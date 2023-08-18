	.byte $00
	.word victory_courtyard_ch_00
	.byte $01
	.word victory_courtyard_ch_01
	.byte $02
	.word victory_courtyard_ch_02
	.byte $03
	.word victory_courtyard_ch_03
	.byte $FF

; -----------------------------------------------------------------------------
;						SQUARE WAVE 0 CHANNEL
; -----------------------------------------------------------------------------

victory_courtyard_ch_00:
	.byte $F5, $07	; Speed = 7
	@order_00:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $F8, $1A		; Volume Envelope = "Warrior Synth"
	.byte $F9, $08		; Duty Envelope = "Warrior Synth"
	.byte $FA, $04		; Pitch Envelope = "Warrior Synth"
	.byte $FB, $FF		; Arpeggio = "Warrior Synth"
	.byte $93			; Duration = 19
	.byte $32			; D-4
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 20.

; -----------------------------------------------------------------------------
;						SQUARE WAVE 1 CHANNEL
; -----------------------------------------------------------------------------

victory_courtyard_ch_01:
	.byte $F5, $07	; Speed = 7
	@order_01:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $F8, $07		; Volume Envelope = "Pulse Bass"
	.byte $F9, $01		; Duty Envelope = "Pulse Bass"
	.byte $FA, $FF		; Pitch Envelope = "Pulse Bass"
	.byte $FB, $FF		; Arpeggio = "Pulse Bass"
	.byte $93			; Duration = 19
	.byte $1A			; D-2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 20.

; -----------------------------------------------------------------------------
;						TRIANGLE WAVE CHANNEL
; -----------------------------------------------------------------------------

victory_courtyard_ch_02:
	.byte $F5, $07	; Speed = 7
	@order_02:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $FA, $FF		; Pitch Envelope = "Blank"
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $1A			; D-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $1A			; D-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $1A			; D-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $84			; Duration = 4
	.byte $1A			; D-2
	.byte $81			; Duration = 1
	.byte $1A			; D-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $1A			; D-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $1A			; D-2
	.byte $F8, $1B		; Volume Envelope = "Warrior Synth 2"
	.byte $FA, $04		; Pitch Envelope = "Warrior Synth 2"
	.byte $FB, $FF		; Arpeggio = "Warrior Synth 2"
	.byte $89			; Duration = 9
	.byte $1A			; D-2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 20.

; -----------------------------------------------------------------------------
;						        NOISE CHANNEL
; -----------------------------------------------------------------------------

victory_courtyard_ch_03:
	.byte $F5, $07	; Speed = 7
	@order_03:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $0B		; Volume Envelope = "Bongo"
	.byte $FB, $07		; Arpeggio = "Bongo"
	.byte $09			; 6-#
	.byte $F8, $02		; Volume Envelope = "Snare Roll"
	.byte $FB, $04		; Arpeggio = "Snare Roll"
	.byte $08			; 7-#
	.byte $F8, $0E		; Volume Envelope = "Snare 2"
	.byte $FB, $03		; Arpeggio = "Snare 2"
	.byte $08			; 7-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $0B		; Volume Envelope = "Bongo"
	.byte $FB, $07		; Arpeggio = "Bongo"
	.byte $0B			; 4-#
	.byte $F8, $08		; Volume Envelope = "Roll Drum"
	.byte $FB, $FF		; Arpeggio = "Roll Drum"
	.byte $07			; 8-#
	.byte $88			; Duration = 8
	.byte $07			; 8-#
	.byte $F1			; RETURN
	; Pattern duration: 20.
