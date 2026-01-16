/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_weapons.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\weapons\zm_weap_chakram;
#include scripts\zm\weapons\zm_weap_hammer;
#include scripts\zm\weapons\zm_weap_scepter;
#include scripts\zm\weapons\zm_weap_sword_pistol;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_wallbuy;

#namespace zm_weapons;

autoexec __init__system__() {
  system::register(#"zm_weapons", &__init__, &__main__, undefined);
}

__init__() {
  level flag::init("weapon_table_loaded");
  callback::on_localclient_connect(&on_player_connect);
  level.weaponnone = getweapon(#"none");
  level.weaponnull = getweapon(#"weapon_null");
  level.weapondefault = getweapon(#"defaultweapon");
  level.weaponbasemelee = getweapon(#"knife");

  if(!isDefined(level.zombie_weapons_upgraded)) {
    level.zombie_weapons_upgraded = [];
  }

  function_ec38915a();
}

__main__() {
  init_weapons();
}

private on_player_connect(localclientnum) {
  if(getmigrationstatus(localclientnum)) {
    return;
  }

  resetweaponcosts(localclientnum);
  level flag::wait_till("weapon_table_loaded");

  if(getgametypesetting(#"zmwallbuysenabled")) {
    level flag::wait_till("weapon_wallbuys_created");
  }

  if(isDefined(level.weapon_costs)) {
    foreach(weaponcost in level.weapon_costs) {
      player_cost = compute_player_weapon_ammo_cost(weaponcost.weapon, weaponcost.ammo_cost, weaponcost.upgraded, undefined, undefined, weaponcost.wonderweapon);
      setweaponcosts(localclientnum, weaponcost.weapon, weaponcost.cost, weaponcost.ammo_cost, player_cost, weaponcost.upgradedweapon);

      if(isDefined(level.var_5a069e6[weaponcost.weapon])) {
        w_dw = level.var_5a069e6[weaponcost.weapon];
        var_8afe76d1 = level.var_5a069e6[weaponcost.upgradedweapon];

        if(!isDefined(var_8afe76d1)) {
          var_8afe76d1 = level.weaponnone;
        }

        setweaponcosts(localclientnum, w_dw, weaponcost.cost, weaponcost.ammo_cost, player_cost, var_8afe76d1);
      }
    }
  }
}

is_weapon_included(weapon) {
  if(!isDefined(level._included_weapons)) {
    return false;
  }

  return isDefined(level._included_weapons[function_386dacbc(weapon)]);
}

compute_player_weapon_ammo_cost(weapon, cost, upgraded, n_base_non_wallbuy_cost = 750, n_upgraded_non_wallbuy_cost = 5000, is_wonder_weapon = 0) {
  w_root = function_386dacbc(weapon);

  if(upgraded) {
    if(zm_wallbuy::is_wallbuy(level.zombie_weapons_upgraded[w_root])) {
      n_ammo_cost = 4000;
    } else if(is_wonder_weapon) {
      n_ammo_cost = 7500;
    } else {
      n_ammo_cost = n_upgraded_non_wallbuy_cost;
    }
  } else if(zm_wallbuy::is_wallbuy(w_root)) {
    n_ammo_cost = cost;
    n_ammo_cost = zm_utility::halve_score(n_ammo_cost);
  } else if(is_wonder_weapon) {
    n_ammo_cost = 4000;
  } else {
    n_ammo_cost = n_base_non_wallbuy_cost;
  }

  return n_ammo_cost;
}

include_weapon(weapon_name, display_in_box, cost, ammo_cost, upgraded = 0, is_wonder_weapon = 0) {
  if(!isDefined(level._included_weapons)) {
    level._included_weapons = [];
  }

  weapon = getweapon(weapon_name);
  level._included_weapons[weapon] = weapon;

  if(!isDefined(level.weapon_costs)) {
    level.weapon_costs = [];
  }

  if(!isDefined(level.weapon_costs[weapon_name])) {
    level.weapon_costs[weapon_name] = spawnStruct();
    level.weapon_costs[weapon_name].weapon = weapon;
    level.weapon_costs[weapon_name].upgradedweapon = level.weaponnone;
    level.weapon_costs[weapon_name].wonderweapon = is_wonder_weapon;
  }

  level.weapon_costs[weapon_name].cost = cost;

  if(!isDefined(ammo_cost) || ammo_cost == 0) {
    ammo_cost = zm_utility::round_up_to_ten(int(cost * 0.5));
  }

  level.weapon_costs[weapon_name].ammo_cost = ammo_cost;
  level.weapon_costs[weapon_name].upgraded = upgraded;

  if(isDefined(display_in_box) && !display_in_box) {
    return;
  }

  if(!isDefined(level._resetzombieboxweapons)) {
    level._resetzombieboxweapons = 1;
    resetzombieboxweapons();
  }

  if(!isDefined(weapon.worldmodel)) {

    thread util::error("<dev string:x38>" + function_9e72a96(weapon_name) + "<dev string:x59>");

      return;
  }

  addzombieboxweapon(weapon, weapon.worldmodel, weapon.isdualwield);
}

include_upgraded_weapon(weapon_name, upgrade_name, display_in_box, cost, ammo_cost, is_wonder_weapon = 0) {
  include_weapon(upgrade_name, display_in_box, cost, ammo_cost, 1, is_wonder_weapon);

  if(!isDefined(level.zombie_weapons_upgraded)) {
    level.zombie_weapons_upgraded = [];
  }

  weapon = getweapon(weapon_name);
  upgrade = getweapon(upgrade_name);
  level.zombie_weapons_upgraded[upgrade] = weapon;

  if(isDefined(level.weapon_costs[weapon_name])) {
    level.weapon_costs[weapon_name].upgradedweapon = upgrade;
  }
}

is_weapon_upgraded(weapon) {
  if(!isDefined(level.zombie_weapons_upgraded)) {
    level.zombie_weapons_upgraded = [];
  }

  rootweapon = function_386dacbc(weapon);

  if(isDefined(level.zombie_weapons_upgraded[rootweapon])) {
    return true;
  }

  return false;
}

checkstringvalid(str) {
  if(str != "") {
    return str;
  }

  return undefined;
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

  level flag::set("weapon_table_loaded");
  level.var_c60359dc = undefined;
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
    cost = row[3];
    weaponvo = checkstringvalid(row[4]);
    weaponvoresp = checkstringvalid(row[5]);
    ammo_cost = row[6];
    create_vox = row[7];
    is_zcleansed = row[8];
    in_box = row[9];
    upgrade_in_box = row[10];
    is_limited = row[11];
    limit = row[12];
    upgrade_limit = row[13];
    content_restrict = row[14];
    wallbuy_autospawn = row[15];
    weapon_class = checkstringvalid(row[16]);
    is_wonder_weapon = row[18];
    tier = row[19];
    include_weapon(weapon_name, in_box, cost, ammo_cost, 0, is_wonder_weapon);

    if(isDefined(upgrade_name)) {
      include_upgraded_weapon(weapon_name, upgrade_name, upgrade_in_box, cost, 4500, is_wonder_weapon);
    }

    index++;
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

function_386dacbc(weapon) {
  rootweapon = weapon.rootweapon;

  if(isDefined(level.var_44e0d625[rootweapon])) {
    rootweapon = level.var_44e0d625[rootweapon];
  }

  return rootweapon;
}