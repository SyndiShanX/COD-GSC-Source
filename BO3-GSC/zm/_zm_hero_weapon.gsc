/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_hero_weapon.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_hero_weapon;

function autoexec __init__sytem__() {
  system::register("zm_hero_weapons", & __init__, undefined, undefined);
}

function __init__() {
  if(!isDefined(level._hero_weapons)) {
    level._hero_weapons = [];
  }
  callback::on_spawned( & on_player_spawned);
  level.hero_power_update = & hero_power_event_callback;
  ability_player::register_gadget_activation_callbacks(14, & gadget_hero_weapon_on_activate, & gadget_hero_weapon_on_off);
}

function gadget_hero_weapon_on_activate(slot, weapon) {}

function gadget_hero_weapon_on_off(slot, weapon) {
  self thread watch_for_glitches(slot, weapon);
}

function watch_for_glitches(slot, weapon) {
  wait(1);
  if(isDefined(self)) {
    w_current = self getcurrentweapon();
    if(isDefined(w_current) && zm_utility::is_hero_weapon(w_current)) {
      self.hero_power = self gadgetpowerget(0);
      if(self.hero_power <= 0) {
        zm_weapons::switch_back_primary_weapon(undefined, 1);
        self.i_tried_to_glitch_the_hero_weapon = 1;
      }
    }
  }
}

function register_hero_weapon(weapon_name) {
  weaponnone = getweapon("none");
  weapon = getweapon(weapon_name);
  if(weapon != weaponnone) {
    hero_weapon = spawnStruct();
    hero_weapon.weapon = weapon;
    hero_weapon.give_fn = & default_give;
    hero_weapon.take_fn = & default_take;
    hero_weapon.wield_fn = & default_wield;
    hero_weapon.unwield_fn = & default_unwield;
    hero_weapon.power_full_fn = & default_power_full;
    hero_weapon.power_empty_fn = & default_power_empty;
    if(!isDefined(level._hero_weapons)) {
      level._hero_weapons = [];
    }
    level._hero_weapons[weapon] = hero_weapon;
    zm_utility::register_hero_weapon_for_level(weapon_name);
  }
}

function register_hero_weapon_give_take_callbacks(weapon_name, give_fn = & default_give, take_fn = & default_take) {
  weaponnone = getweapon("none");
  weapon = getweapon(weapon_name);
  if(weapon != weaponnone && isDefined(level._hero_weapons[weapon])) {
    level._hero_weapons[weapon].give_fn = give_fn;
    level._hero_weapons[weapon].take_fn = take_fn;
  }
}

function default_give(weapon) {
  power = self gadgetpowerget(0);
  if(power < 100) {
    self set_hero_weapon_state(weapon, 1);
  } else {
    self set_hero_weapon_state(weapon, 2);
  }
}

function default_take(weapon) {
  self set_hero_weapon_state(weapon, 0);
}

function register_hero_weapon_wield_unwield_callbacks(weapon_name, wield_fn = & default_wield, unwield_fn = & default_unwield) {
  weaponnone = getweapon("none");
  weapon = getweapon(weapon_name);
  if(weapon != weaponnone && isDefined(level._hero_weapons[weapon])) {
    level._hero_weapons[weapon].wield_fn = wield_fn;
    level._hero_weapons[weapon].unwield_fn = unwield_fn;
  }
}

function default_wield(weapon) {
  self set_hero_weapon_state(weapon, 3);
}

function default_unwield(weapon) {
  self set_hero_weapon_state(weapon, 1);
}

function register_hero_weapon_power_callbacks(weapon_name, power_full_fn = & default_power_full, power_empty_fn = & default_power_empty) {
  weaponnone = getweapon("none");
  weapon = getweapon(weapon_name);
  if(weapon != weaponnone && isDefined(level._hero_weapons[weapon])) {
    level._hero_weapons[weapon].power_full_fn = power_full_fn;
    level._hero_weapons[weapon].power_empty_fn = power_empty_fn;
  }
}

function default_power_full(weapon) {
  self set_hero_weapon_state(weapon, 2);
  self thread zm_equipment::show_hint_text(&"ZOMBIE_HERO_WEAPON_HINT", 2);
}

function default_power_empty(weapon) {
  self set_hero_weapon_state(weapon, 1);
}

function set_hero_weapon_state(w_weapon, state) {
  self.hero_weapon_state = state;
  self clientfield::set_player_uimodel("zmhud.swordState", state);
}

function on_player_spawned() {
  self set_hero_weapon_state(undefined, 0);
  self thread watch_hero_weapon_give();
  self thread watch_hero_weapon_take();
  self thread watch_hero_weapon_change();
}

function watch_hero_weapon_give() {
  self notify("watch_hero_weapon_give");
  self endon("watch_hero_weapon_give");
  self endon("disconnect");
  while(true) {
    self waittill("weapon_give", w_weapon);
    if(isDefined(w_weapon) && zm_utility::is_hero_weapon(w_weapon)) {
      self thread watch_hero_power(w_weapon);
      self[[level._hero_weapons[w_weapon].give_fn]](w_weapon);
    }
  }
}

function watch_hero_weapon_take() {
  self notify("watch_hero_weapon_take");
  self endon("watch_hero_weapon_take");
  self endon("disconnect");
  while(true) {
    self waittill("weapon_take", w_weapon);
    if(isDefined(w_weapon) && zm_utility::is_hero_weapon(w_weapon)) {
      self[[level._hero_weapons[w_weapon].take_fn]](w_weapon);
      self notify("stop_watch_hero_power");
    }
  }
}

function watch_hero_weapon_change() {
  self notify("watch_hero_weapon_change");
  self endon("watch_hero_weapon_change");
  self endon("disconnect");
  while(true) {
    self waittill("weapon_change", w_current, w_previous);
    if(self.sessionstate != "spectator") {
      if(isDefined(w_previous) && zm_utility::is_hero_weapon(w_previous)) {
        self[[level._hero_weapons[w_previous].unwield_fn]](w_previous);
        if(self gadgetpowerget(0) == 100) {
          if(self hasweapon(w_previous)) {
            self setweaponammoclip(w_previous, w_previous.clipsize);
            self[[level._hero_weapons[w_previous].power_full_fn]](w_previous);
          }
        }
      }
      if(isDefined(w_current) && zm_utility::is_hero_weapon(w_current)) {
        self[[level._hero_weapons[w_current].wield_fn]](w_current);
      }
    }
  }
}

function watch_hero_power(w_weapon) {
  self notify("watch_hero_power");
  self endon("watch_hero_power");
  self endon("stop_watch_hero_power");
  self endon("disconnect");
  if(!isDefined(self.hero_power_prev)) {
    self.hero_power_prev = -1;
  }
  while(true) {
    self.hero_power = self gadgetpowerget(0);
    self clientfield::set_player_uimodel("zmhud.swordEnergy", self.hero_power / 100);
    if(self.hero_power != self.hero_power_prev) {
      self.hero_power_prev = self.hero_power;
      if(self.hero_power >= 100) {
        self[[level._hero_weapons[w_weapon].power_full_fn]](w_weapon);
      } else if(self.hero_power <= 0) {
        self[[level._hero_weapons[w_weapon].power_empty_fn]](w_weapon);
      }
    }
    wait(0.05);
  }
}

function continue_draining_hero_weapon(w_weapon) {
  self endon("stop_draining_hero_weapon");
  self set_hero_weapon_state(w_weapon, 3);
  while(isDefined(self)) {
    n_rate = 1;
    if(isDefined(w_weapon.gadget_power_usage_rate)) {
      n_rate = w_weapon.gadget_power_usage_rate;
    }
    self.hero_power = self.hero_power - (0.05 * n_rate);
    self.hero_power = math::clamp(self.hero_power, 0, 100);
    if(self.hero_power != self.hero_power_prev) {
      self gadgetpowerset(0, self.hero_power);
    }
    wait(0.05);
  }
}

function register_hero_recharge_event(w_hero, func) {
  if(!isDefined(level.a_func_hero_power_update)) {
    level.a_func_hero_power_update = [];
  }
  if(!isDefined(level.a_func_hero_power_update[w_hero])) {
    level.a_func_hero_power_update[w_hero] = func;
  }
}

function hero_power_event_callback(e_player, ai_enemy) {
  w_hero = e_player.current_hero_weapon;
  if(isDefined(level.a_func_hero_power_update) && isDefined(level.a_func_hero_power_update[w_hero])) {
    level[[level.a_func_hero_power_update[w_hero]]](e_player, ai_enemy);
  } else {
    level hero_power_event(e_player, ai_enemy);
  }
}

function hero_power_event(player, ai_enemy) {
  if(isDefined(player) && player zm_utility::has_player_hero_weapon() && !player.hero_weapon_state === 3 && (!(isDefined(player.disable_hero_power_charging) && player.disable_hero_power_charging))) {
    player player_hero_power_event(ai_enemy);
  }
}

function player_hero_power_event(ai_enemy) {
  if(isDefined(self)) {
    w_current = self zm_utility::get_player_hero_weapon();
    if(isDefined(ai_enemy.heroweapon_kill_power)) {
      perkfactor = 1;
      if(self hasperk("specialty_overcharge")) {
        perkfactor = getdvarfloat("gadgetPowerOverchargePerkScoreFactor");
      }
      self.hero_power = self.hero_power + (perkfactor * ai_enemy.heroweapon_kill_power);
      self.hero_power = math::clamp(self.hero_power, 0, 100);
      if(self.hero_power != self.hero_power_prev) {
        self gadgetpowerset(0, self.hero_power);
        self clientfield::set_player_uimodel("zmhud.swordEnergy", self.hero_power / 100);
        self clientfield::increment_uimodel("zmhud.swordChargeUpdate");
      }
    }
  }
}

function take_hero_weapon() {
  if(isDefined(self.current_hero_weapon)) {
    self notify("weapon_take", self.current_hero_weapon);
    self gadgetpowerset(0, 0);
  }
}

function is_hero_weapon_in_use() {
  return self.hero_weapon_state === 3;
}