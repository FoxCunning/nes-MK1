.segment "BANK_07t"
; $8000-$8FFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"

; -----------------------------------------------------------------------------

; Animation data for Sub-Zero

rom_8000:
	.word rom_8004, rom_82C7

; -----------------------------------------------------------------------------

rom_8004:
	.byte $09	; $00 Idle
	.word anim_idle
	.byte $06	; $01 Crouch
	.word anim_crouch
	.byte $08	; $02 Crouched parry
	.word anim_crouch_parry
	.byte $01	; $03 Walk forward
	.word anim_walk_fw
	.byte $03	; $04 Walk backwards
	.word anim_walk_bk
	.byte $08	; $05 Standing parry
	.word anim_standing_parry
	.byte $02	; $06 Jump up
	.word anim_jump_up
	.byte $05	; $07 Jump forward
	.word anim_jump_fw
	.byte $04	; $08 Jump backwards
	.word anim_jump_bk
	.byte $07	; $09 Strong hit
	.word anim_strong_hit
	.byte $07	; $0A Hit
	.word anim_regular_hit
	.byte $08	; $0B Kick
	.word anim_base_kick
	.byte $0A	; $0C Close kick
	.word anim_close_kick
	.byte $1D	; $0D Special #1
	.word anim_special_1
	.byte $02	; $0E Jump-kick (up) #1
	.word anim_jump_kick_1
	.byte $02	; $0F Jump-kick (up) #2
	.word anim_jump_kick_2
	.byte $00	; $10 Punch
	.word anim_base_punch
	.byte $02	; $11 Jump-punch (up) #1
	.word anim_jump_punch_1
	.byte $02	; $12 Jump-punch (up) #2
	.word anim_jump_punch_2
	.byte $00	; $13 Uppercut
	.word anim_uppercut
	.byte $0A	; $14 Crouched kick
	.word anim_crouch_kick
	.byte $05	; $15 Jump-kick (fwd) #1
	.word anim_fw_jump_kick_1
	.byte $02	; $16 Jump-punch (up) #3
	.word anim_jump_punch_3
	.byte $2C	; $17 Special #2
	.word anim_special_2
	.byte $2A	; $18 Throw
	.word anim_throw
	.byte $05	; $19 Jump-punch (fwd) #1
	.word anim_fw_jump_punch_1
	.byte $05	; $1A Jump-punch (fwd) #2
	.word anim_fw_jump_punch_2
	.byte $05	; $1B Jump-kick (fwd) #1
	.word anim_fw_jump_kick_2
	.byte $05	; $1C Jump-kick (fwd) #2
	.word anim_fw_jump_kick_3
	.byte $05	; $1D Jump-special
	.word anim_fw_jump_ranged
	.byte $18	; $1E Special #3
	.word anim_ranged_attack
	.byte $04	; $1F Jump-punch (bck) #1
	.word anim_bk_jump_punch_1
	.byte $04	; $20 Jump-punch (bck) #2
	.word anim_bk_jump_punch_2
	.byte $04	; $21 Jump-kick (bck) #1
	.word anim_bk_jump_kick_1
	.byte $04	; $22 Jump-kick (bck) #2
	.word anim_bk_jump_kick_2
	.byte $04	; $23 Mid-air fall back #1?
	.word anim_air_fall_back_1
	.byte $04	; $24 Mid-air fall back #2?
	.word anim_air_fall_back_2
	.byte $06	; $25 Close punch
	.word anim_close_punch
	.byte $0E	; $26 Bounce
	.word anim_fall_back_bounce
	.byte $08	; $27 Get up
	.word anim_get_up
	.byte $18	; $28 Stagger
	.word anim_staggered
	.byte $08	; $29 Shame
	.word anim_shame
	.byte $08	; $2A Victory
	.word anim_victory
	.byte $07	; $2B Crouched parry hit
	.word anim_crouch_parry_hit
	.byte $07	; $2C Standing parry hit
	.word anim_stand_parry_hit
	.byte $0F	; $2D Knock-back #1
	.word anim_knock_back_1
	.byte $0D	; $2E Strong hit
	.word anim_knock_back_2
	.byte $14	; $2F Knock-back #2
	.word anim_knock_back_3
	.byte $0D	; $30 Knock-back #3
	.word anim_knock_back_4
	.byte $29	; $31 Thrown
	.word anim_throw_fall
	.byte $19	; $32 Uppercut hit
	.word anim_uppercut_hit
	.byte $18	; $33 Special hit
	.word anim_special_hit
	.byte $04	; $34 Mid-air recovery
	.word anim_jump_bk_recover

; -----------------------------------------------------------------------------

; Indices for the frame pointers table
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
anim_special_hit:
	.byte $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E
	.byte $0E, $0E, $0E, $0E, $0E, $0E
anim_strong_hit:
	.byte $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E
anim_regular_hit:
	.byte $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E
anim_base_kick:
	.byte $0F, $0F, $10, $10, $0F, $0F
anim_close_kick:
	.byte $31, $31, $31, $31
anim_special_1:
	.byte $34, $34, $35, $35, $36, $36, $34, $34
	.byte $35, $35, $36, $36, $32, $32, $32, $32
	.byte $32, $33, $33, $33, $33, $33, $33, $33
	.byte $33, $33, $33, $33, $33, $33, $33, $33
anim_jump_kick_1:
	.byte $11, $11, $11, $12, $12, $13, $13, $13
	.byte $12, $12, $11, $11
anim_jump_kick_2:
	.byte $11, $11, $11, $11, $11, $12, $12, $12
	.byte $12, $13, $13, $13
anim_base_punch:
	.byte $14, $14, $15, $15, $14, $14, $16, $16
anim_jump_punch_1:
	.byte $0A, $0A, $0A, $0A, $0A, $17, $17, $17
	.byte $0A, $0A, $0A, $0A
anim_jump_punch_2:
	.byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A
	.byte $0A, $17, $17, $17
anim_uppercut:
	.byte $18, $18, $1A, $1A, $19, $19, $1A, $1A
anim_crouch_kick:
	.byte $1B, $1B, $02, $02
anim_fw_jump_kick_1:
	.byte $00
anim_jump_punch_3:
	.byte $00
anim_special_2:
	.byte $2F, $2F, $30, $30, $30, $30, $30, $30
	.byte $30, $30, $0C, $0C, $0D, $0D, $0C, $0C
anim_throw:
	.byte $1C, $1C, $1C, $1C, $1D, $1D, $1D, $1D
	.byte $1E, $1E, $1E, $1E
anim_fw_jump_punch_1:
	.byte $0B, $0B, $0B, $0B, $0C, $0C, $0D, $0D
	.byte $17, $17, $17, $17, $0B, $0B, $0B, $0B
anim_fw_jump_punch_2:
	.byte $0B, $0B, $0B, $0B, $0C, $0C, $0D, $0D
	.byte $0C, $0C, $0D, $0D, $17, $17, $17, $0B
anim_fw_jump_kick_2:
	.byte $0B, $0B, $0B, $0B, $1F, $1F, $20, $20
	.byte $20, $1F, $1F, $1F, $0B, $0B, $0B, $0B
anim_fw_jump_kick_3:
	.byte $0B, $0B, $0B, $0B, $0C, $0C, $0D, $0D
	.byte $1F, $1F, $20, $20, $20, $20, $1F, $0B
anim_fw_jump_ranged:
	.byte $00
anim_ranged_attack:
	.byte $32, $32, $32, $32, $33, $33, $33, $33
	.byte $33, $33, $33, $33, $33, $33, $33, $33
	.byte $33, $33, $33, $33, $33, $33, $33, $33
	.byte $33, $33, $33, $33, $33, $33
anim_bk_jump_punch_1:
	.byte $0B, $0B, $0B, $0B, $17, $17, $17, $17
	.byte $0C, $0C, $0D, $0D, $0B, $0B, $0B, $0B
anim_bk_jump_punch_2:
	.byte $17, $17, $17, $0B, $0C, $0C, $0D, $0D
	.byte $0C, $0C, $0D, $0D, $0B, $0B, $0B, $0B
anim_bk_jump_kick_1:
	.byte $0B, $0B, $0B, $0B, $1F, $1F, $20, $20
	.byte $20, $1F, $1F, $1F, $0B, $0B, $0B, $0B
anim_bk_jump_kick_2:
	.byte $0B, $0B, $0B, $0B, $0C, $0C, $0D, $0D
	.byte $1F, $1F, $20, $20, $20, $1F, $1F, $0B
anim_air_fall_back_1:
	.byte $00
anim_air_fall_back_2:
	.byte $00
anim_close_punch:
	.byte $21
anim_fall_back_bounce:
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
anim_crouch_parry_hit:
	.byte $03, $03, $03, $03, $03, $03, $03, $03
anim_stand_parry_hit:
	.byte $09, $09, $09, $09, $09, $09, $09, $09
anim_knock_back_1:
	.byte $37
anim_knock_back_2:
	.byte $22, $22, $22, $23, $23, $23, $24, $24
	.byte $37, $37, $24, $24, $24, $24, $24, $24
	.byte $24, $24, $24, $00, $00
anim_knock_back_3:
	.byte $38, $38, $38, $39, $39, $39, $3A, $3A
	.byte $23, $23, $23, $23
anim_knock_back_4:
	.byte $22, $22, $22, $23, $23, $23, $24, $24
	.byte $37, $37, $24, $24, $24, $24, $24, $24
	.byte $24, $24, $24, $00, $00
anim_throw_fall:
	.byte $38, $38, $38, $39, $39, $39, $3A, $3A
	.byte $23, $23, $23, $23
anim_uppercut_hit:
	.byte $22, $22, $22, $23, $23, $23, $24, $24
	.byte $37, $37, $24, $24, $24, $24, $24, $24
	.byte $24, $24, $24, $00, $00
anim_jump_bk_recover:
	.byte $0B, $0B, $0B, $0B, $0C, $0C, $0D, $0D
	.byte $0C, $0C, $0D, $0D, $0C, $0B, $0B, $0B
; -----------------------------------------------------------------------------

rom_82C7:
	.word frame_00
	.word frame_01
	.word frame_02
	.word frame_03
	.word frame_04
	.word frame_05
	.word frame_06
	.word frame_07
	.word frame_08
	.word frame_09
	.word frame_0A
	.word frame_0B
	.word frame_0C
	.word frame_0D
	.word frame_0E
	.word frame_0F
	.word frame_10
	.word frame_11
	.word frame_12
	.word frame_13
	.word frame_14
	.word frame_15
	.word frame_16
	.word frame_17
	.word frame_18
	.word frame_19
	.word frame_1A
	.word frame_1B
	.word frame_1C
	.word frame_1D
	.word frame_1E
	.word frame_1F
	.word frame_20
	.word frame_21
	.word frame_22
	.word frame_23
	.word frame_24
	.word frame_25
	.word frame_26
	.word frame_27
	.word frame_28
	.word frame_29
	.word frame_2A
	.word frame_2B
	.word frame_2C
	.word frame_2D
	.word frame_2E
	.word frame_2F
	.word frame_30
	.word frame_31
	.word frame_32
	.word frame_33
	.word frame_34
	.word frame_35
	.word frame_36
	.word frame_37
	.word frame_38
	.word frame_39
	.word frame_3A

; -----------------------------------------------------------------------------

; Frame data format example:
    ; .byte $05	; Horizontal tiles count
    ; .byte $09	; Vertical tiles count
    ; .byte $10	; X offset (8 = neutral, higher = move forward, lower = backwards)
    ; .byte $58	; CHR bank number
    ; .byte $00	; Sprite attributes OR mask (e.g. force flip / priority / palette)
    ; So we have 5 columns x 9 rows composing our meta-sprite
    ; $FF = no sprite to display on that position,
	; Otherwise it's a sprite index ($00-$7F or $80-$FE)
    ; .byte $FF, $FF, $01, $02, $FF	; This is the top of the head
    ; .byte $05, $06, $07, $08, $FF
    ; .byte $0F, $10, $11, $12, $FF
    ; .byte $FF, $1C, $1D, $1E, $FF
    ; .byte $FF, $2A, $2B, $2C, $FF
    ; .byte $FF, $37, $38, $39, $FF
    ; .byte $FF, $47, $48, $49, $FF
    ; .byte $FF, $57, $FF, $58, $FF
    ; .byte $FF, $65, $FF, $66, $67	; These are the feet

; -----------------------------------------------------------------------------

frame_00:
	.byte $05, $09, $10, $58, $00
	.byte $FF, $FF, $01, $02, $FF
	.byte $05, $06, $07, $08, $FF
	.byte $0F, $10, $11, $12, $FF
	.byte $FF, $1C, $1D, $1E, $FF
	.byte $FF, $2A, $2B, $2C, $FF
	.byte $FF, $37, $38, $39, $FF
	.byte $FF, $47, $48, $49, $FF
	.byte $FF, $57, $FF, $58, $FF
	.byte $FF, $65, $FF, $66, $67
frame_01:
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
frame_02:
	.byte $04, $05, $10, $5C, $00
	.byte $6C, $6D, $6E, $6F
	.byte $70, $71, $72, $73
	.byte $74, $75, $76, $77
	.byte $78, $79, $7A, $7B
	.byte $7C, $FF, $7D, $7E
frame_03:
	.byte $04, $06, $10, $5E, $00
	.byte $82, $83, $84, $FF
	.byte $8B, $8C, $8D, $8E
	.byte $98, $99, $9A, $9B
	.byte $A4, $A5, $A6, $A7
	.byte $B1, $B2, $B3, $B4
	.byte $BD, $92, $BE, $BF
frame_04:
	.byte $04, $0A, $10, $5C, $00
	.byte $FF, $01, $02, $FF
	.byte $FF, $05, $06, $FF
	.byte $0B, $0C, $0D, $FF
	.byte $14, $15, $16, $04
	.byte $1D, $1E, $1F, $20
	.byte $29, $2A, $2B, $2C
	.byte $37, $38, $39, $FF
	.byte $44, $45, $46, $FF
	.byte $51, $52, $53, $FF
	.byte $5F, $FF, $60, $FF
frame_05:
	.byte $04, $0A, $10, $5C, $00
	.byte $FF, $03, $04, $FF
	.byte $FF, $07, $08, $FF
	.byte $0E, $0F, $10, $FF
	.byte $17, $18, $19, $FF
	.byte $21, $22, $23, $24
	.byte $FF, $2D, $2E, $2F
	.byte $FF, $3A, $3B, $FF
	.byte $47, $48, $49, $FF
	.byte $54, $55, $56, $FF
	.byte $61, $62, $63, $FF
frame_06:
	.byte $04, $09, $10, $5C, $00
	.byte $FF, $09, $0A, $FF
	.byte $11, $12, $13, $FF
	.byte $1A, $1B, $1C, $FF
	.byte $25, $26, $27, $28
	.byte $FF, $30, $31, $32
	.byte $FF, $3C, $3D, $3E
	.byte $FF, $4A, $4B, $FF
	.byte $FF, $57, $58, $FF
	.byte $FF, $64, $65, $66
frame_07:
	.byte $04, $09, $10, $5C, $00
	.byte $FF, $09, $0A, $FF
	.byte $11, $12, $13, $FF
	.byte $1A, $1B, $1C, $FF
	.byte $25, $26, $27, $28
	.byte $FF, $33, $34, $32
	.byte $FF, $3F, $40, $FF
	.byte $FF, $4C, $46, $4D
	.byte $FF, $59, $5A, $FF
	.byte $FF, $67, $68, $FF
frame_08:
	.byte $04, $09, $10, $5C, $00
	.byte $FF, $09, $0A, $FF
	.byte $11, $12, $13, $FF
	.byte $1A, $1B, $1C, $FF
	.byte $25, $26, $27, $28
	.byte $FF, $35, $36, $32
	.byte $41, $42, $43, $04
	.byte $41, $4E, $4F, $50
	.byte $5B, $5C, $5D, $5E
	.byte $69, $6A, $FF, $6B
frame_09:
	.byte $04, $09, $10, $5E, $00
	.byte $DE, $DF, $E0, $FF
	.byte $E1, $E2, $E3, $FF
	.byte $E4, $E5, $E6, $FF
	.byte $E7, $E8, $E9, $FF
	.byte $EA, $EB, $EC, $FF
	.byte $ED, $EE, $EF, $FF
	.byte $F0, $F1, $F2, $FF
	.byte $F3, $F4, $F5, $FF
	.byte $F6, $FF, $F7, $F8
frame_0A:
	.byte $05, $08, $10, $58, $00
	.byte $FF, $FF, $0D, $0E, $FF
	.byte $FF, $17, $18, $19, $FF
	.byte $FF, $23, $24, $25, $26
	.byte $FF, $30, $31, $32, $33
	.byte $FF, $3D, $3E, $3F, $40
	.byte $4D, $4E, $4F, $50, $51
	.byte $5D, $5E, $5F, $60, $19
	.byte $FF, $FF, $FF, $6B, $FF
frame_0B:
	.byte $04, $0A, $10, $5E, $00
	.byte $FF, $C5, $C6, $FF
	.byte $C7, $C8, $C9, $FF
	.byte $CA, $CB, $CC, $FF
	.byte $CD, $CE, $CF, $D0
	.byte $D1, $D2, $D3, $FF
	.byte $D4, $D5, $FF, $FF
	.byte $D6, $D7, $FF, $FF
	.byte $D8, $D9, $FF, $FF
	.byte $DA, $DB, $FF, $FF
	.byte $DC, $DD, $FF, $FF
frame_0C:
	.byte $03, $05, $10, $58, $00
	.byte $6F, $70, $71
	.byte $72, $73, $74
	.byte $75, $76, $77
	.byte $78, $79, $7A
	.byte $FF, $7B, $7C
frame_0D:
	.byte $03, $05, $10, $58, $40
	.byte $71, $70, $6F
	.byte $74, $73, $72
	.byte $77, $76, $75
	.byte $7A, $79, $78
	.byte $7C, $7B, $FF
frame_0E:
	.byte $05, $09, $10, $68, $00
	.byte $01, $02, $FF, $FF, $FF
	.byte $06, $07, $08, $FF, $FF
	.byte $0C, $0D, $0E, $FF, $FF
	.byte $16, $17, $18, $FF, $FF
	.byte $FF, $1E, $1F, $20, $FF
	.byte $FF, $2B, $2C, $2D, $FF
	.byte $3F, $40, $41, $42, $43
	.byte $57, $58, $FF, $59, $5A
	.byte $6E, $6F, $FF, $FF, $FF
frame_0F:
	.byte $06, $08, $10, $62, $00
	.byte $FF, $C1, $C2, $FF, $FF, $FF
	.byte $C3, $C4, $C5, $FF, $FF, $FF
	.byte $C6, $C7, $C8, $C9, $CA, $CB
	.byte $CC, $CD, $CE, $CF, $D0, $D1
	.byte $D2, $D3, $D4, $D5, $FF, $FF
	.byte $FF, $D6, $D7, $FF, $FF, $FF
	.byte $FF, $FF, $D8, $FF, $FF, $FF
	.byte $FF, $D9, $DA, $FF, $FF, $FF
frame_10:
	.byte $07, $08, $10, $62, $00
	.byte $FF, $FF, $FF, $FF, $DC, $DD, $DE
	.byte $DF, $E0, $FF, $E1, $E2, $E3, $FF
	.byte $E4, $E5, $E6, $E7, $E8, $FF, $FF
	.byte $E9, $EA, $EB, $EC, $FF, $FF, $FF
	.byte $ED, $EE, $EF, $F0, $FF, $FF, $FF
	.byte $FF, $FF, $F1, $F2, $FF, $FF, $FF
	.byte $FF, $FF, $F3, $FF, $FF, $FF, $FF
	.byte $FF, $F4, $F5, $FF, $FF, $FF, $FF
frame_11:
	.byte $05, $08, $10, $58, $00
	.byte $FF, $FF, $0D, $0E, $FF
	.byte $FF, $17, $18, $19, $FF
	.byte $FF, $23, $24, $25, $26
	.byte $FF, $30, $31, $32, $33
	.byte $FF, $3D, $3E, $3F, $40
	.byte $4D, $4E, $4F, $50, $51
	.byte $5D, $5E, $5F, $60, $19
	.byte $FF, $FF, $FF, $6B, $FF
	.byte $07, $08, $10, $10, $00
frame_12:
	.byte $05, $08, $10, $58, $00
	.byte $FF, $FF, $0D, $0E, $FF
	.byte $FF, $17, $18, $19, $FF
	.byte $FF, $23, $24, $25, $26
	.byte $FF, $30, $31, $32, $33
	.byte $FF, $3D, $3E, $3F, $40
	.byte $4D, $4E, $4F, $50, $51
	.byte $5D, $5E, $5F, $60, $19
	.byte $FF, $FF, $FF, $6B, $FF
	.byte $07, $08, $10, $10, $00
frame_13:
	.byte $06, $07, $10, $58, $00
	.byte $FF, $FF, $1A, $1B, $FF, $FF
	.byte $FF, $27, $28, $29, $FF, $FF
	.byte $FF, $34, $35, $36, $FF, $05
	.byte $FF, $41, $42, $43, $44, $45
	.byte $FF, $52, $53, $54, $55, $56
	.byte $61, $62, $63, $64, $FF, $FF
	.byte $6C, $6D, $6E, $FF, $FF, $FF
frame_14:
	.byte $06, $09, $10, $5A, $00
	.byte $FF, $FF, $80, $81, $FF, $FF
	.byte $FF, $87, $88, $89, $8A, $8B
	.byte $FF, $94, $95, $96, $97, $98
	.byte $FF, $A2, $A3, $A4, $FF, $FF
	.byte $FF, $AC, $AD, $FF, $FF, $FF
	.byte $FF, $B3, $B4, $FF, $FF, $FF
	.byte $BC, $BD, $BE, $FF, $FF, $FF
	.byte $C6, $C7, $C8, $FF, $FF, $FF
	.byte $CF, $FF, $D0, $D1, $FF, $FF
frame_15:
	.byte $04, $09, $10, $5A, $00
	.byte $FF, $82, $83, $84
	.byte $FF, $8C, $8D, $8E
	.byte $FF, $99, $9A, $9B
	.byte $FF, $A5, $A6, $A7
	.byte $FF, $AE, $AF, $B0
	.byte $B5, $B6, $B7, $B8
	.byte $BF, $C0, $C1, $C2
	.byte $C9, $CA, $CB, $CC
	.byte $D2, $FF, $D3, $D1
frame_16:
	.byte $06, $09, $10, $5A, $00
	.byte $FF, $FF, $85, $86, $FF, $FF
	.byte $F2, $8F, $90, $91, $92, $93
	.byte $9C, $9D, $9E, $9F, $A0, $A1
	.byte $FF, $A9, $AA, $AB, $FF, $FF
	.byte $FF, $B1, $B2, $FF, $FF, $FF
	.byte $B9, $BA, $BB, $FF, $FF, $FF
	.byte $C3, $C4, $C5, $FF, $FF, $FF
	.byte $CD, $CE, $CB, $FF, $FF, $FF
	.byte $D4, $FF, $D3, $D1, $FF, $FF
frame_17:
	.byte $08, $05, $20, $66, $00
	.byte $FF, $FF, $FF, $CB, $CC, $CD, $FF, $FF
	.byte $FF, $FF, $FF, $CE, $CF, $D0, $FF, $FF
	.byte $FF, $FF, $D1, $D2, $D3, $D4, $D5, $FF
	.byte $FF, $D6, $D7, $D8, $D9, $DA, $DB, $DC
	.byte $DD, $DE, $DF, $E0, $E1, $E2, $FF, $FF
frame_18:
	.byte $04, $08, $10, $60, $00
	.byte $FF, $FF, $0E, $0F
	.byte $FF, $1B, $1C, $1D
	.byte $FF, $29, $2A, $2B
	.byte $FF, $36, $37, $38
	.byte $FF, $43, $44, $45
	.byte $4D, $4E, $4F, $50
	.byte $58, $59, $5A, $5B
	.byte $64, $FF, $65, $66
frame_19:
	.byte $04, $0B, $10, $60, $00
	.byte $FF, $01, $02, $FF
	.byte $FF, $04, $05, $06
	.byte $FF, $0A, $0B, $08
	.byte $15, $16, $17, $18
	.byte $22, $23, $24, $FF
	.byte $2F, $30, $31, $FF
	.byte $FF, $3C, $3D, $3E
	.byte $FF, $49, $4A, $FF
	.byte $54, $55, $56, $FF
	.byte $5F, $60, $61, $FF
	.byte $69, $FF, $6A, $6B
frame_1A:
	.byte $06, $0A, $10, $60, $00
	.byte $FF, $FF, $03, $FF, $FF, $FF
	.byte $FF, $FF, $07, $08, $FF, $09
	.byte $FF, $10, $11, $12, $13, $14
	.byte $1E, $1F, $20, $21, $FF, $FF
	.byte $2C, $2D, $2E, $FF, $FF, $FF
	.byte $FF, $39, $3A, $3B, $FF, $FF
	.byte $FF, $46, $47, $48, $FF, $FF
	.byte $51, $52, $53, $FF, $FF, $FF
	.byte $5C, $5D, $5E, $FF, $FF, $FF
	.byte $67, $FF, $68, $FF, $FF, $FF
frame_1B:
	.byte $06, $07, $10, $5E, $00
	.byte $FF, $FF, $FF, $FF, $FF, $81
	.byte $FF, $FF, $FF, $FF, $85, $86
	.byte $FF, $FF, $8F, $90, $91, $92
	.byte $9C, $9D, $9E, $9F, $92, $FF
	.byte $A8, $A9, $AA, $AB, $AC, $FF
	.byte $B5, $B6, $B7, $B8, $B9, $FF
	.byte $C0, $C1, $C2, $C3, $C4, $FF
frame_1C:
	.byte $06, $09, $10, $66, $00
	.byte $FF, $FF, $80, $81, $FF, $FF
	.byte $82, $83, $84, $85, $FF, $FF
	.byte $86, $87, $88, $89, $FF, $FF
	.byte $FF, $FF, $8C, $8D, $FB, $FF
	.byte $FF, $FF, $8F, $90, $91, $FF
	.byte $FF, $FF, $99, $9A, $9B, $FF
	.byte $FF, $FF, $A4, $A5, $A6, $A7
	.byte $FF, $FF, $B3, $B4, $B5, $B6
	.byte $FF, $FF, $C0, $C1, $FF, $C2
frame_1D:
	.byte $04, $04, $10, $66, $00
	.byte $9C, $9D, $9E, $9F
	.byte $A8, $A9, $AA, $AB
	.byte $B7, $B8, $B9, $BA
	.byte $C4, $C5, $C6, $C7
frame_1E:
	.byte $07, $07, $10, $66, $00
	.byte $FF, $FF, $FF, $FF, $8A, $8B, $FF
	.byte $FF, $FF, $FF, $FC, $8E, $FF, $FF
	.byte $FF, $95, $96, $97, $98, $FF, $FF
	.byte $A0, $A1, $A2, $A3, $FF, $FF, $FF
	.byte $AC, $AD, $AE, $AF, $B0, $B1, $B2
	.byte $FF, $FF, $BB, $BC, $BD, $BE, $BF
	.byte $FF, $FF, $C8, $C9, $CA, $FF, $FF
frame_1F:
	.byte $04, $06, $10, $6A, $00
	.byte $98, $99, $9A, $FF
	.byte $A5, $A6, $A7, $FF
	.byte $B1, $B2, $B3, $FF
	.byte $BF, $C0, $C1, $FF
	.byte $CD, $CE, $CF, $FF
	.byte $FF, $DA, $DB, $DC
frame_20:
	.byte $07, $07, $10, $6A, $00
	.byte $FF, $92, $93, $FF, $FF, $FF, $FF
	.byte $9B, $9C, $9D, $9E, $FF, $FF, $FF
	.byte $A8, $A9, $AA, $AB, $FF, $FF, $FF
	.byte $B4, $B5, $B6, $B7, $B8, $FF, $FF
	.byte $FF, $C2, $C3, $C4, $C5, $C6, $FF
	.byte $FF, $FF, $D0, $D1, $D2, $D3, $D4
	.byte $FF, $FF, $DD, $DE, $DF, $FF, $FF
frame_21:
	.byte $05, $09, $10, $5A, $00
	.byte $FF, $D5, $D6, $FF, $D7
	.byte $D8, $D9, $DA, $DB, $DC
	.byte $DD, $DE, $DF, $E0, $E1
	.byte $FF, $E2, $E3, $FF, $FF
	.byte $FF, $E4, $E5, $FF, $FF
	.byte $E6, $E7, $E8, $FF, $FF
	.byte $E9, $EA, $EB, $FF, $FF
	.byte $EC, $ED, $EE, $FF, $FF
	.byte $EF, $FF, $F0, $F1, $FF
frame_22:
	.byte $05, $08, $10, $68, $00
	.byte $FF, $03, $04, $05, $FF
	.byte $FF, $09, $0A, $0B, $FF
	.byte $0F, $10, $11, $12, $13
	.byte $19, $1A, $1B, $FF, $FF
	.byte $21, $22, $23, $FF, $FF
	.byte $2E, $2F, $30, $FF, $FF
	.byte $44, $45, $FF, $FF, $FF
	.byte $5B, $5C, $5D, $FF, $FF
frame_23:
	.byte $05, $04, $10, $68, $00
	.byte $24, $FF, $25, $26, $27
	.byte $31, $32, $2B, $2B, $33
	.byte $46, $47, $48, $49, $4A
	.byte $FF, $5E, $5F, $60, $61
frame_24:
	.byte $06, $06, $10, $68, $00
	.byte $FF, $FF, $FF, $FF, $14, $15
	.byte $FF, $FF, $FF, $FF, $1C, $1D
	.byte $FF, $FF, $FF, $28, $29, $2A
	.byte $34, $35, $36, $37, $38, $FF
	.byte $4B, $4C, $4D, $4E, $FF, $FF
	.byte $62, $63, $64, $65, $FF, $FF
frame_25:
	.byte $05, $04, $10, $60, $00
	.byte $FF, $6E, $6F, $70, $FF
	.byte $71, $72, $73, $74, $75
	.byte $FF, $77, $78, $79, $7A
	.byte $FF, $7B, $7C, $7D, $7E
frame_26:
	.byte $05, $04, $10, $60, $00
	.byte $FF, $6E, $6F, $70, $FF
	.byte $71, $72, $73, $74, $75
	.byte $FF, $77, $78, $79, $7A
	.byte $FF, $7B, $7C, $7D, $7E
frame_27:
	.byte $03, $05, $10, $6C, $00
	.byte $20, $21, $22
	.byte $2F, $30, $31
	.byte $3F, $40, $41
	.byte $4F, $43, $50
	.byte $61, $43, $62
frame_28:
	.byte $04, $04, $10, $6C, $00
	.byte $FF, $32, $33, $FF
	.byte $42, $43, $43, $44
	.byte $51, $52, $53, $54
	.byte $63, $64, $65, $66
frame_29:
	.byte $05, $06, $10, $6C, $00
	.byte $FF, $15, $16, $FF, $17
	.byte $FF, $23, $24, $25, $26
	.byte $FF, $34, $35, $36, $37
	.byte $45, $46, $43, $47, $FF
	.byte $55, $56, $57, $58, $59
	.byte $FF, $67, $68, $69, $FF
frame_2A:
	.byte $04, $09, $10, $6A, $00
	.byte $E0, $E1, $FF, $FF
	.byte $E2, $E3, $E4, $FF
	.byte $E5, $E6, $E7, $FF
	.byte $E8, $E9, $EA, $FF
	.byte $EB, $EC, $ED, $FF
	.byte $EE, $EF, $F0, $FF
	.byte $F1, $F2, $F3, $F4
	.byte $F5, $F6, $F7, $F8
	.byte $F9, $FA, $FB, $FC
frame_2B:
	.byte $04, $09, $10, $6C, $00
	.byte $FF, $FF, $01, $02
	.byte $03, $04, $05, $06
	.byte $09, $0A, $0B, $0C
	.byte $11, $12, $13, $14
	.byte $1C, $1D, $1E, $1F
	.byte $2B, $2C, $2D, $2E
	.byte $3C, $3D, $3E, $FF
	.byte $4C, $4D, $4E, $FF
	.byte $5F, $FF, $60, $FF
frame_2C:
	.byte $04, $09, $10, $64, $00
	.byte $FF, $06, $07, $FF
	.byte $15, $16, $17, $18
	.byte $24, $25, $26, $27
	.byte $32, $33, $34, $35
	.byte $3E, $3F, $40, $FF
	.byte $49, $4A, $4B, $FF
	.byte $54, $55, $56, $57
	.byte $5E, $5F, $60, $61
	.byte $68, $FF, $69, $6A
frame_2D:
	.byte $04, $0A, $10, $6E, $00
	.byte $FF, $80, $81, $FF
	.byte $84, $85, $86, $FF
	.byte $8D, $8E, $8F, $90
	.byte $98, $99, $9A, $9B
	.byte $FF, $A4, $A5, $A6
	.byte $B1, $B2, $B3, $B4
	.byte $BF, $C0, $C1, $FF
	.byte $CD, $CE, $CF, $FF
	.byte $DD, $DE, $DF, $FF
	.byte $ED, $FF, $EE, $D8
frame_2E:
	.byte $04, $0B, $10, $70, $00
	.byte $01, $FF, $FF, $FF
	.byte $02, $03, $FF, $FF
	.byte $04, $05, $06, $FF
	.byte $07, $08, $09, $0A
	.byte $0B, $0C, $0D, $0E
	.byte $0F, $10, $11, $12
	.byte $13, $14, $15, $16
	.byte $17, $18, $19, $FF
	.byte $1A, $1B, $1C, $FF
	.byte $1D, $FF, $1E, $FF
	.byte $1F, $FF, $20, $FF
frame_2F:
	.byte $05, $08, $10, $6C, $00
	.byte $FF, $07, $08, $FF, $FF
	.byte $0D, $0E, $0F, $10, $FF
	.byte $18, $19, $1A, $1B, $FF
	.byte $27, $28, $29, $2A, $FF
	.byte $38, $39, $3A, $3B, $FF
	.byte $48, $49, $4A, $4B, $FF
	.byte $5A, $5B, $5C, $5D, $5E
	.byte $FF, $6A, $FF, $6B, $6C
frame_30:
	.byte $07, $06, $10, $6E, $00
	.byte $FF, $FF, $9C, $FF, $FF, $FF, $FF
	.byte $A7, $A8, $A9, $AA, $FF, $FF, $FF
	.byte $B5, $B6, $B7, $B8, $FF, $FF, $FF
	.byte $C2, $C3, $C4, $C5, $C6, $FF, $FF
	.byte $D0, $D1, $D2, $D3, $D4, $D5, $FF
	.byte $E0, $E1, $E2, $FF, $E3, $E4, $E5
frame_31:
	.byte $05, $09, $10, $60, $00
	.byte $0C, $0D, $FF, $FF, $FF
	.byte $19, $1A, $02, $FF, $FF
	.byte $25, $26, $27, $28, $FF
	.byte $32, $33, $34, $35, $FF
	.byte $FF, $3F, $40, $41, $42
	.byte $FF, $4B, $4C, $FF, $FF
	.byte $FF, $4B, $57, $FF, $FF
	.byte $FF, $62, $63, $FF, $FF
	.byte $FF, $6C, $6D, $FF, $FF
frame_32:
	.byte $04, $09, $10, $6E, $00
	.byte $82, $83, $FF, $FF
	.byte $87, $88, $89, $FF
	.byte $91, $92, $93, $FF
	.byte $9D, $9E, $9F, $FF
	.byte $AB, $AC, $AD, $FF
	.byte $B9, $BA, $BB, $FF
	.byte $C7, $C8, $C9, $FF
	.byte $D6, $FF, $D7, $D8
	.byte $E6, $FF, $E7, $E8
frame_33:
	.byte $05, $08, $10, $6E, $00
	.byte $FF, $8A, $8B, $FF, $8C
	.byte $FF, $94, $95, $96, $97
	.byte $FF, $A0, $A1, $A2, $A3
	.byte $FF, $AE, $AF, $B0, $FF
	.byte $FF, $BC, $BD, $BE, $FF
	.byte $FF, $CA, $CB, $CC, $FF
	.byte $D9, $DA, $DB, $DC, $FF
	.byte $E9, $EA, $EB, $EC, $FF
frame_34:
	.byte $04, $08, $10, $60, $00
	.byte $FF, $FF, $0E, $0F
	.byte $FF, $1B, $1C, $1D
	.byte $FF, $29, $2A, $2B
	.byte $FF, $36, $37, $38
	.byte $FF, $43, $44, $45
	.byte $4D, $4E, $4F, $50
	.byte $58, $59, $5A, $5B
	.byte $64, $FF, $65, $66
frame_35:
	.byte $06, $0A, $10, $60, $00
	.byte $FF, $FF, $03, $FF, $FF, $FF
	.byte $FF, $FF, $07, $08, $FF, $09
	.byte $FF, $10, $11, $12, $13, $14
	.byte $1E, $1F, $20, $21, $FF, $FF
	.byte $2C, $2D, $2E, $FF, $FF, $FF
	.byte $FF, $39, $3A, $3B, $FF, $FF
	.byte $FF, $46, $47, $48, $FF, $FF
	.byte $51, $52, $53, $FF, $FF, $FF
	.byte $5C, $5D, $5E, $FF, $FF, $FF
	.byte $67, $FF, $68, $FF, $FF, $FF
frame_36:
	.byte $04, $0B, $10, $60, $00
	.byte $FF, $01, $02, $FF
	.byte $FF, $04, $05, $06
	.byte $FF, $0A, $0B, $08
	.byte $15, $16, $17, $18
	.byte $22, $23, $24, $FF
	.byte $2F, $30, $31, $FF
	.byte $FF, $3C, $3D, $3E
	.byte $FF, $49, $4A, $FF
	.byte $54, $55, $56, $FF
	.byte $5F, $60, $61, $FF
	.byte $69, $FF, $6A, $6B
frame_37:
	.byte $08, $03, $10, $68, $00
	.byte $39, $3A, $3B, $3C, $3D, $3E, $FF, $FF
	.byte $4F, $50, $51, $52, $53, $54, $55, $56
	.byte $66, $67, $68, $69, $6A, $6B, $6C, $6D
frame_38:
	.byte $05, $09, $10, $68, $40
	.byte $FF, $FF, $FF, $02, $01
	.byte $FF, $FF, $08, $07, $06
	.byte $FF, $FF, $0E, $0D, $0C
	.byte $FF, $FF, $18, $17, $16
	.byte $FF, $20, $1F, $1E, $FF
	.byte $FF, $2D, $2C, $2B, $FF
	.byte $43, $42, $41, $40, $3F
	.byte $5A, $59, $FF, $58, $57
	.byte $FF, $FF, $FF, $6F, $6E
frame_39:
	.byte $05, $08, $10, $68, $00
	.byte $FF, $03, $04, $05, $FF
	.byte $FF, $09, $0A, $0B, $FF
	.byte $0F, $10, $11, $12, $13
	.byte $19, $1A, $1B, $FF, $FF
	.byte $21, $22, $23, $FF, $FF
	.byte $2E, $2F, $30, $FF, $FF
	.byte $44, $45, $FF, $FF, $FF
	.byte $5B, $5C, $5D, $FF, $FF
frame_3A:
	.byte $06, $06, $10, $68, $C0
	.byte $FF, $FF, $65, $64, $63, $62
	.byte $FF, $FF, $4E, $4D, $4C, $4B
	.byte $FF, $38, $37, $36, $35, $34
	.byte $2A, $29, $28, $FF, $FF, $FF
	.byte $1D, $1C, $FF, $FF, $FF, $FF
	.byte $15, $14, $FF, $FF, $FF, $FF

; -----------------------------------------------------------------------------
