.segment "BANK_00"
; $8000-$9FFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"

.incbin "bin/bank_00.bin"
