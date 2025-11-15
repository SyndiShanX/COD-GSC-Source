/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\_callbacksetup.gsc
*****************************************/

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

codecallback_playerdisconnect(param_00) {
  self notify("disconnect");
  [
    [level.callbackplayerdisconnect]
  ](param_00);
}

codecallback_playerdamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  self endon("disconnect");
  if(isDefined(level.weaponmapfunc)) {
    param_05 = [[level.weaponmapfunc]](param_05, param_00);
  }

  [
    [level.callbackplayerdamage]
  ](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
}

func_00B4(param_00, param_01, param_02, param_03) {
  self endon("disconnect");
  if(isDefined(level.weaponmapfunc)) {
    param_00 = [[level.weaponmapfunc]](param_00);
  }

  if(isDefined(level.weaponmapfunc)) {
    param_02 = [[level.weaponmapfunc]](param_02);
  }
}

func_00B5(param_00, param_01) {
  self endon("disconnect");
  if(isDefined(level.weaponmapfunc)) {
    param_00 = [[level.weaponmapfunc]](param_00);
  }
}

func_00B6(param_00, param_01, param_02, param_03) {
  self endon("disconnect");
  if(isDefined(level.weaponmapfunc)) {
    param_00 = [[level.weaponmapfunc]](param_00);
  }

  if(isDefined(level.weaponmapfunc)) {
    param_02 = [[level.weaponmapfunc]](param_02);
  }

  if(isDefined(level.callbackfinishweaponchange)) {
    [[level.callbackfinishweaponchange]](param_02, param_00, param_03, param_01);
  }
}

codecallback_playerimpaled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self endon("disconnect");
  if(isDefined(level.weaponmapfunc)) {
    param_01 = [[level.weaponmapfunc]](param_01);
  }

  [
    [level.callbackplayerimpaled]
  ](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07);
}

codecallback_playerkilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  self endon("disconnect");
  if(isDefined(level.weaponmapfunc)) {
    param_05 = [[level.weaponmapfunc]](param_05, param_00);
  }

  [
    [level.callbackplayerkilled]
  ](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
}

codecallback_vehicledamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(isDefined(level.weaponmapfunc)) {
    param_05 = [[level.weaponmapfunc]](param_05, param_00);
  }

  if(isDefined(self.nullownerdamagefunc)) {
    var_0C = [[self.nullownerdamagefunc]](param_01);
    if(isDefined(var_0C) && var_0C) {
      return;
    }
  }

  if(isDefined(self.damagecallback)) {
    self[[self.damagecallback]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
    return;
  }

  self vehicle_finishdamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
}

codecallback_playerlaststand(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  self endon("disconnect");
  if(isDefined(level.weaponmapfunc)) {
    param_04 = [[level.weaponmapfunc]](param_04, param_00);
  }

  [
    [level.callbackplayerlaststand]
  ](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
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
  setdvar("g_gametype", "dm");
  exitlevel(0);
}

callbackvoid() {}