/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_remotemissile.gsc
*****************************************************/

init() {
  level.var_B897 = 14000;
  level.var_B895 = 7000;
  level.var_B896 = 1500;
  level.rockets = [];
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("predator_missile", ::tryusepredatormissile);
  level.remotekillstreaks["explode"] = loadfx("vfx\core\expl\aerial_explosion");
}

tryusepredatormissile(param_00, param_01) {
  scripts\mp\utility::setusingremote("remotemissile");
  var_02 = scripts\mp\killstreaks\_killstreaks::initridekillstreak();
  if(var_02 != "success") {
    if(var_02 != "disconnect") {
      scripts\mp\utility::clearusingremote();
    }

    return 0;
  }

  self setclientomnvar("ui_predator_missile", 1);
  level thread _fire(param_00, self);
  return 1;
}

func_7E01(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    var_03.var_1314F = [];
    var_03.var_10909 = 0;
  }

  foreach(var_06 in level.players) {
    if(!scripts\mp\utility::isreallyalive(var_06)) {
      continue;
    }

    if(var_06.team == self.team) {
      continue;
    }

    if(var_06.team == "spectator") {
      continue;
    }

    var_07 = 999999999;
    var_08 = undefined;
    foreach(var_03 in param_00) {
      var_03.var_1314F[var_03.var_1314F.size] = var_06;
      var_0A = distance2d(var_03.var_1155F.origin, var_06.origin);
      if(var_0A <= var_07) {
        var_07 = var_0A;
        var_08 = var_03;
      }
    }

    var_08.var_10909 = var_08.var_10909 + 2;
  }

  var_0D = param_00[0];
  foreach(var_03 in param_00) {
    foreach(var_10, var_06 in var_03.var_1314F) {
      var_03.var_10909 = var_03.var_10909 + 1;
      if(bullettracepassed(var_06.origin + (0, 0, 32), var_03.origin, 0, var_06)) {
        var_03.var_10909 = var_03.var_10909 + 3;
      }

      if(var_03.var_10909 > var_0D.var_10909) {
        var_0D = var_03;
        continue;
      }

      if(var_03.var_10909 == var_0D.var_10909) {
        if(scripts\engine\utility::cointoss()) {
          var_0D = var_03;
        }
      }
    }
  }

  return var_0D;
}

_fire(param_00, param_01) {
  var_02 = getEntArray("remoteMissileSpawn", "targetname");
  foreach(var_04 in var_02) {
    if(isDefined(var_04.target)) {
      var_04.var_1155F = getent(var_04.target, "targetname");
    }
  }

  if(var_02.size > 0) {
    var_06 = param_01 func_7E01(var_02);
  } else {
    var_06 = undefined;
  }

  if(isDefined(var_06)) {
    var_07 = var_06.origin;
    var_08 = var_06.var_1155F.origin;
    var_09 = vectornormalize(var_07 - var_08);
    var_07 = var_09 * 14000 + var_08;
    var_0A = scripts\mp\utility::_magicbullet("remotemissile_projectile_mp", var_07, var_08, param_01);
  } else {
    var_0B = (0, 0, level.var_B897);
    var_0C = level.var_B895;
    var_0D = level.var_B896;
    var_0E = anglesToForward(param_01.angles);
    var_07 = param_01.origin + var_0B + var_0E * var_0C * -1;
    var_08 = param_01.origin + var_0E * var_0D;
    var_0A = scripts\mp\utility::_magicbullet("remotemissile_projectile_mp", var_07, var_08, param_01);
  }

  if(!isDefined(var_0A)) {
    param_01 scripts\mp\utility::clearusingremote();
    return;
  }

  var_0A.team = param_01.team;
  var_0A thread handledamage();
  var_0A.lifeid = param_00;
  var_0A.type = "remote";
  level.remotemissileinprogress = 1;
  missileeyes(param_01, var_0A);
}

handledamage() {
  self endon("death");
  self endon("deleted");
  self setCanDamage(1);
  self waittill("damage");
}

missileeyes(param_00, param_01) {
  param_00 endon("joined_team");
  param_00 endon("joined_spectators");
  param_01 thread rocket_cleanupondeath();
  param_00 thread player_cleanupongameended(param_01);
  param_00 thread player_cleanuponteamchange(param_01);
  param_00 visionsetmissilecamforplayer("black_bw", 0);
  param_00 endon("disconnect");
  if(isDefined(param_01)) {
    param_00 visionsetmissilecamforplayer(game["thermal_vision"], 1);
    param_00 thermalvisionon();
    param_00 thread delayedfofoverlay();
    param_00 cameralinkto(param_01, "tag_origin");
    param_00 controlslinkto(param_01);
    if(getdvarint("camera_thirdPerson")) {
      param_00 scripts\mp\utility::setthirdpersondof(0);
    }

    param_01 waittill("death");
    param_00 thermalvisionoff();
    if(isDefined(param_01)) {
      param_00 scripts\mp\matchdata::logkillstreakevent("predator_missile", param_01.origin);
    }

    param_00 controlsunlink();
    param_00 scripts\mp\utility::freezecontrolswrapper(1);
    if(!level.gameended) {
      param_00 setclientomnvar("ui_predator_missile", 2);
    }

    wait(0.5);
    param_00 thermalvisionfofoverlayoff();
    param_00 cameraunlink();
    if(getdvarint("camera_thirdPerson")) {
      param_00 scripts\mp\utility::setthirdpersondof(1);
    }
  }

  param_00 setclientomnvar("ui_predator_missile", 0);
  param_00 scripts\mp\utility::clearusingremote();
}

delayedfofoverlay() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(0.15);
  self thermalvisionfofoverlayon();
}

player_cleanuponteamchange(param_00) {
  param_00 endon("death");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators");
  if(self.team != "spectator") {
    self thermalvisionfofoverlayoff();
    self controlsunlink();
    self cameraunlink();
    if(getdvarint("camera_thirdPerson")) {
      scripts\mp\utility::setthirdpersondof(1);
    }
  }

  scripts\mp\utility::clearusingremote();
  level.remotemissileinprogress = undefined;
}

rocket_cleanupondeath() {
  var_00 = self getentitynumber();
  level.rockets[var_00] = self;
  self waittill("death");
  level.rockets[var_00] = undefined;
  level.remotemissileinprogress = undefined;
}

player_cleanupongameended(param_00) {
  param_00 endon("death");
  self endon("death");
  level waittill("game_ended");
  self thermalvisionfofoverlayoff();
  self controlsunlink();
  self cameraunlink();
  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility::setthirdpersondof(1);
  }
}