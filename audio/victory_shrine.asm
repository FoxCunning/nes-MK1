	.byte $00
	.word victory_shrine_ch_00
	.byte $01
	.word victory_shrine_ch_01
	.byte $02
	.word victory_shrine_ch_02
	.byte $03
	.word victory_shrine_ch_03
	.byte $FF

; -----------------------------------------------------------------------------
;						SQUARE WAVE 0 CHANNEL
; -----------------------------------------------------------------------------

victory_shrine_ch_00:
	;.byte $F5, $07	; Speed = 7
	@order_00:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $F5, $04		; SPEED = 4
	.byte $F8, $1B		; Volume Envelope = "Warrior Synth 2"
	.byte $F9, $08		; Duty Envelope = "Warrior Synth 2"
	.byte $FA, $04		; Pitch Envelope = "Warrior Synth 2"
	.byte $FB, $FF		; Arpeggio = "Warrior Synth 2"
	.byte $81			; Duration = 1
	.byte $32			; D-4
	.byte $F5, $03		; SPEED = 3
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $83			; Duration = 3
	.byte $01			; HOLD
	.byte $F5, $04		; SPEED = 4
	.byte $81			; Duration = 1
	.byte $01			; HOLD
	.byte $F5, $03		; SPEED = 3
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $93			; Duration = 19
	.byte $01			; HOLD
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 27.

; -----------------------------------------------------------------------------
;						SQUARE WAVE 1 CHANNEL
; -----------------------------------------------------------------------------

victory_shrine_ch_01:
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
	.byte $9A			; Duration = 26
	.byte $2D			; A-3
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 27.

; -----------------------------------------------------------------------------
;						TRIANGLE WAVE CHANNEL
; -----------------------------------------------------------------------------

victory_shrine_ch_02:
	;.byte $F5, $07	; Speed = 7
	@order_02:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $F8, $1B		; Volume Envelope = "Warrior Synth 2"
	.byte $FA, $04		; Pitch Envelope = "Warrior Synth 2"
	.byte $FB, $FF		; Arpeggio = "Warrior Synth 2"
	.byte $9A			; Duration = 26
	.byte $1A			; D-2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 27.

; -----------------------------------------------------------------------------
;						        NOISE CHANNEL
; -----------------------------------------------------------------------------

victory_shrine_ch_03:
	;.byte $F5, $07	; Speed = 7
	@order_03:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $F8, $08		; Volume Envelope = "Roll Drum"
	.byte $FB, $FF		; Arpeggio = "Roll Drum"
	.byte $81			; Duration = 1
	.byte $0C			; 3-#
	.byte $0C			; 3-#
	.byte $82			; Duration = 2
	.byte $0C			; 3-#
	.byte $81			; Duration = 1
	.byte $0C			; 3-#
	.byte $0D			; 2-#
	.byte $0D			; 2-#
	.byte $82			; Duration = 2
	.byte $0D			; 2-#
	.byte $81			; Duration = 1
	.byte $0E			; 1-#
	.byte $81			; Duration = 1
	.byte $0E			; 1-#
	.byte $F1			; RETURN
	; Pattern duration: 27.
