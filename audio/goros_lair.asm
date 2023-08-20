	.byte $00
	.word goros_lair_ch_00
	.byte $01
	.word goros_lair_ch_01
	.byte $02
	.word goros_lair_ch_02
	.byte $03
	.word goros_lair_ch_03
	.byte $FF

; -----------------------------------------------------------------------------
;						SQUARE WAVE 0 CHANNEL
; -----------------------------------------------------------------------------

goros_lair_ch_00:
	.byte $F5, $0A	; Speed = 10
	@order_00:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F4	; JUMP
	.word @order_00

	@pattern_00:
	.byte $89			; Duration = 9
	.byte $01			; HOLD
	.byte $F8, $12		; Volume Envelope = "Bamboo Echo"
	.byte $F9, $04		; Duty Envelope = "Bamboo Echo"
	.byte $FA, $FF		; Pitch Envelope = "Bamboo Echo"
	.byte $FB, $FF		; Arpeggio = "Bamboo Echo"
	.byte $81			; Duration = 1
	.byte $1F			; G-2
	.byte $1D			; F-2
	.byte $89			; Duration = 9
	.byte $1F			; G-2
	.byte $F8, $13		; Volume Envelope = "Bamboo x2 echo"
	.byte $F9, $05		; Duty Envelope = "Bamboo x2 echo"
	.byte $81			; Duration = 1
	.byte $1F			; G-2
	.byte $1F			; G-2
	.byte $1F			; G-2
	.byte $F8, $12		; Volume Envelope = "Bamboo Echo"
	.byte $F9, $04		; Duty Envelope = "Bamboo Echo"
	.byte $84			; Duration = 4
	.byte $20			; G#2
	.byte $82			; Duration = 2
	.byte $20			; G#2
	.byte $1D			; F-2
	.byte $81			; Duration = 1
	.byte $19			; C#2
	.byte $F1			; RETURN
	; Pattern duration: 32.

	@pattern_01:
	.byte $F8, $0F		; Volume Envelope = "Bamboo?"
	.byte $F9, $04		; Duty Envelope = "Bamboo?"
	.byte $FA, $FF		; Pitch Envelope = "Bamboo?"
	.byte $FB, $FF		; Arpeggio = "Bamboo?"
	.byte $83			; Duration = 3
	.byte $18			; C-2
	.byte $F8, $14		; Volume Envelope = "Synth 2 Echo"
	.byte $F9, $06		; Duty Envelope = "Synth 2 Echo"
	.byte $FA, $02		; Pitch Envelope = "Synth 2 Echo"
	.byte $81			; Duration = 1
	.byte $2B			; G-3
	.byte $8C			; Duration = 12
	.byte $30			; C-4
	.byte $F2, $0A		; NOTE DELAY = 10
	.byte $81			; Duration = 1
	.byte $31			; C#4
	.byte $F2, $05		; NOTE DELAY = 5
	.byte $2E			; A#3
	.byte $29			; F-3
	.byte $FC, $08		; NOTE SLIDE UP = 2
	.byte $FA, $FF		; Pitch Envelope = "Goro Echo Sweep"
	.byte $29			; F-3
	.byte $F2, $05		; NOTE DELAY = 5
	.byte $F8, $24		; Volume Envelope = "Goro Vib Echo"
	.byte $F9, $0C		; Duty Envelope = "Goro Vib Echo"
	.byte $FA, $02		; Pitch Envelope = "Goro Vib Echo"
	.byte $86			; Duration = 6
	.byte $2B			; G-3
	.byte $F2, $05		; NOTE DELAY = 5
	.byte $F8, $14		; Volume Envelope = "Synth 2 Echo"
	.byte $F9, $06		; Duty Envelope = "Synth 2 Echo"
	.byte $83			; Duration = 3
	.byte $29			; F-3
	.byte $25			; C#3
	.byte $F1			; RETURN
	; Pattern duration: 32.

	@pattern_02:
	.byte $81			; Duration = 1
	.byte $01			; HOLD
	.byte $F8, $14		; Volume Envelope = "Synth 2 Echo"
	.byte $F9, $06		; Duty Envelope = "Synth 2 Echo"
	.byte $FA, $02		; Pitch Envelope = "Synth 2 Echo"
	.byte $FB, $FF		; Arpeggio = "Synth 2 Echo"
	.byte $88			; Duration = 8
	.byte $24			; C-3
	.byte $81			; Duration = 1
	.byte $25			; C#3
	.byte $22			; A#2
	.byte $8E			; Duration = 14
	.byte $1D			; F-2
	.byte $84			; Duration = 4
	.byte $19			; C#2
	.byte $83			; Duration = 3
	.byte $16			; A#1
	.byte $F1			; RETURN
	; Pattern duration: 32.

	@pattern_03:
	.byte $81			; Duration = 1
	.byte $01			; HOLD
	.byte $F8, $14		; Volume Envelope = "Synth 2 Echo"
	.byte $F9, $06		; Duty Envelope = "Synth 2 Echo"
	.byte $FA, $02		; Pitch Envelope = "Synth 2 Echo"
	.byte $FB, $FF		; Arpeggio = "Synth 2 Echo"
	.byte $8C			; Duration = 12
	.byte $18			; C-2
	.byte $93			; Duration = 19
	.byte $00			; REST
	.byte $F1			; RETURN
	; Pattern duration: 32.

; -----------------------------------------------------------------------------
;						SQUARE WAVE 1 CHANNEL
; -----------------------------------------------------------------------------

goros_lair_ch_01:
	.byte $F5, $0A	; Speed = 10
	@order_01:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_01
	.byte $F0	; CALL
	.word @pattern_02
	.byte $F0	; CALL
	.word @pattern_03
	.byte $F4	; JUMP
	.word @order_01

	@pattern_00:
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $FB, $FF		; Arpeggio = "Pluck"
	.byte $88			; Duration = 8
	.byte $18			; C-2
	.byte $F8, $0F		; Volume Envelope = "Bamboo?"
	.byte $F9, $04		; Duty Envelope = "Bamboo?"
	.byte $81			; Duration = 1
	.byte $1F			; G-2
	.byte $1D			; F-2
	.byte $89			; Duration = 9
	.byte $1F			; G-2
	.byte $F8, $13		; Volume Envelope = "Bamboo x2 echo"
	.byte $F9, $05		; Duty Envelope = "Bamboo x2 echo"
	.byte $81			; Duration = 1
	.byte $1F			; G-2
	.byte $1F			; G-2
	.byte $F8, $10		; Volume Envelope = "Bamboo x2"
	.byte $1F			; G-2
	.byte $F8, $0F		; Volume Envelope = "Bamboo?"
	.byte $F9, $04		; Duty Envelope = "Bamboo?"
	.byte $84			; Duration = 4
	.byte $20			; G#2
	.byte $82			; Duration = 2
	.byte $20			; G#2
	.byte $1D			; F-2
	.byte $19			; C#2
	.byte $F1			; RETURN
	; Pattern duration: 32.

	@pattern_01:
	.byte $F8, $11		; Volume Envelope = "Synth 2"
	.byte $F9, $06		; Duty Envelope = "Synth 2"
	.byte $FA, $02		; Pitch Envelope = "Synth 2"
	.byte $FB, $FF		; Arpeggio = "Synth 2"
	.byte $81			; Duration = 1
	.byte $2B			; G-3
	.byte $2C			; G#3
	.byte $2B			; G-3
	.byte $8C			; Duration = 12
	.byte $30			; C-4
	.byte $F2, $0A		; NOTE DELAY = 10
	.byte $81			; Duration = 1
	.byte $31			; C#4
	.byte $F2, $05		; NOTE DELAY = 5
	.byte $2E			; A#3
	.byte $29			; F-3
	.byte $FC, $08		; NOTE SLIDE UP = 2
	.byte $FA, $FF		; Pitch Envelope = "Goro Sweep"
	.byte $29			; F-3
	.byte $F2, $05		; NOTE DELAY = 5
	.byte $F8, $23		; Volume Envelope = "Goro Vibrato"
	.byte $F9, $0C		; Duty Envelope = "Goro Vibrato"
	.byte $FA, $02		; Pitch Envelope = "Goro Vibrato"
	.byte $86			; Duration = 6
	.byte $2B			; G-3
	.byte $F2, $05		; NOTE DELAY = 5
	.byte $F8, $11		; Volume Envelope = "Synth 2"
	.byte $F9, $06		; Duty Envelope = "Synth 2"
	.byte $83			; Duration = 3
	.byte $29			; F-3
	.byte $84			; Duration = 4
	.byte $25			; C#3
	.byte $F1			; RETURN
	; Pattern duration: 32.

	@pattern_02:
	.byte $F8, $11		; Volume Envelope = "Synth 2"
	.byte $F9, $06		; Duty Envelope = "Synth 2"
	.byte $FA, $02		; Pitch Envelope = "Synth 2"
	.byte $FB, $FF		; Arpeggio = "Synth 2"
	.byte $88			; Duration = 8
	.byte $24			; C-3
	.byte $81			; Duration = 1
	.byte $25			; C#3
	.byte $22			; A#2
	.byte $8E			; Duration = 14
	.byte $1D			; F-2
	.byte $84			; Duration = 4
	.byte $19			; C#2
	.byte $16			; A#1
	.byte $F1			; RETURN
	; Pattern duration: 32.

	@pattern_03:
	.byte $F8, $11		; Volume Envelope = "Synth 2"
	.byte $F9, $06		; Duty Envelope = "Synth 2"
	.byte $FA, $02		; Pitch Envelope = "Synth 2"
	.byte $FB, $FF		; Arpeggio = "Synth 2"
	.byte $8C			; Duration = 12
	.byte $18			; C-2
	.byte $8E			; Duration = 14
	.byte $00			; REST
	.byte $F8, $09		; Volume Envelope = "Pluck"
	.byte $F9, $02		; Duty Envelope = "Pluck"
	.byte $FA, $FF		; Pitch Envelope = "Pluck"
	.byte $81			; Duration = 1
	.byte $16			; A#1
	.byte $18			; C-2
	.byte $1F			; G-2
	.byte $1D			; F-2
	.byte $19			; C#2
	.byte $16			; A#1
	.byte $F1			; RETURN
	; Pattern duration: 32.

; -----------------------------------------------------------------------------
;						TRIANGLE WAVE CHANNEL
; -----------------------------------------------------------------------------

goros_lair_ch_02:
	.byte $F5, $0A	; Speed = 10
	@order_02:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F4	; JUMP
	.word @order_02

	@pattern_00:
	.byte $FA, $FF		; Pitch Envelope = "Tri Kick -> Bass"
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $82			; Duration = 2
	.byte $18			; C-2
	.byte $84			; Duration = 4
	.byte $18			; C-2
	.byte $82			; Duration = 2
	.byte $18			; C-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $81			; Duration = 1
	.byte $18			; C-2
	.byte $18			; C-2
	.byte $18			; C-2
	.byte $18			; C-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $84			; Duration = 4
	.byte $18			; C-2
	.byte $82			; Duration = 2
	.byte $18			; C-2
	.byte $84			; Duration = 4
	.byte $18			; C-2
	.byte $82			; Duration = 2
	.byte $18			; C-2
	.byte $FB, $01		; Arpeggio = "Tri Snare -> Bass"
	.byte $81			; Duration = 1
	.byte $18			; C-2
	.byte $18			; C-2
	.byte $18			; C-2
	.byte $18			; C-2
	.byte $FB, $00		; Arpeggio = "Tri Kick -> Bass"
	.byte $82			; Duration = 2
	.byte $18			; C-2
	.byte $FB, $FF		; Arpeggio = "Blank"
	.byte $19			; C#2
	.byte $F1			; RETURN
	; Pattern duration: 32.

; -----------------------------------------------------------------------------
;						        NOISE CHANNEL
; -----------------------------------------------------------------------------

goros_lair_ch_03:
	.byte $F5, $0A	; Speed = 10
	@order_03:
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F0	; CALL
	.word @pattern_00
	.byte $F4	; JUMP
	.word @order_03

	@pattern_00:
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $82			; Duration = 2
	.byte $06			; 9-#
	.byte $84			; Duration = 4
	.byte $06			; 9-#
	.byte $82			; Duration = 2
	.byte $06			; 9-#
	.byte $F8, $0E		; Volume Envelope = "Snare 2"
	.byte $FB, $03		; Arpeggio = "Snare 2"
	.byte $81			; Duration = 1
	.byte $09			; 6-#
	.byte $09			; 6-#
	.byte $09			; 6-#
	.byte $09			; 6-#
	.byte $F8, $15		; Volume Envelope = "Quiet Drum"
	.byte $FB, $FF		; Arpeggio = "Quiet Drum"
	.byte $84			; Duration = 4
	.byte $0D			; 2-#
	.byte $F8, $00		; Volume Envelope = "Kick Noise Enhance"
	.byte $FB, $02		; Arpeggio = "Kick Noise Enhance"
	.byte $82			; Duration = 2
	.byte $06			; 9-#
	.byte $84			; Duration = 4
	.byte $06			; 9-#
	.byte $82			; Duration = 2
	.byte $06			; 9-#
	.byte $F8, $0E		; Volume Envelope = "Snare 2"
	.byte $FB, $03		; Arpeggio = "Snare 2"
	.byte $81			; Duration = 1
	.byte $09			; 6-#
	.byte $09			; 6-#
	.byte $09			; 6-#
	.byte $09			; 6-#
	.byte $F8, $15		; Volume Envelope = "Quiet Drum"
	.byte $FB, $FF		; Arpeggio = "Quiet Drum"
	.byte $84			; Duration = 4
	.byte $0D			; 2-#
	.byte $F1			; RETURN
	; Pattern duration: 32.

