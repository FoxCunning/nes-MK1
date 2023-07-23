.segment "BANK_05t"
; $8000-$8FFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"


; -----------------------------------------------------------------------------

; Data pointers for Rayden
rom_8000:
	.word rom_8004, rom_82C7

; -----------------------------------------------------------------------------

rom_8004:
	.byte $09				; $00 Idle
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
	.byte $04				; $08
    .word rom_80ED
    .byte $07
    .word rom_80FD
    .byte $07
    .word rom_8105
    .byte $08
    .word rom_810D
    .byte $0A
    .word rom_8113
    .byte $08				; $0D Teleport
    .word anim_special_move_1
    .byte $02
    .word rom_8137
    .byte $02
    .word rom_8143
	.byte $00				; $10
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
    .byte $0B				; $17 Torpedo
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
    .byte $18				; $1E Lightning
    .word anim_ranged_attack
    .byte $04
    .word rom_81F8
	.byte $04				; $20
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
    .byte $08				; $27
    .word anim_get_up
	.byte $18				; $28 Staggered
    .word anim_staggered
    .byte $08
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
	.byte $0D				; $30
    .word rom_8271
    .byte $29
    .word rom_8286
    .byte $19
    .word rom_8292
    .byte $18
    .word anim_special_hit
    .byte $04
    .word rom_80ED

; -----------------------------------------------------------------------------

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
	; Basically a reversed "get up"
	.byte $29, $29, $28, $28, $27, $27
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
anim_staggered:
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
	.byte $24, $24, $24, $24, $24, $24, $24, $24
	.byte $24, $24, $24, $00, $00
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

; More pointers
rom_82C7:
	.word rayden_frame_00, rayden_frame_01, rayden_frame_02, rom_8400
	.word rom_8421, rom_8453, rom_847C, rom_84A5
	.word rom_84D7, rom_8500, rayden_frame_0B, rom_854E
	.word rom_8577, rom_858C, rom_85A1, rom_85D3
	.word rom_8600, rom_864B, rom_8678, rom_86B5
	.word rom_86F9, rom_872B, rom_876F, rom_87B3
	.word rom_87D6, rom_87F7, rom_8824, rom_885F
	.word rom_888E, rom_88D2, rom_8909, rom_893F
	.word rom_8967, rom_899C, rom_89D7, rom_89FC
	.word rom_8A24, rom_8A47, rom_8A6A, rom_8A87
	.word rom_8AA0, rom_8AC5, rom_8AEE, rom_8B17
	.word rom_8B37, rom_8B60, rom_8B89, rom_8BBA
	.word rom_8BE7, rom_8C0A, rom_8C3C, rom_8C65
	.word rom_8C97, rom_8CB8, rom_8CF9, rom_8D19
	.word rom_8D19, rom_8D4B, rom_8D70
; The rest are potentially unused
	.word rayden_frame_00, rayden_frame_00, rayden_frame_00, rayden_frame_00
	.word rayden_frame_00, rayden_frame_00, rayden_frame_00, rayden_frame_00
	.word rayden_frame_00, rayden_frame_00, rayden_frame_00, rayden_frame_00
	.word rayden_frame_00, rayden_frame_00, rayden_frame_00, rayden_frame_00
	.word rayden_frame_00, rayden_frame_00, rayden_frame_00, rayden_frame_00
	.word rayden_frame_00, rayden_frame_00, rayden_frame_00, rayden_frame_00
	.word rayden_frame_00, rayden_frame_00, rayden_frame_00, rayden_frame_00
	.word rayden_frame_00, rayden_frame_00, rayden_frame_00, rayden_frame_00
	.word rayden_frame_00, rayden_frame_00, rayden_frame_00, rayden_frame_00
	.word rayden_frame_00, rayden_frame_00, rayden_frame_00, rayden_frame_00
	.word rayden_frame_00, rayden_frame_00

; -----------------------------------------------------------------------------

rayden_frame_00:
	.byte $04, $09, $10, $00, $00, $FF, $01, $02
	.byte $FF, $09, $0A, $0B, $0C, $18, $19, $1A
	.byte $1B, $29, $2A, $2B, $2C, $37, $38, $39
	.byte $FF, $43, $44, $45, $46, $51, $52, $53
	.byte $54, $62, $FF, $63, $64, $6B, $FF, $6C
	.byte $6D

; -----------------------------------------------------------------------------

rayden_frame_01:
	.byte $04, $09, $10, $00, $00, $FF, $03, $04
	.byte $FF, $09, $0D, $0E, $0F, $1C, $1D, $1E
	.byte $1F, $2D, $2E, $2F, $30, $3A, $3B, $3C
	.byte $FF, $47, $48, $49, $4A, $55, $56, $57
	.byte $58, $65, $FF, $66, $67, $6E, $FF, $6F
	.byte $70

; -----------------------------------------------------------------------------

rayden_frame_02:
	.byte $04, $06, $10, $02, $00, $FF, $AC, $AD
	.byte $FF, $BB, $BC, $BD, $BE, $CB, $CC, $CD
	.byte $CE, $D8, $D9, $DA, $DB, $E1, $E2, $E3
	.byte $E4, $E9, $EA, $FF, $EB

; -----------------------------------------------------------------------------

rom_8400:
	.byte $04, $07, $10, $04, $00, $1F, $20, $21
	.byte $22, $2E, $2F, $30, $31, $3E, $3F, $40
	.byte $FF, $FF, $4D, $4E, $FF, $57, $58, $59
	.byte $5A, $63, $64, $65, $66, $6D, $6E, $FF
	.byte $6F

; -----------------------------------------------------------------------------

rom_8421:
	.byte $05, $09, $10, $08, $00, $FF, $01, $02
	.byte $03, $FF, $FF, $09, $0A, $0B, $0C, $FF
	.byte $13, $14, $15, $16, $FF, $1F, $20, $21
	.byte $FF, $FF, $2A, $2B, $FF, $FF, $FF, $39
	.byte $3A, $3B, $FF, $FF, $4B, $4C, $4D, $FF
	.byte $5B, $5C, $5D, $5E, $FF, $6C, $6D, $6E
	.byte $6F, $FF

; -----------------------------------------------------------------------------

rom_8453:
	.byte $04, $09, $08, $08, $00, $04, $05, $06
	.byte $FF, $0D, $0E, $0F, $10, $17, $18, $19
	.byte $1A, $22, $23, $24, $25, $2C, $2D, $FF
	.byte $FF, $3C, $3D, $3E, $FF, $4E, $4F, $50
	.byte $FF, $5F, $60, $61, $FF, $70, $71, $FF
	.byte $FF

; -----------------------------------------------------------------------------

rom_847C:
	.byte $04, $09, $08, $08, $00, $01, $02, $03
	.byte $FF, $09, $0A, $0B, $0C, $13, $14, $15
	.byte $16, $1F, $20, $21, $FF, $2E, $2F, $FF
	.byte $FF, $3F, $40, $41, $FF, $51, $52, $53
	.byte $FF, $62, $63, $64, $FF, $72, $73, $74
	.byte $FF

; -----------------------------------------------------------------------------

rom_84A5:
	.byte $05, $09, $10, $08, $00, $FF, $04, $05
	.byte $06, $FF, $FF, $0D, $0E, $0F, $10, $FF
	.byte $17, $18, $19, $1A, $FF, $22, $23, $24
	.byte $25, $FF, $30, $31, $32, $FF, $FF, $42
	.byte $43, $0F, $FF, $FF, $54, $55, $56, $FF
	.byte $65, $66, $67, $0F, $FF, $75, $76, $77
	.byte $FF, $FF

; -----------------------------------------------------------------------------

rom_84D7:
	.byte $04, $09, $08, $08, $00, $01, $02, $03
	.byte $FF, $09, $0A, $0B, $0C, $13, $14, $15
	.byte $16, $1F, $20, $21, $FF, $33, $34, $35
	.byte $FF, $44, $45, $46, $FF, $57, $58, $59
	.byte $FF, $68, $69, $6A, $FF, $78, $79, $FF
	.byte $FF

; -----------------------------------------------------------------------------

rom_8500:
	.byte $04, $09, $10, $06, $00, $FF, $80, $81
	.byte $82, $FF, $83, $84, $85, $FF, $88, $89
	.byte $FF, $FF, $8D, $8E, $FF, $FF, $98, $99
	.byte $9A, $FF, $A7, $A8, $A9, $B7, $B8, $B9
	.byte $BA, $CB, $CC, $FF, $CD, $DB, $FF, $FF
	.byte $DC

; -----------------------------------------------------------------------------

rayden_frame_0B:
	.byte $04, $08, $10, $0C, $00, $FF, $0B, $0C
	.byte $FF, $FF, $14, $15, $FF, $1F, $20, $21
	.byte $22, $2C, $2D, $2E, $2F, $3F, $40, $41
	.byte $42, $52, $53, $54, $55, $64, $65, $66
	.byte $67, $72, $73, $74, $75

; -----------------------------------------------------------------------------

rom_854E:
	.byte $04, $09, $10, $0C, $00, $FF, $04, $05
	.byte $FF, $FF, $09, $0A, $FF, $11, $12, $13
	.byte $FF, $1A, $1B, $1C, $FF, $26, $27, $28
	.byte $29, $34, $35, $36, $37, $47, $48, $49
	.byte $FF, $5A, $5B, $5C, $FF, $6A, $6B, $FF
	.byte $FF

; -----------------------------------------------------------------------------

rom_8577:
	.byte $04, $04, $10, $0C, $00, $FF, $38, $39
	.byte $3A, $FF, $4A, $4B, $4C, $5D, $5E, $5F
	.byte $60, $6C, $6D, $6E, $6F

; -----------------------------------------------------------------------------

rom_858C:
	.byte $04, $04, $10, $0C, $40, $3A, $39, $38
	.byte $FF, $4C, $4B, $4A, $FF, $60, $5F, $5E
	.byte $5D, $6F, $6E, $6D, $6C

; -----------------------------------------------------------------------------

rom_85A1:
	.byte $05, $09, $10, $0A, $00, $D4, $D5, $FF
	.byte $FF, $FF, $D6, $D7, $FF, $D8, $FF, $D9
	.byte $DA, $DB, $DC, $FF, $DD, $DE, $DF, $E0
	.byte $FF, $E1, $E2, $E3, $E4, $FF, $FF, $E5
	.byte $E6, $E7, $FF, $FF, $E8, $E9, $EA, $EB
	.byte $FF, $EC, $ED, $EE, $EF, $FF, $F0, $FF
	.byte $F1, $F2

; -----------------------------------------------------------------------------

rom_85D3:
	.byte $05, $08, $10, $02, $00, $8C, $8D, $8E
	.byte $8F, $FF, $9E, $9F, $A0, $A1, $A2, $AE
	.byte $AF, $B0, $B1, $B2, $BF, $C0, $C1, $C2
	.byte $C3, $FF, $CF, $D0, $D1, $FF, $FF, $FF
	.byte $DC, $FF, $FF, $FF, $FF, $E5, $FF, $FF
	.byte $FF, $EC, $ED, $FF, $FF

; -----------------------------------------------------------------------------

rom_8600:
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

; -----------------------------------------------------------------------------

rom_864B:
	.byte $04, $0A, $10, $10, $00, $01, $02, $FF
	.byte $FF, $03, $04, $05, $FF, $0A, $0B, $0C
	.byte $0D, $15, $16, $17, $18, $26, $27, $28
	.byte $FF, $35, $36, $37, $FF, $44, $45, $46
	.byte $FF, $51, $52, $53, $FF, $60, $61, $62
	.byte $FF, $6F, $70, $FF, $FF

; -----------------------------------------------------------------------------

rom_8678:
	.byte $07, $08, $10, $10, $00, $FF, $FF, $FF
	.byte $0E, $FF, $FF, $FF, $FF, $FF, $19, $1A
	.byte $FF, $FF, $FF, $FF, $29, $2A, $2B, $FF
	.byte $FF, $FF, $FF, $38, $39, $3A, $3B, $3C
	.byte $FF, $FF, $FF, $47, $48, $49, $4A, $FF
	.byte $FF, $FF, $54, $55, $56, $57, $58, $63
	.byte $64, $65, $66, $FF, $67, $68, $71, $72
	.byte $73, $FF, $FF, $FF, $FF

; -----------------------------------------------------------------------------

rom_86B5:
	.byte $07, $09, $10, $10, $00, $FF, $FF, $06
	.byte $07, $FF, $FF, $FF, $FF, $01, $0F, $10
	.byte $FF, $FF, $11, $FF, $1B, $1C, $1D, $1E
	.byte $1F, $20, $FF, $2C, $2D, $2E, $2F, $30
	.byte $FF, $3D, $3E, $3F, $40, $41, $FF, $FF
	.byte $FF, $4B, $4C, $FF, $FF, $FF, $FF, $59
	.byte $5A, $5B, $FF, $FF, $FF, $FF, $69, $6A
	.byte $FF, $FF, $FF, $FF, $FF, $74, $FF, $FF
	.byte $FF, $FF, $FF, $FF

; -----------------------------------------------------------------------------

rom_86F9:
	.byte $05, $09, $10, $00, $00, $FF, $FF, $FF
	.byte $07, $08, $FF, $FF, $15, $16, $17, $FF
	.byte $FF, $26, $27, $28, $FF, $33, $34, $35
	.byte $36, $FF, $40, $41, $42, $FF, $FF, $4E
	.byte $4F, $50, $FF, $5E, $5F, $60, $61, $FF
	.byte $68, $69, $FF, $6A, $FF, $71, $FF, $72
	.byte $73, $FF

; -----------------------------------------------------------------------------

rom_872B:
	.byte $07, $09, $10, $00, $00, $FF, $FF, $FF
	.byte $05, $06, $FF, $FF, $FF, $10, $11, $12
	.byte $13, $FF, $14, $FF, $20, $21, $22, $23
	.byte $24, $25, $FF, $FF, $31, $32, $FF, $FF
	.byte $FF, $FF, $3D, $3E, $3F, $FF, $FF, $FF
	.byte $FF, $4B, $4C, $4D, $FF, $FF, $FF, $59
	.byte $5A, $5B, $5C, $5D, $FF, $FF, $68, $69
	.byte $FF, $6A, $FF, $FF, $FF, $71, $FF, $72
	.byte $73, $FF, $FF, $FF

; -----------------------------------------------------------------------------

rom_876F:
	.byte $07, $09, $10, $02, $00, $FF, $FF, $FF
	.byte $81, $82, $FF, $FF, $FF, $FF, $85, $86
	.byte $87, $88, $89, $FF, $96, $97, $98, $99
	.byte $9A, $9B, $FF, $A9, $AA, $AB, $FF, $FF
	.byte $FF, $FF, $B8, $B9, $BA, $FF, $FF, $FF
	.byte $FF, $C8, $C9, $CA, $FF, $FF, $FF, $D4
	.byte $D5, $D6, $D7, $FF, $FF, $FF, $DE, $DF
	.byte $FF, $E0, $FF, $FF, $FF, $E7, $FF, $FF
	.byte $E8, $FF, $FF, $FF

; -----------------------------------------------------------------------------

rom_87B3:
	.byte $05, $06, $10, $0C, $00, $FF, $1D, $1E
	.byte $FF, $FF, $04, $2A, $2B, $FF, $FF, $3B
	.byte $3C, $3D, $3E, $FF, $4D, $4E, $4F, $50
	.byte $51, $61, $62, $63, $FF, $FF, $FF, $70
	.byte $71, $FF, $FF

; -----------------------------------------------------------------------------

rom_87D6:
	.byte $04, $07, $10, $0A, $00, $FF, $FF, $8E
	.byte $8F, $FF, $98, $99, $9A, $A2, $A3, $A4
	.byte $A5, $AD, $AE, $AF, $B0, $FF, $B7, $B8
	.byte $B9, $BF, $C0, $C1, $C2, $C9, $CA, $CB
	.byte $CC

; -----------------------------------------------------------------------------

rom_87F7:
	.byte $04, $0A, $10, $0A, $00, $FF, $80, $81
	.byte $FF, $FF, $82, $83, $84, $FF, $87, $88
	.byte $89, $90, $91, $92, $FF, $9B, $9C, $9D
	.byte $FF, $A6, $A7, $A8, $A9, $B1, $B2, $B3
	.byte $FF, $FF, $BA, $BB, $FF, $C3, $C4, $C5
	.byte $FF, $CD, $CE, $CF, $FF

; -----------------------------------------------------------------------------

rom_8824:
	.byte $06, $09, $14, $0A, $00, $FF, $FF, $FF
	.byte $85, $FF, $86, $FF, $FF, $8A, $8B, $8C
	.byte $8D, $93, $94, $95, $96, $97, $FF, $9E
	.byte $9F, $A0, $A1, $FF, $FF, $FF, $FF, $AA
	.byte $AB, $AC, $FF, $FF, $FF, $B4, $B5, $B6
	.byte $FF, $FF, $FF, $BC, $BD, $BE, $FF, $FF
	.byte $FF, $C6, $C7, $C8, $FF, $FF, $D0, $D1
	.byte $D2, $D3, $FF

; -----------------------------------------------------------------------------

rom_885F:
	.byte $06, $07, $10, $0E, $00, $FF, $FF, $FF
	.byte $FF, $E7, $E8, $FF, $FF, $FF, $E9, $EA
	.byte $FF, $EB, $EC, $ED, $EE, $FF, $FF, $EF
	.byte $F0, $F1, $F2, $FF, $FF, $F3, $F4, $F5
	.byte $F6, $FF, $FF, $F7, $F8, $F9, $FA, $FF
	.byte $FF, $FB, $FC, $FD, $FF, $FF, $FF

; -----------------------------------------------------------------------------

rom_888E:
	.byte $07, $09, $10, $10, $00, $FF, $FF, $08
	.byte $09, $FF, $FF, $FF, $FF, $12, $13, $14
	.byte $FF, $FF, $FF, $21, $22, $23, $24, $25
	.byte $FF, $FF, $FF, $31, $32, $33, $34, $FF
	.byte $FF, $FF, $FF, $FF, $42, $43, $FF, $FF
	.byte $FF, $FF, $4D, $4E, $4F, $50, $FF, $FF
	.byte $FF, $5C, $5D, $5E, $5F, $FF, $FF, $FF
	.byte $6B, $6C, $FF, $6D, $6E, $FF, $FF, $75
	.byte $76, $FF, $FF, $77

; -----------------------------------------------------------------------------

rom_88D2:
	.byte $05, $0A, $10, $12, $00, $FF, $80, $FF
	.byte $81, $FF, $FF, $82, $83, $84, $FF, $FF
	.byte $85, $86, $87, $88, $FF, $89, $8A, $8B
	.byte $FF, $FF, $8E, $8F, $90, $FF, $FF, $94
	.byte $95, $96, $FF, $FF, $9B, $9C, $9D, $9E
	.byte $FF, $A4, $A5, $A6, $A7, $AD, $AE, $AF
	.byte $FF, $B0, $B6, $FF, $FF, $FF, $B7

; -----------------------------------------------------------------------------

rom_8909:
	.byte $07, $07, $10, $12, $00, $FF, $FF, $FF
	.byte $FF, $8C, $8D, $FF, $FF, $FF, $FF, $91
	.byte $92, $93, $FF, $FF, $FF, $97, $98, $99
	.byte $9A, $FF, $FF, $FF, $9F, $A0, $A1, $A2
	.byte $A3, $FF, $FF, $A8, $A9, $AA, $AB, $AC
	.byte $B1, $B2, $B3, $B4, $B5, $FF, $FF, $B8
	.byte $B9, $BA, $FF, $BB, $FF, $FF

; -----------------------------------------------------------------------------

rom_893F:
	.byte $05, $07, $10, $0E, $00, $FF, $82, $FF
	.byte $FF, $FF, $87, $88, $89, $FF, $FF, $8F
	.byte $90, $91, $FF, $FF, $9B, $9C, $9D, $9E
	.byte $FF, $A9, $AA, $AB, $AC, $FF, $B9, $BA
	.byte $BB, $BC, $A4, $FF, $FF, $C8, $C9, $FF

; -----------------------------------------------------------------------------

rom_8967:
	.byte $08, $06, $10, $0E, $00, $FF, $8A, $8B
	.byte $FF, $FF, $FF, $FF, $FF, $92, $93, $94
	.byte $95, $96, $FF, $FF, $FF, $9F, $A0, $A1
	.byte $A2, $A3, $A4, $FF, $FF, $FF, $AD, $AE
	.byte $AF, $B0, $B1, $B2, $B3, $FF, $BD, $BE
	.byte $BF, $C0, $C1, $C2, $C3, $FF, $FF, $CA
	.byte $CB, $CC, $FF, $FF, $FF

; -----------------------------------------------------------------------------

rom_899C:
	.byte $06, $09, $10, $02, $00, $FF, $FF, $FF
	.byte $81, $82, $FF, $FF, $FF, $85, $86, $8A
	.byte $8B, $FF, $96, $97, $98, $9C, $9D, $FF
	.byte $A9, $AA, $AB, $FF, $FF, $FF, $B8, $B9
	.byte $BA, $FF, $FF, $FF, $C8, $C9, $CA, $FF
	.byte $FF, $D4, $D5, $D6, $D7, $FF, $FF, $DE
	.byte $DF, $FF, $E0, $FF, $FF, $E7, $FF, $FF
	.byte $E8, $FF, $FF

; -----------------------------------------------------------------------------

rom_89D7:
	.byte $04, $08, $10, $14, $00, $FF, $FF, $FF
	.byte $03, $FF, $0B, $0C, $0D, $19, $1A, $1B
	.byte $1C, $2B, $2C, $2D, $FF, $39, $3A, $3B
	.byte $FF, $45, $46, $47, $FF, $55, $56, $57
	.byte $FF, $68, $69, $FF, $FF

; -----------------------------------------------------------------------------

rom_89FC:
	.byte $05, $07, $10, $14, $00, $FF, $FF, $FF
	.byte $0E, $0F, $FF, $FF, $1D, $1E, $1F, $2E
	.byte $FF, $2F, $30, $16, $3C, $3D, $3E, $3F
	.byte $40, $FF, $48, $49, $4A, $4B, $FF, $1D
	.byte $58, $59, $5A, $FF, $6A, $6B, $6C, $6D

; -----------------------------------------------------------------------------

rom_8A24:
	.byte $06, $05, $10, $14, $00, $01, $02, $FF
	.byte $FF, $FF, $FF, $04, $05, $06, $07, $08
	.byte $FF, $10, $11, $12, $13, $14, $15, $20
	.byte $21, $22, $23, $24, $25, $31, $32, $33
	.byte $34, $FF, $35

; -----------------------------------------------------------------------------

rom_8A47:
	.byte $06, $05, $10, $12, $00, $D0, $D1, $FF
	.byte $FF, $FF, $D2, $D3, $D4, $FF, $FF, $D5
	.byte $D6, $D7, $D8, $D9, $DA, $DB, $DC, $DD
	.byte $DE, $DF, $E0, $E1, $FF, $E2, $E3, $E4
	.byte $E5, $E6, $E7

; -----------------------------------------------------------------------------

rom_8A6A:
	.byte $06, $04, $10, $12, $00, $FF, $BC, $BD
	.byte $BE, $BF, $FF, $C0, $C1, $C2, $C3, $C4
	.byte $C5, $FF, $C6, $C7, $C8, $C9, $CA, $CB
	.byte $CC, $CD, $FF, $CE, $CF

; -----------------------------------------------------------------------------

rom_8A87:
	.byte $04, $05, $10, $16, $00, $A6, $A7, $A8
	.byte $A9, $B1, $B2, $B3, $B4, $BC, $BD, $BE
	.byte $BF, $C6, $C7, $C8, $C9, $FF, $D0, $D1
	.byte $FF

; -----------------------------------------------------------------------------

rom_8AA0:
	.byte $04, $08, $10, $16, $00, $85, $86, $87
	.byte $FF, $90, $91, $92, $93, $9B, $91, $9C
	.byte $9D, $A1, $91, $A2, $FF, $AA, $AB, $AC
	.byte $AD, $B5, $B6, $B7, $B8, $C0, $C1, $C2
	.byte $C3, $CA, $FF, $CB, $CC

; -----------------------------------------------------------------------------

rom_8AC5:
	.byte $04, $09, $10, $16, $00, $FF, $80, $81
	.byte $FF, $88, $89, $8A, $8B, $94, $91, $95
	.byte $96, $9B, $91, $9C, $9D, $A1, $91, $A2
	.byte $FF, $AA, $AB, $AC, $AD, $B5, $B6, $B7
	.byte $B8, $C0, $C1, $C2, $C3, $CA, $FF, $CB
	.byte $CC

; -----------------------------------------------------------------------------

rom_8AEE:
	.byte $04, $09, $10, $16, $00, $D2, $D3, $FF
	.byte $FF, $D4, $D5, $FF, $FF, $D6, $D7, $D8
	.byte $FF, $D9, $DA, $DB, $FF, $FF, $DC, $DD
	.byte $FF, $FF, $DE, $DF, $E0, $FF, $E1, $E2
	.byte $E3, $FF, $E4, $E5, $E6, $FF, $E7, $E8
	.byte $E9

; -----------------------------------------------------------------------------

rom_8B17:
	.byte $03, $09, $08, $18, $00, $FF, $01, $02
	.byte $09, $0A, $0B, $16, $17, $18, $25, $26
	.byte $27, $34, $35, $36, $3F, $40, $41, $4D
	.byte $4E, $4F, $5B, $5C, $5D, $68, $69, $6A

; -----------------------------------------------------------------------------

rom_8B37:
	.byte $04, $09, $10, $0C, $00, $FF, $01, $02
	.byte $03, $FF, $06, $07, $08, $0D, $0E, $0F
	.byte $10, $16, $17, $18, $19, $FF, $23, $24
	.byte $25, $30, $31, $32, $33, $43, $44, $45
	.byte $46, $56, $57, $58, $59, $68, $FF, $FF
	.byte $69

; -----------------------------------------------------------------------------

rom_8B60:
	.byte $04, $09, $10, $18, $00, $FF, $06, $07
	.byte $08, $12, $13, $14, $15, $21, $22, $23
	.byte $24, $31, $32, $33, $FF, $3C, $3D, $3E
	.byte $FF, $49, $4A, $4B, $4C, $57, $58, $59
	.byte $5A, $65, $FF, $66, $67, $70, $FF, $FF
	.byte $71

; -----------------------------------------------------------------------------

rom_8B89:
	.byte $04, $0B, $10, $1A, $00, $80, $81, $FF
	.byte $82, $83, $84, $85, $86, $87, $88, $89
	.byte $8A, $FF, $8B, $8C, $FF, $FF, $8D, $8E
	.byte $FF, $FF, $8F, $90, $FF, $FF, $91, $92
	.byte $FF, $FF, $93, $94, $95, $96, $97, $98
	.byte $99, $9A, $9B, $9C, $9D, $9E, $FF, $FF
	.byte $9F

; -----------------------------------------------------------------------------

rom_8BBA:
	.byte $05, $08, $10, $0E, $00, $FF, $80, $81
	.byte $FF, $FF, $83, $84, $85, $86, $FF, $8C
	.byte $8D, $8E, $FF, $FF, $97, $98, $99, $9A
	.byte $FF, $A5, $A6, $A7, $A8, $FF, $B4, $B5
	.byte $B6, $B7, $B8, $C4, $C5, $FF, $C6, $C7
	.byte $CD, $CE, $FF, $FF, $CF

; -----------------------------------------------------------------------------

rom_8BE7:
	.byte $0A, $03, $10, $0E, $00, $FF, $FF, $FF
	.byte $FF, $FF, $D0, $D1, $D2, $FF, $FF, $D3
	.byte $D4, $D5, $D6, $D7, $D8, $D9, $DA, $DB
	.byte $DC, $DD, $DE, $DF, $E0, $E1, $E2, $E3
	.byte $E4, $E5, $E6

; -----------------------------------------------------------------------------

rom_8C0A:
	.byte $05, $09, $10, $08, $00, $07, $08, $FF
	.byte $FF, $FF, $11, $12, $FF, $FF, $FF, $1B
	.byte $1C, $1D, $1E, $FF, $26, $27, $28, $29
	.byte $FF, $FF, $36, $37, $38, $FF, $FF, $47
	.byte $48, $49, $4A, $FF, $5A, $56, $FF, $FF
	.byte $FF, $6B, $0F, $FF, $FF, $FF, $7A, $7B
	.byte $FF, $FF

; -----------------------------------------------------------------------------

rom_8C3C:
	.byte $04, $09, $10, $18, $00, $FF, $03, $04
	.byte $FF, $FF, $0C, $0D, $FF, $19, $1A, $1B
	.byte $1C, $28, $29, $2A, $2B, $37, $38, $39
	.byte $FF, $42, $43, $44, $45, $50, $51, $52
	.byte $53, $5E, $5F, $FF, $60, $6B, $FF, $FF
	.byte $6C

; -----------------------------------------------------------------------------

rom_8C65:
	.byte $05, $09, $10, $18, $00, $FF, $05, $FF
	.byte $FF, $FF, $0E, $0F, $10, $11, $FF, $1D
	.byte $1E, $1F, $20, $FF, $2C, $2D, $2E, $2F
	.byte $30, $FF, $3A, $3B, $FF, $FF, $FF, $46
	.byte $47, $48, $FF, $FF, $54, $55, $56, $FF
	.byte $61, $62, $63, $64, $FF, $6E, $6F, $FF
	.byte $6C, $6D

; -----------------------------------------------------------------------------

rom_8C97:
	.byte $04, $07, $10, $04, $00, $12, $13, $14
	.byte $15, $23, $24, $25, $26, $32, $33, $34
	.byte $35, $41, $42, $43, $44, $FF, $4F, $50
	.byte $51, $5B, $5C, $5D, $5E, $67, $FF, $FF
	.byte $68

; -----------------------------------------------------------------------------

rom_8CB8:
	.byte $06, $0A, $10, $04, $00, $FF, $FF, $FF
	.byte $FF, $FF, $01, $FF, $FF, $FF, $02, $03
	.byte $04, $FF, $0A, $0B, $0C, $0D, $FF, $16
	.byte $17, $18, $19, $1A, $FF, $27, $28, $29
	.byte $2A, $FF, $FF, $36, $37, $38, $39, $FF
	.byte $FF, $45, $46, $47, $48, $FF, $FF, $FF
	.byte $FF, $52, $53, $FF, $FF, $FF, $FF, $5F
	.byte $60, $FF, $FF, $FF, $FF, $69, $6A, $FF
	.byte $FF

; -----------------------------------------------------------------------------

rom_8CF9:
	.byte $03, $09, $10, $04, $00, $05, $06, $FF
	.byte $0E, $0F, $10, $1B, $1C, $1D, $2B, $2C
	.byte $2D, $3A, $3B, $3C, $49, $4A, $4B, $54
	.byte $55, $56, $FF, $61, $62, $FF, $6B, $6C

; -----------------------------------------------------------------------------

rom_8D19:
	.byte $05, $09, $10, $0A, $40, $FF, $FF, $FF
	.byte $D5, $D4, $FF, $D8, $FF, $D7, $D6, $FF
	.byte $DC, $DB, $DA, $D9, $FF, $E0, $DF, $DE
	.byte $DD, $FF, $E4, $E3, $E2, $E1, $FF, $E7
	.byte $E6, $E5, $FF, $EB, $EA, $E9, $E8, $FF
	.byte $EF, $EE, $ED, $EC, $FF, $F2, $F1, $FF
	.byte $F0, $FF

; -----------------------------------------------------------------------------

rom_8D4B:
	.byte $04, $08, $10, $14, $00, $FF, $FF, $FF
	.byte $03, $FF, $0B, $0C, $0D, $19, $1A, $1B
	.byte $1C, $2B, $2C, $2D, $FF, $39, $3A, $3B
	.byte $FF, $45, $46, $47, $FF, $55, $56, $57
	.byte $FF, $68, $69, $FF, $FF

; -----------------------------------------------------------------------------

rom_8D70:
	.byte $06, $06, $10, $14, $C0, $35, $FF, $34
	.byte $33, $32, $31, $25, $24, $23, $22, $21
	.byte $20, $15, $14, $13, $12, $11, $10, $FF
	.byte $08, $07, $06, $05, $04, $FF, $FF, $FF
	.byte $FF, $02, $01, $FF, $FF, $FF, $FF, $FF
	.byte $FF

; -----------------------------------------------------------------------------

; The rest of this bank (up to $8FFF) is probably rubbish
