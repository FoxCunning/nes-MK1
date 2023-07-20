.segment "BANK_06b"
; $B000-$BDFFF
; Then transferred to RAM ($7000-$7FFF)
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"

; -----------------------------------------------------------------------------
.export sub_clear_ram

sub_clear_ram:
	lda #$00
	tay
	sta zp_00
	sta zp_01
	:
		; Clear $0100-$01FF
		sta (zp_00),Y
	iny
	bne :-

	; Clear $0200-$07FF
	ldx #$02
	stx zp_01
	:
			sta (zp_00),Y
		iny
		bne :-

		inc zp_01
		inx

	cpx #$08
	bcc :-

	sta zp_01
	rts

; -----------------------------------------------------------------------------
.export sub_clear_nametable

; Fills a nametable with $FF (including attribute table area)
; Parameters:
; A = index of nametable to clear (0: $2000-$23FF, 1: $2400-$27FF etc.)
sub_clear_nametable:
	asl A
	asl A
	clc
	adc #$20
	ldx #$00
	sta PpuAddr_2006
	stx PpuAddr_2006

	ldy #$03
	lda #$FF
	:
			sta PpuData_2007
		dex
		bne :-
	
	dey
	bpl :-

	rts

; -----------------------------------------------------------------------------
.export sub_hide_all_sprites

sub_hide_all_sprites:
	lda #$F8
	ldx #$00
	:
        sta ram_oam_copy_ypos,X
        inx
        inx
        inx
        inx
	bne :-

	rts

; -----------------------------------------------------------------------------
.export sub_do_ppu_transfer

sub_do_ppu_transfer:
	lda zp_47
	ora zp_ppu_control_backup
	and #$7F
	sta PpuControl_2000

	ldy #$00
	ldx #$00
	@E27F:
		lda PpuStatus_2002
		lda zp_nmi_ppu_ptr_hi
		sta PpuAddr_2006
		lda zp_nmi_ppu_ptr_lo
		sta PpuAddr_2006
		:
			lda ram_ppu_data_buffer,X
			sta PpuData_2007
			iny
			inx
			cpy zp_nmi_ppu_cols
		bcc :-

		lda zp_nmi_ppu_ptr_lo
		clc
		adc #$20
		sta zp_nmi_ppu_ptr_lo
		bcc :+
			inc zp_nmi_ppu_ptr_hi
		:
		ldy #$00
		dec zp_nmi_ppu_rows
	bne @E27F

	lda #$00
	sta zp_nmi_ppu_ptr_hi
	rts

; -----------------------------------------------------------------------------
.export sub_get_controller_input

sub_get_controller_input:
	jsr sub_read_controllers
	:
	lda zp_controller1
	sta zp_controller1_backup

	lda zp_controller2
	sta zp_controller2_backup

	jsr sub_read_controllers

	lda zp_controller1
	cmp zp_controller1_backup
	bne :-

	lda zp_controller2
	cmp zp_controller2_backup
	bne :-

	ldx #$00
	jsr @E2B7	; Process controller 1
	inx			; And now do controller 2
	; ----
	@E2B7:
	lda zp_controller1,X
	eor zp_controller1_prev,X
	and zp_controller1,X
	sta zp_controller1_new,X		; This now contains only "new" button presses
	lda zp_controller1,X
	sta zp_controller1_prev,X
	rts

; -----------------------------------------------------------------------------

sub_read_controllers:
	lda #$01
	sta Ctrl1_4016
	; ----
	sta zp_controller2	; Loop will end with this bit is shifted out
	; ----
	lsr A	; A is now zero
	sta Ctrl1_4016

	:
	; Read controller 1
	lda Ctrl1_4016
	and #$03	; Only read controller bits
	cmp #$01	; Carry set if > 0
	rol zp_controller1
	; Read controller 2
	lda Ctrl2_FrameCtr_4017
	and #$03
	cmp #$01
	rol zp_controller2
	bcc :-

	rts

; -----------------------------------------------------------------------------
.export sub_trampoline

; Jumps to a location that is selected from a list of pointers
; The pointers start at the address following the call to this sub (taken from
; the stack, so call this with JSR and whatever is after the JSR is pointer #0)
; Parameters:
; A = index of the selected pointer
sub_trampoline:
	asl A
	tay
	pla
	sta zp_ptr2_lo
	pla
	sta zp_ptr2_hi
	iny
	lda (zp_ptr2_lo),Y
	sta zp_ptr1_lo
	iny
	lda (zp_ptr2_lo),Y
	sta zp_ptr1_hi
	jmp (zp_ptr1_lo)

; -----------------------------------------------------------------------------
.export sub_select_irq_handler

; Selects a new IRQ handler for MMC3 interrupts
; The change will be effective starting from the next vblank
; Parameters:
; ram_routine_pointer_idx = index of routine that will handle MMC3 IRQs
sub_select_irq_handler:
	lda #$4C	; Op code for JMP
	sta ram_irq_trampoline
	lda ram_irq_routine_idx
	asl A
	tax
	lda tbl_irq_handler_ptrs+0,X
	sta ram_irq_ptr_lo
	lda tbl_irq_handler_ptrs+1,X
	sta ram_irq_ptr_hi
	rts

; -----------------------------------------------------------------------------

tbl_irq_handler_ptrs:
	.word sub_irq_handler_00		; $00	Goro's Lair
	.word sub_irq_handler_01		; $01	The Pit
	.word sub_irq_handler_02		; $02	Courtyard
	.word sub_irq_handler_03		; $03	Palace Gates
	.word sub_irq_handler_04		; $04	Warrior Shrine
	.word sub_irq_handler_05		; $05	Throne Room
	.word sub_irq_handler_06		; $06
	.word sub_irq_handler_07		; $07
	.word sub_irq_handler_07		; $08
	.word sub_irq_handler_07		; $09
	.word sub_irq_handler_00		; $0A
	.word sub_irq_handler_00		; $0B	Vs. Screen
	.word sub_irq_handler_0C		; $0C
	.word sub_irq_handler_0D		; $0D
	.word sub_irq_handler_0E		; $0E
	.word sub_irq_handler_0F		; $0F
	.word sub_irq_handler_10		; $10	Sound test
	.word sub_irq_handler_11		; $11
	.word sub_irq_handler_11		; $12
	.word sub_irq_handler_11		; $13

; -----------------------------------------------------------------------------

sub_irq_handler_00:
	jmp sub_rom_E408

; -----------------------------------------------------------------------------

; This controls the parallax scrolling effect for the Pit
sub_irq_handler_01:
	lda ram_irq_state_var	; 0 = top, 1 = mid, 2 = bottom

	bne @pit_mid_clouds

		; Top (clouds)
		sta mmc3_irq_disable
		sta mmc3_irq_enable
		lda #$1B
		sta mmc3_irq_latch

		lda PpuStatus_2002

		lda zp_frame_counter
		and #$07
		bne :+
			inc ram_irq_counter_0
		:
		lda ram_irq_counter_0
		clc
		adc zp_irq_hor_scroll
		sta PpuScroll_2005
		ldy #$E0
		jmp sub_change_state_and_chr

	@pit_mid_clouds:
	cmp #$01
	bne @pit_bottom
	
		; Middle clouds
		sta mmc3_irq_disable
		sta mmc3_irq_enable
		lda #$15
		sta mmc3_irq_latch

		lda PpuStatus_2002

		lda zp_frame_counter
		and #$03
		bne :+
			inc ram_irq_counter_1
		:
		lda ram_irq_counter_1
		clc
		adc zp_irq_hor_scroll
		sta PpuScroll_2005
		inc ram_irq_state_var
		rts

	@pit_bottom:
	; Bottom
	sta mmc3_irq_disable
	lda PpuStatus_2002
	lda zp_irq_hor_scroll
	sta PpuScroll_2005

	lda #$00
	sta ram_irq_state_var

	rts

; -----------------------------------------------------------------------------

; Warrior Shrine split-screen
sub_irq_handler_02:
	lda ram_irq_state_var
	bne :+
		; Top
		sta mmc3_irq_disable
		sta mmc3_irq_enable
		lda #$40
		sta mmc3_irq_latch
		lda PpuStatus_2002
		lda zp_irq_hor_scroll
		sta PpuScroll_2005
		ldy #$E4
		jmp sub_change_state_and_chr
	:
	; Bottom
	sta mmc3_irq_disable

	ldy #$E8
	lda #$00
	sta ram_irq_state_var
	lda #$82
	ora zp_bank_select_mask
	tax
	stx mmc3_bank_select
	sty mmc3_bank_data
	inx
	iny
	stx mmc3_bank_select
	sty mmc3_bank_data
	inx
	iny
	stx mmc3_bank_select
	sty mmc3_bank_data
	inx
	iny
	stx mmc3_bank_select
	lda zp_game_substate
	cmp #$05
	bcs @E54E

		lda zp_frame_counter
		and #$1F

	bne :+
		inc ram_irq_counter_0
	:	
	lda ram_irq_counter_0
	and #$01
	tax
	ldy @rom_E564,X
	sty mmc3_bank_data
	rts
; ----------------
	@E54E:
	lda zp_frame_counter
	and #$07
	bne :+
		inc ram_irq_counter_0
	:	
	lda ram_irq_counter_0
	and #$01
	tax
	ldy @rom_E566,X
	sty mmc3_bank_data
	rts

; ----------------

; CHR bank indices
	@rom_E564:
	.byte $EC, $ED

; CHR bank indices
	@rom_E566:
	.byte $EE, $EF

; -----------------------------------------------------------------------------

; TODO Fix timing for bottom part of the screen in two player mode
; Temple entrance stage
sub_irq_handler_03:
	lda ram_irq_state_var
	bne :+

		sta mmc3_irq_disable
		sta mmc3_irq_enable
		lda #$5F
		sta mmc3_irq_latch
		lda PpuStatus_2002
		lda zp_irq_hor_scroll
		sta PpuScroll_2005
		ldy #$1C
		jmp sub_change_state_and_chr
	:
	sta mmc3_irq_disable
	lda PpuStatus_2002
	lda zp_irq_hor_scroll
	sta PpuScroll_2005
	lda #$00
	sta ram_irq_state_var
	ldy #$20
	jmp sub_rom_E41E

; -----------------------------------------------------------------------------

sub_irq_handler_04:
	lda ram_irq_state_var

	bne :+
		; Top
		sta mmc3_irq_disable
		sta mmc3_irq_enable
		lda #$40
		sta mmc3_irq_latch
		lda PpuStatus_2002
		lda zp_irq_hor_scroll
		sta PpuScroll_2005
		ldy #$24
		jmp sub_change_state_and_chr
	:
	; Bottom
	sta mmc3_irq_disable
	lda PpuStatus_2002
	lda zp_irq_hor_scroll
	sta PpuScroll_2005
	lda #$00
	sta ram_irq_state_var
	ldy #$28
	jmp sub_rom_E41E

; -----------------------------------------------------------------------------

sub_irq_handler_05:
	lda ram_irq_state_var
	bne :+
		sta mmc3_irq_disable
		sta mmc3_irq_enable
		lda #$48
		sta mmc3_irq_latch
		lda PpuStatus_2002
		lda zp_irq_hor_scroll
		sta PpuScroll_2005
		ldy #$2C
		jmp sub_change_state_and_chr
	:
	sta mmc3_irq_disable
	lda PpuStatus_2002
	lda zp_irq_hor_scroll
	sta PpuScroll_2005
	lda #$00
	sta ram_irq_state_var
	ldy #$30
	jmp sub_rom_E41E

; -----------------------------------------------------------------------------

sub_irq_handler_06:
	sta mmc3_irq_disable
	ldx zp_03
	lda zp_game_substate
	cmp #$03
	bcc @E3C0

		cmp #$04
		bne @E3AF

			lda ram_0414
			cmp #$C0
			beq @E3C0

		@E3AF:
		lda zp_frame_counter
		and #$01
		bne @E3C0
		inc ram_0414
		bne @E3C0

		txa
		eor #$03
		tax
		stx zp_03

	@E3C0:
	lda PpuStatus_2002
	stx PpuControl_2000
	lda PpuStatus_2002
	lda ram_0414
	sta PpuScroll_2005

	lda #$82
	ora zp_bank_select_mask
	tax

	stx mmc3_bank_select
	lda #$B0
	sta mmc3_bank_data
	inx
	stx mmc3_bank_select
	inx
	sta mmc3_bank_data
	inx
	stx mmc3_bank_select
	lda #$B2
	sta mmc3_bank_data
	inx
	stx mmc3_bank_select
	lda #$B3
	sta mmc3_bank_data

	lda #$00
	sta ram_irq_state_var
	lda ram_0421
	beq @E406

		ora #$F0
		sta ram_0421
	@E406:
	rts

; -----------------------------------------------------------------------------

sub_irq_handler_07:
	rts

; -----------------------------------------------------------------------------

sub_rom_E408:
	sta mmc3_irq_disable
	lda PpuStatus_2002
	lda zp_irq_hor_scroll ;a:zp_81
	sta PpuScroll_2005
	lda #$00
	sta PpuScroll_2005
	ldy #$DC
; ----------------
sub_change_state_and_chr:
	inc ram_irq_state_var
; ----------------
sub_rom_E41E:
	lda #$82
	ora zp_bank_select_mask
	tax
	stx mmc3_bank_select
	sty mmc3_bank_data
	inx
	iny
	stx mmc3_bank_select
	sty mmc3_bank_data
	inx
	iny
	stx mmc3_bank_select
	sty mmc3_bank_data
	inx
	iny
	stx mmc3_bank_select
	sty mmc3_bank_data
	rts

; -----------------------------------------------------------------------------

sub_irq_handler_0C:
	sta mmc3_irq_disable
	lda #$00
	sta ram_irq_state_var
	rts

; -----------------------------------------------------------------------------

sub_irq_handler_0D:
	sta mmc3_irq_disable

	; Timing for split-screen
	ldy #$14
	:
	dey
	bne :-

	lda #$80
	ora zp_bank_select_mask
	tax

	stx mmc3_bank_select
	lda #$F4
	sta mmc3_bank_data
	inx
	stx mmc3_bank_select
	lda #$F6
	sta mmc3_bank_data
	inx
	lda #$F4
	stx mmc3_bank_select
	sta mmc3_bank_data
	inx
	lda #$F5
	stx mmc3_bank_select
	sta mmc3_bank_data
	inx
	lda #$F6
	stx mmc3_bank_select
	sta mmc3_bank_data
	inx
	lda #$F7
	stx mmc3_bank_select
	sta mmc3_bank_data

	php	; Timing
	plp
	nop

	lda PpuStatus_2002
	lda zp_ppu_ptr_hi
	sta PpuAddr_2006
	lda zp_ppu_ptr_lo
	sta PpuAddr_2006
	lda #$00
	sta PpuScroll_2005
	sta PpuScroll_2005
	lda #$00
	sta ram_irq_state_var

	rts

; -----------------------------------------------------------------------------
sub_irq_handler_0E:
	lda ram_irq_state_var
	beq :+
		lda PpuStatus_2002
		lda #$88
		sta PpuControl_2000
		jmp sub_irq_handler_0C
	:
	sta mmc3_irq_disable
	sta mmc3_irq_enable
	lda #$0E
	sta mmc3_irq_latch
	lda PpuStatus_2002
	lda #$89
	sta PpuControl_2000
	inc ram_irq_state_var

	rts

; -----------------------------------------------------------------------------

sub_irq_handler_0F:
	sta mmc3_irq_disable

	lda #$82
	ora zp_bank_select_mask

	tax
	lda #$54
	stx mmc3_bank_select
	sta mmc3_bank_data
	inx
	lda #$55
	stx mmc3_bank_select
	sta mmc3_bank_data
	inx
	lda #$56
	stx mmc3_bank_select
	sta mmc3_bank_data
	inx
	lda #$57
	stx mmc3_bank_select
	sta mmc3_bank_data
	
	jmp sub_irq_handler_0C

; -----------------------------------------------------------------------------

; Used by the sound test menu to display volume bars
sub_irq_handler_10:
	sta mmc3_irq_disable

	lda ram_irq_state_var
	bne :+
		; We only need to do this set up once
		ldx #$00
		ldy #$04
		@irq10_setup_loop:
			lda #$90
			sta ram_oam_copy_ypos+4,X
			tya
			sbc #$00
			sta ram_oam_copy_attr+4,X
			lda @tbl_irq10_sprite_xpos,Y
			sta ram_oam_copy_xpos+4,X
			; X = X + 4
			txa
			axs #$FC
		dey
		bne @irq10_setup_loop

		inc ram_irq_state_var
	:
	; Read volume and show a sprite for each channel depending on the value
	; TODO Change the palette depending on volume?
	ldx #$00
	ldy #$00
	:
		lda ram_apu_output_volume,Y
		lsr
		adc #$E0
		sta ram_oam_copy_tileid+4,X

		txa
		axs #$FC
	iny
	cpy #$04
	bne :-
	
	@tbl_irq10_sprite_xpos:
	rts	; We need exactly one byte here to offset our data
; ----------------
	.byte $C0, $B0, $48, $38

; -----------------------------------------------------------------------------

; "Idle" IRQ handler
sub_irq_handler_11:
	sta mmc3_irq_disable
	lda #$00
	sta ram_irq_state_var
	rts

; -----------------------------------------------------------------------------
.export sub_state_machine_start

sub_state_machine_start:
	lda zp_machine_state_0
	jsr sub_trampoline	; The sub will pull from the stack and jump, so this is
						; basically a JMP with parameter from the table below
; ----------------
	.word sub_state_menus			; $00
	.word sub_state_match			; $01
	.word sub_rom_E7F5				; $02
	.word sub_clear_machine_states	; $03
	.word sub_rom_E889				; $04
	.word sub_rom_E893				; $05
	.word sub_rom_E89B				; $06

; -----------------------------------------------------------------------------

; Called if Machine State 0 is 0
; Bank $04 in $8000-$9FFF
; Bank $05 in $A000-$BFFF
; Then jumps to $B000 (first routine in bottom half of bank 5)
sub_state_menus:
	lda #$80
	sta zp_bank_select_mask

	lda #$04
	ldx #$86
	stx mmc3_bank_select
	sta mmc3_bank_data
	lda #$05
	inx
	stx mmc3_bank_select
	sta mmc3_bank_data

	jmp sub_state_machine_0

; -----------------------------------------------------------------------------

; Called if State Machine 0 is 2
sub_rom_E7F5:
	lda #$00
	sta zp_machine_state_2
	sta zp_machine_state_0

	ldx ram_040C
	lda zp_plr1_fighter_idx,X
	bpl @E80B

		; Single player continue screen
		@E805:
		; New machine state: 0,4,0
		lda #$04
		sta zp_machine_state_1
		rts
; ----------------
	; Two players continue screen
	@E80B:
	lda zp_plr1_fighter_idx
	eor zp_plr2_fighter_idx
	and #$80
	beq @E805

		lda #$03
		sta zp_machine_state_1
		lda ram_0100
		asl A
		asl A
		clc
		adc zp_endurance_flag
		tax
		inc zp_61
		lda zp_61
		cmp @rom_E849,X
		bcc :+

			lda #$00
			sta zp_61
			inc zp_endurance_flag
			lda zp_endurance_flag
			cmp #$04
			bcc :+

				; New machine state: 0,6,0
				lda #$00
				sta zp_machine_state_2
				lda #$06
				sta zp_machine_state_1
	:
	rts

; ----------------

	@rom_E849:
	.byte $07, $03, $01, $01, $0E, $03, $01, $01

; -----------------------------------------------------------------------------

; Sets all state machine variables to zero
; Basically brings back to the titles screen
sub_clear_machine_states:
	lda #$00
	;;sta a:zp_machine_state_2	; ???
	sta zp_machine_state_2
	sta zp_machine_state_1
	sta zp_machine_state_0
	;;lda #$00
	;sta a:zp_machine_state_1	; ???
	;sta a:zp_machine_state_0	; ???
	rts

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_E889:
	lda #$06
	sta ram_irq_routine_idx
	ldx #$02
	lda #$01
	rts

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_E893:
	lda #$00
	sta zp_machine_state_0
	lda #$00
	rts

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_E89B:
	lda zp_controller1
	and #$40	; Button B
	beq @E8A7

		lda #$00
		sta ram_040C
	@E8A7:
	lda zp_controller1
	and #$80	; Button A
	beq @E8B3

		lda #$01
		sta ram_040C
	@E8B3:
	lda zp_controller1
	and #$10	; Start Button
	beq @E8C4

	lda zp_5E
	bne @E8C5

		lda #$02
		sta zp_machine_state_0
	@E8C4:
	rts
; ----------------
	@E8C5:
	lda #$03
	sta zp_machine_state_0
	rts

; -----------------------------------------------------------------------------
.export sub_sound_playlist

; Check if we need to play a new music or sfx
sub_sound_playlist:
	lda #$80
	sta zp_bank_select_mask

	lda #$86
	sta mmc3_bank_select
	lda #$02
	sta mmc3_bank_data
	lda #$87
	sta zp_bank_select_mask
	sta mmc3_bank_select
	lda #$03
	sta mmc3_bank_data
	
	lda ram_req_song
	cmp ram_cur_song
	bne @E8F3

		lda ram_req_sfx
		bne @E8F9

	rts
; ----------------
	@E8F3:
	lda ram_req_song
	sta ram_cur_song
	@E8F9:
	jsr sub_play_new_song_or_sfx

	lda #$00
	sta ram_req_sfx
	rts

; -----------------------------------------------------------------------------
;.export sub_play_new_song_or_sfx

; Parameters:
; A = index of the SFX or music track to play
sub_play_new_song_or_sfx:
	tax
	ldy #$FF
	@AAEF:
	cpy #$07
	beq :+

		; Read from $0701 to $0707, or until a value with bit 7 set is found
		iny
		lda ram_snd_stack,Y

		bpl @AAEF

		; ...then put the sound index where that value was found
		txa
		sta ram_snd_stack,Y
	:
	rts

; -----------------------------------------------------------------------------
.export sub_oam_update

sub_oam_update:
	ldx #$20
	lda zp_players_x_distance
	cmp #$18	; Throw move
	bcs @E910

	lda zp_players_y_distance
	beq @E917

	@E910:
	lda ram_0675
	and #$20
	bne @E91D

	@E917:
	lda zp_8C
	jmp @E920

	@E91D:
	lda zp_frame_counter
	@E920:
	and #$02
	bne @E995

	lda zp_frame_counter
	and #$01
	bne @E960

	@E92B:
	dex
	lda ram_oam_copy_ypos,X
	sta ram_oam_data,X
	lda ram_0320,X
	sta ram_0220,X
	lda ram_0340,X
	sta ram_0240,X
	lda ram_0360,X
	sta ram_0260,X
	lda ram_0380,X
	sta ram_0280,X
	lda ram_03A0,X
	sta ram_02A0,X
	lda ram_03C0,X
	sta ram_02C0,X
	lda ram_03E0,X
	sta ram_02E0,X
	txa
	bne @E92B

	rts
; ----------------
	@E960:
	dex
	lda ram_oam_copy_ypos,X
	sta ram_0280,X
	lda ram_0320,X
	sta ram_02A0,X
	lda ram_0340,X
	sta ram_02C0,X
	lda ram_0360,X
	sta ram_02E0,X
	lda ram_0380,X
	sta ram_oam_data,X
	lda ram_03A0,X
	sta ram_0220,X
	lda ram_03C0,X
	sta ram_0240,X
	lda ram_03E0,X
	sta ram_0260,X
	txa
	bne @E960

	rts
; ----------------
	@E995:
	lda zp_frame_counter ;a:zp_frame_counter
	and #$01
	bne @E9D1

	@E99C:
	dex
	lda ram_oam_copy_ypos,X
	sta ram_0240,X
	lda ram_0320,X
	sta ram_0260,X
	lda ram_0340,X
	sta ram_oam_data,X
	lda ram_0360,X
	sta ram_0220,X
	lda ram_0380,X
	sta ram_02C0,X
	lda ram_03A0,X
	sta ram_02E0,X
	lda ram_03C0,X
	sta ram_0280,X
	lda ram_03E0,X
	sta ram_02A0,X
	txa
	bne @E99C

	rts
; ----------------
	@E9D1:
	dex
	lda ram_oam_copy_ypos,X
	sta ram_02C0,X
	lda ram_0320,X
	sta ram_02E0,X
	lda ram_0340,X
	sta ram_0280,X
	lda ram_0360,X
	sta ram_02A0,X
	lda ram_0380,X
	sta ram_0240,X
	lda ram_03A0,X
	sta ram_0260,X
	lda ram_03C0,X
	sta ram_oam_data,X
	lda ram_03E0,X
	sta ram_0220,X
	txa
	bne @E9D1

	rts

; -----------------------------------------------------------------------------

; Called if Machine State 0 is 1 (game)
sub_state_match:
	lda #$2F
	sta ram_irq_latch_value
	lda zp_5E ;a:zp_5E
	beq @EA2A

		lda zp_controller1_new
		and #$10	; Start Button
		beq @EA53

			lda #$09
			sta zp_game_substate ;a:zp_7A
			rts
; ----------------
	@EA2A:
	lda zp_controller1_new ;a:zp_controller1_new
	and #$10	; Start Button
	beq @EA4D

	lda zp_game_substate
	cmp #$03
	bne @EA53
	lda ram_0438
	bne @EA53

	jsr sub_pause_game
	lda #$0E	; Pause sound
	sta ram_req_sfx
	lda zp_24
	eor #$01
	sta zp_24
	@EA4D:
	lda zp_24
	beq @EA53

	rts
; ----------------
	@EA53:
	lda #$80
	sta zp_bank_select_mask

	; Banks 0, 1 on top of PRG ROM space
	ldx #$86
	stx mmc3_bank_select
	lda #$00
	sta mmc3_bank_data

	inx
	stx mmc3_bank_select
	lda #$01
	sta mmc3_bank_data

	jmp sub_state_machine_1

; -----------------------------------------------------------------------------

sub_pause_game:
	ldx #$00
	lda #$F8
	@EA5F:
	sta ram_oam_copy_ypos,X
	inx
	inx
	inx
	inx
	bne @EA5F
	
	lda #$0E
	sta ram_oam_copy_ypos
	sta ram_0304
	sta ram_0308
	sta ram_030C
	sta ram_0310
	lda #$6C
	sta ram_oam_copy_xpos
	lda #$74
	sta ram_0307
	lda #$7C
	sta ram_030B
	lda #$84
	sta ram_030F
	lda #$8C
	sta ram_0313
	lda #$03
	sta ram_oam_copy_attr
	sta ram_0306
	sta ram_030A
	sta ram_030E
	sta ram_0312
	lda #$D0
	sta ram_oam_copy_tileid
	lda #$C1
	sta ram_0305
	lda #$D5
	sta ram_0309
	lda #$D3
	sta ram_030D
	lda #$C5
	sta ram_0311
	lda #$DA
	sta zp_chr_bank_1 ;a:zp_chr_bank_1
	rts

; -----------------------------------------------------------------------------
.export sub_call_sound_routines

; This is only used to play one extra tick of music in-between loading
; RLE-packed nametables, to reduce the music slowdown.
; No DMC should be playing when this is called.
sub_call_sound_routines:
	lda #$80
	sta zp_bank_select_mask

	; PRG ROM $8000-$9FFF <-- Bank $02 (sound data)
	lda #$86
	sta mmc3_bank_select
	lda #$02
	sta mmc3_bank_data
	; PRG ROM $8000-$9FFF <-- Bank $03 (sound and moves code)
	lda #$87
	sta mmc3_bank_select
	lda #$03
	sta mmc3_bank_data

	jsr sub_process_all_sound

	lda #$80
	sta zp_bank_select_mask
	; Switch back to PRG ROM Banks $04 and $05
	lda #$86
	sta mmc3_bank_select
	lda #$04
	sta mmc3_bank_data
	; PRG ROM $8000-$9FFF <-- Bank $03 (sound and moves code)
	lda #$87
	ora zp_bank_select_mask
	sta mmc3_bank_select
	lda #$05
	sta mmc3_bank_data
	
	rts

; -----------------------------------------------------------------------------
.export sub_call_gfx_routines

sub_call_gfx_routines:
	lda #$87
	ora zp_bank_select_mask
	sta mmc3_bank_select
	lda #$03
	sta mmc3_bank_data

	jsr sub_rom_03_A5E4
	jsr sub_rom_03_A000

	lda #$87
	ora zp_bank_select_mask
	sta mmc3_bank_select
	lda #$01
	sta mmc3_bank_data
	rts

; -----------------------------------------------------------------------------
