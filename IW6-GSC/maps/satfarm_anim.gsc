/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\satfarm_anim.gsc
*****************************************************/

main() {
  generic_human();
  dialogue();
  player_anims();
  animated_prop_anims();
  vehicle_anims();
  script_model_anims();
  vehicles_anims();
  maps\_minigun_viewmodel::anim_minigun_hands();
}

#using_animtree("generic_human");

generic_human() {
  level.scr_anim["crawl_death_1"]["crawl"] = % civilian_crawl_1;
  level.scr_anim["crawl_death_1"]["death"][0] = % civilian_crawl_1_death_a;
  level.scr_anim["crawl_death_1"]["death"][1] = % civilian_crawl_1_death_b;
  level.scr_anim["crawl_death_1"]["blood_fx_rate"] = 0.5;
  level.scr_anim["crawl_death_1"]["blood_fx"] = "blood_drip";
  level.scr_anim["crawl_death_2"]["crawl"] = % civilian_crawl_2;
  level.scr_anim["crawl_death_2"]["death"][0] = % civilian_crawl_2_death_a;
  level.scr_anim["crawl_death_2"]["death"][1] = % civilian_crawl_2_death_b;
  level.scr_anim["crawl_death_2"]["blood_fx_rate"] = 0.25;
  level.scr_anim["wounded_ai"]["wounded_limp_jog"] = % vegas_baker_limp_jog;
  level.scr_anim["wounded_ai"]["wounded_limp_run"] = % vegas_baker_run_pain;
  level.scr_anim["generic"]["combat_jog_lookback"] = % combat_jog_lookback;
  level.scr_anim["generic"]["payback_escape_dodge_debris_price"] = % payback_escape_dodge_debris_price;
  level.scr_anim["generic"]["payback_escape_rpg_react_price"] = % payback_escape_rpg_react_price;
  level.scr_anim["generic"]["payback_escape_start_backpedal_price"] = % payback_escape_start_backpedal_price;
  level.scr_anim["generic"]["payback_escape_start_wave_soap"] = % payback_escape_start_wave_soap;
  level.scr_anim["generic"]["death_explosion_back13"] = % death_explosion_back13;
  level.scr_anim["generic"]["satfarm_hangar_breach_enemy_run_a"] = % satfarm_hangar_breach_enemy_run_a;
  level.scr_anim["generic"]["satfarm_hangar_breach_enemy_run_b"] = % satfarm_hangar_breach_enemy_run_b;
  level.scr_anim["generic"]["satfarm_hangar_breach_enemy_run_c"] = % satfarm_hangar_breach_enemy_run_c;
  level.scr_anim["generic"]["satfarm_hangar_breach_enemy_run_d"] = % satfarm_hangar_breach_enemy_run_d;
  level.scr_anim["generic"]["satfarm_hangar_breach_enemy_run_e"] = % satfarm_hangar_breach_enemy_run_e;
  level.scr_anim["generic"]["satfarm_hangar_breach_enemy_crush"] = % satfarm_hangar_breach_enemy_crush;
  level.scr_anim["generic"]["spotter_on_radio_idle"][0] = % roadkill_cover_radio_soldier2;
  level.scr_anim["hesh"]["satfarm_control_tower_intro_hesh_talk"] = % satfarm_control_tower_intro_hesh_talk;
  level.scr_anim["hesh"]["little_bird_casual_idle_hesh"][0] = % satfarm_control_tower_intro_hero;
  level.scr_anim["hesh"]["satfarm_control_tower_transition_hesh"] = % satfarm_control_tower_transition_hero;
  level.scr_anim["hesh"]["satfarm_control_tower_alert_hesh"][0] = % satfarm_control_tower_alert_hero;
  level.scr_anim["hesh"]["satfarm_control_tower_hesh"] = % satfarm_control_tower_merrick;
  level.scr_anim["merrick"]["little_bird_casual_idle_merrick"][0] = % little_bird_casual_idle_guy2;
  level.scr_anim["merrick"]["satfarm_control_tower_alert_merrick"][0] = % satfarm_control_tower_alert_hero2;
  level.scr_anim["merrick"]["satfarm_control_tower_transition_merrick"] = % satfarm_control_tower_keegan;
  level.scr_anim["hesh"]["breach_enter"] = % satfarm_tower_breach_hesh_enter;
  level.scr_anim["hesh"]["breach_loop"][0] = % satfarm_tower_breach_hesh_loop;
  level.scr_anim["hesh"]["breach_breach"] = % satfarm_tower_breach_hesh_breach;
  level.scr_anim["generic"]["breach_react_push_guy1"] = % breach_react_push_guy1;
  level.scr_anim["generic"]["exposed_death_blowback"] = % exposed_death_blowback;
  level.scr_anim["generic"]["breach_react_push_guy2"] = % breach_react_push_guy2;
  level.scr_anim["generic"]["exposed_crouch_death_twist"] = % exposed_crouch_death_twist;
  level.scr_anim["generic"]["parabolic_phoneguy_reaction"] = % parabolic_phoneguy_reaction;
  level.scr_anim["generic"]["exposed_death_twist"] = % exposed_death_twist;
  level.scr_anim["generic"]["payback_breach_doorguy"] = % payback_breach_doorguy;
  level.scr_anim["generic"]["satfarm_tower_breach_guard_breach"] = % satfarm_tower_breach_guard_breach;
  level.scr_anim["generic"]["satfarm_tower_launch_dead_loop"][0] = % satfarm_tower_launch_dead_loop;
  level.scr_anim["generic"]["satfarm_tower_launch_dead_exit"] = % satfarm_tower_launch_dead_exit;
  level.scr_anim["hesh"]["satfarm_tower_launch_hesh_intro"] = % satfarm_tower_launch_hesh_intro;
  maps\_anim::addnotetrack_notify("hesh", "ps_satfarm_hsh_overlordlaunchroomsecure", "launch_room_secure_notify", "satfarm_tower_launch_hesh_intro");
  maps\_anim::addnotetrack_notify("hesh", "ps_satfarm_hsh_commandtrajectoryupdated", "trajectory_updated_notify", "satfarm_tower_launch_hesh_intro");
  maps\_anim::addnotetrack_notify("hesh", "ps_satfarm_hsh_beadvisedthearea", "be_advised_notify", "satfarm_tower_launch_hesh_intro");
  level.scr_anim["hesh"]["satfarm_tower_launch_hesh_loop"][0] = % satfarm_tower_launch_hesh_loop;
  level.scr_anim["hesh"]["satfarm_tower_launch_hesh_loop2"][0] = % satfarm_tower_launch_hesh_loop2;
  level.scr_anim["hesh"]["satfarm_tower_launch_hesh_exit"] = % satfarm_tower_launch_hesh_exit;
  maps\_anim::addnotetrack_notify("hesh", "ps_satfarm_hsh_overlordpayloadisaway", "payload_is_away_notify", "satfarm_tower_launch_hesh_exit");
  maps\_anim::addnotetrack_notify("hesh", "ps_satfarm_hsh_youhearthisits", "you_hear_this_notify", "satfarm_tower_launch_hesh_exit");
  level.scr_anim["hesh"]["door_kick_in"] = % doorkick_2_cqbrun;
  level.scr_anim["generic"]["clockwork_chaos_wave_guard"] = % clockwork_chaos_wave_guard;
  level.scr_anim["generic"]["warehouse_lift_enemy_1_loop"][0] = % clockwork_chaos_extinguisher_loop_guard;
  level.scr_anim["generic"]["warehouse_lift_enemy_2"] = % killhouse_gaz_idlea;
  level.scr_anim["generic"]["warehouse_lift_enemy_2_loop"][0] = % killhouse_gaz_talk_side;
  level.scr_anim["generic"]["roadkill_shepherd_shout_sequence"] = % roadkill_shepherd_shout_sequence;
  level.scr_anim["generic"]["payback_escape_forward_wave_left_soap"] = % payback_escape_forward_wave_left_soap;
  level.scr_anim["hesh"]["satfarm_train_jump_straight_run"] = % satfarm_train_jump_straight_run;
  level.scr_anim["intro_tankman"]["intro"] = % satfarm_cargobay_tankman;
  level.scr_anim["intro_commander"]["intro"] = % satfarm_cargobay_commander;
  level.scr_anim["intro_crateman"]["intro"] = % satfarm_cargobay_crateman;
  level.scr_anim["intro_crewmaster"]["intro"] = % satfarm_cargobay_crewmaster;
  level.scr_anim["intro_helper"]["intro"] = % satfarm_cargobay_helper;
  level.scr_anim["intro_lieutenant"]["intro"] = % satfarm_cargobay_lieutenant;
  level.scr_anim["intro_soldier1"]["intro"] = % satfarm_cargobay_soldier1;
  level.scr_anim["intro_soldier2"]["intro"] = % satfarm_cargobay_soldier2;
  level.scr_anim["intro_turretman"]["intro"] = % satfarm_cargobay_turretman;
  level.scr_anim["tank_loader"]["idle_reload"] = % abrams_loader_load;
  level.scr_anim["intro_crewmember1"]["intro"] = % satfarm_infil_c17_crewmember1;
  level.scr_anim["cargobay_tankdriver"]["c17_tank_scene"] = % satfarm_cargobay_tankdriver;
  level.scr_anim["cargobay_tankcopilot"]["c17_tank_scene"] = % satfarm_cargobay_tankcopilot;
}

dialogue() {
  level.scr_sound["hesh"]["satfarm_hsh_loganlaunchit"] = "satfarm_hsh_loganlaunchit";
  level.scr_face["hesh"]["satfarm_hsh_loganlaunchit"] = % satfarm_tower_hesh_loganlaunchit;
  level.scr_sound["hesh"]["satfarm_hsh_launchthewarhead"] = "satfarm_hsh_launchthewarhead";
  level.scr_face["hesh"]["satfarm_hsh_launchthewarhead"] = % satfarm_tower_hesh_launchthewarhead;
}

#using_animtree("player");

player_anims() {
  level.scr_animtree["player_arms"] = #animtree;
  level.scr_model["player_arms"] = "viewhands_player_gs_stealth";
  level.scr_anim["player_arms"]["satfarm_control_tower_player"] = % satfarm_control_tower_player;
  level.scr_anim["player_arms"]["missile_launch_button_press"] = % satfarm_tower_launch_player;
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewhands_player_us_rangers";
  level.scr_anim["player_rig"]["c17_tank_scene"] = % satfarm_cargobay_player;
  level.scr_animtree["player_rig_legs"] = #animtree;
  level.scr_model["player_rig_legs"] = "viewlegs_us_ranger";
  level.scr_anim["player_rig_legs"]["c17_tank_scene"] = % satfarm_cargobay_playerlegs;
}

#using_animtree("animated_props");

animated_prop_anims() {
  level.scr_animtree["satfarm_cargo_crates_in_back_gpr"] = #animtree;
  level.scr_model["satfarm_cargo_crates_in_back_gpr"] = "generic_prop_raven";
  level.scr_anim["satfarm_cargo_crates_in_back_gpr"]["intro"] = % satfarm_cargobay_crates_in_back;
  level.scr_animtree["satfarm_cargobay_basecrates_gpr"] = #animtree;
  level.scr_model["satfarm_cargobay_basecrates_gpr"] = "generic_prop_raven";
  level.scr_anim["satfarm_cargobay_basecrates_gpr"]["intro"] = % satfarm_cargobay_basecrates;
  level.scr_animtree["satfarm_cargobay_topcrate_and_toolbox_gpr"] = #animtree;
  level.scr_model["satfarm_cargobay_topcrate_and_toolbox_gpr"] = "generic_prop_raven";
  level.scr_anim["satfarm_cargobay_topcrate_and_toolbox_gpr"]["intro"] = % satfarm_cargobay_topcrate_and_toolbox;
  level.scr_animtree["satfarm_cargobay_humveecargo_gpr"] = #animtree;
  level.scr_model["satfarm_cargobay_humveecargo_gpr"] = "generic_prop_raven";
  level.scr_anim["satfarm_cargobay_humveecargo_gpr"]["intro"] = % satfarm_cargobay_humveecargo;
  level.scr_animtree["satfarm_infil_falling_crates1"] = #animtree;
  level.scr_model["satfarm_infil_falling_crates1"] = "generic_prop_raven";
  level.scr_anim["satfarm_infil_falling_crates1"]["intro"] = % satfarm_infil_falling_crates1;
  level.scr_animtree["satfarm_infil_falling_crates2"] = #animtree;
  level.scr_model["satfarm_infil_falling_crates2"] = "generic_prop_raven";
  level.scr_anim["satfarm_infil_falling_crates2"]["intro"] = % satfarm_infil_falling_crates2;
  level.scr_animtree["satfarm_hangar_breach_s1"] = #animtree;
  level.scr_model["satfarm_hangar_breach_s1"] = "saf_hangar_breach_01";
  level.scr_anim["satfarm_hangar_breach_s1"]["satfarm_hangar_breach_s1"] = % satfarm_hangar_breach_s1;
  level.scr_animtree["satfarm_hangar_breach_s2"] = #animtree;
  level.scr_model["satfarm_hangar_breach_s2"] = "saf_hangar_breach_02";
  level.scr_anim["satfarm_hangar_breach_s2"]["satfarm_hangar_breach_s2"] = % satfarm_hangar_breach_s2;
  level.scr_animtree["satfarm_hangar_breach_s3"] = #animtree;
  level.scr_model["satfarm_hangar_breach_s3"] = "saf_hangar_breach_03";
  level.scr_anim["satfarm_hangar_breach_s3"]["satfarm_hangar_breach_s3"] = % satfarm_hangar_breach_s3;
  level.scr_animtree["satfarm_hangar_breach_s4"] = #animtree;
  level.scr_model["satfarm_hangar_breach_s4"] = "saf_hangar_breach_04";
  level.scr_anim["satfarm_hangar_breach_s4"]["satfarm_hangar_breach_s4"] = % satfarm_hangar_breach_s4;
  level.scr_animtree["tank_ambient"] = #animtree;
  level.scr_model["tank_ambient"] = "vehicle_m1a2_abrams_iw6";
  level.scr_anim["tank_ambient"]["ambient_drop"] = % satfarm_ambient_tank_drop_m1a1;
  level.scr_animtree["c17_ambient"] = #animtree;
  level.scr_model["c17_ambient"] = "vehicle_boeing_c17";
  level.scr_anim["c17_ambient"]["ambient_drop"] = % satfarm_ambient_tank_drop_c17;
  level.scr_animtree["pilot_chute_tank_ambient"] = #animtree;
  level.scr_model["pilot_chute_tank_ambient"] = "saf_parachute_small";
  level.scr_anim["pilot_chute_tank_ambient"]["pilot_chute_deploy"] = % satfarm_ambient_tank_drop_pilotchute;
  level.scr_animtree["main_chute0_tank_ambient"] = #animtree;
  level.scr_model["main_chute0_tank_ambient"] = "saf_parachute_large";
  level.scr_anim["main_chute0_tank_ambient"]["main_chute_deploy"] = % satfarm_ambient_tank_drop_mainchute1;
  level.scr_animtree["main_chute1_tank_ambient"] = #animtree;
  level.scr_model["main_chute1_tank_ambient"] = "saf_parachute_large";
  level.scr_anim["main_chute1_tank_ambient"]["main_chute_deploy"] = % satfarm_ambient_tank_drop_mainchute2;
  level.scr_animtree["main_chute2_tank_ambient"] = #animtree;
  level.scr_model["main_chute2_tank_ambient"] = "saf_parachute_large";
  level.scr_anim["main_chute2_tank_ambient"]["main_chute_deploy"] = % satfarm_ambient_tank_drop_mainchute3;
  level.scr_animtree["playertank_fake"] = #animtree;
  level.scr_model["playertank_fake"] = "vehicle_m1a2_abrams_viewmodel";
  level.scr_anim["playertank_fake"]["intro"] = % satfarm_infil_playertank_conveyed_back;
  level.scr_animtree["playertank"] = #animtree;
  level.scr_anim["playertank"]["intro"] = % satfarm_infil_playertank;
  level.scr_animtree["crashedtank"] = #animtree;
  level.scr_model["crashedtank"] = "vehicle_m1a2_abrams_iw6_non_anim";
  level.scr_anim["crashedtank"]["intro"] = % satfarm_infil_crashedtank;
  level.scr_animtree["allytank_right"] = #animtree;
  level.scr_anim["allytank_right"]["intro"] = % satfarm_infil_allytank_right;
  level.scr_animtree["playerc17"] = #animtree;
  level.scr_model["playerc17"] = "vehicle_boeing_c17";
  level.scr_anim["playerc17"]["intro"] = % satfarm_infil_playerc17;
  level.scr_animtree["crashedc17"] = #animtree;
  level.scr_model["crashedc17"] = "vehicle_boeing_c17";
  level.scr_anim["crashedc17"]["intro"] = % satfarm_infil_crashedc17;
  level.scr_animtree["allyc17_right"] = #animtree;
  level.scr_model["allyc17_right"] = "vehicle_boeing_c17";
  level.scr_anim["allyc17_right"]["intro"] = % satfarm_infil_allyc17_right;
  level.scr_animtree["pilot_chute_player"] = #animtree;
  level.scr_model["pilot_chute_player"] = "saf_parachute_small";
  level.scr_anim["pilot_chute_player"]["pilot_chute_deploy"] = % satfarm_infil_pilotchute_player;
  level.scr_animtree["pilot_chute_crashedtank"] = #animtree;
  level.scr_model["pilot_chute_crashedtank"] = "saf_parachute_small";
  level.scr_anim["pilot_chute_crashedtank"]["pilot_chute_deploy"] = % satfarm_infil_pilotchute_crashedtank;
  level.scr_animtree["pilot_chute_allytankright"] = #animtree;
  level.scr_model["pilot_chute_allytankright"] = "saf_parachute_small";
  level.scr_anim["pilot_chute_allytankright"]["pilot_chute_deploy"] = % satfarm_infil_pilotchute_allytankright;
  level.scr_animtree["main_chute0_player"] = #animtree;
  level.scr_model["main_chute0_player"] = "saf_parachute_large";
  level.scr_anim["main_chute0_player"]["main_chute_deploy"] = % satfarm_infil_mainchute1_player;
  level.scr_animtree["main_chute1_player"] = #animtree;
  level.scr_model["main_chute1_player"] = "saf_parachute_large";
  level.scr_anim["main_chute1_player"]["main_chute_deploy"] = % satfarm_infil_mainchute2_player;
  level.scr_animtree["main_chute2_player"] = #animtree;
  level.scr_model["main_chute2_player"] = "saf_parachute_large";
  level.scr_anim["main_chute2_player"]["main_chute_deploy"] = % satfarm_infil_mainchute3_player;
  level.scr_animtree["main_chute0_crashedtank"] = #animtree;
  level.scr_model["main_chute0_crashedtank"] = "saf_parachute_large";
  level.scr_anim["main_chute0_crashedtank"]["main_chute_deploy"] = % satfarm_infil_mainchute1_crashedtank;
  level.scr_animtree["main_chute1_crashedtank"] = #animtree;
  level.scr_model["main_chute1_crashedtank"] = "saf_parachute_large";
  level.scr_anim["main_chute1_crashedtank"]["main_chute_deploy"] = % satfarm_infil_mainchute2_crashedtank;
  level.scr_animtree["main_chute2_crashedtank"] = #animtree;
  level.scr_model["main_chute2_crashedtank"] = "saf_parachute_large";
  level.scr_anim["main_chute2_crashedtank"]["main_chute_deploy"] = % satfarm_infil_mainchute3_crashedtank;
  level.scr_animtree["main_chute0_allytankright"] = #animtree;
  level.scr_model["main_chute0_allytankright"] = "saf_parachute_large";
  level.scr_anim["main_chute0_allytankright"]["main_chute_deploy"] = % satfarm_infil_mainchute1_allytankright;
  level.scr_animtree["main_chute1_allytankright"] = #animtree;
  level.scr_model["main_chute1_allytankright"] = "saf_parachute_large";
  level.scr_anim["main_chute1_allytankright"]["main_chute_deploy"] = % satfarm_infil_mainchute2_allytankright;
  level.scr_animtree["main_chute2_allytankright"] = #animtree;
  level.scr_model["main_chute2_allytankright"] = "saf_parachute_large";
  level.scr_anim["main_chute2_allytankright"]["main_chute_deploy"] = % satfarm_infil_mainchute3_allytankright;
  level.scr_animtree["saf_hangar_fence_breach_fence_left"] = #animtree;
  level.scr_model["saf_hangar_fence_breach_fence_left"] = "saf_hangar_fence_breach_fence_left";
  level.scr_anim["saf_hangar_fence_breach_fence_left"]["saf_hangar_fence_breach_fence_left"] = % satfarm_hangar_breach_fence_left;
  level.scr_animtree["saf_hangar_fence_breach_fence_right"] = #animtree;
  level.scr_model["saf_hangar_fence_breach_fence_right"] = "saf_hangar_fence_breach_fence_right";
  level.scr_anim["saf_hangar_fence_breach_fence_right"]["saf_hangar_fence_breach_fence_right"] = % satfarm_hangar_breach_fence_right;
  level.scr_animtree["saf_hangar_fence_breach_gate"] = #animtree;
  level.scr_model["saf_hangar_fence_breach_gate"] = "saf_hangar_fence_breach_gate";
  level.scr_anim["saf_hangar_fence_breach_gate"]["saf_hangar_fence_breach_fence_right"] = % satfarm_hangar_breach_fence_gate_l;
  level.scr_anim["saf_hangar_fence_breach_gate"]["saf_hangar_fence_breach_fence_left"] = % satfarm_hangar_breach_fence_gate_r;
  level.scr_animtree["chopper_turret"] = #animtree;
  level.scr_model["chopper_turret"] = "weapon_blackhawk_minigun";
  level.scr_anim["chopper_turret"]["satfarm_control_tower_turret"] = % satfarm_control_tower_turret;
  level.scr_animtree["fire_extinguisher"] = #animtree;
  level.scr_model["fire_extinguisher"] = "clk_fire_extinguisher_lrg_anim";
  level.scr_anim["fire_extinguisher"]["breach_enter"] = % satfarm_tower_breach_extinguisher_enter;
  level.scr_anim["fire_extinguisher"]["breach_loop"][0] = % satfarm_tower_breach_extinguisher_loop;
  level.scr_anim["fire_extinguisher"]["breach_breach"] = % satfarm_tower_breach_extinguisher_breach;
  level.scr_animtree["breach_door_rig"] = #animtree;
  level.scr_model["breach_door_rig"] = "generic_prop_raven";
  level.scr_anim["breach_door_rig"]["satfarm_tower_breach_doors_loop"][0] = % satfarm_tower_breach_doors_loop;
  level.scr_anim["breach_door_rig"]["breach_breach"] = % satfarm_tower_breach_doors_breach;
  level.scr_animtree["missile_button_panel"] = #animtree;
  level.scr_model["missile_button_panel"] = "saf_missile_button_panel";
  level.scr_anim["missile_button_panel"]["missile_launch_button_press"] = % satfarm_tower_launch_button;
  level.scr_animtree["missile_button"] = #animtree;
  level.scr_model["missile_button"] = "saf_missile_button";
  level.scr_anim["missile_button"]["missile_launch_button_press"] = % satfarm_tower_launch_button;
  level.scr_animtree["missile_button_lit"] = #animtree;
  level.scr_model["missile_button_lit"] = "saf_missile_button_lit";
  level.scr_anim["missile_button_lit"]["missile_launch_button_press"] = % satfarm_tower_launch_button;
  level.scr_animtree["missile_button_panel_obj"] = #animtree;
  level.scr_model["missile_button_panel_obj"] = "saf_missile_button_obj_border";
  level.scr_anim["missile_button_panel_obj"]["missile_launch_button_press"] = % satfarm_tower_launch_button;
  level.scr_animtree["silo_doors"] = #animtree;
  level.scr_model["silo_doors"] = "saf_silo_doors_anim";
  level.scr_anim["silo_doors"]["silo_doors_open"] = % satfarm_missile_silo_doors_open;
  level.scr_animtree["saf_satellite_destroyed_anim_dish"] = #animtree;
  level.scr_model["saf_satellite_destroyed_anim_dish"] = "saf_satellite_destroyed_anim_dish";
  level.scr_anim["saf_satellite_destroyed_anim_dish"]["dish_collapse"] = % satfarm_hangar_dish_collapse;
  level.scr_animtree["saf_satellite_destroyed_anim_base"] = #animtree;
  level.scr_model["saf_satellite_destroyed_anim_base"] = "saf_satellite_destroyed_anim_base";
  level.scr_anim["saf_satellite_destroyed_anim_base"]["dish_collapse"] = % satfarm_hangar_dish_collapse;
  level.scr_animtree["dish_crash_a10"] = #animtree;
  level.scr_model["dish_crash_a10"] = "vehicle_a10_warthog";
  level.scr_anim["dish_crash_a10"]["dish_collapse"] = % satfarm_hangar_a10_crash;
  level.scr_animtree["caleb_diaper_01"] = #animtree;
  level.scr_model["caleb_diaper_01"] = "saf_c17_hanging_net_animated";
  level.scr_anim["caleb_diaper_01"]["intro"] = % satfarm_cargobay_net1;
  level.scr_animtree["caleb_diaper_02"] = #animtree;
  level.scr_model["caleb_diaper_02"] = "saf_c17_hanging_net_animated";
  level.scr_anim["caleb_diaper_02"]["intro"] = % satfarm_cargobay_net2;
  level.scr_animtree["windsock"] = #animtree;
  level.scr_model["windsock"] = "accessories_windsock_large";
  level.scr_anim["windsock"]["windsock_large_wind_medium"][0] = % windsock_large_wind_medium;
}

#using_animtree("vehicles");

vehicle_anims() {
  level.scr_anim["m880"]["launch_prep"] = % satfarm_m880_launch_prep;
  level.scr_anim["m880"]["launch"] = % satfarm_m880_mrls;
  level.scr_animtree["tankman_tank"] = #animtree;
  level.scr_anim["tankman_tank"]["intro"] = % satfarm_cargobay_tank;
  level.scr_model["tankman_tank"] = "vehicle_m1a2_abrams_iw6_non_anim";
}

#using_animtree("script_model");

script_model_anims() {
  level.scr_animtree["m880_missile_01"] = #animtree;
  level.scr_anim["m880_missile_01"]["m880_missile_01"] = % satfarm_m880_missile_01;
  level.scr_model["m880_missile_01"] = "projectile_slamraam_missile";
  level.scr_animtree["m880_missile_02"] = #animtree;
  level.scr_anim["m880_missile_02"]["m880_missile_02"] = % satfarm_m880_missile_02;
  level.scr_model["m880_missile_02"] = "projectile_slamraam_missile";
  level.scr_animtree["m880_missile_03"] = #animtree;
  level.scr_anim["m880_missile_03"]["m880_missile_03"] = % satfarm_m880_missile_03;
  level.scr_model["m880_missile_03"] = "projectile_slamraam_missile";
  level.scr_animtree["m880_missile_04"] = #animtree;
  level.scr_anim["m880_missile_04"]["m880_missile_04"] = % satfarm_m880_missile_04;
  level.scr_model["m880_missile_04"] = "projectile_slamraam_missile";
  level.scr_animtree["blackhawk_turret"] = #animtree;
}

#using_animtree("vehicles");

vehicles_anims() {
  level.scr_animtree["mig_flyby"] = #animtree;
  level.scr_model["mig_flyby"] = "vehicle_mig29_low";
  level.scr_anim["mig_flyby"]["flyby"] = % satfarm_bridge_mig29_flyby;
  level.scr_animtree["gaz_crush"] = #animtree;
  level.scr_model["gaz_crush"] = "vehicle_gaz_tigr_base_destroyed_crushable";
  level.scr_anim["gaz_crush"]["frontfull"] = % satfarm_bridge_gaz_crush_front;
  level.scr_anim["gaz_crush"]["rearfull"] = % satfarm_bridge_gaz_crush_rear;
  level.scr_anim["gaz_crush"]["frontadd"] = % satfarm_bridge_gaz_crush_front_additive;
  level.scr_anim["gaz_crush"]["rearadd"] = % satfarm_bridge_gaz_crush_rear_additive;
}