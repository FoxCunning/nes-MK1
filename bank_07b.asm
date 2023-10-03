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
	lda tbl_ending_text_ptrs_lo,Y
	sta zp_ptr1_lo
	lda tbl_ending_text_ptrs_hi,Y
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
	.byte <tbl_ending_attr_sonya
	.byte <tbl_ending_attr_subzero
	.byte <tbl_ending_attr_scorpion
	.byte <tbl_ending_attr_kano
	.byte <tbl_ending_attr_cage
	.byte <tbl_ending_attr_liukang
	.byte <tbl_ending_attr_goro
	.byte <tbl_ending_attr_shangtsung

tbl_ending_attr_ptrs_hi:
    .byte >tbl_ending_attr_raiden
	.byte >tbl_ending_attr_sonya
	.byte >tbl_ending_attr_subzero
	.byte >tbl_ending_attr_scorpion
	.byte >tbl_ending_attr_kano
	.byte >tbl_ending_attr_cage
	.byte >tbl_ending_attr_liukang
	.byte >tbl_ending_attr_goro
	.byte >tbl_ending_attr_shangtsung

; ----------------

tbl_ending_attr_raiden:
    .byte $CC, $55, $11     ; $23D0, $23D1, $23D2
    .byte $4C, $DD, $11     ; $23D8, $23D9, $23DA
    .byte $04, $0D, $03     ; $23E0, $23E1, $23E2

tbl_ending_attr_sonya:
    .byte $44, $5D, $33     ; $23D0, $23D1, $23D2
    .byte $44, $15, $13     ; $23D8, $23D9, $23DA
    .byte $04, $05, $01     ; $23E0, $23E1, $23E2

tbl_ending_attr_subzero:
    .byte $44, $FF, $F1     ; $23D0, $23D1, $23D2
    .byte $4C, $57, $1F     ; $23D8, $23D9, $23DA
    .byte $04, $05, $01     ; $23E0, $23E1, $23E2

tbl_ending_attr_scorpion:
    .byte $44, $DD, $33     ; $23D0, $23D1, $23D2
    .byte $44, $DD, $33     ; $23D8, $23D9, $23DA
    .byte $04, $0D, $03     ; $23E0, $23E1, $23E2

tbl_ending_attr_kano:
    .byte $CC, $FF, $33     ; $23D0, $23D1, $23D2
    .byte $CC, $44, $11     ; $23D8, $23D9, $23DA
    .byte $0C, $07, $01     ; $23E0, $23E1, $23E2

tbl_ending_attr_cage:
    .byte $44, $55, $11     ; $23D0, $23D1, $23D2
    .byte $44, $55, $11     ; $23D8, $23D9, $23DA
    .byte $04, $05, $01     ; $23E0, $23E1, $23E2

tbl_ending_attr_liukang:
    .byte $44, $55, $11     ; $23D0, $23D1, $23D2
    .byte $44, $55, $11     ; $23D8, $23D9, $23DA
    .byte $04, $05, $01     ; $23E0, $23E1, $23E2

tbl_ending_attr_goro:
    .byte $44, $55, $11     ; $23D0, $23D1, $23D2
    .byte $44, $55, $11     ; $23D8, $23D9, $23DA
    .byte $04, $05, $01     ; $23E0, $23E1, $23E2

tbl_ending_attr_shangtsung:
    .byte $44, $55, $11     ; $23D0, $23D1, $23D2
    .byte $44, $55, $11     ; $23D8, $23D9, $23DA
    .byte $04, $05, $01     ; $23E0, $23E1, $23E2

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
	.byte "sub-zero was", $00
	.byte "paid a large sum", $00
	.byte "of money for the", $00
	.byte "assassination of", $00
	.byte "shang tsung.", $00
	.byte "with his mission", $00
	.byte "accomplished, he", $00
	.byte "will now retire", $00
	.byte "from his dange-", $00
	.byte "rous profession.", $FF

txt_scorpion_ending:
	.byte "even with his", $00
	.byte "triumph in the", $00
	.byte "tournament, the", $00
	.byte "price scorpion", $00
	.byte "paid was high.", $00
	.byte "he can never see", $00
	.byte "his family again", $00
	.byte "and must live", $00
	.byte "with his secret", $00
	.byte "curse.", $FF

txt_kano_ending:
	.byte "with the defeat", $00
	.byte "of goro and", $00
	.byte "shang tsung,", $00
	.byte "kano will bring", $00
	.byte "his own brand of", $00
	.byte "treachery to the", $00
	.byte "tournament, now", $00
	.byte "under the", $00
	.byte "monopoly of", $00
	.byte "the black dragon."

text_cage_ending:
	.byte "cage returns to", $00
	.byte "hollywood after", $00
	.byte "defending his", $00
	.byte "new title as", $00
	.byte "grand champion.", $00
	.byte "he goes on to", $00
	.byte "film mortal", $00
	.byte "kombat:the movie", $00
	.byte "and its many", $00
	.byte "successful", $00
	.byte "sequels", $FF

txt_liukang_ending:
	.byte "after defeating", $00
	.byte "goro and shang", $00
	.byte "tsung, kang will", $00
	.byte "continue the", $00
	.byte "tranditions of", $00
	.byte "the shaolin tem-", $00
	.byte "ples and restore", $00
	.byte "the true pride", $00
	.byte "and respect of", $00
	.byte "this once great", $00
	.byte "tournament.", $FF

txt_goro_ending:
	.byte "after annihila-", $00
	.byte "ting all of the", $00
	.byte "tournament's", $00
	.byte "competitors,", $00
	.byte "goro reaps the", $00
	.byte "rewards and", $00
	.byte "invades the", $00
	.byte "earth kingdoms", $00
	.byte "with his master", $00
	.byte "shang tsung.", $FF

txt_shangtsung_ending:
	.byte "once again,shang", $00
	.byte "tsung has trium-", $00
	.byte "phed as the only", $00
	.byte "champion of the", $00
	.byte "tournament.", $00
	.byte "his evil reign", $00
	.byte "will now forever", $00
	.byte "extend to the", $00
	.byte "earthrealm.", $FF

; -----------------------------------------------------------------------------
