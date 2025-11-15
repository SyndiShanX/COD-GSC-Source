/****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\cp_weaponrank.gsc
****************************************/

init() {
  level.weaponranktable = spawnStruct();
  level.weaponranktable.rankinfo = [];
  var_00 = 0;
  for(;;) {
    var_01 = int(tablelookuprownum("mp\weaponRankTable.csv", 0, var_00));
    if(!isDefined(var_01) || var_01 < 0) {
      break;
    }

    var_02 = spawnStruct();
    level.weaponranktable.rankinfo[var_00] = var_02;
    var_02.minxp = int(tablelookupbyrow("mp\weaponRankTable.csv", var_00, 1));
    var_02.xptonextrank = int(tablelookupbyrow("mp\weaponRankTable.csv", var_00, 2));
    var_02.maxxp = int(tablelookupbyrow("mp\weaponRankTable.csv", var_00, 3));
    var_00++;
  }

  level.weaponranktable.maxrank = var_00 - 1;
  level.weaponranktable.maxweaponranks = [];
  var_03 = 1;
  for(;;) {
    var_01 = int(tablelookuprownum("mp\statstable.csv", 0, var_03));
    if(!isDefined(var_01) || var_01 < 0) {
      break;
    }

    var_04 = tablelookupbyrow("mp\statstable.csv", var_01, 4);
    var_05 = tablelookupbyrow("mp\statstable.csv", var_01, 42);
    if(!isDefined(var_04) || var_04 == "" || !isDefined(var_05) || var_05 == "") {} else {
      var_05 = int(var_05);
      level.weaponranktable.maxweaponranks[var_04] = var_05;
    }

    var_03++;
  }

  init_weapon_rank_events();
}

init_weapon_rank_events() {
  var_00 = "scripts\cp\maps\cp_zmb\cp_zmb_weaponrank_event.csv";
  if(isDefined(level.weapon_rank_event_table)) {
    var_00 = level.weapon_rank_event_table;
  }

  level.weapon_rank_event = [];
  var_01 = 1;
  for(;;) {
    var_02 = tablelookup(var_00, 0, var_01, 1);
    if(!isDefined(var_02) || var_02 == "") {
      break;
    }

    var_03 = int(tablelookup(var_00, 0, var_01, 2));
    level.weapon_rank_event[var_02] = var_03;
    var_01++;
  }
}

try_give_player_weapon_xp(param_00, param_01, param_02, param_03) {
  if(!level.onlinegame) {
    return;
  }

  if(isai(param_00) || !isplayer(param_00) || !weapon_progression_enabled() || !is_weapon_unlocked(param_00, param_01)) {
    return;
  }

  var_04 = scripts\cp\utility::getbaseweaponname(param_01);
  if(!weapon_should_get_xp(var_04)) {
    return;
  }

  give_player_weapon_xp(param_00, var_04, get_xp_value(param_00, param_02, param_03));
}

give_player_weapon_xp(param_00, param_01, param_02) {
  var_03 = get_player_weapon_rank_cp_xp(param_00, param_01);
  var_04 = get_player_weapon_rank_mp_xp(param_00, param_01);
  var_05 = var_03 + var_04;
  var_06 = get_weapon_rank_for_xp(var_05);
  var_07 = get_max_weapon_rank_for_root_weapon(param_01);
  var_08 = get_weapon_max_rank_xp(param_01);
  var_09 = var_08 - var_04;
  var_0A = var_03 + param_02;
  if(var_0A > var_09) {
    var_0A = var_09;
  }

  var_0B = var_0A + var_04;
  var_0C = param_00 getplayerdata("common", "sharedProgression", "weaponLevel", param_01, "prestige");
  var_0D = int(min(get_weapon_rank_for_xp(var_0B), var_07));
  param_00 setplayerdata("common", "sharedProgression", "weaponLevel", param_01, "cpXP", var_0A);
  if(var_06 < var_0D) {
    param_00 scripts\cp\cp_hud_message::showsplash("ranked_up_weapon_" + param_01, var_0D + 1);
  }
}

weapon_progression_enabled() {
  if(scripts\engine\utility::istrue(level.disable_weapon_progression)) {
    return 0;
  }

  return 1;
}

is_weapon_unlocked(param_00, param_01) {
  var_02 = param_00 scripts\cp\cp_persistence::get_player_rank();
  var_03 = scripts\cp\utility::getbaseweaponname(param_01);
  var_04 = int(tablelookup("mp\unlocks\CPWeaponUnlocks.csv", 0, var_03, 7));
  if(var_02 >= var_04) {
    return 1;
  }

  return 0;
}

get_player_weapon_rank_cp_xp(param_00, param_01) {
  var_02 = param_00 getplayerdata("common", "sharedProgression", "weaponLevel", param_01, "cpXP");
  return var_02;
}

get_player_weapon_rank_mp_xp(param_00, param_01) {
  var_02 = param_00 getplayerdata("common", "sharedProgression", "weaponLevel", param_01, "mpXP");
  return var_02;
}

weapon_should_get_xp(param_00) {
  return weapon_has_ranks(param_00);
}

weapon_has_ranks(param_00) {
  if(!isDefined(level.weaponranktable.maxweaponranks[param_00])) {
    return 0;
  }

  return 1;
}

get_weapon_rank_for_xp(param_00) {
  if(param_00 == 0) {
    return 0;
  }

  for(var_01 = get_max_weapon_rank() - 1; var_01 >= 0; var_01--) {
    if(param_00 >= get_weapon_rank_info_min_xp(var_01)) {
      return var_01;
    }
  }

  return var_01;
}

get_max_weapon_rank() {
  return level.weaponranktable.maxrank;
}

get_weapon_rank_info_min_xp(param_00) {
  return level.weaponranktable.rankinfo[param_00].minxp;
}

get_weapon_max_rank_xp(param_00) {
  var_01 = get_max_weapon_rank_for_root_weapon(param_00);
  return get_weapon_rank_info_max_xp(var_01);
}

get_max_weapon_rank_for_root_weapon(param_00) {
  return level.weaponranktable.maxweaponranks[param_00];
}

get_weapon_rank_info_max_xp(param_00) {
  return level.weaponranktable.rankinfo[param_00].maxxp;
}

get_xp_value(param_00, param_01, param_02) {
  var_03 = get_event_xp_base_value(param_01);
  var_04 = get_event_xp_multiplier_value(param_02);
  var_05 = get_player_weapon_xp_scalar(param_00);
  var_06 = int(var_03 * var_04 * var_05);
  return var_06;
}

try_give_weapon_xp_zombie_killed(param_00, param_01, param_02, param_03, param_04) {
  try_give_player_weapon_xp(param_00, param_01, param_04, get_zombie_killed_weapon_xp_multiplier_type(param_01, param_02, param_03, param_00));
}

get_zombie_killed_weapon_xp_multiplier_type(param_00, param_01, param_02, param_03) {
  if(scripts\cp\utility::isheadshot(param_00, param_01, param_02, param_03)) {
    return "headshot";
  }

  return undefined;
}

get_player_weapon_xp_scalar(param_00) {
  if(isDefined(param_00.weaponxpscale)) {
    return param_00.weaponxpscale;
  }

  return 1;
}

get_event_xp_base_value(param_00) {
  if(!isDefined(level.weapon_rank_event[param_00])) {
    return 0;
  }

  return level.weapon_rank_event[param_00];
}

get_event_xp_multiplier_value(param_00) {
  if(!isDefined(param_00)) {
    return 1;
  }

  switch (param_00) {
    case "headshot":
      return 1.5;

    default:
      break;
  }
}