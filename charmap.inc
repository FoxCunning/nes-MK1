    .repeat 10, i  ; Numbers
        .charmap $30 + i, $1E + i
    .endrepeat

    .repeat 26, i   ; Letters
        .charmap $61 + i, $C1 + i   ; Uppercase
        .charmap $41 + i, $50 + i   ; Lowercase
    .endrepeat

    .charmap $20, $00   ; (space)