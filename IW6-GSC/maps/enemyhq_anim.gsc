/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\enemyhq_anim.gsc
*****************************************************/

main() {
  generic_human_anims();
  dog_anims();
  player_anims();
  vehicle_anims();
  prop_anims();
  truck_anims();
  prop_anims();
  soccer_scene_ball();
  soccer_scene_enemies();
}

#using_animtree("generic_human");

generic_human_anims() {
  level.scr_anim["baker"]["intro_player"] = % ehq_intro_merric;
  level.scr_anim["generic"]["patrol_walk_patrol_bored_gundown_walk1"] = % patrol_bored_gundown_walk1;
  level.scr_anim["generic"]["patrol_walk_patrol_bored_gundown_walk2"] = % patrol_bored_gundown_walk2;
  level.scr_anim["generic"]["patrol_walk_patrol_bored_gundown_walk3"] = % patrol_bored_gundown_walk3;
  var_0 = [3, 1, 1];
  level.scr_anim["generic"]["patrol_walk_weights_gundown"] = common_scripts\utility::get_cumulative_weights(var_0);
  level.scr_anim["generic"]["intro_pushups1"][0] = % training_pushups_guy1;
  level.scr_anim["generic"]["intro_pushups2"][0] = % training_pushups_guy2;
  level.scr_anim["generic"]["truck_enter_dead_body1"] = % ehq_truck_enter_dead_body_1;
  level.scr_anim["generic"]["truck_enter_dead_body2"] = % ehq_truck_enter_dead_body_2;
  maps\_anim::addnotetrack_customfunction("baker", "start_dog", maps\enemyhq_rooftop_intro::anim_intro_dog, "intro_player");
  maps\_anim::addnotetrack_customfunction("baker", "detach_food", maps\enemyhq_rooftop_intro::anim_drop_bone, "intro_player");
  level.scr_anim["hesh"]["intro_player_loop"][0] = % ehq_intro_loop_hesh;
  level.scr_anim["hesh"]["intro_player"] = % ehq_intro_hesh;
  maps\_anim::addnotetrack_customfunction("hesh", "line1", maps\enemyhq_intro::hesh_intro_line, "intro_player");
  level.scr_anim["keegan"]["intro_player"] = % ehq_intro_keegan;
  maps\_anim::addnotetrack_customfunction("keegan", "start_sniper", maps\enemyhq_rooftop_intro::anim_intro_sniper, "intro_player");
  level.scr_anim["keegan"]["intro_loop_keegan"][0] = % ehq_intro_loop_keegan;
  level.scr_anim["baker"]["merrick_intro_watch_planes"] = % ehq_intro_watch_planes;
  level.scr_anim["generic"]["active_patrolwalk_gundown"][0] = % active_patrolwalk_gundown;
  level.scr_anim["generic"]["patrol_bored_patrolwalk"][0] = % patrol_bored_patrolwalk;
  level.scr_anim["generic"]["patrol_bored_2_walk"][0] = % patrol_bored_2_walk;
  level.scr_anim["bishop"]["bishop_glimpse"] = % ehq_capture_bishop;
  level.scr_anim["bish_e1"]["bishop_glimpse"] = % ehq_capture_dude1;
  level.scr_anim["bish_e2"]["bishop_glimpse"] = % ehq_capture_dude2;
  level.scr_anim["bish_e3"]["bishop_glimpse"] = % ehq_capture_dude3;
  level.scr_anim["bishop"]["bishop_glimpse_loop"][0] = % ehq_capture_bishop_loop;
  level.scr_anim["bish_e1"]["bishop_glimpse_loop"][0] = % ehq_capture_dude1_loop;
  level.scr_anim["bish_e2"]["bishop_glimpse_loop"][0] = % ehq_capture_dude2_loop;
  level.scr_anim["bish_e3"]["bishop_glimpse_loop"][0] = % ehq_capture_dude3_loop;
  level.scr_anim["keegan"]["enter_truck"] = % ehq_truck_enter_keegan;
  level.scr_anim["keegan"]["enter_truck_loop"][0] = % ehq_truck_enter_loop_keegan;
  level.scr_anim["hesh"]["enter_truck_loop"][0] = % bm21_guy1_idle;
  level.scr_anim["baker"]["enter_truck_loop"][0] = % bm21_guy2_idle;
  level.scr_anim["keegan"]["truck_turn_left"] = % ehq_truck_enter_turn_left_keegan;
  level.scr_anim["keegan"]["truck_turn_right"] = % ehq_truck_enter_turn_right_keegan;
  level.scr_anim["keegan"]["truck_turn_left_rush"] = % ehq_truck_enter_turn_left_rush_keegan;
  level.scr_anim["keegan"]["truck_turn_right_rush"] = % ehq_truck_enter_turn_right_rush_keegan;
  level.scr_anim["keegan"]["enter_truck_loop_rush"][0] = % ehq_truck_enter_loop_rush_keegan;
  level.scr_anim["generic"]["drivein_react1"] = % blackice_explosionreact2;
  level.scr_anim["generic"]["drivein_react2"] = % exposed_idle_reactb;
  level.scr_anim["generic"]["drivein_react3"] = % blackice_explosionreact2;
  level.scr_anim["generic"]["london_police_wave"][0] = % london_police_wave;
  level.scr_anim["vip_e1"]["vip_enemy"] = % prague_bully_b_watch;
  level.scr_anim["vip_e2"]["vip_enemy"] = % africa_burning_men_watcher_idle;
  level.scr_anim["vip_e3"]["vip_enemy"] = % clockwork_checkpoint_lookout_enemy;
  level.scr_anim["vip_e4"]["vip_enemy"] = % london_sandman_sas_talk_sandman;
  level.scr_anim["vip_e5"]["vip_enemy"] = % london_sandman_sas_talk_friendly;
  level.scr_anim["vip_e6"]["vip_enemy"] = % ny_manhattan_radio_sandman_talk;
  level.scr_anim["new_vip_e1"]["new_vip_enemy_intro"] = % ehq_vip_breach_guy4;
  level.scr_anim["new_vip_e1"]["new_vip_enemy"][0] = % ehq_vip_breach_loop_guy4;
  level.scr_anim["new_vip_e2"]["new_vip_enemy"][0] = % ehq_vip_breach_guy6;
  level.scr_anim["new_vip_e3"]["new_vip_enemy_intro"] = % ehq_vip_breach_guy5;
  level.scr_anim["new_vip_e3"]["new_vip_enemy"][0] = % ehq_vip_breach_loop_guy5;
  level.scr_anim["new_vip_e4"]["new_vip_enemy_intro"] = % ehq_vip_breach_guy2;
  level.scr_anim["new_vip_e4"]["new_vip_enemy"][0] = % ehq_vip_breach_loop_guy2;
  level.scr_anim["new_vip_e5"]["new_vip_enemy"][0] = % ehq_vip_breach_guy3;
  level.scr_anim["new_vip_e6"]["new_vip_enemy_intro"] = % ehq_vip_breach_guy1;
  level.scr_anim["new_vip_e6"]["new_vip_enemy"][0] = % ehq_vip_breach_loop_guy1;
  level.scr_anim["vip_e1"]["vip_breach_react"] = % london_surprise_turnaround_left;
  level.scr_anim["vip_e2"]["vip_breach_react"] = % london_surprise_turnaround_right;
  level.scr_anim["vip_e3"]["vip_breach_react"] = % london_surprise_turnaround_left;
  level.scr_anim["vip_e4"]["vip_breach_react"] = % breach_react_blowback_v1;
  level.scr_anim["vip_e5"]["vip_breach_react"] = % blackice_explosionreact2;
  level.scr_anim["vip_e6"]["vip_breach_react"] = % london_surprise_turnaround_right;
  level.scr_anim["new_vip_e1"]["vip_breach_react"] = % london_surprise_turnaround_left;
  level.scr_anim["new_vip_e2"]["vip_breach_react"] = % london_surprise_turnaround_left;
  level.scr_anim["new_vip_e3"]["vip_breach_react"] = % london_surprise_turnaround_right;
  level.scr_anim["new_vip_e4"]["vip_breach_react"] = % breach_react_blowback_v1;
  level.scr_anim["new_vip_e5"]["vip_breach_react"] = % blackice_explosionreact2;
  level.scr_anim["new_vip_e6"]["vip_breach_react"] = % london_surprise_turnaround_right;
  level.breach_react_starttime["new_vip_e1"]["vip_breach_react"] = 1.3;
  level.breach_react_starttime["new_vip_e2"]["vip_breach_react"] = 1.3;
  level.breach_react_starttime["new_vip_e3"]["vip_breach_react"] = 0.88;
  level.breach_react_starttime["new_vip_e4"]["vip_breach_react"] = 0;
  level.breach_react_starttime["new_vip_e5"]["vip_breach_react"] = 0;
  level.breach_react_starttime["new_vip_e6"]["vip_breach_react"] = 0.88;
  level.scr_anim["ally1"]["vip_breach"] = % intro_courtyard_breach_guy1;
  level.scr_anim["ally2"]["vip_breach"] = % intro_courtyard_breach_guy5;
  level.scr_anim["ally3"]["vip_breach"] = % intro_courtyard_breach_guy3;
  level.scr_anim["generic"]["search_walk"][0] = % active_patrolwalk_v5;
  level.scr_anim["goodguy"]["vip_interrogate"] = % ehq_vip_int_keegan;
  level.scr_anim["badguy"]["vip_interrogate"] = % ehq_vip_int_guard;
  level.scr_anim["hesh"]["vip_interrogate"] = % ehq_vip_int_hesh;
  maps\_anim::addnotetrack_customfunction("goodguy", "show_knife", maps\enemyhq_vip::show_knife, "vip_interrogate");
  maps\_anim::addnotetrack_customfunction("goodguy", "hide_knife", maps\enemyhq_vip::hide_knife, "vip_interrogate");
  maps\_anim::addnotetrack_customfunction("goodguy", "line_1", maps\enemyhq_vip::keegan_vip_line1, "vip_interrogate");
  maps\_anim::addnotetrack_customfunction("goodguy", "line_2", maps\enemyhq_vip::keegan_vip_line2, "vip_interrogate");
  maps\_anim::addnotetrack_customfunction("badguy", "wall_slam", ::vip_wall_slam, "vip_interrogate");
  maps\_anim::addnotetrack_customfunction("badguy", "knife_kill", maps\enemyhq_vip::kill_dude, "vip_interrogate");
  maps\_anim::addnotetrack_customfunction("badguy", "line_1", maps\enemyhq_vip::badguyline1, "vip_interrogate");
  maps\_anim::addnotetrack_customfunction("badguy", "line_2", maps\enemyhq_vip::badguyline2, "vip_interrogate");
  maps\_anim::addnotetrack_customfunction("badguy", "line_3", maps\enemyhq_vip::badguyline3, "vip_interrogate");
  maps\_anim::addnotetrack_customfunction("goodguy", "play_merrick_vo_line", ::merrick_vip_vo, "vip_interrogate");
  level.scr_anim["generic"]["combat_jog"][0] = % combat_jog;
  level.scr_anim["generic"]["dog_flee"] = % run_react_stumble_non_loop;
  level.scr_anim["generic"]["basement_dog_ambush"] = % iw6_dog_kill_back_medium_guy_1;
  level.scr_anim["generic"]["teargas_initiate"] = % ehq_teargas_garage_throw_keegan;
  level.scr_anim["generic"]["teargas_dooropen"] = % ehq_teargas_garage_open_keegan;
  level.scr_anim["generic"]["open_battingcage"] = % vegas_keegan_door_check;
  level.scr_anim["generic"]["gas_battingcage"] = % corner_standl_grenade_b;
  level.scr_anim["generic"]["enter_battingcage"] = % corner_standl_trans_out_8;
  level.scr_anim["generic"]["teargas_react_in_place_1"] = % teargas_react_in_place_1;
  level.scr_anim["generic"]["prague_teargas_run_1_twitch"] = % prague_teargas_run_1_twitch;
  level.scr_anim["generic"]["prague_teargas_run_2_twitch"] = % prague_teargas_run_2_twitch;
  level.scr_anim["generic"]["teargas_window_3"] = % teargas_window_3;
  level.scr_anim["generic"]["teargas_window_2"] = % teargas_window_2;
  level.scr_anim["generic"]["civilian_crawl_2"] = % civilian_crawl_2;
  level.scr_anim["keegan"]["light_glowstick"] = % clockwork_surveillance_room_baker;
  level.scr_anim["keegan"]["ct_start"] = % ehq_club_traverse_hall_start_keegan;
  level.scr_anim["keegan"]["ct_enter_loop1"] = % ehq_club_traverse_hall_enter_keegan;
  level.scr_anim["keegan"]["ct_loop1"][0] = % ehq_club_traverse_hall_loop_keegan;
  level.scr_anim["keegan"]["ct_exit_loop1"] = % ehq_club_traverse_hall_exit_keegan;
  level.scr_anim["keegan"]["ct_nowait1"] = % ehq_club_traverse_hall_nowait_keegan;
  level.scr_anim["keegan"]["ct_walk1"] = % ehq_club_traverse_hall_walk_keegan;
  level.scr_anim["keegan"]["flare_kill_loop"][0] = % ehq_club_traverse_flare_loop_keegan;
  level.scr_anim["keegan"]["flare_kill"] = % ehq_club_traverse_flare_keegan;
  level.scr_anim["keegan"]["ct_loop2"][0] = % ehq_club_traverse_tunnel_loop_keegan;
  level.scr_anim["keegan"]["ct_walk2"] = % ehq_club_traverse_tunnel_walk_keegan;
  level.scr_anim["keegan"]["ch_idle"][0] = % ehq_club_traverse_breach_idle_keegan;
  maps\_anim::addnotetrack_flag("keegan", "detach_flare", "drop_flare", "ct_walk2");
  maps\_anim::addnotetrack_customfunction("keegan", "show_knife", ::show_knife, "flare_kill");
  maps\_anim::addnotetrack_customfunction("keegan", "hide_knife", ::hide_knife, "flare_kill");
  maps\_anim::addnotetrack_notify("keegan", "blend_out", "blend_out", "flare_kill");
  maps\_anim::addnotetrack_customfunction("keegan", "show_pistol", ::show_gun, "ct_start");
  maps\_anim::addnotetrack_customfunction("keegan", "flare_speed_off", ::normal_speed, "flare_kill");
  maps\_anim::addnotetrack_customfunction("keegan", "speed_off", ::drop_flare, "ct_walk2");
  level.scr_anim["generic"]["flare_kill"] = % ehq_club_traverse_flare_enemy1;
  maps\_anim::addnotetrack_customfunction("generic", "die_now", maps\enemyhq_code::get_killed, "flare_kill");
  level.scr_anim["keegan"]["ch_breach"] = % ehq_clubhouse_breach_keegan;
  maps\_anim::addnotetrack_customfunction("keegan", "attach_r_pistol", ::gun_r_on, "ch_breach");
  maps\_anim::addnotetrack_customfunction("keegan", "attach_l_pistol", ::gun_l_on, "ch_breach");
  maps\_anim::addnotetrack_customfunction("keegan", "detach_r_pistol", ::gun_r_off, "ch_breach");
  maps\_anim::addnotetrack_customfunction("keegan", "detach_l_pistol", ::gun_l_off, "ch_breach");
  maps\_anim::addnotetrack_customfunction("keegan", "L_fire", ::keegan_fire_l, "ch_breach");
  maps\_anim::addnotetrack_customfunction("keegan", "R_fire", ::keegan_fire_r, "ch_breach");
  level.scr_anim["generic"]["london_civ_idle_lookbehind"] = % london_civ_idle_lookbehind;
  level.scr_anim["generic"]["corner_standL_trans_IN_1"] = % corner_standl_trans_in_1;
  level.scr_anim["ally1"]["ch_breach"] = % intro_courtyard_breach_guy1;
  level.scr_anim["ally3"]["ch_breach"] = % intro_courtyard_breach_guy3;
  level.scr_anim["ally2"]["ch_breach"] = % intro_courtyard_breach_guy1;
  level.scr_anim["generic"]["teargas_react_1"] = % teargas_react_1;
  level.scr_anim["generic"]["teargas_react_2"] = % teargas_react_2;
  level.scr_anim["generic"]["teargas_react_3"] = % teargas_react_3;
  level.scr_anim["generic"]["teargas_react_4"] = % teargas_react_4;
  level.scr_anim["generic"]["clockwork_shoulder_charge_keegan"] = % clockwork_shoulder_charge_keegan;
  level.scr_anim["generic"]["teargas_run_8"] = % teargas_run_8;
  level.scr_anim["generic"]["teargas_run_2"] = % teargas_run_2;
  level.scr_anim["generic"]["teargas_run_7"] = % teargas_run_7;
  level.scr_anim["generic"]["dog_breach"] = % kingfish_breach_ambush_soldier_start;
  maps\_anim::addnotetrack_customfunction("generic", "die", maps\enemyhq_code::get_killed, "dog_breach");
  level.scr_anim["bishop"]["find_bishop"] = % ehq_find_ajax_ajax;
  level.scr_anim["keegan"]["find_bishop"] = % ehq_find_ajax_keegan;
  level.scr_anim["merrick"]["find_bishop"] = % ehq_find_ajax_merrick;
  level.scr_anim["hesh"]["find_bishop"] = % ehq_find_ajax_hesh;
  maps\_anim::addnotetrack_customfunction("keegan", "start_dog_exit_animation", ::dog_leave, "find_bishop");
  maps\_anim::addnotetrack_customfunction("keegan", "hide_gasmask", ::hide_gasmask, "find_bishop");
  maps\_anim::addnotetrack_customfunction("merrick", "hide_gasmask", ::hide_gasmask, "find_bishop");
  maps\_anim::addnotetrack_customfunction("hesh", "hide_gasmask", ::hide_gasmask, "find_bishop");
  maps\_anim::addnotetrack_customfunction("keegan", "start_dog_exit_animation", maps\enemyhq_basement::time_to_go, "find_bishop");
  maps\_anim::addnotetrack_customfunction("keegan", "unhide_flashlight", ::keegan_unhide_flashlight, "find_bishop");
  maps\_anim::addnotetrack_customfunction("keegan", "turn_flashlight_on", ::keegan_light_flashlight, "find_bishop");
  maps\_anim::addnotetrack_customfunction("hesh", "unhide_flare_mesh", ::hesh_unhide_flare, "find_bishop");
  maps\_anim::addnotetrack_customfunction("hesh", "pop_flare", ::hesh_light_flare, "find_bishop");
  level.scr_anim["bishop"]["hvt_loop"][0] = % wounded_carry_closet_idle_wounded;
  level.scr_anim["merrick"]["hvt_pickup"] = % wounded_carry_pickup_closet_carrier_straight;
  level.scr_anim["bishop"]["hvt_pickup"] = % wounded_carry_pickup_closet_wounded_straight;
  level.scr_anim["generic"]["wounded_carry_carrier"] = % wounded_carry_fastwalk_carrier;
  level.scr_anim["generic"]["wounded_carry_wounded"][0] = % wounded_carry_fastwalk_wounded_relative;
  level.scr_anim["keegan"]["wounded_carry_idle"][0] = % intro_fireman_carry_idle_carrier;
  level.scr_anim["bishop"]["wounded_carry_idle"][0] = % intro_fireman_carry_idle_carried;
  level.scr_anim["bishop"]["wounded_carry_putdown"] = % intro_fireman_carry_drop_guy_carried;
  level.scr_anim["bishop"]["wounded_carry_putdown_idle"][0] = % intro_fireman_carry_lie_idle_carried;
  level.scr_anim["keegan"]["wounded_carry_putdown"] = % intro_fireman_carry_drop_guy_carrier;
  level.scr_anim["bishop"]["hvt_fight"] = % kingfish_price_kills_price;
  level.scr_anim["generic"]["hvt_fight"] = % kingfish_price_kills_enemy;
  level.scr_anim["keegan"]["bust_thru_prep"] = % ehq_wall_crash_prep_driver;
  level.scr_anim["keegan"]["bust_thru"] = % ehq_wall_crash_driver;
  level.scr_anim["enemy1"]["bust_thru"] = % ehq_wall_crash_enemy1;
  level.scr_anim["merrick"]["bust_thru"] = % ehq_wall_crash_rearpass;
  maps\_anim::addnotetrack_flag("enemy1", "dog_kill", "FLAG_kill_dog_kill_guy", "bust_thru");
  maps\_anim::addnotetrack_flag("merrick", "Detach_MK", "FLAG_mk32_detach", "bust_thru");
  maps\_anim::addnotetrack_flag("merrick", "Detonate", "FLAG_mk32_atrium_detonate", "bust_thru");
  maps\_anim::addnotetrack_flag("merrick", "shot1", "FLAG_mk32_shot2", "bust_thru");
  maps\_anim::addnotetrack_flag("merrick", "shot2", "FLAG_mk32_shot3", "bust_thru");
  maps\_anim::addnotetrack_flag("merrick", "shot3", "FLAG_mk32_shot4", "bust_thru");
  level.scr_anim["generic"]["dog_last_stand_kill"][1] = % ai_attacked_german_shepherd_last_stand;
  level.scr_anim["generic"]["dog_attack_fast"][1] = % ai_attacked_german_shepherd_attack_fast;
  level.scr_anim["generic"]["32Kill"] = % ai_attacked_german_shepherd_jump_32_kill;
  level.scr_anim["generic"]["dog_jump_over_40"][1] = % ai_attacked_german_shepherd_jump_32_kill;
  level.scr_anim["generic"]["pilot_fire"][0] = % ehq_nh90_pilot_pistol_fire;
  level.scr_anim["generic"]["dog_hijack"] = % ehq_dog_killpilot_pilot;
  level.scr_anim["generic"]["new_dog_hijack"] = % ehq_heli_hijack_pilot;
  level.scr_anim["hesh"]["new_dog_hijack"] = % ehq_heli_hijack_hesh;
  level.scr_anim["hesh"]["aas_72x_pilot_idle"][0] = % aas_72x_pilot_idle;
  maps\_anim::addnotetrack_customfunction("generic", "die", maps\enemyhq_code::get_killed, "new_dog_hijack");
  level.scr_anim["hesh"]["get_in_chopper"] = % ehq_helicopter_enter_hesh;
  level.scr_anim["generic"]["ride_chopper"][0] = % bh_4_idle;
  level.scr_anim["keegan"]["truck_smash"] = % ehq_truck_drivein_hit_driver;
  level.scr_anim["keegan"]["truck_mask"] = % ehq_truck_enter_mask_keegan;
}

#using_animtree("dog");

dog_anims() {
  level.scr_anim["dog"]["intro_player"] = % ehq_intro_dog;
  level.scr_anim["dog"]["intro_loop_dog"][0] = % ehq_intro_loop_dog;
  level.scr_anim["dog"]["dog_bark_truck"] = % ehq_truck_ride_idle_to_alert_dog;
  level.scr_anim["generic"]["dog_sniff_walk_fast"] = % german_shepherd_sniff_loop;
  level.scr_anim["dog"]["growl"][0] = % iw6_dog_attackidle_bark;
  level.scr_anim["dog"]["growl"][1] = % iw6_dog_attackidle;
  level.scr_anim["dog"]["german_shepherd_run_jump_window_40"] = % iw6_dog_traverse_over_36;
  level.scr_anim["dog"]["walk"] = % iw6_dog_walk;
  level.scr_anim["dog"]["german_shepherd_rotate_ccw"] = % iw6_dog_attackidle_turn_4;
  level.scr_anim["dog"]["german_shepherd_rotate_cw"] = % iw6_dog_attackidle_turn_6;
  level.scr_anim["dog"]["sniff"] = % iw6_dog_sniff_walk;
  level.scr_anim["dog"]["dog_breach"] = % kingfish_breach_ambush_dog_start;
  level.scr_anim["dog"]["bust_thru_prep"] = % ehq_wall_crash_prep_dog;
  level.scr_anim["dog"]["bust_thru"] = % ehq_wall_crash_dog;
  level.scr_anim["dog"]["veh_idle"][0] = % ehq_truck_ride_idle_dog;
  level.scr_anim["dog"]["enter_truck"] = % ehq_truck_enter_dog;
  level.scr_anim["dog"]["veh_idle_frantic"][0] = % ehq_truck_ride_idle_alert_dog;
  level.scr_anim["generic"]["dog_jump_over_40"][0] = % german_shepherd_jump_32_kill;
  level.scr_anim["generic"]["dog_last_stand_kill"][0] = % german_shepherd_attack_last_stand;
  level.scr_anim["generic"]["dog_attack_fast"][0] = % german_shepherd_attack_fast;
  level.scr_anim["dog"]["32Kill"] = % german_shepherd_jump_32_kill;
  level.scr_anim["generic"]["dog_walk"] = % german_shepherd_walk_slow;
  level.scr_anim["dog"]["vip_interrogate"] = % ehq_vip_int_dog;
  level.scr_anim["dog"]["found_door"] = % german_shepherd_scratch_door;
  level.scr_anim["dog"]["basement_dog_ambush"] = % iw6_dog_kill_back_medium_1;
  level.scr_anim["dog"]["find_bishop"] = % ehq_find_ajax_riley_enter;
  level.scr_anim["dog"]["find_bishop_dog_loop"][0] = % ehq_find_ajax_riley_loop;
  level.scr_anim["dog"]["find_bishop_exit"] = % ehq_find_ajax_riley_exit;
  level.scr_anim["dog"]["dog_hijack"] = % ehq_dog_killpilot_dog;
  level.scr_anim["dog"]["new_dog_hijack"] = % ehq_heli_hijack_dog;
  level.scr_anim["dog"]["get_in_chopper"] = % ehq_helicopter_enter_dog;
  level.scr_anim["dog"]["get_in_chopper_idle"][0] = % ehq_helicopter_idle_dog;
  level.scr_anim["dog"]["truck_smash"] = % ehq_truck_drivein_hit_dog;
}

#using_animtree("player");

player_anims() {
  level.scr_anim["player_rig"]["intro_player"] = % ehq_intro_player;
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewhands_player_us_rangers";
  level.scr_anim["player_rig"]["bust_thru_prep"] = % ehq_wall_crash_prep_player;
  level.scr_anim["player_rig"]["bust_thru"] = % ehq_wall_crash_player;
  level.scr_anim["player_rig"]["bust_thru_exit"] = % ehq_wall_crash_exit_player;
  level.scr_anim["player_rig"]["player_smash_windshield"] = % ehq_windshield_smash_player;
  level.scr_anim["player_rig"]["player_enter_truck"] = % ehq_truck_enter_player;
  level.scr_anim["player_rig"]["get_in_chopper"] = % ehq_helicopter_enter_player;
  level.scr_anim["player_rig"]["truck_smash"] = % ehq_truck_drivein_hit_player;
  level.scr_anim["player_rig"]["truck_lean_left"] = % ehq_truck_slide_left_player;
  level.scr_anim["player_rig"]["truck_lean_right"] = % ehq_truck_slide_right_player;
  maps\_anim::addnotetrack_flag("player_rig", "keegan_start", "FLAG_keegan_start_mask_anim", "player_enter_truck");
  maps\_anim::addnotetrack_flag("player_rig", "start_rearpass", "FLAG_atrium_ally_mk32_anim", "bust_thru");
  level.scr_anim["player_rig"]["ch_breach"] = % ehq_clubhouse_breach_player;
  maps\_anim::addnotetrack_customfunction("player_rig", "gun_up", maps\enemyhq_basement::breach_gun_up, "ch_breach");
  level.scr_animtree["player_legs"] = #animtree;
  level.scr_model["player_legs"] = "viewlegs_generic";
  level.scr_anim["player_legs"]["ch_breach"] = % ehq_clubhouse_breach_player_legs;
}

#using_animtree("vehicles");

vehicle_anims() {
  level.scr_animtree["heli"] = #animtree;
  level.scr_anim["heli"]["new_dog_hijack"] = % ehq_heli_hijack_helicopter;
}

truck_anims() {
  level.scr_anim["truck"]["bust_thru"] = % ehq_wall_crash_truck;
  level.scr_anim["truck"]["bust_thru_exit"] = % ehq_wall_crash_exit_truck;
  level.scr_anim["truck"]["player_smash_windshield"] = % ehq_windshield_smash_truck;
  level.scr_anim["truck"]["player_enter_truck"] = % ehq_truck_enter_truck;
  level.scr_anim["truck"]["truck_loop"][0] = % ehq_truck_enter_loop_truck;
  level.scr_anim["truck"]["truck_loop_rush"][0] = % ehq_truck_enter_loop_rush_truck;
  level.scr_anim["truck"]["truck_left"] = % ehq_truck_enter_turn_left_truck;
  level.scr_anim["truck"]["truck_right"] = % ehq_truck_enter_turn_right_truck;
  level.scr_anim["truck"]["truck_left_rush"] = % ehq_truck_enter_turn_left_rush_truck;
  level.scr_anim["truck"]["truck_right_rush"] = % ehq_truck_enter_turn_right_rush_truck;
}

#using_animtree("animated_props");

prop_anims() {
  level.scr_animtree["intro_jeep_ram"] = #animtree;
  level.scr_anim["intro_jeep_ram"]["jeep_ram"] = % ehq_truck_ram_jeep;
  level.scr_animtree["intro_jeep_ram_exp_long"] = #animtree;
  level.scr_anim["intro_jeep_ram"]["jeep_ram_long"] = % ehq_truck_gate_explosion_long;
  level.scr_animtree["intro_jeep_ram_exp_short"] = #animtree;
  level.scr_anim["intro_jeep_ram"]["jeep_ram_short"] = % ehq_truck_gate_explosion_short;
  level.scr_animtree["viney"] = #animtree;
  level.scr_model["viney"] = "generic_prop_raven";
  level.scr_anim["viney"]["intro_player"] = % ehq_intro_vines;
  level.scr_animtree["mr_chair"] = #animtree;
  level.scr_model["mr_chair"] = "generic_prop_raven";
  level.scr_anim["mr_chair"]["bishop_glimpse"] = % ehq_capture_chair;
  level.scr_animtree["drive_jeep_flip"] = #animtree;
  level.scr_anim["drive_jeep_flip"]["jeep_flip"] = % ehq_truck_drivein_lynx_flip;
  level.scr_animtree["flip_light_prop"] = #animtree;
  level.scr_model["flip_light_prop"] = "generic_prop_raven";
  level.scr_anim["flip_light_prop"]["jeep_flip"] = % ehq_truck_drivein_light_hit;
  level.scr_animtree["flip_light"] = #animtree;
  level.scr_model["flip_light"] = "pbk_flood_light_generator";
  level.scr_animtree["teargas_grenade_prop"] = #animtree;
  level.scr_model["teargas_grenade_prop"] = "generic_prop_raven";
  level.scr_anim["teargas_grenade_prop"]["teargas_initiate"] = % ehq_teargas_garage_throw_grenade;
  level.scr_animtree["teargas_door_prop"] = #animtree;
  level.scr_model["teargas_door_prop"] = "generic_prop_raven";
  level.scr_anim["teargas_door_prop"]["teargas_dooropen"] = % ehq_teargas_garage_open_door;
  level.scr_animtree["clubhouse_doors"] = #animtree;
  level.scr_model["clubhouse_doors"] = "generic_prop_raven";
  level.scr_anim["clubhouse_doors"]["ch_breach"] = % ehq_clubhouse_breach_doors;
  level.scr_animtree["clubhouse_grenade"] = #animtree;
  level.scr_model["clubhouse_grenade"] = "weapon_us_smoke_grenade_burnt2";
  level.scr_anim["clubhouse_grenade"]["ch_breach"] = % ehq_clubhouse_breach_gas;
  level.scr_animtree["ch_breach_gun_r"] = #animtree;
  level.scr_model["ch_breach_gun_r"] = "viewmodel_mp443";
  level.scr_anim["ch_breach_gun_r"]["ch_breach"] = % ehq_clubhouse_breach_r_pistol;
  level.scr_animtree["ch_breach_gun_l"] = #animtree;
  level.scr_model["ch_breach_gun_l"] = "viewmodel_mp443";
  level.scr_anim["ch_breach_gun_l"]["ch_breach"] = % ehq_clubhouse_breach_l_pistol;
  level.scr_animtree["hamburg_security_gate_crash"] = #animtree;
  level.scr_anim["hamburg_security_gate_crash"]["security_gate_crash"] = % ehq_wall_crash_break_gate;
  level.scr_animtree["bish_ch"] = #animtree;
  level.scr_model["bish_ch"] = "generic_prop_raven";
  level.scr_anim["bish_ch"]["bishop_glimpse"] = % ehq_capture_chair;
  level.scr_animtree["mk32"] = #animtree;
  level.scr_model["mk32"] = "generic_prop_raven";
  level.scr_anim["mk32"]["intro_player"] = % ehq_intro_player_gun;
  level.scr_animtree["remote_sniper"] = #animtree;
  level.scr_model["remote_sniper"] = "generic_prop_raven";
  level.scr_anim["remote_sniper"]["intro_player"] = % ehq_intro_remotesniper;
  level.scr_animtree["glowstick_prop"] = #animtree;
  level.scr_model["glowstick_prop"] = "generic_prop_raven";
  level.scr_anim["glowstick_prop"]["light_glowstick"] = % clockwork_surveillance_room_glowstick;
  maps\_anim::addnotetrack_customfunction("glowstick_prop", "glowstick_break", ::glowstick_on, "light_glowstick");
  level.scr_animtree["glowstick"] = #animtree;
  level.scr_model["glowstick"] = "weapon_light_stick_tactical_green";
  level.scr_animtree["bishop_chair_prop"] = #animtree;
  level.scr_model["bishop_chair_prop"] = "generic_prop_raven";
  level.scr_anim["bishop_chair_prop"]["find_bishop"] = % ehq_find_ajax_chairs;
  level.scr_animtree["bishop_flashlight_prop"] = #animtree;
  level.scr_model["bishop_flashlight_prop"] = "generic_prop_raven";
  level.scr_anim["bishop_flashlight_prop"]["find_bishop"] = % ehq_find_ajax_lights;
  level.scr_animtree["flashlight"] = #animtree;
  level.scr_model["flashlight"] = "com_flashlight_on";
  level.scr_animtree["ajax_flare"] = #animtree;
  level.scr_model["ajax_flare"] = "mil_emergency_flare";
  level.scr_animtree["bishop_mask_prop"] = #animtree;
  level.scr_model["bishop_mask_prop"] = "generic_prop_raven";
  level.scr_anim["bishop_mask_prop"]["find_bishop"] = % ehq_find_ajax_mask;
  maps\_anim::addnotetrack_customfunction("bishop_mask_prop", "hide_mask", ::hide_mask, "find_bishop");
  level.scr_animtree["bishop_mask"] = #animtree;
  level.scr_model["bishop_mask"] = "props_ajax_folded_mask";
  level.scr_anim["bishop_mask"]["find_bishop"] = % ehq_find_ajax_mask;
  maps\_anim::addnotetrack_customfunction("bishop_mask", "hide_mask", ::hide_mask, "find_bishop");
  level.scr_animtree["keegan_ghost_mask"] = #animtree;
  level.scr_model["keegan_ghost_mask"] = "hesh_stealth_head_mask";
  level.scr_anim["keegan_ghost_mask"]["truck_mask"] = % ehq_truck_enter_mask;
}

hide_mask(var_0) {
  level.bishop_mask hide();
}

keegan_fire_l(var_0) {
  level.allies[1] thread maps\enemyhq_audio::aud_keegan_gunfire();
  maps\enemyhq_basement::keegan_shoots_a_guy(level.keegan_gun_l);
}

keegan_fire_r(var_0) {
  level.allies[1] thread maps\enemyhq_audio::aud_keegan_gunfire();
  maps\enemyhq_basement::keegan_shoots_a_guy(level.keegan_gun_r);
}

gun_r_on(var_0) {
  level.keegan_gun_r show();
  level.keegan_gun_r linkto(var_0, "tag_weapon_chest", (0, 0, 0), (0, 0, 0));
}

gun_l_on(var_0) {
  level.keegan_gun_l show();
  level.keegan_gun_l linkto(var_0, "tag_weapon_left", (0, 0, 0), (0, 0, 0));
}

gun_r_off(var_0) {
  level.keegan_gun_r unlink();
}

gun_l_off(var_0) {
  level.keegan_gun_l unlink();
}

glowstick_on(var_0) {
  playFXOnTag(level._effect["glowstick"], var_0, "J_prop_1");
  common_scripts\utility::flag_wait("start_hvt_fight");
  glowstick_off(var_0);
}

glowstick_off(var_0) {
  stopFXOnTag(level._effect["glowstick"], var_0, "J_prop_1");
}

merrick_vip_vo(var_0) {
  level.dog maps\_utility_dogs::disable_dog_sniff();
  level.allies[0] thread maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_letsgo");
}

vip_wall_slam(var_0) {
  common_scripts\utility::exploder(444);
}

hesh_unhide_flare(var_0) {
  level.ajax_flare show();
}

hesh_light_flare(var_0) {
  playFXOnTag(level._effect["vfx_handflare_ehq_lit"], level.ajax_flare, "TAG_FIRE_FX");
}

keegan_unhide_flashlight(var_0) {
  level.flashlight show();
}

keegan_light_flashlight(var_0) {
  playFXOnTag(level._effect["flashlight"], level.flashlight, "tag_light");
}

start_hesh(var_0) {
  common_scripts\utility::flag_set("start_hesh_rescue");
}

start_merrick(var_0) {
  common_scripts\utility::flag_set("start_merrick_rescue");
}

hide_gasmask(var_0) {
  if(isDefined(var_0.gasmask)) {
    var_0.gasmask hide();
    var_0.gasmask delete();
    var_0.gasmask = undefined;
  }
}

show_knife(var_0) {
  level.flare_knife linkto(var_0, "tag_stowed_back", (0, 0, 0), (0, 0, 0));
  level.flare_knife show();
  var_1 = common_scripts\utility::getstruct("fake_light_pos", "targetname");
  playFX(level._effect["vfx_light_fade"], var_1.origin);
}

hide_knife(var_0) {
  level.flare_knife hide();
  level.flare_knife delete();
}

show_gun(var_0) {
  level.flare_gun linkto(var_0, "tag_weapon_chest", (0, 0, 0), (0, 0, 0));
  level.flare_gun show();
}

hide_gun(var_0) {
  level.flare_gun hide();
  level.flare_gun delete();
}

dog_leave(var_0) {
  common_scripts\utility::flag_set("dog_leave_rescue");
}

#using_animtree("generic_human");

soccer_scene_enemies() {
  level.scr_anim["soccer_pass_guy1"]["soccer_scene_pass"][0] = % ehq_intro_field_soccer_pass_enemy1;
  level.scr_anim["soccer_pass_guy2"]["soccer_scene_pass"][0] = % ehq_intro_field_soccer_pass_enemy2;
  level.scr_anim["soccer_goal_guy1"]["soccer_scene_goal"][0] = % ehq_intro_field_soccer_goal_enemy1;
  level.scr_anim["soccer_goal_guy2"]["soccer_scene_goal"][0] = % ehq_intro_field_soccer_goal_enemy2;
}

#using_animtree("animated_props");

soccer_scene_ball() {
  level.scr_animtree["soccerball_pass"] = #animtree;
  level.scr_model["soccerball_pass"] = "soccer_ball";
  level.scr_anim["soccerball_pass"]["soccer_scene_pass"][0] = % ehq_intro_field_soccer_pass_ball;
  level.scr_animtree["soccerball_goal"] = #animtree;
  level.scr_model["soccerball_goal"] = "soccer_ball";
  level.scr_anim["soccerball_goal"]["soccer_scene_goal"][0] = % ehq_intro_field_soccer_goal_ball;
}

normal_speed(var_0) {
  maps\_anim::anim_set_rate(level.flare_guys, "flare_kill", 1.3);
}

drop_flare(var_0) {
  maps\_anim::anim_set_rate_single(var_0, "ct_walk2", 1.0);
  var_1 = getent("clubhouse_breach_light", "targetname");
  var_1.unlit_models = [];
  var_1.lit_models = [];
  var_1.script_threshold = 0;
  var_1 maps\_lights::lerp_intensity(1, 0.5);
}