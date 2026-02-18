/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_169397edb865e2fe.gsc
***********************************************/

#using script_1b9f100b85b7e21d;
#using script_237e957844a8197c;
#using script_3dc93ca9902a9cda;
#using script_4a1a0f734d8d0e04;
#using script_5991d6501121591f;
#using script_7728aa611ab72ad9;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#namespace namespace_9c5e6b7c;

function start(str_objective) {
  level hms_util::function_ee1d1df6("park", "Park", "park_escape_struct", "escape_allies_initial_color");
  level hms_util::function_ee1d1df6("lazar", "Lazar", "lazar_escape_struct");
  level thread namespace_a789f8ae::function_ad98871a();
  level notify(#"hash_73e317451c95becb");
  var_602672df = getent("vip_door_player_clip", "targetname");
  var_602672df delete();
}

function main(str_objective, var_50cc0d4f) {
  hms_util::print("<dev string:x38>");

  flag::set("flg_escape_spawn_triggers");
  level.var_f4389c9d = spawnStruct();
  level.player thread namespace_307260b8::function_1b57de8d();
  level.player thread namespace_307260b8::function_e8de26b3();
  hms_util::function_eaa0342e("escape_containment_warnings", "escape_containment_fails");
  doors::unlock("escape_door", "targetname", 0);
  namespace_232ddc52::music("12.0_contact");
  level.lazar colors::enable();
  level thread namespace_a789f8ae::function_eff61506();
  level thread function_d85d7174();
  level thread namespace_a789f8ae::function_ba3f106b("escape");
  level thread function_d65bdf8d();
  level thread function_dd101d55();
  level thread function_7be5dedf();
  level thread function_ef7a3626();
  level thread function_85f27f87();
  level thread escape_near_window_enemies();
  level thread escape_heli_flyby();
  level thread function_9aeef376();
  level thread function_341c17f6();
  level thread function_d9227637();

  if(var_50cc0d4f) {
    level.player util::function_749362d7(1);
    level thread namespace_307260b8::function_529afded(0);
    level notify(#"hash_73e317451c95becb");
  }

  savegame::checkpoint_save();
}

function cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  hms_util::print("<dev string:x4b>");

  level notify(#"hash_494ec42a5050d27f");

  if(isDefined(level.var_f4389c9d.var_7bacf73f)) {
    foreach(ai in level.var_f4389c9d.var_7bacf73f) {
      if(isDefined(ai)) {
        ai deletedelay();
      }
    }
  }
}

function function_d85d7174() {
  level flag::wait_till("flg_escape_bullets_start");
  var_63802c77 = getent("far_left_window", "targetname");
  var_79f11353 = getent("far_right_window", "targetname");
  var_1f60345c = [];
  var_1f60345c = getEntArray("hallway_shootat", "targetname");
  var_f6a8c5cd = getent("hallway_shootat_miss_left", "targetname");
  var_dce2d37a = getent("hallway_shootat_miss_right", "targetname");
  var_1a28305f = getEntArray("bullet_vignette_spawner", "targetname");
  level thread function_152a7d64();
  level thread scene::play("p9_fxanim_gp_hallway_glass_break_scene", "play");
  snd::client_msg("audio_escape_hallway_glass");

  while(!flag::get("flg_escape_turn_off_window_bullets")) {
    n_index = randomintrange(0, var_1f60345c.size);

    if(level.var_3134aa2e == 1) {
      foreach(ai in var_1a28305f) {
        if(isDefined(ai)) {
          ai.var_24f6e6a6 = 0.01;
        }
      }
    } else {
      magicbullet(getweapon(#"ar_damage_t9"), var_63802c77.origin, var_1f60345c[n_index].origin);
      wait randomfloatrange(0.05, 0.15);
      magicbullet(getweapon(#"ar_damage_t9"), var_79f11353.origin, var_1f60345c[n_index].origin);
      wait randomfloatrange(0.05, 0.15);
    }

    wait 0.5;
  }
}

function function_152a7d64() {
  level.player endon(#"death");
  level endon(#"flg_window");
  var_a4c5ce0d = getEntArray("escape_mg", "targetname");
  level.var_3134aa2e = 0;

  while(true) {
    foreach(mg in var_a4c5ce0d) {
      mg waittill(#"enter_vehicle");
      level.var_3134aa2e = 1;

      hms_util::print("<dev string:x5c>");

      mg waittill(#"exit_vehicle");
      level.var_3134aa2e = 0;

      hms_util::print("<dev string:x6c>");

      break;
    }

    wait 1;
  }
}

function function_d65bdf8d() {
  var_b6ac0499 = struct::get("s_obj_escape", "targetname");
  objectives::follow("obj_escape", level.lazar, #"hash_4a06cb67ec27e4a4");
  level.park setdesiredspeed("sprint");
  level.lazar setdesiredspeed("sprint");
  level flag::wait_till("flg_escape_on_scaffolding");
  objectives::complete("obj_escape", level.lazar);
  objectives::goto("obj_escape_exterior", var_b6ac0499.origin, #"hash_63af6327b60d28a9");
  level flag::wait_till("flg_end_escape");
  level.park.ignoreall = 0;
  level.lazar.ignoreall = 0;
  objectives::complete("obj_escape_exterior");
}

function function_dd101d55() {
  level.player endon(#"death");
  var_e534dcb = struct::get("ai_alder_radio", "targetname");
  var_7cb820ce = struct::get("ai_mason_radio", "targetname");
  var_662759db = struct::get("ai_woods_radio", "targetname");

  if(isDefined(level.park)) {
    level.park battlechatter::function_2ab9360b(0);
  }

  if(isDefined(level.lazar)) {
    level.lazar battlechatter::function_2ab9360b(0);
  }

  level waittill(#"hash_73e317451c95becb");
  var_7cb820ce hms_util::dialogue("vox_cp_cbcr_01700_masn_contactchopperc_05", 1, "allies", "Lazar");
  var_e534dcb hms_util::dialogue("vox_cp_cbcr_01700_adlr_perseusmustbetr_91", 1, "allies", "Adler");
  level.park hms_util::dialogue("vox_cp_cbcr_01700_park_movemove_90");
  var_662759db thread hms_util::dialogue("vox_cp_cbcr_01700_wood_dontlooknowbutt_ac", 1, "allies", "Woods");

  if(isDefined(level.park)) {
    level.park battlechatter::function_2ab9360b(1);
  }

  if(isDefined(level.lazar)) {
    level.lazar battlechatter::function_2ab9360b(1);
  }

  level flag::set("flg_initial_break_down_door_vo");
  level flag::wait_till("flg_door_kicked");
  savegame::checkpoint_save();
  wait 1;
  level.lazar thread hms_util::dialogue("vox_cp_cbcr_01700_lazr_clear_08");
  level.lazar hms_util::dialogue("vox_cp_cbcr_01700_lazr_outoftheway_20", 0, "allies", "Lazar");
  level flag::wait_till("flg_in_second_room");
  var_662759db hms_util::dialogue("vox_cp_cbcr_01700_wood_adlerigoteyeson_c2", 1, "allies", "Woods");

  if(math::cointoss()) {
    var_e534dcb hms_util::dialogue("vox_cp_cbcr_01700_adlr_lockitdown_7f", 1, "allies", "Woods");
  } else {
    var_e534dcb hms_util::dialogue("vox_cp_cbcr_01700_adlr_takehimout_7c", 1, "allies", "Woods");
  }

  level flag::wait_till("flg_window");
  level thread function_cc575202();
  level.lazar hms_util::dialogue("vox_cp_cbcr_01700_lazr_thewindowoutthe_8c");
  level flag::wait_till("flg_spawn_parking_lot_trucks");
  var_662759db hms_util::dialogue("vox_cp_cbcr_01700_wood_fuckmewemissedh_00", 1, "allies", "Woods");
  savegame::checkpoint_save();

  if(math::cointoss()) {
    var_7cb820ce hms_util::dialogue("vox_cp_cbcr_01800_masn_fuckperseusweve_0f", 1, "allies", "Mason");
  } else {
    var_7cb820ce hms_util::dialogue("vox_cp_cbcr_01800_masn_wegotbiggerprob_5b", 1, "allies", "Mason");
  }

  level.park hms_util::dialogue("vox_cp_cbcr_01800_park_adlerwereonther_4b", undefined);
  hms_util::dialogue("vox_cp_cbcr_01800_adlr_wereonadifferen_ba", 1, "allies", "Adler");
}

function function_d9227637() {
  level endon(#"flg_door_kicked");
  var_cad35a6 = doors::get_doors("escape_breach_door");
  s_door = var_cad35a6[0];

  while(!s_door doors::is_open()) {
    waitframe(1);
  }

  level scene::stop("scene_rev_5010_esc_trapped_breach");
  level flag::set("flg_escape_door_open");
  level flag::set("flg_door_kicked");
}

function function_cc575202() {
  level endon(#"flg_escape_on_scaffolding");
  level.player endon(#"death");
  wait 5;
  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.lazar, "vox_cp_cbcr_01700_lazr_bellthewindowgo_dc");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.lazar, "vox_cp_cbcr_01700_lazr_headoutthewindo_24");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.lazar, "vox_cp_cbcr_01700_lazr_movebell_83");
  var_ffbbfc35[3] = hms_util::function_e1449992(level.lazar, "vox_cp_cbcr_01700_lazr_gobell_a2");
  var_ffbbfc35[4] = hms_util::function_e1449992(level.lazar, "vox_cp_cbcr_01700_lazr_bellletsgo_95");
  var_ffbbfc35[5] = hms_util::function_e1449992(level.lazar, "vox_cp_cbcr_01700_lazr_bellgoaheadillc_71");
  var_ffbbfc35[6] = hms_util::function_e1449992(level.lazar, "vox_cp_cbcr_01700_lazr_gobellillbringu_61");

  while(true) {
    hms_util::vo_knockout_manager("cuban_window_nags", var_ffbbfc35);
    wait 5;
  }
}

function function_32c773b8() {
  level endon(#"enemy_surprise");
  level.player endon(#"death");
  var_e4fde6af = struct::get("lazar_node", "targetname");
  level.park setdesiredspeed("sprint");
  level.lazar setdesiredspeed("sprint");
  level.park ai::set_goal("park_node", "targetname");
  level.lazar ai::set_goal("lazar_node3", "targetname");
  level flag::wait_till("flg_park_move_up");
  level.park ai::set_goal("park_node_advance", "targetname");
  level.park colors::disable();
}

function function_7be5dedf() {
  level.player endon(#"death");
  doors::open("escape_door");
  wait 1;
  doors::close("escape_door");
  doors::function_f35467ac("escape_door");
  level.park colors::disable();
  level.lazar colors::disable();
  level.park ai::set_behavior_attribute("disablepeek", 1);
  level.park ai::set_behavior_attribute("disablelean", 1);
  level.lazar ai::set_behavior_attribute("disablepeek", 1);
  level.lazar ai::set_behavior_attribute("disablelean", 1);
  var_9c754d56 = struct::get("park_node_wait", "targetname");
  var_4fba7349 = struct::get("park_node2", "targetname");
  var_650166b4 = struct::get("lazar_node2", "targetname");
  level.park.var_24f6e6a6 = 10000;
  level.lazar.var_24f6e6a6 = 10000;
  level thread function_32c773b8();
  namespace_307260b8::function_2b6287f4("escape_enemy_surprise");
  level.var_c0ed777f = spawner::simple_spawn_single("escape_surprise_enemy");
  level.lazar thread ai::shoot_at_target("kill_within_time", level.var_c0ed777f, undefined, 0.75);
  level.var_c0ed777f waittill(#"death");
  level thread namespace_a789f8ae::function_a1651470();
  level.park.ignoreall = 1;

  hms_util::print("<dev string:x7d>");

  level.park setdesiredspeed("sprint");
  level.park ai::set_goal("park_node_wait", "targetname");
  level waittill(#"hash_3a3bcf6f3a7cf64e");
  level.park ai::set_goal("park_node2", "targetname");
  wait 2;
  level flag::wait_till("flg_park_advance_to_door");
  level.park ai::set_goal("park_go_to_scientist_room", "targetname");
  level flag::wait_till("flg_past_hallway");
  level.park colors::enable();
  level.lazar.ignoreall = 0;
  level.park.ignoreall = 0;
  level.park.var_24f6e6a6 = 100;
  level.lazar.var_24f6e6a6 = 100;
}

function private function_ef7a3626() {
  self endon(#"game_ended", #"hash_494ec42a5050d27f");
  level flag::wait_till("flg_allies_advance_to_ambush");
  wait 1;
  a_ai = [];
  var_841e373 = getEntArray("bullet_vignette_spawner", "targetname");

  foreach(sp in var_841e373) {
    ai = spawner::simple_spawn_single(sp);

    if(isDefined(ai)) {
      array::add(a_ai, ai);
      e_target = getent(ai.script_noteworthy, "targetname");
      ai thread ai::shoot_at_target("shoot_until_target_dead", e_target, undefined, undefined, 1);
      ai.ignoreme = 1;
    }
  }

  foreach(ai in a_ai) {
    if(isalive(ai)) {
      wait randomfloatrange(0.5, 1.5);
      ai ai::stop_shoot_at_target();
      ai.ignoreme = 0;
      ai getenemyinfo(level.player);
    }
  }

  level thread function_318c053c("bullet_vignette_spawner", "escape_enemy_front_shooters", "escape_plaza_shooters_fallback", 7);
  var_4b22e6b8 = getaiarray("bullet_vignette_spawner", "targetname");
  level flag::wait_till("flg_escape_door_open");
  level thread scene::stop("p9_fxanim_gp_hallway_glass_break_scene");
  wait 5;

  hms_util::print("<dev string:x94>");

  foreach(ai in var_4b22e6b8) {
    if(isalive(ai)) {
      ai thread namespace_307260b8::function_10223871("escape_plaza_shooters_fallback", 1);
    }
  }

  var_8bb8735 = getent("escape_bullet_vignette_end_trigger", "targetname");

  if(isDefined(var_8bb8735)) {
    waitresult = var_8bb8735 waittill(#"trigger");

    foreach(ai in a_ai) {
      if(isalive(ai)) {
        ai deletedelay();
      }
    }
  }
}

function function_318c053c(ai_targetname, ai_group, vol_fallback, var_368e1d98) {
  level endon(#"death");
  var_423ae9b8 = getaiarray(ai_targetname, "targetname");
  spawner::waittill_ai_group_ai_count(ai_group, var_368e1d98);
  level flag::set("flg_escape_turn_off_window_bullets");

  foreach(ai in var_423ae9b8) {
    wait randomfloatrange(0.25, 2.25);

    if(isalive(ai)) {
      ai thread namespace_307260b8::function_10223871(vol_fallback, 1);
    }
  }
}

function function_7e2956d3() {
  level endon(#"hash_59f6b36f3f2b5c68");
  var_15ec0cc3 = getEntArray("escape_front_right_civ_spawner", "targetname");
  var_40c2f749 = getent("flg_play_scientist_vo", "targetname");
  thread function_c78f8bf0();

  while(true) {
    if(level.player istouching(var_40c2f749) && isDefined(var_15ec0cc3)) {
      level notify(#"hash_7e8c41dd3a282949");
      var_15ec0cc3[0] thread hms_util::dialogue("vox_cp_cbcr_02400_sci_whimpering_48", undefined, "neutral");
      wait randomfloatrange(1, 2.5);
      var_15ec0cc3[1] thread hms_util::dialogue("vox_cp_cbcr_02400_ms2_heavybreathing_ff", undefined, "neutral");
      wait randomfloatrange(0.75, 2);
    }

    wait 1;
  }
}

function function_c78f8bf0() {
  level waittill(#"hash_7e8c41dd3a282949");
  var_15ec0cc3 = getEntArray("escape_front_right_civ_spawner", "targetname");

  if(isDefined(var_15ec0cc3[2])) {
    var_15ec0cc3[2] thread hms_util::dialogue("vox_cp_cbcr_02400_sci_startledscream_0c", undefined, "neutral");
  }
}

function function_85f27f87() {
  level endon(#"flg_end_escape");
  a_spawners = getEntArray("escape_front_right_civ_spawner", "targetname");
  t_spawn = getent("escape_front_right_civ_trigger", "targetname");
  var_4fb059b8 = getent("trig_park_orange_color", "targetname");
  var_4fb059b8 triggerenable(0);
  t_spawn waittill(#"trigger");
  level flag::wait_till("flg_escape_spawn_triggers");
  var_6e6dffeb = spawner::simple_spawn(a_spawners);
  level thread function_7e2956d3();

  foreach(guy in var_6e6dffeb) {
    if(guy.archetype == # "civilian") {
      guy ai::set_behavior_attribute(#"_civ_mode", "panic");
      guy.health = 1;
    }
  }

  level flag::wait_till("flg_escape_player_in_glass_hallway");
  level flag::wait_till("flg_initial_break_down_door_vo");
  level flag::set("flg_ready_to_break_down_door_vo");
  var_4a3daa0b = struct::get("escape_door_bash_look_at", "targetname");

  while(true) {
    within_fov = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), var_4a3daa0b.origin, cos(45));

    if(within_fov == 1) {
      break;
    }

    waitframe(1);
  }

  hms_util::print("<dev string:xaa>");

  level flag::set("flg_escape_door_open");
  var_4fb059b8 triggerenable(1);
  level thread function_4545fa49();
  level trigger::use("escape_allies_color_door_break_trig");
  level trigger::use("trig_park_orange_color");

  hms_util::print("<dev string:xc8>");

  level.park colors::enable();
  level.park colors::set_force_color("o");
  level flag::wait_till("trig_park_catchup");
  level.park colors::set_force_color("b");

  hms_util::print("<dev string:xc8>");

  level flag::wait_till("flg_cleanup_floor_two_ai");

  if(isDefined(var_6e6dffeb)) {
    foreach(guy in var_6e6dffeb) {
      if(isalive(guy)) {
        guy deletedelay();
      }
    }
  }
}

function function_4545fa49() {
  var_6c5df5a3 = getnode("e_escape_lazar_1", "targetname");
  level.lazar hms_util::function_2f50100e("stay_ahead", var_6c5df5a3.origin);
  level.park hms_util::function_2f50100e("stay_behind", var_6c5df5a3.origin);
  var_3a1c1120 = getnode("e_escape_lazar_2", "targetname");
  level flag::wait_till("flg_escape_advance_1");
  level.lazar hms_util::function_2f50100e("stay_ahead", var_3a1c1120.origin);
  level.park hms_util::function_2f50100e("stay_behind", var_3a1c1120.origin);
  var_1700cae2 = getnode("e_escape_lazar_3", "targetname");
  level flag::wait_till("flg_escape_advance_2");
  level.lazar hms_util::function_2f50100e("stay_ahead", var_1700cae2.origin);
  level.park hms_util::function_2f50100e("stay_behind", var_1700cae2.origin);
  var_24c5e66c = getnode("e_escape_lazar_4", "targetname");
  level flag::wait_till("flg_escape_advance_3");
  level.lazar hms_util::function_2f50100e("stay_ahead", var_24c5e66c.origin);
  level.park hms_util::function_2f50100e("stay_behind", var_24c5e66c.origin);
}

function escape_near_window_enemies() {
  level endon(#"game_ended");
  t_spawn = getent("escape_gate_enemies_spawn", "targetname");
  t_spawn waittill(#"trigger");
  level thread function_2b02b5c0();
  var_fcc1cf15 = spawner::simple_spawn("escape_near_gate_enemies");
  var_8a6c56b1 = spawner::simple_spawn("escape_near_window_enemies");
  level thread namespace_a789f8ae::function_dbd5c057();

  if(var_8a6c56b1.size > 0) {
    ai::waittill_dead_or_dying(var_8a6c56b1);
  }

  hms_util::print("<dev string:xdd>");

  level flag::set("flg_window");

  if(isDefined(level.park)) {
    level.park thread ai::set_goal("s_park_window", "targetname");
  }

  level.lazar thread ai::set_goal("s_lazar_window", "targetname");
  level flag::wait_till("flg_parking_lot_spawners");

  foreach(ai_enemy in var_fcc1cf15) {
    if(isalive(ai_enemy)) {
      ai_enemy deletedelay();
    }
  }

  level flag::wait_till("flg_delay_lazar");
  level.park colors::disable();
  level.lazar colors::disable();
  var_ec6e474c = getnode("rooftop_initial_park_node", "targetname");
  level.park setgoal(var_ec6e474c);
  wait 3;
  var_426436aa = getnode("rooftop_initial_lazar_node", "targetname");
  level.lazar setgoal(var_426436aa);
}

function function_2b02b5c0() {
  mdl_door = doors::function_73f09315("escape_gate_door");
  mdl_door waittill(#"door_opening");
  snd::client_targetname(mdl_door, "audio_escape_double_door_open");
}

function function_5c353098() {
  self endon(#"game_ended");
  level endon(#"flg_end_escape");
  t_spawn = getent("escape_stairway_vehicles_spawn", "targetname");
  t_spawn waittill(#"trigger");
  var_4a3daa0b = struct::get("escape_car_driveby_seen", "targetname");

  while(true) {
    within_fov = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), var_4a3daa0b.origin, cos(35));
    var_19433220 = sighttracepassed(level.player getplayercamerapos(), var_4a3daa0b.origin, 0, undefined);

    if(within_fov == 1 && var_19433220 == 1) {
      break;
    }

    waitframe(1);
  }

  var_911943a3 = spawner::simple_spawn_single("escape_stairway_vehicle_1");

  if(isDefined(var_911943a3)) {
    var_911943a3 thread vehicle::go_path();
  }

  var_da485608 = spawner::simple_spawn_single("escape_stairway_vehicle_2");

  if(isDefined(var_da485608)) {
    var_da485608 thread vehicle::go_path();
  }
}

function escape_heli_flyby() {
  flag::wait_till("flg_escape_heli_flyby");

  hms_util::print("<dev string:xf6>");

  var_d68cf643 = vehicle::simple_spawn_single("rooftop_chopper_fly_away");
  var_1cb288cc = getaiarray("chopper_pilot", "targetname");
  var_d68cf643 hms_util::function_150e9e66();
  snd::client_targetname(var_d68cf643, "audio_escape_heli_flyby_scene");
  flag::wait_till("flg_chopper_start_path");

  hms_util::print("<dev string:x109>");

  var_d68cf643 thread vehicle::go_path();
  playFXOnTag("/maps/cp_nic_revolucion/fx9_wind_heli_downforce", var_d68cf643, "tag_origin");
  snd::client_msg("audio_escape_heli_flyby_started");
  var_4a3daa0b = struct::get("escape_heli_flyby", "targetname");

  while(true) {
    within_fov = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), var_4a3daa0b.origin, cos(35));
    var_19433220 = sighttracepassed(level.player getplayercamerapos(), var_4a3daa0b.origin, 0, undefined);

    if(within_fov == 1 && var_19433220 == 1) {
      break;
    }

    waitframe(1);
  }

  wait 0.5;
  earthquake(0.2, 3, level.player.origin, 200);
}

function private function_9aeef376() {
  self endon(#"game_ended", #"hash_35647238c6ddb5ee");
  level flag::wait_till("flg_spawn_parking_lot_trucks");
  level thread function_f6c194ca();
  var_3e7640be = spawner::simple_spawn("escape_scaffolding_drive_vehicle_spawner_early");

  foreach(vh_vehicle in var_3e7640be) {
    if(isDefined(vh_vehicle)) {
      vh_vehicle thread vehicle::go_path();
      snd::client_targetname(vh_vehicle, "audio_scaffolding_truck_early");
    }
  }

  var_3313c8c0 = spawner::simple_spawn("escape_scaffolding_drive_vehicle_spawner");

  foreach(vh_vehicle in var_3313c8c0) {
    if(isDefined(vh_vehicle)) {
      vh_vehicle thread vehicle::go_path();
    }
  }

  var_f7ee0c0 = getEntArray("escape_enemy_vehicle_ride_in", "targetname");

  foreach(ai in var_f7ee0c0) {
    ai thread function_50aada8c();
  }

  wait 3;
  var_43d75163 = 0;

  while(true) {
    var_4867bef7 = spawner::get_ai_group_ai("ai_escape_riders");
    var_6d780ea5 = getent("escape_enemy_retreat", "targetname");

    if(spawner::get_ai_group_count("ai_escape_riders") < 28 || var_43d75163 >= 30) {
      foreach(guy in var_4867bef7) {
        wait randomfloatrange(0.1, 0.5);

        if(isDefined(guy) && isalive(guy)) {
          guy thread namespace_307260b8::function_10223871("escape_enemy_retreat", 1);
        }
      }
    }

    var_43d75163++;
    wait 1;
  }
}

function function_50aada8c() {
  self endon(#"death");
  self waittill(#"exited_vehicle");
  e_goal = getent("vol_truck_drive_in", "targetname");
  self setgoal(e_goal);
}

function function_f6c194ca() {
  level.player endon(#"death");
  var_ea63d94d = spawner::simple_spawn("rpg_magic_guys");
  level flag::set("flg_parking_lot_spawners");

  hms_util::print("<dev string:x11b>");

  var_4e1e4d18 = spawner::simple_spawn("parking_lot_ground_enemies");

  foreach(ai in var_4e1e4d18) {
    e_goal = getent("vol_truck_drive_in", "targetname");
    ai setgoal(e_goal);
  }

  var_6bf57952 = spawner::get_ai_group_ai("rpg_shooters_parking_lot");
  var_4bad8e55 = array(struct::get("rpg_shootat_1"), struct::get("rpg_shootat_2"), struct::get("rpg_shootat_3"), struct::get("rpg_shootat_4"), struct::get("rpg_shootat_5"));
  level flag::wait_till("magic_rpg_shoot");

  foreach(ai in var_ea63d94d) {
    if(isalive(ai) && isDefined(ai)) {
      ai ai::set_behavior_attribute("sprint", 1);
      ai.script_accuracy = 0.05;
      wait randomfloatrange(1.5, 3.5);

      if(isalive(ai) && isDefined(ai)) {
        hms_util::print("<dev string:x130>");

        var_86303f63 = magicbullet(ai.weapon, ai gettagorigin("tag_flash"), var_4bad8e55[randomintrange(0, 4)].origin, ai);
        ai thread namespace_307260b8::function_10223871("escape_enemy_retreat", 1);
        var_86303f63 waittill(#"death");
        level.player playrumbleonentity("artillery_rumble_near");
      }
    }
  }
}

function function_341c17f6() {
  namespace_307260b8::function_2b6287f4("parking_lot_drone_rush");
  var_98756d17 = getEntArray("escape_scaffolding_drive_drone_spawner", "targetname");

  for(i = 0; i < 4; i++) {
    array::run_all(var_98756d17, &spawner::spawn, 1);
    wait randomfloatrange(1, 2);
  }

  wait 3;
  var_98756d17 = getEntArray("escape_scaffolding_drive_drone_spawner", "targetname");

  foreach(guy in var_98756d17) {
    if(isDefined(guy)) {
      guy deletedelay();
    }
  }
}