.segment "BANK_03"
; $A000-$BFFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"

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
	lda zp_plr1_cur_anim,X
	cmp #$0B
	bcc @A02A

	cmp #$26
	bcs @A02A

	txa
	eor #$01
	tay
	lda zp_plr1_x_pos,X
	cmp zp_plr1_x_pos,Y
	beq @A030

	bcs @A02B

	lda zp_plr1_facing_dir,X
	beq @A030

	@A02A:
	rts
; ----------------
	@A02B:
	lda zp_plr1_facing_dir,X
	bne @A030

	rts
; ----------------
	@A030:
	lda zp_plr1_fgtr_idx_clean,X
	asl A
	tay
	lda rom_A10C+0,Y
	sta zp_ptr4_lo
	lda rom_A10C+1,Y
	sta zp_ptr4_hi
	lda zp_plr1_cur_anim,X
	sec
	sbc #$0B
	asl A
	tay
	lda (zp_ptr4_lo),Y
	sta zp_ptr3_lo
	iny
	lda (zp_ptr4_lo),Y
	sta zp_ptr3_hi
	ldy #$00
	lda (zp_ptr3_lo),Y
	sta zp_ptr1_lo
	cmp #$FF
	beq @A02A

	bpl @A068

	and #$0F
	sta zp_ptr1_lo
	txa
	eor #$01
	tax
	lda zp_controller1,X
	and #$04
	bne @A02A

	@A068:
	ldx zp_7C
	lda zp_plr1_anim_frame,X
	cmp zp_ptr1_lo
	bcc @A02A

	iny
	cmp (zp_ptr3_lo),Y
	bcc @A077

	bne @A02A

	@A077:
	iny
	lda zp_players_x_distance
	cmp (zp_ptr3_lo),Y
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
	lda (zp_ptr3_lo),Y
	cmp zp_players_y_distance
	bcc @A0BD

	ldy #$05
	txa
	eor #$01
	tax
	lda zp_plr1_cur_anim,X
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
	sta zp_plr1_cur_anim,X
	lda #$00
	sta zp_plr1_anim_frame,X
	@A0BD:
	rts
; ----------------
	@A0BE:
	lda (zp_ptr3_lo),Y
	cmp #$09
	beq @A0C8

	cmp #$0A
	bne @A0DA

	@A0C8:
	lda zp_plr1_y_pos,X
	cmp zp_sprites_base_y
	beq @A0D2

	@A0CE:
	lda #$2E
	bne @A0DA

	@A0D2:
	lda zp_E5,X
	cmp #$03
	bcs @A0CE

	lda (zp_ptr3_lo),Y
	@A0DA:
	cmp zp_plr1_cur_anim,X
	beq @A0BD

	sta zp_plr1_cur_anim,X
	lda #$00
	sta zp_plr1_anim_frame,X
	iny
	lda (zp_ptr3_lo),Y
	ldx zp_7C
	sta zp_gained_score_idx,X
	inc zp_gained_score_idx,X
	pha
	iny
	lda (zp_ptr3_lo),Y
	sta zp_EB,X
	iny
	lda (zp_ptr3_lo),Y
	sta zp_ED,X
	pla
	tay
	txa
	eor #$01
	tax
	lda rom_A108,Y
	sta zp_plr1_dmg_counter,X
	lda #$01
	sta zp_player_hit_counter
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
	lda zp_plr1_fighter_idx,Y
	bpl @A60B

	lda zp_plr1_cur_anim,Y
	beq @A601

	cmp #$03
	bne @A60B

	@A601:
	lda #$58
	cmp zp_plr1_damage
	beq @A60B

	cmp zp_plr2_damage
	bne @A60C

	@A60B:
	rts
; ----------------
	@A60C:
	tya
	eor #$01
	tax
	stx zp_7B
	lda zp_players_x_distance
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

	lda ram_plr1_rounds_won,X
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
	lda zp_plr1_fgtr_idx_clean,X
	asl A
	tay
	lda (zp_ptr3_lo),Y
	sta zp_ptr4_lo
	iny
	lda (zp_ptr3_lo),Y
	sta zp_ptr4_hi
	lda zp_plr1_cur_anim,X
	tay
	lda (zp_ptr4_lo),Y
	bmi @A679

	jsr sub_rom_A773
	pla
	pla
	@A679:
	rts

; -----------------------------------------------------------------------------

sub_rom_A67A:
	lda zp_plr1_fgtr_idx_clean,Y
	asl A
	tax
	lda rom_A7BF+0,X
	sta zp_ptr3_lo
	lda rom_A7BF+1,X
	sta zp_ptr3_hi
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
	lda zp_plr1_fgtr_idx_clean,Y
	asl A
	tax
	lda rom_A7D7+0,X
	sta zp_ptr3_lo
	lda rom_A7D7+1,X
	sta zp_ptr3_hi
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
	lda zp_plr1_fgtr_idx_clean,Y
	asl A
	tax
	lda rom_A7EF+0,X
	sta zp_ptr3_lo
	lda rom_A7EF+1,X
	sta zp_ptr3_hi
	jsr sub_rom_A63B
	jsr sub_rom_A9EB
	jsr sub_rom_A9FD
	and #$1F
	tax
	lda rom_A733,X
	bpl @A723

	ldx zp_plr1_fgtr_idx_clean,Y
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
	sta zp_ptr1_lo
	cmp #$03
	beq @A7AB

	cmp #$18
	bne @A7B0

	ldx zp_7B
	lda zp_plr1_y_pos,X
	cmp zp_sprites_base_y
	bne @A7A5

	lda zp_plr1_cur_anim,X
	cmp #$09
	beq @A7A5

	cmp #$0A
	beq @A7A5

	cmp #$26
	beq @A7A5

	cmp #$2D
	bcs @A7A5

	lda zp_frame_counter
	and #$01
	beq @A7B0

	lda #$1E
	sta zp_ptr1_lo
	bne @A7B0

	@A7A5:
	lda #$04
	sta zp_ptr1_lo
	bne @A7B0

	@A7AB:
	cmp zp_plr1_cur_anim,Y
	beq @A7B5
    
	@A7B0:
	lda #$00
	sta zp_plr1_anim_frame,Y
	@A7B5:
	lda zp_ptr1_lo
	and #$3F
	sta zp_plr1_cur_anim,Y
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
	ldx ram_difficulty_setting
	lda zp_frame_counter
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


; -----------------------------------------------------------------------------
.export sub_update_health_bars

sub_update_health_bars:
	lda zp_4B
	cmp #$FF
	bne @D291

		; Display the full bar at the beginning of the match
		lda #$20
		sta PpuAddr_2006
		ldx #$71	; First pattern of health bar for Player 2
		lda zp_plr1_fighter_idx
		bpl :+
			ldx #$64	; First pattern of health bar for Player 1
		:
		stx PpuAddr_2006
		ldx #$0A
		lda #$8A	; Full bar pattern
		:
			sta PpuData_2007
		dex
		bpl :-

	rts
; ----------------
	@D291:
	lda zp_ppu_control_backup
	ora #$04
	sta PpuControl_2000
	lda zp_frame_counter
	and #$01
	bne :+
		ldx #$00
		jsr sub_rom_D359
		ldx #$01
		jsr sub_rom_D359
	:
	jmp @D2EE

	@D2AB:
	lda zp_ppu_control_backup
	sta PpuControl_2000
	lda zp_game_substate
	cmp #$03	; Match main loop
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
	lda zp_match_time
	cmp #$0F
	bcs @D2E1

	lda zp_frame_counter
	and #$04
	bne @D2E1

	lda zp_game_substate
	cmp #$03	; Match main loop
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
	lda zp_game_substate
	cmp #$03	; Match main loop
	beq @D356

	lda ram_plr1_rounds_won
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
	lda ram_plr2_rounds_won
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
	lda zp_plr1_damage,X
	cmp #$58
	bcc @D387

	lda zp_plr1_cur_anim,X
	cmp #$2E
	beq @D375

	cmp #$31
	beq @D375

	cmp #$26
	beq @D38B

	lda #$2E
	sta zp_plr1_cur_anim,X
	lda #$00
	sta zp_plr1_anim_frame,X
	@D375:
	lda zp_4B
	bmi @D38B

	; Play the "victory jingle"
	lda #$32
	sta ram_req_song
	lda #$10
	sta zp_92
	sta ram_0438
	bne @D38B

	@D387:
	lda zp_plr1_dmg_counter,X
	bne @D38C

	@D38B:
	rts
; ----------------
	@D38C:
	dec zp_plr1_dmg_counter,X
	inc zp_plr1_damage,X
	lda #$20
	sta PpuAddr_2006
	lda zp_plr1_damage,X
	sec
	sbc #$01
	lsr A
	lsr A
	lsr A
	sta zp_ptr1_lo
	txa
	bne @D3B7

	lda #$64
	clc
	adc zp_ptr1_lo
	sta PpuAddr_2006
	lda zp_plr1_damage
	sec
	sbc #$01
	and #$07
	tay
	lda @plr1_health_bar,Y
	bne @D3CA

	@D3B7:
	lda #$7B
	sec
	sbc zp_ptr1_lo
	sta PpuAddr_2006
	lda zp_plr1_damage,X
	sec
	sbc #$01
	and #$07
	tay
	lda @plr2_health_bar,Y
	@D3CA:
	sta PpuData_2007
	rts

; ----------------
; Pattern indices for health bars

	@plr1_health_bar:
	.byte $89, $88, $87, $86, $85, $84, $83, $82
	@plr2_health_bar:
	.byte $91, $90, $8F, $8E, $8D, $8C, $8B, $82

; -----------------------------------------------------------------------------



; -----------------------------------------------------------------------------
.export sub_apu_init

; Initialises the APU registers, clears RAM used by sound routines
sub_apu_init:
	; Enable channels
	lda #$0F
	sta ApuStatus_4015
	; Silence all channels
	lda #$00
	sta Sq0Duty_4000
	sta ram_apu_output_volume+0
	sta Sq1Duty_4004
	sta ram_apu_output_volume+1
	sta TrgLinear_4008
	sta ram_apu_output_volume+2
	sta NoiseVolume_400C
	sta ram_apu_output_volume+3
	sta DmcFreq_4010
	sta DmcCounter_4011
	; Disable sweep units
	lda #$7F
	sta Sq0Sweep_4001
	sta Sq1Sweep_4005

	; Clear all sound variables
	lda #$00
	ldy #$F9
	:
		sta ram_snd_initialised,Y
		dey
	bne :-

	lda #$FF
	ldx #$05

	:
		dex
		sta ram_cur_vol_env_duration,X
		sta ram_sfx_vol_env_duration,X
		sta ram_arpeggio_idx,X
	bne :-

	ldx #$04
	:
	dex
		sta ram_cur_pitch_env_duration,X
		sta ram_sfx_pitch_env_duration,X
	bne :-

	ldx #$02
	:
		dex
		sta ram_duty_env_idx,X
		sta ram_sfx_duty_env_idx,X
	bne :-

	; Clear the sound stack by putting $FF in all eight slots
	ldx #$08
	:
		dex
		sta ram_snd_stack,X
	bne :-

	rts

; -----------------------------------------------------------------------------
.export sub_play_new_song_or_sfx

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
.export sub_process_all_sound

sub_process_all_sound:
	jsr sub_sound_output
	jsr sub_init_new_track

	; Process music channels ($00-$03)
	lda #$00
	sta ram_cur_apu_channel
	sta ram_cur_channel_offset
	sta ram_cur_chan_ptr_offset
	:
		jsr sub_play_cur_channel
		jsr sub_advance_envelopes
		inc ram_cur_apu_channel
		inc ram_cur_channel_offset
		inc ram_cur_chan_ptr_offset
		inc ram_cur_chan_ptr_offset
	ldx ram_cur_apu_channel
	cpx #$04 ;#$05 DMC reserved to SFX
	bne :-

	; Process SFX channels ($10-$13)
	lda #$10
	sta ram_cur_apu_channel
	lda #$80
	sta ram_cur_channel_offset
	sta ram_cur_chan_ptr_offset
	:
		jsr sub_play_cur_channel
		jsr sub_advance_envelopes
		inc ram_cur_apu_channel
		inc ram_cur_channel_offset
		inc ram_cur_chan_ptr_offset
		inc ram_cur_chan_ptr_offset
	ldx ram_cur_apu_channel
	cpx #$15
	bne :-

	rts

; -----------------------------------------------------------------------------

; Reads hader data for all music/SFX in the stack, preparing pointers and
; variables for the channels used by that track
sub_init_new_track:
	lda ram_snd_initialised
	beq @init_new_track_return	; Skip if the sound engine has not been initialised

		ldy #$00
		@AB9D:
		; Loop through the whole stack
		lda ram_snd_stack,Y
		bmi :+

			; Skip if the music/sfx index is > $7F
			; (Typically, $FF = no index)
			tax	; Pass this as a parameter
			tya	; Preserve Y
			pha
			jsr @read_track_header
			pla
			tay
			lda #$FF
			sta ram_snd_stack,Y
		:
		iny
		cpy #$08
		bne @AB9D

	@init_new_track_return:
	rts
; ----------------
	; Reads track header
	; Header consists of:
	; Byte: APU channel (0-5, bit 7 set = SFX) or $FF (end of header)
	; Word: Pointer to track data for that channel
	@read_track_header:
	txa	; Index of the sound track from the stack
	asl A
	tax
	; Get pointer from pointers table
	lda tbl_track_ptrs+0,X
	sta zp_sndptr_lo
	lda tbl_track_ptrs+1,X
	sta zp_sndptr_hi
	
	ldy #$00
	@next_track_header_byte:
	lda (zp_sndptr_lo),Y
	sta ram_cur_apu_channel
	tax
	cpx #$FF	; $FF = End of header
	beq @init_new_track_return

	lda ram_cur_apu_channel
	bmi @header_sfx_offsets	; Bit 7 set = channel used for SFX

	; Music offsets
	sta ram_cur_channel_offset
	asl A
	sta ram_cur_chan_ptr_offset
	jmp @header_track_data_ptr

	; SFX offsets
	@header_sfx_offsets:
	;and #$7F
	;clc
	anc #$7F
	adc #$80
	sta ram_cur_channel_offset
	txa
	; and #$7F Useless: we are shifting left and clearing carry, so bit 7 is lost
	asl A
	clc
	adc #$80
	sta ram_cur_chan_ptr_offset

	@header_track_data_ptr:
	ldx ram_cur_chan_ptr_offset
	; Prepare pointer to track data
	iny
	lda (zp_sndptr_lo),Y
	sta ram_track_ptr_lo,X
	iny
	lda (zp_sndptr_lo),Y
	sta ram_track_ptr_hi,X
	iny
	tya
	pha
		ldy #$00
		lda ram_cur_apu_channel
		bpl :+
			; SFX offset
			ldy #$80
		:
		lda ram_cur_apu_channel
		and #$0F
		tay		; Y = APU channel (0-4)
		
		lda #$00
		sta ram_track_speed_counter,X
		sta ram_note_ticks_left,X
		
		ldx ram_cur_channel_offset

		sta ram_delayed_cut_counter,X
		sta ram_note_delay_counter,X
		sta ram_note_slide_counter,X

		lda #$FF
		sta ram_vol_env_idx,X
		cpy #$04	; DMC skips arpeggios
		bpl :+
			sta ram_arpeggio_idx,X
		:
		sta ram_cur_vol_env_duration,X
		cpy #$03	; DMC and noise channels skip pitch, transpose and duty
		bpl :+

			;lda #$FF
			sta ram_cur_pitch_env_duration,X
			sta ram_pitch_env_idx,X

			lda #$00
			sta ram_note_transpose_value,X
			cpy #$02	; Triangle channel skips duty envelope only
			bpl :+

				lda #$FF
				sta ram_duty_env_idx,X
	:
	pla
	tay
	jmp @next_track_header_byte

; -----------------------------------------------------------------------------

; Processes the current event in the playing channel, or moves to the next
; event if the current one has ended
sub_play_cur_channel:
	ldx ram_cur_chan_ptr_offset

	lda ram_track_ptr_lo,X
	ora ram_track_ptr_hi,X
	; Don't do anything if the data pointer is zero
	bne :+
		rts
	:
	; Check for a pending "skip" event on this channel
	lda ram_track_skip_flag
	and tbl_chan_set_mask,X
	beq :+
		; Clear the skip mask for the channel
		lda tbl_chan_clr_mask,X
		and ram_track_skip_flag
		sta ram_track_skip_flag

		; Restore track data pointer
		lda ram_track_ptr_backup_lo,X
		sta ram_track_ptr_lo,X
		lda ram_track_ptr_backup_hi,X
		sta ram_track_ptr_hi,X

		; Clear backup data pointer (the "return" address)
		lda #$00
		sta ram_track_ptr_backup_lo,X
		sta ram_track_ptr_backup_hi,X

		; Force reading next track data
		beq @force_next_read
	:	
	; Check for delayed transpose
	;ldx ram_cur_channel_offset
	lda ram_transpose_counter,X
	beq :+
		; Counter not zero: decrease
		lda #$00
		dcp ram_transpose_counter,X
		bne :+
			; Zero value reached: transpose note
			lda ram_note_transpose_value,X
			clc
			adc ram_cur_note_idx,X
			ldx ram_cur_apu_channel
			jsr sub_apply_note_pitch
	:
	; Check for pending delayed notes
	ldx ram_cur_channel_offset
	lda ram_note_delay_counter,X
	beq :+
		lda #$00
		dcp ram_note_delay_counter,X
		bne :+
			; Counter reached zero: trigger delayed note
			lda ram_delayed_note_idx,X
			jsr sub_apply_note_pitch
			jsr sub_start_all_envelopes
	:
	ldx ram_cur_chan_ptr_offset

	; This is the "outer" counter, which constantly
	; counts down from "song speed value" to zero
	lda ram_track_speed_counter,X
	bne @decrease_speed_counter	; Skip processing if are still waiting
		
		; This is the "inner" counter, used to check when it's
		; time to read the next note or command
		lda ram_note_ticks_left,X
		bne :+

			; Current note just finished playing, get the next
			@force_next_read:
			jsr sub_get_next_track_byte
			ldx ram_cur_chan_ptr_offset
			ldy ram_cur_channel_offset
			lda ram_cur_note_duration,Y
			sta ram_note_ticks_left,X
			ldx ram_cur_chan_ptr_offset
		:
		dec ram_note_ticks_left,X

		; Set Y to offset for track speed byte
		ldy ram_cur_apu_channel
		cpy #$05
		bmi :+

			; Set offset for SFX speed counters
			ldy #$80
			jmp @reload_counter

		:
		ldy #$00
		@reload_counter:
		; Reload the counter for the next event/tick
		lda ram_track_speed,Y
		sta ram_track_speed_counter,X

	@decrease_speed_counter:
	; If the speed timer has not expired, just decrease it
	dec ram_track_speed_counter,X	; X = current channel POINTER index

	; Check if we need to trigger a delayed cut
	ldx ram_cur_channel_offset
	lda ram_delayed_cut_counter,X
	beq @skip_playing_channel

		lda #$00
		dcp ram_delayed_cut_counter,X
		bne @skip_playing_channel
			jmp sub_stop_envelopes	;jsr sub_stop_envelopes

	@skip_playing_channel:
	rts

; -----------------------------------------------------------------------------

; Saves note/rest length value as read from track data
; Parameters:
; A = Value of note duration (typically $8x)
sub_cmd_note_duration:
	and #$7F
	beq :+

		ldx ram_cur_channel_offset
		sta ram_cur_note_duration,X
:
	jsr sub_advance_track_ptr
	jmp sub_get_next_track_byte

; -----------------------------------------------------------------------------

; Immediately ends the current segment, and signals other channels to do
; the same on the next tick
sub_cmd_skip_segment:
	lda #$0F
	sta ram_track_skip_flag
	jmp sub_cmd_end_seg

; -----------------------------------------------------------------------------

; Processes a new note or rest that was just read from sound track data
; Parameters:
; A = value from track data ($00-$5F)
; X = track data pointer offset
sub_new_note_or_rest:
	bne :+

		; Zero value = rest
		jsr sub_advance_track_ptr
		jmp sub_stop_envelopes
		; ------------
		; Unreachable ?
		;rts
; ----------------
	; 1 = note hold
	:
	cmp #$01
	bne :+
		; Do not change pitch and note index
		; Do not restart envelope
		; Frames left will be updated by the calling routine
		; Just advance data pointer
		jmp sub_advance_track_ptr
	:
	; >1 = note
	sta zp_sndptr_lo	;pha	; Preserve note index

	; Should we delay this note?
	ldx ram_cur_channel_offset
	lda ram_note_delay_counter,X
	beq :+
		; Delay counter is set: delay the note
		lda zp_sndptr_lo
		sta ram_delayed_note_idx,X
		jmp sub_advance_track_ptr
	:
	; No delay counter: play the note immediately
	lda ram_cur_apu_channel
	and #$0F
	tax

	cpx #$02
	bne :+
		; Triangle channel
		; Stop playing the previous note, if any
		lda #$80
		sta TrgLinear_4008
		and #$0F
		sta ram_apu_output_volume+2
	:
	lda zp_sndptr_lo	;pla	; Retrieve note index

	jsr sub_apply_note_pitch
	jsr sub_start_all_envelopes

	jmp sub_advance_track_ptr

; -----------------------------------------------------------------------------

; Gets note pitch for arpeggio and saves it as current channel's base pitch
; If arpeggio is inactive or disabled, nothing is changed
; Does not save note index
; Returns:
; zp_sndptr_lo = arpeggio value
; Parameters:
; X = index for byte channel data
; Y = index for word/pointer channel data
sub_apply_arpeggio_pitch:
	txa
	pha	; Preserve X

	lda ram_arpeggio_idx,X
	cmp #$FF	; Skip if arpeggio is inactive
	beq @no_arpeggio

		; Get next value
		jsr sub_get_next_arpeggio_value
		bcc :+
			; If this arpeggio has ended (read last value),
			; change pitch back to original note
			lda ram_cur_note_idx,X
			jmp @apply_note_pitch
		:
		; Check arpeggio type (absolute or fixed)
		lda ram_arpeggio_idx,X
		bmi :+
			; Absolute arpeggio: add to base note index
			lda ram_cur_note_idx,X
			clc
			adc zp_sndptr_lo
			jmp @apply_note_pitch
		:
		; Fixed arpeggio: override base note index
		lda zp_sndptr_lo

		; A = note index
		@apply_note_pitch:
		asl A
		tax

		lda tbl_pitches+0,X
		sta ram_base_period_lo,Y
		lda tbl_pitches+1,x
		sta ram_base_period_hi,Y

	@no_arpeggio:
	pla
	tax
	rts

; -----------------------------------------------------------------------------

; Gets noise value for arpeggio
; If arpeggio is inactive or disabled, nothing is changed
; Does not save note index
; Parameters:
; X = index for byte channel data
; Y = index for word/pointer channel data
sub_apply_arpeggio_noise:
	lda ram_arpeggio_idx,X
	cmp #$FF	; Skip if arpeggio is inactive
	beq @no_noise_arpeggio

		; Get next value
		jsr sub_get_next_arpeggio_value
		bcc :+
			; If this arpeggio has ended (read last value),
			; change pitch period to original value
			lda ram_cur_note_idx,X
			jmp @apply_noise_period
		:
		; Check arpeggio type (absolute or fixed)
		lda ram_arpeggio_idx,X
		bmi :+
			; Absolute arpeggio: add to base noise period
			lda ram_cur_note_idx,X
			sec
			sbc zp_sndptr_lo
			and #$0F
			bpl @apply_noise_period
		:
		; Fixed arpeggio: override base noise period
		lda zp_sndptr_lo

		@apply_noise_period:
		sta ram_base_period_lo,Y

	@no_noise_arpeggio:
	rts

; -----------------------------------------------------------------------------

; Gets note pitch for current channel from period table and stores it
; in the base note pitch for the current channel
; Also saves the note index (except for DMC)
; Parameters:
; A = note index ($09-$5F)
; X = APU channel index (0-4)
; Returns:
; X = ram_cur_chan_ptr_offset
sub_apply_note_pitch:
	cpx #$03
	beq @noise_channel

	cpx #$04
	beq @dpcm_channel

	; Square and Triangle channels

	; Save note index
	ldx ram_cur_channel_offset
	sta ram_cur_note_idx,X

	ldx ram_cur_channel_offset
	; This is not how we want to apply the transpose value
	;clc
	;adc ram_note_transpose_value,X
	asl A
	tay
	ldx ram_cur_chan_ptr_offset
	lda tbl_pitches+0,Y
	sta ram_base_period_lo,X
	lda tbl_pitches+1,Y
	sta ram_base_period_hi,X

	rts

	@noise_channel:
	; Save note index for Noise channel
	ldx ram_cur_channel_offset
	sta ram_cur_note_idx,X

	tax
	and #$10
	beq :+

		txa
		and #$0F
		ora #$80
		tax
	:
	txa
	ldx ram_cur_chan_ptr_offset
	sta ram_base_period_lo,X
	
	rts

	@dpcm_channel:
	; The DPCM channel will start playing the sample immediately
	tax

	lda tbl_dpcm_ptr,X
	;sta ram_dmc_addr
	sta DmcAddress_4012

	lda tbl_dpcm_len,X
	;sta ram_dmc_len
	sta DmcLength_4013

	lda tbl_dpcm_freq,X
	;sta ram_dmc_freq
	sta DmcFreq_4010

	lda #$1F
	sta ApuStatus_4015
	
	rts

; -----------------------------------------------------------------------------

sub_process_track_command:
	and #$0F
	asl A
	tay
	jsr sub_advance_track_ptr
	tya
	tax

	lda tbl_track_cmd_ptrs+0,X
	sta zp_sndptr_lo
	lda tbl_track_cmd_ptrs+1,X
	sta zp_sndptr_hi
	
	jmp (zp_sndptr_lo)
; ----------------

tbl_track_cmd_ptrs:
	.word sub_cmd_call_seg			; $F0
	.word sub_cmd_end_seg			; $F1
	.word sub_cmd_note_delay		; $F2
	.word sub_cmd_delayed_cut		; $F3
	.word sub_cmd_track_jump		; $F4
	.word sub_cmd_track_speed		; $F5
	.word sub_cmd_transpose			; $F6
	.word sub_cmd_skip_segment		; $F7
	.word sub_cmd_set_vol_env		; $F8
	.word sub_cmd_set_duty_env		; $F9
	.word sub_cmd_set_pitch_env		; $FA
	.word sub_cmd_set_arpeggio		; $FB
	.word sub_cmd_note_slide_up		; $FC	TODO
	.word sub_cmd_note_duration		; $FD	Not used ($8x in track data directly)
	.word sub_get_next_track_byte	; $FE	(this byte is skipped)
	.word sub_cmd_stop_playing		; $FF

; -----------------------------------------------------------------------------

; These bit masks are used to set or clear flags for each channel
; Two bytes per entry: set (OR) or check (AND), clear (AND)
; Index using channel pointer offset
tbl_chan_set_mask:
	.byte $08, $F7	; 0 (Sq0)
	.byte $04, $FB	; 1 (Sq1)
	.byte $02, $FD	; 2 (Tri)
	.byte $01, $FE	; 3 (Noise)

; Use this mask to clear a channel's skip flag
tbl_chan_clr_mask = tbl_chan_set_mask+1

; -----------------------------------------------------------------------------

; Saves a backup of the current track data pointer (+2 to skip the subsegment
; address), then changes the pointer to the start of the desired subsegment
sub_cmd_call_seg:
	ldx ram_cur_chan_ptr_offset
	clc

	lda ram_track_ptr_lo,X
	adc #$02
	sta ram_track_ptr_backup_lo,X

	lda ram_track_ptr_hi,X
	adc #$00
	sta ram_track_ptr_backup_hi,X

	jmp sub_track_jump_entry2

; -----------------------------------------------------------------------------

; Restores the track data pointer, clears skip mask for current channel
; and processes the next byte of track data from the new location
sub_cmd_end_seg:
	ldx ram_cur_chan_ptr_offset

	; Clear the skip mask in case this was a forced skip
	lda tbl_chan_clr_mask,X
	and ram_track_skip_flag
	sta ram_track_skip_flag

	; Restore track data pointer
	lda ram_track_ptr_backup_lo,X
	sta ram_track_ptr_lo,X
	lda ram_track_ptr_backup_hi,X
	sta ram_track_ptr_hi,X

	; Clear backup data pointer (the "return" address)
	lda #$00
	sta ram_track_ptr_backup_lo,X
	sta ram_track_ptr_backup_hi,X
	
	; Immediately process next byte from new location
	jmp sub_get_next_track_byte

; -----------------------------------------------------------------------------

; Delays the next note for the given amount of frames
sub_cmd_note_delay:
	; Next byte = frame count
	ldx ram_cur_chan_ptr_offset

	; Prepare pointer to track data
	lda ram_track_ptr_lo,X
	sta zp_sndptr_lo
	lda ram_track_ptr_hi,X
	sta zp_sndptr_hi
	; Read next byte
	ldy #$00
	lda (zp_sndptr_lo),Y

	ldx ram_cur_channel_offset
	sta ram_note_delay_counter,X

	; All done, process following data until the note being delayed is found
	jsr sub_advance_track_ptr
	jmp sub_get_next_track_byte

; -----------------------------------------------------------------------------

; Stops playing the next note after the given amount of frames
sub_cmd_delayed_cut:
	; Next byte = frame count
	ldx ram_cur_chan_ptr_offset

	; Prepare pointer to track data
	lda ram_track_ptr_lo,X
	sta zp_sndptr_lo
	lda ram_track_ptr_hi,X
	sta zp_sndptr_hi
	; Read next byte
	ldy #$00
	lda (zp_sndptr_lo),Y
	
	ldx ram_cur_channel_offset
	adc #$01
	sta ram_delayed_cut_counter,X

	; All done, process next byte
	jsr sub_advance_track_ptr
	jmp sub_get_next_track_byte
	
; -----------------------------------------------------------------------------

; Next byte = number of frames in which to decrease note period by 5
sub_cmd_note_slide_up:
	ldx ram_cur_chan_ptr_offset
	; Prepare pointer
	lda ram_track_ptr_lo,X
	sta zp_sndptr_lo
	lda ram_track_ptr_hi,X
	sta zp_sndptr_hi
	; Read next byte
	ldy #$00
	lda (zp_sndptr_lo),Y

	ldx ram_cur_channel_offset
	sta ram_note_slide_counter,X

	jsr sub_advance_track_ptr
	jmp sub_get_next_track_byte

; -----------------------------------------------------------------------------

; Jumps to the address read from the next two bytes of track data
sub_cmd_track_jump:
	ldx ram_cur_chan_ptr_offset
; ----------------
; Jumps to the address read from the next two bytes of track data
; Entry point that skips loading the track pointer offset
sub_track_jump_entry2:
	; Prepare pointer to track data
	lda ram_track_ptr_lo,X
	sta zp_sndptr_lo
	lda ram_track_ptr_hi,X
	sta zp_sndptr_hi
	; Read next two bytes as the new pointer
	ldy #$00
	lda (zp_sndptr_lo),Y
	sta ram_track_ptr_lo,X
	iny
	lda (zp_sndptr_lo),Y
	sta ram_track_ptr_hi,X
	; Start processing data from the new location
	jmp sub_get_next_track_byte

; -----------------------------------------------------------------------------

sub_cmd_track_speed:
	ldx ram_cur_chan_ptr_offset

	; Prepare data pointer
	lda ram_track_ptr_lo,X
	sta zp_sndptr_lo
	lda ram_track_ptr_hi,X
	sta zp_sndptr_hi

	; Read next byte
	ldy #$00
	lda (zp_sndptr_lo),Y

	; Offset is either zero (music) or $80 (SFX)
	; So it doesn't matter on which channel this happens
	ldx ram_cur_apu_channel
	cpx #$05
	bmi :+
	
		ldy #$80	; Add offset for SFX channels
	:
	sta ram_track_speed,Y
	jsr sub_advance_track_ptr
	jmp sub_get_next_track_byte

; -----------------------------------------------------------------------------

; Next two bytes are semitones to transpose and frame delay
sub_cmd_transpose:
	lda ram_cur_apu_channel
	and #$0F
	;tax
	;cpx #$03	; Skip the effect for channels that can't use it
	cmp #$03
	bpl :+
		; Prepare pointer in zero page
		ldx ram_cur_chan_ptr_offset
		lda ram_track_ptr_lo,X
		sta zp_sndptr_lo
		lda ram_track_ptr_hi,X
		sta zp_sndptr_hi
		; Read frame delay
		ldy #$00
		lda (zp_sndptr_lo),Y
		ldx ram_cur_channel_offset
		sta ram_transpose_counter,X
		; Read semitones
		iny
		lda (zp_sndptr_lo),Y
		sta ram_note_transpose_value,X
	:
	; Advance pointer two bytes
	ldx ram_cur_chan_ptr_offset
	lda ram_track_ptr_lo,X
	clc
	adc #$02
	sta ram_track_ptr_lo,X
	bcc :+
		inc ram_track_ptr_hi,X
	:
	;jmp sub_get_next_track_byte	No need to jump: it's right there!

; ----------------

; Reads (and processes) the next value from track data
sub_get_next_track_byte:
	ldx ram_cur_chan_ptr_offset

	; Prepare data pointer
	lda ram_track_ptr_lo,X
	sta zp_sndptr_lo
	lda ram_track_ptr_hi,X
	sta zp_sndptr_hi

	; Read next byte
	ldy #$00
	lda (zp_sndptr_lo),Y
	bmi :+

		; Note value ($00-$7F)
		jmp sub_new_note_or_rest
		; --------
	:
	tax
	cpx #$F0
	bpl :+

		jmp sub_cmd_note_duration
		; --------
	:
	jmp sub_process_track_command

; -----------------------------------------------------------------------------

sub_cmd_set_vol_env:
	lda ram_cur_apu_channel
	and #$0F
	tax
	cpx #$04
	bmi :+

		jsr sub_advance_track_ptr
		jmp sub_get_next_track_byte
:
	jsr sub_track_read_next_byte
	cmp #$FF
	bne :+
		
		; If the index is $FF, disable the envelope
		sta ram_cur_vol_env_duration,X
:	
	sta ram_vol_env_idx,X
	jmp sub_get_next_track_byte

; -----------------------------------------------------------------------------

sub_cmd_set_duty_env:
	lda ram_cur_apu_channel
	and #$0F
	tax
	cpx #$02
	bmi :+

		; Skip Triangle and Noise channels
		jsr sub_advance_track_ptr
		jmp sub_get_next_track_byte
	:
	jsr sub_track_read_next_byte
	cmp #$FF
	bne :+
		
		; If the index is $FF, disable the envelope
		sta ram_cur_vol_env_duration,X
	:	
	sta ram_duty_env_idx,X
	jmp sub_get_next_track_byte

; -----------------------------------------------------------------------------

sub_cmd_set_pitch_env:
	lda ram_cur_apu_channel
	and #$0F
	tax
	cpx #$04
	bmi :+

		jsr sub_advance_track_ptr
		jmp sub_get_next_track_byte
	:
	jsr sub_track_read_next_byte
	cmp #$FF
	bne :+
		; If the index is $FF, disable the envelope
		sta ram_cur_pitch_env_duration,X
	:	
	sta ram_pitch_env_idx,X
	jmp sub_get_next_track_byte

; -----------------------------------------------------------------------------

; Stops the current channel, and resets its track data pointer and evelopes
sub_cmd_stop_playing:
	ldx ram_cur_chan_ptr_offset

	lda #$00
	sta ram_track_ptr_lo,X
	sta ram_track_ptr_hi,X
	lda ram_cur_apu_channel
	and #$0F
	asl A
	tax
	clc
	adc #$80	; Add offset for SFX channels
	tay
	lda #$FF
	sta ram_note_period_lo,Y
	sta ram_note_period_hi,Y
; ----------------
; Immediately stops the pitch/volume/duty envelopes for the current channel,
; effectively muting it
sub_stop_envelopes:
	ldy ram_cur_channel_offset
	lda ram_cur_apu_channel
	and #$0F
	tax
	lda #$FF
	cpx #$04	; This is probably to avoid doing this for DMC?
	bpl :+

		; Stop pitch and volume envelopes by setting them to $FF
		sta ram_cur_vol_env_duration,Y
		sta ram_cur_pitch_env_duration,Y
		cpx #$02
		bpl :+

			; Stop duty envelope for square wave channels
			sta ram_duty_env_idx,Y
		:
		bne :+
			; Mute triangle channel
			lda #$80
			sta TrgLinear_4008
			and #$0F
			sta ram_apu_output_volume+2
	:
	rts

; -----------------------------------------------------------------------------

; Skips a jump address if we are in a loop, but if this is the last time we
; are looping, then jumps to that address instead
sub_cmd_set_arpeggio:
	lda ram_cur_apu_channel
	and #$0F
	tax
	cpx #$04
	bmi :+

		jsr sub_advance_track_ptr
		jmp sub_get_next_track_byte
	:
	jsr sub_track_read_next_byte
	; If the index is $FF, arpeggio is automatically disabled
	sta ram_arpeggio_idx,X
	jmp sub_get_next_track_byte

; -----------------------------------------------------------------------------

sub_start_all_envelopes:
	ldx ram_cur_chan_ptr_offset
	; This will set bit 7 of length counter load
	lda ram_note_period_hi,X
	ora #$80
	sta ram_note_period_hi,X

	; TODO Remove these, just execute them sequentially
	jsr sub_start_volume_envelope
	jsr sub_start_duty_envelope
	jsr sub_start_pitch_envelope
	jsr sub_start_arpeggio

	rts

; -----------------------------------------------------------------------------

; Reads the first byte of a volume envelope
sub_start_volume_envelope:
	lda ram_cur_apu_channel
	and #$0F
	tax
	
	cpx #$02
	bne :+
		; Start playing triangle channel immediately
		lda #$FF
		sta TrgLinear_4008
		and #$0F
		sta ram_apu_output_volume+2
		rts
	:
	cpx #$04
	bmi :+
		; DPCM channel: return immediately
		rts
; ----------------
	:
	ldx ram_cur_channel_offset
	ldy ram_cur_chan_ptr_offset
	
	; Get envelope index from RAM
	lda ram_vol_env_idx,X
	cmp #$FF	; Skip if index is $FF
	beq @skip_vol_env_start

		asl A
		tax

		; Prepare pointer
		lda tbl_vol_env_ptrs+0,X
		sta ram_vol_env_ptr_lo,Y
		sta zp_sndptr_lo

		lda tbl_vol_env_ptrs+1,X
		sta ram_vol_env_ptr_hi,Y
		sta zp_sndptr_hi

		ldx ram_cur_channel_offset

		; Read first byte (duration)
		ldy #$00
		lda (zp_sndptr_lo),Y
		sta ram_cur_vol_env_duration,X

	@skip_vol_env_start:
	rts

; -----------------------------------------------------------------------------

; Reads the first byte of a duty envelope
sub_start_duty_envelope:
	lda ram_cur_apu_channel
	and #$0F
	tax
	cpx #$02	; Only pulse channels (0-1) can use this envelope
	bmi :+

		rts
; ----------------
:
	ldx ram_cur_channel_offset
	ldy ram_cur_chan_ptr_offset

	lda ram_duty_env_idx,X
	cmp #$FF
	beq @skip_duty_env_start

		asl A
		tax
		lda tbl_duty_env_ptrs+0,X
		sta ram_duty_env_ptr_lo,Y
		sta zp_sndptr_lo
		lda tbl_duty_env_ptrs+1,X
		sta ram_duty_env_ptr_hi,Y
		sta zp_sndptr_hi
		;ldx ram_cur_channel_offset
		;ldy #$00
		;lda (zp_sndptr_lo),Y
		;sta ram_cur_duty_env_duration,X

	@skip_duty_env_start:
	rts

; -----------------------------------------------------------------------------

; Reads the first byte of a pitch envelope
sub_start_pitch_envelope:
	lda ram_cur_apu_channel
	and #$0F
	;tax
	;cpx #$03	; Only for channels 0-2
	;bmi :+
	cmp #$03
	bcs @skip_pitch_env_start

		ldx ram_cur_channel_offset
		ldy ram_cur_chan_ptr_offset

		lda ram_pitch_env_idx,X
		cmp #$FF
		beq @skip_pitch_env_start

			asl A
			tax

			lda tbl_pitch_env_ptrs+0,X
			sta ram_pitch_env_ptr_lo,Y
			sta zp_sndptr_lo

			lda tbl_pitch_env_ptrs+1,X
			sta ram_pitch_env_ptr_hi,Y
			sta zp_sndptr_hi

			ldx ram_cur_channel_offset

			; Read first byte (duration)
			ldy #$00
			lda (zp_sndptr_lo),Y
			sta ram_cur_pitch_env_duration,X

	@skip_pitch_env_start:
	rts

; -----------------------------------------------------------------------------

; Reads and processes the first byte of an arpeggio (type flag)
; Call when an actual note starts (not on a rest or hold)
; Returns:
; A = arpeggio index with type flag, or $FF if no arpeggio
sub_start_arpeggio:
	lda ram_cur_apu_channel
	and #$0F
	cmp #$04
	beq @arpeggio_disabled	; No arpeggio for DMC

		tax
		ldx ram_cur_channel_offset
		ldy ram_cur_chan_ptr_offset

		lda ram_cur_note_idx,X
		bne :+
			; This is a rest: disable arpeggio
			lda #$FF
			sta ram_arpeggio_idx
			rts
		:
		lda ram_arpeggio_idx,X
		cmp #$FF
		beq @arpeggio_disabled

			asl A
			tax

			; Prepare and save pointer
			lda tbl_arp_ptrs+0,X
			sta ram_arpeggio_ptr_lo,Y
			sta zp_sndptr_lo

			lda tbl_arp_ptrs+1,X
			sta ram_arpeggio_ptr_hi,Y
			sta zp_sndptr_hi

			; Read first byte (type flag)
			ldy #$00
			lda (zp_sndptr_lo),Y
			ldx ram_cur_channel_offset
			ora ram_arpeggio_idx,X
			sta ram_arpeggio_idx,X

	@arpeggio_disabled:
	rts

; -----------------------------------------------------------------------------

; Returns:
; A = next byte of track data
; X = current channel offset
sub_track_read_next_byte:
	ldx ram_cur_chan_ptr_offset
	lda ram_track_ptr_lo,X
	sta zp_sndptr_lo
	lda ram_track_ptr_hi,X
	sta zp_sndptr_hi
	jsr sub_advance_track_ptr
	ldy #$00
	lda (zp_sndptr_lo),Y
	ldx ram_cur_channel_offset
	rts

; -----------------------------------------------------------------------------

; Processes the next event in each envelope for the current channel
sub_advance_envelopes:
	; This could be removed by simply eliminating all RTS except the last
	jsr sub_next_volume_envelope
	jsr sub_next_duty_envelope
	jsr sub_next_pitch_envelope
	rts

; -----------------------------------------------------------------------------

; Moves to the next entry in a volume envelope table and reads its duration
sub_next_volume_envelope:
	lda ram_cur_apu_channel
	and #$0F
	tax
	cpx #$04
	bpl @skip_volume_env	; Is this supposed to skip DPCM channels?

	@next_volume_env:
	ldx ram_cur_channel_offset

	lda ram_cur_vol_env_duration,X
	cmp #$FF
	beq @skip_volume_env	; Duration = $FF disables the envelope entirely

		ldx ram_cur_channel_offset	; Why? It's already in X
		lda ram_cur_vol_env_duration,X	; And this is already in A
		bne @vol_env_still_running

			; Move to next event in envelope and prepare pointer
			ldx ram_cur_chan_ptr_offset
			lda #$02	; Each event is two bytes long (duration, value)
			clc
			adc ram_vol_env_ptr_lo,X
			sta ram_vol_env_ptr_lo,X
			sta zp_sndptr_lo
			lda #$00
			adc ram_vol_env_ptr_hi,X
			sta ram_vol_env_ptr_hi,X
			sta zp_sndptr_hi

			ldx ram_cur_channel_offset
			ldy #$00
			lda (zp_sndptr_lo),Y
			sta ram_cur_vol_env_duration,X
			tay					; Same as above
			cpy #$FF
			bne @next_volume_env

				; Found $FF at end of envelope data
				ldx ram_cur_chan_ptr_offset
				iny ;ldy #$01	; Read next byte (which is the last)
				lda (zp_sndptr_lo),Y
				asl A	; Since each entry is two bytes long, the offset is multiplied x2
				bpl @read_new_vol_env_duration

					; A negative value will move the pointer back
					clc
					adc ram_vol_env_ptr_lo,X
					sta ram_vol_env_ptr_lo,X
					sta zp_sndptr_lo
					bcs :+
						dec ram_vol_env_ptr_hi,X
					:
					lda ram_vol_env_ptr_hi,X
					sta zp_sndptr_hi

				@read_new_vol_env_duration:
				ldx ram_cur_channel_offset
				ldy #$00
				lda (zp_sndptr_lo),Y	; If we didn't change the pointer, this will re-read $FF
				sta ram_cur_vol_env_duration,X
				rts

		@vol_env_still_running:
		; Current value still running, or we just started a new one:
		; decrease duration and return
		dec ram_cur_vol_env_duration,X
		
	@skip_volume_env:
	rts

; -----------------------------------------------------------------------------

; Moves to the next entry in a duty envelope table
sub_next_duty_envelope:
	lda ram_cur_apu_channel
	and #$0F
	tax
	cpx #$02	; Only for square wave channels
	bpl @skip_duty_env

		; First, make sure this channel is using a duty envelope
		ldx ram_cur_chan_ptr_offset
		lda ram_duty_env_idx,X
		cmp #$FF
		beq @skip_duty_env

			; Add one to the pointer
			lda #$01
			clc
			adc ram_duty_env_ptr_lo,X
			sta ram_duty_env_ptr_lo,X
			sta zp_sndptr_lo
			; Take care of the high byte
			lda #$00
			adc ram_duty_env_ptr_hi,X
			sta ram_duty_env_ptr_hi,X
			sta zp_sndptr_hi

			; Read the next byte
			ldy #$00
			lda (zp_sndptr_lo),Y
			cmp #$FF	; End of envelope: check for loops
			bne @skip_duty_env	; Otherwise, we are done

				iny
				lda (zp_sndptr_lo),Y
				; The last value is how many bytes to move back
				; Note: this is expected to be an signed, negative 8-bit value
				clc
				adc ram_duty_env_ptr_lo,X
				sta ram_duty_env_ptr_lo,X
				sta zp_sndptr_lo
				bcs :+
					dec ram_duty_env_ptr_hi,X
					dec zp_sndptr_hi
				:
	@skip_duty_env:
	rts

; -----------------------------------------------------------------------------

; Updates the pitch envelope current value's duration and, if needed, moves
; the pointer to the next entry the envelope's table
sub_next_pitch_envelope:
	lda ram_cur_apu_channel
	and #$0F
	tax
	cpx #$03	; Only applies to Square and Triangle channels
	bpl @skip_pitch_env

		@next_pitch_env:
		ldx ram_cur_channel_offset
		lda ram_pitch_env_idx,X
		cmp #$FF
		beq @skip_pitch_env

			lda ram_cur_pitch_env_duration,X
			bne @pitch_env_still_running

				; Advance pointer 2 bytes to get to the next entry
				ldx ram_cur_chan_ptr_offset
				lda #$02
				clc
				adc ram_pitch_env_ptr_lo,X
				sta ram_pitch_env_ptr_lo,X
				sta zp_sndptr_lo
				lda #$00
				adc ram_pitch_env_ptr_hi,X
				sta ram_pitch_env_ptr_hi,X
				sta zp_sndptr_hi

				; Read new entry's duration
				ldx ram_cur_channel_offset
				ldy #$00
				lda (zp_sndptr_lo),Y
				sta ram_cur_pitch_env_duration,X
				cmp #$FF	; If it's not the special termination marker, we're done
				bne @pitch_env_still_running

					; Duration byte = $FF (end of data), read last byte
					ldx ram_cur_chan_ptr_offset
					iny	;ldy #$01
					lda (zp_sndptr_lo),Y
					;asl A
					bmi :+
						; A zero (or positive) value signals the end of the envelope
						lda #$FF
						ldx ram_cur_channel_offset
						sta ram_pitch_env_idx,X
						rts
					:
					; A negative value indicates a loop offset
					clc
					adc ram_pitch_env_ptr_lo,X
					sta ram_pitch_env_ptr_lo,X
					sta zp_sndptr_lo
					bcs :+
						dec ram_pitch_env_ptr_hi,X
					:
					lda ram_pitch_env_ptr_hi,X
					sta zp_sndptr_hi

					; After moving the pointer back to the loop point,
					; read the byte there and store it as the new duration
					ldx ram_cur_channel_offset
					dey ;ldy #$00
					lda (zp_sndptr_lo),Y
					sta ram_cur_pitch_env_duration,X
					; jmp @next_pitch_env

			@pitch_env_still_running:
			dec ram_cur_pitch_env_duration,X
	@skip_pitch_env:
	rts

; -----------------------------------------------------------------------------

sub_note_slide_effect:
	lda ram_note_slide_counter,X
	beq @no_slide	; Counter = 0 means no slide (or already done)

		; Decrease counter
		dec ram_note_slide_counter,X
		; Decrease period by fixed amount
		sec
		lda ram_base_period_lo,Y
		sbc #$05
		sta ram_base_period_lo,Y
		lda ram_base_period_hi,Y
		sbc #$00
		sta ram_base_period_hi,Y

	@no_slide:
	rts

; -----------------------------------------------------------------------------

; Applies envelopes, notes and effects to all channels
sub_sound_output:
	; TODO Just remove all RTS and there is no need for JSR
	jsr sub_sq0_output
	jsr sub_sq1_output
	jsr sub_trg_output
	jsr sub_noise_output
	rts

; -----------------------------------------------------------------------------

sub_sq0_output:
	ldx #$80		; SFX indices
	ldy #$80
	lda ram_sfx0_data_ptr_lo
	ora ram_sfx0_ptr_data_hi
	bne :+

		ldx #$00	; Music indices
		ldy #$00
		jsr sub_note_slide_effect
	:
	jsr sub_get_volume_envelope
	lda zp_sndptr_lo

	pha
	jsr sub_get_duty_envelope
	pla

	ora zp_sndptr_lo
	ora #$30
	sta Sq0Duty_4000
	and #$0F
	sta ram_apu_output_volume+0

	jsr sub_get_pitch_envelope

	; Use the pointer variable as low/high pitch bytes
	lda #$00
	sta zp_sndptr_hi
	; If the low byte is negative, set the high byte to $FF
	; to obtain a 16-bit signed negative value
	lda zp_sndptr_lo
	bpl :+
		dec zp_sndptr_hi
	:
	; Now add the low byte to the base period
	lda ram_base_period_lo,Y
	clc
	adc zp_sndptr_lo
	; TODO For relative envelopes, also modify the base note period
	sta ram_note_period_lo,Y
	; Immediately apply the new value
	sta Sq0Timer_4002

	; Check if we need to update the high byte
	lda ram_note_period_hi,Y
	sta zp_sndptr_lo	; Save the old value here
	lda ram_base_period_hi,Y
	adc zp_sndptr_hi	; Add the modifier
	tax					; Compare with the old value, using X to preserve
	cpx zp_sndptr_lo	; the modified value in case we need to store it
	beq :+

		; TODO For relative envelopes, also modify the base note period
		sta ram_note_period_hi,Y
		ora #$F8
		sta Sq0Length_4003
	:
	rts

; -----------------------------------------------------------------------------

sub_sq1_output:
	ldx #$81		; SFX indices
	ldy #$82
	lda ram_sfx1_data_ptr_lo
	ora ram_sfx1_data_ptr_hi
	bne :+

		ldx #$01	; Music indices
		ldy #$02
		jsr sub_note_slide_effect
	:
	jsr sub_get_volume_envelope
	lda zp_sndptr_lo

	pha
	jsr sub_get_duty_envelope
	pla

	ora zp_sndptr_lo
	ora #$30
	sta Sq1Duty_4004
	and #$0F
	sta ram_apu_output_volume+1
	jsr sub_get_pitch_envelope
	lda #$00
	sta zp_sndptr_hi
	lda zp_sndptr_lo
	bpl :+

		dec zp_sndptr_hi
:
	lda ram_base_period_lo,Y
	clc
	adc zp_sndptr_lo
	sta ram_note_period_lo,Y
	sta Sq1Timer_4006
	lda ram_note_period_hi,Y
	sta zp_sndptr_lo
	lda ram_base_period_hi,Y
	adc zp_sndptr_hi
	tax
	cpx zp_sndptr_lo
	beq :+

		sta ram_note_period_hi,Y
		ora #$F8
		sta Sq1Length_4007
:
	rts

; -----------------------------------------------------------------------------

sub_trg_output:
	ldx #$82		; SFX indices
	ldy #$84
	lda ram_sfx2_data_ptr_lo
	ora ram_sfx2_data_ptr_hi
	bne :+

		ldx #$02	; Music indices
		ldy #$04
	:

	; ---- Don't waste time with volume envelopes on this channel
	;		Just assume it's on when playing a note
	;jsr sub_get_volume_envelope
	;lda zp_sndptr_lo
	;beq :+
		; This will only turn on the channel when the volume envelope is not zero
	;	lda #$FF
	;:
	;ora #$80
	;sta TrgLinear_4008
	; ----

	; Apply arpeggio (if needed) before reading pitch values
	; That is because the arpeggio can modify them, and we apply other effects
	; (such as pitch envelopes/vibrato) to that new value
	jsr sub_apply_arpeggio_pitch

	jsr sub_get_pitch_envelope
	lda #$00
	sta zp_sndptr_hi
	lda zp_sndptr_lo
	bpl :+

		dec zp_sndptr_hi
	:
	lda ram_base_period_lo,Y
	clc
	adc zp_sndptr_lo
	sta ram_note_period_lo,Y
	sta TrgTimer_400A
	lda ram_note_period_hi,Y
	sta zp_sndptr_lo
	lda ram_base_period_hi,Y
	adc zp_sndptr_hi
	tax
	cpx zp_sndptr_lo
	beq :+

		sta ram_note_period_hi,Y
		ora #$F8
		sta TrgLength_400B
	:
	rts

; -----------------------------------------------------------------------------

sub_noise_output:
	ldx #$83		; SFX indices
	ldy #$86
	lda ram_sfx3_data_ptr_lo
	ora ram_sfx3_data_ptr_hi
	bne :+

		ldx #$03	; Music indices
		ldy #$06
	:
	jsr sub_get_volume_envelope
	lda zp_sndptr_lo
	ora #$30
	sta NoiseVolume_400C
	and #$0F
	sta ram_apu_output_volume+3

	; This will change the base period if needed
	jsr sub_apply_arpeggio_noise

	lda ram_base_period_lo,Y
	sta NoisePeriod_400E
	lda #$F8
	sta NoiseLength_400F
	
	rts

; -----------------------------------------------------------------------------

; Returns:
; zp_sndptr_lo: current value of volume envelope
sub_get_volume_envelope:
	tya
	pha

	lda ram_cur_vol_env_duration,X
	tay		; No need to put this in Y, it's not used
	cpy #$FF
	bne :+

		lda #$00
		jmp @B262
:
	pla
	pha
	tay
	lda ram_vol_env_ptr_lo,Y
	sta zp_sndptr_lo
	lda ram_vol_env_ptr_hi,Y
	sta zp_sndptr_hi
	ldy #$01
	lda (zp_sndptr_lo),Y
	@B262:
	sta zp_sndptr_lo

	pla
	tay
	rts

; -----------------------------------------------------------------------------

; Returns:
; zp_sndptr_lo: current value of duty envelope
sub_get_duty_envelope:
	tya
	pha

	lda ram_duty_env_idx,X
	cmp #$FF
	bne :+

		; An index of $FF disables the envelope
		lda #$00
		jmp @duty_env_done

	:
	pla
	pha

	; Read current value
	tay
	lda ram_duty_env_ptr_lo,Y
	sta zp_sndptr_lo
	lda ram_duty_env_ptr_hi,Y
	sta zp_sndptr_hi
	ldy #$00
	lda (zp_sndptr_lo),Y
	@duty_env_done:
	sta zp_sndptr_lo

	pla
	tay
	rts

; -----------------------------------------------------------------------------

; Returns:
; zp_sndptr_lo: current value of pitch envelope
sub_get_pitch_envelope:
	tya
	pha

	lda ram_cur_pitch_env_duration,X
	tay
	cpy #$FF
	bne :+

		lda #$00
		jmp @B2AC
:
	pla
	pha
	tay
	; Get pointer to current envelope entry
	lda ram_pitch_env_ptr_lo,Y
	sta zp_sndptr_lo
	lda ram_pitch_env_ptr_hi,Y
	sta zp_sndptr_hi
	; Read value (second byte, the first is duration)
	ldy #$01
	lda (zp_sndptr_lo),Y

	@B2AC:
	sta zp_sndptr_lo	; Use this as noise period modifier

	pla
	tay
	rts

; -----------------------------------------------------------------------------

; Parameters:
; X = current channel data offset
; Y = current channel pointer offset
; Returns:
; C = set if end of data reached, clear if not
; zp_sndptr_lo = next value from arpeggio table (or $7F if disabled)
sub_get_next_arpeggio_value:
	tya
	pha	; Preserve Y

	; Advance pointer
	lda ram_arpeggio_ptr_lo,Y
	clc
	adc #$01
	sta ram_arpeggio_ptr_lo,Y
	sta zp_sndptr_lo
	lda #$00
	adc ram_arpeggio_ptr_hi,Y
	sta ram_arpeggio_ptr_hi,Y
	sta zp_sndptr_hi

	; Read the entry and check if it's an end of data token
	ldy #$00
	lda (zp_sndptr_lo),Y
	sta zp_sndptr_lo
	cmp #$7F
	bne @arp_end
		; End of data reached
		; Move the pointer back one byte to "loop" the end token
		pla
		tay
		lda #$FF
		dcp ram_arpeggio_ptr_lo,Y
		bne :+
			clc
			adc ram_arpeggio_ptr_hi,Y
			sta ram_arpeggio_ptr_hi,Y
		:
		sec
		rts
	@arp_end:
	pla
	tay
	clc
	rts

; -----------------------------------------------------------------------------

; Increments the track data pointer by one
sub_advance_track_ptr:
	ldx ram_cur_chan_ptr_offset

	inc ram_track_ptr_lo,X
	lda ram_track_ptr_lo,X
	bne :+

		inc ram_track_ptr_hi,X
:
	rts

; -----------------------------------------------------------------------------

; Period table (NTSC)
tbl_pitches:
	.word $0000	; $00	(rest)
	.word $0000	; $01	(hold note)
	.word $0000	; $02	N/A
	.word $0000	; $03	N/A
	.word $0000	; $04	N/A
	.word $0000	; $05	N/A
	.word $0000	; $06	N/A
	.word $0000	; $07	N/A
	.word $0000	; $08	N/A
	.word $07F1	; $09	A0
	.word $0780	; $0A	A#0
	.word $0712	; $0B	B0

	.word $06AD	; $0C	C1
	.word $064D	; $0D	C#1
	.word $05F3	; $0E	D1
	.word $059D	; $0F	D#1
	.word $054D	; $10	E1
	.word $0500	; $11	F1
	.word $04B8	; $12	F#1
	.word $0475	; $13	G1
	.word $0435	; $14	G#1
	.word $03F8 ; $15	A1
	.word $03BF	; $16	A#1
	.word $0389	; $17	B1
	
	.word $0356	; $18	C2
	.word $0326	; $19	C#2
	.word $02F9 ; $1A	D2
	.word $02CE	; $1B	D#2
	.word $02A6	; $1C	E2
	.word $027F	; $1D	F2
	.word $025C	; $1E	F#2
	.word $023A	; $1F	G2
	.word $021A	; $20	G#2
	.word $01FB	; $21	A2
	.word $01DF	; $22	A#2
	.word $01C4	; $23	B2

	.word $01AB	; $24	C3
	.word $0193	; $25	C#3
	.word $017C	; $26	D3
	.word $0167	; $27	D#3
	.word $0152	; $28	E3
	.word $013F	; $29	F3
	.word $012D	; $2A	F#3
	.word $011C	; $2B	G3
	.word $010C	; $2C	G#3
	.word $00FD	; $2D	A3
	.word $00EF	; $2E	A#3
	.word $00E2	; $2F	B3

	.word $00D2	; $30	C4
	.word $00C9	; $31	C#4
	.word $00BD	; $32	D4
	.word $00B3	; $33	D#4
	.word $00A9	; $34	E4
	.word $009F	; $35	F4
	.word $0096	; $36	F#4
	.word $008E	; $37	G4
	.word $0086	; $38	G#4
	.word $007E	; $39	A4
	.word $0077	; $3A	A#4
	.word $0070	; $3B	B4

	.word $006A	; $3C	C5
	.word $0064	; $3D	C#5
	.word $005E	; $3E	D5
	.word $0059	; $3F	D#5
	.word $0054	; $40	E5
	.word $004F	; $41	F5
	.word $004B	; $42	F#5
	.word $0046	; $43	G5
	.word $0042	; $44	G#5
	.word $003F	; $45	A5
	.word $003B	; $46	A#5
	.word $0038	; $47	B5

	.word $0034	; $48	C6
	.word $0031	; $49	C#6
	.word $002F	; $4A	D6
	.word $002C	; $4B	D#6
	.word $0029	; $4C	E6
	.word $0027	; $4D	F6
	.word $0025	; $4E	F#6
	.word $0023	; $4F	G6
	.word $0021	; $50	G#6
	.word $001F	; $51	A6
	.word $001D	; $52	A#6
	.word $001B	; $53	B6

	.word $001A	; $54	C7
	.word $0018	; $55	C#7
	.word $0017	; $56	D7
	.word $0015	; $57	D#7
	.word $0014	; $58	E7
	.word $0013	; $59	F7
	.word $0012	; $5A	F#7
	.word $0011	; $5B	G7
	.word $0010	; $5C	G#7
	.word $000F	; $5D	A7
	.word $000E	; $5E	A#7
	.word $000D	; $5F	B7

; -----------------------------------------------------------------------------

; Value for DPCM address register
tbl_dpcm_ptr:
	.byte $FF					; $00 (rest)
	.byte $FF					; $01 (hold)
	.byte >(dmc_fight<<2)		; $02 "Fight!"
	.byte >(dmc_rayden<<2)		; $03 "Rayden"
	.byte >(dmc_sonya<<2)		; $04 "Sonya"
	.byte >(dmc_subzero<<2)		; $05 "Sub-Zero"
	.byte >(dmc_scorpion<<2)	; $06 "Scorpion"
	.byte >(dmc_kano<<2)		; $07 "Kano"
	.byte >(dmc_cage<<2)		; $08 "Johnny Cage"
	.byte >(dmc_liukang<<2)		; $09 "Liu Kang"
	.byte $FF;>(dmc_wins<<2)		; $0A "...wins"
	.byte >(dmc_bleep<<2)		; $0B UI bleep
	.byte >(dmc_swing<<2)		; $0C SFX punch/kick swing
	.byte >(dmc_hit<<2)			; $0D SFX hit
	.byte >(dmc_hit<<2)			; $0E SFX bounce	TODO

; Values for DPCM length register
tbl_dpcm_len:
	.byte $00	; $00 (rest)
	.byte $00	; $01 (hold)
	.byte $48	; $02 "Fight!"
	.byte $47	; $03 "Rayden"
	.byte $58	; $04 "Sonya"
	.byte $85	; $05 "Sub-Zero"
	.byte $77	; $06 "Scorpion"
	.byte $4B	; $07 "Kano"
	.byte $7C	; $08 "Johnny Cage"
	.byte $73	; $09 "Liu Kang"
	.byte $53	; $0A "...wins"
	.byte $0B	; $0B UI bleep
	.byte $08	; $0C SFX punch/kick swing
	.byte $0F	; $0D SFX hit
	.byte $08	; $0E SFX bounce	TODO

; Values for DPCM frequency register
tbl_dpcm_freq:
	.byte $00	; $00 (rest)
	.byte $00	; $01 (hold)
	.byte $0C	; $02 "Fight!"
	.byte $0C	; $03 "Rayden"
	.byte $0C	; $04 "Sonya"
	.byte $0C	; $05 "Sub-Zero"
	.byte $0C	; $06 "Scorpion"
	.byte $0C	; $07 "Kano"
	.byte $0C	; $08 "Johnny Cage"
	.byte $0C	; $09 "Liu Kang"
	.byte $0C	; $0A "...wins"
	.byte $0A	; $0B UI bleep
	.byte $08	; $0C SFX punch/kick swing
	.byte $08	; $0D SFX hit
	.byte $0A	; $0E SFX bounce	TODO

; -----------------------------------------------------------------------------

.include "audio/instruments.asm"
