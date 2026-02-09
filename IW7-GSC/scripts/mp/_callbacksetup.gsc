/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\_callbacksetup.gsc
*********************************************/

codecallback_startgametype() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    level waittill("eternity");
  }

  if(!isDefined(level.gametypestarted) || !level.gametypestarted) {
    [[level.callbackstartgametype]]();
    level.gametypestarted = 1;
  }
}

codecallback_playerconnect() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    level waittill("eternity");
  }

  self endon("disconnect");
  [[level.callbackplayerconnect]]();
}

codecallback_playerdisconnect(var_0) {
  self notify("disconnect");
  [[level.callbackplayerdisconnect]](var_0);
}

codecallback_playerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  self endon("disconnect");
  if(isDefined(level.weaponmapfunc)) {
    var_5 = [[level.weaponmapfunc]](var_5, var_0);
  }

  [[level.callbackplayerdamage]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

func_00B4(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  if(isDefined(level.weaponmapfunc)) {
    var_0 = [[level.weaponmapfunc]](var_0);
  }

  if(isDefined(level.weaponmapfunc)) {
    var_2 = [[level.weaponmapfunc]](var_2);
  }
}

func_00B5(var_0, var_1) {
  self endon("disconnect");
  if(isDefined(level.weaponmapfunc)) {
    var_0 = [[level.weaponmapfunc]](var_0);
  }
}

func_00B6(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  if(isDefined(level.weaponmapfunc)) {
    var_0 = [[level.weaponmapfunc]](var_0);
  }

  if(isDefined(level.weaponmapfunc)) {
    var_2 = [[level.weaponmapfunc]](var_2);
  }

  if(isDefined(level.callbackfinishweaponchange)) {
    [[level.callbackfinishweaponchange]](var_2, var_0, var_3, var_1);
  }
}

codecallback_playerimpaled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("disconnect");
  if(isDefined(level.weaponmapfunc)) {
    var_1 = [[level.weaponmapfunc]](var_1);
  }

  [[level.callbackplayerimpaled]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

codecallback_playerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self endon("disconnect");
  if(isDefined(level.weaponmapfunc)) {
    var_5 = [[level.weaponmapfunc]](var_5, var_0);
  }

  [[level.callbackplayerkilled]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

codecallback_vehicledamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(level.weaponmapfunc)) {
    var_5 = [[level.weaponmapfunc]](var_5, var_0);
  }

  if(isDefined(self.nullownerdamagefunc)) {
    var_12 = [[self.nullownerdamagefunc]](var_1);
    if(isDefined(var_12) && var_12) {
      return;
    }
  }

  if(isDefined(self.damagecallback)) {
    self[[self.damagecallback]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    return;
  }

  self vehicle_finishdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

codecallback_playerlaststand(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("disconnect");
  if(isDefined(level.weaponmapfunc)) {
    var_4 = [[level.weaponmapfunc]](var_4, var_0);
  }

  [[level.callbackplayerlaststand]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

codecallback_playermigrated() {
  self endon("disconnect");
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
  level.idflags_no_team_protection = 512;
  level.idflags_no_protection = 1024;
  level.idflags_passthru = 2048;
}

abortlevel() {
  level.callbackstartgametype = ::callbackvoid;
  level.callbackplayerconnect = ::callbackvoid;
  level.callbackplayerdisconnect = ::callbackvoid;
  level.callbackplayerdamage = ::callbackvoid;
  level.callbackplayerimpaled = ::callbackvoid;
  level.callbackplayerkilled = ::callbackvoid;
  level.callbackplayerlaststand = ::callbackvoid;
  level.callbackplayermigrated = ::callbackvoid;
  level.callbackhostmigration = ::callbackvoid;
  setDvar("g_gametype", "dm");
  exitlevel(0);
}

callbackvoid() {}