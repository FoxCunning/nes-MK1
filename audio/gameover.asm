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
	@order_00:
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
	.byte $82			; Duration = 2
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 26.

; -----------------------------------------------------------------------------
;						SQUARE WAVE 1 CHANNEL
; -----------------------------------------------------------------------------

gameover_ch_01:
	.byte $F5, $07	; Speed = 7
	@order_01:
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
	.byte $F8, $11		; Volume Envelope = "Synth 2"
	.byte $88			; Duration = 8
	.byte $28			; E-3
	.byte $82			; Duration = 2
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 26.

; -----------------------------------------------------------------------------
;						TRIANGLE WAVE CHANNEL
; -----------------------------------------------------------------------------

gameover_ch_02:
	.byte $F5, $07	; Speed = 7
	@order_02:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $FA, $FF		; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $82			; Duration = 2
	.byte $23			; B-2
	.byte $23			; B-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $23			; B-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $23			; B-2
	.byte $81			; Duration = 1
	.byte $23			; B-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $23			; B-2
	.byte $23			; B-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82			; Duration = 2
	.byte $23			; B-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $1A			; D-2
	.byte $81			; Duration = 1
	.byte $1A			; D-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $84			; Duration = 4
	.byte $26			; D-3
	.byte $83			; Duration = 3
	.byte $27			; D#3
	.byte $82			; Duration = 2
	.byte $28			; E-3
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 26.

; -----------------------------------------------------------------------------
;						        NOISE CHANNEL
; -----------------------------------------------------------------------------

gameover_ch_03:
	.byte $F5, $07	; Speed = 7
	@order_03:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $81			; Duration = 1
	.byte $06			; 9-#
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
	.byte $82			; Duration = 2
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $81			; Duration = 1
	.byte $06			; 9-#
	.byte $06			; 9-#
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $82			; Duration = 2
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $81			; Duration = 1
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $82			; Duration = 2
	.byte $08			; 7-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $81			; Duration = 1
	.byte $04			; B-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $82			; Duration = 2
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 64.
