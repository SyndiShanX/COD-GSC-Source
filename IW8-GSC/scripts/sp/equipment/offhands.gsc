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

function registeroffhandfirefunc(var0, var1) {
  level.offhands.firefuncs[var0] = var1;
}

function offhandisprecached(var0) {
  if(scripts\engine\utility::array_contains(level.offhands.precached, var0)) {
    return 1;
  }

  return 0;
}

function offhandprecachefuncs() {
  var0 = [];
  GscBinSkip0(0x2e, "frag", &scripts\sp\equipment\frag::precache);
}

function offhandfiremanager() {
  self.offhands = spawnStruct();
  self.offhands.lastusedoffhandweapon = undefined;
  self.offhands.lastusedoffhandtime = 0;

  for(;;) {
    self waittill("grenade_fire", var0, var1);

    if(isDefined(level.offhands.firefuncs[var1.basename])) {
      GscBinSkip1(0x74, level.offhands.firefuncs[var1.basename], var0);
    }

    self.offhands.lastusedoffhandweapon = var1;
    self.offhands.lastusedoffhandtime = gettime();
  }
}

function playeroffhandthread(var0) {
  level.player endon("death");
  level.player childthread[[var0]]();
}

function remove_blackboard_isburning(var0) {
  waitframe();

  if(!isDefined(var0)) {
    return;
  }

  var0._blackboard.isburning = undefined;
}

function getweaponoffhandclass(var0) {
  if(isstring(var0)) {
    var1 = var0;
  } else {
    var1 = var1.basename;
  }

  return weaponoffhandclass(var1);
}

function getweaponoffhandtype(var0) {
  var1 = "primaryoffhand";
  var2 = "secondaryoffhand";
  var3 = "none";

  if(isstring(var0)) {
    var4 = var0;
  } else {
    var4 = var1.basename;
  }

  switch (var4) {
    case "c4_no_detonator":
    case "pipebomb":
    case "throwingknife":
    case "c4_sp":
    case "semtex":
    case "frag_farah":
    case "frag":
    case "molotov":
      return var2;
    case "signal":
    case "teargas":
    case "smoke_tall":
    case "smoke":
    case "noisemaker":
    case "flash":
      return var3;
    case "none":
      return var4;
  }
}