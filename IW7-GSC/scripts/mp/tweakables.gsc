/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\tweakables.gsc
*********************************************/

gettweakabledvarvalue(var_0, var_1) {
  switch (var_0) {
    case "rule":
      var_2 = level.rules[var_1].dvar;
      break;

    case "game":
      var_2 = level.gametweaks[var_2].dvar;
      break;

    case "team":
      var_2 = level.teamtweaks[var_2].dvar;
      break;

    case "player":
      var_2 = level.playertweaks[var_2].dvar;
      break;

    case "class":
      var_2 = level.classtweaks[var_2].dvar;
      break;

    case "weapon":
      var_2 = level.weapontweaks[var_2].dvar;
      break;

    case "hardpoint":
      var_2 = level.hardpointtweaks[var_2].dvar;
      break;

    case "hud":
      var_2 = level.hudtweaks[var_2].dvar;
      break;

    default:
      var_2 = undefined;
      break;
  }

  var_3 = getdvarint(var_2);
  return var_3;
}

func_81E4(var_0, var_1) {
  switch (var_0) {
    case "rule":
      var_2 = level.rules[var_1].dvar;
      break;

    case "game":
      var_2 = level.gametweaks[var_2].dvar;
      break;

    case "team":
      var_2 = level.teamtweaks[var_2].dvar;
      break;

    case "player":
      var_2 = level.playertweaks[var_2].dvar;
      break;

    case "class":
      var_2 = level.classtweaks[var_2].dvar;
      break;

    case "weapon":
      var_2 = level.weapontweaks[var_2].dvar;
      break;

    case "hardpoint":
      var_2 = level.hardpointtweaks[var_2].dvar;
      break;

    case "hud":
      var_2 = level.hudtweaks[var_2].dvar;
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
      var_2 = level.gametweaks[var_2].value;
      break;

    case "team":
      var_2 = level.teamtweaks[var_2].value;
      break;

    case "player":
      var_2 = level.playertweaks[var_2].value;
      break;

    case "class":
      var_2 = level.classtweaks[var_2].value;
      break;

    case "weapon":
      var_2 = level.weapontweaks[var_2].value;
      break;

    case "hardpoint":
      var_2 = level.hardpointtweaks[var_2].value;
      break;

    case "hud":
      var_2 = level.hudtweaks[var_2].value;
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
      var_2 = level.rules[var_1].var_AA40;
      break;

    case "game":
      var_2 = level.gametweaks[var_2].var_AA40;
      break;

    case "team":
      var_2 = level.teamtweaks[var_2].var_AA40;
      break;

    case "player":
      var_2 = level.playertweaks[var_2].var_AA40;
      break;

    case "class":
      var_2 = level.classtweaks[var_2].var_AA40;
      break;

    case "weapon":
      var_2 = level.weapontweaks[var_2].var_AA40;
      break;

    case "hardpoint":
      var_2 = level.hardpointtweaks[var_2].var_AA40;
      break;

    case "hud":
      var_2 = level.hudtweaks[var_2].var_AA40;
      break;

    default:
      var_2 = undefined;
      break;
  }

  return var_2;
}

settweakabledvar(var_0, var_1, var_2) {
  switch (var_0) {
    case "rule":
      var_3 = level.rules[var_1].dvar;
      break;

    case "game":
      var_3 = level.gametweaks[var_2].dvar;
      break;

    case "team":
      var_3 = level.teamtweaks[var_2].dvar;
      break;

    case "player":
      var_3 = level.playertweaks[var_2].dvar;
      break;

    case "class":
      var_3 = level.classtweaks[var_2].dvar;
      break;

    case "weapon":
      var_3 = level.weapontweaks[var_2].dvar;
      break;

    case "hardpoint":
      var_3 = level.hardpointtweaks[var_2].dvar;
      break;

    case "hud":
      var_3 = level.hudtweaks[var_2].dvar;
      break;

    default:
      var_3 = undefined;
      break;
  }

  setdvar(var_3, var_2);
}

settweakablevalue(var_0, var_1, var_2) {
  switch (var_0) {
    case "rule":
      level.rules[var_1].var_AA40 = var_2;
      break;

    case "game":
      level.gametweaks[var_1].var_AA40 = var_2;
      break;

    case "team":
      level.teamtweaks[var_1].var_AA40 = var_2;
      break;

    case "player":
      level.playertweaks[var_1].var_AA40 = var_2;
      break;

    case "class":
      level.classtweaks[var_1].var_AA40 = var_2;
      break;

    case "weapon":
      level.weapontweaks[var_1].var_AA40 = var_2;
      break;

    case "hardpoint":
      level.hardpointtweaks[var_1].var_AA40 = var_2;
      break;

    case "hud":
      level.hudtweaks[var_1].var_AA40 = var_2;
      break;

    default:
      break;
  }
}

registertweakable(var_0, var_1, var_2, var_3) {
  if(isstring(var_3)) {
    var_3 = getdvar(var_2, var_3);
  } else {
    var_3 = getdvarint(var_2, var_3);
  }

  switch (var_0) {
    case "rule":
      if(!isDefined(level.rules[var_1])) {
        level.rules[var_1] = spawnStruct();
      }

      level.rules[var_1].value = var_3;
      level.rules[var_1].var_AA40 = var_3;
      level.rules[var_1].dvar = var_2;
      break;

    case "game":
      if(!isDefined(level.gametweaks[var_1])) {
        level.gametweaks[var_1] = spawnStruct();
      }

      level.gametweaks[var_1].value = var_3;
      level.gametweaks[var_1].var_AA40 = var_3;
      level.gametweaks[var_1].dvar = var_2;
      break;

    case "team":
      if(!isDefined(level.teamtweaks[var_1])) {
        level.teamtweaks[var_1] = spawnStruct();
      }

      level.teamtweaks[var_1].value = var_3;
      level.teamtweaks[var_1].var_AA40 = var_3;
      level.teamtweaks[var_1].dvar = var_2;
      break;

    case "player":
      if(!isDefined(level.playertweaks[var_1])) {
        level.playertweaks[var_1] = spawnStruct();
      }

      level.playertweaks[var_1].value = var_3;
      level.playertweaks[var_1].var_AA40 = var_3;
      level.playertweaks[var_1].dvar = var_2;
      break;

    case "class":
      if(!isDefined(level.classtweaks[var_1])) {
        level.classtweaks[var_1] = spawnStruct();
      }

      level.classtweaks[var_1].value = var_3;
      level.classtweaks[var_1].var_AA40 = var_3;
      level.classtweaks[var_1].dvar = var_2;
      break;

    case "weapon":
      if(!isDefined(level.weapontweaks[var_1])) {
        level.weapontweaks[var_1] = spawnStruct();
      }

      level.weapontweaks[var_1].value = var_3;
      level.weapontweaks[var_1].var_AA40 = var_3;
      level.weapontweaks[var_1].dvar = var_2;
      break;

    case "hardpoint":
      if(!isDefined(level.hardpointtweaks[var_1])) {
        level.hardpointtweaks[var_1] = spawnStruct();
      }

      level.hardpointtweaks[var_1].value = var_3;
      level.hardpointtweaks[var_1].var_AA40 = var_3;
      level.hardpointtweaks[var_1].dvar = var_2;
      break;

    case "hud":
      if(!isDefined(level.hudtweaks[var_1])) {
        level.hudtweaks[var_1] = spawnStruct();
      }

      level.hudtweaks[var_1].value = var_3;
      level.hudtweaks[var_1].var_AA40 = var_3;
      level.hudtweaks[var_1].dvar = var_2;
      break;
  }
}

init() {
  level.var_41F9 = [];
  level.var_12AC9 = 1;
  level.rules = [];
  level.gametweaks = [];
  level.teamtweaks = [];
  level.playertweaks = [];
  level.classtweaks = [];
  level.weapontweaks = [];
  level.hardpointtweaks = [];
  level.hudtweaks = [];
  if(level.console) {
    if(level.var_13E0E || level.var_DADC) {
      registertweakable("game", "graceperiod", "scr_game_graceperiod", 20);
    } else {
      registertweakable("game", "graceperiod", "scr_game_graceperiod", 15);
    }

    registertweakable("game", "graceperiod_comp", "scr_game_graceperiod_comp", 30);
  } else {
    registertweakable("game", "playerwaittime", "scr_game_playerwaittime", 15);
    registertweakable("game", "playerwaittime_comp", "scr_game_playerwaittime_comp", 30);
  }

  registertweakable("game", "matchstarttime", "scr_game_matchstarttime", 15);
  registertweakable("game", "onlyheadshots", "scr_game_onlyheadshots", 0);
  registertweakable("game", "allowkillcam", "scr_game_allowkillcam", 1);
  registertweakable("game", "spectatetype", "scr_game_spectatetype", 2);
  registertweakable("game", "allow3rdspectate", "scr_game_allow3rdspectate", 1);
  registertweakable("game", "deathpointloss", "scr_game_deathpointloss", 0);
  registertweakable("game", "suicidepointloss", "scr_game_suicidepointloss", 0);
  registertweakable("team", "teamkillpointloss", "scr_team_teamkillpointloss", 0);
  registertweakable("team", "fftype", "scr_team_fftype", 0);
  registertweakable("team", "teamkillspawndelay", "scr_team_teamkillspawndelay", 0);
  registertweakable("player", "maxhealth", "scr_player_maxhealth", 100);
  registertweakable("player", "healthregentime", "scr_player_healthregentime", 2);
  registertweakable("player", "forcerespawn", "scr_player_forcerespawn", 1);
  registertweakable("player", "streamingwaittime", "scr_player_streamingwaittime", 5);
  registertweakable("weapon", "allowfrag", "scr_weapon_allowfrags", 1);
  registertweakable("weapon", "allowsmoke", "scr_weapon_allowsmoke", 1);
  registertweakable("weapon", "allowflash", "scr_weapon_allowflash", 1);
  registertweakable("weapon", "allowc4", "scr_weapon_allowc4", 1);
  registertweakable("weapon", "allowclaymores", "scr_weapon_allowclaymores", 1);
  registertweakable("weapon", "allowrpgs", "scr_weapon_allowrpgs", 1);
  registertweakable("weapon", "allowmines", "scr_weapon_allowmines", 1);
  registertweakable("hardpoint", "allowartillery", "scr_hardpoint_allowartillery", 1);
  registertweakable("hardpoint", "allowuav", "scr_hardpoint_allowuav", 1);
  registertweakable("hardpoint", "allowsupply", "scr_hardpoint_allowsupply", 1);
  registertweakable("hardpoint", "allowhelicopter", "scr_hardpoint_allowhelicopter", 1);
  registertweakable("hud", "showobjicons", "ui_hud_showobjicons", 1);
  setdvar("ui_hud_showobjicons", 1);
}