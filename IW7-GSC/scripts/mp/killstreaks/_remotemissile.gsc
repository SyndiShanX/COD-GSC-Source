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

tryusepredatormissile(var_0, var_1) {
  scripts\mp\utility::setusingremote("remotemissile");
  var_2 = scripts\mp\killstreaks\_killstreaks::initridekillstreak();
  if(var_2 != "success") {
    if(var_2 != "disconnect") {
      scripts\mp\utility::clearusingremote();
    }

    return 0;
  }

  self setclientomnvar("ui_predator_missile", 1);
  level thread _fire(var_0, self);
  return 1;
}

func_7E01(var_0) {
  var_1 = [];
  foreach(var_3 in var_0) {
    var_3.var_1314F = [];
    var_3.var_10909 = 0;
  }

  foreach(var_6 in level.players) {
    if(!scripts\mp\utility::isreallyalive(var_6)) {
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
      var_3.var_1314F[var_3.var_1314F.size] = var_6;
      var_0A = distance2d(var_3.var_1155F.origin, var_6.origin);
      if(var_0A <= var_7) {
        var_7 = var_0A;
        var_8 = var_3;
      }
    }

    var_8.var_10909 = var_8.var_10909 + 2;
  }

  var_0D = var_0[0];
  foreach(var_3 in var_0) {
    foreach(var_10, var_6 in var_3.var_1314F) {
      var_3.var_10909 = var_3.var_10909 + 1;
      if(bullettracepassed(var_6.origin + (0, 0, 32), var_3.origin, 0, var_6)) {
        var_3.var_10909 = var_3.var_10909 + 3;
      }

      if(var_3.var_10909 > var_0D.var_10909) {
        var_0D = var_3;
        continue;
      }

      if(var_3.var_10909 == var_0D.var_10909) {
        if(scripts\engine\utility::cointoss()) {
          var_0D = var_3;
        }
      }
    }
  }

  return var_0D;
}

_fire(var_0, var_1) {
  var_2 = getEntArray("remoteMissileSpawn", "targetname");
  foreach(var_4 in var_2) {
    if(isDefined(var_4.target)) {
      var_4.var_1155F = getent(var_4.target, "targetname");
    }
  }

  if(var_2.size > 0) {
    var_6 = var_1 func_7E01(var_2);
  } else {
    var_6 = undefined;
  }

  if(isDefined(var_6)) {
    var_7 = var_6.origin;
    var_8 = var_6.var_1155F.origin;
    var_9 = vectornormalize(var_7 - var_8);
    var_7 = var_9 * 14000 + var_8;
    var_0A = scripts\mp\utility::_magicbullet("remotemissile_projectile_mp", var_7, var_8, var_1);
  } else {
    var_0B = (0, 0, level.var_B897);
    var_0C = level.var_B895;
    var_0D = level.var_B896;
    var_0E = anglesToForward(var_1.angles);
    var_7 = var_1.origin + var_0B + var_0E * var_0C * -1;
    var_8 = var_1.origin + var_0E * var_0D;
    var_0A = scripts\mp\utility::_magicbullet("remotemissile_projectile_mp", var_7, var_8, var_1);
  }

  if(!isDefined(var_0A)) {
    var_1 scripts\mp\utility::clearusingremote();
    return;
  }

  var_0A.team = var_1.team;
  var_0A thread handledamage();
  var_0A.lifeid = var_0;
  var_0A.type = "remote";
  level.remotemissileinprogress = 1;
  missileeyes(var_1, var_0A);
}

handledamage() {
  self endon("death");
  self endon("deleted");
  self setCanDamage(1);
  self waittill("damage");
}

missileeyes(var_0, var_1) {
  var_0 endon("joined_team");
  var_0 endon("joined_spectators");
  var_1 thread rocket_cleanupondeath();
  var_0 thread player_cleanupongameended(var_1);
  var_0 thread player_cleanuponteamchange(var_1);
  var_0 visionsetmissilecamforplayer("black_bw", 0);
  var_0 endon("disconnect");
  if(isDefined(var_1)) {
    var_0 visionsetmissilecamforplayer(game["thermal_vision"], 1);
    var_0 thermalvisionon();
    var_0 thread delayedfofoverlay();
    var_0 cameralinkto(var_1, "tag_origin");
    var_0 controlslinkto(var_1);
    if(getdvarint("camera_thirdPerson")) {
      var_0 scripts\mp\utility::setthirdpersondof(0);
    }

    var_1 waittill("death");
    var_0 thermalvisionoff();
    if(isDefined(var_1)) {
      var_0 scripts\mp\matchdata::logkillstreakevent("predator_missile", var_1.origin);
    }

    var_0 controlsunlink();
    var_0 scripts\mp\utility::freezecontrolswrapper(1);
    if(!level.gameended) {
      var_0 setclientomnvar("ui_predator_missile", 2);
    }

    wait(0.5);
    var_0 thermalvisionfofoverlayoff();
    var_0 cameraunlink();
    if(getdvarint("camera_thirdPerson")) {
      var_0 scripts\mp\utility::setthirdpersondof(1);
    }
  }

  var_0 setclientomnvar("ui_predator_missile", 0);
  var_0 scripts\mp\utility::clearusingremote();
}

delayedfofoverlay() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(0.15);
  self thermalvisionfofoverlayon();
}

player_cleanuponteamchange(var_0) {
  var_0 endon("death");
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
  var_0 = self getentitynumber();
  level.rockets[var_0] = self;
  self waittill("death");
  level.rockets[var_0] = undefined;
  level.remotemissileinprogress = undefined;
}

player_cleanupongameended(var_0) {
  var_0 endon("death");
  self endon("death");
  level waittill("game_ended");
  self thermalvisionfofoverlayoff();
  self controlsunlink();
  self cameraunlink();
  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility::setthirdpersondof(1);
  }
}