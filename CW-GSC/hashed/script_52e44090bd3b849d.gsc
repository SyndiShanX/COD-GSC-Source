/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_52e44090bd3b849d.gsc
***********************************************/

#using script_122afd04d0de2423;
#using script_2d443451ce681a;
#using script_30cfffd6b7b2b212;
#using script_3dc93ca9902a9cda;
#using script_67332a4d085a140a;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\spawn_manager;
#using scripts\cp_common\util;
#namespace namespace_fe8e156a;

function starting(var_d3440450) {
  namespace_42da7c51::function_ed760ecb("woods");
  level.var_9a3944f4 = ai::array_spawn("exfil_heli")[0];
  level.var_9a3944f4 thread namespace_42da7c51::function_fbb0d73f();
  level thread namespace_42da7c51::heli_light(level.var_9a3944f4, "ally_heli_spot_light_bustout", "tag_fx_running_light_front_side_left_01", (-20, 12, 0), level.var_9a3944f4, 0, 1);
  level.var_9a3944f4 thread namespace_42da7c51::function_3cebcd1b();
  level.var_9a3944f4 util::delay_notify(0.2, "lights_on");
  callback::on_player_damage(&function_aa3c5fab);
  level.var_7c11765c = 0;
  level.last_player_attacker = level;
  level flag::set(#"hash_5601fb6019314f30");
  level flag::set("aldrich_kill_confirmed");
  player = getplayers()[0];
  player thread namespace_f464d565::function_8896f07c();
  snd::client_msg("stop_camera_zoom");
}

function main(var_d3440450, var_50cc0d4f) {
  level thread function_3a20dd4c();
  level flag::wait_till_all_timeout(20, array("balcony_complete"));

  if(isDefined(level.var_9a3944f4)) {
    thread heli_logic();
  }

  level thread function_978c193();
  level flag::wait_till("parking_lot_combat_complete");
  level thread savegame::checkpoint_save();
  level thread function_1fcf893b();
  level thread trailer_park_combat();
  level flag::wait_till("trailer_park_combat_complete");
  level thread function_848ad996();
  level flag::wait_till("gas_station_escape_complete");

  if(isDefined(var_50cc0d4f)) {
    skipto::function_4e3ab877(var_50cc0d4f);
  }

  safehouse = skipto::function_6914f647();
  skipto = skipto::function_547ca7d2(safehouse);
  skipto::function_1c2dfc20(safehouse, skipto);
}

function cleanup(name, starting, direct, player) {}

function function_172759f0(var_b4a49886, str_tag) {
  e_origin = function_787dbb94(var_b4a49886 gettagorigin(str_tag), var_b4a49886 gettagangles(str_tag), undefined, "tag_origin");
  e_origin util::create_cursor_hint("tag_origin", (0, 0, 48), #"hash_9f628cb81b821f7");
  e_origin util::waittill_any_ents(e_origin, "trigger", level, "evac_helicopter_board_trigger");
  level notify(#"evac_helicopter_board_trigger");
}

function function_787dbb94(v_location, v_angles, v_offset = (0, 0, 0), str_model) {
  e_origin = spawn("script_model", v_location + v_offset);
  e_origin.origin = v_location + v_offset;
  e_origin.angles = v_angles;
  e_origin setModel(str_model);
  return e_origin;
}

function function_3a20dd4c(var_50cc0d4f) {
  level thread exfil_heli();
  level.woods thread ai::force_goal(getnode("woods_exfil_cover", "targetname"));
  level flag::wait_till("heli_explosion_done");
  level thread savegame::checkpoint_save();
  level battlechatter::function_2ab9360b(1);
  var_defad5b2 = ai::array_spawn("parking_lot_baddies");
  trucks = vehicle::simple_spawn_and_drive("parking_lot_truck");

  foreach(truck in trucks) {
    truck namespace_42da7c51::function_3958f4d7("lights_heli_exfil_truck_" + truck.var_5eafe61e);
  }

  waitframe(3);
  var_75603ac7 = getaiarray("first_truck", "script_aigroup");
  var_29ec847f = getaiarray("second_truck", "script_aigroup");
  parking_lot_baddies = arraycombine(var_75603ac7, var_29ec847f);
  level thread function_b06286d2(var_29ec847f, "second_truck_arrived", "vol_outer_parking_lot", "targetname", 1);
  level flag::wait_till("parking_lot_arrived");

  foreach(agent in var_75603ac7) {
    if(math::cointoss()) {
      agent ai::set_goal("vol_inner_parking_lot_right", "targetname", 1);
      continue;
    }

    agent ai::set_goal("vol_inner_parking_lot_left", "targetname", 1);
  }

  parking_lot_baddies = arraycombine(parking_lot_baddies, var_defad5b2);
  level thread function_3c2366a7(parking_lot_baddies, 4, "woods_objective_up");
  level flag::wait_till("woods_objective_up");
  function_9c431ddc(parking_lot_baddies, 3, "parking_lot_combat_complete");
}

function exfil_heli() {
  level flag::wait_till("truck_spawn");
  spawner::add_spawn_function_ai_group("evac_heli_pilot", &function_3c4750e);
  level.var_3b81c485 = ai::array_spawn("vehicle_evac_heli")[0];
  level.var_3b81c485 thread namespace_42da7c51::function_fbb0d73f();
  level.var_3b81c485.drivepath = 0;
  level.var_3b81c485 thread vehicle::get_on_and_go_path("exfil_heli_2_path");
}

function function_3c4750e() {
  self val::set(#"pilot", "ignoreme", 1);
}

function function_b06286d2(array, flag, goal, key = "targetname", b_force = 0) {
  level flag::wait_till(flag);

  foreach(agent in array) {
    agent ai::set_goal(goal, key, b_force);
  }
}

function function_3c2366a7(array, num, flag) {
  if(array.size <= 0) {
    return;
  }

  level ai::waittill_dead_or_dying(array, array.size - num);
  level objectives::follow("woods_exfil", level.woods, undefined, 0, 0);
  level objectives::function_67f87f80("woods_exfil", level.woods, #"hash_7591cd9ae96ac00c");
  level flag::set(flag);
}

function function_9c431ddc(array, var_6ab9c420, flag, rush = 1) {
  if(array.size <= 0) {
    return;
  }

  level ai::waittill_dead_or_dying(array, array.size - var_6ab9c420);

  if(rush) {
    foreach(agent in array) {
      if(isDefined(agent) && isalive(agent) && isDefined(getplayers()[0])) {
        agent.goalradius = 256;
        agent ai::set_goal_ent(getplayers()[0]);
      }
    }
  }

  if(rush) {
    level ai::waittill_dead_or_dying(array);
  }

  level flag::set(flag);
}

function function_3dc8cbc9(seconds) {
  wait seconds;
  level.player takeweapon(level.var_e3f5eafc);
  level.player enableweaponcycling();
}

function function_d192fdd4() {
  ai = spawner::simple_spawn_single("aldrich_spawner");
  ai setteam(#"axis");
  ai.health = 1;
  ai.var_c681e4c1 = 1;
  ai.skipdeath = 1;
  level thread scene::play("aib_engineer_injured_guy_wounded", [ai]);
  ai setCanDamage(1);
  ai ai::bloody_death();
}

function function_1fcf893b() {
  level flag::wait_till("truck_spawn");
  truck_convoy = vehicle::simple_spawn_and_drive("runaway_trucks");
  truck_convoy = vehicle::simple_spawn_and_drive("truck_convoy");

  foreach(truck in truck_convoy) {
    truck namespace_42da7c51::function_3958f4d7("lights_heli_exfil_truck_" + truck.var_5eafe61e);
  }

  truck_riders = getaiarray("truck_riders_start", "script_aigroup");
  level thread cleanup_ai("trailer_park_combat", truck_riders);
  level thread function_ead2bec4("player_runaway", truck_riders);

  if(isDefined(level.woods)) {}

  level flag::wait_till("flag_start_trailer_park_exfil");
  wait 4;
}

function cleanup_ai(flag, array) {
  if(isDefined(flag)) {
    level flag::wait_till(flag);
  }

  foreach(guy in array) {
    if(isDefined(guy) && isalive(guy)) {
      guy ai::bloody_death();
    }
  }
}

function function_f0f342d5(vehicle_array) {
  var_bb75350d = [];

  foreach(vehicle in vehicle_array) {
    riders = vehicle vehicle::function_86c7bebb();

    foreach(rider in riders) {
      var_bb75350d[var_bb75350d.size] = rider;
    }
  }

  return var_bb75350d;
}

function function_ead2bec4(flag, array) {
  level flag::wait_till(flag);

  foreach(agent in array) {
    if(isDefined(agent)) {
      agent.var_9d17efa5 = 1;
      agent.perfectaim = 1;
    }
  }

  level flag::wait_till_clear(flag);

  foreach(agent in array) {
    if(isDefined(agent)) {
      agent.perfectaim = 0;
    }
  }
}

function function_3907835f(flag, name) {
  vehicle::simple_spawn_and_drive(name);
}

function trailer_park_combat() {
  level flag::wait_till("flag_start_trailer_park_exfil");
  trailer_park_guys = ai::array_spawn("trailer_park_guys");
  level flag::wait_till("run_to_gas_station");
  level flag::set("heli_going_to_gas_station");
  level objectives::remove("woods_exfil", level.woods);
  level objectives::function_4eb5c04a("exfil", struct::get("exfil_location", "targetname").origin);
  objectives::function_67f87f80("exfil", undefined, #"hash_7cbf5630c9cd76d7");
  level thread function_9c431ddc(trailer_park_guys, 3, "trailer_park_combat", 0);
  level flag::wait_till("trailer_park_combat");
  gas_station_guys = ai::array_spawn("gas_station_guys");
  level thread function_9c431ddc(gas_station_guys, 0, "gas_station_clear", 0);
  level flag::wait_till("gas_station_clear");

  if(isDefined(level.woods)) {
    level.woods.ignoresuppression = 1;
    level.woods.grenadeawareness = 0;
    level.woods.script_accuracy = 100;
    level.woods val::set(#"exfil", "ignoreall", 1);
    level.woods val::set(#"exfil", "ignoreme", 1);
    level.woods.fixednode = 1;
    level.woods.goalradius = 32;
    level.woods colors::disable();
    level.woods pushplayer(1);
    level.woods ai::force_goal(getnode("woods_wait_jump", "targetname"), 1);
    level.woods ai::look_at(level.player);
    level.woods val::reset(#"exfil", "ignoreall");
    level notify(#"hash_68bdbae19e27e719");
  }

  level flag::wait_till("player_on_gas_station");
  node = getnode("woods_wait_heli", "targetname");

  if(isDefined(level.woods) && isDefined(node)) {
    level.woods val::set(#"exfil", "ignoreall", 1);
    level.woods ai::force_goal(node, 1);
  }
}

function function_848ad996() {
  level thread function_172759f0(level.var_3b81c485, "tag_enter_passenger1");
  level waittill(#"evac_helicopter_board_trigger");
  snd::client_msg(#"hash_5c7e1a43ba45c2b4");
  level objectives::remove("exfil", struct::get("exfil_location", "targetname").var_ac724d0f);
  function_7f59e31f(level.var_3b81c485, "left");
  level.woods dialogue::queue("vox_cp_chao_03200_wood_howaboutwegetth_c6");
  wait 1;
  snd::client_msg(#"hash_305dcf2b80864ec");
  level.woods dialogue::queue("vox_cp_chao_03200_wood_goodworkbrother_e9");
  level flag::set("gas_station_escape_complete");
}

function function_7f59e31f(var_b4a49886, side) {
  player = getplayers()[0];
  player disableweapons();
  level thread dialogue::radio("vox_cp_chao_03200_chp1_hoponinmason_86");
  var_b4a49886 scene::play("scene_sm_tundra_heli_load", side + "_enter");
  var_b4a49886 thread scene::play("scene_sm_tundra_heli_load", side + "_idle");
  vehicle::get_in(level.woods, var_b4a49886, "passenger1");
  level flag::set("exfil_player_loaded");
}

function heli_logic() {
  if(!isDefined(level.var_9a3944f4)) {
    return;
  }

  level.var_9a3944f4 endon(#"death");
  callback::remove_on_player_damage(&namespace_42da7c51::function_aa3c5fab);
  level flag::wait_till("woods_move_out");
  level.woods colors::enable();
  level thread dialogue::radio("vox_cp_chao_03200_chp1_takingheavyfire_b5");
  level thread namespace_61150688::function_e6aee48f();
  level.var_9a3944f4.drivepath = 1;
  level.var_9a3944f4 thread vehicle::get_on_and_go_path("nd_exfil_heli_dies");
  var_3a924007 = 2.25;
  wait var_3a924007;
  var_377893ba = struct::get("org_heli_missile_launch", "targetname");
  level flag::delay_set(3, "heli_explosion_done");
  v_vel = vectornormalize(level.var_9a3944f4.origin - var_377893ba.origin) * 100;
  m = level.woods magicmissile(getweapon(#"launcher_standard_t9"), var_377893ba.origin, v_vel, level.var_9a3944f4);
  org = util::spawn_model("tag_origin", m.origin, m.angles);
  org linkto(m);
  org clientfield::set("heli_rpg_trail", 1);
  level thread namespace_61150688::function_d27e1651();
  m waittill(#"projectile_impact_explode", #"death");
  level flag::set("flag_rpg_struck_heli");
  screenshake((-35250.6, 19974.8, 857.25), 2.5, 2.1, 1.6, 1.6, 0.5, -1, 1280, 6.9, 2.5, 2.3, 1.15);
  level.player playrumbleonentity("grenade_rumble");
  level thread dialogue::function_9e580f95();
  org clientfield::set("heli_rpg_trail", 0);
  level.var_9a3944f4 clientfield::set("exfil_heli_exp", 1);
  level.var_9a3944f4 vehicle::god_off();
  level.var_9a3944f4 setvehmaxspeed(50);
  level.var_9a3944f4.crash_accel = 60;
  level.var_9a3944f4 thread vehicle_death::helicopter_crash();
  level.var_9a3944f4 vehicle::lights_off();
  level.var_9a3944f4 notify(#"hash_48aad0ddc0d9bf5d");
  level.var_9a3944f4.light delete();
  level.var_9a3944f4 thread vehicle::set_damage_fx_level(3);
  level.var_9a3944f4 util::delay(4, undefined, &function_b4a7ac74);

  if(isDefined(org)) {
    org deletedelay();
  }
}

function function_b4a7ac74() {
  exploder::exploder("exfil_heli_crash_exp");
  screenshake((-38435.9, 19693.6, 620.624), 7, 11, 4.8, 2.5, 0.5, 2, 4399, 3, 1.1, 0.5, 1.2);
  ai = getEntArray("heli_crew_second_heli", "targetname", 1);

  if(isDefined(ai) && ai.size) {
    foreach(guy in ai) {
      guy val::reset_all(#"hash_6c5af7e35803f61d");
      guy delete();
    }
  }

  level.var_9a3944f4 delete();
  callback::remove_on_player_damage(&function_aa3c5fab);
}

function function_aa3c5fab(params) {
  if(!isDefined(level.var_9a3944f4)) {
    return;
  }

  level.var_9a3944f4.forward_scalar = 1;
  attacker = params.eattacker;

  if(isDefined(attacker) && isai(attacker)) {
    if(attacker.targetname === "truck_riders") {
      return;
    }

    if(attacker == level.last_player_attacker) {
      level.var_9a3944f4 thread namespace_42da7c51::function_cbe25a41(attacker, "tag_searchlight_fx", 1);
      level.var_7c11765c = gettime();
      return;
    }

    if(level.var_7c11765c < gettime() - 3000 || !isalive(level.last_player_attacker)) {
      level.var_7c11765c = gettime();
      level.last_player_attacker = attacker;
      level.var_9a3944f4 thread namespace_42da7c51::function_cbe25a41(attacker, "tag_searchlight_fx", 1);
    }
  }
}

function function_978c193() {
  level flag::wait_till("flag_rpg_struck_heli");
  var_53c437ae = 2;
  wait var_53c437ae;
  level.woods dialogue::queue("vox_cp_chao_03200_wood_goddammitthatwa_2e");
  level.woods dialogue::queue("vox_cp_chao_03200_wood_24wereintrouble_e4");
  level dialogue::radio("vox_cp_chao_03200_chp2_rogerthatcircli_28");
  level flag::wait_till("heli_explosion_done");
  level.woods dialogue::queue("vox_cp_chao_03200_wood_masontheyvegotf_70");
  level flag::wait_till("truck_spawn");
  level dialogue::radio("vox_cp_chao_03200_chp1_truckspullingin_89");
  level dialogue::radio("vox_cp_chao_03200_chp1_itshotdownthere_63");
  level.woods dialogue::queue("vox_cp_chao_03200_wood_gotit_55");
  level.woods dialogue::queue("vox_cp_chao_03200_wood_shitgorightgori_4e");
  level dialogue::radio("vox_cp_chao_03200_chp1_getuptotherooff_26");
  level flag::wait_till("heli_going_to_gas_station");
  level dialogue::radio("vox_cp_chao_03200_chp1_highwayssurroun_76");
  level flag::wait_till("gas_station_clear");
  level.woods dialogue::queue("vox_cp_chao_03200_wood_letsgomasonusea_f6");
  level waittill(#"hash_68bdbae19e27e719");
  var_1ce174cd = [];
  var_1ce174cd[0] = "vox_cp_chao_03200_wood_upheremason_f4";
  var_1ce174cd[1] = "vox_cp_chao_03200_wood_heyyoucomingorw_80";
  var_1ce174cd[2] = "vox_cp_chao_03200_wood_uptotheroof_20";
  level.woods thread namespace_42da7c51::function_436c1448(var_1ce174cd, "trailer_park_combat_complete");
}

function function_3f06810a(aigroup, var_9fe12ee0, targetname) {
  var_5f4052dd = getaiarray(aigroup, "script_aigroup");

  foreach(agent in var_5f4052dd) {
    agent.goalradius = 1500;
    agent ai::set_goal_ent(getplayers()[0]);
  }

  level flag::wait_till(var_9fe12ee0);

  foreach(agent in var_5f4052dd) {
    if(isDefined(agent) && isalive(agent)) {
      agent.goalradius = 256;

      if(isDefined(targetname)) {
        agent ai::force_goal(getent(targetname, "targetname"));
        continue;
      }

      agent ai::force_goal(getplayers()[0]);
    }
  }

  level flag::set("balcony_complete");
}

function function_bdf7e651(seconds) {
  wait seconds;

  if(flag::get("right_staircase_approach") || flag::get("left_staircase_approach") || flag::get("balcony_complete")) {
    return;
  }

  level flag::set("right_staircase_approach");
  level flag::set("left_staircase_approach");
  level flag::set("balcony_complete");
}

function function_d38f3cd1(value, key = "targetname") {
  level flag::wait_till("fell_off_trailers");
  spawn_manager::disable("spawn_manager_tension_enemies");
  enemies = getaiarray(value, key);

  foreach(agent in enemies) {
    if(isDefined(agent) && isalive(agent)) {
      agent.goalradius = 256;
      agent ai::set_goal_ent(getplayers()[0]);
    }
  }
}

function function_ed60fe85(array, flag, var_7e81cdfd) {
  level flag::wait_till(flag);

  if(level flag::get(var_7e81cdfd)) {
    return;
  }

  foreach(agent in array) {
    if(isDefined(agent) && isalive(agent) && isDefined(getplayers()[0])) {
      agent.goalradius = 256;
      agent.ignoresuppression = 1;
      agent ai::set_goal_ent(getplayers()[0]);
    }
  }
}