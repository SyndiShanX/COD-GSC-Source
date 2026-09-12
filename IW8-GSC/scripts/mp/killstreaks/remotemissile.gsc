/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\remotemissile.gsc
****************************************************/

function init() {
  level.missileremotelaunchvert = 14000;
  level.missileremotelaunchhorz = 7000;
  level.missileremotelaunchtargetdist = 1500;
  level.rockets = [];
  level.remotemissile_fx["explode"] = loadfx("vfx/core/expl/aerial_explosion");
}

function tryusepredatormissile(var_0, var_1) {
  scripts\mp\utility\player::setusingremote("remotemissile");
  var_2 = scripts\mp\killstreaks\killstreaks::initridekillstreak();

  if(var_2 != "success") {
    if(var_2 != "disconnect") {
      scripts\mp\utility\player::clearusingremote();
    }

    return false;
  }

  self setclientomnvar("ui_predator_missile", 1);
  thread _fire(level, var_0);
  return true;
}

function getbestspawnpoint(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_3.validplayers = [];
    var_3.spawnscore = 0;
  }

  foreach(var_6 in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(var_6)) {
      continue;
    }

    if(var_6.team == self.team) {
      continue;
    }

    if(var_6.team == "spectator") {
      continue;
    }

    var_7 = 999999999;
    var_8 = undefined;

    foreach(var_3 in var_0) {
      var_3.validplayers[var_3.validplayers.size] = var_6;
      var_10 = distance2d(var_3.targetent.origin, var_6.origin);

      if(var_10 <= var_7) {
        var_7 = var_10;
        var_8 = var_3;
      }
    }

    var_8.spawnscore += 2;
  }

  var_13 = var_0[0];

  foreach(var_3 in var_0) {
    foreach(var_6 in var_3.validplayers) {
      var_3.spawnscore += 1;

      if(scripts\engine\trace::_bullet_trace_passed(var_6.origin + (0, 0, 32), var_3.origin, 0, var_6)) {
        var_3.spawnscore += 3;
      }

      if(var_3.spawnscore > var_13.spawnscore) {
        var_13 = var_3;
        continue;
      }

      if(var_3.spawnscore == var_13.spawnscore) {
        if(scripts\engine\utility::cointoss()) {
          var_13 = var_3;
        }
      }
    }
  }

  return var_13;
}

function _fire(var_0, var_1) {
  var_2 = getEntArray("remoteMissileSpawn", "targetname");

  foreach(var_5, var_4 in var_2) {
    if(isDefined(var_4.target)) {
      var_4.targetent = getEnt(var_4.target, "targetname");
    }
  }

  if(var_2.size > 0) {
    var_6 = getbestspawnpoint(var_1, var_2);
  } else {
    var_6 = undefined;
  }

  jumpiffalse(isDefined(var_6)) LOC_000000b8;
  var_7 = var_6.origin;
  var_8 = var_6.targetent.origin;
  var_9 = vectorNormalize(var_7 - var_8);
  var_7 = var_9 * 14000 + var_8;
  var_10 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("remotemissile_projectile_mp"), var_7, var_8, var_2);
  goto LOC_00000117;
}

function handledamage() {
  self endon("death");
  self endon("deleted");
  self setCanDamage(1);

  for(;;) {
    self waittill("damage");
  }
}

function missileeyes(var_0, var_1) {
  var_0 endon("joined_team");
  var_0 endon("joined_spectators");
  thread rocket_cleanupondeath();
  thread player_cleanupongameended(var_0);
  thread player_cleanuponteamchange(var_0);
  var_0 visionsetmissilecamforplayer("black_bw", 0);
  var_0 endon("disconnect");

  if(isDefined(var_1)) {
    var_0 visionsetmissilecamforplayer(game["thermal_vision"], 1);
    var_0 thermalvisionon();
    thread delayedfofoverlay();
    var_0 cameralinkTo(var_1, "tag_origin");
    var_0 controlslinkTo(var_1);

    if(getdvarint("camera_thirdPerson")) {
      var_0 scripts\mp\utility\player::setthirdpersondof(0);
    }

    var_1 waittill("death");
    var_0 thermalvisionoff();

    if(isDefined(var_1)) {
      var_0 scripts\common\utility::ref_13E0A(level.ref_11B2A, "predator_missile", var_1.origin);
    }

    var_0 controlsunlink();
    var_0 scripts\mp\utility\player::_freezecontrols(1);

    if(!level.gameended) {
      var_0 setclientomnvar("ui_predator_missile", 2);
    }

    wait 0.5;
    var_0 cameraunlink();

    if(getdvarint("camera_thirdPerson")) {
      var_0 scripts\mp\utility\player::setthirdpersondof(1);
    }
  }

  var_0 setclientomnvar("ui_predator_missile", 0);
  var_0 scripts\mp\utility\player::clearusingremote();
}

function delayedfofoverlay() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait 0.15;
}

function player_cleanuponteamchange(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  scripts\engine\utility::ref_143A5("joined_team", "joined_spectators");

  if(self.team != "spectator") {
    self controlsunlink();
    self cameraunlink();

    if(getdvarint("camera_thirdPerson")) {
      scripts\mp\utility\player::setthirdpersondof(1);
    }
  }

  scripts\mp\utility\player::clearusingremote();
  level.remotemissileinprogress = undefined;
}

function rocket_cleanupondeath() {
  var_0 = self getentitynumber();
  level.rockets[var_0] = self;
  self waittill("death");
  level.rockets[var_0] = undefined;
  level.remotemissileinprogress = undefined;
}

function player_cleanupongameended(var_0) {
  var_0 endon("death");
  self endon("death");
  level waittill("game_ended");
  self controlsunlink();
  self cameraunlink();

  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility\player::setthirdpersondof(1);
    return;
  }
}