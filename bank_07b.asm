.segment "BANK_07b"
; $B000-$BFFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"

; -----------------------------------------------------------------------------
.export sub_ending_attributes

; Sets the attribute table for the ending screen. Each character can use a
; a different set of colours.
; Notes: rendering should be disabled.
; Parameters:
; zp_plr1_fighter_idx = index of the winning character
sub_ending_attributes:
    ldy zp_plr1_fighter_idx
    lda tbl_ending_attr_ptrs_lo,Y
    sta zp_ptr2_lo
    lda tbl_ending_attr_ptrs_hi,Y
    sta zp_ptr2_hi

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

