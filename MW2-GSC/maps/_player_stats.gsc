/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_player_stats.gsc
********************************************************/

#include maps\_utility;
#include common_scripts\utility;

init_stats() {
  self.stats["kills"] = 0;
  self.stats["kills_melee"] = 0;
  self.stats["kills_explosives"] = 0;
  self.stats["kills_juggernaut"] = 0;
  self.stats["kills_vehicle"] = 0;
  self.stats["kills_sentry"] = 0;

  self.stats["shots_fired"] = 0;
  self.stats["shots_hit"] = 0;

  self.stats["weapon"] = [];

  self thread shots_fired_recorder();
}

register_kill(killedEnt, cause) {
  assertEx(isDefined(cause), "Tried to register a player stat for a kill that didn't have a method of death");

  player = self;
  if(isDefined(self.owner))
    player = self.owner;

  if(!isPlayer(player)) {
    if(isDefined(level.pmc_match) && level.pmc_match)
      player = level.players[randomint(level.players.size)];
  }

  if(!isPlayer(player)) {
    return;
  }

  player.stats["kills"]++;

  if(isDefined(killedEnt)) {
    if(isDefined(killedEnt.juggernaut))
      player.stats["kills_juggernaut"]++;

    if(isDefined(killedEnt.isSentryGun))
      player.stats["kills_sentry"]++;

    if(killedEnt.code_classname == "script_vehicle") {
      player.stats["kills_vehicle"]++;

      if(isDefined(killedEnt.riders))
        foreach(rider in killedEnt.riders)
      if(isDefined(rider))
        player register_kill(rider, cause);
    }
  }

  if(issubstr(tolower(cause), "melee"))
    player.stats["kills_melee"]++;

  if(cause_is_explosive(cause))
    player.stats["kills_explosives"]++;

  weaponName = player getCurrentWeapon();
  assert(isDefined(weaponName));
  if(player is_new_weapon(weaponName))
    player register_new_weapon(weaponName);
  player.stats["weapon"][weaponName].kills++;
}

register_shot_hit() {
  if(!isPlayer(self))
    return;
  assert(isDefined(self.stats));

  if(isDefined(self.registeringShotHit))
    return;
  self.registeringShotHit = true;

  self.stats["shots_hit"]++;

  weaponName = self getCurrentWeapon();
  assert(isDefined(weaponName));
  if(is_new_weapon(weaponName))
    register_new_weapon(weaponName);
  self.stats["weapon"][weaponName].shots_hit++;

  waittillframeend;
  self.registeringShotHit = undefined;
}

shots_fired_recorder() {
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");

    self.stats["shots_fired"]++;

    weaponName = self getCurrentWeapon();
    assert(isDefined(weaponName));
    if(is_new_weapon(weaponName))
      register_new_weapon(weaponName);
    self.stats["weapon"][weaponName].shots_fired++;
  }
}

is_new_weapon(weaponName) {
  if(isDefined(self.stats["weapon"][weaponName]))
    return false;
  return true;
}

cause_is_explosive(cause) {
  cause = tolower(cause);
  switch (cause) {
    case "mod_grenade":
    case "mod_grenade_splash":
    case "mod_projectile":
    case "mod_projectile_splash":
    case "mod_explosive":
    case "splash":
      return true;
    default:
      return false;
  }
  return false;
}

register_new_weapon(weaponName) {
  self.stats["weapon"][weaponName] = spawnStruct();
  self.stats["weapon"][weaponName].name = weaponName;
  self.stats["weapon"][weaponName].shots_fired = 0;
  self.stats["weapon"][weaponName].shots_hit = 0;
  self.stats["weapon"][weaponName].kills = 0;
}

set_stat_dvars() {
  playerNum = 1;
  foreach(player in level.players) {
    setDvar("stats_" + playerNum + "_kills_melee", player.stats["kills_melee"]);
    setDvar("stats_" + playerNum + "_kills_juggernaut", player.stats["kills_juggernaut"]);
    setDvar("stats_" + playerNum + "_kills_explosives", player.stats["kills_explosives"]);
    setDvar("stats_" + playerNum + "_kills_vehicle", player.stats["kills_vehicle"]);
    setDvar("stats_" + playerNum + "_kills_sentry", player.stats["kills_sentry"]);

    weapons = player get_best_weapons(5);
    foreach(weapon in weapons) {
      weapon.accuracy = 0;
      if(weapon.shots_fired > 0)
        weapon.accuracy = int((weapon.shots_hit / weapon.shots_fired) * 100);
    }

    for(i = 1; i < 6; i++) {
      setDvar("stats_" + playerNum + "_weapon" + i + "_name", " ");
      setDvar("stats_" + playerNum + "_weapon" + i + "_kills", " ");
      setDvar("stats_" + playerNum + "_weapon" + i + "_shots", " ");
      setDvar("stats_" + playerNum + "_weapon" + i + "_accuracy", " ");
    }
    for(i = 0; i < weapons.size; i++) {
      if(!isDefined(weapons[i])) {
        break;
      }

      setDvar("stats_" + playerNum + "_weapon" + (i + 1) + "_name", weapons[i].name);
      setDvar("stats_" + playerNum + "_weapon" + (i + 1) + "_kills", weapons[i].kills);
      setDvar("stats_" + playerNum + "_weapon" + (i + 1) + "_shots", weapons[i].shots_fired);
      setDvar("stats_" + playerNum + "_weapon" + (i + 1) + "_accuracy", weapons[i].accuracy + "%");
    }

    playerNum++;
  }
}

get_best_weapons(numToGet) {
  weaponStats = [];

  for(i = 0; i < numToGet; i++) {
    weaponStats[i] = get_weapon_with_most_kills(weaponStats);
  }

  return weaponStats;
}

get_weapon_with_most_kills(excluders) {
  if(!isDefined(excluders))
    excluders = [];

  highest = undefined;

  foreach(weapon in self.stats["weapon"]) {
    isExcluder = false;
    foreach(excluder in excluders) {
      if(weapon.name == excluder.name) {
        isExcluder = true;
        break;
      }
    }
    if(isExcluder) {
      continue;
    }
    if(!isDefined(highest))
      highest = weapon;
    else if(weapon.kills > highest.kills)
      highest = weapon;
  }

  return highest;
}