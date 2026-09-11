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

function tryusepredatormissile(var0, var1) {
  scripts\mp\utility\player::setusingremote("remotemissile");
  var2 = scripts\mp\killstreaks\killstreaks::initridekillstreak();

  if(var2 != "success") {
    if(var2 != "disconnect") {
      scripts\mp\utility\player::clearusingremote();
    }

    return false;
  }

  self setclientomnvar("ui_predator_missile", 1);
  thread _fire(level, var0);
  return true;
}

function getbestspawnpoint(var0) {
  var1 = [];

  foreach(var3 in var0) {
    var3.validplayers = [];
    var3.spawnscore = 0;
  }

  foreach(var6 in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(var6)) {
      continue;
    }

    if(var6.team == self.team) {
      continue;
    }

    if(var6.team == "spectator") {
      continue;
    }

    var7 = 999999999;
    var8 = undefined;

    foreach(var3 in var0) {
      var3.validplayers[var3.validplayers.size] = var6;
      var10 = distance2d(var3.targetent.origin, var6.origin);

      if(var10 <= var7) {
        var7 = var10;
        var8 = var3;
      }
    }

    var8.spawnscore += 2;
  }

  var13 = var0[0];

  foreach(var3 in var0) {
    foreach(var6 in var3.validplayers) {
      var3.spawnscore += 1;

      if(scripts\engine\trace::_bullet_trace_passed(var6.origin + (0, 0, 32), var3.origin, 0, var6)) {
        var3.spawnscore += 3;
      }

      if(var3.spawnscore > var13.spawnscore) {
        var13 = var3;
        continue;
      }

      if(var3.spawnscore == var13.spawnscore) {
        if(scripts\engine\utility::cointoss()) {
          var13 = var3;
        }
      }
    }
  }

  return var13;
}

function _fire(var0, var1) {
  var2 = getEntArray("remoteMissileSpawn", "targetname");

  foreach(var5, var4 in var2) {
    if(isDefined(var4.target)) {
      var4.targetent = getEnt(var4.target, "targetname");
    }
  }

  if(var2.size > 0) {
    var6 = getbestspawnpoint(var1, var2);
  } else {
    var6 = undefined;
  }

  jumpiffalse(isDefined(var6)) LOC_000000b8;
  var7 = var6.origin;
  var8 = var6.targetent.origin;
  var9 = vectorNormalize(var7 - var8);
  var7 = var9 * 14000 + var8;
  var10 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("remotemissile_projectile_mp"), var7, var8, var2);
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

function missileeyes(var0, var1) {
  var0 endon("joined_team");
  var0 endon("joined_spectators");
  thread rocket_cleanupondeath();
  thread player_cleanupongameended(var0);
  thread player_cleanuponteamchange(var0);
  var0 visionsetmissilecamforplayer("black_bw", 0);
  var0 endon("disconnect");

  if(isDefined(var1)) {
    var0 visionsetmissilecamforplayer(game["thermal_vision"], 1);
    var0 thermalvisionon();
    thread delayedfofoverlay();
    var0 cameralinkTo(var1, "tag_origin");
    var0 controlslinkTo(var1);

    if(getdvarint("NOSLRNTRKL")) {
      var0 scripts\mp\utility\player::setthirdpersondof(0);
    }

    var1 waittill("death");
    var0 thermalvisionoff();

    if(isDefined(var1)) {
      var0 scripts\common\utility::ref_13e0a(level.ref_11b2a, "predator_missile", var1.origin);
    }

    var0 controlsunlink();
    var0 scripts\mp\utility\player::_freezecontrols(1);

    if(!level.gameended) {
      var0 setclientomnvar("ui_predator_missile", 2);
    }

    wait 0.5;
    var0 cameraunlink();

    if(getdvarint("NOSLRNTRKL")) {
      var0 scripts\mp\utility\player::setthirdpersondof(1);
    }
  }

  var0 setclientomnvar("ui_predator_missile", 0);
  var0 scripts\mp\utility\player::clearusingremote();
}

function delayedfofoverlay() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait 0.15;
}

function player_cleanuponteamchange(var0) {
  var0 endon("death");
  self endon("disconnect");
  scripts\engine\utility::ref_143a5("joined_team", "joined_spectators");

  if(self.team != "spectator") {
    self controlsunlink();
    self cameraunlink();

    if(getdvarint("NOSLRNTRKL")) {
      scripts\mp\utility\player::setthirdpersondof(1);
    }
  }

  scripts\mp\utility\player::clearusingremote();
  level.remotemissileinprogress = undefined;
}

function rocket_cleanupondeath() {
  var0 = self getentitynumber();
  level.rockets[var0] = self;
  self waittill("death");
  level.rockets[var0] = undefined;
  level.remotemissileinprogress = undefined;
}

function player_cleanupongameended(var0) {
  var0 endon("death");
  self endon("death");
  level waittill("game_ended");
  self controlsunlink();
  self cameraunlink();

  if(getdvarint("NOSLRNTRKL")) {
    scripts\mp\utility\player::setthirdpersondof(1);
    return;
  }
}