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
	.word sub_rom_C284	; Substate 9	Back to main menu?

; -----------------------------------------------------------------------------

sub_match_loop:
	lda zp_plr1_fighter_idx
	and #$80
	beq @C12E

	lda #$00
	sta zp_controller1
	sta zp_controller1_new
	@C12E:
	lda zp_plr2_fighter_idx
	and #$80
	beq @C13A

	lda #$00
	sta zp_controller2
	sta zp_controller2_new
	@C13A:
	jsr sub_calc_players_distance
	jsr sub_check_fighter_ko
	jsr sub_rom_CA5C

	; Bank $03 in $A000-$BFFF
	;lda #$87
	;sta zp_prg_bank_select_backup
	;sta mmc3_bank_select
	;lda #$03
	;sta mmc3_bank_data
	;jsr sub_rom_03_A5E4
	;jsr sub_rom_03_A000
	jsr sub_call_gfx_routines

	lda zp_94
	cmp zp_92
	bcs @C15E

		; Determine winner
		jsr sub_rom_CD19 ;sub_rom_CCA8
	@C15E:
	inc zp_23
	jsr sub_rom_CC9A
	bcc @C177

	jsr sub_rom_CCAC
	jsr sub_rom_D09F
	jsr sub_rom_CA9D
	
	;jsr sub_rom_D76D
	jsr sub_load_fighter_sprite_data
	jsr sub_rom_D20A
	
	jsr sub_rom_D02F
	jsr sub_rom_C9EC
	@C177:
	jmp sub_rom_C29E ;jsr sub_rom_C29E
	;rts

; -----------------------------------------------------------------------------

sub_match_hit:
	jsr sub_match_hit_loop
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
	jsr sub_rom_CD34	; Score calculation based on remaining time

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
		
	; Determine winner based on damagetaken
	@C1AF:
	ldy #$00
	ldx #$00
	lda zp_plr1_damage
	cmp zp_plr2_damage
	bcc @C1C3	; Branch if player 1 wins

		beq @victory_end	; Branch if same health

			lda ram_040F

			beq @victory_end

				iny		; Player 2 wins
				ldx #$03
	@C1C3:
	sty zp_7C	; Index of winning player
	stx zp_7B
	
	lda zp_counter_param
	beq :+
		jsr sub_announce_winner_name
	:

	jsr sub_clear_score_display

	ldx zp_7B
	lda #$01
	sta zp_05
	lda #$00
	sta zp_06
	jsr sub_update_score_display

	lda zp_7C
	eor #$01
	sta zp_7C
	lda zp_7B
	eor #$03
	tax
	stx zp_7B
	jsr sub_rom_C6E2
	; jsr sub_rom_C6BA this is just a rts

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
	inc zp_game_substate
	rts

; -----------------------------------------------------------------------------

sub_announce_winner_name:
	inc zp_counter_param
	lda zp_counter_param
	cmp #$14
	bne @wait_for_name
		
		; Announce name after 20 frames
		ldx zp_7C	; Winner index
		lda zp_plr1_fgtr_idx_clean,X
		cmp #$06	; Skip Goro and Shang-Tsung
		bcs @winner_name_rts

			clc
			adc #$11
			sta ram_req_sfx
			rts

	@wait_for_name:
	cmp #$54
	bne @winner_name_rts

		; Time to say "wins"
		lda #$18
		sta ram_req_sfx
		lda #$00
		sta zp_counter_param

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
	sty zp_7C
	jsr sub_rom_C2A8
	iny
	sty zp_7C

; -----------------------------------------------------------------------------

sub_rom_C2A8:
	lda zp_4C,Y
	bpl @C2C4

	cmp #$F0
	bcs @C2BF

	lda #$03
	and zp_frame_counter
	bne @C2C4

	ldx zp_4C,Y
	inx
	stx zp_4C,Y
	jmp @C2C4

	@C2BF:
	lda #$00
	sta zp_4C,Y
	@C2C4:
	lda #$1E
	cmp zp_plr1_cur_anim,Y

	beq @C2CC
	@C2CB:
	rts
; ----------------
	@C2CC:
	lda zp_plr1_anim_frame,Y
	cmp #$05
	bcc @C2CB
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
	lda rom_C3BD,X
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
	jsr sub_rom_C36B
	ldy zp_ptr2_lo
	tya
	iny
	and #$03
	cmp #$03
	bne @C33D

	jsr sub_rom_C3F9
	lda #$FD
	ldy zp_7C
	ldx zp_plr1_facing_dir,Y
	bne @C357

	lda #$03
	@C357:
	clc
	adc ram_ranged_atk_x_pos,Y
	sta ram_ranged_atk_x_pos,Y
	rts

; ----------------

	@rom_C35F:
	.byte $20, $18, $18, $20, $00, $20, $20, $28
	.byte $28, $20, $00, $18

; -----------------------------------------------------------------------------

sub_rom_C36B:
	sty zp_ptr2_lo
	lda rom_C3C9,Y
	bmi @C397

		ora zp_ptr1_lo
		sta ram_0371,X
		lda zp_05
		sta ram_0373,X
		lda zp_06
		sta ram_0370,X
		ldy zp_7C
		lda zp_plr1_facing_dir,Y
		tay
		lda zp_7C
		asl A
		cpy #$00
		beq :+
			ora #$40
		:
		sta ram_0372,X
		dex
		dex
		dex
		dex

	@C397:
	ldy zp_7C
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

rom_C3BD:
	.byte $9C, $98, $9C, $9C, $9C, $9C, $9C, $9C
	.byte $A1, $9C, $9C, $A6

; -----------------------------------------------------------------------------

rom_C3C9:
	.byte $7A, $7B, $72, $73
	.byte $77, $78, $79, $7A, $6F, $70, $71, $72
	.byte $1F, $20, $FF, $FF, $74, $75, $7A, $FF
	.byte $77, $78, $FF, $FF, $67, $68, $FF, $FF
	.byte $75, $76, $FF, $FF, $3E, $3F, $FF, $FF
	.byte $7D, $FF, $7E, $FF, $74, $76, $FF, $78
	.byte $03, $04, $05, $06

; -----------------------------------------------------------------------------

sub_rom_C3F9:
	ldy zp_7C
	lda zp_plr1_fgtr_idx_clean,Y
	jsr sub_game_trampoline
; ----------------
	.word sub_rom_C419
	.word sub_rom_C419
	.word sub_rom_C419
	.word sub_rom_C419
	.word sub_rom_C4B2
	.word sub_rom_C419
	.word sub_rom_C419
	.word sub_rom_C419
	.word sub_rom_C419
	.word sub_rom_C419
	.word sub_rom_C419
	.word sub_rom_C419

; -----------------------------------------------------------------------------

sub_rom_C419:
	rts

; -----------------------------------------------------------------------------

sub_rom_C4B2:
	ldy zp_7C
	lda zp_frame_counter
	and #$04
	bne :+
		rts
; ----------------
	:
	ldx tbl_player_oam_offsets,Y
	lda ram_037C,X
	clc
	adc #$08
	sta ram_037C,X
	lda ram_0378,X
	clc
	adc #$08
	sta ram_0378,X
	lda ram_0374,X
	sec
	sbc #$08
	sta ram_0374,X
	lda ram_0370,X
	sec
	sbc #$08
	sta ram_0370,X
	lda zp_plr1_facing_dir,Y
	bne @C4EF

	lda #$10
	sta zp_16
	lda #$08
	bne @C4F5

	@C4EF:
	lda #$F0
	sta zp_16
	lda #$F8

	@C4F5:
	sta zp_ptr2_lo
	lda ram_037F,X
	clc
	adc zp_ptr2_lo
	clc
	adc zp_16
	sta ram_037F,X
	lda ram_037B,X
	sec
	sbc zp_ptr2_lo
	clc
	adc zp_16
	sta ram_037B,X
	lda ram_0377,X
	clc
	adc zp_ptr2_lo
	clc
	adc zp_16
	sta ram_0377,X
	lda ram_0373,X
	sec
	sbc zp_ptr2_lo
	clc
	adc zp_16
	sta ram_0373,X
	lda ram_0372,X
	eor #$C0
	sta ram_0372,X
	lda ram_0376,X
	eor #$C0
	sta ram_0376,X
	lda ram_037A,X
	eor #$C0
	sta ram_037A,X
	lda ram_037E,X
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
	bne @C55B

	@C558:
	sec
	sbc zp_plr1_x_pos,X
	@C55B:
	rts

; -----------------------------------------------------------------------------

sub_rom_C572:
	lda zp_plr1_cur_anim,X
	cmp #$1E	; Parry animation (opponent)
	bne @C581

	lda zp_plr1_cur_anim,Y
	cmp #$1E	; Parry animation (attacker)
	beq @C58C

	bne @C5A2

	@C581:
	cmp #$0D
	bne @C5A2

	lda zp_plr1_cur_anim,Y
	cmp #$0D
	bne @C5A2

	@C58C:
	lda zp_plr1_anim_frame,X
	cmp #$05
	bcc @C5A2

	lda ram_ranged_atk_x_pos,X
	cmp ram_ranged_atk_x_pos,Y
	bcc @C5A4

	sec
	sbc ram_ranged_atk_x_pos,Y
	@C59E:
	cmp #$08
	bcc @C5AD

	@C5A2:
	clc
	rts
; ----------------
	@C5A4:
	lda ram_ranged_atk_x_pos,Y
	sec
	sbc ram_ranged_atk_x_pos,X
	bne @C59E
	
	@C5AD:
	lda #$00
	sec
	rts

; -----------------------------------------------------------------------------

; Parameters:
; Y = index of player launching the attack (0 for player one, 1 for player two)
; NOTE: Does NOT return to called. It pulls from the stack to go back to
; 		caller's caller.
sub_ranged_attack:
	tya
	eor #$01	; Sets X = !Y (This might be unnecessary, because it was already
	tax			; 				done before the call)
	jsr sub_rom_C572
	bcs @player_hit_anim

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
	beq @ranged_atk_return

	cmp #$2B	; Already parried (crouching)
	beq @C60D

	cmp #$2C	; Already hit (recovering)
	beq @C60D

	cmp #$02	; ???
	beq @C5FF

	cmp #$05	; Parry
	beq @C5FB

	lda #$01	; Start the counter
	sta zp_player_hit_counter

	lda #$08
	sta zp_plr1_dmg_counter,X	; Opponent
	lda #$03
	sta zp_gained_score_idx,Y	; Attacker

	; TODO Special ranged attacks (Scorpion / Sub-Zero)

	; Check if a player was hit whilst airborne
	lda zp_plr1_y_pos,X
	cmp zp_sprites_base_y
	bne @C5F7

	lda #$30	; Airborne hit
	bne @player_hit_anim

	@C5F7:
	lda #$2E	; Strong hit knockback
	bne @player_hit_anim

	@C5FB:
	lda #$2C	; Standing parry
	bne @player_hit_anim

	@C5FF:
	lda #$2B	; Crouched parry

	@player_hit_anim:
	sta zp_plr1_cur_anim,X	; Oppoent
	lda #$00
	sta zp_plr1_anim_frame,X
	
	sta zp_plr1_cur_anim,Y	; Attacker
	sta zp_plr1_anim_frame,Y
	@C60D:
	pla
	pla
	@ranged_atk_return:
	rts

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
	lda zp_player_hit_counter
	cmp #$02
	beq sub_rom_C69C
		rts
; ----------------
sub_rom_C69C:
	jsr sub_clear_score_display
	ldy #$00
	sty zp_7C
	ldx #$00
	stx zp_7B
	jsr sub_rom_C6BB
	lda ram_040F
	beq sub_rom_C6BA
	inc zp_7C
	ldy zp_7C
	ldx #$03
	stx zp_7B
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
	
	ldx zp_7B
; ----------------
sub_update_score_display:
	clc
	lda ram_0403,X
	adc zp_05
	sta ram_0403,X
	lda ram_0404,X
	adc zp_06
	sta ram_0404,X
	bcc sub_rom_C6E2

		inc ram_0405,X
; ----------------
sub_rom_C6E2:
	lda ram_0403,X
	sta zp_07
	lda ram_0404,X
	sta zp_08
	lda ram_0405,X
	sta zp_09
	lda #$B0
	sta zp_0D
	jsr sub_rom_CD56
	ldy zp_7C
	ldx rom_C76A,Y
	ldy #$04

	@C6FF:
	lda ram_066D,Y
	sta ram_ppu_data_buffer,X
	inx
	dey
	bpl @C6FF

	ldy zp_7C
	ldx rom_C76A,Y
	jsr sub_rom_C789
	ldx zp_7B
	txa
	eor #$03
	tay
	lda ram_0405,Y
	cmp ram_0405,X
	bcc @C733
	bne @C75F

	lda ram_0404,Y
	cmp ram_0404,X
	bcc @C733
	bne @C75F

	lda ram_0403,Y
	cmp ram_0403,X
	bcs @C75F

	@C733:
	lda ram_0405,X
	cmp ram_040B
	bcc @C75F

	lda ram_0404,X
	cmp ram_040A
	bcc @C75F

	bne @C74D

	lda ram_0409
	cmp ram_0403,X
	bcs @C75F

	@C74D:
	lda ram_0403,X
	sta ram_0409
	lda ram_0404,X
	sta ram_040A
	lda ram_0405,X
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
	lda zp_player_hit_counter
	cmp #$0F
	bcc :+

		lda #$00
		sta zp_gained_score_idx
		sta zp_F0
		sta zp_player_hit_counter
		dec zp_game_substate	 ; Back to match main loop
		rts
; ----------------
	:
	inc zp_player_hit_counter
	rts

; -----------------------------------------------------------------------------

sub_check_fighter_ko:
	lda #$58
	cmp zp_plr1_damage
	beq @C7BA

	cmp zp_plr2_damage
	bne @C7BB

	@C7BA:
	rts
; ----------------
	@C7BB:
	ldx #$00
	stx zp_7C
	jsr sub_rom_C7C6
	inc zp_7C
	ldx zp_7C
; ----------------
sub_rom_C7C6:
	lda zp_plr1_cur_anim,X
	cmp #$28
	beq @C800

	lda zp_plr1_fgtr_idx_clean,X
	asl A
	clc
	adc zp_plr1_fgtr_idx_clean,X
	tay
	sty ram_0422
	lda rom_C801,Y
	bmi @C7E1

	sta ram_043D
	jsr sub_rom_C825
	@C7E1:
	ldy ram_0422
	iny
	lda rom_C801,Y
	bmi @C7F0

	sta ram_043D
	jsr sub_rom_C82C
	@C7F0:
	ldy ram_0422
	iny
	iny
	lda rom_C801,Y
	bmi @C800

	sta ram_043D
	jsr sub_rom_C833
	@C800:
	rts

; -----------------------------------------------------------------------------

rom_C801:
	.byte $00, $01, $02, $03, $04, $05, $06, $07
	.byte $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
	.byte $10, $11, $12, $13, $14, $FF, $16, $FF
	.byte $FF, $19, $FF, $1B, $1C, $1D, $1E, $1F
	.byte $FF, $06, $07, $08

; -----------------------------------------------------------------------------

sub_rom_C825:
	lda #$0D
	sta ram_043E
	bne sub_rom_C838
; ----------------
sub_rom_C82C:
	lda #$1E
	sta ram_043E
	bne sub_rom_C838
; ----------------
sub_rom_C833:
	lda #$17
	sta ram_043E
; ----------------
sub_rom_C838:
	ldx zp_7C
	lda zp_plr1_y_pos,X
	cmp zp_sprites_base_y
	bne @C875

	lda ram_043D
	bne @C84B

	lda zp_controller1,X
	and #$04	; Button down?
	bne @C875

	@C84B:
	jsr sub_rom_C876
	ldy zp_7C
	lda ram_043E
	cmp #$1E
	bne @C86A

	lda zp_4C,Y
	bmi @C875

	ldx zp_4C,Y
	inx
	stx zp_4C,Y
	cpx #$02
	bcc @C86A

	lda #$80
	sta zp_4C,Y
	@C86A:
	lda ram_043E
	cmp zp_plr1_cur_anim,Y
	beq @C875

		jsr sub_change_fighter_anim

	@C875:
	rts

; -----------------------------------------------------------------------------

sub_rom_C876:
	lda ram_043D
	asl A
	tay
	lda tbl_ctrl_move_ptrs+0,Y
	sta zp_ptr3_lo
	lda tbl_ctrl_move_ptrs+1,Y
	sta zp_ptr3_hi
	ldx ram_043D
	lda rom_C8D5,X
	clc
	adc zp_7C
	tax
	stx zp_7B
	lda zp_A9,X
	sta zp_ptr1_lo
	inc zp_ptr1_lo
	ldx zp_7C
	lda zp_plr1_facing_dir,X
	tay
	lda zp_controller1_new,X
	beq @C8BC

	cpy #$00
	beq @C8B0

	and #$03	; Left/right
	bne @C8AC

	lda zp_controller1_new,X
	bne @C8B0

	@C8AC:
	lda zp_controller1_new,X
	eor #$03	; Flip left/right bits
	@C8B0:
	ldy zp_ptr1_lo
	ldx zp_7B
	cmp (zp_ptr3_lo),Y
	beq @C8C2

	lda #$00
	sta zp_A9,X
	@C8BC:
	jsr sub_rom_C8F9
	pla
	pla
	rts
; ----------------
	@C8C2:
	inc zp_A9,X
	lda #$00
	sta zp_BD,X
	lda zp_A9,X
	ldy #$00
	cmp (zp_ptr3_lo),Y
	bcc @C8BC

	lda #$00
	sta zp_A9,X
	rts

; -----------------------------------------------------------------------------

rom_C8D5:
	.byte $00, $02, $04, $00, $02, $04, $00, $02
	.byte $04, $00, $02, $04, $00, $02, $04, $00
	.byte $02, $04, $00, $02, $04, $00, $02, $04
	.byte $00, $02, $04, $00, $02, $04, $00, $02
	.byte $04, $00, $02, $04

; -----------------------------------------------------------------------------

sub_rom_C8F9:
	ldx zp_7B
	lda zp_BD,X
	cmp #$0F
	bcc @C911

	lda #$00
	sta zp_BD,X
	lda zp_A9,X
	cmp zp_D1,X
	bne @C90F
	
	lda #$00
	sta zp_A9,X
	@C90F:
	sta zp_D1,X
	@C911:
	inc zp_BD,X
	rts

; -----------------------------------------------------------------------------

tbl_ctrl_move_ptrs:
	.word rom_C95C, tbl_move_fireball, rom_C967
	.word rom_C96B, rom_C96F, tbl_move_fireball
	.word rom_C977, rom_C97B, rom_C97F
	.word tbl_move_fireball, rom_C987, rom_C98B
	.word tbl_move_fireball, rom_C993, rom_C997
	.word rom_C99B, rom_C9A2, tbl_move_fireball
	.word rom_C9AA, rom_C9AE, rom_C9B2
	.word rom_C9B6, tbl_move_fireball, rom_C9BE
	.word rom_C9C2, tbl_move_fireball, rom_C9CA
	; Potentially unused
	.word rom_C95C, tbl_move_fireball, rom_C967 ;.word rom_C9CE, rom_C9D5, rom_C9D9
	.word rom_C96B, rom_C96F, tbl_move_fireball ;.word rom_C9DD, rom_C9E4, rom_C9E8
	.word rom_C977, rom_C97B, rom_C97F

; -----------------------------------------------------------------------------
; Data format: length, controller masks

; Rayden's "turbo roundhouse" (B x 6)
rom_C95C:
	.byte $06, $40, $40, $40, $40, $40, $40
; Rayden's "fireball" (Bck, Fwd, A)
tbl_move_fireball:
	.byte $03, $02, $01, $80
; Rayden's "superman" (Dn, Up, B)
rom_C967:
	.byte $03, $04, $08, $40

; Sonya
rom_C96B:
	.byte $03, $02, $01, $40
rom_C96F:
	.byte $03, $04, $01, $80
;rom_C973:
;	.byte $03, $02, $01, $80

; Sub-Zero
rom_C977:
	.byte $03, $04, $02, $40
rom_C97B:
	.byte $03, $04, $01, $80
rom_C97F:
	.byte $03, $01, $04, $80

; Scorpion
;rom_C983:
;	.byte $03, $02, $01, $80
rom_C987:
	.byte $03, $04, $01, $80
rom_C98B:
	.byte $03, $04, $08, $80

; Kano
;rom_C98F:
;	.byte $03, $02, $01, $80
rom_C993:
	.byte $03, $04, $01, $80
rom_C997:
	.byte $03, $04, $08, $40

; Johnny Cage
rom_C99B:
	.byte $06, $80, $80, $80, $80, $80, $80
rom_C9A2:
	.byte $03, $01, $04, $80
;rom_C9A6:
;	.byte $03, $02, $01, $80

; Liu Kang
rom_C9AA:
	.byte $03, $04, $01, $40
rom_C9AE:
	.byte $03, $04, $01, $80
rom_C9B2:
	.byte $03, $01, $04, $80

; Goro
rom_C9B6:
	.byte $03, $02, $10, $80
;rom_C9BA:
;	.byte $03, $02, $01, $80
rom_C9BE:
	.byte $03, $02, $10, $80

; Shang-Tsung
rom_C9C2:
	.byte $03, $02, $10, $80
;rom_C9C6:
;	.byte $03, $02, $01, $80
rom_C9CA:
	.byte $03, $02, $10, $80

; Unused 0
;rom_C9CE:
;	.byte $06, $80, $80, $80, $80, $80, $80
;rom_C9D5:
;	.byte $03, $02, $01, $40
;rom_C9D9:
;	.byte $03, $01, $04, $80

; Unused 1
;rom_C9DD:
;	.byte $06, $80, $80, $80, $80, $80, $80
;rom_C9E4:
;	.byte $03, $01, $04, $80
;rom_C9E8:
;	.byte $03, $04, $01, $80

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

	lda #$01	; The match end state will use this to sync DPCM sample playback
	sta zp_counter_param

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
; Saves Y in zp_8C
; Parameters:
; zp_7C = player index (0 for player one, 1 for player 2)
; A = new animation index
sub_change_fighter_anim:
	ldy zp_7C
	sta zp_plr1_cur_anim,Y
	lda #$00
	sta zp_plr1_anim_frame,Y
	sty zp_8C
	rts

; -----------------------------------------------------------------------------

sub_rom_CA5C:
	ldy #$00
	sty zp_7C
	jsr sub_rom_CA66
	iny
	sty zp_7C

; -----------------------------------------------------------------------------

sub_rom_CA66:
	lda #$58
	cmp zp_plr1_damage
	beq @CA70

	cmp zp_plr2_damage
	bne @CA7C

	@CA70:
	ldy #$01
	@CA72:
	ldx #$68
	@CA74:
	dex
	bne @CA74

	dey
	bne @CA72

	beq @CA94

	@CA7C:
	jsr sub_rom_D164
	jsr sub_rom_CC36
	jsr sub_rom_CBC7
	jsr sub_rom_CBFC
	jsr sub_rom_D1B6
	jsr sub_rom_D0E1
	jsr sub_rom_D129
	jsr sub_rom_CAC0
	@CA94:
	ldy zp_7C
	jsr sub_rom_CB0C
	jmp sub_rom_CB7F ;jsr sub_rom_CB7F
	;rts

; -----------------------------------------------------------------------------

sub_rom_CA9D:
	ldx #$00
	jsr sub_rom_CAA3
	inx

; -----------------------------------------------------------------------------

sub_rom_CAA3:
	lda zp_consecutive_hits_taken,X
	cmp #$03
	bcs @CABF

	lda zp_plr1_cur_anim,X
	cmp #$09
	beq @CAB3

	cmp #$0A
	bne @CABF

	@CAB3:
	lda zp_plr1_anim_frame,X
	cmp #$01
	bne @CABF

	inc zp_consecutive_hits_taken,X
	lda #$00
	sta zp_E9,X
	@CABF:
	rts

; -----------------------------------------------------------------------------

sub_rom_CAC0:
	ldy zp_7C
	lda zp_consecutive_hits_taken,Y
	cmp #$03
	bcc @CAE4

	lda zp_plr1_cur_anim,Y
	cmp #$27
	bne @CAE4

	lda zp_plr1_anim_frame,Y
	cmp #$01
	bne @CAE4

	lda #$28	; Staggered animation
	sta zp_plr1_cur_anim,Y

	lda #$00
	sta zp_consecutive_hits_taken,Y
	sta zp_plr1_anim_frame,Y

	@CAE4:
	lda zp_E9,Y
	cmp #$70
	bcc @CB00

	lda #$00
	sta zp_E9,Y
	lda zp_consecutive_hits_taken,Y
	cmp zp_E7,Y
	bne @CAFD

	lda #$00
	sta zp_consecutive_hits_taken,Y
	@CAFD:
	sta zp_E7,Y
	@CB00:
	lda zp_E9,Y
	clc
	adc #$01
	sta zp_E9,Y
	rts

; -----------------------------------------------------------------------------

tbl_player_oam_offsets:
	.byte $00	; Player 1 (starting at sprite $00)
	.byte $80	; Player 2 (starting at sprite $20 [32 decimal])

; -----------------------------------------------------------------------------

sub_rom_CB0C:
	lda zp_plr1_cur_anim,Y
	cmp #$2E
	beq @CB1B

	; Return if < $30 and >= $33
	cmp #$30	
	bcc @CB7E

	cmp #$33
	bcs @CB7E

	@CB1B:
	; Only reached if animation is $2E, $31 or $32
	lda #$06
	cmp zp_plr1_anim_frame,Y
	bcs @CB7E

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
	bcc @CB7E

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
	rts
; ----------------
	@CB5A:
	lda zp_sprites_base_y
	sec
	sbc #$1A
	sta zp_ptr1_lo
	lda zp_plr1_y_pos,Y
	cmp zp_ptr1_lo
	bcc @CB7E

		lda #$02
		sta zp_92
		lda #$26	; Fall on back
		sta zp_plr1_cur_anim,Y
		lda #$00
		sta zp_plr1_anim_frame,Y
		lda zp_sprites_base_y
		clc
		adc #$08
		sta zp_plr1_y_pos,Y
	
	@CB7E:
	rts

; -----------------------------------------------------------------------------

sub_rom_CB7F:
	lda zp_plr1_cur_anim,Y
	cmp #$26	 ; Knocked out
	bne @CBC6

		lda zp_plr1_anim_frame,Y
		cmp #$0C
		bcc @CBC6

		ldx zp_plr1_damage,Y
		cpx #$58
		bcc @CBB7

		lda #$0B
		sta zp_plr1_anim_frame,Y
		tya
		eor #$01
		tax
		lda zp_plr1_anim_frame,X
		bne @CBC6

		lda #$2A	; Victory pose end
		sta zp_plr1_cur_anim,X
		lda zp_plr1_fgtr_idx_clean,X
		tay
		lda zp_sprites_base_y
		sta zp_plr1_y_pos,X
		lda zp_plr1_fighter_idx,X
		bmi @CBB3

		lda zp_4B
		bmi @CBB6

		@CBB3:
		inc ram_plr1_rounds_won,X
		@CBB6:
		rts
	; ----------------
		@CBB7:
		lda #$27		; Get up? Probably if the timer ran out and player was
		sta zp_plr1_cur_anim,Y	; knocked out, but with some health left

		lda #$00
		sta zp_plr1_anim_frame,Y

		lda zp_sprites_base_y
		sta zp_plr1_y_pos,Y
	@CBC6:
	rts

; -----------------------------------------------------------------------------

; Punch/kick during animation 6 (straight jump up)
; Parameters:
; Y = 0 for player one, 1 for player two
sub_rom_CBC7:
	lda zp_plr1_cur_anim,Y
	cmp #$06	; Upwards jump
	bne @CBFB

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
		beq @CBFB


		lda #$08	; Punch swing
		sta ram_req_sfx
		inx
		inx
		inx	; Animation $0B = base kick
		@CBED:
		lda zp_plr1_anim_frame,Y
		cmp #$07
		bcc @CBF5

			inx	; Animation $0C = Close up kick
		@CBF5:
		txa
		sta zp_plr1_cur_anim,Y
		sty zp_8C
	@CBFB:
	rts

; -----------------------------------------------------------------------------

; Punch/kick during animation 7 or 8 (forward or backwards jump)
; Parameters:
; Y = 0 for player one, 1 for player 2
sub_rom_CBFC:
	ldx #$19
	lda zp_plr1_cur_anim,Y
	cmp #$07
	beq @CC0B

	cmp #$08
	bne @CC35

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
	beq @CC35


	lda #$07	; Kick swing
	sta ram_req_sfx
	inx
	inx
	@CC27:
	lda zp_plr1_anim_frame,Y
	cmp #$07
	bcc @CC2F

	inx
	@CC2F:
	txa
	sta zp_plr1_cur_anim,Y
	sty zp_8C
	@CC35:
	rts

; -----------------------------------------------------------------------------

sub_rom_CC36:
	jsr sub_rom_D0D1
	lda zp_controller1,Y
	and #$04
	bne @CC5B

	lda zp_controller1_new,Y
	and #$40
	beq @CC4F

	jsr sub_rom_CC82
	@CC4A:
	txa
	jsr sub_change_fighter_anim
	rts
; ----------------
	@CC4F:
	lda zp_controller1_new,Y
	and #$80
	beq @CC5B

	jsr sub_rom_CC5C
	bne @CC4A

	@CC5B:
	rts

; -----------------------------------------------------------------------------

sub_rom_CC5C:
	lda zp_players_x_distance
	cmp #$1E
	bcs @CC7F

	lda #$01
	ldx zp_plr1_facing_dir,Y
	beq @CC6A

	lda #$02
	@CC6A:
	and zp_controller1,Y
	beq @CC7C

	tya
	eor #$01
	tax
	lda zp_plr1_y_pos,X
	cmp zp_sprites_base_y
	bne @CC7C

	ldx #$18
	rts
; ----------------
	@CC7C:
	ldx #$25
	rts
; ----------------
	@CC7F:
	ldx #$10
	rts

; -----------------------------------------------------------------------------

sub_rom_CC82:
	lda zp_players_x_distance
	cmp #$30
	bcs @CC97

	lda #$1B
	ldx zp_plr1_fgtr_idx_clean,Y
	bne @CC90

	lda #$1B
	@CC90:
	cmp zp_players_x_distance
	bcc @CC97

	ldx #$0C
	rts
; ----------------
	@CC97:
	ldx #$0B
	rts

; -----------------------------------------------------------------------------

sub_rom_CC9A:
	lda zp_94
	cmp zp_92
	bcc @CCA5

	lda #$00
	sta zp_94
	rts
; ----------------
	@CCA5:
	inc zp_94
	rts

; -----------------------------------------------------------------------------

; This was pointless
;sub_rom_CCA8:
;	jsr sub_rom_CD19
;	rts

; -----------------------------------------------------------------------------

sub_rom_CCAC:
	lda zp_player_hit_counter
	beq @CCC2

	cmp #$01
	bcc @CCC0

		lda #$02	; Hit SFX
		sta ram_req_sfx
		lda #$00
		sta zp_player_hit_counter
		inc zp_game_substate
		rts
; ----------------
	@CCC0:
	inc zp_player_hit_counter
	@CCC2:
	rts

; -----------------------------------------------------------------------------

sub_rom_CD19:
	jsr sub_rom_CD81
	lda #$58
	cmp zp_plr1_damage
	beq sub_rom_CD34
	cmp zp_plr2_damage
	beq sub_rom_CD34
	inc zp_A2
	lda zp_A2
	cmp #$2D
	bcc sub_rom_CD34
	lda #$00
	sta zp_A2
	dec zp_match_time
; ----------------
sub_rom_CD34:
	lda zp_match_time
	sta zp_07
	lda #$00
	sta zp_08
	sta zp_09
	sta zp_0D
	jsr sub_rom_D6C7
	lda ram_066E
	clc
	adc #$B0
	sta ram_063E
	lda ram_066D
	clc
	adc #$B0
	sta ram_063F
	rts

; -----------------------------------------------------------------------------

sub_rom_CD56:
	lda zp_09
	cmp #$01
	bcc @CD7D

	lda zp_08
	cmp #$86
	bcc @CD7D

	lda zp_07
	cmp #$9F
	bcc @CD7D

	lda #$01
	sta zp_07
	sta ram_0403,X
	lda #$86
	sta zp_08
	sta ram_0404,X
	lda #$9F
	sta zp_09
	sta ram_0405,X
	@CD7D:
	jmp sub_rom_D6C7;jsr sub_rom_D6C7
	;rts

; -----------------------------------------------------------------------------

sub_rom_CD81:
	lda ram_0411
	bne @CDD2

	lda zp_match_time
	bne @CDD4

	lda zp_sprites_base_y
	cmp zp_plr1_y_pos
	bne @CDD2

	cmp zp_plr2_y_pos
	bne @CDD2

	lda zp_plr1_damage
	cmp zp_plr2_damage
	bcc @CDA5

	bne @CDB7

	lda #$29
	sta zp_plr1_cur_anim
	sta zp_plr2_cur_anim
	jmp @CDC7

	@CDA5:
	ldx zp_plr1_fgtr_idx_clean
	lda zp_sprites_base_y
	sta zp_plr1_y_pos
	ldx #$2A
	stx zp_plr1_cur_anim
	dex
	stx zp_plr2_cur_anim
	inc ram_plr1_rounds_won
	bne @CDC7

	@CDB7:
	ldx zp_plr2_fgtr_idx_clean
	lda zp_sprites_base_y
	sta zp_plr2_y_pos
	ldx #$29
	stx zp_plr1_cur_anim
	inx
	stx zp_plr2_cur_anim
	inc ram_plr2_rounds_won
	@CDC7:
	lda #$00
	sta zp_plr1_anim_frame
	sta zp_plr2_anim_frame
	lda #$01
	sta ram_0411
	@CDD2:
	pla
	pla
	@CDD4:
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
	.word str_name_rayden
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
	.word str_name_rayden
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
; TODO: Probably safe to use ASCII, otherwise custom encoding
str_name_rayden:
	.byte $06, $52, $41, $59, $44, $45, $4E
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

sub_calc_players_distance:
	lda zp_plr1_x_pos
	cmp zp_plr2_x_pos
	bcs @CF2C

	lda zp_plr2_x_pos
	sec
	sbc zp_plr1_x_pos
	bne @CF2F

	@CF2C:
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
	lda #$1C
	sta ram_067E
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
	sta zp_92
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
	sta zp_plr1_spr_x_offset
	sta zp_plr2_spr_x_offset
	sta zp_plr1_facing_dir
	sta zp_plr1_damage
	sta zp_plr2_damage
	sta zp_plr1_dmg_counter
	sta zp_plr2_dmg_counter
	sta zp_consecutive_hits_taken
	sta zp_E6
	sta zp_7F
	sta ram_0411
	sta zp_4C
	sta zp_4D

	lda #$40
	sta zp_irq_hor_scroll
	sta ram_0414

	lda #$01
	sta zp_plr2_facing_dir

	lda #$90
	sta zp_82

	lda #$F0
	sta zp_84
	lda zp_sprites_base_y
	sta zp_plr1_y_pos
	sta zp_plr2_y_pos
	sta zp_F4
	sta zp_F5

	lda #$00
	tax
	:
		sta zp_A9,X
	inx
	cpx #$3C
	bcc :-

	jsr sub_rebase_fighter_indices
	jsr sub_load_fighter_sprite_data
	jsr sub_rom_D20A
	
	; Put bank 0 back in after loading sprite data
	lda #$80
	sta zp_bank_select_mask

	lda #$86
	sta mmc3_bank_select
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

sub_rom_D02F:
	lda zp_plr1_cur_anim
	cmp #$06
	bcc @D045

	cmp #$26
	bcc @D055

	cmp #$2D
	beq @D055

	cmp #$2E
	beq @D055

	cmp #$18
	beq @D055

	@D045:
	ldx #$00
	sec
	lda zp_82
	sbc zp_84
	lda zp_plr1_spr_x_offset
	sbc zp_plr2_spr_x_offset
	bmi @D053

	inx
	@D053:
	stx zp_plr1_facing_dir
	@D055:
	lda zp_plr2_cur_anim
	cmp #$06
	bcc @D06B

	cmp #$26
	bcc @D07B

	cmp #$2D
	beq @D07B

	cmp #$2E
	beq @D07B

	cmp #$18
	beq @D07B

	@D06B:
	ldx #$00
	sec
	lda zp_82
	sbc zp_84
	lda zp_plr1_spr_x_offset
	sbc zp_plr2_spr_x_offset
	bpl @D079

	inx
	@D079:
	stx zp_plr2_facing_dir
	@D07B:
	rts

; -----------------------------------------------------------------------------

sub_rom_D07C:
	ldy #$00
	jsr sub_rom_D082
	iny
; ----------------
sub_rom_D082:
	lda zp_plr1_fgtr_idx_clean,Y
	beq @D08B

	cmp #$04
	bne @D09D

	@D08B:
	lda zp_plr1_cur_anim,Y
	cmp #$18
	bne @D09D

	lda zp_plr1_anim_frame,Y
	cmp #$0A
	bcs @D09D

	pla
	pla
	sec
	rts
; ----------------
	@D09D:
	clc
	rts

; -----------------------------------------------------------------------------

sub_rom_D09F:
	jsr sub_rom_D07C
	bcs @D0C4

	clc
	lda zp_82
	adc zp_84
	sta zp_ptr1_lo
	lda zp_plr1_spr_x_offset
	adc zp_plr2_spr_x_offset
	sta zp_ptr1_hi
	lsr zp_ptr1_hi
	ror zp_ptr1_lo
	lda zp_ptr1_lo
	sec
	sbc #$80
	ldx ram_irq_routine_idx
	cmp rom_D0C5,X
	bcs @D0C4

	sta zp_irq_hor_scroll
	@D0C4:
	rts

; -----------------------------------------------------------------------------

rom_D0C5:
	.byte $68, $68, $68, $68, $68, $68, $68, $68
	.byte $68, $50, $50, $88

; -----------------------------------------------------------------------------

sub_rom_D0D1:
	lda zp_plr1_cur_anim,Y
	beq sub_rom_D0E0
; ----------------
sub_rom_D0D6:
	cmp #$02
	bcc @D0DE

	cmp #$06
	bcc sub_rom_D0E0

	@D0DE:
	pla
	pla
; ----------------
sub_rom_D0E0:
	rts

; -----------------------------------------------------------------------------

sub_rom_D0E1:
	lda zp_plr1_fgtr_idx_clean,Y
	beq @D0EE
	cmp #$03
	beq @D0EE
	cmp #$04
	bne @D0F3
	@D0EE:
	lda zp_AD,Y
	bne @D124
	@D0F3:
	jsr sub_rom_D0D1
	lda zp_controller1,Y
	and #$08
	beq @D124
	lda zp_controller1,Y
	and #$01
	beq @D111
	ldx #$08
	lda zp_plr1_facing_dir,Y
	bne @D10C
	dex
	@D10C:
	txa
	jsr sub_change_fighter_anim
	rts
; ----------------
	@D111:
	lda zp_controller1,Y
	and #$02
	beq @D125
	ldx #$08
	lda zp_plr1_facing_dir,Y
	beq @D120
	dex
	@D120:
	txa
	@D121:
	jsr sub_change_fighter_anim
	@D124:
	rts
; ----------------
	@D125:
	lda #$06
	bne @D121
; ----------------
sub_rom_D129:
	lda zp_plr1_cur_anim,Y
	beq @D136

		cmp #$03	; Waling forward
		beq @D136

			cmp #$04	; Walking backwards
			bne @D163

		@D136:
		tya
		eor #$01
		tax
		lda zp_plr1_cur_anim,X
		cmp #$0B
		bcc @D163

		cmp #$26
		bcs @D163

		cmp #$14
		beq @D163

		cmp #$18
		beq @D163

		lda #$01
		ldx zp_plr1_facing_dir,Y
		bne @D154

		lda #$02
		@D154:
		and zp_controller1,Y
		beq @D163

		lda #$05
		sta zp_plr1_cur_anim,Y
		lda #$00
		sta zp_plr1_anim_frame,Y
	@D163:
	rts

; -----------------------------------------------------------------------------

sub_rom_D164:
	lda zp_5E
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
	jsr sub_rom_D0D6
	lda #$00	; This will reset the animation to idle when a player stops walking
	beq @D1A1_set_anim	; This always branches

; -----------------------------------------------------------------------------

sub_rom_D1B6:
	tya
	eor #$01
	tax	; Opponent player's index in X (0 for player one, 1 for player 2)
		; Used to check the opponent's animation

	lda zp_plr1_cur_anim,Y
	cmp #$06		; 6 = jumping up animation
	bcs @D209_rts	; Anything lower is idle, parrying, crouching or walking

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
	lda zp_plr1_cur_anim,X
	cmp #$0B	; $0B = base kick
	bcc @D1FD

	cmp #$26	; $26 = tripped/falling
	bcs @D1FD

	cmp #$18	; $18 = executing a throw move
	beq @D1FD

	lda #$01
	ldx zp_plr1_facing_dir,Y
	bne @D1F4

	lda #$02
	@D1F4:
	and zp_controller1,Y
	beq @D1FD

	lda #$02
	bne @D206_set_anim

	@D1FD:
	lda zp_plr1_fgtr_idx_clean,Y
	cmp #$07
	beq @D209_rts

	lda #$01
	@D206_set_anim:
	jsr sub_change_fighter_anim
	@D209_rts:
	rts

; -----------------------------------------------------------------------------

sub_rom_D20A:
	ldy #$00
	sty zp_7C
	jsr sub_rom_D215

	ldy #$01
	sty zp_7C
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
	stx zp_7C
	jmp sub_load_fighters_palettes ;jsr sub_load_fighters_palettes
	;rts

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

tbl_fighter_palette_ptrs:
	.word @pal_rayden			; $00 Rayden
	.word @pal_sonya			; $01 Sonya
	.word @pal_subzero			; $02 Sub-Zero
	.word @pal_scorpion			; $03 Scorpion
	.word @pal_kano				; $04 Kano
	.word @pal_cage				; $05 Johnny Cage
	.word @pal_liukang			; $06 Liu Kang
	.word @pal_goro				; $07 Goro
	.word @pal_shangtsung		; $08 Shang-Tsung

	.word @pal_rayden ;.word @rom_D51E	; $09 Unused?
	.word @pal_rayden ;.word @rom_D526	; $0A Unused?
	.word @pal_rayden ;.word @rom_D52E	; $0B Unused?

	.word @pal_rayden_alt		; $0C Alt Rayden
	.word @pal_sonya_alt		; $0D Alt Sonya
	.word @pal_subzero_alt		; $0E Alt Sub-Zero
	.word @pal_scorpion_alt		; $0F Alt Scorpion
	.word @pal_kano_alt			; $10 Alt Kano
	.word @pal_cage_alt			; $11 Alt Johnny Cage
	.word @pal_liukang_alt		; $12 Alt Liu Kang
	.word @pal_goro_alt			; $13 Alt Goro
	.word @pal_shangtsung_alt	; $14 Alt Shang-Tsung

	.word @pal_rayden_alt ;.word @rom_D57E	; $15 Unused?
	.word @pal_rayden_alt ;.word @rom_D586	; $16 Unused?
	.word @pal_rayden_alt ;.word @rom_D58E	; $17 Unused?
	
	@pal_rayden:
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
	@pal_rayden_alt:
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

tbl_bg_palette_ptrs:
	.word @pal_goros_lair
	.word @pal_pit
	.word @pal_courtyard
	.word @pal_palace_gates
	.word @pal_warrior_shrine
	.word @pal_throne_room
	.word @rom_D610
	.word @rom_D620
	.word @rom_D630
	.word @rom_D640
	.word @rom_D650
	.word @rom_D660
	.word @rom_D670

	@pal_goros_lair:
	.byte $0E, $16, $2A, $28, $0E, $06, $16, $26
	.byte $0E, $08, $08, $20, $0E, $08, $00, $10
	@pal_pit:
	.byte $02, $16, $2A, $28, $02, $18, $28, $38
	.byte $02, $0E, $00, $10, $02, $08, $00, $10
	@pal_courtyard:
	.byte $0E, $16, $2A, $28, $0E, $0C, $11, $21
	.byte $0E, $05, $27, $21, $0E, $0C, $00, $21
	@pal_palace_gates:
	.byte $0E, $16, $2A, $28, $0E, $17, $27, $3C
	.byte $0E, $17, $06, $3C, $0E, $00, $10, $3C
	@pal_warrior_shrine:
	.byte $0E, $16, $2A, $28, $0E, $21, $26, $20
	.byte $0E, $18, $28, $38, $0E, $08, $00, $10
	@pal_throne_room:
	.byte $0E, $16, $2A, $28, $0E, $0B, $18, $06
	.byte $0E, $18, $28, $06, $0E, $00, $10, $06
	@rom_D610:
	;.byte $0E, $06, $27, $30, $0E, $08, $18, $11
	;.byte $0E, $0B, $1B, $11, $0E, $08, $18, $28
	@rom_D620:
	;.byte $0E, $05, $27, $30, $0E, $0B, $1B, $2C
	;.byte $0E, $07, $16, $26, $0E, $02, $12, $22
	@rom_D630:
	;.byte $0E, $05, $27, $30, $0E, $0B, $1B, $3B
	;.byte $0E, $08, $00, $10, $0E, $06, $16, $26
	@rom_D640:
	;.byte $0E, $31, $20, $10, $0E, $3B, $20, $10
	;.byte $0E, $31, $20, $17, $0E, $06, $38, $16
	@rom_D650:
	;.byte $0E, $3B, $2A, $10, $0E, $2C, $1C, $3C
	;.byte $0E, $26, $17, $36, $0E, $06, $38, $16
	@rom_D660:
	;.byte $0E, $06, $27, $30, $0E, $05, $10, $2B
	;.byte $0E, $06, $16, $28, $0E, $1C, $2C, $3C
	@rom_D670:
	;.byte $0E, $8D, $00, $3E, $0E, $20, $00, $00
	;.byte $0E, $02, $00, $90, $0E, $11, $0E, $30
	.byte $FF

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
	@D6A4:
	sta ram_oam_data,X
	inx
	inx
	inx
	inx
	bne @D6A4
	rts

; -----------------------------------------------------------------------------

sub_rom_D6AE:
	lda #$00
	ldx #$18

	@D6B2:
	asl zp_07
	rol zp_08
	rol zp_09
	rol A
	cmp zp_16
	bcc @D6C1

	sbc zp_16
	inc zp_07

	@D6C1:
	dex
	bne @D6B2

	sta zp_ptr1_lo
	rts

; -----------------------------------------------------------------------------

sub_rom_D6C7:
	ldy #$00
	sty zp_17
	lda #$0A
	sta zp_16
	@D6CF:
	jsr sub_rom_D6AE

	lda zp_ptr1_lo
	clc
	adc zp_0D
	sta ram_066D,Y
	iny
	cpy #$05
	bcc @D6CF

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

			lda zp_82,X
			sec
			sbc zp_ptr1_lo
			sta zp_82,X
			bcs sub_skip_bump_check

				dec zp_plr1_spr_x_offset,X
; ----------------
sub_skip_bump_check:
	rts
; ----------------
; Can't push a player that is near the border
sub_check_right_border_proximity:
	lda zp_plr1_x_pos,Y
	cmp #$D0
	bcs sub_skip_bump_check

		lda zp_82,X
		clc
		adc zp_ptr1_lo
		sta zp_82,X
		bcc sub_skip_bump_check

			inc zp_plr1_spr_x_offset,X
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
		bne @D76C

		@D752:
		lda zp_plr1_anim_frame,Y
		cmp #$02
		bne @D76C

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

	@D76C:
	rts

; -----------------------------------------------------------------------------

sub_load_fighter_sprite_data:
	ldx #$00
	stx zp_7B
	stx zp_7C
	jsr sub_rom_D784

	ldx #$02
	stx zp_7B
	dex
	stx zp_7C
; ----------------
sub_rom_D784:
	jsr sub_shangtsung_palettes
	ldy zp_7C
	ldx zp_plr1_fgtr_idx_clean,Y
	lda tbl_fighter_sprite_banks,X
	sta zp_05

	; Load a new bank in $8000-$9FFF from table below
	lda #$80
	sta zp_bank_select_mask
	lda #$86
	sta mmc3_bank_select
	lda zp_05
	sta mmc3_bank_data
	; Bank $01 in $A000-$BFFF
	;lda #$87
	;sta zp_prg_bank_select_backup
	; Not needed after relocation
	;sta mmc3_bank_select
	;lda #$01
	;sta mmc3_bank_data

	; Read a pointer from the top of the new ROM in $8000
	lda rom_8000+0
	sta zp_ptr3_lo
	lda rom_8000+1
	sta zp_ptr3_hi
	; Index = animation idx * 3
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
	sta zp_ptr1_lo
	; Index ready, read first byte
	tay
	lda (zp_ptr3_lo),Y
	asl A
	tax
	lda tbl_anim_data_ptrs+0,X
	sta zp_ptr4_lo
	lda tbl_anim_data_ptrs+1,X
	sta zp_ptr4_hi

	ldy zp_7C	; Player index (0 for player one, 1 for player two)
	lda zp_plr1_anim_frame,Y
	asl A
	tay
	lda (zp_ptr4_lo),Y
	sta zp_05	; Player's X movement (signed value)
	iny
	lda (zp_ptr4_lo),Y
	sta zp_06	; Player's Y movement (signed value)

	iny
	lda #$00
	sta zp_18
	lda (zp_ptr4_lo),Y
	cmp #$80
	bne :+
		; Animation will be set to zero when this is >0
		inc zp_18
	:
	ldx zp_7B	; 2-byte data / pointer offset for current player
	ldy zp_7C	; 1-byte data offset for current player
	lda zp_05	; X movement for current animation
	bpl @D81A

		; Negative movement (against current facing direction)
		eor #$FF
		sta zp_05
		inc zp_05
		lda zp_plr1_facing_dir,Y	; Will determine whether to move forward or backwards
		bne @D81F

			; Recalculate the distance between player hit boxes
			@D803:
			lda zp_plr1_x_pos,Y
			sec
			sbc zp_05
			cmp #$20
			bcc @D834

			lda zp_82,X
			sec
			sbc zp_05
			sta zp_82,X
			bcs @D834

			dec zp_plr1_spr_x_offset,X
			beq @D834

	@D81A:
	lda zp_plr1_facing_dir,Y
	bne @D803

	@D81F:
	lda zp_plr1_x_pos,Y
	clc
	adc zp_05
	cmp #$D0
	bcs @D834

		lda zp_82,X
		clc
		adc zp_05
		sta zp_82,X
		bcc @D834

			inc zp_plr1_spr_x_offset,X

	@D834:
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

	ldy zp_7C
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
	;bcc @D862	; This achieves nothing
	;@D862:
	tay
	lda (zp_ptr4_lo),Y
	sta zp_ptr3_lo
	iny
	lda (zp_ptr4_lo),Y
	sta zp_ptr3_hi	; This now points to the second data table in fighter's anim ROM bank

	ldx zp_7B
	ldy zp_7C
	jsr sub_check_player_push
	jsr sub_rom_D72C

	ldy zp_7C
	ldx tbl_player_oam_offsets,Y
	lda zp_plr1_cur_anim,Y

	cmp #$09
	beq @D88A

	cmp #$2E
	beq @D88A

	cmp #$28	; Staggered animation
	bne @D88E

		@D88A:
		; Force a move to the next OAM entry when staggered (and knocked out?)
		inx
		inx
		inx
		inx

	@D88E:
	stx zp_1A
	ldx zp_7B
	lda zp_plr1_facing_dir,Y
	beq :+
		lda #$40	; Sprite's horizontal flip flag
	:
	sta zp_1B
	
	lda zp_82,X
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

	ldx zp_7C
	inc zp_plr1_anim_frame,X
	ldy zp_7C
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
	beq :+
		lda #$00
		sta zp_plr1_cur_anim,Y
		sta zp_plr1_anim_frame,Y
	:
	jmp sub_animate_player_sprites

; -----------------------------------------------------------------------------

; Bank numbers, will be mapped to $8000-$9FFF
; These contain animation data (sprite indices) and maybe "moves" data
tbl_fighter_sprite_banks:
	.byte $05	; Rayden
	.byte $06	; Sonya
	.byte $07	; Sub-Zero
	.byte $08	; Scorpion
	.byte $09	; Kano
	.byte $0A	; Cage
	.byte $0B	; Liu Kang
	.byte $0C	; Goro
	.byte $0D	; Shang-Tsung
	.byte $05, $05, $05	; Potentially unused
; This portion is also potentially unused
;rom_D8E4:
;	.byte $00, $01, $00, $02, $00, $01, $00, $01
;	.byte $02, $00, $01, $00

; -----------------------------------------------------------------------------

; Change palettes if Shang-Tsung has morphed into a different fighter
sub_shangtsung_palettes:
	ldx zp_7C
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
	ldx zp_7C
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
	lda ram_irq_routine_idx
	cmp #$01
	bne :+
		lda #$02
		sta ram_ppu_data_buffer
	:
	sty zp_nmi_ppu_cols
	lda #$01
	sta zp_nmi_ppu_rows
	lda #$3F
	sta zp_nmi_ppu_ptr_hi
	ldy #$10
	lda zp_7C
	beq @D96A

	ldy #$18
	@D96A:
	sty zp_nmi_ppu_ptr_lo
	rts

; -----------------------------------------------------------------------------

sub_rom_D96D:
	lda zp_22
	and #$07
	bne :+
		iny
	:
	tay
	iny
	rts

; -----------------------------------------------------------------------------

rom_D977:
	.byte $00, $01, $00, $00, $00, $01, $01, $01
	.byte $01, $01, $01, $01, $01, $01, $01, $01
	.byte $01, $01, $01, $01, $01, $01, $01, $01
	.byte $01, $01, $01, $01, $01, $01, $01, $01
	.byte $01, $01, $01, $01, $01, $01, $02, $01
	.byte $01, $02, $02, $01, $01, $01, $02, $01
	.byte $01, $01, $01, $01, $01, $01, $01, $01

; -----------------------------------------------------------------------------

sub_animate_player_sprites:
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
	sta zp_05
	sta zp_ptr2_lo	; This may be unused
	iny
	lda (zp_ptr3_lo),Y
	sta zp_06
	sta zp_16
	iny
	lda (zp_ptr3_lo),Y
	sta zp_0F
	iny
	lda (zp_ptr3_lo),Y
	ldx zp_7C
	sta zp_chr_bank_0,X
	sta ram_0429
	iny
	lda (zp_ptr3_lo),Y
	sta ram_042A
	iny
	lda zp_05
	sta zp_09

	lda zp_1B	; Probably a "direction" flag to indicate whether to move left or right
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
	sta zp_08	; Current X offset (updated for each column)

	ldx zp_06	; Vertical updates count?

	:
		lda zp_0A	; It seems this was player Y pos - 8 before this loop
		sec
		sbc #$08
		sta zp_0A
	dex
	bne :-

	sta zp_0B
	dec zp_0B	; Base Y position (incremented by 8 for each row)

	ldx zp_1A	; OAM offset of first sprite

	@next_frame_data_byte:
	lda (zp_ptr3_lo),Y
	cmp #$FF
	beq @skip_sprite

		; Ignore the MSB because we use this as an offset: we don't know yet
		; if we are in the top half of CHR ROM or the bottom
		and #$7F

		pha
		lda zp_7C	; Player index
		beq @DA2F	; Nothing to change for player 1

		pla
		ora #$80	; Move to the bottom of CHR ROM for player 2
		bne @set_tile_id

		@DA2F:
		pla

		@set_tile_id:
		sta ram_oam_copy_tileid,X
		jmp @set_sprite_flags

		@set_xy_pos:
		lda zp_0B	; Current row's Y pos
		sta ram_oam_copy_ypos,X
		lda zp_08	; Current tile's X pos
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
	adc zp_08
	sta zp_08

	dec zp_09	; X counter
	bne @next_frame_data_byte

	; Increase Y position offset for next row
	lda zp_0B
	clc
	adc #$08	; Fixed offset: we always draw top-to-bottom
	sta zp_0B

	lda zp_05	; Horizontal tiles count reload
	sta zp_09

	lda zp_07	; Starting X pos for next row of sprites
	sta zp_08

	dec zp_06	; Y counter
	bne @next_frame_data_byte

	rts
; ----------------
	@set_sprite_flags:
	tya	; Preserve animation data offset
	pha

	ldy ram_0429 ;lda ram_0429
	;tay
	lda rom_01_B000+0,Y
	sta zp_ptr4_lo
	lda rom_01_B000+1,Y
	sta zp_ptr4_hi

	lda ram_oam_copy_tileid,X
	and #$07
	tay
	lda @rom_DAB4,Y	; Index by tile ID % 8
	pha
		lda ram_oam_copy_tileid,X
		and #$7F
		lsr A
		lsr A
		lsr A
		tay
	pla
	and (zp_ptr4_lo),Y
	beq :+
		lda #$01
	:
	ora ram_042A	; Add flags from fighter's anim frame data
	eor zp_1B		; Horizontal flip flag depending on current facing direction
	tay
	lda zp_7C		; Player index
	beq @DA9D		; Branch for player one

		tya			; Player 2 changes palette index
		ora #$02
		bne @DA9E

	@DA9D:
	tya				; Player 1 uses value as it is (keep palette index)

	@DA9E:
	ldy ram_irq_routine_idx
	cpy #$06
	bne :+
		; This is only used in the Continue screen...
		; probably leftover from a different game
		ora #$20	; Move sprite behind the background
	:
	sta ram_oam_copy_attr,X

	pla
	tay

	lda #$FB
	sta ram_067F	; Probably unused
	jmp @set_xy_pos

; -----------------------------------------------------------------------------

; Probably an index/mask conversion table
	@rom_DAB4:
	.byte $01, $02, $04, $08, $10, $20, $40, $80
; Potentially unused bytes
	.byte $2C, $AC

; -----------------------------------------------------------------------------

; SFX indices for frame 1 of each animation
; 0 = no sound
tbl_frame_1_sfx_idx:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $07, $07, $08, $00, $00
	.byte $08, $00, $00, $08, $07, $08, $00, $04
	.byte $08, $00, $00, $00, $00, $00, $04, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $FF

; -----------------------------------------------------------------------------


; -----------------------------------------------------------------------------
.export rom_01_B000

; Data pointers, indexed by CHR ROM bank number
rom_01_B000:
	.word rom_B0D8, rom_B0E8, rom_B0F8, rom_B108
	.word rom_B118, rom_B128, rom_B138, rom_B148
	.word rom_B158, rom_B168, rom_B178, rom_B188
	.word rom_B198, rom_B1A8, rom_B0D8, rom_B0E8
	.word rom_B0D8, rom_B0E8, rom_B0D8, rom_B0E8
	.word rom_B0D8, rom_B0E8, rom_B0D8, rom_B0E8
	.word rom_B0D8, rom_B0E8, rom_B0D8, rom_B0E8
	.word rom_B1B8, rom_B1C8, rom_B1D8, rom_B1E8
	.word rom_B1F8, rom_B208, rom_B218, rom_B228
	.word rom_B238, rom_B248, rom_B258, rom_B268
	.word rom_B278, rom_B288, rom_B298, rom_B2A8
	.word rom_B2B8, rom_B2C8, rom_B2D8, rom_B2E8
	.word rom_B2F8, rom_B308, rom_B318, rom_B328
	.word rom_B338, rom_B348, rom_B358, rom_B368
	.word rom_B378, rom_B388, rom_B398, rom_B3A8
	.word rom_B3B8, rom_B3C8, rom_B3D8, rom_B3E8
	.word rom_B3F8, rom_B408, rom_B418, rom_B428
	.word rom_B438, rom_B448, rom_B458, rom_B468
	.word rom_B478, rom_B488, rom_B498, rom_B4A8
	.word rom_B4B8, rom_B4C8, rom_B4D8, rom_B4E8
	.word rom_B4F8, rom_B508, rom_B518, rom_B528
	.word rom_B538, rom_B548, rom_B558, rom_B568
	.word rom_B578, rom_B588, rom_B598, rom_B5A8
	.word rom_B5B8, rom_B5C8, rom_B5D8, rom_B5E8
	.word rom_B5F8, rom_B608, rom_B618, rom_B628
	.word rom_B638, rom_B648, rom_B658, rom_B668
	.word rom_B678, rom_B688, rom_B698, rom_B6A8

; -----------------------------------------------------------------------------

rom_B0D8:
	.byte $FF, $B7, $9C, $88, $22, $01, $40, $20
	.byte $00, $00, $00, $20, $00, $00, $F0, $FF
rom_B0E8:
	.byte $06, $92, $13, $48, $18, $30, $08, $78
	.byte $01, $C0, $04, $00, $00, $40, $00, $00
rom_B0F8:
	.byte $81, $0F, $4F, $E0, $9F, $80, $06, $20
	.byte $00, $12, $00, $00, $00, $00, $FF, $FF
rom_B108:
	.byte $DF, $9C, $8F, $00, $00, $00, $00, $00
	.byte $00, $C0, $04, $00, $3E, $22, $00, $02
rom_B118:
	.byte $FC, $FD, $47, $44, $00, $01, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $F0
rom_B128:
	.byte $EF, $C1, $08, $46, $40, $20, $02, $00
	.byte $00, $00, $F0, $11, $00, $00, $00, $00
rom_B138:
	.byte $BF, $3E, $7C, $60, $04, $8A, $80, $40
	.byte $00, $00, $02, $00, $00, $80, $C0, $FF
rom_B148:
	.byte $77, $0F, $57, $00, $08, $00, $00, $22
	.byte $00, $00, $07, $1C, $60, $98, $41, $38
rom_B158:
	.byte $FF, $63, $1D, $67, $02, $08, $06, $70
	.byte $00, $00, $60, $00, $44, $14, $40, $FF
rom_B168:
	.byte $4B, $30, $0C, $00, $08, $80, $00, $30
	.byte $21, $00, $02, $B6, $C4, $00, $00, $00
rom_B178:
	.byte $BF, $26, $80, $11, $00, $04, $32, $08
	.byte $00, $10, $00, $18, $00, $4C, $02, $F8
rom_B188:
	.byte $0C, $B0, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $2C, $11, $00, $00, $00, $00
rom_B198:
	.byte $FF, $F9, $3E, $64, $01, $92, $61, $00
	.byte $00, $00, $00, $00, $00, $60, $00, $F0
rom_B1A8:
	.byte $07, $03, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
rom_B1B8:
	.byte $FF, $9F, $FF, $7F, $FC, $FF, $FF, $FF
	.byte $F9, $FF, $F8, $3F, $07, $00, $00, $C0
rom_B1C8:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $FF, $FF, $FF, $0F, $00, $00, $40, $00
rom_B1D8:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $DF
	.byte $FF, $03, $02, $80, $00, $20, $FE, $FF
rom_B1E8:
	.byte $FF, $CF, $FF, $3F, $FF, $DF, $FF, $7F
	.byte $FF, $CF, $0F, $8F, $01, $00, $80, $00
rom_B1F8:
	.byte $FF, $FF, $FF, $3F, $FF, $3F, $FE, $9F
	.byte $FF, $7F, $1E, $02, $C0, $20, $00, $FE
rom_B208:
	.byte $F9, $F9, $FF, $FF, $FF, $F9, $F7, $C3
	.byte $DF, $04, $FE, $00, $FF, $FF, $3D, $04
rom_B218:
	.byte $87, $C7, $FC, $CF, $FF, $FE, $F9, $7F
	.byte $EE, $7F, $FE, $3F, $7E, $7E, $EC, $30
rom_B228:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $7F, $88, $C7, $04, $10, $02, $C0, $00
rom_B238:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $FF, $FF, $FF, $00, $04, $00, $F8, $FF
rom_B248:
	.byte $FF, $FF, $FF, $FF, $DF, $FF, $F9, $FF
	.byte $FE, $E1, $01, $C0, $01, $30, $60, $00
rom_B258:
	.byte $7F, $FC, $20, $01, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
rom_B268:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
rom_B278:
	.byte $01, $00, $F2, $FF, $FF, $FF, $FF, $FF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
rom_B288:
	.byte $0F, $09, $F9, $FF, $FF, $FD, $BF, $FF
	.byte $FF, $FF, $FF, $FF, $FF, $7F, $FE, $7F
rom_B298:
	.byte $99, $CC, $FF, $FF, $FF, $FF, $FF, $3F
	.byte $00, $00, $00, $00, $00, $00, $00, $00
rom_B2A8:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
rom_B2B8:
	.byte $7F, $FB, $FF, $DF, $FF, $97, $FA, $E6
	.byte $8F, $FF, $7E, $F4, $9E, $FC, $F7, $FF
rom_B2C8:
	.byte $FF, $FF, $FF, $FB, $BF, $79, $7D, $FB
	.byte $3F, $D4, $E2, $FF, $47, $2F, $06, $00
rom_B2D8:
	.byte $FF, $6F, $FB, $FF, $FF, $13, $84, $40
	.byte $02, $F0, $01, $20, $40, $F1, $39, $80
rom_B2E8:
	.byte $9F, $F7, $F9, $DF, $99, $3D, $E0, $00
	.byte $7F, $B7, $5B, $C0, $7F, $26, $17, $01
rom_B2F8:
	.byte $FF, $FF, $7F, $FF, $EF, $FA, $D7, $FB
	.byte $7F, $FE, $FF, $00, $8D, $78, $77, $C4
rom_B308:
	.byte $0F, $C8, $FE, $BF, $FF, $FF, $7F, $72
	.byte $FE, $3F, $CE, $CA, $FF, $73, $D6, $01
rom_B318:
	.byte $FF, $FF, $9F, $EB, $D3, $EB, $EC, $7E
	.byte $E6, $33, $9F, $10, $20, $00, $20, $FF
rom_B328:
	.byte $FF, $0F, $7E, $F8, $C8, $07, $07, $E0
	.byte $08, $BE, $21, $18, $B8, $32, $1F, $08
rom_B338:
	.byte $FF, $FF, $BC, $6A, $FB, $5D, $97, $E7
	.byte $CB, $C8, $C1, $F6, $FD, $6F, $FF, $FF
rom_B348:
	.byte $FF, $FE, $4D, $BF, $C4, $49, $9E, $E7
	.byte $24, $E9, $44, $92, $2F, $69, $1E, $68
rom_B358:
	.byte $FF, $EF, $FB, $99, $F8, $4C, $CC, $89
	.byte $E7, $80, $A3, $12, $4E, $E5, $FF, $FF
rom_B368:
	.byte $FF, $3F, $FE, $F8, $CF, $67, $73, $C9
	.byte $E4, $E6, $09, $4E, $27, $8F, $FF, $7F
rom_B378:
	.byte $FF, $E4, $EE, $1E, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
rom_B388:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
rom_B398:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $9F, $04
	.byte $20, $00, $00, $00, $00, $00, $00, $FE
rom_B3A8:
	.byte $19, $1F, $1F, $1E, $18, $78, $FE, $E3
	.byte $3F, $3C, $C3, $18, $00, $00, $00, $08
rom_B3B8:
	.byte $FF, $F8, $8F, $FF, $F1, $FF, $7C, $46
	.byte $2E, $66, $10, $30, $10, $00, $00, $10
rom_B3C8:
	.byte $9F, $10, $F8, $FF, $FF, $FF, $F7, $07
	.byte $57, $00, $01, $00, $00, $00, $00, $00
rom_B3D8:
	.byte $FF, $FF, $FF, $FF, $7F, $66, $E4, $03
	.byte $00, $03, $00, $18, $00, $00, $00, $80
rom_B3E8:
	.byte $FF, $F3, $7F, $FE, $99, $1D, $60, $78
	.byte $00, $80, $01, $00, $00, $F0, $0F, $01
rom_B3F8:
	.byte $FF, $FF, $FD, $C7, $FF, $FC, $3F, $0F
	.byte $18, $60, $00, $00, $00, $01, $C0, $FC
rom_B408:
	.byte $FF, $E4, $30, $C4, $01, $26, $C0, $73
	.byte $80, $39, $9C, $C7, $F1, $F0, $78, $00
rom_B418:
	.byte $FF, $FF, $FF, $FF, $FF, $3F, $C0, $0F
	.byte $30, $00, $00, $00, $80, $07, $00, $00
rom_B428:
	.byte $FF, $FF, $FF, $FF, $FF, $1D, $01, $20
	.byte $00, $00, $00, $00, $C8, $1F, $00, $00
rom_B438:
	.byte $FF, $FF, $FF, $CF, $FD, $67, $0C, $00
	.byte $00, $00, $00, $00, $00, $FE, $18, $F8
rom_B448:
	.byte $FF, $FF, $3F, $00, $00, $00, $60, $4C
	.byte $0C, $00, $00, $00, $00, $00, $00, $00
rom_B458:
	.byte $FF, $FF, $FF, $FF, $FF, $18, $99, $08
	.byte $09, $1D, $01, $FF, $FD, $3F, $C0, $FC
rom_B468:
	.byte $FF, $F7, $FF, $BF, $FF, $CF, $F9, $1F
	.byte $0C, $7F, $C0, $31, $01, $F3, $FF, $7F
rom_B478:
	.byte $FF, $FF, $FF, $B7, $FF, $C0, $7F, $20
	.byte $FF, $63, $CE, $F9, $FF, $9F, $FF, $FF
rom_B488:
	.byte $FF, $FF, $FF, $FF, $3F, $F3, $FF, $E1
	.byte $FF, $FC, $E1, $A7, $3F, $CE, $FF, $07
rom_B498:
	.byte $FF, $FF, $FF, $1F, $00, $00, $00, $F9
	.byte $F3, $FF, $FF, $FF, $FF, $9B, $99, $FF
rom_B4A8:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $07, $00
	.byte $02, $FE, $FF, $FF, $FF, $FF, $03, $00
rom_B4B8:
	.byte $FF, $FF, $FF, $FF, $FF, $3F, $8E, $20
	.byte $7E, $FE, $FF, $FF, $FF, $CB, $FC, $FF
rom_B4C8:
	.byte $FF, $FF, $FF, $FF, $1B, $7E, $87, $3F
	.byte $19, $87, $E3, $FC, $1D, $FF, $3F, $07
rom_B4D8:
	.byte $FF, $FF, $CF, $FD, $53, $81, $F0, $C0
	.byte $60, $7E, $FE, $CF, $EF, $FB, $27, $FF
rom_B4E8:
	.byte $FF, $FF, $FE, $DF, $F8, $C2, $C7, $FC
	.byte $EF, $FF, $11, $FF, $67, $FE, $9F, $79
rom_B4F8:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $04, $7D
	.byte $00, $90, $FF, $7F, $FC, $FF, $FF, $FF
rom_B508:
	.byte $FF, $FF, $FF, $8B, $B3, $98, $FD, $03
	.byte $00, $00, $00, $00, $00, $00, $00, $00
rom_B518:
	.byte $51, $11, $B5, $16, $84, $E1, $67, $FB
	.byte $BF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
rom_B528:
	.byte $06, $02, $9F, $8F, $3D, $F6, $F8, $1E
	.byte $7E, $1E, $3F, $C4, $3F, $F2, $8F, $7F
rom_B538:
	.byte $EB, $08, $6C, $FD, $B8, $C6, $73, $12
	.byte $67, $FF, $FF, $FF, $FF, $FF, $FF, $FF
rom_B548:
	.byte $14, $53, $95, $02, $64, $C0, $EC, $9F
	.byte $FF, $FF, $FF, $FF, $0F, $F2, $FF, $7F
rom_B558:
	.byte $E1, $FD, $9D, $BF, $CF, $DF, $8F, $7F
	.byte $FF, $5B, $04, $EA, $9F, $3F, $FF, $FF
rom_B568:
	.byte $90, $F3, $E6, $7D, $32, $FB, $CD, $79
	.byte $BB, $1F, $FF, $FF, $FF, $FF, $FF, $7F
rom_B578:
	.byte $85, $65, $C9, $02, $D9, $70, $7F, $FE
	.byte $FF, $FF, $FF, $FF, $FF, $77, $CE, $33
rom_B588:
	.byte $40, $2D, $11, $5E, $F0, $FF, $FE, $FF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $7F, $00
rom_B598:
	.byte $15, $25, $00, $00, $C0, $FF, $FF, $FF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
rom_B5A8:
	.byte $FF, $7F, $FE, $CB, $BC, $EB, $86, $F3
	.byte $F7, $FF, $F1, $F3, $FF, $3F, $9F, $0F
rom_B5B8:
	.byte $65, $29, $1D, $E4, $07, $FC, $7F, $FE
	.byte $87, $FF, $FF, $FF, $FF, $FF, $FF, $FF
rom_B5C8:
	.byte $7B, $6E, $D9, $20, $04, $3F, $F9, $FF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $7F
rom_B5D8:
	.byte $FF, $DB, $FF, $FF, $16, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
rom_B5E8:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
rom_B5F8:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $FF, $FF, $FF, $1F, $00, $00, $00, $80
rom_B608:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $FF, $FF, $FF, $FF, $3F, $00, $00, $00
rom_B618:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $FF, $FF, $C6, $FF, $DF, $9F, $03, $07
rom_B628:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $0F, $00, $00, $FE, $FF, $7F, $80, $00
rom_B638:
	.byte $FF, $1F, $FF, $FC, $CF, $FF, $FF, $FF
	.byte $03, $FF, $07, $FC, $E3, $FF, $FF, $03
rom_B648:
	.byte $FF, $FF, $FF, $FF, $FF, $CF, $FF, $FF
	.byte $F3, $FF, $EF, $FF, $01, $00, $00, $03
rom_B658:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $FF, $FF, $FF, $FF, $03, $00, $00, $00
rom_B668:
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	.byte $FF, $FF, $7F, $00, $00, $00, $10, $00
rom_B678:
	.byte $FF, $FF, $FF, $7F, $66, $92, $C4, $86
	.byte $F2, $AF, $57, $82, $98, $8B, $FF, $FF
rom_B688:
	.byte $FF, $FF, $9F, $EC, $24, $7F, $81, $C0
	.byte $1C, $78, $48, $46, $F2, $20, $10, $00
rom_B698:
	.byte $FE, $DF, $FF, $84, $7F, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
rom_B6A8:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $80

; -----------------------------------------------------------------------------

; Data pointers for sprite animation sequences
; Index for these pointers is first byte from 3-byte data on top of fighter's
; PRG ROM bank
tbl_anim_data_ptrs:
	.word @rom_DB7D	; $00
	.word @rom_DB98	; $01
	.word @rom_DBCC
	.word @rom_DBB7
	.word @rom_DBF6
	.word @rom_DC17
	.word @rom_DB8B
	.word @rom_DBE5
	.word @rom_DB81	; $08
	.word @still_16_frames	; $09
	.word @rom_DB85
	.word @rom_DC38
	.word @rom_DC59
	.word @knockback_19_frames
	.word @rom_DC8D
	.word @rom_DCA8
	.word @still_20_frames	; $10
	.word @rom_DB89
	.word @rom_DCD3
	.word @rom_DCEE
	.word @rom_DD19
	.word @rom_DD46
	.word @rom_DD53
	.word @rom_DD68
	.word @still_30_frames	; $18
	.word @knocked_up_21_frames ;@rom_DD89
	.word @rom_DDA8
	.word @rom_DDC1
	.word @rom_DDC2
	.word @rom_DB75
	.word @rom_DE03
	.word @rom_DE04
	.word @rom_DE05	; $20
	.word @rom_DE12
	.word @rom_DB87
	.word @rom_DE2F
	.word @rom_DE48
	.word @rom_DB8E
	.word @rom_DBAD
	.word @knocked_up_21_frames
	.word @rom_DE8E	; $28
	.word @rom_DE9B
	.word @rom_DEB4
	.word @rom_DECD
	.word @rom_DEEE	; $2C

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

	@rom_DB81:
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

	@rom_DBAD:
	.byte $FC, $00, $FC, $00, $FC, $00, $FC, $00
	.byte $FC, $00

; ----------------

	@rom_DBB7:
	.byte $FC, $00, $FC, $00, $FC, $00, $FC, $00
	.byte $FC, $00, $FC, $00, $FC, $00, $FC, $00
	.byte $FC, $00, $FC, $00, $80

; ----------------

	@rom_DBCC:
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

	@rom_DC38:
	.byte $00, $00, $00, $00, $06, $E8, $0C, $00
	.byte $0C, $00, $0C, $00, $08, $00, $08, $00
	.byte $08, $00, $06, $00, $06, $00, $06, $00
	.byte $04, $00, $04, $00, $04, $00, $04, $18
	.byte $80

; ----------------

	@rom_DC59:
	.byte $10, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $80

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

	@rom_DCD3:
	.byte $F6, $F8, $F8, $FA, $FA, $FC, $FC, $FE
	.byte $FE, $02, $FF, $04, $00, $06, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $80

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

@rom_DD89:
	.byte $00, $00, $00, $00, $00, $EA, $0A, $EC
	.byte $19, $F8, $F0, $FA, $F1, $FC, $F2, $FE
	.byte $F3, $02, $F4, $04, $F5, $06, $F6, $08
	.byte $F7, $0A, $F8, $0E, $F9, $12, $80

; ----------------

@rom_DDA8:
	.byte $00, $00, $00, $00, $2A, $00, $00, $F0
	.byte $00, $00, $00, $00, $00, $F4, $00, $00
	.byte $2A, $00, $00, $00, $00, $14, $00, $00
	.byte $80

; ----------------

@rom_DDC1:
	.byte $80

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
	.byte $80

; ----------------

@rom_DE04:
	.byte $80

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
	.byte $00, $F0	; -0, -16
	.byte $00, $F0	; -0, -16
	.byte $FE, $F0	; -2, -16
	.byte $FE, $F2	; -2, -14
	.byte $FE, $F4	; -2, -12
	.byte $FE, $F6	; -2, -10
	.byte $FE, $F8	; -2, -8
	.byte $FE, $FC	; -2, -4
	.byte $FE, $00	; -2, 0
	.byte $FE, $01	; -2, 1
	.byte $FE, $02	; -2, 2
	.byte $FE, $04	; -2, 4
	.byte $FE, $08	; -2, 8
	.byte $FE, $0A	; -2, 10
	.byte $FE, $0C	; -2, 12
	.byte $FE, $0E	; -2, 14
	.byte $FE, $10	; -2, 16
	.byte $00, $10	; 0, 16
	.byte $00, $10	; 0, 16
	.byte $00, $10	; 0, 16

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

@rom_DE9B:
	.byte $00, $00, $00, $00, $20, $00, $00, $F0
	.byte $00, $00, $00, $00, $00, $F4, $00, $00
	.byte $30, $00, $00, $00, $E0, $14, $E0, $00
	.byte $80

; ----------------

@rom_DEB4:
	.byte $10, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
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

; -----------------------------------------------------------------------------
