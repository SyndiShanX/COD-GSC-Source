/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_43642da1b2402e5c.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace namespace_a9e73d8d;

autoexec __init__system__() {
  system::register(#"hash_1f1fd12b1b87ef2c", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_3ad5e71a03ad70c1", &on_begin, &on_end);
}

private on_begin() {
  level.var_375482b5 = 1;
  callback::on_ai_killed(&on_ai_killed);
  callback::function_33f0ddd3(&function_33f0ddd3);
  callback::on_weapon_change(&zm_trial_util::function_79518194);

  foreach(player in getplayers()) {
    player thread zm_trial_util::function_bf710271(1, 1, 1, 0, 0);
    player thread zm_trial_util::function_dc9ab223(1, 0);
    player thread lock_shield();
    player thread function_29ee24dd();
  }

  level zm_trial::function_25ee130(1);
}

private on_end(round_reset) {
  level.var_375482b5 = undefined;
  callback::remove_on_ai_killed(&on_ai_killed);
  callback::function_824d206(&function_33f0ddd3);
  callback::remove_on_weapon_change(&zm_trial_util::function_79518194);
  level zm_trial::function_25ee130(0);
  level thread refill_ammo();
}

private refill_ammo() {
  self notify("416a437667c7c600");
  self endon("416a437667c7c600");

  while(is_active()) {
    waitframe(1);
  }

  foreach(player in getplayers()) {
    player thread zm_trial_util::function_dc0859e();
    a_w_weapons = player getweaponslist(0);

    foreach(w_weapon in a_w_weapons) {
      if(zm_loadout::is_lethal_grenade(w_weapon) || zm_loadout::is_melee_weapon(w_weapon) || zm_loadout::is_hero_weapon(w_weapon)) {
        continue;
      }

      if(isDefined(level.zombie_include_equipment) && isDefined(level.zombie_include_equipment[w_weapon]) && !(isDefined(level.zombie_equipment[w_weapon].refill_max_ammo) && level.zombie_equipment[w_weapon].refill_max_ammo)) {
        continue;
      }

      player zm_weapons::ammo_give(w_weapon, 0);
    }
  }
}

private lock_shield() {
  foreach(weapon in zm_loadout::function_5a5a742a("tactical_grenade")) {
    self lockweapon(weapon, 1, 1);

    if(weapon.dualwieldweapon != level.weaponnone) {
      self lockweapon(weapon.dualwieldweapon, 1, 1);
    }

    if(weapon.altweapon != level.weaponnone) {
      self lockweapon(weapon.altweapon, 1, 1);
    }
  }
}

private function_33f0ddd3(s_event) {
  if(s_event.event === "give_weapon") {
    if(s_event.weapon.inventorytype === "item") {
      return;
    }

    if(zm_loadout::is_lethal_grenade(s_event.weapon) || zm_loadout::is_tactical_grenade(s_event.weapon, 1)) {
      self lockweapon(s_event.weapon, 1, 1);

      if(s_event.weapon.dualwieldweapon != level.weaponnone) {
        self lockweapon(s_event.weapon.dualwieldweapon, 1, 1);
      }

      if(s_event.weapon.altweapon != level.weaponnone) {
        self lockweapon(s_event.weapon.altweapon, 1, 1);
      }

      return;
    }

    waitframe(1);
    self setweaponammostock(s_event.weapon, 0);
  }
}

private function_29ee24dd() {
  self endon(#"disconnect");
  level endon(#"hash_7646638df88a3656");
  a_w_weapons = self getweaponslist(0);
  self reset_ammo(1);

  while(true) {
    s_waitresult = self waittill(#"zmb_max_ammo", #"hash_278526d0bbdb4ce7", #"melee_reload", #"wallbuy_done");
    w_current = self getcurrentweapon();

    if(s_waitresult._notify == "melee_reload") {
      self setweaponammoclip(w_current, w_current.clipsize);
      continue;
    }

    a_weapons = self getweaponslist(0);

    foreach(weapon in a_weapons) {
      if(!(zm_loadout::is_lethal_grenade(weapon) || zm_loadout::is_hero_weapon(weapon))) {
        self setweaponammostock(weapon, 0);
      }
    }
  }
}

is_active() {
  s_challenge = zm_trial::function_a36e8c38(#"hash_3ad5e71a03ad70c1");
  return isDefined(s_challenge);
}

private on_ai_killed(params) {
  if(isplayer(params.eattacker) && params.smeansofdeath === "MOD_MELEE") {
    params.eattacker notify(#"melee_reload");
  }
}

private reset_ammo(var_f2c84b6b) {
  self notify("70d94e798e24bb1e");
  self endon("70d94e798e24bb1e");
  self endon(#"disconnect");

  if(!self zm_laststand::laststand_has_players_weapons_returned()) {
    self waittill(#"hash_9b426cce825928d");
  }

  if(isDefined(self.var_9b0383f5) && self.var_9b0383f5) {
    self waittill(#"hash_1ac4338b0d419091");
  }

  a_weapons = self getweaponslist(0);

  foreach(weapon in a_weapons) {
    if(zm_loadout::is_hero_weapon(weapon) || zm_loadout::is_lethal_grenade(weapon)) {
      continue;
    }

    self setweaponammostock(weapon, 0);

    if(isDefined(var_f2c84b6b)) {
      self setweaponammoclip(weapon, weapon.clipsize);
      continue;
    }

    self setweaponammoclip(weapon, 0);
  }
}