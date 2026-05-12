/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\dm.gsc
*********************************************/

func_00F9() {
  maps\mp\gametypes\_globallogic::func_00D5();
  lib_01DD::func_8A0C();
  maps\mp\gametypes\_globallogic::func_8A0C();
  if(isusingmatchrulesdata()) {
    level.var_5300 = ::func_5300;
    [[level.var_5300]]();
    level thread maps\mp\_utility::func_7C13();
  } else {
    maps\mp\_utility::func_7BFA(level.var_3FDC, 10);
    maps\mp\_utility::func_7BF9(level.var_3FDC, 30);
    maps\mp\_utility::func_7C04(level.var_3FDC, 1);
    maps\mp\_utility::func_7BF7(level.var_3FDC, 1);
    maps\mp\_utility::func_7BF1(level.var_3FDC, 0);
    maps\mp\_utility::func_7BE5(level.var_3FDC, 0);
    maps\mp\_utility::func_7BF9(level.var_3FDC, 30);
    level.var_6031 = 0;
    level.var_6035 = 0;
  }

  level.var_6BAF = ::func_6BAF;
  level.var_6B5C = ::func_6B5C;
  level.var_6B7F = ::func_6B7F;
  if(level.var_6031 || level.var_6035) {
    level.var_62AD = ::maps\mp\gametypes\_damage::func_3FC8;
  }

  setteammode("ffa");
  maps\mp\_utility::func_873B(0);
  game["dialog"]["gametype"] = "ffa_intro";
  game["dialog"]["defense_obj"] = "gbl_start";
  game["dialog"]["offense_obj"] = "gbl_start";
  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }
}

func_5300() {
  maps\mp\_utility::func_8653(1);
  setdynamicdvar("scr_dm_winlimit", 1);
  maps\mp\_utility::func_7C04("dm", 1);
  setdynamicdvar("scr_dm_roundlimit", 1);
  maps\mp\_utility::func_7BF7("dm", 1);
  setdynamicdvar("scr_dm_halftime", 0);
  maps\mp\_utility::func_7BE5("dm", 0);
}

func_6BAF() {
  setclientnamemode("auto_change");
  maps\mp\_utility::func_86DC("allies", &"OBJECTIVES_DM");
  maps\mp\_utility::func_86DC("axis", &"OBJECTIVES_DM");
  if(level.var_910F) {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_DM");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_DM");
  } else {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_DM_SCORE");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_DM_SCORE");
  }

  maps\mp\_utility::func_86D8("allies", &"OBJECTIVES_DM_HINT");
  maps\mp\_utility::func_86D8("axis", &"OBJECTIVES_DM_HINT");
  lib_050D::func_10E4();
  level.var_A239 = 1;
  var_00[0] = "dm";
  var_00[1] = "blocker_dm";
  maps\mp\gametypes\_gameobjects::func_00F9(var_00);
  level.var_7895 = 1;
}

func_6B5C(param_00, param_01, param_02) {
  var_03 = 0;
  foreach(var_05 in level.var_744A) {
    if(isDefined(var_05.var_015C) && var_05.var_015C > var_03) {
      var_03 = var_05.var_015C;
    }
  }

  if(game["state"] == "postgame" && param_01.var_015C >= var_03) {
    param_01.var_3B4B = 1;
  }
}

func_6B7F(param_00, param_01, param_02, param_03, param_04) {
  var_05 = maps\mp\gametypes\_rank::func_4671(param_00);
  param_01 maps\mp\_utility::func_867B(param_01.var_008F + var_05);
  param_01 maps\mp\gametypes\_gamescore::func_A161(param_01, var_05);
  if(func_57BF(param_00)) {
    return 1;
  } else if(func_57BD(param_00)) {
    return 0;
  }

  return 0;
}

func_57BF(param_00) {
  switch (param_00) {
    case "attack_dogs_kill":
    case "division_commando_kill":
    case "division_grenadier_kill":
    case "kill":
    case "mg_nest_kill":
    case "v2_rocket_kill":
    case "airdrop_kill":
    case "tac_insert_kill":
    case "division_artillery_kill":
    case "division_scout_kill":
    case "division_resistance_kill":
    case "divisions_cavalry_kill":
    case "divisions_mountain_kill":
    case "divisions_armored_kill":
    case "divisions_airborne_kill":
    case "divisions_infantry_kill":
    case "paratroopers_kill":
    case "missile_strike_kill":
    case "mortar_strike_kill":
    case "flamethrower_kill":
    case "molotovs_kill":
    case "plane_gunner_kill":
    case "airstrike_kill":
    case "firebomb_kill":
    case "fritzx_kill":
    case "fighter_strike_kill":
      return 1;
  }

  return 0;
}

func_57BD(param_00) {
  switch (param_00) {
    case "crossfire_steal":
    case "crossfire_high":
    case "crossfire_mid":
    case "crossfire_tactical":
    case "crossfire_painted":
    case "crossfire_painted_expeditionary":
    case "crossfire_low":
      return 1;
  }

  return 0;
}