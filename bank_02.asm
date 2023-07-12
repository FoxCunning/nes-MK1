.segment "BANK_02"
; $8000-$9FFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"

; -----------------------------------------------------------------------------
;.export tbl_vol_env_ptrs
;.export tbl_arp_ptrs
;.export tbl_pitch_env_ptrs
;.export tbl_duty_env_ptrs
;.include "audio/instruments.asm"

; -----------------------------------------------------------------------------
.export tbl_track_ptrs

; Track pointers
tbl_track_ptrs:
	.word track_silence			; $00
	.word sfx_97A7				; $01	A glitchy sound that sometimes plays when a match starts
	.word sfx_hit				; $02	Any hit
	.word sfx_bleep				; $03	Cursor move and point counter at end of match
	.word sfx_projectile		; $04	Projectile/special attack
	.word sfx_bounce			; $05	Bounce/land after jump
	.word track_silence			; $06
	.word sfx_kick				; $07	Kick swing
	.word sfx_kick				; $08	Punch swing
	.word track_silence			; $09
	.word track_silence			; $0A
	.word track_silence			; $0B
	.word sfx_select			; $0C	"Siren" sound (selection confirmed)
	.word sfx_happy_jingle		; $0D	A weird three-note jingle
	.word sfx_pause				; $0E	Pause
	.word sfx_happy_jingle		; $0F	Same as $0D, but here it's used after choosing to continue
	.word sfx_countdown			; $10	Countdown for continue screen
	.word track_silence			; $11
	.word track_silence			; $12
	.word track_silence			; $13
	.word track_silence			; $14
	.word track_silence			; $15
	.word track_silence			; $16
	.word track_silence			; $17
	.word track_silence			; $18
	.word track_silence			; $19
	.word track_silence			; $1A
	.word track_silence			; $1B
	.word track_silence			; $1C
	.word track_silence			; $1D
	.word track_silence			; $1E
	.word track_silence			; $1F
	.word mus_opening			; $20
	.word mus_player_select		; $21
	.word track_silence			; $22
	.word mus_player_unused		; $23
	.word mus_silence			; $24
	; ---- Stage background music starts here
	.word mus_goros_lair		; $25	Goro's Lair
	.word mus_pit				; $26	The Pit
	.word mus_courtyard			; $27	Courtyard
	.word mus_palace_gates		; $28	Palace Gates
	.word mus_warrior_shrine	; $29	Warrior Shrine
	.word mus_throne_room		; $2A	Throne Room
	; ----
	.word mus_goros_lair		; $2B
	.word mus_pit				; $2C
	.word mus_courtyard			; $2D
	.word mus_palace_gates		; $2E
	.word mus_warrior_shrine	; $2F
	.word mus_throne_room		; $30
	; ----
	.word sfx_select			; $31	"Siren" sound but as music (e.g. menu selection)
	.word mus_victory_jingle	; $32

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


; Opening/menu music
mus_opening:
.include "audio/opening.asm"

; -----------------------------------------------------------------------------

; Player select / VS screen
mus_player_select:
.include "audio/your_destiny.asm"

; -----------------------------------------------------------------------------

; Silent channel
rom_895F:
	.byte $FF

; ----------------

; A somewhat noisy version of the player selection music
mus_player_unused:
	.byte $00
	.word rom_895F
	.byte $01
	.word rom_895F
	.byte $02
	.word rom_895F
	.byte $03
	.word rom_895F
	.byte $04
	.word rom_895F
	.byte $FF

; -----------------------------------------------------------------------------

; Silent channel
rom_8A19:
	.byte $FF

; ----------------

mus_silence:
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

; Square 1
rom_8A37:
	.byte $F5, $05, $F9, $02, $FA, $FF, $F8, $08
	.byte $FB, $FF
	.byte $81, $21, $82, $26, $00, $FF

; Silent channel
rom_8A4D:
	.byte $FF

; ----------------

; "Siren" sound
sfx_select:
	.byte $00
	.word rom_8A4D
	.byte $01
	.word rom_8A37
	.byte $02
	.word rom_8A4D
	.byte $03
	.word rom_8A4D
	.byte $04
	.word rom_8A4D
	.byte $FF

; -----------------------------------------------------------------------------

; Square 0
rom_8A5E:
	.byte $F5, $02, $F8, $08, $F9, $02
	.byte $FA, $00, $FB, $FF
	.byte $F8, $02, $8C, $2B, $B0, $2D, $FF

; Square 1
rom_8A6D:
	.byte $F8, $08, $F9, $02
	.byte $FA, $00, $FB, $FF
	.byte $8C, $2B, $B0, $2D, $FF

; Triangle
rom_8A7A:
	.byte $F9, $00, $FA, $00
	.byte $FB, $FF
	.byte $8C, $29, $B0, $28, $FF

; Noise
rom_8A87:
	.byte $F9, $FF, $FA, $00, $F8, $00
	.byte $FB, $FF
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

mus_goros_lair:
.include "audio/goros_lair.asm"

; -----------------------------------------------------------------------------

mus_pit:
.include "audio/the_pit.asm"

; -----------------------------------------------------------------------------

mus_courtyard:
.include "audio/courtyard.asm"

; -----------------------------------------------------------------------------

mus_palace_gates:
.include "audio/palace_gates.asm"

; -----------------------------------------------------------------------------

mus_warrior_shrine:
.include "audio/warriors_shrine.asm"

; -----------------------------------------------------------------------------

mus_throne_room:
.include "audio/throne_room.asm"

; -----------------------------------------------------------------------------

; Square 1
rom_96C1:
	.byte $F5, $02, $F8, $09, $F9, $00
	.byte $FA, $FF, $FB, $FF
	.byte $88, $09, $FF

; ----------------

sfx_bounce:
	.byte $81
	.word rom_96C1
	.byte $FF
	
; -----------------------------------------------------------------------------

; Noise
rom_96D2:
	.byte $F5, $03, $F8, $01, $FB, $03
	.byte $84, $0D, $FF

; ----------------

sfx_projectile:
	.byte $83
	.word rom_96D2
	.byte $FF
	
; -----------------------------------------------------------------------------

; Noise
rom_96E3:
	.byte $F5, $03, $F8, $00, $FB, $02
	.byte $82, $09, $06, $FF

; ----------------

sfx_kick:
	.byte $83
	.word rom_96E3
	.byte $FF

; -----------------------------------------------------------------------------

; Unused SFX Noise channel
rom_96F4:
	.byte $F5, $03, $F9, $00, $FA, $FF
	.byte $FB, $FF
	.byte $F8, $00, $B2, $17, $FF

; ----------------

; Potentially unused SFX
sfx_9701_unused:
	.byte $83
	.word rom_96F4
	.byte $FF
	
; -----------------------------------------------------------------------------

; Noise
rom_9705:
	.byte $F5, $03, $F8, $03
	.byte $FA, $FF, $FB, $FF
	.byte $84, $09, $FF

; ----------------

sfx_hit:
	.byte $83
	.word rom_9705
	.byte $FF
	
; -----------------------------------------------------------------------------

; Square 0
rom_9716:
	.byte $F5, $04, $F8, $09, $F9, $00
	.byte $FA, $FF, $FB, $FF
	.byte $83, $2D, $30, $95, $39, $FF
; Square 1
rom_9726:
	.byte $F9, $00, $FA, $FF, $F8, $0C
	.byte $FB, $FF
	.byte $81, $00, $83, $2D, $30, $95, $39, $FF

; ----------------

sfx_happy_jingle:
	.byte $80
	.word rom_9716
	.byte $81
	.word rom_9726
	.byte $FF
	
; -----------------------------------------------------------------------------

; Square 1
rom_973D:
	.byte $F5, $01, $F8, $09, $F9, $00
	.byte $FA, $FF, $FB, $FF
	.byte $83, $28, $00, $24, $00, $28
	.byte $00, $24, $00, $FF

; ----------------

; Pause "jingle"
sfx_pause:
	.byte $81
	.word rom_973D
	.byte $FF
	
; -----------------------------------------------------------------------------

; Square 0
rom_9754:
	.byte $F5, $04, $F8, $09, $F9, $00
	.byte $FA, $FF, $FB, $FF
	.byte $F8, $00, $81, $24, $89, $21, $FF
; Square 1
rom_9763:
	.byte $F9, $00, $FA, $FF, $F8, $00
	.byte $FB, $FF
	.byte $81, $00, $24, $89, $21, $FF

; ----------------

; Countdown sound used in continue screen
sfx_countdown:
	.byte $80
	.word rom_9754
	.byte $81
	.word rom_9763
	.byte $FF

; -----------------------------------------------------------------------------

; Square 1
rom_9778:
	.byte $F5, $04, $F8, $0E, $F9, $09, $FA, $FF
	.byte $FB, $FF
	.byte $81, $30, $81, $3A, $00, $FF

; ----------------

; Cursor movement blip / points counter
sfx_bleep:
	.byte $81
	.word rom_9778
	.byte $FF

; -----------------------------------------------------------------------------

; Potentially unused SFX noise channel
rom_9789:
	.byte $F5, $03, $F9, $00, $FA, $00
	.byte $FB, $FF
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
	.byte $F5, $03, $F8, $04, $F9, $00
	.byte $FA, $FF, $FB, $FF
	.byte $F8, $00, $85, $17, $FF

; ----------------

; This glitchy sound sometimes plays just before a match begins
sfx_97A7:
	.byte $83
	.word rom_979A
	.byte $FF

; -----------------------------------------------------------------------------
