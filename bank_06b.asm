.segment "BANK_06b"
; $B000-$BDFFF
; Then transferred to RAM ($7000-$7FFF)
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"

; -----------------------------------------------------------------------------
.export sub_clear_ram

sub_clear_ram:
	lda #$00
	tay
	sta zp_00
	sta zp_01
	:
		; Clear $0100-$01FF
		sta (zp_00),Y
	iny
	bne :-

	; Clear $0200-$07FF
	ldx #$02
	stx zp_01
	:
			sta (zp_00),Y
		iny
		bne :-

		inc zp_01
		inx

	cpx #$08
	bcc :-

	sta zp_01
	rts

; -----------------------------------------------------------------------------
.export sub_clear_nametable

; Fills a nametable with $FF (including attribute table area)
; Parameters:
; A = index of nametable to clear (0: $2000-$23FF, 1: $2400-$27FF etc.)
sub_clear_nametable:
	asl A
	asl A
	clc
	adc #$20
	ldx #$00
	sta PpuAddr_2006
	stx PpuAddr_2006

	ldy #$03
	lda #$FF
	:
			sta PpuData_2007
		dex
		bne :-
	
	dey
	bpl :-

	rts

; -----------------------------------------------------------------------------
.export sub_hide_all_sprites

sub_hide_all_sprites:
	lda #$F8
	ldx #$00
	:
        sta ram_oam_copy_ypos,X
        inx
        inx
        inx
        inx
	bne :-

	rts

; -----------------------------------------------------------------------------
