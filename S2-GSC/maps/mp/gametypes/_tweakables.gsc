/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_tweakables.gsc
*********************************************/

func_46F5(param_00, param_01) {
  switch (param_00) {
    case "rule":
      var_02 = level.var_7F46[param_01].var_3515;
      break;

    case "game":
      var_02 = level.var_3FDB[var_02].var_3515;
      break;

    case "team":
      var_02 = level.var_986C[var_02].var_3515;
      break;

    case "player":
      var_02 = level.var_747C[var_02].var_3515;
      break;

    case "class":
      var_02 = level.var_2326[var_02].var_3515;
      break;

    case "weapon":
      var_02 = level.var_A9F3[var_02].var_3515;
      break;

    case "hardpoint":
      var_02 = level.var_4B1E[var_02].var_3515;
      break;

    case "hud":
      var_02 = level.var_4F7C[var_02].var_3515;
      break;

    default:
      var_02 = undefined;
      break;
  }

  var_03 = getdvarint(var_02);
  return var_03;
}

func_46F4(param_00, param_01) {
  switch (param_00) {
    case "rule":
      var_02 = level.var_7F46[param_01].var_3515;
      break;

    case "game":
      var_02 = level.var_3FDB[var_02].var_3515;
      break;

    case "team":
      var_02 = level.var_986C[var_02].var_3515;
      break;

    case "player":
      var_02 = level.var_747C[var_02].var_3515;
      break;

    case "class":
      var_02 = level.var_2326[var_02].var_3515;
      break;

    case "weapon":
      var_02 = level.var_A9F3[var_02].var_3515;
      break;

    case "hardpoint":
      var_02 = level.var_4B1E[var_02].var_3515;
      break;

    case "hud":
      var_02 = level.var_4F7C[var_02].var_3515;
      break;

    default:
      var_02 = undefined;
      break;
  }

  return var_02;
}

func_46F7(param_00, param_01, param_02) {
  switch (param_00) {
    case "rule":
      var_03 = level.var_7F46[param_01].var_A281;
      break;

    case "game":
      var_03 = level.var_3FDB[param_02].var_A281;
      break;

    case "team":
      var_03 = level.var_986C[param_02].var_A281;
      break;

    case "player":
      var_03 = level.var_747C[param_02].var_A281;
      break;

    case "class":
      var_03 = level.var_2326[param_02].var_A281;
      break;

    case "weapon":
      var_03 = level.var_A9F3[param_02].var_A281;
      break;

    case "hardpoint":
      var_03 = level.var_4B1E[param_02].var_A281;
      break;

    case "hud":
      var_03 = level.var_4F7C[param_02].var_A281;
      break;

    default:
      var_03 = undefined;
      break;
  }

  return var_03;
}

func_46F6(param_00, param_01) {
  switch (param_00) {
    case "rule":
      var_02 = level.var_7F46[param_01].var_5C0D;
      break;

    case "game":
      var_02 = level.var_3FDB[var_02].var_5C0D;
      break;

    case "team":
      var_02 = level.var_986C[var_02].var_5C0D;
      break;

    case "player":
      var_02 = level.var_747C[var_02].var_5C0D;
      break;

    case "class":
      var_02 = level.var_2326[var_02].var_5C0D;
      break;

    case "weapon":
      var_02 = level.var_A9F3[var_02].var_5C0D;
      break;

    case "hardpoint":
      var_02 = level.var_4B1E[var_02].var_5C0D;
      break;

    case "hud":
      var_02 = level.var_4F7C[var_02].var_5C0D;
      break;

    default:
      var_02 = undefined;
      break;
  }

  return var_02;
}

func_8751(param_00, param_01, param_02) {
  switch (param_00) {
    case "rule":
      var_03 = level.var_7F46[param_01].var_3515;
      break;

    case "game":
      var_03 = level.var_3FDB[param_02].var_3515;
      break;

    case "team":
      var_03 = level.var_986C[param_02].var_3515;
      break;

    case "player":
      var_03 = level.var_747C[param_02].var_3515;
      break;

    case "class":
      var_03 = level.var_2326[param_02].var_3515;
      break;

    case "weapon":
      var_03 = level.var_A9F3[param_02].var_3515;
      break;

    case "hardpoint":
      var_03 = level.var_4B1E[param_02].var_3515;
      break;

    case "hud":
      var_03 = level.var_4F7C[param_02].var_3515;
      break;

    default:
      var_03 = undefined;
      break;
  }

  setDvar(var_03, param_02);
}

func_8750(param_00, param_01, param_02) {
  switch (param_00) {
    case "rule":
      level.var_7F46[param_01].var_5C0D = param_02;
      break;

    case "game":
      level.var_3FDB[param_01].var_5C0D = param_02;
      break;

    case "team":
      level.var_986C[param_01].var_5C0D = param_02;
      break;

    case "player":
      level.var_747C[param_01].var_5C0D = param_02;
      break;

    case "class":
      level.var_2326[param_01].var_5C0D = param_02;
      break;

    case "weapon":
      level.var_A9F3[param_01].var_5C0D = param_02;
      break;

    case "hardpoint":
      level.var_4B1E[param_01].var_5C0D = param_02;
      break;

    case "hud":
      level.var_4F7C[param_01].var_5C0D = param_02;
      break;

    default:
      break;
  }
}

func_7BFD(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(param_04) && param_04) {
    param_03 = getdvarfloat(param_02, param_03);
  } else if(isstring(param_03)) {
    param_03 = getDvar(param_02, param_03);
  } else {
    param_03 = getdvarint(param_02, param_03);
  }

  switch (param_00) {
    case "rule":
      if(!isDefined(level.var_7F46[param_01])) {
        level.var_7F46[param_01] = spawnStruct();
      }

      level.var_7F46[param_01].var_A281 = param_03;
      level.var_7F46[param_01].var_5C0D = param_03;
      level.var_7F46[param_01].var_3515 = param_02;
      break;

    case "game":
      if(!isDefined(level.var_3FDB[param_01])) {
        level.var_3FDB[param_01] = spawnStruct();
      }

      level.var_3FDB[param_01].var_A281 = param_03;
      level.var_3FDB[param_01].var_5C0D = param_03;
      level.var_3FDB[param_01].var_3515 = param_02;
      break;

    case "team":
      if(!isDefined(level.var_986C[param_01])) {
        level.var_986C[param_01] = spawnStruct();
      }

      level.var_986C[param_01].var_A281 = param_03;
      level.var_986C[param_01].var_5C0D = param_03;
      level.var_986C[param_01].var_3515 = param_02;
      break;

    case "player":
      if(!isDefined(level.var_747C[param_01])) {
        level.var_747C[param_01] = spawnStruct();
      }

      level.var_747C[param_01].var_A281 = param_03;
      level.var_747C[param_01].var_5C0D = param_03;
      level.var_747C[param_01].var_3515 = param_02;
      break;

    case "class":
      if(!isDefined(level.var_2326[param_01])) {
        level.var_2326[param_01] = spawnStruct();
      }

      level.var_2326[param_01].var_A281 = param_03;
      level.var_2326[param_01].var_5C0D = param_03;
      level.var_2326[param_01].var_3515 = param_02;
      break;

    case "weapon":
      if(!isDefined(level.var_A9F3[param_01])) {
        level.var_A9F3[param_01] = spawnStruct();
      }

      level.var_A9F3[param_01].var_A281 = param_03;
      level.var_A9F3[param_01].var_5C0D = param_03;
      level.var_A9F3[param_01].var_3515 = param_02;
      break;

    case "hardpoint":
      if(!isDefined(level.var_4B1E[param_01])) {
        level.var_4B1E[param_01] = spawnStruct();
      }

      level.var_4B1E[param_01].var_A281 = param_03;
      level.var_4B1E[param_01].var_5C0D = param_03;
      level.var_4B1E[param_01].var_3515 = param_02;
      break;

    case "hud":
      if(!isDefined(level.var_4F7C[param_01])) {
        level.var_4F7C[param_01] = spawnStruct();
      }

      level.var_4F7C[param_01].var_A281 = param_03;
      level.var_4F7C[param_01].var_5C0D = param_03;
      level.var_4F7C[param_01].var_3515 = param_02;
      break;
  }
}

func_00D5() {
  level.var_241B = [];
  level.var_9FC5 = 1;
  level.var_7F46 = [];
  level.var_3FDB = [];
  level.var_986C = [];
  level.var_747C = [];
  level.var_2326 = [];
  level.var_A9F3 = [];
  level.var_4B1E = [];
  level.var_4F7C = [];
  if(level.var_258F) {
    func_7BFD("game", "graceperiod", "scr_game_graceperiod", 20);
    func_7BFD("game", "graceperiod_ds", "scr_game_graceperiod_ds", 25);
    func_7BFD("game", "graceperiod_raid_ds", "scr_game_graceperiod_raid_ds", 40);
    func_7BFD("game", "graceperiod_ranked_ds", "scr_game_graceperiod_ranked_ds", 40);
  } else {
    func_7BFD("game", "playerwaittime", "scr_game_playerwaittime", 20);
    func_7BFD("game", "playerwaittime_ds", "scr_game_playerwaittime_ds", 25);
    func_7BFD("game", "playerwaittime_raid_ds", "scr_game_playerwaittime_raid_ds", 40);
    func_7BFD("game", "playerwaittime_ranked_ds", "scr_game_graceperiod_ranked_ds", 40);
  }

  func_7BFD("game", "matchstarttime", "scr_game_matchstarttime", 15);
  func_7BFD("game", "roundstarttime", "scr_game_roundstarttime", 5);
  func_7BFD("game", "onlyheadshots", "scr_game_onlyheadshots", 0);
  func_7BFD("game", "allowkillcam", "scr_game_allowkillcam", 1);
  func_7BFD("game", "spectatetype", "scr_game_spectatetype", 1);
  func_7BFD("game", "lockspectatepov", "scr_game_lockspectatorpov", 1);
  func_7BFD("game", "minimapHiddenWhileADS", "scr_game_minimapHiddenWhileADS", 0);
  func_7BFD("game", "deathpointloss", "scr_game_deathpointloss", 0);
  func_7BFD("game", "suicidepointloss", "scr_game_suicidepointloss", 0);
  func_7BFD("game", "suicidespawndelay", "scr_game_suicidespawndelay", 0, 1);
  func_7BFD("team", "teamkillpointloss", "scr_team_teamkillpointloss", 0);
  func_7BFD("team", "fftype", "scr_team_fftype", 0);
  func_7BFD("team", "teamkillspawndelay", "scr_team_teamkillspawndelay", 20);
  func_7BFD("team", "teamkillkicklimit", "scr_team_teamkillkicklimit", 0);
  func_7BFD("player", "maxhealth", "scr_player_maxhealth", 100);
  func_7BFD("player", "healthregentime", "scr_player_healthregentime", 4);
  func_7BFD("player", "forcerespawn", "scr_player_forcerespawn", 1);
  func_7BFD("weapon", "allowfrag", "scr_weapon_allowfrags", 1);
  func_7BFD("weapon", "allowsmoke", "scr_weapon_allowsmoke", 1);
  func_7BFD("weapon", "allowflash", "scr_weapon_allowflash", 1);
  func_7BFD("weapon", "allowc4", "scr_weapon_allowc4", 1);
  func_7BFD("weapon", "allowclaymores", "scr_weapon_allowclaymores", 1);
  func_7BFD("weapon", "allowrpgs", "scr_weapon_allowrpgs", 1);
  func_7BFD("weapon", "allowmines", "scr_weapon_allowmines", 1);
  func_7BFD("hardpoint", "allowartillery", "scr_hardpoint_allowartillery", 1);
  func_7BFD("hardpoint", "allowuav", "scr_hardpoint_allowuav", 1);
  func_7BFD("hardpoint", "allowsupply", "scr_hardpoint_allowsupply", 1);
  func_7BFD("hardpoint", "allowhelicopter", "scr_hardpoint_allowhelicopter", 1);
}