	.byte $00
	.word your_destiny_ch0
	.byte $01
	.word your_destiny_ch1
	.byte $02
	.word your_destiny_ch2
	.byte $03
	.word your_destiny_ch3
	.byte $FF



your_destiny_ch0:
; Channel 0
	.byte $F5, $07	; SPEED = 7

; -------- FRAME 00 --------
	@frame_00:
	.byte $82		; Note length = 2
	.byte $01		; (Hold), 2 ticks
	.byte $F8, $09	; VOL ENV Pluck
	.byte $F9, $02	; DUTY ENV Pluck
	.byte $FA, $FF	; PITCH ENV Pluck
	.byte $FB, $FF	; ARPEGGIO Pluck
	.byte $81		; Note length = 1
	.byte $23		; B-2, 1 tick
	.byte $23		; B-2, 1 tick
	.byte $82		; Note length = 2
	.byte $21		; A-2, 2 ticks
	.byte $23		; B-2, 2 ticks
	.byte $26		; D-3, 2 ticks
	.byte $23		; B-2, 2 ticks
	.byte $21		; A-2, 2 ticks
	.byte $84		; Note length = 4
	.byte $23		; B-2, 4 ticks
	.byte $81		; Note length = 1
	.byte $23		; B-2, 1 tick
	.byte $23		; B-2, 1 tick
	.byte $82		; Note length = 2
	.byte $21		; A-2, 2 ticks
	.byte $23		; B-2, 2 ticks
	.byte $26		; D-3, 2 ticks
	.byte $23		; B-2, 2 ticks
	.byte $21		; A-2, 2 ticks
	.byte $1E		; F#2, 2 ticks
	.byte $F4		; JUMP
	.word @frame_00


your_destiny_ch1:
; Channel 1
	;.byte $F5, $07	; SPEED = 7

; -------- FRAME 00 --------
	@frame_00:
	.byte $82		; Note length = 2
	.byte $01		; (Hold), 2 ticks
	.byte $F8, $09	; VOL ENV Pluck
	.byte $F9, $02	; DUTY ENV Pluck
	.byte $FA, $FF	; PITCH ENV Pluck
	.byte $FB, $FF	; ARPEGGIO Pluck
	.byte $81		; Note length = 1
	.byte $28		; E-3, 1 tick
	.byte $28		; E-3, 1 tick
	.byte $82		; Note length = 2
	.byte $26		; D-3, 2 ticks
	.byte $28		; E-3, 2 ticks
	.byte $2B		; G-3, 2 ticks
	.byte $28		; E-3, 2 ticks
	.byte $26		; D-3, 2 ticks
	.byte $84		; Note length = 4
	.byte $28		; E-3, 4 ticks
	.byte $81		; Note length = 1
	.byte $28		; E-3, 1 tick
	.byte $28		; E-3, 1 tick
	.byte $82		; Note length = 2
	.byte $26		; D-3, 2 ticks
	.byte $28		; E-3, 2 ticks
	.byte $2B		; G-3, 2 ticks
	.byte $28		; E-3, 2 ticks
	.byte $26		; D-3, 2 ticks
	.byte $23		; B-2, 2 ticks
	.byte $F4		; JUMP
	.word @frame_00


your_destiny_ch2:
; Channel 2
	;.byte $F5, $07	; SPEED = 7

; -------- FRAME 00 --------
	@frame_00:
	.byte $F8, $FF	; VOL ENV Tri Kick -> Bass
	.byte $FA, $FF	; PITCH ENV Tri Kick -> Bass
	.byte $FB, $00	; ARPEGGIO Tri Kick -> Bass
	.byte $82		; Note length = 2
	.byte $1C		; E-2, 2 ticks
	.byte $00		; (Rest), 2 ticks
	.byte $1C		; E-2, 2 ticks
	.byte $00		; (Rest), 2 ticks
	.byte $1C		; E-2, 2 ticks
	.byte $00		; (Rest), 2 ticks
	.byte $1C		; E-2, 2 ticks
	.byte $00		; (Rest), 2 ticks
	.byte $1C		; E-2, 2 ticks
	.byte $00		; (Rest), 2 ticks
	.byte $1C		; E-2, 2 ticks
	.byte $00		; (Rest), 2 ticks
	.byte $1C		; E-2, 2 ticks
	.byte $00		; (Rest), 2 ticks
	.byte $1C		; E-2, 2 ticks
	.byte $00		; (Rest), 2 ticks
	.byte $F4		; JUMP
	.word @frame_00


your_destiny_ch3:
; Channel 3
	;.byte $F5, $07	; SPEED = 7

; -------- FRAME 00 --------
	@frame_00:
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FA, $FF	; PITCH ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $04	; VOL ENV Hat 1
	.byte $FB, $06	; ARPEGGIO Hat 1
	.byte $04		; B-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $04	; VOL ENV Hat 1
	.byte $FB, $06	; ARPEGGIO Hat 1
	.byte $04		; B-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $04	; VOL ENV Hat 1
	.byte $FB, $06	; ARPEGGIO Hat 1
	.byte $04		; B-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $15	; VOL ENV Quiet Drum
	.byte $FB, $FF	; ARPEGGIO Quiet Drum
	.byte $81		; Note length = 1
	.byte $0B		; 4-#, 1 tick
	.byte $0B		; 4-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $04	; VOL ENV Hat 1
	.byte $FB, $06	; ARPEGGIO Hat 1
	.byte $04		; B-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $04	; VOL ENV Hat 1
	.byte $FB, $06	; ARPEGGIO Hat 1
	.byte $04		; B-#, 2 ticks
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $15	; VOL ENV Quiet Drum
	.byte $FB, $FF	; ARPEGGIO Quiet Drum
	.byte $81		; Note length = 1
	.byte $0B		; 4-#, 1 tick
	.byte $0B		; 4-#, 1 tick
	.byte $F8, $00	; VOL ENV Kick Noise Enhance
	.byte $FB, $02	; ARPEGGIO Kick Noise Enhance
	.byte $82		; Note length = 2
	.byte $06		; 9-#, 2 ticks
	.byte $F8, $15	; VOL ENV Quiet Drum
	.byte $FB, $FF	; ARPEGGIO Quiet Drum
	.byte $81		; Note length = 1
	.byte $0B		; 4-#, 1 tick
	.byte $0B		; 4-#, 1 tick
	.byte $F4		; JUMP
	.word @frame_00
