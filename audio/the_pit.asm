	.byte $00
	.word the_pit_ch_00
	.byte $01
	.word the_pit_ch_01
	.byte $02
	.word the_pit_ch_02
	.byte $03
	.word the_pit_ch_03
	.byte $FF

; -----------------------------------------------------------------------------
;						SQUARE WAVE 0 CHANNEL
; -----------------------------------------------------------------------------

the_pit_ch_00:
	.byte $F5, $07	; Speed = 7
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_00
	@order_00:
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F0	; CALL
	.word @pattern_04
	.byte $F4	; JUMP
	.word @order_00

	@pattern_00:
	.byte $F8, $11		; Volume Envelope = "Synth 2"
	.byte $F9, $06		; Duty Envelope = "Synth 2"
	.byte $FA, $02		; Pitch Envelope = "Synth 2"
	.byte $FB, $FF		; Arpeggio = "Synth 2"
	.byte $90			; Duration = 16
	.byte $38			; G#4
	.byte $37			; G-4
	.byte $34			; E-4
	.byte $31			; C#4
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_01:
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $FB, $FF		; Arpeggio = "Pluck"
	.byte $81			; Duration = 1
	.byte $17			; B-1
	.byte $19			; C#2
	.byte $23			; B-2
	.byte $83			; Duration = 3
	.byte $25			; C#3
	.byte $81			; Duration = 1
	.byte $17			; B-1
	.byte $19			; C#2
	.byte $23			; B-2
	.byte $83			; Duration = 3
	.byte $25			; C#3
	.byte $81			; Duration = 1
	.byte $17			; B-1
	.byte $19			; C#2
	.byte $23			; B-2
	.byte $25			; C#3
	.byte $17			; B-1
	.byte $19			; C#2
	.byte $23			; B-2
	.byte $83			; Duration = 3
	.byte $25			; C#3
	.byte $81			; Duration = 1
	.byte $17			; B-1
	.byte $19			; C#2
	.byte $23			; B-2
	.byte $83			; Duration = 3
	.byte $25			; C#3
	.byte $81			; Duration = 1
	.byte $17			; B-1
	.byte $19			; C#2
	.byte $23			; B-2
	.byte $25			; C#3
	.byte $17			; B-1
	.byte $19			; C#2
	.byte $23			; B-2
	.byte $83			; Duration = 3
	.byte $25			; C#3
	.byte $81			; Duration = 1
	.byte $17			; B-1
	.byte $19			; C#2
	.byte $23			; B-2
	.byte $83			; Duration = 3
	.byte $25			; C#3
	.byte $81			; Duration = 1
	.byte $17			; B-1
	.byte $19			; C#2
	.byte $23			; B-2
	.byte $25			; C#3
	.byte $17			; B-1
	.byte $19			; C#2
	.byte $23			; B-2
	.byte $83			; Duration = 3
	.byte $25			; C#3
	.byte $81			; Duration = 1
	.byte $17			; B-1
	.byte $19			; C#2
	.byte $23			; B-2
	.byte $83			; Duration = 3
	.byte $25			; C#3
	.byte $81			; Duration = 1
	.byte $17			; B-1
	.byte $19			; C#2
	.byte $23			; B-2
	.byte $25			; C#3
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_02:
	.byte $F8, $11		; Volume Envelope = "Synth 2"
	.byte $F9, $06		; Duty Envelope = "Synth 2"
	.byte $FA, $02		; Pitch Envelope = "Synth 2"
	.byte $FB, $FF		; Arpeggio = "Synth 2"
	.byte $A0			; Duration = 32
	.byte $31			; C#4
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_03:
	.byte $F8, $11		; Volume Envelope = "Synth 2"
	.byte $F9, $06		; Duty Envelope = "Synth 2"
	.byte $FA, $02		; Pitch Envelope = "Synth 2"
	.byte $FB, $FF		; Arpeggio = "Synth 2"
	.byte $84			; Duration = 4
	.byte $22			; A#2
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $1F			; G-2
	.byte $8C			; Duration = 12
	.byte $22			; A#2
	.byte $81			; Duration = 1
	.byte $1F			; G-2
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $22			; A#2
	.byte $28			; E-3
	.byte $81			; Duration = 1
	.byte $2A			; F#3
	.byte $2B			; G-3
	.byte $2D			; A-3
	.byte $2E			; A#3
	.byte $2B			; G-3
	.byte $82			; Duration = 2
	.byte $27			; D#3
	.byte $86			; Duration = 6
	.byte $28			; E-3
	.byte $F2, $05		; NOTE DELAY = 5
	.byte $81			; Duration = 1
	.byte $2B			; G-3
	.byte $F2, $03		; NOTE DELAY = 3
	.byte $2D			; A-3
	.byte $82			; Duration = 2
	.byte $2E			; A#3
	.byte $33			; D#4
	.byte $2E			; A#3
	.byte $2D			; A-3
	.byte $90			; Duration = 16
	.byte $2B			; G-3
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_04:
	.byte $F8, $05		; Volume Envelope = "Synth Lead"
	.byte $F9, $00		; Duty Envelope = "Synth Lead"
	.byte $FA, $FF		; Pitch Envelope = "Synth Lead"
	.byte $FB, $FF		; Arpeggio = "Synth Lead"
	.byte $82			; Duration = 2
	.byte $1E			; F#2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $83			; Duration = 3
	.byte $1E			; F#2
	.byte $82			; Duration = 2
	.byte $1F			; G-2
	.byte $81			; Duration = 1
	.byte $22			; A#2
	.byte $23			; B-2
	.byte $96			; Duration = 22
	.byte $27			; D#3
	.byte $9F			; Duration = 31
	.byte $10			; E-1
	.byte $81			; Duration = 1
	.byte $01			; HOLD
	.byte $F1			; RETURN
	; Pattern duration: 64.

; -----------------------------------------------------------------------------
;						SQUARE WAVE 1 CHANNEL
; -----------------------------------------------------------------------------

the_pit_ch_01:
	.byte $F5, $07	; Speed = 7
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_00
	@order_01:
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F0	; CALL
	.word @pattern_04
	.byte $F0	; CALL
	.word @pattern_05
	.byte $F4	; JUMP
	.word @order_01

	@pattern_00:
	.byte $82			; Duration = 2
	.byte $01			; HOLD
	.byte $F8, $14		; Volume Envelope = "Synth 2 Echo"
	.byte $F9, $06		; Duty Envelope = "Synth 2 Echo"
	.byte $FA, $02		; Pitch Envelope = "Synth 2 Echo"
	.byte $FB, $FF		; Arpeggio = "Synth 2 Echo"
	.byte $90			; Duration = 16
	.byte $38			; G#4
	.byte $37			; G-4
	.byte $34			; E-4
	.byte $8E			; Duration = 14
	.byte $31			; C#4
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_01:
	.byte $82			; Duration = 2
	.byte $01			; HOLD
	.byte $BE			; Duration = 62
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_02:
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $FB, $FF		; Arpeggio = "Pluck"
	.byte $81			; Duration = 1
	.byte $1E			; F#2
	.byte $20			; G#2
	.byte $2A			; F#3
	.byte $83			; Duration = 3
	.byte $2C			; G#3
	.byte $81			; Duration = 1
	.byte $1E			; F#2
	.byte $20			; G#2
	.byte $2A			; F#3
	.byte $83			; Duration = 3
	.byte $2C			; G#3
	.byte $81			; Duration = 1
	.byte $1E			; F#2
	.byte $20			; G#2
	.byte $2A			; F#3
	.byte $2C			; G#3
	.byte $1E			; F#2
	.byte $20			; G#2
	.byte $2A			; F#3
	.byte $83			; Duration = 3
	.byte $2C			; G#3
	.byte $81			; Duration = 1
	.byte $1E			; F#2
	.byte $20			; G#2
	.byte $2A			; F#3
	.byte $83			; Duration = 3
	.byte $2C			; G#3
	.byte $81			; Duration = 1
	.byte $1E			; F#2
	.byte $20			; G#2
	.byte $2A			; F#3
	.byte $2C			; G#3
	.byte $1E			; F#2
	.byte $20			; G#2
	.byte $2A			; F#3
	.byte $83			; Duration = 3
	.byte $2C			; G#3
	.byte $81			; Duration = 1
	.byte $1E			; F#2
	.byte $20			; G#2
	.byte $2A			; F#3
	.byte $83			; Duration = 3
	.byte $2C			; G#3
	.byte $81			; Duration = 1
	.byte $1E			; F#2
	.byte $20			; G#2
	.byte $2A			; F#3
	.byte $2C			; G#3
	.byte $1E			; F#2
	.byte $20			; G#2
	.byte $2A			; F#3
	.byte $83			; Duration = 3
	.byte $2C			; G#3
	.byte $81			; Duration = 1
	.byte $1E			; F#2
	.byte $20			; G#2
	.byte $2A			; F#3
	.byte $83			; Duration = 3
	.byte $2C			; G#3
	.byte $81			; Duration = 1
	.byte $1E			; F#2
	.byte $20			; G#2
	.byte $2A			; F#3
	.byte $2C			; G#3
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_03:
	.byte $F8, $14		; Volume Envelope = "Synth 2 Echo"
	.byte $F9, $06		; Duty Envelope = "Synth 2 Echo"
	.byte $FA, $02		; Pitch Envelope = "Synth 2 Echo"
	.byte $FB, $FF		; Arpeggio = "Synth 2 Echo"
	.byte $A0			; Duration = 32
	.byte $2C			; G#3
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_04:
	.byte $82			; Duration = 2
	.byte $01			; HOLD
	.byte $F8, $14		; Volume Envelope = "Synth 2 Echo"
	.byte $F9, $06		; Duty Envelope = "Synth 2 Echo"
	.byte $FA, $02		; Pitch Envelope = "Synth 2 Echo"
	.byte $FB, $FF		; Arpeggio = "Synth 2 Echo"
	.byte $84			; Duration = 4
	.byte $22			; A#2
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $1F			; G-2
	.byte $8C			; Duration = 12
	.byte $22			; A#2
	.byte $81			; Duration = 1
	.byte $1F			; G-2
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $22			; A#2
	.byte $28			; E-3
	.byte $81			; Duration = 1
	.byte $2A			; F#3
	.byte $2B			; G-3
	.byte $2D			; A-3
	.byte $2E			; A#3
	.byte $2B			; G-3
	.byte $82			; Duration = 2
	.byte $27			; D#3
	.byte $86			; Duration = 6
	.byte $28			; E-3
	.byte $81			; Duration = 1
	.byte $2B			; G-3
	.byte $2D			; A-3
	.byte $82			; Duration = 2
	.byte $2E			; A#3
	.byte $33			; D#4
	.byte $2E			; A#3
	.byte $2D			; A-3
	.byte $8E			; Duration = 14
	.byte $2B			; G-3
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_05:
	.byte $82			; Duration = 2
	.byte $01			; HOLD
	.byte $F8, $06		; Volume Envelope = "Synth Echo"
	.byte $F9, $00		; Duty Envelope = "Synth Echo"
	.byte $FA, $FF		; Pitch Envelope = "Synth Echo"
	.byte $FB, $FF		; Arpeggio = "Synth Echo"
	.byte $1E			; F#2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $83			; Duration = 3
	.byte $1E			; F#2
	.byte $82			; Duration = 2
	.byte $1F			; G-2
	.byte $81			; Duration = 1
	.byte $22			; A#2
	.byte $23			; B-2
	.byte $96			; Duration = 22
	.byte $27			; D#3
	.byte $9E			; Duration = 30
	.byte $10			; E-1
	.byte $F1			; RETURN
	; Pattern duration: 64.

; -----------------------------------------------------------------------------
;						TRIANGLE WAVE CHANNEL
; -----------------------------------------------------------------------------

the_pit_ch_02:
	.byte $F5, $07	; Speed = 7
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_00
	@order_02:
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F0	; CALL
	.word @pattern_04
	.byte $F4	; JUMP
	.word @order_02

	@pattern_00:
	.byte $FA, $FF		; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $84			; Duration = 4
	.byte $19			; C#2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $19			; C#2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $86			; Duration = 6
	.byte $19			; C#2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $84			; Duration = 4
	.byte $19			; C#2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $19			; C#2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $19			; C#2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $1C			; E-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $1E			; F#2
	.byte $1F			; G-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $1F			; G-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $1A			; D-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $84			; Duration = 4
	.byte $19			; C#2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $19			; C#2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $86			; Duration = 6
	.byte $19			; C#2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $84			; Duration = 4
	.byte $19			; C#2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $19			; C#2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $19			; C#2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $1C			; E-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $1E			; F#2
	.byte $1F			; G-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $1F			; G-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $1A			; D-2
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_01:
	.byte $FA, $FF		; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $83			; Duration = 3
	.byte $19			; C#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $25			; C#3
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $25			; C#3
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $84			; Duration = 4
	.byte $19			; C#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $1C			; E-2
	.byte $1E			; F#2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $1E			; F#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $82			; Duration = 2
	.byte $1F			; G-2
	.byte $81			; Duration = 1
	.byte $1C			; E-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $83			; Duration = 3
	.byte $19			; C#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $25			; C#3
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $25			; C#3
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $84			; Duration = 4
	.byte $19			; C#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $1E			; F#2
	.byte $1F			; G-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $1F			; G-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $82			; Duration = 2
	.byte $23			; B-2
	.byte $81			; Duration = 1
	.byte $1F			; G-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $83			; Duration = 3
	.byte $19			; C#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $25			; C#3
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $25			; C#3
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $84			; Duration = 4
	.byte $19			; C#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $1C			; E-2
	.byte $1E			; F#2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $1E			; F#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $82			; Duration = 2
	.byte $1F			; G-2
	.byte $81			; Duration = 1
	.byte $1C			; E-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $83			; Duration = 3
	.byte $19			; C#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $25			; C#3
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $25			; C#3
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $84			; Duration = 4
	.byte $19			; C#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $1E			; F#2
	.byte $1F			; G-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $1F			; G-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $82			; Duration = 2
	.byte $23			; B-2
	.byte $81			; Duration = 1
	.byte $1F			; G-2
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_02:
	.byte $FA, $FF		; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $83			; Duration = 3
	.byte $19			; C#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $25			; C#3
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $25			; C#3
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $84			; Duration = 4
	.byte $19			; C#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $1C			; E-2
	.byte $1E			; F#2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $1E			; F#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $82			; Duration = 2
	.byte $1F			; G-2
	.byte $81			; Duration = 1
	.byte $1C			; E-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $83			; Duration = 3
	.byte $19			; C#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $25			; C#3
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $25			; C#3
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $84			; Duration = 4
	.byte $19			; C#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $1E			; F#2
	.byte $1F			; G-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $1F			; G-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $82			; Duration = 2
	.byte $23			; B-2
	.byte $81			; Duration = 1
	.byte $1F			; G-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $83			; Duration = 3
	.byte $19			; C#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $25			; C#3
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $25			; C#3
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $84			; Duration = 4
	.byte $19			; C#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $1C			; E-2
	.byte $1E			; F#2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $1E			; F#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $82			; Duration = 2
	.byte $1F			; G-2
	.byte $81			; Duration = 1
	.byte $1C			; E-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $83			; Duration = 3
	.byte $19			; C#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $25			; C#3
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $25			; C#3
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $84			; Duration = 4
	.byte $19			; C#2
	.byte $81			; Duration = 1
	.byte $1E			; F#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $1F			; G-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $1F			; G-2
	.byte $82			; Duration = 2
	.byte $23			; B-2
	.byte $81			; Duration = 1
	.byte $1F			; G-2
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_03:
	.byte $FA, $FF		; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $83			; Duration = 3
	.byte $1C			; E-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $28			; E-3
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $28			; E-3
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $84			; Duration = 4
	.byte $1C			; E-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $1F			; G-2
	.byte $21			; A-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $21			; A-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $82			; Duration = 2
	.byte $22			; A#2
	.byte $81			; Duration = 1
	.byte $1F			; G-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $83			; Duration = 3
	.byte $1C			; E-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $28			; E-3
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $28			; E-3
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $84			; Duration = 4
	.byte $1C			; E-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $22			; A#2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $22			; A#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $82			; Duration = 2
	.byte $26			; D-3
	.byte $81			; Duration = 1
	.byte $22			; A#2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $83			; Duration = 3
	.byte $1C			; E-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $28			; E-3
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $28			; E-3
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $84			; Duration = 4
	.byte $1C			; E-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $1F			; G-2
	.byte $21			; A-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $21			; A-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $82			; Duration = 2
	.byte $22			; A#2
	.byte $81			; Duration = 1
	.byte $1F			; G-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $83			; Duration = 3
	.byte $1C			; E-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $28			; E-3
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $28			; E-3
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $84			; Duration = 4
	.byte $1C			; E-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $22			; A#2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $22			; A#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $82			; Duration = 2
	.byte $26			; D-3
	.byte $81			; Duration = 1
	.byte $22			; A#2
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_04:
	.byte $FA, $FF		; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $83			; Duration = 3
	.byte $1C			; E-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $28			; E-3
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $28			; E-3
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $84			; Duration = 4
	.byte $1C			; E-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $1F			; G-2
	.byte $21			; A-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $21			; A-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $82			; Duration = 2
	.byte $22			; A#2
	.byte $81			; Duration = 1
	.byte $1F			; G-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $83			; Duration = 3
	.byte $1C			; E-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $28			; E-3
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $28			; E-3
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $84			; Duration = 4
	.byte $1C			; E-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $22			; A#2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $22			; A#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $82			; Duration = 2
	.byte $26			; D-3
	.byte $81			; Duration = 1
	.byte $22			; A#2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $83			; Duration = 3
	.byte $1C			; E-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $28			; E-3
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $28			; E-3
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $84			; Duration = 4
	.byte $1C			; E-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $1F			; G-2
	.byte $21			; A-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $21			; A-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $82			; Duration = 2
	.byte $22			; A#2
	.byte $81			; Duration = 1
	.byte $1F			; G-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $83			; Duration = 3
	.byte $1C			; E-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $28			; E-3
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $28			; E-3
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $84			; Duration = 4
	.byte $1C			; E-2
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $22			; A#2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $22			; A#2
	.byte $82			; Duration = 2
	.byte $26			; D-3
	.byte $81			; Duration = 1
	.byte $22			; A#2
	.byte $F1			; RETURN
	; Pattern duration: 64.

; -----------------------------------------------------------------------------
;						        NOISE CHANNEL
; -----------------------------------------------------------------------------

the_pit_ch_03:
	.byte $F5, $07	; Speed = 7
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_01
	@order_03:
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F4	; JUMP
	.word @order_03

	@pattern_00:
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $82			; Duration = 2
	.byte $06			; 9-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $84			; Duration = 4
	.byte $06			; 9-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $82			; Duration = 2
	.byte $04			; B-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $84			; Duration = 4
	.byte $06			; 9-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $82			; Duration = 2
	.byte $04			; B-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $84			; Duration = 4
	.byte $06			; 9-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $82			; Duration = 2
	.byte $04			; B-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $84			; Duration = 4
	.byte $06			; 9-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $82			; Duration = 2
	.byte $04			; B-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_01:
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $84			; Duration = 4
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $82			; Duration = 2
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $86			; Duration = 6
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $84			; Duration = 4
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $82			; Duration = 2
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $86			; Duration = 6
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $84			; Duration = 4
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $82			; Duration = 2
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $86			; Duration = 6
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $84			; Duration = 4
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $82			; Duration = 2
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $86			; Duration = 6
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $84			; Duration = 4
	.byte $08			; 7-#
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_02:
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $84			; Duration = 4
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $82			; Duration = 2
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $86			; Duration = 6
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $84			; Duration = 4
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $82			; Duration = 2
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $86			; Duration = 6
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $84			; Duration = 4
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $82			; Duration = 2
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $86			; Duration = 6
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $84			; Duration = 4
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $82			; Duration = 2
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $84			; Duration = 4
	.byte $06			; 9-#
	.byte $82			; Duration = 2
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $81			; Duration = 1
	.byte $08			; 7-#
	.byte $82			; Duration = 2
	.byte $08			; 7-#
	.byte $81			; Duration = 1
	.byte $08			; 7-#
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_03:
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $84			; Duration = 4
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $82			; Duration = 2
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $86			; Duration = 6
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $84			; Duration = 4
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $82			; Duration = 2
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $86			; Duration = 6
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $84			; Duration = 4
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $82			; Duration = 2
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $86			; Duration = 6
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $84			; Duration = 4
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $82			; Duration = 2
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $86			; Duration = 6
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $84			; Duration = 4
	.byte $08			; 7-#
	.byte $F1			; RETURN
	; Pattern duration: 64.
