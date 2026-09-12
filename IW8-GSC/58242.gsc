/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58242.gsc
***********************************************/

function ref_1412b(var_0) {
  var_1 = ref_14122();
  var_1.instances[var_0 getentitynumber()] = var_0;
  ref_1412f(var_0);
}

function ref_14120(var_0) {
  var_1 = ref_14122();
  var_1.instances[var_0 getentitynumber()] = undefined;
}

function ref_14126(var_0) {
  var_1 = ref_14122();
  return isDefined(var_1.instances[var_0 getentitynumber()]) && var_1.instances[var_0 getentitynumber()] == var_0;
}

function ref_14132(var_0, var_1, var_2) {
  var_3 = ref_14122();

  if(!var_3.ref_142ce) {
    return;
  }

  if(!ref_14126(var_0)) {
    if(istrue(var_2)) {}

    return;
  }

  if(!ref_1412e(var_0, var_1)) {
    var_0 vehicleshowonminimapforclient(var_1, 0);
    return;
  }

  var_0 vehicleshowonminimapforclient(var_1, 1);
}

function ref_14131(var_0, var_1) {
  var_2 = ref_14122();

  if(!var_2.ref_142ce) {
    return;
  }

  if(!ref_14126(var_0)) {
    if(istrue(var_1)) {}

    return;
  }

  foreach(var_4 in level.players) {
    ref_14132(var_0, var_4);
  }
}

function ref_14130(var_0) {
  var_1 = ref_14122();

  if(!var_1.ref_142ce) {
    return;
  }

  foreach(var_3 in var_1.instances) {
    ref_14132(var_3, var_0);
  }
}

function ref_1412e(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_compass", "shouldBeVisibleToPlayer")) {
    var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_compass", "shouldBeVisibleToPlayer")]](var_0, var_1);

    if(isDefined(var_2)) {
      return var_2;
    }
  }

  if(!scripts\cp_mp\vehicles\vehicle::ref_141b9(var_0, var_1)) {
    return 0;
  }

  return 1;
}

function ref_1412f(var_0) {
  var_1 = ref_14122();

  if(var_1.ref_142ce) {
    var_0 vehicleshowonminimap(1);
  }

  if(isDefined(var_1.instances[var_0 getentitynumber()])) {
    if(level.teambased) {
      ref_1412d(var_0, scripts\cp_mp\vehicles\vehicle_occupancy::ref_141d7(var_0));
    } else {
      ref_1412c(var_0, scripts\cp_mp\vehicles\vehicle_occupancy::ref_141d5(var_0));
    }

    ref_14131(var_0, 1);
    return;
  }
}

function ref_14123(var_0) {
  var_1 = ref_14122();
  var_1.instances[var_0 getentitynumber()] = undefined;

  if(var_1.ref_142ce) {
    var_0 vehicleshowonminimap(0);
    return;
  }
}

function ref_1412d(var_0, var_1) {
  if(!isDefined(var_1) || var_1 == "neutral") {
    var_1 = "none";
  }

  var_0 setvehicleteam(var_1);
}

function ref_1412c(var_0, var_1) {
  var_0 setentityowner(undefined);
}

function ref_14125() {
  var_0 = spawnStruct();
  level.vehicle.hidescavengerhudfromplayer = var_0;
  var_0.instances = [];
  var_1 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "runLeanThreadMode")) {
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "runLeanThreadMode")]]();
  }

  var_0.ref_142ce = !var_1 || getdvarint("scr_vehicleCompassVisibilityIsScriptControlled", 0) > 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_compass", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_compass", "init")]]();
    return;
  }
}

function ref_14122() {
  return level.vehicle.hidescavengerhudfromplayer;
}

function ref_14121(var_0, var_1, var_2) {
  var_3 = ref_14122();
  var_4 = isDefined(var_3.instances[var_0 getentitynumber()]) && var_3.instances[var_0 getentitynumber()] == var_0;

  if(!var_4) {
    return;
  }

  if(level.teambased) {
    ref_1412d(var_0, var_2);
  } else {
    ref_1412c(var_0, var_2);
  }

  ref_14131(var_0);
}

function ref_14129(var_0) {
  if(!level.teambased) {
    return;
  }

  ref_14130(var_0);
}

function ref_1412a() {
  ref_14130(self);
}