/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\remotemissile.gsc
****************************************************/

init() {
  level.missileremotelaunchvert = 14000;
  level.missileremotelaunchhorz = 7000;
  level.missileremotelaunchtargetdist = 1500;
  level.rockets = [];
  level.remotemissile_fx["explode"] = loadfx("vfx/core/expl/aerial_explosion");
}

tryusepredatormissile(lifeid, streakname) {
  scripts\mp\utility\player::setusingremote("remotemissile");
  result = scripts\mp\killstreaks\killstreaks::initridekillstreak();

  if(result != "success") {
    if(result != "disconnect")
      scripts\mp\utility\player::clearusingremote();

    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("ride_killstreak");
    return 0;
  }

  self setclientomnvar("ui_predator_missile", 1);
  level thread _fire(lifeid, self);
  return 1;
}

getbestspawnpoint(_id_123255877BC63BBB) {
  _id_45A9094092727403 = [];

  foreach(spawnpoint in _id_123255877BC63BBB) {
    spawnpoint.validplayers = [];
    spawnpoint.spawnscore = 0;
  }

  foreach(player in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    if(player.team == self.team) {
      continue;
    }
    if(player.team == "spectator") {
      continue;
    }
    _id_FDB9974A1CCCE54C = 999999999;
    _id_821EB9EE5D4CB048 = undefined;

    foreach(spawnpoint in _id_123255877BC63BBB) {
      spawnpoint.validplayers[spawnpoint.validplayers.size] = player;
      _id_45897149FE791D94 = distance2d(spawnpoint.targetent.origin, player.origin);

      if(_id_45897149FE791D94 <= _id_FDB9974A1CCCE54C) {
        _id_FDB9974A1CCCE54C = _id_45897149FE791D94;
        _id_821EB9EE5D4CB048 = spawnpoint;
      }
    }

    _id_821EB9EE5D4CB048.spawnscore = _id_821EB9EE5D4CB048.spawnscore + 2;
  }

  _id_B8D119D2C9609296 = _id_123255877BC63BBB[0];

  foreach(spawnpoint in _id_123255877BC63BBB) {
    foreach(player in spawnpoint.validplayers) {
      spawnpoint.spawnscore = spawnpoint.spawnscore + 1;

      if(scripts\engine\trace::_bullet_trace_passed(player.origin + (0, 0, 32), spawnpoint.origin, 0, player))
        spawnpoint.spawnscore = spawnpoint.spawnscore + 3;

      if(spawnpoint.spawnscore > _id_B8D119D2C9609296.spawnscore) {
        _id_B8D119D2C9609296 = spawnpoint;
        continue;
      }

      if(spawnpoint.spawnscore == _id_B8D119D2C9609296.spawnscore) {
        if(scripts\engine\utility::cointoss())
          _id_B8D119D2C9609296 = spawnpoint;
      }
    }
  }

  return _id_B8D119D2C9609296;
}

_fire(lifeid, player) {
  _id_D6A6251019BDCF29 = getEntArray("remoteMissileSpawn", "targetname");

  foreach(spawn in _id_D6A6251019BDCF29) {
    if(isDefined(spawn.target))
      spawn.targetent = getEnt(spawn.target, "targetname");
  }

  if(_id_D6A6251019BDCF29.size > 0)
    _id_9911424A16B85E14 = player getbestspawnpoint(_id_D6A6251019BDCF29);
  else
    _id_9911424A16B85E14 = undefined;

  if(isDefined(_id_9911424A16B85E14)) {
    startpos = _id_9911424A16B85E14.origin;
    targetpos = _id_9911424A16B85E14.targetent.origin;
    _id_16290C9DDA466BCE = vectorNormalize(startpos - targetpos);
    startpos = _id_16290C9DDA466BCE * 14000 + targetpos;
    rocket = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("remotemissile_projectile_mp"), startpos, targetpos, player);
  } else {
    _id_2CF4A7DBEF8201F3 = (0, 0, level.missileremotelaunchvert);
    _id_1124265EE011BB02 = level.missileremotelaunchhorz;
    _id_822DB80CE3C87A54 = level.missileremotelaunchtargetdist;
    forward = anglesToForward(player.angles);
    startpos = player.origin + _id_2CF4A7DBEF8201F3 + forward * _id_1124265EE011BB02 * -1;
    targetpos = player.origin + forward * _id_822DB80CE3C87A54;
    rocket = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("remotemissile_projectile_mp"), startpos, targetpos, player);
  }

  if(!isDefined(rocket)) {
    player scripts\mp\utility\player::clearusingremote();
    return;
  }

  rocket.team = player.team;
  rocket thread handledamage();
  rocket.lifeid = lifeid;
  rocket.type = "remote";
  level.remotemissileinprogress = 1;
  missileeyes(player, rocket);
}

handledamage() {
  self endon("death");
  self endon("deleted");
  self setCanDamage(1);

  for(;;)
    self waittill("damage");
}

missileeyes(player, rocket) {
  player endon("joined_team");
  player endon("joined_spectators");
  rocket thread rocket_cleanupondeath();
  player thread player_cleanupongameended(rocket);
  player thread player_cleanuponteamchange(rocket);
  player visionsetmissilecamforplayer("black_bw", 0);
  player endon("disconnect");

  if(isDefined(rocket)) {
    player visionsetmissilecamforplayer(game["thermal_vision"], 1.0);
    player thermalvisionon();
    player thread delayedfofoverlay();
    player cameralinkTo(rocket, "tag_origin");
    player controlslinkTo(rocket);

    if(getdvarint("camera_thirdPerson"))
      player scripts\mp\utility\player::setthirdpersondof(0);

    rocket waittill("death");
    player thermalvisionoff();

    if(isDefined(rocket))
      player scripts\common\utility::trycall(level.matchdata_logkillstreakevent, "predator_missile", rocket.origin);

    player controlsunlink();
    player scripts\mp\utility\player::_freezecontrols(1);

    if(!level.gameended)
      player setclientomnvar("ui_predator_missile", 2);

    wait 0.5;
    player cameraunlink();

    if(getdvarint("camera_thirdPerson"))
      player scripts\mp\utility\player::setthirdpersondof(1);
  }

  player setclientomnvar("ui_predator_missile", 0);
  player scripts\mp\utility\player::clearusingremote();
}

delayedfofoverlay() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait 0.15;
}

player_cleanuponteamchange(rocket) {
  rocket endon("death");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");

  if(self.team != "spectator") {
    self controlsunlink();
    self cameraunlink();

    if(getdvarint("camera_thirdPerson"))
      scripts\mp\utility\player::setthirdpersondof(1);
  }

  scripts\mp\utility\player::clearusingremote();
  level.remotemissileinprogress = undefined;
}

rocket_cleanupondeath() {
  entitynumber = self getentitynumber();
  level.rockets[entitynumber] = self;
  self waittill("death");
  level.rockets[entitynumber] = undefined;
  level.remotemissileinprogress = undefined;
}

player_cleanupongameended(rocket) {
  rocket endon("death");
  self endon("death");
  level waittill("game_ended");
  self controlsunlink();
  self cameraunlink();

  if(getdvarint("camera_thirdPerson"))
    scripts\mp\utility\player::setthirdpersondof(1);
}