/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_41e8adffbda93483.gsc
***********************************************/

#using script_1b9f100b85b7e21d;
#using script_1d21191fa6d656cf;
#using script_2ef0cf51653aaada;
#using script_2f4f71f95573b891;
#using script_3b2905ec05ed796;
#using script_4489198b8bcf36e8;
#using script_498cf7685befe7bf;
#using script_589f7fc6e210aea7;
#using script_77f51076c7c89596;
#using script_e3ec3024527fc15;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\districts;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp\cp_rus_siege;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\spawn_manager;
#using scripts\cp_common\util;
#using scripts\killstreaks\planemortar_shared;
#namespace namespace_9e5ef376;

function function_abfa576(str_objective) {
  level.courtyard_enemies = [];
  exploder::exploder("lgt_exp_pre_nuke_ext_lights");
  namespace_534279a::spawn_allies();
  namespace_604e2e22::function_3b9e7104();
  level thread namespace_604e2e22::function_1e2a0690("aa_courtyard", "courtyard_aa_gunner", "scene_sge_0000_ambient_aa_gun");
  level thread namespace_604e2e22::function_4a3de7f5("courtyard");
  level.var_77be18d2 = vehicle::simple_spawn_single("player_fav");
  level.var_77be18d2 val::set(#"hash_533b89b2c3072f64", "takedamage", 0);
  level.var_7b278a4f = vehicle::simple_spawn_single("ally_fav_left");
  level.var_5d798cf2 = vehicle::simple_spawn_single("ally_fav_right");
  snd::client_targetname(level.var_77be18d2, "audio_courtyard_fav_idle");
  scene::function_27f5972e("p9_fxanim_cp_siege_radar_destruction_01_bundle");
}

function function_802a0aed(str_objective, var_50cc0d4f) {
  level.player endon(#"death");
  level thread function_33dd0a42();
  namespace_95f223d5::music("2.0_courtyard");
  level util::function_f6847a11();
  level thread namespace_604e2e22::function_1af0cb0("courtyard");

  if(!var_50cc0d4f) {
    level waittill(#"hash_465d6bb5960c37f8");
    level.allowbattlechatter[#"allies"] = 1;
    level.allowbattlechatter[#"axis"] = 1;
    var_3e3877e9 = spawner::get_ai_group_ai("initial_ally_group");
  } else {
    level flag::set("flg_courtyard_start");
    level.player allowcrouch(1);
    level.player allowprone(1);
    level.player namespace_534279a::function_6e9256df();
    level.player namespace_534279a::function_a3c3a2b0();
    level notify(#"courtyard_start");
    exploder::exploder("fxexp_env_fx_set_courtyard");
    level thread function_70461e70();
    level.var_f5b3bac1[4] deletedelay();
    level.var_f5b3bac1[6] deletedelay();
  }

  thread namespace_1512c89a::function_ff11843e();
  level thread function_c9d72e76();
  var_8f33990e = spawner::simple_spawn_single("courtyard_aa_gunner");
  level thread function_50680202(var_8f33990e);
  level thread function_fba8776c(var_8f33990e);
  var_dbdb0082 = getEntArray("veh_courtyard_static", "targetname");
  array::run_all(var_dbdb0082, &val::set, #"hash_7d97d109d0838d04", "ignoreme", 1);
  level thread hms_util::function_eaa0342e("courtyard_containment_warn", "courtyard_containment_fail");
  level thread function_f40bfd86();
  level thread function_b414002b();
  level thread function_e3ac7d4e();
  level thread function_488f070b();
  level thread function_2033fa29();
  level.adler thread function_1e101b5a();
  level.woods thread function_1e101b5a();
  level.mason thread function_1e101b5a();
  wait 5;
  var_1054f3aa = getEntArray("courtyard_initial_ally_positions", "targetname");
  array::run_all(var_1054f3aa, &trigger::use);
  objectives::goto(#"hash_2f798f965e783781", (8385.2, -3200.5, 350.861), #"hash_1a6596414acc0306");
  objectives::show(#"hash_2f798f965e783781");
  function_6ea2cd94();
  objectives::complete(#"hash_1408f7418b622890");
  savegame::checkpoint_save();
  var_5d0c20f2 = spawner::get_ai_group_ai("courtyard_chapel_window_group");
  var_1490a75e = var_5d0c20f2.size;
  level thread function_1eb17b46();
  var_811b60d = struct::get("objective_marker_right_path_start");
  objectives::goto(#"hash_7956ac3690b300bb", var_811b60d.origin, #"hash_74dd5a3afb4c014e");
  objectives::show(#"hash_7956ac3690b300bb");
  var_3e88828c = getEntArray("courtyard_assault_fallback_2", "targetname");
  array::run_all(var_3e88828c, &trigger::use);
  level flag::wait_till("flg_open_chapel_door");
  level thread function_b7e649c0();
  var_5b3c6590 = struct::get("objective_marker_right_path_catacomb");
  objectives::update_position(#"hash_7956ac3690b300bb", var_5b3c6590.origin);
  namespace_534279a::function_bd1a75b("courtyard_chapel_group", 0, "flg_right_path_cathedral_fallback");
  level flag::set("flg_west_wing_dialog");
  var_935774e6 = getent("courtyard_door_advance", "targetname");
  var_935774e6 trigger::use();
  savegame::checkpoint_save();
  level.player val::reset("courtyard_encounter", "attackeraccuracy");
  objectives::hide(#"hash_7956ac3690b300bb");
  level thread skipto::function_4e3ab877("courtyard");
  var_396eb974 = getEntArray("vol_catacomb_advance_0", "targetname");
  array::run_all(var_396eb974, &trigger::use);
  var_3e88828c = getEntArray("courtyard_assault_fallback_3", "targetname");
  array::run_all(var_3e88828c, &trigger::use);
}

function private function_70461e70() {
  wait 1;
  var_3e3877e9 = spawner::get_ai_group_ai("courtyard_allies");
  level.var_f5b3bac1[2] thread function_87df4432("courtyard_redshirt_start_left_1");
  level.var_f5b3bac1[3] thread function_87df4432("courtyard_redshirt_start_right_1");
  wait 0.35;
  level.var_f5b3bac1[0] thread function_87df4432("courtyard_redshirt_start_left_2");
  level.var_f5b3bac1[5] thread function_87df4432("courtyard_redshirt_start_right_2");
  wait 0.2;
  level.var_f5b3bac1[1] thread function_87df4432("courtyard_redshirt_start_left_3");
  level.var_f5b3bac1[7] thread function_87df4432("courtyard_redshirt_start_right_3");
}

function function_87df4432(str_target) {
  if(!isentity(self)) {
    return;
  }

  if(level flag::get("flg_courtyard_start")) {
    self pushplayer(1);
  }

  var_2fe6984 = struct::get(str_target, "targetname");
  self thread spawner::go_to_node(var_2fe6984);
  self ai::set_behavior_attribute("sprint", 1);
  self val::set("wall_breach", "ignoreall", 1);
}

function private function_33dd0a42() {
  level endon(#"flg_player_entering_courtyard");
  var_175c9e88 = struct::get_array("courtyard_magic_bullet_origin", "targetname");
  a_s_target = struct::get_array("courtyard_magic_bullet_target", "targetname");

  while(true) {
    level thread function_4a9738ac(array::random(var_175c9e88), array::random(a_s_target));
    wait randomfloatrange(0.25, 2);
  }
}

function private function_4a9738ac(s_origin, s_target) {
  var_f0935a68 = getweapon("turret_manned_m60");
  var_7722d34c = randomintrange(4, 10);

  for(i = 0; i < var_7722d34c; i++) {
    magicbullet(var_f0935a68, s_origin.origin, s_target.origin);
    wait 0.1;
  }
}

function function_489160a1(str_target, b_delete = 0) {
  self endon(#"death");
  self flag::wait_till_clear(#"riding_vehicle");
  self flag::wait_till_clear(#"scripted_anim_this_frame");

  if(b_delete) {
    self deletedelay();
    return;
  }

  self function_87df4432(str_target);
}

function function_2033fa29() {
  createthreatbiasgroup("player");
  createthreatbiasgroup("courtyard");
  setthreatbias("player", "courtyard", 750);
  level.player setthreatbiasgroup("player");
  var_e1d6eabc = getspawnerarray("courtyard_reinforcement_1_left", "targetname");
  var_eddf88e5 = getspawnerarray("courtyard_reinforcement_1_rear", "targetname");
  var_e1d6eabc = arraycombine(var_e1d6eabc, var_eddf88e5, 0);
  var_eddf88e5 = getspawnerarray("courtyard_reinforcement_1_right", "targetname");
  var_e1d6eabc = arraycombine(var_e1d6eabc, var_eddf88e5, 0);
  var_eddf88e5 = getspawnerarray("courtyard_reinforcement_2_left", "targetname");
  var_e1d6eabc = arraycombine(var_e1d6eabc, var_eddf88e5, 0);
  var_eddf88e5 = getspawnerarray("courtyard_reinforcement_2_rear", "targetname");
  var_e1d6eabc = arraycombine(var_e1d6eabc, var_eddf88e5, 0);
  var_eddf88e5 = getspawnerarray("courtyard_reinforcement_2_right", "targetname");
  var_e1d6eabc = arraycombine(var_e1d6eabc, var_eddf88e5, 0);
  var_eddf88e5 = getspawnerarray("courtyard_reinforcement_3_5_left", "targetname");
  var_e1d6eabc = arraycombine(var_e1d6eabc, var_eddf88e5, 0);
  var_eddf88e5 = getspawnerarray("courtyard_reinforcement_3_5_rear", "targetname");
  var_e1d6eabc = arraycombine(var_e1d6eabc, var_eddf88e5, 0);
  var_eddf88e5 = getspawnerarray("courtyard_reinforcement_3_5_right", "targetname");
  var_e1d6eabc = arraycombine(var_e1d6eabc, var_eddf88e5, 0);
  var_eddf88e5 = getspawnerarray("courtyard_reinforcement_3_left", "targetname");
  var_e1d6eabc = arraycombine(var_e1d6eabc, var_eddf88e5, 0);
  var_eddf88e5 = getspawnerarray("courtyard_reinforcement_3_rear", "targetname");
  var_e1d6eabc = arraycombine(var_e1d6eabc, var_eddf88e5, 0);
  var_eddf88e5 = getspawnerarray("courtyard_reinforcement_3_right", "targetname");
  var_e1d6eabc = arraycombine(var_e1d6eabc, var_eddf88e5, 0);
  array::thread_all(var_e1d6eabc, &spawner::add_spawn_function, &function_a6534cdc);
}

function function_a6534cdc() {
  self endon(#"death");
  self setthreatbiasgroup("courtyard");
}

function function_488f070b() {
  level.woods hms_util::dialogue("vox_cp_seig_01100_wood_pushthroughpush_c9");
  level flag::wait_till("flg_player_entering_courtyard");
  objectives::remove(#"hash_2f798f965e783781");
  level.adler thread hms_util::dialogue("vox_cp_seig_01200_adlr_aagunstraightah_b2");
  var_667bdbcd = [getent("aa_courtyard", "targetname")];
  objectives::kill(#"hash_1408f7418b622890", var_667bdbcd, #"hash_596228abde0d7286", undefined, 0, 1);
  objectives_ui::function_49dec5b(#"hash_1408f7418b622890", var_667bdbcd[0], #"hash_7056653275b7909e");
  wait 2;
  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.adler, "vox_cp_seig_01700_adlr_rpg_0a");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.adler, "vox_cp_seig_01700_adlr_rpgs_7d");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.adler, "vox_cp_seig_01700_adlr_headsuprpg_35");
  level thread hms_util::vo_knockout_manager("courtyard_RPG", var_ffbbfc35);
  level flag::wait_till("flg_courtyard_smoke_dialog");
  var_22f9de73 = [];
  var_22f9de73[0] = hms_util::function_e1449992(level.adler, "vox_cp_seig_01900_adlr_theygotuspinned_06");
  var_22f9de73[1] = hms_util::function_e1449992(level.adler, "vox_cp_seig_01900_adlr_werepinneddownb_5e");
  var_22f9de73[2] = hms_util::function_e1449992(level.adler, "vox_cp_seig_01900_adlr_theygotuspinned_d8");
  var_22f9de73[3] = hms_util::function_e1449992(level.adler, "vox_cp_seig_01900_adlr_weneedcoverbell_e5");
  hms_util::vo_knockout_manager("courtyard_smoke_reminder", var_22f9de73);
  level flag::wait_till("flg_courtyard_assault_fallback_0");
  level.adler hms_util::dialogue("vox_cp_seig_01200_adlr_masonwoodscover_20");
  level flag::wait_till("flg_courtyard_assault_fallback_2_start");
  level.adler hms_util::dialogue("vox_cp_seig_01200_adlr_bellplantthatc4_03");
  level thread function_e3f8cfba();
  level flag::wait_till("flg_aa_gun_c4_planted");
  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.adler, "vox_cp_seig_01200_adlr_standbackitshot_ce");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.adler, "vox_cp_seig_01200_adlr_rightstandbackc_01");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.adler, "vox_cp_seig_01200_adlr_fireinthehole_c7");
  wait 3;
  hms_util::vo_knockout_manager("courtyard_aa_gun", var_ffbbfc35);
  level waittill(#"hash_261ad1569f4c15d1");
  wait 2;
  level.adler hms_util::dialogue("vox_cp_seig_01300_adlr_niceworkintothe_5c");
  level flag::wait_till("flg_west_wing_dialog");
  level.adler hms_util::dialogue("vox_cp_seig_01300_adlr_masonwoodstaket_9d");
  level.woods hms_util::dialogue("vox_cp_seig_01300_wood_wereonit_a9");
}

function function_b7e649c0(var_ddab8604) {
  if(!isDefined(var_ddab8604) || !var_ddab8604) {
    function_1ede49cc();
    return;
  }

  var_643a73f4 = getent("chapel_door_left", "targetname");
  var_a0d4ecdf = getent("chapel_door_right", "targetname");
  var_643a73f4 rotateyaw(-105, 0.3);
  var_a0d4ecdf rotateyaw(95, 0.3);
  var_643a73f4 disconnectpaths();
  var_a0d4ecdf disconnectpaths();
}

function function_1ede49cc() {
  var_7bacf73f = level spawner::simple_spawn("courtyard_chapel_breach_group");
  var_643a73f4 = getent("chapel_door_left", "targetname");
  var_a0d4ecdf = getent("chapel_door_right", "targetname");
  a_actors = [];
  a_actors[#"actor 1"] = var_7bacf73f[0];
  level thread scene::play("scene_rev_0000_door_entry_single_soldier_kick_02_siege", "Shot 1", a_actors);
  a_actors[#"actor 1"] waittill(#"hash_553184e6c2383c0d");
  var_643a73f4 rotateyaw(-95, 0.3);
  var_a0d4ecdf rotateyaw(85, 0.3);
  snd::client_msg("audio_church_doors_kick_open");
  wait 0.5;
  var_643a73f4 disconnectpaths();
  var_a0d4ecdf disconnectpaths();
  wait 0.5;
  level.adler thread hms_util::dialogue("vox_cp_seig_01300_adlr_cutemdown_11");
}

function function_1eb17b46() {
  level.adler endon(#"death");
  level.mason endon(#"death");
  level.woods endon(#"death");
  var_5d0c20f2 = spawner::get_ai_group_ai("courtyard_chapel_window_group");

  if(var_5d0c20f2.size > 1) {
    level.woods thread ai::shoot_at_target("kill_within_time", var_5d0c20f2[1], undefined, 1);
  }

  if(var_5d0c20f2.size > 0) {
    level.mason thread ai::shoot_at_target("kill_within_time", var_5d0c20f2[0], undefined, 1);
  }

  wait 1.5;
  vol_goal = getent("courtyard_chapel_entrance", "targetname");
  a_ai = spawner::get_ai_group_ai("courtyard_enemies");
  array::run_all(a_ai, &setgoal, vol_goal);

  while(a_ai.size > 0) {
    level.adler thread ai::shoot_at_target("kill_within_time", a_ai[0], undefined, 0.5);

    if(a_ai.size > 1) {
      level.mason thread ai::shoot_at_target("kill_within_time", a_ai[1], undefined, 0.5);
    }

    if(a_ai.size > 2) {
      level.woods thread ai::shoot_at_target("kill_within_time", a_ai[2], undefined, 0.5);
    }

    wait 1;
    a_ai = spawner::get_ai_group_ai("courtyard_enemies");
  }

  a_ai = spawner::get_ai_group_ai("courtyard_chapel_group");
  array::run_all(a_ai, &setgoal, vol_goal);

  if(a_ai.size > 0) {
    level.adler thread ai::shoot_at_target("kill_within_time", a_ai[0], undefined, 1);
  }
}

function function_6ea2cd94() {
  level thread namespace_604e2e22::scene_sge_4020_per_bomb_plant("courtyard");
  var_f9e27979 = getent("aa_courtyard", "targetname");
  var_f9e27979 namespace_534279a::function_2a8ee50f("courtyard");
  namespace_95f223d5::music("deactivate_2.0_courtyard");
  var_f9e27979 notify(#"remove_objective");
  level notify(#"hash_261ad1569f4c15d1");
  level flag::set("flg_courtyard_aa_complete");
}

function function_e3f8cfba() {
  var_d3e49516 = [];
  level endon(#"flg_aa_gun_c4_planted");

  while(true) {
    wait 25;

    if(!level flag::get("flg_aa_gun_c4_planted")) {
      level.adler thread hms_util::dialogue("vox_cp_seig_01200_adlr_belltakeoutthat_bb");
      wait 25;
    }

    if(!level flag::get("flg_aa_gun_c4_planted")) {
      level.adler thread hms_util::dialogue("vox_cp_seig_01200_adlr_destroytheaagun_78");
      wait 25;
    }

    if(!level flag::get("flg_aa_gun_c4_planted")) {
      level.adler thread hms_util::dialogue("vox_cp_seig_01200_adlr_theaaguntakeito_89");
      wait 25;
    }

    if(!level flag::get("flg_aa_gun_c4_planted")) {
      level.adler thread hms_util::dialogue("vox_cp_seig_01200_adlr_bellwhatthehell_33");
    }
  }
}

function function_77335d30(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  level flag::set("flg_courtyard_completed");
}

function blocker_init() {
  a_e_blockers = getEntArray("left_path_backtrack_blocker", "targetname");
  array::run_all(a_e_blockers, &show);
  array::run_all(a_e_blockers, &solid);
  a_e_blockers = getEntArray("left_path_return_blocker", "targetname");
  array::run_all(a_e_blockers, &disconnectpaths);
  a_e_blockers = getEntArray("right_path_return_blocker", "targetname");
  array::run_all(a_e_blockers, &disconnectpaths);
  a_e_blockers = getEntArray("courtyard_return_truck", "targetname");
  array::run_all(a_e_blockers, &hide);
  array::run_all(a_e_blockers, &notsolid);
  array::run_all(a_e_blockers, &connectpaths);
}

function private function_f40bfd86() {}

function private function_9dc2e510() {
  var_3e3877e9 = spawner::get_ai_group_ai("courtyard_allies");
  a_ai_enemies = spawner::get_ai_group_ai("courtyard_enemies");
  vol_goal = getent("courtyard_right_rear", "targetname");

  for(i = 0; i < var_3e3877e9.size; i++) {
    var_3e3877e9[i] setgoal(vol_goal);

    if(a_ai_enemies.size > i) {
      a_ai_enemies[i] thread ai::shoot_at_target("kill_within_time", var_3e3877e9[i], undefined, 3);
      continue;
    }

    if(isDefined(a_ai_enemies[0])) {
      a_ai_enemies[0] thread ai::shoot_at_target("kill_within_time", var_3e3877e9[i], undefined, 3);
    }
  }
}

function private function_b414002b() {
  level.player endon(#"death");
  level flag::wait_till("flg_courtyard_spawned");
  exploder::exploder("fxexp_debris_falling_entrance");
  level spawn_manager::enable("courtyard_wave_1_manager");
  waitframe(1);
  var_2f6b9a0 = level spawner::get_ai_group_ai("courtyard_enemies");
  array::run_all(var_2f6b9a0, &util::magic_bullet_shield);
  level flag::wait_till("flg_player_entering_courtyard");
  var_2f6b9a0 = level spawner::get_ai_group_ai("courtyard_enemies");
  array::run_all(var_2f6b9a0, &util::stop_magic_bullet_shield);
  var_11b2a17d = level spawner::get_ai_group_ai("courtyard_window_RPG");
  var_e9fc0486 = level spawner::get_ai_group_ai("courtyard_allies");

  if(var_11b2a17d.size > 0 && var_e9fc0486.size > 0) {
    var_11b2a17d[0] ai::shoot_at_target("kill_within_time", var_e9fc0486[0], undefined, 3);
  }

  level thread function_ae6a9244();
  namespace_534279a::function_4f981a25("courtyard_enemies", 7, "flg_courtyard_assault_fallback_0");
  spawner::waittill_ai_group_amount_killed("courtyard_enemies", 4);
  var_3e88828c = getEntArray("courtyard_assault_fallback_0", "targetname");
  array::run_all(var_3e88828c, &trigger::use);
  level thread function_c4a7bebe();
  level.adler.grenadeammo = 0;
  level.mason.grenadeammo = 0;
  level.woods.grenadeammo = 0;
  namespace_534279a::function_4f981a25("courtyard_enemies", 12, "flg_courtyard_assault_fallback_1");
  spawner::waittill_ai_group_amount_killed("courtyard_enemies", 7);
  var_3e88828c = getEntArray("courtyard_assault_fallback_1", "targetname");
  array::run_all(var_3e88828c, &trigger::use);
  level thread function_f886eda8();
  namespace_534279a::function_bd1a75b("courtyard_enemies", 2, "flg_courtyard_assault_fallback_1_5");
  var_3e88828c = getEntArray("courtyard_assault_fallback_1_5", "targetname");
  array::run_all(var_3e88828c, &trigger::use);
  level thread function_7afaab65();
  level thread function_9dc2e510();
  var_11b2a17d = level spawner::get_ai_group_ai("courtyard_window_RPG");

  if(var_11b2a17d.size) {
    array::thread_all(var_11b2a17d, &function_68675239);
  }

  var_2fe2b603 = level spawner::get_ai_group_ai("courtyard_roof_RPG");

  if(var_2fe2b603.size) {
    array::thread_all(var_2fe2b603, &function_68675239);
  }

  level flag::wait_till("flg_courtyard_assault_fallback_2_start");
  level thread function_47c5954d();
  level.adler.script_accuracy = 0.9;
  level.woods.script_accuracy = 0.9;
  level.mason.script_accuracy = 0.9;
  level flag::wait_till("flg_right_path_start");
  spawner::waittill_ai_group_amount_killed("courtyard_chapel_group", 2);
  namespace_534279a::function_b5e4f3bc("courtyard_chapel_group", "right_path_cathedral_fallback_volume", "script_noteworthy");
  level.adler.script_accuracy = 0.2;
  level.woods.script_accuracy = 0.2;
  level.mason.script_accuracy = 0.2;
}

function private function_68675239() {
  self kill();
}

function private function_e4a6ccc2() {
  vol_goal = getent("courtyard_chapel_entrance", "targetname");
  a_ai = spawner::get_ai_group_ai("courtyard_enemies");
  array::run_all(a_ai, &setgoal, vol_goal);

  while(a_ai.size > 0) {
    level.adler thread ai::shoot_at_target("kill_within_time", a_ai[0], undefined, 0.5);

    if(a_ai.size > 1) {
      level.mason thread ai::shoot_at_target("kill_within_time", a_ai[1], undefined, 0.5);
    }

    if(a_ai.size > 2) {
      level.woods thread ai::shoot_at_target("kill_within_time", a_ai[2], undefined, 0.5);
    }

    wait 1;
    a_ai = spawner::get_ai_group_ai("courtyard_enemies");
  }

  a_ai = spawner::get_ai_group_ai("courtyard_chapel_group");
  array::run_all(a_ai, &setgoal, vol_goal);

  if(a_ai.size > 0) {
    level.adler thread ai::shoot_at_target("kill_within_time", a_ai[0], undefined, 1);
  }
}

function private function_ae6a9244() {
  level endon(#"flg_courtyard_assault_fallback_0");
  level spawn_manager::function_3c035c82(10);
  level spawn_manager::disable("courtyard_wave_1_manager");
  var_92b71fdd = spawner::get_ai_group_ai("courtyard_enemies");
  a_ai_enemies = getaiarray("courtyard_left", "script_string");
  vol_goal = getent("courtyard_left_front", "targetname");
  array::run_all(a_ai_enemies, &setgoal, vol_goal);
  var_ee755f4d = getEntArray("courtyard_reinforcement_2_left", "targetname");

  foreach(e_spawner in var_ee755f4d) {
    e_spawner.target = "courtyard_left_front";
  }

  a_ai_enemies = getaiarray("courtyard_rear", "script_string");
  vol_goal = getent("courtyard_aa_platform", "targetname");
  array::run_all(a_ai_enemies, &setgoal, vol_goal);
  var_ee755f4d = getEntArray("courtyard_reinforcement_2_rear", "targetname");

  foreach(e_spawner in var_ee755f4d) {
    e_spawner.target = "courtyard_aa_platform";
  }

  a_ai_enemies = getaiarray("courtyard_right", "script_string");
  vol_goal = getent("courtyard_right_front", "targetname");
  array::run_all(a_ai_enemies, &setgoal, vol_goal);
  var_ee755f4d = getEntArray("courtyard_reinforcement_2_right", "targetname");

  foreach(e_spawner in var_ee755f4d) {
    e_spawner.target = "courtyard_right_front";
  }

  level thread function_55a5d157();
  spawner::waittill_ai_group_ai_count("courtyard_enemies", 7);
  level thread function_500e1a20("courtyard_left", "courtyard_wave_2_manager_left", "flg_courtyard_assault_fallback_0");
  level thread function_500e1a20("courtyard_rear", "courtyard_wave_2_manager_rear", "flg_courtyard_assault_fallback_0");
  level thread function_500e1a20("courtyard_right", "courtyard_wave_2_manager_right", "flg_courtyard_assault_fallback_0");
}

function private function_500e1a20(str_group, var_18ae7cf0, str_endon) {
  level endon(str_endon);

  for(a_ai_enemies = getaiarray(str_group, "script_string"); a_ai_enemies.size > 1; a_ai_enemies = getaiarray(str_group, "script_string")) {
    wait 1;
  }

  level spawn_manager::enable(var_18ae7cf0);
}

function private function_c4a7bebe() {
  level endon(#"flg_courtyard_assault_fallback_1");
  level spawn_manager::function_3c035c82(10);
  var_92b71fdd = spawner::get_ai_group_ai("courtyard_enemies");
  level spawn_manager::disable("courtyard_wave_2_manager_left");
  level spawn_manager::disable("courtyard_wave_2_manager_rear");
  level spawn_manager::disable("courtyard_wave_2_manager_right");
  var_3e3877e9 = spawner::get_ai_group_ai("courtyard_allies");
  vol_goal = getent("courtyard_allies_front", "targetname");
  array::run_all(var_3e3877e9, &setgoal, vol_goal);

  if(var_3e3877e9.size < 4) {
    level spawner::simple_spawn("ally_breach_spawner_4");
    level spawner::simple_spawn("ally_breach_spawner_4");
  }

  a_ai_enemies = getaiarray("courtyard_left", "script_string");
  vol_goal = getent("courtyard_left_mid", "targetname");
  array::run_all(a_ai_enemies, &setgoal, vol_goal);
  var_ee755f4d = getEntArray("courtyard_reinforcement_3_left", "targetname");

  foreach(e_spawner in var_ee755f4d) {
    e_spawner.target = "courtyard_left_mid";
  }

  a_ai_enemies = getaiarray("courtyard_rear", "script_string");
  vol_goal = getent("courtyard_left_rear", "targetname");
  array::run_all(a_ai_enemies, &setgoal, vol_goal);
  var_ee755f4d = getEntArray("courtyard_reinforcement_3_rear", "targetname");

  foreach(e_spawner in var_ee755f4d) {
    e_spawner.target = "courtyard_left_rear";
  }

  a_ai_enemies = getaiarray("courtyard_right", "script_string");
  vol_goal = getent("courtyard_aa_platform", "targetname");
  array::run_all(a_ai_enemies, &setgoal, vol_goal);
  var_ee755f4d = getEntArray("courtyard_reinforcement_3_right", "targetname");

  foreach(e_spawner in var_ee755f4d) {
    e_spawner.target = "courtyard_aa_platform";
  }

  spawner::waittill_ai_group_ai_count("courtyard_enemies", 7);
  level thread function_500e1a20("courtyard_left", "courtyard_wave_3_manager_left", "flg_courtyard_assault_fallback_1");
  level thread function_500e1a20("courtyard_rear", "courtyard_wave_3_manager_rear", "flg_courtyard_assault_fallback_1");
  level thread function_500e1a20("courtyard_right", "courtyard_wave_3_manager_right", "flg_courtyard_assault_fallback_1");
}

function private function_f886eda8() {
  level endon(#"flg_courtyard_assault_fallback_1_5");
  savegame::checkpoint_save();
  level spawn_manager::function_3c035c82(8);
  var_92b71fdd = spawner::get_ai_group_ai("courtyard_enemies");
  level spawn_manager::disable("courtyard_wave_3_manager_left");
  level spawn_manager::disable("courtyard_wave_3_manager_rear");
  level spawn_manager::disable("courtyard_wave_3_manager_right");
  var_3e3877e9 = spawner::get_ai_group_ai("courtyard_allies");
  array::run_all(var_3e3877e9, &function_f8fdc218);
  a_ai_enemies = getaiarray("courtyard_left", "script_string");
  vol_goal = getent("courtyard_left_rear", "targetname");
  array::run_all(a_ai_enemies, &setgoal, vol_goal);
  var_ee755f4d = getEntArray("courtyard_reinforcement_3_5_left", "targetname");

  foreach(e_spawner in var_ee755f4d) {
    e_spawner.target = "courtyard_left_rear";
  }

  a_ai_enemies = getaiarray("courtyard_rear", "script_string");
  vol_goal = getent("courtyard_aa_platform", "targetname");
  array::run_all(a_ai_enemies, &setgoal, vol_goal);
  var_ee755f4d = getEntArray("courtyard_reinforcement_3_5_rear", "targetname");

  foreach(e_spawner in var_ee755f4d) {
    e_spawner.target = "courtyard_aa_platform";
  }

  a_ai_enemies = getaiarray("courtyard_right", "script_string");
  vol_goal = getent("courtyard_rear_full", "targetname");
  array::run_all(a_ai_enemies, &setgoal, vol_goal);
  var_ee755f4d = getEntArray("courtyard_reinforcement_3_5_right", "targetname");

  foreach(e_spawner in var_ee755f4d) {
    e_spawner.target = "courtyard_rear_full";
  }

  spawner::waittill_ai_group_ai_count("courtyard_enemies", 5);
  level thread function_500e1a20("courtyard_rear", "courtyard_wave_3_5_manager_rear", "flg_courtyard_assault_fallback_1_5");
  level thread function_500e1a20("courtyard_right", "courtyard_wave_3_5_manager_right", "flg_courtyard_assault_fallback_1_5");
}

function private function_f8fdc218() {
  can_see = level.player cansee(self);

  if(!can_see) {
    self kill();
  }
}

function private function_7afaab65() {
  level endon(#"flg_courtyard_assault_fallback_2_start");
  level spawn_manager::function_3c035c82(6);
  level spawner::simple_spawn("courtyard_reinforcement_3_window");
  var_92b71fdd = spawner::get_ai_group_ai("courtyard_enemies");
  level spawn_manager::disable("courtyard_wave_3_5_manager_left");
  level spawn_manager::disable("courtyard_wave_3_5_manager_rear");
  level spawn_manager::disable("courtyard_wave_3_5_manager_right");
  a_ai_enemies = getaiarray("courtyard_left", "script_string");
  vol_goal = getent("courtyard_left_rear", "targetname");
  array::run_all(a_ai_enemies, &setgoal, vol_goal);
  var_ee755f4d = getEntArray("courtyard_reinforcement_4_left", "targetname");

  foreach(e_spawner in var_ee755f4d) {
    e_spawner.target = "courtyard_left_rear";
  }

  a_ai_enemies = getaiarray("courtyard_rear", "script_string");
  vol_goal = getent("courtyard_aa_platform", "targetname");
  array::run_all(a_ai_enemies, &setgoal, vol_goal);
  var_ee755f4d = getEntArray("courtyard_reinforcement_4_rear", "targetname");

  foreach(e_spawner in var_ee755f4d) {
    e_spawner.target = "courtyard_aa_platform";
  }

  a_ai_enemies = getaiarray("courtyard_right", "script_string");
  vol_goal = getent("courtyard_rear_full", "targetname");
  array::run_all(a_ai_enemies, &setgoal, vol_goal);
  var_ee755f4d = getEntArray("courtyard_reinforcement_4_right", "targetname");

  foreach(e_spawner in var_ee755f4d) {
    e_spawner.target = "courtyard_rear_full";
  }

  spawner::waittill_ai_group_ai_count("courtyard_enemies", 4);
  level spawn_manager::enable("courtyard_wave_4_manager_rear");
  level spawn_manager::enable("courtyard_wave_4_manager_right");
  wait 3;
  level spawn_manager::disable("courtyard_wave_4_manager_rear");
}

function private function_55a5d157() {
  level endon(#"flg_courtyard_assault_fallback_1_5");
  spawner::simple_spawn_single("courtyard_window_reinforcement_1");
  wait 5;
  spawner::waittill_ai_group_amount_killed("courtyard_window_RPG", 1);
  wait 8;
  level flag::wait_till("flg_courtyard_assault_fallback_0");
  spawner::simple_spawn_single("courtyard_window_reinforcement_2");
}

function private function_c9f96389() {
  level endon(#"flg_courtyard_assault_fallback_1_5");
  spawner::simple_spawn_single("courtyard_roof_reinforcement_1");
  wait 6;
  spawner::waittill_ai_group_amount_killed("courtyard_roof_RPG", 1);
  wait 10;
  level flag::wait_till("flg_courtyard_assault_fallback_1");
  spawner::simple_spawn_single("courtyard_roof_reinforcement_2");
}

function private function_47c5954d() {
  level.player endon(#"death");
  level namespace_534279a::function_bd1a75b("courtyard_enemies", 4, "flg_courtyard_assault_fallback_2");
  level.player val::set("courtyard_encounter", "attackeraccuracy", 0.2);
  a_ai_enemies = getaiarray("courtyard_left", "script_string");
  vol_goal = getent("courtyard_chapel_yard", "targetname");
  array::run_all(a_ai_enemies, &setgoal, vol_goal);
  var_ee755f4d = getEntArray("courtyard_reinforcement_4_left", "targetname");

  foreach(e_spawner in var_ee755f4d) {
    e_spawner.target = "courtyard_chapel_yard";
  }

  a_ai_enemies = getaiarray("courtyard_rear", "script_string");
  vol_goal = getent("courtyard_chapel_yard", "targetname");
  array::run_all(a_ai_enemies, &setgoal, vol_goal);
  var_ee755f4d = getEntArray("courtyard_reinforcement_4_rear", "targetname");

  foreach(e_spawner in var_ee755f4d) {
    e_spawner.target = "courtyard_chapel_yard";
  }

  a_ai_enemies = getaiarray("courtyard_right", "script_string");
  vol_goal = getent("courtyard_chapel_yard", "targetname");
  array::run_all(a_ai_enemies, &setgoal, vol_goal);
  var_ee755f4d = getEntArray("courtyard_reinforcement_4_right", "targetname");

  foreach(e_spawner in var_ee755f4d) {
    e_spawner.target = "courtyard_chapel_yard";
  }

  wait 3;
  level spawn_manager::disable("courtyard_wave_4_manager_right");
}

function private function_1e101b5a() {
  level endon(#"flg_courtyard_assault_fallback_2_start");
  level endon(#"game_ended");
  level.adler endon(#"death");
  var_ecd1d2eb = self.script_accuracy;

  while(true) {
    var_942cba63 = spawner::get_ai_group_ai("courtyard_enemies");

    if(var_942cba63.size > level.var_539b11be) {
      self.script_accuracy = 0.9;
    } else {
      self.script_accuracy = var_ecd1d2eb;
    }

    wait 3;
  }
}

function private function_f66f2135() {
  level spawner::simple_spawn("courtyard_aa_crew_spawner");
  level spawner::waittill_ai_group_amount_killed("courtyard_aa_crew", 3);

  if(!level flag::get("flg_courtyard_assault_fallback_1")) {
    level spawner::simple_spawn("courtyard_aa_crew_spawner");
  }
}

function private function_e3ac7d4e() {
  level flag::wait_till("flg_right_path_drop_down");
  var_f4c28052 = spawner::get_ai_group_ai("courtyard_enemies");
  array::run_all(var_f4c28052, &deletedelay);
  var_f4c28052 = spawner::get_ai_group_ai("courtyard_chapel_group");
  array::run_all(var_f4c28052, &deletedelay);
}

function function_4b8cec86(str_objective) {
  exploder::exploder("lgt_exp_pre_nuke_ext_lights");
  namespace_534279a::spawn_allies();
  var_53aba3f8 = struct::get("courtyard_start_adler");
  level.adler forceteleport(var_53aba3f8.origin, var_53aba3f8.angles);
  var_f8518240 = getspawnerarray("courtyard_ground_spawner", "targetname");
  level spawner::kill_spawnernum(1);
  level.var_77be18d2 = vehicle::simple_spawn_single("player_fav");
  level.var_77be18d2 val::set(#"hash_533b89b2c3072f64", "takedamage", 0);
  level.var_c88d2182 = [];
  level.var_c88d2182[0] = getent("e_radar_1_rotation", "targetname");
  level.var_c88d2182[1] = getent("e_radar_2_rotation", "targetname");
  level.var_c88d2182[2] = getent("e_radar_3_rotation", "targetname");
  level.var_c88d2182[3] = getent("e_radar_4_rotation", "targetname");
  namespace_95f223d5::music("6.0_danger_close");
}

function outro_main(str_objective, var_50cc0d4f) {
  if(var_50cc0d4f) {
    namespace_9940c067::function_a5083d9c();
    level thread namespace_604e2e22::function_f2f9526e();
    a = [];
    a[0] = getent("aa_parapet", "targetname");
    level thread scene::play("scene_sge_0000_ambient_aa_gun_graveyard", "idle", a);
  }

  level thread function_eaba0b8b();
  level.player freezecontrols(1);
  level waittill(#"hash_1d60861800d3ab4");
  level battlechatter::function_2ab9360b(0);
  wait 3.15;
  exploder::exploder("fxexp_bombing_run_drops_fx");
  wait 1;
  exploder::exploder("fxexp_bombing_run_initial_fx");
  level thread function_83226327();
  wait 3;
  exploder::exploder("fxexp_bombing_run_radar_exp_fx");
  level thread function_780fcd9e();
  level thread function_e3a25e6a();
  wait 2.85;
  exploder::kill_exploder("lgt_exp_post_nuke_power_on_03_lightpost");
  exploder::exploder("lgt_exp_post_nuke_power_on_03_fall");
  level thread util::screen_fade_out(2, "black");
  wait 3;
  wait 3;
  level function_7c927add(#"hash_2698531fea395a1c");
  wait 3;
  dialogue::radio("vox_cp_send_01000_hdsn_westoppedhimtho_06");
  wait 1;
  dialogue::radio("vox_cp_send_01000_hdsn_whatsyoursituat_40");
  wait 2;
  dialogue::radio("vox_cp_send_01000_hdsn_comein_a9");
  wait 2;
  dialogue::radio("vox_cp_send_01000_hdsn_woodshaveyoufou_34");
  wait 2;
  level notify(#"hash_1319460fd5c7e554");
  level thread util::screen_fade_in(0.5);
  wait 1.5;
  level.woods dialogue::queue("vox_cp_send_01000_wood_overhere_81");
  wait 2;
  level.woods dialogue::queue("vox_cp_send_01000_wood_givemeahand_da");
  level thread namespace_95f223d5::ending_fade_out();
  level waittill(#"hash_2635928d7a26d003");
  level thread skipto::function_4e3ab877("outro");
}

function outro_cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  if(isDefined(level.adler)) {
    util::stop_magic_bullet_shield(level.adler);
    level.adler delete();
  }

  if(isDefined(level.woods)) {
    util::stop_magic_bullet_shield(level.woods);
    level.woods delete();
  }

  if(isDefined(level.mason)) {
    util::stop_magic_bullet_shield(level.mason);
    level.mason delete();
  }
}

function function_e3a25e6a() {
  wait 1.1;
  level thread function_c1f193cc(4);
  wait 0.5;
  level thread function_c1f193cc(3);
  wait 1;
  level thread function_c1f193cc(1);
  wait 0.1;
  level thread function_c1f193cc(2);
}

function function_c1f193cc(i_id) {
  s_scene = struct::get("radar_" + i_id, "targetname");
  s_scene thread scene::play("play");
  level.var_c88d2182[i_id - 1] hide();
  level.var_1d829da4[i_id - 1] cp_rus_siege::function_557003b4();
}

function function_50680202(var_8f33990e) {
  var_8f33990e endon(#"hash_771d89dbae9683d1");
  level waittill(#"hash_523968c9e8e5864");

  if(!isalive(var_8f33990e)) {
    var_62a1bc5f = getent("aa_courtyard", "targetname");
    a_corpses = getcorpsearray(var_62a1bc5f.origin, 96);
    array::run_all(a_corpses, &function_e7956bb6);
  }
}

function function_e7956bb6() {
  self delete();
}

function function_fba8776c(var_8f33990e) {
  var_8f33990e endon(#"death");
  var_8f33990e waittill(#"hash_771d89dbae9683d1");
  vol_goal = getent("courtyard_chapel_entrance", "targetname");
  var_8f33990e setgoal(vol_goal);
}

function private function_c9d72e76() {
  e_player = getplayers()[0];
  e_player districts::function_930f8c81("catacombs");
}

function function_7c927add(var_ec670c03) {
  if(level.var_3cf0e895[#"hash_23478d403d62c627"] >= 1) {
    return;
  }

  if(isDefined(var_ec670c03)) {
    level lui::play_movie(var_ec670c03, "fullscreen", 1, 0, 0);
  }
}

function function_eaba0b8b() {
  level endon(#"game_ended");
  var_c2908af1 = "damage_light";

  while(true) {
    level waittill(#"plane_flyover");
    level.player playrumbleonentity(var_c2908af1);
  }
}

function function_83226327() {
  level thread rumble_delay(300);
  level thread rumble_delay(900);
  level thread rumble_delay(1200);
  level thread rumble_delay(1500);
  level thread rumble_delay(1800);
  level thread rumble_delay(2200);
  level thread rumble_delay(2600);
  level thread rumble_delay(2000);
  level thread rumble_delay(2400);
  level thread rumble_delay(1400);
  level thread rumble_delay(1600);
  level thread rumble_delay(0);
  level thread rumble_delay(500);
}

function function_780fcd9e() {
  level thread rumble_delay(4800);
  level thread rumble_delay(4100);
  level thread rumble_delay(4300);
  level thread rumble_delay(4400);
  level thread rumble_delay(3400);
  level thread rumble_delay(0);
  level thread rumble_delay(300);
  level thread rumble_delay(500);
  level thread rumble_delay(600);
  level thread rumble_delay(700);
  level thread rumble_delay(1650);
  level thread rumble_delay(1950);
  level thread rumble_delay(3900);
  level thread rumble_delay(4100);
  level thread rumble_delay(4200);
  level thread rumble_delay(5200);
  level thread rumble_delay(1100);
  level thread rumble_delay(800);
  level thread rumble_delay(1300);
  level thread rumble_delay(1000);
  level thread rumble_delay(750);
  level thread rumble_delay(1500);
  level thread rumble_delay(1700);
  level thread rumble_delay(1900);
  level thread rumble_delay(2600);
  level thread rumble_delay(3100);
  level thread rumble_delay(3300);
  level thread rumble_delay(3200);
  level thread rumble_delay(2900);
  level thread rumble_delay(3100);
  level thread rumble_delay(3100);
  level thread rumble_delay(2400);
  level thread rumble_delay(2700);
}

function rumble_delay(n_delay = 0) {
  var_9bd259fa = "damage_light";
  var_2ff88def = "damage_heavy";
  var_ee24a2d3 = "riotshield_impact";
  n_seconds = n_delay / 1000;
  wait n_seconds;

  if(n_delay > 4000) {
    level.player playrumbleonentity(var_ee24a2d3);
    return;
  }

  if(n_delay > 2000) {
    level.player playrumbleonentity(var_2ff88def);
    return;
  }

  level.player playrumbleonentity(var_9bd259fa);
}