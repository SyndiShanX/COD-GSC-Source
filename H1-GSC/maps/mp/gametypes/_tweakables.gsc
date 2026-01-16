/*********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_tweakables.gsc
*********************************************/

gettweakabledvarvalue(var_0, var_1) {
  switch (var_0) {
    case "rule":
      var_2 = level.rules[var_1].dvar;
      break;
    case "game":
      var_2 = level.gametweaks[var_1].dvar;
      break;
    case "team":
      var_2 = level.teamtweaks[var_1].dvar;
      break;
    case "player":
      var_2 = level.playertweaks[var_1].dvar;
      break;
    case "class":
      var_2 = level.classtweaks[var_1].dvar;
      break;
    case "weapon":
      var_2 = level.weapontweaks[var_1].dvar;
      break;
    case "hardpoint":
      var_2 = level.hardpointtweaks[var_1].dvar;
      break;
    case "hud":
      var_2 = level.hudtweaks[var_1].dvar;
      break;
    default:
      var_2 = undefined;
      break;
  }

  var_3 = getdvarint(var_2);
  return var_3;
}

gettweakabledvar(var_0, var_1) {
  switch (var_0) {
    case "rule":
      var_2 = level.rules[var_1].dvar;
      break;
    case "game":
      var_2 = level.gametweaks[var_1].dvar;
      break;
    case "team":
      var_2 = level.teamtweaks[var_1].dvar;
      break;
    case "player":
      var_2 = level.playertweaks[var_1].dvar;
      break;
    case "class":
      var_2 = level.classtweaks[var_1].dvar;
      break;
    case "weapon":
      var_2 = level.weapontweaks[var_1].dvar;
      break;
    case "hardpoint":
      var_2 = level.hardpointtweaks[var_1].dvar;
      break;
    case "hud":
      var_2 = level.hudtweaks[var_1].dvar;
      break;
    default:
      var_2 = undefined;
      break;
  }

  return var_2;
}

gettweakablevalue(var_0, var_1) {
  switch (var_0) {
    case "rule":
      var_2 = level.rules[var_1].value;
      break;
    case "game":
      var_2 = level.gametweaks[var_1].value;
      break;
    case "team":
      var_2 = level.teamtweaks[var_1].value;
      break;
    case "player":
      var_2 = level.playertweaks[var_1].value;
      break;
    case "class":
      var_2 = level.classtweaks[var_1].value;
      break;
    case "weapon":
      var_2 = level.weapontweaks[var_1].value;
      break;
    case "hardpoint":
      var_2 = level.hardpointtweaks[var_1].value;
      break;
    case "hud":
      var_2 = level.hudtweaks[var_1].value;
      break;
    default:
      var_2 = undefined;
      break;
  }

  return var_2;
}

gettweakablelastvalue(var_0, var_1) {
  switch (var_0) {
    case "rule":
      var_2 = level.rules[var_1].lastvalue;
      break;
    case "game":
      var_2 = level.gametweaks[var_1].lastvalue;
      break;
    case "team":
      var_2 = level.teamtweaks[var_1].lastvalue;
      break;
    case "player":
      var_2 = level.playertweaks[var_1].lastvalue;
      break;
    case "class":
      var_2 = level.classtweaks[var_1].lastvalue;
      break;
    case "weapon":
      var_2 = level.weapontweaks[var_1].lastvalue;
      break;
    case "hardpoint":
      var_2 = level.hardpointtweaks[var_1].lastvalue;
      break;
    case "hud":
      var_2 = level.hudtweaks[var_1].lastvalue;
      break;
    default:
      var_2 = undefined;
      break;
  }

  return var_2;
}

settweakablevalue(var_0, var_1, var_2) {
  switch (var_0) {
    case "rule":
      var_3 = level.rules[var_1].dvar;
      break;
    case "game":
      var_3 = level.gametweaks[var_1].dvar;
      break;
    case "team":
      var_3 = level.teamtweaks[var_1].dvar;
      break;
    case "player":
      var_3 = level.playertweaks[var_1].dvar;
      break;
    case "class":
      var_3 = level.classtweaks[var_1].dvar;
      break;
    case "weapon":
      var_3 = level.weapontweaks[var_1].dvar;
      break;
    case "hardpoint":
      var_3 = level.hardpointtweaks[var_1].dvar;
      break;
    case "hud":
      var_3 = level.hudtweaks[var_1].dvar;
      break;
    default:
      var_3 = undefined;
      break;
  }

  setdvar(var_3, var_2);
}

settweakablelastvalue(var_0, var_1, var_2) {
  switch (var_0) {
    case "rule":
      level.rules[var_1].lastvalue = var_2;
      break;
    case "game":
      level.gametweaks[var_1].lastvalue = var_2;
      break;
    case "team":
      level.teamtweaks[var_1].lastvalue = var_2;
      break;
    case "player":
      level.playertweaks[var_1].lastvalue = var_2;
      break;
    case "class":
      level.classtweaks[var_1].lastvalue = var_2;
      break;
    case "weapon":
      level.weapontweaks[var_1].lastvalue = var_2;
      break;
    case "hardpoint":
      level.hardpointtweaks[var_1].lastvalue = var_2;
      break;
    case "hud":
      level.hudtweaks[var_1].lastvalue = var_2;
      break;
    default:
      break;
  }
}

registertweakable(var_0, var_1, var_2, var_3) {
  if(isstring(var_3))
    var_3 = getdvar(var_2, var_3);
  else
    var_3 = getdvarint(var_2, var_3);

  switch (var_0) {
    case "rule":
      if(!isdefined(level.rules[var_1]))
        level.rules[var_1] = spawnstruct();

      level.rules[var_1].value = var_3;
      level.rules[var_1].lastvalue = var_3;
      level.rules[var_1].dvar = var_2;
      break;
    case "game":
      if(!isdefined(level.gametweaks[var_1]))
        level.gametweaks[var_1] = spawnstruct();

      level.gametweaks[var_1].value = var_3;
      level.gametweaks[var_1].lastvalue = var_3;
      level.gametweaks[var_1].dvar = var_2;
      break;
    case "team":
      if(!isdefined(level.teamtweaks[var_1]))
        level.teamtweaks[var_1] = spawnstruct();

      level.teamtweaks[var_1].value = var_3;
      level.teamtweaks[var_1].lastvalue = var_3;
      level.teamtweaks[var_1].dvar = var_2;
      break;
    case "player":
      if(!isdefined(level.playertweaks[var_1]))
        level.playertweaks[var_1] = spawnstruct();

      level.playertweaks[var_1].value = var_3;
      level.playertweaks[var_1].lastvalue = var_3;
      level.playertweaks[var_1].dvar = var_2;
      break;
    case "class":
      if(!isdefined(level.classtweaks[var_1]))
        level.classtweaks[var_1] = spawnstruct();

      level.classtweaks[var_1].value = var_3;
      level.classtweaks[var_1].lastvalue = var_3;
      level.classtweaks[var_1].dvar = var_2;
      break;
    case "weapon":
      if(!isdefined(level.weapontweaks[var_1]))
        level.weapontweaks[var_1] = spawnstruct();

      level.weapontweaks[var_1].value = var_3;
      level.weapontweaks[var_1].lastvalue = var_3;
      level.weapontweaks[var_1].dvar = var_2;
      break;
    case "hardpoint":
      if(!isdefined(level.hardpointtweaks[var_1]))
        level.hardpointtweaks[var_1] = spawnstruct();

      level.hardpointtweaks[var_1].value = var_3;
      level.hardpointtweaks[var_1].lastvalue = var_3;
      level.hardpointtweaks[var_1].dvar = var_2;
      break;
    case "hud":
      if(!isdefined(level.hudtweaks[var_1]))
        level.hudtweaks[var_1] = spawnstruct();

      level.hudtweaks[var_1].value = var_3;
      level.hudtweaks[var_1].lastvalue = var_3;
      level.hudtweaks[var_1].dvar = var_2;
      break;
  }
}

init() {
  level.clienttweakables = [];
  level.tweakablesinitialized = 1;
  level.rules = [];
  level.gametweaks = [];
  level.teamtweaks = [];
  level.playertweaks = [];
  level.classtweaks = [];
  level.weapontweaks = [];
  level.hardpointtweaks = [];
  level.hudtweaks = [];

  if(level.console) {
    registertweakable("game", "graceperiod", "scr_game_graceperiod", 15);
    registertweakable("game", "graceperiod_ds", "scr_game_graceperiod_ds", 20);
  } else {
    registertweakable("game", "playerwaittime", "scr_game_playerwaittime", 15);
    registertweakable("game", "playerwaittime_ds", "scr_game_playerwaittime_ds", 20);
  }

  registertweakable("game", "matchstarttime", "scr_game_matchstarttime", 15);
  registertweakable("game", "roundstarttime", "scr_game_roundstarttime", 5);
  registertweakable("game", "onlyheadshots", "scr_game_onlyheadshots", 0);
  registertweakable("game", "allowkillcam", "scr_game_allowkillcam", 1);
  registertweakable("game", "spectatetype", "scr_game_spectatetype", 2);
  registertweakable("game", "lockspectatepov", "scr_game_lockspectatorpov", 0);
  registertweakable("game", "deathpointloss", "scr_game_deathpointloss", 0);
  registertweakable("game", "suicidepointloss", "scr_game_suicidepointloss", 0);
  registertweakable("game", "suicidespawndelay", "scr_game_suicidespawndelay", 0);
  registertweakable("team", "teamkillpointloss", "scr_team_teamkillpointloss", 0);
  registertweakable("team", "fftype", "scr_team_fftype", 0);
  registertweakable("team", "teamkillspawndelay", "scr_team_teamkillspawndelay", 20);
  registertweakable("team", "teamkillkicklimit", "scr_team_teamkillkicklimit", 0);
  registertweakable("player", "maxhealth", "scr_player_maxhealth", 100);
  registertweakable("player", "healthregentime", "scr_player_healthregentime", 5);
  registertweakable("player", "forcerespawn", "scr_player_forcerespawn", 1);
  registertweakable("weapon", "allowfrag", "scr_weapon_allowfrags", 1);
  registertweakable("weapon", "allowsmoke", "scr_weapon_allowsmoke", 1);
  registertweakable("weapon", "allowflash", "scr_weapon_allowflash", 1);
  registertweakable("weapon", "allowc4", "scr_weapon_allowc4", 1);
  registertweakable("weapon", "allowclaymores", "scr_weapon_allowclaymores", 1);
  registertweakable("weapon", "allowrpgs", "scr_weapon_allowrpgs", 1);
  registertweakable("weapon", "allowmines", "scr_weapon_allowmines", 1);
}