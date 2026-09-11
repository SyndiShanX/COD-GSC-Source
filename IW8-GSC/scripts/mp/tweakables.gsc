/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\tweakables.gsc
***********************************************/

function gettweakabledvarvalue(var0, var1) {
  switch (var0) {
    case "rule":
      var2 = level.rules[var1].dvar;
      break;
    case "game":
      var2 = level.gametweaks[var2].dvar;
      break;
    case "team":
      var2 = level.teamtweaks[var2].dvar;
      break;
    case "player":
      var2 = level.playertweaks[var2].dvar;
      break;
    case "class":
      var2 = level.classtweaks[var2].dvar;
      break;
    case "weapon":
      var2 = level.weapontweaks[var2].dvar;
      break;
    case "hardpoint":
      var2 = level.hardpointtweaks[var2].dvar;
      break;
    case "hud":
      var2 = level.hudtweaks[var2].dvar;
      break;
    default:
      var2 = undefined;
      break;
  }

  var3 = getdvarint(var2);
  return var3;
}

function gettweakabledvar(var0, var1) {
  switch (var0) {
    case "rule":
      var2 = level.rules[var1].dvar;
      break;
    case "game":
      var2 = level.gametweaks[var2].dvar;
      break;
    case "team":
      var2 = level.teamtweaks[var2].dvar;
      break;
    case "player":
      var2 = level.playertweaks[var2].dvar;
      break;
    case "class":
      var2 = level.classtweaks[var2].dvar;
      break;
    case "weapon":
      var2 = level.weapontweaks[var2].dvar;
      break;
    case "hardpoint":
      var2 = level.hardpointtweaks[var2].dvar;
      break;
    case "hud":
      var2 = level.hudtweaks[var2].dvar;
      break;
    default:
      var2 = undefined;
      break;
  }

  return var2;
}

function gettweakablevalue(var0, var1) {
  switch (var0) {
    case "rule":
      var2 = level.rules[var1].value;
      break;
    case "game":
      var2 = level.gametweaks[var2].value;
      break;
    case "team":
      var2 = level.teamtweaks[var2].value;
      break;
    case "player":
      var2 = level.playertweaks[var2].value;
      break;
    case "class":
      var2 = level.classtweaks[var2].value;
      break;
    case "weapon":
      var2 = level.weapontweaks[var2].value;
      break;
    case "hardpoint":
      var2 = level.hardpointtweaks[var2].value;
      break;
    case "hud":
      var2 = level.hudtweaks[var2].value;
      break;
    default:
      var2 = undefined;
      break;
  }

  return var2;
}

function gettweakablelastvalue(var0, var1) {
  switch (var0) {
    case "rule":
      var2 = level.rules[var1].lastvalue;
      break;
    case "game":
      var2 = level.gametweaks[var2].lastvalue;
      break;
    case "team":
      var2 = level.teamtweaks[var2].lastvalue;
      break;
    case "player":
      var2 = level.playertweaks[var2].lastvalue;
      break;
    case "class":
      var2 = level.classtweaks[var2].lastvalue;
      break;
    case "weapon":
      var2 = level.weapontweaks[var2].lastvalue;
      break;
    case "hardpoint":
      var2 = level.hardpointtweaks[var2].lastvalue;
      break;
    case "hud":
      var2 = level.hudtweaks[var2].lastvalue;
      break;
    default:
      var2 = undefined;
      break;
  }

  return var2;
}

function settweakabledvar(var0, var1, var2) {
  switch (var0) {
    case "rule":
      var3 = level.rules[var1].dvar;
      break;
    case "game":
      var3 = level.gametweaks[var2].dvar;
      break;
    case "team":
      var3 = level.teamtweaks[var3].dvar;
      break;
    case "player":
      var3 = level.playertweaks[var3].dvar;
      break;
    case "class":
      var3 = level.classtweaks[var3].dvar;
      break;
    case "weapon":
      var3 = level.weapontweaks[var3].dvar;
      break;
    case "hardpoint":
      var3 = level.hardpointtweaks[var3].dvar;
      break;
    case "hud":
      var3 = level.hudtweaks[var3].dvar;
      break;
    default:
      var3 = undefined;
      break;
  }

  setDvar(var3, var3);
}

function settweakablevalue(var0, var1, var2) {
  switch (var0) {
    case "rule":
      level.rules[var1].value = var2;
      break;
    case "game":
      level.gametweaks[var1].value = var2;
      break;
    case "team":
      level.teamtweaks[var1].value = var2;
      break;
    case "player":
      level.playertweaks[var1].value = var2;
      break;
    case "class":
      level.classtweaks[var1].value = var2;
      break;
    case "weapon":
      level.weapontweaks[var1].value = var2;
      break;
    case "hardpoint":
      level.hardpointtweaks[var1].value = var2;
      break;
    case "hud":
      level.hudtweaks[var1].v = var2;
      break;
    default:
      break;
  }
}

function settweakablelastvalue(var0, var1, var2) {
  switch (var0) {
    case "rule":
      level.rules[var1].lastvalue = var2;
      break;
    case "game":
      level.gametweaks[var1].lastvalue = var2;
      break;
    case "team":
      level.teamtweaks[var1].lastvalue = var2;
      break;
    case "player":
      level.playertweaks[var1].lastvalue = var2;
      break;
    case "class":
      level.classtweaks[var1].lastvalue = var2;
      break;
    case "weapon":
      level.weapontweaks[var1].lastvalue = var2;
      break;
    case "hardpoint":
      level.hardpointtweaks[var1].lastvalue = var2;
      break;
    case "hud":
      level.hudtweaks[var1].lastvalue = var2;
      break;
    default:
      break;
  }
}

function registertweakable(var0, var1, var2, var3) {
  if(isstring(var3)) {
    var3 = getDvar(var2, var3);
  } else {
    var3 = getdvarint(var2, var3);
  }

  switch (var0) {
    case "rule":
      if(!isDefined(level.rules[var1])) {
        level.rules[var1] = spawnStruct();
      }

      level.rules[var1].value = var3;
      level.rules[var1].lastvalue = var3;
      level.rules[var1].dvar = var2;
      break;
    case "game":
      if(!isDefined(level.gametweaks[var1])) {
        level.gametweaks[var1] = spawnStruct();
      }

      level.gametweaks[var1].value = var3;
      level.gametweaks[var1].lastvalue = var3;
      level.gametweaks[var1].dvar = var2;
      break;
    case "team":
      if(!isDefined(level.teamtweaks[var1])) {
        level.teamtweaks[var1] = spawnStruct();
      }

      level.teamtweaks[var1].value = var3;
      level.teamtweaks[var1].lastvalue = var3;
      level.teamtweaks[var1].dvar = var2;
      break;
    case "player":
      if(!isDefined(level.playertweaks[var1])) {
        level.playertweaks[var1] = spawnStruct();
      }

      level.playertweaks[var1].value = var3;
      level.playertweaks[var1].lastvalue = var3;
      level.playertweaks[var1].dvar = var2;
      break;
    case "class":
      if(!isDefined(level.classtweaks[var1])) {
        level.classtweaks[var1] = spawnStruct();
      }

      level.classtweaks[var1].value = var3;
      level.classtweaks[var1].lastvalue = var3;
      level.classtweaks[var1].dvar = var2;
      break;
    case "weapon":
      if(!isDefined(level.weapontweaks[var1])) {
        level.weapontweaks[var1] = spawnStruct();
      }

      level.weapontweaks[var1].value = var3;
      level.weapontweaks[var1].lastvalue = var3;
      level.weapontweaks[var1].dvar = var2;
      break;
    case "hardpoint":
      if(!isDefined(level.hardpointtweaks[var1])) {
        level.hardpointtweaks[var1] = spawnStruct();
      }

      level.hardpointtweaks[var1].value = var3;
      level.hardpointtweaks[var1].lastvalue = var3;
      level.hardpointtweaks[var1].dvar = var2;
      break;
    case "hud":
      if(!isDefined(level.hudtweaks[var1])) {
        level.hudtweaks[var1] = spawnStruct();
      }

      level.hudtweaks[var1].value = var3;
      level.hudtweaks[var1].lastvalue = var3;
      level.hudtweaks[var1].dvar = var2;
      break;
  }
}

function init() {
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
  registertweakable("game", "graceperiod", "scr_game_graceperiod", 20);
  registertweakable("game", "graceperiod_comp", "scr_game_graceperiod_comp", 30);
  registertweakable("game", "onlyheadshots", "scr_game_onlyheadshots", 0);
  registertweakable("game", "allowkillcam", "scr_game_allowkillcam", 1);
  registertweakable("game", "spectatetype", "scr_game_spectatetype", 1);
  registertweakable("game", "allow3rdspectate", "scr_game_allow3rdspectate", 0);
  registertweakable("game", "deathpointloss", "scr_game_deathpointloss", 0);
  registertweakable("game", "suicidepointloss", "scr_game_suicidepointloss", 0);
  registertweakable("team", "teamkillpointloss", "scr_team_teamkillpointloss", 0);
  registertweakable("team", "fftype", "scr_team_fftype", 0);
  registertweakable("team", "teamkillspawndelay", "scr_team_teamkillspawndelay", 0);
  registertweakable("player", "maxhealth", "scr_player_maxhealth", 100);
  registertweakable("player", "laststand", "scr_player_lastStand", 0);
  registertweakable("player", "postgameexfilweapon", "scr_player_postgameexfilweapon", "none");
  registertweakable("player", "healthregentime", "scr_player_healthregentime", 6);
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
  setDvar("ui_hud_showobjicons", 1);
}