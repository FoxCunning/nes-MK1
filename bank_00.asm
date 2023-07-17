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
	sta zp_7B
	jsr sub_prepare_stage_rle_pointer
	lda #$00
	sta zp_05
	jsr sub_stage_rle_unpack
	inc zp_7B
	lda zp_7B
	jsr sub_prepare_stage_rle_pointer
	lda #$01
	sta zp_05
	jmp sub_stage_rle_unpack ;jsr sub_stage_rle_unpack
	;rts

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
.incbin "bin/goros_lair_left.rle"

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_goros_lair_right:
.incbin "bin/goros_lair_right.rle"

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_pit_left:
.incbin "bin/stage_pit_left.rle"

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_pit_right:
.incbin "bin/stage_pit_right.rle"

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_courtyard_left:
.incbin "bin/courtyard_left.rle"

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_courtyard_right:
.incbin "bin/courtyard_right.rle"

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_palace_gates_left:
.incbin "bin/palace_gates_left.rle"

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_palace_gates_right:
.incbin "bin/palace_gates_right.rle"

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_warrior_shrine_left:
.incbin "bin/warrior_shrine_left.rle"

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_warrior_shrine_right:
.incbin "bin/warrior_shrine_right.rle"

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_throne_room_left:
.incbin "bin/throne_room_left.rle"

; -----------------------------------------------------------------------------

; Nametable data, starts with PPU address and terminates with $FFFF
rle_throne_room_right:
.incbin "bin/throne_room_right.rle"

; -----------------------------------------------------------------------------
.export sub_update_health_bars
; This seems to transfer data to the PPU, depending on the flags in $4B.
sub_update_health_bars:
	lda zp_4B
	cmp #$FF
	bne @D291

		; Display the full bar at the beginning of the match
		lda #$20
		sta PpuAddr_2006
		ldx #$71	; First pattern of health bar for Player 2
		lda zp_plr1_fighter_idx
		bpl :+
			ldx #$64	; First pattern of health bar for Player 1
		:
		stx PpuAddr_2006
		ldx #$0A
		lda #$8A	; Full bar pattern
		:
			sta PpuData_2007
		dex
		bpl :-

	rts
; ----------------
	@D291:
	lda zp_ppu_control_backup
	ora #$04
	sta PpuControl_2000
	lda zp_frame_counter
	and #$01
	bne :+
		ldx #$00
		jsr sub_rom_D359
		ldx #$01
		jsr sub_rom_D359
	:
	jmp @D2EE

	@D2AB:
	lda zp_ppu_control_backup
	sta PpuControl_2000
	lda zp_game_substate
	cmp #$03	; Match main loop
	beq @D2BE

	cmp #$04
	beq @D2BE

	cmp #$05
	bne @D2ED

	@D2BE:
	lda #$20
	sta PpuAddr_2006
	lda #$8F
	sta PpuAddr_2006
	lda zp_match_time
	cmp #$0F
	bcs @D2E1

	lda zp_frame_counter
	and #$04
	bne @D2E1

	lda zp_game_substate
	cmp #$03	; Match main loop
	bne @D2E1

	ldx #$FF
	stx PpuData_2007
	bne @D2EA

	@D2E1:
	ldx ram_063E
	stx PpuData_2007
	ldx ram_063F
	@D2EA:
	stx PpuData_2007
	@D2ED:
	rts
; ----------------
	@D2EE:
	lda zp_game_substate
	cmp #$03	; Match main loop
	beq @D356

	lda ram_plr1_rounds_won
	beq @D325

	ldx #$20
	stx PpuAddr_2006
	cmp #$02
	bcc @D316

	ldx #$41
	stx PpuAddr_2006
	lda #$AD
	sta PpuData_2007
	lda #$AE
	sta PpuData_2007
	lda #$20
	sta PpuAddr_2006
	@D316:
	ldx #$42
	stx PpuAddr_2006
	lda #$AD
	sta PpuData_2007
	lda #$AE
	sta PpuData_2007
	@D325:
	lda ram_plr2_rounds_won
	beq @D356

	ldx #$20
	stx PpuAddr_2006
	cmp #$02
	bcc @D347

	ldx #$5E
	stx PpuAddr_2006
	lda #$AD
	sta PpuData_2007
	lda #$AE
	sta PpuData_2007
	lda #$20
	sta PpuAddr_2006
	@D347:
	ldx #$5D
	stx PpuAddr_2006
	lda #$AD
	sta PpuData_2007
	lda #$AE
	sta PpuData_2007
	@D356:
	jmp @D2AB

; -----------------------------------------------------------------------------

sub_rom_D359:
	lda zp_plr1_damage,X
	cmp #$58
	bcc @D387

	lda zp_plr1_cur_anim,X
	cmp #$2E
	beq @D375

	cmp #$31
	beq @D375

	cmp #$26
	beq @D38B

	lda #$2E
	sta zp_plr1_cur_anim,X
	lda #$00
	sta zp_plr1_anim_frame,X
	@D375:
	lda zp_4B
	bmi @D38B

	; Play the "victory jingle"
	lda #$32
	sta ram_req_song
	lda #$10
	sta zp_92
	sta ram_0438
	bne @D38B

	@D387:
	lda zp_plr1_dmg_counter,X
	bne @D38C

	@D38B:
	rts
; ----------------
	@D38C:
	dec zp_plr1_dmg_counter,X
	inc zp_plr1_damage,X
	lda #$20
	sta PpuAddr_2006
	lda zp_plr1_damage,X
	sec
	sbc #$01
	lsr A
	lsr A
	lsr A
	sta zp_ptr1_lo
	txa
	bne @D3B7

	lda #$64
	clc
	adc zp_ptr1_lo
	sta PpuAddr_2006
	lda zp_plr1_damage
	sec
	sbc #$01
	and #$07
	tay
	lda @plr1_health_bar,Y
	bne @D3CA

	@D3B7:
	lda #$7B
	sec
	sbc zp_ptr1_lo
	sta PpuAddr_2006
	lda zp_plr1_damage,X
	sec
	sbc #$01
	and #$07
	tay
	lda @plr2_health_bar,Y
	@D3CA:
	sta PpuData_2007
	rts

; ----------------
; Pattern indices for health bars

	@plr1_health_bar:
	.byte $89, $88, $87, $86, $85, $84, $83, $82
	@plr2_health_bar:
	.byte $91, $90, $8F, $8E, $8D, $8C, $8B, $82

; -----------------------------------------------------------------------------



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
	sta ram_040F

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
	sta ram_0435
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
	.byte $00, $01, $05, $03, $04, $02, $02, $01
	.byte $04, $01, $02, $03, $00, $01, $05, $03
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
	sta ram_043F
	sta ram_0440

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
	.byte $FF, $6A, $3D, $37, $6B, $3A, $FF, $FF
	.byte $FF, $7A, $48, $42, $7B, $45, $FF, $FF

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
	sty zp_player_hit_counter
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
	lda zp_player_hit_counter
	cmp #$40
	bcs @C227

	inc zp_player_hit_counter
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
	sta zp_player_hit_counter
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
