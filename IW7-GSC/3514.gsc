/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3514.gsc
***************************************/

init() {
  level.func_B897 = 14000;
  level.func_B895 = 7000;
  level.func_B896 = 1500;
  level.rockets = [];
  scripts\mp\killstreaks\killstreaks::registerkillstreak("predator_missile", ::tryusepredatormissile);
  level.remotekillstreaks["explode"] = loadfx("vfx\core\expl\aerial_explosion");
}

tryusepredatormissile(var_00, var_01) {
  scripts\mp\utility\game::setusingremote("remotemissile");
  var_02 = scripts\mp\killstreaks\killstreaks::initridekillstreak();

  if(var_02 != "success") {
    if(var_02 != "disconnect")
      scripts\mp\utility\game::clearusingremote();

    return 0;
  }

  self setclientomnvar("ui_predator_missile", 1);
  level thread _fire(var_00, self);
  return 1;
}

func_7E01(var_00) {
  var_01 = [];

  foreach(var_03 in var_00) {
    var_3.func_1314F = [];
    var_3.func_10909 = 0;
  }

  foreach(var_06 in level.players) {
    if(!scripts\mp\utility\game::isreallyalive(var_06)) {
      continue;
    }
    if(var_6.team == self.team) {
      continue;
    }
    if(var_6.team == "spectator") {
      continue;
    }
    var_07 = 999999999;
    var_08 = undefined;

    foreach(var_03 in var_00) {
      var_3.func_1314F[var_3.func_1314F.size] = var_06;
      var_10 = distance2d(var_3.func_1155F.origin, var_6.origin);

      if(var_10 <= var_07) {
        var_07 = var_10;
        var_08 = var_03;
      }
    }

    var_8.func_10909 = var_8.func_10909 + 2;
  }

  var_13 = var_0[0];

  foreach(var_03 in var_00) {
    foreach(var_06 in var_3.func_1314F) {
      var_3.func_10909 = var_3.func_10909 + 1;

      if(bullettracepassed(var_6.origin + (0, 0, 32), var_3.origin, 0, var_06))
        var_3.func_10909 = var_3.func_10909 + 3;

      if(var_3.func_10909 > var_13.func_10909) {
        var_13 = var_03;
        continue;
      }

      if(var_3.func_10909 == var_13.func_10909) {
        if(scripts\engine\utility::cointoss())
          var_13 = var_03;
      }
    }
  }

  return var_13;
}

_fire(var_00, var_01) {
  var_02 = getEntArray("remoteMissileSpawn", "targetname");

  foreach(var_04 in var_02) {
    if(isDefined(var_4.target))
      var_4.func_1155F = getent(var_4.target, "targetname");
  }

  if(var_2.size > 0)
    var_06 = var_01 func_7E01(var_02);
  else
    var_06 = undefined;

  if(isDefined(var_06)) {
    var_07 = var_6.origin;
    var_08 = var_6.func_1155F.origin;
    var_09 = vectornormalize(var_07 - var_08);
    var_07 = var_09 * 14000 + var_08;
    var_10 = scripts\mp\utility\game::_magicbullet("remotemissile_projectile_mp", var_07, var_08, var_01);
  } else {
    var_11 = (0, 0, level.func_B897);
    var_12 = level.func_B895;
    var_13 = level.func_B896;
    var_14 = anglesToForward(var_1.angles);
    var_07 = var_1.origin + var_11 + var_14 * var_12 * -1;
    var_08 = var_1.origin + var_14 * var_13;
    var_10 = scripts\mp\utility\game::_magicbullet("remotemissile_projectile_mp", var_07, var_08, var_01);
  }

  if(!isDefined(var_10)) {
    var_01 scripts\mp\utility\game::clearusingremote();
    return;
  }

  var_10.team = var_1.team;
  var_10 thread handledamage();
  var_10.lifeid = var_00;
  var_10.type = "remote";
  level.remotemissileinprogress = 1;
  missileeyes(var_01, var_10);
}

handledamage() {
  self endon("death");
  self endon("deleted");
  self setCanDamage(1);

  for(;;)
    self waittill("damage");
}

missileeyes(var_00, var_01) {
  var_00 endon("joined_team");
  var_00 endon("joined_spectators");
  var_01 thread rocket_cleanupondeath();
  var_00 thread player_cleanupongameended(var_01);
  var_00 thread player_cleanuponteamchange(var_01);
  var_00 visionsetmissilecamforplayer("black_bw", 0);
  var_00 endon("disconnect");

  if(isDefined(var_01)) {
    var_00 visionsetmissilecamforplayer(game["thermal_vision"], 1.0);
    var_00 thermalvisionon();
    var_00 thread delayedfofoverlay();
    var_00 cameralinkto(var_01, "tag_origin");
    var_00 controlslinkto(var_01);

    if(getdvarint("camera_thirdPerson"))
      var_00 scripts\mp\utility\game::setthirdpersondof(0);

    var_01 waittill("death");
    var_00 thermalvisionoff();

    if(isDefined(var_01))
      var_00 scripts\mp\matchdata::logkillstreakevent("predator_missile", var_1.origin);

    var_00 controlsunlink();
    var_00 scripts\mp\utility\game::freezecontrolswrapper(1);

    if(!level.gameended)
      var_00 setclientomnvar("ui_predator_missile", 2);

    wait 0.5;
    var_00 thermalvisionfofoverlayoff();
    var_00 cameraunlink();

    if(getdvarint("camera_thirdPerson"))
      var_00 scripts\mp\utility\game::setthirdpersondof(1);
  }

  var_00 setclientomnvar("ui_predator_missile", 0);
  var_00 scripts\mp\utility\game::clearusingremote();
}

delayedfofoverlay() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait 0.15;
  self thermalvisionfofoverlayon();
}

player_cleanuponteamchange(var_00) {
  var_00 endon("death");
  self endon("disconnect");
  scripts\engine\utility::waittill_any("joined_team", "joined_spectators");

  if(self.team != "spectator") {
    self thermalvisionfofoverlayoff();
    self controlsunlink();
    self cameraunlink();

    if(getdvarint("camera_thirdPerson"))
      scripts\mp\utility\game::setthirdpersondof(1);
  }

  scripts\mp\utility\game::clearusingremote();
  level.remotemissileinprogress = undefined;
}

rocket_cleanupondeath() {
  var_00 = self getentitynumber();
  level.rockets[var_00] = self;
  self waittill("death");
  level.rockets[var_00] = undefined;
  level.remotemissileinprogress = undefined;
}

player_cleanupongameended(var_00) {
  var_00 endon("death");
  self endon("death");
  level waittill("game_ended");
  self thermalvisionfofoverlayoff();
  self controlsunlink();
  self cameraunlink();

  if(getdvarint("camera_thirdPerson"))
    scripts\mp\utility\game::setthirdpersondof(1);
}