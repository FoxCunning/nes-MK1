.segment "BANK_0B"
; $8000-$9FFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"


; -----------------------------------------------------------------------------

; Data pointers for Liu Kang
rom_0B_8000:
	.word rom_8004, rom_82C7

; -----------------------------------------------------------------------------

rom_8004:
	.byte $09
	.word anim_liukang_idle
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
	.byte $18
	.word anim_liukang_staggered
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

anim_liukang_idle:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $01, $01, $01, $01, $01, $01, $01, $01
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
	.byte $2F, $2F, $30, $30, $30, $30, $30, $30
	.byte $30, $30, $0C, $0C, $0D, $0D, $0C, $0C
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
anim_liukang_staggered:
	.byte $2A, $2A, $2A, $2A, $2A, $2A, $2A, $2A
	.byte $2B, $2B, $2B, $2B, $2B, $2B, $2B, $2B
	.byte $2A, $2A, $2A, $2A, $2A, $2A, $2A, $2A
	.byte $2B, $2B, $2B, $2B, $2B, $2B
rom_8262:
	.byte $2C, $2C, $2C, $2C, $2C, $2C
rom_8268:
	.byte $2D, $2D, $2D, $2D, $2E, $2E, $03, $09
rom_8270:
	.byte $37
rom_8271:
	.byte $22, $22, $22, $23, $23, $23, $24, $24
	.byte $24, $24, $24, $24, $24, $24, $24, $24
	.byte $24, $37, $37, $00, $00
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
	.word liukang_frame_00, liukang_frame_01, liukang_frame_02, rom_8400
	.word rom_8421, rom_844A, rom_846A, rom_848A
	.word rom_84AA, rom_84D3, rom_84FC, rom_851D
	.word rom_853E, rom_8552, rom_8566, rom_858F
	.word rom_85C1, rom_85FC, rom_861F, rom_8642
	.word rom_8665, rom_8697, rom_86DB, rom_871F
	.word rom_8754, rom_8779, rom_87A6, rom_87D8
	.word rom_87FB, rom_8830, rom_886C, rom_88A1
	.word rom_88C4, rom_88E7, rom_8919, rom_8941
	.word rom_896A, rom_8987, rom_89A5, rom_89B8
	.word rom_89D1, rom_89FA, rom_8A18, rom_8A3D
	.word rom_8A66, rom_8A98, rom_8AB8, rom_8AD8
	.word rom_8AFB, rom_8B1E, rom_8B47, rom_8B74
	.word rom_8B9D, rom_8BD8, rom_8C13, rom_8C3C
	.word rom_8C56, rom_8C7F, rom_8CA7, liukang_frame_00
	.word liukang_frame_00, liukang_frame_00, liukang_frame_00, liukang_frame_00
	.word liukang_frame_00, liukang_frame_00, liukang_frame_00, liukang_frame_00
	.word liukang_frame_00, liukang_frame_00, liukang_frame_00, liukang_frame_00
	.word liukang_frame_00, liukang_frame_00, liukang_frame_00, liukang_frame_00
	.word liukang_frame_00, liukang_frame_00, liukang_frame_00, liukang_frame_00
	.word liukang_frame_00, liukang_frame_00, liukang_frame_00, liukang_frame_00
	.word liukang_frame_00, liukang_frame_00, liukang_frame_00, liukang_frame_00
	.word liukang_frame_00, liukang_frame_00, liukang_frame_00, liukang_frame_00
	.word liukang_frame_00, liukang_frame_00, liukang_frame_00, liukang_frame_00
	.word liukang_frame_00, liukang_frame_00, liukang_frame_00, liukang_frame_00
	.word liukang_frame_00

; -----------------------------------------------------------------------------

liukang_frame_00:
	.byte $04, $09, $10, $74, $00, $FF, $01, $02
	.byte $FF, $FF, $09, $0A, $FF, $17, $18, $19
	.byte $FF, $28, $29, $2A, $2B, $FF, $35, $36
	.byte $37, $41, $42, $43, $44, $4F, $50, $51
	.byte $52, $5E, $5F, $60, $61, $6D, $6E, $FF
	.byte $6F
liukang_frame_01:
	.byte $04, $09, $10, $74, $00, $FF, $03, $04
	.byte $FF, $FF, $0B, $0C, $FF, $1A, $1B, $1C
	.byte $FF, $2C, $2D, $2E, $2F, $FF, $38, $39
	.byte $3A, $45, $46, $47, $48, $53, $54, $55
	.byte $56, $62, $63, $64, $65, $71, $FF, $FF
	.byte $72
liukang_frame_02:
	.byte $04, $06, $10, $76, $00, $FF, $FF, $82
	.byte $FF, $FF, $88, $89, $8A, $90, $91, $92
	.byte $93, $98, $99, $9A, $9B, $9F, $A0, $A1
	.byte $A2, $A7, $A8, $FC, $A9
rom_8400:
	.byte $04, $07, $10, $82, $00, $D2, $D3, $D4
	.byte $FF, $D7, $D8, $D9, $FF, $DE, $DF, $FF
	.byte $FF, $E4, $E5, $FF, $FF, $E9, $EA, $EB
	.byte $EC, $F0, $F1, $F2, $F3, $F7, $F8, $F9
	.byte $FA
rom_8421:
	.byte $04, $09, $18, $7C, $00, $FF, $01, $02
	.byte $FF, $FF, $07, $08, $09, $FF, $0F, $10
	.byte $11, $FF, $1A, $1B, $1C, $FF, $27, $28
	.byte $29, $FF, $3A, $3B, $3C, $4A, $4B, $4C
	.byte $4D, $5D, $5E, $5F, $60, $6E, $6F, $70
	.byte $71
rom_844A:
	.byte $03, $09, $10, $7C, $00, $03, $04, $FF
	.byte $0A, $0B, $0C, $12, $13, $14, $1D, $1E
	.byte $1F, $2B, $2C, $2D, $3D, $2C, $3E, $4E
	.byte $4F, $FF, $61, $62, $FF, $72, $73, $FF
rom_846A:
	.byte $03, $09, $10, $7C, $00, $03, $04, $FF
	.byte $0A, $0B, $0C, $12, $13, $14, $20, $1E
	.byte $1F, $2F, $30, $2D, $3F, $40, $41, $50
	.byte $51, $52, $63, $64, $65, $74, $75, $76
rom_848A:
	.byte $03, $09, $10, $7C, $00, $01, $02, $FF
	.byte $07, $08, $09, $0F, $10, $11, $1A, $1B
	.byte $1C, $31, $2C, $32, $42, $2C, $43, $53
	.byte $54, $55, $66, $67, $FF, $77, $78, $FF
rom_84AA:
	.byte $04, $09, $10, $7C, $00, $05, $06, $FF
	.byte $FF, $0D, $0E, $FF, $FF, $15, $16, $17
	.byte $FF, $21, $22, $23, $FF, $33, $34, $35
	.byte $36, $44, $2C, $45, $FF, $56, $57, $58
	.byte $FF, $68, $69, $6A, $FF, $79, $7A, $7B
	.byte $7C
rom_84D3:
	.byte $04, $09, $10, $7E, $00, $FF, $8C, $8D
	.byte $8E, $FF, $99, $9A, $9B, $FF, $A7, $A8
	.byte $FF, $FF, $B5, $B6, $FF, $FF, $C6, $C7
	.byte $C8, $FF, $D5, $D6, $D7, $DE, $DF, $E0
	.byte $E1, $E4, $E5, $E6, $E7, $E9, $FF, $EA
	.byte $EB
rom_84FC:
	.byte $04, $07, $10, $7A, $00, $FF, $9F, $A0
	.byte $FF, $AA, $AB, $AC, $FF, $B5, $B6, $B7
	.byte $F8, $BF, $C0, $C1, $C2, $CD, $F9, $FA
	.byte $CE, $D9, $DA, $DB, $DC, $E8, $E9, $EA
	.byte $EB
rom_851D:
	.byte $04, $07, $10, $7C, $00, $FF, $FF, $18
	.byte $19, $FF, $24, $25, $26, $FF, $37, $38
	.byte $39, $46, $47, $48, $49, $59, $5A, $5B
	.byte $5C, $FF, $6B, $6C, $6D, $FF, $7D, $7E
	.byte $FF
rom_853E:
	.byte $03, $05, $10, $7E, $00, $FF, $EC, $ED
	.byte $EE, $EF, $F0, $F1, $F2, $F3, $F4, $F5
	.byte $F6, $FF, $FF, $F7
rom_8552:
	.byte $03, $05, $10, $7E, $40, $ED, $EC, $FF
	.byte $F0, $EF, $EE, $F3, $F2, $F1, $F6, $F5
	.byte $F4, $F7, $FF, $FF
rom_8566:
	.byte $04, $09, $10, $86, $00, $80, $81, $FF
	.byte $FF, $86, $87, $88, $FF, $91, $92, $93
	.byte $FF, $A0, $A1, $A2, $FF, $FF, $AD, $AE
	.byte $AF, $FF, $BB, $F5, $BC, $C5, $C6, $C7
	.byte $C8, $D2, $D3, $D4, $D5, $DB, $FF, $FF
	.byte $DC
rom_858F:
	.byte $05, $09, $10, $76, $00, $FB, $AD, $AE
	.byte $FF, $FF, $B4, $B5, $B6, $B7, $FF, $C0
	.byte $C1, $C2, $C3, $FF, $CB, $CC, $CD, $CE
	.byte $CF, $D6, $D7, $D8, $D9, $DA, $FF, $E2
	.byte $E3, $E4, $E5, $FF, $EB, $EC, $FF, $FF
	.byte $FF, $FF, $F2, $FF, $FF, $FF, $FF, $F8
	.byte $FF, $FF
rom_85C1:
	.byte $06, $09, $10, $76, $00, $FF, $FF, $FF
	.byte $FF, $AF, $B0, $B8, $B9, $FF, $BA, $BB
	.byte $BC, $C4, $C5, $C6, $C7, $C8, $FF, $D0
	.byte $D1, $D2, $D3, $FF, $FF, $DB, $DC, $DD
	.byte $DE, $FF, $FF, $FF, $E6, $E7, $FF, $FF
	.byte $FF, $FF, $FF, $ED, $FF, $FF, $FF, $FF
	.byte $FF, $F3, $FF, $FF, $FF, $FF, $F9, $FA
	.byte $FF, $FF, $FF
rom_85FC:
	.byte $05, $06, $10, $88, $00, $FF, $07, $FF
	.byte $FF, $FF, $0F, $10, $11, $FF, $FF, $1E
	.byte $1F, $20, $21, $FF, $2D, $2E, $2F, $30
	.byte $FF, $3B, $3C, $3D, $3E, $3F, $FF, $49
	.byte $4A, $4B, $4C
rom_861F:
	.byte $05, $06, $10, $88, $00, $FF, $07, $FF
	.byte $FF, $FF, $0F, $10, $11, $FF, $FF, $1E
	.byte $1F, $20, $21, $FF, $2D, $2E, $2F, $30
	.byte $FF, $3B, $3C, $3D, $3E, $3F, $FF, $49
	.byte $4A, $4B, $4C
rom_8642:
	.byte $06, $05, $10, $88, $00, $69, $6A, $FF
	.byte $FF, $FF, $FF, $6B, $6C, $6D, $FF, $FF
	.byte $FF, $6E, $6F, $70, $71, $72, $FF, $73
	.byte $74, $41, $75, $76, $77, $FF, $78, $79
	.byte $7A, $FF, $37
rom_8665:
	.byte $05, $09, $10, $76, $00, $FF, $FF, $FF
	.byte $AB, $AC, $FF, $FF, $B1, $B2, $B3, $FF
	.byte $FF, $BD, $BE, $BF, $FF, $FF, $C9, $CA
	.byte $FF, $FF, $85, $D4, $D5, $FF, $FF, $DF
	.byte $E0, $E1, $FF, $FF, $E8, $E9, $EA, $FF
	.byte $EE, $EF, $F0, $F1, $FF, $F4, $F5, $F6
	.byte $F7, $FF
rom_8697:
	.byte $07, $09, $10, $74, $00, $FF, $FF, $FF
	.byte $07, $08, $FF, $FF, $FF, $FF, $12, $13
	.byte $14, $15, $16, $FF, $FF, $23, $24, $25
	.byte $26, $27, $FF, $FF, $33, $34, $FF, $FF
	.byte $FF, $FF, $3E, $3F, $40, $FF, $FF, $FF
	.byte $FF, $4C, $4D, $4E, $FF, $FF, $FF, $45
	.byte $5B, $5C, $5D, $FF, $FF, $FF, $69, $6A
	.byte $6B, $6C, $FF, $FF, $FF, $76, $FF, $77
	.byte $78, $FF, $FF, $FF
rom_86DB:
	.byte $07, $09, $10, $74, $00, $FF, $FF, $FF
	.byte $05, $06, $FF, $FF, $FF, $FF, $0D, $0E
	.byte $0F, $10, $11, $FF, $1D, $1E, $1F, $20
	.byte $21, $22, $FF, $30, $31, $32, $FF, $FF
	.byte $FF, $FF, $3B, $3C, $3D, $FF, $FF, $FF
	.byte $FF, $49, $4A, $4B, $FF, $FF, $FF, $57
	.byte $58, $59, $5A, $FF, $FF, $FF, $66, $67
	.byte $FF, $68, $FF, $FF, $FF, $74, $FF, $FF
	.byte $75, $FF, $FF, $FF
rom_871F:
	.byte $08, $06, $10, $7E, $00, $FF, $FF, $FF
	.byte $8F, $90, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $F8, $9C, $9D, $9E, $FF, $FF, $FF, $FF
	.byte $A9, $AA, $AB, $AC, $FF, $B7, $B8, $B9
	.byte $BA, $BB, $BC, $BD, $BE, $C9, $CA, $CB
	.byte $CC, $CD, $CE, $CF, $D0, $FF, $FF, $FF
	.byte $D8, $D9, $DA, $FF, $FF
rom_8754:
	.byte $04, $08, $10, $78, $00, $FF, $FF, $0B
	.byte $0C, $FF, $FF, $17, $18, $FF, $24, $25
	.byte $26, $FF, $34, $35, $36, $FF, $44, $45
	.byte $46, $FF, $53, $54, $55, $62, $63, $64
	.byte $65, $71, $72, $73, $74
rom_8779:
	.byte $04, $0A, $10, $78, $00, $FF, $01, $02
	.byte $03, $FF, $05, $06, $07, $10, $11, $12
	.byte $13, $1C, $1D, $1E, $FF, $2B, $2C, $2D
	.byte $FF, $3B, $3C, $3D, $FF, $FF, $4B, $4C
	.byte $FF, $10, $5A, $5B, $FF, $6A, $6B, $6C
	.byte $FF, $79, $7A, $7B, $FF
rom_87A6:
	.byte $05, $09, $10, $78, $00, $FF, $FF, $04
	.byte $FF, $FF, $FF, $0D, $0E, $0F, $FF, $FF
	.byte $19, $1A, $1B, $FF, $FF, $27, $28, $29
	.byte $2A, $FF, $37, $38, $39, $3A, $FF, $47
	.byte $48, $49, $4A, $FF, $57, $58, $59, $FF
	.byte $66, $67, $68, $69, $FF, $76, $FF, $77
	.byte $78, $FF
rom_87D8:
	.byte $05, $06, $10, $76, $00, $FF, $FF, $FF
	.byte $80, $81, $83, $84, $85, $86, $87, $8B
	.byte $8C, $8D, $8E, $8F, $94, $95, $96, $97
	.byte $FF, $9C, $9D, $9E, $FF, $FF, $A3, $A4
	.byte $A5, $A6, $FF
rom_87FB:
	.byte $06, $08, $10, $80, $00, $FF, $12, $13
	.byte $FF, $FF, $FF, $1E, $1F, $20, $21, $FF
	.byte $FF, $2A, $2B, $2C, $2D, $2E, $FF, $38
	.byte $39, $3A, $3B, $3C, $FF, $FF, $FF, $46
	.byte $3E, $47, $FF, $FF, $FF, $51, $52, $53
	.byte $FF, $FF, $FF, $5D, $5E, $5F, $60, $FF
	.byte $FF, $6B, $6C, $6D, $6E
rom_8830:
	.byte $05, $0B, $10, $80, $00, $FF, $01, $02
	.byte $FF, $FF, $FF, $03, $04, $05, $FF, $FF
	.byte $0A, $0B, $0C, $FF, $FF, $14, $15, $16
	.byte $FF, $FF, $22, $23, $24, $FF, $FF, $2F
	.byte $30, $31, $FF, $FF, $3D, $3E, $3F, $FF
	.byte $FF, $48, $3E, $49, $FF, $FF, $54, $55
	.byte $56, $FF, $61, $62, $FF, $63, $FF, $6F
	.byte $FF, $FF, $70, $71
rom_886C:
	.byte $06, $08, $10, $80, $00, $FF, $FF, $FF
	.byte $17, $18, $FF, $FF, $FF, $25, $26, $27
	.byte $FF, $FF, $FF, $32, $33, $34, $35, $FF
	.byte $40, $41, $42, $43, $44, $FF, $4A, $4B
	.byte $4C, $4D, $4E, $FF, $57, $58, $59, $5A
	.byte $FF, $FF, $64, $65, $66, $67, $FF, $72
	.byte $73, $FF, $74, $75, $FF
rom_88A1:
	.byte $05, $06, $10, $88, $00, $FF, $07, $FF
	.byte $FF, $FF, $0F, $10, $11, $FF, $FF, $1E
	.byte $1F, $20, $21, $FF, $2D, $2E, $2F, $30
	.byte $FF, $3B, $3C, $3D, $3E, $3F, $FF, $49
	.byte $4A, $4B, $4C
rom_88C4:
	.byte $06, $05, $10, $88, $00, $69, $6A, $FF
	.byte $FF, $FF, $FF, $6B, $6C, $6D, $FF, $FF
	.byte $FF, $6E, $6F, $70, $71, $72, $FF, $73
	.byte $74, $41, $75, $76, $77, $FF, $78, $79
	.byte $7A, $FF, $37
rom_88E7:
	.byte $05, $09, $10, $88, $00, $FF, $FF, $03
	.byte $04, $FF, $FF, $FF, $0A, $0B, $0C, $FF
	.byte $16, $17, $18, $19, $FF, $26, $27, $28
	.byte $FF, $FF, $34, $35, $36, $FF, $FF, $43
	.byte $44, $45, $FF, $FF, $51, $41, $52, $FF
	.byte $59, $5A, $5B, $5C, $FF, $63, $64, $65
	.byte $66, $FF
rom_8919:
	.byte $05, $07, $10, $82, $00, $FF, $FF, $81
	.byte $82, $83, $FF, $84, $85, $86, $87, $FF
	.byte $8D, $8E, $8F, $FF, $FF, $98, $99, $9A
	.byte $FF, $A3, $A4, $A5, $A6, $FF, $B0, $B1
	.byte $B2, $B3, $FF, $C3, $C4, $C5, $FF, $FF
rom_8941:
	.byte $06, $06, $10, $82, $00, $FF, $FF, $88
	.byte $89, $8A, $FF, $90, $91, $92, $93, $94
	.byte $95, $9B, $9C, $9D, $9E, $9F, $A0, $FF
	.byte $FF, $A7, $A8, $A9, $AA, $FF, $FF, $B4
	.byte $B5, $B6, $B7, $FF, $FF, $C6, $FF, $FF
	.byte $FF
rom_896A:
	.byte $04, $06, $10, $82, $00, $FF, $FF, $8B
	.byte $8C, $FF, $FF, $96, $97, $FF, $FF, $A1
	.byte $A2, $FF, $FF, $AB, $AC, $B8, $B9, $BA
	.byte $BB, $C7, $C8, $C9, $CA
rom_8987:
	.byte $05, $05, $10, $8A, $00, $FF, $FF, $FF
	.byte $FF, $B2, $B3, $B4, $B5, $B6, $B7, $B8
	.byte $B9, $BA, $BB, $BC, $FF, $BD, $BE, $BF
	.byte $FF, $FF, $C0, $C1, $C2, $C3
rom_89A5:
	.byte $07, $02, $10, $84, $00, $65, $66, $67
	.byte $68, $69, $6A, $6B, $79, $7A, $7B, $7C
	.byte $7D, $7E, $7F
rom_89B8:
	.byte $04, $05, $10, $80, $00, $4F, $50, $FF
	.byte $FF, $FF, $5B, $5C, $FF, $FF, $68, $69
	.byte $6A, $76, $77, $78, $79, $7A, $7B, $7C
	.byte $7D
rom_89D1:
	.byte $06, $06, $10, $82, $00, $FF, $FF, $FF
	.byte $FF, $D5, $D6, $FF, $FF, $DA, $DB, $DC
	.byte $DD, $FF, $FF, $E0, $E1, $E2, $E3, $FF
	.byte $E6, $E7, $E8, $FF, $FF, $ED, $EE, $EF
	.byte $FF, $FF, $FF, $F4, $F5, $F6, $FF, $FF
	.byte $FF
rom_89FA:
	.byte $05, $05, $10, $80, $00, $06, $07, $08
	.byte $09, $FF, $0D, $0E, $0F, $10, $11, $19
	.byte $1A, $1B, $1C, $1D, $FF, $FF, $FF, $28
	.byte $29, $FF, $FF, $FF, $36, $37
rom_8A18:
	.byte $04, $08, $10, $84, $00, $FF, $FF, $10
	.byte $11, $FF, $1C, $1D, $1E, $FF, $28, $29
	.byte $2A, $34, $35, $36, $37, $42, $43, $44
	.byte $45, $4F, $50, $51, $52, $5F, $60, $61
	.byte $56, $73, $FF, $74, $75
rom_8A3D:
	.byte $04, $09, $10, $84, $00, $FF, $07, $08
	.byte $FF, $12, $13, $14, $FF, $1F, $20, $21
	.byte $FF, $2B, $2C, $2D, $FF, $38, $39, $3A
	.byte $3B, $46, $47, $48, $49, $53, $54, $55
	.byte $56, $62, $63, $64, $56, $76, $FF, $77
	.byte $78
rom_8A66:
	.byte $05, $09, $10, $88, $00, $FF, $01, $02
	.byte $FF, $FF, $FF, $08, $09, $FF, $FF, $12
	.byte $13, $14, $15, $FF, $22, $23, $24, $25
	.byte $FF, $FF, $31, $32, $33, $FF, $40, $2F
	.byte $41, $42, $FF, $4D, $4E, $4F, $50, $FF
	.byte $55, $56, $57, $58, $FF, $5F, $60, $FF
	.byte $61, $62
rom_8A98:
	.byte $03, $09, $10, $8A, $00, $80, $81, $FF
	.byte $84, $85, $86, $8A, $8B, $8C, $90, $91
	.byte $92, $96, $97, $98, $9B, $9C, $9D, $A1
	.byte $A2, $A3, $A6, $A7, $A8, $AC, $AD, $AE
rom_8AB8:
	.byte $03, $09, $10, $8A, $00, $82, $83, $FF
	.byte $87, $88, $89, $8D, $8E, $8F, $93, $94
	.byte $95, $99, $B1, $9A, $9E, $9F, $A0, $A4
	.byte $A5, $C6, $A9, $AA, $AB, $AF, $FF, $B0
rom_8AD8:
	.byte $05, $06, $10, $88, $00, $FF, $07, $FF
	.byte $FF, $FF, $0F, $10, $11, $FF, $FF, $1E
	.byte $1F, $20, $21, $FF, $2D, $2E, $2F, $30
	.byte $FF, $3B, $3C, $3D, $3E, $3F, $FF, $49
	.byte $4A, $4B, $4C
rom_8AFB:
	.byte $06, $05, $10, $88, $00, $69, $6A, $FF
	.byte $FF, $FF, $FF, $6B, $6C, $6D, $FF, $FF
	.byte $FF, $6E, $6F, $70, $71, $72, $FF, $73
	.byte $74, $41, $75, $76, $77, $FF, $78, $79
	.byte $7A, $FF, $37
rom_8B1E:
	.byte $04, $09, $10, $88, $00, $05, $06, $FF
	.byte $FF, $0D, $0E, $FF, $FF, $1A, $1B, $1C
	.byte $1D, $29, $2A, $2B, $2C, $37, $38, $39
	.byte $3A, $FF, $46, $47, $48, $FF, $53, $54
	.byte $FF, $FF, $5D, $5E, $FF, $FF, $67, $68
	.byte $FF
rom_8B47:
	.byte $05, $08, $10, $86, $00, $FF, $89, $8A
	.byte $FF, $FF, $94, $95, $96, $97, $FF, $A3
	.byte $A4, $A5, $A6, $FF, $FF, $B0, $B1, $B2
	.byte $FF, $FF, $BD, $F6, $F7, $FF, $FF, $F9
	.byte $C9, $CA, $FF, $FF, $D6, $D7, $D8, $D9
	.byte $DE, $DF, $FF, $E0, $E1
rom_8B74:
	.byte $04, $09, $10, $86, $00, $FF, $82, $83
	.byte $FF, $8B, $8C, $8D, $8E, $98, $99, $9A
	.byte $9B, $A7, $A8, $F5, $A9, $B3, $B4, $B5
	.byte $B6, $BE, $BF, $C0, $C1, $FF, $CB, $CC
	.byte $FF, $FF, $DA, $FF, $FF, $FF, $E2, $FF
	.byte $FF
rom_8B9D:
	.byte $06, $09, $10, $7A, $00, $FF, $FF, $93
	.byte $94, $FF, $FF, $97, $98, $99, $9A, $9B
	.byte $FF, $A3, $A4, $A5, $A6, $A7, $FF, $FF
	.byte $FF, $B0, $B1, $B2, $FF, $FF, $FF, $FB
	.byte $BB, $BC, $FF, $FF, $FF, $C7, $C8, $C9
	.byte $FF, $FF, $FF, $D3, $D4, $F8, $FF, $FF
	.byte $FF, $E2, $E3, $E4, $FF, $FF, $F0, $F1
	.byte $F2, $F3, $FF
rom_8BD8:
	.byte $06, $09, $10, $78, $00, $FF, $FF, $FF
	.byte $08, $09, $0A, $FF, $FF, $14, $15, $16
	.byte $FF, $1F, $20, $21, $22, $23, $FF, $2E
	.byte $2F, $30, $31, $FF, $FF, $3E, $3F, $40
	.byte $FF, $FF, $FF, $4D, $4E, $4F, $FF, $FF
	.byte $FF, $5C, $5D, $5E, $FF, $FF, $FF, $FF
	.byte $FF, $6D, $FF, $FF, $FF, $FF, $7C, $7D
	.byte $FF, $FF, $FF
rom_8C13:
	.byte $04, $09, $10, $7A, $00, $FF, $FF, $95
	.byte $96, $FF, $9C, $9D, $9E, $FF, $A8, $A9
	.byte $FF, $FF, $B3, $B4, $FF, $FF, $BD, $BE
	.byte $FF, $FC, $CA, $CB, $CC, $D5, $D6, $D7
	.byte $D8, $E5, $8F, $E6, $E7, $F4, $FF, $F5
	.byte $F6
rom_8C3C:
	.byte $07, $03, $10, $82, $00, $FF, $FF, $AD
	.byte $AE, $AE, $FF, $AF, $BC, $BD, $BE, $BF
	.byte $C0, $C1, $C2, $CB, $CC, $CD, $CE, $CF
	.byte $D0, $D1
rom_8C56:
	.byte $04, $09, $10, $86, $40, $FF, $FF, $81
	.byte $80, $FF, $88, $87, $86, $FF, $93, $92
	.byte $91, $FF, $A2, $A1, $A0, $AF, $AE, $AD
	.byte $FF, $BC, $F5, $BB, $FF, $C8, $C7, $C6
	.byte $C5, $D5, $D4, $D3, $D2, $DC, $FF, $FF
	.byte $DB
rom_8C7F:
	.byte $05, $07, $10, $82, $00, $FF, $FF, $81
	.byte $82, $83, $FF, $84, $85, $86, $87, $FF
	.byte $8D, $8E, $8F, $FF, $FF, $98, $99, $9A
	.byte $FF, $A3, $A4, $A5, $A6, $FF, $B0, $B1
	.byte $B2, $B3, $FF, $C3, $C4, $C5, $FF, $FF
rom_8CA7:
	.byte $04, $06, $10, $82, $C0, $CA, $C9, $C8
	.byte $C7, $BB, $BA, $B9, $B8, $AC, $AB, $FF
	.byte $FF, $A2, $A1, $FF, $FF, $97, $96, $FF
	.byte $FF, $8C, $8B, $FF, $FF

; -----------------------------------------------------------------------------

; Nothing is used past this point, apparently
