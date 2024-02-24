.segment "BANK_01"
; $A000-$BFFF
.setcpu "6502X"

.feature org_per_seg
.feature pc_assignment

.include "globals.inc"



; -----------------------------------------------------------------------------
;
;						Relocated bank $0E code
;
; -----------------------------------------------------------------------------

; Temporary definitions
rom_8000 = $8000	;
rom_8002 = $8002	;


; -----------------------------------------------------------------------------
.export sub_state_machine_1

; This state starts right after fighter selection
sub_state_machine_1:
	lda zp_game_substate
	jsr sub_game_trampoline
; ----------------
	.word sub_init_game_mode	; Substate 0
	.word sub_match_fade_in		; Substate 1
	.word sub_match_start		; Substate 2
	.word sub_match_loop		; Substate 3	Match ongoing
	.word sub_match_hit			; Substate 4	Someone was hit
	.word sub_match_end			; Substate 5	End, victory pose and score
	.word sub_match_eval		; Substate 6	Evaluate result (choose either 7 or 8 for next state)
	.word sub_match_fade_out	; Substate 7	Fade out
	.word sub_match_fade_out	; Substate 8	Fade out (to next round)
	.word sub_rom_C284			; Substate 9	Back to main menu?

; -----------------------------------------------------------------------------

sub_match_loop:
	lda zp_plr1_fighter_idx
	and #$80
	beq :+
		; No controller input for CPU opponent
		asl ;same as lda #$00
		sta zp_controller1
		sta zp_controller1_new
	:
	lda zp_plr2_fighter_idx
	and #$80
	beq :+
		; No controller input for CPU opponent
		asl ;same as lda #$00
		sta zp_controller2
		sta zp_controller2_new
	:
	jsr sub_calc_players_distance
	jsr sub_check_special_move
	jsr sub_match_controller_input

	jsr sub_call_match_routines

	lda zp_short_counter
	cmp zp_short_counter_target	; Typically every 2 frames
	bcs :+
		; If needed, show victory/shame animation
		; Update match time display
		jsr sub_upd_anim_and_timer ;sub_rom_CCA8
	:
	inc zp_23
	jsr sub_short_counter_tick	; TODO Inline this
	bcc :+
		; Also normally every 2 frames
		jsr sub_request_hit_sound
		jsr sub_set_irq_x_scroll
		jsr sub_rom_CA9D
		
		;jsr sub_rom_D76D
		jsr sub_move_fighter_sprites
		jsr sub_rom_D20A
		
		jsr sub_adjust_facing
		jsr sub_rom_C9EC
	:
	jmp sub_rom_C29E ;jsr sub_rom_C29E
	;rts

; -----------------------------------------------------------------------------

sub_match_hit:
	jsr sub_match_hit_loop
	lda #$00

	lda zp_5E
	bne :+
		jmp sub_rom_C695
	:
	rts

; -----------------------------------------------------------------------------

sub_match_end:
	lda zp_match_time
	beq @C197	; Branch if time over

	lda zp_4B
	bpl @C192

		jmp sub_rom_D3DE
; ----------------
	@C192:
	dec zp_match_time
	jsr sub_update_match_time	; Score calculation based on remaining time

	@C197:
	lda zp_16bit_hi	; Score left to add, high byte
	bne @C19F

	lda zp_16bit_lo	; Score left to add, low byte
	beq @victory_end

	@C19F:
	; Unfortunately, this causes graphical glitches when we also have to play DPCM samples
	; That is because of the extra cycles due to the sound driver constantly
	; changing the currently playing SFX
	;lda zp_frame_counter
	;and #$03	; Short pause between bleeps
	;bne @C1AF

		;lda #$22	; Silence everything
		;sta ram_req_song
		;lda #$09	; Pulse bleep (score counter)
		;sta ram_req_sfx
		
	; Determine winner based on damage taken
	;@C1AF:
	ldy #$00
	ldx #$00
	lda zp_plr1_damage
	cmp zp_plr2_damage
	bcc @C1C3	; Branch if player 1 wins

		bne :+
			; Same health: nobody wins
			stx zp_counter_param
			beq @victory_end
		:
		lda ram_game_mode_initialised
		beq @victory_end

			iny		; Player 2 wins
			ldx #$03
	@C1C3:
	sty zp_plr_idx_param	; Index of winning player
	stx zp_plr_ofs_param
	
	lda zp_counter_param
	beq :+
		jsr sub_announce_winner_name
	:

	jsr sub_clear_score_display

	ldx zp_plr_ofs_param
	lda #$01
	sta zp_05
	lda #$00
	sta zp_06
	jsr sub_update_score_display

	; Start playing bleep sounds when both counters are zero
	lda zp_counter_param
	bne @skip_bleep

		lda zp_short_counter
		beq @play_bleep

			dec zp_short_counter
			bne @skip_bleep

		@play_bleep:
		lda zp_frame_counter
		and #$03
		bne @skip_bleep
			lda #$09	; Pulse bleep (score counter)
			sta ram_req_sfx

	@skip_bleep:

	lda zp_plr_idx_param
	eor #$01
	sta zp_plr_idx_param
	lda zp_plr_ofs_param
	eor #$03
	tax
	stx zp_plr_ofs_param
	jsr sub_rom_C6E2

	lda zp_16bit_lo
	sec
	sbc #$01
	sta zp_16bit_lo
	bcs :+
		dec zp_16bit_hi
	:
	rts
; ----------------
	@victory_end:
	lda zp_counter_param
	bne :+	; Wait for the announcer, if needed
		inc zp_game_substate
		rts
	:
	;jmp sub_announce_winner_name
	;rts

; -----------------------------------------------------------------------------

sub_announce_winner_name:
	inc zp_counter_param
	lda zp_counter_param
	cmp #$14
	bne @wait_for_name
		
		; Announce name after 20 frames
		ldx zp_plr_idx_param	; Winner index
		lda zp_plr1_fgtr_idx_clean,X
		cmp #$07	; Skip Goro and Shang-Tsung
		bcs @abort_announcement

			clc
			adc #$11
			sta ram_req_sfx
			rts

	@wait_for_name:
	cmp #$50
	bne @winner_name_rts

		; Time to say "wins"
		lda #$18
		sta ram_req_sfx

		@abort_announcement:
		lda #$00
		sta zp_counter_param

		lda #$30
		sta zp_short_counter

	@winner_name_rts:
	rts

; -----------------------------------------------------------------------------

; Is this even used?
sub_rom_C284:
	jsr sub_fade_palettes_out
	bcc :+

		lda #$00
		sta PpuMask_2001
		sta zp_machine_state_0
		sta ram_067D
		sta ram_067C
		sta zp_game_substate
		lda #$1F	; Currently silenced
		sta ram_req_sfx
	:
	rts

; -----------------------------------------------------------------------------

sub_rom_C29E:
	ldy #$00
	sty zp_plr_idx_param
	jsr sub_rom_C2A8

	iny
	sty zp_plr_idx_param

; -----------------------------------------------------------------------------

sub_rom_C2A8:
	;lda zp_4C,Y
	;bpl @C2C4

	;cmp #$F0
	;bcs @C2BF

	;lda #$03
	;and zp_frame_counter
	;bne @C2C4

	;ldx zp_4C,Y
	;inx
	;stx zp_4C,Y
	;jmp @C2C4

	;@C2BF:
	;lda #$00
	;sta zp_4C,Y
	;@C2C4:
	lda #$1E
	cmp zp_plr1_cur_anim,Y

	beq @C2CC

		@C2CB_rts:
		rts
; ----------------
	@C2CC:
	lda zp_plr1_anim_frame,Y
	cmp #$05
	bcc @C2CB_rts
	bne @C2F0

	ldx zp_plr1_fgtr_idx_clean,Y
	lda zp_plr1_facing_dir,Y
	bne @C2E6

		lda zp_plr1_x_pos,Y
		clc
		adc @rom_C35F,X
		jmp @C2ED

	@C2E6:
	lda zp_plr1_x_pos,Y
	sec
	sbc @rom_C35F,X

	@C2ED:
	sta ram_ranged_atk_x_pos,Y

	@C2F0:
	lda ram_ranged_atk_x_pos,Y
	cmp #$E8
	bcs @C2FB

	cmp #$08
	bcs @C304

	@C2FB:
	lda #$00
	sta zp_plr1_cur_anim,Y
	sta zp_plr1_anim_frame,Y
	rts
; ----------------
	@C304:
	tya
	eor #$01
	tax
	lda zp_plr1_cur_anim,X
	bne @C310

	lda zp_plr1_anim_frame,X
	beq @C317

	@C310:
	cmp #$27
	beq @C317

		jsr sub_ranged_attack

	@C317:
	lda ram_ranged_atk_x_pos,Y
	sta zp_05
	lda zp_plr1_cur_anim,Y
	cmp #$0D
	bne @C327

	lda #$B4
	bne @C32C

	@C327:
	ldx zp_plr1_fgtr_idx_clean,Y
	lda zp_sprites_base_y
	sec
	sbc tbl_ranged_atk_spr_y,X
	;lda rom_C3BD,X
	@C32C:
	sta zp_06
	lda tbl_player_oam_offsets,Y
	sta zp_ptr1_lo
	clc
	adc #$0C
	tax
	lda zp_plr1_fgtr_idx_clean,Y
	asl A
	asl A
	tay
	@C33D:
		; Update sprites for the ranged attack
		jsr sub_ranged_sprites_update
		ldy zp_ptr2_lo
		tya
		iny
		and #$03
		cmp #$03
	bne @C33D

	jsr sub_ranged_special_oam
	lda #$FD		; -3 if shooting left
	ldy zp_plr_idx_param		; Attacker's index
	ldx zp_plr1_facing_dir,Y
	bne :+
		lda #$03	; +3 if shooting right
	:
	clc
	adc ram_ranged_atk_x_pos,Y
	sta ram_ranged_atk_x_pos,Y
	rts

; ----------------

	; These are added to ranged attack sprite's X position to make it move
	; (or subtracted, depending on direction)
	@rom_C35F:
	.byte $20	; Raiden
	.byte $18	; Sonya
	.byte $18	; Sub-Zero
	.byte $20	; Scorpion
	.byte $00	; Kano
	.byte $20	; Johnny Cage
	.byte $20	; Liu Kang
	.byte $28	; Goro
	.byte $28	; Shang-Tsung
	; Probably unused
	;.byte $20, $00, $18

; -----------------------------------------------------------------------------

; Parameters:
; X = offset of ranged attack sprites in OAM data
; Y = fighter index * 4 (for indexing)
sub_ranged_sprites_update:
	sty zp_ptr2_lo
	lda tbl_ranged_sprite_ids,Y
	bmi @C397

		ora zp_ptr1_lo
		sta ram_0371,X	; Sprite tile index
		lda zp_05
		sta ram_0373,X	; X position
		lda zp_06
		sta ram_0370,X	; Y position
		ldy zp_plr_idx_param
		lda zp_plr1_facing_dir,Y
		tay
		lda zp_plr_idx_param
		asl A
		cpy #$00
		beq :+
			ora #$40
		:
		sta ram_0372,X	; Attributes
		;dex
		;dex
		;dex
		;dex
		txa
		axs #$04

	@C397:
	ldy zp_plr_idx_param
	lda zp_ptr2_lo
	and #$01
	bne @C3B0

	lda zp_plr1_facing_dir,Y
	bne @C3A8

	lda #$08
	bne @C3AA

	@C3A8:
	lda #$F8
	@C3AA:
	clc
	adc zp_05
	sta zp_05
	rts
; ----------------
	@C3B0:
	lda ram_ranged_atk_x_pos,Y
	sta zp_05
	lda zp_06
	clc
	adc #$08
	sta zp_06
	rts

; -----------------------------------------------------------------------------

; Relative Y coordinate for ranged attack sprite
tbl_ranged_atk_spr_y:
	.byte $DA-$9C	; Raiden
	.byte $DA-$98	; Sonya
	.byte $DA-$9C	; Sub-Zero
	.byte $DA-$90	; Scorpion
	.byte $DA-$9C	; Kano
	.byte $DA-$9C	; Johnny Cage
	.byte $DA-$9C	; Liu Kang
	.byte $DA-$9C	; Goro
	.byte $DA-$A1	; Shang-Tsung

; -----------------------------------------------------------------------------

; Tile indices for ranged attacks - up to 4 sprites per attack
tbl_ranged_sprite_ids:
	.byte $7A, $7B, $72, $73	; Raiden
	.byte $77, $78, $79, $7A	; Sonya
	.byte $6F, $70, $71, $72	; Sub-Zero
	.byte $23, $24, $FF, $FF	; Scorpion
	.byte $74, $75, $7A, $FF	; Kano
	.byte $77, $78, $FF, $FF	; Johnny Cage
	.byte $67, $68, $FF, $FF	; Liu Kang
	.byte $75, $76, $FF, $FF	; Goro
	.byte $3E, $3F, $FF, $FF	; Shang-Tsung

; -----------------------------------------------------------------------------

; This is called when setting OAM data for the ranged attack sprite
; The only one that does somehing is Kano's, who seems to use more than
; four sprites
sub_ranged_special_oam:
	ldy zp_plr_idx_param
	lda zp_plr1_fgtr_idx_clean,Y
	jsr sub_game_trampoline
; ----------------
	.word sub_standard_ranged_oam	; Raiden
	.word sub_standard_ranged_oam	; Sonya
	.word sub_standard_ranged_oam	; Sub-Zero
	.word sub_scorpion_ranged_oam	; Scorpion
	.word sub_kano_ranged_oam		; Kano
	.word sub_standard_ranged_oam	; Johnny Cage
	.word sub_standard_ranged_oam	; Liu Kang
	.word sub_standard_ranged_oam	; Goro
	.word sub_standard_ranged_oam	; Shang-Tsung

; -----------------------------------------------------------------------------

sub_standard_ranged_oam:
	rts

; -----------------------------------------------------------------------------

sub_scorpion_ranged_oam:
	lda #$00
	ldy zp_plr_idx_param
	beq :+
		lda #$80
	:
	sta zp_ptr1_lo	; OR mask for kunai sprite tile index

	lda zp_frame_counter
	and #$04
	beq @scorpion_ranged_rts

		ldx tbl_player_oam_offsets,Y


		; Counter = ((Counter + 1) & 3) << 2
		inc zp_ranged_counter
		lda zp_ranged_counter
		and #$03
		sta zp_ranged_counter
		asl
		asl
		tay	; Y = 0-3 value from frame counter

		; Load tile ID from table
		lda @tbl_kunai_oam_data+0,Y
		ora zp_ptr1_lo
		sta ram_0378+1,X

		lda @tbl_kunai_oam_data+1,Y
		ora zp_ptr1_lo
		sta ram_037C+1,X
	
		iny
		iny

		stx zp_backup_x

		; Read a different X offset value depending on direction
		ldx zp_plr_idx_param
		lda zp_plr1_facing_dir,X
		bne :+
			iny	; Negative values (move left) if going right
		:

		ldx zp_backup_x

		lda ram_0378+3,X
		clc
		adc @tbl_kunai_oam_data,Y
		sta ram_0378+3,X

		lda ram_037C+3,X
		clc
		adc @tbl_kunai_oam_data,Y
		sta ram_037C+3,X

	@scorpion_ranged_rts:
	rts

; ----------------

	@tbl_kunai_oam_data:
	.byte $24, $23, $00, $00	; Frame 0
	.byte $22, $21, $10, $F0	; Frame 1
	.byte $20, $1F, $20, $E0	; Frame 2
	.byte $20, $1F, $20, $E0	; Frame 2

; -----------------------------------------------------------------------------

sub_kano_ranged_oam:
	ldy zp_plr_idx_param
	lda zp_frame_counter
	and #$04
	bne :+
		rts
; ----------------
	:
	ldx tbl_player_oam_offsets,Y
	
	; Move this half down

	lda ram_037C,X	; Sprite 3 Y
	clc
	adc #$08
	sta ram_037C,X

	lda ram_0378,X	; Sprite 2 Y
	clc
	adc #$08
	sta ram_0378,X

	; Move this half up

	lda ram_0374,X	; Sprite 1 Y
	sec
	sbc #$08
	sta ram_0374,X

	;lda ram_0370,X	; Sprite 0 Y
	;sec
	;sbc #$08
	;sta ram_0370,X

	lda zp_plr1_facing_dir,Y
	bne @C4EF

		; Right-facing
		lda #$10	; +16
		sta zp_16
		lda #$08	; +8
		bne @C4F5

	; Left-facing
	@C4EF:
	lda #$F0	; -16
	sta zp_16
	lda #$F8	; -8

	@C4F5:
	sta zp_ptr2_lo
	lda ram_037F,X	; Sprite 3 X
	clc
	adc zp_ptr2_lo
	clc
	adc zp_16		; +/- 24
	sta ram_037F,X

	lda ram_037B,X	; Sprite 2 X
	sec
	sbc zp_ptr2_lo
	clc
	adc zp_16		; +/- 8
	sta ram_037B,X

	lda ram_0377,X	; Sprite 1 X
	clc
	adc zp_ptr2_lo
	clc
	adc zp_16		; +/- 24
	sta ram_0377,X

	;lda ram_0373,X	; Sprite 0 X
	;sec
	;sbc zp_ptr2_lo
	;clc
	;adc zp_16		; +/- 8
	;sta ram_0373,X

	; Flip both horizontally and vertically

	;lda ram_0372,X	; Sprite 0 attributes
	;eor #$C0
	;sta ram_0372,X

	lda ram_0376,X	; Sprite 1 attributes
	eor #$C0
	sta ram_0376,X

	lda ram_037A,X	; Sprite 2 attributes
	eor #$C0
	sta ram_037A,X

	lda ram_037E,X	; Sprite 3 attributes
	eor #$C0
	sta ram_037E,X

	rts

; -----------------------------------------------------------------------------

; Returns the distance between the opponent player's hitbox and an active
; fireball sprite's hitbox (X only)
sub_calc_ranged_atk_distance:
	lda ram_ranged_atk_x_pos,Y
	cmp zp_plr1_x_pos,X
	bcs @C558

	lda zp_plr1_x_pos,X
	sec
	sbc ram_ranged_atk_x_pos,Y
	bne @C55B_rts

	@C558:
	sec
	sbc zp_plr1_x_pos,X

	@C55B_rts:
	rts

; -----------------------------------------------------------------------------

sub_rom_C572:
	lda zp_plr1_cur_anim,X
	cmp #$1E	; Ranged attack (opponent)
	bne @C581_special_1_check

	lda zp_plr1_cur_anim,Y
	cmp #$1E	; Ranged attack (attacker)
	beq @C58C_check_frame

	bne @C5A2_no_hit

	@C581_special_1_check:
	cmp #$0D	; Special 1 (opponent)
	bne @C5A2_no_hit

	lda zp_plr1_cur_anim,Y
	cmp #$0D	; Special 1 (attacker)
	bne @C5A2_no_hit

	@C58C_check_frame:
	lda zp_plr1_anim_frame,X
	cmp #$05
	bcc @C5A2_no_hit

	lda ram_ranged_atk_x_pos,X
	cmp ram_ranged_atk_x_pos,Y
	bcc @C5A4

	sec
	sbc ram_ranged_atk_x_pos,Y

	@C59E_ranged_dist_check:
	cmp #$08
	bcc @C5AD_hit

	@C5A2_no_hit:
	clc
	rts
; ----------------
	@C5A4:
	lda ram_ranged_atk_x_pos,Y
	sec
	sbc ram_ranged_atk_x_pos,X
	bne @C59E_ranged_dist_check
	
	@C5AD_hit:
	lda #$00
	sec
	rts

; -----------------------------------------------------------------------------

; Parameters:
; Y = index of player launching the attack (0 for player one, 1 for player two)
; NOTE: Does NOT return to caller if the attack hits. It pulls from the stack
;	to go back to caller's caller.
sub_ranged_attack:
	tya
	eor #$01	; Sets X = !Y (This might be unnecessary, because it was already
	tax			; 				done before the call)
	jsr sub_rom_C572
	bcc :+
		jmp @player_hit_anim
	:
	lda zp_sprites_base_y
	sec
	sbc #$21	; Hit box "height" = 33 pixels
	cmp zp_plr1_y_pos,X
	bcs @ranged_atk_return

	jsr sub_calc_ranged_atk_distance
	cmp #$10	; Hit box "width" = 16 pixels
	bcs @ranged_atk_return

	; Cheeck opponent's animation
	lda zp_plr1_cur_anim,X
	cmp #$01	; Crouching = no hit
	bne :+
		@ranged_atk_return:
		rts
	:
	cmp #$2B	; Already parried (crouching)
	beq @C60D_rts_x2

	cmp #$2C	; Already hit (recovering)
	beq @C60D_rts_x2

	cmp #$02	; Crouched parry
	beq @C5FF_crouch_parry

	cmp #$05	; Parry
	beq @C5FB_parry

	lda #$01	; Start the "hit" counter
	sta zp_counter_var_F1

	sty zp_backup_y
	lda zp_plr1_fgtr_idx_clean,Y
	tay
	lda @tbl_ranged_hit_damage,Y
	sta zp_plr1_dmg_counter,X	; Opponent
	ldy zp_backup_y
	lda #$03
	sta zp_gained_score_idx,Y	; Attacker

	; Scorpion's spear
	lda zp_plr1_fgtr_idx_clean,Y
	cmp #$03
	bne :+
		; Put the opponents on the ground in case they were jumping
		lda zp_sprites_base_y
		sta zp_plr1_y_pos,X
		; Special hit animation for the opponent
		lda #$33
		bne @player_hit_anim
	:
	; Other special ranged attacks (Sub-Zero)
	cmp #$02
	bne @check_airborne_hit

		lda #$00
		sta zp_plr1_cur_anim,Y
		sta zp_plr1_anim_frame,Y

		lda zp_frozen_timer,X
		beq :+
			; Already frozen: Double Freeze!

			; First, thaw the opponent
			lda #$00
			sta zp_frozen_timer,X
			inc zp_thaw_flag,X

			; Then, freeze the attacker
			tya
			tax
		:

		lda #$20
		sta zp_frozen_timer,X

		jsr sub_frozen_palette

		jmp @C60D_rts_x2

	@check_airborne_hit:
	; Check if a player was hit whilst airborne
	lda zp_plr1_y_pos,X
	cmp zp_sprites_base_y
	bne @C5F7_hit

	lda #$30	; Airborne hit
	bne @player_hit_anim

	@C5F7_hit:
	lda #$2E	; Strong hit knockback
	bne @player_hit_anim

	@C5FB_parry:
	lda #$2C	; Standing parry knockback
	bne @player_hit_anim

	@C5FF_crouch_parry:
	lda #$2B	; Crouched parry knockback

	@player_hit_anim:
	sta zp_plr1_cur_anim,X		; Opponent
	lda #$00
	sta zp_plr1_anim_frame,X
	
	sta zp_plr1_anim_frame,Y	; Attacker
	ldx zp_plr1_fgtr_idx_clean,Y
	cpx #$03
	bne :+
		lda #$2F	; Special pull animation for Scorpion
	:
	sta zp_plr1_cur_anim,Y	; Attacker

	@C60D_rts_x2:
	pla
	pla
	rts

	@tbl_ranged_hit_damage:
	.byte $08	; Raiden
	.byte $08	; Sonya
	.byte $01	; Sub-Zero
	.byte $02	; Scorpion
	.byte $08	; Kano
	.byte $08	; Johnny Cage
	.byte $08	; Liu Kang
	.byte $09	; Goro
	.byte $09	; Shang-Tsung

; -----------------------------------------------------------------------------

; Displays zero on the score above the health bars for both players
sub_clear_score_display:
	lda #$20
	sta zp_nmi_ppu_ptr_hi
	lda #$44
	sta zp_nmi_ppu_ptr_lo
	lda #$01
	sta zp_nmi_ppu_rows
	ldx #$0F
	ldx #$18
	stx zp_nmi_ppu_cols

	ldy #$00
	@C689:
		lda tbl_score_zero,Y
		sta ram_ppu_data_buffer,Y
	iny
	cpy #$1A
	bcc @C689

	rts

; -----------------------------------------------------------------------------
.export sub_rom_C69C

sub_rom_C695:
	lda zp_counter_var_F1
	cmp #$02
	beq sub_rom_C69C
		rts
; ----------------
sub_rom_C69C:
	jsr sub_clear_score_display
	ldy #$00
	sty zp_plr_idx_param
	ldx #$00
	stx zp_plr_ofs_param
	jsr sub_rom_C6BB
	lda ram_game_mode_initialised
	beq sub_rom_C6BA

		inc zp_plr_idx_param
		ldy zp_plr_idx_param
		ldx #$03
		stx zp_plr_ofs_param
		jmp sub_rom_C6BB ;jsr sub_rom_C6BB
	
sub_rom_C6BA:
	rts

; -----------------------------------------------------------------------------

sub_rom_C6BB:
	lda zp_gained_score_idx,Y
	asl A
	tax
	lda rom_C760+0,X
	sta zp_05
	lda rom_C760+1,X
	sta zp_06
	
	ldx zp_plr_ofs_param
; ----------------
sub_update_score_display:
	clc
	lda ram_plr1_score_lo,X
	adc zp_05
	sta ram_plr1_score_lo,X
	lda ram_plr1_score_mid,X
	adc zp_06
	sta ram_plr1_score_mid,X
	bcc sub_rom_C6E2

		inc ram_plr1_score_hi,X
; ----------------
sub_rom_C6E2:
	lda ram_plr1_score_lo,X
	sta zp_07
	lda ram_plr1_score_mid,X
	sta zp_var_x
	lda ram_plr1_score_hi,X
	sta zp_x_counter
	lda #$B0
	sta zp_0D

	jsr sub_rom_CD56

	ldy zp_plr_idx_param
	ldx rom_C76A,Y
	ldy #$04

	@C6FF:
	lda ram_066D,Y
	sta ram_ppu_data_buffer,X
	inx
	dey
	bpl @C6FF

	ldy zp_plr_idx_param
	ldx rom_C76A,Y
	jsr sub_rom_C789
	ldx zp_plr_ofs_param
	txa
	eor #$03
	tay
	lda ram_plr1_score_hi,Y
	cmp ram_plr1_score_hi,X
	bcc @C733
	bne @C75F

	lda ram_plr1_score_mid,Y
	cmp ram_plr1_score_mid,X
	bcc @C733
	bne @C75F

	lda ram_plr1_score_lo,Y
	cmp ram_plr1_score_lo,X
	bcs @C75F

	@C733:
	lda ram_plr1_score_hi,X
	cmp ram_040B
	bcc @C75F

	lda ram_plr1_score_mid,X
	cmp ram_040A
	bcc @C75F

	bne @C74D

	lda ram_0409
	cmp ram_plr1_score_lo,X
	bcs @C75F

	@C74D:
	lda ram_plr1_score_lo,X
	sta ram_0409
	lda ram_plr1_score_mid,X
	sta ram_040A
	lda ram_plr1_score_hi,X
	sta ram_040B

	@C75F:
	rts

; -----------------------------------------------------------------------------

rom_C760:
	.byte $00, $00, $23, $00, $2D, $00, $37, $00
	.byte $96, $00

; -----------------------------------------------------------------------------

rom_C76A:
	.byte $00, $12

; -----------------------------------------------------------------------------

tbl_score_zero:
	.byte $FF, $FF, $FF, $FF, $FF, $B0, $FF, $FF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $B0
	.byte $FF, $FF, $FF, $FF, $FF

; -----------------------------------------------------------------------------

sub_rom_C789:
	ldy #$05
	@C78B:
	lda ram_ppu_data_buffer,X
	cmp #$B0
	bne @C79B

	lda #$FF
	sta ram_ppu_data_buffer,X
	inx
	dey
	bne @C78B

	@C79B:
	rts

; -----------------------------------------------------------------------------

; Acts as a counter from 15 to 0, after which the machine state returns to
; the main match loop
sub_match_hit_loop:
	lda zp_counter_var_F1
	cmp #$0F
	bcc :+

		lda #$00
		sta zp_gained_score_idx+0	; Player one
		sta zp_gained_score_idx+1	; Player two
		sta zp_counter_var_F1	; Stop the "hit" counter
		dec zp_game_substate	; Back to match main loop
		rts
; ----------------
	:
	inc zp_counter_var_F1
	rts

; -----------------------------------------------------------------------------

sub_check_special_move:
	lda #$58	; Max damage
	cmp zp_plr1_damage
	beq @C7BA_rts

		; Skip if fighter is dead

		cmp zp_plr2_damage
		bne @C7BB

			@C7BA_rts:
			rts
; ----------------
	@C7BB:
	ldx #$00
	stx zp_plr_idx_param
	jsr sub_inner_check_special_move

	inc zp_plr_idx_param
	ldx zp_plr_idx_param
; ----------------
sub_inner_check_special_move:
	lda zp_plr1_cur_anim,X
	cmp #$28
	beq @C800_rts

	lda zp_frozen_timer,X
	bne @C800_rts

		; Index = fighter id * 3
		lda zp_plr1_fgtr_idx_clean,X
		asl A
		clc
		adc zp_plr1_fgtr_idx_clean,X
		tay
		sty ram_0422
		lda @special_move_ctrl_ofs,Y
		bmi :+
			sta ram_043D
			jsr sub_check_input_special_1
		:
		ldy ram_0422
		iny
		lda @special_move_ctrl_ofs,Y
		bmi :+
			sta ram_043D
			jsr sub_check_input_ranged_atk
		:
		ldy ram_0422
		iny
		iny
		lda @special_move_ctrl_ofs,Y
		bmi @C800_rts

			sta ram_043D
			jmp sub_check_input_special_2 ;jsr sub_rom_C833

	@C800_rts:
	rts

; ----------------

	; Indices used for tbl_ctrl_move_ptrs
	@special_move_ctrl_ofs:
	.byte $00, $01, $02	; Raiden
	.byte $03, $04, $05	; Sonya
	.byte $06, $07, $08	; Sub-Zero
	.byte $09, $0A, $0B	; Scorpion
	.byte $0C, $0D, $0E	; Kano
	.byte $0F, $10, $11	; Johnny Cage
	.byte $12, $13, $14	; Liu Kang
	.byte $FF, $16, $FF	; Goro
	.byte $FF, $19, $FF	; Shang-Tsung

; -----------------------------------------------------------------------------

sub_check_input_special_1:
	lda #$0D	; Special move 1
	sta ram_special_atk_idx
	bne sub_inner_check_input_special
; ----------------
sub_check_input_ranged_atk:
	lda #$1E	; Ranged attack
	sta ram_special_atk_idx
	bne sub_inner_check_input_special
; ----------------
sub_check_input_special_2:
	lda #$17	; Special move 2
	sta ram_special_atk_idx
; ----------------
sub_inner_check_input_special:
	ldx zp_plr_idx_param
	lda zp_plr1_y_pos,X
	cmp zp_sprites_base_y
	bne @C875_rts

		; This would prevent a combo that starts with button down for Raiden's first special
		;lda ram_043D
		;bne :+
		;	lda zp_controller1,X
		;	and #$04	; Button down?
		;	bne @C875_rts
		;:

		jsr sub_check_special_key_combo
		; The previous call will only return here if a special key combo was completed
		; Otherwise, it will pull from the stack and return to the previous caller
		ldy zp_plr_idx_param
		lda ram_special_atk_idx
		cmp #$1E	; Ranged attack
		;bne @C86A_assign_anim

		;lda zp_4C,Y
		;bmi @C875_rts

		;ldx zp_4C,Y
		;inx
		;stx zp_4C,Y
		;cpx #$02
		;bcc @C86A_assign_anim

		;	lda #$80
		;	sta zp_4C,Y
		;@C86A_assign_anim:
		lda ram_special_atk_idx
		cmp zp_plr1_cur_anim,Y
		beq @C875_rts	; Avoid resetting the animation if it had already started

			jmp sub_change_fighter_anim ;jsr sub_change_fighter_anim

	@C875_rts:
	rts

; -----------------------------------------------------------------------------

sub_check_special_key_combo:
	; Prepare pointer to the key combo of the move we want to check
	lda ram_043D
	asl A
	tay
	lda tbl_ctrl_move_ptrs+0,Y
	sta zp_ptr3_lo
	lda tbl_ctrl_move_ptrs+1,Y
	sta zp_ptr3_hi

	ldx ram_043D
	lda @rom_C8D5,X
	clc
	adc zp_plr_idx_param
	tax
	stx zp_plr_ofs_param	; Offset to key combo pointer (0, 2 or 4 since we have three special moves)

	lda zp_key_combo_hits,X
	sta zp_ptr1_lo
	inc zp_ptr1_lo	; Index of the next byte to read in key combo

	ldx zp_plr_idx_param
	lda zp_plr1_facing_dir,X
	tay
	lda zp_controller1_new,X
	beq @C8BC_rts_x2

		cpy #$00	; Facing right, no need to flip controls
		beq @C8B0

		and #$03	; Left/right bit mask
		bne @C8AC

		lda zp_controller1_new,X
		bne @C8B0	; Always branches

		@C8AC:
		lda zp_controller1_new,X
		eor #$03	; Flip left/right bits

		@C8B0:
		ldy zp_ptr1_lo
		ldx zp_plr_ofs_param
		cmp (zp_ptr3_lo),Y
		beq @C8C2

		lda #$00
		sta zp_key_combo_hits,X
	@C8BC_rts_x2:
	jsr sub_rom_C8F9
	pla
	pla
	rts
; ----------------
	@C8C2:
	; Increment the number of matches found for this key combo
	inc zp_key_combo_hits,X

	lda #$00
	sta zp_BD,X

	; Check if we have read the last value in the combo
	lda zp_key_combo_hits,X
	ldy #$00	; Byte 0 = number of key presses in this combo
	cmp (zp_ptr3_lo),Y
	bcc @C8BC_rts_x2

	lda #$00
	sta zp_key_combo_hits,X
	rts

; ----------------

	; Everyone has the same offsets relative to the start of that player's pointers
	; That is beacause every player has exactly three special moves
	@rom_C8D5:
	.byte $00, $02, $04
	.byte $00, $02, $04
	.byte $00, $02, $04
	.byte $00, $02, $04
	.byte $00, $02, $04
	.byte $00, $02, $04
	.byte $00, $02, $04
	.byte $00, $02, $04
	.byte $00, $02, $04

; -----------------------------------------------------------------------------

sub_rom_C8F9:
	ldx zp_plr_ofs_param
	lda zp_BD,X
	cmp #$0F
	bcc @C911

		lda #$00
		sta zp_BD,X
		lda zp_key_combo_hits,X
		cmp zp_D1,X
		bne :+
			lda #$00
			sta zp_key_combo_hits,X
		:
		sta zp_D1,X

	@C911:
	inc zp_BD,X
	rts

; -----------------------------------------------------------------------------

tbl_ctrl_move_ptrs:
	; $00 Raiden
	.word tbl_move_raiden_teleport
	.word tbl_move_lightning
	.word tbl_move_raiden_torpedo
	
	; $01 Sonya
	.word tbl_move_sonya_kick
	.word tbl_move_ring_toss
	.word tbl_move_square_flight

	; $02 Sub-Zero
	.word tbl_move_subzero_punch
	.word tbl_move_lightning
	.word tbl_move_slide

	; Scorpion
	.word tbl_move_scorpion_punch
	.word tbl_move_scorpion_spear
	.word tbl_move_scorpion_teleport

	; Kano
	.word tbl_move_scorpion_punch
	.word tbl_move_kano_knife
	.word tbl_move_kano_spin

	; Johnny Cage
	.word tbl_move_cage_kick
	.word tbl_move_green_bolt
	.word tbl_move_shadow_kick

	; Liu Kang
	.word tbl_move_liukang_kick
	.word tbl_move_fireball
	.word tbl_move_flying_kick

	; Goro
	.word rom_C9B6
	.word tbl_move_lightning
	.word rom_C9BE

	; Shang-Tsung
	.word rom_C9C2
	.word tbl_move_lightning
	.word rom_C9CA

; Data format: number of inputs, controller masks for each input

; ----------------

; Raiden

; Teleport (Dn, Up)
tbl_move_raiden_teleport:
	.byte $02
	.byte $04, $08

; Lightning (Dn, Fwd, A)
tbl_move_lightning:
	.byte $03
	.byte $04, $01, $80

; Torpedo (Bck, Bck, Fwd)
tbl_move_raiden_torpedo:
	.byte $03
	.byte $02, $02, $01

; ----------------

; Sonya

; Roundhouse Kick (Dn, Bck, B)
tbl_move_sonya_kick:
	.byte $03
	.byte $04, $02, $40

; Ring Toss (Bck, Bck, A)
tbl_move_ring_toss:
	.byte $03
	.byte $80, $02, $80

; Square Flight (Fwd, Bck, A)
tbl_move_square_flight:
	.byte $03
	.byte $01, $02, $80

; ----------------

; Sub-Zero

; Turbo uppercut (Dn, Bck, B)
tbl_move_subzero_punch:
	.byte $03
	.byte $04, $02, $40

; Slide (Bck, A, B)
tbl_move_slide:
	.byte $03
	.byte $02, $80, $40

; ----------------

; Scorpion

; Turbo uppercut (Bck, Fwd, A)
tbl_move_scorpion_punch:
	.byte $03
	.byte $02, $01, $80

; Spear (Bck, Bck, A)
tbl_move_scorpion_spear:
	.byte $03
	.byte $02, $02, $80

; Teleport (Dn, Bck, A)
tbl_move_scorpion_teleport:
	.byte $03
	.byte $04, $02, $80

; ----------------

; Kano

; Knife throw (B, Bck, Fwd)
tbl_move_kano_knife:
	.byte $03
	.byte $40, $02, $01

; Spin attack (Fwd, Dn, Bck, Up)
tbl_move_kano_spin:
	.byte $04
	.byte $01, $04, $02, $08

; ----------------

; Johnny Cage

; "Turbo roundhouse kick" (A x 6)
tbl_move_cage_kick:
	.byte $06
	.byte $80, $80, $80, $80, $80, $80

; Green Bolt (Bck, Fwd, A)
tbl_move_green_bolt:
	.byte $03
	.byte $02, $01, $80

; Shadow kick (Bck, Fwd, B)
tbl_move_shadow_kick:
	.byte $03
	.byte $02, $01, $40

; ----------------

; Liu Kang

; Turbo kick (Dn, Fwd, B)
tbl_move_liukang_kick:
	.byte $03
	.byte $04, $01, $40

; Fireball (Fwd, Fwd, A)
tbl_move_fireball:
	.byte $03
	.byte $01, $01, $80

; Flying kick (Fwd, Fwd, B)
tbl_move_flying_kick:
	.byte $03
	.byte $01, $01, $40

; ----------------

; Goro

rom_C9B6:
	.byte $03
	.byte $02, $10, $80
;rom_C9BA:
;	.byte $03, $02, $01, $80
rom_C9BE:
	.byte $03
	.byte $02, $10, $80

; ----------------

; Shang-Tsung

rom_C9C2:
	.byte $03
	.byte $02, $10, $80
;rom_C9C6:
;	.byte $03, $02, $01, $80
rom_C9CA:
	.byte $03
	.byte $02, $10, $80

; -----------------------------------------------------------------------------

sub_rom_C9EC:
	ldy #$00
	jsr sub_rom_C9F2
	iny
; ----------------
sub_rom_C9F2:
	lda zp_plr1_cur_anim,Y
	cmp #$2A
	bne @CA04

	lda zp_plr1_fighter_idx,Y
	bpl @CA08

	lda #$00
	sta zp_4B
	beq @CA08

	@CA04:
	cmp #$29
	bne @CA18

	@CA08:
	lda zp_plr1_anim_frame,Y
	cmp #$05
	bcc @CA18

	lda #$01	; The match end state will use these to sync DPCM sample playback
	sta zp_counter_param
	lda #$00
	sta zp_short_counter

	lda #$05	; Match end state
	sta zp_game_substate
	jsr sub_rom_CA19
	pla
	pla
	@CA18:
	rts

; -----------------------------------------------------------------------------

sub_rom_CA19:
	lda zp_5E
	beq @CA26

	lda #$00
	sta zp_match_time
	sta zp_16bit_lo
	sta zp_16bit_hi
	rts
; ----------------
	@CA26:
	lda #$01
	sta zp_16bit_hi
	lda zp_match_time
	clc
	adc #$2C
	sta zp_16bit_lo
	bcc @CA35

	inc zp_16bit_hi
	@CA35:
	ldx zp_plr1_damage
	cpx zp_plr2_damage
	bcc @CA3D

	ldx zp_plr2_damage
	@CA3D:
	dex
	beq @CA4E

	lda zp_16bit_lo
	sec
	sbc #$01
	sta zp_16bit_lo
	bcs @CA4B

	dec zp_16bit_hi
	@CA4B:
	jmp @CA3D

	@CA4E:
	rts

; -----------------------------------------------------------------------------

; Changes a player's animation index and resets current frame to zero
; Saves player index in zp_8C
; Parameters:
; zp_7C = player index (0 for player one, 1 for player 2)
; A = new animation index
sub_change_fighter_anim:
	ldy zp_plr_idx_param
	sta zp_plr1_cur_anim,Y	; Set current animation index

	; Check if Scorpion is teleporting
	cmp #$17	; Teleport move index (special #2)
	bne :+
		lda zp_plr1_fgtr_idx_clean,Y
		cmp #$03	; Scorpion's index
		bne :+
			; Change facing direction to jump back
			lda zp_plr1_facing_dir,Y
			eor #$01
			sta zp_plr1_facing_dir,Y
	:

	; Start from frame zero
	lda #$00
	sta zp_plr1_anim_frame,Y

	; Remember the index of the last player whose animation was changed
	sty zp_last_anim_plr

	rts

; -----------------------------------------------------------------------------

sub_match_controller_input:
	ldy #$00
	sty zp_plr_idx_param
	jsr sub_inner_match_input

	iny
	sty zp_plr_idx_param
; ----------------
sub_inner_match_input:
	lda #$58
	cmp zp_plr1_damage
	beq @CA70_delay_y

	cmp zp_plr2_damage
	bne @CA7C_process_inputs

	@CA70_delay_y:
	ldy #$01

	@CA72_delay_x:
	ldx #$68
	:
		dex
	bne :-

	dey
	bne @CA72_delay_x
	beq @CA94

		@CA7C_process_inputs:
		jsr sub_left_right_walk_input
		jsr sub_standing_atk_buttons_input
		jsr sub_jumping_atk_buttons_input
		jsr sub_sidejump_atk_buttons_input
		jsr sub_crouching_input
		jsr sub_jump_button_input
		jsr sub_parry_button_input
		; jsr sub_check_apply_stunned

	@CA94:
	ldy zp_plr_idx_param
	jsr sub_check_apply_knockdown
	jmp sub_post_knockdown ;jsr sub_rom_CB7F
	;rts

; -----------------------------------------------------------------------------

sub_rom_CA9D:
	ldx #$00
	jsr sub_rom_CAA3

	inx
; ----------------
sub_rom_CAA3:
	lda zp_consecutive_hits_taken,X
	cmp #$03
	bcs @CABF_rts

		lda zp_plr1_cur_anim,X
		cmp #$09
		beq @CAB3

			cmp #$0A
			bne @CABF_rts

		@CAB3:
		lda zp_plr1_anim_frame,X
		cmp #$01
		bne @CABF_rts

			inc zp_consecutive_hits_taken,X
			lda #$00
			sta zp_E9,X

	@CABF_rts:
	rts

; -----------------------------------------------------------------------------

; Starts the "stunned" animation if needed (e.g. 3 consecutive hits)
;sub_check_apply_stunned:
;	ldy zp_plr_idx_param
;	lda zp_consecutive_hits_taken,Y
;	cmp #$03
;	bcc @CAE4

;	lda zp_plr1_cur_anim,Y
;	cmp #$27
;	bne @CAE4

;	lda zp_plr1_anim_frame,Y
;	cmp #$01
;	bne @CAE4

		; Staggered if getting up after enough hits taken

;		lda #$28	; Staggered animation
;		sta zp_plr1_cur_anim,Y

;		lda #$00
;		sta zp_consecutive_hits_taken,Y
;		sta zp_plr1_anim_frame,Y

;	@CAE4:
;	lda zp_E9,Y
;	cmp #$70
;	bcc @CB00

;		lda #$00
;		sta zp_E9,Y
;		lda zp_consecutive_hits_taken,Y
;		cmp zp_E7,Y
;		bne @CAFD

;			lda #$00
;			sta zp_consecutive_hits_taken,Y

;		@CAFD:
;		sta zp_E7,Y

;	@CB00:
;	isc a:zp_E9,Y
;	rts

; -----------------------------------------------------------------------------

tbl_player_oam_offsets:
	.byte $00	; Player 1 (starting at sprite $00)
	.byte $80	; Player 2 (starting at sprite $20 [32 decimal])

; -----------------------------------------------------------------------------

; Does something if animation is $2E, $31 or $32
sub_check_apply_knockdown:
	lda zp_plr1_cur_anim,Y
	cmp #$2E
	beq @CB1B

	; Return if < $30 and >= $33
	cmp #$30	
	bcc @fall_back_rts

	cmp #$33
	bcs @fall_back_rts

	@CB1B:
	; Only reached if animation is $2E, $31 or $32
	lda #$06
	cmp zp_plr1_anim_frame,Y
	bcs @fall_back_rts

	lda zp_sprites_base_y
	sec
	sbc #$22
	sta zp_ptr1_lo
	sec
	sbc #$38
	sta zp_ptr1_hi
	lda zp_plr1_y_pos,Y
	cmp zp_ptr1_lo
	bcs @CB5A

	cmp zp_ptr1_hi
	bcc @fall_back_rts

	lda zp_plr1_cur_anim,Y
	cmp #$32
	beq @CB5A
	
	lda zp_consecutive_hits_taken,Y
	cmp #$03
	bcs @CB5A

	lda zp_plr1_damage,Y
	cmp #$58
	bcs @CB5A

	; "Falling back" animation with safe landing
	; (this is the downward movement part of the backwards jump anim)
	lda #$34
	sta zp_plr1_cur_anim,Y
	lda #$0A
	sta zp_plr1_anim_frame,Y

	lda zp_ptr1_hi
	clc
	adc #$0C
	sta zp_plr1_y_pos,Y

	@fall_back_rts:
	rts
; ----------------
	@CB5A:
	lda zp_sprites_base_y
	sec
	sbc #$1A
	sta zp_ptr1_lo
	lda zp_plr1_y_pos,Y
	cmp zp_ptr1_lo
	bcc @CB7E_rts

		; Falling on their back after hit
		lda #$02
		sta zp_short_counter_target
		lda #$26	; Fall on back
		sta zp_plr1_cur_anim,Y
		lda #$00
		sta zp_plr1_anim_frame,Y
		lda zp_sprites_base_y
		clc
		adc #$08
		sta zp_plr1_y_pos,Y
	
	@CB7E_rts:
	rts

; -----------------------------------------------------------------------------

; After a knockout, either get up or end the match
sub_post_knockdown:
	lda zp_plr1_cur_anim,Y
	cmp #$26	 ; Knocked out
	bne @CBC6_rts

		lda zp_plr1_anim_frame,Y
		cmp #$0C
		bcc @CBC6_rts

		ldx zp_plr1_damage,Y
		cpx #$58
		bcc @CBB7

		lda #$0B
		sta zp_plr1_anim_frame,Y
		tya
		eor #$01
		tax
		lda zp_plr1_anim_frame,X
		bne @CBC6_rts

		lda #$2A	; Victory pose end
		sta zp_plr1_cur_anim,X
		lda zp_plr1_fgtr_idx_clean,X
		tay
		lda zp_sprites_base_y
		sta zp_plr1_y_pos,X
		lda zp_plr1_fighter_idx,X
		bmi @CBB3

		lda zp_4B
		bmi @CBB6_rts

		@CBB3:
		inc ram_plr1_rounds_won,X
		@CBB6_rts:
		rts
	; ----------------
		@CBB7:
		lda #$27		; Get up? Probably if the timer ran out and player was
		sta zp_plr1_cur_anim,Y	; knocked out, but with some health left

		lda #$00
		sta zp_plr1_anim_frame,Y

		lda zp_sprites_base_y
		sta zp_plr1_y_pos,Y

	@CBC6_rts:
	rts

; -----------------------------------------------------------------------------

; Punch/kick during animation 6 (straight jump up)
; Parameters:
; Y = 0 for player one, 1 for player two
sub_jumping_atk_buttons_input:
	lda zp_frozen_timer
	bne @CBFB_rts

	lda zp_plr1_cur_anim,Y
	cmp #$06	; Upwards jump
	bne @CBFB_rts

		ldx #$0E	; Animation $0E = upwards jump kick

		lda zp_controller1_new,Y
		and #$40
		beq @CBDE


		lda #$07	; Kick swing
		sta ram_req_sfx
		bne @CBED

		@CBDE:
		lda zp_controller1_new,Y
		and #$80
		beq @CBFB_rts


		lda #$08	; Punch swing
		sta ram_req_sfx
		inx
		inx
		inx	; Animation $11 = jumping punch
		@CBED:
		lda zp_plr1_anim_frame,Y
		cmp #$07
		bcc :+
			inx	; Animation $12 = another jumping punch
		:
		txa
		sta zp_plr1_cur_anim,Y
		sty zp_last_anim_plr
	@CBFB_rts:
	rts

; -----------------------------------------------------------------------------

; Punch/kick during animation 7 or 8 (forward or backwards jump)
; Parameters:
; Y = 0 for player one, 1 for player 2
sub_sidejump_atk_buttons_input:
	lda zp_frozen_timer,Y
	bne @CC35_rts

	ldx #$19
	lda zp_plr1_cur_anim,Y
	cmp #$07
	beq @CC0B

	cmp #$08
	bne @CC35_rts

		ldx #$1F
		@CC0B:
		lda zp_controller1_new,Y
		and #$80
		beq @CC19

		lda #$08	; Punch swing
		sta ram_req_sfx
		bne @CC27

		@CC19:
		lda zp_controller1_new,Y
		and #$40
		beq @CC35_rts


		lda #$07	; Kick swing
		sta ram_req_sfx
		inx
		inx
		@CC27:
		lda zp_plr1_anim_frame,Y
		cmp #$07
		bcc :+
			inx
		:
		txa
		sta zp_plr1_cur_anim,Y
		sty zp_last_anim_plr

	@CC35_rts:
	rts

; -----------------------------------------------------------------------------

; Inputs that would make the player perform a standing attack
sub_standing_atk_buttons_input:
	lda zp_frozen_timer
	bne @CC5B_rts

	jsr sub_check_is_moving

	lda zp_controller1,Y
	and #$04	; D-pad down
	bne @CC5B_rts

		lda zp_controller1_new,Y
		and #$40	; Button B
		beq @CC4F

			jsr sub_sel_kick_type
			@CC4A:
			txa
			jmp sub_change_fighter_anim ;jsr sub_change_fighter_anim
			;rts
	; ----------------
		@CC4F:
		lda zp_controller1_new,Y
		and #$80	; Button A
		beq @CC5B_rts

		jsr sub_sel_punch_type
		bne @CC4A

	@CC5B_rts:
	rts

; -----------------------------------------------------------------------------

; Selects basic punch, close up punch or throw depending on X distance
; Returns:
; X = selected animation index
sub_sel_punch_type:
	lda zp_players_x_distance
	cmp #$1E
	bcs @CC7F_normal_punch

	lda #$01
	ldx zp_plr1_facing_dir,Y
	beq :+
		lda #$02
	:
	and zp_controller1,Y
	beq @CC7C_quick_punch

	tya
	eor #$01
	tax
	lda zp_plr1_y_pos,X
	cmp zp_sprites_base_y
	bne @CC7C_quick_punch

	lda zp_plr1_facing_dir,Y
	eor #$01
	sta zp_plr1_facing_dir,Y
	ldx #$18	; Throw
	rts
; ----------------
	@CC7C_quick_punch:
	ldx #$25	; Up close punch
	rts
; ----------------
	@CC7F_normal_punch:
	ldx #$10	; Basic punch
	rts

; -----------------------------------------------------------------------------

; Selects regular or up-close kick animation based on X distance
; Returns:
; X = selected animation index
sub_sel_kick_type:
	lda zp_players_x_distance
	cmp #$30
	bcs @CC97_ret_0B

		lda #$1B
		;ldx zp_plr1_fgtr_idx_clean,Y	Pointless, it compares with $1B anyway
		;bne @CC90

		;	lda #$1B
		;@CC90:
		cmp zp_players_x_distance
		bcc @CC97_ret_0B

			ldx #$0C	; Close up kick
			rts
; ----------------
	@CC97_ret_0B:
	ldx #$0B	; Base kick
	rts

; -----------------------------------------------------------------------------

sub_short_counter_tick:
	lda zp_short_counter
	cmp zp_short_counter_target
	bcc :+
		lda #$00
		sta zp_short_counter
		rts
; ----------------
	:
	inc zp_short_counter
	rts

; -----------------------------------------------------------------------------

; This was pointless
;sub_rom_CCA8:
;	jsr sub_rom_CD19
;	rts

; -----------------------------------------------------------------------------

sub_request_hit_sound:
	lda zp_counter_var_F1
	beq @CCC2_rts

	cmp #$01
	bcc @CCC0

		ldx #$01	; X will be the index of the target for special attacks
		ldy #$00	; Y will be the index of the attacker for special attacks
		@special_hit_check:
		lda zp_plr1_cur_anim,X
		cmp #$33	; Special hit animation
		beq @ranged_hit
		iny
		dex
		bpl @special_hit_check
		bmi @regular_hit

			@ranged_hit:
			ldx zp_plr1_fgtr_idx_clean,Y
			lda @tbl_special_hit_sfx,X
			bne @request_hit_sfx

		@regular_hit:
		lda #$02	; Hit SFX
		@request_hit_sfx:
		sta ram_req_sfx

		lda #$00
		sta zp_counter_var_F1
		inc zp_game_substate
		rts
; ----------------
	@CCC0:
	inc zp_counter_var_F1
	@CCC2_rts:
	rts

; ----------------
	@tbl_special_hit_sfx:
	.byte $02	; Raiden
	.byte $02	; Sonya
	.byte $02	; Sub-Zero
	.byte $1B	; Scorpion
	.byte $02	; Kano
	.byte $02	; Johnny Cage
	.byte $02	; Liu Kang
	.byte $02	; Goro
	.byte $02	; Shang-Tsung

; -----------------------------------------------------------------------------

sub_upd_anim_and_timer:
	jsr sub_match_end_animations

	; Check if one the players has zero health (i.e. max damage)
	lda #$58
	cmp zp_plr1_damage
	beq sub_update_match_time
	cmp zp_plr2_damage
	beq sub_update_match_time

	; Increase round number?
	inc zp_A2
	lda zp_A2
	cmp #$2D
	bcc sub_update_match_time

	lda #$00
	sta zp_A2
	dec zp_match_time
; ----------------
sub_update_match_time:
	lda zp_match_time
	sta zp_07

	lda #$00
	sta zp_var_x
	sta zp_x_counter
	sta zp_0D

	jsr sub_rom_D6C7

	lda ram_066E
	clc
	adc #$B0
	sta ram_match_time_tens
	lda ram_066D
	clc
	adc #$B0
	sta ram_match_timer_units

	rts

; -----------------------------------------------------------------------------

sub_rom_CD56:
	lda zp_x_counter
	cmp #$01
	bcc @CD7D

	lda zp_var_x
	cmp #$86
	bcc @CD7D

	lda zp_07
	cmp #$9F
	bcc @CD7D

	lda #$01
	sta zp_07
	sta ram_plr1_score_lo,X
	lda #$86
	sta zp_var_x
	sta ram_plr1_score_mid,X
	lda #$9F
	sta zp_x_counter
	sta ram_plr1_score_hi,X
	@CD7D:
	jmp sub_rom_D6C7;jsr sub_rom_D6C7
	;rts

; -----------------------------------------------------------------------------

; Returns to caller's caller (pulling from the stack) if this was already
; executed this round, or if a player is airborne
; Does nothing if the match ended because the time ran out
; Otherwise, change players animations to victory/shame poses as needed
sub_match_end_animations:
	lda ram_0411
	bne @CDD2_rts_back_2

	lda zp_match_time
	bne @CDD4_rts

		lda zp_sprites_base_y
		cmp zp_plr1_y_pos
		bne @CDD2_rts_back_2

		cmp zp_plr2_y_pos
		bne @CDD2_rts_back_2

		lda zp_plr1_damage
		cmp zp_plr2_damage
		bcc @CDA5_victory

		bne @CDB7_shame

		lda #$29
		sta zp_plr1_cur_anim
		sta zp_plr2_cur_anim
		jmp @CDC7_frame_reset

		@CDA5_victory:
		ldx zp_plr1_fgtr_idx_clean
		lda zp_sprites_base_y
		sta zp_plr1_y_pos
		ldx #$2A
		stx zp_plr1_cur_anim
		dex
		stx zp_plr2_cur_anim
		inc ram_plr1_rounds_won
		bne @CDC7_frame_reset

			@CDB7_shame:
			ldx zp_plr2_fgtr_idx_clean
			lda zp_sprites_base_y
			sta zp_plr2_y_pos
			ldx #$29
			stx zp_plr1_cur_anim
			inx
			stx zp_plr2_cur_anim
			inc ram_plr2_rounds_won

		@CDC7_frame_reset:
		lda #$00
		sta zp_plr1_anim_frame
		sta zp_plr2_anim_frame
		lda #$01
		sta ram_0411

	@CDD2_rts_back_2:
	pla
	pla
	@CDD4_rts:
	rts

; -----------------------------------------------------------------------------

sub_calc_players_distance:
	lda zp_plr1_x_pos
	cmp zp_plr2_x_pos
	bcs @CF2C
		; Player 2 to the right
		lda zp_plr2_x_pos
		sec
		sbc zp_plr1_x_pos
	bne @CF2F

	@CF2C:
		; Player 1 to the right
		sec
		sbc zp_plr2_x_pos
	@CF2F:
	sta zp_players_x_distance

	ldx #$00
	lda zp_plr1_y_pos
	cmp zp_plr2_y_pos
	bcs @CF40

	lda zp_plr2_y_pos
	sec
	sbc zp_plr1_y_pos
	bne @CF44
	
	@CF40:
	inx
	sec
	sbc zp_plr2_y_pos

	@CF44:
	sta zp_players_y_distance
	stx zp_y_plane_skew
	;lda #$1C
	;sta ram_067E
	rts

; -----------------------------------------------------------------------------
.export sub_finish_match_init

sub_finish_match_init:
	jsr sub_load_game_palettes

	; Make sure sprite BG colour does not overwrite patterns BG colour
	; This is to allow stages with backgrounds other than black (e.g. the Pit)
	lda ram_0640+0
	sta ram_0640+$10

	lda #$02
	sta zp_short_counter_target
	lda #$01
	sta zp_48

	lda #$00
	sta zp_49
	sta zp_A2
	sta zp_match_time
	sta zp_plr1_cur_anim
	sta zp_plr2_cur_anim
	sta zp_plr1_anim_frame
	sta zp_plr2_anim_frame
	sta zp_plr1_x_hi
	sta zp_plr2_x_hi
	sta zp_plr1_facing_dir
	sta zp_plr1_damage
	sta zp_plr2_damage
	sta zp_plr1_dmg_counter
	sta zp_plr2_dmg_counter
	sta zp_frozen_timer+0
	sta zp_frozen_timer+1
	sta zp_thaw_flag+0
	sta zp_thaw_flag+1
	sta zp_consecutive_hits_taken
	sta zp_E6
	sta zp_7F
	sta ram_0411
	sta zp_4C
	sta zp_4D

	lda #$40
	sta zp_irq_hor_scroll
	sta ram_0414

	; "Flip" player 2
	lda #$01
	sta zp_plr2_facing_dir

	lda #$90
	sta zp_plr1_x_lo

	lda #$F0
	sta zp_plr2_x_lo
	
	lda zp_sprites_base_y
	sta zp_plr1_y_pos
	sta zp_plr2_y_pos
	sta zp_F4
	sta zp_F5

	lda #$00
	tax
	:
		sta zp_key_combo_hits,X
	inx
	cpx #$3C
	bcc :-

	jsr sub_rebase_fighter_indices
	jsr sub_move_fighter_sprites
	jsr sub_rom_D20A
	
	; Put bank 0 back in after loading sprite data
	lda #$86
	sta mmc3_bank_select
	sta zp_bank_select_value
	lda #$00
	sta mmc3_bank_data
	
	rts

; -----------------------------------------------------------------------------

sub_load_game_palettes:
	ldx #$D8
	stx zp_34
	inx
	inx
	stx zp_35

	; The stage index is in the general pointer idx variable
	lda ram_irq_routine_idx ;ldy ram_routine_pointer_idx
	;tya
	asl A
	tay
	lda tbl_bg_palette_ptrs+0,Y
	sta zp_ptr1_lo
	lda tbl_bg_palette_ptrs+1,Y
	sta zp_ptr1_hi

	ldy #$00
	ldx #$00
	:
		lda (zp_ptr1_lo),Y
		sta ram_0640,X
	inx
	iny
	cpy #$10
	bcc :-

	ldx #$10
	lda zp_plr1_fgtr_idx_clean	; Player 1 chosen fighter index
	jsr sub_read_fighter_palette
	;ldx #$18	; This shouldn't be necessary
	lda zp_plr2_fgtr_idx_clean	; Player 2 chosen fighter index
; ----------------
sub_read_fighter_palette:
	asl A
	tay
	lda tbl_fighter_palette_ptrs+0,Y
	sta zp_ptr1_lo
	lda tbl_fighter_palette_ptrs+1,Y
	sta zp_ptr1_hi

	ldy #$00
	:
		lda (zp_ptr1_lo),Y
		sta ram_0640,X
	inx
	iny
	cpy #$08
	bcc :-

	rts

; -----------------------------------------------------------------------------

sub_adjust_facing:
	lda zp_plr1_cur_anim
	cmp #$06
	bcc @D045_plr1

	cmp #$26
	bcc @D055_plr2

	cmp #$2D
	beq @D055_plr2

	cmp #$2E
	beq @D055_plr2

	cmp #$31
	beq @D055_plr2

	; Can't be $18 here: we already skipped if it was < $26
	;cmp #$18	; Player 1: Throw move
	;beq @D055_plr2

	@D045_plr1:
	ldx #$00
	
	; This basically only affects the Carry bit
	sec
	lda zp_plr1_x_lo
	sbc zp_plr2_x_lo

	lda zp_plr1_x_hi
	sbc zp_plr2_x_hi
	bmi :+
		; Change facing if players is on the other side
		inx
	:
	stx zp_plr1_facing_dir
	@D055_plr2:
	lda zp_plr2_cur_anim
	cmp #$06	; Upwards jump
	bcc @D06B_facing_dir

	cmp #$26
	bcc @D07B_rts

	cmp #$2D
	beq @D07B_rts

	cmp #$2E
	beq @D07B_rts

	cmp #$31
	beq @D07B_rts

	; Can't be $18 here: we already skipped if it was < $26
	;cmp #$18	; Player 2: Throw move
	;beq @D07B_rts
	
	; Change facing dir if needed
	@D06B_facing_dir:
	ldx #$00
	sec
	lda zp_plr1_x_lo
	sbc zp_plr2_x_lo
	lda zp_plr1_x_hi
	sbc zp_plr2_x_hi
	bpl :+
		inx
	:
	stx zp_plr2_facing_dir
	@D07B_rts:
	rts

; -----------------------------------------------------------------------------

; Aborts setting X scroll if in the middle of a throw move
sub_should_avoid_scroll:
	ldy #$00
	jsr sub_check_throw_move
	iny
; ----------------
sub_check_throw_move:
	lda zp_plr1_fgtr_idx_clean,Y
	beq @D08B

	cmp #$04
	bne @D09D_clean_rts

		@D08B:
		lda zp_plr1_cur_anim,Y
		cmp #$18	; Throw move
		bne @D09D_clean_rts

		lda zp_plr1_anim_frame,Y
		cmp #$0A
		bcs @D09D_clean_rts

			pla
			pla
			sec
			rts
; ----------------
	@D09D_clean_rts:
	clc
	rts

; -----------------------------------------------------------------------------

sub_set_irq_x_scroll:
	jsr sub_should_avoid_scroll
	; TODO is the check needed?
	; The sub pulls from the stack to return to caller when setting carry
	;bcs @D0C4_rts

	;	clc
		lda zp_plr1_x_lo
		adc zp_plr2_x_lo
		sta zp_ptr1_lo

		lda zp_plr1_x_hi
		adc zp_plr2_x_hi
		sta zp_ptr1_hi

		lsr zp_ptr1_hi
		ror zp_ptr1_lo
		lda zp_ptr1_lo

		sec
		sbc #$80
		
		bcs :+
			dec zp_ptr1_hi
		:

		; A = ((Player 1 X + Player 2 X) / 2) - 128

		;ldx ram_irq_routine_idx
		;cmp @tbl_max_x_scroll,X
		;bcs @D0C4_rts
		;	sta zp_irq_hor_scroll

		cmp #$68
		bcc @set_scroll_value
			lda #$68

			ldx zp_ptr1_hi
			bpl :+	; Don't scroll all the way to the right if going left
				lda #$00
				;beq @set_scroll_value
			:
		@set_scroll_value:
		sta zp_irq_hor_scroll

	@D0C4_rts:
	rts

; -----------------------------------------------------------------------------

	;@tbl_max_x_scroll:
	;.byte $68	; Goro's Lair stage
	;.byte $68	; The Pit stage
	;.byte $68	; Warrior Shrine stage
	;.byte $68	; Palace Gates stage
	;.byte $68	; Courtyard stage
	;.byte $68	; Throne Room stage
	; Potentially unused
	;.byte $68	; $06
	;.byte $68	; $07
	;.byte $68	; $08
	;.byte $50	; $09
	;.byte $50	; $0A
	;.byte $88	; $0B

; -----------------------------------------------------------------------------

; Returns to caller's caller if animation is = 0 or <=2 or >= 6
sub_check_is_moving:
	lda zp_plr1_cur_anim,Y
	beq sub_rom_D0E0_rts	; Just return if animation is 0 = idle
; ----------------
; Returns to caller's caller if animation is <=2 or >=6
; Parameters:
; A = animation index
sub_check_abort_move:
	cmp #$02	; Crouching
	bcc @D0DE_rts_x2	; Fail if < =2

		cmp #$06	; Jumping up
		bcc sub_rom_D0E0_rts	; Fail if >= 6

	@D0DE_rts_x2:
	; Aborts calling sub and returns to caller's caller
	pla
	pla
; ----------------
sub_rom_D0E0_rts:
	rts

; -----------------------------------------------------------------------------

; Y = Attacking player's index (0/1)
sub_jump_button_input:
	lda zp_frozen_timer,Y
	bne @D124_rts
	
	lda zp_plr1_fgtr_idx_clean,Y
	beq @D0EE_downup_combo	; Branch if Raiden

	cmp #$03
	beq @D0EE_downup_combo	; Branch if Scorpion

	cmp #$04	; Kano
	bne @D0F3_check_movement

	; This extra check is only for Raiden, Scorpion and Kano
	; These three have moves performed with a D-pad Down-Up combo
	@D0EE_downup_combo:
	lda zp_AD,Y
	bne @D124_rts

	; Everyone else skips here
	@D0F3_check_movement:
	jsr sub_check_is_moving	; This will return to previous caller if animation is 1 or > 5

	lda zp_controller1,Y
	and #$08
	beq @D124_rts	; Return if not pressing D-pad Up

	lda zp_controller1,Y
	and #$01	; D-pad Right
	beq @D111_dpad_left

		ldx #$08	; Jump backwards
		lda zp_plr1_facing_dir,Y
		bne :+
			dex		; Jump forward
		:
		txa
		jmp sub_change_fighter_anim ;jsr sub_change_fighter_anim
		;rts
; ----------------
	@D111_dpad_left:
	lda zp_controller1,Y
	and #$02	; D-pad Left
	beq @D125_dpad_up

		ldx #$08	; Jump backwards
		lda zp_plr1_facing_dir,Y
		beq :+
			dex		; Jump forward
		:
		txa
		@D121_set_anim:
		jmp sub_change_fighter_anim ;jsr sub_change_fighter_anim

		@D124_rts:
		rts
; ----------------
	@D125_dpad_up:
	lda #$06	; Jump upwards
	bne @D121_set_anim

; -----------------------------------------------------------------------------

; Inputs that would make the player perform a parry
; Will execute if animation is idle or walking, otherwise it will return
sub_parry_button_input:
	lda zp_frozen_timer,Y
	bne @D163_rts
	
	lda zp_plr1_cur_anim,Y
	beq @D136

		cmp #$03	; Waling forward
		beq @D136

			cmp #$04	; Walking backwards
			bne @D163_rts

		@D136:
		tya
		eor #$01
		tax
		; Don't try to parry attacks from frozen players
		lda zp_frozen_timer,X
		bne @D163_rts

		lda zp_plr1_cur_anim,X
		cmp #$0B	; Base kick
		bcc @D163_rts

		cmp #$26	; Falling back
		bcs @D163_rts

		cmp #$14	; Crouched kick
		beq @D163_rts

		cmp #$18	; Throw move
		beq @D163_rts

		lda #$01
		ldx zp_plr1_facing_dir,Y
		bne :+
			lda #$02
		:
		and zp_controller1,Y
		beq @D163_rts

			lda #$05	; Parry
			sta zp_plr1_cur_anim,Y
			lda #$00
			sta zp_plr1_anim_frame,Y

	@D163_rts:
	rts

; -----------------------------------------------------------------------------

; Inputs that would make the player walk
sub_left_right_walk_input:
	lda zp_5E
	bne @D190_rts

	lda zp_frozen_timer,Y
	bne @D190_rts

	lda zp_plr1_fighter_idx,Y
	and #$80
	bne @D190_rts	; Skip input for CPU-controller opponent

	lda zp_plr1_cur_anim,Y
	bne @D1A5	; Branch if not in idle animation

	lda zp_7F
	bne @D1A5

	lda zp_controller1,Y
	and #$01	; Right button mask
	beq @D191_check_dpad_left

		; Right D-Pad button is currently pressed
		ldx #$04	; 4 = moving left animation
		lda zp_plr1_facing_dir,Y
		bne :+
			dex		; 3 = moving right animation
		:
		txa
		sta zp_plr1_cur_anim,Y
		lda #$00
		sta zp_plr1_anim_frame,Y

	@D190_rts:
	rts
; ----------------
	@D191_check_dpad_left:
	lda zp_controller1,Y
	and #$02	; Left button mask
	beq @D1A5

		ldx #$04	; 4 = moving left animation
		lda zp_plr1_facing_dir,Y
		beq :+
			dex		; 3 = moving right animation
		:
		txa
		@D1A1_set_anim:
		jsr sub_change_fighter_anim
	
	@D1A4_rts:
	rts
; ----------------
	@D1A5:
	lda zp_controller1,Y
	and #$03		; Left/Right mask
	bne @D1A4_rts	; Return if pressing left or right

	lda zp_plr1_cur_anim,Y
	jsr sub_check_abort_move
	lda #$00	; This will reset the animation to idle when a player stops walking
	beq @D1A1_set_anim	; This always branches

; -----------------------------------------------------------------------------

; Inputs that make the player perform attacks or parry while crouched
; Parameters:
; Y = Attacker's index (0 for player one, 1 for player 2)
sub_crouching_input:
	lda zp_frozen_timer,Y
	bne @D209_rts
	
	tya
	eor #$01
	tax	; Opponent player's index in X (0 for player one, 1 for player 2)
		; Used to check the opponent's animation

	; Y = attacker
	; X = opponent

	lda zp_plr1_cur_anim,Y
	cmp #$06		; 6 = jumping up animation
	bcs @D209_rts

	; Anything lower is idle, parrying, crouching or walking

	lda zp_controller1,Y
	and #$04	; D-pad down
	beq @D209_rts

	lda zp_controller1_new,Y
	and #$80	; Button A (punch)
	beq @D1D3

	lda #$13	; $13 = Uppercut
	bne @D206_set_anim

	@D1D3:
	lda zp_controller1_new,Y
	and #$40	; Button B (kick)
	beq @D1DE

	lda #$14	; $14 = crouching kick
	bne @D206_set_anim

	@D1DE:
	; Don't try to parry attacks from frozen players
	lda zp_frozen_timer,X
	bne @D1FD

	lda zp_plr1_cur_anim,X
	cmp #$0B	; $0B = base kick
	bcc @D1FD

	cmp #$26	; $26 = tripped/falling
	bcs @D1FD

	cmp #$18	; $18 = executing a throw move
	beq @D1FD

	lda #$01	; D-pad Right
	ldx zp_plr1_facing_dir,Y
	bne @D1F4	; Flip if facing the other direction

	lda #$02	; D-pad Left
	@D1F4:
	and zp_controller1,Y
	beq @D1FD

		lda #$02	; Crouching parry
		bne @D206_set_anim

	@D1FD:
	lda zp_plr1_fgtr_idx_clean,Y
	cmp #$07	; Goro doesn't crouch
	beq @D209_rts

		lda #$01	; Crouching
		@D206_set_anim:
		jsr sub_change_fighter_anim

	@D209_rts:
	rts

; -----------------------------------------------------------------------------

sub_rom_D20A:
	ldy #$00
	sty zp_plr_idx_param
	jsr sub_rom_D215

	ldy #$01
	sty zp_plr_idx_param
; ----------------
sub_rom_D215:
	lda zp_plr1_y_pos,Y
	cmp zp_sprites_base_y
	bcc @D22A

	cmp zp_F4,Y
	beq @D22A

	sta zp_F4,Y
	lda #$0A	; Short bounce sound when landing
	sta ram_req_sfx
	rts
; ----------------
	@D22A:
	sta zp_F4,Y
	rts

; -----------------------------------------------------------------------------

sub_rom_D3DE:
	lda zp_4B
	cmp #$FF
	bne :+
		jsr sub_show_fighter_names
		lda #$00
		sta zp_4B
		lda #$03
		sta zp_game_substate
		rts
; ----------------
	:
	ldx #$00
	lda zp_plr1_fighter_idx
	bmi :+
		; Skip CPU-controlled fighter
		inx
	:
	lda zp_4B
	and #$7F
	sta zp_plr1_fgtr_idx_clean,X

	lda #$00
	sta zp_plr1_cur_anim,X
	sta zp_plr1_anim_frame,X
	sta zp_plr1_damage,X
	sta zp_plr1_dmg_counter,X

	lda #$FF
	sta zp_4B
	stx zp_plr_idx_param
	jmp sub_load_fighters_palettes ;jsr sub_load_fighters_palettes
	;rts

; -----------------------------------------------------------------------------
.export tbl_fighter_palette_ptrs

tbl_fighter_palette_ptrs:
	.word @pal_raiden			; $00 Raiden
	.word @pal_sonya			; $01 Sonya
	.word @pal_subzero			; $02 Sub-Zero
	.word @pal_scorpion			; $03 Scorpion
	.word @pal_kano				; $04 Kano
	.word @pal_cage				; $05 Johnny Cage
	.word @pal_liukang			; $06 Liu Kang
	.word @pal_goro				; $07 Goro
	.word @pal_shangtsung		; $08 Shang-Tsung

	.word @pal_raiden ;.word @rom_D51E	; $09 Unused?
	.word @pal_raiden ;.word @rom_D526	; $0A Unused?
	.word @pal_raiden ;.word @rom_D52E	; $0B Unused?

	.word @pal_raiden_alt		; $0C Alt Raiden
	.word @pal_sonya_alt		; $0D Alt Sonya
	.word @pal_subzero_alt		; $0E Alt Sub-Zero
	.word @pal_scorpion_alt		; $0F Alt Scorpion
	.word @pal_kano_alt			; $10 Alt Kano
	.word @pal_cage_alt			; $11 Alt Johnny Cage
	.word @pal_liukang_alt		; $12 Alt Liu Kang
	.word @pal_goro_alt			; $13 Alt Goro
	.word @pal_shangtsung_alt	; $14 Alt Shang-Tsung

	.word @pal_raiden_alt ;.word @rom_D57E	; $15 Unused?
	.word @pal_raiden_alt ;.word @rom_D586	; $16 Unused?
	.word @pal_raiden_alt ;.word @rom_D58E	; $17 Unused?
	
	@pal_raiden:
	.byte $0E, $0F, $21, $20, $0E, $0F, $18, $28
	@pal_sonya:
	.byte $0E, $08, $18, $20, $0E, $08, $18, $36
	@pal_subzero:
	.byte $0E, $0F, $11, $01, $0E, $0F, $11, $27
	@pal_scorpion:
	.byte $0E, $0F, $27, $17, $0E, $0F, $27, $37
	@pal_kano:
	.byte $0E, $0F, $27, $20, $0E, $0F, $22, $20
	@pal_cage:
	.byte $0E, $0F, $16, $27, $0E, $0F, $27, $37
	@pal_liukang:
	.byte $0E, $0F, $16, $30, $0E, $0F, $17, $27
	@pal_goro:
	.byte $0E, $0F, $27, $20, $0E, $0F, $17, $27
	@pal_shangtsung:
	.byte $0E, $1D, $00, $10, $0E, $0D, $0C, $17
	;@rom_D51E:
	;.byte $0E, $37, $27, $07, $0E, $37, $21, $02
	;@rom_D526:
	;.byte $0E, $37, $26, $16, $0E, $37, $18, $16
	;@rom_D52E:
	;.byte $0E, $07, $27, $37, $0E, $0E, $15, $25
	@pal_raiden_alt:
	.byte $0E, $08, $1C, $20, $0E, $08, $25, $20
	@pal_sonya_alt:
	.byte $0E, $08, $15, $20, $0E, $08, $15, $36
	@pal_subzero_alt:
	.byte $0E, $0F, $1C, $0C, $00, $0F, $1C, $37
	@pal_scorpion_alt:
	.byte $0E, $0F, $26, $16, $0E, $0F, $26, $37
	@pal_kano_alt:
	.byte $0E, $0F, $27, $20, $0E, $07, $28, $30
	@pal_cage_alt:
	.byte $0E, $06, $26, $36, $0E, $08, $26, $36
	@pal_liukang_alt:
	.byte $0E, $05, $16, $30, $0E, $05, $27, $37
	@pal_goro_alt:
	.byte $0E, $07, $28, $30, $0E, $07, $28, $38
	@pal_shangtsung_alt:
	.byte $0E, $1D, $00, $10, $0E, $0D, $06, $17
	;@rom_D57E:
	;.byte $0E, $37, $27, $07, $0E, $37, $19, $09
	;@rom_D586:
	;.byte $0E, $37, $26, $0E, $0E, $37, $18, $0E
	;@rom_D58E:
	;.byte $0E, $07, $27, $37, $0E, $0E, $11, $21

; -----------------------------------------------------------------------------

; Don't forget to also change the global BG colour in tbl_stage_bg_colours
tbl_bg_palette_ptrs:
	.word @pal_goros_lair
	.word @pal_pit
	.word @pal_courtyard
	.word @pal_palace_gates
	.word @pal_warrior_shrine
	.word @pal_throne_room
	.word @pal_pit_bottom

	@pal_goros_lair:
	.byte $0E, $08, $00, $38, $0E, $16, $29, $28
	.byte $0E, $06, $16, $26, $0E, $08, $16, $36
	@pal_pit:
	.byte $0E, $16, $1A, $28, $0E, $08, $18, $01
	.byte $0E, $0C, $00, $10, $0E, $0C, $00, $01
	@pal_courtyard:
	.byte $0E, $16, $1A, $28, $0E, $17, $27, $11
	.byte $0E, $16, $26, $20, $0E, $0C, $00, $10
	@pal_palace_gates:
	.byte $0E, $16, $2A, $28, $0E, $17, $27, $3C
	.byte $0E, $17, $06, $3C, $0E, $00, $10, $3C
	@pal_warrior_shrine:
	.byte $0E, $16, $1A, $28, $0E, $07, $17, $01
	.byte $0E, $2D, $10, $01, $0E, $07, $17, $38
	@pal_throne_room:
	.byte $0E, $16, $2A, $28, $0E, $0B, $18, $06
	.byte $0E, $18, $28, $06, $0E, $00, $10, $06
	@pal_pit_bottom:
	.byte $0E, $16, $19, $28, $0E, $08, $16, $29
	.byte $0E, $08, $2D, $20, $0E, $08, $18, $38

; -----------------------------------------------------------------------------

sub_game_trampoline:
	asl A
	tay
	pla
	sta zp_ptr2_lo
	pla
	sta zp_ptr2_hi
	iny
	lda (zp_ptr2_lo),Y
	sta zp_ptr1_lo
	iny
	lda (zp_ptr2_lo),Y
	sta zp_ptr1_hi
	jmp (zp_ptr1_lo)

; -----------------------------------------------------------------------------
.export sub_clear_oam_data

sub_clear_oam_data:
	lda #$F8
	ldx #$00
	:
		sta ram_oam_data,X
		inx
		inx
		inx
		inx
	bne :-
	rts

; -----------------------------------------------------------------------------

; Returns:
; zp_ptr1_lo = result
sub_divide:
	lda #$00
	ldx #$18

	@D6B2_loop:
		asl zp_07
		rol zp_var_x
		rol zp_x_counter
		rol A
		cmp zp_16
		bcc :+
			sbc zp_16
			inc zp_07
		:
		dex
	bne @D6B2_loop

	sta zp_ptr1_lo
	rts

; -----------------------------------------------------------------------------

sub_rom_D6C7:
	ldy #$00
	sty zp_17
	lda #$0A
	sta zp_16

	:
		jsr sub_divide

		lda zp_ptr1_lo
		clc
		adc zp_0D
		sta ram_066D,Y
		iny
		cpy #$05
	bcc :-

	rts

; -----------------------------------------------------------------------------

; Makes players "push" each other when moving against a stationary opponent
sub_check_player_push:
	lda zp_game_substate
	cmp #$03
	bne sub_skip_bump_check	; Return if we are in "player hit" substate

	lda zp_plr1_cur_anim,Y
	cmp #$06	; Idle/non-moving animations?
	bcc :+

		cmp #$28	; Staggered animation
		bne sub_skip_bump_check

	:
	; Looks like this is only executed if the current player is not moving
	lda zp_players_x_distance
	cmp #$18
	bcs sub_skip_bump_check

		lda zp_players_y_distance
		cmp #$10
		bcs sub_skip_bump_check

			lda #$04
			sta zp_ptr1_lo
; ----------------
; Can't push a player that is near the border
sub_check_left_border_proximity:
	lda zp_plr1_facing_dir,Y
	bne sub_check_right_border_proximity

		lda zp_plr1_x_pos,Y
		cmp #$20
		bcc sub_skip_bump_check

			lda zp_plr1_x_lo,X
			sec
			sbc zp_ptr1_lo
			sta zp_plr1_x_lo,X
			bcs sub_skip_bump_check

				dec zp_plr1_x_hi,X
; ----------------
sub_skip_bump_check:
	rts
; ----------------
; Can't push a player that is near the border
sub_check_right_border_proximity:
	lda zp_plr1_x_pos,Y
	cmp #$D0
	bcs sub_skip_bump_check

		lda zp_plr1_x_lo,X
		clc
		adc zp_ptr1_lo
		sta zp_plr1_x_lo,X
		bcc sub_skip_bump_check

			inc zp_plr1_x_hi,X
			rts

; -----------------------------------------------------------------------------

sub_rom_D72C:
	lda zp_players_x_distance
	cmp #$50
	bcc @D737

		lda #$00
		sta zp_7F
		rts
; ----------------
	@D737:
	lda zp_7F
	bne @D759

		lda zp_plr1_cur_anim,Y
		cmp #$2D
		beq @D752

		cmp #$2F
		beq @D752

		cmp #$09
		beq @D752

		cmp #$0A
		beq @D752

		cmp #$2E
		bne @D76C_rts

		@D752:
		lda zp_plr1_anim_frame,Y
		cmp #$02
		bne @D76C_rts

	@D759:
	lda #$01
	sta zp_7F
	tya
	eor #$01
	tay
	txa
	eor #$02
	tax
	lda #$08
	sta zp_ptr1_lo
	jmp sub_check_left_border_proximity ;jsr sub_rom_D701

	@D76C_rts:
	rts

; -----------------------------------------------------------------------------

sub_move_fighter_sprites:
	ldx #$00
	stx zp_plr_ofs_param
	stx zp_plr_idx_param
	jsr sub_inner_move_sprites

	ldx #$02
	stx zp_plr_ofs_param
	dex
	stx zp_plr_idx_param
; ----------------
sub_inner_move_sprites:
	jsr sub_shangtsung_palettes

	ldy zp_plr_idx_param
	ldx zp_plr1_fgtr_idx_clean,Y
	lda tbl_fighter_sprite_banks,X
	sta zp_05

	; Load a new bank in $8000-$9FFF from table below
	lda #$86
	sta mmc3_bank_select
	sta zp_bank_select_value
	lda zp_05
	sta mmc3_bank_data

	; Read a pointer from the top of the new ROM in $8000
	lda rom_8000+0
	sta zp_ptr3_lo
	lda rom_8000+1
	sta zp_ptr3_hi

	; Index for movement data = animation idx * 3
	lda zp_plr1_cur_anim,Y
	asl A
	bcc :+
		inc zp_ptr3_hi
	:	
	clc
	adc zp_plr1_cur_anim,Y
	bcc :+
		inc zp_ptr3_hi
	:
	sta zp_ptr1_lo	 ; Will also be used to index animation frame data
	
	tay
	lda (zp_ptr3_lo),Y
	asl A
	tax
	lda tbl_movement_data_ptrs+0,X
	sta zp_ptr4_lo
	lda tbl_movement_data_ptrs+1,X
	sta zp_ptr4_hi

	ldy zp_plr_idx_param	; Player index (0 for player one, 1 for player two)
	lda zp_plr1_anim_frame,Y
	asl A
	tay
	lda (zp_ptr4_lo),Y
	sta zp_05	; Player's X movement (signed value)
	iny
	lda (zp_ptr4_lo),Y
	sta zp_06	; Player's Y movement (signed value)

	; Ignore movement if player is frozen
	ldx zp_plr_idx_param
	lda zp_frozen_timer,X
	beq :+
		lda #$00
		sta zp_06
		sta zp_05
	:

	iny
	lda #$00
	sta zp_18
	lda (zp_ptr4_lo),Y
	cmp #$80
	bne :+
		; Animation will be set to zero when this is >0
		inc zp_18
	:

	; Check if we need to move the victim of Scorpion's spear
	jsr sub_scorpion_spear_pull

	ldx zp_plr_ofs_param	; 2-byte data / pointer offset for current player
	ldy zp_plr_idx_param	; 1-byte data offset for current player
	lda zp_05	; X movement for current animation
	bpl @D81A_facing

		; Negative movement (against current facing direction)
		eor #$FF
		sta zp_05
		inc zp_05
		lda zp_plr1_facing_dir,Y	; Will determine whether to move forward or backwards
		bne @D81F_set_x

			; Recalculate the distance between player hit boxes
			@D803:
			lda zp_plr1_x_pos,Y
			sec
			sbc zp_05
			cmp #$20
			bcc @D834_set_y

			lda zp_plr1_x_lo,X
			sec
			sbc zp_05
			sta zp_plr1_x_lo,X
			bcs @D834_set_y

			dec zp_plr1_x_hi,X
			beq @D834_set_y

	@D81A_facing:
	lda zp_plr1_facing_dir,Y
	bne @D803

	@D81F_set_x:
	lda zp_plr1_x_pos,Y
	clc
	adc zp_05
	cmp #$D0
	bcs @D834_set_y

		lda zp_plr1_x_lo,X
		clc
		adc zp_05
		sta zp_plr1_x_lo,X
		bcc @D834_set_y

			inc zp_plr1_x_hi,X

	@D834_set_y:
	lda zp_plr1_y_pos,Y
	clc
	adc zp_06
	sta zp_plr1_y_pos,Y

	ldy zp_ptr1_lo	; Fighter's anim ROM data offset
	iny
	lda (zp_ptr3_lo),Y
	sta zp_ptr4_lo
	iny
	lda (zp_ptr3_lo),Y
	sta zp_ptr4_hi

	ldy zp_plr_idx_param
	lda zp_plr1_anim_frame,Y
	tay
	lda (zp_ptr4_lo),Y
	sta zp_ptr1_lo

	lda rom_8002+0
	sta zp_ptr4_lo
	lda rom_8002+1
	sta zp_ptr4_hi

	lda zp_ptr1_lo
	asl A
	tay
	lda (zp_ptr4_lo),Y
	sta zp_ptr3_lo
	iny
	lda (zp_ptr4_lo),Y
	sta zp_ptr3_hi	; This now points to the second data table in fighter's anim ROM bank

	ldx zp_plr_ofs_param
	ldy zp_plr_idx_param
	jsr sub_check_player_push
	jsr sub_rom_D72C

	ldy zp_plr_idx_param
	ldx tbl_player_oam_offsets,Y
	lda zp_plr1_cur_anim,Y

	cmp #$09	; Knocked backwards
	beq @D88A

	cmp #$2E	; Knocked down
	beq @D88A

	cmp #$28	; Staggered
	bne @D88E

		@D88A:
		; Force a move to the next OAM entry when staggered (and knocked out?)
		inx
		inx
		inx
		inx

	@D88E:
	stx zp_first_oam_ofs
	ldx zp_plr_ofs_param
	lda zp_plr1_facing_dir,Y
	beq :+
		lda #$40	; Sprite's horizontal flip flag
	:
	sta zp_oam_flip_flag
	
	lda zp_plr1_x_lo,X
	sec
	sbc zp_irq_hor_scroll
	sta zp_plr1_x_pos,Y
	sta zp_07

	ldx #$08
	stx zp_ptr1_lo
	lda zp_plr1_y_pos,Y
	sec
	sbc zp_ptr1_lo
	sta zp_0A

	ldy zp_plr_idx_param
	lda zp_frozen_timer,Y
	beq :+
		; Don't animate frozen players
		; Instead, decrement the counter to "thaw" them gradually
		lda #$00
		dcp zp_frozen_timer,Y		
		bne sub_animate_sprites

		; If timer just reached zero, change the palette back to normal
		isc zp_thaw_flag,Y
		bne @check_frame_sfx
	:
	;ldx zp_7C
	isc zp_plr1_anim_frame,Y ;inc zp_plr1_anim_frame,X
	;ldy zp_7C
	@check_frame_sfx:
	ldx zp_plr1_cur_anim,Y
	lda zp_plr1_anim_frame,Y

	; Frame 1 may have a sound if it's an attack/projectile
	cmp #$01
	bne :+
		lda tbl_frame_1_sfx_idx,X
		beq :+
			sta ram_req_sfx
	:
	lda zp_18
	beq sub_animate_sprites
		lda #$00
		sta zp_plr1_anim_frame,Y

		; If the current animation is $33 (ranged hit)
		; and the attacker is Scorpion ($03)
		; then stun the player
		lda zp_plr1_cur_anim,Y
		cmp #$33
		bne :+
			tya
			eor #$01
			tax
			lda zp_plr1_fgtr_idx_clean,X
			cmp #$03
			bne @set_idle_anim
				lda #$28
				sta zp_plr1_cur_anim,Y
				bne @ground_sprite
		:
		; If the current animation is $0D (special 1)
		; and the player is Raiden ($00)
		; then teleport
		cmp #$0D
		bne :+
			lda zp_plr1_fgtr_idx_clean,Y
			bne :+
				jmp sub_raiden_teleport
		:
		; Otherwise, back to idle
		@set_idle_anim:
		lda #$00
		sta zp_plr1_cur_anim,Y
		@ground_sprite:
		lda zp_sprites_base_y
		sta zp_plr1_y_pos,Y

; ----------------

sub_animate_sprites:
	; If the current animation is $17 (special 2)
	; and the player is Scorpion ($03)
	; then teleport
	lda zp_plr1_cur_anim,Y
	cmp #$17
	bne :+
		lda zp_plr1_fgtr_idx_clean,Y
		cmp #$03
		bne :+
			jsr sub_scorpion_teleport
	:

	ldx tbl_player_oam_offsets,Y
	ldy #$00
	lda #$F8
	; This loop moves all sprites off-screen for the current player
	:
		sta ram_oam_copy_ypos,X
		inx
		inx
		inx
		inx
	iny
	cpy #$20
	bcc :-

	ldy #$00
	lda (zp_ptr3_lo),Y
	sta zp_05			; Horizontal tiles count
	;sta zp_ptr2_lo		; This may be unused
	iny
	lda (zp_ptr3_lo),Y
	sta zp_06			; Vertical tiles count
	;sta zp_16			; Maybe also unused
	iny
	lda (zp_ptr3_lo),Y
	sta zp_0F			; X offset
	iny
	lda (zp_ptr3_lo),Y
	ldx zp_plr_idx_param
	sta zp_chr_bank_0,X	; CHR ROM bank
	sta ram_0429
	iny
	lda (zp_ptr3_lo),Y
	sta ram_042A		; Sprite attributes OR mask
	iny
	lda zp_05
	sta zp_x_counter	; Counter for horizontal sprites

	lda zp_oam_flip_flag	; This depends on current facing direction
	bne :+
		; ptr1_lo = $08
		; zp_07 = zp_07 - zp_0F
		lda #$08
		sta zp_ptr1_lo	; X increment (+8)

		lda zp_07
		sec
		sbc zp_0F
		jmp @DA07
	:
	; ptr1_lo = $F8
	; zp_07 = zp_0F - $08 + zp_07
	lda #$F8
	sta zp_ptr1_lo	; X decrement (-8)

	lda zp_0F
	sec
	sbc #$08
	clc
	adc zp_07

	@DA07:
	sta zp_07	; Starting X offset for first tile in a row
	sta zp_var_x	; Current X offset (updated for each column)

	ldx zp_06	; Vertical updates count?

	:
		lda zp_0A	; It seems this was player Y pos - 8 before this loop
		sec
		sbc #$08
		sta zp_0A
	dex
	bne :-

	sta zp_var_y
	dec zp_var_y	; Base Y position (incremented by 8 for each row)

	ldx zp_first_oam_ofs	; OAM offset of first sprite

	@next_frame_data_byte:
	lda (zp_ptr3_lo),Y
	cmp #$FF
	beq @skip_sprite

		; Ignore the MSB because we use this as an offset: we don't know yet
		; if we are in the top half of CHR ROM or the bottom
		and #$7F

		sta zp_backup_a

			lda zp_plr_idx_param	; Player index
			beq @DA2F	; Nothing to change for player 1

		lda zp_backup_a

			ora #$80	; Move tile index to the bottom of CHR ROM for player 2
			bne @set_tile_id

		@DA2F:
		lda zp_backup_a

		@set_tile_id:
		sta ram_oam_copy_tileid,X
		jmp @set_sprite_flags

		; set_sprite_flags will jump back here
		@set_xy_pos:
		lda zp_var_y	; Current row's Y pos
		sta ram_oam_copy_ypos,X
		lda zp_var_x	; Current tile's X pos
		sta ram_oam_copy_xpos,X
		; Move to next OAM entry
		;inx
		;inx
		;inx
		;inx
		txa
		axs #$FC

	@skip_sprite:
	iny	; Animation frame data offset

	; Increase X position offset for next tile in this row
	lda zp_ptr1_lo	; This is a signed value (negative to draw right-to-left)
	clc
	adc zp_var_x
	sta zp_var_x

	dec zp_x_counter	; X counter
	bne @next_frame_data_byte

	; Increase Y position offset for next row
	lda zp_var_y
	clc
	adc #$08	; Fixed offset: we always draw top-to-bottom
	sta zp_var_y

	lda zp_05	; Horizontal tiles count reload
	sta zp_x_counter

	lda zp_07	; Starting X pos for next row of sprites
	sta zp_var_x

	dec zp_06	; Y counter
	bne @next_frame_data_byte

	rts
; ----------------
	@set_sprite_flags:
	; Preserve animation data offset
	sty zp_backup_y

		; No need to multiply bank index by two, because two CHR banks are always
		; loaded with the index of the top one, so the values will be 0, 2, 4, 6...
		ldy ram_0429 ;lda ram_0429
		;tay
		lda tbl_spr_attr_ptrs+0,Y
		sta zp_ptr4_lo
		lda tbl_spr_attr_ptrs+1,Y
		sta zp_ptr4_hi

		lda ram_oam_copy_tileid,X
		and #$07
		tay
		lda rom_DAB4,Y	; Index by tile ID % 8
		sta zp_backup_a
			lda ram_oam_copy_tileid,X
			and #$7F
			lsr A
			lsr A
			lsr A
			tay
		lda zp_backup_a
		and (zp_ptr4_lo),Y
		beq :+
			lda #$01
		:
		ora ram_042A	; Add flags from fighter's anim frame data
		eor zp_oam_flip_flag		; Horizontal flip flag depending on current facing direction
		tay
		lda zp_plr_idx_param		; Player index
		beq @DA9D		; Branch for player one

			tya			; Player 2 changes palette index
			ora #$02
			bne @DA9E

		@DA9D:
		tya				; Player 1 uses value as it is (keep palette index)

		@DA9E:
		;ldy ram_irq_routine_idx
		;cpy #$06
		;bne :+
			; This is only used in the Continue screen...
			; probably leftover from a different game
		;	ora #$20	; Move sprite behind the background
		;:
		sta ram_oam_copy_attr,X

	ldy zp_backup_y

	;lda #$FB
	;sta ram_067F	; Probably unused
	jmp @set_xy_pos

; -----------------------------------------------------------------------------
.export rom_DAB4

; This mask is used to select one bit from the sprite attribute tables
; Each tile ID in a 4KB bank will be matched with one bit to choose either
; palette 0 or 1
rom_DAB4:
	.byte $01, $02, $04, $08, $10, $20, $40, $80

; -----------------------------------------------------------------------------

; SFX indices for frame 1 of each animation
; 0 = no sound
; Index = animation number
tbl_frame_1_sfx_idx:
	.byte $00, $00, $00, $00, $00, $00, $00, $00	; $00-$07
	.byte $00, $00, $00, $07, $07, $08, $00, $00	; $08-$0F
	.byte $08, $00, $00, $08, $07, $08, $00, $04	; $10-$17
	.byte $08, $00, $00, $00, $00, $00, $04, $00	; $18-$1F
	.byte $00, $00, $00, $00, $00, $00, $00, $00	; $20-$27
	.byte $00, $00, $00, $00, $00, $00, $00, $00	; $28-$2F
	.byte $00, $00, $00, $00, $00, $00, $00, $00	; $30-$37

; -----------------------------------------------------------------------------
.export tbl_fighter_sprite_banks

; Bank numbers, will be mapped to $8000-$9FFF
; These contain animation (frames sequence) and frame data (sprite indices)
tbl_fighter_sprite_banks:
	.byte $05	; Raiden
	.byte $06	; Sonya
	.byte $07	; Sub-Zero
	.byte $08	; Scorpion
	.byte $09	; Kano
	.byte $0A	; Cage
	.byte $0B	; Liu Kang
	.byte $0C	; Goro
	.byte $0D	; Shang-Tsung

; -----------------------------------------------------------------------------

; Move Scorpion's sprite during his teleport animation if close to the border
; Parameters:
; Y = player index
sub_scorpion_teleport:
	; Only teleport between frames 3 and 11
	lda zp_plr1_anim_frame,Y
	cmp #$03
	bcc @scorpion_teleport_rts

	cmp #$0C
	bcs	@scorpion_teleport_rts

	; Keep in mind that the direction is flipped
	lda zp_plr1_facing_dir,Y
	beq @teleport_left

		; Teleport from left to right
		lda zp_plr1_x_pos,Y
		cmp #$24	; Must be at X = $23 or lower
		bcs @scorpion_teleport_rts

			;clc not needed, we know it's clear
			lda #$E6
			bne @do_teleport

	; Teleport from right to left
	@teleport_left:
	lda zp_plr1_x_pos,Y
	cmp #$C9	; Must be at X = $C9 or higher
	bcc @scorpion_teleport_rts

		lda #$19
		@do_teleport:
		adc zp_irq_hor_scroll
		sta zp_plr1_x_lo,Y
		lda #$00
		adc #$00
		sta zp_plr1_x_hi,Y

	@scorpion_teleport_rts:
	rts

; -----------------------------------------------------------------------------

; Moves Raiden's sprite during his teleport animation
; Parameters:
; Y = player index
sub_raiden_teleport:
	lda #$27
	sta zp_plr1_cur_anim,Y

	lda zp_plr1_facing_dir,Y
	beq @teleport_right

		; Teleport left

		lax zp_plr_ofs_param
		eor #$02
		tay	; Y = offset for opposing player

		lda zp_plr1_x_lo,Y
		sec
		sbc #$1B
		sta zp_plr1_x_lo,X
		lda zp_plr1_x_hi,Y
		sbc #00
		sta zp_plr1_x_hi,X
		
		; Off-screen check to the left
		lda zp_plr1_x_hi,X
		bne @teleport_done

			lda zp_plr1_x_lo,X
			cmp #$20
			bcs @teleport_done

				lda #$00
				sta zp_plr1_x_hi,X
				lda #$3F	; Safe distance on the other side
				bne @adjust_destination

	@teleport_right:
	lax zp_plr_ofs_param
	eor #$02
	tay	; Y = offset for opposing player

	clc
	lda zp_plr1_x_lo,Y
	adc #$1B
	sta zp_plr1_x_lo,X
	lda zp_plr1_x_hi,Y
	adc #$00
	sta zp_plr1_x_hi,X
	
	; Off-screen check to the right
	lda zp_plr1_x_hi,X
	beq @teleport_done

		lda zp_plr1_x_lo,X
		cmp #$34
		bcc @teleport_done

			lda #$01
			sta zp_plr1_x_hi,X
			lda #$15
	
	@adjust_destination:
	sta zp_plr1_x_lo,X

	;ldy zp_plr_idx_param

	;lda zp_plr1_x_lo,X
	;sec
	;sbc zp_irq_hor_scroll
	;sta zp_plr1_x_pos,Y
	;sta zp_07

	@teleport_done:
	ldy zp_plr_idx_param
	jmp sub_animate_sprites

; -----------------------------------------------------------------------------

; If the player has been hit by Scorpion's spear, move it towards the attacker
; Stop the animation when they are close enough
sub_scorpion_spear_pull:
	lax zp_plr_idx_param	; Target's index (0/1)
	eor #$01
	tay			; Attacker's index

	; Check target's animation

	lda zp_plr1_cur_anim,X
	cmp #$33	; Special ranged hit animation
	bne @spear_pull_rts

	; Check if attacker is Scorpion

	lda zp_plr1_fgtr_idx_clean,Y
	cmp #$03	; Scorpion
	bne @spear_pull_rts

	; Horizontal movement
	lda #$04
	sta zp_05

	; Check distance
	lda zp_players_x_distance
	cmp #$1E
	bcs @spear_pull_rts

		inc zp_18	; Force stop animation (will transition to stunned)

		lda #$00	; Scorpion -> idle
		sta zp_plr1_cur_anim,Y
		sta zp_plr1_anim_frame,Y

	@spear_pull_rts:
	rts

; -----------------------------------------------------------------------------

; Change palettes if Shang-Tsung has morphed into a different fighter
sub_shangtsung_palettes:
	ldx zp_plr_idx_param
	
	lda zp_frozen_timer,X
	bne @D92B_rts	; Don't change palette if frozen (keep special palette)

	lda zp_plr1_fighter_idx,X
	and #$7F	; Mask out CPU opponent flag

	cmp #$08	; Shang-Tsung
	beq @D8FE

	cmp #$14	; Shang-Tsung (alt palette)
	bne @D92B_rts

		@D8FE:
		lda zp_plr1_anim_frame,X
		bne @D923

		ldy zp_plr1_cur_anim,X
		lda rom_D977,Y
		beq @D923

		cmp #$01
		bne @D91D

		lda zp_plr1_fgtr_idx_clean,X
		cmp #$08
		bne @D923

		jsr sub_rom_D96D
		cpy #$08
		bne @D933

		dey
		bne @D933

		@D91D:
		lda #$08
		sta zp_plr1_fgtr_idx_clean,X
		bne sub_load_fighters_palettes
		@D923:
		lda zp_48,X
		cmp #$30
		bcs @D92C

		inc zp_48,X
	@D92B_rts:
	rts
; ----------------
	@D92C:
	lda zp_plr1_cur_anim,X
	bne @D92B_rts

	jsr sub_rom_D96D
	@D933:
	sty zp_plr1_fgtr_idx_clean,X
; ----------------
sub_load_fighters_palettes:
	lda zp_plr1_fgtr_idx_clean,X
	asl A
	tax
	lda tbl_fighter_palette_ptrs+0,X
	sta zp_ptr1_lo
	lda tbl_fighter_palette_ptrs+1,X
	sta zp_ptr1_hi

	ldy #$00
	ldx zp_plr_idx_param
	sty zp_48,X
	sty zp_plr1_anim_frame,X
	ldx #$00
	:
		lda (zp_ptr1_lo),Y
		sta ram_ppu_data_buffer,X
		inx
		iny
	cpy #$08
	bcc :-

	; Adjust global GB colour for the Pit stage
	; Needed because Shang-Tsung can change palettes during the match
	; (Not needed anymore)
	;ldx ram_irq_routine_idx
	;lda tbl_stage_bg_colours,X
	;sta ram_ppu_data_buffer

	sty zp_nmi_ppu_cols
	lda #$01
	sta zp_nmi_ppu_rows
	lda #$3F
	sta zp_nmi_ppu_ptr_hi
	ldy #$10		; Player 1 offset
	lda zp_plr_idx_param
	beq :+
		ldy #$18	; Player 2 offset
	:
	sty zp_nmi_ppu_ptr_lo
	rts

; ----------------

; Now unused, all stages use black
;tbl_stage_bg_colours:
;	.byte $0E	; Goro's Lair
;	.byte $0E	; The Pit
;	.byte $0E	; Courtyard
;	.byte $0E	; Palace Gates
;	.byte $0E	; Warrior Shrine
;	.byte $0E	; Throne room

; -----------------------------------------------------------------------------

sub_rom_D96D:
	lda zp_random
	and #$07
	bne :+
		iny
	:
	tay
	iny
	rts

; -----------------------------------------------------------------------------

; Index by animation number ($00-$34)
rom_D977:
	.byte $00, $01, $00, $00, $00, $01, $01, $01	; $00-$07
	.byte $01, $01, $01, $01, $01, $01, $01, $01	; $08-$0F
	.byte $01, $01, $01, $01, $01, $01, $01, $01	; $10-$17
	.byte $01, $01, $01, $01, $01, $01, $01, $01	; $18-$1F
	.byte $01, $01, $01, $01, $01, $01, $02, $01	; $20-$27
	.byte $01, $02, $02, $01, $01, $01, $02, $01	; $28-$2F
	.byte $01, $01, $01, $01, $01					; $30-$34

; -----------------------------------------------------------------------------

; Load the special "frozen" palette
; Parameters:
; X = player index
sub_frozen_palette:
	stx zp_plr_idx_param
	ldy #$00
	;sty zp_48,X
	;sty zp_plr1_anim_frame,X
	ldx #$00
	:
		lda @pal_frozen,Y
		sta ram_ppu_data_buffer,X
		inx
		iny
	cpy #$08
	bcc :-

	; Adjust global GB colour for the Pit stage
	; Needed because Shang-Tsung can change palettes during the match
	; (Not needed anymore)
	;ldx ram_irq_routine_idx
	;lda tbl_stage_bg_colours,X
	;sta ram_ppu_data_buffer

	sty zp_nmi_ppu_cols	; Y = 8
	lda #$01
	sta zp_nmi_ppu_rows
	lda #$3F
	sta zp_nmi_ppu_ptr_hi
	ldy #$10		; Player 1 offset
	lda zp_plr_idx_param
	beq :+
		ldy #$18	; Player 2 offset
	:
	sty zp_nmi_ppu_ptr_lo
	rts

; ----------------

	@pal_frozen:
	.byte $0E, $0C, $11, $3C, $0E, $0C, $11, $31

; -----------------------------------------------------------------------------


; -----------------------------------------------------------------------------
.export tbl_spr_attr_ptrs

; Data pointers, indexed by CHR ROM bank number
tbl_spr_attr_ptrs:
	.word @attr_bits_00, @attr_bits_02		; Raiden (00-0D)
	.word @attr_bits_04, @attr_bits_06
	.word @attr_bits_08, @attr_bits_0A
	.word @attr_bits_0C, @attr_bits_0E
	.word @attr_bits_10, @attr_bits_12
	.word @attr_bits_14, @attr_bits_16
	.word @attr_bits_18, @attr_bits_1A
	
	.word @attr_bits_00, @attr_bits_02		; Stage BGs (0E-1B, unused)
	.word @attr_bits_00, @attr_bits_02
	.word @attr_bits_00, @attr_bits_02
	.word @attr_bits_00, @attr_bits_02
	.word @attr_bits_00, @attr_bits_02
	.word @attr_bits_00, @attr_bits_02
	.word @attr_bits_00, @attr_bits_02

	.word @attr_bits_38, @attr_bits_3A		; Sonya (1C-27)
	.word @attr_bits_3C, @attr_bits_3E
	.word @attr_bits_40, @attr_bits_42
	.word @attr_bits_44, @attr_bits_46
	.word @attr_bits_48, @attr_bits_4A
	.word @attr_bits_4C, @attr_bits_4E

	.word @attr_bits_50, @attr_bits_52		; Shang Tsung (28-2B)
	.word @attr_bits_54, @attr_bits_56

	.word @attr_bits_58, @attr_bits_5A		; Sub-Zero/Scorpion (2C-39)
	.word @attr_bits_5C, @attr_bits_5E
	.word @attr_bits_60, @attr_bits_62
	.word @attr_bits_64, @attr_bits_66
	.word @attr_bits_68, @attr_bits_6A
	.word @attr_bits_6C, @attr_bits_6E
	.word @attr_bits_70, @attr_bits_72

	.word @attr_bits_74, @attr_bits_76		; Liu Kang (3A-45)
	.word @attr_bits_78, @attr_bits_7A
	.word @attr_bits_7C, @attr_bits_7E
	.word @attr_bits_80, @attr_bits_82
	.word @attr_bits_84, @attr_bits_86
	.word @attr_bits_88, @attr_bits_8A

	.word @attr_bits_8C, @attr_bits_8E		; Johnny Cage (46-51)
	.word @attr_bits_90, @attr_bits_92
	.word @attr_bits_94, @attr_bits_96
	.word @attr_bits_98, @attr_bits_9A
	.word @attr_bits_9C, @attr_bits_9E
	.word @attr_bits_A0, @attr_bits_A2

	.word @attr_bits_A4, @attr_bits_A6		; Kano (52-5F)
	.word @attr_bits_A8, @attr_bits_AA
	.word @attr_bits_AC, @attr_bits_AE
	.word @attr_bits_B0, @attr_bits_B2
	.word @attr_bits_B4, @attr_bits_B6
	.word @attr_bits_B8, @attr_bits_BA
	.word @attr_bits_BC, @attr_bits_BE

	.word @attr_bits_C0, @attr_bits_C2		; Goro (60-67)
	.word @attr_bits_C4, @attr_bits_C6
	.word @attr_bits_C8, @attr_bits_CA
	.word @attr_bits_CC, @attr_bits_CE

	.word @attr_bits_D0, @attr_bits_D2		; Scorpion (68-6B)
	.word @attr_bits_D4, @attr_bits_D6

; ----------------
; These are basically 128 bit masks with one bit for each of the 128 patterns
; in two 2KB CHR ROM banks
.include "attr_bits.asm"

; -----------------------------------------------------------------------------

; Data pointers for sprite animation sequences
; Index for these pointers is first byte from 3-byte data on top of fighter's
; PRG ROM bank
tbl_movement_data_ptrs:
	.word @rom_DB7D				; $00
	.word @rom_DB98				; $01
	.word @up_down_12_frames
	.word @back_10_frames
	.word @rom_DBF6
	.word @rom_DC17
	.word @rom_DB8B
	.word @rom_DBE5
	.word @still_6_frames		; $08
	.word @still_16_frames		; $09
	.word @rom_DB85
	.word @forward_flight
	.word @torpedo
	.word @knockback_19_frames
	.word @rom_DC8D
	.word @rom_DCA8
	.word @still_20_frames		; $10
	.word @rom_DB89
	.word @rom_DCD3_unused
	.word @rom_DCEE
	.word @rom_DD19
	.word @rom_DD46
	.word @rom_DD53
	.word @rom_DD68
	.word @still_30_frames		; $18
	.word @knocked_up_21_frames
	.word @rom_DDA8
	.word @rom_DDC1
	.word @rom_DDC2
	.word @rom_DB75
	.word @rom_DE03
	.word @still_16_frames
	.word @rom_DE05				; $20
	.word @rom_DE12
	.word @rom_DB87
	.word @rom_DE2F
	.word @rom_DE48
	.word @rom_DB8E
	.word @back_15_frames
	.word @knocked_up_21_frames
	.word @rom_DE8E				; $28
	.word @thrown
	.word @throw_move
	.word @rom_DECD
	.word @rom_DEEE				; $2C
	.word @scorpion_teleport	; $2D

; ----------------

; Index for this data is current animation frame * 2
	@still_30_frames:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00

; ----------------

	@still_20_frames:
	.byte $00, $00, $00, $00, $00, $00, $00, $00

; ----------------

; No movement, 16 frames
	@still_16_frames:
	.byte $00, $00, $00, $00, $00, $00, $00, $00

; ----------------

	@rom_DB75:
	.byte $00, $00, $00, $00
	.byte $00, $00, $00, $00

; ----------------

	@rom_DB7D:
	.byte $00, $00, $00, $00

; ----------------

	@still_6_frames:
	.byte $00, $00, $00, $00

; ----------------

	@rom_DB85:
	.byte $00, $00

; ----------------

	@rom_DB87:
	.byte $00, $00

; ----------------

	@rom_DB89:
	.byte $00, $00

; ----------------

	@rom_DB8B:
	.byte $00, $00, $80

; ----------------

	@rom_DB8E:
	.byte $04, $00, $04, $00, $04, $00, $04, $00
	.byte $04, $00

; ----------------

	@rom_DB98:
	.byte $04, $00, $04, $00, $04, $00, $04, $00
	.byte $04, $00, $04, $00, $04, $00, $04, $00
	.byte $04, $00, $04, $00, $80

; ----------------

	@back_15_frames:
	.byte $FC, $00, $FC, $00, $FC, $00, $FC, $00
	.byte $FC, $00

; ----------------

	@back_10_frames:
	.byte $FC, $00, $FC, $00, $FC, $00, $FC, $00
	.byte $FC, $00, $FC, $00, $FC, $00, $FC, $00
	.byte $FC, $00, $FC, $00, $80

; ----------------

	@up_down_12_frames:
	.byte $00, $ED	; 0, -19
	.byte $00, $F0	; 0, -16
	.byte $00, $F2	; 0, -14
	.byte $00, $F4	; 0, -12
	.byte $00, $F6	; 0, -10
	.byte $00, $F8	; 0, -8
	.byte $00, $08	; 0, 8
	.byte $00, $0A	; 0, 10
	.byte $00, $0C	; 0, 12
	.byte $00, $0E	; 0, 14
	.byte $00, $10	; 0, 16
	.byte $00, $13	; 0, 19
	.byte $80

; ----------------

	@rom_DBE5:
	.byte $F8, $00, $F8, $00, $F8, $00, $FB, $00
	.byte $F8, $00, $FB, $00, $FD, $00, $FE, $00
	.byte $80

; ----------------

	@rom_DBF6:
	.byte $FE, $EE, $FE, $F0, $FE, $F2, $FE, $F4
	.byte $FC, $F6, $FA, $F8, $F8, $FA, $F6, $FC
	.byte $F6, $04, $F8, $06, $FA, $08, $FC, $0A
	.byte $FE, $0C, $FE, $0E, $FE, $10, $FE, $12
	.byte $80

; ----------------

	@rom_DC17:
	.byte $02, $EE, $02, $F0, $02, $F2, $02, $F4
	.byte $04, $F6, $06, $F8, $08, $FA, $0A, $FC
	.byte $0A, $04, $08, $06, $06, $08, $04, $0A
	.byte $02, $0C, $02, $0E, $02, $10, $02, $12
	.byte $80

; ----------------

	@forward_flight:
	.byte $00, $00
	.byte $00, $00
	.byte $06, $E8	; 6, -24
	.byte $0C, $00	; 12, 0
	.byte $0C, $00	; 12, 0
	.byte $0C, $00	; 12, 0
	.byte $08, $00	; 8, 0
	.byte $08, $00	; 8, 0
	.byte $08, $00	; 8, 0
	.byte $06, $00	; 6, 0
	.byte $06, $00	; 6, 0
	.byte $06, $00	; 6, 0
	.byte $04, $00	; 4, 0
	.byte $04, $00	; 4, 0
	.byte $04, $00	; 4, 0
	.byte $04, $18	; 4, 24
	.byte $80

; ----------------

	@torpedo:
	.byte $00, $00
	.byte $00, $00
	.byte $06, $E8	; 6, -24
	.byte $08, $00	; 8, 0
	.byte $0C, $00	; 12, 0
	.byte $0C, $00	; 12, 0
	.byte $0C, $00	; 12, 0
	.byte $0C, $00	; 12, 0
	.byte $0C, $00	; 12, 0
	.byte $08, $00	; 8, 0
	.byte $08, $00	; 8, 0
	.byte $08, $E8	; 8, -24
	.byte $F8, $E8	; -8, -24
	.byte $F4, $18	; -12, 24
	.byte $F6, $18	; -10, 24
	.byte $F8, $18	; -8, 24
	.byte $80

; ----------------

; Knockback / airborne hit
	@knockback_19_frames:
	.byte $F0, $F4	; -16, -12
	.byte $F2, $F6	; -14, -10
	.byte $F4, $F8	; -12, -8
	.byte $F6, $FC	; -10, -4
	.byte $F8, $00	; -8, 0
	.byte $FC, $01	; -4, 1
	.byte $FC, $02	; -4, 2
	.byte $FC, $04	; -4, 4
	.byte $FE, $08	; -2, 8
	.byte $FE, $0A	; -2, 10
	.byte $FE, $0C	; -2, 12
	.byte $FE, $0E	; -2, 14
	.byte $FE, $10	; -2, 16
	.byte $00, $12	; 0, 18
	.byte $00, $14	; 0, 20
	.byte $00, $14	; 0, 20
	.byte $00, $14	; 0, 20
	.byte $00, $14	; 0, 20
	.byte $00, $14	; 0, 20
	.byte $80

; ----------------

	@rom_DC8D:
	.byte $F6, $F8, $F8, $FA, $FA, $FC, $FC, $FE
	.byte $FE, $02, $FF, $04, $00, $06, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $80

; ----------------

	@rom_DCA8:
	.byte $00, $00, $0A, $F8, $F6, $00, $00, $00
	.byte $F6, $08, $0A, $00, $F6, $08, $00, $00
	.byte $F6, $F8, $F8, $FA, $FA, $FC, $FC, $FE
	.byte $FE, $02, $FF, $04, $00, $06, $00, $08
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $80

; ----------------

	@rom_DCD3_unused:
	;.byte $F6, $F8, $F8, $FA, $FA, $FC, $FC, $FE
	;.byte $FE, $02, $FF, $04, $00, $06, $00, $00
	;.byte $00, $00, $00, $00, $00, $00, $00, $00
	;.byte $00, $00, $80
	.byte $80

; ----------------

	@rom_DCEE:
	.byte $00, $00, $0A, $F8, $F6, $00, $00, $00
	.byte $F6, $08, $0A, $00, $F6, $00, $00, $00
	.byte $F6, $F8, $F8, $FA, $FA, $FC, $FC, $FE
	.byte $FE, $02, $FF, $04, $00, $06, $00, $08
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $80

; ----------------

	@rom_DD19:
	.byte $00, $00, $00, $00, $0A, $F8, $F6, $00
	.byte $00, $00, $F6, $08, $00, $00, $F6, $00
	.byte $00, $00, $F6, $F8, $F8, $FA, $FA, $FC
	.byte $FC, $FE, $FE, $02, $FF, $04, $00, $06
	.byte $00, $08, $00, $08, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $80

; ----------------

	@rom_DD46:
	.byte $00, $EC, $00, $F1, $00, $F6, $00, $0A
	.byte $00, $0F, $00, $14, $80

; ----------------

	@rom_DD53:
	.byte $00, $F4, $00, $F6, $00, $F8, $00, $FA
	.byte $00, $FC, $00, $04, $00, $06, $00, $08
	.byte $00, $0A, $00, $0C, $80

; ----------------

	@rom_DD68:
	.byte $00, $EE, $00, $F0, $FF, $F2, $FE, $F4
	.byte $FD, $F6, $FC, $F8, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $F8, $08, $F9, $0A
	.byte $FA, $0C, $FB, $0E, $FC, $10, $FD, $12
	.byte $80

; ----------------

;@rom_DD89:
;	.byte $00, $00, $00, $00, $00, $EA, $0A, $EC
;	.byte $19, $F8, $F0, $FA, $F1, $FC, $F2, $FE
;	.byte $F3, $02, $F4, $04, $F5, $06, $F6, $08
;	.byte $F7, $0A, $F8, $0E, $F9, $12, $80

; ----------------

	@rom_DDA8:
	.byte $00, $00, $00, $00, $2A, $00, $00, $F0
	.byte $00, $00, $00, $00, $00, $F4, $00, $00
	.byte $2A, $00, $00, $00, $00, $14, $00, $00
	.byte $80

; ----------------

	@rom_DDC1:
	.byte $00, $00, $80

; ----------------

	@rom_DDC2:
	.byte $00, $F6, $00, $F8, $00, $FA, $00, $FC
	.byte $06, $00, $06, $00, $06, $00, $06, $00
	.byte $06, $00, $06, $00, $06, $00, $06, $00
	.byte $06, $00, $06, $00, $06, $00, $06, $00
	.byte $06, $00, $06, $00, $06, $00, $06, $00
	.byte $06, $00, $06, $00, $06, $00, $06, $00
	.byte $06, $00, $06, $00, $06, $00, $06, $00
	.byte $00, $04, $00, $06, $00, $08, $00, $0A
	.byte $80

; ----------------

	@rom_DE03:
	.byte $00, $00, $80

; ----------------

;@special_hit_16_frames:
;	.byte $00, $00, $80

; ----------------

	@rom_DE05:
	.byte $00, $00, $00, $00, $14, $00, $0F, $00
	.byte $0A, $00, $05, $00, $80

; ----------------

	@rom_DE12:
	.byte $00, $EC, $02, $F6, $04, $F6, $06, $00
	.byte $08, $00, $14, $00, $14, $00, $14, $00
	.byte $14, $00, $08, $00, $06, $00, $04, $0A
	.byte $02, $0A, $00, $14, $80

; ----------------

	@rom_DE2F:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $14, $00, $0F, $00, $0A, $00, $05, $00
	.byte $80

; ----------------

	@rom_DE48:
	.byte $01, $00, $02, $00, $03, $00, $04, $00
	.byte $05, $00, $06, $00, $07, $00, $08, $00
	.byte $08, $00, $08, $00, $08, $00, $08, $00
	.byte $08, $00, $08, $00, $08, $00, $08, $00
	.byte $08, $00, $08, $00, $80

; ----------------

	@knocked_up_21_frames:
	.byte $00, $F0	; -0, -16
	.byte $FF, $F0	; -1, -16
	.byte $FE, $F0	; -2, -16
	.byte $FE, $F0	; -2, -16
	.byte $FE, $F2	; -2, -14
	.byte $FE, $F4	; -2, -12
	.byte $FE, $F6	; -2, -10
	.byte $FE, $F8	; -2, -8
	.byte $FE, $FC	; -2, -4
	.byte $FC, $00	; -4, 0
	.byte $FE, $01	; -2, 1
	.byte $FE, $02	; -2, 2
	.byte $FE, $04	; -2, 4
	.byte $FE, $08	; -2, 8
	.byte $FE, $0A	; -2, 10
	.byte $FE, $0C	; -2, 12
	.byte $FE, $0E	; -2, 14
	.byte $FE, $10	; -2, 16
	.byte $00, $12	; 0, 18
	.byte $00, $14	; 0, 20
	.byte $00, $16	; 0, 22

	; This was unused
	;.byte $02, $EE, $02, $F0, $02, $F2, $02, $F4
	;.byte $04, $F6, $06, $F8, $08, $FA, $0A, $FC
	;.byte $0A, $04, $08, $06, $08, $08, $08, $0A
	;.byte $08, $0C, $08, $0E, $08, $10, $08, $12
	.byte $80

; ----------------

	@rom_DE8E:
	.byte $01, $00, $01, $00, $01, $00, $01, $00
	.byte $FF, $00, $FF, $00, $FF, $00, $FF, $00
	.byte $80

; ----------------

	@thrown:
	.byte $00, $00
	.byte $00, $00
	.byte $10, $00
	.byte $20, $F0
	.byte $00, $00
	.byte $10, $00
	.byte $20, $F4
	.byte $00, $00
	.byte $10, $00
	.byte $08, $00
	.byte $06, $14
	.byte $04, $00
	.byte $80

; ----------------

	@throw_move:
	.byte $F0, $00
	.byte $00, $00
	.byte $00, $00
	.byte $00, $00
	.byte $00, $00
	.byte $00, $00
	.byte $00, $00
	.byte $00, $00
	.byte $00, $00
	.byte $00, $00
	.byte $00, $00
	.byte $00, $00
	.byte $80

; ----------------

	@rom_DECD:
	.byte $00, $00, $00, $00, $06, $00, $06, $00
	.byte $06, $00, $06, $00, $06, $00, $06, $00
	.byte $06, $00, $06, $00, $06, $00, $06, $00
	.byte $04, $00, $04, $00, $04, $00, $04, $00
	.byte $80

; ----------------

	@rom_DEEE:
	.byte $00, $00, $00, $00, $06, $FC, $0C, $00
	.byte $0C, $00, $0C, $00, $08, $00, $08, $00
	.byte $08, $00, $06, $00, $06, $00, $06, $00
	.byte $04, $00, $04, $00, $04, $00, $04, $04
	.byte $80

; ----------------

	@scorpion_teleport:
	.byte $08, $F8, $08, $F8, $08, $F8, $08, $F8
	.byte $08, $00, $08, $00, $08, $00, $08, $00
	.byte $08, $00, $08, $00, $08, $00, $08, $00
	.byte $08, $08, $08, $08, $08, $08, $08, $08
	.byte $80

; -----------------------------------------------------------------------------
