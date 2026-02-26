/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_loadout.gsc
***********************************************/

#using script_18077945bb84ede7;
#using script_437ce686d29bb81b;
#using script_72401f526ba71638;
#using script_7a8059ca02b7b09e;
#using script_dc49265d9886946;
#using scripts\abilities\ability_util;
#using scripts\core_common\aat_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gamestate_util;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\bb;
#using scripts\zm_common\gametypes\globallogic_ui;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_items;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_maptable;
#using scripts\zm_common\zm_melee_weapon;
#using scripts\zm_common\zm_pack_a_punch_util;
#using scripts\zm_common\zm_placeable_mine;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace zm_loadout;

function private autoexec __init__system__() {
  system::register(#"zm_loadout", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.var_928a7cf1 = 1;
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  level.defaultclass = "CLASS_CUSTOM1";
  level.classmap[#"class_smg"] = "CLASS_SMG";
  level.classmap[#"class_cqb"] = "CLASS_CQB";
  level.classmap[#"class_assault"] = "CLASS_ASSAULT";
  level.classmap[#"class_lmg"] = "CLASS_LMG";
  level.classmap[#"class_sniper"] = "CLASS_SNIPER";
  level.classmap[#"custom0"] = "CLASS_CUSTOM1";
  level.classmap[#"custom1"] = "CLASS_CUSTOM2";
  level.classmap[#"custom2"] = "CLASS_CUSTOM3";
  level.classmap[#"custom3"] = "CLASS_CUSTOM4";
  level.classmap[#"custom4"] = "CLASS_CUSTOM5";
  level.classmap[#"custom5"] = "CLASS_CUSTOM6";
  level.classmap[#"custom6"] = "CLASS_CUSTOM7";
  level.classmap[#"custom7"] = "CLASS_CUSTOM8";
  level.classmap[#"custom8"] = "CLASS_CUSTOM9";
  level.classmap[#"custom9"] = "CLASS_CUSTOM10";
  level.classmap[#"custom10"] = "CLASS_CUSTOM_BONUS1";
  level.classmap[#"custom11"] = "CLASS_CUSTOM_BONUS2";
  level.classmap[#"custom12"] = level.classmap[#"class_smg"];
  level.classmap[#"custom13"] = level.classmap[#"class_cqb"];
  level.classmap[#"custom14"] = level.classmap[#"class_assault"];
  level.classmap[#"custom15"] = level.classmap[#"class_lmg"];
  level.classmap[#"custom16"] = level.classmap[#"class_sniper"];
  function_445ac5cc("CLASS_CUSTOM_BONUS1", 10);
  function_445ac5cc("CLASS_CUSTOM_BONUS2", 11);
  load_default_loadout("CLASS_SMG", 12);
  load_default_loadout("CLASS_CQB", 13);
  load_default_loadout("CLASS_ASSAULT", 14);
  load_default_loadout("CLASS_LMG", 15);
  load_default_loadout("CLASS_SNIPER", 16);
  level.var_54cacb7e = namespace_cf6efd05::function_85b812c9();
}

function on_player_connect() {
  self.currentweaponstarttime = gettime();
  self.currentweapon = level.weaponnone;
  self.previousweapon = level.weaponnone;

  if(!isDefined(self.var_57c1d146)) {
    self.var_57c1d146 = [];
  }

  self.pers[#"loadoutindex"] = 0;

  if(loadout::function_87bcb1b()) {
    if(!isDefined(self.pers[#"class"])) {
      self.pers[#"class"] = "";
    }

    self.curclass = self.pers[#"class"];
    self.lastclass = "";
    self loadout::function_c67222df();
    self function_d7c205b9(self.curclass);

    if(!is_true(level.var_54cacb7e)) {
      self thread function_7a169290();
    }
  }
}

function on_player_spawned() {
  self.class_num = self function_cc90c352();
}

function event_handler[weapon_change] weapon_changed(eventstruct) {
  if(!is_true(level.var_928a7cf1)) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  self.currentweapon = eventstruct.weapon;
  self.previousweapon = eventstruct.last_weapon;
}

function event_handler[player_loadoutchanged] loadout_changed(eventstruct) {
  if(!is_true(level.var_928a7cf1)) {
    return;
  }

  if(isDefined(self)) {
    self callback::callback(#"hash_39bf72fd97e248a0", eventstruct);
  }
}

function function_ad4c1664(weapon) {
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

function function_54cb37a4(weapon) {
  self notify(#"weapon_give", weapon);
  self endon(#"disconnect");

  if(weapon == getweapon(#"hash_788c96e19cc7a46e")) {
    return;
  }

  primaryweapons = self getweaponslistprimaries();
  initial_current_weapon = self getcurrentweapon();
  current_weapon = self zm_weapons::switch_from_alt_weapon(initial_current_weapon);
  assert(self zm_weapons::player_can_use_content(weapon));
  weapon_limit = zm_utility::get_player_weapon_limit(self);

  if(is_true(weapon.craftitem)) {
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

  if(is_true(self.var_57c1d146[weapon])) {
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

function function_5a5a742a(slot) {
  if(!isDefined(level.var_d5f9c1d2)) {
    level.var_d5f9c1d2 = [];
  }

  if(!isDefined(level.var_d5f9c1d2[slot])) {
    level.var_d5f9c1d2[slot] = [];
  }

  return level.var_d5f9c1d2[slot];
}

function function_e884e095(slot, weapon) {
  if(!isDefined(weapon)) {
    return;
  }

  if(isstring(weapon) || ishash(weapon)) {
    weapon = getweapon(weapon);
  }

  if(weapon.name == # "none") {
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

function function_59b0ef71(slot, weapon) {
  if(!isDefined(weapon) || !isDefined(level.var_d5f9c1d2) || !isDefined(level.var_d5f9c1d2[slot])) {
    return false;
  }

  return isDefined(level.var_d5f9c1d2[slot][weapon]);
}

function function_393977df(slot, weapon) {
  if(!isDefined(weapon) || weapon == level.weaponnone || !isDefined(self.slot_weapons) || !isDefined(self.slot_weapons[slot])) {
    return false;
  }

  return self.slot_weapons[slot] == weapon;
}

function function_8f85096(slot) {
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

function function_6519eea8(slot, weapon) {
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
    #slot: slot, #weapon: weapon
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

function register_lethal_grenade_for_level(weaponname) {
  function_e884e095("lethal_grenade", weaponname);
}

function is_lethal_grenade(weapon) {
  return is_true(weapon.islethalgrenade);
}

function is_player_lethal_grenade(weapon) {
  return self function_393977df("lethal_grenade", weapon);
}

function get_player_lethal_grenade() {
  return self function_8f85096("lethal_grenade");
}

function set_player_lethal_grenade(weapon) {
  self function_6519eea8("lethal_grenade", weapon);
}

function register_tactical_grenade_for_level(weaponname, var_b1830d98 = 0) {
  function_e884e095("tactical_grenade", weaponname);

  if(var_b1830d98) {
    w_shield = getweapon(weaponname);
    level.var_b115fab2 = w_shield;
  }
}

function is_tactical_grenade(weapon, var_9f428637 = 1) {
  if(!var_9f428637 && is_true(weapon.isriotshield)) {
    return false;
  }

  return function_59b0ef71("tactical_grenade", weapon);
}

function is_player_tactical_grenade(weapon) {
  return self function_393977df("tactical_grenade", weapon);
}

function get_player_tactical_grenade() {
  return self function_8f85096("tactical_grenade");
}

function set_player_tactical_grenade(weapon) {
  self function_6519eea8("tactical_grenade", weapon);
}

function init_player_tactical_grenade() {
  self function_6519eea8("tactical_grenade", level.zombie_tactical_grenade_player_init);
}

function is_placeable_mine(weapon) {
  return function_59b0ef71("placeable_mine", weapon);
}

function is_player_placeable_mine(weapon) {
  return self function_393977df("placeable_mine", weapon);
}

function get_player_placeable_mine() {
  return self function_8f85096("placeable_mine");
}

function set_player_placeable_mine(weapon) {
  self function_6519eea8("placeable_mine", weapon);
}

function init_player_placeable_mine() {
  self function_6519eea8("placeable_mine", level.zombie_placeable_mine_player_init);
}

function register_melee_weapon_for_level(weaponname) {
  function_e884e095("melee_weapon", weaponname);
}

function is_melee_weapon(weapon) {
  return function_59b0ef71("melee_weapon", weapon);
}

function is_player_melee_weapon(weapon) {
  return self function_393977df("melee_weapon", weapon);
}

function get_player_melee_weapon() {
  return self function_8f85096("melee_weapon");
}

function set_player_melee_weapon(weapon) {
  had_fallback_weapon = self zm_melee_weapon::take_fallback_weapon();
  self function_6519eea8("melee_weapon", weapon);

  if(had_fallback_weapon) {
    self zm_melee_weapon::give_fallback_weapon();
  }
}

function init_player_melee_weapon() {
  self zm_weapons::weapon_give(level.zombie_melee_weapon_player_init, 1, 0);
}

function register_hero_weapon_for_level(weaponname) {
  function_e884e095("hero_weapon", weaponname);
}

function is_hero_weapon(weapon) {
  return function_59b0ef71("hero_weapon", weapon);
}

function is_player_hero_weapon(weapon) {
  return self function_393977df("hero_weapon", weapon);
}

function get_player_hero_weapon() {
  return self function_8f85096("hero_weapon");
}

function set_player_hero_weapon(weapon) {
  self function_6519eea8("hero_weapon", weapon);
}

function has_player_hero_weapon() {
  current_hero_weapon = get_player_hero_weapon();
  return isDefined(current_hero_weapon) && current_hero_weapon != level.weaponnone;
}

function register_offhand_weapons_for_level_defaults() {
  if(isDefined(level.var_54f1e174)) {
    [[level.var_54f1e174]]();
    return;
  }

  if(isDefined(level.var_22fda912)) {
    [[level.var_22fda912]]();
  }

  register_melee_weapon_for_level(level.weaponbasemelee.name);

  if(zm_maptable::get_story() == 1) {
    register_melee_weapon_for_level(#"bowie_knife_story_1");
  } else {
    register_melee_weapon_for_level(#"bowie_knife");
  }

  level.zombie_melee_weapon_player_init = level.weaponbasemelee;
  level.zombie_equipment_player_init = undefined;
}

function init_player_offhand_weapons() {
  nullprimary = getweapon(#"null_offhand_primary");
  self giveweapon(nullprimary);
  self setweaponammoclip(nullprimary, 0);
  self switchtooffhand(nullprimary);
  bare_hands = getweapon(#"bare_hands");
  self giveweapon(bare_hands);
  self function_c9a111a(bare_hands);
  self switchtoweapon(bare_hands, 1);
}

function function_2ff6913(weapon) {
  return weapon.isperkbottle || weapon.isflourishweapon;
}

function is_offhand_weapon(weapon) {
  return is_lethal_grenade(weapon) || is_tactical_grenade(weapon) || is_placeable_mine(weapon) || is_melee_weapon(weapon) || is_hero_weapon(weapon) || zm_equipment::is_equipment(weapon);
}

function is_player_offhand_weapon(weapon) {
  return self is_player_lethal_grenade(weapon) || self is_player_tactical_grenade(weapon) || self is_player_placeable_mine(weapon) || self is_player_melee_weapon(weapon) || self is_player_hero_weapon(weapon) || self zm_equipment::is_player_equipment(weapon);
}

function has_powerup_weapon() {
  return is_true(self.has_powerup_weapon);
}

function has_hero_weapon() {
  weapon = self getcurrentweapon();
  return is_true(weapon.isheroweapon);
}

function function_3e5c3a27() {
  if(zm_utility::is_survival()) {
    if(level.var_b48509f9 === 1) {
      self zm_score::function_c1f146ff(500);
      return;
    }
  }

  var_4ba090b7 = function_fc8ff147();
  score = self zm_score::function_ffc2d0bc();

  if(score < var_4ba090b7) {
    diff = var_4ba090b7 - score;
    self zm_score::add_to_player_score(diff);
    return;
  }

  self zm_score::function_c1f146ff(var_4ba090b7);
}

function function_fc8ff147() {
  if(zm_utility::is_survival()) {
    star_level = isDefined(level.var_b48509f9) ? level.var_b48509f9 : 0;
    var_4ba090b7 = star_level * 5000;
    var_4ba090b7 = math::clamp(var_4ba090b7, 0, 25000);
  } else {
    rounds = isDefined(level.round_number) ? level.round_number : 0;
    var_4ba090b7 = rounds * 1000;
    var_4ba090b7 = math::clamp(var_4ba090b7, 0, 25000);
  }

  return var_4ba090b7;
}

function function_cdcea3fd() {
  itemname = self.var_6e3cb3d1;
  itemcount = self.var_a4be9abe;
  count = 0;

  while(count < itemcount) {
    if(isPlayer(self)) {
      self namespace_1b527536::function_6457e4cd(itemname);
    }

    count++;
    waitframe(1);
  }
}

function give_start_weapon(b_switch_weapon) {
  level namespace_cdc318b3::function_b8a3efea();

  primary_weapon = self function_439b009a("primary");

  if(isweapon(level.var_a9ebf2c6)) {
    primary_weapon = self getbuildkitweapon(level.var_a9ebf2c6);

    if(!isDefined(primary_weapon)) {
      primary_weapon = level.var_a9ebf2c6;
    }
  }

  var_c6eea9c1 = isDefined(zm_stats::function_12b698fa(#"weapon_knife_tier")) ? zm_stats::function_12b698fa(#"weapon_knife_tier") : 0;

  var_df6f833b = getdvarint(#"hash_31933df32887a98b", 0);

  if(var_df6f833b > 0) {
    var_c6eea9c1 = var_df6f833b;
  }

  var_8c590502 = isDefined(getgametypesetting(#"hash_3c2c78e639bfd3c6")) ? getgametypesetting(#"hash_3c2c78e639bfd3c6") : 0;

  if(var_8c590502 > 0) {
    var_c6eea9c1 = var_8c590502;
  }

  if(var_c6eea9c1 >= 1 && var_c6eea9c1 < 3) {
    self zm_weapons::weapon_give(getweapon(#"knife"));
  } else if(var_c6eea9c1 >= 3) {
    self zm_weapons::weapon_give(getweapon(#"bowie_knife"));
  }

  s_weapon = getunlockableiteminfofromindex(primary_weapon.statindex, 1);

  if(isDefined(s_weapon) && isDefined(s_weapon.namehash) && zm_custom::function_bce642a1(s_weapon) && zm_custom::function_901b751c(#"zmstartingweaponenabled")) {
    var_9e4954fa = (isDefined(self.var_3b511a7c) ? self.var_3b511a7c : 0) < 0 ? 0 : 1;

    if(zm_utility::is_survival()) {
      var_88cf3317 = isDefined(self.is_hotjoining) || !namespace_cf6efd05::function_99df13e0(self);
    } else {
      var_88cf3317 = isDefined(self.is_hotjoining);
    }

    if(var_9e4954fa || var_88cf3317) {
      var_91f1878f = var_9e4954fa || var_88cf3317;
      self function_3e5c3a27();

      if(zm_utility::is_survival() && !var_9e4954fa && level.var_b48509f9 === 1) {
        self zm_score::function_c1f146ff(level.player_starting_points);
      }

      self.var_595a11bc = 0;
      self.var_72d64cfd = 0;
      self namespace_2a9f256a::function_b802c7fc();

      if(isDefined(self.var_6e3cb3d1) && self.var_87f72f8 === self.var_6e3cb3d1) {
        self thread function_cdcea3fd();
      }
    }

    var_e6a8f11f = undefined;

    if(!namespace_cf6efd05::function_99df13e0(self)) {
      var_e6a8f11f = self namespace_cdc318b3::function_f2eab818();
    }

    if(!is_true(level.var_b0f1ddbc)) {
      if(isDefined(primary_weapon.attachments) && primary_weapon.attachments.size > 0) {
        self zm_weapons::weapon_give(primary_weapon, 1, b_switch_weapon, 0, 1, undefined, primary_weapon.attachments, var_91f1878f, var_e6a8f11f);
      } else {
        self zm_weapons::weapon_give(primary_weapon, 1, b_switch_weapon, 0, 1, undefined, undefined, var_91f1878f, var_e6a8f11f);
      }
    }

    if(zm_custom::function_901b751c(#"zmstartingweaponenabled") && isDefined(self.talisman_weapon_start)) {
      self thread function_d9153457(b_switch_weapon);
    }

    return;
  }

  var_9e4954fa = (isDefined(self.var_3b511a7c) ? self.var_3b511a7c : 0) < 0 ? 0 : 1;
  var_88cf3317 = isDefined(self.is_hotjoining) || !namespace_cf6efd05::function_99df13e0(self);

  if(var_9e4954fa || var_88cf3317) {
    var_91f1878f = var_9e4954fa || var_88cf3317;
    self function_3e5c3a27();
    self.var_595a11bc = 0;
    self.var_72d64cfd = 0;

    if(isDefined(self.var_6e3cb3d1) && self.var_87f72f8 === self.var_6e3cb3d1) {
      self thread function_cdcea3fd();
    }
  }

  var_abb79409 = getweapon(getdvarstring(#"hash_35d047ae6d3ad4a", "pistol_semiauto_t9"));
  self zm_weapons::weapon_give(var_abb79409, 1, b_switch_weapon, 0, 1, undefined, undefined, var_91f1878f);

  if(isDefined(s_weapon) && (!zm_custom::function_bce642a1(s_weapon) || !zm_custom::function_901b751c(#"zmstartingweaponenabled"))) {
    self thread zm_custom::function_343353f8();
  }
}

function get_loadout_item(slot) {
  if(!isDefined(self.class_num)) {
    self.class_num = self function_cc90c352();
  }

  if(!isDefined(self.class_num)) {
    self.class_num = 0;
  }

  return self getloadoutitem(self.class_num, slot);
}

function function_439b009a(slot) {
  if(!isDefined(self.class_num)) {
    self.class_num = self function_cc90c352();
  }

  if(!isDefined(self.class_num)) {
    self.class_num = 0;
  }

  return self getloadoutweapon(self.class_num, slot);
}

function get_class_num(weaponclass) {
  assert(isDefined(weaponclass));
  prefixstring = "CLASS_CUSTOM";
  var_8bba14bc = self getcustomclasscount();
  var_8bba14bc = max(var_8bba14bc, 0);

  if(isstring(weaponclass) && issubstr(weaponclass, "CLASS_CUSTOM_BONUS")) {
    class_num = level.var_f9f569c2[weaponclass];
  } else if(isstring(weaponclass) && issubstr(weaponclass, prefixstring)) {
    var_3858e4e = getsubstr(weaponclass, prefixstring.size);
    class_num = int(var_3858e4e) - 1;

    if(class_num == -1) {
      class_num = var_8bba14bc;
    }

    assert(isDefined(class_num));

    if(class_num < 0 || class_num > var_8bba14bc) {
      class_num = 0;
    }

    assert(class_num >= 0 && class_num <= var_8bba14bc);
  } else {
    class_num = level.classtoclassnum[weaponclass];
  }

  if(!isDefined(class_num)) {
    class_num = self stats::get_stat(#"selectedcustomclass");

    if(!isDefined(class_num)) {
      class_num = 0;
    }
  }

  assert(isDefined(class_num));
  return class_num;
}

function function_d7c205b9(newclass, calledfrom = # "unspecified") {
  loadoutindex = isDefined(newclass) ? get_class_num(newclass) : undefined;
  self.pers[#"loadoutindex"] = loadoutindex;
  var_45843e9a = calledfrom == # "give_loadout";
  var_7f8c24df = 0;

  if(!var_45843e9a) {
    var_7f8c24df = isDefined(game) && isDefined(game.state) && game.state == # "playing" && isalive(self);

    if(var_7f8c24df && self.sessionstate == "playing") {
      var_25b0cd7 = self.usingsupplystation === 1;

      if(is_true(level.ingraceperiod) && !is_true(self.hasdonecombat) || var_25b0cd7) {
        var_7f8c24df = 0;
      }
    }
  }

  if(var_7f8c24df) {
    return;
  }

  self setloadoutindex(loadoutindex);
  self setplayerstateloadoutweapons(loadoutindex);
}

function function_97d216fa(response) {
  assert(isDefined(level.classmap[response]));
  return level.classmap[response];
}

function function_a7079aac(attachments) {}

function menuclass(response, forcedclass, updatecharacterindex, var_632376a3) {
  if(!isDefined(self.pers[#"team"]) || !isDefined(level.teams[self.pers[#"team"]])) {
    return 0;
  }

  if(!loadout::function_87bcb1b()) {
    if((game.state == # "pregame" || game.state == # "playing") && self.sessionstate != "playing") {
      self thread[[level.spawnclient]](0);
    }

    return;
  }

  if(!isDefined(updatecharacterindex)) {
    playerclass = self function_97d216fa(forcedclass);
  } else {
    playerclass = updatecharacterindex;
  }

  if(is_true(level.disablecustomcac) && issubstr(playerclass, "CLASS_CUSTOM") && isarray(level.classtoclassnum) && level.classtoclassnum.size > 0) {
    defaultclasses = getarraykeys(level.var_8e1db8ee);
    playerclass = level.var_8e1db8ee[defaultclasses[randomint(defaultclasses.size)]];
  }

  self function_d7c205b9(playerclass);
  var_96b1ace = 0;

  if(isDefined(self.pers[#"class"]) && self.pers[#"class"] == playerclass) {
    primary_weapon = self function_439b009a("primary");
    current_weapon = self getcurrentweapon();

    if(isDefined(primary_weapon.attachments) && isDefined(current_weapon.attachments) && primary_weapon.rootweapon === current_weapon.rootweapon) {
      if(primary_weapon.attachments.size != current_weapon.attachments.size) {
        var_96b1ace = 1;
      } else {
        foreach(attachment in primary_weapon.attachments) {
          var_c27e271b = isinarray(current_weapon.attachments, attachment);

          if(!var_c27e271b) {
            var_96b1ace = 1;
            break;
          }
        }
      }
    }

    if(primary_weapon.rootweapon != current_weapon.rootweapon) {
      var_96b1ace = 1;
    }

    loadoutindex = self get_class_num(playerclass);
    var_d07d57b2 = self function_b958b70d(loadoutindex, "specialgrenade");

    if(isDefined(self.var_87f72f8) && isDefined(var_d07d57b2) && !(namespace_1b527536::function_53ca9662(self.var_87f72f8) === var_d07d57b2)) {
      var_96b1ace = 1;
    }

    if(!var_96b1ace) {
      return 1;
    }
  }

  self.pers[#"changed_class"] = !isDefined(self.curclass) || self.curclass != playerclass || var_96b1ace;
  var_8d7a946 = !isDefined(self.curclass) || self.curclass == "";
  self.pers[#"class"] = playerclass;
  self.curclass = playerclass;
  self function_d7c205b9(playerclass);
  self.pers[#"weapon"] = undefined;

  if(namespace_cf6efd05::function_85b812c9() && namespace_cf6efd05::function_99df13e0(self)) {
    return;
  }

  self notify(#"changed_class");

  if(gamestate::is_game_over()) {
    return 0;
  }

  if(self.sessionstate != "playing") {
    if(self.sessionstate != "spectator") {
      if(self isinvehicle()) {
        return 0;
      }

      if(self isremotecontrolling()) {
        return 0;
      }

      if(self isweaponviewonlylinked()) {
        return 0;
      }
    }
  }

  if(self.sessionstate == "playing") {
    supplystationclasschange = isDefined(self.usingsupplystation) && self.usingsupplystation;
    self.usingsupplystation = 0;

    if(is_true(self.var_12d4c9e8) || is_true(level.ingraceperiod) && !is_true(self.hasdonecombat) && !is_true(level.var_54cacb7e) || is_true(supplystationclasschange) || var_632376a3 === 1) {
      self.curclass = self.pers[#"class"];
      self.tag_stowed_back = undefined;
      self.tag_stowed_hip = undefined;
      self give_loadout();
      loadoutindex = self get_class_num(playerclass);
      self namespace_1b527536::function_1067f94c(loadoutindex);
    } else if(!var_8d7a946 && self.pers[#"changed_class"] && !is_true(level.var_f46d16f0)) {
      loadoutindex = self get_class_num(playerclass);
      self namespace_1b527536::function_1067f94c(loadoutindex);
      self luinotifyevent(#"hash_6b67aa04e378d681", 2, 6, loadoutindex);
    }
  }

  return 1;
}

function private function_445ac5cc(weaponclass, classnum) {
  level.var_f9f569c2[weaponclass] = classnum;
}

function private load_default_loadout(weaponclass, classnum) {
  level.classtoclassnum[weaponclass] = classnum;
  level.var_8e1db8ee[classnum] = weaponclass;
}

function give_loadout() {
  if(loadout::function_87bcb1b()) {
    actionslot3 = getdvarint(#"hash_449fa75f87a4b5b4", 0) < 0 ? "flourish_callouts" : "ping_callouts";
    self setactionslot(3, actionslot3);
    actionslot4 = getdvarint(#"hash_23270ec9008cb656", 0) < 0 ? "scorestreak_wheel" : "sprays_boasts";
    self setactionslot(4, actionslot4);
  }

  if(namespace_cf6efd05::function_85b812c9() && namespace_cf6efd05::function_99df13e0(self) && !is_true(self.uspawn_already_spawned)) {
    return;
  }

  if(!is_true(level.var_928a7cf1)) {
    return;
  }

  if(self.var_1fa95cc === gettime() && isDefined(self.curclass) && get_class_num(self.curclass) === self.pers[#"loadoutindex"]) {
    return;
  }

  if(loadout::function_87bcb1b()) {
    assert(isDefined(self.curclass));
    self function_d7c205b9(self.curclass, #"give_loadout");

    if(isDefined(level.givecustomloadout)) {
      self[[level.givecustomloadout]]();
    } else {
      init_player(isDefined(self.var_1fa95cc));
      function_f436358b(self.curclass);
      zm_weapons::give_start_weapons();
      telemetry::function_18135b72(#"hash_27cccc0731de1722", {
        #player: self
      });
    }
  } else if(isDefined(level.givecustomloadout)) {
    self[[level.givecustomloadout]]();
  }

  self.var_1fa95cc = gettime();
  self flag::set("loadout_given");
  usedweapons = [];
  usedweapons[0] = self function_439b009a("primary").name;
  self function_bfb53a23(usedweapons);
  callback::callback(#"on_loadout");
}

function init_player(takeallweapons) {
  if(takeallweapons) {
    item_inventory::reset_inventory(0);
    self takeallweapons();
  }

  self.specialty = [];
}

function function_f436358b(weaponclass) {
  self.class_num = get_class_num(weaponclass);

  if(issubstr(weaponclass, "CLASS_CUSTOM")) {
    pixbeginevent(#"");
    self.class_num_for_global_weapons = self.class_num;
    pixendevent();
  } else {
    pixbeginevent(#"");
    assert(isDefined(self.pers[#"class"]), "<dev string:x38>");
    self.class_num_for_global_weapons = 0;
    pixendevent();
  }

  self recordloadoutindex(self.class_num);
}

function function_d9153457(b_switch_weapon = 1) {
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

function private function_7a169290() {
  self endoncallback(&function_ff646bfc, #"death", #"end_game", #"disconnect");
  var_e9c7076a = isDefined(getgametypesetting("zmMaxClassLoadoutTime")) ? getgametypesetting("zmMaxClassLoadoutTime") : 30;

  if(isbot(self)) {
    return;
  }

  self waittill(#"show_class_select_slideout");

  if(!isDefined(level.var_48bad54e)) {
    level.var_48bad54e = 0;
  }

  if(!isDefined(level.var_cf6387d8)) {
    level.var_cf6387d8 = 1;
  }

  if(is_false(level.var_48bad54e) && level.var_cf6387d8) {
    level.var_cf6387d8 = 0;
    level flag::increment("world_is_paused");
  }

  self.var_12d4c9e8 = 1;
  self val::set(#"hash_4746015172ea9af0", "ignoreme", 1);
  self waittilltimeout(var_e9c7076a, #"hide_class_select_slideout");
  self val::reset(#"hash_4746015172ea9af0", "ignoreme");
  self.var_12d4c9e8 = 0;

  if(is_false(level.var_48bad54e)) {
    level flag::decrement("world_is_paused");
    level.var_48bad54e = 1;
  }

  self globallogic_ui::function_f8f38932();
  telemetry::function_18135b72(#"hash_4481df211c9d18aa", {
    #player: self
  });
}

function private function_ff646bfc(notifyhash) {
  if(isbot(self)) {
    return;
  }

  if(is_false(level.var_48bad54e)) {
    level flag::decrement("world_is_paused");
    level.var_48bad54e = 1;
  }
}