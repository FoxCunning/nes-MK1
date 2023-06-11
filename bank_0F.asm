.segment "BANK_0F"
; $E000-FFFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"

; Temporary definitions
; TODO Remove once other banks have been disassembled
rom_8C00 = $8C00	; TEMP
sub_rom_8000 = $8000	; TEMP
sub_rom_B000 = $B000	; TEMP

; -----------------------------------------------------------------------------

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

	@E014:
	lda PpuStatus_2002
	bmi @E014

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
	lda #$10
	tax
	@E039:
	sta PpuAddr_2006
	sta PpuAddr_2006
	eor #$10
	dex
	bne @E039

	sta mmc3_irq_disable
	lda #$00
	sta ram_0100
	lda #$00
	sta ram_042D
	lda #$0C
	sta ram_0410
	jsr sub_rom_E22A
	lda #$00
	jsr sub_rom_E249
	lda #$01
	jsr sub_rom_E249
	lda #$03
	sta ram_042C
	jsr sub_rom_E249
	jsr sub_rom_E264
	lda #$86
	sta a:zp_00FC		; Why?
	sta mmc3_bank_select
	lda #$02
	sta mmc3_bank_data
	lda #$87
	sta a:zp_00FC		; Again
	sta mmc3_bank_select
	lda #$03
	sta mmc3_bank_data
	jsr sub_rom_03_AA98
	lda #$20
	sta ram_0673
	jsr sub_rom_03_AAEC
	inc ram_0700
	lda #$00
	sta zp_28
	lda #$01
	sta a:zp_00F6		; Also why?
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
	sta ram_0423
	cli
	lda #$88
	sta zp_02
	sta PpuControl_2000
	lda #$00
	sta zp_04
	sta PpuMask_2001
	@E0DB:
	inc zp_22
	lda a:zp_00F7		; Why all these?! Precise timing? Why not use NOPs?
	beq @E0DB

	dec a:zp_00F7
	lda #$01
	sta a:zp_00FD
	jsr sub_rom_E7C8
	jsr sub_rom_E902
	jsr sub_rom_E8CB
	lda #$86
	sta a:zp_00FC
	sta mmc3_bank_select
	lda #$02
	sta mmc3_bank_data
	lda #$87
	sta a:zp_00FC
	sta mmc3_bank_select
	lda #$03
	sta mmc3_bank_data
	jsr sub_rom_03_AAFE
	lda #$00
	sta a:zp_00FD
	jmp @E0DB

; -----------------------------------------------------------------------------

irq:
	php
	pha
	txa
	pha
	tya
	pha
	jsr ram_0423
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
	lda a:zp_00FD		; Why...?
	bne @E155
	lda zp_44
	beq @E14C

	jsr sub_rom_E272
	@E14C:
	lda zp_40
	cmp #$01
	bne @E155

	jsr sub_rom_D270
	@E155:
	lda PpuStatus_2002
	lda zp_1E
	sta PpuScroll_2005
	lda zp_20
	sta PpuScroll_2005
	lda zp_02
	sta PpuControl_2000
	lda zp_04
	sta PpuMask_2001
	lda a:zp_00F6		; ...?
	beq @E186
	
	lda ram_0416
	sta ram_0418
	jsr sub_rom_E318
	lda ram_041C
	sta mmc3_irq_latch
	sta mmc3_irq_reload
	sta mmc3_irq_enable
	@E186:
	nop
	lda #$80
	sta mmc3_bank_select
	lda a:zp_0096		; !!!
	sta mmc3_bank_data
	lda #$81
	sta mmc3_bank_select
	lda a:zp_0097		; Also here
	sta mmc3_bank_data
	lda zp_40
	bne @E1CC

	ldx #$82
	lda zp_58
	stx mmc3_bank_select
	sta mmc3_bank_data
	ldx #$83
	lda zp_59
	stx mmc3_bank_select
	sta mmc3_bank_data
	ldx #$84
	lda zp_5A
	stx mmc3_bank_select
	sta mmc3_bank_data
	ldx #$85
	lda zp_5B
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
	inc zp_25
	jsr sub_rom_E2AE
	lda a:zp_00FD		; Why?
	bne @E201

	lda #$01
	sta a:zp_00F7		; Why?
	@E201:
	lda a:zp_00FC		; Why?
	sta mmc3_bank_select
	pla
	tay
	pla
	tax
	pla
	plp
	rti

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_E20E:
	lda #$00
	sta zp_00
	sta zp_01
	ldy #$02
	ldx #$07
	@E218:
	sta (zp_00),Y
	iny
	cpy #$00
	bne @E218

	inc zp_01
	dex
	bpl @E218

	sta zp_00
	sta zp_01
	rts

; -----------------------------------------------------------------------------

sub_rom_E229:
	rts

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

sub_rom_E249:
	asl A
	asl A
	clc
	adc #$20
	ldx #$00
	sta PpuAddr_2006
	stx PpuAddr_2006
	ldy #$03
	lda #$FF
	@E25A:
	sta PpuData_2007
	dex
	bne @E25A
	
	dey
	bpl @E25A

	rts

; -----------------------------------------------------------------------------

sub_rom_E264:
	lda #$F8
	ldx #$00
	@E268:
	sta ram_0300,X
	inx
	inx
	inx
	inx
	bne @E268

	rts

; -----------------------------------------------------------------------------

sub_rom_E272:
	lda zp_47
	ora zp_02
	and #$7F
	sta PpuControl_2000
	ldy #$00
	ldx #$00
	@E27F:
	lda PpuStatus_2002
	lda zp_44
	sta PpuAddr_2006
	lda zp_43
	sta PpuAddr_2006
	@E28C:
	lda ram_0600,X
	sta PpuData_2007
	iny
	inx
	cpy zp_46
	bcc @E28C

	lda zp_43
	clc
	adc #$20
	sta zp_43
	bcc @E2A3

	inc zp_44
	@E2A3:
	ldy #$00
	dec zp_45
	bne @E27F

	lda #$00
	sta zp_44
	rts

; -----------------------------------------------------------------------------

sub_rom_E2AE:
	jsr sub_rom_E2C4
	ldx #$00
	jsr sub_rom_E2B7
	inx
; ----------------
sub_rom_E2B7:
	lda zp_2A,X
	eor zp_2F,X
	and zp_2A,X
	sta zp_2D,X
	lda zp_2A,X
	sta zp_2F,X
	rts

; -----------------------------------------------------------------------------

sub_rom_E2C4:
	lda #$01
	sta Ctrl1_4016
	lda #$00
	sta Ctrl1_4016
	lda #$01
	sta Ctrl1_4016
	nop
	nop
	lda #$00
	sta Ctrl1_4016
	nop
	nop
	lda #$01
	lsr A
	tax
	sta Ctrl1_4016
	jsr sub_rom_E2E7
	inx
; ----------------
sub_rom_E2E7:
	lda #$00
	sta zp_05
	ldy #$08
	@E2ED:
	pha
	lda Ctrl1_4016,X
	sta zp_07
	lsr A
	lsr A
	rol zp_05
	lsr zp_07
	pla
	rol A
	dey
	bne @E2ED

	ora zp_05
	sta zp_2A,X
	rts

; -----------------------------------------------------------------------------

sub_rom_E303:
	asl A
	tay
	pla
	sta zp_14
	pla
	sta zp_15
	iny
	lda (zp_14),Y
	sta zp_12
	iny
	lda (zp_14),Y
	sta zp_13
	jmp (zp_0012)

; -----------------------------------------------------------------------------

sub_rom_E318:
	lda #$4C
	sta ram_0423
	lda ram_0410
	asl A
	tax
	lda rom_E32F,X
	sta ram_0424
	lda rom_E32F+1,X
	sta ram_0425
	rts

; -----------------------------------------------------------------------------

rom_E32F:
	.word sub_rom_E357, sub_rom_E35A, sub_rom_E36C, sub_rom_E377
	.word sub_rom_E382, sub_rom_E38D, sub_rom_E398, sub_rom_E407
	.word sub_rom_E407, sub_rom_E407, sub_rom_E357, sub_rom_E357
	.word sub_rom_E6CC, sub_rom_E6D5, sub_rom_E734, sub_rom_E75B
	.word sub_rom_E789, sub_rom_E789, sub_rom_E789, sub_rom_E789

; -----------------------------------------------------------------------------

sub_rom_E357:
	jmp sub_rom_E408

; -----------------------------------------------------------------------------

sub_rom_E35A:
	lda ram_0435
	bne @E362

	jmp sub_rom_E480
	@E362:
	cmp #$01
	bne @E369

	jmp sub_rom_E4A6
	@E369:
	jmp sub_rom_E4DF

; -----------------------------------------------------------------------------

sub_rom_E36C:
	lda ram_0435
	bne @E374
	
	jmp sub_rom_E4F1
	@E374:
	jmp sub_rom_E50A

; -----------------------------------------------------------------------------

sub_rom_E377:
	lda ram_0435
	bne @E37F

	jmp sub_rom_E568
	@E37F:
	jmp sub_rom_E582

; -----------------------------------------------------------------------------

sub_rom_E382:
	lda ram_0435
	bne @E38A

	jmp sub_rom_E598
	@E38A:
	jmp sub_rom_E5B2

; -----------------------------------------------------------------------------

sub_rom_E38D:
	lda ram_0435
	bne @E395
	jmp sub_rom_E5C8
	@E395:
	jmp sub_rom_E5E2

; -----------------------------------------------------------------------------

sub_rom_E398:
	sta mmc3_irq_disable
	ldx zp_03
	lda a:zp_007A		; Why??
	cmp #$03
	bcc @E3C0

	cmp #$04
	bne @E3AF

	lda ram_0414
	cmp #$C0
	beq @E3C0

	@E3AF:
	lda zp_25
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

sub_rom_E407:
	rts

; -----------------------------------------------------------------------------

sub_rom_E408:
	sta mmc3_irq_disable
	lda PpuStatus_2002
	lda a:zp_0081		; Why?!
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

; Potentially unused
sub_rom_E43F:
	stx zp_85
	sty zp_80
	sta mmc3_irq_disable
	sta mmc3_irq_enable
	lda #$1F
	sta mmc3_irq_latch
	lda PpuStatus_2002
	lda a:zp_0081		; And why?
	sta PpuScroll_2005
	inc ram_0435
	rts

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_E45B:
	sta mmc3_irq_disable
	lda PpuStatus_2002
	lda a:zp_0081		; Again?
	lsr A
	sta PpuScroll_2005
	lda PpuStatus_2002
	lda zp_02
	sta PpuControl_2000
	lda #$00
	sta ram_0435
	lda ram_0421
	beq @E47F

	ora #$F0
	sta ram_0421
	@E47F:
	rts

; -----------------------------------------------------------------------------

sub_rom_E480:
	sta mmc3_irq_disable
	sta mmc3_irq_enable
	lda #$1B
	sta mmc3_irq_latch
	lda PpuStatus_2002
	lda zp_25
	and #$07
	bne @E497

	inc ram_043F
	@E497:
	lda ram_043F
	clc
	adc a:zp_0081		; Why?
	sta PpuScroll_2005
	ldy #$E0
	jmp sub_rom_E41B

; -----------------------------------------------------------------------------

sub_rom_E4A6:
	sta mmc3_irq_disable
	sta mmc3_irq_enable
	lda #$15
	sta mmc3_irq_latch
	lda PpuStatus_2002
	lda zp_25
	and #$03
	bne @E4BD

	inc ram_0440
	@E4BD:
	lda ram_0440
	clc
	adc a:zp_0081		; Why?
	sta PpuScroll_2005
	inc ram_0435
	rts

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_E4CB:
	lda #$00
	ldx #$08
	@E4CF:
	lsr zp_14
	bcc @E4D6

	clc
	adc zp_16
	@E4D6:
	ror A
	ror zp_12
	dex
	bne @E4CF

	sta zp_13
	rts

; -----------------------------------------------------------------------------

sub_rom_E4DF:
	sta mmc3_irq_disable
	lda PpuStatus_2002
	lda a:zp_0081		; Why?
	sta PpuScroll_2005
	lda #$00
	sta ram_0435
	rts

; -----------------------------------------------------------------------------

sub_rom_E4F1:
	sta mmc3_irq_disable
	sta mmc3_irq_enable
	lda #$40
	sta mmc3_irq_latch
	lda PpuStatus_2002
	lda a:zp_0081		; Why?
	sta PpuScroll_2005
	ldy #$E4
	jmp sub_rom_E41B

; -----------------------------------------------------------------------------

sub_rom_E50A:
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
	lda a:zp_007A		; Why?
	cmp #$05
	bcs @E54E

	lda zp_25
	and #$1F
	bne @E541

	inc ram_043F
	@E541:
	lda ram_043F
	and #$01
	tax
	ldy rom_E564,X
	sty mmc3_bank_data
	rts
; ----------------
	@E54E:
	lda zp_25
	and #$07
	bne @E557
	inc ram_043F
	@E557:
	lda ram_043F
	and #$01
	tax
	ldy rom_E566,X
	sty mmc3_bank_data
	rts

; -----------------------------------------------------------------------------

rom_E564:
	.byte $EC, $ED
rom_E566:
	.byte $EE, $EF

; -----------------------------------------------------------------------------

sub_rom_E568:
	sta mmc3_irq_disable
	sta mmc3_irq_enable
	lda #$63
	sta mmc3_irq_latch
	lda PpuStatus_2002
	lda a:zp_0081		; Why?
	sta PpuScroll_2005
	ldy #$1C
	jmp sub_rom_E41B
	rts	; Unreachable

; -----------------------------------------------------------------------------

sub_rom_E582:
	sta mmc3_irq_disable
	lda PpuStatus_2002
	lda a:zp_0081		; Why?
	sta PpuScroll_2005
	lda #$00
	sta ram_0435
	ldy #$20
	jmp sub_rom_E41E

; -----------------------------------------------------------------------------

sub_rom_E598:
	sta mmc3_irq_disable
	sta mmc3_irq_enable
	lda #$40
	sta mmc3_irq_latch
	lda PpuStatus_2002
	lda a:zp_0081		; Why?
	sta PpuScroll_2005
	ldy #$24
	jmp sub_rom_E41B
	rts	; Unreachable

; -----------------------------------------------------------------------------

sub_rom_E5B2:
	sta mmc3_irq_disable
	lda PpuStatus_2002
	lda a:zp_0081		; Why?
	sta PpuScroll_2005
	lda #$00
	sta ram_0435
	ldy #$28
	jmp sub_rom_E41E

; -----------------------------------------------------------------------------

sub_rom_E5C8:
	sta mmc3_irq_disable
	sta mmc3_irq_enable
	lda #$48
	sta mmc3_irq_latch
	lda PpuStatus_2002
	lda a:zp_0081		; Why?
	sta PpuScroll_2005
	ldy #$2C
	jmp sub_rom_E41B
	rts	; Unreachable

; -----------------------------------------------------------------------------

sub_rom_E5E2:
	sta mmc3_irq_disable
	lda PpuStatus_2002
	lda a:zp_0081		; ???
	sta PpuScroll_2005
	lda #$00
	sta ram_0435
	ldy #$30
	jmp sub_rom_E41E

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_E5F8:
	inx
	txa
	and #$0F
	sta ram_041F
	txa
	and #$10
	beq @E60C

	tya
	sec
	sbc ram_041F
	jmp @E611

	@E60C:
	tya
	clc
	adc ram_041F
	@E611:
	tay
	rts

; -----------------------------------------------------------------------------

; Potentially unused and harmful
sub_rom_E613:
	sta mmc3_irq_disable
	sta mmc3_irq_enable
	lda #$80
	sta mmc3_irq_latch
	lda PpuStatus_2002
	lda a:zp_0081		; ???
	lsr A
	sta PpuScroll_2005
	lda zp_25
	and #$0C
	lsr A
	lsr A
	tax
	lda #$82
	sta mmc3_bank_select
	lda sub_rom_E43F,X	; That is not data...
	sta mmc3_bank_data
	lda #$83
	sta mmc3_bank_select
	lda a:zp_0099		; ???
	sta mmc3_bank_data
	lda #$84
	sta mmc3_bank_select
	lda a:zp_009A		; ???
	sta mmc3_bank_data
	lda #$85
	sta mmc3_bank_select
	lda a:zp_009B		; ???
	sta mmc3_bank_data
	lda zp_25
	and #$07
	bne @E66F

	lda ram_0678
	clc
	adc #$20
	sta ram_0678
	bcc @E66F

	inc ram_0679
	@E66F:
	lda PpuStatus_2002
	lda ram_0679
	sta PpuAddr_2006
	lda ram_0678
	sta PpuAddr_2006
	inc ram_0435
	rts

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_E682:
	sta mmc3_irq_disable
	sta mmc3_irq_enable
	lda #$1F
	sta mmc3_irq_latch
	lda PpuStatus_2002
	lda a:zp_0081		; ???
	sta PpuScroll_2005
	lda PpuStatus_2002
	lda #$22
	sta PpuAddr_2006
	lda #$A0
	sta PpuAddr_2006
	inc ram_0435
	rts

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_E6A7:
	sta mmc3_irq_disable
	lda PpuStatus_2002
	lda a:zp_0081		; ???
	lsr A
	sta PpuScroll_2005
	lda PpuStatus_2002
	lda zp_02
	sta PpuControl_2000
	lda #$00
	sta ram_0435
	lda ram_0421
	beq @E6CB

	ora #$F0
	sta ram_0421
	@E6CB:
	rts

; -----------------------------------------------------------------------------

sub_rom_E6CC:
	sta mmc3_irq_disable
	lda #$00
	sta ram_0435
	rts

; -----------------------------------------------------------------------------

sub_rom_E6D5:
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
	lda zp_51
	sta PpuAddr_2006
	lda zp_52
	sta PpuAddr_2006
	lda #$00
	sta PpuScroll_2005
	sta PpuScroll_2005
	lda #$00
	sta ram_0435
	rts

; -----------------------------------------------------------------------------
sub_rom_E734:
	lda ram_0435
	beq @E744
	lda PpuStatus_2002
	lda #$88
	sta PpuControl_2000
	jmp sub_rom_E6CC
	@E744:
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

sub_rom_E75B:
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
	jmp sub_rom_E6CC

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_E789:
	sta mmc3_irq_disable
	lda #$00
	sta ram_0435
	rts

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_E792:
	ldy #$00
	ldx #$00
	@E796:
	lda PpuStatus_2002
	lda ram_067B
	sta PpuAddr_2006
	lda zp_43
	sta PpuAddr_2006
	@E7A4:
	lda ram_0600,X
	sta PpuData_2007
	iny
	inx
	cpy zp_46
	bcc @E7A4

	lda zp_43
	clc
	adc #$08
	sta zp_43
	bcc @E7BC

	inc ram_067B
	@E7BC:
	ldy #$00
	dec zp_45
	bne @E796

	lda #$00
	sta ram_067B
	rts

; -----------------------------------------------------------------------------

sub_rom_E7C8:
	lda a:zp_0040
	jsr sub_rom_E303	; This will pull from the stack and jump, so this is
						; basically a JMP

; -----------------------------------------------------------------------------

rom_E7CE:
	.word sub_rom_E7DC
	.word sub_rom_EA13
	.word sub_rom_E7F5
	.word sub_rom_E866
	.word sub_rom_E889
	.word sub_rom_E893
	.word sub_rom_E89B

; -----------------------------------------------------------------------------

sub_rom_E7DC:
	lda #$04
	ldx #$86
	stx mmc3_bank_select
	sta mmc3_bank_data
	lda #$05
	ldx #$87
	stx mmc3_bank_select
	sta mmc3_bank_data
	jmp sub_rom_B000
	rts	; Unreachable

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_E7F4:
	rts

; -----------------------------------------------------------------------------

sub_rom_E7F5:
	lda #$00
	sta a:zp_004F
	sta a:zp_0040
	ldx ram_040C
	lda a:zp_00F2,X	; WHY?!
	bpl @E80B

	@E805:
	lda #$04
	sta a:zp_004E		; ???
	rts
; ----------------
	@E80B:
	lda a:zp_00F2		; ???
	eor a:zp_00F3		; ???
	and #$80
	beq @E805

	lda #$03
	sta a:zp_004E		; ???
	lda ram_0100
	asl A
	asl A
	clc
	adc a:zp_005F		; ???
	tax
	inc a:zp_0061		; ???
	lda a:zp_0061		; ???
	cmp rom_E849,X
	bcc @E848

	lda #$00
	sta a:zp_0061		; ???
	inc a:zp_005F		; ???
	lda a:zp_005F		; ???
	cmp #$04
	bcc @E848

	lda #$00
	sta a:zp_004F		; ???
	lda #$06
	sta a:zp_004E		; ???
	@E848:
	rts

; -----------------------------------------------------------------------------

rom_E849:
	.byte $07, $03, $01, $01, $0E, $03, $01, $01

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_E851:
	lda #$00
	sta a:zp_0040	; ???
	lda #$36
	lda #$04
	sta rom_8C00+0
	lda #$05
	sta rom_8C00+1
	jsr sub_rom_8000
	rts

; -----------------------------------------------------------------------------

sub_rom_E866:
	lda #$00
	sta a:zp_004F	; ???
	lda #$00
	sta a:zp_004E	; ???
	sta a:zp_0040	; ???
	rts

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_E874:
	lda #$00
	sta a:zp_0040	; ???
	lda #$02
	lda #$04
	sta rom_8C00+0
	lda #$05
	sta rom_8C00+1
	jsr sub_rom_8000
	rts

; -----------------------------------------------------------------------------

sub_rom_E889:
	lda #$06
	sta ram_0410
	ldx #$02
	lda #$01
	rts

; -----------------------------------------------------------------------------

sub_rom_E893:
	lda #$00
	sta a:zp_0040	; ???
	lda #$00
	rts

; -----------------------------------------------------------------------------

sub_rom_E89B:
	lda a:zp_002A	; ???
	and #$40
	beq @E8A7

	lda #$00
	sta ram_040C
	@E8A7:
	lda a:zp_002A	; ???
	and #$80
	beq @E8B3

	lda #$01
	sta ram_040C
	@E8B3:
	lda a:zp_002A	; ???
	and #$10
	beq @E8C4

	lda a:zp_005E	; ???
	bne @E8C5

	lda #$02
	sta a:zp_0040	; ???
	@E8C4:
	rts
; ----------------
	@E8C5:
	lda #$03
	sta a:zp_0040	; ???
	rts

; -----------------------------------------------------------------------------

sub_rom_E8CB:
	lda #$86
	sta a:zp_00FC	; ???
	sta mmc3_bank_select
	lda #$02
	sta mmc3_bank_data
	lda #$87
	sta a:zp_00FC	; ???
	sta mmc3_bank_select
	lda #$03
	sta mmc3_bank_data
	lda ram_0673
	cmp ram_0674
	bne @E8F3

	lda ram_0672
	bne @E8F9

	rts
; ----------------
	@E8F3:
	lda ram_0673
	sta ram_0674
	@E8F9:
	jsr sub_rom_03_AAEC
	lda #$00
	sta ram_0672
	rts

; -----------------------------------------------------------------------------

sub_rom_E902:
	ldx #$20
	lda a:zp_009C	; ???
	cmp #$18
	bcs @E910

	lda a:zp_009D	; ???
	beq @E917

	@E910:
	lda ram_0675
	and #$20
	bne @E91D

	@E917:
	lda a:zp_008C	; ???
	jmp @E920

	@E91D:
	lda a:zp_0025	; ???
	@E920:
	and #$02
	bne @E995

	lda a:zp_0025	; ???
	and #$01
	bne @E960

	@E92B:
	dex
	lda ram_0300,X
	sta ram_0200,X
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
	lda ram_0300,X
	sta ram_0280,X
	lda ram_0320,X
	sta ram_02A0,X
	lda ram_0340,X
	sta ram_02C0,X
	lda ram_0360,X
	sta ram_02E0,X
	lda ram_0380,X
	sta ram_0200,X
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
	lda a:zp_0025	; ???
	and #$01
	bne @E9D1

	@E99C:
	dex
	lda ram_0300,X
	sta ram_0240,X
	lda ram_0320,X
	sta ram_0260,X
	lda ram_0340,X
	sta ram_0200,X
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
	lda ram_0300,X
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
	sta ram_0200,X
	lda ram_03E0,X
	sta ram_0220,X
	txa
	bne @E9D1

	rts

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_EA06:
	lda a:zp_002A	; ???
	and #$30
	eor #$30
	bne @EA12

	jmp sub_rom_8000

	@EA12:
	rts

; -----------------------------------------------------------------------------

sub_rom_EA13:
	lda #$2F
	sta ram_041C
	lda a:zp_005E	; ???
	beq @EA2A

	lda a:zp_002D	; ???
	and #$10
	beq @EA53

	lda #$09
	sta a:zp_007A	; ???
	rts
; ----------------
	@EA2A:
	lda a:zp_002D	; ???
	and #$10
	beq @EA4D

	lda a:zp_007A	; ???
	cmp #$03
	bne @EA53

	lda ram_0438
	bne @EA53

	jsr sub_rom_EA5B
	lda #$0E
	sta ram_0672
	lda a:zp_0024	; ???
	eor #$01
	sta a:zp_0024	; ???
	@EA4D:
	lda a:zp_0024	; ???
	beq @EA53

	rts
; ----------------
	@EA53:
	jsr sub_rom_EA57
	rts

; -----------------------------------------------------------------------------

sub_rom_EA57:
	jsr sub_rom_C000
	rts

; -----------------------------------------------------------------------------

sub_rom_EA5B:
	ldx #$00
	lda #$F8
	@EA5F:
	sta ram_0300,X
	inx
	inx
	inx
	inx
	bne @EA5F
	
	lda #$0E
	sta ram_0300
	sta ram_0304
	sta ram_0308
	sta ram_030C
	sta ram_0310
	lda #$6C
	sta ram_0303
	lda #$74
	sta ram_0307
	lda #$7C
	sta ram_030B
	lda #$84
	sta ram_030F
	lda #$8C
	sta ram_0313
	lda #$03
	sta ram_0302
	sta ram_0306
	sta ram_030A
	sta ram_030E
	sta ram_0312
	lda #$D0
	sta ram_0301
	lda #$C1
	sta ram_0305
	lda #$D5
	sta ram_0309
	lda #$D3
	sta ram_030D
	lda #$C5
	sta ram_0311
	lda #$DA
	sta a:zp_0097
	rts

; -----------------------------------------------------------------------------


; -----------------------------------------------------------------------------

	.segment "VECTORS"
	.word nmi, reset, irq
