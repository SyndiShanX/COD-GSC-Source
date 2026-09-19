/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\477.gsc
**************************************/

codecallback_startgametype() {
  if(getDvar("233") == "1")
    level waittill("eternity");

  if(!isDefined(level.gametypestarted) || !level.gametypestarted) {
    [[level.callbackstartgametype]]();
    level.gametypestarted = 1;
  }
}

codecallback_playerconnect() {
  if(getDvar("233") == "1")
    level waittill("eternity");

  self endon("disconnect");
  [[level.callbackplayerconnect]]();
}

codecallback_playerdisconnect(var_0) {
  self notify("disconnect");
  [[level.callbackplayerdisconnect]](var_0);
}

codecallback_playerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self endon("disconnect");
  [[level.callbackplayerdamage]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

codecallback_playerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("disconnect");
  [[level.callbackplayerkilled]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

_id_0042(var_0, var_1) {
  self endon("disconnect");
  [[level._id_1E72]](var_0, var_1);
}

codecallback_playergrenadesuicide(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("disconnect");
  [[level.callbackplayergrenadesuicide]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

codecallback_entityoutofworld() {
  self endon("disconnect");
  [[level.callbackentityoutofworld]]();
}

codecallback_bullethitentity(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("disconnect");

  if(isDefined(self.bullethitcallback))
    [[self.bullethitcallback]](var_0, var_1, var_2, var_3, var_4, var_5);
}

codecallback_vehicledamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(self.damagecallback))
    self[[self.damagecallback]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  else
    self vehicle_finishdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

codecallback_entitydamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(self.damagecallback))
    self[[self.damagecallback]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  else
    self finishentitydamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

codecallback_codeendgame() {
  self endon("disconnect");
  [[level.callbackcodeendgame]]();
}

_id_0048(var_0, var_1, var_2) {
  _id_04E6::_id_92E1(var_0, var_1, var_2);
}

codecallback_playerlaststand(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("disconnect");
  [[level.callbackplayerlaststand]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

codecallback_playermigrated() {
  self endon("disconnect");
  [[level.callbackplayermigrated]]();
}

codecallback_hostmigration() {
  [[level.callbackhostmigration]]();
}

_id_2491(var_0, var_1) {
  if(isbot(var_0) || istestclient(var_0) || isDefined(var_0.team) && var_0.team == "spectator" || var_0.sessionstate == "spectator") {
    return;
  }
  if(!isDefined(level._id_5A61)) {
    return;
  }
  if(isDefined(level._id_5A61[var_1]) && tablelookup("mp/killstreakTable.csv", 1, var_1, 0) != "" || issubstr(var_1, "turrethead")) {
    if(getdvarint("scorestreak_enabled_" + var_1) == 0) {
      _iprintlnbold("Scorestreak " + var_1 + " was disabled.Re-enabling...");
      setDvar("scorestreak_enabled_" + var_1, 1);
    }

    var_2 = var_0 _id_051E::_id_46B4(var_1);
    var_3 = var_0 _id_051E::_id_45A5(var_1);
    var_0 thread maps\mp\gametypes\_hud_message::killstreaksplashnotify(var_1, var_2, undefined, var_3);
    var_0 _id_051E::_id_478D(var_1);
  }
}

_id_47B6(var_0) {
  waitframe();
  _id_0533::_id_3662(var_0);
}

_id_95F2(var_0) {
  waitframe();
  _id_0533::_id_2F9E(var_0);
}

_id_0045(var_0, var_1) {
  if(istestclient(var_0) || var_0.team == "spectator" || var_0.sessionstate == "spectator") {
    return;
  }
  var_0 thread _id_47B6(var_1);
}

_id_0053(var_0, var_1) {
  if(istestclient(var_0) || var_0.team == "spectator" || var_0.sessionstate == "spectator") {
    return;
  }
  var_0 thread _id_95F2(var_1);
}

_id_2492(var_0, var_1) {}

_id_2499(var_0) {}

_id_2494(var_0, var_1) {}

_id_249D(var_0, var_1) {}

_id_249E(var_0, var_1) {}

_id_249A(var_0, var_1) {}

_id_2496(var_0) {}

_id_2490(var_0, var_1) {}

_id_249B(var_0, var_1) {}

_id_249C(var_0, var_1) {}

_id_248F(var_0) {}

_id_2495(var_0) {}

_id_2493(var_0) {}

_id_2498(var_0) {}

_id_24A0(var_0) {}

_id_2497(var_0) {}

_id_249F(var_0, var_1) {}

codecallback_partymembers(var_0) {
  if(isDefined(level.partymembers_cb))
    [[level.partymembers_cb]](var_0);
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
  level._id_5038 = 2048;
  level._id_5039 = level.idflags_penetration | level.idflags_stun;
}

setupcallbacks() {
  setdefaultcallbacks();
  setupdamageflags();
}

setdefaultcallbacks() {
  level.callbackstartgametype = maps\mp\gametypes\_gamelogic::callback_startgametype;
  level.callbackplayerconnect = maps\mp\gametypes\_playerlogic::callback_playerconnect;
  level.callbackplayerdisconnect = maps\mp\gametypes\_playerlogic::callback_playerdisconnect;
  level.callbackplayerdamage = maps\mp\gametypes\_damage::callback_playerdamage;
  level.callbackplayerkilled = maps\mp\gametypes\_damage::callback_playerkilled;
  level._id_1E72 = maps\mp\gametypes\_damage::callback_entityoutofworld;
  level.callbackentityoutofworld = maps\mp\gametypes\_damage::_id_1E64;
  level.callbackplayergrenadesuicide = maps\mp\gametypes\_damage::callback_playergrenadesuicide;
  level.callbackcodeendgame = maps\mp\gametypes\_gamelogic::callback_codeendgame;
  level.callbackplayerlaststand = maps\mp\gametypes\_damage::callback_playerlaststand;
  level.callbackplayermigrated = maps\mp\gametypes\_playerlogic::callback_playermigrated;
  level.callbackhostmigration = maps\mp\gametypes\_hostmigration::callback_hostmigration;
}

abortlevel() {
  level.callbackstartgametype = ::callbackvoid;
  level.callbackplayerconnect = ::callbackvoid;
  level.callbackplayerdisconnect = ::callbackvoid;
  level.callbackplayerdamage = ::callbackvoid;
  level.callbackplayerkilled = ::callbackvoid;
  level.callbackentityoutofworld = ::callbackvoid;
  level.callbackplayergrenadesuicide = ::callbackvoid;
  level.callbackcodeendgame = ::callbackvoid;
  level.callbackplayerlaststand = ::callbackvoid;
  level.callbackplayermigrated = ::callbackvoid;
  level.callbackhostmigration = ::callbackvoid;
  setDvar("1924", "dm");
  exitlevel(0);
}

callbackvoid() {}