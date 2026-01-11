/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2672.gsc
***************************************/

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
    var_2.minxp = int(tablelookupbyrow("mp\weaponRankTable.csv", var_00, 1));
    var_2.xptonextrank = int(tablelookupbyrow("mp\weaponRankTable.csv", var_00, 2));
    var_2.maxxp = int(tablelookupbyrow("mp\weaponRankTable.csv", var_00, 3));
    var_0++;
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

    var_3++;
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
    var_1++;
  }
}

try_give_player_weapon_xp(var_00, var_01, var_02, var_03) {
  if(!level.onlinegame) {
    return;
  }
  if(isai(var_00) || !isplayer(var_00) || !weapon_progression_enabled() || !is_weapon_unlocked(var_00, var_01)) {
    return;
  }
  var_04 = scripts\cp\utility::getbaseweaponname(var_01);

  if(!weapon_should_get_xp(var_04)) {
    return;
  }
  give_player_weapon_xp(var_00, var_04, get_xp_value(var_00, var_02, var_03));
}

give_player_weapon_xp(var_00, var_01, var_02) {
  var_03 = get_player_weapon_rank_cp_xp(var_00, var_01);
  var_04 = get_player_weapon_rank_mp_xp(var_00, var_01);
  var_05 = var_03 + var_04;
  var_06 = get_weapon_rank_for_xp(var_05);
  var_07 = get_max_weapon_rank_for_root_weapon(var_01);
  var_08 = get_weapon_max_rank_xp(var_01);
  var_09 = var_08 - var_04;
  var_10 = var_03 + var_02;

  if(var_10 > var_09) {
    var_10 = var_09;
  }

  var_11 = var_10 + var_04;
  var_12 = var_00 getrankedplayerdata("common", "sharedProgression", "weaponLevel", var_01, "prestige");
  var_13 = int(min(get_weapon_rank_for_xp(var_11), var_07));
  var_00 setrankedplayerdata("common", "sharedProgression", "weaponLevel", var_01, "cpXP", var_10);

  if(var_06 < var_13) {
    var_00 scripts\cp\cp_hud_message::showsplash("ranked_up_weapon_" + var_01, var_13 + 1);
  }
}

weapon_progression_enabled() {
  if(scripts\engine\utility::is_true(level.disable_weapon_progression)) {
    return 0;
  }

  return 1;
}

is_weapon_unlocked(var_00, var_01) {
  var_02 = var_00 scripts\cp\cp_persistence::get_player_rank();
  var_03 = scripts\cp\utility::getbaseweaponname(var_01);
  var_04 = int(tablelookup("mp\unlocks\CPWeaponUnlocks.csv", 0, var_03, 7));

  if(var_02 >= var_04) {
    return 1;
  } else {
    return 0;
  }
}

get_player_weapon_rank_cp_xp(var_00, var_01) {
  var_02 = var_00 getrankedplayerdata("common", "sharedProgression", "weaponLevel", var_01, "cpXP");
  return var_02;
}

get_player_weapon_rank_mp_xp(var_00, var_01) {
  var_02 = var_00 getrankedplayerdata("common", "sharedProgression", "weaponLevel", var_01, "mpXP");
  return var_02;
}

weapon_should_get_xp(var_00) {
  return weapon_has_ranks(var_00);
}

weapon_has_ranks(var_00) {
  if(!isDefined(level.weaponranktable.maxweaponranks[var_00])) {
    return 0;
  }

  return 1;
}

get_weapon_rank_for_xp(var_00) {
  if(var_00 == 0) {
    return 0;
  }

  for(var_01 = get_max_weapon_rank() - 1; var_01 >= 0; var_1--) {
    if(var_00 >= get_weapon_rank_info_min_xp(var_01)) {
      return var_01;
    }
  }

  return var_01;
}

get_max_weapon_rank() {
  return level.weaponranktable.maxrank;
}

get_weapon_rank_info_min_xp(var_00) {
  return level.weaponranktable.rankinfo[var_00].minxp;
}

get_weapon_max_rank_xp(var_00) {
  var_01 = get_max_weapon_rank_for_root_weapon(var_00);
  return get_weapon_rank_info_max_xp(var_01);
}

get_max_weapon_rank_for_root_weapon(var_00) {
  return level.weaponranktable.maxweaponranks[var_00];
}

get_weapon_rank_info_max_xp(var_00) {
  return level.weaponranktable.rankinfo[var_00].maxxp;
}

get_xp_value(var_00, var_01, var_02) {
  var_03 = get_event_xp_base_value(var_01);
  var_04 = get_event_xp_multiplier_value(var_02);
  var_05 = get_player_weapon_xp_scalar(var_00);
  var_06 = int(var_03 * var_04 * var_05);
  return var_06;
}

try_give_weapon_xp_zombie_killed(var_00, var_01, var_02, var_03, var_04) {
  try_give_player_weapon_xp(var_00, var_01, var_04, get_zombie_killed_weapon_xp_multiplier_type(var_01, var_02, var_03, var_00));
}

get_zombie_killed_weapon_xp_multiplier_type(var_00, var_01, var_02, var_03) {
  if(scripts\cp\utility::isheadshot(var_00, var_01, var_02, var_03)) {
    return "headshot";
  }

  return undefined;
}

get_player_weapon_xp_scalar(var_00) {
  if(isDefined(var_0.weaponxpscale)) {
    return var_0.weaponxpscale;
  } else {
    return 1;
  }
}

get_event_xp_base_value(var_00) {
  if(!isDefined(level.weapon_rank_event[var_00])) {
    return 0;
  }

  return level.weapon_rank_event[var_00];
}

get_event_xp_multiplier_value(var_00) {
  if(!isDefined(var_00)) {
    return 1;
  }

  switch (var_00) {
    case "headshot":
      return 1.5;
    default:
  }
}