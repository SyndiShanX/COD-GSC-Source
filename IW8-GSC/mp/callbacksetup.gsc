/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\callbacksetup.gsc
***********************************************/

codecallback_startgametype() {
  if(getDvar("_encstr_8F7A0BD1E5E15304B8CF7989FF") == "_encstr_A34C02BB")
    level waittill("_encstr_9140093575E183DD9398A3");

  if(!isDefined(level.gametypestarted) || !level.gametypestarted) {
    [[level.callbackstartgametype]]();
    level.gametypestarted = 1;
  }
}

codecallback_playeractive() {
  if(getDvar("_encstr_8F7A0BD1E5E15304B8CF7989FF") == "_encstr_A34C02BB")
    level waittill("_encstr_9140093575E183DD9398A3");

  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.frontend4))
    [[level.frontend4]]();
}

codecallback_playerconnect() {
  if(getDvar("_encstr_8F7A0BD1E5E15304B8CF7989FF") == "_encstr_A34C02BB")
    level waittill("_encstr_9140093575E183DD9398A3");

  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  [[level.callbackplayerconnect]]();
}

codecallback_playerdisconnect(var_0) {
  self notify("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.unicornpoints = 1;
  [[level.callbackplayerdisconnect]](var_0);
}

codecallback_playerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.weaponmapfunc))
    var_5 = [[level.weaponmapfunc]](var_5, var_0);

  [[level.callbackplayerdamage]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
}

codecallback_playerfinishweaponchange(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.weaponmapfunc)) {
    [[level.weaponmapfunc]](var_0);
    [[level.weaponmapfunc]](var_1);
  }

  if(isDefined(level.callbackfinishweaponchange))
    [[level.callbackfinishweaponchange]](var_1, var_0, var_1.isalternate, var_0.isalternate);
}

codecallback_playerimpaled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.weaponmapfunc))
    [[level.weaponmapfunc]](var_1);

  [[level.callbackplayerimpaled]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

codecallback_playerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.weaponmapfunc))
    [[level.weaponmapfunc]](var_5, var_0);

  [[level.callbackplayerkilled]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

codecallback_vehicledamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(isDefined(self.nullownerdamagefunc)) {
    var_13 = [[self.nullownerdamagefunc]](var_1);

    if(isDefined(var_13) && var_13)
      return;
  }

  if(isDefined(level.weaponmapfunc))
    var_5 = [[level.weaponmapfunc]](var_5, var_0);

  if(isDefined(self.damagecallback))
    self[[self.damagecallback]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
  else if(isDefined(level.vehicles) && isDefined(level.vehicles.damagecallback) && isDefined(self.vehiclename))
    self[[level.vehicles.damagecallback]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
  else
    self vehicle_finishdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

codecallback_playerlaststand(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.weaponmapfunc))
    [[level.weaponmapfunc]](var_4, var_0);

  return [[level.callbackplayerlaststand]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

codecallback_spawnpointsprecalc(var_0) {
  if(isDefined(level.callbackspawnpointprecalc))
    [[level.callbackspawnpointprecalc]](var_0);
}

codecallback_spawnpointscore(var_0, var_1, var_2) {
  if(isDefined(level.callbackspawnpointscore))
    return var_0[[level.callbackspawnpointscore]](var_1, var_2);

  return 0.0;
}

codecallback_spawnpointcritscore(var_0, var_1, var_2) {
  var_3 = "_encstr_BA7F0830B3A7859B60B0";

  if(isDefined(level.callbackspawnpointcritscore))
    var_3 = var_0[[level.callbackspawnpointcritscore]](var_1, var_2);

  if(var_3 == "_encstr_BA7F0830B3A7859B60B0")
    return 100.0;
  else if(var_3 == "_encstr_AC8F0AE74163F85AAA380AD8")
    return 50.0;

  return 0.0;
}

codecallback_playermigrated() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  [[level.callbackplayermigrated]]();
}

codecallback_hostmigration() {
  [[level.callbackhostmigration]]();
}

setupdamageflags() {
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

abortlevel() {
  level.callbackstartgametype = ::callbackvoid;
  level.frontend4 = ::callbackvoid;
  level.callbackplayerconnect = ::callbackvoid;
  level.callbackplayerdisconnect = ::callbackvoid;
  level.callbackplayerdamage = ::callbackvoid;
  level.callbackplayerimpaled = ::callbackvoid;
  level.callbackplayerkilled = ::callbackvoid;
  level.callbackplayerlaststand = ::callbackvoid;
  level.callbackplayermigrated = ::callbackvoid;
  level.callbackhostmigration = ::callbackvoid;
  setDvar("_encstr_B60D0B9C840C31FA415FD7EFCB", "_encstr_9707038CB6");
  exitlevel(0);
}

callbackvoid() {}