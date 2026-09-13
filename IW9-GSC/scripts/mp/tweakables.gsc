/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\tweakables.gsc
***********************************************/

gettweakabledvarvalue(category, name) {
  switch (category) {
    case "rule":
      dvar = level.rules[name].dvar;
      break;
    case "game":
      dvar = level.gametweaks[name].dvar;
      break;
    case "team":
      dvar = level.teamtweaks[name].dvar;
      break;
    case "player":
      dvar = level.playertweaks[name].dvar;
      break;
    case "class":
      dvar = level.classtweaks[name].dvar;
      break;
    case "weapon":
      dvar = level.weapontweaks[name].dvar;
      break;
    case "hardpoint":
      dvar = level.hardpointtweaks[name].dvar;
      break;
    case "hud":
      dvar = level.hudtweaks[name].dvar;
      break;
    default:
      dvar = undefined;
      break;
  }

  value = getdvarint(dvar);
  return value;
}

gettweakabledvar(category, name) {
  switch (category) {
    case "rule":
      value = level.rules[name].dvar;
      break;
    case "game":
      value = level.gametweaks[name].dvar;
      break;
    case "team":
      value = level.teamtweaks[name].dvar;
      break;
    case "player":
      value = level.playertweaks[name].dvar;
      break;
    case "class":
      value = level.classtweaks[name].dvar;
      break;
    case "weapon":
      value = level.weapontweaks[name].dvar;
      break;
    case "hardpoint":
      value = level.hardpointtweaks[name].dvar;
      break;
    case "hud":
      value = level.hudtweaks[name].dvar;
      break;
    default:
      value = undefined;
      break;
  }

  return value;
}

gettweakablevalue(category, name) {
  switch (category) {
    case "rule":
      value = level.rules[name].value;
      break;
    case "game":
      value = level.gametweaks[name].value;
      break;
    case "team":
      value = level.teamtweaks[name].value;
      break;
    case "player":
      value = level.playertweaks[name].value;
      break;
    case "class":
      value = level.classtweaks[name].value;
      break;
    case "weapon":
      value = level.weapontweaks[name].value;
      break;
    case "hardpoint":
      value = level.hardpointtweaks[name].value;
      break;
    case "hud":
      value = level.hudtweaks[name].value;
      break;
    default:
      value = undefined;
      break;
  }

  return value;
}

gettweakablelastvalue(category, name) {
  switch (category) {
    case "rule":
      value = level.rules[name].lastvalue;
      break;
    case "game":
      value = level.gametweaks[name].lastvalue;
      break;
    case "team":
      value = level.teamtweaks[name].lastvalue;
      break;
    case "player":
      value = level.playertweaks[name].lastvalue;
      break;
    case "class":
      value = level.classtweaks[name].lastvalue;
      break;
    case "weapon":
      value = level.weapontweaks[name].lastvalue;
      break;
    case "hardpoint":
      value = level.hardpointtweaks[name].lastvalue;
      break;
    case "hud":
      value = level.hudtweaks[name].lastvalue;
      break;
    default:
      value = undefined;
      break;
  }

  return value;
}

settweakabledvar(category, name, value) {
  switch (category) {
    case "rule":
      dvar = level.rules[name].dvar;
      break;
    case "game":
      dvar = level.gametweaks[name].dvar;
      break;
    case "team":
      dvar = level.teamtweaks[name].dvar;
      break;
    case "player":
      dvar = level.playertweaks[name].dvar;
      break;
    case "class":
      dvar = level.classtweaks[name].dvar;
      break;
    case "weapon":
      dvar = level.weapontweaks[name].dvar;
      break;
    case "hardpoint":
      dvar = level.hardpointtweaks[name].dvar;
      break;
    case "hud":
      dvar = level.hudtweaks[name].dvar;
      break;
    default:
      dvar = undefined;
      break;
  }

  setDvar(dvar, value);
}

settweakablevalue(category, name, value) {
  switch (category) {
    case "rule":
      level.rules[name].value = value;
      break;
    case "game":
      level.gametweaks[name].value = value;
      break;
    case "team":
      level.teamtweaks[name].value = value;
      break;
    case "player":
      level.playertweaks[name].value = value;
      break;
    case "class":
      level.classtweaks[name].value = value;
      break;
    case "weapon":
      level.weapontweaks[name].value = value;
      break;
    case "hardpoint":
      level.hardpointtweaks[name].value = value;
      break;
    case "hud":
      level.hudtweaks[name].v = value;
      break;
    default:
      break;
  }
}

settweakablelastvalue(category, name, value) {
  switch (category) {
    case "rule":
      level.rules[name].lastvalue = value;
      break;
    case "game":
      level.gametweaks[name].lastvalue = value;
      break;
    case "team":
      level.teamtweaks[name].lastvalue = value;
      break;
    case "player":
      level.playertweaks[name].lastvalue = value;
      break;
    case "class":
      level.classtweaks[name].lastvalue = value;
      break;
    case "weapon":
      level.weapontweaks[name].lastvalue = value;
      break;
    case "hardpoint":
      level.hardpointtweaks[name].lastvalue = value;
      break;
    case "hud":
      level.hudtweaks[name].lastvalue = value;
      break;
    default:
      break;
  }
}

registertweakable(category, name, dvar, value) {
  if(isstring(value))
    value = getDvar(dvar, value);
  else
    value = getdvarint(dvar, value);

  switch (category) {
    case "rule":
      if(!isDefined(level.rules[name]))
        level.rules[name] = spawnStruct();

      level.rules[name].value = value;
      level.rules[name].lastvalue = value;
      level.rules[name].dvar = dvar;
      break;
    case "game":
      if(!isDefined(level.gametweaks[name]))
        level.gametweaks[name] = spawnStruct();

      level.gametweaks[name].value = value;
      level.gametweaks[name].lastvalue = value;
      level.gametweaks[name].dvar = dvar;
      break;
    case "team":
      if(!isDefined(level.teamtweaks[name]))
        level.teamtweaks[name] = spawnStruct();

      level.teamtweaks[name].value = value;
      level.teamtweaks[name].lastvalue = value;
      level.teamtweaks[name].dvar = dvar;
      break;
    case "player":
      if(!isDefined(level.playertweaks[name]))
        level.playertweaks[name] = spawnStruct();

      level.playertweaks[name].value = value;
      level.playertweaks[name].lastvalue = value;
      level.playertweaks[name].dvar = dvar;
      break;
    case "class":
      if(!isDefined(level.classtweaks[name]))
        level.classtweaks[name] = spawnStruct();

      level.classtweaks[name].value = value;
      level.classtweaks[name].lastvalue = value;
      level.classtweaks[name].dvar = dvar;
      break;
    case "weapon":
      if(!isDefined(level.weapontweaks[name]))
        level.weapontweaks[name] = spawnStruct();

      level.weapontweaks[name].value = value;
      level.weapontweaks[name].lastvalue = value;
      level.weapontweaks[name].dvar = dvar;
      break;
    case "hardpoint":
      if(!isDefined(level.hardpointtweaks[name]))
        level.hardpointtweaks[name] = spawnStruct();

      level.hardpointtweaks[name].value = value;
      level.hardpointtweaks[name].lastvalue = value;
      level.hardpointtweaks[name].dvar = dvar;
      break;
    case "hud":
      if(!isDefined(level.hudtweaks[name]))
        level.hudtweaks[name] = spawnStruct();

      level.hudtweaks[name].value = value;
      level.hudtweaks[name].lastvalue = value;
      level.hudtweaks[name].dvar = dvar;
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
  registertweakable("game", "graceperiod", "scr_game_graceperiod", 20);
  registertweakable("game", "graceperiod_comp", "scr_game_graceperiod_comp", 30);
  registertweakable("game", "onlyheadshots", "scr_game_onlyheadshots", 0);
  registertweakable("game", "allowkillcam", "scr_game_allowkillcam", 1);
  registertweakable("game", "spectatetype", "scr_game_spectatetype", 1);
  registertweakable("game", "allow3rdspectate", "scr_game_allow3rdspectate", 0);
  registertweakable("game", "deathpointloss", "scr_game_deathpointloss", 0);
  registertweakable("game", "suicidepointloss", "scr_game_suicidepointloss", 0);
  registertweakable("team", "teamkillpointloss", "scr_team_teamkillpointloss", 0);
  registertweakable("game", "thirdperson", "camera_thirdPerson", 0);
  registertweakable("game", "lowgravity", "dvar_12CA000DD2976EBC", 0);
  registertweakable("game", "lowgravitystrength", "dvar_02F4CF62DF1AF9A6", 125);
  registertweakable("game", "minfalldamageheight", "bg_fallDamageMinHeight", 225);
  registertweakable("game", "herodrop", "dvar_F1B2BD0A1FA58A73", 0);
  registertweakable("game", "perkpackage", "dvar_B01050DA9B96D273", 1);
  registertweakable("game", "showperksonspawn", "scr_showperksonspawn", 1);
  registertweakable("game", "loadoutperksoff", "dvar_8463BC866E14F4C7", 0);
  registertweakable("game", "one_tap_headshot", "dvar_C0F3F80EC94308D1", 0);
  registertweakable("team", "fftype", "scr_team_fftype", 0);
  registertweakable("team", "teamkillspawndelay", "scr_team_teamkillspawndelay", 0);
  registertweakable("player", "maxhealth", "scr_player_maxhealth", 100);
  registertweakable("player", "laststand", "scr_player_lastStand", 0);
  registertweakable("player", "healthregentime", "scr_player_healthregentime", 6);
  registertweakable("player", "forcerespawn", "scr_player_forcerespawn", 1);
  registertweakable("player", "streamingwaittime", "scr_player_streamingwaittime", 5);
  registertweakable("weapon", "allowfrag", "scr_weapon_allowfrags", 1);
  registertweakable("weapon", "allowsmoke", "scr_weapon_allowsmoke", 1);
  registertweakable("weapon", "allowflash", "scr_weapon_allowflash", 1);
  registertweakable("weapon", "allowc4", "scr_weapon_allowc4", 1);
  registertweakable("weapon", "allowclaymores", "dvar_0FB822E5B2C3150E", 1);
  registertweakable("weapon", "allowrpgs", "scr_weapon_allowrpgs", 1);
  registertweakable("weapon", "allowmines", "scr_weapon_allowmines", 1);
  registertweakable("hardpoint", "allowartillery", "scr_hardpoint_allowartillery", 1);
  registertweakable("hardpoint", "allowuav", "scr_hardpoint_allowuav", 1);
  registertweakable("hardpoint", "allowsupply", "scr_hardpoint_allowsupply", 1);
  registertweakable("hardpoint", "allowhelicopter", "scr_hardpoint_allowhelicopter", 1);
  registertweakable("hud", "showobjicons", "ui_hud_showobjicons", 1);
  setDvar("ui_hud_showobjicons", 1);
}