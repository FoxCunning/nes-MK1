.IFDEF DENDY
	.OUT "Duty cycles swapped for Dendy/clone CPUs."
.ENDIF

; ------------------------------------------------------------------------------

tbl_vol_env_ptrs:
	.word @vol_env_00
	.word @vol_env_01
	.word @vol_env_02
	.word @vol_env_03
	.word @vol_env_04
	.word @vol_env_05
	.word @vol_env_06
	.word @vol_env_07
	.word @vol_env_08
	.word @vol_env_09
	.word @vol_env_0A
	.word @vol_env_0B
	.word @vol_env_0C
	.word @vol_env_0D
	.word @vol_env_0E
	.word @vol_env_0F
	.word @vol_env_10
	.word @vol_env_11
	.word @vol_env_12
	.word @vol_env_13
	.word @vol_env_14
	.word @vol_env_15
	.word @vol_env_16
	.word @vol_env_17
	.word @vol_env_18
	.word @vol_env_19
	.word @vol_env_1A
	.word @vol_env_1B
	.word @vol_env_1C
	.word @vol_env_1D
	.word @vol_env_1E
	.word @vol_env_1F
	.word @vol_env_20
	.word @vol_env_21
	.word @vol_env_22
	.word @vol_env_23
	.word @vol_env_24
	.word @vol_env_25
	.word @vol_env_26
	.word @vol_env_27
	.word @vol_env_28
	.word @vol_env_29
	.word @vol_env_2A
	.word @vol_env_2B
	.word @vol_env_2C
	.word @vol_env_2D

; -----------------

	@vol_env_00:
	.byte $01, $04, $01, $02, $02, $01, $01, $00
	.byte $FF, $00

; -----------------

	@vol_env_01:
	.byte $01, $07, $02, $04, $03, $03, $03, $02
	.byte $04, $01, $01, $00, $FF, $00

; -----------------

	@vol_env_02:
	.byte $01, $07, $03, $02, $01, $07, $03, $02
	.byte $02, $01, $01, $00, $FF, $00

; -----------------

	@vol_env_03:
	.byte $01, $07, $01, $04, $03, $03, $04, $02
	.byte $04, $01, $01, $00, $FF, $00

; -----------------

	@vol_env_04:
	.byte $01, $03, $01, $02, $02, $01, $01, $00
	.byte $FF, $00

; -----------------

	@vol_env_05:
	.byte $01, $05, $03, $06, $04, $05, $08, $04
	.byte $0E, $03, $0E, $02, $0E, $01, $01, $00
	.byte $FF, $00

; -----------------

	@vol_env_06:
	.byte $01, $02, $06, $03, $0C, $02, $0E, $01
	.byte $01, $00, $FF, $00

; -----------------

	@vol_env_07:
	.byte $01, $06, $06, $07, $0E, $06, $0E, $05
	.byte $0E, $04, $0D, $03, $01, $02, $FF, $FF

; -----------------

	@vol_env_08:
	.byte $01, $08, $01, $04, $01, $03, $02, $02
	.byte $03, $01, $01, $00, $FF, $00

; -----------------

	@vol_env_09:
	.byte $01, $06, $01, $05, $01, $04, $01, $03
	.byte $02, $02, $02, $01, $01, $00, $01, $03
	.byte $01, $02, $02, $01, $01, $00, $FF, $00

; -----------------

	@vol_env_0A:
	.byte $01, $03, $01, $02, $02, $01, $05, $00
	.byte $02, $01, $03, $00, $FF, $00

; -----------------

	@vol_env_0B:
	.byte $01, $06, $01, $04, $01, $02, $02, $01
	.byte $01, $00, $FF, $00

; -----------------

	@vol_env_0C:
	.byte $01, $05, $03, $03, $03, $02, $04, $01
	.byte $01, $00, $FF, $00

; -----------------

	@vol_env_0D:
	.byte $01, $01, $02, $02, $03, $03, $0A, $04
	.byte $11, $03, $08, $02, $08, $01, $01, $00
	.byte $FF, $00

; -----------------

	@vol_env_0E:
	.byte $01, $07, $02, $04, $02, $03, $02, $02
	.byte $04, $01, $01, $00, $FF, $00

; -----------------

	@vol_env_0F:
	.byte $01, $04, $01, $08, $01, $06, $01, $05
	.byte $02, $04, $04, $03, $01, $02, $FF, $FF

; -----------------

	@vol_env_10:
	.byte $01, $04, $01, $08, $01, $06, $01, $05
	.byte $02, $04, $01, $08, $01, $06, $01, $05
	.byte $02, $04, $04, $03, $01, $02, $FF, $FF

; -----------------

	@vol_env_11:
	.byte $01, $03, $02, $05, $03, $06, $0A, $05
	.byte $0A, $04, $15, $03, $01, $02, $FF, $FF

; -----------------

	@vol_env_12:
	.byte $01, $02, $01, $04, $01, $03, $03, $02
	.byte $04, $01, $01, $00, $FF, $00

; -----------------

	@vol_env_13:
	.byte $01, $02, $01, $03, $01, $04, $01, $03
	.byte $02, $02, $01, $03, $01, $04, $01, $03
	.byte $02, $02, $04, $01, $01, $00, $FF, $00

; -----------------

	@vol_env_14:
	.byte $01, $01, $02, $02, $03, $03, $09, $02
	.byte $01, $01, $FF, $FF

; -----------------

	@vol_env_15:
	.byte $01, $07, $02, $03, $02, $02, $03, $01
	.byte $01, $00, $FF, $00

; -----------------

	@vol_env_16:
	.byte $02, $06, $02, $03, $02, $02, $04, $01
	.byte $01, $00, $FF, $00

; -----------------

	@vol_env_17:
	.byte $01, $05, $02, $03, $04, $02, $06, $01
	.byte $01, $00, $FF, $00

; -----------------

	@vol_env_18:
	.byte $01, $04, $01, $06, $08, $07, $01, $06
	.byte $FF, $FF

; -----------------

	@vol_env_19:
	.byte $01, $01, $0C, $03, $01, $02, $FF, $00

; -----------------

	@vol_env_1A:
	.byte $01, $03, $04, $05, $0A, $04, $0D, $03
	.byte $17, $02, $01, $01, $FF, $FF

; -----------------

	@vol_env_1B:
	.byte $01, $04, $04, $05, $06, $04, $0D, $03
	.byte $0D, $02, $01, $01, $FF, $FF

; -----------------

	@vol_env_1C:
	.byte $01, $06, $01, $08, $01, $04, $01, $02
	.byte $03, $01, $01, $00, $FF, $00

; -----------------

	@vol_env_1D:
	.byte $01, $06, $01, $05, $01, $04, $01, $03
	.byte $01, $06, $01, $05, $01, $04, $01, $03
	.byte $02, $02, $02, $01, $01, $00, $01, $03
	.byte $01, $02, $02, $01, $01, $00, $FF, $00

; -----------------

	@vol_env_1E:
	.byte $01, $03, $01, $02, $02, $01, $01, $03
	.byte $01, $02, $02, $01, $05, $00, $02, $01
	.byte $03, $00, $FF, $00

; -----------------

	@vol_env_1F:
	.byte $01, $05, $02, $02, $03, $01, $01, $00
	.byte $FF, $00

; -----------------

	@vol_env_20:
	.byte $07, $05, $07, $04, $07, $03, $07, $02
	.byte $07, $01, $01, $00, $FF, $00

; -----------------

	@vol_env_21:
	.byte $01, $06, $FF, $FF

; -----------------

	@vol_env_22:
	.byte $01, $02, $FF, $FF

; ----------------

	@vol_env_23:
	.byte $06, $04, $15, $03, $01, $02, $FF, $FF

; ----------------

	@vol_env_24:
	.byte $03, $02, $01, $01, $FF, $FF

; ----------------

	@vol_env_25:
	.byte $01, $0A, $01, $08, $02, $07, $03, $06
	.byte $04, $05, $06, $04, $09, $03, $0E, $02
	.byte $17, $01, $FF, $FF

; ----------------

	@vol_env_26:
	.byte $01, $10, $01, $09, $02, $08, $01, $07
	.byte $01, $06, $03, $00, $02, $03, $02, $02
	.byte $02, $02, $01, $00, $FF, $00

; ----------------

	@vol_env_27:
	.byte $01, $06, $01, $08, $01, $06, $01, $04
	.byte $01, $02, $01, $01, $01, $00, $FF, $FF

; ----------------

	@vol_env_28:
	.byte $01, $09, $01, $07, $01, $05, $01, $03
	.byte $01, $01, $01, $00, $FF, $00

; ----------------
	
	@vol_env_29:
	.byte $01, $02, $01, $03, $01, $02, $02, $01
	.byte $01, $00, $FF, $00

; ----------------

	@vol_env_2A:
	.byte $01, $09, $01, $08, $01, $07, $01, $06
	.byte $01, $05, $01, $04, $03, $00, $02, $03
	.byte $02, $02, $02, $01, $01, $00, $FF, $00

; ----------------

	@vol_env_2B:
	.byte $1B, $01, $1C, $02, $13, $03, $0D, $04
	.byte $07, $05, $07, $06, $04, $07, $02, $08
	.byte $01, $09, $FF, $FF

; ----------------

	@vol_env_2C:
	.byte $06, $01, $06, $02, $04, $03, $01, $02
	.byte $FF, $FF

; ----------------
	
	@vol_env_2D:
	.byte $01, $07, $02, $04, $02, $03, $07, $02
	.byte $01, $03, $08, $02, $17, $01, $00
	.byte $FF, $00

; ------------------------------------------------------------------------------

tbl_arp_ptrs:
	.word @arp_00
	.word @arp_01
	.word @arp_02
	.word @arp_03
	.word @arp_04
	.word @arp_05
	.word @arp_06
	.word @arp_07
	.word @arp_08
	.word @arp_09
	.word @arp_0A
	.word @arp_0B
	.word @arp_0C
	.word @arp_unused
	.word @arp_unused
	.word @arp_unused
	.word @arp_10

; -----------------------------------------------------------------------------

; B0: $00 = absolute, $80 = Relative
; ... Values (signed)
; $7F = End

; -----------------

	@arp_00:
	.byte $80
	.byte $24, $21, $1E, $1B, $18, $7F

; -----------------

	@arp_01:
	.byte $80
	.byte $2D, $2B, $7F

; -----------------

	@arp_02:
	.byte $00
	.byte $00, $04, $7F

; -----------------

	@arp_03:
	.byte $00
	.byte $00, $01, $02, $7F

; -----------------

	@arp_04:
	.byte $00
	.byte $00, $01, $02, $02, $00, $01, $02, $7F

; -----------------

	@arp_05:
	.byte $00
	.byte $00, $FF, $7F

; -----------------

	@arp_06:
	.byte $00
	.byte $00, $02, $7F

; -----------------

	@arp_07:
	.byte $00
	.byte $00, $02, $7F

; -----------------

	@arp_08:
	.byte $00
	.byte $06, $00, $7F

; -----------------

	@arp_09:
	.byte $00
	.byte $00, $00, $FD, $7F

; -----------------

	@arp_0A:
	.byte $00
	.byte $00, $05, $7F

; ----------------

	@arp_0B:
	.byte $00
	.byte $00, $01, $01, $02, $02, $03, $7F

; ----------------

	@arp_0C:
	.byte $00
	.byte $00, $07, $0C, $00, $07, $0C, $00, $00
	.byte $00, $00, $07, $0C, $00, $07, $0C, $7F

; ----------------

	@arp_unused:
	.byte $00, $00, $7F

; ----------------

	@arp_10:
	.byte $00
	.byte $00, $01, $02, $02, $02, $02, $02, $03
	.byte $03, $03, $03, $03, $04, $03, $7F

; ------------------------------------------------------------------------------

tbl_pitch_env_ptrs:
	.word @pitch_env_00
	.word @pitch_env_01
	.word @pitch_env_02
	.word @pitch_env_03
	.word @pitch_env_04
	.word @pitch_env_05
	.word @pitch_env_06
	.word @pitch_env_07

; -----------------

	@pitch_env_00:
	.byte $07, $00
	; Loop:
	.byte $02, $FF
	.byte $01, $00
	.byte $02, $01
	.byte $FF, $FA

; -----------------

	@pitch_env_01:
	.byte $01, $01, $FF, $00

; -----------------

; Absolute:
; 0 0 0 0 0 0 0 0 0 0 | -1 -2 -2 -1 0 0 2 2 1 0 0 -1 -2 -2 -1 0 1 2 2 1 0 0 -2 -2 -1 0 0 1 2 2 1 0 
	@pitch_env_02:
	.byte $0A, $00
	; Loop:
	.byte $01, $FF
	.byte $02, $FE
	.byte $01, $FF
	.byte $02, $00
	.byte $02, $02
	.byte $01, $01
	.byte $02, $00
	.byte $01, $FF
	.byte $02, $FE
	.byte $01, $FF
	.byte $01, $00
	.byte $01, $01
	.byte $02, $02
	.byte $01, $01
	.byte $02, $00
	.byte $02, $FE
	.byte $01, $FF
	.byte $02, $00
	.byte $01, $01
	.byte $02, $02
	.byte $01, $01
	.byte $01, $00
	.byte $FF, $D4

; -----------------

	@pitch_env_03:
	.byte $01, $00, $01, $FE, $FF, $00

; -----------------

; Relative:
; 0 0 0 0 0 0 0 0 0 0 | 0 0 -1 -1 -1 0 0 1 1 1 

; Absolute equivalent:
; 0 0 0 0 0 0 0 0 0 0 | 0 0 -1 -2 -3 -3 -3 -2 -1 0
	@pitch_env_04:	
	.byte $0A, $00
	; Loop:
	.byte $02, $00
	.byte $01, $FF
	.byte $01, $FE
	.byte $03, $FD
	.byte $01, $FE
	.byte $01, $FF
	.byte $01, $00
	.byte $FF, $F2

; -----------------

	@pitch_env_05:
	.byte $01, $01, $02, $02, $01, $01, $01, $FF
	.byte $02, $FE, $01, $FF, $FF, $F4

; -----------------

	@pitch_env_06:
	.byte $01, $02, $02, $04, $01, $02, $01, $FE
	.byte $02, $FC, $01, $FE, $FF, $F4

; -----------------

	@pitch_env_07:
	.byte $01, $10, $01, $20, $01, $30, $01, $40
	.byte $01, $50, $01, $60, $01, $70, $01, $7F
	.byte $FF, $00

; -----------------------------------------------------------------------------

tbl_duty_env_ptrs:
	.word @duty_env_00
	.word @duty_env_01
	.word @duty_env_02
	.word @duty_env_03
	.word @duty_env_04
	.word @duty_env_05
	.word @duty_env_06
	.word @duty_env_07
	.word @duty_env_08
	.word @duty_env_09
	.word @duty_env_0A
	.word @duty_env_0B
	.word @duty_env_0C
	.word @duty_env_0C	; @duty_env_0D
	.word @duty_env_0E
	.word @duty_env_09	; @duty_env_0F
	.word @duty_env_10

; -----------------

	@duty_env_00:
.IFDEF DENDY
	.byte $00, $80, $FF, $FF
.ELSE
	.byte $00, $40, $FF, $FF
.ENDIF

; -----------------

	@duty_env_01:
.IFDEF DENDY
	.byte $00, $80, $FF, $FF
.ELSE
	.byte $00, $40, $FF, $FF
.ENDIF

; -----------------

	@duty_env_02:
	.byte $00, $FF, $FF

; -----------------

	@duty_env_03:
.IFDEF DENDY
	.byte $80, $40, $FF, $FF
.ELSE
	.byte $40, $80, $FF, $FF
.ENDIF

; -----------------

	@duty_env_04:
.IFDEF DENDY
	.byte $40, $40, $FF, $FF
.ELSE
	.byte $80, $80, $C0, $FF, $FF
.ENDIF

; -----------------

	@duty_env_05:
.IFDEF DENDY
	.byte $80, $80, $40, $40, $40, $80, $80, $80
.ELSE
	.byte $40, $40, $80, $80, $80, $40, $40, $80
.ENDIF
	.byte $FF, $FF

; -----------------

	@duty_env_06:
.IFDEF DENDY
	.byte $80, $80, $40, $FF, $FF
.ELSE
	.byte $40, $40, $80, $FF, $FF
.ENDIF

; -----------------

	@duty_env_07:
.IFDEF DENDY
	.byte $80, $40, $FF, $FF
.ELSE
	.byte $40, $80, $FF, $FF
.ENDIF

; -----------------

	@duty_env_08:
.IFDEF DENDY
	.byte $00, $80, $FF, $FF
.ELSE
	.byte $00, $40, $FF, $FF
.ENDIF

; -----------------

	@duty_env_09:
	.byte $00, $FF, $FF

; -----------------

	@duty_env_0A:
.IFDEF DENDY
	.byte $40, $FF, $FF
.ELSE
	.byte $80, $FF, $FF
.ENDIF

; -----------------

	@duty_env_0B:
.IFDEF DENDY
	.byte $40, $FF, $FF
.ELSE
	.byte $80, $FF, $FF
.ENDIF

; ----------------

	@duty_env_0C:
.IFDEF DENDY
	.byte $40, $FF, $FF
.ELSE
	.byte $80, $FF, $FF
.ENDIF

; ----------------

	@duty_env_0E:
	.byte $0C
.IFDEF DENDY
	.byte $40, $40, $40, $40
.ELSE
	.byte $80, $80, $80, $80
.ENDIF
	.byte $FF, $FF

; ----------------

	@duty_env_10:
.IFDEF DENDY
	.byte $80, $FF, $FF
.ELSE
	.byte $40, $FF, $FF
.ENDIF
