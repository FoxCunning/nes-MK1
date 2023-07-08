.segment "BANK_09"
; $8000-$9FFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"


; -----------------------------------------------------------------------------

; Data pointers for Kano
rom_8000:
	.word rom_8004, rom_82C7

; -----------------------------------------------------------------------------

rom_8004:
	.byte $08
	.word rom_80A3
	.byte $06
	.word rom_80A9
	.byte $08
	.word rom_80AD
	.byte $01
	.word rom_80B5
	.byte $03
	.word rom_80BF
	.byte $08
	.word rom_80C9
	.byte $02
	.word rom_80D1
	.byte $05
	.word rom_80DD
	.byte $04
	.word rom_80ED
	.byte $07
	.word rom_80FD
	.byte $07
	.word rom_8105
	.byte $08
	.word rom_810D
	.byte $0A
	.word rom_8113
	.byte $1D
	.word rom_8117
	.byte $02
	.word rom_8137
	.byte $02
	.word rom_8143
	.byte $00
	.word rom_814F
	.byte $02
	.word rom_8157
	.byte $02
	.word rom_8163
	.byte $00
	.word rom_816F
	.byte $0A
	.word rom_8177
	.byte $05
	.word rom_817B
	.byte $02
	.word rom_817C
	.byte $0B
	.word rom_817D
	.byte $2A
	.word rom_818D
	.byte $05
	.word rom_8199
	.byte $05
	.word rom_81A9
	.byte $05
	.word rom_81B9
	.byte $05
	.word rom_81C9
	.byte $05
	.word rom_81D9
	.byte $18
	.word rom_81DA
	.byte $04
	.word rom_81F8
	.byte $04
	.word rom_8208
	.byte $04
	.word rom_8218
	.byte $04
	.word rom_8228
	.byte $04
	.word rom_8238
	.byte $04
	.word rom_8239
	.byte $06
	.word rom_823A
	.byte $0E
	.word rom_823B
	.byte $08
	.word rom_8248
	.byte $10
	.word rom_824E
	.byte $08
	.word rom_8262
	.byte $08
	.word rom_8268
	.byte $07
	.word rom_80AD
	.byte $07
	.word rom_80C9
	.byte $0F
	.word rom_8270
	.byte $0D
	.word rom_8271
	.byte $14
	.word rom_8286
	.byte $0D
	.word rom_8271
	.byte $29
	.word rom_8286
	.byte $19
	.word rom_8292
	.byte $1F
	.word rom_82A1
	.byte $04
	.word rom_80ED

; -----------------------------------------------------------------------------

rom_80A3:
	.byte $00, $00, $00, $01, $01, $01
rom_80A9:
	.byte $02, $02, $02, $02
rom_80AD:
	.byte $03, $03, $03, $03, $03, $03, $03, $03
rom_80B5:
	.byte $04, $05, $06, $07, $08, $04, $05, $06
	.byte $07, $08
rom_80BF:
	.byte $04, $05, $06, $07, $08, $04, $05, $06
	.byte $07, $08
rom_80C9:
	.byte $09, $09, $09, $09, $09, $09, $09, $09
rom_80D1:
	.byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A
	.byte $0A, $0A, $0A, $0A
rom_80DD:
	.byte $0B, $0B, $0B, $0B, $0C, $0C, $0D, $0D
	.byte $0C, $0C, $0D, $0D, $0C, $0B, $0B, $0B
rom_80ED:
	.byte $0B, $0B, $0B, $0B, $0C, $0C, $0D, $0D
	.byte $0C, $0C, $0D, $0D, $0C, $0B, $0B, $0B
rom_80FD:
	.byte $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E
rom_8105:
	.byte $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E
rom_810D:
	.byte $0F, $0F, $10, $10, $0F, $0F
rom_8113:
	.byte $31, $31, $31, $31
rom_8117:
	.byte $34, $34, $35, $35, $36, $36, $34, $34
	.byte $35, $35, $36, $36
    ; Potentially unused
	.byte $32, $32, $32, $32, $32, $33, $33, $33
	.byte $33, $33, $33, $33, $33, $33, $33, $33
	.byte $33, $33, $33, $33
rom_8137:
	.byte $11, $11, $11, $12, $12, $13, $13, $13
	.byte $12, $12, $11, $11
rom_8143:
	.byte $11, $11, $11, $11, $11, $12, $12, $12
	.byte $12, $13, $13, $13
rom_814F:
	.byte $14, $14, $15, $15, $14, $14, $16, $16
rom_8157:
	.byte $0A, $0A, $0A, $0A, $0A, $17, $17, $17
	.byte $0A, $0A, $0A, $0A
rom_8163:
	.byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A
	.byte $0A, $17, $17, $17
rom_816F:
	.byte $18, $18, $1A, $1A, $19, $19, $1A, $1A
rom_8177:
	.byte $1B, $1B, $02, $02
rom_817B:
	.byte $00
rom_817C:
	.byte $00
rom_817D:
	.byte $0C, $0C, $0D, $0D, $0C, $0C, $0D, $0D
	.byte $0C, $0C, $0D, $0D, $0C, $0C, $0D, $0D
rom_818D:
	.byte $1C, $1C, $1C, $1C, $1D, $1D, $1D, $1D
	.byte $1E, $1E, $1E, $1E
rom_8199:
	.byte $0B, $0B, $0B, $0B, $0C, $0C, $0D, $0D
	.byte $17, $17, $17, $17, $0B, $0B, $0B, $0B
rom_81A9:
	.byte $0B, $0B, $0B, $0B, $0C, $0C, $0D, $0D
	.byte $0C, $0C, $0D, $0D, $17, $17, $17, $0B
rom_81B9:
	.byte $0B, $0B, $0B, $0B, $1F, $1F, $20, $20
	.byte $20, $1F, $1F, $1F, $0B, $0B, $0B, $0B
rom_81C9:
	.byte $0B, $0B, $0B, $0B, $0C, $0C, $0D, $0D
	.byte $1F, $1F, $20, $20, $20, $20, $1F, $0B
rom_81D9:
	.byte $00
rom_81DA:
	.byte $32, $32, $32, $32, $33, $33, $33, $33
	.byte $33, $33, $33, $33, $33, $33, $33, $33
	.byte $33, $33, $33, $33, $33, $33, $33, $33
    ; Potentially unused
	.byte $33, $33, $33, $33, $33, $33
rom_81F8:
	.byte $0B, $0B, $0B, $0B, $17, $17, $17, $17
	.byte $0C, $0C, $0D, $0D, $0B, $0B, $0B, $0B
rom_8208:
	.byte $17, $17, $17, $0B, $0C, $0C, $0D, $0D
	.byte $0C, $0C, $0D, $0D, $0B, $0B, $0B, $0B
rom_8218:
	.byte $0B, $0B, $0B, $0B, $1F, $1F, $20, $20
	.byte $20, $1F, $1F, $1F, $0B, $0B, $0B, $0B
rom_8228:
	.byte $0B, $0B, $0B, $0B, $0C, $0C, $0D, $0D
	.byte $1F, $1F, $20, $20, $20, $1F, $1F, $0B
rom_8238:
	.byte $00
rom_8239:
	.byte $00
rom_823A:
	.byte $21
rom_823B:
	.byte $25, $25, $25, $25, $25, $25, $25, $26
	.byte $26, $26, $26, $26, $26
rom_8248:
	.byte $27, $27, $28, $28, $29, $29
rom_824E:
	.byte $2A, $2A, $2A, $2A, $2B, $2B, $2B, $2B
	.byte $2A, $2A, $2A, $2A, $2B, $2B, $2B, $2B
	.byte $2A, $2A, $2A, $2A
rom_8262:
	.byte $2C, $2C, $2C, $2C, $2C, $2C
rom_8268:
	.byte $2D, $2D, $2D, $2D, $2E, $2E, $03, $09
rom_8270:
	.byte $37
rom_8271:
	.byte $22, $22, $22, $23, $23, $23, $24, $24
	.byte $24
    ; Potentially unused
	.byte $24, $24, $24, $24, $24, $24, $24, $24
	.byte $37, $37, $00, $00
rom_8286:
	.byte $38, $38, $38, $39, $39, $39, $3A, $3A
	.byte $23, $23, $23, $23
rom_8292:
	.byte $37, $37, $37, $37, $37, $37, $37, $37
	.byte $37, $37, $37, $37, $37, $37, $37
rom_82A1:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00

; -----------------------------------------------------------------------------

rom_82C7:
	.word rom_8391, rom_83BA, rom_83E3, rom_8401
	.word rom_8429, rom_8429, rom_8497, rom_84CE
	.word rom_8505, rom_853C, rom_8569, rom_8592
	.word rom_85B3, rom_85CC, rom_85E5, rom_8617
	.word rom_8652, rom_8696, rom_86B7, rom_86D8
	.word rom_8707, rom_8739, rom_877D, rom_87C1
	.word rom_87E4, rom_8813, rom_8840, rom_886D
	.word rom_889C, rom_88D9, rom_8915, rom_893E
	.word rom_895F, rom_898E, rom_89BB, rom_89EA
	.word rom_8A08, rom_8A37, rom_8A58, rom_8A6F
	.word rom_8A86, rom_8A9A, rom_8ABF, rom_8AE4
	.word rom_8B0D, rom_8B3A, rom_8B71, rom_8B9A
	.word rom_8BBB, rom_8BEA, rom_8C21, rom_8C5C
	.word rom_8C97, rom_8CC0, rom_8D04, rom_8D2D
	.word rom_8D47, rom_8D79, rom_8DA8, rom_8391
	.word rom_8391, rom_8391, rom_8391, rom_8391
	.word rom_8391, rom_8391, rom_8391, rom_8391
	.word rom_8391, rom_8391, rom_8391, rom_8391
	.word rom_8391, rom_8391, rom_8391, rom_8391
	.word rom_8391, rom_8391, rom_8391, rom_8391
	.word rom_8391, rom_8391, rom_8391, rom_8391
	.word rom_8391, rom_8391, rom_8391, rom_8391
	.word rom_8391, rom_8391, rom_8391, rom_8391
	.word rom_8391, rom_8391, rom_8391, rom_8391
	.word rom_8391, rom_8391, rom_8391, rom_8391
	.word rom_8391

; -----------------------------------------------------------------------------

rom_8391:
	.byte $04, $09, $10, $AA, $00, $FF, $81, $82
	.byte $FF, $8C, $8D, $8E, $8F, $9A, $9B, $9C
	.byte $9D, $A8, $A9, $AA, $FF, $B5, $B6, $B7
	.byte $FF, $C1, $C2, $C3, $FF, $CA, $CB, $CC
	.byte $CD, $D5, $FE, $D6, $FF, $DA, $FF, $DB
	.byte $DC
rom_83BA:
	.byte $04, $09, $10, $AA, $00, $FF, $83, $84
	.byte $FF, $90, $91, $92, $93, $9E, $9F, $A0
	.byte $A1, $AB, $AC, $AD, $FF, $B8, $B9, $BA
	.byte $FF, $C4, $C5, $C6, $FF, $CE, $CF, $D0
	.byte $D1, $D7, $D8, $D9, $D1, $DD, $FF, $DE
	.byte $DF
rom_83E3:
	.byte $05, $05, $10, $A6, $00, $80, $81, $82
	.byte $FF, $FF, $83, $84, $85, $86, $87, $89
	.byte $8A, $8B, $8C, $8D, $91, $92, $93, $94
	.byte $FF, $98, $FF, $99, $9A, $FF
rom_8401:
	.byte $05, $07, $10, $A6, $00, $FF, $FF, $B0
	.byte $B1, $FF, $FF, $BD, $BE, $BF, $FF, $CC
	.byte $CD, $CE, $CF, $FF, $DB, $DC, $DD, $FF
	.byte $FF, $EA, $EB, $EC, $9E, $FF, $F8, $F9
	.byte $FA, $FB, $FF, $FC, $FF, $FF, $FD, $FE
rom_8429:
	.byte $05, $0A, $10, $B4, $00, $FF, $FF, $01
	.byte $02, $FF, $FF, $06, $07, $08, $FF, $FF
	.byte $0E, $0F, $10, $11, $FF, $1A, $1B, $1C
	.byte $1D, $FF, $26, $27, $28, $FF, $FF, $35
	.byte $36, $37, $FF, $FF, $44, $45, $46, $FF
	.byte $FF, $53, $54, $55, $FF, $06, $60, $61
	.byte $62, $FF, $6D, $6E, $6F, $70, $FF
; Potentially unused, instead there is a second pointer to 8429
unused_8560:
	.byte $05, $0A, $10, $B4, $00, $FF, $FF, $01
	.byte $02, $FF, $FF, $06, $07, $08, $FF, $FF
	.byte $0E, $0F, $10, $11, $FF, $1A, $1B, $1C
	.byte $1D, $FF, $29, $2A, $2B, $FF, $FF, $38
	.byte $39, $3A, $FF, $FF, $47, $48, $49, $FF
	.byte $FF, $56, $57, $58, $FF, $FF, $FF, $63
	.byte $64, $FF, $FF, $FF, $71, $72, $FF
rom_8497:
	.byte $05, $0A, $10, $B4, $00, $FF, $FF, $03
	.byte $04, $FF, $FF, $FF, $09, $0A, $FF, $FF
	.byte $12, $13, $14, $15, $FF, $1E, $1F, $20
	.byte $21, $FF, $2C, $2D, $2E, $FF, $FF, $3B
	.byte $3C, $3D, $FF, $FF, $4A, $4B, $4C, $FF
	.byte $FF, $FF, $59, $5A, $FF, $FF, $65, $66
	.byte $67, $FF, $FF, $73, $74, $75, $FF
rom_84CE:
	.byte $05, $0A, $10, $B4, $00, $FF, $FF, $01
	.byte $02, $FF, $FF, $06, $07, $08, $FF, $FF
	.byte $0E, $0F, $10, $11, $FF, $1A, $1B, $1C
	.byte $1D, $FF, $2F, $30, $31, $FF, $FF, $3E
	.byte $3F, $40, $FF, $FF, $4D, $4E, $4F, $FF
	.byte $FF, $56, $5B, $5C, $FF, $FF, $FF, $68
	.byte $69, $FF, $FF, $FF, $76, $77, $FF
rom_8505:
	.byte $05, $0A, $10, $B4, $00, $FF, $FF, $05
	.byte $02, $FF, $FF, $0B, $0C, $0D, $FF, $FF
	.byte $16, $17, $18, $19, $FF, $22, $23, $24
	.byte $25, $FF, $32, $33, $34, $FF, $FF, $41
	.byte $42, $43, $FF, $FF, $50, $51, $52, $FF
	.byte $FF, $5D, $5E, $5F, $FF, $FF, $6A, $6B
	.byte $6C, $FF, $FF, $78, $79, $7A, $7B
rom_853C:
	.byte $04, $0A, $10, $A8, $00, $FF, $FF, $01
	.byte $FF, $FF, $08, $09, $FF, $FF, $14, $15
	.byte $FF, $25, $26, $27, $FF, $37, $38, $39
	.byte $FF, $47, $48, $49, $4A, $54, $55, $56
	.byte $57, $60, $61, $62, $63, $6C, $6D, $6E
	.byte $6F, $78, $FF, $79, $7A
rom_8569:
	.byte $04, $09, $10, $A8, $00, $FF, $0A, $0B
	.byte $FF, $16, $17, $18, $19, $28, $29, $2A
	.byte $2B, $3A, $3B, $3C, $3D, $4B, $4C, $4D
	.byte $FF, $58, $59, $5A, $5B, $64, $65, $66
	.byte $67, $70, $71, $72, $73, $7B, $7C, $7D
	.byte $FF
rom_8592:
	.byte $04, $07, $10, $AA, $00, $FF, $85, $86
	.byte $87, $94, $95, $96, $FF, $A2, $A3, $A4
	.byte $FF, $AE, $AF, $B0, $B1, $BB, $BC, $BD
	.byte $BE, $C7, $C8, $C9, $FF, $D2, $D3, $D4
	.byte $FF
rom_85B3:
	.byte $04, $05, $10, $AA, $00, $88, $89, $8A
	.byte $8B, $97, $98, $99, $3D, $A5, $A6, $A7
	.byte $FF, $B2, $B3, $B4, $FF, $FF, $BF, $C0
	.byte $FF
rom_85CC:
	.byte $04, $05, $10, $AA, $40, $8B, $8A, $89
	.byte $88, $3D, $99, $98, $97, $FF, $A7, $A6
	.byte $A5, $FF, $B4, $B3, $B2, $FF, $C0, $BF
	.byte $FF
rom_85E5:
	.byte $05, $09, $10, $B6, $00, $FF, $8B, $8C
	.byte $FF, $FF, $9A, $9B, $9C, $9D, $FF, $AA
	.byte $AB, $AC, $FF, $FF, $BA, $BB, $BC, $FF
	.byte $FF, $FF, $CA, $CB, $CC, $FF, $FF, $D5
	.byte $D6, $D7, $FF, $DE, $DF, $E0, $E1, $FF
	.byte $E2, $E3, $E4, $E5, $FF, $E6, $E7, $FF
	.byte $E8, $E9
rom_8617:
	.byte $06, $09, $10, $A8, $00, $02, $03, $FF
	.byte $04, $FF, $FF, $0C, $0D, $0E, $0F, $FF
	.byte $FF, $1A, $1B, $1C, $1D, $1E, $1F, $2C
	.byte $2D, $2E, $2F, $30, $31, $3E, $3F, $40
	.byte $41, $42, $FF, $FF, $4E, $4F, $FF, $FF
	.byte $FF, $FF, $5C, $5D, $FF, $FF, $FF, $FF
	.byte $68, $69, $FF, $FF, $FF, $FF, $74, $75
	.byte $FF, $FF, $FF
rom_8652:
	.byte $07, $09, $10, $A8, $00, $FF, $FF, $FF
	.byte $FF, $05, $06, $07, $FF, $FF, $10, $11
	.byte $12, $13, $FF, $20, $21, $22, $23, $24
	.byte $FF, $FF, $32, $33, $34, $35, $36, $FF
	.byte $FF, $43, $44, $45, $46, $FF, $FF, $FF
	.byte $50, $51, $52, $53, $FF, $FF, $FF, $FF
	.byte $FF, $5E, $5F, $FF, $FF, $FF, $FF, $FF
	.byte $6A, $6B, $FF, $FF, $FF, $FF, $FF, $76
	.byte $77, $FF, $FF, $FF
rom_8696:
	.byte $04, $07, $10, $B0, $00, $0B, $0C, $FF
	.byte $FF, $18, $19, $1A, $FF, $28, $29, $2A
	.byte $FF, $37, $38, $39, $FF, $44, $45, $46
	.byte $47, $54, $55, $56, $57, $FF, $62, $63
	.byte $64
rom_86B7:
	.byte $04, $07, $10, $B0, $00, $0B, $0C, $FF
	.byte $FF, $18, $19, $1A, $FF, $28, $29, $2A
	.byte $FF, $37, $38, $39, $FF, $44, $45, $46
	.byte $47, $54, $55, $56, $57, $FF, $62, $63
	.byte $64
rom_86D8:
	.byte $07, $06, $10, $B0, $00, $0D, $0E, $0F
	.byte $FF, $FF, $FF, $FF, $1B, $1C, $1D, $1E
	.byte $1F, $FF, $FF, $2B, $2C, $2D, $2E, $2F
	.byte $FF, $FF, $FF, $3A, $3B, $3C, $3D, $FF
	.byte $FF, $FF, $FF, $48, $49, $4A, $4B, $4C
	.byte $FF, $FF, $58, $59, $5A, $5B, $5C
rom_8707:
	.byte $05, $09, $10, $A4, $00, $FF, $FF, $03
	.byte $04, $FF, $FF, $0C, $0D, $0E, $0F, $FF
	.byte $1C, $1D, $1E, $1F, $FF, $30, $31, $32
	.byte $FF, $FF, $3D, $3E, $3F, $FF, $FF, $49
	.byte $4A, $4B, $FF, $54, $55, $56, $57, $FF
	.byte $63, $64, $65, $FF, $FF, $71, $72, $73
	.byte $FF, $FF
rom_8739:
	.byte $07, $09, $10, $A4, $00, $FF, $FF, $FF
	.byte $05, $06, $FF, $FF, $FF, $FF, $10, $11
	.byte $12, $13, $FF, $FF, $20, $21, $22, $23
	.byte $24, $25, $FF, $33, $34, $35, $36, $FF
	.byte $FF, $FF, $40, $41, $42, $FF, $FF, $FF
	.byte $FF, $4C, $4D, $4E, $FF, $FF, $FF, $FF
	.byte $59, $5A, $5B, $FF, $FF, $FF, $66, $67
	.byte $68, $69, $FF, $FF, $FF, $74, $FF, $75
	.byte $76, $FF, $FF, $FF
rom_877D:
	.byte $07, $09, $10, $A4, $00, $FF, $FF, $FF
	.byte $07, $08, $FF, $FF, $FF, $FF, $15, $16
	.byte $17, $18, $FF, $FF, $26, $27, $28, $29
	.byte $2A, $2B, $FF, $37, $38, $39, $FF, $FF
	.byte $FF, $FF, $43, $44, $45, $FF, $FF, $FF
	.byte $FF, $4F, $50, $51, $FF, $FF, $FF, $5C
	.byte $5D, $5E, $5F, $FF, $FF, $FF, $6A, $6B
	.byte $6C, $6D, $FF, $FF, $FF, $77, $FF, $78
	.byte $79, $FF, $FF, $FF
rom_87C1:
	.byte $05, $06, $10, $AC, $00, $53, $54, $55
	.byte $56, $FF, $5A, $5B, $5C, $5D, $FF, $62
	.byte $63, $64, $65, $66, $6B, $6C, $6D, $6E
	.byte $6F, $74, $75, $76, $FF, $FF, $FF, $7A
	.byte $7B, $FF, $FF
rom_87E4:
	.byte $06, $07, $10, $A6, $00, $FF, $FF, $9B
	.byte $9C, $9D, $9E, $FF, $A4, $A5, $A6, $A7
	.byte $A8, $B2, $B3, $B4, $B5, $FF, $FF, $C0
	.byte $C1, $C2, $C3, $C4, $FF, $FF, $D0, $D1
	.byte $D2, $D3, $FF, $DE, $DF, $E0, $E1, $E2
	.byte $FF, $ED, $EE, $FF, $EF, $F0, $FF
rom_8813:
	.byte $04, $0A, $10, $A4, $00, $FF, $FF, $01
	.byte $02, $FF, $09, $0A, $0B, $FF, $19, $1A
	.byte $1B, $2C, $2D, $2E, $2F, $3A, $3B, $3C
	.byte $FF, $46, $47, $48, $FF, $FF, $52, $53
	.byte $FF, $60, $61, $62, $FF, $6E, $6F, $70
	.byte $FF, $7A, $7B, $7C, $FF
rom_8840:
	.byte $04, $0A, $10, $A6, $00, $FF, $88, $FF
	.byte $FF, $FF, $8E, $8F, $90, $FF, $95, $96
	.byte $97, $FF, $9F, $A0, $A1, $FF, $A9, $AA
	.byte $AB, $FF, $B6, $B7, $B8, $FF, $C5, $C6
	.byte $C7, $FF, $D4, $D5, $D6, $E3, $E4, $E5
	.byte $FF, $F1, $FF, $F2, $F3
rom_886D:
	.byte $06, $07, $10, $A6, $00, $FF, $FF, $FF
	.byte $FF, $A2, $A3, $FF, $FF, $AC, $AD, $AE
	.byte $AF, $FF, $B9, $BA, $BB, $BC, $FF, $C8
	.byte $C9, $CA, $CB, $FF, $FF, $D7, $D8, $D9
	.byte $DA, $FF, $FF, $E6, $E7, $E8, $E9, $FF
	.byte $FF, $F4, $F5, $F6, $F7, $FF, $FF
rom_889C:
	.byte $07, $08, $10, $B2, $00, $FF, $8B, $8C
	.byte $FF, $FF, $FF, $FF, $96, $97, $98, $99
	.byte $9A, $FF, $FF, $FF, $A7, $A8, $A9, $AA
	.byte $FF, $FF, $FF, $FF, $FF, $B5, $B6, $B7
	.byte $FF, $FF, $FF, $C1, $C2, $C3, $C4, $FF
	.byte $FF, $FF, $CF, $D0, $D1, $D2, $D3, $FF
	.byte $FF, $DE, $DF, $FF, $E0, $E1, $FF, $FF
	.byte $EB, $EC, $FF, $FF, $ED
rom_88D9:
	.byte $05, $0B, $10, $B2, $00, $FF, $FF, $FF
	.byte $FF, $80, $FF, $FF, $FF, $0B, $81, $FF
	.byte $FF, $FF, $84, $85, $FF, $FF, $8D, $8E
	.byte $8F, $FF, $FF, $9B, $9C, $9D, $FF, $F6
	.byte $AB, $AC, $FF, $FF, $B8, $B9, $BA, $FF
	.byte $FF, $C5, $C6, $C7, $C8, $D4, $D5, $D6
	.byte $D7, $D8, $E2, $E3, $FF, $E4, $E5, $EE
	.byte $FF, $FF, $EF, $F0
rom_8915:
	.byte $06, $06, $10, $B0, $00, $FF, $FF, $FF
	.byte $65, $66, $FF, $FF, $67, $68, $69, $6A
	.byte $6B, $FF, $6C, $6D, $6E, $6F, $70, $FF
	.byte $71, $72, $73, $74, $75, $76, $77, $78
	.byte $79, $7A, $7B, $7C, $FF, $FF, $7D, $7E
	.byte $7F
rom_893E:
	.byte $04, $07, $10, $B0, $00, $0B, $0C, $FF
	.byte $FF, $18, $19, $1A, $FF, $28, $29, $2A
	.byte $FF, $37, $38, $39, $FF, $44, $45, $46
	.byte $47, $54, $55, $56, $57, $FF, $62, $63
	.byte $64
rom_895F:
	.byte $07, $06, $10, $B0, $00, $0D, $0E, $0F
	.byte $FF, $FF, $FF, $FF, $1B, $1C, $1D, $1E
	.byte $1F, $FF, $FF, $2B, $2C, $2D, $2E, $2F
	.byte $FF, $FF, $FF, $3A, $3B, $3C, $3D, $FF
	.byte $FF, $FF, $FF, $48, $49, $4A, $4B, $4C
	.byte $FF, $FF, $58, $59, $5A, $5B, $5C
rom_898E:
	.byte $05, $08, $10, $B0, $00, $FF, $FF, $FF
	.byte $01, $02, $FF, $FF, $05, $06, $07, $FF
	.byte $10, $11, $12, $FF, $FF, $20, $21, $22
	.byte $FF, $30, $31, $32, $33, $FF, $3E, $3F
	.byte $40, $41, $FF, $4D, $4E, $4F, $50, $FF
	.byte $5D, $FF, $5E, $5F, $FF
rom_89BB:
	.byte $06, $07, $10, $B6, $00, $FF, $FF, $81
	.byte $82, $83, $84, $FF, $FF, $8D, $8E, $8F
	.byte $90, $FF, $FF, $9E, $9F, $A0, $A1, $FF
	.byte $AD, $AE, $AF, $B0, $FF, $BD, $BE, $BF
	.byte $C0, $FF, $FF, $CD, $CE, $CF, $D0, $FF
	.byte $FF, $FF, $FF, $D8, $D9, $FF, $FF
rom_89EA:
	.byte $05, $05, $10, $B6, $00, $85, $FF, $86
	.byte $87, $88, $92, $93, $94, $95, $96, $A3
	.byte $A4, $A5, $A6, $A7, $B1, $B2, $B3, $B4
	.byte $B5, $C1, $C2, $A2, $C3, $A3
rom_8A08:
	.byte $06, $07, $10, $B6, $00, $FF, $FF, $FF
	.byte $FF, $89, $8A, $FF, $FF, $FF, $97, $98
	.byte $99, $FF, $FF, $FF, $A8, $A9, $FF, $FF
	.byte $FF, $B6, $B7, $B8, $B9, $C4, $C5, $C6
	.byte $C7, $C8, $C9, $D1, $D2, $D3, $D4, $FF
	.byte $FF, $DA, $DB, $DC, $DD, $FF, $FF
rom_8A37:
	.byte $04, $07, $10, $BC, $00, $10, $FF, $FF
	.byte $FF, $11, $FF, $FF, $12, $14, $15, $16
	.byte $17, $18, $19, $1A, $1B, $1C, $1D, $1E
	.byte $1F, $20, $21, $22, $13, $23, $24, $25
	.byte $26
rom_8A58:
	.byte $06, $03, $10, $AE, $00, $FF, $F0, $F1
	.byte $F2, $FF, $FF, $F3, $F4, $F5, $F6, $F7
	.byte $F8, $F9, $FA, $FB, $FC, $FD, $FE
rom_8A6F:
	.byte $03, $06, $10, $BA, $00, $FF, $A8, $FF
	.byte $B6, $B7, $FF, $C5, $C6, $C7, $D7, $D8
	.byte $D9, $EA, $EB, $EC, $FC, $FD, $FE
rom_8A86:
	.byte $03, $05, $10, $BC, $00, $FF, $01, $02
	.byte $03, $04, $05, $06, $07, $08, $09, $0A
	.byte $0B, $0C, $0D, $0E
rom_8A9A:
	.byte $04, $08, $10, $BA, $00, $FF, $89, $8A
	.byte $FF, $95, $96, $97, $FF, $A1, $A2, $A3
	.byte $A4, $AF, $B0, $B1, $B2, $BE, $BF, $C0
	.byte $C1, $CF, $D0, $D1, $D2, $E2, $E3, $E4
	.byte $E5, $F3, $F4, $F5, $F6
rom_8ABF:
	.byte $04, $08, $10, $BA, $00, $FF, $86, $87
	.byte $88, $91, $92, $93, $94, $9E, $9F, $A0
	.byte $FF, $AC, $AD, $AE, $FF, $BB, $BC, $BD
	.byte $FF, $CB, $CC, $CD, $CE, $DE, $DF, $E0
	.byte $E1, $F0, $FF, $F1, $F2
rom_8AE4:
	.byte $04, $09, $10, $BA, $00, $80, $81, $FF
	.byte $FF, $84, $85, $FF, $FF, $8F, $90, $FF
	.byte $FF, $9C, $9D, $FF, $FF, $A9, $AA, $AB
	.byte $FF, $B8, $B9, $BA, $FF, $C8, $C9, $CA
	.byte $FF, $DA, $DB, $DC, $DD, $ED, $FF, $EE
	.byte $EF
rom_8B0D:
	.byte $04, $0A, $10, $AA, $00, $FF, $E0, $E1
	.byte $FF, $FF, $E2, $E3, $FF, $E4, $E5, $E6
	.byte $E7, $E8, $E9, $EA, $EB, $FF, $EC, $ED
	.byte $FF, $FF, $EE, $EF, $F0, $FF, $F1, $F2
	.byte $F3, $F4, $F5, $F6, $F7, $FF, $F8, $F9
	.byte $FA, $FB, $FC, $FF, $FD
rom_8B3A:
	.byte $05, $0A, $10, $AE, $00, $85, $FF, $FF
	.byte $FF, $86, $90, $91, $92, $93, $94, $9F
	.byte $A0, $A1, $A2, $FF, $FF, $AF, $B0, $FF
	.byte $FF, $FF, $BD, $BE, $FF, $FF, $FF, $C9
	.byte $CA, $CB, $FF, $D6, $D7, $D8, $D9, $FF
	.byte $E0, $E1, $E2, $E3, $FF, $E9, $EA, $EB
	.byte $EC, $FF, $ED, $FF, $EE, $EF, $FF
rom_8B71:
	.byte $04, $09, $10, $AE, $00, $FF, $95, $96
	.byte $FF, $A3, $A4, $A5, $FF, $B1, $B2, $B3
	.byte $B4, $BF, $C0, $C1, $C2, $CC, $CD, $CE
	.byte $CF, $D6, $D7, $D8, $D9, $E0, $E1, $E2
	.byte $E3, $E9, $EA, $EB, $EC, $ED, $FF, $EE
	.byte $EF
rom_8B9A:
	.byte $04, $07, $10, $B0, $00, $0B, $0C, $FF
	.byte $FF, $18, $19, $1A, $FF, $28, $29, $2A
	.byte $FF, $37, $38, $39, $FF, $44, $45, $46
	.byte $47, $54, $55, $56, $57, $FF, $62, $63
	.byte $64
rom_8BBB:
	.byte $07, $06, $10, $B0, $00, $0D, $0E, $0F
	.byte $FF, $FF, $FF, $FF, $1B, $1C, $1D, $1E
	.byte $1F, $FF, $FF, $2B, $2C, $2D, $2E, $2F
	.byte $FF, $FF, $FF, $3A, $3B, $3C, $3D, $FF
	.byte $FF, $FF, $FF, $48, $49, $4A, $4B, $4C
	.byte $FF, $FF, $58, $59, $5A, $5B, $5C
rom_8BEA:
	.byte $05, $0A, $10, $B2, $00, $FF, $FF, $83
	.byte $FF, $FF, $FF, $FF, $89, $8A, $FF, $FF
	.byte $93, $94, $95, $FF, $A2, $A3, $A4, $A5
	.byte $A6, $B0, $B1, $B2, $B3, $B4, $FF, $FF
	.byte $BE, $BF, $C0, $FF, $FF, $CC, $CD, $CE
	.byte $FF, $FF, $DC, $DD, $FF, $FF, $FF, $E9
	.byte $EA, $FF, $FF, $FF, $F4, $F5, $FF
rom_8C21:
	.byte $06, $09, $10, $B8, $00, $03, $04, $05
	.byte $FF, $FF, $FF, $09, $0A, $0B, $FF, $FF
	.byte $FF, $11, $12, $13, $FF, $FF, $FF, $1D
	.byte $1E, $1F, $20, $FF, $FF, $FF, $2C, $2D
	.byte $2E, $2F, $FF, $FF, $39, $3A, $3B, $3C
	.byte $FF, $FF, $47, $48, $49, $4A, $FF, $FF
	.byte $57, $58, $FF, $59, $5A, $FF, $67, $FF
	.byte $FF, $FF, $FF
rom_8C5C:
	.byte $06, $09, $10, $B8, $00, $FF, $FF, $FF
	.byte $06, $FF, $FF, $FF, $FF, $0C, $0D, $FF
	.byte $FF, $FF, $14, $15, $16, $17, $18, $FF
	.byte $21, $22, $23, $24, $25, $FF, $30, $31
	.byte $FF, $FF, $FF, $FF, $3D, $3E, $3F, $FF
	.byte $FF, $4B, $4C, $4D, $4E, $FF, $FF, $5B
	.byte $5C, $5D, $5E, $FF, $FF, $68, $FF, $FF
	.byte $69, $6A, $FF
rom_8C97:
	.byte $04, $09, $10, $AE, $00, $FF, $80, $81
	.byte $82, $FF, $87, $88, $89, $FF, $97, $98
	.byte $99, $A6, $A7, $A8, $A9, $B5, $B6, $B7
	.byte $B8, $FF, $C3, $C4, $C5, $D0, $D1, $D2
	.byte $D3, $DA, $DB, $DC, $DD, $E4, $FF, $E5
	.byte $E6
rom_8CC0:
	.byte $07, $09, $10, $AE, $00, $FF, $FF, $FF
	.byte $83, $FF, $FF, $84, $FF, $8A, $8B, $8C
	.byte $8D, $8E, $8F, $FF, $9A, $9B, $9C, $9D
	.byte $9E, $FF, $AA, $AB, $AC, $AD, $AE, $FF
	.byte $FF, $B9, $BA, $BB, $BC, $FF, $FF, $FF
	.byte $C6, $FF, $C7, $C8, $FF, $FF, $FF, $FF
	.byte $FF, $D4, $D5, $FF, $FF, $FF, $FF, $FF
	.byte $DE, $DF, $FF, $FF, $FF, $FF, $FF, $E7
	.byte $E8, $FF, $FF, $FF
rom_8D04:
	.byte $04, $09, $10, $AC, $00, $FF, $4A, $FF
	.byte $FF, $34, $4B, $4C, $FF, $FF, $4D, $4E
	.byte $FF, $4F, $50, $51, $52, $FF, $57, $58
	.byte $59, $5E, $5F, $60, $61, $67, $68, $69
	.byte $6A, $70, $71, $72, $73, $77, $FF, $78
	.byte $79
rom_8D2D:
	.byte $07, $03, $10, $B6, $00, $FF, $EA, $EB
	.byte $EC, $ED, $FF, $FF, $EE, $EF, $F0, $F1
	.byte $F2, $F3, $F4, $F5, $F6, $F7, $F8, $F9
	.byte $FA, $FB
rom_8D47:
	.byte $05, $09, $10, $B6, $40, $FF, $FF, $8C
	.byte $8B, $FF, $FF, $9D, $9C, $9B, $9A, $FF
	.byte $FF, $AC, $AB, $AA, $FF, $FF, $BC, $BB
	.byte $BA, $FF, $CC, $CB, $CA, $FF, $FF, $D7
	.byte $D6, $D5, $FF, $FF, $E1, $E0, $DF, $DE
	.byte $FF, $E5, $E4, $E3, $E2, $E9, $E8, $FF
	.byte $E7, $E6
rom_8D79:
	.byte $06, $07, $10, $B6, $00, $FF, $FF, $81
	.byte $82, $83, $84, $FF, $FF, $8D, $8E, $8F
	.byte $90, $FF, $FF, $9E, $9F, $A0, $A1, $FF
	.byte $AD, $AE, $AF, $B0, $FF, $BD, $BE, $BF
	.byte $C0, $FF, $FF, $CD, $CE, $CF, $D0, $FF
	.byte $FF, $FF, $FF, $D8, $D9, $FF, $FF
rom_8DA8:
	.byte $06, $07, $10, $B6, $C0, $FF, $FF, $DD
	.byte $DC, $DB, $DA, $FF, $FF, $D4, $D3, $D2
	.byte $D1, $C9, $C8, $C7, $C6, $C5, $C4, $B9
	.byte $B8, $B7, $B6, $FF, $FF, $FF, $A9, $A8
	.byte $FF, $FF, $FF, $99, $98, $97, $FF, $FF
	.byte $FF, $8A, $89, $FF, $FF, $FF, $FF

; -----------------------------------------------------------------------------

; The rest is unused junk
