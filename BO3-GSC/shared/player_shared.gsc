/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\player_shared.gsc
*************************************************/

#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace player;

function autoexec __init__sytem__() {
  system::register("player", & __init__, undefined, undefined);
}

function __init__() {
  callback::on_spawned( & on_player_spawned);
  clientfield::register("world", "gameplay_started", 4000, 1, "int");
}

function on_player_spawned() {
  mapname = getdvarstring("mapname");
  if(mapname === "core_frontend") {
    return;
  }
  if(sessionmodeiszombiesgame() || sessionmodeiscampaigngame()) {
    snappedorigin = self get_snapped_spot_origin(self.origin);
    if(!self flagsys::get("shared_igc")) {
      self setorigin(snappedorigin);
    }
  }
  ismultiplayer = !sessionmodeiszombiesgame() && !sessionmodeiscampaigngame();
  if(!ismultiplayer || (isDefined(level._enablelastvalidposition) && level._enablelastvalidposition)) {
    self thread last_valid_position();
  }
}

function last_valid_position() {
  self endon("disconnect");
  self notify("stop_last_valid_position");
  self endon("stop_last_valid_position");
  while(!isDefined(self.last_valid_position)) {
    self.last_valid_position = getclosestpointonnavmesh(self.origin, 2048, 0);
    wait(0.1);
  }
  while(true) {
    if(distance2dsquared(self.origin, self.last_valid_position) < (15 * 15) && (self.origin[2] - self.last_valid_position[2]) * (self.origin[2] - self.last_valid_position[2]) < (16 * 16)) {
      wait(0.1);
      continue;
    }
    if(isDefined(level.last_valid_position_override) && self[[level.last_valid_position_override]]()) {
      wait(0.1);
      continue;
    } else {
      if(ispointonnavmesh(self.origin, self)) {
        self.last_valid_position = self.origin;
      } else {
        if(!ispointonnavmesh(self.origin, self) && ispointonnavmesh(self.last_valid_position, self) && distance2dsquared(self.origin, self.last_valid_position) < (32 * 32)) {
          wait(0.1);
          continue;
        } else {
          position = getclosestpointonnavmesh(self.origin, 100, 15);
          if(isDefined(position)) {
            self.last_valid_position = position;
          }
        }
      }
    }
    wait(0.1);
  }
}

function take_weapons() {
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
  }
}

function generate_weapon_data() {
  self._generated_weapons = [];
  if(!isDefined(self._generated_current_weapon)) {
    self._generated_current_weapon = level.weaponnone;
  }
  if(isDefined(self.gun_removed) && self.gun_removed && isDefined(self._weapons)) {
    self._generated_weapons = arraycopy(self._weapons);
    self._generated_current_weapon = self._current_weapon;
  } else {
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
}

function give_back_weapons(b_immediate = 0) {
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
    } else if(isDefined(self.primaryloadoutweapon) && self hasweapon(self.primaryloadoutweapon)) {
      switch_to_primary_weapon(b_immediate);
    }
  }
  self._weapons = undefined;
  self.gun_removed = undefined;
}

function get_weapondata(weapon) {
  weapondata = [];
  if(!isDefined(weapon)) {
    weapon = self getcurrentweapon();
  }
  weapondata["weapon"] = weapon.name;
  if(weapon != level.weaponnone) {
    weapondata["clip"] = self getweaponammoclip(weapon);
    weapondata["stock"] = self getweaponammostock(weapon);
    weapondata["fuel"] = self getweaponammofuel(weapon);
    weapondata["heat"] = self isweaponoverheating(1, weapon);
    weapondata["overheat"] = self isweaponoverheating(0, weapon);
    weapondata["renderOptions"] = self getweaponoptions(weapon);
    weapondata["acvi"] = self getplayerattachmentcosmeticvariantindexes(weapon);
    if(weapon.isriotshield) {
      weapondata["health"] = self.weaponhealth;
    }
  } else {
    weapondata["clip"] = 0;
    weapondata["stock"] = 0;
    weapondata["fuel"] = 0;
    weapondata["heat"] = 0;
    weapondata["overheat"] = 0;
  }
  if(weapon.dualwieldweapon != level.weaponnone) {
    weapondata["lh_clip"] = self getweaponammoclip(weapon.dualwieldweapon);
  } else {
    weapondata["lh_clip"] = 0;
  }
  if(weapon.altweapon != level.weaponnone) {
    weapondata["alt_clip"] = self getweaponammoclip(weapon.altweapon);
    weapondata["alt_stock"] = self getweaponammostock(weapon.altweapon);
  } else {
    weapondata["alt_clip"] = 0;
    weapondata["alt_stock"] = 0;
  }
  return weapondata;
}

function weapondata_give(weapondata) {
  weapon = util::get_weapon_by_name(weapondata["weapon"]);
  self giveweapon(weapon, weapondata["renderOptions"], weapondata["acvi"]);
  if(weapon != level.weaponnone) {
    self setweaponammoclip(weapon, weapondata["clip"]);
    self setweaponammostock(weapon, weapondata["stock"]);
    if(isDefined(weapondata["fuel"])) {
      self setweaponammofuel(weapon, weapondata["fuel"]);
    }
    if(isDefined(weapondata["heat"]) && isDefined(weapondata["overheat"])) {
      self setweaponoverheating(weapondata["overheat"], weapondata["heat"], weapon);
    }
    if(weapon.isriotshield && isDefined(weapondata["health"])) {
      self.weaponhealth = weapondata["health"];
    }
  }
  if(weapon.dualwieldweapon != level.weaponnone) {
    self setweaponammoclip(weapon.dualwieldweapon, weapondata["lh_clip"]);
  }
  if(weapon.altweapon != level.weaponnone) {
    self setweaponammoclip(weapon.altweapon, weapondata["alt_clip"]);
    self setweaponammostock(weapon.altweapon, weapondata["alt_stock"]);
  }
}

function switch_to_primary_weapon(b_immediate = 0) {
  if(is_valid_weapon(self.primaryloadoutweapon)) {
    if(b_immediate) {
      self switchtoweaponimmediate(self.primaryloadoutweapon);
    } else {
      self switchtoweapon(self.primaryloadoutweapon);
    }
  }
}

function fill_current_clip() {
  w_current = self getcurrentweapon();
  if(w_current.isheroweapon) {
    w_current = self.primaryloadoutweapon;
  }
  if(isDefined(w_current) && self hasweapon(w_current)) {
    self setweaponammoclip(w_current, w_current.clipsize);
  }
}

function is_valid_weapon(weaponobject) {
  return isDefined(weaponobject) && weaponobject != level.weaponnone;
}

function is_spawn_protected() {
  return (gettime() - (isDefined(self.spawntime) ? self.spawntime : 0)) <= level.spawnprotectiontimems;
}

function simple_respawn() {
  self[[level.onspawnplayer]](0);
}

function get_snapped_spot_origin(spot_position) {
  snap_max_height = 100;
  size = 15;
  height = size * 2;
  mins = (-1 * size, -1 * size, 0);
  maxs = (size, size, height);
  spot_position = (spot_position[0], spot_position[1], spot_position[2] + 5);
  new_spot_position = (spot_position[0], spot_position[1], spot_position[2] - snap_max_height);
  trace = physicstrace(spot_position, new_spot_position, mins, maxs, self);
  if(trace["fraction"] < 1) {
    return trace["position"];
  }
  return spot_position;
}

function allow_stance_change(b_allow = 1) {
  if(b_allow) {
    self allowprone(1);
    self allowcrouch(1);
    self allowstand(1);
  } else {
    str_stance = self getstance();
    switch (str_stance) {
      case "prone": {
        self allowprone(1);
        self allowcrouch(0);
        self allowstand(0);
        break;
      }
      case "crouch": {
        self allowprone(0);
        self allowcrouch(1);
        self allowstand(0);
        break;
      }
      case "stand": {
        self allowprone(0);
        self allowcrouch(0);
        self allowstand(1);
        break;
      }
    }
  }
}