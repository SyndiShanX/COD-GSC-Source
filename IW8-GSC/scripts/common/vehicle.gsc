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
  var0 = scripts\common\vehicle_code::vehicle_precachescripts();
  scripts\common\vehicle_code::setup_vehicles(var0);
  level.vehicle.has_vehicles = getEntArray("script_vehicle", "code_classname").size > 0;
  scripts\engine\utility::script_func("add_hint_string", "invulerable_frags", &"SCRIPT/INVULERABLE_FRAGS");
  scripts\engine\utility::script_func("add_hint_string", "invulerable_bullets", &"SCRIPT/INVULERABLE_BULLETS");
}

function vehicle_paths(var0, var1, var2) {
  return scripts\common\vehicle_paths::_vehicle_paths(var0, var1, var2);
}

function vehicle_spawn(var0) {
  return scripts\common\vehicle_code::vehicle_spawn_internal(var0);
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

function spawn_vehicles_from_targetname(var0) {
  var1 = [];
  var2 = getEntArray(var0, "targetname");

  foreach(var4 in var2) {
    if(!isDefined(var4.code_classname) || var4.code_classname != "script_vehicle") {
      continue;
    }

    if(isspawner(var4)) {
      var5 = scripts\common\vehicle_code::vehicle_spawn_internal(var4);
      var1 = scripts\engine\utility::array_add(var1, var5);
    }
  }

  return var1;
}

function spawn_vehicle_from_targetname(var0) {
  var1 = spawn_vehicles_from_targetname(var0);
  return var1[0];
}

function spawn_vehicle_from_targetname_and_drive(var0) {
  var1 = spawn_vehicles_from_targetname(var0);
  thread scripts\common\vehicle_paths::gopath(var1[0]);
  return var1[0];
}

function spawn_vehicles_from_targetname_and_drive(var0) {
  var1 = spawn_vehicles_from_targetname(var0);

  foreach(var3 in var1) {
    thread scripts\common\vehicle_paths::gopath(var3);
  }

  return var1;
}

function aircraft_wash(var0) {
  thread scripts\common\vehicle_code::aircraft_wash_thread(var0);
}

function vehicle_wheels_forward() {
  scripts\common\vehicle_code::vehicle_setwheeldirection(1);
}

function vehicle_wheels_backward() {
  scripts\common\vehicle_code::vehicle_setwheeldirection(0);
}

function vehicle_load_ai(var0, var1, var2) {
  if(!isarray(var0)) {
    var0 = [var0];
  }

  scripts\common\vehicle_aianim::load_ai(var0, var1, var2);

  if(getdvarint("enable_vehicle_ai_using_BT")) {
    if(!self.usedpositions[0]) {
      var3 = self.riders;
      vehicle_unload();
      scripts\engine\utility::ent_flag_wait("unloaded");
      var3 = scripts\engine\utility::array_removedead(var3);
      var3 = scripts\engine\utility::array_remove_array(var3, self.riders);

      if(var3.size > 0) {
        vehicle_load_ai(var3);
        return;
      }

      return;
    }

    var4 = level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()];

    if(isDefined(var4[0].death)) {
      foreach(var6 in self.riders) {
        if(istrue(var6.drivingvehicle)) {
          thread scripts\common\vehicle_aianim::driverdead(var6);
        }
      }

      return;
    }

    return;
  }
}

function spawn_vehicle_and_gopath() {
  var0 = scripts\common\utility::spawn_vehicle();

  if(isDefined(self.script_speed)) {
    if(!ishelicopter()) {
      var0 vehicle_setspeed(self.script_speed);
    }
  }

  thread scripts\common\vehicle_paths::gopath(var0);
  return var0;
}

function attach_vehicle(var0) {
  self vehicle_teleport(var0.origin, var0.angles);

  if(!ishelicopter()) {
    waitframe();
    self attachpath(var0);
  }

  thread vehicle_paths(var0, 1);
}

function attach_vehicle_and_gopath(var0) {
  self vehicle_teleport(var0.origin, var0.angles);
  waitframe();

  if(!ishelicopter()) {
    self attachpath(var0);
  }

  thread vehicle_paths(var0);
  scripts\common\vehicle_paths::gopath(self);
}

function vehicle_get_riders_by_group(var0) {
  var1 = [];
  var2 = scripts\common\vehicle_code::get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.unloadgroups[var2])) {
    return var1;
  }

  var3 = level.vehicle.templates.unloadgroups[var2];

  if(!isDefined(var0)) {
    return var1;
  }

  foreach(var5 in self.riders) {
    foreach(var7 in var3[var0]) {
      if(var5.vehicle_position == var7) {
        var1 = var5;
      }
    }
  }

  return var1;
}

function vehicle_unload(var0) {
  return scripts\common\vehicle_code::_vehicle_unload(var0);
}

function vehicle_turret_scan_off() {
  self notify("stop_scanning_turret");
}

function vehicle_get_path_array() {
  self endon("death");
  var0 = [];
  var1 = self.attachedpath;

  if(!isDefined(self.attachedpath)) {
    return var0;
  }

  var2 = var1;
  var2.counted = 0;

  while(isDefined(var2)) {
    if(isDefined(var2.counted) && var2.counted == 1) {
      break;
    }

    var0 = scripts\engine\utility::array_add(var0, var2);
    var2.counted = 1;

    if(!isDefined(var2.target)) {
      break;
    }

    if(!ishelicopter()) {
      var2 = getvehiclenode(var2.target, "targetname");
      continue;
    }

    var2 = scripts\engine\utility::getent_or_struct(var2.target, "targetname");
  }

  return var0;
}

function vehicle_lights_on(var0, var1) {
  if(!isDefined(var0)) {
    var0 = "all";
  }

  scripts\common\vehicle_lights::lights_on(var0, var1);
}

function vehicle_lights_off(var0, var1) {
  if(!isDefined(var0)) {
    var0 = "all";
  }

  scripts\common\vehicle_lights::lights_off(var0, var1);
}

function vehicle_switch_paths(var0, var1) {
  self setswitchnode(var0, var1);
  self.attachedpath = var1;
  thread vehicle_paths();
}

function vehicle_stop_named(var0, var1, var2) {
  return scripts\common\vehicle_paths::_vehicle_stop_named(var0, var1, var2);
}

function vehicle_resume_named(var0) {
  return scripts\common\vehicle_paths::_vehicle_resume_named(var0);
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