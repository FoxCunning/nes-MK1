    .repeat 10, i  ; Numbers
        .charmap $30 + i, $1E + i
    .endrepeat

    .repeat 26, i   ; Letters
        .charmap $61 + i, $C1 + i   ; Lowercase
        .charmap $41 + i, $50 + i   ; Uppercase
    .endrepeat

    .charmap $20, $00   ; (space)
    .charmap $2D, $DC   ; -
    ; Use the underscore symbol as an alternative space for strings that are null-terminated
    .charmap $5F, $C0   ; _
