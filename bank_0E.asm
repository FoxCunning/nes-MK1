.segment "BANK_0E"
; $C000-$DFFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"
; .include "charmap.inc"

; Temporary definitions
; TODO Remove once other banks have been disassembled
rom_8002 = $8002	; TEMP
rom_A000 = $A000	; TEMP
rom_B000 = $B000	; TEMP
sub_rom_8000 = $8000	; TEMP
sub_rom_A000 = $A000	; TEMP
sub_rom_A5E4 = $A5E4	; TEMP


; -----------------------------------------------------------------------------
.export sub_rom_C000

sub_rom_C000:
	lda zp_7A
	jsr sub_rom_D68B

; -----------------------------------------------------------------------------

rom_C005:
	.word sub_rom_C019, sub_rom_C107, sub_rom_C117, sub_rom_C122
	.word sub_rom_C17B, sub_rom_C186, sub_rom_C1F9, sub_rom_C21E
	.word sub_rom_C21E, sub_rom_C284


; -----------------------------------------------------------------------------

sub_rom_C019:
	lda zp_F3
	and #$7F
	tax
	lda rom_C0A8,X
	sta ram_0410
	lda #$00
	sta PpuControl_2000
	sta zp_02
	sta PpuMask_2001
	sta zp_04
	lda #$01
	sta ram_040F
	lda zp_F2
	and #$7F
	sta zp_12
	lda zp_F3
	and #$7F
	cmp zp_12
	bne @C05A

	cmp #$0C
	bcc @C04D

	sec
	sbc #$0C
	jmp @C050

	@C04D:
	clc
	adc #$0C
	@C050:
	sta zp_12
	lda zp_F3
	and #$80
	ora zp_12
	sta zp_F3
	@C05A:
	lda zp_F2
	and #$7F
	sta zp_A3
	lda zp_F3
	and #$7F
	sta zp_A4
	ldx ram_0410
	lda rom_C0C0,X
	sta zp_4A
	txa
	clc
	adc #$25
	sta ram_0673
	lda #$00
	sta ram_0435
	sta ram_042D
	sta zp_1E
	sta ram_0438
	sta zp_20
	jsr sub_rom_D6A0
	jsr sub_rom_C0C6
	jsr sub_rom_CDD5
	jsr sub_rom_CF4E
	lda #$18
	sta zp_04
	lda #$88
	sta PpuControl_2000
	sta zp_02
	lda #$00
	sta rom_A000
	inc zp_7A
	nop
	lda zp_60
	sta zp_4B
	rts

; -----------------------------------------------------------------------------

rom_C0A8:
	.byte $00, $01, $05, $03, $04, $02, $02, $01
	.byte $04, $01, $02, $03, $00, $01, $05, $03
	.byte $04, $02, $02, $01, $04, $01, $02, $03

; -----------------------------------------------------------------------------

rom_C0C0:
	.byte $DA, $D0, $DA, $DA, $DA, $DA

; -----------------------------------------------------------------------------

sub_rom_C0C6:
	lda #$00
	sta ram_043F
	sta ram_0440
	lda #$86
	sta zp_FC
	sta rom_8000
	lda #$00
	sta rom_8001
	lda #$87
	sta zp_FC
	sta rom_8000
	lda #$01
	sta rom_8001
	jsr sub_rom_8000
	rts

; -----------------------------------------------------------------------------

sub_rom_C0EA:
	lda zp_A3
	@C0EC:
	cmp #$0C
	bcc @C0F8

	sec
	sbc #$0C
	sta zp_A3
	jmp @C0EC

	@C0F8:
	lda zp_A4
	@C0FA:
	cmp #$0C
	bcc @C106

	sec
	sbc #$0C
	sta zp_A4
	jmp @C0FA

	@C106:
	rts

; -----------------------------------------------------------------------------

sub_rom_C107:
	lda ram_0401
	bne @C10F

	jsr sub_rom_C69C
	@C10F:
	jsr sub_rom_D422
	bcc @C116

	inc zp_7A
	@C116:
	rts

; -----------------------------------------------------------------------------

sub_rom_C117:
	lda #$63
	sta zp_9F
	lda #$00
	sta zp_A2
	inc zp_7A
	rts

; -----------------------------------------------------------------------------

sub_rom_C122:
	lda zp_F2
	and #$80
	beq @C12E

	lda #$00
	sta zp_2A
	sta zp_2D
	@C12E:
	lda zp_F3
	and #$80
	beq @C13A

	lda #$00
	sta zp_2B
	sta zp_2E
	@C13A:
	jsr sub_rom_CF1F
	jsr sub_rom_C7B0
	jsr sub_rom_CA5C
	lda #$87
	sta zp_FC
	sta rom_8000
	lda #$03
	sta rom_8001
	jsr sub_rom_A5E4
	jsr sub_rom_A000
	lda zp_94
	cmp zp_92
	bcs @C15E

	jsr sub_rom_CCA8
	@C15E:
	inc zp_23
	jsr sub_rom_CC9A
	bcc @C177

	jsr sub_rom_CCAC
	jsr sub_rom_D09F
	jsr sub_rom_CA9D
	jsr sub_rom_D76D
	jsr sub_rom_D02F
	jsr sub_rom_C9EC
	@C177:
	jsr sub_rom_C29E
	rts

; -----------------------------------------------------------------------------

sub_rom_C17B:
	jsr sub_rom_C79C
	lda zp_5E
	bne @C185

	jsr sub_rom_C695
	@C185:
	rts

; -----------------------------------------------------------------------------

sub_rom_C186:
	lda zp_9F
	beq @C197
	lda zp_4B
	bpl @C192

	jsr sub_rom_D3DE
	rts
; ----------------
	@C192:
	dec zp_9F
	jsr sub_rom_CD34
	@C197:
	lda zp_A1
	bne @C19F

	lda zp_A0
	beq @C1F6

	@C19F:
	lda zp_25
	and #$03
	bne @C1AF

	lda #$22
	sta ram_0673
	lda #$03
	sta ram_0672
	@C1AF:
	ldy #$00
	ldx #$00
	lda zp_A5
	cmp zp_A6
	bcc @C1C3

	beq @C1F6

	lda ram_040F

	beq @C1F6

	iny
	ldx #$03
	@C1C3:
	sty zp_7C
	stx zp_7B
	jsr sub_rom_C675
	ldx zp_7B
	lda #$01
	sta zp_05
	lda #$00
	sta zp_06
	jsr sub_rom_C6CC
	lda zp_7C
	eor #$01
	sta zp_7C
	lda zp_7B
	eor #$03
	tax
	stx zp_7B
	jsr sub_rom_C6E2
	jsr sub_rom_C6BA
	lda zp_A0
	sec
	sbc #$01
	sta zp_A0
	bcs @C1F5

	dec zp_A1
	@C1F5:
	rts
; ----------------
	@C1F6:
	inc zp_7A
	rts

; -----------------------------------------------------------------------------

sub_rom_C1F9:
	inc zp_9E
	ldy #$00
	sty zp_F1
	jsr sub_rom_C207
	iny
	jsr sub_rom_C207
	rts

; -----------------------------------------------------------------------------

sub_rom_C207:
	ldx #$07
	lda ram_040D,Y
	cmp #$02
	bcs @C215

	lda zp_5E
	bne @C215

	inx
	@C215:
	stx zp_7A
	cpx #$08
	beq @C21D

	pla
	pla
	@C21D:
	rts

; -----------------------------------------------------------------------------

sub_rom_C21E:
	lda zp_F1
	cmp #$40
	bcs @C227

	inc zp_F1
	rts
; ----------------
	@C227:
	jsr sub_rom_D440
	bcc @C271

	lda zp_9E
	cmp #$09
	bcs @C238

	lda zp_7A
	cmp #$08
	beq @C268

	@C238:
	ldx #$01
	lda ram_040E
	cmp ram_040D
	bcs @C243

	dex
	@C243:
	stx ram_040C
	ldx #$02
	lda zp_5E
	beq @C24D

	inx
	@C24D:
	stx zp_40
	lda #$0B
	sta ram_0410
	lda #$00
	sta zp_20
	jsr sub_rom_C272
	lda #$00
	sta ram_067C
	sta ram_040D
	sta ram_040E
	sta zp_9E
	@C268:
	lda #$00
	sta ram_067D
	sta zp_7A
	sta zp_F1
	@C271:
	rts

; -----------------------------------------------------------------------------

sub_rom_C272:
	ldx #$00
	beq @C278

	ldx #$80
	@C278:
	lda #$F8
	@C27A:
	sta ram_0300,X
	inx
	inx
	inx
	inx
	bne @C27A
	rts

; -----------------------------------------------------------------------------

sub_rom_C284:
	jsr sub_rom_D440
	bcc @C29D

	lda #$00
	sta PpuMask_2001
	sta zp_40
	sta ram_067D
	sta ram_067C
	sta zp_7A
	lda #$1F
	sta ram_0672
	@C29D:
	rts

; -----------------------------------------------------------------------------

sub_rom_C29E:
	ldy #$00
	sty zp_7C
	jsr sub_rom_C2A8
	iny
	sty zp_7C

; -----------------------------------------------------------------------------

sub_rom_C2A8:
	lda zp_004C,Y
	bpl @C2C4

	cmp #$F0
	bcs @C2BF

	lda #$03
	and zp_25
	bne @C2C4

	ldx zp_004C,Y
	inx
	stx zp_004C,Y
	jmp @C2C4

	@C2BF:
	lda #$00
	sta zp_004C,Y
	@C2C4:
	lda #$1E
	cmp zp_008E,Y

	beq @C2CC
	@C2CB:
	rts
; ----------------
	@C2CC:
	lda zp_0090,Y
	cmp #$05
	bcc @C2CB
	bne @C2F0

	ldx zp_A3,Y
	lda zp_008A,Y
	bne @C2E6

	lda zp_0086,Y
	clc
	adc rom_C35F,X
	jmp @C2ED

	@C2E6:
	lda zp_0086,Y
	sec
	sbc rom_C35F,X
	@C2ED:
	sta ram_0436,Y
	@C2F0:
	lda ram_0436,Y
	cmp #$E8
	bcs @C2FB

	cmp #$08
	bcs @C304

	@C2FB:
	lda #$00
	sta zp_008E,Y
	sta zp_0090,Y
	rts
; ----------------
	@C304:
	tya
	eor #$01
	tax
	lda zp_008E,X
	bne @C310

	lda zp_0090,X
	beq @C317

	@C310:
	cmp #$27
	beq @C317

	jsr sub_rom_C5B1
	@C317:
	lda ram_0436,Y
	sta zp_05
	lda zp_008E,Y
	cmp #$0D
	bne @C327

	lda #$B4
	bne @C32C

	@C327:
	ldx zp_00A3,Y
	lda rom_C3BD,X
	@C32C:
	sta zp_06
	lda rom_CB0A,Y
	sta zp_12
	clc
	adc #$0C
	tax
	lda zp_00A3,Y
	asl A
	asl A
	tay
	@C33D:
	jsr sub_rom_C36B
	ldy zp_14
	tya
	iny
	and #$03
	cmp #$03
	bne @C33D

	jsr sub_rom_C3F9
	lda #$FD
	ldy zp_7C
	ldx zp_8A,Y
	bne @C357

	lda #$03
	@C357:
	clc
	adc ram_0436,Y
	sta ram_0436,Y
	rts

; -----------------------------------------------------------------------------

rom_C35F:
	.byte $20, $18, $18, $20, $00, $20, $20, $28
	.byte $28, $20, $00, $18

; -----------------------------------------------------------------------------

sub_rom_C36B:
	sty zp_14
	lda rom_C3C9,Y
	bmi @C397

	ora zp_12
	sta ram_0371,X
	lda zp_05
	sta ram_0373,X
	lda zp_06
	sta ram_0370,X
	ldy zp_7C
	lda zp_008A,Y
	tay
	lda zp_7C
	asl A
	cpy #$00
	beq @C390

	ora #$40
	@C390:
	sta ram_0372,X
	dex
	dex
	dex
	dex
	@C397:
	ldy zp_7C
	lda zp_14
	and #$01
	bne @C3B0

	lda zp_008A,Y
	bne @C3A8

	lda #$08
	bne @C3AA

	@C3A8:
	lda #$F8
	@C3AA:
	clc
	adc zp_05
	sta zp_05
	rts
; ----------------
	@C3B0:
	lda ram_0436,Y
	sta zp_05
	lda zp_06
	clc
	adc #$08
	sta zp_06
	rts

; -----------------------------------------------------------------------------

rom_C3BD:
	.byte $9C, $98, $9C, $9C, $9C, $9C, $9C, $9C
	.byte $A1, $9C, $9C, $A6

; -----------------------------------------------------------------------------

rom_C3C9:
	.byte $7A, $7B, $72, $73
	.byte $77, $78, $79, $7A, $6F, $70, $71, $72
	.byte $1F, $20, $FF, $FF, $74, $75, $7A, $FF
	.byte $77, $78, $FF, $FF, $67, $68, $FF, $FF
	.byte $75, $76, $FF, $FF, $3E, $3F, $FF, $FF
	.byte $7D, $FF, $7E, $FF, $74, $76, $FF, $78
	.byte $03, $04, $05, $06

; -----------------------------------------------------------------------------

sub_rom_C3F9:
	ldy zp_7C
	lda zp_00A3,Y
	jsr sub_rom_D68B

; -----------------------------------------------------------------------------

rom_C401:
	.word sub_rom_C419, sub_rom_C419, sub_rom_C419, sub_rom_C419
	.word sub_rom_C4B2, sub_rom_C419, sub_rom_C419, sub_rom_C419
	.word sub_rom_C419, sub_rom_C419, sub_rom_C419, sub_rom_C419

; -----------------------------------------------------------------------------

sub_rom_C419:
	rts

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_C41A:
	ldy zp_7C
	lda zp_0090,Y
	and #$07
	tax
	and #$04
	bne @C42A
	lda #$00
	beq @C42C
	@C42A:
	lda #$80
	@C42C:
	pha
	stx zp_16
	lda rom_C46E,X
	sta zp_14
	ldx rom_CB0A,Y
	lda ram_037C,X
	clc
	adc zp_14
	sta ram_037C,X
	ldx zp_16
	lda rom_C476,X
	sta zp_14
	ldx rom_CB0A,Y
	lda ram_0378,X
	clc
	adc zp_14
	sta ram_0378,X
	ldx zp_16
	lda rom_C47E,X
	sta zp_14
	ldx rom_CB0A,Y
	lda ram_0374,X
	clc
	adc zp_14
	sta ram_0374,X
	pla
	ora ram_037E,X
	sta ram_037E,X
	rts

; -----------------------------------------------------------------------------

rom_C46E:
	.byte $F8, $FC, $04, $08, $08, $04, $FC, $F8

; -----------------------------------------------------------------------------

rom_C476:
	.byte $08, $04, $FC, $F8, $F8, $FC, $04, $08

; -----------------------------------------------------------------------------

rom_C47E:
	.byte $F0, $F8, $08, $10, $10, $08, $F8, $F0

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_C486:
	rts

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_C487:
	ldy zp_7C
	lda zp_0090,Y
	and #$07
	tax
	lda rom_C4AA,X
	sta zp_14
	ldx rom_CB0A,Y
	lda ram_037C,X
	clc
	adc zp_14
	sta ram_037C,X
	lda ram_0378,X
	clc
	adc zp_14
	sta ram_0378,X
	rts

; -----------------------------------------------------------------------------

rom_C4AA:
	.byte $F0, $F8, $08, $10, $10, $08, $F8, $F0

; -----------------------------------------------------------------------------

sub_rom_C4B2:
	ldy zp_7C
	lda zp_25
	and #$04
	bne @C4BB
	rts
; ----------------
	@C4BB:
	ldx rom_CB0A,Y
	lda ram_037C,X
	clc
	adc #$08
	sta ram_037C,X
	lda ram_0378,X
	clc
	adc #$08
	sta ram_0378,X
	lda ram_0374,X
	sec
	sbc #$08
	sta ram_0374,X
	lda ram_0370,X
	sec
	sbc #$08
	sta ram_0370,X
	lda zp_008A,Y
	bne @C4EF

	lda #$10
	sta zp_16
	lda #$08
	bne @C4F5
	@C4EF:
	lda #$F0
	sta zp_16
	lda #$F8
	@C4F5:
	sta zp_14
	lda ram_037F,X
	clc
	adc zp_14
	clc
	adc zp_16
	sta ram_037F,X
	lda ram_037B,X
	sec
	sbc zp_14
	clc
	adc zp_16
	sta ram_037B,X
	lda ram_0377,X
	clc
	adc zp_14
	clc
	adc zp_16
	sta ram_0377,X
	lda ram_0373,X
	sec
	sbc zp_14
	clc
	adc zp_16
	sta ram_0373,X
	lda ram_0372,X
	eor #$C0
	sta ram_0372,X
	lda ram_0376,X
	eor #$C0
	sta ram_0376,X
	lda ram_037A,X
	eor #$C0
	sta ram_037A,X
	lda ram_037E,X
	eor #$C0
	sta ram_037E,X
	rts

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_C548:
	rts

; -----------------------------------------------------------------------------

sub_rom_C549:
	lda ram_0436,Y
	cmp zp_86,X
	bcs @C558
	lda zp_86,X
	sec
	sbc ram_0436,Y
	bne @C55B
	@C558:
	sec
	sbc zp_86,X
	@C55B:
	rts

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_C55C:
	lda ram_0436,X
	cmp zp_0086,Y
	bcs @C56D

	lda zp_0086,Y
	sec
	sbc ram_0436,X
	bne @C571

	@C56D:
	sec
	sbc zp_0086,Y
	@C571:
	rts

; -----------------------------------------------------------------------------

sub_rom_C572:
	lda zp_8E,X
	cmp #$1E
	bne @C581

	lda zp_008E,Y
	cmp #$1E
	beq @C58C

	bne @C5A2

	@C581:
	cmp #$0D
	bne @C5A2

	lda zp_008E,Y
	cmp #$0D
	bne @C5A2

	@C58C:
	lda zp_90,X
	cmp #$05
	bcc @C5A2

	lda ram_0436,X
	cmp ram_0436,Y
	bcc @C5A4

	sec
	sbc ram_0436,Y
	@C59E:
	cmp #$08
	bcc @C5AD

	@C5A2:
	clc
	rts
; ----------------
	@C5A4:
	lda ram_0436,Y
	sec
	sbc ram_0436,X
	bne @C59E
	@C5AD:
	lda #$00
	sec
	rts

; -----------------------------------------------------------------------------

sub_rom_C5B1:
	tya
	eor #$01
	tax
	jsr sub_rom_C572
	bcs @C601

	lda zp_4A
	sec
	sbc #$21
	cmp zp_88,X
	bcs @C60F

	jsr sub_rom_C549
	cmp #$10
	bcs @C60F

	lda zp_8E,X
	cmp #$01
	beq @C60F

	cmp #$2B
	beq @C60D

	cmp #$2C
	beq @C60D

	cmp #$02
	beq @C5FF

	cmp #$05
	beq @C5FB

	lda #$01
	sta zp_F1
	lda #$08
	sta zp_A7,X
	lda #$03
	sta zp_00EF,Y
	lda zp_88,X
	cmp zp_4A
	bne @C5F7

	lda #$30
	bne @C601

	@C5F7:
	lda #$2E
	bne @C601

	@C5FB:
	lda #$2C
	bne @C601

	@C5FF:
	lda #$2B
	@C601:
	sta zp_8E,X
	lda #$00
	sta zp_90,X
	sta zp_008E,Y
	sta zp_0090,Y
	@C60D:
	pla
	pla
	@C60F:
	rts

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_C610:
	ldy #$00
	sty zp_7C
	jsr @C61B

	ldy #$01
	sty zp_7C
	@C61B:
	tya
	eor #$01
	tay
	lda zp_008E,Y
	cmp #$09
	bne @C666

	ldy zp_7C
	ldx rom_C667,Y
	lda zp_008A,Y
	bne @C63A

	lda zp_0086,Y
	clc
	adc zp_00EB,Y
	jmp @C641

	@C63A:
	lda zp_0086,Y
	sec
	sbc zp_00EB,Y
	@C641:
	sta ram_0303,X
	lda zp_0088,Y
	sec
	sbc zp_00ED,Y
	sta ram_0300,X
	tya
	eor #$01
	tay
	asl A
	sta ram_0302,X
	lda zp_00A3,Y
	tay
	lda rom_C669,Y
	ldy zp_7C
	bne @C663

	ora #$80
	@C663:
	sta ram_0301,X
	@C666:
	rts

; -----------------------------------------------------------------------------

rom_C667:
	.byte $80, $00

; -----------------------------------------------------------------------------

rom_C669:
	.byte $00, $1B, $0B, $03, $00, $00
	.byte $0F, $03, $7E, $7E, $7E, $0B

; -----------------------------------------------------------------------------

sub_rom_C675:
	lda #$20
	sta zp_44
	lda #$44
	sta zp_43
	lda #$01
	sta zp_45
	ldx #$0F
	ldx #$18
	stx zp_46
	ldy #$00
	@C689:
	lda rom_C76C,Y
	sta ram_0600,Y
	iny
	cpy #$1A
	bcc @C689

	rts

; -----------------------------------------------------------------------------

sub_rom_C695:
	lda zp_F1
	cmp #$02
	beq sub_rom_C69C
	rts
; ----------------
sub_rom_C69C:
	jsr sub_rom_C675
	ldy #$00
	sty zp_7C
	ldx #$00
	stx zp_7B
	jsr sub_rom_C6BB
	lda ram_040F
	beq sub_rom_C6BA
	inc zp_7C
	ldy zp_7C
	ldx #$03
	stx zp_7B
	jsr sub_rom_C6BB
sub_rom_C6BA:
	rts

; -----------------------------------------------------------------------------

sub_rom_C6BB:
	lda zp_00EF,Y
	asl A
	tax
	lda rom_C760+0,X
	sta zp_05
	lda rom_C760+1,X
	sta zp_06
	ldx zp_7B
; ----------------
sub_rom_C6CC:
	clc
	lda ram_0403,X
	adc zp_05
	sta ram_0403,X
	lda ram_0404,X
	adc zp_06
	sta ram_0404,X
	bcc sub_rom_C6E2
	inc ram_0405,X
; ----------------
sub_rom_C6E2:
	lda ram_0403,X
	sta zp_07
	lda ram_0404,X
	sta zp_08
	lda ram_0405,X
	sta zp_09
	lda #$B0
	sta zp_0D
	jsr sub_rom_CD56
	ldy zp_7C
	ldx rom_C76A,Y
	ldy #$04
	@C6FF:
	lda ram_066D,Y
	sta ram_0600,X
	inx
	dey
	bpl @C6FF

	ldy zp_7C
	ldx rom_C76A,Y
	jsr sub_rom_C789
	ldx zp_7B
	txa
	eor #$03
	tay
	lda ram_0405,Y
	cmp ram_0405,X
	bcc @C733
	bne @C75F

	lda ram_0404,Y
	cmp ram_0404,X
	bcc @C733
	bne @C75F

	lda ram_0403,Y
	cmp ram_0403,X
	bcs @C75F

	@C733:
	lda ram_0405,X
	cmp ram_040B
	bcc @C75F

	lda ram_0404,X
	cmp ram_040A
	bcc @C75F

	bne @C74D

	lda ram_0409
	cmp ram_0403,X
	bcs @C75F

	@C74D:
	lda ram_0403,X
	sta ram_0409
	lda ram_0404,X
	sta ram_040A
	lda ram_0405,X
	sta ram_040B
	@C75F:
	rts

; -----------------------------------------------------------------------------

rom_C760:
	.byte $00, $00, $23, $00, $2D, $00, $37, $00
	.byte $96, $00

; -----------------------------------------------------------------------------

rom_C76A:
	.byte $00, $12

; -----------------------------------------------------------------------------

rom_C76C:
	.byte $FF, $FF, $FF, $FF, $FF, $B0, $FF, $FF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $B0
	.byte $FF, $FF, $FF, $FF, $FF

; -----------------------------------------------------------------------------

sub_rom_C789:
	ldy #$05
	@C78B:
	lda ram_0600,X
	cmp #$B0
	bne @C79B

	lda #$FF
	sta ram_0600,X
	inx
	dey
	bne @C78B

	@C79B:
	rts

; -----------------------------------------------------------------------------

sub_rom_C79C:
	lda zp_F1
	cmp #$0F
	bcc @C7AD

	lda #$00
	sta zp_EF
	sta zp_F0
	sta zp_F1
	dec zp_7A
	rts
; ----------------
	@C7AD:
	inc zp_F1
	rts

; -----------------------------------------------------------------------------

sub_rom_C7B0:
	lda #$58
	cmp zp_A5
	beq @C7BA

	cmp zp_A6
	bne @C7BB

	@C7BA:
	rts
; ----------------
	@C7BB:
	ldx #$00
	stx zp_7C
	jsr sub_rom_C7C6
	inc zp_7C
	ldx zp_7C
; ----------------
sub_rom_C7C6:
	lda zp_8E,X
	cmp #$28
	beq @C800

	lda zp_A3,X
	asl A
	clc
	adc zp_A3,X
	tay
	sty ram_0422
	lda rom_C801,Y
	bmi @C7E1

	sta ram_043D
	jsr sub_rom_C825
	@C7E1:
	ldy ram_0422
	iny
	lda rom_C801,Y
	bmi @C7F0

	sta ram_043D
	jsr sub_rom_C82C
	@C7F0:
	ldy ram_0422
	iny
	iny
	lda rom_C801,Y
	bmi @C800

	sta ram_043D
	jsr sub_rom_C833
	@C800:
	rts

; -----------------------------------------------------------------------------

rom_C801:
	.byte $00, $01, $02, $03, $04, $05, $06, $07
	.byte $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
	.byte $10, $11, $12, $13, $14, $FF, $16, $FF
	.byte $FF, $19, $FF, $1B, $1C, $1D, $1E, $1F
	.byte $FF, $06, $07, $08

; -----------------------------------------------------------------------------

sub_rom_C825:
	lda #$0D
	sta ram_043E
	bne sub_rom_C838
; ----------------
sub_rom_C82C:
	lda #$1E
	sta ram_043E
	bne sub_rom_C838
; ----------------
sub_rom_C833:
	lda #$17
	sta ram_043E
; ----------------
sub_rom_C838:
	ldx zp_7C
	lda zp_88,X
	cmp zp_4A
	bne @C875

	lda ram_043D
	bne @C84B

	lda zp_2A,X
	and #$04
	bne @C875

	@C84B:
	jsr sub_rom_C876
	ldy zp_7C
	lda ram_043E
	cmp #$1E
	bne @C86A

	lda zp_004C,Y
	bmi @C875

	ldx zp_4C,Y
	inx
	stx zp_4C,Y
	cpx #$02
	bcc @C86A

	lda #$80
	sta zp_004C,Y
	@C86A:
	lda ram_043E
	cmp zp_008E,Y
	beq @C875

	jsr sub_rom_CA4F
	@C875:
	rts

; -----------------------------------------------------------------------------

sub_rom_C876:
	lda ram_043D
	asl A
	tay
	lda rom_C914+0,Y
	sta zp_3B
	lda rom_C914+1,Y
	sta zp_3C
	ldx ram_043D
	lda rom_C8D5,X
	clc
	adc zp_7C
	tax
	stx zp_7B
	lda zp_A9,X
	sta zp_12
	inc zp_12
	ldx zp_7C
	lda zp_8A,X
	tay
	lda zp_2D,X
	beq @C8BC

	cpy #$00
	beq @C8B0

	and #$03
	bne @C8AC

	lda zp_2D,X
	bne @C8B0

	@C8AC:
	lda zp_2D,X
	eor #$03
	@C8B0:
	ldy zp_12
	ldx zp_7B
	cmp (zp_3B),Y
	beq @C8C2

	lda #$00
	sta zp_A9,X
	@C8BC:
	jsr sub_rom_C8F9
	pla
	pla
	rts
; ----------------
	@C8C2:
	inc zp_A9,X
	lda #$00
	sta zp_BD,X
	lda zp_A9,X
	ldy #$00
	cmp (zp_3B),Y
	bcc @C8BC

	lda #$00
	sta zp_A9,X
	rts

; -----------------------------------------------------------------------------

rom_C8D5:
	.byte $00, $02, $04, $00, $02, $04, $00, $02
	.byte $04, $00, $02, $04, $00, $02, $04, $00
	.byte $02, $04, $00, $02, $04, $00, $02, $04
	.byte $00, $02, $04, $00, $02, $04, $00, $02
	.byte $04, $00, $02, $04

; -----------------------------------------------------------------------------

sub_rom_C8F9:
	ldx zp_7B
	lda zp_BD,X
	cmp #$0F
	bcc @C911

	lda #$00
	sta zp_BD,X
	lda zp_A9,X
	cmp zp_D1,X
	bne @C90F
	
	lda #$00
	sta zp_A9,X
	@C90F:
	sta zp_D1,X
	@C911:
	inc zp_BD,X
	rts

; -----------------------------------------------------------------------------

rom_C914:
	.word rom_C95C, rom_C963, rom_C967, rom_C96B
	.word rom_C96F, rom_C973, rom_C977, rom_C97B
	.word rom_C97F, rom_C983, rom_C987, rom_C98B
	.word rom_C98F, rom_C993, rom_C997, rom_C99B
	.word rom_C9A2, rom_C9A6, rom_C9AA, rom_C9AE
	.word rom_C9B2, rom_C9B6, rom_C9BA, rom_C9BE
	.word rom_C9C2, rom_C9C6, rom_C9CA, rom_C9CE
	.word rom_C9D5, rom_C9D9, rom_C9DD, rom_C9E4
	.word rom_C9E8, rom_C977, rom_C97B, rom_C97F

; -----------------------------------------------------------------------------

rom_C95C:
	.byte $06, $40, $40, $40, $40, $40, $40
rom_C963:
	.byte $03, $02, $01, $80
rom_C967:
	.byte $03, $04, $08, $40
rom_C96B:
	.byte $03, $02, $01, $40
rom_C96F:
	.byte $03, $04, $01, $80
rom_C973:
	.byte $03, $02, $01, $80
rom_C977:
	.byte $03, $04, $02, $40
rom_C97B:
	.byte $03, $04, $01, $80
rom_C97F:
	.byte $03, $01, $04, $80
rom_C983:
	.byte $03, $02, $01, $80
rom_C987:
	.byte $03, $04, $01, $80
rom_C98B:
	.byte $03, $04, $08, $80
rom_C98F:
	.byte $03, $02, $01, $80
rom_C993:
	.byte $03, $04, $01, $80
rom_C997:
	.byte $03, $04, $08, $40
rom_C99B:
	.byte $06, $80, $80, $80, $80, $80, $80
rom_C9A2:
	.byte $03, $01, $04, $80
rom_C9A6:
	.byte $03, $02, $01, $80
rom_C9AA:
	.byte $03, $04, $01, $40
rom_C9AE:
	.byte $03, $04, $01, $80
rom_C9B2:
	.byte $03, $01, $04, $80
rom_C9B6:
	.byte $03, $02, $10, $80
rom_C9BA:
	.byte $03, $02, $01, $80
rom_C9BE:
	.byte $03, $02, $10, $80
rom_C9C2:
	.byte $03, $02, $10, $80
rom_C9C6:
	.byte $03, $02, $01, $80
rom_C9CA:
	.byte $03, $02, $10, $80
rom_C9CE:
	.byte $06, $80, $80, $80, $80, $80, $80
rom_C9D5:
	.byte $03, $02, $01, $40
rom_C9D9:
	.byte $03, $01, $04, $80
rom_C9DD:
	.byte $06, $80, $80, $80, $80, $80, $80
rom_C9E4:
	.byte $03, $01, $04, $80
rom_C9E8:
	.byte $03, $04, $01, $80

; -----------------------------------------------------------------------------

sub_rom_C9EC:
	ldy #$00
	jsr sub_rom_C9F2
	iny
; ----------------
sub_rom_C9F2:
	lda zp_008E,Y
	cmp #$2A
	bne @CA04

	lda zp_00F2,Y
	bpl @CA08

	lda #$00
	sta zp_4B
	beq @CA08

	@CA04:
	cmp #$29
	bne @CA18

	@CA08:
	lda zp_0090,Y
	cmp #$05
	bcc @CA18

	lda #$05
	sta zp_7A
	jsr sub_rom_CA19
	pla
	pla
	@CA18:
	rts

; -----------------------------------------------------------------------------

sub_rom_CA19:
	lda zp_5E
	beq @CA26

	lda #$00
	sta zp_9F
	sta zp_A0
	sta zp_A1
	rts
; ----------------
	@CA26:
	lda #$01
	sta zp_A1
	lda zp_9F
	clc
	adc #$2C
	sta zp_A0
	bcc @CA35

	inc zp_A1
	@CA35:
	ldx zp_A5
	cpx zp_A6
	bcc @CA3D

	ldx zp_A6
	@CA3D:
	dex
	beq @CA4E

	lda zp_A0
	sec
	sbc #$01
	sta zp_A0
	bcs @CA4B

	dec zp_A1
	@CA4B:
	jmp @CA3D

	@CA4E:
	rts

; -----------------------------------------------------------------------------

sub_rom_CA4F:
	ldy zp_7C
	sta zp_008E,Y
	lda #$00
	sta zp_0090,Y
	sty zp_8C
	rts

; -----------------------------------------------------------------------------

sub_rom_CA5C:
	ldy #$00
	sty zp_7C
	jsr sub_rom_CA66
	iny
	sty zp_7C

; -----------------------------------------------------------------------------

sub_rom_CA66:
	lda #$58
	cmp zp_A5
	beq @CA70

	cmp zp_A6
	bne @CA7C

	@CA70:
	ldy #$01
	@CA72:
	ldx #$68
	@CA74:
	dex
	bne @CA74

	dey
	bne @CA72

	beq @CA94

	@CA7C:
	jsr sub_rom_D164
	jsr sub_rom_CC36
	jsr sub_rom_CBC7
	jsr sub_rom_CBFC
	jsr sub_rom_D1B6
	jsr sub_rom_D0E1
	jsr sub_rom_D129
	jsr sub_rom_CAC0
	@CA94:
	ldy zp_7C
	jsr sub_rom_CB0C
	jsr sub_rom_CB7F
	rts

; -----------------------------------------------------------------------------

sub_rom_CA9D:
	ldx #$00
	jsr sub_rom_CAA3
	inx

; -----------------------------------------------------------------------------

sub_rom_CAA3:
	lda zp_E5,X
	cmp #$03
	bcs @CABF

	lda zp_8E,X
	cmp #$09
	beq @CAB3

	cmp #$0A
	bne @CABF

	@CAB3:
	lda zp_90,X
	cmp #$01
	bne @CABF

	inc zp_E5,X
	lda #$00
	sta zp_E9,X
	@CABF:
	rts

; -----------------------------------------------------------------------------

sub_rom_CAC0:
	ldy zp_7C
	lda zp_00E5,Y
	cmp #$03
	bcc @CAE4

	lda zp_008E,Y
	cmp #$27
	bne @CAE4

	lda zp_0090,Y
	cmp #$01
	bne @CAE4

	lda #$28
	sta zp_008E,Y
	lda #$00
	sta zp_00E5,Y
	sta zp_0090,Y
	@CAE4:
	lda zp_00E9,Y
	cmp #$70
	bcc @CB00

	lda #$00
	sta zp_00E9,Y
	lda zp_00E5,Y
	cmp zp_00E7,Y
	bne @CAFD

	lda #$00
	sta zp_00E5,Y
	@CAFD:
	sta zp_00E7,Y
	@CB00:
	lda zp_00E9,Y
	clc
	adc #$01
	sta zp_00E9,Y
	rts

; -----------------------------------------------------------------------------

rom_CB0A:
	.byte $00, $80

; -----------------------------------------------------------------------------

sub_rom_CB0C:
	lda zp_008E,Y
	cmp #$2E
	beq @CB1B

	cmp #$30
	beq @CB1B

	cmp #$31
	bne @CB7E

	@CB1B:
	lda #$06
	cmp zp_0090,Y
	bcs @CB7E

	lda zp_4A
	sec
	sbc #$22
	sta zp_12
	sec
	sbc #$38
	sta zp_13
	lda zp_0088,Y
	cmp zp_12
	bcs @CB5A

	cmp zp_13
	bcc @CB7E

	lda zp_00E5,Y
	cmp #$03
	bcs @CB5A

	lda zp_00A5,Y
	cmp #$58
	bcs @CB5A

	lda #$34
	sta zp_008E,Y
	lda #$0A
	sta zp_0090,Y
	lda zp_13
	clc
	adc #$0C
	sta zp_0088,Y
	rts
; ----------------
	@CB5A:
	lda zp_4A
	sec
	sbc #$1A
	sta zp_12
	lda zp_0088,Y
	cmp zp_12
	bcc @CB7E

	lda #$02
	sta zp_92
	lda #$26
	sta zp_008E,Y
	lda #$00
	sta zp_0090,Y
	lda zp_4A
	clc
	adc #$08
	sta zp_0088,Y
	@CB7E:
	rts

; -----------------------------------------------------------------------------

sub_rom_CB7F:
	lda zp_008E,Y
	cmp #$26
	bne @CBC6

	lda zp_0090,Y
	cmp #$0C
	bcc @CBC6

	ldx zp_A5,Y
	cpx #$58
	bcc @CBB7

	lda #$0B
	sta zp_0090,Y
	tya
	eor #$01
	tax
	lda zp_90,X
	bne @CBC6

	lda #$2A
	sta zp_8E,X
	lda zp_A3,X
	tay
	lda zp_4A
	sta zp_88,X
	lda zp_F2,X
	bmi @CBB3

	lda zp_4B
	bmi @CBB6

	@CBB3:
	inc ram_040D,X
	@CBB6:
	rts
; ----------------
	@CBB7:
	lda #$27
	sta zp_008E,Y
	lda #$00
	sta zp_0090,Y
	lda zp_4A
	sta zp_0088,Y
	@CBC6:
	rts

; -----------------------------------------------------------------------------

sub_rom_CBC7:
	lda zp_008E,Y
	cmp #$06
	bne @CBFB

	ldx #$0E
	lda zp_002D,Y
	and #$40
	beq @CBDE

	lda #$07
	sta ram_0672
	bne @CBED

	@CBDE:
	lda zp_002D,Y
	and #$80
	beq @CBFB

	lda #$08
	sta ram_0672
	inx
	inx
	inx
	@CBED:
	lda zp_0090,Y
	cmp #$07
	bcc @CBF5

	inx
	@CBF5:
	txa
	sta zp_008E,Y
	sty zp_8C
	@CBFB:
	rts

; -----------------------------------------------------------------------------

sub_rom_CBFC:
	ldx #$19
	lda zp_008E,Y
	cmp #$07
	beq @CC0B

	cmp #$08
	bne @CC35

	ldx #$1F
	@CC0B:
	lda zp_002D,Y
	and #$80
	beq @CC19

	lda #$08
	sta ram_0672
	bne @CC27

	@CC19:
	lda zp_002D,Y
	and #$40
	beq @CC35

	lda #$07
	sta ram_0672
	inx
	inx
	@CC27:
	lda zp_0090,Y
	cmp #$07
	bcc @CC2F

	inx
	@CC2F:
	txa
	sta zp_008E,Y
	sty zp_8C
	@CC35:
	rts

; -----------------------------------------------------------------------------

sub_rom_CC36:
	jsr sub_rom_D0D1
	lda zp_002A,Y
	and #$04
	bne @CC5B

	lda zp_002D,Y
	and #$40
	beq @CC4F

	jsr sub_rom_CC82
	@CC4A:
	txa
	jsr sub_rom_CA4F
	rts
; ----------------
	@CC4F:
	lda zp_002D,Y
	and #$80
	beq @CC5B

	jsr sub_rom_CC5C
	bne @CC4A

	@CC5B:
	rts

; -----------------------------------------------------------------------------

sub_rom_CC5C:
	lda zp_9C
	cmp #$1E
	bcs @CC7F

	lda #$01
	ldx zp_8A,Y
	beq @CC6A

	lda #$02
	@CC6A:
	and zp_002A,Y
	beq @CC7C

	tya
	eor #$01
	tax
	lda zp_88,X
	cmp zp_4A
	bne @CC7C

	ldx #$18
	rts
; ----------------
	@CC7C:
	ldx #$25
	rts
; ----------------
	@CC7F:
	ldx #$10
	rts

; -----------------------------------------------------------------------------

sub_rom_CC82:
	lda zp_9C
	cmp #$30
	bcs @CC97

	lda #$1B
	ldx zp_A3,Y
	bne @CC90

	lda #$1B
	@CC90:
	cmp zp_9C
	bcc @CC97

	ldx #$0C
	rts
; ----------------
	@CC97:
	ldx #$0B
	rts

; -----------------------------------------------------------------------------

sub_rom_CC9A:
	lda zp_94
	cmp zp_92
	bcc @CCA5

	lda #$00
	sta zp_94
	rts
; ----------------
	@CCA5:
	inc zp_94
	rts

; -----------------------------------------------------------------------------

sub_rom_CCA8:
	jsr sub_rom_CD19
	rts

; -----------------------------------------------------------------------------

sub_rom_CCAC:
	lda zp_F1
	beq @CCC2

	cmp #$01
	bcc @CCC0

	lda #$02
	sta ram_0672
	lda #$00
	sta zp_F1
	inc zp_7A
	rts
; ----------------
	@CCC0:
	inc zp_F1
	@CCC2:
	rts

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_CCC3:
	lda zp_9C
	lsr A
	lsr A
	lsr A
	lsr A
	tax
	lda rom_CD09,X
	sta ram_0600
	lda zp_9C
	and #$0F
	tax
	lda rom_CD09,X
	sta ram_0601
	lda #$FF
	sta ram_0602
	lda zp_9D
	lsr A
	lsr A
	lsr A
	lsr A
	tax
	lda rom_CD09,X
	sta ram_0603
	lda zp_9D
	and #$0F
	tax
	lda rom_CD09,X
	sta ram_0604
	lda #$01
	sta zp_45
	lda #$05
	sta zp_46
	lda #$20
	sta zp_44
	lda #$4F
	sta zp_43
	rts

; -----------------------------------------------------------------------------

rom_CD09:
	.byte $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7
	.byte $B8, $B9, $C1, $C2, $C3, $C4, $C4, $C5

; -----------------------------------------------------------------------------

sub_rom_CD19:
	jsr sub_rom_CD81
	lda #$58
	cmp zp_A5
	beq sub_rom_CD34
	cmp zp_A6
	beq sub_rom_CD34
	inc zp_A2
	lda zp_A2
	cmp #$2D
	bcc sub_rom_CD34
	lda #$00
	sta zp_A2
	dec zp_9F
; ----------------
sub_rom_CD34:
	lda zp_9F
	sta zp_07
	lda #$00
	sta zp_08
	sta zp_09
	sta zp_0D
	jsr sub_rom_D6C7
	lda ram_066E
	clc
	adc #$B0
	sta ram_063E
	lda ram_066D
	clc
	adc #$B0
	sta ram_063F
	rts

; -----------------------------------------------------------------------------

sub_rom_CD56:
	lda zp_09
	cmp #$01
	bcc @CD7D

	lda zp_08
	cmp #$86
	bcc @CD7D

	lda zp_07
	cmp #$9F
	bcc @CD7D

	lda #$01
	sta zp_07
	sta ram_0403,X
	lda #$86
	sta zp_08
	sta ram_0404,X
	lda #$9F
	sta zp_09
	sta ram_0405,X
	@CD7D:
	jsr sub_rom_D6C7
	rts

; -----------------------------------------------------------------------------

sub_rom_CD81:
	lda ram_0411
	bne @CDD2

	lda zp_9F
	bne @CDD4

	lda zp_4A
	cmp zp_88
	bne @CDD2

	cmp zp_89
	bne @CDD2

	lda zp_A5
	cmp zp_A6
	bcc @CDA5

	bne @CDB7

	lda #$29
	sta zp_8E
	sta zp_8F
	jmp @CDC7

	@CDA5:
	ldx zp_A3
	lda zp_4A
	sta zp_88
	ldx #$2A
	stx zp_8E
	dex
	stx zp_8F
	inc ram_040D
	bne @CDC7

	@CDB7:
	ldx zp_A4
	lda zp_4A
	sta zp_89
	ldx #$29
	stx zp_8E
	inx
	stx zp_8F
	inc ram_040E
	@CDC7:
	lda #$00
	sta zp_90
	sta zp_91
	lda #$01
	sta ram_0411
	@CDD2:
	pla
	pla
	@CDD4:
	rts

; -----------------------------------------------------------------------------

sub_rom_CDD5:
	lda zp_A3
	asl A
	tax
	lda rom_CE40,X
	sta zp_3B
	lda rom_CE40+1,X
	sta zp_3C
	lda #$01
	sta zp_45
	lda #$1C
	sta zp_46
	lda #$20
	sta zp_44
	ldx #$84
	stx zp_43
	ldx #$00
	lda #$FF
	@CDF7:
	sta ram_0600,X
	inx
	cpx #$38
	bcc @CDF7

	ldx #$00
	ldy #$00
	lda (zp_3B),Y
	sta zp_07
	iny
	@CE08:
	lda (zp_3B),Y
	cmp #$20
	beq @CE14

	clc
	adc #$80
	sta ram_0600,X
	@CE14:
	iny
	inx
	cpx zp_07
	bcc @CE08

	lda zp_A4
	asl A
	tax
	lda rom_CE40,X
	sta zp_3B
	lda rom_CE40+1,X
	sta zp_3C
	ldy #$00
	ldx #$17
	lda (zp_3B),Y
	tay
	@CE2F:
	lda (zp_3B),Y
	cmp #$20
	beq @CE3B

	clc
	adc #$80
	sta ram_0600,X
	@CE3B:
	dex
	dey
	bne @CE2F

	rts

; -----------------------------------------------------------------------------

; Pointers to name strings
rom_CE40:
	.word rom_CE70, rom_CE77, rom_CE7D, rom_CE86
	.word rom_CE8F, rom_CE94, rom_CE99, rom_CEA2
	.word rom_CEA7, rom_CEB3, rom_CEBB, rom_CEC3

	.word rom_CE70, rom_CE77, rom_CE7D, rom_CE86
	.word rom_CE8F, rom_CE94, rom_CE99, rom_CEA2
	.word rom_CEA7, rom_CEB3, rom_CEBB, rom_CEC3

; -----------------------------------------------------------------------------

; Byte 0 = lengh, Bytes 1 to (length) = name
; TODO: Probably safe to use ASCII, otherwise custom encoding
rom_CE70:
	.byte $06, $52, $41, $59, $44, $45, $4E
rom_CE77:
	.byte $05, $53, $4F, $4E, $59, $41
rom_CE7D:
	.byte $08, $53, $55, $42, $5C, $5A, $45, $52, $4F
rom_CE86:
	.byte $08, $53, $43, $4F, $52, $50, $49, $4F, $4E
rom_CE8F:
	.byte $04, $4B, $41, $4E, $4F
rom_CE94:
	.byte $04, $43, $41, $47, $45
rom_CE99:
	.byte $08, $4C, $49, $55, $5C, $4B, $41, $4E, $47
rom_CEA2:
	.byte $04, $47, $4F, $52, $4F
rom_CEA7:
	.byte $0B, $53, $48, $41, $4E, $47, $5C, $54, $53, $55, $4E, $47
rom_CEB3:
	.byte $07, $20, $20, $20, $20, $20, $20, $20
rom_CEBB:
	.byte $07, $20, $20, $20, $20, $20, $20, $20
rom_CEC3:
	.byte $03, $20, $20, $20

; Nothing seems to point to these "empty" names
	.byte $03, $20, $20, $20
	.byte $05, $20, $20, $20, $20, $20
	.byte $03, $20, $20, $20
	.byte $07, $20, $20, $20, $20, $20, $20, $4B
	.byte $03, $20, $41, $20
	.byte $06, $41, $20, $20, $20, $20, $4C
	.byte $06, $20, $20, $20, $20, $20, $20
	.byte $06, $20, $20, $20, $20, $20, $20
	.byte $04, $42, $20, $20, $20
	.byte $06, $20, $20, $20, $20, $20, $4F
	.byte $07, $42, $20, $20, $20, $20, $20, $20
	.byte $04, $20, $20, $20, $47

; -----------------------------------------------------------------------------

; Possibly unused rubbish
rom_CF0F:
	.byte $1F, $1C, $22, $1B, $11, $FF, $13, $16
	.byte $14, $15, $21, $FF, $31, $31, $FF, $FF

; -----------------------------------------------------------------------------

sub_rom_CF1F:
	lda zp_86
	cmp zp_87
	bcs @CF2C
	lda zp_87
	sec
	sbc zp_86
	bne @CF2F
	@CF2C:
	sec
	sbc zp_87
	@CF2F:
	sta zp_9C
	ldx #$00
	lda zp_88
	cmp zp_89
	bcs @CF40
	lda zp_89
	sec
	sbc zp_88
	bne @CF44
	@CF40:
	inx
	sec
	sbc zp_89
	@CF44:
	sta zp_9D
	stx zp_8D
	lda #$1C
	sta ram_067E
	rts

; -----------------------------------------------------------------------------

sub_rom_CF4E:
	jsr sub_rom_CFB2
	lda #$02
	sta zp_92
	lda #$01
	sta zp_48
	lda #$00
	sta zp_49
	sta zp_A2
	sta zp_9F
	sta zp_8E
	sta zp_8F
	sta zp_90
	sta zp_91
	sta zp_83
	sta zp_85
	sta zp_8A
	sta zp_A5
	sta zp_A6
	sta zp_A7
	sta zp_A8
	sta zp_E5
	sta zp_E6
	sta zp_7F
	sta ram_0411
	sta zp_4C
	sta zp_4D
	lda #$40
	sta zp_81
	sta ram_0414
	lda #$01
	sta zp_8B
	lda #$90
	sta zp_82
	lda #$F0
	sta zp_84
	lda zp_4A
	sta zp_88
	sta zp_89
	sta zp_F4
	sta zp_F5
	lda #$00
	tax
	@CFA4:
	sta zp_A9,X
	inx
	cpx #$3C
	bcc @CFA4

	jsr sub_rom_C0EA
	jsr sub_rom_D76D
	rts

; -----------------------------------------------------------------------------

sub_rom_CFB2:
	ldx #$D8
	stx zp_34
	inx
	inx
	stx zp_35
	ldy ram_0410
	tya
	asl A
	tay
	lda rom_D596+0,Y
	sta zp_12
	lda rom_D596+1,Y
	sta zp_13
	ldy #$00
	ldx #$00
	@CFCE:
	lda (zp_12),Y
	sta ram_0640,X
	inx
	iny
	cpy #$10
	bcc @CFCE

	ldx #$10
	lda zp_A3
	jsr sub_rom_CFE4
	ldx #$18
	lda zp_A4
; ----------------
sub_rom_CFE4:
	asl A
	tay
	lda rom_D4A6+0,Y
	sta zp_12
	lda rom_D4A6+1,Y
	sta zp_13
	ldy #$00
	@CFF2:
	lda (zp_12),Y
	sta ram_0640,X
	inx
	iny
	cpy #$08
	bcc @CFF2

	rts

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_CFFE:
	lda zp_A3
	asl A
	tax
	lda rom_D4A6+0,X
	sta zp_12
	lda rom_D4A6+1,X
	sta zp_13
	ldy #$00
	ldx #$00
	@D010:
	lda (zp_12),Y
	sta ram_0600,X
	inx
	iny
	cpy #$08
	bcc @D010

	lda #$37
	sta ram_0600
	sty zp_46
	lda #$01
	sta zp_45
	lda #$3F
	sta zp_44
	lda #$10
	sta zp_43
	rts

; -----------------------------------------------------------------------------

sub_rom_D02F:
	lda zp_8E
	cmp #$06
	bcc @D045

	cmp #$26
	bcc @D055

	cmp #$2D
	beq @D055

	cmp #$2E
	beq @D055

	cmp #$18
	beq @D055

	@D045:
	ldx #$00
	sec
	lda zp_82
	sbc zp_84
	lda zp_83
	sbc zp_85
	bmi @D053

	inx
	@D053:
	stx zp_8A
	@D055:
	lda zp_8F
	cmp #$06
	bcc @D06B

	cmp #$26
	bcc @D07B

	cmp #$2D
	beq @D07B

	cmp #$2E
	beq @D07B

	cmp #$18
	beq @D07B

	@D06B:
	ldx #$00
	sec
	lda zp_82
	sbc zp_84
	lda zp_83
	sbc zp_85
	bpl @D079

	inx
	@D079:
	stx zp_8B
	@D07B:
	rts

; -----------------------------------------------------------------------------

sub_rom_D07C:
	ldy #$00
	jsr sub_rom_D082
	iny
; ----------------
sub_rom_D082:
	lda zp_00A3,Y
	beq @D08B

	cmp #$04
	bne @D09D

	@D08B:
	lda zp_008E,Y
	cmp #$18
	bne @D09D

	lda zp_0090,Y
	cmp #$0A
	bcs @D09D

	pla
	pla
	sec
	rts
; ----------------
	@D09D:
	clc
	rts

; -----------------------------------------------------------------------------

sub_rom_D09F:
	jsr sub_rom_D07C
	bcs @D0C4

	clc
	lda zp_82
	adc zp_84
	sta zp_12
	lda zp_83
	adc zp_85
	sta zp_13
	lsr zp_13
	ror zp_12
	lda zp_12
	sec
	sbc #$80
	ldx ram_0410
	cmp rom_D0C5,X
	bcs @D0C4

	sta zp_81
	@D0C4:
	rts

; -----------------------------------------------------------------------------

rom_D0C5:
	.byte $68, $68, $68, $68, $68, $68, $68, $68
	.byte $68, $50, $50, $88

; -----------------------------------------------------------------------------

sub_rom_D0D1:
	lda zp_008E,Y
	beq sub_rom_D0E0
; ----------------
sub_rom_D0D6:
	cmp #$02
	bcc @D0DE

	cmp #$06
	bcc sub_rom_D0E0

	@D0DE:
	pla
	pla
; ----------------
sub_rom_D0E0:
	rts

; -----------------------------------------------------------------------------

sub_rom_D0E1:
	lda zp_00A3,Y
	beq @D0EE
	cmp #$03
	beq @D0EE
	cmp #$04
	bne @D0F3
	@D0EE:
	lda zp_00AD,Y
	bne @D124
	@D0F3:
	jsr sub_rom_D0D1
	lda zp_002A,Y
	and #$08
	beq @D124
	lda zp_002A,Y
	and #$01
	beq @D111
	ldx #$08
	lda zp_008A,Y
	bne @D10C
	dex
	@D10C:
	txa
	jsr sub_rom_CA4F
	rts
; ----------------
	@D111:
	lda zp_002A,Y
	and #$02
	beq @D125
	ldx #$08
	lda zp_008A,Y
	beq @D120
	dex
	@D120:
	txa
	@D121:
	jsr sub_rom_CA4F
	@D124:
	rts
; ----------------
	@D125:
	lda #$06
	bne @D121
; ----------------
sub_rom_D129:
	lda zp_008E,Y
	beq @D136

	cmp #$03
	beq @D136

	cmp #$04
	bne @D163

	@D136:
	tya
	eor #$01
	tax
	lda zp_8E,X
	cmp #$0B
	bcc @D163

	cmp #$26
	bcs @D163

	cmp #$14
	beq @D163

	cmp #$18
	beq @D163

	lda #$01
	ldx zp_8A,Y
	bne @D154

	lda #$02
	@D154:
	and zp_002A,Y
	beq @D163

	lda #$05
	sta zp_008E,Y
	lda #$00
	sta zp_0090,Y
	@D163:
	rts

; -----------------------------------------------------------------------------

sub_rom_D164:
	lda zp_5E
	bne @D190

	lda zp_00F2,Y
	and #$80
	bne @D190

	lda zp_008E,Y
	bne @D1A5

	lda zp_7F
	bne @D1A5

	lda zp_002A,Y
	and #$01
	beq @D191

	ldx #$04
	lda zp_008A,Y
	bne @D187
	dex
	@D187:
	txa
	sta zp_008E,Y
	lda #$00
	sta zp_0090,Y
	@D190:
	rts
; ----------------
	@D191:
	lda zp_002A,Y
	and #$02
	beq @D1A5

	ldx #$04
	lda zp_008A,Y
	beq @D1A0

	dex
	@D1A0:
	txa
	@D1A1:
	jsr sub_rom_CA4F
	@D1A4:
	rts
; ----------------
	@D1A5:
	lda zp_002A,Y
	and #$03
	bne @D1A4

	lda zp_008E,Y
	jsr sub_rom_D0D6
	lda #$00
	beq @D1A1
; ----------------
sub_rom_D1B6:
	tya
	eor #$01
	tax
	lda zp_008E,Y
	cmp #$06
	bcs @D209

	lda zp_002A,Y
	and #$04
	beq @D209

	lda zp_002D,Y
	and #$80
	beq @D1D3

	lda #$13
	bne @D206

	@D1D3:
	lda zp_002D,Y
	and #$40
	beq @D1DE

	lda #$14
	bne @D206

	@D1DE:
	lda zp_8E,X
	cmp #$0B
	bcc @D1FD

	cmp #$26
	bcs @D1FD

	cmp #$18
	beq @D1FD

	lda #$01
	ldx zp_8A,Y
	bne @D1F4

	lda #$02
	@D1F4:
	and zp_002A,Y
	beq @D1FD

	lda #$02
	bne @D206

	@D1FD:
	lda zp_00A3,Y
	cmp #$07
	beq @D209

	lda #$01
	@D206:
	jsr sub_rom_CA4F
	@D209:
	rts

; -----------------------------------------------------------------------------

sub_rom_D20A:
	ldy #$00
	sty zp_7C
	jsr sub_rom_D215
	ldy #$01
	sty zp_7C
; ----------------
sub_rom_D215:
	lda zp_0088,Y
	cmp zp_4A
	bcc @D22A

	cmp zp_00F4,Y
	beq @D22A

	sta zp_00F4,Y
	lda #$05
	sta ram_0672
	rts
; ----------------
	@D22A:
	sta zp_00F4,Y
	rts

; -----------------------------------------------------------------------------

; Possibly unused
sub_rom_D22E:
	ldy zp_7C
	lda zp_008E,Y
	cmp #$17
	beq @D24F

	lda zp_00A3,Y
	beq @D25C

	cmp #$03
	beq @D25C

	lda zp_008E,Y
	cmp #$0D
	beq @D25C

	cmp #$18
	beq @D25C

	cmp #$1E
	bne @D25C

	@D24F:
	lda zp_0090,Y
	cmp #$03
	bne @D25C

	lda #$04
	sta ram_0672
	rts
; ----------------
	@D25C:
	lda zp_008E,Y
	cmp #$0D
	bne @D26F

	lda zp_0090,Y
	cmp #$04
	bne @D26F
	
	lda #$08
	sta ram_0672
	@D26F:
	rts

; -----------------------------------------------------------------------------
.export sub_rom_D270
; This seems to transfer data to the PPU, depending on the flags in $4B.
sub_rom_D270:
	lda zp_4B
	cmp #$FF
	bne @D291

	lda #$20
	sta PpuAddr_2006
	ldx #$71
	lda zp_F2
	bpl @D283

	ldx #$64
	@D283:
	stx PpuAddr_2006
	ldx #$0A
	lda #$8A
	@D28A:
	sta PpuData_2007
	dex
	bpl @D28A

	rts
; ----------------
	@D291:
	lda zp_02
	ora #$04
	sta PpuControl_2000
	lda zp_25
	and #$01
	bne @D2A8

	ldx #$00
	jsr sub_rom_D359
	ldx #$01
	jsr sub_rom_D359
	@D2A8:
	jmp @D2EE

	@D2AB:
	lda zp_02
	sta PpuControl_2000
	lda zp_7A
	cmp #$03
	beq @D2BE

	cmp #$04
	beq @D2BE

	cmp #$05
	bne @D2ED

	@D2BE:
	lda #$20
	sta PpuAddr_2006
	lda #$8F
	sta PpuAddr_2006
	lda zp_9F
	cmp #$0F
	bcs @D2E1

	lda zp_25
	and #$04
	bne @D2E1

	lda zp_7A
	cmp #$03
	bne @D2E1

	ldx #$FF
	stx PpuData_2007
	bne @D2EA

	@D2E1:
	ldx ram_063E
	stx PpuData_2007
	ldx ram_063F
	@D2EA:
	stx PpuData_2007
	@D2ED:
	rts
; ----------------
	@D2EE:
	lda zp_7A
	cmp #$03
	beq @D356

	lda ram_040D
	beq @D325

	ldx #$20
	stx PpuAddr_2006
	cmp #$02
	bcc @D316

	ldx #$41
	stx PpuAddr_2006
	lda #$AD
	sta PpuData_2007
	lda #$AE
	sta PpuData_2007
	lda #$20
	sta PpuAddr_2006
	@D316:
	ldx #$42
	stx PpuAddr_2006
	lda #$AD
	sta PpuData_2007
	lda #$AE
	sta PpuData_2007
	@D325:
	lda ram_040E
	beq @D356

	ldx #$20
	stx PpuAddr_2006
	cmp #$02
	bcc @D347

	ldx #$5E
	stx PpuAddr_2006
	lda #$AD
	sta PpuData_2007
	lda #$AE
	sta PpuData_2007
	lda #$20
	sta PpuAddr_2006
	@D347:
	ldx #$5D
	stx PpuAddr_2006
	lda #$AD
	sta PpuData_2007
	lda #$AE
	sta PpuData_2007
	@D356:
	jmp @D2AB

; -----------------------------------------------------------------------------

sub_rom_D359:
	lda zp_A5,X
	cmp #$58
	bcc @D387

	lda zp_8E,X
	cmp #$2E
	beq @D375

	cmp #$31
	beq @D375

	cmp #$26
	beq @D38B

	lda #$2E
	sta zp_8E,X
	lda #$00
	sta zp_90,X
	@D375:
	lda zp_4B
	bmi @D38B

	lda #$32
	sta ram_0673
	lda #$10
	sta zp_92
	sta ram_0438
	bne @D38B

	@D387:
	lda zp_A7,X
	bne @D38C

	@D38B:
	rts
; ----------------
	@D38C:
	dec zp_A7,X
	inc zp_A5,X
	lda #$20
	sta PpuAddr_2006
	lda zp_A5,X
	sec
	sbc #$01
	lsr A
	lsr A
	lsr A
	sta zp_12
	txa
	bne @D3B7

	lda #$64
	clc
	adc zp_12
	sta PpuAddr_2006
	lda zp_A5
	sec
	sbc #$01
	and #$07
	tay
	lda rom_D3CE,Y
	bne @D3CA

	@D3B7:
	lda #$7B
	sec
	sbc zp_12
	sta PpuAddr_2006
	lda zp_A5,X
	sec
	sbc #$01
	and #$07
	tay
	lda rom_D3D6,Y
	@D3CA:
	sta PpuData_2007
	rts

; -----------------------------------------------------------------------------

rom_D3CE:
	.byte $89, $88, $87, $86, $85, $84, $83, $82
rom_D3D6:
	.byte $91, $90, $8F, $8E, $8D, $8C, $8B, $82

; -----------------------------------------------------------------------------

sub_rom_D3DE:
	lda zp_4B
	cmp #$FF
	bne @D3F0

	jsr sub_rom_CDD5
	lda #$00
	sta zp_4B
	lda #$03
	sta zp_7A
	rts
; ----------------
	@D3F0:
	ldx #$00
	lda zp_F2
	bmi @D3F7

	inx
	@D3F7:
	lda zp_4B
	and #$7F
	sta zp_A3,X
	lda #$00
	sta zp_8E,X
	sta zp_90,X
	sta zp_A5,X
	sta zp_A7,X
	lda #$FF
	sta zp_4B
	stx zp_7C
	jsr sub_rom_D935
	rts

; -----------------------------------------------------------------------------

; Potentially unused?
sub_rom_D411:
	lda #$10
	bne @D417

	lda #$1F
	@D417:
	sta ram_0400
	lda #$00
	sta ram_0401
	sta ram_0402
; ----------------
; This entry point is used
sub_rom_D422:
	ldx ram_0401
	cpx #$07
	bcs @D43F

	ldy ram_0402
	bne @D433

	ldy #$03
	sty ram_0402
	@D433:
	dec ram_0402
	bne @D43E

	jsr sub_rom_D465
	inc ram_0401
	@D43E:
	clc
	@D43F:
	rts

; -----------------------------------------------------------------------------

sub_rom_D440:
	ldx ram_0401
	beq @D463

	ldy ram_0402
	bne @D44F

	ldy #$03
	sty ram_0402
	@D44F:
	dec ram_0402
	bne @D461

	dec ram_0401
	dex
	jsr sub_rom_D465
	cpx #$00
	bne @D461

	stx zp_04
	@D461:
	clc
	rts
; ----------------
	@D463:
	sec
	rts

; -----------------------------------------------------------------------------

sub_rom_D465:
	ldy ram_0400
	@D468:
	lda ram_0640,Y
	cmp rom_D498,X
	bcs @D474

	lda #$0E
	bcc @D47C

	@D474:
	lda rom_D498,X
	eor #$3F
	and ram_0640,Y
	@D47C:
	sta ram_0600,Y
	dey
	bpl @D468

	lda rom_D49F,X
	sta zp_04
	lda #$3F
	sta zp_44
	lda #$00
	sta zp_43
	lda #$01
	sta zp_45
	lda #$20
	sta zp_46
	rts

; -----------------------------------------------------------------------------

rom_D498:
	.byte $FF, $30, $30, $20, $20, $10, $00

; -----------------------------------------------------------------------------

rom_D49F:
	.byte $1E, $FE, $1E, $FE, $1E, $1E, $1E

; -----------------------------------------------------------------------------

rom_D4A6:
	.byte $D6, $D4, $DE, $D4, $E6, $D4, $EE, $D4
	.byte $F6, $D4, $FE, $D4, $06, $D5, $0E, $D5
	.byte $16, $D5, $1E, $D5, $26, $D5, $2E, $D5
	.byte $36, $D5, $3E, $D5, $46, $D5, $4E, $D5
	.byte $56, $D5, $5E, $D5, $66, $D5, $6E, $D5
	.byte $76, $D5, $7E, $D5, $86, $D5, $8E, $D5
	.byte $0E, $08, $2C, $20, $0E, $08, $26, $20
	.byte $0E, $08, $18, $20, $0E, $08, $18, $36
	.byte $0E, $08, $2C, $1C, $0E, $08, $2C, $37
	.byte $0E, $08, $27, $17, $0E, $08, $27, $37
	.byte $0E, $07, $27, $30, $0E, $07, $2C, $30
	.byte $0E, $08, $27, $37, $0E, $07, $27, $37
	.byte $0E, $08, $16, $30, $0E, $07, $27, $37
	.byte $0E, $07, $27, $30, $0E, $07, $27, $37
	.byte $0E, $1D, $00, $10, $0E, $0D, $0C, $17
	.byte $0E, $37, $27, $07, $0E, $37, $21, $02
	.byte $0E, $37, $26, $16, $0E, $37, $18, $16
	.byte $0E, $07, $27, $37, $0E, $0E, $15, $25
	.byte $0E, $08, $1C, $20, $0E, $08, $25, $20
	.byte $0E, $08, $15, $20, $0E, $08, $15, $36
	.byte $00, $08, $1C, $0C, $00, $08, $1C, $37
	.byte $0E, $08, $26, $16, $0E, $08, $26, $37
	.byte $0E, $07, $27, $30, $0E, $07, $28, $30
	.byte $0E, $06, $26, $36, $0E, $08, $26, $36
	.byte $0E, $05, $16, $30, $0E, $05, $27, $37
	.byte $0E, $07, $28, $30, $0E, $07, $28, $38
	.byte $0E, $1D, $00, $10, $0E, $0D, $06, $17
	.byte $0E, $37, $27, $07, $0E, $37, $19, $09
	.byte $0E, $37, $26, $0E, $0E, $37, $18, $0E
	.byte $0E, $07, $27, $37, $0E, $0E, $11, $21

; -----------------------------------------------------------------------------

rom_D596:
	.byte $B0, $D5, $C0, $D5, $D0, $D5, $E0, $D5
	.byte $F0, $D5, $00, $D6, $10, $D6, $20, $D6
	.byte $30, $D6, $40, $D6, $50, $D6, $60, $D6
	.byte $70, $D6, $0E, $16, $2A, $28, $0E, $06
	.byte $16, $26, $0E, $10, $10, $30, $0E, $00
	.byte $10, $20, $0E, $16, $2A, $28, $0E, $18
	.byte $28, $38, $0E, $0C, $1C, $2C, $0E, $00
	.byte $10, $20, $0E, $16, $2A, $28, $0E, $1B
	.byte $27, $3C, $0E, $05, $27, $3C, $0E, $00
	.byte $10, $3C, $0E, $16, $2A, $28, $0E, $17
	.byte $27, $3C, $0E, $17, $06, $3C, $0E, $00
	.byte $10, $3C, $0E, $16, $2A, $28, $0E, $21
	.byte $26, $20, $0E, $18, $28, $38, $0E, $00
	.byte $10, $20, $0E, $16, $2A, $28, $0E, $0B
	.byte $18, $06, $0E, $18, $28, $06, $0E, $00
	.byte $10, $06

; -----------------------------------------------------------------------------

; Potentially unused
rom_D610:
	.byte $0E, $06, $27, $30, $0E, $08, $18, $11
	.byte $0E, $0B, $1B, $11, $0E, $08, $18, $28
	.byte $0E, $05, $27, $30, $0E, $0B, $1B, $2C
	.byte $0E, $07, $16, $26, $0E, $0C, $1C, $2C
	.byte $0E, $05, $27, $30, $0E, $0B, $1B, $3B
	.byte $0E, $00, $10, $20, $0E, $06, $16, $26
	.byte $0E, $31, $20, $10, $0E, $3B, $20, $10
	.byte $0E, $31, $20, $17, $0E, $06, $38, $16
	.byte $0E, $3B, $2A, $10, $0E, $2C, $1C, $3C
	.byte $0E, $26, $17, $36, $0E, $06, $38, $16
	.byte $0E, $06, $27, $30, $0E, $05, $10, $2B
	.byte $0E, $06, $16, $28, $0E, $1C, $2C, $3C
	.byte $0E, $8D, $00, $3E, $0E, $20, $00, $00
	.byte $0E, $02, $00, $90, $0E, $11, $0E, $30

; -----------------------------------------------------------------------------

; Potentially unused
; This would clear RAM between $0403-$0408
sub_rom_D680:
	lda #$00
	ldx #$06
	@D684:
	dex
	sta ram_0403,X
	bne @D684

	rts

; -----------------------------------------------------------------------------

sub_rom_D68B:
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

sub_rom_D6A0:
	lda #$F8
	ldx #$00
	@D6A4:
	sta ram_0200,X
	inx
	inx
	inx
	inx
	bne @D6A4
	rts

; -----------------------------------------------------------------------------

sub_rom_D6AE:
	lda #$00
	ldx #$18
	@D6B2:
	asl zp_07
	rol zp_08
	rol zp_09
	rol A
	cmp zp_16
	bcc @D6C1

	sbc zp_16
	inc zp_07
	@D6C1:
	dex
	bne @D6B2

	sta zp_12
	rts

; -----------------------------------------------------------------------------

sub_rom_D6C7:
	ldy #$00
	sty zp_17
	lda #$0A
	sta zp_16
	@D6CF:
	jsr sub_rom_D6AE
	lda zp_12
	clc
	adc zp_0D
	sta ram_066D,Y
	iny
	cpy #$05
	bcc @D6CF

	rts

; -----------------------------------------------------------------------------

sub_rom_D6E0:
	lda zp_7A
	cmp #$03
	bne sub_rom_D718

	lda zp_008E,Y
	cmp #$06
	bcc @D6F1

	cmp #$28
	bne sub_rom_D718

	@D6F1:
	lda zp_9C
	cmp #$18
	bcs sub_rom_D718

	lda zp_9D
	cmp #$10
	bcs sub_rom_D718

	lda #$04
	sta zp_12
; ----------------
sub_rom_D701:
	lda zp_008A,Y
	bne sub_rom_D719

	lda zp_0086,Y
	cmp #$20
	bcc sub_rom_D718

	lda zp_82,X
	sec
	sbc zp_12
	sta zp_82,X
	bcs sub_rom_D718

	dec zp_83,X
; ----------------
sub_rom_D718:
	rts
; ----------------
sub_rom_D719:
	lda zp_0086,Y
	cmp #$D0
	bcs sub_rom_D718

	lda zp_82,X
	clc
	adc zp_12
	sta zp_82,X
	bcc sub_rom_D718

	inc zp_83,X
	rts

; -----------------------------------------------------------------------------

sub_rom_D72C:
	lda zp_9C
	cmp #$50
	bcc @D737

	lda #$00
	sta zp_7F
	rts
; ----------------
	@D737:
	lda zp_7F
	bne @D759

	lda zp_008E,Y
	cmp #$2D
	beq @D752

	cmp #$2F
	beq @D752

	cmp #$09
	beq @D752

	cmp #$0A
	beq @D752

	cmp #$2E
	bne @D76C

	@D752:
	lda zp_0090,Y
	cmp #$02
	bne @D76C

	@D759:
	lda #$01
	sta zp_7F
	tya
	eor #$01
	tay
	txa
	eor #$02
	tax
	lda #$08
	sta zp_12
	jsr sub_rom_D701
	@D76C:
	rts

; -----------------------------------------------------------------------------

sub_rom_D76D:
	jsr sub_rom_D774
	jsr sub_rom_D20A
	rts

; -----------------------------------------------------------------------------

sub_rom_D774:
	ldx #$00
	stx zp_7B
	stx zp_7C
	jsr sub_rom_D784
	ldx #$02
	stx zp_7B
	dex
	stx zp_7C
; ----------------
sub_rom_D784:
	jsr sub_rom_D8F0
	ldy zp_7C
	ldx zp_A3,Y
	lda rom_D8D8,X
	sta zp_05
	lda #$86
	sta zp_FC
	sta rom_8000
	lda zp_05
	sta rom_8001
	lda #$87
	sta zp_FC
	sta rom_8000
	lda #$01
	sta rom_8001
	lda rom_8000
	sta zp_3B
	lda rom_8001
	sta zp_3C
	lda zp_008E,Y
	asl A
	bcc @D7BA

	inc zp_3C
	@D7BA:
	clc
	adc zp_008E,Y
	bcc @D7C2

	inc zp_3C
	@D7C2:
	sta zp_12
	tay
	lda (zp_3B),Y
	asl A
	tax
	lda rom_DAF7+0,X
	sta zp_3D
	lda rom_DAF7+1,X
	sta zp_3E
	ldy zp_7C
	lda zp_0090,Y
	asl A
	tay
	lda (zp_3D),Y
	sta zp_05
	iny
	lda (zp_3D),Y
	sta zp_06
	iny
	lda #$00
	sta zp_18
	lda (zp_3D),Y
	cmp #$80
	bne @D7F0

	inc zp_18
	@D7F0:
	ldx zp_7B
	ldy zp_7C
	lda zp_05
	bpl @D81A

	eor #$FF
	sta zp_05
	inc zp_05
	lda zp_008A,Y
	bne @D81F

	@D803:
	lda zp_0086,Y
	sec
	sbc zp_05
	cmp #$20
	bcc @D834

	lda zp_82,X
	sec
	sbc zp_05
	sta zp_82,X
	bcs @D834

	dec zp_83,X
	beq @D834

	@D81A:
	lda zp_008A,Y
	bne @D803
	@D81F:
	lda zp_0086,Y
	clc
	adc zp_05
	cmp #$D0
	bcs @D834

	lda zp_82,X
	clc
	adc zp_05
	sta zp_82,X
	bcc @D834

	inc zp_83,X
	@D834:
	lda zp_0088,Y
	clc
	adc zp_06
	sta zp_0088,Y
	ldy zp_12
	iny
	lda (zp_3B),Y
	sta zp_3D
	iny
	lda (zp_3B),Y
	sta zp_3E
	ldy zp_7C
	lda zp_0090,Y
	tay
	lda (zp_3D),Y
	sta zp_12
	lda rom_8002+0
	sta zp_3D
	lda rom_8002+1
	sta zp_3E
	lda zp_12
	asl A
	bcc @D862
	@D862:
	tay
	lda (zp_3D),Y
	sta zp_3B
	iny
	lda (zp_3D),Y
	sta zp_3C
	ldx zp_7B
	ldy zp_7C
	jsr sub_rom_D6E0
	jsr sub_rom_D72C
	ldy zp_7C
	ldx rom_CB0A,Y
	lda zp_008E,Y
	cmp #$09
	beq @D88A

	cmp #$2E
	beq @D88A

	cmp #$28
	bne @D88E

	@D88A:
	inx
	inx
	inx
	inx
	@D88E:
	stx zp_1A
	ldx zp_7B
	lda zp_008A,Y
	beq @D899

	lda #$40
	@D899:
	sta zp_1B
	lda zp_82,X
	sec
	sbc zp_81
	sta zp_0086,Y
	sta zp_07
	ldx #$08
	stx zp_12
	lda zp_0088,Y
	sec
	sbc zp_12
	sta zp_0A
	ldx zp_7C
	inc zp_90,X
	ldy zp_7C
	ldx zp_8E,Y
	lda zp_0090,Y
	cmp #$01
	bne @D8C8

	lda rom_DABE,X
	beq @D8C8

	sta ram_0672
	@D8C8:
	lda zp_18
	beq @D8D4

	lda #$00
	sta zp_008E,Y
	sta zp_0090,Y
	@D8D4:
	jsr sub_rom_D9AF
	rts

; -----------------------------------------------------------------------------

rom_D8D8:
	.byte $05, $06, $07, $08, $09, $0A, $0B, $0C
	.byte $0D, $05, $05, $05, $00, $01, $00, $02
	.byte $00, $01, $00, $01, $02, $00, $01, $00

; -----------------------------------------------------------------------------

sub_rom_D8F0:
	ldx zp_7C
	lda zp_F2,X
	and #$7F
	cmp #$08
	beq @D8FE
	cmp #$14
	bne @D92B
	@D8FE:
	lda zp_90,X
	bne @D923
	ldy zp_8E,X
	lda rom_D977,Y
	beq @D923
	cmp #$01
	bne @D91D
	lda zp_A3,X
	cmp #$08
	bne @D923
	jsr sub_rom_D96D
	cpy #$08
	bne @D933
	dey
	bne @D933
	@D91D:
	lda #$08
	sta zp_A3,X
	bne sub_rom_D935
	@D923:
	lda zp_48,X
	cmp #$30
	bcs @D92C
	inc zp_48,X
	@D92B:
	rts
; ----------------
	@D92C:
	lda zp_8E,X
	bne @D92B
	jsr sub_rom_D96D
	@D933:
	sty zp_A3,X
; ----------------
sub_rom_D935:
	lda zp_A3,X
	asl A
	tax
	lda rom_D4A6+0,X
	sta zp_12
	lda rom_D4A6+1,X
	sta zp_13
	ldy #$00
	ldx zp_7C
	sty zp_48,X
	sty zp_90,X
	ldx #$00
	@D94D:
	lda (zp_12),Y
	sta ram_0600,X
	inx
	iny
	cpy #$08
	bcc @D94D

	sty zp_46
	lda #$01
	sta zp_45
	lda #$3F
	sta zp_44
	ldy #$10
	lda zp_7C
	beq @D96A

	ldy #$18
	@D96A:
	sty zp_43
	rts

; -----------------------------------------------------------------------------

; Potentially unused
sub_rom_D96D:
	lda zp_22
	and #$07
	bne @D974

	iny
	@D974:
	tay
	iny
	rts

; -----------------------------------------------------------------------------

rom_D977:
	.byte $00, $01, $00, $00, $00, $01, $01, $01
	.byte $01, $01, $01, $01, $01, $01, $01, $01
	.byte $01, $01, $01, $01, $01, $01, $01, $01
	.byte $01, $01, $01, $01, $01, $01, $01, $01
	.byte $01, $01, $01, $01, $01, $01, $02, $01
	.byte $01, $02, $02, $01, $01, $01, $02, $01
	.byte $01, $01, $01, $01, $01, $01, $01, $01

; -----------------------------------------------------------------------------

sub_rom_D9AF:
	ldx rom_CB0A,Y
	ldy #$00
	lda #$F8
	@D9B6:
	sta ram_0300,X
	inx
	inx
	inx
	inx
	iny
	cpy #$20
	bcc @D9B6

	ldy #$00
	lda (zp_3B),Y
	sta zp_05
	sta zp_14
	iny
	lda (zp_3B),Y
	sta zp_06
	sta zp_16
	iny
	lda (zp_3B),Y
	sta zp_0F
	iny
	lda (zp_3B),Y
	ldx zp_7C
	sta zp_96,X
	sta ram_0429
	iny
	lda (zp_3B),Y
	sta ram_042A
	iny
	lda zp_05
	sta zp_09
	lda zp_1B
	bne @D9FB

	lda #$08
	sta zp_12
	lda zp_07
	sec
	sbc zp_0F
	jmp @DA07

	@D9FB:
	lda #$F8
	sta zp_12
	lda zp_0F
	sec
	sbc #$08
	clc
	adc zp_07
	@DA07:
	sta zp_07
	sta zp_08
	ldx zp_06
	@DA0D:
	lda zp_0A
	sec
	sbc #$08
	sta zp_0A
	dex
	bne @DA0D
	sta zp_0B
	dec zp_0B
	ldx zp_1A
	@DA1D:
	lda (zp_3B),Y
	cmp #$FF
	beq @DA44

	and #$7F
	pha
	lda zp_7C
	beq @DA2F

	pla
	ora #$80
	bne @DA30

	@DA2F:
	pla
	@DA30:
	sta ram_0301,X
	jmp @DA64

	@DA36:
	lda zp_0B
	sta ram_0300,X
	lda zp_08
	sta ram_0303,X
	inx
	inx
	inx
	inx
	@DA44:
	iny
	lda zp_12
	clc
	adc zp_08
	sta zp_08
	dec zp_09
	bne @DA1D

	lda zp_0B
	clc
	adc #$08
	sta zp_0B
	lda zp_05
	sta zp_09
	lda zp_07
	sta zp_08
	dec zp_06
	bne @DA1D

	rts
; ----------------
	@DA64:
	tya
	pha
	lda ram_0429
	tay
	lda rom_B000+0,Y
	sta zp_3D
	lda rom_B000+1,Y
	sta zp_3E
	lda ram_0301,X
	and #$07
	tay
	lda rom_DAB4,Y
	pha
	lda ram_0301,X
	and #$7F
	lsr A
	lsr A
	lsr A
	tay
	pla
	and (zp_3D),Y
	beq @DA8E

	lda #$01
	@DA8E:
	ora ram_042A
	eor zp_1B
	tay
	lda zp_7C
	beq @DA9D

	tya
	ora #$02
	bne @DA9E

	@DA9D:
	tya
	@DA9E:
	ldy ram_0410
	cpy #$06
	bne @DAA7

	ora #$20
	@DAA7:
	sta ram_0302,X
	pla
	tay
	lda #$FB
	sta ram_067F
	jmp @DA36

; -----------------------------------------------------------------------------

; Probably an index/mask conversion table
rom_DAB4:
	.byte $01, $02, $04, $08, $10, $20, $40, $80
; Potentially unused bytes
	.byte $2C, $AC

; -----------------------------------------------------------------------------

rom_DABE:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $07, $07, $08, $00, $00
	.byte $08, $00, $00, $08, $07, $08, $00, $04
	.byte $08, $00, $00, $00, $00, $00, $04, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $FF

; -----------------------------------------------------------------------------

; Data pointers
rom_DAF7:
	.word rom_DB7D, rom_DB98, rom_DBCC, rom_DBB7
	.word rom_DBF6, rom_DC17, rom_DB8B, rom_DBE5
	.word rom_DB81, rom_DB79, rom_DB85, rom_DC38
	.word rom_DC59, rom_DC66, rom_DC8D, rom_DCA8
	.word rom_DB65, rom_DB89, rom_DCD3, rom_DCEE
	.word rom_DD19, rom_DD46, rom_DD53, rom_DD68
	.word rom_DB51, rom_DD89, rom_DDA8, rom_DDC1
	.word rom_DDC2, rom_DB75, rom_DE03, rom_DE04
	.word rom_DE05, rom_DE12, rom_DB87, rom_DE2F
	.word rom_DE48, rom_DB8E, rom_DBAD, rom_DE6D
	.word rom_DE8E, rom_DE9B, rom_DEB4, rom_DECD
	.word rom_DEEE

; -----------------------------------------------------------------------------

rom_DB51:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00

; -----------------------------------------------------------------------------

rom_DB65:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00

; -----------------------------------------------------------------------------

rom_DB75:
	.byte $00, $00, $00, $00

; -----------------------------------------------------------------------------

rom_DB79:
	.byte $00, $00, $00, $00

; -----------------------------------------------------------------------------

rom_DB7D:
	.byte $00, $00, $00, $00

; -----------------------------------------------------------------------------

rom_DB81:
	.byte $00, $00, $00, $00

; -----------------------------------------------------------------------------

rom_DB85:
	.byte $00, $00

; -----------------------------------------------------------------------------

rom_DB87:
	.byte $00, $00

; -----------------------------------------------------------------------------

rom_DB89:
	.byte $00, $00

; -----------------------------------------------------------------------------

rom_DB8B:
	.byte $00, $00, $80

; -----------------------------------------------------------------------------

rom_DB8E:
	.byte $04, $00, $04, $00, $04, $00, $04, $00
	.byte $04, $00

; -----------------------------------------------------------------------------

rom_DB98:
	.byte $04, $00, $04, $00, $04, $00, $04, $00
	.byte $04, $00, $04, $00, $04, $00, $04, $00
	.byte $04, $00, $04, $00, $80

; -----------------------------------------------------------------------------

rom_DBAD:
	.byte $FC, $00, $FC, $00, $FC, $00, $FC, $00
	.byte $FC, $00

; -----------------------------------------------------------------------------

rom_DBB7:
	.byte $FC, $00, $FC, $00, $FC, $00, $FC, $00
	.byte $FC, $00, $FC, $00, $FC, $00, $FC, $00
	.byte $FC, $00, $FC, $00, $80

; -----------------------------------------------------------------------------

rom_DBCC:
	.byte $00, $ED, $00, $F0, $00, $F2, $00, $F4
	.byte $00, $F6, $00, $F8, $00, $08, $00, $0A
	.byte $00, $0C, $00, $0E, $00, $10, $00, $13
	.byte $80

; -----------------------------------------------------------------------------

rom_DBE5:
	.byte $F8, $00, $F8, $00, $F8, $00, $FB, $00
	.byte $F8, $00, $FB, $00, $FD, $00, $FE, $00
	.byte $80

; -----------------------------------------------------------------------------

rom_DBF6:
	.byte $FE, $EE, $FE, $F0, $FE, $F2, $FE, $F4
	.byte $FC, $F6, $FA, $F8, $F8, $FA, $F6, $FC
	.byte $F6, $04, $F8, $06, $FA, $08, $FC, $0A
	.byte $FE, $0C, $FE, $0E, $FE, $10, $FE, $12
	.byte $80

; -----------------------------------------------------------------------------

rom_DC17:
	.byte $02, $EE, $02, $F0, $02, $F2, $02, $F4
	.byte $04, $F6, $06, $F8, $08, $FA, $0A, $FC
	.byte $0A, $04, $08, $06, $06, $08, $04, $0A
	.byte $02, $0C, $02, $0E, $02, $10, $02, $12
	.byte $80

; -----------------------------------------------------------------------------

rom_DC38:
	.byte $00, $00, $00, $00, $06, $E8, $0C, $00
	.byte $0C, $00, $0C, $00, $08, $00, $08, $00
	.byte $08, $00, $06, $00, $06, $00, $06, $00
	.byte $04, $00, $04, $00, $04, $00, $04, $18
	.byte $80

; -----------------------------------------------------------------------------

rom_DC59:
	.byte $10, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $80

; -----------------------------------------------------------------------------

rom_DC66:
	.byte $F0, $F4, $F2, $F6, $F4, $F8, $F6, $FC
	.byte $F8, $00, $FC, $01, $FC, $02, $FC, $04
	.byte $FE, $08, $FE, $0A, $FE, $0C, $FE, $0E
	.byte $FE, $10, $00, $12, $00, $14, $00, $14
	.byte $00, $14, $00, $14, $00, $14, $80

; -----------------------------------------------------------------------------

rom_DC8D:
	.byte $F6, $F8, $F8, $FA, $FA, $FC, $FC, $FE
	.byte $FE, $02, $FF, $04, $00, $06, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $80

; -----------------------------------------------------------------------------

rom_DCA8:
	.byte $00, $00, $0A, $F8, $F6, $00, $00, $00
	.byte $F6, $08, $0A, $00, $F6, $08, $00, $00
	.byte $F6, $F8, $F8, $FA, $FA, $FC, $FC, $FE
	.byte $FE, $02, $FF, $04, $00, $06, $00, $08
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $80

; -----------------------------------------------------------------------------

rom_DCD3:
	.byte $F6, $F8, $F8, $FA, $FA, $FC, $FC, $FE
	.byte $FE, $02, $FF, $04, $00, $06, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $80

; -----------------------------------------------------------------------------

rom_DCEE:
	.byte $00, $00, $0A, $F8, $F6, $00, $00, $00
	.byte $F6, $08, $0A, $00, $F6, $00, $00, $00
	.byte $F6, $F8, $F8, $FA, $FA, $FC, $FC, $FE
	.byte $FE, $02, $FF, $04, $00, $06, $00, $08
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $80

; -----------------------------------------------------------------------------

rom_DD19:
	.byte $00, $00, $00, $00, $0A, $F8, $F6, $00
	.byte $00, $00, $F6, $08, $00, $00, $F6, $00
	.byte $00, $00, $F6, $F8, $F8, $FA, $FA, $FC
	.byte $FC, $FE, $FE, $02, $FF, $04, $00, $06
	.byte $00, $08, $00, $08, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $80

; -----------------------------------------------------------------------------

rom_DD46:
	.byte $00, $EC, $00, $F1, $00, $F6, $00, $0A
	.byte $00, $0F, $00, $14, $80

; -----------------------------------------------------------------------------

rom_DD53:
	.byte $00, $F4, $00, $F6, $00, $F8, $00, $FA
	.byte $00, $FC, $00, $04, $00, $06, $00, $08
	.byte $00, $0A, $00, $0C, $80

; -----------------------------------------------------------------------------

rom_DD68:
	.byte $00, $EE, $00, $F0, $FF, $F2, $FE, $F4
	.byte $FD, $F6, $FC, $F8, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $F8, $08, $F9, $0A
	.byte $FA, $0C, $FB, $0E, $FC, $10, $FD, $12
	.byte $80

; -----------------------------------------------------------------------------

rom_DD89:
	.byte $00, $00, $00, $00, $00, $EA, $0A, $EC
	.byte $19, $F8, $F0, $FA, $F1, $FC, $F2, $FE
	.byte $F3, $02, $F4, $04, $F5, $06, $F6, $08
	.byte $F7, $0A, $F8, $0E, $F9, $12, $80

; -----------------------------------------------------------------------------

rom_DDA8:
	.byte $00, $00, $00, $00, $2A, $00, $00, $F0
	.byte $00, $00, $00, $00, $00, $F4, $00, $00
	.byte $2A, $00, $00, $00, $00, $14, $00, $00
	.byte $80

; -----------------------------------------------------------------------------

rom_DDC1:
	.byte $80

; -----------------------------------------------------------------------------

rom_DDC2:
	.byte $00, $F6, $00, $F8, $00, $FA, $00, $FC
	.byte $06, $00, $06, $00, $06, $00, $06, $00
	.byte $06, $00, $06, $00, $06, $00, $06, $00
	.byte $06, $00, $06, $00, $06, $00, $06, $00
	.byte $06, $00, $06, $00, $06, $00, $06, $00
	.byte $06, $00, $06, $00, $06, $00, $06, $00
	.byte $06, $00, $06, $00, $06, $00, $06, $00
	.byte $00, $04, $00, $06, $00, $08, $00, $0A
	.byte $80

; -----------------------------------------------------------------------------

rom_DE03:
	.byte $80

; -----------------------------------------------------------------------------

rom_DE04:
	.byte $80

; -----------------------------------------------------------------------------

rom_DE05:
	.byte $00, $00, $00, $00, $14, $00, $0F, $00
	.byte $0A, $00, $05, $00, $80

; -----------------------------------------------------------------------------

rom_DE12:
	.byte $00, $EC, $02, $F6, $04, $F6, $06, $00
	.byte $08, $00, $14, $00, $14, $00, $14, $00
	.byte $14, $00, $08, $00, $06, $00, $04, $0A
	.byte $02, $0A, $00, $14, $80

; -----------------------------------------------------------------------------

rom_DE2F:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $14, $00, $0F, $00, $0A, $00, $05, $00
	.byte $80

; -----------------------------------------------------------------------------

rom_DE48:
	.byte $01, $00, $02, $00, $03, $00, $04, $00
	.byte $05, $00, $06, $00, $07, $00, $08, $00
	.byte $08, $00, $08, $00, $08, $00, $08, $00
	.byte $08, $00, $08, $00, $08, $00, $08, $00
	.byte $08, $00, $08, $00, $80

; -----------------------------------------------------------------------------

rom_DE6D:
	.byte $02, $EE, $02, $F0, $02, $F2, $02, $F4
	.byte $04, $F6, $06, $F8, $08, $FA, $0A, $FC
	.byte $0A, $04, $08, $06, $08, $08, $08, $0A
	.byte $08, $0C, $08, $0E, $08, $10, $08, $12
	.byte $80

; -----------------------------------------------------------------------------

rom_DE8E:
	.byte $01, $00, $01, $00, $01, $00, $FF, $00
	.byte $FF, $00, $FF, $00, $80

; -----------------------------------------------------------------------------

rom_DE9B:
	.byte $00, $00, $00, $00, $20, $00, $00, $F0
	.byte $00, $00, $00, $00, $00, $F4, $00, $00
	.byte $30, $00, $00, $00, $E0, $14, $E0, $00
	.byte $80

; -----------------------------------------------------------------------------

rom_DEB4:
	.byte $10, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $80

; -----------------------------------------------------------------------------

rom_DECD:
	.byte $00, $00, $00, $00, $06, $00, $06, $00
	.byte $06, $00, $06, $00, $06, $00, $06, $00
	.byte $06, $00, $06, $00, $06, $00, $06, $00
	.byte $04, $00, $04, $00, $04, $00, $04, $00
	.byte $80

; -----------------------------------------------------------------------------

rom_DEEE:
	.byte $00, $00, $00, $00, $06, $FC, $0C, $00
	.byte $0C, $00, $0C, $00, $08, $00, $08, $00
	.byte $08, $00, $06, $00, $06, $00, $06, $00
	.byte $04, $00, $04, $00, $04, $00, $04, $04
	.byte $80

; -----------------------------------------------------------------------------
