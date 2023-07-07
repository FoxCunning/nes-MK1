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

	.byte $F0	; CALL
	.word @pattern_00
	@loop:
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F0	; CALL
	.word @pattern_04
	.byte $F0	; CALL
	.word @pattern_05
	.byte $F0	; CALL
	.word @pattern_06
	.byte $F0	; CALL
	.word @pattern_07
	.byte $F4	; JUMP
	.word @loop

	@pattern_00:
	.byte $F8, $1A	; Volume Envelope = "Warrior Synth"
	.byte $F9, $08	; Duty Envelope = "Warrior Synth"
	.byte $FA, $04	; Pitch Envelope = "Warrior Synth"
	.byte $FB, $FF	; Arpeggio = "Warrior Synth"
	.byte $9E	; Duration = 30
	.byte $39	; A-4
	.byte $81	; Duration = 1
	.byte $38	; G#4
	.byte $38	; G#4
	.byte $9E	; Duration = 30
	.byte $39	; A-4
	.byte $81	; Duration = 1
	.byte $38	; G#4
	.byte $38	; G#4
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_01:
	.byte $F8, $1A	; Volume Envelope = "Warrior Synth"
	.byte $F9, $08	; Duty Envelope = "Warrior Synth"
	.byte $FA, $04	; Pitch Envelope = "Warrior Synth"
	.byte $FB, $FF	; Arpeggio = "Warrior Synth"
	.byte $90	; Duration = 16
	.byte $2D	; A-3
	.byte $88	; Duration = 8
	.byte $2C	; G#3
	.byte $A8	; Duration = 40
	.byte $28	; E-3
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_02:
	.byte $F8, $1A	; Volume Envelope = "Warrior Synth"
	.byte $F9, $08	; Duty Envelope = "Warrior Synth"
	.byte $FA, $04	; Pitch Envelope = "Warrior Synth"
	.byte $FB, $FF	; Arpeggio = "Warrior Synth"
	.byte $98	; Duration = 24
	.byte $26	; D-3
	.byte $81	; Duration = 1
	.byte $2D	; A-3
	.byte $2C	; G#3
	.byte $28	; E-3
	.byte $25	; C#3
	.byte $2C	; G#3
	.byte $2B	; G-3
	.byte $27	; D#3
	.byte $A1	; Duration = 33
	.byte $25	; C#3
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_03:
	.byte $F8, $1A	; Volume Envelope = "Warrior Synth"
	.byte $F9, $08	; Duty Envelope = "Warrior Synth"
	.byte $FA, $04	; Pitch Envelope = "Warrior Synth"
	.byte $FB, $FF	; Arpeggio = "Warrior Synth"
	.byte $88	; Duration = 8
	.byte $21	; A-2
	.byte $2D	; A-3
	.byte $22	; A#2
	.byte $84	; Duration = 4
	.byte $2B	; G-3
	.byte $81	; Duration = 1
	.byte $24	; C-3
	.byte $21	; A-2
	.byte $1F	; G-2
	.byte $1D	; F-2
	.byte $88	; Duration = 8
	.byte $2D	; A-3
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $F8, $1D	; Volume Envelope = "Double Pluck"
	.byte $F9, $09	; Duty Envelope = "Double Pluck"
	.byte $FA, $FF	; Pitch Envelope = "Double Pluck"
	.byte $81	; Duration = 1
	.byte $21	; A-2
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $21	; A-2
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $21	; A-2
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $21	; A-2
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $26	; D-3
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $26	; D-3
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $26	; D-3
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $26	; D-3
	.byte $F6, $04, $02	; TRANSPOSE = 4, 2
	.byte $2B	; G-3
	.byte $F6, $04, $02	; TRANSPOSE = 4, 2
	.byte $2B	; G-3
	.byte $F6, $04, $02	; TRANSPOSE = 4, 2
	.byte $2B	; G-3
	.byte $F6, $04, $02	; TRANSPOSE = 4, 2
	.byte $2B	; G-3
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $2D	; A-3
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $2D	; A-3
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $2D	; A-3
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $2D	; A-3
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $32	; D-4
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $32	; D-4
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $32	; D-4
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $32	; D-4
	.byte $F6, $03, $FE	; TRANSPOSE = 3, 254
	.byte $32	; D-4
	.byte $F6, $03, $FF	; TRANSPOSE = 3, 255
	.byte $2E	; A#3
	.byte $F6, $03, $FE	; TRANSPOSE = 3, 254
	.byte $2B	; G-3
	.byte $F6, $03, $FF	; TRANSPOSE = 3, 255
	.byte $27	; D#3
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_04:
	.byte $F8, $09	; Volume Envelope = "Pluck"
	.byte $F9, $02	; Duty Envelope = "Pluck"
	.byte $FA, $FF	; Pitch Envelope = "Pluck"
	.byte $FB, $FF	; Arpeggio = "Pluck"
	.byte $81	; Duration = 1
	.byte $26	; D-3
	.byte $27	; D#3
	.byte $26	; D-3
	.byte $2E	; A#3
	.byte $2D	; A-3
	.byte $2B	; G-3
	.byte $29	; F-3
	.byte $27	; D#3
	.byte $24	; C-3
	.byte $25	; C#3
	.byte $24	; C-3
	.byte $2C	; G#3
	.byte $2B	; G-3
	.byte $29	; F-3
	.byte $27	; D#3
	.byte $25	; C#3
	.byte $84	; Duration = 4
	.byte $26	; D-3
	.byte $F6, $04, $02	; TRANSPOSE = 4, 2
	.byte $F8, $11	; Volume Envelope = "Synth 2"
	.byte $F9, $06	; Duty Envelope = "Synth 2"
	.byte $FA, $02	; Pitch Envelope = "Synth 2"
	.byte $88	; Duration = 8
	.byte $1F	; G-2
	.byte $84	; Duration = 4
	.byte $2B	; G-3
	.byte $A0	; Duration = 32
	.byte $32	; D-4
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_05:
	.byte $F8, $07	; Volume Envelope = "Pulse Bass"
	.byte $F9, $01	; Duty Envelope = "Pulse Bass"
	.byte $FA, $FF	; Pitch Envelope = "Pulse Bass"
	.byte $FB, $FF	; Arpeggio = "Pulse Bass"
	.byte $98	; Duration = 24
	.byte $0E	; D-1
	.byte $84	; Duration = 4
	.byte $0F	; D#1
	.byte $13	; G-1
	.byte $F7	; SKIP
	; Should force all channels to loop back to order 01
	; Pattern duration: 32.

	@pattern_06:
	.byte $F8, $09	; Volume Envelope = "Pluck"
	.byte $F9, $02	; Duty Envelope = "Pluck"
	.byte $FA, $FF	; Pitch Envelope = "Pluck"
	.byte $FB, $FF	; Arpeggio = "Pluck"
	.byte $82	; Duration = 2
	.byte $2D	; A-3
	.byte $84	; Duration = 4
	.byte $2D	; A-3
	.byte $82	; Duration = 2
	.byte $2D	; A-3
	.byte $8A	; Duration = 10
	.byte $2D	; A-3
	.byte $82	; Duration = 2
	.byte $2D	; A-3
	.byte $84	; Duration = 4
	.byte $2D	; A-3
	.byte $81	; Duration = 1
	.byte $2E	; A#3
	.byte $2D	; A-3
	.byte $82	; Duration = 2
	.byte $2B	; G-3
	.byte $81	; Duration = 1
	.byte $2F	; B-3
	.byte $2E	; A#3
	.byte $82	; Duration = 2
	.byte $2A	; F#3
	.byte $2D	; A-3
	.byte $84	; Duration = 4
	.byte $2D	; A-3
	.byte $82	; Duration = 2
	.byte $2D	; A-3
	.byte $8A	; Duration = 10
	.byte $2D	; A-3
	.byte $82	; Duration = 2
	.byte $2D	; A-3
	.byte $84	; Duration = 4
	.byte $2D	; A-3
	.byte $81	; Duration = 1
	.byte $2E	; A#3
	.byte $2D	; A-3
	.byte $82	; Duration = 2
	.byte $2B	; G-3
	.byte $81	; Duration = 1
	.byte $2F	; B-3
	.byte $2E	; A#3
	.byte $82	; Duration = 2
	.byte $2A	; F#3
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_07:
	.byte $F8, $06	; Volume Envelope = "Synth Echo"
	.byte $F9, $00	; Duty Envelope = "Synth Echo"
	.byte $FA, $FF	; Pitch Envelope = "Synth Echo"
	.byte $FB, $FF	; Arpeggio = "Synth Echo"
	.byte $82	; Duration = 2
	.byte $2D	; A-3
	.byte $F8, $09	; Volume Envelope = "Pluck"
	.byte $F9, $02	; Duty Envelope = "Pluck"
	.byte $84	; Duration = 4
	.byte $2D	; A-3
	.byte $82	; Duration = 2
	.byte $2D	; A-3
	.byte $8A	; Duration = 10
	.byte $2D	; A-3
	.byte $82	; Duration = 2
	.byte $2D	; A-3
	.byte $84	; Duration = 4
	.byte $2D	; A-3
	.byte $81	; Duration = 1
	.byte $2E	; A#3
	.byte $2D	; A-3
	.byte $82	; Duration = 2
	.byte $2B	; G-3
	.byte $81	; Duration = 1
	.byte $2F	; B-3
	.byte $2E	; A#3
	.byte $82	; Duration = 2
	.byte $2A	; F#3
	.byte $39	; A-4
	.byte $84	; Duration = 4
	.byte $39	; A-4
	.byte $82	; Duration = 2
	.byte $39	; A-4
	.byte $8A	; Duration = 10
	.byte $39	; A-4
	.byte $82	; Duration = 2
	.byte $39	; A-4
	.byte $84	; Duration = 4
	.byte $39	; A-4
	.byte $81	; Duration = 1
	.byte $3A	; A#4
	.byte $39	; A-4
	.byte $82	; Duration = 2
	.byte $37	; G-4
	.byte $81	; Duration = 1
	.byte $3B	; B-4
	.byte $3A	; A#4
	.byte $36	; F#4
	.byte $01	; HOLD
	.byte $F1	; RETURN
	; Pattern duration: 64.

; -----------------------------------------------------------------------------
;						SQUARE WAVE 1 CHANNEL
; -----------------------------------------------------------------------------

channel_01:
	.byte $F5, $07	; Speed = 7
	
	.byte $F0	; CALL
	.word @pattern_00
	@loop:
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F0	; CALL
	.word @pattern_04
	.byte $F0	; CALL
	.word @pattern_05
	.byte $F0	; CALL
	.word @pattern_06
	.byte $F0	; CALL
	.word @pattern_07
	.byte $F4	; JUMP
	.word @loop

	@pattern_00:
	.byte $F8, $1B	; Volume Envelope = "Warrior Synth 2"
	.byte $F9, $08	; Duty Envelope = "Warrior Synth 2"
	.byte $FA, $04	; Pitch Envelope = "Warrior Synth 2"
	.byte $FB, $FF	; Arpeggio = "Warrior Synth 2"
	.byte $9E	; Duration = 30
	.byte $34	; E-4
	.byte $81	; Duration = 1
	.byte $33	; D#4
	.byte $33	; D#4
	.byte $9E	; Duration = 30
	.byte $34	; E-4
	.byte $81	; Duration = 1
	.byte $33	; D#4
	.byte $33	; D#4
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_01:
	.byte $F8, $1B	; Volume Envelope = "Warrior Synth 2"
	.byte $F9, $08	; Duty Envelope = "Warrior Synth 2"
	.byte $FA, $04	; Pitch Envelope = "Warrior Synth 2"
	.byte $FB, $FF	; Arpeggio = "Warrior Synth 2"
	.byte $90	; Duration = 16
	.byte $29	; F-3
	.byte $88	; Duration = 8
	.byte $28	; E-3
	.byte $25	; C#3
	.byte $F7	; SKIP

	; Pattern duration: 32.

	@pattern_02:
	.byte $F8, $1B	; Volume Envelope = "Warrior Synth 2"
	.byte $F9, $08	; Duty Envelope = "Warrior Synth 2"
	.byte $FA, $04	; Pitch Envelope = "Warrior Synth 2"
	.byte $FB, $FF	; Arpeggio = "Warrior Synth 2"
	.byte $98	; Duration = 24
	.byte $21	; A-2
	.byte $81	; Duration = 1
	.byte $28	; E-3
	.byte $27	; D#3
	.byte $25	; C#3
	.byte $23	; B-2
	.byte $27	; D#3
	.byte $26	; D-3
	.byte $22	; A#2
	.byte $20	; G#2
	.byte $F7	; SKIP
	; Pattern duration: 32.

	@pattern_03:
	.byte $F8, $1B	; Volume Envelope = "Warrior Synth 2"
	.byte $F9, $08	; Duty Envelope = "Warrior Synth 2"
	.byte $FA, $04	; Pitch Envelope = "Warrior Synth 2"
	.byte $FB, $FF	; Arpeggio = "Warrior Synth 2"
	.byte $88	; Duration = 8
	.byte $26	; D-3
	.byte $29	; F-3
	.byte $27	; D#3
	.byte $84	; Duration = 4
	.byte $2E	; A#3
	.byte $81	; Duration = 1
	.byte $27	; D#3
	.byte $26	; D-3
	.byte $24	; C-3
	.byte $21	; A-2
	.byte $8B	; Duration = 11
	.byte $32	; D-4
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $F8, $1E	; Volume Envelope = "Double Pluck Echo"
	.byte $F9, $09	; Duty Envelope = "Double Pluck Echo"
	.byte $FA, $FF	; Pitch Envelope = "Double Pluck Echo"
	.byte $81	; Duration = 1
	.byte $21	; A-2
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $21	; A-2
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $21	; A-2
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $21	; A-2
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $26	; D-3
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $26	; D-3
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $26	; D-3
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $26	; D-3
	.byte $F6, $04, $02	; TRANSPOSE = 4, 2
	.byte $2B	; G-3
	.byte $F6, $04, $02	; TRANSPOSE = 4, 2
	.byte $2B	; G-3
	.byte $F6, $04, $02	; TRANSPOSE = 4, 2
	.byte $2B	; G-3
	.byte $F6, $04, $02	; TRANSPOSE = 4, 2
	.byte $2B	; G-3
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $2D	; A-3
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $2D	; A-3
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $2D	; A-3
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $2D	; A-3
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $32	; D-4
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $32	; D-4
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $32	; D-4
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $32	; D-4
	.byte $F6, $03, $FE	; TRANSPOSE = 3, 254
	.byte $32	; D-4
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_04:
	.byte $F6, $03, $FF	; TRANSPOSE = 3, 255
	.byte $F8, $0A	; Volume Envelope = "Pluck (Quiet)"
	.byte $F9, $02	; Duty Envelope = "Pluck (Quiet)"
	.byte $FA, $FF	; Pitch Envelope = "Pluck (Quiet)"
	.byte $FB, $FF	; Arpeggio = "Pluck (Quiet)"
	.byte $81	; Duration = 1
	.byte $2E	; A#3
	.byte $F6, $03, $FE	; TRANSPOSE = 3, 254
	.byte $2B	; G-3
	.byte $F6, $03, $FF	; TRANSPOSE = 3, 255
	.byte $27	; D#3
	.byte $26	; D-3
	.byte $27	; D#3
	.byte $26	; D-3
	.byte $2E	; A#3
	.byte $2D	; A-3
	.byte $2B	; G-3
	.byte $29	; F-3
	.byte $27	; D#3
	.byte $24	; C-3
	.byte $25	; C#3
	.byte $24	; C-3
	.byte $2C	; G#3
	.byte $2B	; G-3
	.byte $29	; F-3
	.byte $27	; D#3
	.byte $25	; C#3
	.byte $26	; D-3
	.byte $F6, $04, $02	; TRANSPOSE = 4, 2
	.byte $F8, $14	; Volume Envelope = "Synth 2 Echo"
	.byte $F9, $06	; Duty Envelope = "Synth 2 Echo"
	.byte $FA, $02	; Pitch Envelope = "Synth 2 Echo"
	.byte $88	; Duration = 8
	.byte $24	; C-3
	.byte $84	; Duration = 4
	.byte $2E	; A#3
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $A0	; Duration = 32
	.byte $2C	; G#3
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_05:
	.byte $C0	; Duration = 64
	.byte $00	; REST
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_06:
	.byte $F8, $09	; Volume Envelope = "Pluck"
	.byte $F9, $02	; Duty Envelope = "Pluck"
	.byte $FA, $FF	; Pitch Envelope = "Pluck"
	.byte $FB, $FF	; Arpeggio = "Pluck"
	.byte $82	; Duration = 2
	.byte $26	; D-3
	.byte $84	; Duration = 4
	.byte $26	; D-3
	.byte $82	; Duration = 2
	.byte $26	; D-3
	.byte $8A	; Duration = 10
	.byte $26	; D-3
	.byte $82	; Duration = 2
	.byte $26	; D-3
	.byte $84	; Duration = 4
	.byte $26	; D-3
	.byte $81	; Duration = 1
	.byte $27	; D#3
	.byte $26	; D-3
	.byte $82	; Duration = 2
	.byte $24	; C-3
	.byte $81	; Duration = 1
	.byte $2B	; G-3
	.byte $29	; F-3
	.byte $82	; Duration = 2
	.byte $27	; D#3
	.byte $26	; D-3
	.byte $84	; Duration = 4
	.byte $26	; D-3
	.byte $82	; Duration = 2
	.byte $26	; D-3
	.byte $8A	; Duration = 10
	.byte $26	; D-3
	.byte $82	; Duration = 2
	.byte $26	; D-3
	.byte $84	; Duration = 4
	.byte $26	; D-3
	.byte $81	; Duration = 1
	.byte $27	; D#3
	.byte $26	; D-3
	.byte $82	; Duration = 2
	.byte $24	; C-3
	.byte $81	; Duration = 1
	.byte $2B	; G-3
	.byte $29	; F-3
	.byte $82	; Duration = 2
	.byte $27	; D#3
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_07:
	.byte $F8, $09	; Volume Envelope = "Pluck"
	.byte $F9, $02	; Duty Envelope = "Pluck"
	.byte $FA, $FF	; Pitch Envelope = "Pluck"
	.byte $FB, $FF	; Arpeggio = "Pluck"
	.byte $82	; Duration = 2
	.byte $32	; D-4
	.byte $84	; Duration = 4
	.byte $32	; D-4
	.byte $82	; Duration = 2
	.byte $32	; D-4
	.byte $8A	; Duration = 10
	.byte $32	; D-4
	.byte $82	; Duration = 2
	.byte $32	; D-4
	.byte $84	; Duration = 4
	.byte $32	; D-4
	.byte $81	; Duration = 1
	.byte $33	; D#4
	.byte $32	; D-4
	.byte $82	; Duration = 2
	.byte $30	; C-4
	.byte $81	; Duration = 1
	.byte $37	; G-4
	.byte $35	; F-4
	.byte $82	; Duration = 2
	.byte $33	; D#4
	.byte $32	; D-4
	.byte $84	; Duration = 4
	.byte $32	; D-4
	.byte $82	; Duration = 2
	.byte $32	; D-4
	.byte $8A	; Duration = 10
	.byte $32	; D-4
	.byte $82	; Duration = 2
	.byte $32	; D-4
	.byte $84	; Duration = 4
	.byte $32	; D-4
	.byte $81	; Duration = 1
	.byte $33	; D#4
	.byte $32	; D-4
	.byte $82	; Duration = 2
	.byte $30	; C-4
	.byte $81	; Duration = 1
	.byte $37	; G-4
	.byte $35	; F-4
	.byte $82	; Duration = 2
	.byte $33	; D#4
	.byte $F1	; RETURN
	; Pattern duration: 64.

; -----------------------------------------------------------------------------
;						TRIANGLE WAVE CHANNEL
; -----------------------------------------------------------------------------

channel_02:
	.byte $F5, $07	; Speed = 7
	
	.byte $F0	; CALL
	.word @pattern_00
	@loop:
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
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F0	; CALL
	.word @pattern_04
	.byte $F0	; CALL
	.word @pattern_05
	.byte $F0	; CALL
	.word @pattern_05
	.byte $F4	; JUMP
	.word @loop

	@pattern_00:
	.byte $FA, $FF	; Pitch Envelope = "Blank"
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $9E	; Duration = 30
	.byte $1A	; D-2
	.byte $82	; Duration = 2
	.byte $19	; C#2
	.byte $9E	; Duration = 30
	.byte $1A	; D-2
	.byte $82	; Duration = 2
	.byte $19	; C#2
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_01:
	.byte $FA, $FF	; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $84	; Duration = 4
	.byte $1A	; D-2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $82	; Duration = 2
	.byte $1A	; D-2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $84	; Duration = 4
	.byte $1D	; F-2
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $81	; Duration = 1
	.byte $1D	; F-2
	.byte $01	; HOLD
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $84	; Duration = 4
	.byte $1E	; F#2
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $82	; Duration = 2
	.byte $1E	; F#2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $1D	; F-2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $84	; Duration = 4
	.byte $1D	; F-2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $82	; Duration = 2
	.byte $1A	; D-2
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $81	; Duration = 1
	.byte $1A	; D-2
	.byte $01	; HOLD
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $83	; Duration = 3
	.byte $18	; C-2
	.byte $A1	; Duration = 33
	.byte $18	; C-2
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_02:
	.byte $FA, $FF	; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $82	; Duration = 2
	.byte $1A	; D-2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $26	; D-3
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $26	; D-3
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $1D	; F-2
	.byte $29	; F-3
	.byte $81	; Duration = 1
	.byte $01	; HOLD
	.byte $01	; HOLD
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $82	; Duration = 2
	.byte $1E	; F#2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $2A	; F#3
	.byte $01	; HOLD
	.byte $1D	; F-2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $84	; Duration = 4
	.byte $29	; F-3
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $82	; Duration = 2
	.byte $1A	; D-2
	.byte $81	; Duration = 1
	.byte $26	; D-3
	.byte $01	; HOLD
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $82	; Duration = 2
	.byte $18	; C-2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $81	; Duration = 1
	.byte $24	; C-3
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $A1	; Duration = 33
	.byte $24	; C-3
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_03:
	.byte $FA, $FF	; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $82	; Duration = 2
	.byte $1A	; D-2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $81	; Duration = 1
	.byte $26	; D-3
	.byte $1A	; D-2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $1A	; D-2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $1A	; D-2
	.byte $26	; D-3
	.byte $1A	; D-2
	.byte $82	; Duration = 2
	.byte $1D	; F-2
	.byte $81	; Duration = 1
	.byte $29	; F-3
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $1D	; F-2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $1D	; F-2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $1D	; F-2
	.byte $29	; F-3
	.byte $1D	; F-2
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $82	; Duration = 2
	.byte $1E	; F#2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $81	; Duration = 1
	.byte $2A	; F#3
	.byte $1E	; F#2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $1E	; F#2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $1E	; F#2
	.byte $2A	; F#3
	.byte $1B	; D#2
	.byte $82	; Duration = 2
	.byte $1D	; F-2
	.byte $81	; Duration = 1
	.byte $29	; F-3
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $1D	; F-2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $1D	; F-2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $1D	; F-2
	.byte $29	; F-3
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $18	; C-2
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $82	; Duration = 2
	.byte $1A	; D-2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $81	; Duration = 1
	.byte $26	; D-3
	.byte $1A	; D-2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $1A	; D-2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $1A	; D-2
	.byte $26	; D-3
	.byte $1A	; D-2
	.byte $82	; Duration = 2
	.byte $1D	; F-2
	.byte $81	; Duration = 1
	.byte $29	; F-3
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $1D	; F-2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $1D	; F-2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $1D	; F-2
	.byte $29	; F-3
	.byte $1D	; F-2
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $82	; Duration = 2
	.byte $1E	; F#2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $81	; Duration = 1
	.byte $2A	; F#3
	.byte $1E	; F#2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $1E	; F#2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $1E	; F#2
	.byte $2A	; F#3
	.byte $1B	; D#2
	.byte $82	; Duration = 2
	.byte $1D	; F-2
	.byte $81	; Duration = 1
	.byte $29	; F-3
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $1D	; F-2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $1D	; F-2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $1D	; F-2
	.byte $29	; F-3
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $18	; C-2
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_04:
	.byte $FA, $FF	; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $84	; Duration = 4
	.byte $1A	; D-2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $86	; Duration = 6
	.byte $1A	; D-2
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $81	; Duration = 1
	.byte $1A	; D-2
	.byte $1A	; D-2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $84	; Duration = 4
	.byte $1A	; D-2
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $1A	; D-2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $1A	; D-2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $82	; Duration = 2
	.byte $1B	; D#2
	.byte $FB, $00	; Arpeggio = "Tri Kick -> Bass"
	.byte $81	; Duration = 1
	.byte $1B	; D#2
	.byte $1B	; D#2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $83	; Duration = 3
	.byte $1F	; G-2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $A1	; Duration = 33
	.byte $1F	; G-2
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_05:
	.byte $FA, $FF	; Pitch Envelope = "Tri Snare -> Bass"
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $81	; Duration = 1
	.byte $1A	; D-2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $1A	; D-2
	.byte $1A	; D-2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $83	; Duration = 3
	.byte $00	; REST
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $81	; Duration = 1
	.byte $1A	; D-2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $1A	; D-2
	.byte $1A	; D-2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $89	; Duration = 9
	.byte $00	; REST
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $81	; Duration = 1
	.byte $1A	; D-2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $1A	; D-2
	.byte $1A	; D-2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $83	; Duration = 3
	.byte $00	; REST
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $82	; Duration = 2
	.byte $18	; C-2
	.byte $81	; Duration = 1
	.byte $22	; A#2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $82	; Duration = 2
	.byte $1B	; D#2
	.byte $81	; Duration = 1
	.byte $22	; A#2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $82	; Duration = 2
	.byte $18	; C-2
	.byte $81	; Duration = 1
	.byte $1A	; D-2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $1A	; D-2
	.byte $1A	; D-2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $83	; Duration = 3
	.byte $00	; REST
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $81	; Duration = 1
	.byte $1A	; D-2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $1A	; D-2
	.byte $1A	; D-2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $89	; Duration = 9
	.byte $00	; REST
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $81	; Duration = 1
	.byte $1A	; D-2
	.byte $F3, $02	; DELAYED CUT = 2
	.byte $1A	; D-2
	.byte $1A	; D-2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $83	; Duration = 3
	.byte $00	; REST
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $82	; Duration = 2
	.byte $18	; C-2
	.byte $81	; Duration = 1
	.byte $22	; A#2
	.byte $FB, $FF	; Arpeggio = "Blank"
	.byte $82	; Duration = 2
	.byte $1B	; D#2
	.byte $81	; Duration = 1
	.byte $22	; A#2
	.byte $FB, $01	; Arpeggio = "Tri Snare -> Bass"
	.byte $82	; Duration = 2
	.byte $18	; C-2
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_06:
	.byte $C0	; Duration = 64
	.byte $01	; HOLD
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_07:
	.byte $C0	; Duration = 64
	.byte $01	; HOLD
	.byte $F1	; RETURN
	; Pattern duration: 64.

; -----------------------------------------------------------------------------
;						        NOISE CHANNEL
; -----------------------------------------------------------------------------

channel_03:
	.byte $F5, $07	; Speed = 7
	
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
	.word @pattern_05
	.byte $F0	; CALL
	.word @pattern_05
	.byte $F0	; CALL
	.word @pattern_05
	.byte $F0	; CALL
	.word @pattern_04
	.byte $F0	; CALL
	.word @pattern_04
	.byte $F4	; JUMP
	.word @loop

	@pattern_00:
	.byte $F8, $08	; Volume Envelope = "Roll Drum"
	.byte $FB, $FF	; Arpeggio = "Roll Drum"
	.byte $82	; Duration = 2
	.byte $0E	; 1-#
	.byte $F2, $07	; NOTE DELAY = 7
	.byte $81	; Duration = 1
	.byte $0E	; 1-#
	.byte $F2, $03	; NOTE DELAY = 3
	.byte $0E	; 1-#
	.byte $82	; Duration = 2
	.byte $0E	; 1-#
	.byte $0E	; 1-#
	.byte $F2, $07	; NOTE DELAY = 7
	.byte $81	; Duration = 1
	.byte $0E	; 1-#
	.byte $F2, $03	; NOTE DELAY = 3
	.byte $0E	; 1-#
	.byte $82	; Duration = 2
	.byte $0E	; 1-#
	.byte $0E	; 1-#
	.byte $0E	; 1-#
	.byte $0E	; 1-#
	.byte $F2, $07	; NOTE DELAY = 7
	.byte $81	; Duration = 1
	.byte $0E	; 1-#
	.byte $F2, $03	; NOTE DELAY = 3
	.byte $0E	; 1-#
	.byte $82	; Duration = 2
	.byte $0E	; 1-#
	.byte $0E	; 1-#
	.byte $F2, $07	; NOTE DELAY = 7
	.byte $81	; Duration = 1
	.byte $0E	; 1-#
	.byte $F2, $03	; NOTE DELAY = 3
	.byte $0E	; 1-#
	.byte $82	; Duration = 2
	.byte $0E	; 1-#
	.byte $81	; Duration = 1
	.byte $0E	; 1-#
	.byte $0E	; 1-#
	.byte $82	; Duration = 2
	.byte $0E	; 1-#
	.byte $0E	; 1-#
	.byte $F2, $07	; NOTE DELAY = 7
	.byte $81	; Duration = 1
	.byte $0E	; 1-#
	.byte $F2, $03	; NOTE DELAY = 3
	.byte $0E	; 1-#
	.byte $82	; Duration = 2
	.byte $0E	; 1-#
	.byte $0E	; 1-#
	.byte $F2, $07	; NOTE DELAY = 7
	.byte $81	; Duration = 1
	.byte $0E	; 1-#
	.byte $F2, $03	; NOTE DELAY = 3
	.byte $0E	; 1-#
	.byte $82	; Duration = 2
	.byte $0E	; 1-#
	.byte $0E	; 1-#
	.byte $0E	; 1-#
	.byte $0E	; 1-#
	.byte $F2, $07	; NOTE DELAY = 7
	.byte $81	; Duration = 1
	.byte $0E	; 1-#
	.byte $F2, $03	; NOTE DELAY = 3
	.byte $0E	; 1-#
	.byte $82	; Duration = 2
	.byte $0E	; 1-#
	.byte $0E	; 1-#
	.byte $F2, $07	; NOTE DELAY = 7
	.byte $81	; Duration = 1
	.byte $0E	; 1-#
	.byte $F2, $03	; NOTE DELAY = 3
	.byte $0E	; 1-#
	.byte $82	; Duration = 2
	.byte $0E	; 1-#
	.byte $81	; Duration = 1
	.byte $0E	; 1-#
	.byte $0E	; 1-#
	.byte $82	; Duration = 2
	.byte $0E	; 1-#
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_01:
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $82	; Duration = 2
	.byte $06	; 9-#
	.byte $F8, $08	; Volume Envelope = "Roll Drum"
	.byte $FB, $FF	; Arpeggio = "Roll Drum"
	.byte $0E	; 1-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $09	; 6-#
	.byte $F8, $04	; Volume Envelope = "Hat 1"
	.byte $FB, $06	; Arpeggio = "Hat 1"
	.byte $03	; C-#
	.byte $F8, $08	; Volume Envelope = "Roll Drum"
	.byte $FB, $FF	; Arpeggio = "Roll Drum"
	.byte $0E	; 1-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $81	; Duration = 1
	.byte $06	; 9-#
	.byte $06	; 9-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $82	; Duration = 2
	.byte $09	; 6-#
	.byte $F8, $1C	; Volume Envelope = "Pop Drum"
	.byte $FB, $0A	; Arpeggio = "Pop Drum"
	.byte $0B	; 4-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $06	; 9-#
	.byte $F8, $08	; Volume Envelope = "Roll Drum"
	.byte $FB, $FF	; Arpeggio = "Roll Drum"
	.byte $0E	; 1-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $09	; 6-#
	.byte $F8, $04	; Volume Envelope = "Hat 1"
	.byte $FB, $06	; Arpeggio = "Hat 1"
	.byte $03	; C-#
	.byte $F8, $08	; Volume Envelope = "Roll Drum"
	.byte $FB, $FF	; Arpeggio = "Roll Drum"
	.byte $0E	; 1-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $81	; Duration = 1
	.byte $06	; 9-#
	.byte $06	; 9-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $82	; Duration = 2
	.byte $09	; 6-#
	.byte $F8, $1C	; Volume Envelope = "Pop Drum"
	.byte $FB, $0A	; Arpeggio = "Pop Drum"
	.byte $81	; Duration = 1
	.byte $0D	; 2-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $09	; 6-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $82	; Duration = 2
	.byte $06	; 9-#
	.byte $F8, $08	; Volume Envelope = "Roll Drum"
	.byte $FB, $FF	; Arpeggio = "Roll Drum"
	.byte $0E	; 1-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $09	; 6-#
	.byte $F8, $04	; Volume Envelope = "Hat 1"
	.byte $FB, $06	; Arpeggio = "Hat 1"
	.byte $03	; C-#
	.byte $F8, $08	; Volume Envelope = "Roll Drum"
	.byte $FB, $FF	; Arpeggio = "Roll Drum"
	.byte $0E	; 1-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $81	; Duration = 1
	.byte $06	; 9-#
	.byte $06	; 9-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $82	; Duration = 2
	.byte $09	; 6-#
	.byte $F8, $1C	; Volume Envelope = "Pop Drum"
	.byte $FB, $0A	; Arpeggio = "Pop Drum"
	.byte $0B	; 4-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $06	; 9-#
	.byte $F8, $08	; Volume Envelope = "Roll Drum"
	.byte $FB, $FF	; Arpeggio = "Roll Drum"
	.byte $0E	; 1-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $09	; 6-#
	.byte $F8, $04	; Volume Envelope = "Hat 1"
	.byte $FB, $06	; Arpeggio = "Hat 1"
	.byte $03	; C-#
	.byte $F8, $08	; Volume Envelope = "Roll Drum"
	.byte $FB, $FF	; Arpeggio = "Roll Drum"
	.byte $0E	; 1-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $81	; Duration = 1
	.byte $06	; 9-#
	.byte $06	; 9-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $82	; Duration = 2
	.byte $09	; 6-#
	.byte $F8, $1C	; Volume Envelope = "Pop Drum"
	.byte $FB, $0A	; Arpeggio = "Pop Drum"
	.byte $81	; Duration = 1
	.byte $0D	; 2-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $09	; 6-#
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_02:
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $81	; Duration = 1
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $84	; Duration = 4
	.byte $09	; 6-#
	.byte $81	; Duration = 1
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $8A	; Duration = 10
	.byte $09	; 6-#
	.byte $81	; Duration = 1
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $84	; Duration = 4
	.byte $09	; 6-#
	.byte $81	; Duration = 1
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $82	; Duration = 2
	.byte $09	; 6-#
	.byte $81	; Duration = 1
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $82	; Duration = 2
	.byte $09	; 6-#
	.byte $81	; Duration = 1
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $84	; Duration = 4
	.byte $09	; 6-#
	.byte $81	; Duration = 1
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $8A	; Duration = 10
	.byte $09	; 6-#
	.byte $81	; Duration = 1
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $84	; Duration = 4
	.byte $09	; 6-#
	.byte $81	; Duration = 1
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $82	; Duration = 2
	.byte $09	; 6-#
	.byte $81	; Duration = 1
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $82	; Duration = 2
	.byte $09	; 6-#
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_03:
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $FB, $FF	; Arpeggio = "Light Drum"
	.byte $81	; Duration = 1
	.byte $0A	; 5-#
	.byte $0B	; 4-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $0A	; 5-#
	.byte $0B	; 4-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $0A	; 5-#
	.byte $0B	; 4-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $0A	; 5-#
	.byte $0B	; 4-#
	.byte $0C	; 3-#
	.byte $0B	; 4-#
	.byte $0C	; 3-#
	.byte $0B	; 4-#
	.byte $0A	; 5-#
	.byte $0B	; 4-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $0E	; 1-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $0E	; 1-#
	.byte $0A	; 5-#
	.byte $0B	; 4-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $0A	; 5-#
	.byte $0B	; 4-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $0A	; 5-#
	.byte $0B	; 4-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $0A	; 5-#
	.byte $0B	; 4-#
	.byte $0C	; 3-#
	.byte $0B	; 4-#
	.byte $0C	; 3-#
	.byte $0B	; 4-#
	.byte $0A	; 5-#
	.byte $0B	; 4-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $0E	; 1-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $0E	; 1-#
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_04:
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $81	; Duration = 1
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $FB, $FF	; Arpeggio = "Light Drum"
	.byte $0D	; 2-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $FB, $FF	; Arpeggio = "Light Drum"
	.byte $0D	; 2-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $0A	; 5-#
	.byte $0B	; 4-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $FB, $FF	; Arpeggio = "Light Drum"
	.byte $0B	; 4-#
	.byte $0C	; 3-#
	.byte $0B	; 4-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $FB, $FF	; Arpeggio = "Light Drum"
	.byte $0D	; 2-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $FB, $FF	; Arpeggio = "Light Drum"
	.byte $0E	; 1-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $FB, $FF	; Arpeggio = "Light Drum"
	.byte $0D	; 2-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $FB, $FF	; Arpeggio = "Light Drum"
	.byte $0D	; 2-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $0A	; 5-#
	.byte $0B	; 4-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $0C	; 3-#
	.byte $0D	; 2-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $FB, $FF	; Arpeggio = "Light Drum"
	.byte $0B	; 4-#
	.byte $0C	; 3-#
	.byte $0B	; 4-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $FB, $FF	; Arpeggio = "Light Drum"
	.byte $0D	; 2-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $09	; 6-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $FB, $FF	; Arpeggio = "Light Drum"
	.byte $0E	; 1-#
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_05:
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $81	; Duration = 1
	.byte $06	; 9-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $FB, $FF	; Arpeggio = "Light Drum"
	.byte $0B	; 4-#
	.byte $F8, $08	; Volume Envelope = "Roll Drum"
	.byte $0E	; 1-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $0D	; 2-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $82	; Duration = 2
	.byte $09	; 6-#
	.byte $F8, $04	; Volume Envelope = "Hat 1"
	.byte $FB, $06	; Arpeggio = "Hat 1"
	.byte $81	; Duration = 1
	.byte $03	; C-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $FB, $FF	; Arpeggio = "Light Drum"
	.byte $0B	; 4-#
	.byte $F8, $08	; Volume Envelope = "Roll Drum"
	.byte $0E	; 1-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $0D	; 2-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $06	; 9-#
	.byte $06	; 9-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $82	; Duration = 2
	.byte $09	; 6-#
	.byte $F8, $1C	; Volume Envelope = "Pop Drum"
	.byte $FB, $0A	; Arpeggio = "Pop Drum"
	.byte $81	; Duration = 1
	.byte $0B	; 4-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $FB, $FF	; Arpeggio = "Light Drum"
	.byte $0D	; 2-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $06	; 9-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $FB, $FF	; Arpeggio = "Light Drum"
	.byte $0D	; 2-#
	.byte $F8, $08	; Volume Envelope = "Roll Drum"
	.byte $0E	; 1-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $0B	; 4-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $82	; Duration = 2
	.byte $09	; 6-#
	.byte $F8, $04	; Volume Envelope = "Hat 1"
	.byte $FB, $06	; Arpeggio = "Hat 1"
	.byte $81	; Duration = 1
	.byte $03	; C-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $FB, $FF	; Arpeggio = "Light Drum"
	.byte $0B	; 4-#
	.byte $F8, $08	; Volume Envelope = "Roll Drum"
	.byte $0E	; 1-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $0B	; 4-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $06	; 9-#
	.byte $06	; 9-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $82	; Duration = 2
	.byte $09	; 6-#
	.byte $F8, $1C	; Volume Envelope = "Pop Drum"
	.byte $FB, $0A	; Arpeggio = "Pop Drum"
	.byte $81	; Duration = 1
	.byte $0D	; 2-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $09	; 6-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $06	; 9-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $FB, $FF	; Arpeggio = "Light Drum"
	.byte $0B	; 4-#
	.byte $F8, $08	; Volume Envelope = "Roll Drum"
	.byte $0E	; 1-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $0D	; 2-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $82	; Duration = 2
	.byte $09	; 6-#
	.byte $F8, $04	; Volume Envelope = "Hat 1"
	.byte $FB, $06	; Arpeggio = "Hat 1"
	.byte $81	; Duration = 1
	.byte $03	; C-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $FB, $FF	; Arpeggio = "Light Drum"
	.byte $0B	; 4-#
	.byte $F8, $08	; Volume Envelope = "Roll Drum"
	.byte $0E	; 1-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $0D	; 2-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $06	; 9-#
	.byte $06	; 9-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $82	; Duration = 2
	.byte $09	; 6-#
	.byte $F8, $1C	; Volume Envelope = "Pop Drum"
	.byte $FB, $0A	; Arpeggio = "Pop Drum"
	.byte $81	; Duration = 1
	.byte $0B	; 4-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $FB, $FF	; Arpeggio = "Light Drum"
	.byte $0D	; 2-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $06	; 9-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $FB, $FF	; Arpeggio = "Light Drum"
	.byte $0D	; 2-#
	.byte $F8, $08	; Volume Envelope = "Roll Drum"
	.byte $0E	; 1-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $0B	; 4-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $82	; Duration = 2
	.byte $09	; 6-#
	.byte $F8, $04	; Volume Envelope = "Hat 1"
	.byte $FB, $06	; Arpeggio = "Hat 1"
	.byte $81	; Duration = 1
	.byte $03	; C-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $FB, $FF	; Arpeggio = "Light Drum"
	.byte $0B	; 4-#
	.byte $F8, $08	; Volume Envelope = "Roll Drum"
	.byte $0E	; 1-#
	.byte $F8, $1F	; Volume Envelope = "Light Drum"
	.byte $0B	; 4-#
	.byte $F8, $00	; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02	; Arpeggio = "Kick Noise Enhance"
	.byte $06	; 9-#
	.byte $06	; 9-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $82	; Duration = 2
	.byte $09	; 6-#
	.byte $F8, $1C	; Volume Envelope = "Pop Drum"
	.byte $FB, $0A	; Arpeggio = "Pop Drum"
	.byte $81	; Duration = 1
	.byte $0D	; 2-#
	.byte $F8, $0E	; Volume Envelope = "Snare 2"
	.byte $FB, $03	; Arpeggio = "Snare 2"
	.byte $09	; 6-#
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_06:
	.byte $C0	; Duration = 64
	.byte $01	; E-#
	.byte $F1	; RETURN
	; Pattern duration: 64.

	@pattern_07:
	.byte $C0	; Duration = 64
	.byte $01	; E-#
	.byte $F1	; RETURN
	; Pattern duration: 64.
