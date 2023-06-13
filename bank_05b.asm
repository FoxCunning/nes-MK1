.segment "BANK_05b"
; $B000-$BFFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"


; -----------------------------------------------------------------------------
.export sub_rom_05_B000

sub_rom_05_B000:
	lda zp_4E           ; This will be the index of the pointer to use
	jsr sub_rom_E303    ; The sub will use the following table of pointers
                        ; to jump to one of those locations
; ----------------
	.word sub_rom_B013, sub_rom_B174, sub_rom_B24F, sub_rom_B8BC
	.word sub_rom_B6D8, sub_rom_B7FE, sub_rom_BF1E

; -----------------------------------------------------------------------------

sub_rom_B013:
	lda zp_4F
	jsr sub_rom_E303    ; Same trick again
; ----------------
	.word sub_rom_BF92, sub_rom_BFB9, sub_rom_BFCA, sub_rom_BFEA
	.word sub_rom_B030, sub_rom_B079, sub_rom_B086, sub_rom_B0A5
	.word sub_rom_B0CC, sub_rom_B107, sub_rom_B114, sub_rom_B13A

; -----------------------------------------------------------------------------

sub_rom_B030:
	lda #$00
	sta zp_50
	lda #$00
	sta zp_66
	jsr sub_rom_04_805A
	lda #$00
	sta zp_1E
	sta zp_20
	lda #$88
	sta PpuControl_2000
	sta zp_02
	cli
	jsr sub_rom_04_8000
	lda #$1E
	sta zp_04
	lda #$0D
	sta ram_0410
	lda #$ED
	sta ram_041C
	lda #$00
	sta zp_5F
	sta zp_61
	lda #$00
	sta zp_63
	lda #$02
	sta zp_64
	lda rom_B170+0
	sta zp_51
	lda rom_B170+1
	sta zp_52
	inc zp_4F
	lda #$00
	sta zp_5E
	rts

; -----------------------------------------------------------------------------

sub_rom_B079:
	jsr sub_rom_04_81D2
	lda zp_55
	cmp #$05
	bcs @B083

	rts
; ----------------
	@B083:
	inc zp_4F
	rts

; -----------------------------------------------------------------------------

sub_rom_B086:
	lda zp_25
	cmp zp_53
	bne @B08D

	rts
; ----------------
	@B08D:
	sta zp_53
	dec ram_041C
	lda ram_041C
	cmp #$8B
	bcs @B0A4

	lda #$8C
	sta ram_041C
	lda #$07
	sta zp_54
	inc zp_4F
	@B0A4:
	rts

; -----------------------------------------------------------------------------

sub_rom_B0A5:
	lda zp_25
	cmp zp_53
	bne @B0AC
    
	rts
; ----------------
	@B0AC:
	sta zp_53
	ldx zp_54
	lda rom_B0C4,X
	sta zp_20
	dec zp_54
	bpl @B0C3

	lda #$00
	sta zp_20
	lda #$0A
	sta zp_54
	inc zp_4F
	@B0C3:
	rts

; -----------------------------------------------------------------------------

rom_B0C4:
	.byte $00, $02, $00, $03, $00, $04, $00, $07

; -----------------------------------------------------------------------------

sub_rom_B0CC:
	lda zp_25
	cmp zp_53
	bne @B0D3

	rts
; ----------------
	@B0D3:
	sta zp_53
	lda zp_25
	and #$3F
	bne @B0E4

	dec zp_54
	bpl @B0E4

	lda #$0B
	sta zp_4F
	rts
; ----------------
	@B0E4:
	jsr sub_rom_B14D
	lda zp_63
	asl A
	tax
	lda rom_B170+0,X
	sta zp_51
	lda rom_B170+1,X
	sta zp_52
	lda zp_2D
	and #$D0
	beq sub_rom_B0CC
	lda #$31
	sta ram_0673
	inc zp_4F
	lda #$05
	sta zp_55
	rts

; -----------------------------------------------------------------------------

sub_rom_B107:
	jsr sub_rom_04_81D2
	lda zp_55
	cmp #$09
	bcs @B111

	rts
; ----------------
	@B111:
	inc zp_4F
	rts

; -----------------------------------------------------------------------------

sub_rom_B114:
	lda zp_25
	cmp zp_53
	bne @B11B

	rts
; ----------------
	@B11B:
	sta zp_53
	lda #$0C
	sta ram_0410
	lda #$00
	sta PpuMask_2001
	sta zp_4F
	lda zp_63
	bne @B137

	lda #$03
	sta zp_63
	lda #$84
	sta zp_64
	inc zp_4E
	@B137:
	inc zp_4E
	rts

; -----------------------------------------------------------------------------

sub_rom_B13A:
	jsr sub_rom_04_81D2
	lda zp_55
	cmp #$09
	bcs @B144

	rts
; ----------------
	@B144:
	lda #$00
	sta zp_4F
	lda #$05
	sta zp_4E
	rts

; -----------------------------------------------------------------------------

sub_rom_B14D:
	lda #$00
	asl A
	tax
	lda rom_04_9CAD+0,X
	sta zp_12
	lda rom_04_9CAD+1,X
	sta zp_13
	lda zp_2D
	sta zp_06
	lda zp_63
	sta zp_05
	jsr sub_rom_04_810A
	bmi @B16F

	sta zp_63
	lda #$03
	sta ram_0672
	@B16F:
	rts

; -----------------------------------------------------------------------------

rom_B170:
	.byte $28, $20, $2A, $20

; -----------------------------------------------------------------------------

sub_rom_B174:
	lda zp_4F
	jsr sub_rom_E303
; ----------------
	.word sub_rom_B183, sub_rom_B079, sub_rom_B1B2, sub_rom_B107
	.word sub_rom_B1E2

; -----------------------------------------------------------------------------

sub_rom_B183:
	lda #$01
	sta zp_50
	jsr sub_rom_04_805A
	lda #$00
	sta mmc3_mirroring
	lda #$88
	sta PpuControl_2000
	sta zp_02
	cli
	jsr sub_rom_04_8000
	lda #$1E
	sta zp_04
	lda ram_042C
	sta zp_64
	jsr sub_rom_B223
	ldx ram_042C
	lda rom_B24A,X
	sta ram_041C
	inc zp_4F
	rts

; -----------------------------------------------------------------------------

sub_rom_B1B2:
	lda zp_25
	cmp zp_53
	bne @B1B9
    
	rts
; ----------------
	@B1B9:
	sta zp_53
	jsr sub_rom_B200
	jsr sub_rom_B223
	lda zp_2D
	and #$D0
	beq sub_rom_B1B2

	lda zp_64
	cmp #$05
	bcs @B1DB

	ldx zp_64
	stx ram_042C
	lda rom_B24A,X
	sta ram_041C
	jmp sub_rom_B1B2

	@B1DB:
	inc zp_4F
	lda #$05
	sta zp_55
	rts

; -----------------------------------------------------------------------------

sub_rom_B1E2:
	lda zp_25
	cmp zp_53
	bne @B1E9

	rts
; ----------------
	@B1E9:
	sta zp_53
	lda #$0C
	sta ram_0410
	lda #$00
	sta PpuMask_2001
	sta zp_4F
	lda #$00
	sta zp_4E
	lda #$04
	sta zp_4F
	rts

; -----------------------------------------------------------------------------

sub_rom_B200:
	lda #$01
	asl A
	tax
	lda rom_04_9CAD+0,X
	sta zp_12
	lda rom_04_9CAD+1,X
	sta zp_13
	lda zp_2D
	sta zp_06
	lda zp_64
	sta zp_05
	jsr sub_rom_04_810A
	bmi @B222

	sta zp_64
	lda #$03
	sta ram_0672
	@B222:
	rts

sub_rom_B223:
	lda zp_64
	asl A
	tax
	lda rom_B23E+0,X
	sta ram_0300
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
	lda zp_4F
	jsr sub_rom_E303
; ----------------
; Indirect jump pointers
	.word sub_rom_B25C, sub_rom_B2AD, sub_rom_B2BD, sub_rom_B2E0

; -----------------------------------------------------------------------------

sub_rom_B25C:
	ldy #$02
	lda zp_66
	beq @B263
	iny
	@B263:
	sty zp_50
	jsr sub_rom_04_805A
	jsr sub_rom_B4B2
	lda #$00
	sta zp_1E
	sta zp_20
	lda #$88
	sta PpuControl_2000
	sta zp_02
	cli
	jsr sub_rom_04_8000
	lda #$1E
	sta zp_04
	lda #$0C
	sta ram_0410
	lda #$80
	sta ram_041C
	inc zp_4F
	lda #$00
	sta zp_5C
	sta zp_5D
	lda zp_66
	asl A
	tay
	lda zp_63
	and #$80
	ora rom_B2A9+0,Y
	sta zp_63
	lda zp_64
	and #$80
	ora rom_B2A9+1,Y
	sta zp_64
	rts

; -----------------------------------------------------------------------------

rom_B2A9:
	.byte $03, $04, $06, $08

; -----------------------------------------------------------------------------

sub_rom_B2AD:
	jsr sub_rom_04_81D2
	lda zp_55
	cmp #$05
	bcs @B2B7

	rts
; ----------------
	@B2B7:
	inc zp_4F
	jsr sub_rom_B363
	rts

; -----------------------------------------------------------------------------


sub_rom_B2BD:
	lda zp_25
	cmp zp_53
	bne @B2C4

	rts
; ----------------
	@B2C4:
	sta zp_53
	jsr sub_rom_B2F1
	jsr sub_rom_B363
	jsr sub_rom_B556
	lda zp_5C
	cmp zp_5D
	bne @B2DF

	cmp #$09
	bne @B2DF

	inc zp_4F
	lda #$05
	sta zp_55
	@B2DF:
	rts

; -----------------------------------------------------------------------------

sub_rom_B2E0:
	jsr sub_rom_04_81D2
	lda zp_55
	cmp #$09
	bcs @B2EA

	rts
; ----------------
	@B2EA:
	lda #$00
	sta zp_4F
	inc zp_4E
	rts

; -----------------------------------------------------------------------------

sub_rom_B2F1:
	ldx #$00
	stx zp_07
	jsr sub_rom_B2FC
	ldx #$01
	stx zp_07
; ----------------
sub_rom_B2FC:
	lda zp_63,X
	bpl @B316

	lda #$09
	sta zp_5C,X
	lda zp_2A,X
	and #$0F
	beq @B352

	lda zp_63,X
	and #$7F
	sta zp_63,X
	lda #$00
	sta zp_5C,X
	sta zp_2D,X
	@B316:
	lda zp_5C,X
	bne @B352

	lda zp_2D,X
	sta zp_06
	lda zp_63,X
	sta zp_05
	lda zp_50
	asl A
	tax
	lda rom_04_9CAD+0,X
	sta zp_12
	lda rom_04_9CAD+1,X
	sta zp_13
	lda zp_06
	sta zp_06
	lda zp_05
	sta zp_05
	jsr sub_rom_04_810A
	sta zp_05
	ldx zp_07
	lda zp_05
	bmi @B34A

	sta zp_63,X
	lda #$03
	sta ram_0672
	@B34A:
	lda zp_2D,X
	and #$C0
	beq @B352

	inc zp_5C,X
	@B352:
	lda zp_5C,X
	beq @B362

	cmp #$09
	bcs @B362

	lda zp_25
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
	sta ram_0300,Y
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
	lda zp_50
	asl A
	tay
	lda rom_B414+0,Y
	sta zp_12
	lda rom_B414+1,Y
	sta zp_13
	lda zp_63,X
	bpl @B3A6
	rts
; ----------------
	@B3A6:
	asl A
	tay
	lda (zp_12),Y
	sta zp_14
	iny
	lda (zp_12),Y
	sta zp_15
	ldy #$08
	lda zp_5C,X
	beq @B3B9

	ldy #$02
	@B3B9:
	sty zp_05
	ldy #$00
	lda zp_25
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
	lda zp_14
	sta zp_09
	@B3E3:
	sta ram_0303,X
	lda rom_B452,Y
	beq @B3FC

	sta ram_0301,X
	lda zp_0F
	sta ram_0302,X
	lda zp_15
	sta ram_0300,X
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

	lda zp_15
	clc
	adc #$08
	sta zp_15
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
	lda zp_50
	asl A
	tax
	lda rom_B4CE+0,X
	sta zp_12
	lda rom_B4CE+1,X
	sta zp_13
	ldx #$40
	ldy #$00
	@B4C4:
	lda (zp_12),Y
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
	lda zp_50
	asl A
	tay
	lda rom_B5BF+0,Y
	sta zp_14
	lda rom_B5BF+1,Y
	sta zp_15
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
	lda zp_63,X
	asl A
	tay
	lda (zp_14),Y
	sta zp_12
	iny
	lda (zp_14),Y
	sta zp_13
	ldy #$00
	lda (zp_12),Y
	@B58B:
	tax
	iny
	lda ram_0680,X
	ora (zp_12),Y
	sta ram_0680,X
	iny
	lda (zp_12),Y
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
	lda zp_4F
	jsr sub_rom_E303
; ----------------
; Jump pointers
	.word sub_rom_B6E9, sub_rom_B712, sub_rom_B723, sub_rom_B776
	.word sub_rom_B789, sub_rom_B7A8

; -----------------------------------------------------------------------------

sub_rom_B6E9:
	lda #$05
	sta zp_50
	jsr sub_rom_04_805A
	lda #$00
	sta zp_1E
	sta zp_20
	lda #$88
	sta PpuControl_2000
	sta zp_02
	cli
	jsr sub_rom_04_8000
	lda #$1E
	sta zp_04
	lda #$0C
	sta ram_0410
	lda #$80
	sta ram_041C
	inc zp_4F
	rts

; -----------------------------------------------------------------------------

sub_rom_B712:
	jsr sub_rom_04_81D2
	lda zp_55
	cmp #$05
	bcs @B71C
	rts
; ----------------
	@B71C:
	lda #$0A
	sta zp_54
	inc zp_4F
	rts

; -----------------------------------------------------------------------------

sub_rom_B723:
	lda zp_25
	cmp zp_53
	bne @B72A

	rts
; ----------------
	@B72A:
	sta zp_53
	lda ram_040C
	eor #$01
	tax
	lda zp_2D,X
	and #$C0
	beq @B744

	lda #$0F
	sta ram_0672
	inc zp_4F
	lda #$05
	sta zp_55
	rts
; ----------------
	@B744:
	jsr sub_rom_B7C3
	lda zp_25
	and #$3F
	bne @B775

	lda #$10
	sta ram_0672
	dec zp_54
	bpl @B775

	lda zp_F2
	eor zp_F3
	and #$80
	bne @B767

	inc zp_4F
	inc zp_4F
	lda #$05
	sta zp_55
	rts
; ----------------
	@B767:
	inc zp_4F
	inc zp_4F
	inc zp_4F
	lda #$03
	sta zp_54
	lda #$8A
	sta zp_02
	@B775:
	rts

; -----------------------------------------------------------------------------

sub_rom_B776:
	jsr sub_rom_04_81D2
	lda zp_55
	cmp #$09
	bcs @B780

	rts
; ----------------
	@B780:
	lda #$00
	sta zp_4F
	lda #$02
	sta zp_4E
	rts

; -----------------------------------------------------------------------------

sub_rom_B789:
	jsr sub_rom_04_81D2
	lda zp_55
	cmp #$09
	bcs @B793

	rts
; ----------------
	@B793:
	lda #$00
	sta zp_4F
	lda #$03
	sta zp_4E
	lda ram_040C
	eor #$01
	tax
	lda #$80
	sta zp_F2,X
	sta zp_63,X
	rts

; -----------------------------------------------------------------------------

sub_rom_B7A8:
	lda zp_25
	cmp zp_53
	bne @B7AF

	rts
; ----------------
	@B7AF:
	sta zp_53
	lda zp_25
	and #$1F
	bne @B7C2

	dec zp_54
	bne @B7C2

	lda #$00
	sta zp_04
	jmp reset
	@B7C2:
	rts

; -----------------------------------------------------------------------------

sub_rom_B7C3:
	lda zp_54
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
	lda zp_4F
	jsr sub_rom_E303
; ----------------
; Jump pointers
	.word sub_rom_B80D, sub_rom_B834, sub_rom_B845, sub_rom_B864
	.word sub_rom_B8A5

; -----------------------------------------------------------------------------

sub_rom_B80D:
	lda #$04
	sta zp_50
	jsr sub_rom_04_805A
	lda #$00
	sta zp_1E
	sta zp_20
	lda #$88
	sta PpuControl_2000
	sta zp_02
	cli
	jsr sub_rom_04_8000
	lda #$1E
	sta zp_04
	lda #$0C
	sta ram_0410
	sta ram_041C
	inc zp_4F
	rts

; -----------------------------------------------------------------------------

sub_rom_B834:
	jsr sub_rom_04_81D2
	lda zp_55
	cmp #$05
	bcs @B83E

	rts
; ----------------
	@B83E:
	lda #$09
	sta zp_54
	inc zp_4F
	rts

; -----------------------------------------------------------------------------

sub_rom_B845:
	lda zp_25
	cmp zp_53
	bne @B84C

	rts
; ----------------
	@B84C:
	sta zp_53
	lda zp_2D
	beq @B857

	inc zp_4F
	jmp @B861

	@B857:
	lda zp_25
	and #$3F
	bne @B863

	dec zp_54
	bpl @B863

	@B861:
	inc zp_4F
	@B863:
	rts

; -----------------------------------------------------------------------------

sub_rom_B864:
	jsr sub_rom_04_81D2
	lda zp_55
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
	sta zp_4F
	lda #$00
	sta zp_4E
	lda #$01
	sta zp_40
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
	jsr sub_rom_04_81D2
	lda zp_55
	cmp #$09
	bcs @B8AF

	rts
; ----------------
	@B8AF:
	lda #$00
	sta zp_4F
	lda #$00
	sta zp_4E
	sta zp_63
	sta zp_64
	rts

; -----------------------------------------------------------------------------

sub_rom_B8BC:
	lda zp_4F
	jsr sub_rom_E303
; ----------------
; Jump pointers
	.word sub_rom_B8CB, sub_rom_B926, sub_rom_B982, sub_rom_B993
	.word sub_rom_B9B5

; -----------------------------------------------------------------------------

sub_rom_B8CB:
	jsr sub_rom_BE15
	ldx #$00
	lda zp_63,X
	bmi @B8E2

	inx
	lda zp_63,X
	bmi @B8E2

	inc zp_4F
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
	sta zp_63,X
	inc zp_4F
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

	lda #$02
	sta zp_50
	jsr sub_rom_04_805A
	jsr sub_rom_BA74
	jsr sub_rom_B9DB
	lda #$8A
	sta ram_0680
	jmp @B956

	@B941:
	lda #$07
	sta zp_50
	jsr sub_rom_04_805A
	jsr sub_rom_BC2B
	ldy #$88
	lda zp_63
	bpl @B953

	ldy #$8A
	@B953:
	sty ram_0680
	@B956:
	jsr sub_rom_E264
	lda #$00
	sta zp_57
	sta zp_55
	sta zp_1E
	sta zp_20
	lda #$88
	sta PpuControl_2000
	sta zp_02
	cli
	jsr sub_rom_04_8000
	lda #$1E
	sta zp_04
	lda ram_0680
	sta zp_02
	lda #$0C
	sta ram_0410
	sta ram_041C
	inc zp_4F
	rts

; -----------------------------------------------------------------------------

sub_rom_B982:
	jsr sub_rom_04_81D2
	lda zp_55
	cmp #$05
	bcs @B98C

	rts
; ----------------
	@B98C:
	inc zp_4F
	lda #$04
	sta zp_54
	rts

; -----------------------------------------------------------------------------

sub_rom_B993:
	lda zp_25
	cmp zp_53
	bne @B99A

	rts
; ----------------
	@B99A:
	sta zp_53
	lda zp_2D
	bne @B9AE

	lda zp_2E
	bne @B9AE

	lda zp_25
	and #$1F
	bne @B9B4

	dec zp_54
	bne @B9B4

	@B9AE:
	lda #$00
	sta zp_54
	inc zp_4F
	@B9B4:
	rts

; -----------------------------------------------------------------------------

sub_rom_B9B5:
	jsr sub_rom_04_81D2
	lda zp_55
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
	sta zp_4F
	lda #$00
	sta zp_4E
	jsr sub_rom_BE9F
	lda #$01
	sta zp_40
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
	sta zp_14
	lda rom_BB07+1,Y
	sta zp_15
	ldx #$00
	lda zp_63
	and #$7F
	asl A
	tay
	lda (zp_14),Y
	sta zp_05
	iny
	lda (zp_14),Y
	sta ram_0680,X
	jsr sub_rom_BC9A
	lda #$29
	sta zp_44
	lda #$46
	sta zp_43
	jsr sub_rom_BABF
	ldx #$01
	lda zp_64
	and #$7F
	asl A
	tay
	lda (zp_14),Y
	sta zp_05
	iny
	lda (zp_14),Y
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
	sta zp_14
	lda rom_BB07+1,Y
	sta zp_15
	ldx #$00
	stx zp_1C
	lda zp_63
	jsr sub_rom_BC57
	ldx #$01
	stx zp_1C
	lda zp_63,X
	jsr sub_rom_BC57
	ldx #$02
	stx zp_1C
	lda zp_63,X
	jsr sub_rom_BC57
	jmp sub_rom_BCCB

; -----------------------------------------------------------------------------

sub_rom_BC57:
	and #$7F
	asl A
	tay
	lda (zp_14),Y
	sta zp_05
	iny
	ldx zp_1C
	lda (zp_14),Y
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
	sta zp_12
	lda rom_BB41+1,Y
	sta zp_13
	lda #$04
	sta zp_46
	lda #$06
	sta zp_45
	ldy #$00
	sty zp_47
	@BCB4:
	lda (zp_12),Y
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
	lda zp_63
	bpl @BE1F
	lda zp_64
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
	lda zp_63
	bpl @BE4A

	lda zp_64
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
	lda zp_63
	and #$80
	sta zp_F2
	lda zp_64
	and #$80
	sta zp_F3
	lda zp_65
	and #$80
	sta zp_60
	lda zp_66
	bne @BEDC

	lda zp_63
	and #$7F
	tay
	lda rom_BF03,Y
	ora zp_F2
	sta zp_F2
	lda zp_64
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
	lda zp_63
	and #$7F
	tay
	lda rom_BF0C,Y
	ora zp_F2
	sta zp_F2
	lda zp_64
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
	lda zp_4F
	jsr sub_rom_E303
; ----------------
; Jump pointers
	.word sub_rom_BF29, sub_rom_BF66, sub_rom_BF73

; -----------------------------------------------------------------------------

sub_rom_BF29:
	lda #$06
	sta zp_50
	jsr sub_rom_04_805A
	lda #$00
	sta zp_1E
	sta zp_20
	lda #$01
	sta mmc3_mirroring
	lda #$88
	sta PpuControl_2000
	sta zp_02
	cli
	jsr sub_rom_04_8000
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
	sta ram_0410
	sta ram_041C
	inc zp_4F
	lda #$14
	sta zp_54
	rts

; -----------------------------------------------------------------------------

sub_rom_BF66:
	jsr sub_rom_04_81D2
	lda zp_55
	cmp #$05
	bcs @BF70

	rts
; ----------------
	@BF70:
	inc zp_4F
	rts

; -----------------------------------------------------------------------------

sub_rom_BF73:
	jsr sub_rom_04_81D2
	lda zp_55
	cmp #$09
	bcs @BF7D

	rts
; ----------------
	@BF7D:
	dec zp_54
	beq @BF89

	ldy #$00
	sty zp_55
	iny
	sty zp_4F
	rts
; ----------------
	@BF89:
	lda #$00
	sta zp_4F
	sta zp_4E
	sta zp_40
	rts

; -----------------------------------------------------------------------------

sub_rom_BF92:
	lda #$08
	sta zp_50
	jsr sub_rom_04_805A
	jsr sub_rom_E264
	lda #$00
	sta zp_1E
	sta zp_20
	lda #$88
	sta PpuControl_2000
	sta zp_02
	cli
	jsr sub_rom_04_8000
	lda #$1E
	sta zp_04
	lda #$7C
	sta ram_041C
	inc zp_4F
	rts

; -----------------------------------------------------------------------------

sub_rom_BFB9:
	jsr sub_rom_04_81D2
	lda zp_55
	cmp #$05
	bcs @BFC3

	rts
; ----------------
	@BFC3:
	inc zp_4F
	lda #$0A
	sta zp_54
	rts

; -----------------------------------------------------------------------------

sub_rom_BFCA:
	lda zp_25
	cmp zp_53
	bne @BFD1

	rts
; ----------------
	@BFD1:
	sta zp_53
	lda zp_2D
	and #$D0
	bne @BFE3

	lda zp_25
	and #$1F
	bne @BFE9
	dec zp_54
	bne @BFE9

	@BFE3:
	lda #$00
	sta zp_54
	inc zp_4F
	@BFE9:
	rts

; -----------------------------------------------------------------------------

sub_rom_BFEA:
	jsr sub_rom_04_81D2
	lda zp_55
	cmp #$09
	bcs @BFF4

	rts
; ----------------
	@BFF4:
	inc zp_4F
	rts

; -----------------------------------------------------------------------------

; Potentially unused
rom_BFF7:
	.byte $20, $24, $32, $31, $2C, $24, $34, $34
	.byte $2C

; -----------------------------------------------------------------------------
