.segment "BANK_00"
; $8000-$9FFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"
.include "charmap.inc"


; -----------------------------------------------------------------------------
.export sub_load_stage_background

sub_load_stage_background:
	lda ram_irq_routine_idx
	asl A
	sta zp_plr_ofs_param
	jsr sub_prepare_stage_rle_pointer

	lda #$00
	sta zp_05
	jsr sub_stage_rle_unpack

	inc zp_plr_ofs_param
	lda zp_plr_ofs_param
	jsr sub_prepare_stage_rle_pointer

	lda #$01
	sta zp_05
	jmp sub_stage_rle_unpack

; -----------------------------------------------------------------------------

sub_prepare_stage_rle_pointer:
	asl A
	tax
	lda tbl_stage_rle_ptrs+0,X
	sta zp_ptr1_lo
	lda tbl_stage_rle_ptrs+1,X
	sta zp_ptr1_hi
	lda zp_ptr1_lo
	clc
	adc #$02
	sta zp_ptr1_lo
	lda zp_ptr1_hi
	adc #$00
	sta zp_ptr1_hi
	rts

; -----------------------------------------------------------------------------

; PPU pointers to the four nametables (stage backgrounds)
tbl_stage_ppu_ptrs:
	.word $2000, $2400, $2800, $2C00

; -----------------------------------------------------------------------------

sub_stage_rle_unpack:
	lda #$00
	sta PpuControl_2000
	sta PpuMask_2001
	lda zp_05
	asl A
	tax
	ldy #$00
	lda PpuStatus_2002
	lda tbl_stage_ppu_ptrs+1,X
	sta PpuAddr_2006
	lda tbl_stage_ppu_ptrs+0,X
	sta PpuAddr_2006
	@805E:
	lda (zp_ptr1_lo),Y
	bpl @807C
	cmp #$FF
	beq @8090

		and #$7F
		sta zp_18
		@806A:
			jsr sub_rom_8091
			lda (zp_ptr1_lo),Y
			sta PpuData_2007
		dec zp_18
		bne @806A

		jsr sub_rom_8091
		jmp @805E

		@807C:
		sta zp_18
		jsr sub_rom_8091
		lda (zp_ptr1_lo),Y
		@8083:
			sta PpuData_2007
		dec zp_18
		bne @8083

		jsr sub_rom_8091
		jmp @805E

	@8090:
	rts

; -----------------------------------------------------------------------------

; TODO Inline this
sub_rom_8091:
	inc zp_ptr1_lo
	bne :+
		inc zp_ptr1_hi
	:
	rts

; -----------------------------------------------------------------------------

tbl_stage_rle_ptrs:
	.word rle_goros_lair_left		; $00
	.word rle_goros_lair_right
	.word rle_pit_left				; $01
	.word rle_pit_right
	.word rle_courtyard_left		; $02
	.word rle_courtyard_right
	.word rle_palace_gates_left		; $03
	.word rle_palace_gates_right
	.word rle_warrior_shrine_left	; $04
	.word rle_warrior_shrine_right
	.word rle_throne_room_left		; $05
	.word rle_throne_room_right

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_goros_lair_left:
.incbin "nam/goros_lair_left.rle"

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_goros_lair_right:
.incbin "nam/goros_lair_right.rle"

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_pit_left:
.incbin "nam/stage_pit_left.rle"

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_pit_right:
.incbin "nam/stage_pit_right.rle"

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_courtyard_left:
.incbin "nam/courtyard_left.rle"

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_courtyard_right:
.incbin "nam/courtyard_right.rle"

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_palace_gates_left:
.incbin "nam/palace_gates_left.rle"

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_palace_gates_right:
.incbin "nam/palace_gates_right.rle"

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_warrior_shrine_left:
.incbin "nam/warrior_shrine_left.rle"

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_warrior_shrine_right:
.incbin "nam/warrior_shrine_right.rle"

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_throne_room_left:
.incbin "nam/throne_room_left.rle"

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_throne_room_right:
.incbin "nam/throne_room_right.rle"

; -----------------------------------------------------------------------------
.export sub_init_game_mode

; Initialises "game mode", setting a new IRQ handler, loading nametable data
; for the stage background, sprite data for the player(s) and music
sub_init_game_mode:
	; Retrieve the stage index
	lda zp_plr2_fighter_idx	; This is player 2 fighter index, bit 7 is set for CPU opponent
	and #$7F
	tax
	lda @tbl_stage_indices,X
	sta ram_irq_routine_idx

	; Disable rendering and NMI generation
	lda #$00
	sta PpuControl_2000
	sta zp_ppu_control_backup
	sta PpuMask_2001
	sta zp_ppu_mask_backup

	lda #$01
	sta ram_game_mode_initialised

	; Check if the two players are using the same fighter
	; Then either add or subtract $0C to the index in order to load
	; the alternative palette
	lda zp_plr1_fighter_idx	; <- Player 1
	and #$7F
	sta zp_ptr1_lo
	lda zp_plr2_fighter_idx	; <- Player 2
	and #$7F
	cmp zp_ptr1_lo
	bne @C05A

	cmp #$0C
	bcc @C04D

	sec
	sbc #$0C
	jmp @C050

	@C04D:
	clc
	adc #$0C

	@C050:
	sta zp_ptr1_lo
	lda zp_plr2_fighter_idx
	and #$80
	ora zp_ptr1_lo
	sta zp_plr2_fighter_idx
	@C05A:
	lda zp_plr1_fighter_idx
	and #$7F
	sta zp_plr1_fgtr_idx_clean
	lda zp_plr2_fighter_idx
	and #$7F
	sta zp_plr2_fgtr_idx_clean

	; Select stage music
	ldx ram_irq_routine_idx
	lda @tbl_y_pos_offsets,X
	sta zp_sprites_base_y
	txa
	clc
	adc #$25	; Stage music offset
	sta ram_req_song

	lda #$00
	sta ram_irq_state_var
	sta ram_042D
	sta zp_scroll_x
	sta ram_0438
	sta zp_scroll_y

	jsr sub_clear_oam_data
	jsr sub_call_load_stage_bg
	jsr sub_show_fighter_names
	jsr sub_finish_match_init

	lda #$18
	sta zp_ppu_mask_backup
	lda #$88
	sta PpuControl_2000
	sta zp_ppu_control_backup
	lda #$00
	sta mmc3_mirroring
	inc zp_game_substate
	;nop
	lda zp_60
	sta zp_4B
	rts

; ----------------

	@tbl_stage_indices:
	.byte $00, $01, $05, $03, $04, $02, $02
	.byte $01, $04, $01
	.byte $02, $03
	.byte $00, $01, $05, $03
	.byte $04, $02, $02, $01, $04, $01, $02, $03

; ----------------

	@tbl_y_pos_offsets:
	.byte $DA, $D0, $DA, $DA, $DA, $DA

; -----------------------------------------------------------------------------
.export sub_call_load_stage_bg

; Loads stage background nametables from bank 0
; $8000-$9FFF = Bank $00
; $A000-$BFFF = Bank $01
sub_call_load_stage_bg:
	lda #$00
	sta ram_irq_counter_0
	sta ram_irq_counter_1

	; Not needed after code relocation
	; Bank $00 in $8000-$9FFF
	;lda #$86
	;sta zp_prg_bank_select_backup
	;sta mmc3_bank_select
	;lda #$00
	;sta mmc3_bank_data
	; Bank $01 in $A000-$BFFF
	;lda #$87
	;sta zp_prg_bank_select_backup
	;sta mmc3_bank_select
	;lda #$01
	;sta mmc3_bank_data

	jmp sub_load_stage_background ;jsr sub_rom_00_8000
	;rts

; -----------------------------------------------------------------------------
.export sub_rebase_fighter_indices

; If any of the fighter indices were changed to load the alt palette,
; put it back as it was before ($00-$08 instead of $0C-$14)
sub_rebase_fighter_indices:
	lda zp_plr1_fgtr_idx_clean	; Player 1 fighter idx
	@C0EC:
	cmp #$0C
	bcc @C0F8

	sec
	sbc #$0C
	sta zp_plr1_fgtr_idx_clean
	jmp @C0EC

	@C0F8:
	lda zp_plr2_fgtr_idx_clean	; Player 2 fighter idx
	@C0FA:
	cmp #$0C
	bcc @C106

	sec
	sbc #$0C
	sta zp_plr2_fgtr_idx_clean
	jmp @C0FA

	@C106:
	rts

; -----------------------------------------------------------------------------
.export sub_match_fade_in

sub_match_fade_in:
	lda ram_0401
	bne :+
		jsr sub_rom_C69C
	:
	jsr sub_fade_palettes_in
	bcc :+
		inc zp_game_substate
	:
	rts

; -----------------------------------------------------------------------------
.export sub_match_start

sub_match_start:
	ldy zp_match_time	; The match will start when this counter reaches 99 ($63)
	bne :+
		; Counter is zero: show round number
		ldx #$00
		@round_text_loop:
			lda @str_round,X
			sta ram_ppu_data_buffer,X
		inx
		cpx #$06
		bcc @round_text_loop
		
		; Show round number
		lda ram_plr1_rounds_won
		clc
		adc ram_plr2_rounds_won
		tax
		lda @str_numbers,X
		ldx #$06
		sta ram_ppu_data_buffer,X
		inx

		lda #$01
		jsr sub_announcer_text
	:
	cpy #$31
	bne :+
		; "FIGHT!"
		lda #$06
		sta ram_req_sfx
		; Show text
		ldx #$00
		@fight_text_loop:
			lda @str_fight,X
			sta ram_ppu_data_buffer,X
		inx
		cpx #$10
		bcc @fight_text_loop

		ldx #$08
		lda #$02 ; Two rows
		jsr sub_announcer_text
	:
	cpy #$63
	beq :+
		; Just waiting, increase the counter and return
		inc zp_match_time
		rts
	:
	; Counter is 99: advance substate and begin the match
	
	lax #$00
	sta zp_A2
	; Clear text
	:
		sta ram_ppu_data_buffer,X
	inx
	cpx #$10
	bcc :-
	ldx #$08 ; Clear 8 columns
	lda #$02 ; Clear two rows
	jsr sub_announcer_text

	inc zp_game_substate
	rts

; ----------------

	@str_round:
	.byte "ROUND "
	@str_numbers:
	.byte $1F, $20, $21	; Yellow numbers 1, 2 and 3
	@str_fight:
	.byte $FF, $6A, $6B, $6C, $6D, $6E, $6F, $FF
	.byte $FF, $7A, $7B, $7C, $7D, $7E, $7F, $FF

; -----------------------------------------------------------------------------

; Parameters:
; X = columns
; A = rows
sub_announcer_text:
		; X = number of characters in string
		stx zp_nmi_ppu_cols
		;lda #$01
		sta zp_nmi_ppu_rows
		ldx #$4C
		; PPU Address = $204C, or $202C for the larger text
		cmp #$01
		bcc :+
			ldx #$2C
		:
		lda #$20
		sta zp_nmi_ppu_ptr_hi
		stx zp_nmi_ppu_ptr_lo
		rts

; -----------------------------------------------------------------------------

.export sub_match_eval

sub_match_eval:
	inc zp_9E
	ldy #$00
	sty zp_counter_var_F1
	jsr sub_rom_C207

	iny
	jsr sub_rom_C207

	rts

; -----------------------------------------------------------------------------

sub_rom_C207:
	ldx #$07
	lda ram_plr1_rounds_won,Y
	cmp #$02
	bcs @C215

	lda zp_5E
	bne @C215

	inx
	@C215:
	stx zp_game_substate
	cpx #$08
	beq @C21D

	pla
	pla
	@C21D:
	rts

; -----------------------------------------------------------------------------
.export sub_match_fade_out

sub_match_fade_out:
	lda zp_counter_var_F1
	cmp #$40
	bcs @C227

	inc zp_counter_var_F1
	rts
; ----------------
	@C227:
	jsr sub_fade_palettes_out
	bcc @C271

	lda zp_9E
	cmp #$09
	bcs @C238

	lda zp_game_substate
	cmp #$08
	beq @C268

	@C238:
	ldx #$01
	lda ram_plr2_rounds_won
	cmp ram_plr1_rounds_won
	bcs @C243

	dex
	@C243:
	stx ram_040C
	ldx #$02
	lda zp_5E
	beq @C24D

	inx
	@C24D:
	stx zp_machine_state_0
	lda #$0B
	sta ram_irq_routine_idx
	lda #$00
	sta zp_scroll_y
	jsr sub_hide_fighter_sprites
	lda #$00
	sta ram_067C
	sta ram_plr1_rounds_won
	sta ram_plr2_rounds_won
	sta zp_9E
	@C268:
	lda #$00
	sta ram_067D
	sta zp_game_substate
	sta zp_counter_var_F1
	@C271:
	rts

; -----------------------------------------------------------------------------

sub_hide_fighter_sprites:
	ldx #$00
	beq :+
		ldx #$80	; Offset for player 2 sprites
	:
	lda #$F8
	:
	sta ram_oam_copy_ypos,X
	inx
	inx
	inx
	inx
	bne :-
	
	rts

; -----------------------------------------------------------------------------
.export sub_show_fighter_names

sub_show_fighter_names:
	lda zp_plr1_fgtr_idx_clean
	asl A
	tax
	lda tbl_fighter_name_ptrs,X
	sta zp_ptr3_lo
	lda tbl_fighter_name_ptrs+1,X
	sta zp_ptr3_hi
	lda #$01
	sta zp_nmi_ppu_rows
	lda #$1C
	sta zp_nmi_ppu_cols
	lda #$20
	sta zp_nmi_ppu_ptr_hi
	ldx #$84
	stx zp_nmi_ppu_ptr_lo
	ldx #$00
	lda #$FF
	@CDF7:
	sta ram_ppu_data_buffer,X
	inx
	cpx #$38
	bcc @CDF7

	ldx #$00
	ldy #$00
	lda (zp_ptr3_lo),Y
	sta zp_07
	iny
	@CE08:
	lda (zp_ptr3_lo),Y
	cmp #$20
	beq @CE14

	clc
	adc #$80
	sta ram_ppu_data_buffer,X
	@CE14:
	iny
	inx
	cpx zp_07
	bcc @CE08

	lda zp_plr2_fgtr_idx_clean
	asl A
	tax
	lda tbl_fighter_name_ptrs,X
	sta zp_ptr3_lo
	lda tbl_fighter_name_ptrs+1,X
	sta zp_ptr3_hi
	ldy #$00
	ldx #$17
	lda (zp_ptr3_lo),Y
	tay
	@CE2F:
	lda (zp_ptr3_lo),Y
	cmp #$20
	beq @CE3B

	clc
	adc #$80
	sta ram_ppu_data_buffer,X
	@CE3B:
	dex
	dey
	bne @CE2F

	rts

; -----------------------------------------------------------------------------

; Pointers to name strings
tbl_fighter_name_ptrs:
	; Player 1
	.word str_name_raiden
	.word str_name_sonya
	.word str_name_subzero
	.word str_name_scorpion
	.word str_name_kano
	.word str_name_cage
	.word str_name_liukang
	.word str_name_goro
	.word str_name_shangtsung
	.word str_name_empty_7spc0
	.word str_name_empty_7scp1
	.word str_name_empty_3spc
	; Player 2
	.word str_name_raiden
	.word str_name_sonya
	.word str_name_subzero
	.word str_name_scorpion
	.word str_name_kano
	.word str_name_cage
	.word str_name_liukang
	.word str_name_goro
	.word str_name_shangtsung
	.word str_name_empty_7spc0
	.word str_name_empty_7scp1
	.word str_name_empty_3spc

; -----------------------------------------------------------------------------

; Byte 0 = lengh, Bytes 1 to (length) = name
str_name_raiden:
	.byte $06, $52, $41, $49, $44, $45, $4E
str_name_sonya:
	.byte $05, $53, $4F, $4E, $59, $41
str_name_subzero:
	.byte $08, $53, $55, $42, $5C, $5A, $45, $52, $4F
str_name_scorpion:
	.byte $08, $53, $43, $4F, $52, $50, $49, $4F, $4E
str_name_kano:
	.byte $04, $4B, $41, $4E, $4F
str_name_cage:
	.byte $04, $43, $41, $47, $45
str_name_liukang:
	.byte $08, $4C, $49, $55, $5C, $4B, $41, $4E, $47
str_name_goro:
	.byte $04, $47, $4F, $52, $4F
str_name_shangtsung:
	.byte $0B, $53, $48, $41, $4E, $47, $5C, $54, $53, $55, $4E, $47
str_name_empty_7spc0:
	;.byte $07, $20, $20, $20, $20, $20, $20, $20
str_name_empty_7scp1:
	;.byte $07, $20, $20, $20, $20, $20, $20, $20
str_name_empty_3spc:
	;.byte $03, $20, $20, $20
_empty:
	.byte $00

; Nothing seems to point to these "empty" names
	;.byte $03, $20, $20, $20
	;.byte $05, $20, $20, $20, $20, $20
	;.byte $03, $20, $20, $20
	;.byte $07, $20, $20, $20, $20, $20, $20, $4B
	;.byte $03, $20, $41, $20
	;.byte $06, $41, $20, $20, $20, $20, $4C
	;.byte $06, $20, $20, $20, $20, $20, $20
	;.byte $06, $20, $20, $20, $20, $20, $20
	;.byte $04, $42, $20, $20, $20
	;.byte $06, $20, $20, $20, $20, $20, $4F
	;.byte $07, $42, $20, $20, $20, $20, $20, $20
	;.byte $04, $20, $20, $20, $47

; -----------------------------------------------------------------------------
.export sub_fade_palettes_in

; Parameters:
; ram_0401 = fade cycle index (0-6 for fade in, anything higher is ignored)
; ram_640 to ram_65F = target palettes for fade effect
; Returns:
; C = clear if colours have been faded (one step), set otherwise
sub_fade_palettes_in:
	ldx ram_0401
	cpx #$07
	bcs @D43F

		ldy ram_0402
		bne :+
			ldy #$03
			sty ram_0402
		:
		dec ram_0402
		bne :+
			jsr sub_fade_colours
			inc ram_0401	; Increment the index for the next fade cycle
		:
		clc
	@D43F:
	rts

; -----------------------------------------------------------------------------
.export sub_fade_palettes_out

; Parameters:
; ram_0401 = fade cycle index (7-1 for fade out)
; ram_640 to ram_65F = target palettes for fade effect
; Returns:
; C = clear if colours have been faded (one step), set otherwise
sub_fade_palettes_out:
	ldx ram_0401
	beq @D463

		ldy ram_0402
		bne :+
			ldy #$03
			sty ram_0402
		:
		dec ram_0402
		bne @D461

			dec ram_0401
			dex
			jsr sub_fade_colours
			cpx #$00
			bne @D461

				stx zp_ppu_mask_backup
		@D461:
		clc
		rts
; ----------------
	@D463:
	sec
	rts

; -----------------------------------------------------------------------------
; Parameters:
; ram_640 to ram_65F = target palettes for fade effect
sub_fade_colours:
	ldy #$1F ;ram_0400 seems to be constant anyway
	:
		lda ram_0640,Y
		cmp tbl_pal_cycle_min,X
		bcs @darken_colour

			; Value too low, use black
			lda #$0E
			bcc @write_value

		@darken_colour:
		; This will reduce the colour value depending on the current minimum
		; e.g.: $36 -> $06 if min is $30, $36 -> $16 if min is $20, etc.
		lda tbl_pal_cycle_min,X
		eor #$3F
		and ram_0640,Y

		@write_value:
		sta ram_ppu_data_buffer,Y
	dey
	bpl :-

	lda tbl_pal_cycle_ppumasks,X
	sta zp_ppu_mask_backup
	lda #$3F
	sta zp_nmi_ppu_ptr_hi
	lda #$00
	sta zp_nmi_ppu_ptr_lo
	lda #$01
	sta zp_nmi_ppu_rows
	lda #$20
	sta zp_nmi_ppu_cols
	rts

; ----------------

; If the indexed colour is not at least this value, then use black instead
tbl_pal_cycle_min:
	.byte $FF, $30, $30, $20, $20, $10, $00

; ----------------

; Alternates between colour emphasis enabled and disabled
tbl_pal_cycle_ppumasks:
	.byte $1E, $FE, $1E, $FE, $1E, $1E, $1E

; -----------------------------------------------------------------------------
