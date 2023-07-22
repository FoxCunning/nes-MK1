.segment "BANK_0A"
; $8000-$9FFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"


; -----------------------------------------------------------------------------

; Data pointers for Johnny Cage
rom_8000:
	.word rom_8004, rom_82C7

; -----------------------------------------------------------------------------

rom_8004:
	.byte $09
	.word anim_cage_idle
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
	.byte $2B
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
	.word anim_ranged_attack
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
	.word anim_cage_staggered
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
	.word rom_8271 ;rom_8292
	.byte $18
	.word anim_special_hit ;rom_82A1
	.byte $04
	.word rom_80ED

; -----------------------------------------------------------------------------

anim_cage_idle:
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
	
; Also use the next two, for a total of 30 frames
anim_special_hit:
	.byte $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E
	.byte $0E, $0E, $0E, $0E, $0E, $0E
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
	.byte $35, $35, $36, $36, $32, $32, $32, $32
	.byte $32, $33, $33, $33, $33, $33, $33, $33
	.byte $33, $33, $33, $33, $33, $33, $33, $33
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
	.byte $30, $30, $30, $30, $30, $30, $30, $30
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
anim_ranged_attack:
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
anim_cage_staggered:
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
	.word cage_frame_00, frame_idle_01, rom_83F5, rom_840E
	.word rom_842F, rom_846A, rom_849C, rom_84CE
	.word rom_8500, rom_8532, rom_855B, rom_8578
	.word rom_8598, rom_85B1, rom_85CA, rom_85FC
	.word rom_8629, rom_8664, rom_8696, rom_86C8
	.word rom_86FE, rom_872B, rom_8766, rom_87A7
	.word rom_87CF, rom_87F8, rom_8829, rom_885B
	.word rom_8883, rom_88B8, rom_88EF, rom_8924
	.word rom_8941, rom_8977, rom_89AE, rom_89D6
	.word rom_89F3, rom_8A1C, rom_8A3F, rom_8A5C
	.word rom_8A76, rom_8A8F, rom_8ABE, rom_8AE7
	.word rom_8B10, rom_8B39, rom_8B62, rom_8B8F
	.word rom_8BBC, rom_8C01, rom_8C33, rom_8C60
	.word rom_8C9D, rom_8CCF, rom_8D0A, rom_8D2A
	.word rom_8D4B, rom_8D7D, rom_8DA5, cage_frame_00
	.word cage_frame_00, cage_frame_00, cage_frame_00, cage_frame_00
	.word cage_frame_00, cage_frame_00, cage_frame_00, cage_frame_00
	.word cage_frame_00, cage_frame_00, cage_frame_00, cage_frame_00
	.word cage_frame_00, cage_frame_00, cage_frame_00, cage_frame_00
	.word cage_frame_00, cage_frame_00, cage_frame_00, cage_frame_00
	.word cage_frame_00, cage_frame_00, cage_frame_00, cage_frame_00
	.word cage_frame_00, cage_frame_00, cage_frame_00, cage_frame_00
	.word cage_frame_00, cage_frame_00, cage_frame_00, cage_frame_00
	.word cage_frame_00, cage_frame_00, cage_frame_00, cage_frame_00
	.word cage_frame_00, cage_frame_00, cage_frame_00, cage_frame_00
	.word cage_frame_00

; -----------------------------------------------------------------------------

cage_frame_00:
	.byte $05, $09, $10, $8C, $00, $FF, $01, $02
	.byte $FF, $FF, $0C, $0D, $0E, $FF, $0F, $1E
	.byte $1F, $20, $21, $22, $30, $31, $32, $33
	.byte $FF, $40, $41, $42, $FF, $FF, $4D, $4E
	.byte $4F, $50, $FF, $55, $56, $57, $58, $FF
	.byte $5A, $FF, $5B, $5C, $FF, $5F, $FF, $FF
	.byte $60, $FF
frame_idle_01:
	.byte $05, $09, $10, $8E, $00, $FF, $80, $81
	.byte $FF, $FF, $FF, $85, $86, $FF, $FF, $93
	.byte $94, $95, $96, $97, $A7, $A8, $A9, $AA
	.byte $AB, $BC, $BD, $BE, $FF, $FF, $CF, $D0
	.byte $D1, $D2, $FF, $E1, $E2, $E3, $E4, $FF
	.byte $EE, $FF, $FF, $EF, $FF, $F9, $FF, $FF
	.byte $FA, $FB
rom_83F5:
	.byte $04, $05, $10, $90, $00, $FF, $33, $34
	.byte $FF, $45, $46, $47, $48, $5C, $5D, $5E
	.byte $5F, $6C, $6D, $6E, $6F, $79, $FF, $FF
	.byte $7A
rom_840E:
	.byte $04, $07, $10, $90, $00, $15, $16, $17
	.byte $FF, $22, $23, $24, $FF, $30, $31, $32
	.byte $FF, $42, $43, $44, $FF, $58, $59, $5A
	.byte $5B, $6C, $6D, $6E, $6F, $79, $FF, $FF
	.byte $7A
rom_842F:
	.byte $06, $09, $18, $94, $00, $FF, $FF, $01
	.byte $02, $FF, $FF, $FF, $05, $06, $07, $FF
	.byte $08, $FF, $0E, $0F, $10, $11, $12, $FF
	.byte $18, $19, $1A, $FF, $FF, $FF, $1D, $1E
	.byte $1F, $FF, $FF, $FF, $28, $29, $2A, $FF
	.byte $FF, $38, $39, $3A, $3B, $FF, $FF, $49
	.byte $4A, $4B, $4C, $FF, $FF, $58, $FF, $59
	.byte $5A, $FF, $FF
rom_846A:
	.byte $05, $09, $10, $94, $00, $FF, $03, $04
	.byte $FF, $FF, $09, $0A, $0B, $0C, $0D, $13
	.byte $14, $15, $16, $17, $1B, $1C, $1A, $FF
	.byte $FF, $20, $21, $1F, $FF, $FF, $2B, $2C
	.byte $2D, $FF, $FF, $3C, $3D, $3E, $FF, $FF
	.byte $4D, $4E, $4F, $FF, $FF, $5B, $5C, $5D
	.byte $FF, $FF
rom_849C:
	.byte $05, $09, $10, $94, $00, $FF, $01, $02
	.byte $FF, $FF, $05, $06, $07, $FF, $08, $0E
	.byte $0F, $10, $11, $12, $18, $19, $1A, $FF
	.byte $FF, $22, $1E, $23, $FF, $FF, $2E, $2F
	.byte $30, $FF, $FF, $3F, $40, $41, $FF, $FF
	.byte $FF, $50, $51, $FF, $FF, $FF, $5E, $5F
	.byte $FF, $FF
rom_84CE:
	.byte $05, $09, $10, $94, $00, $FF, $01, $02
	.byte $FF, $FF, $05, $06, $07, $FF, $08, $0E
	.byte $0F, $10, $11, $12, $18, $19, $1A, $FF
	.byte $FF, $24, $1E, $25, $FF, $FF, $31, $32
	.byte $33, $FF, $FF, $42, $43, $44, $FF, $FF
	.byte $FF, $52, $53, $FF, $FF, $FF, $60, $FF
	.byte $FF, $FF
rom_8500:
	.byte $05, $09, $10, $94, $00, $FF, $01, $02
	.byte $FF, $FF, $05, $06, $07, $FF, $08, $0E
	.byte $0F, $10, $11, $12, $18, $19, $1A, $FF
	.byte $FF, $26, $1E, $27, $FF, $FF, $34, $35
	.byte $36, $37, $FF, $45, $46, $47, $48, $FF
	.byte $54, $55, $56, $57, $FF, $61, $62, $FF
	.byte $63, $FF
rom_8532:
	.byte $04, $09, $10, $8C, $00, $03, $04, $05
	.byte $FF, $10, $11, $12, $FF, $23, $24, $25
	.byte $FF, $34, $35, $36, $FF, $43, $44, $45
	.byte $FF, $51, $52, $53, $50, $55, $56, $57
	.byte $58, $5A, $FF, $5B, $5C, $5F, $FF, $FF
	.byte $60
rom_855B:
	.byte $03, $08, $10, $8E, $00, $FF, $82, $83
	.byte $87, $88, $89, $98, $99, $9A, $AC, $AD
	.byte $AE, $BF, $C0, $C1, $D3, $D4, $D5, $E5
	.byte $E6, $E7, $F0, $F1, $F2
rom_8578:
	.byte $03, $09, $10, $A0, $00, $FF, $07, $08
	.byte $FF, $11, $12, $1C, $1D, $1E, $29, $2A
	.byte $2B, $38, $39, $3A, $49, $4A, $4B, $5B
	.byte $5C, $5D, $6D, $6E, $FF, $7C, $7D, $7E
rom_8598:
	.byte $04, $05, $10, $A2, $00, $86, $FF, $FF
	.byte $FF, $8D, $8E, $8F, $FF, $98, $99, $9A
	.byte $9B, $A4, $A5, $A6, $A7, $AF, $B0, $B1
	.byte $FF
rom_85B1:
	.byte $04, $05, $10, $A2, $40, $FF, $FF, $FF
	.byte $86, $FF, $8F, $8E, $8D, $9B, $9A, $99
	.byte $98, $A7, $A6, $A5, $A4, $FF, $B1, $B0
	.byte $AF
rom_85CA:
	.byte $05, $09, $10, $9C, $00, $03, $04, $FF
	.byte $FF, $FF, $08, $09, $0A, $0B, $0C, $13
	.byte $14, $15, $16, $17, $21, $22, $23, $FF
	.byte $FF, $FF, $2C, $2D, $2E, $FF, $FF, $3B
	.byte $3C, $3D, $FF, $FF, $49, $4A, $4B, $4C
	.byte $FF, $56, $FF, $57, $58, $FF, $62, $FF
	.byte $FF, $63
rom_85FC:
	.byte $05, $08, $10, $8C, $00, $08, $09, $0A
	.byte $0B, $FF, $1A, $1B, $1C, $1D, $FF, $2B
	.byte $2C, $2D, $2E, $2F, $3B, $3C, $3D, $3E
	.byte $3F, $FF, $49, $47, $4A, $4B, $FF, $FF
	.byte $54, $FF, $FF, $FF, $FF, $59, $FF, $FF
	.byte $FF, $5D, $5E, $FF, $FF
rom_8629:
	.byte $06, $09, $10, $8E, $00, $FF, $FF, $FF
	.byte $FF, $FF, $84, $8A, $FE, $8B, $FF, $8C
	.byte $8D, $9B, $9C, $9D, $9E, $9F, $FF, $AF
	.byte $B0, $B1, $B2, $FF, $FF, $C2, $C3, $C4
	.byte $C5, $FF, $FF, $D7, $D8, $D9, $FF, $FF
	.byte $FF, $FF, $FF, $E8, $FF, $FF, $FF, $FF
	.byte $FF, $F3, $FF, $FF, $FF, $FF, $FC, $FD
	.byte $FF, $FF, $FF
rom_8664:
	.byte $05, $09, $10, $94, $00, $FF, $01, $02
	.byte $FF, $FF, $05, $06, $07, $FF, $08, $0E
	.byte $0F, $10, $11, $12, $18, $19, $1A, $FF
	.byte $FF, $26, $1E, $27, $FF, $FF, $34, $35
	.byte $36, $37, $FF, $45, $46, $47, $48, $FF
	.byte $54, $55, $56, $57, $FF, $61, $62, $FF
	.byte $63, $FF
rom_8696:
	.byte $05, $09, $10, $94, $00, $FF, $01, $02
	.byte $FF, $FF, $05, $06, $07, $FF, $08, $0E
	.byte $0F, $10, $11, $12, $18, $19, $1A, $FF
	.byte $FF, $26, $1E, $27, $FF, $FF, $34, $35
	.byte $36, $37, $FF, $45, $46, $47, $48, $FF
	.byte $54, $55, $56, $57, $FF, $61, $62, $FF
	.byte $63, $FF
rom_86C8:
	.byte $07, $07, $10, $92, $00, $FF, $94, $FF
	.byte $FF, $FF, $FF, $FF, $9D, $9E, $9F, $FF
	.byte $FF, $FF, $FF, $AD, $AE, $AF, $B0, $B1
	.byte $FF, $FF, $BD, $BE, $BF, $C0, $C1, $FF
	.byte $FF, $D1, $D2, $D3, $D4, $D5, $D6, $D7
	.byte $FF, $E6, $E7, $E8, $FF, $B7, $B8, $FF
	.byte $FF, $F5, $F6, $F7, $FF, $FF
rom_86FE:
	.byte $04, $0A, $10, $96, $00, $FF, $FF, $81
	.byte $82, $FF, $FF, $86, $87, $FF, $92, $93
	.byte $94, $FF, $A2, $A3, $A4, $FF, $AD, $AE
	.byte $F1, $FF, $B8, $B9, $FF, $FF, $C2, $C3
	.byte $F1, $CD, $CE, $CF, $F1, $DA, $DB, $DC
	.byte $FF, $E8, $FF, $E9, $FF
rom_872B:
	.byte $06, $09, $10, $96, $00, $FF, $FF, $88
	.byte $89, $FF, $FF, $FF, $95, $96, $97, $98
	.byte $99, $FF, $A5, $A6, $A7, $A8, $FF, $FF
	.byte $AF, $B0, $B1, $FF, $FF, $FF, $BA, $BB
	.byte $F1, $FF, $FF, $FF, $C4, $C5, $C6, $FF
	.byte $FF, $FF, $D0, $D1, $D2, $FF, $FF, $DD
	.byte $DE, $DF, $E0, $FF, $FF, $EA, $FF, $EB
	.byte $EC, $FF, $FF
rom_8766:
	.byte $06, $0A, $10, $96, $00, $FF, $FF, $80
	.byte $FF, $FF, $FF, $FF, $EF, $85, $FF, $FF
	.byte $FF, $FF, $8D, $8E, $8F, $90, $91, $FF
	.byte $9E, $9F, $A0, $A1, $FF, $FF, $AB, $AC
	.byte $FF, $FF, $FF, $B5, $B6, $B7, $FF, $FF
	.byte $FF, $BE, $BF, $C0, $C1, $FF, $FF, $C9
	.byte $CA, $CB, $CC, $FF, $FF, $D7, $FF, $D8
	.byte $D9, $FF, $FF, $E5, $FF, $E6, $E7, $FF
	.byte $FF
rom_87A7:
	.byte $05, $07, $10, $8E, $00, $90, $91, $92
	.byte $FF, $FF, $A4, $A5, $A6, $FF, $FF, $B8
	.byte $B9, $BA, $BB, $FF, $CA, $CB, $CC, $CD
	.byte $CE, $DE, $DF, $E0, $FF, $6B, $EB, $EC
	.byte $ED, $FF, $FF, $FF, $F5, $F6, $F7, $FF
rom_87CF:
	.byte $06, $06, $10, $92, $00, $FF, $FF, $95
	.byte $FF, $FF, $FF, $A0, $A1, $A2, $A3, $A4
	.byte $A5, $B3, $B4, $B5, $B6, $B7, $B8, $C7
	.byte $C8, $C9, $CA, $FF, $FF, $DD, $DE, $FF
	.byte $DF, $FF, $FF, $EE, $FF, $FF, $EF, $FF
	.byte $FF
rom_87F8:
	.byte $04, $0B, $10, $92, $00, $FF, $FF, $FF
	.byte $80, $FF, $FF, $81, $82, $FF, $FF, $85
	.byte $86, $FF, $8A, $8B, $8C, $90, $91, $92
	.byte $93, $FF, $9A, $9B, $9C, $FF, $AA, $AB
	.byte $AC, $FF, $BB, $BC, $FF, $CE, $CF, $D0
	.byte $FF, $E3, $E4, $E5, $FF, $F2, $FF, $F3
	.byte $F4
rom_8829:
	.byte $05, $09, $10, $92, $00, $FF, $FF, $83
	.byte $84, $FF, $FF, $87, $88, $89, $FF, $FF
	.byte $8D, $8E, $8F, $FF, $FF, $96, $97, $98
	.byte $99, $FF, $A6, $A7, $A8, $A9, $FF, $B9
	.byte $BA, $FF, $FF, $CB, $CC, $CD, $FF, $FF
	.byte $E0, $E1, $E2, $FF, $FF, $F0, $FF, $F1
	.byte $FD, $FF
rom_885B:
	.byte $07, $05, $10, $92, $00, $FF, $FF, $FF
	.byte $FF, $FF, $B2, $FF, $FF, $C2, $FF, $C3
	.byte $C4, $C5, $C6, $D8, $D9, $DA, $DB, $DC
	.byte $FF, $FF, $E9, $EA, $EB, $EC, $ED, $FF
	.byte $FF, $F8, $F9, $FA, $FB, $FC, $FF, $FF
rom_8883:
	.byte $06, $08, $10, $90, $00, $FF, $06, $07
	.byte $FF, $FF, $FF, $0D, $0E, $0F, $FF, $FF
	.byte $FF, $18, $19, $1A, $1B, $FF, $FF, $25
	.byte $26, $27, $28, $FF, $FF, $35, $36, $37
	.byte $38, $39, $FF, $FF, $49, $4A, $4B, $4C
	.byte $4D, $FF, $60, $61, $FF, $62, $63, $FF
	.byte $70, $71, $FF, $72, $73
rom_88B8:
	.byte $05, $0A, $10, $90, $00, $FF, $FF, $01
	.byte $02, $FF, $FF, $FF, $03, $04, $05, $FF
	.byte $FF, $08, $09, $0A, $FF, $FF, $10, $11
	.byte $FF, $FF, $FF, $1C, $1D, $FF, $FF, $29
	.byte $2A, $2B, $FF, $FF, $3A, $3B, $3C, $FF
	.byte $4E, $4F, $50, $51, $52, $64, $65, $FF
	.byte $66, $63, $74, $FF, $FF, $75, $76
rom_88EF:
	.byte $06, $08, $10, $90, $00, $FF, $FF, $FF
	.byte $FF, $0B, $0C, $FF, $FF, $FF, $12, $13
	.byte $14, $FF, $FF, $1E, $1F, $20, $21, $FF
	.byte $FF, $2C, $2D, $2E, $2F, $FF, $3D, $3E
	.byte $3F, $40, $41, $FF, $53, $54, $55, $56
	.byte $57, $67, $68, $69, $6A, $6B, $FF, $77
	.byte $69, $FF, $FF, $78, $FF
rom_8924:
	.byte $04, $06, $10, $A0, $00, $FF, $1F, $20
	.byte $FF, $2C, $2D, $2E, $FF, $3B, $3C, $3D
	.byte $FF, $4C, $4D, $4E, $FF, $5E, $5F, $60
	.byte $61, $FF, $6F, $70, $71
rom_8941:
	.byte $07, $07, $10, $92, $00, $FF, $94, $FF
	.byte $FF, $FF, $FF, $FF, $9D, $9E, $9F, $FF
	.byte $FF, $FF, $FF, $AD, $AE, $AF, $B0, $B1
	.byte $FF, $FF, $BD, $BE, $BF, $C0, $C1, $FF
	.byte $FF, $D1, $D2, $D3, $D4, $D5, $D6, $D7
	.byte $FF, $E6, $E7, $E8, $FF, $B7, $B8, $FF
	.byte $FF, $F5, $F6, $F7, $FF, $FF
rom_8977:
	.byte $05, $0A, $10, $96, $00, $FF, $FF, $83
	.byte $84, $FF, $FF, $FF, $8A, $8B, $8C, $FF
	.byte $9A, $9B, $9C, $9D, $FF, $F0, $A9, $AA
	.byte $FF, $FF, $B2, $B3, $B4, $FF, $FF, $BC
	.byte $B7, $BD, $FF, $FF, $C7, $C8, $F2, $FF
	.byte $D3, $D4, $D5, $D6, $FF, $E1, $E2, $E3
	.byte $E4, $FF, $ED, $FF, $FF, $EE, $FF
rom_89AE:
	.byte $05, $07, $10, $9E, $00, $FF, $FF, $80
	.byte $81, $82, $FF, $87, $88, $89, $8A, $8F
	.byte $90, $91, $92, $93, $9C, $9D, $9E, $9F
	.byte $FF, $FF, $A8, $A9, $FF, $FF, $B0, $B1
	.byte $B2, $FF, $FF, $BB, $BC, $BD, $FF, $FF
rom_89D6:
	.byte $04, $06, $10, $9C, $00, $33, $34, $35
	.byte $36, $43, $44, $45, $46, $4F, $50, $51
	.byte $52, $5C, $5D, $5E, $FF, $67, $68, $38
	.byte $FF, $6E, $6F, $FF, $FF
rom_89F3:
	.byte $06, $06, $10, $9C, $00, $FF, $FF, $FF
	.byte $FF, $05, $FF, $FF, $FF, $FF, $0D, $0E
	.byte $0F, $FF, $18, $19, $1A, $1B, $1C, $FF
	.byte $24, $25, $26, $27, $FF, $FF, $2F, $30
	.byte $31, $32, $FF, $3E, $3F, $40, $41, $42
	.byte $FF
rom_8A1C:
	.byte $06, $05, $10, $9E, $00, $FF, $FF, $C5
	.byte $FF, $C6, $FF, $FF, $FF, $C7, $C8, $C9
	.byte $FF, $CA, $CB, $CC, $CD, $CE, $FF, $CF
	.byte $D0, $D1, $D2, $D3, $D4, $FF, $FF, $D5
	.byte $D6, $D7, $D8
rom_8A3F:
	.byte $06, $04, $10, $9E, $00, $FF, $FF, $D9
	.byte $DA, $FF, $FF, $FF, $DB, $DC, $DD, $DE
	.byte $DF, $E0, $E1, $E2, $E3, $E4, $E5, $FF
	.byte $FF, $E6, $E7, $E8, $FF
rom_8A5C:
	.byte $03, $07, $10, $9E, $00, $83, $84, $85
	.byte $8B, $8C, $8D, $94, $95, $96, $A0, $A1
	.byte $A2, $AA, $C4, $AB, $B3, $B4, $B5, $BE
	.byte $BF, $C0
rom_8A76:
	.byte $04, $05, $10, $9C, $00, $70, $FF, $71
	.byte $FF, $72, $73, $74, $FF, $75, $76, $77
	.byte $FF, $78, $79, $7A, $7B, $FF, $7C, $7D
	.byte $7E
rom_8A8F:
	.byte $06, $07, $10, $9E, $00, $FF, $FF, $FF
	.byte $86, $FF, $FF, $84, $FF, $FF, $8E, $FF
	.byte $FF, $97, $98, $99, $9A, $9B, $FF, $FF
	.byte $A3, $A4, $A5, $A6, $A7, $FF, $84, $AC
	.byte $AD, $AE, $AF, $FF, $B7, $B8, $B9, $BA
	.byte $FF, $FF, $FF, $C1, $C2, $C3, $FF
rom_8ABE:
	.byte $04, $09, $10, $A0, $00, $01, $02, $FF
	.byte $FF, $09, $0A, $FF, $FF, $13, $14, $15
	.byte $FF, $21, $22, $23, $FF, $2F, $30, $31
	.byte $FF, $3E, $3F, $40, $FF, $4F, $50, $51
	.byte $52, $62, $63, $64, $65, $72, $FF, $73
	.byte $74
rom_8AE7:
	.byte $04, $09, $10, $A0, $00, $FF, $03, $04
	.byte $FF, $0B, $0C, $0D, $FF, $16, $17, $18
	.byte $FF, $24, $25, $26, $FF, $32, $33, $34
	.byte $FF, $41, $42, $43, $44, $53, $54, $55
	.byte $56, $66, $67, $68, $69, $75, $FF, $76
	.byte $77
rom_8B10:
	.byte $04, $09, $10, $A0, $00, $FF, $05, $06
	.byte $FF, $FF, $0E, $0F, $10, $FF, $19, $1A
	.byte $1B, $FF, $27, $28, $FF, $35, $36, $37
	.byte $FF, $45, $46, $47, $48, $57, $58, $59
	.byte $5A, $6A, $1B, $6B, $6C, $78, $79, $7A
	.byte $7B
rom_8B39:
	.byte $04, $09, $10, $98, $00, $06, $07, $FF
	.byte $FF, $10, $11, $12, $FF, $1E, $1F, $20
	.byte $FF, $28, $2B, $2C, $FF, $34, $35, $36
	.byte $FF, $3E, $3F, $40, $41, $4A, $4B, $4C
	.byte $4D, $57, $FF, $58, $59, $63, $FF, $64
	.byte $65
rom_8B62:
	.byte $04, $0A, $10, $98, $00, $FF, $01, $02
	.byte $FF, $FF, $04, $05, $FF, $0D, $0E, $0F
	.byte $FF, $1B, $1C, $1D, $FF, $28, $29, $2A
	.byte $FF, $34, $35, $36, $FF, $3E, $3F, $40
	.byte $41, $4A, $4B, $4C, $4D, $57, $FF, $58
	.byte $59, $63, $FF, $64, $65
rom_8B8F:
	.byte $05, $08, $10, $8C, $00, $08, $09, $0A
	.byte $0B, $FF, $1A, $1B, $1C, $1D, $FF, $2B
	.byte $2C, $2D, $2E, $2F, $3B, $3C, $3D, $3E
	.byte $3F, $FF, $49, $47, $4A, $4B, $FF, $FF
	.byte $54, $FF, $FF, $FF, $FF, $59, $FF, $FF
	.byte $FF, $5D, $5E, $FF, $FF
rom_8BBC:
	.byte $08, $08, $10, $8C, $00, $FF, $06, $07
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $13, $14
	.byte $15, $16, $17, $18, $19, $FF, $26, $27
	.byte $28, $29, $2A, $FF, $FF, $FF, $37, $38
	.byte $39, $3A, $FF, $FF, $FF, $FF, $FF, $46
	.byte $47, $48, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $54, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $59, $FF, $FF, $FF, $FF, $FF, $FF, $5D
	.byte $5E, $FF, $FF, $FF, $FF
rom_8C01:
	.byte $05, $09, $10, $94, $00, $64, $65, $FF
	.byte $FF, $FF, $66, $67, $FF, $FF, $FF, $68
	.byte $69, $6A, $6B, $FF, $6C, $6D, $6E, $6F
	.byte $FF, $70, $71, $72, $73, $FF, $74, $75
	.byte $76, $77, $FF, $FF, $78, $79, $FF, $FF
	.byte $FF, $7A, $53, $FF, $FF, $FF, $7B, $7C
	.byte $FF, $FF
rom_8C33:
	.byte $05, $08, $10, $98, $00, $FF, $08, $09
	.byte $FF, $FF, $13, $14, $15, $16, $FF, $21
	.byte $22, $23, $24, $FF, $2D, $2E, $2F, $30
	.byte $FF, $37, $38, $39, $3A, $FF, $42, $43
	.byte $44, $45, $46, $4E, $4F, $FF, $50, $51
	.byte $5A, $5B, $FF, $5C, $5D
rom_8C60:
	.byte $07, $08, $10, $98, $00, $FF, $FF, $FF
	.byte $0A, $0B, $FF, $0C, $FF, $FF, $FF, $17
	.byte $18, $19, $1A, $FF, $FF, $25, $26, $27
	.byte $FF, $FF, $FF, $FF, $31, $32, $33, $FF
	.byte $FF, $FF, $FF, $3B, $3C, $3D, $FF, $FF
	.byte $FF, $FF, $47, $48, $49, $FF, $FF, $52
	.byte $53, $54, $55, $56, $FF, $FF, $5E, $5F
	.byte $60, $FF, $61, $62, $FF
rom_8C9D:
	.byte $05, $09, $10, $9A, $00, $FF, $80, $81
	.byte $FF, $FF, $FF, $88, $89, $8A, $8B, $FF
	.byte $94, $95, $96, $97, $FF, $A0, $A1, $A2
	.byte $FF, $AC, $AD, $AE, $AF, $B0, $BC, $BD
	.byte $BE, $BF, $FF, $FF, $FF, $CD, $CE, $FF
	.byte $FF, $FF, $DA, $DB, $FF, $FF, $FF, $EA
	.byte $EB, $FF
rom_8CCF:
	.byte $06, $09, $10, $9A, $00, $FF, $FF, $FF
	.byte $82, $83, $84, $8C, $8D, $8E, $8F, $90
	.byte $91, $98, $99, $9A, $9B, $9C, $FF, $A3
	.byte $A4, $A5, $A6, $FF, $FF, $B1, $B2, $B3
	.byte $B4, $FF, $FF, $FF, $C0, $C1, $FF, $FF
	.byte $FF, $FF, $FF, $CF, $FF, $FF, $FF, $FF
	.byte $FF, $DC, $FF, $FF, $FF, $FF, $FF, $EC
	.byte $FF, $FF, $FF
rom_8D0A:
	.byte $03, $09, $10, $9A, $00, $85, $86, $87
	.byte $92, $93, $FF, $9D, $9E, $FF, $A7, $A8
	.byte $FF, $B5, $B6, $FF, $C2, $C3, $C4, $D0
	.byte $D1, $FF, $DD, $DE, $FF, $ED, $EE, $FF
rom_8D2A:
	.byte $07, $04, $10, $9E, $00, $FF, $18, $19
	.byte $FF, $4D, $4E, $FF, $FF, $24, $25, $59
	.byte $5A, $5B, $FF, $FF, $2F, $30, $31, $64
	.byte $65, $66, $3E, $3F, $40, $41, $6A, $6B
	.byte $6C
rom_8D4B:
	.byte $05, $09, $10, $9C, $40, $FF, $FF, $FF
	.byte $04, $03, $0C, $0B, $0A, $09, $08, $17
	.byte $16, $15, $14, $13, $FF, $FF, $23, $22
	.byte $21, $FF, $2E, $2D, $2C, $FF, $FF, $3D
	.byte $3C, $3B, $FF, $4C, $4B, $4A, $49, $FF
	.byte $58, $57, $FF, $56, $FF, $63, $FF, $FF
	.byte $62, $FF
rom_8D7D:
	.byte $05, $07, $10, $9E, $00, $FF, $FF, $80
	.byte $81, $82, $FF, $87, $88, $89, $8A, $8F
	.byte $90, $91, $92, $93, $9C, $9D, $9E, $9F
	.byte $FF, $FF, $A8, $A9, $FF, $FF, $B0, $B1
	.byte $B2, $FF, $FF, $BB, $BC, $BD, $FF, $FF
rom_8DA5:
	.byte $06, $06, $10, $9C, $C0, $FF, $42, $41
	.byte $40, $3F, $3E, $FF, $32, $31, $30, $2F
	.byte $FF, $FF, $27, $26, $25, $24, $FF, $1C
	.byte $1B, $1A, $19, $18, $FF, $0F, $0E, $0D
	.byte $FF, $FF, $FF, $FF, $05, $FF, $FF, $FF
	.byte $FF

; -----------------------------------------------------------------------------

; And the rest is unused
