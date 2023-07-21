.segment "BANK_07"
; $8000-$9FFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"


; -----------------------------------------------------------------------------

; Data pointers for Sub-Zero
rom_07_8000:
	.word rom_8004, rom_82C7

; -----------------------------------------------------------------------------

rom_8004:
	.byte $09			; $00 = idle
    .word anim_subzero_idle
    .byte $06			; $01 = crouching
    .word rom_80A9
    .byte $08			; $02 = crouching parry
	.word rom_80AD
	.byte $01			; $03 = walking forward
	.word rom_80B5
	.byte $03			; $04 = walking backwards
	.word rom_80BF
	.byte $08			; $05 = parrying
	.word rom_80C9
	.byte $02			; $06 = jumping up
	.word rom_80D1
	.byte $05			; $07 = jumping forward
	.word rom_80DD
	.byte $04			; $08 = jumping backwards
	.word rom_80ED
	.byte $07			; $09 = strong hit? hit by flying kick? (still shoved backwards)
	.word rom_80FD
	.byte $07			; $0A = regular hit (shoved backwards)
	.word rom_8105
	; Attack animations
	.byte $08			; $0B = base kick
	.word rom_810D
	.byte $0A			; $0C = close/combo kick
	.word rom_8113
	.byte $1D			; $0D
	.word rom_8117
	.byte $02			; $0E = jumping kick (straight up)
	.word rom_8137
	.byte $02			; $0F
	.word rom_8143
	.byte $00			; $10 = base punch
	.word rom_814F
	.byte $02			; $11 = jumping up punch
	.word rom_8157
	.byte $02			; $12
	.word rom_8163
	.byte $00			; $13 = uppercut
	.word rom_816F
	.byte $0A			; $14 = crouching kick
	.word rom_8177
	.byte $05			; $15
	.word rom_817B
	.byte $02			; $16 = jumping up punch
	.word rom_817C
	.byte $2C			; $17
	.word rom_817D
	.byte $2A			; $18 = throw move
	.word rom_818D
	.byte $05			; $19 = jumping forward punch
	.word rom_8199
	.byte $05			; $1A
	.word rom_81A9
	.byte $05			; $1B = jumping forward kick
	.word rom_81B9
	.byte $05			; $1C
	.word rom_81C9
	.byte $05			; $1D
	.word rom_81D9
	.byte $18			; $1E = ranged attack
	.word anim_ranged_attack
	.byte $04			; $1F = jumping backwards punch
	.word rom_81F8
	.byte $04			; $20
	.word rom_8208
	.byte $04			; $21 = jumping backwards kick
	.word rom_8218
	.byte $04			; $22
	.word rom_8228
	.byte $04			; $23
	.word rom_8238
	.byte $04			; $24
	.word rom_8239
	.byte $06			; $25 = quick standing punch? (only up close)

	.word rom_823A
	.byte $0E			; $26 = falling on his back (bounce)
	.word rom_823B
	.byte $08			; $27 = getting up
	.word rom_8248
	.byte $18			; $28 = staggered
	.word anim_subzero_staggered
	
	.byte $08			; $29 = "shame" pose
	.word rom_8262
	.byte $08			; $2A = victory pose
	.word rom_8268

	; More hit animations
	.byte $07			; $2B = crouching parried hit
	.word rom_80AD
	.byte $07			; $2C = standing parried hit
	.word rom_80C9
	.byte $0F			; $2D = quick knockback
	.word rom_8270
	.byte $0D			; $2E = strong hit (knocked down or hit in the air)
	.word rom_8271
	.byte $14			; $2F = bigger knockback
	.word rom_8286
	.byte $0D			; $30 = another knockback
	.word rom_8271
	.byte $29			; $31 = being thrown
	.word rom_8286
	.byte $19			; $32 = hit by uppercut
	.word rom_8271 ;rom_8292
	.byte $18 ;$1F		; $33 = special hit (spear/freeze)
	.word anim_special_hit ;rom_82A1
	.byte $04			; $34 = Jumping back (start at frame $0A for the downward movement part)
	.word rom_80ED

; -----------------------------------------------------------------------------

; Indices for a pointer in the second table below
anim_subzero_idle:
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
	.byte $35, $35, $36, $36
    ; Potentially unused portion
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
	.byte $1B, $1B
    ; Potentially unused portion
	.byte $02, $02
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
anim_ranged_attack:
	.byte $32, $32, $32, $32, $33, $33, $33, $33
	.byte $33, $33, $33, $33, $33, $33, $33, $33
	.byte $33, $33, $33, $33, $33, $33, $33, $33
	.byte $33, $33
    ; Potentially unused portion
	.byte $33, $33, $33, $33
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
	.byte $26, $26, $26, $26
    ; Potentially unused portion
	.byte $26
rom_8248:
	.byte $27, $27, $28, $28, $29, $29
anim_subzero_staggered:
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
	.byte $37, $37, $24, $24, $24, $24
    ; Portion used when landing after mid-air hit?
	.byte $24, $24, $24, $24, $24, $00, $00
rom_8286:
	.byte $38, $38, $38
    ; Potentially unused portion
	.byte $39, $39, $39, $3A, $3A, $23, $23, $23
	.byte $23
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
	.word subzero_frame_00, rom_83C3, rom_83EC, rom_8405
	.word rom_8422, rom_844F, rom_847C, rom_84A5
	.word rom_84CE, rom_84F7, rom_8520, rom_854D
	.word rom_857A, rom_858E, rom_85A2, rom_85D4
	.word rom_8609, rom_8646, rom_8678, rom_86AA
	.word rom_86D9, rom_8714, rom_873D, rom_8778
	.word rom_87A5, rom_87CA, rom_87FB, rom_883C
	.word rom_886B, rom_88A6, rom_88BB, rom_88F1
	.word rom_890E, rom_8944, rom_8976, rom_89A3
	.word rom_89BC, rom_89E5, rom_89FE, rom_8A17
	.word rom_8A2B, rom_8A40, rom_8A63, rom_8A8C
	.word rom_8AB5, rom_8ADE, rom_8B0B, rom_8B3C
	.word rom_8B69, rom_8B98, rom_8BCA, rom_8BF3
	.word rom_8C20, rom_8C45, rom_8C86, rom_8CB7
	.word rom_8CD4, rom_8D06, rom_8D33, subzero_frame_00
	.word subzero_frame_00, subzero_frame_00, subzero_frame_00, subzero_frame_00
	.word subzero_frame_00, subzero_frame_00, subzero_frame_00, subzero_frame_00
	.word subzero_frame_00, subzero_frame_00, subzero_frame_00, subzero_frame_00
	.word subzero_frame_00, subzero_frame_00, subzero_frame_00, subzero_frame_00
	.word subzero_frame_00, subzero_frame_00, subzero_frame_00, subzero_frame_00
	.word subzero_frame_00, subzero_frame_00, subzero_frame_00, subzero_frame_00
	.word subzero_frame_00, subzero_frame_00, subzero_frame_00, subzero_frame_00
	.word subzero_frame_00, subzero_frame_00, subzero_frame_00, subzero_frame_00
	.word subzero_frame_00, subzero_frame_00, subzero_frame_00, subzero_frame_00
	.word subzero_frame_00, subzero_frame_00, subzero_frame_00, subzero_frame_00
	.word subzero_frame_00

; -----------------------------------------------------------------------------

; Idle animation, frame 0
subzero_frame_00:
	.byte $05	; Horizontal tiles count
	.byte $09	; Vertical tiles count
	.byte $10	; X offset (8 = neutral, higher = move forward, lower = backwards)
	.byte $58	; CHR bank number
	.byte $00	; Sprite attributes OR mask (e.g. force flip / priority / palette)
	; So we have 5 columns x 9 rows composing our meta-sprite
	; $FF = no sprite to display on that position
	.byte $FF, $FF, $01, $02, $FF	; This is the top of the head
	.byte $05, $06, $07, $08, $FF
	.byte $0F, $10, $11, $12, $FF
	.byte $FF, $1C, $1D, $1E, $FF
	.byte $FF, $2A, $2B, $2C, $FF
	.byte $FF, $37, $38, $39, $FF
	.byte $FF, $47, $48, $49, $FF
	.byte $FF, $57, $FF, $58, $FF
	.byte $FF, $65, $FF, $66, $67	; These are the feet

; Idle animation, frame 1
rom_83C3:
	.byte $04, $09, $08, $58, $00
	.byte $FF, $03, $04, $FF
	.byte $09, $0A, $0B, $0C
	.byte $13, $14, $15, $16
	.byte $1F, $20, $21, $22
	.byte $FF, $2D, $2E, $2F
	.byte $3A, $3B, $3C, $FF
	.byte $4A, $4B, $4C, $0C
	.byte $59, $5A, $5B, $5C
	.byte $68, $FF, $69, $6A

rom_83EC:
	.byte $04, $05, $10, $5C, $00
	.byte $6C, $6D, $6E, $6F
	.byte $70, $71, $72, $73
	.byte $74, $75, $76, $77
	.byte $78, $79, $7A, $7B
	.byte $7C, $FF, $7D, $7E
rom_8405:
	.byte $04, $06, $10, $5E, $00
	.byte $82, $83, $84, $FF
	.byte $8B, $8C, $8D, $8E
	.byte $98, $99, $9A, $9B
	.byte $A4, $A5, $A6, $A7
	.byte $B1, $B2, $B3, $B4
	.byte $BD, $92, $BE, $BF
rom_8422:
	.byte $04, $0A, $10, $5C, $00
	.byte $FF, $01, $02
	.byte $FF, $FF, $05, $06, $FF, $0B, $0C, $0D
	.byte $FF, $14, $15, $16, $04, $1D, $1E, $1F
	.byte $20, $29, $2A, $2B, $2C, $37, $38, $39
	.byte $FF, $44, $45, $46, $FF, $51, $52, $53
	.byte $FF, $5F, $FF, $60, $FF
rom_844F:
	.byte $04, $0A, $10, $5C, $00, $FF, $03, $04
	.byte $FF, $FF, $07, $08, $FF, $0E, $0F, $10
	.byte $FF, $17, $18, $19, $FF, $21, $22, $23
	.byte $24, $FF, $2D, $2E, $2F, $FF, $3A, $3B
	.byte $FF, $47, $48, $49, $FF, $54, $55, $56
	.byte $FF, $61, $62, $63, $FF
rom_847C:
	.byte $04, $09, $10, $5C, $00, $FF, $09, $0A
	.byte $FF, $11, $12, $13, $FF, $1A, $1B, $1C
	.byte $FF, $25, $26, $27, $28, $FF, $30, $31
	.byte $32, $FF, $3C, $3D, $3E, $FF, $4A, $4B
	.byte $FF, $FF, $57, $58, $FF, $FF, $64, $65
	.byte $66
rom_84A5:
	.byte $04, $09, $10, $5C, $00, $FF, $09, $0A
	.byte $FF, $11, $12, $13, $FF, $1A, $1B, $1C
	.byte $FF, $25, $26, $27, $28, $FF, $33, $34
	.byte $32, $FF, $3F, $40, $FF, $FF, $4C, $46
	.byte $4D, $FF, $59, $5A, $FF, $FF, $67, $68
	.byte $FF
rom_84CE:
	.byte $04, $09, $10, $5C, $00, $FF, $09, $0A
	.byte $FF, $11, $12, $13, $FF, $1A, $1B, $1C
	.byte $FF, $25, $26, $27, $28, $FF, $35, $36
	.byte $32, $41, $42, $43, $04, $41, $4E, $4F
	.byte $50, $5B, $5C, $5D, $5E, $69, $6A, $FF
	.byte $6B
rom_84F7:
	.byte $04, $09, $10, $5E, $00, $DE, $DF, $E0
	.byte $FF, $E1, $E2, $E3, $FF, $E4, $E5, $E6
	.byte $FF, $E7, $E8, $E9, $FF, $EA, $EB, $EC
	.byte $FF, $ED, $EE, $EF, $FF, $F0, $F1, $F2
	.byte $FF, $F3, $F4, $F5, $FF, $F6, $FF, $F7
	.byte $F8
rom_8520:
	.byte $05, $08, $10, $58, $00, $FF, $FF, $0D
	.byte $0E, $FF, $FF, $17, $18, $19, $FF, $FF
	.byte $23, $24, $25, $26, $FF, $30, $31, $32
	.byte $33, $FF, $3D, $3E, $3F, $40, $4D, $4E
	.byte $4F, $50, $51, $5D, $5E, $5F, $60, $19
	.byte $FF, $FF, $FF, $6B, $FF
rom_854D:
	.byte $04, $0A, $10, $5E, $00, $FF, $C5, $C6
	.byte $FF, $C7, $C8, $C9, $FF, $CA, $CB, $CC
	.byte $FF, $CD, $CE, $CF, $D0, $D1, $D2, $D3
	.byte $FF, $D4, $D5, $FF, $FF, $D6, $D7, $FF
	.byte $FF, $D8, $D9, $FF, $FF, $DA, $DB, $FF
	.byte $FF, $DC, $DD, $FF, $FF
rom_857A:
	.byte $03, $05, $10, $58, $00, $6F, $70, $71
	.byte $72, $73, $74, $75, $76, $77, $78, $79
	.byte $7A, $FF, $7B, $7C
rom_858E:
	.byte $03, $05, $10, $58, $40, $71, $70, $6F
	.byte $74, $73, $72, $77, $76, $75, $7A, $79
	.byte $78, $7C, $7B, $FF
rom_85A2:
	.byte $05, $09, $10, $68, $00, $01, $02, $FF
	.byte $FF, $FF, $06, $07, $08, $FF, $FF, $0C
	.byte $0D, $0E, $FF, $FF, $16, $17, $18, $FF
	.byte $FF, $FF, $1E, $1F, $20, $FF, $FF, $2B
	.byte $2C, $2D, $FF, $3F, $40, $41, $42, $43
	.byte $57, $58, $FF, $59, $5A, $6E, $6F, $FF
	.byte $FF, $FF
rom_85D4:
	.byte $06, $08, $10, $62, $00, $FF, $C1, $C2
	.byte $FF, $FF, $FF, $C3, $C4, $C5, $FF, $FF
	.byte $FF, $C6, $C7, $C8, $C9, $CA, $CB, $CC
	.byte $CD, $CE, $CF, $D0, $D1, $D2, $D3, $D4
	.byte $D5, $FF, $FF, $FF, $D6, $D7, $FF, $FF
	.byte $FF, $FF, $FF, $D8, $FF, $FF, $FF, $FF
	.byte $D9, $DA, $FF, $FF, $FF
rom_8609:
	.byte $07, $08, $10, $62, $00, $FF, $FF, $FF
	.byte $FF, $DC, $DD, $DE, $DF, $E0, $FF, $E1
	.byte $E2, $E3, $FF, $E4, $E5, $E6, $E7, $E8
	.byte $FF, $FF, $E9, $EA, $EB, $EC, $FF, $FF
	.byte $FF, $ED, $EE, $EF, $F0, $FF, $FF, $FF
	.byte $FF, $FF, $F1, $F2, $FF, $FF, $FF, $FF
	.byte $FF, $F3, $FF, $FF, $FF, $FF, $FF, $F4
	.byte $F5, $FF, $FF, $FF, $FF
rom_8646:
	.byte $05, $08, $10, $58, $00, $FF, $FF, $0D
	.byte $0E, $FF, $FF, $17, $18, $19, $FF, $FF
	.byte $23, $24, $25, $26, $FF, $30, $31, $32
	.byte $33, $FF, $3D, $3E, $3F, $40, $4D, $4E
	.byte $4F, $50, $51, $5D, $5E, $5F, $60, $19
	.byte $FF, $FF, $FF, $6B, $FF, $07, $08, $10
	.byte $10, $00
rom_8678:
	.byte $05, $08, $10, $58, $00, $FF, $FF, $0D
	.byte $0E, $FF, $FF, $17, $18, $19, $FF, $FF
	.byte $23, $24, $25, $26, $FF, $30, $31, $32
	.byte $33, $FF, $3D, $3E, $3F, $40, $4D, $4E
	.byte $4F, $50, $51, $5D, $5E, $5F, $60, $19
	.byte $FF, $FF, $FF, $6B, $FF, $07, $08, $10
	.byte $10, $00
rom_86AA:
	.byte $06, $07, $10, $58, $00, $FF, $FF, $1A
	.byte $1B, $FF, $FF, $FF, $27, $28, $29, $FF
	.byte $FF, $FF, $34, $35, $36, $FF, $05, $FF
	.byte $41, $42, $43, $44, $45, $FF, $52, $53
	.byte $54, $55, $56, $61, $62, $63, $64, $FF
	.byte $FF, $6C, $6D, $6E, $FF, $FF, $FF
rom_86D9:
	.byte $06, $09, $10, $5A, $00, $FF, $FF, $80
	.byte $81, $FF, $FF, $FF, $87, $88, $89, $8A
	.byte $8B, $FF, $94, $95, $96, $97, $98, $FF
	.byte $A2, $A3, $A4, $FF, $FF, $FF, $AC, $AD
	.byte $FF, $FF, $FF, $FF, $B3, $B4, $FF, $FF
	.byte $FF, $BC, $BD, $BE, $FF, $FF, $FF, $C6
	.byte $C7, $C8, $FF, $FF, $FF, $CF, $FF, $D0
	.byte $D1, $FF, $FF
rom_8714:
	.byte $04, $09, $10, $5A, $00, $FF, $82, $83
	.byte $84, $FF, $8C, $8D, $8E, $FF, $99, $9A
	.byte $9B, $FF, $A5, $A6, $A7, $FF, $AE, $AF
	.byte $B0, $B5, $B6, $B7, $B8, $BF, $C0, $C1
	.byte $C2, $C9, $CA, $CB, $CC, $D2, $FF, $D3
	.byte $D1
rom_873D:
	.byte $06, $09, $10, $5A, $00, $FF, $FF, $85
	.byte $86, $FF, $FF, $F2, $8F, $90, $91, $92
	.byte $93, $9C, $9D, $9E, $9F, $A0, $A1, $FF
	.byte $A9, $AA, $AB, $FF, $FF, $FF, $B1, $B2
	.byte $FF, $FF, $FF, $B9, $BA, $BB, $FF, $FF
	.byte $FF, $C3, $C4, $C5, $FF, $FF, $FF, $CD
	.byte $CE, $CB, $FF, $FF, $FF, $D4, $FF, $D3
	.byte $D1, $FF, $FF
rom_8778:
	.byte $08, $05, $20, $66, $00, $FF, $FF, $FF
	.byte $CB, $CC, $CD, $FF, $FF, $FF, $FF, $FF
	.byte $CE, $CF, $D0, $FF, $FF, $FF, $FF, $D1
	.byte $D2, $D3, $D4, $D5, $FF, $FF, $D6, $D7
	.byte $D8, $D9, $DA, $DB, $DC, $DD, $DE, $DF
	.byte $E0, $E1, $E2, $FF, $FF
rom_87A5:
	.byte $04, $08, $10, $60, $00, $FF, $FF, $0E
	.byte $0F, $FF, $1B, $1C, $1D, $FF, $29, $2A
	.byte $2B, $FF, $36, $37, $38, $FF, $43, $44
	.byte $45, $4D, $4E, $4F, $50, $58, $59, $5A
	.byte $5B, $64, $FF, $65, $66
rom_87CA:
	.byte $04, $0B, $10, $60, $00, $FF, $01, $02
	.byte $FF, $FF, $04, $05, $06, $FF, $0A, $0B
	.byte $08, $15, $16, $17, $18, $22, $23, $24
	.byte $FF, $2F, $30, $31, $FF, $FF, $3C, $3D
	.byte $3E, $FF, $49, $4A, $FF, $54, $55, $56
	.byte $FF, $5F, $60, $61, $FF, $69, $FF, $6A
	.byte $6B
rom_87FB:
	.byte $06, $0A, $10, $60, $00, $FF, $FF, $03
	.byte $FF, $FF, $FF, $FF, $FF, $07, $08, $FF
	.byte $09, $FF, $10, $11, $12, $13, $14, $1E
	.byte $1F, $20, $21, $FF, $FF, $2C, $2D, $2E
	.byte $FF, $FF, $FF, $FF, $39, $3A, $3B, $FF
	.byte $FF, $FF, $46, $47, $48, $FF, $FF, $51
	.byte $52, $53, $FF, $FF, $FF, $5C, $5D, $5E
	.byte $FF, $FF, $FF, $67, $FF, $68, $FF, $FF
	.byte $FF
rom_883C:
	.byte $06, $07, $10, $5E, $00, $FF, $FF, $FF
	.byte $FF, $FF, $81, $FF, $FF, $FF, $FF, $85
	.byte $86, $FF, $FF, $8F, $90, $91, $92, $9C
	.byte $9D, $9E, $9F, $92, $FF, $A8, $A9, $AA
	.byte $AB, $AC, $FF, $B5, $B6, $B7, $B8, $B9
	.byte $FF, $C0, $C1, $C2, $C3, $C4, $FF
rom_886B:
	.byte $06, $09, $10, $66, $00, $FF, $FF, $80
	.byte $81, $FF, $FF, $82, $83, $84, $85, $FF
	.byte $FF, $86, $87, $88, $89, $FF, $FF, $FF
	.byte $FF, $8C, $8D, $FB, $FF, $FF, $FF, $8F
	.byte $90, $91, $FF, $FF, $FF, $99, $9A, $9B
	.byte $FF, $FF, $FF, $A4, $A5, $A6, $A7, $FF
	.byte $FF, $B3, $B4, $B5, $B6, $FF, $FF, $C0
	.byte $C1, $FF, $C2
rom_88A6:
	.byte $04, $04, $10, $66, $00, $9C, $9D, $9E
	.byte $9F, $A8, $A9, $AA, $AB, $B7, $B8, $B9
	.byte $BA, $C4, $C5, $C6, $C7
rom_88BB:
	.byte $07, $07, $10, $66, $00, $FF, $FF, $FF
	.byte $FF, $8A, $8B, $FF, $FF, $FF, $FF, $FC
	.byte $8E, $FF, $FF, $FF, $95, $96, $97, $98
	.byte $FF, $FF, $A0, $A1, $A2, $A3, $FF, $FF
	.byte $FF, $AC, $AD, $AE, $AF, $B0, $B1, $B2
	.byte $FF, $FF, $BB, $BC, $BD, $BE, $BF, $FF
	.byte $FF, $C8, $C9, $CA, $FF, $FF
rom_88F1:
	.byte $04, $06, $10, $6A, $00, $98, $99, $9A
	.byte $FF, $A5, $A6, $A7, $FF, $B1, $B2, $B3
	.byte $FF, $BF, $C0, $C1, $FF, $CD, $CE, $CF
	.byte $FF, $FF, $DA, $DB, $DC
rom_890E:
	.byte $07, $07, $10, $6A, $00, $FF, $92, $93
	.byte $FF, $FF, $FF, $FF, $9B, $9C, $9D, $9E
	.byte $FF, $FF, $FF, $A8, $A9, $AA, $AB, $FF
	.byte $FF, $FF, $B4, $B5, $B6, $B7, $B8, $FF
	.byte $FF, $FF, $C2, $C3, $C4, $C5, $C6, $FF
	.byte $FF, $FF, $D0, $D1, $D2, $D3, $D4, $FF
	.byte $FF, $DD, $DE, $DF, $FF, $FF
rom_8944:
	.byte $05, $09, $10, $5A, $00, $FF, $D5, $D6
	.byte $FF, $D7, $D8, $D9, $DA, $DB, $DC, $DD
	.byte $DE, $DF, $E0, $E1, $FF, $E2, $E3, $FF
	.byte $FF, $FF, $E4, $E5, $FF, $FF, $E6, $E7
	.byte $E8, $FF, $FF, $E9, $EA, $EB, $FF, $FF
	.byte $EC, $ED, $EE, $FF, $FF, $EF, $FF, $F0
	.byte $F1, $FF
rom_8976:
	.byte $05, $08, $10, $68, $00, $FF, $03, $04
	.byte $05, $FF, $FF, $09, $0A, $0B, $FF, $0F
	.byte $10, $11, $12, $13, $19, $1A, $1B, $FF
	.byte $FF, $21, $22, $23, $FF, $FF, $2E, $2F
	.byte $30, $FF, $FF, $44, $45, $FF, $FF, $FF
	.byte $5B, $5C, $5D, $FF, $FF
rom_89A3:
	.byte $05, $04, $10, $68, $00, $24, $FF, $25
	.byte $26, $27, $31, $32, $2B, $2B, $33, $46
	.byte $47, $48, $49, $4A, $FF, $5E, $5F, $60
	.byte $61
rom_89BC:
	.byte $06, $06, $10, $68, $00, $FF, $FF, $FF
	.byte $FF, $14, $15, $FF, $FF, $FF, $FF, $1C
	.byte $1D, $FF, $FF, $FF, $28, $29, $2A, $34
	.byte $35, $36, $37, $38, $FF, $4B, $4C, $4D
	.byte $4E, $FF, $FF, $62, $63, $64, $65, $FF
	.byte $FF
rom_89E5:
	.byte $05, $04, $10, $60, $00, $FF, $6E, $6F
	.byte $70, $FF, $71, $72, $73, $74, $75, $FF
	.byte $77, $78, $79, $7A, $FF, $7B, $7C, $7D
	.byte $7E
rom_89FE:
	.byte $05, $04, $10, $60, $00, $FF, $6E, $6F
	.byte $70, $FF, $71, $72, $73, $74, $75, $FF
	.byte $77, $78, $79, $7A, $FF, $7B, $7C, $7D
	.byte $7E
rom_8A17:
	.byte $03, $05, $10, $6C, $00, $20, $21, $22
	.byte $2F, $30, $31, $3F, $40, $41, $4F, $43
	.byte $50, $61, $43, $62
rom_8A2B:
	.byte $04, $04, $10, $6C, $00, $FF, $32, $33
	.byte $FF, $42, $43, $43, $44, $51, $52, $53
	.byte $54, $63, $64, $65, $66
rom_8A40:
	.byte $05, $06, $10, $6C, $00, $FF, $15, $16
	.byte $FF, $17, $FF, $23, $24, $25, $26, $FF
	.byte $34, $35, $36, $37, $45, $46, $43, $47
	.byte $FF, $55, $56, $57, $58, $59, $FF, $67
	.byte $68, $69, $FF
rom_8A63:
	.byte $04, $09, $10, $6A, $00, $E0, $E1, $FF
	.byte $FF, $E2, $E3, $E4, $FF, $E5, $E6, $E7
	.byte $FF, $E8, $E9, $EA, $FF, $EB, $EC, $ED
	.byte $FF, $EE, $EF, $F0, $FF, $F1, $F2, $F3
	.byte $F4, $F5, $F6, $F7, $F8, $F9, $FA, $FB
	.byte $FC
rom_8A8C:
	.byte $04, $09, $10, $6C, $00, $FF, $FF, $01
	.byte $02, $03, $04, $05, $06, $09, $0A, $0B
	.byte $0C, $11, $12, $13, $14, $1C, $1D, $1E
	.byte $1F, $2B, $2C, $2D, $2E, $3C, $3D, $3E
	.byte $FF, $4C, $4D, $4E, $FF, $5F, $FF, $60
	.byte $FF
rom_8AB5:
	.byte $04, $09, $10, $64, $00, $FF, $06, $07
	.byte $FF, $15, $16, $17, $18, $24, $25, $26
	.byte $27, $32, $33, $34, $35, $3E, $3F, $40
	.byte $FF, $49, $4A, $4B, $FF, $54, $55, $56
	.byte $57, $5E, $5F, $60, $61, $68, $FF, $69
	.byte $6A
rom_8ADE:
	.byte $04, $0A, $10, $6E, $00, $FF, $80, $81
	.byte $FF, $84, $85, $86, $FF, $8D, $8E, $8F
	.byte $90, $98, $99, $9A, $9B, $FF, $A4, $A5
	.byte $A6, $B1, $B2, $B3, $B4, $BF, $C0, $C1
	.byte $FF, $CD, $CE, $CF, $FF, $DD, $DE, $DF
	.byte $FF, $ED, $FF, $EE, $D8
rom_8B0B:
	.byte $04, $0B, $10, $70, $00, $01, $FF, $FF
	.byte $FF, $02, $03, $FF, $FF, $04, $05, $06
	.byte $FF, $07, $08, $09, $0A, $0B, $0C, $0D
	.byte $0E, $0F, $10, $11, $12, $13, $14, $15
	.byte $16, $17, $18, $19, $FF, $1A, $1B, $1C
	.byte $FF, $1D, $FF, $1E, $FF, $1F, $FF, $20
	.byte $FF
rom_8B3C:
	.byte $05, $08, $10, $6C, $00, $FF, $07, $08
	.byte $FF, $FF, $0D, $0E, $0F, $10, $FF, $18
	.byte $19, $1A, $1B, $FF, $27, $28, $29, $2A
	.byte $FF, $38, $39, $3A, $3B, $FF, $48, $49
	.byte $4A, $4B, $FF, $5A, $5B, $5C, $5D, $5E
	.byte $FF, $6A, $FF, $6B, $6C
rom_8B69:
	.byte $07, $06, $10, $6E, $00, $FF, $FF, $9C
	.byte $FF, $FF, $FF, $FF, $A7, $A8, $A9, $AA
	.byte $FF, $FF, $FF, $B5, $B6, $B7, $B8, $FF
	.byte $FF, $FF, $C2, $C3, $C4, $C5, $C6, $FF
	.byte $FF, $D0, $D1, $D2, $D3, $D4, $D5, $FF
	.byte $E0, $E1, $E2, $FF, $E3, $E4, $E5
rom_8B98:
	.byte $05, $09, $10, $60, $00, $0C, $0D, $FF
	.byte $FF, $FF, $19, $1A, $02, $FF, $FF, $25
	.byte $26, $27, $28, $FF, $32, $33, $34, $35
	.byte $FF, $FF, $3F, $40, $41, $42, $FF, $4B
	.byte $4C, $FF, $FF, $FF, $4B, $57, $FF, $FF
	.byte $FF, $62, $63, $FF, $FF, $FF, $6C, $6D
	.byte $FF, $FF
rom_8BCA:
	.byte $04, $09, $10, $6E, $00, $82, $83, $FF
	.byte $FF, $87, $88, $89, $FF, $91, $92, $93
	.byte $FF, $9D, $9E, $9F, $FF, $AB, $AC, $AD
	.byte $FF, $B9, $BA, $BB, $FF, $C7, $C8, $C9
	.byte $FF, $D6, $FF, $D7, $D8, $E6, $FF, $E7
	.byte $E8
rom_8BF3:
	.byte $05, $08, $10, $6E, $00, $FF, $8A, $8B
	.byte $FF, $8C, $FF, $94, $95, $96, $97, $FF
	.byte $A0, $A1, $A2, $A3, $FF, $AE, $AF, $B0
	.byte $FF, $FF, $BC, $BD, $BE, $FF, $FF, $CA
	.byte $CB, $CC, $FF, $D9, $DA, $DB, $DC, $FF
	.byte $E9, $EA, $EB, $EC, $FF
rom_8C20:
	.byte $04, $08, $10, $60, $00, $FF, $FF, $0E
	.byte $0F, $FF, $1B, $1C, $1D, $FF, $29, $2A
	.byte $2B, $FF, $36, $37, $38, $FF, $43, $44
	.byte $45, $4D, $4E, $4F, $50, $58, $59, $5A
	.byte $5B, $64, $FF, $65, $66
rom_8C45:
	.byte $06, $0A, $10, $60, $00, $FF, $FF, $03
	.byte $FF, $FF, $FF, $FF, $FF, $07, $08, $FF
	.byte $09, $FF, $10, $11, $12, $13, $14, $1E
	.byte $1F, $20, $21, $FF, $FF, $2C, $2D, $2E
	.byte $FF, $FF, $FF, $FF, $39, $3A, $3B, $FF
	.byte $FF, $FF, $46, $47, $48, $FF, $FF, $51
	.byte $52, $53, $FF, $FF, $FF, $5C, $5D, $5E
	.byte $FF, $FF, $FF, $67, $FF, $68, $FF, $FF
	.byte $FF
rom_8C86:
	.byte $04, $0B, $10, $60, $00, $FF, $01, $02
	.byte $FF, $FF, $04, $05, $06, $FF, $0A, $0B
	.byte $08, $15, $16, $17, $18, $22, $23, $24
	.byte $FF, $2F, $30, $31, $FF, $FF, $3C, $3D
	.byte $3E, $FF, $49, $4A, $FF, $54, $55, $56
	.byte $FF, $5F, $60, $61, $FF, $69, $FF, $6A
	.byte $6B
rom_8CB7:
	.byte $08, $03, $10, $68, $00, $39, $3A, $3B
	.byte $3C, $3D, $3E, $FF, $FF, $4F, $50, $51
	.byte $52, $53, $54, $55, $56, $66, $67, $68
	.byte $69, $6A, $6B, $6C, $6D
rom_8CD4:
	.byte $05, $09, $10, $68, $40, $FF, $FF, $FF
	.byte $02, $01, $FF, $FF, $08, $07, $06, $FF
	.byte $FF, $0E, $0D, $0C, $FF, $FF, $18, $17
	.byte $16, $FF, $20, $1F, $1E, $FF, $FF, $2D
	.byte $2C, $2B, $FF, $43, $42, $41, $40, $3F
	.byte $5A, $59, $FF, $58, $57, $FF, $FF, $FF
	.byte $6F, $6E
rom_8D06:
	.byte $05, $08, $10, $68, $00, $FF, $03, $04
	.byte $05, $FF, $FF, $09, $0A, $0B, $FF, $0F
	.byte $10, $11, $12, $13, $19, $1A, $1B, $FF
	.byte $FF, $21, $22, $23, $FF, $FF, $2E, $2F
	.byte $30, $FF, $FF, $44, $45, $FF, $FF, $FF
	.byte $5B, $5C, $5D, $FF, $FF
rom_8D33:
	.byte $06, $06, $10, $68, $C0, $FF, $FF, $65
	.byte $64, $63, $62, $FF, $FF, $4E, $4D, $4C
	.byte $4B, $FF, $38, $37, $36, $35, $34, $2A
	.byte $29, $28, $FF, $FF, $FF, $1D, $1C, $FF
	.byte $FF, $FF, $FF, $15, $14, $FF, $FF, $FF
	.byte $FF

; -----------------------------------------------------------------------------

; The rest seems to be half-overwritten junk
