.segment "BANK_07b"
; $B000-$BFFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"

; -----------------------------------------------------------------------------
.export sub_ending_prepare

; Sets the attribute table for the ending screen. Each character can use a
; a different set of colours.
; Then copies the ending text data to RAM ($6F00-$6FFF).
; Notes: rendering should be disabled.
; Parameters:
; zp_plr1_fighter_idx = index of the winning character
sub_ending_prepare:
    ; Prepare pointer
    ldy zp_plr1_fighter_idx
    lda tbl_ending_attr_ptrs_lo,Y
    sta zp_ptr2_lo
    lda tbl_ending_attr_ptrs_hi,Y
    sta zp_ptr2_hi

    ; Copy attribute data to PPU
    ldy #$00
    :
        lda #$23
        sta PpuAddr_2006
        lda @tbl_ppu_addr,Y
        sta PpuAddr_2006

        lda (zp_ptr2_lo),Y
        sta PpuData_2007
        iny
        cpy #$09
    bcc :-

	lda #$80	; Write protection disabled
	sta mmc3_ram_protect

    ; Prepare pointer
	ldy zp_plr1_fighter_idx
	lda tbl_ending_text_ptrs_lo
	sta zp_ptr1_lo
	lda tbl_ending_text_ptrs_hi
	sta zp_ptr1_hi

    ; Copy ending text data to RAM
    ldy #$00
    :
        lda (zp_ptr1_lo),Y
        sta $6F00,Y
        iny
        cmp #$FF
    bne :-

	lda #$C0	; Write protection enabled
	sta mmc3_ram_protect

    rts

    @tbl_ppu_addr:
    .byte $D0, $D1, $D2, $D8, $D9, $DA, $E0, $E1, $E2

; -----------------------------------------------------------------------------

tbl_ending_attr_ptrs_lo:
    .byte <tbl_ending_attr_raiden

tbl_ending_attr_ptrs_hi:
    .byte >tbl_ending_attr_raiden

tbl_ending_attr_raiden:
    .byte $CC, $55, $11     ; $23D0, $23D1, $23D2
    .byte $4C, $DD, $11     ; $23D8, $23D9, $23DA
    .byte $04, $0D, $03     ; $23E0, $23E1, $23E2

; -----------------------------------------------------------------------------

tbl_ending_text_ptrs_lo:
	.byte <txt_raiden_ending
	.byte <txt_sonya_ending
	.byte <txt_subzero_ending
	.byte <txt_scorpion_ending
	.byte <txt_kano_ending
	.byte <text_cage_ending
	.byte <txt_liukang_ending
	.byte <txt_goro_ending
	.byte <txt_shangtsung_ending

tbl_ending_text_ptrs_hi:
	.byte >txt_raiden_ending
	.byte >txt_sonya_ending
	.byte >txt_subzero_ending
	.byte >txt_scorpion_ending
	.byte >txt_kano_ending
	.byte >text_cage_ending
	.byte >txt_liukang_ending
	.byte >txt_goro_ending
	.byte >txt_shangtsung_ending

; ----------------

    .repeat 26, i   ; Letters
        .charmap $61 + i, $E0 + i   ; Lowercase
        .charmap $41 + i, $E0 + i   ; Uppercase
    .endrepeat

	.charmap $20, $B4		; Space
	.charmap $2D, $A0   	; -
	.charmap $27, $A1		; '
	.charmap $2C, $B0		; ,
	.charmap $3A, $B1		; ;
	.charmap $2E, $B2		; .

; ----------------

txt_raiden_ending:
	.byte "raiden's victory", $00
	.byte "comes as no", $00
	.byte "surprise to him.", $00
	.byte "he was never", $00
	.byte "impressed by", $00
	.byte "shang tsung's", $00
	.byte "inferior sorcery", $00
	.byte "goro's brute", $00
	.byte "force, or the", $00
	.byte "challenge of the", $00
	.byte "other fighters.", $FF

txt_sonya_ending:
	.byte "sonya has won", $00
	.byte "the contest. her", $00
	.byte "victory not only", $00
	.byte "released her", $00
	.byte "unit, but also", $00
	.byte "put and end to", $00
	.byte "the black dragon", $00
	.byte "and shang", $00
	.byte "tsung's powerful", $00
	.byte "grip on the", $00
	.byte "tournament.", $FF

txt_subzero_ending:
	.byte $FF

txt_scorpion_ending:
	.byte $FF

txt_kano_ending:
	.byte $FF

text_cage_ending:
	.byte $FF

txt_liukang_ending:
	.byte $FF

txt_goro_ending:
	.byte $FF

txt_shangtsung_ending:
	.byte $FF

; -----------------------------------------------------------------------------
