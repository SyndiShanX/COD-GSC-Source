/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\offhands.gsc
***********************************************/

function init() {
  if(isDefined(level.offhands)) {
    return;
  }

  level.offhands = spawnStruct();
  level.offhands.firefuncs = [];
  level.offhands.precached = [];
}

function registeroffhandfirefunc(var_0, var_1) {
  level.offhands.firefuncs[var_0] = var_1;
}

function offhandisprecached(var_0) {
  if(scripts\engine\utility::array_contains(level.offhands.precached, var_0)) {
    return 1;
  }

  return 0;
}

function offhandprecachefuncs() {
  var_0 = [];
  GscBinSkip0(0x2e, "frag", &scripts\sp\equipment\frag::precache);
}

function offhandfiremanager() {
  self.offhands = spawnStruct();
  self.offhands.lastusedoffhandweapon = undefined;
  self.offhands.lastusedoffhandtime = 0;

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(isDefined(level.offhands.firefuncs[var_1.basename])) {
      GscBinSkip1(0x74, level.offhands.firefuncs[var_1.basename], var_0);
    }

    self.offhands.lastusedoffhandweapon = var_1;
    self.offhands.lastusedoffhandtime = gettime();
  }
}

function playeroffhandthread(var_0) {
  level.player endon("death");
  level.player childthread[[var_0]]();
}

function remove_blackboard_isburning(var_0) {
  waitframe();

  if(!isDefined(var_0)) {
    return;
  }

  var_0._blackboard.isburning = undefined;
}

function getweaponoffhandclass(var_0) {
  if(isstring(var_0)) {
    var_1 = var_0;
  } else {
    var_1 = var_1.basename;
  }

  return weaponoffhandclass(var_1);
}

function getweaponoffhandtype(var_0) {
  var_1 = "primaryoffhand";
  var_2 = "secondaryoffhand";
  var_3 = "none";

  if(isstring(var_0)) {
    var_4 = var_0;
  } else {
    var_4 = var_1.basename;
  }

  switch (var_4) {
    case "c4_no_detonator":
    case "pipebomb":
    case "throwingknife":
    case "c4_sp":
    case "semtex":
    case "frag_farah":
    case "frag":
    case "molotov":
      return var_2;
    case "signal":
    case "teargas":
    case "smoke_tall":
    case "smoke":
    case "noisemaker":
    case "flash":
      return var_3;
    case "none":
      return var_4;
  }
}