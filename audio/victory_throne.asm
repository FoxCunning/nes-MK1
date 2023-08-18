	.byte $00
	.word victory_throne_ch_00
	.byte $01
	.word victory_throne_ch_01
	.byte $02
	.word victory_throne_ch_02
	.byte $03
	.word victory_throne_ch_03
	.byte $FF

; -----------------------------------------------------------------------------
;						SQUARE WAVE 0 CHANNEL
; -----------------------------------------------------------------------------

victory_throne_ch_00:
	;.byte $F5, $07	; Speed = 7
	@order_00:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $F5, $04		; SPEED = 4
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $FB, $FF		; Arpeggio = "Pluck"
	.byte $81			; Duration = 1
	.byte $14			; G#1
	.byte $F5, $03		; SPEED = 3
	.byte $15			; A-1
	.byte $F5, $04		; SPEED = 4
	.byte $19			; C#2
	.byte $F5, $03		; SPEED = 3
	.byte $1B			; D#2
	.byte $F5, $04		; SPEED = 4
	.byte $F8, $11		; Volume Envelope = "Synth 2"
	.byte $F9, $06		; Duty Envelope = "Synth 2"
	.byte $FA, $02		; Pitch Envelope = "Synth 2"
	.byte $36			; F#4
	.byte $F5, $03		; SPEED = 3
	.byte $01			; HOLD
	.byte $F5, $04		; SPEED = 4
	.byte $34			; E-4
	.byte $F5, $03		; SPEED = 3
	.byte $01			; HOLD
	.byte $F5, $04		; SPEED = 4
	.byte $33			; D#4
	.byte $F5, $03		; SPEED = 3
	.byte $01			; HOLD
	.byte $F5, $04		; SPEED = 4
	.byte $31			; C#4
	.byte $F5, $03		; SPEED = 3
	.byte $01			; HOLD
	.byte $F5, $04		; SPEED = 4
	.byte $33			; D#4
	.byte $F5, $03		; SPEED = 3
	.byte $01			; HOLD
	.byte $F5, $04		; SPEED = 4
	.byte $38			; G#4
	.byte $F5, $03		; SPEED = 3
	.byte $01			; HOLD
	.byte $F5, $04		; SPEED = 4
	.byte $01			; HOLD
	.byte $F5, $03		; SPEED = 3
	.byte $01			; HOLD
	.byte $F5, $04		; SPEED = 4
	.byte $01			; HOLD
	.byte $F5, $03		; SPEED = 3
	.byte $01			; HOLD
	.byte $F5, $04		; SPEED = 4
	.byte $01			; HOLD
	.byte $F5, $03		; SPEED = 3
	.byte $01			; HOLD
	.byte $F5, $04		; SPEED = 4
	.byte $01			; HOLD
	.byte $F5, $03		; SPEED = 3
	.byte $01			; HOLD
	.byte $F5, $04		; SPEED = 4
	.byte $01			; HOLD
	.byte $F5, $03		; SPEED = 3
	.byte $01			; HOLD
	.byte $F5, $04		; SPEED = 4
	.byte $01			; HOLD
	.byte $F5, $03		; SPEED = 3
	.byte $01			; HOLD
	.byte $F5, $04		; SPEED = 4
	.byte $01			; HOLD
	.byte $F5, $03		; SPEED = 3
	.byte $01			; HOLD
	.byte $F5, $04		; SPEED = 4
	.byte $01			; HOLD
	.byte $F5, $03		; SPEED = 3
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $86			; Duration = 6
	.byte $01			; HOLD
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 39.

; -----------------------------------------------------------------------------
;						SQUARE WAVE 1 CHANNEL
; -----------------------------------------------------------------------------

victory_throne_ch_01:
	;.byte $F5, $07	; Speed = 7
	@order_01:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $F8, $1A		; Volume Envelope = "Warrior Synth"
	.byte $F9, $08		; Duty Envelope = "Warrior Synth"
	.byte $FA, $04		; Pitch Envelope = "Warrior Synth"
	.byte $FB, $FF		; Arpeggio = "Warrior Synth"
	.byte $82			; Duration = 2
	.byte $2C			; G#3
	.byte $2D			; A-3
	.byte $2C			; G#3
	.byte $27			; D#3
	.byte $2A			; F#3
	.byte $24			; C-3
	.byte $27			; D#3
	.byte $98			; Duration = 24
	.byte $20			; G#2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 39.

; -----------------------------------------------------------------------------
;						TRIANGLE WAVE CHANNEL
; -----------------------------------------------------------------------------

victory_throne_ch_02:
	;.byte $F5, $07	; Speed = 7
	@order_02:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $FA, $FF		; Pitch Envelope = "Tri Snare -> Bass"
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $20			; G#2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $20			; G#2
	.byte $20			; G#2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $81			; Duration = 1
	.byte $20			; G#2
	.byte $20			; G#2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $82			; Duration = 2
	.byte $20			; G#2
	.byte $1C			; E-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $1E			; F#2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $98			; Duration = 24
	.byte $20			; G#2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 39.

; -----------------------------------------------------------------------------
;						        NOISE CHANNEL
; -----------------------------------------------------------------------------

victory_throne_ch_03:
	;.byte $F5, $07	; Speed = 7
	@order_03:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $81			; Duration = 1
	.byte $08			; 7-#
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $82			; Duration = 2
	.byte $06			; 9-#
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $81			; Duration = 1
	.byte $08			; 7-#
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $82			; Duration = 2
	.byte $06			; 9-#
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $81			; Duration = 1
	.byte $08			; 7-#
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $99			; Duration = 25
	.byte $06			; 9-#
	.byte $F1			; RETURN
	; Pattern duration: 39.
