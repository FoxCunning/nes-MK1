	.byte $00
	.word victory_palace_ch_00
	.byte $01
	.word victory_palace_ch_01
	.byte $02
	.word victory_palace_ch_02
	.byte $03
	.word victory_palace_ch_03
	.byte $FF

; -----------------------------------------------------------------------------
;						SQUARE WAVE 0 CHANNEL
; -----------------------------------------------------------------------------

victory_palace_ch_00:
	.byte $F5, $09	; Speed = 9
	@order_00:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $F3, $08		; DELAYED CUT = 8
	.byte $F8, $05		; Volume Envelope = "Synth Lead"
	.byte $F9, $00		; Duty Envelope = "Synth Lead"
	.byte $FA, $FF		; Pitch Envelope = "Synth Lead"
	.byte $FB, $FF		; Arpeggio = "Synth Lead"
	.byte $81			; Duration = 1
	.byte $2D			; A-3
	.byte $F3, $08		; DELAYED CUT = 8
	.byte $2B			; G-3
	.byte $F3, $08		; DELAYED CUT = 8
	.byte $28			; E-3
	.byte $F3, $08		; DELAYED CUT = 8
	.byte $26			; D-3
	.byte $F3, $08		; DELAYED CUT = 8
	.byte $22			; A#2
	.byte $F3, $08		; DELAYED CUT = 8
	.byte $21			; A-2
	.byte $F3, $08		; DELAYED CUT = 8
	.byte $1F			; G-2
	.byte $F3, $08		; DELAYED CUT = 8
	.byte $1C			; E-2
	.byte $84			; Duration = 4
	.byte $16			; A#1
	.byte $F8, $11		; Volume Envelope = "Synth 2"
	.byte $F9, $06		; Duty Envelope = "Synth 2"
	.byte $FA, $02		; Pitch Envelope = "Synth 2"
	.byte $27			; D#3
	.byte $8C			; Duration = 12
	.byte $28			; E-3
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 29.

; -----------------------------------------------------------------------------
;						SQUARE WAVE 1 CHANNEL
; -----------------------------------------------------------------------------

victory_palace_ch_01:
	.byte $F5, $09	; Speed = 9
	@order_01:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $82			; Duration = 2
	.byte $01			; HOLD
	.byte $F3, $08		; DELAYED CUT = 8
	.byte $F8, $06		; Volume Envelope = "Synth Echo"
	.byte $F9, $00		; Duty Envelope = "Synth Echo"
	.byte $FA, $FF		; Pitch Envelope = "Synth Echo"
	.byte $FB, $FF		; Arpeggio = "Synth Echo"
	.byte $81			; Duration = 1
	.byte $2D			; A-3
	.byte $F3, $08		; DELAYED CUT = 8
	.byte $2B			; G-3
	.byte $F3, $08		; DELAYED CUT = 8
	.byte $28			; E-3
	.byte $F3, $08		; DELAYED CUT = 8
	.byte $26			; D-3
	.byte $F3, $08		; DELAYED CUT = 8
	.byte $22			; A#2
	.byte $F3, $08		; DELAYED CUT = 8
	.byte $21			; A-2
	.byte $F3, $08		; DELAYED CUT = 8
	.byte $1F			; G-2
	.byte $F3, $08		; DELAYED CUT = 8
	.byte $1C			; E-2
	.byte $82			; Duration = 2
	.byte $16			; A#1
	.byte $F8, $11		; Volume Envelope = "Synth 2"
	.byte $F9, $06		; Duty Envelope = "Synth 2"
	.byte $FA, $02		; Pitch Envelope = "Synth 2"
	.byte $84			; Duration = 4
	.byte $22			; A#2
	.byte $8C			; Duration = 12
	.byte $23			; B-2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 29.

; -----------------------------------------------------------------------------
;						TRIANGLE WAVE CHANNEL
; -----------------------------------------------------------------------------

victory_palace_ch_02:
	.byte $F5, $09	; Speed = 9
	@order_02:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $8C			; Duration = 12
	.byte $01			; HOLD
	.byte $FA, $FF		; Pitch Envelope = "Blank"
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $84			; Duration = 4
	.byte $1B			; D#2
	.byte $F8, $1B		; Volume Envelope = "Warrior Synth 2"
	.byte $FA, $04		; Pitch Envelope = "Warrior Synth 2"
	.byte $8C			; Duration = 12
	.byte $1C			; E-2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 29.

; -----------------------------------------------------------------------------
;						        NOISE CHANNEL
; -----------------------------------------------------------------------------

victory_palace_ch_03:
	.byte $FF
