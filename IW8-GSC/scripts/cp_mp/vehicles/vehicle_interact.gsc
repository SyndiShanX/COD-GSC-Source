/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_interact.gsc
*******************************************************/

function vehicle_interact_getleveldataforvehicle(var_0, var_1, var_2) {
  var_3 = vehicle_interact_getleveldata();
  var_4 = var_3.vehicledata[var_0];

  if(!isDefined(var_4)) {
    if(istrue(var_1)) {
      var_4 = spawnStruct();
      var_4.trial_lap_time = [];
      var_3.vehicledata[var_0] = var_4;
    }
  }

  return var_4;
}

function vehicle_interact_getinstancedataforvehicle(var_0, var_1, var_2) {
  var_3 = vehicle_interact_getleveldataforvehicle(var_0.vehiclename, var_1, var_2);

  if(!isDefined(var_3)) {
    return undefined;
  }

  if(!isDefined(var_0 getlinkedscriptableinstance())) {
    return undefined;
  }

  var_4 = var_0.interactdata;

  if(!isDefined(var_4)) {
    if(istrue(var_1)) {
      var_4 = spawnStruct();
      var_0.interactdata = var_4;
      var_4.disabledbyallow = 0;
      var_4.pointdata = [];

      foreach(var_6 in var_3.trial_lap_time) {
        var_4.pointdata[var_6] = vehicle_interact_getinstancedataforpoint(var_0, var_6, var_1, var_2);
      }

      var_4.dirty = 1;
      var_4.disabled = undefined;
      var_4.availableteam = undefined;
    }
  }

  return var_4;
}

function ref_1419D(var_0, var_1, var_2) {
  var_3 = vehicle_interact_getleveldataforvehicle(var_0, undefined, 1);

  if(!isDefined(var_3)) {
    return;
  }

  var_4 = ref_141A3(var_1);
  var_3.trial_lap_time = scripts\engine\utility::array_add(var_3.trial_lap_time, var_1);
  ref_141AA("activate", var_1, var_2, var_3);
}

function vehicle_interact_registerinstance(var_0) {
  vehicle_interact_getinstancedataforvehicle(var_0, 1);
  vehicle_interact_makeusable(var_0);
  var_1 = vehicle_interact_getleveldata();
  var_1.vehicles[var_0 getentitynumber()] = var_0;
}

function vehicle_interact_deregisterinstance(var_0) {
  var_1 = vehicle_interact_getleveldata();

  if(isDefined(var_1.vehicles[var_0 getentitynumber()])) {
    vehicle_interact_makeunusable(var_0);
  }

  var_1.vehicles[var_0 getentitynumber()] = undefined;
  var_0.interactdata = undefined;
}

function vehicle_interact_instanceisregistered(var_0) {
  return isDefined(var_0.interactdata);
}

function vehicle_interact_allowvehicleuseglobal(var_0) {
  var_1 = vehicle_interact_getleveldata();

  if(!isDefined(var_1.vehicles)) {
    return;
  }

  if(!var_0) {
    var_1.disabledbyallow++;

    if(var_1.disabledbyallow == 1) {
      foreach(var_4, var_3 in var_1.vehicles) {
        vehicle_interact_setvehicledirty(var_3);
        vehicle_interact_updateusability(var_3);
      }

      return;
    }

    return;
  }

  var_4.disabledbyallow--;

  if(var_4.disabledbyallow == 0) {
    foreach(var_3 in var_4.vehicles) {
      vehicle_interact_setvehicledirty(var_3);
      vehicle_interact_updateusability(var_3);
    }

    return;
  }
}

function vehicle_interact_allowvehicleuse(var_0, var_1) {
  var_2 = vehicle_interact_getinstancedataforvehicle(var_0, undefined, 1);

  if(!isDefined(var_2)) {
    return;
  }

  if(!var_1) {
    var_2.disabledbyallow++;

    if(var_2.disabledbyallow == 1) {
      vehicle_interact_setvehicledirty(var_0);
      vehicle_interact_updateusability(var_0);
      return;
    }

    return;
  }

  var_2.disabledbyallow--;

  if(var_2.disabledbyallow == 0) {
    vehicle_interact_setvehicledirty(var_0);
    vehicle_interact_updateusability(var_0);
    return;
  }
}

function vehicle_interact_init() {
  var_0 = spawnStruct();
  level.vehicle.interact = var_0;
  var_0.vehicledata = [];
  var_0.trial_lap_time = [];
  var_0.disabledbyallow = 0;
  ref_141A7("single", &ref_141A2, &ref_141A0, &ref_1419F, &ref_141A1);
  ref_141A7("upgrade", &ref_141B2, &ref_141AE, &ref_141AD, &ref_141AF);
  ref_141A7("copyofupgrade", &ref_141B2, &ref_141AE, &ref_141AD, &ref_141AF);
  scripts\engine\scriptable::scriptable_addusedcallback(&vehicle_interact_scriptableused);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_interact", "init", 1)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_interact", "init")]]();
    return;
  }
}

function ref_141A7(var_0, var_1, var_2, var_3, var_4) {
  var_5 = vehicle_interact_getleveldata();
  var_6 = spawnStruct();
  var_7 = [];
  GscBinSkip0(0x2e, "useInstance", var_1);
}

function vehicle_interact_scriptableused(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "vehicle_use" || var_2 == "vehicle_use_in_air") {
    var_5 = var_0 getscriptablelinkedentity();
    var_6 = var_1;

    if(vehicle_interact_playercanusevehicles(var_3)) {
      if(istrue(vehicle_interact_vehiclecanbeused(var_5))) {
        if(vehicle_interact_playercanusevehicle(var_3, var_5)) {
          if(vehicle_interact_pointcanbeused(var_5, var_6)) {
            var_7 = vehicle_interact_getinstancedataforpoint(var_5, var_6);
            ref_141AA("useInstance", var_6, var_7, var_5, var_3);
          }
        }
      }
    }
  }
}

function vehicle_interact_updateplayerusability(var_0, var_1) {
  var_2 = vehicle_interact_getleveldata();

  if(!vehicle_interact_playercanusevehicles(var_0)) {
    foreach(var_4 in var_1) {
      var_4 disablescriptableplayeruse(var_0);
    }

    return;
  }

  foreach(var_4 in var_4) {
    if(istrue(vehicle_interact_vehiclecanbeused(var_4)) && vehicle_interact_playercanusevehicle(var_3, var_4)) {
      var_4 enablescriptableplayeruse(var_3);
      continue;
    }

    var_4 disablescriptableplayeruse(var_3);
  }
}

function vehicle_interact_monitorplayerusability(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("update_vehicle_usability", var_1);
    vehicle_interact_updateplayerusability(var_0, var_1);
  }
}

function vehicle_interact_getleveldata() {
  return level.vehicle.interact;
}

function ref_141A3(var_0) {
  return level.vehicle.interact.trial_lap_time[var_0];
}

function ref_141AA(var_0, var_1, var_2, var_3, var_4) {
  var_5 = ref_141A3(var_1);
  var_6 = var_5.callbacks[var_0];

  if(isDefined(var_6)) {
    level thread[[var_6]](var_1, var_2, var_3, var_4);
    return;
  }
}

function vehicle_interact_playercanusevehicles(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(!var_0 scripts\common\utility::is_vehicle_use_allowed()) {
    return false;
  }

  if(var_0 isparachuting() || var_0 isskydiving()) {
    return false;
  }

  if(var_0 isinexecutionattack() || var_0 isinexecutionvictim()) {
    return false;
  }

  if(istrue(level.stop_visited_once)) {
    return false;
  }

  return true;
}

function vehicle_interact_vehiclecanbeused(var_0) {
  var_1 = vehicle_interact_getinstancedataforvehicle(var_0, undefined, 1);

  if(!isDefined(var_1)) {
    return undefined;
  }

  if(var_1.dirty) {
    vehicle_interact_cleanvehicle(var_0);
  }

  return !var_1.disabled;
}

function vehicle_interact_pointcanbeused(var_0, var_1) {
  var_2 = vehicle_interact_getinstancedataforpoint(var_0, var_1, undefined, 1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  if(var_2.dirty) {
    vehicle_interact_cleanpoint(var_0, var_1);
  }

  return !var_2.disabled;
}

function vehicle_interact_playercanusevehicle(var_0, var_1) {
  if(level.teambased) {
    var_2 = vehicle_interact_getvehicleavailableteam(var_1);

    if(isDefined(var_2) && var_2 != var_0.team) {
      return false;
    }
  } else {
    var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141D5(var_1);

    if(isDefined(var_3) && var_3 != var_0) {
      return false;
    }
  }

  return true;
}

function vehicle_interact_getvehicleavailableteam(var_0) {
  var_1 = vehicle_interact_getinstancedataforvehicle(var_0, undefined, 1);

  if(!isDefined(var_1)) {
    return undefined;
  }

  if(var_1.dirty) {
    vehicle_interact_cleanvehicle(var_0);
  }

  return var_1.availableteam;
}

function vehicle_interact_setvehicledirty(var_0) {
  var_1 = vehicle_interact_getinstancedataforvehicle(var_0, undefined, 1);

  if(!isDefined(var_1)) {
    return;
  }

  var_1.dirty = 1;
}

function vehicle_interact_cleanvehicle(var_0) {
  var_1 = vehicle_interact_getleveldata();
  var_2 = vehicle_interact_getinstancedataforvehicle(var_0, undefined, 1);

  if(!isDefined(var_2)) {
    return;
  }

  if(level.teambased) {
    var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141D7(var_0);

    if(isDefined(var_3)) {
      var_2.availableteam = var_3;
    } else {
      var_4 = undefined;
      var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141D6(var_0);

      foreach(var_7 in var_5) {
        if(isDefined(var_7)) {
          var_4 = var_7.team;
          break;
        }
      }

      var_2.availableteam = var_4;
    }
  }

  if(var_1.disabledbyallow > 0) {
    var_2.disabled = 1;
  } else if(var_2.disabledbyallow > 0) {
    var_2.disabled = 1;
  } else {
    var_2.disabled = 0;
  }

  var_2.dirty = 0;
}

function vehicle_interact_getinstancedataforpoint(var_0, var_1, var_2, var_3) {
  var_4 = vehicle_interact_getinstancedataforvehicle(var_0, var_2, var_3);

  if(!isDefined(var_4)) {
    return undefined;
  }

  var_5 = var_4.pointdata[var_1];

  if(!isDefined(var_5) && isDefined(var_2)) {
    if(istrue(var_2)) {
      var_5 = spawnStruct();
      var_4.pointdata[var_1] = var_5;
      var_5.dirty = 1;
      var_5.disabled = undefined;
      ref_141AA("createInstance", var_1, var_5, var_0);
    }
  }

  return var_5;
}

function vehicle_interact_pointisdisabled(var_0, var_1) {
  var_2 = vehicle_interact_getinstancedataforpoint(var_0, var_1, undefined, 1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  if(var_2.dirty) {
    vehicle_interact_cleanpoint(var_0, var_1);
  }

  return var_2.disabled;
}

function vehicle_interact_pointavailableseat(var_0, var_1) {
  var_2 = vehicle_interact_getinstancedataforpoint(var_0, var_1, undefined, 1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  if(var_2.dirty) {
    vehicle_interact_cleanpoint(var_0, var_1);
  }

  return var_2.availableseatid;
}

function vehicle_interact_setpointdirty(var_0, var_1) {
  var_2 = vehicle_interact_getinstancedataforpoint(var_0, var_1, undefined, 1);

  if(!isDefined(var_2)) {
    return;
  }

  var_2.dirty = 1;
}

function vehicle_interact_setpointsdirty(var_0) {
  var_1 = vehicle_interact_getinstancedataforvehicle(var_0, undefined, 1);

  if(!isDefined(var_1)) {
    return;
  }

  foreach(var_3 in var_1.pointdata) {
    var_3.dirty = 1;
  }

  var_1.dirty = 1;
}

function vehicle_interact_cleanpoint(var_0, var_1) {
  var_2 = vehicle_interact_getinstancedataforpoint(var_0, var_1, undefined, 1);

  if(!isDefined(var_2)) {
    return;
  }

  ref_141AA("cleanInstance", var_1, var_2, var_0);
  var_2.dirty = 0;
}

function vehicle_interact_makeusable(var_0) {
  vehicle_interact_updateusability(var_0);
}

function vehicle_interact_makeunusable(var_0) {
  var_1 = vehicle_interact_getinstancedataforvehicle(var_0, undefined, 1);

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = getarraykeys(var_1.pointdata);

  foreach(var_4 in var_2) {
    var_0 setscriptablepartstate(var_4, "vehicle_unusable");
  }
}

function vehicle_interact_updateusability(var_0) {
  var_1 = vehicle_interact_getinstancedataforvehicle(var_0, undefined, 1);

  if(!isDefined(var_1)) {
    return;
  }

  if(var_1.dirty) {
    vehicle_interact_cleanvehicle(var_0);
  }

  if(var_1.disabled) {
    vehicle_interact_makeunusable(var_0);
    return;
  }

  foreach(var_4, var_3 in var_1.pointdata) {
    if(var_3.dirty) {
      vehicle_interact_cleanpoint(var_0, var_4);
    }

    if(var_3.disabled) {
      var_0 setscriptablepartstate(var_4, "vehicle_unusable");
      continue;
    }

    if(istrue(var_0.shouldmodeplayfinalmoments)) {
      var_0 setscriptablepartstate(var_4, "vehicle_use_in_air");
      continue;
    }

    var_0 setscriptablepartstate(var_4, "vehicle_use");
  }
}

function ref_141A2(var_0, var_1, var_2, var_3) {
  var_4 = var_1.availableseatid;
  thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, var_4, var_3);
}

function ref_141A0(var_0, var_1, var_2, var_3) {
  var_4 = var_1.ref_12FA8;
  var_5 = undefined;

  foreach(var_7 in var_4) {
    if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_seatisavailable(var_2, var_7)) {
      var_5 = var_7;
      break;
    }
  }

  var_1.disabled = !isDefined(var_5);
  var_1.availableseatid = var_5;
}

function ref_1419F(var_0, var_1, var_2, var_3) {
  var_2.ref_12FA8 = var_1;
}

function ref_141A1(var_0, var_1, var_2, var_3) {
  var_4 = vehicle_interact_getleveldataforvehicle(var_2.vehiclename, undefined, 1);
  var_1.availableseatid = undefined;
  var_1.ref_12FA8 = var_4.ref_12FA8;
}

function ref_1419E(var_0, var_1) {
  if(isDefined(var_0)) {
    if(!isDefined(var_0.ref_12664)) {
      var_0.ref_12664 = [];
    }

    var_0.ref_12664 = scripts\engine\utility::array_add(var_0.ref_12664, var_1);
    return;
  }
}

function ref_141A8(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_0.ref_12664)) {
    var_0.ref_12664 = scripts\engine\utility::array_remove(var_0.ref_12664, var_1);
    return;
  }
}

function ref_141B2(var_0, var_1, var_2, var_3) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_upgrade", "init")) {
    if(!isDefined(level.delayedeventtypes)) {
      var_3 iprintlnbold("BR Kiosk station is not activated in this game mode");
      return;
    }

    [[var_1.emp_nearby_targets]](var_2, var_3);
    var_3 setclientomnvar("ui_br_purchase_file_override", var_1.emp_effect_duration);
    var_3.delete_silo_lights = 1;
    var_3.ref_1424D = var_2;
    ref_1419E(var_2, var_3);
    var_4 = scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_upgrade", "init");
    var_5 = ref_141B1(var_2, var_0);
    var_3 thread[[var_4]](var_5);
    return;
  }
}

function ref_141AE(var_0, var_1, var_2, var_3) {
  var_1.disabled = 0;
}

function ref_141AD(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2.wait_for_lmg_dead)) {
    var_2.wait_for_lmg_dead = [];
  }

  if(!isDefined(var_2.emp_drone_success_use)) {
    var_2.emp_drone_success_use = [];
  }

  if(!isDefined(var_2.emp_nearby_targets)) {
    var_2.emp_nearby_targets = [];
  }

  var_2.wait_for_lmg_dead[var_0] = var_1[0];
  var_2.emp_drone_success_use[var_0] = var_1[1];
  var_2.emp_nearby_targets[var_0] = var_1[2];
}

function ref_141AF(var_0, var_1, var_2, var_3) {
  var_4 = vehicle_interact_getleveldataforvehicle(var_2.vehiclename, undefined, 1);
  var_1.emp_effect_duration = var_4.emp_drone_success_use[var_0];
  var_1.emp_nearby_targets = var_4.emp_nearby_targets[var_0];
  var_5 = var_4.wait_for_lmg_dead[var_0];
  ref_141B0(var_2, var_0, var_5);
}

function ref_141B1(var_0, var_1) {
  return var_0.wait_for_kills[var_1];
}

function ref_141B0(var_0, var_1, var_2) {
  if(!isDefined(var_0.wait_for_kills)) {
    var_0.wait_for_kills = [];
  }

  var_3 = spawnStruct();
  thread ref_141AB(var_3, var_0);
  var_0.wait_for_kills[var_1] = var_3;
}

function ref_141AB(var_0, var_1) {
  var_0 endon("death");

  for(;;) {
    self.origin = var_0 gettagorigin(var_1);
    wait 0.5;
  }
}

function ref_141AC(var_0, var_1) {
  ref_141A6(var_0);
  return isDefined(var_0.ref_14034) && istrue(var_0.ref_14034[var_1]);
}

function ref_141A6(var_0) {
  if(!isDefined(var_0.ref_14034)) {
    var_0.ref_14034 = [];
    return;
  }
}

function ref_141A4(var_0, var_1, var_2) {
  ref_141A9(var_0, var_1);
  var_0 notify("give_upgrade", var_1, var_2);
}

function ref_141A9(var_0, var_1) {
  ref_141A6(var_0);
  var_0.ref_14034[var_1] = 1;
}

function ref_141A5() {
  var_0 = setdvarifuninitialized("scr_enterVehicleSeatOverride", 0);
}