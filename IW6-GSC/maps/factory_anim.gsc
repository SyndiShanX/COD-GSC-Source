/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\factory_anim.gsc
*****************************************************/

main() {
  generic_human();
  script_model();
  player();
  dialog();
  vehicles();
  level thread vignettes();
}

vignettes() {
  level thread maps\_vignette_util::vignette_register(::ambush, "ambush_triggered");
}

#using_animtree("generic_human");

generic_human() {
  level.scr_anim["ally_alpha"]["factory_intro_jungle_drop_ally01"] = % factory_intro_jungle_drop_ally01;
  level.scr_anim["ally_alpha"]["factory_intro_jungle_drop_ally01_loop01"][0] = % factory_intro_jungle_drop_ally01_loop01;
  level.scr_anim["ally_alpha"]["factory_intro_jungle_drop_kill_ally01"] = % factory_intro_jungle_drop_kill_ally01;
  level.scr_anim["ally_alpha"]["factory_intro_jungle_drop_kill_short_ally01"] = % factory_intro_jungle_drop_kill_short_ally01;
  maps\_anim::addnotetrack_notify("ally_alpha", "del_knife", "del_knife");
  level.scr_anim["introkill_enemy1"]["factory_intro_jungle_drop_opfor01"] = % factory_intro_jungle_drop_opfor01;
  level.scr_anim["introkill_enemy1"]["factory_intro_jungle_drop_kill_opfor01"] = % factory_intro_jungle_drop_kill_opfor01;
  level.scr_anim["introkill_enemy1"]["factory_intro_jungle_drop_kill_short_opfor01"] = % factory_intro_jungle_drop_kill_short_opfor01;
  level.scr_anim["introkill_enemy1"]["factory_intro_jungle_drop_opfor01_loop"][0] = % factory_intro_jungle_drop_opfor01_loop;
  maps\_anim::addnotetrack_customfunction("introkill_enemy1", "fx_intro_kill_ally_stab", maps\factory_fx::fx_intro_kill_ally_stab);
  level.scr_anim["introkill_enemy2"]["factory_intro_jungle_drop_opfor02"] = % factory_intro_jungle_drop_opfor02;
  level.scr_anim["introkill_enemy2"]["factory_intro_jungle_drop_opfor02_loop"][0] = % factory_intro_jungle_drop_opfor02_loop;
  level.scr_anim["introkill_enemy2"]["factory_intro_jungle_drop_kill_player"] = % factory_intro_jungle_drop_kill_opfor02;
  maps\_anim::addnotetrack_customfunction("introkill_enemy2", "fx_intro_kill_player_stab", maps\factory_fx::fx_intro_kill_player_stab);
  level.scr_anim["generic"]["crouch_fastwalk_F"] = % crouch_fastwalk_f;
  level.scr_anim["ally_alpha"]["crouch_fastwalk_F"] = % crouch_fastwalk_f;
  level.scr_anim["player_body"]["factory_intro_jungle_player"] = % factory_intro_jungle_body_player;
  level.scr_anim["ally_alpha"]["factory_intro_jungle_slide_baker_exit"] = % factory_intro_jungle_slide_baker_exit;
  level.scr_anim["ally_charlie"]["factory_intro_jungle_wallhop"] = % factory_intro_jungle_wallhop_ally01;
  level.scr_anim["ally_echo"]["factory_intro_jungle_wallhop"] = % factory_intro_jungle_wallhop_ally02;
  level.scr_anim["ally_bravo"]["factory_intro_jungle_wallhop"] = % factory_intro_jungle_wallhop_ally03;
  level.scr_anim["ally_bravo"]["factory_intro"] = % factory_intro_ally01;
  level.scr_anim["ally_alpha"]["factory_intro"] = % factory_intro_ally02;
  level.scr_anim["trainyard_enemy"]["factory_intro"] = % factory_intro_guard;
  level.scr_anim["trainyard_enemy"]["flashlight_searching"][0] = % so_hijack_search_flashlight_high_loop;
  level.scr_anim["trainyard_enemy"]["factory_opfor_trainyard_patrol_enter"] = % factory_opfor_trainyard_patrol_enter;
  level.scr_anim["trainyard_enemy"]["factory_opfor_trainyard_patrol_loop"][0] = % factory_opfor_trainyard_patrol_loop;
  level.scr_anim["trainyard_enemy"]["factory_opfor_trainyard_patrol_reaction"] = % factory_opfor_trainyard_patrol_reaction;
  level.scr_anim["trainyard_enemy"]["factory_opfor_trainyard_melee_death"] = % factory_opfor_trainyard_melee_death_opfor;
  maps\_anim::addnotetrack_customfunction("trainyard_enemy", "notetrack_kill", maps\factory_intro::kill_trainyard_enemy);
  level.scr_anim["ally_charlie"]["factory_intro_ally03"] = % factory_intro_ally03;
  level.scr_anim["ally_alpha"]["factory_intro_ally_mantle"] = % factory_intro_cover_ally02;
  level.scr_anim["ally_alpha"]["factory_intro_ally_cover_idle"][0] = % factory_intro_cover_idle_ally02;
  level.scr_anim["ally_echo"]["factory_engine_jump_ally02"] = % factory_engine_jump_ally02;
  level.scr_anim["initial_enemy"]["patrol_bored_idle"][0] = % patrol_bored_idle;
  level.scr_anim["initial_enemy"]["patrol_bored_patrolwalk_twitch"] = % patrol_bored_patrolwalk_twitch;
  level.scr_anim["initial_enemy"]["active_patrolwalk_pause"] = % active_patrolwalk_pause;
  level.scr_anim["ally_alpha"]["heat_approach_6"] = % heat_approach_6;
  level.scr_anim["ally_charlie"]["factory_truck_ally02_search"] = % factory_truck_ally02_search;
  level.scr_anim["enemy"]["factory_truck_enemy01_death"] = % factory_truck_enemy01_death;
  level.scr_anim["enemy"]["factory_truck_enemy01_enter"] = % factory_truck_enemy01_enter;
  level.scr_anim["enemy"]["factory_truck_enemy01_loop"][0] = % factory_truck_enemy01_loop;
  level.scr_anim["enemy"]["factory_truck_enemy02_death"] = % factory_truck_enemy02_death;
  level.scr_anim["enemy"]["factory_truck_enemy02_death_searched"] = % factory_truck_enemy02_death_searched;
  level.scr_anim["enemy"]["factory_truck_enemy02_loop"][0] = % factory_truck_enemy02_loop;
  level.scr_anim["enemy"]["factory_truck_enemy03_death"] = % factory_truck_enemy03_death;
  level.scr_anim["enemy"]["factory_truck_enemy03_loop"][0] = % factory_truck_enemy03_loop;
  level.scr_anim["enemy"]["factory_truck_enemy01"] = % factory_truck_enemy01;
  level.scr_anim["enemy"]["factory_truck_enemy02"] = % factory_truck_enemy02_enter;
  level.scr_anim["enemy"]["factory_truck_enemy03"] = % factory_truck_enemy03;
  level.scr_anim["enemy"]["factory_truck_driver_loop"] = % factory_truck_driver_loop;
  level.scr_anim["enemy"]["factory_truck_driver_death"] = % factory_truck_driver_death;
  level.scr_anim["enemy"]["surprise_stop_v1"] = % surprise_stop_v1;
  level.scr_anim["enemy"]["prague_intro_dock_guard_reaction_02"] = % prague_intro_dock_guard_reaction_02;
  level.scr_anim["enemy"]["scared_idle_turn_l_90"] = % scared_idle_turn_l_90;
  level.scr_anim["enemy"]["patrol_bored_walk_2_scared_idle_turn_r_90"] = % patrol_bored_walk_2_scared_idle_turn_r_90;
  level.scr_anim["enemy"]["patrol_bored_walk_2_scared_idle_turn_l_90"] = % patrol_bored_walk_2_scared_idle_turn_l_90;
  level.scr_anim["ally_charlie"]["factory_allies_enter_factory_ally_01"] = % factory_allies_enter_factory_ally_01;
  maps\_anim::addnotetrack_customfunction("ally_charlie", "intro_cardreader_unlock", maps\factory_fx::fx_intro_cardreader_unlock);
  level.scr_anim["ally_bravo"]["factory_allies_enter_factory_ally_02"] = % factory_allies_enter_factory_ally_02;
  level.scr_anim["ally_charlie"]["combatwalk_F_spin"] = % combatwalk_f_spin;
  level.scr_anim["generic"]["patrol_bored_patrolwalk"] = % patrol_bored_patrolwalk;
  level.scr_anim["generic"]["patrol_bored_idle"][0] = % patrol_bored_idle;
  level.scr_anim["generic"]["walk_gun_unwary"] = % dufflebag_casual_walk;
  level.scr_anim["enemy"]["dufflebag_casual_idle"][0] = % dufflebag_casual_idle;
  level.scr_anim["generic"]["patrol_bored_patrolwalk_twitch"] = % patrol_bored_patrolwalk_twitch;
  level.scr_anim["generic"]["exposed_crouch_idle_twitch_v2"][0] = % exposed_crouch_idle_twitch_v2;
  level.scr_anim["ally_charlie"]["cqb_aim"][0] = % cqb_stand_aim5;
  level.scr_anim["ally_charlie"]["cqb_walk_2_creepwalk"] = % cqb_walk_2_creepwalk;
  level.scr_anim["ally_alpha"]["corner_standL_signal_hold"] = % corner_standl_signal_hold;
  level.scr_anim["ally_alpha"]["CQB_stop_2_signal"] = % cqb_stop_2_signal;
  level.scr_anim["ally_alpha"]["factory_power_stealth_ally_intro"] = % factory_power_stealth_ally_intro;
  level.scr_anim["ally_alpha"]["factory_power_stealth_ally_intro_loop"][0] = % factory_power_stealth_ally_intro_loop;
  level.scr_anim["ally_alpha"]["factory_power_stealth_ally_intro_talk"] = % factory_power_stealth_ally_intro_talk;
  level.scr_anim["ally_alpha"]["factory_power_stealth_ally_exit_loop"][0] = % factory_power_stealth_ally_exit_loop;
  level.scr_anim["ally_alpha"]["factory_power_stealth_ally_intro_exit"] = % factory_power_stealth_ally_intro_exit;
  level.scr_anim["ally_alpha"]["CQB_stand_signal_move_up"] = % cqb_stand_signal_move_up;
  level.scr_anim["generic"]["CornerStndR_alert_signal_enemy_spotted"] = % cornerstndr_alert_signal_enemy_spotted;
  level.scr_anim["generic"]["signal_onme"] = % cqb_stand_wave_on_me;
  level.scr_anim["generic"]["signal_go_cqb"] = % cqb_stand_wave_go_v1;
  level.scr_anim["generic"]["signal_stop"] = % cqb_stand_signal_stop;
  level.scr_anim["ally_alpha"]["factory_power_stealth_lower_hallway_enter_ally"] = % factory_power_stealth_lower_hallway_enter_ally;
  level.scr_anim["ally_alpha"]["factory_power_stealth_lower_hallway_cross_ally"] = % factory_power_stealth_lower_hallway_cross_ally;
  level.scr_anim["ally_alpha"]["factory_power_stealth_breakarea_ally_shoot"] = % factory_power_stealth_breakarea_ally_shoot;
  maps\_anim::addnotetrack_customfunction("ally_alpha", "pistol", maps\factory_powerstealth::ps_alpha_pistol_switch);
  maps\_anim::addnotetrack_customfunction("ally_alpha", "fire1", maps\factory_powerstealth::ps_alpha_pistol_fire);
  maps\_anim::addnotetrack_customfunction("ally_alpha", "fire2", maps\factory_powerstealth::ps_alpha_pistol_fire);
  maps\_anim::addnotetrack_customfunction("ally_alpha", "fire3", maps\factory_powerstealth::ps_alpha_pistol_fire);
  maps\_anim::addnotetrack_customfunction("ally_alpha", "fire4", maps\factory_powerstealth::ps_alpha_pistol_fire);
  level.scr_anim["ally_charlie"]["card_swipe"] = % factory_power_stealth_card_swipe;
  maps\_anim::addnotetrack_customfunction("generic", "knife_in", ::throat_stab_npc);
  level.scr_anim["enemy"]["flashlight_search_loop"][0] = % so_hijack_search_flashlight_high_loop;
  level.scr_anim["enemy"]["active_patrolwalk_turn_180"] = % active_patrolwalk_turn_180;
  level.scr_anim["enemy"]["active_patrolwalk_v2"] = % active_patrolwalk_v2;
  level.scr_anim["enemy"]["active_patrolwalk_v4"] = % active_patrolwalk_v4;
  level.scr_anim["enemy"]["active_patrolwalk_v5"] = % active_patrolwalk_v5;
  level.scr_anim["enemy"]["active_patrolwalk_pause"] = % active_patrolwalk_pause;
  level.scr_anim["enemy"]["casual_stand_idle"][0] = % casual_stand_idle;
  level.scr_anim["ally"]["rogers_hall_kill"] = % factory_power_stealth_hallway_death_hero;
  level.scr_anim["ally"]["baker_lower_hall_kill"] = % factory_power_stealth_lower_hallway_hero;
  level.scr_anim["opfor"]["baker_lower_hall_kill"] = % factory_power_stealth_lower_hallway_enemy;
  level.scr_anim["opfor01"]["rest_area_kills"] = % factory_power_stealth_break_area_death_a;
  level.scr_anim["opfor02"]["rest_area_kills"] = % factory_power_stealth_break_area_death_b;
  level.scr_anim["opfor01"]["break_area_react_a"] = % factory_power_stealth_break_area_react_a;
  level.scr_anim["opfor02"]["break_area_react_b"] = % factory_power_stealth_break_area_react_b;
  level.scr_anim["opfor01"]["break_area_react_death_a"] = % factory_power_stealth_break_area_react_death_a;
  level.scr_anim["opfor02"]["break_area_react_death_b"] = % factory_power_stealth_break_area_react_death_b;
  maps\_anim::addnotetrack_customfunction("opfor01", "grab_gun", ::break_area_grab_gun);
  maps\_anim::addnotetrack_customfunction("opfor02", "grab_gun", ::break_area_grab_gun);
  level.scr_anim["ally_charlie"]["rogers_hall_kill_enter"] = % factory_power_stealth_hallway_death_enter_hero;
  level.scr_anim["ally_charlie"]["rogers_hall_kill_loop"][0] = % factory_power_stealth_hallway_death_loop_hero;
  level.scr_anim["ally_charlie"]["rogers_hall_kill"] = % factory_power_stealth_hallway_death_hero;
  level.scr_anim["opfor"]["rogers_hall_kill"] = % factory_power_stealth_hallway_death_enemy;
  level.scr_anim["ally_alpha"]["baker_lower_hall_kill_hero"] = % factory_power_stealth_lower_hallway_hero;
  level.scr_anim["enemy"]["baker_lower_hall_kill_enemy"] = % factory_power_stealth_lower_hallway_enemy;
  level.scr_anim["opfor01"]["factory_power_stealth_break_area_idle_a"][0] = % factory_power_stealth_break_area_idle_a;
  level.scr_anim["opfor02"]["factory_power_stealth_break_area_idle_b"][0] = % factory_power_stealth_break_area_idle_b;
  level.scr_anim["opfor"]["factory_power_stealth_break_area_death_a"] = % factory_power_stealth_break_area_death_a;
  level.scr_anim["opfor"]["factory_power_stealth_break_area_death_b"] = % factory_power_stealth_break_area_death_b;
  level.scr_anim["enemy"]["console_kill"] = % factory_power_stealth_console_death;
  level.scr_anim["enemy"]["factory_power_stealth_console_idle"][0] = % factory_power_stealth_console_idle;
  level.scr_anim["ally_charlie"]["factory_power_stealth_ally_corner_entrance"] = % factory_power_stealth_ally_corner_entrance;
  level.scr_anim["ally_charlie"]["factory_power_stealth_ally_corner_idle"][0] = % factory_power_stealth_ally_corner_idle;
  level.scr_anim["ally_charlie"]["factory_power_stealth_ally_corner_exit"] = % factory_power_stealth_ally_corner_exit;
  level.scr_anim["generic"]["sleep_enter"] = % factory_power_stealth_opfor_console_enter;
  level.scr_anim["generic"]["sleep_idle"][0] = % factory_power_stealth_opfor_console_loop;
  level.scr_anim["generic"]["throat_stab"] = % factory_power_stealth_opfor_console_melee_death;
  level.scr_anim["generic"]["sleep_react"] = % factory_power_stealth_opfor_console_react;
  level.scr_anim["generic"]["sleeper_shot"] = % factory_power_stealth_opfor_console_death_shot;
  level.scr_anim["ally_bravo"]["keegan_office_kill_enter"] = % factory_power_stealth_stairway_top_ally_enter;
  level.scr_anim["ally_bravo"]["keegan_office_kill_exit"] = % factory_power_stealth_stairway_top_ally_exit;
  level.scr_anim["ally_bravo"]["keegan_office_kill_loop"][0] = % factory_power_stealth_stairway_top_ally_loop;
  level.scr_anim["ally_bravo"]["keegan_office_kill_shoot"] = % factory_power_stealth_stairway_top_ally_shoot;
  maps\_anim::addnotetrack_customfunction("ally_bravo", "fire", maps\factory_powerstealth::bravo_shoot_office_guard);
  level.scr_anim["ally_charlie"]["keegan_top_stairway_kill"] = % factory_power_stealth_stairway_top_death_hero;
  level.scr_anim["enemy"]["keegan_top_stairway_kill"] = % factory_power_stealth_stairway_top_death_enemy;
  maps\_anim::addnotetrack_customfunction("enemy", "start_ragdoll", ::rag_doll);
  level.scr_anim["opfor01"]["last_patrol_kill"] = % factory_power_stealth_last_patrol_kill_enemy;
  level.scr_anim["ally01"]["last_patrol_kill"] = % factory_power_stealth_last_patrol_kill_hero;
  level.scr_anim["ally01"]["allies_enter_factory_ally01"] = % factory_allies_enter_factory_ally_01;
  level.scr_anim["ally02"]["allies_enter_factory_ally02"] = % factory_allies_enter_factory_ally_02;
  level.scr_anim["ally_charlie"]["corner_standL_trans_CQB_IN_2"] = % corner_standl_trans_cqb_in_2;
  level.scr_anim["ally_alpha"]["sat_room_enter_alpha"] = % factory_odin_reveal_merrick;
  level.scr_anim["ally_bravo"]["sat_room_enter_bravo"] = % factory_odin_reveal_keegan;
  level.scr_anim["ally_charlie"]["sat_room_enter_charlie"] = % factory_odin_reveal_hesh;
  level.scr_anim["ally_alpha"]["presat_door_arrive"] = % factory_allies_arrive_presat_door_ally01;
  level.scr_anim["ally_charlie"]["presat_door_arrive"] = % factory_allies_arrive_presat_door_ally02;
  level.scr_anim["ally_bravo"]["presat_door_arrive"] = % factory_allies_arrive_presat_door_ally03;
  level.scr_anim["ally_alpha"]["presat_door_enter"] = % factory_allies_enter_presat_door_ally01;
  level.scr_anim["ally_charlie"]["presat_door_enter"] = % factory_allies_enter_presat_door_ally02;
  level.scr_anim["ally_bravo"]["presat_door_enter"] = % factory_allies_enter_presat_door_ally03;
  level.scr_anim["ally_alpha"]["sat_room_alpha_lights"] = % factory_ambush_ally02_loop;
  level.scr_anim["ally_alpha"]["factory_SATroom_ally01_standIdle_enter"] = % factory_satroom_ally01_standidle_enter;
  level.scr_anim["ally_alpha"]["factory_SATroom_ally01_standIdle_loop"][0] = % factory_satroom_ally01_standidle_loop;
  level.scr_anim["ally_alpha"]["factory_SATroom_ally01_standIdle_exit"] = % factory_satroom_ally01_standidle_exit;
  level.scr_anim["ally_bravo"]["factory_SATroom_ally02_consoletyping_enter"] = % factory_satroom_ally02_consoletyping_enter;
  level.scr_anim["ally_bravo"]["factory_SATroom_ally02_consoletyping_loop"][0] = % factory_satroom_ally02_consoletyping_loop;
  level.scr_anim["ally_bravo"]["factory_SATroom_ally02_consoletyping_exit"] = % factory_satroom_ally02_consoletyping_exit;
  level.scr_anim["ally_alpha"]["factory_assembly_floor_open_door"] = % factory_assembly_floor_open_door_ally01;
  level.scr_goaltime["ally_alpha"]["factory_assembly_floor_open_door"] = 1;
  level.scr_anim["ally_charlie"]["factory_assembly_floor_open_door"] = % factory_assembly_floor_open_door_ally02;
  level.scr_goaltime["ally_alpha"]["factory_assembly_floor_open_door"] = 1;
  maps\_anim::addnotetrack_customfunction("ally_charlie", "assembly_cardreader_unlock", maps\factory_fx::fx_assembly_cardreader_unlock);
  level.scr_anim["ally_bravo"]["ambush_bravo_desk_search"] = % factory_ambush_desk_search_ally03;
  maps\_anim::addnotetrack_customfunction("ally_bravo", "fx_monitor_swap", maps\factory_fx::fx_assembly_ally_monitor_swap_1);
  level.scr_anim["ally_charlie"]["ambush_charlie_desk_search"] = % factory_ambush_desk_search_ally02;
  maps\_anim::addnotetrack_customfunction("ally_charlie", "fx_monitor_swap", maps\factory_fx::fx_assembly_ally_monitor_swap_2);
  level.scr_anim["ally_alpha"]["tell_player_get_data"][0] = % factory_ambush_ally01_loop;
  level.scr_anim["ally_charlie"]["charlie_typing"][0] = % factory_ambush_ally02_loop;
  level.scr_anim["ally_bravo"]["bravo_typing"][0] = % factory_ambush_ally03_loop;
  level.scr_anim["ally_alpha"]["ambush_ally01"] = % factory_ambush_ally01;
  level.scr_anim["ally_charlie"]["ambush_ally02"] = % factory_ambush_ally02;
  level.scr_anim["generic"]["ambush_enemy01"] = % factory_ambush_opfor01;
  level.scr_anim["generic"]["ambush_enemy02"] = % factory_ambush_opfor02;
  level.scr_anim["generic"]["ambush_enemy03"] = % factory_ambush_opfor03;
  level.scr_anim["generic"]["ambush_enemy04"] = % factory_ambush_opfor04;
  maps\_anim::addnotetrack_customfunction("generic", "die", ::kill_me);
  maps\_anim::addnotetrack_customfunction("generic", "fx_ambush_chest_blood", maps\factory_fx::fx_ambush_chest_blood);
  maps\_anim::addnotetrack_customfunction("ally_alpha", "fxn_ceiling_cables", maps\factory_fx::fx_assembly_ceiling_cables);
  maps\_anim::addnotetrack_customfunction("ally_alpha", "start_ambush_fx", ::ambush_notify_start_fx);
  maps\_anim::addnotetrack_customfunction("ally_alpha", "start_ambush_slowmo", ::ambush_notify_start_slomo);
  maps\_anim::addnotetrack_customfunction("ally_alpha", "glass_break", ::ambush_notify_glass_break);
  level.scr_anim["ally_charlie"]["casual_stand_idle"][0] = % casual_stand_idle;
  level.scr_anim["ally_charlie"]["casual_stand_idle"][1] = % casual_stand_idle_twitch;
  level.scr_anim["ally_charlie"]["casual_stand_idle"][2] = % casual_stand_idle_twitchb;
  level.scr_anim["generic"]["bravo_rappel_drop"] = % berlin_granite_team_rappel_drop;
  level.scr_anim["ally_bravo"]["pop_smoke_enter_ally02"] = % factory_ambush_pop_smoke_enter_ally02;
  level.scr_anim["ally_charlie"]["pop_smoke_enter_ally03"] = % factory_ambush_pop_smoke_enter_ally03;
  level.scr_anim["ally_alpha"]["pop_smoke_ally01"] = % factory_ambush_pop_smoke_ally01;
  level.scr_anim["ally_bravo"]["pop_smoke_ally02"] = % factory_ambush_pop_smoke_ally02;
  level.scr_anim["ally_charlie"]["pop_smoke_ally03"] = % factory_ambush_pop_smoke_ally03;
  level.scr_anim["generic"]["factory_ambush_smoke_CornerCr_01"] = % factory_ambush_smoke_cornercr_01;
  level.scr_anim["generic"]["factory_ambush_smoke_CornerCr_02"] = % factory_ambush_smoke_cornercr_02;
  level.scr_anim["generic"]["factory_ambush_smoke_CornerCrL_01"] = % factory_ambush_smoke_cornercrl_01;
  level.scr_anim["generic"]["factory_ambush_smoke_CornerCrL_02"] = % factory_ambush_smoke_cornercrl_02;
  level.scr_anim["generic"]["factory_ambush_smoke_CornerCrL_03"] = % factory_ambush_smoke_cornercrl_03;
  level.scr_anim["generic"]["factory_ambush_smoke_CornerCrR_01"] = % factory_ambush_smoke_cornercrr_01;
  level.scr_anim["generic"]["factory_ambush_smoke_CornerCrR_02"] = % factory_ambush_smoke_cornercrr_02;
  level.scr_anim["generic"]["factory_ambush_smoke_CornerCrR_03"] = % factory_ambush_smoke_cornercrr_03;
  level.scr_anim["generic"]["factory_ambush_smoke_CornerCrR_04"] = % factory_ambush_smoke_cornercrr_04;
  level.scr_anim["generic"]["factory_ambush_smoke_CornerCrR_05"] = % factory_ambush_smoke_cornercrr_05;
  level.scr_anim["generic"]["factory_ambush_smoke_stand_01"] = % factory_ambush_smoke_stand_01;
  level.scr_anim["generic"]["factory_ambush_smoke_stand_02"] = % factory_ambush_smoke_stand_02;
  level.scr_anim["generic"]["factory_ambush_smoke_stand_03"] = % factory_ambush_smoke_stand_03;
  level.scr_anim["generic"]["factory_ambush_smoke_walkforward_01"] = % factory_ambush_smoke_walkforward_01;
  level.scr_anim["generic"]["factory_ambush_smoke_walking_cough_01"] = % factory_ambush_smoke_walking_cough_01;
  level.scr_anim["generic"]["factory_ambush_smoke_walking_cough_02"] = % factory_ambush_smoke_walking_cough_02;
  level.scr_anim["generic"]["factory_ambush_smoke_walking_cough_03"] = % factory_ambush_smoke_walking_cough_03;
  level.scr_anim["ally_alpha"]["rooftop_breach_idle"][0] = % factory_longest_50_intro_door_breach_ally1_idle;
  level.scr_anim["ally_charlie"]["rooftop_breach_idle"][0] = % factory_longest_50_intro_door_breach_ally2_idle;
  level.scr_anim["ally_alpha"]["rooftop_breach"] = % factory_longest_50_intro_door_breach_ally1;
  level.scr_anim["ally_charlie"]["rooftop_breach"] = % factory_longest_50_intro_door_breach_ally2;
  level.scr_anim["enemy"]["exposed_idle_reactB"] = % exposed_idle_reactb;
  maps\_anim::addnotetrack_notify("ally_alpha", "door_breach_dialog", "door_breach_dialog");
  level.scr_anim["enemy"]["rooftop_enemy_door_kick"] = % door_kick_in;
  level.scr_anim["ally_alpha"]["factory_rooftop_jumpoff_ally01"] = % factory_rooftop_jumpoff_ally01;
  level.scr_anim["ally_bravo"]["factory_rooftop_jumpoff_ally02"] = % factory_rooftop_jumpoff_ally02;
  level.scr_anim["ally_charlie"]["factory_rooftop_jumpoff_ally03"] = % factory_rooftop_jumpoff_ally03;
  level.scr_anim["ally_alpha"]["factory_car_chase_intro_ally_pulls_up_player_loop"][0] = % factory_car_chase_intro_ally_wave_to_player_loop;
  level.scr_anim["ally_alpha"]["factory_car_chase_intro_ally_pulls_up_player"] = % factory_car_chase_intro_ally_pulls_up_player_ally;
  level.scr_anim["ally_bravo"]["factory_car_chase_intro_ally_pulls_up_player"] = % factory_car_chase_intro_ally_pulls_up_player_ally02;
  level.scr_anim["ally_charlie"]["factory_car_chase_intro_ally_pulls_up_player"] = % factory_car_chase_intro_ally_pulls_up_player_ally03;
  level.scr_anim["ally_alpha"]["factory_parking_lot_crub_hop_ally01"] = % factory_parking_lot_crub_hop_ally01;
  level.scr_anim["ally_bravo"]["factory_parking_lot_crub_hop_ally02"] = % factory_parking_lot_crub_hop_ally02;
  level.scr_anim["ally_charlie"]["factory_parking_lot_crub_hop_ally03"] = % factory_parking_lot_crub_hop_ally03;
  level.scr_anim["ally_alpha"]["factory_car_chase"] = % factory_car_chase_ally01;
  level.scr_anim["ally_bravo"]["factory_car_chase"] = % factory_car_chase_ally02;
  level.scr_anim["ally_charlie"]["factory_car_chase"] = % factory_car_chase_ally03;
}

#using_animtree("script_model");

script_model() {
  level.scr_animtree["foliage"] = #animtree;
  level.scr_anim["foliage"]["factory_intro_jungle_drop_player"] = % factory_intro_jungle_drop_foliage;
  level.scr_model["foliage"] = "factory_intro_jungle_drop_foliage";
  level.scr_animtree["foliage"] = #animtree;
  level.scr_anim["foliage"]["factory_intro_jungle_player"] = % factory_intro_jungle_foliage;
  level.scr_model["foliage"] = "factory_intro_jungle_foliage";
  level.scr_animtree["chair"] = #animtree;
  level.scr_model["chair"] = "fac_ambush_desk_search_chair";
  level.scr_anim["chair"]["sleep_react"] = % factory_power_stealth_opfor_console_react_chair;
  level.scr_anim["chair"]["sleeper_shot"] = % factory_power_stealth_opfor_console_death_shot_chair;
  level.scr_anim["chair"]["sleep_enter"] = % factory_power_stealth_opfor_console_enter_chair;
  level.scr_anim["chair"]["throat_stab"] = % factory_power_stealth_opfor_console_melee_death_chair;
  level.scr_animtree["rope"] = #animtree;
  level.scr_model["rope"] = "weapon_rappel_rope_long";
  level.scr_animtree["factory_intro_clipboard"] = #animtree;
  level.scr_anim["factory_intro_clipboard"]["factory_truck_enemy02"] = % factory_truck_enemy02_clipboard;
  level.scr_anim["factory_intro_clipboard"]["factory_truck_enemy02_death"] = % factory_truck_enemy02_death_clipboard;
  level.scr_model["factory_intro_clipboard"] = "com_clipboard_wpaper";
  level.scr_animtree["front_crane"] = #animtree;
  level.scr_anim["front_crane"]["allies_enter_factory_cranes"] = % factory_allies_enter_factory_front_crane;
  level.scr_model["front_crane"] = "factory_crane_loader_01";
  level.scr_animtree["front_crane_beam"] = #animtree;
  level.scr_anim["front_crane_beam"]["allies_enter_factory_cranes"] = % factory_allies_enter_factory_front_crane_beam;
  level.scr_model["front_crane_beam"] = "tag_origin";
  level.scr_animtree["factory_crane_rear"] = #animtree;
  level.scr_anim["factory_crane_rear"]["allies_enter_factory_cranes"] = % factory_allies_enter_factory_rear_crane;
  level.scr_model["factory_crane_rear"] = "factory_crane_loader_01";
  level.scr_animtree["factory_crane_rear_beam"] = #animtree;
  level.scr_anim["factory_crane_rear_beam"]["allies_enter_factory_cranes"] = % factory_allies_enter_factory_rear_crane_beam;
  level.scr_model["factory_crane_rear_beam"] = "tag_origin";
  level.scr_animtree["factory_crane_missiles"] = #animtree;
  level.scr_anim["factory_crane_missiles"]["allies_enter_factory_cranes"] = % factory_allies_enter_factory_missiles;
  level.scr_model["factory_crane_missiles"] = "tag_origin";
  level.scr_animtree["factory_allies_enter_factory_container01"] = #animtree;
  level.scr_anim["factory_allies_enter_factory_container01"]["allies_enter_factory_cranes"] = % factory_allies_enter_factory_container01;
  level.scr_model["factory_allies_enter_factory_container01"] = "tag_origin";
  level.scr_animtree["factory_allies_enter_factory_container02"] = #animtree;
  level.scr_anim["factory_allies_enter_factory_container02"]["allies_enter_factory_cranes"] = % factory_allies_enter_factory_container02;
  level.scr_model["factory_allies_enter_factory_container02"] = "tag_origin";
  level.scr_animtree["factory_conveyor_system_lanea"] = #animtree;
  level.scr_anim["factory_conveyor_system_lanea"]["factory_conveyor_system_lanea"][0] = % factory_conveyor_system_lanea;
  level.scr_anim["factory_conveyor_system_lanea"]["factory_conveyor_system_lanea_single"] = % factory_conveyor_system_lanea;
  level.scr_model["factory_conveyor_system_lanea"] = "factory_car_chase_tankfield";
  level.scr_animtree["factory_conveyor_system_laneb"] = #animtree;
  level.scr_anim["factory_conveyor_system_laneb"]["factory_conveyor_system_laneb"][0] = % factory_conveyor_system_laneb;
  level.scr_anim["factory_conveyor_system_laneb"]["factory_conveyor_system_laneb_single"] = % factory_conveyor_system_laneb;
  level.scr_model["factory_conveyor_system_laneb"] = "factory_car_chase_tankfield";
  level.scr_animtree["chair_opfor01"] = #animtree;
  level.scr_anim["chair_opfor01"]["rest_area_kills"] = % factory_power_stealth_break_area_death_a_chair;
  level.scr_anim["chair_opfor01"]["break_area_idle_chair"][0] = % factory_power_stealth_break_area_idle_a_chair;
  level.scr_anim["chair_opfor01"]["break_area_react_a_chair"] = % factory_power_stealth_break_area_react_a_chair;
  level.scr_anim["chair_opfor01"]["break_area_react_death_a_chair"] = % factory_power_stealth_break_area_react_death_a_chair;
  level.scr_model["chair_opfor01"] = "factory_folding_chair";
  level.scr_animtree["chair_opfor02"] = #animtree;
  level.scr_anim["chair_opfor02"]["rest_area_kills"] = % factory_power_stealth_break_area_death_b_chair;
  level.scr_anim["chair_opfor02"]["break_area_idle_chair"][0] = % factory_power_stealth_break_area_idle_b_chair;
  level.scr_anim["chair_opfor02"]["break_area_react_b_chair"] = % factory_power_stealth_break_area_react_b_chair;
  level.scr_anim["chair_opfor02"]["break_area_react_death_b_chair"] = % factory_power_stealth_break_area_react_death_b_chair;
  level.scr_model["chair_opfor02"] = "factory_folding_chair";
  level.scr_animtree["assembly_floor_door"] = #animtree;
  level.scr_anim["assembly_floor_door"]["factory_assembly_floor_open_door"] = % factory_assembly_floor_open_door_door;
  level.scr_model["assembly_floor_door"] = "factory_assembly_room_door";
  level.scr_animtree["front_moving_piece"] = #animtree;
  level.scr_anim["front_moving_piece"]["automated_assemebly_line"] = % factory_assembly_line_front_piece;
  level.scr_model["front_moving_piece"] = "factory_assembly_moving_front_piece";
  level.scr_animtree["front_moving_piece_belt"] = #animtree;
  level.scr_anim["front_moving_piece_belt"]["automated_assemebly_line"] = % factory_assembly_line_front_piece_belt;
  level.scr_model["front_moving_piece_belt"] = "factory_assembly_moving_front_belt";
  maps\_anim::addnotetrack_customfunction("front_moving_piece", "front_station_01_start", ::front_station_start_01);
  maps\_anim::addnotetrack_customfunction("front_moving_piece", "front_station_02_start", ::front_station_start_02);
  maps\_anim::addnotetrack_customfunction("front_moving_piece", "front_station_03_start", ::front_station_start_03);
  maps\_anim::addnotetrack_customfunction("front_moving_piece", "front_station_04_start", ::front_station_start_04);
  maps\_anim::addnotetrack_customfunction("front_moving_piece", "front_station_05_start", ::front_station_start_05);
  maps\_anim::addnotetrack_customfunction("front_moving_piece", "front_station_06_start", ::front_station_start_06);
  maps\_anim::addnotetrack_startfxontag("front_moving_piece", "fx_ambush_piece_start", undefined, "factory_moving_piece_light", "j_anim_jnt_main_piston_arm_btm");
  maps\_anim::addnotetrack_stopFXOnTag("front_moving_piece", "fx_ambush_piece_stop", undefined, "factory_moving_piece_light", "j_anim_jnt_main_piston_arm_btm");
  level.scr_animtree["back_moving_piece"] = #animtree;
  level.scr_anim["back_moving_piece"]["automated_assemebly_line"] = % factory_assembly_line_back_piece;
  level.scr_model["back_moving_piece"] = "factory_assembly_moving_back_piece";
  maps\_anim::addnotetrack_customfunction("back_moving_piece", "back_station_01_start", ::back_station_start_01);
  maps\_anim::addnotetrack_customfunction("back_moving_piece", "back_station_02_start", ::back_station_start_02);
  maps\_anim::addnotetrack_customfunction("back_moving_piece", "back_station_03_start", ::back_station_start_03);
  maps\_anim::addnotetrack_customfunction("back_moving_piece", "back_station_04_start", ::back_station_start_04);
  maps\_anim::addnotetrack_customfunction("back_moving_piece", "back_station_05_start", ::back_station_start_05);
  maps\_anim::addnotetrack_customfunction("back_moving_piece", "back_station_turn_rail_track", ::back_turn_rail_track);
  level.scr_animtree["factory_assembly_line_front_station01_arm_a"] = #animtree;
  level.scr_anim["factory_assembly_line_front_station01_arm_a"]["automated_assemebly_line"] = % factory_assembly_line_front_station01_arm_a;
  level.scr_model["factory_assembly_line_front_station01_arm_a"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station01_arm_a", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station01_arm_a", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_front_station01_arm_b"] = #animtree;
  level.scr_anim["factory_assembly_line_front_station01_arm_b"]["automated_assemebly_line"] = % factory_assembly_line_front_station01_arm_b;
  level.scr_model["factory_assembly_line_front_station01_arm_b"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station01_arm_b", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station01_arm_b", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_front_station02_arm_a"] = #animtree;
  level.scr_anim["factory_assembly_line_front_station02_arm_a"]["automated_assemebly_line"] = % factory_assembly_line_front_station02_arm_a;
  level.scr_model["factory_assembly_line_front_station02_arm_a"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station02_arm_a", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station02_arm_a", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_front_station02_arm_b"] = #animtree;
  level.scr_anim["factory_assembly_line_front_station02_arm_b"]["automated_assemebly_line"] = % factory_assembly_line_front_station02_arm_b;
  level.scr_model["factory_assembly_line_front_station02_arm_b"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station02_arm_b", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station02_arm_b", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_front_station02_arm_c"] = #animtree;
  level.scr_anim["factory_assembly_line_front_station02_arm_c"]["automated_assemebly_line"] = % factory_assembly_line_front_station02_arm_c;
  level.scr_model["factory_assembly_line_front_station02_arm_c"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station02_arm_c", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station02_arm_c", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_front_station02_arm_d"] = #animtree;
  level.scr_anim["factory_assembly_line_front_station02_arm_d"]["automated_assemebly_line"] = % factory_assembly_line_front_station02_arm_d;
  level.scr_model["factory_assembly_line_front_station02_arm_d"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station02_arm_d", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station02_arm_d", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_front_station03_arm_a"] = #animtree;
  level.scr_anim["factory_assembly_line_front_station03_arm_a"]["automated_assemebly_line"] = % factory_assembly_line_front_station03_arm_a;
  level.scr_model["factory_assembly_line_front_station03_arm_a"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station03_arm_a", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station03_arm_a", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_front_station03_arm_b"] = #animtree;
  level.scr_anim["factory_assembly_line_front_station03_arm_b"]["automated_assemebly_line"] = % factory_assembly_line_front_station03_arm_b;
  level.scr_model["factory_assembly_line_front_station03_arm_b"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station03_arm_b", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station03_arm_b", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_front_station03_arm_c"] = #animtree;
  level.scr_anim["factory_assembly_line_front_station03_arm_c"]["automated_assemebly_line"] = % factory_assembly_line_front_station03_arm_c;
  level.scr_model["factory_assembly_line_front_station03_arm_c"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station03_arm_c", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station03_arm_c", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_front_station03_arm_d"] = #animtree;
  level.scr_anim["factory_assembly_line_front_station03_arm_d"]["automated_assemebly_line"] = % factory_assembly_line_front_station03_arm_d;
  level.scr_model["factory_assembly_line_front_station03_arm_d"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station03_arm_d", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station03_arm_d", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_front_station04_arm_a"] = #animtree;
  level.scr_anim["factory_assembly_line_front_station04_arm_a"]["automated_assemebly_line"] = % factory_assembly_line_front_station04_arm_a;
  level.scr_model["factory_assembly_line_front_station04_arm_a"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station04_arm_a", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station04_arm_a", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_front_station04_arm_b"] = #animtree;
  level.scr_anim["factory_assembly_line_front_station04_arm_b"]["automated_assemebly_line"] = % factory_assembly_line_front_station04_arm_b;
  level.scr_model["factory_assembly_line_front_station04_arm_b"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station04_arm_b", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station04_arm_b", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_front_station04_arm_c"] = #animtree;
  level.scr_anim["factory_assembly_line_front_station04_arm_c"]["automated_assemebly_line"] = % factory_assembly_line_front_station04_arm_c;
  level.scr_model["factory_assembly_line_front_station04_arm_c"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station04_arm_c", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station04_arm_c", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_front_station05_arm_a"] = #animtree;
  level.scr_anim["factory_assembly_line_front_station05_arm_a"]["automated_assemebly_line"] = % factory_assembly_line_front_station05_arm_a;
  level.scr_model["factory_assembly_line_front_station05_arm_a"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station05_arm_a", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station05_arm_a", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_front_station05_arm_b"] = #animtree;
  level.scr_anim["factory_assembly_line_front_station05_arm_b"]["automated_assemebly_line"] = % factory_assembly_line_front_station05_arm_b;
  level.scr_model["factory_assembly_line_front_station05_arm_b"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station05_arm_b", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station05_arm_b", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_front_station05_arm_c"] = #animtree;
  level.scr_anim["factory_assembly_line_front_station05_arm_c"]["automated_assemebly_line"] = % factory_assembly_line_front_station05_arm_c;
  level.scr_model["factory_assembly_line_front_station05_arm_c"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station05_arm_c", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station05_arm_c", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_front_station06_arm_a"] = #animtree;
  level.scr_anim["factory_assembly_line_front_station06_arm_a"]["automated_assemebly_line"] = % factory_assembly_line_front_station06_arm_a;
  level.scr_model["factory_assembly_line_front_station06_arm_a"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station06_arm_a", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station06_arm_a", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_front_station06_arm_b"] = #animtree;
  level.scr_anim["factory_assembly_line_front_station06_arm_b"]["automated_assemebly_line"] = % factory_assembly_line_front_station06_arm_b;
  level.scr_model["factory_assembly_line_front_station06_arm_b"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station06_arm_b", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_front_station06_arm_b", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_back_station01"] = #animtree;
  level.scr_anim["factory_assembly_line_back_station01"]["automated_assemebly_line"] = % factory_assembly_line_back_station01;
  level.scr_model["factory_assembly_line_back_station01"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_back_station01", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_back_station01", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_back_station02"] = #animtree;
  level.scr_anim["factory_assembly_line_back_station02"]["automated_assemebly_line"] = % factory_assembly_line_back_station02;
  level.scr_model["factory_assembly_line_back_station02"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_back_station02", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_back_station02", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_back_station03"] = #animtree;
  level.scr_anim["factory_assembly_line_back_station03"]["automated_assemebly_line"] = % factory_assembly_line_back_station03;
  level.scr_model["factory_assembly_line_back_station03"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_back_station03", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_back_station03", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_back_station04"] = #animtree;
  level.scr_anim["factory_assembly_line_back_station04"]["automated_assemebly_line"] = % factory_assembly_line_back_station04;
  level.scr_model["factory_assembly_line_back_station04"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_back_station04", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_back_station04", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_back_station05"] = #animtree;
  level.scr_anim["factory_assembly_line_back_station05"]["automated_assemebly_line"] = % factory_assembly_line_back_station05;
  level.scr_model["factory_assembly_line_back_station05"] = "factory_assembly_automated_arm";
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_back_station05", "fx_ambush_welding_start", maps\factory_fx::fx_ambush_welding_start);
  maps\_anim::addnotetrack_customfunction("factory_assembly_line_back_station05", "fx_ambush_welding_stop", maps\factory_fx::fx_ambush_welding_stop);
  level.scr_animtree["factory_assembly_line_back_turn_rail_track"] = #animtree;
  level.scr_anim["factory_assembly_line_back_turn_rail_track"]["automated_assemebly_line"] = % factory_assembly_line_back_turn_rail_track;
  level.scr_model["factory_assembly_line_back_turn_rail_track"] = "factory_back_turn_rail_track";
  level.scr_animtree["factory_assembly_line_arm_malfunction"] = #animtree;
  level.scr_anim["factory_assembly_line_arm_malfunction"]["arm_malfunction"][0] = % factory_assembly_automated_arm_malfunction_loop;
  level.scr_model["factory_assembly_line_arm_malfunction"] = "factory_assembly_automated_arm_damaged";
  level.scr_animtree["desk_chair"] = #animtree;
  level.scr_anim["desk_chair"]["ambush_bravo_desk_search"] = % factory_ambush_desk_search_chair;
  level.scr_model["desk_chair"] = "fac_ambush_desk_search_chair";
  level.scr_animtree["desk_phone"] = #animtree;
  level.scr_anim["desk_phone"]["ambush_bravo_desk_search"] = % factory_ambush_desk_search_phone;
  level.scr_model["desk_phone"] = "fac_ambush_desk_search_phone";
  level.scr_animtree["desk_trash_can"] = #animtree;
  level.scr_anim["desk_trash_can"]["ambush_bravo_desk_search"] = % factory_ambush_desk_search_trash_can;
  level.scr_model["desk_trash_can"] = "fac_trash_bin";
  level.scr_animtree["desk_book01"] = #animtree;
  level.scr_anim["desk_book01"]["ambush_bravo_desk_search"] = % factory_ambush_desk_search_book01;
  level.scr_model["desk_book01"] = "com_office_book_black_standing";
  level.scr_animtree["desk_book02"] = #animtree;
  level.scr_anim["desk_book02"]["ambush_bravo_desk_search"] = % factory_ambush_desk_search_book02;
  level.scr_model["desk_book02"] = "com_office_book_blue_standing";
  level.scr_animtree["desk_book03"] = #animtree;
  level.scr_anim["desk_book03"]["ambush_bravo_desk_search"] = % factory_ambush_desk_search_book03;
  level.scr_model["desk_book03"] = "com_office_book_black_standing";
  level.scr_animtree["desk_book04"] = #animtree;
  level.scr_anim["desk_book04"]["ambush_bravo_desk_search"] = % factory_ambush_desk_search_book04;
  level.scr_model["desk_book04"] = "com_office_book_red_flat";
  level.scr_animtree["desk_book05"] = #animtree;
  level.scr_anim["desk_book05"]["ambush_bravo_desk_search"] = % factory_ambush_desk_search_book05;
  level.scr_model["desk_book05"] = "com_office_book_black_standing";
  level.scr_animtree["desk_book06"] = #animtree;
  level.scr_anim["desk_book06"]["ambush_bravo_desk_search"] = % factory_ambush_desk_search_book06;
  level.scr_model["desk_book06"] = "com_office_book_red_flat";
  level.scr_animtree["desk_book07"] = #animtree;
  level.scr_anim["desk_book07"]["ambush_bravo_desk_search"] = % factory_ambush_desk_search_book07;
  level.scr_model["desk_book07"] = "com_office_book_blue_standing";
  level.scr_animtree["desk_keyboard"] = #animtree;
  level.scr_anim["desk_keyboard"]["ambush_bravo_desk_search"] = % factory_ambush_desk_search_keyboard;
  level.scr_model["desk_keyboard"] = "fac_keyboard";
  level.scr_animtree["factory_ambush_usb_stick"] = #animtree;
  level.scr_anim["factory_ambush_usb_stick"]["ambush_props"] = % factory_ambush_usb_stick;
  level.scr_model["factory_ambush_usb_stick"] = "factory_ambush_usb_stick";
  level.scr_animtree["factory_ambush_door"] = #animtree;
  level.scr_anim["factory_ambush_door"]["ambush_props"] = % factory_ambush_door;
  level.scr_model["factory_ambush_door"] = "factory_ambush_door";
  level.scr_animtree["factory_ambush_desk"] = #animtree;
  level.scr_anim["factory_ambush_desk"]["ambush_props"] = % factory_ambush_desk;
  level.scr_model["factory_ambush_desk"] = "factory_ambush_desk";
  level.scr_animtree["factory_ambush_monitor01"] = #animtree;
  level.scr_anim["factory_ambush_monitor01"]["ambush_props"] = % factory_ambush_comp_monitor_01;
  level.scr_model["factory_ambush_monitor01"] = "factory_ambush_monitor";
  level.scr_animtree["factory_ambush_monitor02"] = #animtree;
  level.scr_anim["factory_ambush_monitor02"]["ambush_props"] = % factory_ambush_comp_monitor_02;
  level.scr_model["factory_ambush_monitor02"] = "com_pc_monitor_a";
  level.scr_animtree["factory_ambush_mouse01"] = #animtree;
  level.scr_anim["factory_ambush_mouse01"]["ambush_props"] = % factory_ambush_comp_mouse_01;
  level.scr_model["factory_ambush_mouse01"] = "plastic_computer_mouse_01";
  level.scr_animtree["factory_ambush_mouse02"] = #animtree;
  level.scr_anim["factory_ambush_mouse02"]["ambush_props"] = % factory_ambush_comp_mouse_02;
  level.scr_model["factory_ambush_mouse02"] = "plastic_computer_mouse_01";
  level.scr_animtree["factory_ambush_keyboard01"] = #animtree;
  level.scr_anim["factory_ambush_keyboard01"]["ambush_props"] = % factory_ambush_comp_keyboard_01;
  level.scr_model["factory_ambush_keyboard01"] = "fac_keyboard";
  level.scr_animtree["factory_ambush_keyboard02"] = #animtree;
  level.scr_anim["factory_ambush_keyboard02"]["ambush_props"] = % factory_ambush_comp_keyboard_02;
  level.scr_model["factory_ambush_keyboard02"] = "fac_keyboard";
  level.scr_animtree["factory_ambush_clipboard"] = #animtree;
  level.scr_anim["factory_ambush_clipboard"]["ambush_props"] = % factory_ambush_clipboard;
  level.scr_model["factory_ambush_clipboard"] = "com_clipboard_wpaper";
  level.scr_animtree["factory_ambush_cup"] = #animtree;
  level.scr_anim["factory_ambush_cup"]["ambush_props"] = % factory_ambush_cup;
  level.scr_model["factory_ambush_cup"] = "fac_coffee_cup";
  level.scr_animtree["factory_ambush_computer"] = #animtree;
  level.scr_anim["factory_ambush_computer"]["ambush_props"] = % factory_ambush_computer_01;
  level.scr_model["factory_ambush_computer"] = "fac_io_device";
  level.scr_animtree["factory_ambush_tv"] = #animtree;
  level.scr_anim["factory_ambush_tv"]["ambush_props"] = % factory_ambush_tv_debris;
  level.scr_model["factory_ambush_tv"] = "tv_flatscreen_large";
  level.scr_animtree["factory_ambush_airduct_01"] = #animtree;
  level.scr_anim["factory_ambush_airduct_01"]["ambush_props"] = % factory_ambush_airduct_01;
  level.scr_model["factory_ambush_airduct_01"] = "com_airduct_150x_square";
  level.scr_animtree["factory_ambush_airduct_02"] = #animtree;
  level.scr_anim["factory_ambush_airduct_02"]["ambush_props"] = % factory_ambush_airduct_02;
  level.scr_model["factory_ambush_airduct_02"] = "com_airduct_150x_square";
  level.scr_animtree["factory_ambush_wall_debris"] = #animtree;
  level.scr_anim["factory_ambush_wall_debris"]["ambush_props"] = % factory_ambush_wall_debris;
  level.scr_model["factory_ambush_wall_debris"] = "factory_ambush_wall_debris";
  level.scr_animtree["factory_ambush_ceiling_cables_01"] = #animtree;
  level.scr_anim["factory_ambush_ceiling_cables_01"]["ambush_props"] = % factory_ambush_ceiling_cables_01;
  level.scr_model["factory_ambush_ceiling_cables_01"] = "factory_ambush_ceiling_cables";
  level.scr_animtree["factory_ambush_ceiling_cables_02"] = #animtree;
  level.scr_anim["factory_ambush_ceiling_cables_02"]["ambush_props"] = % factory_ambush_ceiling_cables_02;
  level.scr_model["factory_ambush_ceiling_cables_02"] = "factory_ambush_ceiling_cables";
  level.scr_animtree["factory_ambush_ceiling_cables_03"] = #animtree;
  level.scr_anim["factory_ambush_ceiling_cables_03"]["ambush_props"] = % factory_ambush_ceiling_cables_03;
  level.scr_model["factory_ambush_ceiling_cables_03"] = "factory_ambush_ceiling_cables";
  level.scr_animtree["factory_ambush_opfor02_rope"] = #animtree;
  level.scr_anim["factory_ambush_opfor02_rope"]["ambush_props"] = % factory_ambush_opfor02_rope;
  level.scr_model["factory_ambush_opfor02_rope"] = "weapon_rappel_rope_long";
  level.scr_animtree["factory_ambush_opfor03_rope"] = #animtree;
  level.scr_anim["factory_ambush_opfor03_rope"]["ambush_props"] = % factory_ambush_opfor03_rope;
  level.scr_model["factory_ambush_opfor03_rope"] = "weapon_rappel_rope_long";
  level.scr_animtree["factory_ambush_opfor04_rope"] = #animtree;
  level.scr_anim["factory_ambush_opfor04_rope"]["ambush_props"] = % factory_ambush_opfor04_rope;
  level.scr_model["factory_ambush_opfor04_rope"] = "weapon_rappel_rope_long";
  level.scr_anim["rope"]["bravo_rappel_drop"] = % berlin_granite_team_rappel_drop_rope;
  level.scr_animtree["rooftop_breach_door"] = #animtree;
  level.scr_anim["rooftop_breach_door"]["rooftop_breach"] = % factory_longest_50_intro_door_breach_door;
  level.scr_animtree["factory_car_chase_intro_broken_awning01"] = #animtree;
  level.scr_anim["factory_car_chase_intro_broken_awning01"]["car_chase_intro_car_crash"] = % factory_car_chase_intro_broken_awning01;
  level.scr_model["factory_car_chase_intro_broken_awning01"] = "factory_car_chase_intro_broken_awning01";
  level.scr_animtree["factory_car_chase_intro_broken_awning02"] = #animtree;
  level.scr_anim["factory_car_chase_intro_broken_awning02"]["car_chase_intro_car_crash"] = % factory_car_chase_intro_broken_awning02;
  level.scr_model["factory_car_chase_intro_broken_awning02"] = "factory_car_chase_intro_broken_awning02";
  level.scr_animtree["factory_car_chase_intro_broken_awning03"] = #animtree;
  level.scr_anim["factory_car_chase_intro_broken_awning03"]["car_chase_intro_car_crash"] = % factory_car_chase_intro_broken_awning03;
  level.scr_model["factory_car_chase_intro_broken_awning03"] = "factory_car_chase_intro_broken_awning03";
  level.scr_animtree["factory_car_chase_intro_broken_awning04"] = #animtree;
  level.scr_anim["factory_car_chase_intro_broken_awning04"]["car_chase_intro_car_crash"] = % factory_car_chase_intro_broken_awning04;
  level.scr_model["factory_car_chase_intro_broken_awning04"] = "factory_car_chase_intro_broken_awning04";
  level.scr_animtree["factory_car_chase_intro_broken_fence01"] = #animtree;
  level.scr_anim["factory_car_chase_intro_broken_fence01"]["car_chase_intro_car_crash"] = % factory_car_chase_intro_broken_fence01;
  level.scr_model["factory_car_chase_intro_broken_fence01"] = "factory_car_chase_intro_broken_fence";
  level.scr_animtree["factory_car_chase_intro_broken_fence02"] = #animtree;
  level.scr_anim["factory_car_chase_intro_broken_fence02"]["car_chase_intro_car_crash"] = % factory_car_chase_intro_broken_fence02;
  level.scr_model["factory_car_chase_intro_broken_fence02"] = "factory_car_chase_intro_broken_fence";
  level.scr_animtree["factory_car_chase_intro_broken_light_post"] = #animtree;
  level.scr_anim["factory_car_chase_intro_broken_light_post"]["car_chase_intro_car_crash"] = % factory_car_chase_intro_broken_light_post;
  level.scr_model["factory_car_chase_intro_broken_light_post"] = "factory_car_chase_intro_broken_light_post";
  level.scr_animtree["factory_car_chase_smokestack_01"] = #animtree;
  level.scr_anim["factory_car_chase_smokestack_01"]["factory_car_chase"] = % factory_car_chase_smokestack_01;
  level.scr_model["factory_car_chase_smokestack_01"] = "factory_car_chase_smokestack_large";
  maps\_anim::addnotetrack_customfunction("factory_car_chase_smokestack_01", "fx_chase_stack_small_break", maps\factory_fx::fx_chase_stack_small_break);
  level.scr_animtree["factory_car_chase_smokestack_02"] = #animtree;
  level.scr_anim["factory_car_chase_smokestack_02"]["factory_car_chase"] = % factory_car_chase_smokestack_02;
  level.scr_model["factory_car_chase_smokestack_02"] = "factory_car_chase_smokestack_large";
  maps\_anim::addnotetrack_customfunction("factory_car_chase_smokestack_02", "fx_chase_stack_break_01", maps\factory_fx::fx_chase_stack_break_01);
  maps\_anim::addnotetrack_customfunction("factory_car_chase_smokestack_02", "fx_chase_stack_break_02", maps\factory_fx::fx_chase_stack_break_02);
  maps\_anim::addnotetrack_customfunction("factory_car_chase_smokestack_02", "fx_chase_stack_piece_027", maps\factory_fx::fx_chase_stack_piece_027);
  maps\_anim::addnotetrack_customfunction("factory_car_chase_smokestack_02", "fx_chase_stack_piece_037", maps\factory_fx::fx_chase_stack_piece_037);
  maps\_anim::addnotetrack_customfunction("factory_car_chase_smokestack_02", "fx_chase_stack_piece_039", maps\factory_fx::fx_chase_stack_piece_039);
  maps\_anim::addnotetrack_customfunction("factory_car_chase_smokestack_02", "fx_chase_stack_piece_042", maps\factory_fx::fx_chase_stack_piece_042);
  maps\_anim::addnotetrack_customfunction("factory_car_chase_smokestack_02", "fx_chase_stack_piece_007", maps\factory_fx::fx_chase_stack_piece_007);
  maps\_anim::addnotetrack_customfunction("factory_car_chase_smokestack_02", "fx_chase_stack_piece_008", maps\factory_fx::fx_chase_stack_piece_008);
  maps\_anim::addnotetrack_customfunction("factory_car_chase_smokestack_02", "fx_chase_stack_piece_017", maps\factory_fx::fx_chase_stack_piece_017);
  level.scr_animtree["factory_car_chase_building_corner_break_00"] = #animtree;
  level.scr_anim["factory_car_chase_building_corner_break_00"]["factory_car_chase"] = % factory_car_chase_building_corner_break_00;
  level.scr_model["factory_car_chase_building_corner_break_00"] = "factory_car_chase_building_corner_break_00";
  level.scr_animtree["factory_car_chase_building_corner_break_01"] = #animtree;
  level.scr_anim["factory_car_chase_building_corner_break_01"]["factory_car_chase"] = % factory_car_chase_building_corner_break_01;
  level.scr_model["factory_car_chase_building_corner_break_01"] = "factory_car_chase_building_corner_break_01";
  level.scr_animtree["factory_car_chase_building_corner_break_02"] = #animtree;
  level.scr_anim["factory_car_chase_building_corner_break_02"]["factory_car_chase"] = % factory_car_chase_building_corner_break_02;
  level.scr_model["factory_car_chase_building_corner_break_02"] = "factory_car_chase_building_corner_break_02";
  level.scr_animtree["factory_boxes_and_shvelves_01"] = #animtree;
  level.scr_anim["factory_boxes_and_shvelves_01"]["factory_car_chase"] = % factory_car_chase_boxes_n_shelves_01;
  level.scr_model["factory_boxes_and_shvelves_01"] = "factory_boxes_and_shvelves_01";
  level.scr_animtree["factory_boxes_and_shvelves_02"] = #animtree;
  level.scr_anim["factory_boxes_and_shvelves_02"]["factory_car_chase"] = % factory_car_chase_boxes_n_shelves_02;
  level.scr_model["factory_boxes_and_shvelves_02"] = "factory_boxes_and_shvelves_02";
  level.scr_animtree["factory_car_chase_warehouse_facade0"] = #animtree;
  level.scr_anim["factory_car_chase_warehouse_facade0"]["factory_car_chase"] = % factory_car_chase_warehouse_facade0;
  level.scr_model["factory_car_chase_warehouse_facade0"] = "factory_car_chase_warehouse_facade0";
  level.scr_animtree["factory_car_chase_warehouse_facade1"] = #animtree;
  level.scr_anim["factory_car_chase_warehouse_facade1"]["factory_car_chase"] = % factory_car_chase_warehouse_facade1;
  level.scr_model["factory_car_chase_warehouse_facade1"] = "factory_car_chase_warehouse_facade1";
  level.scr_animtree["factory_car_chase_warehouse_top"] = #animtree;
  level.scr_anim["factory_car_chase_warehouse_top"]["factory_car_chase"] = % factory_car_chase_warehouse_top;
  level.scr_model["factory_car_chase_warehouse_top"] = "factory_car_chase_warehouse_top";
  level.scr_animtree["factory_car_chase_pipes"] = #animtree;
  level.scr_anim["factory_car_chase_pipes"]["factory_car_chase"] = % factory_car_chase_pipes;
  level.scr_model["factory_car_chase_pipes"] = "fac_car_chase_pipes_01";
  level.scr_animtree["factory_car_chase_skybridge_01"] = #animtree;
  level.scr_anim["factory_car_chase_skybridge_01"]["factory_car_chase"] = % factory_car_chase_skybridge_01;
  level.scr_model["factory_car_chase_skybridge_01"] = "fac_skybridge_01";
  level.scr_animtree["factory_car_chase_skybridge_02"] = #animtree;
  level.scr_anim["factory_car_chase_skybridge_02"]["factory_car_chase"] = % factory_car_chase_skybridge_02;
  level.scr_model["factory_car_chase_skybridge_02"] = "fac_skybridge_01";
  level.scr_animtree["factory_car_chase_smokestack_wall_01"] = #animtree;
  level.scr_anim["factory_car_chase_smokestack_wall_01"]["factory_car_chase"] = % factory_car_chase_smokestack_wall_01;
  level.scr_model["factory_car_chase_smokestack_wall_01"] = "fac_smokestack_wall0";
  level.scr_animtree["factory_car_chase_smokestack_wall_02"] = #animtree;
  level.scr_anim["factory_car_chase_smokestack_wall_02"]["factory_car_chase"] = % factory_car_chase_smokestack_wall_02;
  level.scr_model["factory_car_chase_smokestack_wall_02"] = "fac_smokestack_wall1";
  level.scr_animtree["factory_car_chase_building_facade_01"] = #animtree;
  level.scr_anim["factory_car_chase_building_facade_01"]["factory_car_chase"] = % factory_car_chase_building_facade_01;
  level.scr_model["factory_car_chase_building_facade_01"] = "factory_car_chase_building_facade_01";
  level.scr_animtree["factory_car_chase_building_facade_02"] = #animtree;
  level.scr_anim["factory_car_chase_building_facade_02"]["factory_car_chase"] = % factory_car_chase_building_facade_02;
  level.scr_model["factory_car_chase_building_facade_02"] = "factory_car_chase_building_facade_02";
  level.scr_animtree["factory_car_chase_building_facade_03"] = #animtree;
  level.scr_anim["factory_car_chase_building_facade_03"]["factory_car_chase"] = % factory_car_chase_building_facade_03;
  level.scr_model["factory_car_chase_building_facade_03"] = "factory_car_chase_building_facade_03";
  level.scr_animtree["factory_car_chase_building_facade_04"] = #animtree;
  level.scr_anim["factory_car_chase_building_facade_04"]["factory_car_chase"] = % factory_car_chase_building_facade_04;
  level.scr_model["factory_car_chase_building_facade_04"] = "factory_car_chase_building_facade_04";
  level.scr_animtree["factory_car_chase_building_facade_05"] = #animtree;
  level.scr_anim["factory_car_chase_building_facade_05"]["factory_car_chase"] = % factory_car_chase_building_facade_05;
  level.scr_model["factory_car_chase_building_facade_05"] = "factory_car_chase_building_facade_05";
  level.scr_animtree["factory_car_chase_building_facade_06"] = #animtree;
  level.scr_anim["factory_car_chase_building_facade_06"]["factory_car_chase"] = % factory_car_chase_building_facade_06;
  level.scr_model["factory_car_chase_building_facade_06"] = "factory_car_chase_building_facade_06";
  level.scr_animtree["factory_car_chase_building_facade_07"] = #animtree;
  level.scr_anim["factory_car_chase_building_facade_07"]["factory_car_chase"] = % factory_car_chase_building_facade_07;
  level.scr_model["factory_car_chase_building_facade_07"] = "factory_car_chase_building_facade_01";
  level.scr_animtree["factory_car_chase_building_facade_08"] = #animtree;
  level.scr_anim["factory_car_chase_building_facade_08"]["factory_car_chase"] = % factory_car_chase_building_facade_08;
  level.scr_model["factory_car_chase_building_facade_08"] = "factory_car_chase_building_facade_02";
  level.scr_animtree["factory_car_chase_building_facade_09"] = #animtree;
  level.scr_anim["factory_car_chase_building_facade_09"]["factory_car_chase"] = % factory_car_chase_building_facade_09;
  level.scr_model["factory_car_chase_building_facade_09"] = "factory_car_chase_building_facade_03";
  level.scr_animtree["factory_car_chase_building_facade_10"] = #animtree;
  level.scr_anim["factory_car_chase_building_facade_10"]["factory_car_chase"] = % factory_car_chase_building_facade_10;
  level.scr_model["factory_car_chase_building_facade_10"] = "factory_car_chase_building_facade_04";
  level.scr_animtree["factory_car_chase_building_facade_11"] = #animtree;
  level.scr_anim["factory_car_chase_building_facade_11"]["factory_car_chase"] = % factory_car_chase_building_facade_11;
  level.scr_model["factory_car_chase_building_facade_11"] = "factory_car_chase_building_facade_05";
  level.scr_animtree["factory_car_chase_building_facade_12"] = #animtree;
  level.scr_anim["factory_car_chase_building_facade_12"]["factory_car_chase"] = % factory_car_chase_building_facade_12;
  level.scr_model["factory_car_chase_building_facade_12"] = "factory_car_chase_building_facade_06";
}

#using_animtree("player");

player() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_anim["player_rig"]["factory_intro_jungle_drop_player"] = % factory_intro_jungle_drop_player;
  level.scr_model["player_rig"] = "viewhands_player_devgru_elite";
  maps\_anim::addnotetrack_customfunction("player_rig", "release_arc", ::release_intro_view_angle_clamp);
  maps\_anim::addnotetrack_notify("player_rig", "release_arc", "release_arc_notify");
  level.scr_anim["player_rig"]["factory_intro_jungle_drop_kill_player"] = % factory_intro_jungle_drop_kill_player;
  level.scr_anim["player_rig"]["factory_intro_jungle_player"] = % factory_intro_jungle_player;
  level.scr_anim["player_rig"]["factory_intro"] = % factory_intro_player;
  level.scr_anim["player_rig"]["factory_opfor_trainyard_melee_death"] = % factory_opfor_trainyard_melee_death_player;
  level.scr_anim["player_rig"]["throat_stab"] = % factory_power_stealth_player_console_melee_death;
  maps\_anim::addnotetrack_customfunction("player_rig", "knife_in", ::throat_stab_player);
  level.scr_anim["player_rig"]["ambush_player"] = % factory_player_ambush;
  level.scr_anim["player_rig"]["ambush_player_knockback"] = % factory_player_ambush_knock_back;
  maps\_anim::addnotetrack_notify("player_rig", "hands_off", "hands_off");
  maps\_anim::addnotetrack_customfunction("player_rig", "fxn_monitor_bink_start", maps\factory_fx::fx_assembly_monitor_bink_start);
  maps\_anim::addnotetrack_customfunction("player_rig", "fxn_monitor_error", maps\factory_fx::fx_assembly_ally_monitor_error);
  level.scr_anim["player_rig"]["factory_car_chase_intro_ally_pulls_up_player"] = % factory_car_chase_intro_ally_pulls_up_player_player;
  maps\_anim::addnotetrack_customfunction("player_rig", "player_switch", ::chase_pull_up_notify_switch);
  level.scr_anim["player_rig"]["factory_car_chase_player_knock_down_01"] = % factory_car_chase_player_knock_down_01;
  level.scr_anim["player_rig"]["factory_car_chase_player_knock_down_02"] = % factory_car_chase_player_knock_down_02;
  level.scr_anim["player_rig"]["factory_car_chase_player_knock_down_03"] = % factory_car_chase_player_knock_down_03;
}

release_intro_view_angle_clamp(var_0) {
  var_1 = 15;
  level.player lerpviewangleclamp(0.5, 0.1, 0.1, var_1, var_1, var_1, var_1);
}

#using_animtree("vehicles");

vehicles() {
  level.scr_animtree["het_cab"] = #animtree;
  level.scr_anim["het_cab"]["factory_truck_entrance"] = % factory_truck_cab;
  level.scr_model["het_cab"] = "vehicle_mobile_railgun_cab";
  level.scr_animtree["het_trailer"] = #animtree;
  level.scr_anim["het_trailer"]["factory_truck_entrance"] = % factory_truck_trailer;
  level.scr_model["het_trailer"] = "vehicle_mobile_railgun_trailer";
  level.scr_animtree["intro_chopper"] = #animtree;
  level.scr_anim["intro_chopper"]["factory_intro_jungle_spotlight_chopper"] = % factory_intro_jungle_spotlight_chopper;
  level.scr_model["intro_chopper"] = "vehicle_nh90";
  level.scr_animtree["factory_car_chase_intro_ally_pulls_up_player_b201"] = #animtree;
  level.scr_anim["factory_car_chase_intro_ally_pulls_up_player_b201"]["factory_car_chase_intro_ally_pulls_up_player"] = % factory_car_chase_intro_ally_pulls_up_player_b201;
  level.scr_model["factory_car_chase_intro_ally_pulls_up_player_b201"] = "vehicle_b2_bomber";
  level.scr_animtree["factory_car_chase_intro_ally_pulls_up_player_b202"] = #animtree;
  level.scr_anim["factory_car_chase_intro_ally_pulls_up_player_b202"]["factory_car_chase_intro_ally_pulls_up_player"] = % factory_car_chase_intro_ally_pulls_up_player_b202;
  level.scr_model["factory_car_chase_intro_ally_pulls_up_player_b202"] = "vehicle_b2_bomber";
  level.scr_animtree["factory_car_chase_intro_ally_pulls_up_player_b203"] = #animtree;
  level.scr_anim["factory_car_chase_intro_ally_pulls_up_player_b203"]["factory_car_chase_intro_ally_pulls_up_player"] = % factory_car_chase_intro_ally_pulls_up_player_b203;
  level.scr_model["factory_car_chase_intro_ally_pulls_up_player_b203"] = "vehicle_b2_bomber";
  level.scr_anim["first_opfor_car"]["car_chase_intro_pullup"] = % factory_car_chase_intro_first_car_pullup;
  level.scr_anim["second_opfor_car"]["car_chase_intro_pullup"] = % factory_car_chase_intro_second_car_pullup;
  level.scr_anim["heavy_weapon_opfor_car"]["car_chase_intro_pullup"] = % factory_car_chase_intro_heavy_vehicle_pullup;
  level.scr_anim["first_opfor_car"]["car_chase_intro_car_crash"] = % factory_car_chase_intro_first_car_crash;
  level.scr_anim["second_opfor_car"]["car_chase_intro_car_crash"] = % factory_car_chase_intro_second_car_crash;
  level.scr_anim["heavy_weapon_opfor_car"]["car_chase_intro_car_crash"] = % factory_car_chase_intro_heavy_vehicle_crash;
  level.scr_anim["het_cab"]["car_chase_intro_car_crash"] = % factory_car_chase_intro_het_cab_crash;
  maps\_anim::addnotetrack_customfunction("het_cab", "fx_chase_first_explosion", maps\factory_fx::fx_chase_first_explosion);
  maps\_anim::addnotetrack_customfunction("het_cab", "fx_chase_box_explosions_start", maps\factory_fx::fx_chase_box_explosions_start);
  maps\_anim::addnotetrack_customfunction("het_cab", "fx_chase_warehouse_explosion", maps\factory_fx::fx_chase_warehouse_explosion);
  maps\_anim::addnotetrack_customfunction("het_cab", "fx_chase_turn_explosion", maps\factory_fx::fx_chase_turn_explosion);
  maps\_anim::addnotetrack_customfunction("het_cab", "fx_chase_helicopter_explosion", maps\factory_fx::fx_chase_helicopter_explosion);
  level.scr_animtree["factory_car_chase_intro_side_car01_crash"] = #animtree;
  level.scr_anim["factory_car_chase_intro_side_car01_crash"]["car_chase_intro_car_crash"] = % factory_car_chase_intro_side_car01_crash;
  level.scr_anim["factory_car_chase_intro_side_car01_crash"]["factory_car_chase"] = % factory_car_chase_intro_side_car01_blowup;
  level.scr_model["factory_car_chase_intro_side_car01_crash"] = "vehicle_uk_utility_truck_static";
  level.scr_animtree["factory_car_chase_intro_side_car02_crash"] = #animtree;
  level.scr_anim["factory_car_chase_intro_side_car02_crash"]["car_chase_intro_car_crash"] = % factory_car_chase_intro_side_car02_crash;
  level.scr_anim["factory_car_chase_intro_side_car02_crash"]["factory_car_chase"] = % factory_car_chase_intro_side_car02_blowup;
  level.scr_model["factory_car_chase_intro_side_car02_crash"] = "vehicle_uk_utility_truck_static";
  level.scr_animtree["factory_car_chase_intro_side_car03_blowup"] = #animtree;
  level.scr_anim["factory_car_chase_intro_side_car03_blowup"]["factory_car_chase"] = % factory_car_chase_intro_side_car03_blowup;
  level.scr_model["factory_car_chase_intro_side_car03_blowup"] = "vehicle_uk_utility_truck_static";
  level.scr_anim["het_trailer"]["car_chase_intro_car_crash"] = % factory_car_chase_intro_het_trailer_crash;
  maps\_anim::addnotetrack_customfunction("het_trailer", "fx_chase_het_tire_smoke", maps\factory_fx::fx_chase_het_tire_smoke);
  level.scr_anim["first_opfor_car"]["factory_car_chase"] = % factory_car_chase_intro_first_car_blowup;
  level.scr_anim["second_opfor_car"]["factory_car_chase"] = % factory_car_chase_intro_second_blowup;
  level.scr_anim["heavy_weapon_opfor_car"]["factory_car_chase"] = % factory_car_chase_intro_heavy_car_blowup;
  level.scr_animtree["third_opfor_car"] = #animtree;
  level.scr_anim["third_opfor_car"]["factory_car_chase"] = % factory_car_chase_intro_third_car_blowup;
  level.scr_model["third_opfor_car"] = "vehicle_iveco_lynx_iw6";
  maps\_anim::addnotetrack_customfunction("het_cab", "hit_gaz_01", ::chase_notify_hit_vehicle_1);
  maps\_anim::addnotetrack_customfunction("het_cab", "hit_gaz_02", ::chase_notify_hit_vehicle_2);
  maps\_anim::addnotetrack_customfunction("het_cab", "hit_btr", ::chase_notify_hit_vehicle_3);
  maps\_anim::addnotetrack_customfunction("het_cab", "hit_awning", ::chase_notify_hit_awning);
  maps\_anim::addnotetrack_customfunction("het_cab", "hit_light_pole", ::chase_notify_hit_light_pole);
  maps\_anim::addnotetrack_customfunction("het_cab", "hit_hydrant", ::chase_notify_hit_hydrant);
  maps\_anim::addnotetrack_customfunction("het_cab", "get_on_01", ::ally_01_mount_trailer);
  maps\_anim::addnotetrack_customfunction("het_cab", "get_on_02", ::ally_02_mount_trailer);
  maps\_anim::addnotetrack_customfunction("het_cab", "get_on_03", ::ally_03_mount_trailer);
  maps\_anim::addnotetrack_customfunction("het_cab", "fx_exploder,chase_130", ::chase_trailer_catch_fire);
  maps\_anim::addnotetrack_customfunction("het_cab", "fx_exploder,chase_160", ::chase_trailer_crate_destroyed);
  maps\_anim::addnotetrack_customfunction("het_cab", "player_knock_03", ::chase_player_knock_03);
  maps\_anim::addnotetrack_customfunction("het_cab", "slide_right", ::slide_right);
  maps\_anim::addnotetrack_customfunction("het_cab", "slide_left_quick", ::slide_left_quick);
  maps\_anim::addnotetrack_customfunction("het_cab", "slide_right_quick", ::slide_right_quick);
  maps\_anim::addnotetrack_customfunction("het_cab", "hard_left", ::hard_left);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_01_exp", maps\factory_audio::sfx_01_exp);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_02_exp", maps\factory_audio::sfx_02_exp);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_03_exp", maps\factory_audio::sfx_03_exp);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_04_exp", maps\factory_audio::sfx_04_exp);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_05_exp", maps\factory_audio::sfx_05_exp);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_06_exp", maps\factory_audio::sfx_06_exp);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_07_exp", maps\factory_audio::sfx_07_exp);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_08_exp", maps\factory_audio::sfx_08_exp);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_09_exp", maps\factory_audio::sfx_09_exp);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_10_exp", maps\factory_audio::sfx_10_exp);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_11_exp", maps\factory_audio::sfx_11_exp);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_car_impact", maps\factory_audio::sfx_car_impact);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_car_squeal", maps\factory_audio::sfx_car_squeal);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_plane01", maps\factory_audio::sfx_plane01);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_plane02", maps\factory_audio::sfx_plane02);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_plane03", maps\factory_audio::sfx_plane03);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_tower_1", maps\factory_audio::sfx_tower_1);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_big_tower_debris", maps\factory_audio::sfx_big_tower_debris);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_tower2_imp", maps\factory_audio::sfx_tower2_imp);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_tower2", maps\factory_audio::sfx_tower2);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_tower2_exp1", maps\factory_audio::sfx_tower2_exp1);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_tower2_exp2", maps\factory_audio::sfx_tower2_exp2);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_falling_exp", maps\factory_audio::sfx_falling_exp);
  level.scr_anim["het_cab"]["factory_car_chase"] = % factory_car_chase_het_cab;
  level.scr_anim["het_trailer"]["factory_car_chase"] = % factory_car_chase_het_trailer;
  maps\_anim::addnotetrack_customfunction("het_cab", "fx_exploder( chase_box_explosion_01 )", ::chase_rumble_small);
  maps\_anim::addnotetrack_customfunction("het_cab", "fx_exploder( chase_box_explosion_02 )", ::chase_rumble_small);
  maps\_anim::addnotetrack_customfunction("het_cab", "fx_exploder( chase_box_explosion_03 )", ::chase_rumble_small);
  maps\_anim::addnotetrack_customfunction("het_cab", "fx_exploder( chase_box_explosion_04 )", ::chase_rumble_small);
  maps\_anim::addnotetrack_customfunction("het_cab", "fx_exploder( chase_turn_dust_010 )", ::chase_rumble_small);
  maps\_anim::addnotetrack_customfunction("het_cab", "fx_exploder( chase_turn_dust_020 )", ::chase_rumble_small);
  maps\_anim::addnotetrack_customfunction("het_cab", "fx_exploder( chase_turn_dust_030 )", ::chase_rumble_small);
  maps\_anim::addnotetrack_customfunction("het_cab", "fx_exploder,chase_010", ::chase_rumble_big);
  maps\_anim::addnotetrack_customfunction("het_cab", "fx_exploder,chase_030", ::chase_rumble_big);
  maps\_anim::addnotetrack_customfunction("het_cab", "fx_chase_helicopter_explosion", ::chase_rumble_big);
  maps\_anim::addnotetrack_customfunction("het_cab", "fx_chase_warehouse_explosion", ::chase_rumble_big);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_07_exp", ::chase_rumble_big);
  maps\_anim::addnotetrack_customfunction("het_cab", "fx_exploder( chase_stack_ground_collision_01 )", ::chase_rumble_big);
  maps\_anim::addnotetrack_customfunction("het_cab", "fx_exploder( chase_stack_window_explosion )", ::chase_rumble_big);
  maps\_anim::addnotetrack_customfunction("het_cab", "sfx_tower_1_imp", ::chase_rumble_big);
  maps\_anim::addnotetrack_customfunction("het_cab", "fx_exploder( chase_stack_ground_collision_02 )", ::chase_rumble_bigger);
  maps\_anim::addnotetrack_customfunction("het_cab", "building01_swap", ::chase_rumble_bigger);
  level.scr_animtree["factory_car_chase_chopper02"] = #animtree;
  level.scr_anim["factory_car_chase_chopper02"]["factory_car_chase"] = % factory_car_chase_chopper02;
  level.scr_model["factory_car_chase_chopper02"] = "vehicle_nh90";
  level.scr_animtree["factory_car_chase_chopper03"] = #animtree;
  level.scr_anim["factory_car_chase_chopper03"]["factory_car_chase"] = % factory_car_chase_chopper03;
  level.scr_model["factory_car_chase_chopper03"] = "vehicle_nh90";
  level.scr_animtree["factory_car_chase_chopper04"] = #animtree;
  level.scr_anim["factory_car_chase_chopper04"]["factory_car_chase"] = % factory_car_chase_chopper04;
  level.scr_model["factory_car_chase_chopper04"] = "vehicle_nh90";
  level.scr_animtree["factory_car_chase_opfor_car01"] = #animtree;
  level.scr_anim["factory_car_chase_opfor_car01"]["factory_car_chase"] = % factory_car_chase_opfor_car01;
  level.scr_model["factory_car_chase_opfor_car01"] = "vehicle_iveco_lynx_iw6";
  maps\_anim::addnotetrack_customfunction("factory_car_chase_opfor_car01", "car_death", ::chase_kill_vehicle);
  level.scr_animtree["factory_car_chase_opfor_car02"] = #animtree;
  level.scr_anim["factory_car_chase_opfor_car02"]["factory_car_chase"] = % factory_car_chase_opfor_car02;
  level.scr_model["factory_car_chase_opfor_car02"] = "vehicle_iveco_lynx_iw6";
  maps\_anim::addnotetrack_customfunction("factory_car_chase_opfor_car02", "car_death", ::chase_kill_vehicle);
  maps\_anim::addnotetrack_customfunction("factory_car_chase_opfor_car02", "car_explode", ::chase_explode_vehicle);
  level.scr_animtree["factory_car_chase_opfor_car03"] = #animtree;
  level.scr_anim["factory_car_chase_opfor_car03"]["factory_car_chase"] = % factory_car_chase_opfor_car03;
  level.scr_model["factory_car_chase_opfor_car03"] = "vehicle_iveco_lynx_iw6";
  maps\_anim::addnotetrack_customfunction("factory_car_chase_opfor_car03", "car_death", ::chase_kill_vehicle);
  maps\_anim::addnotetrack_customfunction("factory_car_chase_opfor_car03", "car_explode", ::chase_explode_vehicle);
  level.scr_animtree["factory_car_chase_opfor_car04"] = #animtree;
  level.scr_anim["factory_car_chase_opfor_car04"]["factory_car_chase"] = % factory_car_chase_opfor_car04;
  level.scr_model["factory_car_chase_opfor_car04"] = "vehicle_iveco_lynx_iw6";
  maps\_anim::addnotetrack_customfunction("factory_car_chase_opfor_car04", "car_death", ::chase_kill_vehicle);
  maps\_anim::addnotetrack_customfunction("factory_car_chase_opfor_car04", "car_explode", ::chase_explode_vehicle);
  level.scr_animtree["factory_car_chase_opfor_car05"] = #animtree;
  level.scr_anim["factory_car_chase_opfor_car05"]["factory_car_chase"] = % factory_car_chase_opfor_car05;
  level.scr_model["factory_car_chase_opfor_car05"] = "vehicle_iveco_lynx_iw6";
  maps\_anim::addnotetrack_customfunction("factory_car_chase_opfor_car05", "car_death", ::chase_kill_vehicle);
  level.scr_animtree["factory_car_chase_opfor_car06"] = #animtree;
  level.scr_anim["factory_car_chase_opfor_car06"]["factory_car_chase"] = % factory_car_chase_opfor_car06;
  level.scr_model["factory_car_chase_opfor_car06"] = "vehicle_iveco_lynx_iw6";
  maps\_anim::addnotetrack_customfunction("factory_car_chase_opfor_car06", "car_death", ::chase_kill_vehicle);
  level.scr_animtree["factory_car_chase_opfor_car07"] = #animtree;
  level.scr_anim["factory_car_chase_opfor_car07"]["factory_car_chase"] = % factory_car_chase_opfor_car07;
  level.scr_model["factory_car_chase_opfor_car07"] = "vehicle_iveco_lynx_iw6";
  maps\_anim::addnotetrack_customfunction("factory_car_chase_opfor_car07", "car_death", ::chase_kill_vehicle);
  maps\_anim::addnotetrack_customfunction("factory_car_chase_opfor_car07", "car_explode", ::chase_explode_vehicle);
  level.scr_animtree["factory_car_chase_opfor_car08"] = #animtree;
  level.scr_anim["factory_car_chase_opfor_car08"]["factory_car_chase"] = % factory_car_chase_opfor_car08;
  level.scr_model["factory_car_chase_opfor_car08"] = "vehicle_iveco_lynx_iw6";
  maps\_anim::addnotetrack_customfunction("factory_car_chase_opfor_car08", "car_death", ::chase_kill_vehicle);
  level.scr_animtree["factory_car_chase_opfor_car09"] = #animtree;
  level.scr_anim["factory_car_chase_opfor_car09"]["factory_car_chase"] = % factory_car_chase_opfor_car09;
  level.scr_model["factory_car_chase_opfor_car09"] = "vehicle_iveco_lynx_iw6";
  level.scr_animtree["factory_car_chase_plane01"] = #animtree;
  level.scr_anim["factory_car_chase_plane01"]["factory_car_chase"] = % factory_car_chase_plane01;
  level.scr_model["factory_car_chase_plane01"] = "vehicle_b2_bomber";
  level.scr_animtree["factory_car_chase_plane02"] = #animtree;
  level.scr_anim["factory_car_chase_plane02"]["factory_car_chase"] = % factory_car_chase_plane02;
  level.scr_model["factory_car_chase_plane02"] = "vehicle_b2_bomber";
  level.scr_animtree["factory_car_chase_plane03"] = #animtree;
  level.scr_anim["factory_car_chase_plane03"]["factory_car_chase"] = % factory_car_chase_plane03;
  level.scr_model["factory_car_chase_plane03"] = "vehicle_b2_bomber";
}

dialog() {
  level.scr_radio["factory_mrk_theyredowncreeper11"] = "factory_mrk_theyredowncreeper11";
  level.scr_radio["factory_mrk_housemainwehave"] = "factory_mrk_housemainwehave";
  level.scr_radio["factory_hqr_rogerjerichomoveto"] = "factory_hqr_rogerjerichomoveto";
  level.scr_radio["factory_mrk_copythatapproachingentry"] = "factory_mrk_copythatapproachingentry";
  level.scr_radio["factory_mrk_jerichoatentrya"] = "factory_mrk_jerichoatentrya";
  level.scr_radio["factory_mrk_copymovingregroupfifty"] = "factory_mrk_copymovingregroupfifty";
  level.scr_radio["factory_mrk_weseeyoucreeper"] = "factory_mrk_weseeyoucreeper";
  level.scr_radio["factory_mrk_downweremoving"] = "factory_mrk_downweremoving";
  level.scr_radio["factory_mrk_oldboyandpickpeeloff"] = "factory_mrk_oldboyandpickpeeloff";
  level.scr_radio["factory_mrk_everyoneelseweremoving"] = "factory_mrk_everyoneelseweremoving";
  level.scr_radio["factory_mrk_allclearheshgrab"] = "factory_mrk_allclearheshgrab";
  level.scr_radio["factory_mrk_onthedoor"] = "factory_mrk_onthedoor";
  level.scr_radio["factory_hsh_cleartomove"] = "factory_hsh_cleartomove";
  level.scr_radio["factory_spa_takethemout"] = "factory_spa_takethemout";
  level.scr_radio["factory_vs1_trainsareclear"] = "factory_vs1_trainsareclear";
  level.scr_radio["factory_vs2_rogerpatrol"] = "factory_vs2_rogerpatrol";
  level.scr_radio["factory_vs3_movingtoloadingdocks"] = "factory_vs3_movingtoloadingdocks";
  level.scr_radio["factory_vs2_copythat"] = "factory_vs2_copythat";
  level.scr_radio["factory_bkr_twoapproaching"] = "factory_bkr_twoapproaching";
  level.scr_radio["factory_diz_gettingclose"] = "factory_diz_gettingclose";
  level.scr_radio["factory_bkr_gotthem"] = "factory_bkr_gotthem";
  level.scr_radio["factory_bkr_rookonyou"] = "factory_bkr_rookonyou";
  level.scr_radio["factory_kgn_theyredown"] = "factory_kgn_theyredown";
  level.scr_radio["factory_bkr_holdokaymoving"] = "factory_bkr_holdokaymoving";
  level.scr_radio["factory_bkr_okaymoving"] = "factory_bkr_okaymoving";
  level.scr_radio["factory_bkr_findout"] = "factory_bkr_findout";
  level.scr_radio["factory_bkr_maintainstealth"] = "factory_bkr_maintainstealth";
  level.scr_radio["factory_bkr_eyesandears"] = "factory_bkr_eyesandears";
  level.scr_radio["factory_bkr_yourewithme"] = "factory_bkr_yourewithme";
  level.scr_radio["factory_bkr_cleartogohot"] = "factory_bkr_cleartogohot";
  level.scr_radio["factory_bkr_targetsahead"] = "factory_bkr_targetsahead";
  level.scr_radio["factory_bkr_theyredown"] = "factory_bkr_theyredown";
  level.scr_radio["factory_bkr_moving"] = "factory_bkr_moving";
  level.scr_radio["factory_diz_tangos"] = "factory_diz_tangos";
  level.scr_radio["factory_diz_nice"] = "factory_diz_nice";
  level.scr_radio["factory_bkr_go"] = "factory_bkr_go";
  level.scr_radio["factory_kgn_tangosahead"] = "factory_kgn_tangosahead";
  level.scr_radio["factory_kgn_clear"] = "factory_kgn_clear";
  level.scr_radio["factory_kgn_roger"] = "factory_kgn_roger";
  level.scr_radio["factory_bkr_getatarget"] = "factory_bkr_getatarget";
  level.scr_radio["factory_bkr_throughhere"] = "factory_bkr_throughhere";
  level.scr_radio["factory_bkr_letsgo"] = "factory_bkr_letsgo";
  level.scr_radio["factory_diz_clear"] = "factory_diz_clear";
  level.scr_radio["factory_bkr_dropem"] = "factory_bkr_dropem";
  level.scr_radio["factory_bkr_goright"] = "factory_bkr_goright";
  level.scr_sound["opfor01"]["factory_sp1_miranomeimporta"] = "factory_sp1_miranomeimporta";
  level.scr_sound["opfor02"]["factory_sp2_peroyaterminaronlas"] = "factory_sp2_peroyaterminaronlas";
  level.scr_sound["opfor01"]["factory_sp1_ycuandosesupone"] = "factory_sp1_ycuandosesupone";
  level.scr_sound["opfor02"]["factory_sp2_elseorventuradijo"] = "factory_sp2_elseorventuradijo";
  level.scr_sound["opfor01"]["factory_sp1_puesesperoquelo"] = "factory_sp1_puesesperoquelo";
  level.scr_sound["opfor02"]["factory_sp2_yoandoigual"] = "factory_sp2_yoandoigual";
  level.scr_sound["opfor01"]["factory_sp1_quhoratienes"] = "factory_sp1_quhoratienes";
  level.scr_sound["opfor02"]["factory_sp2_dosymedia"] = "factory_sp2_dosymedia";
  level.scr_sound["opfor01"]["factory_sp1_putamadrenosquedan"] = "factory_sp1_putamadrenosquedan";
  level.scr_radio["factory_kgn_wholebattalion"] = "factory_kgn_wholebattalion";
  level.scr_radio["factory_kgn_ontop"] = "factory_kgn_ontop";
  level.scr_sound["ally_alpha"]["factory_bkr_gettocover"] = "factory_bkr_gettocover";
  level.scr_sound["ally_bravo"]["factory_diz_everywhere"] = "factory_diz_everywhere";
  level.scr_sound["ally_alpha"]["factory_bkr_extractionsmoke"] = "factory_bkr_extractionsmoke";
  level.scr_sound["ally_bravo"]["factory_diz_ready"] = "factory_diz_ready";
  level.scr_sound["ally_alpha"]["factory_bkr_popsmoke"] = "factory_bkr_popsmoke";
  level.scr_sound["ally_alpha"]["factory_bkr_gotothermals"] = "factory_bkr_gotothermals";
  level.scr_sound["ally_alpha"]["factory_bkr_totheoffices"] = "factory_bkr_totheoffices";
  level.scr_sound["ally_alpha"]["factory_bkr_targetleft"] = "factory_bkr_targetleft";
  level.scr_sound["ally_alpha"]["factory_bkr_targetright"] = "factory_bkr_targetright";
  level.scr_sound["ally_bravo"]["factory_diz_tangoleft"] = "factory_diz_tangoleft";
  level.scr_sound["ally_bravo"]["factory_diz_tangoright"] = "factory_diz_tangoright";
  level.scr_sound["elm_thunder_distant"] = "elm_thunder_distant";
  level.scr_sound["elm_thunder_strike"] = "elm_thunder_strike";
}

factory_introkill_jungle_player() {
  var_0 = common_scripts\utility::getstruct("drop_kill_node", "script_noteworthy");
  var_1 = maps\_utility::spawn_anim_model("foliage");
  level.player.active_anim = 1;
  level.player freezecontrols(1);
  level.player allowprone(0);
  level.player giveweapon("factory_knife");
  level.player switchtoweapon("factory_knife");
  level.player disableweapons();
  level.player setstance("crouch");
  var_2 = maps\_utility::spawn_anim_model("player_rig");
  var_2 hide();
  var_3 = [];
  var_3["player_rig"] = var_2;
  var_3["foliage"] = var_1;
  var_0 maps\_anim::anim_first_frame(var_3, "factory_intro_jungle_drop_player");
  var_4 = 0;
  level.player playerlinktoblend(var_2, "tag_player", 0.25, 0.15, 0.15);
  wait 0.25;
  level.player playerlinktodelta(var_2, "tag_player", 1, var_4, var_4, var_4, var_4, 1);
  var_2 show();
  wait 0.8;
  var_0 maps\_anim::anim_single(var_3, "factory_intro_jungle_drop_player");
  wait 1.5;
  level.player disableweaponswitch();
  level.player enableweapons();
  level.player thread maps\factory_audio::audio_plr_intro_knife_pullout();
  wait 0.75;
  level.player unlink();
  var_2 delete();
  level.player.active_anim = 0;
  level.player freezecontrols(0);
}

intro_chopper() {
  var_0 = maps\_vignette_util::vignette_vehicle_spawn("intro_chopper_spotlight_1", "intro_chopper");
  var_0 setCanDamage(1);
  var_1 = getent("factory_intro_chopper", "script_noteworthy");
  playFXOnTag(level._effect["spotlight_model_factory"], var_0, "tag_flash");
  var_0.has_spotlight = 1;
  var_0 thread maps\factory_intro::intro_animated_chopper_spotlight();
  var_0 thread maps\factory_intro::detect_player_shot();
  var_2 = [];
  var_2["intro_chopper"] = var_0;
  thread maps\factory_audio::sfx_intro_helicopter_and_splash(var_0);
  var_1 thread maps\_anim::anim_single(var_2, "factory_intro_jungle_spotlight_chopper");
  level.squad["ALLY_ALPHA"] maps\_utility::cqb_aim(var_0);
  common_scripts\utility::flag_wait("intro_start_slide");
  wait 1;
  stopFXOnTag(level._effect["spotlight_model_factory"], var_0, "tag_flash");
  var_0.has_spotlight = 0;
  common_scripts\utility::flag_wait("trig_intro_vignette");
  var_0 delete();
}

factory_intro_jungle_wallhop(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct("factory_intro_jungle_wallhop", "script_noteworthy");
  var_3 = [];
  var_3["wallhop_ally01"] = var_0;
  var_3["wallhop_ally02"] = var_1;
  var_2 maps\_anim::anim_single(var_3, "factory_intro_jungle_wallhop");
}

allies_enter_factory_cranes() {
  common_scripts\utility::flag_wait("card_swiped");
  var_0 = common_scripts\utility::getstruct("allies_enter_factory", "script_noteworthy");
  var_1 = maps\_utility::spawn_anim_model("factory_crane_rear");
  var_2 = maps\_utility::spawn_anim_model("factory_crane_rear_beam");
  var_3 = maps\_utility::spawn_anim_model("factory_allies_enter_factory_container01");
  var_4 = maps\_utility::spawn_anim_model("factory_allies_enter_factory_container02");
  var_5 = setup_crane_beam();
  var_5.origin = var_2.origin;
  var_5 linkto(var_2, "tag_origin", (0, 0, -140), (0, 0, 0));
  var_6 = getent("fac_ent_container_01", "targetname");
  var_6.origin = var_3.origin;
  var_6 linkto(var_3);
  var_7 = getent("fac_ent_container_02", "targetname");
  var_7.origin = var_4.origin;
  var_7 linkto(var_4);
  playFXOnTag(level._effect["glow_red_light_100_blinker_nolight"], var_1, "tag_light_01");
  playFXOnTag(level._effect["glow_red_light_100_blinker_nolight"], var_1, "tag_light_02");
  wait 0.05;
  playFXOnTag(level._effect["glow_red_light_100_blinker_nolight"], var_1, "tag_light_03");
  playFXOnTag(level._effect["glow_red_light_100_blinker_nolight"], var_1, "tag_light_04");
  var_8 = [];
  var_8["factory_crane_rear"] = var_1;
  var_8["factory_crane_rear_beam"] = var_2;
  var_8["factory_allies_enter_factory_container01"] = var_3;
  var_8["factory_allies_enter_factory_container02"] = var_4;
  var_0 thread maps\_anim::anim_single(var_8, "allies_enter_factory_cranes");
}

setup_crane_beam() {
  var_0 = getent("reveal_crane_org", "targetname");
  var_1 = [];
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
  var_3 linkto(var_0);
  }

  var_5 = getent("beam_light_01", "script_noteworthy");

  if(isDefined(var_5)) {
    var_6 = var_5 common_scripts\utility::spawn_tag_origin();
    var_6.origin = var_5.origin;
    var_6 linkto(var_0);
    playFXOnTag(level._effect["glow_red_light_100_blinker"], var_6, "tag_origin");
  }

  var_5 = getent("beam_light_02", "script_noteworthy");

  if(isDefined(var_5)) {
    var_6 = var_5 common_scripts\utility::spawn_tag_origin();
    var_6.origin = var_5.origin;
    var_6 linkto(var_0);
    playFXOnTag(level._effect["glow_red_light_100_blinker"], var_6, "tag_origin");
  }

  return var_0;
}

allies_enter_factory_ally01_spawn() {
  var_0 = maps\_vignette_util::vignette_actor_spawn("allies_enter_factory_ally01", "ally01");
  allies_enter_factory_ally01(var_0);
  var_0 maps\_vignette_util::vignette_actor_delete();
}

allies_enter_factory_ally01(var_0) {
  var_1 = common_scripts\utility::getstruct("allies_enter_factory", "script_noteworthy");
  var_2 = [];
  var_2["ally01"] = var_0;
  var_1 maps\_anim::anim_single(var_2, "allies_enter_factory_ally01");
}

allies_enter_factory_ally02_spawn() {
  var_0 = maps\_vignette_util::vignette_actor_spawn("allies_enter_factory_ally02", "ally02");
  allies_enter_factory_ally02(var_0);
  var_0 maps\_vignette_util::vignette_actor_delete();
}

allies_enter_factory_ally02(var_0) {
  var_1 = common_scripts\utility::getstruct("allies_enter_factory", "script_noteworthy");
  var_2 = [];
  var_2["ally02"] = var_0;
  var_1 maps\_anim::anim_single(var_2, "allies_enter_factory_ally02");
}

conveyor_system() {
  var_0 = getent("conveyor_belt_anim_node", "targetname");
  var_1 = maps\_utility::spawn_anim_model("factory_conveyor_system_lanea");
  var_2 = maps\_utility::spawn_anim_model("factory_conveyor_system_laneb");
  var_0 thread maps\_anim::anim_first_frame_solo(var_1, "factory_conveyor_system_lanea_single");
  var_0 thread maps\_anim::anim_first_frame_solo(var_2, "factory_conveyor_system_laneb_single");
  var_1 thread conveyor_system_link_crates("conveyor_crate", 21);
  var_2 thread conveyor_system_link_crates("conveyor_crate", 27);
  var_0 thread maps\_anim::anim_loop_solo(var_1, "factory_conveyor_system_lanea", "stop_loop");
  var_0 thread maps\_anim::anim_loop_solo(var_2, "factory_conveyor_system_laneb", "stop_loop");
  var_3 = maps\_utility::spawn_anim_model("factory_conveyor_system_lanea");
  var_4 = maps\_utility::spawn_anim_model("factory_conveyor_system_laneb");
  var_0 thread maps\_anim::anim_first_frame_solo(var_3, "factory_conveyor_system_lanea_single");
  var_0 thread maps\_anim::anim_first_frame_solo(var_4, "factory_conveyor_system_laneb_single");
  var_3 thread conveyor_system_link_crates("conveyor_crate", 21);
  var_4 thread conveyor_system_link_crates("conveyor_crate", 27);
  var_5 = maps\_utility::spawn_anim_model("factory_conveyor_system_lanea");
  var_6 = maps\_utility::spawn_anim_model("factory_conveyor_system_laneb");
  var_0 thread maps\_anim::anim_first_frame_solo(var_5, "factory_conveyor_system_lanea_single");
  var_0 thread maps\_anim::anim_first_frame_solo(var_6, "factory_conveyor_system_laneb_single");
  var_5 thread conveyor_system_link_crates("conveyor_crate", 21);
  var_6 thread conveyor_system_link_crates("conveyor_crate", 27);
  wait 37;
  var_0 thread maps\_anim::anim_loop_solo(var_3, "factory_conveyor_system_lanea", "stop_loop");
  var_0 thread maps\_anim::anim_loop_solo(var_4, "factory_conveyor_system_laneb", "stop_loop");
  wait 37;
  var_0 thread maps\_anim::anim_loop_solo(var_5, "factory_conveyor_system_lanea", "stop_loop");
  var_0 thread maps\_anim::anim_loop_solo(var_6, "factory_conveyor_system_laneb", "stop_loop");
  common_scripts\utility::flag_wait("presat_revolving_door_closed");
  var_0 notify("stop_loop");
  var_1 delete();
  var_2 delete();
  var_3 delete();
  var_4 delete();
  var_5 delete();
  var_6 delete();
}

conveyor_system_link_crates(var_0, var_1) {
  var_2 = [];
  var_3 = level.scr_model[self.animname];
  var_4 = getnumparts(var_3);

  for(var_5 = 0; var_5 < var_1; var_5++) {
    var_6 = getpartname(var_3, var_5);
    thread maps\factory_audio::audio_crate_move(var_6);

    if(getsubstr(var_6, 0, 4) == "tank") {
      var_7 = spawn("script_model", self gettagorigin(var_6));
      var_7 setModel("shipping_frame_boxes");
      var_7.angles = self gettagangles(var_6);
      var_7 linkto(self, var_6);

      if(isDefined(var_0)) {
        var_7.targetname = var_0;
      }

      var_2[var_2.size] = var_7;
      common_scripts\utility::waitframe();
    }
  }

  common_scripts\utility::flag_wait("presat_revolving_door_closed");

  foreach(var_9 in var_2) {
  var_9 delete();
  }
}

rogers_hall_kill(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct("rogers_hall_kill", "script_noteworthy");
  var_3 = [];
  var_3["ally"] = var_0;
  var_3["opfor"] = var_1;
  var_2 maps\_anim::anim_single(var_3, "rogers_hall_kill");
}

baker_lower_hall_kill(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct("baker_lower_hall_kill", "script_noteworthy");
  var_3 = [];
  var_3["ally"] = var_0;
  var_3["opfor"] = var_1;
  var_2 maps\_anim::anim_single(var_3, "baker_lower_hall_kill");
}

rest_area_kills(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct("rest_area_kills", "script_noteworthy");
  var_3 = maps\_utility::spawn_anim_model("chair_opfor01");
  var_4 = maps\_utility::spawn_anim_model("chair_opfor02");
  var_5 = [];
  var_5["opfor01"] = var_0;
  var_5["opfor02"] = var_1;
  var_5["chair_opfor01"] = var_3;
  var_5["chair_opfor02"] = var_4;
  var_2 maps\_anim::anim_single(var_5, "rest_area_kills");
}

console_kill(var_0) {
  var_1 = common_scripts\utility::getstruct("console_kill", "script_noteworthy");
  var_2 = [];
  var_2["opfor"] = var_0;
  var_1 maps\_anim::anim_single(var_2, "console_kill");
}

keegan_top_stairway_kill(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct("keegan_top_stairway_kill", "script_noteworthy");
  var_3 = [];
  var_3["ally"] = var_0;
  var_3["opfor"] = var_1;
  var_2 maps\_anim::anim_single(var_3, "keegan_top_stairway_kill");
}

last_patrol_kill(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct("last_patrol_kill", "script_noteworthy");
  var_3 = [];
  var_3["opfor01"] = var_0;
  var_3["ally01"] = var_1;
  var_2 maps\_anim::anim_single(var_3, "last_patrol_kill");
}

throat_stab_npc(var_0) {
  start_death(var_0);
}

throat_stab_player(var_0) {
  level.player playrumbleonentity("artillery_rumble");

  if(isDefined(level.sleeping_guard)) {
    level.sleeping_guard dropweapon(level.sleeping_guard.weapon, "right", 0);
    level.sleeping_guard maps\_utility::gun_remove();
  }

  playFXOnTag(level._effect["factory_intro_stab_blood_ally"], var_0, "tag_knife_fx");
}

start_death(var_0) {
  level.sleeping_guard dropweapon(level.sleeping_guard.weapon, "right", 0);
  level.sleeping_guard maps\_utility::gun_remove();
}

break_area_grab_gun(var_0) {
  var_0 notify("grab_gun");
}

presat_door_open() {
  var_0 = getent("presat_entrance_anim_node", "targetname");
  var_1 = [];
  var_1["ally_alpha"] = level.squad["ALLY_ALPHA"];
  var_1["ally_bravo"] = level.squad["ALLY_BRAVO"];
  var_1["ally_charlie"] = level.squad["ALLY_CHARLIE"];
  common_scripts\utility::flag_wait("presat_revolving_door_dialog_done");
  var_0 maps\_anim::anim_single(var_1, "presat_door_arrive");
  thread maps\factory_audio::sfx_revolving_door_unlock(level.presat_door);
  maps\_utility::delaythread(1.33, common_scripts\utility::flag_set, "presat_open_revolving_door");
  level.squad["ALLY_ALPHA"] thread presat_door_open_individual(var_0, 0.12, "presat_allies_enter_alpha");
  level.squad["ALLY_BRAVO"] thread presat_door_open_individual(var_0, 0.1, "presat_allies_enter_bravo");
  level.squad["ALLY_CHARLIE"] presat_door_open_individual(var_0, 0.1, "presat_allies_enter_charlie");
  common_scripts\utility::flag_set("presat_door_anim_done");
}

presat_door_open_individual(var_0, var_1, var_2) {
  self setgoalpos(self.origin);
  maps\_utility::enable_ai_color_dontmove();
  var_0 maps\_anim::anim_single_solo(self, "presat_door_enter", undefined);
  maps\factory_util::safe_trigger_by_targetname(var_2);
}

sat_room_alpha_typing() {
  var_0 = getent("sat_typing_node_01", "targetname");
  var_0 maps\_anim::anim_reach_solo(self, "factory_SATroom_ally01_standIdle_enter");
  var_0 maps\_anim::anim_single_solo(self, "factory_SATroom_ally01_standIdle_enter");
  var_0 thread maps\_anim::anim_loop_solo(self, "factory_SATroom_ally01_standIdle_loop", "stop_idle");
  common_scripts\utility::flag_wait("sat_room_bridge_down");
  wait 0.1;
  var_0 notify("stop_idle");
  var_0 maps\_anim::anim_single_solo(self, "factory_SATroom_ally01_standIdle_exit");
  maps\_utility::enable_ai_color();
}

sat_room_bravo_typing_01() {
  var_0 = getent("sat_typing_node_01", "targetname");
  var_0 maps\_anim::anim_reach_solo(self, "factory_SATroom_ally02_consoletyping_enter");
  var_0 maps\_anim::anim_single_solo(self, "factory_SATroom_ally02_consoletyping_enter");
  var_0 thread maps\_anim::anim_loop_solo(self, "factory_SATroom_ally02_consoletyping_loop", "stop_idle");
  common_scripts\utility::flag_wait("sat_room_bridge_down");
  wait 0.1;
  var_0 notify("stop_idle");
  var_0 maps\_anim::anim_single_solo(self, "factory_SATroom_ally02_consoletyping_exit");
  maps\_utility::enable_ai_color();
}

sat_room_bravo_typing_02() {
  var_0 = getent("sat_typing_node_03", "targetname");
  var_0 maps\_anim::anim_reach_solo(self, "sat_room_bravo_computer_02");
  var_0 thread maps\_anim::anim_loop_solo(self, "sat_room_bravo_computer_02", "stop_idle");
  common_scripts\utility::flag_wait("sat_room_continue");
  var_0 notify("stop_idle");
  wait 0.1;
  maps\_utility::enable_ai_color();
}

reveal_room_exit_door() {
  var_0 = getent("assembly_floor_open_node", "targetname");
  level.assembly_room_door.animname = "assembly_floor_door";
  level.assembly_room_door maps\_utility::assign_animtree();
  var_1 = [];
  var_1["ALLY_ALPHA"] = level.squad["ALLY_ALPHA"];
  var_1["ALLY_CHARLIE"] = level.squad["ALLY_CHARLIE"];
  var_1["assembly_floor_door"] = level.assembly_room_door;
  common_scripts\utility::flag_wait("reveal_room_player_at_exit");
  level.assembly_room_door.connector connectpaths();
  thread maps\factory_audio::greenlight_amb_change();
  var_0 maps\_anim::anim_single(var_1, "factory_assembly_floor_open_door");
  level.squad["ALLY_ALPHA"] maps\_utility::enable_ai_color();
  level.squad["ALLY_BRAVO"] maps\_utility::enable_ai_color();
  level.assembly_room_door.connector disconnectpaths();
}

ambush_get_on_computer_player_nag() {
  var_0 = common_scripts\utility::getstruct("ambush_anim_node", "script_noteworthy");
  var_0 maps\_anim::anim_reach_solo(self, "tell_player_get_data");
  var_0 thread maps\_anim::anim_loop_solo(self, "tell_player_get_data");
  common_scripts\utility::flag_wait("ambush_triggered");
  self stopanimscripted();
  var_0 notify("stop_loop");
  maps\_utility::enable_ai_color();
}

ambush_bravo_computer_use() {
  var_0 = maps\_utility::spawn_anim_model("desk_chair");
  var_1 = maps\_utility::spawn_anim_model("desk_phone");
  var_2 = maps\_utility::spawn_anim_model("desk_book01");
  var_3 = maps\_utility::spawn_anim_model("desk_book02");
  var_4 = maps\_utility::spawn_anim_model("desk_book03");
  var_5 = maps\_utility::spawn_anim_model("desk_book04");
  var_6 = maps\_utility::spawn_anim_model("desk_book05");
  var_7 = maps\_utility::spawn_anim_model("desk_book06");
  var_8 = maps\_utility::spawn_anim_model("desk_book07");
  var_9 = maps\_utility::spawn_anim_model("desk_keyboard");
  var_10 = [];
  var_10["desk_chair"] = var_0;
  var_10["desk_phone"] = var_1;
  var_10["desk_book01"] = var_2;
  var_10["desk_book02"] = var_3;
  var_10["desk_book03"] = var_4;
  var_10["desk_book04"] = var_5;
  var_10["desk_book05"] = var_6;
  var_10["desk_book06"] = var_7;
  var_10["desk_book07"] = var_8;
  var_10["desk_keyboard"] = var_9;
  var_11 = common_scripts\utility::getstruct("desk_search_bravo_node", "script_noteworthy");
  var_11 maps\_anim::anim_first_frame(var_10, "ambush_bravo_desk_search");
  var_12 = getent("desk_search_anim_collision", "targetname");
  var_13 = getent("desk_search_anim_collision_post", "targetname");
  var_13 notsolid();
  common_scripts\utility::flag_wait("entered_pre_ambush_room");
  var_11 maps\_anim::anim_reach_solo(self, "ambush_bravo_desk_search");
  var_10["ally_bravo"] = self;
  thread maps\factory_audio::sfx_keegan_desk();
  var_0 thread desk_search_chair(var_12, var_13);
  var_11 maps\_anim::anim_single(var_10, "ambush_bravo_desk_search");
  var_11 = common_scripts\utility::getstruct("desk_search_bravo_node", "script_noteworthy");
  var_11 thread maps\_anim::anim_loop_solo(self, "bravo_typing");
  common_scripts\utility::flag_wait("ambush_start_fx");
  self stopanimscripted();
  var_11 notify("stop_loop");
  maps\_utility::enable_ai_color();
}

desk_search_chair(var_0, var_1) {
  var_0 linkto(self, "tag_chair_collision");
  wait 2.0;
  var_2 = getent("desk_search_physics_source", "targetname");
  physicsexplosionsphere(var_2.origin, 15, 1, 0.5);
  wait 2.0;
  var_3 = getent("ambush_desk_search_buffer", "targetname");
  var_3 notsolid();
  var_3 delete();
  var_4 = self.origin;

  while(maps\_utility::players_within_distance(64, var_4)) {
    wait 1.0;
  }

  var_0 unlink();
  var_0 notsolid();
  var_0 delete();
  var_1 solid();
}

ambush_charlie_computer_use() {
  var_0 = common_scripts\utility::getstruct("ambush_anim_node", "script_noteworthy");
  var_0 maps\_anim::anim_reach_solo(self, "ambush_charlie_desk_search");

  if(common_scripts\utility::flag("ambush_triggered")) {
    self stopanimscripted();
    var_0 notify("stop_loop");
    maps\_utility::enable_ai_color();
    return;
  }

  var_0 maps\_anim::anim_single_solo(self, "ambush_charlie_desk_search");

  if(common_scripts\utility::flag("ambush_triggered")) {
    self stopanimscripted();
    var_0 notify("stop_loop");
    maps\_utility::enable_ai_color();
    return;
  }

  var_0 = common_scripts\utility::getstruct("ambush_anim_node", "script_noteworthy");
  var_0 thread maps\_anim::anim_loop_solo(self, "charlie_typing");
  common_scripts\utility::flag_wait("ambush_triggered");
  self stopanimscripted();
  var_0 notify("stop_loop");
  maps\_utility::enable_ai_color();
}

ambush_loop_flashbang_react(var_0, var_1) {
  level endon("ambush_start_fx");
  level endon("stop_flashbang_react");

  for(;;) {
    if(common_scripts\utility::flag("player_used_computer")) {
      return;
    }
    self waittill("flashbang", var_2, var_3, var_4, var_5);
    waittillframeend;
    var_6 = 0;

    if(!isDefined(self.flashendtime)) {
      continue;
    }
    else {
      var_7 = self.flashendtime - gettime();
      var_6 = var_7 / 1000 + 0.25;

      if(var_6 < 0.5) {
        continue;
      }
    }

    self stopanimscripted();
    var_0 notify("stop_loop");
    self notify("flashbang", var_2, var_3, var_4, var_5);
    wait(var_6);
    var_0 maps\_anim::anim_reach_solo(self, var_1);
    var_0 thread maps\_anim::anim_loop_solo(self, var_1, "stop_loop");
    wait 0.25;
  }
}

ambush() {
  var_0 = common_scripts\utility::getstruct("ambush_anim_node", "script_noteworthy");
  level thread ambush_player(var_0);
  level thread ambush_ally(var_0);
  level thread ambush_enemies(var_0);
  level thread ambush_props(var_0);
  level thread ambush_door(var_0);
}

ambush_anim_setup() {
  var_0 = common_scripts\utility::getstruct("ambush_anim_node", "script_noteworthy");
  var_1 = getent("factory_ambush_desk", "targetname");
  var_1.animname = "factory_ambush_desk";
  var_1 maps\_utility::assign_animtree();
  var_2 = maps\_utility::spawn_anim_model("factory_ambush_mouse01");
  var_3 = maps\_utility::spawn_anim_model("factory_ambush_mouse02");
  var_4 = maps\_utility::spawn_anim_model("factory_ambush_keyboard01");
  var_5 = maps\_utility::spawn_anim_model("factory_ambush_keyboard02");
  var_6 = maps\_utility::spawn_anim_model("factory_ambush_clipboard");
  var_7 = maps\_utility::spawn_anim_model("factory_ambush_cup");
  var_8 = maps\_utility::spawn_anim_model("factory_ambush_computer");
  var_9 = maps\_utility::spawn_anim_model("factory_ambush_monitor01");
  var_10 = maps\_utility::spawn_anim_model("factory_ambush_monitor02");
  level.factory_ambush_props = [];
  level.factory_ambush_props["factory_ambush_desk"] = var_1;
  level.factory_ambush_props["factory_ambush_mouse01"] = var_2;
  level.factory_ambush_props["factory_ambush_mouse02"] = var_3;
  level.factory_ambush_props["factory_ambush_keyboard01"] = var_4;
  level.factory_ambush_props["factory_ambush_keyboard02"] = var_5;
  level.factory_ambush_props["factory_ambush_clipboard"] = var_6;
  level.factory_ambush_props["factory_ambush_cup"] = var_7;
  level.factory_ambush_props["factory_ambush_computer"] = var_8;
  level.factory_ambush_props["factory_ambush_monitor01"] = var_9;
  level.factory_ambush_props["factory_ambush_monitor02"] = var_10;
  var_0 maps\_anim::anim_first_frame(level.factory_ambush_props, "ambush_props");
  var_11 = getent("ambush_breach_monitor_screen", "targetname");
  var_11 linkto(var_9);
  thread maps\factory_fx::fx_assembly_monitor_bink_init();
  common_scripts\utility::flag_wait("enable_ambush_use");
  var_12 = spawn("script_model", var_9.origin);
  var_12.angles = var_9.angles;
  var_12 setModel("factory_ambush_monitor_obj");
  common_scripts\utility::waitframe();
  var_9 hide();
  var_13 = spawn("script_model", var_4.origin);
  var_13.angles = var_4.angles;
  var_13 setModel("fac_keyboard_obj");
  common_scripts\utility::flag_wait("player_used_computer");
  var_9 show();
  var_12 delete();
  var_13 delete();
}

ambush_player(var_0) {
  level.player.active_anim = 1;
  level.player freezecontrols(1);
  level.player disableweapons();
  level.player.ignoreme = 1;
  thread change_dof();
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  var_1 = maps\_utility::spawn_anim_model("player_rig");
  var_1 hide();
  var_2 = [];
  var_2["player_rig"] = var_1;
  var_0 maps\_anim::anim_first_frame(var_2, "ambush_player");
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  level.player playerlinktoblend(var_1, "tag_player", 0.5, 0.25, 0.25);
  thread maps\factory_audio::ambush_start_intro_foley_sfx();
  wait 0.5;
  level.player playerlinktodelta(var_1, "tag_player", 1, var_3, var_4, var_5, var_6, 1);
  var_1 show();
  level notify("play_ambush_anim");
  var_0 maps\_anim::anim_single(var_2, "ambush_player");
  level notify("ambush_player_unlinked");
  level.player unlink();
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  var_1 hide();
  level waittill("ambush_door_breached");
  level.player disableweapons();
  level.player allowcrouch(0);
  level.player setstance("stand");

  if(common_scripts\utility::flag("player_in_desk_area")) {
    level.player freezecontrols(1);
    var_0 maps\_anim::anim_first_frame(var_2, "ambush_player_knockback");
    level.player playerlinktoblend(var_1, "tag_player", 0.25, 0.25, 0.25);
    wait 0.25;
    level.player playerlinktodelta(var_1, "tag_player", 1, var_3, var_4, var_5, var_6, 1);
    var_1 show();
    var_0 thread maps\_anim::anim_single(var_2, "ambush_player_knockback");
    wait 1;
    level.player enableweapons();
    var_1 hide();
    wait 2.5;
    var_1 delete();
  } else {
    var_7 = getent("ambush_breach_physics_push", "targetname");
    var_8 = level.player.origin + (0, 0, 16) - var_7.origin;
    var_8 = vectornormalize(var_8);
    var_9 = vectortoangles(-1 * var_8);
    var_8 = var_8 * 100;
    level.player pushplayervector(var_8, 1);
    thread player_hit_wall();
    level common_scripts\utility::waittill_notify_or_timeout("player_hit_wall", 0.25);
    level.player setstance("prone");
    level.player enableweapons();
    level.player pushplayervector((0, 0, 0), 1);
    wait 0.25;
  }

  level.player freezecontrols(0);
  level.player.active_anim = 0;
  level.player unlink();
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player allowstand(1);
  level.player allowjump(1);
  wait 1.3;
  level.player.ignoreme = 0;
}

player_hit_wall() {
  var_0 = 0.1;
  level endon("player_hit_wall");
  wait 0.05;

  for(;;) {
    var_1 = level.player.origin;
    wait 0.01;
    var_2 = level.player.origin;
    var_3 = distance(var_1, var_2);

    if(var_3 < var_0) {
      level notify("player_hit_wall");
    }
  }
}

change_dof() {
  maps\_art::dof_enable_script(0, 0, 4, 55, 120, 1.5, 0.25);
  level waittill("ambush_player_unlinked");
  maps\_art::dof_disable_script(1.25);
  level waittill("ambush_door_breached");
  maps\_art::dof_enable_script(0, 100, 10, 100, 1000, 0, 0.25);
  wait 1.0;
  maps\_art::dof_disable_script(1.25);
}

change_dof_jungle_intro() {
  maps\_art::dof_enable_script(0, 0, 4, 0, 100, 1, 0.15);
  wait 1.233;
  maps\_art::dof_enable_script(0, 0, 4, 300, 500, 1, 0.25);
  wait 3.0;
  maps\_art::dof_enable_script(0, 0, 4, 100, 450, 1.5, 0.25);
  wait 1.67;
  maps\_art::dof_disable_script(1.25);
}

ambush_ally(var_0) {
  var_0 thread maps\_anim::anim_first_frame_solo(level.squad["ALLY_ALPHA"], "ambush_ally01");
  var_0 thread maps\_anim::anim_first_frame_solo(level.squad["ALLY_CHARLIE"], "ambush_ally02");
  level waittill("play_ambush_anim");
  var_0 thread maps\_anim::anim_single_solo(level.squad["ALLY_ALPHA"], "ambush_ally01");
  var_0 thread maps\_anim::anim_single_solo(level.squad["ALLY_CHARLIE"], "ambush_ally02");
}

ambush_enemies(var_0) {
  var_1 = getEntArray("ambush_anim_breachers", "targetname");
  var_2 = [];
  var_3 = maps\_utility::spawn_anim_model("factory_ambush_opfor02_rope");
  var_4 = maps\_utility::spawn_anim_model("factory_ambush_opfor03_rope");
  var_5 = maps\_utility::spawn_anim_model("factory_ambush_opfor04_rope");
  var_0 thread maps\_anim::anim_first_frame_solo(var_3, "ambush_props");
  var_0 thread maps\_anim::anim_first_frame_solo(var_4, "ambush_props");
  var_0 thread maps\_anim::anim_first_frame_solo(var_5, "ambush_props");
  level waittill("play_ambush_anim");

  foreach(var_9, var_7 in var_1) {
    var_8 = var_7 maps\_utility::spawn_ai(1);
    var_8.animname = "generic";
    var_8.goalradius = 0;
    var_8.allowdeath = 1;
    var_8.favoriteenemy = level.player;
    var_8.ignoreme = 1;
    var_8.threatbias = 5000;
    var_8 maps\_utility::delaythread(11, maps\factory_util::factory_set_ignoreme, 0);
    var_2[var_2.size] = var_8;
    var_8 maps\_utility::enable_cqbwalk();
  }

  var_0 thread maps\_anim::anim_single_solo(var_2[0], "ambush_enemy01");
  var_0 maps\_utility::delaythread(0.88, maps\_anim::anim_single_solo, var_2[1], "ambush_enemy02");
  var_0 maps\_utility::delaythread(0.88, maps\_anim::anim_single_solo, var_3, "ambush_props");
  var_0 maps\_utility::delaythread(0.05, maps\_anim::anim_single_solo, var_2[2], "ambush_enemy03");
  var_0 maps\_utility::delaythread(0.05, maps\_anim::anim_single_solo, var_4, "ambush_props");
  var_0 maps\_utility::delaythread(0.4, maps\_anim::anim_single_solo, var_2[3], "ambush_enemy04");
  var_0 maps\_utility::delaythread(0.4, maps\_anim::anim_single_solo, var_5, "ambush_props");
  common_scripts\utility::flag_wait("ambush_vignette_done");
  wait 4.0;

  foreach(var_8 in var_2) {
    if(isDefined(var_8) && isalive(var_8)) {
      var_8.health = 1;
      var_8.ignoreme = 0;
      var_8.threatbias = 10000;
    }
  }

  if(isDefined(var_2[1])) {
    level.squad["ALLY_ALPHA"].favoriteenemy = var_2[1];
  }

  if(isDefined(var_2[2])) {
    level.squad["ALLY_BRAVO"].favoriteenemy = var_2[2];
  }

  if(isDefined(var_2[3])) {
    level.squad["ALLY_CHARLIE"].favoriteenemy = var_2[3];
  }
}

debugline(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_3 * 20; var_4++) {
    wait 0.05;
  }
}

ambush_props(var_0) {
  var_1 = getEntArray("ambush_window_mantle", "targetname");

  foreach(var_3 in var_1) {
  var_3 movez(100, 0.1);
  }

  var_5 = maps\_utility::spawn_anim_model("factory_ambush_usb_stick");
  var_6["factory_ambush_usb_stick"] = var_5;
  var_0 maps\_anim::anim_first_frame(var_6, "ambush_props");
  var_7 = getent("ambush_breach_player_pda", "targetname");
  var_7 show();
  var_7 linkto(var_5);
  level waittill("play_ambush_anim");
  var_8 = maps\_utility::array_merge(level.factory_ambush_props, var_6);
  var_0 thread maps\_anim::anim_single(var_8, "ambush_props");
  level waittill("ambush_door_breached");
  thread ambush_manage_desk_collision();
  var_9 = getEntArray("ambush_desk_prop_pre", "targetname");

  foreach(var_11 in var_9) {
    if(isDefined(var_11.script_parameters)) {
      var_11 connectpaths();
      var_11 notsolid();
    }

    var_11 delete();
  }

  var_13 = getent("ambush_breach_monitor_screen", "targetname");
  var_13 delete();
  var_14 = getEntArray("ambush_breach_wall_screen", "targetname");

  foreach(var_16 in var_14) {
  var_16 delete();
  }

  level.factory_ambush_props["factory_ambush_monitor01"] setModel("com_pc_monitor_a");
  level.factory_ambush_props["factory_ambush_monitor02"] setModel("com_pc_monitor_a");
  var_7 delete();
  var_5 delete();
  waittillframeend;
  maps\factory_util::safe_trigger_by_targetname("ambush_intro_ally_take_cover");
}

ambush_manage_desk_collision() {
  var_0 = getEntArray("ambush_desk_pre", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_parameters)) {
      var_2 connectpaths();
      var_2 notsolid();
    }

    var_2 delete();
  }

  common_scripts\utility::flag_waitopen("player_in_desk_area");
  var_4 = getEntArray("ambush_desk_post", "targetname");

  foreach(var_2 in var_4) {
    var_2 show();

    if(isDefined(var_2.script_parameters)) {
      var_2 solid();
      var_2 disconnectpaths();
    }
  }
}

ambush_door(var_0) {
  var_1 = maps\_utility::spawn_anim_model("factory_ambush_door");
  var_2 = maps\_utility::spawn_anim_model("factory_ambush_tv");
  var_3 = maps\_utility::spawn_anim_model("factory_ambush_wall_debris");
  var_4 = maps\_utility::spawn_anim_model("factory_ambush_airduct_01");
  var_5 = maps\_utility::spawn_anim_model("factory_ambush_airduct_02");
  var_6 = [];
  var_6["factory_ambush_door"] = var_1;
  var_6["factory_ambush_tv"] = var_2;
  var_6["factory_ambush_wall_debris"] = var_3;
  var_6["factory_ambush_airduct_01"] = var_4;
  var_6["factory_ambush_airduct_02"] = var_5;
  level waittill("ambush_door_breached");
  var_0 maps\_anim::anim_first_frame(var_6, "ambush_props");
  var_0 maps\_anim::anim_single(var_6, "ambush_props");
}

ambush_cables(var_0) {
  var_1 = maps\_utility::spawn_anim_model("factory_ambush_ceiling_cables_01");
  var_2 = maps\_utility::spawn_anim_model("factory_ambush_ceiling_cables_02");
  var_3 = maps\_utility::spawn_anim_model("factory_ambush_ceiling_cables_03");
  level.assembly_ceiling_cables = [];
  level.assembly_ceiling_cables["factory_ambush_ceiling_cables_01"] = var_1;
  level.assembly_ceiling_cables["factory_ambush_ceiling_cables_02"] = var_2;
  level.assembly_ceiling_cables["factory_ambush_ceiling_cables_03"] = var_3;
  var_0 maps\_anim::anim_first_frame(level.assembly_ceiling_cables, "ambush_props");
  level waittill("ambush_door_breached");
  var_0 maps\_anim::anim_single(level.assembly_ceiling_cables, "ambush_props");
}

ambush_notify_start_fx(var_0) {
  common_scripts\utility::flag_set("ambush_start_fx");
}

ambush_notify_start_slomo(var_0) {
  level notify("ambush_door_breached");
  var_1 = getEntArray("ambush_breach_prop_pre", "targetname");

  foreach(var_3 in var_1) {
  var_3 delete();
  }

  var_5 = getent("ambush_breach_physics_push", "targetname");
  physicsexplosionsphere(var_5.origin, 250, 100, 1);
  radiusdamage(var_5.origin, 150, 25, 1);
}

ambush_notify_glass_break(var_0) {
  level notify("ambush_glass_break");
}

ambush_fastrope_do_anim(var_0, var_1, var_2, var_3) {
  var_2 = var_2 * 1.0;
  var_3 = var_3 * 1.0;
  wait(randomfloatrange(var_2, var_3));
  var_4 = self;
  var_5 = getent(var_0, "targetname");
  var_6 = spawn("script_model", (0, 0, 0));
  var_6 setModel("weapon_rappel_rope_long");
  var_6.origin = var_5.origin;
  var_6.animname = "rope";
  var_6 maps\_utility::assign_animtree();
  var_4.animname = "generic";
  var_7 = [];
  var_7["generic"] = var_4;
  var_7["rope"] = var_6;
  var_5 maps\_anim::anim_single(var_7, "bravo_rappel_drop");

  if(isDefined(var_1) && var_1 == 1) {
    var_4 kill();
  }

  var_6 delete();
}

ambush_ally_throw_smoke(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("cleanup_grenade_throw");
  wait(var_4);
  thread maps\factory_util::disable_awareness();
  var_6 = common_scripts\utility::getstruct(var_1, "script_noteworthy");

  if(isDefined(var_5)) {
    var_6 maps\_anim::anim_reach_solo(self, var_5);
    var_6 maps\_anim::anim_single_solo(self, var_5);
  } else
    var_6 maps\_anim::anim_reach_solo(self, var_2);

  var_6 thread maps\_anim::anim_single_solo(self, var_2);
  var_7 = spawn("script_model", self gettagorigin("TAG_INHAND"));
  var_7 setModel("projectile_us_smoke_grenade");
  var_7 linkto(self, "tag_inhand");
  var_8 = common_scripts\utility::spawn_tag_origin();
  var_8.origin = var_7.origin;
  var_8 linkto(var_7);
  playFXOnTag(level._effect["factory_ambush_smoke_grenade_hand"], var_8, "tag_origin");
  var_8 thread maps\_utility::play_sound_on_tag("scn_factory_ambush_pull_smoke", "TAG_ORIGIN");
  self waittillmatch("single anim", "grenade_throw");
  var_8 delete();
  var_7 delete();
  var_9 = getent(var_0, "targetname");
  var_10 = undefined;
  var_10 = magicgrenade("smoke_grenade_factory", self gettagorigin("TAG_INHAND"), var_9.origin, 2);

  if(isDefined(var_10)) {
    var_11 = var_10 common_scripts\utility::spawn_tag_origin();
    var_11 linkto(var_10);
    playFXOnTag(level._effect["factory_ambush_grenade_trail_runner"], var_11, "TAG_ORIGIN");
    var_11 thread maps\_utility::play_sound_on_tag("scn_factory_ambush_throw_smoke", "TAG_ORIGIN");
    var_10 thread ambush_spent_gas_grenade(var_9.script_noteworthy);
  }

  if(isDefined(var_3)) {
    maps\_utility::smart_dialogue(var_3);
  }

  var_6 waittill(var_2);
  maps\factory_util::enable_awareness();
  self.ignoreall = 0;
  self.ignoreme = 0;
  maps\_utility::disable_dontevershoot();
  maps\_utility::enable_ai_color();
  wait 0.1;
  maps\factory_util::safe_trigger_by_targetname("ambush_allies_after_smoke_pop");
}

ambush_spent_gas_grenade(var_0) {
  var_1 = getent(var_0, "targetname");
  self waittill("death");
  var_1 show();
  common_scripts\utility::flag_wait("thermal_battle_clear");
  var_1 delete();
}

#using_animtree("generic_human");

setup_smoke_archetype() {
  var_0 = [];
  var_0["cqb"]["straight"] = % factory_ambush_smoke_walkforward_01;
  var_0["cqb"]["straight_twitch"] = [ % factory_ambush_smoke_walkforward_01];
  maps\_utility::register_archetype("factory_smoke", var_0, 1);
}

force_smoke_reaction_anims() {
  thread ambush_enemy_walking_cough_01();
  thread ambush_enemy_force_smoke_reaction("ambush_force_smoke_reaction_01", "factory_ambush_smoke_CornerCrR_04", "coverstand_hide_idle");
  thread ambush_enemy_force_smoke_reaction("ambush_force_smoke_reaction_02", "factory_ambush_smoke_CornerCrR_05", "coverstand_hide_idle");
  thread ambush_enemy_force_smoke_reaction("ambush_force_smoke_reaction_03", "factory_ambush_smoke_walking_cough_03", "coverstand_hide_idle");
}

ambush_enemy_walking_cough_01() {
  if(common_scripts\utility::flag("player_left_ambush_room")) {
    return;
  }
  level.player common_scripts\utility::waittill_notify_or_timeout("use_thermal", 8);
  level.squad["ALLY_ALPHA"] maps\_utility::delaythread(1.2, maps\_utility::smart_dialogue, "factory_bkr_theycantseeus");
  var_0 = getent("ambush_walking_cough_01", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai();

  if(maps\_utility::spawn_failed(var_1)) {
    common_scripts\utility::flag_set("walking_cough_guy_done");
    return;
  }

  var_1.animname = "generic";
  var_1.animating = 1;
  var_1.allowdeath = 1;
  var_1.oldgoalradius = 256;
  waittillframeend;
  var_2 = getent("ambush_walking_cough_node", "targetname");
  var_2 maps\_anim::anim_single_solo(var_1, "factory_ambush_smoke_walking_cough_01");
  var_1.animating = undefined;
  var_1 maps\_utility::enable_cqbwalk();
  maps\factory_util::safe_set_goal_volume([var_1], "ambush_left_volume");
  common_scripts\utility::flag_set("walking_cough_guy_done");
}

ambush_enemy_force_smoke_reaction(var_0, var_1, var_2, var_3) {
  var_4 = getent(var_0, "targetname");

  if(isDefined(var_4.radius)) {
    if(maps\_utility::players_within_distance(var_4.radius, var_4.origin)) {
      return;
    }
  }

  var_5 = 3;
  var_6 = [];
  var_7 = undefined;

  while(var_5 > 0) {
    if(var_6.size == 0) {
      var_7 = maps\_utility::get_closest_ai(var_4.origin, "axis");
    }
    else {
      var_7 = maps\_utility::get_closest_ai(var_4.origin, "axis", var_6);
    }

    if(isalive(var_7) && !isDefined(var_7.animating)) {
      break;
    } else {
      var_6[var_6.size] = var_7;
      var_5--;

      if(var_5 <= 0) {
        return;
      }
    }
  }

  var_7.animating = 1;
  var_7.allowdeath = 1;
  var_7.animname = "generic";
  var_7.oldgoalradius = 256;
  waittillframeend;
  var_8 = [];
  var_8["generic"] = var_7;
  var_4 maps\_anim::anim_reach(var_8, var_1);

  if(isDefined(var_3)) {
    wait(var_3);

    if(!isDefined(var_7) || !isalive(var_7)) {
      return;
    }
  }

  if(isDefined(var_7) && isalive(var_7)) {
    var_4 maps\_anim::anim_single_solo(var_7, var_1);
  }

  if(isDefined(var_7) && isalive(var_7)) {
    var_7.animating = undefined;
  }
}

kill_me(var_0) {
  var_0 kill_no_react();
}

kill_no_react() {
  if(!isalive(self)) {
    return;
  }
  if(isDefined(self.magic_bullet_shield)) {
    maps\_utility::stop_magic_bullet_shield();
  }

  self.allowdeath = 1;
  self.a.nodeath = 1;
  maps\_utility::set_battlechatter(0);
  self kill();
}

rag_doll(var_0) {
  var_0 startragdoll();
  var_0 kill();
  level notify("guard_window_02_dead");
}

factory_assembly_line_play() {
  level endon("stop_assembly_line");
  level.speed_up_multiplier = 20.0;
  var_0 = common_scripts\utility::getstruct("automated_assemebly_line", "script_noteworthy");
  level.assembly_anim_node = var_0;
  var_0 = common_scripts\utility::getstruct("automated_assemebly_line_back", "script_noteworthy");
  level.assembly_anim_node_back = var_0;
  thread factory_auto_play_front();
  thread factory_auto_play_back();
  thread ambush_arm_malfunction();
}

factory_assembly_line_delete() {
  var_0 = [];
  var_0 = getEntArray("assembly_line_anim_model", "script_noteworthy");

  foreach(var_2 in var_0) {
  var_2 delete();
  }
}

factory_auto_play_front() {
  level endon("stop_assembly_line");
  level.factory_assembly_line_front_station01_arm_a = maps\_utility::spawn_anim_model("factory_assembly_line_front_station01_arm_a");
  level.factory_assembly_line_front_station01_arm_a thermaldrawenable();
  level.factory_assembly_line_front_station01_arm_b = maps\_utility::spawn_anim_model("factory_assembly_line_front_station01_arm_b");
  level.factory_assembly_line_front_station01_arm_b thermaldrawenable();
  level.factory_assembly_line_front_station02_arm_a = maps\_utility::spawn_anim_model("factory_assembly_line_front_station02_arm_a");
  level.factory_assembly_line_front_station02_arm_a thermaldrawenable();
  level.factory_assembly_line_front_station02_arm_b = maps\_utility::spawn_anim_model("factory_assembly_line_front_station02_arm_b");
  level.factory_assembly_line_front_station02_arm_b thermaldrawenable();
  level.factory_assembly_line_front_station02_arm_c = maps\_utility::spawn_anim_model("factory_assembly_line_front_station02_arm_c");
  level.factory_assembly_line_front_station02_arm_c thermaldrawenable();
  level.factory_assembly_line_front_station02_arm_d = maps\_utility::spawn_anim_model("factory_assembly_line_front_station02_arm_d");
  level.factory_assembly_line_front_station02_arm_d thermaldrawenable();
  level.factory_assembly_line_front_station03_arm_a = maps\_utility::spawn_anim_model("factory_assembly_line_front_station03_arm_a");
  level.factory_assembly_line_front_station03_arm_a thermaldrawenable();
  level.factory_assembly_line_front_station03_arm_b = maps\_utility::spawn_anim_model("factory_assembly_line_front_station03_arm_b");
  level.factory_assembly_line_front_station03_arm_b thermaldrawenable();
  level.factory_assembly_line_front_station03_arm_c = maps\_utility::spawn_anim_model("factory_assembly_line_front_station03_arm_c");
  level.factory_assembly_line_front_station03_arm_c thermaldrawenable();
  level.factory_assembly_line_front_station03_arm_d = maps\_utility::spawn_anim_model("factory_assembly_line_front_station03_arm_d");
  level.factory_assembly_line_front_station03_arm_d thermaldrawenable();
  level.factory_assembly_line_front_station04_arm_a = maps\_utility::spawn_anim_model("factory_assembly_line_front_station04_arm_a");
  level.factory_assembly_line_front_station04_arm_a thermaldrawenable();
  level.factory_assembly_line_front_station04_arm_b = maps\_utility::spawn_anim_model("factory_assembly_line_front_station04_arm_b");
  level.factory_assembly_line_front_station04_arm_b thermaldrawenable();
  level.factory_assembly_line_front_station04_arm_c = maps\_utility::spawn_anim_model("factory_assembly_line_front_station04_arm_c");
  level.factory_assembly_line_front_station04_arm_c thermaldrawenable();
  level.factory_assembly_line_front_station05_arm_a = maps\_utility::spawn_anim_model("factory_assembly_line_front_station05_arm_a");
  level.factory_assembly_line_front_station05_arm_a thermaldrawenable();
  level.factory_assembly_line_front_station05_arm_b = maps\_utility::spawn_anim_model("factory_assembly_line_front_station05_arm_b");
  level.factory_assembly_line_front_station05_arm_b thermaldrawenable();
  level.factory_assembly_line_front_station05_arm_c = maps\_utility::spawn_anim_model("factory_assembly_line_front_station05_arm_c");
  level.factory_assembly_line_front_station05_arm_c thermaldrawenable();
  level.factory_assembly_line_front_station06_arm_a = maps\_utility::spawn_anim_model("factory_assembly_line_front_station06_arm_a");
  level.factory_assembly_line_front_station06_arm_a thermaldrawenable();
  level.factory_assembly_line_front_station06_arm_b = maps\_utility::spawn_anim_model("factory_assembly_line_front_station06_arm_b");
  level.factory_assembly_line_front_station06_arm_b thermaldrawenable();
  var_0 = 20.0;
  var_1 = 4;

  for(;;) {
    thread spawn_front_piece();
    thread spawn_front_piece_belt();

    if(var_1 > 0) {
      var_1--;
      wait(var_0 / level.speed_up_multiplier);

      if(var_1 == 0) {
        common_scripts\utility::flag_set("factory_assembly_line_resume_speed_front");
      }

      continue;
    }

    wait(var_0);
  }
}

factory_auto_play_back() {
  level endon("stop_assembly_line");
  level.factory_assembly_line_back_station01 = maps\_utility::spawn_anim_model("factory_assembly_line_back_station01");
  level.factory_assembly_line_back_station01 thermaldrawenable();
  level.factory_assembly_line_back_station02 = maps\_utility::spawn_anim_model("factory_assembly_line_back_station02");
  level.factory_assembly_line_back_station02 thermaldrawenable();
  level.factory_assembly_line_back_station03 = maps\_utility::spawn_anim_model("factory_assembly_line_back_station03");
  level.factory_assembly_line_back_station03 thermaldrawenable();
  level.factory_assembly_line_back_station04 = maps\_utility::spawn_anim_model("factory_assembly_line_back_station04");
  level.factory_assembly_line_back_station04 thermaldrawenable();
  level.factory_assembly_line_back_station05 = maps\_utility::spawn_anim_model("factory_assembly_line_back_station05");
  level.factory_assembly_line_back_station05 thermaldrawenable();
  level.factory_assembly_line_back_turn_rail_track = maps\_utility::spawn_anim_model("factory_assembly_line_back_turn_rail_track");
  var_0 = 11.4;
  var_1 = 11;

  for(;;) {
    thread spawn_back_piece();

    if(var_1 > 0) {
      var_1--;
      wait(var_0 / level.speed_up_multiplier);

      if(var_1 == 0) {
        common_scripts\utility::flag_set("factory_assembly_line_resume_speed_back");
      }

      continue;
    }

    wait(var_0);
  }
}

spawn_front_piece() {
  if(common_scripts\utility::flag("stop_assembly_line")) {
    return;
  }
  var_0 = maps\_utility::spawn_anim_model("front_moving_piece");
  var_0.animname = "front_moving_piece";
  var_0 thermaldrawenable();
  var_0 maps\factory_ambush::attach_mover_prefab();

  if(!common_scripts\utility::flag("factory_assembly_line_resume_speed_front")) {
    maps\_utility::delaythread(0.1, maps\_anim::anim_set_rate_single, var_0, "automated_assemebly_line", level.speed_up_multiplier);
    thread factory_anim_resume_speed("factory_assembly_line_resume_speed_front", var_0);
  }

  if(isDefined(level.assembly_anim_node)) {
    level.assembly_anim_node maps\_anim::anim_single_solo(var_0, "automated_assemebly_line", undefined, 0.001);
  }

  var_0 maps\factory_ambush::detach_mover_prefab();
  var_0 delete();
}

spawn_front_piece_belt() {
  if(common_scripts\utility::flag("stop_assembly_line")) {
    return;
  }
  var_0 = maps\_utility::spawn_anim_model("front_moving_piece_belt");
  var_0.animname = "front_moving_piece_belt";

  if(!common_scripts\utility::flag("factory_assembly_line_resume_speed_front")) {
    maps\_utility::delaythread(0.1, maps\_anim::anim_set_rate_single, var_0, "automated_assemebly_line", level.speed_up_multiplier);
    thread factory_anim_resume_speed("factory_assembly_line_resume_speed_front", var_0);
  }

  if(isDefined(level.assembly_anim_node)) {
    level.assembly_anim_node maps\_anim::anim_single_solo(var_0, "automated_assemebly_line", undefined, 0.001);
  }

  var_0 delete();
}

spawn_back_piece() {
  if(common_scripts\utility::flag("stop_assembly_line")) {
    return;
  }
  var_0 = maps\_utility::spawn_anim_model("back_moving_piece");
  var_0.animname = "back_moving_piece";

  if(!common_scripts\utility::flag("factory_assembly_line_resume_speed_back")) {
    maps\_utility::delaythread(0.1, maps\_anim::anim_set_rate_single, var_0, "automated_assemebly_line", level.speed_up_multiplier);
    thread factory_anim_resume_speed("factory_assembly_line_resume_speed_back", var_0);
  }

  if(isDefined(level.assembly_anim_node_back)) {
    level.assembly_anim_node_back maps\_anim::anim_single_solo(var_0, "automated_assemebly_line", undefined, 0.001);
  }

  var_0 delete();
}

front_station_start_01(var_0) {
  level endon("stop_assembly_line");
  var_1 = [];
  var_1["factory_assembly_line_front_station01_arm_a"] = level.factory_assembly_line_front_station01_arm_a;
  var_1["factory_assembly_line_front_station01_arm_b"] = level.factory_assembly_line_front_station01_arm_b;
  level.factory_assembly_line_front_station01_arm_a playSound("scn_factory_assembly_tank_arm01_ss");

  if(!common_scripts\utility::flag("factory_assembly_line_resume_speed_front")) {
    maps\_utility::delaythread(0.1, maps\_anim::anim_set_rate, var_1, "automated_assemebly_line", level.speed_up_multiplier);
    thread factory_anim_resume_speed("factory_assembly_line_resume_speed_front", var_1);
  }

  if(isDefined(level.assembly_anim_node) && isDefined(var_1)) {
    level.assembly_anim_node maps\_anim::anim_single(var_1, "automated_assemebly_line", undefined, 0.001);
    level.assembly_anim_node maps\_anim::anim_first_frame(var_1, "automated_assemebly_line");
  }
}

front_station_start_02(var_0) {
  level endon("stop_assembly_line");
  var_1 = [];
  var_1["factory_assembly_line_front_station01_arm_a"] = level.factory_assembly_line_front_station02_arm_a;
  var_1["factory_assembly_line_front_station01_arm_b"] = level.factory_assembly_line_front_station02_arm_b;
  var_1["factory_assembly_line_front_station01_arm_c"] = level.factory_assembly_line_front_station02_arm_c;
  var_1["factory_assembly_line_front_station01_arm_d"] = level.factory_assembly_line_front_station02_arm_d;
  level.factory_assembly_line_front_station02_arm_a playSound("scn_factory_assembly_tank_arm02_ss");

  if(!common_scripts\utility::flag("factory_assembly_line_resume_speed_front")) {
    maps\_utility::delaythread(0.1, maps\_anim::anim_set_rate, var_1, "automated_assemebly_line", level.speed_up_multiplier);
    thread factory_anim_resume_speed("factory_assembly_line_resume_speed_front", var_1);
  }

  if(isDefined(level.assembly_anim_node) && isDefined(var_1)) {
    level.assembly_anim_node maps\_anim::anim_single(var_1, "automated_assemebly_line", undefined, 0.001);
    level.assembly_anim_node maps\_anim::anim_first_frame(var_1, "automated_assemebly_line");
  }
}

front_station_start_03(var_0) {
  level endon("stop_assembly_line");
  var_1 = [];
  var_1["factory_assembly_line_front_station03_arm_a"] = level.factory_assembly_line_front_station03_arm_a;
  var_1["factory_assembly_line_front_station03_arm_b"] = level.factory_assembly_line_front_station03_arm_b;
  var_1["factory_assembly_line_front_station03_arm_c"] = level.factory_assembly_line_front_station03_arm_c;
  var_1["factory_assembly_line_front_station03_arm_d"] = level.factory_assembly_line_front_station03_arm_d;
  level.factory_assembly_line_front_station03_arm_a playSound("scn_factory_assembly_tank_arm03_ss");

  if(!common_scripts\utility::flag("factory_assembly_line_resume_speed_front")) {
    maps\_utility::delaythread(0.1, maps\_anim::anim_set_rate, var_1, "automated_assemebly_line", level.speed_up_multiplier);
    thread factory_anim_resume_speed("factory_assembly_line_resume_speed_front", var_1);
  }

  if(isDefined(level.assembly_anim_node) && isDefined(var_1)) {
    level.assembly_anim_node maps\_anim::anim_single(var_1, "automated_assemebly_line", undefined, 0.001);
    level.assembly_anim_node maps\_anim::anim_first_frame(var_1, "automated_assemebly_line");
  }
}

front_station_start_04(var_0) {
  level endon("stop_assembly_line");
  var_1 = [];
  var_1["factory_assembly_line_front_station04_arm_a"] = level.factory_assembly_line_front_station04_arm_a;
  var_1["factory_assembly_line_front_station04_arm_b"] = level.factory_assembly_line_front_station04_arm_b;
  var_1["factory_assembly_line_front_station04_arm_c"] = level.factory_assembly_line_front_station04_arm_c;
  level.factory_assembly_line_front_station04_arm_a playSound("scn_factory_assembly_tank_arm04_ss");

  if(!common_scripts\utility::flag("factory_assembly_line_resume_speed_front")) {
    maps\_utility::delaythread(0.1, maps\_anim::anim_set_rate, var_1, "automated_assemebly_line", level.speed_up_multiplier);
    thread factory_anim_resume_speed("factory_assembly_line_resume_speed_front", var_1);
  }

  if(isDefined(level.assembly_anim_node) && isDefined(var_1)) {
    level.assembly_anim_node maps\_anim::anim_single(var_1, "automated_assemebly_line", undefined, 0.001);
    level.assembly_anim_node maps\_anim::anim_first_frame(var_1, "automated_assemebly_line");
  }
}

front_station_start_05(var_0) {
  level endon("ambush_arm_malfunction");

  if(common_scripts\utility::flag("ambush_arm_malfunction")) {
    return;
  }
  var_1 = [];
  var_1["factory_assembly_line_front_station05_arm_a"] = level.factory_assembly_line_front_station05_arm_a;
  var_1["factory_assembly_line_front_station05_arm_b"] = level.factory_assembly_line_front_station05_arm_b;
  var_1["factory_assembly_line_front_station05_arm_c"] = level.factory_assembly_line_front_station05_arm_c;
  level.factory_assembly_line_front_station05_arm_a playSound("scn_factory_assembly_tank_arm05_ss");

  if(!common_scripts\utility::flag("factory_assembly_line_resume_speed_front")) {
    maps\_utility::delaythread(0.1, maps\_anim::anim_set_rate, var_1, "automated_assemebly_line", level.speed_up_multiplier);
    thread factory_anim_resume_speed("factory_assembly_line_resume_speed_front", var_1);
  }

  if(isDefined(level.assembly_anim_node) && isDefined(var_1)) {
    level.assembly_anim_node maps\_anim::anim_single(var_1, "automated_assemebly_line", undefined, 0.001);
    level.assembly_anim_node maps\_anim::anim_first_frame(var_1, "automated_assemebly_line");
  }
}

front_station_start_06(var_0) {
  level endon("stop_assembly_line");
  var_1 = [];
  var_1["factory_assembly_line_front_station06_arm_a"] = level.factory_assembly_line_front_station06_arm_a;
  var_1["factory_assembly_line_front_station06_arm_b"] = level.factory_assembly_line_front_station06_arm_b;

  if(!common_scripts\utility::flag("factory_assembly_line_resume_speed_front")) {
    maps\_utility::delaythread(0.1, maps\_anim::anim_set_rate, var_1, "automated_assemebly_line", level.speed_up_multiplier);
    thread factory_anim_resume_speed("factory_assembly_line_resume_speed_front", var_1);
  }

  if(isDefined(level.assembly_anim_node) && isDefined(var_1)) {
    level.assembly_anim_node maps\_anim::anim_single(var_1, "automated_assemebly_line", undefined, 0.001);
    level.assembly_anim_node maps\_anim::anim_first_frame(var_1, "automated_assemebly_line");
  }
}

back_station_start_01(var_0) {
  level endon("stop_assembly_line");
  level.factory_assembly_line_back_station01 playSound("scn_factory_assembly_back_arm_ss");

  if(!common_scripts\utility::flag("factory_assembly_line_resume_speed_back")) {
    maps\_utility::delaythread(0.1, maps\_anim::anim_set_rate_single, level.factory_assembly_line_back_station01, "automated_assemebly_line", level.speed_up_multiplier);
    thread factory_anim_resume_speed("factory_assembly_line_resume_speed_back", level.factory_assembly_line_back_station01);
  }

  if(isDefined(level.assembly_anim_node_back) && isDefined(level.factory_assembly_line_back_station01)) {
    level.assembly_anim_node_back maps\_anim::anim_single_solo(level.factory_assembly_line_back_station01, "automated_assemebly_line", undefined, 0.001);
    level.assembly_anim_node_back maps\_anim::anim_first_frame_solo(level.factory_assembly_line_back_station01, "automated_assemebly_line");
  }
}

back_station_start_02(var_0) {
  level endon("stop_assembly_line");
  level.factory_assembly_line_back_station02 playSound("scn_factory_assembly_back_arm_ss");

  if(!common_scripts\utility::flag("factory_assembly_line_resume_speed_back")) {
    maps\_utility::delaythread(0.1, maps\_anim::anim_set_rate_single, level.factory_assembly_line_back_station02, "automated_assemebly_line", level.speed_up_multiplier);
    thread factory_anim_resume_speed("factory_assembly_line_resume_speed_back", level.factory_assembly_line_back_station02);
  }

  if(isDefined(level.assembly_anim_node_back) && isDefined(level.factory_assembly_line_back_station02)) {
    level.assembly_anim_node_back maps\_anim::anim_single_solo(level.factory_assembly_line_back_station02, "automated_assemebly_line", undefined, 0.001);
    level.assembly_anim_node_back maps\_anim::anim_first_frame_solo(level.factory_assembly_line_back_station02, "automated_assemebly_line");
  }
}

back_station_start_03(var_0) {
  level endon("stop_assembly_line");
  level.factory_assembly_line_back_station03 playSound("scn_factory_assembly_back_arm_ss");

  if(!common_scripts\utility::flag("factory_assembly_line_resume_speed_back")) {
    maps\_utility::delaythread(0.1, maps\_anim::anim_set_rate_single, level.factory_assembly_line_back_station03, "automated_assemebly_line", level.speed_up_multiplier);
    thread factory_anim_resume_speed("factory_assembly_line_resume_speed_back", level.factory_assembly_line_back_station03);
  }

  if(isDefined(level.assembly_anim_node_back) && isDefined(level.factory_assembly_line_back_station03)) {
    level.assembly_anim_node_back maps\_anim::anim_single_solo(level.factory_assembly_line_back_station03, "automated_assemebly_line", undefined, 0.001);
    level.assembly_anim_node_back maps\_anim::anim_first_frame_solo(level.factory_assembly_line_back_station03, "automated_assemebly_line");
  }
}

back_station_start_04(var_0) {
  level endon("stop_assembly_line");
  level.factory_assembly_line_back_station04 playSound("scn_factory_assembly_back_arm_ss");

  if(!common_scripts\utility::flag("factory_assembly_line_resume_speed_back")) {
    maps\_utility::delaythread(0.1, maps\_anim::anim_set_rate_single, level.factory_assembly_line_back_station04, "automated_assemebly_line", level.speed_up_multiplier);
    thread factory_anim_resume_speed("factory_assembly_line_resume_speed_back", level.factory_assembly_line_back_station04);
  }

  if(isDefined(level.assembly_anim_node_back) && isDefined(level.factory_assembly_line_back_station04)) {
    level.assembly_anim_node_back maps\_anim::anim_single_solo(level.factory_assembly_line_back_station04, "automated_assemebly_line", undefined, 0.001);
    level.assembly_anim_node_back maps\_anim::anim_first_frame_solo(level.factory_assembly_line_back_station04, "automated_assemebly_line");
  }
}

back_station_start_05(var_0) {
  level endon("stop_assembly_line");
  level.factory_assembly_line_back_station05 playSound("scn_factory_assembly_back_arm_ss");

  if(!common_scripts\utility::flag("factory_assembly_line_resume_speed_back")) {
    maps\_utility::delaythread(0.1, maps\_anim::anim_set_rate_single, level.factory_assembly_line_back_station05, "automated_assemebly_line", level.speed_up_multiplier);
    thread factory_anim_resume_speed("factory_assembly_line_resume_speed_back", level.factory_assembly_line_back_station05);
  }

  if(isDefined(level.assembly_anim_node_back) && isDefined(level.factory_assembly_line_back_station05)) {
    level.assembly_anim_node_back maps\_anim::anim_single_solo(level.factory_assembly_line_back_station05, "automated_assemebly_line", undefined, 0.001);
    level.assembly_anim_node_back maps\_anim::anim_first_frame_solo(level.factory_assembly_line_back_station05, "automated_assemebly_line");
  }
}

back_turn_rail_track(var_0) {
  level endon("stop_assembly_line");

  if(!common_scripts\utility::flag("factory_assembly_line_resume_speed_back")) {
    maps\_utility::delaythread(0.1, maps\_anim::anim_set_rate_single, level.factory_assembly_line_back_turn_rail_track, "automated_assemebly_line", level.speed_up_multiplier);
    thread factory_anim_resume_speed("factory_assembly_line_resume_speed_back", level.factory_assembly_line_back_turn_rail_track);
  }

  var_0 playSound("scn_factory_assembly_tank_back_ss");

  if(isDefined(level.assembly_anim_node_back) && isDefined(level.factory_assembly_line_back_turn_rail_track)) {
    level.assembly_anim_node_back maps\_anim::anim_single_solo(level.factory_assembly_line_back_turn_rail_track, "automated_assemebly_line", undefined, 0.001);
    level.assembly_anim_node_back maps\_anim::anim_first_frame_solo(level.factory_assembly_line_back_turn_rail_track, "automated_assemebly_line");
  }
}

factory_anim_resume_speed(var_0, var_1) {
  common_scripts\utility::flag_wait(var_0);

  if(isarray(var_1)) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3)) {
        maps\_anim::anim_set_rate_single(var_3, "automated_assemebly_line", 1.0);
      }
    }
  } else if(isDefined(var_1))
    maps\_anim::anim_set_rate_single(var_1, "automated_assemebly_line", 1.0);
}

factory_assembly_line_cleanup(var_0) {
  if(!isDefined(var_0)) {
    common_scripts\utility::flag_wait("player_off_roof");
  }

  common_scripts\utility::flag_set("stop_assembly_line");
  wait 0.1;
  maps\factory_util::safe_delete(level.factory_assembly_line_front_station01_arm_a);
  maps\factory_util::safe_delete(level.factory_assembly_line_front_station01_arm_b);
  maps\factory_util::safe_delete(level.factory_assembly_line_front_station02_arm_a);
  maps\factory_util::safe_delete(level.factory_assembly_line_front_station02_arm_b);
  maps\factory_util::safe_delete(level.factory_assembly_line_front_station02_arm_c);
  maps\factory_util::safe_delete(level.factory_assembly_line_front_station02_arm_d);
  maps\factory_util::safe_delete(level.factory_assembly_line_front_station03_arm_a);
  maps\factory_util::safe_delete(level.factory_assembly_line_front_station03_arm_b);
  maps\factory_util::safe_delete(level.factory_assembly_line_front_station03_arm_c);
  maps\factory_util::safe_delete(level.factory_assembly_line_front_station03_arm_d);
  maps\factory_util::safe_delete(level.factory_assembly_line_front_station04_arm_a);
  maps\factory_util::safe_delete(level.factory_assembly_line_front_station04_arm_b);
  maps\factory_util::safe_delete(level.factory_assembly_line_front_station04_arm_c);
  maps\factory_util::safe_delete(level.factory_assembly_line_front_station05_arm_a);
  maps\factory_util::safe_delete(level.factory_assembly_line_front_station05_arm_b);
  maps\factory_util::safe_delete(level.factory_assembly_line_front_station05_arm_c);
  maps\factory_util::safe_delete(level.factory_assembly_line_front_station06_arm_a);
  maps\factory_util::safe_delete(level.factory_assembly_line_front_station06_arm_b);
  maps\factory_util::safe_delete(level.factory_assembly_line_back_station01);
  maps\factory_util::safe_delete(level.factory_assembly_line_back_station02);
  maps\factory_util::safe_delete(level.factory_assembly_line_back_station03);
  maps\factory_util::safe_delete(level.factory_assembly_line_back_station04);
  maps\factory_util::safe_delete(level.factory_assembly_line_back_station05);
  maps\factory_util::safe_delete(level.factory_assembly_line_back_turn_rail_track);
  maps\factory_util::safe_delete(level.factory_assembly_line_arm_malfunction);
}

ambush_arm_malfunction() {
  common_scripts\utility::flag_wait("ambush_arm_malfunction");
  level.factory_assembly_line_front_station05_arm_b delete();
  var_0 = maps\_utility::spawn_anim_model("factory_assembly_line_arm_malfunction");
  var_1 = common_scripts\utility::getstruct("automated_assemebly_line", "script_noteworthy");
  var_1 thread maps\_anim::anim_loop_solo(var_0, "arm_malfunction");
  playFXOnTag(level._effect["welding_sparks_funner"], var_0, "tag_fx_01");
  playFXOnTag(level._effect["electrical_sparks_20_funner"], var_0, "tag_fx_02");
  playFXOnTag(level._effect["electrical_sparks_20_funner"], var_0, "tag_fx_03");
  radiusdamage((5178, -2361, 262), 200, 400, 100);
  level waittill("stop_assembly_line");
  var_1 notify("stop_loop");
  var_0 stopanimscripted();
  level.factory_assembly_line_arm_malfunction = var_0;
}

chase_notify_hit_vehicle_1(var_0) {
  level notify("hit_vehicle_01");
  var_1 = getent("parking_lot_trucks_at_rest_blocker", "targetname");
  var_1 solid();
  var_2 = getent("parking_lot_fence_blocker", "targetname");
  var_2 solid();
}

chase_notify_hit_vehicle_2(var_0) {
  level notify("hit_vehicle_02");
}

chase_notify_hit_vehicle_3(var_0) {
  level notify("hit_vehicle_03");
  wait 1;
  level notify("semi_stopped");
}

chase_notify_hit_awning(var_0) {
  var_1 = getent("parking_lot_awning_blocker", "targetname");
  var_1 delete();
}

chase_notify_hit_light_pole(var_0) {
  var_1 = getent("parking_lot_light_pole_blocker", "targetname");
  var_1 delete();
}

chase_notify_hit_hydrant(var_0) {
  thread maps\factory_parking_lot::parking_lot_fire_hydrant_explodes();
}

chase_pull_up_notify_switch(var_0) {
  level notify("player_switch");
}

ally_01_mount_trailer(var_0) {
  var_1 = getent("car_chase_intro", "script_noteworthy");
  var_1 maps\_anim::anim_single_solo(level.squad["ALLY_ALPHA"], "factory_parking_lot_crub_hop_ally01");
  level notify("start_mount");
  level.squad["ALLY_ALPHA"] linkto(level.ally_vehicle_trailer, "body_anim_jnt");
  level.ally_vehicle_trailer maps\_anim::anim_loop_solo(level.squad["ALLY_ALPHA"], "factory_car_chase_intro_ally_pulls_up_player_loop", "stop_loop", "body_anim_jnt");
}

ally_02_mount_trailer(var_0) {
  level endon("player_mount_vehicle_start");
  var_1 = getent("car_chase_intro", "script_noteworthy");
  var_1 maps\_anim::anim_single_solo(level.squad["ALLY_BRAVO"], "factory_parking_lot_crub_hop_ally02");
  level.squad["ALLY_BRAVO"] linkto(level.ally_vehicle_trailer, "body_anim_jnt");
  level.ally_vehicle_trailer maps\_anim::anim_first_frame_solo(level.squad["ALLY_BRAVO"], "factory_car_chase_intro_ally_pulls_up_player", "body_anim_jnt");
}

ally_03_mount_trailer(var_0) {
  level endon("player_mount_vehicle_start");
  var_1 = getent("car_chase_intro", "script_noteworthy");
  var_1 maps\_anim::anim_single_solo(level.squad["ALLY_CHARLIE"], "factory_parking_lot_crub_hop_ally03");
  level.squad["ALLY_CHARLIE"] linkto(level.ally_vehicle_trailer, "body_anim_jnt");
  level.ally_vehicle_trailer maps\_anim::anim_first_frame_solo(level.squad["ALLY_CHARLIE"], "factory_car_chase_intro_ally_pulls_up_player", "body_anim_jnt");
}

chase_rumble_small(var_0) {
  level.player playrumbleonentity("light_1s");
}

chase_rumble_big(var_0) {
  level.player playrumbleonentity("heavy_1s");
}

chase_rumble_bigger(var_0) {
  level.player playrumbleonentity("artillery_rumble");
}

chase_kill_vehicle(var_0) {
  common_scripts\utility::array_thread(var_0.riders, maps\factory_chase::vehicle_crash_guy, var_0);
  var_0 thread maps\factory_chase::vehicle_crash_launch_guys();
}

chase_explode_vehicle(var_0) {
  var_0 maps\_vehicle::vehicle_lights_off("headlights");
  playFXOnTag(level._effect["lynxexplode"], var_0, "tag_deathfx");
  var_0 setModel("vehicle_iveco_lynx_destroyed_iw6");
}

chase_trailer_crate_destroyed(var_0) {
  var_1 = getent("trailer_crate_2", "targetname");
  var_1 setModel("com_bunkercrate_broken");
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("tag_origin");
  playFXOnTag(level._effect["lynxfire"], var_2, "tag_origin");
}

chase_trailer_catch_fire(var_0) {
  var_1 = spawn("script_model", level.ally_vehicle_trailer gettagorigin("tag_wheel_back_left") + (0, 0, 60));
  var_1 setModel("tag_origin");
  var_1 linkto(level.ally_vehicle_trailer);
  playFXOnTag(level._effect["lynxfire"], var_1, "tag_origin");
}

chase_player_knock_02(var_0) {
  var_1 = anglesToForward(level.ally_vehicle_trailer.angles);
  var_2 = level.player getplayerangles();
  var_3 = anglesToForward(var_2);
  var_4 = vectordot(var_1, -1 * var_3);

  if(var_4 < 0.5) {
    return;
  }
  var_5 = maps\_utility::spawn_anim_model("player_rig");
  var_5 hide();
  var_6 = getEntArray("trailer_node", "script_noteworthy");
  var_7 = common_scripts\utility::getclosest(level.player.origin, var_6);
  var_7 maps\_anim::anim_first_frame_solo(var_5, "factory_car_chase_player_knock_down_02");
  var_5 linkto(level.ally_vehicle_trailer, "body_anim_jnt");
  level.player freezecontrols(1);
  level.player setstance("stand");
  level.player playerlinktodelta(var_5, "tag_player", 1, 0, 0, 0, 0, 1);
  var_5 show();
  level.player disableweapons();
  level.player hideviewmodel();
  var_7 maps\_anim::anim_single_solo(var_5, "factory_car_chase_player_knock_down_02");
  level.player unlink();
  level.player showviewmodel();
  level.player enableweapons();
  level.player freezecontrols(0);
  var_5 delete();
}

#using_animtree("player");

chase_player_knock_03(var_0) {
  level endon("player_fell_off_trailer");
  var_1 = maps\_utility::spawn_anim_model("player_rig");
  var_1 hide();
  var_2 = getEntArray("trailer_node_left_side", "targetname");
  level.knock_03_node = common_scripts\utility::getclosest(level.player.origin, var_2);
  level.knock_03_node maps\_anim::anim_first_frame_solo(var_1, "factory_car_chase_player_knock_down_03");
  var_1 linkto(level.ally_vehicle_trailer, "body_anim_jnt");
  level.player setstance("stand");
  level.player playerlinktodelta(var_1, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player pushplayervector((0, 0, 0));
  var_1 show();
  level.player disableweapons();
  level.player hideviewmodel();
  level.knock_03_node thread maps\_anim::anim_single_solo(var_1, "factory_car_chase_player_knock_down_03");
  var_3 = getanimlength( % factory_car_chase_player_knock_down_03) - 0.1;
  wait(var_3);
  level.player setorigin(level.knock_03_node.origin + (0, 0, 5));
  level.player unlink();
  level.player showviewmodel();
  level.player enableweapons();
  var_1 delete();
}

slide_right(var_0) {
  level.player pushplayervector((-12, -8, 0));
  wait 2;
  level.player pushplayervector((0, 0, 0));
}

slide_left_quick(var_0) {
  level.player pushplayervector((8, 8, 0));
  wait 1;
  level.player pushplayervector((0, 0, 0));
}

slide_right_quick(var_0) {
  level.player pushplayervector((-8, -8, 0));
  wait 1;
  level.player pushplayervector((0, 0, 0));
}

hard_left(var_0) {
  level.player pushplayervector((0, 15, 0));
}

factory_car_chase_spawn() {
  var_0 = level.ally_vehicle;
  var_1 = level.ally_vehicle_trailer;
  var_2 = level.blockade_vehicle_1;
  var_3 = level.blockade_vehicle_2;
  var_4 = level.third_opfor_car;
  var_5 = level.blockade_vehicle_3;
  factory_car_chase(var_0, var_1, var_2, var_3, var_4, var_5);
}

factory_car_chase(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getEntArray("static_smokestack", "targetname");

  foreach(var_8 in var_6) {
  var_8 delete();
  }

  var_10 = getent("car_chase_intro", "script_noteworthy");
  var_11 = level.factory_car_chase_intro_side_car01;
  var_12 = level.factory_car_chase_intro_side_car02;
  var_13 = getent("parking_lot_truck_03", "targetname");
  var_13 delete();
  var_14 = maps\_utility::spawn_anim_model("factory_car_chase_intro_side_car03_blowup");
  level.factory_car_chase_intro_side_car03_blowup = var_14;
  var_15 = maps\_utility::spawn_anim_model("factory_car_chase_smokestack_01");
  var_16 = maps\_utility::spawn_anim_model("factory_car_chase_smokestack_02");
  var_17 = maps\_utility::spawn_anim_model("factory_boxes_and_shvelves_01");
  var_18 = maps\_utility::spawn_anim_model("factory_boxes_and_shvelves_02");
  var_17 thread factory_car_chase_link_boxes();
  var_18 thread factory_car_chase_link_boxes();
  var_19 = maps\_utility::spawn_anim_model("factory_car_chase_warehouse_facade0");
  var_20 = maps\_utility::spawn_anim_model("factory_car_chase_warehouse_facade1");
  var_21 = maps\_utility::spawn_anim_model("factory_car_chase_warehouse_top");
  var_22 = maps\_utility::spawn_anim_model("factory_car_chase_building_corner_break_00");
  var_23 = maps\_utility::spawn_anim_model("factory_car_chase_building_corner_break_01");
  var_24 = maps\_utility::spawn_anim_model("factory_car_chase_building_corner_break_02");
  var_25 = maps\_utility::spawn_anim_model("factory_car_chase_pipes");
  var_26 = maps\_utility::spawn_anim_model("factory_car_chase_skybridge_01");
  var_27 = maps\_utility::spawn_anim_model("factory_car_chase_skybridge_02");
  var_28 = maps\_utility::spawn_anim_model("factory_car_chase_smokestack_wall_01");
  var_29 = maps\_utility::spawn_anim_model("factory_car_chase_smokestack_wall_02");
  var_30 = maps\_utility::spawn_anim_model("factory_car_chase_building_facade_01");
  var_31 = maps\_utility::spawn_anim_model("factory_car_chase_building_facade_02");
  var_32 = maps\_utility::spawn_anim_model("factory_car_chase_building_facade_03");
  var_33 = maps\_utility::spawn_anim_model("factory_car_chase_building_facade_04");
  var_34 = maps\_utility::spawn_anim_model("factory_car_chase_building_facade_05");
  var_35 = maps\_utility::spawn_anim_model("factory_car_chase_building_facade_06");
  var_36 = maps\_utility::spawn_anim_model("factory_car_chase_building_facade_07");
  var_37 = maps\_utility::spawn_anim_model("factory_car_chase_building_facade_08");
  var_38 = maps\_utility::spawn_anim_model("factory_car_chase_building_facade_09");
  var_39 = maps\_utility::spawn_anim_model("factory_car_chase_building_facade_10");
  var_40 = maps\_utility::spawn_anim_model("factory_car_chase_building_facade_11");
  var_41 = maps\_utility::spawn_anim_model("factory_car_chase_building_facade_12");
  var_42 = maps\_vignette_util::vignette_vehicle_spawn("chase_heli_01", "factory_car_chase_chopper03");
  var_42 maps\_vehicle::godon();
  var_43 = maps\_utility::spawn_anim_model("factory_car_chase_plane01");
  var_44 = maps\_utility::spawn_anim_model("factory_car_chase_plane02");
  var_45 = maps\_utility::spawn_anim_model("factory_car_chase_plane03");
  var_43 thread maps\factory_chase::chase_looped_afterburner();
  var_44 thread maps\factory_chase::chase_looped_afterburner();
  var_45 thread maps\factory_chase::chase_looped_afterburner();
  var_46 = [];
  var_46["factory_car_chase_smokestack_01"] = var_15;
  var_46["factory_car_chase_building_corner_break_00"] = var_22;
  var_46["factory_car_chase_building_corner_break_01"] = var_23;
  var_46["factory_car_chase_building_corner_break_02"] = var_24;
  thread factory_car_chase_delete_early(var_46);
  var_47 = [];
  var_47["first_opfor_car"] = var_2;
  var_47["second_opfor_car"] = var_3;
  var_47["third_opfor_car"] = var_4;
  var_47["heavy_weapon_opfor_car"] = var_5;
  var_47["factory_car_chase_intro_side_car01_blowup"] = var_11;
  var_47["factory_car_chase_intro_side_car02_blowup"] = var_12;
  var_47["factory_car_chase_intro_side_car03_blowup"] = var_14;
  var_47["het_cab"] = var_0;
  var_47["het_trailer"] = var_1;
  var_47["factory_car_chase_smokestack_02"] = var_16;
  var_47["factory_boxes_and_shvelves_01"] = var_17;
  var_47["factory_boxes_and_shvelves_02"] = var_18;
  var_47["factory_car_chase_warehouse_facade0"] = var_19;
  var_47["factory_car_chase_warehouse_facade1"] = var_20;
  var_47["factory_car_chase_warehouse_top"] = var_21;
  var_47["factory_car_chase_pipes"] = var_25;
  var_47["factory_car_chase_skybridge_01"] = var_26;
  var_47["factory_car_chase_skybridge_02"] = var_27;
  var_47["factory_car_chase_building_facade_01"] = var_30;
  var_47["factory_car_chase_building_facade_02"] = var_31;
  var_47["factory_car_chase_building_facade_03"] = var_32;
  var_47["factory_car_chase_building_facade_04"] = var_33;
  var_47["factory_car_chase_building_facade_05"] = var_34;
  var_47["factory_car_chase_building_facade_06"] = var_35;
  var_47["factory_car_chase_building_facade_07"] = var_36;
  var_47["factory_car_chase_building_facade_08"] = var_37;
  var_47["factory_car_chase_building_facade_09"] = var_38;
  var_47["factory_car_chase_building_facade_10"] = var_39;
  var_47["factory_car_chase_building_facade_11"] = var_40;
  var_47["factory_car_chase_building_facade_12"] = var_41;
  var_47["factory_car_chase_chopper03"] = var_42;
  var_47["factory_car_chase_opfor_car01"] = factory_car_chase_enemy_vehicle_setup("factory_car_chase_opfor_car01");
  var_47["factory_car_chase_opfor_car02"] = factory_car_chase_enemy_vehicle_setup("factory_car_chase_opfor_car02");
  var_47["factory_car_chase_opfor_car03"] = factory_car_chase_enemy_vehicle_setup("factory_car_chase_opfor_car03");
  var_47["factory_car_chase_opfor_car04"] = factory_car_chase_enemy_vehicle_setup("factory_car_chase_opfor_car04");
  var_47["factory_car_chase_opfor_car05"] = factory_car_chase_enemy_vehicle_setup("factory_car_chase_opfor_car05");
  var_47["factory_car_chase_opfor_car07"] = factory_car_chase_enemy_vehicle_setup("factory_car_chase_opfor_car07");
  var_47["factory_car_chase_opfor_car08"] = factory_car_chase_enemy_vehicle_setup("factory_car_chase_opfor_car08");
  var_47["factory_car_chase_opfor_car09"] = maps\_utility::spawn_anim_model("factory_car_chase_opfor_car09");
  var_47["factory_car_chase_plane01"] = var_43;
  var_47["factory_car_chase_plane02"] = var_44;
  var_47["factory_car_chase_plane03"] = var_45;
  var_48 = [];
  var_48["ally_alpha"] = level.squad["ALLY_ALPHA"];
  var_48["ally_bravo"] = level.squad["ALLY_BRAVO"];
  var_48["ally_charlie"] = level.squad["ALLY_CHARLIE"];
  var_10 maps\_anim::anim_first_frame(var_47, "factory_car_chase");
  waittillframeend;
  setsaveddvar("player_sprintUnlimited", "1");
  var_10 thread maps\_anim::anim_single(var_47, "factory_car_chase");
  var_10 thread maps\_anim::anim_single(var_46, "factory_car_chase");
  level.ally_vehicle_trailer maps\_anim::anim_single(var_48, "factory_car_chase", "body_anim_jnt");
}

factory_car_chase_delete_early(var_0) {
  maps\factory_chase::chase_wait_for_semi_touch("chase_spawn_skybridge_drones_1");

  foreach(var_2 in var_0) {
  var_2 delete();
  }
}

light_turns_red() {
  var_0 = getent("foo", "targetname");

  for(;;) {
    common_scripts\utility::flag_wait("light_red");
    var_0 setlightcolor((1, 0, 0));
    common_scripts\utility::flag_waitopen("light_red");
    var_0 setlightcolor((1, 1, 1));
  }
}

factory_car_chase_link_boxes(var_0) {
  var_1 = [];
  var_2 = level.scr_model[self.animname];
  var_3 = getnumparts(var_2);

  for(var_4 = 0; var_4 < 48; var_4++) {
    var_5 = getpartname(var_2, var_4);

    if(getsubstr(var_5, 0, 14) == "shipping_crate") {
      var_6 = spawn("script_model", self gettagorigin(var_5));
      var_6 setModel("ch_crate64x64");
      var_6.angles = self gettagangles(var_5);
      var_6 linkto(self, var_5);

      if(isDefined(var_0)) {
        var_6.targetname = var_0;
      }

      var_1[var_1.size] = var_6;
      common_scripts\utility::waitframe();
    }
  }

  maps\factory_chase::chase_wait_for_semi_touch("chase_delete_warehouse_boxes");

  foreach(var_6 in var_1) {
  var_6 delete();
  }
}

factory_car_chase_enemy_vehicle_setup(var_0) {
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname(var_0);
  var_1 maps\_vehicle::vehicle_lights_on("headlights");
  var_1.animname = var_0;
  var_1 thread maps\factory_chase::vehicle_catch_fire_when_shot();
  var_1 thread maps\factory_chase::enemy_vehicle_twitch();
  return var_1;
}