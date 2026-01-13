/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\maps\europa\europa_anim.gsc
**************************************************/

main() {
  func_91DC();
  func_3353();
  func_3508();
  player();
  func_13267();
  func_EE25();
}

func_91DC() {
  level.var_EC87["sdf1"] = #animtree;
  level.var_EC87["sdf2"] = #animtree;
  level.var_EC87["sdf3"] = #animtree;
  level.var_EC85["generic"]["c6_hack_enter"] = % europa_armory_eng_console_intro;
  level.var_EC85["generic"]["c6_hack"][0] = % europa_armory_eng_console_idle;
  level.var_EC85["scar1"]["europa_dropship_intro"] = % europa_dropship_intro_scar01_scene;
  level.var_EC85["scar2"]["europa_dropship_intro"] = % europa_dropship_intro_scar02_scene;
  scripts\sp\anim::func_17FA("scar2", "nt_door_open", "dropship_door_open", "europa_dropship_intro");
  scripts\sp\anim::func_17FC("scar2", "weapon_attach", "scar2_stow_weapon", "europa_dropship_intro");
  level.var_EC85["scar1"]["europa_dropship_idle"][0] = % europa_dropship_intro_scar01_idle;
  level.var_EC85["scar2"]["europa_dropship_idle"][0] = % europa_dropship_intro_scar02_idle;
  level.var_EC85["scar1"]["europa_dropship_halo_jump"] = % europa_dropship_intro_scar01_halo_jump;
  level.var_EC85["scar2"]["europa_dropship_halo_jump"] = % europa_dropship_intro_scar02_halo_jump;
  level.var_EC85["scar1"]["lookdown"] = % europa_crevasse_scar02_lookdown;
  level.var_EC85["scar1"]["lookdown_idle"][0] = % europa_crevasse_scar02_idle;
  level.var_EC85["scar2"]["lookdown"] = % europa_crevasse_scar01_lookdown;
  level.var_EC85["scar2"]["lookdown_idle"][0] = % europa_crevasse_scar01_idle;
  level.var_EC85["scar1"]["airlock_response"] = % europa_airlock_scar01_reload_scene;
  level.var_EC88["scar2"]["europa_tee_gearsicingupletspl"] = % europa_tee_4_30_hr_r2;
  level.var_EC88["scar2"]["europa_tee_trackintwotargest"] = % europa_tee_3_70_hr_r2;
  level.var_EC88["scar2"]["europa_tee_boostdowntakeem"] = % europa_tee_3_80_hr_r2;
  level.var_EC88["scar1"]["europa_sip_wolfjumpdownwe"] = % europa_sip_4_10_hr_r2;
  level.var_EC85["player_enemy"]["cliffjumper"] = % europa_landing_takedown_a_enemy;
  level.var_EC85["player_enemy"]["cliffjumper_loop"] = % europa_landing_takedown_melee_loop_a_enemy;
  level.var_EC85["player_enemy"]["cliffjumper_kill"] = % europa_landing_takedown_melee_kill_a_enemy;
  level.var_EC85["player_enemy"]["cliffjumper_exit"] = % europa_landing_takedown_shoot_exit_a_enemy;
  level.var_EC85["ally_enemy"]["cliffjumper"] = % europa_landing_takedown_b_enemy;
  level.var_EC85["scar2"]["cliffjumper"] = % europa_landing_takedown_b_ally;
  scripts\sp\anim::func_17F6("ally_enemy", "helmet_pop", ::func_8E1D, "cliffjumper");
  scripts\sp\anim::func_17F6("player_enemy", "die", ::func_12920, "cliffjumper");
  scripts\sp\anim::func_17F6("player_enemy", "kick_impact", ::func_12923, "cliffjumper");
  level.var_EC85["guy1"]["platform_scene"] = % europa_labs_eng_c12_walkby_pcap;
  level.var_EC85["guy2"]["platform_scene"] = % europa_labs_xo_c12_walkby_pcap;
  level.var_EC85["takedown_enemy"]["tunnel_takedown"] = % europa_ice_cavern_sdf_takedown_02;
  level.var_EC85["scar1"]["tunnel_takedown"] = % europa_ice_cavern_scar_takedown_02;
  scripts\sp\anim::func_17F6("takedown_enemy", "die", ::func_12920, "tunnel_takedown");
  scripts\sp\anim::func_17F6("takedown_enemy", "nt_interupt_end", ::func_12924, "tunnel_takedown");
  scripts\sp\anim::func_17FC("scar1", "nt_interupt_check", "interupt_check", "tunnel_takedown");
  scripts\sp\anim::func_17FC("scar1", "nt_stab", "scar_stab", "tunnel_takedown");
  scripts\sp\anim::func_17F6("scar1", "knife_on", ::func_12922, "tunnel_takedown");
  scripts\sp\anim::func_17FC("scar1", "knife_off", "knife_off", "tunnel_takedown");
  level.var_EC85["scar1"]["hold_up"] = % europa_seeker_scar01_hold;
  level.var_EC85["scar2"]["hold_up"] = % europa_seeker_scar01_hold;
  level.var_EC85["generic"]["rummage1"] = % europa_airlock_locker_sdf01_scavenge;
  level.var_EC85["generic"]["rummage2"] = % europa_airlock_locker_sdf02_scavenge;
  level.var_EC85["generic"]["rummage3"] = % europa_airlock_locker_sdf03_scavenge;
  level.var_EC85["generic"]["rummage1_react"] = % europa_airlock_locker_sdf01_react;
  level.var_EC85["generic"]["rummage2_react"] = % europa_airlock_locker_sdf02_react;
  level.var_EC85["generic"]["rummage3_react"] = % europa_airlock_locker_sdf03_react;
  level.var_EC85["generic"]["rummage1_loop"][0] = % europa_airlock_locker_sdf01_scavenge_idle;
  level.var_EC85["generic"]["rummage2_loop"][0] = % europa_airlock_locker_sdf02_scavenge_idle;
  level.var_EC85["generic"]["rummage3_loop"][0] = % europa_airlock_locker_sdf03_scavenge_idle;
  level.var_EC85["generic"]["scripted_long_death_start"] = % hm_grnd_org_long_death_stand_trans_to_crawl;
  level.var_EC85["generic"]["scripted_long_death_crawl"] = % hm_grnd_org_long_death_crawl01;
  level.var_EC85["generic"]["scripted_long_death_die"] = % hm_grnd_org_long_death_crawl_death01;
  level.var_EC85["scar1"]["antigrav_breach"] = % europa_airlock_scar01_grav_grenade_scene;
  scripts\sp\anim::func_17FC("scar1", "grenade_appear", "grenade_appear", "antigrav_breach");
  scripts\sp\anim::func_17FC("scar1", "grenade_toss", "grenade_toss", "antigrav_breach");
  level.var_EC85["scar2"]["lab_airlock_close_intro"] = % europa_airlock_xo_door_intro;
  level.var_EC85["scar2"]["lab_airlock_close_idle"][0] = % europa_airlock_xo_door_idle;
  level.var_EC85["scar2"]["lab_airlock_close"] = % europa_airlock_xo_door_close;
  level.var_EC85["generic"]["search_flashlight_left"] = % hm_grnd_yel_flashlightsearch_left;
  level.var_EC85["generic"]["search_locker"] = % ph_un_hq_listening_stand_taking_notes_loop;
  level.var_EC85["sdf1"]["airlock_open_breakout"] = % europa_airlock_locker_sdf01_react;
  level.var_EC85["sdf2"]["airlock_open_breakout"] = % europa_airlock_locker_sdf02_react;
  level.var_EC85["sdf3"]["airlock_open_breakout"] = % europa_airlock_locker_sdf03_react;
  level.var_EC85["scar1"]["new_armory_enter"] = % europa_armory_scar01_enter;
  level.var_EC85["scar2"]["new_armory_enter"] = % europa_armory_scar02_enter;
  level.var_EC85["scar1"]["office_enter_in"] = % europa_office_enter_scar01_into;
  level.var_EC85["scar1"]["office_enter_idle"][0] = % europa_office_enter_scar01_idle;
  level.var_EC85["scar1"]["office_enter_go"] = % europa_office_enter_scar01_out;
  level.var_EC85["scar2"]["office_enter_tapgo"] = % europa_office_enter_scar02_tap;
  scripts\sp\anim::func_17FC("scar2", "scar01_out_start", "nt_notify_tapandgo", "office_enter_tapgo");
  level.var_EC85["generic"]["sdf_seeker_pulltable_sc"] = % europa_gunrange_sdf01_pulltable;
  level.var_EC85["scar1"]["cutter_entry_scars"] = % europa_armory_scar01_enter;
  level.var_EC85["scar2"]["cutter_entry_scars"] = % europa_armory_scar02_enter;
  level.var_EC85["scar1"]["armory_vault_reaction"] = % europa_armory_scar02_back_away;
  level.var_EC85["scar2"]["selfdestruct"] = % europa_armory_scar01_self_destruct;
  scripts\sp\anim::func_17F6("scar2", "give_weapon", ::func_C0D7, "selfdestruct");
  level.var_EC85["scar2"]["selfdestruct_alt"] = % europa_armory_scar01_self_destruct_alt;
  scripts\sp\anim::func_17F6("scar2", "give_weapon", ::func_C0D7, "selfdestruct_alt");
  level.var_EC85["scar1"]["fspar_boot_intro"] = % europa_armory_ally_starting_up_fspar_intro;
  level.var_EC85["scar1"]["fspar_boot_idle"][0] = % europa_armory_ally_starting_up_fspar_idle;
  level.var_EC85["scar1"]["fspar_boot_exit"] = % europa_armory_ally_starting_up_fspar_exit;
  level.var_EC85["scar1"]["fspar_suckout"] = % europa_end_ally_suckout;
  scripts\sp\anim::func_17FA("scar1", "impact", "decompress_blackout", "fspar_suckout");
  level.scr_sound["scar1"]["decompress_intro"] = "europa_tee_scramblingtofinds";
  level.var_EC85["scar1"]["decompress_intro"] = % europa_end_tunnel_scar_02_hangon_intro;
  level.var_EC85["scar1"]["decompress_loop"][0] = % europa_end_tunnel_scar_02_hangon_idle;
  level.var_EC85["scar1"]["right_decompress"] = % europa_end_tunnel_scar_02_scene;
  scripts\sp\anim::func_17FA("scar1", "hit_player", "decompress_blackout", "right_decompress");
  level.var_EC85["scar1"]["left_decompress"] = % europa_end_tunnel_scar_02_scene_left;
  scripts\sp\anim::func_17FA("scar1", "hit_player", "decompress_blackout", "left_decompress");
  level.var_EC85["scar2"]["decompress"] = % europa_end_tunnel_scar_01_suckout;
  level.scr_sound["scar2"]["decompress"] = "europa_sip_arrrhhhhhhgettings";
  level.var_EC85["generic"]["decompress"][0] = % europa_end_tunnel_scar_01_suckout_rel;
  level.var_EC85["scar1"]["outro"] = % europa_end_scar01_scene;
  scripts\sp\anim::func_17F6("scar1", "headsmash", ::func_8CA1, "outro");
  level.var_EC85["scar2"]["outro"] = % europa_end_scar02_scene;
  scripts\sp\anim::func_17F6("scar2", "headsmash", ::func_8CA1, "outro");
  level.var_EC85["sdf1"]["outro"] = % europa_end_sdf01_scene;
  scripts\sp\anim::func_17F6("sdf1", "kill_me", ::func_C7C7, "outro");
  level.var_EC85["sdf2"]["outro"] = % europa_end_sdf02_scene;
  scripts\sp\anim::func_17F6("sdf2", "first_hit", ::func_C7BF, "outro");
  scripts\sp\anim::func_17F6("sdf2", "hit", ::func_C7C5, "outro");
  scripts\sp\anim::func_17F6("sdf2", "focus_on_me", ::func_C7C4, "outro");
  scripts\sp\anim::func_17F6("sdf2", "raise_fist", ::func_C7CE, "outro");
  level.var_EC85["sdf3"]["outro"] = % europa_end_sdf03_scene;
  level.var_EC85["sdf4"]["outro"] = % europa_end_sdf04_scene;
  level.var_EC85["kotch"]["outro"] = % europa_end_kotch_scene;
  scripts\sp\anim::func_17FC("kotch", "kotch_kneel", "kotch_kneel", "outro");
  scripts\sp\anim::func_17FC("kotch", "kotch_stands", "kotch_stands", "outro");
  scripts\sp\anim::func_17FC("kotch", "kotch_kneel2", "kotch_kneel2", "outro");
  scripts\sp\anim::func_17F6("kotch", "fire", ::func_C7BE, "outro");
  scripts\sp\anim::func_17F6("kotch", "oxygen_in", ::func_C7CB, "outro");
  scripts\sp\anim::func_17F6("kotch", "oxygen_out", ::func_C7CC, "outro");
  scripts\sp\anim::func_17F6("kotch", "detach_canister", ::func_C7BA, "outro");
  level.var_EC85["generic"]["generic_dead_civ_01"] = % generic_dead_civ_01;
  level.var_EC85["generic"]["generic_dead_civ_02"] = % generic_dead_civ_02;
  level.var_EC85["generic"]["generic_dead_civ_03"] = % generic_dead_civ_03;
  level.var_EC85["generic"]["generic_dead_civ_04"] = % generic_dead_civ_04;
  level.var_EC85["generic"]["generic_dead_civ_05"] = % generic_dead_civ_05;
  level.var_EC85["generic"]["generic_dead_civ_06"] = % generic_dead_civ_06;
  level.var_EC85["generic"]["generic_dead_civ_07"] = % generic_dead_civ_07;
  level.var_EC85["generic"]["europa_labs_dead_pose01"] = % europa_labs_dead_pose01;
  level.var_EC85["generic"]["europa_labs_dead_pose02"] = % europa_labs_dead_pose02;
  level.var_EC85["generic"]["europa_labs_dead_pose03"] = % europa_labs_dead_pose03;
  level.var_EC85["generic"]["europa_labs_dead_pose04"] = % europa_labs_dead_pose04;
  level.var_EC85["generic"]["europa_labs_rail_dead_pose_01"] = % europa_labs_rail_dead_pose_01;
  level.var_EC85["generic"]["hm_grnd_yel_patrol_react_to_combat_6_ar"] = % hm_grnd_yel_patrol_react_to_combat_6_ar;
  level.var_EC85["generic"]["hm_grnd_yel_patrol_react_to_combat_2_ar"] = % hm_grnd_yel_patrol_react_to_combat_2_ar;
  level.var_EC85["generic"]["hm_grnd_yel_patrol_react_to_combat_4_ar"] = % hm_grnd_yel_patrol_react_to_combat_4_ar;
}

func_12921(var_0) {
  playFX(scripts\engine\utility::getfx("vfx_eu_icecave_landing_kickup_sml"), scripts\sp\utility::func_864C(var_0.origin));
}

func_12924(var_0) {
  var_0.var_38DF = 1;
  var_0 notify("cannot_interupt");
}

func_C7C7(var_0) {
  playFX(scripts\engine\utility::getfx("deathfx_bloodpool_generic"), var_0 gettagorigin("j_head"), (0, 0, 1));
  var_0.a.nodeath = 1;
  var_0 _meth_81D0();
}

func_C7BE(var_0) {
  if(!isDefined(var_0.var_6D66)) {
    var_0.var_6D66 = 1;
    return;
  }

  playFXOnTag(scripts\engine\utility::getfx("kotch_muzzleflash"), level.var_A70E.var_1FB6, "tag_flash");
  var_1 = scripts\engine\utility::getfx("outro_gun_impact");
  var_2 = anglesToForward(level.var_A70E.origin - level.var_C7D2.origin);
  var_3 = anglestoright(level.var_C7D2.origin - level.var_A70E.origin);
  var_4 = anglestoup(level.var_C7D2.origin - level.var_A70E.origin);
  var_5 = level.var_C7D2 gettagorigin("j_head");
  var_5 = var_5 + var_3 * -3;
  var_5 = var_5 + var_4 * -5;
  playFX(var_1, var_5, var_2);
  var_6 = scripts\engine\utility::spawn_tag_origin(var_5, vectortoangles(var_2));
  var_6 linkto(level.var_C7D2, "j_spineupper");
  playFXOnTag(scripts\engine\utility::getfx("outro_gun_impact_leak"), var_6, "tag_origin");
  wait(3.75);
  stopFXOnTag(scripts\engine\utility::getfx("outro_gun_impact_leak"), var_6, "tag_origin");
}

func_C7BB(var_0) {
  var_0.var_1FB6 hide();
}

func_C7CB(var_0) {
  level.var_8E0F = "good";
  level.player notify("o2_in");
}

func_C7CC(var_0) {
  level.var_8E0F = "depleted";
  level.player notify("o2_out");
}

func_C7BA(var_0) {
  var_1 = "tag_accessory_right";
  var_2 = var_0 gettagorigin(var_1);
  var_3 = var_0 gettagangles(var_1);
  var_4 = spawn("script_model", var_2);
  var_4.angles = var_3;
  var_4 setModel("oxygen_bottle_air_boss");
  wait(0.05);
  var_0 detach("oxygen_bottle_air_boss", var_1);
}

func_8E1D(var_0) {
  playFX(level.var_7649["human_gib_head"], var_0 gettagorigin("j_head"), (0, 0, 1));
  playFX(scripts\engine\utility::getfx("deathfx_bloodpool_generic"), var_0 gettagorigin("j_head"), (0, 0, 1));
  var_0.var_C065 = 1;
  var_0 thread scripts\sp\utility::func_19D3();
  var_0 givescorefortrophyblocks();
}

func_8CA1(var_0) {
  playFX(scripts\engine\utility::getfx("deathfx_bloodpool_generic"), var_0 gettagorigin("j_head"), (0, 0, 1));
  var_0 lib_0C60::func_8C99();
  var_0 detach(var_0.hatmodel);
  if(var_0 == level.var_EBBB) {
    var_0 attach("helmet_hero_sipes_crushed");
    return;
  }

  var_0 attach("helmet_hero_t_crushed");
}

func_C7BF(var_0) {
  level.player viewkick(100, var_0.origin, 0);
  level.player thread func_54D7(0.5, 2, 0.5);
  level.player thread scripts\sp\gameskill::func_2BDB(2, 0.5);
  var_1 = getEntArray("europa_lights_outro_2", "targetname");
  foreach(var_3 in var_1) {
    var_3 setlightintensity(0);
  }
}

func_54D7(var_0, var_1, var_2) {
  level.player _meth_809A(var_0, var_1);
  wait(var_2);
  level.player _meth_809A(0, 1);
}

func_C7C5(var_0) {
  if(!isDefined(var_0.var_902B)) {
    var_0.var_902B = 0;
  }

  if(scripts\sp\utility::func_93A6() && !isDefined(level.player.helmet)) {
    level.player.helmet = level.var_10964.helmet;
  }

  var_0.var_902B++;
  var_1 = 1;
  if(var_0.var_902B == 1) {
    level.player thread scripts\sp\gameskill::func_2BDB(2.5, 0.5);
    level.player _meth_809A(0.25, 2);
    level.player.helmet setModel("vm_hero_protagonist_helmet_glass_crack_02_clear");
    level.player playSound("scn_europa_outro_plr_helmet_glass_break_01");
    level.player scripts\engine\utility::delaythread(0.2, ::scripts\sp\utility::play_sound_on_entity, "europa_plr_end_efforts_2");
    level.player notify("sfx_beep_fade");
  } else if(var_0.var_902B == 2) {
    level.player thread scripts\sp\gameskill::func_2BDB(2.7, 0.5);
    level.player _meth_809A(0.5, 2);
    level.player.helmet setModel("vm_hero_protagonist_helmet_glass_crack_03_clear");
    level.player playSound("scn_europa_outro_plr_helmet_glass_break_03");
    level.player scripts\engine\utility::delaythread(0.2, ::scripts\sp\utility::play_sound_on_entity, "europa_plr_end_efforts_3");
  } else if(var_0.var_902B == 3) {
    thread scripts\sp\hud::func_8DF7(0.05);
    level.player _meth_809A(0, 1);
    level.player scripts\engine\utility::delaythread(0.2, ::scripts\sp\utility::play_sound_on_entity, "europa_plr_end_efforts_4");
    wait(0.15);
    level.player playSound("scn_europa_outro_plr_helmet_glass_break_04");
    func_C7CD();
    wait(0.05);
    var_1 = 0;
    level.player.var_E505 _meth_82B1(level.player.var_E505 scripts\sp\utility::func_7DC1("outro"), 0);
    var_0 _meth_82B1(var_0 scripts\sp\utility::func_7DC1("outro"), 0);
    level.player freezecontrols(1);
    setomnvar("ui_show_compass", 1);
    scripts\engine\utility::flag_set("outro_freeze");
  }

  if(var_1) {
    level.player viewkick(100, var_0.origin, 0);
  }
}

func_C7CD() {
  var_0 = anglesToForward(level.player getplayerangles());
  playFX(scripts\engine\utility::getfx("outro_player_glass_punch"), level.player getEye(), var_0);
  if(scripts\sp\utility::func_93A6()) {
    level.var_10964.helmet delete();
    return;
  }

  level.player.helmet delete();
}

func_C7C4(var_0) {
  level.player notify("connor");
  level notify("stop_dof_target_thread");
  level.var_584B = var_0;
  level.var_5844 = 1;
}

func_C7CE(var_0) {
  var_1 = 0.4;
  var_2 = 0.05;
  var_3 = 1;
  var_4 = [level.player.var_E505, var_0];
  foreach(var_6 in var_4) {
    var_6 thread func_AB76(var_6 scripts\sp\utility::func_7DC1("outro"), var_1, var_3, var_2);
  }

  wait(0.5);
  foreach(var_6 in var_4) {
    var_6 thread func_AB76(var_6 scripts\sp\utility::func_7DC1("outro"), var_1, var_2, var_3);
  }
}

func_AB76(var_0, var_1, var_2, var_3) {
  self notify("stop_lerp_animrate");
  self endon("stop_lerp_animrate");
  var_4 = var_1 * 20;
  var_5 = var_3 - var_2 / var_4;
  for(var_6 = 0; var_6 < var_4; var_6++) {
    var_2 = var_2 + var_5;
    self _meth_82B1(var_0, var_2);
    wait(0.05);
  }

  self _meth_82B1(var_0, var_3);
}

func_3353() {
  level.var_EC87["c6"] = #animtree;
  level.var_EC8C["c6"] = "robot_c6";
  level.var_EC85["c6"]["locker_deploy"] = % c6_grnd_red_exposed_rack_arm_spawn_ar;
  level.var_EC85["generic"]["robot_through_window"] = % traverse_window_m_2_run;
  level.var_EC85["c61"]["outro"] = % europa_end_c6_01_scene;
  level.var_EC85["c62"]["outro"] = % europa_end_c6_02_scene;
}

func_3508() {
  level.var_EC87["c12"] = #animtree;
  level.var_EC8C["c12"] = "robot_c12";
}

player() {
  level.var_EC87["player_rig"] = #animtree;
  level.var_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
  level.var_EC85["player_rig"]["europa_dropship_idle"][0] = % europa_dropship_intro_plr_idle;
  level.var_EC85["player_rig"]["europa_dropship_intro"] = % europa_dropship_intro_plr_scene;
  scripts\sp\anim::func_17FA("player_rig", "vo_europa_rpr_warlordactual", "nt_flag_warlordactual", "europa_dropship_intro");
  scripts\sp\anim::func_17FA("player_rig", "vo_europa_rpr_goindark", "nt_flag_going_dark", "europa_dropship_intro");
  scripts\sp\anim::func_17FA("player_rig", "visor_lower", "nt_flag_visor_lower", "europa_dropship_intro");
  scripts\sp\anim::func_17F6("player_rig", "visor_lower", ::func_67AF, "europa_dropship_intro");
  scripts\sp\anim::func_17FA("player_rig", "nt_thirty_seconds", "nt_thirty_seconds", "europa_dropship_intro");
  scripts\sp\anim::func_17FA("player_rig", "nt_twenty_seconds", "nt_twenty_seconds", "europa_dropship_intro");
  scripts\sp\anim::func_17FA("player_rig", "nt_ten_seconds", "nt_ten_seconds", "europa_dropship_intro");
  level.var_EC85["player_rig"]["europa_dropship_halo_jump"] = % europa_dropship_intro_plr_halo_jump_all;
  level.var_EC85["player_rig"]["europa_dropship_halo_land"] = % europa_dropship_intro_plr_halo_land;
  level.var_EC85["player_rig"]["europa_dropship_halo_land_rel"] = % europa_dropship_intro_plr_halo_land_rel;
  level.var_EC85["player_rig"]["europa_dropship_halo_land_death"] = % europa_dropship_intro_plr_halo_death;
  level.var_EC85["player_rig"]["europa_dropship_halo_death_rel"] = % europa_dropship_intro_plr_halo_death_rel;
  level.var_EC85["player_rig"]["cliffjumper"] = % europa_landing_takedown_a_plr;
  level.var_EC85["player_rig"]["cliffjumper_loop"] = % europa_landing_takedown_melee_loop_a_plr;
  level.var_EC85["player_rig"]["cliffjumper_kill"] = % europa_landing_takedown_melee_kill_a_plr;
  level.var_EC85["player_rig"]["cliffjumper_exit"] = % europa_landing_takedown_shoot_exit_a_plr;
  scripts\sp\anim::func_17F6("player_rig", "knife_attach", ::func_D1B0, "cliffjumper");
  scripts\sp\anim::func_17F6("player_rig", "head_crack", ::func_8C5B, "cliffjumper");
  scripts\sp\anim::func_17FA("player_rig", "kick_done", "cliffjump_kick_done", "cliffjumper");
  scripts\sp\anim::func_17FA("player_rig", "boost_end", "boost_required_end", "cliffjumper");
  scripts\sp\anim::func_17FC("player_rig", "stab", "stab", "cliffjumper_kill");
  level.var_EC85["player_rig"]["antigrav_breach"] = % europa_airlock_plr_grav_grenade_scene;
  scripts\sp\anim::func_17FA("player_rig", "door_ajar", "door_ajar", "antigrav_breach");
  scripts\sp\anim::func_17FA("player_rig", "door_kick", "door_kick", "antigrav_breach");
  level.var_EC85["player_rig"]["selfdestruct"] = % europa_armory_plr_self_destruct;
  scripts\sp\anim::func_17F5("player_rig", "attach_weapon", "weapon_steeldragon_sp_wm", "tag_accessory_right", "selfdestruct");
  scripts\sp\anim::func_17FA("player_rig", "open_doors", "open_armory_doors", "selfdestruct");
  scripts\sp\anim::func_17FA("player_rig", "lookdown", "armory_lookdown", "selfdestruct");
  scripts\sp\anim::func_17FA("player_rig", "pvo_europa_plr_bootitupsipes", "sipes_mount_fspar", "selfdestruct");
  scripts\sp\anim::func_17FC("player_rig", "dof1", "dof_change", "selfdestruct");
  scripts\sp\anim::func_17FC("player_rig", "dof2", "dof_change", "selfdestruct");
  scripts\sp\anim::func_17FC("player_rig", "dof3", "dof_change", "selfdestruct");
  level.var_EC85["player_rig"]["decompress_loop"] = % europa_end_tunnel_plr_suckout_idle;
  level.var_EC85["player_rig"]["right_decompress"] = % europa_end_tunnel_plr_suckout_scene;
  level.var_EC85["player_rig"]["left_decompress"] = % europa_end_tunnel_plr_suckout_scene_left;
  level.var_EC85["player_rig"]["fspar_suckout"] = % europa_plr_fires_large_steel_dragon_suckout;
  level.var_EC85["player_rig"]["fspar_idle"][0] = % europa_plr_fires_large_steel_dragon_idle;
  level.var_EC85["player_rig"]["fspar_fire"] = % europa_plr_fires_large_steel_dragon_button_press;
  scripts\sp\anim::func_17FA("player_rig", "holding_on", "player_holding_on", "fspar_suckout");
  scripts\sp\anim::func_17F6("player_rig", "player_scream", ::func_D015, "decompress");
  level.var_EC85["player_rig"]["outro"] = % europa_end_plr_scene;
  level.var_C7D5 = getanimlength(level.var_EC85["player_rig"]["outro"]);
  scripts\sp\anim::func_17F6("player_rig", "oxygen_depleted", ::func_C7CA, "outro");
  scripts\sp\anim::func_17FC("player_rig", "look_at_friendlies", "look_at_friendlies", "outro");
  level.var_EC85["player_rig"]["fire_fspar"] = % europa_plr_fires_large_steel_dragon;
}

func_8C5B(var_0) {
  var_1 = (29221, -5369, -76);
  playFX(level._effect["small_cracks"], var_1);
}

func_12922(var_0) {
  var_1 = spawn("script_model", var_0 gettagorigin("tag_accessory_right"));
  var_1.angles = var_0 gettagangles("tag_accessory_right");
  var_1 linkto(var_0, "tag_accessory_right");
  var_1 setModel("tactical_knife_iw7_wm");
  level waittill("scar_stab");
  playFX(scripts\engine\utility::getfx("player_stab"), var_1 gettagorigin("tag_knife_fx"));
  level waittill("knife_off");
  var_1 delete();
}

func_12923(var_0) {
  var_0 func_8E18();
  level.player playSound("scn_cave_jump_boostkill");
}

func_8E18(var_0) {
  if(!isDefined(self.hatmodel)) {
    return;
  }

  var_1 = self gettagorigin("j_head");
  var_2 = anglesToForward(self gettagangles("j_head"));
  playFX(scripts\engine\utility::getfx("helmet_sdf_army_broken_europa"), var_1, var_2);
  if(isDefined(self.var_8E1E)) {
    self.var_8E1E = undefined;
    var_3 = self _meth_850C("helmet", "helmet");
    if(var_3 > 0) {
      self _meth_850B(var_3, "helmet", "helmet");
    }
  }

  self detach(self.hatmodel, "");
  self.hatmodel = undefined;
}

func_D1B0(var_0) {
  level endon("scar_saved_player");
  level.var_4214 = spawn("script_model", level.player.origin);
  level.var_4214 setModel("tactical_knife_iw7_vm");
  level.var_4214 linkto(level.player.var_D267, "tag_accessory_left", (0, 0, 0), (0, 0, 0));
  level.var_4214 hide();
  thread scripts\engine\utility::flag_set_delayed("teleport_scar1", 3);
  level waittill("stab");
  scripts\engine\utility::exploder("enemy_ground_impact");
  playFX(scripts\engine\utility::getfx("player_stab"), level.var_4214 gettagorigin("tag_knife_fx"));
  playFX(scripts\engine\utility::getfx("vfx_eu_icecave_takedown_bloodpool"), level.var_4214 gettagorigin("tag_knife_fx"));
}

func_67AF(var_0) {
  setglobalsoundcontext("atmosphere", "helmet", 1);
}

func_D015(var_0) {
  thread scripts\sp\utility::func_1034F("europa_plr_effortsholdingontod");
}

func_C7CA(var_0) {
  level.var_8E0F = "depleted";
}

func_13267() {
  level.var_EC87["dropship"] = #animtree;
  level.var_EC85["dropship"]["europa_dropship_intro"] = % europa_dropship_intro_dropship_start;
}

func_EE25() {
  level.var_EC87["script_model"] = #animtree;
  level.var_EC87["desk"] = #animtree;
  level.var_EC85["cutter"]["cutter_crawl"][0] = % europa_seeker_forward_in_place;
  level.var_EC85["desk"]["sdf_seeker_pulltable_sc"] = % europa_gunrange_desk_pulltable;
  level.var_EC85["script_model"]["c12_pose_02"] = % europa_labs_c12_02_hanging_idle;
  level.var_EC85["script_model"]["c12_pose_03"] = % europa_labs_c12_03_hanging_idle;
  level.var_EC85["door"]["lab_airlock_close"] = % europa_airlock_door_close;
  level.var_EC87["tag_origin_mover"] = #animtree;
  level.var_EC8C["tag_origin_mover"] = "tag_origin";
  level.var_EC85["tag_origin_mover"]["new_armory_enter"] = % europa_armory_seeker_door_fall;
  level.var_EC87["locker_arm"] = #animtree;
  level.var_EC8C["locker_arm"] = "veh_mil_air_ca_drop_pod_arm";
  level.var_EC85["locker_arm"]["locker_deploy"] = % c6_grnd_red_exposed_rack_arm_spawn_arm;
  level.var_EC87["fhr40"] = #animtree;
  level.var_EC8C["fhr40"] = "weapon_fhr40_wm";
  level.var_EC85["fhr40"]["airlock_response"] = % europa_airlock_fhr40_reload_scene;
  level.var_EC85["fhr40"]["europa_dropship_intro"] = % europa_dropship_intro_fhr40_scene;
  level.var_EC87["antigrav_door"] = #animtree;
  level.var_EC85["antigrav_door"]["antigrav_breach"] = % europa_airlock_grav_grenade_scene;
  level.var_EC87["selfdestruct_console"] = #animtree;
  level.var_EC85["selfdestruct_console"]["selfdestruct"] = % europa_armory_plr_self_destruct_console;
  level.var_EC85["selfdestruct_console"]["selfdestruct_alt"] = % europa_armory_plr_self_destruct_console_alt;
  level.var_EC87["flag"] = #animtree;
  level.var_EC8C["flag"] = "ctf_game_flag_nostand";
  level.var_EC85["flag"]["outro"] = % europa_end_sdf_flag_scene;
  level.var_EC8C["fspar"] = "weapon_steeldragon_wm";
  level.var_EC87["script_model_corpse"] = #animtree;
  level.var_EC85["script_model_corpse"]["generic_dead_civ_01"] = % generic_dead_civ_01;
  level.var_EC85["script_model_corpse"]["generic_dead_civ_02"] = % generic_dead_civ_02;
  level.var_EC85["script_model_corpse"]["generic_dead_civ_03"] = % generic_dead_civ_03;
  level.var_EC85["script_model_corpse"]["generic_dead_civ_04"] = % generic_dead_civ_04;
  level.var_EC85["script_model_corpse"]["generic_dead_civ_05"] = % generic_dead_civ_05;
  level.var_EC85["script_model_corpse"]["generic_dead_civ_06"] = % generic_dead_civ_06;
  level.var_EC85["script_model_corpse"]["generic_dead_civ_07"] = % generic_dead_civ_07;
  level.var_EC85["script_model_corpse"]["europa_labs_dead_pose01"] = % europa_labs_dead_pose01;
  level.var_EC85["script_model_corpse"]["europa_labs_dead_pose02"] = % europa_labs_dead_pose02;
  level.var_EC85["script_model_corpse"]["europa_labs_dead_pose03"] = % europa_labs_dead_pose03;
  level.var_EC85["script_model_corpse"]["europa_labs_dead_pose04"] = % europa_labs_dead_pose04;
  level.var_EC85["script_model_corpse"]["europa_labs_rail_dead_pose_01"] = % europa_labs_rail_dead_pose_01;
  level.var_EC87["kotch_gun"] = #animtree;
  level.var_EC8C["kotch_gun"] = "weapon_emc_wm";
  level.var_EC85["kotch_gun"]["outro"] = % europa_end_emcpistol_scene;
}

func_12920(var_0) {
  if(isDefined(var_0.var_B14F)) {
    var_0 scripts\sp\utility::func_1101B();
  }

  var_0.var_EF = 1;
  var_0.var_DC1A = 1;
  var_0.var_30 = 1;
  var_0 scripts\sp\utility::func_F2DA(0);
  var_0 _meth_81D0();
}

func_C0C7(var_0) {
  if(isDefined(var_0.var_B14F)) {
    var_0 scripts\sp\utility::func_1101B();
  }

  var_0.a.nodeath = 1;
  var_0 scripts\sp\utility::func_54C6();
}

func_7348(var_0) {
  level endon("fpar_fire_stop");
  for(;;) {
    var_0 _meth_8494("iw7_steeldragon", level.var_21F7 gettagorigin("tag_flash"), level.var_21F7 gettagangles("tag_flash"));
    wait(0.05);
  }
}

func_F1EC(var_0) {
  setomnvar("ui_europa_selfdestruct", 1);
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  level.player playSound("europa_armory_self_destruct_ui");
  cinematicingame("europa_selfdestruct");
  while(!iscinematicplaying()) {
    wait(0.05);
  }

  thread scripts\sp\art::func_583F(0, 4, 10, 5, 15, 150, 0.5);
  scripts\engine\utility::delaythread(3.5, ::scripts\sp\art::func_583D, 1);
  while(iscinematicplaying()) {
    wait(0.05);
  }

  stopcinematicingame();
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "1");
  setomnvar("ui_europa_selfdestruct", 0);
}

func_C0D7(var_0) {
  scripts\engine\utility::flag_set("scar1_moveto_fspar");
  scripts\sp\maps\europa\europa_util::func_117FF(75);
  var_1 = "iw7_steeldragon+europaspeedmod";
  level.player giveweapon(var_1);
  level.player switchtoweaponimmediate(var_1);
}

func_F2DF(var_0) {
  if(!isDefined(self.var_1310C)) {
    level.var_11B30.var_2AA2 glinton(#animtree);
    level.var_11B30.var_2AA2.var_1310C = 1;
  }

  level.var_11B30.var_2AA2 notify("stop_idle_thread");
  var_1["powerup"] = % steel_dragon_powerup;
  var_1["idle"] = % steel_dragon_idle;
  var_1["fire"] = % steel_dragon_fire;
  var_1["powerdown"] = % steel_dragon_powerdown;
  var_2 = "bfganim";
  level.var_11B30.var_2AA2 clearanim( % root, 0.2);
  if(var_0 == "idle") {
    level.var_11B30.var_2AA2 thread func_2AA4(var_1[var_0]);
  }

  level.var_11B30.var_2AA2 _meth_82E1(var_2, var_1[var_0], 1, 0.2, 1);
  if(var_0 == "fire") {
    thread func_2AA3();
  }

  if(var_0 != "idle") {
    level.var_11B30.var_2AA2 waittillmatch("end", var_2);
  }
}

func_2AA4(var_0) {
  self endon("death");
  self endon("stop_idle_thread");
  wait(0.05);
  var_1 = 1;
  for(;;) {
    wait(randomfloatrange(2, 5));
    var_2 = randomfloatrange(3, 5);
    var_3 = randomfloatrange(0.2, 1);
    var_4 = var_3 - var_1;
    var_5 = int(var_2 / 0.05);
    var_6 = var_4 / var_5;
    for(var_7 = 0; var_7 < var_5; var_7++) {
      var_1 = var_1 + var_6;
      self _meth_82B1(var_0, var_1);
      wait(0.05);
    }

    var_1 = var_3;
    self _meth_82B1(var_0, var_1);
  }
}

func_2AA3() {
  wait(0.8);
  level.var_11B30.var_113F2 playSound("scn_europa_fspar_fire");
  thread scripts\sp\maps\europa\europa_armory::func_3532();
  wait(2);
}