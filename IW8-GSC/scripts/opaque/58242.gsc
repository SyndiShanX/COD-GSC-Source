/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58242.gsc
***********************************************/

function ref_1412b(var0) {
  var1 = ref_14122();
  var1.instances[var0 getentitynumber()] = var0;
  ref_1412f(var0);
}

function ref_14120(var0) {
  var1 = ref_14122();
  var1.instances[var0 getentitynumber()] = undefined;
}

function ref_14126(var0) {
  var1 = ref_14122();
  return isDefined(var1.instances[var0 getentitynumber()]) && var1.instances[var0 getentitynumber()] == var0;
}

function ref_14132(var0, var1, var2) {
  var3 = ref_14122();

  if(!var3.ref_142ce) {
    return;
  }

  if(!ref_14126(var0)) {
    if(istrue(var2)) {}

    return;
  }

  if(!ref_1412e(var0, var1)) {
    var0 vehicleshowonminimapforclient(var1, 0);
    return;
  }

  var0 vehicleshowonminimapforclient(var1, 1);
}

function ref_14131(var0, var1) {
  var2 = ref_14122();

  if(!var2.ref_142ce) {
    return;
  }

  if(!ref_14126(var0)) {
    if(istrue(var1)) {}

    return;
  }

  foreach(var4 in level.players) {
    ref_14132(var0, var4);
  }
}

function ref_14130(var0) {
  var1 = ref_14122();

  if(!var1.ref_142ce) {
    return;
  }

  foreach(var3 in var1.instances) {
    ref_14132(var3, var0);
  }
}

function ref_1412e(var0, var1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_compass", "shouldBeVisibleToPlayer")) {
    var2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_compass", "shouldBeVisibleToPlayer")]](var0, var1);

    if(isDefined(var2)) {
      return var2;
    }
  }

  if(!scripts\cp_mp\vehicles\vehicle::ref_141b9(var0, var1)) {
    return 0;
  }

  return 1;
}

function ref_1412f(var0) {
  var1 = ref_14122();

  if(var1.ref_142ce) {
    var0 vehicleshowonminimap(1);
  }

  if(isDefined(var1.instances[var0 getentitynumber()])) {
    if(level.teambased) {
      ref_1412d(var0, scripts\cp_mp\vehicles\vehicle_occupancy::ref_141d7(var0));
    } else {
      ref_1412c(var0, scripts\cp_mp\vehicles\vehicle_occupancy::ref_141d5(var0));
    }

    ref_14131(var0, 1);
    return;
  }
}

function ref_14123(var0) {
  var1 = ref_14122();
  var1.instances[var0 getentitynumber()] = undefined;

  if(var1.ref_142ce) {
    var0 vehicleshowonminimap(0);
    return;
  }
}

function ref_1412d(var0, var1) {
  if(!isDefined(var1) || var1 == "neutral") {
    var1 = "none";
  }

  var0 setvehicleteam(var1);
}

function ref_1412c(var0, var1) {
  var0 setentityowner(undefined);
}

function ref_14125() {
  var0 = spawnStruct();
  level.vehicle.hidescavengerhudfromplayer = var0;
  var0.instances = [];
  var1 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "runLeanThreadMode")) {
    var1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "runLeanThreadMode")]]();
  }

  var0.ref_142ce = !var1 || getdvarint("scr_vehicleCompassVisibilityIsScriptControlled", 0) > 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_compass", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_compass", "init")]]();
    return;
  }
}

function ref_14122() {
  return level.vehicle.hidescavengerhudfromplayer;
}

function ref_14121(var0, var1, var2) {
  var3 = ref_14122();
  var4 = isDefined(var3.instances[var0 getentitynumber()]) && var3.instances[var0 getentitynumber()] == var0;

  if(!var4) {
    return;
  }

  if(level.teambased) {
    ref_1412d(var0, var2);
  } else {
    ref_1412c(var0, var2);
  }

  ref_14131(var0);
}

function ref_14129(var0) {
  if(!level.teambased) {
    return;
  }

  ref_14130(var0);
}

function ref_1412a() {
  ref_14130(self);
}