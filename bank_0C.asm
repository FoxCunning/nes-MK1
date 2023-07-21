.segment "BANK_0C"
; $8000-$9FFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"


; -----------------------------------------------------------------------------

; Data pointers for Goro
rom_0C_8000:
	.word rom_8004, rom_82CD

; -----------------------------------------------------------------------------

rom_8004:
	.byte $1D
	.word anim_goro_idle
	.byte $1D
	.word anim_goro_idle
	.byte $1D
	.word anim_goro_idle
	.byte $01
	.word rom_80BB
	.byte $03
	.word rom_80C5
	.byte $08
	.word rom_80CF
	.byte $02
	.word rom_80D7
	.byte $05
	.word rom_80E3
	.byte $04
	.word rom_80F3
	.byte $07
	.word rom_8103
	.byte $07
	.word rom_810B
	.byte $00
	.word rom_8155
	.byte $00
	.word rom_8155
	.byte $00
	.word rom_8155
	.byte $02
	.word rom_815D
	.byte $02
	.word rom_8169
	.byte $00
	.word rom_8155
	.byte $02
	.word rom_815D
	.byte $02
	.word rom_8169
	.byte $00
	.word rom_8155
	.byte $00
	.word rom_8155
	.byte $05
	.word rom_8181
	.byte $02
	.word rom_8182
	.byte $05
	.word rom_81AF
	.byte $2A
	.word rom_8193
	.byte $05
	.word rom_819F
	.byte $05
	.word rom_81AF
	.byte $05
	.word rom_81BF
	.byte $05
	.word rom_81CF
	.byte $05
	.word rom_81DF
	.byte $18
	.word rom_81E0
	.byte $04
	.word rom_81FE
	.byte $04
	.word rom_820E
	.byte $04
	.word rom_821E
	.byte $04
	.word rom_822E
	.byte $04
	.word rom_823E
	.byte $04
	.word rom_823F
	.byte $06
	.word rom_8240
	.byte $0E
	.word rom_8241
	.byte $08
	.word anim_goro_staggered
	.byte $10
	.word rom_8254
	.byte $08
	.word rom_8268
	.byte $08
	.word rom_826E
	.byte $07
	.word rom_80B3
	.byte $07
	.word rom_80CF
	.byte $0F
	.word rom_8276
	.byte $0D
	.word rom_8277
	.byte $14
	.word rom_828C
	.byte $0D
	.word rom_8277
	.byte $29
	.word rom_828C
	.byte $19
	.word rom_8277 ;rom_8298
	.byte $18
	.word anim_special_hit ;rom_82A7
	.byte $04
	.word rom_80F3

; -----------------------------------------------------------------------------

anim_goro_idle:
	.byte $00, $00, $00, $01, $01, $01, $38, $38
	.byte $38, $39, $39, $39, $02, $02, $02, $02
	.byte $03, $03, $03, $03, $03, $03, $03, $03
rom_80BB:
	.byte $04, $05, $06, $07, $08, $04, $05, $06
	.byte $07, $08
rom_80C5:
	.byte $04, $05, $06, $07, $08, $04, $05, $06
	.byte $07, $08
rom_80CF:
	.byte $09, $09, $09, $09, $09, $09, $09, $09
rom_80D7:
	.byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A
	.byte $0A, $0A, $0A, $0A
rom_80E3:
	.byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A
	.byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A
rom_80F3:
	.byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A
	.byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A
	
; Also use the next two, for a total of 30 frames
anim_special_hit:
	.byte $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E
	.byte $0E, $0E, $0E, $0E, $0E, $0E
rom_8103:
	.byte $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E
rom_810B:
	.byte $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E
    ; Potentially unused
	.byte $0F, $0F, $10, $10, $0F, $0F, $31, $31
	.byte $31, $31, $34, $34, $35, $35, $36, $36
	.byte $34, $34, $35, $35, $36, $36, $32, $32
	.byte $32, $32, $32, $33, $33, $33, $33, $33
	.byte $33, $33, $33, $33, $33, $33, $33, $33
	.byte $33, $33, $11, $11, $11, $12, $12, $13
	.byte $13, $13, $12, $12, $11, $11, $11, $11
	.byte $11, $11, $11, $12, $12, $12, $12, $13
	.byte $13, $13
rom_8155:
	.byte $14, $14, $15, $15, $16, $16, $15, $15
rom_815D:
	.byte $0A, $0A, $0A, $0A, $0A, $17, $17, $17
	.byte $0A, $0A, $0A, $0A
rom_8169:
	.byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A
	.byte $0A, $17, $17, $17, $18, $18, $1A, $1A
	.byte $19, $19, $1A, $1A, $1B, $1B, $02, $02
rom_8181:
	.byte $00
rom_8182:
	.byte $00, $2F, $2F, $30, $30, $30, $30, $30
	.byte $30, $30, $30, $0C, $0C, $0D, $0D, $0C
	.byte $0C
rom_8193:
	.byte $1C, $1C, $1C, $1C, $1D, $1D, $1D, $1D
	.byte $1E, $1E, $1E, $1E
rom_819F:
	.byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A
	.byte $17, $17, $17, $17, $0A, $0A, $0A, $0A
rom_81AF:
	.byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A
	.byte $0A, $0A, $0A, $0A, $17, $17, $17, $0A
rom_81BF:
	.byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A
	.byte $17, $17, $17, $17, $0A, $0A, $0A, $0A
rom_81CF:
	.byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A
	.byte $0A, $0A, $0A, $0A, $17, $17, $17, $0A
rom_81DF:
	.byte $00
rom_81E0:
	.byte $32, $32, $32, $32, $33, $33, $33, $33
	.byte $33, $33, $33, $33, $33, $33, $33, $33
	.byte $33, $33, $33, $33, $33, $33, $33, $33
	.byte $33, $33, $33, $33, $33, $33
rom_81FE:
	.byte $0A, $0A, $0A, $0A, $17, $17, $17, $17
	.byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A
rom_820E:
	.byte $17, $17, $17, $0A, $0A, $0A, $0A, $0A
	.byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A
rom_821E:
	.byte $0A, $0A, $0A, $0A, $17, $17, $17, $17
	.byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A
rom_822E:
	.byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A
	.byte $0A, $0A, $17, $17, $17, $17, $0A, $0A
rom_823E:
	.byte $00
rom_823F:
	.byte $00
rom_8240:
	.byte $21
rom_8241:
	.byte $25, $25, $25, $25, $25, $25, $25, $26
	.byte $26, $26, $26, $26, $26
anim_goro_staggered:
	.byte $27, $27, $28, $28, $29, $29
rom_8254:
	.byte $2A, $2A, $2A, $2A, $2B, $2B, $2B, $2B
	.byte $2A, $2A, $2A, $2A, $2B, $2B, $2B, $2B
	.byte $2A, $2A, $2A, $2A
rom_8268:
	.byte $2C, $2C, $2C, $2C, $2C, $2C
rom_826E:
	.byte $2D, $2D, $2D, $2D, $2E, $2E, $03, $09
rom_8276:
	.byte $37
rom_8277:
	.byte $22, $22, $22, $23, $23, $23, $24, $24
	.byte $24, $24, $24, $24, $24, $24, $24, $24
	.byte $24, $24, $24, $00, $00
rom_828C:
	.byte $3A, $3A, $3A, $3B, $3B, $3B, $3C, $3C
	.byte $23, $23, $23, $23
rom_8298:
	.byte $37, $37, $37, $37, $37, $37, $37, $37
	.byte $37, $37, $37, $37, $37, $37, $37
rom_82A7:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00
rom_80B3:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00

; -----------------------------------------------------------------------------

rom_82CD:
	.word rom_8397, rom_83BC, rom_83E1, rom_83FE
	.word rom_842B, rom_8450, rom_8475, rom_849E
	.word rom_84C3, rom_84F0, rom_851D, rom_854F
	.word rom_8578, rom_858D, rom_85A2, rom_85CF
	.word rom_85FC, rom_8647, rom_8674, rom_86B1
	.word rom_86F5, rom_8732, rom_875F, rom_879C
	.word rom_87D9, rom_87FA, rom_8827, rom_8862
	.word rom_8891, rom_88CC, rom_8901, rom_8929
	.word rom_8951, rom_8986, rom_89B3, rom_89DC
	.word rom_8A04, rom_8A21, rom_8A3E, rom_8A5B
	.word rom_8A7E, rom_8AA1, rom_8AD0, rom_8AF5
	.word rom_8B1A, rom_8B4F, rom_8B84, rom_8BB1
	.word rom_8BDE, rom_8C01, rom_8C33, rom_8C60
	.word rom_8C9D, rom_8CBE, rom_8CFF, rom_8D1F
	.word rom_8D1F, rom_8D4C, rom_8D79, rom_8DA6
	.word rom_8DCF, rom_8397, rom_8397, rom_8397
	.word rom_8397, rom_8397, rom_8397, rom_8397
	.word rom_8397, rom_8397, rom_8397, rom_8397
	.word rom_8397, rom_8397, rom_8397, rom_8397
	.word rom_8397, rom_8397, rom_8397, rom_8397
	.word rom_8397, rom_8397, rom_8397, rom_8397
	.word rom_8397, rom_8397, rom_8397, rom_8397
	.word rom_8397, rom_8397, rom_8397, rom_8397
	.word rom_8397, rom_8397, rom_8397, rom_8397
	.word rom_8397, rom_8397, rom_8397, rom_8397
	.word rom_8397

; -----------------------------------------------------------------------------

rom_8397:
	.byte $04, $08, $08, $CC, $00, $FF, $0B, $0C
	.byte $FF, $1D, $1E, $1F, $20, $31, $32, $33
	.byte $34, $45, $46, $47, $48, $52, $53, $54
	.byte $55, $5F, $60, $61, $FF, $6E, $6F, $70
	.byte $FF, $7D, $7E, $7F, $FF
rom_83BC:
	.byte $04, $08, $08, $CE, $00, $FF, $80, $81
	.byte $FF, $88, $89, $8A, $8B, $99, $9A, $9B
	.byte $9C, $AC, $AD, $AE, $AF, $BD, $BE, $BF
	.byte $C0, $CB, $CC, $CD, $FF, $D7, $D8, $D9
	.byte $FF, $E4, $E5, $E6, $E7
rom_83E1:
	.byte $04, $06, $10, $02, $00, $FF, $AC, $AD
	.byte $FF, $BB, $BC, $BD, $BE, $CB, $CC, $CD
	.byte $CE, $D8, $D9, $DA, $DB, $E1, $E2, $E3
	.byte $E4, $E9, $EA, $FF, $EB
rom_83FE:
	.byte $05, $08, $10, $CE, $00, $FF, $86, $87
	.byte $FF, $FF, $95, $96, $97, $98, $F4, $A7
	.byte $A8, $A9, $AA, $AB, $B9, $BA, $BB, $BC
	.byte $FF, $FF, $C8, $C9, $CA, $FF, $FF, $D4
	.byte $D5, $D6, $FF, $E1, $E2, $E3, $FF, $FF
	.byte $F0, $F1, $F2, $F3, $FF
rom_842B:
	.byte $04, $08, $10, $CC, $00, $FF, $03, $04
	.byte $FF, $0D, $0E, $0F, $10, $21, $22, $23
	.byte $24, $35, $36, $37, $38, $FF, $49, $4A
	.byte $4B, $56, $57, $58, $FF, $62, $63, $64
	.byte $FF, $71, $72, $73, $FF
rom_8450:
	.byte $04, $08, $10, $CC, $00, $FF, $05, $06
	.byte $FF, $11, $12, $13, $14, $25, $26, $27
	.byte $28, $39, $3A, $3B, $3C, $FF, $4C, $4D
	.byte $FF, $FF, $59, $5A, $FF, $65, $66, $67
	.byte $FF, $74, $75, $76, $FF
rom_8475:
	.byte $04, $09, $10, $CC, $00, $FF, $01, $02
	.byte $FF, $FF, $07, $08, $FF, $15, $16, $17
	.byte $18, $29, $2A, $2B, $2C, $3D, $3E, $3F
	.byte $40, $FF, $4E, $4F, $FF, $FF, $5B, $5C
	.byte $FF, $68, $69, $6A, $FF, $77, $78, $79
	.byte $FF
rom_849E:
	.byte $04, $08, $10, $CC, $00, $FF, $09, $0A
	.byte $FF, $19, $1A, $1B, $1C, $2D, $2E, $2F
	.byte $30, $41, $42, $43, $44, $FF, $50, $51
	.byte $FF, $FF, $5D, $5E, $FF, $6B, $6C, $6D
	.byte $FF, $7A, $7B, $7C, $FF
rom_84C3:
	.byte $05, $08, $10, $CE, $00, $FF, $86, $87
	.byte $FF, $FF, $95, $96, $97, $98, $F4, $A7
	.byte $A8, $A9, $AA, $AB, $B9, $BA, $BB, $BC
	.byte $FF, $FF, $C8, $C9, $CA, $FF, $FF, $D4
	.byte $D5, $D6, $FF, $E1, $E2, $E3, $FF, $FF
	.byte $F0, $F1, $F2, $F3, $FF
rom_84F0:
	.byte $05, $08, $10, $CE, $00, $FF, $86, $87
	.byte $FF, $FF, $95, $96, $97, $98, $F4, $A7
	.byte $A8, $A9, $AA, $AB, $B9, $BA, $BB, $BC
	.byte $FF, $FF, $C8, $C9, $CA, $FF, $FF, $D4
	.byte $D5, $D6, $FF, $E1, $E2, $E3, $FF, $FF
	.byte $F0, $F1, $F2, $F3, $FF
rom_851D:
	.byte $05, $09, $10, $C2, $00, $FF, $80, $81
	.byte $FF, $FF, $82, $83, $84, $85, $86, $90
	.byte $91, $92, $93, $94, $A4, $A5, $A6, $A7
	.byte $FF, $B9, $BA, $BB, $FF, $FF, $FF, $CC
	.byte $CD, $FF, $FF, $D9, $DA, $DB, $FF, $FF
	.byte $E6, $E7, $94, $FF, $FF, $F1, $F2, $FF
	.byte $FF, $FF
rom_854F:
	.byte $04, $09, $10, $0C, $00, $FF, $04, $05
	.byte $FF, $FF, $09, $0A, $FF, $11, $12, $13
	.byte $FF, $1A, $1B, $1C, $FF, $26, $27, $28
	.byte $29, $34, $35, $36, $37, $47, $48, $49
	.byte $FF, $5A, $5B, $5C, $FF, $6A, $6B, $FF
	.byte $FF
rom_8578:
	.byte $04, $04, $10, $0C, $00, $FF, $38, $39
	.byte $3A, $FF, $4A, $4B, $4C, $5D, $5E, $5F
	.byte $60, $6C, $6D, $6E, $6F
rom_858D:
	.byte $04, $04, $10, $0C, $40, $3A, $39, $38
	.byte $FF, $4C, $4B, $4A, $FF, $60, $5F, $5E
	.byte $5D, $6F, $6E, $6D, $6C
rom_85A2:
	.byte $05, $08, $10, $C0, $00, $FF, $06, $07
	.byte $FF, $FF, $15, $16, $17, $18, $FF, $2A
	.byte $2B, $2C, $2D, $FF, $3D, $3E, $3F, $40
	.byte $FF, $4C, $4D, $4E, $4F, $FF, $FF, $5A
	.byte $5B, $5C, $FF, $FF, $67, $68, $69, $FF
	.byte $FF, $72, $FF, $73, $74
rom_85CF:
	.byte $05, $08, $10, $02, $00, $8C, $8D, $8E
	.byte $8F, $FF, $9E, $9F, $A0, $A1, $A2, $AE
	.byte $AF, $B0, $B1, $B2, $BF, $C0, $C1, $C2
	.byte $C3, $FF, $CF, $D0, $D1, $FF, $FF, $FF
	.byte $DC, $FF, $FF, $FF, $FF, $E5, $FF, $FF
	.byte $FF, $EC, $ED, $FF, $FF
rom_85FC:
	.byte $07, $0A, $10, $02, $00, $FF, $FF, $FF
	.byte $FF, $FF, $FF, $80, $FF, $FF, $FF, $FF
	.byte $FF, $83, $84, $90, $91, $92, $93, $94
	.byte $95, $FF, $A3, $A4, $A5, $A6, $A7, $A8
	.byte $FF, $B3, $B4, $B5, $B6, $B7, $FF, $FF
	.byte $FF, $C4, $C5, $C6, $C7, $FF, $FF, $FF
	.byte $FF, $D2, $D3, $D1, $FF, $FF, $FF, $FF
	.byte $FF, $DD, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $E6, $FF, $FF, $FF, $FF, $FF, $EE, $EF
	.byte $FF, $FF, $FF
rom_8647:
	.byte $04, $0A, $10, $10, $00, $01, $02, $FF
	.byte $FF, $03, $04, $05, $FF, $0A, $0B, $0C
	.byte $0D, $15, $16, $17, $18, $26, $27, $28
	.byte $FF, $35, $36, $37, $FF, $44, $45, $46
	.byte $FF, $51, $52, $53, $FF, $60, $61, $62
	.byte $FF, $6F, $70, $FF, $FF
rom_8674:
	.byte $07, $08, $10, $10, $00, $FF, $FF, $FF
	.byte $0E, $FF, $FF, $FF, $FF, $FF, $19, $1A
	.byte $FF, $FF, $FF, $FF, $29, $2A, $2B, $FF
	.byte $FF, $FF, $FF, $38, $39, $3A, $3B, $3C
	.byte $FF, $FF, $FF, $47, $48, $49, $4A, $FF
	.byte $FF, $FF, $54, $55, $56, $57, $58, $63
	.byte $64, $65, $66, $FF, $67, $68, $71, $72
	.byte $73, $FF, $FF, $FF, $FF
rom_86B1:
	.byte $07, $09, $10, $10, $00, $FF, $FF, $06
	.byte $07, $FF, $FF, $FF, $FF, $01, $0F, $10
	.byte $FF, $FF, $11, $FF, $1B, $1C, $1D, $1E
	.byte $1F, $20, $FF, $2C, $2D, $2E, $2F, $30
	.byte $FF, $3D, $3E, $3F, $40, $41, $FF, $FF
	.byte $FF, $4B, $4C, $FF, $FF, $FF, $FF, $59
	.byte $5A, $5B, $FF, $FF, $FF, $FF, $69, $6A
	.byte $FF, $FF, $FF, $FF, $FF, $74, $FF, $FF
	.byte $FF, $FF, $FF, $FF
rom_86F5:
	.byte $07, $08, $18, $C0, $00, $FF, $FF, $01
	.byte $FF, $FF, $FF, $FF, $FF, $08, $09, $0A
	.byte $0B, $FF, $FF, $19, $1A, $1B, $1C, $1D
	.byte $1E, $1F, $2E, $2F, $30, $31, $32, $33
	.byte $34, $FF, $41, $42, $43, $44, $FF, $FF
	.byte $FF, $FF, $50, $51, $52, $FF, $FF, $FF
	.byte $FF, $5D, $5E, $5F, $FF, $FF, $FF, $FF
	.byte $6A, $FF, $6B, $6C, $FF
rom_8732:
	.byte $05, $08, $10, $C0, $00, $FF, $02, $03
	.byte $04, $FF, $FF, $0C, $0D, $0E, $FF, $20
	.byte $21, $22, $23, $FF, $35, $36, $37, $38
	.byte $39, $FF, $45, $46, $47, $48, $53, $54
	.byte $55, $56, $FF, $60, $61, $62, $FF, $FF
	.byte $6D, $FF, $6E, $FF, $FF
rom_875F:
	.byte $07, $08, $08, $C0, $00, $FF, $FF, $FF
	.byte $05, $FF, $FF, $FF, $FF, $0F, $10, $11
	.byte $12, $13, $14, $FF, $24, $25, $26, $27
	.byte $28, $29, $FF, $3A, $3B, $3C, $FF, $FF
	.byte $FF, $FF, $49, $4A, $4B, $FF, $FF, $FF
	.byte $FF, $57, $58, $59, $FF, $FF, $FF, $63
	.byte $64, $65, $66, $FF, $FF, $FF, $6F, $FF
	.byte $70, $71, $FF, $FF, $FF
rom_879C:
	.byte $07, $08, $08, $C0, $00, $FF, $FF, $FF
	.byte $05, $FF, $FF, $FF, $FF, $0F, $10, $11
	.byte $12, $13, $14, $FF, $24, $25, $26, $27
	.byte $28, $29, $FF, $3A, $3B, $3C, $FF, $FF
	.byte $FF, $FF, $49, $4A, $4B, $FF, $FF, $FF
	.byte $FF, $57, $58, $59, $FF, $FF, $FF, $63
	.byte $64, $65, $66, $FF, $FF, $FF, $6F, $FF
	.byte $70, $71, $FF, $FF, $FF
rom_87D9:
	.byte $04, $07, $10, $0A, $00, $FF, $FF, $8E
	.byte $8F, $FF, $98, $99, $9A, $A2, $A3, $A4
	.byte $A5, $AD, $AE, $AF, $B0, $FF, $B7, $B8
	.byte $B9, $BF, $C0, $C1, $C2, $C9, $CA, $CB
	.byte $CC
rom_87FA:
	.byte $04, $0A, $10, $0A, $00, $FF, $80, $81
	.byte $FF, $FF, $82, $83, $84, $FF, $87, $88
	.byte $89, $90, $91, $92, $FF, $9B, $9C, $9D
	.byte $FF, $A6, $A7, $A8, $A9, $B1, $B2, $B3
	.byte $FF, $FF, $BA, $BB, $FF, $C3, $C4, $C5
	.byte $FF, $CD, $CE, $CF, $FF
rom_8827:
	.byte $06, $09, $14, $0A, $00, $FF, $FF, $FF
	.byte $85, $FF, $86, $FF, $FF, $8A, $8B, $8C
	.byte $8D, $93, $94, $95, $96, $97, $FF, $9E
	.byte $9F, $A0, $A1, $FF, $FF, $FF, $FF, $AA
	.byte $AB, $AC, $FF, $FF, $FF, $B4, $B5, $B6
	.byte $FF, $FF, $FF, $BC, $BD, $BE, $FF, $FF
	.byte $FF, $C6, $C7, $C8, $FF, $FF, $D0, $D1
	.byte $D2, $D3, $FF
rom_8862:
	.byte $06, $07, $10, $0E, $00, $FF, $FF, $FF
	.byte $FF, $E7, $E8, $FF, $FF, $FF, $E9, $EA
	.byte $FF, $EB, $EC, $ED, $EE, $FF, $FF, $EF
	.byte $F0, $F1, $F2, $FF, $FF, $F3, $F4, $F5
	.byte $F6, $FF, $FF, $F7, $F8, $F9, $FA, $FF
	.byte $FF, $FB, $FC, $FD, $FF, $FF, $FF
rom_8891:
	.byte $06, $09, $10, $CA, $00, $80, $81, $FF
	.byte $FF, $FF, $FF, $82, $83, $84, $FF, $FF
	.byte $FF, $8C, $8D, $8E, $8F, $FF, $FF, $FF
	.byte $9B, $9C, $9D, $FF, $FF, $AE, $AF, $B0
	.byte $B1, $B2, $FF, $FF, $FF, $C4, $C5, $C6
	.byte $FF, $FF, $FF, $D5, $D6, $D7, $FF, $FF
	.byte $FF, $E3, $E4, $E5, $E6, $FF, $FF, $ED
	.byte $EE, $EF, $F0
rom_88CC:
	.byte $06, $08, $10, $CA, $00, $FF, $FF, $85
	.byte $86, $87, $88, $FF, $90, $91, $92, $93
	.byte $94, $9E, $9F, $A0, $A1, $A2, $FF, $B3
	.byte $B4, $B5, $B6, $B7, $FF, $C7, $C8, $C9
	.byte $FF, $CA, $FF, $D8, $D9, $DA, $6B, $FF
	.byte $FF, $E7, $E8, $E9, $FF, $FF, $FF, $F1
	.byte $F2, $F3, $F4, $FF, $FF
rom_8901:
	.byte $05, $07, $10, $C8, $00, $FF, $FF, $65
	.byte $66, $67, $FF, $68, $69, $6A, $6B, $6C
	.byte $6D, $6E, $6F, $FF, $70, $71, $72, $73
	.byte $74, $75, $76, $77, $78, $79, $7A, $7B
	.byte $7C, $FF, $FF, $7D, $FF, $7E, $7F, $FF
rom_8929:
	.byte $05, $07, $10, $0E, $00, $FF, $82, $FF
	.byte $FF, $FF, $87, $88, $89, $FF, $FF, $8F
	.byte $90, $91, $FF, $FF, $9B, $9C, $9D, $9E
	.byte $FF, $A9, $AA, $AB, $AC, $FF, $B9, $BA
	.byte $BB, $BC, $A4, $FF, $FF, $C8, $C9, $FF
rom_8951:
	.byte $08, $06, $10, $0E, $00, $FF, $8A, $8B
	.byte $FF, $FF, $FF, $FF, $FF, $92, $93, $94
	.byte $95, $96, $FF, $FF, $FF, $9F, $A0, $A1
	.byte $A2, $A3, $A4, $FF, $FF, $FF, $AD, $AE
	.byte $AF, $B0, $B1, $B2, $B3, $FF, $BD, $BE
	.byte $BF, $C0, $C1, $C2, $C3, $FF, $FF, $CA
	.byte $CB, $CC, $FF, $FF, $FF
rom_8986:
	.byte $05, $08, $10, $C0, $00, $FF, $02, $03
	.byte $04, $FF, $FF, $0C, $0D, $0E, $FF, $20
	.byte $21, $22, $23, $FF, $35, $36, $37, $38
	.byte $39, $FF, $45, $46, $47, $48, $53, $54
	.byte $55, $56, $FF, $60, $61, $62, $FF, $FF
	.byte $6D, $FF, $6E, $FF, $FF
rom_89B3:
	.byte $06, $06, $10, $CA, $00, $89, $8A, $8B
	.byte $FF, $FF, $FF, $98, $99, $9A, $FF, $FF
	.byte $FF, $A8, $A9, $AA, $AB, $AC, $AD, $BE
	.byte $BF, $C0, $C1, $C2, $C3, $F9, $D0, $D1
	.byte $D2, $D3, $D4, $FF, $DE, $DF, $E0, $E1
	.byte $E2
rom_89DC:
	.byte $05, $07, $10, $C8, $00, $FF, $0D, $0E
	.byte $0F, $FF, $18, $19, $1A, $1B, $FF, $24
	.byte $25, $26, $27, $28, $FF, $FF, $30, $31
	.byte $32, $FF, $39, $3A, $3B, $3C, $48, $49
	.byte $4A, $4B, $4C, $FF, $5A, $5B, $5C, $FF
rom_8A04:
	.byte $08, $03, $10, $C8, $00, $3D, $3E, $3F
	.byte $40, $41, $FF, $42, $FF, $4D, $4E, $4F
	.byte $50, $51, $52, $53, $54, $5D, $5E, $5F
	.byte $60, $61, $62, $63, $64
rom_8A21:
	.byte $08, $03, $10, $C8, $00, $3D, $3E, $3F
	.byte $40, $41, $FF, $42, $FF, $4D, $4E, $4F
	.byte $50, $51, $52, $53, $54, $5D, $5E, $5F
	.byte $60, $61, $62, $63, $64
rom_8A3E:
	.byte $08, $03, $10, $C8, $00, $3D, $3E, $3F
	.byte $40, $41, $FF, $42, $FF, $4D, $4E, $4F
	.byte $50, $51, $52, $53, $54, $5D, $5E, $5F
	.byte $60, $61, $62, $63, $64
rom_8A5B:
	.byte $06, $05, $10, $C4, $00, $FF, $FF, $FF
	.byte $5E, $5F, $60, $FF, $FF, $65, $66, $67
	.byte $68, $6C, $6D, $6E, $6F, $70, $71, $75
	.byte $76, $77, $78, $79, $7A, $FF, $FF, $7F
	.byte $FF, $FF, $FF
rom_8A7E:
	.byte $06, $05, $10, $C4, $00, $FF, $FF, $FF
	.byte $5E, $5F, $60, $FF, $FF, $65, $66, $67
	.byte $68, $6C, $6D, $6E, $6F, $70, $71, $75
	.byte $76, $77, $78, $79, $7A, $FF, $FF, $7F
	.byte $FF, $FF, $FF
rom_8AA1:
	.byte $06, $07, $10, $C6, $00, $FF, $FF, $85
	.byte $86, $FF, $FF, $8E, $8F, $90, $91, $92
	.byte $FF, $9D, $9E, $9F, $A0, $A1, $A2, $AC
	.byte $AD, $AE, $AF, $B0, $B1, $BA, $BB, $BC
	.byte $BD, $BE, $FF, $FF, $FF, $C4, $C5, $C6
	.byte $FF, $FF, $FF, $CE, $FF, $CF, $D0
rom_8AD0:
	.byte $04, $08, $08, $CC, $00, $FF, $0B, $0C
	.byte $FF, $1D, $1E, $1F, $20, $31, $32, $33
	.byte $34, $45, $46, $47, $48, $52, $53, $54
	.byte $55, $5F, $60, $61, $FF, $6E, $6F, $70
	.byte $FF, $7D, $7E, $7F, $FF
rom_8AF5:
	.byte $04, $08, $08, $CE, $00, $FF, $80, $81
	.byte $FF, $88, $89, $8A, $8B, $99, $9A, $9B
	.byte $9C, $AC, $AD, $AE, $AF, $BD, $BE, $BF
	.byte $C0, $CB, $CC, $CD, $FF, $D7, $D8, $D9
	.byte $FF, $E4, $E5, $E6, $E7
rom_8B1A:
	.byte $06, $08, $10, $C2, $00, $FF, $FF, $89
	.byte $8A, $FF, $FF, $99, $9A, $9B, $9C, $9D
	.byte $9E, $AE, $AF, $B0, $B1, $B2, $B3, $C2
	.byte $C3, $C4, $C5, $C6, $C7, $FF, $D2, $D3
	.byte $D4, $D5, $FF, $FF, $FF, $E0, $E1, $E2
	.byte $FF, $FF, $FF, $EB, $EC, $ED, $FF, $FF
	.byte $F7, $F8, $FF, $F9, $FF
rom_8B4F:
	.byte $06, $08, $10, $C2, $00, $FF, $FF, $87
	.byte $88, $FF, $FF, $FF, $95, $96, $97, $98
	.byte $FF, $A8, $A9, $AA, $AB, $AC, $AD, $BC
	.byte $BD, $BE, $BF, $C0, $C1, $FF, $CE, $CF
	.byte $D0, $D1, $FF, $FF, $DC, $DD, $DE, $DF
	.byte $FF, $FF, $E8, $E9, $EA, $FF, $FF, $FF
	.byte $F3, $F4, $F5, $F6, $FF
rom_8B84:
	.byte $05, $08, $10, $C2, $00, $8B, $8C, $8D
	.byte $8E, $8F, $9F, $A0, $A1, $A2, $A3, $B4
	.byte $B5, $B6, $B7, $B8, $C8, $C9, $CA, $CB
	.byte $FF, $FF, $D6, $D7, $D8, $FF, $FF, $E3
	.byte $E4, $E5, $FF, $FF, $EE, $EF, $F0, $FF
	.byte $FA, $FB, $FF, $FC, $FF
rom_8BB1:
	.byte $05, $08, $10, $0E, $00, $FF, $80, $81
	.byte $FF, $FF, $83, $84, $85, $86, $FF, $8C
	.byte $8D, $8E, $FF, $FF, $97, $98, $99, $9A
	.byte $FF, $A5, $A6, $A7, $A8, $FF, $B4, $B5
	.byte $B6, $B7, $B8, $C4, $C5, $FF, $C6, $C7
	.byte $CD, $CE, $FF, $FF, $CF
rom_8BDE:
	.byte $0A, $03, $10, $0E, $00, $FF, $FF, $FF
	.byte $FF, $FF, $D0, $D1, $D2, $FF, $FF, $D3
	.byte $D4, $D5, $D6, $D7, $D8, $D9, $DA, $DB
	.byte $DC, $DD, $DE, $DF, $E0, $E1, $E2, $E3
	.byte $E4, $E5, $E6
rom_8C01:
	.byte $05, $09, $10, $08, $00, $07, $08, $FF
	.byte $FF, $FF, $11, $12, $FF, $FF, $FF, $1B
	.byte $1C, $1D, $1E, $FF, $26, $27, $28, $29
	.byte $FF, $FF, $36, $37, $38, $FF, $FF, $47
	.byte $48, $49, $4A, $FF, $5A, $56, $FF, $FF
	.byte $FF, $6B, $0F, $FF, $FF, $FF, $7A, $7B
	.byte $FF, $FF
rom_8C33:
	.byte $05, $08, $10, $C0, $00, $FF, $02, $03
	.byte $04, $FF, $FF, $0C, $0D, $0E, $FF, $20
	.byte $21, $22, $23, $FF, $35, $36, $37, $38
	.byte $39, $FF, $45, $46, $47, $48, $53, $54
	.byte $55, $56, $FF, $60, $61, $62, $FF, $FF
	.byte $6D, $FF, $6E, $FF, $FF
rom_8C60:
	.byte $07, $08, $10, $C0, $00, $FF, $FF, $FF
	.byte $05, $FF, $FF, $FF, $FF, $0F, $10, $11
	.byte $12, $13, $14, $FF, $24, $25, $26, $27
	.byte $28, $29, $FF, $3A, $3B, $3C, $FF, $FF
	.byte $FF, $FF, $49, $4A, $4B, $FF, $FF, $FF
	.byte $FF, $57, $58, $59, $FF, $FF, $FF, $63
	.byte $64, $65, $66, $FF, $FF, $FF, $6F, $FF
	.byte $70, $71, $FF, $FF, $FF
rom_8C9D:
	.byte $04, $07, $10, $04, $00, $12, $13, $14
	.byte $15, $23, $24, $25, $26, $32, $33, $34
	.byte $35, $41, $42, $43, $44, $FF, $4F, $50
	.byte $51, $5B, $5C, $5D, $5E, $67, $FF, $FF
	.byte $68
rom_8CBE:
	.byte $06, $0A, $10, $04, $00, $FF, $FF, $FF
	.byte $FF, $FF, $01, $FF, $FF, $FF, $02, $03
	.byte $04, $FF, $0A, $0B, $0C, $0D, $FF, $16
	.byte $17, $18, $19, $1A, $FF, $27, $28, $29
	.byte $2A, $FF, $FF, $36, $37, $38, $39, $FF
	.byte $FF, $45, $46, $47, $48, $FF, $FF, $FF
	.byte $FF, $52, $53, $FF, $FF, $FF, $FF, $5F
	.byte $60, $FF, $FF, $FF, $FF, $69, $6A, $FF
	.byte $FF
rom_8CFF:
	.byte $03, $09, $10, $04, $00, $05, $06, $FF
	.byte $0E, $0F, $10, $1B, $1C, $1D, $2B, $2C
	.byte $2D, $3A, $3B, $3C, $49, $4A, $4B, $54
	.byte $55, $56, $FF, $61, $62, $FF, $6B, $6C
rom_8D1F:
	.byte $05, $08, $10, $CE, $00, $FF, $FF, $82
	.byte $83, $FF, $8C, $8D, $8E, $8F, $90, $9D
	.byte $9E, $9F, $A0, $A1, $B0, $B1, $B2, $B3
	.byte $FF, $FF, $C1, $C2, $C3, $FF, $FF, $CE
	.byte $CF, $D0, $FF, $DA, $DB, $DC, $DD, $FF
	.byte $E8, $E9, $EA, $EB, $FF
rom_8D4C:
	.byte $05, $08, $10, $CE, $00, $FF, $FF, $84
	.byte $85, $FF, $91, $92, $93, $94, $FF, $A2
	.byte $A3, $A4, $A5, $A6, $B4, $B5, $B6, $B7
	.byte $B8, $C4, $C5, $C6, $C7, $FF, $FF, $D1
	.byte $D2, $D3, $FF, $FF, $DE, $DF, $E0, $FF
	.byte $EC, $ED, $EE, $EF, $FF
rom_8D79:
	.byte $05, $08, $10, $C0, $40, $FF, $FF, $07
	.byte $06, $FF, $FF, $18, $17, $16, $15, $FF
	.byte $2D, $2C, $2B, $2A, $FF, $40, $3F, $3E
	.byte $3D, $FF, $4F, $4E, $4D, $4C, $FF, $5C
	.byte $5B, $5A, $FF, $FF, $69, $68, $67, $FF
	.byte $74, $73, $FF, $72, $FF
rom_8DA6:
	.byte $06, $06, $10, $CA, $00, $89, $8A, $8B
	.byte $FF, $FF, $FF, $98, $99, $9A, $FF, $FF
	.byte $FF, $A8, $A9, $AA, $AB, $AC, $AD, $BE
	.byte $BF, $C0, $C1, $C2, $C3, $F9, $D0, $D1
	.byte $D2, $D3, $D4, $FF, $DE, $DF, $E0, $E1
	.byte $E2
rom_8DCF:
	.byte $05, $08, $10, $C8, $00, $FF, $FF, $FF
	.byte $FF, $FF, $FF, $0D, $0E, $0F, $FF, $18
	.byte $19, $1A, $1B, $FF, $24, $25, $26, $27
	.byte $28, $FF, $FF, $30, $31, $32, $FF, $39
	.byte $3A, $3B, $3C, $48, $49, $4A, $4B, $4C
	.byte $FF, $5A, $5B, $5C, $FF

; -----------------------------------------------------------------------------

; The rest seems to be unused
