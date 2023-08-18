	.byte $00
	.word victory_pit_ch_00
	.byte $01
	.word victory_pit_ch_01
	.byte $02
	.word victory_pit_ch_02
	.byte $03
	.word victory_pit_ch_03
	.byte $FF

; -----------------------------------------------------------------------------
;						SQUARE WAVE 0 CHANNEL
; -----------------------------------------------------------------------------

victory_pit_ch_00:
	.byte $F5, $07	; Speed = 7
	@order_00:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $F5, $04		; SPEED = 4
	.byte $F8, $11		; Volume Envelope = "Synth 2"
	.byte $F9, $06		; Duty Envelope = "Synth 2"
	.byte $FA, $02		; Pitch Envelope = "Synth 2"
	.byte $FB, $FF		; Arpeggio = "Synth 2"
	.byte $81			; Duration = 1
	.byte $31			; C#4
	.byte $F5, $03		; SPEED = 3
	.byte $32			; D-4
	.byte $F5, $07		; SPEED = 7
	.byte $87			; Duration = 7
	.byte $31			; C#4
	.byte $F5, $04		; SPEED = 4
	.byte $81			; Duration = 1
	.byte $2C			; G#3
	.byte $F5, $03		; SPEED = 3
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $87			; Duration = 7
	.byte $2C			; G#3
	.byte $8F			; Duration = 15
	.byte $28			; E-3
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 64.

; -----------------------------------------------------------------------------
;						SQUARE WAVE 1 CHANNEL
; -----------------------------------------------------------------------------

victory_pit_ch_01:
	.byte $F5, $07	; Speed = 7
	@order_01:
	.byte $F0	; CALL
	.word @pattern_01
	.byte $FF

	@pattern_01:
	.byte $F8, $10		; Volume Envelope = "Bamboo x2"
	.byte $F9, $05		; Duty Envelope = "Bamboo x2"
	.byte $FA, $FF		; Pitch Envelope = "Bamboo x2"
	.byte $FB, $FF		; Arpeggio = "Bamboo x2"
	.byte $82			; Duration = 2
	.byte $19			; C#2
	.byte $F8, $0F		; Volume Envelope = "Bamboo?"
	.byte $F9, $04		; Duty Envelope = "Bamboo?"
	.byte $19			; C#2
	.byte $25			; C#3
	.byte $81			; Duration = 1
	.byte $25			; C#3
	.byte $84			; Duration = 4
	.byte $19			; C#2
	.byte $81			; Duration = 1
	.byte $19			; C#2
	.byte $1C			; E-2
	.byte $1E			; F#2
	.byte $2A			; F#3
	.byte $1F			; G-2
	.byte $2B			; G-3
	.byte $1C			; E-2
	.byte $F8, $11		; Volume Envelope = "Synth 2"
	.byte $F9, $06		; Duty Envelope = "Synth 2"
	.byte $FA, $02		; Pitch Envelope = "Synth 2"
	.byte $8F			; Duration = 15
	.byte $2C			; G#3
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 64.

; -----------------------------------------------------------------------------
;						TRIANGLE WAVE CHANNEL
; -----------------------------------------------------------------------------

victory_pit_ch_02:
	.byte $F5, $07	; Speed = 7
	@order_02:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $FA, $FF		; Pitch Envelope = "Blank"
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $83			; Duration = 3
	.byte $19			; C#2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $81			; Duration = 1
	.byte $01			; HOLD
	.byte $19			; C#2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $19			; C#2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $01			; HOLD
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $19			; C#2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $01			; HOLD
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $19			; C#2
	.byte $81			; Duration = 1
	.byte $19			; C#2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $19			; C#2
	.byte $19			; C#2
	.byte $19			; C#2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $19			; C#2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $19			; C#2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $19			; C#2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $8F			; Duration = 15
	.byte $19			; C#2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 34.

; -----------------------------------------------------------------------------
;						        NOISE CHANNEL
; -----------------------------------------------------------------------------

victory_pit_ch_03:
	.byte $F5, $07	; Speed = 7
	@order_03:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $F8, $08		; Volume Envelope = "Roll Drum"
	.byte $FB, $FF		; Arpeggio = "Roll Drum"
	.byte $85			; Duration = 5
	.byte $0E			; 1-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $82			; Duration = 2
	.byte $08			; 7-#
	.byte $F8, $08		; Volume Envelope = "Roll Drum"
	.byte $FB, $FF		; Arpeggio = "Roll Drum"
	.byte $0E			; 1-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $81			; Duration = 1
	.byte $08			; 7-#
	.byte $08			; 7-#
	.byte $F8, $02		; Volume Envelope = "Snare Roll"
	.byte $FB, $04		; Arpeggio = "Snare Roll"
	.byte $08			; 7-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $90			; Duration = 16
	.byte $08			; 7-#
	.byte $F1			; RETURN
	; Pattern duration: 34.
