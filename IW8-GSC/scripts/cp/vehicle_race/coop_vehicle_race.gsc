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
  var0 = getvehiclenode("main_start", "targetname");
  var1 = spawnVehicle("veh8_mil_lnd_vindia_a1", "target_enemy_vehicle", "vindia", var0.origin, var0.angles);
  var1 attachpath(var0);
  var1 startpath();
  var1 vehicle_setspeedimmediate(50, 50, 50);
  var1.num_of_ied_hit = 0;
  level.enemy_hvt_vehicle = var1;
  thread track_player_humvee_speed_monitor(var1);
  thread start_combat_marker_think(var1);
  thread enemy_hvt_vehicle_damage_monitor(var1);
  put_icon_on_hvt_vehicle(var1, var1);
  thread reach_end_monitor(var1);
  thread get_too_far_ahead_monitor(var1);
  thread follow_another_vehicle(var1, var1, level.player_humvee, 60, 35, 1750, 7, 4.5, 2);
  scripts\cp\cp_modular_spawning::run_spawn_module("enemy_hvt_boss_spawner");
}

function reach_end_monitor(var0) {
  var0 endon("death");
  var1 = scripts\engine\utility::getStruct("enemy_target_vehicle_end_point", "targetname");

  for(;;) {
    if(distance2dsquared(var1.origin, var0.origin) <= 22500) {
      thread delay_end_game_hvt_escaped();
      return;
    }

    wait 0.1;
  }
}

function get_too_far_ahead_monitor(var0) {
  var0 endon("death");
  var1 = 0;

  for(;;) {
    if(enemy_hvt_start_to_get_away(var0)) {
      if(enemy_hvt_got_away_fail(var0)) {
        thread delay_end_game_hvt_escaped();
        return;
      }

      if(var1 == 0) {
        var1 = 1;
        show_enemy_hvt_get_away_message(var0);
      }
    } else if(var1 == 1) {
      var1 = 0;
      hide_enemy_hvt_get_away_message(var0);
    }

    waitframe();
  }
}

function show_enemy_hvt_get_away_message(var0) {
  if(should_print_warning_message()) {
    iprintlnbold("Enemy HVT is getting away!");
  }

  objective_addalltomask(var0.objective_id);
  objective_state(var0.objective_id, "current");
}

function hide_enemy_hvt_get_away_message(var0) {
  objective_removeallfrommask(var0.objective_id);
  objective_state(var0.objective_id, "invisible");
}

function should_print_warning_message() {
  if(!isDefined(level.next_warning_message_time_hvt_getting_away)) {
    level.next_warning_message_time_hvt_getting_away = 0;
  }

  var0 = gettime();

  if(var0 > level.next_warning_message_time_hvt_getting_away) {
    level.next_warning_message_time_hvt_getting_away = var0 + 5000;
    return 1;
  }

  return 0;
}

function enemy_hvt_start_to_get_away(var0) {
  if(distance2dsquared(level.player_humvee.origin, (0, 0, 0)) < 40000) {
    return false;
  }

  return distance2dsquared(var0.origin, level.player_humvee.origin) > 25000000;
}

function enemy_hvt_got_away_fail(var0) {
  if(distance2dsquared(level.player_humvee.origin, (0, 0, 0)) < 40000) {
    return false;
  }

  return distance2dsquared(var0.origin, level.player_humvee.origin) > 256000000;
}

function add_weak_spot_on_hvt_vehicle(var0) {
  var1 = scripts\engine\utility::getStruct("enemy_hvt_weak_spot_marker", "targetname");
  var2 = spawn("script_model", var1.origin);
  var2 setModel("crate_plastic_box_red");
  var2.angles = var1.angles;
  var2 linkTo(var0);
  thread clean_up_think(var2, var2);
  thread hvt_vehicle_weak_spot_damage_monitor(var2, var2);
}

function clean_up_think(var0, var1) {
  var1 waittill("death");
  var0 delete();
}

function hvt_vehicle_weak_spot_damage_monitor(var0, var1) {
  var0 endon("death");
  var1.weak_spot_destroyed = 0;
  var1.weak_spot = var0;
  var0 setCanDamage(1);
  var0.health = 999999;
  var0.fake_health = 30;

  for(;;) {
    var0 waittill("damage", var2, var3, var4, var5, var6, var7, var8, var9, var10, var11);
    var0.health = 999999;

    if(isPlayer(var3) && isDefined(var2)) {
      var3 scripts\cp\cp_damagefeedback::updatehitmarker("standard", 1, var2, 0, 0);
      var0.fake_health -= var2;

      if(var0.fake_health < 0) {
        break;
      }
    }
  }

  iprintlnbold("Vehicle armor has been destroyed");
  var1.weak_spot_destroyed = 1;
  var0 setModel("tag_origin");
  thread armor_disabled_vfx_loop(var0);
}

function armor_disabled_vfx_loop(var0) {
  var0 endon("death");
  playFXOnTag(level._effect["hvt_vehicle_armor_explosion"], var0, "tag_origin");

  for(;;) {
    playFXOnTag(level._effect["hvt_vehicle_armor_disabled"], var0, "tag_origin");
    var1 = randomfloatrange(0.5, 0.9);
    wait var1;
  }
}

function vehicle_race_ied_explosion_action(var0) {
  check_ied_blow_up_sight_blocker(var0);
  check_ied_explodes_near_enemy_hvt(var0);
}

function check_ied_explodes_near_enemy_hvt(var0) {
  if(!isDefined(level.enemy_hvt_vehicle)) {
    return;
  }

  if(distance2dsquared(var0.origin, level.enemy_hvt_vehicle.origin) < 90000) {
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

function check_ied_blow_up_sight_blocker(var0) {
  if(isDefined(var0.target)) {
    var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
    var2 = var1.sight_blocker_models;
    var2 = scripts\engine\utility::array_removeundefined(var2);
    var3 = scripts\engine\utility::get_array_of_closest(var0.origin, var2)[0];
    playFX(level._effect["sight_blocker_explosion"], var3.origin);
    var3 delete();
    return;
  }
}

function play_smoke_vfx_on_tires() {
  var0 = ["tag_wheel_center_front_left", "tag_wheel_center_middle_left", "tag_wheel_center_back_left"];
  var1 = ["tag_wheel_center_front_right", "tag_wheel_center_middle_right", "tag_wheel_center_back_right"];

  foreach(var3 in var0) {
    playFXOnTag(level._effect["hvt_vehicle_tire_damage_smoke_left"], level.enemy_hvt_vehicle, var3);
  }

  foreach(var6 in var1) {
    playFXOnTag(level._effect["hvt_vehicle_tire_damage_smoke_right"], level.enemy_hvt_vehicle, var6);
  }
}

function play_smoke_vfx_on_vehicle() {
  var0 = ["rear_hatch_jnt", "drivers_hatch_jnt"];

  foreach(var2 in var0) {
    playFXOnTag(level._effect["hvt_vehicle_hood_damage_smoke"], level.enemy_hvt_vehicle, var2);
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

function put_icon_on_hvt_vehicle(var0) {
  var1 = scripts\cp\cp_objectives::requestworldid("enemy_hvt_vehicle_icon", 20);
  objective_setplayintro(var1, 0);
  objective_setbackground(var1, 1);
  objective_state(var1, "invisible");
  objective_icon(var1, "icon_faction_spetsnaz_enemy_small");
  objective_onentity(var1, var0);
  objective_removeallfrommask(var1);
  var0.objective_id = var1;
  thread icon_clean_up_think(var0);
}

function icon_clean_up_think(var0) {
  var0 waittill("death");
  scripts\cp\cp_objectives::freeworldid("enemy_hvt_vehicle_icon");
}

function follow_another_vehicle(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var0 endon("death");
  var0 endon("end_follow_another_vehicle");

  for(;;) {
    if(vehicle_is_falling_behind_vehicle_to_follow(var0, var1)) {
      speed_up(var0, var2, var5);
    } else if(vehicle_is_too_far_ahead(var0, var1, var4)) {
      slow_down(var0, var3, var7);
    } else if(enemy_hvt_vehicle_should_speed_up(var0, var1, var8)) {
      speed_up(var0, var2, var6);
    } else {
      slow_down(var0, var3, var7);
    }

    wait 0.1;
  }
}

function vehicle_is_falling_behind_vehicle_to_follow(var0, var1) {
  var2 = vectorNormalize(var0 vehicle_getvelocity());
  var3 = vectorNormalize(var1.origin - var0.origin);
  var4 = vectordot(var3, var2);
  return var4 > 0;
}

function speed_up(var0, var1, var2) {
  var3 = var0 vehicle_getspeed();
  var4 = min(var3 + var2, var1);
  var0 vehicle_setspeedimmediate(var4);
}

function slow_down(var0, var1, var2) {
  var3 = var0 vehicle_getspeed();
  var4 = max(var3 - var2, var1);
  var0 vehicle_setspeedimmediate(var4);
}

function enemy_hvt_vehicle_should_speed_up(var0, var1, var2) {
  var3 = get_angles_between_two_vehicle(var0, var1);

  if(var3 < var2) {
    return 1;
  }

  return 0;
}

function get_angles_between_two_vehicle(var0, var1) {
  var2 = var0 vehicle_getvelocity();
  var2 = (var2[0], var2[1], 0);
  var2 = vectorNormalize(var2);
  var3 = var1.origin - var0.origin;
  var3 = (var3[0], var3[1], 0);
  var3 = vectorNormalize(var3);
  var4 = vectordot(var2, var3);
  var4 = clamp(var4, -1, 1);
  return acos(var4);
}

function vehicle_is_too_far_ahead(var0, var1, var2) {
  return distancesquared(var0.origin, var1.origin) >= squared(var2);
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

function increase_script_maxdist(var0, var1, var2, var3) {
  for(var4 = 0; var4 < var0.spawn_points.size; var4++) {
    var5 = var0.spawn_points[var4];
    var5.script_maxdist = 20000;
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

  var0 = scripts\engine\utility::getStructArray("bodyguard_spawn_trigger", "targetname");

  foreach(var2 in var0) {
    thread bodyguard_vehicle_spawn_trigger_think(var0, var2);
  }

  for(;;) {
    level waittill("spawn_bodyguard_vehicle", var4);
    scripts\cp\cp_modular_spawning::run_spawn_module(var4);
    LOC_00000093:
  }
}

function enemy_blocker_vehicle_think() {
  level.blocker_vehicles = [];
  thread blocker_vehicle_spawned_monitor();
  var0 = scripts\engine\utility::getStructArray("blocker_spawn_trigger", "targetname");

  foreach(var2 in var0) {
    thread blocker_vehicle_spawn_trigger_think(var2, var2);
  }

  for(;;) {
    level waittill("spawn_blocker_vehicle", var4);
    scripts\cp\cp_modular_spawning::run_spawn_module(var4);
    LOC_0000006c:
  }
}

function enemy_suicide_truck_think() {
  var0 = scripts\engine\utility::getStructArray("suicide_truck_spawn_trigger", "targetname");

  foreach(var2 in var0) {
    thread suicide_truck_spawn_trigger_think(var2);
  }
}

function suicide_truck_spawn_trigger_think(var0) {
  level endon("game_ended");

  for(;;) {
    if(distance2dsquared(var0.origin, level.player_humvee.origin) < 2250000) {
      break;
    }

    waitframe();
  }

  spawn_suicide_truck_at_vehicle_spawner(var0.script_noteworthy, var0);
}

function spawn_suicide_truck_at_vehicle_spawner(var0, var1) {
  var2 = getvehiclenode(var0, "targetname");
  var3 = spawnVehicle("veh8_civ_lnd_techo_rebel_armor", "target_suicide_truck", "vindia", var2.origin, var2.angles);
  var3 attachpath(var2);
  var3 startpath();
  var3 vehicle_setspeedimmediate(70, 70, 70);
  thread suicide_truck_detonate_think(var3, var3);
  thread suicide_truck_damage_monitor(var3);
}

function suicide_truck_damage_monitor(var0) {
  var0 endon("death");
  var0 setCanDamage(1);
  var0.health = 999999;
  var0.fake_health = 500;

  for(;;) {
    var0 waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);
    var0.health = 999999;

    if(isPlayer(var2) && isDefined(var1)) {
      var2 scripts\cp\cp_damagefeedback::updatehitmarker("standard", 1, var1, 0, 0);
      var0.fake_health -= var1;

      if(var0.fake_health <= 0) {
        break;
      }
    }
  }

  suicide_truct_explods(var0);
}

function suicide_truck_detonate_think(var0, var1) {
  var0 endon("death");
  wait_to_get_to_main_road(var0, var1);

  for(;;) {
    if(suicide_truck_should_detonate(var0)) {
      suicide_truct_explods(var0);
    }

    waitframe();
  }
}

function suicide_truct_explods(var0) {
  earthquake(0.5, 1.2, var0.origin, 400);
  playsoundatpos(var0.origin, "frag_grenade_expl_trans");
  playFX(level._effect["vfx_suicide_truck_explo"], var0.origin);
  scripts\cp\maps\cp_br_syrk\vehicle_travel::damage_nearby_players(var0, 80, 40000);
  scripts\cp\maps\cp_br_syrk\vehicle_travel::damage_nearby_vehicles(var0, 22500);
  var0 delete();
}

function suicide_truck_should_detonate(var0) {
  if(suicide_truck_ahead_of_player_humvee(var0)) {
    return true;
  }

  if(player_humvee_withn_explosion_range(var0)) {
    return true;
  }

  return false;
}

function player_humvee_withn_explosion_range(var0) {
  var1 = level.player_humvee.origin;

  if(distance2dsquared(var1, (0, 0, 0)) > 40000) {
    return (distance2dsquared(var0.origin, var1) < 40000);
  }

  return false;
}

function suicide_truck_ahead_of_player_humvee(var0) {
  var1 = level.player_humvee.origin;

  if(distance2dsquared(var1, (0, 0, 0)) > 40000) {
    var2 = var0 vehicle_getvelocity();
    var2 = (var2[0], var2[1], 0);
    var2 = vectorNormalize(var2);
    var3 = var1 - var0.origin;
    var3 = (var3[0], var3[1], 0);
    var3 = vectorNormalize(var3);
    var4 = vectordot(var2, var3);
    return (var4 < 0);
  }

  return false;
}

function other_bodyguard_vehicles_exist() {
  return level.hvt_bodyguard_vehicles.size > 0;
}

function other_blocker_vehicles_exist() {
  return level.blocker_vehicles.size > 0;
}

function bodyguard_vehicle_spawn_trigger_think(var0, var1) {
  level.enemy_hvt_vehicle endon("death");

  for(;;) {
    if(distance2dsquared(var0.origin, level.enemy_hvt_vehicle.origin) < 2250000) {
      break;
    }

    waitframe();
  }

  level notify(var1, var0.script_noteworthy);
}

function blocker_vehicle_spawn_trigger_think(var0, var1) {
  for(;;) {
    if(distance2dsquared(var0.origin, level.player_humvee.origin) < 2250000) {
      break;
    }

    waitframe();
  }

  level notify(var1, var0.script_noteworthy);
}

function bodyguard_vehicle_spawned_monitor() {
  level endon("game_ended");

  for(;;) {
    level waittill("vehicle_spawned", var0, var1);

    if(scripts\engine\utility::array_contains(level.hvt_bodyguard_vehicles, var1)) {
      continue;
    }

    switch (var0.group_name) {
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
        thread bodyguard_vehicle_think(var1);
        break;
    }
  }
}

function blocker_vehicle_spawned_monitor() {
  level endon("game_ended");

  for(;;) {
    level waittill("vehicle_spawned", var0, var1);

    if(scripts\engine\utility::array_contains(level.blocker_vehicles, var1)) {
      continue;
    }

    switch (var0.group_name) {
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
        thread blocker_vehicle_think(var1);
        break;
    }
  }
}

function bodyguard_vehicle_think(var0) {
  var0 endon("death");
  add_to_hvt_bodyguard_vehicles_array(var0);
  thread bodyguard_vehicle_death_monitor(var0);
  thread enemy_vehicle_damage_monitor(var0, var0);
  wait 1.5;
  change_riders_demeanor(var0);
  var0 notify("stop_vehicle_on_damage_internal");
  var0 notify("stop_waiting_for_spawns");
  thread follow_enemy_hvt_vehicle(var0);
  thread enemy_vehicle_no_rider_monitor(var0);
}

function blocker_vehicle_think(var0) {
  var0 endon("death");
  add_to_blocker_vehicles_array(var0);
  thread blocker_vehicle_death_monitor(var0);
  thread enemy_vehicle_damage_monitor(var0, var0);
  wait 1.5;
  change_riders_demeanor(var0);
  var0 notify("stop_vehicle_on_damage_internal");
  var0 notify("stop_waiting_for_spawns");
  thread enemy_vehicle_no_rider_monitor(var0);
  thread stay_in_front_of_player_vehicle(var0);
}

function change_riders_demeanor(var0) {
  foreach(var2 in var0.riders) {
    var2 scripts\common\utility::demeanor_override("combat");
  }
}

function enemy_vehicle_damage_monitor(var0, var1) {
  var0 endon("death");
  var0.health = 999999;
  var0.fake_health = var1;

  for(;;) {
    var0 waittill("damage", var2, var3, var4, var5, var6, var7, var8, var9, var10, var11);
    var0.health = 999999;

    if(isDefined(var2)) {
      var0.fake_health -= var2;

      if(var0.fake_health < 0) {
        enemy_vehicle_explodes(var0, var0);
      }
    }
  }
}

function enemy_vehicle_no_rider_monitor(var0) {
  var0 endon("death");
  var0 endon("vehicle_has_unload");

  foreach(var2 in var0.riders) {
    thread rider_death_monitor(var2, var2);
  }

  for(;;) {
    var0 waittill("a_rider_just_died");
    var4 = get_num_of_alive_riders(var0);

    if(var4 == 0) {
      enemy_vehicle_explodes(var0, var0);
    }
  }
}

function get_num_of_alive_riders(var0) {
  var1 = 0;

  foreach(var3 in var0.riders) {
    if(isai(var3) && isalive(var3)) {
      var1++;
    }
  }

  return var1;
}

function rider_death_monitor(var0, var1) {
  var0 waittill("death");
  var1 notify("a_rider_just_died");
}

function enemy_vehicle_explodes(var0) {
  foreach(var2 in var0.riders) {
    if(isai(var2) && isalive(var2)) {
      var2 unlink();
      var3 = vectorNormalize(var2.origin - var0.origin);
      var2 setvelocity(var3 * 1200);
      var2 dodamage(var2.health + 100, var2.origin);
    }
  }

  playFX(level._effect["bodyguard_vehicle_explosion"], var0.origin + (0, 0, 20));
  var0 delete();
}

function follow_enemy_hvt_vehicle(var0) {
  var0 endon("death");
  level.enemy_hvt_vehicle endon("death");

  if(!isDefined(level.enemy_hvt_vehicle)) {
    return;
  }

  var1 = level.enemy_hvt_vehicle;
  var0 vehicle_setspeedimmediate(65, 65, 65);

  for(;;) {
    if(vehicle_is_too_far_ahead(var0, var1, 1300)) {
      speed_up(var0, 65, 1);
    } else if(hvt_bodyguard_vehicle_should_speed_up(var0, var1)) {
      speed_up(var0, 65, 1);
    } else {
      slow_down(var0, 25, 4);
    }

    waitframe();
  }
}

function stay_in_front_of_player_vehicle(var0) {
  var0 endon("death");
  var0 vehicle_setspeedimmediate(75, 75, 75);
  wait_to_get_to_main_road(var0, scripts\engine\utility::getStruct(var0.group.group_name + "_target", "targetname"));

  for(;;) {
    if(getting_too_close_with_player_humvee(var0, level.player_humvee)) {
      speed_up(var0, 75, 2.5);
    } else {
      slow_down(var0, 0, 1);
    }

    waitframe();
  }
}

function delay_test_explodes(var0) {
  wait 5;
  enemy_vehicle_explodes(var0);
}

function wait_to_get_to_main_road(var0, var1) {
  for(;;) {
    if(distance2dsquared(var0.origin, var1.origin) < 90000) {
      return;
    }

    waitframe();
  }
}

function getting_too_close_with_player_humvee(var0, var1) {
  return distance2dsquared(var0.origin, var1.origin) < 2250000;
}

function hvt_bodyguard_vehicle_should_speed_up(var0, var1) {
  if(too_close_to_other_bodyguard_vehicle_in_front(var0)) {
    return 0;
  }

  var2 = var0 vehicle_getvelocity();
  var2 = (var2[0], var2[1], 0);
  var2 = vectorNormalize(var2);
  var3 = var1.origin - var0.origin;
  var3 = (var3[0], var3[1], 0);
  var3 = vectorNormalize(var3);
  var4 = vectordot(var2, var3);
  var5 = acos(var4);

  if(var5 < get_desired_bodyguard_vehicle_angle(var0)) {
    return 1;
  }

  return 0;
}

function too_close_to_other_bodyguard_vehicle_in_front(var0) {
  var1 = get_other_bodyguard_vehicles_in_front(var0);

  foreach(var3 in var1) {
    if(distance2dsquared(var0.origin, var3.origin) <= 250000) {
      return true;
    }
  }

  return false;
}

function get_other_bodyguard_vehicles_in_front(var0) {
  var1 = [];
  var2 = var0 vehicle_getvelocity();

  foreach(var4 in level.hvt_bodyguard_vehicles) {
    if(var4 == var0) {
      continue;
    }

    var5 = var4.origin - var0.origin;

    if(vectordot(var5, var2) < 0) {
      continue;
    }

    var1 = var4;
  }

  return var1;
}

function too_close_to_other_blocker_vehicle_in_front(var0) {
  var1 = get_other_blocker_vehicles_in_front(var0);

  foreach(var3 in var1) {
    if(distance2dsquared(var0.origin, var3.origin) <= 250000) {
      return true;
    }
  }

  return false;
}

function get_other_blocker_vehicles_in_front(var0) {
  var1 = [];
  var2 = var0 vehicle_getvelocity();

  foreach(var4 in level.blocker_vehicles) {
    if(var4 == var0) {
      continue;
    }

    var5 = var4.origin - var0.origin;

    if(vectordot(var5, var2) < 0) {
      continue;
    }

    var1 = var4;
  }

  return var1;
}

function get_desired_bodyguard_vehicle_angle(var0) {
  switch (level.hvt_bodyguard_vehicles.size) {
    case 1:
      return 90;
    case 2:
      switch (var0.bodyguard_vehicle_id) {
        case 1:
          return 135;
        case 2:
          return 90;
      }
    case 3:
      switch (var0.bodyguard_vehicle_id) {
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

function add_to_blocker_vehicles_array(var0) {
  level.blocker_vehicles = scripts\engine\utility::array_add(level.blocker_vehicles, var0);
}

function add_to_hvt_bodyguard_vehicles_array(var0) {
  level.hvt_bodyguard_vehicles = scripts\engine\utility::array_add(level.hvt_bodyguard_vehicles, var0);
  var0.bodyguard_vehicle_id = level.hvt_bodyguard_vehicles.size;
}

function bodyguard_vehicle_death_monitor(var0) {
  var0 waittill("death");
  var1 = var0.bodyguard_vehicle_id;
  level.hvt_bodyguard_vehicles = scripts\engine\utility::array_remove(level.hvt_bodyguard_vehicles, var0);
  reassign_bodyguard_vehicle_id(var1);
}

function blocker_vehicle_death_monitor(var0) {
  var0 waittill("death");
  level.blocker_vehicles = scripts\engine\utility::array_remove(level.blocker_vehicles, var0);
}

function reassign_bodyguard_vehicle_id(var0) {
  foreach(var2 in level.hvt_bodyguard_vehicles) {
    if(var2.bodyguard_vehicle_id > var0) {
      var2.bodyguard_vehicle_id--;
    }
  }
}

function enemy_hvt_vehicle_damage_monitor(var0) {
  var0 endon("death");
  var0 setCanDamage(1);
  var0.health = 999999;

  for(;;) {
    var0 waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);
    var0.health = 999999;
  }
}

function deploy_concrtete_blockers_for_puzzle() {
  var0 = scripts\engine\utility::getStructArray("concrete_blocker_controlling_struct", "script_noteworthy");

  foreach(var2 in var0) {
    process_concrete_blocker_controlling_struct(var2);
    waitframe();
  }
}

function process_concrete_blocker_controlling_struct(var0) {
  process_linked_structs(var0);
  set_up_concrete_blockers(var0);
  set_up_sight_blockers(var0);
}

function process_linked_structs(var0) {
  var0.num_of_concrete_blocks = int(var0.script_parameters);
  var1 = [];
  var2 = [];
  var3 = scripts\engine\utility::getStructArray(var0.target, "targetname");

  foreach(var5 in var3) {
    switch (var5.script_noteworthy) {
      case "concrete_blocker_marker":
        var1 = var5;
        break;
      case "sight_blocker_marker":
        var2 = var5;
        break;
    }
  }

  var0.concrete_blocker_markers = var1;
  var0.sight_blocker_markers = var2;
}

function set_up_concrete_blockers(var0) {
  var1 = var0.concrete_blocker_markers;

  for(var2 = 0; var2 < 5; var2++) {
    var1 = scripts\engine\utility::array_randomize(var1);
  }

  var3 = var0.num_of_concrete_blocks;

  for(var4 = 0; var4 < var3; var4++) {
    var5 = var1[var4];
    var6 = spawn("script_model", var5.origin);
    var6 setModel("barrier_traffic_concrete_block_01");
    var6.angles = var5.angles;
  }
}

function set_up_sight_blockers(var0) {
  var1 = [];

  foreach(var3 in var0.sight_blocker_markers) {
    var4 = spawn("script_model", var3.origin);
    var4 setModel("fence_corrugated_metal_03_256_cp");
    var4.angles = var3.angles;
    var1 = var4;
  }

  var0.sight_blocker_models = var1;
}

function enemy_hvt_boss_watcher(var0) {
  var1 = self;
  var1.health = 9999;
  var1.maxhealth = 9999;
  var1.dontevershoot = 1;
  var1.invulnerable = 1;
  var1 scripts\engine\utility::ent_flag_init("stop_combat");
  thread delay_demeanor_override(var1);
  thread hvt_boss_damage_monitor(var1);
  thread hvt_boss_combat_think(var1);
  var2 = spawn("script_model", var1 gettagorigin("tag_eye"));
  var2 setModel("tag_origin");
  var2.angles = var1 getplayerangles();
  var2 linkTo(var1);
  var1.hvt_boss_laser_tag = var2;
  var3 = spawn("script_model", var1.origin);
  var3 setModel("tag_origin");
  var3.angles = var1 getplayerangles();
  var1.hvt_boss_mover = var3;
  var1 linkTo(var3, "tag_origin");
  thread hvt_boss_mover_follow_enemy_hvt_vehicle(var3);
  thread hvt_boss_mover_face_player_humvee(var3);
  thread hvt_boss_clean_up_think(var1);
}

function delay_demeanor_override(var0) {
  var0 endon("death");
  waitframe();
  var0 scripts\common\utility::demeanor_override("patrol");
  var0 allowedstances("crouch");
}

function hvt_boss_mover_follow_enemy_hvt_vehicle(var0) {
  var0 endon("death");
  level.enemy_hvt_vehicle endon("death");
  var1 = level.enemy_hvt_vehicle;
  var0.enemy_hvt_mover_vertical_offset = -71;

  for(;;) {
    var2 = var1 gettagorigin("tag_turret");
    var3 = var1 vehicle_getvelocity();
    var3 = (var3[0], var3[1], 0);
    var3 *= 0.05;
    var0.origin = var2 + (0, 0, var0.enemy_hvt_mover_vertical_offset) + var3;
    waitframe();
  }
}

function hvt_boss_combat_think(var0) {
  var0 endon("death");
  wait randomfloatrange(7, 15);
  hvt_boss_do_combat(var0);
  scripts\engine\utility::flag_wait("hvt_boss_combat_stage_two");
  hvt_boss_do_combat(var0);
  scripts\engine\utility::flag_wait("hvt_boss_combat_stage_three");
  hvt_boss_do_combat(var0);
  thread play_coop_vehicle_race_successs();
  var0.invulnerable = 0;
  var0 dodamage(var0.health + 100, var0.origin);
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

function hvt_boss_do_combat(var0) {
  var0 scripts\engine\utility::ent_flag_clear("stop_combat");

  for(;;) {
    if(player_humvee_is_within_combar_range()) {
      hvt_boss_move_to_target_vertical_offset(var0, -45);
      var0.invulnerable = 0;
      var0 scripts\common\utility::demeanor_override("combat");
      var0 waittill("exposed_stand_to_crouch_finished");
      hvt_boss_move_to_target_vertical_offset(var0, -25);

      if(isDefined(level.enemy_hvt_vehicle.damage_state) && level.enemy_hvt_vehicle.damage_state == 3) {
        return;
      }

      wait 1;

      if(!var0 scripts\engine\utility::ent_flag("stop_combat")) {
        var1 = level.enemy_hvt_vehicle;
        var2 = var1 vehicle_getvelocity();
        var2 = (var2[0], var2[1], 0);
        var2 *= 0.95;
        var3 = anglesToForward(var0 getplayerangles());
        var4 = var0 gettagorigin("j_wrist_le") + var3 * 20 + var2;
        var5 = level.player_humvee vehicle_getvelocity();
        var6 = anglesToForward(level.player_humvee.angles);
        var7 = level.player_humvee.origin + (0, 0, 40) + var6 * var1.player_humvee_speed * 25;
        var8 = magicbullet("rpg_missile_cp", var4, var7);
        thread delay_play_ignition_vfx(var8);
      }

      var0.invulnerable = 1;

      if(isDefined(level.enemy_hvt_vehicle.damage_state) && level.enemy_hvt_vehicle.damage_state == 3) {
        return;
      }

      var0 scripts\common\utility::demeanor_override("patrol");
      hvt_boss_move_to_target_vertical_offset(var0, -71);
      wait randomfloatrange(3, 6);

      if(var0 scripts\engine\utility::ent_flag("stop_combat")) {
        return;
      }
    }

    wait randomfloatrange(0.5, 1);

    if(var0 scripts\engine\utility::ent_flag("stop_combat")) {
      return;
    }
  }
}

function do_laser_target_on_player_humvee(var0) {
  var1 = int(60);

  for(var2 = 0; var2 < var1; var2++) {
    var3 = var0 gettagorigin("tag_eye");
    var4 = level.player_humvee vehicle_getvelocity();
    var5 = level.player_humvee.origin + (0, 0, 80) + var4 * 0.01;
    var6 = var5 - var3;
    var7 = vectortoangles(var6);
    playfxbetweenpoints(level._effect["hvt_target_laser"], var3, var7, var5);
    var8 = var0 scripts\engine\utility::ref_143b9(0.05, "damage");

    if(var8 == "damage") {
      return "fail";
    }
  }

  return "success";
}

function get_target_laser_angles(var0) {
  var1 = var0 gettagorigin("tag_eye");
  var2 = level.player_humvee.origin + (0, 0, 50);
  var3 = var2 - var1;
  return vectortoangles(var3);
}

function switch_to_guiding_missile(var0) {
  var1 = var0.origin;
  var0 delete();
  var2 = level.enemy_hvt_vehicle;
  var3 = var2 vehicle_getvelocity();
  var3 = (var3[0], var3[1], 0);
  var3 *= 0.95;
  var1 += var3;
  var4 = level.player_humvee;
  var5 = magicbullet("juliet_missile_cp", var1, var4.origin);
  var5 missile_settargetEnt(var4);
  var5 missile_setflightmodetop();
  thread delay_play_ignition_vfx(var5);
}

function delay_play_ignition_vfx(var0) {
  var0 endon("death");
  wait 0.1;
  playFXOnTag(level._effect["javelin_ignition"], var0, "tag_fx");
}

function hvt_boss_move_to_target_vertical_offset(var0, var1) {
  var2 = var1 - var0.hvt_boss_mover.enemy_hvt_mover_vertical_offset;
  var3 = abs(var2) / 1;

  for(var4 = 0; var4 < var3; var4++) {
    if(var1 >= var0.hvt_boss_mover.enemy_hvt_mover_vertical_offset) {
      var0.hvt_boss_mover.enemy_hvt_mover_vertical_offset += 1;
    } else {
      var0.hvt_boss_mover.enemy_hvt_mover_vertical_offset -= 1;
    }

    waitframe();
  }
}

function player_humvee_is_within_combar_range() {
  var0 = level.enemy_hvt_vehicle;
  var1 = level.player_humvee;

  if(distance2dsquared(level.player_humvee.origin, (0, 0, 0)) < 40000) {
    return false;
  }

  return distance2dsquared(var0.origin, var1.origin) < 25000000;
}

function hvt_boss_mover_face_player_humvee(var0) {
  var0 endon("death");

  for(;;) {
    var1 = level.player_humvee.origin - var0.origin;
    var1 = (var1[0], var1[1], 0);
    var1 = vectorNormalize(var1);
    var0.angles = vectortoangles(var1);
    waitframe();
  }
}

function hvt_boss_clean_up_think(var0) {
  var0 waittill("death");

  if(isDefined(var0.hvt_boss_mover)) {
    var0.hvt_boss_mover delete();
  }

  if(isDefined(var0.hvt_boss_laser_tag)) {
    var0.hvt_boss_laser_tag delete();
    return;
  }
}

function hvt_boss_damage_monitor(var0) {
  var0 endon("death");

  for(;;) {
    var0 waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);
    var0.health = 9999;
    var0.maxhealth = 9999;

    if(istrue(var0.invulnerable)) {
      continue;
    }

    var11 = get_attacker_as_player(var2);

    if(isDefined(var11)) {
      var0.invulnerable = 1;
      playsoundatpos(var0.origin, "frag_grenade_expl_trans");
      playFX(level._effect["hvt_boss_rpg_explosion"], var0.origin);
      enemy_hvt_vehicle_damage_state();
      var0 scripts\engine\utility::ent_flag_set("stop_combat");
      thread delay_update_damagefeedback(var11);
    }
  }
}

function get_attacker_as_player(var0) {
  if(isPlayer(var0)) {
    return var0;
  }

  if(isPlayer(var0.owner)) {
    return var0.owner;
  }

  return undefined;
}

function delay_update_damagefeedback(var0) {
  var0 endon("disconnect");
  waittillframeend();

  if(isDefined(level.enemy_hvt_vehicle.damage_state) && level.enemy_hvt_vehicle.damage_state == 3) {
    var0 thread scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical", 1);
    return;
  }

  var0 thread scripts\cp\cp_damagefeedback::updatedamagefeedback("standard");
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
  var0 = ["tag_wheel_center_front_left", "tag_wheel_center_middle_left", "tag_wheel_center_back_left", "tag_wheel_center_front_right", "tag_wheel_center_middle_right", "tag_wheel_center_back_right", "rear_hatch_jnt", "drivers_hatch_jnt"];

  for(;;) {
    var1 = scripts\engine\utility::random(var0);
    playFXOnTag(level._effect["hvt_vehicle_armor_explosion"], level.enemy_hvt_vehicle, var1);
    wait randomfloatrange(0.15, 0.35);
  }
}

function track_player_humvee_speed_monitor(var0) {
  var0 endon("death");
  var1 = level.player_humvee;

  for(var2 = var1.origin;; var2 = var3) {
    waitframe();
    var3 = var1.origin;
    var4 = length(var3 - var2);
    var0.player_humvee_speed = var4;
  }
}

function start_combat_marker_think(var0) {
  level.enemy_hvt_vehicle endon("death");
  var1 = scripts\engine\utility::getStructArray("hvt_boss_combat_marker", "targetname");

  foreach(var3 in var1) {
    thread hvt_combat_start_marker_think(var3);
  }
}

function hvt_combat_start_marker_think(var0) {
  level.enemy_hvt_vehicle endon("death");

  for(;;) {
    if(distance2dsquared(var0.origin, level.enemy_hvt_vehicle.origin) < 2250000) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set(var0.script_noteworthy);
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