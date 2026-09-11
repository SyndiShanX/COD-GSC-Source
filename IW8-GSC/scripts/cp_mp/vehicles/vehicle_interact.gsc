/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_interact.gsc
*******************************************************/

function vehicle_interact_getleveldataforvehicle(var0, var1, var2) {
  var3 = vehicle_interact_getleveldata();
  var4 = var3.vehicledata[var0];

  if(!isDefined(var4)) {
    if(istrue(var1)) {
      var4 = spawnStruct();
      var4.trial_lap_time = [];
      var3.vehicledata[var0] = var4;
    }
  }

  return var4;
}

function vehicle_interact_getinstancedataforvehicle(var0, var1, var2) {
  var3 = vehicle_interact_getleveldataforvehicle(var0.vehiclename, var1, var2);

  if(!isDefined(var3)) {
    return undefined;
  }

  if(!isDefined(var0 getlinkedscriptableinstance())) {
    return undefined;
  }

  var4 = var0.interactdata;

  if(!isDefined(var4)) {
    if(istrue(var1)) {
      var4 = spawnStruct();
      var0.interactdata = var4;
      var4.disabledbyallow = 0;
      var4.pointdata = [];

      foreach(var6 in var3.trial_lap_time) {
        var4.pointdata[var6] = vehicle_interact_getinstancedataforpoint(var0, var6, var1, var2);
      }

      var4.dirty = 1;
      var4.disabled = undefined;
      var4.availableteam = undefined;
    }
  }

  return var4;
}

function ref_1419d(var0, var1, var2) {
  var3 = vehicle_interact_getleveldataforvehicle(var0, undefined, 1);

  if(!isDefined(var3)) {
    return;
  }

  var4 = ref_141a3(var1);
  var3.trial_lap_time = scripts\engine\utility::array_add(var3.trial_lap_time, var1);
  ref_141aa("activate", var1, var2, var3);
}

function vehicle_interact_registerinstance(var0) {
  vehicle_interact_getinstancedataforvehicle(var0, 1);
  vehicle_interact_makeusable(var0);
  var1 = vehicle_interact_getleveldata();
  var1.vehicles[var0 getentitynumber()] = var0;
}

function vehicle_interact_deregisterinstance(var0) {
  var1 = vehicle_interact_getleveldata();

  if(isDefined(var1.vehicles[var0 getentitynumber()])) {
    vehicle_interact_makeunusable(var0);
  }

  var1.vehicles[var0 getentitynumber()] = undefined;
  var0.interactdata = undefined;
}

function vehicle_interact_instanceisregistered(var0) {
  return isDefined(var0.interactdata);
}

function vehicle_interact_allowvehicleuseglobal(var0) {
  var1 = vehicle_interact_getleveldata();

  if(!isDefined(var1.vehicles)) {
    return;
  }

  if(!var0) {
    var1.disabledbyallow++;

    if(var1.disabledbyallow == 1) {
      foreach(var4, var3 in var1.vehicles) {
        vehicle_interact_setvehicledirty(var3);
        vehicle_interact_updateusability(var3);
      }

      return;
    }

    return;
  }

  var4.disabledbyallow--;

  if(var4.disabledbyallow == 0) {
    foreach(var3 in var4.vehicles) {
      vehicle_interact_setvehicledirty(var3);
      vehicle_interact_updateusability(var3);
    }

    return;
  }
}

function vehicle_interact_allowvehicleuse(var0, var1) {
  var2 = vehicle_interact_getinstancedataforvehicle(var0, undefined, 1);

  if(!isDefined(var2)) {
    return;
  }

  if(!var1) {
    var2.disabledbyallow++;

    if(var2.disabledbyallow == 1) {
      vehicle_interact_setvehicledirty(var0);
      vehicle_interact_updateusability(var0);
      return;
    }

    return;
  }

  var2.disabledbyallow--;

  if(var2.disabledbyallow == 0) {
    vehicle_interact_setvehicledirty(var0);
    vehicle_interact_updateusability(var0);
    return;
  }
}

function vehicle_interact_init() {
  var0 = spawnStruct();
  level.vehicle.interact = var0;
  var0.vehicledata = [];
  var0.trial_lap_time = [];
  var0.disabledbyallow = 0;
  ref_141a7("single", &ref_141a2, &ref_141a0, &ref_1419f, &ref_141a1);
  ref_141a7("upgrade", &ref_141b2, &ref_141ae, &ref_141ad, &ref_141af);
  ref_141a7("copyofupgrade", &ref_141b2, &ref_141ae, &ref_141ad, &ref_141af);
  scripts\engine\scriptable::scriptable_addusedcallback(&vehicle_interact_scriptableused);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_interact", "init", 1)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_interact", "init")]]();
    return;
  }
}

function ref_141a7(var0, var1, var2, var3, var4) {
  var5 = vehicle_interact_getleveldata();
  var6 = spawnStruct();
  var7 = [];
  GscBinSkip0(0x2e, "useInstance", var1);
}

function vehicle_interact_scriptableused(var0, var1, var2, var3, var4) {
  if(var2 == "vehicle_use" || var2 == "vehicle_use_in_air") {
    var5 = var0 getscriptablelinkedentity();
    var6 = var1;

    if(vehicle_interact_playercanusevehicles(var3)) {
      if(istrue(vehicle_interact_vehiclecanbeused(var5))) {
        if(vehicle_interact_playercanusevehicle(var3, var5)) {
          if(vehicle_interact_pointcanbeused(var5, var6)) {
            var7 = vehicle_interact_getinstancedataforpoint(var5, var6);
            ref_141aa("useInstance", var6, var7, var5, var3);
          }
        }
      }
    }
  }
}

function vehicle_interact_updateplayerusability(var0, var1) {
  var2 = vehicle_interact_getleveldata();

  if(!vehicle_interact_playercanusevehicles(var0)) {
    foreach(var4 in var1) {
      var4 disablescriptableplayeruse(var0);
    }

    return;
  }

  foreach(var4 in var4) {
    if(istrue(vehicle_interact_vehiclecanbeused(var4)) && vehicle_interact_playercanusevehicle(var3, var4)) {
      var4 enablescriptableplayeruse(var3);
      continue;
    }

    var4 disablescriptableplayeruse(var3);
  }
}

function vehicle_interact_monitorplayerusability(var0) {
  level endon("game_ended");
  var0 endon("disconnect");

  for(;;) {
    var0 waittill("update_vehicle_usability", var1);
    vehicle_interact_updateplayerusability(var0, var1);
  }
}

function vehicle_interact_getleveldata() {
  return level.vehicle.interact;
}

function ref_141a3(var0) {
  return level.vehicle.interact.trial_lap_time[var0];
}

function ref_141aa(var0, var1, var2, var3, var4) {
  var5 = ref_141a3(var1);
  var6 = var5.callbacks[var0];

  if(isDefined(var6)) {
    level thread[[var6]](var1, var2, var3, var4);
    return;
  }
}

function vehicle_interact_playercanusevehicles(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(!var0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(!var0 scripts\common\utility::is_vehicle_use_allowed()) {
    return false;
  }

  if(var0 isparachuting() || var0 isskydiving()) {
    return false;
  }

  if(var0 isinexecutionattack() || var0 isinexecutionvictim()) {
    return false;
  }

  if(istrue(level.stop_visited_once)) {
    return false;
  }

  return true;
}

function vehicle_interact_vehiclecanbeused(var0) {
  var1 = vehicle_interact_getinstancedataforvehicle(var0, undefined, 1);

  if(!isDefined(var1)) {
    return undefined;
  }

  if(var1.dirty) {
    vehicle_interact_cleanvehicle(var0);
  }

  return !var1.disabled;
}

function vehicle_interact_pointcanbeused(var0, var1) {
  var2 = vehicle_interact_getinstancedataforpoint(var0, var1, undefined, 1);

  if(!isDefined(var2)) {
    return undefined;
  }

  if(var2.dirty) {
    vehicle_interact_cleanpoint(var0, var1);
  }

  return !var2.disabled;
}

function vehicle_interact_playercanusevehicle(var0, var1) {
  if(level.teambased) {
    var2 = vehicle_interact_getvehicleavailableteam(var1);

    if(isDefined(var2) && var2 != var0.team) {
      return false;
    }
  } else {
    var3 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141d5(var1);

    if(isDefined(var3) && var3 != var0) {
      return false;
    }
  }

  return true;
}

function vehicle_interact_getvehicleavailableteam(var0) {
  var1 = vehicle_interact_getinstancedataforvehicle(var0, undefined, 1);

  if(!isDefined(var1)) {
    return undefined;
  }

  if(var1.dirty) {
    vehicle_interact_cleanvehicle(var0);
  }

  return var1.availableteam;
}

function vehicle_interact_setvehicledirty(var0) {
  var1 = vehicle_interact_getinstancedataforvehicle(var0, undefined, 1);

  if(!isDefined(var1)) {
    return;
  }

  var1.dirty = 1;
}

function vehicle_interact_cleanvehicle(var0) {
  var1 = vehicle_interact_getleveldata();
  var2 = vehicle_interact_getinstancedataforvehicle(var0, undefined, 1);

  if(!isDefined(var2)) {
    return;
  }

  if(level.teambased) {
    var3 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141d7(var0);

    if(isDefined(var3)) {
      var2.availableteam = var3;
    } else {
      var4 = undefined;
      var5 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141d6(var0);

      foreach(var7 in var5) {
        if(isDefined(var7)) {
          var4 = var7.team;
          break;
        }
      }

      var2.availableteam = var4;
    }
  }

  if(var1.disabledbyallow > 0) {
    var2.disabled = 1;
  } else if(var2.disabledbyallow > 0) {
    var2.disabled = 1;
  } else {
    var2.disabled = 0;
  }

  var2.dirty = 0;
}

function vehicle_interact_getinstancedataforpoint(var0, var1, var2, var3) {
  var4 = vehicle_interact_getinstancedataforvehicle(var0, var2, var3);

  if(!isDefined(var4)) {
    return undefined;
  }

  var5 = var4.pointdata[var1];

  if(!isDefined(var5) && isDefined(var2)) {
    if(istrue(var2)) {
      var5 = spawnStruct();
      var4.pointdata[var1] = var5;
      var5.dirty = 1;
      var5.disabled = undefined;
      ref_141aa("createInstance", var1, var5, var0);
    }
  }

  return var5;
}

function vehicle_interact_pointisdisabled(var0, var1) {
  var2 = vehicle_interact_getinstancedataforpoint(var0, var1, undefined, 1);

  if(!isDefined(var2)) {
    return undefined;
  }

  if(var2.dirty) {
    vehicle_interact_cleanpoint(var0, var1);
  }

  return var2.disabled;
}

function vehicle_interact_pointavailableseat(var0, var1) {
  var2 = vehicle_interact_getinstancedataforpoint(var0, var1, undefined, 1);

  if(!isDefined(var2)) {
    return undefined;
  }

  if(var2.dirty) {
    vehicle_interact_cleanpoint(var0, var1);
  }

  return var2.availableseatid;
}

function vehicle_interact_setpointdirty(var0, var1) {
  var2 = vehicle_interact_getinstancedataforpoint(var0, var1, undefined, 1);

  if(!isDefined(var2)) {
    return;
  }

  var2.dirty = 1;
}

function vehicle_interact_setpointsdirty(var0) {
  var1 = vehicle_interact_getinstancedataforvehicle(var0, undefined, 1);

  if(!isDefined(var1)) {
    return;
  }

  foreach(var3 in var1.pointdata) {
    var3.dirty = 1;
  }

  var1.dirty = 1;
}

function vehicle_interact_cleanpoint(var0, var1) {
  var2 = vehicle_interact_getinstancedataforpoint(var0, var1, undefined, 1);

  if(!isDefined(var2)) {
    return;
  }

  ref_141aa("cleanInstance", var1, var2, var0);
  var2.dirty = 0;
}

function vehicle_interact_makeusable(var0) {
  vehicle_interact_updateusability(var0);
}

function vehicle_interact_makeunusable(var0) {
  var1 = vehicle_interact_getinstancedataforvehicle(var0, undefined, 1);

  if(!isDefined(var1)) {
    return;
  }

  var2 = getarraykeys(var1.pointdata);

  foreach(var4 in var2) {
    var0 setscriptablepartstate(var4, "vehicle_unusable");
  }
}

function vehicle_interact_updateusability(var0) {
  var1 = vehicle_interact_getinstancedataforvehicle(var0, undefined, 1);

  if(!isDefined(var1)) {
    return;
  }

  if(var1.dirty) {
    vehicle_interact_cleanvehicle(var0);
  }

  if(var1.disabled) {
    vehicle_interact_makeunusable(var0);
    return;
  }

  foreach(var4, var3 in var1.pointdata) {
    if(var3.dirty) {
      vehicle_interact_cleanpoint(var0, var4);
    }

    if(var3.disabled) {
      var0 setscriptablepartstate(var4, "vehicle_unusable");
      continue;
    }

    if(istrue(var0.shouldmodeplayfinalmoments)) {
      var0 setscriptablepartstate(var4, "vehicle_use_in_air");
      continue;
    }

    var0 setscriptablepartstate(var4, "vehicle_use");
  }
}

function ref_141a2(var0, var1, var2, var3) {
  var4 = var1.availableseatid;
  thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var2, var4, var3);
}

function ref_141a0(var0, var1, var2, var3) {
  var4 = var1.ref_12fa8;
  var5 = undefined;

  foreach(var7 in var4) {
    if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_seatisavailable(var2, var7)) {
      var5 = var7;
      break;
    }
  }

  var1.disabled = !isDefined(var5);
  var1.availableseatid = var5;
}

function ref_1419f(var0, var1, var2, var3) {
  var2.ref_12fa8 = var1;
}

function ref_141a1(var0, var1, var2, var3) {
  var4 = vehicle_interact_getleveldataforvehicle(var2.vehiclename, undefined, 1);
  var1.availableseatid = undefined;
  var1.ref_12fa8 = var4.ref_12fa8;
}

function ref_1419e(var0, var1) {
  if(isDefined(var0)) {
    if(!isDefined(var0.ref_12664)) {
      var0.ref_12664 = [];
    }

    var0.ref_12664 = scripts\engine\utility::array_add(var0.ref_12664, var1);
    return;
  }
}

function ref_141a8(var0, var1) {
  if(isDefined(var0) && isDefined(var0.ref_12664)) {
    var0.ref_12664 = scripts\engine\utility::array_remove(var0.ref_12664, var1);
    return;
  }
}

function ref_141b2(var0, var1, var2, var3) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_upgrade", "init")) {
    if(!isDefined(level.delayedeventtypes)) {
      var3 iprintlnbold("BR Kiosk station is not activated in this game mode");
      return;
    }

    [[var1.emp_nearby_targets]](var2, var3);
    var3 setclientomnvar("ui_br_purchase_file_override", var1.emp_effect_duration);
    var3.delete_silo_lights = 1;
    var3.ref_1424d = var2;
    ref_1419e(var2, var3);
    var4 = scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_upgrade", "init");
    var5 = ref_141b1(var2, var0);
    var3 thread[[var4]](var5);
    return;
  }
}

function ref_141ae(var0, var1, var2, var3) {
  var1.disabled = 0;
}

function ref_141ad(var0, var1, var2, var3) {
  if(!isDefined(var2.wait_for_lmg_dead)) {
    var2.wait_for_lmg_dead = [];
  }

  if(!isDefined(var2.emp_drone_success_use)) {
    var2.emp_drone_success_use = [];
  }

  if(!isDefined(var2.emp_nearby_targets)) {
    var2.emp_nearby_targets = [];
  }

  var2.wait_for_lmg_dead[var0] = var1[0];
  var2.emp_drone_success_use[var0] = var1[1];
  var2.emp_nearby_targets[var0] = var1[2];
}

function ref_141af(var0, var1, var2, var3) {
  var4 = vehicle_interact_getleveldataforvehicle(var2.vehiclename, undefined, 1);
  var1.emp_effect_duration = var4.emp_drone_success_use[var0];
  var1.emp_nearby_targets = var4.emp_nearby_targets[var0];
  var5 = var4.wait_for_lmg_dead[var0];
  ref_141b0(var2, var0, var5);
}

function ref_141b1(var0, var1) {
  return var0.wait_for_kills[var1];
}

function ref_141b0(var0, var1, var2) {
  if(!isDefined(var0.wait_for_kills)) {
    var0.wait_for_kills = [];
  }

  var3 = spawnStruct();
  thread ref_141ab(var3, var0);
  var0.wait_for_kills[var1] = var3;
}

function ref_141ab(var0, var1) {
  var0 endon("death");

  for(;;) {
    self.origin = var0 gettagorigin(var1);
    wait 0.5;
  }
}

function ref_141ac(var0, var1) {
  ref_141a6(var0);
  return isDefined(var0.ref_14034) && istrue(var0.ref_14034[var1]);
}

function ref_141a6(var0) {
  if(!isDefined(var0.ref_14034)) {
    var0.ref_14034 = [];
    return;
  }
}

function ref_141a4(var0, var1, var2) {
  ref_141a9(var0, var1);
  var0 notify("give_upgrade", var1, var2);
}

function ref_141a9(var0, var1) {
  ref_141a6(var0);
  var0.ref_14034[var1] = 1;
}

function ref_141a5() {
  var0 = setdvarifuninitialized("scr_enterVehicleSeatOverride", 0);
}