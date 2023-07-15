.segment "BANK_0F"
; $E000-FFFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"

sub_rom_8000 = $8000	; Likely unused, leftover from a different game
rom_8C00 = $8C00		; Likely unused, leftover from a different game


; -----------------------------------------------------------------------------
.export reset

reset:
	sei
	cld
	ldx #$FF
	txs

	lda #$00
	sta PpuMask_2001
	sta PpuControl_2000

	ldx #$02
	@E00F:
	bit PpuStatus_2002
	bpl @E00F
	:
		lda PpuStatus_2002
	bmi :-
	dex
	bne @E00F

	lda #$0F
	sta ApuStatus_4015
	lda #$00
	sta DmcFreq_4010
	lda #$40
	sta Ctrl2_FrameCtr_4017
	sta mmc3_irq_disable
	lda #$80
	sta mmc3_ram_protect
	lda PpuStatus_2002

	;lda #$10
	;tax
	lax #$10
	:
		sta PpuAddr_2006
		sta PpuAddr_2006
		eor #$10
		dex
	bne :-

	sta mmc3_irq_disable

	lda #$00
	sta ram_0100
	;lda #$00
	sta ram_042D

	lda #$0C
	sta ram_irq_routine_idx

	jsr sub_rom_E22A

	lda #$00
	jsr sub_clear_nametable
	lda #$01
	jsr sub_clear_nametable
	lda #$03
	sta ram_difficulty_setting
	jsr sub_clear_nametable

	jsr sub_hide_all_sprites
	; PRG ROM $8000-$9FFF <-- Bank $02
	lda #$86
	sta zp_prg_bank_select_backup	;sta a:zp_FC
	sta mmc3_bank_select
	lda #$02
	sta mmc3_bank_data
	; PRG ROM $A000-$BFFF <-- Bank $03
	lda #$87
	sta zp_prg_bank_select_backup	;sta a:zp_FC
	sta mmc3_bank_select
	lda #$03
	sta mmc3_bank_data

	jsr sub_apu_init

	; This will not actually play anything, because the apu initialised flag is clear
	lda #$22
	sta ram_req_song
	sta ram_cur_song	; This should have the same effect
	;jsr sub_play_new_song_or_sfx
	inc ram_snd_initialised	; Sounds will start playing after this

	lda #$00
	sta zp_28
	lda #$01
	sta zp_mmc3_irq_ready	;sta a:zp_mmc3_irq_ready
	lda #$88
	sta ram_0409
	lda #$13
	sta ram_040A
	lda #$00
	sta ram_040B
	lda #$01
	sta ram_041A
	lda #$00
	sta ram_0416
	lda #$02
	sta ram_0419
	lda #$1F
	sta ram_0400
	lda #$00
	sta ram_0435
	lda #$4C
	sta ram_irq_trampoline
	cli
	lda #$88
	sta zp_ppu_control_backup
	sta PpuControl_2000
	lda #$00
	sta zp_ppu_mask_backup
	sta PpuMask_2001

	@main_loop:
		inc zp_22
		lda zp_F7
	beq @main_loop

		dec zp_F7
		lda #$01
		sta zp_FD

		jsr sub_state_machine_start
		jsr sub_rom_E902
		jsr sub_rom_E8CB

		; PRG ROM $8000-$9FFF <-- Bank $02 (sound data)
		lda #$86
		sta zp_prg_bank_select_backup	;sta a:zp_prg_bank_select_backup
		sta mmc3_bank_select
		lda #$02
		sta mmc3_bank_data
		; PRG ROM $8000-$9FFF <-- Bank $03 (sound and moves code)
		lda #$87
		sta zp_prg_bank_select_backup	;sta a:zp_prg_bank_select_backup
		sta mmc3_bank_select
		lda #$03
		sta mmc3_bank_data

		jsr sub_process_all_sound

		lda #$00
		sta zp_FD

	jmp @main_loop

; -----------------------------------------------------------------------------

irq:
	php
	pha
	txa
	pha
	tya
	pha
	jsr ram_irq_trampoline
	pla
	tay
	pla
	tax
	pla
	plp
	rti

; -----------------------------------------------------------------------------

nmi:
	php
	pha
	txa
	pha
	tya
	pha

	lda #$00
	sta OamAddr_2003
	lda PpuStatus_2002
	and #$20
	sta ram_0675
	lda #$02
	sta SpriteDma_4014

	lda zp_FD
	bne @E155

	lda zp_nmi_ppu_ptr_hi
	beq @E14C

		jsr sub_do_ppu_transfer

	@E14C:
	lda zp_machine_state_0
	cmp #$01
	bne @E155

		lda #$86
		sta mmc3_bank_select
		lda #$00
		sta mmc3_bank_data
		jsr sub_update_health_bars
		lda #$86
		sta mmc3_bank_select
		lda #$02
		sta mmc3_bank_data

	@E155:
	lda PpuStatus_2002

	lda zp_scroll_x
	sta PpuScroll_2005
	lda zp_scroll_y
	sta PpuScroll_2005
	lda zp_ppu_control_backup
	sta PpuControl_2000
	lda zp_ppu_mask_backup
	sta PpuMask_2001
	lda zp_mmc3_irq_ready ;a:zp_mmc3_irq_ready
	beq @E186
	
		lda ram_0416
		sta ram_0418
		jsr sub_select_irq_handler
		lda ram_irq_latch_value
		sta mmc3_irq_latch
		sta mmc3_irq_reload
		sta mmc3_irq_enable
		
	@E186:
	lda #$80
	sta mmc3_bank_select
	lda zp_chr_bank_0 ;a:zp_chr_bank_0
	sta mmc3_bank_data
	lda #$81
	sta mmc3_bank_select
	lda zp_chr_bank_1 ;a:zp_chr_bank_1
	sta mmc3_bank_data
	lda zp_machine_state_0
	bne @E1CC

		ldx #$82
		lda zp_chr_bank_2
		stx mmc3_bank_select
		sta mmc3_bank_data
		ldx #$83
		lda zp_chr_bank_3
		stx mmc3_bank_select
		sta mmc3_bank_data
		ldx #$84
		lda zp_chr_bank_4
		stx mmc3_bank_select
		sta mmc3_bank_data
		ldx #$85
		lda zp_chr_bank_5
		stx mmc3_bank_select
		sta mmc3_bank_data
		jmp @E1F2

	@E1CC:
	lda #$82
	sta mmc3_bank_select
	ldx zp_34
	stx mmc3_bank_data
	lda #$83
	sta mmc3_bank_select
	inx
	stx mmc3_bank_data
	lda #$84
	sta mmc3_bank_select
	ldx zp_35
	stx mmc3_bank_data
	lda #$85
	sta mmc3_bank_select
	inx
	stx mmc3_bank_data
	@E1F2:
	inc zp_frame_counter
	jsr sub_get_controller_input
	lda zp_FD ;a:zp_FD
	bne @E201

		lda #$01
		sta zp_F7 ;a:zp_F7

	@E201:
	lda zp_prg_bank_select_backup ;a:zp_prg_bank_select_backup
	sta mmc3_bank_select

	pla
	tay
	pla
	tax
	pla
	plp
	rti

; -----------------------------------------------------------------------------
sub_rom_E22A:
	lda #$00
	tay
	sta zp_00
	sta zp_01
	@E231:
	sta (zp_00),Y
	iny
	bne @E231

	ldx #$02
	stx zp_01
	@E23A:
	sta (zp_00),Y
	iny
	bne @E23A

	inc zp_01
	inx
	cpx #$08
	bcc @E23A

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
	lda ram_0435

	bne :+
		; Top
		sta mmc3_irq_disable
		sta mmc3_irq_enable
		lda #$1B
		sta mmc3_irq_latch
		lda PpuStatus_2002

		lda zp_frame_counter
		and #$07
		bne @E497
			inc ram_043F
		@E497:
		lda ram_043F
		clc
		adc zp_irq_hor_scroll
		sta PpuScroll_2005
		ldy #$E0		
		jmp sub_rom_E41B
	:
	cmp #$01
	bne :+
		; Middle
		sta mmc3_irq_disable
		sta mmc3_irq_enable
		lda #$15
		sta mmc3_irq_latch
		lda PpuStatus_2002

		lda zp_frame_counter
		and #$03
		bne @E4BD
			inc ram_0440
		@E4BD:
		lda ram_0440
		clc
		adc zp_irq_hor_scroll
		sta PpuScroll_2005
		inc ram_0435
	:
	; Bottom
	sta mmc3_irq_disable
	lda PpuStatus_2002
	lda zp_irq_hor_scroll
	sta PpuScroll_2005
	lda #$00
	sta ram_0435
	rts

; -----------------------------------------------------------------------------

sub_irq_handler_02:
	lda ram_0435
	bne :+
	
		sta mmc3_irq_disable
		sta mmc3_irq_enable
		lda #$40
		sta mmc3_irq_latch
		lda PpuStatus_2002
		lda zp_irq_hor_scroll
		sta PpuScroll_2005
		ldy #$E4
		jmp sub_rom_E41B
	:
	sta mmc3_irq_disable
	ldy #$E8
	lda #$00
	sta ram_0435
	ldx #$82
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
		inc ram_043F
	:	
	lda ram_043F
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
		inc ram_043F
	:	
	lda ram_043F
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

sub_irq_handler_03:
	lda ram_0435
	bne :+

		sta mmc3_irq_disable
		sta mmc3_irq_enable
		lda #$63
		sta mmc3_irq_latch
		lda PpuStatus_2002
		lda zp_irq_hor_scroll ;a:zp_81
		sta PpuScroll_2005
		ldy #$1C
		jmp sub_rom_E41B
	:
	sta mmc3_irq_disable
	lda PpuStatus_2002
	lda zp_irq_hor_scroll ;a:zp_81
	sta PpuScroll_2005
	lda #$00
	sta ram_0435
	ldy #$20
	jmp sub_rom_E41E

; -----------------------------------------------------------------------------

sub_irq_handler_04:
	lda ram_0435

	bne :+
		; Top
		sta mmc3_irq_disable
		sta mmc3_irq_enable
		lda #$40
		sta mmc3_irq_latch
		lda PpuStatus_2002
		lda zp_irq_hor_scroll ;a:zp_81
		sta PpuScroll_2005
		ldy #$24
		jmp sub_rom_E41B
	:
	; Bottom
	sta mmc3_irq_disable
	lda PpuStatus_2002
	lda zp_irq_hor_scroll ;a:zp_81
	sta PpuScroll_2005
	lda #$00
	sta ram_0435
	ldy #$28
	jmp sub_rom_E41E

; -----------------------------------------------------------------------------

sub_irq_handler_05:
	lda ram_0435
	bne :+
		sta mmc3_irq_disable
		sta mmc3_irq_enable
		lda #$48
		sta mmc3_irq_latch
		lda PpuStatus_2002
		lda zp_irq_hor_scroll ;a:zp_81
		sta PpuScroll_2005
		ldy #$2C
		jmp sub_rom_E41B
	:
	sta mmc3_irq_disable
	lda PpuStatus_2002
	lda zp_irq_hor_scroll ;a:zp_81
	sta PpuScroll_2005
	lda #$00
	sta ram_0435
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
	sta mmc3_bank_select
	lda #$B0
	sta mmc3_bank_data
	lda #$83
	sta mmc3_bank_select
	lda #$B1
	sta mmc3_bank_data
	lda #$84
	sta mmc3_bank_select
	lda #$B2
	sta mmc3_bank_data
	lda #$85
	sta mmc3_bank_select
	lda #$B3
	sta mmc3_bank_data
	lda #$00
	sta ram_0435
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
sub_rom_E41B:
	inc ram_0435
; ----------------
sub_rom_E41E:
	ldx #$82
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
	sta ram_0435
	rts

; -----------------------------------------------------------------------------

sub_irq_handler_0D:
	sta mmc3_irq_disable
	ldy #$12
	@E6DA:
	dey
	bne @E6DA
	lda #$80
	sta mmc3_bank_select
	lda #$F4
	sta mmc3_bank_data
	lda #$81
	sta mmc3_bank_select
	lda #$F6
	sta mmc3_bank_data
	ldx #$82
	lda #$F4
	stx mmc3_bank_select
	sta mmc3_bank_data
	ldx #$83
	lda #$F5
	stx mmc3_bank_select
	sta mmc3_bank_data
	ldx #$84
	lda #$F6
	stx mmc3_bank_select
	sta mmc3_bank_data
	ldx #$85
	lda #$F7
	stx mmc3_bank_select
	sta mmc3_bank_data
	lda PpuStatus_2002
	lda zp_ppu_ptr_hi
	sta PpuAddr_2006
	lda zp_ppu_ptr_lo
	sta PpuAddr_2006
	lda #$00
	sta PpuScroll_2005
	sta PpuScroll_2005
	lda #$00
	sta ram_0435
	rts

; -----------------------------------------------------------------------------
sub_irq_handler_0E:
	lda ram_0435
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
	inc ram_0435

	rts

; -----------------------------------------------------------------------------

sub_irq_handler_0F:
	sta mmc3_irq_disable
	ldx #$82
	lda #$54
	stx mmc3_bank_select
	sta mmc3_bank_data
	ldx #$83
	lda #$55
	stx mmc3_bank_select
	sta mmc3_bank_data
	ldx #$84
	lda #$56
	stx mmc3_bank_select
	sta mmc3_bank_data
	ldx #$85
	lda #$57
	stx mmc3_bank_select
	sta mmc3_bank_data
	jmp sub_irq_handler_0C

; -----------------------------------------------------------------------------

; Used by the sound test menu to display volume bars
sub_irq_handler_10:
	sta mmc3_irq_disable

	lda ram_0435
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

		inc ram_0435
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
	sta ram_0435
	rts

; -----------------------------------------------------------------------------

sub_state_machine_start:
	;lda a:zp_machine_state_0
	lda zp_machine_state_0
	jsr sub_trampoline	; The sub will pull from the stack and jump, so this is
						; basically a JMP with parameter from the table below
; ----------------
	.word sub_prg_banks_4_5			; $00
	.word sub_rom_EA13				; $01
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
sub_prg_banks_4_5:
	lda #$04
	ldx #$86
	stx mmc3_bank_select
	sta mmc3_bank_data
	lda #$05
	ldx #$87
	stx mmc3_bank_select
	sta mmc3_bank_data
	jmp sub_state_machine_0

; -----------------------------------------------------------------------------

; Called if State Machine 0 is 2
sub_rom_E7F5:
	lda #$00
	sta a:zp_machine_state_2
	sta a:zp_machine_state_0

	ldx ram_040C
	lda zp_plr1_fighter_idx,X ;a:zp_F2,X
	bpl @E80B

		@E805:
		lda #$04
		sta zp_machine_state_1 ;a:zp_machine_state_1
		rts
; ----------------
	@E80B:
	lda zp_plr1_fighter_idx ;a:zp_F2
	eor zp_plr2_fighter_idx ;a:zp_F3
	and #$80
	beq @E805

		lda #$03
		sta zp_machine_state_1 ;a:zp_machine_state_1
		lda ram_0100
		asl A
		asl A
		clc
		adc zp_5F ;a:zp_5F
		tax
		inc zp_61 ;a:zp_61
		lda zp_61 ;a:zp_61
		cmp rom_E849,X
		bcc :+

			lda #$00
			sta zp_61 ;a:zp_61
			inc zp_5F ;a:zp_5F
			lda zp_5F ;a:zp_5F
			cmp #$04
			bcc :+

				; New machine state: 2,6,0
				lda #$00
				sta zp_machine_state_2 ;a:zp_machine_state_2
				lda #$06
				sta zp_machine_state_1 ;a:zp_machine_state_1
	:
	rts

; -----------------------------------------------------------------------------

rom_E849:
	.byte $07, $03, $01, $01, $0E, $03, $01, $01

; -----------------------------------------------------------------------------

; Sets all state machine variables to zero
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

sub_rom_E889:
	lda #$06
	sta ram_irq_routine_idx
	ldx #$02
	lda #$01
	rts

; -----------------------------------------------------------------------------

sub_rom_E893:
	lda #$00
	sta a:zp_machine_state_0	; ???
	lda #$00
	rts

; -----------------------------------------------------------------------------

sub_rom_E89B:
	lda zp_controller1 ;a:zp_controller1
	and #$40	; Button B
	beq @E8A7

		lda #$00
		sta ram_040C
	@E8A7:
	lda zp_controller1 ;a:zp_controller1
	and #$80	; Button A
	beq @E8B3

		lda #$01
		sta ram_040C
	@E8B3:
	lda zp_controller1 ;a:zp_controller1
	and #$10	; Start Button
	beq @E8C4

	lda zp_5E ;a:zp_5E
	bne @E8C5

		lda #$02
		sta zp_machine_state_0 ;a:zp_machine_state_0
	@E8C4:
	rts
; ----------------
	@E8C5:
	lda #$03
	sta zp_machine_state_0 ;a:zp_machine_state_0
	rts

; -----------------------------------------------------------------------------

; Sound / music stuff
sub_rom_E8CB:
	lda #$86
	sta zp_prg_bank_select_backup ;a:zp_prg_bank_select_backup
	sta mmc3_bank_select
	lda #$02
	sta mmc3_bank_data
	lda #$87
	sta zp_prg_bank_select_backup ;a:zp_prg_bank_select_backup
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

sub_rom_E902:
	ldx #$20
	lda zp_players_x_distance ;a:zp_9C
	cmp #$18
	bcs @E910

	lda zp_players_y_distance ;a:zp_9D
	beq @E917

	@E910:
	lda ram_0675
	and #$20
	bne @E91D

	@E917:
	lda zp_8C ;a:zp_8C
	jmp @E920

	@E91D:
	lda zp_frame_counter ;a:zp_frame_counter
	@E920:
	and #$02
	bne @E995

	lda zp_frame_counter ;a:zp_frame_counter
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

; Potentially unused
sub_rom_EA06:
	lda zp_controller1
	and #$30
	eor #$30
	bne :+
		jmp sub_rom_8000
	:
	rts

; -----------------------------------------------------------------------------

; Called if Machine State 0 is 1 (game)
sub_rom_EA13:
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

	jsr sub_rom_EA5B
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
	;jmp sub_rom_EA57	; jsr sub_rom_EA57
	;rts
	lda #$86
	sta mmc3_bank_select
	lda #$00
	sta mmc3_bank_data

	lda #$87
	sta mmc3_bank_select
	lda #$01
	sta mmc3_bank_data

	jmp sub_state_machine_1

; -----------------------------------------------------------------------------

sub_rom_EA5B:
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

sub_call_sound_routines:
	; PRG ROM $8000-$9FFF <-- Bank $02 (sound data)
	lda #$86
	sta zp_prg_bank_select_backup
	sta mmc3_bank_select
	lda #$02
	sta mmc3_bank_data
	; PRG ROM $8000-$9FFF <-- Bank $03 (sound and moves code)
	lda #$87
	sta zp_prg_bank_select_backup
	sta mmc3_bank_select
	lda #$03
	sta mmc3_bank_data

	jsr sub_process_all_sound

	; Switch back to PRG ROM Banks $04 and $05
	lda #$86
	sta zp_prg_bank_select_backup
	sta mmc3_bank_select
	lda #$04
	sta mmc3_bank_data
	; PRG ROM $8000-$9FFF <-- Bank $03 (sound and moves code)
	lda #$87
	sta zp_prg_bank_select_backup
	sta mmc3_bank_select
	lda #$05
	sta mmc3_bank_data
	
	rts

; -----------------------------------------------------------------------------
.export sub_call_03_routines

sub_call_03_routines:
	lda #$87
	sta zp_prg_bank_select_backup
	sta mmc3_bank_select
	lda #$03
	sta mmc3_bank_data
	jsr sub_rom_03_A5E4
	jsr sub_rom_03_A000
	lda #$87
	sta mmc3_bank_select
	lda #$01
	sta mmc3_bank_data
	rts

; -----------------------------------------------------------------------------
;
;								DPCM Samples Area
;
; -----------------------------------------------------------------------------
.segment "DMC"

; ----------------
.export dmc_fight

dmc_fight:
.incbin "audio/fight.dmc"

; ----------------
.export dmc_liukang

dmc_liukang:
.incbin "audio/liukang.dmc"

; ----------------
.export dmc_cage

dmc_cage:
.incbin "audio/cage.dmc"

; -----------------------------------------------------------------------------

.segment "VECTORS"
	.word nmi, reset, irq
