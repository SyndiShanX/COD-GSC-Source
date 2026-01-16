/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\black_ice_anim.gsc
*****************************************************/

main() {
  player_anims();
  generic_human_anims();
  script_model_anims();
  vehicle_anims();
}

#using_animtree("player");

player_anims() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewhands_player_us_udt";
  level.scr_anim["player_rig"]["player_intro"] = % blackice_player_intro;
  level.scr_anim["player_rig"]["player_surface_arms"] = % blackice_player_surface_arms;
  level.scr_anim["player_rig"]["player_surface_root"] = % blackice_player_surface_root;
  level.scr_anim["player_rig"]["player_surface_root_pt2"] = % blackice_player_surface_root_pt2;
  maps\_anim::addnotetrack_flag("player_rig", "surface_anim_swap", "flag_surface_anim_swap");
  level.scr_anim["player_rig"]["alpha_rig_ascend_aim"] = % blackice_player_rigascend_aim;
  level.scr_anim["player_rig"]["alpha_rig_ascend_aim_loop"][0] = % blackice_player_rigascend_aim_loop;
  level.scr_anim["player_rig"]["alpha_rig_ascend_linkup"] = % blackice_player_linkup;
  level.scr_anim["player_rig"]["alpha_rig_ascend_groundidle"][0] = % blackice_player_groundidle;
  level.scr_anim["player_rig"]["alpha_rig_ascend"] = % blackice_player_rigascend;
  level.scr_anim["player_rig"]["player_rigascend_noise"] = % blackice_player_rigascend_noise;
  level.scr_anim["player_rig"]["rigascend_noise_parent"] = % rigascend_noise;
  level.scr_anim["player_rig"]["rig_ascend_stop"] = % blackice_player_rigascend_stop;
  level.scr_anim["player_rig"]["rig_ascend_start"] = % blackice_player_rigascend_start;
  level.scr_anim["player_rig"]["rigascend_aim_left_parent"] = % rigascend_aim_left;
  level.scr_anim["player_rig"]["rigascend_aim_right_parent"] = % rigascend_aim_right;
  level.scr_anim["player_rig"]["rigascend_aim_up_parent"] = % rigascend_aim_up;
  level.scr_anim["player_rig"]["rigascend_aim_down_parent"] = % rigascend_aim_down;
  level.scr_anim["player_rig"]["rigascend_aim_left"] = % blackice_player_rigascend_aim_left;
  level.scr_anim["player_rig"]["rigascend_aim_right"] = % blackice_player_rigascend_aim_right;
  level.scr_anim["player_rig"]["rigascend_aim_up"] = % blackice_player_rigascend_aim_up;
  level.scr_anim["player_rig"]["rigascend_aim_down"] = % blackice_player_rigascend_aim_down;
  maps\_anim::addnotetrack_customfunction("player_rig", "free_look_active", ::notetrack_player_free_look_active, "alpha_rig_ascend");
  maps\_anim::addnotetrack_customfunction("player_rig", "additive_anims_start", ::notetrack_player_additive_anims_start, "alpha_rig_ascend");
  maps\_anim::addnotetrack_customfunction("player_rig", "draw_weapon", ::notetrack_player_draw_weapon_ascend, "alpha_rig_ascend");
  maps\_anim::addnotetrack_flag("player_rig", "bravo_leave", "flag_ascend_bravo_go");
  maps\_anim::addnotetrack_notify("player_rig", "change_snowfx", "notify_start_catwalks_snow", "alpha_rig_ascend");
  level.scr_anim["player_rig"]["breach"] = % blackice_commonroom_player;
  maps\_anim::addnotetrack_notify("player_rig", "start_bullets", "notify_start_bullets", "breach");
  maps\_anim::addnotetrack_notify("player_rig", "green_light_start", "notify_start_green_light", "breach");
  maps\_anim::addnotetrack_notify("player_rig", "red_light_start", "notify_start_red_light", "breach");
  maps\_anim::addnotetrack_notify("player_rig", "damage_breacher", "notify_damage_breacher", "breach");
  maps\_anim::addnotetrack_flag("player_rig", "ally_start", "flag_common_breach_ally_start", "breach");
  maps\_anim::addnotetrack_customfunction("player_rig", "draw_your_weapon", ::cw_common_breach_draw_weapon, "breach");
  level.scr_anim["player_rig"]["turn_off_flare_stack"] = % blackice_flare_stack_player;
  level.scr_anim["player_rig"]["command_start"] = % blackice_controlroom_player_start;
  level.scr_anim["player_rig"]["command_end"] = % blackice_controlroom_player_end;
  level.scr_anim["player_rig"]["command_early"] = % blackice_controlroom_player_early;
  level.scr_anim["player_rig"]["command_late"] = % blackice_controlroom_player_late;
  level.scr_anim["player_rig"]["command_control"] = % blackice_controlroom_player_control;
  level.scr_anim["player_rig"]["ladder_chase"] = % blackice_player_exfil_explode;
  level.scr_anim["player_rig"]["exfil_fail"] = % blackice_player_exfil_fail;
  level.scr_anim["player_rig"]["jump_arms"] = % blackice_player_exfil_jumparms;
  level.scr_anim["player_rig"]["jump_arms_fail"] = % blackice_player_exfil_jumparms_fail;
  level.scr_anim["player_rig"]["cam_test"] = % blackice_player_exfil_jumparms;
  maps\_anim::addnotetrack_notify("player_rig", "focus_monitor", "notify_focus_monitor", "command_start");
  maps\_anim::addnotetrack_notify("player_rig", "blast", "notify_command_early_blast", "command_early");
  maps\_anim::addnotetrack_notify("player_rig", "flare_console_small_quake", "notify_flare_stack_button_press", "turn_off_flare_stack");
  maps\_anim::addnotetrack_notify("player_rig", "flip_switch", "notify_console_flip_switch", "turn_off_flare_stack");
  maps\_anim::addnotetrack_notify("player_rig", "draw_weapon", "notify_player_draw_weapon", "turn_off_flare_stack");
  maps\_anim::addnotetrack_notify("player_rig", "unlink", "notify_player_unlink", "turn_off_flare_stack");
  maps\_anim::addnotetrack_notify("player_rig", "flare_stack_off", "notify_stop_flare_stack", "turn_off_flare_stack");
  maps\_anim::addnotetrack_notify("player_rig", "unhide_arms", "notify_player_unhide_arms", "ladder_chase");
  maps\_anim::addnotetrack_notify("player_rig", "fade_to_black", "notify_flyout_fade_to_black", "ladder_chase");
  maps\_anim::addnotetrack_notify("player_rig", "death", "notify_player_hit_ice", "exfil_fail");
  maps\_anim::addnotetrack_notify("player_rig", "quit_smoking", "notify_stop_view_smoke_fx", "exfil_fail");
  maps\_anim::addnotetrack_customfunction("player_rig", "allow_player_control", ::notetrack_swim_begin_player_control);
  maps\_anim::addnotetrack_customfunction("player_rig", "player_breach_water", ::notetrack_player_breach_water);
  maps\_anim::addnotetrack_customfunction("player_rig", "player_remove_mask", ::notetrack_remove_mask);
  maps\_anim::addnotetrack_customfunction("player_rig", "release_allies", ::notetrack_release_allies);
  maps\_anim::addnotetrack_customfunction("player_rig", "draw_weapon", ::notetrack_player_draw_weapon_surface, "player_surface_root_pt2");
  maps\_anim::addnotetrack_customfunction("player_rig", "loosen_lookaround", ::notetrack_swim_loosen_lookaround);
  maps\_anim::addnotetrack_customfunction("player_rig", "End_player_control", ::notetrack_ascend_end_player_control, "alpha_rig_ascend");
  maps\_anim::addnotetrack_customfunction("player_rig", "allow_free_look", ::notetrack_control_room_allow_free_look);
  maps\_anim::addnotetrack_customfunction("player_rig", "start_baker", ::notetrack_control_room_start_baker);
  maps\_anim::addnotetrack_customfunction("player_rig", "slowmo_start", maps\black_ice_exfil::notetrack_slowmo_start);
  maps\_anim::addnotetrack_customfunction("player_rig", "fire_shake", maps\black_ice_ascend::notetrack_fire_shake);
  maps\_anim::addnotetrack_customfunction("player_rig", "takeoff", maps\black_ice_ascend::notetrack_takeoff);
  maps\_anim::addnotetrack_customfunction("player_rig", "shake_start", maps\black_ice_ascend::notetrack_shake_start);
  maps\_anim::addnotetrack_customfunction("player_rig", "shake_stop", maps\black_ice_ascend::notetrack_shake_stop);
  maps\_anim::addnotetrack_customfunction("player_rig", "grab_shake", maps\black_ice_exfil::notetrack_grab_shake);
  maps\_anim::addnotetrack_customfunction("player_rig", "shockwave_shake", maps\black_ice_exfil::notetrack_shockwave_shake);
  maps\_anim::addnotetrack_customfunction("player_rig", "blast_shake_early", maps\black_ice_command::notetrack_blast_shake_early);
  maps\_anim::addnotetrack_customfunction("player_rig", "blast_shake_late", maps\black_ice_command::notetrack_blast_shake_late);
  maps\_anim::addnotetrack_flag("player_rig", "fail_late", "flag_ladder_jumpfail_nojump", "ladder_chase");
}

#using_animtree("generic_human");

generic_human_anims() {
  level.scr_anim["snake_cam_enemy"]["intro_1"] = % blackice_intro_snakecam_opfor_1;
  level.scr_anim["snake_cam_enemy"]["intro_2"] = % blackice_intro_snakecam_opfor_2;
  level.scr_anim["snake_cam_enemy"]["intro_3"] = % blackice_intro_snakecam_opfor_3;
  level.scr_anim["snake_cam_enemy"]["intro_4"] = % blackice_intro_snakecam_opfor_4;
  level.scr_anim["snake_cam_enemy"]["intro_5"] = % blackice_intro_snakecam_opfor_9;
  level.scr_anim["opfor5"]["enemy_dismount"] = % blackice_intro_snakecam_opfor_5;
  level.scr_anim["opfor6"]["enemy_dismount"] = % blackice_intro_snakecam_opfor_6;
  level.scr_anim["opfor7"]["enemy_dismount"] = % blackice_intro_snakecam_opfor_7;
  level.scr_anim["opfor8"]["enemy_dismount"] = % blackice_intro_snakecam_opfor_8;
  level.scr_anim["scuba_ally"]["intro_ally1"] = % blackice_intro_ally2;
  level.scr_anim["scuba_ally"]["intro_ally2"] = % blackice_intro_ally1;
  maps\_anim::addnotetrack_customfunction("scuba_ally", "bubbles_1", ::notetrack_intro_ally2_bubbles);
  maps\_anim::addnotetrack_notify("scuba_ally", "line3_1", "notify_snake_cam_dialogue_line3_1");
  level.scr_anim["scuba_ally"]["intro_ally1_idle"][0] = % blackice_intro_ally2_idle;
  level.scr_anim["scuba_ally"]["intro_ally2_idle"][0] = % blackice_intro_ally1_idle;
  level.scr_anim["scuba_ally"]["breach_ally1"] = % blackice_breach_ally2;
  level.scr_anim["scuba_ally"]["breach_ally2"] = % blackice_breach_ally1;
  level.scr_anim["ice_breach_enemy"]["death_anim0"] = % blackice_introbreach_opfor1_death;
  level.scr_anim["ice_breach_enemy"]["death_anim1"] = % blackice_introbreach_opfor2_death;
  level.scr_anim["ice_breach_enemy"]["death_anim2"] = % blackice_introbreach_opfor3_death;
  level.scr_anim["ice_breach_enemy"]["death_anim3"] = % blackice_introbreach_opfor4_death;
  level.scr_anim["ice_breach_enemy"]["death_anim4"] = % blackice_introbreach_opfor5_death;
  level.scr_anim["ice_breach_enemy"]["death_anim5"] = % blackice_introbreach_opfor6_death;
  level.scr_anim["ice_breach_enemy"]["death_anim6"] = % blackice_introbreach_opfor7_death;
  level.scr_anim["ice_breach_enemy"]["death_anim7"] = % blackice_introbreach_opfor8_death;
  level.scr_anim["ice_breach_enemy"]["death_anim8"] = % blackice_introbreach_opfor9_death;
  level.scr_anim["ice_breach_enemy"]["death_anim9"] = % blackice_introbreach_opfor10_death;
  level.scr_anim["ice_breach_enemy"]["introbreach_opfor0"] = % blackice_introbreach_opfor1;
  level.scr_anim["ice_breach_enemy"]["introbreach_opfor1"] = % blackice_introbreach_opfor2;
  level.scr_anim["ice_breach_enemy"]["introbreach_opfor2"] = % blackice_introbreach_opfor3;
  level.scr_anim["ice_breach_enemy"]["introbreach_opfor3"] = % blackice_introbreach_opfor4;
  level.scr_anim["ice_breach_enemy"]["introbreach_opfor4"] = % blackice_introbreach_opfor5;
  level.scr_anim["ice_breach_enemy"]["introbreach_opfor5"] = % blackice_introbreach_opfor6;
  level.scr_anim["ice_breach_enemy"]["introbreach_opfor6"] = % blackice_introbreach_opfor7;
  level.scr_anim["ice_breach_enemy"]["introbreach_opfor7"] = % blackice_introbreach_opfor8;
  level.scr_anim["ice_breach_enemy"]["introbreach_opfor8"] = % blackice_introbreach_opfor9;
  level.scr_anim["ice_breach_enemy"]["introbreach_opfor9"] = % blackice_introbreach_opfor10;
  maps\_anim::addnotetrack_notify("scuba_ally", "line5_1", "notify_swim_dialog5_1");
  maps\_anim::addnotetrack_flag("scuba_ally", "line5_1", "flag_player_clear_to_breach");
  maps\_anim::addnotetrack_notify("scuba_ally", "line6", "notify_swim_dialog6");
  maps\_anim::addnotetrack_notify("scuba_ally", "line6_1", "notify_swim_dialog6_1");
  maps\_anim::addnotetrack_notify("scuba_ally", "line6_2", "notify_swim_dialog6_2");
  maps\_anim::addnotetrack_notify("scuba_ally", "line6_3", "notify_swim_dialog6_3");
  maps\_anim::addnotetrack_notify("scuba_ally", "line6_4", "notify_swim_dialog6_4");
  maps\_anim::addnotetrack_notify("scuba_ally", "line6_5", "notify_swim_dialog6_5");
  maps\_anim::addnotetrack_notify("scuba_ally", "line7", "notify_swim_dialog7");
  maps\_anim::addnotetrack_notify("scuba_ally", "line7_1", "notify_swim_dialog7_1");
  maps\_anim::addnotetrack_notify("scuba_ally", "line8", "notify_swim_dialog8");
  maps\_anim::addnotetrack_notify("scuba_ally", "pullout_detonator", "notify_pullout_detonator");
  maps\_anim::addnotetrack_notify("scuba_ally", "end_breach", "notify_swim_end_breach");
  maps\_anim::addnotetrack_notify("scuba_ally", "allow_movement", "notify_swim_allow_movement");
  level.scr_anim["scuba_ally"]["surface_ally1"] = % blackice_surface_ally2;
  level.scr_anim["scuba_ally"]["surface_ally2"] = % blackice_surface_ally1;
  level.scr_anim["scuba_ally"]["surface_ally1_idle"][0] = % blackice_surface_ally2_idle;
  level.scr_anim["scuba_ally"]["surface_ally2_idle"][0] = % blackice_surface_ally1_idle;
  level.scr_anim["scuba_ally"]["surface_ally1_up"] = % blackice_surface_ally2_up;
  level.scr_anim["scuba_ally"]["surface_ally2_up"] = % blackice_surface_ally1_up;
  level.scr_anim["scuba_ally"]["surface_ally3_up"] = % blackice_surface_ally3_up;
  level.scr_anim["scuba_ally"]["surface_ally3_up_pt2"] = % blackice_surface_ally3_up_pt2;
  maps\_anim::addnotetrack_notify("scuba_ally", "icehole_godrays", "notify_icehole_godrays");
  maps\_anim::addnotetrack_dialogue("scuba_ally", "wave_to_player", "surface_ally1_up", "blackice_bkr_onthatrig");
  var_0 = [];
  var_0["run"]["stairs_up"] = % traverse_stair_run_01_blackice;
  maps\_utility::register_archetype("black_ice_ally", var_0);
  level.scr_anim["generic"]["camp_pain_dead"] = % blackice_surface_opfor4;
  level.scr_anim["generic"]["camp_pain_long_1"] = % blackice_surface_opfor1;
  level.scr_anim["generic"]["camp_pain_long_2"] = % blackice_surface_opfor2;
  level.scr_anim["generic"]["camp_pain_short_1"] = % blackice_surface_opfor3;
  level.scr_anim["generic"]["camp_pain_tumble"] = % blackice_surface_opfor5;
  level.scr_anim["generic"]["unarmed_run"] = % unarmed_scared_run_delta;
  level.scr_anim["generic"]["run_180_1"] = % run_reaction_180;
  level.scr_anim["generic"]["run_180_2"] = % civilian_run_upright_turn180;
  level.scr_anim["ally1"]["grenade"] = % doorpeek_grenade;
  level.scr_anim["ally1"]["kick"] = % doorpeek_kick;
  level.scr_anim["heli_opfor1"]["arrive"] = % blackice_basecamp_heliarrive_opfor1;
  level.scr_anim["heli_opfor2"]["arrive"] = % blackice_basecamp_heliarrive_opfor2;
  level.scr_anim["heli_opfor3"]["arrive"] = % blackice_basecamp_heliarrive_opfor3;
  level.scr_anim["heli_opfor4"]["arrive"] = % blackice_basecamp_heliarrive_opfor4;
  level.scr_anim["heli_opfor1"]["leave"] = % blackice_basecamp_heli_opfor1;
  level.scr_anim["heli_opfor2"]["leave"] = % blackice_basecamp_heli_opfor2;
  level.scr_anim["heli_opfor3"]["leave"] = % blackice_basecamp_heli_opfor3;
  level.scr_anim["heli_opfor4"]["leave"] = % blackice_basecamp_heli_opfor4;
  level.scr_anim["bravo1"]["ascend_runin"] = % blackice_ally1_runin;
  level.scr_anim["bravo1"]["ascend_waiting"][0] = % blackice_ally1_waiting;
  level.scr_anim["bravo1"]["bravo_rope_shoot"] = % blackice_ally1_rigshoot;
  level.scr_anim["bravo1"]["bravo_rope_idle"][0] = % blackice_ally1_rig_idle;
  level.scr_anim["bravo1"]["bravo_rig_ascend"] = % blackice_ally1_rigascend;
  level.scr_anim["bravo2"]["ascend_runin"] = % blackice_ally2_runin;
  level.scr_anim["bravo2"]["ascend_waiting"][0] = % blackice_ally2_waiting;
  level.scr_anim["bravo2"]["bravo_rope_shoot"] = % blackice_ally2_rigshoot;
  level.scr_anim["bravo2"]["bravo_rope_idle"][0] = % blackice_ally2_rig_idle;
  level.scr_anim["bravo2"]["bravo_rig_ascend"] = % blackice_ally2_rigascend;
  level.scr_anim["ally1"]["ascend_runin"] = % blackice_ally4_runin;
  level.scr_anim["ally1"]["ascend_waiting"][0] = % blackice_ally4_waiting;
  level.scr_anim["ally1"]["alpha_rope_shoot"] = % blackice_ally4_ropeshoot;
  level.scr_anim["ally1"]["alpha_hand_rope"][0] = % blackice_ally4_handrope;
  level.scr_anim["ally1"]["alpha_rig_ascend"] = % blackice_ally4_rigascend;
  level.scr_anim["ally2"]["ascend_runin"] = % blackice_ally5_runin;
  level.scr_anim["ally2"]["ascend_waiting"][0] = % blackice_ally5_waiting;
  level.scr_anim["ally2"]["alpha_rope_shoot"] = % blackice_ally5_ropeshoot;
  level.scr_anim["ally2"]["alpha_hand_rope"][0] = % blackice_ally5_handrope;
  level.scr_anim["ally2"]["alpha_rig_ascend"] = % blackice_ally5_rigascend;
  level.scr_anim["opfor"]["alpha_rig_ascend"] = % blackice_opfor_rigascend;
  maps\_anim::addnotetrack_notify("bravo1", "line0", "notify_ascend_dialog0");
  maps\_anim::addnotetrack_notify("bravo1", "line5", "notify_ascend_dialog5");
  maps\_anim::addnotetrack_notify("bravo1", "line6", "notify_ascend_dialog6");
  maps\_anim::addnotetrack_notify("bravo1", "line7", "notify_ascend_dialog7");
  maps\_anim::addnotetrack_flag("ally1", "dialog_dontstop", "flag_dialog_dontstop");
  maps\_anim::addnotetrack_flag("ally1", "dialog_weaponsfree", "flag_dialog_weaponsfree");
  maps\_anim::addnotetrack_customfunction("bravo1", "rubber_band_stop", ::notetrack_ascend_rubberband_bravo_stop);
  maps\_anim::addnotetrack_customfunction("ally1", "rubber_band_start", ::notetrack_ascend_rubberband_alpha_start);
  maps\_anim::addnotetrack_customfunction("ally1", "rubber_band_stop", ::notetrack_ascend_rubberband_alpha_stop);
  level.scr_animtree["player_legs_ascend"] = #animtree;
  level.scr_model["player_legs_ascend"] = "body_hero_sandman_seal_udt_b";
  level.scr_anim["player_legs_ascend"]["alpha_rig_ascend_linkup"] = % blackice_playerlegs_linkup;
  level.scr_anim["player_legs_ascend"]["alpha_rig_ascend_groundidle"][0] = % blackice_playerlegs_groundidle;
  level.scr_anim["player_legs_ascend"]["alpha_rig_ascend"] = % blackice_playerlegs_rigascend;
  level.scr_anim["player_legs_ascend"]["rig_ascend_stop"] = % blackice_playerlegs_rigascend_stop;
  level.scr_anim["player_legs_ascend"]["rig_ascend_start"] = % blackice_playerlegs_rigascend_start;
  level.scr_anim["generic"]["cw_falling_death"][0] = % blackice_catwalk_deathfall_1;
  level.scr_anim["generic"]["cw_falling_death"][1] = % blackice_catwalk_deathfall_2;
  level.scr_anim["generic"]["cw_falling_death"][2] = % blackice_catwalk_deathfall_5;
  level.scr_anim["generic"]["cw_falling_death"][3] = % blackice_catwalk_deathfall_6;
  level.scr_anim["ally1"]["catwalk_kill"] = % blackice_catwalkkill_ally;
  level.scr_anim["ally2"]["catwalk_kill"] = % blackice_catwalkkill_ally;
  level.scr_anim["generic"]["catwalk_kill"] = % blackice_catwalkkill_opfor;
  level.scr_anim["ally1"]["cw_tape_breach"] = % blackice_doortape_ally1;
  level.scr_anim["ally2"]["cw_tape_breach"] = % blackice_doortape_ally2;
  maps\_anim::addnotetrack_customfunction("ally2", "doortape_breach", ::notetrack_cw_tape_explode, "cw_tape_breach");
  level.scr_anim["ally1"]["cw_hallsweep"] = % blackice_hallwayclear_baker;
  level.scr_anim["ally2"]["cw_hallsweep"] = % blackice_hallwayclear_fuentes;
  level.scr_anim["generic"]["cw_hallsweep"] = % blackice_hallwayclear_opfor;
  maps\_anim::addnotetrack_dialogue("ally2", "fuentes_va_clear_1", "cw_hallsweep", "blackice_fnt_clearmoveup");
  maps\_anim::addnotetrack_dialogue("ally1", "baker_vo_clear_1", "cw_hallsweep", "blackice_bkr_roomscleargo");
  maps\_anim::addnotetrack_dialogue("ally2", "fuentes_vo_contact", "cw_hallsweep", "black_ice_fnt_contact");
  maps\_anim::addnotetrack_dialogue("ally1", "baker_vo_clear_2", "cw_hallsweep", "black_ice_mrk_goodeyeshesh");
  maps\_anim::addnotetrack_customfunction("ally2", "fuentes_bakers_vo_contact", ::notetrack_dialogue_hallclear, "cw_hallsweep");
  maps\_anim::addnotetrack_notify("ally2", "fuentes_vo_contact", "cw_hallsweep_ally2_attack", "cw_hallsweep");
  maps\_anim::addnotetrack_customfunction("generic", "opfor_dead", ::vig_actor_kill, "cw_hallsweep");
  level.scr_anim["ally1"]["rec_breach_check"] = % blackice_commonroom_ally1_check;
  level.scr_anim["ally1"]["rec_breach"] = % blackice_commonroom_ally1_pt1;
  level.scr_anim["ally2"]["rec_breach"] = % blackice_commonroom_ally2_pt1;
  level.scr_anim["ally1"]["rec_breach_idle"][0] = % blackice_commonroom_ally1_idle;
  level.scr_anim["ally2"]["rec_breach_idle"][0] = % blackice_commonroom_ally2_idle;
  level.scr_anim["ally1"]["rec_breach_move"] = % blackice_commonroom_ally1_pt2;
  level.scr_anim["ally2"]["rec_breach_move"] = % blackice_commonroom_ally2_pt2;
  level.scr_anim["generic"]["exposed_flashbang_v1"] = % exposed_flashbang_v1;
  level.scr_anim["generic"]["exposed_flashbang_v3"] = % exposed_flashbang_v3;
  maps\_anim::addnotetrack_notify("ally1", "blast", "cw_common_door_down", "rec_breach");
  maps\_anim::addnotetrack_notify("ally1", "throwaflash", "cw_common_throw_flash", "rec_breach");
  level.scr_anim["ally1"]["flarestack_start"] = % blackice_flamestack_ally1;
  level.scr_anim["ally1"]["flarestack_idle"][0] = % blackice_flamestack_ally1_idle;
  level.scr_anim["ally1"]["flarestack_end"] = % blackice_flamestack_ally1_end;
  maps\_anim::addnotetrack_notify("ally1", "start_scan", "notify_flarestack_start_scan", "flarestack_start");
  maps\_anim::addnotetrack_notify("ally1", "pistol_pullout", "notify_flarestack_baker_pistol_pullout", "flarestack_end");
  maps\_anim::addnotetrack_notify("ally1", "pistol_fire", "notify_flarestack_baker_pistol_fire", "flarestack_end");
  maps\_anim::addnotetrack_notify("ally1", "pistol_putawayz", "notify_flarestack_baker_pistol_putaway", "flarestack_end");
  level.scr_anim["flarestack_guy"]["flarestack_start"] = % blackice_flamestack_opfor1;
  level.scr_anim["flarestack_guy"]["flarestack_idle"][0] = % blackice_flamestack_opfor1_idle;
  level.scr_anim["flarestack_guy"]["flarestack_end"] = % blackice_flamestack_opfor1_end;
  maps\_anim::addnotetrack_notify("flarestack_guy", "death", "notify_flarestack_enemy_kill", "flarestack_end");
  maps\_anim::addnotetrack_notify("flarestack_guy", "audio_point", "notify_flarestack_enemy_on_console", "flarestack_start");
  maps\_anim::addnotetrack_notify("flarestack_guy", "line_1", "black_ice_saf2_whatareyoudoing", "flarestack_start");
  maps\_anim::addnotetrack_dialogue("ally1", "line2", "flarestack_start", "black_ice_mrk_quiet");
  maps\_anim::addnotetrack_notify("flarestack_guy", "line3", "black_ice_saf2_shitwhatareyou", "flarestack_end");
  level.scr_sound["flarestack_guy"]["black_ice_saf2_whatareyoudoing"] = "black_ice_saf2_whatareyoudoing";
  level.scr_face["flarestack_guy"]["black_ice_saf2_whatareyoudoing"] = % black_ice_saf2_whatareyoudoing;
  level.scr_sound["flarestack_guy"]["black_ice_saf2_nononodontdoit"] = "black_ice_saf2_nononodontdoit";
  level.scr_face["flarestack_guy"]["black_ice_saf2_nononodontdoit"] = % black_ice_saf2_nononodontdoit;
  level.scr_sound["flarestack_guy"]["black_ice_saf2_shitwhatareyou"] = "black_ice_saf2_shitwhatareyou";
  level.scr_face["flarestack_guy"]["black_ice_saf2_shitwhatareyou"] = % black_ice_saf2_shitwhatareyou;
  level.scr_anim["ally1"]["flarestack_exit"] = % blackice_flamestack_ally1_exit;
  maps\_anim::addnotetrack_notify("ally1", "door_open", "notify_flamestack_door_open", "flarestack_exit");
  level.scr_anim["ally1"]["cover_left_idle"][0] = % blackice_corner_standl_alert_idle;
  level.scr_anim["ally1"]["refinery_hold_init"] = % blackice_baker_hold2_init;
  level.scr_anim["ally1"]["refinery_hold_idle"][0] = % blackice_baker_hold2_idle;
  level.scr_anim["ally1"]["refinery_hold_end"] = % blackice_baker_hold2_end;
  level.scr_anim["refinery_guy"]["derrick_explode_reaction_1"] = % blackice_explosionreact1;
  level.scr_anim["refinery_guy"]["derrick_explode_reaction_2"] = % blackice_explosionreact2;
  level.scr_anim["generic"]["derrick_explode_death"] = % death_explosion_run_f_v2;
  level.scr_anim["refinery_guy1"]["derrick_explode_death"] = % death_explosion_run_f_v2;
  level.scr_anim["refinery_guy2"]["derrick_explode_death"] = % death_explosion_run_f_v2;
  level.scr_anim["refinery_guy3"]["derrick_explode_death"] = % death_explosion_run_f_v2;
  level.scr_anim["refinery_guy4"]["derrick_explode_death"] = % death_explosion_run_f_v2;
  level.scr_anim["refinery_guy5"]["derrick_explode_death"] = % death_explosion_run_f_v2;
  level.scr_anim["refinery_guy6"]["derrick_explode_death"] = % death_explosion_run_f_v2;
  level.scr_anim["refinery_guy7"]["derrick_explode_death"] = % death_explosion_run_f_v2;
  level.scr_anim["refinery_guy1"]["derrick_explode_scene"] = % blackice_topside_opfor1;
  level.scr_anim["refinery_guy2"]["derrick_explode_scene"] = % blackice_topside_opfor2;
  level.scr_anim["refinery_guy3"]["derrick_explode_scene"] = % blackice_topside_opfor3;
  level.scr_anim["refinery_guy4"]["derrick_explode_scene"] = % blackice_topside_opfor4;
  level.scr_anim["refinery_guy5"]["derrick_explode_scene"] = % blackice_topside_opfor5;
  level.scr_anim["refinery_guy6"]["derrick_explode_scene"] = % blackice_topside_opfor6;
  level.scr_anim["refinery_guy7"]["derrick_explode_scene"] = % blackice_topside_opfor7;
  level.scr_anim["refinery_guy6"]["death_pose"] = % blackice_topside_opfor6_dead;
  maps\_anim::addnotetrack_notify("refinery_guy1", "derrick_detonation", "notify_refinery_explosion_start");
  level.scr_anim["tanks_guy_1"]["tanks_bridge_fall_scene"] = % blackice_tanks_catwalk_collapse_opfor1;
  level.scr_anim["tanks_guy_1"]["tanks_bridge_fall_death"] = % blackice_tanks_catwalk_collapse_opfor1_death;
  level.scr_anim["tanks_guy_2"]["tanks_bridge_fall_scene"] = % blackice_tanks_catwalk_collapse_opfor2;
  maps\_anim::addnotetrack_customfunction("tanks_guy_1", "start_custom_death", ::notetrack_tanks_start_custom_death, "tanks_bridge_fall_scene");
  maps\_anim::addnotetrack_customfunction("tanks_guy_1", "end_custom_death", ::notetrack_tanks_end_custom_death, "tanks_bridge_fall_scene");
  level.scr_anim["ai0"]["engineroom_workers_throughdoor"] = % blackice_engineroom_throughdoor_worker1;
  level.scr_anim["ai1"]["engineroom_workers_throughdoor"] = % blackice_engineroom_throughdoor_worker2;
  level.scr_anim["ai0"]["engineroom_workers_idle"][0] = % blackice_engineroom_idle_worker1;
  level.scr_anim["ai1"]["engineroom_workers_idle"][0] = % blackice_engineroom_idle_worker2;
  level.scr_anim["ai0"]["engineroom_workers_death"] = % blackice_engineroom_death_worker1;
  level.scr_anim["ai1"]["engineroom_workers_death"] = % blackice_engineroom_death_worker2;
  level.scr_anim["ally1"]["engine_room_enter"] = % blackice_engineroom_postup_ally1;
  level.scr_anim["ai0"]["engineroom_worker2_run"] = % blackice_engineroom2_walkout;
  level.scr_anim["ai0"]["engineroom_worker2_idle"][0] = % blackice_engineroom2_idle;
  level.scr_anim["extinguisher_guy"]["extinguisher_loop1"][0] = % blackice_engineroom_firefighter1_idle;
  level.scr_anim["extinguisher_guy"]["extinguisher_loop2"][0] = % blackice_engineroom_firefighter2_idle;
  level.scr_anim["extinguisher_guy"]["extinguisher_loop3"][0] = % blackice_engineroom_firefighter3_idle;
  level.scr_anim["extinguisher_guy"]["extinguisher_loop_break1"] = % blackice_engineroom_firefighter1;
  level.scr_anim["extinguisher_guy"]["extinguisher_loop_break2"] = % blackice_engineroom_firefighter2;
  level.scr_anim["extinguisher_guy"]["extinguisher_loop_break3"] = % blackice_engineroom_firefighter3;
  level.scr_anim["ally1"]["topdrive_reaction"] = % blackice_explosionreact2;
  level.scr_anim["ally1"]["topdrive_duck_full"] = % blackice_topdrive_ally2;
  level.scr_anim["ally1"]["topdrive_duck"] = % blackice_topdrive_ally1;
  level.scr_anim["ally2"]["topdrive_duck"] = % blackice_topdrive_ally1;
  maps\_anim::addnotetrack_notify("ally1", "heli_notify", "notify_spawn_pipedeck_heli");
  level.scr_anim["lifeboat_guy1"]["lifeboat_deploy"] = % blackice_lifeboat_opfor1;
  level.scr_anim["lifeboat_guy2"]["lifeboat_deploy"] = % blackice_lifeboat_opfor2;
  level.scr_anim["lifeboat_guy3"]["lifeboat_deploy"] = % blackice_lifeboat_opfor3;
  level.scr_anim["lifeboat_guy4"]["lifeboat_deploy"] = % blackice_lifeboat_opfor4;
  level.scr_anim["lifeboat_guy5"]["lifeboat_deploy"] = % blackice_lifeboat_opfor5;
  level.scr_anim["lifeboat_guy6"]["lifeboat_deploy"] = % blackice_lifeboat_opfor6;
  level.scr_anim["lifeboat_guy7"]["lifeboat_deploy"] = % blackice_lifeboat_opfor7;
  level.scr_anim["lifeboat_guy8"]["lifeboat_deploy"] = % blackice_lifeboat_opfor8;
  level.scr_anim["lifeboat_guy9"]["lifeboat_deploy"] = % blackice_lifeboat_opfor9;
  level.scr_anim["lifeboat_guy10"]["lifeboat_deploy"] = % blackice_lifeboat_opfor10;
  level.scr_anim["lifeboat_guy11"]["lifeboat_deploy"] = % blackice_lifeboat_opfor11;
  level.scr_anim["lifeboat_guy12"]["lifeboat_deploy"] = % blackice_lifeboat_opfor12;
  level.scr_anim["derrick_guy1"]["heat_shield_run"] = % blackice_pipedeck_heat_opfor1;
  level.scr_anim["derrick_guy2"]["heat_shield_run"] = % blackice_pipedeck_heat_opfor2;
  level.scr_anim["ally1"]["command_enter_approach"] = % blackice_baker_controlroomdoor_1;
  level.scr_anim["ally1"]["command_enter"] = % blackice_baker_controlroomdoor_2;
  level.scr_anim["ally1"]["command_init"] = % blackice_controlroompanel_baker_init;
  level.scr_goaltime["ally1"]["command_init"] = 0.2;
  level.scr_anim["ally1"]["command_loop"][0] = % blackice_controlroompanel_baker_loop;
  level.scr_anim["ally1"]["command_start"] = % blackice_controlroompanel_baker_start;
  level.scr_anim["ally1"]["command_control"] = % blackice_controlroompanel_baker_control;
  level.scr_anim["ally1"]["command_end"] = % blackice_controlroompanel_baker_end;
  level.scr_anim["ally1"]["command_early"] = % blackice_controlroompanel_baker_early;
  level.scr_anim["ally1"]["command_late"] = % blackice_controlroompanel_baker_late;
  maps\_anim::addnotetrack_notify("ally1", "opfor1_anim_start", "notify_baker_push_opfor");
  maps\_anim::addnotetrack_notify("ally1", "dialog_instruct_1", "notify_dialog_instruct_1");
  maps\_anim::addnotetrack_notify("ally1", "dialog_instruct_2", "notify_dialog_instruct_2");
  maps\_anim::addnotetrack_notify("ally1", "dialog_instruct_3", "notify_dialog_instruct_3");
  maps\_anim::addnotetrack_notify("ally1", "dialog_instruct_4", "notify_dialog_instruct_4");
  maps\_anim::addnotetrack_notify("ally1", "dialog_instruct_5", "notify_dialog_instruct_5");
  maps\_anim::addnotetrack_notify("ally1", "merrick_head", "notify_swap_ally_head");
  maps\_anim::addnotetrack_notify("ally1", "ps_black_ice_bkr_shutdownthefire", "ps_black_ice_bkr_shutdownthefire");
  maps\_anim::addnotetrack_notify("ally1", "ps_black_ice_mrk_holditsteady", "ps_black_ice_mrk_holditsteady");
  maps\_anim::addnotetrack_notify("ally1", "ps_black_ice_mrk_yougottakeepthe", "ps_black_ice_mrk_yougottakeepthe");
  maps\_anim::addnotetrack_notify("ally1", "ps_black_ice_mrk_keepusoutof", "ps_black_ice_mrk_keepusoutof");
  maps\_anim::addnotetrack_customfunction("ally1", "dialog_end", ::notetrack_command_dialog_end);
  level.scr_anim["ally1"]["exfil_corner_cut"] = % blackice_controlroom_exfil_stairs_1;
  level.scr_anim["ally2"]["exfil_corner_cut"] = % blackice_controlroom_exfil_stairs_2;
  level.scr_anim["ally1"]["exfil_steam_react"] = % blackice_controlroom_exfil_finalroom_1;
  level.scr_anim["ally2"]["exfil_steam_react"] = % blackice_controlroom_exfil_finalroom_2;
  level.scr_anim["ally1"]["ladder_chase"] = % blackice_ally1_exfil_explode;
  level.scr_anim["ally2"]["ladder_chase"] = % blackice_ally2_exfil_explode;
  level.scr_animtree["player_legs_exfil"] = #animtree;
  level.scr_model["player_legs_exfil"] = "body_hero_sandman_seal_udt_b";
  level.scr_anim["player_legs_exfil"]["ladder_chase"] = % blackice_playerlegs_exfil_explode;
  maps\_anim::addnotetrack_notify("ally1", "pipe_burst", "notify_exfil_steam_burst", "exfil_steam_react");
  maps\_anim::addnotetrack_notify("ally1", "start_ladder_chase", "notify_start_ladder_chase", "exfil_steam_react");
  maps\_anim::addnotetrack_flag("ally1", "pipe_explosion", "flag_command_pipes_explosion", "exfil_steam_react");
  maps\_anim::addnotetrack_customfunction("ally1", "baker_dialog_1", ::notetrack_exfil_dialog_1);
  maps\_anim::addnotetrack_customfunction("ally1", "baker_dialog_2", ::notetrack_exfil_dialog_2);
  maps\_anim::addnotetrack_customfunction("ally1", "player_teleport", ::notetrack_player_teleport);
  maps\_anim::addnotetrack_customfunction("ally1", "heli_swing", ::notetrack_heli_swing);
  maps\_anim::addnotetrack_customfunction("ally1", "start_slomo", ::notetrack_start_slomo);
  maps\_anim::addnotetrack_customfunction("ally1", "end_slomo", ::notetrack_end_slomo);
  level.scr_anim["ally1"]["DRS_sprint"] = % sprint1_loop;
  level.scr_anim["ally1"]["DRS_combat_jog"] = % combat_jog;
  level.scr_anim["ally2"]["DRS_sprint"] = % sprint1_loop;
  level.scr_anim["ally2"]["DRS_combat_jog"] = % combat_jog;
}

#using_animtree("script_model");

script_model_anims() {
  level.scr_animtree["snake_cam"] = #animtree;
  level.scr_model["snake_cam"] = "tag_origin";
  level.scr_anim["snake_cam"]["retract"] = % blackice_intro_snakecam_retract;
  maps\_anim::addnotetrack_customfunction("snake_cam", "lens_water", ::notetrack_snake_cam_lens_water);
  maps\_anim::addnotetrack_customfunction("snake_cam", "underwater_transition", ::notetrack_snake_cam_underwater_transition);
  maps\_anim::addnotetrack_notify("snake_cam", "rumble_cam_1", "notify_rumble_cam_1");
  maps\_anim::addnotetrack_notify("snake_cam", "rumble_cam_2", "notify_rumble_cam_2");
  maps\_anim::addnotetrack_notify("snake_cam", "rumble_cam_3", "notify_rumble_cam_3");
  maps\_anim::addnotetrack_notify("snake_cam", "rumble_cam_4", "notify_rumble_cam_4");
  level.scr_animtree["snowmobile_1"] = #animtree;
  level.scr_model["snowmobile_1"] = "vehicle_snowmobile_iw6";
  level.scr_anim["snowmobile_1"]["intro_drive"] = % blackice_intro_drive_snowmobile_1;
  level.scr_animtree["snowmobile_2"] = #animtree;
  level.scr_model["snowmobile_2"] = "vehicle_snowmobile_iw6";
  level.scr_anim["snowmobile_2"]["intro_drive"] = % blackice_intro_drive_snowmobile_2;
  level.scr_animtree["gaz71"] = #animtree;
  level.scr_model["gaz71"] = "vehicle_gaz71_iw6";
  level.scr_anim["gaz71"]["intro_drive"] = % blackice_intro_drive_gaz71;
  level.scr_anim["gaz71"]["intro_breach"] = % blackice_introbreach_gaz71;
  maps\_anim::addnotetrack_notify("gaz71", "line2_1", "notify_snake_cam_dialogue_line2_1");
  maps\_anim::addnotetrack_notify("gaz71", "line2_2", "notify_snake_cam_dialogue_line2_2");
  maps\_anim::addnotetrack_notify("gaz71", "line2_3", "notify_snake_cam_dialogue_line2_3");
  maps\_anim::addnotetrack_notify("gaz71", "line2_4", "notify_snake_cam_dialogue_line2_4");
  maps\_anim::addnotetrack_notify("gaz71", "rumble_snowmobile_1", "notify_rumble_snowmobile_1");
  maps\_anim::addnotetrack_notify("gaz71", "rumble_snowmobile_2", "notify_rumble_snowmobile_2");
  maps\_anim::addnotetrack_notify("gaz71", "rumble_truck_1", "notify_rumble_truck_1");
  maps\_anim::addnotetrack_notify("gaz71", "rumble_truck_2", "notify_rumble_truck_2");
  maps\_anim::addnotetrack_notify("gaz71", "rumble_truck_3", "notify_rumble_truck_3");
  maps\_anim::addnotetrack_notify("gaz71", "rumble_truck_off", "notify_rumble_truck_off");
  maps\_anim::addnotetrack_customfunction("gaz71", "camera_retract", ::notetrack_snake_cam_retract);
  maps\_anim::addnotetrack_customfunction("gaz71", "enemy_dismount", ::notetrack_snake_enemy_dismount);
  level.scr_animtree["gaztiger"] = #animtree;
  level.scr_model["gaztiger"] = "vehicle_iveco_lynx_iw6";
  level.scr_anim["gaztiger"]["intro_drive"] = % blackice_intro_drive_gaztiger;
  level.scr_anim["gaztiger"]["intro_breach"] = % blackice_introbreach_gaztiger;
  level.scr_animtree["gaztiger_2"] = #animtree;
  level.scr_model["gaztiger_2"] = "vehicle_iveco_lynx_iw6";
  level.scr_anim["gaztiger_2"]["intro_drive"] = % blackice_intro_drive_gaztiger2;
  level.scr_animtree["bm21_1"] = #animtree;
  level.scr_model["bm21_1"] = "vehicle_tatra_t815_iw6_covered";
  level.scr_anim["bm21_1"]["intro_drive"] = % blackice_intro_drive_truck1;
  level.scr_anim["bm21_1"]["intro_breach"] = % blackice_introbreach_truck1;
  level.scr_anim["bm21_1"]["surface_truck"] = % blackice_intro_truck_fall;
  level.scr_animtree["blackice_ice_chunks_truck"] = #animtree;
  level.scr_model["blackice_ice_chunks_truck"] = "blackice_ice_chunks_truck";
  level.scr_anim["blackice_ice_chunks_truck"]["surface_truck"] = % blackice_intro_truck_fall_icechunks;
  level.scr_animtree["bm21_2"] = #animtree;
  level.scr_model["bm21_2"] = "vehicle_tatra_t815_iw6_covered";
  level.scr_anim["bm21_2"]["intro_drive"] = % blackice_intro_drive_truck2;
  level.scr_anim["bm21_2"]["intro_breach"] = % blackice_introbreach_truck2;
  level.scr_animtree["bm21_3"] = #animtree;
  level.scr_model["bm21_3"] = "vehicle_tatra_t815_iw6_covered";
  level.scr_anim["bm21_3"]["intro_drive"] = % blackice_intro_drive_truck3;
  level.scr_animtree["introbreach_props"] = #animtree;
  level.scr_model["introbreach_props"] = "blackice_introbreach_props";
  level.scr_anim["introbreach_props"]["intro_breach"] = % blackice_introbreach_props_01;
  level.scr_anim["introbreach_props"]["intro_breach_end"] = % blackice_introbreach_props_end;
  level.scr_animtree["ice_chunks1"] = #animtree;
  level.scr_model["ice_chunks1"] = "blackice_infil_ice_chunks_1";
  level.scr_anim["ice_chunks1"]["intro_breach"] = % blackice_introbreach_ice1;
  level.scr_anim["ice_chunks1"]["intro_breach_loop"][0] = % blackice_introbreach_ice1_loop;
  level.scr_anim["ice_chunks1"]["intro_breach_end"] = % blackice_introbreach_ice1_end;
  level.scr_animtree["ice_chunks2"] = #animtree;
  level.scr_model["ice_chunks2"] = "blackice_infil_ice_chunks_2";
  level.scr_anim["ice_chunks2"]["intro_breach"] = % blackice_introbreach_ice2;
  level.scr_anim["ice_chunks2"]["intro_breach_loop"][0] = % blackice_introbreach_ice2_loop;
  level.scr_anim["ice_chunks2"]["intro_breach_end"] = % blackice_introbreach_ice2_end;
  level.scr_animtree["breach_water"] = #animtree;
  level.scr_model["breach_water"] = "blackice_breach_water";
  level.scr_anim["breach_water"]["intro_breach"] = % blackice_introbreach_water;
  level.scr_anim["breach_water"]["intro_breach_end"] = % blackice_introbreach_water_end;
  level.scr_animtree["tape_breach_door"] = #animtree;
  level.scr_animtree["tape_breach_door_dam"] = #animtree;
  level.scr_model["tape_breach_door"] = "bulkhead_door";
  level.scr_model["tape_breach_door_dam"] = "bulkhead_door_damaged";
  level.scr_anim["tape_breach_door"]["cw_tape_breach"] = % blackice_doortape_door;
  level.scr_anim["tape_breach_door_dam"]["cw_tape_breach"] = % blackice_doortape_door;
  level.scr_animtree["tape_breach_tape"] = #animtree;
  level.scr_model["tape_breach_tape"] = "blackice_explosive_tape";
  level.scr_anim["tape_breach_tape"]["cw_tape_breach"] = % blackice_doortape_tape;
  level.scr_animtree["hallway_door"] = #animtree;
  level.scr_model["hallway_door"] = "bi_hallway_door";
  level.scr_anim["hallway_door"]["cw_hallsweep"] = % blackice_hallwayclear_door;
  level.scr_animtree["breach_door_charge"] = #animtree;
  level.scr_model["breach_door_charge"] = "blackice_comm_room_breacher";
  level.scr_anim["breach_door_charge"]["breach"] = % blackice_commonroom_charge;
  level.scr_animtree["common_door_dam"] = #animtree;
  level.scr_model["common_door_dam"] = "hallway_double_door_damaged";
  level.scr_anim["common_door_dam"]["explode"] = % blackice_commonroom_door;
  level.scr_animtree["common_door"] = #animtree;
  level.scr_model["common_door"] = "hallway_double_door";
  level.scr_anim["common_door"]["bullets"] = % blackice_commonroom_door_bullets;
  level.scr_animtree["oil_pump"] = #animtree;
  level.scr_anim["oil_pump"]["motion"] = % oil_pump_2;
  level.scr_animtree["flarestack_door_in"] = #animtree;
  level.scr_anim["flarestack_door_in"]["flarestack_start"] = % blackice_flamestack_door;
  level.scr_animtree["baker_sidearm"] = #animtree;
  level.scr_model["baker_sidearm"] = "weapon_p226";
  level.scr_animtree["flarestack_door_out"] = #animtree;
  level.scr_anim["flarestack_door_out"]["flarestack_exit"] = % blackice_flamestack_door_exit;
  level.scr_animtree["derrick"] = #animtree;
  level.scr_model["derrick"] = "blackice_oil_derrick";
  level.scr_anim["derrick"]["collapse"] = % blackice_derrick_collapse;
  level.scr_anim["derrick"]["small_explosion"] = % blackice_derrick_small_explosion;
  level.scr_animtree["tag_origin"] = #animtree;
  level.scr_anim["tag_origin"]["cam_test"] = % blackice_player_exfil_jumpcam;
  maps\_anim::addnotetrack_customfunction("derrick", "small_explosion", ::notetrack_derrick_small_explosion);
  maps\_anim::addnotetrack_customfunction("derrick", "large_explosion", ::notetrack_derrick_large_explosion);
  maps\_anim::addnotetrack_customfunction("derrick", "traveling_block_impact", ::notetrack_traveling_block_impact);
  maps\_anim::addnotetrack_customfunction("derrick", "impact_rig", ::notetrack_derrick_impact_rig);
  maps\_anim::addnotetrack_customfunction("derrick", "start_combat", ::notetrack_refinery_start_combat);
  level.scr_animtree["traveling_block"] = #animtree;
  level.scr_model["traveling_block"] = "blackice_traveling_block";
  level.scr_anim["traveling_block"]["derrick_explosion"] = % blackice_derrick_traveling_block2;
  maps\_anim::addnotetrack_customfunction("traveling_block", "hit_1", ::notetrack_derrick_debris_hit_1);
  maps\_anim::addnotetrack_customfunction("traveling_block", "hit_2", ::notetrack_derrick_debris_hit_2);
  level.scr_animtree["derrick_chunk"] = #animtree;
  level.scr_model["derrick_chunk"] = "blackice_derrick_chunk";
  level.scr_anim["derrick_chunk"]["derrick_explosion"] = % blackice_derrick_traveling_block;
  maps\_anim::addnotetrack_customfunction("derrick_chunk", "hitbarrels", ::notetrack_derrick_chunk_hit_barrels);
  level.scr_animtree["oiltank_catwalk"] = #animtree;
  level.scr_model["oiltank_catwalk"] = "blackice_refinery_tank_catwalk_destroyed";
  level.scr_anim["oiltank_catwalk"]["oiltank_catwalk"] = % blackice_derrick_oiltank_catwalk;
  maps\_anim::addnotetrack_customfunction("oiltank_catwalk", "swap_catwalk", ::notetrack_oiltank_catwalk_swap);
  level.scr_animtree["oiltank_forklift"] = #animtree;
  level.scr_model["oiltank_forklift"] = "vehicle_forklift_blackice";
  level.scr_anim["oiltank_forklift"]["derrick_explosion"] = % blackice_derrick_debris_forklift;
  level.scr_animtree["oiltank_forklift_crate"] = #animtree;
  level.scr_model["oiltank_forklift_crate"] = "ch_crate48x64_snow_no_tweak";
  level.scr_anim["oiltank_forklift_crate"]["derrick_explosion"] = % blackice_derrick_debris_forklift_crate;
  level.scr_animtree["oiltank_spool"] = #animtree;
  level.scr_model["oiltank_spool"] = "wire_spool_metal";
  level.scr_anim["oiltank_spool"]["derrick_explosion"] = % blackice_derrick_debris_spool;
  level.scr_animtree["oiltank_debris_1_1"] = #animtree;
  level.scr_model["oiltank_debris_1_1"] = "junk_scrap_08";
  level.scr_anim["oiltank_debris_1_1"]["derrick_explosion"] = % blackice_derrick_oiltank_debris_1;
  level.scr_animtree["oiltank_debris_1_2"] = #animtree;
  level.scr_model["oiltank_debris_1_2"] = "junk_scrap_08";
  level.scr_anim["oiltank_debris_1_2"]["derrick_explosion"] = % blackice_derrick_oiltank_debris_2;
  level.scr_animtree["oiltank_debris_1_3"] = #animtree;
  level.scr_model["oiltank_debris_1_3"] = "junk_scrap_08";
  level.scr_anim["oiltank_debris_1_3"]["derrick_explosion"] = % blackice_derrick_oiltank_debris_3;
  level.scr_animtree["oiltank_debris_2"] = #animtree;
  level.scr_model["oiltank_debris_2"] = "junk_scrap_05";
  level.scr_anim["oiltank_debris_2"]["derrick_explosion"] = % blackice_derrick_oiltank_debris_4;
  level.scr_animtree["oiltank_debris_3"] = #animtree;
  level.scr_model["oiltank_debris_3"] = "junk_scrap_10";
  level.scr_anim["oiltank_debris_3"]["derrick_explosion"] = % blackice_derrick_oiltank_debris_5;
  level.scr_animtree["barrel_crush"] = #animtree;
  level.scr_model["barrel_crush"] = "blackice_barrel_crush";
  level.scr_anim["barrel_crush"]["barrel_crush_1"] = % blackice_derrick_barrel_1;
  level.scr_anim["barrel_crush"]["barrel_crush_2"] = % blackice_derrick_barrel_2;
  level.scr_anim["barrel_crush"]["barrel_crush_3"] = % blackice_derrick_barrel_3;
  level.scr_anim["barrel_crush"]["barrel_crush_4"] = % blackice_derrick_barrel_4;
  level.scr_anim["barrel_crush"]["barrel_crush_5"] = % blackice_derrick_barrel_5;
  level.scr_animtree["barrel_oiltank_crush_1"] = #animtree;
  level.scr_animtree["barrel_oiltank_crush_2"] = #animtree;
  level.scr_animtree["barrel_oiltank_crush_3"] = #animtree;
  level.scr_animtree["barrel_oiltank_crush_4"] = #animtree;
  level.scr_animtree["barrel_oiltank_crush_5"] = #animtree;
  level.scr_animtree["barrel_oiltank_crush_6"] = #animtree;
  level.scr_animtree["barrel_oiltank_crush_7"] = #animtree;
  level.scr_model["barrel_oiltank_crush_1"] = "blackice_barrel_crush";
  level.scr_model["barrel_oiltank_crush_2"] = "blackice_barrel_crush";
  level.scr_model["barrel_oiltank_crush_3"] = "blackice_barrel_crush";
  level.scr_model["barrel_oiltank_crush_4"] = "blackice_barrel_crush";
  level.scr_model["barrel_oiltank_crush_5"] = "blackice_barrel_crush";
  level.scr_model["barrel_oiltank_crush_6"] = "blackice_barrel_crush";
  level.scr_model["barrel_oiltank_crush_7"] = "blackice_barrel_crush";
  level.scr_anim["barrel_oiltank_crush_1"]["derrick_explosion"] = % blackice_derrick_oiltank_barrel_1;
  level.scr_anim["barrel_oiltank_crush_2"]["derrick_explosion"] = % blackice_derrick_oiltank_barrel_2;
  level.scr_anim["barrel_oiltank_crush_3"]["derrick_explosion"] = % blackice_derrick_oiltank_barrel_3;
  level.scr_anim["barrel_oiltank_crush_4"]["derrick_explosion"] = % blackice_derrick_oiltank_barrel_4;
  level.scr_anim["barrel_oiltank_crush_5"]["derrick_explosion"] = % blackice_derrick_oiltank_barrel_5;
  level.scr_anim["barrel_oiltank_crush_6"]["derrick_explosion"] = % blackice_derrick_oiltank_barrel_6;
  level.scr_anim["barrel_oiltank_crush_7"]["derrick_explosion"] = % blackice_derrick_oiltank_barrel_7;
  level.scr_animtree["derrick_debris_1"] = #animtree;
  level.scr_model["derrick_debris_1"] = "ny_harbor_debris_misc_01";
  level.scr_anim["derrick_debris_1"]["derrick_debris_1"] = % blackice_derrick_debris_1_1;
  level.scr_anim["derrick_debris_1"]["derrick_debris_2"] = % blackice_derrick_debris_1_2;
  level.scr_animtree["derrick_debris_2"] = #animtree;
  level.scr_model["derrick_debris_2"] = "ny_harbor_debris_misc_02";
  level.scr_anim["derrick_debris_2"]["derrick_debris_1"] = % blackice_derrick_debris_2_1;
  level.scr_anim["derrick_debris_2"]["derrick_debris_2"] = % blackice_derrick_debris_2_2;
  level.scr_animtree["derrick_debris_3"] = #animtree;
  level.scr_model["derrick_debris_3"] = "ny_harbor_debris_misc_03";
  level.scr_anim["derrick_debris_3"]["derrick_debris_1"] = % blackice_derrick_debris_3_1;
  level.scr_anim["derrick_debris_3"]["derrick_debris_2"] = % blackice_derrick_debris_3_2;
  level.scr_animtree["derrick_debris_4"] = #animtree;
  level.scr_model["derrick_debris_4"] = "ny_harbor_debris_misc_04";
  level.scr_anim["derrick_debris_4"]["derrick_debris_1"] = % blackice_derrick_debris_4_1;
  level.scr_anim["derrick_debris_4"]["derrick_debris_2"] = % blackice_derrick_debris_4_2;
  level.scr_animtree["derrick_debris_5"] = #animtree;
  level.scr_model["derrick_debris_5"] = "ny_harbor_debris_misc_05";
  level.scr_anim["derrick_debris_5"]["derrick_debris_1"] = % blackice_derrick_debris_5_1;
  level.scr_anim["derrick_debris_5"]["derrick_debris_2"] = % blackice_derrick_debris_5_2;
  level.scr_animtree["derrick_debris_6"] = #animtree;
  level.scr_model["derrick_debris_6"] = "ny_harbor_debris_misc_06";
  level.scr_anim["derrick_debris_6"]["derrick_debris_1"] = % blackice_derrick_debris_6_1;
  level.scr_anim["derrick_debris_6"]["derrick_debris_2"] = % blackice_derrick_debris_6_2;
  maps\_anim::addnotetrack_customfunction("traveling_block", "hitground", ::notetrack_derrick_debris_hitground);
  maps\_anim::addnotetrack_customfunction("derrick_chunk", "hitground", ::notetrack_derrick_debris_hitground);
  maps\_anim::addnotetrack_customfunction("derrick_debris_1", "hitground", ::notetrack_derrick_debris_hitground);
  maps\_anim::addnotetrack_customfunction("derrick_debris_2", "hitground", ::notetrack_derrick_debris_hitground);
  maps\_anim::addnotetrack_customfunction("derrick_debris_3", "hitground", ::notetrack_derrick_debris_hitground);
  maps\_anim::addnotetrack_customfunction("derrick_debris_4", "hitground", ::notetrack_derrick_debris_hitground);
  maps\_anim::addnotetrack_customfunction("derrick_debris_5", "hitground", ::notetrack_derrick_debris_hitground);
  maps\_anim::addnotetrack_customfunction("derrick_debris_6", "hitground", ::notetrack_derrick_debris_hitground);
  level.scr_animtree["blackice_door_refinery"] = #animtree;
  level.scr_model["blackice_door_refinery"] = "blackice_door_refinery";
  level.scr_anim["blackice_door_refinery"]["command_enter"] = % blackice_door_controlroomdoor_2;
  level.scr_animtree["derrick_wires"] = #animtree;
  level.scr_animtree["drill_pipe1"] = #animtree;
  level.scr_model["drill_pipe1"] = "blackice_drill_pipe_single";
  level.scr_anim["drill_pipe1"]["fall"] = % blackice_topdrive_pipe1_fall;
  level.scr_animtree["drill_pipe2"] = #animtree;
  level.scr_model["drill_pipe2"] = "blackice_drill_pipe_single";
  level.scr_anim["drill_pipe2"]["fall"] = % blackice_topdrive_pipe2_fall;
  level.scr_animtree["drill_pipe3"] = #animtree;
  level.scr_model["drill_pipe3"] = "blackice_drill_pipe_single";
  level.scr_anim["drill_pipe3"]["fall"] = % blackice_topdrive_pipe3_fall;
  level.scr_animtree["drill_pipe4"] = #animtree;
  level.scr_model["drill_pipe4"] = "blackice_drill_pipe_single";
  level.scr_anim["drill_pipe4"]["fall"] = % blackice_topdrive_pipe4_fall;
  level.scr_animtree["top_drive"] = #animtree;
  level.scr_model["top_drive"] = "topdrive_destroyed";
  level.scr_anim["top_drive"]["fall"] = % blackice_topdrive_fall;
  level.scr_animtree["hiding_door"] = #animtree;
  level.scr_anim["hiding_door"]["grenade"] = % doorpeek_grenade_door;
  level.scr_anim["hiding_door"]["kick"] = % doorpeek_kick_door;
  level.scr_animtree["player_scuba"] = #animtree;
  level.scr_model["player_scuba"] = "prop_player_scuba_tank";
  level.scr_anim["player_scuba"]["scuba_intro"] = % blackice_scuba_intro;
  level.scr_animtree["player_mask"] = #animtree;
  level.scr_model["player_mask"] = "viewmodel_scuba_mask";
  level.scr_anim["player_mask"]["mask_surface"] = % blackice_mask_surface;
  level.scr_anim["player_mask"]["mask_surface_pt2"] = % blackice_mask_surface_pt2;
  level.scr_animtree["borescope"] = #animtree;
  level.scr_model["borescope"] = "blackice_borescope";
  level.scr_anim["borescope"]["borescope"] = % blackice_intro_borescope_01;
  level.scr_animtree["ascend_launcher_non_anim"] = #animtree;
  level.scr_model["ascend_launcher_non_anim"] = "black_ice_line_launcher";
  level.scr_animtree["ascend_hook"] = #animtree;
  level.scr_model["ascend_hook"] = "grappling_hook_rigged";
  level.scr_anim["ascend_hook"]["ascend_hook"] = % blackice_player_rigascend_hook;
  level.scr_animtree["ascend_hook_ally1"] = #animtree;
  level.scr_model["ascend_hook_ally1"] = "grappling_hook_rigged";
  level.scr_anim["ascend_hook_ally1"]["ascend_hook"] = % blackice_ally1_rigascend_hook;
  level.scr_animtree["ascend_hook_ally2"] = #animtree;
  level.scr_model["ascend_hook_ally2"] = "grappling_hook_rigged";
  level.scr_anim["ascend_hook_ally2"]["ascend_hook"] = % blackice_ally2_rigascend_hook;
  level.scr_animtree["ascend_hook_ally3"] = #animtree;
  level.scr_model["ascend_hook_ally3"] = "grappling_hook_rigged";
  level.scr_anim["ascend_hook_ally3"]["ascend_hook"] = % blackice_ally3_rigascend_hook;
  level.scr_animtree["ascend_hook_ally4"] = #animtree;
  level.scr_model["ascend_hook_ally4"] = "grappling_hook_rigged";
  level.scr_anim["ascend_hook_ally4"]["ascend_hook"] = % blackice_ally4_rigascend_hook;
  level.scr_animtree["ascend_launcher"] = #animtree;
  level.scr_model["ascend_launcher"] = "viewmodel_black_ice_line_launcher";
  level.scr_anim["ascend_launcher"]["alpha_rig_ascend_aim"] = % blackice_playerascender_rigascend_aim;
  level.scr_anim["ascend_launcher"]["alpha_rig_ascend_aim_loop"][0] = % blackice_playerascender_aim_loop;
  level.scr_anim["ascend_launcher"]["alpha_rig_ascend_linkup"] = % blackice_player_lineshooter_linkup;
  level.scr_anim["ascend_launcher"]["ascender_aim_left_parent"] = % ascender_aim_left;
  level.scr_anim["ascend_launcher"]["ascender_aim_right_parent"] = % ascender_aim_right;
  level.scr_anim["ascend_launcher"]["ascender_aim_up_parent"] = % ascender_aim_up;
  level.scr_anim["ascend_launcher"]["ascender_aim_down_parent"] = % ascender_aim_down;
  level.scr_anim["ascend_launcher"]["ascender_aim_left"] = % blackice_playerascender_aim_left;
  level.scr_anim["ascend_launcher"]["ascender_aim_right"] = % blackice_playerascender_aim_right;
  level.scr_anim["ascend_launcher"]["ascender_aim_up"] = % blackice_playerascender_aim_up;
  level.scr_anim["ascend_launcher"]["ascender_aim_down"] = % blackice_playerascender_aim_down;
  level.scr_animtree["ascend_ascender"] = #animtree;
  level.scr_model["ascend_ascender"] = "black_ice_rope_ascender";
  level.scr_anim["ascend_ascender"]["alpha_rig_ascend_linkup"] = % blackice_player_ascender_linkup;
  level.scr_anim["ascend_ascender"]["alpha_rig_ascend_groundidle"][0] = % blackice_player_ascender_groundidle;
  level.scr_anim["ascend_ascender"]["alpha_rig_ascend"] = % blackice_player_ascender_rigascend;
  level.scr_animtree["ally1_ascend_launcher"] = #animtree;
  level.scr_model["ally1_ascend_launcher"] = "rig_linelauncher_animated";
  level.scr_anim["ally1_ascend_launcher"]["ascend_runin"] = % blackice_ally1_lineshooter_runnin;
  level.scr_anim["ally1_ascend_launcher"]["ascend_waiting"][0] = % blackice_ally1_lineshooter_waiting;
  level.scr_anim["ally1_ascend_launcher"]["alpha_rope_shoot"] = % blackice_ally1_lineshooter_shoot;
  level.scr_anim["ally1_ascend_launcher"]["alpha_hand_rope"][0] = % blackice_ally1_lineshooter_idle;
  level.scr_anim["ally1_ascend_launcher"]["alpha_rig_ascend"] = % blackice_ally1_lineshooter_ascend;
  level.scr_animtree["ally1_ascend_ascender"] = #animtree;
  level.scr_model["ally1_ascend_ascender"] = "black_ice_rope_ascender";
  level.scr_anim["ally1_ascend_ascender"]["alpha_hand_rope"][0] = % blackice_ally1_ascender_idle;
  level.scr_anim["ally1_ascend_ascender"]["alpha_rig_ascend"] = % blackice_ally1_ascender_ascend;
  level.scr_animtree["ally2_ascend_launcher"] = #animtree;
  level.scr_model["ally2_ascend_launcher"] = "rig_linelauncher_animated";
  level.scr_anim["ally2_ascend_launcher"]["ascend_runin"] = % blackice_ally2_lineshooter_runnin;
  level.scr_anim["ally2_ascend_launcher"]["ascend_waiting"][0] = % blackice_ally2_lineshooter_waiting;
  level.scr_anim["ally2_ascend_launcher"]["alpha_rope_shoot"] = % blackice_ally2_lineshooter_shoot;
  level.scr_anim["ally2_ascend_launcher"]["alpha_hand_rope"][0] = % blackice_ally2_lineshooter_idle;
  level.scr_anim["ally2_ascend_launcher"]["alpha_rig_ascend"] = % blackice_ally2_lineshooter_ascend;
  level.scr_animtree["ally2_ascend_ascender"] = #animtree;
  level.scr_model["ally2_ascend_ascender"] = "black_ice_rope_ascender";
  level.scr_anim["ally2_ascend_ascender"]["alpha_hand_rope"][0] = % blackice_ally2_ascender_idle;
  level.scr_anim["ally2_ascend_ascender"]["alpha_rig_ascend"] = % blackice_ally2_ascender_ascend;
  level.scr_animtree["bravo1_ascend_launcher"] = #animtree;
  level.scr_model["bravo1_ascend_launcher"] = "rig_linelauncher_animated";
  level.scr_anim["bravo1_ascend_launcher"]["ascend_runin"] = % blackice_bravo2_lineshooter_runnin;
  level.scr_anim["bravo1_ascend_launcher"]["ascend_waiting"][0] = % blackice_bravo2_lineshooter_waiting;
  level.scr_anim["bravo1_ascend_launcher"]["bravo_rope_shoot"] = % blackice_bravo2_lineshooter_shoot;
  level.scr_anim["bravo1_ascend_launcher"]["bravo_rope_idle"][0] = % blackice_bravo2_lineshooter_idle;
  level.scr_anim["bravo1_ascend_launcher"]["bravo_rig_ascend"] = % blackice_bravo2_lineshooter_ascend;
  level.scr_animtree["bravo1_ascend_ascender"] = #animtree;
  level.scr_model["bravo1_ascend_ascender"] = "black_ice_rope_ascender";
  level.scr_anim["bravo1_ascend_ascender"]["bravo_rope_idle"][0] = % blackice_bravo1_ascender_idle;
  level.scr_anim["bravo1_ascend_ascender"]["bravo_rig_ascend"] = % blackice_bravo1_ascender_ascend;
  level.scr_animtree["bravo2_ascend_launcher"] = #animtree;
  level.scr_model["bravo2_ascend_launcher"] = "rig_linelauncher_animated";
  level.scr_anim["bravo2_ascend_launcher"]["ascend_runin"] = % blackice_bravo1_lineshooter_runnin;
  level.scr_anim["bravo2_ascend_launcher"]["ascend_waiting"][0] = % blackice_bravo1_lineshooter_waiting;
  level.scr_anim["bravo2_ascend_launcher"]["bravo_rope_shoot"] = % blackice_bravo1_lineshooter_shoot;
  level.scr_anim["bravo2_ascend_launcher"]["bravo_rope_idle"][0] = % blackice_bravo1_lineshooter_idle;
  level.scr_anim["bravo2_ascend_launcher"]["bravo_rig_ascend"] = % blackice_bravo1_lineshooter_ascend;
  level.scr_animtree["bravo2_ascend_ascender"] = #animtree;
  level.scr_model["bravo2_ascend_ascender"] = "black_ice_rope_ascender";
  level.scr_anim["bravo2_ascend_ascender"]["bravo_rope_idle"][0] = % blackice_bravo2_ascender_idle;
  level.scr_anim["bravo2_ascend_ascender"]["bravo_rig_ascend"] = % blackice_bravo2_ascender_ascend;
  level.scr_animtree["ascend_rope1"] = #animtree;
  level.scr_model["ascend_rope1"] = "black_ice_rope_prop";
  level.scr_anim["ascend_rope1"]["alpha_rope_shoot"] = % blackice_allyrope1_shoot;
  level.scr_anim["ascend_rope1"]["alpha_hand_rope"][0] = % blackice_allyrope1_hand;
  level.scr_anim["ascend_rope1"]["alpha_rig_ascend_linkup"] = % blackice_allyrope1_linkup;
  level.scr_anim["ascend_rope1"]["alpha_rig_ascend_groundidle"][0] = % blackice_allyrope1_groundidle;
  level.scr_anim["ascend_rope1"]["alpha_rig_ascend"] = % blackice_allyrope1_rigascend;
  level.scr_animtree["ascend_rope2"] = #animtree;
  level.scr_model["ascend_rope2"] = "black_ice_rope_prop";
  level.scr_anim["ascend_rope2"]["alpha_rope_shoot"] = % blackice_allyrope2_shoot;
  level.scr_anim["ascend_rope2"]["alpha_hand_rope"][0] = % blackice_allyrope2_hand;
  level.scr_anim["ascend_rope2"]["alpha_rig_ascend"] = % blackice_allyrope2_rigascend;
  level.scr_animtree["ascend_rope3"] = #animtree;
  level.scr_model["ascend_rope3"] = "black_ice_rope_prop";
  level.scr_anim["ascend_rope3"]["alpha_rope_shoot"] = % blackice_allyrope3_shoot;
  level.scr_anim["ascend_rope3"]["alpha_hand_rope"][0] = % blackice_allyrope3_hand;
  level.scr_anim["ascend_rope3"]["alpha_rig_ascend"] = % blackice_allyrope3_rigascend;
  level.scr_animtree["bravo_ascend_rope1"] = #animtree;
  level.scr_model["bravo_ascend_rope1"] = "black_ice_rope_prop";
  level.scr_anim["bravo_ascend_rope1"]["bravo_rope_shoot"] = % blackice_bravorope1_shoot;
  level.scr_anim["bravo_ascend_rope1"]["bravo_rope_idle"][0] = % blackice_bravorope1_idle;
  level.scr_anim["bravo_ascend_rope1"]["bravo_rig_ascend"] = % blackice_bravorope1_ascend;
  level.scr_animtree["bravo_ascend_rope2"] = #animtree;
  level.scr_model["bravo_ascend_rope2"] = "black_ice_rope_prop";
  level.scr_anim["bravo_ascend_rope2"]["bravo_rope_shoot"] = % blackice_bravorope2_shoot;
  level.scr_anim["bravo_ascend_rope2"]["bravo_rope_idle"][0] = % blackice_bravorope2_idle;
  level.scr_anim["bravo_ascend_rope2"]["bravo_rig_ascend"] = % blackice_bravorope2_ascend;
  maps\_anim::addnotetrack_sound("hiding_door", "sound door death", "any", "scn_blackice_door_kick");
  level.scr_animtree["flare_stack_console"] = #animtree;
  level.scr_anim["flare_stack_console"]["turn_off_flare_stack"] = % blackice_flare_stack_console_press;
  level.scr_anim["flare_stack_console"]["console_open"] = % blackice_flare_stack_console;
  level.scr_animtree["extinguisher"] = #animtree;
  level.scr_model["extinguisher"] = "com_fire_extinguisher_anim";
  level.scr_anim["extinguisher"]["extinguisher_loop1"][0] = % blackice_engineroom_firefighter1_ext_idle;
  level.scr_anim["extinguisher"]["extinguisher_loop2"][0] = % blackice_engineroom_firefighter2_ext_idle;
  level.scr_anim["extinguisher"]["extinguisher_loop3"][0] = % blackice_engineroom_firefighter3_ext_idle;
  level.scr_anim["extinguisher"]["extinguisher_loop_break1"] = % blackice_engineroom_firefighter1_ext;
  level.scr_anim["extinguisher"]["extinguisher_loop_break2"] = % blackice_engineroom_firefighter2_ext;
  level.scr_anim["extinguisher"]["extinguisher_loop_break3"] = % blackice_engineroom_firefighter3_ext;
  level.scr_animtree["tanks_pipe"] = #animtree;
  level.scr_model["tanks_pipe"] = "blackice_catwalk_collapse_pipe";
  level.scr_anim["tanks_pipe"]["tanks_bridge_fall_scene"] = % blackice_tanks_catwalk_collapse_pipe1;
  level.scr_animtree["tanks_bridge"] = #animtree;
  level.scr_anim["tanks_bridge"]["tanks_bridge_fall_scene"] = % blackice_tanks_catwalk_collapse_bridge;
  maps\_anim::addnotetrack_notify("tanks_bridge", "model_swap", "notify_bridge_model_swap", "tanks_bridge_fall_scene");
  level.scr_animtree["lifeboat1"] = #animtree;
  level.scr_anim["lifeboat1"]["lifeboat_deploy"] = % blackice_lifeboat1;
  level.scr_animtree["lifeboat2"] = #animtree;
  level.scr_anim["lifeboat2"]["lifeboat_deploy"] = % blackice_lifeboat2;
  level.scr_animtree["lifeboat_crates"] = #animtree;
  level.scr_model["lifeboat_crates"] = "blackice_lifeboat_crates";
  level.scr_anim["lifeboat_crates"]["lifeboat_deploy"] = % blackice_lifeboat_crates_01;
  level.scr_animtree["pipedeck_explosion2_rig"] = #animtree;
  level.scr_anim["pipedeck_explosion2_rig"]["pipes_explode"] = % blackice_pipedeck_explosion2_01;
  level.scr_animtree["pipedeck_explosion3_rig"] = #animtree;
  level.scr_anim["pipedeck_explosion3_rig"]["pipes_explode"] = % blackice_pipedeck_explosion3_01;
  level.scr_animtree["pipedeck_explosion4_rig"] = #animtree;
  level.scr_anim["pipedeck_explosion4_rig"]["pipes_explode"] = % blackice_pipedeck_explosion4_01;
  level.scr_animtree["pipedeck_pipe"] = #animtree;
  level.scr_model["pipedeck_pipe"] = "blackice_drill_pipe_single";
  level.scr_animtree["pipedeck_crate"] = #animtree;
  level.scr_model["pipedeck_crate"] = "ch_crate48x64_snow_no_tweak";
  level.scr_animtree["pipedeck_crane_1"] = #animtree;
  level.scr_anim["pipedeck_crane_1"]["pipes_explode"] = % blackice_pipedeck_explosion2_crane;
  level.scr_animtree["wires"] = #animtree;
  level.scr_anim["wires"]["vig_pipdeck_wires"][0] = % blackice_wires_pipedeck_01;
  level.scr_animtree["pipedeck_heli_target"] = #animtree;
  level.scr_model["pipedeck_heli_target"] = "blackice_pipedeck_heliattack_hitpoint";
  level.scr_anim["pipedeck_heli_target"]["final_support"] = % blackice_pipedeck_heliattack_hitpoint_01;
  level.scr_animtree["command_lever"] = #animtree;
  level.scr_anim["command_lever"]["command_player_end"] = % blackice_controlroom_lever_player_end;
  level.scr_anim["command_lever"]["command_player_early"] = % blackice_controlroom_lever_player_early;
  level.scr_anim["command_lever"]["command_player_late"] = % blackice_controlroom_lever_player_late;
  level.scr_anim["command_lever"]["command_player_control"] = % blackice_controlroom_lever_player_control;
  level.scr_anim["command_lever"]["command_baker_end"] = % blackice_controlroom_lever_baker_end;
  level.scr_anim["command_lever"]["command_baker_early"] = % blackice_controlroom_lever_baker_early;
  level.scr_anim["command_lever"]["command_baker_late"] = % blackice_controlroom_lever_baker_late;
  level.scr_animtree["command_monitor_fx_green"] = #animtree;
  level.scr_model["command_monitor_fx_green"] = "bi_command_center_panel_26_screen_green";
  level.scr_anim["command_monitor_fx_green"]["command_monitor_fx_1"] = % blackice_controlroom_monitor_fx_1;
  level.scr_anim["command_monitor_fx_green"]["command_monitor_fx_2"] = % blackice_controlroom_monitor_fx_2;
  level.scr_anim["command_monitor_fx_green"]["command_monitor_fx_3"] = % blackice_controlroom_monitor_fx_3;
  level.scr_animtree["command_monitor_fx_yellow"] = #animtree;
  level.scr_model["command_monitor_fx_yellow"] = "bi_command_center_panel_26_screen_yellow";
  level.scr_anim["command_monitor_fx_yellow"]["command_monitor_fx_1"] = % blackice_controlroom_monitor_fx_1;
  level.scr_anim["command_monitor_fx_yellow"]["command_monitor_fx_2"] = % blackice_controlroom_monitor_fx_2;
  level.scr_anim["command_monitor_fx_yellow"]["command_monitor_fx_3"] = % blackice_controlroom_monitor_fx_3;
  level.scr_animtree["command_monitor_fx_red"] = #animtree;
  level.scr_model["command_monitor_fx_red"] = "bi_command_center_panel_26_screen_red";
  level.scr_anim["command_monitor_fx_red"]["command_monitor_fx_1"] = % blackice_controlroom_monitor_fx_1;
  level.scr_anim["command_monitor_fx_red"]["command_monitor_fx_2"] = % blackice_controlroom_monitor_fx_2;
  level.scr_anim["command_monitor_fx_red"]["command_monitor_fx_3"] = % blackice_controlroom_monitor_fx_3;
  level.scr_animtree["command_shutoff_button"] = #animtree;
  level.scr_anim["command_shutoff_button"]["command_shutoff_button"] = % blackice_command_shutoff_button;
  level.scr_animtree["command_monitor"] = #animtree;
  level.scr_anim["command_monitor"]["command_monitor_player"] = % blackice_command_monitor_player;
  level.scr_anim["command_monitor"]["command_monitor_baker"] = % blackice_command_monitor_baker;
  level.scr_anim["command_monitor"]["command_monitor_player_end"] = % blackice_command_monitor_player_end;
  level.scr_anim["command_monitor"]["command_monitor_baker_end"] = % blackice_command_monitor_baker_end;
  level.scr_animtree["command_opfor1_chair"] = #animtree;
  level.scr_model["command_opfor1_chair"] = "blackice_commandcenter_chair";
  level.scr_anim["command_opfor1_chair"]["command_death"] = % blackice_controlroompanel_chair_death;
  level.scr_anim["command_opfor1_chair"]["command_start"] = % blackice_controlroompanel_chair_death_push;
  level.scr_animtree["command_enemy_1"] = #animtree;
  level.scr_animtree["command_enemy_2"] = #animtree;
  level.scr_model["command_enemy_1"] = "body_oil_worker_ab";
  level.scr_model["command_enemy_2"] = "body_oil_worker_bb";
  level.scr_anim["command_enemy_1"]["command_idle"][0] = % blackice_controlroompanel_opfor1_loop;
  level.scr_anim["command_enemy_1"]["command_death"] = % blackice_controlroompanel_opfor1_death;
  level.scr_anim["command_enemy_1"]["command_start"] = % blackice_controlroompanel_opfor1_death_push;
  level.scr_anim["command_enemy_2"]["command_idle"][0] = % blackice_controlroompanel_opfor2_loop;
  level.scr_anim["command_enemy_2"]["command_death"] = % blackice_controlroompanel_opfor2_death;
  level.scr_anim["command_enemy_2"]["command_start"] = % blackice_controlroom_player_start_opfor;
  level.scr_animtree["debris01"] = #animtree;
  level.scr_anim["debris01"]["runout_group1"] = % blackice_runout_group_1;
  level.scr_model["debris01"] = "blackice_runout_group1";
  level.scr_animtree["debris02"] = #animtree;
  level.scr_anim["debris02"]["runout_group2"] = % blackice_runout_group_2;
  level.scr_model["debris02"] = "blackice_runout_group2";
  level.scr_animtree["debris03"] = #animtree;
  level.scr_anim["debris03"]["runout_group3"] = % blackice_runout_group_3;
  level.scr_model["debris03"] = "blackice_runout_group3";
  level.scr_animtree["bulkhead_door"] = #animtree;
  level.scr_model["bulkhead_door"] = "bulkhead_door";
  level.scr_anim["bulkhead_door"]["shoulder_door"] = % blackice_controlroom_exfil_finalroom_door;
  level.scr_animtree["exfil_helo"] = #animtree;
  level.scr_model["exfil_helo"] = "vehicle_mi24p_hind_blackice";
  level.scr_anim["exfil_helo"]["idle"] = % blackice_helo_idle;
  level.scr_anim["exfil_helo"]["ladder_chase"] = % blackice_helo_explode;
  maps\_anim::addnotetrack_notify("exfil_helo", "spotlight_on", "notify_helo_spotlight_on", "idle");
  maps\_anim::addnotetrack_notify("exfil_helo", "spotlight_off", "notify_helo_spotlight_off", "ladder_chase");
  level.scr_animtree["cam_shake"] = #animtree;
  level.scr_model["cam_shake"] = "tag_origin";
  level.scr_anim["cam_shake"]["jump_shake"] = % blackice_player_exfil_jumpcam;
  level.scr_anim["cam_shake"]["jump_shake_fail"] = % blackice_player_exfil_jumpcam_fail;
  level.scr_animtree["exfil_ladder"] = #animtree;
  level.scr_model["exfil_ladder"] = "blackice_rope_ladder";
  level.scr_anim["exfil_ladder"]["idle"] = % blackice_rope_ladder_idle;
  level.scr_anim["exfil_ladder"]["ladder_chase"] = % blackice_rope_ladder_explode;
  level.scr_animtree["exfil_oilrig"] = #animtree;
  level.scr_model["exfil_oilrig"] = "black_ice_rig_platform";
  level.scr_anim["exfil_oilrig"]["ladder_chase"] = % blackice_oilrig_exfil_explode;
  maps\_anim::addnotetrack_notify("exfil_oilrig", "sphere_start_fall", "notify_sphere_start_fall", "ladder_chase");
  maps\_anim::addnotetrack_notify("exfil_oilrig", "sphere_hit_ground", "notify_sphere_hit_ground", "ladder_chase");
  maps\_anim::addnotetrack_notify("exfil_oilrig", "rig_explode", "notify_rig_explode", "ladder_chase");
  level.scr_animtree["exfil_lifeboat1"] = #animtree;
  level.scr_model["exfil_lifeboat1"] = "rnk_lifeboat";
  level.scr_anim["exfil_lifeboat1"]["ladder_chase"] = % blackice_lifeboat1_exfil_explode;
  level.scr_animtree["exfil_lifeboat2"] = #animtree;
  level.scr_model["exfil_lifeboat2"] = "rnk_lifeboat";
  level.scr_anim["exfil_lifeboat2"]["ladder_chase"] = % blackice_lifeboat2_exfil_explode;
  level.scr_animtree["exfil_lifeboat3"] = #animtree;
  level.scr_model["exfil_lifeboat3"] = "rnk_lifeboat";
  level.scr_anim["exfil_lifeboat3"]["ladder_chase"] = % blackice_lifeboat3_exfil_explode;
  level.scr_animtree["exfil_lifeboat4"] = #animtree;
  level.scr_model["exfil_lifeboat4"] = "rnk_lifeboat";
  level.scr_anim["exfil_lifeboat4"]["ladder_chase"] = % blackice_lifeboat4_exfil_explode;
  level.scr_animtree["exfil_lifeboat5"] = #animtree;
  level.scr_model["exfil_lifeboat5"] = "rnk_lifeboat";
  level.scr_anim["exfil_lifeboat5"]["ladder_chase"] = % blackice_lifeboat5_exfil_explode;
  level.scr_animtree["exfil_lifeboat6"] = #animtree;
  level.scr_model["exfil_lifeboat6"] = "rnk_lifeboat";
  level.scr_anim["exfil_lifeboat6"]["ladder_chase"] = % blackice_lifeboat6_exfil_explode;
  level.scr_animtree["exfil_lifeboat7"] = #animtree;
  level.scr_model["exfil_lifeboat7"] = "rnk_lifeboat";
  level.scr_anim["exfil_lifeboat7"]["ladder_chase"] = % blackice_lifeboat7_exfil_explode;
  level.scr_animtree["exfil_lifeboat8"] = #animtree;
  level.scr_model["exfil_lifeboat8"] = "rnk_lifeboat";
  level.scr_anim["exfil_lifeboat8"]["ladder_chase"] = % blackice_lifeboat8_exfil_explode;
  level.scr_animtree["exfil_lifeboat9"] = #animtree;
  level.scr_model["exfil_lifeboat9"] = "rnk_lifeboat";
  level.scr_anim["exfil_lifeboat9"]["ladder_chase"] = % blackice_lifeboat9_exfil_explode;
  level.scr_animtree["exfil_lifeboat10"] = #animtree;
  level.scr_model["exfil_lifeboat10"] = "rnk_lifeboat";
  level.scr_anim["exfil_lifeboat10"]["ladder_chase"] = % blackice_lifeboat10_exfil_explode;
  level.scr_animtree["exfil_lifeboat11"] = #animtree;
  level.scr_model["exfil_lifeboat11"] = "rnk_lifeboat";
  level.scr_anim["exfil_lifeboat11"]["ladder_chase"] = % blackice_lifeboat11_exfil_explode;
  level.scr_animtree["exfil_lifeboat12"] = #animtree;
  level.scr_model["exfil_lifeboat12"] = "rnk_lifeboat";
  level.scr_anim["exfil_lifeboat12"]["ladder_chase"] = % blackice_lifeboat12_exfil_explode;
  level.scr_animtree["exfil_lifeboat13"] = #animtree;
  level.scr_model["exfil_lifeboat13"] = "rnk_lifeboat";
  level.scr_anim["exfil_lifeboat13"]["ladder_chase"] = % blackice_lifeboat13_exfil_explode;
  level.scr_animtree["exfil_lifeboat14"] = #animtree;
  level.scr_model["exfil_lifeboat14"] = "rnk_lifeboat";
  level.scr_anim["exfil_lifeboat14"]["ladder_chase"] = % blackice_lifeboat14_exfil_explode;
  level.scr_animtree["exfil_lifeboat15"] = #animtree;
  level.scr_model["exfil_lifeboat15"] = "rnk_lifeboat";
  level.scr_anim["exfil_lifeboat15"]["ladder_chase"] = % blackice_lifeboat15_exfil_explode;
  level.scr_animtree["exfil_lifeboat16"] = #animtree;
  level.scr_model["exfil_lifeboat16"] = "rnk_lifeboat";
  level.scr_anim["exfil_lifeboat16"]["ladder_chase"] = % blackice_lifeboat16_exfil_explode;
  level.scr_animtree["exfil_lifeboat17"] = #animtree;
  level.scr_model["exfil_lifeboat17"] = "rnk_lifeboat";
  level.scr_anim["exfil_lifeboat17"]["ladder_chase"] = % blackice_lifeboat17_exfil_explode;
  level.scr_animtree["exfil_lifeboat18"] = #animtree;
  level.scr_model["exfil_lifeboat18"] = "rnk_lifeboat";
  level.scr_anim["exfil_lifeboat18"]["ladder_chase"] = % blackice_lifeboat18_exfil_explode;
  level.scr_animtree["exfil_lifeboat19"] = #animtree;
  level.scr_model["exfil_lifeboat19"] = "rnk_lifeboat";
  level.scr_anim["exfil_lifeboat19"]["ladder_chase"] = % blackice_lifeboat19_exfil_explode;
  level.scr_animtree["exfil_lifeboat20"] = #animtree;
  level.scr_model["exfil_lifeboat20"] = "rnk_lifeboat";
  level.scr_anim["exfil_lifeboat20"]["ladder_chase"] = % blackice_lifeboat20_exfil_explode;
  level.scr_animtree["exfil_viewexplosion_source"] = #animtree;
  level.scr_model["exfil_viewexplosion_source"] = "bi_viewexplosion_source";
}

collapsed_derrick_wire_anims() {
  var_0 = getent("derrick_wires", "targetname");
  var_0.animname = "derrick_wires";
  var_0 maps\_anim::setanimtree();
  var_0 setanim( % blackice_derrick_collapse_wires_1, 1, 0, 1);
  var_0 setanim( % blackice_derrick_collapse_wires_2, 1, 0, 1);
  var_0 setanim( % blackice_derrick_collapse_wires_3, 1, 0, 1);
  var_0 setanim( % blackice_derrick_collapse_wires_4, 1, 0, 1);
  var_0 setanim( % blackice_derrick_collapse_wires_5, 1, 0, 1);
  var_0 setanim( % blackice_derrick_collapse_wires_6, 1, 0, 1);
}

#using_animtree("vehicles");

vehicle_anims() {
  level.scr_anim["bc_reinforce_helo"]["arrive"] = % blackice_basecamp_heliarrival;
  level.scr_anim["bc_reinforce_helo"]["idle_loop"][0] = % blackice_basecamp_heliidle;
  level.scr_anim["bc_reinforce_helo"]["leave"] = % blackice_basecamp_helileave;
  level.scr_animtree["pipedeck_heli"] = #animtree;
  level.scr_model["pipedeck_heli"] = "blackice_drill_pipe_single";
  level.scr_anim["pipedeck_heli"]["heli_reveal"] = % blackice_topdrive_helireveal;
  level.scr_anim["pipedeck_heli"]["heli_reveal_loop"][0] = % blackice_topdrive_helireveal_loop;
  level.scr_anim["pipedeck_heli"]["final_support"] = % blackice_pipedeck_heliattack_01;
  maps\_anim::addnotetrack_notify("pipedeck_heli", "gun_on", "notify_heli_anim_fire_on", "final_support");
  maps\_anim::addnotetrack_notify("pipedeck_heli", "gun_off", "notify_heli_anim_fire_off", "final_support");
  maps\_anim::addnotetrack_notify("pipedeck_heli", "command_lights_out", "notify_command_lights_out", "final_support");
}

notetrack_swim_loosen_lookaround(var_0) {
  level.player lerpviewangleclamp(1.0, 0, 0, level.spring_cam_max_clamp, level.spring_cam_max_clamp, level.spring_cam_max_clamp, level.spring_cam_max_clamp);
}

notetrack_swim_begin_player_control(var_0) {
  level.player unlink();
  level.player_mover delete();
  level.player_rig delete();
}

notetrack_player_breach_water(var_0) {
  var_1 = 0.2;
  var_2 = 0.2;
  var_3 = 1.5;
  var_4 = maps\_hud_util::create_client_overlay("black", 0, level.player);
  var_4 fadeovertime(var_1);
  var_4.alpha = 1;
  wait(var_1);
  thread maps\_utility::vision_set_fog_changes("black_ice_basecamp_breach", 0.1);
  common_scripts\utility::flag_set("player_water_breach");
  wait(var_2);
  level.breach_anim_node thread maps\_anim::anim_single_solo(level.breach_props["breach_water"], "intro_breach_end");
  level.breach_anim_node thread maps\_anim::anim_single_solo(level.breach_props["ice_chunks1"], "intro_breach_end");
  level.breach_anim_node thread maps\_anim::anim_single_solo(level.breach_props["introbreach_props"], "intro_breach_end");
  level.player maps\_underwater::underwater_hud_enable(0);
  level.player thread maps\_underwater::stop_player_scuba();

  if(isDefined(level.player.hud_scubamask))
    level.player.hud_scubamask maps\_hud_util::destroyelem();

  level.player_mask show();
  var_4 fadeovertime(var_3);
  var_4.alpha = 0;
  thread maps\_utility::vision_set_fog_changes("black_ice_basecamp", 1.5);
  wait(var_3);
  var_4 destroy();
}

notetrack_intro_ally2_bubbles(var_0) {
  playFXOnTag(common_scripts\utility::getfx("scuba_bubbles_friendly"), var_0.scuba_org, "tag_origin");
}

notetrack_remove_mask(var_0) {}

notetrack_release_allies(var_0) {
  level notify("bc_release_allies");
}

notetrack_player_draw_weapon_surface(var_0) {
  level.player takeweapon("aps_underwater+swim");
  level.player switchtoweapon(level.default_weapon);
  level.player giveweapon("fraggrenade");
  level.player giveweapon("flash_grenade");
  level.player.disablereload = 0;
  level.player enableweapons();
  level.player enableoffhandweapons();
  level.player enableweaponswitch();
  setsaveddvar("hud_drawhud", 1);
  maps\black_ice_util::black_ice_show_previous_hud();
  level.player.early_weapon_enabled = 1;
}

notetrack_player_draw_weapon_ascend(var_0) {
  level.player.disablereload = 0;
  level.player enableweapons();
  level.player enableoffhandweapons();
  level.player enableweaponswitch();
  level.player.early_weapon_enabled = 1;
}

notetrack_derrick_small_explosion(var_0) {
  level notify("notify_derrick_small_explosion");
}

notetrack_traveling_block_impact(var_0) {
  thread maps\black_ice_audio::sfx_blackice_derrick_exp6_ss();
  level notify("notify_traveling_block_impact");
}

notetrack_derrick_large_explosion(var_0) {
  level notify("notify_derrick_large_explosion");
  common_scripts\utility::flag_set("flag_derrick_exploded");
}

notetrack_derrick_impact_rig(var_0) {
  level notify("notify_derrick_impact_rig");
}

notetrack_refinery_start_combat(var_0) {
  level notify("notify_notetrack_debris_end");
}

notetrack_ascend_rubberband_bravo_stop(var_0) {
  level notify("notify_ascend_rubberband_bravo_stop");
}

notetrack_ascend_rubberband_alpha_start(var_0) {
  level notify("notify_ascend_rubberband_alpha_start");
}

notetrack_ascend_rubberband_alpha_stop(var_0) {
  level notify("notify_ascend_rubberband_alpha_stop");
}

notetrack_player_free_look_active(var_0) {
  level.player lerpviewangleclamp(0.02, 0, 0, 60, 60, 60, 60);
}

notetrack_player_additive_anims_start(var_0) {
  level.player notify("notify_additive_anims_start");
  level.allow_player_ascend_move = 1;
  var_0 setanimlimited(level.scr_anim["player_rig"]["player_rigascend_noise"], 1, 0.1);
  var_0 setanimlimited(level.scr_anim["player_rig"]["rigascend_noise_parent"], 0, 0.1);
  maps\black_ice_ascend::player_ramp_up_wind();
}

notetrack_ascend_end_player_control(var_0) {
  level.allow_player_ascend_move = 0;
  thread maps\black_ice_audio::sfx_stop_ascent_sounds();
  thread maps\black_ice_audio::sfx_ascend_wind_last();
  level.player lerpviewangleclamp(1.0, 0, 0, 0, 0, 0, 0);
  level.player_rig setanim(level.scr_anim["player_rig"]["rig_ascend_start"], 0.0);
  level.player_legs setanim(level.scr_anim["player_legs_ascend"]["rig_ascend_start"], 0.0);
  level.player_rig setanim(level.scr_anim["player_rig"]["rig_ascend_stop"], 0.0);
  level.player_legs setanim(level.scr_anim["player_legs_ascend"]["rig_ascend_stop"], 0.0);
  level.player_rig setanimlimited(level.scr_anim["player_rig"]["player_rigascend_noise"], 0.0, 0.2);
  level.player_rig setanimlimited(level.scr_anim["player_rig"]["rigascend_noise_parent"], 0.0, 0.2);
  level notify("notify_end_ascend_pendulum");
  wait(level.timestep);
  level.player_ascend_anim_node rotateto((0, level.player_ascend_anim_node.angles[1], 0), level.timestep);
  level notify("notify_ascend_objective_complete");
  wait 5;
  maps\_utility::autosave_by_name("catwalk_start");
}

notetrack_cw_tape_explode(var_0) {
  level notify("notify_cw_tape_explode");
}

notetrack_control_room_allow_free_look(var_0) {
  level notify("notify_control_room_allow_free_look");
}

notetrack_control_room_start_baker(var_0) {
  common_scripts\utility::flag_set("flag_command_baker_console_anim");
}

notetrack_dialogue_hallclear(var_0) {
  level._allies[0] maps\_utility::smart_dialogue("black_ice_bkr_hallwayclearletsmove");
}

notetrack_exfil_dialog_1(var_0) {
  level notify("notify_exfil_dialog_1");
}

notetrack_exfil_dialog_2(var_0) {
  level notify("notify_exfil_dialog_2");
}

notetrack_player_teleport(var_0) {
  level notify("notify_exfil_player_teleport");
  level notify("notify_stop_view_smoke_fx");
}

notetrack_heli_swing(var_0) {
  common_scripts\utility::flag_set("flag_helo_swing");
  level.player playrumbleonentity("helo_ladder_swing");
}

notetrack_start_slomo(var_0) {
  level notify("notify_exfil_start_slomo");
}

notetrack_end_slomo(var_0) {
  level notify("notify_exfil_end_slomo");
}

ambient_derrick_animation() {
  thread collapsed_derrick_wire_anims();
}

notetrack_command_dialog_fail_early(var_0) {
  thread maps\black_ice_util::temp_dialogue_line("Baker", "ROOK!TO SOON!GET OUT, NOW!!!", 3);
}

notetrack_command_dialog_fail_late(var_0) {
  maps\_utility::radio_dialogue_stop();
  wait 0.5;
  level._allies[0] maps\_utility::smart_radio_dialogue_interrupt("black_ice_mrk_shitadamkeepthe");
}

notetrack_command_dialog_end(var_0) {
  level notify("notify_dialog_command_end");
}

notetrack_derrick_debris_hitground(var_0) {
  var_0 notify("hitground");
}

notetrack_derrick_debris_hit_1(var_0) {
  level notify("notify_debris_ground_fx_1");
}

notetrack_derrick_debris_hit_2(var_0) {
  level notify("notify_debris_ground_fx_2");
}

notetrack_derrick_chunk_hit_barrels(var_0) {
  earthquake(0.33, 0.65, level.player.origin, 128);
  level.player playrumbleonentity("damage_light");
}

notetrack_oiltank_catwalk_swap(var_0) {
  level notify("notify_swap_catwalk");
}

notetrack_tanks_start_custom_death(var_0) {
  level notify("notify_tanks_start_custom_death");
}

notetrack_tanks_end_custom_death(var_0) {
  level notify("notify_tanks_end_custom_death");
}

smooth_player_link(var_0, var_1) {
  level.player playerlinktoblend(var_0, "tag_player", var_1);
  wait(var_1);
  level.player playerlinktodelta(var_0, "tag_player", 1, 0, 0, 0, 0, 1);
  var_0 show();
}

snake_cam_enemy_anims() {
  for(var_0 = 1; var_0 < level.snake_cam_enemies.size; var_0++)
    level.snake_cam_anim_node thread maps\_anim::anim_single_solo(level.snake_cam_enemies[var_0], "intro_" + (var_0 + 1));

  level.snake_cam_anim_node maps\_anim::anim_single_solo(level.snake_cam_enemies[0], "intro_1");

  foreach(var_2 in level.snake_cam_enemies) {
    var_2 delete();
    var_2 = undefined;
  }
}

swim_intro_anims() {
  level.allies_breach_anim_node thread maps\_anim::anim_single_solo(level.player_scuba, "scuba_intro");
  level.allies_breach_anim_node thread maps\_anim::anim_single_solo(level.borescope, "borescope");
  level.borescope thread maps\black_ice_util::delete_at_anim_end("borescope", "borescope");
  level.allies_breach_anim_node thread maps\_anim::anim_single_solo(level.player_rig, "player_intro");
  level.allies_breach_anim_node thread maps\_anim::anim_single_solo(level._allies_swim[0], "intro_ally1");
  level.allies_breach_anim_node thread maps\_anim::anim_single_solo(level._allies_swim[1], "intro_ally2");
  level common_scripts\utility::waittill_either("notify_swim_dialog5_1", "flag_swim_breach_detonate");

  if(!common_scripts\utility::flag("flag_swim_breach_detonate"))
    thread swim_await_detonate_anims();
}

swim_await_detonate_anims() {
  for(var_0 = 0; var_0 < level.const_expected_num_swim_allies; var_0++)
    level.allies_breach_anim_node thread maps\_anim::anim_loop_solo(level._allies_swim[var_0], "intro_ally" + (var_0 + 1) + "_idle", "stop_loop");
}

swim_enemies_first_frame_anims() {
  for(var_0 = 0; var_0 < level.ice_breach_enemies.size; var_0++)
    level.breach_anim_node thread maps\_anim::anim_first_frame_solo(level.ice_breach_enemies[var_0], "introbreach_opfor" + var_0);
}

swim_props_first_frame_anims() {
  level.allies_breach_anim_node thread maps\_anim::anim_first_frame_solo(level.borescope, "borescope");
  level.breach_anim_node maps\_anim::anim_first_frame(level.breach_props, "intro_breach");
}

swim_vehicles_snake_cam_anims() {
  level.snake_cam_anim_node thread maps\_anim::anim_single(level.breach_vehicles, "intro_drive");
  level.snake_cam_anim_node thread maps\_anim::anim_single(level.vehicles_no_breach, "intro_drive");
  level.vehicles_no_breach["bm21_3"] thread maps\black_ice_util::delete_at_anim_end("bm21_3", "intro_drive");
  level.vehicles_no_breach["gaztiger_2"] thread maps\black_ice_util::delete_at_anim_end("gaztiger_2", "intro_drive");
  level.vehicles_no_breach["snowmobile_1"] thread maps\black_ice_util::delete_at_anim_end("snowmobile_1", "intro_drive");
  level.vehicles_no_breach["snowmobile_2"] thread maps\black_ice_util::delete_at_anim_end("snowmobile_2", "intro_drive");
}

notetrack_snake_cam_retract(var_0) {
  level.snake_cam_anim_node thread maps\_anim::anim_single_solo(level.snake_cam_dummy, "retract");
}

notetrack_snake_enemy_dismount(var_0) {
  var_1 = getEntArray("enemy_dismount", "script_noteworthy");
  var_2 = maps\_utility::array_spawn(var_1);

  foreach(var_4 in var_2) {
    var_4.animname = var_4.script_parameters;
    var_4 maps\black_ice_util::ignore_everything();
    var_4 thread maps\_utility::magic_bullet_shield();
  }

  level.snake_cam_anim_node maps\_anim::anim_single(var_2, "enemy_dismount");

  foreach(var_4 in var_2) {
    var_4 maps\_utility::stop_magic_bullet_shield();
    var_4 delete();
  }
}

notetrack_snake_cam_lens_water(var_0) {
  common_scripts\utility::flag_set("flag_snake_cam_below_water");
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setModel("tag_origin");
  var_1 linktoplayerview(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
  playFXOnTag(common_scripts\utility::getfx("snake_cam_waterline_under"), var_1, "tag_origin");
  level waittill("snake_cam_transition_to_underwater_complete");
  stopFXOnTag(common_scripts\utility::getfx("snake_cam_waterline_under"), var_1, "tag_origin");
  var_1 delete();
}

notetrack_snake_cam_underwater_transition(var_0) {
  level notify("notify_underwater_transition");
  common_scripts\utility::flag_set("flag_intro_above_ice");

  if(!level.console && !level.player common_scripts\utility::is_player_gamepad_enabled())
    level.player enablemousesteer(0);
}

swim_breach_anims() {
  level.allies_breach_anim_node notify("stop_loop");

  for(var_0 = 0; var_0 < level.const_expected_num_swim_allies; var_0++)
    level.allies_breach_anim_node thread maps\_anim::anim_single_solo(level._allies_swim[var_0], "breach_ally" + (var_0 + 1));

  for(var_0 = 0; var_0 < level.ice_breach_enemies.size; var_0++) {
    level.breach_anim_node thread maps\_anim::anim_single_solo(level.ice_breach_enemies[var_0], "introbreach_opfor" + var_0);
    level.ice_breach_enemies[var_0].deathanim = level.ice_breach_enemies[var_0] maps\_utility::getanim("death_anim" + var_0);
  }

  level.breach_anim_node thread maps\_anim::anim_single(level.breach_props, "intro_breach");
  thread swim_breach_ice_anims();
  level.breach_anim_node thread maps\_anim::anim_single(level.breach_vehicles, "intro_breach");
  thread maps\black_ice_fx::intro_turn_on_vehicle_underwater_lights_fx();
}

swim_breach_ice_anims() {
  level endon("bc_player_ready");

  while(!level.breach_props["ice_chunks1"] maps\black_ice_util::check_anim_time("ice_chunks1", "intro_breach", 1.0))
    wait(level.timestep);

  level.breach_anim_node thread maps\_anim::anim_loop_solo(level.breach_props["ice_chunks1"], "intro_breach_loop", "stop_loop");
}

swim_enemy_death_anim_override() {
  if(!isDefined(self.nodeathsound))
    animscripts\death::playdeathsound();

  if(isDefined(self.deathanim)) {
    self animmode("nogravity");
    self stopanimscripted();
    self setflaggedanimknoblimitedrestart("deathanim", self.deathanim, 1, 0.4);
    playFXOnTag(common_scripts\utility::getfx("swim_ai_death_blood"), self, "j_spineupper");
    wait(getanimlength(self.deathanim));
    return 1;
  }

  return 0;
}

swim_allies_swim_forward() {
  for(var_0 = 0; var_0 < level._allies_swim.size; var_0++)
    thread swim_single_ally_swim_forward(var_0);
}

swim_single_ally_swim_forward(var_0) {
  level.allies_breach_anim_node maps\_anim::anim_single_solo(level._allies_swim[var_0], "surface_ally" + (var_0 + 1));

  if(!common_scripts\utility::flag("flag_player_breaching"))
    level.allies_breach_anim_node thread maps\_anim::anim_loop_solo(level._allies_swim[var_0], "surface_ally" + (var_0 + 1) + "_idle");
}

swim_ally_surface_anim() {
  var_0 = level.allies_breach_anim_node;
  var_0 thread maps\black_ice_swim::scuba_surface(0.5, level._allies_swim[0], "surface_ally1_up", level._allies[0], "bc_node_surf_ally1");
  var_0 thread maps\black_ice_swim::bravo_post_snake_cam(0.0, level._bravo[0], "bc_node_surf_bravo1", "surface_ally3_up");
  var_0 thread maps\black_ice_swim::bravo_post_snake_cam(0.0, level._bravo[1], "bc_node_surf_bravo2");
  var_0 maps\black_ice_swim::scuba_surface(2.0, level._allies_swim[1], "surface_ally2_up", level._allies[1], "bc_node_surf_ally2");
  level notify("notify_ally_swim_surface_anims_done");
}

swim_truck_surface_anim() {
  var_0 = common_scripts\utility::getstruct("vignette_truck_fall", "script_noteworthy");
  var_1 = maps\_utility::spawn_anim_model("blackice_ice_chunks_truck");
  var_2 = maps\_utility::spawn_anim_model("bm21_1");
  level.surface_truck = var_2;
  level.blackice_ice_chunks_truck = var_1;
  var_3 = [var_2, var_1];
  var_0 maps\_anim::anim_first_frame(var_3, "surface_truck");
  level waittill("flag_player_breaching");
  var_0 maps\_anim::anim_single(var_3, "surface_truck");
}

swim_truck_surface_destroy() {
  wait 0.1;
  level.surface_truck delete();
  level.surface_truck = undefined;
}

swim_player_surface_anim() {
  var_0 = maps\_utility::spawn_anim_model("player_rig");
  var_0 setanim(level.scr_anim["player_rig"]["player_surface_arms"]);
  var_1 = var_0 gettagorigin("tag_knife_attach");
  level.player_rig = maps\_utility::spawn_anim_model("player_rig");
  level.player_rig hide();
  level.allies_breach_anim_node thread maps\_anim::anim_single_solo(level.player_rig, "player_surface_root");
  level.player playerlinktoblend(level.player_rig, "tag_player", 1.6);
  var_2 = maps\_utility::spawn_anim_model("player_mask", var_1);
  level.player_mask = var_2;
  var_2 hide();
  level.allies_breach_anim_node thread maps\_anim::anim_single_solo(var_2, "mask_surface");

  while(!level.player_rig maps\black_ice_util::check_anim_time("player_rig", "player_surface_root", 1.0)) {
    if(common_scripts\utility::flag("flag_surface_anim_swap")) {
      break;
    }

    var_1 = level.player getEye();
    var_3 = level.player getplayerangles();
    var_0.origin = var_1;
    var_0.angles = var_3;
    wait(level.timestep);
  }

  var_0 delete();
  level.player_rig show();
  level.player_rig stopanimscripted();
  var_2 stopanimscripted();
  level._bravo[0] stopanimscripted();
  level.allies_breach_anim_node thread maps\_anim::anim_single_solo(level.player_rig, "player_surface_root_pt2");
  level.allies_breach_anim_node thread maps\_anim::anim_single_solo(var_2, "mask_surface_pt2");
  level.allies_breach_anim_node thread maps\_anim::anim_single_solo(level._bravo[0], "surface_ally3_up_pt2");

  while(!level.player_rig maps\black_ice_util::check_anim_time("player_rig", "player_surface_root_pt2", 1.0))
    wait(level.timestep);

  level notify("bc_player_ready");
  var_2 delete();
  level.player_mask = undefined;
  thread maps\_swim_ai_common::restore_water_footsteps();
}

intro_player_goggles_watersheeting_fx() {
  level.player setwatersheeting(1, 3);
}

cw_common_breach_player(var_0) {
  var_1 = getent("cw_vig_common_room_breach", "targetname");
  level.breach_charge = maps\_utility::spawn_anim_model("breach_door_charge");
  var_2 = maps\_utility::spawn_anim_model("player_rig");
  var_2 hide();
  var_0 maps\_utility::assign_animtree("common_door");
  level.player disableweapons();
  level.player freezecontrols(1);
  level.player allowprone(0);
  level.player allowcrouch(0);
  var_3 = tolower(level.player getcurrentweapon());

  if(issubstr(var_3, "mts255"))
    wait 0.2;
  else if(issubstr(var_3, "panzerfaust"))
    wait 0.6;

  var_4 = [var_2, level.breach_charge];
  var_5 = 0;
  thread smooth_player_link(var_2, 0.4);
  var_1 thread maps\_anim::anim_single_solo(var_4[1], "breach");
  var_0 thread maps\_anim::anim_single_solo(var_0, "bullets");
  var_1 maps\_anim::anim_single_solo(var_4[0], "breach");
  level.player unlink();
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player thread maps\black_ice_catwalks::cw_common_perfect_breach_proc();
  var_2 delete();
}

cw_common_breach_draw_weapon(var_0) {
  level.player enableweapons();
}

cw_common_breach_allies() {
  var_0 = getent("cw_vig_common_room_breach", "targetname");
  var_0 maps\_anim::anim_single(level._allies, "rec_breach");
  var_0 thread maps\_anim::anim_loop(level._allies, "rec_breach_idle", "stop_looping_anim");
  common_scripts\utility::flag_wait("flag_common_breach_done");
  var_0 notify("stop_looping_anim");
  var_0 maps\_anim::anim_single(level._allies, "rec_breach_move", undefined, 0.1);
}

vig_actor_kill(var_0) {
  if(!isalive(var_0)) {
    return;
  }
  if(isDefined(var_0.magic_bullet_shield))
    var_0 maps\_utility::stop_magic_bullet_shield();

  var_0.allowdeath = 1;
  var_0.a.nodeath = 1;
  var_0 maps\_utility::set_battlechatter(0);
  var_0 kill();
}

#using_animtree("generic_human");

spawn_dead_bodies_mudpumps() {
  level.scr_animtree["body_mud1"] = #animtree;
  level.scr_anim["body_mud1"]["bodies"][0] = % blackice_mudpump_bodies_01;
  level.scr_model["body_mud1"] = "body_oil_worker_a";
  level.scr_animtree["body_mud2"] = #animtree;
  level.scr_anim["body_mud2"]["bodies"][0] = % blackice_mudpump_bodies_02;
  level.scr_model["body_mud2"] = "body_oil_worker_ab";
  level.scr_animtree["body_mud3"] = #animtree;
  level.scr_anim["body_mud3"]["bodies"][0] = % blackice_mudpump_bodies_03;
  level.scr_model["body_mud3"] = "body_oil_worker_ac";
  level.scr_animtree["body_mud4"] = #animtree;
  level.scr_anim["body_mud4"]["bodies"][0] = % blackice_mudpump_bodies_04;
  level.scr_model["body_mud4"] = "body_oil_worker_b";
  level.scr_animtree["body_mud5"] = #animtree;
  level.scr_anim["body_mud5"]["bodies"][0] = % blackice_mudpump_bodies_05;
  level.scr_model["body_mud5"] = "body_oil_worker_bb";
  level.scr_animtree["body_mud6"] = #animtree;
  level.scr_anim["body_mud6"]["bodies"][0] = % blackice_mudpump_bodies_06;
  level.scr_model["body_mud6"] = "body_oil_worker_bc";
  var_0 = common_scripts\utility::getstruct("bodies", "script_noteworthy");
  var_1 = [];

  for(var_2 = 1; var_2 <= 6; var_2++) {
    var_3 = maps\_utility::spawn_anim_model("body_mud" + var_2);
    var_1 = common_scripts\utility::array_add(var_1, var_3);

    if(common_scripts\utility::mod(var_2, 2) == 0) {
      var_3 attach("head_oil_worker_a", "");
      continue;
    }

    var_3 attach("head_oil_worker_b", "");
  }

  var_0 maps\_anim::anim_loop(var_1, "bodies");
}

spawn_dead_bodies_pipe_deck() {
  level.scr_animtree["body1"] = #animtree;
  level.scr_anim["body1"]["bodies"][0] = % blackice_pipedeck_bodies_01;
  level.scr_model["body1"] = "body_oil_worker_a";
  level.scr_animtree["body2"] = #animtree;
  level.scr_anim["body2"]["bodies"][0] = % blackice_pipedeck_bodies_02;
  level.scr_model["body2"] = "body_oil_worker_ab";
  level.scr_animtree["body3"] = #animtree;
  level.scr_anim["body3"]["bodies"][0] = % blackice_pipedeck_bodies_03;
  level.scr_model["body3"] = "body_oil_worker_ac";
  level.scr_animtree["body4"] = #animtree;
  level.scr_anim["body4"]["bodies"][0] = % blackice_pipedeck_bodies_04;
  level.scr_model["body4"] = "body_oil_worker_b";
  level.scr_animtree["body5"] = #animtree;
  level.scr_anim["body5"]["bodies"][0] = % blackice_pipedeck_bodies_05;
  level.scr_model["body5"] = "body_oil_worker_bb";
  level.scr_animtree["body6"] = #animtree;
  level.scr_anim["body6"]["bodies"][0] = % blackice_pipedeck_bodies_06;
  level.scr_model["body6"] = "body_oil_worker_bc";
  level.scr_animtree["body7"] = #animtree;
  level.scr_anim["body7"]["bodies"][0] = % blackice_pipedeck_bodies_07;
  level.scr_model["body7"] = "body_oil_worker_a";
  level.scr_animtree["body8"] = #animtree;
  level.scr_anim["body8"]["bodies"][0] = % blackice_pipedeck_bodies_08;
  level.scr_model["body8"] = "body_oil_worker_ab";
  level.scr_animtree["body9"] = #animtree;
  level.scr_anim["body9"]["bodies"][0] = % blackice_pipedeck_bodies_09;
  level.scr_model["body9"] = "body_oil_worker_ac";
  level.scr_animtree["body10"] = #animtree;
  level.scr_anim["body10"]["bodies"][0] = % blackice_pipedeck_bodies_10;
  level.scr_model["body10"] = "body_oil_worker_b";
  var_0 = common_scripts\utility::getstruct("bodies", "script_noteworthy");
  var_1 = [];

  for(var_2 = 1; var_2 <= 10; var_2++) {
    var_3 = maps\_utility::spawn_anim_model("body" + var_2);
    var_1 = common_scripts\utility::array_add(var_1, var_3);

    if(common_scripts\utility::mod(var_2, 2) == 0) {
      var_3 attach("head_oil_worker_b", "");
      continue;
    }

    var_3 attach("head_oil_worker_c", "");
  }

  var_0 maps\_anim::anim_loop(var_1, "bodies");
}

vig_pipdeck_wires() {
  var_0 = common_scripts\utility::getstruct("vig_pipdeck_wires", "script_noteworthy");
  var_1 = getent("blackice_wires_pipedeck_anim", "targetname");
  var_1 maps\_utility::assign_animtree("wires");
  var_2 = [];
  var_2["wires"] = var_1;
  var_0 maps\_anim::anim_loop(var_2, "vig_pipdeck_wires");
}

runout_group1() {
  var_0 = common_scripts\utility::getstruct("vignette_exfil_runout", "script_noteworthy");
  var_1 = maps\_utility::spawn_anim_model("debris01");
  var_2 = [];
  var_2["debris01"] = var_1;
  var_0 maps\_anim::anim_first_frame(var_2, "runout_group1");
  wait 2.0;
  var_0 maps\_anim::anim_single(var_2, "runout_group1");
}

runout_group2() {
  var_0 = common_scripts\utility::getstruct("vignette_exfil_runout", "script_noteworthy");
  var_1 = maps\_utility::spawn_anim_model("debris02");
  var_2 = [];
  var_2["debris02"] = var_1;
  var_0 maps\_anim::anim_first_frame(var_2, "runout_group2");
  wait 4.85;
  var_0 maps\_anim::anim_single(var_2, "runout_group2");
}

runout_group3() {
  var_0 = common_scripts\utility::getstruct("vignette_exfil_runout", "script_noteworthy");
  var_1 = maps\_utility::spawn_anim_model("debris03");
  var_2 = [];
  var_2["debris03"] = var_1;
  var_0 maps\_anim::anim_first_frame(var_2, "runout_group3");
  wait 7.0;
  var_0 maps\_anim::anim_single(var_2, "runout_group3");
}