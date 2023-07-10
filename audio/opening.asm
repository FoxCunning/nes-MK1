	.byte $00
	.word opening_ch_00
	.byte $01
	.word opening_ch_01
	.byte $02
	.word opening_ch_02
	.byte $03
	.word opening_ch_03
	.byte $FF

; -----------------------------------------------------------------------------
;						SQUARE WAVE 0 CHANNEL
; -----------------------------------------------------------------------------

opening_ch_00:
	@order_00:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F4	; JUMP
	.word @order_00

	@pattern_00:
	.byte $F5, $03		; SPEED = 3
	.byte $F8, $0A		; Volume Envelope = "Pluck (Quiet)"
	.byte $F9, $02		; Duty Envelope = "Pluck (Quiet)"
	.byte $FA, $FF		; Pitch Envelope = "Pluck (Quiet)"
	.byte $FB, $FF		; Arpeggio = "Pluck (Quiet)"
	.byte $81			; Duration = 1
	.byte $27			; D#3
	.byte $F5, $04		; SPEED = 4
	.byte $29			; F-3
	.byte $F5, $03		; SPEED = 3
	.byte $2C			; G#3
	.byte $F5, $04		; SPEED = 4
	.byte $2E			; A#3
	.byte $F5, $03		; SPEED = 3
	.byte $30			; C-4
	.byte $F5, $04		; SPEED = 4
	.byte $33			; D#4
	.byte $F5, $03		; SPEED = 3
	.byte $35			; F-4
	.byte $F5, $04		; SPEED = 4
	.byte $38			; G#4
	.byte $F5, $03		; SPEED = 3
	.byte $35			; F-4
	.byte $F5, $04		; SPEED = 4
	.byte $33			; D#4
	.byte $F5, $03		; SPEED = 3
	.byte $30			; C-4
	.byte $F5, $04		; SPEED = 4
	.byte $2E			; A#3
	.byte $F5, $03		; SPEED = 3
	.byte $2C			; G#3
	.byte $F5, $04		; SPEED = 4
	.byte $29			; F-3
	.byte $F5, $03		; SPEED = 3
	.byte $27			; D#3
	.byte $F5, $04		; SPEED = 4
	.byte $24			; C-3
	.byte $F5, $03		; SPEED = 3
	.byte $27			; D#3
	.byte $F5, $04		; SPEED = 4
	.byte $29			; F-3
	.byte $F5, $03		; SPEED = 3
	.byte $2C			; G#3
	.byte $F5, $04		; SPEED = 4
	.byte $2E			; A#3
	.byte $F5, $03		; SPEED = 3
	.byte $30			; C-4
	.byte $F5, $04		; SPEED = 4
	.byte $33			; D#4
	.byte $F5, $03		; SPEED = 3
	.byte $35			; F-4
	.byte $F5, $04		; SPEED = 4
	.byte $38			; G#4
	.byte $F5, $03		; SPEED = 3
	.byte $35			; F-4
	.byte $F5, $04		; SPEED = 4
	.byte $33			; D#4
	.byte $F5, $03		; SPEED = 3
	.byte $30			; C-4
	.byte $F5, $04		; SPEED = 4
	.byte $2E			; A#3
	.byte $F5, $03		; SPEED = 3
	.byte $2C			; G#3
	.byte $F5, $04		; SPEED = 4
	.byte $29			; F-3
	.byte $F5, $03		; SPEED = 3
	.byte $27			; D#3
	.byte $F5, $04		; SPEED = 4
	.byte $24			; C-3
	.byte $F1			; RETURN
	; Pattern duration: 32.

	@pattern_01:
	.byte $F5, $07		; SPEED = 7
	.byte $F8, $05		; Volume Envelope = "Synth Lead"
	.byte $F9, $00		; Duty Envelope = "Synth Lead"
	.byte $FA, $FF		; Pitch Envelope = "Synth Lead"
	.byte $FB, $FF		; Arpeggio = "Synth Lead"
	.byte $84			; Duration = 4
	.byte $1D			; F-2
	.byte $F8, $06		; Volume Envelope = "Synth Echo"
	.byte $9C			; Duration = 28
	.byte $1D			; F-2
	.byte $F1			; RETURN
	; Pattern duration: 32.

	@pattern_02:
	.byte $82			; Duration = 2
	.byte $01			; HOLD
	.byte $F8, $18		; Volume Envelope = "Opening Synth"
	.byte $F9, $07		; Duty Envelope = "Opening Synth"
	.byte $FA, $FF		; Pitch Envelope = "Opening Synth"
	.byte $FB, $FF		; Arpeggio = "Opening Synth"
	.byte $24			; C-3
	.byte $27			; D#3
	.byte $29			; F-3
	.byte $81			; Duration = 1
	.byte $2C			; G#3
	.byte $F2, $07		; NOTE DELAY = 7
	.byte $29			; F-3
	.byte $F2, $03		; NOTE DELAY = 3
	.byte $2C			; G#3
	.byte $29			; F-3
	.byte $82			; Duration = 2
	.byte $27			; D#3
	.byte $81			; Duration = 1
	.byte $24			; C-3
	.byte $F2, $07		; NOTE DELAY = 7
	.byte $22			; A#2
	.byte $F2, $03		; NOTE DELAY = 3
	.byte $24			; C-3
	.byte $22			; A#2
	.byte $82			; Duration = 2
	.byte $20			; G#2
	.byte $FC, $16		; NOTE SLIDE UP = 4
	.byte $84			; Duration = 4
	.byte $20			; G#2
	.byte $F8, $21		; Volume Envelope = "Opening Synth Vibrato 4"
	.byte $F9, $0B		; Duty Envelope = "Opening Synth Vibrato 4"
	.byte $FA, $06		; Pitch Envelope = "Opening Synth Vibrato 4"
	.byte $88			; Duration = 8
	.byte $24			; C-3
	.byte $F1			; RETURN
	; Pattern duration: 32.

	@pattern_03:
	.byte $F8, $18		; Volume Envelope = "Opening Synth"
	.byte $F9, $07		; Duty Envelope = "Opening Synth"
	.byte $FA, $FF		; Pitch Envelope = "Opening Synth"
	.byte $FB, $FF		; Arpeggio = "Opening Synth"
	.byte $82			; Duration = 2
	.byte $2E			; A#3
	.byte $2C			; G#3
	.byte $29			; F-3
	.byte $27			; D#3
	.byte $FC, $08		; NOTE SLIDE UP = 2
	.byte $27			; D#3
	.byte $F8, $21		; Volume Envelope = "Opening Synth Vibrato 2"
	.byte $F9, $0B		; Duty Envelope = "Opening Synth Vibrato 2"
	.byte $FA, $05		; Pitch Envelope = "Opening Synth Vibrato 2"
	.byte $83			; Duration = 3
	.byte $29			; F-3
	.byte $F2, $07		; NOTE DELAY = 7
	.byte $F8, $18		; Volume Envelope = "Opening Synth"
	.byte $F9, $07		; Duty Envelope = "Opening Synth"
	.byte $FA, $FF		; Pitch Envelope = "Opening Synth"
	.byte $81			; Duration = 1
	.byte $2C			; G#3
	.byte $F2, $03		; NOTE DELAY = 3
	.byte $2E			; A#3
	.byte $27			; D#3
	.byte $86			; Duration = 6
	.byte $29			; F-3
	.byte $F8, $21		; Volume Envelope = "Opening Synth Vibrato 4"
	.byte $F9, $0B		; Duty Envelope = "Opening Synth Vibrato 4"
	.byte $FA, $06		; Pitch Envelope = "Opening Synth Vibrato 4"
	.byte $29			; F-3
	.byte $F2, $06		; NOTE DELAY = 6
	.byte $F8, $20		; Volume Envelope = "Opening Synth fade"
	.byte $F9, $0A		; Duty Envelope = "Opening Synth fade"
	.byte $84			; Duration = 4
	.byte $29			; F-3
	.byte $F1			; RETURN
	; Pattern duration: 32.

; -----------------------------------------------------------------------------
;						SQUARE WAVE 1 CHANNEL
; -----------------------------------------------------------------------------

opening_ch_01:
	@order_01:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F4	; JUMP
	.word @order_01

	@pattern_00:
	.byte $83			; Duration = 3
	.byte $01			; HOLD
	.byte $9D			; Duration = 29
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 32.

	@pattern_01:
	.byte $82			; Duration = 2
	.byte $01			; HOLD
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $FB, $FF		; Arpeggio = "Pluck"
	.byte $81			; Duration = 1
	.byte $11			; F-1
	.byte $11			; F-1
	.byte $82			; Duration = 2
	.byte $14			; G#1
	.byte $84			; Duration = 4
	.byte $11			; F-1
	.byte $81			; Duration = 1
	.byte $1D			; F-2
	.byte $1D			; F-2
	.byte $82			; Duration = 2
	.byte $20			; G#2
	.byte $84			; Duration = 4
	.byte $1D			; F-2
	.byte $81			; Duration = 1
	.byte $11			; F-1
	.byte $11			; F-1
	.byte $82			; Duration = 2
	.byte $14			; G#1
	.byte $84			; Duration = 4
	.byte $11			; F-1
	.byte $81			; Duration = 1
	.byte $1D			; F-2
	.byte $1D			; F-2
	.byte $82			; Duration = 2
	.byte $20			; G#2
	.byte $1D			; F-2
	.byte $F1			; RETURN
	; Pattern duration: 32.

	@pattern_02:
	.byte $82			; Duration = 2
	.byte $01			; HOLD
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $FB, $FF		; Arpeggio = "Pluck"
	.byte $81			; Duration = 1
	.byte $11			; F-1
	.byte $11			; F-1
	.byte $14			; G#1
	.byte $F8, $19		; Volume Envelope = "Opening Synth Echo"
	.byte $F9, $07		; Duty Envelope = "Opening Synth Echo"
	.byte $82			; Duration = 2
	.byte $24			; C-3
	.byte $27			; D#3
	.byte $29			; F-3
	.byte $81			; Duration = 1
	.byte $2C			; G#3
	.byte $F2, $07		; NOTE DELAY = 7
	.byte $29			; F-3
	.byte $F2, $03		; NOTE DELAY = 3
	.byte $2C			; G#3
	.byte $29			; F-3
	.byte $82			; Duration = 2
	.byte $27			; D#3
	.byte $81			; Duration = 1
	.byte $24			; C-3
	.byte $F2, $07		; NOTE DELAY = 7
	.byte $22			; A#2
	.byte $F2, $03		; NOTE DELAY = 3
	.byte $24			; C-3
	.byte $22			; A#2
	.byte $82			; Duration = 2
	.byte $20			; G#2
	.byte $FC, $16		; NOTE SLIDE UP = 4
	.byte $84			; Duration = 4
	.byte $20			; G#2
	.byte $F8, $22		; Volume Envelope = "Opening Echo Vib 4"
	.byte $F9, $0B		; Duty Envelope = "Opening Echo Vib 4"
	.byte $FA, $06		; Pitch Envelope = "Opening Echo Vib 4"
	.byte $85			; Duration = 5
	.byte $24			; C-3
	.byte $F1			; RETURN
	; Pattern duration: 32.

	@pattern_03:
	.byte $83			; Duration = 3
	.byte $01			; HOLD
	.byte $F8, $19		; Volume Envelope = "Opening Synth Echo"
	.byte $F9, $07		; Duty Envelope = "Opening Synth Echo"
	.byte $FA, $FF		; Pitch Envelope = "Opening Synth Echo"
	.byte $FB, $FF		; Arpeggio = "Opening Synth Echo"
	.byte $82			; Duration = 2
	.byte $2E			; A#3
	.byte $2C			; G#3
	.byte $29			; F-3
	.byte $27			; D#3
	.byte $FC, $08		; NOTE SLIDE UP = 2
	.byte $27			; D#3
	.byte $F8, $22		; Volume Envelope = "Opening Echo Vib 2"
	.byte $F9, $0B		; Duty Envelope = "Opening Echo Vib 2"
	.byte $FA, $05		; Pitch Envelope = "Opening Echo Vib 2"
	.byte $83			; Duration = 3
	.byte $29			; F-3
	.byte $F2, $07		; NOTE DELAY = 7
	.byte $F8, $19		; Volume Envelope = "Opening Synth Echo"
	.byte $F9, $07		; Duty Envelope = "Opening Synth Echo"
	.byte $FA, $FF		; Pitch Envelope = "Opening Synth Echo"
	.byte $81			; Duration = 1
	.byte $2C			; G#3
	.byte $F2, $03		; NOTE DELAY = 3
	.byte $2E			; A#3
	.byte $27			; D#3
	.byte $86			; Duration = 6
	.byte $29			; F-3
	.byte $F8, $22		; Volume Envelope = "Opening Echo Vib 4"
	.byte $F9, $0B		; Duty Envelope = "Opening Echo Vib 4"
	.byte $FA, $06		; Pitch Envelope = "Opening Echo Vib 4"
	.byte $87			; Duration = 7
	.byte $29			; F-3
	.byte $F1			; RETURN
	; Pattern duration: 32.

; -----------------------------------------------------------------------------
;						TRIANGLE WAVE CHANNEL
; -----------------------------------------------------------------------------

opening_ch_02:
	@order_02:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F4	; JUMP
	.word @order_02

	@pattern_00:
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $FA, $FF		; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $84			; Duration = 4
	.byte $24			; C-3
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $26			; D-3
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $24			; C-3
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $26			; D-3
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $24			; C-3
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $26			; D-3
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $24			; C-3
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $24			; C-3
	.byte $F1			; RETURN
	; Pattern duration: 32.

	@pattern_01:
	.byte $FA, $FF		; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $82			; Duration = 2
	.byte $1D			; F-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $1D			; F-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $1D			; F-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $1D			; F-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $1D			; F-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $1D			; F-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $1D			; F-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $81			; Duration = 1
	.byte $1D			; F-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $1D			; F-2
	.byte $82			; Duration = 2
	.byte $1D			; F-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $1D			; F-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $1D			; F-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $1D			; F-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $1D			; F-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $1D			; F-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $1D			; F-2
	.byte $1B			; D#2
	.byte $F1			; RETURN
	; Pattern duration: 32.

; -----------------------------------------------------------------------------
;						        NOISE CHANNEL
; -----------------------------------------------------------------------------

opening_ch_03:
	@order_03:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F4	; JUMP
	.word @order_03

	@pattern_00:
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $84			; Duration = 4
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $82			; Duration = 2
	.byte $06			; 9-#
	.byte $06			; 9-#
	.byte $F1			; RETURN
	; Pattern duration: 32.

	@pattern_01:
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $82			; Duration = 2
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $81			; Duration = 1
	.byte $06			; 9-#
	.byte $06			; 9-#
	.byte $82			; Duration = 2
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $06			; 9-#
	.byte $81			; Duration = 1
	.byte $06			; 9-#
	.byte $06			; 9-#
	.byte $F1			; RETURN
	; Pattern duration: 32.
