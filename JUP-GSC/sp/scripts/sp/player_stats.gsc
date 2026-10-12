/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\player_stats.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\utility;
#namespace player_stats;

function init_stats() {
  self.stats["kills"] = 0;
  self.stats["kills_melee"] = 0;
  self.stats["kills_explosives"] = 0;
  self.stats["kills_juggernaut"] = 0;
  self.stats["kills_vehicle"] = 0;
  self.stats["kills_sentry"] = 0;
  self.stats["headshots"] = 0;
  self.stats["shots_fired"] = 0;
  self.stats["shots_hit"] = 0;
  self.stats["weapon"] = [];
  thread shots_fired_recorder();
}

function was_headshot() {
  if(isDefined(self.died_of_headshot) && self.died_of_headshot) {
    return true;
  }

  if(!isDefined(self.damagelocation)) {
    return false;
  }

  return self.damagelocation == "helmet" || self.damagelocation == "head" || self.damagelocation == "neck";
}

function register_kill(killedent, cause, weaponname, killtype) {
  assertex(isDefined(cause), "Tried to register a player stat for a kill that didn't have a method of death");
  player = self;

  if(isDefined(self.owner)) {
    player = self.owner;
  }

  if(!isPlayer(player)) {
    if(isDefined(level.pmc_match) && level.pmc_match) {
      player = level.players[randomint(level.players.size)];
    }
  }

  if(!isPlayer(player)) {
    return;
  }

  if(isDefined(level.skip_pilot_kill_count) && isDefined(killedent.drivingvehicle) && killedent.drivingvehicle) {
    return;
  }

  player.stats["kills"]++;

  if(isDefined(killedent)) {
    if(killedent was_headshot()) {
      player.stats["headshots"]++;
    }

    if(isDefined(killedent.juggernaut)) {
      player.stats["kills_juggernaut"]++;
    }

    if(isDefined(killedent.issentrygun)) {
      player.stats["kills_sentry"]++;
    }

    if(killedent.code_classname == "script_vehicle") {
      player.stats["kills_vehicle"]++;

      if(isDefined(killedent.riders)) {
        foreach(rider in killedent.riders) {
          if(isDefined(rider)) {
            player register_kill(rider, cause, weaponname, killtype);
          }
        }
      }
    }
  }

  if(cause_is_explosive(cause)) {
    player.stats["kills_explosives"]++;
  }

  if(isDefined(weaponname)) {
    weapon = makeweaponfromstring(weaponname);
  } else {
    weapon = player getcurrentweapon();
  }

  if(issubstr(tolower(cause), "melee")) {
    player.stats["kills_melee"]++;

    if(weaponinventorytype(weapon) == "primary") {
      return;
    }
  }

  assert(isDefined(weapon));

  if(player is_new_weapon(weapon)) {
    player register_new_weapon(weapon);
  }

  player.stats["weapon"][getcompleteweaponname(weapon)].kills++;
}

function register_shot_hit() {
  if(!isPlayer(self)) {
    return;
  }

  assert(isDefined(self.stats));

  if(isDefined(self.registeringshothit)) {
    return;
  }

  self.registeringshothit = 1;
  self.stats["shots_hit"]++;
  weapon = self getcurrentweapon();
  assert(isDefined(weapon));

  if(is_new_weapon(weapon)) {
    register_new_weapon(weapon);
  }

  self.stats["weapon"][getcompleteweaponname(weapon)].shots_hit++;
  waittillframeend();
  self.registeringshothit = undefined;
}

function shots_fired_recorder() {
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    weapon = self getcurrentweapon();

    if(!isDefined(weapon) || !isprimaryweapon(weapon)) {
      continue;
    }

    self.stats["shots_fired"]++;

    if(is_new_weapon(weapon)) {
      register_new_weapon(weapon);
    }

    self.stats["weapon"][getcompleteweaponname(weapon)].shots_fired++;
  }
}

function is_new_weapon(weapon) {
  if(isDefined(self.stats["weapon"][getcompleteweaponname(weapon)])) {
    return false;
  }

  return true;
}

function cause_is_explosive(cause) {
  cause = tolower(cause);

  switch (cause) {
    case #"hash_1991ba0f6a8cd0a2":
    case #"hash_25d762139cbf755b":
    case #"hash_3734ba2dac7b82b0":
    case #"hash_95f4dd5cd9bac6c6":
    case #"hash_e519b5a3caf0a103":
    case #"hash_fec6e5947c5a138b":
      return true;
    default:
      return false;
  }

  return false;
}

function register_new_weapon(weapon) {
  weaponname = getcompleteweaponname(weapon);
  self.stats["weapon"][weaponname] = spawnStruct();
  self.stats["weapon"][weaponname].name = weaponname;
  self.stats["weapon"][weaponname].shots_fired = 0;
  self.stats["weapon"][weaponname].shots_hit = 0;
  self.stats["weapon"][weaponname].kills = 0;
}

function set_stat_dvars() {
  playernum = 1;

  foreach(player in level.players) {
    setDvar(hashcat(@ "stats_", playernum, "_kills_melee", player.stats["kills_melee"]));
    setDvar(hashcat(@ "stats_", playernum, "_kills_juggernaut", player.stats["kills_juggernaut"]));
    setDvar(hashcat(@ "stats_", playernum, "_kills_explosives", player.stats["kills_explosives"]));
    setDvar(hashcat(@ "stats_", playernum, "_kills_vehicle", player.stats["kills_vehicle"]));
    setDvar(hashcat(@ "stats_", playernum, "_kills_sentry", player.stats["kills_sentry"]));
    weapons = player get_best_weapons(5);

    foreach(weapon in weapons) {
      weapon.accuracy = 0;

      if(weapon.shots_fired > 0) {
        weapon.accuracy = int(weapon.shots_hit / weapon.shots_fired * 100);
      }
    }

    for(i = 1; i < 6; i++) {
      setDvar(hashcat(@ "stats_", playernum, "_weapon", i, "_name"), " ");
      setDvar(hashcat(@ "stats_", playernum, "_weapon", i, "_kills"), " ");
      setDvar(hashcat(@ "stats_", playernum, "_weapon", i, "_shots"), " ");
      setDvar(hashcat(@ "stats_", playernum, "_weapon", i, "_accuracy"), " ");
    }

    for(i = 0; i < weapons.size; i++) {
      if(!isDefined(weapons[i])) {
        break;
      }

      setDvar(hashcat(@ "stats_", playernum, "_weapon", i + 1, "_name"), weapons[i].name);
      setDvar(hashcat(@ "stats_", playernum, "_weapon", i + 1, "_kills"), weapons[i].kills);
      setDvar(hashcat(@ "stats_", playernum, "_weapon", i + 1, "_shots"), weapons[i].shots_fired);
      setDvar(hashcat(@ "stats_", playernum, "_weapon", i + 1, "_accuracy"), weapons[i].accuracy + "%");
    }

    playernum++;
  }
}

function get_best_weapons(var_1391e661d0c70d36) {
  weaponstats = [];

  for(i = 0; i < var_1391e661d0c70d36; i++) {
    weaponstats[i] = get_weapon_with_most_kills(weaponstats);
  }

  return weaponstats;
}

function get_weapon_with_most_kills(excluders) {
  if(!isDefined(excluders)) {
    excluders = [];
  }

  highest = undefined;

  foreach(weapon in self.stats["weapon"]) {
    isexcluder = 0;

    foreach(excluder in excluders) {
      if(weapon.name == excluder.name) {
        isexcluder = 1;
        break;
      }
    }

    if(isexcluder) {
      continue;
    }

    if(!isDefined(highest)) {
      highest = weapon;
      continue;
    }

    if(weapon.kills > highest.kills) {
      highest = weapon;
    }
  }

  return highest;
}