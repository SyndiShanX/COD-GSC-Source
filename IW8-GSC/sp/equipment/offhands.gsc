/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\equipment\offhands.gsc
***********************************************/

init() {
  if(isDefined(level.offhands)) {
    return;
  }
  level.offhands = spawnStruct();
  level.offhands.firefuncs = [];
  level.offhands.precached = [];
}

registeroffhandfirefunc(var_0, var_1) {
  level.offhands.firefuncs[var_0] = var_1;
}

offhandisprecached(var_0) {
  if(scripts\engine\utility::array_contains(level.offhands.precached, var_0))
    return 1;
  else
    return 0;
}

offhandprecachefuncs() {
  var_0 = [];
  var_0["frag"] = scripts\sp\equipment\frag::precache;
  var_0["frag_farah"] = scripts\sp\equipment\frag::precache;
  var_0["flash"] = scripts\sp\equipment\flash::precache;
  var_0["molotov"] = scripts\sp\equipment\molotov::precache;
  var_0["ied"] = scripts\sp\equipment\ied::precache;
  var_0["noisemaker"] = scripts\sp\equipment\noisemaker::precache;
  var_0["semtex"] = scripts\sp\equipment\semtex::precache;
  var_0["c4_sp"] = scripts\sp\equipment\c4::precache;
  var_0["throwingknife"] = scripts\sp\equipment\throwingknife::precache;
  var_0["smoke"] = scripts\sp\equipment\smoke::precache;
  var_0["smoke_tall"] = scripts\sp\equipment\smoke::precache;
  var_0["teargas"] = scripts\sp\equipment\teargas::precache;
  var_0["signal"] = scripts\sp\equipment\signal::precache;
  var_0["pipebomb"] = scripts\sp\equipment\pipebomb::precache;
  return var_0;
}

offhandfiremanager() {
  self.offhands = spawnStruct();
  self.offhands.lastusedoffhandweapon = undefined;
  self.offhands.lastusedoffhandtime = 0;

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(isDefined(level.offhands.firefuncs[var_1.basename]))
      thread[[level.offhands.firefuncs[var_1.basename]]](var_0);

    self.offhands.lastusedoffhandweapon = var_1;
    self.offhands.lastusedoffhandtime = gettime();
  }
}

playeroffhandthread(var_0) {
  level.player endon("death");
  level.player childthread[[var_0]]();
}

remove_blackboard_isburning(var_0) {
  waitframe();

  if(!isDefined(var_0)) {
    return;
  }
  var_0._blackboard.isburning = undefined;
}

getweaponoffhandclass(var_0) {
  if(isstring(var_0))
    var_1 = var_0;
  else
    var_1 = var_0.basename;

  return weaponoffhandclass(var_1);
}

getweaponoffhandtype(var_0) {
  var_1 = "primaryoffhand";
  var_2 = "secondaryoffhand";
  var_3 = "none";

  if(isstring(var_0))
    var_4 = var_0;
  else
    var_4 = var_0.basename;

  switch (var_4) {
    case "c4_no_detonator":
    case "pipebomb":
    case "throwingknife":
    case "c4_sp":
    case "semtex":
    case "frag_farah":
    case "frag":
    case "molotov":
      return var_1;
    case "signal":
    case "teargas":
    case "smoke_tall":
    case "smoke":
    case "noisemaker":
    case "flash":
      return var_2;
    case "none":
      return var_3;
  }
}