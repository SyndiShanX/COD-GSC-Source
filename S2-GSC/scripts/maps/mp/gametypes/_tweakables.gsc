/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_tweakables.gsc
*****************************************************/

_id_46F5(var_0, var_1) {
  switch (var_0) {
    case "rule":
      var_2 = level._id_7F46[var_1]._id_3515;
      break;
    case "game":
      var_2 = level._id_3FDB[var_1]._id_3515;
      break;
    case "team":
      var_2 = level._id_986C[var_1]._id_3515;
      break;
    case "player":
      var_2 = level._id_747C[var_1]._id_3515;
      break;
    case "class":
      var_2 = level._id_2326[var_1]._id_3515;
      break;
    case "weapon":
      var_2 = level._id_A9F3[var_1]._id_3515;
      break;
    case "hardpoint":
      var_2 = level._id_4B1E[var_1]._id_3515;
      break;
    case "hud":
      var_2 = level._id_4F7C[var_1]._id_3515;
      break;
    default:
      var_2 = undefined;
      break;
  }

  var_3 = getdvarint(var_2);
  return var_3;
}

_id_46F4(var_0, var_1) {
  switch (var_0) {
    case "rule":
      var_2 = level._id_7F46[var_1]._id_3515;
      break;
    case "game":
      var_2 = level._id_3FDB[var_1]._id_3515;
      break;
    case "team":
      var_2 = level._id_986C[var_1]._id_3515;
      break;
    case "player":
      var_2 = level._id_747C[var_1]._id_3515;
      break;
    case "class":
      var_2 = level._id_2326[var_1]._id_3515;
      break;
    case "weapon":
      var_2 = level._id_A9F3[var_1]._id_3515;
      break;
    case "hardpoint":
      var_2 = level._id_4B1E[var_1]._id_3515;
      break;
    case "hud":
      var_2 = level._id_4F7C[var_1]._id_3515;
      break;
    default:
      var_2 = undefined;
      break;
  }

  return var_2;
}

_id_46F7(var_0, var_1, var_2) {
  switch (var_0) {
    case "rule":
      var_3 = level._id_7F46[var_1].value;
      break;
    case "game":
      var_3 = level._id_3FDB[var_1].value;
      break;
    case "team":
      var_3 = level._id_986C[var_1].value;
      break;
    case "player":
      var_3 = level._id_747C[var_1].value;
      break;
    case "class":
      var_3 = level._id_2326[var_1].value;
      break;
    case "weapon":
      var_3 = level._id_A9F3[var_1].value;
      break;
    case "hardpoint":
      var_3 = level._id_4B1E[var_1].value;
      break;
    case "hud":
      var_3 = level._id_4F7C[var_1].value;
      break;
    default:
      var_3 = undefined;
      break;
  }

  return var_3;
}

_id_46F6(var_0, var_1) {
  switch (var_0) {
    case "rule":
      var_2 = level._id_7F46[var_1]._id_5C0D;
      break;
    case "game":
      var_2 = level._id_3FDB[var_1]._id_5C0D;
      break;
    case "team":
      var_2 = level._id_986C[var_1]._id_5C0D;
      break;
    case "player":
      var_2 = level._id_747C[var_1]._id_5C0D;
      break;
    case "class":
      var_2 = level._id_2326[var_1]._id_5C0D;
      break;
    case "weapon":
      var_2 = level._id_A9F3[var_1]._id_5C0D;
      break;
    case "hardpoint":
      var_2 = level._id_4B1E[var_1]._id_5C0D;
      break;
    case "hud":
      var_2 = level._id_4F7C[var_1]._id_5C0D;
      break;
    default:
      var_2 = undefined;
      break;
  }

  return var_2;
}

_id_8751(var_0, var_1, var_2) {
  switch (var_0) {
    case "rule":
      var_3 = level._id_7F46[var_1]._id_3515;
      break;
    case "game":
      var_3 = level._id_3FDB[var_1]._id_3515;
      break;
    case "team":
      var_3 = level._id_986C[var_1]._id_3515;
      break;
    case "player":
      var_3 = level._id_747C[var_1]._id_3515;
      break;
    case "class":
      var_3 = level._id_2326[var_1]._id_3515;
      break;
    case "weapon":
      var_3 = level._id_A9F3[var_1]._id_3515;
      break;
    case "hardpoint":
      var_3 = level._id_4B1E[var_1]._id_3515;
      break;
    case "hud":
      var_3 = level._id_4F7C[var_1]._id_3515;
      break;
    default:
      var_3 = undefined;
      break;
  }

  setDvar(var_3, var_2);
}

_id_8750(var_0, var_1, var_2) {
  switch (var_0) {
    case "rule":
      level._id_7F46[var_1]._id_5C0D = var_2;
      break;
    case "game":
      level._id_3FDB[var_1]._id_5C0D = var_2;
      break;
    case "team":
      level._id_986C[var_1]._id_5C0D = var_2;
      break;
    case "player":
      level._id_747C[var_1]._id_5C0D = var_2;
      break;
    case "class":
      level._id_2326[var_1]._id_5C0D = var_2;
      break;
    case "weapon":
      level._id_A9F3[var_1]._id_5C0D = var_2;
      break;
    case "hardpoint":
      level._id_4B1E[var_1]._id_5C0D = var_2;
      break;
    case "hud":
      level._id_4F7C[var_1]._id_5C0D = var_2;
      break;
    default:
      break;
  }
}

_id_7BFD(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4) && var_4)
    var_3 = getdvarfloat(var_2, var_3);
  else if(_func_031(var_3))
    var_3 = getDvar(var_2, var_3);
  else
    var_3 = getdvarint(var_2, var_3);

  switch (var_0) {
    case "rule":
      if(!isDefined(level._id_7F46[var_1]))
        level._id_7F46[var_1] = spawnStruct();

      level._id_7F46[var_1].value = var_3;
      level._id_7F46[var_1]._id_5C0D = var_3;
      level._id_7F46[var_1]._id_3515 = var_2;
      break;
    case "game":
      if(!isDefined(level._id_3FDB[var_1]))
        level._id_3FDB[var_1] = spawnStruct();

      level._id_3FDB[var_1].value = var_3;
      level._id_3FDB[var_1]._id_5C0D = var_3;
      level._id_3FDB[var_1]._id_3515 = var_2;
      break;
    case "team":
      if(!isDefined(level._id_986C[var_1]))
        level._id_986C[var_1] = spawnStruct();

      level._id_986C[var_1].value = var_3;
      level._id_986C[var_1]._id_5C0D = var_3;
      level._id_986C[var_1]._id_3515 = var_2;
      break;
    case "player":
      if(!isDefined(level._id_747C[var_1]))
        level._id_747C[var_1] = spawnStruct();

      level._id_747C[var_1].value = var_3;
      level._id_747C[var_1]._id_5C0D = var_3;
      level._id_747C[var_1]._id_3515 = var_2;
      break;
    case "class":
      if(!isDefined(level._id_2326[var_1]))
        level._id_2326[var_1] = spawnStruct();

      level._id_2326[var_1].value = var_3;
      level._id_2326[var_1]._id_5C0D = var_3;
      level._id_2326[var_1]._id_3515 = var_2;
      break;
    case "weapon":
      if(!isDefined(level._id_A9F3[var_1]))
        level._id_A9F3[var_1] = spawnStruct();

      level._id_A9F3[var_1].value = var_3;
      level._id_A9F3[var_1]._id_5C0D = var_3;
      level._id_A9F3[var_1]._id_3515 = var_2;
      break;
    case "hardpoint":
      if(!isDefined(level._id_4B1E[var_1]))
        level._id_4B1E[var_1] = spawnStruct();

      level._id_4B1E[var_1].value = var_3;
      level._id_4B1E[var_1]._id_5C0D = var_3;
      level._id_4B1E[var_1]._id_3515 = var_2;
      break;
    case "hud":
      if(!isDefined(level._id_4F7C[var_1]))
        level._id_4F7C[var_1] = spawnStruct();

      level._id_4F7C[var_1].value = var_3;
      level._id_4F7C[var_1]._id_5C0D = var_3;
      level._id_4F7C[var_1]._id_3515 = var_2;
      break;
  }
}

init() {
  level._id_241B = [];
  level._id_9FC5 = 1;
  level._id_7F46 = [];
  level._id_3FDB = [];
  level._id_986C = [];
  level._id_747C = [];
  level._id_2326 = [];
  level._id_A9F3 = [];
  level._id_4B1E = [];
  level._id_4F7C = [];

  if(level._id_258F) {
    _id_7BFD("game", "graceperiod", "scr_game_graceperiod", 20);
    _id_7BFD("game", "graceperiod_ds", "scr_game_graceperiod_ds", 25);
    _id_7BFD("game", "graceperiod_raid_ds", "scr_game_graceperiod_raid_ds", 40);
    _id_7BFD("game", "graceperiod_ranked_ds", "scr_game_graceperiod_ranked_ds", 40);
  } else {
    _id_7BFD("game", "playerwaittime", "scr_game_playerwaittime", 20);
    _id_7BFD("game", "playerwaittime_ds", "scr_game_playerwaittime_ds", 25);
    _id_7BFD("game", "playerwaittime_raid_ds", "scr_game_playerwaittime_raid_ds", 40);
    _id_7BFD("game", "playerwaittime_ranked_ds", "scr_game_graceperiod_ranked_ds", 40);
  }

  _id_7BFD("game", "matchstarttime", "scr_game_matchstarttime", 15);
  _id_7BFD("game", "roundstarttime", "scr_game_roundstarttime", 5);
  _id_7BFD("game", "onlyheadshots", "scr_game_onlyheadshots", 0);
  _id_7BFD("game", "allowkillcam", "scr_game_allowkillcam", 1);
  _id_7BFD("game", "spectatetype", "scr_game_spectatetype", 1);
  _id_7BFD("game", "lockspectatepov", "scr_game_lockspectatorpov", 1);
  _id_7BFD("game", "minimapHiddenWhileADS", "scr_game_minimapHiddenWhileADS", 0);
  _id_7BFD("game", "deathpointloss", "scr_game_deathpointloss", 0);
  _id_7BFD("game", "suicidepointloss", "scr_game_suicidepointloss", 0);
  _id_7BFD("game", "suicidespawndelay", "scr_game_suicidespawndelay", 0, 1);
  _id_7BFD("team", "teamkillpointloss", "scr_team_teamkillpointloss", 0);
  _id_7BFD("team", "fftype", "scr_team_fftype", 0);
  _id_7BFD("team", "teamkillspawndelay", "scr_team_teamkillspawndelay", 20);
  _id_7BFD("team", "teamkillkicklimit", "scr_team_teamkillkicklimit", 0);
  _id_7BFD("player", "maxhealth", "scr_player_maxhealth", 100);
  _id_7BFD("player", "healthregentime", "scr_player_healthregentime", 4);
  _id_7BFD("player", "forcerespawn", "scr_player_forcerespawn", 1);
  _id_7BFD("weapon", "allowfrag", "scr_weapon_allowfrags", 1);
  _id_7BFD("weapon", "allowsmoke", "scr_weapon_allowsmoke", 1);
  _id_7BFD("weapon", "allowflash", "scr_weapon_allowflash", 1);
  _id_7BFD("weapon", "allowc4", "scr_weapon_allowc4", 1);
  _id_7BFD("weapon", "allowclaymores", "scr_weapon_allowclaymores", 1);
  _id_7BFD("weapon", "allowrpgs", "scr_weapon_allowrpgs", 1);
  _id_7BFD("weapon", "allowmines", "scr_weapon_allowmines", 1);
  _id_7BFD("hardpoint", "allowartillery", "scr_hardpoint_allowartillery", 1);
  _id_7BFD("hardpoint", "allowuav", "scr_hardpoint_allowuav", 1);
  _id_7BFD("hardpoint", "allowsupply", "scr_hardpoint_allowsupply", 1);
  _id_7BFD("hardpoint", "allowhelicopter", "scr_hardpoint_allowhelicopter", 1);
}