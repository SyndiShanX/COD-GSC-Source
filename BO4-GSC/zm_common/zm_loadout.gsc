/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_loadout.gsc
***********************************************/

#include scripts\core_common\aat_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\bb;
#include scripts\zm_common\util;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_hero_weapon;
#include scripts\zm_common\zm_items;
#include scripts\zm_common\zm_magicbox;
#include scripts\zm_common\zm_maptable;
#include scripts\zm_common\zm_melee_weapon;
#include scripts\zm_common\zm_pack_a_punch_util;
#include scripts\zm_common\zm_placeable_mine;
#include scripts\zm_common\zm_player;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_loadout;

autoexec __init__system__() {
  system::register(#"zm_loadout", &__init__, undefined, undefined);
}

__init__() {
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
}

on_player_connect() {
  self.currentweaponstarttime = gettime();
  self.currentweapon = level.weaponnone;
  self.previousweapon = level.weaponnone;

  if(!isDefined(self.var_57c1d146)) {
    self.var_57c1d146 = [];
  }
}

on_player_spawned() {
  self.class_num = self function_cc90c352();
}

event_handler[weapon_change] weapon_changed(eventstruct) {
  if(!isplayer(self)) {
    return;
  }

  self.currentweaponstarttime = gettime();
  self.currentweapon = eventstruct.weapon;
  self.previousweapon = eventstruct.last_weapon;
}

event_handler[player_loadoutchanged] loadout_changed(eventstruct) {
  switch (eventstruct.event) {
    case #"give_weapon":
      self function_54cb37a4(eventstruct.weapon);
      break;
    case #"take_weapon":
      self function_ad4c1664(eventstruct.weapon);
      break;
  }

  if(isDefined(self)) {
    self thread zm_player::function_de3936f8(eventstruct.weapon);
    self callback::callback(#"hash_39bf72fd97e248a0", eventstruct);
  }
}

function_ad4c1664(weapon) {
  self notify(#"weapon_take", weapon);
  primaryweapons = self getweaponslistprimaries();
  current_weapon = self getcurrentweapon();

  if(zm_equipment::is_equipment(weapon)) {
    self zm_equipment::take(weapon);
  }

  if(function_59b0ef71("melee_weapon", weapon)) {
    self function_6519eea8("melee_weapon", level.weaponnone);
  } else if(function_59b0ef71("hero_weapon", weapon)) {
    self function_6519eea8("hero_weapon", level.weaponnone);
  } else if(function_59b0ef71("lethal_grenade", weapon)) {
    self function_6519eea8("lethal_grenade", level.weaponnone);
  } else if(function_59b0ef71("tactical_grenade", weapon)) {
    self function_6519eea8("tactical_grenade", level.weaponnone);
  } else if(function_59b0ef71("placeable_mine", weapon)) {
    self function_6519eea8("placeable_mine", level.weaponnone);
  }

  if(!is_offhand_weapon(weapon) && primaryweapons.size < 1) {
    self zm_weapons::give_fallback_weapon();
  }
}

function_54cb37a4(weapon) {
  self notify(#"weapon_give", weapon);
  self endon(#"disconnect");
  primaryweapons = self getweaponslistprimaries();
  initial_current_weapon = self getcurrentweapon();
  current_weapon = self zm_weapons::switch_from_alt_weapon(initial_current_weapon);
  assert(self zm_weapons::player_can_use_content(weapon));
  weapon_limit = zm_utility::get_player_weapon_limit(self);

  if(isDefined(weapon.craftitem) && weapon.craftitem) {
    zm_items::player_pick_up(self, weapon);
    return;
  }

  if(zm_equipment::is_equipment(weapon)) {
    self zm_equipment::give(weapon);
  }

  if(weapon.isriotshield) {
    if(isDefined(self.player_shield_reset_health)) {
      self[[self.player_shield_reset_health]](weapon);
    }
  }

  if(function_59b0ef71("melee_weapon", weapon)) {
    had_fallback_weapon = self zm_melee_weapon::take_fallback_weapon();
    self function_6519eea8("melee_weapon", weapon);

    if(had_fallback_weapon) {
      self zm_melee_weapon::give_fallback_weapon();
    }
  } else if(function_59b0ef71("hero_weapon", weapon)) {
    self function_6519eea8("hero_weapon", weapon);
  } else if(function_59b0ef71("lethal_grenade", weapon)) {
    self function_6519eea8("lethal_grenade", weapon);
  } else if(function_59b0ef71("tactical_grenade", weapon)) {
    self function_6519eea8("tactical_grenade", weapon);
  } else if(function_59b0ef71("placeable_mine", weapon)) {
    self function_6519eea8("placeable_mine", weapon);
  }

  if(!is_offhand_weapon(weapon) && !function_2ff6913(weapon) && weapon != self zm_melee_weapon::determine_fallback_weapon()) {
    self zm_weapons::take_fallback_weapon();
  }

  if(primaryweapons.size > weapon_limit) {
    if(is_placeable_mine(current_weapon) || zm_equipment::is_equipment(current_weapon) || self.laststandpistol === weapon) {
      current_weapon = undefined;
    }

    if(isDefined(current_weapon)) {
      if(!is_offhand_weapon(weapon)) {
        self zm_weapons::weapon_take(current_weapon);

        if(isDefined(initial_current_weapon) && current_weapon != initial_current_weapon) {
          self zm_weapons::weapon_take(initial_current_weapon);
        }
      }
    }
  }

  if(isDefined(level.zombiemode_offhand_weapon_give_override)) {
    if(self[[level.zombiemode_offhand_weapon_give_override]](weapon)) {
      return;
    }
  }

  if(is_placeable_mine(weapon)) {
    self thread zm_placeable_mine::setup_for_player(weapon);
    return weapon;
  }

  if(isDefined(level.zombie_weapons_callbacks) && isDefined(level.zombie_weapons_callbacks[weapon])) {
    self thread[[level.zombie_weapons_callbacks[weapon]]]();
  }

  self zm_weapons::function_7c5dd4bd(weapon);

  if(isDefined(self.var_57c1d146[weapon]) && self.var_57c1d146[weapon]) {
    self.var_57c1d146[weapon] = undefined;
    return;
  }

  if(!is_offhand_weapon(weapon) && !is_hero_weapon(weapon)) {
    if(!is_melee_weapon(weapon)) {
      self switchtoweapon(weapon);
      return;
    }

    self switchtoweapon(current_weapon);
  }
}

function_5a5a742a(slot) {
  if(!isDefined(level.var_d5f9c1d2)) {
    level.var_d5f9c1d2 = [];
  }

  if(!isDefined(level.var_d5f9c1d2[slot])) {
    level.var_d5f9c1d2[slot] = [];
  }

  return level.var_d5f9c1d2[slot];
}

function_e884e095(slot, weapon) {
  if(isstring(weapon) || ishash(weapon)) {
    weapon = getweapon(weapon);
  }

  if(weapon.name == #"none") {
    return;
  }

  if(function_59b0ef71(slot, weapon)) {
    return;
  }

  if(!isDefined(level.var_d5f9c1d2)) {
    level.var_d5f9c1d2 = [];
  }

  if(!isDefined(level.var_d5f9c1d2[slot])) {
    level.var_d5f9c1d2[slot] = [];
  }

  level.var_d5f9c1d2[slot][weapon] = weapon;
}

function_59b0ef71(slot, weapon) {
  if(!isDefined(weapon) || !isDefined(level.var_d5f9c1d2) || !isDefined(level.var_d5f9c1d2[slot])) {
    return false;
  }

  return isDefined(level.var_d5f9c1d2[slot][weapon]);
}

function_393977df(slot, weapon) {
  if(!isDefined(weapon) || weapon == level.weaponnone || !isDefined(self.slot_weapons) || !isDefined(self.slot_weapons[slot])) {
    return false;
  }

  return self.slot_weapons[slot] == weapon;
}

function_8f85096(slot) {
  if(!isDefined(self.slot_weapons)) {
    self.slot_weapons = [];
  }

  if(!isDefined(self.slot_weapons[slot])) {
    self.slot_weapons[slot] = level.weaponnone;
  }

  w_ret = level.weaponnone;

  if(isDefined(self.slot_weapons) && isDefined(self.slot_weapons[slot])) {
    w_ret = self.slot_weapons[slot];
  }

  return w_ret;
}

function_6519eea8(slot, weapon) {
  if(!isDefined(self.slot_weapons)) {
    self.slot_weapons = [];
  }

  if(!isDefined(self.slot_weapons[slot])) {
    self.slot_weapons[slot] = level.weaponnone;
  }

  if(!isDefined(weapon)) {
    weapon = level.weaponnone;
  }

  old_weapon = self function_8f85096(slot);
  self notify(#"hash_4078956b159dd0f3", {
    #slot: slot, 
    #weapon: weapon
  });
  self notify("new_" + slot, {
    #weapon: weapon
  });
  self.slot_weapons[slot] = level.weaponnone;

  if(old_weapon != level.weaponnone && old_weapon != weapon) {
    if(self hasweapon(old_weapon)) {
      self takeweapon(old_weapon);
    }
  }

  self.slot_weapons[slot] = weapon;
}

register_lethal_grenade_for_level(weaponname) {
  function_e884e095("lethal_grenade", weaponname);
}

is_lethal_grenade(weapon) {
  return function_59b0ef71("lethal_grenade", weapon);
}

is_player_lethal_grenade(weapon) {
  return self function_393977df("lethal_grenade", weapon);
}

get_player_lethal_grenade() {
  return self function_8f85096("lethal_grenade");
}

set_player_lethal_grenade(weapon) {
  self function_6519eea8("lethal_grenade", weapon);
}

init_player_lethal_grenade() {
  var_cd6fae8c = self get_loadout_item("primarygrenade");
  s_weapon = getunlockableiteminfofromindex(var_cd6fae8c, 1);
  w_weapon = level.zombie_lethal_grenade_player_init;

  if(isDefined(s_weapon) && isDefined(s_weapon.namehash)) {
    w_weapon = getweapon(s_weapon.namehash);
    self zm_weapons::weapon_give(w_weapon, 1, 0);
  } else {
    self zm_weapons::weapon_give(level.zombie_lethal_grenade_player_init, 1, 0);
  }

  if(w_weapon.isgadget) {
    slot = self gadgetgetslot(w_weapon);
    var_aabc1f49 = isDefined(self.firstspawn) ? self.firstspawn : 1;

    if(slot >= 0 && var_aabc1f49) {
      self gadgetpowerreset(slot, 1);
    }
  }
}

register_tactical_grenade_for_level(weaponname, var_b1830d98 = 0) {
  function_e884e095("tactical_grenade", weaponname);

  if(var_b1830d98) {
    w_shield = getweapon(weaponname);
    level.var_b115fab2 = w_shield;
  }
}

is_tactical_grenade(weapon, var_9f428637 = 1) {
  if(!var_9f428637 && isDefined(weapon.isriotshield) && weapon.isriotshield) {
    return false;
  }

  return function_59b0ef71("tactical_grenade", weapon);
}

is_player_tactical_grenade(weapon) {
  return self function_393977df("tactical_grenade", weapon);
}

get_player_tactical_grenade() {
  return self function_8f85096("tactical_grenade");
}

set_player_tactical_grenade(weapon) {
  self function_6519eea8("tactical_grenade", weapon);
}

init_player_tactical_grenade() {
  self function_6519eea8("tactical_grenade", level.zombie_tactical_grenade_player_init);
}

is_placeable_mine(weapon) {
  return function_59b0ef71("placeable_mine", weapon);
}

is_player_placeable_mine(weapon) {
  return self function_393977df("placeable_mine", weapon);
}

get_player_placeable_mine() {
  return self function_8f85096("placeable_mine");
}

set_player_placeable_mine(weapon) {
  self function_6519eea8("placeable_mine", weapon);
}

init_player_placeable_mine() {
  self function_6519eea8("placeable_mine", level.zombie_placeable_mine_player_init);
}

register_melee_weapon_for_level(weaponname) {
  function_e884e095("melee_weapon", weaponname);
}

is_melee_weapon(weapon) {
  return function_59b0ef71("melee_weapon", weapon);
}

is_player_melee_weapon(weapon) {
  return self function_393977df("melee_weapon", weapon);
}

get_player_melee_weapon() {
  return self function_8f85096("melee_weapon");
}

set_player_melee_weapon(weapon) {
  had_fallback_weapon = self zm_melee_weapon::take_fallback_weapon();
  self function_6519eea8("melee_weapon", weapon);

  if(had_fallback_weapon) {
    self zm_melee_weapon::give_fallback_weapon();
  }
}

init_player_melee_weapon() {
  self zm_weapons::weapon_give(level.zombie_melee_weapon_player_init, 1, 0);
}

register_hero_weapon_for_level(weaponname) {
  function_e884e095("hero_weapon", weaponname);
}

is_hero_weapon(weapon) {
  return function_59b0ef71("hero_weapon", weapon);
}

is_player_hero_weapon(weapon) {
  return self function_393977df("hero_weapon", weapon);
}

get_player_hero_weapon() {
  return self function_8f85096("hero_weapon");
}

set_player_hero_weapon(weapon) {
  self function_6519eea8("hero_weapon", weapon);
}

init_player_hero_weapon() {
  self zm_hero_weapon::hero_weapon_player_init();
}

has_player_hero_weapon() {
  current_hero_weapon = get_player_hero_weapon();
  return isDefined(current_hero_weapon) && current_hero_weapon != level.weaponnone;
}

register_offhand_weapons_for_level_defaults() {
  if(isDefined(level.var_54f1e174)) {
    [[level.var_54f1e174]]();
    return;
  }

  if(isDefined(level.var_22fda912)) {
    [[level.var_22fda912]]();
  }

  register_lethal_grenade_for_level(#"claymore");
  register_lethal_grenade_for_level(#"eq_acid_bomb");
  register_lethal_grenade_for_level(#"eq_frag_grenade");
  register_lethal_grenade_for_level(#"eq_molotov");
  register_lethal_grenade_for_level(#"eq_wraith_fire");
  register_lethal_grenade_for_level(#"mini_turret");
  register_lethal_grenade_for_level(#"proximity_grenade");
  register_lethal_grenade_for_level(#"sticky_grenade");
  level.zombie_lethal_grenade_player_init = getweapon(#"eq_frag_grenade");
  register_melee_weapon_for_level(level.weaponbasemelee.name);

  if(zm_maptable::get_story() == 1) {
    register_melee_weapon_for_level(#"bowie_knife_story_1");
  } else {
    register_melee_weapon_for_level(#"bowie_knife");
  }

  level.zombie_melee_weapon_player_init = level.weaponbasemelee;
  level.zombie_equipment_player_init = undefined;
}

init_player_offhand_weapons() {
  init_player_lethal_grenade();
  init_player_tactical_grenade();
  init_player_placeable_mine();
  init_player_melee_weapon();
  init_player_hero_weapon();
  zm_equipment::init_player_equipment();
}

function_2ff6913(weapon) {
  return weapon.isperkbottle || weapon.isflourishweapon;
}

is_offhand_weapon(weapon) {
  return is_lethal_grenade(weapon) || is_tactical_grenade(weapon) || is_placeable_mine(weapon) || is_melee_weapon(weapon) || is_hero_weapon(weapon) || zm_equipment::is_equipment(weapon);
}

is_player_offhand_weapon(weapon) {
  return self is_player_lethal_grenade(weapon) || self is_player_tactical_grenade(weapon) || self is_player_placeable_mine(weapon) || self is_player_melee_weapon(weapon) || self is_player_hero_weapon(weapon) || self zm_equipment::is_player_equipment(weapon);
}

has_powerup_weapon() {
  return isDefined(self.has_powerup_weapon) && self.has_powerup_weapon;
}

has_hero_weapon() {
  weapon = self getcurrentweapon();
  return isDefined(weapon.isheroweapon) && weapon.isheroweapon;
}

give_start_weapon(b_switch_weapon) {
  var_9aeb4447 = self get_loadout_item("primary");
  s_weapon = getunlockableiteminfofromindex(var_9aeb4447, 1);

  if(isDefined(s_weapon) && isDefined(s_weapon.namehash) && zm_custom::function_bce642a1(s_weapon) && zm_custom::function_901b751c(#"zmstartingweaponenabled")) {
    self zm_weapons::weapon_give(getweapon(s_weapon.namehash), 1, b_switch_weapon);

    if(zm_custom::function_901b751c(#"zmstartingweaponenabled") && isDefined(self.talisman_weapon_start)) {
      self thread function_d9153457(b_switch_weapon);
    }

    return;
  }

  self zm_weapons::weapon_give(level.start_weapon, 1, b_switch_weapon);

  if(isDefined(s_weapon) && (!zm_custom::function_bce642a1(s_weapon) || !zm_custom::function_901b751c(#"zmstartingweaponenabled"))) {
    self thread zm_custom::function_343353f8();
  }
}

get_loadout_item(slot) {
  if(!isDefined(self.class_num)) {
    self.class_num = self function_cc90c352();
  }

  if(!isDefined(self.class_num)) {
    self.class_num = 0;
  }

  return self getloadoutitem(self.class_num, slot);
}

function_439b009a(slot) {
  if(!isDefined(self.class_num)) {
    self.class_num = self function_cc90c352();
  }

  if(!isDefined(self.class_num)) {
    self.class_num = 0;
  }

  return self getloadoutweapon(self.class_num, slot);
}

function_d9153457(b_switch_weapon = 1) {
  self endon(#"death");
  var_19673a84 = getweapon(self.talisman_weapon_start);

  if(var_19673a84 !== level.weaponnone) {
    self zm_weapons::weapon_give(var_19673a84, 1, 0);

    if(b_switch_weapon) {
      level waittill(#"start_zombie_round_logic");
      self switchtoweaponimmediate(var_19673a84, 1);
    }
  }
}