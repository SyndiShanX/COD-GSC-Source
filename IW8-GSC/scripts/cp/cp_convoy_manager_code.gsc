/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_convoy_manager_code.gsc
*************************************************/

function spawn_convoy(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  wait 0.05;

  if(!isDefined(level.vehicle_all_stop_func)) {
    level.vehicle_all_stop_func = &stop_all_convoy_cars;
  }

  var_8 = undefined;
  var_9 = undefined;

  if(isstruct(var_2)) {
    var_10 = strtok(var_2.targetname, "_");
    var_10 = scripts\engine\utility::array_remove(var_10, var_10[0]);
    var_10 = scripts\engine\utility::array_remove(var_10, var_10[0]);
    var_11 = "";

    for(var_12 = 0; var_12 < var_10.size; var_12++) {
      if(var_12 > 0) {
        var_11 += "_";
      }

      var_11 += var_10[var_12];
    }

    var_2 = var_11;
    var_13 = spawnStruct();
    var_13.targetname = "convoy_start_" + var_2;
  }

  var_8 = "convoy_spawner_" + var_2;
  var_9 = scripts\engine\utility::getStruct(var_8, "targetname");
  var_14 = scripts\engine\utility::getStruct("convoy_start_" + var_2, "targetname");

  if(!isDefined(var_9)) {
    var_9 = spawnStruct();
    var_9.classname_mp = "script_vehicle_iw8_truck_techo_white";
    var_9.lookahead = 1;
    var_9.script_modelname = "veh8_civ_lnd_techo_physics_mp";
    var_9.speed = 30;
    var_9.targetname = var_8;
    var_9.origin = var_14.origin;
  }

  var_15 = spawnStruct();
  var_15.name = var_0;
  var_15.type = var_1;
  var_15.spawner = var_9;
  var_15.nodefaultweapon = 1;
  var_15.spawned_vehicles = [];
  var_15.alive_support_vehicles = 0;
  var_15.using_path = var_2;
  var_15.not_compromised = 1;
  var_15.backup_spawned = 0;
  var_15.amount_to_compromise_left = -1;
  var_15.team = scripts\engine\utility::ter_op(isDefined(var_6), var_6, "axis");
  var_15.cp_speed = scripts\engine\utility::ter_op(isDefined(var_7), var_7, 300);

  if(isDefined(var_5)) {
    var_15.eventname = var_5;
  } else {
    var_15.eventname = "";
  }

  var_15.targeted_hvt = undefined;
  var_15.settings = spawnStruct();
  var_15.settings.target = undefined;
  var_15.settings.can_steal_hvt = 1;
  var_15.settings.can_pickup_hvt = 1;
  var_15.settings.hide_icon_on_pickup = 0;
  var_15.settings.lookahead = -500;
  var_15.settings.unload_at_target = 0;
  var_15.settings.roaming = 0;
  var_15.settings.attach_icon = 0;
  var_15.settings.show_health = 0;
  var_15.settings.ref_13898 = 0;
  var_15.settings.amount_to_compromise = -1;
  var_15.settings.center_compromises = 1;
  var_15.settings.can_compromise_before_first_target = 0;
  var_15.settings.health_drain = -1;
  var_15.settings.long_low_health = 0;
  var_15.settings.toggle_vo_on_hvt_pickup = 0;
  var_15.settings.toggle_vo_on_hvt_rescued = 0;
  var_15.settings.toggle_vo_on_convoy_death = 0;
  var_15.settings.toggle_vo_on_nearby_convoy = 0;
  var_15.settings.recruit_enable = 1;
  var_15.settings.recruit_juggs = 1;
  var_15.settings.recruit_time_between = 3;
  var_15.settings.recruit_time_until = 12;
  var_15.settings.recruit_amount = 5;
  var_15.settings.recruit_distance = 4000;
  var_15.settings.goal_distance = 1000;
  var_15.settings.pickup_uses_origin = 0;
  var_15.settings.defeated_on_kill_backup = 0;
  var_15.settings.backup_deposit_names = undefined;
  var_15.settings.route_to_any_veh = 1;
  var_15.settings.route_to_other_veh = 1;
  var_15.settings.route_to_other_support_veh = 1;
  var_15.settings.enable_stop_all_cars = 1;
  var_15.settings.path_jitter = undefined;
  var_15.settings.use_path_speeds = undefined;
  var_15.settings.despawn_dist = 7000;
  var_15.settings.despawn_dist_enable = 1;
  var_15.settings.distance_z = -1;
  var_15.settings.suspend_at_end_path = undefined;
  var_15.convoy_objectivestruct = var_3;
  add_convoy_to_level(level, var_15);
  level thread scripts\cp\cp_vehicle_turretdrone::process_turret_sweep_nodes(var_15.using_path);
  thread allow_soldiers_attempt_take_target(level);
  spawn_convoy_from_type(level, var_15);
  thread waittillconvoydead();
  thread waittill_return_to_truck(level, var_15.using_path);

  if(isDefined(var_4)) {
    thread kill_convoy_all(level, var_15);
  }

  var_15 notify("event_convoy_spawned");
  level notify("new_convoy_spawned");
  return var_15;
}

function spawn_convoy_from_type(var_0) {
  if(!isDefined(var_0)) {
    var_1 = "convoy_spawner_" + var_0.using_path;
    var_0 = scripts\engine\utility::getStruct(var_1, "targetname");
  }

  if(isDefined(getvehiclenode("convoy_start_" + var_0.using_path, "targetname"))) {
    var_2 = getvehiclenodearray("convoy_start_" + var_0.using_path, "targetname");
  } else {
    var_2 = scripts\engine\utility::getStructArray("convoy_start_" + var_2.using_path, "targetname");
  }

  if(var_2.size > 1) {}

  var_3 = 1;

  if(isDefined(level.convoy_speed_override)) {
    var_3 = 30 / level.convoy_speed_override;
  }

  switch (var_2.type) {
    case "medium":
      var_4 = thread create_convoy_truck(var_2, "techo", 1, "soldier_armored_helmet", 1, "price", "minigun_mp", var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_5 = thread create_convoy_truck(var_2, "techo", 1, "soldier_armored_helmet", 1, "price", "minigun_mp", var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_6 = thread create_convoy_truck(var_2, "mkilo", 0, undefined, 9, "price", undefined, var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_7 = thread create_convoy_truck(var_2, "techo", 1, "soldier_armored_helmet", 1, "price", "minigun_mp", var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_7.spawned_after_convoy_center = 1;
      var_8 = thread create_convoy_truck(var_2, "techo", 1, "soldier_armored_helmet", 1, "price", "minigun_mp", var_2[0]);
      var_2.vehicles_remaining = 5;
      break;
    case "medium-roaming":
      var_4 = thread create_convoy_truck(var_2, "techo", 2, "soldier_armored_helmet", 1, "price", "minigun_mp", var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_5 = thread create_convoy_truck(var_2, "techo", 2, "soldier_armored_helmet", 1, "price", "minigun_mp", var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_6 = thread create_convoy_truck(var_2, "mkilo-notarp", 3, "soldier_armored_helmet", 1, "price", undefined, var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_7 = thread create_convoy_truck(var_2, "techo", 2, "soldier_armored_helmet", 1, "price", "minigun_mp", var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_8 = thread create_convoy_truck(var_2, "techo", 2, "soldier_armored_helmet", 1, "price", "minigun_mp", var_2[0]);
      var_2.vehicles_remaining = 5;
      break;
    case "small":
      var_4 = thread create_convoy_truck(var_2, "techo", 0, "soldier_armored_helmet", 1, "price", "minigun_mp", var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_6 = thread create_convoy_truck(var_2, "mkilo", 0, undefined, 4, "price", undefined, var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_5 = thread create_convoy_truck(var_2, "techo", 0, "soldier_armored_helmet", 1, "price", "minigun_mp", var_2[0]);
      var_2.vehicles_remaining = 3;
      break;
    case "small-roaming":
      var_4 = thread create_convoy_truck(var_2, "techo", 3, "soldier_armored_helmet", 1, "price", "minigun_mp", var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_6 = thread create_convoy_truck(var_2, "mkilo-notarp", 3, "soldier_armored_helmet", 1, "price", undefined, var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_5 = thread create_convoy_truck(var_2, "techo", 3, "soldier_armored_helmet", 1, "price", "minigun_mp", var_2[0]);
      var_2.vehicles_remaining = 3;
      break;
    case "small-roaming-stealing":
      var_2.settings.ref_13898 = 1;
      var_4 = thread create_convoy_truck(var_2, "techo", 2, "soldier_armored_helmet", 1, "price", undefined, var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_6 = thread create_convoy_truck(var_2, "mkilo-notarp", 0, "soldier_armored_helmet", 1, "price", undefined, var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_5 = thread create_convoy_truck(var_2, "techo", 2, "soldier_armored_helmet", 1, "price", undefined, var_2[0]);
      var_2.vehicles_remaining = 3;
      break;
    case "small-danger-roaming":
      var_4 = thread create_convoy_truck(var_2, "techo", 3, "soldier_armored_helmet", 1, "price", "minigun_mp", var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_6 = thread create_convoy_truck(var_2, "mkilo-notarp", 3, "soldier_armored_helmet", 1, "price", "wheelson_manned", var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_5 = thread create_convoy_truck(var_2, "techo", 3, "soldier_armored_helmet", 1, "price", "minigun_mp", var_2[0]);
      var_2.vehicles_remaining = 3;
      break;
    case "single":
      var_4 = thread create_convoy_truck(var_2, "techo", 0, "soldier_armored_helmet", 1, "price", undefined, var_2[0]);
      var_2.vehicles_remaining = 1;
      break;
    case "single-empty":
      var_4 = thread create_convoy_truck(var_2, "techo", 0, "soldier_armored_helmet", 0, "price", undefined, var_2[0]);
      var_2.vehicles_remaining = 1;
      break;
    case "single-mkilo":
      var_6 = thread create_convoy_truck(var_2, "mkilo-notarp", 3, "soldier_armored_helmet", 1, "price", undefined, var_2[0]);
      var_2.vehicles_remaining = 1;
      break;
    case "single-techo-turret":
      var_4 = thread create_convoy_truck(var_2, "techo", 2, "soldier_armored_helmet", 1, "price", "minigun_mp", var_2[0]);
      var_2.vehicles_remaining = 1;
      break;
    case "double-techo-turret":
      var_4 = thread create_convoy_truck(var_2, "techo", 2, "soldier_armored_helmet", 1, "price", "minigun_mp", var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_5 = thread create_convoy_truck(var_2, "techo", 2, "soldier_armored_helmet", 1, "price", "minigun_mp", var_2[0]);
      var_2.vehicles_remaining = 2;
      break;
    case "double-techo":
      var_4 = thread create_convoy_truck(var_2, "techo", 2, "soldier_armored_helmet", 1, "price", undefined, var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_5 = thread create_convoy_truck(var_2, "techo", 2, "soldier_armored_helmet", 1, "price", undefined, var_2[0]);
      var_5.spawned_after_convoy_center = 1;
      var_2.vehicles_remaining = 2;
      break;
    case "triple-techo-turret":
      var_4 = thread create_convoy_truck(var_2, "techo", 2, "soldier_armored_helmet", 1, "price", "minigun_mp", var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_5 = thread create_convoy_truck(var_2, "techo", 2, "soldier_armored_helmet", 1, "price", "minigun_mp", var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_7 = thread create_convoy_truck(var_2, "techo", 2, "soldier_armored_helmet", 1, "price", "minigun_mp", var_2[0]);
      var_7.spawned_after_convoy_center = 1;
      var_2.vehicles_remaining = 3;
      break;
    case "apc-payload-type":
      var_4 = thread create_convoy_truck(var_2, "apc", 0, "soldier_armored_helmet", 1, "price", undefined, var_2[0]);
      var_2.vehicles_remaining = 1;
      break;
    case "decho_getaway":
      var_6 = thread create_convoy_truck(var_2, "decho", 0, "soldier_armored_helmet", 0, "price", undefined, var_2[0]);
      var_2.vehicles_remaining = 1;
      break;
    case "convoyescort-type":
      var_3 = 0.95;
      var_4 = thread create_convoy_truck(var_2, "techo", 0, "soldier_armored_helmet", 1, "price", undefined, var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_5 = thread create_convoy_truck(var_2, "techo", 0, "soldier_armored_helmet", 1, "price", undefined, var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_7 = thread create_convoy_truck(var_2, "techo", 0, "soldier_armored_helmet", 1, "price", undefined, var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_8 = thread create_convoy_truck(var_2, "techo", 0, "soldier_armored_helmet", 1, "price", undefined, var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_9 = thread create_convoy_truck(var_2, "techo", 0, "soldier_armored_helmet", 1, "price", undefined, var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_10 = thread create_convoy_truck(var_2, "techo", 0, "soldier_armored_helmet", 1, "price", undefined, var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_11 = thread create_convoy_truck(var_2, "techo", 0, "soldier_armored_helmet", 1, "price", undefined, var_2[0]);
      var_9.spawned_after_convoy_center = 1;
      var_10.spawned_after_convoy_center = 1;
      var_11.spawned_after_convoy_center = 1;
      var_2.vehicles_remaining = 7;
      break;
    case "single-techo-cargo":
      var_4 = thread create_convoy_truck(var_2, "techo-cargo", 5, "soldier_armored_helmet", 1, "price", undefined, var_2[0]);
      var_2.vehicles_remaining = 1;
      break;
    case "double-techo-cargo":
      var_4 = thread create_convoy_truck(var_2, "techo-cargo", 5, "soldier_armored_helmet", 1, "price", undefined, var_2[0]);
      wait randomfloatrange(2.75, 4.55) * var_3;
      var_5 = thread create_convoy_truck(var_2, "techo-cargo", 5, "soldier_armored_helmet", 1, "price", undefined, var_2[0]);
      var_5.spawned_after_convoy_center = 1;
      var_2.vehicles_remaining = 2;
      break;
    default:
      break;
  }
}

function create_convoy_truck(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_0)) {
    return;
  }

  var_10 = undefined;

  switch (var_1) {
    case "decho":
      var_10 = spawn_convoy_decho(var_0);
      break;
    case "techo-cargo":
    case "techo":
      var_10 = spawn_convoy_truck(var_0);
      break;
    case "umike":
    case "apc":
      var_10 = spawn_convoy_apc(var_0);
      break;
    case "mkilo":
      var_10 = spawn_convoy_mkilo23(var_0);
      var_10.guys_assigned = 0;
      break;
    case "mkilo-notarp":
      var_10 = spawn_convoy_mkilo23(var_0, 1);
      var_10.guys_assigned = 0;
      break;
    default:
      break;
  }

  if(!isDefined(var_1)) {
    return;
  }

  if(istrue(var_0.settings.ref_13898)) {
    var_10.ref_13898 = 1;
  }

  if(isDefined(var_0.main_truck) && var_10 != var_0.main_truck) {
    var_10.spawned_after_convoy_center = 1;
  } else {
    var_10.spawned_after_convoy_center = 0;
  }

  var_10 scripts\engine\utility::ent_flag_init("driver_spawned");

  if(isDefined(var_2) && var_2 > 0) {
    if(isDefined(var_3)) {
      var_0.spawner.script_noteworthy = var_3;
    } else {
      var_0.spawner.script_noteworthy = "soldier_armored_helmet";
    }

    if(var_1 == "techo") {
      thread trial_start_time(var_10);
    } else if(var_1 == "techo-cargo") {
      thread trial_stat_row();
    }

    thread ref_135DA(level, var_10, var_2);
  }

  thread killoff_vis_passed(var_10);

  if(isDefined(var_4) && var_4 > 0) {
    var_11 = "";

    switch (var_1) {
      case "techo-cargo":
      case "techo":
        var_11 = "techo_phys";
        break;
      case "mkilo-notarp":
      case "mkilo":
        var_11 = "mkilo23_ai_infil";
        break;
    }

    level thread scripts\cp\cp_vehicles::ref_135CB(var_10, var_11);
    var_10 scripts\engine\utility::ent_flag_set("driver_spawned");
    thread wait_to_deposit_driver(level);
  }

  if(isDefined(var_7)) {
    thread trial_retrieve_persistent_values(var_10, var_7, var_0);
  }

  var_10.measure_origin = var_10.origin;

  if(!isDefined(var_0.using_path)) {
    return;
  } else {
    thread convoy_vehicle_monitor(var_10, var_0.using_path);
  }

  if(isDefined(var_6) && var_6 != "") {
    thread ref_135E2(var_10);
  }

  return var_10;
}

function ref_135E2(var_0) {
  var_0.computerscriptable = 1;
  var_0.zombiejumping = [];
  var_1 = (-62, 0, 45);
  var_2 = level scripts\cp\cp_vehicles::spawn_ai_in_truck(var_0, 1, undefined, 0, undefined, "lmg_heavy", 5);

  if(isDefined(var_2) && var_2.size > 0) {
    var_2[0].equip_armor = 1;
    var_2[0].equip_helmet = 1;
    var_2[0].maxhealth = 600;
    var_2[0].health = 600;
    var_2[0].i_see_laststand_player_watcher = 1;
    var_0.zombiejumping[0] = var_2[0];
  }

  var_3 = (-92, 0, 60);
  var_4 = level scripts\cp\cp_vehicles::spawn_ai_in_truck(var_0, 1, undefined, 0, undefined, "lmg_heavy", 6);

  if(isDefined(var_4) && var_4.size > 0) {
    var_4[0].equip_armor = 1;
    var_4[0].equip_helmet = 1;
    var_4[0].maxhealth = 600;
    var_4[0].health = 600;
    var_4[0].i_see_laststand_player_watcher = 1;
    var_0.zombiejumping[1] = var_4[0];
  }

  wait 5;
  var_0.computerscriptable = undefined;
}

function ref_135DA(var_0, var_1, var_2) {
  level thread scripts\cp\cp_vehicles::spawn_ai_in_truck(var_0, var_1, var_2.spawner, 0, undefined);
}

function trial_start_time(var_0) {
  level endon("game_ended");
  self endon("death");

  if(self.type != "techo") {
    return;
  }

  self waittill("stop_follow_path");
  var_1 = "entirecab";

  if(isDefined(var_0) && isDefined(var_0.settings.ref_13F14)) {
    var_1 = var_0.settings.ref_13F14;
  }

  scripts\common\vehicle::vehicle_unload(var_1);
}

function trial_stat_row() {
  level endon("game_ended");
  self endon("death");

  if(self.type != "techo-cargo") {
    return;
  }

  self waittill("stop_follow_path");
  level scripts\cp\cp_vehicles::lastteamused(self);
  scripts\common\vehicle::vehicle_unload("default");
}

function wait_to_deposit_driver(var_0) {
  level endon("game_ended");
  var_0 endon("event_convoy_delete");
  var_0 waittill("able_to_deposit_driver");

  for(var_1 = 0; var_1 < var_0.spawned_vehicles.size; var_1++) {
    if(isDefined(var_0.spawned_vehicles[var_1]) && isalive(var_0.spawned_vehicles[var_1])) {
      var_0.spawned_vehicles[var_1] thread scripts\cp\cp_vehicles::deposit_ai_from_drones_in_vehicle(1, 0);
    }
  }
}

function killoff_vis_passed(var_0) {
  var_0 endon("death");
  wait 15;
  var_0.nav_obstacle = createnavrepulsor("ai_vehicle", 0, var_0, 150, 1);
}

function trial_retrieve_persistent_values(var_0, var_1, var_2) {
  var_0 endon("death");

  if(isDefined(level.convoy_speed_override)) {
    var_0.speed_override = level.convoy_speed_override;
  } else {
    var_0.speed_override = 30;
  }

  var_3 = var_1;
  var_0.pathing_array = [];
  var_0.pathing_array[var_0.pathing_array.size] = var_1;
  var_3.pathing_index = var_0.pathing_array.size;

  while(isDefined(var_3) && isDefined(var_3.target)) {
    var_3 = scripts\engine\utility::getStruct(var_3.target, "targetname");
    var_3.pathing_index = var_0.pathing_array.size;
    var_0.pathing_array[var_0.pathing_array.size] = var_3;
  }

  if(var_0.pathing_array.size > 27) {
    var_0 scripts\cp\cp_vehicles::split_large_pathing_array();
  }

  if(isDefined(level.convoy_path_jitter) && level.convoy_path_jitter > 0) {
    var_2.settings.path_jitter = level.convoy_path_jitter;
  }

  if(!isDefined(var_0.pathing_arrays)) {
    var_4 = var_0.pathing_array;
  } else {
    var_4 = var_1.pathing_arrays;
  }

  var_1 thread scripts\cp\cp_vehicles::vehiclefollowstructpath(var_4);
  thread intro_stop_car_if_too_close(var_1, var_1);
}

function intro_stop_car_if_too_close(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("stop_follow_path");
  var_2 = 650;
  var_3 = var_2 * var_2;

  if(istrue(var_0.spawned_after_convoy_center)) {
    for(;;) {
      if(isent(var_1.main_truck) && isent(var_0)) {
        if(distancesquared(var_1.main_truck.origin, var_0.origin) < var_3) {
          var_0 vehicle_setspeed(0, 70, 70);
          var_0 notify("stop_follow_path");
        }
      }

      wait 0.25;
    }

    return;
  }
}

function add_convoy_to_level(var_0) {
  if(!isDefined(level.all_convoys)) {
    level.all_convoys = [];
  }

  if(isDefined(level.all_convoys[var_0.name])) {
    thread kill_convoy_all(level, level.all_convoys[var_0.name]);
    wait 0.05;
  }

  level.all_convoys[var_0.name] = var_0;
}

function remove_convoy_from_level(var_0) {
  if(!isDefined(level.all_convoys)) {
    return;
  }

  if(!isDefined(level.all_convoys[var_0.name])) {
    return;
  }

  if(isDefined(var_0.saved_struct_paths)) {
    var_1 = var_0.saved_struct_paths.size;

    for(var_2 = 0; var_2 < var_1; var_2++) {
      scripts\engine\utility::deletestruct_ref(var_0.saved_struct_paths[var_2]);
      var_0.saved_struct_paths[var_2] = undefined;
    }
  }

  var_0 notify("fully_removed");
  level.all_convoys = scripts\engine\utility::array_remove(level.all_convoys, level.all_convoys[var_0.name]);

  if(isDefined(isDefined(level.all_convoys[var_0.name]))) {
    level.all_convoys[var_0.name] = undefined;
    return;
  }
}

function change_convoy_objective_target() {
  self.settings.target = var_0;

  if(istrue(var_2)) {
    if(istrue(self.settings.unload_at_target)) {
      foreach(var_5 in self.spawned_vehicles) {
        if(isalive(var_5)) {
          if(isDefined(level.vehicle_all_stop_func)) {
            var_5[[level.vehicle_all_stop_func]](0);
          }

          var_5 notify("unload_guys");
        }
      }
    }

    return;
  }

  if(istrue(var_3)) {
    return;
  }

  var_7 = 1000;
  var_8 = var_7 * var_7;

  foreach(var_5 in self.spawned_vehicles) {
      if(isalive(var_5)) {
        var_5.path_gobbler = 1;

        if(isstring(var_0)) {
          var_10 = var_0;
          var_0 = scripts\engine\utility::getent_or_struct(var_10, "script_noteworthy").origin;

          if(!isDefined(var_0)) {
            var_0 = scripts\engine\utility::getent_or_struct(var_10, "targetname").origin;
          }
        } else if(!isvector(var_0) && isDefined(var_0.origin)) {
          var_0 = var_0.origin;
        }

        var_11 = 60;
        var_12 = "mkilo23_ai_infil";
        var_13 = level.ai_spawn_vehicle_func[var_12].path_start_points;

        if(isDefined(self.convoy_paths_override)) {
          var_13 = self.convoy_paths_override;
        }

        var_14 = scripts\engine\utility::getStructArray(var_13, "targetname");

        if(!isDefined(var_14) || var_14.size == 0) {
          return;
        }

        if(isDefined(var_5.pathing_array)) {
          foreach(var_16 in var_5.pathing_array) {
            level notify("kill_debug_" + var_16.pathing_index);
          }
        }

        if(isDefined(var_5.pathing_arrays)) {
          var_5.pathing_arrays = undefined;
        }

        var_18 = undefined;
        var_19 = scripts\engine\utility::getclosest(var_5.origin, var_14);

        if(!is_struct_in_front_of_me(var_5, var_19)) {
          var_20 = var_19 scripts\cp\cp_vehicles::get_veh_linked_structs();

          for(var_21 = 0; var_21 < var_20.size; var_21++) {
            if(is_struct_in_front_of_me(var_5, var_20[var_21])) {
              var_18 = var_20[var_21];
              break;
            }
          }

          if(!isDefined(var_18)) {
            for(var_21 = 0; var_21 < var_20.size; var_21++) {
              var_22 = var_20[var_21] scripts\cp\cp_vehicles::get_veh_linked_structs();

              for(var_23 = 0; var_23 < var_22.size; var_23++) {
                if(is_struct_in_front_of_me(var_5, var_22[var_23])) {
                  var_18 = var_22[var_23];
                  break;
                }
              }
            }
          }

          if(isDefined(var_18)) {
            var_19 = var_18;
          }
        }

        var_24 = scripts\engine\utility::getclosest(var_0, var_14);

        if(distance2dsquared(var_5.origin, var_24.origin) < var_8) {
          break;
        }

        var_0 notify("reset_path");
        var_25 = scripts\cp\cp_vehicles::duplicate_struct(var_5);
        var_25.speed = var_2;
        var_25.angles = vectortoangles(var_25.origin - var_0.origin);
        scripts\cp\cp_vehicles::add_targetname_kvps(var_25, undefined, var_3 + 0 + "_convoy_start");
        add_to_convoy_structs(var_25);
        var_26 = scripts\cp\cp_vehicles::duplicate_struct(var_31);
        var_26.speed = var_2;
        var_26.script_pathtype = "unload";
        scripts\cp\cp_vehicles::add_targetname_kvps(var_26, undefined, var_3 + 0 + "_convoy_end");
        add_to_convoy_structs(var_26);
        var_27 = [];

        if(isDefined( < error > ) && < error > .size > 0) {
          for(var_21 = 0; var_21 < < error > .size; var_21++) {
            var_28 = < error > [var_21];

            if(isstruct( < error > [var_21])) {
              var_28 = < error > [var_21].origin;
            }

            var_29 = scripts\engine\utility::getclosest(var_28, var_8);
            var_30 = scripts\cp\cp_vehicles::duplicate_struct(var_29);
            var_30.speed = var_2;
            scripts\cp\cp_vehicles::add_targetname_kvps(var_29, undefined, var_3 + 0 + "_convoy_btwn");
            add_to_convoy_structs(var_30);
            var_27 = var_29;
          }
        }

        follow_path_from_grid(var_0, var_25, var_26, var_27, var_8);
        wait 2;
      }
    }

    <
    error > = undefined;
  var_1 = undefined;
}

function is_struct_in_front_of_me(var_0) {
  var_1 = vectordot(self.angles, vectorNormalize(var_0.origin - self.origin));
  return var_1 > 0;
}

function add_to_convoy_structs(var_0) {
  if(!isDefined(self.saved_struct_paths)) {
    self.saved_struct_paths = [];
  }

  if(isDefined(var_0) && isstruct(var_0)) {
    self.saved_struct_paths[self.saved_struct_paths.size] = var_0;
    return;
  }
}

function handle_set_speed_to_goal(var_0, var_1) {
  self endon("death");
  var_1 endon("convoy_compromised");
  self.disable_set_speed = 1;
  var_2 = getdvarint("scr_event_convoy_speedup", 0);

  if(var_2 == 0) {
    return;
  }

  if(var_2 > 400) {
    var_2 = 400;
  }

  var_3 = scripts\cp\cp_vehicles::getvehiclepath("convoy_start_" + var_0);

  while(isDefined(var_3.target)) {
    var_3 = scripts\cp\cp_vehicles::getvehiclepath(var_3.target);
    var_3 waittill("trigger");

    if(var_3.speed > 15) {
      self vehicle_setspeedimmediate(var_2, 15, 15);
    }

    if(isDefined(var_3.script_pathtype) && var_3.script_pathtype == "convoy_slowdown") {
      self vehicle_setspeedimmediate(15, 350, 350);
      wait 5;
      return;
    }
  }
}

function follow_path_from_grid(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  level endon("game_ended");
  self endon("convoy_compromised");

  if(!isDefined(level.convoy_path_number)) {
    level.convoy_path_number = 0;
  }

  var_0.pathing_array = undefined;
  var_0.veh_path = [];

  if(isDefined(var_3) && var_3.size > 0) {
    var_5 = [];
    GscBinSkip0(0x2e, 0, var_1);
  }

  var_21 = var_1.vehicletype;
  var_1 scripts\cp\cp_vehicles::create_path_from_struct_to_struct(var_2, var_3, level.convoy_path_number, var_21, "_convoy_unload_pathing_", (1, 1, 1));
  var_1 scripts\engine\utility::thread_on_notify_no_endon_death("death", &scripts\cp\cp_vehicles::reset_spawn_point_targetname, undefined, undefined, var_1);
  var_1 thread scripts\cp\cp_vehicles::vehiclefollowstructpath(var_1.pathing_array[0]);
  level.convoy_path_number++;
}

function allow_soldiers_attempt_take_target(var_0) {
  scripts\engine\utility::waittill_any_ents(level, "allow_convoy_soldiers_target", var_0, "convoy_arrived_at_dest");
  thread attempt_new_pulse_set(level);
}

function attempt_new_pulse_set(var_0) {
  if(istrue(var_0.settings.recruit_enable)) {
    thread pulse_soldiers_to_help_convoy();
    return;
  }
}

function set_roaming() {
  level endon("game_ended");
  self endon("convoy_compromised");
  self endon("death");
  self endon("reset_path");
  var_0 = undefined;
  var_1 = 192;
  var_2 = var_1 * var_1;
  var_3 = 10000;
  var_4 = var_3 * var_3;
  var_5 = 1;
  var_6 = "mkilo23_ai_infil";
  var_7 = undefined;

  for(var_8 = 0; var_8 < self.spawned_vehicles.size; var_8++) {
    if(isDefined(self.spawned_vehicles[var_8]) && isalive(self.spawned_vehicles[var_8])) {
      var_7 = self.spawned_vehicles[var_8];
      break;
    }
  }

  var_7 endon("death");
  var_9 = 0.1;

  for(;;) {
    if(var_5 == 1) {
      var_10 = level.ai_spawn_vehicle_func[var_6].path_start_points;

      if(isDefined(self.convoy_paths_override)) {
        var_10 = self.convoy_paths_override;
      }

      var_11 = scripts\engine\utility::getStructArray(var_10, "targetname");

      for(var_8 = 0; var_8 < var_11.size; var_8++) {
        var_12 = var_11[var_8] scripts\cp\cp_vehicles::get_veh_linked_structs();
        var_13 = var_12.size;

        if(var_13 < 2) {
          var_11 = scripts\engine\utility::array_remove(var_11, var_11[var_8]);
        }
      }

      var_11 = sortbydistance(var_11, var_7.origin);
      var_14 = [];
      var_15 = int(var_11.size * 0.66);

      for(var_8 = 0; var_8 < var_11.size; var_8++) {
        if(var_8 >= var_15) {
          var_14 = var_11[var_8];
        }
      }

      if(var_14.size == 0) {
        var_14 = var_11[var_8];
      }

      var_0 = scripts\engine\utility::random(var_14);

      if(isDefined(var_0.origin)) {}

      change_convoy_objective_target(var_0.origin);
      var_5 = 0;
    }

    if(distance2dsquared(var_7.origin, var_0.origin) > var_4) {
      var_9 = 1;
    } else if(distance2dsquared(var_7.origin, var_0.origin) > var_2) {
      var_9 = 0.1;
    } else if(distance2dsquared(var_7.origin, var_0.origin) < var_2) {
      var_5 = 1;
    }

    wait var_9;
  }
}

function debug_draw_until_newpath(var_0, var_1) {
  var_1 endon("death");
  var_1 notify("debug_draw_until_newpath");
  var_1 endon("debug_draw_until_newpath");

  for(;;) {
    level thread scripts\engine\utility::draw_capsule(var_0.origin, 128, 2000, undefined, (1, 0, 1), undefined, 1);
    waitframe();
  }
}

function toggle_trucks_disable_leave(var_0) {
  foreach(var_2 in self.spawned_vehicles) {
    if(isent(var_2)) {
      var_2.disable_leave_truck = var_0;

      if(istrue(var_0)) {
        var_2 notify("disable_leave_truck");
      }
    }
  }
}

function spawn_convoy_truck(var_0) {
  var_1 = var_0.spawner;

  if(isDefined(getvehiclenode("convoy_start_helidown3", "targetname"))) {
    var_1.vehicletype = "truck";
    var_1.script_modelname = "veh8_civ_lnd_techo_physics_mp";
  } else {
    var_1.vehicletype = "techo_physics";
    var_1.script_modelname = "veh8_civ_lnd_techo_physics_mp";
  }

  var_1.classname_mp = "script_vehicle_iw8_truck_techo_white_physics";
  var_1.script_team = "axis";

  if(!isDefined(var_1.angles)) {
    var_1.angles = (0, 0, 0);
  }

  var_2 = scripts\common\vehicle::vehicle_spawn(var_1);
  var_2.vehicle_skipdeathmodel = 1;
  var_2.death_fx_on_self = 1;
  var_2.disable_leave_truck = 1;
  var_2 setvehicleteam("axis");
  var_2.orig_health = var_2.health;
  var_2.type = "techo";
  var_2.riders = [];
  var_0.alive_support_vehicles++;
  var_0.spawned_vehicles[var_0.spawned_vehicles.size] = var_2;
  var_2.spawner = var_1;
  var_2.convoy = var_0;
  return var_2;
}

function spawn_convoy_decho(var_0) {
  if(!isDefined(var_0.team)) {
    var_0.team = "axis";
  }

  var_1 = var_0.spawner;
  var_1.vehicletype = "techo_physics";
  var_1.script_modelname = "veh8_civ_lnd_decho_physics";
  var_1.classname_mp = "script_vehicle_iw8_truck_techo_white";
  var_1.script_team = var_0.team;

  if(!isDefined(var_1.angles)) {
    var_1.angles = (0, 0, 0);
  }

  var_2 = scripts\common\vehicle::vehicle_spawn(var_1);
  var_2.vehicle_skipdeathmodel = 1;
  var_2.death_fx_on_self = 1;
  var_2.disable_leave_truck = 1;
  var_2 setvehicleteam("axis");
  var_2.orig_health = var_2.health;
  var_2.type = "decho";
  var_2.riders = [];
  var_0.alive_support_vehicles++;
  var_0.spawned_vehicles[var_0.spawned_vehicles.size] = var_2;
  var_2.spawner = var_1;
  var_2.convoy = var_0;
  return var_2;
}

function spawn_convoy_apc(var_0) {
  if(!isDefined(var_0.team)) {
    var_0.team = "axis";
  }

  var_1 = var_0.team;
  var_2 = var_0.spawner;
  var_2.vehicletype = "stango_physics_mp";
  var_2.script_modelname = "veh8_mil_lnd_stango_physics_mp";
  var_2.classname_mp = "apc";
  var_2.targetname = "apc";
  var_2.script_team = var_1;

  if(!isDefined(var_2.angles)) {
    var_2.angles = (0, 0, 0);
  }

  var_3 = scripts\common\vehicle::vehicle_spawn(var_2);
  var_3.vehicle_skipdeathmodel = 1;
  var_3.death_fx_on_self = 1;
  var_3 setCanDamage(0);
  var_3 setvehicleteam(var_1);
  var_3.script_team = var_1;
  var_3.orig_health = var_3.health * 2;
  var_3.type = "apc";
  var_3.riders = [];
  var_3.cp_speed = scripts\engine\utility::ter_op(isDefined(var_0.cp_speed), var_0.cp_speed, 300);
  var_0.main_truck = var_3;
  var_0.spawned_vehicles[var_0.spawned_vehicles.size] = var_3;
  var_3.spawner = var_2;
  var_3.convoy = var_0;
  return var_3;
}

function spawn_convoy_mkilo23(var_0, var_1) {
  var_2 = var_0.spawner;
  var_2.vehicletype = "mkilo_physics_cp";
  var_2.script_modelname = "veh8_mil_lnd_mkilo23_physics_mp";
  var_2.classname_mp = "script_veh8_mil_lnd_mkilo23_physics_ai_infil";
  var_2.script_team = "axis";

  if(!isDefined(var_2.angles)) {
    var_2.angles = (0, 0, 0);
  }

  var_3 = scripts\common\vehicle::vehicle_spawn(var_2);
  var_3.vehicle_skipdeathmodel = 1;
  var_3.death_fx_on_self = 1;
  var_3 setCanDamage(1);
  var_3 setvehicleteam("axis");
  var_3.script_team = "axis";
  var_3.orig_health = var_3.health;
  var_3.disable_leave_truck = 1;

  if(!istrue(var_1)) {
    var_3.tarp = var_3 thread scripts\cp\vehicles\vehicle_cp::spawn_vehicle_accessory("veh8_mil_lnd_mkilo23_tarp", undefined, undefined, (0, 0, 0));
  } else {
    var_0.no_tarp = 1;
  }

  var_4 = 500;
  var_5 = 26.6;
  add_wheel_tag(var_3, "tag_wheel_center_front_left", var_4, var_5);
  add_wheel_tag(var_3, "tag_wheel_center_front_right", var_4, var_5);
  add_wheel_tag(var_3, "tag_wheel_center_middle_left", var_4, var_5);
  add_wheel_tag(var_3, "tag_wheel_center_middle_right", var_4, var_5);
  add_wheel_tag(var_3, "tag_wheel_center_back_left", var_4, var_5);
  add_wheel_tag(var_3, "tag_wheel_center_back_right", var_4, var_5);
  var_3.type = "mkilo";
  var_3.riders = [];
  var_0.main_truck = var_3;
  var_0.spawned_vehicles[var_0.spawned_vehicles.size] = var_3;
  var_3.spawner = var_2;
  var_3.convoy = var_0;
  thread is_ascender_use_allowed();
  return var_3;
}

function is_ascender_use_allowed() {
  level endon("game_ended");
  self.convoy endon("event_convoy_delete");
  self endon("death");
  var_0 = undefined;
  var_1 = 40000;
  var_2 = 2;
  wait 10;

  for(;;) {
    var_0 = vehicle_getarray();
    var_2 = 2;

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      if(!isDefined(var_0[var_3].convoy) && istrue(var_0[var_3].isempty) && isDefined(var_0[var_3].team) && var_0[var_3].team != "axis" && isent(var_0[var_3]) && isDefined(var_0[var_3].vehiclename) && var_0[var_3].vehiclename == "atv" && self != var_0[var_3] && !var_0[var_3] issuspendedvehicle()) {
        var_4 = self gettagorigin("tag_light_front_right");

        if(distancesquared(var_4, var_0[var_3].origin) < var_1) {
          var_0[var_3] dodamage(90, self.origin);
          var_2 = 0.5;
        }
      }
    }

    wait var_2;
  }
}

function convoy_vehicle_monitor(var_0, var_1) {
  level endon("game_ended");
  thread handle_set_speed_to_goal(var_0, var_1);
  self.damage_functions[0] = &convoy_damage_monitor;
  thread waittilldeath();
  thread waittillarriveatdestination(var_0, var_1);
  thread waittillcompromised(var_0, var_1);
  thread waittillhealthlow(var_0);
  thread waittilltoofarz();
}

function convoy_damage_monitor(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = 0;

  if(!isDefined(self.team)) {
    self.team = "axis";
  }

  if(!isPlayer(var_1)) {
    if(isDefined(var_1.owner) && isPlayer(var_1.owner) && isexplosivedamagemod(var_4) && self.health > self.healthbuffer) {
      if(self.type == "mkilo") {
        apply_truck_dmg(var_0, 1, 0.7, var_4);
      }

      var_1.owner scripts\cp\cp_damagefeedback::updatehitmarker("hittankarmor", 0, var_0, 1, 0);
      var_1.owner playlocalsound("cp_hit_indication_armor");
    }

    return;
  }

  if(self.type == "mkilo") {
    if(!isDefined(self.is_correct_wire_color_sync)) {
      self.is_correct_wire_color_sync = 0.03;
    }

    if(self.health > self.healthbuffer) {
      var_1 scripts\cp\cp_damagefeedback::updatehitmarker("hittankarmor", 0, var_0, 0, 0);
      var_1 playlocalsound("cp_hit_indication_armor");
    }

    if(!isexplosivedamagemod(var_4)) {
      apply_truck_dmg(var_0, 1, 0.95, var_4);
    } else {
      apply_truck_dmg(var_0, 0, 0.6, var_4);
    }
  } else {
    if(self.health > self.healthbuffer) {
      var_1 scripts\cp\cp_damagefeedback::updatehitmarker("low_damage", 0, var_0, 0, 0);
    }

    if(isexplosivedamagemod(var_4)) {
      apply_truck_dmg(var_0, 0, 1.8, var_4);
    } else {
      apply_truck_dmg(var_0, 1, 0.55, var_4);
    }
  }

  foreach(var_12 in self.riders) {
    if(isalive(var_12)) {
      if(isDefined(var_1) && isPlayer(var_1)) {
        var_12 getenemyinfo(var_1);
      }
    }
  }

  if(self.health < self.healthbuffer) {
    var_1 scripts\cp\cp_damagefeedback::updatehitmarker("low_damage", 0, var_0, 0, 0);
    return;
  }
}

function apply_truck_dmg(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3) && var_3 == "MOD_SUICIDE") {
    return;
  }

  if(istrue(self.draining_health)) {
    self.health += var_0;
    return;
  }

  if(!istrue(self.hull_invulnerable)) {
    if(istrue(var_1)) {
      self.health += int(var_0 * var_2);
      return;
    }

    self.health -= int(var_0 * var_2);
    return;
  }

  self.health = self.orig_health;
}

function add_wheel_tag(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0) && isDefined(var_1)) {
    if(!isDefined(var_0.wheel_tags)) {
      var_0.wheel_tags = [];
    }

    if(!isDefined(var_2)) {
      var_2 = 500;
    }

    if(!isDefined(var_3)) {
      var_3 = 60;
    }

    if(!isDefined(var_4)) {
      var_4 = "veh8_civ_lnd_techo_wheel_dst";
    }

    var_5 = spawnStruct();
    var_5.tag = var_1;
    var_5.health = var_2;
    var_5.radius = var_3;
    var_5.model = var_4;
    var_5.orientation = "right";
    var_6 = strtok(var_1, "_");

    foreach(var_8 in var_6) {
      if(var_8 == "left") {
        var_5.orientation = "left";
      }
    }

    var_0.wheel_tags[var_0.wheel_tags.size] = var_5;
    return;
  }
}

function init_tire_outlines(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.wheel_tags) || var_0.wheel_tags.size == 0) {
    return;
  }

  thread barrel_setup_anims();

  for(var_1 = 0; var_1 < var_0.wheel_tags.size; var_1++) {
    var_2 = var_0.wheel_tags[var_1];
    var_2.model_created = spawn_wheel_outline_model(var_0, var_2);
    var_2.collision_created = spawn_wheel_collision(var_0, var_2);
    thread track_tire_damage(var_2.collision_created, var_0);
  }
}

function spawn_wheel_outline_model(var_0, var_1) {
  var_2 = spawn("script_model", var_0 gettagorigin(var_1.tag));
  var_2.angles = var_0.angles;
  var_2 setModel(var_1.model);
  var_2 notsolid();
  var_2 show();
  var_2.owner = var_0;
  var_3 = -8;
  var_4 = 180;

  if(var_1.orientation == "left") {
    var_3 *= -1;
    var_4 = 0;
  }

  var_2 linkTo(var_0, var_1.tag, (0, var_3, 0), (0, var_4, 0));
  return var_2;
}

function spawn_wheel_collision(var_0, var_1) {
  level.obj_overwatch_coll_type = 0;

  if(!isDefined(level.taccoverbulletcollision)) {
    var_2 = getEntArray("tactical_cover_bullet_col", "targetname");

    if(isDefined(var_2)) {
      level.taccoverbulletcollision = var_2[0];
      level.obj_overwatch_coll_type = 1;
    }
  }

  if(!isDefined(level.taccoverbulletcollision)) {
    var_2 = getEntArray("player32x32x8", "targetname");

    if(isDefined(var_2)) {
      level.taccoverbulletcollision = var_2[0];
      level.obj_overwatch_coll_type = 2;
    }
  }

  var_3 = spawn("script_model", var_0 gettagorigin(var_1.tag));
  var_3 dontinterpolate();
  var_3.angles = var_0.angles;
  var_3.owner = var_0;
  var_3.maxhealth = 999999;
  var_3.health = 500;
  var_3.team = var_0.script_team;
  var_3 setCanDamage(1);
  var_3 clonebrushmodeltoscriptmodel(level.taccoverbulletcollision);
  var_4 = -10;

  if(var_1.orientation == "left") {
    var_4 *= -1;
  }

  var_5 = (0, 90, 0);

  if(level.obj_overwatch_coll_type == 2) {
    var_5 = (90, 90, 0);
  }

  var_3 linkTo(var_0, var_1.tag, (0, var_4, 5), var_5);
  return var_3;
}

function track_tire_damage(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("death");
  var_2 = var_1.collision_created;

  while(var_2.health > 0) {
    var_2 waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(!isPlayer(var_4)) {
      if(isDefined(var_4.owner) && isPlayer(var_4.owner) && isexplosivedamagemod(var_7)) {
        var_2.health += int(var_3 * 0.99);
        thread blink_tire_outline(var_2);
      } else {
        var_2.health += int(var_3);
      }

      continue;
    }

    if(isexplosivedamagemod(var_7)) {
      var_2 dodamage(var_3 * 0.88, var_6, var_4);
      thread blink_tire_outline(var_2);
      continue;
    }

    var_2.health += int(var_3 * 0.7);
    thread blink_tire_outline(var_2);
  }

  var_2 delete();
  thread toggle_tire_outlines(level, var_0);
  var_0.convoy notify("vehicle_lost_wheel");
  var_0 notify("lost_wheel");
  var_1 notify("wheel_burst");

  if(soundexists("smoke_grenade_expl_trans")) {
    var_1.model_created playsoundonmovingent("smoke_grenade_expl_trans");
  }

  if(isDefined(var_1.orientation)) {
    if(var_1.orientation == "left") {
      playFXOnTag(scripts\engine\utility::getfx("vfx_mkilo_tire_explode_left"), var_0, var_1.tag);
      return;
    }

    playFXOnTag(scripts\engine\utility::getfx("vfx_mkilo_tire_explode_right"), var_0, var_1.tag);
    return;
  }
}

function blink_tire_outline(var_0) {
  var_0 notify("blink_outline");
  var_0 endon("blink_outline");
  var_0 endon("wheel_burst");
  var_0.model_created hudoutlinedisable();
  var_0.model_created hudoutlineenable("outlinefill_depth_red");
  wait 0.1;
  var_0.model_created hudoutlinedisable();
  var_0.model_created hudoutlineenable("outlinefill_depth_orange");
}

function toggle_tire_outlines(var_0, var_1, var_2) {
  if(istrue(var_2)) {
    if(!isDefined(var_0.toggled_tire_outlines)) {
      init_tire_outlines(var_0);
      var_0.toggled_tire_outlines = 1;
    }
  }

  if(isDefined(var_0.wheel_tags)) {
    if(!isDefined(var_2)) {
      if(istrue(var_1.outlined)) {
        if(isDefined(var_1.model_created)) {
          var_1.model_created hudoutlinedisable();
        }

        var_1.outlined = 0;
        return;
      }

      if(isDefined(var_1.model_created)) {
        var_1.model_created hudoutlineenable("outlinefill_depth_orange");
      }

      var_1.outlined = 1;
      return;
    }

    if(!istrue(var_2)) {
      if(isDefined(var_1.model_created)) {
        var_1.model_created hudoutlinedisable();
      }

      var_1.outlined = 0;
      return;
    }

    if(isDefined(var_1.model_created)) {
      var_1.model_created hudoutlineenable("outlinefill_depth_orange");
    }

    var_1.outlined = 1;
    return;
  }
}

function check_backup_is_set(var_0) {
  if(isDefined(var_0.settings.backup_deposit_names)) {
    return true;
  }

  return false;
}

function route_soldiers_towards_backup_location(var_0) {
  level endon("game_ended");
  var_0 notify("route_soldiers_to_backups");
  var_0 endon("route_soldiers_to_backups");
  var_1 = var_0.targeted_hvt;

  if(!istrue(var_0.ref_13069)) {
    var_0.ref_13069 = 1;
    var_0.initialize_switches_pattern = undefined;

    if(isDefined(var_1.carrier)) {
      var_0.initialize_switches_pattern = var_1.carrier;
    }

    var_0.initialize_water_trap = gettime();
    thread allow_routing_to_end(level);
  }

  if(isDefined(var_1.carrier)) {
    if(!isDefined(var_0.initialize_switches_pattern) || var_1.carrier != var_0.initialize_switches_pattern || gettime() > var_0.initialize_water_trap + 45000) {
      var_0.initialize_switches_pattern = var_1.carrier;
      var_0.initialize_water_trap = gettime();
    } else if(isDefined(var_0.chopper_carepackage_set_useable)) {
      return;
    }
  } else {
    return;
  }

  if(isDefined(var_1.waypoint)) {
    if(isDefined(var_1.sethotfunc)) {
      var_1 thread[[var_1.sethotfunc]](1);
    }
  }

  var_2 = scripts\engine\utility::getStructArray(var_0.settings.backup_deposit_names, "targetname");

  if(!isDefined(var_2) || var_2.size == 0) {
    var_0 notify("allow_routing_to_end");
    return;
  }

  var_3 = 2250000;

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    if(distance2dsquared(var_2[var_4].origin, var_1.origin) < var_3) {
      var_2 = scripts\engine\utility::array_remove(var_2, var_2[var_4]);
    }
  }

  var_5 = scripts\engine\utility::getclosest(var_1.origin, var_2);
  var_0.chopper_carepackage_set_useable = var_5;

  if(istrue(var_0.settings.recruit_enable)) {
    thread pulse_soldiers_to_help_convoy();
  }

  if(!isDefined(var_0.settings.backup_deposit_names)) {
    var_0 notify("allow_routing_to_end");
    return;
  }

  if(var_0.backup_soldiers.size > 0) {
    foreach(var_7 in var_0.backup_soldiers) {
      if(istrue(var_0.targeted_hvt.pickedup)) {
        send_convoy_soldier_here(var_7, var_5.origin, undefined, 1);

        if(istrue(var_7.has_hvt)) {
          var_7.goalradius = 50;
          continue;
        }

        var_7.goalradius = 150;
      }
    }

    return;
  }
}

function allow_routing_to_end(var_0) {
  var_0 waittill("allow_routing_to_end");
  thread remove_convoy_from_level(level);

  if(isDefined(var_0.eventname) && var_0.eventname != "") {
    scripts\cp\cp_objectives_events::mark_event_completed(var_0.eventname);
    return;
  }
}

function is_convoy() {
  if(!isDefined(self.spawner)) {
    return false;
  }

  return true;
}

function kill_convoy_all_safe(var_0) {
  var_1 = 0.05;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  if(var_1 > 0) {
    wait var_1;
  }

  foreach(var_3 in self.spawned_vehicles) {
    if(isalive(var_3)) {
      thread waittillplayersleavearea();
    }
  }
}

function kill_convoy_all(var_0, var_1) {
  level endon("game_ended");

  if(!isDefined(var_1)) {
    var_1 = 180;
  }

  var_2 = var_0 scripts\engine\utility::waittill_any_ents_or_timeout_return(var_1, level, "debug_beat_" + var_0.eventname + "_objective", var_0, "kill_convoy_ents");
  var_0 notify("event_convoy_delete");

  foreach(var_4 in var_0.spawned_vehicles) {
    if(isalive(var_4)) {
      thread kill_truck_riders();
      thread delete_accessories();
      thread delete_tires();
      thread delete_my_drone_models();
      var_4 delete();
    }
  }

  if(isDefined(var_0.convoy_hvt_struct)) {
    var_0.convoy_hvt_struct.script_noteworthy = "";
  }

  var_6 = getEnt("objective_convoy_civilian", "script_noteworthy");

  if(isDefined(var_6)) {
    var_6 delete();
  }

  if(isDefined(var_0.targeted_hvt) && isent(var_0.targeted_hvt) && istrue(var_0.targeted_hvt.pickedup)) {
    var_0.targeted_hvt delete();
  }

  if(isDefined(var_0.targeted_hvt) && isalive(var_0.targeted_hvt)) {
    var_0.targeted_hvt kill();
  }

  thread remove_convoy_from_level(level);

  if(isDefined(var_0.eventname) && var_0.eventname != "") {
    scripts\cp\cp_objectives_events::mark_event_completed(var_0.eventname);
    return;
  }
}

function kill_main_truck(var_0, var_1) {
  var_2 = var_0.main_truck;

  if(isDefined(var_1)) {
    wait var_1;
  }

  if(isalive(var_2)) {
    thread kill_truck_riders();
    thread delete_accessories();
    thread delete_tires();
    thread delete_my_drone_models();
    var_2 delete();
    return;
  }
}

function kill_truck_riders() {
  foreach(var_1 in self.riders) {
    if(isalive(var_1)) {
      var_1 dodamage(var_1.health + 9990, var_1.origin, undefined, undefined, "MOD_UNKNOWN");
    }
  }

  if(isDefined(self.spawned_guys)) {
    foreach(var_4 in self.spawned_guys) {
      if(isalive(var_4)) {
        var_4 dodamage(var_4.health + 9990, var_4.origin, undefined, undefined, "MOD_UNKNOWN");
      }
    }
  }

  if(isDefined(self.zombiejumping)) {
    foreach(var_4 in self.zombiejumping) {
      if(isalive(var_4)) {
        var_4 dodamage(var_4.health + 9990, var_4.origin, undefined, undefined, "MOD_UNKNOWN");
      }
    }

    return;
  }
}

function delete_my_drone_models() {
  var_0 = self.attached_drones;

  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      if(isDefined(var_2)) {
        var_2 delete();
      }

      if(isDefined(self.type) && self.type == "mkilo") {
        if(isDefined(level.reserved_spawn_slots["truck_drones"])) {
          scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "truck_drones");
        }
      }
    }
  }

  scripts\cp\cp_vehicle_turretdrone::delete_vehicles_turrets();
}

function waittillconvoydead() {
  level endon("game_ended");
  self endon("event_convoy_delete");

  if(!isDefined(self.vehicles_remaining)) {
    return;
  }

  while(self.vehicles_remaining > 0) {
    wait 0.5;
  }

  if(istrue(self.settings.toggle_vo_on_convoy_death) && !istrue(self.despawned_vehicles)) {
    level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_convoy_disabled_10", "allies");
  }

  if(check_backup_is_set(self)) {
    thread route_soldiers_towards_backup_location(level);
    return;
  }

  thread remove_convoy_from_level(level);

  if(isDefined(self.eventname) && self.eventname != "") {
    scripts\cp\cp_objectives_events::mark_event_completed(self.eventname);
    return;
  }
}

function waittilldeath() {
  level endon("game_ended");
  self.convoy endon("event_convoy_delete");
  var_0 = self.convoy;
  wait 1;
  self waittill("death", var_1, var_2, var_3, var_4);

  if(isDefined(self.convoy.vehicles_remaining)) {
    self.convoy.vehicles_remaining--;
  }

  if(!isDefined(var_4)) {
    var_4 = self.origin;
  }

  if(isDefined(self.origin)) {
    thread play_deathfx_convoy(var_1, var_2, var_4);
  }

  thread scripts\cp\utility::vehicle_freehealthbarui();
  thread delete_my_old_path();
  thread delete_my_drone_models();
  thread kill_truck_riders();
  thread truck_barrels_on_death(var_0);
  GscBinSkip4(0x35);
}

function play_deathfx_convoy(var_0, var_1, var_2) {
  scripts\common\vehicle_code::vehicle_playdeatheffects(var_0, var_1, var_2);
}

function handle_vehicle_death_type() {
  if(self.type != "mkilo") {
    self.convoy.alive_support_vehicles--;

    if(istrue(self.has_hvt) && istrue(self.convoy.exiting)) {
      thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/CONVOY_2");
      thread spawnheliactorsfunc(self.convoy.targeted_hvt);
    }
  } else if(self.type == "mkilo" && !istrue(self.convoy.exiting)) {
    foreach(var_1 in self.convoy.spawned_vehicles) {
      if(isalive(var_1)) {
        var_1.disable_leave_truck = 0;
        var_1 vehicle_setspeed(0, 10, 10);
        thread waittillplayersleavearea();
      }

      var_1 notify("stop_follow_path");
      self.convoy notify("convoy_compromised");
    }

    if(isDefined(self.convoy.targeted_hvt) && istrue(self.has_hvt)) {
      self.convoy.targeted_hvt.origin = getclosestpointonnavmesh(self.convoy.targeted_hvt.origin) + (0, 0, 10);
    }
  }

  if(self.type == "mkilo") {
    if(istrue(self.convoy.exiting)) {
      if(self.convoy.vehicles_remaining > 0) {
        thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/CONVOY_2");
      }

      if(isDefined(self.convoy.targeted_hvt) && istrue(self.has_hvt)) {
        thread spawnheliactorsfunc(self.convoy.targeted_hvt);
      }
    }

    self.convoy notify("convoy_center_death");
    thread main_truck_compromise(level);
  }

  if((!isDefined(self.convoy.vehicles_remaining) || self.convoy.vehicles_remaining == 0) && istrue(self.convoy.not_compromised)) {
    GscBinSkip4(0x6e, self.convoy, self.convoy, self, var_1, self);
  }

  if(isDefined(self) && isent(self)) {
    if(isDefined(self) && isent(self) && isDefined(self.dmg_vfx_tag)) {
      stopFXOnTag(scripts\engine\utility::getfx("vfx_ai_gen_fire"), self, self.dmg_vfx_tag);
    }

    thread delete_accessories();
    thread delete_tires();

    if(getdvarint("scr_convoy_corpse_enable", 0) == 0) {
      self delete();
      return;
    }

    return;
  }
}

function delete_accessories(var_0) {
  if(isDefined(var_0) && var_0 > 0) {
    wait var_0;
  }

  if(isDefined(self.accessories)) {
    foreach(var_2 in self.accessories) {
      var_2 delete();
    }

    return;
  }
}

function delete_tires(var_0) {
  if(isDefined(var_0) && var_0 > 0) {
    wait var_0;
  }

  if(isDefined(self.wheel_tags)) {
    foreach(var_2 in self.wheel_tags) {
      if(isent(var_2.model_created)) {
        var_2.model_created delete();
      }

      if(isent(var_2.collision_created)) {
        var_2.collision_created delete();
      }
    }

    return;
  }
}

function delay_kill_convoy_ents() {
  wait 0.5;
  self notify("kill_convoy_ents");
}

function delete_my_old_path() {
  scripts\cp\cp_vehicles::reset_spawn_point_targetname();
}

function waittillplayersleavearea() {
  level endon("game_ended");
  self.convoy endon("event_convoy_delete");
  self endon("death");

  if(!istrue(self.convoy.settings.despawn_dist_enable)) {
    return;
  }

  var_0 = self.convoy.settings.despawn_dist;
  var_1 = var_0 * var_0;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(self.origin, var_1)) {
      wait 1;
      continue;
    }

    break;
  }

  thread kill_truck_riders();
  thread delete_my_drone_models();
  thread delete_accessories();
  thread delete_tires();
  thread remove_convoy_from_level(level);

  if(isDefined(self.convoy.eventname) && self.convoy.eventname != "") {
    scripts\cp\cp_objectives_events::mark_event_completed(self.convoy.eventname);
  }

  self.convoy notify("despawned_truck_at_dist");
  self.convoy.despawned_vehicles = 1;
  self delete();
}

function waittilltoofarz() {
  level endon("game_ended");
  self.convoy endon("event_convoy_delete");
  self endon("death");

  for(;;) {
    wait 3;

    if(self.convoy.settings.distance_z > 0) {
      if(isalive(self)) {
        if(abs(self.origin[2] - self.measure_origin[2]) > self.convoy.settings.distance_z) {
          thread kill_truck_riders();
          thread delete_accessories();
          thread delete_tires();
          thread delete_my_drone_models();
          self delete();
        }
      }
    }
  }
}

function waittillhealthlow(var_0) {
  level endon("game_ended");
  self.convoy endon("event_convoy_delete");
  self endon("death");
  self.convoy endon("health_low");
  self.convoy waittill("event_convoy_spawned");
  GscBinSkip4(0x35);
}

function main_truck_compromise(var_0) {
  if(isalive(var_0.main_truck) && istrue(var_0.not_compromised)) {
    var_0.settings.ref_13F14 = undefined;
    var_0.main_truck.disable_leave_truck = 0;

    if(istrue(var_0.main_truck.hull_invulnerable)) {
      var_0.main_truck.health = var_0.main_truck.orig_health;
    }

    thread truck_compromise(var_0.main_truck);

    if(soundexists("vehicle_tire_screech")) {
      var_0.main_truck playSound("vehicle_tire_screech");
      return;
    }

    return;
  }
}

function truck_compromise(var_0) {
  var_1 = self.convoy;
  var_1.lastconfirmedpos = undefined;

  foreach(var_3 in self.convoy.spawned_vehicles) {
    if(isalive(var_3)) {
      var_3.disable_leave_truck = 0;
      level thread scripts\cp\cp_vehicles::make_guys_leave_truck(var_3);
      var_3 notify("unload_guys", "health_low");
      var_3 notify("stop_follow_path");
      var_1.lastconfirmedpos = var_3.origin;
    }
  }

  wait 0.05;

  if(istrue(var_0)) {
    if(isDefined(var_1.attached_barrels) && var_1.attached_barrels.size > 0) {
      thread truck_barrels_compromised(var_1);
    }

    thread handle_healthdrain_from_lowhealth(var_1);
    var_1 notify("health_low");
    var_1.lastconfirmedpos = self.origin;
  }

  var_1.not_compromised = 0;
  var_1 notify("convoy_compromised");
}

function handle_healthdrain_from_lowhealth(var_0) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(var_0.settings.health_drain) || var_0.settings.health_drain <= 0) {
    return;
  }

  if(self.type != "mkilo") {
    return;
  }

  self.draining_health = 1;
  objective_setplayintro(var_0.convoy_objectivestruct.objectiveindex, 0);
  objective_setplayoutro(var_0.convoy_objectivestruct.objectiveindex, 0);
  var_1 = int(var_0.settings.health_drain);
  wait 1;

  for(;;) {
    self dodamage(var_1, self.origin, undefined, undefined, "MOD_SUICIDE");
    objective_sethot(var_0.convoy_objectivestruct.objectiveindex, 0);
    wait 0.7;
    objective_sethot(var_0.convoy_objectivestruct.objectiveindex, 1);
    wait 0.3;
  }
}

function handle_vfx_on_damage() {
  self endon("death");
  self.dmg_vfx_tag = "tag_origin";

  if(!isDefined(self.type)) {
    return;
  }

  switch (self.type) {
    case "mkilo":
      self.dmg_vfx_tag = "tag_engine_fx_right";
      self.dmg_vfx_smoke = "vfx_ai_mkilo_smoke";
      self.dmg_vfx_smoke_move = "vfx_ai_mkilo_smoke_moving";
      self.dmg_vfx_hp = 1000;
      break;
    default:
      self.dmg_vfx_tag = "tag_engine_fx_left";
      self.dmg_vfx_smoke = "vfx_ai_mkilo_smoke";
      self.dmg_vfx_smoke_move = "vfx_ai_mkilo_smoke_moving";
      self.dmg_vfx_hp = 1000;
      break;
  }

  while(self.health > self.healthbuffer + self.dmg_vfx_hp) {
    wait 0.25;
  }

  scripts\cp\utility::debugprintline("play smoke");
  playFXOnTag(scripts\engine\utility::getfx(self.dmg_vfx_smoke), self, self.dmg_vfx_tag);
  wait 0.05;

  while(self.health > self.healthbuffer + 550) {
    wait 0.25;
  }

  scripts\cp\utility::debugprintline("play fire");
  stopFXOnTag(scripts\engine\utility::getfx(self.dmg_vfx_smoke), self, self.dmg_vfx_tag);
  playFXOnTag(scripts\engine\utility::getfx("vfx_ai_gen_fire"), self, self.dmg_vfx_tag);
}

function handle_smuggler_loot_attach(var_0, var_1, var_2) {
  var_3 = undefined;

  if(var_1 != var_2) {
    var_3 = randomintrange(var_1, var_2 + 1);
  } else {
    var_3 = var_1;
  }

  if(isDefined(self.main_truck) && isalive(self.main_truck)) {
    thread attach_barrels_to_truck(self.main_truck, "tag_accessory_01");
    return;
  }
}

function handle_smuggler_loot_drop(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 1;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  if(var_3 > var_4) {
    var_3 = var_4 - 1;
  }

  if(var_4 <= 0 || var_3 < 0) {
    self.settings.barrels_on_death = 0;
    return;
  }

  if(var_3 == var_4) {
    self.settings.barrels_on_death = var_3;
    return;
  }

  self.settings.barrels_on_death = randomintrange(var_3, var_4 + 1);
}

function attach_barrels_to_truck(var_0, var_1) {
  var_2 = self gettagorigin(var_0);

  if(!isDefined(var_2)) {
    return;
  }

  var_3 = 28;
  var_4 = 2;
  var_5 = self gettagangles(var_0);

  if(!isDefined(self.convoy.attached_barrels)) {
    self.convoy.attached_barrels = [];
  }

  for(var_6 = 0; var_6 < var_1; var_6++) {
    var_7 = var_3 * 0.51;

    if(var_6 % 2 == 0) {
      var_7 *= -1;
    }

    var_8 = var_6 * (var_3 * 0.5 + var_4);
    var_9 = (var_8 * -1, var_7, 0);
    var_10 = rotatevector(var_9, self.angles);
    var_11 = var_2 + var_10;
    var_12 = randomintrange(0, 359);
    var_13 = (var_5[0], var_12, var_5[2]);
    var_14 = thread spawn_phys_barrel_pickup(level, var_11, var_13);
    self.convoy.attached_barrels[self.convoy.attached_barrels.size] = var_14;
  }
}

function spawn_phys_barrel_pickup(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0);
  var_3.angles = var_1;
  var_3 setModel("container_nitrate_barrel_01");
  var_3 notsolid();
  var_3 show();
  var_3.owner = var_2;
  var_3 linkTo(var_2);
  spawn_barrel_straps(var_3);
  return var_3;
}

function spawn_barrel_collision(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1 dontinterpolate();
  var_1.angles = var_0;
  var_1 clonebrushmodeltoscriptmodel(level.taccovercollision);
  var_1 linkTo(self);
  return var_1;
}

function spawn_barrel_straps() {
  var_0 = spawn("script_model", self.origin);
  var_0.angles = self.angles;
  var_0 setModel("accessory_barrel_bomb_strap_01");
  var_0 notsolid();
  var_0 show();
  var_0 linkTo(self);

  if(!isDefined(self.straps)) {
    self.straps = [];
  }

  self.straps[self.straps.size] = var_0;
  return var_0;
}

function spawn_barrel_tracker(var_0) {
  var_1 = (0, 0, 3);
  var_2 = spawn("script_model", self.origin + var_1);
  var_2.angles = (0, 0, 0);
  var_2 setModel("decor_balloon_bunch_01");
  var_2 notsolid();
  var_2 show();
  var_2 linkTo(self);
  var_2 playLoopSound("capture_alert_lp");

  if(!isDefined(self.trackers)) {
    self.trackers = [];
  }

  self.trackers[self.trackers.size] = var_2;
  return var_2;
}

function delay_suspend_vehicle() {
  self endon("death");

  if(self.classname == "script_model" || !self vehicle_isphysveh()) {
    return;
  }

  while(self vehicle_getspeed() > 1) {
    wait 0.05;
  }

  wait 1.1;

  if(isDefined(self) && isent(self)) {
    self vehphys_deactivate();
    return;
  }
}

function truck_barrels_compromised(var_0) {
  if(!isDefined(var_0.attached_barrels)) {
    return;
  }

  delay_suspend_vehicle();
  var_1 = 10;

  for(var_2 = 0; var_2 < var_0.attached_barrels.size; var_2++) {
    if(var_2 == 0) {
      playrumbleonposition("grenade_rumble", var_0.attached_barrels[var_2].origin);
      earthquake(0.5, 1, var_0.attached_barrels[var_2].origin, 1500);
    }

    var_3 = var_0.attached_barrels[var_2];
    var_3 solid();
    var_3 show();
    var_3 unlink();

    for(var_4 = 0; var_4 < var_3.straps.size; var_4++) {
      var_3.straps[var_4] delete();
    }

    thread launch_barrel_away(var_3, 28, var_1);
    var_3 hudoutlineenable("outline_nodepth_red");
    thread init_smuggler_loot_interaction();
  }

  physicsexplosionsphere(var_0.attached_barrels[0].origin, 150, 120, 90);
}

function launch_barrel_away(var_0, var_1, var_2) {
  self endon("loot_marked");
  self endon("death");

  if(!isDefined(var_0)) {
    var_0 = 30;
  }

  var_3 = var_2.origin;
  self physicslaunchserver(self.origin, (0, 0, 0));
  var_4 = 0;
  var_5 = (0, 0, 0);
  wait var_1 / 2;

  if(self.origin[2] > var_3[2]) {
    physicsexplosionsphere(self.origin + (0, 1, 1), 3, 2, 10);
    return;
  }
}

function barrel_freeze() {
  if(istrue(self.frozen)) {
    return;
  }

  self.frozen = 1;
  self physicsstopserver();
}

function barrel_unfreeze() {
  if(!istrue(self.frozen)) {
    return;
  }

  self.frozen = 0;
  self physicslaunchserver();
}

function barrel_fulton(var_0) {
  var_1 = 15;
  var_2 = randomintrange(2300, 2800);
  var_3 = randomintrange(1, 3);
  self moveTo(self.origin + (0, 0, var_2), var_1, var_3, 4);
  wait var_1 * 0.66;
  barrel_wind_to_above_truck(var_0);
}

function barrel_wind_to_above_truck(var_0) {
  if(distance2d(self.origin, var_0) > 500) {
    var_1 = (var_0[0], var_0[1], self.origin[2]);
    self moveTo(var_1, 8, 3, 3);
    return;
  }
}

function truck_barrels_on_death(var_0) {
  if(!isDefined(var_0.attached_barrels) || var_0.attached_barrels.size <= var_0.settings.barrels_on_death) {
    return;
  }

  if(!isDefined(level._effect["grenadeexp_default"])) {
    level._effect["grenadeexp_default"] = loadfx("vfx/core/expl/grenadeexp_default");
  }

  var_1 = var_0.settings.barrels_on_death;

  for(var_2 = 0; var_2 < var_0.attached_barrels.size; var_2++) {
    if(istrue(var_0.attached_barrels[var_2].loot_marked)) {
      var_1 = -1;
      continue;
    }

    if(!isDefined(var_0.attached_barrels[var_2]) || !isDefined(var_0.attached_barrels[var_2].origin)) {
      continue;
    }

    var_3 = var_0.lastconfirmedpos;

    if(isDefined(var_3)) {
      if(distance2d(var_0.attached_barrels[var_2].origin, var_3) > 1200) {
        continue;
      }
    }

    if(isDefined(var_1) && var_1 > 0) {
      var_1--;
      continue;
    }

    if(isent(var_0.attached_barrels[var_2])) {
      var_4 = anglesToForward(var_0.attached_barrels[var_2].angles);
      playFX(scripts\engine\utility::getfx("grenadeexp_default"), var_0.attached_barrels[var_2].origin, var_4);

      if(soundexists("breach_c4_expl_trans")) {
        playsoundatpos(var_0.attached_barrels[var_2].origin, "breach_c4_expl_trans");
      }

      earthquake(0.4, 0.7, var_0.attached_barrels[var_2].origin, 800);
      playrumbleonposition("grenade_rumble", var_0.attached_barrels[var_2].origin);
      var_0.attached_barrels[var_2] delete();

      if(isDefined(var_0.attached_barrels[var_2].last_player)) {
        var_0.attached_barrels[var_2].last_player cameradefault();
        var_0.attached_barrels[var_2].last_player scripts\cp\utility::freezecontrolswrapper(0);

        if(istrue(var_0.attached_barrels[var_2].last_player.cantswitch)) {
          var_0.attached_barrels[var_2].last_player scripts\common\utility::allow_weapon_switch(1);
          var_0.attached_barrels[var_2].last_player.cantswitch = undefined;
        }

        var_0.attached_barrels[var_2].last_player scripts\cp\cp_kidnapper::setimmunetokidnapper(0);
        var_0.attached_barrels[var_2].last_player setclientomnvar("ui_securing_progress", 0);
        var_0.attached_barrels[var_2].last_player setclientomnvar("ui_securing", 0);
        thread barrel_cancel_animate_player(level);
      }
    }
  }

  convoy_update_label_to_loot_num(var_0);
}

function init_smuggler_loot_interaction() {
  for(var_0 = 0; var_0 < self.convoy.attached_barrels.size; var_0++) {
    if(istrue(self.convoy.attached_barrels[var_0].setup_interact)) {
      return;
    }

    var_1 = spawnStruct();
    var_1.origin = self.convoy.attached_barrels[var_0].origin;
    var_1.targetname = "interactible";
    var_1.script_noteworthy = "smuggler_loot_interaction";
    self.convoy.attached_barrels[var_0].interaction = var_1;
    self.convoy.attached_barrels[var_0].setup_interact = 1;
    temp_make_barrel_interactible(self.convoy.attached_barrels[var_0], self.origin);
  }

  wait 0.05;
}

function temp_make_barrel_interactible(var_0, var_1) {
  var_0 setHintString(&"CP_CONVOYS/LOOT_MARK");
  var_0 setCursorHint("HINT_BUTTON");
  var_0 sethintdisplayrange(1200);
  var_0 sethintdisplayfov(150);
  var_0 sethinticon("hud_icon_door_open");
  var_0 setuserange(112);
  var_0 setusefov(90);
  var_0 sethintonobstruction("show");
  var_0 setuseholdduration("duration_long");
  var_0 makeusable();
  thread temp_make_barrel_think(var_0);
  thread barrel_early_exit();
}

function temp_make_barrel_think(var_0) {
  self endon("death");
  GscBinSkip4(0x35);
}

function barrel_collect_chance() {
  var_0 = 10;
  var_1 = 0;

  if(level.obj_current_barrels_scanned < var_0) {
    var_1 = level.obj_current_barrels_scanned / var_0;
  } else {
    var_1 = 100;
  }

  return var_1 > randomintrange(0, 11);
}

function barrel_early_exit() {
  self endon("death");
  level waittill("delete_other_barrels");

  if(istrue(self.loot_marked)) {
    return;
  }

  barrel_freeze();
  self makeunusable();
  self hudoutlinedisable();
}

function reenable_barrel_interaction() {
  if(!istrue(self.loot_marked)) {
    for(var_0 = 0; var_0 < level.players.size; var_0++) {
      self enableplayeruse(level.players[var_0]);
    }

    barrel_unfreeze();
    return;
  }
}

function convoy_update_label_to_loot_num(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(true) {
    return;
  }

  var_1 = var_0 scripts\cp\cp_convoy_manager::get_smuggler_loot_amount();

  if(isDefined(var_1)) {
    if(var_1 <= 0) {
      objective_icon_show(var_0, 0);
      var_0 notify("convoy_all_loot_taken");
      return;
    }

    var_2 = get_nitrate_label(var_1);
    objective_icon_show_label(var_0, var_2);
    return;
  }
}

function barrel_handle_cancellation() {
  for(;;) {
    self waittill("trigger_progress", var_0);

    if(isDefined(var_0)) {
      if(!var_0 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      self.last_player = var_0;
      var_1 = 4096;

      if(distancesquared(self.origin, getclosestpointonnavmesh(self.origin)) < var_1) {
        thread barrel_animate_player(self, var_0);
      }

      var_0 cameraset("camera_custom_orbit_1");
      var_0 scripts\cp\utility::freezecontrolswrapper(1);
      var_0 scripts\cp\cp_kidnapper::setimmunetokidnapper(1);
      var_0 setclientomnvar("ui_securing", 1);
      var_0 scripts\common\utility::allow_weapon_switch(0);
      var_0.cantswitch = 1;
      barrel_freeze();

      for(var_2 = 0; var_2 < level.players.size; var_2++) {
        if(level.players[var_2] != var_0) {
          self disableplayeruse(level.players[var_2]);
        }
      }

      var_3 = 5;
      var_4 = 0;

      while(var_0 useButtonPressed() && var_4 < var_3) {
        var_0 setclientomnvar("ui_securing_progress", var_4 / var_3);
        wait 0.05;
        var_4 += 0.05;
      }

      self notify("captured", var_0);
      self.last_player = undefined;
      var_0 cameradefault();
      var_0 scripts\cp\utility::freezecontrolswrapper(0);
      var_0 scripts\cp\cp_kidnapper::setimmunetokidnapper(0);

      if(istrue(var_0.cantswitch)) {
        var_0 scripts\common\utility::allow_weapon_switch(1);
        var_0.cantswitch = undefined;
      }

      var_0 setclientomnvar("ui_securing_progress", 0);
      var_0 setclientomnvar("ui_securing", 0);
      thread barrel_cancel_animate_player(level);
      reenable_barrel_interaction();
    }
  }
}

#using_animtree("");

function barrel_setup_anims() {
  if(isDefined(level.scr_anim["player"]) && isDefined(level.scr_anim["player"]["scan_barrel"])) {
    return;
  }

  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["scan_barrel"][0] = $cp_fulton_group_player_1_hookup;
  level.scr_animname["player"]["scan_barrel"] = "cp_fulton_group_player_1_hookup";
  level.scr_eventanim["player"]["scan_barrel"][0] = "cp_fulton_group_player_1_hookup";
}

function barrel_animate_player(var_0, var_1) {
  if(!isDefined(level.scr_anim["player"]) || !isDefined(level.scr_anim["player"]["scan_barrel"])) {
    return;
  }

  var_2 = (0, vectortoangles(self.origin - var_1.origin)[1], 0);
  var_3 = vectorNormalize(var_1.origin - self.origin);
  var_3 *= 32;
  var_1.barrelscan_animscene = spawnStruct();
  var_4 = scripts\engine\utility::drop_to_ground(self.origin + var_3);
  var_1.barrelscan_animscene.origin = var_4;
  var_1.barrelscan_animscene.angles = var_2;
  var_5 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_1, "player", 1, 0, 1);
  var_1.barrelscan_animactor = var_5;
  var_5 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  var_6 = var_1.barrelscan_animscene scripts\cp_mp\anim_scene::anim_scene_loop([var_5], "scan_barrel");
  var_1.barrelscan_animscene = undefined;
}

function barrel_cancel_animate_player(var_0) {
  if(isDefined(var_0.barrelscan_animscene)) {
    var_0.barrelscan_animscene scripts\cp_mp\anim_scene::anim_scene_stop_actor(var_0.barrelscan_animactor);
    var_0.barrelscan_animscene scripts\cp_mp\anim_scene::anim_scene_stop(1);
    return;
  }
}

function smuggler_loot_hint_func(var_0, var_1) {
  return &"CP_CONVOYS/LOOT_MARK";
}

function smuggler_loot_activate_func(var_0, var_1) {
  var_1 endon("disconnect");

  if(istrue(var_0.disabled)) {
    return;
  }

  if(istrue(var_1.tablet_out)) {
    return;
  }
}

function smuggler_loot_init_func(var_0) {
  level endon("game_ended");
  level.pentskipfov["smuggler_loot_interaction"] = 1;

  foreach(var_2 in var_0) {
    var_2.p_ent_skip_fov = 1;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
    scripts\cp\coop_personal_ents::addtopersonalinteractionlist(var_2);
  }
}

function smuggler_collect_loot() {
  if(istrue(level.smuggler_disable_loots)) {
    return;
  }

  if(!isDefined(level.smuggler_loot_collected)) {
    level.smuggler_loot_collected = 0;
  }

  if(!isDefined(level.smuggler_loot_max)) {
    level.smuggler_loot_max = 5;
  }

  level.smuggler_loot_collected++;
  thread print_nitrate_text(level);

  foreach(var_1 in level.players) {
    var_1 iprintlnbold("^3 Nitrate Marked: " + level.smuggler_loot_collected + " / " + level.smuggler_loot_max);
  }

  if(level.smuggler_loot_collected >= level.smuggler_loot_max) {
    thread smuggler_temp_ending();
    return;
  }
}

function smuggler_loot_despawn(var_0) {
  level endon("game_ended");
  self endon("death");
  var_1 = self.owner;
  var_2 = var_0 * var_0;

  for(;;) {
    wait 1;

    if(!scripts\cp\utility::any_player_nearby(self.origin, var_2)) {
      break;
    }
  }

  if(isDefined(self.trackers) && self.trackers.size > 0) {
    foreach(var_4 in self.trackers) {
      var_4 stoploopsound();
      var_4 delete();
    }
  }

  self delete();
  convoy_update_label_to_loot_num(var_1.convoy);
}

function smuggler_temp_ending() {
  level.smuggler_disable_loots = 1;
  level notify("convoy_mission_complete");
  wait 3;
}

function get_nitrate_label(var_0) {
  var_1 = &"";

  if(!isDefined(var_0)) {
    return var_1;
  }

  switch (var_0) {
    case 1:
      var_1 = &"CP_CONVOYS/STR_1";
      break;
    case 2:
      var_1 = &"CP_CONVOYS/STR_2";
      break;
    case 3:
      var_1 = &"CP_CONVOYS/STR_3";
      break;
    case 4:
      var_1 = &"CP_CONVOYS/STR_4";
      break;
    case 5:
      var_1 = &"CP_CONVOYS/STR_5";
      break;
    case 6:
      var_1 = &"CP_CONVOYS/STR_6";
      break;
    case 7:
      var_1 = &"CP_CONVOYS/STR_7";
      break;
    case 8:
      var_1 = &"CP_CONVOYS/STR_8";
      break;
    case 9:
      var_1 = &"CP_CONVOYS/STR_9";
      break;
    case 10:
      var_1 = &"CP_CONVOYS/STR_10";
      break;
    case 11:
      var_1 = &"CP_CONVOYS/STR_11";
      break;
    case 12:
      var_1 = &"CP_CONVOYS/STR_12";
      break;
    case 13:
      var_1 = &"CP_CONVOYS/STR_13";
      break;
    case 14:
      var_1 = &"CP_CONVOYS/STR_14";
      break;
    case 15:
      var_1 = &"CP_CONVOYS/STR_15";
      break;
    case 16:
      var_1 = &"CP_CONVOYS/STR_16";
      break;
    case 17:
      var_1 = &"CP_CONVOYS/STR_17";
      break;
    case 18:
      var_1 = &"CP_CONVOYS/STR_18";
      break;
    case 19:
      var_1 = &"CP_CONVOYS/STR_19";
      break;
    case 20:
      var_1 = &"CP_CONVOYS/STR_20";
      break;
  }

  return var_1;
}

function print_nitrate_text(var_0) {
  if(isDefined(level.convoy_hud_text)) {
    level.convoy_hud_text destroy();
  }

  var_1 = newhudelem();
  var_1.alignx = "left";
  var_1.aligny = "top";
  var_1.x = -32;
  var_1.y = 47;
  var_2 = get_nitrate_label(var_0);
  var_1 settext(var_2);
  var_1.fontscale = 1;
  var_1.alpha = 1;
  level.convoy_hud_text = var_1;
}

function waittillcompromised(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("event_convoy_delete");

  if(isDefined(var_1.eventname) && var_1.eventname != "") {
    level endon("debug_" + var_1.eventname + "_completed");
  }

  self endon("death");
  var_1 endon("convoy_compromised_early");

  if(!isDefined(var_1.backup_soldiers)) {
    var_1.backup_soldiers = [];
  }

  wait 1;

  if(isDefined(self.type) && (var_1.settings.amount_to_compromise > 0 || istrue(var_1.settings.center_compromises) && self.type == "mkilo") && var_1.alive_support_vehicles > 0) {
    while((self.convoy.alive_support_vehicles > 0 || var_1.backup_soldiers.size > 0) && istrue(self.convoy.not_compromised)) {
      wait 0.5;
    }

    while(!istrue(self.arrived_at_goal) && !istrue(var_1.settings.can_compromise_before_first_target) && !istrue(self.convoy.settings.roaming)) {
      wait 0.5;
    }

    if(isDefined(var_1.main_truck) && self != var_1.main_truck) {
      return;
    }

    foreach(var_3 in self.convoy.spawned_vehicles) {
      if(isalive(var_3)) {
        var_3 vehicle_setspeed(0, 150, 150);
        var_3.disable_leave_truck = 0;
      }

      var_3 notify("stop_follow_path");
      self.convoy notify("convoy_compromised");
    }

    self notify("unload_guys", "compromised");
    self notify("stop_follow_path");
    self.convoy notify("convoy_compromised");

    if(istrue(self.convoy.settings.route_to_other_veh) && istrue(self.convoy.settings.route_to_any_veh) && istrue(self.convoy.not_compromised)) {
      thread route_spawned_soldiers_to_new_vehicle();
      return;
    }

    if(check_backup_is_set(self.convoy)) {
      thread route_soldiers_towards_backup_location(level);
      return;
    }

    return;
  }
}

function waittillarriveatdestination(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("convoy_compromised");
  var_1 endon("event_convoy_delete");
  jumpiffalse(isDefined(self.type) && self.type != "mkilo") LOC_00000031;
  return;
}

function stop_all_convoy_cars(var_0) {
  if(!istrue(self.convoy.settings.enable_stop_all_cars)) {
    return;
  }

  foreach(var_2 in self.convoy.spawned_vehicles) {
    if(isalive(var_2)) {
      if(!istrue(var_0)) {
        var_2 notify("unload_guys", "stop_all_convoy_cars");
      }

      var_2 notify("stop_follow_path");
      var_2 vehicle_setspeedimmediate(0, 120, 120);
      var_2.veh_brake = 1;
      var_2.disable_horn = 1;
    }
  }
}

function spawn_soldiers_route_to_hvt(var_0) {
  var_0 = self.convoy.using_path;
  thread stop_all_convoy_cars();
  wait 1;
  var_1 = undefined;

  if(isent(self.convoy.settings.target)) {
    var_1 = self.convoy.settings.target;
  }

  if(isDefined(self.convoy.targeted_hvt)) {
    var_1 = self.convoy.targeted_hvt;
  }

  if(!isDefined(var_1)) {
    var_1 = getEnt("objective_convoy_civilian_" + var_0, "targetname");
  }

  if(!isDefined(var_1)) {
    var_1 = getEnt(self.convoy.settings.target, "script_noteworthy");
    self.convoy.targeted_hvt = var_1;
  }

  if(!isDefined(var_1)) {
    if(isDefined(self.convoy.settings.target)) {
      wait 15;
      var_1 = getEnt(self.convoy.settings.target, "script_noteworthy");
      self.convoy.targeted_hvt = var_1;
    } else {
      return;
    }

    if(!isDefined(self.convoy.targeted_hvt)) {
      self.convoy.exiting = 1;
      self.convoy notify("event_convoy_exit");
      return;
    }
  }

  self.convoy notify("convoy_hvtent_set");

  if(!istrue(var_1.carried_by_vehicle) && !(isDefined(var_1.carrier) && isPlayer(var_1.carrier))) {
    var_1 unlink();
  }

  var_2 = self;

  if(isDefined(self.convoy.main_truck)) {
    var_2 = self.convoy.main_truck;
  }

  if(istrue(self.convoy.settings.route_to_any_veh)) {
    thread waittill_hvt_at_vehicle(var_2, var_1);
  }

  if(!isDefined(self.riders) || self.riders.size == 0) {
    return;
  }

  if(isDefined(self.type) && self.type == "mkilo") {
    if(istrue(self.convoy.settings.recruit_enable)) {
      thread temp_spawn_backup_on_apc(var_1);
    }

    var_3 = self.riders.size;
    var_4 = [];

    foreach(var_6 in self.riders) {
      if(isalive(var_6)) {
        var_4 = var_6;
      }
    }

    var_8 = int(var_4.size / 4 * 3);
    var_8 = var_4.size;
    self.convoy.convoy_hvt_squad_alive = var_8;
    self.convoy_apc_spawned_riders = [];

    foreach(var_10 in var_4) {
      self.convoy_apc_spawned_riders[self.convoy_apc_spawned_riders.size] = var_10;
    }

    for(var_12 = 0; var_12 < var_8; var_12++) {
      apply_apc_soldier_settings(var_4[var_12], var_1, self.convoy);
      var_4[var_12].convoy = self.convoy;
    }

    return;
  }
}

function route_spawned_soldiers_to_new_vehicle() {
  if(!isDefined(self.convoy.backup_soldiers)) {
    return;
  }

  if(istrue(self.convoy.exiting)) {
    return;
  }

  if(self.type == "mkilo") {
    if(!istrue(self.convoy.exiting)) {
      if(isDefined(self.convoy.main_truck)) {
        self.convoy.main_truck notify("new_main_convoy_chosen");
      }

      foreach(var_1 in self.convoy.spawned_vehicles) {
        if(can_route_othercar(var_1)) {
          thread waittill_hvt_at_vehicle(var_1, self.convoy.targeted_hvt);

          if(self.convoy.backup_soldiers.size > 0) {
            foreach(var_3 in self.convoy.backup_soldiers) {
              if(isalive(var_3)) {
                var_3.truck = var_1;
              }

              if(istrue(self.convoy.targeted_hvt.pickedup)) {
                send_convoy_soldier_here(var_3, var_1.origin);

                if(istrue(var_3.has_hvt)) {
                  var_3.goalradius = 50;
                } else {
                  var_3.goalradius = 250;
                }
              }

              var_1.riders[var_1.riders.size] = var_3;
            }
          }

          break;
        }
      }

      return;
    }

    return;
  }
}

function can_route_othercar(var_0) {
  if(!istrue(self.convoy.settings.route_to_any_veh)) {
    return false;
  }

  if(isDefined(var_0) && isalive(var_0) && var_0 != self) {
    if(var_0.type != "mkilo" && istrue(self.convoy.settings.route_to_other_support_veh)) {
      return true;
    } else if(var_0.type == "mkilo") {
      return true;
    }
  }

  return false;
}

function pulse_soldiers_to_help_convoy() {
  level endon("game_ended");
  self endon("event_convoy_delete");
  self endon("event_convoy_exit");
  level notify("pulse_soldiers_convoy");
  level endon("pulse_soldiers_convoy");

  if(!isDefined(self.targeted_hvt)) {
    if(isent(self.settings.target)) {
      var_0 = self.settings.target;
    } else {
      var_0 = getEnt(self.settings.target, "script_noteworthy");
    }

    self.targeted_hvt = var_0;
  }

  if(!isDefined(self.targeted_hvt)) {
    return;
  }

  self.targeted_hvt endon("death");
  var_1 = self.settings.recruit_time_until;
  wait var_1;
  GscBinSkip4(0x6e, self.targeted_hvt, self);
}

function grab_nearby_soldiers_and_apply_settings(var_0) {
  var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_1 = sortbydistance(var_1, self.origin);
  var_2 = var_0.settings.recruit_distance * var_0.settings.recruit_distance;

  if(!isDefined(var_0.backup_soldiers)) {
    var_0.backup_soldiers = [];
  }

  foreach(var_4 in var_1) {
    if(!(isDefined(var_4) && isalive(var_4))) {
      continue;
    }

    if(!isDefined(var_4.agent_type)) {
      continue;
    }

    if(distance2dsquared(self.origin, var_4.origin) > var_2) {
      continue;
    }

    if(!istrue(var_0.settings.recruit_juggs) && var_4 scripts\cp\cp_modular_spawning::is_juggernaut_aitype()) {
      continue;
    }

    if(isDefined(var_4.agent_type) && istrue(var_4.agent_type == "juggernaut")) {
      continue;
    }

    if(isDefined(var_4.aitype) && istrue(var_4.aitype == "juggernaut")) {
      continue;
    }

    if(isDefined(var_4.aitype) && istrue(var_4.aitype == "suicidebomber")) {
      continue;
    }

    if(isDefined(var_0.main_truck.riders) && scripts\engine\utility::array_contains(var_0.main_truck.riders, var_4)) {
      continue;
    }

    apply_apc_soldier_settings(var_4, undefined, var_0);
  }
}

function apply_apc_soldier_settings(var_0, var_1) {
  if(!isDefined(var_0)) {
    if(isDefined(var_1.targeted_hvt)) {
      var_0 = var_1.targeted_hvt;
    }
  }

  if(!isDefined(var_1.backup_soldiers)) {
    var_1.backup_soldiers = [];
  }

  if(!scripts\engine\utility::array_contains(var_1.backup_soldiers, self) && var_1.backup_soldiers.size < var_1.settings.recruit_amount) {
    var_1.backup_soldiers[var_1.backup_soldiers.size] = self;
    thread waittillarriveathvt(var_0, var_1);
    thread waittill_backup_death(var_1);

    if(isDefined(self.script_origin_other)) {
      self.script_origin_other = undefined;
    }

    if(!scripts\cp\cp_modular_spawning::is_juggernaut_aitype()) {
      scripts\engine\utility::set_movement_speed(230);
    }

    if(isDefined(var_1)) {
      self.convoy = var_1;
    }

    scripts\cp\cp_squadmanager::removefromsquad();
    return;
  }
}

function waittill_backup_death(var_0) {
  var_0 endon("event_convoy_delete");
  level endon("game_ended");
  self waittill("death");
  var_0.backup_soldiers = scripts\engine\utility::array_remove(var_0.backup_soldiers, self);
}

function temp_spawn_backup_on_apc(var_0) {
  self endon("death");
  self.convoy endon("convoy_compromised");
  level endon("game_ended");
  self.convoy endon("event_convoy_exit");
  jumpiffalse(getdvarint("scr_event_convoy_disablebackup", 0) == 1) LOC_00000037;
  return;
}

function waittillarriveathvt(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("event_convoy_delete");
  var_1 endon("event_convoy_exit");
  self notify("apply_convoy_soldier_settings");
  self endon("apply_convoy_soldier_settings");
  var_0 endon("death");
  var_2 = 60;
  var_3 = var_2 * var_2;
  var_4 = 400;
  var_5 = var_4 * var_4;

  while(isalive(self) && !scripts\engine\utility::doinglongdeath()) {
    if(!isalive(self)) {
      return;
    }

    if(scripts\engine\utility::doinglongdeath()) {
      return;
    }

    if(!istrue(var_0.pickedup) && !istrue(var_0.carried)) {
      while(distancesquared(self.origin, var_0.origin) > var_3) {
        if(istrue(var_0.pickedup) || istrue(var_0.carried)) {
          break;
        }

        wait 1;

        if(isalive(self)) {
          send_convoy_soldier_here(var_0.origin);

          if(!event_can_pickup_hvt(var_0, var_1)) {
            self.goalradius = var_1.settings.goal_distance;
            continue;
          }

          scripts\engine\utility::set_movement_speed(190);
          self.goalradius = 80;
        }
      }

      if(isalive(self) && !istrue(var_0.pickedup) && !istrue(var_0.carried) && !istrue(var_0.pickup_disabled) && event_can_pickup_hvt(var_0, var_1) && !istrue(players_nearby_hvt(var_0)) && !istrue(self.little_bird_mg_cp_createfromstructs)) {
        if(istrue(var_0.carried_by_vehicle)) {
          if(istrue(var_1.settings.can_steal_hvt)) {
            self.goalradius = 450;
            thread convoy_steal_hvt_from_player_car();
          } else {
            self.goalradius = 1200;
          }

          wait 1;
        } else if(var_1.vehicles_remaining <= 0 && !isDefined(var_1.settings.backup_deposit_names)) {
          self.goalradius = 4000;
          wait 1;
        } else {
          thread first_hvt_pickup(var_0, var_1);
          thread monitor_hvt_pickup(var_0, var_1);
          convoy_pickup_hvt_settings(var_0, var_1);
        }
      }
    } else if(istrue(var_0.pickedup)) {
      take_cover_near_hvt(var_1);
    }

    var_6 = randomfloatrange(2, 4);
    wait var_6;
  }
}

function convoy_steal_hvt_from_player_car() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getclosest(self.origin, level.vehicle_travel_array);

  if(!isDefined(var_0)) {
    return;
  }

  if(var_0 vehicle_getspeed() > 1) {
    return;
  }

  if(!istrue(var_0.stealing_hvt)) {
    var_0.stealing_hvt = 1;
    wait 1.5;

    if(isDefined(var_0)) {
      var_0.stealing_hvt = 0;

      if(var_0 vehicle_getspeed() > 1) {
        return;
      }

      if(isalive(self) && isDefined(var_0) && isDefined(var_0.hostage)) {
        var_1 = level.vehicle_interaction_info["retrieve_hostage"];
        scripts\cp\maps\cp_br_syrk\vehicle_travel::exit_retrieve_hostage(var_1, self, var_0);
        return;
      }

      return;
    }

    return;
  }
}

function convoy_pickup_hvt_settings(var_0, var_1) {
  var_0.pickedup = 1;
  var_0.pickup_disabled = 1;
  var_0 makeunusable();

  if(isDefined(var_0.trigger)) {
    var_0.trigger makeunusable();
  }

  if(isDefined(var_0.interaction_handle)) {
    var_0.interaction_handle makeunusable();
  }

  binoculars_setexpirationtimer(var_0, var_1);

  if(!isalive(self) || scripts\engine\utility::doinglongdeath()) {
    return;
  }

  var_2 = "tag_stowed_back";
  var_3 = 0;
  var_4 = undefined;

  if(istrue(var_1.settings.pickup_uses_origin)) {
    var_3 = -768;
    var_2 = "tag_origin";
  }

  var_0 linkTo(self, var_2, (0, 0, var_3), (0, 0, 0));
  self.has_hvt = 1;
  self.dontkilloff = 1;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.maxhealth = 400;
  self.health = self.maxhealth;
  scripts\common\utility::demeanor_override("sprint");
  self.scripted_mode = 1;
  var_0.carrier = self;
  self notify("get_enemy_info_loop");
  var_0 setCanDamage(0);
  var_0.scripted_mode = 1;

  if(!isDefined(var_0.bodymodel)) {
    var_0.bodymodel = var_0.model;
  }

  self.default_starting_pistol = level.players[0].default_starting_pistol;

  if(istrue(var_1.settings.hide_icon_on_pickup)) {
    objective_icon_show(var_1, 0);
  }

  self setcarryobject("hostage_mage");

  if(isDefined(var_0.waypoint)) {
    if(isDefined(var_0.sethotfunc)) {
      var_0 thread[[var_0.sethotfunc]](1);
    }
  }

  if(isagent(var_0)) {
    if(isDefined(var_0.head)) {
      var_0.head setModel("head_usmc_ar_invisible");
    }

    var_0 setModel("body_usmc_ar_invisible");
    var_0 scripts\cp\cp_vip::disable_outline();

    if(isDefined(var_0.objnum)) {
      objective_setzoffset(var_0.objnum, 768);
      return;
    }

    return;
  }

  var_0 hide();

  if(isDefined(var_0.body)) {
    var_0.body hide();
  }

  if(isDefined(var_0.head)) {
    var_0.head hide();
    return;
  }
}

function binoculars_setexpirationtimer(var_0, var_1) {
  if(isai(self)) {
    self.scripted_mode = 1;
    self.restoreweapon = self.ref_1237E;
    self takeweapon(self.weapon);
    var_0.clearandrestoreinfectedtacinsert = 1;
    var_0.play_trialympic_flames = 1;
    var_2 = spawn("script_origin", var_0.origin);
    var_2.origin = var_0.origin;
    var_2.angles = var_0.angles;
    self.ref_12F89 = var_2;
    self.ref_12F89 scripts\common\anim::anim_first_frame_solo(var_0.body, "pickup_hvt_ground");
    thread binoculars_setpendingtimer(self.ref_12F89, self);
    scripts\asm\shared\mp\utility::burningpartlogic("sdr_cp_hostage_pickup_ground_player", self.ref_12F89, undefined, 0, "animscripted2");
  }

  if(isDefined(self.ref_12F89)) {
    self.ref_12F89 delete();
    self.ref_12F89 = undefined;
  }

  var_0.clearandrestoreinfectedtacinsert = 0;

  if(!isalive(self)) {
    return false;
  }

  if(isDefined(self.restoreweapon)) {
    self giveweapon(self.restoreweapon);
  }

  self.scripted_mode = 0;
  scripts\asm\shared\mp\utility::bunkercounteruav();
  var_0.play_trialympic_flames = 0;
  return true;
}

function binoculars_setpendingtimer(var_0, var_1) {
  var_1 endon("death");
  var_2 = "pickup_hvt_ground";
  var_1.body endon(var_2);
  var_1.body childthread scripts\common\anim::anim_single_solo(var_1.body, var_2);
  var_0 waittill("death");

  if(isDefined(var_1.idleanim)) {
    var_1.body scriptmodelplayanim(var_1.idleanim);

    if(isDefined(var_1.head)) {
      var_1.head scriptmodelplayanim(var_1.idleanim);
    }
  }

  var_1.body notify(var_2);
}

function event_can_pickup_hvt(var_0) {
  return (isDefined(self.convoy_can_pickup) && istrue(self.convoy_can_pickup) || !isDefined(self.convoy_can_pickup)) && isDefined(var_0.settings) && istrue(var_0.settings.can_pickup_hvt);
}

function players_nearby_hvt(var_0) {
  var_1 = 165;
  var_2 = var_1 * var_1;

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    if(!level.players[var_3] scripts\cp_mp\utility\player_utility::_isalive() || istrue(level.players[var_3].inlaststand)) {
      continue;
    }

    if(distancesquared(level.players[var_3].origin, var_0.origin) > var_2) {
      continue;
    }

    return true;
  }

  return false;
}

function first_hvt_pickup(var_0, var_1) {
  if(!istrue(var_1.target_first_interacted)) {
    var_0 notify("convoy_pickedup_hvt");
    var_1.target_first_interacted = 1;
    var_1.target_first_interacted_routing = 1;
    take_cover_near_hvt(var_1);
    wait 1.25;
    var_1.target_first_interacted_routing = undefined;
    take_cover_near_hvt(var_1);
    wait 2.25;

    if(isalive(self) && isDefined(var_1.main_truck)) {
      if(istrue(var_1.settings.toggle_vo_on_hvt_pickup)) {
        if(!isDefined(self.played_convoy_vo)) {
          level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_convoy_success_safe_10", "allies");
          wait 1.15;
          level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/CONVOY_5");
          self.played_convoy_vo = 1;
        } else {
          level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_convoy_pilot_captured_10", "allies");
          wait 1.15;
          level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/CONVOY_6");
          self.played_convoy_vo = undefined;
        }
      }
    }

    wait 6;
    var_1.target_first_interacted = undefined;
    return;
  }
}

function take_cover_near_hvt(var_0) {
  if(istrue(var_0.target_first_interacted_routing) && level.gameskill <= 2) {
    send_convoy_soldier_here(self.origin);
    self.goalradius = 1500;
    return;
  }

  if(isDefined(var_0.main_truck) && isalive(var_0.main_truck) && !istrue(var_0.exiting) && istrue(var_0.settings.route_to_any_veh) && istrue(var_0.not_compromised)) {
    var_1 = getstartorigin(var_0.main_truck.origin, var_0.main_truck.angles, %sdr_cp_hostage_dropoff_mkilo23_carry_smuggler);
    send_convoy_soldier_here(var_1, var_0);
  } else if(check_backup_is_set(var_0)) {
    thread route_soldiers_towards_backup_location(level);
  }

  if(istrue(self.has_hvt)) {
    self.goalradius = 50;
    return;
  }

  self.goalradius = 600;
}

function send_convoy_soldier_here(var_0, var_1, var_2) {
  var_3 = getclosestpointonnavmesh(var_0);

  if(isDefined(var_1)) {
    var_1.convoy_board_pos = var_3;
  }

  self setgoalpos(var_3);

  if(istrue(var_2)) {
    thread little_bird_mg_cp_initlate(var_3);
    return;
  }

  self notify("tracking_getto_ignore");
}

function little_bird_mg_cp_initlate(var_0) {
  level endon("game_ended");
  self endon("death");
  self notify("tracking_getto_ignore");
  self endon("tracking_getto_ignore");
  var_1 = 14400;
  self.ignoreall = 1;

  for(;;) {
    if(distancesquared(self.origin, var_0) < var_1) {
      self.ignoreall = 0;
    }

    wait 1;
  }
}

function monitor_hvt_pickup(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("event_convoy_delete");
  var_1 endon("event_convoy_exit");
  level notify("monitor_convoy_hvt");
  level endon("monitor_convoy_hvt");
  wait 0.1;

  while(istrue(var_0.clearandrestoreinfectedtacinsert)) {
    waitframe();
  }

  var_2 = 200;
  var_3 = var_2 * var_2;

  while(isalive(self) && !scripts\engine\utility::doinglongdeath()) {
    wait 0.1;

    if(distance2dsquared(self.origin, var_0.origin) > var_3) {
      var_0.origin = self.origin;
      var_0 linkTo(self, "tag_stowed_back", (0, 0, 0), (0, 0, 0));
    }

    if(isDefined(var_0.carrier)) {
      if(var_0.carrier != self) {
        break;
      }
    }
  }

  if(isagent(var_0)) {
    if(isDefined(var_0.head)) {
      var_0.head setModel(var_0.head.oldhead);
    }

    var_0 setModel(var_0.bodymodel);
    var_0 scripts\cp\cp_vip::enable_outline();

    if(isDefined(var_0.objnum)) {
      objective_setzoffset(var_0.objnum, 75);
    }
  } else {
    var_0 show();

    if(isDefined(var_0.body)) {
      var_0.body show();
    }

    if(isDefined(var_0.head)) {
      var_0.head show();
    }
  }

  if(isDefined(var_0.waypoint)) {
    if(isDefined(var_0.sethotfunc)) {
      var_0 thread[[var_0.sethotfunc]](1);
    }
  }

  var_0 unlink();
  self.dontkilloff = 0;
  var_0.pickedup = 0;
  var_0.pickup_disabled = 0;
  self.has_hvt = 0;
  self.ignoreall = 0;
  var_0 setCanDamage(1);
  var_0.scripted_mode = 0;

  if(isDefined(var_0.trigger)) {
    var_0.trigger makeusable();
  }

  if(isDefined(var_0.interaction_handle)) {
    var_0.interaction_handle makeusable();
  }

  if(!istrue(var_0.play_trialympic_flames)) {
    var_4 = scripts\cp\cp_pickup_hostage::get_hostage_drop_pos(self);
    var_4 = scripts\cp\cp_pickup_hostage::_getphysicspointaboutnavmesh(var_4) + (0, 0, 2);
    var_0.origin = var_4;
    var_0.angles = (0, var_0.angles[1], 0);
  }

  var_0 thread scripts\cp\cp_pickup_hostage::spawn_module_building_chopper2(self);

  if(isDefined(var_0.idleanim)) {
    var_0.body scriptmodelplayanim(var_0.idleanim);

    if(isDefined(var_0.head)) {
      var_0.head scriptmodelplayanim(var_0.idleanim);
    }
  }

  hvt_ent_delete_wm(var_1);
  objective_icon_show(var_1, 1);
}

function hvt_ent_delete_wm(var_0) {
  var_1 = undefined;

  if(isDefined(self.wmhostage)) {
    var_1 = self.wmhostage;
  }

  if(isDefined(var_0.soldier_wmhostage)) {
    var_1 = var_0.soldier_wmhostage;
  }

  self resetcarryobject();

  if(isDefined(var_1)) {
    var_1 unlink();

    if(isDefined(var_1.head)) {
      var_1.head delete();
    }

    var_1 delete();
    var_1 = undefined;
    return;
  }
}

function spawnheliactorsfunc(var_0) {
  level endon("game_ended");
  self endon("death");
  objective_icon_show(var_0.convoy, 1);
  var_1 = var_0.convoy.settings.toggle_vo_on_hvt_rescued;
  self unlink();
  wait 0.5;
  self.origin = getclosestpointonnavmesh(self.origin) + (0, 0, 10);
  var_2 = scripts\cp\cp_pickup_hostage::get_hostage_drop_pos(self);
  var_2 = scripts\cp\cp_pickup_hostage::_getphysicspointaboutnavmesh(var_2) + (0, 0, 2);
  self.origin = var_2;
  self.angles = (0, self.angles[1], 0);
  wait 5;

  if(istrue(var_1)) {
    thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/CONVOY_4");
    level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_convoy_success_exfil_10", "allies");
    return;
  }
}

function waittill_hvt_at_vehicle(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  level endon("game_ended");
  var_1 endon("event_convoy_delete");
  var_1 endon("event_convoy_exit");
  self endon("death");
  var_0 endon("death");
  var_1.main_truck endon("new_main_convoy_chosen");
  var_1.main_truck = self;
  var_2 = 96;
  var_3 = var_2 * var_2;

  for(;;) {
    wait 0.5;

    if(!isDefined(var_1.convoy_board_pos)) {
      continue;
    }

    var_4 = distance2dsquared(var_1.convoy_board_pos, var_0.origin);

    if(var_4 > var_3) {
      continue;
    }

    if(!istrue(var_0.pickedup)) {
      continue;
    }

    if(istrue(var_0.carried_by_vehicle)) {
      continue;
    }

    if(istrue(var_0.carried) || isDefined(var_0.carrier) && isPlayer(var_0.carrier)) {
      continue;
    }

    break;
  }

  GscBinSkip4(0x35, var_0, var_1, 1);
}

function attach_hvt_to_vehicle(var_0, var_1, var_2) {
  var_0 unlink();
  var_0.pickedup = 0;
  var_0.pickup_disabled = 0;

  if(isDefined(var_0.carrier)) {
    var_0.carrier.tugofwar_anim = "htf_pop_020_trafficking_enemy_04_load_cp";
    var_0.carrier notify("tugofwar_playanim");
  }

  var_3 = (0, 0, 130);

  if(self.type == "techo") {
    var_3 = (0, 0, 86);
  }

  var_4 = "tag_origin";

  if(isagent(var_0)) {
    var_4 = "tag_windshield_back";
  }

  if(istrue(var_1.no_tarp)) {
    var_4 = "tag_accessory_01";
    var_3 = (-96, 0, -13);
  }

  var_0 linkTo(self, var_4, var_3, (0, 180, 0));
  var_0 setuseholdduration("duration_medium");

  if(isDefined(var_0.interaction_handle)) {
    var_0.interaction_handle makeusable();
  }

  if(!isagent(var_0)) {
    var_0 makeusable();
  }

  self.has_hvt = 1;
  var_0.convoy_pickedup = 1;
  var_0.carried_by_vehicle = 1;
  var_1.has_hvt = 1;

  if(isDefined(var_0.idleanim)) {
    var_0.body scriptmodelplayanim(var_0.idleanim);

    if(isDefined(var_0.head)) {
      var_0.head scriptmodelplayanim(var_0.idleanim);
    }
  }

  if(isDefined(var_0.carrier)) {
    if(istrue(var_0.dontkilloff)) {
      var_0.dontkilloff = 0;
    }

    thread hvt_ent_delete_wm(var_0.carrier);
  }

  if(istrue(self.convoy.settings.pickup_uses_origin)) {
    var_0 setCanDamage(0);
    var_0.ignoreme = 1;
    var_0.scripted_mode = 1;
    var_0.ignoreall = 1;
  }

  objective_icon_show(self.convoy, 1);

  if(isagent(var_0)) {
    if(isDefined(var_0.head)) {
      var_0.head setModel(var_0.head.oldhead);
    }

    var_0 setModel(var_0.bodymodel);
    var_0 scripts\cp\cp_vip::enable_outline();

    if(isDefined(var_0.objnum)) {
      objective_setzoffset(var_0.objnum, 75);
    }
  } else {
    var_0 show();

    if(isDefined(var_0.body)) {
      var_0.body show();
    }

    if(isDefined(var_0.head)) {
      var_0.head show();
    }

    if(isDefined(var_0.waypoint)) {
      if(isDefined(var_0.sethotfunc)) {
        var_0 thread[[var_0.sethotfunc]](1);
      }
    }

    thread spawnintermission_nocam(level, var_0);
  }

  if(istrue(var_2)) {
    convoy_force_exit();
    return;
  }
}

function convoy_force_exit() {
  self.convoy.exiting = 1;
  self.convoy notify("event_convoy_exit");
}

function spawnintermission_nocam(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 waittill("player_picked_up_hostage");

  if(isDefined(var_0.waypoint)) {
    if(isDefined(var_0.sethotfunc)) {
      var_0 thread[[var_0.sethotfunc]](0);
    }

    var_0 notify("freedobjective");
    scripts\cp\cp_objectives::freeworldid("pickup_hostage");
    objective_delete(var_0.waypoint);
    var_0.waypoint = undefined;
  }

  if(isDefined(var_1)) {
    var_1 notify("convoy_compromised_early");

    foreach(var_3 in var_1.spawned_vehicles) {
      if(isent(var_3) && istrue(var_3.has_hvt)) {
        var_3.has_hvt = undefined;
      }
    }
  }

  if(check_backup_is_set(var_1)) {
    thread route_soldiers_towards_backup_location(level);
    return;
  }
}

function waittill_return_to_truck(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("event_convoy_delete");
  var_1 waittill("event_convoy_exit");
  var_0 = var_1.using_path;
  GscBinSkip4(0x6e, level, var_0, var_1);
}

function send_out_convoy_towards_exit(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("event_convoy_delete");
  var_1 endon("convoy_compromised");
  var_2 = 16;
  var_3 = getdvarint("scr_event_convoy_exitspeed", 0);

  if(var_3 > 0) {
    var_2 = var_3;
  }

  if(var_2 > 400) {
    var_2 = 400;
  }

  wait 9;
  var_1 notify("convoy_exiting_after_pickup");
  level notify("convoy_exiting_after_pickup", var_1);
  var_1.allowed_to_exit = 1;
}

function slow_down_if_leader() {
  if(isDefined(self.type) && self.type != "mkilo") {
    return;
  }

  var_0 = undefined;
  var_1 = 1.5;
  var_2 = 2000;

  for(;;) {
    if(isDefined(self.leading_veh)) {
      var_0 = self.veh_speed;
      self.speed_override = 5;
      var_3 = self.leading_veh / var_2 * var_1;
      wait var_3;
      self.speed_override = var_0;
    }

    wait 10;
  }
}

function adjust_vehicle_speed_on_player_dist() {
  level endon("game_ended");
  self.convoy endon("event_convoy_delete");
  self.convoy endon("convoy_compromised");
  self endon("death");
  self endon("unload_guys");
  self notify("adjusting_player_speed");
  self endon("adjusting_player_speed");

  if(isDefined(self.type) && self.type != "mkilo") {
    return;
  }

  if(!self vehicle_isphysveh()) {
    return;
  }

  var_0 = 2500;
  var_1 = var_0 * var_0;

  while(isalive(self)) {
    wait 0.5;

    if(!isDefined(level.vehicle_travel_array)) {
      continue;
    }

    var_2 = scripts\engine\utility::getclosest(self.origin, level.vehicle_travel_array, var_0);

    if(!isDefined(var_2)) {
      self.convoy.main_truck.following_player = undefined;

      if(isalive(self) && self vehicle_isphysveh() && isDefined(self.current_path) && !istrue(self.disable_set_speed)) {
        set_convoy_vehicle_speed(self.current_path.speed, 30, 30);
      }

      continue;
    }

    self.convoy.main_truck.following_player = 1;
    var_3 = var_2 vehicle_getspeed();

    if(var_3 > 15) {
      if(var_3 > 45) {
        var_4 = 45;
      } else {
        var_4 = var_6 + 5;
      }

      foreach(var_4 in self.convoy.spawned_vehicles) {
        if(isalive(var_4)) {
          set_convoy_vehicle_speed(var_4, var_4, 30, 30);
        }
      }

      continue;
    }

    foreach(var_4 in self.convoy.spawned_vehicles) {
      if(isalive(var_4)) {
        set_convoy_vehicle_speed(var_4, 15, 30, 30);
      }
    }
  }
}

function adjust_vehicle_speed_on_center_dist() {
  level endon("game_ended");
  self.convoy endon("event_convoy_delete");
  self.convoy endon("convoy_compromised");
  self endon("death");
  self endon("unload_guys");
  self notify("adjusting_center_speed");
  self endon("adjusting_center_speed");

  if(isDefined(self.type) && self.type == "mkilo") {
    return;
  }

  if(!self vehicle_isphysveh()) {
    return;
  }

  GscBinSkip4(0x35);
}

function get_vehicle_adjust_speed(var_0, var_1) {
  var_2 = 5000;

  if(var_1 > var_2) {
    var_1 = var_2;
  }

  var_3 = var_1 / var_2;
  var_4 = scripts\engine\math::lerp(var_0, 15, var_3);
  return var_4;
}

function set_convoy_vehicle_speed(var_0, var_1, var_2) {
  self vehicle_setspeedimmediate(var_0, var_1, var_2);
}

function calc_length_of_full_veh_path(var_0) {
  if(!isDefined(var_0.pathing_array)) {
    return 0;
  }

  if(var_0.pathing_array.size <= 1) {
    return 0;
  }

  if(!isDefined(var_0.current_path)) {
    return 0;
  }

  var_1 = undefined;
  var_2 = undefined;

  for(var_3 = var_0.pathing_array.size - 1; var_3 > 0; var_3--) {
    if(var_0.pathing_array[var_3].origin == var_0.current_path.origin) {
      var_1 = var_0.pathing_array[var_3];
      var_2 = var_3;
      break;
    }
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  var_4 = 0;

  for(var_5 = var_2; var_5 < var_0.pathing_array.size - 1; var_5++) {
    var_4 += distance2d(var_0.pathing_array[var_5].origin, var_0.pathing_array[var_5 + 1].origin);
  }

  var_0.dist_from_node_to_end = var_4;
  return var_4;
}

function comparevehdisttoends(var_0, var_1) {
  if(var_0.dist_from_node_to_end == var_1.dist_from_node_to_end) {
    return (var_0.dist_from_node_to_end < var_1.dist_from_node_to_end);
  }

  return var_0.dist_from_node_to_end < var_1.dist_from_node_to_end;
}

function objective_icon_show(var_0, var_1) {
  if(!isDefined(self.convoy_objectivestruct)) {
    return;
  }

  if(!istrue(var_0)) {
    if(isDefined(self.convoy_objectivestruct.objectiveindex)) {
      objective_addteamtomask(self.convoy_objectivestruct.objectiveindex, "spectator");
      return;
    }

    return;
  }

  if(isDefined(self.convoy_objectivestruct.objectiveindex)) {
    objective_addalltomask(self.convoy_objectivestruct.objectiveindex);

    if(isDefined(var_1)) {
      objective_sethot(self.convoy_objectivestruct.objectiveindex, var_1);
      return;
    }

    return;
  }
}

function objective_icon_override(var_0) {
  if(isDefined(var_0)) {
    self.convoy_objectivestruct = var_0;
    return;
  }
}

function objective_icon_attach_to_center_vehicle(var_0, var_1, var_2) {
  if(!isDefined(self.convoy_objectivestruct)) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_3 = undefined;

  if(isalive(self.main_truck)) {
    var_3 = self.main_truck;
  } else {
    for(var_4 = 0; var_4 < self.spawned_vehicles.size; var_4++) {
      if(isalive(self.spawned_vehicles[var_4])) {
        var_3 = self.spawned_vehicles[var_4];
        break;
      }
    }
  }

  if(!isDefined(var_3)) {
    return;
  }

  if(istrue(var_0)) {
    objective_setplayintro(self.convoy_objectivestruct.objectiveindex, 1);
    objective_setplayoutro(self.convoy_objectivestruct.objectiveindex, 1);
    objective_onentity(self.convoy_objectivestruct.objectiveindex, var_3);
    objective_setzoffset(self.convoy_objectivestruct.objectiveindex, var_1);
    return;
  }
}

function objective_icon_show_health(var_0) {
  if(!isDefined(self.convoy_objectivestruct)) {
    return;
  }

  var_1 = undefined;

  if(isalive(self.main_truck)) {
    var_1 = self.main_truck;
  } else {
    for(var_2 = 0; var_2 < self.spawned_vehicles.size; var_2++) {
      if(isalive(self.spawned_vehicles[var_2])) {
        var_1 = self.spawned_vehicles[var_2];
        break;
      }
    }
  }

  if(!isDefined(var_1)) {
    return;
  }

  if(istrue(var_0)) {
    objective_sethot(self.convoy_objectivestruct.objectiveindex, 1);
    thread hold_health_on_objectiveicon(var_1);
    return;
  }

  self notify("stop_showing_health");
  objective_sethot(self.convoy_objectivestruct.objectiveindex, 0);
  var_1 scripts\cp\utility::vehicle_freehealthbarui();
}

function objective_icon_show_label(var_0) {
  if(!isDefined(self.convoy_objectivestruct)) {
    return;
  }

  if(!isDefined(var_0)) {
    return;
  }

  if(var_0 != &"") {
    objective_setlabel(self.convoy_objectivestruct.objectiveindex, var_0);
    return;
  }

  objective_setlabel(self.convoy_objectivestruct.objectiveindex, "");
}

function hold_health_on_objectiveicon(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  self endon("stop_showing_health");
  var_1 = var_0.health - var_0.healthbuffer;

  if(var_1 < var_0.health) {
    var_1 = var_0.health - var_0.healthbuffer;
  }

  var_2 = spawn("script_model", var_0.origin);
  var_2 linkTo(var_0, "tag_origin", (0, 0, 190), (0, 0, 0));
  var_3 = scripts\cp\utility::vehicle_gethealthbarid();

  if(!isDefined(var_3)) {
    return;
  }

  var_0.healthbarid = var_3;
  var_4 = scripts\engine\utility::ter_op(isDefined(var_0.script_team) && var_0.script_team != "axis", 2, 1);

  if(!isDefined(level.healthbars)) {
    level.healthbars = [];
  }

  level.healthbars[var_0.healthbarid] = var_2;
  setomnvar("ui_ingame_light_tank_ent_" + var_0.healthbarid, var_2);
  setomnvar("ui_ingame_light_tank_team_" + var_0.healthbarid, var_4);
  setomnvar("ui_ingame_light_tank_health_" + var_0.healthbarid, 1);

  for(;;) {
    var_5 = var_0.health - var_0.healthbuffer;
    setomnvar("ui_ingame_light_tank_health_" + var_0.healthbarid, var_5 / var_1);
    wait 0.2;
  }
}