/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\black_ice_catwalks.gsc
***************************************/

section_flag_inits() {
  common_scripts\utility::flag_init("flag_cw_bravo_breach_1");
  common_scripts\utility::flag_init("flag_cw_bravo_breach_2");
  common_scripts\utility::flag_init("flag_cw_bravo_breach");
  common_scripts\utility::flag_init("flag_start_retreat");
  common_scripts\utility::flag_init("flag_low_retreat");
  common_scripts\utility::flag_init("flag_low_runaway");
  common_scripts\utility::flag_init("flag_stairs_kill");
  common_scripts\utility::flag_init("flag_mid_start");
  common_scripts\utility::flag_init("flag_low_runaway_again");
  common_scripts\utility::flag_init("flag_mid_retreat");
  common_scripts\utility::flag_init("flag_high_retreat");
  common_scripts\utility::flag_init("flag_high_dead");
  common_scripts\utility::flag_init("flag_no_catwalk_kill");
  common_scripts\utility::flag_init("flag_vig_catwalk_kill");
  common_scripts\utility::flag_init("flag_tape_breach_ally1");
  common_scripts\utility::flag_init("flag_tape_breach_ally2");
  common_scripts\utility::flag_init("flag_cw_breach_vo_ready");
  common_scripts\utility::flag_init("flag_catwalks_end");
  common_scripts\utility::flag_init("flag_barracks_go_fast");
  common_scripts\utility::flag_init("flag_barracks_ally1_ready");
  common_scripts\utility::flag_init("flag_barracks_ally2_ready");
  common_scripts\utility::flag_init("flag_barracks_sweep_start");
  common_scripts\utility::flag_init("flag_player_in_barracks_room1");
  common_scripts\utility::flag_init("flag_player_in_barracks_room2");
  common_scripts\utility::flag_init("flag_barracks_opfor_attack");
  common_scripts\utility::flag_init("flag_barracks_cleared");
  common_scripts\utility::flag_init("flag_common_player_ready");
  common_scripts\utility::flag_init("flag_common_ai_ready");
  common_scripts\utility::flag_init("flag_common_breach");
  common_scripts\utility::flag_init("flag_common_breach_ally_start");
  common_scripts\utility::flag_init("flag_common_breach_done");
  common_scripts\utility::flag_init("flag_common_player_inside");
  common_scripts\utility::flag_init("flag_common_reinforce");
  common_scripts\utility::flag_init("flag_common_retreat");
  common_scripts\utility::flag_init("flag_common_end");
  common_scripts\utility::flag_init("flag_common_cleanup");
  common_scripts\utility::flag_init("flag_common_cleared");
  common_scripts\utility::flag_init("cw_gps_tape_breach");
  common_scripts\utility::flag_init("cw_gps_common_door");
}

section_post_inits() {
  getent("cw_gold_common_room_breach", "targetname") hide();
}

section_

start_catwalks() {
  iprintln("Catwalks");
  maps\black_ice_util::player_start("player_start_catwalks");
  var_0 = common_scripts\utility::getstruct("cw_start_ally1", "targetname");
  level._allies[0] forceteleport(var_0.origin, var_0.angles);
  var_0 = common_scripts\utility::getstruct("cw_start_ally2", "targetname");
  level._allies[1] forceteleport(var_0.origin, var_0.angles);
  common_scripts\utility::flag_set("bc_flag_spots_off");
  var_1 = getent("cw_trig_start_spawn", "script_noteworthy");
  var_1 maps\_utility::notify_delay("trigger", 0.1);
  common_scripts\utility::exploder("catwalks_snow");
  common_scripts\utility::exploder("catwalks_lights");
  thread catwalk_godrays();
  thread maps\black_ice_ascend::hanging_cargo_motion();
  thread maps\_utility::notify_delay("notify_ascend_rubberband_alpha_stop", 1.1);
  maps\_utility::delaythread(1.1, common_scripts\utility::flag_set, "flag_ascend_end");
}

start_catwalks_end() {
  iprintln("Catwalks End");
  maps\black_ice_util::player_start("player_start_catwalks_end");
  var_0 = common_scripts\utility::getstruct("cwe_start_ally1", "targetname");
  level._allies[0] forceteleport(var_0.origin, var_0.angles);
  var_0 = common_scripts\utility::getstruct("cwe_start_ally2", "targetname");
  level._allies[1] forceteleport(var_0.origin, var_0.angles);
  common_scripts\utility::array_thread(level._allies, maps\_utility::set_grenadeammo, 0);
  setup_spawners();
  var_1 = getEntArray("cw_trig_enable_cqb", "script_noteworthy");
  common_scripts\utility::array_thread(var_1, ::trig_enable_cqb);
  var_1 = getEntArray("cw_trig_disable_cqb", "script_noteworthy");
  common_scripts\utility::array_thread(var_1, ::trig_disable_cqb);
  var_0 = getent("cw_vig_tape_breach", "targetname");
  level.tape_breach_door = maps\_utility::spawn_anim_model("tape_breach_door");
  var_0 maps\_anim::anim_first_frame_solo(level.tape_breach_door, "cw_tape_breach");
  thread maps\black_ice_ascend::hanging_cargo_motion();
  var_2 = getent("cw_color_exit_door", "targetname");
  var_2 notify("trigger");
  common_scripts\utility::flag_set("flag_vig_catwalk_kill");
  level.tele_catwalks_end = 1;
}

start_barracks() {
  iprintln("Barracks");
  maps\black_ice_util::player_start("player_start_barracks");
  var_0 = common_scripts\utility::getstruct("cwb_start_ally1", "targetname");
  level._allies[0] forceteleport(var_0.origin, var_0.angles);
  var_0 = common_scripts\utility::getstruct("cwb_start_ally2", "targetname");
  level._allies[1] forceteleport(var_0.origin, var_0.angles);
  common_scripts\utility::array_thread(level._allies, maps\_utility::set_grenadeammo, 0);
  setup_spawners();
  var_1 = getEntArray("cw_trig_enable_cqb", "script_noteworthy");
  common_scripts\utility::array_thread(var_1, ::trig_enable_cqb);
  var_1 = getEntArray("cw_trig_disable_cqb", "script_noteworthy");
  common_scripts\utility::array_thread(var_1, ::trig_disable_cqb);
  common_scripts\utility::array_call(getEntArray("cw_clip_tape_breach_door", "targetname"), ::delete);
  common_scripts\utility::array_call(getEntArray("cw_clip_tape_breach", "targetname"), ::delete);
  wait 0.05;
  common_scripts\utility::array_thread(level._allies, maps\_utility::set_force_cover, 0);
  common_scripts\utility::array_thread(level._allies, maps\_utility::disable_ai_color);
  var_0 = getnode("cwb_node_start_ally1", "targetname");
  level._allies[0] thread maps\_utility::follow_path(var_0);
  var_0 = getnode("cwb_node_start_ally2", "targetname");
  level._allies[1] thread maps\_utility::follow_path(var_0);
  common_scripts\utility::exploder("barracks_ambfx");
}

start_common() {
  iprintln("Common Room");
  maps\black_ice_util::player_start("player_start_common");
  var_0 = common_scripts\utility::getstruct("cwc_start_ally1", "targetname");
  level._allies[0] forceteleport(var_0.origin, var_0.angles);
  var_0 = common_scripts\utility::getstruct("cwc_start_ally2", "targetname");
  level._allies[1] forceteleport(var_0.origin, var_0.angles);
  common_scripts\utility::array_thread(level._allies, maps\_utility::set_grenadeammo, 0);

  foreach(var_2 in level._allies) {
    var_2.old_react_dist = var_2.newenemyreactiondistsq;
  }

  setup_spawners();
  wait 0.05;
  var_4 = getnode("cwc_node_door_ally1", "targetname");
  level._allies[0] thread maps\_utility::follow_path(var_4);
  var_5 = getnode("cwc_node_door_ally2", "targetname");
  level._allies[1] thread maps\_utility::follow_path(var_5);
  common_scripts\utility::exploder("barracks_ambfx");
  maps\_utility::vision_set_fog_changes("black_ice_commonroom", 0);
}

main_catwalks() {
  thread catwalks_setup();
  thread catwalk_godrays();
  wait 1;
  thread cw_bravo_breach();
  level waittill("notify_ascend_rubberband_alpha_stop");

  foreach(var_1 in level._allies) {
    if(isDefined(var_1.old_moveplaybackrate)) {
      var_1 thread maps\_utility::set_moveplaybackrate(var_1.old_moveplaybackrate);
    }
  }

  common_scripts\utility::array_thread(level._allies, maps\_utility::set_grenadeammo, 0);
  level._allies[0] maps\_utility::set_force_color("r");
  level._allies[1] maps\_utility::set_force_color("y");
  common_scripts\utility::flag_wait("flag_ascend_end");
  thread maps\black_ice::trains_periph_logic(0.0, 0);
  maps\_utility::vision_set_fog_changes("black_ice_catwalks", 0);
  setsaveddvar("r_snowAmbientColor", (0.02, 0.02, 0.03));
  thread maps\black_ice_util::rotatelights("light_spinner_h", "light_spin_h", "yaw");
  thread maps\black_ice_util::rotatelights("light_spinner_v", "light_spin_v", "pitch");
  thread maps\black_ice_util::rotatelights("light_spinner_v2", "light_spin_v2", "pitch");
  level cw_start();
  level cw_low();
  level cw_mid();
}

catwalks_setup() {
  var_0 = getent("cw_vig_tape_breach", "targetname");
  level.tape_breach_door = maps\_utility::spawn_anim_model("tape_breach_door");
  var_0 maps\_anim::anim_first_frame_solo(level.tape_breach_door, "cw_tape_breach");
  var_1 = getEntArray("cw_trig_enable_cqb", "script_noteworthy");
  common_scripts\utility::array_thread(var_1, ::trig_enable_cqb);
  var_1 = getEntArray("cw_trig_disable_cqb", "script_noteworthy");
  common_scripts\utility::array_thread(var_1, ::trig_disable_cqb);
  setup_spawners();

  if(level._bravo.size < 2) {
    level maps\black_ice_util::spawn_bravo();
    var_0 = common_scripts\utility::getstruct("cw_start_bravo1", "targetname");
    level._bravo[0] forceteleport(var_0.origin, var_0.angles);
    var_0 = common_scripts\utility::getstruct("cw_start_bravo2", "targetname");
    level._bravo[1] forceteleport(var_0.origin, var_0.angles);
  }

  common_scripts\utility::array_thread(level._bravo, maps\_utility::set_ignoreall, 1);
}

catwalks_end() {
  thread catwalks_end_fic();
  common_scripts\utility::array_thread(level._allies, maps\black_ice_util::set_forcesuppression, 1);
  high_catwalk_kill();
  common_scripts\utility::flag_wait("flag_catwalks_end");
  cw_tape_breach();
  common_scripts\utility::array_thread(level._allies, maps\black_ice_util::set_forcesuppression, 0);
}

main_barracks() {
  maps\_utility::autosave_by_name("barracks_start");
  level cw_barracks();
}

main_common() {
  maps\_utility::autosave_by_name("common_start");
  level cw_common();
}

cw_start() {
  level.player.ignoreme = 0;
  wait 1;
  var_0 = maps\_utility::array_spawn_targetname("cw_opfor_start_door", 1);
  var_1 = maps\black_ice_util::setup_door("cw_low_door");
  var_1 thread maps\black_ice_util::open_door([126, -10], 1);
  thread maps\black_ice_audio::sfx_cw_door_open(var_1);
  wait 1;
  setthreatbias("axis", "player", 0);
  common_scripts\utility::array_thread(var_0, maps\_utility::set_ignoreall, 0);
  maps\black_ice_util::delay_retreat("cw_opfor", 60, 3, "flag_start_retreat", "cw_color_low");
}

cw_low() {
  thread cw_low_fic();
  maps\_utility::array_spawn_targetname("cw_opfor_low_balcony", undefined, 1);
  maps\_utility::flood_spawn(getEntArray("cw_opfor_low", "targetname"));
  wait 2;
  maps\_utility::flagwaitthread("flag_low_runaway", common_scripts\utility::flag_set, "flag_low_retreat");
  maps\black_ice_util::delay_retreat("cw_opfor", 90, 4, "flag_low_retreat", ["cw_color_low_retreat", "cw_color_low"], 1);
  wait 0.05;
  maps\black_ice_util::delay_retreat("cw_opfor", 60, 2, "flag_low_runaway", "cw_color_low_runaway", 1, "cw_to_mid_vo_nag");
  thread cw_low_cleanup();
  level.fixednodesaferadius_default = 100;
}

cw_low_cleanup() {
  var_0 = maps\_utility::get_ai_group_ai("bc_opfor");

  if(var_0.size > 0) {
    common_scripts\utility::array_thread(var_0, maps\_utility::set_ignoreall, 1);
  } else {
    return;
  }

  wait 3;
  var_0 = maps\_utility::array_removedead(var_0);

  if(var_0.size > 0) {
    common_scripts\utility::array_thread(var_0, maps\_utility::set_ignoreall, 0);
  }
}

cw_mid() {
  common_scripts\utility::flag_wait("flag_mid_start");
  thread cw_mid_fic();
  thread fx_snow_windtunnel();
  wait 0.05;
  maps\black_ice_util::delay_retreat("cw_opfor", 90, 2, "flag_high_retreat", ["cw_color_exit_door", "cw_color_to_high"], 1);

  if(!common_scripts\utility::flag("flag_mid_retreat")) {
    common_scripts\utility::flag_set("flag_mid_retreat");
  }

  thread maps\_spawner::killspawner(129);
  thread maps\_utility::kill_deathflag("flag_opfor_high_clear", 1.0);
  thread maps\black_ice_util::delay_retreat("cw_opfor", 90, 0, "flag_high_dead");
  level.fixednodesaferadius_default = undefined;
  wait 1;
  level._allies[0] thread goto_door_breach("cw_node_tape_breach_ally1", 1.18, "flag_tape_breach_ally1");
  level._allies[1] thread goto_door_breach("cw_node_tape_breach_ally2", 1.16, "flag_tape_breach_ally2");
}

cw_low_fic() {
  level endon("stop_low_fic");
  level waittill("cw_to_mid_vo_nag");
  level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_moveupalpha");
}

cw_mid_fic() {
  level notify("stop_low_fic");
  level endon("stop_mid_fic");
  level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_cutthroughmetal");
  wait 10;

  if(!common_scripts\utility::flag("flag_opfor_high_clear")) {
    level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_coversuseless");
  }
}

catwalks_end_fic() {
  level notify("stop_mid_fic");

  if(!isDefined(level.tele_catwalks_end)) {
    level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_fallingbackmoveup");
  }

  thread catwalks_end_cleanup_fic();
  common_scripts\utility::flag_wait_all("flag_tape_breach_ally1", "flag_catwalks_end");
  level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_shapecharges");
  common_scripts\utility::flag_set("flag_cw_breach_vo_ready");
  level waittill("cw_tape_breach_start");
  level._allies[1] thread maps\_utility::smart_dialogue("blackice_fnt_settingcharges");
  level waittill("cw_tape_breach_cover");
  level._allies[1] maps\_utility::smart_dialogue("blackice_fnt_standclear");
}

catwalks_end_cleanup_fic() {
  level endon("flag_tape_breach_ally1");
  common_scripts\utility::flag_wait("flag_high_dead");
  wait 0.25;

  if(!common_scripts\utility::flag("flag_catwalks_end")) {
    level._allies[1] maps\_utility::smart_dialogue("black_ice_hsh_wereclear");
  }

  level._allies[0] maps\_utility::smart_dialogue("black_ice_mrk_movintodeckto");
}

cw_barracks() {
  thread cw_stairs_fic();
  thread tv_watcher();
  var_0 = getent("cw_vig_hallway_sweep", "targetname");
  var_1 = maps\_utility::spawn_anim_model("hallway_door");
  var_0 maps\_anim::anim_first_frame_solo(var_1, "cw_hallsweep");
  var_2 = getent("cw_door_hallway_sweep", "targetname");
  var_2 linkto(var_1, "j_hinge");
  common_scripts\utility::flag_wait("flag_barracks_sweep_start");
  level._allies[0] thread breach_wait_move("cw_gps_hall_sweep", "cwb_node_start_ally1", "cwb_node_start_ally1_detour", ["blackice_bkr_muchtime"], "flag_barracks_go_fast");
  common_scripts\utility::array_call(level._allies, ::pushplayer, 0);
  var_3 = getent("cw_trig_common_ambush", "targetname");

  if(isDefined(var_3)) {
    thread cw_barracks_fast_trig_proc(var_3);
    thread cw_barracks_fast_shoot_proc();
  } else
    common_scripts\utility::flag_set("flag_barracks_go_fast");

  thread maps\_utility::flagwaitthread("flag_player_in_barracks_room1", maps\_anim::removenotetrack, "ally2", "fuentes_va_clear_1", "cw_hallsweep", "dialog");
  thread maps\_utility::flagwaitthread("flag_player_in_barracks_room2", maps\_anim::removenotetrack, "ally1", "baker_vo_clear_1", "cw_hallsweep", "dialog");
  level.op_barracks = maps\_utility::spawn_targetname("cw_barracks_opfor");
  cw_barracks_setup();
  cw_barracks_slow(var_0, var_1);
  cw_barracks_fast(var_1);
}

cw_barracks_setup() {
  common_scripts\utility::array_thread(level._allies, maps\_utility::disable_cqbwalk);
  common_scripts\utility::array_thread(level._allies, maps\_utility::set_ignoreall, 1);

  foreach(var_1 in level._allies) {
    if(isDefined(var_1.old_moveplaybackrate)) {
      var_1 maps\_utility::set_moveplaybackrate(var_1.old_moveplaybackrate);
    }

    var_1.old_react_dist = var_1.newenemyreactiondistsq;
    var_1.newenemyreactiondistsq = 0;
  }
}

cw_barracks_slow(var_0, var_1) {
  level endon("flag_barracks_go_fast");

  if(common_scripts\utility::flag("flag_barracks_go_fast")) {
    return;
  }
  common_scripts\utility::flag_wait_all("flag_barracks_ally1_ready", "flag_barracks_ally2_ready");
  var_2 = getnode("cwc_node_door_ally1", "targetname");
  var_3 = getnode("cwc_node_door_ally2", "targetname");

  foreach(var_5 in level._allies) {
    if(var_5.origin != var_5.goalpos) {
      wait 0.05;
    }
  }

  thread maps\black_ice_audio::hall_search_music();
  wait 0.5;
  level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_move");
  level._allies[0] maps\_utility::delaythread(1, maps\_utility::smart_dialogue, "black_ice_bkr_rookcheckyourcorners");
  var_0 thread maps\_anim::anim_generic(level.op_barracks, "cw_hallsweep");
  var_0 thread maps\_anim::anim_single_solo(var_1, "cw_hallsweep");
  var_0 thread anim_reach_play(level._allies[1], "cw_hallsweep", undefined, 0.1, undefined, var_3, 1);
  var_0 anim_reach_play(level._allies[0], "cw_hallsweep", undefined, 0.1, undefined, var_2, 1);
}

cw_barracks_fast(var_0) {
  if(!common_scripts\utility::flag("flag_barracks_go_fast")) {
    return;
  }
  if(var_0 getanimtime(var_0 maps\_utility::getanim("cw_hallsweep")) > 0.16) {
    var_1 = [level._allies[0], level._allies[1], level.op_barracks];
  } else {
    var_1 = [level._allies[0], level._allies[1], level.op_barracks, var_0];
  }

  maps\_utility::array_notify(var_1, "anim_reach_play");
  maps\_utility::array_notify(var_1, "new_anim_reach");
  common_scripts\utility::array_thread(var_1, maps\_utility::anim_stopanimscripted);
  common_scripts\utility::array_thread(level._allies, maps\_utility::disable_cqbwalk);
  common_scripts\utility::array_thread(level._allies, maps\_utility::enable_careful);
  common_scripts\utility::array_thread(level._allies, maps\_utility::set_ignoreall, 0);
  common_scripts\utility::array_thread(level._allies, maps\_utility::set_baseaccuracy, 0.25);
  level._allies[0] thread maps\_utility::set_force_color("r");
  level._allies[1] thread maps\_utility::set_force_color("y");
  var_2 = getent("cw_color_barracks_fast", "targetname");
  var_2 notify("trigger");
  var_2 common_scripts\utility::trigger_off();
  thread cw_barracks_fast_fic();
  common_scripts\utility::flag_wait("flag_barracks_cleared");
  common_scripts\utility::array_thread(level._allies, maps\_utility::set_baseaccuracy, 1);
  common_scripts\utility::array_thread(level._allies, maps\_utility::disable_careful);
  var_3 = getnode("cwc_node_door_ally1", "targetname");
  var_4 = getnode("cwc_node_door_ally2", "targetname");
  level._allies[0] thread maps\_utility::follow_path(var_3);
  level._allies[1] thread maps\_utility::follow_path(var_4);
}

cw_stairs_fic() {
  level endon("flag_barracks_sweep_start");
  wait 0.5;
  level._allies[0] maps\_utility::smart_dialogue("black_ice_mrk_dealertwothisis");
  maps\_utility::smart_radio_dialogue("black_ice_oby_copyone");
  wait 1;
  level._allies[0] maps\_utility::smart_dialogue("black_ice_mrk_pressureregulatorsareup");
  wait 1.0;
  level._allies[0] maps\_utility::smart_dialogue("black_ice_bkr_keepalertfuenteson");
}

cw_barracks_fast_fic() {
  maps\_anim::removenotetrack("ally1", "baker_vo_clear_1", "cw_hallsweep", "dialog");
  maps\_anim::removenotetrack("ally1", "baker_vo_clear_2", "cw_hallsweep", "dialog");
  maps\_anim::removenotetrack("ally2", "fuentes_va_clear_1", "cw_hallsweep", "dialog");
  common_scripts\utility::flag_wait_any("flag_barracks_opfor_attack", "flag_barracks_cleared");

  if(!common_scripts\utility::flag("flag_barracks_cleared")) {
    level._allies[1] maps\_utility::smart_dialogue("black_ice_fnt_tangowatchout");
  }

  common_scripts\utility::flag_wait("flag_barracks_cleared");
  wait 1.0;
  level._allies[0] maps\_utility::smart_dialogue("black_ice_bkr_hallwayclearletsmove");
}

cw_common() {
  common_scripts\utility::array_call(level._allies, ::pushplayer, 1);
  common_scripts\utility::flag_wait_all("flag_common_player_ready", "flag_common_ai_ready");
  thread cw_common_fic();
  common_scripts\utility::array_thread(level._allies, maps\_utility::set_ignoreall, 0);

  foreach(var_1 in level._allies) {
    var_1.newenemyreactiondistsq = var_1.old_react_dist;
  }

  var_3 = getent("cw_vig_common_room_breach", "targetname");
  var_3 thread maps\_anim::anim_single_solo(level._allies[0], "rec_breach_check");
  wait 0.05;
  common_scripts\utility::array_thread(level._allies, maps\_utility::enable_cqbwalk);
  common_scripts\utility::array_thread(level._allies, maps\_utility::disable_ai_color);
  common_scripts\utility::flag_wait("flag_common_breach");
  level cw_common_breach();
  common_scripts\utility::array_call(level._allies, ::pushplayer, 0);
  level._allies[0] thread maps\_utility::set_ignoresuppression(1);
  level._allies[0] maps\_utility::delaythread(2.5, maps\_utility::set_ignoresuppression, 0);
  level._allies[0] thread maps\_utility::set_force_color("r");
  level._allies[1] maps\_utility::delaythread(1.5, maps\_utility::set_force_color, "y");
  var_4 = getent("cw_color_common_start", "targetname");
  var_4 notify("trigger");
  var_4 common_scripts\utility::trigger_off();
  common_scripts\utility::array_thread(level._allies, maps\_utility::set_force_cover, 0);
  maps\black_ice_util::delay_retreat("com_opfor", 30, 5, "flag_common_reinforce");
  maps\_utility::array_spawn_targetname("cw_opfor_common_runner");
  wait 1;
  maps\black_ice_util::delay_retreat("com_opfor", 90, 4, "flag_common_retreat", "cw_trig_common_retreat", 1);
  wait 1;
  maps\black_ice_util::delay_retreat("com_opfor", 60, 2, "flag_common_end");
  common_scripts\utility::array_thread(maps\_utility::get_ai_group_ai("com_opfor"), maps\_utility::player_seek_enable);
  maps\black_ice_util::delay_retreat("com_opfor", 60, 1, "flag_common_cleanup");
  maps\_utility::kill_deathflag("flag_common_cleared", 2);
  common_scripts\utility::flag_wait("flag_common_cleared");
  level.player thread maps\_utility::notify_delay("common_encounter_done", 1.0);
  common_scripts\utility::array_thread(level._allies, maps\_utility::disable_cqbwalk);
  common_scripts\utility::array_thread(level._allies, maps\_utility::set_grenadeammo, 3);
  var_5 = getEntArray("cw_color_common", "script_noteworthy");
  common_scripts\utility::array_thread(var_5, common_scripts\utility::trigger_off);
  var_4 = getent("cwc_color_leave", "targetname");
  var_4 notify("trigger");
}

cw_common_fic() {
  wait 0.5;
  maps\_utility::delaythread(1.0, common_scripts\utility::flag_set, "flag_common_breach");
  level waittill("flag_common_breach_ally_start");
  level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_ambush");
  level waittill("cw_common_throw_flash");
  level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_doorsdown");
  common_scripts\utility::flag_wait("flag_common_cleared");
  wait 1;
  level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_roomsclearmove");
  level._allies[1] maps\_utility::smart_dialogue("black_ice_hsh_closecalltherebro");
}

cw_bravo_breach() {
  common_scripts\utility::array_thread(level._bravo, maps\_utility::set_ignoreme, 1);
  level._bravo[0] thread maps\_utility::follow_path(getnode("cw_leave_bravo1", "targetname"));
  level._bravo[1] thread maps\_utility::follow_path(getnode("cw_leave_bravo2", "targetname"));
  common_scripts\utility::flag_wait_all("flag_cw_bravo_breach_1", "flag_cw_bravo_breach_2");
  common_scripts\utility::flag_clear("flag_cw_bravo_breach_1");
  common_scripts\utility::flag_clear("flag_cw_bravo_breach_2");
  wait 1;
  common_scripts\utility::flag_set("flag_cw_bravo_breach");
  common_scripts\utility::flag_wait_all("flag_cw_bravo_breach_1", "flag_cw_bravo_breach_2");
  common_scripts\utility::array_thread(level._bravo, maps\_utility::stop_magic_bullet_shield);
  wait 0.1;
  common_scripts\utility::array_call(level._bravo, ::delete);
}

fx_snow_windtunnel() {
  level endon("notify_stop_flare_stack");
  var_0 = 0;

  for(;;) {
    if(common_scripts\utility::flag("flag_catwalks_windtunnel_fx")) {
      if(var_0 == 0) {
        common_scripts\utility::exploder("catwalks_snow_windtunnel");
        var_0 = 1;
      }
    } else if(var_0 == 1) {
      maps\_utility::stop_exploder("catwalks_snow_windtunnel");
      maps\_utility::stop_exploder("catwalks_lights");
      maps\_utility::stop_exploder("catwalks_snow");
      common_scripts\utility::exploder("barracks_ambfx");
      var_0 = 0;
    }

    wait(level.timestep);
  }
}

goto_door_breach(var_0, var_1, var_2) {
  self endon("death");
  var_3 = self.newenemyreactiondistsq;
  var_4 = self.moveplaybackrate;
  thread maps\_utility::set_moveplaybackrate(var_1, 0.25);
  self.disablebulletwhizbyreaction = 1;
  self.disablefriendlyfirereaction = 1;
  self.dodangerreact = 0;
  self.dontavoidplayer = 1;
  self.disableplayeradsloscheck = 1;
  self.ignorerandombulletdamage = 1;
  self.ignoresuppression = 1;
  self.newenemyreactiondistsq = 0;
  thread maps\_utility::follow_path(getnode(var_0, "targetname"));
  level waittill(var_2);
  self.disablebulletwhizbyreaction = undefined;
  self.disablefriendlyfirereaction = undefined;
  self.dodangerreact = 1;
  self.dontavoidplayer = 0;
  self.disableplayeradsloscheck = 0;
  self.ignorerandombulletdamage = 0;
  self.ignoresuppression = 0;
  self.newenemyreactiondistsq = var_3;
  maps\_utility::set_moveplaybackrate(var_4);
}

goto_door_breach_catchup(var_0, var_1) {
  self endon("death");
  level endon("cw_tape_breach_start");

  if(isstring(var_0)) {
    var_0 = common_scripts\utility::getstruct(var_0, "targetname");
  }

  if(isDefined(var_1) && isstring(var_1)) {
    var_1 = getnode(var_1, "targetname");
  }

  if(distancesquared(level.player.origin, var_0.origin) + 90000 < distancesquared(level.player.origin, self.origin)) {
    while(maps\_utility::player_can_see_ai(self)) {
      wait 0.1;
    }

    if(distancesquared(level.player.origin, var_0.origin) + 90000 < distancesquared(level.player.origin, self.origin)) {
      self teleport(var_0.origin, var_0.angles);
    }
  }

  if(isDefined(var_1)) {
    thread maps\_utility::follow_path(var_1);
  }
}

high_catwalk_kill() {
  common_scripts\utility::flag_wait("flag_vig_catwalk_kill");
  var_0 = getent("cw_vignette_catwalk_kill", "targetname");
  var_1 = maps\_utility::spawn_targetname("cw_opfor_catwalk_kill");
  var_2 = common_scripts\utility::getclosest(var_0.origin, level._allies, 256);

  if(!isDefined(var_1)) {
    return;
  } else if(!isDefined(var_2) || common_scripts\utility::flag("flag_no_catwalk_kill")) {
    var_1 delete();
    return;
  }

  var_1.animname = "generic";
  var_3 = [var_2, var_1];
  var_2 notify("stop_going_to_node");
  var_2 thread maps\_utility::disable_ai_color();
  var_0 maps\_anim::anim_reach_together(var_3, "catwalk_kill");
  var_2 thread maps\black_ice_audio::sfx_catwalk_guy_over_railing();
  var_0 maps\_anim::anim_single(var_3, "catwalk_kill");

  if(!common_scripts\utility::flag("flag_catwalks_end")) {
    var_2 maps\_utility::enable_ai_color();
  }

  var_1 kill();
}

cw_tape_breach() {
  var_0 = getent("cw_vig_tape_breach", "targetname");
  var_1 = maps\_utility::spawn_anim_model("tape_breach_tape");
  var_2 = maps\_utility::spawn_anim_model("tape_breach_door_dam");
  var_0 maps\_anim::anim_first_frame_solo(var_2, "cw_tape_breach");
  var_2 hide();
  var_3 = [level._allies[0], level._allies[1], level.tape_breach_door, var_2, var_1];
  thread cw_tape_explode(var_1, var_2);
  var_4 = getEntArray("cw_clip_tape_breach_door", "targetname");
  common_scripts\utility::array_call(var_4, ::linkto, var_2, "jnt_door");
  var_0 thread maps\_anim::anim_first_frame_solo(var_1, "cw_tape_breach");
  common_scripts\utility::array_call(level._allies, ::pushplayer, 1);
  level._allies[0] thread goto_door_breach_catchup("cw_org_tape_breach_ally1", "cw_node_tape_breach_ally1");
  level._allies[1] thread goto_door_breach_catchup("cw_org_tape_breach_ally2", "cw_node_tape_breach_ally2");
  level._allies[0] thread breach_wait_move("cw_gps_tape_breach", "cw_node_tape_breach_ally1", "cw_node_tape_breach_ally1_detour");
  common_scripts\utility::array_thread(level._allies, maps\_utility::set_force_cover, 1);
  common_scripts\utility::flag_wait_all("flag_cw_breach_vo_ready", "flag_tape_breach_ally2");
  var_5 = getent("cw_gps_tape_breach", "targetname");
  var_6 = getent("cw_clip_tape_breach", "targetname");

  if(level.player istouching(var_5)) {
    while(level.player istouching(var_5)) {
      wait 0.05;
    }

    var_6 movey(-30, 0.05);
  } else
    var_6 movey(-30, 0.05);

  foreach(var_8 in level._allies) {
    if(var_8.origin != var_8.goalpos) {
      wait 0.05;
    }
  }

  level notify("cw_tape_breach_start");
  level thread maps\_utility::notify_delay("cw_tape_breach_cover", 4);
  thread maps\black_ice_audio::sfx_tape_breach(var_0);
  var_0 maps\_anim::anim_single(var_3, "cw_tape_breach", undefined, 0.1);
  common_scripts\utility::array_call(var_4, ::delete);
  var_6 delete();
  common_scripts\utility::array_thread(level._allies, maps\_utility::disable_cqbwalk);
  common_scripts\utility::array_thread(level._allies, maps\_utility::set_force_cover, 0);
  common_scripts\utility::array_thread(level._allies, maps\_utility::disable_ai_color);
  level._allies[0].old_moveplaybackrate = level._allies[0].moveplaybackrate;
  level._allies[1].old_moveplaybackrate = level._allies[1].moveplaybackrate;
  level._allies[0] thread maps\_utility::follow_path(getnode("cwb_node_start_ally1", "targetname"));
  level._allies[0] thread maps\_utility::set_moveplaybackrate(1.18, 0.6);
  level._allies[1] thread maps\_utility::follow_path(getnode("cwb_node_start_ally2", "targetname"));
  level._allies[1] thread maps\_utility::set_moveplaybackrate(1.16, 0.6);
  wait 1;
}

breach_wait_move(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    level endon(var_4);
  }

  if(isstring(var_0)) {
    var_0 = getent(var_0, "targetname");
  }

  if(isstring(var_1)) {
    var_1 = getnode(var_1, "targetname");
  }

  if(isstring(var_2)) {
    var_2 = getnode(var_2, "targetname");
  }

  while(!common_scripts\utility::flag(var_1.script_flag_set)) {
    if(level.player istouching(var_0)) {
      maps\_utility::follow_path(var_2);
      thread breach_wait_nag_proc(var_0, var_3);

      while(level.player istouching(var_0)) {
        wait 0.1;
      }

      var_0 notify("breach_end_detour");
      self setlookatentity();
      thread maps\_utility::follow_path(var_1);
    }

    wait 0.05;
  }
}

breach_wait_nag_proc(var_0, var_1) {
  var_0 endon("breach_end_detour");

  if(!isDefined(var_1)) {
    var_1 = ["blackice_bkr_muchtime", "blackice_bkr_move"];
  } else if(!isarray(var_1)) {
    var_1 = [var_1];
  }

  wait 1.5;

  for(var_2 = 5; level.player istouching(var_0); var_2 = var_2 + 2) {
    self setlookatentity(level.player);
    common_scripts\utility::delaycall(2, ::setlookatentity);
    maps\_utility::smart_dialogue(var_1[randomint(var_1.size)]);
    wait(var_2);
  }
}

cw_tape_explode(var_0, var_1) {
  level waittill("notify_cw_tape_explode");
  cw_tape_explode_player_effect();
  var_1 show();
  common_scripts\utility::exploder("catwalk_det_tape");
  common_scripts\utility::exploder("catwalk_snow_suck");
  wait 0.1;
  level.tape_breach_door delete();
  var_0 delete();
}

cw_tape_explode_player_effect() {
  var_0 = 14000;
  var_1 = distancesquared(level.player.origin, level.tape_breach_door.origin);

  if(var_1 > var_0) {
    level.player playrumbleonentity("damage_light");
    earthquake(0.38, 0.6, level.player.origin, 3000);
  } else {
    level.player playrumbleonentity("grenade_rumble");
    earthquake(0.48, 1.2, level.player.origin, 3000);
    level.player shellshock("default_nosound", 2);
    level.player viewkick(10, level.tape_breach_door.origin);
    var_2 = 70;
    var_3 = 5;
    var_4 = maps\black_ice_util::normalize_value(0, var_0, var_1);
    var_5 = maps\black_ice_util::factor_value_min_max(var_2, var_3, var_4);
    var_6 = vectornormalize(level.player.origin - level.tape_breach_door.origin);
    thread maps\black_ice_util::push_player_impulse(var_6, var_5, 0.5);
  }
}

cw_common_breach() {
  level endon("cw_common_flashed");
  var_0 = getent("cw_common_door", "targetname");
  var_1 = getent(var_0.target, "targetname");
  var_2 = getent("cw_use_common_room_breach", "targetname");
  var_2 sethintstring(&"BLACK_ICE_COMMON_BREACH");
  var_2 thread cw_common_breach_trig_proc();
  level._allies[1] thread cw_common_breach_nag(var_2);

  for(;;) {
    var_2 waittill("trigger");

    if(!level.player isthrowinggrenade()) {
      var_2 notify("breach_triggered");
      var_2 thread common_scripts\utility::trigger_off();
      break;
    }

    wait 0.05;
  }

  getent("cw_gold_common_room_breach", "targetname") delete();
  thread maps\black_ice_audio::sfx_barracks_breach(var_0);
  thread maps\black_ice_anim::cw_common_breach_player(var_0);
  level waittill("notify_start_red_light");
  playFXOnTag(level._effect["breacher_light_red"], level.breach_charge, "tag_red_light");
  level waittill("notify_start_green_light");
  stopFXOnTag(level._effect["breacher_light_red"], level.breach_charge, "tag_red_light");
  playFXOnTag(level._effect["breacher_light_green"], level.breach_charge, "tag_green_light");
  common_scripts\utility::flag_wait("flag_common_breach_ally_start");
  thread cw_breach_bullets();
  wait 0.1;
  var_3 = getent("cw_vig_common_room_breach", "targetname");
  thread maps\black_ice_anim::cw_common_breach_allies();
  level waittill("notify_damage_breacher");
  playFXOnTag(level._effect["common_breach_damaged_breacher"], level.breach_charge, "tag_damage_fx");
  killfxontag(level._effect["breacher_light_green"], level.breach_charge, "tag_green_light");
  level waittill("cw_common_door_down");
  common_scripts\utility::exploder("common_breach_charge");
  common_scripts\utility::exploder("common_room_ambfx");
  killfxontag(level._effect["common_breach_damaged_breacher"], level.breach_charge, "tag_damage_fx");
  wait 0.15;
  maps\_utility::delaythread(0.0, ::cw_breach_player_effects);
  level.breach_charge delete();
  var_4 = maps\_utility::spawn_anim_model("common_door_dam", var_0.origin);
  var_3 thread maps\_anim::anim_single_solo(var_4, "explode");
  var_0 delete();
  var_1 thread delete_path_clip();
  level.player thread common_gps_autokill();
  thread cw_breach_flash_protect();
  maps\black_ice_util::delay_retreat("com_opfor", 6, 4, "flag_common_breach_done");
}

cw_common_breach_trig_proc() {
  self endon("breach_triggered");
  var_0 = getent("cw_common_breach_blast_source", "targetname");

  for(;;) {
    if(!isDefined(self.trigger_off) && (level.player isthrowinggrenade() || !level.player maps\_utility::player_looking_at(var_0.origin, 0.9, 1))) {
      common_scripts\utility::trigger_off();
    } else if(isDefined(self.trigger_off) && !level.player isthrowinggrenade() && level.player maps\_utility::player_looking_at(var_0.origin, 0.9, 1)) {
      common_scripts\utility::trigger_on();
    }

    wait 0.05;
  }
}

cw_common_breach_nag(var_0) {
  var_0 endon("breach_triggered");
  wait 3;
  getent("cw_gold_common_room_breach", "targetname") show();
  var_1 = ["blackice_bkr_illflash", "black_ice_hsh_adamwegottamove"];
  var_2 = 5;

  for(;;) {
    maps\_utility::smart_dialogue(var_1[randomint(var_1.size)]);
    wait(var_2);
    var_2 = var_2 + 2;
  }
}

cw_breach_player_effects() {
  var_0 = getent("cw_common_breach_blast_source", "targetname");
  var_1 = level.player.origin - var_0.origin;
  thread maps\black_ice_util::push_player_impulse(var_1, 0.12, 0.7);
  earthquake(0.5, 0.75, level.player.origin, 2000);
  level.player shellshock("blackice_nosound", 1.0);
  level.player playrumbleonentity("grenade_rumble");
  level.player viewkick(20, var_0.origin);
}

cw_breach_bullets() {
  level endon("flag_common_breach_done");
  level waittill("notify_start_bullets");
  var_0 = getEntArray("cw_bullet_common_ambush", "targetname");
  var_1 = undefined;
  var_2 = getEntArray("cw_target_common_ambush", "targetname");
  var_3 = undefined;
  var_4 = ["ak12"];

  for(;;) {
    var_1 = randomint(var_0.size);
    var_3 = randomint(var_2.size);

    if(common_scripts\utility::flag("cw_gps_common_door") && randomint(5) == 0) {
      magicbullet(var_4[randomint(var_4.size)], var_0[var_1].origin, level.player getEye());
    } else {
      if(!bullettracepassed(var_0[var_1].origin, var_2[var_3].origin, 1, undefined)) {
        continue;
      }
      magicbullet(var_4[randomint(var_4.size)], var_0[var_1].origin, var_2[var_3].origin);
    }

    wait(0.05 * randomintrange(1, 4));
  }
}

cw_breach_flash_protect() {
  level endon("cw_common_flashed");
  level.player endon("death");
  var_0 = undefined;
  level.player waittill("grenade_fire", var_0);
  wait 0.5;
  var_1 = getent("cw_vol_common", "targetname");

  if(isDefined(var_0) && var_0 istouching(var_1)) {
    common_scripts\utility::array_thread(level._allies, maps\_utility::setflashbangimmunity, 1);
    maps\_utility::delaythread(1, common_scripts\utility::array_thread, level._allies, maps\_utility::setflashbangimmunity, 0);
  }
}

cw_common_perfect_breach_proc() {
  if(maps\_utility::get_player_gameskill() < 3) {
    return;
  }
  common_scripts\utility::waittill_any("damage", "common_encounter_done");

  if(common_scripts\utility::flag("flag_common_cleared")) {
    maps\_utility::player_giveachievement_wrapper("LEVEL_11B");
  }
}

common_gps_autokill() {
  level endon("flag_common_end");
  var_0 = 0;
  var_1 = getent("cw_vol_common", "targetname");
  var_2 = getent("cw_vol_common_near", "targetname");
  var_3 = getent("cw_gps_tape_breach", "targetname");
  common_scripts\utility::flag_wait("flag_common_breach_done");

  for(;;) {
    while(var_0 < 30) {
      if(self istouching(var_1)) {
        var_0 = 0;
      } else if(self istouching(var_3)) {
        var_0 = 30;
      } else if(!self istouching(var_2)) {
        var_0 = var_0 + 0.05;
      }

      wait 0.05;
    }

    level._allies[0] thread shot_tracker(&"BLACK_ICE_MERRICK_KILLED");
    level._allies[1] thread shot_tracker(&"BLACK_ICE_HESH_KILLED");
    level._allies[randomint(level._allies.size)] thread maps\_utility::notify_delay("fake_damage", randomfloat(10));

    while(var_0 > 0) {
      if(self istouching(var_2) || self istouching(var_1)) {
        level notify("player_inside_common_room");
        var_0 = 0;
      }

      wait 0.05;
    }
  }
}

shot_tracker(var_0) {
  level endon("flag_common_end");
  level endon("player_inside_common_room");
  common_scripts\utility::waittill_any("damage", "fake_damage");
  setdvar("ui_deadquote", var_0);
  maps\_utility::missionfailedwrapper();
}

setup_spawners() {
  var_0 = getEntArray("cw_vol_falling_area", "targetname");
  level.cw_fall_chance = 1;
  maps\_utility::array_spawn_function_noteworthy("cw_opfor_starting_runners", ::opfor_starting_runners);
  maps\_utility::array_spawn_function_noteworthy("cw_opfor_death_runners", ::opfor_death_runners);
  maps\_utility::array_spawn_function_noteworthy("cw_opfor_low", ::opfor_catwalk_low);
  maps\_utility::array_spawn_function_targetname("cw_opfor_low_balcony", ::opfor_low_balcony);
  maps\_utility::array_spawn_function_noteworthy("cw_opfor_falling", ::opfor_catwalk_falling_death, var_0);
  maps\_utility::array_spawn_function_targetname("cw_barracks_opfor", ::opfor_barracks);
  maps\_utility::array_spawn_function_targetname("cw_opfor_common_ambush", ::opfor_common_ambush);
  setthreatbias("allies", "cw_low_balcony", 256);
}

ascend_ignoreme_loop() {
  level endon("flag_ascend_end");

  for(;;) {
    maps\_utility::set_ignoreme(0);

    while(self.health == self.maxhealth) {
      wait 0.05;
    }

    maps\_utility::set_ignoreme(1);

    while(self.health < self.maxhealth) {
      wait 0.1;
    }
  }
}

opfor_starting_runners() {
  self endon("death");
  maps\_utility::set_ignoreall(1);
  self waittill("goal");
  maps\_utility::set_ignoreall(0);
}

opfor_death_runners() {
  self endon("death");
  maps\_utility::set_ignoreall(1);
  self waittill("goal");
  self delete();
}

opfor_catwalk_low() {
  self endon("death");
  common_scripts\utility::flag_wait("flag_low_retreat");

  if(!common_scripts\utility::flag("flag_low_runaway")) {
    thread maps\_utility::follow_path(getnode("cw_node_low_cover_retreat", "targetname"));
  }

  common_scripts\utility::flag_wait("flag_low_runaway");
  maps\_utility::set_ignoresuppression(1);
  thread maps\_utility::follow_path(getnode("cw_node_low_cover_runaway", "targetname"));
  maps\_utility::delaythread(5, maps\_utility::set_ignoresuppression, 0);
}

opfor_low_balcony() {
  self endon("death");
  maps\_utility::set_ignoreall(1);
  self waittill("goal");
  maps\_utility::set_ignoreall(0);
  common_scripts\utility::flag_wait("flag_low_runaway");
  maps\_utility::follow_path(getnode("cw_node_mid_runners_end", "targetname"));
  self delete();
}

opfor_catwalk_falling_death(var_0) {
  self waittill("death");
  var_1 = 1;

  if(self.movemode != "stop" || !isDefined(self.a.covermode) || self.a.covermode != "stand") {
    return;
  }
  foreach(var_3 in var_0) {
    if(self istouching(var_3)) {
      var_1 = 0;
      break;
    }
  }

  if(var_1) {
    return;
  }
  if(randomint(level.cw_fall_chance) == 0) {
    var_5 = randomint(level.scr_anim["generic"]["cw_falling_death"].size);
    self.deathanim = level.scr_anim["generic"]["cw_falling_death"][var_5];
    level.cw_fall_chance = level.cw_fall_chance + 4;
  }
}

opfor_barracks() {
  self endon("death");
  level maps\_utility::waittillthread("cw_hallsweep_ally2_attack", maps\_utility::magic_bullet_shield, 1);
  common_scripts\utility::flag_wait("flag_barracks_go_fast");
  self.newenemyreactiondistsq = 0;
  maps\_utility::set_fixednode_false();
  self.goalradius = 150;
  wait 1;
  self setgoalentity(level.player);
}

opfor_common_ambush() {
  self endon("death");
  maps\_utility::set_ignoreall(1);
  maps\_utility::set_ignoreme(1);
  level waittill("notify_start_bullets");
  thread common_flash_check();
  thread random_flash();
  maps\_utility::set_ignoreall(0);
  maps\_utility::set_ignoresuppression(1);
  var_0 = getEntArray("cw_target_common_ambush", "targetname");
  self setentitytarget(var_0[randomint(var_0.size)]);

  while(!common_scripts\utility::flag("flag_common_breach_done")) {
    self setentitytarget(var_0[randomint(var_0.size)]);
    wait 0.3;
  }

  maps\_utility::set_ignoreme(0);
  wait(randomfloat(0.5));
  self clearentitytarget();
  wait 1.5;
  maps\_utility::set_ignoresuppression(0);
}

common_flash_check() {
  self endon("death");
  level endon("cw_common_flashed");

  for(;;) {
    if(common_scripts\utility::isflashed()) {
      common_scripts\utility::flag_set("flag_common_breach_done");
      level notify("cw_common_flashed");
    }

    wait 0.05;
  }
}

random_flash() {
  self endon("death");
  level waittill("cw_common_flashed");

  if(isDefined(self.script_parameters)) {
    self allowedstances("stand");
    maps\_utility::set_allowdeath(1);
    maps\_anim::anim_generic(self, self.script_parameters);
    self allowedstances("stand", "crouch");
  } else if(randomint(2) == 0)
    maps\_utility::flashbangstart(randomfloatrange(4.0, 5.0));
}

catwalk_godrays() {
  var_0 = getent("origin_flarestack_fx", "targetname");

  if(maps\_utility::is_gen4()) {
    maps\black_ice_util::god_rays_from_world_location(var_0.origin, "flag_cw_bravo_breach_1", "flag_catwalks_end", undefined, undefined);
  }
}

cw_barracks_fast_trig_proc(var_0) {
  level endon("cw_hallsweep_ally2_attack");
  level endon("flag_barracks_go_fast");
  var_0 endon("trigger");
  var_1 = getent("cw_barracks_dist_org", "targetname");
  var_1 = var_1.origin;
  var_2 = [level.player, level._allies[0], level._allies[1]];

  for(;;) {
    var_3 = common_scripts\utility::getclosest(var_1, var_2, 384);

    if(isDefined(var_3) && isplayer(var_3)) {
      common_scripts\utility::flag_set("flag_barracks_go_fast");
      return;
    }

    wait 0.1;
  }
}

cw_barracks_fast_shoot_proc() {
  level endon("cw_hallsweep_ally2_attack");
  level endon("flag_barracks_go_fast");
  level.player common_scripts\utility::waittill_any("weapon_fired", "grenade_fire");
  common_scripts\utility::flag_set("flag_barracks_go_fast");
}

delete_path_clip() {
  self movez(-10000, 0.05);
  wait 0.05;
  self connectpaths();
  self delete();
}

anim_reach_play(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  var_0[0] notify("anim_reach_play");
  var_0[0] endon("anim_reach_play");

  if(isDefined(var_5) && !isDefined(var_3)) {
    var_3 = 0.1;
  }

  maps\_utility::anim_stopanimscripted();

  if(!isDefined(var_6) || !var_6) {
    maps\_anim::anim_reach(var_0, var_1, var_2, var_4);
  }

  maps\_anim::anim_single(var_0, var_1, var_2, var_3, var_4);

  if(isDefined(var_5)) {
    var_0[0] maps\_utility::follow_path(var_5);
  }
}

trig_enable_cqb() {
  level endon("turn_off_cw_cqb_trigs");

  for(;;) {
    self waittill("trigger", var_0);
    var_0 thread maps\_utility::enable_cqbwalk();
  }
}

trig_disable_cqb() {
  level endon("turn_off_cw_cqb_trigs");

  for(;;) {
    self waittill("trigger", var_0);
    var_0 thread maps\_utility::disable_cqbwalk();
  }
}

tv_watcher() {
  var_0 = getEntArray("blackice_tv", "script_noteworthy");
  var_1 = getent("light_barracks_tv", "script_noteworthy");

  foreach(var_3 in var_0) {
    if(var_3.origin == (-1605, 5480, 1885.5)) {
      var_3 waittill("destroyed");
      var_1 setlightcolor((0.01, 0.01, 0.01));
      var_1 setlightradius(12);
      continue;
    }
  }
}