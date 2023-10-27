	.byte $00
	.word techno_syndrome_ch_00
	.byte $01
	.word techno_syndrome_ch_01
	.byte $02
	.word techno_syndrome_ch_02
	.byte $03
	.word techno_syndrome_ch_03
	.byte $FF

; -----------------------------------------------------------------------------
;						SQUARE WAVE 0 CHANNEL
; -----------------------------------------------------------------------------

techno_syndrome_ch_00:
	.byte $F5, $07	; Speed = 7
	.byte $F0	; CALL
	.word @pattern_04
	.byte $F0	; CALL
	.word @pattern_05
	.byte $F0	; CALL
	.word @pattern_03
	@order_00:
	.byte $F0	; CALL
	.word @pattern_06
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_07
	.byte $F0	; CALL
	.word @pattern_08
	.byte $F4	; JUMP
	.word @order_00

	@pattern_01:
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $FB, $FF		; Arpeggio = "Pluck"
	.byte $81			; Duration = 1
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $34			; E-4
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $2E			; A#3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $2E			; A#3
	.byte $F5, $06		; SPEED = 6
	.byte $2B			; G-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $34			; E-4
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $2E			; A#3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $2E			; A#3
	.byte $F5, $06		; SPEED = 6
	.byte $2B			; G-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $34			; E-4
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $2E			; A#3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $2E			; A#3
	.byte $F5, $06		; SPEED = 6
	.byte $2B			; G-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $34			; E-4
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2B			; G-3
	.byte $F5, $07		; SPEED = 7
	.byte $2B			; G-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2B			; G-3
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_03:
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $FB, $FF		; Arpeggio = "Pluck"
	.byte $81			; Duration = 1
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2B			; G-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2B			; G-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $28			; E-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2B			; G-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_04:
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $2C		; Volume Envelope = "Theme String"
	.byte $F9, $0F		; Duty Envelope = "Theme String"
	.byte $FA, $04		; Pitch Envelope = "Theme String"
	.byte $FB, $FF		; Arpeggio = "Theme String"
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $F5, $07		; SPEED = 7
	.byte $83			; Duration = 3
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $81			; Duration = 1
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $83			; Duration = 3
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $81			; Duration = 1
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $83			; Duration = 3
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $81			; Duration = 1
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $83			; Duration = 3
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $81			; Duration = 1
	.byte $24			; C-3
	.byte $F5, $07		; SPEED = 7
	.byte $83			; Duration = 3
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $81			; Duration = 1
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $83			; Duration = 3
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $81			; Duration = 1
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $83			; Duration = 3
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $81			; Duration = 1
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $83			; Duration = 3
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $81			; Duration = 1
	.byte $1F			; G-2
	.byte $F5, $07		; SPEED = 7
	.byte $83			; Duration = 3
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $81			; Duration = 1
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $83			; Duration = 3
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $81			; Duration = 1
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $83			; Duration = 3
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $81			; Duration = 1
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $83			; Duration = 3
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $81			; Duration = 1
	.byte $1D			; F-2
	.byte $F5, $07		; SPEED = 7
	.byte $83			; Duration = 3
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $81			; Duration = 1
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $83			; Duration = 3
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $81			; Duration = 1
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $83			; Duration = 3
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $81			; Duration = 1
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $83			; Duration = 3
	.byte $01			; HOLD
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_05:
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $FB, $FF		; Arpeggio = "Pluck"
	.byte $81			; Duration = 1
	.byte $15			; A-1
	.byte $F5, $07		; SPEED = 7
	.byte $15			; A-1
	.byte $15			; A-1
	.byte $15			; A-1
	.byte $F5, $06		; SPEED = 6
	.byte $15			; A-1
	.byte $F5, $07		; SPEED = 7
	.byte $15			; A-1
	.byte $13			; G-1
	.byte $13			; G-1
	.byte $F5, $06		; SPEED = 6
	.byte $15			; A-1
	.byte $F5, $07		; SPEED = 7
	.byte $15			; A-1
	.byte $15			; A-1
	.byte $15			; A-1
	.byte $F5, $06		; SPEED = 6
	.byte $15			; A-1
	.byte $F5, $07		; SPEED = 7
	.byte $15			; A-1
	.byte $13			; G-1
	.byte $13			; G-1
	.byte $F5, $06		; SPEED = 6
	.byte $15			; A-1
	.byte $F5, $07		; SPEED = 7
	.byte $15			; A-1
	.byte $15			; A-1
	.byte $15			; A-1
	.byte $F5, $06		; SPEED = 6
	.byte $15			; A-1
	.byte $F5, $07		; SPEED = 7
	.byte $15			; A-1
	.byte $13			; G-1
	.byte $13			; G-1
	.byte $F5, $06		; SPEED = 6
	.byte $15			; A-1
	.byte $F5, $07		; SPEED = 7
	.byte $15			; A-1
	.byte $15			; A-1
	.byte $15			; A-1
	.byte $F5, $06		; SPEED = 6
	.byte $15			; A-1
	.byte $F5, $07		; SPEED = 7
	.byte $15			; A-1
	.byte $13			; G-1
	.byte $13			; G-1
	.byte $F5, $06		; SPEED = 6
	.byte $15			; A-1
	.byte $F5, $07		; SPEED = 7
	.byte $15			; A-1
	.byte $15			; A-1
	.byte $15			; A-1
	.byte $F5, $06		; SPEED = 6
	.byte $15			; A-1
	.byte $F5, $07		; SPEED = 7
	.byte $15			; A-1
	.byte $13			; G-1
	.byte $13			; G-1
	.byte $F5, $06		; SPEED = 6
	.byte $15			; A-1
	.byte $F5, $07		; SPEED = 7
	.byte $15			; A-1
	.byte $15			; A-1
	.byte $15			; A-1
	.byte $F5, $06		; SPEED = 6
	.byte $15			; A-1
	.byte $F5, $07		; SPEED = 7
	.byte $15			; A-1
	.byte $13			; G-1
	.byte $13			; G-1
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $0A		; Volume Envelope = "Pluck (Quiet)"
	.byte $15			; A-1
	.byte $F5, $07		; SPEED = 7
	.byte $15			; A-1
	.byte $15			; A-1
	.byte $15			; A-1
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $83			; Duration = 3
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $81			; Duration = 1
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $83			; Duration = 3
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $81			; Duration = 1
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $83			; Duration = 3
	.byte $01			; HOLD
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_06:
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $FB, $FF		; Arpeggio = "Pluck"
	.byte $81			; Duration = 1
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2B			; G-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $30			; C-4
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2B			; G-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $30			; C-4
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2B			; G-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $30			; C-4
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_07:
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $FB, $FF		; Arpeggio = "Pluck"
	.byte $81			; Duration = 1
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $34			; E-4
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $2E			; A#3
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $2E			; A#3
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $30			; C-4
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $34			; E-4
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $2E			; A#3
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $2E			; A#3
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $30			; C-4
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $34			; E-4
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $2E			; A#3
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $2E			; A#3
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $F9, $0E		; Duty Envelope = "Pulse Tom"
	.byte $FA, $07		; Pitch Envelope = "Pulse Tom"
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $30			; C-4
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $34			; E-4
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2B			; G-3
	.byte $F5, $07		; SPEED = 7
	.byte $2B			; G-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2B			; G-3
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_08:
	.byte $F5, $06		; SPEED = 6
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $FB, $FF		; Arpeggio = "Pluck"
	.byte $81			; Duration = 1
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2B			; G-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2B			; G-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $28			; E-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2B			; G-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $30			; C-4
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $2D			; A-3
	.byte $F5, $06		; SPEED = 6
	.byte $2D			; A-3
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F5, $06		; SPEED = 6
	.byte $01			; HOLD
	.byte $F5, $07		; SPEED = 7
	.byte $01			; HOLD
	.byte $F1			; RETURN
	; Pattern duration: 64.

; -----------------------------------------------------------------------------
;						SQUARE WAVE 1 CHANNEL
; -----------------------------------------------------------------------------

techno_syndrome_ch_01:
	.byte $F5, $07	; Speed = 7
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F0	; CALL
	.word @pattern_02
	@order_01:
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F4	; JUMP
	.word @order_01

	@pattern_01:
	.byte $F8, $2A		; Volume Envelope = "Orch Hit 0 7 12"
	.byte $F9, $10		; Duty Envelope = "Orch Hit 0 7 12"
	.byte $FA, $FF		; Pitch Envelope = "Orch Hit 0 7 12"
	.byte $FB, $0C		; Arpeggio = "Orch Hit 0 7 12"
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $82			; Duration = 2
	.byte $28			; E-3
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $82			; Duration = 2
	.byte $24			; C-3
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $82			; Duration = 2
	.byte $22			; A#2
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $82			; Duration = 2
	.byte $24			; C-3
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $22			; A#2
	.byte $82			; Duration = 2
	.byte $1F			; G-2
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $82			; Duration = 2
	.byte $28			; E-3
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $82			; Duration = 2
	.byte $24			; C-3
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $82			; Duration = 2
	.byte $22			; A#2
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $82			; Duration = 2
	.byte $24			; C-3
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $22			; A#2
	.byte $82			; Duration = 2
	.byte $1F			; G-2
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $82			; Duration = 2
	.byte $28			; E-3
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $82			; Duration = 2
	.byte $24			; C-3
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $82			; Duration = 2
	.byte $22			; A#2
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $82			; Duration = 2
	.byte $24			; C-3
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $22			; A#2
	.byte $82			; Duration = 2
	.byte $1F			; G-2
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $82			; Duration = 2
	.byte $28			; E-3
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $82			; Duration = 2
	.byte $24			; C-3
	.byte $81			; Duration = 1
	.byte $1F			; G-2
	.byte $82			; Duration = 2
	.byte $1F			; G-2
	.byte $81			; Duration = 1
	.byte $1F			; G-2
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $84			; Duration = 4
	.byte $21			; A-2
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_02:
	.byte $F8, $26		; Volume Envelope = "Orch Hit 0 7 12"
	.byte $F9, $0D		; Duty Envelope = "Orch Hit 0 7 12"
	.byte $FA, $FF		; Pitch Envelope = "Orch Hit 0 7 12"
	.byte $FB, $0C		; Arpeggio = "Orch Hit 0 7 12"
	.byte $83			; Duration = 3
	.byte $21			; A-2
	.byte $21			; A-2
	.byte $21			; A-2
	.byte $21			; A-2
	.byte $82			; Duration = 2
	.byte $1F			; G-2
	.byte $24			; C-3
	.byte $83			; Duration = 3
	.byte $21			; A-2
	.byte $21			; A-2
	.byte $21			; A-2
	.byte $21			; A-2
	.byte $82			; Duration = 2
	.byte $1F			; G-2
	.byte $1C			; E-2
	.byte $83			; Duration = 3
	.byte $21			; A-2
	.byte $21			; A-2
	.byte $21			; A-2
	.byte $21			; A-2
	.byte $82			; Duration = 2
	.byte $1F			; G-2
	.byte $24			; C-3
	.byte $83			; Duration = 3
	.byte $21			; A-2
	.byte $21			; A-2
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $84			; Duration = 4
	.byte $21			; A-2
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_03:
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $F9, $0D		; Duty Envelope = "Theme Intro"
	.byte $FA, $FF		; Pitch Envelope = "Theme Intro"
	.byte $FB, $0E		; Arpeggio = "Theme Intro"
	.byte $81			; Duration = 1
	.byte $2D			; A-3
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $2F			; B-3
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $2D			; A-3
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $2D			; A-3
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $30			; C-4
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $2D			; A-3
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $2D			; A-3
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $30			; C-4
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $32			; D-4
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $2D			; A-3
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $2D			; A-3
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $32			; D-4
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $34			; E-4
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $2D			; A-3
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $32			; D-4
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $34			; E-4
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $30			; C-4
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $32			; D-4
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $30			; C-4
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $30			; C-4
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $34			; E-4
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $30			; C-4
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $30			; C-4
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $34			; E-4
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $37			; G-4
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $30			; C-4
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $30			; C-4
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $37			; G-4
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $34			; E-4
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $30			; C-4
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $30			; C-4
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $34			; E-4
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $2B			; G-3
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $30			; C-4
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $2B			; G-3
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $2B			; G-3
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $2F			; B-3
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $2B			; G-3
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $2B			; G-3
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $2F			; B-3
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $30			; C-4
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $2B			; G-3
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $2B			; G-3
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $30			; C-4
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $32			; D-4
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $2B			; G-3
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $30			; C-4
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $32			; D-4
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $29			; F-3
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $30			; C-4
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $29			; F-3
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $29			; F-3
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $2D			; A-3
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $29			; F-3
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $29			; F-3
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $2D			; A-3
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $30			; C-4
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $29			; F-3
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $29			; F-3
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $30			; C-4
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $30			; C-4
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $29			; F-3
	.byte $F8, $27		; Volume Envelope = "Theme Intro"
	.byte $2F			; B-3
	.byte $F8, $29		; Volume Envelope = "Theme Intro Echo"
	.byte $30			; C-4
	.byte $F1			; RETURN
	; Pattern duration: 64.


; -----------------------------------------------------------------------------
;						TRIANGLE WAVE CHANNEL
; -----------------------------------------------------------------------------

techno_syndrome_ch_02:
	.byte $F5, $07	; Speed = 7
	.byte $F0	; CALL
	.word @pattern_04
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_01
	@order_02:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F4	; JUMP
	.word @order_02

	@pattern_00:
	.byte $FA, $FF		; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $21			; A-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $21			; A-2
	.byte $00			; REST
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $1F			; G-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $21			; A-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $21			; A-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $1F			; G-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $21			; A-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $21			; A-2
	.byte $00			; REST
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $1F			; G-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $21			; A-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $21			; A-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $1F			; G-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $21			; A-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $21			; A-2
	.byte $00			; REST
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $1F			; G-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $21			; A-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $21			; A-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $1F			; G-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $1F			; G-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $24			; C-3
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $24			; C-3
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $82			; Duration = 2
	.byte $24			; C-3
	.byte $81			; Duration = 1
	.byte $26			; D-3
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $26			; D-3
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_01:
	.byte $FA, $FF		; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $21			; A-2
	.byte $21			; A-2
	.byte $00			; REST
	.byte $1F			; G-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $21			; A-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $21			; A-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $1F			; G-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $21			; A-2
	.byte $21			; A-2
	.byte $00			; REST
	.byte $1F			; G-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $21			; A-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $21			; A-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $1F			; G-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $21			; A-2
	.byte $21			; A-2
	.byte $00			; REST
	.byte $1F			; G-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $21			; A-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $21			; A-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $1F			; G-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $1F			; G-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $24			; C-3
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $24			; C-3
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $82			; Duration = 2
	.byte $24			; C-3
	.byte $81			; Duration = 1
	.byte $26			; D-3
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $26			; D-3
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_02:
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $FA, $FF		; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $C0			; Duration = 64
	.byte $18			; C-2
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_03:
	.byte $FA, $FF		; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $21			; A-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $21			; A-2
	.byte $00			; REST
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $1F			; G-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $21			; A-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $21			; A-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $1F			; G-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $21			; A-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $21			; A-2
	.byte $00			; REST
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $1F			; G-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $21			; A-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $21			; A-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $1F			; G-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $21			; A-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $21			; A-2
	.byte $00			; REST
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $1F			; G-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $21			; A-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $21			; A-2
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $81			; Duration = 1
	.byte $21			; A-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $1F			; G-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $82			; Duration = 2
	.byte $21			; A-2
	.byte $81			; Duration = 1
	.byte $00			; REST
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $21			; A-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $21			; A-2
	.byte $00			; REST
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $1F			; G-2
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $24			; C-3
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $24			; C-3
	.byte $F3, $05		; DELAYED CUT = 5
	.byte $82			; Duration = 2
	.byte $24			; C-3
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $81			; Duration = 1
	.byte $26			; D-3
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $26			; D-3
	.byte $F3, $02		; DELAYED CUT = 2
	.byte $01			; HOLD
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_04:
	.byte $C0			; Duration = 64
	.byte $01			; HOLD
	.byte $F1			; RETURN
	; Pattern duration: 64.


; -----------------------------------------------------------------------------
;						        NOISE CHANNEL
; -----------------------------------------------------------------------------

techno_syndrome_ch_03:
	.byte $F5, $07	; Speed = 7
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_04
	@order_03:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F4	; JUMP
	.word @order_03

	@pattern_00:
	.byte $F8, $25		; Volume Envelope = "Crash"
	.byte $FB, $0B		; Arpeggio = "Crash"
	.byte $84			; Duration = 4
	.byte $08			; 7-#
	.byte $F8, $2D		; Volume Envelope = "Snare Crash Tail"
	.byte $FB, $10		; Arpeggio = "Snare Crash Tail"
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $81			; Duration = 1
	.byte $06			; 9-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $82			; Duration = 2
	.byte $04			; B-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $81			; Duration = 1
	.byte $06			; 9-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $82			; Duration = 2
	.byte $04			; B-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $81			; Duration = 1
	.byte $06			; 9-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $82			; Duration = 2
	.byte $04			; B-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $81			; Duration = 1
	.byte $06			; 9-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $82			; Duration = 2
	.byte $04			; B-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $81			; Duration = 1
	.byte $06			; 9-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $82			; Duration = 2
	.byte $04			; B-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $F8, $2B		; Volume Envelope = "Reverse Crash"
	.byte $FB, $FF		; Arpeggio = "Reverse Crash"
	.byte $90			; Duration = 16
	.byte $07			; 8-#
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_01:
	.byte $C0			; Duration = 64
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_02:
	.byte $F8, $25		; Volume Envelope = "Crash"
	.byte $FB, $0B		; Arpeggio = "Crash"
	.byte $B0			; Duration = 48
	.byte $08			; 7-#
	.byte $F8, $28		; Volume Envelope = "Pulse Tom"
	.byte $FB, $FF		; Arpeggio = "Pulse Tom"
	.byte $88			; Duration = 8
	.byte $00			; REST
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_03:
	.byte $F8, $25		; Volume Envelope = "Crash"
	.byte $FB, $0B		; Arpeggio = "Crash"
	.byte $84			; Duration = 4
	.byte $08			; 7-#
	.byte $F8, $2D		; Volume Envelope = "Snare Crash Tail"
	.byte $FB, $10		; Arpeggio = "Snare Crash Tail"
	.byte $08			; 7-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $81			; Duration = 1
	.byte $06			; 9-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $82			; Duration = 2
	.byte $04			; B-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $81			; Duration = 1
	.byte $06			; 9-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $82			; Duration = 2
	.byte $04			; B-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $81			; Duration = 1
	.byte $06			; 9-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $82			; Duration = 2
	.byte $04			; B-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $81			; Duration = 1
	.byte $06			; 9-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $82			; Duration = 2
	.byte $04			; B-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $81			; Duration = 1
	.byte $06			; 9-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $82			; Duration = 2
	.byte $04			; B-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $81			; Duration = 1
	.byte $06			; 9-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $82			; Duration = 2
	.byte $04			; B-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $81			; Duration = 1
	.byte $06			; 9-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $82			; Duration = 2
	.byte $04			; B-#
	.byte $F8, $01		; Volume Envelope = "Snare Noise Enhance"
	.byte $FB, $03		; Arpeggio = "Snare Noise Enhance"
	.byte $08			; 7-#
	.byte $F8, $04		; Volume Envelope = "Hat 1"
	.byte $FB, $06		; Arpeggio = "Hat 1"
	.byte $04			; B-#
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_04:
	.byte $F8, $25		; Volume Envelope = "Crash"
	.byte $FB, $0B		; Arpeggio = "Crash"
	.byte $B0			; Duration = 48
	.byte $08			; 7-#
	.byte $F8, $2B		; Volume Envelope = "Reverse Crash"
	.byte $FB, $FF		; Arpeggio = "Reverse Crash"
	.byte $90			; Duration = 16
	.byte $07			; 8-#
	.byte $F1			; RETURN
	; Pattern duration: 64.
