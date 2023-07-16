	.byte $00
	.word gameover_ch_00
	.byte $01
	.word gameover_ch_01
	.byte $02
	.word gameover_ch_02
	.byte $03
	.word gameover_ch_03
	.byte $FF

; -----------------------------------------------------------------------------
;						SQUARE WAVE 0 CHANNEL
; -----------------------------------------------------------------------------

gameover_ch_00:
	.byte $F5, $07	; Speed = 7

	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $F8, $11		; Volume Envelope = "Synth 2"
	.byte $F9, $06		; Duty Envelope = "Synth 2"
	.byte $FA, $02		; Pitch Envelope = "Synth 2"
	.byte $FB, $FF		; Arpeggio = "Synth 2"
	.byte $81			; Duration = 1
	.byte $3B			; B-4
	.byte $39			; A-4
	.byte $36			; F#4
	.byte $34			; E-4
	.byte $30			; C-4
	.byte $2D			; A-3
	.byte $2A			; F#3
	.byte $28			; E-3
	.byte $84			; Duration = 4
	.byte $23			; B-2
	.byte $2D			; A-3
	.byte $88			; Duration = 8
	.byte $36			; F#4
	.byte $88			; Duration = 8
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 32.

; -----------------------------------------------------------------------------
;						SQUARE WAVE 1 CHANNEL
; -----------------------------------------------------------------------------

gameover_ch_01:
	.byte $F5, $07	; Speed = 7

	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $82			; Duration = 2
	.byte $01			; HOLD
	.byte $F8, $14		; Volume Envelope = "Synth 2 Echo"
	.byte $F9, $06		; Duty Envelope = "Synth 2 Echo"
	.byte $FA, $02		; Pitch Envelope = "Synth 2 Echo"
	.byte $FB, $FF		; Arpeggio = "Synth 2 Echo"
	.byte $81			; Duration = 1
	.byte $3B			; B-4
	.byte $39			; A-4
	.byte $36			; F#4
	.byte $34			; E-4
	.byte $30			; C-4
	.byte $2D			; A-3
	.byte $2A			; F#3
	.byte $28			; E-3
	.byte $84			; Duration = 4
	.byte $23			; B-2
	.byte $82			; Duration = 2
	.byte $2D			; A-3
	.byte $F8, $07		; Volume Envelope = "Pulse Bass"
	.byte $F9, $01		; Duty Envelope = "Pulse Bass"
	.byte $FA, $FF		; Pitch Envelope = "Pulse Bass"
	.byte $88			; Duration = 8
	.byte $28			; E-3
	.byte $88			; Duration = 8
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 32.

; -----------------------------------------------------------------------------
;						TRIANGLE WAVE CHANNEL
; -----------------------------------------------------------------------------

gameover_ch_02:
	.byte $F5, $07	; Speed = 7

	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $FA, $FF		; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $82			; Duration = 2
	.byte $23			; B-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $23			; B-2
	.byte $00			; REST
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $23			; B-2
	.byte $81			; Duration = 1
	.byte $23			; B-2
	.byte $00			; REST
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $23			; B-2
	.byte $23			; B-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $82			; Duration = 2
	.byte $23			; B-2
	.byte $1A			; D-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $84			; Duration = 4
	.byte $26			; D-3
	.byte $83			; Duration = 3
	.byte $27			; D#3
	.byte $28			; E-3
	.byte $86			; Duration = 6
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 32.

; -----------------------------------------------------------------------------
;						        NOISE CHANNEL
; -----------------------------------------------------------------------------

gameover_ch_03:
	.byte $F5, $07	; Speed = 7

	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $81			; Duration = 1
	.byte $0D			; 2-#
	.byte $0D			; 2-#
	.byte $09			; 6-#
	.byte $09			; 6-#
	.byte $82			; Duration = 2
	.byte $04			; B-#
	.byte $04			; B-#
	.byte $84			; Duration = 4
	.byte $09			; 6-#
	.byte $0D			; 2-#
	.byte $81			; Duration = 1
	.byte $04			; B-#
	.byte $04			; B-#
	.byte $0B			; 4-#
	.byte $0B			; 4-#
	.byte $09			; 6-#
	.byte $09			; 6-#
	.byte $04			; B-#
	.byte $09			; 6-#
	.byte $87			; Duration = 7
	.byte $00			; REST
	.byte $81			; Duration = 1
	.byte $01			; E-#
	.byte $F1			; RETURN
	; Pattern duration: 32.
