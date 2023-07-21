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

	; Wait for two vblanks
	ldx #$02
	@reset_wait:
	bit PpuStatus_2002
	bpl @reset_wait
	:
		lda PpuStatus_2002
	bmi :-
	dex
	bne @reset_wait

	; Init some registers
	lda #$0F
	sta ApuStatus_4015
	lda #$00
	sta DmcFreq_4010
	lda #$40
	sta Ctrl2_FrameCtr_4017
	sta mmc3_irq_disable
	lda #$80	; Write protection disabled
	sta mmc3_ram_protect

	; ---- Transfer some code to RAM ----
	lda #$87
	sta mmc3_bank_select
	lda #$06
	sta mmc3_bank_data

	; Source: $B000-$BFFF (bank 6)
	; Destination: $7000-$7FFF (WRAM)
	lda #$00
	sta zp_00
	sta zp_ptr1_lo

	lda #$B0
	sta zp_01

	lda #$70
	sta zp_ptr1_hi

	ldy #$00
	:
		lda (zp_00),Y
		sta (zp_ptr1_lo),Y
	iny
	bne :-

	inc zp_01
	inc zp_ptr1_hi
	lda zp_ptr1_hi	; Stop when the high byte is $80
	bpl :-			; $80 = negative

	lda #$C0	; Write protection enabled
	sta mmc3_ram_protect
	; -----------------------------------

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

	jsr sub_clear_ram

	lda #$00
	jsr sub_clear_nametable
	lda #$01
	jsr sub_clear_nametable
	lda #$03
	sta ram_difficulty_setting
	jsr sub_clear_nametable

	jsr sub_hide_all_sprites

	lda #$80
	sta zp_bank_select_mask
	; PRG ROM $8000-$9FFF <-- Bank $02
	ldx #$86
	stx mmc3_bank_select
	lda #$02
	sta mmc3_bank_data
	; PRG ROM $A000-$BFFF <-- Bank $03
	inx
	stx mmc3_bank_select
	lda #$03
	sta mmc3_bank_data

	jsr sub_apu_init

	; This will not actually play anything, because the apu initialised flag is clear
	lda #$22
	sta ram_req_song
	sta ram_cur_song	; This should have the same effect
	;jsr sub_play_new_song_or_sfx
	inc ram_snd_initialised	; SFX and music can be played only after this

	lda #$00
	sta zp_28
	lda #$01
	sta zp_mmc3_irq_ready
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
	sta ram_irq_state_var
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
		lda zp_F7	; This basically waits for the next NMI
	beq @main_loop

		dec zp_F7
		lda #$01
		sta zp_FD

		jsr sub_state_machine_start
		jsr sub_oam_update

		jsr sub_sound_playlist

		lda #$80
		sta zp_bank_select_mask
		; PRG ROM $8000-$9FFF <-- Bank $02 (sound data)
		ldx #$86
		stx mmc3_bank_select
		lda #$02
		sta mmc3_bank_data
		; PRG ROM $8000-$9FFF <-- Bank $03 (sound and graphics code)
		inx
		stx mmc3_bank_select
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
		beq :+
			jsr sub_do_ppu_transfer
		:
		lda zp_machine_state_0
		cmp #$01
		bne @E155

			jsr sub_update_health_bars

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
	ora zp_bank_select_mask
	tax
	stx mmc3_bank_select
	lda zp_chr_bank_0
	sta mmc3_bank_data
	inx
	stx mmc3_bank_select
	lda zp_chr_bank_1
	sta mmc3_bank_data
	lda zp_machine_state_0
	bne @E1CC

		inx
		lda zp_chr_bank_2
		stx mmc3_bank_select
		sta mmc3_bank_data
		inx
		lda zp_chr_bank_3
		stx mmc3_bank_select
		sta mmc3_bank_data
		inx
		lda zp_chr_bank_4
		stx mmc3_bank_select
		sta mmc3_bank_data
		inx
		lda zp_chr_bank_5
		stx mmc3_bank_select
		sta mmc3_bank_data
		jmp @E1F2

	@E1CC:
	inx
	stx mmc3_bank_select
	ldy zp_34
	sty mmc3_bank_data
	inx
	stx mmc3_bank_select
	iny
	sty mmc3_bank_data
	inx
	stx mmc3_bank_select
	ldy zp_35
	sty mmc3_bank_data
	inx
	stx mmc3_bank_select
	iny
	sty mmc3_bank_data

	@E1F2:
	inc zp_frame_counter

	jsr sub_get_controller_input

	lda zp_FD
	bne :+
		lda #$01
		sta zp_F7
	:
	;lda zp_bank_select_mask
	;sta mmc3_bank_select

	pla
	tay
	pla
	tax
	pla
	plp
	rti

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

; ----------------
.export dmc_swing

dmc_swing:
.incbin "audio/swing_08.dmc"

; ----------------
.export dmc_wins

dmc_wins:
.incbin "audio/wins.dmc"

; ----------------
.export dmc_comehere

dmc_comehere:
.incbin "audio/comehere_sp6up.dmc"

; -----------------------------------------------------------------------------

.segment "VECTORS"
	.word nmi, reset, irq
