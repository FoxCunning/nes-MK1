	.byte $00
	.word victory_jingle_ch_00
	.byte $01
	.word victory_jingle_ch_01
	.byte $02
	.word victory_jingle_ch_02
	.byte $03
	.word victory_jingle_ch_03
	.byte $FF

; -----------------------------------------------------------------------------
;						SQUARE WAVE 0 CHANNEL
; -----------------------------------------------------------------------------

victory_jingle_ch_00:
	.byte $F5, $03	; Speed = 3

	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $F8, $11		; Volume Envelope = "Synth 2"
	.byte $F9, $06		; Duty Envelope = "Synth 2"
	.byte $FA, $02		; Pitch Envelope = "Synth 2"
	.byte $FB, $FF		; Arpeggio = "Synth 2"
	.byte $82, $00
	.byte $81			; Duration = 1
	.byte $34			; E-4
	.byte $35			; F-4
	.byte $8E			; Duration = 14
	.byte $34			; E-4
	.byte $81			; Duration = 1
	.byte $2E			; A#3
	.byte $2F			; B-3
	.byte $8E			; Duration = 14
	.byte $2E			; A#3
	.byte $A0			; Duration = 32
	.byte $28			; E-3
	.byte $F1			; RETURN
	; Pattern duration: 64.

; -----------------------------------------------------------------------------
;						SQUARE WAVE 1 CHANNEL
; -----------------------------------------------------------------------------

victory_jingle_ch_01:
	.byte $F5, $03	; Speed = 3

	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $FB, $FF		; Arpeggio = "Pluck"
	.byte $82, $00
	.byte $82			; Duration = 2
	.byte $22			; A#2
	.byte $84			; Duration = 4
	.byte $1C			; E-2
	.byte $22			; A#2
	.byte $82			; Duration = 2
	.byte $1C			; E-2
	.byte $84			; Duration = 4
	.byte $22			; A#2
	.byte $82			; Duration = 2
	.byte $22			; A#2
	.byte $84			; Duration = 4
	.byte $22			; A#2
	.byte $22			; A#2
	.byte $82			; Duration = 2
	.byte $22			; A#2
	.byte $84			; Duration = 4
	.byte $1A			; D-2
	.byte $F8, $11		; Volume Envelope = "Synth 2"
	.byte $F9, $06		; Duty Envelope = "Synth 2"
	.byte $FA, $02		; Pitch Envelope = "Synth 2"
	.byte $A0			; Duration = 32
	.byte $22			; A#2
	.byte $F1			; RETURN
	; Pattern duration: 64.

; -----------------------------------------------------------------------------
;						TRIANGLE WAVE CHANNEL
; -----------------------------------------------------------------------------

victory_jingle_ch_02:
	.byte $F5, $03	; Speed = 3

	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $FA, $FF		; Pitch Envelope = "Tri Snare -> Bass"
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $82, $00
	.byte $82			; Duration = 2
	.byte $1C			; E-2
	.byte $84			; Duration = 4
	.byte $1C			; E-2
	.byte $81			; Duration = 1
	.byte $1C			; E-2
	.byte $83			; Duration = 3
	.byte $00			; REST
	.byte $82			; Duration = 2
	.byte $1C			; E-2
	.byte $81			; Duration = 1
	.byte $1C			; E-2
	.byte $83			; Duration = 3
	.byte $00			; REST
	.byte $81			; Duration = 1
	.byte $1C			; E-2
	.byte $00			; REST
	.byte $84			; Duration = 4
	.byte $1C			; E-2
	.byte $81			; Duration = 1
	.byte $1C			; E-2
	.byte $83			; Duration = 3
	.byte $00			; REST
	.byte $82			; Duration = 2
	.byte $17			; B-1
	.byte $81			; Duration = 1
	.byte $1C			; E-2
	.byte $83			; Duration = 3
	.byte $00			; REST
	.byte $A0			; Duration = 32
	.byte $1C			; E-2
	.byte $F1			; RETURN
	; Pattern duration: 64.

; -----------------------------------------------------------------------------
;						        NOISE CHANNEL
; -----------------------------------------------------------------------------

victory_jingle_ch_03:
	.byte $F5, $03	; Speed = 3

	.byte $F0	; CALL
	.word @pattern_00
	.byte $FF

	@pattern_00:
	.byte $F8, $0B		; Volume Envelope = "Bongo"
	.byte $FB, $07		; Arpeggio = "Bongo"
	.byte $82, $00
	.byte $81			; Duration = 1
	.byte $0A			; 5-#
	.byte $0C			; 3-#
	.byte $82			; Duration = 2
	.byte $0A			; 5-#
	.byte $0A			; 5-#
	.byte $84			; Duration = 4
	.byte $0A			; 5-#
	.byte $82			; Duration = 2
	.byte $0C			; 3-#
	.byte $84			; Duration = 4
	.byte $0A			; 5-#
	.byte $81			; Duration = 1
	.byte $0A			; 5-#
	.byte $0C			; 3-#
	.byte $82			; Duration = 2
	.byte $0A			; 5-#
	.byte $0A			; 5-#
	.byte $84			; Duration = 4
	.byte $0A			; 5-#
	.byte $82			; Duration = 2
	.byte $0C			; 3-#
	.byte $84			; Duration = 4
	.byte $0A			; 5-#
	.byte $F8, $11		; Volume Envelope = "Synth 2"
	.byte $FB, $FF		; Arpeggio = "Synth 2"
	.byte $88			; Duration = 8
	.byte $09			; 6-#
	.byte $F8, $14		; Volume Envelope = "Synth 2 Echo"
	.byte $98			; Duration = 24
	.byte $09			; 6-#
	.byte $F1			; RETURN
	; Pattern duration: 64.
