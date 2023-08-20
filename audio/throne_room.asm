	.byte $00
	.word throne_room_ch_00
	.byte $01
	.word throne_room_ch_01
	.byte $02
	.word throne_room_ch_02
	.byte $03
	.word throne_room_ch_03
	.byte $FF

; -----------------------------------------------------------------------------
;						SQUARE WAVE 0 CHANNEL
; -----------------------------------------------------------------------------

throne_room_ch_00:
	.byte $F5, $07	; Speed = 7
	.byte $F0	; CALL
	.word @pattern_03
	@order_00:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_04
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_04
	.byte $F0	; CALL
	.word @pattern_05
	.byte $F0	; CALL
	.word @pattern_06
	.byte $F4	; JUMP
	.word @order_00

	@pattern_00:
	.byte $82			; Duration = 2
	.byte $01			; HOLD
	.byte $F8, $0A		; Volume Envelope = "Pluck (Quiet)"
	.byte $F9, $02		; Duty Envelope = "Pluck (Quiet)"
	.byte $FA, $FF		; Pitch Envelope = "Pluck (Quiet)"
	.byte $FB, $FF		; Arpeggio = "Pluck (Quiet)"
	.byte $81			; Duration = 1
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $33			; D#4
	.byte $31			; C#4
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $2A			; F#3
	.byte $27			; D#3
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $36			; F#4
	.byte $33			; D#4
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $2A			; F#3
	.byte $27			; D#3
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $33			; D#4
	.byte $31			; C#4
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $2A			; F#3
	.byte $27			; D#3
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $33			; D#4
	.byte $31			; C#4
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $2A			; F#3
	.byte $27			; D#3
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $36			; F#4
	.byte $33			; D#4
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $2A			; F#3
	.byte $27			; D#3
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $33			; D#4
	.byte $31			; C#4
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $F1			; RETURN
	; Pattern duration: 48.

	@pattern_01:
	.byte $F8, $11		; Volume Envelope = "Synth 2"
	.byte $F9, $06		; Duty Envelope = "Synth 2"
	.byte $FA, $02		; Pitch Envelope = "Synth 2"
	.byte $FB, $FF		; Arpeggio = "Synth 2"
	.byte $81			; Duration = 1
	.byte $27			; D#3
	.byte $2A			; F#3
	.byte $2C			; G#3
	.byte $2A			; F#3
	.byte $36			; F#4
	.byte $33			; D#4
	.byte $2D			; A-3
	.byte $2A			; F#3
	.byte $88			; Duration = 8
	.byte $27			; D#3
	.byte $F8, $14		; Volume Envelope = "Synth 2 Echo"
	.byte $34			; E-4
	.byte $31			; C#4
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $81			; Duration = 1
	.byte $33			; D#4
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $33			; D#4
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $33			; D#4
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $33			; D#4
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $33			; D#4
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $33			; D#4
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $33			; D#4
	.byte $F6, $04, $01	; TRANSPOSE = 4, 1
	.byte $33			; D#4
	.byte $88			; Duration = 8
	.byte $33			; D#4
	.byte $F1			; RETURN
	; Pattern duration: 48.

	@pattern_02:
	.byte $F8, $05		; Volume Envelope = "Synth Lead"
	.byte $F9, $00		; Duty Envelope = "Synth Lead"
	.byte $FA, $FF		; Pitch Envelope = "Synth Lead"
	.byte $FB, $FF		; Arpeggio = "Synth Lead"
	.byte $81			; Duration = 1
	.byte $2C			; G#3
	.byte $2A			; F#3
	.byte $2C			; G#3
	.byte $82			; Duration = 2
	.byte $36			; F#4
	.byte $81			; Duration = 1
	.byte $33			; D#4
	.byte $31			; C#4
	.byte $2D			; A-3
	.byte $2C			; G#3
	.byte $2A			; F#3
	.byte $2C			; G#3
	.byte $82			; Duration = 2
	.byte $39			; A-4
	.byte $81			; Duration = 1
	.byte $36			; F#4
	.byte $33			; D#4
	.byte $2D			; A-3
	.byte $88			; Duration = 8
	.byte $2A			; F#3
	.byte $F8, $11		; Volume Envelope = "Synth 2"
	.byte $F9, $06		; Duty Envelope = "Synth 2"
	.byte $FA, $02		; Pitch Envelope = "Synth 2"
	.byte $81			; Duration = 1
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $2C			; G#3
	.byte $38			; G#4
	.byte $36			; F#4
	.byte $2F			; B-3
	.byte $30			; C-4
	.byte $83			; Duration = 3
	.byte $35			; F-4
	.byte $8E			; Duration = 14
	.byte $33			; D#4
	.byte $F1			; RETURN
	; Pattern duration: 48.

	@pattern_03:
	.byte $F8, $07		; Volume Envelope = "Pulse Bass"
	.byte $F9, $01		; Duty Envelope = "Pulse Bass"
	.byte $FA, $FF		; Pitch Envelope = "Pulse Bass"
	.byte $FB, $FF		; Arpeggio = "Pulse Bass"
	.byte $98			; Duration = 24
	.byte $14			; G#1
	.byte $F7			; SKIP
	; Pattern duration: 24.

	@pattern_04:
	.byte $98			; Duration = 24
	.byte $00			; REST
	.byte $F7			; SKIP
	; Pattern duration: 24.

	@pattern_05:
	.byte $F8, $05		; Volume Envelope = "Synth Lead"
	.byte $F9, $00		; Duty Envelope = "Synth Lead"
	.byte $FA, $FF		; Pitch Envelope = "Synth Lead"
	.byte $FB, $FF		; Arpeggio = "Synth Lead"
	.byte $86			; Duration = 6
	.byte $1E			; F#2
	.byte $82			; Duration = 2
	.byte $1C			; E-2
	.byte $81			; Duration = 1
	.byte $23			; B-2
	.byte $24			; C-3
	.byte $84			; Duration = 4
	.byte $27			; D#3
	.byte $82			; Duration = 2
	.byte $2A			; F#3
	.byte $88			; Duration = 8
	.byte $2B			; G-3
	.byte $F8, $11		; Volume Envelope = "Synth 2"
	.byte $F9, $06		; Duty Envelope = "Synth 2"
	.byte $FA, $02		; Pitch Envelope = "Synth 2"
	.byte $82			; Duration = 2
	.byte $36			; F#4
	.byte $81			; Duration = 1
	.byte $34			; E-4
	.byte $36			; F#4
	.byte $82			; Duration = 2
	.byte $2F			; B-3
	.byte $81			; Duration = 1
	.byte $2D			; A-3
	.byte $2F			; B-3
	.byte $82			; Duration = 2
	.byte $2A			; F#3
	.byte $81			; Duration = 1
	.byte $28			; E-3
	.byte $2A			; F#3
	.byte $82			; Duration = 2
	.byte $23			; B-2
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $23			; B-2
	.byte $88			; Duration = 8
	.byte $1E			; F#2
	.byte $F1			; RETURN
	; Pattern duration: 48.

	@pattern_06:
	.byte $8C			; Duration = 12
	.byte $01			; HOLD
	.byte $8B			; Duration = 11
	.byte $00			; REST
	.byte $99			; Duration = 25
	.byte $01			; HOLD
	.byte $F1			; RETURN
	; Pattern duration: 48.

; -----------------------------------------------------------------------------
;						SQUARE WAVE 1 CHANNEL
; -----------------------------------------------------------------------------

throne_room_ch_01:
	.byte $F5, $07	; Speed = 7
	.byte $F0	; CALL
	.word @pattern_00
	@order_01:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F4	; JUMP
	.word @order_01

	@pattern_00:
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $FB, $FF		; Arpeggio = "Pluck"
	.byte $81			; Duration = 1
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $33			; D#4
	.byte $31			; C#4
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $2A			; F#3
	.byte $27			; D#3
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $36			; F#4
	.byte $33			; D#4
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $2A			; F#3
	.byte $27			; D#3
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $33			; D#4
	.byte $31			; C#4
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $2A			; F#3
	.byte $27			; D#3
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $33			; D#4
	.byte $31			; C#4
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $2A			; F#3
	.byte $27			; D#3
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $36			; F#4
	.byte $33			; D#4
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $2A			; F#3
	.byte $27			; D#3
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $33			; D#4
	.byte $31			; C#4
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $2A			; F#3
	.byte $27			; D#3
	.byte $F1			; RETURN
	; Pattern duration: 48.

	@pattern_01:
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $FB, $FF		; Arpeggio = "Pluck"
	.byte $81			; Duration = 1
	.byte $2F			; B-3
	.byte $30			; C-4
	.byte $36			; F#4
	.byte $34			; E-4
	.byte $2F			; B-3
	.byte $30			; C-4
	.byte $2D			; A-3
	.byte $2A			; F#3
	.byte $2F			; B-3
	.byte $30			; C-4
	.byte $39			; A-4
	.byte $36			; F#4
	.byte $2F			; B-3
	.byte $30			; C-4
	.byte $2D			; A-3
	.byte $2A			; F#3
	.byte $2F			; B-3
	.byte $30			; C-4
	.byte $36			; F#4
	.byte $34			; E-4
	.byte $2F			; B-3
	.byte $30			; C-4
	.byte $2D			; A-3
	.byte $2A			; F#3
	.byte $2F			; B-3
	.byte $30			; C-4
	.byte $36			; F#4
	.byte $34			; E-4
	.byte $2F			; B-3
	.byte $30			; C-4
	.byte $2D			; A-3
	.byte $2A			; F#3
	.byte $2F			; B-3
	.byte $30			; C-4
	.byte $39			; A-4
	.byte $36			; F#4
	.byte $2F			; B-3
	.byte $30			; C-4
	.byte $2D			; A-3
	.byte $2A			; F#3
	.byte $2F			; B-3
	.byte $30			; C-4
	.byte $36			; F#4
	.byte $34			; E-4
	.byte $2F			; B-3
	.byte $30			; C-4
	.byte $2D			; A-3
	.byte $2A			; F#3
	.byte $F1			; RETURN
	; Pattern duration: 48.

; -----------------------------------------------------------------------------
;						TRIANGLE WAVE CHANNEL
; -----------------------------------------------------------------------------

throne_room_ch_02:
	.byte $F5, $07	; Speed = 7
	.byte $F0	; CALL
	.word @pattern_00
	@order_02:
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F4	; JUMP
	.word @order_02

	@pattern_00:
	.byte $B0			; Duration = 48
	.byte $01			; HOLD
	.byte $F1			; RETURN
	; Pattern duration: 24.

	@pattern_01:
	.byte $FA, $FF		; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $86			; Duration = 6
	.byte $20			; G#2
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $8A			; Duration = 10
	.byte $00			; REST
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $82			; Duration = 2
	.byte $20			; G#2
	.byte $81			; Duration = 1
	.byte $20			; G#2
	.byte $20			; G#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $1E			; F#2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $1E			; F#2
	.byte $86			; Duration = 6
	.byte $20			; G#2
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $8A			; Duration = 10
	.byte $00			; REST
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $82			; Duration = 2
	.byte $20			; G#2
	.byte $81			; Duration = 1
	.byte $20			; G#2
	.byte $20			; G#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $1E			; F#2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $1E			; F#2
	.byte $F1			; RETURN
	; Pattern duration: 48.

	@pattern_02:
	.byte $FA, $FF		; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $84			; Duration = 4
	.byte $20			; G#2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $20			; G#2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $21			; A-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $84			; Duration = 4
	.byte $00			; REST
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $86			; Duration = 6
	.byte $20			; G#2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $82			; Duration = 2
	.byte $20			; G#2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $81			; Duration = 1
	.byte $20			; G#2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $20			; G#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $1E			; F#2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $1E			; F#2
	.byte $84			; Duration = 4
	.byte $20			; G#2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $20			; G#2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $21			; A-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $84			; Duration = 4
	.byte $00			; REST
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $86			; Duration = 6
	.byte $20			; G#2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $82			; Duration = 2
	.byte $20			; G#2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $81			; Duration = 1
	.byte $20			; G#2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $20			; G#2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $1E			; F#2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $1E			; F#2
	.byte $F1			; RETURN
	; Pattern duration: 48.

	@pattern_03:
	.byte $FA, $FF		; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $82			; Duration = 2
	.byte $23			; B-2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $23			; B-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $23			; B-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $24			; C-3
	.byte $84			; Duration = 4
	.byte $00			; REST
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $25			; C#3
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $23			; B-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $2F			; B-3
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $23			; B-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $23			; B-2
	.byte $82			; Duration = 2
	.byte $23			; B-2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $23			; B-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $23			; B-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $24			; C-3
	.byte $84			; Duration = 4
	.byte $00			; REST
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $25			; C#3
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $23			; B-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $2F			; B-3
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $23			; B-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $23			; B-2
	.byte $F1			; RETURN
	; Pattern duration: 48.

; -----------------------------------------------------------------------------
;						        NOISE CHANNEL
; -----------------------------------------------------------------------------

throne_room_ch_03:
	.byte $F5, $07	; Speed = 7
	.byte $F0	; CALL
	.word @pattern_00
	@order_03:
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F4	; JUMP
	.word @order_03

	@pattern_00:
	.byte $B0			; Duration = 48
	.byte $01			; E-#
	.byte $F1			; RETURN
	; Pattern duration: 48.

	@pattern_01:
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $86			; Duration = 6
	.byte $06			; 9-#
	.byte $8C			; Duration = 12
	.byte $06			; 9-#
	.byte $82			; Duration = 2
	.byte $06			; 9-#
	.byte $81			; Duration = 1
	.byte $06			; 9-#
	.byte $82			; Duration = 2
	.byte $06			; 9-#
	.byte $81			; Duration = 1
	.byte $06			; 9-#
	.byte $86			; Duration = 6
	.byte $06			; 9-#
	.byte $8C			; Duration = 12
	.byte $06			; 9-#
	.byte $82			; Duration = 2
	.byte $06			; 9-#
	.byte $81			; Duration = 1
	.byte $06			; 9-#
	.byte $82			; Duration = 2
	.byte $06			; 9-#
	.byte $81			; Duration = 1
	.byte $06			; 9-#
	.byte $F1			; RETURN
	; Pattern duration: 48.

	@pattern_02:
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $82			; Duration = 2
	.byte $06			; 9-#
	.byte $F8, $1C		; Volume Envelope = "Pop Drum"
	.byte $FB, $0A		; Arpeggio = "Pop Drum"
	.byte $0B			; 4-#
	.byte $F8, $0E		; Volume Envelope = "Snare 2"
	.byte $FB, $03		; Arpeggio = "Snare 2"
	.byte $09			; 6-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $1C		; Volume Envelope = "Pop Drum"
	.byte $FB, $0A		; Arpeggio = "Pop Drum"
	.byte $83			; Duration = 3
	.byte $0B			; 4-#
	.byte $F8, $02		; Volume Envelope = "Snare Roll"
	.byte $FB, $04		; Arpeggio = "Snare Roll"
	.byte $81			; Duration = 1
	.byte $09			; 6-#
	.byte $F8, $0E		; Volume Envelope = "Snare 2"
	.byte $FB, $03		; Arpeggio = "Snare 2"
	.byte $82			; Duration = 2
	.byte $09			; 6-#
	.byte $F8, $15		; Volume Envelope = "Quiet Drum"
	.byte $FB, $FF		; Arpeggio = "Quiet Drum"
	.byte $81			; Duration = 1
	.byte $0A			; 5-#
	.byte $0A			; 5-#
	.byte $82			; Duration = 2
	.byte $0B			; 4-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $0E		; Volume Envelope = "Snare 2"
	.byte $FB, $03		; Arpeggio = "Snare 2"
	.byte $81			; Duration = 1
	.byte $09			; 6-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $08		; Volume Envelope = "Roll Drum"
	.byte $FB, $FF		; Arpeggio = "Roll Drum"
	.byte $0A			; 5-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $82			; Duration = 2
	.byte $06			; 9-#
	.byte $F8, $1C		; Volume Envelope = "Pop Drum"
	.byte $FB, $0A		; Arpeggio = "Pop Drum"
	.byte $0B			; 4-#
	.byte $F8, $0E		; Volume Envelope = "Snare 2"
	.byte $FB, $03		; Arpeggio = "Snare 2"
	.byte $09			; 6-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $1C		; Volume Envelope = "Pop Drum"
	.byte $FB, $0A		; Arpeggio = "Pop Drum"
	.byte $83			; Duration = 3
	.byte $0B			; 4-#
	.byte $F8, $02		; Volume Envelope = "Snare Roll"
	.byte $FB, $04		; Arpeggio = "Snare Roll"
	.byte $81			; Duration = 1
	.byte $09			; 6-#
	.byte $F8, $0E		; Volume Envelope = "Snare 2"
	.byte $FB, $03		; Arpeggio = "Snare 2"
	.byte $82			; Duration = 2
	.byte $09			; 6-#
	.byte $F8, $15		; Volume Envelope = "Quiet Drum"
	.byte $FB, $FF		; Arpeggio = "Quiet Drum"
	.byte $81			; Duration = 1
	.byte $0A			; 5-#
	.byte $0A			; 5-#
	.byte $82			; Duration = 2
	.byte $0B			; 4-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $0E		; Volume Envelope = "Snare 2"
	.byte $FB, $03		; Arpeggio = "Snare 2"
	.byte $81			; Duration = 1
	.byte $09			; 6-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $08		; Volume Envelope = "Roll Drum"
	.byte $FB, $FF		; Arpeggio = "Roll Drum"
	.byte $0A			; 5-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F1			; RETURN
	; Pattern duration: 48.
