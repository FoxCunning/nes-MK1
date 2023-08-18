	.byte $00
	.word victory_goro_ch_00
	.byte $01
	.word victory_goro_ch_01
	.byte $02
	.word victory_goro_ch_02
	.byte $03
	.word victory_goro_ch_03
	.byte $FF

; -----------------------------------------------------------------------------
;						SQUARE WAVE 0 CHANNEL
; -----------------------------------------------------------------------------

victory_goro_ch_00:
	.byte $F5, $07	; Speed = 7
	@order_00:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $F8, $0F		; Volume Envelope = "Bamboo?"
	.byte $F9, $04		; Duty Envelope = "Bamboo?"
	.byte $FA, $FF		; Pitch Envelope = "Bamboo?"
	.byte $FB, $FF		; Arpeggio = "Bamboo?"
	.byte $81			; Duration = 1
	.byte $1C			; E-2
	.byte $1C			; E-2
	.byte $1C			; E-2
	.byte $83			; Duration = 3
	.byte $1C			; E-2
	.byte $81			; Duration = 1
	.byte $1C			; E-2
	.byte $1C			; E-2
	.byte $88			; Duration = 8
	.byte $1C			; E-2
	.byte $82			; Duration = 2
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 19.

; -----------------------------------------------------------------------------
;						SQUARE WAVE 1 CHANNEL
; -----------------------------------------------------------------------------

victory_goro_ch_01:
	.byte $F5, $07	; Speed = 7
	@order_01:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	;.byte $F3, $06		; DELAYED CUT = 6
	.byte $F8, $23		; Volume Envelope = "Goro Vibrato"
	.byte $F9, $0C		; Duty Envelope = "Goro Vibrato"
	.byte $FA, $02		; Pitch Envelope = "Goro Vibrato"
	.byte $FB, $FF		; Arpeggio = "Goro Vibrato"
	.byte $81			; Duration = 1
	.byte $23			; B-2
	;.byte $F3, $06		; DELAYED CUT = 6
	.byte $23			; B-2
	;.byte $F3, $06		; DELAYED CUT = 6
	.byte $23			; B-2
	.byte $83			; Duration = 3
	.byte $23			; B-2
	;.byte $F3, $06		; DELAYED CUT = 6
	.byte $81			; Duration = 1
	.byte $23			; B-2
	;.byte $F3, $06		; DELAYED CUT = 6
	.byte $23			; B-2
	.byte $88			; Duration = 8
	.byte $23			; B-2
	.byte $82			; Duration = 2
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 19.

; -----------------------------------------------------------------------------
;						TRIANGLE WAVE CHANNEL
; -----------------------------------------------------------------------------

victory_goro_ch_02:
	.byte $F5, $07	; Speed = 7
	@order_02:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $F3, $06		; DELAYED CUT = 6
	.byte $FA, $FF		; Pitch Envelope = "Blank"
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $81			; Duration = 1
	.byte $1C			; E-2
	.byte $F3, $06		; DELAYED CUT = 6
	.byte $1C			; E-2
	.byte $F3, $06		; DELAYED CUT = 6
	.byte $1C			; E-2
	.byte $83			; Duration = 3
	.byte $1C			; E-2
	.byte $F3, $06		; DELAYED CUT = 6
	.byte $81			; Duration = 1
	.byte $1C			; E-2
	.byte $F3, $06		; DELAYED CUT = 6
	.byte $1C			; E-2
	.byte $F3, $06		; DELAYED CUT = 6
	.byte $1C			; E-2
	.byte $87			; Duration = 7
	.byte $1C			; E-2
	.byte $82			; Duration = 2
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 19.

; -----------------------------------------------------------------------------
;						        NOISE CHANNEL
; -----------------------------------------------------------------------------

victory_goro_ch_03:
	.byte $F5, $07	; Speed = 7
	@order_03:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $F8, $08		; Volume Envelope = "Roll Drum"
	.byte $FB, $FF		; Arpeggio = "Roll Drum"
	.byte $81			; Duration = 1
	.byte $0D			; 2-#
	.byte $0D			; 2-#
	.byte $0D			; 2-#
	.byte $83			; Duration = 3
	.byte $0D			; 2-#
	.byte $81			; Duration = 1
	.byte $0D			; 2-#
	.byte $0D			; 2-#
	.byte $0D			; 2-#
	.byte $87			; Duration = 7
	.byte $0D			; 2-#
	.byte $F8, $03		; Volume Envelope = "Low Drum"
	.byte $FB, $05		; Arpeggio = "Low Drum"
	.byte $83			; Duration = 3
	.byte $0E			; 1-#
	.byte $F1			; RETURN
	; Pattern duration: 19.
