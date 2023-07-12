.segment "BANK_04"
; $8000-$9FFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"
.include "charmap.inc"

; -----------------------------------------------------------------------------
.export sub_wait_vblank

sub_wait_vblank:
	lda PpuStatus_2002
	bpl sub_wait_vblank

	; Probably this repeat is to work around the potential issue that happens
	; when the status is read right after the NMI flag was set in the PPU
	:
	lda PpuStatus_2002
	bpl :-

	; TODO Use the global frame counter instead?

	rts

; -----------------------------------------------------------------------------

; Data is using a simple RLE compression
; Parameters:
; Data pointer in zp_ptr1
; Nametable selector (high byte of VRAM pointer) in zp_14
sub_unpack_nametable:
	; Disable rendering
	lda #$00
	sta PpuControl_2000
	sta PpuMask_2001

	ldy #$00
	lda PpuStatus_2002

	lda zp_ptr2_lo
	sta PpuAddr_2006
	inc zp_ptr1_lo
	bne :+
		inc zp_ptr1_hi
	:
	lda #$00
	sta PpuAddr_2006

	@rle_unpack_loop:
	inc zp_ptr1_lo
	bne :+
		inc zp_ptr1_hi
	:
	lda (zp_ptr1_lo),Y
	bpl @rle_repeat_byte

	cmp #$FF	; Stop byte
	beq @rle_unpack_done

	; Values >= $80 are the number of bytes to copy & $80
	and #$7F
	tax	;sta zp_08
	@rle_copy:
		inc zp_ptr1_lo
		bne :+
			inc zp_ptr1_hi
		:
		lda (zp_ptr1_lo),Y
		sta PpuData_2007
	dex	;dec zp_08
	bne @rle_copy

		; Get the next byte when the counter reaches zero
		beq @rle_unpack_loop

	@rle_repeat_byte:
	; Values < $80 are the number of times the next byte must be copied
	tax	;sta zp_08
	inc zp_ptr1_lo
	bne :+
		inc zp_ptr1_hi
	:
	lda (zp_ptr1_lo),Y
	:
		sta PpuData_2007
		dex	;dec zp_08
	bne :-

	beq @rle_unpack_loop

	@rle_unpack_done:
	rts

; -----------------------------------------------------------------------------
.export sub_init_screen_common

; Parameters:
; A = screen index
sub_init_screen_common:
	sta zp_tmp_idx
	jsr sub_setup_new_screen

	; Reset scroll at next NMI
	lda #$00
	sta zp_scroll_x
	sta zp_scroll_y

	; Use bottom table for sprites
	lda #$88
	sta PpuControl_2000
	sta zp_ppu_control_backup

	cli
	jsr sub_wait_vblank
	lda #$1E
	sta zp_ppu_mask_backup

	rts

; -----------------------------------------------------------------------------
.export sub_setup_new_screen

; Clears screen, loads a new palette and new nametable, switches CHR banks,
; sets a new IRQ handler, chooses a music track
; Parameters:
; zp_tmp_idx = index of compressed nametable, palette and IRQ handler pointers
sub_setup_new_screen:
	jsr sub_wait_vblank

	; Disable NMI and rendering, VRAM set increment to horizontal
	lda #$00
	sta PpuControl_2000
	sta PpuMask_2001

	; Change mirroring and IRQ handler
	lda #$0C
	sta ram_routine_pointer_idx
	lda #$01
	sta mmc3_mirroring

	lda #$00
	jsr sub_clear_nametable
	lda #$01
	jsr sub_clear_nametable
	;lda #$02	; Pointless: already cleared because of mirroring
	;jsr sub_clear_nametable

	jsr sub_hide_all_sprites
	jsr sub_load_screen_data

	lda zp_tmp_idx
	asl A
	tay
	lda tbl_palette_and_irq_ptrs+0,Y
	sta ram_routine_pointer_idx
	lda tbl_palette_and_irq_ptrs+1,Y
	sta zp_palette_idx

	jsr sub_clear_palettes
	jsr sub_choose_music_track

	lda #$00
	sta zp_57
	sta zp_palette_fade_idx

	rts

; -----------------------------------------------------------------------------

; Loads an RLE-compressed nametable into the PPU, then switches CHR banks
; Parameters:
; zp_tmp_idx = Index of nametable data to unpack and CHR banks list
sub_load_screen_data:
	; Top or Left
	lda zp_tmp_idx
	asl A
	asl A
	asl A
	tax
	lda tbl_rle_data_ptr_even+0,X
	sta zp_ptr1_lo
	lda tbl_rle_data_ptr_even+1,X
	sta zp_ptr1_hi
	lda tbl_rle_data_ptr_even+2,X
	sta zp_ptr2_lo
	jsr sub_unpack_nametable

	; Bottom or Right
	lda zp_tmp_idx
	asl A
	asl A
	asl A
	tax
	lda tbl_rle_data_ptr_odd+0,X
	sta zp_ptr1_lo
	lda tbl_rle_data_ptr_odd+1,X
	sta zp_ptr1_hi
	lda tbl_rle_data_ptr_odd+2,X
	sta zp_ptr2_lo
	jsr sub_unpack_nametable

	; Reduce music slowdown
	jsr sub_call_sound_routines

	; CHR Banks
	lda zp_tmp_idx
	asl A
	asl A
	asl A
	tax
	lda tbl_chr_banks_per_screen+0,X
	sta zp_chr_bank_0
	lda tbl_chr_banks_per_screen+1,X
	sta zp_chr_bank_1
	lda tbl_chr_banks_per_screen+2,X
	sta zp_chr_bank_2
	lda tbl_chr_banks_per_screen+3,X
	sta zp_chr_bank_3
	lda tbl_chr_banks_per_screen+4,X
	sta zp_chr_bank_4
	lda tbl_chr_banks_per_screen+5,X
	sta zp_chr_bank_5

	rts

; -----------------------------------------------------------------------------

; Writes $0E to all palette entries
sub_clear_palettes:
	ldx #$20
	lda #$3F
	sta PpuAddr_2006
	lda #$00
	sta PpuAddr_2006
	lda #$0E
	:
        sta PpuData_2007
        dex
	bne :-

	rts

; -----------------------------------------------------------------------------
.export sub_ctrl_to_idx

; Turns controller input data to an index offset used for navigating menus
; Returns $FF when input is not valid (e.g. no D-Pad direction pressed)
sub_ctrl_to_idx:
	lda zp_06
	and #$0F	; Mask D-Pad input only
	bne :+
        lda #$FF
        rts
; ----------------
	:
	tax
	lda zp_05
	asl A
	asl A
	clc
	adc @rom_8120,X
	tay
	lda (zp_ptr1_lo),Y
	rts
; ----------------

	@rom_8120:
	.byte $00, $01, $00, $01, $03, $01, $00, $01
	.byte $02, $01, $00, $01, $03, $01, $00, $01

; -----------------------------------------------------------------------------

; Values for CHR bank data register, all banks (registers R0-R5)
; Trailing zeroes are just padding to keep 8-byte alignment for easy indexing
tbl_chr_banks_per_screen:
	.byte $F0, $F2, $F0, $F1, $F2, $F3, $00, $00	; $00	Main menu
	.byte $FC, $FE, $FC, $FD, $FE, $FF, $00, $00	; $01	Options menu
	.byte $FC, $FE, $F8, $F9, $FA, $FB, $00, $00	; $02
	.byte $FC, $FE, $F8, $F9, $FA, $FB, $00, $00	; $03
	.byte $FC, $FE, $FC, $FD, $FE, $FF, $00, $00	; $04
	.byte $FC, $FE, $FC, $FD, $FE, $FF, $00, $00	; $05	(Fake) high scores
	.byte $D8, $DA, $D8, $D9, $DA, $DB, $00, $00	; $06
	.byte $FC, $FE, $F8, $F9, $FA, $FB, $00, $00	; $07
	.byte $BC, $BE, $BC, $BD, $BE, $BF, $00, $00	; $08	Titles screen
	.byte $D8, $DA, $D8, $D9, $DA, $DB, $00, $00	; $09	Sound test

; -----------------------------------------------------------------------------

; Left/Top nametable data pointers (even entries)
; Third byte is VRAM address high byte
; Fourth byte is unused (kept for alignment)
tbl_rle_data_ptr_even:
	.word nam_main_menu_top_rle		; $00
    .byte $20, $20
; ----------------
; Right/Bottom nametable data pointers (odd entries)
; Third byte is VRAM address high byte
; Fourth byte is unused (kept for alignment)
tbl_rle_data_ptr_odd:
	.word nam_main_menu_btm_rle
    .byte $28, $28

    .word nam_option_menu_rle		; $01
    .byte $20, $20
	.word nam_option_menu_2_rle
    .byte $28, $28

    .word rom_player_select_rle		; $02
    .byte $20, $20
	.word rom_vs_screen_2_rle
    .byte $28, $28

    .word rom_901A				; $03
    .byte $20, $20
	.word rom_vs_screen_2_rle
    .byte $28, $28

    .word rom_high_scores_rle	; $04	Fake "top winning streaks"
    .byte $20, $20
	.word rom_high_scores_rle
    .byte $28, $28

    .word rom_9591				; $05
    .byte $20, $20
	.word rom_968C
    .byte $28, $28

    .word rom_8327				; $06
    .byte $20, $20
	.word rom_8390
    .byte $28, $28

    .word rom_9391				; $07
    .byte $20, $20
	.word rom_9491
    .byte $28, $28

    .word nam_titles_rle		; $08
    .byte $20, $20
	.word nam_titles_rle
    .byte $28, $28

	.word nam_sound_test_rle	; $09
	.byte $20, $20
	.word nam_sound_test_rle
	.byte $28, $28

; -----------------------------------------------------------------------------

; Byte 0: index of IRQ handler routine pointer
; Byte 1: index of palette pointer
tbl_palette_and_irq_ptrs:
    .byte $0C, $00	; $00	Main menu
    .byte $0E, $01	; $01	Options menu
    .byte $0C, $02	; $02	Fighter selection
    .byte $0C, $02	; $03	VS Screen?
    .byte $0C, $01	; $04	Fake high scores screen
    .byte $0C, $01	; $05
    .byte $0C, $01	; $06
    .byte $0C, $02	; $07
    .byte $0F, $04	; $08	Titles
	.byte $10, $01	; $09	Sound test

; -----------------------------------------------------------------------------
.export sub_rom_cycle_palettes

; Used for fade-in/out effects
sub_rom_cycle_palettes:
	lda zp_palette_idx
	asl A
	tay
	lda rom_823D+0,Y
	sta zp_ptr1_lo
	lda rom_823D+1,Y
	sta zp_ptr1_hi

	lda zp_57
	asl A
	tay
	lda rom_8239+0,Y
	sta zp_ptr2_lo
	lda rom_8239+1,Y
	sta zp_ptr2_hi

	lda zp_nmi_ppu_ptr_hi
	bne @822F

        lda zp_frame_counter
        and #$03
	    bne @822F

	ldx zp_palette_fade_idx
	lda tbl_palette_fade_subtrahends,X
	sta zp_05

	ldy #$00
	@8201:
		lda (zp_ptr2_lo),Y
		bpl @820A

			lda (zp_ptr1_lo),Y
			jmp @8213

		@820A:
		lda (zp_ptr1_lo),Y
		sec
		sbc zp_05
		bpl @8213

			lda #$FF

		@8213:
		sta ram_0600,Y
		iny
		cpy #$20
	bne @8201

	lda #$3F
	sta zp_nmi_ppu_ptr_hi
	lda #$00
	sta zp_nmi_ppu_ptr_lo
	sta zp_47
	lda #$20
	sta zp_nmi_ppu_cols
	lda #$01
	sta zp_nmi_ppu_rows
	inc zp_palette_fade_idx

	@822F:
	rts

; -----------------------------------------------------------------------------

tbl_palette_fade_subtrahends:
	; Fade in
	.byte $40, $30, $20, $10, $00
	; Fade out
	.byte $10, $20, $30, $40

; -----------------------------------------------------------------------------

rom_8239:
	.word palette_mask_82E7
	.word palette_mask_8307
; ----------------
rom_823D:
	.word palette_8247
	.word palette_8267
	.word palette_8287
	.word palette_82A7
	.word palette_82C7

; -----------------------------------------------------------------------------

palette_8247:
	.byte $0E, $00, $10, $27, $0E, $00, $10, $10
	.byte $0E, $06, $00, $10, $0E, $16, $27, $30
	.byte $0E, $00, $10, $20, $0E, $00, $10, $10
	.byte $0E, $06, $00, $10, $0E, $16, $27, $30

; -----------------------------------------------------------------------------

; Used in option menu
palette_8267:
	.byte $0E, $01, $11, $28, $0E, $00, $10, $26
	.byte $0E, $10, $00, $38, $0E, $00, $10, $20
	.byte $0E, $01, $11, $28, $0E, $00, $10, $26
	.byte $0E, $10, $00, $38, $0E, $00, $10, $20

; -----------------------------------------------------------------------------

palette_8287:
	.byte $FF, $08, $17, $30, $FF, $11, $21, $30
	.byte $FF, $08, $18, $30, $FF, $00, $10, $27
	.byte $0F, $17, $27, $38, $0E, $13, $21, $30
	.byte $0E, $09, $19, $3B, $0E, $06, $16, $36

; -----------------------------------------------------------------------------

palette_82A7:
	.byte $0E, $16, $2A, $38, $0E, $21, $26, $20
	.byte $0E, $21, $26, $20, $0E, $21, $26, $20
	.byte $0E, $16, $2A, $38, $0E, $21, $26, $20
	.byte $0E, $21, $26, $20, $0E, $21, $26, $20

; -----------------------------------------------------------------------------

; Used in titles sequence
palette_82C7:
	.byte $0E, $21, $26, $20, $0E, $21, $26, $20
	.byte $0E, $21, $26, $20, $0E, $20, $00, $10
	.byte $0E, $21, $26, $20, $0E, $21, $26, $20
	.byte $0E, $21, $26, $20, $0E, $16, $27, $20

; -----------------------------------------------------------------------------

palette_mask_82E7:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00

; -----------------------------------------------------------------------------

palette_mask_8307:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $FF, $FF, $FF, $FF
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $FF, $FF, $FF, $FF

; -----------------------------------------------------------------------------

rom_8327:
	.byte $20, $00, $77, $00, $77, $00, $77, $00
	.byte $64, $00, $8F, $34, $35, $36, $37, $38
	.byte $39, $3A, $3B, $3C, $39, $3A, $3D, $35
	.byte $36, $3E, $11, $00, $8F, $3F, $40, $41
	.byte $42, $43, $44, $45, $46, $47, $44, $45
	.byte $48, $40, $41, $49, $77, $00, $77, $00
	.byte $77, $00, $63, $00, $81, $3C, $02, $0C
	.byte $82, $CC, $3C, $02, $0C, $82, $CC, $3C
	.byte $06, $0C, $82, $CC, $F0, $03, $00, $81
	.byte $CC, $02, $3C, $02, $FC, $06, $0C, $86
	.byte $CC, $FC, $00, $F0, $3C, $00, $02, $0C
	.byte $84, $CC, $FC, $00, $0C, $06, $FC, $82
	.byte $00, $C0, $0D, $FC, $81, $00, $FF, $FF
	.byte $FF

; -----------------------------------------------------------------------------

rom_8390:
	.byte $28, $00, $77, $00, $77, $00, $77, $00
	.byte $77, $00, $0A, $00, $86, $17, $15, $1C
	.byte $00, $07, $0C, $02, $09, $8C, $08, $15
	.byte $08, $11, $17, $00, $0F, $08, $19, $08
	.byte $0F, $28, $77, $00, $77, $00, $77, $00
	.byte $61, $00, $81, $3C, $02, $0C, $82, $CC
	.byte $3C, $02, $0C, $82, $CC, $3C, $06, $0C
	.byte $82, $CC, $F0, $03, $00, $81, $CC, $02
	.byte $3C, $02, $FC, $06, $0C, $86, $CC, $FC
	.byte $00, $F0, $3C, $00, $02, $0C, $84, $CC
	.byte $FC, $00, $0C, $06, $FC, $82, $00, $C0
	.byte $0D, $FC, $81, $00, $FF, $FF, $FF

; -----------------------------------------------------------------------------

nam_main_menu_top_rle:
	.byte $20, $00, $41, $00, $81, $01, $0A, $02
	.byte $88, $03, $04, $05, $06, $07, $08, $09
	.byte $0A, $0A, $02, $84, $0B, $00, $00, $0C
	.byte $0A, $00, $88, $0D, $0E, $0F, $10, $11
	.byte $12, $13, $14, $0A, $00, $84, $15, $00
	.byte $00, $0C, $03, $00, $95, $16, $17, $00
	.byte $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
	.byte $20, $21, $22, $23, $24, $25, $26, $27
	.byte $28, $29, $04, $00, $84, $15, $00, $00
	.byte $0C, $03, $00, $94, $2D, $2E, $2F, $30
	.byte $31, $32, $33, $34, $35, $36, $37, $38
	.byte $39, $3A, $3B, $3C, $3D, $3E, $3F, $40
	.byte $05, $00, $9B, $15, $2B, $2C, $44, $2A
	.byte $2A, $00, $45, $46, $47, $48, $49, $4A
	.byte $4B, $4C, $4D, $4E, $4F, $50, $51, $52
	.byte $00, $53, $54, $55, $56, $57, $03, $00
	.byte $02, $2A, $9B, $58, $42, $5C, $5D, $41
	.byte $41, $00, $5E, $5F, $60, $61, $62, $63
	.byte $64, $65, $66, $67, $68, $69, $6A, $6B
	.byte $6C, $6D, $6E, $6F, $70, $71, $03, $00
	.byte $02, $41, $E4, $72, $5A, $5B, $5D, $59
	.byte $59, $00, $74, $75, $76, $77, $78, $79
	.byte $7A, $7B, $7C, $7D, $7E, $7F, $80, $81
	.byte $82, $83, $84, $85, $86, $87, $88, $89
	.byte $8A, $59, $59, $8B, $73, $8D, $8E, $73
	.byte $73, $00, $8F, $90, $91, $92, $93, $94
	.byte $95, $96, $97, $98, $99, $9A, $9B, $9C
	.byte $9D, $9E, $9F, $A0, $A1, $A2, $A3, $A4
	.byte $A5, $73, $73, $A6, $8C, $A7, $5D, $8D
	.byte $8D, $00, $16, $A8, $A9, $AA, $1A, $1B
	.byte $1C, $AB, $17, $00, $18, $AC, $AD, $AE
	.byte $AF, $B0, $24, $25, $B1, $B2, $B3, $B4
	.byte $B5, $8D, $8D, $A6, $8D, $B7, $B8, $02
	.byte $B6, $D6, $00, $2D, $B9, $BA, $BB, $32
	.byte $33, $34, $BC, $2E, $2F, $30, $BD, $BE
	.byte $BF, $C0, $C1, $3C, $3D, $C2, $C3, $C4
	.byte $C5, $C6, $B6, $B6, $72, $B6, $C8, $0C
	.byte $D4, $D4, $00, $45, $C9, $CA, $CB, $4A
	.byte $4B, $4C, $CC, $46, $47, $48, $CD, $CE
	.byte $CF, $D0, $D1, $53, $54, $55, $D2, $D3
	.byte $00, $C8, $D4, $D4, $D5, $B7, $00, $0C
	.byte $C8, $C8, $00, $5E, $D6, $D7, $D8, $63
	.byte $64, $65, $D9, $5F, $60, $61, $CD, $DA
	.byte $DB, $DC, $DD, $6D, $6E, $6F, $70, $DE
	.byte $02, $00, $02, $C8, $9C, $58, $C8, $2C
	.byte $DF, $E9, $E9, $00, $74, $E0, $E1, $E2
	.byte $79, $7A, $7B, $E3, $75, $76, $77, $CD
	.byte $E4, $E5, $E6, $E7, $83, $84, $85, $86
	.byte $E8, $02, $00, $02, $E9, $A4, $15, $00
	.byte $5C, $5D, $F6, $F6, $00, $8F, $EA, $EB
	.byte $EC, $94, $95, $96, $ED, $90, $91, $92
	.byte $EE, $EF, $F0, $F1, $F2, $9E, $9F, $A0
	.byte $A1, $F3, $F4, $F5, $F6, $F6, $F7, $41
	.byte $5B, $8E, $15, $F8, $07, $5B, $83, $8B
	.byte $59, $8C, $1E, $F9, $7F, $8C, $7F, $8C
	.byte $7F, $8C, $04, $8C, $03, $AA, $02, $0A
	.byte $04, $AA, $06, $FF, $02, $AA, $06, $FF
	.byte $02, $AA, $06, $FF, $21, $AA, $FF, $BB
	.byte $EE, $05, $FF, $83, $EE, $BB, $EE, $05
	.byte $FF, $82, $EE, $BB, $18, $AA, $08, $FA
	.byte $81, $0A, $FF, $FF, $FF

; -----------------------------------------------------------------------------

; This is the bottom half the of the main menu, repeated twice vertically
; The bottom copy has the "options" menu item selected
nam_main_menu_btm_rle:
	.byte $28, $00, $07, $BE, $02, $8C, $17, $BE
	.byte $20, $8C, $04, $BE, $98, $01, $02, $03
	.byte $04, $05, $06, $07, $08, $09, $0A, $0B
	.byte $0C, $0D, $0E, $0F, $10, $11, $12, $13
	.byte $14, $15, $16, $17, $18, $08, $BE, $98
	.byte $19, $1A, $1B, $1C, $1D, $1E, $1F, $20
	.byte $21, $22, $23, $24, $25, $26, $27, $28
	.byte $29, $2A, $2B, $2C, $2D, $2E, $2F, $30
	.byte $08, $BE, $98, $31, $32, $33, $34, $35
	.byte $36, $37, $38, $39, $3A, $3B, $3C, $3D
	.byte $3E, $3F, $40, $41, $42, $43, $44, $45
	.byte $46, $47, $48, $08, $BE, $98, $49, $4A
	.byte $4B, $4C, $4D, $4E, $4F, $50, $51, $52
	.byte $53, $54, $4A, $4B, $4C, $4D, $4E, $4F
	.byte $50, $51, $52, $53, $54, $55, $08, $BE
	.byte $98, $56, $57, $58, $59, $5A, $5B, $5C
	.byte $5D, $5E, $5F, $60, $61, $57, $58, $59
	.byte $5A, $5B, $5C, $5D, $5E, $5F, $60, $61
	.byte $62, $08, $BE, $98, $63, $64, $65, $66
	.byte $67, $68, $69, $6A, $6B, $6C, $6D, $6E
	.byte $64, $65, $66, $67, $68, $69, $6A, $6B
	.byte $6C, $6D, $6E, $6F, $08, $BE, $98, $70
	.byte $71, $72, $C0, $74, $75, $76, $77, $78
	.byte $79, $7A, $7B, $71, $72, $C0, $74, $75
	.byte $76, $77, $78, $79, $7A, $7B, $7C, $08
	.byte $BE, $98, $7D, $7E, $7F, $80, $81, $82
	.byte $83, $84, $85, $86, $87, $88, $7E, $7F
	.byte $80, $81, $82, $83, $84, $85, $86, $87
	.byte $88, $89, $08, $BE, $98, $8A, $8B, $C1
	.byte $8D, $8E, $8F, $90, $91, $92, $93, $94
	.byte $95, $8B, $C1, $8D, $8E, $8F, $90, $91
	.byte $92, $93, $94, $95, $96, $08, $BE, $98
	.byte $97, $98, $99, $9A, $9B, $9C, $9D, $9E
	.byte $9F, $A0, $A1, $A2, $98, $99, $9A, $9B
	.byte $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3
	.byte $08, $BE, $98, $A4, $A5, $A6, $A7, $A8
	.byte $A9, $AA, $AB, $AC, $AD, $AE, $AF, $A5
	.byte $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD
	.byte $AE, $AF, $B0, $08, $BE, $98, $B1, $B2
	.byte $B3, $B4, $B5, $B6, $B7, $B8, $B9, $BA
	.byte $BB, $BC, $B2, $B3, $B4, $B5, $B6, $B7
	.byte $B8, $B9, $BA, $BB, $BC, $BD, $64, $BE
	.byte $20, $8C, $04, $BE, $98, $01, $02, $03
	.byte $04, $05, $06, $07, $08, $09, $0A, $0B
	.byte $0C, $0D, $0E, $0F, $10, $11, $12, $13
	.byte $14, $15, $16, $17, $18, $08, $BE, $98
	.byte $19, $1A, $1B, $1C, $1D, $1E, $1F, $20
	.byte $21, $22, $23, $24, $25, $26, $27, $28
	.byte $29, $2A, $2B, $2C, $2D, $2E, $2F, $30
	.byte $08, $BE, $98, $31, $32, $33, $34, $35
	.byte $36, $37, $38, $39, $3A, $3B, $3C, $3D
	.byte $3E, $3F, $40, $41, $42, $43, $44, $45
	.byte $46, $47, $48, $08, $BE, $98, $49, $4A
	.byte $4B, $4C, $4D, $4E, $4F, $50, $51, $52
	.byte $53, $54, $4A, $4B, $4C, $4D, $4E, $4F
	.byte $50, $51, $52, $53, $54, $55, $08, $BE
	.byte $98, $56, $57, $58, $59, $5A, $5B, $5C
	.byte $5D, $5E, $5F, $60, $61, $57, $58, $59
	.byte $5A, $5B, $5C, $5D, $5E, $5F, $60, $61
	.byte $62, $08, $BE, $98, $63, $64, $65, $66
	.byte $67, $68, $69, $6A, $6B, $6C, $6D, $6E
	.byte $64, $65, $66, $67, $68, $69, $6A, $6B
	.byte $6C, $6D, $6E, $6F, $08, $BE, $98, $70
	.byte $71, $72, $C0, $74, $75, $76, $77, $78
	.byte $79, $7A, $7B, $71, $72, $C0, $74, $75
	.byte $76, $77, $78, $79, $7A, $7B, $7C, $08
	.byte $BE, $98, $7D, $7E, $7F, $80, $81, $82
	.byte $83, $84, $85, $86, $87, $88, $7E, $7F
	.byte $80, $81, $82, $83, $84, $85, $86, $87
	.byte $88, $89, $08, $BE, $98, $8A, $8B, $C1
	.byte $8D, $8E, $8F, $90, $91, $92, $93, $94
	.byte $95, $8B, $C1, $8D, $8E, $8F, $90, $91
	.byte $92, $93, $94, $95, $96, $08, $BE, $98
	.byte $97, $98, $99, $9A, $9B, $9C, $9D, $9E
	.byte $9F, $A0, $A1, $A2, $98, $99, $9A, $9B
	.byte $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3
	.byte $08, $BE, $98, $A4, $A5, $A6, $A7, $A8
	.byte $A9, $AA, $AB, $AC, $AD, $AE, $AF, $A5
	.byte $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD
	.byte $AE, $AF, $B0, $08, $BE, $98, $B1, $B2
	.byte $B3, $B4, $B5, $B6, $B7, $B8, $B9, $BA
	.byte $BB, $BC, $B2, $B3, $B4, $B5, $B6, $B7
	.byte $B8, $B9, $BA, $BB, $BC, $BD, $04, $BE
	.byte $81, $AA, $03, $0A, $03, $5A, $02, $AA
	.byte $83, $10, $00, $40, $03, $55, $02, $AA
	.byte $83, $51, $00, $54, $03, $55, $02, $AA
	.byte $06, $A5, $02, $AA, $03, $5A, $83, $1A
	.byte $0A, $4A, $02, $AA, $86, $44, $55, $15
	.byte $11, $00, $54, $02, $AA, $88, $04, $55
	.byte $01, $51, $00, $55, $AA, $FA, $03, $F0
	; Fixed glitchy attributes
	.byte $03, $F5, $81, $FA, $FF, $FF, $FF

; -----------------------------------------------------------------------------

nam_option_menu_rle:
	.byte $20, $00, $4C, $42, $88, $02, $46, $07
	.byte $09, $02, $03, $06, $00, $18, $42, $88
	.byte $0F, $47, $14, $16, $0F, $10, $13, $00
	.byte $0E, $42, $81, $1B, $1A, $1C, $81, $1D
	.byte $04, $42, $81, $1E, $1A, $42, $81, $1E
	.byte $04, $42, $82, $1E, $42, $03, $00, $83
	.byte $00, $50, $09, $02, $21, $86, $09, $3A
	.byte $0D, $01, $07, $3C, $01, $00, $85, $01
	.byte $05, $52, $05, $01, $04, $00, $82, $42
	.byte $1E, $04, $42, $82, $1E, $42, $03, $00
	.byte $83, $00, $51, $16, $02, $2A, $86, $16
	.byte $3B, $1A, $0E, $14, $3D, $01, $00, $85
	.byte $0E, $12, $53, $12, $0E, $04, $00, $82
	.byte $42, $1E, $04, $42, $81, $1E, $1A, $42
	.byte $81, $1E, $04, $42, $81, $40, $1A, $1C
	.byte $81, $41, $0A, $42, $81, $1B, $0E, $1C
	.byte $81, $1D, $10, $42, $81, $1E, $0E, $42
	.byte $81, $1E, $08, $42, $81, $1B, $06, $1C
	.byte $83, $1D, $1E, $42, $02, $00, $8D, $52
	.byte $05, $0A, $3C, $00, $05, $0B, $06, $3C
	.byte $00, $42, $1E, $1B, $06, $1C, $88, $1D
	.byte $1E, $60, $61, $62, $63, $64, $65, $02
	.byte $1E, $81, $42, $02, $00, $8B, $53, $12
	.byte $17, $3D, $00, $12, $18, $13, $3D, $00
	.byte $42, $02, $1E, $86, $60, $61, $62, $63
	.byte $64, $65, $02, $1E, $86, $67, $68, $69
	.byte $6A, $6B, $6C, $02, $1E, $81, $42, $02
	.byte $00, $84, $05, $0B, $06, $3C, $06, $00
	.byte $81, $42, $02, $1E, $86, $67, $68, $69
	.byte $6A, $6B, $6C, $02, $1E, $86, $6D, $6E
	.byte $6F, $70, $71, $72, $02, $1E, $81, $42
	.byte $02, $00, $84, $12, $18, $13, $3D, $06
	.byte $00, $81, $42, $02, $1E, $86, $6D, $6E
	.byte $6F, $70, $71, $72, $02, $1E, $86, $74
	.byte $75, $76, $77, $78, $79, $02, $1E, $81
	.byte $42, $02, $00, $86, $20, $05, $50, $09
	.byte $0D, $20, $04, $00, $81, $42, $02, $1E
	.byte $86, $74, $75, $76, $77, $78, $79, $02
	.byte $1E, $86, $7B, $7C, $7D, $7E, $7F, $80
	.byte $02, $1E, $81, $42, $02, $00, $86, $29
	.byte $12, $51, $16, $1A, $29, $04, $00, $81
	.byte $42, $02, $1E, $86, $7B, $7C, $7D, $7E
	.byte $7F, $80, $02, $1E, $86, $82, $83, $84
	.byte $85, $86, $87, $02, $1E, $81, $42, $02
	.byte $00, $84, $3E, $0B, $0A, $50, $06, $00
	.byte $81, $42, $02, $1E, $86, $82, $83, $84
	.byte $85, $86, $87, $02, $1E, $86, $88, $89
	.byte $8A, $8B, $8C, $8D, $02, $1E, $81, $42
	.byte $02, $00, $84, $3F, $18, $17, $51, $06
	.byte $00, $81, $42, $02, $1E, $86, $88, $89
	.byte $8A, $8B, $8C, $8D, $02, $1E, $86, $8E
	.byte $8F, $90, $91, $92, $93, $02, $1E, $81
	.byte $42, $02, $00, $8B, $52, $05, $0A, $3C
	.byte $00, $3E, $0B, $0A, $50, $00, $42, $02
	.byte $1E, $88, $8E, $8F, $90, $91, $92, $93
	.byte $1E, $40, $06, $1C, $83, $41, $1E, $42
	.byte $02, $00, $8D, $53, $12, $17, $3D, $00
	.byte $3F, $18, $17, $51, $00, $42, $1E, $40
	.byte $06, $1C, $81, $41, $08, $42, $82, $1E
	.byte $42, $0C, $00, $82, $42, $1E, $10, $42
	.byte $82, $1E, $42, $0C, $00, $82, $42, $1E
	.byte $10, $42, $82, $1E, $42, $04, $00, $84
	.byte $05, $55, $09, $07, $04, $00, $82, $42
	.byte $1E, $10, $42, $82, $1E, $42, $04, $00
	.byte $84, $12, $56, $16, $14, $04, $00, $82
	.byte $42, $1E, $10, $42, $81, $1E, $0E, $42
	.byte $81, $1E, $10, $42, $81, $40, $0E, $1C
	.byte $81, $41, $48, $42, $03, $FF, $02, $AF
	.byte $03, $FF, $81, $BB, $06, $FA, $83, $EE
	.byte $FB, $FA, $04, $AA, $82, $FA, $FE, $02
	.byte $55, $81, $E6, $02, $FF, $81, $BB, $04
	.byte $55, $81, $66, $02, $FF, $81, $BB, $02
	.byte $55, $02, $F5, $81, $E6, $02, $FF, $81
	.byte $BB, $02, $F5, $02, $FF, $84, $AE, $AD
	.byte $AF, $AB, $0A, $FF, $FF, $FF, $FF, $FF
	.byte $FF

; -----------------------------------------------------------------------------

; This is basically the same as the previous nametable, but with different
; attributes to highlight the options
nam_option_menu_2_rle:
	.byte $20, $00, $4C, $42, $88, $02, $46, $07
	.byte $09, $02, $03, $06, $00, $18, $42, $88
	.byte $0F, $47, $14, $16, $0F, $10, $13, $00
	.byte $0E, $42, $81, $1B, $1A, $1C, $81, $1D
	.byte $04, $42, $81, $1E, $1A, $42, $81, $1E
	.byte $04, $42, $82, $1E, $42, $03, $00, $83
	.byte $50, $09, $52, $02, $21, $86, $09, $3A
	.byte $0D, $01, $07, $3C, $02, $00, $85, $01
	.byte $05, $52, $05, $01, $03, $00, $82, $42
	.byte $1E, $04, $42, $82, $1E, $42, $03, $00
	.byte $83, $51, $16, $53, $02, $2A, $86, $16
	.byte $3B, $1A, $0E, $14, $3D, $02, $00, $85
	.byte $0E, $12, $53, $12, $0E, $03, $00, $82
	.byte $42, $1E, $04, $42, $81, $1E, $1A, $42
	.byte $81, $1E, $04, $42, $81, $40, $1A, $1C
	.byte $81, $41, $0A, $42, $81, $1B, $0E, $1C
	.byte $81, $1D, $10, $42, $81, $1E, $0E, $42
	.byte $81, $1E, $08, $42, $81, $1B, $06, $1C
	.byte $83, $1D, $1E, $42, $02, $00, $8D, $52
	.byte $05, $0A, $3C, $00, $05, $0B, $06, $3C
	.byte $00, $42, $1E, $1B, $06, $1C, $88, $1D
	.byte $1E, $60, $61, $62, $63, $64, $65, $02
	.byte $1E, $81, $42, $02, $00, $8B, $53, $12
	.byte $17, $3D, $00, $12, $18, $13, $3D, $00
	.byte $42, $02, $1E, $86, $60, $61, $62, $63
	.byte $64, $65, $02, $1E, $86, $67, $68, $69
	.byte $6A, $6B, $6C, $02, $1E, $81, $42, $02
	.byte $00, $84, $05, $0B, $06, $3C, $06, $00
	.byte $81, $42, $02, $1E, $86, $67, $68, $69
	.byte $6A, $6B, $6C, $02, $1E, $86, $6D, $6E
	.byte $6F, $70, $71, $72, $02, $1E, $81, $42
	.byte $02, $00, $84, $12, $18, $13, $3D, $06
	.byte $00, $81, $42, $02, $1E, $86, $6D, $6E
	.byte $6F, $70, $71, $72, $02, $1E, $86, $74
	.byte $75, $76, $77, $78, $79, $02, $1E, $81
	.byte $42, $02, $00, $86, $20, $05, $50, $09
	.byte $0D, $20, $04, $00, $81, $42, $02, $1E
	.byte $86, $74, $75, $76, $77, $78, $79, $02
	.byte $1E, $86, $7B, $7C, $7D, $7E, $7F, $80
	.byte $02, $1E, $81, $42, $02, $00, $86, $29
	.byte $12, $51, $16, $1A, $29, $04, $00, $81
	.byte $42, $02, $1E, $86, $7B, $7C, $7D, $7E
	.byte $7F, $80, $02, $1E, $86, $82, $83, $84
	.byte $85, $86, $87, $02, $1E, $81, $42, $02
	.byte $00, $84, $3E, $0B, $0A, $50, $06, $00
	.byte $81, $42, $02, $1E, $86, $82, $83, $84
	.byte $85, $86, $87, $02, $1E, $86, $88, $89
	.byte $8A, $8B, $8C, $8D, $02, $1E, $81, $42
	.byte $02, $00, $84, $3F, $18, $17, $51, $06
	.byte $00, $81, $42, $02, $1E, $86, $88, $89
	.byte $8A, $8B, $8C, $8D, $02, $1E, $86, $8E
	.byte $8F, $90, $91, $92, $93, $02, $1E, $81
	.byte $42, $02, $00, $8B, $52, $05, $0A, $3C
	.byte $00, $3E, $0B, $0A, $50, $00, $42, $02
	.byte $1E, $88, $8E, $8F, $90, $91, $92, $93
	.byte $1E, $40, $06, $1C, $83, $41, $1E, $42
	.byte $02, $00, $8D, $53, $12, $17, $3D, $00
	.byte $3F, $18, $17, $51, $00, $42, $1E, $40
	.byte $06, $1C, $81, $41, $08, $42, $82, $1E
	.byte $42, $0C, $00, $82, $42, $1E, $10, $42
	.byte $82, $1E, $42, $0C, $00, $82, $42, $1E
	.byte $10, $42, $82, $1E, $42, $04, $00, $84
	.byte $05, $55, $09, $07, $04, $00, $82, $42
	.byte $1E, $10, $42, $82, $1E, $42, $04, $00
	.byte $84, $12, $56, $16, $14, $04, $00, $82
	.byte $42, $1E, $10, $42, $81, $1E, $0E, $42
	.byte $81, $1E, $10, $42, $81, $40, $0E, $1C
	.byte $81, $41, $48, $42, $03, $FF, $02, $AF
	.byte $03, $FF, $81, $BB, $06, $FA, $83, $EE
	.byte $FB, $FA, $04, $AA, $82, $FA, $FE, $02
	.byte $55, $84, $E6, $55, $F5, $B9, $04, $55
	.byte $84, $66, $55, $FD, $BB, $02, $55, $02
	.byte $F5, $81, $E6, $02, $F5, $81, $B9, $02
	.byte $F5, $02, $FF, $84, $AE, $AD, $AF, $AB
	.byte $0A, $FF, $FF, $FF, $FF, $FF, $FF

; -----------------------------------------------------------------------------

rom_player_select_rle:
	.byte $20, $00, $46, $FC, $82, $E0, $E1, $02
	.byte $E2, $8F, $E3, $E4, $FC, $E5, $E2, $E6
	.byte $E7, $FC, $E8, $E9, $E0, $E1, $EA, $E4
	.byte $E7, $0D, $FC, $82, $F0, $F1, $02, $F2
	.byte $8F, $F3, $F4, $FC, $F5, $F2, $F6, $F7
	.byte $FC, $F8, $F9, $F0, $F1, $FA, $F4, $F7
	.byte $0C, $FC, $81, $EB, $14, $EC, $81, $ED
	.byte $0A, $FC, $83, $FB, $FC, $EB, $04, $EC
	.byte $81, $ED, $06, $FC, $81, $EB, $04, $EC
	.byte $83, $ED, $FC, $FB, $0A, $FC, $88, $FB
	.byte $FC, $FB, $C0, $C1, $C2, $C3, $FB, $06
	.byte $FC, $88, $FB, $6C, $6D, $6E, $6F, $FB
	.byte $FC, $FB, $0A, $FC, $88, $FB, $FC, $FB
	.byte $D0, $D1, $D2, $D3, $FB, $06, $FC, $88
	.byte $FB, $7C, $7D, $7E, $7F, $FB, $FC, $FB
	.byte $0A, $FC, $88, $FB, $FC, $FB, $C4, $C5
	.byte $C6, $C7, $FB, $06, $FC, $88, $FB, $8C
	.byte $8D, $8E, $8F, $FB, $FC, $FB, $07, $FC
	.byte $81, $EB, $02, $EC, $88, $EF, $FC, $FB
	.byte $D4, $D5, $D6, $D7, $FB, $06, $FC, $88
	.byte $FB, $9C, $9D, $9E, $9F, $FB, $FC, $EE
	.byte $02, $EC, $81, $ED, $04, $FC, $81, $FB
	.byte $04, $FC, $86, $FB, $C8, $C9, $CA, $CB
	.byte $FB, $06, $FC, $86, $FB, $AC, $AD, $AE
	.byte $AF, $FB, $04, $FC, $81, $FB, $04, $FC
	.byte $81, $FB, $04, $FC, $86, $FB, $D8, $D9
	.byte $DA, $DB, $FB, $06, $FC, $86, $FB, $BC
	.byte $BD, $BE, $BF, $FB, $04, $FC, $81, $FB
	.byte $04, $FC, $81, $FB, $04, $FC, $81, $EE
	.byte $04, $EC, $81, $EF, $06, $FC, $81, $EE
	.byte $04, $EC, $81, $EF, $04, $FC, $81, $FB
	.byte $04, $FC, $81, $FB, $1A, $FC, $81, $FB
	.byte $04, $FC, $86, $FB, $FC, $08, $09, $0A
	.byte $0B, $02, $FC, $84, $64, $65, $66, $67
	.byte $04, $FC, $84, $00, $01, $02, $03, $02
	.byte $FC, $86, $68, $69, $6A, $6B, $FC, $FB
	.byte $04, $FC, $86, $FB, $FC, $18, $19, $1A
	.byte $1B, $02, $FC, $84, $74, $75, $76, $77
	.byte $04, $FC, $84, $10, $11, $12, $13, $02
	.byte $FC, $86, $78, $79, $7A, $7B, $FC, $FB
	.byte $04, $FC, $86, $FB, $FC, $28, $29, $2A
	.byte $2B, $02, $FC, $84, $84, $85, $86, $87
	.byte $04, $FC, $84, $20, $21, $22, $23, $02
	.byte $FC, $86, $88, $89, $8A, $8B, $FC, $FB
	.byte $04, $FC, $86, $FB, $FC, $38, $39, $3A
	.byte $3B, $02, $FC, $84, $94, $95, $96, $97
	.byte $04, $FC, $84, $30, $31, $32, $33, $02
	.byte $FC, $86, $98, $99, $9A, $9B, $FC, $FB
	.byte $04, $FC, $86, $FB, $FC, $48, $49, $4A
	.byte $4B, $02, $FC, $84, $A4, $A5, $A6, $A7
	.byte $04, $FC, $84, $40, $15, $42, $43, $02
	.byte $FC, $86, $A8, $A9, $AA, $AB, $FC, $FB
	.byte $04, $FC, $86, $FB, $FC, $58, $59, $5A
	.byte $5B, $02, $FC, $84, $B4, $B5, $B6, $B7
	.byte $04, $FC, $84, $50, $51, $52, $53, $02
	.byte $FC, $86, $B8, $B9, $BA, $BB, $FC, $FB
	.byte $04, $FC, $81, $FB, $05, $FC, $84, $60
	.byte $61, $62, $63, $02, $FC, $84, $04, $05
	.byte $06, $07, $02, $FC, $84, $0C, $0D, $0E
	.byte $0F, $05, $FC, $81, $FB, $04, $FC, $81
	.byte $FB, $05, $FC, $84, $70, $71, $72, $73
	.byte $02, $FC, $84, $14, $15, $16, $17, $02
	.byte $FC, $84, $1C, $1D, $1E, $1F, $05, $FC
	.byte $81, $FB, $04, $FC, $81, $EE, $02, $EC
	.byte $81, $ED, $02, $FC, $84, $80, $81, $82
	.byte $83, $02, $FC, $84, $24, $25, $26, $27
	.byte $02, $FC, $84, $2C, $2D, $2E, $2F, $02
	.byte $FC, $81, $EB, $02, $EC, $81, $EF, $07
	.byte $FC, $81, $FB, $02, $FC, $84, $90, $91
	.byte $92, $93, $02, $FC, $84, $34, $35, $36
	.byte $37, $02, $FC, $84, $3C, $3D, $3E, $3F
	.byte $02, $FC, $81, $FB, $0A, $FC, $81, $FB
	.byte $02, $FC, $84, $A0, $A1, $A2, $A3, $02
	.byte $FC, $84, $44, $45, $46, $47, $02, $FC
	.byte $84, $4C, $4D, $4E, $4F, $02, $FC, $81
	.byte $FB, $0A, $FC, $81, $FB, $02, $FC, $84
	.byte $B0, $B1, $B2, $B3, $02, $FC, $84, $54
	.byte $55, $56, $57, $02, $FC, $84, $5C, $5D
	.byte $5E, $5F, $02, $FC, $81, $FB, $0A, $FC
	.byte $81, $FB, $14, $FC, $81, $FB, $0A, $FC
	.byte $81, $EE, $14, $EC, $81, $EF, $45, $FC
	.byte $0A, $FF, $81, $5F, $02, $FF, $81, $0F
	.byte $04, $FF, $81, $55, $02, $FF, $81, $00
	.byte $03, $FF, $86, $0F, $7F, $DF, $7F, $DF
	.byte $AF, $02, $FF, $86, $00, $77, $DD, $77
	.byte $DD, $AA, $03, $FF, $84, $55, $33, $CC
	.byte $AA, $04, $FF, $84, $F5, $F3, $FC, $FA
	.byte $0A, $FF, $FF

; -----------------------------------------------------------------------------

rom_901A:
	.byte $20, $00, $46, $00, $82, $01, $02, $02
	.byte $03, $8F, $04, $05, $00, $06, $03, $07
	.byte $08, $00, $09, $0A, $01, $02, $0B, $05
	.byte $08, $0D, $00, $82, $0C, $0D, $02, $0E
	.byte $8F, $0F, $10, $00, $11, $0E, $12, $13
	.byte $00, $14, $15, $0C, $0D, $16, $10, $13
	.byte $2C, $00, $81, $17, $14, $18, $81, $19
	.byte $0A, $00, $89, $1A, $1B, $1C, $1D, $1E
	.byte $B9, $BA, $BB, $BC, $04, $00, $89, $5E
	.byte $5F, $60, $61, $1F, $20, $21, $22, $1A
	.byte $0A, $00, $89, $1A, $23, $24, $25, $26
	.byte $C5, $C6, $C7, $C8, $04, $00, $89, $6E
	.byte $6F, $70, $71, $29, $2A, $2B, $2C, $1A
	.byte $0A, $00, $89, $1A, $2D, $2E, $2F, $30
	.byte $D0, $D1, $D2, $D3, $04, $00, $89, $7E
	.byte $7F, $80, $81, $35, $36, $37, $38, $1A
	.byte $0A, $00, $89, $1A, $3A, $3B, $3C, $3D
	.byte $DC, $DD, $DE, $DF, $04, $00, $89, $8E
	.byte $8F, $90, $91, $42, $43, $44, $45, $1A
	.byte $0A, $00, $89, $1A, $47, $48, $49, $4A
	.byte $E7, $E8, $E9, $EA, $04, $00, $89, $9E
	.byte $9F, $A0, $A1, $4D, $4E, $4F, $50, $1A
	.byte $06, $00, $81, $17, $03, $18, $89, $39
	.byte $51, $52, $53, $54, $F2, $F3, $F4, $F5
	.byte $04, $00, $89, $AD, $AE, $AF, $B0, $56
	.byte $57, $58, $59, $46, $03, $18, $81, $19
	.byte $02, $00, $9E, $1A, $B9, $BA, $BB, $BC
	.byte $5A, $5B, $5C, $5D, $5E, $5F, $60, $61
	.byte $62, $63, $64, $65, $66, $67, $68, $69
	.byte $C1, $C2, $C3, $C4, $BD, $BE, $BF, $C0
	.byte $1A, $02, $00, $9E, $1A, $C5, $C6, $C7
	.byte $C8, $6A, $6B, $6C, $6D, $6E, $6F, $70
	.byte $71, $72, $73, $74, $75, $76, $77, $78
	.byte $79, $CC, $CD, $CE, $CF, $C9, $C1, $CA
	.byte $CB, $1A, $02, $00, $9E, $1A, $D0, $D1
	.byte $D2, $D3, $7A, $7B, $7C, $7D, $7E, $7F
	.byte $80, $81, $82, $83, $84, $85, $86, $87
	.byte $88, $89, $D8, $D9, $DA, $DB, $D4, $D5
	.byte $D6, $D7, $1A, $02, $00, $9E, $1A, $DC
	.byte $DD, $DE, $DF, $8A, $8B, $8C, $8D, $8E
	.byte $8F, $90, $91, $92, $93, $94, $95, $96
	.byte $97, $98, $99, $DF, $E4, $E5, $E6, $E0
	.byte $E1, $E2, $E3, $1A, $02, $00, $9E, $1A
	.byte $E7, $E8, $E9, $EA, $9A, $9B, $9C, $9D
	.byte $9E, $9F, $A0, $A1, $A2, $C1, $A4, $A5
	.byte $C1, $A6, $A7, $A8, $EE, $EF, $F0, $F1
	.byte $A3, $EB, $EC, $ED, $1A, $02, $00, $9E
	.byte $1A, $F2, $F3, $F4, $F5, $A9, $AA, $AB
	.byte $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3
	.byte $B4, $B5, $B6, $B7, $B8, $FA, $FB, $FC
	.byte $FD, $F6, $F7, $F8, $F9, $1A, $02, $00
	.byte $9E, $1A, $66, $67, $68, $69, $BD, $BE
	.byte $BF, $C0, $C1, $C2, $C3, $C4, $1B, $1C
	.byte $1D, $1E, $5A, $5B, $5C, $5D, $1F, $20
	.byte $21, $22, $62, $63, $64, $65, $1A, $02
	.byte $00, $9E, $1A, $76, $77, $78, $79, $C9
	.byte $C1, $CA, $CB, $CC, $CD, $CE, $CF, $23
	.byte $24, $25, $26, $6A, $6B, $6C, $6D, $29
	.byte $2A, $2B, $2C, $72, $73, $74, $75, $1A
	.byte $02, $00, $9E, $1A, $86, $87, $88, $89
	.byte $D4, $D5, $D6, $D7, $D8, $D9, $DA, $DB
	.byte $2D, $2E, $2F, $30, $7A, $7B, $7C, $7D
	.byte $35, $36, $37, $38, $82, $83, $84, $85
	.byte $1A, $02, $00, $9E, $1A, $96, $97, $98
	.byte $99, $E0, $E1, $E2, $E3, $DF, $E4, $E5
	.byte $E6, $3A, $3B, $3C, $3D, $8A, $8B, $8C
	.byte $8D, $42, $43, $44, $45, $92, $93, $94
	.byte $95, $1A, $02, $00, $9E, $1A, $C1, $A6
	.byte $A7, $A8, $A3, $EB, $EC, $ED, $EE, $EF
	.byte $F0, $F1, $47, $48, $49, $4A, $9A, $9B
	.byte $9C, $9D, $4D, $4E, $4F, $50, $A2, $C1
	.byte $A4, $A5, $1A, $02, $00, $9E, $1A, $B5
	.byte $B6, $B7, $B8, $F6, $F7, $F8, $F9, $FA
	.byte $FB, $FC, $FD, $51, $52, $53, $54, $A9
	.byte $AA, $AB, $AC, $56, $57, $58, $59, $B1
	.byte $B2, $B3, $B4, $1A, $02, $00, $81, $46
	.byte $1C, $18, $81, $39, $77, $00, $2A, $00
	.byte $09, $FF, $86, $7F, $1F, $CF, $BF, $2F
	.byte $CF, $02, $FF, $9F, $77, $11, $CC, $BB
	.byte $22, $CC, $FF, $77, $11, $44, $55, $11
	.byte $88, $22, $CC, $B7, $A1, $24, $05, $41
	.byte $58, $92, $EC, $BB, $AA, $22, $00, $44
	.byte $55, $99, $EE, $10, $FF, $FF

; -----------------------------------------------------------------------------

rom_vs_screen_2_rle:
	.byte $20, $00, $77, $15, $77, $15, $37, $15
	.byte $81, $EB, $04, $EC, $81, $ED, $0A, $15
	.byte $81, $EB, $04, $EC, $81, $ED, $0A, $15
	.byte $81, $FB, $04, $15, $81, $FB, $0A, $15
	.byte $81, $FB, $04, $15, $81, $FB, $0A, $15
	.byte $81, $FB, $04, $15, $81, $FB, $03, $15
	.byte $83, $CC, $CD, $CE, $04, $15, $81, $FB
	.byte $04, $15, $81, $FB, $0A, $15, $81, $FB
	.byte $04, $15, $81, $FB, $03, $15, $84, $DC
	.byte $DD, $DE, $DF, $03, $15, $81, $FB, $04
	.byte $15, $81, $FB, $0A, $15, $81, $FB, $04
	.byte $15, $81, $FB, $04, $15, $83, $41, $CF
	.byte $FD, $03, $15, $81, $FB, $04, $15, $81
	.byte $FB, $0A, $15, $81, $FB, $04, $15, $81
	.byte $FB, $04, $15, $83, $15, $FE, $FF, $03
	.byte $15, $81, $FB, $04, $15, $81, $FB, $0A
	.byte $15, $81, $FB, $04, $15, $81, $FB, $0A
	.byte $15, $81, $FB, $04, $15, $81, $FB, $0A
	.byte $15, $81, $EE, $04, $EC, $81, $EF, $0A
	.byte $15, $81, $EE, $04, $EC, $81, $EF, $77
	.byte $15, $77, $15, $77, $15, $40, $15, $0A
	.byte $FF, $81, $5F, $02, $FF, $81, $0F, $04
	.byte $FF, $84, $DF, $3F, $CF, $3F, $03, $FF
	.byte $86, $3F, $FF, $D3, $4C, $FF, $EF, $02
	.byte $FF, $86, $0F, $7F, $DD, $77, $DF, $AF
	.byte $03, $FF, $84, $55, $33, $CC, $AA, $04
	.byte $FF, $84, $F5, $F3, $FC, $FA, $0A, $FF
	.byte $FF

; -----------------------------------------------------------------------------

rom_9391:
	.byte $20, $00, $77, $15, $77, $15, $35, $15
	.byte $81, $EB, $04, $EC, $81, $ED, $08, $15
	.byte $81, $EB, $04, $EC, $82, $ED, $EB, $04
	.byte $EC, $81, $ED, $06, $15, $81, $FB, $04
	.byte $15, $81, $FB, $08, $15, $81, $FB, $04
	.byte $15, $02, $FB, $04, $15, $81, $FB, $06
	.byte $15, $81, $FB, $04, $15, $81, $FB, $02
	.byte $15, $83, $CC, $CD, $CE, $03, $15, $81
	.byte $FB, $04, $15, $02, $FB, $04, $15, $81
	.byte $FB, $06, $15, $81, $FB, $04, $15, $81
	.byte $FB, $02, $15, $84, $DC, $DD, $DE, $DF
	.byte $02, $15, $81, $FB, $04, $15, $02, $FB
	.byte $04, $15, $81, $FB, $06, $15, $81, $FB
	.byte $04, $15, $81, $FB, $03, $15, $83, $41
	.byte $CF, $FD, $02, $15, $81, $FB, $04, $15
	.byte $02, $FB, $04, $15, $81, $FB, $06, $15
	.byte $81, $FB, $04, $15, $81, $FB, $03, $15
	.byte $83, $15, $FE, $FF, $02, $15, $81, $FB
	.byte $04, $15, $02, $FB, $04, $15, $81, $FB
	.byte $06, $15, $81, $FB, $04, $15, $81, $FB
	.byte $08, $15, $81, $FB, $04, $15, $02, $FB
	.byte $04, $15, $81, $FB, $06, $15, $81, $EE
	.byte $04, $EC, $81, $EF, $08, $15, $81, $EE
	.byte $04, $EC, $82, $EF, $EE, $04, $EC, $81
	.byte $EF, $77, $15, $77, $15, $77, $15, $3E
	.byte $15, $0A, $FF, $81, $5F, $02, $FF, $81
	.byte $0F, $03, $FF, $86, $0F, $3F, $0F, $3F
	.byte $CF, $0F, $02, $FF, $86, $00, $33, $00
	.byte $33, $CC, $00, $02, $FF, $86, $0F, $7F
	.byte $DD, $7F, $DF, $AF, $03, $FF, $84, $55
	.byte $33, $CC, $AA, $04, $FF, $84, $F5, $F3
	.byte $FC, $FA, $0A, $FF, $81, $0F, $FF, $FF

; -----------------------------------------------------------------------------

rom_9491:
	.byte $28, $00, $77, $C1, $77, $C1, $35, $C1
	.byte $81, $17, $04, $18, $82, $19, $17, $04
	.byte $18, $81, $19, $08, $C1, $81, $17, $04
	.byte $18, $81, $19, $06, $C1, $81, $1A, $04
	.byte $C1, $02, $1A, $04, $C1, $81, $1A, $08
	.byte $C1, $81, $1A, $04, $C1, $81, $1A, $06
	.byte $C1, $81, $1A, $04, $C1, $02, $1A, $04
	.byte $C1, $81, $1A, $02, $C1, $83, $27, $28
	.byte $31, $03, $C1, $81, $1A, $04, $C1, $81
	.byte $1A, $06, $C1, $81, $1A, $04, $C1, $02
	.byte $1A, $04, $C1, $81, $1A, $02, $C1, $84
	.byte $32, $33, $34, $3E, $02, $C1, $81, $1A
	.byte $04, $C1, $81, $1A, $06, $C1, $81, $1A
	.byte $04, $C1, $02, $1A, $04, $C1, $81, $1A
	.byte $03, $C1, $83, $3F, $40, $41, $02, $C1
	.byte $81, $1A, $04, $C1, $81, $1A, $06, $C1
	.byte $81, $1A, $04, $C1, $02, $1A, $04, $C1
	.byte $81, $1A, $03, $C1, $83, $55, $4B, $4C
	.byte $02, $C1, $81, $1A, $04, $C1, $81, $1A
	.byte $06, $C1, $81, $1A, $04, $C1, $02, $1A
	.byte $04, $C1, $81, $1A, $08, $C1, $81, $1A
	.byte $04, $C1, $81, $1A, $06, $C1, $81, $46
	.byte $04, $18, $82, $39, $46, $04, $18, $81
	.byte $39, $08, $C1, $81, $46, $04, $18, $81
	.byte $39, $77, $C1, $77, $C1, $77, $C1, $3E
	.byte $C1, $0A, $FF, $81, $5F, $02, $FF, $81
	.byte $0F, $03, $FF, $86, $0F, $3F, $CF, $0F
	.byte $CF, $0F, $02, $FF, $86, $00, $33, $CC
	.byte $00, $CC, $00, $02, $FF, $86, $0F, $7F
	.byte $DF, $7F, $DF, $AF, $03, $FF, $84, $55
	.byte $33, $CC, $AA, $04, $FF, $84, $F5, $F3
	.byte $FC, $FA, $0A, $FF, $81, $0F, $FF, $FF

; -----------------------------------------------------------------------------

rom_9591:
	.byte $20, $00, $77, $45, $6E, $45, $81, $48
	.byte $14, $4C, $81, $49, $0A, $45, $81, $4D
	.byte $14, $00, $81, $4F, $0A, $45, $81, $4D
	.byte $14, $00, $81, $4F, $0A, $45, $81, $4D
	.byte $14, $00, $81, $4F, $0A, $45, $81, $4D
	.byte $03, $00, $83, $46, $0A, $05, $02, $06
	.byte $02, $00, $85, $06, $07, $0B, $0A, $07
	.byte $05, $00, $81, $4F, $0A, $45, $81, $4D
	.byte $03, $00, $83, $47, $17, $12, $02, $13
	.byte $02, $00, $85, $13, $14, $18, $17, $14
	.byte $05, $00, $81, $4F, $0A, $45, $81, $4D
	.byte $14, $00, $81, $4F, $0A, $45, $81, $4D
	.byte $03, $00, $82, $07, $02, $02, $00, $8A
	.byte $3A, $02, $03, $07, $09, $03, $0D, $05
	.byte $00, $44, $03, $00, $81, $4F, $0A, $45
	.byte $81, $4D, $03, $00, $82, $14, $0F, $02
	.byte $00, $8A, $3B, $0F, $10, $14, $16, $10
	.byte $1A, $12, $00, $43, $03, $00, $81, $4F
	.byte $0A, $45, $81, $4D, $14, $00, $81, $4F
	.byte $0A, $45, $81, $4D, $14, $00, $81, $4F
	.byte $0A, $45, $81, $4D, $0A, $00, $81, $22
	.byte $09, $00, $81, $4F, $0A, $45, $81, $4D
	.byte $0A, $00, $81, $2B, $09, $00, $81, $4F
	.byte $0A, $45, $81, $4D, $14, $00, $81, $4F
	.byte $0A, $45, $81, $4D, $14, $00, $81, $4F
	.byte $0A, $45, $81, $4A, $14, $4E, $81, $4B
	.byte $77, $45, $6E, $45, $11, $FF, $81, $33
	.byte $04, $00, $81, $CC, $02, $FF, $81, $33
	.byte $04, $00, $81, $CC, $02, $FF, $81, $33
	.byte $04, $00, $81, $CC, $02, $FF, $81, $F3
	.byte $04, $F0, $81, $FC, $11, $FF, $FF

; -----------------------------------------------------------------------------

rom_968C:
	.byte $20, $00, $77, $45, $6E, $45, $81, $48
	.byte $14, $4C, $81, $49, $0A, $45, $81, $4D
	.byte $14, $00, $81, $4F, $0A, $45, $81, $4D
	.byte $14, $00, $81, $4F, $0A, $45, $81, $4D
	.byte $14, $00, $81, $4F, $0A, $45, $81, $4D
	.byte $14, $00, $81, $4F, $0A, $45, $81, $4D
	.byte $14, $00, $81, $4F, $0A, $45, $81, $4D
	.byte $14, $00, $81, $4F, $0A, $45, $81, $4D
	.byte $05, $00, $84, $04, $0B, $20, $05, $02
	.byte $00, $84, $02, $52, $05, $0A, $05, $00
	.byte $81, $4F, $0A, $45, $81, $4D, $05, $00
	.byte $84, $11, $18, $29, $12, $02, $00, $84
	.byte $0F, $53, $12, $17, $05, $00, $81, $4F
	.byte $0A, $45, $81, $4D, $14, $00, $81, $4F
	.byte $0A, $45, $81, $4D, $14, $00, $81, $4F
	.byte $0A, $45, $81, $4D, $14, $00, $81, $4F
	.byte $0A, $45, $81, $4D, $14, $00, $81, $4F
	.byte $0A, $45, $81, $4D, $14, $00, $81, $4F
	.byte $0A, $45, $81, $4D, $14, $00, $81, $4F
	.byte $0A, $45, $81, $4A, $14, $4E, $81, $4B
	.byte $77, $45, $6E, $45, $11, $FF, $81, $33
	.byte $04, $00, $81, $CC, $02, $FF, $81, $33
	.byte $04, $00, $81, $CC, $02, $FF, $81, $33
	.byte $04, $00, $81, $CC, $02, $FF, $81, $F3
	.byte $04, $F0, $81, $FC, $11, $FF, $FF

; -----------------------------------------------------------------------------

rom_high_scores_rle:
	.byte $20, $00, $44, $42, $8A, $01, $02, $03
	.byte $04, $05, $06, $07, $00, $08, $09, $02
	.byte $03, $8C, $09, $03, $04, $00, $06, $07
	.byte $0A, $05, $0B, $0C, $06, $00, $08, $42
	.byte $8A, $0E, $0F, $10, $11, $12, $13, $14
	.byte $00, $15, $16, $02, $10, $8C, $16, $10
	.byte $11, $00, $13, $14, $17, $12, $18, $19
	.byte $13, $00, $06, $42, $81, $1B, $1A, $1C
	.byte $81, $1D, $04, $42, $81, $1E, $1A, $42
	.byte $81, $1E, $04, $42, $83, $1E, $42, $1F
	.byte $02, $00, $83, $20, $0B, $21, $02, $00
	.byte $8D, $1F, $22, $00, $08, $09, $03, $06
	.byte $00, $1F, $23, $24, $25, $23, $03, $26
	.byte $82, $42, $1E, $04, $42, $88, $1E, $42
	.byte $27, $28, $00, $29, $18, $2A, $02, $00
	.byte $8D, $27, $2B, $00, $15, $16, $10, $13
	.byte $00, $27, $2C, $2D, $2E, $2C, $03, $2F
	.byte $82, $42, $1E, $04, $42, $83, $1E, $42
	.byte $30, $02, $00, $83, $31, $02, $03, $02
	.byte $00, $8D, $1F, $25, $00, $08, $09, $03
	.byte $06, $00, $1F, $30, $32, $33, $25, $03
	.byte $26, $82, $42, $1E, $04, $42, $88, $1E
	.byte $42, $34, $28, $00, $35, $0F, $10, $02
	.byte $00, $8D, $27, $2E, $00, $15, $16, $10
	.byte $13, $00, $27, $34, $36, $37, $2E, $03
	.byte $2F, $82, $42, $1E, $04, $42, $83, $1E
	.byte $42, $23, $02, $00, $83, $31, $05, $21
	.byte $02, $00, $88, $1F, $33, $00, $08, $09
	.byte $03, $06, $00, $02, $1F, $84, $26, $24
	.byte $25, $23, $02, $26, $82, $42, $1E, $04
	.byte $42, $88, $1E, $42, $2C, $28, $00, $35
	.byte $12, $2A, $02, $00, $88, $27, $37, $00
	.byte $15, $16, $10, $13, $00, $02, $27, $84
	.byte $2F, $2D, $2E, $2C, $02, $2F, $82, $42
	.byte $1E, $04, $42, $83, $1E, $42, $32, $02
	.byte $00, $83, $31, $09, $20, $02, $00, $87
	.byte $1F, $32, $00, $08, $09, $03, $06, $02
	.byte $00, $84, $22, $32, $38, $33, $03, $26
	.byte $82, $42, $1E, $04, $42, $88, $1E, $42
	.byte $36, $28, $00, $35, $16, $29, $02, $00
	.byte $87, $27, $36, $00, $15, $16, $10, $13
	.byte $02, $00, $84, $2B, $36, $39, $37, $03
	.byte $2F, $82, $42, $1E, $04, $42, $83, $1E
	.byte $42, $38, $02, $00, $83, $0B, $07, $3A
	.byte $02, $00, $87, $1F, $23, $00, $08, $09
	.byte $03, $06, $02, $00, $81, $24, $02, $1F
	.byte $82, $26, $24, $02, $26, $82, $42, $1E
	.byte $04, $42, $88, $1E, $42, $39, $28, $00
	.byte $18, $14, $3B, $02, $00, $87, $27, $2C
	.byte $00, $15, $16, $10, $13, $02, $00, $81
	.byte $2D, $02, $27, $82, $2F, $2D, $02, $2F
	.byte $82, $42, $1E, $04, $42, $83, $1E, $42
	.byte $33, $02, $00, $83, $04, $0A, $3C, $02
	.byte $00, $87, $1F, $23, $00, $08, $09, $03
	.byte $06, $02, $00, $84, $33, $25, $30, $1F
	.byte $03, $26, $82, $42, $1E, $04, $42, $88
	.byte $1E, $42, $37, $28, $00, $11, $17, $3D
	.byte $02, $00, $87, $27, $2C, $00, $15, $16
	.byte $10, $13, $02, $00, $84, $37, $2E, $34
	.byte $27, $03, $2F, $82, $42, $1E, $04, $42
	.byte $83, $1E, $42, $25, $02, $00, $83, $31
	.byte $02, $05, $02, $00, $87, $1F, $23, $00
	.byte $08, $09, $03, $06, $02, $00, $82, $32
	.byte $33, $02, $25, $81, $38, $02, $26, $82
	.byte $42, $1E, $04, $42, $88, $1E, $42, $2E
	.byte $28, $00, $35, $0F, $12, $02, $00, $87
	.byte $27, $2C, $00, $15, $16, $10, $13, $02
	.byte $00, $82, $36, $37, $02, $2E, $81, $39
	.byte $02, $2F, $82, $42, $1E, $04, $42, $83
	.byte $1E, $42, $24, $02, $00, $83, $3A, $3E
	.byte $0C, $03, $00, $86, $22, $00, $08, $09
	.byte $03, $06, $02, $00, $85, $30, $32, $38
	.byte $33, $25, $02, $26, $82, $42, $1E, $04
	.byte $42, $88, $1E, $42, $2D, $28, $00, $3B
	.byte $3F, $19, $03, $00, $86, $2B, $00, $15
	.byte $16, $10, $13, $02, $00, $85, $34, $36
	.byte $39, $37, $2E, $02, $2F, $82, $42, $1E
	.byte $04, $42, $83, $1E, $42, $22, $02, $00
	.byte $83, $3A, $3E, $06, $03, $00, $86, $25
	.byte $00, $08, $09, $03, $06, $02, $00, $85
	.byte $1F, $23, $33, $32, $33, $02, $26, $82
	.byte $42, $1E, $04, $42, $88, $1E, $42, $2B
	.byte $28, $00, $3B, $3F, $13, $03, $00, $86
	.byte $2E, $00, $15, $16, $10, $13, $02, $00
	.byte $85, $27, $2C, $37, $36, $37, $02, $2F
	.byte $82, $42, $1E, $04, $42, $88, $1E, $42
	.byte $1F, $26, $00, $3E, $0B, $01, $03, $00
	.byte $86, $33, $00, $08, $09, $03, $06, $03
	.byte $00, $84, $22, $32, $24, $25, $02, $26
	.byte $82, $42, $1E, $04, $42, $88, $1E, $42
	.byte $27, $2F, $28, $3F, $18, $0E, $03, $00
	.byte $86, $37, $00, $15, $16, $10, $13, $03
	.byte $00, $84, $2B, $36, $2D, $2E, $02, $2F
	.byte $82, $42, $1E, $04, $42, $81, $1E, $1A
	.byte $42, $81, $1E, $04, $42, $81, $40, $1A
	.byte $1C, $81, $41, $42, $42, $81, $FF, $06
	.byte $AF, $82, $FF, $BB, $06, $FA, $82, $EE
	.byte $BB, $06, $FF, $82, $EE, $BB, $06, $FF
	.byte $82, $EE, $BB, $06, $FF, $82, $EE, $BB
	.byte $06, $FF, $82, $EE, $BB, $06, $AF, $81
	.byte $EE, $08, $FF, $FF

; -----------------------------------------------------------------------------

; This is the "title sequence" before the main menu appears
nam_titles_rle:
.incbin "bin/titles.rle"

; -----------------------------------------------------------------------------

; A plain-looking sound test menu
nam_sound_test_rle:
.incbin "bin/sound_test.rle"

; -----------------------------------------------------------------------------

.export rom_04_9CAD

rom_04_9CAD:
	.word tbl_main_menu_indices
	.word tbl_options_menu_indices
	.word rom_9CD5
	.word rom_9CF9
	.word tbl_sound_test_indices

; -----------------------------------------------------------------------------

; Each entry has four indices, one per D-Pad direction (left, right, up, down)
; When that direction is pressed, the cursor will move to the option with the
; corresponding index
; If the index is $FF, the cursor will not move

; Indices for main menu (left=tournament, right=options)
tbl_main_menu_indices:
	.byte $00, $01, $FF, $FF	; $00 = Tournament
	.byte $00, $01, $FF, $FF	; $01 = Options

; Indices for options menu (top=very easy ... bottom= exit)
tbl_options_menu_indices:
	.byte $FF, $FF, $05, $01	; $00 = Very Easy
	.byte $FF, $FF, $00, $02	; $01 = Easy
	.byte $FF, $FF, $01, $03	; $02 = Medium
	.byte $FF, $FF, $02, $04	; $03 = Hard
	.byte $FF, $FF, $03, $05	; $04 = Very Hard
	.byte $FF, $FF, $04, $00	; $05 = Exit

rom_9CD5:
	.byte $00, $01, $06, $03
	.byte $00, $01, $08, $04
	.byte $05, $03, $00, $06
	.byte $02, $04, $00, $06
	.byte $03, $05, $01, $08
	.byte $04, $02, $01, $08
	.byte $08, $07, $03, $00
	.byte $06, $08, $03, $00
	.byte $07, $06, $04, $01

rom_9CF9:
	.byte $03, $01, $0C, $05
	.byte $00, $02, $0D, $06
	.byte $01, $03, $0F, $08
	.byte $02, $00, $10, $09
	.byte $0A, $05, $FF, $0B
	.byte $04, $06, $00, $0C
	.byte $05, $07, $01, $0D
	.byte $06, $08, $FF, $0E
	.byte $07, $09, $02, $0F

; Potentially unused
	.byte $08, $0A, $03, $10
	.byte $09, $04, $FF, $11
	.byte $11, $0C, $04, $FF
	.byte $0B, $0D, $05, $00
	.byte $0C, $0E, $06, $01
	.byte $0D, $0F, $07, $FF
	.byte $0E, $10, $08, $02
	.byte $0F, $11, $09, $03
	.byte $10, $0B, $0A, $FF

tbl_sound_test_indices:
	.byte $FF, $FF, $00, $01	; Music track
	.byte $FF, $FF, $00, $02	; Sound effect
	.byte $FF, $FF, $01, $02	; Quit

; -----------------------------------------------------------------------------

; Requests the engine to play a music track depending on the current screen
sub_choose_music_track:
	ldx zp_tmp_idx
	lda @tbl_bg_music,X
	sta ram_req_song
	rts

; -----------------------------------------------------------------------------

	@tbl_bg_music:
	.byte $20	; $00	Menu intro jingle
	.byte $22	; $01	Options menu
	.byte $21	; $02	Player select (also VS screen)
	.byte $21	; $03
	.byte $20	; $04	High scores
	.byte $22	; $05
	.byte $22	; $06
	.byte $21	; $07
	.byte $20	; $08	Titles screen
	.byte $22	; $09	Sound test (silence)

; -----------------------------------------------------------------------------
.export sub_select_music_to_test

; Parameters:
; A = controller data with left or right bit set
; zp_plr2_selection = 0 for music, 1 for sfx, anything else is ignored
sub_select_music_to_test:
	ldy zp_plr2_selection
	beq @select_music
		cpy #$01
		beq :+
			; Ignore invalid options
			rts
		:
		; Select sound effect
		; TODO
		bit @bit_01
		beq :+
			; Right = increase index
			; TODO
			rts
		:
		; Left = decrease index
		; TODO
		rts
	@select_music:
	bit @bit_01
	beq @music_prev

		; Right = increase index
		lda #$0C	; There are 11 choices (0-10)
		isc zp_plr1_selection
		bne :+
			dec zp_plr1_selection
		:
		jmp sub_show_mus_selection

	@music_prev:

	; Left = decrease index
	lda #$FF
	dcp zp_plr1_selection
	bne :+
		inc zp_plr1_selection
	:
	jmp sub_show_mus_selection

	@bit_01:
	.byte $01

; -----------------------------------------------------------------------------

sub_show_mus_selection:
	; PPU Address = $2176
	lda #$21
	sta zp_nmi_ppu_ptr_hi
	lda #$76
	sta zp_nmi_ppu_ptr_lo
	
	lda zp_plr1_selection
	asl
	tax

	lda tbl_num_to_char+0,X
	sta ram_0600+0
	lda tbl_num_to_char+1,X
	sta ram_0600+1

	; Ready to transfer data
	lda #$01
	sta zp_nmi_ppu_rows
	lda #$02
	sta zp_nmi_ppu_cols

	rts

; ----------------

; Number conversion table
tbl_num_to_char:
	.byte "00", "01", "02", "03", "04", "05", "06", "07"
	.byte "08", "09", "10"

; -----------------------------------------------------------------------------
.export sub_show_playing_song

sub_show_playing_song:
	; PPU Address = $22C8
	lda #$22
	sta zp_nmi_ppu_ptr_hi
	lda #$C8
	sta zp_nmi_ppu_ptr_lo

	lda ram_req_song
	sec
	sbc #$20
	asl
	asl
	asl
	asl
	tax

	ldy #$00
	:
	lda @tbl_song_names,X
	sta ram_0600,Y
	inx
	iny
	cpy #$11
	bne :-

	; Ready to transfer data
	lda #$01
	sta zp_nmi_ppu_rows
	lda #$10
	sta zp_nmi_ppu_cols

	rts

; ----------------

	; Each string is 16 bytes long
	@tbl_song_names:
	.byte "    opening     "	; $20
	.byte "  your destiny  "	; $21
	.byte "    silence     "	; $22
	.byte "     unused     "	; $23
	.byte "    silence     "	; $24
	.byte "   goros lair   "	; $25
	.byte "    the pit     "	; $26
	.byte "   courtyard    "	; $27
	.byte "  palace gates  "	; $28
	.byte " warrior shrine "	; $29
	.byte "  throne  room  "	; $2A

; -----------------------------------------------------------------------------
