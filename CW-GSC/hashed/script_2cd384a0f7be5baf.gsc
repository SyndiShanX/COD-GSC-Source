/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2cd384a0f7be5baf.gsc
***********************************************/

#using script_3d81630134db409c;
#using script_3dc93ca9902a9cda;
#using script_55d0a106fd8aa60a;
#using script_58524f08c3081cbb;
#using script_5c325a0a637fdc2e;
#using script_6fad88ff3ed4ff7d;
#using script_8b6f2185feb33ac;
#using script_c36b776c6718540;
#using scripts\core_common\ai_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#namespace namespace_9e8d4ac3;

function function_157fc984() {}

function function_6d9e84ea(str_objective, var_50cc0d4f) {
  level.e_steiner_radio = getent("e_steiner_radio", "targetname");

  if(!isDefined(level.player)) {
    a_e_players = getplayers();
    level.player = a_e_players[0];
  }

  if(var_50cc0d4f) {
    level.player util::function_749362d7(1, #"hash_320ff7b9723b7e5d");
    snd::client_msg("audio_level_triton_verb_disable");
  }

  var_835b8c00 = struct::get("elevator_descent_interact", "targetname");
  var_835b8c00 util::create_cursor_hint(undefined, undefined, #"hash_12aa9737a3364fda", undefined, 0.1, undefined, undefined, 650, 180, undefined, undefined, undefined, &function_e81d76a6);
  level thread function_855a3a3(var_835b8c00);
  level thread objectives::scripted("obj_yamantau_4", undefined, #"hash_74aac1baed0971dd");
  level thread function_da207ab5();
  level thread function_5e8fd656();
  savegame::checkpoint_save(1);
  level thread namespace_7468806b::function_dd08d77();
  level thread function_d2aeeb7c();
  level thread function_8cf4172f();
  level flag::wait_till("flg_excavation_survey_room_exited");
  objectives::complete(#"hash_7b814bc685d7ca4");
  objectives::complete(#"hash_7c39160a497ca2e8");
  objectives::complete(#"hash_40c6b4ca8deece21");
  trigger::use("t_breadcrumb_excavation_cleanup", "targetname");
  level objectives::goto(#"hash_494aacecfcf0ec0", var_835b8c00.origin + (0, 0, 20));
  level thread namespace_7468806b::function_52a8784();
  level.var_f2996ecc = [];
  level.var_79161eb2 = [];
  level.var_b1e6de87 = [];
  level thread function_83dd8b4();
  var_835b8c00 waittill(#"trigger");
  level objectives::complete(#"hash_494aacecfcf0ec0");
  level flag::set("flg_excavation_descent_started");
  level namespace_5d7a2dac::music("11.0_dig_site");
  level.player util::function_749362d7(0);
  level thread function_f456ec34();
  level thread function_7ad3ec4();
  level.player val::set(#"elevator_interact", "disable_weapons", 1);
  level.player val::set(#"elevator_interact", "freezecontrols_allowlook", 1);
  wait 0.5;
  level thread function_b9dad1c1();
  level.player thread function_304a7d6e();
  level.player val::reset_all(#"elevator_interact");
  level thread namespace_8a404420::function_879f456d();
  level scene::stop("scene_yam_6010_grp_enter_react_dead_soldiers");
  level thread function_c4c96ccc();
  level thread namespace_7468806b::function_e5859acb();
  level flag::wait_till("flg_excavation_alpha_camping");
  level thread namespace_7468806b::function_7337a5cc();
  savegame::checkpoint_save(1);
  level flag::wait_till("flg_excavation_alpha_lower_spawn");
  savegame::checkpoint_save(1);
  level flag::wait_till("flg_excavation_charlie_initial_spawn");
  namespace_b73b9191::function_29b49cb5();
  skipto::function_4e3ab877("excavation");
}

function function_855a3a3(var_835b8c00) {
  var_835b8c00 endon(#"trigger");
  var_8b5f46a0 = getent("elevator_descent_kill_volume", "targetname");
  var_8b5f46a0 waittill(#"trigger");

  while(!level.player isonground()) {
    waitframe(1);
  }

  level.player util::stop_magic_bullet_shield();
  level.player kill();
}

function function_b9dad1c1() {
  level thread scene::play("scene_yam_7030_exc_vert_descend", "player_go");
  level waittill(#"hash_b47c121a85fb7bc");
  level flag::set("flg_excav_player_descent_done");
  savegame::function_7790f03(1);
  earthquake(1, 1.2, level.player.origin, 30);
}

function function_304a7d6e() {
  self endon(#"death");
  self waittill(#"hash_2830681ee8fe59f4");
  self playrumbleonentity(#"jump_rumble_start");
  self playrumblelooponentity(#"buzz_high");
  self waittill(#"hash_68eb97f9e822041a");
  snd::client_msg("audio_level_triton_verb_enable");
  self stoprumble(#"buzz_high");
  self playrumbleonentity(#"jump_rumble_end");
  earthquake(0.5, 0.25, self.origin, 100);
}

function function_e81d76a6(s_info) {
  var_57da8476 = getent("elevator_descent_interact_volume", "targetname");
  return level.player istouching(var_57da8476);
}

function function_c4c96ccc() {
  level endon(#"game_ended");
  e_player = level.player;
  level flag::wait_till("excavation_start_chopper_strafe_run_timer");
  level flag::wait_till_timeout(1.75, "excavation_start_chopper_strafe_run_immediately");
  level thread function_d73f8d00();
}

function function_9e2d774a() {
  vol_charlie_turret_intro_high = getent("vol_charlie_turret_intro_high", "targetname");
  level flag::wait_till("flg_excavation_barrel_trigger");
  var_41eff203 = spawner::simple_spawn_single("excavation_bravo_hallway_rpg", &function_794d84a9, "flg_breadcrumb_excavation_alpha", vol_charlie_turret_intro_high);

  if(!isDefined(level.var_79161eb2)) {
    level.var_79161eb2 = [];
  } else if(!isarray(level.var_79161eb2)) {
    level.var_79161eb2 = array(level.var_79161eb2);
  }

  if(!isinarray(level.var_79161eb2, var_41eff203)) {
    level.var_79161eb2[level.var_79161eb2.size] = var_41eff203;
  }

  var_41eff203 val::set(#"woods", "ignoreme", 1);
  var_41eff203 thread function_d210173f("n_excavation_launcher", "e_excavation_launch_target");
}

function function_d210173f(var_3c97f36d, var_5442a320) {
  self endon(#"death");
  self val::set(#"hash_722c2bad015d62bc", "ignoreall", 1);
  self thread ai::shoot_at_target("normal", getent(var_5442a320, "targetname"), "tag_origin", 10, 100, 1);
  self waittill(#"shoot");
  self ai::stop_shoot_at_target();
  self val::set(#"hash_722c2bad015d62bc", "ignoreall", 0);
}

function function_d2aeeb7c() {
  level thread namespace_8a404420::function_174832fd();
}

function function_21b8d590() {
  s_excavation_office_exit_lookat_ref = struct::get("s_excavation_office_exit_lookat_ref", "targetname");

  while(!level flag::get("flg_excavation_survey_room_exited")) {
    if(level.player util::is_looking_at(s_excavation_office_exit_lookat_ref.origin, 0.99)) {
      level flag::set("flg_excavation_survey_room_exited");
    }

    waitframe(1);
  }
}

function function_83dd8b4() {
  vol_alpha_greeter_2_attack = getent("vol_alpha_greeter_2_attack", "targetname");
  nd_alpha_greeter_1_attack = getnode("nd_alpha_greeter_1_attack", "targetname");
  vol_alpha_reinforce_push = getent("vol_alpha_reinforce_push", "targetname");
  var_f43dffab = spawner::simple_spawn_single("excavation_alpha_greeter_initial_1", &function_794d84a9, "flg_excavation_alpha_greeters_alerted_early", nd_alpha_greeter_1_attack, "flg_excavation_alpha_greeter_1_move", nd_alpha_greeter_1_attack, 0, 1);
  var_74037f30 = spawner::simple_spawn_single("excavation_alpha_greeter_initial_2", &function_794d84a9, "flg_excavation_alpha_greeters_alerted_early", vol_alpha_greeter_2_attack, "flg_excavation_alpha_greeters_alerted", vol_alpha_reinforce_push, 0, 1);

  if(!isDefined(level.var_b1e6de87)) {
    level.var_b1e6de87 = [];
  } else if(!isarray(level.var_b1e6de87)) {
    level.var_b1e6de87 = array(level.var_b1e6de87);
  }

  if(!isinarray(level.var_b1e6de87, var_f43dffab)) {
    level.var_b1e6de87[level.var_b1e6de87.size] = var_f43dffab;
  }

  if(!isDefined(level.var_f2996ecc)) {
    level.var_f2996ecc = [];
  } else if(!isarray(level.var_f2996ecc)) {
    level.var_f2996ecc = array(level.var_f2996ecc);
  }

  if(!isinarray(level.var_f2996ecc, var_74037f30)) {
    level.var_f2996ecc[level.var_f2996ecc.size] = var_74037f30;
  }

  level thread namespace_8a404420::scene_yam_7035_exc_vert_descend_guard(var_f43dffab);
  var_f43dffab thread function_a19b1bc2(1);
  var_74037f30 thread function_a19b1bc2();
  level flag::wait_till("flg_excavation_descent_started");
  wait 4;

  if(!level flag::get("flg_excavation_alpha_greeters_alerted_early")) {
    namespace_7468806b::function_21e7292a(var_f43dffab);
  } else {
    wait 1;
    namespace_7468806b::function_df5b726(var_f43dffab);
  }

  level flag::wait_till("flg_excav_player_descent_done");

  if(!level flag::get("flg_excavation_alpha_greeters_alerted_early")) {
    level flag::set("flg_excavation_alpha_greeters_alerted");
    namespace_7468806b::function_df5b726(var_f43dffab);
    var_f43dffab ai::set_behavior_attribute("demeanor", "combat");
    var_74037f30 ai::set_behavior_attribute("demeanor", "combat");
  }
}

function function_a19b1bc2(var_af285262 = 0) {
  self endon(#"death");
  level endon(#"flg_excav_player_descent_done");

  if(var_af285262 == 1) {
    self.script_longdeath = 0;
  }

  self ai::set_behavior_attribute("demeanor", "patrol");

  while(!level flag::get("flg_excavation_alpha_greeters_alerted_early")) {
    if(self.alertlevel == "low_alert" || self.alertlevel == "high_alert") {
      level flag::set("flg_excavation_alpha_greeters_alerted_early");
    }

    wait 0.1;
  }

  if(level flag::get("flg_excavation_alpha_greeters_alerted_early")) {
    self ai::set_behavior_attribute("demeanor", "combat");
  }
}

function function_f456ec34() {
  vol_alpha_initial_camper = getent("vol_alpha_initial_camper", "targetname");
  vol_alpha_front_upper_attack = getent("vol_alpha_front_upper_attack", "targetname");
  vol_alpha_greeter_retreat = getent("vol_alpha_greeter_retreat", "targetname");
  vol_alpha_rear_low_retreat = getent("vol_alpha_rear_low_retreat", "targetname");
  vol_alpha_front_upper_retreat = getent("vol_alpha_front_upper_retreat", "targetname");
  vol_alpha_front_upper_safe = getent("vol_alpha_front_upper_safe", "targetname");
  vol_alpha_rear_low_push = getent("vol_alpha_rear_low_push", "targetname");
  vol_alpha_bunker_overpass = getent("vol_alpha_bunker_overpass", "targetname");
  level thread function_71ad7c6d();
  level thread function_38c1ecf4();
  wait 3;
  ai_excavation_alpha_initial_camper_2 = spawner::simple_spawn_single("ai_excavation_alpha_initial_camper_2", &function_794d84a9, "flg_excavation_alpha_upper_relocate", vol_alpha_bunker_overpass);
  var_4271f8d0 = spawner::simple_spawn_single("excavation_alpha_initial_catwalk_runner", &function_794d84a9, "flg_excavation_alpha_crane_rotate", vol_alpha_front_upper_attack, "flg_excavation_alpha_right_rein_spawn", vol_alpha_front_upper_attack);
  var_fa7eec03 = spawner::simple_spawn("excavation_alpha_initial_upper", &function_794d84a9, "flg_excavation_alpha_right_rein_spawn", vol_alpha_front_upper_attack, "flg_excavation_alpha_upper_relocate", vol_alpha_front_upper_retreat);
  var_4271f8d0 thread function_d44eaa84(1, vol_alpha_front_upper_safe, 1);
  ai_excavation_alpha_initial_camper_2 thread function_3b16eb20();
  var_4271f8d0 thread function_3b16eb20();

  foreach(ai in var_fa7eec03) {
    ai thread function_3b16eb20();
  }

  foreach(ai in var_fa7eec03) {
    ai thread function_d44eaa84(1, vol_alpha_front_upper_safe, 1);
  }

  if(!isDefined(level.var_f2996ecc)) {
    level.var_f2996ecc = [];
  } else if(!isarray(level.var_f2996ecc)) {
    level.var_f2996ecc = array(level.var_f2996ecc);
  }

  if(!isinarray(level.var_f2996ecc, ai_excavation_alpha_initial_camper_2)) {
    level.var_f2996ecc[level.var_f2996ecc.size] = ai_excavation_alpha_initial_camper_2;
  }

  if(!isDefined(level.var_f2996ecc)) {
    level.var_f2996ecc = [];
  } else if(!isarray(level.var_f2996ecc)) {
    level.var_f2996ecc = array(level.var_f2996ecc);
  }

  if(!isinarray(level.var_f2996ecc, var_4271f8d0)) {
    level.var_f2996ecc[level.var_f2996ecc.size] = var_4271f8d0;
  }

  level.var_f2996ecc = arraycombine(level.var_f2996ecc, var_fa7eec03);
  level thread function_ae455ff1();
  level thread function_baed84e2();
  vol_alpha_reinforce_push = getent("vol_alpha_reinforce_push", "targetname");
  var_5c69badc = spawner::simple_spawn("excavation_alpha_right_rein", &function_794d84a9, "flg_excavation_rein_push", vol_alpha_reinforce_push);
  level.var_f2996ecc = arraycombine(level.var_f2996ecc, var_5c69badc, 0);
  level flag::wait_till("flg_excavation_alpha_zipline_spawn");
  level flag::wait_till("flg_excavation_charlie_zipliner_spawn");

  foreach(ai in level.var_f2996ecc) {
    if(isalive(ai)) {
      ai deletedelay();
    }
  }
}

function function_3b16eb20() {
  self endon(#"death");
  self.script_grenades = 0;
  level flag::wait_till("excavation_chopper_strafe_complete");
  self.script_grenades = 1;
}

function function_38c1ecf4() {
  level.player val::set("excavation_alpha", "attackeraccuracy", 0.25);
  level flag::wait_till_any(array("flg_excavation_alpha_right_rein_spawn", "chopper_strafe_run_fire_guns"));

  if(level flag::get("flg_excavation_alpha_right_rein_spawn") && !level flag::get("chopper_strafe_run_fire_guns")) {
    level.player val::set("excavation_alpha", "attackeraccuracy", 1);
    level flag::wait_till("chopper_strafe_run_fire_guns");
    level.player val::reset("excavation_alpha", "attackeraccuracy");
    return;
  }

  if(!level flag::get("flg_excavation_alpha_right_rein_spawn") && level flag::get("chopper_strafe_run_fire_guns")) {
    level.player val::reset("excavation_alpha", "attackeraccuracy");
  }
}

function function_df54f77c() {
  vol_alpha_catwalk_upper_fallback = getent("vol_alpha_catwalk_upper_fallback", "targetname");
  level flag::wait_till("flg_excavation_alpha_camping_react");
  var_7c6b9967 = spawner::simple_spawn_single("excavation_alpha_zipliner_1", &function_794d84a9, "flg_excavation_alpha_zipliners_fallback", vol_alpha_catwalk_upper_fallback);

  if(!isDefined(level.var_f2996ecc)) {
    level.var_f2996ecc = [];
  } else if(!isarray(level.var_f2996ecc)) {
    level.var_f2996ecc = array(level.var_f2996ecc);
  }

  if(!isinarray(level.var_f2996ecc, var_7c6b9967)) {
    level.var_f2996ecc[level.var_f2996ecc.size] = var_7c6b9967;
  }
}

function function_71ad7c6d() {
  level flag::wait_till("flg_excavation_alpha_crane_rotate");
  var_5c573be7 = spawner::simple_spawn_single("excavation_alpha_bunker_exit_initial");

  if(!isDefined(level.var_f2996ecc)) {
    level.var_f2996ecc = [];
  } else if(!isarray(level.var_f2996ecc)) {
    level.var_f2996ecc = array(level.var_f2996ecc);
  }

  if(!isinarray(level.var_f2996ecc, var_5c573be7)) {
    level.var_f2996ecc[level.var_f2996ecc.size] = var_5c573be7;
  }
}

function function_ae455ff1() {
  level endon(#"hash_442f9dc2c39a7ef0");
  var_91347afc = 5;

  while(level.var_f2996ecc.size > var_91347afc) {
    function_1eaaceab(level.var_f2996ecc, 0);
    wait 0.1;
  }

  if(level flag::get("flg_excavation_alpha_camping")) {
    level flag::set("flg_excavation_alpha_camping_react");
  }
}

function function_d44eaa84(var_b67d9509 = 0, var_bd90fcd4, var_71caae1f = 0) {
  self endon(#"death");

  if(var_b67d9509 == 1) {
    self thread function_7bd8fa3d(var_bd90fcd4);
  }

  if(var_71caae1f == 1) {
    self thread function_2fc7a7c3();
  }
}

function function_7bd8fa3d(var_bd90fcd4) {
  self endon(#"death");
  level flag::wait_till("flg_excavation_alpha_camping_react");
  wait randomfloatrange(0, 2);
  self cleargoalvolume();
  self setgoal(var_bd90fcd4, 1);
  self.var_38754eac = level.player.origin;
}

function function_2fc7a7c3() {
  self endon(#"death");
  level flag::wait_till_all(array("flg_excavation_alpha_camping_react", "excavation_chopper_strafe_complete"));
  self.var_38754eac = level.player.origin;
}

function function_499f139a(var_1036ae3a, var_30bf7246 = 0) {
  self endon(#"death");

  if(var_30bf7246 == 1) {
    self val::set(#"hash_719e7e05bd04a005", "ignoreall", 1);
  }

  self util::waittill_any_ents(self, "damage", self, "bulletwhizby", self, "player_sighted");
  self ai::set_behavior_attribute("demeanor", "combat");

  if(var_30bf7246 == 1) {
    self val::reset(#"hash_719e7e05bd04a005", "ignoreall");
  }

  self getperfectinfo(level.player);

  if(!level flag::get(var_1036ae3a)) {
    level flag::set(var_1036ae3a);
  }
}

function function_baed84e2() {
  level endon(#"hash_335b505b6d880c1e");
  vol_alpha_bunker_1_advance = getent("vol_alpha_bunker_1_advance", "targetname");
  vol_alpha_bunker_1_retreat = getent("vol_alpha_bunker_1_retreat", "targetname");
  vol_alpha_bunker_2_advance = getent("vol_alpha_bunker_2_advance", "targetname");
  vol_alpha_bunker_2_retreat = getent("vol_alpha_bunker_2_retreat", "targetname");
  var_e6592d4 = [];
  level flag::wait_till("flg_excavation_alpha_right_rein_spawn");
  var_f51302a1 = spawner::simple_spawn_single("excavation_alpha_bunker_initial_1", &function_794d84a9, "flg_excavation_alpha_bunker_advance", vol_alpha_bunker_1_advance, "flg_excavation_alpha_bunker_retreat", vol_alpha_bunker_1_retreat);
  var_859292d = spawner::simple_spawn_single("excavation_alpha_bunker_initial_2", &function_794d84a9, "flg_excavation_alpha_bunker_advance", vol_alpha_bunker_2_advance, "flg_excavation_alpha_bunker_retreat", vol_alpha_bunker_2_retreat);

  if(!isDefined(var_e6592d4)) {
    var_e6592d4 = [];
  } else if(!isarray(var_e6592d4)) {
    var_e6592d4 = array(var_e6592d4);
  }

  if(!isinarray(var_e6592d4, var_f51302a1)) {
    var_e6592d4[var_e6592d4.size] = var_f51302a1;
  }

  if(!isDefined(var_e6592d4)) {
    var_e6592d4 = [];
  } else if(!isarray(var_e6592d4)) {
    var_e6592d4 = array(var_e6592d4);
  }

  if(!isinarray(var_e6592d4, var_859292d)) {
    var_e6592d4[var_e6592d4.size] = var_859292d;
  }

  if(!isDefined(level.var_f2996ecc)) {
    level.var_f2996ecc = [];
  } else if(!isarray(level.var_f2996ecc)) {
    level.var_f2996ecc = array(level.var_f2996ecc);
  }

  if(!isinarray(level.var_f2996ecc, var_f51302a1)) {
    level.var_f2996ecc[level.var_f2996ecc.size] = var_f51302a1;
  }

  if(!isDefined(level.var_f2996ecc)) {
    level.var_f2996ecc = [];
  } else if(!isarray(level.var_f2996ecc)) {
    level.var_f2996ecc = array(level.var_f2996ecc);
  }

  if(!isinarray(level.var_f2996ecc, var_859292d)) {
    level.var_f2996ecc[level.var_f2996ecc.size] = var_859292d;
  }

  var_f51302a1 thread function_499f139a("flg_excavation_alpha_bunker_retreat");
  var_859292d thread function_499f139a("flg_excavation_alpha_bunker_retreat");

  while(var_e6592d4.size > 0 && !level flag::get("flg_excavation_alpha_lower_spawn")) {
    wait 0.5;
    function_1eaaceab(var_e6592d4, 0);
  }

  var_93fc3feb = spawner::simple_spawn("excavation_bravo_lower");
  level.var_f2996ecc = arraycombine(level.var_f2996ecc, var_93fc3feb, 0);
}

function function_5bf481a4() {
  self endon(#"death");
  vol_alpha_catwalk_upper_fallback = getent("vol_alpha_catwalk_upper_fallback", "targetname");
  var_604e7f32 = self.health;
  self.health = 1;
  self val::set(#"zipline_excavation_7", "ignoreall", 1);
  self val::set(#"zipline_excavation_7", "ignoreme", 1);
  self thread namespace_7468806b::function_4b1535c7();
  self waittill(#"hash_4c7ded9d08b15793");
  self val::set(#"zipline_excavation_7", "ignoreall", 0);
  self.health = var_604e7f32;
  level flag::wait_till("flg_excavation_alpha_zipliners_fallback");
  self cleargoalvolume();
  self setgoal(vol_alpha_catwalk_upper_fallback, 1);
}

function function_982e9ab() {
  level.ai_woods val::set(#"hash_7582767c1785e448", "ignoreme", 1);
  level.ai_woods val::set(#"hash_7582767c1785e448", "ignoreall", 1);
  wait 3;
  level.ai_woods val::set(#"hash_7582767c1785e448", "ignoreme", 0);
  level.ai_woods val::set(#"hash_7582767c1785e448", "ignoreall", 0);
}

function function_5e8fd656() {
  level flag::wait_till("flg_excavation_alpha_crane_rotate");
  level thread breadcrumb::function_61037c6c(#"breadcrumb_excavation_alpha");
  level flag::wait_till("flg_breadcrumb_excavation_alpha");
  level thread breadcrumb::function_61037c6c(#"hash_35a607a75750258a");
}

function function_3a2be9a5(var_2ec9696a, var_8dea88af, color) {
  self notify(#"hash_7dead634940144a1");
  self endon(#"hash_7dead634940144a1");
  self endon(#"death");

  if(isDefined(var_2ec9696a) && isDefined(var_8dea88af)) {
    while(true) {
      radius = length(var_8dea88af.maxs);
      line(self getcentroid(), var_8dea88af.origin, color, 1, 0, 1);
      sphere(var_8dea88af.origin, radius, color, 0.1, 0, 10, 1);
      print3d(var_8dea88af.origin, var_2ec9696a, (1, 1, 1), 1, 1, 1, 1);

      waitframe(1);
    }
  }
}

function function_da207ab5() {
  level thread breadcrumb::function_61037c6c(#"hash_40452e2b9da8abec");
}

function function_7ad3ec4() {
  level flag::wait_till("flg_excavation_alpha_bunker_advance");
  level thread function_17e23a7f();
  level thread function_c0f9e627();
  level thread function_72aeec8();
  level thread function_9e2d774a();
  level flag::wait_till("flg_excavation_delta_save");

  foreach(ai in level.var_79161eb2) {
    if(isalive(ai)) {
      ai deletedelay();
    }
  }
}

function function_17e23a7f() {
  vol_excavation_bunker_rooftop = getent("vol_excavation_bunker_rooftop", "targetname");
  vol_bravo_rear_rein_lower = getent("vol_bravo_rear_rein_lower", "targetname");
  vol_charlie_island_push = getent("vol_charlie_island_push", "targetname");
  vol_bravo_upper_retreat = getent("vol_bravo_upper_retreat", "targetname");
  level flag::wait_till("flg_excavation_bravo_upper_spawn");
  var_5168c041 = spawner::simple_spawn_single("excavation_bravo_bunker_upper", &function_794d84a9, "flg_excavation_bravo_overhead_zipliners_start", vol_bravo_upper_retreat);
  var_255319fb = spawner::simple_spawn("excavation_bravo_exit_lower", &function_794d84a9, "flg_excavation_alpha_rear_rein_lower_retreat", vol_bravo_rear_rein_lower);

  if(!isDefined(level.var_79161eb2)) {
    level.var_79161eb2 = [];
  } else if(!isarray(level.var_79161eb2)) {
    level.var_79161eb2 = array(level.var_79161eb2);
  }

  if(!isinarray(level.var_79161eb2, var_5168c041)) {
    level.var_79161eb2[level.var_79161eb2.size] = var_5168c041;
  }

  if(!isDefined(level.var_79161eb2)) {
    level.var_79161eb2 = [];
  } else if(!isarray(level.var_79161eb2)) {
    level.var_79161eb2 = array(level.var_79161eb2);
  }

  if(!isinarray(level.var_79161eb2, var_255319fb)) {
    level.var_79161eb2[level.var_79161eb2.size] = var_255319fb;
  }
}

function function_c0f9e627() {
  level.var_a6ff982 = 0;
  level flag::wait_till("flg_excavation_bravo_upper_spawn");
  level.var_e1b00a95 = spawner::simple_spawn_single("excavation_bravo_zipline_overhead_1");

  if(!isDefined(level.var_79161eb2)) {
    level.var_79161eb2 = [];
  } else if(!isarray(level.var_79161eb2)) {
    level.var_79161eb2 = array(level.var_79161eb2);
  }

  level.var_79161eb2[level.var_79161eb2.size] = level.var_e1b00a95;
  negotiation_node_zipline_excavation_1_begin = getnode("negotiation_node_zipline_excavation_1_begin", "targetname");
  level.var_e1b00a95 forceteleport(negotiation_node_zipline_excavation_1_begin.origin, negotiation_node_zipline_excavation_1_begin.angles, 0);
  level flag::wait_till("flg_excavation_bravo_overhead_zipliners_start");
  level.var_7dfa4327 = spawner::simple_spawn_single("excavation_bravo_zipline_overhead_2");

  if(!isDefined(level.var_79161eb2)) {
    level.var_79161eb2 = [];
  } else if(!isarray(level.var_79161eb2)) {
    level.var_79161eb2 = array(level.var_79161eb2);
  }

  level.var_79161eb2[level.var_79161eb2.size] = level.var_7dfa4327;
  level.var_7dfa4327.var_660aa59f = 0.4;
  level.var_7dfa4327 forceteleport(negotiation_node_zipline_excavation_1_begin.origin, negotiation_node_zipline_excavation_1_begin.angles, 0);
  wait 3;

  if(!is_true(level.ai_woods.istalking)) {
    level thread namespace_7468806b::function_4ef400c0();
  }
}

function function_67b7e01e() {
  self endon(#"death");
  var_475dc8a0 = getnode("negotiation_node_zipline_excavation_1_begin", "targetname");
  var_4eff0b93 = getent("vol_excavation_bunker_rooftop", "targetname");

  if(level.var_a6ff982 == 1) {
    wait 3;
  } else {
    level.var_a6ff982 = 1;
  }

  self val::set(#"hash_178c61dd7f256288", "ignoreall", 1);
  self forceteleport(var_475dc8a0.origin, var_475dc8a0.angles);
  self setgoal(var_4eff0b93);
  self waittill(#"hash_4c7ded9d08b15793");
  self val::set(#"zipline_mountain_tutorial", "ignoreall", 0);
}

function function_72aeec8() {
  level flag::wait_till_any(array("flg_excavation_bravo_ladder_taken", "flg_excavation_bravo_overhead_zipliners_start"));

  if(!isalive(level.var_e1b00a95)) {
    var_de1c3bb3 = spawner::simple_spawn_single("excavation_bravo_bunker_upper_exit_1");

    if(!isDefined(level.var_79161eb2)) {
      level.var_79161eb2 = [];
    } else if(!isarray(level.var_79161eb2)) {
      level.var_79161eb2 = array(level.var_79161eb2);
    }

    level.var_79161eb2[level.var_79161eb2.size] = var_de1c3bb3;
  }

  if(!isalive(level.var_7dfa4327)) {
    var_c3ca070f = spawner::simple_spawn_single("excavation_bravo_bunker_upper_exit_2");

    if(!isDefined(level.var_79161eb2)) {
      level.var_79161eb2 = [];
    } else if(!isarray(level.var_79161eb2)) {
      level.var_79161eb2 = array(level.var_79161eb2);
    }

    level.var_79161eb2[level.var_79161eb2.size] = var_c3ca070f;
  }
}

function function_794d84a9(var_2ec9696a, var_8dea88af, fallback_flag, var_8a12da56, var_779361c7 = 0, var_3e5a4606 = 0) {
  self endon(#"death");

  if(var_779361c7 == 1) {
    self val::set(#"hash_5f956c8f5b98041b", "ignoreall", 1);
  }

  if(isDefined(var_2ec9696a) && isDefined(var_8dea88af)) {
    if(var_779361c7 == 1) {
      level flag::wait_till("flg_excavation_delta_zipline_used");
    } else if(var_3e5a4606 == 1) {
      level flag::wait_till_any(array(var_2ec9696a, fallback_flag));
    } else {
      level flag::wait_till(var_2ec9696a);
    }

    if(var_779361c7 == 1) {
      self val::reset(#"hash_5f956c8f5b98041b", "ignoreall");
    }

    self cleargoalvolume();
    self setgoal(var_8dea88af, 1);
  }

  if(isDefined(fallback_flag) && isDefined(var_8a12da56)) {
    level flag::wait_till(fallback_flag);
    self cleargoalvolume();
    self setgoal(var_8a12da56, 1);
  }
}

function function_c45206f5() {
  var_4bacbbbe = getent("excavation_crane_mover", "targetname");
  level flag::wait_till("flg_excavation_alpha_crane_rotate");
  var_4bacbbbe rotateyaw(-30, 10);
}

function function_ab15a34c(str_objective) {
  level flag::set("flg_bunker_office_entered");
  level flag::set("flg_bunker_survey_interacted");
  level flag::set("survey_equipment_completed");
  level thread namespace_8a404420::function_df4e7f42();
  level thread namespace_73841f48::function_38479ea0();
  level thread function_f5ae4873();
  level thread namespace_7468806b::function_8d5b3937();
  namespace_b73b9191::function_2683ec5d();
  var_3c499539 = struct::get("woods_office_start", "targetname");
  level.ai_woods forceteleport(var_3c499539.origin, var_3c499539.angles);
  level flag::set("flg_woods_regroup_radio_complete_timeout");
  level thread namespace_8a404420::function_e6604e8b();
  level thread namespace_c8bf7287::function_c17f029c();
}

function function_1e5a768a(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  level thread function_f2797a4(1);
}

function function_e30ea9da(str_objective, var_50cc0d4f) {
  savegame::checkpoint_save(1);
  level thread function_ee32da2d();
  level thread function_4ef657c();
  level flag::wait_till("flg_excavation_delta_save");
  savegame::checkpoint_save(1);
  level flag::wait_till("flg_server_reveal_start");
  namespace_b73b9191::function_29b49cb5();
  skipto::function_4e3ab877("excavation_finale");
}

function function_ee32da2d() {
  vol_charlie_zipliners_2_fallback = getent("vol_charlie_zipliners_2_fallback", "targetname");
  vol_charlie_exit_fallback = getent("vol_charlie_exit_fallback", "targetname");
  vol_charlie_zipliners_fallback = getent("vol_charlie_zipliners_fallback", "targetname");

  if(!isDefined(level.var_b1e6de87)) {
    level.var_b1e6de87 = [];
  }

  var_c087df7f = spawner::simple_spawn("excavation_charlie_initial");
  level.var_b1e6de87 = arraycombine(level.var_b1e6de87, var_c087df7f, 0);
  level thread function_9e39e5ab();
  level flag::wait_till("flg_excavation_charlie_zipliner_spawn");
  level thread function_2955f0c2();

  if(!is_true(level.ai_woods.istalking)) {
    level thread namespace_7468806b::function_1b881326();
  }

  level flag::wait_till("flg_excavation_delta_approach");
  var_d3eef0a3 = spawner::simple_spawn("excavation_charlie_exit", &function_794d84a9, "flg_excavation_charlie_counterattack", vol_charlie_zipliners_fallback);
  level.var_b1e6de87 = arraycombine(level.var_b1e6de87, var_d3eef0a3, 0);

  foreach(ai in var_d3eef0a3) {
    if(isalive(ai)) {
      ai ai::set_behavior_attribute("disablepeek", 1);
      ai ai::set_behavior_attribute("disablelean", 1);
    }
  }

  level flag::wait_till("flg_excavation_delta_exit_approach");

  foreach(ai in level.var_b1e6de87) {
    if(isalive(ai)) {
      ai deletedelay();
    }
  }
}

function private function_6f3bd725() {
  self endon(#"death");
  self val::set(#"hash_28625787364ed011", "ignoreall", 1);
  self.allowpain = 0;

  while(true) {
    waitframe(1);

    if(is_true(self.is_ziplining)) {
      break;
    }
  }

  self val::reset(#"hash_28625787364ed011", "ignoreall");
}

function function_2955f0c2() {
  var_f9e70880 = spawner::simple_spawn_single("excavation_charlie_zipliner_3", &function_bfec36a3);
  var_f9e70880 thread function_6f3bd725();

  if(!isDefined(level.var_b1e6de87)) {
    level.var_b1e6de87 = [];
  } else if(!isarray(level.var_b1e6de87)) {
    level.var_b1e6de87 = array(level.var_b1e6de87);
  }

  level.var_b1e6de87[level.var_b1e6de87.size] = var_f9e70880;
  level flag::wait_till_timeout(1.5, "flg_excavation_charlie_zipline_immediate");
  var_ba8ac03 = spawner::simple_spawn_single("excavation_charlie_zipliner_2", &function_bfec36a3);
  var_ba8ac03 thread function_6f3bd725();

  if(!isDefined(level.var_b1e6de87)) {
    level.var_b1e6de87 = [];
  } else if(!isarray(level.var_b1e6de87)) {
    level.var_b1e6de87 = array(level.var_b1e6de87);
  }

  level.var_b1e6de87[level.var_b1e6de87.size] = var_ba8ac03;
  level flag::wait_till_timeout(1, "flg_excavation_charlie_zipline_immediate");
  var_a160d775 = spawner::simple_spawn_single("excavation_charlie_zipliner_1", &function_bfec36a3);
  var_a160d775.var_e8f98e9d = 0.6;
  var_a160d775.var_662e279c = 1;
  var_a160d775 thread function_6f3bd725();

  if(!isDefined(level.var_b1e6de87)) {
    level.var_b1e6de87 = [];
  } else if(!isarray(level.var_b1e6de87)) {
    level.var_b1e6de87 = array(level.var_b1e6de87);
  }

  level.var_b1e6de87[level.var_b1e6de87.size] = var_a160d775;
}

function function_bfec36a3() {
  self endon(#"death");
  vol_charlie_zipliners_fallback = getent("vol_charlie_zipliners_fallback", "targetname");
  self setgoal(level.player, 1);
  level flag::wait_till("flg_excavation_charlie_zipliners_fallback");
  self cleargoalvolume();
  self setgoal(vol_charlie_zipliners_fallback, 1);
}

function function_9e39e5ab() {
  nd_excavation_turret_1 = getnode("nd_excavation_turret_1", "targetname");
  veh_turret = function_1a2a3760(nd_excavation_turret_1);
  level.var_d07a8fe2 = spawner::simple_spawn_single("excavation_turret_gunner_1");
  level.var_d07a8fe2 setgoal(nd_excavation_turret_1, 1, 64);
  level.var_d07a8fe2 val::set(#"hash_5b395383c920db60", "ignoreme", 1);
  level.var_d07a8fe2 thread namespace_7468806b::function_d6e3ed97();
  level.var_d07a8fe2 thread function_78407bf8(veh_turret);
  level.var_d07a8fe2 thread function_fed0bc04();
  level.var_d07a8fe2 thread function_f8d17019();

  if(!isDefined(level.var_b1e6de87)) {
    level.var_b1e6de87 = [];
  } else if(!isarray(level.var_b1e6de87)) {
    level.var_b1e6de87 = array(level.var_b1e6de87);
  }

  level.var_b1e6de87[level.var_b1e6de87.size] = level.var_d07a8fe2;
  veh_turret.aim_only_no_shooting = 1;
  veh_turret setteam(#"axis");
  veh_turret turretsetontargettolerance(0, 0);
  veh_turret turret::set_burst_parameters(100, 100, 0.05, 0.05, 0);
  veh_turret turret::set_target(level.player, (0, 0, 0), 0);
  level.var_7b665d77 = spawn("script_origin", level.player.origin);
  level.var_7b665d77 makesentient();
  level.var_7b665d77 setteam(#"neutral");
  level.var_d07a8fe2.favoriteenemy = level.var_7b665d77;
  veh_turret function_9602cb9e();
  veh_turret function_667c40a();
  veh_turret turretsetontargettolerance(0, 90);
  veh_turret turret::set_burst_parameters(3, 3.5, 2.5, 3, 0);
  veh_turret turret::function_49c3b892(level.player);
  veh_turret.aim_only_no_shooting = undefined;
}

function function_f8d17019() {
  self endon(#"death");
  level endon(#"flg_excavation_turret_detach");
  var_a4df412f = getent("excavation_mg_nest_damage_detection", "targetname");

  while(true) {
    var_7b1b5529 = var_a4df412f waittill(#"damage");

    if(var_7b1b5529 hms_util::function_1062a852()) {
      break;
    }
  }

  radiusdamage(self.origin, 100, 1000, 200, level.player, "MOD_EXPLOSIVE");
}

function function_78407bf8(veh_turret) {
  self endon(#"death");
  self waittill(#"exit_turret");
  self cleargoalvolume();
  veh_turret makeunusable();
  setenablenode(getnode("nd_excavation_turret_1", "targetname"), 0);
  self.goalradius = 32;
  self setgoal(getent("vol_turret_redeploy", "targetname"), 1, 32);
}

function function_fed0bc04() {
  while(isalive(self)) {
    waitframe(1);
  }

  level notify(#"hash_2c8120c2c4f90067");
  wait 1.5;

  if(!level flag::get("flg_excavation_turret_detach")) {
    level thread namespace_7468806b::function_c492928b();
  }
}

function function_9602cb9e() {
  level endon(#"hash_4bde20f553432e5f");
  level.player endon(#"death");
  level thread function_2624afa1();
  var_b3294f70[0] = (12875.5, -4631.23, 679.71);
  var_b3294f70[1] = (13091.3, -4631.23, 679.71);
  var_b3294f70[2] = (12981.9, -4748.23, 449.565);
  var_b3294f70[3] = (13090.4, -4899.81, 449.565);
  level.var_602cf102 = var_b3294f70[0];

  while(true) {
    if(vectordot(vectornormalize(anglesToForward(level.player getplayerangles())), vectornormalize(self.origin + (0, 0, 30) - level.player getEye())) > 0.999) {
      break;
    } else {
      var_efff4c42 = 0;
      var_3b1efaa4 = 0;
      var_947b4032 = (0, 0, 0);

      foreach(v in var_b3294f70) {
        var_3b1efaa4 = vectordot(vectornormalize(level.player getEye() - self.origin), vectornormalize(v - self.origin));

        if(var_3b1efaa4 > var_efff4c42) {
          var_efff4c42 = var_3b1efaa4;
          var_947b4032 = v;
        }
      }

      level.var_602cf102 = var_947b4032;
      level.var_7b665d77.origin = level.var_602cf102;
    }

    waitframe(1);
  }
}

function function_2624afa1() {
  level endon(#"hash_2c8120c2c4f90067");
  a_vol[0] = getent("vol_charlie_turret_intro_high", "targetname");
  a_vol[1] = getent("vol_charlie_turret_intro_low", "targetname");

  while(true) {
    foreach(vol in a_vol) {
      if(istouching(level.player.origin, vol)) {
        level notify(#"hash_4bde20f553432e5f");
        return;
      }
    }

    waitframe(1);
  }
}

function function_667c40a() {
  level endon(#"hash_2c8120c2c4f90067");
  level.player endon(#"death");
  i = 0;

  while(i < 2) {
    var_c154039f = i / 2;
    var_3421afd1 = level.var_602cf102 - level.player.origin;
    v_offset = var_c154039f * var_3421afd1;
    level.var_7b665d77.origin = level.var_602cf102 - v_offset;
    a_trace = bulletTrace(self gettagorigin("tag_flash"), level.var_7b665d77.origin, 1, self, 0, 1);
    level.var_7b665d77.origin = a_trace[#"position"];
    self turret::fire(0);
    wait 0.15;
    i += 0.15;
  }

  level flag::set("flg_excavation_turret_shooting");
  level.var_7b665d77 delete();
}

function function_4ef657c() {
  negotiation_node_zipline_5_begin = getnode("negotiation_node_zipline_5_begin", "targetname");
  var_46f5bd8b = 0.5;
  level.var_e672dbe5 = [];
  createthreatbiasgroup("rooftop_strafe");
  createthreatbiasgroup("strafe_helo");
  setthreatbias("strafe_helo", "rooftop_strafe", 10000);

  while(!level flag::get("flg_excavation_delta_zipline_used")) {
    s_notify = level.player waittill(#"player_zipline_start");

    if(s_notify.var_14af458a == "zipline_excavation_5") {
      level thread namespace_7468806b::function_c05409c7();
      level flag::set("flg_excavation_delta_zipline_used");
      thread function_5d346c9c("t_excavation_delta_zipline_color_trigger");
      level.ai_woods.var_660aa59f = 0.02;
      level thread function_9340ffe4("vh_kgb_excavation_hind");
      wait var_46f5bd8b;
      wait 1;
      level.ai_woods forceteleport(negotiation_node_zipline_5_begin.origin, negotiation_node_zipline_5_begin.angles);
      var_95f88e34 = spawner::simple_spawn("excavation_delta_zipline_exit", &function_8cdf2785);
      level thread function_5d7ff344();
      wait 1;
      level.var_e672dbe5 = arraycombine(level.var_e672dbe5, var_95f88e34, 0);
      level.var_a12503a1 = spawner::simple_spawn_single("excavation_delta_zipline_exit_runner", &function_e16091a7);

      if(!isDefined(level.var_e672dbe5)) {
        level.var_e672dbe5 = [];
      } else if(!isarray(level.var_e672dbe5)) {
        level.var_e672dbe5 = array(level.var_e672dbe5);
      }

      if(!isinarray(level.var_e672dbe5, level.var_a12503a1)) {
        level.var_e672dbe5[level.var_e672dbe5.size] = level.var_a12503a1;
      }

      var_233809e = getEntArray("cp_explosive_barrel", "targetname");

      foreach(barrel in var_233809e) {
        barrel thread function_48959786();
      }

      level flag::wait_till("flg_excavation_delta_exit_save");
    }

    waitframe(1);
  }

  level flag::wait_till("flg_server_room_start");

  foreach(ai in level.var_e672dbe5) {
    if(isalive(ai)) {
      ai deletedelay();
    }
  }
}

function function_8cdf2785() {
  self endon(#"death");
  self util::magic_bullet_shield();
  wait 2.5;
  self util::stop_magic_bullet_shield();
}

function function_5d7ff344() {
  var_9e1ffedc = spawner::simple_spawn_single("excavation_delta_strafe_1", &function_23eb3589, "flg_excavation_charlie_chopper_shoot", 1, 2);
  var_6c6f1b7b = spawner::simple_spawn_single("excavation_delta_strafe_2", &function_23eb3589, "flg_excavation_charlie_chopper_shoot", 2, 3);
  var_7e6526b = spawner::simple_spawn_single("excavation_delta_strafe_3", &function_23eb3589, "flg_excavation_charlie_chopper_shoot", 3, 4);
  level flag::wait_till("flg_excavation_delta_exit_save");
  var_6f089943 = spawner::simple_spawn("excavation_delta_strafe_roof_1", &function_23eb3589, "flg_excavation_charlie_rooftop_strafe", 1, 2, 1);
  var_7d3db5ad = spawner::simple_spawn("excavation_delta_strafe_roof_2", &function_23eb3589, "flg_excavation_charlie_rooftop_strafe", 1.5, 2, 1);
  var_ca7bd028 = spawner::simple_spawn("excavation_delta_strafe_roof_3", &function_23eb3589, "flg_excavation_charlie_rooftop_strafe", 2, 3, 1);
  var_a8ad8c8c = spawner::simple_spawn("excavation_delta_strafe_roof_4", &function_23eb3589, "flg_excavation_charlie_rooftop_strafe", 4, 4.1, 1);
  var_b65fa7f0 = spawner::simple_spawn("excavation_delta_strafe_roof_5", &function_23eb3589, "flg_excavation_charlie_rooftop_strafe", 5, 7, 1);
}

function function_23eb3589(var_8976dc95, var_110068ca, var_703540e6, var_ba084a80 = 0) {
  self endon(#"death");
  self setthreatbiasgroup("rooftop_strafe");

  if(var_ba084a80 == 1) {
    self.favoriteenemy = level.var_ebbd5cf8;
    self thread ai::shoot_at_target("normal", level.var_ebbd5cf8, "tag_origin", 10);
  }

  level flag::wait_till(var_8976dc95);
  wait randomfloatrange(var_110068ca, var_703540e6);
  self kill();
}

function function_48959786() {
  self enableaimassist();
  level flag::wait_till("flg_excavation_delta_exit_save");
  self disableaimassist();
}

function function_e16091a7() {
  self endon(#"death");
  self val::set("burning_man", "allowdeath", 0);
  self val::set("burning_man", "takedamage", 0);
}

function function_5d346c9c(var_bddd937) {
  wait 2.5;
  trigger::use(var_bddd937, "targetname", level.player, 0);
}

function function_4a1a74fe(str_objective) {
  objectives::complete("obj_yamantau_3");
  level thread objectives::scripted("obj_yamantau_4", undefined, #"hash_74aac1baed0971dd");
  level thread breadcrumb::function_61037c6c(#"hash_35a607a75750258a");
  level flag::set("flg_bunker_office_entered");
  level flag::set("flg_bunker_survey_interacted");
  level flag::set("flg_excavation_alpha_crane_rotate");
  level namespace_5d7a2dac::music("11.0_dig_site");
  namespace_b73b9191::function_2683ec5d();
  var_532adac5 = struct::get("woods_excavation_finale_start", "targetname");
  level.ai_woods forceteleport(var_532adac5.origin, var_532adac5.angles);
  level thread namespace_8a404420::function_164734e9();
  level thread namespace_7468806b::function_7337a5cc();
}

function function_888e9b6b(str_objective, var_50cc0d4f, var_aa1a6455, player) {}

function function_f5ae4873() {
  e_bunker_survey_exit_door_closed = getent("e_bunker_survey_exit_door_closed", "targetname");
  e_bunker_survey_exit_door_closed movez(-1024, 0.1);
}

function function_8cf4172f() {
  e_excavation_gate_l_open = getent("e_excavation_gate_l_open", "targetname");
  e_excavation_gate_r_open = getent("e_excavation_gate_r_open", "targetname");
  e_excavation_gate_l_close = getent("e_excavation_gate_l_close", "targetname");
  e_excavation_gate_r_close = getent("e_excavation_gate_r_close", "targetname");
  e_excavation_gate_close_clip = getent("e_excavation_gate_close_clip", "targetname");
  e_excavation_gate_l_open show();
  e_excavation_gate_r_open show();
  e_excavation_gate_l_close hide();
  e_excavation_gate_r_close hide();
  e_excavation_gate_close_clip movez(-1000, 0.1);
  level flag::wait_till("flg_excavation_descent_started");
  e_excavation_gate_l_open hide();
  e_excavation_gate_r_open hide();
  e_excavation_gate_l_close show();
  e_excavation_gate_r_close show();
  e_excavation_gate_close_clip movez(1000, 0.1);
}

function function_f2797a4(b_skipto = 0) {
  if(b_skipto == 1) {
    wait 2;
  }

  e_excavation_gate_l_open = getent("e_excavation_gate_l_open", "targetname");
  e_excavation_gate_r_open = getent("e_excavation_gate_r_open", "targetname");
  e_excavation_gate_l_open hide();
  e_excavation_gate_r_open hide();
}

function function_d73f8d00() {
  var_48a64d70 = getvehiclenode("excavation_chopper_strafe_run_0a", "targetname");
  var_5c7316ba = namespace_b73b9191::function_f206e65e("vh_kgb_excavation_hind", "sp_excavation_helo_pilot", 0);
  var_5c7316ba val::set("support_heli", "ignoreme", 1);
  var_5c7316ba val::set("support_heli", "takedamage", 0);
  var_5c7316ba thread vehicle::get_on_and_go_path(var_48a64d70);
  var_dce05631 = getent("excavation_chopper_strafe_target_1_start", "targetname");
  var_ccf127c3 = struct::get(var_dce05631.target, "targetname");
  level flag::wait_till("chopper_strafe_run_fire_guns");
  level flag::set("flg_excavation_rein_push");
  var_dce05631 moveto(var_ccf127c3.origin, 2);

  while(level flag::get("chopper_strafe_run_fire_guns")) {
    var_5c7316ba thread namespace_b73b9191::function_887fdde7("front", var_dce05631, 0.25);
    var_5c7316ba thread function_fef7d6b1();
    wait 0.25;
  }

  level flag::set("excavation_chopper_strafe_complete");
}

function function_fef7d6b1() {
  if(flag::get("flg_audio_heli_guns_playing") == 1) {
    return;
  }

  flag::set("flg_audio_heli_guns_playing");
  var_7697a1f7 = snd::play("wpn_alpha_attack_helicopter_cannon_fire_npc", self);
  wait 2;
  snd::stop(var_7697a1f7);
  snd::play("wpn_alpha_lmg_npc_decay_attack_heli", self);
}

function function_32d9a51b() {
  var_b58a047 = [];

  if(!isDefined(var_b58a047)) {
    var_b58a047 = [];
  } else if(!isarray(var_b58a047)) {
    var_b58a047 = array(var_b58a047);
  }

  var_b58a047[var_b58a047.size] = "flg_excavation_charlie_right_zipline_used";

  if(!isDefined(var_b58a047)) {
    var_b58a047 = [];
  } else if(!isarray(var_b58a047)) {
    var_b58a047 = array(var_b58a047);
  }

  var_b58a047[var_b58a047.size] = "flg_excavation_charlie_left_zipline_used";

  if(!isDefined(var_b58a047)) {
    var_b58a047 = [];
  } else if(!isarray(var_b58a047)) {
    var_b58a047 = array(var_b58a047);
  }

  var_b58a047[var_b58a047.size] = "flg_excavation_charlie_granny_path_used";
  level.ai_woods hms_util::dialogue("(Radio) Approaching your AO, Woods. You've pissed off a lot of people down there.", 1, undefined, "Dimitri");
  level.ai_woods hms_util::dialogue("Like I wasn't aware!");
  level flag::wait_till("flg_excavation_charlie_approach");
  level.ai_woods hms_util::dialogue("How about you give us a fuckin' hand, Dimitri!");
  level flag::wait_till_any(var_b58a047);
  level.ai_woods hms_util::dialogue("(Radio ) Da! Covering your flank!", 1, undefined, "Dimitri");
}

function function_9340ffe4(heli_targetname) {
  level.var_ebbd5cf8 = namespace_b73b9191::function_f206e65e(heli_targetname, "sp_excavation_helo_pilot", 0);
  level.var_ebbd5cf8 makesentient();
  level.var_ebbd5cf8 setteam(#"allies");
  level.var_ebbd5cf8 val::set("server_heli", "allowdeath", 0);
  level thread function_ba45b49();
  level thread scene::play("scene_yam_7090_exc_heli_flyover", level.var_ebbd5cf8);
  level.var_ebbd5cf8 setthreatbiasgroup("strafe_helo");
  snd::client_targetname(level.var_ebbd5cf8, "audio_srv_heli");
  level thread function_6f58aeb8();
}

function function_ba45b49() {
  e_target = getent("excavation_chopper_strafe_target_2_start", "targetname");
  var_8969e152 = struct::get(e_target.target, "targetname");
  s_end = struct::get(var_8969e152.target, "targetname");
  level flag::wait_till("flg_excavation_charlie_chopper_shoot");
  e_target moveto(var_8969e152.origin, 1);

  while(level flag::get("flg_excavation_charlie_chopper_shoot")) {
    level.var_ebbd5cf8 thread namespace_b73b9191::function_887fdde7("front", e_target, 0.25);
    wait 0.25;
  }

  level flag::wait_till("flg_excavation_charlie_chopper_shoot");
  level thread function_85afb2d2();
  e_target moveto(s_end.origin, 2);

  while(level flag::get("flg_excavation_charlie_chopper_shoot")) {
    level.var_ebbd5cf8 thread namespace_b73b9191::function_887fdde7("front", e_target, 0.25);
    wait 0.25;
  }

  e_target = getent("excavation_chopper_strafe_target_3_start", "targetname");
  s_end = struct::get(e_target.target, "targetname");
  level flag::wait_till("flg_excavation_charlie_chopper_shoot");
  level flag::set("flg_excavation_charlie_rooftop_strafe");
  e_target moveto(s_end.origin, 6);

  while(level flag::get("flg_excavation_charlie_chopper_shoot")) {
    level.var_ebbd5cf8 thread namespace_b73b9191::function_887fdde7("front", e_target, 0.25);
    wait 0.25;
  }
}

function function_85afb2d2() {
  wait 1.25;
  var_9a5dec69 = level.var_a12503a1;
  var_9a5dec69 endon(#"death");
  var_9a5dec69 detach("c_t9_rus_winter_enemy_01_hat");
  var_9a5dec69 attach("c_t9_rus_winter_enemy_01_hat_burn");
  var_9a5dec69 setModel("p9_c_t9_rus_winter_enemy_loadout_a_burn");
  level thread scene::play("scene_yam_7090_exc_burning_guard", var_9a5dec69);
  var_9a5dec69 waittill(#"start_ragdoll");
  var_9a5dec69 val::reset_all("burning_man");
  var_9a5dec69 startragdoll(1);
  var_8f81719f = struct::get("burning_man_bad_place", "targetname");
  badplace_cylinder("", 60, var_8f81719f.origin, 65, 200, "axis", "allies");
}

function function_6f58aeb8() {
  level waittill(#"hash_31711c4b54547af9");
  wait 1;
  level thread namespace_7468806b::function_18babf5c();
}