.segment "BANK_05b"
; $B000-$BFFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"


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
	.word sub_fighter_selection_states	; 0,2
	.word sub_vs_state_machine				; 0,3
	.word sub_continue_screen_state_machine	; 0,4
	.word sub_high_scores_states		; 0,5
	.word sub_rom_BF1E					; 0,6

; -----------------------------------------------------------------------------

; Called when Machine State is 0,0,?
sub_main_menu_states:
	lda zp_machine_state_2
	jsr sub_trampoline    ; Same trick again
; ----------------
	.word sub_init_titles_screen	; 0,0,0
	.word sub_titles_fade_in		; 0,0,1
	.word sub_titles_loop			; 0,0,2
	.word sub_menu_fade_out 		; 0,0,3

	.word sub_init_menu_screen		; 0,0,4
	.word sub_menu_fade_in			; 0,0,5
	.word sub_menu_slide_up			; 0,0,6
	.word sub_menu_screen_shake		; 0,0,7
	.word sub_main_menu_loop		; 0,0,8
	.word sub_menu_fade_out			; 0,0,9
	.word sub_eval_menu_choice		; 0,0,A
	.word sub_fade_to_high_scores	; 0,0,B

; -----------------------------------------------------------------------------

; Machine state = 0,0,4
sub_init_menu_screen:
	lda #$00
	;sta zp_tmp_idx
	;lda #$00
	sta zp_66
	jsr sub_init_screen_common

	; Switch to vertical mirroring
	;lda #$01
	;sta mmc3_mirroring

	lda #$0D
	sta ram_irq_routine_idx
	lda #$ED
	sta ram_irq_latch_value
	
	lda #$00
	sta zp_endurance_flag
	sta zp_61
	;lda #$00
	sta zp_plr1_selection
	lda #$02
	sta zp_plr2_selection

	; Move "cursor" to default selection (left)
	lda tbl_menu_cursor_ptrs+0
	sta zp_ppu_ptr_hi
	lda tbl_menu_cursor_ptrs+1
	sta zp_ppu_ptr_lo

	inc zp_machine_state_2	; Move to next sub-state

	lda #$00
	sta zp_5E
	rts

; -----------------------------------------------------------------------------

; Machine state = 0,0,5 and 0,1,1
; Used to fade in the Main Menu and Options Menu
sub_menu_fade_in:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$05
	bcc @menu_fade_in_end
		; Palettes still cycling
		;rts
; ----------------
	
	; Fade in complete
	inc zp_machine_state_2	; Move to next sub-state
	@menu_fade_in_end:
	rts

; -----------------------------------------------------------------------------

; Machine state = 0,0,6
; Gradually increases the latch value, making the bottom part of the menu
; screen slide upwards
sub_menu_slide_up:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	beq @menu_slide_end
		; Already executed this frame
		;rts
; ----------------
	
	sta zp_last_execution_frame
	;dec ram_irq_latch_value
	;lda ram_irq_latch_value
	;cmp #$8B
	;bcs :+
	lda #$8C
	dcp ram_irq_latch_value
	bcc @menu_slide_end
		lda #$8C
		sta ram_irq_latch_value
		; Prepare the counter for the screen shake effect
		lda #$07
		sta zp_counter_param
		; Advance to next sub-state
		inc zp_machine_state_2
	@menu_slide_end:
	rts

; -----------------------------------------------------------------------------

; Machine state = 0,0,7
; Makes the screen "shake" when the bottom half of the main menu hits the top
sub_menu_screen_shake:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	beq @screen_shake_end
		; Already executed during this frame
		;rts
; ----------------

	sta zp_last_execution_frame
	
	ldx zp_counter_param
	lda @tbl_scroll_shake_values,X
	sta zp_scroll_y

	dec zp_counter_param
	bpl @screen_shake_end
		; Counter underflow: we have finished shaking the screen
		lda #$00
		sta zp_scroll_y
		; Prepare wait counter (when expired, it will show high scores)
		lda #$0A
		sta zp_counter_param
		; Advance to next sub-state
		inc zp_machine_state_2
	@screen_shake_end:
	rts

; ----------------

	@tbl_scroll_shake_values:
	.byte $00, $02, $00, $03, $00, $04, $00, $07

; -----------------------------------------------------------------------------

; Called when Machine State is 0,0,8
sub_main_menu_loop:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	beq @main_menu_loop_end
		; Already executed during this frame
		;rts
; ----------------
	sta zp_last_execution_frame

	lda zp_frame_counter
	and #$3F
	bne :+

		dec zp_counter_param
		bpl :+
			; Wait counter expired: show high score screen
			lda #$0B
			sta zp_machine_state_2	; 0,0,B = Fake high scores
			rts
; ----------------
	:
	jsr sub_get_controller1_main_menu

	lda zp_plr1_selection	; 0 = left selection, 1 = right selection
	asl A
	tax
	lda tbl_menu_cursor_ptrs+0,X
	sta zp_ppu_ptr_hi
	lda tbl_menu_cursor_ptrs+1,X
	sta zp_ppu_ptr_lo

	lda zp_controller1_new
	and #$D0	; A, B or START
	beq sub_main_menu_loop

	; ---- End of loop: a button was pressed

	;lda #$31	; This will stop music and play the "selection" sound instead
	;sta ram_req_song
	; TODO Use a DMC "gong" sample?
	lda #$0C	; "Select" sound
	sta ram_req_sfx

	inc zp_machine_state_2
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
		lda #$03 	; Player 1 default selection (Kano)
		sta zp_plr1_selection
		lda #$84	; Player 2 default selection (Sub-Zero)
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
	bmi :+
		sta zp_plr1_selection
		lda #$03	; Cursor bleep SFX
		sta ram_req_sfx
	:
	rts

; -----------------------------------------------------------------------------

; PPU pointers for "cursor" in main menu?
tbl_menu_cursor_ptrs:
	.byte $28, $20, $2A, $20

; -----------------------------------------------------------------------------

; Called when Machine State is 0,1,?
sub_option_menu_states:
	lda zp_machine_state_2
	jsr sub_trampoline
; ----------------
	.word sub_init_options_menu		; 0,1,0
	.word sub_menu_fade_in			; 0,1,1
	.word sub_options_menu_loop		; 0,1,2
	.word sub_menu_fade_out			; 0,1,3
	.word sub_back_to_main			; 0,1,4

	.word sub_menu_fade_out			; 0,1,5
	.word sub_init_sound_test		; 0,1,6
	.word sub_menu_fade_in			; 0,1,7
	.word sub_sound_test_input_loop	; 0,1,8
	.word sub_menu_fade_out			; 0,1,9
	.word sub_back_to_main			; 0,1,A

; -----------------------------------------------------------------------------

sub_init_options_menu:
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
	lda #$59
	sta ram_oam_copy_tileid
	lda #$01
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

sub_init_sound_test:
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
	.byte $28, $29, $2A

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

sub_fighter_selection_states:
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
	lda zp_66
	beq :+
		iny
	:
	sty zp_tmp_idx
	jsr sub_setup_new_screen
	jsr sub_rom_B4B2

	lda #$00
	sta zp_scroll_x
	sta zp_scroll_y

	lda #$88
	sta PpuControl_2000
	sta zp_ppu_control_backup

	cli
	jsr sub_wait_vblank

	lda #$1E
	sta zp_ppu_mask_backup

	lda #$0C
	sta ram_irq_routine_idx

	lda #$80
	sta ram_irq_latch_value

	inc zp_machine_state_2

	lda #$00
	sta zp_5C
	sta zp_5D

	lda zp_66
	asl A
	tay

	lda zp_plr1_selection
	and #$80
	ora @rom_B2A9+0,Y
	sta zp_plr1_selection

	lda zp_plr2_selection
	and #$80
	ora @rom_B2A9+1,Y
	sta zp_plr2_selection
	rts

; -----------------------------------------------------------------------------

	@rom_B2A9:
	.byte $03, $04, $06, $08

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
	jmp sub_rom_B363

; -----------------------------------------------------------------------------


sub_fighter_sel_loop:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	beq @B2DF_rts

		sta zp_last_execution_frame
		jsr sub_fighter_selection_input
		jsr sub_rom_B363
		jsr sub_rom_B556
		lda zp_5C
		cmp zp_5D
		bne @B2DF_rts

			cmp #$09
			bne @B2DF_rts

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

sub_fighter_selection_input:
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
		lda zp_06
		sta zp_06
		lda zp_05
		sta zp_05

		jsr sub_ctrl_to_idx
		sta zp_05
		ldx zp_07
		lda zp_05
		bmi :+
			sta zp_plr1_selection,X
			lda #$03	; Bleep sound
			sta ram_req_sfx
		:
		lda zp_controller1_new,X
		and #$C0
		beq @B352
			jsr sub_announce_fighter_name
			inc zp_5C,X
	@B352:
	lda zp_5C,X
	beq @B362_rts

	cmp #$09
	bcs @B362_rts

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
	.byte $00	; $00 Shang-Tsung
	.byte $00	; $01 Goro
	.byte $16	; $02 Johnny Cage
	.byte $15	; $03 Kano
	.byte $13	; $04 Sub-zero
	.byte $12	; $05 Sonya
	.byte $11	; $06 Raiden
	.byte $17	; $07 Liu Kang
	.byte $14	; $08 Scorpion

; -----------------------------------------------------------------------------

; Checks if the player (or both players) has selected a fighter
sub_rom_B363:
	ldx #$00
	stx zp_07
	jsr sub_rom_B36E	; First run for player 1

	ldx #$01			; Second run for player 2
	stx zp_07
; ----------------
sub_rom_B36E:
	lda zp_5C,X	; This will be set when that player has made a selection
	cmp #$06
	bcs @B377

		jmp sub_ftr_sel_update_cursors

	; Flash the cursor if fighter selected
	@B377:
	lda #$08	; Number of sprites in the meta-sprite
	sta zp_0A
	lda tbl_sel_cur_oam_ofs,X
	tay
	lda #$F8
	:
		sta ram_oam_copy_ypos,Y
		iny
		iny
		iny
		iny
		dec zp_0A
	bne :-

	rts

; -----------------------------------------------------------------------------

tbl_sel_cur_oam_ofs:
	.byte $00	; Player 1
	.byte $20	; Player 2

tbl_sel_cur_data_ofs:                
	.byte $00	; Player 1             
	.byte $10	; Player 2

; Sprite attribute byte for fighter selection cursor
tbl_sel_cur_attr:
	.byte $02	; Player 1
	.byte $03	; Player 2

; -----------------------------------------------------------------------------

sub_ftr_sel_update_cursors:
	lda zp_tmp_idx
	asl A
	tay
	lda rom_B414+0,Y
	sta zp_ptr1_lo
	lda rom_B414+1,Y
	sta zp_ptr1_hi
	
	lda zp_plr1_selection,X
	bpl :+	; Skip CPU opponent
		rts
; ----------------
	:
	asl A
	tay
	lda (zp_ptr1_lo),Y
	sta zp_ptr2_lo
	iny
	lda (zp_ptr1_lo),Y
	sta zp_ptr2_hi
	ldy #$08
	lda zp_5C,X
	beq :+
		ldy #$02
	:
	sty zp_05
	ldy #$00
	lda zp_frame_counter
	and zp_05
	beq :+
		ldy #$08
	:
	sty zp_05
	lda tbl_sel_cur_data_ofs,X
	clc
	adc zp_05
	tay

	lda tbl_sel_cur_attr,X
	sta zp_0F

	lda tbl_sel_cur_oam_ofs,X
	tax

	lda #$02
	sta zp_var_y
	@B3DB_loop_y:
	lda #$04
	sta zp_var_x

	lda zp_ptr2_lo
	sta zp_09

	@B3E3_loop_x:
	sta ram_oam_copy_xpos,X
	lda tbl_ftr_sel_tiles,Y
	beq :+
		sta ram_oam_copy_tileid,X
		lda zp_0F
		sta ram_oam_copy_attr,X
		lda zp_ptr2_hi
		sta ram_oam_copy_ypos,X
		; X = X + 4
		txa
		axs #$FC
	:
	iny
	lda zp_09
	clc
	adc #$08
	sta zp_09
	dec zp_var_x
	bne @B3E3_loop_x

	lda zp_ptr2_hi
	clc
	adc #$08
	sta zp_ptr2_hi
	dec zp_var_y
	bne @B3DB_loop_y

	rts

; ----------------

rom_B414:
	.word tbl_ftr_sel_xy_0, tbl_ftr_sel_xy_1
	.word tbl_ftr_sel_xy_0, tbl_ftr_sel_xy_1

; ----------------

tbl_ftr_sel_xy_0:
	.byte $40, $17	; $00
	.byte $70, $17	; $01
	.byte $A0, $17	; $02

	.byte $18, $4F	; $03
	.byte $48, $4F	; $04
	.byte $80, $4F	; $05
	.byte $B8, $4F	; $06
	
	.byte $50, $8F	; $07
	.byte $80, $8F	; $08

; ----------------

; Unused?
tbl_ftr_sel_xy_1:
	.byte $30, $30, $50, $30, $90, $30, $B0, $30
	.byte $10, $60, $30, $60, $50, $60, $70, $60
	.byte $90, $60, $B0, $60, $D0, $60, $10, $90
	.byte $30, $90, $50, $90, $70, $90, $90, $90
	.byte $B0, $90, $D0, $90

; ----------------

tbl_ftr_sel_tiles:
	; Player 1 cursor
	.byte $E0, $E1, $E1, $E2
	.byte $E3, $F2, $F0, $E4

	.byte $E8, $E9, $E9, $EA
	.byte $EB, $F0, $F0, $EF

	; Player 2 cursor
	.byte $E8, $E9, $E9, $EA
	.byte $EB, $F0, $F0, $EF

	.byte $E0, $E1, $E1, $E2
	.byte $E3, $F0, $F6, $E4

; -----------------------------------------------------------------------------

sub_rom_B4B2:
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

sub_rom_B556:
	lda zp_tmp_idx
	asl A
	tay
	lda rom_B5BF+0,Y
	sta zp_ptr2_lo
	lda rom_B5BF+1,Y
	sta zp_ptr2_hi

	ldx #$00
	lda zp_5C,X
	cmp #$05
	bne :+
		jsr sub_rom_B578
	:
	ldx #$01
	lda zp_5C,X
	cmp #$05
	beq sub_rom_B578
		rts
; ----------------
sub_rom_B578:
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
	.word sub_rom_B864
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

sub_rom_B864:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$09
	bcc @B864_rts

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
		lda rom_B89C+0,Y
		sta zp_plr1_fighter_idx
		lda rom_B89C+1,Y
		sta zp_plr2_fighter_idx
		inc zp_62

	@B864_rts:
	rts

; -----------------------------------------------------------------------------

rom_B89C:
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
	.word sub_vs_state_init	; 0,2,0
	.word sub_rom_B926	; 0,2,1
	.word sub_vs_fade_in	; 0,2,2
	.word sub_rom_B993	; 0,2,3
	.word sub_vs_fade_out	; 0,2,4

; -----------------------------------------------------------------------------

sub_vs_state_init:
	jsr sub_rom_BE15
	; If both fighters have already been selected, move to VS screen,
	; otherwise this will show the fighter selection screen
	ldx #$00
	lda zp_plr1_selection,X			; Player 1
	bmi @B8E2

		inx
		lda zp_plr1_selection,X		; Player 2

	bmi @B8E2

		inc zp_machine_state_2
		lda #$00
		sta zp_61
		sta zp_endurance_flag

	rts
; ----------------
	@B8E2:
	lda zp_endurance_flag
	bne @B8F2

	lda #$00
	sta zp_65
	ldy zp_61
	lda ram_06C0,Y
	jmp @B917

	@B8F2:
	cmp #$01
	bne @B905

	ldy zp_61
	lda ram_06C3,Y
	ora #$80
	sta zp_65
	lda ram_06C0,Y
	jmp @B917

	@B905:
	tay
	lda #$00
	sta zp_65
	lda zp_66
	bne @B914
	lda rom_B91E,Y
	jmp @B917

	@B914:
	lda rom_B922,Y
	@B917:
	ora #$80
	sta zp_plr1_selection,X
	inc zp_machine_state_2
	rts

; -----------------------------------------------------------------------------

rom_B91E:
	.byte $01, $00, $01, $00
rom_B922:
	.byte $03, $00, $03, $00

; -----------------------------------------------------------------------------

sub_rom_B926:
	lda zp_endurance_flag
	cmp #$01
	beq @B941

		lda #$02	; Index used for VS screen (it's the same as player select)
		sta zp_tmp_idx
		jsr sub_setup_new_screen
		jsr sub_rom_BA74
		jsr sub_rom_B9DB
		lda #$8A
		sta ram_0680
		jmp @B956

	@B941:
	lda #$07	; Index for endurance match VS screen
	sta zp_tmp_idx
	jsr sub_setup_new_screen
	jsr sub_rom_BC2B
	ldy #$88
	lda zp_plr1_selection
	bpl @B953

	ldy #$8A
	@B953:
	sty ram_0680
	@B956:
	jsr sub_hide_all_sprites
	lda #$00
	sta zp_57
	sta zp_palette_fade_idx
	sta zp_scroll_x
	sta zp_scroll_y
	lda #$88
	sta PpuControl_2000
	sta zp_ppu_control_backup
	cli
	jsr sub_wait_vblank
	lda #$1E
	sta zp_ppu_mask_backup
	lda ram_0680
	sta zp_ppu_control_backup
	lda #$0C
	sta ram_irq_routine_idx
	sta ram_irq_latch_value
	inc zp_machine_state_2
	rts

; -----------------------------------------------------------------------------

sub_vs_fade_in:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$05
	bcc @B982_rts

		inc zp_machine_state_2
		lda #$04
		sta zp_counter_param

	@B982_rts:
	rts

; -----------------------------------------------------------------------------

sub_rom_B993:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	beq @B9B4

		sta zp_last_execution_frame
		lda zp_controller1_new
		bne @B9AE

		lda zp_controller2_new
		bne @B9AE

		lda zp_frame_counter
		and #$1F
		bne @B9B4

		dec zp_counter_param
		bne @B9B4

		@B9AE:
		lda #$00
		sta zp_counter_param
		inc zp_machine_state_2

	@B9B4:
	rts

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

sub_rom_B9DB:
	lda ram_0680
	asl A
	asl A
	tax
	ldy #$2B
	sty PpuAddr_2006
	lda #$D1
	sta PpuAddr_2006
	lda rom_BA68+0,X
	sta PpuData_2007
	;lda #$2B
	sty PpuAddr_2006
	lda #$D2
	sta PpuAddr_2006
	lda rom_BA68+1,X
	sta PpuData_2007
	;lda #$2B
	sty PpuAddr_2006
	lda #$D9
	sta PpuAddr_2006
	lda rom_BA6A+0,X
	sta PpuData_2007
	;lda #$2B
	sty PpuAddr_2006
	lda #$DA
	sta PpuAddr_2006
	lda rom_BA6A+1,X
	sta PpuData_2007
	lda ram_0681
	asl A
	asl A
	tax
	;lda #$2B
	sty PpuAddr_2006
	lda #$D5
	sta PpuAddr_2006
	lda rom_BA68+0,X
	sta PpuData_2007
	;lda #$2B
	sty PpuAddr_2006
	lda #$D6
	sta PpuAddr_2006
	lda rom_BA68+1,X
	sta PpuData_2007
	;lda #$2B
	sty PpuAddr_2006
	lda #$DD
	sta PpuAddr_2006
	lda rom_BA6A+0,X
	sta PpuData_2007
	;lda #$2B
	sty PpuAddr_2006
	lda #$DE
	sta PpuAddr_2006
	lda rom_BA6A+1,X
	sta PpuData_2007
	rts
; ----------------
rom_BA68:
	.byte $3F, $CF
rom_BA6A:
	.byte $33, $CC, $7F, $DF, $77, $DD, $BF, $EF
	.byte $BB, $EE

; -----------------------------------------------------------------------------

sub_rom_BA74:
	lda zp_66
	asl A
	tay
	lda rom_BB07+0,Y
	sta zp_ptr2_lo
	lda rom_BB07+1,Y
	sta zp_ptr2_hi
	ldx #$00
	lda zp_plr1_selection
	and #$7F
	asl A
	tay
	lda (zp_ptr2_lo),Y
	sta zp_05
	iny
	lda (zp_ptr2_lo),Y
	sta ram_0680,X
	jsr sub_rom_BC9A
	lda #$29
	sta zp_nmi_ppu_ptr_hi
	lda #$46
	sta zp_nmi_ppu_ptr_lo
	jsr sub_rom_BABF
	ldx #$01
	lda zp_plr2_selection
	and #$7F
	asl A
	tay
	lda (zp_ptr2_lo),Y
	sta zp_05
	iny
	lda (zp_ptr2_lo),Y
	sta ram_0680,X
	jsr sub_rom_BC9A
	lda #$29
	sta zp_nmi_ppu_ptr_hi
	lda #$56
	sta zp_nmi_ppu_ptr_lo
; ----------------
sub_rom_BABF:
	lda zp_47
	ora zp_ppu_control_backup
	and #$7F
	sta PpuControl_2000
	ldy #$00
	ldx #$00
	@BACC:
	lda PpuStatus_2002
	lda zp_nmi_ppu_ptr_hi
	sta PpuAddr_2006
	lda zp_nmi_ppu_ptr_lo
	sta PpuAddr_2006
	@BAD9:
	lda ram_ppu_data_buffer,X
	sta PpuData_2007
	iny
	inx
	cpy zp_nmi_ppu_cols
	bcc @BAD9

	lda zp_nmi_ppu_ptr_lo
	clc
	adc #$20
	sta zp_nmi_ppu_ptr_lo
	bcc @BAF0

	inc zp_nmi_ppu_ptr_hi
	@BAF0:
	ldy #$00
	dec zp_nmi_ppu_rows
	bne @BACC

	lda #$00
	sta zp_nmi_ppu_ptr_hi
	rts

; -----------------------------------------------------------------------------

; Potentially unused
;rom_BAFB:
;	.byte $3F, $CF, $33, $CC, $7F, $DF, $77, $DD
;	.byte $BF, $EF, $BB, $EE

; -----------------------------------------------------------------------------

rom_BB07:
	.word rom_BB0B, rom_BB1D

; -----------------------------------------------------------------------------

rom_BB0B:
	.byte $00, $01, $01, $00, $02, $00, $03, $01
	.byte $04, $01, $05, $02, $06, $01, $07, $00
	.byte $08, $02

; -----------------------------------------------------------------------------

rom_BB1D:
	.byte $00, $01, $06, $00, $03, $02, $01, $00
	.byte $06, $01, $02, $00, $03, $01, $04, $01
	.byte $05, $00, $08, $02, $07, $00, $05, $02
	.byte $07, $02, $08, $00, $00, $00, $02, $01
	.byte $01, $01, $04, $02

; -----------------------------------------------------------------------------

rom_BB41:
	.word rom_BB53
	.word rom_BB6B
	.word rom_BB83
	.word rom_BB9B
	.word rom_BBB3
	.word rom_BBCB
	.word rom_BBE3
	.word rom_BBFB
	.word rom_BC13

; -----------------------------------------------------------------------------

rom_BB53:
	.byte $C0, $C1, $C2, $C3, $D0, $D1, $D2, $D3
	.byte $C4, $C5, $C6, $C7, $D4, $D5, $D6, $D7
	.byte $C8, $C9, $CA, $CB, $D8, $D9, $DA, $DB
rom_BB6B:
	.byte $6C, $6D, $6E, $6F, $7C, $7D, $7E, $7F
	.byte $8C, $8D, $8E, $8F, $9C, $9D, $9E, $9F
	.byte $AC, $AD, $AE, $AF, $BC, $BD, $BE, $BF
rom_BB83:
	.byte $08, $09, $0A, $0B, $18, $19, $1A, $1B
	.byte $28, $29, $2A, $2B, $38, $39, $3A, $3B
	.byte $48, $49, $4A, $4B, $58, $59, $5A, $5B
rom_BB9B:
	.byte $64, $65, $66, $67, $74, $75, $76, $77
	.byte $84, $85, $86, $87, $94, $95, $96, $97
	.byte $A4, $A5, $A6, $A7, $B4, $B5, $B6, $B7
rom_BBB3:
	.byte $00, $01, $02, $03, $10, $11, $12, $13
	.byte $20, $21, $22, $23, $30, $31, $32, $33
	.byte $40, $15, $42, $43, $50, $51, $52, $53
rom_BBCB:
	.byte $68, $69, $6A, $6B, $78, $79, $7A, $7B
	.byte $88, $89, $8A, $8B, $98, $99, $9A, $9B
	.byte $A8, $A9, $AA, $AB, $B8, $B9, $BA, $BB
rom_BBE3:
	.byte $60, $61, $62, $63, $70, $71, $72, $73
	.byte $80, $81, $82, $83, $90, $91, $92, $93
	.byte $A0, $A1, $A2, $A3, $B0, $B1, $B2, $B3
rom_BBFB:
	.byte $04, $05, $06, $07, $14, $15, $16, $17
	.byte $24, $25, $26, $27, $34, $35, $36, $37
	.byte $44, $45, $46, $47, $54, $55, $56, $57
rom_BC13:
	.byte $0C, $0D, $0E, $0F, $1C, $1D, $1E, $1F
	.byte $2C, $2D, $2E, $2F, $3C, $3D, $3E, $3F
	.byte $4C, $4D, $4E, $4F, $5C, $5D, $5E, $5F

; -----------------------------------------------------------------------------

sub_rom_BC2B:
	lda zp_66
	asl A
	tay
	lda rom_BB07+0,Y
	sta zp_ptr2_lo
	lda rom_BB07+1,Y
	sta zp_ptr2_hi
	ldx #$00
	stx zp_1C
	lda zp_plr1_selection
	jsr sub_rom_BC57
	ldx #$01
	stx zp_1C
	lda zp_plr1_selection,X
	jsr sub_rom_BC57
	ldx #$02
	stx zp_1C
	lda zp_plr1_selection,X
	jsr sub_rom_BC57
	jmp sub_rom_BCCB

; -----------------------------------------------------------------------------

sub_rom_BC57:
	and #$7F
	asl A
	tay
	lda (zp_ptr2_lo),Y
	sta zp_05
	iny
	ldx zp_1C
	lda (zp_ptr2_lo),Y
	sta ram_0680,X
	jsr sub_rom_BC9A
	lda zp_1C
	asl A
	asl A
	tax
	lda rom_BCBF+0,X
	sta zp_nmi_ppu_ptr_hi
	lda rom_BCBF+1,X
	sta zp_nmi_ppu_ptr_lo
	jsr sub_rom_BABF
	lda zp_1C
	asl A
	asl A
	tax
	lda rom_BCC1+0,X
	sta zp_nmi_ppu_ptr_hi
	lda rom_BCC1+1,X
	sta zp_nmi_ppu_ptr_lo
	lda #$04
	sta zp_nmi_ppu_cols
	lda #$06
	sta zp_nmi_ppu_rows
	ldy #$00
	sty zp_47
	jmp sub_rom_BABF

; -----------------------------------------------------------------------------

sub_rom_BC9A:
	lda zp_05
	asl A
	tay
	lda rom_BB41+0,Y
	sta zp_ptr1_lo
	lda rom_BB41+1,Y
	sta zp_ptr1_hi
	lda #$04
	sta zp_nmi_ppu_cols
	lda #$06
	sta zp_nmi_ppu_rows
	ldy #$00
	sty zp_47
	:
		lda (zp_ptr1_lo),Y
		sta ram_ppu_data_buffer,Y
		iny
		cpy #$18
	bcc :-

	rts

; -----------------------------------------------------------------------------

rom_BCBF:
	.byte $21, $44
rom_BCC1:
	.byte $29, $44, $21, $52, $29, $58, $21, $58
	.byte $29, $4A

; -----------------------------------------------------------------------------

sub_rom_BCCB:
	lda ram_0680
	asl A
	tax
	ldy #$23
	sty PpuAddr_2006
	lda #$D1
	sta PpuAddr_2006
	lda rom_BDDF+0,X
	sta PpuData_2007
	;lda #$23
	sty PpuAddr_2006
	lda #$D9
	sta PpuAddr_2006
	lda rom_BDDF+1,X
	sta PpuData_2007
	ldy #$2B
	sty PpuAddr_2006
	lda #$D1
	sta PpuAddr_2006
	lda rom_BDDF+0,X
	sta PpuData_2007
	;lda #$2B
	sty PpuAddr_2006
	lda #$D9
	sta PpuAddr_2006
	lda rom_BDDF+1,X
	sta PpuData_2007
	lda ram_0681
	asl A
	asl A
	asl A
	tax
	ldy #$23
	sty PpuAddr_2006
	lda #$D4
	sta PpuAddr_2006
	lda rom_BDE5+0,X
	sta PpuData_2007
	;lda #$23
	sty PpuAddr_2006
	lda #$D5
	sta PpuAddr_2006
	lda rom_BDE5+1,X
	sta PpuData_2007
	;lda #$23
	sty PpuAddr_2006
	lda #$DC
	sta PpuAddr_2006
	lda rom_BDE7+0,X
	sta PpuData_2007
	;lda #$23
	sty PpuAddr_2006
	lda #$DD
	sta PpuAddr_2006
	lda rom_BDE7+1,X
	sta PpuData_2007
	ldy #$2B
	sty PpuAddr_2006
	lda #$D6
	sta PpuAddr_2006
	lda rom_BDE9+0,X
	sta PpuData_2007
	;lda #$2B
	sty PpuAddr_2006
	lda #$DE
	sta PpuAddr_2006
	lda rom_BDE9+1,X
	sta PpuData_2007
	lda ram_0682
	asl A
	asl A
	asl A
	tax
	ldy #$23
	sty PpuAddr_2006
	lda #$D6
	sta PpuAddr_2006
	lda rom_BDFD+0,X
	sta PpuData_2007
	;lda #$23
	sty PpuAddr_2006
	lda #$DE
	sta PpuAddr_2006
	lda rom_BDFD+1,X
	sta PpuData_2007
	ldy #$2B
	sty PpuAddr_2006
	lda #$D2
	sta PpuAddr_2006
	lda rom_BDFF+0,X
	sta PpuData_2007
	;lda #$2B
	sty PpuAddr_2006
	lda #$D3
	sta PpuAddr_2006
	lda rom_BDFF+1,X
	sta PpuData_2007
	;lda #$2B
	sty PpuAddr_2006
	lda #$DA
	sta PpuAddr_2006
	lda rom_BE01+0,X
	sta PpuData_2007
	;lda #$2B
	sty PpuAddr_2006
	lda #$DB
	sta PpuAddr_2006
	lda rom_BE01+1,X
	sta PpuData_2007
	rts

; -----------------------------------------------------------------------------

rom_BDDF:
	.byte $0F, $00, $5F, $55, $AF, $AA
rom_BDE5:
	.byte $3F, $CF
rom_BDE7:
	.byte $33, $CC
rom_BDE9:
	.byte $0F, $00, $00, $00, $7F, $DF, $77, $DD
	.byte $5F, $55, $00, $00, $BF, $EF, $BB, $EE
	.byte $AF, $AA, $00, $00
rom_BDFD:
	.byte $0F, $00
rom_BDFF:
	.byte $3F, $CF
rom_BE01:
	.byte $33, $CC, $00, $00, $5F, $55, $7F, $DF
	.byte $77, $DD, $00, $00, $AF, $AA, $BF, $EF
	.byte $BB, $EE, $00, $00

; -----------------------------------------------------------------------------

sub_rom_BE15:
	lda zp_66
	bne @BE44
	lda zp_plr1_selection
	bpl @BE1F
	lda zp_plr2_selection
	@BE1F:
	sta zp_05
	sta ram_06C6
	and #$7F
	tay
	lda rom_BE6F,Y
	sta zp_07
	ldx #$00
	ldy #$00
	@BE30:
	lda rom_BE8A,X
	cmp zp_05
	bne @BE3A

	inx
	bne @BE30

	@BE3A:
	sta ram_06C0,Y
	iny
	inx
	dec zp_07
	bne @BE30

	rts
; ----------------
	@BE44:
	lda zp_plr1_selection
	bpl @BE4A

	lda zp_plr2_selection
	@BE4A:
	sta zp_05
	sta ram_06CD
	and #$7F
	tay
	lda rom_BE78,Y
	sta zp_07
	ldx #$00
	ldy #$00
	@BE5B:
	lda rom_BE91,X
	cmp zp_05
	bne @BE65

	inx
	bne @BE5B

	@BE65:
	sta ram_06C0,Y
	iny
	inx
	dec zp_07
	bne @BE5B

	rts

; -----------------------------------------------------------------------------

rom_BE6F:
	.byte $07, $07, $06, $06, $06, $06, $06, $06
	.byte $06
rom_BE78:
	.byte $0E, $0D, $0D, $0E, $0D, $0D, $0D, $0D
	.byte $0D, $0D, $0D, $0D, $0D, $0D, $0E, $0D
	.byte $0E, $0D
rom_BE8A:
	.byte $02, $03, $04, $05, $06, $07, $08
rom_BE91:
	.byte $01, $02, $05, $07, $08, $09, $0A, $04
	.byte $06, $0B, $0C, $0D, $0F, $11

; -----------------------------------------------------------------------------

sub_rom_BE9F:
	lda zp_plr1_selection
	and #$80
	sta zp_plr1_fighter_idx
	lda zp_plr2_selection
	and #$80
	sta zp_plr2_fighter_idx
	lda zp_65
	and #$80
	sta zp_60
	lda zp_66
	bne @BEDC

	lda zp_plr1_selection
	and #$7F
	tay
	lda rom_BF03,Y
	ora zp_plr1_fighter_idx
	sta zp_plr1_fighter_idx
	lda zp_plr2_selection
	and #$7F
	tay
	lda rom_BF03,Y
	ora zp_plr2_fighter_idx
	sta zp_plr2_fighter_idx
	lda zp_65
	beq @BED9

	and #$7F
	tay
	lda rom_BF03,Y
	ora zp_60
	@BED9:
	sta zp_60
	rts
; ----------------
	@BEDC:
	lda zp_plr1_selection
	and #$7F
	tay
	lda rom_BF0C,Y
	ora zp_plr1_fighter_idx
	sta zp_plr1_fighter_idx
	lda zp_plr2_selection
	and #$7F
	tay
	lda rom_BF0C,Y
	ora zp_plr2_fighter_idx
	sta zp_plr2_fighter_idx
	lda zp_65
	beq @BF00

	and #$7F
	tay
	lda rom_BF0C,Y
	ora zp_60
	@BF00:
	sta zp_60
	rts

; -----------------------------------------------------------------------------

rom_BF03:
	.byte $08, $07, $05, $04, $02, $01, $00, $06
	.byte $03
rom_BF0C:
	.byte $08, $00, $04, $07, $0C, $05, $10
	.byte $02, $01, $03, $06, $0D, $12, $0F, $14
	.byte $11, $13, $0E

; -----------------------------------------------------------------------------

sub_rom_BF1E:
	lda zp_machine_state_2
	jsr sub_trampoline
; ----------------
; Jump pointers
	.word sub_rom_BF29
	.word sub_rom_BF66
	.word sub_rom_BF73

; -----------------------------------------------------------------------------

sub_rom_BF29:
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

sub_rom_BF66:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$05
	bcs @BF70

	rts
; ----------------
	@BF70:
	inc zp_machine_state_2
	rts

; -----------------------------------------------------------------------------

sub_rom_BF73:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$09
	bcs @BF7D

	rts
; ----------------
	@BF7D:
	dec zp_counter_param
	beq @BF89

	ldy #$00
	sty zp_palette_fade_idx
	iny
	sty zp_machine_state_2
	rts
; ----------------
	@BF89:
	lda #$00
	sta zp_machine_state_2
	sta zp_machine_state_1
	sta zp_machine_state_0
	rts

; -----------------------------------------------------------------------------

; Called when Machine State is 0,0,0
sub_init_titles_screen:
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

; Machine state = 0,0,3
; Redundant: this was identical to sub_menu_fade_out
;sub_titles_fade_out:
;	jsr sub_rom_cycle_palettes
;	lda zp_palette_fade_idx
;	cmp #$09
;	bcs :+
		; Palettes are still cycling
;		rts
; ----------------
;	:
	; Fade out complete
;	inc zp_machine_state_2	; Move to next sub-state
;	rts

; -----------------------------------------------------------------------------

; Potentially unused
;rom_BFF7:
;	.byte $20, $24, $32, $31, $2C, $24, $34, $34
;	.byte $2C

; -----------------------------------------------------------------------------
