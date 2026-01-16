/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\player\player_shared.gsc
************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\player\player_loadout;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace player;

autoexec __init__system__() {
  system::register(#"player", &__init__, undefined, undefined);
}

__init__() {
  callback::on_spawned(&on_player_spawned);
  clientfield::register("world", "gameplay_started", 1, 1, "int");
  clientfield::register("toplayer", "gameplay_allows_deploy", 1, 1, "int");
  clientfield::register("toplayer", "player_dof_settings", 1, 2, "int");
  setdvar(#"hash_256144ebda864b87", 1);

  if(!isDefined(getdvarint(#"hash_8351525729015ab", 0))) {
    setdvar(#"hash_8351525729015ab", 0);
  }
}

spawn_player() {
  self endon(#"disconnect", #"joined_spectators");
  self notify(#"spawned");
  level notify(#"player_spawned");
  self notify(#"end_respawn");
  self set_spawn_variables();
  self luinotifyevent(#"player_spawned", 0);
  self function_b552ffa9(#"player_spawned", 0);
  self setclientuivisibilityflag("killcam_nemesis", 0);
  self.sessionteam = self.team;
  function_73646bd9(self);
  self.sessionstate = "playing";
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.spectatekillcam = 0;
  self.statusicon = "";
  self.damagedplayers = [];
  self.friendlydamage = undefined;
  self.hasspawned = 1;
  self.lastspawntime = gettime();
  self.spawntime = gettime();
  self.afk = 0;
  self.laststunnedby = undefined;
  self.var_a010bd8f = undefined;
  self.var_9060b065 = undefined;
  self.lastflashedby = undefined;
  self.var_a7679005 = undefined;
  self.var_7ef2427c = undefined;
  self.var_e021fe43 = undefined;
  self.var_f866f320 = undefined;
  self.laststand = undefined;
  self.resurrect_not_allowed_by = undefined;
  self.revivingteammate = 0;
  self.burning = undefined;
  self.lastshotby = 127;
  self.maxhealth = self.spawnhealth;
  self.health = self.maxhealth;
  self function_9080887a();

  if(self.pers[#"lives"] && !(isDefined(level.takelivesondeath) && level.takelivesondeath)) {
    self.pers[#"lives"]--;
  }

  if(isDefined(game.lives) && isDefined(game.lives[self.team]) && game.lives[self.team] && !(isDefined(level.takelivesondeath) && level.takelivesondeath)) {
    game.lives[self.team]--;
  }

  self.disabledweapon = 0;
  self util::resetusability();
  self reset_attacker_list();
  self resetfov();
}

on_player_spawned() {
  if(util::is_frontend_map()) {
    return;
  }

  level.var_2386648b = 0;

  if(sessionmodeiszombiesgame() || sessionmodeiscampaigngame()) {
    snappedorigin = self get_snapped_spot_origin(self.origin);

    if(!self flagsys::get(#"shared_igc")) {
      self setorigin(snappedorigin);
    }

    update_rate = 0.1;
  }

  if(sessionmodeiswarzonegame()) {
    update_rate = 0.4;
    level.var_2386648b = 1;
  }

  if(isDefined(update_rate)) {
    self thread last_valid_position(update_rate);
  }
}

last_valid_position(update_rate) {
  self notify(#"stop_last_valid_position");
  self endon(#"stop_last_valid_position", #"disconnect");

  while(!isDefined(self.last_valid_position)) {
    self.last_valid_position = getclosestpointonnavmesh(self.origin, 2048, 0);
    wait update_rate;
  }

  while(isDefined(self)) {
    if(isDefined(level.var_cdc822b) && ![
        [level.var_cdc822b]
      ]()) {
      wait update_rate;
      continue;
    }

    playerradius = self getpathfindingradius();

    if(distance2dsquared(self.origin, self.last_valid_position) < playerradius * playerradius && (self.origin[2] - self.last_valid_position[2]) * (self.origin[2] - self.last_valid_position[2]) < 16 * 16) {
      wait update_rate;
      continue;
    }

    if(self isplayerswimming()) {
      if(isDefined(self.var_5d991645)) {
        if(distancesquared(self.origin, self.var_5d991645) < playerradius * playerradius) {
          wait update_rate;
          continue;
        }
      }

      ground_pos = groundtrace(self.origin + (0, 0, 8), self.origin + (0, 0, -100000), 0, self)[#"position"];

      if(!isDefined(ground_pos)) {
        wait update_rate;
        continue;
      }

      position = getclosestpointonnavmesh(ground_pos, 100, playerradius);

      if(isDefined(position)) {
        self.last_valid_position = position;
        self.var_5d991645 = self.origin;
      }
    } else if(ispointonnavmesh(self.origin, self)) {
      self.last_valid_position = self.origin;
    } else if(!ispointonnavmesh(self.origin, self) && ispointonnavmesh(self.last_valid_position, self) && distance2dsquared(self.origin, self.last_valid_position) < 32 * 32 && (self.origin[2] - self.last_valid_position[2]) * (self.origin[2] - self.last_valid_position[2]) < 32 * 32) {
      wait update_rate;
      continue;
    } else {
      position = getclosestpointonnavmesh(self.origin, 100, playerradius);

      if(isDefined(position)) {
        if(isDefined(level.var_2386648b) && level.var_2386648b) {
          player_position = self.origin + (0, 0, 20);
          var_f5df51f2 = position + (0, 0, 20);
          player_vehicle = undefined;

          if(isvehicle(self getgroundent())) {
            player_vehicle = self getgroundent();
          }

          if(bullettracepassed(player_position, var_f5df51f2, 0, self, player_vehicle)) {
            self.last_valid_position = position;
          }
        } else {
          self.last_valid_position = position;
        }
      } else if(isDefined(level.var_a6a84389)) {
        self.last_valid_position = self[[level.var_a6a84389]](playerradius);
      }
    }

    wait update_rate;
  }
}

take_weapons() {
  if(!(isDefined(self.gun_removed) && self.gun_removed)) {
    self.gun_removed = 1;
    self._weapons = [];

    if(!isDefined(self._current_weapon)) {
      self._current_weapon = level.weaponnone;
    }

    w_current = self getcurrentweapon();

    if(w_current != level.weaponnone) {
      self._current_weapon = w_current;
    }

    a_weapon_list = self getweaponslist();

    if(self._current_weapon == level.weaponnone) {
      if(isDefined(a_weapon_list[0])) {
        self._current_weapon = a_weapon_list[0];
      }
    }

    foreach(weapon in a_weapon_list) {
      if(isDefined(weapon.dniweapon) && weapon.dniweapon) {
        continue;
      }

      if(!isDefined(self._weapons)) {
        self._weapons = [];
      } else if(!isarray(self._weapons)) {
        self._weapons = array(self._weapons);
      }

      self._weapons[self._weapons.size] = get_weapondata(weapon);
      self takeweapon(weapon);
    }

    if(isDefined(level.detach_all_weapons)) {
      self[[level.detach_all_weapons]]();
    }
  }
}

generate_weapon_data() {
  self._generated_weapons = [];

  if(!isDefined(self._generated_current_weapon)) {
    self._generated_current_weapon = level.weaponnone;
  }

  if(isDefined(self.gun_removed) && self.gun_removed && isDefined(self._weapons)) {
    self._generated_weapons = arraycopy(self._weapons);
    self._generated_current_weapon = self._current_weapon;
    return;
  }

  w_current = self getcurrentweapon();

  if(w_current != level.weaponnone) {
    self._generated_current_weapon = w_current;
  }

  a_weapon_list = self getweaponslist();

  if(self._generated_current_weapon == level.weaponnone) {
    if(isDefined(a_weapon_list[0])) {
      self._generated_current_weapon = a_weapon_list[0];
    }
  }

  foreach(weapon in a_weapon_list) {
    if(isDefined(weapon.dniweapon) && weapon.dniweapon) {
      continue;
    }

    if(!isDefined(self._generated_weapons)) {
      self._generated_weapons = [];
    } else if(!isarray(self._generated_weapons)) {
      self._generated_weapons = array(self._generated_weapons);
    }

    self._generated_weapons[self._generated_weapons.size] = get_weapondata(weapon);
  }
}

give_back_weapons(b_immediate = 0) {
  if(isDefined(self._weapons)) {
    foreach(weapondata in self._weapons) {
      weapondata_give(weapondata);
    }

    if(isDefined(self._current_weapon) && self._current_weapon != level.weaponnone) {
      if(b_immediate) {
        self switchtoweaponimmediate(self._current_weapon);
      } else {
        self switchtoweapon(self._current_weapon);
      }
    } else {
      weapon = self loadout::function_18a77b37("primary");

      if(isDefined(weapon) && self hasweapon(weapon)) {
        switch_to_primary_weapon(b_immediate);
      }
    }
  }

  self._weapons = undefined;
  self.gun_removed = undefined;
}

get_weapondata(weapon) {
  if(isDefined(level.var_51443ce5)) {
    return self[[level.var_51443ce5]](weapon);
  }

  weapondata = [];

  if(!isDefined(weapon)) {
    weapon = self getcurrentweapon();
  }

  weapondata[#"weapon"] = weapon.rootweapon.name;
  weapondata[#"attachments"] = util::function_2146bd83(weapon);

  if(weapon != level.weaponnone) {
    weapondata[#"clip"] = self getweaponammoclip(weapon);
    weapondata[#"stock"] = self getweaponammostock(weapon);
    weapondata[#"fuel"] = self getweaponammofuel(weapon);
    weapondata[#"heat"] = self isweaponoverheating(1, weapon);
    weapondata[#"overheat"] = self isweaponoverheating(0, weapon);
    weapondata[#"renderoptions"] = self getweaponoptions(weapon);

    if(weapon.isriotshield) {
      weapondata[#"health"] = self.weaponhealth;
    }
  } else {
    weapondata[#"clip"] = 0;
    weapondata[#"stock"] = 0;
    weapondata[#"fuel"] = 0;
    weapondata[#"heat"] = 0;
    weapondata[#"overheat"] = 0;
  }

  if(weapon.dualwieldweapon != level.weaponnone) {
    weapondata[#"lh_clip"] = self getweaponammoclip(weapon.dualwieldweapon);
  } else {
    weapondata[#"lh_clip"] = 0;
  }

  if(weapon.altweapon != level.weaponnone) {
    weapondata[#"alt_clip"] = self getweaponammoclip(weapon.altweapon);
    weapondata[#"alt_stock"] = self getweaponammostock(weapon.altweapon);
  } else {
    weapondata[#"alt_clip"] = 0;
    weapondata[#"alt_stock"] = 0;
  }

  return weapondata;
}

weapondata_give(weapondata) {
  if(isDefined(level.var_bfbdc0cd)) {
    self[[level.var_bfbdc0cd]](weapondata);
    return;
  }

  weapon = util::get_weapon_by_name(weapondata[#"weapon"], weapondata[#"attachments"]);
  self giveweapon(weapon, weapondata[#"renderoptions"]);

  if(weapon != level.weaponnone) {
    self setweaponammoclip(weapon, weapondata[#"clip"]);
    self setweaponammostock(weapon, weapondata[#"stock"]);

    if(isDefined(weapondata[#"fuel"])) {
      self setweaponammofuel(weapon, weapondata[#"fuel"]);
    }

    if(isDefined(weapondata[#"heat"]) && isDefined(weapondata[#"overheat"])) {
      self setweaponoverheating(weapondata[#"overheat"], weapondata[#"heat"], weapon);
    }

    if(weapon.isriotshield && isDefined(weapondata[#"health"])) {
      self.weaponhealth = weapondata[#"health"];
    }
  }

  if(weapon.dualwieldweapon != level.weaponnone) {
    self setweaponammoclip(weapon.dualwieldweapon, weapondata[#"lh_clip"]);
  }

  if(weapon.altweapon != level.weaponnone) {
    self setweaponammoclip(weapon.altweapon, weapondata[#"alt_clip"]);
    self setweaponammostock(weapon.altweapon, weapondata[#"alt_stock"]);
  }
}

switch_to_primary_weapon(b_immediate = 0) {
  weapon = self loadout::function_18a77b37("primary");

  if(is_valid_weapon(weapon)) {
    if(b_immediate) {
      self switchtoweaponimmediate(weapon);
      return;
    }

    self switchtoweapon(weapon);
  }
}

function_1bff13a1(b_immediate = 0) {
  weapon = self loadout::function_18a77b37("secondary");

  if(is_valid_weapon(weapon)) {
    if(b_immediate) {
      self switchtoweaponimmediate(weapon);
      return;
    }

    self switchtoweapon(weapon);
  }
}

fill_current_clip() {
  w_current = self getcurrentweapon();

  if(w_current.isheavyweapon) {
    w_current = self loadout::function_18a77b37("primary");
  }

  if(isDefined(w_current) && self hasweapon(w_current)) {
    self setweaponammoclip(w_current, w_current.clipsize);
  }
}

is_valid_weapon(weaponobject) {
  return isDefined(weaponobject) && weaponobject != level.weaponnone;
}

is_spawn_protected() {
  if(!isDefined(self)) {
    return false;
  }

  if(!isDefined(self.spawntime)) {
    self.spawntime = 0;
  }

  if(!isDefined(level.spawnprotectiontimems)) {
    level.spawnprotectiontimems = int((isDefined(level.spawnprotectiontime) ? level.spawnprotectiontime : 0) * 1000);
  }

  return gettime() - (isDefined(self.spawntime) ? self.spawntime : 0) <= level.spawnprotectiontimems;
}

simple_respawn() {
  self[[level.onspawnplayer]](0);
}

get_snapped_spot_origin(spot_position) {
  snap_max_height = 100;
  size = 15;
  height = size * 2;
  mins = (-1 * size, -1 * size, 0);
  maxs = (size, size, height);
  spot_position = (spot_position[0], spot_position[1], spot_position[2] + 5);
  new_spot_position = (spot_position[0], spot_position[1], spot_position[2] - snap_max_height);
  trace = physicstrace(spot_position, new_spot_position, mins, maxs, self);

  if(trace[#"fraction"] < 1) {
    return trace[#"position"];
  }

  return spot_position;
}

allow_stance_change(b_allow = 1) {
  if(b_allow) {
    self allowprone(1);
    self allowcrouch(1);
    self allowstand(1);
    return;
  }

  str_stance = self getstance();

  switch (str_stance) {
    case #"prone":
      self allowprone(1);
      self allowcrouch(0);
      self allowstand(0);
      break;
    case #"crouch":
      self allowprone(0);
      self allowcrouch(1);
      self allowstand(0);
      break;
    case #"stand":
      self allowprone(0);
      self allowcrouch(0);
      self allowstand(1);
      break;
  }
}

set_spawn_variables() {
  resettimeout();
  self stopshellshock();
  self stoprumble("damage_heavy");
}

reset_attacker_list() {
  self.attackers = [];
  self.attackerdata = [];
  self.attackerdamage = [];
  self.var_6ef09a14 = [];
  self.firsttimedamaged = 0;
}

function_9080887a(var_cf05ebb7) {
  if(!isDefined(self.var_894f7879)) {
    self.var_894f7879 = [];
  }

  var_f7d37aa4 = 0;

  foreach(modifier in self.var_894f7879) {
    var_f7d37aa4 += modifier;
  }

  basemaxhealth = isDefined(var_cf05ebb7) ? var_cf05ebb7 : self.spawnhealth;
  self.var_66cb03ad = int(basemaxhealth + var_f7d37aa4 + (isDefined(level.var_90bb9821) ? level.var_90bb9821 : 0));

  if(self.var_66cb03ad < 1) {
    self.var_66cb03ad = 1;
  }
}

function_d1768e8e() {
  self notify(#"fully_healed");
  callback::callback(#"fully_healed");
}

function_c6fe9951() {
  self notify(#"done_healing");
  callback::callback(#"done_healing");
}

function_2a67df65(modname, value, var_96a9fbf4, var_b861a047) {
  if(!isDefined(self.var_894f7879)) {
    self.var_894f7879 = [];
  }

  self function_74598aba(var_96a9fbf4);
  can_modify = 1;

  if(level.wound_disabled === 1 && value < 0) {
    can_modify = 0;
  }

  if(can_modify) {
    self.var_894f7879[modname] = value;
  }

  self function_9080887a();

  if(!(isDefined(var_b861a047) && var_b861a047)) {
    self function_b2b139e6();
  }
}

function_b2b139e6() {
  if(isDefined(self.var_abe2db87)) {
    return;
  }

  if(self.health > self.var_66cb03ad) {
    self.health = self.var_66cb03ad;
    self function_d1768e8e();
  }
}

function_b933de24(modname, var_b861a047) {
  if(isDefined(self)) {
    if(!isDefined(self.var_894f7879)) {
      self.var_894f7879 = [];
    }

    var_d87cedce = self.var_66cb03ad;
    self.var_894f7879[modname] = undefined;
    self function_9080887a();

    if(!(isDefined(var_b861a047) && var_b861a047)) {
      self function_b2b139e6();
    }
  }
}

function_74598aba(var_96a9fbf4) {
  if(!isDefined(var_96a9fbf4)) {
    return;
  }

  foreach(modifier in var_96a9fbf4) {
    if(!isDefined(modifier)) {
      continue;
    }

    self function_b933de24(modifier.name, modifier.var_b861a047);
  }
}

function_466d8a4b(var_b66879ad, team) {
  params = {
    #team: team, 
    #var_b66879ad: var_b66879ad
  };
  self notify(#"joined_team", params);
  level notify(#"joined_team");
  self callback::callback(#"joined_team", params);
}

function_6f6c29e(var_b66879ad) {
  params = {
    #team: #"spectator", 
    #var_b66879ad: var_b66879ad
  };
  self notify(#"joined_spectator", params);
  level notify(#"joined_spectator");
  self callback::callback(#"on_joined_spectator", params);
}

function_2f80d95b(player_func, ...) {
  players = level.players;

  foreach(player in players) {
    util::single_func_argarray(player, player_func, vararg);
  }
}

function_4dcd9a89(players, player_func, ...) {
  foreach(player in players) {
    util::single_func_argarray(player, player_func, vararg);
  }
}

function_7629df88(team, player_func, ...) {
  players = level.players;

  foreach(player in players) {
    if(player.team == team) {
      util::single_func_argarray(player, player_func, vararg);
    }
  }
}

function_e7f18b20(player_func, ...) {
  players = level.players;

  foreach(player in players) {
    if(!isDefined(player.pers[#"team"])) {
      continue;
    }

    util::single_func_argarray(player, player_func, vararg);
  }
}

function_38de2d5a(notification) {
  players = level.players;

  foreach(player in players) {
    player notify(notification);
  }
}

init_heal(var_cd7b9255, var_e9c4ebeb) {
  var_84d04e6 = {
    #enabled: var_cd7b9255, 
    #rate: 0, 
    #var_bc840360: 0, 
    #var_c8777194: var_e9c4ebeb, 
    #var_b8c7d886: 0, 
    #var_a1cac2f1: 0
  };

  if(!isDefined(self.heal)) {
    self.heal = var_84d04e6;
  }

  if(!isDefined(self.var_66cb03ad)) {
    self.var_66cb03ad = self.maxhealth;
  }
}

figure_out_attacker(eattacker) {
  if(isDefined(eattacker) && !isplayer(eattacker)) {
    team = self.team;

    if(isDefined(eattacker.script_owner)) {
      if(util::function_fbce7263(eattacker.script_owner.team, team)) {
        eattacker = eattacker.script_owner;
      }
    }

    if(isDefined(eattacker.owner)) {
      eattacker = eattacker.owner;
    }

    if(isDefined(eattacker.var_97f1b32a) && eattacker.var_97f1b32a && isDefined(level.var_6ed50229)) {
      assert(isvehicle(eattacker));

      if(isvehicle(eattacker) && isDefined(eattacker.var_735382e) && isDefined(eattacker.var_a816f2cd)) {
        driver = eattacker getseatoccupant(0);

        if(!isDefined(driver)) {
          currenttime = gettime();

          if(currenttime - eattacker.var_a816f2cd <= int(level.var_6ed50229 * 1000)) {
            eattacker = eattacker.var_735382e;
          }
        }
      }
    }
  }

  return eattacker;
}

function_4ca4d8c6(string, value) {
  assert(isDefined(string), "<dev string:x38>");

  if(isDefined(self) && isDefined(self.pers)) {
    self.pers[string] = value;
  }
}

function_2abc116(string, defaultval) {
  assert(isDefined(string), "<dev string:x38>");

  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers[string])) {
    return self.pers[string];
  }

  return defaultval;
}