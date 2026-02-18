/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_weapons.csc
***********************************************/

#using script_101d8280497ff416;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_inventory_util;
#using scripts\core_common\item_world;
#using scripts\core_common\item_world_util;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weapons;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_wallbuy;
#namespace zm_weapons;

function private autoexec __init__system__() {
  system::register(#"zm_weapons", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  level flag::init("weapon_table_loaded");
  callback::on_localclient_connect(&on_player_connect);
  level.weaponnone = getweapon(#"none");
  level.weaponnull = getweapon(#"weapon_null");
  level.weapondefault = getweapon(#"defaultweapon");
  level.weaponbasemelee = getweapon(#"knife");

  if(!isDefined(level.zombie_weapons_upgraded)) {
    level.zombie_weapons_upgraded = [];
  }

  if(!isDefined(level.var_11173af4)) {
    level.var_11173af4 = [];
  }

  weapons::init_shared();
}

function private postinit() {
  init_weapons();
  function_8389c033(#"ray_gun", #"ray_gun");
  function_8389c033(#"ray_gun", #"ray_gun_upgraded");
  function_8389c033(#"ray_gun_upgraded", #"ray_gun");
  function_8389c033(#"ray_gun_upgraded", #"ray_gun_upgraded");
  function_8389c033(#"ww_ray_rifle_t9", #"ww_ray_rifle_t9");
  function_8389c033(#"ww_ray_rifle_t9", #"ww_ray_rifle_t9_upgraded");
  function_8389c033(#"ww_ray_rifle_t9_upgraded", #"ww_ray_rifle_t9");
  function_8389c033(#"ww_ray_rifle_t9_upgraded", #"ww_ray_rifle_t9_upgraded");
  function_8389c033(#"ray_gun", #"ww_ray_rifle_t9");
  function_8389c033(#"ray_gun_upgraded", #"ww_ray_rifle_t9");
  function_8389c033(#"ray_gun", #"ww_ray_rifle_t9_upgraded");
  function_8389c033(#"ray_gun_upgraded", #"ww_ray_rifle_t9_upgraded");
  function_8389c033(#"ww_ray_rifle_t9", #"ray_gun");
  function_8389c033(#"ww_ray_rifle_t9_upgraded", #"ray_gun");
  function_8389c033(#"ww_ray_rifle_t9", #"ray_gun_upgraded");
  function_8389c033(#"ww_ray_rifle_t9_upgraded", #"ray_gun_upgraded");
  function_8389c033(#"ww_mega_barrel_fullauto_copycat_t9", #"ww_mega_barrel_fullauto_copycat_t9");
  function_8389c033(#"ww_mega_barrel_fullauto_copycat_t9", #"ww_mega_barrel_fullauto_blazer_beam_t9");
  function_8389c033(#"ww_mega_barrel_fullauto_copycat_t9", #"ww_mega_barrel_fullauto_diffusion_beam_t9");
  function_8389c033(#"ww_mega_barrel_fullauto_copycat_t9", #"ww_mega_barrel_fullauto_micro_missile_t9");
  function_8389c033(#"ww_mega_barrel_fullauto_blazer_beam_t9", #"ww_mega_barrel_fullauto_copycat_t9");
  function_8389c033(#"ww_mega_barrel_fullauto_blazer_beam_t9", #"ww_mega_barrel_fullauto_blazer_beam_t9");
  function_8389c033(#"ww_mega_barrel_fullauto_blazer_beam_t9", #"ww_mega_barrel_fullauto_diffusion_beam_t9");
  function_8389c033(#"ww_mega_barrel_fullauto_blazer_beam_t9", #"ww_mega_barrel_fullauto_micro_missile_t9");
  function_8389c033(#"ww_mega_barrel_fullauto_diffusion_beam_t9", #"ww_mega_barrel_fullauto_copycat_t9");
  function_8389c033(#"ww_mega_barrel_fullauto_diffusion_beam_t9", #"ww_mega_barrel_fullauto_blazer_beam_t9");
  function_8389c033(#"ww_mega_barrel_fullauto_diffusion_beam_t9", #"ww_mega_barrel_fullauto_diffusion_beam_t9");
  function_8389c033(#"ww_mega_barrel_fullauto_diffusion_beam_t9", #"ww_mega_barrel_fullauto_micro_missile_t9");
  function_8389c033(#"ww_mega_barrel_fullauto_micro_missile_t9", #"ww_mega_barrel_fullauto_copycat_t9");
  function_8389c033(#"ww_mega_barrel_fullauto_micro_missile_t9", #"ww_mega_barrel_fullauto_blazer_beam_t9");
  function_8389c033(#"ww_mega_barrel_fullauto_micro_missile_t9", #"ww_mega_barrel_fullauto_diffusion_beam_t9");
  function_8389c033(#"ww_mega_barrel_fullauto_micro_missile_t9", #"ww_mega_barrel_fullauto_micro_missile_t9");
  level.var_69fa4969 = &function_2bcaec6f;
}

function function_2a207572(item_name) {
  if(!isDefined(level.var_3fd97ca3)) {
    level.var_3fd97ca3 = [];
  }

  if(!isDefined(level.var_3fd97ca3)) {
    level.var_3fd97ca3 = [];
  } else if(!isarray(level.var_3fd97ca3)) {
    level.var_3fd97ca3 = array(level.var_3fd97ca3);
  }

  level.var_3fd97ca3[level.var_3fd97ca3.size] = item_name;
}

function function_8389c033(weapon_name, var_b72e8856) {
  weapon = getweapon(weapon_name);
  var_6ae93843 = getweapon(var_b72e8856);

  if(!isDefined(level.var_11173af4[weapon])) {
    level.var_11173af4[weapon] = [];
  }

  if(!isDefined(level.var_11173af4[weapon])) {
    level.var_11173af4[weapon] = [];
  } else if(!isarray(level.var_11173af4[weapon])) {
    level.var_11173af4[weapon] = array(level.var_11173af4[weapon]);
  }

  level.var_11173af4[weapon][level.var_11173af4[weapon].size] = var_6ae93843;
}

function function_2bcaec6f(localclientnum, itementry) {
  if(!(isDefined(itementry) && isDefined(itementry.weapon)) || !isDefined(localclientnum)) {
    return;
  }

  data = item_world::function_a7e98a1a(localclientnum);
  current_weapon = getcurrentweapon(localclientnum);
  current_weapon = get_base_weapon(current_weapon);
  var_3ccb716f = get_base_weapon(itementry.weapon);
  weapon1 = data.inventory.items[17 + 1];
  weapon2 = data.inventory.items[17 + 1 + 8 + 1];
  var_5df29481 = data.inventory.items[17 + 1 + 8 + 1 + 8 + 1];
  weapon1 = self item_inventory_util::function_2b83d3ff(weapon1);
  weapon2 = self item_inventory_util::function_2b83d3ff(weapon2);
  var_5df29481 = self item_inventory_util::function_2b83d3ff(var_5df29481);

  if(!(isDefined(weapon1) && isDefined(weapon2))) {
    return 1;
  }

  weapon1 = get_base_weapon(weapon1);
  weapon2 = get_base_weapon(weapon2);

  if(isDefined(var_5df29481)) {
    var_5df29481 = get_base_weapon(var_5df29481);
  }

  if(isarray(level.var_11173af4[var_3ccb716f])) {
    var_36e0edce = 0;
    var_7bdcb52a = 0;

    foreach(var_6ae93843 in level.var_11173af4[var_3ccb716f]) {
      if(weapon1 == var_6ae93843 || weapon2 == var_6ae93843 || var_5df29481 === var_6ae93843) {
        var_36e0edce = 1;
        break;
      }
    }

    foreach(var_6ae93843 in level.var_11173af4[var_3ccb716f]) {
      if(self hastalent(localclientnum, #"talent_mulekick_5")) {
        if(current_weapon == var_6ae93843 && isDefined(var_5df29481)) {
          var_7bdcb52a = 1;
        } else {
          var_7bdcb52a = 0;
        }

        continue;
      }

      if(current_weapon == var_6ae93843) {
        var_7bdcb52a = 1;
      }
    }

    if(self hastalent(localclientnum, #"talent_mulekick_5")) {
      if(var_36e0edce && current_weapon == var_3ccb716f && !var_7bdcb52a && !isDefined(var_5df29481)) {
        return 0;
      } else if(var_36e0edce && current_weapon != var_3ccb716f && !var_7bdcb52a) {
        return 0;
      }
    } else if(var_36e0edce && current_weapon != var_3ccb716f && !var_7bdcb52a) {
      return 0;
    }
  }

  return 1;
}

function get_base_weapon(upgradedweapon) {
  if(isDefined(upgradedweapon.rootweapon)) {
    upgradedweapon = upgradedweapon.rootweapon;
  }

  if(isDefined(level.zombie_weapons_upgraded[upgradedweapon])) {
    return level.zombie_weapons_upgraded[upgradedweapon];
  }

  return upgradedweapon;
}

function private on_player_connect(localclientnum) {
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
      player_cost = compute_player_weapon_ammo_cost(weaponcost.weapon, weaponcost.ammo_cost, weaponcost.upgraded);
      setweaponcosts(localclientnum, weaponcost.weapon, weaponcost.cost, weaponcost.ammo_cost, player_cost, weaponcost.upgradedweapon);
    }
  }
}

function is_weapon_included(weapon) {
  if(!isDefined(level._included_weapons)) {
    return false;
  }

  return isDefined(level._included_weapons[weapon.rootweapon]);
}

function compute_player_weapon_ammo_cost(weapon, cost, upgraded, n_base_non_wallbuy_cost = 750, n_upgraded_non_wallbuy_cost = 5000) {
  w_root = weapon.rootweapon;

  if(upgraded) {
    if(zm_wallbuy::is_wallbuy(level.zombie_weapons_upgraded[w_root])) {
      n_ammo_cost = 4000;
    } else {
      n_ammo_cost = n_upgraded_non_wallbuy_cost;
    }
  } else if(zm_wallbuy::is_wallbuy(w_root)) {
    n_ammo_cost = cost;
    n_ammo_cost = zm_utility::halve_score(n_ammo_cost);
  } else {
    n_ammo_cost = n_base_non_wallbuy_cost;
  }

  return n_ammo_cost;
}

function include_weapon(weapon_name, display_in_box, cost, ammo_cost, upgraded = 0) {
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
    thread util::error("<dev string:x38>" + function_9e72a96(weapon_name) + "<dev string:x5a>");

    return;
  }
}

function include_upgraded_weapon(weapon_name, upgrade_name, display_in_box, cost, ammo_cost) {
  include_weapon(upgrade_name, display_in_box, cost, ammo_cost, 1);

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

function is_weapon_upgraded(weapon) {
  if(!isDefined(level.zombie_weapons_upgraded)) {
    level.zombie_weapons_upgraded = [];
  }

  rootweapon = weapon.rootweapon;

  if(isDefined(level.zombie_weapons_upgraded[rootweapon])) {
    return true;
  }

  return false;
}

function checkstringvalid(str) {
  if(str != "") {
    return str;
  }

  return undefined;
}

function init_weapons() {
  level.var_c60359dc = [];
  var_4ef031c9 = # "hash_2298893b58cc2885";
  load_weapon_spec_from_table(var_4ef031c9, 0);

  if(isDefined(level.var_d0ab70a2)) {
    load_weapon_spec_from_table(level.var_d0ab70a2, 0);
  }

  level thread function_350ee41();
  level flag::set("weapon_table_loaded");
  level.var_c60359dc = undefined;
}

function function_15827c82(var_904df15f) {
  if(var_904df15f.type === "itemspawnlist") {
    foreach(s_item in var_904df15f.itemlist) {
      var_89230090 = getscriptbundle(s_item.itementry);

      if(var_89230090.type === "itemspawnlist") {
        function_15827c82(var_89230090);
        continue;
      }

      if(isDefined(var_89230090.weapon.name)) {
        if(!isDefined(level.var_af500dbd)) {
          level.var_af500dbd = [];
        } else if(!isarray(level.var_af500dbd)) {
          level.var_af500dbd = array(level.var_af500dbd);
        }

        if(!isinarray(level.var_af500dbd, var_89230090.weapon.name)) {
          level.var_af500dbd[level.var_af500dbd.size] = var_89230090.weapon.name;
        }
      }
    }
  }
}

function private function_350ee41() {
  if(!isDefined(level.var_c8b5248e)) {
    level.var_c8b5248e = [];
  }

  if(!isDefined(level.var_1d1c6c28)) {
    level.var_1d1c6c28 = [];
  }

  if(!isDefined(level.var_af500dbd)) {
    level.var_af500dbd = [];
  }

  if(!isDefined(level.str_magicbox_weapon_itemspawnlist)) {
    level.str_magicbox_weapon_itemspawnlist = "zm_magicbox_weapons_list";
  }

  if(!isDefined(level.str_magicbox_support_itemspawnlist)) {
    level.str_magicbox_support_itemspawnlist = "zm_magicbox_scorestreak_list";
  }

  if(!isDefined(level.str_magicbox_named_itemspawnlist)) {
    level.str_magicbox_named_itemspawnlist = "zm_magicbox_named_weapons_parent";
  }

  resetzombieboxweapons();

  if(isDefined(level.var_ee110db8[# "zm_magicbox_named_weapons_parent"])) {
    level.str_magicbox_named_itemspawnlist = level.var_ee110db8[# "zm_magicbox_named_weapons_parent"];
  }

  function_bd6fcf62(level.str_magicbox_weapon_itemspawnlist, "str_magicbox_weapon_itemspawnlist");
  function_bd6fcf62(level.str_magicbox_support_itemspawnlist, "str_magicbox_support_itemspawnlist");
  function_bd6fcf62(level.str_magicbox_named_itemspawnlist, "str_magicbox_named_itemspawnlist");
  level.var_af500dbd = array::randomize(level.var_af500dbd);

  if(isinarray(level.var_af500dbd, #"ray_gun")) {
    arrayremovevalue(level.var_af500dbd, #"ray_gun");
    arrayinsert(level.var_af500dbd, #"ray_gun", 0);
  }

  arrayremovevalue(level.var_af500dbd, #"ultimate_turret");

  foreach(index, var_ff8843d4 in level.var_af500dbd) {
    weapon = getweapon(var_ff8843d4);

    if(isweapon(weapon)) {
      if(!isDefined(level.var_c8b5248e)) {
        level.var_c8b5248e = [];
      } else if(!isarray(level.var_c8b5248e)) {
        level.var_c8b5248e = array(level.var_c8b5248e);
      }

      if(!isinarray(level.var_c8b5248e, weapon)) {
        level.var_c8b5248e[level.var_c8b5248e.size] = weapon;
      }

      if(index < 32) {
        if(!isDefined(level.var_1d1c6c28)) {
          level.var_1d1c6c28 = [];
        } else if(!isarray(level.var_1d1c6c28)) {
          level.var_1d1c6c28 = array(level.var_1d1c6c28);
        }

        if(!isinarray(level.var_1d1c6c28, weapon.worldmodel)) {
          level.var_1d1c6c28[level.var_1d1c6c28.size] = weapon.worldmodel;
        }

        addzombieboxweapon(weapon, weapon.worldmodel, weapon.isdualwield);
      }
    }
  }
}

function private function_bd6fcf62(var_f8dfa2cf, var_3fbf56c8) {
  if(!isDefined(var_f8dfa2cf)) {
    return;
  }

  if(isDefined(level.var_ee110db8[var_f8dfa2cf])) {
    level.(var_3fbf56c8) = level.var_ee110db8[var_f8dfa2cf];
  }

  var_83b3038e = getscriptbundle(var_f8dfa2cf);

  if(!isDefined(var_83b3038e)) {
    return;
  }

  foreach(s_item in var_83b3038e.itemlist) {
    itementry = s_item.itementry;

    if(isDefined(level.var_ee110db8[itementry])) {
      itementry = level.var_ee110db8[itementry];
    } else if(isDefined(level.itemreplacement[itementry])) {
      itementry = level.itemreplacement[itementry];
    }

    var_89230090 = getscriptbundle(itementry);

    if(var_89230090.type === "itemspawnlist") {
      function_15827c82(var_89230090);
      continue;
    }

    if(isDefined(var_89230090.weapon.name)) {
      if(!isDefined(level.var_af500dbd)) {
        level.var_af500dbd = [];
      } else if(!isarray(level.var_af500dbd)) {
        level.var_af500dbd = array(level.var_af500dbd);
      }

      if(!isinarray(level.var_af500dbd, var_89230090.weapon.name)) {
        level.var_af500dbd[level.var_af500dbd.size] = var_89230090.weapon.name;
      }
    }
  }
}

function load_weapon_spec_from_table(table, first_row) {
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
    include_weapon(weapon_name, in_box, cost, ammo_cost, 0);

    if(isDefined(upgrade_name)) {
      include_upgraded_weapon(weapon_name, upgrade_name, upgrade_in_box, cost, 4500);
    }

    index++;
  }
}