.segment "BANK_06t"
; $8000-$9FFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"


; -----------------------------------------------------------------------------

; Data pointers for Sonya
rom_06_8000:
	.word rom_8004, rom_82C7

; -----------------------------------------------------------------------------

; Index = player's animation idx * 3
rom_8004:
	.byte $09			; $00 = Idle
	.word anim_idle
    .byte $06
	.word anim_crouch
    .byte $08
	.word anim_crouch_parry
    .byte $01
	.word anim_walk_fw
    .byte $03
	.word anim_walk_bk
    .byte $08
	.word anim_jump_up
    .byte $02
	.word anim_jump_fw
    .byte $05
	.word anim_jump_bk
	.byte $04			; $08
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
	.word anim_special_move_1
    .byte $02
	.word rom_8137
    .byte $02
	.word rom_8143
	.byte $00			; $10
	.word rom_814F
    .byte $02
	.word rom_8157
    .byte $02
	.word rom_8163
    .byte $00
	.word anim_uppercut
    .byte $0A
	.word rom_8177
    .byte $05
	.word rom_817B
    .byte $02
	.word rom_817C
    .byte $0B
	.word anim_special_move_2
	.byte $2A			; $18
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
	.byte $04			; $20
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
	.word anim_get_up
	.byte $18 ;$10			; $28 = Staggered
	.word anim_sonya_staggered
    .byte $08			; $29 = Victory pose
	.word anim_shame
    .byte $08
	.word anim_victory
    .byte $07
	.word anim_crouch_parry
    .byte $07
	.word anim_jump_up
    .byte $0F
	.word rom_8270
    .byte $0D
	.word rom_8271
    .byte $14
	.word rom_8286
	.byte $0D			; $30
	.word rom_8271
    .byte $29
	.word rom_8286
    .byte $19
	.word rom_8271 ;rom_8292
    .byte $18 ;$1F
	.word anim_special_hit ;rom_82A1
    .byte $04			; $34
	.word rom_80ED

; -----------------------------------------------------------------------------

; Index = player's animation frame
; Data = indices for a pointer in the second table below
anim_idle:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $01, $01, $01, $01, $01, $01, $01, $01
anim_crouch:
	.byte $02, $02, $02, $02
anim_crouch_parry:
	.byte $03, $03, $03, $03, $03, $03, $03, $03
anim_walk_fw:
	.byte $04, $05, $06, $07, $08, $04, $05, $06
	.byte $07, $08
anim_walk_bk:
	.byte $04, $05, $06, $07, $08, $04, $05, $06
	.byte $07, $08
anim_jump_up:
	.byte $09, $09, $09, $09, $09, $09, $09, $09
anim_jump_fw:
	.byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A
	.byte $0A, $0A, $0A, $0A
anim_jump_bk:
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
anim_special_move_1:
	.byte $34, $34, $35, $35, $36, $36, $34, $34
	.byte $35, $35, $36, $36, $32, $32, $32, $32
	.byte $32, $33, $33, $33, $33, $33, $33, $33
	.byte $33, $33, $33, $33, $33, $33, $33, $33
rom_8137:
	.byte $11, $11, $11, $11, $11, $13, $13, $13
	.byte $11, $11, $11, $11
rom_8143:
	.byte $11, $11, $11, $11, $11, $11, $11, $11
	.byte $11, $13, $13, $13
rom_814F:
	.byte $14, $14, $15, $15, $14, $14, $16, $16
rom_8157:
	.byte $0A, $0A, $0A, $0A, $0A, $17, $17, $17
	.byte $0A, $0A, $0A, $0A
rom_8163:
	.byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A
	.byte $0A, $17, $17, $17
anim_uppercut:
	.byte $18, $18, $1A, $1A, $19, $19, $1A, $1A
rom_8177:
	.byte $1B, $1B, $02, $02
rom_817B:
	.byte $00
rom_817C:
	.byte $00
anim_special_move_2:
	.byte $0B, $0B, $17, $17, $17, $17, $17, $17
	.byte $17, $17, $0C, $0C, $0D, $0D, $0C, $0C
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
anim_get_up:
	.byte $27, $27, $28, $28, $29, $29
anim_sonya_staggered:
	.byte $2A, $2A, $2A, $2A, $2A, $2A, $2A, $2A
	.byte $2B, $2B, $2B, $2B, $2B, $2B, $2B, $2B
	.byte $2A, $2A, $2A, $2A, $2A, $2A, $2A, $2A
	.byte $2B, $2B, $2B, $2B, $2B, $2B
anim_shame:
	.byte $2C, $2C, $2C, $2C, $2C, $2C
anim_victory:
	.byte $2D, $2D, $2D, $2D, $2E, $2E, $03, $09
rom_8270:
	.byte $37
rom_8271:
	.byte $22, $22, $22, $23, $23, $23, $24, $24
	.byte $37, $37, $37, $37, $37, $37, $37, $37
	.byte $37, $37, $37, $00, $00
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
	.word anim_frame_00, anim_frame_01, anim_frame_02, anim_frame_03
	.word anim_frame_04, anim_frame_05, anim_frame_06, anim_frame_07
	.word anim_frame_08, anim_frame_09, anim_frame_0A, anim_frame_0B
	.word anim_frame_0C, anim_frame_0D, anim_frame_0E, anim_frame_0F
	.word anim_frame_10, anim_frame_11, anim_frame_12, anim_frame_13
	.word anim_frame_14, anim_frame_15, anim_frame_16, anim_frame_17
	.word rom_8761, rom_877E, rom_87AB, rom_87D3
	.word rom_87FC, rom_8824, rom_883D, rom_8865
	.word rom_8876, rom_889F, rom_88D6, rom_88EF
	.word rom_8912, rom_8935, rom_8953, rom_8970
	.word rom_897E, rom_8992, rom_89AC, rom_89D5
	.word rom_89F5, rom_8A15, rom_8A36, rom_8A77
	.word rom_8AA4, rom_8AC7, rom_8AF0, rom_8B1D
	.word rom_8B52, rom_8B84, rom_8BC5, rom_8C06
	.word rom_8C19, rom_8C42, rom_8C5B, anim_frame_00
	.word anim_frame_00, anim_frame_00, anim_frame_00, anim_frame_00
	.word anim_frame_00, anim_frame_00, anim_frame_00, anim_frame_00
	.word anim_frame_00, anim_frame_00, anim_frame_00, anim_frame_00
	.word anim_frame_00, anim_frame_00, anim_frame_00, anim_frame_00
	.word anim_frame_00, anim_frame_00, anim_frame_00, anim_frame_00
	.word anim_frame_00, anim_frame_00, anim_frame_00, anim_frame_00
	.word anim_frame_00, anim_frame_00, anim_frame_00, anim_frame_00
	.word anim_frame_00, anim_frame_00, anim_frame_00, anim_frame_00
	.word anim_frame_00, anim_frame_00, anim_frame_00, anim_frame_00
	.word anim_frame_00, anim_frame_00, anim_frame_00, anim_frame_00
	.word anim_frame_00

; -----------------------------------------------------------------------------

anim_frame_00:
	.byte $04, $09, $10, $38, $00, $FF, $04, $05
	.byte $FF, $13, $14, $15, $FF, $26, $27, $28
	.byte $FF, $39, $3A, $3B, $FF, $49, $4A, $4B
	.byte $FF, $57, $58, $59, $FF, $63, $64, $65
	.byte $66, $6F, $FF, $70, $FF, $78, $FF, $79
	.byte $7A
anim_frame_01:
	.byte $04, $09, $10, $38, $00, $06, $07, $08
	.byte $FF, $16, $17, $18, $FF, $29, $2A, $2B
	.byte $FF, $3C, $3D, $3E, $FF, $4C, $4D, $4E
	.byte $FF, $5A, $5B, $5C, $FF, $67, $68, $69
	.byte $FF, $71, $FF, $72, $FF, $78, $FF, $79
	.byte $7A
anim_frame_02:
	.byte $03, $05, $10, $3A, $00, $BE, $BF, $C0
	.byte $CB, $CC, $CD, $D9, $DA, $DB, $E6, $E7
	.byte $E8, $F4, $FF, $F5
anim_frame_03:
	.byte $04, $06, $10, $48, $00, $2A, $2B, $2C
	.byte $2D, $39, $3A, $3B, $FF, $FF, $48, $49
	.byte $FF, $03, $55, $56, $57, $62, $63, $64
	.byte $65, $FF, $71, $FF, $72
anim_frame_04:
	.byte $05, $0A, $10, $3C, $00, $FF, $FF, $01
	.byte $02, $FF, $FF, $FF, $07, $08, $FF, $FF
	.byte $FF, $0F, $10, $FF, $FF, $FF, $18, $19
	.byte $1A, $FF, $FF, $25, $26, $27, $FF, $FF
	.byte $31, $32, $FF, $FF, $3D, $3E, $3F, $FF
	.byte $FF, $4A, $4B, $4C, $FF, $FF, $57, $58
	.byte $59, $FF, $63, $64, $FF, $65, $FF
anim_frame_05:
	.byte $03, $0A, $00, $3C, $00, $03, $04, $FF
	.byte $09, $0A, $FF, $11, $12, $FF, $1B, $1C
	.byte $1D, $28, $29, $FF, $33, $34, $FF, $40
	.byte $41, $FF, $4D, $4E, $FF, $5A, $5B, $FF
	.byte $66, $67, $FF
anim_frame_06:
	.byte $03, $0A, $00, $3C, $00, $FF, $FF, $FF
	.byte $0B, $0C, $FF, $13, $14, $FF, $1E, $1F
	.byte $20, $2A, $2B, $2C, $35, $36, $FF, $42
	.byte $43, $FF, $4F, $50, $FF, $5C, $5D, $5E
	.byte $68, $69, $6A
anim_frame_07:
	.byte $03, $0A, $00, $3C, $00, $03, $04, $FF
	.byte $09, $0A, $FF, $11, $12, $FF, $1B, $1C
	.byte $21, $2D, $2E, $FF, $37, $38, $39, $44
	.byte $45, $46, $51, $52, $53, $5F, $60, $FF
	.byte $6B, $6C, $FF
anim_frame_08:
	.byte $04, $0A, $08, $3C, $00, $FF, $05, $06
	.byte $FF, $FF, $0D, $0E, $FF, $FF, $15, $16
	.byte $17, $FF, $22, $23, $24, $FF, $2F, $30
	.byte $FF, $FF, $3A, $3B, $3C, $FF, $47, $48
	.byte $49, $FF, $54, $55, $56, $3D, $61, $FF
	.byte $62, $6D, $6E, $FF, $6F
anim_frame_09:
	.byte $03, $0A, $10, $46, $00, $FF, $FF, $FF
	.byte $85, $86, $FF, $8A, $8B, $8C, $94, $95
	.byte $FF, $A0, $A1, $A2, $B0, $B1, $B2, $B0
	.byte $C2, $C3, $D3, $D4, $D5, $E5, $E6, $E7
	.byte $F4, $FF, $F5
anim_frame_0A:
	.byte $04, $08, $10, $3A, $00, $FF, $95, $96
	.byte $FF, $A5, $A6, $A7, $FF, $AF, $B0, $B1
	.byte $B2, $BA, $BB, $BC, $BD, $C8, $C9, $CA
	.byte $FF, $D6, $D7, $D8, $FF, $E3, $E4, $E5
	.byte $FF, $F1, $F2, $F3, $FF
anim_frame_0B:
	.byte $02, $09, $10, $3E, $00, $FF, $84, $92
	.byte $93, $A4, $A5, $B0, $B1, $BB, $BC, $C7
	.byte $C8, $D6, $D7, $E5, $E6, $EE, $EF
anim_frame_0C:
	.byte $03, $05, $10, $3E, $00, $BD, $BE, $F7
	.byte $C9, $CA, $CB, $D9, $DA, $DB, $E7, $E8
	.byte $E9, $FF, $F0, $E9
anim_frame_0D:
	.byte $03, $05, $10, $3E, $40, $F7, $BE, $BD
	.byte $CB, $CA, $C9, $DB, $DA, $D9, $E9, $E8
	.byte $E7, $E9, $F0, $FF
anim_frame_0E:
	.byte $04, $09, $10, $48, $00, $05, $06, $FF
	.byte $FF, $0F, $10, $FF, $FF, $1B, $1C, $FF
	.byte $FF, $26, $27, $FF, $FF, $34, $35, $36
	.byte $FF, $43, $44, $45, $FF, $51, $52, $53
	.byte $FF, $5E, $FF, $5F, $FF, $6C, $FF, $6D
	.byte $6E
anim_frame_0F:
	.byte $04, $09, $10, $38, $00, $09, $0A, $FF
	.byte $FF, $1A, $1B, $FF, $FF, $2D, $2E, $2F
	.byte $30, $3F, $40, $41, $42, $4F, $50, $51
	.byte $52, $5D, $5E, $FF, $5F, $FF, $6A, $FF
	.byte $FF, $FF, $73, $FF, $FF, $FF, $7B, $FF
	.byte $FF
anim_frame_10:
	.byte $06, $09, $10, $38, $00, $FF, $0B, $0C
	.byte $FF, $0D, $0E, $1C, $1D, $1E, $1F, $20
	.byte $21, $31, $32, $33, $34, $35, $FF, $43
	.byte $44, $45, $46, $FF, $FF, $FF, $53, $54
	.byte $FF, $FF, $FF, $FF, $5D, $60, $FF, $FF
	.byte $FF, $FF, $FF, $6B, $FF, $FF, $FF, $FF
	.byte $FF, $74, $FF, $FF, $FF, $FF, $FF, $7B
	.byte $FF, $FF, $FF
anim_frame_11:
	.byte $04, $0A, $10, $40, $00, $01, $02, $FF
	.byte $FF, $03, $04, $05, $FF, $06, $07, $08
	.byte $FF, $0C, $0D, $FF, $FF, $19, $1A, $FF
	.byte $FF, $29, $2A, $2B, $FF, $3C, $3D, $3E
	.byte $FF, $4E, $4F, $50, $FF, $60, $61, $62
	.byte $63, $75, $76, $FF, $FF
anim_frame_12:
	.byte $07, $08, $10, $10, $00, $FF, $FF, $FF
	.byte $0E, $FF, $FF, $FF, $FF, $FF, $19, $1A
	.byte $FF, $FF, $FF, $FF, $29, $2A, $2B, $FF
	.byte $FF, $FF, $FF, $38, $39, $3A, $3B, $3C
	.byte $FF, $FF, $FF, $47, $48, $49, $4A, $FF
	.byte $FF, $FF, $54, $55, $56, $57, $58, $63
	.byte $64, $65, $66, $FF, $67, $68, $71, $72
	.byte $73, $FF, $FF, $FF, $FF
anim_frame_13:
	.byte $05, $07, $10, $40, $00, $0E, $0F, $10
	.byte $FF, $FF, $1B, $1C, $1D, $1E, $1F, $2C
	.byte $2D, $2E, $2F, $30, $3F, $40, $41, $42
	.byte $FF, $51, $52, $FF, $FF, $FF, $64, $65
	.byte $66, $FF, $FF, $77, $78, $FF, $FF, $FF
anim_frame_14:
	.byte $05, $09, $10, $3A, $00, $FF, $FF, $82
	.byte $83, $84, $FF, $FF, $8C, $8D, $8E, $FF
	.byte $9C, $9D, $9E, $9F, $FF, $AA, $AB, $FF
	.byte $FF, $FF, $B5, $B6, $FF, $FF, $FF, $C3
	.byte $C4, $FF, $FF, $CE, $D1, $D2, $FF, $FF
	.byte $DF, $FF, $E0, $FF, $FF, $EB, $FF, $EC
	.byte $ED, $FF
anim_frame_15:
	.byte $06, $09, $10, $3A, $00, $FF, $FF, $85
	.byte $86, $FF, $FF, $8F, $90, $91, $92, $93
	.byte $94, $F6, $A0, $A1, $A2, $A3, $A4, $FF
	.byte $AC, $AD, $AE, $FF, $FF, $FF, $B7, $B8
	.byte $B9, $FF, $FF, $FF, $C5, $C6, $C7, $FF
	.byte $FF, $D3, $D4, $D5, $FF, $FF, $FF, $E1
	.byte $FF, $E2, $FF, $FF, $FF, $EE, $FF, $EF
	.byte $F0, $FF, $FF
anim_frame_16:
	.byte $06, $09, $10, $3A, $00, $FF, $FF, $80
	.byte $81, $FF, $FF, $FF, $87, $88, $89, $8A
	.byte $8B, $FF, $97, $98, $99, $9A, $9B, $FF
	.byte $A8, $A9, $FF, $FF, $FF, $FF, $B3, $B4
	.byte $FF, $FF, $FF, $FF, $C1, $C2, $FF, $FF
	.byte $FF, $CE, $CF, $D0, $FF, $FF, $FF, $DC
	.byte $DD, $DE, $FF, $FF, $FF, $E9, $FF, $EA
	.byte $FF, $FF, $FF
anim_frame_17:
	.byte $09, $05, $20, $4C, $00, $FF, $FF, $FF
	.byte $FF, $02, $03, $FF, $FF, $FF, $FF, $FF
	.byte $FF, $FF, $04, $05, $06, $FF, $FF, $07
	.byte $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
	.byte $10, $11, $12, $13, $14, $15, $FF, $FF
	.byte $FF, $FF, $FF, $FF, $16, $17, $18, $FF
	.byte $FF, $FF
rom_8761:
	.byte $04, $06, $10, $46, $00, $FF, $96, $97
	.byte $FF, $FF, $A3, $A4, $A5, $B3, $B4, $B5
	.byte $B6, $C4, $C5, $C6, $C7, $D6, $D7, $D8
	.byte $D9, $E8, $E9, $EA, $EB
rom_877E:
	.byte $04, $0A, $10, $46, $00, $FF, $FF, $80
	.byte $81, $FF, $82, $83, $84, $FF, $87, $88
	.byte $89, $90, $91, $92, $93, $9C, $9D, $9E
	.byte $9F, $FF, $AA, $AB, $AC, $FF, $BC, $BD
	.byte $FF, $CC, $CD, $CE, $FF, $DE, $DF, $E0
	.byte $FF, $EF, $FF, $F0, $F1
rom_87AB:
	.byte $05, $07, $10, $46, $00, $FF, $8D, $8E
	.byte $8F, $FF, $98, $99, $9A, $9B, $FF, $A6
	.byte $A7, $A8, $A9, $FF, $B7, $B8, $B9, $BA
	.byte $BB, $FF, $C8, $C9, $CA, $CB, $DA, $DB
	.byte $DC, $DD, $FF, $EC, $AC, $ED, $EE, $FF
rom_87D3:
	.byte $06, $06, $10, $4A, $00, $FF, $FF, $FF
	.byte $FF, $FF, $A5, $FF, $FF, $FF, $FF, $B1
	.byte $B2, $BC, $BD, $BE, $BF, $C0, $FF, $CD
	.byte $CE, $CF, $D0, $FF, $FF, $DE, $DF, $E0
	.byte $E1, $FF, $FF, $EC, $FF, $ED, $EE, $FF
	.byte $FF
rom_87FC:
	.byte $05, $07, $10, $42, $00, $FF, $FF, $80
	.byte $FF, $FF, $85, $86, $87, $88, $FF, $8E
	.byte $8F, $90, $91, $92, $FF, $FF, $9C, $9D
	.byte $9E, $FF, $FF, $A9, $AA, $AB, $FF, $FF
	.byte $BA, $BB, $FF, $FF, $FF, $CD, $CE, $FF
rom_8824:
	.byte $04, $05, $10, $42, $00, $93, $FA, $94
	.byte $FF, $9F, $A0, $A1, $A2, $FF, $AC, $AD
	.byte $AE, $BC, $BD, $BE, $BF, $CF, $D0, $D1
	.byte $FF
rom_883D:
	.byte $05, $07, $10, $42, $00, $FF, $81, $82
	.byte $FF, $FF, $FF, $89, $8A, $FF, $FF, $95
	.byte $96, $FF, $FF, $FF, $A3, $A4, $FF, $FF
	.byte $FF, $AF, $B0, $FF, $B1, $B2, $C0, $C1
	.byte $C2, $C3, $FF, $D2, $D3, $D4, $FF, $FF
rom_8865:
	.byte $03, $04, $10, $44, $00, $61, $62, $63
	.byte $69, $6A, $6B, $72, $73, $74, $FF, $FF
	.byte $7B
rom_8876:
	.byte $06, $06, $10, $44, $00, $57, $58, $FF
	.byte $FF, $FF, $FF, $5C, $5D, $FF, $FF, $FF
	.byte $FF, $64, $65, $66, $FF, $FF, $FF, $6C
	.byte $6D, $6E, $6F, $70, $71, $75, $76, $77
	.byte $78, $79, $7A, $7C, $7D, $7E, $7F, $FF
	.byte $FF
rom_889F:
	.byte $05, $0A, $10, $38, $00, $FF, $FF, $01
	.byte $02, $03, $FF, $0F, $10, $11, $12, $FF
	.byte $22, $23, $24, $25, $FF, $36, $37, $38
	.byte $FF, $FF, $47, $48, $FF, $FF, $FF, $55
	.byte $56, $FF, $FF, $FF, $61, $62, $FF, $FF
	.byte $6C, $6D, $6E, $FF, $FF, $75, $76, $77
	.byte $FF, $FF, $7C, $FF, $7D, $FF, $FF
rom_88D6:
	.byte $04, $05, $10, $44, $00, $07, $08, $09
	.byte $0A, $14, $15, $16, $17, $21, $22, $23
	.byte $FF, $31, $32, $33, $FF, $44, $FF, $FF
	.byte $FF
rom_88EF:
	.byte $05, $06, $10, $44, $00, $03, $04, $05
	.byte $FF, $FF, $0B, $0C, $0D, $0E, $0F, $FF
	.byte $FF, $18, $19, $1A, $FF, $FF, $24, $25
	.byte $26, $FF, $FF, $34, $35, $FF, $FF, $FF
	.byte $45, $FF, $FF
rom_8912:
	.byte $05, $06, $10, $44, $00, $FF, $FF, $FF
	.byte $FF, $06, $FF, $FF, $FF, $10, $11, $FF
	.byte $FF, $1B, $1C, $1D, $FF, $FF, $27, $28
	.byte $FF, $36, $37, $38, $39, $FF, $46, $47
	.byte $48, $49, $FF
rom_8935:
	.byte $05, $05, $10, $42, $00, $FF, $DC, $DD
	.byte $FF, $FF, $FF, $DE, $DF, $FF, $FF, $FF
	.byte $E2, $E3, $FF, $FF, $EA, $EB, $EC, $ED
	.byte $EE, $F2, $F3, $F4, $F5, $FF
rom_8953:
	.byte $06, $04, $10, $42, $00, $FF, $FF, $E0
	.byte $E1, $FF, $FF, $E4, $E5, $E6, $E7, $E8
	.byte $E9, $FF, $EF, $F0, $F1, $FF, $FF, $F6
	.byte $F7, $FF, $F8, $F9, $FF
rom_8970:
	.byte $03, $03, $10, $42, $00, $FF, $B3, $B4
	.byte $C4, $C5, $C6, $D5, $D6, $D7
rom_897E:
	.byte $03, $05, $10, $42, $00, $97, $98, $FF
	.byte $A5, $A6, $FF, $B5, $B6, $B7, $C8, $C9
	.byte $CA, $D8, $D9, $FF
rom_8992:
	.byte $03, $07, $10, $42, $00, $83, $84, $FF
	.byte $8B, $8C, $8D, $99, $9A, $9B, $A7, $A8
	.byte $FF, $B8, $B9, $FF, $CB, $CC, $FF, $DA
	.byte $DB, $FF
rom_89AC:
	.byte $04, $09, $10, $48, $00, $01, $02, $FF
	.byte $FF, $09, $0A, $0B, $FF, $14, $15, $16
	.byte $17, $FF, $20, $21, $22, $FF, $2E, $2F
	.byte $30, $3C, $3D, $3E, $3F, $4A, $4B, $4C
	.byte $4D, $FF, $58, $59, $5A, $FF, $66, $67
	.byte $68
rom_89D5:
	.byte $03, $09, $10, $48, $00, $03, $04, $FF
	.byte $0C, $0D, $0E, $18, $19, $1A, $23, $24
	.byte $25, $31, $32, $33, $40, $41, $42, $4E
	.byte $4F, $50, $5B, $5C, $5D, $69, $6A, $6B
rom_89F5:
	.byte $03, $09, $10, $44, $00, $12, $13, $FF
	.byte $1E, $1F, $20, $2E, $2F, $30, $41, $42
	.byte $43, $51, $52, $53, $54, $55, $56, $59
	.byte $5A, $5B, $5E, $5F, $60, $67, $FF, $68
rom_8A15:
	.byte $04, $07, $10, $4A, $00, $FF, $93, $94
	.byte $95, $FF, $A0, $A1, $A2, $FF, $AC, $AD
	.byte $AE, $FF, $B7, $B8, $B9, $FF, $C9, $CA
	.byte $FF, $D9, $DA, $DB, $FF, $E8, $FF, $E9
	.byte $FF
rom_8A36:
	.byte $06, $0A, $10, $4A, $00, $80, $81, $82
	.byte $83, $84, $85, $86, $87, $88, $89, $8A
	.byte $FF, $FF, $8B, $8C, $8D, $8E, $FF, $FF
	.byte $FF, $96, $97, $FF, $FF, $FF, $FF, $A3
	.byte $A4, $FF, $FF, $FF, $FF, $AF, $B0, $FF
	.byte $FF, $FF, $FF, $BA, $BB, $FF, $FF, $FF
	.byte $FF, $CB, $CC, $FF, $FF, $FF, $FF, $DC
	.byte $DD, $FF, $FF, $FF, $FF, $EA, $EB, $FF
	.byte $FF
rom_8A77:
	.byte $05, $08, $10, $0E, $00, $FF, $80, $81
	.byte $FF, $FF, $83, $84, $85, $86, $FF, $8C
	.byte $8D, $8E, $FF, $FF, $97, $98, $99, $9A
	.byte $FF, $A5, $A6, $A7, $A8, $FF, $B4, $B5
	.byte $B6, $B7, $B8, $C4, $C5, $FF, $C6, $C7
	.byte $CD, $CE, $FF, $FF, $CF
rom_8AA4:
	.byte $0A, $03, $10, $0E, $00, $FF, $FF, $FF
	.byte $FF, $FF, $D0, $D1, $D2, $FF, $FF, $D3
	.byte $D4, $D5, $D6, $D7, $D8, $D9, $DA, $DB
	.byte $DC, $DD, $DE, $DF, $E0, $E1, $E2, $E3
	.byte $E4, $E5, $E6
rom_8AC7:
	.byte $04, $09, $10, $38, $00, $09, $0A, $FF
	.byte $FF, $1A, $1B, $FF, $FF, $2D, $2E, $2F
	.byte $30, $3F, $40, $41, $42, $4F, $50, $51
	.byte $52, $5D, $5E, $FF, $5F, $FF, $6A, $FF
	.byte $FF, $FF, $73, $FF, $FF, $FF, $7B, $FF
	.byte $FF
rom_8AF0:
	.byte $05, $08, $10, $4A, $00, $FF, $FF, $8F
	.byte $90, $FF, $FF, $98, $99, $9A, $9B, $FF
	.byte $A6, $A7, $A8, $FF, $FF, $B3, $B4, $FF
	.byte $FF, $C1, $C2, $C3, $C4, $FF, $D1, $D2
	.byte $D3, $D4, $FF, $E2, $E3, $E4, $E5, $FF
	.byte $EF, $FF, $F0, $F1, $FF
rom_8B1D:
	.byte $06, $08, $10, $4A, $00, $FF, $FF, $91
	.byte $92, $FF, $FF, $FF, $F6, $9C, $9D, $9E
	.byte $9F, $FF, $A9, $AA, $AB, $FF, $FF, $FF
	.byte $B5, $B6, $FF, $FF, $FF, $C5, $C6, $C7
	.byte $C8, $FF, $FF, $D5, $D6, $D7, $D8, $FF
	.byte $FF, $E6, $E3, $E4, $E7, $FF, $FF, $F2
	.byte $FF, $F3, $F4, $FF, $FF
rom_8B52:
	.byte $05, $09, $10, $3E, $00, $FF, $FF, $86
	.byte $87, $FF, $95, $96, $97, $98, $99, $FF
	.byte $A6, $A7, $A8, $A9, $FF, $FF, $B2, $B3
	.byte $B4, $FF, $FF, $BF, $C0, $C1, $F5, $CC
	.byte $CD, $CE, $CF, $DC, $DD, $FF, $DE, $FF
	.byte $FF, $FF, $FF, $EA, $F6, $FF, $FF, $FF
	.byte $F1, $F2
rom_8B84:
	.byte $06, $0A, $10, $3E, $00, $FF, $80, $81
	.byte $FF, $FF, $FF, $88, $89, $8A, $8B, $8C
	.byte $8D, $9A, $9B, $9C, $9D, $9E, $9F, $FF
	.byte $AA, $AB, $AC, $AD, $FF, $FF, $B5, $B6
	.byte $B7, $FF, $FF, $FF, $C2, $C3, $FF, $FF
	.byte $FF, $FF, $D0, $D1, $FF, $FF, $FF, $FF
	.byte $FF, $DF, $FF, $FF, $FF, $FF, $FF, $EB
	.byte $FF, $FF, $FF, $FF, $FF, $F3, $FF, $FF
	.byte $FF
rom_8BC5:
	.byte $06, $0A, $10, $3E, $00, $FF, $82, $83
	.byte $FF, $FF, $FF, $8E, $8F, $90, $91, $FF
	.byte $FF, $A0, $A1, $A2, $A3, $FF, $FF, $FF
	.byte $AE, $AF, $FF, $FF, $FF, $FF, $B8, $B9
	.byte $BA, $FF, $FF, $FF, $C4, $C5, $C6, $FF
	.byte $FF, $FF, $D2, $D3, $D4, $D5, $FF, $FF
	.byte $E0, $E1, $E2, $E3, $E4, $FF, $EC, $ED
	.byte $FF, $FF, $FF, $FF, $FF, $F4, $FF, $FF
	.byte $FF
rom_8C06:
	.byte $07, $02, $10, $44, $00, $3A, $3B, $3C
	.byte $3D, $3E, $3F, $40, $4A, $4B, $4C, $4D
	.byte $4E, $4F, $50
rom_8C19:
	.byte $04, $09, $10, $48, $40, $FF, $FF, $06
	.byte $05, $FF, $FF, $10, $0F, $FF, $FF, $1C
	.byte $1B, $FF, $FF, $27, $26, $FF, $36, $35
	.byte $34, $FF, $45, $44, $43, $FF, $53, $52
	.byte $51, $FF, $5F, $FF, $5E, $6E, $6D, $FF
	.byte $6C
rom_8C42:
	.byte $04, $05, $10, $44, $00, $07, $08, $09
	.byte $0A, $14, $15, $16, $17, $21, $22, $23
	.byte $FF, $31, $32, $33, $FF, $44, $FF, $FF
	.byte $FF
rom_8C5B:
	.byte $05, $06, $10, $44, $C0, $FF, $49, $48
	.byte $47, $46, $FF, $39, $38, $37, $36, $FF
	.byte $28, $27, $FF, $FF, $1D, $1C, $1B, $FF
	.byte $FF, $11, $10, $FF, $FF, $FF, $06, $FF
	.byte $FF, $FF, $FF

; -----------------------------------------------------------------------------
