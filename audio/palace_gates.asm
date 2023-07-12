	.byte $00
	.word palace_gates_ch_00
	.byte $01
	.word palace_gates_ch_01
	.byte $02
	.word palace_gates_ch_02
	.byte $03
	.word palace_gates_ch_03
	.byte $FF

; -----------------------------------------------------------------------------
;						SQUARE WAVE 0 CHANNEL
; -----------------------------------------------------------------------------

palace_gates_ch_00:
	.byte $F5, $06	; Speed = 6
	@order_00:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F4	; JUMP
	.word @order_00

	@pattern_00:
	.byte $F8, $11		; Volume Envelope = "Synth 2"
	.byte $F9, $06		; Duty Envelope = "Synth 2"
	.byte $FA, $02		; Pitch Envelope = "Synth 2"
	.byte $FB, $FF		; Arpeggio = "Synth 2"
	.byte $81			; Duration = 1
	.byte $2D			; A-3
	.byte $83			; Duration = 3
	.byte $2F			; B-3
	.byte $82			; Duration = 2
	.byte $32			; D-4
	.byte $81			; Duration = 1
	.byte $2D			; A-3
	.byte $8F			; Duration = 15
	.byte $2F			; B-3
	.byte $81			; Duration = 1
	.byte $2D			; A-3
	.byte $2F			; B-3
	.byte $82			; Duration = 2
	.byte $35			; F-4
	.byte $32			; D-4
	.byte $2F			; B-3
	.byte $2B			; G-3
	.byte $90			; Duration = 16
	.byte $29			; F-3
	.byte $81			; Duration = 1
	.byte $2F			; B-3
	.byte $30			; C-4
	.byte $84			; Duration = 4
	.byte $2F			; B-3
	.byte $82			; Duration = 2
	.byte $2D			; A-3
	.byte $2C			; G#3
	.byte $28			; E-3
	.byte $26			; D-3
	.byte $23			; B-2
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_01:
	.byte $F8, $11		; Volume Envelope = "Synth 2"
	.byte $F9, $06		; Duty Envelope = "Synth 2"
	.byte $FA, $02		; Pitch Envelope = "Synth 2"
	.byte $FB, $FF		; Arpeggio = "Synth 2"
	.byte $90			; Duration = 16
	.byte $28			; E-3
	.byte $81			; Duration = 1
	.byte $2F			; B-3
	.byte $2D			; A-3
	.byte $8E			; Duration = 14
	.byte $2F			; B-3
	.byte $81			; Duration = 1
	.byte $34			; E-4
	.byte $32			; D-4
	.byte $8E			; Duration = 14
	.byte $34			; E-4
	.byte $88			; Duration = 8
	.byte $35			; F-4
	.byte $32			; D-4
	.byte $F1			; RETURN
	; Pattern duration: 64.

; -----------------------------------------------------------------------------
;						SQUARE WAVE 1 CHANNEL
; -----------------------------------------------------------------------------

palace_gates_ch_01:
	.byte $F5, $06	; Speed = 6
	@order_01:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F4	; JUMP
	.word @order_01

	@pattern_00:
	.byte $F8, $05		; Volume Envelope = "Synth Lead"
	.byte $F9, $00		; Duty Envelope = "Synth Lead"
	.byte $FA, $FF		; Pitch Envelope = "Synth Lead"
	.byte $FB, $FF		; Arpeggio = "Synth Lead"
	.byte $86			; Duration = 6
	.byte $28			; E-3
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $82			; Duration = 2
	.byte $17			; B-1
	.byte $84			; Duration = 4
	.byte $1D			; F-2
	.byte $82			; Duration = 2
	.byte $1A			; D-2
	.byte $17			; B-1
	.byte $84			; Duration = 4
	.byte $10			; E-1
	.byte $82			; Duration = 2
	.byte $16			; A#1
	.byte $17			; B-1
	.byte $84			; Duration = 4
	.byte $1D			; F-2
	.byte $82			; Duration = 2
	.byte $1A			; D-2
	.byte $17			; B-1
	.byte $84			; Duration = 4
	.byte $11			; F-1
	.byte $82			; Duration = 2
	.byte $17			; B-1
	.byte $18			; C-2
	.byte $84			; Duration = 4
	.byte $1D			; F-2
	.byte $82			; Duration = 2
	.byte $1A			; D-2
	.byte $17			; B-1
	.byte $84			; Duration = 4
	.byte $11			; F-1
	.byte $82			; Duration = 2
	.byte $17			; B-1
	.byte $18			; C-2
	.byte $84			; Duration = 4
	.byte $1D			; F-2
	.byte $82			; Duration = 2
	.byte $1A			; D-2
	.byte $17			; B-1
	.byte $F1			; RETURN
	; Pattern duration: 64.

	@pattern_01:
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $FB, $FF		; Arpeggio = "Pluck"
	.byte $84			; Duration = 4
	.byte $10			; E-1
	.byte $82			; Duration = 2
	.byte $16			; A#1
	.byte $17			; B-1
	.byte $84			; Duration = 4
	.byte $1D			; F-2
	.byte $82			; Duration = 2
	.byte $1A			; D-2
	.byte $17			; B-1
	.byte $84			; Duration = 4
	.byte $10			; E-1
	.byte $82			; Duration = 2
	.byte $16			; A#1
	.byte $17			; B-1
	.byte $84			; Duration = 4
	.byte $1D			; F-2
	.byte $82			; Duration = 2
	.byte $1A			; D-2
	.byte $17			; B-1
	.byte $84			; Duration = 4
	.byte $11			; F-1
	.byte $82			; Duration = 2
	.byte $17			; B-1
	.byte $18			; C-2
	.byte $84			; Duration = 4
	.byte $1D			; F-2
	.byte $82			; Duration = 2
	.byte $1A			; D-2
	.byte $17			; B-1
	.byte $84			; Duration = 4
	.byte $11			; F-1
	.byte $82			; Duration = 2
	.byte $17			; B-1
	.byte $18			; C-2
	.byte $84			; Duration = 4
	.byte $1D			; F-2
	.byte $82			; Duration = 2
	.byte $1A			; D-2
	.byte $17			; B-1
	.byte $F1			; RETURN
	; Pattern duration: 64.

; -----------------------------------------------------------------------------
;						TRIANGLE WAVE CHANNEL
; -----------------------------------------------------------------------------

palace_gates_ch_02:
	.byte $F5, $06	; Speed = 6
	@order_02:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F4	; JUMP
	.word @order_02

	@pattern_00:
	.byte $FA, $FF		; Pitch Envelope = "Blank"
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $A0			; Duration = 32
	.byte $1C			; E-2
	.byte $1D			; F-2
	.byte $F1			; RETURN
	; Pattern duration: 64.

; -----------------------------------------------------------------------------
;						        NOISE CHANNEL
; -----------------------------------------------------------------------------

palace_gates_ch_03:
	.byte $F5, $06	; Speed = 6
	@order_03:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F4	; JUMP
	.word @order_03

	@pattern_00:
	.byte $F8, $03		; Volume Envelope = "Low Drum"
	.byte $FB, $05		; Arpeggio = "Low Drum"
	.byte $86			; Duration = 6
	.byte $0D			; 2-#
	.byte $82			; Duration = 2
	.byte $0D			; 2-#
	.byte $88			; Duration = 8
	.byte $0D			; 2-#
	.byte $86			; Duration = 6
	.byte $0D			; 2-#
	.byte $82			; Duration = 2
	.byte $0D			; 2-#
	.byte $88			; Duration = 8
	.byte $0D			; 2-#
	.byte $86			; Duration = 6
	.byte $0D			; 2-#
	.byte $82			; Duration = 2
	.byte $0D			; 2-#
	.byte $88			; Duration = 8
	.byte $0D			; 2-#
	.byte $86			; Duration = 6
	.byte $0D			; 2-#
	.byte $82			; Duration = 2
	.byte $0D			; 2-#
	.byte $88			; Duration = 8
	.byte $0D			; 2-#
	.byte $F1			; RETURN
	; Pattern duration: 64.
