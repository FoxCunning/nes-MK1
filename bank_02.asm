.segment "BANK_02"
; $8000-$9FFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"

; -----------------------------------------------------------------------------
.export tbl_track_ptrs

; Track pointers
tbl_track_ptrs:
	.word sfx_silence			; $00
	.word sfx_97A7				; $01	A glitchy sound that sometimes plays when a match starts
	.word sfx_hit				; $02	Any hit
	.word sfx_dmcbleep			; $03	Cursor movement bleep
	.word sfx_projectile		; $04	Projectile/special attack
	.word sfx_bounce			; $05	Bounce/land after jump
	.word sfx_fight				; $06	Announcer "Fight!"
	.word sfx_kick				; $07	Kick swing
	.word sfx_kick				; $08	Punch swing
	.word sfx_bleep				; $09	Pulse bleep (score counter)
	.word sfx_silence			; $0A
	.word sfx_silence			; $0B
	.word sfx_select			; $0C	"Siren" sound (selection confirmed)
	.word sfx_happy_jingle		; $0D	A weird three-note jingle
	.word sfx_pause				; $0E	Pause
	.word sfx_happy_jingle		; $0F	Same as $0D, but here it's used after choosing to continue
	.word sfx_countdown			; $10	Countdown for continue screen
	.word sfx_rayden			; $11	Announcer "Rayden"
	.word sfx_sonya				; $12	Announcer "Sonya"
	.word sfx_subzero			; $13	Announcer "Sub-Zero"
	.word sfx_scorpion			; $14	Announcer "Scorpion"
	.word sfx_kano				; $15	Announcer "Kano"
	.word sfx_cage				; $16	Announcer "Johnny Cage"
	.word sfx_liukang			; $17	Announcer "Liu Kang"
	.word sfx_silence			; $18
	.word sfx_silence			; $19
	.word sfx_silence			; $1A
	.word sfx_silence			; $1B
	.word sfx_silence			; $1C
	.word sfx_silence			; $1D
	.word sfx_silence			; $1E
	.word sfx_silence			; $1F
	.word mus_opening			; $20
	.word mus_player_select		; $21
	.word mus_and_sfx_silence	; $22
	.word mus_game_over			; $23	Game Over
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

mus_and_sfx_silence:
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
sfx_silence:
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

mus_game_over:
.include "audio/gameover.asm"

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

; ----------------

; "Siren" sound
sfx_select:

	.byte $81
	.word rom_8A37
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

sfx_fight:
	.byte $84
	.word @sfx_fight_ch4
	.byte $FF

	@sfx_fight_ch4:
	.byte $F5, $01, $02, $FF

; -----------------------------------------------------------------------------

; Square 1
rom_96C1:
	.byte $F5, $02, $F8, $0C, $F9, $FF
	.byte $FA, $FF, $FB, $FF
	.byte $88, $09, $FF

; ----------------

sfx_bounce:
	.byte $81
	.word rom_96C1
	.byte $FF

; -----------------------------------------------------------------------------

sfx_dmcbleep:
	.byte $84
	.word @sfx_dmcbleep_ch4
	.byte $FF

	@sfx_dmcbleep_ch4:
	.byte $F5, $01, $0B, $FF

; -----------------------------------------------------------------------------

; Noise
rom_96D2:
	.byte $F5, $03, $F8, $00, $FB, $FF
	.byte $84, $0D, $FF

; ----------------

sfx_projectile:
	.byte $83
	.word rom_96D2
	.byte $FF
	
; -----------------------------------------------------------------------------

sfx_kick:
	.byte $84
	.word @sfx_kick_ch4
	.byte $FF

	@sfx_kick_ch4:
	.byte $F5, $01, $0C, $FF

; -----------------------------------------------------------------------------

; Noise
;rom_9705:
;	.byte $F5, $03, $F8, $FF
;	.byte $FA, $FF, $FB, $FF
;	.byte $84, $09, $FF

; ----------------

sfx_hit:
	;.byte $83
	;.word rom_9705
	.byte $84
	.word @sfx_hit_ch4
	.byte $FF

	@sfx_hit_ch4:
	.byte $F5, $01, $0D, $FF
	
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
	.byte $F5, $01, $F8, $0C, $F9, $FF
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
	.byte $F5, $04, $F8, $0C, $F9, $FF, $FA, $FF
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
	.byte $F5, $03, $F9, $FF, $FA, $FF
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
	.byte $F5, $03, $F8, $FF, $F9, $FF
	.byte $FA, $FF, $FB, $FF
	.byte $F8, $00, $85, $17, $FF

; ----------------

; This glitchy sound sometimes plays just before a match begins
sfx_97A7:
	.byte $83
	.word rom_979A
	.byte $FF

; -----------------------------------------------------------------------------

sfx_rayden:
	.byte $84
	.word @sfx_rayden_ch4
	.byte $FF

	@sfx_rayden_ch4:
	.byte $F5, $01, $03, $FF

; -----------------------------------------------------------------------------

sfx_sonya:
	.byte $84
	.word @sfx_sonya_ch4
	.byte $FF

	@sfx_sonya_ch4:
	.byte $F5, $01, $04, $FF

; -----------------------------------------------------------------------------

sfx_subzero:
	.byte $84
	.word @sfx_subzero_ch4
	.byte $FF

	@sfx_subzero_ch4:
	.byte $F5, $01, $05, $FF

; -----------------------------------------------------------------------------

sfx_scorpion:
	.byte $84
	.word @sfx_scorpion_ch4
	.byte $FF

	@sfx_scorpion_ch4:
	.byte $F5, $01, $06, $FF

; -----------------------------------------------------------------------------

sfx_kano:
	.byte $84
	.word @sfx_kano_ch4
	.byte $FF

	@sfx_kano_ch4:
	.byte $F5, $01, $07, $FF

; -----------------------------------------------------------------------------

sfx_cage:
	.byte $84
	.word @sfx_cage_ch4
	.byte $FF

	@sfx_cage_ch4:
	.byte $F5, $01, $08, $FF

; -----------------------------------------------------------------------------

sfx_liukang:
	.byte $84
	.word @sfx_liukang_ch4
	.byte $FF

	@sfx_liukang_ch4:
	.byte $F5, $01, $09, $FF

; -----------------------------------------------------------------------------
