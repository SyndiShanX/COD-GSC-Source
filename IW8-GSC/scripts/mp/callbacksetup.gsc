/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\callbacksetup.gsc
***********************************************/

function codecallback_startgametype() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    level waittill("eternity");
  }

  if(!isDefined(level.gametypestarted) || !level.gametypestarted) {
    [[level.callbackstartgametype]]();
    level.gametypestarted = 1;
    return;
  }
}

function codecallback_playeractive() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    level waittill("eternity");
  }

  self endon("disconnect");

  if(isDefined(level.frontend4)) {
    [[level.frontend4]]();
    return;
  }
}

function codecallback_playerconnect() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    level waittill("eternity");
  }

  self endon("disconnect");
  [[level.callbackplayerconnect]]();
}

function codecallback_playerdisconnect(var_0) {
  self notify("disconnect");
  self notify("death_or_disconnect");
  self.unicornpoints = 1;
  [[level.callbackplayerdisconnect]](var_0);
}

function codecallback_playerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    var_5 = [[level.weaponmapfunc]](var_5, var_0);
  }

  [[level.callbackplayerdamage]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
}

function codecallback_playerfinishweaponchange(var_0, var_1) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    [[level.weaponmapfunc]](var_0);
    [[level.weaponmapfunc]](var_1);
  }

  if(isDefined(level.callbackfinishweaponchange)) {
    [[level.callbackfinishweaponchange]](var_1, var_0, var_1.isalternate, var_0.isalternate);
    return;
  }
}

function codecallback_playerimpaled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    [[level.weaponmapfunc]](var_1);
  }

  [[level.callbackplayerimpaled]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

function codecallback_playerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    [[level.weaponmapfunc]](var_5, var_0);
  }

  [[level.callbackplayerkilled]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

function codecallback_vehicledamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(isDefined(self.nullownerdamagefunc)) {
    var_13 = [[self.nullownerdamagefunc]](var_1);

    if(isDefined(var_13) && var_13) {
      return;
    }
  }

  if(isDefined(level.weaponmapfunc)) {
    var_5 = [[level.weaponmapfunc]](var_5, var_0);
  }

  if(isDefined(self.damagecallback)) {
    self[[self.damagecallback]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
    return;
  }

  if(isDefined(level.vehicles) && isDefined(level.vehicles.damagecallback) && isDefined(self.vehiclename)) {
    self[[level.vehicles.damagecallback]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
    return;
  }

  self vehicle_finishdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

function codecallback_playerlaststand(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    [[level.weaponmapfunc]](var_4, var_0);
  }

  return [[level.callbackplayerlaststand]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

function codecallback_spawnpointsprecalc(var_0) {
  if(isDefined(level.callbackspawnpointprecalc)) {
    [[level.callbackspawnpointprecalc]](var_0);
    return;
  }
}

function codecallback_spawnpointscore(var_0, var_1, var_2) {
  if(isDefined(level.callbackspawnpointscore)) {
    return var_0[[level.callbackspawnpointscore]](var_1, var_2);
  }

  return 0;
}

function codecallback_spawnpointcritscore(var_0, var_1, var_2) {
  var_3 = "primary";

  if(isDefined(level.callbackspawnpointcritscore)) {
    var_3 = var_0[[level.callbackspawnpointcritscore]](var_1, var_2);
  }

  if(var_3 == "primary") {
    return 100;
  } else if(var_3 == "secondary") {
    return 50;
  }

  return 0;
}

function codecallback_playermigrated() {
  self endon("disconnect");
  [[level.callbackplayermigrated]]();
}

function codecallback_hostmigration() {
  [[level.callbackhostmigration]]();
}

function setupdamageflags() {
  level.idflags_radius = 1;
  level.idflags_no_armor = 2;
  level.idflags_no_knockback = 4;
  level.idflags_penetration = 8;
  level.idflags_stun = 16;
  level.idflags_shield_explosive_impact = 32;
  level.idflags_shield_explosive_impact_huge = 64;
  level.idflags_shield_explosive_splash = 128;
  level.idflags_ricochet = 256;
  level.ss_circletick = 512;
  level.sr_next_ammo_restock_time = 1024;
  level.sstablet_init = 2048;
  level.ss_removequestinstance = 4096;
  level.ss_playerdisconnect = 8192;
  level.ss_respawn = 16384;
  level.ss_ontimerexpired = 32768;
  level.ss_entergulag = 65536;
  level.idflags_no_team_protection = 131072;
  level.idflags_no_protection = 262144;
  level.idflags_passthru = 524288;
}

function abortlevel() {
  level.callbackstartgametype = &callbackvoid;
  level.frontend4 = &callbackvoid;
  level.callbackplayerconnect = &callbackvoid;
  level.callbackplayerdisconnect = &callbackvoid;
  level.callbackplayerdamage = &callbackvoid;
  level.callbackplayerimpaled = &callbackvoid;
  level.callbackplayerkilled = &callbackvoid;
  level.callbackplayerlaststand = &callbackvoid;
  level.callbackplayermigrated = &callbackvoid;
  level.callbackhostmigration = &callbackvoid;
  setDvar("g_gametype", "dm");
  exitlevel(0);
}

function callbackvoid() {}