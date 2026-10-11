/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\killstreaks\remotemissile.gsc
*******************************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#namespace remotemissile;

function init() {
  level.missileremotelaunchvert = 14000;
  level.missileremotelaunchhorz = 7000;
  level.missileremotelaunchtargetdist = 1500;
  level.rockets = [];
  assertmsg("<dev string:x1c>");
  level.remotemissile_fx["explode"] = loadfx("vfx/core/expl/aerial_explosion");
}

function tryusepredatormissile(lifeid, streakname) {
  setusingremote("remotemissile");
  result = scripts\mp\killstreaks\killstreaks::initridekillstreak();

  if(result != "success") {
    if(result != "disconnect") {
      clearusingremote();
    }

    val::reset_all("ride_killstreak");
    return false;
  }

  self setclientomnvar("ui_predator_missile", 1);
  level thread _fire(lifeid, self);
  return true;
}

function getbestspawnpoint(remotemissilespawnpoints) {
  validenemies = [];

  foreach(spawnpoint in remotemissilespawnpoints) {
    spawnpoint.validplayers = [];
    spawnpoint.spawnscore = 0;
  }

  foreach(player in level.players) {
    if(!isreallyalive(player)) {
      continue;
    }

    if(player.team == self.team) {
      continue;
    }

    if(player.team == "spectator") {
      continue;
    }

    bestdistance = 999999999;
    bestspawnpoint = undefined;

    foreach(spawnpoint in remotemissilespawnpoints) {
      spawnpoint.validplayers[spawnpoint.validplayers.size] = player;
      potentialbestdistance = distance2d(spawnpoint.targetent.origin, player.origin);

      if(potentialbestdistance <= bestdistance) {
        bestdistance = potentialbestdistance;
        bestspawnpoint = spawnpoint;
      }
    }

    assertex(isDefined(bestspawnpoint), "<dev string:x7b>" + player.name);
    bestspawnpoint.spawnscore += 2;
  }

  bestspawn = remotemissilespawnpoints[0];

  foreach(spawnpoint in remotemissilespawnpoints) {
    foreach(player in spawnpoint.validplayers) {
      spawnpoint.spawnscore += 1;

      if(scripts\engine\trace::_bullet_trace_passed(player.origin + (0, 0, 32), spawnpoint.origin, 0, player)) {
        spawnpoint.spawnscore += 3;
      }

      if(spawnpoint.spawnscore > bestspawn.spawnscore) {
        bestspawn = spawnpoint;
        continue;
      }

      if(spawnpoint.spawnscore == bestspawn.spawnscore) {
        if(cointoss()) {
          bestspawn = spawnpoint;
        }
      }
    }
  }

  return bestspawn;
}

function _fire(lifeid, player) {
  remotemissilespawnarray = getEntArray("remoteMissileSpawn", "targetname");

  foreach(spawn in remotemissilespawnarray) {
    if(isDefined(spawn.target)) {
      spawn.targetent = getEnt(spawn.target, "targetname");
    }
  }

  if(remotemissilespawnarray.size > 0) {
    remotemissilespawn = player getbestspawnpoint(remotemissilespawnarray);
  } else {
    remotemissilespawn = undefined;
  }

  if(isDefined(remotemissilespawn)) {
    startpos = remotemissilespawn.origin;
    targetpos = remotemissilespawn.targetent.origin;
    vector = vectorNormalize(startpos - targetpos);
    startpos = vector * 14000 + targetpos;
    rocket = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("remotemissile_projectile_mp"), startpos, targetpos, player);
  } else {
    upvector = (0, 0, level.missileremotelaunchvert);
    backdist = level.missileremotelaunchhorz;
    targetdist = level.missileremotelaunchtargetdist;
    forward = anglesToForward(player.angles);
    startpos = player.origin + upvector + forward * backdist * -1;
    targetpos = player.origin + forward * targetdist;
    rocket = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("remotemissile_projectile_mp"), startpos, targetpos, player);
  }

  if(!isDefined(rocket)) {
    player clearusingremote();
    return;
  }

  rocket.team = player.team;
  rocket thread handledamage();
  rocket.lifeid = lifeid;
  rocket.type = "remote";
  level.remotemissileinprogress = 1;
  missileeyes(player, rocket);
}

function _fire_noplayer(lifeid, player) {
  upvector = (0, 0, level.missileremotelaunchvert);
  backdist = level.missileremotelaunchhorz;
  targetdist = level.missileremotelaunchtargetdist;
  forward = anglesToForward(player.angles);
  startpos = player.origin + upvector + forward * backdist * -1;
  targetpos = player.origin + forward * targetdist;
  rocket = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("<dev string:xb7>"), startpos, targetpos, player);

  if(!isDefined(rocket)) {
    return;
  }

  rocket thread handledamage();
  rocket.lifeid = lifeid;
  rocket.type = "<dev string:xd6>";
  player cameralinkTo(rocket, "<dev string:xe0>");
  player controlslinkTo(rocket);
  rocket thread rocket_cleanupondeath();
  wait 2;
  player controlsunlink();
  player cameraunlink();
}

function handledamage() {
  self endon("death");
  self endon("deleted");
  self setCanDamage(1);

  for(;;) {
    self waittill("<dev string:xee>");
    println("<dev string:xf8>");
  }
}

function missileeyes(player, rocket) {
  player endon("joined_team");
  player endon("joined_spectators");
  rocket thread rocket_cleanupondeath();
  player thread player_cleanupongameended(rocket);
  player thread player_cleanuponteamchange(rocket);
  player visionsetmissilecamforplayer("black_bw", 0);
  player endon("disconnect");

  if(isDefined(rocket)) {
    player visionsetmissilecamforplayer(game["thermal_vision"], 1);
    player thermalvisionon();
    player thread delayedfofoverlay();
    player cameralinkTo(rocket, "tag_origin");
    player controlslinkTo(rocket);

    if(getdvarint(@ "camera_thirdperson")) {
      player setthirdpersondof(0);
    }

    rocket waittill("death");
    player thermalvisionoff();

    if(isDefined(rocket)) {
      player utility::trycall(level.matchdata_logkillstreakevent, "predator_missile", rocket.origin);
    }

    player controlsunlink();
    player _freezecontrols(1);

    if(!level.gameended) {
      player setclientomnvar("ui_predator_missile", 2);
    }

    wait 0.5;
    player cameraunlink();

    if(getdvarint(@ "camera_thirdperson")) {
      player setthirdpersondof(1);
    }
  }

  player setclientomnvar("ui_predator_missile", 0);
  player clearusingremote();
}

function delayedfofoverlay() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait 0.15;
}

function player_cleanuponteamchange(rocket) {
  rocket endon("death");
  self endon("disconnect");
  waittill_any_2("joined_team", "joined_spectators");

  if(self.team != "spectator") {
    self controlsunlink();
    self cameraunlink();

    if(getdvarint(@ "camera_thirdperson")) {
      setthirdpersondof(1);
    }
  }

  clearusingremote();
  level.remotemissileinprogress = undefined;
}

function rocket_cleanupondeath() {
  entitynumber = self getentitynumber();
  level.rockets[entitynumber] = self;
  self waittill("death");
  level.rockets[entitynumber] = undefined;
  level.remotemissileinprogress = undefined;
}

function player_cleanupongameended(rocket) {
  rocket endon("death");
  self endon("death");
  level waittill("game_ended");
  self controlsunlink();
  self cameraunlink();

  if(getdvarint(@ "camera_thirdperson")) {
    setthirdpersondof(1);
  }
}