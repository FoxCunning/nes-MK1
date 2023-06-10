.segment "BANK_01"
; $A000-$BFFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"

.incbin "bin/bank_01.bin"
