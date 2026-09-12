/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicle_race\coop_vehicle_race.gsc
*********************************************************/

function init() {
  level.ied_explosion_action_func = &vehicle_race_ied_explosion_action;
  init_flags();
  load_vfx();
}

function init_flags() {
  scripts\engine\utility::flag_init("hvt_boss_combat_stage_two");
  scripts\engine\utility::flag_init("hvt_boss_combat_stage_three");
}

function start_coop_vehicle_race_sequence() {
  start_enemy_hvt_vehicle();
  thread enemy_hvt_bodyguard_vehicle_think();
  thread enemy_blocker_vehicle_think();
  thread enemy_suicide_truck_think();
}

function start_enemy_hvt_vehicle() {
  var_0 = getvehiclenode("main_start", "targetname");
  var_1 = spawnVehicle("veh8_mil_lnd_vindia_a1", "target_enemy_vehicle", "vindia", var_0.origin, var_0.angles);
  var_1 attachpath(var_0);
  var_1 startpath();
  var_1 vehicle_setspeedimmediate(50, 50, 50);
  var_1.num_of_ied_hit = 0;
  level.enemy_hvt_vehicle = var_1;
  thread track_player_humvee_speed_monitor(var_1);
  thread start_combat_marker_think(var_1);
  thread enemy_hvt_vehicle_damage_monitor(var_1);
  put_icon_on_hvt_vehicle(var_1, var_1);
  thread reach_end_monitor(var_1);
  thread get_too_far_ahead_monitor(var_1);
  thread follow_another_vehicle(var_1, var_1, level.player_humvee, 60, 35, 1750, 7, 4.5, 2);
  scripts\cp\cp_modular_spawning::run_spawn_module("enemy_hvt_boss_spawner");
}

function reach_end_monitor(var_0) {
  var_0 endon("death");
  var_1 = scripts\engine\utility::getStruct("enemy_target_vehicle_end_point", "targetname");

  for(;;) {
    if(distance2dsquared(var_1.origin, var_0.origin) <= 22500) {
      thread delay_end_game_hvt_escaped();
      return;
    }

    wait 0.1;
  }
}

function get_too_far_ahead_monitor(var_0) {
  var_0 endon("death");
  var_1 = 0;

  for(;;) {
    if(enemy_hvt_start_to_get_away(var_0)) {
      if(enemy_hvt_got_away_fail(var_0)) {
        thread delay_end_game_hvt_escaped();
        return;
      }

      if(var_1 == 0) {
        var_1 = 1;
        show_enemy_hvt_get_away_message(var_0);
      }
    } else if(var_1 == 1) {
      var_1 = 0;
      hide_enemy_hvt_get_away_message(var_0);
    }

    waitframe();
  }
}

function show_enemy_hvt_get_away_message(var_0) {
  if(should_print_warning_message()) {
    iprintlnbold("Enemy HVT is getting away!");
  }

  objective_addalltomask(var_0.objective_id);
  objective_state(var_0.objective_id, "current");
}

function hide_enemy_hvt_get_away_message(var_0) {
  objective_removeallfrommask(var_0.objective_id);
  objective_state(var_0.objective_id, "invisible");
}

function should_print_warning_message() {
  if(!isDefined(level.next_warning_message_time_hvt_getting_away)) {
    level.next_warning_message_time_hvt_getting_away = 0;
  }

  var_0 = gettime();

  if(var_0 > level.next_warning_message_time_hvt_getting_away) {
    level.next_warning_message_time_hvt_getting_away = var_0 + 5000;
    return 1;
  }

  return 0;
}

function enemy_hvt_start_to_get_away(var_0) {
  if(distance2dsquared(level.player_humvee.origin, (0, 0, 0)) < 40000) {
    return false;
  }

  return distance2dsquared(var_0.origin, level.player_humvee.origin) > 25000000;
}

function enemy_hvt_got_away_fail(var_0) {
  if(distance2dsquared(level.player_humvee.origin, (0, 0, 0)) < 40000) {
    return false;
  }

  return distance2dsquared(var_0.origin, level.player_humvee.origin) > 256000000;
}

function add_weak_spot_on_hvt_vehicle(var_0) {
  var_1 = scripts\engine\utility::getStruct("enemy_hvt_weak_spot_marker", "targetname");
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("crate_plastic_box_red");
  var_2.angles = var_1.angles;
  var_2 linkTo(var_0);
  thread clean_up_think(var_2, var_2);
  thread hvt_vehicle_weak_spot_damage_monitor(var_2, var_2);
}

function clean_up_think(var_0, var_1) {
  var_1 waittill("death");
  var_0 delete();
}

function hvt_vehicle_weak_spot_damage_monitor(var_0, var_1) {
  var_0 endon("death");
  var_1.weak_spot_destroyed = 0;
  var_1.weak_spot = var_0;
  var_0 setCanDamage(1);
  var_0.health = 999999;
  var_0.fake_health = 30;

  for(;;) {
    var_0 waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    var_0.health = 999999;

    if(isPlayer(var_3) && isDefined(var_2)) {
      var_3 scripts\cp\cp_damagefeedback::updatehitmarker("standard", 1, var_2, 0, 0);
      var_0.fake_health -= var_2;

      if(var_0.fake_health < 0) {
        break;
      }
    }
  }

  iprintlnbold("Vehicle armor has been destroyed");
  var_1.weak_spot_destroyed = 1;
  var_0 setModel("tag_origin");
  thread armor_disabled_vfx_loop(var_0);
}

function armor_disabled_vfx_loop(var_0) {
  var_0 endon("death");
  playFXOnTag(level._effect["hvt_vehicle_armor_explosion"], var_0, "tag_origin");

  for(;;) {
    playFXOnTag(level._effect["hvt_vehicle_armor_disabled"], var_0, "tag_origin");
    var_1 = randomfloatrange(0.5, 0.9);
    wait var_1;
  }
}

function vehicle_race_ied_explosion_action(var_0) {
  check_ied_blow_up_sight_blocker(var_0);
  check_ied_explodes_near_enemy_hvt(var_0);
}

function check_ied_explodes_near_enemy_hvt(var_0) {
  if(!isDefined(level.enemy_hvt_vehicle)) {
    return;
  }

  if(distance2dsquared(var_0.origin, level.enemy_hvt_vehicle.origin) < 90000) {
    level.enemy_hvt_vehicle.num_of_ied_hit++;

    switch (level.enemy_hvt_vehicle.num_of_ied_hit) {
      case 1:
        play_smoke_vfx_on_tires();
        iprintlnbold("Successful IED hit!");
        break;
      case 2:
        play_smoke_vfx_on_vehicle();
        iprintlnbold("Successful IED hit!");
        break;
      case 3:
        enemy_hvt_vehicle_explodes();
        thread coop_vehicle_race_success();
        break;
    }

    return;
  }
}

function check_ied_blow_up_sight_blocker(var_0) {
  if(isDefined(var_0.target)) {
    var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
    var_2 = var_1.sight_blocker_models;
    var_2 = scripts\engine\utility::array_removeundefined(var_2);
    var_3 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_2)[0];
    playFX(level._effect["sight_blocker_explosion"], var_3.origin);
    var_3 delete();
    return;
  }
}

function play_smoke_vfx_on_tires() {
  var_0 = ["tag_wheel_center_front_left", "tag_wheel_center_middle_left", "tag_wheel_center_back_left"];
  var_1 = ["tag_wheel_center_front_right", "tag_wheel_center_middle_right", "tag_wheel_center_back_right"];

  foreach(var_3 in var_0) {
    playFXOnTag(level._effect["hvt_vehicle_tire_damage_smoke_left"], level.enemy_hvt_vehicle, var_3);
  }

  foreach(var_6 in var_1) {
    playFXOnTag(level._effect["hvt_vehicle_tire_damage_smoke_right"], level.enemy_hvt_vehicle, var_6);
  }
}

function play_smoke_vfx_on_vehicle() {
  var_0 = ["rear_hatch_jnt", "drivers_hatch_jnt"];

  foreach(var_2 in var_0) {
    playFXOnTag(level._effect["hvt_vehicle_hood_damage_smoke"], level.enemy_hvt_vehicle, var_2);
  }
}

function enemy_hvt_vehicle_explodes() {
  playsoundatpos(level.enemy_hvt_vehicle.origin, "frag_grenade_expl_trans");
  earthquake(0.5, 1.2, level.enemy_hvt_vehicle.origin, 4000);
  playFX(level._effect["hvt_vehicle_explosion"], level.enemy_hvt_vehicle.origin);
  level.enemy_hvt_vehicle delete();
}

function coop_vehicle_race_success() {
  iprintln("You Won!");
  wait 4;
  level thread[[level.endgame]]("axis", level.end_game_string_index["win"]);
}

function put_icon_on_hvt_vehicle(var_0) {
  var_1 = scripts\cp\cp_objectives::requestworldid("enemy_hvt_vehicle_icon", 20);
  objective_setplayintro(var_1, 0);
  objective_setbackground(var_1, 1);
  objective_state(var_1, "invisible");
  objective_icon(var_1, "icon_faction_spetsnaz_enemy_small");
  objective_onentity(var_1, var_0);
  objective_removeallfrommask(var_1);
  var_0.objective_id = var_1;
  thread icon_clean_up_think(var_0);
}

function icon_clean_up_think(var_0) {
  var_0 waittill("death");
  scripts\cp\cp_objectives::freeworldid("enemy_hvt_vehicle_icon");
}

function follow_another_vehicle(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_0 endon("death");
  var_0 endon("end_follow_another_vehicle");

  for(;;) {
    if(vehicle_is_falling_behind_vehicle_to_follow(var_0, var_1)) {
      speed_up(var_0, var_2, var_5);
    } else if(vehicle_is_too_far_ahead(var_0, var_1, var_4)) {
      slow_down(var_0, var_3, var_7);
    } else if(enemy_hvt_vehicle_should_speed_up(var_0, var_1, var_8)) {
      speed_up(var_0, var_2, var_6);
    } else {
      slow_down(var_0, var_3, var_7);
    }

    wait 0.1;
  }
}

function vehicle_is_falling_behind_vehicle_to_follow(var_0, var_1) {
  var_2 = vectorNormalize(var_0 vehicle_getvelocity());
  var_3 = vectorNormalize(var_1.origin - var_0.origin);
  var_4 = vectordot(var_3, var_2);
  return var_4 > 0;
}

function speed_up(var_0, var_1, var_2) {
  var_3 = var_0 vehicle_getspeed();
  var_4 = min(var_3 + var_2, var_1);
  var_0 vehicle_setspeedimmediate(var_4);
}

function slow_down(var_0, var_1, var_2) {
  var_3 = var_0 vehicle_getspeed();
  var_4 = max(var_3 - var_2, var_1);
  var_0 vehicle_setspeedimmediate(var_4);
}

function enemy_hvt_vehicle_should_speed_up(var_0, var_1, var_2) {
  var_3 = get_angles_between_two_vehicle(var_0, var_1);

  if(var_3 < var_2) {
    return 1;
  }

  return 0;
}

function get_angles_between_two_vehicle(var_0, var_1) {
  var_2 = var_0 vehicle_getvelocity();
  var_2 = (var_2[0], var_2[1], 0);
  var_2 = vectorNormalize(var_2);
  var_3 = var_1.origin - var_0.origin;
  var_3 = (var_3[0], var_3[1], 0);
  var_3 = vectorNormalize(var_3);
  var_4 = vectordot(var_2, var_3);
  var_4 = clamp(var_4, -1, 1);
  return acos(var_4);
}

function vehicle_is_too_far_ahead(var_0, var_1, var_2) {
  return distancesquared(var_0.origin, var_1.origin) >= squared(var_2);
}

function delay_end_game_hvt_escaped() {
  iprintlnbold("Enemy HVT has escaped!");
  wait 2.5;
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

function set_up_modular_spawning() {
  level endon("game_ended");

  if(!isDefined(level.ambientgroups)) {
    level.ambientgroups = [];
  }

  if(!isDefined(level.active_spawn_modules)) {
    level.active_spawn_modules = [];
  }

  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  if(getdvarint("scr_enemy_nospawn", 0) != 0) {
    return;
  }

  scripts\cp\cp_modular_spawning::registerambientgroup("enemy_hvt_boss_spawner", 1, 1, 1, 0.05, 0, "enemy_hvt_boss_spawner", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("start_body_guard", 6, 6, 6, 0.05, 0, "start_bodyguard_spawn", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("start_bodyguard_spawn_cs", 6, 6, 6, 0.05, 0, "start_bodyguard_spawn_cs", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("bodyguard_spawn_1", 6, 6, 6, 0.05, 0, "bodyguard_spawn_1", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("bodyguard_spawn_2", 12, 12, 12, 0.05, 0, "bodyguard_spawn_2", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("bodyguard_spawn_3", 12, 12, 12, 0.05, 0, "bodyguard_spawn_3", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("bodyguard_spawn_4", 12, 12, 12, 0.05, 0, "bodyguard_spawn_4", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("bodyguard_spawn_5", 12, 12, 12, 0.05, 0, "bodyguard_spawn_5", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("bodyguard_spawn_6", 12, 12, 12, 0.05, 0, "bodyguard_spawn_6", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("bodyguard_spawn_7", 12, 12, 12, 0.05, 0, "bodyguard_spawn_7", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("bodyguard_spawn_8", 12, 12, 12, 0.05, 0, "bodyguard_spawn_8", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("bodyguard_spawn_9", 12, 12, 12, 0.05, 0, "bodyguard_spawn_9", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("bodyguard_spawn_10", 12, 12, 12, 0.05, 0, "bodyguard_spawn_10", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("bodyguard_spawn_11", 12, 12, 12, 0.05, 0, "bodyguard_spawn_11", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("bodyguard_spawn_12", 12, 12, 12, 0.05, 0, "bodyguard_spawn_12", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("bodyguard_spawn_13", 12, 12, 12, 0.05, 0, "bodyguard_spawn_13", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("bodyguard_spawn_14", 12, 12, 12, 0.05, 0, "bodyguard_spawn_14", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("bodyguard_spawn_15", 12, 12, 12, 0.05, 0, "bodyguard_spawn_15", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("bodyguard_spawn_16", 12, 12, 12, 0.05, 0, "bodyguard_spawn_16", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("bodyguard_spawn_17", 12, 12, 12, 0.05, 0, "bodyguard_spawn_17", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("blocker_spawn_1", 6, 6, 6, 0.05, 0, "blocker_spawn_1", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("blocker_spawn_2", 6, 6, 6, 0.05, 0, "blocker_spawn_2", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("blocker_spawn_3", 6, 6, 6, 0.05, 0, "blocker_spawn_3", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("blocker_spawn_4", 6, 6, 6, 0.05, 0, "blocker_spawn_4", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("blocker_spawn_5", 6, 6, 6, 0.05, 0, "blocker_spawn_5", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("blocker_spawn_6", 6, 6, 6, 0.05, 0, "blocker_spawn_6", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("blocker_spawn_7", 6, 6, 6, 0.05, 0, "blocker_spawn_7", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("blocker_spawn_8", 12, 12, 12, 0.05, 0, "blocker_spawn_8", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("blocker_spawn_9", 12, 12, 12, 0.05, 0, "blocker_spawn_9", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("blocker_spawn_10", 12, 12, 12, 0.05, 0, "blocker_spawn_10", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("blocker_spawn_11", 12, 12, 12, 0.05, 0, "blocker_spawn_11", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("blocker_spawn_12", 12, 12, 12, 0.05, 0, "blocker_spawn_12", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("blocker_spawn_13", 12, 12, 12, 0.05, 0, "blocker_spawn_13", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("blocker_spawn_14", 12, 12, 12, 0.05, 0, "blocker_spawn_14", &increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("enemy_hvt_boss_spawner", &enemy_hvt_boss_watcher);
}

function increase_script_maxdist(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_0.spawn_points.size; var_4++) {
    var_5 = var_0.spawn_points[var_4];
    var_5.script_maxdist = 20000;
  }
}

function enemy_hvt_bodyguard_vehicle_think() {
  level.hvt_bodyguard_vehicles = [];
  thread bodyguard_vehicle_spawned_monitor();

  if(getdvarint("scr_chase_use_cs", 0)) {
    scripts\cp\cp_modular_spawning::run_spawn_module("start_bodyguard_spawn_cs");
  } else {
    scripts\cp\cp_modular_spawning::run_spawn_module("start_body_guard");
  }

  var_0 = scripts\engine\utility::getStructArray("bodyguard_spawn_trigger", "targetname");

  foreach(var_2 in var_0) {
    thread bodyguard_vehicle_spawn_trigger_think(var_0, var_2);
  }

  for(;;) {
    level waittill("spawn_bodyguard_vehicle", var_4);
    scripts\cp\cp_modular_spawning::run_spawn_module(var_4);
    LOC_00000093:
  }
}

function enemy_blocker_vehicle_think() {
  level.blocker_vehicles = [];
  thread blocker_vehicle_spawned_monitor();
  var_0 = scripts\engine\utility::getStructArray("blocker_spawn_trigger", "targetname");

  foreach(var_2 in var_0) {
    thread blocker_vehicle_spawn_trigger_think(var_2, var_2);
  }

  for(;;) {
    level waittill("spawn_blocker_vehicle", var_4);
    scripts\cp\cp_modular_spawning::run_spawn_module(var_4);
    LOC_0000006c:
  }
}

function enemy_suicide_truck_think() {
  var_0 = scripts\engine\utility::getStructArray("suicide_truck_spawn_trigger", "targetname");

  foreach(var_2 in var_0) {
    thread suicide_truck_spawn_trigger_think(var_2);
  }
}

function suicide_truck_spawn_trigger_think(var_0) {
  level endon("game_ended");

  for(;;) {
    if(distance2dsquared(var_0.origin, level.player_humvee.origin) < 2250000) {
      break;
    }

    waitframe();
  }

  spawn_suicide_truck_at_vehicle_spawner(var_0.script_noteworthy, var_0);
}

function spawn_suicide_truck_at_vehicle_spawner(var_0, var_1) {
  var_2 = getvehiclenode(var_0, "targetname");
  var_3 = spawnVehicle("veh8_civ_lnd_techo_rebel_armor", "target_suicide_truck", "vindia", var_2.origin, var_2.angles);
  var_3 attachpath(var_2);
  var_3 startpath();
  var_3 vehicle_setspeedimmediate(70, 70, 70);
  thread suicide_truck_detonate_think(var_3, var_3);
  thread suicide_truck_damage_monitor(var_3);
}

function suicide_truck_damage_monitor(var_0) {
  var_0 endon("death");
  var_0 setCanDamage(1);
  var_0.health = 999999;
  var_0.fake_health = 500;

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_0.health = 999999;

    if(isPlayer(var_2) && isDefined(var_1)) {
      var_2 scripts\cp\cp_damagefeedback::updatehitmarker("standard", 1, var_1, 0, 0);
      var_0.fake_health -= var_1;

      if(var_0.fake_health <= 0) {
        break;
      }
    }
  }

  suicide_truct_explods(var_0);
}

function suicide_truck_detonate_think(var_0, var_1) {
  var_0 endon("death");
  wait_to_get_to_main_road(var_0, var_1);

  for(;;) {
    if(suicide_truck_should_detonate(var_0)) {
      suicide_truct_explods(var_0);
    }

    waitframe();
  }
}

function suicide_truct_explods(var_0) {
  earthquake(0.5, 1.2, var_0.origin, 400);
  playsoundatpos(var_0.origin, "frag_grenade_expl_trans");
  playFX(level._effect["vfx_suicide_truck_explo"], var_0.origin);
  scripts\cp\maps\cp_br_syrk\vehicle_travel::damage_nearby_players(var_0, 80, 40000);
  scripts\cp\maps\cp_br_syrk\vehicle_travel::damage_nearby_vehicles(var_0, 22500);
  var_0 delete();
}

function suicide_truck_should_detonate(var_0) {
  if(suicide_truck_ahead_of_player_humvee(var_0)) {
    return true;
  }

  if(player_humvee_withn_explosion_range(var_0)) {
    return true;
  }

  return false;
}

function player_humvee_withn_explosion_range(var_0) {
  var_1 = level.player_humvee.origin;

  if(distance2dsquared(var_1, (0, 0, 0)) > 40000) {
    return (distance2dsquared(var_0.origin, var_1) < 40000);
  }

  return false;
}

function suicide_truck_ahead_of_player_humvee(var_0) {
  var_1 = level.player_humvee.origin;

  if(distance2dsquared(var_1, (0, 0, 0)) > 40000) {
    var_2 = var_0 vehicle_getvelocity();
    var_2 = (var_2[0], var_2[1], 0);
    var_2 = vectorNormalize(var_2);
    var_3 = var_1 - var_0.origin;
    var_3 = (var_3[0], var_3[1], 0);
    var_3 = vectorNormalize(var_3);
    var_4 = vectordot(var_2, var_3);
    return (var_4 < 0);
  }

  return false;
}

function other_bodyguard_vehicles_exist() {
  return level.hvt_bodyguard_vehicles.size > 0;
}

function other_blocker_vehicles_exist() {
  return level.blocker_vehicles.size > 0;
}

function bodyguard_vehicle_spawn_trigger_think(var_0, var_1) {
  level.enemy_hvt_vehicle endon("death");

  for(;;) {
    if(distance2dsquared(var_0.origin, level.enemy_hvt_vehicle.origin) < 2250000) {
      break;
    }

    waitframe();
  }

  level notify(var_1, var_0.script_noteworthy);
}

function blocker_vehicle_spawn_trigger_think(var_0, var_1) {
  for(;;) {
    if(distance2dsquared(var_0.origin, level.player_humvee.origin) < 2250000) {
      break;
    }

    waitframe();
  }

  level notify(var_1, var_0.script_noteworthy);
}

function bodyguard_vehicle_spawned_monitor() {
  level endon("game_ended");

  for(;;) {
    level waittill("vehicle_spawned", var_0, var_1);

    if(scripts\engine\utility::array_contains(level.hvt_bodyguard_vehicles, var_1)) {
      continue;
    }

    switch (var_0.group_name) {
      case "bodyguard_spawn_17":
      case "bodyguard_spawn_16":
      case "bodyguard_spawn_15":
      case "bodyguard_spawn_14":
      case "bodyguard_spawn_13":
      case "bodyguard_spawn_12":
      case "bodyguard_spawn_11":
      case "bodyguard_spawn_10":
      case "bodyguard_spawn_9":
      case "bodyguard_spawn_8":
      case "bodyguard_spawn_7":
      case "bodyguard_spawn_6":
      case "bodyguard_spawn_5":
      case "bodyguard_spawn_4":
      case "bodyguard_spawn_3":
      case "bodyguard_spawn_2":
      case "bodyguard_spawn_1":
      case "start_body_guard":
        thread bodyguard_vehicle_think(var_1);
        break;
    }
  }
}

function blocker_vehicle_spawned_monitor() {
  level endon("game_ended");

  for(;;) {
    level waittill("vehicle_spawned", var_0, var_1);

    if(scripts\engine\utility::array_contains(level.blocker_vehicles, var_1)) {
      continue;
    }

    switch (var_0.group_name) {
      case "blocker_spawn_14":
      case "blocker_spawn_13":
      case "blocker_spawn_12":
      case "blocker_spawn_11":
      case "blocker_spawn_10":
      case "blocker_spawn_9":
      case "blocker_spawn_8":
      case "blocker_spawn_7":
      case "blocker_spawn_6":
      case "blocker_spawn_5":
      case "blocker_spawn_4":
      case "blocker_spawn_3":
      case "blocker_spawn_2":
      case "blocker_spawn_1":
        thread blocker_vehicle_think(var_1);
        break;
    }
  }
}

function bodyguard_vehicle_think(var_0) {
  var_0 endon("death");
  add_to_hvt_bodyguard_vehicles_array(var_0);
  thread bodyguard_vehicle_death_monitor(var_0);
  thread enemy_vehicle_damage_monitor(var_0, var_0);
  wait 1.5;
  change_riders_demeanor(var_0);
  var_0 notify("stop_vehicle_on_damage_internal");
  var_0 notify("stop_waiting_for_spawns");
  thread follow_enemy_hvt_vehicle(var_0);
  thread enemy_vehicle_no_rider_monitor(var_0);
}

function blocker_vehicle_think(var_0) {
  var_0 endon("death");
  add_to_blocker_vehicles_array(var_0);
  thread blocker_vehicle_death_monitor(var_0);
  thread enemy_vehicle_damage_monitor(var_0, var_0);
  wait 1.5;
  change_riders_demeanor(var_0);
  var_0 notify("stop_vehicle_on_damage_internal");
  var_0 notify("stop_waiting_for_spawns");
  thread enemy_vehicle_no_rider_monitor(var_0);
  thread stay_in_front_of_player_vehicle(var_0);
}

function change_riders_demeanor(var_0) {
  foreach(var_2 in var_0.riders) {
    var_2 scripts\common\utility::demeanor_override("combat");
  }
}

function enemy_vehicle_damage_monitor(var_0, var_1) {
  var_0 endon("death");
  var_0.health = 999999;
  var_0.fake_health = var_1;

  for(;;) {
    var_0 waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    var_0.health = 999999;

    if(isDefined(var_2)) {
      var_0.fake_health -= var_2;

      if(var_0.fake_health < 0) {
        enemy_vehicle_explodes(var_0, var_0);
      }
    }
  }
}

function enemy_vehicle_no_rider_monitor(var_0) {
  var_0 endon("death");
  var_0 endon("vehicle_has_unload");

  foreach(var_2 in var_0.riders) {
    thread rider_death_monitor(var_2, var_2);
  }

  for(;;) {
    var_0 waittill("a_rider_just_died");
    var_4 = get_num_of_alive_riders(var_0);

    if(var_4 == 0) {
      enemy_vehicle_explodes(var_0, var_0);
    }
  }
}

function get_num_of_alive_riders(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0.riders) {
    if(isai(var_3) && isalive(var_3)) {
      var_1++;
    }
  }

  return var_1;
}

function rider_death_monitor(var_0, var_1) {
  var_0 waittill("death");
  var_1 notify("a_rider_just_died");
}

function enemy_vehicle_explodes(var_0) {
  foreach(var_2 in var_0.riders) {
    if(isai(var_2) && isalive(var_2)) {
      var_2 unlink();
      var_3 = vectorNormalize(var_2.origin - var_0.origin);
      var_2 setvelocity(var_3 * 1200);
      var_2 dodamage(var_2.health + 100, var_2.origin);
    }
  }

  playFX(level._effect["bodyguard_vehicle_explosion"], var_0.origin + (0, 0, 20));
  var_0 delete();
}

function follow_enemy_hvt_vehicle(var_0) {
  var_0 endon("death");
  level.enemy_hvt_vehicle endon("death");

  if(!isDefined(level.enemy_hvt_vehicle)) {
    return;
  }

  var_1 = level.enemy_hvt_vehicle;
  var_0 vehicle_setspeedimmediate(65, 65, 65);

  for(;;) {
    if(vehicle_is_too_far_ahead(var_0, var_1, 1300)) {
      speed_up(var_0, 65, 1);
    } else if(hvt_bodyguard_vehicle_should_speed_up(var_0, var_1)) {
      speed_up(var_0, 65, 1);
    } else {
      slow_down(var_0, 25, 4);
    }

    waitframe();
  }
}

function stay_in_front_of_player_vehicle(var_0) {
  var_0 endon("death");
  var_0 vehicle_setspeedimmediate(75, 75, 75);
  wait_to_get_to_main_road(var_0, scripts\engine\utility::getStruct(var_0.group.group_name + "_target", "targetname"));

  for(;;) {
    if(getting_too_close_with_player_humvee(var_0, level.player_humvee)) {
      speed_up(var_0, 75, 2.5);
    } else {
      slow_down(var_0, 0, 1);
    }

    waitframe();
  }
}

function delay_test_explodes(var_0) {
  wait 5;
  enemy_vehicle_explodes(var_0);
}

function wait_to_get_to_main_road(var_0, var_1) {
  for(;;) {
    if(distance2dsquared(var_0.origin, var_1.origin) < 90000) {
      return;
    }

    waitframe();
  }
}

function getting_too_close_with_player_humvee(var_0, var_1) {
  return distance2dsquared(var_0.origin, var_1.origin) < 2250000;
}

function hvt_bodyguard_vehicle_should_speed_up(var_0, var_1) {
  if(too_close_to_other_bodyguard_vehicle_in_front(var_0)) {
    return 0;
  }

  var_2 = var_0 vehicle_getvelocity();
  var_2 = (var_2[0], var_2[1], 0);
  var_2 = vectorNormalize(var_2);
  var_3 = var_1.origin - var_0.origin;
  var_3 = (var_3[0], var_3[1], 0);
  var_3 = vectorNormalize(var_3);
  var_4 = vectordot(var_2, var_3);
  var_5 = acos(var_4);

  if(var_5 < get_desired_bodyguard_vehicle_angle(var_0)) {
    return 1;
  }

  return 0;
}

function too_close_to_other_bodyguard_vehicle_in_front(var_0) {
  var_1 = get_other_bodyguard_vehicles_in_front(var_0);

  foreach(var_3 in var_1) {
    if(distance2dsquared(var_0.origin, var_3.origin) <= 250000) {
      return true;
    }
  }

  return false;
}

function get_other_bodyguard_vehicles_in_front(var_0) {
  var_1 = [];
  var_2 = var_0 vehicle_getvelocity();

  foreach(var_4 in level.hvt_bodyguard_vehicles) {
    if(var_4 == var_0) {
      continue;
    }

    var_5 = var_4.origin - var_0.origin;

    if(vectordot(var_5, var_2) < 0) {
      continue;
    }

    var_1 = var_4;
  }

  return var_1;
}

function too_close_to_other_blocker_vehicle_in_front(var_0) {
  var_1 = get_other_blocker_vehicles_in_front(var_0);

  foreach(var_3 in var_1) {
    if(distance2dsquared(var_0.origin, var_3.origin) <= 250000) {
      return true;
    }
  }

  return false;
}

function get_other_blocker_vehicles_in_front(var_0) {
  var_1 = [];
  var_2 = var_0 vehicle_getvelocity();

  foreach(var_4 in level.blocker_vehicles) {
    if(var_4 == var_0) {
      continue;
    }

    var_5 = var_4.origin - var_0.origin;

    if(vectordot(var_5, var_2) < 0) {
      continue;
    }

    var_1 = var_4;
  }

  return var_1;
}

function get_desired_bodyguard_vehicle_angle(var_0) {
  switch (level.hvt_bodyguard_vehicles.size) {
    case 1:
      return 90;
    case 2:
      switch (var_0.bodyguard_vehicle_id) {
        case 1:
          return 135;
        case 2:
          return 90;
      }
    case 3:
      switch (var_0.bodyguard_vehicle_id) {
        case 1:
          return 150;
        case 2:
          return 90;
        case 3:
          return 30;
      }

      break;
  }
}

function add_to_blocker_vehicles_array(var_0) {
  level.blocker_vehicles = scripts\engine\utility::array_add(level.blocker_vehicles, var_0);
}

function add_to_hvt_bodyguard_vehicles_array(var_0) {
  level.hvt_bodyguard_vehicles = scripts\engine\utility::array_add(level.hvt_bodyguard_vehicles, var_0);
  var_0.bodyguard_vehicle_id = level.hvt_bodyguard_vehicles.size;
}

function bodyguard_vehicle_death_monitor(var_0) {
  var_0 waittill("death");
  var_1 = var_0.bodyguard_vehicle_id;
  level.hvt_bodyguard_vehicles = scripts\engine\utility::array_remove(level.hvt_bodyguard_vehicles, var_0);
  reassign_bodyguard_vehicle_id(var_1);
}

function blocker_vehicle_death_monitor(var_0) {
  var_0 waittill("death");
  level.blocker_vehicles = scripts\engine\utility::array_remove(level.blocker_vehicles, var_0);
}

function reassign_bodyguard_vehicle_id(var_0) {
  foreach(var_2 in level.hvt_bodyguard_vehicles) {
    if(var_2.bodyguard_vehicle_id > var_0) {
      var_2.bodyguard_vehicle_id--;
    }
  }
}

function enemy_hvt_vehicle_damage_monitor(var_0) {
  var_0 endon("death");
  var_0 setCanDamage(1);
  var_0.health = 999999;

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_0.health = 999999;
  }
}

function deploy_concrtete_blockers_for_puzzle() {
  var_0 = scripts\engine\utility::getStructArray("concrete_blocker_controlling_struct", "script_noteworthy");

  foreach(var_2 in var_0) {
    process_concrete_blocker_controlling_struct(var_2);
    waitframe();
  }
}

function process_concrete_blocker_controlling_struct(var_0) {
  process_linked_structs(var_0);
  set_up_concrete_blockers(var_0);
  set_up_sight_blockers(var_0);
}

function process_linked_structs(var_0) {
  var_0.num_of_concrete_blocks = int(var_0.script_parameters);
  var_1 = [];
  var_2 = [];
  var_3 = scripts\engine\utility::getStructArray(var_0.target, "targetname");

  foreach(var_5 in var_3) {
    switch (var_5.script_noteworthy) {
      case "concrete_blocker_marker":
        var_1 = var_5;
        break;
      case "sight_blocker_marker":
        var_2 = var_5;
        break;
    }
  }

  var_0.concrete_blocker_markers = var_1;
  var_0.sight_blocker_markers = var_2;
}

function set_up_concrete_blockers(var_0) {
  var_1 = var_0.concrete_blocker_markers;

  for(var_2 = 0; var_2 < 5; var_2++) {
    var_1 = scripts\engine\utility::array_randomize(var_1);
  }

  var_3 = var_0.num_of_concrete_blocks;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = var_1[var_4];
    var_6 = spawn("script_model", var_5.origin);
    var_6 setModel("barrier_traffic_concrete_block_01");
    var_6.angles = var_5.angles;
  }
}

function set_up_sight_blockers(var_0) {
  var_1 = [];

  foreach(var_3 in var_0.sight_blocker_markers) {
    var_4 = spawn("script_model", var_3.origin);
    var_4 setModel("fence_corrugated_metal_03_256_cp");
    var_4.angles = var_3.angles;
    var_1 = var_4;
  }

  var_0.sight_blocker_models = var_1;
}

function enemy_hvt_boss_watcher(var_0) {
  var_1 = self;
  var_1.health = 9999;
  var_1.maxhealth = 9999;
  var_1.dontevershoot = 1;
  var_1.invulnerable = 1;
  var_1 scripts\engine\utility::ent_flag_init("stop_combat");
  thread delay_demeanor_override(var_1);
  thread hvt_boss_damage_monitor(var_1);
  thread hvt_boss_combat_think(var_1);
  var_2 = spawn("script_model", var_1 gettagorigin("tag_eye"));
  var_2 setModel("tag_origin");
  var_2.angles = var_1 getplayerangles();
  var_2 linkTo(var_1);
  var_1.hvt_boss_laser_tag = var_2;
  var_3 = spawn("script_model", var_1.origin);
  var_3 setModel("tag_origin");
  var_3.angles = var_1 getplayerangles();
  var_1.hvt_boss_mover = var_3;
  var_1 linkTo(var_3, "tag_origin");
  thread hvt_boss_mover_follow_enemy_hvt_vehicle(var_3);
  thread hvt_boss_mover_face_player_humvee(var_3);
  thread hvt_boss_clean_up_think(var_1);
}

function delay_demeanor_override(var_0) {
  var_0 endon("death");
  waitframe();
  var_0 scripts\common\utility::demeanor_override("patrol");
  var_0 allowedstances("crouch");
}

function hvt_boss_mover_follow_enemy_hvt_vehicle(var_0) {
  var_0 endon("death");
  level.enemy_hvt_vehicle endon("death");
  var_1 = level.enemy_hvt_vehicle;
  var_0.enemy_hvt_mover_vertical_offset = -71;

  for(;;) {
    var_2 = var_1 gettagorigin("tag_turret");
    var_3 = var_1 vehicle_getvelocity();
    var_3 = (var_3[0], var_3[1], 0);
    var_3 *= 0.05;
    var_0.origin = var_2 + (0, 0, var_0.enemy_hvt_mover_vertical_offset) + var_3;
    waitframe();
  }
}

function hvt_boss_combat_think(var_0) {
  var_0 endon("death");
  wait randomfloatrange(7, 15);
  hvt_boss_do_combat(var_0);
  scripts\engine\utility::flag_wait("hvt_boss_combat_stage_two");
  hvt_boss_do_combat(var_0);
  scripts\engine\utility::flag_wait("hvt_boss_combat_stage_three");
  hvt_boss_do_combat(var_0);
  thread play_coop_vehicle_race_successs();
  var_0.invulnerable = 0;
  var_0 dodamage(var_0.health + 100, var_0.origin);
}

function play_coop_vehicle_race_successs() {
  enemy_hvt_vehicle_explodes();
  thread coop_vehicle_race_success();
}

function delay_set_starge_two_flag() {
  wait 10;
  scripts\engine\utility::flag_set("hvt_boss_combat_stage_two");
  iprintlnbold("stage_two");
}

function delay_set_starge_three_flag() {
  wait 10;
  scripts\engine\utility::flag_set("hvt_boss_combat_stage_three");
  iprintlnbold("stage_three");
}

function hvt_boss_do_combat(var_0) {
  var_0 scripts\engine\utility::ent_flag_clear("stop_combat");

  for(;;) {
    if(player_humvee_is_within_combar_range()) {
      hvt_boss_move_to_target_vertical_offset(var_0, -45);
      var_0.invulnerable = 0;
      var_0 scripts\common\utility::demeanor_override("combat");
      var_0 waittill("exposed_stand_to_crouch_finished");
      hvt_boss_move_to_target_vertical_offset(var_0, -25);

      if(isDefined(level.enemy_hvt_vehicle.damage_state) && level.enemy_hvt_vehicle.damage_state == 3) {
        return;
      }

      wait 1;

      if(!var_0 scripts\engine\utility::ent_flag("stop_combat")) {
        var_1 = level.enemy_hvt_vehicle;
        var_2 = var_1 vehicle_getvelocity();
        var_2 = (var_2[0], var_2[1], 0);
        var_2 *= 0.95;
        var_3 = anglesToForward(var_0 getplayerangles());
        var_4 = var_0 gettagorigin("j_wrist_le") + var_3 * 20 + var_2;
        var_5 = level.player_humvee vehicle_getvelocity();
        var_6 = anglesToForward(level.player_humvee.angles);
        var_7 = level.player_humvee.origin + (0, 0, 40) + var_6 * var_1.player_humvee_speed * 25;
        var_8 = magicbullet("rpg_missile_cp", var_4, var_7);
        thread delay_play_ignition_vfx(var_8);
      }

      var_0.invulnerable = 1;

      if(isDefined(level.enemy_hvt_vehicle.damage_state) && level.enemy_hvt_vehicle.damage_state == 3) {
        return;
      }

      var_0 scripts\common\utility::demeanor_override("patrol");
      hvt_boss_move_to_target_vertical_offset(var_0, -71);
      wait randomfloatrange(3, 6);

      if(var_0 scripts\engine\utility::ent_flag("stop_combat")) {
        return;
      }
    }

    wait randomfloatrange(0.5, 1);

    if(var_0 scripts\engine\utility::ent_flag("stop_combat")) {
      return;
    }
  }
}

function do_laser_target_on_player_humvee(var_0) {
  var_1 = int(60);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = var_0 gettagorigin("tag_eye");
    var_4 = level.player_humvee vehicle_getvelocity();
    var_5 = level.player_humvee.origin + (0, 0, 80) + var_4 * 0.01;
    var_6 = var_5 - var_3;
    var_7 = vectortoangles(var_6);
    playfxbetweenpoints(level._effect["hvt_target_laser"], var_3, var_7, var_5);
    var_8 = var_0 scripts\engine\utility::ref_143B9(0.05, "damage");

    if(var_8 == "damage") {
      return "fail";
    }
  }

  return "success";
}

function get_target_laser_angles(var_0) {
  var_1 = var_0 gettagorigin("tag_eye");
  var_2 = level.player_humvee.origin + (0, 0, 50);
  var_3 = var_2 - var_1;
  return vectortoangles(var_3);
}

function switch_to_guiding_missile(var_0) {
  var_1 = var_0.origin;
  var_0 delete();
  var_2 = level.enemy_hvt_vehicle;
  var_3 = var_2 vehicle_getvelocity();
  var_3 = (var_3[0], var_3[1], 0);
  var_3 *= 0.95;
  var_1 += var_3;
  var_4 = level.player_humvee;
  var_5 = magicbullet("juliet_missile_cp", var_1, var_4.origin);
  var_5 missile_settargetEnt(var_4);
  var_5 missile_setflightmodetop();
  thread delay_play_ignition_vfx(var_5);
}

function delay_play_ignition_vfx(var_0) {
  var_0 endon("death");
  wait 0.1;
  playFXOnTag(level._effect["javelin_ignition"], var_0, "tag_fx");
}

function hvt_boss_move_to_target_vertical_offset(var_0, var_1) {
  var_2 = var_1 - var_0.hvt_boss_mover.enemy_hvt_mover_vertical_offset;
  var_3 = abs(var_2) / 1;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    if(var_1 >= var_0.hvt_boss_mover.enemy_hvt_mover_vertical_offset) {
      var_0.hvt_boss_mover.enemy_hvt_mover_vertical_offset += 1;
    } else {
      var_0.hvt_boss_mover.enemy_hvt_mover_vertical_offset -= 1;
    }

    waitframe();
  }
}

function player_humvee_is_within_combar_range() {
  var_0 = level.enemy_hvt_vehicle;
  var_1 = level.player_humvee;

  if(distance2dsquared(level.player_humvee.origin, (0, 0, 0)) < 40000) {
    return false;
  }

  return distance2dsquared(var_0.origin, var_1.origin) < 25000000;
}

function hvt_boss_mover_face_player_humvee(var_0) {
  var_0 endon("death");

  for(;;) {
    var_1 = level.player_humvee.origin - var_0.origin;
    var_1 = (var_1[0], var_1[1], 0);
    var_1 = vectorNormalize(var_1);
    var_0.angles = vectortoangles(var_1);
    waitframe();
  }
}

function hvt_boss_clean_up_think(var_0) {
  var_0 waittill("death");

  if(isDefined(var_0.hvt_boss_mover)) {
    var_0.hvt_boss_mover delete();
  }

  if(isDefined(var_0.hvt_boss_laser_tag)) {
    var_0.hvt_boss_laser_tag delete();
    return;
  }
}

function hvt_boss_damage_monitor(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_0.health = 9999;
    var_0.maxhealth = 9999;

    if(istrue(var_0.invulnerable)) {
      continue;
    }

    var_11 = get_attacker_as_player(var_2);

    if(isDefined(var_11)) {
      var_0.invulnerable = 1;
      playsoundatpos(var_0.origin, "frag_grenade_expl_trans");
      playFX(level._effect["hvt_boss_rpg_explosion"], var_0.origin);
      enemy_hvt_vehicle_damage_state();
      var_0 scripts\engine\utility::ent_flag_set("stop_combat");
      thread delay_update_damagefeedback(var_11);
    }
  }
}

function get_attacker_as_player(var_0) {
  if(isPlayer(var_0)) {
    return var_0;
  }

  if(isPlayer(var_0.owner)) {
    return var_0.owner;
  }

  return undefined;
}

function delay_update_damagefeedback(var_0) {
  var_0 endon("disconnect");
  waittillframeend();

  if(isDefined(level.enemy_hvt_vehicle.damage_state) && level.enemy_hvt_vehicle.damage_state == 3) {
    var_0 thread scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical", 1);
    return;
  }

  var_0 thread scripts\cp\cp_damagefeedback::updatedamagefeedback("standard");
}

function enemy_hvt_vehicle_damage_state() {
  if(!isDefined(level.enemy_hvt_vehicle.damage_state)) {
    level.enemy_hvt_vehicle.damage_state = 0;
  }

  level.enemy_hvt_vehicle.damage_state++;

  switch (level.enemy_hvt_vehicle.damage_state) {
    case 1:
      thread loop_sparks_vfx_on_enemy_hvt_vehicle();
      break;
    case 2:
      play_smoke_vfx_on_tires();
      play_smoke_vfx_on_vehicle();
      break;
    default:
      break;
  }
}

function loop_sparks_vfx_on_enemy_hvt_vehicle() {
  level.enemy_hvt_vehicle endon("death");
  var_0 = ["tag_wheel_center_front_left", "tag_wheel_center_middle_left", "tag_wheel_center_back_left", "tag_wheel_center_front_right", "tag_wheel_center_middle_right", "tag_wheel_center_back_right", "rear_hatch_jnt", "drivers_hatch_jnt"];

  for(;;) {
    var_1 = scripts\engine\utility::random(var_0);
    playFXOnTag(level._effect["hvt_vehicle_armor_explosion"], level.enemy_hvt_vehicle, var_1);
    wait randomfloatrange(0.15, 0.35);
  }
}

function track_player_humvee_speed_monitor(var_0) {
  var_0 endon("death");
  var_1 = level.player_humvee;

  for(var_2 = var_1.origin;; var_2 = var_3) {
    waitframe();
    var_3 = var_1.origin;
    var_4 = length(var_3 - var_2);
    var_0.player_humvee_speed = var_4;
  }
}

function start_combat_marker_think(var_0) {
  level.enemy_hvt_vehicle endon("death");
  var_1 = scripts\engine\utility::getStructArray("hvt_boss_combat_marker", "targetname");

  foreach(var_3 in var_1) {
    thread hvt_combat_start_marker_think(var_3);
  }
}

function hvt_combat_start_marker_think(var_0) {
  level.enemy_hvt_vehicle endon("death");

  for(;;) {
    if(distance2dsquared(var_0.origin, level.enemy_hvt_vehicle.origin) < 2250000) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set(var_0.script_noteworthy);
}

function load_vfx() {
  level._effect["bodyguard_vehicle_explosion"] = loadfx("vfx/iw8/prop/scriptables/vfx_veh_explosion_civ.vfx");
  level._effect["hvt_vehicle_armor_explosion"] = loadfx("vfx/core/expl/electrical_transformer_sparks_a.vfx");
  level._effect["hvt_vehicle_armor_disabled"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_omni.vfx");
  level._effect["hvt_vehicle_tire_damage_smoke_left"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_damage_smoke_runner.vfx");
  level._effect["hvt_vehicle_tire_damage_smoke_right"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_damage_smoke_runner_right_side.vfx");
  level._effect["hvt_vehicle_hood_damage_smoke"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_damage_smoke_hood.vfx");
  level._effect["hvt_vehicle_explosion"] = loadfx("vfx/iw8/level/highway/vfx_suicide_truck_explosion.vfx");
  level._effect["vfx_suicide_truck_explo"] = loadfx("vfx/iw8/level/highway/vfx_suicide_truck_explosion.vfx");
  level._effect["sight_blocker_explosion"] = loadfx("vfx/iw8/weap/_explo/suicide/vfx_explo_suicide_bomb.vfx");
  level._effect["hvt_boss_rpg_explosion"] = loadfx("vfx/iw8/weap/_explo/rpg/vfx_explo_rpg.vfx");
  level._effect["javelin_ignition"] = loadfx("vfx/iw8_mp/muzflash/vfx_smoke_javelin_ignition.vfx");
  level._effect["hvt_target_laser"] = loadfx("vfx/iw8_cp/coop_vehicle_race/vfx_enemy_hvt_laser_pointer.vfx");
  level._effect["hvt_target_laser_static"] = loadfx("vfx/iw8_cp/coop_vehicle_race/vfx_enemy_hvt_laser_pointer_static.vfx");
}