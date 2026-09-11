/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_vehicles.gsc
***********************************************/

function coopvehicles_init() {
  if(isDefined(level.vehicles_init)) {
    [[level.vehicles_init]]();
  }

  if(!isDefined(level.unloading_func)) {
    level.unloading_func = [];
  }

  if(!isDefined(level.unloaded_func)) {
    level.unloaded_func = [];
  }

  if(!isDefined(level.vehicle_builds)) {
    level.vehicle_builds = [];
  }

  setDvar("scr_struct_spline_path", 1);
  thread init_vehicle_spawning();
  scripts\engine\utility::create_func_ref("vehicle_damage_modifier", &incrementobjectiveachievementkill);
  level._effect["helidown_rpghit"] = loadfx("vfx/iw8_cp/chopper/vfx_chopper_air_explosion.vfx");
  level._effect["helidown_tailfire"] = loadfx("vfx/iw8_cp/chopper/vfx_cp_fire_fire_trail.vfx");
  level._effect["helidown_groundexp"] = loadfx("vfx/iw8_cp/chopper/vfx_cp_chopper_ground_exp.vfx");
}

function ref_13f29() {
  if(isDefined(level.vehicle)) {
    if(isDefined(level.vehicle.templates)) {
      if(isDefined(level.vehicle.templates.bullet_shield)) {
        var_0 = getarraykeys(level.vehicle.templates.bullet_shield);

        for(var_1 = 0; var_1 < var_0.size; var_1++) {
          level.vehicle.templates.bullet_shield[var_0[var_1]] = 0;
        }

        return;
      }

      return;
    }

    return;
  }
}

function init_infectgroundwarvehicles() {
  if(isDefined(level.vehicle)) {
    if(isDefined(level.vehicle.templates)) {
      if(isDefined(level.vehicle.templates.unloadgroups)) {
        var_0 = getarraykeys(level.vehicle.templates.unloadgroups);

        for(var_1 = 0; var_1 < var_0.size; var_1++) {
          var_2 = var_0[var_1];
          var_3 = level.vehicle.templates.aianims[var_0[var_1]].size;

          if(!isDefined(level.vehicle.templates.unloadgroups[var_2])) {
            level.vehicle.templates.unloadgroups[var_2] = [];
          }

          if(isDefined(level.vehicle.templates.unloadgroups[var_2]["passengers"])) {
            continue;
          }

          if(var_3 > 1) {
            for(var_4 = 1; var_4 < var_3; var_4++) {
              if(isDefined(level.vehicle.templates.aianims[var_2][var_4])) {
                var_5 = level.vehicle.templates.aianims[var_2][var_4];

                if(isDefined(var_5.getout)) {
                  if(!isDefined(level.vehicle.templates.unloadgroups[var_2]["passengers"])) {
                    level.vehicle.templates.unloadgroups[var_2]["passengers"] = [];
                  }

                  level.vehicle.templates.unloadgroups[var_2]["passengers"][level.vehicle.templates.unloadgroups[var_2]["passengers"].size] = var_4;
                }
              }
            }
          }
        }

        return;
      }

      return;
    }

    return;
  }
}

function ref_1311c() {
  if(isDefined(level.vehicle)) {
    if(isDefined(level.vehicle.templates)) {
      if(isDefined(level.vehicle.templates.team)) {
        var_0 = getarraykeys(level.vehicle.templates.team);

        for(var_1 = 0; var_1 < var_0.size; var_1++) {
          level.vehicle.templates.team[var_0[var_1]] = "axis";
        }

        return;
      }

      return;
    }

    return;
  }
}

function ref_1311b(var_0, var_1) {
  level.vehicle.templates.bullet_shield[var_1] = var_0;
}

function registervehicleinteractions() {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("interactions_init_started")) {
    scripts\engine\utility::flag_wait("interactions_init_started");
  }

  level.interaction_hintstrings["drive_vehicle"] = &"CP_VEHICLES/ENTER_VEHICLE";
  level.interaction_hintstrings["tank_use"] = &"KILLSTREAKS_HINTS/BRADLEY_DRIVER_ENTER";
  scripts\cp\cp_interaction::registerinteraction("drive_vehicle", &vehiclehint, &usevehicle);
  scripts\cp\cp_interaction::registerinteraction("tank_use", &vehiclehint, &usevehicle);
}

function vehiclehint(var_0, var_1) {
  if(getdvarint("scr_allow_drivable_vehicles", 0) == 1) {
    return &"CP_VEHICLES/ENTER_VEHICLE";
  }

  return "";
}

function usevehicle(var_0, var_1) {
  if(getdvarint("scr_allow_drivable_vehicles", 0) == 1) {
    var_2 = var_0.vehicle;
    var_2.ownerid = var_1 getentitynumber();
    var_2.originalowner = var_1;
    var_2.driver = var_1;
    var_1.vehicle = var_2;
    var_2 setCanDamage(0);
    var_1 setplayerangles(var_2.angles);
    var_1.vehicle setotherent(var_1);
    var_1 controlslinkTo(var_2);
    var_1 playerlinktodelta(var_2, "tag_driver");
    var_1.vehicle setentityowner(var_1);
    var_1 playerhide();

    foreach(var_0 in var_2.interactions) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    }

    thread watchforplayerexit(var_2, var_1);
    thread vehiclewatchforflip(var_2, var_1);
    return;
  }
}

function watchforplayerexit(var_0, var_1) {
  var_1 endon("game_ended");
  var_1 notifyonplayercommand("exit_vehicle", "+usereload");
  var_1 waittill("exit_vehicle");
  exitvehicle(var_0, var_1);
}

function exitvehicle(var_0, var_1, var_2) {
  var_1 unlink(1);
  var_1 controlsunlink();
  var_1.vehicle setotherent(undefined);
  var_1.vehicle setentityowner(undefined);
  var_1.vehicle = undefined;
  var_1 setOrigin(scripts\engine\utility::random(var_0.interactions).origin);

  if(istrue(var_2)) {
    var_0 delete();
  } else {
    foreach(var_4 in var_0.interactions) {
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_4);
    }
  }

  waitframe();
  var_1 playershow();
}

function vehiclewatchforflip(var_0, var_1) {
  var_0 endon("death");
  var_2 = 0;

  for(;;) {
    if(var_2 >= 4) {
      break;
    }

    var_3 = vectordot(anglestoup(var_0.angles), (0, 0, 1));

    if(var_3 < 0.707) {
      var_2 += 0.05;
    } else {
      var_2 = 0;
    }

    waitframe();
  }

  exitvehicle(var_0, var_1, 1);
}

function updateinteractionstructpositions(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_1 = spawnStruct();
  var_2 = spawnStruct();
  var_3 = spawnStruct();
  var_4 = spawnStruct();
  createvehicleinteraction(var_1, var_0);
  createvehicleinteraction(var_2, var_0);
  createvehicleinteraction(var_3, var_0);
  createvehicleinteraction(var_4, var_0);

  for(;;) {
    var_5 = anglesToForward(var_0.angles);
    var_6 = -1 * var_5;
    var_7 = anglestoleft(var_0.angles);
    var_8 = anglestoright(var_0.angles);
    var_5 *= 145;
    var_6 *= 145;
    var_7 *= 90;
    var_8 *= 90;
    var_9 = var_0.origin + var_5;
    var_10 = var_0.origin + var_6;
    var_11 = var_0.origin + var_7;
    var_12 = var_0.origin + var_8;
    var_1.origin = var_9 + (0, 0, 12);
    var_2.origin = var_10 + (0, 0, 12);
    var_3.origin = var_11 + (0, 0, 12);
    var_4.origin = var_12 + (0, 0, 12);
    wait 0.25;
  }
}

function _spawnVehicle(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnVehicle(var_0, var_1, var_2, var_3, var_4);
  var_7.interactions = [];
  thread updateinteractionstructpositions(var_7);
  return var_7;
}

function createvehicleinteraction(var_0, var_1) {
  var_0.script_noteworthy = "drive_vehicle";
  var_0.requires_power = 0;
  var_0.powered_on = 1;
  var_0.script_parameters = "default";
  var_0.cost = 0;
  var_0.spend_type = "null";
  var_0.targetname = "interaction";
  var_0.vehicle = var_1;
  var_1.interactions[var_1.interactions.size] = var_0;
  scripts\cp\utility::addtostructarray("targetname", "interaction", var_0);
  scripts\cp\utility::addtostructarray("script_noteworthy", "tank_use", var_0);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

function create_simple_vehicle_path_from_struct(var_0) {
  self.pathing_array = [];
  self.pathing_array[self.pathing_array.size] = var_0;
  var_0.pathing_index = self.pathing_array.size;
  var_1 = var_0;

  while(isDefined(var_1.target)) {
    var_2 = scripts\engine\utility::getStructArray(var_1.target, "targetname");

    if(var_2.size < 1) {
      break;
    }

    if(var_2.size > 1) {
      var_3 = 1;
      var_4 = var_2;
      var_2 = [];

      for(var_5 = 0; var_5 < var_4.size; var_5++) {
        if(var_4[var_5] == var_1) {
          var_3 = 0;
          continue;
        }

        var_2 = var_4[var_5];
      }
    }

    var_1 = var_2[0];
    var_1.pathing_index = self.pathing_array.size;
    self.pathing_array[self.pathing_array.size] = var_1;
  }
}

function vehiclefollowpathgeneric(var_0, var_1) {
  if(istrue(var_1)) {
    create_simple_vehicle_path_from_struct(var_0);
  }

  if(isstruct(var_0)) {
    thread vehiclefollowstructpath(var_0);
    return;
  }

  thread vehiclefollowpath(var_0);
}

function getvehiclepath(var_0) {
  var_1 = getvehiclenode(var_0, "targetname");

  if(!isDefined(var_1)) {
    var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  }

  return var_1;
}

function vehiclefollowstructpathsplines(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_follow_path");
  self endon("reset_path");
  level endon("game_ended");

  if(var_1.size == 0) {
    return;
  }

  jumpiftrue(isDefined(var_0)) LOC_0000002f;
  return;
}

function ref_141fd(var_0) {
  if(istrue(var_0.ref_119e3)) {
    return false;
  }

  if(isDefined(var_0.pathing_arrays)) {
    if(istrue(var_0.on_last_pathing_array)) {
      return true;
    } else {
      return false;
    }
  }

  return true;
}

function create_extra_structpath(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = (var_1 - self.origin) / 2;
  }

  var_3 = var_1;
  var_4 = var_2;
  var_5 = (var_4 + var_3) / 2;
  var_6 = var_5 - var_4;
  var_7 = spawnStruct();
  var_7.origin = var_3 + var_6;
  return var_7;
}

function vehiclefollowstructpath(var_0, var_1) {
  self endon("death");
  self endon("stop_follow_path");
  self endon("reset_path");
  level endon("game_ended");
  self.on_last_pathing_array = undefined;
  var_2 = undefined;

  if(isDefined(self.pathing_arrays) && self.pathing_arrays.size > 0) {
    for(var_3 = 0; var_3 < self.pathing_arrays.size; var_3++) {
      if(!isDefined(self.pathing_arrays) || self.pathing_arrays.size == 0) {
        return;
      }

      if(var_3 == self.pathing_arrays.size - 1) {
        self.on_last_pathing_array = 1;
      }

      vehiclefollowstructpathsplines(var_0, self.pathing_arrays[var_3], var_1);
    }

    return;
  }

  if(isDefined(self.pathing_array) && self.pathing_array.size > 0) {
    self.on_last_pathing_array = 1;
    vehiclefollowstructpathsplines(var_0, self.pathing_array, var_1);
    return;
  }
}

function finish_spline_path() {
  if(isDefined(self.convoy)) {
    if(!isDefined(self.convoy.settings) || istrue(self.convoy.settings.unload_at_target)) {
      if(isDefined(level.vehicle_all_stop_func)) {
        self[[level.vehicle_all_stop_func]](0);
      }

      self notify("unload_guys");
    }

    if(isDefined(self.convoy.settings) && isDefined(self.convoy.settings.target)) {
      self notify("unload_guys");
    }
  }

  self stoppath(1);
  self notify("stop_follow_path");
}

function killstreak_update_hint_logic() {
  self endon("death");

  if(!self issuspendedvehicle()) {
    self suspendvehicle();
    return;
  }
}

function ent_facing_away_from_mypos(var_0) {
  var_1 = var_0.angles;
  var_2 = vectordot(var_1, vectorNormalize(var_0.origin - self.origin));
  return var_2 > 0;
}

function drop_to_ground_ignore_vehicle(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = 1500;
  }

  if(!isDefined(var_2)) {
    var_2 = -12000;
  }

  var_4 = scripts\engine\trace::create_world_contents();

  if(isDefined(var_3)) {
    return scripts\engine\trace::ray_trace(var_0 + var_1 * var_3, var_0 + var_2 * var_3, undefined, var_4)["position"];
  }

  return scripts\engine\trace::ray_trace(var_0 + (0, 0, var_1), var_0 + (0, 0, var_2), undefined, var_4)["position"];
}

function anglebetweenvectorsrounded(var_0, var_1) {
  return acos(clamp(vectordot(var_0, var_1) / length(var_0) * length(var_1), -1, 1));
}

function vehiclefollowpath(var_0) {
  self endon("death");
  self endon("stop_follow_path");
  self endon("reset_path");
  self startpath(var_0);

  for(var_1 = getvehiclenode(var_0.target, "targetname"); isDefined(var_1); var_1 = getvehiclenode(var_1.target, "targetname")) {
    var_1 waittill("trigger");

    if(isDefined(var_1.script_unload)) {
      self vehicle_setspeedimmediate(0, 30, 30);

      for(var_2 = self vehicle_getspeed(); var_2 > 1; var_2 = self vehicle_getspeed()) {
        wait 0.1;
      }

      self notify("unload_guys");

      while(self.riders.size > 0) {
        wait 0.1;
      }

      if(isDefined(var_1.target)) {
        self resumespeed(10);
      }
    }

    if(isDefined(var_1.script_pathtype) && var_1.script_pathtype == "unload") {
      self vehicle_setspeedimmediate(0, 300, 300);
      self stoppath(1);
      self notify("unload_guys");
      self notify("stop_follow_path");
      return;
    }

    if(!isDefined(var_1.target)) {
      break;
    }
  }

  self vehicle_setspeedimmediate(0, 30, 30);

  for(var_2 = self vehicle_getspeed(); var_2 > 1; var_2 = self vehicle_getspeed()) {
    wait 0.1;
  }

  self notify("unload_guys");
}

function spawn_ai_in_truck(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_0 scripts\engine\utility::ent_flag_wait("driver_spawned");
  var_0.riders = [];
  var_0.spawned_guys = [];
  var_9 = [];

  if(!isDefined(var_2) && isDefined(level.all_spawn_locations)) {
    var_2 = scripts\engine\utility::random(level.all_spawn_locations);
  }

  var_10 = "convoy_soldiers";
  var_11 = level.ambientgroups[var_10];

  if(!isDefined(var_11)) {
    var_12 = &scripts\cp\cp_modular_spawning::registerambientgroup;
    [[var_12]]("convoy_soldiers", 0, 10, 250, 20, 0, "convoy_soldiers", undefined, undefined, undefined);
    waitframe();
    var_11 = level.ambientgroups[var_10];
  }

  if(!var_11 scripts\engine\utility::ent_flag_exist("weapons_free")) {
    var_11 scripts\engine\utility::ent_flag_init("weapons_free");
  }

  if(!isDefined(level.spawn_module_structs_memory[var_10])) {
    level.spawn_module_structs_memory[var_10] = [];
    level.active_spawn_module_structs[var_10][0] = var_11;
    level.spawn_module_structs_memory[var_10][0] = var_11;
  }

  var_13 = 0;

  while(var_13 < var_1) {
    if(isDefined(level.soldierspawnfunc)) {
      var_14 = [[level.soldierspawnfunc]](var_4, var_2, undefined, 1);
    } else {
      var_14 = var_0 scripts\cp\cp_modular_spawning::spawn_ai(undefined, undefined, var_5, var_11);
    }

    if(isDefined(var_14)) {
      if(isDefined(var_11.cargo_truck_mg_init)) {
        if(isDefined(level.players[var_11.cargo_truck_mg_init])) {
          level.players[var_11.cargo_truck_mg_init].cargo_truck_mg_gunnerdamagemodignorefunc++;
          var_14.cargo_truck_mg_initdamage = level.players[var_11.cargo_truck_mg_init];
        }
      }

      var_11 scripts\cp\cp_modular_spawning::change_module_status(undefined, "Found Agent");
      level notify("spawned_group_soldier", var_14);
      thread scripts\cp\cp_modular_spawning::run_ai_post_spawn_init(var_11, var_14, var_0, undefined, undefined, undefined, undefined);
      var_14.group = var_11;

      if(istrue(var_0.ref_13898)) {
        var_14.sightmaxdistance = 2200;
        var_14.ignoreall = 1;
      }

      var_14.trial_target_think_func = 1;
      var_14.dontkilloff = 1;

      if(isDefined(level.reserved_spawn_slots["truck_ai"])) {
        scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "truck_ai");
      }

      if(isDefined(var_8)) {
        var_14 thread[[var_8]]();
      }

      if(istrue(var_7)) {
        var_15 = var_13 + 2;

        if(isDefined(var_6)) {
          var_15 = var_6;
        }

        var_16 = (0, 0, 0);

        if(!isvector(var_6)) {
          var_17 = level.vehicle.templates.aianims[var_0.classname_mp][var_15];
          var_18 = var_17.sittag;
        } else {
          var_18 = "tag_origin";
          var_18 = var_7;
          var_18 = rotatevector(var_18, var_1.angles);
        }

        var_15.origin = var_1 gettagorigin(var_18) + (0, 0, -18) + var_18;
        var_15.linkedent = scripts\engine\utility::spawn_tag_origin(var_15.origin);
        var_15.linkedent linkTo(var_1, var_18);
        var_15 linkTo(var_15.linkedent, "tag_origin");
        var_15 thread scripts\engine\utility::delete_on_death(var_15.linkedent);
        wait 0.05;
        var_15 playerlinkedoffsetenable();
      }

      var_15.dontkilloff = 1;
      var_1.spawned_guys[var_1.spawned_guys.size] = var_15;
      var_10 = var_15;
    }

    wait 0.05;
    var_14++;
  }

  if(!istrue(var_8)) {
    foreach(var_20 in var_10) {
      if(isDefined(var_7) && isint(var_7)) {
        var_20.forced_startingposition = var_7;
      }

      var_1 thread scripts\common\vehicle_aianim::guy_enter(var_20);
    }
  }

  thread make_guys_leave_truck(level);
  return var_10;
}

function spawn_real_ai_from_drone_pos(var_0) {
  var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_2 = var_0.origin;
  var_3 = var_0.script_noteworthy;
  var_4 = var_0.model;

  while(var_1.size >= level.max_enemy_count) {
    wait 5;
    var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  }

  if(!isDefined(var_0)) {
    var_0 = spawn("script_model", var_2);
    var_0 setModel(var_4);
    var_0.vehicle_position = 3;
    var_0.disable_gun_recall = 1;
    var_0.script_noteworthy = var_3;
  }

  var_5 = undefined;

  while(!isDefined(var_5)) {
    var_5 = scripts\cp\cp_modular_spawning::spawn_ai(var_2, undefined, undefined);

    if(!isDefined(var_5)) {
      wait 3;
    }
  }

  var_5.disable_gun_recall = 1;
  var_5.disable_vehicle_idle = 1;
  var_5.animationarchetype = "soldier";
  var_5.dontkilloff = 1;

  if(isDefined(level.reserved_spawn_slots["truck_drones"])) {
    scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "truck_drones");
  }

  return var_5;
}

function disableunloadanim() {
  return true;
}

function deposit_ai_from_drones_in_vehicle(var_0, var_1) {
  self endon("death");
  var_2 = scripts\engine\utility::ref_143ad("stop_follow_path", "unload_guys");
  wait 0.75;
  thread make_guys_leave_truck(level, self);
}

function create_unload_nodes(var_0, var_1) {
  var_2 = [(-140, 64, 48), (-212, 64, 48), (-140, -64, 48), (-212, -64, 48)];
  var_3 = [];
  var_4 = 0;

  foreach(var_6 in var_2) {
    if(var_4 < var_1) {
      var_7 = spawn("script_origin", var_0.origin + var_6);
      var_3 = scripts\engine\utility::array_add(var_3, var_7);
      var_4++;
      var_7 linkTo(var_0);
      wait 0.1;
    }
  }

  return var_3;
}

function reinforcement_test() {
  level endon("game_ended");
  scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(4, "reinforcement_test");
  wait 5;
}

function spawn_reinforcement_truck(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = scripts\engine\utility::getStruct(var_1, "targetname");
  var_9 = var_8.origin;

  if(!isDefined(var_8.angles)) {
    var_10 = (0, 0, 0);
  } else {
    var_10 = var_9.angles;
  }

  var_11 = _spawnVehicle(var_3, "jeep4x4", "atv_physics_cp", var_10, (0, 0, 0));

  if(isDefined(var_11)) {
    thread vehicle_logic(level, var_11, var_4, var_1, var_6, var_7);
    return var_11;
  }
}

function spawnreinforementtruck(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = scripts\engine\utility::getStruct(var_1, "targetname");
  var_9 = var_8.origin;

  if(!isDefined(var_8.angles)) {
    var_10 = (0, 0, 0);
  } else {
    var_10 = var_9.angles;
  }

  var_11 = _spawnVehicle(var_3, "jeep4x4", "atv_physics_cp", var_10, (0, 0, 0));

  if(isDefined(var_11)) {
    var_11.num_guys = var_1;
    var_11.targetname_string = var_2;
    var_11.model_name = var_3;
    var_11.start_node_name = var_4;
    var_11.damagable = var_5;
    var_11.spawnpoints = var_9;
    var_11.bforcespawn = var_7;
    var_11.group = var_8;
    return var_11;
  }

  return undefined;
}

function vehicle_logic(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_start_node(var_0, var_1);

  if(!isDefined(var_6)) {
    var_0 delete();
    return;
  }

  var_0.unload_nodes = create_unload_nodes(var_0, var_2);
  wait 0.1;
  var_0.origin = var_6.origin;
  var_0.angles = var_6.angles;
  spawn_ai_in_truck(var_0, var_2, var_3, var_4, var_5);
  vehiclefollowpath(var_0, var_6);
}

function get_start_node(var_0) {
  var_1 = undefined;

  if(isDefined(var_0)) {
    var_1 = getvehiclenode(var_0, "targetname");
  } else {
    var_2 = getallvehiclenodes();
    var_3 = scripts\engine\utility::getclosest(self.origin, var_2, 500);

    if(!isDefined(var_3)) {
      return undefined;
    } else {
      var_1 = var_3;
    }
  }

  return var_1;
}

function spawn_guys_on_truck(var_0) {}

function make_guys_leave_truck(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disable_leave_truck");

  if(!istrue(var_1)) {
    var_0 waittill("unload_guys");
    var_0 vehicle_setspeed(0, 90, 90);
    wait 1;
    var_0 vehicle_setspeedimmediate(0, 30, 30);
  }

  if(istrue(var_0.disable_leave_truck)) {
    return;
  }

  var_2 = "convoy_soldiers";
  var_3 = level.ambientgroups[var_2];

  if(!isDefined(var_3)) {
    var_4 = &scripts\cp\cp_modular_spawning::registerambientgroup;
    [[var_4]]("convoy_soldiers", 0, 10, 250, 20, 0, "convoy_soldiers", undefined, undefined, undefined);
    waitframe();
    var_3 = level.ambientgroups[var_2];
  }

  if(!var_3 scripts\engine\utility::ent_flag_exist("weapons_free")) {
    var_3 scripts\engine\utility::ent_flag_init("weapons_free");
  }

  if(!isDefined(level.spawn_module_structs_memory[var_2])) {
    level.spawn_module_structs_memory[var_2] = [];
    level.active_spawn_module_structs[var_2][0] = var_3;
    level.spawn_module_structs_memory[var_2][0] = var_3;
  }

  var_5 = [];

  foreach(var_7 in var_0.attachedguys) {
    if(isent(var_7)) {
      var_7.group = var_3;
      var_7.combat_func_override = "shotgun";

      if(istrue(var_0.ref_13898) && isalive(var_7)) {
        var_7.sightmaxdistance = 2200;
        var_7 thread scripts\cp\coop_stealth::run_common_functions(var_7, 1, 1, 60, 160000);
        var_7.ignoreall = 0;
      }

      if(!isalive(var_7)) {
        var_5 = var_7;
      }
    }
  }

  hudattractionobj(var_0, var_3, var_5);

  if(!istrue(var_1)) {
    while(var_0.riders.size > 0) {
      waitframe();
    }
  } else {
    wait 2;
  }

  var_0 notify("unloaded");
}

function soldier_leave_truck(var_0, var_1) {
  var_2 = spawn("script_origin", var_0.origin);
  var_3 = anglesToForward(var_1.angles) * -1;
  var_4 = 150;
  var_5 = scripts\cp\utility::vec_multiply(var_3, var_4);
  var_6 = getclosestpointonnavmesh(var_0.origin + var_5);
  var_0.scripted_mode = 1;
  var_0.ignoreall = 1;
  var_0 linkTo(var_2);
  var_2 moveTo(var_6 + (0, 0, 5), 0.25);
  var_2 waittill("movedone");
  var_0.scripted_mode = 0;
  var_0.ignoreall = 0;
  var_0 unlink();
  var_1.riders = scripts\engine\utility::array_remove(var_1.riders, var_0);
  var_6 = getclosestpointonnavmesh(var_0.origin);
  var_0 setgoalpos(var_6);

  if(isDefined(var_0.spawnpoint) && isDefined(var_0.spawnpoint.script_goalvolume)) {
    var_0 setgoalvolumeauto(getEnt(var_0.spawnpoint.script_goalvolume, "script_noteworthy"));
  }

  var_0.goalradius = 2048;
  var_2 delete();
}

function incrementobjectiveachievementkill(var_0) {
  var_1 = undefined;

  if(isDefined(var_0)) {
    if(isDefined(var_0.damage)) {
      var_1 = var_0.damage;
    }

    if(isDefined(var_0.attacker) && isPlayer(var_0.attacker) && isDefined(var_1)) {
      if(isDefined(var_0.attacker.team) && isDefined(self.team) && var_0.attacker.team != self.team) {
        if(isDefined(var_0.objweapon) && isDefined(var_0.objweapon.basename)) {
          if(var_0.objweapon.basename == "emp_drone_player_mp") {
            var_1 = 10000;
          }
        }
      }

      if(isDefined(var_0.objweapon) && isDefined(var_0.objweapon.basename)) {
        switch (var_0.objweapon.basename) {
          case "cruise_proj_mp":
          case "toma_proj_mp":
            if(isDefined(self.healthbuffer)) {
              self.health = self.healthbuffer - 100;
            } else {
              self.health = 0;
            }

            break;
          case "molotov_mp":
            if(self.healthbuffer > self.health) {
              if(isDefined(var_0.objweapon) && issubstr(var_0.objweapon.basename, "molotov")) {
                var_0.attacker thread scripts\cp\cp_achievement::scriptable_setups();
              }
            }

            break;
        }

        if(isDefined(var_0.meansofdeath)) {
          var_1 = scripts\cp\cp_damage::handleapdamage(var_0.objweapon, var_0.meansofdeath, var_1, var_0.attacker);
        }
      }

      if(isDefined(self.is_correct_wire_color_sync)) {
        var_1 *= self.is_correct_wire_color_sync;
      }

      if(istrue(var_0.attacker.is_available_for_hack)) {
        var_2 = var_0.attacker.origin[2];
        var_3 = self.origin[2];

        if(var_2 >= var_3) {
          var_4 = int(abs(var_2 - var_3));
          var_5 = int(var_4 / 64);

          if(var_5 > 0) {
            var_1 *= 1 + 0.4 * var_5;
          }
        }
      }

      var_0.attacker scripts\cp\cp_damagefeedback::updatehitmarker("standard", 1, var_1, 0, 0);
      var_6 = self.health - var_1;
      self.health = int(max(var_6, self.healthbuffer - 1));
    }
  }

  return var_1;
}

function delete_on_end() {
  level endon("game_ended");
  self endon("death");
  wait 0.25;
  scripts\engine\utility::ref_143a5("unloaded", "stop_follow_path");
}

function spawnstaticvehicle(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0);
  var_3.angles = var_1;
  var_3 setModel(var_2);
  var_3 solid();
  createnavobstaclebybounds(var_3.origin, (100, 100, 200), var_3.angles);
  var_3 disconnectPaths();
  wait 0.1;
}

function init_vehicle_spawning() {
  level.ai_spawn_vehicle_func = [];
  level.next_index = 0;
  level.all_ai_vehicle_infils = [];
  level.available_ai_vehicle_air_infils = [];
  level.available_ai_vehicle_ground_infils = [];
  level.path_points = [];
  level.invalid_path_points = [];
  level.heli_triggers = [];
  level.ref_14102 = [];
  create_vehicle_builds();
  vehicle_registrations();
  thread init_vehicles_after_flags();
  add_ai_ground_infil("pindia");
  add_ai_ground_infil("technical_ai_plr");
  add_ai_air_infil("attack_heli");
  register_vehicle_spawn("attack_heli", undefined, undefined, undefined, "heli_spawner", undefined, "heli_infil_path", undefined, &spawn_enemy_chopper, "apache");
  register_vehicle_spawn("decho", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "decho");
  register_vehicle_spawn("techo_non_phys", 10, 10, 10, "ai_ground_veh_spawner", "ground_veh_exit", "ground_veh_infil_path", undefined, &veh_ground_veh_spawn, "techo_non_phys");
  register_vehicle_spawn("techo", 10, 10, 10, "ai_ground_veh_spawner", "ground_veh_exit", "ground_veh_infil_path", undefined, &veh_ground_veh_spawn, "techo");
  register_vehicle_spawn("technical_ai_plr", 10, 10, 10, "ai_ground_veh_spawner", "ground_veh_exit", "ground_veh_infil_path", undefined, &veh_ground_veh_spawn, "technical_ai_plr");
  register_vehicle_spawn("veh8_mil_lnd_mkilo23", 1, 2, 30, "ai_ground_veh_spawner", "ground_veh_exit", "ground_veh_infil_path", undefined, &veh_ground_veh_spawn, "veh8_mil_lnd_mkilo23");
  register_vehicle_spawn("veh8_mil_lnd_mkilo23_rus", 1, 2, 30, "ai_ground_veh_spawner", "ground_veh_exit", "ground_veh_infil_path", undefined, &veh_ground_veh_spawn, "veh8_mil_lnd_mkilo23_rus");
  register_vehicle_spawn("mkilo23_physics", 4, 10, 10, "ai_ground_veh_spawner", "ground_veh_exit", "ground_veh_infil_path", undefined, &veh_ground_veh_spawn, "mkilo23_physics");
  register_vehicle_spawn("vindia_a2", 4, 10, 10, "ai_ground_veh_spawner", "ground_veh_exit", "ground_veh_infil_path", undefined, &veh_ground_veh_spawn, "vindia_a2");
  register_vehicle_spawn("random_ground_vehicle_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, &choose_random_ground_vehicle_spawn);
  register_vehicle_spawn("random_air_vehicle_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, &choose_random_air_vehicle_spawn);
  register_vehicle_spawn("escalation_heli_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, &choose_escalation_air_vehicle_spawn);
  register_vehicle_spawn_drivers("blima_ground", 2, scripts\engine\utility::random(["aq_pilot_fullbody_1", "aq_pilot_fullbody_2"]));
  register_vehicle_spawn_drivers("techo", 2, scripts\engine\utility::random(["aq_pilot_fullbody_1", "aq_pilot_fullbody_2"]));
  register_vehicle_spawn_drivers("veh8_mil_lnd_mkilo23", 2, scripts\engine\utility::random(["aq_pilot_fullbody_1", "aq_pilot_fullbody_2"]));
  register_vehicle_spawn_drivers("veh8_mil_lnd_mkilo23_rus", 2, scripts\engine\utility::random(["aq_pilot_fullbody_1", "aq_pilot_fullbody_2"]));
  register_vehicle_spawn_drivers("mkilo23_physics", 2, scripts\engine\utility::random(["aq_pilot_fullbody_1", "aq_pilot_fullbody_2"]));
  register_vehicle_spawn_drivers("decho", 2, scripts\engine\utility::random(["aq_pilot_fullbody_1", "aq_pilot_fullbody_2"]));
}

function register_unloading_func(var_0, var_1) {
  if(!isDefined(level.unloading_func)) {
    level.unloading_func = [];
  }

  var_2 = spawnStruct();
  var_2.spawn_type = var_1;
  level.unloading_func[var_0] = var_1;
}

function register_unloaded_func(var_0, var_1) {
  if(!isDefined(level.unloading_func)) {
    level.unloaded_func = [];
  }

  var_2 = spawnStruct();
  var_2.spawn_type = var_1;
  level.unloaded_func[var_0] = var_1;
}

#using_animtree("");

function deploy_fast_rope() {
  var_0 = self gettagorigin("origin_animate_jnt");
  var_1 = self gettagangles("origin_animate_jnt");
  var_2 = "equipment_fast_rope_wm_01_infil_heli_l";
  var_3 = % equipment_fast_rope_wm_01_infil_heli_l;
  var_4 = getstartorigin(var_0, var_1, var_3);
  var_5 = getstartangles(var_0, var_1, var_3);
  var_6 = spawn("script_model", var_4);
  var_6.angles = var_5;
  thread scripts\engine\utility::delete_on_death(var_6);
  var_6 setModel("equipment_fast_rope_wm_01_infil_heli_l");
  var_6 linkTo(self);
  var_6 scriptmodelplayanimdeltamotionfrompos(var_2, var_4, var_5);
  var_0 = self gettagorigin("origin_animate_jnt");
  var_1 = self gettagangles("origin_animate_jnt");
  var_2 = "equipment_fast_rope_wm_01_infil_heli_r";
  var_3 = $equipment_fast_rope_wm_01_infil_heli_r;
  var_4 = getstartorigin(var_0, var_1, var_3);
  var_5 = getstartangles(var_0, var_1, var_3);
  var_7 = spawn("script_model", var_4);
  var_7.angles = var_5;
  thread scripts\engine\utility::delete_on_death(var_7);
  var_7 setModel("equipment_fast_rope_wm_01_infil_heli_l");
  var_7 linkTo(self);
  var_7 scriptmodelplayanimdeltamotionfrompos(var_2, var_4, var_5);
  scripts\engine\utility::waittill_either("death", "unloaded");
  var_6 scriptmodelclearanim();
  var_6 scriptmodelplayanim("equipment_fast_rope_wm_01_infil_heli_l_fall");
  var_7 scriptmodelclearanim();
  var_7 scriptmodelplayanim("equipment_fast_rope_wm_01_infil_heli_r_fall");
  wait 2;
  var_6 delete();
  var_7 delete();
}

function drop_fast_rope() {}

function setup_fast_rope_anims() {
  level.scr_animtree["rope"] = #animtree;
  level.scr_anim["rope"]["equipment_fast_rope_wm_01_infil_heli_l"] = % equipment_fast_rope_wm_01_infil_heli_l;
  level.scr_animname["rope"]["equipment_fast_rope_wm_01_infil_heli_l"] = "equipment_fast_rope_wm_01_infil_heli_l";
  level.scr_model["rope"]["equipment_fast_rope_wm_01_infil_heli_l"] = "equipment_fast_rope_wm_01_infil_heli_l";
  level.tag["rope"]["equipment_fast_rope_wm_01_infil_heli_l"] = "origin_animate_jnt";
  level.scr_anim["rope"]["equipment_fast_rope_wm_01_infil_heli_l_fall"] = % equipment_fast_rope_wm_01_infil_heli_l_fall;
  level.scr_animname["rope"]["equipment_fast_rope_wm_01_infil_heli_l_fall"] = "equipment_fast_rope_wm_01_infil_heli_l_fall";
  level.scr_model["rope"]["equipment_fast_rope_wm_01_infil_heli_l_fall"] = "equipment_fast_rope_wm_01_infil_heli_l";
  level.tag["rope"]["equipment_fast_rope_wm_01_infil_heli_l_fall"] = "origin_animate_jnt";
}

function init_vehicles_after_flags() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  ref_13f29();
  init_infectgroundwarvehicles();
  ref_1311c();
  level.ground_vehicle_structs = scripts\engine\utility::getStructArray("ground_veh_infil_path", "targetname");

  if(isDefined(level.vehicle.helicopter_crash_locations)) {
    level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_combine(level.vehicle.helicopter_crash_locations, scripts\engine\utility::getstructarray_delete("helicopter_crash_location", "targetname"));
    level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_combine(level.vehicle.helicopter_crash_locations, scripts\engine\utility::getStructArray("heli_exit", "targetname"));
    return;
  }

  level.vehicle.helicopter_crash_locations = scripts\engine\utility::getStructArray("heli_exit", "targetname");
}

function vehicle_ai_spawn_funcs() {
  register_spawner_script_function("pindia", &ai_ground_veh_spawn, undefined);
  register_spawner_script_function("techo_non_phys", &ai_ground_veh_spawn, undefined);
  register_spawner_script_function("technical_ai_plr", &ai_ground_veh_spawn, undefined);
  register_spawner_script_function("techo", &ai_ground_veh_spawn, undefined);
  register_spawner_script_function("veh8_mil_lnd_umike", &ai_ground_veh_spawn, undefined);
  register_spawner_script_function("veh8_mil_lnd_mkilo23", &ai_ground_veh_spawn, undefined);
  register_spawner_script_function("veh8_mil_lnd_mkilo23_rus", &ai_ground_veh_spawn, undefined);
  register_spawner_script_function("mkilo23_physics", &ai_ground_veh_spawn, undefined);
  register_spawner_script_function("vindia_a2", &ai_ground_veh_spawn, undefined);
  register_spawner_script_function("decho", &ai_ground_veh_spawn, undefined);
}

function register_spawner_script_function(var_0, var_1, var_2, var_3) {
  if(istrue(var_3)) {
    level waittill(var_0);
  }

  if(isDefined(level.spawner_script_funcs[var_0])) {
    var_4 = level.spawner_script_funcs[var_0];
  } else {
    var_4 = spawnStruct();
  }

  var_4.script_function = var_2;
  var_4.specs = var_3;
  level.spawner_script_funcs[var_1] = var_4;
}

function create_ai_plr_vehicle(var_0, var_1) {
  copy_vehicle_build_to_spawnpoint(var_1, var_0);
  var_2 = scripts\common\vehicle::vehicle_spawn(var_0);
  var_2.cannotbesuspended = 1;

  if(isDefined(var_0.vehiclename)) {
    var_2.vehiclename = var_0.vehiclename;
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(var_2, "axis");
    var_2 makeunusable();
    var_2 setCanDamage(1);
    var_2.maxhealth = 999999;
    var_2.health = var_2.maxhealth;
    var_2 scripts\cp_mp\emp_debuff::set_start_emp_callback(&scripts\cp_mp\vehicles\vehicle::vehicle_empstartcallback);
    var_2 scripts\cp_mp\emp_debuff::set_clear_emp_callback(&scripts\cp_mp\vehicles\vehicle::vehicle_empclearcallback);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_registerinstance(var_2);
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_registerinstance(var_2);
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(var_2);
    scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(var_2, undefined, undefined);
    scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_spawnevent(var_2, undefined);
    var_3 = &scripts\cp_mp\utility\weapon_utility::setlockedoncallback;
    [[var_3]](var_2, &scripts\cp_mp\vehicles\vehicle::vehicle_lockedoncallback);
    var_4 = &scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback;
    [[var_4]](var_2, &scripts\cp_mp\vehicles\vehicle::vehicle_lockedonremovedcallback);
    thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);
  }

  return var_2;
}

function register_vehicle_build(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.model = var_1;
  var_5.vehicletype = var_2;
  var_5.classname_mp = var_3;
  level.vehicle_builds[var_0] = var_5;
}

function ref_12b02(var_0, var_1) {
  if(istrue(var_1)) {
    level waittill(var_0);
  }

  var_2 = level.vehicle_builds[var_0];

  if(isDefined(var_2)) {
    var_2.trial_turret_kill_func = 1;
    var_2.brjugg_initfeatures = 1;
    return;
  }
}

function ref_141b4(var_0) {
  return istrue(level.vehicle_builds[var_0].trial_turret_kill_func);
}

function init_ammo_boxes(var_0, var_1, var_2, var_3) {
  thread ref_12b03(level, var_0, var_1, var_2, var_3, undefined, 1);
  thread ref_12b02(level, var_0);
  thread register_vehicle_spawn_drivers(level, var_0, 1);
  thread ref_12b05(level, var_0, undefined, undefined, undefined, undefined, undefined, undefined, 1, undefined);
}

function ref_12b03(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(istrue(var_6)) {
    level waittill(var_0);
  }

  if(isDefined(level.vehicle)) {
    if(isDefined(level.vehicle.templates)) {
      if(isDefined(level.vehicle.templates.aianims)) {
        if(isDefined(level.vehicle.templates.aianims[var_3])) {
          if(isDefined(level.ai_spawn_vehicle_func[var_0]) && isDefined(level.ai_spawn_vehicle_func[var_0].max_ai)) {
            if(isDefined(var_5)) {
              level.vehicle_builds[var_0].max_ai = var_5;
              return;
            }

            level.vehicle_builds[var_0].max_ai = level.ai_spawn_vehicle_func[var_0].max_ai;
            return;
          }

          if(isDefined(var_5)) {
            level.vehicle_builds[var_0].max_ai = var_5;
            return;
          }

          var_7 = level.vehicle.templates.aianims[var_3];
          level.vehicle_builds[var_0].max_ai = var_7.size;
          return;
        }

        return;
      }

      return;
    }

    return;
  }
}

function puzzle_mark_complete(var_0, var_1) {
  if(isDefined(level.vehicle_builds) && isDefined(level.vehicle_builds[var_1]) && isDefined(level.vehicle_builds[var_1].max_ai)) {
    var_2 = puddle_fx(var_0, var_1);

    if(isDefined(var_2)) {
      var_3 = 0;

      for(var_4 = 0; var_4 < self.usedpositions.size; var_4++) {
        var_5 = 1;

        for(var_6 = 0; var_6 < var_2.size; var_6++) {
          if(var_2[var_6] == var_4) {
            var_5 = 0;
            break;
          }
        }

        if(var_5) {
          var_3++;
        }
      }

      return int(min(var_3, level.vehicle_builds[var_1].max_ai));
    }

    return level.vehicle_builds[var_5].max_ai;
  }

  return undefined;
}

function get_random_available_air_ai_infil() {
  return scripts\engine\utility::random(level.available_ai_vehicle_air_infils);
}

function get_random_available_ground_ai_infil() {
  return scripts\engine\utility::random(level.available_ai_vehicle_ground_infils);
}

function attempt_ai_ground_infil_cooldown(var_0) {
  if(level.ai_spawn_vehicle_func[var_0].max_num <= level.ai_spawn_vehicle_func[var_0].count) {
    thread remove_ai_ground_infil_for_time(level);
    return;
  }
}

function attempt_ai_air_infil_cooldown(var_0) {
  if(level.ai_spawn_vehicle_func[var_0].max_num <= level.ai_spawn_vehicle_func[var_0].count) {
    thread remove_ai_air_infil_for_time(level);
    return;
  }
}

function remove_ai_ground_infil_for_time(var_0) {
  level.available_ai_vehicle_ground_infils = scripts\engine\utility::array_remove(level.available_ai_vehicle_ground_infils, var_0);

  if(isDefined(level.ai_spawn_vehicle_func[var_0].cooldown)) {
    scripts\engine\utility::delaythread(level.ai_spawn_vehicle_func[var_0].cooldown, &add_ai_ground_infil, var_0);
    return;
  }
}

function remove_ai_air_infil_for_time(var_0) {
  level.available_ai_vehicle_air_infils = scripts\engine\utility::array_remove(level.available_ai_vehicle_air_infils, var_0);

  if(isDefined(level.ai_spawn_vehicle_func[var_0].cooldown)) {
    scripts\engine\utility::delaythread(level.ai_spawn_vehicle_func[var_0].cooldown, &add_ai_air_infil, var_0);
    return;
  }
}

function add_ai_air_infil(var_0) {
  level.available_ai_vehicle_air_infils[var_0] = var_0;
}

function add_ai_ground_infil(var_0) {
  level.available_ai_vehicle_ground_infils[var_0] = var_0;
}

function ref_12b05(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  level waittill(var_0);

  if(isDefined(level.ai_spawn_vehicle_func[var_0])) {
    var_10 = level.ai_spawn_vehicle_func[var_0];

    if(isDefined(var_0)) {
      var_10.spawn_type = var_0;
    }

    if(isDefined(var_1)) {
      var_10.max_num = var_1;
    }

    if(isDefined(var_2)) {
      var_10.cooldown = var_2;
    }

    if(isDefined(var_3)) {
      var_10.max_wait_for_infil = var_3;
    }

    if(isDefined(var_4)) {
      var_10.spawn_points = var_4;
    }

    if(isDefined(var_5)) {
      var_10.exit_points = var_5;
    }

    if(isDefined(var_6)) {
      var_10.path_start_points = var_6;
    }

    if(isDefined(var_8)) {
      var_10.vehicle_spawn_func = var_8;
    }

    if(isDefined(var_9)) {
      var_10.vehicle_build = var_9;
    }

    level.ai_spawn_vehicle_func[var_0] = var_10;

    if(isDefined(var_6)) {
      thread get_path_points(level, var_0);
    }
  }

  if(isDefined(var_7)) {
    if(isDefined(level.vehicle_builds[var_0]) && isDefined(level.vehicle_builds[var_0].max_ai)) {
      level.vehicle_builds[var_0].max_ai = var_7;
      return;
    }

    return;
  }
}

function register_vehicle_spawn(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  level.all_ai_vehicle_infils[level.all_ai_vehicle_infils.size] = var_0;
  var_10 = spawnStruct();
  var_10.spawn_type = var_0;
  var_10.max_num = var_1;
  var_10.cooldown = var_2;
  var_10.max_wait_for_infil = var_3;
  var_10.spawn_points = var_4;
  var_10.exit_points = var_5;
  var_10.path_start_points = var_6;
  var_10.vehicle_spawn_func = var_8;
  var_10.count = 0;
  var_10.max_ai = var_7;
  var_10.vehicle_build = var_9;
  var_10.infected_music = var_0;
  level.ai_spawn_vehicle_func[var_0] = var_10;

  if(isDefined(var_6)) {
    thread get_path_points(level, var_0);
    return;
  }
}

function get_path_points(var_0, var_1) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("introscreen_over");
  scripts\engine\utility::flag_wait("infil_complete");
  scripts\engine\utility::flag_wait("interactions_initialized");
  level.path_points[var_0] = scripts\engine\utility::getStructArray(var_1, "targetname");
}

function register_vehicle_spawn_drivers(var_0, var_1, var_2, var_3) {
  if(istrue(var_3)) {
    level waittill(var_0);
  }

  if(isDefined(level.ai_spawn_vehicle_func[var_0])) {
    var_4 = level.ai_spawn_vehicle_func[var_0];
    var_4.num_script_models = var_1;
    var_4.driver_models = var_2;
    level.ai_spawn_vehicle_func[var_0] = var_4;
    return;
  }
}

function choose_random_ground_vehicle_spawn(var_0, var_1, var_2) {
  if(isDefined(var_1.ai_infil_type)) {
    var_3 = var_1.ai_infil_type;
  } else {
    var_3 = get_random_available_ground_ai_infil();
  }

  if(isDefined(var_3)) {
    var_2.og_script_function = var_2.script_function;
    var_2.script_function = var_3;

    if(!isDefined(var_2.vehicle) && isDefined(level.ai_spawn_vehicle_func[var_3].vehicle_spawn_func)) {
      if([[level.ai_spawn_vehicle_func[var_3].vehicle_spawn_func]](var_1, var_2, var_3)) {
        return 1;
      } else {
        return 0;
      }
    } else if(isDefined(var_2.vehicle)) {
      return 1;
    } else {
      return 0;
    }

    self thread[[level.spawner_script_funcs[var_3].script_function]](var_1, var_2, var_3);
    thread attempt_ai_ground_infil_cooldown(var_3);
    return;
  }

  return 0;
}

function decrement_wave_veh_count(var_0) {
  if(isDefined(self.valid_vehicles) && isDefined(self.valid_vehicles[var_0])) {
    self.valid_vehicles[var_0]--;

    if(self.valid_vehicles[var_0] < 1) {
      self.valid_vehicles[var_0] = undefined;
      return;
    }

    return;
  }
}

function choose_escalation_air_vehicle_spawn(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = var_0 scripts\cp\cp_modular_spawning::get_current_wave_ref();

  if(isDefined(var_4)) {
    var_5 = var_0 scripts\cp\cp_modular_spawning::pressure_stability_event_start();

    if(istrue(var_0.use_only_veh_spawners) && (!isDefined(var_5) || var_5.size < 1)) {
      return 0;
    }

    var_5 = var_1 scripts\cp\cp_modular_spawning::pressure_stability_event_init(var_5);

    if(isDefined(var_5) && var_5.size > 0) {
      var_3 = scripts\engine\utility::random(var_5);

      if(scripts\cp\cp_modular_spawning::has_vehicle_type_exceeded_module_cap(var_0, var_3)) {
        return 0;
      }
    }
  } else if(isDefined(var_0.valid_vehicles) && scripts\engine\utility::array_sum(var_0.valid_vehicles) > 0) {
    var_5 = var_0 scripts\cp\cp_modular_spawning::pressure_stability_event_start();
    var_5 = var_1 scripts\cp\cp_modular_spawning::pressure_stability_event_init(var_5);

    if(isDefined(var_5) && var_5.size > 0) {
      var_3 = scripts\engine\utility::random(var_5);

      if(scripts\cp\cp_modular_spawning::has_vehicle_type_exceeded_module_cap(var_0, var_3)) {
        return 0;
      }
    }
  } else {
    var_3 = get_random_available_air_ai_infil();
  }

  if(isDefined(var_3)) {
    if(scripts\cp\cp_modular_spawning::has_vehicle_type_exceeded_module_cap(var_0, var_3)) {
      return 0;
    }

    var_1.og_script_function = var_1.script_function;
    var_1.script_function = var_3;

    if(!isDefined(var_1.vehicle) && isDefined(level.ai_spawn_vehicle_func[var_3].vehicle_spawn_func)) {
      if([[level.ai_spawn_vehicle_func[var_3].vehicle_spawn_func]](var_0, var_1, var_3)) {
        return 1;
      } else {
        return 0;
      }
    } else if(isDefined(var_1.vehicle)) {
      return 1;
    } else {
      return 0;
    }

    self thread[[level.spawner_script_funcs[var_3].script_function]](var_0, var_1, var_3);
    return;
  }

  return 0;
}

function choose_random_air_vehicle_spawn(var_0, var_1, var_2) {
  if(isDefined(var_1.ai_infil_type)) {
    var_3 = var_1.ai_infil_type;
  } else {
    var_3 = get_random_available_air_ai_infil();
  }

  if(isDefined(var_3)) {
    var_2.og_script_function = var_2.script_function;
    var_2.script_function = var_3;

    if(!isDefined(var_2.vehicle) && isDefined(level.ai_spawn_vehicle_func[var_3].vehicle_spawn_func)) {
      if([[level.ai_spawn_vehicle_func[var_3].vehicle_spawn_func]](var_1, var_2, var_3)) {
        return 1;
      } else {
        return 0;
      }
    } else if(isDefined(var_2.vehicle)) {
      return 1;
    } else {
      return 0;
    }

    self thread[[level.spawner_script_funcs[var_3].script_function]](var_1, var_2, var_3);
    thread attempt_ai_air_infil_cooldown(var_3);
    return;
  }

  return 0;
}

function ai_ground_veh_spawn(var_0, var_1, var_2) {
  if(isDefined(var_1.vehicle)) {
    self.vehicle = var_1.vehicle;
    self.vehicle thread scripts\engine\utility::thread_on_notify("unloaded", &clear_kill_off_flags, self, undefined, self, self, "death");
    thread delay_enter_vehicle(var_0, var_1, var_1.vehicle, var_2);
    thread allow_infil_after_full_or_timeout(var_1.vehicle, var_0);
    return;
  }
}

function should_kill_off_flags() {
  if(isDefined(level.script) && (level.script == "cp_chase" || level.script == "cp_blockade" || level.script == "cp_raid_phase1" || level.script == "cp_donetsk")) {
    return false;
  }

  return true;
}

function stop_vehicle_on_damage_after_loaded() {
  self endon("unload");
  self endon("death");
  self.vehicle endon("death");
  self.vehicle endon("stop_vehicle_on_damage_internal");
  self waittill("loaded");
}

function stop_vehicle_on_damage() {
  self.vehicle endon("death");
  self.vehicle endon("stop_vehicle_on_damage_internal");
  self endon("unload");
  self.vehicle endon("unloaded");
  var_0 = self.vehicle;
  var_1 = scripts\engine\utility::ref_143ad("damage", "death");
  thread stop_vehicle_on_damage_internal(var_0);
}

function stop_vehicle_on_damage_internal(var_0) {
  var_0 notify("stop_vehicle_on_damage_internal");
  var_0 endon("death");
  var_0 scripts\common\utility::vehicle_detachfrompath();
  var_0 scripts\common\vehicle::vehicle_unload("default");
  var_0 waittill("unloaded");
  var_0 thread scripts\common\utility::vehicle_resumepath();
}

function ai_mindia8_jugg_spawn(var_0, var_1, var_2) {
  if(!isDefined(var_1.vehicle)) {
    if(isDefined(level.ai_spawn_vehicle_func[var_2].vehicle_spawn_func)) {
      if([[level.ai_spawn_vehicle_func[var_2].vehicle_spawn_func]](var_0, var_1, var_2)) {
        if(isDefined(self.unittype) && self.unittype == "juggernaut") {
          self.forced_startingposition = 14;
          self.dontkilloff = 1;
        }

        thread ai_enter_vehicle(var_0, var_1, var_2);

        if(!isDefined(self.forced_startingposition)) {
          if(var_1.vehicle.riders.size >= level.vehicle_builds[var_2].max_ai - 1) {
            var_1.vehicle notify("spawning_done");
            return;
          }

          return;
        }

        return;
      }

      return;
    }

    return;
  }

  if(isDefined(self.unittype) && self.unittype == "juggernaut") {
    self.forced_startingposition = 14;
    self.dontkilloff = 1;
  }

  thread ai_enter_vehicle(var_0, var_1, var_2);

  if(var_1.vehicle.riders.size >= level.vehicle_builds[var_2].max_ai - 1) {
    var_1.vehicle notify("spawning_done");
    return;
  }
}

function ai_lbravo_spawn(var_0, var_1, var_2) {
  if(!isDefined(var_1.vehicle) && isDefined(level.ai_spawn_vehicle_func[var_2].vehicle_spawn_func)) {
    if([[level.ai_spawn_vehicle_func[var_2].vehicle_spawn_func]](var_0, var_1, var_2)) {
      thread ai_enter_vehicle(var_0, var_1, var_2);
      return;
    }

    return;
  }

  thread ai_enter_vehicle(var_0, var_1, var_2);
}

function ai_enter_vehicle(var_0, var_1, var_2) {
  if(isDefined(var_1.vehicle)) {
    thread hasexiteddriver(var_1.vehicle);
    thread delay_enter_vehicle(var_0, var_1, var_1.vehicle, var_2);
    thread allow_infil_after_full_or_timeout(var_1.vehicle, var_0);

    if(isDefined(var_1.script_demeanor)) {
      scripts\cp\cp_modular_spawning::set_demeanor_from_unittype(var_1.script_demeanor);
      return;
    }

    return;
  }
}

function hasexiteddriver(var_0) {
  self endon("death");
  hashitplayer(var_0);
  thread clear_kill_off_flags(self);
}

function hashitplayer(var_0) {
  self endon("unload");
  self endon("death");
  var_0 endon("death");
  self waittill("forever");
}

function delay_enter_vehicle(var_0, var_1, var_2, var_3) {
  if(isDefined(self.spawnpoint.pos_override_struct) && self.spawnpoint.pos_override_struct != var_2) {
    thread add_to_vehicle_queue(var_2);
    return;
  }

  scripts\engine\utility::thread_on_notify("loaded", &disable_canshootinvehicle);
  self hide();

  if(isDefined(var_1.script_demeanor)) {
    scripts\cp\cp_modular_spawning::set_demeanor_from_unittype(var_1.script_demeanor);
  }

  var_4 = redlight(var_2, var_0, var_3);

  if(!isDefined(self.forced_startingposition) && isDefined(var_4) && int(var_4) >= 0) {
    self.forced_startingposition = var_4;
  }

  self dontinterpolate();
  var_2 thread scripts\common\vehicle_aianim::guy_enter(self);
}

function disable_canshootinvehicle() {
  self show();

  if(istrue(level.vehicle_ai_can_shoot_after_reload)) {
    return;
  }

  self.canshootinvehicle = 0;
}

function add_to_vehicle_queue(var_0) {
  self notify("add_to_vehicle_queue");
  self.load_queue[self.load_queue.size] = var_0;
  var_0 scripts\engine\utility::thread_on_notify_no_endon_death("death", &remove_from_vehicle_queue, self);
}

function remove_from_vehicle_queue(var_0) {
  if(isDefined(var_0) && isDefined(var_0.load_queue) && var_0.load_queue.size > 0) {
    if(scripts\engine\utility::array_contains(var_0.load_queue, self)) {
      var_0.load_queue = scripts\engine\utility::array_remove(var_0.load_queue, self);
      return;
    }

    return;
  }
}

function veh_ground_veh_spawn(var_0, var_1, var_2) {
  var_3 = level.ai_spawn_vehicle_func[var_2];
  var_4 = get_vehicle_spawn_points(var_3, var_1);

  if(var_4.size > 0) {
    foreach(var_6 in var_4) {
      if(istrue(var_6.in_use)) {
        continue;
      }

      var_7 = create_ai_plr_vehicle(var_6, var_2);

      if(isDefined(var_7)) {
        stringtovec3(var_7, var_1, var_0, var_6, var_2);
        thread veh_ping_vehicle_location_to_players();
        thread waittill_full_or_timeout(var_7, var_2);
        post_spawn_vehicle_init(var_7, var_0, var_1, var_2, var_6);
        thread super_onspawned(var_7, var_0);

        if(ref_141b4(var_2) || getdvarint("scr_script_model_drivers", 0)) {
          thread ref_135cb(var_7, var_7);
        }

        clear_vehicle_build_to_spawnpoint(var_6);
        return 1;
      }

      clear_vehicle_build_to_spawnpoint(var_6);
      return 0;
    }

    var_6 = undefined;
    var_7 = undefined;
    return 0;
  }

  return 0;
}

function veh_ping_vehicle_location_to_players() {
  self endon("death");
  self endon("unloading");

  for(;;) {
    pinglocationenemyteams(self.origin, "axis");
    wait 2;
  }
}

function post_spawn_vehicle_init(var_0, var_1, var_2, var_3) {
  level.ai_spawn_vehicle_func[var_2].count++;
  self.load_queue = [];
  self.group = var_0;
  self.vehicle_skipdeathmodel = 1;
  self.veh_spawn_point = var_3;
  var_1.ai_infil_type = var_2;
  var_3.in_use = 1;
  var_1.specs = level.spawner_script_funcs[var_2].specs;
  var_1.vehicle = self;
  self.spawn_point = var_1;
}

function set_throttle_zero() {}

function reset_throttle() {}

function ref_135cb(var_0, var_1) {
  var_2 = level.ai_spawn_vehicle_func[var_1];

  if(isDefined(var_2) && isDefined(var_2.num_script_models)) {
    var_3 = [];

    for(var_4 = 0; var_4 < var_2.num_script_models; var_4++) {
      var_5 = level.vehicle.templates.aianims[var_0.classname_mp][var_4];
      var_6 = var_5.sittag;
      var_7 = var_0 scripts\cp\vehicles\vehicle_cp::spawn_script_model_at_pos(var_4, var_6, var_5.idle_anim, var_5.idle, var_2.driver_models);
      var_3 = var_7;
      level.ref_14102[level.ref_14102.size] = var_7;
      thread handlemeleekillrewardbullets(var_0);

      if(var_4 <= 1 && scripts\cp\utility::turn_off_sniper_laser()) {
        thread ref_12f4e(var_0);
      }
    }
  }

  if(isDefined(level.vehicle_builds[var_1]) && isDefined(level.vehicle_builds[var_1].max_ai)) {
    var_8 = int(min(level.vehicle_builds[var_1].max_ai, var_0.usedpositions.size));
  } else {
    var_8 = var_1.usedpositions.size;
  }

  if(var_1.attachedguys.size >= var_8) {
    var_1 notify("spawning_done");
    return;
  }
}

function ref_12f4e(var_0) {
  self endon("death");
  var_0 endon("death");

  if(!isDefined(self) || !isDefined(var_0)) {
    return;
  }

  var_1 = 250;

  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5);

    if(isDefined(var_3) && isPlayer(var_3) && isDefined(var_2) && var_2 > 0 && isDefined(var_5)) {
      if(var_0 tagexists("j_head")) {
        var_6 = var_0 gettagorigin("j_head");
      } else {
        var_6 = var_1.origin + (0, 0, 50);
      }

      var_6 += (0, 0, -20);
      var_7 = var_4 getEye();
      var_8 = vectorNormalize(var_6 - var_7);
      var_9 = vectorNormalize(var_6 - var_7);
      var_10 = vectordot(var_8, var_9);
      var_11 = vectordot(vectorNormalize(anglesToForward(self.angles)), vectorNormalize(var_6 - self.origin));
      var_12 = var_1.origin + (0, 0, 18);

      if(var_10 > 0.99975 && var_11 > 0.73 && var_6[2] > var_12[2]) {
        var_2 -= var_3;

        if(var_2 <= 0) {
          var_4 scripts\cp\cp_achievement::scriptable_enginedamaged();
          self notify("death", var_4);
        }
      }
    }
  }
}

function ref_13b03(var_0) {
  self endon("death");

  for(;;) {
    var_1 = getdvarint("scr_x", 0);
    var_2 = getdvarint("scr_y", 0);
    var_3 = getdvarint("scr_z", 0);
    var_4 = scripts\cp\utility::get_point_in_local_ent_space(var_0, (var_1, var_2, var_3));
    thread scripts\engine\utility::draw_line_for_time(var_4, var_4 + (0, 0, 128), 1, 1, 1, 0.05);
    waitframe();
  }
}

function handlemeleekillrewardbullets(var_0) {
  self waittill("death");

  if(isDefined(var_0)) {
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      ref_12bcd(var_0[var_1]);
    }

    return;
  }
}

function ref_12bcd() {
  if(scripts\engine\utility::array_contains(level.ref_14102, self)) {
    level.ref_14102 = scripts\engine\utility::array_remove(level.ref_14102, self);

    if(isDefined(self)) {
      self delete();
      return;
    }

    return;
  }
}

function get_vehicle_spawn_points(var_0) {
  if(istrue(var_0.veh_model_spawner)) {
    return [var_0];
  }

  var_1 = scripts\engine\utility::getStructArray(self.spawn_points, "targetname");
  var_2 = [];

  if(isDefined(var_0.script_linkname)) {
    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      if(is_linked_struct(var_1[var_3], var_0)) {
        var_2 = var_1[var_3];
      }
    }

    if(var_2.size < 1) {
      return scripts\engine\utility::array_randomize(var_1);
    }

    var_4 = scripts\engine\utility::random(var_2);
    return [var_4];
  }

  return scripts\engine\utility::array_randomize(var_2);
}

function veh_heli_spawn(var_0, var_1, var_2) {
  var_3 = level.ai_spawn_vehicle_func[var_2];
  var_4 = get_vehicle_spawn_points(var_3, var_1);

  if(var_4.size > 0) {
    foreach(var_6 in var_4) {
      if(istrue(var_6.in_use)) {
        continue;
      }

      if(getdvarint("scr_direct_heli_path_debug", 0)) {
        thread scripts\engine\utility::draw_capsule(var_6.origin, 64, 64, (0, 0, 0), (0, 1, 0), 0, 1000);
      }

      copy_vehicle_build_to_spawnpoint(var_2, var_6);
      var_7 = vectortoangles(var_1.origin - var_6.origin);
      var_6.angles = (0, var_7[1], 0);
      var_8 = scripts\common\vehicle::vehicle_spawn(var_6);

      if(isDefined(var_8)) {
        stringtovec3(var_8, var_1, var_0, var_6, var_2);
        ref_13bb7(var_6, 1);

        if(var_6 scripts\common\vehicle_code::ishelicopter_internal()) {
          init_helicopter(var_8, var_0, var_2);
        }

        var_0.vehicle = var_8;
        var_8.veh_spawn_point = var_6;
        var_8.path_gobbler = 1;
        var_1.specs = level.spawner_script_funcs[var_2].specs;
        var_1.ai_infil_type = var_2;
        thread veh_ping_vehicle_location_to_players();
        thread heli_waittill_full_or_timeout(var_8, var_2);

        if(ref_141b4(var_2) || getdvarint("scr_script_model_drivers", 0) || scripts\cp\utility::turn_off_sniper_laser()) {
          thread ref_135cb(var_8, var_8);
        }

        clear_vehicle_build_to_spawnpoint(var_6);
        return 1;
      }

      clear_vehicle_build_to_spawnpoint(var_6);
      return 0;
    }

    var_8 = undefined;
    return 0;
  }

  return 0;
}

function stringtovec3(var_0, var_1, var_2, var_3) {
  self.load_queue = [];
  self.spawn_point = var_0;
  self.stop_all_ascend_anims = var_3;
  self.group = var_1;
  var_1.vehicle = self;
  var_0.vehicle = self;
  var_0.veh_spawn_point = var_2;
  self.veh_spawn_point = var_2;
  self.dontdisconnectpaths = 1;
  var_1.ref_12a87 = 1;
  self setCanDamage(1);
  scripts\cp_mp\emp_debuff::set_start_emp_callback(&scripts\cp_mp\vehicles\vehicle::vehicle_empstartcallback);
  scripts\cp_mp\emp_debuff::set_clear_emp_callback(&scripts\cp_mp\vehicles\vehicle::vehicle_empclearcallback);
  thread lb_impulse_dmg_threshold_top();
  thread decrement_wave_veh_count(var_1);
  self vehicle_turnengineon();
}

function lb_impulse_dmg_threshold_top() {
  self endon("death");
  var_0 = ref_14451();

  if(isDefined(var_0) && isai(var_0)) {
    var_0.health = 500;
    var_0.maxhealth = 500;

    if(scripts\common\vehicle_code::ishelicopter_internal()) {
      thread lb_mg_dmg_factor_driverless_collision(var_0);
      return;
    }

    thread ref_138ce(var_0);
    return;
  }
}

function lb_mg_dmg_factor_driverless_collision(var_0) {
  level endon("game_ended");
  self endon("death_finished");
  self endon("death");
  var_0 endon("unload");
  var_0 waittill("death", var_1, var_2, var_3, var_4);

  if(isDefined(var_1) && isPlayer(var_1)) {
    var_1 scripts\cp\cp_achievement::scriptable_enginedamaged();
  }

  self notify("death", var_1);
}

function ref_138ce(var_0) {
  level endon("game_ended");
  self endon("death");
  var_0 endon("unload");
  var_0 waittill("death", var_1, var_2, var_3, var_4);
  self notify("watch_for_all_passengers_dead");
  self stoppath(1);
  self notify("stop_follow_path");
  scripts\common\vehicle::vehicle_unload();
}

function ref_14451() {
  level endon("game_ended");
  self endon("death");
  self endon("unloading");

  for(;;) {
    self waittill("guy_entered", var_0, var_1);

    if(isDefined(var_0)) {
      if(scripts\engine\utility::is_equal(self.driver, var_0)) {
        return var_0;
      }
    }
  }

  return undefined;
}

function ref_13bb7(var_0) {
  if(istrue(var_0)) {
    self.in_use = var_0;
    return;
  }

  self.in_use = undefined;
}

function clear_vehicle_build_to_spawnpoint(var_0) {
  var_0.classname_mp = undefined;
  var_0.vehicletype = undefined;
  var_0.vehiclename = undefined;
}

function copy_vehicle_build_to_spawnpoint(var_0, var_1) {
  if(isDefined(level.vehicle_builds) && isDefined(level.vehicle_builds[var_0])) {
    var_2 = level.vehicle_builds[var_0];

    if(isDefined(var_2.classname_mp)) {
      var_1.classname_mp = var_2.classname_mp;
    }

    if(isDefined(var_2.vehicletype)) {
      var_1.vehicletype = var_2.vehicletype;
    }

    if(isDefined(var_2.vehiclename)) {
      var_1.vehiclename = var_2.vehiclename;
      return;
    }

    return;
  }
}

function waittill_full_or_timeout(var_0, var_1) {
  self notify("waittill_full_or_timeout");
  self endon("waittill_full_or_timeout");
  self endon("death");
  level endon("game_ended");
  thread decrement_vehicles_active(var_0, var_1);
  thread watch_for_all_passengers_dead(var_0, var_1);

  if(self vehicle_isphysveh()) {
    if(getdvarint("scr_struct_spline_path", 0)) {
      self vehicle_cleardrivingstate();
    }

    self.veh_brake = 1;
  }

  self waittill("spawning_done");
  self.spawn_point scripts\cp\cp_modular_spawning::little_bird_mg_givetakegunnerturrettimeout();
  scripts\engine\utility::thread_on_notify_no_endon_death("unloading", &check_for_unloading_func, var_0, undefined, undefined);

  if(!isDefined(self.group.ref_13959)) {
    self.group.ref_13959 = 1;
  } else {
    self.group.ref_13959++;
  }

  self.group.vehicle = undefined;
  self.spawn_point.pos_override_struct = undefined;

  if(self.load_queue.size > 0) {
    thread scripts\common\vehicle::vehicle_load_ai(self.load_queue);
    scripts\engine\utility::ent_flag_wait("loaded");
  } else {
    wait 1;
  }

  var_2 = create_vehicle_path(var_0);

  if(self vehicle_isphysveh()) {
    self.veh_brake = 0;
  }

  self notify("ai_vehicle_pathing_started");

  if(!self vehicle_isphysveh()) {
    if(isDefined(self.target)) {
      var_3 = getvehiclenode(self.target, "targetname");
      self attachpath(var_3);
      self startpath();
      return;
    }

    self notify("stop_vehicle_watchers");
    return;
  }

  self notify("newpath");

  if(isDefined(self.target)) {
    var_3 = getvehiclenode(self.target, "targetname");

    if(isDefined(var_3)) {
      self attachpath(var_3);
      self startpath();
      return;
    }
  }

  if(getdvarint("scr_struct_spline_path", 0) && self.pathing_array.size >= 1) {
    self.spawn_point.vehicle = undefined;
    vehiclefollowstructpath(self.pathing_array[0], 1);
    wait 5;
    return;
  }

  self.spawn_point.vehicle = undefined;
  thread scripts\common\vehicle_paths::getonpath();
}

function get_duration_between_points(var_0, var_1, var_2, var_3) {
  var_4 = distance(var_0, var_1);

  if(istrue(var_3)) {
    var_4 *= 0.0568182;
  }

  var_5 = var_4 / var_2;

  if(var_5 < 0.05) {
    var_5 = 0.05;
  }

  return var_5;
}

function start_vehicle_path(var_0) {
  if(!self vehicle_isphysveh() && !isstruct(var_0)) {
    var_0 = getvehiclenode(self.target, "targetname");
    self attachpath(var_0);
    self startpath();
    return;
  }

  self notify("newpath");

  if(getdvarint("scr_struct_spline_path", 0) && self.pathing_array.size >= 1) {
    thread vehiclefollowstructpath(self.pathing_array[0]);
    return;
  }

  thread scripts\common\vehicle_paths::getonpath();
}

function watch_for_vehicle_stuck() {
  self endon("death");
  self endon("stop_vehicle_watchers");
  self waittill("ai_vehicle_pathing_started");
  self endon("unloading");
  var_0 = 0;
  var_1 = 2;

  if(isDefined(self.ref_13f12)) {
    var_1 = self.ref_13f12;
  }

  for(;;) {
    if(self issuspendedvehicle() || self vehicle_getspeed() <= 2) {
      var_0 += 0.1;
    } else {
      var_0 = 0;
    }

    if(var_0 >= var_1) {
      break;
    }

    wait 0.1;
  }

  self vehicle_setspeedimmediate(0, 30, 30);
  thread scripts\common\vehicle_code::_vehicle_unload("default");
}

function heli_waittill_full_or_timeout(var_0, var_1) {
  self notify("waittill_full_or_timeout");
  self endon("waittill_full_or_timeout");
  self endon("death");
  level endon("game_ended");
  thread decrement_vehicles_active(var_0, var_1);
  thread slide_trig(var_0);
  self waittill("spawning_done");
  self.spawn_point scripts\cp\cp_modular_spawning::little_bird_mg_givetakegunnerturrettimeout();
  self.group.vehicle = undefined;
  scripts\engine\utility::thread_on_notify_no_endon_death("unloading", &check_for_unloading_func, var_0, undefined, undefined);
  scripts\engine\utility::thread_on_notify_no_endon_death("unloaded", &delete_nav_obstacle, undefined, undefined, undefined);

  if(isDefined(self.spawn_point.heli_path_func)) {
    var_2 = self[[self.spawn_point.heli_path_func]](var_0);
  } else {
    var_2 = create_direct_heli_path(var_1);
  }

  self.spawn_point.vehicle = undefined;
}

function check_for_unloading_func(var_0) {
  if(isDefined(level.unloading_func[var_0])) {
    self thread[[level.unloading_func[var_0]]]();
    return;
  }
}

function watch_for_all_passengers_dead(var_0, var_1) {
  self notify("watch_for_all_passengers_dead");
  self endon("watch_for_all_passengers_dead");
  self endon("death");
  self endon("unloading");
  self waittill("guy_entered");
  self waittill("spawning_done");

  for(;;) {
    var_2 = reflectbolt(1);

    if(var_2 <= 0) {
      delete_nav_obstacle();
      self notify("all_passengers_dead");
      self notify("newpath");
      self vehicle_setspeedimmediate(0, 30, 30);
      thread hudattractionobj(var_1);
      break;
    }

    wait 0.2;
  }
}

function hudattractionobj(var_0, var_1) {
  var_2 = self.riders;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(!isent(var_4) || isagent(var_4)) {
      continue;
    }

    var_5 = spawnStruct();
    var_5.origin = var_4.origin;
    var_5.angles = var_4.angles;
    var_5.vehicle_position = var_4.vehicle_position;
    var_5.specs = var_4.specs;

    if(isDefined(self.convoy)) {
      lastteamused(level, self);
    }

    ref_12bcd(var_4);
    var_6 = var_5.vehicle_position;
    var_5.vehicle_position = undefined;
    var_5.specs = "vehicle_ai";
    var_7 = scripts\cp\cp_modular_spawning::spawn_soldier_scripted_internal(var_0, var_5, 0, "vehicle_ai", undefined, 1);

    if(isDefined(var_7)) {
      var_7.forced_startingposition = var_6;

      if(istrue(self.ref_13898)) {
        var_7.ignoreall = 0;
        var_7.sightmaxdistance = 2200;
        var_7 thread scripts\cp\coop_stealth::run_common_functions(var_7, 1, 1, 60, 160000);
      }

      thread scripts\common\vehicle_aianim::guy_enter(var_7);
    }

    if(isent(var_4)) {
      var_4 delete();
    }
  }

  scripts\common\vehicle::vehicle_unload();
}

function lastteamused(var_0) {
  level endon("game_ended");

  if(!isDefined(var_0.convoy)) {
    return;
  }

  var_0.convoy endon("event_convoy_delete");
  var_0.convoy endon("death");
  var_0 endon("death");
  var_1 = var_0.convoy;

  if(istrue(var_1.kiosksearchradiusidealmax)) {
    thread lasttimedamagecalledout();

    while(istrue(var_1.kiosksearchradiusidealmax)) {
      wait 0.5;
    }

    return;
  }

  var_2 = 28;

  if(getaiarray("axis").size > var_2) {
    var_1.kiosksearchradiusidealmax = 1;
    scripts\cp\cp_modular_spawning::pause_group_by_group_name("wave_spawning");

    while(getaiarray("axis").size > var_2) {
      wait 0.5;
    }

    var_1.kiosksearchradiusidealmax = undefined;
    var_1 notify("delayed_depositing_undefined");
    scripts\cp\cp_modular_spawning::unpause_group_by_group_name("wave_spawning");
    return;
  }
}

function lasttimedamagecalledout() {
  level endon("game_ended");
  self.convoy endon("delayed_depositing_undefined");
  self waittill("death");

  if(isDefined(self.convoy)) {
    self.convoy.kiosksearchradiusidealmax = undefined;
    return;
  }
}

function slide_trig(var_0) {
  self notify("heli_watch_for_fly_away");
  self endon("heli_watch_for_fly_away");
  self endon("death");
  self waittill("guy_entered");
  self waittill("spawning_done");
  thread ref_143a4(var_0);
  thread ref_143ea(var_0);
}

function ref_143ea(var_0) {
  self notify("waittill_unload_complete");
  self endon("waittill_unload_complete");
  self endon("death");
  self endon("all_valid_passengers_are_gone");
  self waittill("unloaded");

  if(isDefined(self.spawn_point) && isDefined(self.spawn_point.wavesv_finite_ending)) {
    if(isDefined(level.sixthsenselastvotime)) {
      [[level.sixthsenselastvotime]](self);
    }

    return;
  }

  self notify("newpath");
  delete_nav_obstacle();
  thread recently_spawned_vehicle(var_0);
  self notify("all_valid_passengers_are_gone");
}

function ref_143a4(var_0) {
  self notify("waittill_all_valid_ai_are_gone");
  self endon("waittill_all_valid_ai_are_gone");
  self endon("death");
  self endon("unloaded");

  for(;;) {
    var_1 = reflectbolt();
    var_2 = reflectbolt(1);
    var_3 = reflectprojectile(1);

    if(var_2 <= 0 || var_3 <= 0) {
      if(isDefined(self.spawn_point) && isDefined(self.spawn_point.wavesv_finite_ending)) {
        if(isDefined(level.sixthsenselastvotime)) {
          [[level.sixthsenselastvotime]](self);
        }

        return;
      }

      thread recently_spawned_vehicle(var_0);
      self notify("newpath");
      delete_nav_obstacle();
      self notify("all_valid_passengers_are_gone");
      break;
    }

    wait 0.2;
  }
}

function recently_spawned_vehicle(var_0) {
  self endon("death");
  thread ref_11b04();
  var_1 = getgroundposition(self.origin, 1);

  if(distancesquared(self.origin, var_1) <= 2250000) {
    var_2 = spawnStruct();
    var_2.origin = var_1 + (0, 0, 1500);
    var_2.angles = self.angles;
    var_2.script_goalyaw = 1;
    thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_2);
    self setneargoalnotifydist(512);
    scripts\engine\utility::ref_143a5("near_goal", "goal");
  }

  var_3 = get_best_end_point(var_0, self.spawn_point, self.angles);

  if(!isDefined(var_3)) {
    var_3 = scripts\engine\utility::random(scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var_0].exit_points, "targetname"));
  }

  var_4 = duplicate_struct(var_3);
  var_5 = anglesToForward(vectortoangles(var_4.origin - self.origin)) * 10000;
  var_4.origin += (var_5[0], var_5[1], var_4.origin[2]);
  var_4.targetname = create_unique_kvp_string();
  self.end_point = var_4;
  var_6 = var_4;

  if(getdvarint("scr_direct_heli_path_debug", 0)) {
    thread scripts\engine\utility::draw_capsule(var_4.origin, 32, 32, (0, 0, 0), (1, 0, 0), 0, 250);
  }

  thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_4);
}

function ref_11b04() {
  level endon("game_ended");
  self endon("death");
  wait 2;

  if(isDefined(self.riders) && self.riders.size > 0) {
    for(var_0 = 0; var_0 < self.riders.size; var_0++) {
      self.riders[var_0].ref_11e52 = 1;
    }

    return;
  }
}

function cant_get_out_num() {
  var_0 = 0;

  if(isDefined(level.vehicle.templates.aianims)) {
    if(isDefined(self.classname_mp) && isDefined(level.vehicle.templates.aianims[self.classname_mp])) {
      for(var_1 = 0; var_1 < self.riders.size; var_1++) {
        var_2 = self.riders[var_1];

        if(!isDefined(var_2.vehicle_position)) {
          continue;
        }

        var_3 = level.vehicle.templates.aianims[self.classname_mp][var_2.vehicle_position];

        if(!isDefined(var_3.getout)) {
          var_0++;
        }
      }
    } else if(isDefined(level.vehicle.templates.aianims[self.classname])) {
      for(var_1 = 0; var_1 < self.riders.size; var_1++) {
        var_2 = self.riders[var_1];
        var_3 = level.vehicle.templates.aianims[self.classname][var_2.vehicle_position];

        if(!isDefined(var_3.getout)) {
          var_0++;
        }
      }
    }
  }

  return var_0;
}

function reflectbolt(var_0) {
  var_1 = 0;

  foreach(var_3 in self.riders) {
    if(istrue(var_0)) {
      if(isalive(var_3)) {
        var_1++;
      }

      continue;
    }

    var_1++;
  }

  return var_1;
}

function reflectprojectile(var_0, var_1) {
  var_2 = 0;

  if(isDefined(self.classname_mp)) {
    if(isDefined(level.vehicle) && isDefined(level.vehicle.templates) && isDefined(level.vehicle.templates.aianims) && isDefined(level.vehicle.templates.aianims[self.classname_mp])) {
      for(var_3 = 0; var_3 < self.riders.size; var_3++) {
        var_4 = self.riders[var_3];

        if(!isalive(var_4)) {
          continue;
        }

        if(!isai(var_4)) {
          continue;
        }

        if(!isDefined(var_4.vehicle_position)) {
          continue;
        }

        if(scripts\common\vehicle_aianim::check_unloadgroup(var_4.vehicle_position)) {
          var_5 = level.vehicle.templates.aianims[self.classname_mp][var_4.vehicle_position];

          if(isDefined(var_5.getout)) {
            var_2++;
          }
        }
      }
    }
  }

  return var_2;
}

function unload_when_near_players() {
  self endon("unload");
  self endon("death");

  for(;;) {
    wait 1;

    if(scripts\engine\utility::get_array_of_closest(self.origin, level.players, undefined, 1, 512).size) {
      if(isDefined(self.riders)) {
        for(var_0 = 0; var_0 < self.riders.size; var_0++) {
          var_1 = self.riders[var_0];
          var_1 scripts\common\utility::demeanor_override("combat");
        }
      }

      break;
    }
  }
}

function create_vehicle_path(var_0) {
  level notify("create_vehicle_path");
  var_1 = level.next_index;
  level.next_index++;

  if(isDefined(self.spawn_point.veh_model_spawner)) {
    self.allow_unload_on_path = 1;
    var_2 = create_path_to_delete_node(var_0, var_1);
    var_3 = undefined;
    return var_2;
  } else {
    var_2 = duplicate_struct(self.veh_spawn_point);
    add_targetname_kvps(var_2, undefined, var_2 + var_3 + "_start");
    self.currentnode = var_2;
    var_4 = create_simple_path(self.currentnode, self.angles, var_3, var_2, "_end_node_pathing_", (1, 1, 0));

    if(var_4) {
      return var_2;
    }
  }

  var_3 = duplicate_struct(self.spawn_point);
  var_5 = undefined;

  if(isDefined(var_3) && isDefined(self.veh_spawn_point) && isDefined(self.veh_spawn_point.script_linkto)) {
    var_6 = get_veh_linked_structs(self.veh_spawn_point);
    var_7 = -5;

    foreach(var_9 in var_6) {
      var_10 = scripts\engine\math::get_dot(self.origin, self.angles, var_9.origin);
      var_11 = scripts\engine\math::get_dot(self.origin, vectortoangles(var_3.origin - self.origin), var_9.origin);
      var_12 = var_10 + var_11;

      if(var_12 > var_7) {
        var_7 = var_12;
        var_5 = var_9;
      }
    }
  }

  if(!isDefined(var_5)) {
    var_14 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var_2].path_start_points, "targetname");

    if(!isDefined(var_14) || var_14.size < 1) {
      var_14 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var_2].path_start_points, "script_linkName");
    }

    if(!isDefined(var_14) || var_14.size < 1) {
      return;
    }

    var_5 = scripts\engine\utility::getclosest(self.origin, var_14);
  }

  if(!isDefined(var_5)) {
    return;
  }

  var_15 = duplicate_struct(var_5);
  var_15.angles = vectortoangles(var_15.origin - self.origin);

  if(false) {
    level thread scripts\cp\utility::draw_line_until_endons(self.spawn_point.origin, 1, 1, 1, "create_vehicle_path");
    level thread scripts\cp\utility::draw_line_until_endons(var_15.origin, 0, 1, 0, "create_vehicle_path");
    level thread scripts\cp\utility::draw_line_until_endons(var_3.origin, 1, 1, 0, "create_vehicle_path");
  }

  add_targetname_kvps(var_15, undefined, var_2 + var_3 + "_start");
  create_path_from_struct_to_struct(var_15, var_3, var_3, var_2, "_unload_pathing_", (1, 1, 1));
  scripts\engine\utility::thread_on_notify("unloaded", &create_path_to_delete_node, var_2, var_3, self);
  scripts\engine\utility::thread_on_notify_no_endon_death("death", &reset_spawn_point_targetname, self.spawn_point, undefined, self);
  self.disabled_nodes = undefined;
  return var_15;
}

function create_path_to_delete_node(var_0, var_1) {
  var_2 = self.spawn_point;
  self.currentnode = var_2;
  var_3 = create_simple_path(self.currentnode, self.angles, var_1, var_0, "_end_node_pathing_", (1, 1, 0));

  if(!var_3) {
    var_4 = get_best_end_point(var_0, self.currentnode);
    var_5 = duplicate_struct(var_4);
    self.path_gobbler = 1;
    self.end_point = var_5;

    if(false) {
      level thread scripts\cp\utility::draw_line_until_endons(var_5.origin, 1, 0, 0, "create_vehicle_path");
    }

    create_path_from_struct_to_struct(self.currentnode, var_5, var_1, var_0, "_end_node_pathing_", (1, 1, 0));
  }

  if(scripts\engine\math::is_point_in_front(self.currentnode.origin) || self.spawn_point.origin == self.currentnode.origin) {
    self.target = self.pathing_array[1].targetname;
  } else if(!var_3) {
    self.target = self.pathing_array[1].targetname;
  } else {
    self.pathing_array = scripts\engine\utility::array_remove_index(self.pathing_array, 0);
  }

  self.disabled_nodes = undefined;
  return self.currentnode;
}

function start_struct_path(var_0, var_1) {
  self notify("start_struct_path");
  self endon("start_struct_path");
  self endon("death");
  self startpathnodes(var_0, var_1, 0, 0.5, 0.5, 1);
  var_2 = 1;
  var_3 = self.pathing_array[var_2];
  var_4 = self.pathing_array[var_2];
  var_5 = 62500;

  if(!isDefined(var_3)) {
    return;
  }

  thread process_nextpoint_after_struct_wait(var_3, var_5);

  for(;;) {
    self waittill("trigger", var_6, var_7, var_8, var_9);

    if(isint(var_6)) {
      if(var_2 < var_6 + 1) {
        var_2 = var_6 + 1;
        var_3 = get_next_node_on_spline(var_2);

        if(isDefined(var_3)) {
          var_4 = var_3;
          thread process_nextpoint_after_struct_wait(var_3, var_5);
          continue;
        }

        break;
      }
    }
  }
}

function ref_14205(var_0) {
  level endon("game_ended");
  self endon("death");
  self notify("vehicle_process_node_when_at_goal");
  self endon("vehicle_process_node_when_at_goal");
  var_1 = 12500;
  var_2 = 1;
  var_3 = self.pathing_array[var_2];
  var_4 = self.pathing_array[var_2];
  level.ref_1421f = self;
  jumpiffalse(istrue(var_0)) LOC_0000004e;
  thread process_nextpoint_after_struct_wait(var_3, var_1);

  for(;;) {
    self waittill("trigger", var_5, var_6, var_7, var_8);

    if(isint(var_5)) {
      if(var_2 < var_5 + 1) {
        if(isDefined(self.path_gobbler)) {
          scripts\engine\utility::deletestruct_ref(var_3);
        }

        var_2 = var_5 + 1;
        var_3 = get_next_node_on_spline(var_2);

        if(isDefined(var_3)) {
          var_4 = var_3;
          self notify("new_next_point");

          if(istrue(var_0)) {
            thread process_nextpoint_after_struct_wait(var_3, var_1);
          }

          continue;
        }

        break;
      }
    }
  }
}

function process_nextpoint_after_struct_wait(var_0, var_1) {
  self notify("process_nextPoint_after_struct_wait");
  self endon("process_nextPoint_after_struct_wait");
  self endon("death");

  while(distancesquared(self.origin, var_0.origin) > var_1) {
    wait 0.1;
  }

  process_vehicle_struct_node(var_0);
}

function process_vehicle_struct_node(var_0) {
  self endon("newpath");
  self endon("death");
  var_1 = scripts\common\vehicle_paths::get_path_getfunc(var_0);
  var_2 = undefined;
  self.currentnode = var_0;
  scripts\common\vehicle_paths::trigger_process_node(var_0);

  if(scripts\common\vehicle_paths::vehicle_should_unload(&scripts\common\vehicle_paths::node_wait, var_0)) {
    self vehicle_setspeedimmediate(0, 1, 1);
    struct_path_unload_node(var_0);
    wait 0.25;

    if(!isDefined(self.riders) || self.riders.size < 1) {
      self notify("vehicle_process_node_when_at_goal");
      self notify("stop_follow_path");
      return;
    }

    self resumespeed(20);
    return;
  }
}

function struct_path_unload_node(var_0) {
  self endon("death");

  if(isDefined(self.ent_flag["prep_unload"]) && scripts\engine\utility::ent_flag("prep_unload")) {
    return;
  }

  if(!isDefined(var_0.script_flag_wait) && !isDefined(var_0.script_delay)) {}

  var_1 = getnode(var_0.targetname, "target");

  if(isDefined(var_1) && self.riders.size) {
    foreach(var_3 in self.riders) {
      if(isai(var_3)) {
        var_3 thread scripts\engine\utility::script_func("go_to_node", var_1);
      }
    }
  }

  if(scripts\common\vehicle_code::ishelicopter_internal()) {
    self sethoverparams(0, 0, 0);
    scripts\common\vehicle_code::waittill_stable(var_0);
  }

  if(isDefined(var_0.script_noteworthy)) {
    if(var_0.script_noteworthy == "wait_for_flag") {
      scripts\engine\utility::flag_wait(var_0.script_flag);
    }
  }

  if(isDefined(var_0.script_unload)) {
    if(var_0.script_unload == "1") {
      var_0.script_unload = "default";
    }
  }

  scripts\common\vehicle_code::_vehicle_unload(var_0.script_unload);

  if(scripts\common\vehicle_aianim::riders_unloadable(var_0.script_unload)) {
    self waittill("unloaded");
  }

  if(isDefined(var_0.script_flag_wait) || isDefined(var_0.script_delay)) {
    return;
  }
}

function get_next_node_on_spline(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  if(!isDefined(self.pathing_array)) {
    return undefined;
  }

  if(isDefined(self.pathing_array[var_0])) {
    return self.pathing_array[var_0];
  }

  return undefined;
}

function create_simple_path(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  self endon("death");
  var_6 = 1;
  var_7 = var_0;
  var_8 = -0.3;
  self.pathing_array = [var_0];

  if(false) {
    level.players[0] notifyonplayercommand("use", "+usereload");
    level.players[0] notifyonplayercommand("use", "+activate");
  }

  jumpiffalse(isDefined(var_7.script_linkto)) LOC_00000091;
  var_9 = duplicate_struct(var_7);
  add_targetname_kvps(var_9, undefined, var_3 + var_2 + "_start");
  self.currentnode = var_9;
  var_7 = self.currentnode;

  for(;;) {
    if(false) {
      level.players[0] waittill("use");
    }

    if(isDefined(var_7.script_linkto)) {
      var_10 = get_veh_linked_structs(var_7);
      var_11 = [];
      var_12 = -1;
      var_13 = undefined;

      if(var_10.size == 1) {
        var_11 = var_10[0];
      } else {
        for(var_14 = 0; var_14 < var_10.size; var_14++) {
          var_15 = var_10[var_14];

          if(!isDefined(var_13)) {
            var_13 = var_15;
          }

          var_16 = scripts\engine\math::get_dot(var_7.origin, var_1, var_15.origin);

          if(var_16 >= var_8) {
            var_11 = var_15;
          }
        }
      }

      if(var_11.size < 1 && isDefined(var_13)) {
        var_11 = var_13;
      }

      if(var_11.size > 0) {
        var_17 = scripts\engine\utility::random(var_11);
        var_17 = duplicate_struct(var_17);
        self.path_gobbler = 1;
        self.pathing_array[self.pathing_array.size] = var_17;
        add_targetname_kvps(var_17, var_7, var_3 + "_" + var_2 + "_simple_path_" + self.pathing_array.size);

        if(false) {
          level thread scripts\cp\utility::draw_line_until_endons(var_7.origin, 1, 1, 1, "create_vehicle_path", var_17.origin);
        }

        var_7 = var_17;
      } else {
        break;
      }

      continue;
    }

    if(isDefined(var_7.target)) {
      var_10 = var_7 scripts\engine\utility::get_target_array();
      var_11 = [];
      var_12 = -1;
      var_13 = undefined;

      for(var_14 = 0; var_14 < var_10.size; var_14++) {
        var_15 = var_10[var_14];
        var_16 = scripts\engine\math::get_dot(var_7.origin, var_1, var_15.origin);

        if(var_16 >= var_8) {
          var_11 = var_15;
          continue;
        }

        if(var_16 >= var_12) {
          var_13 = var_10[var_14];
        }
      }

      if(var_11.size < 1 && isDefined(var_13)) {
        var_11 = var_13;
      }

      if(var_11.size > 0) {
        var_17 = scripts\engine\utility::random(var_11);

        if(scripts\engine\utility::array_contains(self.pathing_array, var_17)) {
          self.pathing_array[self.pathing_array.size] = var_17;
          self.ref_119e3 = 1;
          break;
        }

        self.pathing_array[self.pathing_array.size] = var_11;

        if(false) {
          level thread scripts\cp\utility::draw_line_until_endons(var_4.origin, 1, 1, 1, "create_vehicle_path", var_11.origin);
        }

        var_4 = var_11;
      } else {
        break;
      }
    } else {
      break;
    }
  }

  if(self.pathing_array.size > 27) {
    split_large_pathing_array();
  }

  if(self.pathing_array.size < 1) {
    return 0;
  }

  return 1;
}

function split_large_pathing_array() {
  self.pathing_arrays = [];
  var_0 = [];
  var_1 = undefined;

  for(var_2 = 0; var_2 < self.pathing_array.size; var_2++) {
    var_0 = self.pathing_array[var_2];
    var_1 = self.pathing_array[var_2];

    if(var_2 > 0 && var_2 % 27 == 0) {
      self.pathing_arrays[self.pathing_arrays.size] = var_0;
      var_0 = [];
      var_0 = var_1;
    }
  }

  if(var_0.size == 1) {
    var_3 = spawnStruct();
    var_3.origin = (var_0[0].origin + var_1.origin) / 2;
    var_0 = var_0[0];
    var_0 = var_3;
  }

  if(var_0.size > 0) {
    self.pathing_arrays[self.pathing_arrays.size] = var_0;
    return;
  }
}

function create_path_from_struct_to_struct(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  self endon("death");
  var_6 = var_0;
  var_6.angles = self.angles;
  var_7 = undefined;
  var_8 = 1;
  var_9 = 0;
  var_0.pathing_index = 0;

  if(isDefined(self.disabled_nodes)) {
    self.disabled_nodes = undefined;
  }

  if(isDefined(self.pathing_array)) {
    foreach(var_11 in self.pathing_array) {
      if(isDefined(var_11)) {
        var_11.previous_struct = undefined;
        var_11.antepenultimate_struct = undefined;
      }
    }
  }

  self.pathing_array = [var_0];

  if(false) {
    announcement("Waiting for player use");
    level.players[0] notifyonplayercommand("use", "+usereload");
    level.players[0] notifyonplayercommand("use", "+activate");
  }

  for(;;) {
    if(false) {
      level.players[0] waittill("use");
    }

    var_6 = find_closest_path_struct(var_6, var_1, var_3 + var_2 + var_4 + var_9, var_5, var_3);

    if(isDefined(var_6)) {
      if(!isDefined(var_6.pathing_index)) {
        var_6.pathing_index = self.pathing_array.size;
        self.pathing_array[self.pathing_array.size] = var_6;

        if(false) {
          if(isDefined(var_6.previous_struct)) {
            level thread scripts\cp\utility::draw_line_until_endons(var_6.previous_struct.origin, var_5[0], var_5[1], var_5[2], ["create_vehicle_path", "kill_debug_" + var_6.pathing_index], var_6.origin);
          }
        }
      }

      if(var_6.origin == var_1.origin) {
        break;
      }
    } else {
      break;
    }

    if(var_9 > 1000) {
      self notify("no_good_path_found");
      break;
    }

    var_9++;
  }

  for(var_13 = 0; var_13 < self.pathing_array.size - 1; var_13++) {
    self.pathing_array[var_13].target = self.pathing_array[var_13 + 1].targetname;
  }

  if(self.pathing_array.size > 27) {
    split_large_pathing_array();
    return;
  }
}

function find_closest_path_struct(var_0, var_1, var_2, var_3, var_4) {
  self notify("find_closest_path_struct");

  if(false) {
    level thread scripts\cp\utility::drawsphere(var_0.origin, 24, 1, (1, 1, 1));
  }

  var_5 = undefined;
  var_6 = sortbydistance(get_veh_linked_structs(var_0), var_1.origin);

  if(var_6.size < 1) {
    var_7 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var_4].path_start_points, "targetname");

    if(!isDefined(var_7) || var_7.size < 1) {
      var_7 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var_4].path_start_points, "script_linkName");
    }

    if(!isDefined(var_7) || var_7.size < 1) {
      return;
    }

    var_8 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_7, [var_0], 3);

    foreach(var_10 in var_8) {
      var_6 = var_10;
      var_6 = scripts\engine\utility::array_combine(var_6, sortbydistance(get_veh_linked_structs(var_10), var_10.origin));
    }
  }

  var_12 = [];
  var_13 = -5;
  var_14 = 20000;
  var_15 = -5;
  var_16 = undefined;
  var_17 = 0;

  foreach(var_10 in var_6) {
    var_19 = var_10;

    foreach(var_21 in self.pathing_array) {
      if(istrue(var_21.disabled) || var_10.origin == var_21.origin) {
        var_19 = undefined;
        break;
      }
    }

    if(isDefined(var_19)) {
      var_12 = var_19;
    }
  }

  var_0.rewinding_path = undefined;

  if(var_12.size > 1) {
    if(istrue(0)) {}

    self.pathing_array[self.pathing_array.size - 1].was_branch = 1;
  }

  if(is_linked_struct(var_0, var_1)) {
    var_5 = var_1;
  } else if(var_12.size > 0) {
    if(istrue(0)) {
      foreach(var_25 in var_12) {}
    }

    var_5 = calc_best_closest_struct(var_0, var_1, var_12);
  }

  if(!isDefined(var_5) && isDefined(var_16)) {
    var_5 = var_16;
  }

  if(isDefined(var_5)) {
    var_5.angles = vectortoangles(var_5.origin - var_0.origin);

    if(var_5.origin != var_1.origin) {
      var_5 = duplicate_struct(var_5);
    }

    var_5.previous_struct = var_0;

    if(isDefined(var_0.previous_struct)) {
      var_5.antepenultimate_struct = var_0.previous_struct;
    }

    add_targetname_kvps(var_5, var_0, var_2);
    return var_5;
  }

  if(!isDefined(var_5)) {
    var_5 = step_back_to_last_good_branch(var_0, var_1);

    if(isDefined(var_5)) {
      add_targetname_kvps(var_5, var_0, var_2);
    }
  }

  return var_5;
}

function is_linked_struct(var_0, var_1) {
  if(isDefined(var_0.script_linkto) && isDefined(var_1.script_linkname)) {
    var_2 = var_0 scripts\engine\utility::get_links();

    foreach(var_4 in var_2) {
      if(var_1.script_linkname == var_4) {
        return true;
      }
    }
  }

  return false;
}

function print_debug_info(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon(var_5);
  self endon("death");
  var_6 = istrue(self.pathing_array[self.pathing_array.size - 1].was_branch);

  for(;;) {
    waitframe();
  }
}

function get_veh_linked_structs() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = scripts\engine\utility::get_links();

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = scripts\engine\utility::getStructArray(var_1[var_2], "script_linkname");

      if(var_3.size > 0) {
        var_0 = scripts\engine\utility::array_combine(var_0, var_3);
      }
    }
  }

  return var_0;
}

function calc_best_closest_struct(var_0, var_1, var_2) {
  var_3 = 1000000;
  var_4 = 360;
  var_5 = -50;
  var_6 = undefined;
  var_7 = 0.5;

  for(var_8 = 0; var_8 < var_2.size; var_8++) {
    if(var_2[var_8].origin == var_0.origin) {
      var_0 = var_0.previous_struct;
    }
  }

  var_9 = -5;
  var_10 = distance(var_1.origin, var_0.origin);

  foreach(var_12 in var_2) {
    var_13 = 5;
    var_14 = 5;
    var_15 = 0;
    var_16 = undefined;
    var_17 = -5;

    if(var_12 == var_0) {
      continue;
    }

    if(var_12.origin == var_0.origin) {
      continue;
    }

    if(isDefined(var_0.previous_struct) && var_0.previous_struct.origin == var_12.origin) {
      continue;
    }

    if(isDefined(var_0.antepenultimate_struct) && var_0.antepenultimate_struct.origin == var_12.origin) {
      continue;
    }

    if(isDefined(var_12.script_noteworthy) && var_12.script_noteworthy == "deleteme" && var_12.origin != var_1.origin) {
      continue;
    }

    if(!istrue(self.allow_unload_on_path) && isDefined(var_12.script_unload) && var_12.origin != var_1.origin) {
      continue;
    }

    if(istrue(var_12.disabled)) {
      continue;
    }

    if(check_all_previous_in_pathing(var_12, 30)) {
      continue;
    }

    if(istrue(struct_is_personally_disabled(var_12))) {
      continue;
    }

    var_18 = distance(var_0.origin, var_12.origin);

    if(var_12.origin == var_1.origin && var_18 > 1250) {
      continue;
    }

    var_18 = distance(var_1.origin, var_12.origin);
    var_19 = vectortoangles(var_1.origin - var_0.origin);

    if(!isDefined(var_0.angles)) {
      var_0.angles = (0, 0, 0);
    }

    var_20 = scripts\engine\math::get_dot(var_0.origin, var_0.angles, var_12.origin);
    var_20 = scripts\engine\math::normalize_value(-0.5, 0.8, var_20);
    var_21 = scripts\engine\math::get_dot(var_0.origin, var_19, var_12.origin);
    var_21 = scripts\engine\math::normalize_value(-0.8, 0.8, var_21);
    var_22 = scripts\engine\math::normalize_value(0, 2000, var_18);
    var_22 = 1 - var_22;
    var_17 = var_20 + var_21 + var_22;

    if(var_20 < 0.25) {
      var_17 -= 10;
    }

    if(false) {
      thread print_debug_info(var_12, var_21, var_20, var_18, var_17, "find_closest_path_struct");
    }

    if(var_17 > var_5) {
      var_6 = var_12;
      var_5 = var_17;
    }
  }

  if(isDefined(var_6)) {}

  return var_6;
}

function get_best_end_point(var_0, var_1, var_2) {
  if(isDefined(var_1.script_linkto)) {
    var_3 = get_veh_linked_structs(var_1);

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(scripts\engine\utility::is_equal(level.ai_spawn_vehicle_func[var_0].exit_points, var_3[var_4].targetname)) {
        return var_3[var_4];
      }
    }
  }

  var_5 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var_0].exit_points, "targetname");
  var_6 = -5;
  var_7 = undefined;
  var_8 = scripts\engine\utility::get_array_of_closest(var_1.origin, var_5, [var_1]);

  if(isDefined(var_1.angles)) {
    var_2 = var_1.angles;
  }

  foreach(var_10 in var_8) {
    var_11 = scripts\engine\math::get_dot(var_1.origin, var_2, var_10.origin);

    if(var_11 > var_6) {
      if(getdvarint("scr_direct_heli_path_debug", 0)) {
        thread scripts\engine\utility::draw_capsule(var_10.origin, 32, 32, (0, 0, 0), (1, 0, 0), 0, 250);
      }

      var_6 = var_11;
      var_7 = var_10;
    }
  }

  return var_7;
}

function check_all_previous_in_pathing(var_0, var_1) {
  if(!isDefined(self.pathing_array)) {
    return false;
  }

  if(!isDefined(var_1)) {
    var_1 = self.pathing_array.size;
  }

  for(var_2 = 0; var_2 < var_1; var_2++) {
    if(isDefined(self.pathing_array[var_2]) && self.pathing_array[var_2].origin == var_0.origin) {
      return true;
    }
  }

  return false;
}

function struct_is_personally_disabled(var_0) {
  if(!isDefined(self.disabled_nodes)) {
    return false;
  }

  for(var_1 = self.disabled_nodes.size - 1; var_1 >= 0; var_1--) {
    if(self.disabled_nodes[var_1].origin == var_0.origin) {
      return true;
    }
  }

  return false;
}

function step_back_to_last_good_branch(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = [];
  var_5 = 0;
  var_6 = self.pathing_array.size - 1;

  while(var_6 >= 0) {
    if(var_5 > 0) {
      break;
    }

    if(istrue(self.pathing_array[var_6].was_branch)) {
      var_7 = get_veh_linked_structs(self.pathing_array[var_6]);

      for(var_8 = 0; var_8 < var_7.size; var_8++) {
        if(is_this_a_valid_node(var_7[var_8])) {
          var_4 = var_7[var_8];
        }
      }

      if(var_4.size > 0) {
        if(var_4.size == 1) {
          var_9 = var_4[0];
        } else {
          var_9 = calc_best_closest_struct(var_1, var_2, var_5);
        }

        var_6 = var_7;
        var_4 = var_9;

        if(istrue(0)) {}

        break;
      } else {
        disable_this_node_for_us(self.pathing_array[var_5]);
      }
    } else {
      disable_this_node_for_us(self.pathing_array[var_5]);
    }

    var_5--;
  }

  if(isDefined( < error > .previous_struct)) {
    if(isDefined(var_2)) {
      var_1 = var_2;

      if(isDefined(self.pathing_array[var_4 - 1])) {
        var_1.previous_struct = self.pathing_array[var_4 - 1];
      }

      if(isDefined(self.pathing_array[var_4 - 2])) {
        var_1.antepenultimate_struct = self.pathing_array[var_4 - 2];
      }
    } else {
      var_1 = self.pathing_array[0];
    }

    if(isDefined(var_1)) {
      var_1.rewinding_path = 1;
    }
  }

  if(isDefined(var_1)) {}

  return var_1;
}

function is_this_a_valid_node(var_0) {
  if(istrue(var_0.disabled)) {
    return false;
  }

  for(var_1 = self.pathing_array.size - 1; var_1 >= 0; var_1--) {
    if(self.pathing_array[var_1].origin == var_0.origin) {
      return false;
    }
  }

  for(var_1 = self.disabled_nodes.size - 1; var_1 >= 0; var_1--) {
    if(self.disabled_nodes[var_1].origin == var_0.origin) {
      return false;
    }
  }

  return true;
}

function disable_this_node_for_us(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(self.disabled_nodes)) {
    self.disabled_nodes = [];
  }

  if(scripts\engine\utility::array_contains(self.disabled_nodes, var_0)) {
    return;
  }

  self.disabled_nodes[self.disabled_nodes.size] = var_0;

  if(istrue(0)) {}

  level notify("kill_debug_" + var_0.pathing_index);
  self.pathing_array = scripts\engine\utility::array_remove(self.pathing_array, var_0);
}

function create_direct_heli_path(var_0) {
  self endon("death");
  var_1 = create_direct_path_from_landing_point(var_0);
  thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_1);
}

function binding(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_2 + 1;

    if(isDefined(var_0[var_3])) {
      var_4 = vectortoangles(var_0[var_3].origin - var_0[var_2].origin);
      var_0[var_2].angles = (0, var_4[1], 0);
      continue;
    }

    var_4 = vectortoangles(var_1.origin - var_0[var_2].origin);
    var_0[var_2].angles = (0, var_4[1], 0);

    if(!isDefined(var_1.angles) || var_1.angles == (0, 0, 0)) {
      var_1.angles = (0, var_4[1], 0);
    }

    break;
  }
}

function create_direct_path_from_landing_point(var_0) {
  var_1 = create_unique_kvp_string();
  var_2 = var_1;
  var_3 = duplicate_struct(self.spawn_point);
  var_3.targetname = var_1;
  scripts\cp\utility::addtostructarray("targetname", var_3.targetname, var_3);
  var_4 = [];

  if(isDefined(var_3.script_linkto)) {
    var_4 = build_path_from_script_linkTo(var_3, var_0);
  }

  if(var_4.size > 0) {
    binding(var_4, var_3);
    var_5 = self.spawn_point.origin;

    for(var_6 = 0; var_6 < self.riders.size; var_6++) {
      if(isalive(self.riders[var_6]) && isai(self.riders[var_6])) {
        self.riders[var_6] scripts\cp\cp_modular_spawning::set_goal_pos(var_5);
      }
    }

    if(getdvarint("scr_direct_heli_path_debug", 0)) {
      thread scripts\engine\utility::draw_line_for_time(self.veh_spawn_point.origin, var_4[0].origin, 1, 1, 1, 60);
    }

    return var_4[0];
  }

  if(isDefined(var_5.script_linkname)) {
    var_7 = [];
    var_8 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var_2].path_start_points, "script_linkname");

    if(!isDefined(var_8) || var_8.size < 1) {
      var_8 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var_2].path_start_points, "targetname");
    }

    if(!isDefined(var_8) || var_8.size < 1) {
      return;
    }

    var_9 = var_5.script_linkname;

    for(var_6 = 0; var_6 < var_8.size; var_6++) {
      if(scripts\engine\utility::is_equal(var_8[var_6].script_linkto, var_9)) {
        var_10 = [];
        var_11 = duplicate_struct(var_8[var_6]);
        var_11.target = var_4;
        scripts\cp\utility::addtostructarray("target", var_4, var_11);
        var_11.targetname = create_unique_kvp_string();
        scripts\cp\utility::addtostructarray("targetname", var_11.targetname, var_11);
        var_10 = get_linkto_structs_return_to_array(var_11, var_10, var_8);

        if(var_10.size > 0) {
          var_7 = var_10;
        }
      }
    }

    if(var_7.size > 0) {
      var_12 = [];
      var_6 = 0;

      if(var_6 < var_7.size) {
        thread cleanup_unused_paths(var_7[var_6], var_7[var_6][var_7[var_6].size - 1]);
        GscBinSkip0(0x2e, var_12.size, var_7[var_6][var_7[var_6].size - 1]);
      }

      var_13 = scripts\engine\math::get_mid_point(var_5.origin, self.origin);

      if(getdvarint("scr_direct_heli_path_debug", 0)) {
        thread scripts\engine\utility::draw_capsule(self.origin, 32, 32, (0, 0, 0), (0, 1, 0), 0, 250);
        thread scripts\engine\utility::draw_capsule(self.spawn_point.origin, 32, 32, (0, 0, 0), (0, 1, 0), 0, 250);
        thread scripts\engine\utility::draw_capsule(var_13, 32, 32, (0, 0, 0), (1, 1, 0), 0, 250);
      }

      var_14 = scripts\engine\utility::getclosest(var_13, var_12);

      if(getdvarint("scr_direct_heli_path_debug", 0)) {
        thread scripts\engine\utility::draw_line_for_time(var_14.origin, self.origin, 1, 0, 0, 10);
      }

      if(isDefined(var_14.target)) {
        var_15 = var_14 scripts\engine\utility::get_target_array();

        for(var_6 = 0; var_6 < var_15.size; var_6++) {
          if(getdvarint("scr_direct_heli_path_debug", 0)) {
            thread scripts\engine\utility::draw_line_for_time(var_14.origin, var_15[var_6].origin, 1, 0, 0, 12.5);
            thread scripts\engine\utility::draw_capsule(var_15[var_6].origin, 32, 32, (0, 0, 0), (0, 1, 1), 0, 250);
          }

          if(var_6 >= var_15.size - 1) {
            if(getdvarint("scr_direct_heli_path_debug", 0)) {
              thread scripts\engine\utility::draw_line_for_time(var_5.origin, var_15[var_6].origin, 1, 0, 0, 12.5);
            }
          }
        }
      }

      if(getdvarint("scr_direct_heli_path_debug", 0)) {
        thread scripts\engine\utility::draw_capsule(var_14.origin, 32, 32, (0, 0, 0), (0, 1, 1), 0, 250);
      }

      var_14 notify("path_chosen");
      self notify("path_chosen");
      return var_14;
    }

    var_6 = [];
    var_14 = create_entrance_points(var_8);

    if(isDefined(var_14)) {
      var_14.target = var_7;
      scripts\cp\utility::addtostructarray("target", var_7, var_14);
      var_14.targetname = create_unique_kvp_string();
      scripts\cp\utility::addtostructarray("targetname", var_14.targetname, var_14);

      if(getdvarint("scr_direct_heli_path_debug", 0)) {
        thread scripts\engine\utility::draw_capsule(var_14.origin, 32, 32, (0, 0, 0), (0, 1, 1), 0, 250);
        thread scripts\engine\utility::draw_capsule(var_8.origin, 32, 32, (0, 0, 0), (0, 1, 0), 0, 250);
      }

      return var_14;
    }

    return var_8;
  }

  return var_9;
}

function brjugg_initexternalfeatures(var_0) {
  if(isDefined(level.vehicle_builds[var_0])) {
    return istrue(level.vehicle_builds[var_0].brjugg_initfeatures);
  }

  return 0;
}

function build_path_from_script_linkTo(var_0) {
  var_1 = [];
  var_2 = scripts\engine\utility::get_links();
  var_3 = undefined;

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = var_2[var_4];
    var_6 = scripts\engine\utility::getStructArray(var_5, "script_linkname");

    if(isDefined(var_6) && var_6.size > 0) {
      var_6 = scripts\engine\utility::array_randomize(var_6);

      for(var_7 = 0; var_7 < var_6.size; var_7++) {
        var_8 = var_6[var_7];

        if(scripts\engine\utility::is_equal(var_8.targetname, "heli_spawner")) {
          continue;
        }

        if(!brjugg_initexternalfeatures(var_0)) {
          if(scripts\engine\utility::is_equal(var_8.script_noteworthy, "deleteme")) {
            continue;
          }
        }

        var_8 = duplicate_struct(var_8);
        var_1 = var_8;
        var_8.targetname = create_unique_kvp_string();
        scripts\cp\utility::addtostructarray("targetname", var_8.targetname, var_8);

        if(isDefined(var_3)) {
          if(getdvarint("scr_direct_heli_path_debug", 0)) {
            thread scripts\engine\utility::draw_line_for_time(var_3.origin, var_8.origin, 1, 1, 1, 60);
          }

          var_3.target = var_8.targetname;
          scripts\cp\utility::addtostructarray("target", var_3.target, var_3);
        }

        var_3 = var_8;
        break;
      }
    }
  }

  if(var_1.size > 0) {
    var_1[var_1.size - 1].target = self.targetname;
    scripts\cp\utility::addtostructarray("target", var_1[var_1.size - 1].target, var_1[var_1.size - 1]);

    if(getdvarint("scr_direct_heli_path_debug", 0)) {
      thread scripts\engine\utility::draw_line_for_time(var_1[var_1.size - 1].origin, self.origin, 1, 1, 1, 60);
    }
  }

  return var_1;
}

function create_entrance_points(var_0) {
  var_1 = [];
  var_2 = var_0.origin;

  if(scripts\engine\trace::capsule_trace_passed(var_2 + (1500, 0, 1500), var_2, 256, 512, (0, 0, 0), level.characters)) {
    var_3 = spawnStruct();
    var_3.origin = var_2 + (1500, 0, 1500);
    var_1 = var_3;
  }

  if(scripts\engine\trace::capsule_trace_passed(var_2 + (-1500, 0, 1500), var_2, 256, 512, (0, 0, 0), level.characters)) {
    var_3 = spawnStruct();
    var_3.origin = var_2 + (-1500, 0, 1500);
    var_1 = var_3;
  }

  if(scripts\engine\trace::capsule_trace_passed(var_2 + (0, -1500, 1500), var_2, 256, 512, (0, 0, 0), level.characters)) {
    var_3 = spawnStruct();
    var_3.origin = var_2 + (0, -1500, 1500);
    var_1 = var_3;
  }

  if(scripts\engine\trace::capsule_trace_passed(var_2 + (0, 1500, 1500), var_2, 256, 512, (0, 0, 0), level.characters)) {
    var_3 = spawnStruct();
    var_3.origin = var_2 + (0, 1500, 1500);
    var_1 = var_3;
  }

  if(scripts\engine\trace::capsule_trace_passed(var_2 + (-1500, 1500, 1500), var_2, 256, 512, (0, 0, 0), level.characters)) {
    var_3 = spawnStruct();
    var_3.origin = var_2 + (-1500, 1500, 1500);
    var_1 = var_3;
  }

  if(scripts\engine\trace::capsule_trace_passed(var_2 + (-1500, -1500, 1500), var_2, 256, 512, (0, 0, 0), level.characters)) {
    var_3 = spawnStruct();
    var_3.origin = var_2 + (-1500, -1500, 1500);
    var_1 = var_3;
  }

  if(scripts\engine\trace::capsule_trace_passed(var_2 + (1500, -1500, 1500), var_2, 256, 512, (0, 0, 0), level.characters)) {
    var_3 = spawnStruct();
    var_3.origin = var_2 + (1500, -1500, 1500);
    var_1 = var_3;
  }

  if(scripts\engine\trace::capsule_trace_passed(var_2 + (1500, 1500, 1500), var_2, 256, 512, (0, 0, 0), level.characters)) {
    var_3 = spawnStruct();
    var_3.origin = var_2 + (1500, 1500, 1500);
    var_1 = var_3;
  }

  var_4 = scripts\engine\math::get_mid_point(var_0.origin, self.origin);

  if(getdvarint("scr_direct_heli_path_debug", 0)) {
    thread scripts\engine\utility::draw_capsule(var_4, 32, 32, (0, 0, 0), (1, 1, 0), 0, 250);
  }

  var_5 = scripts\engine\utility::getclosest(var_4, var_1);

  for(var_6 = 0; var_6 < var_1.size; var_6++) {
    if(var_1[var_6] != var_5) {
      if(getdvarint("scr_direct_heli_path_debug", 0)) {
        thread scripts\engine\utility::draw_capsule(var_1[var_6].origin, 32, 32, (0, 0, 0), (1, 0, 0), 0, 250);
      }
    }
  }

  return var_5;
}

function get_linkto_structs_return_to_array(var_0, var_1) {
  var_0 = self;

  if(isDefined(self.script_linkname)) {
    var_2 = self.script_linkname;

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      if(var_1[var_3].origin == self.origin) {
        continue;
      }

      if(scripts\engine\utility::is_equal(var_1[var_3].script_linkto, var_2)) {
        var_4 = duplicate_struct(var_1[var_3]);
        var_4.target = self.targetname;
        scripts\cp\utility::addtostructarray("target", var_4.target, var_4);
        var_4.targetname = create_unique_kvp_string();
        scripts\cp\utility::addtostructarray("targetname", var_4.targetname, var_4);
        var_0 = var_4;
        var_0 = get_linkto_structs_return_to_array(var_4, var_0, var_1);
      }
    }
  }

  return var_0;
}

function cleanup_unused_paths(var_0, var_1) {
  var_1 endon("path_chosen");
  self waittill("path_chosen");

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    scripts\engine\utility::deletestruct_ref(var_0[var_2]);
  }
}

function create_heli_path(var_0) {
  self.veh_path = [];
  var_1 = level.next_index;
  level.next_index++;
  var_2 = scripts\engine\utility::random(scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var_0].exit_points, "targetname"));
  var_3 = duplicate_struct(var_2);
  self.end_point = var_3;
  thread begin_searching_for_landing_loc(undefined, var_0, var_1);
  scripts\engine\utility::thread_on_notify_no_endon_death("death", &reset_spawn_point_targetname, self.spawn_point, undefined, self);
}

function begin_searching_for_landing_loc(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("death");
  self notify("begin_searching_for_landing_loc");
  self endon("begin_searching_for_landing_loc");
  self endon("all_passengers_dead");
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;

  for(;;) {
    var_7 = scripts\cp\utility::get_array_of_valid_players();

    if(!var_7.size) {
      wait 1;
      continue;
    }

    var_8 = scripts\cp\utility::get_center_point_of_array(var_7);

    if(!isDefined(var_8)) {
      var_8 = self.origin;
    }

    if(isDefined(self.spawn_point)) {
      if(isDefined(self.spawn_point)) {}

      var_9 = [self.spawn_point];
    } else {
      var_9 = sortbydistance(level.valid_air_vehicle_spawn_points, var_8);
    }

    var_3 = undefined;
    var_10 = 2048;

    for(var_11 = 0; var_11 < var_9.size; var_11++) {
      var_12 = var_9[var_11];

      if(isDefined(var_12.radius) && var_12.radius > var_10) {
        var_10 = int(var_12.radius);
      }

      if(distance2dsquared(var_12.origin, var_8) <= var_10 * var_10) {
        var_3 = var_12;
        break;
      }
    }

    if(isDefined(var_3)) {
      var_10 = 2048;

      if(isDefined(var_3.radius) && var_3.radius > var_10) {
        var_10 = int(var_3.radius);
      }

      if(distance2dsquared(var_3.origin, self.origin) <= var_10 * var_10) {
        level.valid_air_vehicle_spawn_points = scripts\engine\utility::array_remove(level.valid_air_vehicle_spawn_points, var_3);
        var_4 = duplicate_struct(var_3);

        if(!isDefined(var_3.script_noteworthy)) {
          var_4.targetname = "arrived_at_node_" + var_2;
        } else {
          var_4.targetname = var_3.script_noteworthy;
        }

        thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_4);
        self.landing_spot = var_4;
        var_13 = (150, 150, 150);

        if(var_1 == "lbravo_ai_infil") {
          var_13 = (90, 90, 90);
        }

        self.nav_obstacle = createnavobstaclebybounds(var_4.origin, var_13, (0, 0, 0), "axis");
        thread delete_nav_obstacle_on_death();
        break;
      } else {
        var_14 = scripts\engine\utility::array_remove_array(level.path_points[var_1], level.invalid_path_points);

        if(isDefined(var_6)) {
          var_14 = scripts\engine\utility::array_remove(level.path_points[var_1], var_6);
        }

        var_15 = get_best_hover_point(var_8, var_14);

        if(isDefined(var_15)) {
          var_16 = duplicate_struct(var_15);

          if(!isDefined(var_15.script_noteworthy)) {
            var_16.script_noteworthy = "arrived_at_node_" + var_2;
          } else {
            var_16.script_noteworthy = var_15.script_noteworthy;
          }

          var_16.radius = 512;

          if(!isDefined(var_6) || var_15 != var_6) {
            thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_16);
          }

          var_6 = var_15;
          level.invalid_path_points[level.invalid_path_points.size] = var_15;
          var_17 = scripts\engine\utility::ref_143b9(2.5, var_16.script_noteworthy);

          if(var_17 == "timeout") {
            var_6 = undefined;
          }

          scripts\engine\utility::deletestruct_ref(var_16);
          level.invalid_path_points = scripts\engine\utility::array_remove(level.invalid_path_points, var_15);
        } else {
          wait 1;
        }
      }

      continue;
    }

    var_14 = scripts\engine\utility::array_remove_array(level.path_points[var_1], level.invalid_path_points);

    if(isDefined(var_6)) {
      var_14 = scripts\engine\utility::array_remove(level.path_points[var_1], var_6);
    }

    var_15 = get_best_hover_point(var_8, var_14);

    if(isDefined(var_15)) {
      var_16 = duplicate_struct(var_15);

      if(!isDefined(var_15.script_noteworthy)) {
        var_16.script_noteworthy = "arrived_at_node_" + var_2;
      } else {
        var_16.script_noteworthy = var_15.script_noteworthy;
      }

      var_16.radius = 512;

      if(!isDefined(var_6) || var_15 != var_6) {
        thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_16);
      }

      var_6 = var_15;
      level.invalid_path_points[level.invalid_path_points.size] = var_15;
      var_17 = scripts\engine\utility::ref_143b9(2.5, var_16.script_noteworthy);

      if(var_17 == "timeout") {
        var_6 = undefined;
      }

      scripts\engine\utility::deletestruct_ref(var_16);
      level.invalid_path_points = scripts\engine\utility::array_remove(level.invalid_path_points, var_15);
      continue;
    }

    wait 1;
  }

  self waittill("unloaded");

  if(!scripts\engine\utility::array_contains(level.valid_air_vehicle_spawn_points, var_3)) {
    level.valid_air_vehicle_spawn_points[level.valid_air_vehicle_spawn_points.size] = var_3;
  }

  if(isDefined(var_4)) {
    var_5 = get_exit_route(var_4, var_1 + var_2 + "_start");
  }

  var_18 = scripts\engine\utility::random(scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var_1].exit_points, "targetname"));
  var_19 = duplicate_struct(var_18);

  if(isDefined(var_4) && isDefined(var_5) && var_5 != var_4) {
    add_targetname_kvps(var_5, var_4, var_1 + var_2 + "_exit_path");
    add_targetname_kvps(var_19, var_5, var_1 + var_2 + "_end");
    thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_5);
  } else {
    add_targetname_kvps(var_19, var_4, var_1 + var_2 + "_end");
    thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_19);
  }

  delete_nav_obstacle();
}

function create_unique_kvp_string() {
  var_0 = get_next_free_num();
  return "unique_KVP_" + var_0;
}

function get_next_free_num() {
  var_0 = level.next_index;
  level.next_index++;
  return var_0;
}

function avoid_other_helicopters(var_0) {
  self notify("avoid_other_helicopters");
  self endon("avoid_other_helicopters");

  for(;;) {
    var_1 = self.origin + anglesToForward(self.angles) * 256;

    foreach(var_3 in scripts\engine\utility::get_array_of_closest(var_1, level.all_spawned_vehicles, [self], undefined, 512)) {
      if(var_3 == self) {}
    }

    wait 1;
  }
}

function get_best_hover_point(var_0, var_1) {
  var_1 = sortbydistance(var_1, var_0);
  var_2 = -5;
  var_3 = undefined;

  foreach(var_5 in var_1) {
    var_6 = scripts\engine\math::get_dot(self.origin, self.angles, var_5.origin);

    if(var_6 > 0) {
      return var_5;
    }
  }

  return var_3;
}

function get_exit_route(var_0, var_1) {
  var_2 = var_0;

  if(isDefined(var_2.script_linkto)) {
    for(var_3 = 0; isDefined(var_2.script_linkto); var_3++) {
      var_4 = scripts\engine\utility::random(get_veh_linked_structs(var_2));
      var_4 = duplicate_struct(var_4);
      add_targetname_kvps(var_4, var_0, var_1 + "_exit_route_" + var_3);
      var_2 = var_4;
    }
  }

  return var_2;
}

function copy_path_struct_at_new_pos(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.speed = var_1.speed;
  var_2.lookahead = var_1.lookahead;
  return var_2;
}

function add_targetname_kvps(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_0.targetname = var_2;
    scripts\cp\utility::addtostructarray("targetname", var_2, var_0);

    if(isDefined(self.veh_path)) {
      self.veh_path[self.veh_path.size] = var_0;
    }
  }

  if(isDefined(var_1)) {
    var_1.target = var_2;
    scripts\cp\utility::addtostructarray("target", var_2, var_1);

    if(isDefined(self.veh_path)) {
      self.veh_path[self.veh_path.size] = var_1;
      return;
    }

    return;
  }
}

function duplicate_struct(var_0) {
  var_1 = spawnStruct();
  var_1.path_gobbler = 1;
  var_1.origin = var_0.origin;

  if(isDefined(var_0.angles)) {
    var_1.angles = var_0.angles;
  } else {
    var_1.angles = (0, 0, 0);
  }

  if(isDefined(var_0.script_unload)) {
    var_1.script_unload = var_0.script_unload;
  }

  if(isDefined(var_0.lookahead)) {
    var_1.lookahead = var_0.lookahead;
  }

  if(isDefined(var_0.speed)) {
    var_1.speed = var_0.speed;
  } else {
    var_1.speed = 2000;
  }

  if(isDefined(var_0.start_node)) {
    var_1.start_node = var_0.start_node;
  }

  if(isDefined(var_0.script_noteworthy)) {
    var_1.script_noteworthy = var_0.script_noteworthy;
  }

  if(isDefined(var_0.script_linkname)) {
    var_1.script_linkname = var_0.script_linkname;
  }

  if(isDefined(var_0.script_linkto)) {
    var_1.script_linkto = var_0.script_linkto;
  }

  if(isDefined(var_0.script_brake)) {
    var_1.script_brake = var_0.script_brake;
  }

  if(isDefined(var_0.script_pathtype)) {
    var_1.script_pathtype = var_0.script_pathtype;
  }

  if(isDefined(var_0.script_goalyaw)) {
    var_1.script_goalyaw = var_0.script_goalyaw;
  }

  if(isDefined(var_0.script_anglevehicle)) {
    var_1.script_anglevehicle = var_0.script_anglevehicle;
  }

  if(isDefined(var_0.radius)) {
    var_1.radius = var_0.radius;
  } else {
    var_1.radius = 512;
  }

  return var_1;
}

function delete_nav_obstacle() {
  if(isDefined(self.nav_obstacle)) {
    destroynavobstacle(self.nav_obstacle);
  }

  self.spawn_point scripts\cp\cp_modular_spawning::set_default_spawner_values();
}

function attack_player_cooldown(var_0, var_1, var_2, var_3) {
  var_3.ref_12a87 = undefined;
  var_4 = 1;

  if(isDefined(var_2)) {
    if(reflectbolt(var_2) < 1) {
      var_4 = 0;
    }
  }

  if(isDefined(var_0)) {
    ref_13bb7(var_0, 0);
  }

  if(isDefined(var_1)) {
    if(var_4) {
      var_1 scripts\cp\cp_modular_spawning::mounted();
    } else if(isDefined(var_2)) {
      mountstringtodlogenum(var_2, var_1);
    }
  }

  reset_spawn_point_targetname(var_1);

  if(isDefined(var_2)) {
    if(isDefined(var_2.veh_spawn_point)) {
      var_2.veh_spawn_point = undefined;
      return;
    }

    return;
  }
}

function mountstringtodlogenum(var_0) {
  self waittill("death");
  var_0 scripts\cp\cp_modular_spawning::mounted();
}

function delete_nav_obstacle_on_death() {
  self waittill("death");
  delete_nav_obstacle();
}

function reached_infil_node(var_0) {
  iprintlnbold("TEST");
}

function decrement_vehicles_active(var_0, var_1) {
  self notify("decrement_vehicles_active");
  self endon("decrement_vehicles_active");
  level endon("game_ended");
  var_2 = self.veh_spawn_point;
  var_3 = self.spawn_point;
  var_4 = scripts\engine\utility::ref_143ad("death", "unloaded");
  level scripts\engine\utility::delaythread(5, &attack_player_cooldown, var_2, var_3, self, var_1);
  level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
  level.ai_spawn_vehicle_func[var_0].count--;

  if(isDefined(self.veh_spawn_point) && isDefined(self.veh_spawn_point.script_vehiclegroup)) {
    var_5 = scripts\engine\utility::getStructArray(self.veh_spawn_point.script_vehiclegroup, "targetname");

    foreach(var_7 in var_5) {
      var_7.disabled = undefined;
    }
  }

  if(isDefined(self.veh_spawn_point)) {
    self.veh_spawn_point.in_use = undefined;
  }

  self.veh_spawn_point = undefined;
}

function reset_spawn_point_targetname(var_0) {
  if(!isDefined(var_0) && isDefined(self.spawn_point)) {
    var_0 = self.spawn_point;
  }

  if(isDefined(var_0)) {
    var_0.ai_infil_type = undefined;

    if(isDefined(var_0.og_script_function)) {
      var_0.script_function = var_0.og_script_function;
    }

    var_0 = undefined;
  }

  if(isDefined(self) && isDefined(self.veh_path)) {
    foreach(var_2 in self.veh_path) {
      if(!isDefined(var_2)) {
        continue;
      }

      if(isDefined(var_2.script_noteworthy)) {
        remove_from_struct_array("script_noteworthy", var_2.script_noteworthy, var_2);
      }

      if(isDefined(var_2.target)) {
        remove_from_struct_array("target", var_2.target, var_2);
      }

      if(isDefined(var_2.targetname)) {
        remove_from_struct_array("targetname", var_2.targetname, var_2);
      }

      if(isDefined(var_2.script_linkname)) {
        remove_from_struct_array("script_linkname", var_2.script_linkname, var_2);
      }
    }
  }

  if(isDefined(self) && isDefined(self.pathing_array)) {
    foreach(var_2 in self.pathing_array) {
      if(!isDefined(var_2)) {
        continue;
      }

      if(isDefined(var_2.script_noteworthy)) {
        remove_from_struct_array("script_noteworthy", var_2.script_noteworthy, var_2);
      }

      if(isDefined(var_2.target)) {
        remove_from_struct_array("target", var_2.target, var_2);
      }

      if(isDefined(var_2.targetname)) {
        remove_from_struct_array("script_noteworthy", var_2.targetname, var_2);
        remove_from_struct_array("targetname", var_2.targetname, var_2);
      }

      if(isDefined(var_2.script_linkname)) {
        remove_from_struct_array("script_linkname", var_2.script_linkname, var_2);
      }
    }

    return;
  }
}

function remove_from_struct_array(var_0, var_1, var_2) {
  if(isDefined(level.struct_class_names[var_0]) && isDefined(level.struct_class_names[var_0][var_1]) && scripts\engine\utility::array_contains(level.struct_class_names[var_0][var_1], var_2)) {
    level.struct_class_names[var_0][var_1] = scripts\engine\utility::array_remove(level.struct_class_names[var_0][var_1], var_2);
    return;
  }
}

function clear_kill_off_flags(var_0) {
  if(istrue(var_0.skip_clear_kill_off_flag)) {
    return;
  }

  var_0.killofftime = gettime() + 20000;
  var_0.dontkilloff = undefined;
  var_0.canshootinvehicle = undefined;
  var_0.ignoreall = 0;

  if(isDefined(var_0.vehicle) && isDefined(var_0.vehicle.landing_spot)) {
    var_0 scripts\cp\cp_modular_spawning::node_fields_pre_goal(var_0.vehicle.landing_spot);
  }

  if(isDefined(var_0.demeanoroverride) && var_0.demeanoroverride == "casual") {
    var_0 scripts\cp\cp_modular_spawning::set_demeanor_from_unittype("patrol");
    var_0 scripts\cp\cp_modular_spawning::set_goal_pos(var_0.origin);
    var_0 thread scripts\cp\cp_modular_spawning::start_patrol();
    return;
  }

  var_0 scripts\cp\cp_modular_spawning::set_goal_pos(var_0.origin);
  var_1 = var_0 scripts\cp\utility::get_closest_living_player();

  if(isDefined(var_1)) {
    var_0 scripts\cp\cp_modular_spawning::set_goal_pos(var_1.origin);
  }

  var_0 scripts\cp\cp_modular_spawning::enter_combat();
}

function ref_12ae5(var_0, var_1, var_2) {
  if(isDefined(level.ambientgroups[var_0])) {
    if(isarray(level.ambientgroups[var_0])) {
      for(var_3 = 0; var_3 < level.ambientgroups[var_0].size; var_3++) {
        if(!isDefined(level.ambientgroups[var_0][var_3].ref_141b3)) {
          level.ambientgroups[var_0][var_3].ref_141b3 = [];
        }

        level.ambientgroups[var_0][var_3].ref_141b3[var_1] = var_2;
      }

      return;
    }

    if(!isDefined(level.ambientgroups[var_0].ref_141b3)) {
      level.ambientgroups[var_0].ref_141b3 = [];
    }

    level.ambientgroups[var_0].ref_141b3[var_1] = var_2;
    return;
  }
}

function puddle_fx(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    if(!isDefined(var_0.ref_141b3)) {
      return;
    }

    if(!isDefined(var_0.ref_141b3[var_1])) {
      return;
    }

    return var_0.ref_141b3[var_1];
  }

  return undefined;
}

function redlight(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = puddle_fx(var_0, var_1);

    if(!isDefined(var_2)) {
      var_2 = [];
    }

    for(var_3 = 0; var_3 < self.usedpositions.size; var_3++) {
      if(self.usedpositions[var_3]) {
        continue;
      }

      var_4 = 1;

      for(var_5 = 0; var_5 < var_2.size; var_5++) {
        if(var_2[var_5] == var_3) {
          var_4 = 0;
          break;
        }
      }

      if(var_4) {
        return var_3;
      }
    }
  }

  return -1;
}

function ref_1301b(var_0) {
  jumpiffalse(isDefined(var_0)) LOC_00000009;
  return;
}

function allow_infil_after_full_or_timeout(var_0, var_1) {
  self notify("allow_infil_after_full_or_timeout");
  self endon("allow_infil_after_full_or_timeout");
  self endon("death");
  self endon("spawning_done");
  level endon("game_ended");
  var_2 = puzzle_mark_complete(var_0, var_1);

  if(isDefined(level.ai_spawn_vehicle_func[var_1].max_wait_for_infil)) {
    scripts\engine\utility::ref_143b9(level.ai_spawn_vehicle_func[var_1].max_wait_for_infil, "stop_waiting_for_spawns");
  }

  if(isDefined(var_2)) {
    if(self.attachedguys.size == var_2 || isDefined(self.load_queue) && self.load_queue.size == var_2) {
      self notify("spawning_done");
      return;
    } else {
      GscBinSkip4(0x35, "spawning_done");
    }
  }

  if(isDefined(self.load_queue) && self.load_queue.size > 0) {
    self notify("spawning_done");
    return;
  }

  if(self.attachedguys.size < 1) {
    scripts\common\vehicle_code::vehicle_deathcleanup();
    scripts\common\vehicle_paths::delete_riders();
    self notify("delete");
    self delete();
    return;
  }

  self notify("spawning_done");
}

function little_bird_mg_takegunnerturret(var_0, var_1) {}

function register_combined_vehicles(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  [[var_0]](var_1, var_2, var_3);
  thread ref_12ae0(level, var_0, var_1, var_2, var_3, var_4, var_5);
}

function ref_12ae0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  register_vehicle_build(var_6, var_1, var_2, var_3, var_6);
  var_8 = spawnStruct();
  copy_vehicle_build_to_spawnpoint(var_5, var_8);

  if(var_8 scripts\common\vehicle_code::ishelicopter_internal()) {
    add_ai_air_infil(var_5);
    register_vehicle_spawn(var_5, 10, 10, undefined, "heli_spawner", "heli_exit", "heli_infil_path", undefined, &veh_heli_spawn, var_6);
    register_spawner_script_function(var_5, &ai_lbravo_spawn);
  } else {
    add_ai_ground_infil(var_5);
    register_vehicle_spawn(var_5, 10, 10, undefined, "ai_ground_veh_spawner", "ground_veh_exit", "ground_veh_infil_path", undefined, &veh_ground_veh_spawn, var_6);
    register_spawner_script_function(var_5, &ai_ground_veh_spawn);
  }

  ref_12b03(var_6, var_1, var_2, var_3, var_4);
  var_9 = level.vehicle.templates.aianims[var_3];
  var_10 = 0;

  for(var_11 = 0; var_11 < var_9.size; var_11++) {
    if(isDefined(var_9[var_11].idle_anim)) {
      var_10++;
    }
  }

  if(var_10 > 0) {
    register_vehicle_spawn_drivers(var_5, var_10, scripts\engine\utility::random(["aq_pilot_fullbody_1", "aq_pilot_fullbody_2"]));
  }

  if(isDefined(var_4) && getdvarint("scr_create_mp_vehicles", 0)) {
    init_gas_vents(var_4, var_3, var_6);
  }

  level notify(var_5);
}

function init_gas_vents(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(level.vehicle)) {
    return;
  }

  var_3 = level.vehicle_builds[var_2];
  var_3.vehiclename = var_2;
  init_pipe_traps(var_0, var_1, var_2);
  init_petrograd_bsp_patch(var_0, var_1, var_2);
  init_patches(var_0, var_1, var_2);
  init_pipe_room_obj(var_0, var_1, var_2);
}

function init_patches(var_0, var_1, var_2) {
  if(!isDefined(level.vehicle.interact)) {
    return;
  }

  if(!isDefined(level.vehicle.interact.vehicledata)) {
    return;
  }

  if(isDefined(level.vehicle.interact.vehicledata[var_0]) && !isDefined(level.vehicle.interact.vehicledata[var_2])) {
    if(isDefined(level.vehicle.templates.aianims[var_1])) {
      var_3 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle(var_2, 1);

      for(var_4 = 0; var_4 < level.vehicle.templates.aianims[var_1].size; var_4++) {
        var_5 = level.vehicle.templates.aianims[var_1][var_4];
        var_6 = tolower(var_5.sittag);
        var_3.seatenterarrays[var_6] = [];
        var_3.seatenterarrays[var_6][var_3.seatenterarrays[var_6].size] = var_6;
        var_7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(var_2, var_6, 1);

        if(var_4 == 0) {
          var_8 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(var_2, 1);
          var_8.driverseatid = var_6;
        }
      }

      level.vehicle.interact.vehicledata[var_2] = var_3;
      return;
    }

    return;
  }
}

function init_pipe_traps(var_0, var_1, var_2) {
  if(!isDefined(level.vehicle.vehicledata)) {
    return;
  }

  if(isDefined(level.vehicle.vehicledata[var_0]) && !isDefined(level.vehicle.vehicledata[var_2])) {
    var_3 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle(var_2, 1);
    var_3.destroycallback = level.vehicle.vehicledata[var_0].destroycallback;
    level.vehicle.vehicledata[var_2] = var_3;
    return;
  }
}

function init_pipe_room_obj(var_0, var_1, var_2) {
  if(!isDefined(level.vehicle.ref_11fd0.vehicledata)) {
    return;
  }

  if(isDefined(level.vehicle.ref_11fd0.vehicledata[var_0]) && !isDefined(level.vehicle.ref_11fd0.vehicledata[var_2])) {
    var_3 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e(var_2, 1);
    var_4 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e(var_0);
    var_3.brtruck_initdialog = var_4.brtruck_initdialog;
    var_3.id = var_4.id;
    var_3.ref_12da2 = var_4.ref_12da2;
    var_3.seatids = var_4.seatids;
    var_3.ref_14422 = var_4.ref_14422;
    var_3.ref_14423 = var_4.ref_14423;
    var_3.ref_14424 = var_4.ref_14424;
    var_3.ref_14426 = var_4.ref_14426;
    level.vehicle.ref_11fd0.vehicledata[var_2] = var_3;
    return;
  }
}

function init_laser_panel_anims(var_0, var_1) {
  if(!isDefined(level.vehicle.ref_11fd0.vehicledata)) {
    return;
  }

  if(isDefined(level.vehicle.ref_11fd0.vehicledata[var_0])) {
    var_2 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e(var_0, 1);
    var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(var_0);
    var_2.seatids = [];
    var_4 = getarraykeys(var_3.seatdata);

    for(var_5 = 0; var_5 < var_4.size; var_5++) {
      var_2.seatids[var_4[var_5]] = var_1[var_5];
    }

    level.vehicle.ref_11fd0.vehicledata[var_0] = var_2;
    return;
  }
}

function init_petrograd_bsp_patch(var_0, var_1, var_2) {
  if(!isDefined(level.vehicle.occupancy.vehicledata)) {
    return;
  }

  if(isDefined(level.vehicle.occupancy.vehicledata[var_0]) && !isDefined(level.vehicle.occupancy.vehicledata[var_2])) {
    var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(var_2, 1);
    var_3.camera = level.vehicle.occupancy.vehicledata[var_0].camera;
    var_3.damagefeedbackgroupheavy = level.vehicle.occupancy.vehicledata[var_0].damagefeedbackgroupheavy;
    var_3.damagefeedbackgrouplight = level.vehicle.occupancy.vehicledata[var_0].damagefeedbackgrouplight;
    var_3.damagemodifier = level.vehicle.occupancy.vehicledata[var_0].damagemodifier;
    var_3.enterendcallback = level.vehicle.occupancy.vehicledata[var_0].enterendcallback;
    var_3.enterstartcallback = level.vehicle.occupancy.vehicledata[var_0].enterstartcallback;
    var_3.exitdirections = level.vehicle.occupancy.vehicledata[var_0].exitdirections;
    var_3.exitendcallback = level.vehicle.occupancy.vehicledata[var_0].exitendcallback;
    var_3.exitextents = level.vehicle.occupancy.vehicledata[var_0].exitextents;
    var_3.exitoffsets = level.vehicle.occupancy.vehicledata[var_0].exitoffsets;
    var_3.exitstartcallback = level.vehicle.occupancy.vehicledata[var_0].exitstartcallback;
    var_3.restrictions = level.vehicle.occupancy.vehicledata[var_0].restrictions;
    var_3.threatbiasgroup = level.vehicle.occupancy.vehicledata[var_0].threatbiasgroup;
    level.vehicle.occupancy.vehicledata[var_2] = var_3;
    return;
  }
}

function ref_12af9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(level.vehicle)) {
    return;
  }

  if(!isDefined(level.vehicle.occupancy.vehicledata)) {
    return;
  }

  if(!isDefined(!isDefined(level.vehicle.occupancy.vehicledata[var_0]))) {
    return;
  }

  ref_12af8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

function ref_12af8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(var_0, 1);
  var_9 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(var_0, var_1, 1);
  var_9.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_1, var_2);
  var_9.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_9.damagemodifier = 0.5;
  var_9.animtag = var_3;
  var_9.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_9.animtag);
  var_9.exitids = var_4;
  var_8.exitoffsets[var_1] = var_5;
  var_8.exitdirections[var_1] = var_6;
  var_9.spawnpriority = 10;
}

function ref_12afd(var_0) {
  var_1 = ["tag_driver", "tag_passenger", "tag_bed1", "tag_bed2", "tag_bed_center"];
  var_2 = ["tag_seat_0", "tag_seat_2", "tag_seat_4", "tag_seat_4", "tag_seat_4", "tag_seat_3", "tag_seat_5"];
  var_3 = var_1;
  var_4 = [];
  var_5 = (5, 14, 55);
  var_6 = "left";
  var_7 = 10;

  if(isDefined(level.vehicle.interact.vehicledata[var_0]) && isDefined(isDefined(level.vehicle.interact.vehicledata[var_0].seatenterarrays))) {
    var_8 = getarraykeys(level.vehicle.interact.vehicledata[var_0].seatenterarrays);

    for(var_9 = 0; var_9 < level.vehicle.interact.vehicledata[var_0].seatenterarrays.size; var_9++) {
      var_10 = var_8[var_9];
      var_4 = scripts\engine\utility::array_add(var_3, var_10);
      ref_12af9(var_0, var_10, var_1, var_2[var_9], var_4, var_5, var_6, var_7);
    }

    return;
  }
}

function ref_12ae1(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(level.vehicle)) {
    return;
  }

  if(!isDefined(level.vehicle.interact)) {
    return;
  }

  if(!isDefined(level.vehicle.interact.vehicledata)) {
    return;
  }

  if(isDefined(level.vehicle.interact.vehicledata[var_0])) {
    return;
  }

  if(!isarray(var_1)) {
    var_1 = [var_1];
  }

  if(isDefined(level.vehicle.interact.vehicledata[var_0].seatenterarrays)) {
    var_2 = level.vehicle.interact.vehicledata[var_0].seatenterarrays;

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      for(var_4 = 0; var_4 < var_1.size; var_4++) {}
    }

    return;
  }
}

function vehicle_registrations(var_0, var_1, var_2, var_3) {
  scripts\vehicle\mindia8::main("veh8_mil_air_ahotel64_ks", "veh_apache_cp", "script_vehicle_apache");
  scripts\vehicle\mindia8::main("veh8_mil_air_ahotel64_ks_east_mp", "veh_apache_cp", "script_vehicle_apache_east");
  register_vehicle_build("attack_heli_west", "veh8_mil_air_ahotel64_ks", "veh_apache_cp", "script_vehicle_apache");
  register_vehicle_build("attack_heli", "veh8_mil_air_ahotel64_ks_east_mp", "veh_apache_cp", "script_vehicle_apache_east");
  init_jugg_maze("script_vehicle_apache");
  init_jugg_maze("script_vehicle_apache_east");
  thread init_ammo_boxes(level, "lbravo_ambient", "veh8_mil_air_lbravo_personnel_cp", "lbravo_infil_cp");
  register_combined_vehicles(&scripts\vehicle\lbravo::main, "veh8_mil_air_lbravo_personnel_cp", "lbravo_infil_cp", "script_vehicle_iw8_lbravo_ambient", undefined, "lbravo_ambient", "lbravo_ambient");
  register_combined_vehicles(&scripts\vehicle\lbravo::main, "veh8_mil_air_lbravo", "lbravo_infil_cp", "script_vehicle_iw8_lbravo_guns", undefined, "lbravo_guns", "lbravo_guns");
  register_combined_vehicles(&scripts\vehicle\lbravo::main, "veh8_mil_air_lbravo_east", "lbravo_infil_cp", "script_vehicle_iw8_lbravo_guns_east", undefined, "lbravo_guns_east", "lbravo_guns_east");
  register_combined_vehicles(&scripts\vehicle\lbravo::main, "veh8_mil_air_lbravo", "lbravo_infil_cp", "script_vehicle_iw8_lbravo", undefined, "lbravo", "lbravo");
  register_combined_vehicles(&scripts\vehicle\lbravo::main, "veh8_mil_air_lbravo_personnel_cp", "lbravo_infil_cp", "script_vehicle_iw8_lbravo_carrier", undefined, "lbravo_carrier", "lbravo_carrier");
  register_combined_vehicles(&scripts\vehicle\lbravo::main, "veh8_mil_air_lbravo_east", "lbravo_infil_cp", "script_vehicle_iw8_lbravo_carrier_east", undefined, "lbravo_carrier_east", "lbravo_carrier_east");
  register_combined_vehicles(&scripts\vehicle\lbravo::main, "veh8_mil_air_lbravo", "lbravo_infil_cp", "script_vehicle_iw8_lbravo_ai_infil", undefined, "lbravo_ai_infil", "lbravo_ai_infil");
  register_combined_vehicles(&scripts\vehicle\blima::main, "veh8_mil_air_blima_cp", "blima_cp", "script_vehicle_iw8_blima", undefined, "blima_exfil", "blima_exfil");
  register_combined_vehicles(&scripts\vehicle\blima::main, "veh8_mil_air_blima_cp", "blima_cp", "script_vehicle_iw8_blima_cp", undefined, "blima", "blima");
  thread register_spawner_script_function(level, "mindia8_jugg", &ai_mindia8_jugg_spawn, ["juggernaut"]);
  thread ref_12b05(level, "mindia8_jugg", undefined, undefined, undefined, undefined, undefined, undefined, 3, undefined);
  register_combined_vehicles(&scripts\vehicle\mindia8::main, "veh8_mil_air_mindia8", "mindia8_cp", "script_vehicle_iw8_mindia8_closed", undefined, "mindia8_closed", "mindia8_closed");
  register_combined_vehicles(&scripts\vehicle\mindia8::main, "veh8_mil_air_mindia8_open_back_vm_x_cp", "mindia8_cp", "script_vehicle_iw8_mindia8", undefined, "mindia8", "mindia8");
  register_combined_vehicles(&scripts\vehicle\mindia8_jugg::main, "veh8_mil_air_mindia8_open_back_vm_x_cp", "mindia8_cp", "script_vehicle_iw8_mindia8_jugg", undefined, "mindia8_jugg", "mindia8_jugg");
  register_combined_vehicles(&scripts\vehicle\techo::main, "veh8_civ_lnd_techo_physics_cp", "techo_physics_cp", "script_vehicle_iw8_truck_techo_white_physics", undefined, "techo_white", "techo_white");
  register_combined_vehicles(&scripts\vehicle\techo::main, "veh8_civ_lnd_techo_dirty_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_whitedirty_physics", undefined, "techo_whitedirty", "techo_whitedirty");
  register_combined_vehicles(&scripts\vehicle\techo::main, "veh8_civ_lnd_techo_physics_cp", "techo_physics_cp", "script_vehicle_iw8_truck_techo_physics_mp", "technical", "techo_phys", "techo_phys");
  register_combined_vehicles(&scripts\vehicle\techo::main, "veh8_civ_lnd_hindia_physics_mp", "hindia_physics_mp", "script_vehicle_iw8_technical_ai_plr", undefined, "technical_ai_plr", "technical_ai_plr");
  init_laser_panel_anims("techo_phys", []);
  ref_12afd("techo_phys");
  ref_12afd("techo_white");
  register_combined_vehicles(&scripts\vehicle\decho::main, "veh8_civ_lnd_decho_rebel_dirty_milgreen_physics", "decho_physics_sp", "script_vehicle_iw8_decho_rebel_milgreendirty_physics", undefined, "decho_green", "decho_green");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_whitedirty_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_red_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_red_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty_red_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_reddirty_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_black_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_black_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty_black_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_blackdirty_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_tan_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_tan_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty_tan_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_tandirty_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_rusty_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_whiterusty_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_rusty_blue_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_bluerusty_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_rusty_black_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_blackrusty_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_rusty_orange_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_orangerusty_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_rusty_green_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_greenrusty_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_rebel_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_rebel_physics");
  scripts\vehicle\vindia::main("veh8_civ_lnd_techo_rebel_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_rebel_physics");
  register_combined_vehicles(&scripts\vehicle\mkilo23_ai_infil::main, "veh8_mil_lnd_mkilo23_physics_mp", "mkilo_physics_cp", "script_veh8_mil_lnd_mkilo23_physics_ai_infil", undefined, "mkilo23_ai_infil", "mkilo23_ai_infil");
  scripts\vehicle\empty_turret::main("cp_turret_body", "empty_turret", "script_vehicle_empty_turret");
  scripts\cp\cp_remote_tank::main("veh8_mil_lnd_whotel", "veh_pac_sentry_mp", "script_vehicle_mp_collmap_wheelson_west");
  scripts\cp\cp_remote_tank::main("veh8_mil_lnd_whotel_east", "veh_pac_sentry_mp", "script_vehicle_mp_collmap_wheelson_east");

  if(isDefined(level.ref_14208)) {
    [[level.ref_14208]]();
    return;
  }
}

function create_vehicle_builds() {
  if(isDefined(level.script) && (level.script == "cp_chase" || level.script == "cp_blockade" || level.script == "cp_raid_phase1" || level.script == "cp_donetsk")) {
    if(getdvarint("scr_chase_use_cs", 0)) {
      register_vehicle_build("pindia", "veh8_mil_lnd_pindia_physics", "techo_phys_convoy_cp", "script_vehicle_iw8_truck_pindia_black");
    } else {
      register_vehicle_build("pindia", "veh8_mil_lnd_pindia", "truck", "script_vehicle_iw8_truck_pindia_white");
    }
  } else {
    register_vehicle_build("pindia_node", "veh8_mil_lnd_pindia", "truck", "script_vehicle_iw8_truck_pindia_white");
    register_vehicle_build("pindia", "veh8_mil_lnd_pindia_physics", "techo_phys_convoy_cp", "script_vehicle_iw8_truck_pindia_black");
  }

  register_vehicle_build("pindia_ai_plr", "veh8_mil_lnd_pindia_1seat_red_physics_mp", "hindia_physics_mp", "script_vehicle_iw8_truck_pindia_1seat_red_physics", "hoopty");
  register_vehicle_build("technical_ai_plr", "veh8_civ_lnd_hindia_physics_mp", "hindia_physics_mp", "script_vehicle_iw8_technical_ai_plr", "technical");
  register_vehicle_build("mkilo23_physics", "veh8_mil_lnd_mkilo23_physics", "mkilo23_physics", "script_vehicle_iw8_truck_mkilo23_physics");
  register_vehicle_build("mkilo23_ai_infil", "veh8_mil_lnd_mkilo23_physics_mp", "mkilo23_physics", "script_veh8_mil_lnd_mkilo23_physics_ai_infil");
  register_vehicle_build("vindia_a2", "veh8_mil_lnd_vindia_a2_physics", "vindia_physics_sp", "script_vehicle_iw8_vindia_a2");
  register_vehicle_build("decho", "veh8_civ_lnd_decho_physics", "decho_physics_sp", "script_vehicle_iw8_decho_white_physics");
}

function setup_player_vehicles(var_0, var_1, var_2) {
  var_3 = "-";
  var_4 = "&";
  var_5 = "_";
  var_6 = "devgui_cmd \"CP Players:2 / " + var_1 + " / Spawn Vehicle / Little Bird\" \"set scr_vehicle_debug Spawn" + var_5 + var_3 + var_2 + var_3 + var_4 + "little_bird\" \n";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "devgui_cmd \"CP Players:2 / " + var_1 + " / Spawn Vehicle / Light Tank\" \"set scr_vehicle_debug Spawn" + var_5 + var_3 + var_2 + var_3 + var_4 + "light_tank\" \n";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "devgui_cmd \"CP Players:2 / " + var_1 + " / Spawn Vehicle / Technical\" \"set scr_vehicle_debug Spawn" + var_5 + var_3 + var_2 + var_3 + var_4 + "technical\" \n";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "devgui_cmd \"CP Players:2 / " + var_1 + " / Spawn Vehicle / Tac Rover\" \"set scr_vehicle_debug Spawn" + var_5 + var_3 + var_2 + var_3 + var_4 + "tac_rover\" \n";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "devgui_cmd \"CP Players:2 / " + var_1 + " / Spawn Vehicle / Hoopty\" \"set scr_vehicle_debug Spawn" + var_5 + var_3 + var_2 + var_3 + var_4 + "hoopty\" \n";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "devgui_cmd \"CP Players:2 / " + var_1 + " / Spawn Vehicle / APC\" \"set scr_vehicle_debug Spawn" + var_5 + var_3 + var_2 + var_3 + var_4 + "apc\" \n";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "devgui_cmd \"CP Players:2 / " + var_1 + " / Spawn Vehicle / APC RUS\" \"set scr_vehicle_debug Spawn" + var_5 + var_3 + var_2 + var_3 + var_4 + "apc_russian\" \n";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "devgui_cmd \"CP Players:2 / " + var_1 + " / Spawn Vehicle / ATV\" \"set scr_vehicle_debug Spawn" + var_5 + var_3 + var_2 + var_3 + var_4 + "atv\" \n";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "devgui_cmd \"CP Players:2 / " + var_1 + " / Spawn Vehicle / Cargo Truck\" \"set scr_vehicle_debug Spawn" + var_5 + var_3 + var_2 + var_3 + var_4 + "cargo_truck\" \n";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "devgui_cmd \"CP Players:2 / " + var_1 + " / Spawn Vehicle / Cop Car\" \"set scr_vehicle_debug Spawn" + var_5 + var_3 + var_2 + var_3 + var_4 + "cop_car\" \n";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "devgui_cmd \"CP Players:2 / " + var_1 + " / Spawn Vehicle / Hoopty Truck\" \"set scr_vehicle_debug Spawn" + var_5 + var_3 + var_2 + var_3 + var_4 + "hoopty_truck\" \n";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "devgui_cmd \"CP Players:2 / " + var_1 + " / Spawn Vehicle / Jeep\" \"set scr_vehicle_debug Spawn" + var_5 + var_3 + var_2 + var_3 + var_4 + "jeep\" \n";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "devgui_cmd \"CP Players:2 / " + var_1 + " / Spawn Vehicle / Large Transport\" \"set scr_vehicle_debug Spawn" + var_5 + var_3 + var_2 + var_3 + var_4 + "large_transport\" \n";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "devgui_cmd \"CP Players:2 / " + var_1 + " / Spawn Vehicle / Med Transport\" \"set scr_vehicle_debug Spawn" + var_5 + var_3 + var_2 + var_3 + var_4 + "med_transport\" \n";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "devgui_cmd \"CP Players:2 / " + var_1 + " / Spawn Vehicle / Pickup Truck\" \"set scr_vehicle_debug Spawn" + var_5 + var_3 + var_2 + var_3 + var_4 + "pickup_truck\" \n";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "devgui_cmd \"CP Players:2 / " + var_1 + " / Spawn Vehicle / Van\" \"set scr_vehicle_debug Spawn" + var_5 + var_3 + var_2 + var_3 + var_4 + "van\" \n";
  scripts\cp\utility::addentrytodevgui(var_6);
}

function cp_vehicle_debug(var_0) {
  var_1 = strtok(var_0, "_");
  var_2 = strtok(var_0, "-");
  var_3 = strtok(var_0, "&");
  var_4 = undefined;

  if(var_2.size > 0) {
    var_5 = int(var_2[0]);
    var_4 = level.players[var_5];
  }

  switch (var_1[0]) {
    case "Spawn":
    case "spawn":
      if(isDefined(var_3) && var_3.size > 1) {
        scripts\engine\utility::script_func(var_3[1], var_4);
      }

      break;
    default:
      break;
  }
}

function spawn_enemy_chopper(var_0, var_1, var_2) {
  var_3 = level.ai_spawn_vehicle_func[var_2];
  var_4 = get_vehicle_spawn_points(var_3, var_1);

  if(isDefined(level.cashtypes)) {
    return false;
  }

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    if(isDefined(var_0.valid_vehicles)) {
      if(isDefined(var_0.valid_vehicles["attack_heli"])) {
        if(var_0.valid_vehicles["attack_heli"] == 0) {
          return false;
        }
      }
    }

    if(getdvarint("scr_survival_disable_bossheli", 0) > 0) {
      return false;
    }
  }

  if(var_4.size > 0) {
    foreach(var_6 in var_4) {
      if(istrue(var_6.in_use)) {
        continue;
      }

      copy_vehicle_build_to_spawnpoint(var_2, var_6);
      var_7 = vectortoangles(var_1.origin - var_6.origin);
      var_6.angles = (0, var_7[1], 0);
      var_8 = scripts\common\vehicle::vehicle_spawn(var_6);

      if(isDefined(var_8)) {
        var_6.in_use = 1;
        var_8.veh_spawn_point = var_6;
        level.cashtypes = var_8;
        stringtovec3(var_8, var_1, var_0, var_6, var_2);
        var_0.vehicle = undefined;
        var_1.vehicle = undefined;
        var_1.veh_spawn_point = undefined;
        var_0.ref_12a87 = undefined;
        init_helicopter(var_8, var_0, var_2);
        var_8.vehicle_forcerocketdeath = undefined;
        var_8.death_fx_on_self = 1;
        var_8.circle_radius = 2500;
        var_8 scripts\cp\helicopter\cp_helicopter::heli_mg_create("veh8_mil_air_ahotel64_turret_wm", "apache_turret_cp", "tag_turret");
        var_8 thread scripts\cp\helicopter\cp_helicopter::setup_pilot(1, undefined, undefined, undefined);
        var_8 setmaxpitchroll(15, 15);
        var_8.health_remaining = 2250;
        level thread scripts\cp\helicopter\cp_helicopter::heli_think_default(var_8);
        var_8 sethoverparams(25, 15, 10);
        var_8.vehicletype = "apache";
        var_8.headicon = deleteheadicon(var_8);
        setheadiconfriendlyimage(var_8.headicon, "hud_icon_head_equipment_enemy");
        setheadiconsnaptoedges(var_8.headicon, 12000);
        setheadiconmaxdistance(var_8.headicon, 1500);
        addclienttoheadiconmask(var_8.headicon, 10);
        setheadicondrawthroughgeo(var_8.headicon, 1);
        var_8.bullets_can_damage = 1;
        var_8.needs_to_evade = 0;
        thread ref_142d6();

        if(scripts\cp\utility::turn_off_sniper_laser()) {
          return true;
        }
      }
    }
  }

  return false;
}

function ref_142d6() {
  var_0 = ["dx_cps_kama_callout_helicopter_attacking_10", "dx_cps_kama_callout_helicopter_attacking_20", "dx_cps_lass_callout_helicopter_attacking_10", "dx_cps_lass_callout_helicopter_attacking_20"];
  level scripts\cp\cp_vo::try_to_play_vo_on_team(scripts\engine\utility::random(var_0), "allies");
}

function ref_13079(var_0) {
  if(isDefined(self.healthbuffer)) {
    self.health = self.healthbuffer + var_0;
    self.maxhealth = self.health;
    return;
  }

  self.health = var_0;
  self.maxhealth = self.health;
}

function init_helicopter(var_0, var_1) {
  self.isheli = 1;
  self.currentdestindex = gettime();

  switch (var_1) {
    case "mindia8_closed":
    case "blima_exfil":
    case "blima":
    case "mindia8_jugg":
    case "mindia8":
      ref_13079(5000);
      break;
    case "attack_heli":
      ref_13079(50000);
      break;
    default:
      ref_13079(1250);
      break;
  }

  thread is_done_speaking();
  self.team = "axis";

  if(isDefined(self.script_team)) {
    self.team = self.script_team;
  }

  self setvehicleteam(self.team);

  if(isDefined(var_1) && var_1 == "lbravo_carrier") {
    thread waiting_for_disable();
  }

  if(self.team == "axis") {
    level thread scripts\cp\cp_weapon::add_to_special_lockon_target_list(self);
    thread smoke_wheelson_chosen_spawn();
  }

  self.dontdisconnectpaths = 1;
  self.vehicle_forcerocketdeath = 1;
  self.death_fx_on_self = 1;

  if(isDefined(var_1)) {
    level.ai_spawn_vehicle_func[var_1].count++;

    if(isDefined(var_0)) {
      scripts\cp\cp_modular_spawning::add_to_module_vehicles_list(var_0, var_1);
    }
  }

  level.all_spawned_vehicles[level.all_spawned_vehicles.size] = self;
}

function smoke_wheelson_chosen_spawn() {
  level endon("game_ended");
  scripts\engine\utility::ref_143a5("death", "deleting_vehicle");
  level thread scripts\cp\cp_weapon::remove_from_special_lockon_target_list(self);
}

function is_done_speaking() {
  self endon("death");

  for(;;) {
    var_0 = scripts\common\utility::playersnear(self.origin, 256);

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      if(var_0[var_1].origin[2] > self.origin[2]) {
        if(var_0[var_1].origin[2] - self.origin[2] <= 32 && var_0[var_1] isonground()) {
          var_0[var_1] dodamage(var_0[var_1].health + 1000, self.origin, self, self, "MOD_CRUSH");
        }
      }
    }

    wait 0.25;
  }
}

function waiting_for_disable() {
  self endon("death");
  self endon("unloaded");
  self notify("landing_damage_watcher");
  self endon("landing_damage_watcher");
  var_0 = 256;
  var_1 = 80;
  var_2 = 36;

  while(isDefined(self)) {
    if(isDefined(self.currentdestindex) && gettime() - self.currentdestindex < 5000) {
      wait 0.05;
      continue;
    }

    var_3 = self.origin + (0, 0, -140) + anglesToForward(self.angles) * 24;

    if(self.team == "axis") {
      foreach(var_5 in level.players) {
        if(isDefined(var_5) && isalive(var_5) && truckwarspawnlocations(var_5.origin, var_3, var_1, var_2)) {
          var_5 dodamage(var_5.health + 1000, self.origin, self, self, "MOD_CRUSH");
        }
      }
    }

    var_7 = tablesort(var_3 - (0, 0, 200), 400, 400);

    if(!isDefined(var_7) || var_7.size == 0) {
      wait 0.25;
      continue;
    }

    var_7 = sortbydistance(var_7, self.origin);
    var_8 = undefined;

    for(var_9 = 0; var_9 < var_7.size; var_9++) {
      var_10 = var_7[var_9];

      if(!isDefined(var_10) || var_10 == self) {
        continue;
      }

      if(var_10 vehicle_getspeed() > 1) {
        continue;
      }

      if(isent(var_10) && truckwarspawnlocations(var_10.origin, var_3, var_0 * 1.5, var_2)) {
        var_8 = var_10;
        break;
      }
    }

    if(!isDefined(var_8)) {
      wait 0.05;
      continue;
    }

    var_11 = var_8;
    var_12 = 0;

    if(isDefined(var_11.vehiclename) && var_11.vehiclename == "little_bird") {
      var_12 = 1;
    }

    if(isDefined(var_11.vehiclename) && var_11.vehiclename == "little_bird_mg") {
      var_12 = 1;
    }

    if(isDefined(var_11.stop_all_ascend_anims) && var_11.stop_all_ascend_anims == "lbravo_carrier") {
      var_12 = 1;
    }

    if(isDefined(self.owner) && isPlayer(self.owner) && isDefined(var_11.owner) && isPlayer(var_11.owner)) {
      var_12 = 0;
    }

    if(triggerexitfunc() && triggerexitfunc(var_11)) {
      var_12 = 0;
    }

    if(var_12) {
      var_13 = var_11.health + 1000;
      var_11 notify("landing_collision_damage", var_13, self);
      var_11.load_sequence_4_vfx = 1;
      var_11 dodamage(var_13, self.origin, undefined, undefined, "MOD_CRUSH");
    }

    wait 0.05;
  }
}

function truckwarspawnlocations(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::distance_2d_squared(var_0, var_1) > squared(var_2)) {
    return false;
  }

  if(var_0[2] < var_1[2]) {
    return false;
  }

  if(var_0[2] > var_1[2] + var_3) {
    return false;
  }

  return true;
}

function triggerexitfunc() {
  if(isDefined(self.owner) && isPlayer(self.owner)) {
    return true;
  }

  if(isDefined(self.occupants)) {
    foreach(var_1 in self.occupants) {
      if(isDefined(var_1) && isPlayer(var_1) && isalive(var_1)) {
        return true;
      }
    }
  }

  return false;
}

function laser_trap_triggers(var_0) {
  self endon("death");
  self waittill("unloaded");

  if(isDefined(var_0)) {
    var_0 delete();
    return;
  }
}

function super_onspawned(var_0, var_1) {
  self.custom_death_script = &internal_isplayerindanger_think;

  switch (var_1) {
    case "techo_whitedirty":
    case "techo_white":
    case "technical_ai_plr":
    case "techo_phys":
      ref_13079(2500);
      break;
    default:
      ref_13079(1250);
      break;
  }

  self.vehicle_skipdeathcrash = 1;
  self.team = "axis";
  self setvehicleteam(self.team);

  if(isDefined(var_1)) {
    level.ai_spawn_vehicle_func[var_1].count++;

    if(isDefined(var_0)) {
      scripts\cp\cp_modular_spawning::add_to_module_vehicles_list(var_0, var_1);
    }
  }

  thread watch_for_vehicle_stuck();
  level.all_spawned_vehicles[level.all_spawned_vehicles.size] = self;
}

function internal_isplayerindanger_think() {
  self vehicle_setspeedimmediate(0, 1, 1);

  if(isDefined(self.riders) && self.riders.size > 0) {
    foreach(var_1 in self.riders) {
      if(!isDefined(var_1) || !isalive(var_1)) {
        continue;
      }

      if(isDefined(var_1._blackboard) && isDefined(var_1._blackboard.chosenvehicleanimpos)) {
        if(istrue(var_1._blackboard.chosenvehicleanimpos.isincircle)) {
          var_1._blackboard.chosenvehicleanimpos.vehicle_death_ragdoll = 1;
        }
      }
    }

    return;
  }
}

function heli_think_default() {
  thread heli_damagemonitor();
  thread heli_check_players();
  thread heli_move();
  thread engage_target_think();
  thread rumble_nearby_players();
}

function heli_damagemonitor(var_0, var_1) {
  self endon("death");
  var_2 = 0;
  self.health = 1000000;
  jumpiftrue(isDefined(var_1)) LOC_00000022;
  var_1 = 2500;

  for(;;) {
    self waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16);
    self.health = 1000000;

    if(isDefined(var_4) && var_4 == self) {
      continue;
    }

    if(isDefined(var_16) && isDefined(var_16.owner) && var_16.owner == self) {
      continue;
    }

    if(isDefined(var_4) && isDefined(self.minigun) && var_4 == self.minigun) {
      continue;
    }

    if(scripts\cp\helicopter\cp_helicopter::is_snipe_kill(var_4, var_6, var_12)) {
      var_2++;

      if(var_2 == 1) {
        if(isDefined(self.headicon)) {
          setheadiconimage(self.headicon);
        }

        self.headicon = undefined;
        var_4 scripts\cp\cp_achievement::scriptable_enginedamaged();
        var_4 thread scripts\cp_mp\xmike109::givemidmatchaward("kill_ss_chopper_support");
        var_4 scripts\cp\cp_persistence::give_player_currency(500, "large");
        playFX(level._effect["vfx_blima_explosion"], self.origin);
        var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical", 1);
        level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
        self.minigun delete();

        if(isDefined(self.pilot)) {
          self.pilot delete();
        }

        self notify("deleting_vehicle");
        self delete();
        return;
      }

      var_4.lasthitmarkertime = undefined;
      var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical", 1);
      self.needs_to_evade = 1;
      self vehicle_setspeed(100, 100, 100);
      self setvehgoalpos(self.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0), 0);
      self notify("needs_to_evade");
      continue;
    }

    if(!isexplosivedamagemod(var_7)) {
      var_4.lasthitmarkertime = undefined;
      var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitarmorheavy");
    } else {
      var_4.lasthitmarkertime = undefined;
      var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical");

      if(isDefined(var_12) && isDefined(var_12.basename)) {
        switch (var_12.basename) {
          case "iw8_thermite_mp":
            break;
          case "emp_drone_player_mp":
            var_3 = 1400;
            break;
          default:
            break;
        }
      } else if(var_3 < 700) {
        var_3 = 700;
      }

      if(isDefined(var_0) && scripts\engine\utility::flag_exist(var_0) && !scripts\engine\utility::flag(var_0)) {
        scripts\engine\utility::flag_set(var_0);
      } else {
        if(!istrue(self.needs_to_evade)) {
          self.needs_to_evade = 1;
        }

        self notify("needs_to_evade");
        self vehicle_setspeed(100, 100, 100);
        self setvehgoalpos(self.origin + (randomintrange(-850, 850), randomintrange(-850, 850), 0), 0);
      }
    }

    self.health_remaining -= var_3;

    if(self.health_remaining <= var_1 * 0.25 && !isDefined(self.deathfx)) {
      playFX(level._effect["aerial_explosion"], self.origin);
      self setscriptablepartstate("body_damage_heavy", "on");
      self.deathfx = 1;
    } else if(self.health_remaining <= var_1 * 0.5 && !isDefined(self.deathfx1)) {
      self setscriptablepartstate("body_damage_medium", "on");
      playFX(level._effect["aerial_explosion"], self.origin);
      self.deathfx1 = 1;
    } else if(self.health_remaining <= var_1 * 0.75 && !isDefined(self.deathfx2)) {
      self setscriptablepartstate("body_damage_light", "on");
      self.deathfx2 = 1;
    }

    if(self.health_remaining <= 0) {
      if(isDefined(self.headicon)) {
        setheadiconimage(self.headicon);
      }

      self.headicon = undefined;

      if(isDefined(var_12) && issubstr(var_12.basename, "molotov")) {
        if(isDefined(var_4) && isPlayer(var_4)) {
          var_4 thread scripts\cp\cp_achievement::scriptable_setups();
        }
      }

      if(isDefined(var_4) && isPlayer(var_4)) {
        var_4 thread scripts\cp_mp\xmike109::givemidmatchaward("kill_ss_chopper_support");
        var_4 scripts\cp\cp_persistence::give_player_currency(500, "large");
      }

      playFX(level._effect["vfx_blima_explosion"], self.origin);
      var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical", 1);
      level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
      self.minigun delete();

      if(isDefined(self.pilot)) {
        self.pilot delete();
      }

      self notify("deleting_vehicle");
      self delete();
      continue;
    }

    if(isDefined(var_4) && isPlayer(var_4)) {
      var_4 scripts\cp\cp_persistence::give_player_currency(10, "large");
    }
  }
}

function init_jugg_maze(var_0) {
  level.vtclassname = var_0;
  scripts\common\vehicle_build::build_rocket_deathfx("vfx/core/expl/aerial_explosion_heli_large.vfx", "tag_origin", undefined, undefined, undefined, 0, 0, 0);
}

function crash_deathfx() {
  self waittill("vehicle_deathComplete", var_0);
  playFX(level._effect["vfx_blima_explosion"], var_0 + (0, 0, -100));
  playsoundatpos(var_0, "cp_br_syrk_chopper_crash");
}

function get_helicopter_path_positions(var_0) {
  self.path_positions = [];
  var_1 = 12;
  var_2 = 2048;
  var_3 = 360 / var_1;
  var_4 = self.origin;
  self.flight_pos = undefined;
  self.flight_pos_dot = undefined;

  if(isDefined(var_0)) {
    if(isvector(var_0)) {
      var_5 = var_0;
    } else {
      var_5 = var_1.origin;
    }
  } else {
    var_5 = scripts\cp\utility::get_center_point_of_array(level.players);
  }

  for(var_6 = 0; var_6 < var_3; var_6++) {
    var_7 = var_5 * var_6;
    var_8 = cos(var_7) * var_4;
    var_9 = sin(var_7) * var_4;
    var_10 = var_5[0] + var_8;
    var_11 = var_5[1] + var_9;
    var_12 = var_5[2];

    if(validate_pos((var_10, var_11, var_12), var_5)) {
      self.path_positions[self.path_positions.size] = (var_10, var_11, var_12);
    }
  }
}

function draw_capsule_until_notifies(var_0, var_1) {
  self endon("death");
  self endon("near_goal");

  for(;;) {
    thread scripts\engine\utility::draw_capsule(var_0, 32, 32, (0, 0, 0), var_1, 0, 1);
    waitframe();
  }
}

function validate_pos(var_0, var_1) {
  if(isDefined(var_1)) {
    var_0 = (var_0[0], var_0[1], var_1[2] + 1500);
  }

  if(isDefined(level.heli_triggers) && level.heli_triggers.size > 0) {
    var_2 = level.heli_triggers;

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(!isDefined(var_2[var_3])) {
        level.heli_triggers = scripts\engine\utility::array_remove(level.heli_triggers, var_2[var_3]);
        continue;
      }

      if(isDefined(self.move_trigger) && self.move_trigger == var_2[var_3]) {
        continue;
      }

      if(ispointinvolume(var_0, var_2[var_3])) {
        return 0;
      }
    }
  }

  if(scripts\engine\trace::capsule_trace_passed(self.origin, var_0, 256, 512, self.angles, self)) {
    if(isDefined(var_1)) {
      var_4 = var_0 - self.origin;

      if(isvector(var_1)) {
        var_5 = vectortoangles(var_1 - self.origin);
      } else if(isDefined(var_4.velo_forward)) {
        var_5 = vectortoangles(var_4.velo_forward - self.origin);
      } else {
        var_5 = vectortoangles(var_5.origin - self.origin);
      }

      var_6 = anglesToForward(var_5);
      var_7 = vectordot(var_5, var_6);

      if(isDefined(self.flight_pos)) {
        if(var_7 > self.flight_pos_dot) {
          self.flight_pos_dot = var_7;
          self.flight_pos = var_4;
        }
      } else {
        self.flight_pos_dot = var_7;
        self.flight_pos = var_4;
      }

      if(var_7 > 0.3) {
        return 1;
      }

      return 0;
    }

    if(scripts\engine\math::is_point_in_front(var_4)) {
      return 1;
    }

    return 0;
  }

  return 0;
}

function point_is_towards_target(var_0, var_1) {
  var_2 = var_0 - self.origin;
  var_3 = vectortoangles(var_1.origin - self.origin);
  var_4 = anglesToForward(var_3);
  var_5 = vectordot(var_2, var_4);
  return var_5 > 0.3;
}

function update_every_frame() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    if(isDefined(self.update_state)) {
      switch (self.update_state) {
        default:
          break;
      }
    }

    waitframe();
  }
}

function heli_move() {
  level endon("game_ended");
  self endon("death");
  var_0 = self.origin[2];
  self.chopper_height = var_0;
  var_1 = 0;
  var_2 = 5;
  self vehicle_setspeed(75, 30);

  for(;;) {
    if(istrue(self.needs_to_evade)) {
      heli_evade((self.origin[0], self.origin[1], self.chopper_height));
      continue;
    }

    if(!isDefined(self.best_target)) {
      heli_go_search();
      continue;
    }

    if(should_move_to_target(self.minigun, self.best_target)) {
      heli_move_to_target(self.best_target);
      continue;
    }

    wait 1;
  }
}

function should_move_to_target(var_0, var_1) {
  var_2 = 6250000;

  if(isDefined(self.should_move_to_target_dist)) {
    var_2 = self.should_move_to_target_dist * self.should_move_to_target_dist;
  }

  if(istrue(self.landed)) {
    self.landed = undefined;
    return true;
  }

  if(distance2dsquared(var_0.origin, var_1.origin) > var_2 || isDefined(self.gotopos) && distance2dsquared(var_0.origin, self.gotopos) > var_2) {
    return true;
  }

  return false;
}

function heli_move_to_target(var_0) {
  self endon("death");
  self cleartargetyaw();
  self cleargoalyaw();
  self setlookatent(var_0);

  if(isDefined(self.best_target)) {
    get_helicopter_path_positions(self.best_target);
  } else {
    get_helicopter_path_positions();
  }

  var_1 = undefined;

  if(isDefined(self.flight_pos)) {
    var_1 = self.flight_pos;
  } else if(isDefined(self.path_positions) && self.path_positions.size > 0) {
    var_1 = scripts\engine\utility::random(self.path_positions);
  }

  if(isDefined(var_1)) {
    self setneargoalnotifydist(750);

    if(distance2dsquared(self.origin, var_1) > 1440000) {
      self vehicle_setspeed(50, 30, 30);
      self setvehgoalpos(var_1, 1);
    } else {
      self vehicle_setspeed(15, 12, 12);
      self setvehgoalpos(var_1, 0);
    }

    scripts\engine\utility::ref_143b9(15, "near_goal");
  }

  wait 5;
}

function heli_evade(var_0) {
  self notify("taking_evasive_actions");
  self endon("taking_evasive_actions");
  self endon("death");
  var_1 = 5000;
  get_helicopter_path_positions();
  var_2 = self.path_positions;

  if(isDefined(var_2) && var_2.size > 0) {
    var_3 = 0;
    var_4 = var_2[0];
    self cleargoalyaw();
    self cleartargetyaw();
    self clearlookatent();

    foreach(var_8, var_6 in var_2) {
      if(isvector(var_6)) {
        var_7 = var_6;
      } else {
        var_7 = var_6.origin;
      }

      if(scripts\engine\utility::within_fov(self.origin, self.angles, var_7, cos(25))) {
        var_4 = var_6;
        var_3 = var_8;
        break;
      }
    }

    if(isvector(var_2[var_3])) {
      self setvehgoalpos(var_2[var_3], 0);
    } else {
      self setvehgoalpos(var_2[var_3].origin, 0);
    }

    var_9 = 1500;
    var_9 *= var_1 / 5000;
    var_10 = 100;
    var_10 *= var_1 / 5000;
    self setneargoalnotifydist(1500);
    self vehicle_setspeed(100, 50, 50);
    var_11 = 0;
    var_8 = var_3 + 1;
    var_12 = randomint(4);

    while(var_11 < var_2.size - 1) {
      if(var_8 >= var_2.size) {
        var_8 = 0;
      }

      if(isvector(var_2[var_8])) {
        self setvehgoalpos(var_2[var_8], 0);
      } else {
        self setvehgoalpos(var_2[var_8].origin, 0);
      }

      self waittill("near_goal");
      var_11++;
      var_8++;

      if(var_11 == var_12) {
        break;
      }
    }
  }

  self.needs_to_evade = 0;
}

function rumble_nearby_players() {
  self endon("death");

  for(;;) {
    playrumbleonposition("cp_chopper_rumble", self.origin);
    wait 0.1;
  }
}

function circle_around_target() {
  get_helicopter_path_positions();
}

function heli_check_players() {
  self endon("death");
  self.best_target = undefined;
  var_0 = 5;
  var_1 = 0;

  for(;;) {
    var_2 = heli_get_target();

    if(isDefined(var_2)) {
      var_1 = 0;
      self notify("target_found");
      self.best_target = var_2;
    } else {
      self notify("target_lost");
      var_1 += 0.25;

      if(var_1 >= var_0) {
        var_1 = 0;
        self.best_target = undefined;
      }
    }

    wait 0.25;
  }
}

function engage_target_think() {
  level endon("game_ended");
  self notify("engage_target_think");
  self endon("engage_target_think");
  self endon("death");
  self.minigun setmode("manual");
  self.nextfiretime = gettime() + 2000;

  for(;;) {
    while(isDefined(self.best_target)) {
      self sethoverparams(150, 35, 35);

      if(istrue(self.has_rockets)) {
        wait 2;

        if(istrue(self.rockets_ready)) {
          scripts\cp\helicopter\cp_helicopter::hover_and_shoot_rockets(self.best_target);
        }
      } else {
        self.minigun settargetentity(self.best_target, (0, 0, 40));
        var_0 = scripts\engine\utility::waittill_any_ents_or_timeout_return(3, self.minigun, "turret_on_target");
        scripts\cp\helicopter\cp_helicopter::shoot_at_target();
      }

      self notify("target_engaged");
      self sethoverparams(0, 0, 0);
    }

    wait 1;
  }
}

function heli_get_target() {
  var_0 = self.origin;
  var_1 = undefined;
  var_2 = scripts\engine\utility::get_array_of_closest(var_0, level.players);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(!var_4 scripts\cp\utility::is_valid_player(undefined, 0) || istrue(var_4 isinfreefall()) || istrue(var_4 isskydiving()) || istrue(var_4 isparachuting())) {
      continue;
    }

    var_0 = (var_4.origin[0], var_4.origin[1], self.chopper_height);

    if(!istrue(self.has_rockets)) {
      if(scripts\engine\trace::ray_trace_passed(var_0, var_4.origin + (0, 0, 10), [self, var_4])) {
        var_1 = var_4;
        self.gotopos = var_0;
      }
    }

    if(!isDefined(var_1)) {
      var_5 = anglestoright(var_4.angles);
      var_6 = anglestoleft(var_4.angles);
      var_7 = anglesToForward(var_4.angles);
      var_8 = var_7 * -1;
      var_9 = [var_5, var_6, var_7, var_8];

      foreach(var_11 in var_9) {
        if(isDefined(var_4.vehicle)) {
          var_12 = [self, var_4, var_4.vehicle];
        } else {
          var_12 = [self, var_4];
        }

        var_0 = (var_4.origin[0], var_4.origin[1], 0) + (var_11[0], var_11[1], 0) * 1800 + (0, 0, self.chopper_height);

        if(scripts\engine\trace::ray_trace_passed(var_0, var_4.origin + (0, 0, 10), var_12)) {
          var_1 = var_4;
          self.gotopos = var_0;
          self.nocircle = 1;
          return var_1;
        }
      }
    }

    if(isDefined(var_1)) {
      break;
    }
  }

  return var_1;
}

function heli_go_search() {
  level endon("game_ended");
  self endon("target_found");
  self endon("needs_to_evade");
  self endon("death");
  self clearlookatent();
  self cleartargetyaw();
  self cleargoalyaw();

  if(isDefined(self.minigun)) {
    self.minigun cleartargetentity();
  }

  self vehicle_setspeed(90, 15);
  self setneargoalnotifydist(1000);

  while(!isDefined(self.best_target)) {
    get_helicopter_path_positions();

    if(isDefined(self.flight_pos)) {
      var_0 = self.flight_pos;
      self setvehgoalpos(var_0, 0);
    } else if(isDefined(self.path_positions) && self.path_positions.size > 0) {
      var_0 = scripts\engine\utility::random(self.path_positions);
      self setvehgoalpos(var_0, 0);
    }

    self waittill("near_goal");
  }
}

function is_vehicle_spawnpoint() {
  return scripts\cp\cp_spawner_scoring::get_spawn_scoring_type() == "vehicle_spawner";
}