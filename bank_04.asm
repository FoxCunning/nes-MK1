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
	lda zp_frame_counter
	clc
	adc #$01
	:
	cmp zp_frame_counter
	bcc :-
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

	; We load a full nametable: no need to clear it first
	;lda #$00
	;jsr sub_clear_nametable
	;lda #$01
	;jsr sub_clear_nametable

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
	sta zp_pal_mask_idx
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
	.byte $FC, $FD, $FE, $FF, $FE, $FF, $00, $00	; $00	Main menu
	.byte $FC, $FE, $FC, $FD, $FE, $FF, $00, $00	; $01	Options menu
	.byte $FC, $FE, $F8, $F9, $FA, $FB, $00, $00	; $02	Fighter select
	.byte $F4, $F6, $F4, $F5, $F6, $F7, $00, $00	; $03	Battle plan
	.byte $FC, $FE, $FC, $FD, $FE, $FF, $00, $00	; $04	(Fake) high scores
	.byte $FC, $FE, $FC, $FD, $FE, $FF, $00, $00	; $05	Continue screen
	.byte $D8, $DA, $D8, $D9, $DA, $DB, $00, $00	; $06	Ending
	.byte $FC, $FE, $F8, $F9, $FA, $FB, $00, $00	; $07	Endurance match VS TODO remove
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
	.word nam_dont_load
    .byte $28, $28

    .word nam_battle_plan_top		; $03
    .byte $20, $20
	.word nam_battle_plan_btm
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
    .byte $0C, $03	; $03	Battle Plan
    .byte $0C, $01	; $04	Fake high scores screen
    .byte $0C, $01	; $05
    .byte $0C, $01	; $06
    .byte $0C, $02	; $07
    .byte $0F, $04	; $08	Titles
	.byte $10, $00	; $09	Sound test

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

	lda zp_pal_mask_idx
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
	.word palette_main_menu
	.word palette_options_menu
	.word palette_fighter_select
	.word palette_battle_plan
	.word palette_titles

; -----------------------------------------------------------------------------

palette_main_menu:
	.byte $0E, $16, $26, $36, $0E, $12, $21, $20
	.byte $0E, $17, $27, $37, $0E, $00, $10, $20
	.byte $0E, $0F, $00, $20, $0E, $16, $26, $20
	.byte $0E, $0F, $00, $27, $0E, $06, $16, $26

; -----------------------------------------------------------------------------

; Used in option menu
palette_options_menu:
	.byte $0E, $00, $10, $20, $0E, $2D, $00, $20
	.byte $0E, $2D, $00, $10, $0E, $2D, $00, $27
	.byte $0E, $0F, $00, $20, $0E, $16, $26, $20
	.byte $0E, $0F, $00, $27, $0E, $06, $16, $26

; -----------------------------------------------------------------------------

palette_fighter_select:
	.byte $FF, $16, $26, $36, $FF, $11, $21, $30
	.byte $FF, $17, $27, $37, $FF, $0C, $1C, $37
	.byte $0F, $17, $27, $38, $0E, $13, $21, $30
	.byte $0E, $09, $19, $3B, $0E, $06, $16, $36

; -----------------------------------------------------------------------------

palette_battle_plan:
	.byte $07, $00, $2D, $30, $07, $11, $21, $30
	.byte $07, $17, $27, $37, $07, $06, $16, $26
	.byte $07, $16, $26, $36, $07, $11, $21, $30
	.byte $07, $17, $27, $37, $07, $0F, $1A, $37

; -----------------------------------------------------------------------------

; Used in titles sequence
palette_titles:
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

nam_battle_plan_top:
.incbin "nam/battle_plan_top.rle"

; -----------------------------------------------------------------------------

nam_battle_plan_btm:
.incbin "nam/battle_plan_btm.rle"

; -----------------------------------------------------------------------------

nam_dont_load:
	.byte $20, $00, $FF

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
	.word tbl_fighter_sel_indices
	.word rom_9CF9
	.word tbl_sound_test_indices

; -----------------------------------------------------------------------------

; Each entry has four indices, one per D-Pad direction (left, right, up, down)
; When that direction is pressed, the cursor will move to the option with the
; corresponding index
; If the index is $FF, the cursor will not move

; Indices for main menu (left=tournament, right=options)
tbl_main_menu_indices:
	.byte $FF, $FF, $FF, $01	; $00 = Tournament
	.byte $FF, $FF, $00, $FF	; $01 = Options

; Indices for options menu (top=very easy ... bottom= exit)
tbl_options_menu_indices:
	.byte $FF, $FF, $06, $01	; $00 = Very Easy
	.byte $FF, $FF, $00, $02	; $01 = Easy
	.byte $FF, $FF, $01, $03	; $02 = Medium
	.byte $FF, $FF, $02, $04	; $03 = Hard
	.byte $FF, $FF, $03, $05	; $04 = Very Hard
	.byte $FF, $FF, $04, $06	; $05 = Sound Test
	.byte $FF, $FF, $05, $00	; $06 = Exit

tbl_fighter_sel_indices:
	.byte $FF, $01, $FF, $04
	.byte $00, $02, $FF, $05
	.byte $01, $FF, $FF, $06

	.byte $FF, $04, $00, $07
	.byte $03, $05, $00, $07
	.byte $04, $06, $01, $08
	.byte $05, $FF, $02, $08

	.byte $FF, $08, $04, $FF
	.byte $07, $FF, $05, $FF

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
	.byte $21	; $07	Endurance match Vs. Screen
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
