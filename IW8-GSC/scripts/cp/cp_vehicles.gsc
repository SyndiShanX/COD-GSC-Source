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
        var0 = getarraykeys(level.vehicle.templates.bullet_shield);

        for(var1 = 0; var1 < var0.size; var1++) {
          level.vehicle.templates.bullet_shield[var0[var1]] = 0;
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
        var0 = getarraykeys(level.vehicle.templates.unloadgroups);

        for(var1 = 0; var1 < var0.size; var1++) {
          var2 = var0[var1];
          var3 = level.vehicle.templates.aianims[var0[var1]].size;

          if(!isDefined(level.vehicle.templates.unloadgroups[var2])) {
            level.vehicle.templates.unloadgroups[var2] = [];
          }

          if(isDefined(level.vehicle.templates.unloadgroups[var2]["passengers"])) {
            continue;
          }

          if(var3 > 1) {
            for(var4 = 1; var4 < var3; var4++) {
              if(isDefined(level.vehicle.templates.aianims[var2][var4])) {
                var5 = level.vehicle.templates.aianims[var2][var4];

                if(isDefined(var5.getout)) {
                  if(!isDefined(level.vehicle.templates.unloadgroups[var2]["passengers"])) {
                    level.vehicle.templates.unloadgroups[var2]["passengers"] = [];
                  }

                  level.vehicle.templates.unloadgroups[var2]["passengers"][level.vehicle.templates.unloadgroups[var2]["passengers"].size] = var4;
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
        var0 = getarraykeys(level.vehicle.templates.team);

        for(var1 = 0; var1 < var0.size; var1++) {
          level.vehicle.templates.team[var0[var1]] = "axis";
        }

        return;
      }

      return;
    }

    return;
  }
}

function ref_1311b(var0, var1) {
  level.vehicle.templates.bullet_shield[var1] = var0;
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

function vehiclehint(var0, var1) {
  if(getdvarint("scr_allow_drivable_vehicles", 0) == 1) {
    return &"CP_VEHICLES/ENTER_VEHICLE";
  }

  return "";
}

function usevehicle(var0, var1) {
  if(getdvarint("scr_allow_drivable_vehicles", 0) == 1) {
    var2 = var0.vehicle;
    var2.ownerid = var1 getentitynumber();
    var2.originalowner = var1;
    var2.driver = var1;
    var1.vehicle = var2;
    var2 setCanDamage(0);
    var1 setplayerangles(var2.angles);
    var1.vehicle setotherent(var1);
    var1 controlslinkTo(var2);
    var1 playerlinktodelta(var2, "tag_driver");
    var1.vehicle setentityowner(var1);
    var1 playerhide();

    foreach(var0 in var2.interactions) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var0);
    }

    thread watchforplayerexit(var2, var1);
    thread vehiclewatchforflip(var2, var1);
    return;
  }
}

function watchforplayerexit(var0, var1) {
  var1 endon("game_ended");
  var1 notifyonplayercommand("exit_vehicle", "+usereload");
  var1 waittill("exit_vehicle");
  exitvehicle(var0, var1);
}

function exitvehicle(var0, var1, var2) {
  var1 unlink(1);
  var1 controlsunlink();
  var1.vehicle setotherent(undefined);
  var1.vehicle setentityowner(undefined);
  var1.vehicle = undefined;
  var1 setOrigin(scripts\engine\utility::random(var0.interactions).origin);

  if(istrue(var2)) {
    var0 delete();
  } else {
    foreach(var4 in var0.interactions) {
      scripts\cp\cp_interaction::add_to_current_interaction_list(var4);
    }
  }

  waitframe();
  var1 playershow();
}

function vehiclewatchforflip(var0, var1) {
  var0 endon("death");
  var2 = 0;

  for(;;) {
    if(var2 >= 4) {
      break;
    }

    var3 = vectordot(anglestoup(var0.angles), (0, 0, 1));

    if(var3 < 0.707) {
      var2 += 0.05;
    } else {
      var2 = 0;
    }

    waitframe();
  }

  exitvehicle(var0, var1, 1);
}

function updateinteractionstructpositions(var0) {
  level endon("game_ended");
  var0 endon("death");
  var1 = spawnStruct();
  var2 = spawnStruct();
  var3 = spawnStruct();
  var4 = spawnStruct();
  createvehicleinteraction(var1, var0);
  createvehicleinteraction(var2, var0);
  createvehicleinteraction(var3, var0);
  createvehicleinteraction(var4, var0);

  for(;;) {
    var5 = anglesToForward(var0.angles);
    var6 = -1 * var5;
    var7 = anglestoleft(var0.angles);
    var8 = anglestoright(var0.angles);
    var5 *= 145;
    var6 *= 145;
    var7 *= 90;
    var8 *= 90;
    var9 = var0.origin + var5;
    var10 = var0.origin + var6;
    var11 = var0.origin + var7;
    var12 = var0.origin + var8;
    var1.origin = var9 + (0, 0, 12);
    var2.origin = var10 + (0, 0, 12);
    var3.origin = var11 + (0, 0, 12);
    var4.origin = var12 + (0, 0, 12);
    wait 0.25;
  }
}

function _spawnVehicle(var0, var1, var2, var3, var4, var5, var6) {
  var7 = spawnVehicle(var0, var1, var2, var3, var4);
  var7.interactions = [];
  thread updateinteractionstructpositions(var7);
  return var7;
}

function createvehicleinteraction(var0, var1) {
  var0.script_noteworthy = "drive_vehicle";
  var0.requires_power = 0;
  var0.powered_on = 1;
  var0.script_parameters = "default";
  var0.cost = 0;
  var0.spend_type = "null";
  var0.targetname = "interaction";
  var0.vehicle = var1;
  var1.interactions[var1.interactions.size] = var0;
  scripts\cp\utility::addtostructarray("targetname", "interaction", var0);
  scripts\cp\utility::addtostructarray("script_noteworthy", "tank_use", var0);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var0);
}

function create_simple_vehicle_path_from_struct(var0) {
  self.pathing_array = [];
  self.pathing_array[self.pathing_array.size] = var0;
  var0.pathing_index = self.pathing_array.size;
  var1 = var0;

  while(isDefined(var1.target)) {
    var2 = scripts\engine\utility::getStructArray(var1.target, "targetname");

    if(var2.size < 1) {
      break;
    }

    if(var2.size > 1) {
      var3 = 1;
      var4 = var2;
      var2 = [];

      for(var5 = 0; var5 < var4.size; var5++) {
        if(var4[var5] == var1) {
          var3 = 0;
          continue;
        }

        var2 = var4[var5];
      }
    }

    var1 = var2[0];
    var1.pathing_index = self.pathing_array.size;
    self.pathing_array[self.pathing_array.size] = var1;
  }
}

function vehiclefollowpathgeneric(var0, var1) {
  if(istrue(var1)) {
    create_simple_vehicle_path_from_struct(var0);
  }

  if(isstruct(var0)) {
    thread vehiclefollowstructpath(var0);
    return;
  }

  thread vehiclefollowpath(var0);
}

function getvehiclepath(var0) {
  var1 = getvehiclenode(var0, "targetname");

  if(!isDefined(var1)) {
    var1 = scripts\engine\utility::getStruct(var0, "targetname");
  }

  return var1;
}

function vehiclefollowstructpathsplines(var0, var1, var2) {
  self endon("death");
  self endon("stop_follow_path");
  self endon("reset_path");
  level endon("game_ended");

  if(var1.size == 0) {
    return;
  }

  jumpiftrue(isDefined(var0)) LOC_0000002f;
  return;
}

function ref_141fd(var0) {
  if(istrue(var0.ref_119e3)) {
    return false;
  }

  if(isDefined(var0.pathing_arrays)) {
    if(istrue(var0.on_last_pathing_array)) {
      return true;
    } else {
      return false;
    }
  }

  return true;
}

function create_extra_structpath(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = (var1 - self.origin) / 2;
  }

  var3 = var1;
  var4 = var2;
  var5 = (var4 + var3) / 2;
  var6 = var5 - var4;
  var7 = spawnStruct();
  var7.origin = var3 + var6;
  return var7;
}

function vehiclefollowstructpath(var0, var1) {
  self endon("death");
  self endon("stop_follow_path");
  self endon("reset_path");
  level endon("game_ended");
  self.on_last_pathing_array = undefined;
  var2 = undefined;

  if(isDefined(self.pathing_arrays) && self.pathing_arrays.size > 0) {
    for(var3 = 0; var3 < self.pathing_arrays.size; var3++) {
      if(!isDefined(self.pathing_arrays) || self.pathing_arrays.size == 0) {
        return;
      }

      if(var3 == self.pathing_arrays.size - 1) {
        self.on_last_pathing_array = 1;
      }

      vehiclefollowstructpathsplines(var0, self.pathing_arrays[var3], var1);
    }

    return;
  }

  if(isDefined(self.pathing_array) && self.pathing_array.size > 0) {
    self.on_last_pathing_array = 1;
    vehiclefollowstructpathsplines(var0, self.pathing_array, var1);
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

function ent_facing_away_from_mypos(var0) {
  var1 = var0.angles;
  var2 = vectordot(var1, vectorNormalize(var0.origin - self.origin));
  return var2 > 0;
}

function drop_to_ground_ignore_vehicle(var0, var1, var2, var3) {
  if(!isDefined(var1)) {
    var1 = 1500;
  }

  if(!isDefined(var2)) {
    var2 = -12000;
  }

  var4 = scripts\engine\trace::create_world_contents();

  if(isDefined(var3)) {
    return scripts\engine\trace::ray_trace(var0 + var1 * var3, var0 + var2 * var3, undefined, var4)["position"];
  }

  return scripts\engine\trace::ray_trace(var0 + (0, 0, var1), var0 + (0, 0, var2), undefined, var4)["position"];
}

function anglebetweenvectorsrounded(var0, var1) {
  return acos(clamp(vectordot(var0, var1) / length(var0) * length(var1), -1, 1));
}

function vehiclefollowpath(var0) {
  self endon("death");
  self endon("stop_follow_path");
  self endon("reset_path");
  self startpath(var0);

  for(var1 = getvehiclenode(var0.target, "targetname"); isDefined(var1); var1 = getvehiclenode(var1.target, "targetname")) {
    var1 waittill("trigger");

    if(isDefined(var1.script_unload)) {
      self vehicle_setspeedimmediate(0, 30, 30);

      for(var2 = self vehicle_getspeed(); var2 > 1; var2 = self vehicle_getspeed()) {
        wait 0.1;
      }

      self notify("unload_guys");

      while(self.riders.size > 0) {
        wait 0.1;
      }

      if(isDefined(var1.target)) {
        self resumespeed(10);
      }
    }

    if(isDefined(var1.script_pathtype) && var1.script_pathtype == "unload") {
      self vehicle_setspeedimmediate(0, 300, 300);
      self stoppath(1);
      self notify("unload_guys");
      self notify("stop_follow_path");
      return;
    }

    if(!isDefined(var1.target)) {
      break;
    }
  }

  self vehicle_setspeedimmediate(0, 30, 30);

  for(var2 = self vehicle_getspeed(); var2 > 1; var2 = self vehicle_getspeed()) {
    wait 0.1;
  }

  self notify("unload_guys");
}

function spawn_ai_in_truck(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var0 scripts\engine\utility::ent_flag_wait("driver_spawned");
  var0.riders = [];
  var0.spawned_guys = [];
  var9 = [];

  if(!isDefined(var2) && isDefined(level.all_spawn_locations)) {
    var2 = scripts\engine\utility::random(level.all_spawn_locations);
  }

  var10 = "convoy_soldiers";
  var11 = level.ambientgroups[var10];

  if(!isDefined(var11)) {
    var12 = &scripts\cp\cp_modular_spawning::registerambientgroup;
    [[var12]]("convoy_soldiers", 0, 10, 250, 20, 0, "convoy_soldiers", undefined, undefined, undefined);
    waitframe();
    var11 = level.ambientgroups[var10];
  }

  if(!var11 scripts\engine\utility::ent_flag_exist("weapons_free")) {
    var11 scripts\engine\utility::ent_flag_init("weapons_free");
  }

  if(!isDefined(level.spawn_module_structs_memory[var10])) {
    level.spawn_module_structs_memory[var10] = [];
    level.active_spawn_module_structs[var10][0] = var11;
    level.spawn_module_structs_memory[var10][0] = var11;
  }

  var13 = 0;

  while(var13 < var1) {
    if(isDefined(level.soldierspawnfunc)) {
      var14 = [[level.soldierspawnfunc]](var4, var2, undefined, 1);
    } else {
      var14 = var0 scripts\cp\cp_modular_spawning::spawn_ai(undefined, undefined, var5, var11);
    }

    if(isDefined(var14)) {
      if(isDefined(var11.cargo_truck_mg_init)) {
        if(isDefined(level.players[var11.cargo_truck_mg_init])) {
          level.players[var11.cargo_truck_mg_init].cargo_truck_mg_gunnerdamagemodignorefunc++;
          var14.cargo_truck_mg_initdamage = level.players[var11.cargo_truck_mg_init];
        }
      }

      var11 scripts\cp\cp_modular_spawning::change_module_status(undefined, "Found Agent");
      level notify("spawned_group_soldier", var14);
      thread scripts\cp\cp_modular_spawning::run_ai_post_spawn_init(var11, var14, var0, undefined, undefined, undefined, undefined);
      var14.group = var11;

      if(istrue(var0.ref_13898)) {
        var14.sightmaxdistance = 2200;
        var14.ignoreall = 1;
      }

      var14.trial_target_think_func = 1;
      var14.dontkilloff = 1;

      if(isDefined(level.reserved_spawn_slots["truck_ai"])) {
        scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "truck_ai");
      }

      if(isDefined(var8)) {
        var14 thread[[var8]]();
      }

      if(istrue(var7)) {
        var15 = var13 + 2;

        if(isDefined(var6)) {
          var15 = var6;
        }

        var16 = (0, 0, 0);

        if(!isvector(var6)) {
          var17 = level.vehicle.templates.aianims[var0.classname_mp][var15];
          var18 = var17.sittag;
        } else {
          var18 = "tag_origin";
          var18 = var7;
          var18 = rotatevector(var18, var1.angles);
        }

        var15.origin = var1 gettagorigin(var18) + (0, 0, -18) + var18;
        var15.linkedent = scripts\engine\utility::spawn_tag_origin(var15.origin);
        var15.linkedent linkTo(var1, var18);
        var15 linkTo(var15.linkedent, "tag_origin");
        var15 thread scripts\engine\utility::delete_on_death(var15.linkedent);
        wait 0.05;
        var15 playerlinkedoffsetenable();
      }

      var15.dontkilloff = 1;
      var1.spawned_guys[var1.spawned_guys.size] = var15;
      var10 = var15;
    }

    wait 0.05;
    var14++;
  }

  if(!istrue(var8)) {
    foreach(var20 in var10) {
      if(isDefined(var7) && isint(var7)) {
        var20.forced_startingposition = var7;
      }

      var1 thread scripts\common\vehicle_aianim::guy_enter(var20);
    }
  }

  thread make_guys_leave_truck(level);
  return var10;
}

function spawn_real_ai_from_drone_pos(var0) {
  var1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var2 = var0.origin;
  var3 = var0.script_noteworthy;
  var4 = var0.model;

  while(var1.size >= level.max_enemy_count) {
    wait 5;
    var1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  }

  if(!isDefined(var0)) {
    var0 = spawn("script_model", var2);
    var0 setModel(var4);
    var0.vehicle_position = 3;
    var0.disable_gun_recall = 1;
    var0.script_noteworthy = var3;
  }

  var5 = undefined;

  while(!isDefined(var5)) {
    var5 = scripts\cp\cp_modular_spawning::spawn_ai(var2, undefined, undefined);

    if(!isDefined(var5)) {
      wait 3;
    }
  }

  var5.disable_gun_recall = 1;
  var5.disable_vehicle_idle = 1;
  var5.animationarchetype = "soldier";
  var5.dontkilloff = 1;

  if(isDefined(level.reserved_spawn_slots["truck_drones"])) {
    scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "truck_drones");
  }

  return var5;
}

function disableunloadanim() {
  return true;
}

function deposit_ai_from_drones_in_vehicle(var0, var1) {
  self endon("death");
  var2 = scripts\engine\utility::ref_143ad("stop_follow_path", "unload_guys");
  wait 0.75;
  thread make_guys_leave_truck(level, self);
}

function create_unload_nodes(var0, var1) {
  var2 = [(-140, 64, 48), (-212, 64, 48), (-140, -64, 48), (-212, -64, 48)];
  var3 = [];
  var4 = 0;

  foreach(var6 in var2) {
    if(var4 < var1) {
      var7 = spawn("script_origin", var0.origin + var6);
      var3 = scripts\engine\utility::array_add(var3, var7);
      var4++;
      var7 linkTo(var0);
      wait 0.1;
    }
  }

  return var3;
}

function reinforcement_test() {
  level endon("game_ended");
  scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(4, "reinforcement_test");
  wait 5;
}

function spawn_reinforcement_truck(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = scripts\engine\utility::getStruct(var1, "targetname");
  var9 = var8.origin;

  if(!isDefined(var8.angles)) {
    var10 = (0, 0, 0);
  } else {
    var10 = var9.angles;
  }

  var11 = _spawnVehicle(var3, "jeep4x4", "atv_physics_cp", var10, (0, 0, 0));

  if(isDefined(var11)) {
    thread vehicle_logic(level, var11, var4, var1, var6, var7);
    return var11;
  }
}

function spawnreinforementtruck(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = scripts\engine\utility::getStruct(var1, "targetname");
  var9 = var8.origin;

  if(!isDefined(var8.angles)) {
    var10 = (0, 0, 0);
  } else {
    var10 = var9.angles;
  }

  var11 = _spawnVehicle(var3, "jeep4x4", "atv_physics_cp", var10, (0, 0, 0));

  if(isDefined(var11)) {
    var11.num_guys = var1;
    var11.targetname_string = var2;
    var11.model_name = var3;
    var11.start_node_name = var4;
    var11.damagable = var5;
    var11.spawnpoints = var9;
    var11.bforcespawn = var7;
    var11.group = var8;
    return var11;
  }

  return undefined;
}

function vehicle_logic(var0, var1, var2, var3, var4, var5) {
  var6 = get_start_node(var0, var1);

  if(!isDefined(var6)) {
    var0 delete();
    return;
  }

  var0.unload_nodes = create_unload_nodes(var0, var2);
  wait 0.1;
  var0.origin = var6.origin;
  var0.angles = var6.angles;
  spawn_ai_in_truck(var0, var2, var3, var4, var5);
  vehiclefollowpath(var0, var6);
}

function get_start_node(var0) {
  var1 = undefined;

  if(isDefined(var0)) {
    var1 = getvehiclenode(var0, "targetname");
  } else {
    var2 = getallvehiclenodes();
    var3 = scripts\engine\utility::getclosest(self.origin, var2, 500);

    if(!isDefined(var3)) {
      return undefined;
    } else {
      var1 = var3;
    }
  }

  return var1;
}

function spawn_guys_on_truck(var0) {}

function make_guys_leave_truck(var0, var1) {
  var0 endon("death");
  var0 endon("disable_leave_truck");

  if(!istrue(var1)) {
    var0 waittill("unload_guys");
    var0 vehicle_setspeed(0, 90, 90);
    wait 1;
    var0 vehicle_setspeedimmediate(0, 30, 30);
  }

  if(istrue(var0.disable_leave_truck)) {
    return;
  }

  var2 = "convoy_soldiers";
  var3 = level.ambientgroups[var2];

  if(!isDefined(var3)) {
    var4 = &scripts\cp\cp_modular_spawning::registerambientgroup;
    [[var4]]("convoy_soldiers", 0, 10, 250, 20, 0, "convoy_soldiers", undefined, undefined, undefined);
    waitframe();
    var3 = level.ambientgroups[var2];
  }

  if(!var3 scripts\engine\utility::ent_flag_exist("weapons_free")) {
    var3 scripts\engine\utility::ent_flag_init("weapons_free");
  }

  if(!isDefined(level.spawn_module_structs_memory[var2])) {
    level.spawn_module_structs_memory[var2] = [];
    level.active_spawn_module_structs[var2][0] = var3;
    level.spawn_module_structs_memory[var2][0] = var3;
  }

  var5 = [];

  foreach(var7 in var0.attachedguys) {
    if(isent(var7)) {
      var7.group = var3;
      var7.combat_func_override = "shotgun";

      if(istrue(var0.ref_13898) && isalive(var7)) {
        var7.sightmaxdistance = 2200;
        var7 thread scripts\cp\coop_stealth::run_common_functions(var7, 1, 1, 60, 160000);
        var7.ignoreall = 0;
      }

      if(!isalive(var7)) {
        var5 = var7;
      }
    }
  }

  hudattractionobj(var0, var3, var5);

  if(!istrue(var1)) {
    while(var0.riders.size > 0) {
      waitframe();
    }
  } else {
    wait 2;
  }

  var0 notify("unloaded");
}

function soldier_leave_truck(var0, var1) {
  var2 = spawn("script_origin", var0.origin);
  var3 = anglesToForward(var1.angles) * -1;
  var4 = 150;
  var5 = scripts\cp\utility::vec_multiply(var3, var4);
  var6 = getclosestpointonnavmesh(var0.origin + var5);
  var0.scripted_mode = 1;
  var0.ignoreall = 1;
  var0 linkTo(var2);
  var2 moveTo(var6 + (0, 0, 5), 0.25);
  var2 waittill("movedone");
  var0.scripted_mode = 0;
  var0.ignoreall = 0;
  var0 unlink();
  var1.riders = scripts\engine\utility::array_remove(var1.riders, var0);
  var6 = getclosestpointonnavmesh(var0.origin);
  var0 setgoalpos(var6);

  if(isDefined(var0.spawnpoint) && isDefined(var0.spawnpoint.script_goalvolume)) {
    var0 setgoalvolumeauto(getEnt(var0.spawnpoint.script_goalvolume, "script_noteworthy"));
  }

  var0.goalradius = 2048;
  var2 delete();
}

function incrementobjectiveachievementkill(var0) {
  var1 = undefined;

  if(isDefined(var0)) {
    if(isDefined(var0.damage)) {
      var1 = var0.damage;
    }

    if(isDefined(var0.attacker) && isPlayer(var0.attacker) && isDefined(var1)) {
      if(isDefined(var0.attacker.team) && isDefined(self.team) && var0.attacker.team != self.team) {
        if(isDefined(var0.objweapon) && isDefined(var0.objweapon.basename)) {
          if(var0.objweapon.basename == "emp_drone_player_mp") {
            var1 = 10000;
          }
        }
      }

      if(isDefined(var0.objweapon) && isDefined(var0.objweapon.basename)) {
        switch (var0.objweapon.basename) {
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
              if(isDefined(var0.objweapon) && issubstr(var0.objweapon.basename, "molotov")) {
                var0.attacker thread scripts\cp\cp_achievement::scriptable_setups();
              }
            }

            break;
        }

        if(isDefined(var0.meansofdeath)) {
          var1 = scripts\cp\cp_damage::handleapdamage(var0.objweapon, var0.meansofdeath, var1, var0.attacker);
        }
      }

      if(isDefined(self.is_correct_wire_color_sync)) {
        var1 *= self.is_correct_wire_color_sync;
      }

      if(istrue(var0.attacker.is_available_for_hack)) {
        var2 = var0.attacker.origin[2];
        var3 = self.origin[2];

        if(var2 >= var3) {
          var4 = int(abs(var2 - var3));
          var5 = int(var4 / 64);

          if(var5 > 0) {
            var1 *= 1 + 0.4 * var5;
          }
        }
      }

      var0.attacker scripts\cp\cp_damagefeedback::updatehitmarker("standard", 1, var1, 0, 0);
      var6 = self.health - var1;
      self.health = int(max(var6, self.healthbuffer - 1));
    }
  }

  return var1;
}

function delete_on_end() {
  level endon("game_ended");
  self endon("death");
  wait 0.25;
  scripts\engine\utility::ref_143a5("unloaded", "stop_follow_path");
}

function spawnstaticvehicle(var0, var1, var2) {
  var3 = spawn("script_model", var0);
  var3.angles = var1;
  var3 setModel(var2);
  var3 solid();
  createnavobstaclebybounds(var3.origin, (100, 100, 200), var3.angles);
  var3 disconnectPaths();
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

function register_unloading_func(var0, var1) {
  if(!isDefined(level.unloading_func)) {
    level.unloading_func = [];
  }

  var2 = spawnStruct();
  var2.spawn_type = var1;
  level.unloading_func[var0] = var1;
}

function register_unloaded_func(var0, var1) {
  if(!isDefined(level.unloading_func)) {
    level.unloaded_func = [];
  }

  var2 = spawnStruct();
  var2.spawn_type = var1;
  level.unloaded_func[var0] = var1;
}

#using_animtree("");

function deploy_fast_rope() {
  var0 = self gettagorigin("origin_animate_jnt");
  var1 = self gettagangles("origin_animate_jnt");
  var2 = "equipment_fast_rope_wm_01_infil_heli_l";
  var3 = % equipment_fast_rope_wm_01_infil_heli_l;
  var4 = getstartorigin(var0, var1, var3);
  var5 = getstartangles(var0, var1, var3);
  var6 = spawn("script_model", var4);
  var6.angles = var5;
  thread scripts\engine\utility::delete_on_death(var6);
  var6 setModel("equipment_fast_rope_wm_01_infil_heli_l");
  var6 linkTo(self);
  var6 scriptmodelplayanimdeltamotionfrompos(var2, var4, var5);
  var0 = self gettagorigin("origin_animate_jnt");
  var1 = self gettagangles("origin_animate_jnt");
  var2 = "equipment_fast_rope_wm_01_infil_heli_r";
  var3 = $equipment_fast_rope_wm_01_infil_heli_r;
  var4 = getstartorigin(var0, var1, var3);
  var5 = getstartangles(var0, var1, var3);
  var7 = spawn("script_model", var4);
  var7.angles = var5;
  thread scripts\engine\utility::delete_on_death(var7);
  var7 setModel("equipment_fast_rope_wm_01_infil_heli_l");
  var7 linkTo(self);
  var7 scriptmodelplayanimdeltamotionfrompos(var2, var4, var5);
  scripts\engine\utility::waittill_either("death", "unloaded");
  var6 scriptmodelclearanim();
  var6 scriptmodelplayanim("equipment_fast_rope_wm_01_infil_heli_l_fall");
  var7 scriptmodelclearanim();
  var7 scriptmodelplayanim("equipment_fast_rope_wm_01_infil_heli_r_fall");
  wait 2;
  var6 delete();
  var7 delete();
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

function register_spawner_script_function(var0, var1, var2, var3) {
  if(istrue(var3)) {
    level waittill(var0);
  }

  if(isDefined(level.spawner_script_funcs[var0])) {
    var4 = level.spawner_script_funcs[var0];
  } else {
    var4 = spawnStruct();
  }

  var4.script_function = var2;
  var4.specs = var3;
  level.spawner_script_funcs[var1] = var4;
}

function create_ai_plr_vehicle(var0, var1) {
  copy_vehicle_build_to_spawnpoint(var1, var0);
  var2 = scripts\common\vehicle::vehicle_spawn(var0);
  var2.cannotbesuspended = 1;

  if(isDefined(var0.vehiclename)) {
    var2.vehiclename = var0.vehiclename;
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(var2, "axis");
    var2 makeunusable();
    var2 setCanDamage(1);
    var2.maxhealth = 999999;
    var2.health = var2.maxhealth;
    var2 scripts\cp_mp\emp_debuff::set_start_emp_callback(&scripts\cp_mp\vehicles\vehicle::vehicle_empstartcallback);
    var2 scripts\cp_mp\emp_debuff::set_clear_emp_callback(&scripts\cp_mp\vehicles\vehicle::vehicle_empclearcallback);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_registerinstance(var2);
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_registerinstance(var2);
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(var2);
    scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(var2, undefined, undefined);
    scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_spawnevent(var2, undefined);
    var3 = &scripts\cp_mp\utility\weapon_utility::setlockedoncallback;
    [[var3]](var2, &scripts\cp_mp\vehicles\vehicle::vehicle_lockedoncallback);
    var4 = &scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback;
    [[var4]](var2, &scripts\cp_mp\vehicles\vehicle::vehicle_lockedonremovedcallback);
    thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);
  }

  return var2;
}

function register_vehicle_build(var0, var1, var2, var3, var4) {
  var5 = spawnStruct();
  var5.model = var1;
  var5.vehicletype = var2;
  var5.classname_mp = var3;
  level.vehicle_builds[var0] = var5;
}

function ref_12b02(var0, var1) {
  if(istrue(var1)) {
    level waittill(var0);
  }

  var2 = level.vehicle_builds[var0];

  if(isDefined(var2)) {
    var2.trial_turret_kill_func = 1;
    var2.brjugg_initfeatures = 1;
    return;
  }
}

function ref_141b4(var0) {
  return istrue(level.vehicle_builds[var0].trial_turret_kill_func);
}

function init_ammo_boxes(var0, var1, var2, var3) {
  thread ref_12b03(level, var0, var1, var2, var3, undefined, 1);
  thread ref_12b02(level, var0);
  thread register_vehicle_spawn_drivers(level, var0, 1);
  thread ref_12b05(level, var0, undefined, undefined, undefined, undefined, undefined, undefined, 1, undefined);
}

function ref_12b03(var0, var1, var2, var3, var4, var5, var6) {
  if(istrue(var6)) {
    level waittill(var0);
  }

  if(isDefined(level.vehicle)) {
    if(isDefined(level.vehicle.templates)) {
      if(isDefined(level.vehicle.templates.aianims)) {
        if(isDefined(level.vehicle.templates.aianims[var3])) {
          if(isDefined(level.ai_spawn_vehicle_func[var0]) && isDefined(level.ai_spawn_vehicle_func[var0].max_ai)) {
            if(isDefined(var5)) {
              level.vehicle_builds[var0].max_ai = var5;
              return;
            }

            level.vehicle_builds[var0].max_ai = level.ai_spawn_vehicle_func[var0].max_ai;
            return;
          }

          if(isDefined(var5)) {
            level.vehicle_builds[var0].max_ai = var5;
            return;
          }

          var7 = level.vehicle.templates.aianims[var3];
          level.vehicle_builds[var0].max_ai = var7.size;
          return;
        }

        return;
      }

      return;
    }

    return;
  }
}

function puzzle_mark_complete(var0, var1) {
  if(isDefined(level.vehicle_builds) && isDefined(level.vehicle_builds[var1]) && isDefined(level.vehicle_builds[var1].max_ai)) {
    var2 = puddle_fx(var0, var1);

    if(isDefined(var2)) {
      var3 = 0;

      for(var4 = 0; var4 < self.usedpositions.size; var4++) {
        var5 = 1;

        for(var6 = 0; var6 < var2.size; var6++) {
          if(var2[var6] == var4) {
            var5 = 0;
            break;
          }
        }

        if(var5) {
          var3++;
        }
      }

      return int(min(var3, level.vehicle_builds[var1].max_ai));
    }

    return level.vehicle_builds[var5].max_ai;
  }

  return undefined;
}

function get_random_available_air_ai_infil() {
  return scripts\engine\utility::random(level.available_ai_vehicle_air_infils);
}

function get_random_available_ground_ai_infil() {
  return scripts\engine\utility::random(level.available_ai_vehicle_ground_infils);
}

function attempt_ai_ground_infil_cooldown(var0) {
  if(level.ai_spawn_vehicle_func[var0].max_num <= level.ai_spawn_vehicle_func[var0].count) {
    thread remove_ai_ground_infil_for_time(level);
    return;
  }
}

function attempt_ai_air_infil_cooldown(var0) {
  if(level.ai_spawn_vehicle_func[var0].max_num <= level.ai_spawn_vehicle_func[var0].count) {
    thread remove_ai_air_infil_for_time(level);
    return;
  }
}

function remove_ai_ground_infil_for_time(var0) {
  level.available_ai_vehicle_ground_infils = scripts\engine\utility::array_remove(level.available_ai_vehicle_ground_infils, var0);

  if(isDefined(level.ai_spawn_vehicle_func[var0].cooldown)) {
    scripts\engine\utility::delaythread(level.ai_spawn_vehicle_func[var0].cooldown, &add_ai_ground_infil, var0);
    return;
  }
}

function remove_ai_air_infil_for_time(var0) {
  level.available_ai_vehicle_air_infils = scripts\engine\utility::array_remove(level.available_ai_vehicle_air_infils, var0);

  if(isDefined(level.ai_spawn_vehicle_func[var0].cooldown)) {
    scripts\engine\utility::delaythread(level.ai_spawn_vehicle_func[var0].cooldown, &add_ai_air_infil, var0);
    return;
  }
}

function add_ai_air_infil(var0) {
  level.available_ai_vehicle_air_infils[var0] = var0;
}

function add_ai_ground_infil(var0) {
  level.available_ai_vehicle_ground_infils[var0] = var0;
}

function ref_12b05(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  level waittill(var0);

  if(isDefined(level.ai_spawn_vehicle_func[var0])) {
    var10 = level.ai_spawn_vehicle_func[var0];

    if(isDefined(var0)) {
      var10.spawn_type = var0;
    }

    if(isDefined(var1)) {
      var10.max_num = var1;
    }

    if(isDefined(var2)) {
      var10.cooldown = var2;
    }

    if(isDefined(var3)) {
      var10.max_wait_for_infil = var3;
    }

    if(isDefined(var4)) {
      var10.spawn_points = var4;
    }

    if(isDefined(var5)) {
      var10.exit_points = var5;
    }

    if(isDefined(var6)) {
      var10.path_start_points = var6;
    }

    if(isDefined(var8)) {
      var10.vehicle_spawn_func = var8;
    }

    if(isDefined(var9)) {
      var10.vehicle_build = var9;
    }

    level.ai_spawn_vehicle_func[var0] = var10;

    if(isDefined(var6)) {
      thread get_path_points(level, var0);
    }
  }

  if(isDefined(var7)) {
    if(isDefined(level.vehicle_builds[var0]) && isDefined(level.vehicle_builds[var0].max_ai)) {
      level.vehicle_builds[var0].max_ai = var7;
      return;
    }

    return;
  }
}

function register_vehicle_spawn(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  level.all_ai_vehicle_infils[level.all_ai_vehicle_infils.size] = var0;
  var10 = spawnStruct();
  var10.spawn_type = var0;
  var10.max_num = var1;
  var10.cooldown = var2;
  var10.max_wait_for_infil = var3;
  var10.spawn_points = var4;
  var10.exit_points = var5;
  var10.path_start_points = var6;
  var10.vehicle_spawn_func = var8;
  var10.count = 0;
  var10.max_ai = var7;
  var10.vehicle_build = var9;
  var10.infected_music = var0;
  level.ai_spawn_vehicle_func[var0] = var10;

  if(isDefined(var6)) {
    thread get_path_points(level, var0);
    return;
  }
}

function get_path_points(var0, var1) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("introscreen_over");
  scripts\engine\utility::flag_wait("infil_complete");
  scripts\engine\utility::flag_wait("interactions_initialized");
  level.path_points[var0] = scripts\engine\utility::getStructArray(var1, "targetname");
}

function register_vehicle_spawn_drivers(var0, var1, var2, var3) {
  if(istrue(var3)) {
    level waittill(var0);
  }

  if(isDefined(level.ai_spawn_vehicle_func[var0])) {
    var4 = level.ai_spawn_vehicle_func[var0];
    var4.num_script_models = var1;
    var4.driver_models = var2;
    level.ai_spawn_vehicle_func[var0] = var4;
    return;
  }
}

function choose_random_ground_vehicle_spawn(var0, var1, var2) {
  if(isDefined(var1.ai_infil_type)) {
    var3 = var1.ai_infil_type;
  } else {
    var3 = get_random_available_ground_ai_infil();
  }

  if(isDefined(var3)) {
    var2.og_script_function = var2.script_function;
    var2.script_function = var3;

    if(!isDefined(var2.vehicle) && isDefined(level.ai_spawn_vehicle_func[var3].vehicle_spawn_func)) {
      if([[level.ai_spawn_vehicle_func[var3].vehicle_spawn_func]](var1, var2, var3)) {
        return 1;
      } else {
        return 0;
      }
    } else if(isDefined(var2.vehicle)) {
      return 1;
    } else {
      return 0;
    }

    self thread[[level.spawner_script_funcs[var3].script_function]](var1, var2, var3);
    thread attempt_ai_ground_infil_cooldown(var3);
    return;
  }

  return 0;
}

function decrement_wave_veh_count(var0) {
  if(isDefined(self.valid_vehicles) && isDefined(self.valid_vehicles[var0])) {
    self.valid_vehicles[var0]--;

    if(self.valid_vehicles[var0] < 1) {
      self.valid_vehicles[var0] = undefined;
      return;
    }

    return;
  }
}

function choose_escalation_air_vehicle_spawn(var0, var1, var2) {
  var3 = undefined;
  var4 = var0 scripts\cp\cp_modular_spawning::get_current_wave_ref();

  if(isDefined(var4)) {
    var5 = var0 scripts\cp\cp_modular_spawning::pressure_stability_event_start();

    if(istrue(var0.use_only_veh_spawners) && (!isDefined(var5) || var5.size < 1)) {
      return 0;
    }

    var5 = var1 scripts\cp\cp_modular_spawning::pressure_stability_event_init(var5);

    if(isDefined(var5) && var5.size > 0) {
      var3 = scripts\engine\utility::random(var5);

      if(scripts\cp\cp_modular_spawning::has_vehicle_type_exceeded_module_cap(var0, var3)) {
        return 0;
      }
    }
  } else if(isDefined(var0.valid_vehicles) && scripts\engine\utility::array_sum(var0.valid_vehicles) > 0) {
    var5 = var0 scripts\cp\cp_modular_spawning::pressure_stability_event_start();
    var5 = var1 scripts\cp\cp_modular_spawning::pressure_stability_event_init(var5);

    if(isDefined(var5) && var5.size > 0) {
      var3 = scripts\engine\utility::random(var5);

      if(scripts\cp\cp_modular_spawning::has_vehicle_type_exceeded_module_cap(var0, var3)) {
        return 0;
      }
    }
  } else {
    var3 = get_random_available_air_ai_infil();
  }

  if(isDefined(var3)) {
    if(scripts\cp\cp_modular_spawning::has_vehicle_type_exceeded_module_cap(var0, var3)) {
      return 0;
    }

    var1.og_script_function = var1.script_function;
    var1.script_function = var3;

    if(!isDefined(var1.vehicle) && isDefined(level.ai_spawn_vehicle_func[var3].vehicle_spawn_func)) {
      if([[level.ai_spawn_vehicle_func[var3].vehicle_spawn_func]](var0, var1, var3)) {
        return 1;
      } else {
        return 0;
      }
    } else if(isDefined(var1.vehicle)) {
      return 1;
    } else {
      return 0;
    }

    self thread[[level.spawner_script_funcs[var3].script_function]](var0, var1, var3);
    return;
  }

  return 0;
}

function choose_random_air_vehicle_spawn(var0, var1, var2) {
  if(isDefined(var1.ai_infil_type)) {
    var3 = var1.ai_infil_type;
  } else {
    var3 = get_random_available_air_ai_infil();
  }

  if(isDefined(var3)) {
    var2.og_script_function = var2.script_function;
    var2.script_function = var3;

    if(!isDefined(var2.vehicle) && isDefined(level.ai_spawn_vehicle_func[var3].vehicle_spawn_func)) {
      if([[level.ai_spawn_vehicle_func[var3].vehicle_spawn_func]](var1, var2, var3)) {
        return 1;
      } else {
        return 0;
      }
    } else if(isDefined(var2.vehicle)) {
      return 1;
    } else {
      return 0;
    }

    self thread[[level.spawner_script_funcs[var3].script_function]](var1, var2, var3);
    thread attempt_ai_air_infil_cooldown(var3);
    return;
  }

  return 0;
}

function ai_ground_veh_spawn(var0, var1, var2) {
  if(isDefined(var1.vehicle)) {
    self.vehicle = var1.vehicle;
    self.vehicle thread scripts\engine\utility::thread_on_notify("unloaded", &clear_kill_off_flags, self, undefined, self, self, "death");
    thread delay_enter_vehicle(var0, var1, var1.vehicle, var2);
    thread allow_infil_after_full_or_timeout(var1.vehicle, var0);
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
  var0 = self.vehicle;
  var1 = scripts\engine\utility::ref_143ad("damage", "death");
  thread stop_vehicle_on_damage_internal(var0);
}

function stop_vehicle_on_damage_internal(var0) {
  var0 notify("stop_vehicle_on_damage_internal");
  var0 endon("death");
  var0 scripts\common\utility::vehicle_detachfrompath();
  var0 scripts\common\vehicle::vehicle_unload("default");
  var0 waittill("unloaded");
  var0 thread scripts\common\utility::vehicle_resumepath();
}

function ai_mindia8_jugg_spawn(var0, var1, var2) {
  if(!isDefined(var1.vehicle)) {
    if(isDefined(level.ai_spawn_vehicle_func[var2].vehicle_spawn_func)) {
      if([[level.ai_spawn_vehicle_func[var2].vehicle_spawn_func]](var0, var1, var2)) {
        if(isDefined(self.unittype) && self.unittype == "juggernaut") {
          self.forced_startingposition = 14;
          self.dontkilloff = 1;
        }

        thread ai_enter_vehicle(var0, var1, var2);

        if(!isDefined(self.forced_startingposition)) {
          if(var1.vehicle.riders.size >= level.vehicle_builds[var2].max_ai - 1) {
            var1.vehicle notify("spawning_done");
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

  thread ai_enter_vehicle(var0, var1, var2);

  if(var1.vehicle.riders.size >= level.vehicle_builds[var2].max_ai - 1) {
    var1.vehicle notify("spawning_done");
    return;
  }
}

function ai_lbravo_spawn(var0, var1, var2) {
  if(!isDefined(var1.vehicle) && isDefined(level.ai_spawn_vehicle_func[var2].vehicle_spawn_func)) {
    if([[level.ai_spawn_vehicle_func[var2].vehicle_spawn_func]](var0, var1, var2)) {
      thread ai_enter_vehicle(var0, var1, var2);
      return;
    }

    return;
  }

  thread ai_enter_vehicle(var0, var1, var2);
}

function ai_enter_vehicle(var0, var1, var2) {
  if(isDefined(var1.vehicle)) {
    thread hasexiteddriver(var1.vehicle);
    thread delay_enter_vehicle(var0, var1, var1.vehicle, var2);
    thread allow_infil_after_full_or_timeout(var1.vehicle, var0);

    if(isDefined(var1.script_demeanor)) {
      scripts\cp\cp_modular_spawning::set_demeanor_from_unittype(var1.script_demeanor);
      return;
    }

    return;
  }
}

function hasexiteddriver(var0) {
  self endon("death");
  hashitplayer(var0);
  thread clear_kill_off_flags(self);
}

function hashitplayer(var0) {
  self endon("unload");
  self endon("death");
  var0 endon("death");
  self waittill("forever");
}

function delay_enter_vehicle(var0, var1, var2, var3) {
  if(isDefined(self.spawnpoint.pos_override_struct) && self.spawnpoint.pos_override_struct != var2) {
    thread add_to_vehicle_queue(var2);
    return;
  }

  scripts\engine\utility::thread_on_notify("loaded", &disable_canshootinvehicle);
  self hide();

  if(isDefined(var1.script_demeanor)) {
    scripts\cp\cp_modular_spawning::set_demeanor_from_unittype(var1.script_demeanor);
  }

  var4 = redlight(var2, var0, var3);

  if(!isDefined(self.forced_startingposition) && isDefined(var4) && int(var4) >= 0) {
    self.forced_startingposition = var4;
  }

  self dontinterpolate();
  var2 thread scripts\common\vehicle_aianim::guy_enter(self);
}

function disable_canshootinvehicle() {
  self show();

  if(istrue(level.vehicle_ai_can_shoot_after_reload)) {
    return;
  }

  self.canshootinvehicle = 0;
}

function add_to_vehicle_queue(var0) {
  self notify("add_to_vehicle_queue");
  self.load_queue[self.load_queue.size] = var0;
  var0 scripts\engine\utility::thread_on_notify_no_endon_death("death", &remove_from_vehicle_queue, self);
}

function remove_from_vehicle_queue(var0) {
  if(isDefined(var0) && isDefined(var0.load_queue) && var0.load_queue.size > 0) {
    if(scripts\engine\utility::array_contains(var0.load_queue, self)) {
      var0.load_queue = scripts\engine\utility::array_remove(var0.load_queue, self);
      return;
    }

    return;
  }
}

function veh_ground_veh_spawn(var0, var1, var2) {
  var3 = level.ai_spawn_vehicle_func[var2];
  var4 = get_vehicle_spawn_points(var3, var1);

  if(var4.size > 0) {
    foreach(var6 in var4) {
      if(istrue(var6.in_use)) {
        continue;
      }

      var7 = create_ai_plr_vehicle(var6, var2);

      if(isDefined(var7)) {
        stringtovec3(var7, var1, var0, var6, var2);
        thread veh_ping_vehicle_location_to_players();
        thread waittill_full_or_timeout(var7, var2);
        post_spawn_vehicle_init(var7, var0, var1, var2, var6);
        thread super_onspawned(var7, var0);

        if(ref_141b4(var2) || getdvarint("scr_script_model_drivers", 0)) {
          thread ref_135cb(var7, var7);
        }

        clear_vehicle_build_to_spawnpoint(var6);
        return 1;
      }

      clear_vehicle_build_to_spawnpoint(var6);
      return 0;
    }

    var6 = undefined;
    var7 = undefined;
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

function post_spawn_vehicle_init(var0, var1, var2, var3) {
  level.ai_spawn_vehicle_func[var2].count++;
  self.load_queue = [];
  self.group = var0;
  self.vehicle_skipdeathmodel = 1;
  self.veh_spawn_point = var3;
  var1.ai_infil_type = var2;
  var3.in_use = 1;
  var1.specs = level.spawner_script_funcs[var2].specs;
  var1.vehicle = self;
  self.spawn_point = var1;
}

function set_throttle_zero() {}

function reset_throttle() {}

function ref_135cb(var0, var1) {
  var2 = level.ai_spawn_vehicle_func[var1];

  if(isDefined(var2) && isDefined(var2.num_script_models)) {
    var3 = [];

    for(var4 = 0; var4 < var2.num_script_models; var4++) {
      var5 = level.vehicle.templates.aianims[var0.classname_mp][var4];
      var6 = var5.sittag;
      var7 = var0 scripts\cp\vehicles\vehicle_cp::spawn_script_model_at_pos(var4, var6, var5.idle_anim, var5.idle, var2.driver_models);
      var3 = var7;
      level.ref_14102[level.ref_14102.size] = var7;
      thread handlemeleekillrewardbullets(var0);

      if(var4 <= 1 && scripts\cp\utility::turn_off_sniper_laser()) {
        thread ref_12f4e(var0);
      }
    }
  }

  if(isDefined(level.vehicle_builds[var1]) && isDefined(level.vehicle_builds[var1].max_ai)) {
    var8 = int(min(level.vehicle_builds[var1].max_ai, var0.usedpositions.size));
  } else {
    var8 = var1.usedpositions.size;
  }

  if(var1.attachedguys.size >= var8) {
    var1 notify("spawning_done");
    return;
  }
}

function ref_12f4e(var0) {
  self endon("death");
  var0 endon("death");

  if(!isDefined(self) || !isDefined(var0)) {
    return;
  }

  var1 = 250;

  for(;;) {
    self waittill("damage", var2, var3, var4, var5);

    if(isDefined(var3) && isPlayer(var3) && isDefined(var2) && var2 > 0 && isDefined(var5)) {
      if(var0 tagexists("j_head")) {
        var6 = var0 gettagorigin("j_head");
      } else {
        var6 = var1.origin + (0, 0, 50);
      }

      var6 += (0, 0, -20);
      var7 = var4 getEye();
      var8 = vectorNormalize(var6 - var7);
      var9 = vectorNormalize(var6 - var7);
      var10 = vectordot(var8, var9);
      var11 = vectordot(vectorNormalize(anglesToForward(self.angles)), vectorNormalize(var6 - self.origin));
      var12 = var1.origin + (0, 0, 18);

      if(var10 > 0.99975 && var11 > 0.73 && var6[2] > var12[2]) {
        var2 -= var3;

        if(var2 <= 0) {
          var4 scripts\cp\cp_achievement::scriptable_enginedamaged();
          self notify("death", var4);
        }
      }
    }
  }
}

function ref_13b03(var0) {
  self endon("death");

  for(;;) {
    var1 = getdvarint("scr_x", 0);
    var2 = getdvarint("scr_y", 0);
    var3 = getdvarint("scr_z", 0);
    var4 = scripts\cp\utility::get_point_in_local_ent_space(var0, (var1, var2, var3));
    thread scripts\engine\utility::draw_line_for_time(var4, var4 + (0, 0, 128), 1, 1, 1, 0.05);
    waitframe();
  }
}

function handlemeleekillrewardbullets(var0) {
  self waittill("death");

  if(isDefined(var0)) {
    for(var1 = 0; var1 < var0.size; var1++) {
      ref_12bcd(var0[var1]);
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

function get_vehicle_spawn_points(var0) {
  if(istrue(var0.veh_model_spawner)) {
    return [var0];
  }

  var1 = scripts\engine\utility::getStructArray(self.spawn_points, "targetname");
  var2 = [];

  if(isDefined(var0.script_linkname)) {
    for(var3 = 0; var3 < var1.size; var3++) {
      if(is_linked_struct(var1[var3], var0)) {
        var2 = var1[var3];
      }
    }

    if(var2.size < 1) {
      return scripts\engine\utility::array_randomize(var1);
    }

    var4 = scripts\engine\utility::random(var2);
    return [var4];
  }

  return scripts\engine\utility::array_randomize(var2);
}

function veh_heli_spawn(var0, var1, var2) {
  var3 = level.ai_spawn_vehicle_func[var2];
  var4 = get_vehicle_spawn_points(var3, var1);

  if(var4.size > 0) {
    foreach(var6 in var4) {
      if(istrue(var6.in_use)) {
        continue;
      }

      if(getdvarint("scr_direct_heli_path_debug", 0)) {
        thread scripts\engine\utility::draw_capsule(var6.origin, 64, 64, (0, 0, 0), (0, 1, 0), 0, 1000);
      }

      copy_vehicle_build_to_spawnpoint(var2, var6);
      var7 = vectortoangles(var1.origin - var6.origin);
      var6.angles = (0, var7[1], 0);
      var8 = scripts\common\vehicle::vehicle_spawn(var6);

      if(isDefined(var8)) {
        stringtovec3(var8, var1, var0, var6, var2);
        ref_13bb7(var6, 1);

        if(var6 scripts\common\vehicle_code::ishelicopter_internal()) {
          init_helicopter(var8, var0, var2);
        }

        var0.vehicle = var8;
        var8.veh_spawn_point = var6;
        var8.path_gobbler = 1;
        var1.specs = level.spawner_script_funcs[var2].specs;
        var1.ai_infil_type = var2;
        thread veh_ping_vehicle_location_to_players();
        thread heli_waittill_full_or_timeout(var8, var2);

        if(ref_141b4(var2) || getdvarint("scr_script_model_drivers", 0) || scripts\cp\utility::turn_off_sniper_laser()) {
          thread ref_135cb(var8, var8);
        }

        clear_vehicle_build_to_spawnpoint(var6);
        return 1;
      }

      clear_vehicle_build_to_spawnpoint(var6);
      return 0;
    }

    var8 = undefined;
    return 0;
  }

  return 0;
}

function stringtovec3(var0, var1, var2, var3) {
  self.load_queue = [];
  self.spawn_point = var0;
  self.stop_all_ascend_anims = var3;
  self.group = var1;
  var1.vehicle = self;
  var0.vehicle = self;
  var0.veh_spawn_point = var2;
  self.veh_spawn_point = var2;
  self.dontdisconnectpaths = 1;
  var1.ref_12a87 = 1;
  self setCanDamage(1);
  scripts\cp_mp\emp_debuff::set_start_emp_callback(&scripts\cp_mp\vehicles\vehicle::vehicle_empstartcallback);
  scripts\cp_mp\emp_debuff::set_clear_emp_callback(&scripts\cp_mp\vehicles\vehicle::vehicle_empclearcallback);
  thread lb_impulse_dmg_threshold_top();
  thread decrement_wave_veh_count(var1);
  self vehicle_turnengineon();
}

function lb_impulse_dmg_threshold_top() {
  self endon("death");
  var0 = ref_14451();

  if(isDefined(var0) && isai(var0)) {
    var0.health = 500;
    var0.maxhealth = 500;

    if(scripts\common\vehicle_code::ishelicopter_internal()) {
      thread lb_mg_dmg_factor_driverless_collision(var0);
      return;
    }

    thread ref_138ce(var0);
    return;
  }
}

function lb_mg_dmg_factor_driverless_collision(var0) {
  level endon("game_ended");
  self endon("death_finished");
  self endon("death");
  var0 endon("unload");
  var0 waittill("death", var1, var2, var3, var4);

  if(isDefined(var1) && isPlayer(var1)) {
    var1 scripts\cp\cp_achievement::scriptable_enginedamaged();
  }

  self notify("death", var1);
}

function ref_138ce(var0) {
  level endon("game_ended");
  self endon("death");
  var0 endon("unload");
  var0 waittill("death", var1, var2, var3, var4);
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
    self waittill("guy_entered", var0, var1);

    if(isDefined(var0)) {
      if(scripts\engine\utility::is_equal(self.driver, var0)) {
        return var0;
      }
    }
  }

  return undefined;
}

function ref_13bb7(var0) {
  if(istrue(var0)) {
    self.in_use = var0;
    return;
  }

  self.in_use = undefined;
}

function clear_vehicle_build_to_spawnpoint(var0) {
  var0.classname_mp = undefined;
  var0.vehicletype = undefined;
  var0.vehiclename = undefined;
}

function copy_vehicle_build_to_spawnpoint(var0, var1) {
  if(isDefined(level.vehicle_builds) && isDefined(level.vehicle_builds[var0])) {
    var2 = level.vehicle_builds[var0];

    if(isDefined(var2.classname_mp)) {
      var1.classname_mp = var2.classname_mp;
    }

    if(isDefined(var2.vehicletype)) {
      var1.vehicletype = var2.vehicletype;
    }

    if(isDefined(var2.vehiclename)) {
      var1.vehiclename = var2.vehiclename;
      return;
    }

    return;
  }
}

function waittill_full_or_timeout(var0, var1) {
  self notify("waittill_full_or_timeout");
  self endon("waittill_full_or_timeout");
  self endon("death");
  level endon("game_ended");
  thread decrement_vehicles_active(var0, var1);
  thread watch_for_all_passengers_dead(var0, var1);

  if(self vehicle_isphysveh()) {
    if(getdvarint("scr_struct_spline_path", 0)) {
      self vehicle_cleardrivingstate();
    }

    self.veh_brake = 1;
  }

  self waittill("spawning_done");
  self.spawn_point scripts\cp\cp_modular_spawning::little_bird_mg_givetakegunnerturrettimeout();
  scripts\engine\utility::thread_on_notify_no_endon_death("unloading", &check_for_unloading_func, var0, undefined, undefined);

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

  var2 = create_vehicle_path(var0);

  if(self vehicle_isphysveh()) {
    self.veh_brake = 0;
  }

  self notify("ai_vehicle_pathing_started");

  if(!self vehicle_isphysveh()) {
    if(isDefined(self.target)) {
      var3 = getvehiclenode(self.target, "targetname");
      self attachpath(var3);
      self startpath();
      return;
    }

    self notify("stop_vehicle_watchers");
    return;
  }

  self notify("newpath");

  if(isDefined(self.target)) {
    var3 = getvehiclenode(self.target, "targetname");

    if(isDefined(var3)) {
      self attachpath(var3);
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

function get_duration_between_points(var0, var1, var2, var3) {
  var4 = distance(var0, var1);

  if(istrue(var3)) {
    var4 *= 0.0568182;
  }

  var5 = var4 / var2;

  if(var5 < 0.05) {
    var5 = 0.05;
  }

  return var5;
}

function start_vehicle_path(var0) {
  if(!self vehicle_isphysveh() && !isstruct(var0)) {
    var0 = getvehiclenode(self.target, "targetname");
    self attachpath(var0);
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
  var0 = 0;
  var1 = 2;

  if(isDefined(self.ref_13f12)) {
    var1 = self.ref_13f12;
  }

  for(;;) {
    if(self issuspendedvehicle() || self vehicle_getspeed() <= 2) {
      var0 += 0.1;
    } else {
      var0 = 0;
    }

    if(var0 >= var1) {
      break;
    }

    wait 0.1;
  }

  self vehicle_setspeedimmediate(0, 30, 30);
  thread scripts\common\vehicle_code::_vehicle_unload("default");
}

function heli_waittill_full_or_timeout(var0, var1) {
  self notify("waittill_full_or_timeout");
  self endon("waittill_full_or_timeout");
  self endon("death");
  level endon("game_ended");
  thread decrement_vehicles_active(var0, var1);
  thread slide_trig(var0);
  self waittill("spawning_done");
  self.spawn_point scripts\cp\cp_modular_spawning::little_bird_mg_givetakegunnerturrettimeout();
  self.group.vehicle = undefined;
  scripts\engine\utility::thread_on_notify_no_endon_death("unloading", &check_for_unloading_func, var0, undefined, undefined);
  scripts\engine\utility::thread_on_notify_no_endon_death("unloaded", &delete_nav_obstacle, undefined, undefined, undefined);

  if(isDefined(self.spawn_point.heli_path_func)) {
    var2 = self[[self.spawn_point.heli_path_func]](var0);
  } else {
    var2 = create_direct_heli_path(var1);
  }

  self.spawn_point.vehicle = undefined;
}

function check_for_unloading_func(var0) {
  if(isDefined(level.unloading_func[var0])) {
    self thread[[level.unloading_func[var0]]]();
    return;
  }
}

function watch_for_all_passengers_dead(var0, var1) {
  self notify("watch_for_all_passengers_dead");
  self endon("watch_for_all_passengers_dead");
  self endon("death");
  self endon("unloading");
  self waittill("guy_entered");
  self waittill("spawning_done");

  for(;;) {
    var2 = reflectbolt(1);

    if(var2 <= 0) {
      delete_nav_obstacle();
      self notify("all_passengers_dead");
      self notify("newpath");
      self vehicle_setspeedimmediate(0, 30, 30);
      thread hudattractionobj(var1);
      break;
    }

    wait 0.2;
  }
}

function hudattractionobj(var0, var1) {
  var2 = self.riders;

  if(isDefined(var1)) {
    var2 = var1;
  }

  for(var3 = 0; var3 < var2.size; var3++) {
    var4 = var2[var3];

    if(!isent(var4) || isagent(var4)) {
      continue;
    }

    var5 = spawnStruct();
    var5.origin = var4.origin;
    var5.angles = var4.angles;
    var5.vehicle_position = var4.vehicle_position;
    var5.specs = var4.specs;

    if(isDefined(self.convoy)) {
      lastteamused(level, self);
    }

    ref_12bcd(var4);
    var6 = var5.vehicle_position;
    var5.vehicle_position = undefined;
    var5.specs = "vehicle_ai";
    var7 = scripts\cp\cp_modular_spawning::spawn_soldier_scripted_internal(var0, var5, 0, "vehicle_ai", undefined, 1);

    if(isDefined(var7)) {
      var7.forced_startingposition = var6;

      if(istrue(self.ref_13898)) {
        var7.ignoreall = 0;
        var7.sightmaxdistance = 2200;
        var7 thread scripts\cp\coop_stealth::run_common_functions(var7, 1, 1, 60, 160000);
      }

      thread scripts\common\vehicle_aianim::guy_enter(var7);
    }

    if(isent(var4)) {
      var4 delete();
    }
  }

  scripts\common\vehicle::vehicle_unload();
}

function lastteamused(var0) {
  level endon("game_ended");

  if(!isDefined(var0.convoy)) {
    return;
  }

  var0.convoy endon("event_convoy_delete");
  var0.convoy endon("death");
  var0 endon("death");
  var1 = var0.convoy;

  if(istrue(var1.kiosksearchradiusidealmax)) {
    thread lasttimedamagecalledout();

    while(istrue(var1.kiosksearchradiusidealmax)) {
      wait 0.5;
    }

    return;
  }

  var2 = 28;

  if(getaiarray("axis").size > var2) {
    var1.kiosksearchradiusidealmax = 1;
    scripts\cp\cp_modular_spawning::pause_group_by_group_name("wave_spawning");

    while(getaiarray("axis").size > var2) {
      wait 0.5;
    }

    var1.kiosksearchradiusidealmax = undefined;
    var1 notify("delayed_depositing_undefined");
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

function slide_trig(var0) {
  self notify("heli_watch_for_fly_away");
  self endon("heli_watch_for_fly_away");
  self endon("death");
  self waittill("guy_entered");
  self waittill("spawning_done");
  thread ref_143a4(var0);
  thread ref_143ea(var0);
}

function ref_143ea(var0) {
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
  thread recently_spawned_vehicle(var0);
  self notify("all_valid_passengers_are_gone");
}

function ref_143a4(var0) {
  self notify("waittill_all_valid_ai_are_gone");
  self endon("waittill_all_valid_ai_are_gone");
  self endon("death");
  self endon("unloaded");

  for(;;) {
    var1 = reflectbolt();
    var2 = reflectbolt(1);
    var3 = reflectprojectile(1);

    if(var2 <= 0 || var3 <= 0) {
      if(isDefined(self.spawn_point) && isDefined(self.spawn_point.wavesv_finite_ending)) {
        if(isDefined(level.sixthsenselastvotime)) {
          [[level.sixthsenselastvotime]](self);
        }

        return;
      }

      thread recently_spawned_vehicle(var0);
      self notify("newpath");
      delete_nav_obstacle();
      self notify("all_valid_passengers_are_gone");
      break;
    }

    wait 0.2;
  }
}

function recently_spawned_vehicle(var0) {
  self endon("death");
  thread ref_11b04();
  var1 = getgroundposition(self.origin, 1);

  if(distancesquared(self.origin, var1) <= 2250000) {
    var2 = spawnStruct();
    var2.origin = var1 + (0, 0, 1500);
    var2.angles = self.angles;
    var2.script_goalyaw = 1;
    thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var2);
    self setneargoalnotifydist(512);
    scripts\engine\utility::ref_143a5("near_goal", "goal");
  }

  var3 = get_best_end_point(var0, self.spawn_point, self.angles);

  if(!isDefined(var3)) {
    var3 = scripts\engine\utility::random(scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var0].exit_points, "targetname"));
  }

  var4 = duplicate_struct(var3);
  var5 = anglesToForward(vectortoangles(var4.origin - self.origin)) * 10000;
  var4.origin += (var5[0], var5[1], var4.origin[2]);
  var4.targetname = create_unique_kvp_string();
  self.end_point = var4;
  var6 = var4;

  if(getdvarint("scr_direct_heli_path_debug", 0)) {
    thread scripts\engine\utility::draw_capsule(var4.origin, 32, 32, (0, 0, 0), (1, 0, 0), 0, 250);
  }

  thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var4);
}

function ref_11b04() {
  level endon("game_ended");
  self endon("death");
  wait 2;

  if(isDefined(self.riders) && self.riders.size > 0) {
    for(var0 = 0; var0 < self.riders.size; var0++) {
      self.riders[var0].ref_11e52 = 1;
    }

    return;
  }
}

function cant_get_out_num() {
  var0 = 0;

  if(isDefined(level.vehicle.templates.aianims)) {
    if(isDefined(self.classname_mp) && isDefined(level.vehicle.templates.aianims[self.classname_mp])) {
      for(var1 = 0; var1 < self.riders.size; var1++) {
        var2 = self.riders[var1];

        if(!isDefined(var2.vehicle_position)) {
          continue;
        }

        var3 = level.vehicle.templates.aianims[self.classname_mp][var2.vehicle_position];

        if(!isDefined(var3.getout)) {
          var0++;
        }
      }
    } else if(isDefined(level.vehicle.templates.aianims[self.classname])) {
      for(var1 = 0; var1 < self.riders.size; var1++) {
        var2 = self.riders[var1];
        var3 = level.vehicle.templates.aianims[self.classname][var2.vehicle_position];

        if(!isDefined(var3.getout)) {
          var0++;
        }
      }
    }
  }

  return var0;
}

function reflectbolt(var0) {
  var1 = 0;

  foreach(var3 in self.riders) {
    if(istrue(var0)) {
      if(isalive(var3)) {
        var1++;
      }

      continue;
    }

    var1++;
  }

  return var1;
}

function reflectprojectile(var0, var1) {
  var2 = 0;

  if(isDefined(self.classname_mp)) {
    if(isDefined(level.vehicle) && isDefined(level.vehicle.templates) && isDefined(level.vehicle.templates.aianims) && isDefined(level.vehicle.templates.aianims[self.classname_mp])) {
      for(var3 = 0; var3 < self.riders.size; var3++) {
        var4 = self.riders[var3];

        if(!isalive(var4)) {
          continue;
        }

        if(!isai(var4)) {
          continue;
        }

        if(!isDefined(var4.vehicle_position)) {
          continue;
        }

        if(scripts\common\vehicle_aianim::check_unloadgroup(var4.vehicle_position)) {
          var5 = level.vehicle.templates.aianims[self.classname_mp][var4.vehicle_position];

          if(isDefined(var5.getout)) {
            var2++;
          }
        }
      }
    }
  }

  return var2;
}

function unload_when_near_players() {
  self endon("unload");
  self endon("death");

  for(;;) {
    wait 1;

    if(scripts\engine\utility::get_array_of_closest(self.origin, level.players, undefined, 1, 512).size) {
      if(isDefined(self.riders)) {
        for(var0 = 0; var0 < self.riders.size; var0++) {
          var1 = self.riders[var0];
          var1 scripts\common\utility::demeanor_override("combat");
        }
      }

      break;
    }
  }
}

function create_vehicle_path(var0) {
  level notify("create_vehicle_path");
  var1 = level.next_index;
  level.next_index++;

  if(isDefined(self.spawn_point.veh_model_spawner)) {
    self.allow_unload_on_path = 1;
    var2 = create_path_to_delete_node(var0, var1);
    var3 = undefined;
    return var2;
  } else {
    var2 = duplicate_struct(self.veh_spawn_point);
    add_targetname_kvps(var2, undefined, var2 + var3 + "_start");
    self.currentnode = var2;
    var4 = create_simple_path(self.currentnode, self.angles, var3, var2, "_end_node_pathing_", (1, 1, 0));

    if(var4) {
      return var2;
    }
  }

  var3 = duplicate_struct(self.spawn_point);
  var5 = undefined;

  if(isDefined(var3) && isDefined(self.veh_spawn_point) && isDefined(self.veh_spawn_point.script_linkto)) {
    var6 = get_veh_linked_structs(self.veh_spawn_point);
    var7 = -5;

    foreach(var9 in var6) {
      var10 = scripts\engine\math::get_dot(self.origin, self.angles, var9.origin);
      var11 = scripts\engine\math::get_dot(self.origin, vectortoangles(var3.origin - self.origin), var9.origin);
      var12 = var10 + var11;

      if(var12 > var7) {
        var7 = var12;
        var5 = var9;
      }
    }
  }

  if(!isDefined(var5)) {
    var14 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var2].path_start_points, "targetname");

    if(!isDefined(var14) || var14.size < 1) {
      var14 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var2].path_start_points, "script_linkName");
    }

    if(!isDefined(var14) || var14.size < 1) {
      return;
    }

    var5 = scripts\engine\utility::getclosest(self.origin, var14);
  }

  if(!isDefined(var5)) {
    return;
  }

  var15 = duplicate_struct(var5);
  var15.angles = vectortoangles(var15.origin - self.origin);

  if(false) {
    level thread scripts\cp\utility::draw_line_until_endons(self.spawn_point.origin, 1, 1, 1, "create_vehicle_path");
    level thread scripts\cp\utility::draw_line_until_endons(var15.origin, 0, 1, 0, "create_vehicle_path");
    level thread scripts\cp\utility::draw_line_until_endons(var3.origin, 1, 1, 0, "create_vehicle_path");
  }

  add_targetname_kvps(var15, undefined, var2 + var3 + "_start");
  create_path_from_struct_to_struct(var15, var3, var3, var2, "_unload_pathing_", (1, 1, 1));
  scripts\engine\utility::thread_on_notify("unloaded", &create_path_to_delete_node, var2, var3, self);
  scripts\engine\utility::thread_on_notify_no_endon_death("death", &reset_spawn_point_targetname, self.spawn_point, undefined, self);
  self.disabled_nodes = undefined;
  return var15;
}

function create_path_to_delete_node(var0, var1) {
  var2 = self.spawn_point;
  self.currentnode = var2;
  var3 = create_simple_path(self.currentnode, self.angles, var1, var0, "_end_node_pathing_", (1, 1, 0));

  if(!var3) {
    var4 = get_best_end_point(var0, self.currentnode);
    var5 = duplicate_struct(var4);
    self.path_gobbler = 1;
    self.end_point = var5;

    if(false) {
      level thread scripts\cp\utility::draw_line_until_endons(var5.origin, 1, 0, 0, "create_vehicle_path");
    }

    create_path_from_struct_to_struct(self.currentnode, var5, var1, var0, "_end_node_pathing_", (1, 1, 0));
  }

  if(scripts\engine\math::is_point_in_front(self.currentnode.origin) || self.spawn_point.origin == self.currentnode.origin) {
    self.target = self.pathing_array[1].targetname;
  } else if(!var3) {
    self.target = self.pathing_array[1].targetname;
  } else {
    self.pathing_array = scripts\engine\utility::array_remove_index(self.pathing_array, 0);
  }

  self.disabled_nodes = undefined;
  return self.currentnode;
}

function start_struct_path(var0, var1) {
  self notify("start_struct_path");
  self endon("start_struct_path");
  self endon("death");
  self startpathnodes(var0, var1, 0, 0.5, 0.5, 1);
  var2 = 1;
  var3 = self.pathing_array[var2];
  var4 = self.pathing_array[var2];
  var5 = 62500;

  if(!isDefined(var3)) {
    return;
  }

  thread process_nextpoint_after_struct_wait(var3, var5);

  for(;;) {
    self waittill("trigger", var6, var7, var8, var9);

    if(isint(var6)) {
      if(var2 < var6 + 1) {
        var2 = var6 + 1;
        var3 = get_next_node_on_spline(var2);

        if(isDefined(var3)) {
          var4 = var3;
          thread process_nextpoint_after_struct_wait(var3, var5);
          continue;
        }

        break;
      }
    }
  }
}

function ref_14205(var0) {
  level endon("game_ended");
  self endon("death");
  self notify("vehicle_process_node_when_at_goal");
  self endon("vehicle_process_node_when_at_goal");
  var1 = 12500;
  var2 = 1;
  var3 = self.pathing_array[var2];
  var4 = self.pathing_array[var2];
  level.ref_1421f = self;
  jumpiffalse(istrue(var0)) LOC_0000004e;
  thread process_nextpoint_after_struct_wait(var3, var1);

  for(;;) {
    self waittill("trigger", var5, var6, var7, var8);

    if(isint(var5)) {
      if(var2 < var5 + 1) {
        if(isDefined(self.path_gobbler)) {
          scripts\engine\utility::deletestruct_ref(var3);
        }

        var2 = var5 + 1;
        var3 = get_next_node_on_spline(var2);

        if(isDefined(var3)) {
          var4 = var3;
          self notify("new_next_point");

          if(istrue(var0)) {
            thread process_nextpoint_after_struct_wait(var3, var1);
          }

          continue;
        }

        break;
      }
    }
  }
}

function process_nextpoint_after_struct_wait(var0, var1) {
  self notify("process_nextPoint_after_struct_wait");
  self endon("process_nextPoint_after_struct_wait");
  self endon("death");

  while(distancesquared(self.origin, var0.origin) > var1) {
    wait 0.1;
  }

  process_vehicle_struct_node(var0);
}

function process_vehicle_struct_node(var0) {
  self endon("newpath");
  self endon("death");
  var1 = scripts\common\vehicle_paths::get_path_getfunc(var0);
  var2 = undefined;
  self.currentnode = var0;
  scripts\common\vehicle_paths::trigger_process_node(var0);

  if(scripts\common\vehicle_paths::vehicle_should_unload(&scripts\common\vehicle_paths::node_wait, var0)) {
    self vehicle_setspeedimmediate(0, 1, 1);
    struct_path_unload_node(var0);
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

function struct_path_unload_node(var0) {
  self endon("death");

  if(isDefined(self.ent_flag["prep_unload"]) && scripts\engine\utility::ent_flag("prep_unload")) {
    return;
  }

  if(!isDefined(var0.script_flag_wait) && !isDefined(var0.script_delay)) {}

  var1 = getnode(var0.targetname, "target");

  if(isDefined(var1) && self.riders.size) {
    foreach(var3 in self.riders) {
      if(isai(var3)) {
        var3 thread scripts\engine\utility::script_func("go_to_node", var1);
      }
    }
  }

  if(scripts\common\vehicle_code::ishelicopter_internal()) {
    self sethoverparams(0, 0, 0);
    scripts\common\vehicle_code::waittill_stable(var0);
  }

  if(isDefined(var0.script_noteworthy)) {
    if(var0.script_noteworthy == "wait_for_flag") {
      scripts\engine\utility::flag_wait(var0.script_flag);
    }
  }

  if(isDefined(var0.script_unload)) {
    if(var0.script_unload == "1") {
      var0.script_unload = "default";
    }
  }

  scripts\common\vehicle_code::_vehicle_unload(var0.script_unload);

  if(scripts\common\vehicle_aianim::riders_unloadable(var0.script_unload)) {
    self waittill("unloaded");
  }

  if(isDefined(var0.script_flag_wait) || isDefined(var0.script_delay)) {
    return;
  }
}

function get_next_node_on_spline(var0) {
  if(!isDefined(var0)) {
    return undefined;
  }

  if(!isDefined(self.pathing_array)) {
    return undefined;
  }

  if(isDefined(self.pathing_array[var0])) {
    return self.pathing_array[var0];
  }

  return undefined;
}

function create_simple_path(var0, var1, var2, var3, var4, var5) {
  level endon("game_ended");
  self endon("death");
  var6 = 1;
  var7 = var0;
  var8 = -0.3;
  self.pathing_array = [var0];

  if(false) {
    level.players[0] notifyonplayercommand("use", "+usereload");
    level.players[0] notifyonplayercommand("use", "+activate");
  }

  jumpiffalse(isDefined(var7.script_linkto)) LOC_00000091;
  var9 = duplicate_struct(var7);
  add_targetname_kvps(var9, undefined, var3 + var2 + "_start");
  self.currentnode = var9;
  var7 = self.currentnode;

  for(;;) {
    if(false) {
      level.players[0] waittill("use");
    }

    if(isDefined(var7.script_linkto)) {
      var10 = get_veh_linked_structs(var7);
      var11 = [];
      var12 = -1;
      var13 = undefined;

      if(var10.size == 1) {
        var11 = var10[0];
      } else {
        for(var14 = 0; var14 < var10.size; var14++) {
          var15 = var10[var14];

          if(!isDefined(var13)) {
            var13 = var15;
          }

          var16 = scripts\engine\math::get_dot(var7.origin, var1, var15.origin);

          if(var16 >= var8) {
            var11 = var15;
          }
        }
      }

      if(var11.size < 1 && isDefined(var13)) {
        var11 = var13;
      }

      if(var11.size > 0) {
        var17 = scripts\engine\utility::random(var11);
        var17 = duplicate_struct(var17);
        self.path_gobbler = 1;
        self.pathing_array[self.pathing_array.size] = var17;
        add_targetname_kvps(var17, var7, var3 + "_" + var2 + "_simple_path_" + self.pathing_array.size);

        if(false) {
          level thread scripts\cp\utility::draw_line_until_endons(var7.origin, 1, 1, 1, "create_vehicle_path", var17.origin);
        }

        var7 = var17;
      } else {
        break;
      }

      continue;
    }

    if(isDefined(var7.target)) {
      var10 = var7 scripts\engine\utility::get_target_array();
      var11 = [];
      var12 = -1;
      var13 = undefined;

      for(var14 = 0; var14 < var10.size; var14++) {
        var15 = var10[var14];
        var16 = scripts\engine\math::get_dot(var7.origin, var1, var15.origin);

        if(var16 >= var8) {
          var11 = var15;
          continue;
        }

        if(var16 >= var12) {
          var13 = var10[var14];
        }
      }

      if(var11.size < 1 && isDefined(var13)) {
        var11 = var13;
      }

      if(var11.size > 0) {
        var17 = scripts\engine\utility::random(var11);

        if(scripts\engine\utility::array_contains(self.pathing_array, var17)) {
          self.pathing_array[self.pathing_array.size] = var17;
          self.ref_119e3 = 1;
          break;
        }

        self.pathing_array[self.pathing_array.size] = var11;

        if(false) {
          level thread scripts\cp\utility::draw_line_until_endons(var4.origin, 1, 1, 1, "create_vehicle_path", var11.origin);
        }

        var4 = var11;
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
  var0 = [];
  var1 = undefined;

  for(var2 = 0; var2 < self.pathing_array.size; var2++) {
    var0 = self.pathing_array[var2];
    var1 = self.pathing_array[var2];

    if(var2 > 0 && var2 % 27 == 0) {
      self.pathing_arrays[self.pathing_arrays.size] = var0;
      var0 = [];
      var0 = var1;
    }
  }

  if(var0.size == 1) {
    var3 = spawnStruct();
    var3.origin = (var0[0].origin + var1.origin) / 2;
    var0 = var0[0];
    var0 = var3;
  }

  if(var0.size > 0) {
    self.pathing_arrays[self.pathing_arrays.size] = var0;
    return;
  }
}

function create_path_from_struct_to_struct(var0, var1, var2, var3, var4, var5) {
  level endon("game_ended");
  self endon("death");
  var6 = var0;
  var6.angles = self.angles;
  var7 = undefined;
  var8 = 1;
  var9 = 0;
  var0.pathing_index = 0;

  if(isDefined(self.disabled_nodes)) {
    self.disabled_nodes = undefined;
  }

  if(isDefined(self.pathing_array)) {
    foreach(var11 in self.pathing_array) {
      if(isDefined(var11)) {
        var11.previous_struct = undefined;
        var11.antepenultimate_struct = undefined;
      }
    }
  }

  self.pathing_array = [var0];

  if(false) {
    announcement("Waiting for player use");
    level.players[0] notifyonplayercommand("use", "+usereload");
    level.players[0] notifyonplayercommand("use", "+activate");
  }

  for(;;) {
    if(false) {
      level.players[0] waittill("use");
    }

    var6 = find_closest_path_struct(var6, var1, var3 + var2 + var4 + var9, var5, var3);

    if(isDefined(var6)) {
      if(!isDefined(var6.pathing_index)) {
        var6.pathing_index = self.pathing_array.size;
        self.pathing_array[self.pathing_array.size] = var6;

        if(false) {
          if(isDefined(var6.previous_struct)) {
            level thread scripts\cp\utility::draw_line_until_endons(var6.previous_struct.origin, var5[0], var5[1], var5[2], ["create_vehicle_path", "kill_debug_" + var6.pathing_index], var6.origin);
          }
        }
      }

      if(var6.origin == var1.origin) {
        break;
      }
    } else {
      break;
    }

    if(var9 > 1000) {
      self notify("no_good_path_found");
      break;
    }

    var9++;
  }

  for(var13 = 0; var13 < self.pathing_array.size - 1; var13++) {
    self.pathing_array[var13].target = self.pathing_array[var13 + 1].targetname;
  }

  if(self.pathing_array.size > 27) {
    split_large_pathing_array();
    return;
  }
}

function find_closest_path_struct(var0, var1, var2, var3, var4) {
  self notify("find_closest_path_struct");

  if(false) {
    level thread scripts\cp\utility::drawsphere(var0.origin, 24, 1, (1, 1, 1));
  }

  var5 = undefined;
  var6 = sortbydistance(get_veh_linked_structs(var0), var1.origin);

  if(var6.size < 1) {
    var7 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var4].path_start_points, "targetname");

    if(!isDefined(var7) || var7.size < 1) {
      var7 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var4].path_start_points, "script_linkName");
    }

    if(!isDefined(var7) || var7.size < 1) {
      return;
    }

    var8 = scripts\engine\utility::get_array_of_closest(var0.origin, var7, [var0], 3);

    foreach(var10 in var8) {
      var6 = var10;
      var6 = scripts\engine\utility::array_combine(var6, sortbydistance(get_veh_linked_structs(var10), var10.origin));
    }
  }

  var12 = [];
  var13 = -5;
  var14 = 20000;
  var15 = -5;
  var16 = undefined;
  var17 = 0;

  foreach(var10 in var6) {
    var19 = var10;

    foreach(var21 in self.pathing_array) {
      if(istrue(var21.disabled) || var10.origin == var21.origin) {
        var19 = undefined;
        break;
      }
    }

    if(isDefined(var19)) {
      var12 = var19;
    }
  }

  var0.rewinding_path = undefined;

  if(var12.size > 1) {
    if(istrue(0)) {}

    self.pathing_array[self.pathing_array.size - 1].was_branch = 1;
  }

  if(is_linked_struct(var0, var1)) {
    var5 = var1;
  } else if(var12.size > 0) {
    if(istrue(0)) {
      foreach(var25 in var12) {}
    }

    var5 = calc_best_closest_struct(var0, var1, var12);
  }

  if(!isDefined(var5) && isDefined(var16)) {
    var5 = var16;
  }

  if(isDefined(var5)) {
    var5.angles = vectortoangles(var5.origin - var0.origin);

    if(var5.origin != var1.origin) {
      var5 = duplicate_struct(var5);
    }

    var5.previous_struct = var0;

    if(isDefined(var0.previous_struct)) {
      var5.antepenultimate_struct = var0.previous_struct;
    }

    add_targetname_kvps(var5, var0, var2);
    return var5;
  }

  if(!isDefined(var5)) {
    var5 = step_back_to_last_good_branch(var0, var1);

    if(isDefined(var5)) {
      add_targetname_kvps(var5, var0, var2);
    }
  }

  return var5;
}

function is_linked_struct(var0, var1) {
  if(isDefined(var0.script_linkto) && isDefined(var1.script_linkname)) {
    var2 = var0 scripts\engine\utility::get_links();

    foreach(var4 in var2) {
      if(var1.script_linkname == var4) {
        return true;
      }
    }
  }

  return false;
}

function print_debug_info(var0, var1, var2, var3, var4, var5) {
  self endon(var5);
  self endon("death");
  var6 = istrue(self.pathing_array[self.pathing_array.size - 1].was_branch);

  for(;;) {
    waitframe();
  }
}

function get_veh_linked_structs() {
  var0 = [];

  if(isDefined(self.script_linkto)) {
    var1 = scripts\engine\utility::get_links();

    for(var2 = 0; var2 < var1.size; var2++) {
      var3 = scripts\engine\utility::getStructArray(var1[var2], "script_linkname");

      if(var3.size > 0) {
        var0 = scripts\engine\utility::array_combine(var0, var3);
      }
    }
  }

  return var0;
}

function calc_best_closest_struct(var0, var1, var2) {
  var3 = 1000000;
  var4 = 360;
  var5 = -50;
  var6 = undefined;
  var7 = 0.5;

  for(var8 = 0; var8 < var2.size; var8++) {
    if(var2[var8].origin == var0.origin) {
      var0 = var0.previous_struct;
    }
  }

  var9 = -5;
  var10 = distance(var1.origin, var0.origin);

  foreach(var12 in var2) {
    var13 = 5;
    var14 = 5;
    var15 = 0;
    var16 = undefined;
    var17 = -5;

    if(var12 == var0) {
      continue;
    }

    if(var12.origin == var0.origin) {
      continue;
    }

    if(isDefined(var0.previous_struct) && var0.previous_struct.origin == var12.origin) {
      continue;
    }

    if(isDefined(var0.antepenultimate_struct) && var0.antepenultimate_struct.origin == var12.origin) {
      continue;
    }

    if(isDefined(var12.script_noteworthy) && var12.script_noteworthy == "deleteme" && var12.origin != var1.origin) {
      continue;
    }

    if(!istrue(self.allow_unload_on_path) && isDefined(var12.script_unload) && var12.origin != var1.origin) {
      continue;
    }

    if(istrue(var12.disabled)) {
      continue;
    }

    if(check_all_previous_in_pathing(var12, 30)) {
      continue;
    }

    if(istrue(struct_is_personally_disabled(var12))) {
      continue;
    }

    var18 = distance(var0.origin, var12.origin);

    if(var12.origin == var1.origin && var18 > 1250) {
      continue;
    }

    var18 = distance(var1.origin, var12.origin);
    var19 = vectortoangles(var1.origin - var0.origin);

    if(!isDefined(var0.angles)) {
      var0.angles = (0, 0, 0);
    }

    var20 = scripts\engine\math::get_dot(var0.origin, var0.angles, var12.origin);
    var20 = scripts\engine\math::normalize_value(-0.5, 0.8, var20);
    var21 = scripts\engine\math::get_dot(var0.origin, var19, var12.origin);
    var21 = scripts\engine\math::normalize_value(-0.8, 0.8, var21);
    var22 = scripts\engine\math::normalize_value(0, 2000, var18);
    var22 = 1 - var22;
    var17 = var20 + var21 + var22;

    if(var20 < 0.25) {
      var17 -= 10;
    }

    if(false) {
      thread print_debug_info(var12, var21, var20, var18, var17, "find_closest_path_struct");
    }

    if(var17 > var5) {
      var6 = var12;
      var5 = var17;
    }
  }

  if(isDefined(var6)) {}

  return var6;
}

function get_best_end_point(var0, var1, var2) {
  if(isDefined(var1.script_linkto)) {
    var3 = get_veh_linked_structs(var1);

    for(var4 = 0; var4 < var3.size; var4++) {
      if(scripts\engine\utility::is_equal(level.ai_spawn_vehicle_func[var0].exit_points, var3[var4].targetname)) {
        return var3[var4];
      }
    }
  }

  var5 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var0].exit_points, "targetname");
  var6 = -5;
  var7 = undefined;
  var8 = scripts\engine\utility::get_array_of_closest(var1.origin, var5, [var1]);

  if(isDefined(var1.angles)) {
    var2 = var1.angles;
  }

  foreach(var10 in var8) {
    var11 = scripts\engine\math::get_dot(var1.origin, var2, var10.origin);

    if(var11 > var6) {
      if(getdvarint("scr_direct_heli_path_debug", 0)) {
        thread scripts\engine\utility::draw_capsule(var10.origin, 32, 32, (0, 0, 0), (1, 0, 0), 0, 250);
      }

      var6 = var11;
      var7 = var10;
    }
  }

  return var7;
}

function check_all_previous_in_pathing(var0, var1) {
  if(!isDefined(self.pathing_array)) {
    return false;
  }

  if(!isDefined(var1)) {
    var1 = self.pathing_array.size;
  }

  for(var2 = 0; var2 < var1; var2++) {
    if(isDefined(self.pathing_array[var2]) && self.pathing_array[var2].origin == var0.origin) {
      return true;
    }
  }

  return false;
}

function struct_is_personally_disabled(var0) {
  if(!isDefined(self.disabled_nodes)) {
    return false;
  }

  for(var1 = self.disabled_nodes.size - 1; var1 >= 0; var1--) {
    if(self.disabled_nodes[var1].origin == var0.origin) {
      return true;
    }
  }

  return false;
}

function step_back_to_last_good_branch(var0, var1) {
  var2 = undefined;
  var3 = undefined;
  var4 = [];
  var5 = 0;
  var6 = self.pathing_array.size - 1;

  while(var6 >= 0) {
    if(var5 > 0) {
      break;
    }

    if(istrue(self.pathing_array[var6].was_branch)) {
      var7 = get_veh_linked_structs(self.pathing_array[var6]);

      for(var8 = 0; var8 < var7.size; var8++) {
        if(is_this_a_valid_node(var7[var8])) {
          var4 = var7[var8];
        }
      }

      if(var4.size > 0) {
        if(var4.size == 1) {
          var9 = var4[0];
        } else {
          var9 = calc_best_closest_struct(var1, var2, var5);
        }

        var6 = var7;
        var4 = var9;

        if(istrue(0)) {}

        break;
      } else {
        disable_this_node_for_us(self.pathing_array[var5]);
      }
    } else {
      disable_this_node_for_us(self.pathing_array[var5]);
    }

    var5--;
  }

  if(isDefined( < error > .previous_struct)) {
    if(isDefined(var2)) {
      var1 = var2;

      if(isDefined(self.pathing_array[var4 - 1])) {
        var1.previous_struct = self.pathing_array[var4 - 1];
      }

      if(isDefined(self.pathing_array[var4 - 2])) {
        var1.antepenultimate_struct = self.pathing_array[var4 - 2];
      }
    } else {
      var1 = self.pathing_array[0];
    }

    if(isDefined(var1)) {
      var1.rewinding_path = 1;
    }
  }

  if(isDefined(var1)) {}

  return var1;
}

function is_this_a_valid_node(var0) {
  if(istrue(var0.disabled)) {
    return false;
  }

  for(var1 = self.pathing_array.size - 1; var1 >= 0; var1--) {
    if(self.pathing_array[var1].origin == var0.origin) {
      return false;
    }
  }

  for(var1 = self.disabled_nodes.size - 1; var1 >= 0; var1--) {
    if(self.disabled_nodes[var1].origin == var0.origin) {
      return false;
    }
  }

  return true;
}

function disable_this_node_for_us(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(self.disabled_nodes)) {
    self.disabled_nodes = [];
  }

  if(scripts\engine\utility::array_contains(self.disabled_nodes, var0)) {
    return;
  }

  self.disabled_nodes[self.disabled_nodes.size] = var0;

  if(istrue(0)) {}

  level notify("kill_debug_" + var0.pathing_index);
  self.pathing_array = scripts\engine\utility::array_remove(self.pathing_array, var0);
}

function create_direct_heli_path(var0) {
  self endon("death");
  var1 = create_direct_path_from_landing_point(var0);
  thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var1);
}

function binding(var0, var1) {
  for(var2 = 0; var2 < var0.size; var2++) {
    var3 = var2 + 1;

    if(isDefined(var0[var3])) {
      var4 = vectortoangles(var0[var3].origin - var0[var2].origin);
      var0[var2].angles = (0, var4[1], 0);
      continue;
    }

    var4 = vectortoangles(var1.origin - var0[var2].origin);
    var0[var2].angles = (0, var4[1], 0);

    if(!isDefined(var1.angles) || var1.angles == (0, 0, 0)) {
      var1.angles = (0, var4[1], 0);
    }

    break;
  }
}

function create_direct_path_from_landing_point(var0) {
  var1 = create_unique_kvp_string();
  var2 = var1;
  var3 = duplicate_struct(self.spawn_point);
  var3.targetname = var1;
  scripts\cp\utility::addtostructarray("targetname", var3.targetname, var3);
  var4 = [];

  if(isDefined(var3.script_linkto)) {
    var4 = build_path_from_script_linkTo(var3, var0);
  }

  if(var4.size > 0) {
    binding(var4, var3);
    var5 = self.spawn_point.origin;

    for(var6 = 0; var6 < self.riders.size; var6++) {
      if(isalive(self.riders[var6]) && isai(self.riders[var6])) {
        self.riders[var6] scripts\cp\cp_modular_spawning::set_goal_pos(var5);
      }
    }

    if(getdvarint("scr_direct_heli_path_debug", 0)) {
      thread scripts\engine\utility::draw_line_for_time(self.veh_spawn_point.origin, var4[0].origin, 1, 1, 1, 60);
    }

    return var4[0];
  }

  if(isDefined(var5.script_linkname)) {
    var7 = [];
    var8 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var2].path_start_points, "script_linkname");

    if(!isDefined(var8) || var8.size < 1) {
      var8 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var2].path_start_points, "targetname");
    }

    if(!isDefined(var8) || var8.size < 1) {
      return;
    }

    var9 = var5.script_linkname;

    for(var6 = 0; var6 < var8.size; var6++) {
      if(scripts\engine\utility::is_equal(var8[var6].script_linkto, var9)) {
        var10 = [];
        var11 = duplicate_struct(var8[var6]);
        var11.target = var4;
        scripts\cp\utility::addtostructarray("target", var4, var11);
        var11.targetname = create_unique_kvp_string();
        scripts\cp\utility::addtostructarray("targetname", var11.targetname, var11);
        var10 = get_linkto_structs_return_to_array(var11, var10, var8);

        if(var10.size > 0) {
          var7 = var10;
        }
      }
    }

    if(var7.size > 0) {
      var12 = [];
      var6 = 0;

      if(var6 < var7.size) {
        thread cleanup_unused_paths(var7[var6], var7[var6][var7[var6].size - 1]);
        GscBinSkip0(0x2e, var12.size, var7[var6][var7[var6].size - 1]);
      }

      var13 = scripts\engine\math::get_mid_point(var5.origin, self.origin);

      if(getdvarint("scr_direct_heli_path_debug", 0)) {
        thread scripts\engine\utility::draw_capsule(self.origin, 32, 32, (0, 0, 0), (0, 1, 0), 0, 250);
        thread scripts\engine\utility::draw_capsule(self.spawn_point.origin, 32, 32, (0, 0, 0), (0, 1, 0), 0, 250);
        thread scripts\engine\utility::draw_capsule(var13, 32, 32, (0, 0, 0), (1, 1, 0), 0, 250);
      }

      var14 = scripts\engine\utility::getclosest(var13, var12);

      if(getdvarint("scr_direct_heli_path_debug", 0)) {
        thread scripts\engine\utility::draw_line_for_time(var14.origin, self.origin, 1, 0, 0, 10);
      }

      if(isDefined(var14.target)) {
        var15 = var14 scripts\engine\utility::get_target_array();

        for(var6 = 0; var6 < var15.size; var6++) {
          if(getdvarint("scr_direct_heli_path_debug", 0)) {
            thread scripts\engine\utility::draw_line_for_time(var14.origin, var15[var6].origin, 1, 0, 0, 12.5);
            thread scripts\engine\utility::draw_capsule(var15[var6].origin, 32, 32, (0, 0, 0), (0, 1, 1), 0, 250);
          }

          if(var6 >= var15.size - 1) {
            if(getdvarint("scr_direct_heli_path_debug", 0)) {
              thread scripts\engine\utility::draw_line_for_time(var5.origin, var15[var6].origin, 1, 0, 0, 12.5);
            }
          }
        }
      }

      if(getdvarint("scr_direct_heli_path_debug", 0)) {
        thread scripts\engine\utility::draw_capsule(var14.origin, 32, 32, (0, 0, 0), (0, 1, 1), 0, 250);
      }

      var14 notify("path_chosen");
      self notify("path_chosen");
      return var14;
    }

    var6 = [];
    var14 = create_entrance_points(var8);

    if(isDefined(var14)) {
      var14.target = var7;
      scripts\cp\utility::addtostructarray("target", var7, var14);
      var14.targetname = create_unique_kvp_string();
      scripts\cp\utility::addtostructarray("targetname", var14.targetname, var14);

      if(getdvarint("scr_direct_heli_path_debug", 0)) {
        thread scripts\engine\utility::draw_capsule(var14.origin, 32, 32, (0, 0, 0), (0, 1, 1), 0, 250);
        thread scripts\engine\utility::draw_capsule(var8.origin, 32, 32, (0, 0, 0), (0, 1, 0), 0, 250);
      }

      return var14;
    }

    return var8;
  }

  return var9;
}

function brjugg_initexternalfeatures(var0) {
  if(isDefined(level.vehicle_builds[var0])) {
    return istrue(level.vehicle_builds[var0].brjugg_initfeatures);
  }

  return 0;
}

function build_path_from_script_linkTo(var0) {
  var1 = [];
  var2 = scripts\engine\utility::get_links();
  var3 = undefined;

  for(var4 = 0; var4 < var2.size; var4++) {
    var5 = var2[var4];
    var6 = scripts\engine\utility::getStructArray(var5, "script_linkname");

    if(isDefined(var6) && var6.size > 0) {
      var6 = scripts\engine\utility::array_randomize(var6);

      for(var7 = 0; var7 < var6.size; var7++) {
        var8 = var6[var7];

        if(scripts\engine\utility::is_equal(var8.targetname, "heli_spawner")) {
          continue;
        }

        if(!brjugg_initexternalfeatures(var0)) {
          if(scripts\engine\utility::is_equal(var8.script_noteworthy, "deleteme")) {
            continue;
          }
        }

        var8 = duplicate_struct(var8);
        var1 = var8;
        var8.targetname = create_unique_kvp_string();
        scripts\cp\utility::addtostructarray("targetname", var8.targetname, var8);

        if(isDefined(var3)) {
          if(getdvarint("scr_direct_heli_path_debug", 0)) {
            thread scripts\engine\utility::draw_line_for_time(var3.origin, var8.origin, 1, 1, 1, 60);
          }

          var3.target = var8.targetname;
          scripts\cp\utility::addtostructarray("target", var3.target, var3);
        }

        var3 = var8;
        break;
      }
    }
  }

  if(var1.size > 0) {
    var1[var1.size - 1].target = self.targetname;
    scripts\cp\utility::addtostructarray("target", var1[var1.size - 1].target, var1[var1.size - 1]);

    if(getdvarint("scr_direct_heli_path_debug", 0)) {
      thread scripts\engine\utility::draw_line_for_time(var1[var1.size - 1].origin, self.origin, 1, 1, 1, 60);
    }
  }

  return var1;
}

function create_entrance_points(var0) {
  var1 = [];
  var2 = var0.origin;

  if(scripts\engine\trace::capsule_trace_passed(var2 + (1500, 0, 1500), var2, 256, 512, (0, 0, 0), level.characters)) {
    var3 = spawnStruct();
    var3.origin = var2 + (1500, 0, 1500);
    var1 = var3;
  }

  if(scripts\engine\trace::capsule_trace_passed(var2 + (-1500, 0, 1500), var2, 256, 512, (0, 0, 0), level.characters)) {
    var3 = spawnStruct();
    var3.origin = var2 + (-1500, 0, 1500);
    var1 = var3;
  }

  if(scripts\engine\trace::capsule_trace_passed(var2 + (0, -1500, 1500), var2, 256, 512, (0, 0, 0), level.characters)) {
    var3 = spawnStruct();
    var3.origin = var2 + (0, -1500, 1500);
    var1 = var3;
  }

  if(scripts\engine\trace::capsule_trace_passed(var2 + (0, 1500, 1500), var2, 256, 512, (0, 0, 0), level.characters)) {
    var3 = spawnStruct();
    var3.origin = var2 + (0, 1500, 1500);
    var1 = var3;
  }

  if(scripts\engine\trace::capsule_trace_passed(var2 + (-1500, 1500, 1500), var2, 256, 512, (0, 0, 0), level.characters)) {
    var3 = spawnStruct();
    var3.origin = var2 + (-1500, 1500, 1500);
    var1 = var3;
  }

  if(scripts\engine\trace::capsule_trace_passed(var2 + (-1500, -1500, 1500), var2, 256, 512, (0, 0, 0), level.characters)) {
    var3 = spawnStruct();
    var3.origin = var2 + (-1500, -1500, 1500);
    var1 = var3;
  }

  if(scripts\engine\trace::capsule_trace_passed(var2 + (1500, -1500, 1500), var2, 256, 512, (0, 0, 0), level.characters)) {
    var3 = spawnStruct();
    var3.origin = var2 + (1500, -1500, 1500);
    var1 = var3;
  }

  if(scripts\engine\trace::capsule_trace_passed(var2 + (1500, 1500, 1500), var2, 256, 512, (0, 0, 0), level.characters)) {
    var3 = spawnStruct();
    var3.origin = var2 + (1500, 1500, 1500);
    var1 = var3;
  }

  var4 = scripts\engine\math::get_mid_point(var0.origin, self.origin);

  if(getdvarint("scr_direct_heli_path_debug", 0)) {
    thread scripts\engine\utility::draw_capsule(var4, 32, 32, (0, 0, 0), (1, 1, 0), 0, 250);
  }

  var5 = scripts\engine\utility::getclosest(var4, var1);

  for(var6 = 0; var6 < var1.size; var6++) {
    if(var1[var6] != var5) {
      if(getdvarint("scr_direct_heli_path_debug", 0)) {
        thread scripts\engine\utility::draw_capsule(var1[var6].origin, 32, 32, (0, 0, 0), (1, 0, 0), 0, 250);
      }
    }
  }

  return var5;
}

function get_linkto_structs_return_to_array(var0, var1) {
  var0 = self;

  if(isDefined(self.script_linkname)) {
    var2 = self.script_linkname;

    for(var3 = 0; var3 < var1.size; var3++) {
      if(var1[var3].origin == self.origin) {
        continue;
      }

      if(scripts\engine\utility::is_equal(var1[var3].script_linkto, var2)) {
        var4 = duplicate_struct(var1[var3]);
        var4.target = self.targetname;
        scripts\cp\utility::addtostructarray("target", var4.target, var4);
        var4.targetname = create_unique_kvp_string();
        scripts\cp\utility::addtostructarray("targetname", var4.targetname, var4);
        var0 = var4;
        var0 = get_linkto_structs_return_to_array(var4, var0, var1);
      }
    }
  }

  return var0;
}

function cleanup_unused_paths(var0, var1) {
  var1 endon("path_chosen");
  self waittill("path_chosen");

  for(var2 = 0; var2 < var0.size; var2++) {
    scripts\engine\utility::deletestruct_ref(var0[var2]);
  }
}

function create_heli_path(var0) {
  self.veh_path = [];
  var1 = level.next_index;
  level.next_index++;
  var2 = scripts\engine\utility::random(scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var0].exit_points, "targetname"));
  var3 = duplicate_struct(var2);
  self.end_point = var3;
  thread begin_searching_for_landing_loc(undefined, var0, var1);
  scripts\engine\utility::thread_on_notify_no_endon_death("death", &reset_spawn_point_targetname, self.spawn_point, undefined, self);
}

function begin_searching_for_landing_loc(var0, var1, var2) {
  level endon("game_ended");
  self endon("death");
  self notify("begin_searching_for_landing_loc");
  self endon("begin_searching_for_landing_loc");
  self endon("all_passengers_dead");
  var3 = undefined;
  var4 = undefined;
  var5 = undefined;
  var6 = undefined;

  for(;;) {
    var7 = scripts\cp\utility::get_array_of_valid_players();

    if(!var7.size) {
      wait 1;
      continue;
    }

    var8 = scripts\cp\utility::get_center_point_of_array(var7);

    if(!isDefined(var8)) {
      var8 = self.origin;
    }

    if(isDefined(self.spawn_point)) {
      if(isDefined(self.spawn_point)) {}

      var9 = [self.spawn_point];
    } else {
      var9 = sortbydistance(level.valid_air_vehicle_spawn_points, var8);
    }

    var3 = undefined;
    var10 = 2048;

    for(var11 = 0; var11 < var9.size; var11++) {
      var12 = var9[var11];

      if(isDefined(var12.radius) && var12.radius > var10) {
        var10 = int(var12.radius);
      }

      if(distance2dsquared(var12.origin, var8) <= var10 * var10) {
        var3 = var12;
        break;
      }
    }

    if(isDefined(var3)) {
      var10 = 2048;

      if(isDefined(var3.radius) && var3.radius > var10) {
        var10 = int(var3.radius);
      }

      if(distance2dsquared(var3.origin, self.origin) <= var10 * var10) {
        level.valid_air_vehicle_spawn_points = scripts\engine\utility::array_remove(level.valid_air_vehicle_spawn_points, var3);
        var4 = duplicate_struct(var3);

        if(!isDefined(var3.script_noteworthy)) {
          var4.targetname = "arrived_at_node_" + var2;
        } else {
          var4.targetname = var3.script_noteworthy;
        }

        thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var4);
        self.landing_spot = var4;
        var13 = (150, 150, 150);

        if(var1 == "lbravo_ai_infil") {
          var13 = (90, 90, 90);
        }

        self.nav_obstacle = createnavobstaclebybounds(var4.origin, var13, (0, 0, 0), "axis");
        thread delete_nav_obstacle_on_death();
        break;
      } else {
        var14 = scripts\engine\utility::array_remove_array(level.path_points[var1], level.invalid_path_points);

        if(isDefined(var6)) {
          var14 = scripts\engine\utility::array_remove(level.path_points[var1], var6);
        }

        var15 = get_best_hover_point(var8, var14);

        if(isDefined(var15)) {
          var16 = duplicate_struct(var15);

          if(!isDefined(var15.script_noteworthy)) {
            var16.script_noteworthy = "arrived_at_node_" + var2;
          } else {
            var16.script_noteworthy = var15.script_noteworthy;
          }

          var16.radius = 512;

          if(!isDefined(var6) || var15 != var6) {
            thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var16);
          }

          var6 = var15;
          level.invalid_path_points[level.invalid_path_points.size] = var15;
          var17 = scripts\engine\utility::ref_143b9(2.5, var16.script_noteworthy);

          if(var17 == "timeout") {
            var6 = undefined;
          }

          scripts\engine\utility::deletestruct_ref(var16);
          level.invalid_path_points = scripts\engine\utility::array_remove(level.invalid_path_points, var15);
        } else {
          wait 1;
        }
      }

      continue;
    }

    var14 = scripts\engine\utility::array_remove_array(level.path_points[var1], level.invalid_path_points);

    if(isDefined(var6)) {
      var14 = scripts\engine\utility::array_remove(level.path_points[var1], var6);
    }

    var15 = get_best_hover_point(var8, var14);

    if(isDefined(var15)) {
      var16 = duplicate_struct(var15);

      if(!isDefined(var15.script_noteworthy)) {
        var16.script_noteworthy = "arrived_at_node_" + var2;
      } else {
        var16.script_noteworthy = var15.script_noteworthy;
      }

      var16.radius = 512;

      if(!isDefined(var6) || var15 != var6) {
        thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var16);
      }

      var6 = var15;
      level.invalid_path_points[level.invalid_path_points.size] = var15;
      var17 = scripts\engine\utility::ref_143b9(2.5, var16.script_noteworthy);

      if(var17 == "timeout") {
        var6 = undefined;
      }

      scripts\engine\utility::deletestruct_ref(var16);
      level.invalid_path_points = scripts\engine\utility::array_remove(level.invalid_path_points, var15);
      continue;
    }

    wait 1;
  }

  self waittill("unloaded");

  if(!scripts\engine\utility::array_contains(level.valid_air_vehicle_spawn_points, var3)) {
    level.valid_air_vehicle_spawn_points[level.valid_air_vehicle_spawn_points.size] = var3;
  }

  if(isDefined(var4)) {
    var5 = get_exit_route(var4, var1 + var2 + "_start");
  }

  var18 = scripts\engine\utility::random(scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var1].exit_points, "targetname"));
  var19 = duplicate_struct(var18);

  if(isDefined(var4) && isDefined(var5) && var5 != var4) {
    add_targetname_kvps(var5, var4, var1 + var2 + "_exit_path");
    add_targetname_kvps(var19, var5, var1 + var2 + "_end");
    thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var5);
  } else {
    add_targetname_kvps(var19, var4, var1 + var2 + "_end");
    thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var19);
  }

  delete_nav_obstacle();
}

function create_unique_kvp_string() {
  var0 = get_next_free_num();
  return "unique_KVP_" + var0;
}

function get_next_free_num() {
  var0 = level.next_index;
  level.next_index++;
  return var0;
}

function avoid_other_helicopters(var0) {
  self notify("avoid_other_helicopters");
  self endon("avoid_other_helicopters");

  for(;;) {
    var1 = self.origin + anglesToForward(self.angles) * 256;

    foreach(var3 in scripts\engine\utility::get_array_of_closest(var1, level.all_spawned_vehicles, [self], undefined, 512)) {
      if(var3 == self) {}
    }

    wait 1;
  }
}

function get_best_hover_point(var0, var1) {
  var1 = sortbydistance(var1, var0);
  var2 = -5;
  var3 = undefined;

  foreach(var5 in var1) {
    var6 = scripts\engine\math::get_dot(self.origin, self.angles, var5.origin);

    if(var6 > 0) {
      return var5;
    }
  }

  return var3;
}

function get_exit_route(var0, var1) {
  var2 = var0;

  if(isDefined(var2.script_linkto)) {
    for(var3 = 0; isDefined(var2.script_linkto); var3++) {
      var4 = scripts\engine\utility::random(get_veh_linked_structs(var2));
      var4 = duplicate_struct(var4);
      add_targetname_kvps(var4, var0, var1 + "_exit_route_" + var3);
      var2 = var4;
    }
  }

  return var2;
}

function copy_path_struct_at_new_pos(var0, var1) {
  var2 = spawnStruct();
  var2.origin = var0;
  var2.speed = var1.speed;
  var2.lookahead = var1.lookahead;
  return var2;
}

function add_targetname_kvps(var0, var1, var2) {
  if(isDefined(var0)) {
    var0.targetname = var2;
    scripts\cp\utility::addtostructarray("targetname", var2, var0);

    if(isDefined(self.veh_path)) {
      self.veh_path[self.veh_path.size] = var0;
    }
  }

  if(isDefined(var1)) {
    var1.target = var2;
    scripts\cp\utility::addtostructarray("target", var2, var1);

    if(isDefined(self.veh_path)) {
      self.veh_path[self.veh_path.size] = var1;
      return;
    }

    return;
  }
}

function duplicate_struct(var0) {
  var1 = spawnStruct();
  var1.path_gobbler = 1;
  var1.origin = var0.origin;

  if(isDefined(var0.angles)) {
    var1.angles = var0.angles;
  } else {
    var1.angles = (0, 0, 0);
  }

  if(isDefined(var0.script_unload)) {
    var1.script_unload = var0.script_unload;
  }

  if(isDefined(var0.lookahead)) {
    var1.lookahead = var0.lookahead;
  }

  if(isDefined(var0.speed)) {
    var1.speed = var0.speed;
  } else {
    var1.speed = 2000;
  }

  if(isDefined(var0.start_node)) {
    var1.start_node = var0.start_node;
  }

  if(isDefined(var0.script_noteworthy)) {
    var1.script_noteworthy = var0.script_noteworthy;
  }

  if(isDefined(var0.script_linkname)) {
    var1.script_linkname = var0.script_linkname;
  }

  if(isDefined(var0.script_linkto)) {
    var1.script_linkto = var0.script_linkto;
  }

  if(isDefined(var0.script_brake)) {
    var1.script_brake = var0.script_brake;
  }

  if(isDefined(var0.script_pathtype)) {
    var1.script_pathtype = var0.script_pathtype;
  }

  if(isDefined(var0.script_goalyaw)) {
    var1.script_goalyaw = var0.script_goalyaw;
  }

  if(isDefined(var0.script_anglevehicle)) {
    var1.script_anglevehicle = var0.script_anglevehicle;
  }

  if(isDefined(var0.radius)) {
    var1.radius = var0.radius;
  } else {
    var1.radius = 512;
  }

  return var1;
}

function delete_nav_obstacle() {
  if(isDefined(self.nav_obstacle)) {
    destroynavobstacle(self.nav_obstacle);
  }

  self.spawn_point scripts\cp\cp_modular_spawning::set_default_spawner_values();
}

function attack_player_cooldown(var0, var1, var2, var3) {
  var3.ref_12a87 = undefined;
  var4 = 1;

  if(isDefined(var2)) {
    if(reflectbolt(var2) < 1) {
      var4 = 0;
    }
  }

  if(isDefined(var0)) {
    ref_13bb7(var0, 0);
  }

  if(isDefined(var1)) {
    if(var4) {
      var1 scripts\cp\cp_modular_spawning::mounted();
    } else if(isDefined(var2)) {
      mountstringtodlogenum(var2, var1);
    }
  }

  reset_spawn_point_targetname(var1);

  if(isDefined(var2)) {
    if(isDefined(var2.veh_spawn_point)) {
      var2.veh_spawn_point = undefined;
      return;
    }

    return;
  }
}

function mountstringtodlogenum(var0) {
  self waittill("death");
  var0 scripts\cp\cp_modular_spawning::mounted();
}

function delete_nav_obstacle_on_death() {
  self waittill("death");
  delete_nav_obstacle();
}

function reached_infil_node(var0) {
  iprintlnbold("TEST");
}

function decrement_vehicles_active(var0, var1) {
  self notify("decrement_vehicles_active");
  self endon("decrement_vehicles_active");
  level endon("game_ended");
  var2 = self.veh_spawn_point;
  var3 = self.spawn_point;
  var4 = scripts\engine\utility::ref_143ad("death", "unloaded");
  level scripts\engine\utility::delaythread(5, &attack_player_cooldown, var2, var3, self, var1);
  level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
  level.ai_spawn_vehicle_func[var0].count--;

  if(isDefined(self.veh_spawn_point) && isDefined(self.veh_spawn_point.script_vehiclegroup)) {
    var5 = scripts\engine\utility::getStructArray(self.veh_spawn_point.script_vehiclegroup, "targetname");

    foreach(var7 in var5) {
      var7.disabled = undefined;
    }
  }

  if(isDefined(self.veh_spawn_point)) {
    self.veh_spawn_point.in_use = undefined;
  }

  self.veh_spawn_point = undefined;
}

function reset_spawn_point_targetname(var0) {
  if(!isDefined(var0) && isDefined(self.spawn_point)) {
    var0 = self.spawn_point;
  }

  if(isDefined(var0)) {
    var0.ai_infil_type = undefined;

    if(isDefined(var0.og_script_function)) {
      var0.script_function = var0.og_script_function;
    }

    var0 = undefined;
  }

  if(isDefined(self) && isDefined(self.veh_path)) {
    foreach(var2 in self.veh_path) {
      if(!isDefined(var2)) {
        continue;
      }

      if(isDefined(var2.script_noteworthy)) {
        remove_from_struct_array("script_noteworthy", var2.script_noteworthy, var2);
      }

      if(isDefined(var2.target)) {
        remove_from_struct_array("target", var2.target, var2);
      }

      if(isDefined(var2.targetname)) {
        remove_from_struct_array("targetname", var2.targetname, var2);
      }

      if(isDefined(var2.script_linkname)) {
        remove_from_struct_array("script_linkname", var2.script_linkname, var2);
      }
    }
  }

  if(isDefined(self) && isDefined(self.pathing_array)) {
    foreach(var2 in self.pathing_array) {
      if(!isDefined(var2)) {
        continue;
      }

      if(isDefined(var2.script_noteworthy)) {
        remove_from_struct_array("script_noteworthy", var2.script_noteworthy, var2);
      }

      if(isDefined(var2.target)) {
        remove_from_struct_array("target", var2.target, var2);
      }

      if(isDefined(var2.targetname)) {
        remove_from_struct_array("script_noteworthy", var2.targetname, var2);
        remove_from_struct_array("targetname", var2.targetname, var2);
      }

      if(isDefined(var2.script_linkname)) {
        remove_from_struct_array("script_linkname", var2.script_linkname, var2);
      }
    }

    return;
  }
}

function remove_from_struct_array(var0, var1, var2) {
  if(isDefined(level.struct_class_names[var0]) && isDefined(level.struct_class_names[var0][var1]) && scripts\engine\utility::array_contains(level.struct_class_names[var0][var1], var2)) {
    level.struct_class_names[var0][var1] = scripts\engine\utility::array_remove(level.struct_class_names[var0][var1], var2);
    return;
  }
}

function clear_kill_off_flags(var0) {
  if(istrue(var0.skip_clear_kill_off_flag)) {
    return;
  }

  var0.killofftime = gettime() + 20000;
  var0.dontkilloff = undefined;
  var0.canshootinvehicle = undefined;
  var0.ignoreall = 0;

  if(isDefined(var0.vehicle) && isDefined(var0.vehicle.landing_spot)) {
    var0 scripts\cp\cp_modular_spawning::node_fields_pre_goal(var0.vehicle.landing_spot);
  }

  if(isDefined(var0.demeanoroverride) && var0.demeanoroverride == "casual") {
    var0 scripts\cp\cp_modular_spawning::set_demeanor_from_unittype("patrol");
    var0 scripts\cp\cp_modular_spawning::set_goal_pos(var0.origin);
    var0 thread scripts\cp\cp_modular_spawning::start_patrol();
    return;
  }

  var0 scripts\cp\cp_modular_spawning::set_goal_pos(var0.origin);
  var1 = var0 scripts\cp\utility::get_closest_living_player();

  if(isDefined(var1)) {
    var0 scripts\cp\cp_modular_spawning::set_goal_pos(var1.origin);
  }

  var0 scripts\cp\cp_modular_spawning::enter_combat();
}

function ref_12ae5(var0, var1, var2) {
  if(isDefined(level.ambientgroups[var0])) {
    if(isarray(level.ambientgroups[var0])) {
      for(var3 = 0; var3 < level.ambientgroups[var0].size; var3++) {
        if(!isDefined(level.ambientgroups[var0][var3].ref_141b3)) {
          level.ambientgroups[var0][var3].ref_141b3 = [];
        }

        level.ambientgroups[var0][var3].ref_141b3[var1] = var2;
      }

      return;
    }

    if(!isDefined(level.ambientgroups[var0].ref_141b3)) {
      level.ambientgroups[var0].ref_141b3 = [];
    }

    level.ambientgroups[var0].ref_141b3[var1] = var2;
    return;
  }
}

function puddle_fx(var0, var1) {
  if(isDefined(var0) && isDefined(var1)) {
    if(!isDefined(var0.ref_141b3)) {
      return;
    }

    if(!isDefined(var0.ref_141b3[var1])) {
      return;
    }

    return var0.ref_141b3[var1];
  }

  return undefined;
}

function redlight(var0, var1) {
  if(isDefined(var0) && isDefined(var1)) {
    var2 = puddle_fx(var0, var1);

    if(!isDefined(var2)) {
      var2 = [];
    }

    for(var3 = 0; var3 < self.usedpositions.size; var3++) {
      if(self.usedpositions[var3]) {
        continue;
      }

      var4 = 1;

      for(var5 = 0; var5 < var2.size; var5++) {
        if(var2[var5] == var3) {
          var4 = 0;
          break;
        }
      }

      if(var4) {
        return var3;
      }
    }
  }

  return -1;
}

function ref_1301b(var0) {
  jumpiffalse(isDefined(var0)) LOC_00000009;
  return;
}

function allow_infil_after_full_or_timeout(var0, var1) {
  self notify("allow_infil_after_full_or_timeout");
  self endon("allow_infil_after_full_or_timeout");
  self endon("death");
  self endon("spawning_done");
  level endon("game_ended");
  var2 = puzzle_mark_complete(var0, var1);

  if(isDefined(level.ai_spawn_vehicle_func[var1].max_wait_for_infil)) {
    scripts\engine\utility::ref_143b9(level.ai_spawn_vehicle_func[var1].max_wait_for_infil, "stop_waiting_for_spawns");
  }

  if(isDefined(var2)) {
    if(self.attachedguys.size == var2 || isDefined(self.load_queue) && self.load_queue.size == var2) {
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

function little_bird_mg_takegunnerturret(var0, var1) {}

function register_combined_vehicles(var0, var1, var2, var3, var4, var5, var6) {
  [[var0]](var1, var2, var3);
  thread ref_12ae0(level, var0, var1, var2, var3, var4, var5);
}

function ref_12ae0(var0, var1, var2, var3, var4, var5, var6, var7) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  register_vehicle_build(var6, var1, var2, var3, var6);
  var8 = spawnStruct();
  copy_vehicle_build_to_spawnpoint(var5, var8);

  if(var8 scripts\common\vehicle_code::ishelicopter_internal()) {
    add_ai_air_infil(var5);
    register_vehicle_spawn(var5, 10, 10, undefined, "heli_spawner", "heli_exit", "heli_infil_path", undefined, &veh_heli_spawn, var6);
    register_spawner_script_function(var5, &ai_lbravo_spawn);
  } else {
    add_ai_ground_infil(var5);
    register_vehicle_spawn(var5, 10, 10, undefined, "ai_ground_veh_spawner", "ground_veh_exit", "ground_veh_infil_path", undefined, &veh_ground_veh_spawn, var6);
    register_spawner_script_function(var5, &ai_ground_veh_spawn);
  }

  ref_12b03(var6, var1, var2, var3, var4);
  var9 = level.vehicle.templates.aianims[var3];
  var10 = 0;

  for(var11 = 0; var11 < var9.size; var11++) {
    if(isDefined(var9[var11].idle_anim)) {
      var10++;
    }
  }

  if(var10 > 0) {
    register_vehicle_spawn_drivers(var5, var10, scripts\engine\utility::random(["aq_pilot_fullbody_1", "aq_pilot_fullbody_2"]));
  }

  if(isDefined(var4) && getdvarint("scr_create_mp_vehicles", 0)) {
    init_gas_vents(var4, var3, var6);
  }

  level notify(var5);
}

function init_gas_vents(var0, var1, var2) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(level.vehicle)) {
    return;
  }

  var3 = level.vehicle_builds[var2];
  var3.vehiclename = var2;
  init_pipe_traps(var0, var1, var2);
  init_petrograd_bsp_patch(var0, var1, var2);
  init_patches(var0, var1, var2);
  init_pipe_room_obj(var0, var1, var2);
}

function init_patches(var0, var1, var2) {
  if(!isDefined(level.vehicle.interact)) {
    return;
  }

  if(!isDefined(level.vehicle.interact.vehicledata)) {
    return;
  }

  if(isDefined(level.vehicle.interact.vehicledata[var0]) && !isDefined(level.vehicle.interact.vehicledata[var2])) {
    if(isDefined(level.vehicle.templates.aianims[var1])) {
      var3 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle(var2, 1);

      for(var4 = 0; var4 < level.vehicle.templates.aianims[var1].size; var4++) {
        var5 = level.vehicle.templates.aianims[var1][var4];
        var6 = tolower(var5.sittag);
        var3.seatenterarrays[var6] = [];
        var3.seatenterarrays[var6][var3.seatenterarrays[var6].size] = var6;
        var7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(var2, var6, 1);

        if(var4 == 0) {
          var8 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(var2, 1);
          var8.driverseatid = var6;
        }
      }

      level.vehicle.interact.vehicledata[var2] = var3;
      return;
    }

    return;
  }
}

function init_pipe_traps(var0, var1, var2) {
  if(!isDefined(level.vehicle.vehicledata)) {
    return;
  }

  if(isDefined(level.vehicle.vehicledata[var0]) && !isDefined(level.vehicle.vehicledata[var2])) {
    var3 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle(var2, 1);
    var3.destroycallback = level.vehicle.vehicledata[var0].destroycallback;
    level.vehicle.vehicledata[var2] = var3;
    return;
  }
}

function init_pipe_room_obj(var0, var1, var2) {
  if(!isDefined(level.vehicle.ref_11fd0.vehicledata)) {
    return;
  }

  if(isDefined(level.vehicle.ref_11fd0.vehicledata[var0]) && !isDefined(level.vehicle.ref_11fd0.vehicledata[var2])) {
    var3 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e(var2, 1);
    var4 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e(var0);
    var3.brtruck_initdialog = var4.brtruck_initdialog;
    var3.id = var4.id;
    var3.ref_12da2 = var4.ref_12da2;
    var3.seatids = var4.seatids;
    var3.ref_14422 = var4.ref_14422;
    var3.ref_14423 = var4.ref_14423;
    var3.ref_14424 = var4.ref_14424;
    var3.ref_14426 = var4.ref_14426;
    level.vehicle.ref_11fd0.vehicledata[var2] = var3;
    return;
  }
}

function init_laser_panel_anims(var0, var1) {
  if(!isDefined(level.vehicle.ref_11fd0.vehicledata)) {
    return;
  }

  if(isDefined(level.vehicle.ref_11fd0.vehicledata[var0])) {
    var2 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e(var0, 1);
    var3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(var0);
    var2.seatids = [];
    var4 = getarraykeys(var3.seatdata);

    for(var5 = 0; var5 < var4.size; var5++) {
      var2.seatids[var4[var5]] = var1[var5];
    }

    level.vehicle.ref_11fd0.vehicledata[var0] = var2;
    return;
  }
}

function init_petrograd_bsp_patch(var0, var1, var2) {
  if(!isDefined(level.vehicle.occupancy.vehicledata)) {
    return;
  }

  if(isDefined(level.vehicle.occupancy.vehicledata[var0]) && !isDefined(level.vehicle.occupancy.vehicledata[var2])) {
    var3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(var2, 1);
    var3.camera = level.vehicle.occupancy.vehicledata[var0].camera;
    var3.damagefeedbackgroupheavy = level.vehicle.occupancy.vehicledata[var0].damagefeedbackgroupheavy;
    var3.damagefeedbackgrouplight = level.vehicle.occupancy.vehicledata[var0].damagefeedbackgrouplight;
    var3.damagemodifier = level.vehicle.occupancy.vehicledata[var0].damagemodifier;
    var3.enterendcallback = level.vehicle.occupancy.vehicledata[var0].enterendcallback;
    var3.enterstartcallback = level.vehicle.occupancy.vehicledata[var0].enterstartcallback;
    var3.exitdirections = level.vehicle.occupancy.vehicledata[var0].exitdirections;
    var3.exitendcallback = level.vehicle.occupancy.vehicledata[var0].exitendcallback;
    var3.exitextents = level.vehicle.occupancy.vehicledata[var0].exitextents;
    var3.exitoffsets = level.vehicle.occupancy.vehicledata[var0].exitoffsets;
    var3.exitstartcallback = level.vehicle.occupancy.vehicledata[var0].exitstartcallback;
    var3.restrictions = level.vehicle.occupancy.vehicledata[var0].restrictions;
    var3.threatbiasgroup = level.vehicle.occupancy.vehicledata[var0].threatbiasgroup;
    level.vehicle.occupancy.vehicledata[var2] = var3;
    return;
  }
}

function ref_12af9(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!isDefined(level.vehicle)) {
    return;
  }

  if(!isDefined(level.vehicle.occupancy.vehicledata)) {
    return;
  }

  if(!isDefined(!isDefined(level.vehicle.occupancy.vehicledata[var0]))) {
    return;
  }

  ref_12af8(var0, var1, var2, var3, var4, var5, var6, var7);
}

function ref_12af8(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(var0, 1);
  var9 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(var0, var1, 1);
  var9.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var1, var2);
  var9.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var9.damagemodifier = 0.5;
  var9.animtag = var3;
  var9.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var9.animtag);
  var9.exitids = var4;
  var8.exitoffsets[var1] = var5;
  var8.exitdirections[var1] = var6;
  var9.spawnpriority = 10;
}

function ref_12afd(var0) {
  var1 = ["tag_driver", "tag_passenger", "tag_bed1", "tag_bed2", "tag_bed_center"];
  var2 = ["tag_seat_0", "tag_seat_2", "tag_seat_4", "tag_seat_4", "tag_seat_4", "tag_seat_3", "tag_seat_5"];
  var3 = var1;
  var4 = [];
  var5 = (5, 14, 55);
  var6 = "left";
  var7 = 10;

  if(isDefined(level.vehicle.interact.vehicledata[var0]) && isDefined(isDefined(level.vehicle.interact.vehicledata[var0].seatenterarrays))) {
    var8 = getarraykeys(level.vehicle.interact.vehicledata[var0].seatenterarrays);

    for(var9 = 0; var9 < level.vehicle.interact.vehicledata[var0].seatenterarrays.size; var9++) {
      var10 = var8[var9];
      var4 = scripts\engine\utility::array_add(var3, var10);
      ref_12af9(var0, var10, var1, var2[var9], var4, var5, var6, var7);
    }

    return;
  }
}

function ref_12ae1(var0, var1) {
  if(!isDefined(var0)) {
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

  if(isDefined(level.vehicle.interact.vehicledata[var0])) {
    return;
  }

  if(!isarray(var1)) {
    var1 = [var1];
  }

  if(isDefined(level.vehicle.interact.vehicledata[var0].seatenterarrays)) {
    var2 = level.vehicle.interact.vehicledata[var0].seatenterarrays;

    for(var3 = 0; var3 < var2.size; var3++) {
      for(var4 = 0; var4 < var1.size; var4++) {}
    }

    return;
  }
}

function vehicle_registrations(var0, var1, var2, var3) {
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

function setup_player_vehicles(var0, var1, var2) {
  var3 = "-";
  var4 = "&";
  var5 = "_";
  var6 = "devgui_cmd \"CP Players:2 / " + var1 + " / Spawn Vehicle / Little Bird\" \"set scr_vehicle_debug Spawn" + var5 + var3 + var2 + var3 + var4 + "little_bird\" \n";
  scripts\cp\utility::addentrytodevgui(var6);
  var6 = "devgui_cmd \"CP Players:2 / " + var1 + " / Spawn Vehicle / Light Tank\" \"set scr_vehicle_debug Spawn" + var5 + var3 + var2 + var3 + var4 + "light_tank\" \n";
  scripts\cp\utility::addentrytodevgui(var6);
  var6 = "devgui_cmd \"CP Players:2 / " + var1 + " / Spawn Vehicle / Technical\" \"set scr_vehicle_debug Spawn" + var5 + var3 + var2 + var3 + var4 + "technical\" \n";
  scripts\cp\utility::addentrytodevgui(var6);
  var6 = "devgui_cmd \"CP Players:2 / " + var1 + " / Spawn Vehicle / Tac Rover\" \"set scr_vehicle_debug Spawn" + var5 + var3 + var2 + var3 + var4 + "tac_rover\" \n";
  scripts\cp\utility::addentrytodevgui(var6);
  var6 = "devgui_cmd \"CP Players:2 / " + var1 + " / Spawn Vehicle / Hoopty\" \"set scr_vehicle_debug Spawn" + var5 + var3 + var2 + var3 + var4 + "hoopty\" \n";
  scripts\cp\utility::addentrytodevgui(var6);
  var6 = "devgui_cmd \"CP Players:2 / " + var1 + " / Spawn Vehicle / APC\" \"set scr_vehicle_debug Spawn" + var5 + var3 + var2 + var3 + var4 + "apc\" \n";
  scripts\cp\utility::addentrytodevgui(var6);
  var6 = "devgui_cmd \"CP Players:2 / " + var1 + " / Spawn Vehicle / APC RUS\" \"set scr_vehicle_debug Spawn" + var5 + var3 + var2 + var3 + var4 + "apc_russian\" \n";
  scripts\cp\utility::addentrytodevgui(var6);
  var6 = "devgui_cmd \"CP Players:2 / " + var1 + " / Spawn Vehicle / ATV\" \"set scr_vehicle_debug Spawn" + var5 + var3 + var2 + var3 + var4 + "atv\" \n";
  scripts\cp\utility::addentrytodevgui(var6);
  var6 = "devgui_cmd \"CP Players:2 / " + var1 + " / Spawn Vehicle / Cargo Truck\" \"set scr_vehicle_debug Spawn" + var5 + var3 + var2 + var3 + var4 + "cargo_truck\" \n";
  scripts\cp\utility::addentrytodevgui(var6);
  var6 = "devgui_cmd \"CP Players:2 / " + var1 + " / Spawn Vehicle / Cop Car\" \"set scr_vehicle_debug Spawn" + var5 + var3 + var2 + var3 + var4 + "cop_car\" \n";
  scripts\cp\utility::addentrytodevgui(var6);
  var6 = "devgui_cmd \"CP Players:2 / " + var1 + " / Spawn Vehicle / Hoopty Truck\" \"set scr_vehicle_debug Spawn" + var5 + var3 + var2 + var3 + var4 + "hoopty_truck\" \n";
  scripts\cp\utility::addentrytodevgui(var6);
  var6 = "devgui_cmd \"CP Players:2 / " + var1 + " / Spawn Vehicle / Jeep\" \"set scr_vehicle_debug Spawn" + var5 + var3 + var2 + var3 + var4 + "jeep\" \n";
  scripts\cp\utility::addentrytodevgui(var6);
  var6 = "devgui_cmd \"CP Players:2 / " + var1 + " / Spawn Vehicle / Large Transport\" \"set scr_vehicle_debug Spawn" + var5 + var3 + var2 + var3 + var4 + "large_transport\" \n";
  scripts\cp\utility::addentrytodevgui(var6);
  var6 = "devgui_cmd \"CP Players:2 / " + var1 + " / Spawn Vehicle / Med Transport\" \"set scr_vehicle_debug Spawn" + var5 + var3 + var2 + var3 + var4 + "med_transport\" \n";
  scripts\cp\utility::addentrytodevgui(var6);
  var6 = "devgui_cmd \"CP Players:2 / " + var1 + " / Spawn Vehicle / Pickup Truck\" \"set scr_vehicle_debug Spawn" + var5 + var3 + var2 + var3 + var4 + "pickup_truck\" \n";
  scripts\cp\utility::addentrytodevgui(var6);
  var6 = "devgui_cmd \"CP Players:2 / " + var1 + " / Spawn Vehicle / Van\" \"set scr_vehicle_debug Spawn" + var5 + var3 + var2 + var3 + var4 + "van\" \n";
  scripts\cp\utility::addentrytodevgui(var6);
}

function cp_vehicle_debug(var0) {
  var1 = strtok(var0, "_");
  var2 = strtok(var0, "-");
  var3 = strtok(var0, "&");
  var4 = undefined;

  if(var2.size > 0) {
    var5 = int(var2[0]);
    var4 = level.players[var5];
  }

  switch (var1[0]) {
    case "Spawn":
    case "spawn":
      if(isDefined(var3) && var3.size > 1) {
        scripts\engine\utility::script_func(var3[1], var4);
      }

      break;
    default:
      break;
  }
}

function spawn_enemy_chopper(var0, var1, var2) {
  var3 = level.ai_spawn_vehicle_func[var2];
  var4 = get_vehicle_spawn_points(var3, var1);

  if(isDefined(level.cashtypes)) {
    return false;
  }

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    if(isDefined(var0.valid_vehicles)) {
      if(isDefined(var0.valid_vehicles["attack_heli"])) {
        if(var0.valid_vehicles["attack_heli"] == 0) {
          return false;
        }
      }
    }

    if(getdvarint("scr_survival_disable_bossheli", 0) > 0) {
      return false;
    }
  }

  if(var4.size > 0) {
    foreach(var6 in var4) {
      if(istrue(var6.in_use)) {
        continue;
      }

      copy_vehicle_build_to_spawnpoint(var2, var6);
      var7 = vectortoangles(var1.origin - var6.origin);
      var6.angles = (0, var7[1], 0);
      var8 = scripts\common\vehicle::vehicle_spawn(var6);

      if(isDefined(var8)) {
        var6.in_use = 1;
        var8.veh_spawn_point = var6;
        level.cashtypes = var8;
        stringtovec3(var8, var1, var0, var6, var2);
        var0.vehicle = undefined;
        var1.vehicle = undefined;
        var1.veh_spawn_point = undefined;
        var0.ref_12a87 = undefined;
        init_helicopter(var8, var0, var2);
        var8.vehicle_forcerocketdeath = undefined;
        var8.death_fx_on_self = 1;
        var8.circle_radius = 2500;
        var8 scripts\cp\helicopter\cp_helicopter::heli_mg_create("veh8_mil_air_ahotel64_turret_wm", "apache_turret_cp", "tag_turret");
        var8 thread scripts\cp\helicopter\cp_helicopter::setup_pilot(1, undefined, undefined, undefined);
        var8 setmaxpitchroll(15, 15);
        var8.health_remaining = 2250;
        level thread scripts\cp\helicopter\cp_helicopter::heli_think_default(var8);
        var8 sethoverparams(25, 15, 10);
        var8.vehicletype = "apache";
        var8.headicon = deleteheadicon(var8);
        setheadiconfriendlyimage(var8.headicon, "hud_icon_head_equipment_enemy");
        setheadiconsnaptoedges(var8.headicon, 12000);
        setheadiconmaxdistance(var8.headicon, 1500);
        addclienttoheadiconmask(var8.headicon, 10);
        setheadicondrawthroughgeo(var8.headicon, 1);
        var8.bullets_can_damage = 1;
        var8.needs_to_evade = 0;
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
  var0 = ["dx_cps_kama_callout_helicopter_attacking_10", "dx_cps_kama_callout_helicopter_attacking_20", "dx_cps_lass_callout_helicopter_attacking_10", "dx_cps_lass_callout_helicopter_attacking_20"];
  level scripts\cp\cp_vo::try_to_play_vo_on_team(scripts\engine\utility::random(var0), "allies");
}

function ref_13079(var0) {
  if(isDefined(self.healthbuffer)) {
    self.health = self.healthbuffer + var0;
    self.maxhealth = self.health;
    return;
  }

  self.health = var0;
  self.maxhealth = self.health;
}

function init_helicopter(var0, var1) {
  self.isheli = 1;
  self.currentdestindex = gettime();

  switch (var1) {
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

  if(isDefined(var1) && var1 == "lbravo_carrier") {
    thread waiting_for_disable();
  }

  if(self.team == "axis") {
    level thread scripts\cp\cp_weapon::add_to_special_lockon_target_list(self);
    thread smoke_wheelson_chosen_spawn();
  }

  self.dontdisconnectpaths = 1;
  self.vehicle_forcerocketdeath = 1;
  self.death_fx_on_self = 1;

  if(isDefined(var1)) {
    level.ai_spawn_vehicle_func[var1].count++;

    if(isDefined(var0)) {
      scripts\cp\cp_modular_spawning::add_to_module_vehicles_list(var0, var1);
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
    var0 = scripts\common\utility::playersnear(self.origin, 256);

    for(var1 = 0; var1 < var0.size; var1++) {
      if(var0[var1].origin[2] > self.origin[2]) {
        if(var0[var1].origin[2] - self.origin[2] <= 32 && var0[var1] isonground()) {
          var0[var1] dodamage(var0[var1].health + 1000, self.origin, self, self, "MOD_CRUSH");
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
  var0 = 256;
  var1 = 80;
  var2 = 36;

  while(isDefined(self)) {
    if(isDefined(self.currentdestindex) && gettime() - self.currentdestindex < 5000) {
      wait 0.05;
      continue;
    }

    var3 = self.origin + (0, 0, -140) + anglesToForward(self.angles) * 24;

    if(self.team == "axis") {
      foreach(var5 in level.players) {
        if(isDefined(var5) && isalive(var5) && truckwarspawnlocations(var5.origin, var3, var1, var2)) {
          var5 dodamage(var5.health + 1000, self.origin, self, self, "MOD_CRUSH");
        }
      }
    }

    var7 = tablesort(var3 - (0, 0, 200), 400, 400);

    if(!isDefined(var7) || var7.size == 0) {
      wait 0.25;
      continue;
    }

    var7 = sortbydistance(var7, self.origin);
    var8 = undefined;

    for(var9 = 0; var9 < var7.size; var9++) {
      var10 = var7[var9];

      if(!isDefined(var10) || var10 == self) {
        continue;
      }

      if(var10 vehicle_getspeed() > 1) {
        continue;
      }

      if(isent(var10) && truckwarspawnlocations(var10.origin, var3, var0 * 1.5, var2)) {
        var8 = var10;
        break;
      }
    }

    if(!isDefined(var8)) {
      wait 0.05;
      continue;
    }

    var11 = var8;
    var12 = 0;

    if(isDefined(var11.vehiclename) && var11.vehiclename == "little_bird") {
      var12 = 1;
    }

    if(isDefined(var11.vehiclename) && var11.vehiclename == "little_bird_mg") {
      var12 = 1;
    }

    if(isDefined(var11.stop_all_ascend_anims) && var11.stop_all_ascend_anims == "lbravo_carrier") {
      var12 = 1;
    }

    if(isDefined(self.owner) && isPlayer(self.owner) && isDefined(var11.owner) && isPlayer(var11.owner)) {
      var12 = 0;
    }

    if(triggerexitfunc() && triggerexitfunc(var11)) {
      var12 = 0;
    }

    if(var12) {
      var13 = var11.health + 1000;
      var11 notify("landing_collision_damage", var13, self);
      var11.load_sequence_4_vfx = 1;
      var11 dodamage(var13, self.origin, undefined, undefined, "MOD_CRUSH");
    }

    wait 0.05;
  }
}

function truckwarspawnlocations(var0, var1, var2, var3) {
  if(scripts\engine\utility::distance_2d_squared(var0, var1) > squared(var2)) {
    return false;
  }

  if(var0[2] < var1[2]) {
    return false;
  }

  if(var0[2] > var1[2] + var3) {
    return false;
  }

  return true;
}

function triggerexitfunc() {
  if(isDefined(self.owner) && isPlayer(self.owner)) {
    return true;
  }

  if(isDefined(self.occupants)) {
    foreach(var1 in self.occupants) {
      if(isDefined(var1) && isPlayer(var1) && isalive(var1)) {
        return true;
      }
    }
  }

  return false;
}

function laser_trap_triggers(var0) {
  self endon("death");
  self waittill("unloaded");

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function super_onspawned(var0, var1) {
  self.custom_death_script = &internal_isplayerindanger_think;

  switch (var1) {
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

  if(isDefined(var1)) {
    level.ai_spawn_vehicle_func[var1].count++;

    if(isDefined(var0)) {
      scripts\cp\cp_modular_spawning::add_to_module_vehicles_list(var0, var1);
    }
  }

  thread watch_for_vehicle_stuck();
  level.all_spawned_vehicles[level.all_spawned_vehicles.size] = self;
}

function internal_isplayerindanger_think() {
  self vehicle_setspeedimmediate(0, 1, 1);

  if(isDefined(self.riders) && self.riders.size > 0) {
    foreach(var1 in self.riders) {
      if(!isDefined(var1) || !isalive(var1)) {
        continue;
      }

      if(isDefined(var1._blackboard) && isDefined(var1._blackboard.chosenvehicleanimpos)) {
        if(istrue(var1._blackboard.chosenvehicleanimpos.isincircle)) {
          var1._blackboard.chosenvehicleanimpos.vehicle_death_ragdoll = 1;
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

function heli_damagemonitor(var0, var1) {
  self endon("death");
  var2 = 0;
  self.health = 1000000;
  jumpiftrue(isDefined(var1)) LOC_00000022;
  var1 = 2500;

  for(;;) {
    self waittill("damage", var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14, var15, var16);
    self.health = 1000000;

    if(isDefined(var4) && var4 == self) {
      continue;
    }

    if(isDefined(var16) && isDefined(var16.owner) && var16.owner == self) {
      continue;
    }

    if(isDefined(var4) && isDefined(self.minigun) && var4 == self.minigun) {
      continue;
    }

    if(scripts\cp\helicopter\cp_helicopter::is_snipe_kill(var4, var6, var12)) {
      var2++;

      if(var2 == 1) {
        if(isDefined(self.headicon)) {
          setheadiconimage(self.headicon);
        }

        self.headicon = undefined;
        var4 scripts\cp\cp_achievement::scriptable_enginedamaged();
        var4 thread scripts\cp_mp\xmike109::givemidmatchaward("kill_ss_chopper_support");
        var4 scripts\cp\cp_persistence::give_player_currency(500, "large");
        playFX(level._effect["vfx_blima_explosion"], self.origin);
        var4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical", 1);
        level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
        self.minigun delete();

        if(isDefined(self.pilot)) {
          self.pilot delete();
        }

        self notify("deleting_vehicle");
        self delete();
        return;
      }

      var4.lasthitmarkertime = undefined;
      var4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical", 1);
      self.needs_to_evade = 1;
      self vehicle_setspeed(100, 100, 100);
      self setvehgoalpos(self.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0), 0);
      self notify("needs_to_evade");
      continue;
    }

    if(!isexplosivedamagemod(var7)) {
      var4.lasthitmarkertime = undefined;
      var4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitarmorheavy");
    } else {
      var4.lasthitmarkertime = undefined;
      var4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical");

      if(isDefined(var12) && isDefined(var12.basename)) {
        switch (var12.basename) {
          case "iw8_thermite_mp":
            break;
          case "emp_drone_player_mp":
            var3 = 1400;
            break;
          default:
            break;
        }
      } else if(var3 < 700) {
        var3 = 700;
      }

      if(isDefined(var0) && scripts\engine\utility::flag_exist(var0) && !scripts\engine\utility::flag(var0)) {
        scripts\engine\utility::flag_set(var0);
      } else {
        if(!istrue(self.needs_to_evade)) {
          self.needs_to_evade = 1;
        }

        self notify("needs_to_evade");
        self vehicle_setspeed(100, 100, 100);
        self setvehgoalpos(self.origin + (randomintrange(-850, 850), randomintrange(-850, 850), 0), 0);
      }
    }

    self.health_remaining -= var3;

    if(self.health_remaining <= var1 * 0.25 && !isDefined(self.deathfx)) {
      playFX(level._effect["aerial_explosion"], self.origin);
      self setscriptablepartstate("body_damage_heavy", "on");
      self.deathfx = 1;
    } else if(self.health_remaining <= var1 * 0.5 && !isDefined(self.deathfx1)) {
      self setscriptablepartstate("body_damage_medium", "on");
      playFX(level._effect["aerial_explosion"], self.origin);
      self.deathfx1 = 1;
    } else if(self.health_remaining <= var1 * 0.75 && !isDefined(self.deathfx2)) {
      self setscriptablepartstate("body_damage_light", "on");
      self.deathfx2 = 1;
    }

    if(self.health_remaining <= 0) {
      if(isDefined(self.headicon)) {
        setheadiconimage(self.headicon);
      }

      self.headicon = undefined;

      if(isDefined(var12) && issubstr(var12.basename, "molotov")) {
        if(isDefined(var4) && isPlayer(var4)) {
          var4 thread scripts\cp\cp_achievement::scriptable_setups();
        }
      }

      if(isDefined(var4) && isPlayer(var4)) {
        var4 thread scripts\cp_mp\xmike109::givemidmatchaward("kill_ss_chopper_support");
        var4 scripts\cp\cp_persistence::give_player_currency(500, "large");
      }

      playFX(level._effect["vfx_blima_explosion"], self.origin);
      var4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical", 1);
      level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
      self.minigun delete();

      if(isDefined(self.pilot)) {
        self.pilot delete();
      }

      self notify("deleting_vehicle");
      self delete();
      continue;
    }

    if(isDefined(var4) && isPlayer(var4)) {
      var4 scripts\cp\cp_persistence::give_player_currency(10, "large");
    }
  }
}

function init_jugg_maze(var0) {
  level.vtclassname = var0;
  scripts\common\vehicle_build::build_rocket_deathfx("vfx/core/expl/aerial_explosion_heli_large.vfx", "tag_origin", undefined, undefined, undefined, 0, 0, 0);
}

function crash_deathfx() {
  self waittill("vehicle_deathComplete", var0);
  playFX(level._effect["vfx_blima_explosion"], var0 + (0, 0, -100));
  playsoundatpos(var0, "cp_br_syrk_chopper_crash");
}

function get_helicopter_path_positions(var0) {
  self.path_positions = [];
  var1 = 12;
  var2 = 2048;
  var3 = 360 / var1;
  var4 = self.origin;
  self.flight_pos = undefined;
  self.flight_pos_dot = undefined;

  if(isDefined(var0)) {
    if(isvector(var0)) {
      var5 = var0;
    } else {
      var5 = var1.origin;
    }
  } else {
    var5 = scripts\cp\utility::get_center_point_of_array(level.players);
  }

  for(var6 = 0; var6 < var3; var6++) {
    var7 = var5 * var6;
    var8 = cos(var7) * var4;
    var9 = sin(var7) * var4;
    var10 = var5[0] + var8;
    var11 = var5[1] + var9;
    var12 = var5[2];

    if(validate_pos((var10, var11, var12), var5)) {
      self.path_positions[self.path_positions.size] = (var10, var11, var12);
    }
  }
}

function draw_capsule_until_notifies(var0, var1) {
  self endon("death");
  self endon("near_goal");

  for(;;) {
    thread scripts\engine\utility::draw_capsule(var0, 32, 32, (0, 0, 0), var1, 0, 1);
    waitframe();
  }
}

function validate_pos(var0, var1) {
  if(isDefined(var1)) {
    var0 = (var0[0], var0[1], var1[2] + 1500);
  }

  if(isDefined(level.heli_triggers) && level.heli_triggers.size > 0) {
    var2 = level.heli_triggers;

    for(var3 = 0; var3 < var2.size; var3++) {
      if(!isDefined(var2[var3])) {
        level.heli_triggers = scripts\engine\utility::array_remove(level.heli_triggers, var2[var3]);
        continue;
      }

      if(isDefined(self.move_trigger) && self.move_trigger == var2[var3]) {
        continue;
      }

      if(ispointinvolume(var0, var2[var3])) {
        return 0;
      }
    }
  }

  if(scripts\engine\trace::capsule_trace_passed(self.origin, var0, 256, 512, self.angles, self)) {
    if(isDefined(var1)) {
      var4 = var0 - self.origin;

      if(isvector(var1)) {
        var5 = vectortoangles(var1 - self.origin);
      } else if(isDefined(var4.velo_forward)) {
        var5 = vectortoangles(var4.velo_forward - self.origin);
      } else {
        var5 = vectortoangles(var5.origin - self.origin);
      }

      var6 = anglesToForward(var5);
      var7 = vectordot(var5, var6);

      if(isDefined(self.flight_pos)) {
        if(var7 > self.flight_pos_dot) {
          self.flight_pos_dot = var7;
          self.flight_pos = var4;
        }
      } else {
        self.flight_pos_dot = var7;
        self.flight_pos = var4;
      }

      if(var7 > 0.3) {
        return 1;
      }

      return 0;
    }

    if(scripts\engine\math::is_point_in_front(var4)) {
      return 1;
    }

    return 0;
  }

  return 0;
}

function point_is_towards_target(var0, var1) {
  var2 = var0 - self.origin;
  var3 = vectortoangles(var1.origin - self.origin);
  var4 = anglesToForward(var3);
  var5 = vectordot(var2, var4);
  return var5 > 0.3;
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
  var0 = self.origin[2];
  self.chopper_height = var0;
  var1 = 0;
  var2 = 5;
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

function should_move_to_target(var0, var1) {
  var2 = 6250000;

  if(isDefined(self.should_move_to_target_dist)) {
    var2 = self.should_move_to_target_dist * self.should_move_to_target_dist;
  }

  if(istrue(self.landed)) {
    self.landed = undefined;
    return true;
  }

  if(distance2dsquared(var0.origin, var1.origin) > var2 || isDefined(self.gotopos) && distance2dsquared(var0.origin, self.gotopos) > var2) {
    return true;
  }

  return false;
}

function heli_move_to_target(var0) {
  self endon("death");
  self cleartargetyaw();
  self cleargoalyaw();
  self setlookatent(var0);

  if(isDefined(self.best_target)) {
    get_helicopter_path_positions(self.best_target);
  } else {
    get_helicopter_path_positions();
  }

  var1 = undefined;

  if(isDefined(self.flight_pos)) {
    var1 = self.flight_pos;
  } else if(isDefined(self.path_positions) && self.path_positions.size > 0) {
    var1 = scripts\engine\utility::random(self.path_positions);
  }

  if(isDefined(var1)) {
    self setneargoalnotifydist(750);

    if(distance2dsquared(self.origin, var1) > 1440000) {
      self vehicle_setspeed(50, 30, 30);
      self setvehgoalpos(var1, 1);
    } else {
      self vehicle_setspeed(15, 12, 12);
      self setvehgoalpos(var1, 0);
    }

    scripts\engine\utility::ref_143b9(15, "near_goal");
  }

  wait 5;
}

function heli_evade(var0) {
  self notify("taking_evasive_actions");
  self endon("taking_evasive_actions");
  self endon("death");
  var1 = 5000;
  get_helicopter_path_positions();
  var2 = self.path_positions;

  if(isDefined(var2) && var2.size > 0) {
    var3 = 0;
    var4 = var2[0];
    self cleargoalyaw();
    self cleartargetyaw();
    self clearlookatent();

    foreach(var8, var6 in var2) {
      if(isvector(var6)) {
        var7 = var6;
      } else {
        var7 = var6.origin;
      }

      if(scripts\engine\utility::within_fov(self.origin, self.angles, var7, cos(25))) {
        var4 = var6;
        var3 = var8;
        break;
      }
    }

    if(isvector(var2[var3])) {
      self setvehgoalpos(var2[var3], 0);
    } else {
      self setvehgoalpos(var2[var3].origin, 0);
    }

    var9 = 1500;
    var9 *= var1 / 5000;
    var10 = 100;
    var10 *= var1 / 5000;
    self setneargoalnotifydist(1500);
    self vehicle_setspeed(100, 50, 50);
    var11 = 0;
    var8 = var3 + 1;
    var12 = randomint(4);

    while(var11 < var2.size - 1) {
      if(var8 >= var2.size) {
        var8 = 0;
      }

      if(isvector(var2[var8])) {
        self setvehgoalpos(var2[var8], 0);
      } else {
        self setvehgoalpos(var2[var8].origin, 0);
      }

      self waittill("near_goal");
      var11++;
      var8++;

      if(var11 == var12) {
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
  var0 = 5;
  var1 = 0;

  for(;;) {
    var2 = heli_get_target();

    if(isDefined(var2)) {
      var1 = 0;
      self notify("target_found");
      self.best_target = var2;
    } else {
      self notify("target_lost");
      var1 += 0.25;

      if(var1 >= var0) {
        var1 = 0;
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
        var0 = scripts\engine\utility::waittill_any_ents_or_timeout_return(3, self.minigun, "turret_on_target");
        scripts\cp\helicopter\cp_helicopter::shoot_at_target();
      }

      self notify("target_engaged");
      self sethoverparams(0, 0, 0);
    }

    wait 1;
  }
}

function heli_get_target() {
  var0 = self.origin;
  var1 = undefined;
  var2 = scripts\engine\utility::get_array_of_closest(var0, level.players);

  for(var3 = 0; var3 < var2.size; var3++) {
    var4 = var2[var3];

    if(!var4 scripts\cp\utility::is_valid_player(undefined, 0) || istrue(var4 isinfreefall()) || istrue(var4 isskydiving()) || istrue(var4 isparachuting())) {
      continue;
    }

    var0 = (var4.origin[0], var4.origin[1], self.chopper_height);

    if(!istrue(self.has_rockets)) {
      if(scripts\engine\trace::ray_trace_passed(var0, var4.origin + (0, 0, 10), [self, var4])) {
        var1 = var4;
        self.gotopos = var0;
      }
    }

    if(!isDefined(var1)) {
      var5 = anglestoright(var4.angles);
      var6 = anglestoleft(var4.angles);
      var7 = anglesToForward(var4.angles);
      var8 = var7 * -1;
      var9 = [var5, var6, var7, var8];

      foreach(var11 in var9) {
        if(isDefined(var4.vehicle)) {
          var12 = [self, var4, var4.vehicle];
        } else {
          var12 = [self, var4];
        }

        var0 = (var4.origin[0], var4.origin[1], 0) + (var11[0], var11[1], 0) * 1800 + (0, 0, self.chopper_height);

        if(scripts\engine\trace::ray_trace_passed(var0, var4.origin + (0, 0, 10), var12)) {
          var1 = var4;
          self.gotopos = var0;
          self.nocircle = 1;
          return var1;
        }
      }
    }

    if(isDefined(var1)) {
      break;
    }
  }

  return var1;
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
      var0 = self.flight_pos;
      self setvehgoalpos(var0, 0);
    } else if(isDefined(self.path_positions) && self.path_positions.size > 0) {
      var0 = scripts\engine\utility::random(self.path_positions);
      self setvehgoalpos(var0, 0);
    }

    self waittill("near_goal");
  }
}

function is_vehicle_spawnpoint() {
  return scripts\cp\cp_spawner_scoring::get_spawn_scoring_type() == "vehicle_spawner";
}