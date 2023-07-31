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
.IFNDEF DENDY
	lda PpuStatus_2002
	bpl sub_wait_vblank

	; Probably this repeat is to work around the potential issue that happens
	; when the status is read right after the NMI flag was set in the PPU
	:
	lda PpuStatus_2002
	bpl :-
.ELSE
	; Use the global frame counter instead
	lda zp_frame_counter
	clc
	adc #$01
	@wait_2frames:
	cmp zp_frame_counter
	bcc @wait_2frames
.ENDIF
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
	sta ram_irq_routine_idx
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
	sta ram_irq_routine_idx
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
	.byte $FC, $FE, $F8, $F9, $FA, $FB, $00, $00	; $02	Fighter select / VS
	.byte $FC, $FE, $F8, $F9, $FA, $FB, $00, $00	; $03	UNUSED/LEFTOVER
	.byte $FC, $FE, $FC, $FD, $FE, $FF, $00, $00	; $04	(Fake) high scores
	.byte $FC, $FE, $FC, $FD, $FE, $FF, $00, $00	; $05	Continue screen
	.byte $D8, $DA, $D8, $D9, $DA, $DB, $00, $00	; $06	Ending
	.byte $FC, $FE, $F8, $F9, $FA, $FB, $00, $00	; $07	Endurance match VS
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

    .word nam_fighter_select_rle	; $02
    .byte $20, $20
	.word nam_vs_screen_2_rle
    .byte $28, $28

    .word nam_unused_rle			; $03
    .byte $20, $20
	.word nam_vs_screen_2_rle
    .byte $28, $28

    .word nam_high_scores_rle		; $04	Fake "top winning streaks"
    .byte $20, $20
	.word nam_high_scores_rle
    .byte $28, $28

    .word nam_continue_rle			; $05
    .byte $20, $20
	.word nam_game_over_rle
    .byte $28, $28

    .word nam_congratulations_rle	; $06
    .byte $20, $20
	.word nam_try_harder_rle
    .byte $28, $28

    .word nam_endurance_top_rle		; $07
    .byte $20, $20
	.word nam_endurance_btm_rle
    .byte $28, $28

    .word nam_titles_rle			; $08
    .byte $20, $20
	.word nam_titles_rle
    .byte $28, $28

	.word nam_sound_test_rle		; $09
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
		sta ram_ppu_data_buffer,Y
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

nam_congratulations_rle:
.incbin "nam/congratulations.rle"

; -----------------------------------------------------------------------------

nam_try_harder_rle:
.incbin "nam/try_harder.rle"

; -----------------------------------------------------------------------------

nam_main_menu_top_rle:
.incbin "nam/main_menu_top.rle"

; -----------------------------------------------------------------------------

; This is the bottom half the of the main menu, repeated twice vertically
; The bottom copy has the "options" menu item selected
nam_main_menu_btm_rle:
.incbin "nam/main_menu_btm.rle"

; -----------------------------------------------------------------------------

nam_option_menu_rle:
.incbin "nam/options_left.rle"

; -----------------------------------------------------------------------------

; This is basically the same as the previous nametable, but with different
; attributes to highlight the options
nam_option_menu_2_rle:
.incbin "nam/options_right.rle"

; -----------------------------------------------------------------------------

nam_fighter_select_rle:
.incbin "nam/fighter_select.rle"

; -----------------------------------------------------------------------------

nam_unused_rle:
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

nam_vs_screen_2_rle:
.incbin "nam/vs_screen_btm.rle"

; -----------------------------------------------------------------------------

nam_endurance_top_rle:
.incbin "nam/vs_endurance_top.rle"

; -----------------------------------------------------------------------------

nam_endurance_btm_rle:
.incbin "nam/vs_endurance_btm.rle"

; -----------------------------------------------------------------------------

nam_continue_rle:
.incbin "nam/continue_screen.rle"

; -----------------------------------------------------------------------------

nam_game_over_rle:
.incbin "nam/game_over_screen.rle"

; -----------------------------------------------------------------------------

nam_high_scores_rle:
.incbin "nam/winning_streaks.rle"

; -----------------------------------------------------------------------------

; This is the "title sequence" before the main menu appears
nam_titles_rle:
.incbin "nam/titles.rle"

; -----------------------------------------------------------------------------

; A plain-looking sound test menu
nam_sound_test_rle:
.incbin "nam/sound_test.rle"

; -----------------------------------------------------------------------------

.export tbl_menu_indices_ptrs

tbl_menu_indices_ptrs:
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
	.byte $FF, $FF, $06, $01	; $00 = Very Easy
	.byte $FF, $FF, $00, $02	; $01 = Easy
	.byte $FF, $FF, $01, $03	; $02 = Medium
	.byte $FF, $FF, $02, $04	; $03 = Hard
	.byte $FF, $FF, $03, $05	; $04 = Very Hard
	.byte $FF, $FF, $04, $06	; $05 = Sound Test
	.byte $FF, $FF, $05, $00	; $06 = Exit

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
	.byte $20	; $02	Player select
	.byte $21	; $03	Vs. Screen
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
; zp_selected_opt = 0 for music, 1 for sfx, anything else is ignored
sub_select_music_to_test:
	ldy ram_selected_opt
	beq @select_music
		cpy #$01
		beq :+
			; Ignore invalid options
			rts
		:
		; Select sound effect
		bit @bit_01	; Check left/right
		beq @sfx_prev
			; Right = increase index
			lda #$20	; There are 32 choices (00-1F)
			isc zp_plr2_selection
			bne :+
				; Invalid choice, avoid overflow
				dec zp_plr2_selection
			:
			jmp sub_show_mus_selection

		@sfx_prev:

		; Left = decrease index
		lda #$FF
		dcp zp_plr2_selection
		bne :+
			inc zp_plr2_selection
		:
		jmp sub_show_mus_selection

	@select_music:
	bit @bit_01	; Check left/right (bit 0 set = Right)
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

; Parameters:
; Y = 0 for music, 1 for SFX
sub_show_mus_selection:
	; PPU Address = $2176
	lda #$21
	sta zp_nmi_ppu_ptr_hi

	lda #$B6		; Vertical offset for sfx
	cpy #$01
	beq :+
		lda #$76	; Vertical offset for music
	:
	sta zp_nmi_ppu_ptr_lo
	
	lda zp_plr1_selection,Y
	asl
	tax

	lda tbl_num_to_char+0,X
	sta ram_ppu_data_buffer+0
	lda tbl_num_to_char+1,X
	sta ram_ppu_data_buffer+1

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
	.byte "08", "09", "10", "11", "12", "13", "14", "15"
	.byte "16", "17", "18", "19", "20", "21", "22", "23"
	.byte "24", "25", "26", "27", "28", "29", "30", "31"

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
	sta ram_ppu_data_buffer,Y
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
	.byte "   game over    "	; $23
	.byte "    silence     "	; $24
	.byte "   goros lair   "	; $25
	.byte "    the pit     "	; $26
	.byte "   courtyard    "	; $27
	.byte "  palace gates  "	; $28
	.byte " warrior shrine "	; $29
	.byte "  throne  room  "	; $2A

; -----------------------------------------------------------------------------
