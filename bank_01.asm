.segment "BANK_01"
; $A000-$BFFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"


; -----------------------------------------------------------------------------

; The first half of this bank is full of corrupted unassembled code
.res $1000

; -----------------------------------------------------------------------------
.export rom_01_B000

; Data pointers
rom_01_B000:
	.word rom_B0D8, rom_B0E8, rom_B0F8, rom_B108
	.word rom_B118, rom_B128, rom_B138, rom_B148
	.word rom_B158, rom_B168, rom_B178, rom_B188
	.word rom_B198, rom_B1A8, rom_B0D8, rom_B0E8
	.word rom_B0D8, rom_B0E8, rom_B0D8, rom_B0E8
	.word rom_B0D8, rom_B0E8, rom_B0D8, rom_B0E8
	.word rom_B0D8, rom_B0E8, rom_B0D8, rom_B0E8
	.word rom_B1B8, rom_B1C8, rom_B1D8, rom_B1E8
	.word rom_B1F8, rom_B208, rom_B218, rom_B228
	.word rom_B238, rom_B248, rom_B258, rom_B268
	.word rom_B278, rom_B288, rom_B298, rom_B2A8
	.word rom_B2B8, rom_B2C8, rom_B2D8, rom_B2E8
	.word rom_B2F8, rom_B308, rom_B318, rom_B328
	.word rom_B338, rom_B348, rom_B358, rom_B368
	.word rom_B378, rom_B388, rom_B398, rom_B3A8
	.word rom_B3B8, rom_B3C8, rom_B3D8, rom_B3E8
	.word rom_B3F8, rom_B408, rom_B418, rom_B428
	.word rom_B438, rom_B448, rom_B458, rom_B468
	.word rom_B478, rom_B488, rom_B498, rom_B4A8
	.word rom_B4B8, rom_B4C8, rom_B4D8, rom_B4E8
	.word rom_B4F8, rom_B508, rom_B518, rom_B528
	.word rom_B538, rom_B548, rom_B558, rom_B568
	.word rom_B578, rom_B588, rom_B598, rom_B5A8
	.word rom_B5B8, rom_B5C8, rom_B5D8, rom_B5E8
	.word rom_B5F8, rom_B608, rom_B618, rom_B628
	.word rom_B638, rom_B648, rom_B658, rom_B668
	.word rom_B678, rom_B688, rom_B698, rom_B6A8

; -----------------------------------------------------------------------------

rom_B0D8:
	.byte $FF, $B7, $9C, $88, $22, $01, $40, $20
	.byte $00, $00, $00, $20, $00, $00, $F0, $FF
rom_B0E8:
	.byte $06, $92, $13, $48, $18, $30, $08, $78
	.byte $01, $C0, $04, $00, $00, $40, $00, $00
rom_B0F8:
	.byte $81, $0F, $4F, $E0, $9F, $80, $06, $20
	.byte $00, $12, $00, $00, $00, $00, $FF, $FF
rom_B108:
	.byte $DF, $9C, $8F, $00, $00, $00, $00, $00
	.byte $00, $C0, $04, $00, $3E, $22, $00, $02
rom_B118:
	.byte $FC, $FD, $47, $44, $00, $01, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $F0
rom_B128:
	.byte $EF, $C1, $08, $46, $40, $20, $02, $00
	.byte $00, $00, $F0, $11, $00, $00, $00, $00
rom_B138:
	.byte $BF, $3E, $7C, $60, $04, $8A, $80, $40
	.byte $00, $00, $02, $00, $00, $80, $C0, $FF
rom_B148:
	.byte $77, $0F, $57, $00, $08, $00, $00, $22
	.byte $00, $00, $07, $1C, $60, $98, $41, $38
rom_B158:
	.byte $FF, $63, $1D, $67, $02, $08, $06, $70
	.byte $00, $00, $60, $00, $44, $14, $40, $FF
rom_B168:
	.byte $4B, $30, $0C, $00, $08, $80, $00, $30
	.byte $21, $00, $02, $B6, $C4, $00, $00, $00
rom_B178:
	.byte $BF, $26, $80, $11, $00, $04, $32, $08
	.byte $00, $10, $00, $18, $00, $4C, $02, $F8
rom_B188:
	.byte $0C, $B0, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $2C, $11, $00, $00, $00, $00
rom_B198:
	.byte $FF, $F9, $3E, $64, $01, $92, $61, $00
	.byte $00, $00, $00, $00, $00, $60, $00, $F0
rom_B1A8:
	.byte $07, $03, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
rom_B1B8:
	.byte $FF, $9F, $FF, $7F, $FC, $FF, $FF, $FF
	.byte $F9, $FF, $F8, $3F, $07, $00, $00, $C0
rom_B1C8:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $FF, $FF, $FF, $0F, $00, $00, $40, $00
rom_B1D8:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $DF
	.byte $FF, $03, $02, $80, $00, $20, $FE, $FF
rom_B1E8:
	.byte $FF, $CF, $FF, $3F, $FF, $DF, $FF, $7F
	.byte $FF, $CF, $0F, $8F, $01, $00, $80, $00
rom_B1F8:
	.byte $FF, $FF, $FF, $3F, $FF, $3F, $FE, $9F
	.byte $FF, $7F, $1E, $02, $C0, $20, $00, $FE
rom_B208:
	.byte $F9, $F9, $FF, $FF, $FF, $F9, $F7, $C3
	.byte $DF, $04, $FE, $00, $FF, $FF, $3D, $04
rom_B218:
	.byte $87, $C7, $FC, $CF, $FF, $FE, $F9, $7F
	.byte $EE, $7F, $FE, $3F, $7E, $7E, $EC, $30
rom_B228:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $7F, $88, $C7, $04, $10, $02, $C0, $00
rom_B238:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $FF, $FF, $FF, $00, $04, $00, $F8, $FF
rom_B248:
	.byte $FF, $FF, $FF, $FF, $DF, $FF, $F9, $FF
	.byte $FE, $E1, $01, $C0, $01, $30, $60, $00
rom_B258:
	.byte $7F, $FC, $20, $01, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
rom_B268:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
rom_B278:
	.byte $01, $00, $F2, $FF, $FF, $FF, $FF, $FF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
rom_B288:
	.byte $0F, $09, $F9, $FF, $FF, $FD, $BF, $FF
	.byte $FF, $FF, $FF, $FF, $FF, $7F, $FE, $7F
rom_B298:
	.byte $99, $CC, $FF, $FF, $FF, $FF, $FF, $3F
	.byte $00, $00, $00, $00, $00, $00, $00, $00
rom_B2A8:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
rom_B2B8:
	.byte $7F, $FB, $FF, $DF, $FF, $97, $FA, $E6
	.byte $8F, $FF, $7E, $F4, $9E, $FC, $F7, $FF
rom_B2C8:
	.byte $FF, $FF, $FF, $FB, $BF, $79, $7D, $FB
	.byte $3F, $D4, $E2, $FF, $47, $2F, $06, $00
rom_B2D8:
	.byte $FF, $6F, $FB, $FF, $FF, $13, $84, $40
	.byte $02, $F0, $01, $20, $40, $F1, $39, $80
rom_B2E8:
	.byte $9F, $F7, $F9, $DF, $99, $3D, $E0, $00
	.byte $7F, $B7, $5B, $C0, $7F, $26, $17, $01
rom_B2F8:
	.byte $FF, $FF, $7F, $FF, $EF, $FA, $D7, $FB
	.byte $7F, $FE, $FF, $00, $8D, $78, $77, $C4
rom_B308:
	.byte $0F, $C8, $FE, $BF, $FF, $FF, $7F, $72
	.byte $FE, $3F, $CE, $CA, $FF, $73, $D6, $01
rom_B318:
	.byte $FF, $FF, $9F, $EB, $D3, $EB, $EC, $7E
	.byte $E6, $33, $9F, $10, $20, $00, $20, $FF
rom_B328:
	.byte $FF, $0F, $7E, $F8, $C8, $07, $07, $E0
	.byte $08, $BE, $21, $18, $B8, $32, $1F, $08
rom_B338:
	.byte $FF, $FF, $BC, $6A, $FB, $5D, $97, $E7
	.byte $CB, $C8, $C1, $F6, $FD, $6F, $FF, $FF
rom_B348:
	.byte $FF, $FE, $4D, $BF, $C4, $49, $9E, $E7
	.byte $24, $E9, $44, $92, $2F, $69, $1E, $68
rom_B358:
	.byte $FF, $EF, $FB, $99, $F8, $4C, $CC, $89
	.byte $E7, $80, $A3, $12, $4E, $E5, $FF, $FF
rom_B368:
	.byte $FF, $3F, $FE, $F8, $CF, $67, $73, $C9
	.byte $E4, $E6, $09, $4E, $27, $8F, $FF, $7F
rom_B378:
	.byte $FF, $E4, $EE, $1E, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
rom_B388:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
rom_B398:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $9F, $04
	.byte $20, $00, $00, $00, $00, $00, $00, $FE
rom_B3A8:
	.byte $19, $1F, $1F, $1E, $18, $78, $FE, $E3
	.byte $3F, $3C, $C3, $18, $00, $00, $00, $08
rom_B3B8:
	.byte $FF, $F8, $8F, $FF, $F1, $FF, $7C, $46
	.byte $2E, $66, $10, $30, $10, $00, $00, $10
rom_B3C8:
	.byte $9F, $10, $F8, $FF, $FF, $FF, $F7, $07
	.byte $57, $00, $01, $00, $00, $00, $00, $00
rom_B3D8:
	.byte $FF, $FF, $FF, $FF, $7F, $66, $E4, $03
	.byte $00, $03, $00, $18, $00, $00, $00, $80
rom_B3E8:
	.byte $FF, $F3, $7F, $FE, $99, $1D, $60, $78
	.byte $00, $80, $01, $00, $00, $F0, $0F, $01
rom_B3F8:
	.byte $FF, $FF, $FD, $C7, $FF, $FC, $3F, $0F
	.byte $18, $60, $00, $00, $00, $01, $C0, $FC
rom_B408:
	.byte $FF, $E4, $30, $C4, $01, $26, $C0, $73
	.byte $80, $39, $9C, $C7, $F1, $F0, $78, $00
rom_B418:
	.byte $FF, $FF, $FF, $FF, $FF, $3F, $C0, $0F
	.byte $30, $00, $00, $00, $80, $07, $00, $00
rom_B428:
	.byte $FF, $FF, $FF, $FF, $FF, $1D, $01, $20
	.byte $00, $00, $00, $00, $C8, $1F, $00, $00
rom_B438:
	.byte $FF, $FF, $FF, $CF, $FD, $67, $0C, $00
	.byte $00, $00, $00, $00, $00, $FE, $18, $F8
rom_B448:
	.byte $FF, $FF, $3F, $00, $00, $00, $60, $4C
	.byte $0C, $00, $00, $00, $00, $00, $00, $00
rom_B458:
	.byte $FF, $FF, $FF, $FF, $FF, $18, $99, $08
	.byte $09, $1D, $01, $FF, $FD, $3F, $C0, $FC
rom_B468:
	.byte $FF, $F7, $FF, $BF, $FF, $CF, $F9, $1F
	.byte $0C, $7F, $C0, $31, $01, $F3, $FF, $7F
rom_B478:
	.byte $FF, $FF, $FF, $B7, $FF, $C0, $7F, $20
	.byte $FF, $63, $CE, $F9, $FF, $9F, $FF, $FF
rom_B488:
	.byte $FF, $FF, $FF, $FF, $3F, $F3, $FF, $E1
	.byte $FF, $FC, $E1, $A7, $3F, $CE, $FF, $07
rom_B498:
	.byte $FF, $FF, $FF, $1F, $00, $00, $00, $F9
	.byte $F3, $FF, $FF, $FF, $FF, $9B, $99, $FF
rom_B4A8:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $07, $00
	.byte $02, $FE, $FF, $FF, $FF, $FF, $03, $00
rom_B4B8:
	.byte $FF, $FF, $FF, $FF, $FF, $3F, $8E, $20
	.byte $7E, $FE, $FF, $FF, $FF, $CB, $FC, $FF
rom_B4C8:
	.byte $FF, $FF, $FF, $FF, $1B, $7E, $87, $3F
	.byte $19, $87, $E3, $FC, $1D, $FF, $3F, $07
rom_B4D8:
	.byte $FF, $FF, $CF, $FD, $53, $81, $F0, $C0
	.byte $60, $7E, $FE, $CF, $EF, $FB, $27, $FF
rom_B4E8:
	.byte $FF, $FF, $FE, $DF, $F8, $C2, $C7, $FC
	.byte $EF, $FF, $11, $FF, $67, $FE, $9F, $79
rom_B4F8:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $04, $7D
	.byte $00, $90, $FF, $7F, $FC, $FF, $FF, $FF
rom_B508:
	.byte $FF, $FF, $FF, $8B, $B3, $98, $FD, $03
	.byte $00, $00, $00, $00, $00, $00, $00, $00
rom_B518:
	.byte $51, $11, $B5, $16, $84, $E1, $67, $FB
	.byte $BF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
rom_B528:
	.byte $06, $02, $9F, $8F, $3D, $F6, $F8, $1E
	.byte $7E, $1E, $3F, $C4, $3F, $F2, $8F, $7F
rom_B538:
	.byte $EB, $08, $6C, $FD, $B8, $C6, $73, $12
	.byte $67, $FF, $FF, $FF, $FF, $FF, $FF, $FF
rom_B548:
	.byte $14, $53, $95, $02, $64, $C0, $EC, $9F
	.byte $FF, $FF, $FF, $FF, $0F, $F2, $FF, $7F
rom_B558:
	.byte $E1, $FD, $9D, $BF, $CF, $DF, $8F, $7F
	.byte $FF, $5B, $04, $EA, $9F, $3F, $FF, $FF
rom_B568:
	.byte $90, $F3, $E6, $7D, $32, $FB, $CD, $79
	.byte $BB, $1F, $FF, $FF, $FF, $FF, $FF, $7F
rom_B578:
	.byte $85, $65, $C9, $02, $D9, $70, $7F, $FE
	.byte $FF, $FF, $FF, $FF, $FF, $77, $CE, $33
rom_B588:
	.byte $40, $2D, $11, $5E, $F0, $FF, $FE, $FF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $7F, $00
rom_B598:
	.byte $15, $25, $00, $00, $C0, $FF, $FF, $FF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
rom_B5A8:
	.byte $FF, $7F, $FE, $CB, $BC, $EB, $86, $F3
	.byte $F7, $FF, $F1, $F3, $FF, $3F, $9F, $0F
rom_B5B8:
	.byte $65, $29, $1D, $E4, $07, $FC, $7F, $FE
	.byte $87, $FF, $FF, $FF, $FF, $FF, $FF, $FF
rom_B5C8:
	.byte $7B, $6E, $D9, $20, $04, $3F, $F9, $FF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $7F
rom_B5D8:
	.byte $FF, $DB, $FF, $FF, $16, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
rom_B5E8:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
rom_B5F8:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $FF, $FF, $FF, $1F, $00, $00, $00, $80
rom_B608:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $FF, $FF, $FF, $FF, $3F, $00, $00, $00
rom_B618:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $FF, $FF, $C6, $FF, $DF, $9F, $03, $07
rom_B628:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $0F, $00, $00, $FE, $FF, $7F, $80, $00
rom_B638:
	.byte $FF, $1F, $FF, $FC, $CF, $FF, $FF, $FF
	.byte $03, $FF, $07, $FC, $E3, $FF, $FF, $03
rom_B648:
	.byte $FF, $FF, $FF, $FF, $FF, $CF, $FF, $FF
	.byte $F3, $FF, $EF, $FF, $01, $00, $00, $03
rom_B658:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $FF, $FF, $FF, $FF, $03, $00, $00, $00
rom_B668:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $FF, $FF, $7F, $00, $00, $00, $10, $00
rom_B678:
	.byte $FF, $FF, $FF, $7F, $66, $92, $C4, $86
	.byte $F2, $AF, $57, $82, $98, $8B, $FF, $FF
rom_B688:
	.byte $FF, $FF, $9F, $EC, $24, $7F, $81, $C0
	.byte $1C, $78, $48, $46, $F2, $20, $10, $00
rom_B698:
	.byte $FE, $DF, $FF, $84, $7F, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
rom_B6A8:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $80

; -----------------------------------------------------------------------------
