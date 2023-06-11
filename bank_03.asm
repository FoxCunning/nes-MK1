.segment "BANK_03"
; $A000-$BFFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"


; Temporary definitions
; TODO Remove once other banks have been disassembled
rom_8000 = $8000	; TEMP
rom_85BE = $85BE    ; TEMP
rom_867E = $867E    ; TEMP


; -----------------------------------------------------------------------------
.export sub_rom_03_A000

sub_rom_03_A000:
	jsr sub_rom_A9FD
	and #$01
	jsr sub_rom_A00C

	lda zp_7C
	eor #$01
; ----------------
sub_rom_A00C:
	tax
	stx zp_7C
	lda zp_8E,X
	cmp #$0B
	bcc @A02A

	cmp #$26
	bcs @A02A

	txa
	eor #$01
	tay
	lda zp_86,X
	cmp zp_86,Y
	beq @A030

	bcs @A02B

	lda zp_8A,X
	beq @A030

	@A02A:
	rts
; ----------------
	@A02B:
	lda zp_8A,X
	bne @A030

	rts
; ----------------
	@A030:
	lda zp_A3,X
	asl A
	tay
	lda rom_A10C+0,Y
	sta zp_3D
	lda rom_A10C+1,Y
	sta zp_3E
	lda zp_8E,X
	sec
	sbc #$0B
	asl A
	tay
	lda (zp_3D),Y
	sta zp_3B
	iny
	lda (zp_3D),Y
	sta zp_3C
	ldy #$00
	lda (zp_3B),Y
	sta zp_12
	cmp #$FF
	beq @A02A

	bpl @A068

	and #$0F
	sta zp_12
	txa
	eor #$01
	tax
	lda zp_2A,X
	and #$04
	bne @A02A

	@A068:
	ldx zp_7C
	lda zp_90,X
	cmp zp_12
	bcc @A02A

	iny
	cmp (zp_3B),Y
	bcc @A077

	bne @A02A

	@A077:
	iny
	lda zp_9C
	cmp (zp_3B),Y
	bcs @A02A

	iny
	lda zp_8D
	bne @A08A

	cpx #$00
	beq @A08F

	iny
	bne @A08F

	@A08A:
	cpx #$00
	bne @A08F

	iny
	@A08F:
	lda (zp_3B),Y
	cmp zp_9D
	bcc @A0BD

	ldy #$05
	txa
	eor #$01
	tax
	lda zp_8E,X
	cmp #$27
	beq @A0BD

	cmp #$2B
	beq @A0BD

	cmp #$2C
	beq @A0BD

	cmp #$02
	bne @A0B1

	lda #$2B
	bne @A0B7

	@A0B1:
	cmp #$05
	bne @A0BE

	lda #$2C
	@A0B7:
	sta zp_8E,X
	lda #$00
	sta zp_90,X
	@A0BD:
	rts
; ----------------
	@A0BE:
	lda (zp_3B),Y
	cmp #$09
	beq @A0C8

	cmp #$0A
	bne @A0DA

	@A0C8:
	lda zp_88,X
	cmp zp_4A
	beq @A0D2

	@A0CE:
	lda #$2E
	bne @A0DA

	@A0D2:
	lda zp_E5,X
	cmp #$03
	bcs @A0CE

	lda (zp_3B),Y
	@A0DA:
	cmp zp_8E,X
	beq @A0BD

	sta zp_8E,X
	lda #$00
	sta zp_90,X
	iny
	lda (zp_3B),Y
	ldx zp_7C
	sta zp_EF,X
	inc zp_EF,X
	pha
	iny
	lda (zp_3B),Y
	sta zp_EB,X
	iny
	lda (zp_3B),Y
	sta zp_ED,X
	pla
	tay
	txa
	eor #$01
	tax
	lda rom_A108,Y
	sta zp_A7,X
	lda #$01
	sta zp_F1
	rts

; -----------------------------------------------------------------------------

rom_A108:
	.byte $04, $08, $0C, $10

; -----------------------------------------------------------------------------

; Pointers table
rom_A10C:
	.word rom_A124, rom_A15A, rom_A190, rom_A1C6
	.word rom_A1FC, rom_A232, rom_A268, rom_A29E
	.word rom_A2D4, rom_A30A, rom_A340, rom_A190

; -----------------------------------------------------------------------------

; Pointers table
rom_A124:
	.word rom_A376, rom_A37F, rom_AA1A, rom_A38F
	.word rom_A398, rom_A3A1, rom_A3A8, rom_A3B1
	.word rom_A3BA, rom_A526, rom_A40A, rom_A3CF
	.word rom_AA3D, rom_A48E, rom_A3E6, rom_A3EF
	.word rom_A3F8, rom_A401, rom_A40A, rom_A5DD
	.word rom_A418, rom_A421, rom_A3F8, rom_A401
	.word rom_A43C, rom_A443, rom_A44A

; -----------------------------------------------------------------------------

; Pointers table
rom_A15A:
	.word rom_A55B, rom_A37F, rom_AA1A, rom_A38F
	.word rom_A398, rom_A554, rom_A3A8, rom_A3B1
	.word rom_A554, rom_A526, rom_A3C8, rom_A3CF
	.word rom_AA21, rom_A48E, rom_A3E6, rom_A3EF
	.word rom_A3F8, rom_A401, rom_A40A, rom_A5DD
	.word rom_A576, rom_A57F, rom_A588, rom_A591
	.word rom_A43C, rom_A443, rom_A44A

; -----------------------------------------------------------------------------

; Pointers table
rom_A190:
	.word rom_A42A, rom_A465, rom_A49E, rom_A38F
	.word rom_A398, rom_A453, rom_A3A8, rom_A3B1
	.word rom_A3BA, rom_A5D6, rom_A3C8, rom_A3CF
	.word rom_A495, rom_A48E, rom_A3E6, rom_A3EF
	.word rom_A3F8, rom_A401, rom_A40A, rom_A5DD
	.word rom_A418, rom_A421, rom_A3F8, rom_A401
	.word rom_A43C, rom_A443, rom_A44A

; -----------------------------------------------------------------------------

; Pointers table
rom_A1C6:
	.word rom_A59A, rom_A37F, rom_A5B3, rom_A38F
	.word rom_A398, rom_A59A, rom_A3A8, rom_A3B1
	.word rom_A3BA, rom_A526, rom_A3C8, rom_A3CF
	.word rom_A5BA, rom_A48E, rom_A3E6, rom_A3EF
	.word rom_A3F8, rom_A401, rom_A40A, rom_A5DD
	.word rom_A3F8, rom_A401, rom_A3F8, rom_A401
	.word rom_A43C, rom_A443, rom_A44A

; -----------------------------------------------------------------------------

; Pointers table
rom_A1FC:
	.word rom_A376, rom_A465, rom_A47E, rom_A38F
	.word rom_A398, rom_A453, rom_A3A8, rom_A3B1
	.word rom_A3BA, rom_A3C1, rom_A3C8, rom_A3CF
	.word rom_A487, rom_A48E, rom_A3E6, rom_A3EF
	.word rom_A3F8, rom_A401, rom_A40A, rom_A5DD
	.word rom_A418, rom_A421, rom_A3F8, rom_A401
	.word rom_A43C, rom_A443, rom_A44A

; -----------------------------------------------------------------------------

; Pointers table
rom_A232:
	.word rom_A376, rom_A37F, rom_A54D, rom_A38F
	.word rom_A398, rom_A3A1, rom_A3A8, rom_A3B1
	.word rom_A3BA, rom_A526, rom_A3C8, rom_A3CF
	.word rom_AA36, rom_A48E, rom_A3E6, rom_A3EF
	.word rom_A3F8, rom_A401, rom_A40A, rom_A5DD
	.word rom_A418, rom_A421, rom_A3F8, rom_A401
	.word rom_A43C, rom_A443, rom_A44A

; -----------------------------------------------------------------------------

; Pointers table
rom_A268:
	.word rom_A5A1, rom_A5A1, rom_AA2F, rom_A38F
	.word rom_A398, rom_A3A1, rom_A3A8, rom_A3B1
	.word rom_A3BA, rom_A526, rom_A3C8, rom_A3CF
	.word rom_A495, rom_A48E, rom_A3E6, rom_A3EF
	.word rom_A3F8, rom_A401, rom_A40A, rom_A5DD
	.word rom_A418, rom_A421, rom_A3F8, rom_A401
	.word rom_A43C, rom_A443, rom_A44A

; -----------------------------------------------------------------------------

; Pointers table
rom_A29E:
	.word rom_A504, rom_A465, rom_A38F, rom_A398
	.word rom_A4B7, rom_A453, rom_A3A8, rom_A3B1
	.word rom_A3BA, rom_A4FD, rom_A3C8, rom_A3CF
	.word rom_A3EF, rom_A48E, rom_A3E6, rom_A3EF
	.word rom_A3F8, rom_A401, rom_A40A, rom_A5DD
	.word rom_A418, rom_A421, rom_A4C0, rom_A4C9
	.word rom_A43C, rom_A443, rom_A44A

; -----------------------------------------------------------------------------

; Pointers table
rom_A2D4:
	.word rom_A376, rom_A37F, rom_A5C1, rom_A38F
	.word rom_A398, rom_A59A, rom_A3A8, rom_A3B1
	.word rom_A3BA, rom_A526, rom_A3C8, rom_A3CF
	.word rom_A5C8, rom_A48E, rom_A3E6, rom_A3EF
	.word rom_A3F8, rom_A401, rom_A40A, rom_A5DD
	.word rom_A418, rom_A421, rom_A3F8, rom_A401
	.word rom_A43C, rom_A443, rom_A44A

; -----------------------------------------------------------------------------

; Pointers table
rom_A30A:
	.word rom_A5AA, rom_A5AA, rom_A386, rom_A38F
	.word rom_A398, rom_A3A1, rom_A3A8, rom_A3B1
	.word rom_A3BA, rom_A5AA, rom_A3C8, rom_A3CF
	.word rom_A546, rom_A48E, rom_A3E6, rom_A3EF
	.word rom_A3F8, rom_A401, rom_A40A, rom_A5DD
	.word rom_A418, rom_A421, rom_A3F8, rom_A401
	.word rom_A43C, rom_A443, rom_A44A

; -----------------------------------------------------------------------------

; Pointers table
rom_A340:
	.word rom_A4D2, rom_A4DB, rom_A4AE, rom_A433
	.word rom_A4B7, rom_A3A1, rom_A3A8, rom_A3B1
	.word rom_A3BA, rom_A3C1, rom_A3C8, rom_A3CF
	.word rom_A495, rom_A4F6, rom_A3E6, rom_A3EF
	.word rom_A4C0, rom_A4C9, rom_A40A, rom_A5DD
	.word rom_A418, rom_A421, rom_A4C0, rom_A4C9
	.word rom_A43C, rom_A443, rom_A4ED

; -----------------------------------------------------------------------------

rom_A376:
	.byte $02, $03, $29, $30, $30, $09, $00, $28
	.byte $40

; -----------------------------------------------------------------------------

rom_A37F:
	.byte $02, $03, $24, $30, $30, $0A, $01

; -----------------------------------------------------------------------------

rom_A386:
	.byte $02, $04, $38, $30, $30, $09, $02, $30
	.byte $30

; -----------------------------------------------------------------------------

rom_A38F:
	.byte $05, $07, $28, $30, $30, $09, $01, $10
	.byte $30

; -----------------------------------------------------------------------------

rom_A398:
	.byte $09, $0B, $28, $30, $30, $09, $01, $10
	.byte $30

; -----------------------------------------------------------------------------

rom_A3A1:
	.byte $02, $03, $30, $30, $30, $0A, $00

; -----------------------------------------------------------------------------

rom_A3A8:
	.byte $05, $07, $28, $30, $30, $09, $00, $18
	.byte $30

; -----------------------------------------------------------------------------

rom_A3B1:
	.byte $09, $0A, $28, $30, $30, $09, $00, $18
	.byte $30

; -----------------------------------------------------------------------------

rom_A3BA:
	.byte $02, $03, $28, $30, $20, $0A, $01

; -----------------------------------------------------------------------------

rom_A3C1:
	.byte $00, $01, $28, $00, $00, $2E, $00

; -----------------------------------------------------------------------------

rom_A3C8:
	.byte $04, $0B, $10, $30, $00, $0A, $02

; -----------------------------------------------------------------------------

rom_A3CF:
	.byte $08, $0B, $10, $30, $00, $0A, $02, $83
	.byte $09, $40, $21, $60, $09, $02, $30, $30
	.byte $00, $03, $24, $00, $00, $2D, $02

; -----------------------------------------------------------------------------

rom_A3E6:
	.byte $08, $0B, $28, $30, $30, $09, $01, $18
	.byte $30

; -----------------------------------------------------------------------------

rom_A3EF:
	.byte $0C, $0E, $28, $30, $30, $09, $01, $18
	.byte $30

; -----------------------------------------------------------------------------

rom_A3F8:
	.byte $06, $08, $30, $30, $30, $09, $00, $30
	.byte $40

; -----------------------------------------------------------------------------

rom_A401:
	.byte $0A, $0D, $30, $30, $30, $09, $00, $30
	.byte $40

; -----------------------------------------------------------------------------

rom_A40A:
	.byte $07, $0E, $10, $30, $00, $0A, $02, $0B
	.byte $0F, $10, $30, $00, $0A, $02

; -----------------------------------------------------------------------------

rom_A418:
	.byte $05, $07, $28, $30, $30, $09, $01, $18
	.byte $30

; -----------------------------------------------------------------------------

rom_A421:
	.byte $0B, $0F, $28, $30, $30, $09, $01, $18
	.byte $30

; -----------------------------------------------------------------------------

rom_A42A:
	.byte $02, $03, $26, $30, $30, $09, $00, $30
	.byte $40

; -----------------------------------------------------------------------------

rom_A433:
	.byte $05, $07, $35, $38, $28, $09, $00, $30
	.byte $20

; -----------------------------------------------------------------------------

rom_A43C:
	.byte $07, $0E, $10, $30, $00, $0A, $02

; -----------------------------------------------------------------------------

rom_A443:
	.byte $0B, $0F, $10, $30, $00, $0A, $02

; -----------------------------------------------------------------------------

rom_A44A:
	.byte $00, $03, $1E, $30, $30, $09, $01, $20
	.byte $50

; -----------------------------------------------------------------------------

rom_A453:
	.byte $02, $03, $30, $30, $30, $09, $00, $20
	.byte $40, $02, $03, $30, $30, $30, $09, $01
	.byte $20, $44

; -----------------------------------------------------------------------------

rom_A465:
	.byte $02, $03, $24, $30, $30, $09, $01, $18
	.byte $40, $00, $03, $24, $00, $00, $09, $02
	.byte $02, $03, $34, $30, $30, $09, $00, $30
	.byte $20

; -----------------------------------------------------------------------------

rom_A47E:
	.byte $04, $05, $30, $30, $30, $09, $02, $30
	.byte $30

; -----------------------------------------------------------------------------

rom_A487:
	.byte $02, $0A, $30, $30, $00, $2E, $01, $00

; -----------------------------------------------------------------------------

rom_A48E:
	.byte $03, $1E, $00, $00, $31, $02

; -----------------------------------------------------------------------------

rom_A495:
	.byte $02, $09, $28, $30, $00, $2E, $01, $20
	.byte $40

; -----------------------------------------------------------------------------

rom_A49E:
	.byte $84, $1B, $30, $30, $60, $09, $02, $30
	.byte $30, $00, $03, $1E, $00, $00, $32, $02

; -----------------------------------------------------------------------------

rom_A4AE:
	.byte $02, $11, $39, $00, $00, $09, $02, $28
	.byte $40

; -----------------------------------------------------------------------------

rom_A4B7:
	.byte $08, $0A, $35, $38, $28, $09, $02, $30
	.byte $20

; -----------------------------------------------------------------------------

rom_A4C0:
	.byte $06, $08, $35, $38, $28, $09, $00, $30
	.byte $20

; -----------------------------------------------------------------------------

rom_A4C9:
	.byte $0B, $0E, $35, $38, $28, $09, $00, $30
	.byte $20

; -----------------------------------------------------------------------------

rom_A4D2:
	.byte $02, $03, $35, $30, $30, $09, $00, $28
	.byte $40

; -----------------------------------------------------------------------------

rom_A4DB:
	.byte $02, $03, $35, $30, $30, $09, $01, $28
	.byte $40, $02, $03, $35, $30, $30, $09, $00
	.byte $28, $40

; -----------------------------------------------------------------------------

rom_A4ED:
	.byte $02, $03, $35, $30, $30, $09, $01, $28
	.byte $40

; -----------------------------------------------------------------------------

rom_A4F6:
	.byte $00, $03, $24, $00, $00, $33, $02

; -----------------------------------------------------------------------------

rom_A4FD:
	.byte $02, $05, $28, $00, $00, $0A, $02

; -----------------------------------------------------------------------------

rom_A504:
	.byte $02, $03, $30, $30, $30, $09, $00, $28
	.byte $40, $02, $0B, $36, $30, $00, $09, $02
	.byte $38, $20, $0B, $0F, $10, $30, $00, $0A
	.byte $01, $06, $0A, $36, $30, $00, $09, $02
	.byte $38, $20

; -----------------------------------------------------------------------------

rom_A526:
	.byte $00, $01, $24, $00, $00, $2E, $00, $02
	.byte $03, $40, $30, $30, $09, $00, $28, $40
	.byte $02, $03, $41, $00, $00, $2E, $00, $00
	.byte $30, $28, $30, $30, $2E, $02, $20, $40

; -----------------------------------------------------------------------------

rom_A546:
	.byte $00, $03, $24, $00, $00, $34, $02

; -----------------------------------------------------------------------------

rom_A54D:
	.byte $80, $14, $20, $28, $28, $2E, $02

; -----------------------------------------------------------------------------

rom_A554:
	.byte $02, $03, $30, $10, $10, $0A, $00

; -----------------------------------------------------------------------------

rom_A55B:
	.byte $02, $03, $29, $30, $30, $09, $00, $28
	.byte $40, $05, $07, $30, $30, $30, $09, $00
	.byte $18, $30, $09, $0A, $30, $30, $30, $09
	.byte $00, $18, $30

; -----------------------------------------------------------------------------

rom_A576:
	.byte $05, $07, $30, $30, $30, $09, $01, $18
	.byte $30

; -----------------------------------------------------------------------------

rom_A57F:
	.byte $0B, $0F, $30, $30, $30, $09, $01, $18
	.byte $30

; -----------------------------------------------------------------------------

rom_A588:
	.byte $05, $07, $30, $18, $30, $09, $00, $30
	.byte $40

; -----------------------------------------------------------------------------

rom_A591:
	.byte $0B, $0F, $30, $18, $30, $09, $00, $30
	.byte $40

; -----------------------------------------------------------------------------

rom_A59A:
	.byte $02, $03, $30, $30, $30, $0A, $00

; -----------------------------------------------------------------------------

rom_A5A1:
	.byte $02, $03, $30, $30, $30, $09, $00, $28
	.byte $40

; -----------------------------------------------------------------------------

rom_A5AA:
	.byte $02, $03, $40, $30, $30, $09, $00, $28
	.byte $40

; -----------------------------------------------------------------------------

rom_A5B3:
	.byte $83, $05, $30, $30, $30, $0A, $01

; -----------------------------------------------------------------------------

rom_A5BA:
	.byte $03, $0A, $28, $30, $00, $0A, $02

; -----------------------------------------------------------------------------

rom_A5C1:
	.byte $0D, $11, $3A, $30, $30, $0A, $00

; -----------------------------------------------------------------------------

rom_A5C8:
	.byte $08, $0B, $3A, $30, $30, $0A, $00, $0D
	.byte $11, $3A, $30, $30, $0A, $00

; -----------------------------------------------------------------------------

rom_A5D6:
	.byte $00, $01, $23, $00, $00, $2E, $00

; -----------------------------------------------------------------------------

rom_A5DD:
	.byte $7F, $7F, $00, $00, $00, $2E, $00

; -----------------------------------------------------------------------------
.export sub_rom_03_A5E4

sub_rom_03_A5E4:
	jsr sub_rom_A9FD
	and #$01
	jsr sub_rom_A5F0
	lda zp_7C
	eor #$01
; ----------------
sub_rom_A5F0:
    tay
	sty zp_7C
	lda zp_F2,Y
	bpl @A60B

	lda zp_8E,Y
	beq @A601

	cmp #$03
	bne @A60B

	@A601:
	lda #$58
	cmp zp_A5
	beq @A60B

	cmp zp_A6
	bne @A60C

	@A60B:
	rts
; ----------------
	@A60C:
	tya
	eor #$01
	tax
	stx zp_7B
	lda zp_9C
	cmp #$14
	bcs @A61C

	jsr sub_rom_A67A
	rts
; ----------------
	@A61C:
	cmp #$28
	bcs @A624

	jsr sub_rom_A6BC
	rts
; ----------------
	@A624:
	cmp #$80
	bcs @A62C

	jsr sub_rom_A6FE
	rts
; ----------------
	@A62C:
	jsr sub_rom_A9EB
	jsr sub_rom_A9FD
	and #$1F
	tax
	lda #$03
	jsr sub_rom_A773
	rts

; -----------------------------------------------------------------------------

sub_rom_A63B:
	ldx zp_7B
	lda zp_5E
	bne @A659

	jsr sub_rom_A9EB
	ldx zp_7B
	lda zp_9E
	cmp #$01
	bcc @A659

	lda ram_040D,X
	beq @A659

	jsr sub_rom_A9FD
	and #$07
	bne @A660

	rts
; ----------------
	@A659:
	jsr sub_rom_A9FD
	and #$07
	bne @A679

	@A660:
	lda zp_A3,X
	asl A
	tay
	lda (zp_3B),Y
	sta zp_3D
	iny
	lda (zp_3B),Y
	sta zp_3E
	lda zp_8E,X
	tay
	lda (zp_3D),Y
	bmi @A679

	jsr sub_rom_A773
	pla
	pla
	@A679:
	rts

; -----------------------------------------------------------------------------

sub_rom_A67A:
	lda zp_A3,Y
	asl A
	tax
	lda rom_A7BF+0,X
	sta zp_3B
	lda rom_A7BF+1,X
	sta zp_3C
	jsr sub_rom_A63B
	jsr sub_rom_A9EB
	jsr sub_rom_A9FD
	and #$1F
	tax
	lda rom_A69C,X
	jsr sub_rom_A773
	rts

; -----------------------------------------------------------------------------

rom_A69C:
	.byte $25, $18, $0C, $18, $25, $18, $0C, $18
	.byte $25, $18, $0C, $18, $25, $18, $0C, $18
	.byte $25, $18, $0C, $18, $25, $18, $0C, $18
	.byte $25, $18, $0C, $18, $25, $18, $0C, $18

; -----------------------------------------------------------------------------

sub_rom_A6BC:
	lda zp_A3,Y
	asl A
	tax
	lda rom_A7D7+0,X
	sta zp_3B
	lda rom_A7D7+1,X
	sta zp_3C
	jsr sub_rom_A63B
	jsr sub_rom_A9EB
	jsr sub_rom_A9FD
	and #$1F
	tax
	lda rom_A6DE,X
	jsr sub_rom_A773
	rts

; -----------------------------------------------------------------------------

rom_A6DE:
	.byte $0B, $13, $10, $17, $13, $0D, $14, $0B
	.byte $0B, $0D, $10, $17, $13, $14, $14, $10
	.byte $0B, $13, $10, $17, $13, $0D, $14, $0B
	.byte $0B, $0D, $10, $17, $13, $14, $14, $10

; -----------------------------------------------------------------------------

sub_rom_A6FE:
	lda zp_A3,Y
	asl A
	tax
	lda rom_A7EF+0,X
	sta zp_3B
	lda rom_A7EF+1,X
	sta zp_3C
	jsr sub_rom_A63B
	jsr sub_rom_A9EB
	jsr sub_rom_A9FD
	and #$1F
	tax
	lda rom_A733,X
	bpl @A723

	ldx zp_A3,Y
	lda rom_A727,X
	@A723:
	jsr sub_rom_A773
	rts

; -----------------------------------------------------------------------------

rom_A727:
	.byte $0D, $17, $1E, $1B, $1E, $17, $0D, $0D
	.byte $1E, $1B, $1E, $1E

; -----------------------------------------------------------------------------

rom_A733:
	.byte $03, $80, $03, $03, $03, $03, $03, $03
	.byte $03, $03, $03, $03, $03, $03, $03, $03
	.byte $03, $03, $03, $03, $1A, $03, $03, $03
	.byte $03, $03, $03, $03, $03, $03, $03, $03
	.byte $03, $1B, $03, $03, $03, $14, $1B, $03
	.byte $03, $19, $14, $03, $1B, $14, $19, $19
	.byte $03, $1B, $03, $03, $03, $14, $1B, $03
	.byte $03, $19, $14, $03, $14, $14, $03, $19

; -----------------------------------------------------------------------------

sub_rom_A773:
	ldy zp_7C
	sta zp_12
	cmp #$03
	beq @A7AB

	cmp #$18
	bne @A7B0

	ldx zp_7B
	lda zp_88,X
	cmp zp_4A
	bne @A7A5

	lda zp_8E,X
	cmp #$09
	beq @A7A5

	cmp #$0A
	beq @A7A5

	cmp #$26
	beq @A7A5

	cmp #$2D
	bcs @A7A5

	lda zp_25
	and #$01
	beq @A7B0

	lda #$1E
	sta zp_12
	bne @A7B0

	@A7A5:
	lda #$04
	sta zp_12
	bne @A7B0

	@A7AB:
	cmp zp_8E,Y
	beq @A7B5
    
	@A7B0:
	lda #$00
	sta zp_90,Y
	@A7B5:
	lda zp_12
	and #$3F
	sta zp_8E,Y
	sty zp_8C
	rts

; -----------------------------------------------------------------------------

rom_A7BF:
	.word rom_A807, rom_A807, rom_A807, rom_A807
	.word rom_A807, rom_A807, rom_A807, rom_A807
	.word rom_A807, rom_A807, rom_A807, rom_A8F9

; -----------------------------------------------------------------------------

rom_A7D7:
	.word rom_A81F, rom_A81F, rom_A81F, rom_A81F
	.word rom_A81F, rom_A81F, rom_A81F, rom_A81F
	.word rom_A81F, rom_A81F, rom_A81F, rom_A911

; -----------------------------------------------------------------------------

rom_A7EF:
	.word rom_A837, rom_A837, rom_A837, rom_A837
	.word rom_A837, rom_A837, rom_A837, rom_A837
	.word rom_A837, rom_A837, rom_A837, rom_A929

; -----------------------------------------------------------------------------

rom_A807:
	.word rom_A84F, rom_A84F, rom_A84F, rom_A84F
	.word rom_A84F, rom_A84F, rom_A84F, rom_A84F
	.word rom_A84F, rom_A84F, rom_A84F, rom_A84F

; -----------------------------------------------------------------------------

rom_A81F:
	.word rom_A884, rom_A884, rom_A884, rom_A884
	.word rom_A884, rom_A884, rom_A884, rom_A884
	.word rom_A884, rom_A884, rom_A884, rom_A884

; -----------------------------------------------------------------------------

rom_A837:
	.word rom_A8B9, rom_A8B9, rom_A8B9, rom_A8B9
	.word rom_A8B9, rom_A8B9, rom_A8B9, rom_A8B9
	.word rom_A8B9, rom_A8B9, rom_A8B9, rom_A8B9

; -----------------------------------------------------------------------------

rom_A84F:
	.byte $80, $13, $18, $18, $14, $14, $0C, $17
	.byte $1E, $1A, $1C, $05, $05, $05, $13, $13
	.byte $05, $0C, $0C, $02, $02, $08, $08, $13
	.byte $80, $17, $17, $17, $17, $08, $08, $0C
	.byte $0C, $0C, $0C, $08, $08, $05, $04, $14
	.byte $17, $80, $80, $1C, $0E, $08, $0E, $08
	.byte $0F, $08, $08, $08, $1E

; -----------------------------------------------------------------------------

rom_A884:
	.byte $80, $80, $03, $80, $80, $80, $1E, $17
	.byte $1E, $1E, $1E, $05, $05, $02, $05, $05
	.byte $05, $0C, $0C, $02, $02, $17, $17, $05
	.byte $08, $17, $17, $17, $17, $80, $1C, $0C
	.byte $0C, $0C, $0C, $80, $80, $05, $04, $14
	.byte $1E, $80, $80, $1C, $1A, $08, $19, $08
	.byte $08, $08, $08, $08, $1E

; -----------------------------------------------------------------------------

rom_A8B9:
	.byte $80, $80, $03, $80, $80, $80, $03, $17
	.byte $03, $1E, $1E, $80, $80, $1E, $80, $80
	.byte $80, $80, $80, $80, $1E, $17, $17, $1E
	.byte $80, $17, $17, $17, $17, $03, $03, $0C
	.byte $0C, $0C, $0C, $03, $03, $80, $04, $03
	.byte $1E, $80, $80, $1C, $1A, $08, $19, $04
	.byte $04, $04, $04, $04, $03, $80, $80, $80
	.byte $80, $80, $80, $80, $80, $80, $80, $80

; -----------------------------------------------------------------------------

rom_A8F9:
	.word rom_A941, rom_A941, rom_A941, rom_A941
	.word rom_A941, rom_A941, rom_A941, rom_A941
	.word rom_A941, rom_A941, rom_A941, rom_A941

; -----------------------------------------------------------------------------

rom_A911:
	.word rom_A976, rom_A976, rom_A976, rom_A976
	.word rom_A976, rom_A976, rom_A976, rom_A976
	.word rom_A976, rom_A976, rom_A976, rom_A976

; -----------------------------------------------------------------------------

rom_A929:
	.word rom_A9AB, rom_A9AB, rom_A9AB, rom_A9AB
	.word rom_A9AB, rom_A9AB, rom_A9AB, rom_A9AB
	.word rom_A9AB, rom_A9AB, rom_A9AB, rom_A9AB

; -----------------------------------------------------------------------------

rom_A941:
	.byte $80, $13, $1E, $18, $14, $14, $0C, $17
	.byte $17, $1A, $1C, $05, $05, $05, $13, $13
	.byte $05, $0C, $0C, $02, $02, $08, $08, $13
	.byte $80, $17, $17, $17, $17, $08, $08, $0C
	.byte $0C, $0C, $0C, $08, $08, $05, $04, $14
	.byte $17, $80, $80, $1C, $0E, $08, $0E, $08
	.byte $0F, $08, $08, $08, $17

; -----------------------------------------------------------------------------

rom_A976:
	.byte $80, $80, $03, $0D, $80, $80, $1C, $80
	.byte $1C, $1C, $1C, $05, $05, $0D, $05, $05
	.byte $05, $0C, $0C, $02, $02, $80, $80, $11
	.byte $08, $80, $80, $80, $80, $80, $05, $0C
	.byte $0C, $0C, $0C, $80, $80, $05, $04, $14
	.byte $0D, $80, $80, $1C, $1A, $08, $19, $08
	.byte $08, $08, $08, $08, $1C

; -----------------------------------------------------------------------------

rom_A9AB:
	.byte $80, $80, $03, $80, $80, $80, $80, $80
	.byte $03, $1A, $1C, $80, $80, $13, $80, $80
	.byte $80, $80, $80, $80, $80, $80, $80, $80
	.byte $80, $80, $80, $80, $80, $80, $1C, $0C
	.byte $0C, $0C, $0C, $80, $80, $80, $04, $03
	.byte $1C, $80, $80, $1C, $1A, $08, $19, $04
	.byte $04, $04, $04, $04, $03, $80, $80, $80
	.byte $80, $80, $80, $80, $80, $80, $80, $80

; -----------------------------------------------------------------------------

sub_rom_A9EB:
	ldx ram_042C
	lda zp_25
	and rom_A9F8,X
	beq @A9F7

	pla
	pla
	@A9F7:
	rts

; -----------------------------------------------------------------------------

rom_A9F8:
	.byte $1F, $0F, $07, $03, $00

; -----------------------------------------------------------------------------

sub_rom_A9FD:
	txa
	adc zp_22
	sta zp_22
	and #$01
	bne @AA0F

	txa
	adc zp_22
	tya
	adc zp_22
	sta zp_22
	rts
; ----------------
	@AA0F:
	adc zp_22
	sta zp_22
	ror A
	ror A
	adc zp_22
	sta zp_22
	rts

; -----------------------------------------------------------------------------

rom_AA1A:
	.byte $02, $05, $30, $20, $00, $0A, $01

; -----------------------------------------------------------------------------

rom_AA21:
	.byte $02, $0A, $38, $30, $00, $0A, $01, $02
	.byte $05, $29, $30, $00, $0A, $01

; -----------------------------------------------------------------------------

rom_AA2F:
	.byte $02, $04, $30, $30, $00, $0A, $01

; -----------------------------------------------------------------------------

rom_AA36:
	.byte $82, $0A, $29, $30, $00, $0A, $01

; -----------------------------------------------------------------------------

rom_AA3D:
	.byte $02, $0A, $38, $30, $00, $0A, $01, $02
	.byte $05, $29, $30, $00, $0A, $02, $02, $05
	.byte $29, $30, $00, $0A, $02, $02, $05, $29
	.byte $30, $00, $0A, $02, $02, $05, $29, $30
	.byte $00, $0A, $02, $02, $05, $29, $30, $00
	.byte $0A, $02, $02, $05, $29, $30, $00, $0A
	.byte $02, $02, $05, $29, $30, $00, $0A, $02
	.byte $02, $05, $29, $30, $00, $0A, $02, $02
	.byte $05, $29, $30, $00, $0A, $02, $02, $05
	.byte $29, $30, $00, $0A, $02, $02, $05, $29
	.byte $30

	.byte $00, $0A, $02, $02, $05, $29, $30, $00
	.byte $0A, $02

; -----------------------------------------------------------------------------
.export sub_rom_03_AA98

sub_rom_03_AA98:
	lda #$0F
	sta ApuStatus_4015
	lda #$00
	sta Sq0Duty_4000
	sta Sq1Duty_4004
	sta TrgLinear_4008
	sta NoiseVolume_400C
	sta DmcFreq_4010
	lda #$7F
	sta Sq0Sweep_4001
	sta Sq1Sweep_4005
	lda #$00
	ldy #$F9
	@AABA:
	sta ram_0700,Y
	dey
	bne @AABA

	lda #$FF
	ldx #$05
	@AAC4:
	dex
	sta ram_075C,X
	sta ram_07D2,X
	bne @AAC4

	ldx #$04
	@AACF:
	dex
	sta ram_0777,X
	sta ram_07ED,X
	bne @AACF

	ldx #$02
	@AADA:
	dex
	sta ram_076D,X
	sta ram_07E3,X
	bne @AADA

	ldx #$08
	@AAE5:
	dex
	sta ram_0701,X
	bne @AAE5
	rts

; -----------------------------------------------------------------------------
.export sub_rom_03_AAEC

sub_rom_03_AAEC:
	tax
	ldy #$FF
	@AAEF:
	cpy #$07
	beq @AAFD

	iny
	lda ram_0701,Y
	bpl @AAEF

	txa
	sta ram_0701,Y
	@AAFD:
	rts

; -----------------------------------------------------------------------------
.export sub_rom_03_AAFE

sub_rom_03_AAFE:
	lda ram_0709
	bne @AB54

	@AB03:
	jsr sub_rom_B116
	jsr sub_rom_AB96
	lda #$00
	sta ram_070A
	sta ram_070B
	sta ram_070C
	@AB14:
	jsr sub_rom_AC4F
	jsr sub_rom_AFB6
	inc ram_070A
	inc ram_070B
	inc ram_070C
	inc ram_070C
	ldx ram_070A
	cpx #$05
	bne @AB14

	lda #$10
	sta ram_070A
	lda #$76
	sta ram_070B
	sta ram_070C
	@AB3A:
	jsr sub_rom_AC4F
	jsr sub_rom_AFB6
	inc ram_070A
	inc ram_070B
	inc ram_070C
	inc ram_070C
	ldx ram_070A
	cpx #$15
	bne @AB3A

	rts
; ----------------
	@AB54:
	tay
	cpy #$F0
	beq @AB5E

	cpy #$F1
	beq @AB8E

	rts
; ----------------
	@AB5E:
	ldx #$00
	ldy #$00
	jsr sub_rom_B267
	lda zp_FE
	and #$F0
	ora #$30
	sta Sq0Duty_4000
	ldx #$01
	ldy #$02
	jsr sub_rom_B267
	lda zp_FE
	and #$F0
	ora #$30
	sta Sq1Duty_4004
	lda #$00
	sta TrgLinear_4008
	lda #$30
	sta NoiseVolume_400C
	lda #$FF
	sta ram_0709
	rts
; ----------------
	@AB8E:
	lda #$00
	sta ram_0709
	jmp @AB03

; -----------------------------------------------------------------------------

sub_rom_AB96:
	lda ram_0700
	beq sub_rom_ABB4

	ldy #$00
	@AB9D:
	lda ram_0701,Y
	bmi @ABAF

	tax
	tya
	pha
	jsr sub_rom_ABB5
	pla
	tay
	lda #$FF
	sta ram_0701,Y
	@ABAF:
	iny
	cpy #$08
	bne @AB9D

sub_rom_ABB4:
	rts

; -----------------------------------------------------------------------------

sub_rom_ABB5:
	txa
	asl A
	tax
	lda rom_867E+0,X
	sta zp_FE
	lda rom_867E+1,X
	sta zp_FF
	ldy #$00
	@ABC4:
	lda (zp_FE),Y
	sta ram_070A
	tax
	cpx #$FF
	beq sub_rom_ABB4	; sub_rom_AB53 (rts)

	lda ram_070A
	bmi @ABDD

	sta ram_070B
	asl A
	sta ram_070C
	jmp @ABEF

	@ABDD:
	and #$7F
	clc
	adc #$76
	sta ram_070B
	txa
	and #$7F
	asl A
	clc
	adc #$76
	sta ram_070C
	@ABEF:
	ldx ram_070C
	iny
	lda (zp_FE),Y
	sta ram_0729,X
	iny
	lda (zp_FE),Y
	sta ram_072A,X
	iny
	tya
	pha
	ldy #$00
	lda ram_070A
	bpl @AC0A

	ldy #$76
	@AC0A:
	lda ram_070A
	and #$0F
	tay
	lda #$00
	sta ram_0739,X
	sta ram_073A,X
	ldx ram_070B
	lda #$00
	sta ram_0757,X
	lda #$FF
	sta ram_075C,X
	cpy #$04
	bpl @AC4A

	lda #$00
	sta ram_0773,X
	lda #$FF
	sta ram_0777,X
	cpy #$03
	bpl @AC4A

	lda #$00
	sta ram_070D,X
	cpy #$02
	bpl @AC4A

	lda #$00
	sta ram_076B,X
	lda #$FF
	sta ram_076D,X
	@AC4A:
	pla
	tay
	jmp @ABC4

; -----------------------------------------------------------------------------

sub_rom_AC4F:
	ldx ram_070C
	lda ram_0729,X
	ora ram_072A,X
	beq @AC8D

	lda ram_0739,X
	bne @AC8A
	lda ram_073A,X
	bne @AC73

	jsr sub_rom_AE11
	ldx ram_070C
	ldy ram_070B
	lda ram_0734,Y
	sta ram_073A,X
	@AC73:
	dec ram_073A,X
	ldy ram_070A
	cpy #$05
	bmi @AC82

	ldy #$76
	jmp @AC84
	@AC82:
	ldy #$00
	@AC84:
	lda ram_0733,Y
	sta ram_0739,X
	@AC8A:
	dec ram_0739,X
	@AC8D:
	rts

; -----------------------------------------------------------------------------

sub_rom_AC8E:
	and #$7F
	beq @AC98

	ldx ram_070B
	sta ram_0734,X
	@AC98:
	jsr sub_rom_B2B1
	jmp sub_rom_AE11

; -----------------------------------------------------------------------------

sub_rom_AC9E:
	jsr sub_rom_B2B1
	rts

; -----------------------------------------------------------------------------

sub_rom_ACA2:
	bne @ACAB
	jsr sub_rom_B2B1
	jmp sub_rom_AE9B

    ; Unreachable ?
	rts
; ----------------
	@ACAB:
	pha
	lda ram_070A
	and #$0F
	tax
	pla
	cpx #$03
	beq @ACD6

	cpx #$04
	bne @ACBB

	@ACBB:
	ldx ram_070B
	clc
	adc ram_070D,X
	asl A
	tay
	ldx ram_070C
	lda rom_85BE+0,Y
	sta ram_0743,X
	lda rom_85BE+1,Y
	sta ram_0744,X
	jmp @ACE8

	@ACD6:
	tax
	and #$10
	beq @ACE1

	txa
	and #$0F
	ora #$80
	tax
	@ACE1:
	txa
	ldx ram_070C
	sta ram_0743,X
	@ACE8:
	jsr sub_rom_AEF6
	jsr sub_rom_B2B1
	rts

; -----------------------------------------------------------------------------

sub_rom_ACEF:
	and #$0F
	asl A
	tay
	jsr sub_rom_B2B1
	tya
	tax
	lda rom_AD05+0,X
	sta zp_FE
	lda rom_AD05+1,X
	sta zp_FF
	jmp (zp_00FE)

; -----------------------------------------------------------------------------

rom_AD05:
	.word sub_rom_AD25, sub_rom_AD3C, sub_rom_AD56, sub_rom_AD82
	.word sub_rom_ADAA, sub_rom_ADC7, sub_rom_ADEA, sub_rom_AE11
	.word sub_rom_AE32, sub_rom_AE4B, sub_rom_AE64, sub_rom_AEB8
	.word sub_rom_AC9E, sub_rom_AC8E, sub_rom_AE11, sub_rom_AE7D

; -----------------------------------------------------------------------------

sub_rom_AD25:
	ldx ram_070C
	clc
	lda ram_0729,X
	adc #$02
	sta ram_071F,X
	lda ram_072A,X
	adc #$00
	sta ram_0720,X
	jmp sub_rom_ADAD

; -----------------------------------------------------------------------------

sub_rom_AD3C:
	ldx ram_070C
	lda ram_071F,X
	sta ram_0729,X
	lda ram_0720,X
	sta ram_072A,X
	lda #$00
	sta ram_071F,X
	sta ram_0720,X
	jmp sub_rom_AE11

; -----------------------------------------------------------------------------

sub_rom_AD56:
	ldx ram_070C
	lda ram_0729,X
	sta zp_FE
	lda ram_072A,X
	sta zp_FF
	ldx ram_070B
	ldy #$00
	lda (zp_FE),Y
	sta ram_0710,X
	jsr sub_rom_B2B1
	ldx ram_070C
	lda ram_0729,X
	sta ram_0715,X
	lda ram_072A,X
	sta ram_0716,X
	jmp sub_rom_AE11

; -----------------------------------------------------------------------------

sub_rom_AD82:
	ldx ram_070B
	dec ram_0710,X
	beq @AD9C

	ldx ram_070C
	lda ram_0715,X
	sta ram_0729,X
	lda ram_0716,X
	sta ram_072A,X
	jmp sub_rom_AE11
	@AD9C:
	ldx ram_070C
	lda #$00
	sta ram_0715,X
	sta ram_0716,X
	jmp sub_rom_AE11

; -----------------------------------------------------------------------------

sub_rom_ADAA:
	ldx ram_070C
; ----------------
sub_rom_ADAD:
	lda ram_0729,X
	sta zp_FE
	lda ram_072A,X
	sta zp_FF
	ldy #$00
	lda (zp_FE),Y
	sta ram_0729,X
	iny
	lda (zp_FE),Y
	sta ram_072A,X
	jmp sub_rom_AE11

; -----------------------------------------------------------------------------

sub_rom_ADC7:
	ldx ram_070C
	lda ram_0729,X
	sta zp_FE
	lda ram_072A,X
	sta zp_FF
	ldy #$00
	lda (zp_FE),Y
	ldx ram_070A
	cpx #$05
	bmi @ADE1
	
	ldy #$76
	@ADE1:
	sta ram_0733,Y
	jsr sub_rom_B2B1
	jmp sub_rom_AE11

; -----------------------------------------------------------------------------

sub_rom_ADEA:
	lda ram_070A
	and #$0F
	tax
	cpx #$03
	bpl @AE0B

	ldx ram_070C
	lda ram_0729,X
	sta zp_FE
	lda ram_072A,X
	sta zp_FF
	ldy #$00
	lda (zp_FE),Y
	ldx ram_070B
	sta ram_070D,X
	@AE0B:
	jsr sub_rom_B2B1
	jmp sub_rom_AE11

; -----------------------------------------------------------------------------

sub_rom_AE11:
	ldx ram_070C
	lda ram_0729,X
	sta zp_FE
	lda ram_072A,X
	sta zp_FF
	ldy #$00
	lda (zp_FE),Y
	bmi @AE27

	jmp sub_rom_ACA2
	@AE27:
	tax
	cpx #$F0
	bpl @AE2F

	jmp sub_rom_AC8E
	@AE2F:
	jmp sub_rom_ACEF

; -----------------------------------------------------------------------------

sub_rom_AE32:
	lda ram_070A
	and #$0F
	tax
	cpx #$04
	bmi @AE42

	jsr sub_rom_B2B1
	jmp sub_rom_AE11
	@AE42:
	jsr sub_rom_AF9E
	sta ram_0757,X
	jmp sub_rom_AE11

; -----------------------------------------------------------------------------

sub_rom_AE4B:
	lda ram_070A
	and #$0F
	tax
	cpx #$02
	bmi @AE5B

	jsr sub_rom_B2B1
	jmp sub_rom_AE11

	@AE5B:
	jsr sub_rom_AF9E
	sta ram_076B,X
	jmp sub_rom_AE11

; -----------------------------------------------------------------------------

sub_rom_AE64:
	lda ram_070A
	and #$0F
	tax
	cpx #$04
	bmi @AE74

	jsr sub_rom_B2B1
	jmp sub_rom_AE11
	@AE74:
	jsr sub_rom_AF9E
	sta ram_0773,X
	jmp sub_rom_AE11

; -----------------------------------------------------------------------------

sub_rom_AE7D:
	ldx ram_070C
	lda #$00
	sta ram_0729,X
	sta ram_072A,X
	lda ram_070A
	and #$0F
	asl A
	tax
	clc
	adc #$76
	tay
	lda #$FF
	sta ram_074E,X
	sta ram_074E,Y
; ----------------
sub_rom_AE9B:
	ldy ram_070B
	lda ram_070A
	and #$0F
	tax
	lda #$FF
	cpx #$04
	bpl @AEB7

	sta ram_075C,Y
	sta ram_0777,Y
	cpx #$02
	bpl @AEB7

	sta ram_076D,Y
	@AEB7:
	rts

; -----------------------------------------------------------------------------

sub_rom_AEB8:
	ldx ram_070C
	lda ram_0729,X
	sta zp_FE
	lda ram_072A,X
	sta zp_FF
	jsr sub_rom_B2B1
	ldx ram_070B
	lda ram_0710,X
	bne @AED7

	ldy #$00
	lda (zp_FE),Y
	sta ram_0710,X
	@AED7:
	dec ram_0710,X
	bne @AEF3

	ldx ram_070C
	lda ram_0729,X
	clc
	adc #$02
	sta ram_0729,X
	lda ram_072A,X
	adc #$00
	sta ram_072A,X
	jmp sub_rom_AE11
	@AEF3:
	jmp sub_rom_ADAA

; -----------------------------------------------------------------------------

sub_rom_AEF6:
	ldx ram_070C
	lda ram_074E,X
	ora #$80
	sta ram_074E,X
	jsr sub_rom_AF0B
	jsr sub_rom_AF3C
	jsr sub_rom_AF6D
	rts

; -----------------------------------------------------------------------------

sub_rom_AF0B:
	lda ram_070A
	and #$0F
	tax
	cpx #$04
	bmi @AF16

	rts
; ----------------
	@AF16:
	ldx ram_070B
	ldy ram_070C
	lda ram_0757,X
	asl A
	tax
	lda rom_8000+0,X
	sta ram_0761,Y
	sta zp_FE
	lda rom_8000+1,X
	sta ram_0762,Y
	sta zp_FF
	ldx ram_070B
	ldy #$00
	lda (zp_FE),Y
	sta ram_075C,X
	rts

; -----------------------------------------------------------------------------

sub_rom_AF3C:
	lda ram_070A
	and #$0F
	tax
	cpx #$02
	bmi @AF47

	rts
; ----------------
	@AF47:
	ldx ram_070B
	ldy ram_070C
	lda ram_076B,X
	asl A
	tax
	lda rom_8000+0,X
	sta ram_076F,Y
	sta zp_FE
	lda rom_8000+1,X
	sta ram_0770,Y
	sta zp_FF
	ldx ram_070B
	ldy #$00
	lda (zp_FE),Y
	sta ram_076D,X
	rts

; -----------------------------------------------------------------------------

sub_rom_AF6D:
	lda ram_070A
	and #$0F
	tax
	cpx #$04
	bmi @AF78

	rts
; ----------------
	@AF78:
	ldx ram_070B
	ldy ram_070C
	lda ram_0773,X
	asl A
	tax
	lda rom_8000+0,X
	sta ram_077B,Y
	sta zp_FE
	lda rom_8000+1,X
	sta ram_077C,Y
	sta zp_FF
	ldx ram_070B
	ldy #$00
	lda (zp_FE),Y
	sta ram_0777,X
	rts

; -----------------------------------------------------------------------------

sub_rom_AF9E:
	ldx ram_070C
	lda ram_0729,X
	sta zp_FE
	lda ram_072A,X
	sta zp_FF
	jsr sub_rom_B2B1
	ldy #$00
	lda (zp_FE),Y
	ldx ram_070B
	rts

; -----------------------------------------------------------------------------

sub_rom_AFB6:
	jsr sub_rom_AFC0
	jsr sub_rom_B033
	jsr sub_rom_B0A6
	rts

; -----------------------------------------------------------------------------

sub_rom_AFC0:
	lda ram_070A
	and #$0F
	tax
	cpx #$04
	bpl @B032

	@AFCA:
	ldx ram_070B
	lda ram_075C,X
	tay
	cpy #$FF
	beq @B032

	ldx ram_070B
	lda ram_075C,X
	bne @B02F

	ldx ram_070C
	lda #$02
	clc
	adc ram_0761,X
	sta ram_0761,X
	sta zp_FE
	lda #$00
	adc ram_0762,X
	sta ram_0762,X
	sta zp_FF
	ldx ram_070B
	ldy #$00
	lda (zp_FE),Y
	sta ram_075C,X
	tay
	cpy #$FF
	bne @AFCA

	ldx ram_070C
	ldy #$01
	lda (zp_FE),Y
	and #$FE
	bpl @B022

	clc
	adc ram_0761,X
	sta ram_0761,X
	sta zp_FE
	bcs @B01D

	dec ram_0762,X
	@B01D:
	lda ram_0762,X
	sta zp_FF
	@B022:
	ldx ram_070B
	ldy #$00
	lda (zp_FE),Y
	sta ram_075C,X
	jmp @AFCA

	@B02F:
	dec ram_075C,X
	@B032:
	rts

; -----------------------------------------------------------------------------

sub_rom_B033:
	lda ram_070A
	and #$0F
	tax
	cpx #$02
	bpl @B0A5

	@B03D:
	ldx ram_070B
	lda ram_076D,X
	tay
	cpy #$FF
	beq @B0A5

	ldx ram_070B
	lda ram_076D,X
	bne @B0A2

	ldx ram_070C
	lda #$02
	clc
	adc ram_076F,X
	sta ram_076F,X
	sta zp_FE
	lda #$00
	adc ram_0770,X
	sta ram_0770,X
	sta zp_FF
	ldx ram_070B
	ldy #$00
	lda (zp_FE),Y
	sta ram_076D,X
	tay
	cpy #$FF
	bne @B03D

	ldx ram_070C
	ldy #$01
	lda (zp_FE),Y
	and #$FE
	bpl @B095

	clc
	adc ram_076F,X
	sta ram_076F,X
	sta zp_FE
	bcs @B090

	dec ram_0770,X
	@B090:
	lda ram_0770,X
	sta zp_FF
	@B095:
	ldx ram_070B
	ldy #$00
	lda (zp_FE),Y
	sta ram_076D,X
	jmp @B03D

	@B0A2:
	dec ram_076D,X
	@B0A5:
	rts

; -----------------------------------------------------------------------------

sub_rom_B0A6:
	lda ram_070A
	and #$0F
	tax
	cpx #$04
	bpl @B115

	@B0B0:
	ldx ram_070B
	lda ram_0777,X
	tay
	cpy #$FF
	beq @B115

	lda ram_0777,X
	bne @B112

	ldx ram_070C
	lda #$02
	clc
	adc ram_077B,X
	sta ram_077B,X
	sta zp_FE
	lda #$00
	adc ram_077C,X
	sta ram_077C,X
	sta zp_FF
	ldx ram_070B
	ldy #$00
	lda (zp_FE),Y
	sta ram_0777,X
	tay
	cpy #$FF
	bne @B0B0

	ldx ram_070C
	ldy #$01
	lda (zp_FE),Y
	and #$FE
	bpl @B105
	clc
	adc ram_077B,X
	sta ram_077B,X
	sta zp_FE
	bcs @B100

	dec ram_077C,X
	@B100:
	lda ram_077C,X
	sta zp_FF
	@B105:
	ldx ram_070B
	ldy #$00
	lda (zp_FE),Y
	sta ram_0777,X
	jmp @B0B0

	@B112:
	dec ram_0777,X
	@B115:
	rts

; -----------------------------------------------------------------------------

sub_rom_B116:
	jsr sub_rom_B123
	jsr sub_rom_B175
	jsr sub_rom_B1C7
	jsr sub_rom_B216
	rts

; -----------------------------------------------------------------------------

sub_rom_B123:
	ldx #$76
	ldy #$76
	lda ram_079F
	ora ram_07A0
	bne @B133

	ldx #$00
	ldy #$00
	@B133:
	jsr sub_rom_B242
	lda zp_FE
	pha
	jsr sub_rom_B267
	pla
	ora zp_FE
	ora #$30
	sta Sq0Duty_4000
	jsr sub_rom_B28C
	lda #$00
	sta zp_FF
	lda zp_FE
	bpl @B151

	dec zp_FF
	@B151:
	lda ram_0743,Y
	clc
	adc zp_FE
	sta ram_074D,Y
	sta Sq0Timer_4002
	lda ram_074E,Y
	sta zp_FE
	lda ram_0744,Y
	adc zp_FF
	tax
	cpx zp_FE
	beq @B174

	sta ram_074E,Y
	ora #$F8
	sta Sq0Length_4003
	@B174:
	rts

; -----------------------------------------------------------------------------

sub_rom_B175:
	ldx #$77
	ldy #$78
	lda ram_07A1
	ora ram_07A2
	bne @B185

	ldx #$01
	ldy #$02
	@B185:
	jsr sub_rom_B242
	lda zp_FE
	pha
	jsr sub_rom_B267
	pla
	ora zp_FE
	ora #$30
	sta Sq1Duty_4004
	jsr sub_rom_B28C
	lda #$00
	sta zp_FF
	lda zp_FE
	bpl @B1A3

	dec zp_FF
	@B1A3:
	lda ram_0743,Y
	clc
	adc zp_FE
	sta ram_074D,Y
	sta Sq1Timer_4006
	lda ram_074E,Y
	sta zp_FE
	lda ram_0744,Y
	adc zp_FF
	tax
	cpx zp_FE
	beq @B1C6

	sta ram_074E,Y
	ora #$F8
	sta Sq1Length_4007
	@B1C6:
	rts

; -----------------------------------------------------------------------------

sub_rom_B1C7:
	ldx #$78
	ldy #$7A
	lda ram_07A3
	ora ram_07A4
	bne @B1D7

	ldx #$02
	ldy #$04
	@B1D7:
	jsr sub_rom_B242
	lda zp_FE
	beq @B1E0

	lda #$FF
	@B1E0:
	ora #$80
	sta TrgLinear_4008
	jsr sub_rom_B28C
	lda #$00
	sta zp_FF
	lda zp_FE
	bpl @B1F2

	dec zp_FF
	@B1F2:
	lda ram_0743,Y
	clc
	adc zp_FE
	sta ram_074D,Y
	sta TrgTimer_400A
	lda ram_074E,Y
	sta zp_FE
	lda ram_0744,Y
	adc zp_FF
	tax
	cpx zp_FE
	beq @B215

	sta ram_074E,Y
	ora #$F8
	sta TrgLength_400B
	@B215:
	rts

; -----------------------------------------------------------------------------

sub_rom_B216:
	ldx #$79
	ldy #$7C
	lda ram_07A5
	ora ram_07A6
	bne @B226

	ldx #$03
	ldy #$06
	@B226:
	jsr sub_rom_B242
	lda zp_FE
	ora #$30
	sta NoiseVolume_400C
	jsr sub_rom_B28C
	lda ram_0743,Y
	clc
	adc zp_FE
	sta NoisePeriod_400E
	lda #$F8
	sta NoiseLength_400F
	rts

; -----------------------------------------------------------------------------

sub_rom_B242:
	tya
	pha
	lda ram_075C,X
	tay
	cpy #$FF
	bne @B251

	lda #$00
	jmp @B262

	@B251:
	pla
	pha
	tay
	lda ram_0761,Y
	sta zp_FE
	lda ram_0762,Y
	sta zp_FF
	ldy #$01
	lda (zp_FE),Y
	@B262:
	sta zp_FE
	pla
	tay
	rts

; -----------------------------------------------------------------------------

sub_rom_B267:
	tya
	pha
	lda ram_076D,X
	tay
	cpy #$FF
	bne @B276

	lda #$00
	jmp @B287

	@B276:
	pla
	pha
	tay
	lda ram_076F,Y
	sta zp_FE
	lda ram_0770,Y
	sta zp_FF
	ldy #$01
	lda (zp_FE),Y
	@B287:
	sta zp_FE
	pla
	tay
	rts

; -----------------------------------------------------------------------------

sub_rom_B28C:
	tya
	pha
	lda ram_0777,X
	tay
	cpy #$FF
	bne @B29B

	lda #$00
	jmp @B2AC

	@B29B:
	pla
	pha
	tay
	lda ram_077B,Y
	sta zp_FE
	lda ram_077C,Y
	sta zp_FF
	ldy #$01
	lda (zp_FE),Y
	@B2AC:
	sta zp_FE
	pla
	tay
	rts

; -----------------------------------------------------------------------------

sub_rom_B2B1:
	ldx ram_070C
	inc ram_0729,X
	lda ram_0729,X
	bne @B2BF

	inc ram_072A,X
	@B2BF:
	rts

; -----------------------------------------------------------------------------

; Corrupted data follows
; (mirror of a section of bank 1, plus some unassembled code)
