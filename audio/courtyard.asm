	.byte $00
	.word courtyard_ch0
	.byte $01
	.word courtyard_ch1
	.byte $02
	.word courtyard_ch2
	.byte $03
	.word courtyard_ch3
	.byte $FF



courtyard_ch0:
; LOOP OFFSET: $0007 (ORDER 01)
	.byte $F4, $07, $00	;

; Channel 0
	.byte $F5, $07	; SPEED = 7

; -------- FRAME 00 --------
	@frame_00:
	.byte $F5, $07	; SPEED = 7

; ---- FRAME 00 END ($0002 bytes) ----

; -------- FRAME 01 --------
	@frame_01:
	.byte $F5, $07	; SPEED = 7
	.byte $C0		; Note length = 64
	.byte $01		; (Hold), 64 ticks
	.byte $92		; Note length = 18
	.byte $00		; (Rest), 18 ticks
	.byte $F8, $09	; VOL ENV Pluck
	.byte $F9, $02	; DUTY ENV Pluck
	.byte $FA, $FF	; PITCH ENV Pluck
	.byte $FB, $FF	; ARPEGGIO Pluck
	.byte $84		; Note length = 4
	.byte $2D		; A-3, 4 ticks
	.byte $F8, $0A	; VOL ENV Pluck (Quiet)
	.byte $9C		; Note length = 28
	.byte $2D		; A-3, 28 ticks
	.byte $F8, $09	; VOL ENV Pluck
	.byte $84		; Note length = 4
	.byte $2D		; A-3, 4 ticks
	.byte $F8, $0A	; VOL ENV Pluck (Quiet)

; ---- FRAME 01 END ($0018 bytes) ----

; -------- FRAME 02 --------
	@frame_02:
	.byte $F5, $07	; SPEED = 7
	.byte $8A		; Note length = 10
	.byte $2D		; A-3, 10 ticks
	.byte $92		; Note length = 18
	.byte $00		; (Rest), 18 ticks
	.byte $F8, $09	; VOL ENV Pluck
	.byte $84		; Note length = 4
	.byte $2D		; A-3, 4 ticks
	.byte $F8, $0A	; VOL ENV Pluck (Quiet)
	.byte $9C		; Note length = 28
	.byte $2D		; A-3, 28 ticks
	.byte $F8, $09	; VOL ENV Pluck
	.byte $84		; Note length = 4
	.byte $2D		; A-3, 4 ticks
	.byte $F8, $0A	; VOL ENV Pluck (Quiet)

; ---- FRAME 02 END ($0015 bytes) ----

; -------- FRAME 03 --------
	@frame_03:
	.byte $F5, $07	; SPEED = 7
	.byte $8A		; Note length = 10
	.byte $2D		; A-3, 10 ticks
	.byte $F8, $11	; VOL ENV Synth 2
	.byte $F9, $06	; DUTY ENV Synth 2
	.byte $FA, $02	; PITCH ENV Synth 2
	.byte $84		; Note length = 4
	.byte $21		; A-2, 4 ticks
	.byte $24		; C-3, 4 ticks
	.byte $25		; C#3, 4 ticks
	.byte $27		; D#3, 4 ticks
	.byte $82		; Note length = 2
	.byte $28		; E-3, 2 ticks
	.byte $88		; Note length = 8
	.byte $2B		; G-3, 8 ticks
	.byte $89		; Note length = 9
	.byte $2A		; F#3, 9 ticks
	.byte $84		; Note length = 4
	.byte $2C		; G#3, 4 ticks
	.byte $81		; Note length = 1
	.byte $2A		; F#3, 1 tick
	.byte $29		; F-3, 1 tick
	.byte $84		; Note length = 4
	.byte $2C		; G#3, 4 ticks
	.byte $81		; Note length = 1
	.byte $2A		; F#3, 1 tick
	.byte $29		; F-3, 1 tick
	.byte $2C		; G#3, 1 tick
	.byte $2D		; A-3, 1 tick
	.byte $30		; C-4, 1 tick
	.byte $8D		; Note length = 13
	.byte $33		; D#4, 13 ticks

; ---- FRAME 03 END ($002B bytes) ----

; -------- FRAME 04 --------
	@frame_04:
	.byte $F5, $07	; SPEED = 7
	.byte $84		; Note length = 4
	.byte $00		; (Rest), 4 ticks
	.byte $F8, $12	; VOL ENV Bamboo Echo
	.byte $F9, $04	; DUTY ENV Bamboo Echo
	.byte $FA, $FF	; PITCH ENV Bamboo Echo
	.byte $1A		; D-2, 4 ticks
	.byte $81		; Note length = 1
	.byte $26		; D-3, 1 tick
	.byte $25		; C#3, 1 tick
	.byte $82		; Note length = 2
	.byte $21		; A-2, 2 ticks
	.byte $81		; Note length = 1
	.byte $24		; C-3, 1 tick
	.byte $23		; B-2, 1 tick
	.byte $82		; Note length = 2
	.byte $1F		; G-2, 2 ticks
	.byte $81		; Note length = 1
	.byte $23		; B-2, 1 tick
	.byte $22		; A#2, 1 tick
	.byte $1E		; F#2, 1 tick
	.byte $83		; Note length = 3
	.byte $21		; A-2, 3 ticks
	.byte $F8, $09	; VOL ENV Pluck
	.byte $F9, $02	; DUTY ENV Pluck
	.byte $84		; Note length = 4
	.byte $2D		; A-3, 4 ticks
	.byte $F8, $0A	; VOL ENV Pluck (Quiet)

; ---- FRAME 04 END ($0025 bytes) ----

; -------- FRAME 05 --------
	@frame_05:
	.byte $F5, $07	; SPEED = 7
	.byte $8A		; Note length = 10
	.byte $2D		; A-3, 10 ticks
	.byte $F8, $11	; VOL ENV Synth 2
	.byte $F9, $06	; DUTY ENV Synth 2
	.byte $FA, $02	; PITCH ENV Synth 2
	.byte $84		; Note length = 4
	.byte $21		; A-2, 4 ticks
	.byte $24		; C-3, 4 ticks
	.byte $25		; C#3, 4 ticks
	.byte $27		; D#3, 4 ticks
	.byte $82		; Note length = 2
	.byte $28		; E-3, 2 ticks
	.byte $88		; Note length = 8
	.byte $2B		; G-3, 8 ticks
	.byte $89		; Note length = 9
	.byte $2A		; F#3, 9 ticks
	.byte $84		; Note length = 4
	.byte $2C		; G#3, 4 ticks
	.byte $81		; Note length = 1
	.byte $2A		; F#3, 1 tick
	.byte $29		; F-3, 1 tick
	.byte $84		; Note length = 4
	.byte $2C		; G#3, 4 ticks
	.byte $81		; Note length = 1
	.byte $2A		; F#3, 1 tick
	.byte $29		; F-3, 1 tick
	.byte $2C		; G#3, 1 tick
	.byte $2D		; A-3, 1 tick
	.byte $30		; C-4, 1 tick
	.byte $8D		; Note length = 13
	.byte $33		; D#4, 13 ticks

; ---- FRAME 05 END ($002B bytes) ----

; -------- FRAME 06 --------
	@frame_06:
	.byte $F5, $07	; SPEED = 7
	.byte $84		; Note length = 4
	.byte $00		; (Rest), 4 ticks
	.byte $F8, $12	; VOL ENV Bamboo Echo
	.byte $F9, $04	; DUTY ENV Bamboo Echo
	.byte $FA, $FF	; PITCH ENV Bamboo Echo
	.byte $1A		; D-2, 4 ticks
	.byte $81		; Note length = 1
	.byte $26		; D-3, 1 tick
	.byte $25		; C#3, 1 tick
	.byte $82		; Note length = 2
	.byte $21		; A-2, 2 ticks
	.byte $81		; Note length = 1
	.byte $24		; C-3, 1 tick
	.byte $23		; B-2, 1 tick
	.byte $82		; Note length = 2
	.byte $1F		; G-2, 2 ticks
	.byte $81		; Note length = 1
	.byte $23		; B-2, 1 tick
	.byte $22		; A#2, 1 tick
	.byte $1E		; F#2, 1 tick
	.byte $83		; Note length = 3
	.byte $21		; A-2, 3 ticks
	.byte $F8, $09	; VOL ENV Pluck
	.byte $F9, $02	; DUTY ENV Pluck
	.byte $84		; Note length = 4
	.byte $2D		; A-3, 4 ticks
	.byte $F8, $0A	; VOL ENV Pluck (Quiet)

; ---- FRAME 06 END ($0025 bytes) ----

; -------- FRAME 07 --------
	@frame_07:
	.byte $F5, $03	; SPEED = 3
	.byte $8A		; Note length = 10
	.byte $2D		; A-3, 10 ticks
	.byte $F8, $11	; VOL ENV Synth 2
	.byte $F9, $06	; DUTY ENV Synth 2
	.byte $FA, $02	; PITCH ENV Synth 2
	.byte $F5, $04	; SPEED = 4
	.byte $81		; Note length = 1
	.byte $32		; D-4, 1 tick
	.byte $F5, $03	; SPEED = 3
	.byte $33		; D#4, 1 tick
	.byte $F5, $04	; SPEED = 4
	.byte $32		; D-4, 1 tick
	.byte $F5, $03	; SPEED = 3
	.byte $33		; D#4, 1 tick
	.byte $F5, $04	; SPEED = 4
	.byte $32		; D-4, 1 tick
	.byte $F5, $03	; SPEED = 3
	.byte $33		; D#4, 1 tick
	.byte $F5, $04	; SPEED = 4
	.byte $32		; D-4, 1 tick
	.byte $F5, $03	; SPEED = 3
	.byte $33		; D#4, 1 tick
	.byte $F5, $04	; SPEED = 4
	.byte $32		; D-4, 1 tick
	.byte $F5, $03	; SPEED = 3
	.byte $31		; C#4, 1 tick
	.byte $F5, $04	; SPEED = 4
	.byte $30		; C-4, 1 tick
	.byte $F5, $03	; SPEED = 3
	.byte $2F		; B-3, 1 tick
	.byte $F5, $04	; SPEED = 4
	.byte $2E		; A#3, 1 tick
	.byte $F5, $03	; SPEED = 3
	.byte $2D		; A-3, 1 tick
	.byte $F5, $04	; SPEED = 4
	.byte $2C		; G#3, 1 tick
	.byte $F5, $03	; SPEED = 3
	.byte $2B		; G-3, 1 tick
	.byte $F5, $04	; SPEED = 4
	.byte $2A		; F#3, 1 tick
	.byte $F5, $03	; SPEED = 3
	.byte $2B		; G-3, 1 tick
	.byte $F5, $04	; SPEED = 4
	.byte $2A		; F#3, 1 tick
	.byte $F5, $03	; SPEED = 3
	.byte $2B		; G-3, 1 tick
	.byte $F5, $04	; SPEED = 4
	.byte $2A		; F#3, 1 tick
	.byte $F5, $03	; SPEED = 3
	.byte $2B		; G-3, 1 tick
	.byte $F5, $04	; SPEED = 4
	.byte $2A		; F#3, 1 tick
	.byte $F5, $03	; SPEED = 3
	.byte $2B		; G-3, 1 tick
	.byte $F5, $04	; SPEED = 4
	.byte $2A		; F#3, 1 tick
	.byte $F5, $03	; SPEED = 3
	.byte $29		; F-3, 1 tick
	.byte $F5, $04	; SPEED = 4
	.byte $28		; E-3, 1 tick
	.byte $F5, $03	; SPEED = 3
	.byte $27		; D#3, 1 tick
	.byte $F5, $04	; SPEED = 4
	.byte $26		; D-3, 1 tick
	.byte $F5, $03	; SPEED = 3
	.byte $25		; C#3, 1 tick
	.byte $F5, $04	; SPEED = 4
	.byte $24		; C-3, 1 tick
	.byte $F5, $03	; SPEED = 3
	.byte $23		; B-2, 1 tick
	.byte $F5, $04	; SPEED = 4
	.byte $22		; A#2, 1 tick
	.byte $F5, $03	; SPEED = 3
	.byte $21		; A-2, 1 tick
	.byte $F5, $04	; SPEED = 4
	.byte $F5, $03	; SPEED = 3
	.byte $F5, $04	; SPEED = 4
	.byte $F5, $03	; SPEED = 3
	.byte $F5, $04	; SPEED = 4
	.byte $F5, $03	; SPEED = 3
	.byte $F5, $04	; SPEED = 4
	.byte $F5, $03	; SPEED = 3
	.byte $F5, $04	; SPEED = 4
	.byte $F5, $03	; SPEED = 3
	.byte $F5, $04	; SPEED = 4
	.byte $F5, $03	; SPEED = 3
	.byte $F5, $04	; SPEED = 4
	.byte $F5, $03	; SPEED = 3
	.byte $F5, $04	; SPEED = 4
	.byte $F5, $03	; SPEED = 3
	.byte $F5, $04	; SPEED = 4
	.byte $F5, $03	; SPEED = 3
	.byte $F5, $04	; SPEED = 4
	.byte $F5, $03	; SPEED = 3
	.byte $F5, $04	; SPEED = 4
	.byte $F5, $03	; SPEED = 3
	.byte $F5, $04	; SPEED = 4
	.byte $F5, $03	; SPEED = 3
	.byte $F5, $04	; SPEED = 4
	.byte $F5, $03	; SPEED = 3
	.byte $F5, $04	; SPEED = 4
	.byte $F5, $03	; SPEED = 3
	.byte $F5, $04	; SPEED = 4

; ---- FRAME 07 END ($00AA bytes) ----

; -------- FRAME 08 --------
	@frame_08:
	.byte $F5, $07	; SPEED = 7
	.byte $9E		; Note length = 30
	.byte $20		; G#2, 30 ticks
	.byte $92		; Note length = 18
	.byte $1E		; F#2, 18 ticks
	.byte $F8, $09	; VOL ENV Pluck
	.byte $F9, $02	; DUTY ENV Pluck
	.byte $FA, $FF	; PITCH ENV Pluck
	.byte $84		; Note length = 4
	.byte $2D		; A-3, 4 ticks
	.byte $F8, $0A	; VOL ENV Pluck (Quiet)
	.byte $8A		; Note length = 10
	.byte $2D		; A-3, 10 ticks
	.byte $F1		; END SEGMENT


courtyard_ch1:
; LOOP OFFSET: $0009 (ORDER 01)
	.byte $F4, $09, $00	;

; Channel 1

; -------- FRAME 00 --------
	@frame_00:
	.byte $F8, $07	; VOL ENV Pulse Bass
	.byte $F9, $01	; DUTY ENV Pulse Bass
	.byte $FA, $FF	; PITCH ENV Pulse Bass
	.byte $FB, $FF	; ARPEGGIO Pulse Bass

; ---- FRAME 00 END ($0004 bytes) ----

; -------- FRAME 01 --------
	@frame_01:
	.byte $C0		; Note length = 64
	.byte $0E		; D-1, 64 ticks
	.byte $F8, $05	; VOL ENV Synth Lead
	.byte $F9, $00	; DUTY ENV Synth Lead
	.byte $84		; Note length = 4
	.byte $1A		; D-2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $1E		; F#2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $F8, $09	; VOL ENV Pluck
	.byte $F9, $02	; DUTY ENV Pluck
	.byte $84		; Note length = 4
	.byte $32		; D-4, 4 ticks
	.byte $F8, $0A	; VOL ENV Pluck (Quiet)
	.byte $8A		; Note length = 10
	.byte $32		; D-4, 10 ticks
	.byte $F8, $05	; VOL ENV Synth Lead
	.byte $F9, $00	; DUTY ENV Synth Lead
	.byte $84		; Note length = 4
	.byte $1A		; D-2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $1E		; F#2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $F8, $09	; VOL ENV Pluck
	.byte $F9, $02	; DUTY ENV Pluck
	.byte $84		; Note length = 4
	.byte $32		; D-4, 4 ticks
	.byte $F8, $0A	; VOL ENV Pluck (Quiet)

; ---- FRAME 01 END ($0028 bytes) ----

; -------- FRAME 02 --------
	@frame_02:
	.byte $8A		; Note length = 10
	.byte $32		; D-4, 10 ticks
	.byte $F8, $05	; VOL ENV Synth Lead
	.byte $F9, $00	; DUTY ENV Synth Lead
	.byte $84		; Note length = 4
	.byte $1A		; D-2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $1E		; F#2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $F8, $09	; VOL ENV Pluck
	.byte $F9, $02	; DUTY ENV Pluck
	.byte $84		; Note length = 4
	.byte $32		; D-4, 4 ticks
	.byte $F8, $0A	; VOL ENV Pluck (Quiet)
	.byte $8A		; Note length = 10
	.byte $32		; D-4, 10 ticks
	.byte $F8, $05	; VOL ENV Synth Lead
	.byte $F9, $00	; DUTY ENV Synth Lead
	.byte $84		; Note length = 4
	.byte $1A		; D-2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $1E		; F#2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $F8, $09	; VOL ENV Pluck
	.byte $F9, $02	; DUTY ENV Pluck
	.byte $84		; Note length = 4
	.byte $32		; D-4, 4 ticks
	.byte $F8, $0A	; VOL ENV Pluck (Quiet)

; ---- FRAME 02 END ($0028 bytes) ----

; -------- FRAME 03 --------
	@frame_03:
	.byte $8A		; Note length = 10
	.byte $32		; D-4, 10 ticks
	.byte $F8, $14	; VOL ENV Synth 2 Echo
	.byte $F9, $06	; DUTY ENV Synth 2 Echo
	.byte $FA, $02	; PITCH ENV Synth 2 Echo
	.byte $84		; Note length = 4
	.byte $26		; D-3, 4 ticks
	.byte $29		; F-3, 4 ticks
	.byte $2A		; F#3, 4 ticks
	.byte $2C		; G#3, 4 ticks
	.byte $82		; Note length = 2
	.byte $2D		; A-3, 2 ticks
	.byte $88		; Note length = 8
	.byte $30		; C-4, 8 ticks
	.byte $89		; Note length = 9
	.byte $2F		; B-3, 9 ticks
	.byte $84		; Note length = 4
	.byte $2F		; B-3, 4 ticks
	.byte $81		; Note length = 1
	.byte $2D		; A-3, 1 tick
	.byte $2C		; G#3, 1 tick
	.byte $84		; Note length = 4
	.byte $2F		; B-3, 4 ticks
	.byte $81		; Note length = 1
	.byte $2D		; A-3, 1 tick
	.byte $2C		; G#3, 1 tick
	.byte $2F		; B-3, 1 tick
	.byte $30		; C-4, 1 tick
	.byte $33		; D#4, 1 tick
	.byte $8B		; Note length = 11
	.byte $36		; F#4, 11 ticks

; ---- FRAME 03 END ($0029 bytes) ----

; -------- FRAME 04 --------
	@frame_04:
	.byte $86		; Note length = 6
	.byte $00		; (Rest), 6 ticks
	.byte $F8, $05	; VOL ENV Synth Lead
	.byte $F9, $00	; DUTY ENV Synth Lead
	.byte $FA, $FF	; PITCH ENV Synth Lead
	.byte $84		; Note length = 4
	.byte $1A		; D-2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $1E		; F#2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $F8, $09	; VOL ENV Pluck
	.byte $F9, $02	; DUTY ENV Pluck
	.byte $84		; Note length = 4
	.byte $32		; D-4, 4 ticks
	.byte $F8, $0A	; VOL ENV Pluck (Quiet)

; ---- FRAME 04 END ($0015 bytes) ----

; -------- FRAME 05 --------
	@frame_05:
	.byte $8A		; Note length = 10
	.byte $32		; D-4, 10 ticks
	.byte $F8, $14	; VOL ENV Synth 2 Echo
	.byte $F9, $06	; DUTY ENV Synth 2 Echo
	.byte $FA, $02	; PITCH ENV Synth 2 Echo
	.byte $84		; Note length = 4
	.byte $26		; D-3, 4 ticks
	.byte $29		; F-3, 4 ticks
	.byte $2A		; F#3, 4 ticks
	.byte $2C		; G#3, 4 ticks
	.byte $82		; Note length = 2
	.byte $2D		; A-3, 2 ticks
	.byte $88		; Note length = 8
	.byte $30		; C-4, 8 ticks
	.byte $89		; Note length = 9
	.byte $2F		; B-3, 9 ticks
	.byte $84		; Note length = 4
	.byte $2F		; B-3, 4 ticks
	.byte $81		; Note length = 1
	.byte $2D		; A-3, 1 tick
	.byte $2C		; G#3, 1 tick
	.byte $84		; Note length = 4
	.byte $2F		; B-3, 4 ticks
	.byte $81		; Note length = 1
	.byte $2D		; A-3, 1 tick
	.byte $2C		; G#3, 1 tick
	.byte $2F		; B-3, 1 tick
	.byte $30		; C-4, 1 tick
	.byte $33		; D#4, 1 tick
	.byte $8B		; Note length = 11
	.byte $36		; F#4, 11 ticks

; ---- FRAME 05 END ($0029 bytes) ----

; -------- FRAME 06 --------
	@frame_06:
	.byte $86		; Note length = 6
	.byte $00		; (Rest), 6 ticks
	.byte $F8, $05	; VOL ENV Synth Lead
	.byte $F9, $00	; DUTY ENV Synth Lead
	.byte $FA, $FF	; PITCH ENV Synth Lead
	.byte $84		; Note length = 4
	.byte $1A		; D-2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $1E		; F#2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $F8, $09	; VOL ENV Pluck
	.byte $F9, $02	; DUTY ENV Pluck
	.byte $84		; Note length = 4
	.byte $32		; D-4, 4 ticks
	.byte $F8, $0A	; VOL ENV Pluck (Quiet)

; ---- FRAME 06 END ($0015 bytes) ----

; -------- FRAME 07 --------
	@frame_07:
	.byte $8D		; Note length = 13
	.byte $32		; D-4, 13 ticks
	.byte $F8, $14	; VOL ENV Synth 2 Echo
	.byte $F9, $06	; DUTY ENV Synth 2 Echo
	.byte $FA, $02	; PITCH ENV Synth 2 Echo
	.byte $81		; Note length = 1
	.byte $32		; D-4, 1 tick
	.byte $33		; D#4, 1 tick
	.byte $32		; D-4, 1 tick
	.byte $33		; D#4, 1 tick
	.byte $32		; D-4, 1 tick
	.byte $33		; D#4, 1 tick
	.byte $32		; D-4, 1 tick
	.byte $33		; D#4, 1 tick
	.byte $32		; D-4, 1 tick
	.byte $31		; C#4, 1 tick
	.byte $30		; C-4, 1 tick
	.byte $2F		; B-3, 1 tick
	.byte $2E		; A#3, 1 tick
	.byte $2D		; A-3, 1 tick
	.byte $2C		; G#3, 1 tick
	.byte $2B		; G-3, 1 tick
	.byte $2A		; F#3, 1 tick
	.byte $2B		; G-3, 1 tick
	.byte $2A		; F#3, 1 tick
	.byte $2B		; G-3, 1 tick
	.byte $2A		; F#3, 1 tick
	.byte $2B		; G-3, 1 tick
	.byte $2A		; F#3, 1 tick
	.byte $2B		; G-3, 1 tick
	.byte $2A		; F#3, 1 tick
	.byte $29		; F-3, 1 tick
	.byte $28		; E-3, 1 tick
	.byte $27		; D#3, 1 tick
	.byte $26		; D-3, 1 tick
	.byte $25		; C#3, 1 tick
	.byte $24		; C-3, 1 tick
	.byte $23		; B-2, 1 tick
	.byte $22		; A#2, 1 tick
	.byte $21		; A-2, 1 tick

; ---- FRAME 07 END ($002A bytes) ----

; -------- FRAME 08 --------
	@frame_08:
	.byte $9E		; Note length = 30
	.byte $20		; G#2, 30 ticks
	.byte $8F		; Note length = 15
	.byte $1E		; F#2, 15 ticks
	.byte $F8, $09	; VOL ENV Pluck
	.byte $F9, $02	; DUTY ENV Pluck
	.byte $FA, $FF	; PITCH ENV Pluck
	.byte $84		; Note length = 4
	.byte $32		; D-4, 4 ticks
	.byte $F8, $0A	; VOL ENV Pluck (Quiet)
	.byte $8A		; Note length = 10
	.byte $32		; D-4, 10 ticks
	.byte $F1		; END SEGMENT


courtyard_ch2:
; LOOP OFFSET: $001A (ORDER 01)
	.byte $F4, $1A, $00	;

; Channel 2

; -------- FRAME 00 --------
	@frame_00:
	.byte $F8, $FF	; VOL ENV Tri Kick -> Bass
	.byte $FA, $FF	; PITCH ENV Tri Kick -> Bass
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $85		; Note length = 5
	.byte $1A		; D-2, 5 ticks
	.byte $1A		; D-2, 5 ticks
	.byte $1A		; D-2, 5 ticks
	.byte $1A		; D-2, 5 ticks
	.byte $1A		; D-2, 5 ticks
	.byte $1A		; D-2, 5 ticks
	.byte $1A		; D-2, 5 ticks
	.byte $1A		; D-2, 5 ticks
	.byte $1A		; D-2, 5 ticks
	.byte $1A		; D-2, 5 ticks
	.byte $1A		; D-2, 5 ticks
	.byte $1A		; D-2, 5 ticks
	.byte $1A		; D-2, 5 ticks
	.byte $1A		; D-2, 5 ticks
	.byte $1A		; D-2, 5 ticks
	.byte $1A		; D-2, 5 ticks

; ---- FRAME 00 END ($0015 bytes) ----

; -------- FRAME 01 --------
	@frame_01:
	.byte $84		; Note length = 4
	.byte $1A		; D-2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $1E		; F#2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $00		; (Rest), 2 ticks
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $1A		; D-2, 2 ticks
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $84		; Note length = 4
	.byte $1A		; D-2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $1E		; F#2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $00		; (Rest), 2 ticks
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $1A		; D-2, 2 ticks

; ---- FRAME 01 END ($0037 bytes) ----

; -------- FRAME 02 --------
	@frame_02:
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $84		; Note length = 4
	.byte $1A		; D-2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $1E		; F#2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $00		; (Rest), 2 ticks
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $1A		; D-2, 2 ticks
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $84		; Note length = 4
	.byte $1A		; D-2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $1E		; F#2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $00		; (Rest), 2 ticks
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $1A		; D-2, 2 ticks

; ---- FRAME 02 END ($0038 bytes) ----

; -------- FRAME 03 --------
	@frame_03:
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $84		; Note length = 4
	.byte $1A		; D-2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $1E		; F#2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $00		; (Rest), 2 ticks
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $1A		; D-2, 2 ticks
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $84		; Note length = 4
	.byte $1A		; D-2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $1E		; F#2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $00		; (Rest), 2 ticks
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $1A		; D-2, 2 ticks

; ---- FRAME 03 END ($0038 bytes) ----

; -------- FRAME 04 --------
	@frame_04:
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $84		; Note length = 4
	.byte $1A		; D-2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $1E		; F#2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $00		; (Rest), 2 ticks
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $1A		; D-2, 2 ticks

; ---- FRAME 04 END ($001C bytes) ----

; -------- FRAME 05 --------
	@frame_05:
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $84		; Note length = 4
	.byte $1A		; D-2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $1E		; F#2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $00		; (Rest), 2 ticks
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $1A		; D-2, 2 ticks
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $84		; Note length = 4
	.byte $1A		; D-2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $1E		; F#2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $00		; (Rest), 2 ticks
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $1A		; D-2, 2 ticks

; ---- FRAME 05 END ($0038 bytes) ----

; -------- FRAME 06 --------
	@frame_06:
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $84		; Note length = 4
	.byte $1A		; D-2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $1E		; F#2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $00		; (Rest), 2 ticks
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $1A		; D-2, 2 ticks

; ---- FRAME 06 END ($001C bytes) ----

; -------- FRAME 07 --------
	@frame_07:
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $88		; Note length = 8
	.byte $1A		; D-2, 8 ticks
	.byte $1D		; F-2, 8 ticks
	.byte $1E		; F#2, 8 ticks
	.byte $1D		; F-2, 8 ticks
	.byte $84		; Note length = 4
	.byte $1A		; D-2, 4 ticks
	.byte $00		; (Rest), 4 ticks
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $83		; Note length = 3
	.byte $00		; (Rest), 3 ticks
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $00		; (Rest), 2 ticks
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $1A		; D-2, 2 ticks

; ---- FRAME 07 END ($0022 bytes) ----

; -------- FRAME 08 --------
	@frame_08:
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $84		; Note length = 4
	.byte $1A		; D-2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $1E		; F#2, 4 ticks
	.byte $1D		; F-2, 4 ticks
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $00		; (Rest), 2 ticks
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $85		; Note length = 5
	.byte $18		; C-2, 5 ticks
	.byte $FB, $01	; ARPEGGIO Tri Snare -> Bass
	.byte $82		; Note length = 2
	.byte $1A		; D-2, 2 ticks
	.byte $1A		; D-2, 2 ticks
	.byte $F1		; END SEGMENT


courtyard_ch3:
; LOOP OFFSET: $00AC (ORDER 01)
	.byte $F4, $AC, $00	;

; Channel 3

; -------- FRAME 00 --------
	@frame_00:
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FA, $FF	; PITCH ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $0C		; 3-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $81		; Note length = 1
	.byte $06		; 9-#, 1 tick
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $0C		; 3-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $88		; Note length = 8
	.byte $0C		; 3-#, 8 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $81		; Note length = 1
	.byte $06		; 9-#, 1 tick
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $0C		; 3-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance

; ---- FRAME 00 END ($00A7 bytes) ----

; -------- FRAME 01 --------
	@frame_01:
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $81		; Note length = 1
	.byte $06		; 9-#, 1 tick
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 1 tick
	.byte $84		; Note length = 4
	.byte $08		; 7-#, 4 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $81		; Note length = 1
	.byte $06		; 9-#, 1 tick
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 1 tick

; ---- FRAME 01 END ($009B bytes) ----

; -------- FRAME 02 --------
	@frame_02:
	.byte $84		; Note length = 4
	.byte $08		; 7-#, 4 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $81		; Note length = 1
	.byte $06		; 9-#, 1 tick
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 1 tick
	.byte $84		; Note length = 4
	.byte $08		; 7-#, 4 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $81		; Note length = 1
	.byte $06		; 9-#, 1 tick
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 1 tick

; ---- FRAME 02 END ($00A0 bytes) ----

; -------- FRAME 03 --------
	@frame_03:
	.byte $84		; Note length = 4
	.byte $08		; 7-#, 4 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $81		; Note length = 1
	.byte $06		; 9-#, 1 tick
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 1 tick
	.byte $84		; Note length = 4
	.byte $08		; 7-#, 4 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $81		; Note length = 1
	.byte $06		; 9-#, 1 tick
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 1 tick

; ---- FRAME 03 END ($00A0 bytes) ----

; -------- FRAME 04 --------
	@frame_04:
	.byte $84		; Note length = 4
	.byte $08		; 7-#, 4 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $81		; Note length = 1
	.byte $06		; 9-#, 1 tick
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 1 tick

; ---- FRAME 04 END ($0050 bytes) ----

; -------- FRAME 05 --------
	@frame_05:
	.byte $84		; Note length = 4
	.byte $08		; 7-#, 4 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $81		; Note length = 1
	.byte $06		; 9-#, 1 tick
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 1 tick
	.byte $84		; Note length = 4
	.byte $08		; 7-#, 4 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $81		; Note length = 1
	.byte $06		; 9-#, 1 tick
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 1 tick

; ---- FRAME 05 END ($00A0 bytes) ----

; -------- FRAME 06 --------
	@frame_06:
	.byte $84		; Note length = 4
	.byte $08		; 7-#, 4 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $81		; Note length = 1
	.byte $06		; 9-#, 1 tick
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 1 tick

; ---- FRAME 06 END ($0050 bytes) ----

; -------- FRAME 07 --------
	@frame_07:
	.byte $87		; Note length = 7
	.byte $08		; 7-#, 7 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $82		; Note length = 2
	.byte $0C		; 3-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $84		; Note length = 4
	.byte $06		; 9-#, 4 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $82		; Note length = 2
	.byte $0D		; 2-#, 2 ticks
	.byte $0D		; 2-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $86		; Note length = 6
	.byte $06		; 9-#, 6 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $82		; Note length = 2
	.byte $0C		; 3-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $84		; Note length = 4
	.byte $06		; 9-#, 4 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $82		; Note length = 2
	.byte $0D		; 2-#, 2 ticks
	.byte $0D		; 2-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $86		; Note length = 6
	.byte $06		; 9-#, 6 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $82		; Note length = 2
	.byte $0C		; 3-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $84		; Note length = 4
	.byte $06		; 9-#, 4 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $82		; Note length = 2
	.byte $0D		; 2-#, 2 ticks
	.byte $0D		; 2-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $84		; Note length = 4
	.byte $06		; 9-#, 4 ticks
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 4 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $0C		; 3-#, 2 ticks
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 2 ticks

; ---- FRAME 07 END ($0050 bytes) ----

; -------- FRAME 08 --------
	@frame_08:
	.byte $85		; Note length = 5
	.byte $08		; 7-#, 5 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $83		; Note length = 3
	.byte $06		; 9-#, 3 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $81		; Note length = 1
	.byte $0D		; 2-#, 1 tick
	.byte $0D		; 2-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $81		; Note length = 1
	.byte $06		; 9-#, 1 tick
	.byte $F8, $0B	; VOL ENV Bongo
	.byte $FB, $07	; ARPEGGIO Bongo
	.byte $0C		; 3-#, 1 tick
	.byte $F8, $01	; VOL ENV Snare Noise Enhance
	.byte $FB, $03	; ARPEGGIO Snare Noise Enhance
	.byte $08		; 7-#, 1 tick
	.byte $08		; 7-#, 1 tick
	.byte $F1		; END SEGMENT
