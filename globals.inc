; -----------------------------------------------------------------------------
;
;                           ZERO-PAGE variables
;
; -----------------------------------------------------------------------------

zp_00 = $00     ;
zp_01 = $01     ;
zp_ppu_control_backup = $02     ;
zp_03 = $03     ;
zp_ppu_mask_backup = $04     ;
zp_05 = $05     ;
zp_06 = $06     ;
zp_07 = $07     ;
zp_var_x = $08     ;
zp_09 = $09     ;
zp_0A = $0A     ;
zp_var_y = $0B     ;
zp_0D = $0D     ;
zp_backup_a = $0E   ; Register backup to avoid psh/pla
zp_0F = $0F     ;

zp_backup_x = $10   ; Register backup to avoid psh/pla
zp_backup_y = $11   ; Register backup to avoid psh/pla

; Generically used as a pointer for indirect addressing. Low byte.
zp_ptr1_lo = $12 ;
; Generically used as a pointer for indirect addressing. High byte.
zp_ptr1_hi = $13 ;
zp_ptr2_lo = $14     ;
zp_ptr2_hi = $15     ;
zp_16 = $16     ;
zp_17 = $17     ;
zp_18 = $18     ;
zp_first_oam_ofs = $1A     ;
zp_oam_flip_flag = $1B     ;
zp_1C = $1C     ;

; Value for X scroll, will be written to $2005 on the next vblank
zp_scroll_x = $1E   ;
; Value for Y scroll, will be written to $2005 on the next vblank
zp_scroll_y = $20   ;

zp_random = $22 ;
zp_23 = $23     ;
zp_24 = $24     ;
; Incremented at each vblank
zp_frame_counter = $25  ;
zp_ranged_counter = $28 ; Internal counter for alternating ranged attack sprites

; Most recent data read from controller port 1
zp_controller1 = $2A     ;
; Most recent data read from controller port 2
zp_controller2 = $2B     ;
; "New" button presses, i.e. controller status bits, but those that were
; already set on the previous read will now be cleared, so all bits here
; are from buttons that were not pressed on the previous frame
zp_controller1_new = $2D    ;
; "New" button presses, i.e. controller status bits, but those that were
; already set on the previous read will now be cleared, so all bits here
; are from buttons that were not pressed on the previous frame
zp_controller2_new = $2E    ;
; The status of the controller as it was on the last frame
zp_controller1_prev = $2F   ;
; The status of the controller as it was on the last frame
; (Just for debugging, this does not need to be used in code since we use $2F,X)
zp_controller2_prev = $30   ;
zp_controller1_backup = $31 ;
zp_controller2_backup = $32 ;

zp_34 = $34     ;
zp_35 = $35     ;
zp_ptr3_lo = $3B     ;
zp_ptr3_hi = $3C     ;
zp_ptr4_lo = $3D     ;
zp_ptr4_hi = $3E     ;

zp_machine_state_0 = $40    ;
; When this pointer is valid, the NMI routine will write data to this PPU address
zp_nmi_ppu_ptr_lo = $43 ;
; When this pointer is valid, the NMI routine will write data to this PPU address
zp_nmi_ppu_ptr_hi = $44 ;
; How many rows of data to copy from $0600 to PPU
zp_nmi_ppu_rows = $45   ;
; How many columns of data to copy from $0600 to PPU
zp_nmi_ppu_cols = $46   ;
zp_47 = $47     ;
zp_48 = $48     ;
zp_49 = $49     ;
zp_sprites_base_y = $4A ; The only stage with a different one is the Pit
zp_4B = $4B     ;
zp_4C = $4C     ;
zp_4D = $4D     ;
zp_machine_state_1 = $4E    ;
zp_machine_state_2 = $4F    ;

; Used as a temporary index for various things
zp_tmp_idx = $50    ;
; Used to pass PPU addresses between subroutines
zp_ppu_ptr_hi = $51 ;
zp_ppu_ptr_lo = $52 ;
; Used to avoid running certain routines more than once per frame
; (e.g. controller reading routines)
zp_last_execution_frame = $53   ;
; Used as a counter that can be shared between subroutines
zp_counter_param = $54  ;
zp_palette_fade_idx = $55   ;
zp_palette_idx = $56    ;
zp_57 = $57     ;
zp_chr_bank_2 = $58     ;
zp_chr_bank_3 = $59     ;
zp_chr_bank_4 = $5A     ;
zp_chr_bank_5 = $5B     ;
zp_5C = $5C     ;
zp_5D = $5D     ;
zp_5E = $5E     ;
zp_endurance_flag = $5F ; Set to one for endurance matches (1 vs 2)

zp_60 = $60     ;
zp_match_number = $61     ;
zp_62 = $62     ;
; Index of menu option selected by controller 1
zp_plr1_selection = $63 ;
; Index of menu option selected by controller 2
zp_plr2_selection = $64 ;
zp_endurance_opp_idx = $65     ;

zp_frozen_timer = $70   ; Size=2 Player can't move until timer reaches zero
zp_thaw_flag = $72  ; Size=2 Player will be "thawed" when this flag is set

zp_game_substate = $7A     ;
zp_plr_ofs_param = $7B  ; Pointer offset for current player: 0 for player one, 2 for player two
zp_plr_idx_param = $7C  ; Active player index parameter: 0 for player one, 1 for player two
; zp_attacker_anim = $7D  ;
zp_7F = $7F     ;

;zp_80 = $80     ;

; Horizontal scroll value used in IRQ routines
zp_irq_hor_scroll = $81 ;
zp_plr1_x_lo = $82 ;
zp_plr1_x_hi = $83  ; How much the player has moved from the starting position
zp_plr2_x_lo = $84     ;
zp_plr2_x_hi = $85  ; How much the player has moved from the starting position
; Hitbox coordinates
zp_plr1_x_pos = $86 ;
zp_plr2_x_pos = $87 ;
zp_plr1_y_pos = $88 ;
zp_plr2_y_pos = $89 ;
zp_plr1_facing_dir = $8A    ; 0 = forward, 1 = backwards
zp_plr2_facing_dir = $8B    ; 0 = forward, 1 = backwards
zp_last_anim_plr = $8C     ; Index of the last player (0 or 1) whose animation was changed
zp_y_plane_skew = $8D   ; Set to 1 if one player is airborne while the other isn't

zp_plr1_cur_anim = $8E  ;
zp_plr2_cur_anim = $8F  ;

zp_plr1_anim_frame = $90     ;
zp_plr2_anim_frame = $91     ;

zp_short_counter_target = $92     ;
zp_short_counter = $94     ;
zp_chr_bank_0 = $96     ;
zp_chr_bank_1 = $97     ;
zp_99 = $99     ;
zp_9A = $9A     ;
zp_9B = $9B     ;
zp_players_x_distance = $9C ;
zp_players_y_distance = $9D ;
zp_9E = $9E     ;
zp_match_time = $9F ;

zp_16bit_lo = $A0     ;
zp_16bit_hi = $A1     ;
zp_A2 = $A2     ;
zp_plr1_fgtr_idx_clean = $A3    ; Fighter index without flags
zp_plr2_fgtr_idx_clean = $A4    ; Fighter index without flags

; This basically represents missing health / hits taken
zp_plr1_damage = $A5    ;
; This basically represents missing health / hits taken
zp_plr2_damage = $A6    ;

; This will count down while damage is applied point by point
zp_plr1_dmg_counter = $A7   ;
zp_plr2_dmg_counter = $A8   ;

zp_key_combo_hits = $A9     ;
zp_AD = $AD     ;

zp_BD = $BD     ;

zp_D1 = $D1     ;

zp_consecutive_hits_taken = $E5     ;
zp_E6 = $E6     ;
zp_E7 = $E7     ;
zp_E9 = $E9     ;
;zp_EB = $EB     ;
;zp_ED = $ED     ;

; Determines how many points to add to a player's score
zp_gained_score_idx = $EF   ; 0 to 4 (low to high)

zp_last_player_hit = $F0    ; Index (0 or 1) of last player hit by non-ranged attack
zp_counter_var_F1 = $F1     ;
zp_plr1_fighter_idx = $F2     ;
zp_plr2_fighter_idx = $F3     ;
zp_F4 = $F4     ;
zp_F5 = $F5     ;
; After this has been set to 1, IRQ handling subroutines will be used
zp_mmc3_irq_ready = $F6     ;
zp_F7 = $F7     ;
; Copy of the value last written in the MMC3 Bank Select register for PRG ROM
zp_bank_select_value = $FC ;
zp_FD = $FD     ;
; Used for indirect addressing by sound routines (low byte)
zp_sndptr_lo = $FE     ;
; Used for indirect addressing by sound routines (high byte)
zp_sndptr_hi = $FF     ;


; -----------------------------------------------------------------------------
;
;                           System RAM variables
;
; -----------------------------------------------------------------------------

ram_0100 = $0100    ;

; OAM data ready to be transferred to the PPU
ram_oam_data = $0200    ;
ram_0220 = $0220    ;
ram_0240 = $0240    ;
ram_0260 = $0260    ;
ram_0280 = $0280    ;
ram_02A0 = $02A0    ;
ram_02C0 = $02C0    ;
ram_02E0 = $02E0    ;

; Local copy of OAM data to be written/modified before being sent to the PPU
ram_oam_copy_ypos = $0300   ;
ram_oam_copy_tileid = $0301 ;
ram_oam_copy_attr = $0302   ;
ram_oam_copy_xpos = $0303   ;
ram_0304 = $0304    ;
ram_0305 = $0305    ;
ram_0306 = $0306    ;
ram_0307 = $0307    ;
ram_0308 = $0308    ;
ram_0309 = $0309    ;
ram_030A = $030A    ;
ram_030B = $030B    ;
ram_030C = $030C    ;
ram_030D = $030D    ;
ram_030E = $030E    ;
ram_030F = $030F    ;
ram_0310 = $0310    ;
ram_0311 = $0311    ;
ram_0312 = $0312    ;
ram_0313 = $0313    ;
ram_0320 = $0320    ;
ram_0340 = $0340    ;
ram_0360 = $0360    ;
ram_0370 = $0370    ;
ram_0371 = $0371    ;
ram_0372 = $0372    ;
ram_0373 = $0373    ;
ram_0374 = $0374    ;
ram_0376 = $0376    ;
ram_0377 = $0377    ;
ram_037A = $037A    ;
ram_0378 = $0378    ;
ram_037B = $037B    ;
ram_037C = $037C    ;
ram_037E = $037E    ;
ram_037F = $037F    ;
ram_0380 = $0380    ;
ram_03A0 = $03A0    ;
ram_03C0 = $03C0    ;
ram_03E0 = $03E0    ;

ram_0400 = $0400    ;
ram_0401 = $0401    ;
ram_0402 = $0402    ;
ram_0403 = $0403    ;
ram_0404 = $0404    ;
ram_0405 = $0405    ;
ram_0409 = $0409    ;
ram_040A = $040A    ;
ram_040B = $040B    ;
ram_040C = $040C    ;
ram_plr1_rounds_won = $040D    ;
ram_plr2_rounds_won = $040E    ;
ram_game_mode_initialised = $040F    ;
; Index for tables of pointers
; Used choose an IRQ handling routine and others
ram_irq_routine_idx = $0410 ;
ram_0411 = $0411    ;
ram_0414 = $0414    ;
ram_0416 = $0416    ;
ram_0418 = $0418    ;
ram_0419 = $0419    ;
ram_041F = $041F    ;
ram_0421 = $0421    ;
ram_041A = $041A    ;
; The NMI routine will write this to the MMC3 latch register
ram_irq_latch_value = $041C    ;
ram_0422 = $0422    ;
; This location will contain a jump to the variable MMC3 IRQ handler
; Routines can change the pointer to a different routine
ram_irq_trampoline = $0423  ;
; The subroutine at this address will be called by the IRQ handler
ram_irq_ptr_lo = $0424  ;
; The subroutine at this address will be called by the IRQ handler
ram_irq_ptr_hi = $0425  ;
ram_0429 = $0429    ;
ram_042A = $042A    ;
; Very Easy to Very Hard (0-4)
ram_difficulty_setting = $042C    ;
ram_042D = $042D    ;
ram_irq_state_var = $0435 ; Used in IRQ routines as a substate indicator
ram_ranged_atk_x_pos = $0436    ; Ranged attack hit box coordinate
ram_0438 = $0438    ;
ram_043D = $043D    ;
ram_special_atk_idx = $043E    ;
ram_irq_counter_0 = $043F ; Used in IRQ routines as a counter (e.g. for parallax scrolling)
ram_irq_counter_1 = $0440    ;

; This buffer will be copied to the PPU during vblank
ram_ppu_data_buffer = $0600 ; Size=63
; The last two bytes are also used to store the tile indices for the match timer
ram_match_time_tens = $063E     ; Tile ID for tens
ram_match_timer_units = $063F   ; Tile ID for units

ram_0640 = $0640    ;
ram_066D = $066D    ;
ram_066E = $066E    ;

ram_selected_opt = $0670    ; Sound test menu variable

; Index of the SFX to play starting from the next frame
ram_req_sfx = $0672    ;
; Index of the music track to play
; Can be used for SFX too, but it's meant to "request" music
; Requesting the same track that is already playing has no effect
ram_req_song = $0673    ;
; Index of the music track currently playing (or last played)
ram_cur_song = $0674    ;

ram_0675 = $0675    ;
;ram_0678 = $0678    ;
;ram_0679 = $0679    ;
;ram_067B = $067B    ;

ram_067C = $067C    ; Set twice, but potentially unused
ram_067D = $067D    ; Set twice, but potentially unused
;ram_067E = $067E    ; Set once, but potentially unused
;ram_067F = $067F    ; Set once, but potentially unused

ram_0680 = $0680    ;
ram_0681 = $0681    ;
ram_0682 = $0682    ;

ram_opponent_idx = $06C0    ;
ram_06C3 = $06C3    ;
ram_mirror_opp_idx = $06C6    ;
ram_06CD = $06CD    ;

; ----------------

; One per channel
ram_apu_output_volume = $06E0

; ----------------
; Will contain 1 after the APU and sound engine have been initialised
; Nothing will play while this is set to zero
ram_snd_initialised = $06F0    ;
; Up to eight song/sfx indices to play ($FF = nothing is playing)
ram_snd_stack = $06F1   ; Size=8
ram_cur_apu_channel = $06F9 ;
; The four APU channels are used both for music and sfx, and each will have
; variables in RAM at different offsets. Music starts at offset 0, using 118
; bytes of RAM, so sound effects start from offset $76.
; This way, we can reuse the same base addresses, for example $70C,X
; would be $70D for music square channel 0, and $783 for sfx square channel 0
ram_cur_channel_offset = $06FA    ;
; The four APU channels are used both for music and sfx, and each will have
; variables in RAM at different offsets. Music starts at offset 0, using 118
; bytes of RAM, so sound effects start from offset $76.
; This way, we can reuse the same base addresses, for example $70C,X
; would be $70D for music square channel 0, and $783 for sfx square channel 0
; This is an offset for pointers, so it is 2-byte aligned: 0, 2, 4, 6, 8, 10...
ram_cur_chan_ptr_offset = $06FB    ;
; When this flag is 1, the current track segment will forcibly on the next frame
; One bit per channel ($00-$0F)
ram_track_skip_flag = $06FC     ; Size=1
; ----------------

; This value will be added to note period index
ram_note_transpose_value = $0700    ; Size=3
; ----------------
; Index of the arpeggio, or $FF is no arpeggio is active
ram_arpeggio_idx = $0703    ; Size=4
; Pointer to arpeggio data
ram_arpeggio_ptr_lo = $0707 ;
; Pointer to arpeggio data
ram_arpeggio_ptr_hi = $0708 ;
; ----------------
; Backup pointer, used to jump back to track after calling a subsegment
ram_track_ptr_backup_lo = $070F    ;
; Backup pointer, used to jump back to track after calling a subsegment
ram_track_ptr_backup_hi = $0710    ;
; Pointer to the track data for each channel
ram_track_ptr_lo = $0719    ;
; Pointer to the track data for each channel
ram_track_ptr_hi = $071A    ;
; Music/SFX speed value (interval in frames between events)
;ram_track_speed = $0723     ;
; Number of frames this note should last
ram_cur_note_duration = $0723   ; Size=5
; Frame counter, starts from track speed and counts down to zero
; Events are only processed when this reaches zero
; For example, at speed 4 a note with duration 2 lasts 8 frames
ram_track_speed_counter = $0728 ; Use pointer offset to index
; "Ticks" left for current note to play (total note frames = ticks * speed)
ram_note_ticks_left = $0729    ; Use pointer offset to index
; Base value for the period register, before applying envelopes and effects
ram_base_period_lo = $0732   ;
; Base value for the period register, before applying envelopes and effects
ram_base_period_hi = $0733   ;
; Modified note period, after applying envelopes and effects
ram_note_period_lo = $073A  ;
; Modified note period, after applying envelopes and effects
ram_note_period_hi = $073B  ;
; ----------------
ram_note_slide_counter = $0742  ; Size=4
; ----------------
; Index of duty envelope, one per channel
ram_vol_env_idx = $0746             ; Size=5
; Ticks left for current value of instrument's volume evenlope
ram_cur_vol_env_duration = $074B    ; Size=5
; Pointer to current position in volume envelope (one per channel)
ram_vol_env_ptr_lo = $0750    ;
; Pointer to current position in volume envelope (one per channel)
ram_vol_env_ptr_hi = $0751    ;
; ----------------
; Index of duty envelope, one per channel (only used for Square wave channels)
ram_duty_env_idx = $075A    ; Size=2
; Ticks left for current value of instrument's duty evenlope
ram_duty_env_ptr_lo = $075C ;
ram_duty_env_ptr_hi = $075D ;
; ----------------
; Pitch evelope indices, one per channel
ram_pitch_env_idx = $0760   ; Size=3
; Ticks left for current value of instrument's pitch evenlope
ram_cur_pitch_env_duration = $0763  ; Size=3
; ----------------
; Pointer to the current position in the pitch envelope
ram_pitch_env_ptr_lo = $0766    ; Ptrs=3
; Pointer to the current position in the pitch envelope
ram_pitch_env_ptr_hi = $0767    ; Ptrs=3
; Index of the note currently being played
ram_cur_note_idx = $076C    ; Size=4
; APU channel being currently processed: $00-$04 for music, $10-$14 for sfx
; Music/SFX speed value (interval in frames between events)
ram_track_speed = $770  ;
; When this counter reaches zero, the current note is prematurely cut
; (i.e. all envelopes stop, note index becomes zero)
ram_delayed_cut_counter = $0774 ;
; Starts envelopes for the note "cached" in the delayed note index byte
; when this counter reaches zero
ram_note_delay_counter = $0778  ;
; Frame counter before current note is transposed
ram_transpose_counter = $0771   ;
; Index of the note that is being delayed
ram_delayed_note_idx = $077C    ;
; ----------------

; Pointer to the track data for each channel (SFX 0)
ram_sfx0_data_ptr_lo = $0799    ;
; Pointer to the track data for each channel (SFX 0)
ram_sfx0_ptr_data_hi = $079A    ;
; Pointer to the track data for each channel (SFX 1)
ram_sfx1_data_ptr_lo = $079B    ;
; Pointer to the track data for each channel (SFX 1)
ram_sfx1_data_ptr_hi = $079C    ;
; Pointer to the track data for each channel (SFX 2)
ram_sfx2_data_ptr_lo = $079D    ;
; Pointer to the track data for each channel (SFX 2)
ram_sfx2_data_ptr_hi = $079E    ;
; Pointer to the track data for each channel (SFX 3)
ram_sfx3_data_ptr_lo = $079F    ;
; Pointer to the track data for each channel (SFX 3)
ram_sfx3_data_ptr_hi = $07A0    ;
; ----------------
ram_sfx_vol_env_duration = $07CB    ;
ram_sfx_duty_env_idx = $07DA        ; Size=2
ram_sfx_pitch_env_duration = $07E3  ;


; -----------------------------------------------------------------------------
;
;                           I/O Mapped Registers
;
; -----------------------------------------------------------------------------

; Descriptions mostly taken from NES Dev Wiki (https://www.nesdev.org/wiki/)

;VPHB SINN
;(V) NMI enable
;(P) PPU master/slave
;(H) Sprite height
;(B) Background tile select
; ----
;(S) Sprite tile select
;(I) Increment mode
;(NN) Nametable select
PpuControl_2000  = $2000    ;
;BGRs bMmG
;(B) Emphasise Blue
;(G) Emphasise Green (red on PAL/Dendy)
;(R) Emphasise Red (green on PAL/Dendy)
;(s) 1: Show sprites
; ----
;(b) 1: Show background
;(M) 1: Show sprites in leftmost 8 pixels of screen, 0: Hide
;(m) 1: Show background in leftmost 8 pixels of screen, 0: Hide
;(G) Greyscale (0: normal colour, 1: produce a greyscale display)
PpuMask_2001     = $2001    ;
;VSO- ----
;(V) vblanks
;(S) sprite 0 hit
;(O) sprite overflow
; Note: read resets write pair for $2005/$2006
PpuStatus_2002   = $2002    ;

OamAddr_2003     = $2003    ;
OamData_2004     = $2004    ;

PpuScroll_2005   = $2005    ;
PpuAddr_2006     = $2006    ;
PpuData_2007     = $2007    ;

;DDLC VVVV
;Duty (D), envelope loop / length counter halt (L), constant volume (C)
;Volume/envelope (V)
Sq0Duty_4000     = $4000    ;
;EPPP NSSS
;Sweep unit: enabled (E), period (P)
;Negate (N), shift (S)
Sq0Sweep_4001    = $4001    ;
;TTTT TTTT
;Timer low (T)
Sq0Timer_4002    = $4002    ;
;LLLL LTTT
;Length counter load (L), timer high (T)
Sq0Length_4003   = $4003    ;
;DDLC VVVV
;Duty (D), envelope loop / length counter halt (L), constant volume (C)
;Volume/envelope (V)
Sq1Duty_4004     = $4004    ;
;EPPP NSSS
;Sweep unit: enabled (E), period (P)
;Negate (N), shift (S)
Sq1Sweep_4005    = $4005    ;
;TTTT TTTT
;Timer low (T)
Sq1Timer_4006    = $4006    ;
;LLLL LTTT
;Length counter load (L), timer high (T)
Sq1Length_4007   = $4007    ;
;CRRR RRRR
;Length counter halt / linear counter control (C), linear counter load (R)
TrgLinear_4008   = $4008    ;
;TTTT TTTT
;Timer low (T)
TrgTimer_400A    = $400A    ;
;LLLL LTTT
;Length counter load (L), timer high (T)
TrgLength_400B   = $400B    ;
;--LC VVVV
;Envelope loop / length counter halt (L), constant volume (C)
;Volume/envelope (V)
NoiseVolume_400C = $400C    ;
;L--- PPPP
;Loop noise (L), noise period (P)
NoisePeriod_400E = $400E    ;
;LLLL L---
;Length counter load (L)
NoiseLength_400F = $400F    ;
;IL-- RRRR
;IRQ enable (I), loop (L), frequency (R)
DmcFreq_4010     = $4010    ;
;-DDD DDDD
;Load counter (D)
DmcCounter_4011  = $4011    ;
;AAAA AAAA
;Sample address (A)
DmcAddress_4012  = $4012    ;
;LLLL LLLL
;Sample length (L)
DmcLength_4013   = $4013    ;

SpriteDma_4014   = $4014    ;

;Read:
;IF-D NT21
;DMC interrupt (I), frame interrupt (F), DMC active (D)
;Length counter > 0 (N/T/2/1)
;
;Write:
;---D NT21
;Enable DMC (D), noise (N), triangle (T), and pulse channels (2/1)
ApuStatus_4015   = $4015    ;

Ctrl1_4016       = $4016    ;
Ctrl2_FrameCtr_4017 = $4017 ;


; -----------------------------------------------------------------------------
;
;                               MMC3 registers
;
; -----------------------------------------------------------------------------

; CPxx xRRR
; (C) CHR A12 inversion (0: two 2 KB banks at $0000-$0FFF, four 1 KB banks at $1000-$1FFF;
;                        1: two 2 KB banks at $1000-$1FFF, four 1 KB banks at $0000-$0FFF)
; (P) PRG ROM bank mode (0: $8000-$9FFF swappable, $C000-$DFFF fixed to second-last bank;
;                        1: $C000-$DFFF swappable, $8000-$9FFF fixed to second-last bank)
; (RRR) Specify which bank register to update on next write to Bank Data register
;                      000: R0: Select 2 KB CHR bank at PPU $0000-$07FF (or $1000-$17FF)
;                      001: R1: Select 2 KB CHR bank at PPU $0800-$0FFF (or $1800-$1FFF)
;                      010: R2: Select 1 KB CHR bank at PPU $1000-$13FF (or $0000-$03FF)
;                      011: R3: Select 1 KB CHR bank at PPU $1400-$17FF (or $0400-$07FF)
;                      100: R4: Select 1 KB CHR bank at PPU $1800-$1BFF (or $0800-$0BFF)
;                      101: R5: Select 1 KB CHR bank at PPU $1C00-$1FFF (or $0C00-$0FFF)
;                      110: R6: Select 8 KB PRG ROM bank at $8000-$9FFF (or $C000-$DFFF)
;                      111: R7: Select 8 KB PRG ROM bank at $A000-$BFFF
mmc3_bank_select = $8000    ;
; DDDD DDDD
; New bank value, based on last value written to Bank select register
mmc3_bank_data = $8001      ;
; xxxx xxxM
; (M) Nametable mirroring (0: vertical; 1: horizontal)
mmc3_mirroring = $A000      ;
; RWxx xxxx
; (R) PRG RAM chip enable (0: disable; 1: enable)
; (W) Write protection (0: allow writes; 1: deny writes)
mmc3_ram_protect = $A001    ;

mmc3_irq_latch = $C000      ;
mmc3_irq_reload = $C001     ;

mmc3_irq_disable = $E000    ;
mmc3_irq_enable = $E001     ;
