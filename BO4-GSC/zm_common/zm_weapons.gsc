/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_weapons.gsc
***********************************************/

#include script_43642da1b2402e5c;
#include scripts\abilities\ability_util;
#include scripts\core_common\aat_shared;
#include scripts\core_common\activecamo_shared;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\bb_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\weapons\weapons;
#include scripts\zm\weapons\zm_weap_chakram;
#include scripts\zm\weapons\zm_weap_hammer;
#include scripts\zm\weapons\zm_weap_scepter;
#include scripts\zm\weapons\zm_weap_sword_pistol;
#include scripts\zm_common\bb;
#include scripts\zm_common\gametypes\globallogic_utils;
#include scripts\zm_common\trials\zm_trial_reset_loadout;
#include scripts\zm_common\util;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_camos;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_devgui;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_hero_weapon;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_magicbox;
#include scripts\zm_common\zm_melee_weapon;
#include scripts\zm_common\zm_pack_a_punch_util;
#include scripts\zm_common\zm_placeable_mine;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_wallbuy;

#namespace zm_weapons;

autoexec __init__system__() {
  system::register(#"zm_weapons", &__init__, &__main__, undefined);
}

__init__() {
  level flag::init("zm_weapons_table_loaded");
  level.weaponnone = getweapon(#"none");
  level.weaponnull = getweapon(#"weapon_null");
  level.weapondefault = getweapon(#"defaultweapon");
  level.weaponbasemelee = getweapon(#"knife");

  if(!isDefined(level.zombie_weapons)) {
    level.zombie_weapons = [];
  }

  if(!isDefined(level.zombie_weapons_upgraded)) {
    level.zombie_weapons_upgraded = [];
  }

  level.limited_weapons = [];
  function_ec38915a();
  level.var_51443ce5 = &get_player_weapondata;
  level.var_bfbdc0cd = &weapondata_give;
  level.var_ee5c0b6e = &function_93cd8e76;
}

__main__() {
  init();
}

init() {
  if(!isDefined(level.pack_a_punch_camo_index)) {
    level.pack_a_punch_camo_index = 42;
  }

  level.primary_weapon_array = [];
  level.side_arm_array = [];
  level.grenade_array = [];
  level.inventory_array = [];
  init_weapons();
  level._zombiemode_check_firesale_loc_valid_func = &default_check_firesale_loc_valid_func;
  callback::on_spawned(&on_player_spawned);
}

on_player_spawned() {
  self thread watchforgrenadeduds();
  self thread watchforgrenadelauncherduds();
  self.staticweaponsstarttime = gettime();

  if(!isDefined(self.var_f6d3c3)) {
    self.var_f6d3c3 = [];
  }
}

function_ec38915a() {
  if(!isDefined(level.var_5a069e6)) {
    level.var_5a069e6 = [];
  }

  if(!isDefined(level.var_44e0d625)) {
    level.var_44e0d625 = [];
  }

  function_8005e7f3(getweapon(#"smg_handling_t8"), getweapon(#"smg_handling_t8_dw"));
  function_8005e7f3(getweapon(#"smg_handling_t8_upgraded"), getweapon(#"smg_handling_t8_upgraded_dw"));
  function_8005e7f3(getweapon(#"special_ballisticknife_t8_dw"), getweapon(#"special_ballisticknife_t8_dw_dw"));
  function_8005e7f3(getweapon(#"special_ballisticknife_t8_dw_upgraded"), getweapon(#"special_ballisticknife_t8_dw_upgraded_dw"));
}

function_8005e7f3(w_base, var_ebc2aad) {
  if(w_base != level.weaponnone && var_ebc2aad != level.weaponnone) {
    level.var_5a069e6[w_base] = var_ebc2aad;
    level.var_44e0d625[var_ebc2aad] = w_base;
  }
}

event_handler[player_gunchallengecomplete] player_gunchallengecomplete(s_event) {
  if(s_event.is_lastrank) {
    var_8e617ca1 = 0;
    a_w_guns = get_guns();

    foreach(weapon in a_w_guns) {
      str_weapon = weapon.name;
      n_item_index = getbaseweaponitemindex(weapon);
      var_cc074f5b = stats::get_stat(#"ranked_item_stats", str_weapon, #"xp");

      if(isDefined(var_cc074f5b)) {
        var_6b792d1d = function_33cc663e(str_weapon);
        var_56ccc9fe = stats::get_stat(#"ranked_item_stats", str_weapon, #"plevel");

        if(var_cc074f5b >= var_6b792d1d || var_56ccc9fe >= 1) {
          var_8e617ca1++;
        }
      }
    }

    if(var_8e617ca1 >= 25) {
      zm_utility::giveachievement_wrapper("zm_trophy_gold");
    }
  }
}

get_guns() {
  a_w_guns = [];

  foreach(s_weapon in level.zombie_weapons) {
    switch (s_weapon.weapon_classname) {
      case 0:
      case #"equipment":
      case #"shield":
      case #"melee":
        continue;
    }

    if(is_wonder_weapon(s_weapon.weapon)) {
      continue;
    }

    if(!isDefined(a_w_guns)) {
      a_w_guns = [];
    } else if(!isarray(a_w_guns)) {
      a_w_guns = array(a_w_guns);
    }

    a_w_guns[a_w_guns.size] = s_weapon.weapon;
  }

  return a_w_guns;
}

function_14590040(str_weapon) {
  var_9bea1b6 = [];

  for(i = 0; i < 16; i++) {
    var_4a3def14 = tablelookup(#"gamedata/weapons/zm/zm_gunlevels.csv", 2, str_weapon, 0, i, 1);

    if("" == var_4a3def14) {
      break;
    }

    var_9bea1b6[i] = int(var_4a3def14);
  }

  return var_9bea1b6;
}

function_33cc663e(str_weapon) {
  var_9bea1b6 = function_14590040(str_weapon);
  return var_9bea1b6[var_9bea1b6.size - 1];
}

watchforgrenadeduds() {
  self endon(#"death", #"disconnect");

  while(true) {
    waitresult = self waittill(#"grenade_fire");
    grenade = waitresult.projectile;
    weapon = waitresult.weapon;

    if(!zm_equipment::is_equipment(weapon) && !zm_loadout::is_placeable_mine(weapon)) {
      grenade thread checkgrenadefordud(weapon, 1, self);
    }
  }
}

watchforgrenadelauncherduds() {
  self endon(#"death", #"disconnect");

  while(true) {
    waitresult = self waittill(#"grenade_launcher_fire");
    grenade = waitresult.projectile;
    weapon = waitresult.weapon;
    grenade thread checkgrenadefordud(weapon, 0, self);
  }
}

grenade_safe_to_throw(player, weapon) {
  if(isDefined(level.grenade_safe_to_throw)) {
    return self[[level.grenade_safe_to_throw]](player, weapon);
  }

  return 1;
}

grenade_safe_to_bounce(player, weapon) {
  if(isDefined(level.grenade_safe_to_bounce)) {
    return self[[level.grenade_safe_to_bounce]](player, weapon);
  }

  return 1;
}

makegrenadedudanddestroy() {
  self endon(#"death");
  self notify(#"grenade_dud");
  self makegrenadedud();
  wait 3;

  if(isDefined(self)) {
    self delete();
  }
}

checkgrenadefordud(weapon, isthrowngrenade, player) {
  self endon(#"death");
  player endon(#"zombify");

  if(!isDefined(self)) {
    return;
  }

  if(!self grenade_safe_to_throw(player, weapon)) {
    self thread makegrenadedudanddestroy();
    return;
  }

  for(;;) {
    self waittilltimeout(0.25, #"grenade_bounce", #"stationary", #"death", #"zombify");

    if(!self grenade_safe_to_bounce(player, weapon)) {
      self thread makegrenadedudanddestroy();
      return;
    }
  }
}

get_nonalternate_weapon(weapon) {
  if(isDefined(weapon.isaltmode) && weapon.isaltmode) {
    return weapon.altweapon;
  }

  return weapon;
}

function_af29d744(weapon) {
  if(isDefined(weapon)) {
    if(weapon.isaltmode) {
      weapon = weapon.altweapon;
    }

    weapon = function_386dacbc(weapon);
  }

  return weapon;
}

function_93cd8e76(weapon, var_1011fc73 = 0) {
  if(weapon.inventorytype == "dwlefthand") {
    weapon = weapon.dualwieldweapon;
  }

  weapon = function_af29d744(weapon);

  if(var_1011fc73 && isDefined(level.zombie_weapons_upgraded[weapon])) {
    return level.zombie_weapons_upgraded[weapon];
  }

  return weapon;
}

switch_from_alt_weapon(weapon) {
  if(weapon.ischargeshot) {
    return weapon;
  }

  alt = get_nonalternate_weapon(weapon);

  if(alt != weapon) {
    if(!weaponhasattachment(weapon, "dualoptic")) {
      self switchtoweaponimmediate(alt);
      self waittilltimeout(1, #"weapon_change_complete");
    }

    return alt;
  }

  return weapon;
}

give_start_weapons(takeallweapons, alreadyspawned) {
  if(isDefined(self.s_loadout) && zombie_utility::get_zombie_var("retain_weapons") && zm_custom::function_901b751c(#"zmretainweapons")) {
    self player_give_loadout(self.s_loadout, 1, 0);
    self.s_loadout = undefined;
    return;
  }

  self zm_loadout::give_start_weapon(1);
  self zm_loadout::init_player_offhand_weapons();
}

give_fallback_weapon(immediate = 0) {
  zm_melee_weapon::give_fallback_weapon(immediate);
}

take_fallback_weapon() {
  zm_melee_weapon::take_fallback_weapon();
}

switch_back_primary_weapon(oldprimary, immediate = 0, var_6d4494f9 = 0) {
  if(isDefined(self.laststand) && self.laststand) {
    return;
  }

  if(!isDefined(oldprimary) || oldprimary == level.weaponnone || oldprimary.isflourishweapon || zm_loadout::is_melee_weapon(oldprimary) || zm_loadout::is_placeable_mine(oldprimary) || zm_loadout::is_lethal_grenade(oldprimary) || zm_loadout::is_tactical_grenade(oldprimary, !var_6d4494f9) || !self hasweapon(oldprimary)) {
    oldprimary = undefined;
  } else if((oldprimary.isheroweapon || oldprimary.isgadget) && (!isDefined(self.hero_power) || self.hero_power <= 0)) {
    oldprimary = undefined;
  }

  primaryweapons = self getweaponslistprimaries();

  if(isDefined(oldprimary) && (isinarray(primaryweapons, oldprimary) || oldprimary.isriotshield && var_6d4494f9)) {
    if(immediate) {
      self switchtoweaponimmediate(oldprimary);
    } else {
      self switchtoweapon(oldprimary);
    }

    return;
  }

  if(primaryweapons.size > 0) {
    if(immediate) {
      self switchtoweaponimmediate();
    } else {
      self switchtoweapon();
    }

    return;
  }

  give_fallback_weapon(immediate);
}

updatelastheldweapontimingszm(newtime) {
  if(isDefined(self.currentweapon) && isDefined(self.currenttime)) {
    curweapon = self.currentweapon;
    totaltime = int((newtime - self.currenttime) / 1000);

    if(totaltime > 0) {
      self stats::function_e24eec31(curweapon, #"timeused", totaltime);
    }
  }
}

updateweapontimingszm(newtime) {
  if(isbot(self)) {
    return;
  }

  updatelastheldweapontimingszm(newtime);

  if(!isDefined(self.staticweaponsstarttime)) {
    return;
  }

  totaltime = int((newtime - self.staticweaponsstarttime) / 1000);

  if(totaltime < 0) {
    return;
  }

  self.staticweaponsstarttime = newtime;
}

default_check_firesale_loc_valid_func() {
  return true;
}

add_zombie_weapon(weapon_name, upgrade_name, is_ee, cost, weaponvo, weaponvoresp, ammo_cost, create_vox, weapon_class, is_wonder_weapon, tier = 0, in_box) {
  weapon = getweapon(weapon_name);
  upgrade = undefined;

  if(isDefined(upgrade_name)) {
    upgrade = getweapon(upgrade_name);
  }

  if(isDefined(level.zombie_include_weapons) && !isDefined(level.zombie_include_weapons[weapon])) {
    return;
  }

  struct = spawnStruct();

  if(!isDefined(level.zombie_weapons)) {
    level.zombie_weapons = [];
  }

  if(!isDefined(level.zombie_weapons_upgraded)) {
    level.zombie_weapons_upgraded = [];
  }

  if(isDefined(upgrade_name)) {
    level.zombie_weapons_upgraded[upgrade] = weapon;
  }

  struct.weapon = weapon;
  struct.upgrade = upgrade;
  struct.weapon_classname = weapon_class;

  if(function_8b1a219a()) {
    struct.hint = #"hash_2791ecebb85142c4";
  } else {
    struct.hint = #"hash_60606b68e93a29c8";
  }

  struct.cost = cost;
  struct.vox = weaponvo;
  struct.vox_response = weaponvoresp;
  struct.is_wonder_weapon = is_wonder_weapon;
  struct.tier = tier;
  println("<dev string:x38>" + function_9e72a96(weapon_name));
  struct.is_in_box = level.zombie_include_weapons[weapon];

  if(!isDefined(ammo_cost) || ammo_cost == 0) {
    ammo_cost = zm_utility::round_up_to_ten(int(cost * 0.5));
  }

  struct.ammo_cost = ammo_cost;

  if(weapon.isemp || isDefined(upgrade) && upgrade.isemp) {
    level.should_watch_for_emp = 1;
  }

  level.zombie_weapons[weapon] = struct;

  if(isDefined(create_vox)) {}

  if(isDefined(level.devgui_add_weapon) && (!is_ee || getdvarint(#"zm_debug_ee", 0))) {
    level thread[[level.devgui_add_weapon]](weapon, upgrade, in_box, cost, weaponvo, weaponvoresp, ammo_cost);
  }

}

is_weapon_included(weapon) {
  if(!isDefined(level.zombie_weapons)) {
    return false;
  }

  weapon = get_nonalternate_weapon(weapon);
  return isDefined(level.zombie_weapons[function_386dacbc(weapon)]);
}

is_weapon_or_base_included(weapon) {
  weapon = get_nonalternate_weapon(weapon);
  return isDefined(level.zombie_weapons[function_386dacbc(weapon)]) || isDefined(level.zombie_weapons[get_base_weapon(weapon)]);
}

include_zombie_weapon(weapon_name, in_box) {
  if(!isDefined(level.zombie_include_weapons)) {
    level.zombie_include_weapons = [];
  }

  if(!isDefined(in_box)) {
    in_box = 1;
  }

  println("<dev string:x56>" + function_9e72a96(weapon_name));
  level.zombie_include_weapons[getweapon(weapon_name)] = in_box;
}

init_weapons() {
  level.var_c60359dc = [];
  var_8e01336 = getdvarint(#"hash_4fdf506c770b343", 0);

  switch (var_8e01336) {
    case 1:
      var_4ef031c9 = #"hash_5694d3fa5334f8fe";
      break;
    case 2:
      var_4ef031c9 = #"hash_3f8d28bb3d9e9bec";
      break;
    default:
      var_4ef031c9 = #"hash_7bda40310359350e";
      break;
  }

  load_weapon_spec_from_table(var_4ef031c9, 0);

  if(isDefined(level.var_d0ab70a2)) {
    load_weapon_spec_from_table(level.var_d0ab70a2, 0);
  }

  level flag::set("zm_weapons_table_loaded");
  level.var_c60359dc = undefined;
}

add_limited_weapon(weapon_name, amount) {
  if(amount == 0) {
    return;
  }

  level.limited_weapons[getweapon(weapon_name)] = amount;
}

limited_weapon_below_quota(weapon, ignore_player) {
  if(isDefined(level.limited_weapons[weapon])) {
    pap_machines = undefined;

    if(!isDefined(pap_machines)) {
      pap_machines = getEntArray("zm_pack_a_punch", "targetname");
    }

    if(isDefined(level.no_limited_weapons) && level.no_limited_weapons) {
      return false;
    }

    upgradedweapon = weapon;

    if(isDefined(level.zombie_weapons[weapon]) && isDefined(level.zombie_weapons[weapon].upgrade)) {
      upgradedweapon = level.zombie_weapons[weapon].upgrade;
    }

    players = getplayers();
    count = 0;
    limit = level.limited_weapons[weapon];

    for(i = 0; i < players.size; i++) {
      if(isDefined(ignore_player) && ignore_player == players[i]) {
        continue;
      }

      if(players[i] has_weapon_or_upgrade(weapon)) {
        count++;

        if(count >= limit) {
          return false;
        }
      }
    }

    foreach(machine in pap_machines) {
      if(!isDefined(machine)) {
        continue;
      }

      if(!isDefined(machine.unitrigger_stub)) {
        continue;
      }

      if(isDefined(machine.unitrigger_stub.current_weapon) && (machine.unitrigger_stub.current_weapon == weapon || machine.unitrigger_stub.current_weapon == upgradedweapon)) {
        count++;

        if(count >= limit) {
          return false;
        }
      }
    }

    foreach(chest in level.chests) {
      if(!isDefined(chest)) {
        continue;
      }

      if(!isDefined(chest.zbarrier)) {
        continue;
      }

      if(isDefined(chest.zbarrier.weapon) && chest.zbarrier.weapon == weapon) {
        count++;

        if(count >= limit) {
          return false;
        }
      }
    }

    if(isDefined(level.custom_limited_weapon_checks)) {
      foreach(check in level.custom_limited_weapon_checks) {
        count += [
          [check]
        ](weapon);
      }

      if(count >= limit) {
        return false;
      }
    }

    if(isDefined(level.random_weapon_powerups)) {
      for(powerupindex = 0; powerupindex < level.random_weapon_powerups.size; powerupindex++) {
        if(isDefined(level.random_weapon_powerups[powerupindex]) && level.random_weapon_powerups[powerupindex].base_weapon == weapon) {
          count++;

          if(count >= limit) {
            return false;
          }
        }
      }
    }
  }

  return true;
}

add_custom_limited_weapon_check(callback) {
  if(!isDefined(level.custom_limited_weapon_checks)) {
    level.custom_limited_weapon_checks = [];
  }

  level.custom_limited_weapon_checks[level.custom_limited_weapon_checks.size] = callback;
}

add_weapon_to_content(weapon_name, package) {
  if(!isDefined(level.content_weapons)) {
    level.content_weapons = [];
  }

  level.content_weapons[getweapon(weapon_name)] = package;
}

player_can_use_content(weapon) {
  if(isDefined(level.content_weapons)) {
    if(isDefined(level.content_weapons[weapon])) {
      return self hasdlcavailable(level.content_weapons[weapon]);
    }
  }

  return 1;
}

get_weapon_hint(weapon) {
  assert(isDefined(level.zombie_weapons[weapon]), function_9e72a96(weapon.name) + "<dev string:x72>");
  return level.zombie_weapons[weapon].hint;
}

get_weapon_cost(weapon) {
  assert(isDefined(level.zombie_weapons[weapon]), function_9e72a96(weapon.name) + "<dev string:x72>");
  return level.zombie_weapons[weapon].cost;
}

get_ammo_cost(weapon) {
  assert(isDefined(level.zombie_weapons[weapon]), function_9e72a96(weapon.name) + "<dev string:x72>");
  return level.zombie_weapons[weapon].ammo_cost;
}

get_upgraded_ammo_cost(weapon) {
  assert(isDefined(level.zombie_weapons[weapon]), function_9e72a96(weapon.name) + "<dev string:x72>");

  if(isDefined(level.zombie_weapons[weapon].upgraded_ammo_cost)) {
    return level.zombie_weapons[weapon].upgraded_ammo_cost;
  }

  return 4500;
}

get_ammo_cost_for_weapon(w_current, n_base_non_wallbuy_cost = 750, n_upgraded_non_wallbuy_cost = 5000) {
  w_root = function_386dacbc(w_current);

  if(is_weapon_upgraded(w_root)) {
    w_root = get_base_weapon(w_root);
  }

  is_wonder_weapon = is_wonder_weapon(w_root);

  if(self has_upgrade(w_root)) {
    if(zm_wallbuy::is_wallbuy(w_root)) {
      n_ammo_cost = 4000;
    } else if(is_wonder_weapon) {
      n_ammo_cost = 7500;
    } else {
      n_ammo_cost = n_upgraded_non_wallbuy_cost;
    }
  } else if(zm_wallbuy::is_wallbuy(w_root)) {
    n_ammo_cost = get_ammo_cost(w_root);
    n_ammo_cost = zm_utility::halve_score(n_ammo_cost);
  } else if(is_wonder_weapon) {
    n_ammo_cost = 4000;
  } else {
    n_ammo_cost = n_base_non_wallbuy_cost;
  }

  return n_ammo_cost;
}

get_is_in_box(weapon) {
  assert(isDefined(level.zombie_weapons[weapon]), weapon.name + "<dev string:x72>");
  return level.zombie_weapons[weapon].is_in_box;
}

function_603af7a8(weapon) {
  if(isDefined(level.zombie_weapons[weapon])) {
    level.zombie_weapons[weapon].is_in_box = 1;
  }

  level thread zm_devgui::function_bcc8843e(getweaponname(weapon), "<dev string:xb0>", "<dev string:xb0>");

}

function_f1114209(weapon) {
  if(isDefined(level.zombie_weapons[weapon])) {
    level.zombie_weapons[weapon].is_in_box = 0;
  }
}

weapon_supports_default_attachment(weapon) {
  weapon = get_base_weapon(weapon);
  attachment = level.zombie_weapons[weapon].default_attachment;
  return isDefined(attachment);
}

default_attachment(weapon) {
  weapon = get_base_weapon(weapon);
  attachment = level.zombie_weapons[weapon].default_attachment;

  if(isDefined(attachment)) {
    return attachment;
  }

  return "none";
}

weapon_supports_attachments(weapon) {
  weapon = get_base_weapon(weapon);
  attachments = level.zombie_weapons[weapon].addon_attachments;
  return isDefined(attachments) && attachments.size > 1;
}

random_attachment(weapon, exclude) {
  lo = 0;

  if(isDefined(level.zombie_weapons[weapon].addon_attachments) && level.zombie_weapons[weapon].addon_attachments.size > 0) {
    attachments = level.zombie_weapons[weapon].addon_attachments;
  } else {
    attachments = weapon.supportedattachments;
    lo = 1;
  }

  minatt = lo;

  if(isDefined(exclude) && exclude != "none") {
    minatt = lo + 1;
  }

  if(attachments.size > minatt) {
    while(true) {
      idx = randomint(attachments.size - lo) + lo;

      if(!isDefined(exclude) || attachments[idx] != exclude) {
        return attachments[idx];
      }
    }
  }

  return "none";
}

get_attachment_index(weapon) {
  attachments = weapon.attachments;

  if(!attachments.size) {
    return -1;
  }

  weapon = get_nonalternate_weapon(weapon);
  base = function_386dacbc(weapon);

  if(attachments[0] === level.zombie_weapons[base].default_attachment) {
    return 0;
  }

  if(isDefined(level.zombie_weapons[base].addon_attachments)) {
    for(i = 0; i < level.zombie_weapons[base].addon_attachments.size; i++) {
      if(level.zombie_weapons[base].addon_attachments[i] == attachments[0]) {
        return (i + 1);
      }
    }
  }

  println("<dev string:xb3>" + weapon.name);
  return -1;
}

weapon_supports_this_attachment(weapon, att) {
  weapon = get_nonalternate_weapon(weapon);
  base = function_386dacbc(weapon);

  if(att == level.zombie_weapons[base].default_attachment) {
    return true;
  }

  if(isDefined(level.zombie_weapons[base].addon_attachments)) {
    for(i = 0; i < level.zombie_weapons[base].addon_attachments.size; i++) {
      if(level.zombie_weapons[base].addon_attachments[i] == att) {
        return true;
      }
    }
  }

  return false;
}

get_base_weapon(upgradedweapon) {
  upgradedweapon = get_nonalternate_weapon(upgradedweapon);
  upgradedweapon = function_386dacbc(upgradedweapon);

  if(isDefined(level.zombie_weapons_upgraded[upgradedweapon])) {
    return level.zombie_weapons_upgraded[upgradedweapon];
  }

  return upgradedweapon;
}

get_upgrade_weapon(weapon, add_attachment) {
  weapon = get_nonalternate_weapon(weapon);
  rootweapon = function_386dacbc(weapon);
  newweapon = rootweapon;
  baseweapon = get_base_weapon(weapon);

  if(!is_weapon_upgraded(rootweapon) && isDefined(level.zombie_weapons[rootweapon])) {
    newweapon = level.zombie_weapons[rootweapon].upgrade;
  } else if(!zm_custom::function_901b751c(#"zmsuperpapenabled")) {
    return weapon;
  }

  if(isDefined(self.var_8d5839f4) && isinarray(self.var_8d5839f4, weapon) && weapon.attachments.size) {
    newweapon = getweapon(newweapon.name, weapon.attachments);
    return newweapon;
  }

    if(isDefined(level.zombie_weapons[rootweapon]) && isDefined(level.zombie_weapons[rootweapon].default_attachment)) {
      att = level.zombie_weapons[rootweapon].default_attachment;
      newweapon = getweapon(newweapon.name, att);
    }

  return newweapon;
}

can_upgrade_weapon(weapon) {
  if(weapon == level.weaponnone || weapon == level.weaponzmfists || !is_weapon_included(weapon)) {
    return false;
  }

  weapon = get_nonalternate_weapon(weapon);
  rootweapon = function_386dacbc(weapon);

  if(!is_weapon_upgraded(rootweapon)) {
    upgraded_weapon = level.zombie_weapons[rootweapon].upgrade;
    return (isDefined(upgraded_weapon) && upgraded_weapon != level.weaponnone);
  }

  return false;
}

weapon_supports_aat(weapon) {
  if(!zm_custom::function_901b751c(#"zmsuperpapenabled")) {
    return false;
  }

  if(!isDefined(weapon)) {
    return false;
  }

  if(weapon == level.weaponnone || weapon == level.weaponzmfists) {
    return false;
  }

  weapontopack = get_nonalternate_weapon(weapon);

  if(!aat::is_exempt_weapon(weapontopack)) {
    return true;
  }

  return false;
}

is_weapon_upgraded(weapon) {
  if(!isDefined(weapon)) {
    return false;
  }

  if(weapon == level.weaponnone || weapon == level.weaponzmfists) {
    return false;
  }

  weapon = get_nonalternate_weapon(weapon);
  rootweapon = function_386dacbc(weapon);

  if(isDefined(level.zombie_weapons_upgraded[rootweapon])) {
    return true;
  }

  return false;
}

get_weapon_with_attachments(weapon) {
  weapon = get_nonalternate_weapon(weapon);
  rootweapon = function_386dacbc(weapon);

  if(self has_weapon_or_attachments(rootweapon)) {

    if(isDefined(self.var_8d5839f4) && isinarray(self.var_8d5839f4, weapon) && weapon.attachments.size) {
      return weapon;
    }

      return self getbuildkitweapon(rootweapon);
  }

  return undefined;
}

has_weapon_or_attachments(weapon) {
  if(self hasweapon(weapon, 1)) {
    return true;
  } else if(self hasweapon(self getbuildkitweapon(weapon), 1)) {
    return true;
  }

  return false;
}

function_386dacbc(weapon) {
  rootweapon = weapon.rootweapon;

  if(isDefined(level.var_44e0d625[rootweapon])) {
    rootweapon = level.var_44e0d625[rootweapon];
  }

  return rootweapon;
}

has_upgrade(weapon) {
  weapon = get_nonalternate_weapon(weapon);
  rootweapon = function_386dacbc(weapon);
  has_upgrade = 0;

  if(isDefined(level.zombie_weapons[rootweapon]) && isDefined(level.zombie_weapons[rootweapon].upgrade)) {
    has_upgrade = self has_weapon_or_attachments(level.zombie_weapons[rootweapon].upgrade);
  }

  return has_upgrade;
}

has_weapon_or_upgrade(weapon) {
  weapon = get_nonalternate_weapon(weapon);
  rootweapon = function_386dacbc(weapon);
  upgradedweaponname = rootweapon;

  if(isDefined(level.zombie_weapons[rootweapon]) && isDefined(level.zombie_weapons[rootweapon].upgrade)) {
    upgradedweaponname = level.zombie_weapons[rootweapon].upgrade;
  }

  has_weapon = 0;

  if(isDefined(level.zombie_weapons[rootweapon])) {
    has_weapon = self has_weapon_or_attachments(rootweapon) || self has_upgrade(rootweapon);
  }

  if(!has_weapon && zm_equipment::is_equipment(rootweapon)) {
    has_weapon = self zm_equipment::is_active(rootweapon);
  }

  return has_weapon;
}

add_shared_ammo_weapon(weapon, base_weapon) {
  level.zombie_weapons[weapon].shared_ammo_weapon = base_weapon;
}

get_shared_ammo_weapon(weapon) {
  weapon = get_nonalternate_weapon(weapon);
  rootweapon = function_386dacbc(weapon);
  weapons = self getweaponslist(1);

  foreach(w in weapons) {
    w = function_386dacbc(w);

    if(!isDefined(level.zombie_weapons[w]) && isDefined(level.zombie_weapons_upgraded[w])) {
      w = level.zombie_weapons_upgraded[w];
    }

    if(isDefined(level.zombie_weapons[w]) && isDefined(level.zombie_weapons[w].shared_ammo_weapon) && level.zombie_weapons[w].shared_ammo_weapon == rootweapon) {
      return w;
    }
  }

  return undefined;
}

get_player_weapon_with_same_base(weapon) {
  if(isDefined(level.var_ee565b3f)) {
    retweapon = [[level.var_ee565b3f]](weapon);

    if(isDefined(retweapon)) {
      return retweapon;
    }
  }

  weapon = get_nonalternate_weapon(weapon);
  rootweapon = function_386dacbc(weapon);
  retweapon = self get_weapon_with_attachments(rootweapon);

  if(!isDefined(retweapon)) {
    if(isDefined(level.zombie_weapons[rootweapon])) {
      if(isDefined(level.zombie_weapons[rootweapon].upgrade)) {
        retweapon = self get_weapon_with_attachments(level.zombie_weapons[rootweapon].upgrade);
      }
    } else if(isDefined(level.zombie_weapons_upgraded[rootweapon])) {
      retweapon = self get_weapon_with_attachments(level.zombie_weapons_upgraded[rootweapon]);
    }
  }

  return retweapon;
}

get_weapon_hint_ammo() {
  if(function_8b1a219a()) {
    return #"hash_2791ecebb85142c4";
  }

  return #"hash_60606b68e93a29c8";
}

weapon_set_first_time_hint(cost, ammo_cost) {
  self sethintstring(get_weapon_hint_ammo());
}

get_pack_a_punch_weapon_options(weapon) {
  if(!isDefined(self.pack_a_punch_weapon_options)) {
    self.pack_a_punch_weapon_options = [];
  }

  if(!is_weapon_upgraded(weapon)) {
    return self calcweaponoptions(0, 0, 0, 0, 0);
  }

  if(isDefined(self.pack_a_punch_weapon_options[weapon])) {
    return self.pack_a_punch_weapon_options[weapon];
  }

  camo_index = self zm_camos::function_4f727cf5(weapon);
  reticle_index = randomintrange(0, 16);
  var_eb2e3f90 = 0;
  plain_reticle_index = 16;
  use_plain = randomint(10) < 1;

  if(use_plain) {
    reticle_index = plain_reticle_index;
  }

  if(getdvarint(#"scr_force_reticle_index", 0) >= 0) {
    reticle_index = getdvarint(#"scr_force_reticle_index", 0);
  }

    self.pack_a_punch_weapon_options[weapon] = self calcweaponoptions(camo_index, reticle_index, var_eb2e3f90);
  return self.pack_a_punch_weapon_options[weapon];
}

function_17512fb3() {
  lethal_grenade = self zm_loadout::get_player_lethal_grenade();

  if(!self hasweapon(lethal_grenade)) {
    self giveweapon(lethal_grenade);
    self setweaponammoclip(lethal_grenade, 0);
    self switchtooffhand(lethal_grenade);
    self ability_util::gadget_reset(lethal_grenade, 0, 0, 1, 0);
  }
}

give_build_kit_weapon(weapon, var_51ec4e93, var_bd5d43c6, b_switch_weapon = 1) {
  if(isDefined(var_51ec4e93)) {
    n_camo = var_51ec4e93;
  } else {
    n_camo = self zm_camos::function_79be4786(weapon);
  }

  base_weapon = weapon;

  if(is_weapon_upgraded(weapon)) {
    level notify(#"hash_6dead3931d3e708a", {
      #player: self, 
      #weapon: weapon
    });

    if(!isDefined(n_camo)) {
      n_camo = self zm_camos::function_4f727cf5(weapon);
    }

    base_weapon = get_base_weapon(weapon);
  }

  if(isDefined(self.var_8d5839f4) && isinarray(self.var_8d5839f4, weapon) && weapon.attachments.size) {
    if(!isDefined(n_camo)) {
      n_camo = 0;
    }

    weapon_options = self calcweaponoptions(n_camo, 0, 0);
    self giveweapon(weapon, weapon_options);
    return weapon;
  }

    weapon = self getbuildkitweapon(weapon);
  weapon = function_1242e467(weapon);
  w_root = function_386dacbc(weapon);
  weapon_options = self getbuildkitweaponoptions(w_root, n_camo, var_bd5d43c6);

  if(!isDefined(n_camo)) {
    n_camo = getcamoindex(weapon_options);
  }

  if(!(isDefined(b_switch_weapon) && b_switch_weapon)) {
    self.var_57c1d146[weapon] = 1;
  }

  self giveweapon(weapon, weapon_options);

  if(!self hasweapon(weapon)) {
    return weapon;
  }

  var_35dbd2be = self function_9826b353(w_root);

  if(isDefined(var_35dbd2be) && var_35dbd2be >= 0) {
    self function_3fb8b14(weapon, var_35dbd2be);
  }

  var_502dadb4 = self function_74829bcf(w_root);

  if(isDefined(var_502dadb4) && var_502dadb4 >= 0) {
    self function_a85d2581(weapon, var_502dadb4);
  }

  return weapon;
}

weapon_give(weapon, nosound = 0, b_switch_weapon = 1, var_51ec4e93, var_bd5d43c6) {
  if(!(isDefined(nosound) && nosound)) {
    self zm_utility::play_sound_on_ent("purchase");
  }

  weapon = self give_build_kit_weapon(weapon, var_51ec4e93, var_bd5d43c6, b_switch_weapon);

  if(!(isDefined(nosound) && nosound)) {
    self play_weapon_vo(weapon);
  }

  return weapon;
}

weapon_take(weapon) {
  if(self hasweapon(weapon)) {
    self takeweapon(weapon);
  }
}

play_weapon_vo(weapon) {
  if(isDefined(level.var_d99d49fd)) {
    result = self[[level.var_d99d49fd]](weapon);

    if(result) {
      return;
    }
  }

  if(isDefined(level._audio_custom_weapon_check)) {
    type = self[[level._audio_custom_weapon_check]](weapon);
  } else {
    type = self weapon_type_check(weapon);
  }

  if(!isDefined(type)) {
    return;
  }

  if(isDefined(level.sndweaponpickupoverride)) {
    foreach(override in level.sndweaponpickupoverride) {
      if(type === override) {
        self zm_audio::create_and_play_dialog(#"weapon_pickup", override);
        return;
      }
    }
  }

  if(isDefined(self.var_966bfd1b) && self.var_966bfd1b) {
    self.var_966bfd1b = 0;
    self zm_audio::create_and_play_dialog(#"magicbox", type);
    return;
  }

  if(type == "upgrade") {
    self zm_audio::create_and_play_dialog(#"weapon_pickup", #"upgrade");
    return;
  }

  if(randomintrange(0, 100) <= 75 || type == "shield") {
    self zm_audio::create_and_play_dialog(#"weapon_pickup", type);
    return;
  }

  self zm_audio::create_and_play_dialog(#"weapon_pickup", #"generic");
}

weapon_type_check(weapon) {
  if(!isDefined(self.entity_num)) {
    return "crappy";
  }

  weapon = get_nonalternate_weapon(weapon);
  weapon = function_386dacbc(weapon);

  if(is_weapon_upgraded(weapon) && !self bgb::is_enabled(#"zm_bgb_wall_power")) {
    return "upgrade";
  }

  if(isDefined(level.zombie_weapons[weapon])) {
    return level.zombie_weapons[weapon].vox;
  }

  return "crappy";
}

ammo_give(weapon, b_purchased = 1) {
  var_cd9d17e0 = 0;

  if(!zm_loadout::is_offhand_weapon(weapon) || weapon.isriotshield) {
    weapon = self get_weapon_with_attachments(weapon);

    if(isDefined(weapon)) {
      if(zm_trial_reset_loadout::is_active(1) || namespace_a9e73d8d::is_active()) {
        var_cb48c3c9 = 0;
        var_ef0714fa = 0;
      } else {
        var_cb48c3c9 = weapon.maxammo;
        var_ef0714fa = weapon.startammo;
      }

      var_98f6dae8 = self getweaponammoclip(weapon);
      n_clip_size = weapon.clipsize;

      if(var_98f6dae8 < n_clip_size) {
        var_cd9d17e0 = 1;
      }

      var_4052eae0 = 0;

      if(!var_cd9d17e0 && weapon.dualwieldweapon != level.weaponnone) {
        var_4052eae0 = self getweaponammoclip(weapon.dualwieldweapon);
        var_5916b9ab = weapon.dualwieldweapon.clipsize;

        if(var_4052eae0 < var_5916b9ab) {
          var_cd9d17e0 = 1;
        }
      }

      if(!var_cd9d17e0) {
        var_b8624c26 = self getammocount(weapon);

        if(self hasperk(#"specialty_extraammo")) {
          n_ammo_max = var_cb48c3c9;
        } else {
          n_ammo_max = var_ef0714fa;
        }

        if(weapon.isdualwield) {
          if(weapon == getweapon(#"pistol_topbreak_t8_upgraded")) {
            n_ammo_max = n_ammo_max * 2 - var_98f6dae8;
          }

          var_b8624c26 += var_4052eae0;
        }

        var_6ec34556 = isDefined(weapon.iscliponly) && weapon.iscliponly ? var_98f6dae8 : n_ammo_max + var_98f6dae8 + var_4052eae0;

        if(var_b8624c26 >= var_6ec34556) {
          var_cd9d17e0 = 0;
        } else {
          var_cd9d17e0 = 1;
        }
      }
    }
  } else if(self has_weapon_or_upgrade(weapon)) {
    if(self getammocount(weapon) < weapon.maxammo) {
      var_cd9d17e0 = 1;
    }
  }

  if(var_cd9d17e0) {
    if(b_purchased) {
      self zm_utility::play_sound_on_ent("purchase");
    }

    self function_7c5dd4bd(weapon);
    return 1;
  }

  if(!var_cd9d17e0) {
    return 0;
  }
}

get_default_weapondata(weapon) {
  weapondata = [];
  weapondata[#"weapon"] = weapon;
  dw_weapon = weapon.dualwieldweapon;
  alt_weapon = weapon.altweapon;
  weaponnone = getweapon(#"none");

  if(isDefined(level.weaponnone)) {
    weaponnone = level.weaponnone;
  }

  if(weapon != weaponnone) {
    weapondata[#"clip"] = weapon.clipsize;
    weapondata[#"stock"] = weapon.maxammo;
    weapondata[#"fuel"] = weapon.fuellife;
    weapondata[#"heat"] = 0;
    weapondata[#"overheat"] = 0;
  }

  if(dw_weapon != weaponnone) {
    weapondata[#"lh_clip"] = dw_weapon.clipsize;
  } else {
    weapondata[#"lh_clip"] = 0;
  }

  if(alt_weapon != weaponnone) {
    weapondata[#"alt_clip"] = alt_weapon.clipsize;
    weapondata[#"alt_stock"] = alt_weapon.maxammo;
  } else {
    weapondata[#"alt_clip"] = 0;
    weapondata[#"alt_stock"] = 0;
  }

  return weapondata;
}

get_player_weapondata(weapon) {
  weapondata = [];

  if(!isDefined(weapon)) {
    weapon = self getcurrentweapon();
  }

  weapondata[#"weapon"] = weapon;

  if(weapondata[#"weapon"] != level.weaponnone) {
    weapondata[#"clip"] = self getweaponammoclip(weapon);
    weapondata[#"stock"] = self getweaponammostock(weapon);
    weapondata[#"fuel"] = self getweaponammofuel(weapon);
    weapondata[#"heat"] = self isweaponoverheating(1, weapon);
    weapondata[#"overheat"] = self isweaponoverheating(0, weapon);

    if(weapon.isgadget) {
      slot = self gadgetgetslot(weapon);
      weapondata[#"power"] = self gadgetpowerget(slot);
    }

    if(weapon.isriotshield) {
      weapondata[#"health"] = self.weaponhealth;
    }
  } else {
    weapondata[#"clip"] = 0;
    weapondata[#"stock"] = 0;
    weapondata[#"fuel"] = 0;
    weapondata[#"heat"] = 0;
    weapondata[#"overheat"] = 0;
    weapondata[#"power"] = undefined;
  }

  dw_weapon = weapon.dualwieldweapon;

  if(dw_weapon != level.weaponnone) {
    weapondata[#"lh_clip"] = self getweaponammoclip(dw_weapon);
  } else {
    weapondata[#"lh_clip"] = 0;
  }

  alt_weapon = weapon.altweapon;

  if(alt_weapon != level.weaponnone) {
    weapondata[#"alt_clip"] = self getweaponammoclip(alt_weapon);
    weapondata[#"alt_stock"] = self getweaponammostock(alt_weapon);
  } else {
    weapondata[#"alt_clip"] = 0;
    weapondata[#"alt_stock"] = 0;
  }

  if(self aat::has_aat(weapon)) {
    weapondata[#"aat"] = self aat::getaatonweapon(weapon, 1);
  }

  weapondata[#"repacks"] = self zm_pap_util::function_83c29ddb(weapon);
  return weapondata;
}

weapon_is_better(left, right) {
  if(left != right) {
    left_upgraded = is_weapon_upgraded(left);
    right_upgraded = is_weapon_upgraded(right);

    if(left_upgraded) {
      return true;
    }
  }

  return false;
}

merge_weapons(oldweapondata, newweapondata) {
  weapondata = [];

  if(isDefined(level.var_bb2323e4)) {
    weapondata = [[level.var_bb2323e4]](oldweapondata, newweapondata);

    if(isDefined(weapondata)) {
      return weapondata;
    }
  }

  if(weapon_is_better(oldweapondata[#"weapon"], newweapondata[#"weapon"])) {
    weapondata[#"weapon"] = oldweapondata[#"weapon"];
  } else {
    weapondata[#"weapon"] = newweapondata[#"weapon"];
  }

  weapon = weapondata[#"weapon"];
  dw_weapon = weapon.dualwieldweapon;
  alt_weapon = weapon.altweapon;

  if(weapon != level.weaponnone) {
    weapondata[#"clip"] = newweapondata[#"clip"] + oldweapondata[#"clip"];
    weapondata[#"clip"] = int(min(weapondata[#"clip"], weapon.clipsize));
    weapondata[#"stock"] = newweapondata[#"stock"] + oldweapondata[#"stock"];
    weapondata[#"stock"] = int(min(weapondata[#"stock"], weapon.maxammo));
    weapondata[#"fuel"] = newweapondata[#"fuel"] + oldweapondata[#"fuel"];
    weapondata[#"fuel"] = int(min(weapondata[#"fuel"], weapon.fuellife));
    weapondata[#"heat"] = int(min(newweapondata[#"heat"], oldweapondata[#"heat"]));
    weapondata[#"overheat"] = int(min(newweapondata[#"overheat"], oldweapondata[#"overheat"]));
    weapondata[#"power"] = int(max(isDefined(newweapondata[#"power"]) ? newweapondata[#"power"] : 0, isDefined(oldweapondata[#"power"]) ? oldweapondata[#"power"] : 0));
  }

  if(dw_weapon != level.weaponnone) {
    weapondata[#"lh_clip"] = newweapondata[#"lh_clip"] + oldweapondata[#"lh_clip"];
    weapondata[#"lh_clip"] = int(min(weapondata[#"lh_clip"], dw_weapon.clipsize));
  }

  if(alt_weapon != level.weaponnone) {
    weapondata[#"alt_clip"] = newweapondata[#"alt_clip"] + oldweapondata[#"alt_clip"];
    weapondata[#"alt_clip"] = int(min(weapondata[#"alt_clip"], alt_weapon.clipsize));
    weapondata[#"alt_stock"] = newweapondata[#"alt_stock"] + oldweapondata[#"alt_stock"];
    weapondata[#"alt_stock"] = int(min(weapondata[#"alt_stock"], alt_weapon.maxammo));
  }

  return weapondata;
}

weapondata_give(weapondata) {
  current = self get_player_weapon_with_same_base(weapondata[#"weapon"]);

  if(isDefined(current)) {
    curweapondata = self get_player_weapondata(current);
    self weapon_take(current);
    weapondata = merge_weapons(curweapondata, weapondata);
  }

  weapon = weapondata[#"weapon"];
  weapon_give(weapon, 1);

  if(weapon != level.weaponnone) {
    if(weapondata[#"clip"] + weapondata[#"stock"] <= weapon.clipsize) {
      self setweaponammoclip(weapon, weapon.clipsize);
      self setweaponammostock(weapon, 0);
    } else {
      self setweaponammoclip(weapon, weapondata[#"clip"]);
      self setweaponammostock(weapon, weapondata[#"stock"]);
    }

    if(isDefined(weapondata[#"fuel"])) {
      self setweaponammofuel(weapon, weapondata[#"fuel"]);
    }

    if(isDefined(weapondata[#"heat"]) && isDefined(weapondata[#"overheat"])) {
      self setweaponoverheating(weapondata[#"overheat"], weapondata[#"heat"], weapon);
    }

    if(weapon.isgadget && isDefined(weapondata[#"power"])) {
      slot = self gadgetgetslot(weapon);

      if(slot >= 0) {
        self gadgetpowerset(slot, weapondata[#"power"]);
      }
    }

    if(weapon.isriotshield && isDefined(weapondata[#"health"])) {
      self.weaponhealth = weapondata[#"health"];
    }
  }

  dw_weapon = weapon.dualwieldweapon;

  if(function_386dacbc(dw_weapon) != level.weaponnone) {
    if(!self hasweapon(dw_weapon)) {
      self giveweapon(dw_weapon);
    }

    self setweaponammoclip(dw_weapon, weapondata[#"lh_clip"]);
  }

  alt_weapon = weapon.altweapon;

  if(function_386dacbc(alt_weapon) != level.weaponnone) {
    if(!self hasweapon(alt_weapon)) {
      self giveweapon(alt_weapon);
    }

    self setweaponammoclip(alt_weapon, weapondata[#"alt_clip"]);
    self setweaponammostock(alt_weapon, weapondata[#"alt_stock"]);
  }

  if(isDefined(weapondata[#"aat"])) {
    self aat::acquire(weapon, weapondata[#"aat"]);
  }

  if(isDefined(weapondata[#"repacks"]) && weapondata[#"repacks"] > 0) {
    self zm_pap_util::repack_weapon(weapon, weapondata[#"repacks"]);
  }

  return weapon;
}

weapondata_take(weapondata) {
  weapon = weapondata[#"weapon"];

  if(weapon != level.weaponnone) {
    if(self hasweapon(weapon)) {
      self weapon_take(weapon);
    }
  }

  dw_weapon = weapon.dualwieldweapon;

  if(dw_weapon != level.weaponnone) {
    if(self hasweapon(dw_weapon)) {
      self weapon_take(dw_weapon);
    }
  }

  alt_weapon = weapon.altweapon;
  a_alt_weapons = [];

  while(alt_weapon != level.weaponnone) {
    if(!isDefined(a_alt_weapons)) {
      a_alt_weapons = [];
    } else if(!isarray(a_alt_weapons)) {
      a_alt_weapons = array(a_alt_weapons);
    }

    if(!isinarray(a_alt_weapons, alt_weapon)) {
      a_alt_weapons[a_alt_weapons.size] = alt_weapon;
    }

    if(self hasweapon(alt_weapon)) {
      self weapon_take(alt_weapon);
    }

    alt_weapon = alt_weapon.altweapon;

    if(isinarray(a_alt_weapons, alt_weapon)) {
      println("<dev string:xe9>" + function_9e72a96(alt_weapon.name) + "<dev string:x108>");
      break;
    }
  }
}

create_loadout(weapons) {
  weaponnone = getweapon(#"none");

  if(isDefined(level.weaponnone)) {
    weaponnone = level.weaponnone;
  }

  loadout = spawnStruct();
  loadout.weapons = [];

  foreach(weapon in weapons) {
    if(isstring(weapon)) {
      weapon = getweapon(weapon);
    }

    if(weapon == weaponnone) {
      println("<dev string:x1a0>" + weapon.name);
    }

    loadout.weapons[weapon.name] = get_default_weapondata(weapon);

    if(!isDefined(loadout.current)) {
      loadout.current = weapon;
    }
  }

  return loadout;
}

player_get_loadout() {
  loadout = spawnStruct();
  loadout.current = self getcurrentweapon();
  loadout.stowed = self getstowedweapon();
  loadout.weapons = [];

  foreach(weapon in self getweaponslist()) {
    loadout.weapons[weapon.name] = self get_player_weapondata(weapon);
  }

  return loadout;
}

player_give_loadout(loadout, replace_existing = 1, immediate_switch = 0) {
  if(replace_existing) {
    self takeallweapons();
  }

  foreach(weapondata in loadout.weapons) {
    if(isDefined(weapondata[#"weapon"].isheroweapon) && weapondata[#"weapon"].isheroweapon) {
      self zm_hero_weapon::hero_give_weapon(self.var_fd05e363, 0);
      w_weapon = weapondata[#"weapon"];

      if(w_weapon.isgadget && isDefined(weapondata[#"power"])) {
        slot = self gadgetgetslot(w_weapon);

        if(slot >= 0) {
          self gadgetpowerset(slot, weapondata[#"power"]);
        }
      }

      continue;
    }

    self weapondata_give(weapondata);
  }

  if(self getweaponslistprimaries().size == 0) {
    self zm_loadout::give_start_weapon(1);
  }

  if(!zm_loadout::is_offhand_weapon(loadout.current)) {
    if(immediate_switch) {
      self switchtoweaponimmediate(loadout.current);
    } else {
      self switchtoweapon(loadout.current);
    }
  } else if(immediate_switch) {
    self switchtoweaponimmediate();
  } else {
    self switchtoweapon();
  }

  if(isDefined(loadout.stowed)) {
    self setstowedweapon(loadout.stowed);
  }
}

player_take_loadout(loadout) {
  foreach(weapondata in loadout.weapons) {
    self weapondata_take(weapondata);
  }
}

register_zombie_weapon_callback(weapon, func) {
  if(!isDefined(level.zombie_weapons_callbacks)) {
    level.zombie_weapons_callbacks = [];
  }

  if(!isDefined(level.zombie_weapons_callbacks[weapon])) {
    level.zombie_weapons_callbacks[weapon] = func;
  }
}

set_stowed_weapon(weapon) {
  self.weapon_stowed = weapon;

  if(!(isDefined(self.stowed_weapon_suppressed) && self.stowed_weapon_suppressed)) {
    self setstowedweapon(self.weapon_stowed);
  }
}

clear_stowed_weapon() {
  self notify(#"hash_70957a1035bda74b");
  self.weapon_stowed = undefined;
  self clearstowedweapon();
}

suppress_stowed_weapon(onoff) {
  self.stowed_weapon_suppressed = onoff;

  if(onoff || !isDefined(self.weapon_stowed)) {
    self clearstowedweapon();
    return;
  }

  self setstowedweapon(self.weapon_stowed);
}

checkstringvalid(hash_or_str) {
  if(hash_or_str != "") {
    return hash_or_str;
  }

  return undefined;
}

load_weapon_spec_from_table(table, first_row) {
  gametype = util::get_game_type();
  index = first_row;

  for(row = tablelookuprow(table, index); isDefined(row); row = tablelookuprow(table, index)) {
    weapon_name = checkstringvalid(row[0]);

    if(isinarray(level.var_c60359dc, weapon_name)) {
      index++;
      row = tablelookuprow(table, index);
      continue;
    }

    if(!isDefined(level.var_c60359dc)) {
      level.var_c60359dc = [];
    } else if(!isarray(level.var_c60359dc)) {
      level.var_c60359dc = array(level.var_c60359dc);
    }

    level.var_c60359dc[level.var_c60359dc.size] = weapon_name;
    upgrade_name = checkstringvalid(row[1]);
    is_ee = row[2];
    cost = row[3];
    weaponvo = checkstringvalid(row[4]);
    weaponvoresp = checkstringvalid(row[5]);
    ammo_cost = row[6];
    create_vox = row[7];
    is_zcleansed = row[8];
    in_box = row[9];
    upgrade_in_box = row[10];
    is_limited = row[11];
    var_ddca6652 = row[17];
    limit = row[12];
    upgrade_limit = row[13];
    content_restrict = row[14];
    wallbuy_autospawn = row[15];
    weapon_class = checkstringvalid(row[16]);
    is_wonder_weapon = row[18];
    tier = row[19];
    zm_utility::include_weapon(weapon_name, in_box);

    if(isDefined(upgrade_name)) {
      zm_utility::include_weapon(upgrade_name, upgrade_in_box);
    }

    add_zombie_weapon(weapon_name, upgrade_name, is_ee, cost, weaponvo, weaponvoresp, ammo_cost, create_vox, weapon_class, is_wonder_weapon, tier, in_box);

    if(is_limited) {
      if(isDefined(limit)) {
        add_limited_weapon(weapon_name, limit);
      }

      if(isDefined(upgrade_limit) && isDefined(upgrade_name)) {
        add_limited_weapon(upgrade_name, upgrade_limit);
      }
    }

    if(!var_ddca6652 && weapon_class !== "equipment") {
      aat::register_aat_exemption(getweapon(weapon_name));

      if(isDefined(upgrade_name)) {
        aat::register_aat_exemption(getweapon(upgrade_name));
      }
    }

    index++;
  }
}

is_wonder_weapon(w_to_check) {
  w_base = get_base_weapon(w_to_check);

  if(isDefined(level.zombie_weapons[w_base]) && level.zombie_weapons[w_base].is_wonder_weapon) {
    return true;
  }

  return false;
}

is_tactical_rifle(w_to_check) {
  if(level.zombie_weapons[w_to_check].weapon_classname === "tr") {
    return true;
  }

  return false;
}

is_explosive_weapon(weapon) {
  if(weapon.explosioninnerdamage > 0 || weapon.explosionouterdamage > 0) {
    return true;
  }

  return false;
}

function_f5a0899d(weapon, var_d921715f = 1) {
  if(isDefined(weapon)) {
    if(!var_d921715f && is_wonder_weapon(weapon)) {
      return false;
    }

    var_3ba4bf7d = self getweaponslistprimaries();

    if(isinarray(var_3ba4bf7d, weapon)) {
      return true;
    }
  }

  return false;
}

function_7c5dd4bd(w_weapon) {
  if(zm_loadout::function_2ff6913(w_weapon)) {
    return;
  }

  if(!self hasweapon(w_weapon)) {
    return;
  }

  self setweaponammoclip(w_weapon, w_weapon.clipsize);
  self notify(#"hash_278526d0bbdb4ce7");

  if(zm_trial_reset_loadout::is_active(1)) {
    self function_7f7c1226(w_weapon);
    return;
  }

  if(self hasperk(#"specialty_extraammo")) {
    self givemaxammo(w_weapon);
    return;
  }

  self givestartammo(w_weapon);
}

private function_7f7c1226(weapon) {
  waittillframeend();

  if(weaponhasattachment(weapon, "uber") && weapon.statname == #"smg_capacity_t8" || isDefined(weapon.isriotshield) && weapon.isriotshield) {
    n_stock = weapon.clipsize;
  } else {
    n_stock = 0;
  }

  self setweaponammostock(weapon, n_stock);
}

function_35746b9c(weapon, str_mod = "MOD_MELEE") {
  w_root = function_93cd8e76(weapon, 1);

  if(w_root.name == "pistol_standard_t8" || w_root.name == "ar_stealth_t8") {
    if(weaponhasattachment(weapon, "uber") && str_mod == "MOD_MELEE") {
      return true;
    }
  }

  return false;
}

function_ed29dde5(var_947d01ee, var_ccd1bc81 = 0, var_609a8d33 = 0) {
  a_weapons = [];

  foreach(s_weapon in level.zombie_weapons) {
    if(s_weapon.weapon_classname === var_947d01ee) {
      if(var_609a8d33) {
        if(!isDefined(a_weapons)) {
          a_weapons = [];
        } else if(!isarray(a_weapons)) {
          a_weapons = array(a_weapons);
        }

        a_weapons[a_weapons.size] = s_weapon.weapon.name;
      } else {
        if(!isDefined(a_weapons)) {
          a_weapons = [];
        } else if(!isarray(a_weapons)) {
          a_weapons = array(a_weapons);
        }

        a_weapons[a_weapons.size] = s_weapon.weapon;
      }

      if(var_ccd1bc81) {
        if(var_609a8d33) {
          if(!isDefined(a_weapons)) {
            a_weapons = [];
          } else if(!isarray(a_weapons)) {
            a_weapons = array(a_weapons);
          }

          a_weapons[a_weapons.size] = s_weapon.upgrade.name;
        } else {
          if(!isDefined(a_weapons)) {
            a_weapons = [];
          } else if(!isarray(a_weapons)) {
            a_weapons = array(a_weapons);
          }

          a_weapons[a_weapons.size] = s_weapon.upgrade;
        }
      }
    }

    if(s_weapon.weapon_classname === "shield" && var_947d01ee != "shield") {
      if(s_weapon.weapon.weapclass === var_947d01ee) {
        if(var_609a8d33) {
          if(!isDefined(a_weapons)) {
            a_weapons = [];
          } else if(!isarray(a_weapons)) {
            a_weapons = array(a_weapons);
          }

          a_weapons[a_weapons.size] = s_weapon.weapon.name;

          if(s_weapon.weapon.dualwieldweapon != level.weaponnone) {
            if(!isDefined(a_weapons)) {
              a_weapons = [];
            } else if(!isarray(a_weapons)) {
              a_weapons = array(a_weapons);
            }

            a_weapons[a_weapons.size] = s_weapon.weapon.dualwieldweapon.name;
          }
        } else {
          if(!isDefined(a_weapons)) {
            a_weapons = [];
          } else if(!isarray(a_weapons)) {
            a_weapons = array(a_weapons);
          }

          a_weapons[a_weapons.size] = s_weapon.weapon;

          if(s_weapon.weapon.dualwieldweapon != level.weaponnone) {
            if(!isDefined(a_weapons)) {
              a_weapons = [];
            } else if(!isarray(a_weapons)) {
              a_weapons = array(a_weapons);
            }

            a_weapons[a_weapons.size] = s_weapon.weapon.dualwieldweapon;
          }
        }
      }

      if(s_weapon.weapon.altweapon.weapclass === var_947d01ee) {
        if(var_609a8d33) {
          if(!isDefined(a_weapons)) {
            a_weapons = [];
          } else if(!isarray(a_weapons)) {
            a_weapons = array(a_weapons);
          }

          a_weapons[a_weapons.size] = s_weapon.weapon.altweapon.name;
          continue;
        }

        if(!isDefined(a_weapons)) {
          a_weapons = [];
        } else if(!isarray(a_weapons)) {
          a_weapons = array(a_weapons);
        }

        a_weapons[a_weapons.size] = s_weapon.weapon.altweapon;
      }
    }
  }

  return a_weapons;
}