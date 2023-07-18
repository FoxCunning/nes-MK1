.segment "BANK_0E"
; $C000-$DFFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"


; -----------------------------------------------------------------------------
.export dmc_rayden

dmc_rayden:
.incbin "audio/rayden.dmc"

; ----------------
.export dmc_sonya

dmc_sonya:
.incbin "audio/sonya.dmc"

; ----------------
.export dmc_subzero

dmc_subzero:
.incbin "audio/subzero.dmc"

; ----------------
.export dmc_scorpion

dmc_scorpion:
.incbin "audio/scorpion.dmc"

; ----------------
.export dmc_kano

dmc_kano:
.incbin "audio/kano.dmc"

; ----------------
;.export dmc_wins

;dmc_wins:
;.incbin "audio/wins.dmc"

; ----------------
.export dmc_hit

dmc_hit:
.incbin "audio/hit_08.dmc"


; -----------------------------------------------------------------------------
