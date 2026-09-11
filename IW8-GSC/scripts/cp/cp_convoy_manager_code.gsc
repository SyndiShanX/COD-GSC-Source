/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_convoy_manager_code.gsc
*************************************************/

function spawn_convoy(var0, var1, var2, var3, var4, var5, var6, var7) {
  wait 0.05;

  if(!isDefined(level.vehicle_all_stop_func)) {
    level.vehicle_all_stop_func = &stop_all_convoy_cars;
  }

  var8 = undefined;
  var9 = undefined;

  if(isstruct(var2)) {
    var10 = strtok(var2.targetname, "_");
    var10 = scripts\engine\utility::array_remove(var10, var10[0]);
    var10 = scripts\engine\utility::array_remove(var10, var10[0]);
    var11 = "";

    for(var12 = 0; var12 < var10.size; var12++) {
      if(var12 > 0) {
        var11 += "_";
      }

      var11 += var10[var12];
    }

    var2 = var11;
    var13 = spawnStruct();
    var13.targetname = "convoy_start_" + var2;
  }

  var8 = "convoy_spawner_" + var2;
  var9 = scripts\engine\utility::getStruct(var8, "targetname");
  var14 = scripts\engine\utility::getStruct("convoy_start_" + var2, "targetname");

  if(!isDefined(var9)) {
    var9 = spawnStruct();
    var9.classname_mp = "script_vehicle_iw8_truck_techo_white";
    var9.lookahead = 1;
    var9.script_modelname = "veh8_civ_lnd_techo_physics_mp";
    var9.speed = 30;
    var9.targetname = var8;
    var9.origin = var14.origin;
  }

  var15 = spawnStruct();
  var15.name = var0;
  var15.type = var1;
  var15.spawner = var9;
  var15.nodefaultweapon = 1;
  var15.spawned_vehicles = [];
  var15.alive_support_vehicles = 0;
  var15.using_path = var2;
  var15.not_compromised = 1;
  var15.backup_spawned = 0;
  var15.amount_to_compromise_left = -1;
  var15.team = scripts\engine\utility::ter_op(isDefined(var6), var6, "axis");
  var15.cp_speed = scripts\engine\utility::ter_op(isDefined(var7), var7, 300);

  if(isDefined(var5)) {
    var15.eventname = var5;
  } else {
    var15.eventname = "";
  }

  var15.targeted_hvt = undefined;
  var15.settings = spawnStruct();
  var15.settings.target = undefined;
  var15.settings.can_steal_hvt = 1;
  var15.settings.can_pickup_hvt = 1;
  var15.settings.hide_icon_on_pickup = 0;
  var15.settings.lookahead = -500;
  var15.settings.unload_at_target = 0;
  var15.settings.roaming = 0;
  var15.settings.attach_icon = 0;
  var15.settings.show_health = 0;
  var15.settings.ref_13898 = 0;
  var15.settings.amount_to_compromise = -1;
  var15.settings.center_compromises = 1;
  var15.settings.can_compromise_before_first_target = 0;
  var15.settings.health_drain = -1;
  var15.settings.long_low_health = 0;
  var15.settings.toggle_vo_on_hvt_pickup = 0;
  var15.settings.toggle_vo_on_hvt_rescued = 0;
  var15.settings.toggle_vo_on_convoy_death = 0;
  var15.settings.toggle_vo_on_nearby_convoy = 0;
  var15.settings.recruit_enable = 1;
  var15.settings.recruit_juggs = 1;
  var15.settings.recruit_time_between = 3;
  var15.settings.recruit_time_until = 12;
  var15.settings.recruit_amount = 5;
  var15.settings.recruit_distance = 4000;
  var15.settings.goal_distance = 1000;
  var15.settings.pickup_uses_origin = 0;
  var15.settings.defeated_on_kill_backup = 0;
  var15.settings.backup_deposit_names = undefined;
  var15.settings.route_to_any_veh = 1;
  var15.settings.route_to_other_veh = 1;
  var15.settings.route_to_other_support_veh = 1;
  var15.settings.enable_stop_all_cars = 1;
  var15.settings.path_jitter = undefined;
  var15.settings.use_path_speeds = undefined;
  var15.settings.despawn_dist = 7000;
  var15.settings.despawn_dist_enable = 1;
  var15.settings.distance_z = -1;
  var15.settings.suspend_at_end_path = undefined;
  var15.convoy_objectivestruct = var3;
  add_convoy_to_level(level, var15);
  level thread scripts\cp\cp_vehicle_turretdrone::process_turret_sweep_nodes(var15.using_path);
  thread allow_soldiers_attempt_take_target(level);
  spawn_convoy_from_type(level, var15);
  thread waittillconvoydead();
  thread waittill_return_to_truck(level, var15.using_path);

  if(isDefined(var4)) {
    thread kill_convoy_all(level, var15);
  }

  var15 notify("event_convoy_spawned");
  level notify("new_convoy_spawned");
  return var15;
}

function spawn_convoy_from_type(var0) {
  if(!isDefined(var0)) {
    var1 = "convoy_spawner_" + var0.using_path;
    var0 = scripts\engine\utility::getStruct(var1, "targetname");
  }

  if(isDefined(getvehiclenode("convoy_start_" + var0.using_path, "targetname"))) {
    var2 = getvehiclenodearray("convoy_start_" + var0.using_path, "targetname");
  } else {
    var2 = scripts\engine\utility::getStructArray("convoy_start_" + var2.using_path, "targetname");
  }

  if(var2.size > 1) {}

  var3 = 1;

  if(isDefined(level.convoy_speed_override)) {
    var3 = 30 / level.convoy_speed_override;
  }

  switch (var2.type) {
    case "medium":
      var4 = thread create_convoy_truck(var2, "techo", 1, "soldier_armored_helmet", 1, "price", "minigun_mp", var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var5 = thread create_convoy_truck(var2, "techo", 1, "soldier_armored_helmet", 1, "price", "minigun_mp", var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var6 = thread create_convoy_truck(var2, "mkilo", 0, undefined, 9, "price", undefined, var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var7 = thread create_convoy_truck(var2, "techo", 1, "soldier_armored_helmet", 1, "price", "minigun_mp", var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var7.spawned_after_convoy_center = 1;
      var8 = thread create_convoy_truck(var2, "techo", 1, "soldier_armored_helmet", 1, "price", "minigun_mp", var2[0]);
      var2.vehicles_remaining = 5;
      break;
    case "medium-roaming":
      var4 = thread create_convoy_truck(var2, "techo", 2, "soldier_armored_helmet", 1, "price", "minigun_mp", var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var5 = thread create_convoy_truck(var2, "techo", 2, "soldier_armored_helmet", 1, "price", "minigun_mp", var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var6 = thread create_convoy_truck(var2, "mkilo-notarp", 3, "soldier_armored_helmet", 1, "price", undefined, var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var7 = thread create_convoy_truck(var2, "techo", 2, "soldier_armored_helmet", 1, "price", "minigun_mp", var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var8 = thread create_convoy_truck(var2, "techo", 2, "soldier_armored_helmet", 1, "price", "minigun_mp", var2[0]);
      var2.vehicles_remaining = 5;
      break;
    case "small":
      var4 = thread create_convoy_truck(var2, "techo", 0, "soldier_armored_helmet", 1, "price", "minigun_mp", var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var6 = thread create_convoy_truck(var2, "mkilo", 0, undefined, 4, "price", undefined, var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var5 = thread create_convoy_truck(var2, "techo", 0, "soldier_armored_helmet", 1, "price", "minigun_mp", var2[0]);
      var2.vehicles_remaining = 3;
      break;
    case "small-roaming":
      var4 = thread create_convoy_truck(var2, "techo", 3, "soldier_armored_helmet", 1, "price", "minigun_mp", var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var6 = thread create_convoy_truck(var2, "mkilo-notarp", 3, "soldier_armored_helmet", 1, "price", undefined, var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var5 = thread create_convoy_truck(var2, "techo", 3, "soldier_armored_helmet", 1, "price", "minigun_mp", var2[0]);
      var2.vehicles_remaining = 3;
      break;
    case "small-roaming-stealing":
      var2.settings.ref_13898 = 1;
      var4 = thread create_convoy_truck(var2, "techo", 2, "soldier_armored_helmet", 1, "price", undefined, var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var6 = thread create_convoy_truck(var2, "mkilo-notarp", 0, "soldier_armored_helmet", 1, "price", undefined, var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var5 = thread create_convoy_truck(var2, "techo", 2, "soldier_armored_helmet", 1, "price", undefined, var2[0]);
      var2.vehicles_remaining = 3;
      break;
    case "small-danger-roaming":
      var4 = thread create_convoy_truck(var2, "techo", 3, "soldier_armored_helmet", 1, "price", "minigun_mp", var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var6 = thread create_convoy_truck(var2, "mkilo-notarp", 3, "soldier_armored_helmet", 1, "price", "wheelson_manned", var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var5 = thread create_convoy_truck(var2, "techo", 3, "soldier_armored_helmet", 1, "price", "minigun_mp", var2[0]);
      var2.vehicles_remaining = 3;
      break;
    case "single":
      var4 = thread create_convoy_truck(var2, "techo", 0, "soldier_armored_helmet", 1, "price", undefined, var2[0]);
      var2.vehicles_remaining = 1;
      break;
    case "single-empty":
      var4 = thread create_convoy_truck(var2, "techo", 0, "soldier_armored_helmet", 0, "price", undefined, var2[0]);
      var2.vehicles_remaining = 1;
      break;
    case "single-mkilo":
      var6 = thread create_convoy_truck(var2, "mkilo-notarp", 3, "soldier_armored_helmet", 1, "price", undefined, var2[0]);
      var2.vehicles_remaining = 1;
      break;
    case "single-techo-turret":
      var4 = thread create_convoy_truck(var2, "techo", 2, "soldier_armored_helmet", 1, "price", "minigun_mp", var2[0]);
      var2.vehicles_remaining = 1;
      break;
    case "double-techo-turret":
      var4 = thread create_convoy_truck(var2, "techo", 2, "soldier_armored_helmet", 1, "price", "minigun_mp", var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var5 = thread create_convoy_truck(var2, "techo", 2, "soldier_armored_helmet", 1, "price", "minigun_mp", var2[0]);
      var2.vehicles_remaining = 2;
      break;
    case "double-techo":
      var4 = thread create_convoy_truck(var2, "techo", 2, "soldier_armored_helmet", 1, "price", undefined, var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var5 = thread create_convoy_truck(var2, "techo", 2, "soldier_armored_helmet", 1, "price", undefined, var2[0]);
      var5.spawned_after_convoy_center = 1;
      var2.vehicles_remaining = 2;
      break;
    case "triple-techo-turret":
      var4 = thread create_convoy_truck(var2, "techo", 2, "soldier_armored_helmet", 1, "price", "minigun_mp", var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var5 = thread create_convoy_truck(var2, "techo", 2, "soldier_armored_helmet", 1, "price", "minigun_mp", var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var7 = thread create_convoy_truck(var2, "techo", 2, "soldier_armored_helmet", 1, "price", "minigun_mp", var2[0]);
      var7.spawned_after_convoy_center = 1;
      var2.vehicles_remaining = 3;
      break;
    case "apc-payload-type":
      var4 = thread create_convoy_truck(var2, "apc", 0, "soldier_armored_helmet", 1, "price", undefined, var2[0]);
      var2.vehicles_remaining = 1;
      break;
    case "decho_getaway":
      var6 = thread create_convoy_truck(var2, "decho", 0, "soldier_armored_helmet", 0, "price", undefined, var2[0]);
      var2.vehicles_remaining = 1;
      break;
    case "convoyescort-type":
      var3 = 0.95;
      var4 = thread create_convoy_truck(var2, "techo", 0, "soldier_armored_helmet", 1, "price", undefined, var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var5 = thread create_convoy_truck(var2, "techo", 0, "soldier_armored_helmet", 1, "price", undefined, var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var7 = thread create_convoy_truck(var2, "techo", 0, "soldier_armored_helmet", 1, "price", undefined, var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var8 = thread create_convoy_truck(var2, "techo", 0, "soldier_armored_helmet", 1, "price", undefined, var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var9 = thread create_convoy_truck(var2, "techo", 0, "soldier_armored_helmet", 1, "price", undefined, var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var10 = thread create_convoy_truck(var2, "techo", 0, "soldier_armored_helmet", 1, "price", undefined, var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var11 = thread create_convoy_truck(var2, "techo", 0, "soldier_armored_helmet", 1, "price", undefined, var2[0]);
      var9.spawned_after_convoy_center = 1;
      var10.spawned_after_convoy_center = 1;
      var11.spawned_after_convoy_center = 1;
      var2.vehicles_remaining = 7;
      break;
    case "single-techo-cargo":
      var4 = thread create_convoy_truck(var2, "techo-cargo", 5, "soldier_armored_helmet", 1, "price", undefined, var2[0]);
      var2.vehicles_remaining = 1;
      break;
    case "double-techo-cargo":
      var4 = thread create_convoy_truck(var2, "techo-cargo", 5, "soldier_armored_helmet", 1, "price", undefined, var2[0]);
      wait randomfloatrange(2.75, 4.55) * var3;
      var5 = thread create_convoy_truck(var2, "techo-cargo", 5, "soldier_armored_helmet", 1, "price", undefined, var2[0]);
      var5.spawned_after_convoy_center = 1;
      var2.vehicles_remaining = 2;
      break;
    default:
      break;
  }
}

function create_convoy_truck(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isDefined(var0)) {
    return;
  }

  var10 = undefined;

  switch (var1) {
    case "decho":
      var10 = spawn_convoy_decho(var0);
      break;
    case "techo-cargo":
    case "techo":
      var10 = spawn_convoy_truck(var0);
      break;
    case "umike":
    case "apc":
      var10 = spawn_convoy_apc(var0);
      break;
    case "mkilo":
      var10 = spawn_convoy_mkilo23(var0);
      var10.guys_assigned = 0;
      break;
    case "mkilo-notarp":
      var10 = spawn_convoy_mkilo23(var0, 1);
      var10.guys_assigned = 0;
      break;
    default:
      break;
  }

  if(!isDefined(var1)) {
    return;
  }

  if(istrue(var0.settings.ref_13898)) {
    var10.ref_13898 = 1;
  }

  if(isDefined(var0.main_truck) && var10 != var0.main_truck) {
    var10.spawned_after_convoy_center = 1;
  } else {
    var10.spawned_after_convoy_center = 0;
  }

  var10 scripts\engine\utility::ent_flag_init("driver_spawned");

  if(isDefined(var2) && var2 > 0) {
    if(isDefined(var3)) {
      var0.spawner.script_noteworthy = var3;
    } else {
      var0.spawner.script_noteworthy = "soldier_armored_helmet";
    }

    if(var1 == "techo") {
      thread trial_start_time(var10);
    } else if(var1 == "techo-cargo") {
      thread trial_stat_row();
    }

    thread ref_135da(level, var10, var2);
  }

  thread killoff_vis_passed(var10);

  if(isDefined(var4) && var4 > 0) {
    var11 = "";

    switch (var1) {
      case "techo-cargo":
      case "techo":
        var11 = "techo_phys";
        break;
      case "mkilo-notarp":
      case "mkilo":
        var11 = "mkilo23_ai_infil";
        break;
    }

    level thread scripts\cp\cp_vehicles::ref_135cb(var10, var11);
    var10 scripts\engine\utility::ent_flag_set("driver_spawned");
    thread wait_to_deposit_driver(level);
  }

  if(isDefined(var7)) {
    thread trial_retrieve_persistent_values(var10, var7, var0);
  }

  var10.measure_origin = var10.origin;

  if(!isDefined(var0.using_path)) {
    return;
  } else {
    thread convoy_vehicle_monitor(var10, var0.using_path);
  }

  if(isDefined(var6) && var6 != "") {
    thread ref_135e2(var10);
  }

  return var10;
}

function ref_135e2(var0) {
  var0.computerscriptable = 1;
  var0.zombiejumping = [];
  var1 = (-62, 0, 45);
  var2 = level scripts\cp\cp_vehicles::spawn_ai_in_truck(var0, 1, undefined, 0, undefined, "lmg_heavy", 5);

  if(isDefined(var2) && var2.size > 0) {
    var2[0].equip_armor = 1;
    var2[0].equip_helmet = 1;
    var2[0].maxhealth = 600;
    var2[0].health = 600;
    var2[0].i_see_laststand_player_watcher = 1;
    var0.zombiejumping[0] = var2[0];
  }

  var3 = (-92, 0, 60);
  var4 = level scripts\cp\cp_vehicles::spawn_ai_in_truck(var0, 1, undefined, 0, undefined, "lmg_heavy", 6);

  if(isDefined(var4) && var4.size > 0) {
    var4[0].equip_armor = 1;
    var4[0].equip_helmet = 1;
    var4[0].maxhealth = 600;
    var4[0].health = 600;
    var4[0].i_see_laststand_player_watcher = 1;
    var0.zombiejumping[1] = var4[0];
  }

  wait 5;
  var0.computerscriptable = undefined;
}

function ref_135da(var0, var1, var2) {
  level thread scripts\cp\cp_vehicles::spawn_ai_in_truck(var0, var1, var2.spawner, 0, undefined);
}

function trial_start_time(var0) {
  level endon("game_ended");
  self endon("death");

  if(self.type != "techo") {
    return;
  }

  self waittill("stop_follow_path");
  var1 = "entirecab";

  if(isDefined(var0) && isDefined(var0.settings.ref_13f14)) {
    var1 = var0.settings.ref_13f14;
  }

  scripts\common\vehicle::vehicle_unload(var1);
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

function wait_to_deposit_driver(var0) {
  level endon("game_ended");
  var0 endon("event_convoy_delete");
  var0 waittill("able_to_deposit_driver");

  for(var1 = 0; var1 < var0.spawned_vehicles.size; var1++) {
    if(isDefined(var0.spawned_vehicles[var1]) && isalive(var0.spawned_vehicles[var1])) {
      var0.spawned_vehicles[var1] thread scripts\cp\cp_vehicles::deposit_ai_from_drones_in_vehicle(1, 0);
    }
  }
}

function killoff_vis_passed(var0) {
  var0 endon("death");
  wait 15;
  var0.nav_obstacle = createnavrepulsor("ai_vehicle", 0, var0, 150, 1);
}

function trial_retrieve_persistent_values(var0, var1, var2) {
  var0 endon("death");

  if(isDefined(level.convoy_speed_override)) {
    var0.speed_override = level.convoy_speed_override;
  } else {
    var0.speed_override = 30;
  }

  var3 = var1;
  var0.pathing_array = [];
  var0.pathing_array[var0.pathing_array.size] = var1;
  var3.pathing_index = var0.pathing_array.size;

  while(isDefined(var3) && isDefined(var3.target)) {
    var3 = scripts\engine\utility::getStruct(var3.target, "targetname");
    var3.pathing_index = var0.pathing_array.size;
    var0.pathing_array[var0.pathing_array.size] = var3;
  }

  if(var0.pathing_array.size > 27) {
    var0 scripts\cp\cp_vehicles::split_large_pathing_array();
  }

  if(isDefined(level.convoy_path_jitter) && level.convoy_path_jitter > 0) {
    var2.settings.path_jitter = level.convoy_path_jitter;
  }

  if(!isDefined(var0.pathing_arrays)) {
    var4 = var0.pathing_array;
  } else {
    var4 = var1.pathing_arrays;
  }

  var1 thread scripts\cp\cp_vehicles::vehiclefollowstructpath(var4);
  thread intro_stop_car_if_too_close(var1, var1);
}

function intro_stop_car_if_too_close(var0, var1) {
  level endon("game_ended");
  var0 endon("death");
  var0 endon("stop_follow_path");
  var2 = 650;
  var3 = var2 * var2;

  if(istrue(var0.spawned_after_convoy_center)) {
    for(;;) {
      if(isent(var1.main_truck) && isent(var0)) {
        if(distancesquared(var1.main_truck.origin, var0.origin) < var3) {
          var0 vehicle_setspeed(0, 70, 70);
          var0 notify("stop_follow_path");
        }
      }

      wait 0.25;
    }

    return;
  }
}

function add_convoy_to_level(var0) {
  if(!isDefined(level.all_convoys)) {
    level.all_convoys = [];
  }

  if(isDefined(level.all_convoys[var0.name])) {
    thread kill_convoy_all(level, level.all_convoys[var0.name]);
    wait 0.05;
  }

  level.all_convoys[var0.name] = var0;
}

function remove_convoy_from_level(var0) {
  if(!isDefined(level.all_convoys)) {
    return;
  }

  if(!isDefined(level.all_convoys[var0.name])) {
    return;
  }

  if(isDefined(var0.saved_struct_paths)) {
    var1 = var0.saved_struct_paths.size;

    for(var2 = 0; var2 < var1; var2++) {
      scripts\engine\utility::deletestruct_ref(var0.saved_struct_paths[var2]);
      var0.saved_struct_paths[var2] = undefined;
    }
  }

  var0 notify("fully_removed");
  level.all_convoys = scripts\engine\utility::array_remove(level.all_convoys, level.all_convoys[var0.name]);

  if(isDefined(isDefined(level.all_convoys[var0.name]))) {
    level.all_convoys[var0.name] = undefined;
    return;
  }
}

function change_convoy_objective_target() {
  self.settings.target = var0;

  if(istrue(var2)) {
    if(istrue(self.settings.unload_at_target)) {
      foreach(var5 in self.spawned_vehicles) {
        if(isalive(var5)) {
          if(isDefined(level.vehicle_all_stop_func)) {
            var5[[level.vehicle_all_stop_func]](0);
          }

          var5 notify("unload_guys");
        }
      }
    }

    return;
  }

  if(istrue(var3)) {
    return;
  }

  var7 = 1000;
  var8 = var7 * var7;

  foreach(var5 in self.spawned_vehicles) {
      if(isalive(var5)) {
        var5.path_gobbler = 1;

        if(isstring(var0)) {
          var10 = var0;
          var0 = scripts\engine\utility::getent_or_struct(var10, "script_noteworthy").origin;

          if(!isDefined(var0)) {
            var0 = scripts\engine\utility::getent_or_struct(var10, "targetname").origin;
          }
        } else if(!isvector(var0) && isDefined(var0.origin)) {
          var0 = var0.origin;
        }

        var11 = 60;
        var12 = "mkilo23_ai_infil";
        var13 = level.ai_spawn_vehicle_func[var12].path_start_points;

        if(isDefined(self.convoy_paths_override)) {
          var13 = self.convoy_paths_override;
        }

        var14 = scripts\engine\utility::getStructArray(var13, "targetname");

        if(!isDefined(var14) || var14.size == 0) {
          return;
        }

        if(isDefined(var5.pathing_array)) {
          foreach(var16 in var5.pathing_array) {
            level notify("kill_debug_" + var16.pathing_index);
          }
        }

        if(isDefined(var5.pathing_arrays)) {
          var5.pathing_arrays = undefined;
        }

        var18 = undefined;
        var19 = scripts\engine\utility::getclosest(var5.origin, var14);

        if(!is_struct_in_front_of_me(var5, var19)) {
          var20 = var19 scripts\cp\cp_vehicles::get_veh_linked_structs();

          for(var21 = 0; var21 < var20.size; var21++) {
            if(is_struct_in_front_of_me(var5, var20[var21])) {
              var18 = var20[var21];
              break;
            }
          }

          if(!isDefined(var18)) {
            for(var21 = 0; var21 < var20.size; var21++) {
              var22 = var20[var21] scripts\cp\cp_vehicles::get_veh_linked_structs();

              for(var23 = 0; var23 < var22.size; var23++) {
                if(is_struct_in_front_of_me(var5, var22[var23])) {
                  var18 = var22[var23];
                  break;
                }
              }
            }
          }

          if(isDefined(var18)) {
            var19 = var18;
          }
        }

        var24 = scripts\engine\utility::getclosest(var0, var14);

        if(distance2dsquared(var5.origin, var24.origin) < var8) {
          break;
        }

        var0 notify("reset_path");
        var25 = scripts\cp\cp_vehicles::duplicate_struct(var5);
        var25.speed = var2;
        var25.angles = vectortoangles(var25.origin - var0.origin);
        scripts\cp\cp_vehicles::add_targetname_kvps(var25, undefined, var3 + 0 + "_convoy_start");
        add_to_convoy_structs(var25);
        var26 = scripts\cp\cp_vehicles::duplicate_struct(var31);
        var26.speed = var2;
        var26.script_pathtype = "unload";
        scripts\cp\cp_vehicles::add_targetname_kvps(var26, undefined, var3 + 0 + "_convoy_end");
        add_to_convoy_structs(var26);
        var27 = [];

        if(isDefined( < error > ) && < error > .size > 0) {
          for(var21 = 0; var21 < < error > .size; var21++) {
            var28 = < error > [var21];

            if(isstruct( < error > [var21])) {
              var28 = < error > [var21].origin;
            }

            var29 = scripts\engine\utility::getclosest(var28, var8);
            var30 = scripts\cp\cp_vehicles::duplicate_struct(var29);
            var30.speed = var2;
            scripts\cp\cp_vehicles::add_targetname_kvps(var29, undefined, var3 + 0 + "_convoy_btwn");
            add_to_convoy_structs(var30);
            var27 = var29;
          }
        }

        follow_path_from_grid(var0, var25, var26, var27, var8);
        wait 2;
      }
    }

    <
    error > = undefined;
  var1 = undefined;
}

function is_struct_in_front_of_me(var0) {
  var1 = vectordot(self.angles, vectorNormalize(var0.origin - self.origin));
  return var1 > 0;
}

function add_to_convoy_structs(var0) {
  if(!isDefined(self.saved_struct_paths)) {
    self.saved_struct_paths = [];
  }

  if(isDefined(var0) && isstruct(var0)) {
    self.saved_struct_paths[self.saved_struct_paths.size] = var0;
    return;
  }
}

function handle_set_speed_to_goal(var0, var1) {
  self endon("death");
  var1 endon("convoy_compromised");
  self.disable_set_speed = 1;
  var2 = getdvarint("scr_event_convoy_speedup", 0);

  if(var2 == 0) {
    return;
  }

  if(var2 > 400) {
    var2 = 400;
  }

  var3 = scripts\cp\cp_vehicles::getvehiclepath("convoy_start_" + var0);

  while(isDefined(var3.target)) {
    var3 = scripts\cp\cp_vehicles::getvehiclepath(var3.target);
    var3 waittill("trigger");

    if(var3.speed > 15) {
      self vehicle_setspeedimmediate(var2, 15, 15);
    }

    if(isDefined(var3.script_pathtype) && var3.script_pathtype == "convoy_slowdown") {
      self vehicle_setspeedimmediate(15, 350, 350);
      wait 5;
      return;
    }
  }
}

function follow_path_from_grid(var0, var1, var2, var3, var4) {
  var0 endon("death");
  level endon("game_ended");
  self endon("convoy_compromised");

  if(!isDefined(level.convoy_path_number)) {
    level.convoy_path_number = 0;
  }

  var0.pathing_array = undefined;
  var0.veh_path = [];

  if(isDefined(var3) && var3.size > 0) {
    var5 = [];
    GscBinSkip0(0x2e, 0, var1);
  }

  var21 = var1.vehicletype;
  var1 scripts\cp\cp_vehicles::create_path_from_struct_to_struct(var2, var3, level.convoy_path_number, var21, "_convoy_unload_pathing_", (1, 1, 1));
  var1 scripts\engine\utility::thread_on_notify_no_endon_death("death", &scripts\cp\cp_vehicles::reset_spawn_point_targetname, undefined, undefined, var1);
  var1 thread scripts\cp\cp_vehicles::vehiclefollowstructpath(var1.pathing_array[0]);
  level.convoy_path_number++;
}

function allow_soldiers_attempt_take_target(var0) {
  scripts\engine\utility::waittill_any_ents(level, "allow_convoy_soldiers_target", var0, "convoy_arrived_at_dest");
  thread attempt_new_pulse_set(level);
}

function attempt_new_pulse_set(var0) {
  if(istrue(var0.settings.recruit_enable)) {
    thread pulse_soldiers_to_help_convoy();
    return;
  }
}

function set_roaming() {
  level endon("game_ended");
  self endon("convoy_compromised");
  self endon("death");
  self endon("reset_path");
  var0 = undefined;
  var1 = 192;
  var2 = var1 * var1;
  var3 = 10000;
  var4 = var3 * var3;
  var5 = 1;
  var6 = "mkilo23_ai_infil";
  var7 = undefined;

  for(var8 = 0; var8 < self.spawned_vehicles.size; var8++) {
    if(isDefined(self.spawned_vehicles[var8]) && isalive(self.spawned_vehicles[var8])) {
      var7 = self.spawned_vehicles[var8];
      break;
    }
  }

  var7 endon("death");
  var9 = 0.1;

  for(;;) {
    if(var5 == 1) {
      var10 = level.ai_spawn_vehicle_func[var6].path_start_points;

      if(isDefined(self.convoy_paths_override)) {
        var10 = self.convoy_paths_override;
      }

      var11 = scripts\engine\utility::getStructArray(var10, "targetname");

      for(var8 = 0; var8 < var11.size; var8++) {
        var12 = var11[var8] scripts\cp\cp_vehicles::get_veh_linked_structs();
        var13 = var12.size;

        if(var13 < 2) {
          var11 = scripts\engine\utility::array_remove(var11, var11[var8]);
        }
      }

      var11 = sortbydistance(var11, var7.origin);
      var14 = [];
      var15 = int(var11.size * 0.66);

      for(var8 = 0; var8 < var11.size; var8++) {
        if(var8 >= var15) {
          var14 = var11[var8];
        }
      }

      if(var14.size == 0) {
        var14 = var11[var8];
      }

      var0 = scripts\engine\utility::random(var14);

      if(isDefined(var0.origin)) {}

      change_convoy_objective_target(var0.origin);
      var5 = 0;
    }

    if(distance2dsquared(var7.origin, var0.origin) > var4) {
      var9 = 1;
    } else if(distance2dsquared(var7.origin, var0.origin) > var2) {
      var9 = 0.1;
    } else if(distance2dsquared(var7.origin, var0.origin) < var2) {
      var5 = 1;
    }

    wait var9;
  }
}

function debug_draw_until_newpath(var0, var1) {
  var1 endon("death");
  var1 notify("debug_draw_until_newpath");
  var1 endon("debug_draw_until_newpath");

  for(;;) {
    level thread scripts\engine\utility::draw_capsule(var0.origin, 128, 2000, undefined, (1, 0, 1), undefined, 1);
    waitframe();
  }
}

function toggle_trucks_disable_leave(var0) {
  foreach(var2 in self.spawned_vehicles) {
    if(isent(var2)) {
      var2.disable_leave_truck = var0;

      if(istrue(var0)) {
        var2 notify("disable_leave_truck");
      }
    }
  }
}

function spawn_convoy_truck(var0) {
  var1 = var0.spawner;

  if(isDefined(getvehiclenode("convoy_start_helidown3", "targetname"))) {
    var1.vehicletype = "truck";
    var1.script_modelname = "veh8_civ_lnd_techo_physics_mp";
  } else {
    var1.vehicletype = "techo_physics";
    var1.script_modelname = "veh8_civ_lnd_techo_physics_mp";
  }

  var1.classname_mp = "script_vehicle_iw8_truck_techo_white_physics";
  var1.script_team = "axis";

  if(!isDefined(var1.angles)) {
    var1.angles = (0, 0, 0);
  }

  var2 = scripts\common\vehicle::vehicle_spawn(var1);
  var2.vehicle_skipdeathmodel = 1;
  var2.death_fx_on_self = 1;
  var2.disable_leave_truck = 1;
  var2 setvehicleteam("axis");
  var2.orig_health = var2.health;
  var2.type = "techo";
  var2.riders = [];
  var0.alive_support_vehicles++;
  var0.spawned_vehicles[var0.spawned_vehicles.size] = var2;
  var2.spawner = var1;
  var2.convoy = var0;
  return var2;
}

function spawn_convoy_decho(var0) {
  if(!isDefined(var0.team)) {
    var0.team = "axis";
  }

  var1 = var0.spawner;
  var1.vehicletype = "techo_physics";
  var1.script_modelname = "veh8_civ_lnd_decho_physics";
  var1.classname_mp = "script_vehicle_iw8_truck_techo_white";
  var1.script_team = var0.team;

  if(!isDefined(var1.angles)) {
    var1.angles = (0, 0, 0);
  }

  var2 = scripts\common\vehicle::vehicle_spawn(var1);
  var2.vehicle_skipdeathmodel = 1;
  var2.death_fx_on_self = 1;
  var2.disable_leave_truck = 1;
  var2 setvehicleteam("axis");
  var2.orig_health = var2.health;
  var2.type = "decho";
  var2.riders = [];
  var0.alive_support_vehicles++;
  var0.spawned_vehicles[var0.spawned_vehicles.size] = var2;
  var2.spawner = var1;
  var2.convoy = var0;
  return var2;
}

function spawn_convoy_apc(var0) {
  if(!isDefined(var0.team)) {
    var0.team = "axis";
  }

  var1 = var0.team;
  var2 = var0.spawner;
  var2.vehicletype = "stango_physics_mp";
  var2.script_modelname = "veh8_mil_lnd_stango_physics_mp";
  var2.classname_mp = "apc";
  var2.targetname = "apc";
  var2.script_team = var1;

  if(!isDefined(var2.angles)) {
    var2.angles = (0, 0, 0);
  }

  var3 = scripts\common\vehicle::vehicle_spawn(var2);
  var3.vehicle_skipdeathmodel = 1;
  var3.death_fx_on_self = 1;
  var3 setCanDamage(0);
  var3 setvehicleteam(var1);
  var3.script_team = var1;
  var3.orig_health = var3.health * 2;
  var3.type = "apc";
  var3.riders = [];
  var3.cp_speed = scripts\engine\utility::ter_op(isDefined(var0.cp_speed), var0.cp_speed, 300);
  var0.main_truck = var3;
  var0.spawned_vehicles[var0.spawned_vehicles.size] = var3;
  var3.spawner = var2;
  var3.convoy = var0;
  return var3;
}

function spawn_convoy_mkilo23(var0, var1) {
  var2 = var0.spawner;
  var2.vehicletype = "mkilo_physics_cp";
  var2.script_modelname = "veh8_mil_lnd_mkilo23_physics_mp";
  var2.classname_mp = "script_veh8_mil_lnd_mkilo23_physics_ai_infil";
  var2.script_team = "axis";

  if(!isDefined(var2.angles)) {
    var2.angles = (0, 0, 0);
  }

  var3 = scripts\common\vehicle::vehicle_spawn(var2);
  var3.vehicle_skipdeathmodel = 1;
  var3.death_fx_on_self = 1;
  var3 setCanDamage(1);
  var3 setvehicleteam("axis");
  var3.script_team = "axis";
  var3.orig_health = var3.health;
  var3.disable_leave_truck = 1;

  if(!istrue(var1)) {
    var3.tarp = var3 thread scripts\cp\vehicles\vehicle_cp::spawn_vehicle_accessory("veh8_mil_lnd_mkilo23_tarp", undefined, undefined, (0, 0, 0));
  } else {
    var0.no_tarp = 1;
  }

  var4 = 500;
  var5 = 26.6;
  add_wheel_tag(var3, "tag_wheel_center_front_left", var4, var5);
  add_wheel_tag(var3, "tag_wheel_center_front_right", var4, var5);
  add_wheel_tag(var3, "tag_wheel_center_middle_left", var4, var5);
  add_wheel_tag(var3, "tag_wheel_center_middle_right", var4, var5);
  add_wheel_tag(var3, "tag_wheel_center_back_left", var4, var5);
  add_wheel_tag(var3, "tag_wheel_center_back_right", var4, var5);
  var3.type = "mkilo";
  var3.riders = [];
  var0.main_truck = var3;
  var0.spawned_vehicles[var0.spawned_vehicles.size] = var3;
  var3.spawner = var2;
  var3.convoy = var0;
  thread is_ascender_use_allowed();
  return var3;
}

function is_ascender_use_allowed() {
  level endon("game_ended");
  self.convoy endon("event_convoy_delete");
  self endon("death");
  var0 = undefined;
  var1 = 40000;
  var2 = 2;
  wait 10;

  for(;;) {
    var0 = vehicle_getarray();
    var2 = 2;

    for(var3 = 0; var3 < var0.size; var3++) {
      if(!isDefined(var0[var3].convoy) && istrue(var0[var3].isempty) && isDefined(var0[var3].team) && var0[var3].team != "axis" && isent(var0[var3]) && isDefined(var0[var3].vehiclename) && var0[var3].vehiclename == "atv" && self != var0[var3] && !var0[var3] issuspendedvehicle()) {
        var4 = self gettagorigin("tag_light_front_right");

        if(distancesquared(var4, var0[var3].origin) < var1) {
          var0[var3] dodamage(90, self.origin);
          var2 = 0.5;
        }
      }
    }

    wait var2;
  }
}

function convoy_vehicle_monitor(var0, var1) {
  level endon("game_ended");
  thread handle_set_speed_to_goal(var0, var1);
  self.damage_functions[0] = &convoy_damage_monitor;
  thread waittilldeath();
  thread waittillarriveatdestination(var0, var1);
  thread waittillcompromised(var0, var1);
  thread waittillhealthlow(var0);
  thread waittilltoofarz();
}

function convoy_damage_monitor(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  var10 = 0;

  if(!isDefined(self.team)) {
    self.team = "axis";
  }

  if(!isPlayer(var1)) {
    if(isDefined(var1.owner) && isPlayer(var1.owner) && isexplosivedamagemod(var4) && self.health > self.healthbuffer) {
      if(self.type == "mkilo") {
        apply_truck_dmg(var0, 1, 0.7, var4);
      }

      var1.owner scripts\cp\cp_damagefeedback::updatehitmarker("hittankarmor", 0, var0, 1, 0);
      var1.owner playlocalsound("cp_hit_indication_armor");
    }

    return;
  }

  if(self.type == "mkilo") {
    if(!isDefined(self.is_correct_wire_color_sync)) {
      self.is_correct_wire_color_sync = 0.03;
    }

    if(self.health > self.healthbuffer) {
      var1 scripts\cp\cp_damagefeedback::updatehitmarker("hittankarmor", 0, var0, 0, 0);
      var1 playlocalsound("cp_hit_indication_armor");
    }

    if(!isexplosivedamagemod(var4)) {
      apply_truck_dmg(var0, 1, 0.95, var4);
    } else {
      apply_truck_dmg(var0, 0, 0.6, var4);
    }
  } else {
    if(self.health > self.healthbuffer) {
      var1 scripts\cp\cp_damagefeedback::updatehitmarker("low_damage", 0, var0, 0, 0);
    }

    if(isexplosivedamagemod(var4)) {
      apply_truck_dmg(var0, 0, 1.8, var4);
    } else {
      apply_truck_dmg(var0, 1, 0.55, var4);
    }
  }

  foreach(var12 in self.riders) {
    if(isalive(var12)) {
      if(isDefined(var1) && isPlayer(var1)) {
        var12 getenemyinfo(var1);
      }
    }
  }

  if(self.health < self.healthbuffer) {
    var1 scripts\cp\cp_damagefeedback::updatehitmarker("low_damage", 0, var0, 0, 0);
    return;
  }
}

function apply_truck_dmg(var0, var1, var2, var3) {
  if(isDefined(var3) && var3 == "MOD_SUICIDE") {
    return;
  }

  if(istrue(self.draining_health)) {
    self.health += var0;
    return;
  }

  if(!istrue(self.hull_invulnerable)) {
    if(istrue(var1)) {
      self.health += int(var0 * var2);
      return;
    }

    self.health -= int(var0 * var2);
    return;
  }

  self.health = self.orig_health;
}

function add_wheel_tag(var0, var1, var2, var3, var4) {
  if(isDefined(var0) && isDefined(var1)) {
    if(!isDefined(var0.wheel_tags)) {
      var0.wheel_tags = [];
    }

    if(!isDefined(var2)) {
      var2 = 500;
    }

    if(!isDefined(var3)) {
      var3 = 60;
    }

    if(!isDefined(var4)) {
      var4 = "veh8_civ_lnd_techo_wheel_dst";
    }

    var5 = spawnStruct();
    var5.tag = var1;
    var5.health = var2;
    var5.radius = var3;
    var5.model = var4;
    var5.orientation = "right";
    var6 = strtok(var1, "_");

    foreach(var8 in var6) {
      if(var8 == "left") {
        var5.orientation = "left";
      }
    }

    var0.wheel_tags[var0.wheel_tags.size] = var5;
    return;
  }
}

function init_tire_outlines(var0) {
  if(!isDefined(var0) || !isDefined(var0.wheel_tags) || var0.wheel_tags.size == 0) {
    return;
  }

  thread barrel_setup_anims();

  for(var1 = 0; var1 < var0.wheel_tags.size; var1++) {
    var2 = var0.wheel_tags[var1];
    var2.model_created = spawn_wheel_outline_model(var0, var2);
    var2.collision_created = spawn_wheel_collision(var0, var2);
    thread track_tire_damage(var2.collision_created, var0);
  }
}

function spawn_wheel_outline_model(var0, var1) {
  var2 = spawn("script_model", var0 gettagorigin(var1.tag));
  var2.angles = var0.angles;
  var2 setModel(var1.model);
  var2 notsolid();
  var2 show();
  var2.owner = var0;
  var3 = -8;
  var4 = 180;

  if(var1.orientation == "left") {
    var3 *= -1;
    var4 = 0;
  }

  var2 linkTo(var0, var1.tag, (0, var3, 0), (0, var4, 0));
  return var2;
}

function spawn_wheel_collision(var0, var1) {
  level.obj_overwatch_coll_type = 0;

  if(!isDefined(level.taccoverbulletcollision)) {
    var2 = getEntArray("tactical_cover_bullet_col", "targetname");

    if(isDefined(var2)) {
      level.taccoverbulletcollision = var2[0];
      level.obj_overwatch_coll_type = 1;
    }
  }

  if(!isDefined(level.taccoverbulletcollision)) {
    var2 = getEntArray("player32x32x8", "targetname");

    if(isDefined(var2)) {
      level.taccoverbulletcollision = var2[0];
      level.obj_overwatch_coll_type = 2;
    }
  }

  var3 = spawn("script_model", var0 gettagorigin(var1.tag));
  var3 dontinterpolate();
  var3.angles = var0.angles;
  var3.owner = var0;
  var3.maxhealth = 999999;
  var3.health = 500;
  var3.team = var0.script_team;
  var3 setCanDamage(1);
  var3 clonebrushmodeltoscriptmodel(level.taccoverbulletcollision);
  var4 = -10;

  if(var1.orientation == "left") {
    var4 *= -1;
  }

  var5 = (0, 90, 0);

  if(level.obj_overwatch_coll_type == 2) {
    var5 = (90, 90, 0);
  }

  var3 linkTo(var0, var1.tag, (0, var4, 5), var5);
  return var3;
}

function track_tire_damage(var0, var1) {
  level endon("game_ended");
  var0 endon("death");
  var2 = var1.collision_created;

  while(var2.health > 0) {
    var2 waittill("damage", var3, var4, var5, var6, var7, var8, var9, var10, var11, var12);

    if(!isPlayer(var4)) {
      if(isDefined(var4.owner) && isPlayer(var4.owner) && isexplosivedamagemod(var7)) {
        var2.health += int(var3 * 0.99);
        thread blink_tire_outline(var2);
      } else {
        var2.health += int(var3);
      }

      continue;
    }

    if(isexplosivedamagemod(var7)) {
      var2 dodamage(var3 * 0.88, var6, var4);
      thread blink_tire_outline(var2);
      continue;
    }

    var2.health += int(var3 * 0.7);
    thread blink_tire_outline(var2);
  }

  var2 delete();
  thread toggle_tire_outlines(level, var0);
  var0.convoy notify("vehicle_lost_wheel");
  var0 notify("lost_wheel");
  var1 notify("wheel_burst");

  if(soundexists("smoke_grenade_expl_trans")) {
    var1.model_created playsoundonmovingent("smoke_grenade_expl_trans");
  }

  if(isDefined(var1.orientation)) {
    if(var1.orientation == "left") {
      playFXOnTag(scripts\engine\utility::getfx("vfx_mkilo_tire_explode_left"), var0, var1.tag);
      return;
    }

    playFXOnTag(scripts\engine\utility::getfx("vfx_mkilo_tire_explode_right"), var0, var1.tag);
    return;
  }
}

function blink_tire_outline(var0) {
  var0 notify("blink_outline");
  var0 endon("blink_outline");
  var0 endon("wheel_burst");
  var0.model_created hudoutlinedisable();
  var0.model_created hudoutlineenable("outlinefill_depth_red");
  wait 0.1;
  var0.model_created hudoutlinedisable();
  var0.model_created hudoutlineenable("outlinefill_depth_orange");
}

function toggle_tire_outlines(var0, var1, var2) {
  if(istrue(var2)) {
    if(!isDefined(var0.toggled_tire_outlines)) {
      init_tire_outlines(var0);
      var0.toggled_tire_outlines = 1;
    }
  }

  if(isDefined(var0.wheel_tags)) {
    if(!isDefined(var2)) {
      if(istrue(var1.outlined)) {
        if(isDefined(var1.model_created)) {
          var1.model_created hudoutlinedisable();
        }

        var1.outlined = 0;
        return;
      }

      if(isDefined(var1.model_created)) {
        var1.model_created hudoutlineenable("outlinefill_depth_orange");
      }

      var1.outlined = 1;
      return;
    }

    if(!istrue(var2)) {
      if(isDefined(var1.model_created)) {
        var1.model_created hudoutlinedisable();
      }

      var1.outlined = 0;
      return;
    }

    if(isDefined(var1.model_created)) {
      var1.model_created hudoutlineenable("outlinefill_depth_orange");
    }

    var1.outlined = 1;
    return;
  }
}

function check_backup_is_set(var0) {
  if(isDefined(var0.settings.backup_deposit_names)) {
    return true;
  }

  return false;
}

function route_soldiers_towards_backup_location(var0) {
  level endon("game_ended");
  var0 notify("route_soldiers_to_backups");
  var0 endon("route_soldiers_to_backups");
  var1 = var0.targeted_hvt;

  if(!istrue(var0.ref_13069)) {
    var0.ref_13069 = 1;
    var0.initialize_switches_pattern = undefined;

    if(isDefined(var1.carrier)) {
      var0.initialize_switches_pattern = var1.carrier;
    }

    var0.initialize_water_trap = gettime();
    thread allow_routing_to_end(level);
  }

  if(isDefined(var1.carrier)) {
    if(!isDefined(var0.initialize_switches_pattern) || var1.carrier != var0.initialize_switches_pattern || gettime() > var0.initialize_water_trap + 45000) {
      var0.initialize_switches_pattern = var1.carrier;
      var0.initialize_water_trap = gettime();
    } else if(isDefined(var0.chopper_carepackage_set_useable)) {
      return;
    }
  } else {
    return;
  }

  if(isDefined(var1.waypoint)) {
    if(isDefined(var1.sethotfunc)) {
      var1 thread[[var1.sethotfunc]](1);
    }
  }

  var2 = scripts\engine\utility::getStructArray(var0.settings.backup_deposit_names, "targetname");

  if(!isDefined(var2) || var2.size == 0) {
    var0 notify("allow_routing_to_end");
    return;
  }

  var3 = 2250000;

  for(var4 = 0; var4 < var2.size; var4++) {
    if(distance2dsquared(var2[var4].origin, var1.origin) < var3) {
      var2 = scripts\engine\utility::array_remove(var2, var2[var4]);
    }
  }

  var5 = scripts\engine\utility::getclosest(var1.origin, var2);
  var0.chopper_carepackage_set_useable = var5;

  if(istrue(var0.settings.recruit_enable)) {
    thread pulse_soldiers_to_help_convoy();
  }

  if(!isDefined(var0.settings.backup_deposit_names)) {
    var0 notify("allow_routing_to_end");
    return;
  }

  if(var0.backup_soldiers.size > 0) {
    foreach(var7 in var0.backup_soldiers) {
      if(istrue(var0.targeted_hvt.pickedup)) {
        send_convoy_soldier_here(var7, var5.origin, undefined, 1);

        if(istrue(var7.has_hvt)) {
          var7.goalradius = 50;
          continue;
        }

        var7.goalradius = 150;
      }
    }

    return;
  }
}

function allow_routing_to_end(var0) {
  var0 waittill("allow_routing_to_end");
  thread remove_convoy_from_level(level);

  if(isDefined(var0.eventname) && var0.eventname != "") {
    scripts\cp\cp_objectives_events::mark_event_completed(var0.eventname);
    return;
  }
}

function is_convoy() {
  if(!isDefined(self.spawner)) {
    return false;
  }

  return true;
}

function kill_convoy_all_safe(var0) {
  var1 = 0.05;

  if(isDefined(var0)) {
    var1 = var0;
  }

  if(var1 > 0) {
    wait var1;
  }

  foreach(var3 in self.spawned_vehicles) {
    if(isalive(var3)) {
      thread waittillplayersleavearea();
    }
  }
}

function kill_convoy_all(var0, var1) {
  level endon("game_ended");

  if(!isDefined(var1)) {
    var1 = 180;
  }

  var2 = var0 scripts\engine\utility::waittill_any_ents_or_timeout_return(var1, level, "debug_beat_" + var0.eventname + "_objective", var0, "kill_convoy_ents");
  var0 notify("event_convoy_delete");

  foreach(var4 in var0.spawned_vehicles) {
    if(isalive(var4)) {
      thread kill_truck_riders();
      thread delete_accessories();
      thread delete_tires();
      thread delete_my_drone_models();
      var4 delete();
    }
  }

  if(isDefined(var0.convoy_hvt_struct)) {
    var0.convoy_hvt_struct.script_noteworthy = "";
  }

  var6 = getEnt("objective_convoy_civilian", "script_noteworthy");

  if(isDefined(var6)) {
    var6 delete();
  }

  if(isDefined(var0.targeted_hvt) && isent(var0.targeted_hvt) && istrue(var0.targeted_hvt.pickedup)) {
    var0.targeted_hvt delete();
  }

  if(isDefined(var0.targeted_hvt) && isalive(var0.targeted_hvt)) {
    var0.targeted_hvt kill();
  }

  thread remove_convoy_from_level(level);

  if(isDefined(var0.eventname) && var0.eventname != "") {
    scripts\cp\cp_objectives_events::mark_event_completed(var0.eventname);
    return;
  }
}

function kill_main_truck(var0, var1) {
  var2 = var0.main_truck;

  if(isDefined(var1)) {
    wait var1;
  }

  if(isalive(var2)) {
    thread kill_truck_riders();
    thread delete_accessories();
    thread delete_tires();
    thread delete_my_drone_models();
    var2 delete();
    return;
  }
}

function kill_truck_riders() {
  foreach(var1 in self.riders) {
    if(isalive(var1)) {
      var1 dodamage(var1.health + 9990, var1.origin, undefined, undefined, "MOD_UNKNOWN");
    }
  }

  if(isDefined(self.spawned_guys)) {
    foreach(var4 in self.spawned_guys) {
      if(isalive(var4)) {
        var4 dodamage(var4.health + 9990, var4.origin, undefined, undefined, "MOD_UNKNOWN");
      }
    }
  }

  if(isDefined(self.zombiejumping)) {
    foreach(var4 in self.zombiejumping) {
      if(isalive(var4)) {
        var4 dodamage(var4.health + 9990, var4.origin, undefined, undefined, "MOD_UNKNOWN");
      }
    }

    return;
  }
}

function delete_my_drone_models() {
  var0 = self.attached_drones;

  if(isDefined(var0)) {
    foreach(var2 in var0) {
      if(isDefined(var2)) {
        var2 delete();
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
  var0 = self.convoy;
  wait 1;
  self waittill("death", var1, var2, var3, var4);

  if(isDefined(self.convoy.vehicles_remaining)) {
    self.convoy.vehicles_remaining--;
  }

  if(!isDefined(var4)) {
    var4 = self.origin;
  }

  if(isDefined(self.origin)) {
    thread play_deathfx_convoy(var1, var2, var4);
  }

  thread scripts\cp\utility::vehicle_freehealthbarui();
  thread delete_my_old_path();
  thread delete_my_drone_models();
  thread kill_truck_riders();
  thread truck_barrels_on_death(var0);
  GscBinSkip4(0x35);
}

function play_deathfx_convoy(var0, var1, var2) {
  scripts\common\vehicle_code::vehicle_playdeatheffects(var0, var1, var2);
}

function handle_vehicle_death_type() {
  if(self.type != "mkilo") {
    self.convoy.alive_support_vehicles--;

    if(istrue(self.has_hvt) && istrue(self.convoy.exiting)) {
      thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/CONVOY_2");
      thread spawnheliactorsfunc(self.convoy.targeted_hvt);
    }
  } else if(self.type == "mkilo" && !istrue(self.convoy.exiting)) {
    foreach(var1 in self.convoy.spawned_vehicles) {
      if(isalive(var1)) {
        var1.disable_leave_truck = 0;
        var1 vehicle_setspeed(0, 10, 10);
        thread waittillplayersleavearea();
      }

      var1 notify("stop_follow_path");
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
    GscBinSkip4(0x6e, self.convoy, self.convoy, self, var1, self);
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

function delete_accessories(var0) {
  if(isDefined(var0) && var0 > 0) {
    wait var0;
  }

  if(isDefined(self.accessories)) {
    foreach(var2 in self.accessories) {
      var2 delete();
    }

    return;
  }
}

function delete_tires(var0) {
  if(isDefined(var0) && var0 > 0) {
    wait var0;
  }

  if(isDefined(self.wheel_tags)) {
    foreach(var2 in self.wheel_tags) {
      if(isent(var2.model_created)) {
        var2.model_created delete();
      }

      if(isent(var2.collision_created)) {
        var2.collision_created delete();
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

  var0 = self.convoy.settings.despawn_dist;
  var1 = var0 * var0;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(self.origin, var1)) {
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

function waittillhealthlow(var0) {
  level endon("game_ended");
  self.convoy endon("event_convoy_delete");
  self endon("death");
  self.convoy endon("health_low");
  self.convoy waittill("event_convoy_spawned");
  GscBinSkip4(0x35);
}

function main_truck_compromise(var0) {
  if(isalive(var0.main_truck) && istrue(var0.not_compromised)) {
    var0.settings.ref_13f14 = undefined;
    var0.main_truck.disable_leave_truck = 0;

    if(istrue(var0.main_truck.hull_invulnerable)) {
      var0.main_truck.health = var0.main_truck.orig_health;
    }

    thread truck_compromise(var0.main_truck);

    if(soundexists("vehicle_tire_screech")) {
      var0.main_truck playSound("vehicle_tire_screech");
      return;
    }

    return;
  }
}

function truck_compromise(var0) {
  var1 = self.convoy;
  var1.lastconfirmedpos = undefined;

  foreach(var3 in self.convoy.spawned_vehicles) {
    if(isalive(var3)) {
      var3.disable_leave_truck = 0;
      level thread scripts\cp\cp_vehicles::make_guys_leave_truck(var3);
      var3 notify("unload_guys", "health_low");
      var3 notify("stop_follow_path");
      var1.lastconfirmedpos = var3.origin;
    }
  }

  wait 0.05;

  if(istrue(var0)) {
    if(isDefined(var1.attached_barrels) && var1.attached_barrels.size > 0) {
      thread truck_barrels_compromised(var1);
    }

    thread handle_healthdrain_from_lowhealth(var1);
    var1 notify("health_low");
    var1.lastconfirmedpos = self.origin;
  }

  var1.not_compromised = 0;
  var1 notify("convoy_compromised");
}

function handle_healthdrain_from_lowhealth(var0) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(var0.settings.health_drain) || var0.settings.health_drain <= 0) {
    return;
  }

  if(self.type != "mkilo") {
    return;
  }

  self.draining_health = 1;
  objective_setplayintro(var0.convoy_objectivestruct.objectiveindex, 0);
  objective_setplayoutro(var0.convoy_objectivestruct.objectiveindex, 0);
  var1 = int(var0.settings.health_drain);
  wait 1;

  for(;;) {
    self dodamage(var1, self.origin, undefined, undefined, "MOD_SUICIDE");
    objective_sethot(var0.convoy_objectivestruct.objectiveindex, 0);
    wait 0.7;
    objective_sethot(var0.convoy_objectivestruct.objectiveindex, 1);
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

function handle_smuggler_loot_attach(var0, var1, var2) {
  var3 = undefined;

  if(var1 != var2) {
    var3 = randomintrange(var1, var2 + 1);
  } else {
    var3 = var1;
  }

  if(isDefined(self.main_truck) && isalive(self.main_truck)) {
    thread attach_barrels_to_truck(self.main_truck, "tag_accessory_01");
    return;
  }
}

function handle_smuggler_loot_drop(var0, var1, var2) {
  var3 = 0;
  var4 = 1;

  if(isDefined(var1)) {
    var3 = var1;
  }

  if(isDefined(var2)) {
    var4 = var2;
  }

  if(var3 > var4) {
    var3 = var4 - 1;
  }

  if(var4 <= 0 || var3 < 0) {
    self.settings.barrels_on_death = 0;
    return;
  }

  if(var3 == var4) {
    self.settings.barrels_on_death = var3;
    return;
  }

  self.settings.barrels_on_death = randomintrange(var3, var4 + 1);
}

function attach_barrels_to_truck(var0, var1) {
  var2 = self gettagorigin(var0);

  if(!isDefined(var2)) {
    return;
  }

  var3 = 28;
  var4 = 2;
  var5 = self gettagangles(var0);

  if(!isDefined(self.convoy.attached_barrels)) {
    self.convoy.attached_barrels = [];
  }

  for(var6 = 0; var6 < var1; var6++) {
    var7 = var3 * 0.51;

    if(var6 % 2 == 0) {
      var7 *= -1;
    }

    var8 = var6 * (var3 * 0.5 + var4);
    var9 = (var8 * -1, var7, 0);
    var10 = rotatevector(var9, self.angles);
    var11 = var2 + var10;
    var12 = randomintrange(0, 359);
    var13 = (var5[0], var12, var5[2]);
    var14 = thread spawn_phys_barrel_pickup(level, var11, var13);
    self.convoy.attached_barrels[self.convoy.attached_barrels.size] = var14;
  }
}

function spawn_phys_barrel_pickup(var0, var1, var2) {
  var3 = spawn("script_model", var0);
  var3.angles = var1;
  var3 setModel("container_nitrate_barrel_01");
  var3 notsolid();
  var3 show();
  var3.owner = var2;
  var3 linkTo(var2);
  spawn_barrel_straps(var3);
  return var3;
}

function spawn_barrel_collision(var0) {
  var1 = spawn("script_model", self.origin);
  var1 dontinterpolate();
  var1.angles = var0;
  var1 clonebrushmodeltoscriptmodel(level.taccovercollision);
  var1 linkTo(self);
  return var1;
}

function spawn_barrel_straps() {
  var0 = spawn("script_model", self.origin);
  var0.angles = self.angles;
  var0 setModel("accessory_barrel_bomb_strap_01");
  var0 notsolid();
  var0 show();
  var0 linkTo(self);

  if(!isDefined(self.straps)) {
    self.straps = [];
  }

  self.straps[self.straps.size] = var0;
  return var0;
}

function spawn_barrel_tracker(var0) {
  var1 = (0, 0, 3);
  var2 = spawn("script_model", self.origin + var1);
  var2.angles = (0, 0, 0);
  var2 setModel("decor_balloon_bunch_01");
  var2 notsolid();
  var2 show();
  var2 linkTo(self);
  var2 playLoopSound("capture_alert_lp");

  if(!isDefined(self.trackers)) {
    self.trackers = [];
  }

  self.trackers[self.trackers.size] = var2;
  return var2;
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

function truck_barrels_compromised(var0) {
  if(!isDefined(var0.attached_barrels)) {
    return;
  }

  delay_suspend_vehicle();
  var1 = 10;

  for(var2 = 0; var2 < var0.attached_barrels.size; var2++) {
    if(var2 == 0) {
      playrumbleonposition("grenade_rumble", var0.attached_barrels[var2].origin);
      earthquake(0.5, 1, var0.attached_barrels[var2].origin, 1500);
    }

    var3 = var0.attached_barrels[var2];
    var3 solid();
    var3 show();
    var3 unlink();

    for(var4 = 0; var4 < var3.straps.size; var4++) {
      var3.straps[var4] delete();
    }

    thread launch_barrel_away(var3, 28, var1);
    var3 hudoutlineenable("outline_nodepth_red");
    thread init_smuggler_loot_interaction();
  }

  physicsexplosionsphere(var0.attached_barrels[0].origin, 150, 120, 90);
}

function launch_barrel_away(var0, var1, var2) {
  self endon("loot_marked");
  self endon("death");

  if(!isDefined(var0)) {
    var0 = 30;
  }

  var3 = var2.origin;
  self physicslaunchserver(self.origin, (0, 0, 0));
  var4 = 0;
  var5 = (0, 0, 0);
  wait var1 / 2;

  if(self.origin[2] > var3[2]) {
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

function barrel_fulton(var0) {
  var1 = 15;
  var2 = randomintrange(2300, 2800);
  var3 = randomintrange(1, 3);
  self moveTo(self.origin + (0, 0, var2), var1, var3, 4);
  wait var1 * 0.66;
  barrel_wind_to_above_truck(var0);
}

function barrel_wind_to_above_truck(var0) {
  if(distance2d(self.origin, var0) > 500) {
    var1 = (var0[0], var0[1], self.origin[2]);
    self moveTo(var1, 8, 3, 3);
    return;
  }
}

function truck_barrels_on_death(var0) {
  if(!isDefined(var0.attached_barrels) || var0.attached_barrels.size <= var0.settings.barrels_on_death) {
    return;
  }

  if(!isDefined(level._effect["grenadeexp_default"])) {
    level._effect["grenadeexp_default"] = loadfx("vfx/core/expl/grenadeexp_default");
  }

  var1 = var0.settings.barrels_on_death;

  for(var2 = 0; var2 < var0.attached_barrels.size; var2++) {
    if(istrue(var0.attached_barrels[var2].loot_marked)) {
      var1 = -1;
      continue;
    }

    if(!isDefined(var0.attached_barrels[var2]) || !isDefined(var0.attached_barrels[var2].origin)) {
      continue;
    }

    var3 = var0.lastconfirmedpos;

    if(isDefined(var3)) {
      if(distance2d(var0.attached_barrels[var2].origin, var3) > 1200) {
        continue;
      }
    }

    if(isDefined(var1) && var1 > 0) {
      var1--;
      continue;
    }

    if(isent(var0.attached_barrels[var2])) {
      var4 = anglesToForward(var0.attached_barrels[var2].angles);
      playFX(scripts\engine\utility::getfx("grenadeexp_default"), var0.attached_barrels[var2].origin, var4);

      if(soundexists("breach_c4_expl_trans")) {
        playsoundatpos(var0.attached_barrels[var2].origin, "breach_c4_expl_trans");
      }

      earthquake(0.4, 0.7, var0.attached_barrels[var2].origin, 800);
      playrumbleonposition("grenade_rumble", var0.attached_barrels[var2].origin);
      var0.attached_barrels[var2] delete();

      if(isDefined(var0.attached_barrels[var2].last_player)) {
        var0.attached_barrels[var2].last_player cameradefault();
        var0.attached_barrels[var2].last_player scripts\cp\utility::freezecontrolswrapper(0);

        if(istrue(var0.attached_barrels[var2].last_player.cantswitch)) {
          var0.attached_barrels[var2].last_player scripts\common\utility::allow_weapon_switch(1);
          var0.attached_barrels[var2].last_player.cantswitch = undefined;
        }

        var0.attached_barrels[var2].last_player scripts\cp\cp_kidnapper::setimmunetokidnapper(0);
        var0.attached_barrels[var2].last_player setclientomnvar("ui_securing_progress", 0);
        var0.attached_barrels[var2].last_player setclientomnvar("ui_securing", 0);
        thread barrel_cancel_animate_player(level);
      }
    }
  }

  convoy_update_label_to_loot_num(var0);
}

function init_smuggler_loot_interaction() {
  for(var0 = 0; var0 < self.convoy.attached_barrels.size; var0++) {
    if(istrue(self.convoy.attached_barrels[var0].setup_interact)) {
      return;
    }

    var1 = spawnStruct();
    var1.origin = self.convoy.attached_barrels[var0].origin;
    var1.targetname = "interactible";
    var1.script_noteworthy = "smuggler_loot_interaction";
    self.convoy.attached_barrels[var0].interaction = var1;
    self.convoy.attached_barrels[var0].setup_interact = 1;
    temp_make_barrel_interactible(self.convoy.attached_barrels[var0], self.origin);
  }

  wait 0.05;
}

function temp_make_barrel_interactible(var0, var1) {
  var0 setHintString(&"CP_CONVOYS/LOOT_MARK");
  var0 setCursorHint("HINT_BUTTON");
  var0 sethintdisplayrange(1200);
  var0 sethintdisplayfov(150);
  var0 sethinticon("hud_icon_door_open");
  var0 setuserange(112);
  var0 setusefov(90);
  var0 sethintonobstruction("show");
  var0 setuseholdduration("duration_long");
  var0 makeusable();
  thread temp_make_barrel_think(var0);
  thread barrel_early_exit();
}

function temp_make_barrel_think(var0) {
  self endon("death");
  GscBinSkip4(0x35);
}

function barrel_collect_chance() {
  var0 = 10;
  var1 = 0;

  if(level.obj_current_barrels_scanned < var0) {
    var1 = level.obj_current_barrels_scanned / var0;
  } else {
    var1 = 100;
  }

  return var1 > randomintrange(0, 11);
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
    for(var0 = 0; var0 < level.players.size; var0++) {
      self enableplayeruse(level.players[var0]);
    }

    barrel_unfreeze();
    return;
  }
}

function convoy_update_label_to_loot_num(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(true) {
    return;
  }

  var1 = var0 scripts\cp\cp_convoy_manager::get_smuggler_loot_amount();

  if(isDefined(var1)) {
    if(var1 <= 0) {
      objective_icon_show(var0, 0);
      var0 notify("convoy_all_loot_taken");
      return;
    }

    var2 = get_nitrate_label(var1);
    objective_icon_show_label(var0, var2);
    return;
  }
}

function barrel_handle_cancellation() {
  for(;;) {
    self waittill("trigger_progress", var0);

    if(isDefined(var0)) {
      if(!var0 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      self.last_player = var0;
      var1 = 4096;

      if(distancesquared(self.origin, getclosestpointonnavmesh(self.origin)) < var1) {
        thread barrel_animate_player(self, var0);
      }

      var0 cameraset("camera_custom_orbit_1");
      var0 scripts\cp\utility::freezecontrolswrapper(1);
      var0 scripts\cp\cp_kidnapper::setimmunetokidnapper(1);
      var0 setclientomnvar("ui_securing", 1);
      var0 scripts\common\utility::allow_weapon_switch(0);
      var0.cantswitch = 1;
      barrel_freeze();

      for(var2 = 0; var2 < level.players.size; var2++) {
        if(level.players[var2] != var0) {
          self disableplayeruse(level.players[var2]);
        }
      }

      var3 = 5;
      var4 = 0;

      while(var0 useButtonPressed() && var4 < var3) {
        var0 setclientomnvar("ui_securing_progress", var4 / var3);
        wait 0.05;
        var4 += 0.05;
      }

      self notify("captured", var0);
      self.last_player = undefined;
      var0 cameradefault();
      var0 scripts\cp\utility::freezecontrolswrapper(0);
      var0 scripts\cp\cp_kidnapper::setimmunetokidnapper(0);

      if(istrue(var0.cantswitch)) {
        var0 scripts\common\utility::allow_weapon_switch(1);
        var0.cantswitch = undefined;
      }

      var0 setclientomnvar("ui_securing_progress", 0);
      var0 setclientomnvar("ui_securing", 0);
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

function barrel_animate_player(var0, var1) {
  if(!isDefined(level.scr_anim["player"]) || !isDefined(level.scr_anim["player"]["scan_barrel"])) {
    return;
  }

  var2 = (0, vectortoangles(self.origin - var1.origin)[1], 0);
  var3 = vectorNormalize(var1.origin - self.origin);
  var3 *= 32;
  var1.barrelscan_animscene = spawnStruct();
  var4 = scripts\engine\utility::drop_to_ground(self.origin + var3);
  var1.barrelscan_animscene.origin = var4;
  var1.barrelscan_animscene.angles = var2;
  var5 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var1, "player", 1, 0, 1);
  var1.barrelscan_animactor = var5;
  var5 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  var6 = var1.barrelscan_animscene scripts\cp_mp\anim_scene::anim_scene_loop([var5], "scan_barrel");
  var1.barrelscan_animscene = undefined;
}

function barrel_cancel_animate_player(var0) {
  if(isDefined(var0.barrelscan_animscene)) {
    var0.barrelscan_animscene scripts\cp_mp\anim_scene::anim_scene_stop_actor(var0.barrelscan_animactor);
    var0.barrelscan_animscene scripts\cp_mp\anim_scene::anim_scene_stop(1);
    return;
  }
}

function smuggler_loot_hint_func(var0, var1) {
  return &"CP_CONVOYS/LOOT_MARK";
}

function smuggler_loot_activate_func(var0, var1) {
  var1 endon("disconnect");

  if(istrue(var0.disabled)) {
    return;
  }

  if(istrue(var1.tablet_out)) {
    return;
  }
}

function smuggler_loot_init_func(var0) {
  level endon("game_ended");
  level.pentskipfov["smuggler_loot_interaction"] = 1;

  foreach(var2 in var0) {
    var2.p_ent_skip_fov = 1;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var2);
    scripts\cp\coop_personal_ents::addtopersonalinteractionlist(var2);
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

  foreach(var1 in level.players) {
    var1 iprintlnbold("^3 Nitrate Marked: " + level.smuggler_loot_collected + " / " + level.smuggler_loot_max);
  }

  if(level.smuggler_loot_collected >= level.smuggler_loot_max) {
    thread smuggler_temp_ending();
    return;
  }
}

function smuggler_loot_despawn(var0) {
  level endon("game_ended");
  self endon("death");
  var1 = self.owner;
  var2 = var0 * var0;

  for(;;) {
    wait 1;

    if(!scripts\cp\utility::any_player_nearby(self.origin, var2)) {
      break;
    }
  }

  if(isDefined(self.trackers) && self.trackers.size > 0) {
    foreach(var4 in self.trackers) {
      var4 stoploopsound();
      var4 delete();
    }
  }

  self delete();
  convoy_update_label_to_loot_num(var1.convoy);
}

function smuggler_temp_ending() {
  level.smuggler_disable_loots = 1;
  level notify("convoy_mission_complete");
  wait 3;
}

function get_nitrate_label(var0) {
  var1 = &"";

  if(!isDefined(var0)) {
    return var1;
  }

  switch (var0) {
    case 1:
      var1 = &"CP_CONVOYS/STR_1";
      break;
    case 2:
      var1 = &"CP_CONVOYS/STR_2";
      break;
    case 3:
      var1 = &"CP_CONVOYS/STR_3";
      break;
    case 4:
      var1 = &"CP_CONVOYS/STR_4";
      break;
    case 5:
      var1 = &"CP_CONVOYS/STR_5";
      break;
    case 6:
      var1 = &"CP_CONVOYS/STR_6";
      break;
    case 7:
      var1 = &"CP_CONVOYS/STR_7";
      break;
    case 8:
      var1 = &"CP_CONVOYS/STR_8";
      break;
    case 9:
      var1 = &"CP_CONVOYS/STR_9";
      break;
    case 10:
      var1 = &"CP_CONVOYS/STR_10";
      break;
    case 11:
      var1 = &"CP_CONVOYS/STR_11";
      break;
    case 12:
      var1 = &"CP_CONVOYS/STR_12";
      break;
    case 13:
      var1 = &"CP_CONVOYS/STR_13";
      break;
    case 14:
      var1 = &"CP_CONVOYS/STR_14";
      break;
    case 15:
      var1 = &"CP_CONVOYS/STR_15";
      break;
    case 16:
      var1 = &"CP_CONVOYS/STR_16";
      break;
    case 17:
      var1 = &"CP_CONVOYS/STR_17";
      break;
    case 18:
      var1 = &"CP_CONVOYS/STR_18";
      break;
    case 19:
      var1 = &"CP_CONVOYS/STR_19";
      break;
    case 20:
      var1 = &"CP_CONVOYS/STR_20";
      break;
  }

  return var1;
}

function print_nitrate_text(var0) {
  if(isDefined(level.convoy_hud_text)) {
    level.convoy_hud_text destroy();
  }

  var1 = newhudelem();
  var1.alignx = "left";
  var1.aligny = "top";
  var1.x = -32;
  var1.y = 47;
  var2 = get_nitrate_label(var0);
  var1 settext(var2);
  var1.fontscale = 1;
  var1.alpha = 1;
  level.convoy_hud_text = var1;
}

function waittillcompromised(var0, var1) {
  level endon("game_ended");
  var1 endon("event_convoy_delete");

  if(isDefined(var1.eventname) && var1.eventname != "") {
    level endon("debug_" + var1.eventname + "_completed");
  }

  self endon("death");
  var1 endon("convoy_compromised_early");

  if(!isDefined(var1.backup_soldiers)) {
    var1.backup_soldiers = [];
  }

  wait 1;

  if(isDefined(self.type) && (var1.settings.amount_to_compromise > 0 || istrue(var1.settings.center_compromises) && self.type == "mkilo") && var1.alive_support_vehicles > 0) {
    while((self.convoy.alive_support_vehicles > 0 || var1.backup_soldiers.size > 0) && istrue(self.convoy.not_compromised)) {
      wait 0.5;
    }

    while(!istrue(self.arrived_at_goal) && !istrue(var1.settings.can_compromise_before_first_target) && !istrue(self.convoy.settings.roaming)) {
      wait 0.5;
    }

    if(isDefined(var1.main_truck) && self != var1.main_truck) {
      return;
    }

    foreach(var3 in self.convoy.spawned_vehicles) {
      if(isalive(var3)) {
        var3 vehicle_setspeed(0, 150, 150);
        var3.disable_leave_truck = 0;
      }

      var3 notify("stop_follow_path");
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

function waittillarriveatdestination(var0, var1) {
  level endon("game_ended");
  var1 endon("convoy_compromised");
  var1 endon("event_convoy_delete");
  jumpiffalse(isDefined(self.type) && self.type != "mkilo") LOC_00000031;
  return;
}

function stop_all_convoy_cars(var0) {
  if(!istrue(self.convoy.settings.enable_stop_all_cars)) {
    return;
  }

  foreach(var2 in self.convoy.spawned_vehicles) {
    if(isalive(var2)) {
      if(!istrue(var0)) {
        var2 notify("unload_guys", "stop_all_convoy_cars");
      }

      var2 notify("stop_follow_path");
      var2 vehicle_setspeedimmediate(0, 120, 120);
      var2.veh_brake = 1;
      var2.disable_horn = 1;
    }
  }
}

function spawn_soldiers_route_to_hvt(var0) {
  var0 = self.convoy.using_path;
  thread stop_all_convoy_cars();
  wait 1;
  var1 = undefined;

  if(isent(self.convoy.settings.target)) {
    var1 = self.convoy.settings.target;
  }

  if(isDefined(self.convoy.targeted_hvt)) {
    var1 = self.convoy.targeted_hvt;
  }

  if(!isDefined(var1)) {
    var1 = getEnt("objective_convoy_civilian_" + var0, "targetname");
  }

  if(!isDefined(var1)) {
    var1 = getEnt(self.convoy.settings.target, "script_noteworthy");
    self.convoy.targeted_hvt = var1;
  }

  if(!isDefined(var1)) {
    if(isDefined(self.convoy.settings.target)) {
      wait 15;
      var1 = getEnt(self.convoy.settings.target, "script_noteworthy");
      self.convoy.targeted_hvt = var1;
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

  if(!istrue(var1.carried_by_vehicle) && !(isDefined(var1.carrier) && isPlayer(var1.carrier))) {
    var1 unlink();
  }

  var2 = self;

  if(isDefined(self.convoy.main_truck)) {
    var2 = self.convoy.main_truck;
  }

  if(istrue(self.convoy.settings.route_to_any_veh)) {
    thread waittill_hvt_at_vehicle(var2, var1);
  }

  if(!isDefined(self.riders) || self.riders.size == 0) {
    return;
  }

  if(isDefined(self.type) && self.type == "mkilo") {
    if(istrue(self.convoy.settings.recruit_enable)) {
      thread temp_spawn_backup_on_apc(var1);
    }

    var3 = self.riders.size;
    var4 = [];

    foreach(var6 in self.riders) {
      if(isalive(var6)) {
        var4 = var6;
      }
    }

    var8 = int(var4.size / 4 * 3);
    var8 = var4.size;
    self.convoy.convoy_hvt_squad_alive = var8;
    self.convoy_apc_spawned_riders = [];

    foreach(var10 in var4) {
      self.convoy_apc_spawned_riders[self.convoy_apc_spawned_riders.size] = var10;
    }

    for(var12 = 0; var12 < var8; var12++) {
      apply_apc_soldier_settings(var4[var12], var1, self.convoy);
      var4[var12].convoy = self.convoy;
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

      foreach(var1 in self.convoy.spawned_vehicles) {
        if(can_route_othercar(var1)) {
          thread waittill_hvt_at_vehicle(var1, self.convoy.targeted_hvt);

          if(self.convoy.backup_soldiers.size > 0) {
            foreach(var3 in self.convoy.backup_soldiers) {
              if(isalive(var3)) {
                var3.truck = var1;
              }

              if(istrue(self.convoy.targeted_hvt.pickedup)) {
                send_convoy_soldier_here(var3, var1.origin);

                if(istrue(var3.has_hvt)) {
                  var3.goalradius = 50;
                } else {
                  var3.goalradius = 250;
                }
              }

              var1.riders[var1.riders.size] = var3;
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

function can_route_othercar(var0) {
  if(!istrue(self.convoy.settings.route_to_any_veh)) {
    return false;
  }

  if(isDefined(var0) && isalive(var0) && var0 != self) {
    if(var0.type != "mkilo" && istrue(self.convoy.settings.route_to_other_support_veh)) {
      return true;
    } else if(var0.type == "mkilo") {
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
      var0 = self.settings.target;
    } else {
      var0 = getEnt(self.settings.target, "script_noteworthy");
    }

    self.targeted_hvt = var0;
  }

  if(!isDefined(self.targeted_hvt)) {
    return;
  }

  self.targeted_hvt endon("death");
  var1 = self.settings.recruit_time_until;
  wait var1;
  GscBinSkip4(0x6e, self.targeted_hvt, self);
}

function grab_nearby_soldiers_and_apply_settings(var0) {
  var1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var1 = sortbydistance(var1, self.origin);
  var2 = var0.settings.recruit_distance * var0.settings.recruit_distance;

  if(!isDefined(var0.backup_soldiers)) {
    var0.backup_soldiers = [];
  }

  foreach(var4 in var1) {
    if(!(isDefined(var4) && isalive(var4))) {
      continue;
    }

    if(!isDefined(var4.agent_type)) {
      continue;
    }

    if(distance2dsquared(self.origin, var4.origin) > var2) {
      continue;
    }

    if(!istrue(var0.settings.recruit_juggs) && var4 scripts\cp\cp_modular_spawning::is_juggernaut_aitype()) {
      continue;
    }

    if(isDefined(var4.agent_type) && istrue(var4.agent_type == "juggernaut")) {
      continue;
    }

    if(isDefined(var4.aitype) && istrue(var4.aitype == "juggernaut")) {
      continue;
    }

    if(isDefined(var4.aitype) && istrue(var4.aitype == "suicidebomber")) {
      continue;
    }

    if(isDefined(var0.main_truck.riders) && scripts\engine\utility::array_contains(var0.main_truck.riders, var4)) {
      continue;
    }

    apply_apc_soldier_settings(var4, undefined, var0);
  }
}

function apply_apc_soldier_settings(var0, var1) {
  if(!isDefined(var0)) {
    if(isDefined(var1.targeted_hvt)) {
      var0 = var1.targeted_hvt;
    }
  }

  if(!isDefined(var1.backup_soldiers)) {
    var1.backup_soldiers = [];
  }

  if(!scripts\engine\utility::array_contains(var1.backup_soldiers, self) && var1.backup_soldiers.size < var1.settings.recruit_amount) {
    var1.backup_soldiers[var1.backup_soldiers.size] = self;
    thread waittillarriveathvt(var0, var1);
    thread waittill_backup_death(var1);

    if(isDefined(self.script_origin_other)) {
      self.script_origin_other = undefined;
    }

    if(!scripts\cp\cp_modular_spawning::is_juggernaut_aitype()) {
      scripts\engine\utility::set_movement_speed(230);
    }

    if(isDefined(var1)) {
      self.convoy = var1;
    }

    scripts\cp\cp_squadmanager::removefromsquad();
    return;
  }
}

function waittill_backup_death(var0) {
  var0 endon("event_convoy_delete");
  level endon("game_ended");
  self waittill("death");
  var0.backup_soldiers = scripts\engine\utility::array_remove(var0.backup_soldiers, self);
}

function temp_spawn_backup_on_apc(var0) {
  self endon("death");
  self.convoy endon("convoy_compromised");
  level endon("game_ended");
  self.convoy endon("event_convoy_exit");
  jumpiffalse(getdvarint("scr_event_convoy_disablebackup", 0) == 1) LOC_00000037;
  return;
}

function waittillarriveathvt(var0, var1) {
  level endon("game_ended");
  var1 endon("event_convoy_delete");
  var1 endon("event_convoy_exit");
  self notify("apply_convoy_soldier_settings");
  self endon("apply_convoy_soldier_settings");
  var0 endon("death");
  var2 = 60;
  var3 = var2 * var2;
  var4 = 400;
  var5 = var4 * var4;

  while(isalive(self) && !scripts\engine\utility::doinglongdeath()) {
    if(!isalive(self)) {
      return;
    }

    if(scripts\engine\utility::doinglongdeath()) {
      return;
    }

    if(!istrue(var0.pickedup) && !istrue(var0.carried)) {
      while(distancesquared(self.origin, var0.origin) > var3) {
        if(istrue(var0.pickedup) || istrue(var0.carried)) {
          break;
        }

        wait 1;

        if(isalive(self)) {
          send_convoy_soldier_here(var0.origin);

          if(!event_can_pickup_hvt(var0, var1)) {
            self.goalradius = var1.settings.goal_distance;
            continue;
          }

          scripts\engine\utility::set_movement_speed(190);
          self.goalradius = 80;
        }
      }

      if(isalive(self) && !istrue(var0.pickedup) && !istrue(var0.carried) && !istrue(var0.pickup_disabled) && event_can_pickup_hvt(var0, var1) && !istrue(players_nearby_hvt(var0)) && !istrue(self.little_bird_mg_cp_createfromstructs)) {
        if(istrue(var0.carried_by_vehicle)) {
          if(istrue(var1.settings.can_steal_hvt)) {
            self.goalradius = 450;
            thread convoy_steal_hvt_from_player_car();
          } else {
            self.goalradius = 1200;
          }

          wait 1;
        } else if(var1.vehicles_remaining <= 0 && !isDefined(var1.settings.backup_deposit_names)) {
          self.goalradius = 4000;
          wait 1;
        } else {
          thread first_hvt_pickup(var0, var1);
          thread monitor_hvt_pickup(var0, var1);
          convoy_pickup_hvt_settings(var0, var1);
        }
      }
    } else if(istrue(var0.pickedup)) {
      take_cover_near_hvt(var1);
    }

    var6 = randomfloatrange(2, 4);
    wait var6;
  }
}

function convoy_steal_hvt_from_player_car() {
  level endon("game_ended");
  var0 = scripts\engine\utility::getclosest(self.origin, level.vehicle_travel_array);

  if(!isDefined(var0)) {
    return;
  }

  if(var0 vehicle_getspeed() > 1) {
    return;
  }

  if(!istrue(var0.stealing_hvt)) {
    var0.stealing_hvt = 1;
    wait 1.5;

    if(isDefined(var0)) {
      var0.stealing_hvt = 0;

      if(var0 vehicle_getspeed() > 1) {
        return;
      }

      if(isalive(self) && isDefined(var0) && isDefined(var0.hostage)) {
        var1 = level.vehicle_interaction_info["retrieve_hostage"];
        scripts\cp\maps\cp_br_syrk\vehicle_travel::exit_retrieve_hostage(var1, self, var0);
        return;
      }

      return;
    }

    return;
  }
}

function convoy_pickup_hvt_settings(var0, var1) {
  var0.pickedup = 1;
  var0.pickup_disabled = 1;
  var0 makeunusable();

  if(isDefined(var0.trigger)) {
    var0.trigger makeunusable();
  }

  if(isDefined(var0.interaction_handle)) {
    var0.interaction_handle makeunusable();
  }

  binoculars_setexpirationtimer(var0, var1);

  if(!isalive(self) || scripts\engine\utility::doinglongdeath()) {
    return;
  }

  var2 = "tag_stowed_back";
  var3 = 0;
  var4 = undefined;

  if(istrue(var1.settings.pickup_uses_origin)) {
    var3 = -768;
    var2 = "tag_origin";
  }

  var0 linkTo(self, var2, (0, 0, var3), (0, 0, 0));
  self.has_hvt = 1;
  self.dontkilloff = 1;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.maxhealth = 400;
  self.health = self.maxhealth;
  scripts\common\utility::demeanor_override("sprint");
  self.scripted_mode = 1;
  var0.carrier = self;
  self notify("get_enemy_info_loop");
  var0 setCanDamage(0);
  var0.scripted_mode = 1;

  if(!isDefined(var0.bodymodel)) {
    var0.bodymodel = var0.model;
  }

  self.default_starting_pistol = level.players[0].default_starting_pistol;

  if(istrue(var1.settings.hide_icon_on_pickup)) {
    objective_icon_show(var1, 0);
  }

  self setcarryobject("hostage_mage");

  if(isDefined(var0.waypoint)) {
    if(isDefined(var0.sethotfunc)) {
      var0 thread[[var0.sethotfunc]](1);
    }
  }

  if(isagent(var0)) {
    if(isDefined(var0.head)) {
      var0.head setModel("head_usmc_ar_invisible");
    }

    var0 setModel("body_usmc_ar_invisible");
    var0 scripts\cp\cp_vip::disable_outline();

    if(isDefined(var0.objnum)) {
      objective_setzoffset(var0.objnum, 768);
      return;
    }

    return;
  }

  var0 hide();

  if(isDefined(var0.body)) {
    var0.body hide();
  }

  if(isDefined(var0.head)) {
    var0.head hide();
    return;
  }
}

function binoculars_setexpirationtimer(var0, var1) {
  if(isai(self)) {
    self.scripted_mode = 1;
    self.restoreweapon = self.ref_1237e;
    self takeweapon(self.weapon);
    var0.clearandrestoreinfectedtacinsert = 1;
    var0.play_trialympic_flames = 1;
    var2 = spawn("script_origin", var0.origin);
    var2.origin = var0.origin;
    var2.angles = var0.angles;
    self.ref_12f89 = var2;
    self.ref_12f89 scripts\common\anim::anim_first_frame_solo(var0.body, "pickup_hvt_ground");
    thread binoculars_setpendingtimer(self.ref_12f89, self);
    scripts\asm\shared\mp\utility::burningpartlogic("sdr_cp_hostage_pickup_ground_player", self.ref_12f89, undefined, 0, "animscripted2");
  }

  if(isDefined(self.ref_12f89)) {
    self.ref_12f89 delete();
    self.ref_12f89 = undefined;
  }

  var0.clearandrestoreinfectedtacinsert = 0;

  if(!isalive(self)) {
    return false;
  }

  if(isDefined(self.restoreweapon)) {
    self giveweapon(self.restoreweapon);
  }

  self.scripted_mode = 0;
  scripts\asm\shared\mp\utility::bunkercounteruav();
  var0.play_trialympic_flames = 0;
  return true;
}

function binoculars_setpendingtimer(var0, var1) {
  var1 endon("death");
  var2 = "pickup_hvt_ground";
  var1.body endon(var2);
  var1.body childthread scripts\common\anim::anim_single_solo(var1.body, var2);
  var0 waittill("death");

  if(isDefined(var1.idleanim)) {
    var1.body scriptmodelplayanim(var1.idleanim);

    if(isDefined(var1.head)) {
      var1.head scriptmodelplayanim(var1.idleanim);
    }
  }

  var1.body notify(var2);
}

function event_can_pickup_hvt(var0) {
  return (isDefined(self.convoy_can_pickup) && istrue(self.convoy_can_pickup) || !isDefined(self.convoy_can_pickup)) && isDefined(var0.settings) && istrue(var0.settings.can_pickup_hvt);
}

function players_nearby_hvt(var0) {
  var1 = 165;
  var2 = var1 * var1;

  for(var3 = 0; var3 < level.players.size; var3++) {
    if(!level.players[var3] scripts\cp_mp\utility\player_utility::_isalive() || istrue(level.players[var3].inlaststand)) {
      continue;
    }

    if(distancesquared(level.players[var3].origin, var0.origin) > var2) {
      continue;
    }

    return true;
  }

  return false;
}

function first_hvt_pickup(var0, var1) {
  if(!istrue(var1.target_first_interacted)) {
    var0 notify("convoy_pickedup_hvt");
    var1.target_first_interacted = 1;
    var1.target_first_interacted_routing = 1;
    take_cover_near_hvt(var1);
    wait 1.25;
    var1.target_first_interacted_routing = undefined;
    take_cover_near_hvt(var1);
    wait 2.25;

    if(isalive(self) && isDefined(var1.main_truck)) {
      if(istrue(var1.settings.toggle_vo_on_hvt_pickup)) {
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
    var1.target_first_interacted = undefined;
    return;
  }
}

function take_cover_near_hvt(var0) {
  if(istrue(var0.target_first_interacted_routing) && level.gameskill <= 2) {
    send_convoy_soldier_here(self.origin);
    self.goalradius = 1500;
    return;
  }

  if(isDefined(var0.main_truck) && isalive(var0.main_truck) && !istrue(var0.exiting) && istrue(var0.settings.route_to_any_veh) && istrue(var0.not_compromised)) {
    var1 = getstartorigin(var0.main_truck.origin, var0.main_truck.angles, %sdr_cp_hostage_dropoff_mkilo23_carry_smuggler);
    send_convoy_soldier_here(var1, var0);
  } else if(check_backup_is_set(var0)) {
    thread route_soldiers_towards_backup_location(level);
  }

  if(istrue(self.has_hvt)) {
    self.goalradius = 50;
    return;
  }

  self.goalradius = 600;
}

function send_convoy_soldier_here(var0, var1, var2) {
  var3 = getclosestpointonnavmesh(var0);

  if(isDefined(var1)) {
    var1.convoy_board_pos = var3;
  }

  self setgoalpos(var3);

  if(istrue(var2)) {
    thread little_bird_mg_cp_initlate(var3);
    return;
  }

  self notify("tracking_getto_ignore");
}

function little_bird_mg_cp_initlate(var0) {
  level endon("game_ended");
  self endon("death");
  self notify("tracking_getto_ignore");
  self endon("tracking_getto_ignore");
  var1 = 14400;
  self.ignoreall = 1;

  for(;;) {
    if(distancesquared(self.origin, var0) < var1) {
      self.ignoreall = 0;
    }

    wait 1;
  }
}

function monitor_hvt_pickup(var0, var1) {
  level endon("game_ended");
  var1 endon("event_convoy_delete");
  var1 endon("event_convoy_exit");
  level notify("monitor_convoy_hvt");
  level endon("monitor_convoy_hvt");
  wait 0.1;

  while(istrue(var0.clearandrestoreinfectedtacinsert)) {
    waitframe();
  }

  var2 = 200;
  var3 = var2 * var2;

  while(isalive(self) && !scripts\engine\utility::doinglongdeath()) {
    wait 0.1;

    if(distance2dsquared(self.origin, var0.origin) > var3) {
      var0.origin = self.origin;
      var0 linkTo(self, "tag_stowed_back", (0, 0, 0), (0, 0, 0));
    }

    if(isDefined(var0.carrier)) {
      if(var0.carrier != self) {
        break;
      }
    }
  }

  if(isagent(var0)) {
    if(isDefined(var0.head)) {
      var0.head setModel(var0.head.oldhead);
    }

    var0 setModel(var0.bodymodel);
    var0 scripts\cp\cp_vip::enable_outline();

    if(isDefined(var0.objnum)) {
      objective_setzoffset(var0.objnum, 75);
    }
  } else {
    var0 show();

    if(isDefined(var0.body)) {
      var0.body show();
    }

    if(isDefined(var0.head)) {
      var0.head show();
    }
  }

  if(isDefined(var0.waypoint)) {
    if(isDefined(var0.sethotfunc)) {
      var0 thread[[var0.sethotfunc]](1);
    }
  }

  var0 unlink();
  self.dontkilloff = 0;
  var0.pickedup = 0;
  var0.pickup_disabled = 0;
  self.has_hvt = 0;
  self.ignoreall = 0;
  var0 setCanDamage(1);
  var0.scripted_mode = 0;

  if(isDefined(var0.trigger)) {
    var0.trigger makeusable();
  }

  if(isDefined(var0.interaction_handle)) {
    var0.interaction_handle makeusable();
  }

  if(!istrue(var0.play_trialympic_flames)) {
    var4 = scripts\cp\cp_pickup_hostage::get_hostage_drop_pos(self);
    var4 = scripts\cp\cp_pickup_hostage::_getphysicspointaboutnavmesh(var4) + (0, 0, 2);
    var0.origin = var4;
    var0.angles = (0, var0.angles[1], 0);
  }

  var0 thread scripts\cp\cp_pickup_hostage::spawn_module_building_chopper2(self);

  if(isDefined(var0.idleanim)) {
    var0.body scriptmodelplayanim(var0.idleanim);

    if(isDefined(var0.head)) {
      var0.head scriptmodelplayanim(var0.idleanim);
    }
  }

  hvt_ent_delete_wm(var1);
  objective_icon_show(var1, 1);
}

function hvt_ent_delete_wm(var0) {
  var1 = undefined;

  if(isDefined(self.wmhostage)) {
    var1 = self.wmhostage;
  }

  if(isDefined(var0.soldier_wmhostage)) {
    var1 = var0.soldier_wmhostage;
  }

  self resetcarryobject();

  if(isDefined(var1)) {
    var1 unlink();

    if(isDefined(var1.head)) {
      var1.head delete();
    }

    var1 delete();
    var1 = undefined;
    return;
  }
}

function spawnheliactorsfunc(var0) {
  level endon("game_ended");
  self endon("death");
  objective_icon_show(var0.convoy, 1);
  var1 = var0.convoy.settings.toggle_vo_on_hvt_rescued;
  self unlink();
  wait 0.5;
  self.origin = getclosestpointonnavmesh(self.origin) + (0, 0, 10);
  var2 = scripts\cp\cp_pickup_hostage::get_hostage_drop_pos(self);
  var2 = scripts\cp\cp_pickup_hostage::_getphysicspointaboutnavmesh(var2) + (0, 0, 2);
  self.origin = var2;
  self.angles = (0, self.angles[1], 0);
  wait 5;

  if(istrue(var1)) {
    thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/CONVOY_4");
    level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_convoy_success_exfil_10", "allies");
    return;
  }
}

function waittill_hvt_at_vehicle(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  level endon("game_ended");
  var1 endon("event_convoy_delete");
  var1 endon("event_convoy_exit");
  self endon("death");
  var0 endon("death");
  var1.main_truck endon("new_main_convoy_chosen");
  var1.main_truck = self;
  var2 = 96;
  var3 = var2 * var2;

  for(;;) {
    wait 0.5;

    if(!isDefined(var1.convoy_board_pos)) {
      continue;
    }

    var4 = distance2dsquared(var1.convoy_board_pos, var0.origin);

    if(var4 > var3) {
      continue;
    }

    if(!istrue(var0.pickedup)) {
      continue;
    }

    if(istrue(var0.carried_by_vehicle)) {
      continue;
    }

    if(istrue(var0.carried) || isDefined(var0.carrier) && isPlayer(var0.carrier)) {
      continue;
    }

    break;
  }

  GscBinSkip4(0x35, var0, var1, 1);
}

function attach_hvt_to_vehicle(var0, var1, var2) {
  var0 unlink();
  var0.pickedup = 0;
  var0.pickup_disabled = 0;

  if(isDefined(var0.carrier)) {
    var0.carrier.tugofwar_anim = "htf_pop_020_trafficking_enemy_04_load_cp";
    var0.carrier notify("tugofwar_playanim");
  }

  var3 = (0, 0, 130);

  if(self.type == "techo") {
    var3 = (0, 0, 86);
  }

  var4 = "tag_origin";

  if(isagent(var0)) {
    var4 = "tag_windshield_back";
  }

  if(istrue(var1.no_tarp)) {
    var4 = "tag_accessory_01";
    var3 = (-96, 0, -13);
  }

  var0 linkTo(self, var4, var3, (0, 180, 0));
  var0 setuseholdduration("duration_medium");

  if(isDefined(var0.interaction_handle)) {
    var0.interaction_handle makeusable();
  }

  if(!isagent(var0)) {
    var0 makeusable();
  }

  self.has_hvt = 1;
  var0.convoy_pickedup = 1;
  var0.carried_by_vehicle = 1;
  var1.has_hvt = 1;

  if(isDefined(var0.idleanim)) {
    var0.body scriptmodelplayanim(var0.idleanim);

    if(isDefined(var0.head)) {
      var0.head scriptmodelplayanim(var0.idleanim);
    }
  }

  if(isDefined(var0.carrier)) {
    if(istrue(var0.dontkilloff)) {
      var0.dontkilloff = 0;
    }

    thread hvt_ent_delete_wm(var0.carrier);
  }

  if(istrue(self.convoy.settings.pickup_uses_origin)) {
    var0 setCanDamage(0);
    var0.ignoreme = 1;
    var0.scripted_mode = 1;
    var0.ignoreall = 1;
  }

  objective_icon_show(self.convoy, 1);

  if(isagent(var0)) {
    if(isDefined(var0.head)) {
      var0.head setModel(var0.head.oldhead);
    }

    var0 setModel(var0.bodymodel);
    var0 scripts\cp\cp_vip::enable_outline();

    if(isDefined(var0.objnum)) {
      objective_setzoffset(var0.objnum, 75);
    }
  } else {
    var0 show();

    if(isDefined(var0.body)) {
      var0.body show();
    }

    if(isDefined(var0.head)) {
      var0.head show();
    }

    if(isDefined(var0.waypoint)) {
      if(isDefined(var0.sethotfunc)) {
        var0 thread[[var0.sethotfunc]](1);
      }
    }

    thread spawnintermission_nocam(level, var0);
  }

  if(istrue(var2)) {
    convoy_force_exit();
    return;
  }
}

function convoy_force_exit() {
  self.convoy.exiting = 1;
  self.convoy notify("event_convoy_exit");
}

function spawnintermission_nocam(var0, var1) {
  level endon("game_ended");
  var0 endon("death");
  var0 waittill("player_picked_up_hostage");

  if(isDefined(var0.waypoint)) {
    if(isDefined(var0.sethotfunc)) {
      var0 thread[[var0.sethotfunc]](0);
    }

    var0 notify("freedobjective");
    scripts\cp\cp_objectives::freeworldid("pickup_hostage");
    objective_delete(var0.waypoint);
    var0.waypoint = undefined;
  }

  if(isDefined(var1)) {
    var1 notify("convoy_compromised_early");

    foreach(var3 in var1.spawned_vehicles) {
      if(isent(var3) && istrue(var3.has_hvt)) {
        var3.has_hvt = undefined;
      }
    }
  }

  if(check_backup_is_set(var1)) {
    thread route_soldiers_towards_backup_location(level);
    return;
  }
}

function waittill_return_to_truck(var0, var1) {
  level endon("game_ended");
  var1 endon("event_convoy_delete");
  var1 waittill("event_convoy_exit");
  var0 = var1.using_path;
  GscBinSkip4(0x6e, level, var0, var1);
}

function send_out_convoy_towards_exit(var0, var1) {
  level endon("game_ended");
  var1 endon("event_convoy_delete");
  var1 endon("convoy_compromised");
  var2 = 16;
  var3 = getdvarint("scr_event_convoy_exitspeed", 0);

  if(var3 > 0) {
    var2 = var3;
  }

  if(var2 > 400) {
    var2 = 400;
  }

  wait 9;
  var1 notify("convoy_exiting_after_pickup");
  level notify("convoy_exiting_after_pickup", var1);
  var1.allowed_to_exit = 1;
}

function slow_down_if_leader() {
  if(isDefined(self.type) && self.type != "mkilo") {
    return;
  }

  var0 = undefined;
  var1 = 1.5;
  var2 = 2000;

  for(;;) {
    if(isDefined(self.leading_veh)) {
      var0 = self.veh_speed;
      self.speed_override = 5;
      var3 = self.leading_veh / var2 * var1;
      wait var3;
      self.speed_override = var0;
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

  var0 = 2500;
  var1 = var0 * var0;

  while(isalive(self)) {
    wait 0.5;

    if(!isDefined(level.vehicle_travel_array)) {
      continue;
    }

    var2 = scripts\engine\utility::getclosest(self.origin, level.vehicle_travel_array, var0);

    if(!isDefined(var2)) {
      self.convoy.main_truck.following_player = undefined;

      if(isalive(self) && self vehicle_isphysveh() && isDefined(self.current_path) && !istrue(self.disable_set_speed)) {
        set_convoy_vehicle_speed(self.current_path.speed, 30, 30);
      }

      continue;
    }

    self.convoy.main_truck.following_player = 1;
    var3 = var2 vehicle_getspeed();

    if(var3 > 15) {
      if(var3 > 45) {
        var4 = 45;
      } else {
        var4 = var6 + 5;
      }

      foreach(var4 in self.convoy.spawned_vehicles) {
        if(isalive(var4)) {
          set_convoy_vehicle_speed(var4, var4, 30, 30);
        }
      }

      continue;
    }

    foreach(var4 in self.convoy.spawned_vehicles) {
      if(isalive(var4)) {
        set_convoy_vehicle_speed(var4, 15, 30, 30);
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

function get_vehicle_adjust_speed(var0, var1) {
  var2 = 5000;

  if(var1 > var2) {
    var1 = var2;
  }

  var3 = var1 / var2;
  var4 = scripts\engine\math::lerp(var0, 15, var3);
  return var4;
}

function set_convoy_vehicle_speed(var0, var1, var2) {
  self vehicle_setspeedimmediate(var0, var1, var2);
}

function calc_length_of_full_veh_path(var0) {
  if(!isDefined(var0.pathing_array)) {
    return 0;
  }

  if(var0.pathing_array.size <= 1) {
    return 0;
  }

  if(!isDefined(var0.current_path)) {
    return 0;
  }

  var1 = undefined;
  var2 = undefined;

  for(var3 = var0.pathing_array.size - 1; var3 > 0; var3--) {
    if(var0.pathing_array[var3].origin == var0.current_path.origin) {
      var1 = var0.pathing_array[var3];
      var2 = var3;
      break;
    }
  }

  if(!isDefined(var1)) {
    return 0;
  }

  var4 = 0;

  for(var5 = var2; var5 < var0.pathing_array.size - 1; var5++) {
    var4 += distance2d(var0.pathing_array[var5].origin, var0.pathing_array[var5 + 1].origin);
  }

  var0.dist_from_node_to_end = var4;
  return var4;
}

function comparevehdisttoends(var0, var1) {
  if(var0.dist_from_node_to_end == var1.dist_from_node_to_end) {
    return (var0.dist_from_node_to_end < var1.dist_from_node_to_end);
  }

  return var0.dist_from_node_to_end < var1.dist_from_node_to_end;
}

function objective_icon_show(var0, var1) {
  if(!isDefined(self.convoy_objectivestruct)) {
    return;
  }

  if(!istrue(var0)) {
    if(isDefined(self.convoy_objectivestruct.objectiveindex)) {
      objective_addteamtomask(self.convoy_objectivestruct.objectiveindex, "spectator");
      return;
    }

    return;
  }

  if(isDefined(self.convoy_objectivestruct.objectiveindex)) {
    objective_addalltomask(self.convoy_objectivestruct.objectiveindex);

    if(isDefined(var1)) {
      objective_sethot(self.convoy_objectivestruct.objectiveindex, var1);
      return;
    }

    return;
  }
}

function objective_icon_override(var0) {
  if(isDefined(var0)) {
    self.convoy_objectivestruct = var0;
    return;
  }
}

function objective_icon_attach_to_center_vehicle(var0, var1, var2) {
  if(!isDefined(self.convoy_objectivestruct)) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  var3 = undefined;

  if(isalive(self.main_truck)) {
    var3 = self.main_truck;
  } else {
    for(var4 = 0; var4 < self.spawned_vehicles.size; var4++) {
      if(isalive(self.spawned_vehicles[var4])) {
        var3 = self.spawned_vehicles[var4];
        break;
      }
    }
  }

  if(!isDefined(var3)) {
    return;
  }

  if(istrue(var0)) {
    objective_setplayintro(self.convoy_objectivestruct.objectiveindex, 1);
    objective_setplayoutro(self.convoy_objectivestruct.objectiveindex, 1);
    objective_onentity(self.convoy_objectivestruct.objectiveindex, var3);
    objective_setzoffset(self.convoy_objectivestruct.objectiveindex, var1);
    return;
  }
}

function objective_icon_show_health(var0) {
  if(!isDefined(self.convoy_objectivestruct)) {
    return;
  }

  var1 = undefined;

  if(isalive(self.main_truck)) {
    var1 = self.main_truck;
  } else {
    for(var2 = 0; var2 < self.spawned_vehicles.size; var2++) {
      if(isalive(self.spawned_vehicles[var2])) {
        var1 = self.spawned_vehicles[var2];
        break;
      }
    }
  }

  if(!isDefined(var1)) {
    return;
  }

  if(istrue(var0)) {
    objective_sethot(self.convoy_objectivestruct.objectiveindex, 1);
    thread hold_health_on_objectiveicon(var1);
    return;
  }

  self notify("stop_showing_health");
  objective_sethot(self.convoy_objectivestruct.objectiveindex, 0);
  var1 scripts\cp\utility::vehicle_freehealthbarui();
}

function objective_icon_show_label(var0) {
  if(!isDefined(self.convoy_objectivestruct)) {
    return;
  }

  if(!isDefined(var0)) {
    return;
  }

  if(var0 != &"") {
    objective_setlabel(self.convoy_objectivestruct.objectiveindex, var0);
    return;
  }

  objective_setlabel(self.convoy_objectivestruct.objectiveindex, "");
}

function hold_health_on_objectiveicon(var0) {
  level endon("game_ended");
  var0 endon("death");
  self endon("stop_showing_health");
  var1 = var0.health - var0.healthbuffer;

  if(var1 < var0.health) {
    var1 = var0.health - var0.healthbuffer;
  }

  var2 = spawn("script_model", var0.origin);
  var2 linkTo(var0, "tag_origin", (0, 0, 190), (0, 0, 0));
  var3 = scripts\cp\utility::vehicle_gethealthbarid();

  if(!isDefined(var3)) {
    return;
  }

  var0.healthbarid = var3;
  var4 = scripts\engine\utility::ter_op(isDefined(var0.script_team) && var0.script_team != "axis", 2, 1);

  if(!isDefined(level.healthbars)) {
    level.healthbars = [];
  }

  level.healthbars[var0.healthbarid] = var2;
  setomnvar("ui_ingame_light_tank_ent_" + var0.healthbarid, var2);
  setomnvar("ui_ingame_light_tank_team_" + var0.healthbarid, var4);
  setomnvar("ui_ingame_light_tank_health_" + var0.healthbarid, 1);

  for(;;) {
    var5 = var0.health - var0.healthbuffer;
    setomnvar("ui_ingame_light_tank_health_" + var0.healthbarid, var5 / var1);
    wait 0.2;
  }
}