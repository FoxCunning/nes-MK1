.segment "BANK_08"
; $8000-$9FFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"


; -----------------------------------------------------------------------------

; Data pointers for Scorpion
rom_08_8000:
	.word rom_8004, rom_82C7

; -----------------------------------------------------------------------------

rom_8004:
	.byte $09
	.word anim_scorpion_idle
	.byte $06
	.word anim_crouch
	.byte $08
	.word anim_crouch_parry
	.byte $01
	.word anim_walk_fw
	.byte $03
	.word anim_walk_bk
	.byte $08
	.word anim_standing_parry
	.byte $02
	.word anim_jump_up
	.byte $05
	.word anim_jump_fw
	.byte $04
	.word anim_jump_bk
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
	.byte $00
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
	.byte $2D								; Special #2 (Teleport)
	.word anim_special_move_2
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
	.word anim_get_up
	.byte $18
	.word anim_scorpion_staggered
	.byte $08
	.word anim_shame
	.byte $08
	.word anim_victory
	.byte $07
	.word anim_crouch_parry
	.byte $07
	.word anim_standing_parry
	.byte $0F
	.word rom_8270
	.byte $0D
	.word rom_8271
	.byte $18				; $2F Scorpion kunai pull
	.word anim_scorpion_pull ;rom_8286
	.byte $0D
	.word rom_8271
	.byte $29
	.word rom_8286
	.byte $19
	.word rom_8271 ;rom_8292
	.byte $18
	.word anim_special_hit ;rom_82A1
	.byte $04
	.word anim_jump_bk

; -----------------------------------------------------------------------------

anim_scorpion_idle:
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
anim_standing_parry:
	.byte $09, $09, $09, $09, $09, $09, $09, $09
anim_jump_up:
	.byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A
	.byte $0A, $0A, $0A, $0A
anim_jump_fw:
	.byte $0B, $0B, $0B, $0B, $0C, $0C, $0D, $0D
	.byte $0C, $0C, $0D, $0D, $0C, $0B, $0B, $0B
anim_jump_bk:
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
anim_uppercut:
	.byte $18, $18, $1A, $1A, $19, $19, $1A, $1A
rom_8177:
	.byte $1B, $1B, $02, $02
rom_817B:
	.byte $00
rom_817C:
	.byte $00
anim_special_move_2:
	.byte $0A, $0A, $17, $17, $17, $17, $17, $17
	.byte $17, $17, $17, $17, $17, $17, $0A, $0A
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
anim_scorpion_pull:
	.byte $33, $33, $33, $33, $32, $32, $32, $32
	.byte $32, $32, $32, $32, $32, $32, $32, $32
	.byte $32, $32, $32, $32, $32, $32, $32, $32
	.byte $32, $32, $32, $32, $32, $32

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
anim_scorpion_staggered:
	.byte $2A, $2A, $2A, $2A, $2A, $2A, $2A, $2A
	.byte $2B, $2B, $2B, $2B, $2B, $2B, $2B, $2B
	.byte $2A, $2A, $2A, $2A, $2A, $2A, $2A, $2A
	.byte $2B, $2B, $2B, $2B, $2B, $2B
anim_shame:
	.byte $2C, $2C, $2C, $2C, $2C, $2C
anim_victory:
	.byte $2D, $2D, $2D, $2D, $2E
    ; Potentially unused
	.byte $2E, $03, $09
rom_8270:
	.byte $37
rom_8271:
	.byte $22, $22, $22, $23, $23, $23, $24, $24
	.byte $37
unused_827A:
	.byte $37, $24, $24, $24, $24, $24, $24, $24
	.byte $24, $24, $00, $00
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
	.word scorpion_frame_00, frame_idle_01, rom_83EC, rom_8405
	.word rom_8422, scorpion_frame_05, rom_8474, rom_849D
	.word rom_84C6, rom_84F8, rom_8521, rom_854E
	.word rom_857B, rom_858F, rom_85A3, rom_85D5
	.word rom_860A, rom_8647, rom_8679, rom_86AB
	.word rom_86DA, rom_8715, rom_873E, rom_8779
	.word rom_87A6, rom_87CB, rom_87FC, rom_883D
	.word rom_886C, rom_88A7, rom_88BC, rom_88F2
	.word rom_890F, rom_8945, rom_8977, rom_89A4
	.word rom_89BD, rom_89E6, rom_89FF, rom_8A18
	.word rom_8A2C, rom_8A41, rom_8A64, rom_8A8D
	.word rom_8AB6, rom_8ADF, rom_8B0C, rom_8B3D
	.word rom_8B6A, rom_8B99, rom_8BCB, rom_8C06
	.word rom_8C4A, rom_8C6F, rom_8CB0, rom_8CE1
	.word rom_8CFE, rom_8D30, rom_8D5D, scorpion_frame_00
	.word scorpion_frame_00, scorpion_frame_00, scorpion_frame_00, scorpion_frame_00
	.word scorpion_frame_00, scorpion_frame_00, scorpion_frame_00, scorpion_frame_00
	.word scorpion_frame_00, scorpion_frame_00, scorpion_frame_00, scorpion_frame_00
	.word scorpion_frame_00, scorpion_frame_00, scorpion_frame_00, scorpion_frame_00
	.word scorpion_frame_00, scorpion_frame_00, scorpion_frame_00, scorpion_frame_00
	.word scorpion_frame_00, scorpion_frame_00, scorpion_frame_00, scorpion_frame_00
	.word scorpion_frame_00, scorpion_frame_00, scorpion_frame_00, scorpion_frame_00
	.word scorpion_frame_00, scorpion_frame_00, scorpion_frame_00, scorpion_frame_00
	.word scorpion_frame_00, scorpion_frame_00, scorpion_frame_00, scorpion_frame_00
	.word scorpion_frame_00, scorpion_frame_00, scorpion_frame_00, scorpion_frame_00
	.word scorpion_frame_00

; -----------------------------------------------------------------------------

scorpion_frame_00:
	.byte $05, $09, $10, $D2, $00, $80, $81, $82
	.byte $FF, $FF, $85, $86, $87, $88, $FF, $8D
	.byte $8E, $8F, $90, $FF, $FF, $95, $96, $97
	.byte $FF, $FF, $9C, $9D, $9E, $9F, $FF, $A3
	.byte $A4, $A5, $FF, $A9, $AA, $AB, $AC, $FF
	.byte $B1, $B2, $B3, $B4, $FF, $B9, $BA, $FF
	.byte $BB, $FF
frame_idle_01:
	.byte $04, $09, $10, $D2, $00, $FF, $83, $84
	.byte $FF, $89, $8A, $8B, $8C, $91, $92, $93
	.byte $94, $98, $99, $9A, $9B, $FF, $A0, $A1
	.byte $A2, $FF, $A6, $A7, $A8, $AD, $AE, $AF
	.byte $B0, $B5, $B6, $B7, $B8, $B9, $BC, $FF
	.byte $BD
rom_83EC:
	.byte $04, $05, $10, $5C, $00, $6C, $6D, $6E
	.byte $6F, $70, $71, $72, $73, $74, $75, $76
	.byte $77, $78, $79, $7A, $7B, $7C, $FF, $7D
	.byte $7E
rom_8405:
	.byte $04, $06, $10, $5E, $00, $82, $83, $84
	.byte $FF, $8B, $8C, $8D, $8E, $98, $99, $9A
	.byte $9B, $A4, $A5, $A6, $A7, $B1, $B2, $B3
	.byte $B4, $BD, $92, $BE, $BF
rom_8422:
	.byte $04, $09, $10, $D0, $00, $01, $02, $03
	.byte $FF, $08, $09, $0A, $0B, $13, $14, $15
	.byte $16, $FF, $1F, $20, $21, $FF, $2A, $2B
	.byte $2C, $FF, $37, $38, $39, $45, $46, $47
	.byte $48, $53, $54, $55, $56, $61, $FF, $62
	.byte $63
scorpion_frame_05:
	.byte $04, $09, $10, $D0, $00, $FF, $04, $05
	.byte $FF, $0C, $0D, $0E, $0F, $17, $18, $19
	.byte $1A, $22, $23, $24, $25, $FF, $2D, $2E
	.byte $2F, $FF, $3A, $3B, $FF, $FF, $49, $4A
	.byte $FF, $FF, $57, $58, $FF, $64, $65, $66
	.byte $FF
rom_8474:
	.byte $04, $09, $10, $D0, $00, $FF, $06, $07
	.byte $FF, $10, $11, $12, $FF, $1B, $1C, $1D
	.byte $1E, $26, $27, $28, $29, $FF, $30, $31
	.byte $32, $FF, $3C, $3D, $3E, $FF, $4B, $4C
	.byte $FF, $FF, $59, $5A, $5B, $FF, $67, $68
	.byte $69
rom_849D:
	.byte $04, $09, $10, $D0, $00, $FF, $04, $05
	.byte $FF, $0C, $0D, $0E, $0F, $17, $18, $19
	.byte $1A, $22, $23, $24, $25, $FF, $2D, $33
	.byte $2F, $FF, $3F, $40, $41, $FF, $4D, $4E
	.byte $4F, $FF, $5C, $5D, $FF, $FF, $6A, $6B
	.byte $FF
rom_84C6:
	.byte $05, $09, $10, $D0, $00, $01, $02, $03
	.byte $FF, $FF, $08, $09, $0A, $0B, $FF, $13
	.byte $14, $15, $16, $FF, $FF, $1F, $20, $21
	.byte $FF, $FF, $34, $35, $36, $FF, $FF, $42
	.byte $43, $44, $FF, $FF, $50, $51, $52, $FF
	.byte $FF, $5E, $5F, $60, $FF, $6C, $6D, $FF
	.byte $6E, $6F
rom_84F8:
	.byte $04, $09, $10, $5E, $00, $DE, $DF, $E0
	.byte $FF, $E1, $E2, $E3, $FF, $E4, $E5, $E6
	.byte $FF, $E7, $E8, $E9, $FF, $EA, $EB, $EC
	.byte $FF, $ED, $EE, $EF, $FF, $F0, $F1, $F2
	.byte $FF, $F3, $F4, $F5, $FF, $F6, $FF, $F7
	.byte $F8
rom_8521:
	.byte $05, $08, $10, $58, $00, $FF, $FF, $0D
	.byte $0E, $FF, $FF, $17, $18, $19, $FF, $FF
	.byte $23, $24, $25, $26, $FF, $30, $31, $32
	.byte $33, $FF, $3D, $3E, $3F, $40, $4D, $4E
	.byte $4F, $50, $51, $5D, $5E, $5F, $60, $19
	.byte $FF, $FF, $FF, $6B, $FF
rom_854E:
	.byte $04, $0A, $10, $5E, $00, $FF, $C5, $C6
	.byte $FF, $C7, $C8, $C9, $FF, $CA, $CB, $CC
	.byte $FF, $CD, $CE, $CF, $D0, $D1, $D2, $D3
	.byte $FF, $D4, $D5, $FF, $FF, $D6, $D7, $FF
	.byte $FF, $D8, $D9, $FF, $FF, $DA, $DB, $FF
	.byte $FF, $DC, $DD, $FF, $FF
rom_857B:
	.byte $03, $05, $10, $58, $00, $6F, $70, $71
	.byte $72, $73, $74, $75, $76, $77, $78, $79
	.byte $7A, $FF, $7B, $7C
rom_858F:
	.byte $03, $05, $10, $58, $40, $71, $70, $6F
	.byte $74, $73, $72, $77, $76, $75, $7A, $79
	.byte $78, $7C, $7B, $FF
rom_85A3:
	.byte $05, $09, $10, $68, $00, $01, $02, $FF
	.byte $FF, $FF, $06, $07, $08, $FF, $FF, $0C
	.byte $0D, $0E, $FF, $FF, $16, $17, $18, $FF
	.byte $FF, $FF, $1E, $1F, $20, $FF, $FF, $2B
	.byte $2C, $2D, $FF, $3F, $40, $41, $42, $43
	.byte $57, $58, $FF, $59, $5A, $6E, $6F, $FF
	.byte $FF, $FF
rom_85D5:
	.byte $06, $08, $10, $62, $00, $FF, $C1, $C2
	.byte $FF, $FF, $FF, $C3, $C4, $C5, $FF, $FF
	.byte $FF, $C6, $C7, $C8, $C9, $CA, $CB, $CC
	.byte $CD, $CE, $CF, $D0, $D1, $D2, $D3, $D4
	.byte $D5, $FF, $FF, $FF, $D6, $D7, $FF, $FF
	.byte $FF, $FF, $FF, $D8, $FF, $FF, $FF, $FF
	.byte $D9, $DA, $FF, $FF, $FF
rom_860A:
	.byte $07, $08, $10, $62, $00, $FF, $FF, $FF
	.byte $FF, $DC, $DD, $DE, $DF, $E0, $FF, $E1
	.byte $E2, $E3, $FF, $E4, $E5, $E6, $E7, $E8
	.byte $FF, $FF, $E9, $EA, $EB, $EC, $FF, $FF
	.byte $FF, $ED, $EE, $EF, $F0, $FF, $FF, $FF
	.byte $FF, $FF, $F1, $F2, $FF, $FF, $FF, $FF
	.byte $FF, $F3, $FF, $FF, $FF, $FF, $FF, $F4
	.byte $F5, $FF, $FF, $FF, $FF
rom_8647:
	.byte $05, $08, $10, $58, $00, $FF, $FF, $0D
	.byte $0E, $FF, $FF, $17, $18, $19, $FF, $FF
	.byte $23, $24, $25, $26, $FF, $30, $31, $32
	.byte $33, $FF, $3D, $3E, $3F, $40, $4D, $4E
	.byte $4F, $50, $51, $5D, $5E, $5F, $60, $19
	.byte $FF, $FF, $FF, $6B, $FF
unused_8674:
	.byte $07, $08, $10, $10, $00
rom_8679:
	.byte $05, $08, $10, $58, $00, $FF, $FF, $0D
	.byte $0E, $FF, $FF, $17, $18, $19, $FF, $FF
	.byte $23, $24, $25, $26, $FF, $30, $31, $32
	.byte $33, $FF, $3D, $3E, $3F, $40, $4D, $4E
	.byte $4F, $50, $51, $5D, $5E, $5F, $60, $19
	.byte $FF, $FF, $FF, $6B, $FF
unused_86A6:
	.byte $07, $08, $10, $10, $00
rom_86AB:
	.byte $06, $07, $10, $58, $00, $FF, $FF, $1A
	.byte $1B, $FF, $FF, $FF, $27, $28, $29, $FF
	.byte $FF, $FF, $34, $35, $36, $FF, $05, $FF
	.byte $41, $42, $43, $44, $45, $FF, $52, $53
	.byte $54, $55, $56, $61, $62, $63, $64, $FF
	.byte $FF, $6C, $6D, $6E, $FF, $FF, $FF
rom_86DA:
	.byte $06, $09, $10, $5A, $00, $FF, $FF, $80
	.byte $81, $FF, $FF, $FF, $87, $88, $89, $8A
	.byte $8B, $FF, $94, $95, $96, $97, $98, $FF
	.byte $A2, $A3, $A4, $FF, $FF, $FF, $AC, $AD
	.byte $FF, $FF, $FF, $FF, $B3, $B4, $FF, $FF
	.byte $FF, $BC, $BD, $BE, $FF, $FF, $FF, $C6
	.byte $C7, $C8, $FF, $FF, $FF, $CF, $FF, $D0
	.byte $D1, $FF, $FF
rom_8715:
	.byte $04, $09, $10, $5A, $00, $FF, $82, $83
	.byte $84, $FF, $8C, $8D, $8E, $FF, $99, $9A
	.byte $9B, $FF, $A5, $A6, $A7, $FF, $AE, $AF
	.byte $B0, $B5, $B6, $B7, $B8, $BF, $C0, $C1
	.byte $C2, $C9, $CA, $CB, $CC, $D2, $FF, $D3
	.byte $D1
rom_873E:
	.byte $06, $09, $10, $5A, $00, $FF, $FF, $85
	.byte $86, $FF, $FF, $F2, $8F, $90, $91, $92
	.byte $93, $9C, $9D, $9E, $9F, $A0, $A1, $FF
	.byte $A9, $AA, $AB, $FF, $FF, $FF, $B1, $B2
	.byte $FF, $FF, $FF, $B9, $BA, $BB, $FF, $FF
	.byte $FF, $C3, $C4, $C5, $FF, $FF, $FF, $CD
	.byte $CE, $CB, $FF, $FF, $FF, $D4, $FF, $D3
	.byte $D1, $FF, $FF
rom_8779:
	.byte $08, $05, $20, $66, $00, $FF, $FF, $FF
	.byte $CB, $CC, $CD, $FF, $FF, $FF, $FF, $FF
	.byte $CE, $CF, $D0, $FF, $FF, $FF, $FF, $D1
	.byte $D2, $D3, $D4, $D5, $FF, $FF, $D6, $D7
	.byte $D8, $D9, $DA, $DB, $DC, $DD, $DE, $DF
	.byte $E0, $E1, $E2, $FF, $FF
rom_87A6:
	.byte $04, $08, $10, $60, $00, $FF, $FF, $0E
	.byte $0F, $FF, $1B, $1C, $1D, $FF, $29, $2A
	.byte $2B, $FF, $36, $37, $38, $FF, $43, $44
	.byte $45, $4D, $4E, $4F, $50, $58, $59, $5A
	.byte $5B, $64, $FF, $65, $66
rom_87CB:
	.byte $04, $0B, $10, $60, $00, $FF, $01, $02
	.byte $FF, $FF, $04, $05, $06, $FF, $0A, $0B
	.byte $08, $15, $16, $17, $18, $22, $23, $24
	.byte $FF, $2F, $30, $31, $FF, $FF, $3C, $3D
	.byte $3E, $FF, $49, $4A, $FF, $54, $55, $56
	.byte $FF, $5F, $60, $61, $FF, $69, $FF, $6A
	.byte $6B
rom_87FC:
	.byte $06, $0A, $10, $60, $00, $FF, $FF, $03
	.byte $FF, $FF, $FF, $FF, $FF, $07, $08, $FF
	.byte $09, $FF, $10, $11, $12, $13, $14, $1E
	.byte $1F, $20, $21, $FF, $FF, $2C, $2D, $2E
	.byte $FF, $FF, $FF, $FF, $39, $3A, $3B, $FF
	.byte $FF, $FF, $46, $47, $48, $FF, $FF, $51
	.byte $52, $53, $FF, $FF, $FF, $5C, $5D, $5E
	.byte $FF, $FF, $FF, $67, $FF, $68, $FF, $FF
	.byte $FF
rom_883D:
	.byte $06, $07, $10, $5E, $00, $FF, $FF, $FF
	.byte $FF, $FF, $81, $FF, $FF, $FF, $FF, $85
	.byte $86, $FF, $FF, $8F, $90, $91, $92, $9C
	.byte $9D, $9E, $9F, $92, $FF, $A8, $A9, $AA
	.byte $AB, $AC, $FF, $B5, $B6, $B7, $B8, $B9
	.byte $FF, $C0, $C1, $C2, $C3, $C4, $FF
rom_886C:
	.byte $06, $09, $10, $66, $00, $FF, $FF, $80
	.byte $81, $FF, $FF, $82, $83, $84, $85, $FF
	.byte $FF, $86, $87, $88, $89, $FF, $FF, $FF
	.byte $FF, $8C, $8D, $FB, $FF, $FF, $FF, $8F
	.byte $90, $91, $FF, $FF, $FF, $99, $9A, $9B
	.byte $FF, $FF, $FF, $A4, $A5, $A6, $A7, $FF
	.byte $FF, $B3, $B4, $B5, $B6, $FF, $FF, $C0
	.byte $C1, $FF, $C2
rom_88A7:
	.byte $04, $04, $10, $66, $00, $9C, $9D, $9E
	.byte $9F, $A8, $A9, $AA, $AB, $B7, $B8, $B9
	.byte $BA, $C4, $C5, $C6, $C7
rom_88BC:
	.byte $07, $07, $10, $66, $00, $FF, $FF, $FF
	.byte $FF, $8A, $8B, $FF, $FF, $FF, $FF, $FC
	.byte $8E, $FF, $FF, $FF, $95, $96, $97, $98
	.byte $FF, $FF, $A0, $A1, $A2, $A3, $FF, $FF
	.byte $FF, $AC, $AD, $AE, $AF, $B0, $B1, $B2
	.byte $FF, $FF, $BB, $BC, $BD, $BE, $BF, $FF
	.byte $FF, $C8, $C9, $CA, $FF, $FF
rom_88F2:
	.byte $04, $06, $10, $6A, $00, $98, $99, $9A
	.byte $FF, $A5, $A6, $A7, $FF, $B1, $B2, $B3
	.byte $FF, $BF, $C0, $C1, $FF, $CD, $CE, $CF
	.byte $FF, $FF, $DA, $DB, $DC
rom_890F:
	.byte $07, $07, $10, $6A, $00, $FF, $92, $93
	.byte $FF, $FF, $FF, $FF, $9B, $9C, $9D, $9E
	.byte $FF, $FF, $FF, $A8, $A9, $AA, $AB, $FF
	.byte $FF, $FF, $B4, $B5, $B6, $B7, $B8, $FF
	.byte $FF, $FF, $C2, $C3, $C4, $C5, $C6, $FF
	.byte $FF, $FF, $D0, $D1, $D2, $D3, $D4, $FF
	.byte $FF, $DD, $DE, $DF, $FF, $FF
rom_8945:
	.byte $05, $09, $10, $5A, $00, $FF, $D5, $D6
	.byte $FF, $D7, $D8, $D9, $DA, $DB, $DC, $DD
	.byte $DE, $DF, $E0, $E1, $FF, $E2, $E3, $FF
	.byte $FF, $FF, $E4, $E5, $FF, $FF, $E6, $E7
	.byte $E8, $FF, $FF, $E9, $EA, $EB, $FF, $FF
	.byte $EC, $ED, $EE, $FF, $FF, $EF, $FF, $F0
	.byte $F1, $FF
rom_8977:
	.byte $05, $08, $10, $68, $00, $FF, $03, $04
	.byte $05, $FF, $FF, $09, $0A, $0B, $FF, $0F
	.byte $10, $11, $12, $13, $19, $1A, $1B, $FF
	.byte $FF, $21, $22, $23, $FF, $FF, $2E, $2F
	.byte $30, $FF, $FF, $44, $45, $FF, $FF, $FF
	.byte $5B, $5C, $5D, $FF, $FF
rom_89A4:
	.byte $05, $04, $10, $68, $00, $24, $FF, $25
	.byte $26, $27, $31, $32, $2B, $2B, $33, $46
	.byte $47, $48, $49, $4A, $FF, $5E, $5F, $60
	.byte $61
rom_89BD:
	.byte $06, $06, $10, $68, $00, $FF, $FF, $FF
	.byte $FF, $14, $15, $FF, $FF, $FF, $FF, $1C
	.byte $1D, $FF, $FF, $FF, $28, $29, $2A, $34
	.byte $35, $36, $37, $38, $FF, $4B, $4C, $4D
	.byte $4E, $FF, $FF, $62, $63, $64, $65, $FF
	.byte $FF
rom_89E6:
	.byte $05, $04, $10, $60, $00, $FF, $6E, $6F
	.byte $70, $FF, $71, $72, $73, $74, $75, $FF
	.byte $77, $78, $79, $7A, $FF, $7B, $7C, $7D
	.byte $7E
rom_89FF:
	.byte $05, $04, $10, $60, $00, $FF, $6E, $6F
	.byte $70, $FF, $71, $72, $73, $74, $75, $FF
	.byte $77, $78, $79, $7A, $FF, $7B, $7C, $7D
	.byte $7E
rom_8A18:
	.byte $03, $05, $10, $6C, $00, $20, $21, $22
	.byte $2F, $30, $31, $3F, $40, $41, $4F, $43
	.byte $50, $61, $43, $62
rom_8A2C:
	.byte $04, $04, $10, $6C, $00, $FF, $32, $33
	.byte $FF, $42, $43, $43, $44, $51, $52, $53
	.byte $54, $63, $64, $65, $66
rom_8A41:
	.byte $05, $06, $10, $6C, $00, $FF, $15, $16
	.byte $FF, $17, $FF, $23, $24, $25, $26, $FF
	.byte $34, $35, $36, $37, $45, $46, $43, $47
	.byte $FF, $55, $56, $57, $58, $59, $FF, $67
	.byte $68, $69, $FF
rom_8A64:
	.byte $04, $09, $10, $6A, $00, $E0, $E1, $FF
	.byte $FF, $E2, $E3, $E4, $FF, $E5, $E6, $E7
	.byte $FF, $E8, $E9, $EA, $FF, $EB, $EC, $ED
	.byte $FF, $EE, $EF, $F0, $FF, $F1, $F2, $F3
	.byte $F4, $F5, $F6, $F7, $F8, $F9, $FA, $FB
	.byte $FC
rom_8A8D:
	.byte $04, $09, $10, $6C, $00, $FF, $FF, $01
	.byte $02, $03, $04, $05, $06, $09, $0A, $0B
	.byte $0C, $11, $12, $13, $14, $1C, $1D, $1E
	.byte $1F, $2B, $2C, $2D, $2E, $3C, $3D, $3E
	.byte $FF, $4C, $4D, $4E, $FF, $5F, $FF, $60
	.byte $FF
rom_8AB6:
	.byte $04, $09, $10, $64, $00, $FF, $06, $07
	.byte $FF, $15, $16, $17, $18, $24, $25, $26
	.byte $27, $32, $33, $34, $35, $3E, $3F, $40
	.byte $FF, $49, $4A, $4B, $FF, $54, $55, $56
	.byte $57, $5E, $5F, $60, $61, $68, $FF, $69
	.byte $6A
rom_8ADF:
	.byte $04, $0A, $10, $6E, $00, $FF, $80, $81
	.byte $FF, $84, $85, $86, $FF, $8D, $8E, $8F
	.byte $90, $98, $99, $9A, $9B, $FF, $A4, $A5
	.byte $A6, $B1, $B2, $B3, $B4, $BF, $C0, $C1
	.byte $FF, $CD, $CE, $CF, $FF, $DD, $DE, $DF
	.byte $FF, $ED, $FF, $EE, $D8
rom_8B0C:
	.byte $04, $0B, $10, $70, $00, $01, $FF, $FF
	.byte $FF, $02, $03, $FF, $FF, $04, $05, $06
	.byte $FF, $07, $08, $09, $0A, $0B, $0C, $0D
	.byte $0E, $0F, $10, $11, $12, $13, $14, $15
	.byte $16, $17, $18, $19, $FF, $1A, $1B, $1C
	.byte $FF, $1D, $FF, $1E, $FF, $1F, $FF, $20
	.byte $FF
rom_8B3D:
	.byte $05, $08, $10, $6C, $00, $FF, $07, $08
	.byte $FF, $FF, $0D, $0E, $0F, $10, $FF, $18
	.byte $19, $1A, $1B, $FF, $27, $28, $29, $2A
	.byte $FF, $38, $39, $3A, $3B, $FF, $48, $49
	.byte $4A, $4B, $FF, $5A, $5B, $5C, $5D, $5E
	.byte $FF, $6A, $FF, $6B, $6C
rom_8B6A:
	.byte $07, $06, $10, $6E, $00, $FF, $FF, $9C
	.byte $FF, $FF, $FF, $FF, $A7, $A8, $A9, $AA
	.byte $FF, $FF, $FF, $B5, $B6, $B7, $B8, $FF
	.byte $FF, $FF, $C2, $C3, $C4, $C5, $C6, $FF
	.byte $FF, $D0, $D1, $D2, $D3, $D4, $D5, $FF
	.byte $E0, $E1, $E2, $FF, $E3, $E4, $E5
rom_8B99:
	.byte $05, $09, $10, $60, $00, $0C, $0D, $FF
	.byte $FF, $FF, $19, $1A, $02, $FF, $FF, $25
	.byte $26, $27, $28, $FF, $32, $33, $34, $35
	.byte $FF, $FF, $3F, $40, $41, $42, $FF, $4B
	.byte $4C, $FF, $FF, $FF, $4B, $57, $FF, $FF
	.byte $FF, $62, $63, $FF, $FF, $FF, $6C, $6D
	.byte $FF, $FF
rom_8BCB:
	.byte $06, $09, $10, $D2, $00, $FF, $FF, $BE
	.byte $BF, $FF, $FF, $FF, $C2, $C3, $C4, $FF
	.byte $FF, $CB, $CC, $CD, $CE, $FF, $FF, $D3
	.byte $D4, $D5, $D6, $FF, $FF, $FF, $FF, $D9
	.byte $DA, $FF, $FF, $FF, $DE, $DF, $E0, $E1
	.byte $FF, $FF, $E4, $E5, $E6, $E7, $FF, $FF
	.byte $EB, $EC, $ED, $EE, $FF, $FF, $F3, $F4
	.byte $FF, $F5, $F6
rom_8C06:
	.byte $07, $09, $10, $D4, $00, $FF, $FF, $01
	.byte $02, $FF, $FF, $FF, $FF, $03, $04, $05
	.byte $06, $07, $08, $FF, $09, $0A, $0B, $0C
	.byte $FF, $FF, $FF, $FF, $0D, $0E, $FF, $FF
	.byte $FF, $FF, $0F, $10, $11, $FF, $FF, $FF
	.byte $FF, $12, $13, $14, $FF, $FF, $FF, $FF
	.byte $15, $16, $17, $FF, $FF, $FF, $18, $19
	.byte $1A, $1B, $FF, $FF, $FF, $1C, $FF, $FF
	.byte $1D, $1E, $FF, $FF
rom_8C4A:
	.byte $04, $08, $10, $60, $00, $FF, $FF, $0E
	.byte $0F, $FF, $1B, $1C, $1D, $FF, $29, $2A
	.byte $2B, $FF, $36, $37, $38, $FF, $43, $44
	.byte $45, $4D, $4E, $4F, $50, $58, $59, $5A
	.byte $5B, $64, $FF, $65, $66
rom_8C6F:
	.byte $06, $0A, $10, $60, $00, $FF, $FF, $03
	.byte $FF, $FF, $FF, $FF, $FF, $07, $08, $FF
	.byte $09, $FF, $10, $11, $12, $13, $14, $1E
	.byte $1F, $20, $21, $FF, $FF, $2C, $2D, $2E
	.byte $FF, $FF, $FF, $FF, $39, $3A, $3B, $FF
	.byte $FF, $FF, $46, $47, $48, $FF, $FF, $51
	.byte $52, $53, $FF, $FF, $FF, $5C, $5D, $5E
	.byte $FF, $FF, $FF, $67, $FF, $68, $FF, $FF
	.byte $FF
rom_8CB0:
	.byte $04, $0B, $10, $60, $00, $FF, $01, $02
	.byte $FF, $FF, $04, $05, $06, $FF, $0A, $0B
	.byte $08, $15, $16, $17, $18, $22, $23, $24
	.byte $FF, $2F, $30, $31, $FF, $FF, $3C, $3D
	.byte $3E, $FF, $49, $4A, $FF, $54, $55, $56
	.byte $FF, $5F, $60, $61, $FF, $69, $FF, $6A
	.byte $6B
rom_8CE1:
	.byte $08, $03, $10, $68, $00, $39, $3A, $3B
	.byte $3C, $3D, $3E, $FF, $FF, $4F, $50, $51
	.byte $52, $53, $54, $55, $56, $66, $67, $68
	.byte $69, $6A, $6B, $6C, $6D
rom_8CFE:
	.byte $05, $09, $10, $68, $40
	.byte $FF, $FF, $FF, $02, $01, $FF, $FF, $08
	.byte $07, $06, $FF, $FF, $0E, $0D, $0C, $FF
	.byte $FF, $18, $17, $16, $FF, $20, $1F, $1E
	.byte $FF, $FF, $2D, $2C, $2B, $FF, $43, $42
	.byte $41, $40, $3F, $5A, $59, $FF, $58, $57
	.byte $FF, $FF, $FF, $6F, $6E
rom_8D30:
	.byte $05, $08, $10, $68, $00, $FF, $03, $04
	.byte $05, $FF, $FF, $09, $0A, $0B, $FF, $0F
	.byte $10, $11, $12, $13, $19, $1A, $1B, $FF
	.byte $FF, $21, $22, $23, $FF, $FF, $2E, $2F
	.byte $30, $FF, $FF, $44, $45, $FF, $FF, $FF
	.byte $5B, $5C, $5D, $FF, $FF
rom_8D5D:
	.byte $06, $06, $10, $68, $C0, $FF, $FF, $65
	.byte $64, $63, $62, $FF, $FF, $4E, $4D, $4C
	.byte $4B, $FF, $38, $37, $36, $35, $34, $2A
	.byte $29, $28, $FF, $FF, $FF, $1D, $1C, $FF
	.byte $FF, $FF, $FF, $15, $14, $FF, $FF, $FF
	.byte $FF

; -----------------------------------------------------------------------------

; The rest is rubbish as usual
