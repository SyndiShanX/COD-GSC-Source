/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_372b72db713e7946.gsc
***********************************************/

#using script_1d21191fa6d656cf;
#using script_2ef0cf51653aaada;
#using script_35ae72be7b4fec10;
#using script_3b2905ec05ed796;
#using script_41e8adffbda93483;
#using script_498cf7685befe7bf;
#using script_77f51076c7c89596;
#using script_e3ec3024527fc15;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\districts;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\achievements;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#namespace namespace_b11c1856;

function starting(str_objective) {
  level.allowbattlechatter[# "allies"] = 0;
  level.allowbattlechatter[# "axis"] = 0;
  exploder::exploder("lgt_exp_pre_nuke_ext_lights");
  namespace_534279a::spawn_allies();
  namespace_604e2e22::function_3b9e7104();
  level.var_77be18d2 = vehicle::simple_spawn_single("player_fav");
  level.var_7b278a4f = vehicle::simple_spawn_single("ally_fav_left");
  level.var_5d798cf2 = vehicle::simple_spawn_single("ally_fav_right");
  vehicle::simple_spawn("veh_town");
  level thread namespace_604e2e22::function_1e2a0690("aa_courtyard", "courtyard_aa_gunner", "scene_sge_0000_ambient_aa_gun");
  snd::client_targetname(level.var_77be18d2, "audio_vehicle_drive_in_post_emp");
  namespace_95f223d5::music("1.5_approach_checkpoint");
  snd::client_msg("audio_intro_triton_disable");
}

function main(str_objective, var_50cc0d4f) {
  level.player.var_46111c07 = 0;
  level.player.var_ee4032c4 = 0;
  level util::create_streamer_hint((7833.92, -3391.2, 161.25), (0, 200, 0), 1);
  savegame::checkpoint_save();

  if(var_50cc0d4f === 1) {
    level.var_77be18d2 thread vehicle::lights_on();
    level thread namespace_ce17746::function_ee43d0f7();
    level thread namespace_ce17746::function_53c16fe1();
    level thread namespace_604e2e22::function_4a3de7f5("emp");
    exploder::exploder("fxexp_env_fx_set_courtyard");
    scene::function_27f5972e("p9_fxanim_cp_siege_watch_tower_destruction_bundle");
    scene::function_27f5972e("p9_fxanim_cp_siege_wood_gate_bundle");
  }

  level thread function_47fb5849();
  level thread function_7df588f1();
  level thread function_b644bfb7();
  level thread function_cee4c961();
  level thread function_575dfa11();
  level thread function_e9849cb4();
  level thread function_993246a7();
  level thread function_669e6733();
  level thread function_86f5a078();
  level thread function_ba67eb3b();
  level thread function_256fa8b();
  level flag::set("flg_intro_ride_in_progress");
  level thread namespace_ce17746::function_91d00da9();
  level thread function_5b0b935c();
  thread namespace_1512c89a::function_ff11843e();
  level waittill(#"hash_591304b4cda16171");
  skipto::function_4e3ab877("emp_flash");
  function_f3c202c9();
  snd::client_targetname(level.var_77be18d2, "audio_vehicle_drive_in_post_emp");
  level.player.var_ee4032c4 = undefined;
}

function function_7df588f1() {
  level flag::wait_till("flg_emp_blast");
  var_8cb61842 = spawner::simple_spawn("emp_enemy");

  foreach(ai in var_8cb61842) {
    if(isDefined(ai.script_noteworthy)) {
      if(ai.script_noteworthy == "ai_rpg_mid_left") {
        level.ai_rpg_mid_left = ai;
      }

      if(ai.script_noteworthy == "ai_rpg_mid_right") {
        level.ai_rpg_mid_right = ai;
      }
    }
  }

  var_69c7ff32 = getEntArray("veh_town", "targetname");

  foreach(vh in var_69c7ff32) {
    level thread function_d2b31a03(vh);
  }

  a_ai = spawner::simple_spawn("emp_turret_enemy");
  var_e37ea03f = undefined;
  var_8933ebaf = undefined;
  var_79c24ccc = undefined;
  var_f1a8db84 = undefined;
  var_71c65bbd = undefined;
  var_8300fe32 = undefined;

  foreach(ai in a_ai) {
    nd = getnode(ai.target, "targetname");
    vh = function_1a2a3760(nd);
    vh setteam("axis");
    vh turretsetontargettolerance(0, 0);
    vh turret::enable(0);
    vh turret::set_burst_parameters(randomintrange(5, 10), randomintrange(10, 15), randomfloatrange(0.25, 0.5), randomfloatrange(0.5, 0.75), 0);
    vh turret::get_in(ai, 0);

    if(isDefined(ai.script_noteworthy)) {
      switch (ai.script_noteworthy) {
        case # "intro_hit_player_1":
          var_e37ea03f = ai;
          var_f1a8db84 = vh;
          break;
        case # "intro_hit_player_2":
          var_8933ebaf = ai;
          var_71c65bbd = vh;
          break;
        case # "intro_hit_player_3":
          var_79c24ccc = ai;
          var_8300fe32 = vh;
          break;
        default:
          assertmsg("<dev string:x38>");
          break;
      }
    }
  }

  level thread function_74bcaf79(var_e37ea03f, var_8933ebaf, var_79c24ccc, var_f1a8db84, var_71c65bbd, var_8300fe32);
  level flag::wait_till("flg_spawn_drones_1");
  level.var_4180f434 = spawner::simple_spawn("spawn_drones_1");
}

function function_74bcaf79(var_e37ea03f, var_8933ebaf, var_79c24ccc, var_f1a8db84, var_71c65bbd, var_8300fe32) {
  level.player endon(#"death");
  level thread function_6ad56a7d();
  level flag::wait_till("flg_intro_hit_player_1");
  function_544c7da1(var_e37ea03f, var_f1a8db84);

  if(level.player getammocount(level.player.currentweapon) == 36) {
    wait 0.5;
    function_544c7da1(var_e37ea03f, var_f1a8db84);
  }

  level flag::wait_till("flg_intro_hit_player_2");
  function_544c7da1(var_8933ebaf, var_71c65bbd);
  var_9cf32ad5 = undefined;

  switch (level.gameskill) {
    case 0:
      var_9cf32ad5 = 0;
      break;
    case 1:
      var_9cf32ad5 = 1;
      break;
    case 2:
      var_9cf32ad5 = 2;
      break;
    case 3:
      var_9cf32ad5 = 3;
      break;
    case 4:
      var_9cf32ad5 = 3;
      break;
    default:
      assertmsg("<dev string:x7d>");
      break;
  }

  if(level.player.var_ee4032c4 < var_9cf32ad5) {
    function_544c7da1(var_8933ebaf, var_71c65bbd);
  }

  level flag::wait_till("flg_intro_hit_player_3");
  level thread function_22a95b63();

  switch (level.gameskill) {
    case 0:
      var_9cf32ad5 = 1;
      break;
    case 1:
      var_9cf32ad5 = 2;
      break;
    case 2:
      var_9cf32ad5 = 4;
      break;
    case 3:
      var_9cf32ad5 = 5;
      break;
    case 4:
      var_9cf32ad5 = 6;
      break;
    default:
      assertmsg("<dev string:x7d>");
      break;
  }

  if(level.player.var_ee4032c4 < var_9cf32ad5) {
    function_544c7da1(var_79c24ccc, var_8300fe32);
  }

  level.player val::reset(#"emp_mg", "takedamage");
}

function function_6ad56a7d() {
  level.player endon(#"death");
  wait 2;
  level flag::set("flg_intro_hit_player_1");
  wait 5.5;
  level flag::set("flg_intro_hit_player_2");
  wait 5.5;
  level flag::set("flg_intro_hit_player_3");
}

function function_544c7da1(ai, vh) {
  level.player endon(#"death");

  if(!isalive(ai)) {
    return;
  }

  ai endon(#"death");
  ai endon(#"entitydeleted");
  i_damage = undefined;

  switch (level.gameskill) {
    case 0:
      i_damage = 6;
      break;
    case 1:
      i_damage = 10;
      break;
    case 2:
      i_damage = 12;
      break;
    case 3:
      i_damage = 14;
      break;
    case 4:
      i_damage = 16;
      break;
    default:
      assertmsg("<dev string:x7d>");
      break;
  }

  level.var_77be18d2.ignoreme = 0;
  vh turret::set_burst_parameters(100, 100, 0.05, 0.05, 0);
  level thread function_57a15b5(ai, vh);
  wait 1;
  level.player val::set(#"emp_mg", "takedamage", 1);
  function_f17eac00(i_damage, vh);
  level.player val::set(#"emp_mg", "takedamage", 0);
  wait randomfloatrange(0.1, 0.3);
  level.player val::set(#"emp_mg", "takedamage", 1);
  function_f17eac00(i_damage, vh);
  level.player val::set(#"emp_mg", "takedamage", 0);
  wait randomfloatrange(0.5, 1);
  level.player val::set(#"emp_mg", "takedamage", 1);
  function_f17eac00(i_damage, vh);
  level.player val::set(#"emp_mg", "takedamage", 0);
  wait 1;
  vh turret::set_burst_parameters(randomintrange(5, 10), randomintrange(10, 15), randomfloatrange(0.25, 0.5), randomfloatrange(0.5, 0.75), 0);
  level.var_77be18d2.ignoreme = 1;
}

function function_f17eac00(i_damage, e_source) {
  level.player dodamage(1, e_source.origin);
  level.player.health++;

  if(level.player.health > i_damage) {
    level.player.health -= i_damage;
    return;
  }

  level.player dodamage(1000, e_source.origin);
}

function function_57a15b5(ai, vh) {
  ai endon(#"death");
  ai endon(#"entitydeleted");
  i = 0;

  while(i < 2) {
    var_21bd6951 = randomfloatrange(-50, 50);
    var_ef7f04d5 = randomfloatrange(-50, 50);
    var_fd39a04a = randomfloatrange(-50, 50);
    vh turret::set_target(level.var_77be18d2, (var_21bd6951, var_ef7f04d5, var_fd39a04a + 50), 0, 1, 1);
    wait 0.05;
    i += 0.05;
  }
}

function function_d2b31a03(vh) {
  s_result = vh waittill(#"death");

  if(isDefined(s_result.weapon) && s_result.weapon.name === # "hash_154127ac67af815e") {
    level.player.var_ee4032c4++;
  }
}

function function_22a95b63() {
  level.player endon(#"death");
  level waittill(#"hash_b8fa6af917a13ca");
  level.player val::set(#"hash_2d28107834c48f84", "allowdeath", 0);
  level waittill(#"hash_465d6bb5960c37f8");
  level.player val::reset(#"hash_2d28107834c48f84", "allowdeath");
}

function function_b644bfb7() {
  level waittill(#"hash_100baecc1ac1beca");
  a_ai = spawner::get_ai_group_ai("emp_group");
  array::run_all(a_ai, &deletedelay);
  level waittill(#"hash_4df9e3fc761b00b4");
  a_ai = spawner::get_ai_group_ai("town_group");
  array::run_all(a_ai, &deletedelay);
  var_fb90e03a = getEntArray("veh_town", "targetname");

  foreach(e in var_fb90e03a) {
    e notify(#"hash_6c7ae72dc5e27d35");
    e deletedelay();
  }

  level waittill(#"hash_188b223cffb6e50a");
  a_ai = spawner::get_ai_group_ai("guard_station_group");
  array::run_all(a_ai, &deletedelay);
  level waittill(#"hash_465d6bb5960c37f8");
  a_ai = spawner::get_ai_group_ai("tower_group");
  array::run_all(a_ai, &deletedelay);
  a_ai = spawner::get_ai_group_ai("tower_rpg_group");
  array::run_all(a_ai, &deletedelay);

  foreach(drone in level.var_4180f434) {
    if(isDefined(drone)) {
      drone deletedelay();
    }
  }
}

function function_de2dfc58() {
  wait 20;
  level endon(#"camera_movement");
  level thread function_86531f64();
  var_94c47885 = (-6, 0, 0);
  n_lerp_time = 5;
  var_c046d22f = level.player getplayerangles();
  i = 0;

  while(i <= n_lerp_time) {
    var_6603789d = i / n_lerp_time;
    x = (var_94c47885[0] - var_c046d22f[0]) * var_6603789d + var_c046d22f[0];
    y = (var_94c47885[1] - var_c046d22f[1]) * var_6603789d + var_c046d22f[1];
    z = (var_94c47885[2] - var_c046d22f[2]) * var_6603789d + var_c046d22f[2];
    level.player setplayerangles((x, y, z));
    wait 0.05;
    i += 0.05;
  }

  level.player cameraactivate(0);
}

function function_86f5a078() {
  level flag::wait_till("flg_emp_blast");
  wait 1.25;
  magicbullet(getweapon("launcher_standard_t9_cp_straight_shot_siege"), (-818, 7011, 250), (2194, 3652, 125), level.player);
}

function function_256fa8b() {
  level.var_f5b3bac1[2] thread namespace_9e5ef376::function_489160a1("courtyard_redshirt_start_left_1");
  level.var_f5b3bac1[0] thread namespace_9e5ef376::function_489160a1("courtyard_redshirt_start_left_2");
  level.var_f5b3bac1[1] thread namespace_9e5ef376::function_489160a1("courtyard_redshirt_start_left_3");
  level.var_f5b3bac1[3] thread namespace_9e5ef376::function_489160a1("courtyard_redshirt_start_right_1");
  level.var_f5b3bac1[5] thread namespace_9e5ef376::function_489160a1("courtyard_redshirt_start_right_2");
  level.var_f5b3bac1[7] thread namespace_9e5ef376::function_489160a1("courtyard_redshirt_start_right_3");
  level.var_f5b3bac1[4] thread namespace_9e5ef376::function_489160a1("courtyard_redshirt_start_right_3", 1);
  level.var_f5b3bac1[6] thread namespace_9e5ef376::function_489160a1("courtyard_redshirt_start_right_3", 1);
}

function function_ba67eb3b() {
  level waittill(#"flg_wall_rpg");
  var_b986bc82 = getEntArray("veh_wall_vignette", "script_noteworthy");
  array::run_all(var_b986bc82, &util::stop_magic_bullet_shield);
  level.var_82e50b77 val::reset("scene_sge_1010_apr_intro:2010_emp", "allowdeath");
  level.var_82e50b77 util::stop_magic_bullet_shield();
  wait 1.75;
  var_b50c6c7 = spawner::get_ai_group_ai("tower_group");
  var_3ab4d4b2 = spawner::get_ai_group_ai("tower_rpg_group");
  array::thread_all(var_b50c6c7, &ai::shoot_at_target, "normal", level.var_82e50b77, undefined, 10, undefined, 1);
  array::thread_all(var_3ab4d4b2, &ai::shoot_at_target, "normal", level.var_82e50b77, undefined, 10, undefined, 1);
  s_rpg_origin = struct::get("s_rpg_origin", "targetname");
  s_rpg_target = struct::get("s_rpg_target", "targetname");
  magicbullet(getweapon("launcher_standard_t9_cp_straight_shot_siege"), s_rpg_origin.origin, s_rpg_target.origin);
  level flag::set("flg_wall_rpg_magic_bullet");
  level thread function_848b5c69();
  level waittill(#"flg_wall_crash");
  level flag::clear("flg_wall_rpg_magic_bullet");
  snd::client_msg("flg_audio_wall_crash");
}

function function_848b5c69() {
  wait 2;
  level.player val::set(#"hash_4dc1b5696b832566", "allowdeath", 0);
  level.player dodamage(1000, (6943, -626, 66));
  snd::client_msg("audio_triton_enable_approach_end");
  wait 10;
  level.player val::reset(#"hash_4dc1b5696b832566", "allowdeath");
}

function function_86531f64() {
  while(level.player getnormalizedcameramovement()[0] == 0 && level.player getnormalizedcameramovement()[1] == 0) {
    waitframe(1);
  }

  level notify(#"camera_movement");
}

function cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {}

function function_669e6733() {
  level waittill(#"hash_39210373f249ed12");

  if(isalive(level.ai_rpg_mid_right)) {
    s_origin = struct::get("s_rpg_miss_origin");
    s_target = struct::get("s_rpg_miss_target");
    magicbullet(getweapon("launcher_standard_t9_cp_straight_shot_siege"), s_origin.origin, s_target.origin);
  }

  level waittill(#"hash_2fb4fdfd35dc601f");

  if(isalive(level.ai_rpg_mid_left)) {
    s_origin = struct::get("s_rpg_miss_2_origin");
    s_target = struct::get("s_rpg_miss_2_target");
    magicbullet(getweapon("launcher_standard_t9_cp_straight_shot_siege"), s_origin.origin, s_target.origin);
  }
}

function function_cee4c961() {
  level.var_26eb7ff5 = 0;
  level.var_b80457b0 = 0;
  var_5c6c150c = struct::get_array("watch_tower_destruction", "targetname");
  array::thread_all(var_5c6c150c, &function_5bf8b176);
  var_9892ef20 = getEntArray("veh_town", "targetname");
  array::thread_all(var_9892ef20, &function_5bf8b176);
}

function function_5bf8b176() {
  level.player endon(#"death");
  self endon(#"hash_6c7ae72dc5e27d35");
  self waittill(#"death");
  level.player.var_46111c07++;

  if(level.player.var_46111c07 == 10) {
    level.player achievements::give_achievement(#"cp_achievement_scorched_earth2");
  }

  if(gettime() < level.var_b80457b0 + 3000) {
    return;
  }

  switch (level.var_26eb7ff5) {
    case 0:
      level.adler thread hms_util::dialogue("vox_cp_seig_01100_adlr_nowwerecooking_2d");
      break;
    case 1:
      level.adler thread hms_util::dialogue("vox_cp_seig_01100_adlr_pouriton_c1");
      break;
  }

  level.var_26eb7ff5++;
  level.var_b80457b0 = gettime();

  if(level.var_26eb7ff5 >= 2) {
    level.var_26eb7ff5 = 0;
  }
}

function function_575dfa11() {
  level.var_50f33587 = 0;
  level.var_fd0e50a2 = 0;
  callback::on_vehicle_damage(&function_d4aec214);
}

function function_d4aec214(params) {
  if(params.eattacker !== level.player) {
    return;
  }

  var_a28063f4 = self === level.var_7b278a4f;
  var_e75e3cca = self === level.var_5d798cf2;
  var_9117ab6c = self === level.var_82e50b77;
  var_8d8229bf = isinarray(level.var_a1030c4e, self);

  if(!(var_a28063f4 || var_e75e3cca || var_8d8229bf)) {
    return;
  }

  if(gettime() < level.var_fd0e50a2 + 3000) {
    return;
  }

  switch (level.var_50f33587) {
    case 0:
      level.adler thread hms_util::dialogue("vox_cp_seig_01100_adlr_watchyouraimbel_39");
      break;
    case 1:
      level.adler thread hms_util::dialogue("vox_cp_seig_01100_adlr_watchittheyreon_fa");
      break;
    case 2:
      level.player thread hms_util::dialogue("vox_cp_seig_01100_masn_watchfirewatchf_dc", 1);
      break;
  }

  level.var_50f33587++;
  level.var_fd0e50a2 = gettime();

  if(level.var_50f33587 >= 3) {
    level.var_50f33587 = 0;
  }
}

function function_f3c202c9() {
  var_5c6c150c = struct::get_array("watch_tower_destruction", "targetname");

  foreach(var_90946929 in var_5c6c150c) {
    var_90946929 notify(#"hash_6c7ae72dc5e27d35");
  }

  var_9892ef20 = getEntArray("veh_town", "targetname");

  foreach(var_825d3987 in var_9892ef20) {
    var_825d3987 notify(#"hash_6c7ae72dc5e27d35");
  }

  callback::remove_on_vehicle_damage(&function_d4aec214);
}

function function_e9849cb4() {
  level flag::wait_till("flg_emp_blast");
  level endon(#"hash_1339dcac629a7afb");
  s_waitresult = level.player waittilltimeout(5, #"weapon_fired");

  if(s_waitresult._notify == "weapon_fired") {
    return;
  }

  level.player util::show_hint_text(#"hash_4496122e436b7380", 0, "weapon_fired", 18);
  s_waitresult = level.player waittilltimeout(18, #"weapon_fired");
}

function function_993246a7() {
  level flag::wait_till("flg_emp_blast");
  objectives::remove(#"hash_62624188ae803d4f");
  objectives::scripted("obj_emp_mg", undefined, #"hash_1955f1a3c2418318", 0);
  level waittill(#"flg_wall_crash");
  objectives::remove("obj_emp_mg");
}

function function_c0557b7a(var_97009eaf, var_17151ed6, var_c5a3eca9) {
  level endon(var_c5a3eca9);

  while(true) {
    if(is_true(var_97009eaf.var_5435d94) && is_true(var_17151ed6.var_5435d94)) {
      level flag::set(var_c5a3eca9);
    }

    waitframe(1);
  }
}

function private function_47fb5849() {
  e_player = getplayers()[0];
  e_player districts::function_930f8c81("interior_cathedral_01");
  level flag::wait_till("flg_emp_blast");
  e_player districts::function_a7d79fcb("vista_buildings_main_street");
  level waittill(#"flg_wall_rpg");
  wait 2.75;
  e_player districts::function_930f8c81("vista_buildings_main_street");
  wait 1;
  e_player districts::function_a7d79fcb("west_wall_blockout");
  e_player districts::function_a7d79fcb("interior_cathedral_01");
}

function function_5b0b935c() {
  level waittill(#"hash_b8fa6af917a13ca");
  level.player playrumbleonentity("explosion_generic");
  level waittill(#"hash_af75fb9dee3d105");
  level.player playrumbleonentity("damage_heavy");
  level waittill(#"hash_5e20063bd2c01416");
  level.player playrumbleonentity("riotshield_impact");
  level waittill(#"hash_3d2d4e3bc0920646");
  level.player playrumbleonentity("damage_heavy");
  level waittill(#"hash_25609fdc6b3f335e");
  level.player playrumbleonentity("leap_end");
}