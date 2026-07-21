/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\vehicle.gsc
***********************************************/

init_vehicles() {
  if(isDefined(level.disablevehiclescripts) && level.disablevehiclescripts) {
    return;
  }
  if(!scripts\engine\utility::add_init_script("_encstr_A35F099B8B0BAA5B5081FA", ::init_vehicles)) {
    return;
  }
  thread init_vehicles_thread();
  cleanup_vt();
}

cleanup_vt() {
  level.vtclassname = undefined;
  level.vtmodel = undefined;
  level.vttype = undefined;
}

init_vehicles_thread() {
  scripts\engine\utility::create_lock("_encstr_AB881358D24E6C272C66D1AFDD58CDD0BE6B0BD186");
  scripts\common\vehicle_code::vehicle_setuplevelvariables();
  level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_combine(level.vehicle.helicopter_crash_locations, scripts\engine\utility::getstructarray_delete("_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  scripts\common\vehicle_code::vehicle_setupspawners();
  var_0 = scripts\common\vehicle_code::vehicle_precachescripts();
  scripts\common\vehicle_code::setup_vehicles(var_0);
  level.vehicle.has_vehicles = getEntArray("_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56", "_encstr_956D0F572FD22561C3BD81DB62A6D869BA").size > 0;
  scripts\engine\utility::script_func("_encstr_821A109F376A972849A3B0F1CF8CA333321F", "_encstr_A2D8122DDCD9BAB19527589836AC7DCC93C2B3B9", &"_encstr_954E19E1BDFEFFCA41B7B9B6ADA1053706156898C5D08B32B15FBB");
  scripts\engine\utility::script_func("_encstr_821A109F376A972849A3B0F1CF8CA333321F", "_encstr_AF2314A1F00B17A57320BA82F85B51F3C3693C251573", &"_encstr_A7D61BA968254A14A8CB922795AA1315928290982AEB48AA6298158AA9");
}

vehicle_paths(var_0, var_1, var_2) {
  return scripts\common\vehicle_paths::_vehicle_paths(var_0, var_1, var_2);
}

vehicle_spawn(var_0) {
  return scripts\common\vehicle_code::vehicle_spawn_internal(var_0);
}

godon() {
  self.godmode = 1;
}

godoff() {
  self.godmode = 0;
}

mainturretoff() {
  return scripts\common\vehicle_code::_mainturretoff();
}

mainturreton() {
  return scripts\common\vehicle_code::_mainturreton();
}

mgoff() {
  return scripts\common\vehicle_code::_mgoff();
}

mgon() {
  return scripts\common\vehicle_code::_mgon();
}

isvehicle() {
  return isDefined(self.vehicletype);
}

vehicle_is_crashing() {
  return scripts\common\vehicle_code::vehicle_iscrashing();
}

is_godmode() {
  return scripts\common\vehicle_code::_is_godmode();
}

vehicle_kill_rumble_forever() {
  self notify("_encstr_8E601457C8AB31F0C383CF89623581AD97FA9D6CE7A0");
}

spawn_vehicles_from_targetname(var_0) {
  var_1 = [];
  var_2 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_2) {
    if(!isDefined(var_4.code_classname) || var_4.code_classname != "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
      continue;
    }
    if(isspawner(var_4)) {
      var_5 = scripts\common\vehicle_code::vehicle_spawn_internal(var_4);
      var_1 = scripts\engine\utility::array_add(var_1, var_5);
    }
  }

  return var_1;
}

spawn_vehicle_from_targetname(var_0) {
  var_1 = spawn_vehicles_from_targetname(var_0);
  return var_1[0];
}

spawn_vehicle_from_targetname_and_drive(var_0) {
  var_1 = spawn_vehicles_from_targetname(var_0);
  thread scripts\common\vehicle_paths::gopath(var_1[0]);
  return var_1[0];
}

spawn_vehicles_from_targetname_and_drive(var_0) {
  var_1 = spawn_vehicles_from_targetname(var_0);

  foreach(var_3 in var_1)
  thread scripts\common\vehicle_paths::gopath(var_3);

  return var_1;
}

aircraft_wash(var_0) {
  thread scripts\common\vehicle_code::aircraft_wash_thread(var_0);
}

vehicle_wheels_forward() {
  scripts\common\vehicle_code::vehicle_setwheeldirection(1);
}

vehicle_wheels_backward() {
  scripts\common\vehicle_code::vehicle_setwheeldirection(0);
}

vehicle_load_ai(var_0, var_1, var_2) {
  if(!isarray(var_0))
    var_0 = [var_0];

  scripts\common\vehicle_aianim::load_ai(var_0, var_1, var_2);

  if(getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F")) {
    if(!self.usedpositions[0]) {
      var_3 = self.riders;
      vehicle_unload();
      scripts\engine\utility::ent_flag_wait("_encstr_BD82096B5DA4B07F924F29");
      var_3 = scripts\engine\utility::array_removedead(var_3);
      var_3 = scripts\engine\utility::array_remove_array(var_3, self.riders);

      if(var_3.size > 0) {
        vehicle_load_ai(var_3);
        return;
      }
    } else {
      var_4 = level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()];

      if(isDefined(var_4[0].death)) {
        foreach(var_6 in self.riders) {
          if(istrue(var_6.drivingvehicle))
            thread scripts\common\vehicle_aianim::driverdead(var_6);
        }
      }
    }
  }
}

spawn_vehicle_and_gopath() {
  var_0 = scripts\common\utility::spawn_vehicle();

  if(isDefined(self.script_speed)) {
    if(!ishelicopter())
      var_0 vehicle_setspeed(self.script_speed);
  }

  thread scripts\common\vehicle_paths::gopath(var_0);
  return var_0;
}

attach_vehicle(var_0) {
  self vehicle_teleport(var_0.origin, var_0.angles);

  if(!ishelicopter()) {
    waitframe();
    self attachpath(var_0);
  }

  thread vehicle_paths(var_0, 1);
}

attach_vehicle_and_gopath(var_0) {
  self vehicle_teleport(var_0.origin, var_0.angles);
  waitframe();

  if(!ishelicopter())
    self attachpath(var_0);

  thread vehicle_paths(var_0);
  scripts\common\vehicle_paths::gopath(self);
}

vehicle_get_riders_by_group(var_0) {
  var_1 = [];
  var_2 = scripts\common\vehicle_code::get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.unloadgroups[var_2]))
    return var_1;

  var_3 = level.vehicle.templates.unloadgroups[var_2];

  if(!isDefined(var_0))
    return var_1;

  foreach(var_5 in self.riders) {
    foreach(var_7 in var_3[var_0]) {
      if(var_5.vehicle_position == var_7)
        var_1[var_1.size] = var_5;
    }
  }

  return var_1;
}

vehicle_unload(var_0) {
  return scripts\common\vehicle_code::_vehicle_unload(var_0);
}

vehicle_turret_scan_off() {
  self notify("_encstr_81B2150B03BF32B93B18B01E50574807B7CB1B72D23049");
}

vehicle_get_path_array() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = [];
  var_1 = self.attachedpath;

  if(!isDefined(self.attachedpath))
    return var_0;

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
      var_2 = getvehiclenode(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      continue;
    }

    var_2 = scripts\engine\utility::getent_or_struct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  }

  return var_0;
}

vehicle_lights_on(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = "_encstr_AF1904A7F929";

  scripts\common\vehicle_lights::lights_on(var_0, var_1);
}

vehicle_lights_off(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = "_encstr_AF1904A7F929";

  scripts\common\vehicle_lights::lights_off(var_0, var_1);
}

vehicle_switch_paths(var_0, var_1) {
  self setswitchnode(var_0, var_1);
  self.attachedpath = var_1;
  thread vehicle_paths();
}

vehicle_stop_named(var_0, var_1, var_2) {
  return scripts\common\vehicle_paths::_vehicle_stop_named(var_0, var_1, var_2);
}

vehicle_resume_named(var_0) {
  return scripts\common\vehicle_paths::_vehicle_resume_named(var_0);
}

ishelicopter() {
  return scripts\common\vehicle_code::ishelicopter_internal();
}

isairplane() {
  return scripts\common\vehicle_code::isairplane_internal();
}

enable_global_vehicle_spawn_functions() {
  scripts\common\vehicle_code::vehicle_setuplevelvariables();
  level.vehicle.spawn_functions_enable = 1;
}