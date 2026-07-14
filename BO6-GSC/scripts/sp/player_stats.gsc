/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\player_stats.gsc
***************************************/

#using scripts\engine\utility;
#using scripts\sp\utility;
#namespace player_stats;

function init_stats() {
  self.stats["E\xb9\xf4j\x0f"] = 0;
  self.stats["\x81~\xed\xac\xfe\xb8\b&\xb6\xa96"] = 0;
  self.stats["\xb6i\xb16\x9b\xaf\x95\xf0\a\xc6\xde\x9b\xa5g\xcas"] = 0;
  self.stats["\xf5\x89\xb4\x11\xb7\xaehR\x1eZ\xc5\xc3\x16\x88\xb9\x89"] = 0;
  self.stats["\xf4\x04s}a1B\xf0\xa0\xfe\xcel\xb4"] = 0;
  self.stats["\x12\x92\xb10_?\x7f\xa7\xdf\xefL\x83"] = 0;
  self.stats["\x86\xb2\x16\x8c\xcdC\xde\x1ds"] = 0;
  self.stats["\xe6\r\xdb\xa3\xdc\xfa\xcci\xc9V\x8c"] = 0;
  self.stats["\x05\xb1\xc8\xa2W\x8a\xba\xab8"] = 0;
  self.stats["\xe5\x06\xb0\bE\x16"] = [];
  thread shots_fired_recorder();
}

function was_headshot() {
  if(isDefined(self.died_of_headshot) && self.died_of_headshot) {
    return true;
  }

  if(!isDefined(self.damagelocation)) {
    return false;
  }

  return self.damagelocation == "\xebe\xe3\x82S\x14" || self.damagelocation == "\x83\xe2\x11D" || self.damagelocation == "\xcd\xca\xd8k";
}

function register_kill(killedent, cause, weaponname, killtype) {
  assert(isDefined(cause), "<dev string:x24>");
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

  player.stats["E\xb9\xf4j\x0f"]++;

  if(isDefined(killedent)) {
    if(killedent was_headshot()) {
      player.stats["\x86\xb2\x16\x8c\xcdC\xde\x1ds"]++;
    }

    if(isDefined(killedent.juggernaut)) {
      player.stats["\xf5\x89\xb4\x11\xb7\xaehR\x1eZ\xc5\xc3\x16\x88\xb9\x89"]++;
    }

    if(isDefined(killedent.issentrygun)) {
      player.stats["\x12\x92\xb10_?\x7f\xa7\xdf\xefL\x83"]++;
    }

    if(killedent.code_classname == "\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e") {
      player.stats["\xf4\x04s}a1B\xf0\xa0\xfe\xcel\xb4"]++;

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
    player.stats["\xb6i\xb16\x9b\xaf\x95\xf0\a\xc6\xde\x9b\xa5g\xcas"]++;
  }

  if(isDefined(weaponname)) {
    weapon = utility::function_3aac010105913843(weaponname);
  } else {
    weapon = player getcurrentweapon();
  }

  if(issubstr(tolower(cause), "mV\x8d+e")) {
    player.stats["\x81~\xed\xac\xfe\xb8\b&\xb6\xa96"]++;

    if(weaponinventorytype(weapon) == "\xe6\xaa6=\x93`Y") {
      return;
    }
  }

  assert(isDefined(weapon));

  if(player is_new_weapon(weapon)) {
    player register_new_weapon(weapon);
  }

  player.stats["\xe5\x06\xb0\bE\x16"][getcompleteweaponname(weapon)].kills++;
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
  self.stats["\x05\xb1\xc8\xa2W\x8a\xba\xab8"]++;
  weapon = self getcurrentweapon();
  assert(isDefined(weapon));

  if(is_new_weapon(weapon)) {
    register_new_weapon(weapon);
  }

  self.stats["\xe5\x06\xb0\bE\x16"][getcompleteweaponname(weapon)].shots_hit++;
  waittillframeend();
  self.registeringshothit = undefined;
}

function shots_fired_recorder() {
  self endon("\x1e\xfd\xd1\xa2\a");

  for(;;) {
    self waittill("9\xfca\xad\f^Rj.\xe6\xc6$");
    weapon = self getcurrentweapon();

    if(!isDefined(weapon) || !utility_sp::isprimaryweapon(weapon)) {
      continue;
    }

    self.stats["\xe6\r\xdb\xa3\xdc\xfa\xcci\xc9V\x8c"]++;

    if(is_new_weapon(weapon)) {
      register_new_weapon(weapon);
    }

    self.stats["\xe5\x06\xb0\bE\x16"][getcompleteweaponname(weapon)].shots_fired++;
  }
}

function is_new_weapon(weapon) {
  if(isDefined(self.stats["\xe5\x06\xb0\bE\x16"][getcompleteweaponname(weapon)])) {
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
  self.stats["\xe5\x06\xb0\bE\x16"][weaponname] = spawnStruct();
  self.stats["\xe5\x06\xb0\bE\x16"][weaponname].name = weaponname;
  self.stats["\xe5\x06\xb0\bE\x16"][weaponname].shots_fired = 0;
  self.stats["\xe5\x06\xb0\bE\x16"][weaponname].shots_hit = 0;
  self.stats["\xe5\x06\xb0\bE\x16"][weaponname].kills = 0;
}

function set_stat_dvars() {
  playernum = 1;

  foreach(player in level.players) {
    setDvar(hashcat(@ "stats_", playernum, "q\x9d\x9a\xb3\xb8A\xef\xa0\xc66N\xce", player.stats["\x81~\xed\xac\xfe\xb8\b&\xb6\xa96"]));
    setDvar(hashcat(@ "stats_", playernum, "{j\xf8\xb9\x94F1\xe1\x14{\xe9\xcf\bl\xafS\f", player.stats["\xf5\x89\xb4\x11\xb7\xaehR\x1eZ\xc5\xc3\x16\x88\xb9\x89"]));
    setDvar(hashcat(@ "stats_", playernum, "v\xe7\x82\t2\x06:qn9\x9a\xa1t=\x89\x13\x0f", player.stats["\xb6i\xb16\x9b\xaf\x95\xf0\a\xc6\xde\x9b\xa5g\xcas"]));
    setDvar(hashcat(@ "stats_", playernum, "\x9b\xb9WAz\xb4a\x99\xd1\xaa\xe2YJL", player.stats["\xf4\x04s}a1B\xf0\xa0\xfe\xcel\xb4"]));
    setDvar(hashcat(@ "stats_", playernum, "\xa3dEx-\n\xa7_x\x96~+%", player.stats["\x12\x92\xb10_?\x7f\xa7\xdf\xefL\x83"]));
    weapons = player get_best_weapons(5);

    foreach(weapon in weapons) {
      weapon.accuracy = 0;

      if(weapon.shots_fired > 0) {
        weapon.accuracy = int(weapon.shots_hit / weapon.shots_fired * 100);
      }
    }

    for(i = 1; i < 6; i++) {
      setDvar(hashcat(@ "stats_", playernum, "9\xb3\x9f\v\xc3o\xb6", i, "\xbe\xb9\x16ke"), "\xda");
      setDvar(hashcat(@ "stats_", playernum, "9\xb3\x9f\v\xc3o\xb6", i, "\xb5\xeb\x1e\x93\x93\x80"), "\xda");
      setDvar(hashcat(@ "stats_", playernum, "9\xb3\x9f\v\xc3o\xb6", i, "\xaf\xe64\xde\xe8\xb9"), "\xda");
      setDvar(hashcat(@ "stats_", playernum, "9\xb3\x9f\v\xc3o\xb6", i, "&[,\\{b\x06eM"), "\xda");
    }

    for(i = 0; i < weapons.size; i++) {
      if(!isDefined(weapons[i])) {
        break;
      }

      setDvar(hashcat(@ "stats_", playernum, "9\xb3\x9f\v\xc3o\xb6", i + 1, "\xbe\xb9\x16ke"), weapons[i].name);
      setDvar(hashcat(@ "stats_", playernum, "9\xb3\x9f\v\xc3o\xb6", i + 1, "\xb5\xeb\x1e\x93\x93\x80"), weapons[i].kills);
      setDvar(hashcat(@ "stats_", playernum, "9\xb3\x9f\v\xc3o\xb6", i + 1, "\xaf\xe64\xde\xe8\xb9"), weapons[i].shots_fired);
      setDvar(hashcat(@ "stats_", playernum, "9\xb3\x9f\v\xc3o\xb6", i + 1, "&[,\\{b\x06eM"), weapons[i].accuracy + "\xa8");
    }

    playernum++;
  }
}

function get_best_weapons(var_8d579d340f67bc4b) {
  weaponstats = [];

  for(i = 0; i < var_8d579d340f67bc4b; i++) {
    weaponstats[i] = get_weapon_with_most_kills(weaponstats);
  }

  return weaponstats;
}

function get_weapon_with_most_kills(excluders) {
  if(!isDefined(excluders)) {
    excluders = [];
  }

  highest = undefined;

  foreach(weapon in self.stats["\xe5\x06\xb0\bE\x16"]) {
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