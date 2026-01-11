/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 7.gsc
***************************************/

codecallback_startgametype() {
  if(getdvar("r_reflectionProbeGenerate") == "1") {
    level waittill("eternity");
  }

  if(!isDefined(level.gametypestarted) || !level.gametypestarted) {
    [[level.callbackstartgametype]]();
    level.gametypestarted = 1;
  }
}

codecallback_playerconnect() {
  if(getdvar("r_reflectionProbeGenerate") == "1") {
    level waittill("eternity");
  }

  self endon("disconnect");
  [
    [level.callbackplayerconnect]
  ]();
}

codecallback_playerdisconnect(var_00) {
  self notify("disconnect");
  [
    [level.callbackplayerdisconnect]
  ](var_00);
}

codecallback_playerdamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    var_05 = [[level.weaponmapfunc]](var_05, var_00);
  }

  [
    [level.callbackplayerdamage]
  ](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11);
}

func_00B4(var_00, var_01, var_02, var_03) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    var_00 = [[level.weaponmapfunc]](var_00);
  }

  if(isDefined(level.weaponmapfunc)) {
    var_02 = [[level.weaponmapfunc]](var_02);
  }
}

func_00B5(var_00, var_01) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    var_00 = [[level.weaponmapfunc]](var_00);
  }
}

func_00B6(var_00, var_01, var_02, var_03) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    var_00 = [[level.weaponmapfunc]](var_00);
  }

  if(isDefined(level.weaponmapfunc)) {
    var_02 = [[level.weaponmapfunc]](var_02);
  }

  if(isDefined(level.callbackfinishweaponchange)) {
    [[level.callbackfinishweaponchange]](var_02, var_00, var_03, var_01);
  }
}

codecallback_playerimpaled(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    var_01 = [[level.weaponmapfunc]](var_01);
  }

  [
    [level.callbackplayerimpaled]
  ](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07);
}

codecallback_playerkilled(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    var_05 = [[level.weaponmapfunc]](var_05, var_00);
  }

  [
    [level.callbackplayerkilled]
  ](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
}

codecallback_vehicledamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  if(isDefined(level.weaponmapfunc)) {
    var_05 = [[level.weaponmapfunc]](var_05, var_00);
  }

  if(isDefined(self.nullownerdamagefunc)) {
    var_12 = [[self.nullownerdamagefunc]](var_01);

    if(isDefined(var_12) && var_12) {
      return;
    }
  }

  if(isDefined(self.damagecallback)) {
    self[[self.damagecallback]](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11);
  }
  else {
    self vehicle_finishdamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11);
  }
}

codecallback_playerlaststand(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    var_04 = [[level.weaponmapfunc]](var_04, var_00);
  }

  [
    [level.callbackplayerlaststand]
  ](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08);
}

codecallback_playermigrated() {
  self endon("disconnect");
  [
    [level.callbackplayermigrated]
  ]();
}

codecallback_hostmigration() {
  [
    [level.callbackhostmigration]
  ]();
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
  level.idflags_no_team_protection = 256;
  level.idflags_no_protection = 512;
  level.idflags_passthru = 1024;
  level.idflags_ricochet = 2048;
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
  setdvar("g_gametype", "dm");
  exitlevel(0);
}

callbackvoid() {}