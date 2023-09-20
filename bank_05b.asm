.segment "BANK_05b"
; $B000-$BFFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"
.include "charmap.inc"


; -----------------------------------------------------------------------------
.export sub_state_machine_0

; Called when Machine State is 0,?,?
; Branches depending on Machine State 1
sub_state_machine_0:
	lda zp_machine_state_1	; This will be the index of the pointer to use
	jsr sub_trampoline		; The sub will use the following table of pointers
                        	; to jump to one of those locations
; ----------------
	.word sub_main_menu_states			; 0,0
	.word sub_option_menu_states		; 0,1
	.word sub_fighter_sel_states		; 0,2
	.word sub_vs_state_machine			; 0,3
	.word sub_continue_screen_state_machine	; 0,4
	.word sub_high_scores_states		; 0,5
	.word sub_ending_states					; 0,6

; -----------------------------------------------------------------------------

; Called when Machine State is 0,0,?
sub_main_menu_states:
	lda zp_machine_state_2
	jsr sub_trampoline    ; Same trick again
; ----------------
	.word sub_titles_screen_init	; 0,0,0
	.word sub_titles_fade_in		; 0,0,1
	.word sub_titles_loop			; 0,0,2
	.word sub_menu_fade_out 		; 0,0,3

	.word sub_menu_screen_init		; 0,0,4
	.word sub_menu_fade_in			; 0,0,5
	.word sub_main_menu_loop		; 0,0,6
	.word sub_main_menu_loop		; 0,0,7
	.word sub_main_menu_loop		; 0,0,8
	.word sub_menu_fade_out			; 0,0,9
	.word sub_eval_menu_choice		; 0,0,A
	.word sub_fade_to_high_scores	; 0,0,B

; -----------------------------------------------------------------------------

; Machine state = 0,0,4
sub_menu_screen_init:
	lda #$00
	jsr sub_init_screen_common

	; Switch to vertical mirroring
	lda #$00
	sta mmc3_mirroring

	sta zp_irq_hor_scroll
	sta zp_irq_ver_scroll

	lda #$0D
	sta ram_irq_routine_idx
	lda #$48
	sta ram_irq_latch_value
	
	lda #$00
	sta zp_match_type
	sta zp_match_number
	;lda #$00
	sta zp_plr1_selection
	lda #$02
	sta zp_plr2_selection

	; OAM data for menu items
	ldx #$00
	:
		lda @oam_menu_sprites,X
		sta ram_oam_copy_ypos+4,X
		inx
		cpx #$30
	bne :-

	; Move the cursor sprite to default selection
	lda tbl_menu_cursor_y
	sta ram_oam_copy_ypos
	lda #$95
	sta ram_oam_copy_tileid
	lda #$01
	sta ram_oam_copy_attr
	lda #$54
	sta ram_oam_copy_xpos

	inc zp_machine_state_2	; Move to next sub-state

	lda #$00
	sta zp_5E
	sta zp_ppu_ptr_lo	; These are used for the scrolling effect
	lda #$24
	sta zp_ppu_ptr_hi

	rts

; ----------------

	@oam_menu_sprites:

	; Start
	.byte $70, $BB, $02, $60
	.byte $70, $AB, $02, $68
	.byte $70, $AD, $02, $70
	.byte $70, $A9, $02, $78
	.byte $70, $AB, $02, $80

	; Options
	.byte $A0, $A7, $00, $60
	.byte $A0, $B5, $00, $68
	.byte $A0, $AB, $00, $70
	.byte $A0, $B7, $00, $78
	.byte $A0, $A7, $00, $80
	.byte $A0, $B9, $00, $88
	.byte $A0, $BB, $00, $90

; -----------------------------------------------------------------------------

; Machine state = 0,0,5 and 0,1,1
; Used to fade in the Main Menu and Options Menu
sub_menu_fade_in:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$05
	bcc @menu_fade_in_end	; Branch if palettes still cycling
	
		; Fade in complete
		
		lda #$0A
		sta zp_counter_param	; Countdown for high scores

		inc zp_machine_state_2	; Move to next sub-state

	@menu_fade_in_end:
	rts

; -----------------------------------------------------------------------------

; Called when Machine State is 0,0,8
sub_main_menu_loop:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	beq @main_menu_loop_end	; Branch if already executed during this frame
		
		sta zp_last_execution_frame

		; Animate cursor
		lda zp_frame_counter
		and #$01
		bne :++
			lda ram_oam_copy_tileid
			clc
			adc #$02
			cmp #$A3
			bcc :+
				lda #$95
			:
			sta ram_oam_copy_tileid
		:
		

		lda zp_frame_counter
		and #$3F
		bne :+

			dec zp_counter_param
			bpl :+
				; Wait counter expired: show high score screen
				lda #$0B
				sta zp_machine_state_2	; 0,0,B = Fake high scores
				rts

		:
		jsr sub_get_controller1_main_menu

		lda zp_controller1_new
		and #$D0	; A, B or START
		beq sub_main_menu_loop

		; ---- End of loop: a button was pressed

			; TODO Use a DMC "gong" sample?
			lda #$0C	; "Select" sound
			sta ram_req_sfx

			lda #$09
			sta zp_machine_state_2

			lda #$05
			sta zp_palette_fade_idx
	@main_menu_loop_end:
	rts

; -----------------------------------------------------------------------------

; Machine state = 0,0,9 and 0,1,3
; Used to fade out the Main Menu and Options Menu
sub_menu_fade_out:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$09
	bcc @fade_out_end
		; Palettes are still cycling
		;rts
; ----------------
	inc zp_machine_state_2
	@fade_out_end:
	rts

; -----------------------------------------------------------------------------

; Machine state = 0,0,A
sub_eval_menu_choice:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	beq @main_menu_eval_end
		; Already executed on this frame
		;rts
; ----------------
	sta zp_last_execution_frame

	lda #$0C
	sta ram_irq_routine_idx

	; Disable rendering and clear machine sub-state
	lda #$00
	sta PpuMask_2001
	sta zp_machine_state_2

	lda zp_plr1_selection
	bne :+
		; Option 0 = Tournament
		lda #$03 	; Player 1 default selection
		sta zp_plr1_selection
		lda #$84	; Player 2 default selection
		sta zp_plr2_selection

		inc zp_machine_state_1	; 0,2,0 (because it's increased again below)
	:
	; Option 1 = Options Menu
	inc zp_machine_state_1	; 0,1,0
	@main_menu_eval_end:
	rts

; -----------------------------------------------------------------------------

; Machine state = 0,0,B
sub_fade_to_high_scores:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$09
	bcc @fade_to_high_scores_end
		; Palettes still cycling
		;rts
; ----------------
	; Palette fade done: switch to machine state 0,5,0
	lda #$00
	sta zp_machine_state_2
	lda #$05
	sta zp_machine_state_1
	@fade_to_high_scores_end:
	rts

; -----------------------------------------------------------------------------

; Handles controller 1 input for main menu
sub_get_controller1_main_menu:
	;lda #$00	; What's the point? Just read the first two bytes...
	;asl A
	;tax
	;lda rom_04_9CAD+0,X
	lda tbl_menu_indices_ptrs+0
	sta zp_ptr1_lo
	;lda rom_04_9CAD+1,X
	lda tbl_menu_indices_ptrs+1
	sta zp_ptr1_hi

	lda zp_controller1_new
	sta zp_06

	lda zp_plr1_selection	; This will be either 0 (left option) or 1 (right option)
	sta zp_05

	jsr sub_ctrl_to_idx
	bmi @menu_ctrl_rts

		sta zp_plr1_selection
		lda #$03	; Cursor bleep SFX
		sta ram_req_sfx

		; Move the cursor sprite and highlight the selected item

		ldx zp_plr1_selection	; 0 = Start, 1 = Options
		lda tbl_menu_cursor_y,X
		sta ram_oam_copy_ypos

		ldy #$00
		cpx #$00
		beq :+
			ldy #$02
		:

		ldx #$00
		:
			lda @tbl_menu_sel_attr+0,Y
			sta ram_oam_copy_attr+4,X
			txa
			axs #$FC
			cpx #$14
		bcc :-

		:
			lda @tbl_menu_sel_attr+1,Y
			sta ram_oam_copy_attr+4,X
			txa
			axs #$FC
			cpx #$34
		bcc :-

		lda #$0A
		sta zp_counter_param

	@menu_ctrl_rts:
	rts

; ----------------

	@tbl_menu_sel_attr:
	.byte $02, $00	; Start highlighted
	.byte $00, $02	; Options highlighted

; -----------------------------------------------------------------------------

; OAM Y value for cursor in main menu
tbl_menu_cursor_y:
	.byte $74, $A4

; -----------------------------------------------------------------------------

; Called when Machine State is 0,1,?
sub_option_menu_states:
	lda zp_machine_state_2
	jsr sub_trampoline
; ----------------
	.word sub_options_menu_init		; 0,1,0
	.word sub_menu_fade_in			; 0,1,1
	.word sub_options_menu_loop		; 0,1,2
	.word sub_menu_fade_out			; 0,1,3
	.word sub_back_to_main			; 0,1,4

	.word sub_menu_fade_out			; 0,1,5
	.word sub_sound_test_init		; 0,1,6
	.word sub_menu_fade_in			; 0,1,7
	.word sub_sound_test_input_loop	; 0,1,8
	.word sub_menu_fade_out			; 0,1,9
	.word sub_back_to_main			; 0,1,A

; -----------------------------------------------------------------------------

sub_options_menu_init:
	lda #$01
	jsr sub_init_screen_common
	
	lda #$00
	sta mmc3_mirroring

	;lda ram_difficulty_setting
	;sta zp_plr2_selection
	;jsr sub_option_menu_cursor

	; Set the latch depending on chosen setting to "highlight" the appropriate
	; area of the screen (by switching nametables)
	ldx ram_difficulty_setting
	stx zp_plr2_selection	; Also set default selection
	lda tbl_option_menu_latches,X
	sta ram_irq_latch_value

	; Show cursor at the default selection position
	lda #$94
	sta ram_oam_copy_tileid
	jsr sub_option_menu_cursor

	inc zp_machine_state_2
	rts

; -----------------------------------------------------------------------------

sub_options_menu_loop:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	beq @options_menu_loop_end
		; Only executed once per frame
		sta zp_last_execution_frame

		jsr sub_get_controller1_options_menu
		jsr sub_option_menu_cursor
		lda zp_controller1_new
		and #$D0	; A, B or START
		beq sub_options_menu_loop

		lda zp_plr2_selection
		
		cmp #$05	; Option < 5 = Difficulty setting
		bcs :+
			; Apply selection
			ldx zp_plr2_selection
			stx ram_difficulty_setting
			lda tbl_option_menu_latches,X
			sta ram_irq_latch_value
			;jmp sub_options_menu_loop
			bne sub_options_menu_loop
		:
		; Option >= 5 Sound Test or Exit
		;cmp #$05
		bne :+
			; Option 5 = Sound Text
			;lda #$05 happens to match the substate index
			sta zp_machine_state_2
			rts
		:
		; Option 6 = Exit
		inc zp_machine_state_2
		lda #$05
		sta zp_palette_fade_idx
	@options_menu_loop_end:
	rts

; -----------------------------------------------------------------------------

sub_back_to_main:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	beq @back_to_main_end
		; Only executed once per frame
		sta zp_last_execution_frame
		
		; Switch to state 0,0,4 (main menu init)
		lda #$0C
		sta ram_irq_routine_idx
		lda #$00
		sta PpuMask_2001
		sta zp_machine_state_2
		;lda #$00
		sta zp_machine_state_1
		lda #$04
		sta zp_machine_state_2
	@back_to_main_end:
	rts

; -----------------------------------------------------------------------------

; Handles controller 1 input for options menu
; Returns:
; zp_plr2_selection = selection index (0-5)
sub_get_controller1_options_menu:
	;lda #$01
	;asl A
	;tax
	;lda rom_04_9CAD+0,X
	lda tbl_menu_indices_ptrs+2
	sta zp_ptr1_lo
	;lda rom_04_9CAD+1,X
	lda tbl_menu_indices_ptrs+3
	sta zp_ptr1_hi

	lda zp_controller1_new
	sta zp_06
	lda zp_plr2_selection
	sta zp_05
	jsr sub_ctrl_to_idx
	bmi :+
		; If index is valid, save new selection
		sta zp_plr2_selection
		lda #$03	; Cursor bleep SFX
		sta ram_req_sfx
	:
	rts

; -----------------------------------------------------------------------------

; Shows/updates the cursor sprite for the options menu
sub_option_menu_cursor:
	lda zp_plr2_selection
	asl A
	tax
	lda @tbl_options_menu_cursor_pos+0,X
	sta ram_oam_copy_ypos
	lda @tbl_options_menu_cursor_pos+1,X
	sta ram_oam_copy_xpos
	
	lda zp_frame_counter
	and #$02
	bne @skip_crsr_anim
		lda ram_oam_copy_tileid
		clc
		adc #$02
		cmp #$A1
		bcc :+
			lda #$94
		:
		sta ram_oam_copy_tileid

	@skip_crsr_anim:
	lda #$03
	sta ram_oam_copy_attr
	rts

; ----------------

; Two bytes per entry: Y position, X position
	@tbl_options_menu_cursor_pos:
	.byte $64, $54	; Very Easy
	.byte $74, $54	; Easy
	.byte $84, $54	; Normal
	.byte $94, $54	; Hard
	.byte $A4, $54	; Very Hard
	.byte $B4, $54	; Sound Test
	.byte $C4, $64	; Exit

; -----------------------------------------------------------------------------

; Aligned to menu options to "highlight" the selected one
tbl_option_menu_latches:
	.byte $60, $70, $80, $90, $A0

; -----------------------------------------------------------------------------

sub_sound_test_init:
	lda #$00
	sta ram_irq_state_var
	lda #$09
	jsr sub_init_screen_common

	lda #$00
	sta zp_plr1_selection	; Selected music track index
	sta zp_plr2_selection	; Selected sfx index
	sta ram_selected_opt		; Menu item selection (0-2)
	lda #$F0
	sta ram_oam_copy_tileid
	jsr sub_sound_test_cursor

	inc zp_machine_state_2
	rts

; -----------------------------------------------------------------------------

sub_sound_test_input_loop:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	beq @sound_test_input_end
		; Only execute once per frame
		sta zp_last_execution_frame

		jsr sub_get_controller1_sound_test
		jsr sub_sound_test_cursor
		
		lda zp_controller1_new
		bit @bit_03+1	; Check if bit 0 (right) or bit 1 (left) is set
		beq :+
			; Left/right to change selection
			@bit_03:
			and #$03
			jmp sub_select_music_to_test
		:
		and #$D0	; A, B or START
		beq sub_sound_test_input_loop

		lda ram_selected_opt
		bne :+
			; Option zero
			; Start playing the selected song
			ldx zp_plr1_selection
			lda @tbl_test_mus_indices,X
			sta ram_req_song
			jsr sub_show_playing_song
			jmp sub_sound_test_input_loop
		:
		cmp #$02
		beq :+
			; Option 1
			; Start playing the selected sfx
			lda zp_plr2_selection
			sta ram_req_sfx
			jmp sub_sound_test_input_loop
		:
		; Option 2 = exit
		inc zp_machine_state_2
		lda #$05
		sta zp_palette_fade_idx
	@sound_test_input_end:
	rts

	@tbl_test_mus_indices:
	.byte $22, $20, $21, $23, $24, $25, $26, $27
	.byte $28, $29, $2A, $2B, $2C, $2D, $2E, $2F
	.byte $30

; -----------------------------------------------------------------------------

; Handles controller 1 input for sound test menu
; Returns:
; zp_selected_opt = selection index (0-2)
sub_get_controller1_sound_test:
	lda tbl_menu_indices_ptrs+8
	sta zp_ptr1_lo
	lda tbl_menu_indices_ptrs+9
	sta zp_ptr1_hi

	lda zp_controller1_new
	sta zp_06
	lda ram_selected_opt
	sta zp_05
	jsr sub_ctrl_to_idx
	bmi :+
		; If index is valid, save new selection
		sta ram_selected_opt
	:
	rts

; -----------------------------------------------------------------------------

; Shows/updates the cursor sprite for the options menu
sub_sound_test_cursor:
	lda ram_selected_opt
	asl A
	tax
	lda @tbl_sound_test_cursor_pos+0,X
	sta ram_oam_copy_ypos
	lda @tbl_sound_test_cursor_pos+1,X
	sta ram_oam_copy_xpos

	lda zp_frame_counter
	and #$01
	beq :+
		; Animate cursor
		lda ram_oam_copy_tileid
		clc
		adc #$01
		and #$F7
		sta ram_oam_copy_tileid
	:
	lda #$01
	sta ram_oam_copy_attr
	rts

; ----------------

; Two bytes per entry: Y position, X position
	@tbl_sound_test_cursor_pos:
	.byte $58, $34
	.byte $68, $34
	.byte $78, $34

; -----------------------------------------------------------------------------

sub_fighter_sel_states:
	lda zp_machine_state_2
	jsr sub_trampoline
; ----------------
; Indirect jump pointers
	.word sub_fighter_sel_init		; 0,2,0
	.word sub_fighter_sel_fade_in	; 0,2,1
	.word sub_fighter_sel_loop		; 0,2,2
	.word sub_fighter_sel_fade_out	; 0,2,3

; -----------------------------------------------------------------------------

sub_fighter_sel_init:
	ldy #$02
	sty zp_tmp_idx

	jsr sub_setup_new_screen
	jsr sub_ftr_sel_init_attributes

	lda #$FC
	sta zp_scroll_x

	lda #$00
	sta zp_scroll_y
	sta ram_irq_state_var

	sta zp_plr1_sel_prev
	sta zp_plr2_sel_prev

	; Will only (re)load sprite palettes when this is set
	inc ram_irq_counter_0
	; Same for player 2
	inc ram_irq_counter_1

	lda #$88
	sta PpuControl_2000
	sta zp_ppu_control_backup

	cli
	jsr sub_wait_vblank

	lda #$1E
	sta zp_ppu_mask_backup

	lda #$12 ;#$0C
	sta ram_irq_routine_idx

	lda #$A0 ;#$80
	sta ram_irq_latch_value

	inc zp_machine_state_2

	; Selection counters, used for flashing the cursor and checking if
	; a player has already selected their fighter
	lda #$00
	sta zp_5C
	sta zp_5D

	ldy #$00

	lda zp_plr1_selection
	and #$80
	ora @tbl_default_ftr_sel+0,Y
	sta zp_plr1_selection

	lda zp_plr2_selection
	and #$80
	ora @tbl_default_ftr_sel+1,Y
	sta zp_plr2_selection

	rts

; -----------------------------------------------------------------------------

	@tbl_default_ftr_sel:
	.byte $03, $04

; -----------------------------------------------------------------------------

sub_fighter_sel_fade_in:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$05
	bcs :+
		rts
; ----------------
	:
	inc zp_machine_state_2

	rts ;jmp sub_ftr_sel_cursors

; -----------------------------------------------------------------------------


sub_fighter_sel_loop:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	beq @B2DF_rts

		sta zp_last_execution_frame

		jsr sub_fighter_sel_input
		jsr sub_ftr_sel_cursors
		jsr sub_ftr_sel_attributes

		ldx #$00
		stx zp_plr_idx_param
		jsr sub_ftr_sel_sprites

		ldx #$01
		inc zp_plr_idx_param
		jsr sub_ftr_sel_sprites

		lda zp_5C
		cmp zp_5D
		bne @B2DF_rts

			cmp #$09
			bne @B2DF_rts

				; Both players have selected a fighter: go to fade out state
				inc zp_machine_state_2
				lda #$05
				sta zp_palette_fade_idx
	@B2DF_rts:
	rts

; -----------------------------------------------------------------------------

sub_fighter_sel_fade_out:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$09
	bcc @B2E0_rts
		lda #$00
		sta zp_machine_state_2
		inc zp_machine_state_1
	@B2E0_rts:
	rts

; -----------------------------------------------------------------------------

sub_fighter_sel_input:
	; First run: controller 1
	ldx #$00
	stx zp_07
	jsr @player_selection_input

	; Second run: controller 2
	ldx #$01
	stx zp_07
; ----------------
	@player_selection_input:
	lda zp_plr1_selection,X
	bpl :+
		; CPU opponent
		lda #$09
		sta zp_5C,X
		lda zp_controller1,X
		and #$0F
		beq @B352

		lda zp_plr1_selection,X
		and #$7F
		sta zp_plr1_selection,X
		lda #$00
		sta zp_5C,X
		sta zp_controller1_new,X
	:
	lda zp_5C,X
	bne @B352

		lda zp_controller1_new,X
		sta zp_06
		lda zp_plr1_selection,X
		sta zp_05

		lda zp_tmp_idx
		asl A
		tax
		lda tbl_menu_indices_ptrs+0,X
		sta zp_ptr1_lo
		lda tbl_menu_indices_ptrs+1,X
		sta zp_ptr1_hi

		; Why?
		;lda zp_06
		;sta zp_06
		;lda zp_05
		;sta zp_05

		jsr sub_ctrl_to_idx
		sta zp_05
		ldx zp_07
		lda zp_05
		bmi :+
			sta zp_plr1_selection,X
			lda #$03	; Bleep sound
			sta ram_req_sfx

			lda #$01	; (Re)load palettes
			sta ram_irq_counter_0,X
		:
		lda zp_controller1_new,X
		and #$C0
		beq @B352
			jsr sub_announce_fighter_name
			inc zp_5C,X
	@B352:
	lda zp_5C,X
	beq @B362_rts	; Check if cursor is flashing after selection

	cmp #$09
	bcs @B362_rts	; Check if it has already finished flashing

	lda zp_frame_counter
	and #$0F
	bne @B362_rts

		inc zp_5C,X

	@B362_rts:
	rts

; -----------------------------------------------------------------------------

sub_announce_fighter_name:
	ldy zp_plr1_selection,X
	lda @tbl_fighter_names_sfx+0,Y
	sta ram_req_sfx
	rts

	@tbl_fighter_names_sfx:
	.byte $13	; $00 Sub-zero
	.byte $15	; $01 Kano
	.byte $14	; $02 Scorpion
	.byte $11	; $03 Raiden
	.byte $16	; $04 Johnny Cage
	.byte $17	; $05 Liu Kang
	.byte $12	; $06 Sonya
	.byte $00	; $07 Shang-Tsung
	.byte $00	; $08 Goro

; -----------------------------------------------------------------------------

; Flashes the selection cursors if needed, otherwise jumps to the cursor
; update routine
sub_ftr_sel_cursors:
	;ldx #$00
	;stx zp_07
	;jsr sub_inner_ftr_sel_cursors	; First run for player 1

	;ldx #$01			; Second run for player 2
	;stx zp_07
	lda zp_frame_counter
	and #$01
	sta zp_07
	tax
; ----------------
;sub_inner_ftr_sel_cursors:
	lda zp_5C,X	; This will be set when that player has made a selection
	cmp #$06
	bcs :+

		jmp sub_ftr_sel_update_cursors

	:
	cmp #$08
	bne @ftr_sel_crsr_rts
		; Hide the cursor if fighter selected
		lda #$00	; PPU offset for player 1
		cpx #$00
		beq :+
			; PPU offset for player 2
			lda #$05
		:
		sta zp_var_x

		ldy #$00
		@erase_crsr_tiles:
			lda #$3C
			sta ram_ppu_minibuf_0+5,Y
			inx
		iny
		cpy #$06
		bcc @erase_crsr_tiles

		lda #$01	; Columns
		sta ram_ppu_minibuf_0+1
		lda #$06	; Rows
		sta ram_ppu_minibuf_0+2
		; Bytes of tile data to copy (columns * rows)
		sta ram_ppu_minibuf_0+0

		; Set address of location to clear
		ldx zp_07
		lda zp_plr1_sel_prev,X
		asl
		tay

		lda tbl_ftr_sel_addr+0,Y
		clc
		adc zp_var_x
		sta ram_ppu_minibuf_0+4

		lda tbl_ftr_sel_addr+1,Y
		sta ram_ppu_minibuf_0+3

	@ftr_sel_crsr_rts:
	rts

; -----------------------------------------------------------------------------

; Parameters:
; X = zp_07 = player index (0 or 1)
sub_ftr_sel_update_cursors:
	lda zp_plr1_selection,X
	bmi @update_cursors_rts ; Skip CPU opponent

	cmp zp_plr1_sel_prev,X
	beq @update_cursors_rts	; Return if selection hasn't changed

		lda #$00	; PPU offset for player 1
		cpx #$00
		beq :+
			; PPU offset for player 2
			lda #$05
		:
		sta zp_var_x

		; Show cursor at new location
		txa
		asl
		asl
		asl
		tax

		ldy #$00
		@copy_crsr_tiles:
			lda tbl_ftr_sel_tiles,X
			sta ram_ppu_minibuf_1+5,Y
			; Also clear previous location
			lda #$3C
			sta ram_ppu_minibuf_0+5,Y
			inx
		iny
		cpy #$06
		bcc @copy_crsr_tiles

		; Instruct the IRQ handler to draw the new BG tiles
		ldx zp_07
		lda zp_plr1_selection,X
		asl
		tay
		
		lda tbl_ftr_sel_addr+0,Y
		clc
		adc zp_var_x
		sta ram_ppu_minibuf_1+4

		lda tbl_ftr_sel_addr+1,Y
		sta ram_ppu_minibuf_1+3

		lda #$01	; Columns
		sta ram_ppu_minibuf_1+1
		sta ram_ppu_minibuf_0+1
		lda #$06	; Rows
		sta ram_ppu_minibuf_1+2
		sta ram_ppu_minibuf_0+2

		; Bytes of tile data to copy (columns * rows)
		sta ram_ppu_minibuf_1+0
		sta ram_ppu_minibuf_0+0

		; Set address of previous location to clear
		;ldx zp_07
		lda zp_plr1_sel_prev,X
		asl
		tay

		lda tbl_ftr_sel_addr+0,Y
		clc
		adc zp_var_x
		sta ram_ppu_minibuf_0+4

		lda tbl_ftr_sel_addr+1,Y
		sta ram_ppu_minibuf_0+3

		; Update selection
		lda zp_plr1_selection,X
		sta zp_plr1_sel_prev,X
	
	@update_cursors_rts:
	rts

; ----------------

; Cursor coordinates for each selectable character
tbl_ftr_sel_addr:
	.word $2067		; $00
	.word $206D		; $01
	.word $2073		; $02

	.word $2142		; $03
	.word $2148		; $04
	.word $214F		; $05
	.word $2156		; $06
	
	.word $2249		; $07
	.word $224F		; $08

; ----------------

tbl_ftr_sel_tiles:
	; Player 1 cursor tile IDs
	.byte $CC, $FD, $CD, $DD, $FD, $DC

	; Padding for 8-byte alignment
	.byte $00, $00

	; Player 2 cursor
	.byte $CE, $FD, $CF, $DF, $FD, $DE

; -----------------------------------------------------------------------------

; Loads the starting attribute table for the fighter selection screen in RAM
; This allows modifying it on the fly before uploading to the PPU
; (we need to read from it to OR current values with a different mask for
; each selectable fighter)
sub_ftr_sel_init_attributes:
	lda zp_tmp_idx
	asl A
	tax
	lda @tbl_attr_tables_ptrs+0,X
	sta zp_ptr1_lo
	lda @tbl_attr_tables_ptrs+1,X
	sta zp_ptr1_hi

	ldx #$40
	ldy #$00
	:
		lda (zp_ptr1_lo),Y
		sta ram_0680,Y
		iny
		dex
	bne :-

	rts

; ----------------
	
	@tbl_attr_tables_ptrs:
	.word attr_fighter_sel, rom_B516
	.word attr_fighter_sel, rom_B516

; ----------------

attr_fighter_sel:
	.byte $FF, $FF, $5F, $7F, $CF, $FF, $FF, $FF
	.byte $FF, $FF, $51, $77, $CC, $B3, $FF, $FF
	.byte $7F, $5F, $15, $57, $06, $9E, $AF, $FF
	.byte $37, $58, $03, $45, $AA, $D9, $C8, $FF
	.byte $FF, $FF, $FF, $75, $05, $FF, $FF, $FF
	.byte $FF, $FF, $7F, $57, $00, $FF, $FF, $FF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F

; ----------------

; Unused?
rom_B516:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $FF, $7F, $1F, $CF, $BF, $2F, $CF, $FF
	.byte $FF, $77, $11, $CC, $BB, $22, $CC, $FF
	.byte $77, $11, $44, $55, $11, $88, $22, $CC
	.byte $B7, $A1, $24, $05, $41, $58, $92, $EC
	.byte $BB, $AA, $22, $00, $44, $55, $99, $EE
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $0F

; -----------------------------------------------------------------------------

sub_ftr_sel_attributes:
	lda zp_tmp_idx
	asl A
	tay
	lda rom_B5BF+0,Y
	sta zp_ptr2_lo
	lda rom_B5BF+1,Y
	sta zp_ptr2_hi

	ldx #$00	; First run, player one
	lda zp_5C,X
	cmp #$05
	bne :+
		jsr sub_inner_ftr_sel_attr
	:
	ldx #$01	; Second run, player two
	lda zp_5C,X
	cmp #$05
	beq sub_inner_ftr_sel_attr

		rts
; ----------------
sub_inner_ftr_sel_attr:
	inc zp_5C,X
	lda zp_plr1_selection,X
	asl A
	tay
	lda (zp_ptr2_lo),Y
	sta zp_ptr1_lo
	iny
	lda (zp_ptr2_lo),Y
	sta zp_ptr1_hi

	ldy #$00
	lda (zp_ptr1_lo),Y
	@B58B:
		tax
		iny
		lda ram_0680,X
		ora (zp_ptr1_lo),Y
		sta ram_0680,X
		iny
		lda (zp_ptr1_lo),Y
	bpl @B58B

	lda #$23
	sta zp_nmi_ppu_ptr_hi
	lda #$C0
	sta zp_nmi_ppu_ptr_lo

	lda #$00
	sta zp_47
	lda #$30
	sta zp_nmi_ppu_cols
	lda #$01
	sta zp_nmi_ppu_rows

	ldx #$00
	;ldy #$00
	@B5B2:
		lda ram_0680,X
		sta ram_ppu_data_buffer,X
		inx
		;iny
		;cpy #$30
		cpx #$30
	bcc @B5B2

	rts

; -----------------------------------------------------------------------------

; TODO The second table is unused, we don't need a pointer to another pointer
rom_B5BF:
	.word rom_B5C7, rom_B5D9, rom_B5C7, rom_B5D9

; -----------------------------------------------------------------------------

; Pointers for fighter selection attribute tables used to change the colours
; of the selected fighter
rom_B5C7:
	.word attr_fgtr_0	; $00
	.word attr_fgtr_1	; $01
	.word attr_fgtr_2	; $02
	.word attr_fgtr_3	; $03
	.word attr_fgtr_4	; $04
	.word attr_fgtr_5	; $05
	.word attr_fgtr_6	; $06
	.word attr_fgtr_7	; $07
	.word attr_fgtr_8	; $08

; -----------------------------------------------------------------------------

; Potentially unused
rom_B5D9:
	.word rom_B636
;	.word rom_B63F, rom_B648, rom_B651
;	.word rom_B65A, rom_B663, rom_B66C, rom_B675
;	.word rom_B67E, rom_B687, rom_B690, rom_B699
;	.word rom_B6A2, rom_B6AB, rom_B6B4, rom_B6BD
;	.word rom_B6C6, rom_B6CF

; -----------------------------------------------------------------------------

; Data format (two bytes per entry):
; Attribute table offset, Attribute value OR mask
; Offset bit 7 set = stop

attr_fgtr_0:
	.byte $02, $FF
	.byte $0A, $FF
	.byte $12, $0F
	.byte $FF
attr_fgtr_1:
	.byte $03, $FF
	.byte $04, $FF
	.byte $0B, $FF
	.byte $0C, $FF
	.byte $13, $0F
	.byte $14, $0F
	.byte $FF
attr_fgtr_2:
	.byte $05, $FF
	.byte $0D, $FF
	.byte $15, $9F
	.byte $FF

attr_fgtr_3:
	.byte $10, $FF
	.byte $11, $FF
	.byte $18, $FF
	.byte $19, $FF
	.byte $FF
attr_fgtr_4:
	.byte $12, $F0
	.byte $13, $73
	.byte $1A, $FF
	.byte $1B, $77
	.byte $FF
attr_fgtr_5:
	.byte $14, $F4
	.byte $1C, $FF
	.byte $FF
attr_fgtr_6:
	.byte $15, $D0
	.byte $16, $FF
	.byte $1D, $DD
	.byte $1E, $FF
	.byte $FF

attr_fgtr_7:
	.byte $22, $FF
	.byte $23, $75
	.byte $2A, $FF
	.byte $2B, $77
	.byte $FF
attr_fgtr_8:
	.byte $24, $F5
	.byte $2C, $FF
	.byte $FF

; -----------------------------------------------------------------------------

rom_B636:
	.byte $09, $C0, $0A, $30, $11, $CC, $12, $33
	.byte $FF
;rom_B63F:
;	.byte $0A, $C0, $0B, $30, $12, $CC, $13, $33
;	.byte $FF
;rom_B648:
;	.byte $0C, $C0, $0D, $30, $14, $CC, $15, $33
;	.byte $FF
;rom_B651:
;	.byte $0D, $C0, $0E, $30, $15, $CC, $16, $33
;	.byte $FF
;rom_B65A:
;	.byte $18, $CC, $19, $33, $20, $0C, $21, $03
;	.byte $FF
;rom_B663:
;	.byte $19, $CC, $1A, $33, $21, $0C, $22, $03
;	.byte $FF
;rom_B66C:
;	.byte $1A, $CC, $1B, $33, $22, $0C, $23, $03
;	.byte $FF
;rom_B675:
;	.byte $1B, $CC, $1C, $33, $23, $0C, $24, $03
;	.byte $FF
;rom_B67E:
;	.byte $1C, $CC, $1D, $33, $24, $0C, $25, $03
;	.byte $FF
;rom_B687:
;	.byte $1D, $CC, $1E, $33, $25, $0C, $26, $03
;	.byte $FF
;rom_B690:
;	.byte $1E, $CC, $1F, $33, $26, $0C, $27, $03
;	.byte $FF
;rom_B699:
;	.byte $20, $C0, $21, $30, $28, $CC, $29, $33
;	.byte $FF
;rom_B6A2:
;	.byte $21, $C0, $22, $30, $29, $CC, $2A, $33
;	.byte $FF
;rom_B6AB:
;	.byte $22, $C0, $23, $30, $2A, $CC, $2B, $33
;	.byte $FF
;rom_B6B4:
;	.byte $23, $C0, $24, $30, $2B, $CC, $2C, $33
;	.byte $FF
;rom_B6BD:
;	.byte $24, $C0, $25, $30, $2C, $CC, $2D, $33
;	.byte $FF
;rom_B6C6:
;	.byte $25, $C0, $26, $30, $2D, $CC, $2E, $33
;	.byte $FF
;rom_B6CF:
;	.byte $26, $C0, $27, $30, $2E, $CC, $2F, $33
;	.byte $FF

; -----------------------------------------------------------------------------

; State machine for the Continue screen
sub_continue_screen_state_machine:
	lda zp_machine_state_2
	jsr sub_trampoline
; ----------------
; Jump pointers
	.word sub_continue_screen_init
	.word sub_rom_B712
	.word sub_rom_B723
	.word sub_rom_B776
	.word sub_rom_B789
	.word sub_continue_timer_expired
	.word sub_game_over

; -----------------------------------------------------------------------------

sub_continue_screen_init:
	lda #$05
	jsr sub_init_screen_common

	lda #$0C
	sta ram_irq_routine_idx
	lda #$80
	sta ram_irq_latch_value

	inc zp_machine_state_2
	rts

; -----------------------------------------------------------------------------

sub_rom_B712:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$05
	bcc @B712_end
		lda #$0A
		sta zp_counter_param
		inc zp_machine_state_2
	@B712_end:
	rts

; -----------------------------------------------------------------------------

sub_rom_B723:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	beq @B723_rts

		sta zp_last_execution_frame
		lda ram_040C
		eor #$01
		tax
		lda zp_controller1_new,X
		and #$C0
		beq @B744

		lda #$0F
		sta ram_req_sfx
		inc zp_machine_state_2
		lda #$05
		sta zp_palette_fade_idx

	@B723_rts:
	rts
; ----------------
	@B744:
	jsr sub_rom_B7C3
	lda zp_frame_counter
	and #$3F
	bne @B775

	lda #$10	; Countdown sound
	sta ram_req_sfx
	dec zp_counter_param
	bpl @B775

	lda zp_plr1_fighter_idx
	eor zp_plr2_fighter_idx
	and #$80
	bne @B767

	inc zp_machine_state_2
	inc zp_machine_state_2
	lda #$05
	sta zp_palette_fade_idx
	rts
; ----------------
	@B767:
	inc zp_machine_state_2
	inc zp_machine_state_2
	inc zp_machine_state_2
	lda #$03
	sta zp_counter_param
	lda #$8A
	sta zp_ppu_control_backup
	@B775:
	rts

; -----------------------------------------------------------------------------

sub_rom_B776:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$09
	bcc @B776_end

		lda #$00
		sta zp_machine_state_2
		lda #$02
		sta zp_machine_state_1

	@B776_end:
	rts

; -----------------------------------------------------------------------------

sub_rom_B789:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$09
	bcc @B789_end

		lda #$00
		sta zp_machine_state_2
		lda #$03
		sta zp_machine_state_1
		lda ram_040C
		eor #$01
		tax
		lda #$80
		sta zp_plr1_fighter_idx,X
		sta zp_plr1_selection,X

	@B789_end:
	rts

; -----------------------------------------------------------------------------

sub_continue_timer_expired:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	beq @B7C2
		sta zp_last_execution_frame
		lda zp_frame_counter
		and #$1F
		bne @B7C2

		dec zp_counter_param
		bne @B7C2

		lda #$23	; Game over music
		sta ram_req_song
		sta zp_counter_param	; Incidentally, it's also a good value for the counter
		inc zp_machine_state_2
	@B7C2:
	rts

; -----------------------------------------------------------------------------

sub_rom_B7C3:
	lda zp_counter_param
	asl A
	tax
	lda rom_B7E8+0,X
	sta ram_ppu_data_buffer
	lda rom_B7E8+1,X
	sta ram_ppu_data_buffer+1
	lda #$22
	sta zp_nmi_ppu_ptr_hi
	lda #$50
	sta zp_nmi_ppu_ptr_lo
	
	ldx #$00	;lda #$00
	stx zp_47	;sta zp_47
	inx			;lda #$01
	stx zp_nmi_ppu_cols	;sta zp_46
	inx			;lda #$02
	stx zp_nmi_ppu_rows	;sta zp_45

	rts

; -----------------------------------------------------------------------------

sub_game_over:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	beq @game_over_rts

		sta zp_last_execution_frame
		lda zp_frame_counter
		and #$1F
		bne @game_over_rts

			dec zp_counter_param
			bne @game_over_rts

				lda #$00
				sta zp_ppu_mask_backup
				jmp reset

	@game_over_rts:
	rts

; -----------------------------------------------------------------------------

rom_B7E8:
	.byte $26, $2F, $1F, $27, $30, $34, $23, $2C
	.byte $32, $36, $38, $39, $33, $37, $25, $2E
	.byte $24, $2D, $22, $2B, $22, $2B

; -----------------------------------------------------------------------------

sub_high_scores_states:
	lda zp_machine_state_2
	jsr sub_trampoline
; ----------------
; Jump pointers
	.word sub_high_scores_init
	.word sub_rom_B834
	.word sub_rom_B845
	.word sub_attract_choose_ftrs
	.word sub_rom_B8A5

; -----------------------------------------------------------------------------

sub_high_scores_init:
	lda #$04
	jsr sub_init_screen_common

	lda #$0C
	sta ram_irq_routine_idx
	sta ram_irq_latch_value

	inc zp_machine_state_2
	rts

; -----------------------------------------------------------------------------

sub_rom_B834:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$05
	bcc @B834_rts

		lda #$09
		sta zp_counter_param
		inc zp_machine_state_2

	@B834_rts:
	rts

; -----------------------------------------------------------------------------

sub_rom_B845:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	beq @B863

		sta zp_last_execution_frame
		lda zp_controller1_new
		beq @B857

		inc zp_machine_state_2
		jmp @B861

		@B857:
		lda zp_frame_counter
		and #$3F
		bne @B863

		dec zp_counter_param
		bpl @B863

		@B861:
		inc zp_machine_state_2

	@B863:
	rts

; -----------------------------------------------------------------------------

; Chooses two fighters for the attract mode
sub_attract_choose_ftrs:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$09
	bcc :+

		lda #$00
		sta PpuMask_2001
		sta zp_ppu_mask_backup
		lda #$00
		sta mmc3_mirroring
		lda #$00
		sta zp_machine_state_2
		lda #$00
		sta zp_machine_state_1
		lda #$01
		sta zp_machine_state_0
		lda #$01
		sta zp_5E
		lda zp_62
		and #$07
		tay
		lda @tbl_attract_mode_ftrs+0,Y
		sta zp_plr1_fighter_idx
		lda @tbl_attract_mode_ftrs+1,Y
		sta zp_plr2_fighter_idx
		inc zp_62

	:
	rts

; ----------------

	@tbl_attract_mode_ftrs:
	.byte $83, $82, $84, $85, $86, $87, $88, $85
	.byte $81

; -----------------------------------------------------------------------------

sub_rom_B8A5:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$09
	bcc @B8A5_rts

		lda #$00
		sta zp_machine_state_2
		lda #$00
		sta zp_machine_state_1
		sta zp_plr1_selection
		sta zp_plr2_selection

	@B8A5_rts:
	rts

; -----------------------------------------------------------------------------

sub_vs_state_machine:
	lda zp_machine_state_2
	jsr sub_trampoline
; ----------------
; Jump pointers
	.word sub_vs_state_init		; 0,2,0
	.word sub_vs_scr_init		; 0,2,1
	.word sub_vs_fade_in		; 0,2,2
	.word sub_vs_scr_loop		; 0,2,3
	.word sub_vs_fade_out		; 0,2,4

; -----------------------------------------------------------------------------

sub_vs_state_init:
	; Get next fighter selection for the CPU
	jsr sub_choose_opponent
	; If both fighters have already been selected, move to VS screen,
	; otherwise this will show the fighter selection screen
	ldx #$00
	lda zp_plr1_selection,X			; Player 1
	bmi @B8E2	; Branch if player 1 is CPU-controller

		inx
		lda zp_plr1_selection,X		; Player 2

	bmi @B8E2	; Branch if player 2 is CPU-controlled

		; This is only for 2 players mode
		; inc zp_machine_state_2
		lda #$00
		sta zp_match_number
		sta zp_match_type
		; Skip the Battle Plan altogether
		lda #$09
		sta zp_palette_fade_idx
		lda #$04
		sta zp_machine_state_2

	rts
; ----------------
	; Parameters:
	; X = index of CPU opponent (0/1)
	@B8E2:
	lda zp_match_type
	bne :+
		lda #$00
		sta zp_endurance_opp_idx

		ldy zp_match_number
		lda ram_opponent_idx,Y
		jmp @B917_set_opponent
	:
	cmp #$01
	bne :+
		ldy zp_match_number
		lda ram_06C3,Y
		ora #$80
		sta zp_endurance_opp_idx

		lda ram_opponent_idx,Y
		jmp @B917_set_opponent
	:
	tay
	lda #$00
	sta zp_endurance_opp_idx

	lda tbl_boss_sel_idx,Y

	@B917_set_opponent:
	ora #$80
	sta zp_plr1_selection,X
	inc zp_machine_state_2
	rts

; -----------------------------------------------------------------------------

tbl_boss_sel_idx:
	.byte $08, $07, $08, $07

; -----------------------------------------------------------------------------

sub_vs_scr_init:
	lda zp_match_type
	beq :+	; Endurance and boss fights start from the top

		lda #$88
		bne @B956_prepare_scr
	:

	lda zp_match_number
	bne :+
		lda #$88
		bne @B956_prepare_scr	; First match starts from the top too
	:
	lda #$8A
	
	@B956_prepare_scr:
	sta ram_0680
	lda #$03
	jsr sub_init_screen_common
	jsr sub_vs_scr_portraits
	jsr sub_vs_scr_sprites

	lda #$00
	sta zp_pal_mask_idx
	sta zp_palette_fade_idx
	sta zp_scroll_x

	; Choose appropriate vertical scroll value for current match
	lda #$00
	ldx zp_match_type
	beq @vs_init_scroll

		cpx #$01
		bne :+
			; Endurance matches
			ldx zp_match_number
			lda @tbl_starting_y_scroll+0,X
			bne @vs_init_scroll	; Must branche always
		:
		; X will be 2 for Goro, 3 for Shang Tsung
		lda @tbl_starting_y_scroll+1,X

	@vs_init_scroll:
	sta zp_scroll_y

	lda #$88
	sta PpuControl_2000
	sta zp_ppu_control_backup

	cli
	jsr sub_wait_vblank

	lda #$1E
	sta zp_ppu_mask_backup

	lda ram_0680	; Select nametable
	sta zp_ppu_control_backup

	lda #$0C
	sta ram_irq_routine_idx
	sta ram_irq_latch_value

	inc zp_machine_state_2

	rts

	@tbl_starting_y_scroll:
	.byte $D0	; Endurance 1
	.byte $A0	; Endurance 2
	.byte $80	; Endurance 3
	.byte $60	; Goro
	.byte $28	; Shang Tsung

; -----------------------------------------------------------------------------

sub_vs_fade_in:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$05
	bcc @B982_rts

		inc zp_machine_state_2
		lda #$00
		sta zp_counter_param

	@B982_rts:
	rts

; -----------------------------------------------------------------------------

sub_vs_scr_loop:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	bne :+
		rts
	:
	sta zp_last_execution_frame
	lda zp_controller1_new
	and #$F0	; Press a button to skip the wait
	beq @vs_loop_controller

		@B9AE_skip_wait:
		lda #$00
		sta zp_counter_param
		inc zp_machine_state_2
		rts
		; ----

	@vs_loop_controller:
	lda zp_controller2_new
	and #$F0	; Press a button to skip the wait
	bne @B9AE_skip_wait

		lda zp_counter_param
		beq :+
			; Little pause before fading out
			dec zp_counter_param
			beq @B9AE_skip_wait
			bne @B9B4_rts
		:
		; Scroll the screen if needed
		lda zp_match_type
		bne @vs_move_up

			lda zp_match_number
			bne @vs_move_up

			; Move down

				; Move the player portrait to the desired position
				lda ram_oam_copy_ypos+0
				cmp @tbl_target_spr_y+0
				bcs :+
					ldx #$0C
					@spr_down_loop:
						inc ram_oam_copy_ypos+0,X
						inc ram_oam_copy_ypos+16,X
						txa
						axs #$04
					bpl @spr_down_loop

					rts
				:
				; Scroll the screen downwards
				lda #$F0
				isc zp_scroll_y
				bne :+
					lda #$78	; Wait 2 seconds (120 frames) before fading out
					sta zp_counter_param

					lda #$8A	; Bottom nametable
					sta zp_ppu_control_backup
					lda #$00
					sta zp_scroll_y
				:
				rts


		@vs_move_up:

		; Move up

		; Keep moving the player portrait until it has reached its target coordintes
		lda zp_match_type
		asl
		tax
		lda @tbl_target_spr_y_ptrs+0,X
		sta zp_ptr1_lo
		lda @tbl_target_spr_y_ptrs+1,X
		sta zp_ptr1_hi

		ldy zp_match_number
		lda (zp_ptr1_lo),Y
		cmp ram_oam_copy_ypos+0
		beq :+	; Skip if coordinates have been reached
			ldx #$0C
			@spr_up_loop:
				dec ram_oam_copy_ypos+0,X
				dec ram_oam_copy_ypos+16,X
				txa
				axs #$04
			bpl @spr_up_loop

			rts
		:
		; Scroll the screen upwards for endurance and boss matches
		lda zp_match_type
		beq @vs_scroll_done
			asl
			tax
			lda @tbl_target_scroll_ptrs+0,X
			sta zp_ptr1_lo
			lda @tbl_target_scroll_ptrs+1,X
			sta zp_ptr1_hi

			ldy zp_match_number

			lda (zp_ptr1_lo),Y
			cmp zp_scroll_y
			beq @vs_scroll_done

				dec zp_scroll_y
				rts

		@vs_scroll_done:
		lda #$78	; 2 seconds wait
		sta zp_counter_param

	@B9B4_rts:
	rts

; ----------------

	@tbl_target_spr_y_ptrs:
	.word @tbl_target_spr_y
	.word @tbl_target_spr_y_end
	.word @tbl_target_spr_y_goro
	.word @tbl_target_spr_y_shang

	; Target Y coordinate where to move the player portrait for each match
	@tbl_target_spr_y:
	.byte $CF, $AF, $8F, $6F, $4F, $2F, $0B

	@tbl_target_spr_y_end:
	; Endurance matches
	.byte $0F, $0F, $0F

	@tbl_target_spr_y_goro:
	; Goro
	.byte $2F

	@tbl_target_spr_y_shang:
	; Shang Tsung
	.byte $27

; ----------------

	@tbl_target_scroll_ptrs:
	.byte $FF, $FF
	.word @tbl_target_scroll_y
	.word @tbl_target_scroll_y_goro
	.word @tbl_target_scroll_y_shang

	; Target Y scroll for endurance and boss fights
	@tbl_target_scroll_y:
	.byte $C0, $A0, $80

	@tbl_target_scroll_y_goro:
	.byte $28

	@tbl_target_scroll_y_shang:
	; Bosses
	.byte $00

; -----------------------------------------------------------------------------

sub_vs_fade_out:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$09
	bcc @B9B5_end

		lda #$00
		sta zp_ppu_mask_backup
		sta PpuMask_2001
		lda #$00
		sta mmc3_mirroring
		lda #$00
		sta zp_machine_state_2
		lda #$00
		sta zp_machine_state_1
		jsr sub_rom_BE9F
		lda #$01
		sta zp_machine_state_0

	@B9B5_end:
	rts

; -----------------------------------------------------------------------------

; Shows the player's portrait as a sprite
; Coordinates will be chosen depending on current match type/number
sub_vs_scr_sprites:
	ldy zp_plr1_selection
	bpl :+	; If player 1 is AI-controlled, use player 2's portrait
		ldy zp_plr2_selection
	:
	
	lda @tbl_vs_sprite_tiles,Y
	sta zp_ptr1_lo	; Left
	sta zp_ptr1_hi
	inc zp_ptr1_hi	; Right


	; Initial Y position

	ldx zp_match_number

	lda zp_match_type
	beq :++		; Skip for regular matches
		cmp #$01
		bne :+
			; Endurance
			txa
			clc
			adc #$07
			tax
			bne :++
		:
		; Bosses
		txa
		clc
		adc #$0A
		tax
	:
	lda @tbl_initial_sprite_y,X
	sta zp_var_y	; Initial Y coordinate


	ldx #$00
	@vs_spr_loop:
		; Left
		lda zp_var_y
		sta ram_oam_copy_ypos+0,X
		sta ram_oam_copy_ypos+16,X	; Background sprite
		; Right
		sta ram_oam_copy_ypos+4,X
		sta ram_oam_copy_ypos+20,X

		lda zp_ptr1_lo
		sta ram_oam_copy_tileid+0,X
		lda zp_ptr1_hi
		sta ram_oam_copy_tileid+4,X

		lda #$1F
		sta ram_oam_copy_tileid+16,X
		sta ram_oam_copy_tileid+20,X
		
		lda @tbl_vs_sprite_attr,Y
		sta ram_oam_copy_attr+0,X
		sta ram_oam_copy_attr+4,X

		lda #$03
		sta ram_oam_copy_attr+16,X
		sta ram_oam_copy_attr+20,X

		; Left
		lda #$2A
		sta ram_oam_copy_xpos+0,X
		sta ram_oam_copy_xpos+16,X
		; Right
		lda #$32
		sta ram_oam_copy_xpos+4,X
		sta ram_oam_copy_xpos+20,X

		; Next row
		lda zp_var_y
		clc
		adc #$08
		sta zp_var_y

		lda zp_ptr1_lo
		adc #$10
		sta zp_ptr1_lo

		lda zp_ptr1_hi
		adc #$10
		sta zp_ptr1_hi

		; X = X + 8
		txa
		axs #$F8
		cpx #$09
	bcc @vs_spr_loop

	rts

; ----------------

	; Index of first tile for each fighter
	@tbl_vs_sprite_tiles:
	.byte $20, $22, $24, $26, $28, $2A, $2C, $2E, $40

	; Attribute values for each fighter's sprite
	@tbl_vs_sprite_attr:
	.byte $01, $01, $02, $01, $00, $02, $00, $01, $02

	@tbl_initial_sprite_y:
	.byte $2F, $CF, $AF, $8F, $6F, $4F, $2F

	; Endurance
	.byte $2F, $31, $2F

	; Goro and Shang Tsung
	.byte $2F

; -----------------------------------------------------------------------------

; Shows fighter portraits on the Battle Plan screen
sub_vs_scr_portraits:
	lda zp_plr1_selection
	bpl :+
		lda zp_plr2_selection
	:
	sta zp_07

	lda PpuControl_2000

	ldx #$00
	ldy #$00
	@vs_regular_potraits:
		; Top-Left
		lda @tbl_vs_portr_ppu_ofs+1,Y
		sta zp_ptr1_hi
		sta PpuAddr_2006
		lda @tbl_vs_portr_ppu_ofs+0,Y
		sta zp_ptr1_lo
		sta PpuAddr_2006

		lda ram_opponent_idx,X
		asl
		adc #$20
		sta zp_05
		sta PpuData_2007

		; Top-Right

		lda zp_05
		adc #$01
		sta PpuData_2007

		; Bottom-Left
		lda zp_ptr1_hi
		sta PpuAddr_2006

		lda zp_ptr1_lo
		adc #$20
		sta PpuAddr_2006

		lda zp_05
		adc #$10
		sta PpuData_2007

		; Bottom-Right

		lda zp_05
		adc #$11
		sta PpuData_2007

		; Attribute
		lda @tbl_vs_portr_attr_ofs+1,Y
		sta PpuAddr_2006
		lda @tbl_vs_portr_attr_ofs+0,Y
		sta PpuAddr_2006

		sty zp_backup_y		; Preserve Y
		; ----
		
		lda ram_opponent_idx,X
		tay
		lda @tbl_vs_portr_attr_value,Y
		sta PpuData_2007

		; Name
		lda ram_opponent_idx,X
		cmp zp_07
		bne :+
			; If opponent's index is same as player's type "mirror match"
			lda #<@str_mirror_match
			sta zp_ptr2_lo
			lda #>@str_mirror_match
			sta zp_ptr2_hi
			jmp @vs_print_name
		:
		asl
		tay
		lda @tbl_vs_names_ptrs+0,Y
		sta zp_ptr2_lo
		lda @tbl_vs_names_ptrs+1,Y
		sta zp_ptr2_hi

		@vs_print_name:
		ldy #$00
		:
			lda zp_ptr1_hi
			sta PpuAddr_2006
			tya
			clc
			adc zp_ptr1_lo
			adc #$04
			sta PpuAddr_2006

			lda (zp_ptr2_lo),Y
			beq :+	; Check for string terminator
			sta PpuData_2007

			; Bottom half of the name
			lda zp_ptr1_hi
			sta PpuAddr_2006
			tya
			clc
			adc #$24
			adc zp_ptr1_lo
			sta PpuAddr_2006

			lda (zp_ptr2_lo),Y
			adc #$20
			sta PpuData_2007

			iny
			bne :-
		:

		; ----
		ldy zp_backup_y		; Restore Y

		iny
		iny
		inx
		cpx #$07
		beq @vs_endurance_portraits
	jmp @vs_regular_potraits

	@vs_endurance_portraits:
	; Endurance opponent portraits
	ldx #$00	; Opponent index (0-6)
	ldy #$00	; Pointer index
	@vs_end_portr_loop:
		lda @tbl_vs_portr_ppu_ofs+15,Y
		sta zp_ptr1_hi
		sta PpuAddr_2006
		lda @tbl_vs_portr_ppu_ofs+14,Y
		sta zp_ptr1_lo
		sta PpuAddr_2006

		; Top-Left
		lda ram_opponent_idx,X
		asl
		adc #$20
		sta zp_05
		sta PpuData_2007

		; Top-Right
		lda zp_05
		clc
		adc #$01
		sta PpuData_2007

		; Bottom-Left
		lda zp_ptr1_hi
		sta PpuAddr_2006
		lda zp_ptr1_lo
		adc #$20
		sta PpuAddr_2006

		lda zp_05
		adc #$10
		sta PpuData_2007

		; Bottom-Right
		lda zp_05
		adc #$11
		sta PpuData_2007

		; Attributes

		lda @tbl_vs_portr_attr_ofs+15,Y
		sta PpuAddr_2006
		lda @tbl_vs_portr_attr_ofs+14,Y
		sta PpuAddr_2006

		sty zp_backup_y
		
			ldy ram_opponent_idx,X
			lda @tbl_vs_portr_attr_value+7,Y
			sta PpuData_2007

		ldy zp_backup_y

		iny
		iny
		inx
		cpx #$06
	bne @vs_end_portr_loop

	rts

; ----------------

	@tbl_vs_portr_ppu_ofs:
	.word $2B4A		; Opponent 0
	.word $2ACA		; Opponent 1
	.word $2A4A		; Opponent 2
	.word $29CA		; Opponent 3
	.word $294A		; Opponent 4
	.word $28CA		; Opponent 5
	.word $284A		; Opponent 6

	; Endurance opponents
	.word $2348		; 0, 0
	.word $22C8		; 1, 0
	.word $2248		; 2, 0
	.word $234C		; 0, 1
	.word $22CC		; 1, 1
	.word $224C		; 2, 1

	@tbl_vs_portr_attr_ofs:
	.word $2BF2		; 0
	.word $2BEA		; 1
	.word $2BE2		; 2
	.word $2BDA		; 3
	.word $2BD2		; 4
	.word $2BCA		; 5
	.word $2BC2		; 6

	; Endurance opponents
	.word $23F2
	.word $23EA
	.word $23E2
	.word $23F3
	.word $23EB
	.word $23E3

	; $40 = blue
	; $80 = yellow
	; $C0 = red
	@tbl_vs_portr_attr_value:
	.byte $40, $40, $80, $40, $40, $C0, $80

	; Endurance opponents
	; $10 = blue
	; $20 = yellow
	; $30 = red
	.byte $10, $10, $20, $10, $10, $30, $20

	@tbl_vs_names_ptrs:
	.word @str_vs_subzero
	.word @str_vs_kano
	.word @str_vs_scorpion
	.word @str_vs_raiden
	.word @str_vs_cage
	.word @str_vs_liukang
	.word @str_vs_sonya

	@str_vs_subzero:
	.byte "sub-zero", $00
	@str_vs_kano:
	.byte "kano", $00
	@str_vs_scorpion:
	.byte "scorpion", $00
	@str_vs_raiden:
	.byte "raiden", $00
	@str_vs_cage:
	.byte "johnny_cage", $00
	@str_vs_liukang:
	.byte "liu_kang", $00
	@str_vs_sonya:
	.byte "sonya", $00

	@str_mirror_match:
	.byte "mirror_match", $00

; -----------------------------------------------------------------------------

sub_choose_opponent:
	lda zp_plr1_selection
	bpl :+
		; Use player 2 if player 1 is CPU opponent
		lda zp_plr2_selection
	:
	sta zp_05	; Store player selection index in temp variable
	sta ram_mirror_opp_idx	; Save it as mirror match opponent

	and #$7F	; Remove AI flag if present
	tay

	lda tbl_num_opponents,Y
	sta zp_07	; Number of matches to fight excluding endurance, mirror and bosses

	ldx #$00
	ldy #$00
	@BE30_loop:
	; TODO Use a random list
	lda tbl_opponent_indices,X
	cmp zp_05
	bne :+
		; Skip opponent if same as player (mirror match is handled separately)
		inx
		bne @BE30_loop	; Always branches
	:
	sta ram_opponent_idx,Y	; Will fill in the table from 0 to 5 (or 6)
	iny
	inx
	dec zp_07
	bne @BE30_loop

	rts

; ----------------

; Looks like Goro and Shang-Tsung play one more match, but that is because
; they have no mirror match, so they just fight all regular opponents
tbl_num_opponents:
	.byte $06, $06, $06, $06, $06, $06, $06
	.byte $07, $07

; This the list of opponent selections, excluding Goro and Shang-Tsung
tbl_opponent_indices:
	.byte $00, $01, $02, $03, $04, $05, $06

; -----------------------------------------------------------------------------

sub_rom_BE9F:
	lda zp_plr1_selection
	and #$80
	sta zp_plr1_fighter_idx

	lda zp_plr2_selection
	and #$80
	sta zp_plr2_fighter_idx

	lda zp_endurance_opp_idx
	and #$80
	sta zp_60

	lda zp_plr1_selection
	and #$7F
	tay
	lda tbl_sel_to_ftr_idx,Y
	ora zp_plr1_fighter_idx
	sta zp_plr1_fighter_idx

	lda zp_plr2_selection
	and #$7F
	tay
	lda tbl_sel_to_ftr_idx,Y
	ora zp_plr2_fighter_idx
	sta zp_plr2_fighter_idx
	lda zp_endurance_opp_idx
	beq :+
		and #$7F
		tay
		lda tbl_sel_to_ftr_idx,Y
		ora zp_60
	:
	sta zp_60
	rts

; -----------------------------------------------------------------------------
.export tbl_sel_to_ftr_idx

tbl_sel_to_ftr_idx:
	.byte $02, $04, $03, $00, $05, $06, $01, $08
	.byte $07

; -----------------------------------------------------------------------------

sub_ending_states:
	lda zp_machine_state_2
	jsr sub_trampoline
; ----------------
; Jump pointers
	.word sub_ending_init
	.word sub_ending_fade_in
	.word sub_ending_loop

; -----------------------------------------------------------------------------

sub_ending_init:
	lda #$06
	jsr sub_init_screen_common

	; Not needed: init_screen_common calls setup_new_screen which does that
	;lda #$01
	;sta mmc3_mirroring

	ldy #$80
	lda ram_difficulty_setting
	cmp #$02
	bcs @BF55

		ldy #$8A
	@BF55:
	sty zp_ppu_control_backup
	lda #$0C
	sta ram_irq_routine_idx
	sta ram_irq_latch_value
	inc zp_machine_state_2
	lda #$14
	sta zp_counter_param
	rts

; -----------------------------------------------------------------------------

sub_ending_fade_in:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$05
	bcc :+
		inc zp_machine_state_2
	:
	rts

; -----------------------------------------------------------------------------

sub_ending_loop:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$09
	bcc @ending_loop_rts

		dec zp_counter_param
		beq :+

			; Fade out
			ldy #$00
			sty zp_palette_fade_idx
			iny
			sty zp_machine_state_2
			rts
		; ----------------
		:
		lda #$00
		sta zp_machine_state_2
		sta zp_machine_state_1
		sta zp_machine_state_0

	@ending_loop_rts:
	rts

; -----------------------------------------------------------------------------

; Called when Machine State is 0,0,0
sub_titles_screen_init:
	lda #$08	; Index of palette, nametable and IRQ handler pointers
	;sta zp_tmp_idx
	jsr sub_init_screen_common

	; Redundant, already hidden
	;jsr sub_hide_all_sprites

	lda #$7C
	sta ram_irq_latch_value

	inc zp_machine_state_2	; Move to next sub-state

	rts

; -----------------------------------------------------------------------------

; Machine state: 0,0,1
sub_titles_fade_in:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$05
	bcs :+
		; Palettes are still cycling
		rts
	; ----------------
	:
	; Palettes have finished cycling
	inc zp_machine_state_2	; Move to next sub-state
	lda #$03	; Wait timer for titles screen
	sta zp_counter_param
	rts

; -----------------------------------------------------------------------------

; Called when Machine State is 0,0,2
; Fades out the titles on controller press, or when the timer expires
sub_titles_loop:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	beq @BFE9_rts

		sta zp_last_execution_frame

		lda zp_controller1_new
		and #$D0	; A, B or START
		bne :+
			lda zp_frame_counter
			and #$1F
			bne @BFE9_rts
			dec zp_counter_param
			bne @BFE9_rts
		:
		lda #$00
		sta zp_counter_param
		inc zp_machine_state_2	; Move to next sub-state

	@BFE9_rts:
	rts

; -----------------------------------------------------------------------------
