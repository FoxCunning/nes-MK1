.segment "BANK_05b"
; $B000-$BFFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"


; -----------------------------------------------------------------------------
.export sub_state_machine_0

; Called when Machine State 0 is 0
; Branches depending on Machine State 1
sub_state_machine_0:
	lda zp_machine_state_1	; This will be the index of the pointer to use
	jsr sub_trampoline		; The sub will use the following table of pointers
                        	; to jump to one of those locations
; ----------------
	.word sub_state_machine_0_0
	.word sub_rom_B174
	.word sub_rom_B24F
	.word sub_rom_B8BC
	.word sub_rom_B6D8
	.word sub_rom_B7FE
	.word sub_rom_BF1E

; -----------------------------------------------------------------------------

; Called when Machine State is 0,0
sub_state_machine_0_0:
	lda zp_machine_state_2
	jsr sub_trampoline    ; Same trick again
; ----------------
	.word sub_init_titles_screen	; 0,0,0
	.word sub_titles_fade_in		; 0,0,1
	.word sub_titles_loop			; 0,0,2
	.word sub_titles_fade_out		; 0,0,3
	.word sub_init_menu_screen		; 0,0,4
	.word sub_menu_fade_in			; 0,0,5
	.word sub_menu_slide_up			; 0,0,6
	.word sub_menu_screen_shake		; 0,0,7
	.word sub_main_menu_loop		; 0,0,8
	.word sub_menu_fade_out			; 0,0,9
	.word sub_rom_B114		; 0,0,A
	.word sub_rom_B13A		; 0,0,B

; -----------------------------------------------------------------------------

; Machine state = 0,0,4
sub_init_menu_screen:
	lda #$00
	sta zp_tmp_idx
	;lda #$00
	sta zp_66
	jsr sub_setup_new_screen

	; Set up screen split
	lda #$00
	sta zp_scroll_x
	sta zp_scroll_y
	lda #$88
	sta PpuControl_2000
	sta zp_02
	cli
	jsr sub_wait_vblank
	lda #$1E
	sta zp_04
	lda #$0D
	sta ram_routine_pointer_idx

	lda #$ED
	sta ram_irq_latch_value
	lda #$00
	sta zp_5F
	sta zp_61
	lda #$00
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
	bcs :+
		; Palettes still cycling
		rts
; ----------------
	:
	; Fade in complete
	inc zp_machine_state_2	; Move to next sub-state
	rts

; -----------------------------------------------------------------------------

; Machine state = 0,0,6
; Gradually increases the latch value, making the bottom part of the menu
; screen slide upwards
sub_menu_slide_up:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	bne :+
		; Already executed this frame
		rts
; ----------------
	:
	sta zp_last_execution_frame
	;dec ram_irq_latch_value
	;lda ram_irq_latch_value
	;cmp #$8B
	;bcs :+
	lda #$8C
	dcp ram_irq_latch_value
	bcc :+
		lda #$8C
		sta ram_irq_latch_value
		; Prepare the counter for the screen shake effect
		lda #$07
		sta zp_counter_param
		; Advance to next sub-state
		inc zp_machine_state_2
	:
	rts

; -----------------------------------------------------------------------------

; Machine state = 0,0,7
; Makes the screen "shake" when the bottom half of the main menu hits the top
sub_menu_screen_shake:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	bne :+
		; Already executed during this frame
		rts
; ----------------
	:
	sta zp_last_execution_frame
	
	ldx zp_counter_param
	lda @tbl_scroll_shake_values,X
	sta zp_scroll_y

	dec zp_counter_param
	bpl :+
		; Counter underflow: we have finished shaking the screen
		lda #$00
		sta zp_scroll_y
		; Prepare wait counter (when expired, it will show high scores)
		lda #$0A
		sta zp_counter_param
		; Advance to next sub-state
		inc zp_machine_state_2
	:
	rts

; ----------------

	@tbl_scroll_shake_values:
	.byte $00, $02, $00, $03, $00, $04, $00, $07

; -----------------------------------------------------------------------------

; Called when Machine State is 0,0,8
sub_main_menu_loop:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	bne :+
		; Already executed during this frame
		rts
; ----------------
	:
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

	lda #$31	; This will stop music and play the "selection" sound instead
	sta ram_req_song

	inc zp_machine_state_2
	lda #$05
	sta zp_palette_fade_idx
	rts

; -----------------------------------------------------------------------------

; Machine state = 0,0,9 and 0,1,3
; Used to fade out the Main Menu and Options Menu
sub_menu_fade_out:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$09
	bcs :+
		; Palettes are still cycling
		rts
; ----------------
	:
	inc zp_machine_state_2
	rts

; -----------------------------------------------------------------------------

; Machine state = 0,0,A
sub_rom_B114:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	bne :+
		; Already executed on this frame
		rts
; ----------------
	:
	sta zp_last_execution_frame

	lda #$0C
	sta ram_routine_pointer_idx

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
	rts

; -----------------------------------------------------------------------------

; Machine state = 0,0,B
sub_rom_B13A:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$09
	bcs :+
		; Palettes still cycling
		rts
; ----------------
	:
	; Palette fade done: switch to machine state 0,5,0
	lda #$00
	sta zp_machine_state_2
	lda #$05
	sta zp_machine_state_1
	rts

; -----------------------------------------------------------------------------

; Handles controller 1 input for main menu
sub_get_controller1_main_menu:
	;lda #$00	; What's the point? Just read the first two bytes...
	;asl A
	;tax
	;lda rom_04_9CAD+0,X
	lda rom_04_9CAD+0
	sta zp_ptr1_lo
	;lda rom_04_9CAD+1,X
	lda rom_04_9CAD+1
	sta zp_ptr1_hi

	lda zp_controller1_new
	sta zp_06

	lda zp_plr1_selection	; This will be either 0 (left option) or 1 (right option)
	sta zp_05

	jsr sub_rom_04_810A
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

; Called when Machine State is 0,1
sub_rom_B174:
	lda zp_machine_state_2
	jsr sub_trampoline
; ----------------
	.word sub_rom_B183
	.word sub_menu_fade_in
	.word sub_rom_B1B2
	.word sub_menu_fade_out
	.word sub_rom_B1E2

; -----------------------------------------------------------------------------

sub_rom_B183:
	lda #$01
	sta zp_tmp_idx
	jsr sub_setup_new_screen
	; Switch to vertical mirroring
	lda #$00
	sta mmc3_mirroring
	; Use bottom table for sprites
	lda #$88
	sta PpuControl_2000
	sta zp_02
	
	cli		; Enable MMC3 interrupts
	jsr sub_wait_vblank
	lda #$1E
	sta zp_04
	lda ram_042C
	sta zp_plr2_selection
	jsr sub_rom_B223
	ldx ram_042C
	lda rom_B24A,X
	sta ram_irq_latch_value
	inc zp_machine_state_2
	rts

; -----------------------------------------------------------------------------

sub_rom_B1B2:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	bne :+
    
		rts
; ----------------
	:
	sta zp_last_execution_frame
	jsr sub_get_controller1_options_menu
	jsr sub_rom_B223
	lda zp_controller1_new
	and #$D0
	beq sub_rom_B1B2

	lda zp_plr2_selection
	cmp #$05
	bcs :+

		ldx zp_plr2_selection
		stx ram_042C
		lda rom_B24A,X
		sta ram_irq_latch_value
		jmp sub_rom_B1B2
	:
	inc zp_machine_state_2
	lda #$05
	sta zp_palette_fade_idx
	rts

; -----------------------------------------------------------------------------

sub_rom_B1E2:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	bne :+

		rts
; ----------------
	:
	sta zp_last_execution_frame
	lda #$0C
	sta ram_routine_pointer_idx
	lda #$00
	sta PpuMask_2001
	sta zp_machine_state_2
	lda #$00
	sta zp_machine_state_1
	lda #$04
	sta zp_machine_state_2
	rts

; -----------------------------------------------------------------------------

; Handles controller 1 input for options menu
sub_get_controller1_options_menu:
	lda #$01
	asl A
	tax
	lda rom_04_9CAD+0,X
	sta zp_ptr1_lo
	lda rom_04_9CAD+1,X
	sta zp_ptr1_hi
	lda zp_controller1_new
	sta zp_06
	lda zp_plr2_selection
	sta zp_05
	jsr sub_rom_04_810A
	bmi :+

		sta zp_plr2_selection
		lda #$03
		sta ram_req_sfx
	:
	rts

; -----------------------------------------------------------------------------

sub_rom_B223:
	lda zp_plr2_selection
	asl A
	tax
	lda rom_B23E+0,X
	sta ram_oam_data_copy
	lda rom_B23E+1,X
	sta ram_0303
	lda #$59
	sta ram_0301
	lda #$01
	sta ram_0302
	rts

; -----------------------------------------------------------------------------

rom_B23E:
	.byte $64, $54, $74, $54, $84, $54, $94, $54
	.byte $A4, $54, $C4, $64

; -----------------------------------------------------------------------------

rom_B24A:
	.byte $60, $70, $80, $90, $A0

; -----------------------------------------------------------------------------

sub_rom_B24F:
	lda zp_machine_state_2
	jsr sub_trampoline
; ----------------
; Indirect jump pointers
	.word sub_rom_B25C
	.word sub_rom_B2AD
	.word sub_rom_B2BD
	.word sub_rom_B2E0

; -----------------------------------------------------------------------------

sub_rom_B25C:
	ldy #$02
	lda zp_66
	beq @B263
	iny
	@B263:
	sty zp_tmp_idx
	jsr sub_setup_new_screen
	jsr sub_rom_B4B2
	lda #$00
	sta zp_scroll_x
	sta zp_scroll_y
	lda #$88
	sta PpuControl_2000
	sta zp_02
	cli
	jsr sub_wait_vblank
	lda #$1E
	sta zp_04
	lda #$0C
	sta ram_routine_pointer_idx
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
	ora rom_B2A9+0,Y
	sta zp_plr1_selection
	lda zp_plr2_selection
	and #$80
	ora rom_B2A9+1,Y
	sta zp_plr2_selection
	rts

; -----------------------------------------------------------------------------

rom_B2A9:
	.byte $03, $04, $06, $08

; -----------------------------------------------------------------------------

sub_rom_B2AD:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$05
	bcs @B2B7

	rts
; ----------------
	@B2B7:
	inc zp_machine_state_2
	jsr sub_rom_B363
	rts

; -----------------------------------------------------------------------------


sub_rom_B2BD:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	bne @B2C4

	rts
; ----------------
	@B2C4:
	sta zp_last_execution_frame
	jsr sub_fighter_selection_input
	jsr sub_rom_B363
	jsr sub_rom_B556
	lda zp_5C
	cmp zp_5D
	bne @B2DF

	cmp #$09
	bne @B2DF

	inc zp_machine_state_2
	lda #$05
	sta zp_palette_fade_idx
	@B2DF:
	rts

; -----------------------------------------------------------------------------

sub_rom_B2E0:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$09
	bcs @B2EA

	rts
; ----------------
	@B2EA:
	lda #$00
	sta zp_machine_state_2
	inc zp_machine_state_1
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
	bpl @B316

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
	@B316:
	lda zp_5C,X
	bne @B352

	lda zp_controller1_new,X
	sta zp_06
	lda zp_plr1_selection,X
	sta zp_05
	lda zp_tmp_idx
	asl A
	tax
	lda rom_04_9CAD+0,X
	sta zp_ptr1_lo
	lda rom_04_9CAD+1,X
	sta zp_ptr1_hi
	lda zp_06
	sta zp_06
	lda zp_05
	sta zp_05
	jsr sub_rom_04_810A
	sta zp_05
	ldx zp_07
	lda zp_05
	bmi @B34A

	sta zp_plr1_selection,X
	lda #$03
	sta ram_req_sfx
	@B34A:
	lda zp_controller1_new,X
	and #$C0
	beq @B352

	inc zp_5C,X
	@B352:
	lda zp_5C,X
	beq @B362

	cmp #$09
	bcs @B362

	lda zp_frame_counter
	and #$0F
	bne @B362

	inc zp_5C,X
	@B362:
	rts

; -----------------------------------------------------------------------------

sub_rom_B363:
	ldx #$00
	stx zp_07
	jsr sub_rom_B36E
	ldx #$01
	stx zp_07
; ----------------
sub_rom_B36E:
	lda zp_5C,X
	cmp #$06
	bcs @B377

	jmp sub_rom_B393
	@B377:
	lda #$20
	sta zp_0A
	lda rom_B38D,X
	tay
	lda #$F8
	@B381:
	sta ram_oam_data_copy,Y
	iny
	iny
	iny
	iny
	dec zp_0A
	bne @B381

	rts

; -----------------------------------------------------------------------------

rom_B38D:
	.byte $00, $80
rom_B38F:                
	.byte $00, $30
rom_B391:
	.byte $02, $03

; -----------------------------------------------------------------------------

sub_rom_B393:
	lda zp_tmp_idx
	asl A
	tay
	lda rom_B414+0,Y
	sta zp_ptr1_lo
	lda rom_B414+1,Y
	sta zp_ptr1_hi
	lda zp_plr1_selection,X
	bpl @B3A6
	rts
; ----------------
	@B3A6:
	asl A
	tay
	lda (zp_ptr1_lo),Y
	sta zp_ptr2_lo
	iny
	lda (zp_ptr1_lo),Y
	sta zp_ptr2_hi
	ldy #$08
	lda zp_5C,X
	beq @B3B9

	ldy #$02
	@B3B9:
	sty zp_05
	ldy #$00
	lda zp_frame_counter
	and zp_05
	beq @B3C5

	ldy #$18
	@B3C5:
	sty zp_05
	lda rom_B38F,X
	clc
	adc zp_05
	tay
	lda rom_B391,X
	sta zp_0F
	lda rom_B38D,X
	tax
	lda #$06
	sta zp_0B
	@B3DB:
	lda #$04
	sta zp_08
	lda zp_ptr2_lo
	sta zp_09
	@B3E3:
	sta ram_0303,X
	lda rom_B452,Y
	beq @B3FC

	sta ram_0301,X
	lda zp_0F
	sta ram_0302,X
	lda zp_ptr2_hi
	sta ram_oam_data_copy,X
	inx
	inx
	inx
	inx
	@B3FC:
	iny
	lda zp_09
	clc
	adc #$08
	sta zp_09
	dec zp_08
	bne @B3E3

	lda zp_ptr2_hi
	clc
	adc #$08
	sta zp_ptr2_hi
	dec zp_0B
	bne @B3DB

	rts

; -----------------------------------------------------------------------------

rom_B414:
	.word rom_B41C, rom_B42E, rom_B41C, rom_B42E

; -----------------------------------------------------------------------------

rom_B41C:
	.byte $40, $2F, $A0, $2F, $20, $6F, $50, $6F
	.byte $90, $6F, $C0, $6F, $40, $9F, $70, $9F
	.byte $A0, $9F

; -----------------------------------------------------------------------------

rom_B42E:
	.byte $30, $30, $50, $30, $90, $30, $B0, $30
	.byte $10, $60, $30, $60, $50, $60, $70, $60
	.byte $90, $60, $B0, $60, $D0, $60, $10, $90
	.byte $30, $90, $50, $90, $70, $90, $90, $90
	.byte $B0, $90, $D0, $90

; -----------------------------------------------------------------------------

rom_B452:
	.byte $E0, $E1, $E1, $E2, $E3, $F0, $F1, $E4
	.byte $E3, $00, $00, $E4, $E3, $00, $00, $E4
	.byte $E3, $00, $00, $E4, $E5, $E6, $E6, $E7
	.byte $E8, $E9, $E9, $EA, $EB, $F2, $F3, $EF
	.byte $EB, $00, $00, $EF, $EB, $00, $00, $EF
	.byte $EB, $00, $00, $EF, $EC, $ED, $ED, $EE
	.byte $E0, $E1, $E1, $E2, $E3, $00, $00, $E4
	.byte $E3, $00, $00, $E4, $E3, $00, $00, $E4
	.byte $E3, $F4, $F5, $E4, $E5, $E6, $E6, $E7
	.byte $E8, $E9, $E9, $EA, $EB, $00, $00, $EF
	.byte $EB, $00, $00, $EF, $EB, $00, $00, $EF
	.byte $EB, $F6, $F7, $EF, $EC, $ED, $ED, $EE

; -----------------------------------------------------------------------------

sub_rom_B4B2:
	lda zp_tmp_idx
	asl A
	tax
	lda rom_B4CE+0,X
	sta zp_ptr1_lo
	lda rom_B4CE+1,X
	sta zp_ptr1_hi
	ldx #$40
	ldy #$00
	@B4C4:
	lda (zp_ptr1_lo),Y
	sta ram_0680,Y
	iny
	dex
	bne @B4C4

	rts

; -----------------------------------------------------------------------------

rom_B4CE:
	.word rom_B4D6, rom_B516, rom_B4D6, rom_B516

; -----------------------------------------------------------------------------

rom_B4D6:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $FF, $FF, $5F, $FF, $FF, $0F, $FF, $FF
	.byte $FF, $FF, $55, $FF, $FF, $00, $FF, $FF
	.byte $FF, $0F, $7F, $DF, $7F, $DF, $AF, $FF
	.byte $FF, $00, $77, $DD, $77, $DD, $AA, $FF
	.byte $FF, $FF, $55, $33, $CC, $AA, $FF, $FF
	.byte $FF, $FF, $F5, $F3, $FC, $FA, $FF, $FF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $0F

; -----------------------------------------------------------------------------

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
	bne @B56F

	jsr sub_rom_B578
	@B56F:
	ldx #$01
	lda zp_5C,X
	cmp #$05
	beq sub_rom_B578

	rts

; -----------------------------------------------------------------------------

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
	sta zp_44
	lda #$C8
	sta zp_43
	lda #$00
	sta zp_47
	lda #$30
	sta zp_46
	lda #$01
	sta zp_45
	ldx #$08
	ldy #$00
	@B5B2:
	lda ram_0680,X
	sta ram_0600,Y
	inx
	iny
	cpy #$30
	bcc @B5B2

	rts

; -----------------------------------------------------------------------------

rom_B5BF:
	.word rom_B5C7, rom_B5D9, rom_B5C7, rom_B5D9

; -----------------------------------------------------------------------------

rom_B5C7:
	.word rom_B5FD, rom_B602, rom_B607, rom_B60C
	.word rom_B615, rom_B61E, rom_B623, rom_B628
	.word rom_B631

; -----------------------------------------------------------------------------

rom_B5D9:
	.word rom_B636, rom_B63F, rom_B648, rom_B651
	.word rom_B65A, rom_B663, rom_B66C, rom_B675
	.word rom_B67E, rom_B687, rom_B690, rom_B699
	.word rom_B6A2, rom_B6AB, rom_B6B4, rom_B6BD
	.word rom_B6C6, rom_B6CF

; -----------------------------------------------------------------------------

rom_B5FD:
	.byte $0A, $F0, $12, $FF, $FF
rom_B602:
	.byte $0D, $F0, $15, $FF, $FF
rom_B607:
	.byte $19, $F0, $21, $FF, $FF
rom_B60C:
	.byte $1A, $C0, $1B, $30, $22, $CC, $23, $33
	.byte $FF
rom_B615:
	.byte $1C, $C0, $1D, $30, $24, $CC, $25, $33
	.byte $FF
rom_B61E:
	.byte $1E, $F0, $26, $FF, $FF
rom_B623:
	.byte $2A, $FF, $32, $0F, $FF
rom_B628:
	.byte $2B, $CC, $2C, $33, $33, $0C, $34, $03
	.byte $FF
rom_B631:
	.byte $2D, $FF, $35, $0F, $FF
rom_B636:
	.byte $09, $C0, $0A, $30, $11, $CC, $12, $33
	.byte $FF
rom_B63F:
	.byte $0A, $C0, $0B, $30, $12, $CC, $13, $33
	.byte $FF
rom_B648:
	.byte $0C, $C0, $0D, $30, $14, $CC, $15, $33
	.byte $FF
rom_B651:
	.byte $0D, $C0, $0E, $30, $15, $CC, $16, $33
	.byte $FF
rom_B65A:
	.byte $18, $CC, $19, $33, $20, $0C, $21, $03
	.byte $FF
rom_B663:
	.byte $19, $CC, $1A, $33, $21, $0C, $22, $03
	.byte $FF
rom_B66C:
	.byte $1A, $CC, $1B, $33, $22, $0C, $23, $03
	.byte $FF
rom_B675:
	.byte $1B, $CC, $1C, $33, $23, $0C, $24, $03
	.byte $FF
rom_B67E:
	.byte $1C, $CC, $1D, $33, $24, $0C, $25, $03
	.byte $FF
rom_B687:
	.byte $1D, $CC, $1E, $33, $25, $0C, $26, $03
	.byte $FF
rom_B690:
	.byte $1E, $CC, $1F, $33, $26, $0C, $27, $03
	.byte $FF
rom_B699:
	.byte $20, $C0, $21, $30, $28, $CC, $29, $33
	.byte $FF
rom_B6A2:
	.byte $21, $C0, $22, $30, $29, $CC, $2A, $33
	.byte $FF
rom_B6AB:
	.byte $22, $C0, $23, $30, $2A, $CC, $2B, $33
	.byte $FF
rom_B6B4:
	.byte $23, $C0, $24, $30, $2B, $CC, $2C, $33
	.byte $FF
rom_B6BD:
	.byte $24, $C0, $25, $30, $2C, $CC, $2D, $33
	.byte $FF
rom_B6C6:
	.byte $25, $C0, $26, $30, $2D, $CC, $2E, $33
	.byte $FF
rom_B6CF:
	.byte $26, $C0, $27, $30, $2E, $CC, $2F, $33
	.byte $FF

; -----------------------------------------------------------------------------

sub_rom_B6D8:
	lda zp_machine_state_2
	jsr sub_trampoline
; ----------------
; Jump pointers
	.word sub_rom_B6E9, sub_rom_B712, sub_rom_B723, sub_rom_B776
	.word sub_rom_B789, sub_rom_B7A8

; -----------------------------------------------------------------------------

sub_rom_B6E9:
	lda #$05
	sta zp_tmp_idx
	jsr sub_setup_new_screen
	lda #$00
	sta zp_scroll_x
	sta zp_scroll_y
	lda #$88
	sta PpuControl_2000
	sta zp_02
	cli
	jsr sub_wait_vblank
	lda #$1E
	sta zp_04
	lda #$0C
	sta ram_routine_pointer_idx
	lda #$80
	sta ram_irq_latch_value
	inc zp_machine_state_2
	rts

; -----------------------------------------------------------------------------

sub_rom_B712:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$05
	bcs @B71C
	rts
; ----------------
	@B71C:
	lda #$0A
	sta zp_counter_param
	inc zp_machine_state_2
	rts

; -----------------------------------------------------------------------------

sub_rom_B723:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	bne @B72A

	rts
; ----------------
	@B72A:
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
	rts
; ----------------
	@B744:
	jsr sub_rom_B7C3
	lda zp_frame_counter
	and #$3F
	bne @B775

	lda #$10
	sta ram_req_sfx
	dec zp_counter_param
	bpl @B775

	lda zp_F2
	eor zp_F3
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
	sta zp_02
	@B775:
	rts

; -----------------------------------------------------------------------------

sub_rom_B776:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$09
	bcs @B780

	rts
; ----------------
	@B780:
	lda #$00
	sta zp_machine_state_2
	lda #$02
	sta zp_machine_state_1
	rts

; -----------------------------------------------------------------------------

sub_rom_B789:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$09
	bcs @B793

	rts
; ----------------
	@B793:
	lda #$00
	sta zp_machine_state_2
	lda #$03
	sta zp_machine_state_1
	lda ram_040C
	eor #$01
	tax
	lda #$80
	sta zp_F2,X
	sta zp_plr1_selection,X
	rts

; -----------------------------------------------------------------------------

sub_rom_B7A8:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	bne @B7AF

	rts
; ----------------
	@B7AF:
	sta zp_last_execution_frame
	lda zp_frame_counter
	and #$1F
	bne @B7C2

	dec zp_counter_param
	bne @B7C2

	lda #$00
	sta zp_04
	jmp reset
	@B7C2:
	rts

; -----------------------------------------------------------------------------

sub_rom_B7C3:
	lda zp_counter_param
	asl A
	tax
	lda rom_B7E8+0,X
	sta ram_0600
	lda rom_B7E8+1,X
	sta ram_0601
	lda #$22
	sta zp_44
	lda #$50
	sta zp_43
	lda #$00
	sta zp_47
	lda #$01
	sta zp_46
	lda #$02
	sta zp_45
	rts

; -----------------------------------------------------------------------------

rom_B7E8:
	.byte $26, $2F, $1F, $27, $30, $34, $23, $2C
	.byte $32, $36, $38, $39, $33, $37, $25, $2E
	.byte $24, $2D, $22, $2B, $22, $2B

; -----------------------------------------------------------------------------

sub_rom_B7FE:
	lda zp_machine_state_2
	jsr sub_trampoline
; ----------------
; Jump pointers
	.word sub_rom_B80D, sub_rom_B834, sub_rom_B845, sub_rom_B864
	.word sub_rom_B8A5

; -----------------------------------------------------------------------------

sub_rom_B80D:
	lda #$04
	sta zp_tmp_idx
	jsr sub_setup_new_screen

	lda #$00
	sta zp_scroll_x
	sta zp_scroll_y

	lda #$88
	sta PpuControl_2000
	sta zp_02

	cli
	jsr sub_wait_vblank

	lda #$1E
	sta zp_04

	lda #$0C
	sta ram_routine_pointer_idx
	sta ram_irq_latch_value

	inc zp_machine_state_2
	rts

; -----------------------------------------------------------------------------

sub_rom_B834:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$05
	bcs @B83E

	rts
; ----------------
	@B83E:
	lda #$09
	sta zp_counter_param
	inc zp_machine_state_2
	rts

; -----------------------------------------------------------------------------

sub_rom_B845:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	bne @B84C

	rts
; ----------------
	@B84C:
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
	bcs @B86E

	rts
; ----------------
	@B86E:
	lda #$00
	sta PpuMask_2001
	sta zp_04
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
	sta zp_F2
	lda rom_B89C+1,Y
	sta zp_F3
	inc zp_62
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
	bcs @B8AF

	rts
; ----------------
	@B8AF:
	lda #$00
	sta zp_machine_state_2
	lda #$00
	sta zp_machine_state_1
	sta zp_plr1_selection
	sta zp_plr2_selection
	rts

; -----------------------------------------------------------------------------

sub_rom_B8BC:
	lda zp_machine_state_2
	jsr sub_trampoline
; ----------------
; Jump pointers
	.word sub_rom_B8CB, sub_rom_B926, sub_rom_B982, sub_rom_B993
	.word sub_rom_B9B5

; -----------------------------------------------------------------------------

sub_rom_B8CB:
	jsr sub_rom_BE15
	ldx #$00
	lda zp_plr1_selection,X
	bmi @B8E2

	inx
	lda zp_plr1_selection,X
	bmi @B8E2

	inc zp_machine_state_2
	lda #$00
	sta zp_61
	sta zp_5F
	rts
; ----------------
	@B8E2:
	lda zp_5F
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
	lda zp_5F
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
	lda #$07
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
	sta zp_02
	cli
	jsr sub_wait_vblank
	lda #$1E
	sta zp_04
	lda ram_0680
	sta zp_02
	lda #$0C
	sta ram_routine_pointer_idx
	sta ram_irq_latch_value
	inc zp_machine_state_2
	rts

; -----------------------------------------------------------------------------

sub_rom_B982:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$05
	bcs @B98C

	rts
; ----------------
	@B98C:
	inc zp_machine_state_2
	lda #$04
	sta zp_counter_param
	rts

; -----------------------------------------------------------------------------

sub_rom_B993:
	lda zp_frame_counter
	cmp zp_last_execution_frame
	bne @B99A

	rts
; ----------------
	@B99A:
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

sub_rom_B9B5:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$09
	bcs @B9BF

	rts
; ----------------
	@B9BF:
	lda #$00
	sta zp_04
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
	rts

; -----------------------------------------------------------------------------

sub_rom_B9DB:
	lda ram_0680
	asl A
	asl A
	tax
	lda #$2B
	sta PpuAddr_2006
	lda #$D1
	sta PpuAddr_2006
	lda rom_BA68+0,X
	sta PpuData_2007
	lda #$2B
	sta PpuAddr_2006
	lda #$D2
	sta PpuAddr_2006
	lda rom_BA68+1,X
	sta PpuData_2007
	lda #$2B
	sta PpuAddr_2006
	lda #$D9
	sta PpuAddr_2006
	lda rom_BA6A+0,X
	sta PpuData_2007
	lda #$2B
	sta PpuAddr_2006
	lda #$DA
	sta PpuAddr_2006
	lda rom_BA6A+1,X
	sta PpuData_2007
	lda ram_0681
	asl A
	asl A
	tax
	lda #$2B
	sta PpuAddr_2006
	lda #$D5
	sta PpuAddr_2006
	lda rom_BA68+0,X
	sta PpuData_2007
	lda #$2B
	sta PpuAddr_2006
	lda #$D6
	sta PpuAddr_2006
	lda rom_BA68+1,X
	sta PpuData_2007
	lda #$2B
	sta PpuAddr_2006
	lda #$DD
	sta PpuAddr_2006
	lda rom_BA6A+0,X
	sta PpuData_2007
	lda #$2B
	sta PpuAddr_2006
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
	sta zp_44
	lda #$46
	sta zp_43
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
	sta zp_44
	lda #$56
	sta zp_43
; ----------------
sub_rom_BABF:
	lda zp_47
	ora zp_02
	and #$7F
	sta PpuControl_2000
	ldy #$00
	ldx #$00
	@BACC:
	lda PpuStatus_2002
	lda zp_44
	sta PpuAddr_2006
	lda zp_43
	sta PpuAddr_2006
	@BAD9:
	lda ram_0600,X
	sta PpuData_2007
	iny
	inx
	cpy zp_46
	bcc @BAD9

	lda zp_43
	clc
	adc #$20
	sta zp_43
	bcc @BAF0

	inc zp_44
	@BAF0:
	ldy #$00
	dec zp_45
	bne @BACC

	lda #$00
	sta zp_44
	rts

; -----------------------------------------------------------------------------

; Potentially unused
rom_BAFB:
	.byte $3F, $CF, $33, $CC, $7F, $DF, $77, $DD
	.byte $BF, $EF, $BB, $EE

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
	.word rom_BB53, rom_BB6B, rom_BB83, rom_BB9B
	.word rom_BBB3, rom_BBCB, rom_BBE3, rom_BBFB
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
	sta zp_44
	lda rom_BCBF+1,X
	sta zp_43
	jsr sub_rom_BABF
	lda zp_1C
	asl A
	asl A
	tax
	lda rom_BCC1+0,X
	sta zp_44
	lda rom_BCC1+1,X
	sta zp_43
	lda #$04
	sta zp_46
	lda #$06
	sta zp_45
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
	sta zp_46
	lda #$06
	sta zp_45
	ldy #$00
	sty zp_47
	@BCB4:
	lda (zp_ptr1_lo),Y
	sta ram_0600,Y
	iny
	cpy #$18
	bcc @BCB4

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
	lda #$23
	sta PpuAddr_2006
	lda #$D1
	sta PpuAddr_2006
	lda rom_BDDF+0,X
	sta PpuData_2007
	lda #$23
	sta PpuAddr_2006
	lda #$D9
	sta PpuAddr_2006
	lda rom_BDDF+1,X
	sta PpuData_2007
	lda #$2B
	sta PpuAddr_2006
	lda #$D1
	sta PpuAddr_2006
	lda rom_BDDF+0,X
	sta PpuData_2007
	lda #$2B
	sta PpuAddr_2006
	lda #$D9
	sta PpuAddr_2006
	lda rom_BDDF+1,X
	sta PpuData_2007
	lda ram_0681
	asl A
	asl A
	asl A
	tax
	lda #$23
	sta PpuAddr_2006
	lda #$D4
	sta PpuAddr_2006
	lda rom_BDE5+0,X
	sta PpuData_2007
	lda #$23
	sta PpuAddr_2006
	lda #$D5
	sta PpuAddr_2006
	lda rom_BDE5+1,X
	sta PpuData_2007
	lda #$23
	sta PpuAddr_2006
	lda #$DC
	sta PpuAddr_2006
	lda rom_BDE7+0,X
	sta PpuData_2007
	lda #$23
	sta PpuAddr_2006
	lda #$DD
	sta PpuAddr_2006
	lda rom_BDE7+1,X
	sta PpuData_2007
	lda #$2B
	sta PpuAddr_2006
	lda #$D6
	sta PpuAddr_2006
	lda rom_BDE9+0,X
	sta PpuData_2007
	lda #$2B
	sta PpuAddr_2006
	lda #$DE
	sta PpuAddr_2006
	lda rom_BDE9+1,X
	sta PpuData_2007
	lda ram_0682
	asl A
	asl A
	asl A
	tax
	lda #$23
	sta PpuAddr_2006
	lda #$D6
	sta PpuAddr_2006
	lda rom_BDFD+0,X
	sta PpuData_2007
	lda #$23
	sta PpuAddr_2006
	lda #$DE
	sta PpuAddr_2006
	lda rom_BDFD+1,X
	sta PpuData_2007
	lda #$2B
	sta PpuAddr_2006
	lda #$D2
	sta PpuAddr_2006
	lda rom_BDFF+0,X
	sta PpuData_2007
	lda #$2B
	sta PpuAddr_2006
	lda #$D3
	sta PpuAddr_2006
	lda rom_BDFF+1,X
	sta PpuData_2007
	lda #$2B
	sta PpuAddr_2006
	lda #$DA
	sta PpuAddr_2006
	lda rom_BE01+0,X
	sta PpuData_2007
	lda #$2B
	sta PpuAddr_2006
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
	sta zp_F2
	lda zp_plr2_selection
	and #$80
	sta zp_F3
	lda zp_65
	and #$80
	sta zp_60
	lda zp_66
	bne @BEDC

	lda zp_plr1_selection
	and #$7F
	tay
	lda rom_BF03,Y
	ora zp_F2
	sta zp_F2
	lda zp_plr2_selection
	and #$7F
	tay
	lda rom_BF03,Y
	ora zp_F3
	sta zp_F3
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
	ora zp_F2
	sta zp_F2
	lda zp_plr2_selection
	and #$7F
	tay
	lda rom_BF0C,Y
	ora zp_F3
	sta zp_F3
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
	.word sub_rom_BF29, sub_rom_BF66, sub_rom_BF73

; -----------------------------------------------------------------------------

sub_rom_BF29:
	lda #$06
	sta zp_tmp_idx
	jsr sub_setup_new_screen
	lda #$00
	sta zp_scroll_x
	sta zp_scroll_y
	lda #$01
	sta mmc3_mirroring
	lda #$88
	sta PpuControl_2000
	sta zp_02
	cli
	jsr sub_wait_vblank
	lda #$1E
	sta zp_04
	ldy #$80
	lda ram_042C
	cmp #$02
	bcs @BF55

	ldy #$8A
	@BF55:
	sty zp_02
	lda #$0C
	sta ram_routine_pointer_idx
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
	sta zp_tmp_idx
	jsr sub_setup_new_screen

	jsr sub_hide_all_sprites

	lda #$00
	sta zp_scroll_x
	sta zp_scroll_y

	lda #$88
	sta PpuControl_2000
	sta zp_02

	cli
	jsr sub_wait_vblank
	lda #$1E
	sta zp_04
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
	bne :+
		; Already executed on this frame
		rts
; ----------------
	:
	sta zp_last_execution_frame

	lda zp_controller1_new
	and #$D0	; A, B or START
	bne :+
		lda zp_frame_counter
		and #$1F
		bne @BFE9
		dec zp_counter_param
		bne @BFE9
	:
	lda #$00
	sta zp_counter_param
	inc zp_machine_state_2	; Move to next sub-state

	@BFE9:
	rts

; -----------------------------------------------------------------------------

; Machine state = 0,0,3
sub_titles_fade_out:
	jsr sub_rom_cycle_palettes
	lda zp_palette_fade_idx
	cmp #$09
	bcs :+
		; Palettes are still cycling
		rts
; ----------------
	:
	; Fade out complete
	inc zp_machine_state_2	; Move to next sub-state
	rts

; -----------------------------------------------------------------------------

; Potentially unused
;rom_BFF7:
;	.byte $20, $24, $32, $31, $2C, $24, $34, $34
;	.byte $2C

; -----------------------------------------------------------------------------
