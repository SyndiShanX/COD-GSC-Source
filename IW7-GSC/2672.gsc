/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2672.gsc
**************************************/

init() {
  level.weaponranktable = spawnStruct();
  level.weaponranktable.rankinfo = [];
  var_0 = 0;

  for(;;) {
    var_1 = int(tablelookuprownum("mp\weaponRankTable.csv", 0, var_0));

    if(!isDefined(var_1) || var_1 < 0) {
      break;
    }
    var_2 = spawnStruct();
    level.weaponranktable.rankinfo[var_0] = var_2;
    var_2.minxp = int(tablelookupbyrow("mp\weaponRankTable.csv", var_0, 1));
    var_2.xptonextrank = int(tablelookupbyrow("mp\weaponRankTable.csv", var_0, 2));
    var_2.maxxp = int(tablelookupbyrow("mp\weaponRankTable.csv", var_0, 3));
    var_0++;
  }

  level.weaponranktable.maxrank = var_0 - 1;
  level.weaponranktable.maxweaponranks = [];
  var_3 = 1;

  for(;;) {
    var_1 = int(tablelookuprownum("mp\statstable.csv", 0, var_3));

    if(!isDefined(var_1) || var_1 < 0) {
      break;
    }
    var_4 = tablelookupbyrow("mp\statstable.csv", var_1, 4);
    var_5 = tablelookupbyrow("mp\statstable.csv", var_1, 42);

    if(!isDefined(var_4) || var_4 == "" || !isDefined(var_5) || var_5 == "") {} else {
      var_5 = int(var_5);
      level.weaponranktable.maxweaponranks[var_4] = var_5;
    }

    var_3++;
  }

  init_weapon_rank_events();
}

init_weapon_rank_events() {
  var_0 = "scripts\cp\maps\cp_zmb\cp_zmb_weaponrank_event.csv";

  if(isDefined(level.weapon_rank_event_table)) {
    var_0 = level.weapon_rank_event_table;
  }

  level.weapon_rank_event = [];
  var_1 = 1;

  for(;;) {
    var_2 = tablelookup(var_0, 0, var_1, 1);

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }
    var_3 = int(tablelookup(var_0, 0, var_1, 2));
    level.weapon_rank_event[var_2] = var_3;
    var_1++;
  }
}

try_give_player_weapon_xp(var_0, var_1, var_2, var_3) {
  if(!level.onlinegame) {
    return;
  }
  if(isai(var_0) || !isPlayer(var_0) || !weapon_progression_enabled() || !is_weapon_unlocked(var_0, var_1)) {
    return;
  }
  var_4 = scripts\cp\utility::getbaseweaponname(var_1);

  if(!weapon_should_get_xp(var_4)) {
    return;
  }
  give_player_weapon_xp(var_0, var_4, get_xp_value(var_0, var_2, var_3));
}

give_player_weapon_xp(var_0, var_1, var_2) {
  var_3 = get_player_weapon_rank_cp_xp(var_0, var_1);
  var_4 = get_player_weapon_rank_mp_xp(var_0, var_1);
  var_5 = var_3 + var_4;
  var_6 = get_weapon_rank_for_xp(var_5);
  var_7 = get_max_weapon_rank_for_root_weapon(var_1);
  var_8 = get_weapon_max_rank_xp(var_1);
  var_9 = var_8 - var_4;
  var_10 = var_3 + var_2;

  if(var_10 > var_9) {
    var_10 = var_9;
  }

  var_11 = var_10 + var_4;
  var_12 = var_0 getrankedplayerdata("common", "sharedProgression", "weaponLevel", var_1, "prestige");
  var_13 = int(min(get_weapon_rank_for_xp(var_11), var_7));
  var_0 setrankedplayerdata("common", "sharedProgression", "weaponLevel", var_1, "cpXP", var_10);

  if(var_6 < var_13) {
    var_0 scripts\cp\cp_hud_message::showsplash("ranked_up_weapon_" + var_1, var_13 + 1);
  }
}

weapon_progression_enabled() {
  if(scripts\engine\utility::is_true(level.disable_weapon_progression)) {
    return 0;
  }

  return 1;
}

is_weapon_unlocked(var_0, var_1) {
  var_2 = var_0 scripts\cp\cp_persistence::get_player_rank();
  var_3 = scripts\cp\utility::getbaseweaponname(var_1);
  var_4 = int(tablelookup("mp\unlocks\CPWeaponUnlocks.csv", 0, var_3, 7));

  if(var_2 >= var_4) {
    return 1;
  } else {
    return 0;
  }
}

get_player_weapon_rank_cp_xp(var_0, var_1) {
  var_2 = var_0 getrankedplayerdata("common", "sharedProgression", "weaponLevel", var_1, "cpXP");
  return var_2;
}

get_player_weapon_rank_mp_xp(var_0, var_1) {
  var_2 = var_0 getrankedplayerdata("common", "sharedProgression", "weaponLevel", var_1, "mpXP");
  return var_2;
}

weapon_should_get_xp(var_0) {
  return weapon_has_ranks(var_0);
}

weapon_has_ranks(var_0) {
  if(!isDefined(level.weaponranktable.maxweaponranks[var_0])) {
    return 0;
  }

  return 1;
}

get_weapon_rank_for_xp(var_0) {
  if(var_0 == 0) {
    return 0;
  }

  for(var_1 = get_max_weapon_rank() - 1; var_1 >= 0; var_1--) {
    if(var_0 >= get_weapon_rank_info_min_xp(var_1)) {
      return var_1;
    }
  }

  return var_1;
}

get_max_weapon_rank() {
  return level.weaponranktable.maxrank;
}

get_weapon_rank_info_min_xp(var_0) {
  return level.weaponranktable.rankinfo[var_0].minxp;
}

get_weapon_max_rank_xp(var_0) {
  var_1 = get_max_weapon_rank_for_root_weapon(var_0);
  return get_weapon_rank_info_max_xp(var_1);
}

get_max_weapon_rank_for_root_weapon(var_0) {
  return level.weaponranktable.maxweaponranks[var_0];
}

get_weapon_rank_info_max_xp(var_0) {
  return level.weaponranktable.rankinfo[var_0].maxxp;
}

get_xp_value(var_0, var_1, var_2) {
  var_3 = get_event_xp_base_value(var_1);
  var_4 = get_event_xp_multiplier_value(var_2);
  var_5 = get_player_weapon_xp_scalar(var_0);
  var_6 = int(var_3 * var_4 * var_5);
  return var_6;
}

try_give_weapon_xp_zombie_killed(var_0, var_1, var_2, var_3, var_4) {
  try_give_player_weapon_xp(var_0, var_1, var_4, get_zombie_killed_weapon_xp_multiplier_type(var_1, var_2, var_3, var_0));
}

get_zombie_killed_weapon_xp_multiplier_type(var_0, var_1, var_2, var_3) {
  if(scripts\cp\utility::isheadshot(var_0, var_1, var_2, var_3)) {
    return "headshot";
  }

  return undefined;
}

get_player_weapon_xp_scalar(var_0) {
  if(isDefined(var_0.weaponxpscale)) {
    return var_0.weaponxpscale;
  } else {
    return 1;
  }
}

get_event_xp_base_value(var_0) {
  if(!isDefined(level.weapon_rank_event[var_0])) {
    return 0;
  }

  return level.weapon_rank_event[var_0];
}

get_event_xp_multiplier_value(var_0) {
  if(!isDefined(var_0)) {
    return 1;
  }

  switch (var_0) {
    case "headshot":
      return 1.5;
    default:
  }
}