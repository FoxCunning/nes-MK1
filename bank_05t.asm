.segment "BANK_05t"
; $8000-$8FFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"

.incbin "bin/bank_05_top.bin"
