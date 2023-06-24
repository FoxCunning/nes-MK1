.segment "BANK_02"
; $8000-$9FFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"

; -----------------------------------------------------------------------------
.export tbl_vol_env_ptrs
.export tbl_arp_ptrs
.export tbl_pitch_env_ptrs
.export tbl_duty_env_ptrs
.include "audio/instruments.asm"

; -----------------------------------------------------------------------------
.export tbl_pitches

; Period table (NTSC)
tbl_pitches:
	.word $0000	; $00	(rest)
	.word $0000	; $01	N/A
	.word $0000	; $02	N/A
	.word $0000	; $03	N/A
	.word $0000	; $04	N/A
	.word $0000	; $05	N/A
	.word $0000	; $06	N/A
	.word $0000	; $07	N/A
	.word $0000	; $08	N/A
	.word $07F1	; $09	A0
	.word $0780	; $0A	A#0
	.word $0712	; $0B	B0

	.word $06AD	; $0C	C1
	.word $064D	; $0D	C#1
	.word $05F3	; $0E	D1
	.word $059D	; $0F	D#1
	.word $054D	; $10	E1
	.word $0500	; $11	F1
	.word $04B8	; $12	F#1
	.word $0475	; $13	G1
	.word $0435	; $14	G#1
	.word $03F8 ; $15	A1
	.word $03BF	; $16	A#1
	.word $0389	; $17	B1
	.word $0356	; $18	C2
	.word $0326	; $19	C#2
	.word $02F9 ; $1A	D2
	.word $02CE	; $1B	D#2
	.word $02A6	; $1C	E2
	.word $027F	; $1D	F2
	.word $025C	; $1E	F#2
	.word $023A	; $1F	G2
	.word $021A	; $20	G#2
	.word $01FB	; $21	A2
	.word $01DF	; $22	A#2
	.word $01C4	; $23	B2

	.word $01AB	; $24	C3
	.word $0193	; $25	C#3
	.word $017C	; $26	D3
	.word $0167	; $27	D#3
	.word $0152	; $28	E3
	.word $013F	; $29	F3
	.word $012D	; $2A	F#3
	.word $011C	; $2B	G3
	.word $010C	; $2C	G#3
	.word $00FD	; $2D	A3
	.word $00EF	; $2E	A#3
	.word $00E2	; $2F	B3

	.word $00D2	; $30	C4
	.word $00C9	; $31	C#4
	.word $00BD	; $32	D4
	.word $00B3	; $33	D#4
	.word $00A9	; $34	E4
	.word $009F	; $35	F4
	.word $0096	; $36	F#4
	.word $008E	; $37	G4
	.word $0086	; $38	G#4
	.word $007E	; $39	A4
	.word $0077	; $3A	A#4
	.word $0070	; $3B	B4

	.word $006A	; $3C	C5
	.word $0064	; $3D	C#5
	.word $005E	; $3E	D5
	.word $0059	; $3F	D#5
	.word $0054	; $40	E5
	.word $004F	; $41	F5
	.word $004B	; $42	F#5
	.word $0046	; $43	G5
	.word $0042	; $44	G#5
	.word $003F	; $45	A5
	.word $003B	; $46	A#5
	.word $0038	; $47	B5

	.word $0034	; $48	C6
	.word $0031	; $49	C#6
	.word $002F	; $4A	D6
	.word $002C	; $4B	D#6
	.word $0029	; $4C	E6
	.word $0027	; $4D	F6
	.word $0025	; $4E	F#6
	.word $0023	; $4F	G6
	.word $0021	; $50	G#6
	.word $001F	; $51	A6
	.word $001D	; $52	A#6
	.word $001B	; $53	B6

	.word $001A	; $54	C7
	.word $0018	; $55	C#7
	.word $0017	; $56	D7
	.word $0015	; $57	D#7
	.word $0014	; $58	E7
	.word $0013	; $59	F7
	.word $0012	; $5A	F#7
	.word $0011	; $5B	G7
	.word $0010	; $5C	G#7
	.word $000F	; $5D	A7
	.word $000E	; $5E	A#7
	.word $000D	; $5F	B7

; -----------------------------------------------------------------------------
.export tbl_track_ptrs

; Track pointers
tbl_track_ptrs:
	.word track_silence		; $00
	.word sfx_97A7			; $01	A glitchy sound that sometimes plays when a match starts
	.word sfx_9712			; $02	Any hit
	.word sfx_9785			; $03	Cursor move and point counter at end of match
	.word sfx_96DF			; $04	Projectile/special attack
	.word sfx_96CE			; $05	Bounce/land after jump
	.word track_silence		; $06
	.word sfx_96F0			; $07	Kick swing
	.word sfx_96F0			; $08	Punch swing
	.word track_silence		; $09
	.word track_silence		; $0A
	.word track_silence		; $0B
	.word sfx_8A4E			; $0C	"Siren" sound (e.g. after menu selection)
	.word sfx_9736			; $0D	A weird three-note jingle
	.word sfx_9750			; $0E	Pause
	.word sfx_9736			; $0F	Same as $0D, but here it's used after choosing to continue
	.word sfx_9771			; $10	Countdown for continue screen
	.word track_silence		; $11
	.word track_silence		; $12
	.word track_silence		; $13
	.word track_silence		; $14
	.word track_silence		; $15
	.word track_silence		; $16
	.word track_silence		; $17
	.word track_silence		; $18
	.word track_silence		; $19
	.word track_silence		; $1A
	.word track_silence		; $1B
	.word track_silence		; $1C
	.word track_silence		; $1D
	.word track_silence		; $1E
	.word track_silence		; $1F
	.word mus_menu_jingle	; $20
	.word mus_player_select	; $21
	.word track_silence		; $22
	.word mus_player_unused	; $23
	.word mus_8A1A			; $24
	.word mus_8D5F			; $25
	.word mus_8EE8			; $26
	.word mus_9162			; $27
	.word mus_9353			; $28
	.word mus_94C4			; $29
	.word mus_96B1			; $2A
	.word mus_8D5F			; $2B
	.word mus_8EE8			; $2C
	.word mus_9162			; $2D
	.word mus_9353			; $2E
	.word mus_94C4			; $2F
	.word mus_96B1			; $30
	.word sfx_8A4E			; $31
	.word mus_victory_jingle; $32

; -----------------------------------------------------------------------------

track_silence:
	.byte $00
	.word rom_8702
	.byte $01
	.word rom_8702
	.byte $02
	.word rom_8702
	.byte $03
	.word rom_8702
	.byte $04
	.word rom_8702
	; This should mute the SFX channels too
	.byte $80
	.word rom_8702
	.byte $81
	.word rom_8702
	.byte $82
	.word rom_8702
	.byte $83
	.word rom_8702
	.byte $84
	.word rom_8702
rom_8702:
	.byte $FF

; -----------------------------------------------------------------------------

; Square 0
rom_8703:
	.byte $F5, $02, $F6, $0F, $F9, $00, $FA, $00
	.byte $F8, $02, $83, $2D, $2B, $A4, $2D, $8C
	.byte $00, $00, $F6, $01, $F9, $00, $FA, $00
	.byte $F8, $41, $98, $17, $FF, $FF

; Square 1
rom_8721:
	.byte $F6, $0F, $F9, $00, $FA, $00, $F8, $00
	.byte $83, $39, $37, $A4, $39, $8C, $00, $00
	.byte $F6, $01, $F9, $00, $FA, $00, $F8, $00
	.byte $BC, $15, $FF, $FF

; Triangle
rom_873D:
	.byte $F6, $0F, $F9, $00, $FA, $00, $F8, $00
	.byte $83, $2B, $29, $A4, $28, $8C, $00, $00
	.byte $FF

; Noise
rom_874E:
	.byte $F6, $00, $F9, $00, $FA, $00, $F8, $00
	.byte $83, $24, $24, $24, $24, $8C, $00, $00
	.byte $00, $00, $F9, $00, $FA, $00, $F8, $00
	.byte $A4, $2D, $FF, $FF

; DMC?
rom_876A:
	.byte $FF

; ----------------

; Menu intro jingle
mus_menu_jingle:
	.byte $00
	.word rom_8703
	.byte $01
	.word rom_8721
	.byte $02
	.word rom_873D
	.byte $03
	.word rom_874E
	.byte $04
	.word rom_876A
	.byte $FF

; -----------------------------------------------------------------------------

; Player select / VS screen
mus_player_select:
.include "audio/your_destiny.asm"

; -----------------------------------------------------------------------------

; Square 0
rom_88E5:
	.byte $F5, $02, $F6, $0B, $F9, $00, $FA, $00
	.byte $F8, $00
	@rom_88EF:
	.byte $F6, $0B, $F9, $00, $FA, $00, $F8, $00
	.byte $88, $21, $2D, $2B, $2D, $00, $2D, $2B
	.byte $2D, $21, $2D, $2B, $2D, $00, $2D, $2B
	.byte $2D
	.byte $F4
	.word @rom_88EF
	.byte $FF
; ----------------

; Square 1
rom_890C:
	.byte $F6, $0B, $F9, $00, $FA, $00, $F8, $00
	@rom_8914:
	.byte $F9, $00, $FA, $00, $F8, $00, $88, $2D
	.byte $84, $2B, $2D, $30, $2D, $88, $2D, $2D
	.byte $2D, $2B, $2D, $2D, $84, $2B, $2D, $30
	.byte $2D, $88, $2D
	.byte $F4
	.word @rom_8914
	.byte $FF
; ----------------

; Triangle
rom_8933:
	.byte $F6, $0A, $F9, $00, $FA, $00, $F8, $00
	.byte $88, $21, $2D, $2B, $2D, $00, $2D, $2B
	.byte $2D
	.byte $F4
	.word rom_8933
	.byte $FF
; ----------------

; Noise
rom_8948:
	.byte $F6, $00, $F9, $00, $FA, $00, $F8, $00
	.byte $88, $24, $24, $24, $24, $24, $24, $24
	.byte $84, $24, $24
	.byte $F4
	.word rom_8948
	.byte $FF
; ----------------

; DMC?
rom_895F:
	.byte $FF

; ----------------

; A somewhat noisy version of the player selection music
mus_player_unused:
	.byte $00
	.word rom_88E5
	.byte $01
	.word rom_890C
	.byte $02
	.word rom_8933
	.byte $03
	.word rom_8948
	.byte $04
	.word rom_895F
	.byte $FF

; -----------------------------------------------------------------------------

; Silent channel
rom_8A19:
	.byte $FF

; ----------------

mus_8A1A:
	.byte $00
	.word rom_8A19
	.byte $01
	.word rom_8A19
	.byte $02
	.word rom_8A19
	.byte $03
	.word rom_8A19
	.byte $04
	.word rom_8A19
	.byte $FF

; -----------------------------------------------------------------------------

; Square 0
rom_8A2A:
	.byte $F5, $02, $F6, $00, $F9, $00, $FA, $00
	.byte $F8, $00, $A4, $1D, $FF

; Square 1
rom_8A37:
	.byte $F6, $01, $F9, $00, $FA, $00, $F8, $00
	.byte $A4, $21, $FF

; Triangle
rom_8A42:
	.byte $F6, $00, $F9, $00, $FA, $00, $F8, $00
	.byte $A4, $2F, $FF

; Silent channel
rom_8A4D:
	.byte $FF

; ----------------

; "Siren" sound
sfx_8A4E:
	.byte $00
	.word rom_8A2A
	.byte $01
	.word rom_8A37
	.byte $02
	.word rom_8A42
	.byte $03
	.word rom_8A4D
	.byte $04
	.word rom_8A4D
	.byte $FF

; -----------------------------------------------------------------------------

; Square 0
rom_8A5E:
	.byte $F5, $02, $F6, $0F, $F9, $07, $FA, $00
	.byte $F8, $02, $8C, $2B, $B0, $2D, $FF

; Square 1
rom_8A6D:
	.byte $F6, $0F, $F9, $12, $FA, $00, $F8, $00
	.byte $8C, $2B, $B0, $2D, $FF

; Triangle
rom_8A7A:
	.byte $F6, $0F, $F9, $00, $FA, $00, $F8, $00
	.byte $8C, $29, $B0, $28, $FF

; Noise
rom_8A87:
	.byte $F6, $00, $F9, $00, $FA, $00, $F8, $00
	.byte $83, $24, $24, $24, $24, $86, $24, $24
	.byte $24, $24, $24, $24, $24, $FF

; Silent channel	
rom_8A9D:
	.byte $FF

; ----------------

mus_victory_jingle:
	.byte $00
	.word rom_8A5E
	.byte $01
	.word rom_8A6D
	.byte $02
	.word rom_8A7A
	.byte $03
	.word rom_8A87
	.byte $04
	.word rom_8A9D
	.byte $FF

; -----------------------------------------------------------------------------

; Silent channel
rom_8D5E:
	.byte $FF

; ----------------

mus_8D5F:
	.byte $00
	.word rom_8D5E
	.byte $01
	.word rom_8D5E
	.byte $02
	.word rom_8D5E
	.byte $03
	.word rom_8D5E
	.byte $04
	.word rom_8D5E
	.byte $FF

; -----------------------------------------------------------------------------

; Silent channel
rom_8EE7:
	.byte $FF

; ----------------

mus_8EE8:
	.byte $00
	.word rom_8EE7
	.byte $01
	.word rom_8EE7
	.byte $02
	.word rom_8EE7
	.byte $03
	.word rom_8EE7
	.byte $04
	.word rom_8EE7
	.byte $FF

; -----------------------------------------------------------------------------

; Silent channel
rom_9161:
	.byte $FF

; ----------------

mus_9162:
	.byte $00
	.word rom_9161
	.byte $01
	.word rom_9161
	.byte $02
	.word rom_9161
	.byte $03
	.word rom_9161
	.byte $04
	.word rom_9161
	.byte $FF

; -----------------------------------------------------------------------------

; Silent channel
rom_9319:
	.byte $FF

; ----------------

mus_9353:
	.byte $00
	.word rom_9319
	.byte $01
	.word rom_9319
	.byte $02
	.word rom_9319
	.byte $03
	.word rom_9319
	.byte $04
	.word rom_9319
	.byte $FF

; -----------------------------------------------------------------------------

; Silent channel
rom_94C3:
	.byte $FF

; ----------------

mus_94C4:
	.byte $00
	.word rom_94C3
	.byte $01
	.word rom_94C3
	.byte $02
	.word rom_94C3
	.byte $03
	.word rom_94C3
	.byte $04
	.word rom_94C3
	.byte $FF

; -----------------------------------------------------------------------------

; Silent channel
rom_96B0:
	.byte $FF

; ----------------

mus_96B1:
	.byte $00
	.word rom_96B0
	.byte $01
	.word rom_96B0
	.byte $02
	.word rom_96B0
	.byte $03
	.word rom_96B0
	.byte $04
	.word rom_96B0
	.byte $FF

; -----------------------------------------------------------------------------

; Square 1
rom_96C1:
	.byte $F5, $02, $F6, $01, $F9, $00, $FA, $00
	.byte $F8, $00, $BC, $15, $FF

; ----------------

sfx_96CE:
	.byte $81
	.word rom_96C1
	.byte $FF
	
; -----------------------------------------------------------------------------

; Noise
rom_96D2:
	.byte $F5, $03, $F6, $01, $F9, $00, $FA, $00
	.byte $F8, $00, $A0, $2D, $FF

; ----------------

sfx_96DF:
	.byte $83
	.word rom_96D2
	.byte $FF
	
; -----------------------------------------------------------------------------

; Noise
rom_96E3:
	.byte $F5, $03, $F6, $01, $F9, $00, $FA, $00
	.byte $F8, $01, $A0, $2F, $FF

; ----------------

sfx_96F0:
	.byte $83
	.word rom_96E3
	.byte $FF

; -----------------------------------------------------------------------------

; Unused SFX Noise channel
rom_96F4:
	.byte $F5, $03, $F6, $01, $F9, $00, $FA, $00
	.byte $F8, $00, $B2, $17, $FF

; ----------------

; Potentially unused SFX
sfx_9701_unused:
	.byte $83
	.word rom_96F4
	.byte $FF
	
; -----------------------------------------------------------------------------

rom_9705:
	.byte $F5, $03, $F6, $01, $F9, $00, $FA, $00
	.byte $F8, $00, $8C, $29, $FF

; ----------------

sfx_9712:
	.byte $83
	.word rom_9705
	.byte $FF
	
; -----------------------------------------------------------------------------

; Square 0
rom_9716:
	.byte $F5, $04, $F6, $00, $F9, $00, $FA, $00
	.byte $F8, $00, $83, $2D, $30, $95, $39, $FF
; Square 1
rom_9726:
	.byte $F6, $00, $F9, $00, $FA, $00, $F8, $00
	.byte $81, $00, $83, $2D, $30, $95, $39, $FF

; ----------------

sfx_9736:
	.byte $80
	.word rom_9716
	.byte $81
	.word rom_9726
	.byte $FF
	
; -----------------------------------------------------------------------------

; Square 1
rom_973D:
	.byte $F5, $01, $F6, $11, $F9, $00, $FA, $00
	.byte $F8, $00, $83, $28, $00, $24, $00, $28
	.byte $00, $24, $FF

; ----------------

sfx_9750:
	.byte $81
	.word rom_973D
	.byte $FF
	
; -----------------------------------------------------------------------------

; Square 0
rom_9754:
	.byte $F5, $04, $F6, $00, $F9, $00, $FA, $00
	.byte $F8, $00, $81, $24, $89, $21, $FF
; Square 1
rom_9763:
	.byte $F6, $00, $F9, $00, $FA, $00, $F8, $00
	.byte $81, $00, $24, $89, $21, $FF

; ----------------

sfx_9771:
	.byte $80
	.word rom_9754
	.byte $81
	.word rom_9763
	.byte $FF

; -----------------------------------------------------------------------------

; Square 0
rom_9778:
	.byte $F5, $04, $F6, $00, $F9, $00, $FA, $00
	.byte $F8, $00, $83, $39, $FF

; ----------------

; Cursor movement blip
sfx_9785:
	.byte $80
	.word rom_9778
	.byte $FF

; -----------------------------------------------------------------------------

; Potentially unused SFX noise channel
rom_9789:
	.byte $F5, $03, $F6, $01, $F9, $00, $FA, $00
	.byte $F8, $00, $84, $2F, $FF

; ----------------

; Potentially unused SFX
sfx_9796_unused:
	.byte $83
	.word rom_9789
	.byte $FF

; -----------------------------------------------------------------------------

; Noise
rom_979A:
	.byte $F5, $03, $F6, $01, $F9, $00, $FA, $00
	.byte $F8, $00, $85, $17, $FF

; ----------------


sfx_97A7:
	.byte $83
	.word rom_979A
	.byte $FF

; -----------------------------------------------------------------------------

; Potentially unused
rom_97AB:
	.byte $0B, $79, $7A, $7B
	.byte $14, $FF, $02, $01, $8A, $93, $94, $95
	.byte $96, $97, $98, $0B, $90, $91, $92, $14
	.byte $FF, $8C, $CA, $01, $A5, $A6, $A7, $A8
	.byte $A9, $AA, $0B, $02, $03, $04, $14, $FF
	.byte $81, $CB, $08, $01, $83, $1A, $1B, $1C
	.byte $14, $FF, $83, $E1, $E2, $E3, $06, $CF
	.byte $83, $CC, $CD, $CE, $14, $FF, $83, $01
	.byte $02, $03, $06, $B4, $83, $1C, $1D, $1E
	.byte $14, $FF, $86, $04, $05, $06, $07, $08
	.byte $09, $03, $B3, $83, $30, $31, $32, $14
	.byte $FF, $8C, $0A, $0B, $0C, $0D, $0E, $0F
	.byte $10, $11, $B4, $49, $4A, $4B, $14, $FF
	.byte $87, $12, $13, $14, $15, $16, $17, $18
	.byte $02, $B4, $83, $62, $63, $64, $14, $FF
	.byte $09, $1A, $83, $76, $77, $78, $14, $FF
	.byte $09, $1B, $83, $7D, $7E, $7F, $14, $FF
	.byte $8C, $A6, $A7, $AA, $AB, $A6, $A7, $AA
	.byte $AB, $83, $84, $85, $86, $14, $FF, $8C
	.byte $A8, $A9, $AC, $AD, $A8, $A9, $AC, $AD
	.byte $88, $89, $8A, $8B, $14, $FF, $0C, $8D
	.byte $14, $FF, $0C, $8E, $14, $FF, $0C, $8E
	.byte $14, $FF, $0C, $8F, $14, $FF, $8C, $AE
	.byte $AF, $B0, $B1, $AE, $AF, $B0, $B1, $AE
	.byte $AF, $B0, $B1, $14, $FF, $0C, $B2, $14
	.byte $FF, $08, $0F, $02, $F0, $81, $A0, $02
	.byte $30, $83, $50, $10, $30, $02, $FF, $81
	.byte $AA, $02, $33, $85, $DD, $11, $33, $AE
	.byte $EF, $02, $AA, $83, $E6, $DD, $D5, $02
	.byte $AA, $81, $AE, $02, $AA, $81, $EE, $02
	.byte $FD, $81, $AA, $02, $FF, $81, $FA, $05
	.byte $FF, $08, $00, $08, $FF, $81, $0F, $FF
	.byte $FF

; -----------------------------------------------------------------------------

; As usual, the rest is rubbish (unassembled code)
