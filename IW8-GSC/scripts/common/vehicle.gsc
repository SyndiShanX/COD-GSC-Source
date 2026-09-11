/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\vehicle.gsc
***********************************************/

function init_vehicles() {
  if(isDefined(level.disablevehiclescripts) && level.disablevehiclescripts) {
    return;
  }

  if(!scripts\engine\utility::add_init_script("vehicles", &init_vehicles)) {
    return;
  }

  thread init_vehicles_thread();
  cleanup_vt();
}

function cleanup_vt() {
  level.vtclassname = undefined;
  level.vtmodel = undefined;
  level.vttype = undefined;
}

function init_vehicles_thread() {
  scripts\engine\utility::create_lock("aircraft_wash_math");
  scripts\common\vehicle_code::vehicle_setuplevelvariables();
  level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_combine(level.vehicle.helicopter_crash_locations, scripts\engine\utility::getstructarray_delete("helicopter_crash_location", "targetname"));
  scripts\common\vehicle_code::vehicle_setupspawners();
  var_0 = scripts\common\vehicle_code::vehicle_precachescripts();
  scripts\common\vehicle_code::setup_vehicles(var_0);
  level.vehicle.has_vehicles = getEntArray("script_vehicle", "code_classname").size > 0;
  scripts\engine\utility::script_func("add_hint_string", "invulerable_frags", &"SCRIPT/INVULERABLE_FRAGS");
  scripts\engine\utility::script_func("add_hint_string", "invulerable_bullets", &"SCRIPT/INVULERABLE_BULLETS");
}

function vehicle_paths(var_0, var_1, var_2) {
  return scripts\common\vehicle_paths::_vehicle_paths(var_0, var_1, var_2);
}

function vehicle_spawn(var_0) {
  return scripts\common\vehicle_code::vehicle_spawn_internal(var_0);
}

function godon() {
  self.godmode = 1;
}

function godoff() {
  self.godmode = 0;
}

function mainturretoff() {
  return scripts\common\vehicle_code::_mainturretoff();
}

function mainturreton() {
  return scripts\common\vehicle_code::_mainturreton();
}

function mgoff() {
  return scripts\common\vehicle_code::_mgoff();
}

function mgon() {
  return scripts\common\vehicle_code::_mgon();
}

function isvehicle() {
  return isDefined(self.vehicletype);
}

function vehicle_is_crashing() {
  return scripts\common\vehicle_code::vehicle_iscrashing();
}

function is_godmode() {
  return scripts\common\vehicle_code::_is_godmode();
}

function vehicle_kill_rumble_forever() {
  self notify("kill_rumble_forever");
}

function spawn_vehicles_from_targetname(var_0) {
  var_1 = [];
  var_2 = getEntArray(var_0, "targetname");

  foreach(var_4 in var_2) {
    if(!isDefined(var_4.code_classname) || var_4.code_classname != "script_vehicle") {
      continue;
    }

    if(isspawner(var_4)) {
      var_5 = scripts\common\vehicle_code::vehicle_spawn_internal(var_4);
      var_1 = scripts\engine\utility::array_add(var_1, var_5);
    }
  }

  return var_1;
}

function spawn_vehicle_from_targetname(var_0) {
  var_1 = spawn_vehicles_from_targetname(var_0);
  return var_1[0];
}

function spawn_vehicle_from_targetname_and_drive(var_0) {
  var_1 = spawn_vehicles_from_targetname(var_0);
  thread scripts\common\vehicle_paths::gopath(var_1[0]);
  return var_1[0];
}

function spawn_vehicles_from_targetname_and_drive(var_0) {
  var_1 = spawn_vehicles_from_targetname(var_0);

  foreach(var_3 in var_1) {
    thread scripts\common\vehicle_paths::gopath(var_3);
  }

  return var_1;
}

function aircraft_wash(var_0) {
  thread scripts\common\vehicle_code::aircraft_wash_thread(var_0);
}

function vehicle_wheels_forward() {
  scripts\common\vehicle_code::vehicle_setwheeldirection(1);
}

function vehicle_wheels_backward() {
  scripts\common\vehicle_code::vehicle_setwheeldirection(0);
}

function vehicle_load_ai(var_0, var_1, var_2) {
  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  scripts\common\vehicle_aianim::load_ai(var_0, var_1, var_2);

  if(getdvarint("enable_vehicle_ai_using_BT")) {
    if(!self.usedpositions[0]) {
      var_3 = self.riders;
      vehicle_unload();
      scripts\engine\utility::ent_flag_wait("unloaded");
      var_3 = scripts\engine\utility::array_removedead(var_3);
      var_3 = scripts\engine\utility::array_remove_array(var_3, self.riders);

      if(var_3.size > 0) {
        vehicle_load_ai(var_3);
        return;
      }

      return;
    }

    var_4 = level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()];

    if(isDefined(var_4[0].death)) {
      foreach(var_6 in self.riders) {
        if(istrue(var_6.drivingvehicle)) {
          thread scripts\common\vehicle_aianim::driverdead(var_6);
        }
      }

      return;
    }

    return;
  }
}

function spawn_vehicle_and_gopath() {
  var_0 = scripts\common\utility::spawn_vehicle();

  if(isDefined(self.script_speed)) {
    if(!ishelicopter()) {
      var_0 vehicle_setspeed(self.script_speed);
    }
  }

  thread scripts\common\vehicle_paths::gopath(var_0);
  return var_0;
}

function attach_vehicle(var_0) {
  self vehicle_teleport(var_0.origin, var_0.angles);

  if(!ishelicopter()) {
    waitframe();
    self attachpath(var_0);
  }

  thread vehicle_paths(var_0, 1);
}

function attach_vehicle_and_gopath(var_0) {
  self vehicle_teleport(var_0.origin, var_0.angles);
  waitframe();

  if(!ishelicopter()) {
    self attachpath(var_0);
  }

  thread vehicle_paths(var_0);
  scripts\common\vehicle_paths::gopath(self);
}

function vehicle_get_riders_by_group(var_0) {
  var_1 = [];
  var_2 = scripts\common\vehicle_code::get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.unloadgroups[var_2])) {
    return var_1;
  }

  var_3 = level.vehicle.templates.unloadgroups[var_2];

  if(!isDefined(var_0)) {
    return var_1;
  }

  foreach(var_5 in self.riders) {
    foreach(var_7 in var_3[var_0]) {
      if(var_5.vehicle_position == var_7) {
        var_1 = var_5;
      }
    }
  }

  return var_1;
}

function vehicle_unload(var_0) {
  return scripts\common\vehicle_code::_vehicle_unload(var_0);
}

function vehicle_turret_scan_off() {
  self notify("stop_scanning_turret");
}

function vehicle_get_path_array() {
  self endon("death");
  var_0 = [];
  var_1 = self.attachedpath;

  if(!isDefined(self.attachedpath)) {
    return var_0;
  }

  var_2 = var_1;
  var_2.counted = 0;

  while(isDefined(var_2)) {
    if(isDefined(var_2.counted) && var_2.counted == 1) {
      break;
    }

    var_0 = scripts\engine\utility::array_add(var_0, var_2);
    var_2.counted = 1;

    if(!isDefined(var_2.target)) {
      break;
    }

    if(!ishelicopter()) {
      var_2 = getvehiclenode(var_2.target, "targetname");
      continue;
    }

    var_2 = scripts\engine\utility::getent_or_struct(var_2.target, "targetname");
  }

  return var_0;
}

function vehicle_lights_on(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  scripts\common\vehicle_lights::lights_on(var_0, var_1);
}

function vehicle_lights_off(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  scripts\common\vehicle_lights::lights_off(var_0, var_1);
}

function vehicle_switch_paths(var_0, var_1) {
  self setswitchnode(var_0, var_1);
  self.attachedpath = var_1;
  thread vehicle_paths();
}

function vehicle_stop_named(var_0, var_1, var_2) {
  return scripts\common\vehicle_paths::_vehicle_stop_named(var_0, var_1, var_2);
}

function vehicle_resume_named(var_0) {
  return scripts\common\vehicle_paths::_vehicle_resume_named(var_0);
}

function ishelicopter() {
  return scripts\common\vehicle_code::ishelicopter_internal();
}

function isairplane() {
  return scripts\common\vehicle_code::isairplane_internal();
}

function enable_global_vehicle_spawn_functions() {
  scripts\common\vehicle_code::vehicle_setuplevelvariables();
  level.vehicle.spawn_functions_enable = 1;
}