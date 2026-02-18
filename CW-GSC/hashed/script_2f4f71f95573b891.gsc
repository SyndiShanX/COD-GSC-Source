/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2f4f71f95573b891.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using script_3b2905ec05ed796;
#using script_41e8adffbda93483;
#using script_498cf7685befe7bf;
#using script_77f51076c7c89596;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\districts;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp\cp_rus_siege;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#namespace namespace_9940c067;

function function_d7e02379(str_objective) {
  exploder::exploder("lgt_exp_pre_nuke_ext_lights");
  namespace_534279a::spawn_allies("graveyard_start");
  level.var_77be18d2 = vehicle::simple_spawn_single("player_fav");
  level.var_77be18d2 val::set(#"hash_533b89b2c3072f64", "takedamage", 0);
  level thread namespace_9e5ef376::function_b7e649c0();
  snd::client_msg("audio_graveyard_fire_start");
}

function function_8b10d19c(str_objective, var_50cc0d4f) {
  if(var_50cc0d4f) {
    exploder::exploder("fxexp_env_fx_set_graveyard");
    exploder::exploder("fxexp_env_fx_set_graveyard_2");
  }

  level.n_timer = int(60 * 1000);
  namespace_95f223d5::music("5.0_graveyard");
  function_a5083d9c();
  spawner::simple_spawn_single("parapet_aa_gunner");
  level.player namespace_534279a::function_a3c3a2b0();
  level.mason val::set(#"hash_427e34b7109385d2", "ignoreme", 1);
  level.woods val::set(#"hash_427e34b7109385d2", "ignoreme", 1);
  level notify(#"hash_72c4460ada02022c");
  level notify(#"hash_49fd25a30e3024a0");
  level thread function_a1514e3c();
  level thread function_e6528249();
  level thread function_71ff3dee();
  var_92d37871 = getplayers()[0];
  level thread function_7a6fed15(var_92d37871);
  var_ce667ea2 = getEntArray("destructible_tombstone", "targetname");

  foreach(var_b337ad77 in var_ce667ea2) {
    var_b337ad77.var_86a21346 = &function_c62ae6e1;
    var_b337ad77 thread function_2a1cc4d0();
  }

  e_blocker = getent("scene_adler_right_stair_blocker", "targetname");
  e_blocker notsolid();
  e_blocker connectpaths();
  level flag::wait_till("flg_graveyard_reveal");
  objectives::remove(#"obj_follow_adler", level.adler);
  objectives::complete(#"hash_7956ac3690b300bb");
  var_c31a6f62 = getent("aa_parapet", "targetname");
  objectives::kill(#"hash_75d3caceed12ab7d", var_c31a6f62, #"hash_5c22b5de1fc16f25");
  objectives_ui::function_49dec5b(#"hash_75d3caceed12ab7d", var_c31a6f62, #"hash_7056653275b7909e");
  level thread function_cb6a2e9b();
  snd::client_msg("audio_graveyard_fire_start");
  function_6ea2cd94();
  player_decision::function_8c0836dd(0);
  objectives::complete(#"hash_75d3caceed12ab7d");
  skipto::function_4e3ab877("graveyard");
}

function function_cdf0a865(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  function_693651a7();
}

function function_6ea2cd94() {
  level thread function_7e171808();
  level waittill(#"flg_aa_gun_c4_planted");
  level thread namespace_604e2e22::function_f2f9526e();

  if(level.n_timer >= 45000) {
    level.player stats::function_dad108fa(#"hash_76803ad04be840f8", 1);
  }
}

function function_7e171808() {
  var_80d256bf = getent("aa_parapet", "targetname");
  var_80d256bf namespace_534279a::function_2a8ee50f("parapet");
  namespace_95f223d5::music("6.0_danger_close");
  level notify(#"hash_7797b485016eeeed");
  level.player hms_util::dialogue("vox_cp_seig_01600_cmnd_youaredangerclo_60", 1);
  var_80d256bf notify(#"remove_objective");
}

function private function_a1514e3c() {
  level thread function_778517c4();
  level thread function_996c0ba0();
  level thread function_e4ead38e();
  level thread function_de07f71e();
  level thread function_2c6ed0b9();
  level thread graveyard_adler_right_stair();
  level thread function_c40d0905();
}

function private function_c62ae6e1(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, iboneindex, imodelindex, spartname, isurfacetype, vsurfacenormal) {
  if(isDefined(isurfacetype.s_turret)) {
    return (vsurfacenormal * 4);
  }

  return vsurfacenormal;
}

function private function_1e0501c8(eventstruct) {
  dynent = eventstruct.ent;
  var_f2f0344e = 1;
  var_9d27f60c = getentitiesinradius(dynent.origin, 170, 15);

  foreach(actor in var_9d27f60c) {
    var_dfc4aab4 = actor getteam();

    if(var_dfc4aab4 == # "axis") {
      actor dodamage(1, dynent.origin, undefined, undefined, 0, "MOD_UNKNOWN", 0, undefined, undefined, var_f2f0344e);
    }
  }
}

function private event_handler[event_9e981c4] function_87fb14da(eventstruct) {
  dynent = eventstruct.ent;

  if(isDefined(dynent.targetname) && dynent.targetname == # "hash_59014f81a0bff5e7") {
    function_1e0501c8(eventstruct);
  }
}

function private function_778517c4() {
  level flag::wait_till("flg_graveyard_initial");
  a_ai = namespace_534279a::function_da412d49(["graveyard_initial_group", "graveyard_initial_rear_group"]);
  array::run_all(a_ai, &val::set, "graveyard_intro_ignore", "ignoreall", 1);
  array::run_all(a_ai, &ai::set_behavior_attribute, "disablelean", 1);
  level.adler val::set("graveyard_intro_ignore", "ignoreall", 1);
  level flag::wait_till("flg_graveyard_reveal");
  a_ai = namespace_534279a::function_da412d49(["graveyard_initial_group", "graveyard_initial_rear_group"]);
  array::run_all(a_ai, &val::set, "graveyard_intro_ignore", "ignoreall", 1);
  array::run_all(a_ai, &ai::set_behavior_attribute, "disablelean", 1);
  array::thread_all(a_ai, &function_99345cd4);
  level flag::wait_till("flg_graveyard_unignore");
  a_ai = namespace_534279a::function_da412d49(["graveyard_initial_group", "graveyard_initial_rear_group"]);
  array::run_all(a_ai, &val::reset, "graveyard_intro_ignore", "ignoreall");
  array::run_all(a_ai, &ai::set_behavior_attribute, "disablelean", 0);
  level thread function_95286c05();
  level.adler val::reset("graveyard_intro_ignore", "ignoreall");
  namespace_534279a::function_bd1a75b("graveyard_initial_group", 3, "flg_initial_fallback");
  namespace_534279a::function_b5e4f3bc("graveyard_initial_group", "graveyard_initial_fallback_1_volume", "script_noteworthy");
  namespace_534279a::function_bd1a75b("graveyard_initial_group", 2, "flg_graveyard_engage");
  spawner::simple_spawn("graveyard_pre_engage");
  level flag::wait_till("flg_graveyard_engage");
  spawner::simple_spawn("graveyard_engage");
  namespace_534279a::function_bd1a75b(["graveyard_initial_group", "graveyard_initial_rear_group"], 3, "flg_engage_fallback");
  namespace_534279a::function_b5e4f3bc("graveyard_initial_group", "graveyard_initial_fallback_2_volume", "script_noteworthy");
  level flag::wait_till("flg_lowground_fallback");
  namespace_534279a::function_b5e4f3bc("graveyard_initial_group", "graveyard_lowground_retreat_volume", "script_noteworthy", 1, 1);
  a_ai = spawner::get_ai_group_ai("graveyard_initial_group");

  if(a_ai.size) {
    a_ai = arraysortclosest(a_ai, level.player.origin);
    a_ai[0] thread ai::force_goal(level.player);
  }

  wait 1.5;
  namespace_534279a::function_b5e4f3bc("graveyard_initial_rear_group", "graveyard_lowground_retreat_volume", "script_noteworthy", 1, 1);
  var_9d4d3c67 = spawner::get_ai_group_ai("graveyard_initial_rear_group");

  if(var_9d4d3c67.size) {
    var_9d4d3c67 = arraysortclosest(var_9d4d3c67, level.player.origin);
    var_9d4d3c67[0] thread ai::force_goal(level.player);
  }

  level thread function_71d31006();
}

function private function_99345cd4() {
  level endon(#"flg_graveyard_unignore", #"game_ended");
  level.player endon(#"death");
  self waittill(#"damage", #"bulletwhizby");
  level flag::set("flg_graveyard_unignore");
}

function private function_e4ead38e() {
  level endon(#"flg_initial_fallback", #"game_ended");
  level flag::wait_till("flg_graveyard_unignore");
  wait 2;
  var_37bcd55 = getaiarray("graveyard_front_left", "script_noteworthy");
  var_44265112 = getent("graveyard_initial_backright_fallback_volume", "script_noteworthy");
  array::thread_all(var_37bcd55, &ai::force_goal, var_44265112);
}

function private function_95286c05() {
  level endon(#"end_game");
  level.player endon(#"death");
  level endon(#"flg_lowground_fallback");
  var_d83a65d4 = 0;

  while(true) {
    wait randomfloatrange(4, 6) + 2 * var_d83a65d4;
    a_ai = namespace_534279a::function_da412d49(["graveyard_initial_group", "graveyard_initial_rear_group"]);

    if(a_ai.size) {
      ai = array::function_a3b0f814(a_ai);
      ai.var_38754eac = level.player.origin;
    }
  }
}

function private function_996c0ba0() {
  level thread function_a5d5b89c("parapet_turret_1", "parapet_turret_gunner_1");
  level flag::wait_till("flg_graveyard_engage");

  if(!spawner::get_ai_group_sentient_count("graveyard_turret_group")) {
    function_a5d5b89c("parapet_turret_1", "parapet_turret_gunner_2");
  } else {
    level flag::wait_till("flg_graveyard_turret_final");

    if(!spawner::get_ai_group_sentient_count("graveyard_turret_group")) {
      function_a5d5b89c("parapet_turret_1", "parapet_turret_gunner_2");
    }
  }

  level thread function_5a8712d0();
  level flag::wait_till("flg_turret_gunner_fallback");
  namespace_534279a::function_b5e4f3bc("graveyard_turret_group", "graveyard_turret_gunner_fallback_volume", "script_noteworthy");
  waitframe(1);
  namespace_534279a::function_b5e4f3bc("graveyard_turret_group", "graveyard_turret_gunner_fallback_volume", "script_noteworthy");
  var_a27e797b = spawner::get_ai_group_ai("graveyard_turret_group");
  array::thread_all(var_a27e797b, &val::reset, #"hash_4d90a080f869a233", "ignoreme");
  savegame::checkpoint_save();
  level flag::wait_till("flg_stair_fallback");
  namespace_534279a::function_b5e4f3bc("graveyard_turret_group", "graveyard_lowground_retreat_volume", "script_noteworthy");
}

function private function_a5d5b89c(var_d562fbb8, var_14a42c6d) {
  var_d93ed883 = getnode(var_d562fbb8, "targetname");
  veh_turret = function_1a2a3760(var_d93ed883);
  level flag::clear("graveyard_turret_gunner_killed");
  level flag::clear("flg_graveyard_turret_intro_started");

  if(!isDefined(level.var_c837e477)) {
    veh_turret thread function_c368c7fd();
    level.var_c837e477 = 1;
    veh_turret.aim_only_no_shooting = 1;
    veh_turret setteam(#"axis");
    veh_turret turret::set_on_target_angle(1, 0);
    veh_turret turret::set_burst_parameters(100, 100, 0.05, 0.05, 0);
    veh_turret turret::function_9c04d437();
    var_3c0b220f = spawner::simple_spawn_single(var_14a42c6d);
    var_3c0b220f setgoal(var_d93ed883, 1, 64);
    var_3c0b220f val::set(#"hash_4d90a080f869a233", "ignoreme", 1);
    var_3c0b220f.blockingpain = 1;
    var_3c0b220f thread function_91520ec4();
    veh_turret.var_5deea171 = var_3c0b220f;
    level.var_dae3084a = spawn("script_origin", level.player.origin);
    level.var_dae3084a function_2baad8fc();
    level.var_dae3084a setteam(#"neutral");
    veh_turret turret::set_target(level.var_dae3084a, undefined, 0);
    veh_turret turret::function_49c3b892(level.var_dae3084a);
    veh_turret turret::function_3a7e640f(1, 0);
    veh_turret function_5ef98b38();
    veh_turret turret::function_3a7e640f(0, 0);

    if(flag::get("flg_graveyard_unignore")) {
      wait 2;
    }

    if(isalive(var_3c0b220f)) {
      veh_turret function_4a536ec1();

      if(isalive(var_3c0b220f)) {
        veh_turret function_d20ad6b2();
      }
    }

    wait 3;
    level flag::set("flg_graveyard_unignore");
    return;
  }

  var_3c0b220f = spawner::simple_spawn_single(var_14a42c6d);
  var_3c0b220f setgoal(var_d93ed883, 1, 64);
  var_3c0b220f val::set(#"hash_4d90a080f869a233", "ignoreme", 1);
}

function private function_5a8712d0() {
  wait 0.1;
  spawner::waittill_ai_group_ai_count("graveyard_turret_group", 0);
  level flag::set("flg_turret_gunner_killed_all");
}

function function_c368c7fd() {
  self endon(#"death");
  level.player endon(#"death");

  while(true) {
    if(distance2dsquared(level.player.origin, self.origin) < sqr(125)) {
      break;
    }

    waitframe(1);
  }

  self makeunusable();
}

function function_5ef98b38() {
  level endon(#"flg_graveyard_unignore");
  self.var_5deea171 endon(#"damage", #"bulletwhizby");
  var_b3294f70[0] = (10027.5, -6219.7, 266.562);
  var_b3294f70[1] = (9925.58, -6328.67, 282.025);
  var_b3294f70[2] = (9925.58, -6349.83, 282.025);
  var_b3294f70[3] = (10011.8, -6380.1, 277.366);
  var_b3294f70[4] = (10011.8, -6489.5, 278.711);

  while(true) {
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

    level.var_b949cb00 = var_947b4032;
    level.var_dae3084a.origin = level.var_b949cb00;
    waitframe(1);
  }
}

function function_4a536ec1() {
  level endon(#"graveyard_turret_gunner_killed");
  level flag::set("flg_graveyard_turret_intro_started");

  if(!level flag::get("flg_graveyard_engage")) {
    i = 0;

    while(i < 1) {
      self turret::function_259e1449(0);
      var_c154039f = i / 1;
      var_3421afd1 = level.var_b949cb00 - level.adler getEye();
      v_offset = var_c154039f * var_3421afd1;

      if(i < 0.1) {
        v_offset = (0, 0, 0);
      }

      level.var_dae3084a.origin = level.var_b949cb00 - v_offset;
      a_trace = bulletTrace(self gettagorigin("tag_flash"), level.var_dae3084a.origin, 1, self, 0, 1);
      level.var_dae3084a.origin = a_trace[# "position"];
      self turret::fire(0);
      wait 0.05;
      i += 0.05;
    }
  }
}

function function_d20ad6b2() {
  self turret::function_21827343();
  self turret::set_on_target_angle(15, 0);
  self turret::set_burst_parameters(3, 3.5, 2.5, 3, 0);
  self turret::set_target(level.player, undefined, 0);
  self turret::function_49c3b892(level.player);
  self.var_5deea171.blockingpain = 0;
  self.script_accuracy = 0.33;
  self.aim_only_no_shooting = undefined;
  level.var_dae3084a delete();
}

function function_91520ec4() {
  self waittill(#"death");
  level flag::set("graveyard_turret_gunner_killed");
}

function private graveyard_adler_right_stair() {
  level endon(#"game_ended", #"hash_52ec6053fd9503a0");
  level flag::wait_till("graveyard_adler_right_stair");
  var_c1a94704 = getent("graveyard_adler_right_stair_enemy_volume", "targetname");
  var_67c65aa3 = 1;

  while(var_67c65aa3) {
    var_67c65aa3 = 0;
    a_ai = namespace_534279a::function_da412d49(["graveyard_initial_group", "graveyard_initial_rear_group", "graveyard_turret_group"]);

    foreach(ai in a_ai) {
      if(ai istouching(var_c1a94704)) {
        var_67c65aa3 = 1;
        break;
      }
    }

    wait 0.1;
  }

  trigger::use("graveyard_adler_right_stair_color_trigger", "targetname", level.player);
  e_blocker = getent("scene_adler_right_stair_blocker", "targetname");
  e_blocker solid();
  e_blocker disconnectpaths();
  a_ents = [];
  a_ents[# "adler"] = level.adler;
  s_scene = struct::get("scene_adler_right_stair");
  s_scene scene::init(a_ents);
  s_scene scene::play(a_ents);
}

function function_71d31006() {
  level endon(#"game_ended");
  level.player endon(#"death");
  level flag::wait_till("flg_turret_gunner_fallback");

  while(!level flag::get("flg_graveyard_upper_entrance")) {
    a_ai = spawner::get_ai_group_ai("graveyard_initial_group");

    if(a_ai.size >= 2) {
      foreach(ai in a_ai) {
        if(!level.player cansee(ai)) {
          ai deletedelay();
          break;
        }
      }
    }

    wait 1;
  }
}

function private function_2c6ed0b9() {
  level flag::wait_till("flg_hallway_shotgunner_spawn");
  ai = spawner::simple_spawn_single("graveyard_hallway_shotgunner");
  ai ai::set_behavior_attribute("demeanor", "cqb");
  ai waittill(#"goal", #"death");
  waitframe(1);

  if(isalive(ai)) {
    ai thread ai::force_goal(level.player);
  }
}

function private function_de07f71e() {
  level endon(#"game_end");
  level.player endon(#"death");
  level thread function_bb05a3f7();
  level flag::wait_till("flg_graveyard_upper_entrance");
  level thread function_ea6cda92();
  namespace_534279a::function_bd1a75b("graveyard_upper_group", 6, "flg_aa_fallback");
  namespace_534279a::function_b5e4f3bc("graveyard_turret_group", "graveyard_AA_retreat_volume", "script_noteworthy");
  namespace_534279a::function_b5e4f3bc("graveyard_upper_group", "graveyard_AA_retreat_volume", "script_noteworthy");
  var_32d376d6 = getnodearray("graveyard_rear_wall_nodes", "targetname");

  foreach(nd in var_32d376d6) {
    setenablenode(nd, 0);
  }

  spawner::waittill_ai_group_ai_count("graveyard_upper_group", 3);
  level flag::set("flg_rusher_end");
  level thread function_84e3ebe0();

  if(level.player hasweapon(getweapon(#"hash_6fb61bc95fdf307c"))) {
    namespace_534279a::function_b5e4f3bc("graveyard_turret_group", "graveyard_retreat_delete_volume", "script_noteworthy", 0, 1);
    namespace_534279a::function_b5e4f3bc("graveyard_upper_group", "graveyard_retreat_delete_volume", "script_noteworthy", 0, 1);
  }
}

function private function_ea6cda92() {
  wait 0.5;
  a_ai = getaiarchetypearray("human", "axis");
  function_1eaaceab(a_ai);

  foreach(ai in a_ai) {
    ai.script_accuracy = 0.4;
    ai.grenadeammo = 0;
  }
}

function private function_c40d0905() {
  a_ents = [];
  a_ents[# "hash_363ff12eba02d468"] = getent("flip_table", "targetname");
  a_ents[# "hash_363ff12eba02d468"] hide();
  var_87b16d96 = getent("flip_table_visible", "targetname");
  var_87b16d96 notsolid();
  level flag::wait_till("flg_graveyard_table_flip");
  s_scene = struct::get("scene_table_flip");
  s_scene scene::init(a_ents);
  a_ents[# "enemy"] = spawner::simple_spawn_single("vig_table_flip_spawner");
  a_ents[# "enemy"] endon(#"death");
  s_scene thread function_b1f33833(a_ents[# "enemy"]);
  s_scene scene::play(a_ents);
  var_e4bd6323 = getnode("table_flip_node", "targetname");
  a_ents[# "enemy"] ai::set_goal_node(var_e4bd6323);
}

function function_b1f33833(var_541d697) {
  var_541d697 endoncallback(&function_6ea46f39, #"death");
  var_e189955e = self.scene_ents[# "hash_363ff12eba02d468"];
  var_e189955e waittill(#"flip");
  snd::client_msg("audio_table_flip");
  physicsexplosionsphere(var_e189955e.origin + (0, -16, 32), 60, 0, 0.1);
}

function function_6ea46f39(str_notify) {
  s_scene = struct::get("scene_table_flip");
  s_scene scene::stop();
}

function private function_bb05a3f7() {
  level endon(#"hash_20f535c37929add9", #"flg_rusher_end", #"game_ended");
  level.player endon(#"death");
  level flag::wait_till("flg_graveyard_upper_rusher_start");

  while(true) {
    a_ai = getaiarchetypearray("human", "axis");
    function_1eaaceab(a_ai);

    if(a_ai.size) {
      for(i = 0; i < 2; i++) {
        ai = a_ai[randomintrange(0, a_ai.size)];

        if(isDefined(ai)) {
          ai thread ai::force_goal(level.player);
        }
      }

      wait randomfloatrange(4, 7);
      continue;
    }

    break;
  }
}

function function_84e3ebe0() {
  level endon(#"end_game");
  level.player endon(#"death");
  var_e2990a7b = getent("graveyard_retreat_delete_trigger", "targetname");

  while(true) {
    s_notify = var_e2990a7b waittill(#"trigger");

    if(isalive(s_notify.activator)) {
      s_notify.activator deletedelay();
    }
  }
}

function private function_2a1cc4d0() {
  self endon(#"game_ended", #"disconnect");

  if(isDefined(self.var_3016f2b2)) {
    var_1f3a4780 = getnodearray(self.var_3016f2b2, "targetname");

    if(isDefined(var_1f3a4780)) {
      foreach(nd in var_1f3a4780) {
        if(isDefined(nd.target)) {
          var_4906649c = getnodearray(nd.target, "targetname");

          if(var_4906649c.size) {
            foreach(var_cc827aa1 in var_4906649c) {
              setenablenode(var_cc827aa1, 0);
            }
          }
        }
      }

      self waittill(#"broken");

      foreach(nd in var_1f3a4780) {
        setenablenode(nd, 0);

        if(isDefined(nd.target)) {
          var_4906649c = getnodearray(nd.target, "targetname");

          if(var_4906649c.size) {
            foreach(var_cc827aa1 in var_4906649c) {
              setenablenode(var_cc827aa1, 1);
            }
          }
        }

        ai = getnodeowner(nd);

        if(isDefined(ai) && ai != level.player) {
          ai setgoal(ai.origin, 0, 2048, 1024);
          waitframe(1);

          if(isDefined(ai)) {
            aiutility::releaseclaimnode(ai);
            aiutility::choosebestcovernodeasap(ai);
          }
        }
      }
    }
  }
}

function private function_e6528249() {
  level flag::wait_till("flg_power_returns");
  snd::client_msg("audio_power_on");
  wait 1.3;
  level.adler hms_util::dialogue("vox_cp_seig_01500_adlr_yeahthepowerisc_c9");
  wait 2;
  level.woods hms_util::dialogue("vox_cp_seig_01500_wood_adlerareyouseei_6f", 1);
  level.adler hms_util::dialogue("vox_cp_seig_01800_adlr_woodswererunnin_22");
  level.woods hms_util::dialogue("vox_cp_seig_01800_wood_thatsabiggamble_5c", 1);
  level flag::wait_till_any(["flg_graveyard_turret_intro_started", "graveyard_turret_gunner_killed", "flg_graveyard_unignore"]);

  if(level flag::get("flg_graveyard_turret_intro_started")) {
    wait 0.5;
    level.adler hms_util::dialogue("vox_cp_seig_01700_adlr_watchitheavymgo_90");
  }

  wait 3;
  level.adler hms_util::dialogue("vox_cp_seig_01500_adlr_commandsendinth_0d");
  level.player hms_util::dialogue("vox_cp_seig_01500_hdsn_copythatgetyour_5d", 1);
  level.adler hms_util::dialogue("vox_cp_seig_01700_adlr_thosebomberswon_6a");
  level.woods hms_util::dialogue("vox_cp_seig_01800_wood_youbetterhurryt_8d", 1);
  level thread function_c81a0e5f();
  level flag::wait_till_any(["flg_turret_gunner_fallback", "flg_turret_gunner_killed_all"]);
  level.player hms_util::dialogue("vox_cp_seig_01700_pilo_ordersconfirmed_b3", 1);
  wait 1;
  level.adler hms_util::dialogue("vox_cp_seig_01900_adlr_bellthebombersw_d4");
  level flag::wait_till("flg_call_in_bombers");
  level.player hms_util::dialogue("vox_cp_seig_01700_pilo_coordinatesconf_17", 1);
  level flag::set("flg_start_timer");
  wait 3;
  level.adler hms_util::dialogue("vox_cp_seig_01700_adlr_theradiotowersa_aa");
  level flag::wait_till("flg_fail_timer_30s");
  level.player hms_util::dialogue("vox_cp_seig_01700_pilo_allunitsbeadvis_3e", 1);
}

function private function_c81a0e5f() {
  var_70cf0f3a = ["vox_cp_seig_01700_adlr_belltakeoutthat_8e", "vox_cp_seig_01700_adlr_bellyouregonnah_c6", "vox_cp_seig_01700_adlr_thatmgisduginti_eb", "vox_cp_seig_01700_adlr_bellwellneverge_68"];
  level endon(#"game_ended", #"flg_turret_gunner_fallback");
  level thread function_1914d55();

  for(i = 0; i < var_70cf0f3a.size; i++) {
    wait randomfloatrange(8, 13);
    level flag::wait_till("graveyard_turret_gunner_alive");
    level.adler hms_util::dialogue(var_70cf0f3a[i]);
  }
}

function private function_1914d55() {
  level endon(#"game_ended");

  while(true) {
    a_ai = spawner::get_ai_group_ai("graveyard_turret_group");

    if(a_ai.size && a_ai[0] isatgoal()) {
      level flag::set("graveyard_turret_gunner_alive");
    } else {
      level flag::clear("graveyard_turret_gunner_alive");
    }

    wait 1;
  }
}

function function_ed691e53() {
  level endon(#"game_ended", #"hash_24e97c3654187766");

  while(true) {
    level.adler hms_util::dialogue("vox_cp_seig_01500_adlr_bellwevegottohu_65");
    wait randomfloatrange(10, 15);
    level.adler hms_util::dialogue("vox_cp_seig_01500_adlr_movebellwereout_6e");
    wait randomfloatrange(10, 15);
    level.adler hms_util::dialogue("vox_cp_seig_01500_adlr_bellwevegottohu_65_1");
    wait randomfloatrange(10, 15);
    level.adler hms_util::dialogue("vox_cp_seig_01500_adlr_movebellwereout_6e");
    wait randomfloatrange(10, 15);
  }
}

function private function_ce03fba7() {
  level endon(#"game_ended", #"hash_20f535c37929add9");
  wait 1;
  level.adler hms_util::dialogue("vox_cp_seig_01700_adlr_thebombersareon_6f");
  wait randomfloatrange(7, 12);
  level.adler hms_util::dialogue("vox_cp_seig_01700_adlr_bellthebombersa_e1");
  wait randomfloatrange(7, 12);
  level.adler hms_util::dialogue("vox_cp_seig_01700_adlr_wegottacleartha_20");
}

function function_cb6a2e9b() {
  level flag::wait_till("flg_start_timer");
  level thread function_68842b0f();
  function_cfcd9b92();
}

function function_cfcd9b92() {
  if(!namespace_61e6d095::exists(#"hash_33852677f997cf9b")) {
    namespace_61e6d095::create(#"hash_33852677f997cf9b", #"hash_1d2dffab57e2f728");
    function_e782b221();
  }
}

function function_e782b221() {
  level endon(#"hash_267bd9980f77d5f4", #"level_restarting", #"death");
  level.n_timer = int(60 * 1000);
  namespace_61e6d095::set_time(#"hash_33852677f997cf9b", level.n_timer);

  while(level.n_timer >= 0) {
    if(getDvar(#"hash_3cbb0c98822270b1", 0) == 0) {
      level.n_timer = max(level.n_timer - function_60d95f53(), 0);
    }

    namespace_61e6d095::set_time(#"hash_33852677f997cf9b", level.n_timer);

    if(level flag::get("flg_aa_gun_c4_planted")) {
      level thread function_5e3101b2();
      break;
    } else if(!level flag::get("flg_fail_timer_30s") && level.n_timer <= int(30 * 1000)) {
      level flag::set("flg_fail_timer_30s");
    } else if(level.n_timer <= 0) {
      level thread function_94505a0b();
      break;
    }

    waitframe(1);
  }
}

function function_94505a0b() {
  level notify(#"hash_56a61cb4fe8b8e79");
  function_5e3101b2();
  util::missionfailedwrapper(#"hash_74dae6ee671bda93");
}

function function_5e3101b2() {
  level notify(#"hash_267bd9980f77d5f4");

  if(namespace_61e6d095::exists(#"hash_33852677f997cf9b")) {
    namespace_61e6d095::remove(#"hash_33852677f997cf9b");
  }
}

function function_68842b0f() {
  wait 2;
  level thread function_939a79c0();
}

function function_a5083d9c() {
  level.var_c88d2182 = [];
  level.var_c88d2182[0] = getent("e_radar_1_rotation", "targetname");
  level.var_c88d2182[1] = getent("e_radar_2_rotation", "targetname");
  level.var_c88d2182[2] = getent("e_radar_3_rotation", "targetname");
  level.var_c88d2182[3] = getent("e_radar_4_rotation", "targetname");
  level.var_1d829da4 = [];
  var_9dce209a = struct::get("dish_red_light_fx_1", "targetname");
  var_fb87dc0c = struct::get("dish_red_light_fx_2", "targetname");
  var_7b6c5bd7 = struct::get("dish_red_light_fx_3", "targetname");
  var_892e775b = struct::get("dish_red_light_fx_4", "targetname");
  level.var_1d829da4[0] = spawn("script_model", var_9dce209a.origin);
  level.var_1d829da4[1] = spawn("script_model", var_fb87dc0c.origin);
  level.var_1d829da4[2] = spawn("script_model", var_7b6c5bd7.origin);
  level.var_1d829da4[3] = spawn("script_model", var_892e775b.origin);
  level.var_1d829da4[0].angles = level.var_c88d2182[0].angles + (0, 90, 0);
  level.var_1d829da4[1].angles = level.var_c88d2182[1].angles + (0, 90, 0);
  level.var_1d829da4[2].angles = level.var_c88d2182[2].angles + (0, 90, 0);
  level.var_1d829da4[3].angles = level.var_c88d2182[3].angles + (0, 90, 0);
  level.var_1d829da4[0] linkto(level.var_c88d2182[0]);
  level.var_1d829da4[1] linkto(level.var_c88d2182[1]);
  level.var_1d829da4[2] linkto(level.var_c88d2182[2]);
  level.var_1d829da4[3] linkto(level.var_c88d2182[3]);

  foreach(e in level.var_1d829da4) {
    e setModel("tag_origin");
    e cp_rus_siege::function_689c12cc();
  }
}

function function_939a79c0() {
  var_5a5a8327 = 0;

  foreach(index, ent in level.var_c88d2182) {
    s_scene = struct::get("radar_" + index + 1, "targetname");

    if(115 - s_scene.angles[1] > var_5a5a8327) {
      var_5a5a8327 = 115 - s_scene.angles[1];
    }
  }

  foreach(index, ent in level.var_c88d2182) {
    ent thread function_6d038c35(index, var_5a5a8327);
  }
}

function function_6d038c35(index, var_5a5a8327) {
  s_scene = struct::get("radar_" + index + 1, "targetname");
  var_69a6acc4 = 115 - s_scene.angles[1];
  var_b1595f6a = var_5a5a8327 / 30 / 20;
  var_5c614d61 = int(var_69a6acc4 / var_b1595f6a);

  for(i = 0; i < var_5c614d61; i++) {
    foreach(ent in s_scene.scene_ents) {
      ent rotateyaw(var_b1595f6a, 0.05);
    }

    self rotateyaw(var_b1595f6a, 0.05);
    wait 0.05;
  }
}

function function_693651a7() {
  var_c3d060a6 = ["graveyard_initial_group", "graveyard_initial_rear_group", "graveyard_turret_group", "graveyard_stair_lmg_group", "graveyard_upper_group", "graveyard_upper_special_group"];
  var_c3d060a6 = namespace_534279a::function_da412d49(var_c3d060a6);
  array::run_all(var_c3d060a6, &deletedelay);
}

function function_71ff3dee() {
  level.var_bf4e61ab = getent("minigun_left", "targetname");
  level.var_4c6b5059 = getent("minigun_right", "targetname");
  level.var_bf4e61ab util::create_cursor_hint(undefined, (0, 0, 10), #"hash_205618f70cd06aa3", undefined, undefined, &give_minigun);
  level.var_4c6b5059 util::create_cursor_hint(undefined, (0, 0, 10), #"hash_205618f70cd06aa3", undefined, undefined, &give_minigun);
}

function give_minigun() {
  self hide();
  w_minigun = getweapon(#"hash_6fb61bc95fdf307c");
  level.player giveweapon(w_minigun);
  level.player switchtoweapon(w_minigun);

  if(self == level.var_bf4e61ab) {
    level.var_4c6b5059 util::remove_cursor_hint();
    level.var_4c6b5059 thread function_914b4909();
    return;
  }

  level.var_bf4e61ab util::remove_cursor_hint();
  level.var_bf4e61ab thread function_914b4909();
}

function function_914b4909() {
  w_minigun = getweapon(#"hash_6fb61bc95fdf307c");

  while(level.player.currentweapon != w_minigun) {
    waitframe(1);
  }

  while(level.player.currentweapon == w_minigun) {
    waitframe(1);
  }

  self util::create_cursor_hint(undefined, (0, 0, 10), #"hash_205618f70cd06aa3", undefined, undefined, &function_585936d9);
}

function function_585936d9() {
  self hide();
  spawnweapon(level.player.currentweapon, level.player.origin + vectornormalize(anglesToForward(level.player.angles)) * 10 + (0, 0, 20), level.player.angles, 0);
  level.player takeweapon(level.player.currentweapon);
  w_minigun = getweapon(#"hash_6fb61bc95fdf307c");
  level.player giveweapon(w_minigun);
  level.player switchtoweapon(w_minigun);
}

function function_5e36a991() {
  var_92d37871 = getplayers()[0];
  level thread function_7a6fed15(var_92d37871);
}

function private function_7a6fed15(var_9621dba4) {
  level flag::wait_till("flg_district_close");
  var_9621dba4 districts::function_a7d79fcb("catacombs");
  level flag::clear("flg_district_close");
  wait 0.8;
  level thread function_409d60e7(var_9621dba4);
}

function private function_409d60e7(var_22d3a57f) {
  level flag::wait_till("flg_district_away");
  var_22d3a57f districts::function_930f8c81("catacombs");
  level flag::clear("flg_district_away");
  wait 0.8;
  level thread function_7a6fed15(var_22d3a57f);
}