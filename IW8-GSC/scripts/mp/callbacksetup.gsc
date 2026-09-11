/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\callbacksetup.gsc
***********************************************/

function codecallback_startgametype() {
  if(getDvar("LLQQOPKTKM") == "1") {
    level waittill("eternity");
  }

  if(!isDefined(level.gametypestarted) || !level.gametypestarted) {
    [[level.callbackstartgametype]]();
    level.gametypestarted = 1;
    return;
  }
}

function codecallback_playeractive() {
  if(getDvar("LLQQOPKTKM") == "1") {
    level waittill("eternity");
  }

  self endon("disconnect");

  if(isDefined(level.frontend4)) {
    [[level.frontend4]]();
    return;
  }
}

function codecallback_playerconnect() {
  if(getDvar("LLQQOPKTKM") == "1") {
    level waittill("eternity");
  }

  self endon("disconnect");
  [[level.callbackplayerconnect]]();
}

function codecallback_playerdisconnect(var0) {
  self notify("disconnect");
  self notify("death_or_disconnect");
  self.unicornpoints = 1;
  [[level.callbackplayerdisconnect]](var0);
}

function codecallback_playerdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    var5 = [[level.weaponmapfunc]](var5, var0);
  }

  [[level.callbackplayerdamage]](var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
}

function codecallback_playerfinishweaponchange(var0, var1) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    [[level.weaponmapfunc]](var0);
    [[level.weaponmapfunc]](var1);
  }

  if(isDefined(level.callbackfinishweaponchange)) {
    [[level.callbackfinishweaponchange]](var1, var0, var1.isalternate, var0.isalternate);
    return;
  }
}

function codecallback_playerimpaled(var0, var1, var2, var3, var4, var5, var6, var7) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    [[level.weaponmapfunc]](var1);
  }

  [[level.callbackplayerimpaled]](var0, var1, var2, var3, var4, var5, var6, var7);
}

function codecallback_playerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    [[level.weaponmapfunc]](var5, var0);
  }

  [[level.callbackplayerkilled]](var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
}

function codecallback_vehicledamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
  if(isDefined(self.nullownerdamagefunc)) {
    var13 = [[self.nullownerdamagefunc]](var1);

    if(isDefined(var13) && var13) {
      return;
    }
  }

  if(isDefined(level.weaponmapfunc)) {
    var5 = [[level.weaponmapfunc]](var5, var0);
  }

  if(isDefined(self.damagecallback)) {
    self[[self.damagecallback]](var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12);
    return;
  }

  if(isDefined(level.vehicles) && isDefined(level.vehicles.damagecallback) && isDefined(self.vehiclename)) {
    self[[level.vehicles.damagecallback]](var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12);
    return;
  }

  self vehicle_finishdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11);
}

function codecallback_playerlaststand(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    [[level.weaponmapfunc]](var4, var0);
  }

  return [[level.callbackplayerlaststand]](var0, var1, var2, var3, var4, var5, var6, var7, var8);
}

function codecallback_spawnpointsprecalc(var0) {
  if(isDefined(level.callbackspawnpointprecalc)) {
    [[level.callbackspawnpointprecalc]](var0);
    return;
  }
}

function codecallback_spawnpointscore(var0, var1, var2) {
  if(isDefined(level.callbackspawnpointscore)) {
    return var0[[level.callbackspawnpointscore]](var1, var2);
  }

  return 0;
}

function codecallback_spawnpointcritscore(var0, var1, var2) {
  var3 = "primary";

  if(isDefined(level.callbackspawnpointcritscore)) {
    var3 = var0[[level.callbackspawnpointcritscore]](var1, var2);
  }

  if(var3 == "primary") {
    return 100;
  } else if(var3 == "secondary") {
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
  setDvar("NKTMKRMSKR", "dm");
  exitlevel(0);
}

function callbackvoid() {}