	.byte $00
	.word channel_00
	.byte $01
	.word channel_01
	.byte $02
	.word channel_02
	.byte $03
	.word channel_03
	.byte $FF

; -----------------------------------------------------------------------------
;						SQUARE WAVE 0 CHANNEL
; -----------------------------------------------------------------------------

channel_00:
	.byte $F5, $07	; Speed = 7
	@order_00:
	.byte $F0	; CALL
	.word @pattern_00
	@loop:
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F0	; CALL
	.word @pattern_04
	.byte $F0	; CALL
	.word @pattern_05
	.byte $F4	; JUMP
	.word @loop

	@pattern_00:
	.byte $C0	; Duration = 64
	.byte $01	; HOLD
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_01:
	.byte $92	; Duration = 18
	.byte $00	; REST
	.byte $F8, $09	; Volume Envelope = "Pluck"
	.byte $F9, $02	; Duty Envelope = "Pluck"
	.byte $FA, $FF	; Pitch Envelope = "Pluck"
	.byte $FB, $FF	; Arpeggio = "Pluck"
	.byte $84	; Duration = 4
	.byte $2D	; A-3
	.byte $F8, $0A	; Volume Envelope = "Pluck (Quiet)"
	.byte $9C	; Duration = 28
	.byte $2D	; A-3
	.byte $F8, $09	; Volume Envelope = "Pluck"
	.byte $84	; Duration = 4
	.byte $2D	; A-3
	.byte $F8, $0A	; Volume Envelope = "Pluck (Quiet)"
	.byte $8A	; Duration = 10
	.byte $2D	; A-3
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_02:
	.byte $F8, $11	; Volume Envelope = "Synth 2"
	.byte $F9, $06	; Duty Envelope = "Synth 2"
	.byte $FA, $02	; Pitch Envelope = "Synth 2"
	.byte $FB, $FF	; Arpeggio = "Synth 2"
	.byte $84	; Duration = 4
	.byte $21	; A-2
	.byte $24	; C-3
	.byte $25	; C#3
	.byte $27	; D#3
	.byte $82	; Duration = 2
	.byte $28	; E-3
	.byte $81	; Duration = 1
	.byte $2B	; G-3
	.byte $F2, $07	; NOTE DELAY = 7
	.byte $28	; E-3
	.byte $F2, $03	; NOTE DELAY = 3
	.byte $8C	; Duration = 12
	.byte $2A	; F#3
	.byte $84	; Duration = 4
	.byte $2C	; G#3
	.byte $81	; Duration = 1
	.byte $2A	; F#3
	.byte $29	; F-3
	.byte $84	; Duration = 4
	.byte $2C	; G#3
	.byte $81	; Duration = 1
	.byte $2A	; F#3
	.byte $29	; F-3
	.byte $2C	; G#3
	.byte $2D	; A-3
	.byte $30	; C-4
	.byte $8D	; Duration = 13
	.byte $33	; D#4
	.byte $84	; Duration = 4
	.byte $00	; REST
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_03:
	.byte $F8, $12	; Volume Envelope = "Bamboo Echo"
	.byte $F9, $04	; Duty Envelope = "Bamboo Echo"
	.byte $FA, $FF	; Pitch Envelope = "Bamboo Echo"
	.byte $FB, $FF	; Arpeggio = "Bamboo Echo"
	.byte $84	; Duration = 4
	.byte $1A	; D-2
	.byte $81	; Duration = 1
	.byte $26	; D-3
	.byte $25	; C#3
	.byte $82	; Duration = 2
	.byte $21	; A-2
	.byte $81	; Duration = 1
	.byte $24	; C-3
	.byte $23	; B-2
	.byte $82	; Duration = 2
	.byte $1F	; G-2
	.byte $81	; Duration = 1
	.byte $23	; B-2
	.byte $22	; A#2
	.byte $1E	; F#2
	.byte $83	; Duration = 3
	.byte $21	; A-2
	.byte $F8, $09	; Volume Envelope = "Pluck"
	.byte $F9, $02	; Duty Envelope = "Pluck"
	.byte $84	; Duration = 4
	.byte $2D	; A-3
	.byte $F8, $0A	; Volume Envelope = "Pluck (Quiet)"
	.byte $8A	; Duration = 10
	.byte $2D	; A-3
	.byte $F7	; SKIP
	; Pattern duration: 64.

	@pattern_04:
	.byte $F5, $03	; SPEED = 3
	.byte $F8, $11	; Volume Envelope = "Synth 2"
	.byte $F9, $06	; Duty Envelope = "Synth 2"
	.byte $FA, $02	; Pitch Envelope = "Synth 2"
	.byte $FB, $FF	; Arpeggio = "Synth 2"
	.byte $81	; Duration = 1
	.byte $32	; D-4
	.byte $F5, $04	; SPEED = 4
	.byte $33	; D#4
	.byte $F5, $03	; SPEED = 3
	.byte $32	; D-4
	.byte $F5, $04	; SPEED = 4
	.byte $33	; D#4
	.byte $F5, $03	; SPEED = 3
	.byte $32	; D-4
	.byte $F5, $04	; SPEED = 4
	.byte $33	; D#4
	.byte $F5, $03	; SPEED = 3
	.byte $32	; D-4
	.byte $F5, $04	; SPEED = 4
	.byte $33	; D#4
	.byte $F5, $03	; SPEED = 3
	.byte $32	; D-4
	.byte $F5, $04	; SPEED = 4
	.byte $31	; C#4
	.byte $F5, $03	; SPEED = 3
	.byte $30	; C-4
	.byte $F5, $04	; SPEED = 4
	.byte $2F	; B-3
	.byte $F5, $03	; SPEED = 3
	.byte $2E	; A#3
	.byte $F5, $04	; SPEED = 4
	.byte $2D	; A-3
	.byte $F5, $03	; SPEED = 3
	.byte $2C	; G#3
	.byte $F5, $04	; SPEED = 4
	.byte $2B	; G-3
	.byte $F5, $03	; SPEED = 3
	.byte $2A	; F#3
	.byte $F5, $04	; SPEED = 4
	.byte $2B	; G-3
	.byte $F5, $03	; SPEED = 3
	.byte $2A	; F#3
	.byte $F5, $04	; SPEED = 4
	.byte $2B	; G-3
	.byte $F5, $03	; SPEED = 3
	.byte $2A	; F#3
	.byte $F5, $04	; SPEED = 4
	.byte $2B	; G-3
	.byte $F5, $03	; SPEED = 3
	.byte $2A	; F#3
	.byte $F5, $04	; SPEED = 4
	.byte $2B	; G-3
	.byte $F5, $03	; SPEED = 3
	.byte $2A	; F#3
	.byte $F5, $04	; SPEED = 4
	.byte $29	; F-3
	.byte $F5, $03	; SPEED = 3
	.byte $28	; E-3
	.byte $F5, $04	; SPEED = 4
	.byte $27	; D#3
	.byte $F5, $03	; SPEED = 3
	.byte $26	; D-3
	.byte $F5, $04	; SPEED = 4
	.byte $25	; C#3
	.byte $F5, $03	; SPEED = 3
	.byte $24	; C-3
	.byte $F5, $04	; SPEED = 4
	.byte $23	; B-2
	.byte $F5, $03	; SPEED = 3
	.byte $22	; A#2
	.byte $F5, $04	; SPEED = 4
	.byte $21	; A-2
	.byte $F5, $03	; SPEED = 3
	.byte $20	; G#2
	.byte $F5, $04	; SPEED = 4
	.byte $01	; HOLD
	.byte $F5, $03	; SPEED = 3
	.byte $01	; HOLD
	.byte $F5, $04	; SPEED = 4
	.byte $01	; HOLD
	.byte $F5, $03	; SPEED = 3
	.byte $01	; HOLD
	.byte $F5, $04	; SPEED = 4
	.byte $01	; HOLD
	.byte $F5, $03	; SPEED = 3
	.byte $01	; HOLD
	.byte $F5, $04	; SPEED = 4
	.byte $01	; HOLD
	.byte $F5, $03	; SPEED = 3
	.byte $01	; HOLD
	.byte $F5, $04	; SPEED = 4
	.byte $01	; HOLD
	.byte $F5, $03	; SPEED = 3
	.byte $01	; HOLD
	.byte $F5, $04	; SPEED = 4
	.byte $01	; HOLD
	.byte $F5, $03	; SPEED = 3
	.byte $01	; HOLD
	.byte $F5, $04	; SPEED = 4
	.byte $01	; HOLD
	.byte $F5, $03	; SPEED = 3
	.byte $01	; HOLD
	.byte $F5, $04	; SPEED = 4
	.byte $01	; HOLD
	.byte $F5, $03	; SPEED = 3
	.byte $01	; HOLD
	.byte $F5, $04	; SPEED = 4
	.byte $01	; HOLD
	.byte $F5, $03	; SPEED = 3
	.byte $01	; HOLD
	.byte $F5, $04	; SPEED = 4
	.byte $01	; HOLD
	.byte $F5, $03	; SPEED = 3
	.byte $01	; HOLD
	.byte $F5, $04	; SPEED = 4
	.byte $01	; HOLD
	.byte $F5, $03	; SPEED = 3
	.byte $01	; HOLD
	.byte $F5, $04	; SPEED = 4
	.byte $01	; HOLD
	.byte $F5, $03	; SPEED = 3
	.byte $01	; HOLD
	.byte $F5, $04	; SPEED = 4
	.byte $01	; HOLD
	.byte $F5, $03	; SPEED = 3
	.byte $01	; HOLD
	.byte $F5, $04	; SPEED = 4
	.byte $01	; HOLD
	.byte $F5, $03	; SPEED = 3
	.byte $01	; HOLD
	.byte $F5, $04	; SPEED = 4
	.byte $01	; HOLD
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_05:
	.byte $F5, $07	; SPEED = 7
	.byte $F8, $11	; Volume Envelope = "Synth 2"
	.byte $F9, $06	; Duty Envelope = "Synth 2"
	.byte $FA, $02	; Pitch Envelope = "Synth 2"
	.byte $FB, $FF	; Arpeggio = "Synth 2"
	.byte $92	; Duration = 18
	.byte $1E	; F#2
	.byte $F8, $09	; Volume Envelope = "Pluck"
	.byte $F9, $02	; Duty Envelope = "Pluck"
	.byte $FA, $FF	; Pitch Envelope = "Pluck"
	.byte $84	; Duration = 4
	.byte $2D	; A-3
	.byte $F8, $0A	; Volume Envelope = "Pluck (Quiet)"
	.byte $8A	; Duration = 10
	.byte $2D	; A-3
	.byte $F7	; SKIP
	; Should loop back to order 1
	; Pattern duration: 32.

; -----------------------------------------------------------------------------
;						SQUARE WAVE 1 CHANNEL
; -----------------------------------------------------------------------------

channel_01:
	.byte $F5, $07	; Speed = 7
	@order_01:
	.byte $F0	; CALL
	.word @pattern_00
	@loop:
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F0	; CALL
	.word @pattern_04
	.byte $F4	; JUMP
	.word @loop

	@pattern_00:
	.byte $F8, $07	; Volume Envelope = "Pulse Bass"
	.byte $F9, $01	; Duty Envelope = "Pulse Bass"
	.byte $FA, $FF	; Pitch Envelope = "Pulse Bass"
	.byte $FB, $FF	; Arpeggio = "Pulse Bass"
	.byte $C0	; Duration = 64
	.byte $0E	; D-1
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_01:
	.byte $F8, $05	; Volume Envelope = "Synth Lead"
	.byte $F9, $00	; Duty Envelope = "Synth Lead"
	.byte $FA, $FF	; Pitch Envelope = "Synth Lead"
	.byte $FB, $FF	; Arpeggio = "Synth Lead"
	.byte $84	; Duration = 4
	.byte $1A	; D-2
	.byte $1D	; F-2
	.byte $1E	; F#2
	.byte $1D	; F-2
	.byte $82	; Duration = 2
	.byte $1A	; D-2
	.byte $F8, $09	; Volume Envelope = "Pluck"
	.byte $F9, $02	; Duty Envelope = "Pluck"
	.byte $84	; Duration = 4
	.byte $32	; D-4
	.byte $F8, $0A	; Volume Envelope = "Pluck (Quiet)"
	.byte $8A	; Duration = 10
	.byte $32	; D-4
	.byte $F8, $05	; Volume Envelope = "Synth Lead"
	.byte $F9, $00	; Duty Envelope = "Synth Lead"
	.byte $84	; Duration = 4
	.byte $1A	; D-2
	.byte $1D	; F-2
	.byte $1E	; F#2
	.byte $1D	; F-2
	.byte $82	; Duration = 2
	.byte $1A	; D-2
	.byte $F8, $09	; Volume Envelope = "Pluck"
	.byte $F9, $02	; Duty Envelope = "Pluck"
	.byte $84	; Duration = 4
	.byte $32	; D-4
	.byte $F8, $0A	; Volume Envelope = "Pluck (Quiet)"
	.byte $8A	; Duration = 10
	.byte $32	; D-4
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_02:
	.byte $F8, $14	; Volume Envelope = "Synth 2 Echo"
	.byte $F9, $06	; Duty Envelope = "Synth 2 Echo"
	.byte $FA, $02	; Pitch Envelope = "Synth 2 Echo"
	.byte $FB, $FF	; Arpeggio = "Synth 2 Echo"
	.byte $84	; Duration = 4
	.byte $26	; D-3
	.byte $29	; F-3
	.byte $2A	; F#3
	.byte $2C	; G#3
	.byte $82	; Duration = 2
	.byte $2D	; A-3
	.byte $81	; Duration = 1
	.byte $30	; C-4
	.byte $F2, $07	; NOTE DELAY = 7
	.byte $2D	; A-3
	.byte $F2, $03	; NOTE DELAY = 3
	.byte $8C	; Duration = 12
	.byte $2F	; B-3
	.byte $84	; Duration = 4
	.byte $2F	; B-3
	.byte $81	; Duration = 1
	.byte $2D	; A-3
	.byte $2C	; G#3
	.byte $84	; Duration = 4
	.byte $2F	; B-3
	.byte $81	; Duration = 1
	.byte $2D	; A-3
	.byte $2C	; G#3
	.byte $2F	; B-3
	.byte $30	; C-4
	.byte $33	; D#4
	.byte $8B	; Duration = 11
	.byte $36	; F#4
	.byte $86	; Duration = 6
	.byte $00	; REST
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_03:
	.byte $83	; Duration = 3
	.byte $01	; HOLD
	.byte $F8, $14	; Volume Envelope = "Synth 2 Echo"
	.byte $F9, $06	; Duty Envelope = "Synth 2 Echo"
	.byte $FA, $02	; Pitch Envelope = "Synth 2 Echo"
	.byte $FB, $FF	; Arpeggio = "Synth 2 Echo"
	.byte $81	; Duration = 1
	.byte $32	; D-4
	.byte $33	; D#4
	.byte $32	; D-4
	.byte $33	; D#4
	.byte $32	; D-4
	.byte $33	; D#4
	.byte $32	; D-4
	.byte $33	; D#4
	.byte $32	; D-4
	.byte $31	; C#4
	.byte $30	; C-4
	.byte $2F	; B-3
	.byte $2E	; A#3
	.byte $2D	; A-3
	.byte $2C	; G#3
	.byte $2B	; G-3
	.byte $2A	; F#3
	.byte $2B	; G-3
	.byte $2A	; F#3
	.byte $2B	; G-3
	.byte $2A	; F#3
	.byte $2B	; G-3
	.byte $2A	; F#3
	.byte $2B	; G-3
	.byte $2A	; F#3
	.byte $29	; F-3
	.byte $28	; E-3
	.byte $27	; D#3
	.byte $26	; D-3
	.byte $25	; C#3
	.byte $24	; C-3
	.byte $23	; B-2
	.byte $22	; A#2
	.byte $21	; A-2
	.byte $9B	; Duration = 27
	.byte $20	; G#2
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_04:
	.byte $83	; Duration = 3
	.byte $01	; HOLD
	.byte $F8, $14	; Volume Envelope = "Synth 2 Echo"
	.byte $F9, $06	; Duty Envelope = "Synth 2 Echo"
	.byte $FA, $02	; Pitch Envelope = "Synth 2 Echo"
	.byte $FB, $FF	; Arpeggio = "Synth 2 Echo"
	.byte $8F	; Duration = 15
	.byte $1E	; F#2
	.byte $F8, $09	; Volume Envelope = "Pluck"
	.byte $F9, $02	; Duty Envelope = "Pluck"
	.byte $FA, $FF	; Pitch Envelope = "Pluck"
	.byte $84	; Duration = 4
	.byte $32	; D-4
	.byte $F8, $0A	; Volume Envelope = "Pluck (Quiet)"
	.byte $AA	; Duration = 42
	.byte $32	; D-4
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_05:
	.byte $C0	; Duration = 64
	.byte $01	; HOLD
	.byte $F1	; RETURN
	; Pattern duration: 64.

; -----------------------------------------------------------------------------
;						TRIANGLE WAVE CHANNEL
; -----------------------------------------------------------------------------

channel_02:
	.byte $F5, $07	; Speed = 7
	@order_02:
	.byte $F0	; CALL
	.word @pattern_00
	@loop:
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F4	; JUMP
	.word @loop

	@pattern_00:
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $FA, $FF	; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $84	; Duration = 4
	.byte $1A	; D-2
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $1A	; D-2
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $1A	; D-2
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $1A	; D-2
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $1A	; D-2
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $1A	; D-2
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $1A	; D-2
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $1A	; D-2
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $1A	; D-2
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $1A	; D-2
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $1A	; D-2
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $1A	; D-2
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $1A	; D-2
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $1A	; D-2
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $1A	; D-2
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $1A	; D-2
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_01:
	.byte $FA, $FF	; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $84	; Duration = 4
	.byte $1A	; D-2
	.byte $1D	; F-2
	.byte $1E	; F#2
	.byte $1D	; F-2
	.byte $82	; Duration = 2
	.byte $1A	; D-2
	.byte $00	; REST
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $84	; Duration = 4
	.byte $18	; C-2
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $82	; Duration = 2
	.byte $18	; C-2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $1A	; D-2
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $18	; C-2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $81	; Duration = 1
	.byte $1A	; D-2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $1A	; D-2
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $84	; Duration = 4
	.byte $1A	; D-2
	.byte $1D	; F-2
	.byte $1E	; F#2
	.byte $1D	; F-2
	.byte $82	; Duration = 2
	.byte $1A	; D-2
	.byte $00	; REST
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $84	; Duration = 4
	.byte $18	; C-2
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $82	; Duration = 2
	.byte $18	; C-2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $1A	; D-2
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $18	; C-2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $81	; Duration = 1
	.byte $1A	; D-2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $1A	; D-2
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_02:
	.byte $FA, $FF	; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $88	; Duration = 8
	.byte $1A	; D-2
	.byte $1D	; F-2
	.byte $1E	; F#2
	.byte $1D	; F-2
	.byte $84	; Duration = 4
	.byte $1A	; D-2
	.byte $00	; REST
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $88	; Duration = 8
	.byte $18	; C-2
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $84	; Duration = 4
	.byte $18	; C-2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $1A	; D-2
	.byte $F3, $05	; DELAYED CUT = 5
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $18	; C-2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $82	; Duration = 2
	.byte $1A	; D-2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $1A	; D-2
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_03:
	.byte $C0	; Duration = 64
	.byte $01	; HOLD
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_04:
	.byte $C0	; Duration = 64
	.byte $01	; HOLD
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_05:
	.byte $C0	; Duration = 64
	.byte $01	; HOLD
	.byte $F1	; RETURN
	; Pattern duration: 64.

; -----------------------------------------------------------------------------
;						        NOISE CHANNEL
; -----------------------------------------------------------------------------

channel_03:
	.byte $F5, $07	; Speed = 7
	@order_03:
	.byte $F0	; CALL
	.word @pattern_00
	@loop:
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F4	; JUMP
	.word @loop

	@pattern_00:
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $83	; Duration = 3
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0C	; 3-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $82	; Duration = 2
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0D	; 2-#
	.byte $0D	; 2-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $83	; Duration = 3
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0C	; 3-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $82	; Duration = 2
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0D	; 2-#
	.byte $0D	; 2-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $83	; Duration = 3
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0C	; 3-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $82	; Duration = 2
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0D	; 2-#
	.byte $0D	; 2-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $82	; Duration = 2
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $0C	; 3-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $81	; Duration = 1
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $0D	; 2-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $83	; Duration = 3
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0C	; 3-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $82	; Duration = 2
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0D	; 2-#
	.byte $0D	; 2-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $83	; Duration = 3
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0C	; 3-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $82	; Duration = 2
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0D	; 2-#
	.byte $0D	; 2-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $83	; Duration = 3
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0C	; 3-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $82	; Duration = 2
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0D	; 2-#
	.byte $0D	; 2-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $82	; Duration = 2
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0C	; 3-#
	.byte $F2, $07	; NOTE DELAY = 7
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $06	; 9-#
	.byte $F2, $07	; NOTE DELAY = 7
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $0C	; 3-#
	.byte $F2, $07	; NOTE DELAY = 7
	.byte $0D	; 2-#
	.byte $F2, $07	; NOTE DELAY = 7
	.byte $0D	; 2-#
	.byte $F2, $07	; NOTE DELAY = 7
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $06	; 9-#
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_01:
	.byte $83	; Duration = 3
	.byte $01	; E-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0C	; 3-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $82	; Duration = 2
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0D	; 2-#
	.byte $0D	; 2-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $83	; Duration = 3
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0C	; 3-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $82	; Duration = 2
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0D	; 2-#
	.byte $0D	; 2-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $83	; Duration = 3
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0C	; 3-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $82	; Duration = 2
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0D	; 2-#
	.byte $0D	; 2-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $82	; Duration = 2
	.byte $06	; 9-#
	.byte $F8, $01	; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03	; Arpeggio = "Snare Noise Enhance"
	.byte $08	; 7-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $81	; Duration = 1
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $0C	; 3-#
	.byte $F8, $01	; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03	; Arpeggio = "Snare Noise Enhance"
	.byte $08	; 7-#
	.byte $84	; Duration = 4
	.byte $08	; 7-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0C	; 3-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $82	; Duration = 2
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0D	; 2-#
	.byte $0D	; 2-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $83	; Duration = 3
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0C	; 3-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $82	; Duration = 2
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0D	; 2-#
	.byte $0D	; 2-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $83	; Duration = 3
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0C	; 3-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $82	; Duration = 2
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $81	; Duration = 1
	.byte $0D	; 2-#
	.byte $0D	; 2-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $82	; Duration = 2
	.byte $06	; 9-#
	.byte $F8, $01	; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03	; Arpeggio = "Snare Noise Enhance"
	.byte $08	; 7-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $81	; Duration = 1
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $0C	; 3-#
	.byte $F8, $01	; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03	; Arpeggio = "Snare Noise Enhance"
	.byte $08	; 7-#
	.byte $08	; 7-#
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_02:
	.byte $86	; Duration = 6
	.byte $01	; E-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $82	; Duration = 2
	.byte $0C	; 3-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $84	; Duration = 4
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $82	; Duration = 2
	.byte $0D	; 2-#
	.byte $0D	; 2-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $86	; Duration = 6
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $82	; Duration = 2
	.byte $0C	; 3-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $84	; Duration = 4
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $82	; Duration = 2
	.byte $0D	; 2-#
	.byte $0D	; 2-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $86	; Duration = 6
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $82	; Duration = 2
	.byte $0C	; 3-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $84	; Duration = 4
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $82	; Duration = 2
	.byte $0D	; 2-#
	.byte $0D	; 2-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $84	; Duration = 4
	.byte $06	; 9-#
	.byte $F8, $01	; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03	; Arpeggio = "Snare Noise Enhance"
	.byte $08	; 7-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $82	; Duration = 2
	.byte $06	; 9-#
	.byte $F8, $0B	; Volume Envelope = "Bongo"
	.byte $FB, $07	; Arpeggio = "Bongo"
	.byte $0C	; 3-#
	.byte $F8, $01	; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03	; Arpeggio = "Snare Noise Enhance"
	.byte $08	; 7-#
	.byte $08	; 7-#
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_03:
	.byte $C0	; Duration = 64
	.byte $01	; E-#
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_04:
	.byte $C0	; Duration = 64
	.byte $01	; E-#
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_05:
	.byte $C0	; Duration = 64
	.byte $01	; E-#
	.byte $F1	; RETURN
	; Pattern duration: 64.
