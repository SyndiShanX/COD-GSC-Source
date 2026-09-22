/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\dm.gsc
********************************************/

main() {
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();

  if(_isusingmatchrulesdata()) {
    level._id_5300 = ::_id_5300;
    [[level._id_5300]]();
    level thread maps\mp\_utility::_id_7C13();
  } else {
    maps\mp\_utility::registertimelimitdvar(level.gametype, 10);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 30);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 30);
    level._id_6031 = 0;
    level._id_6035 = 0;
  }

  level._id_6BAF = ::_id_6BAF;
  level._id_6B5C = ::_id_6B5C;
  level._id_6B7F = ::_id_6B7F;

  if(level._id_6031 || level._id_6035) {
    level._id_62AD = maps\mp\gametypes\_damage::_id_3FC8;
  }

  _setteammode("ffa");
  maps\mp\_utility::_id_873B(0);
  game["dialog"]["gametype"] = "ffa_intro";
  game["dialog"]["defense_obj"] = "gbl_start";
  game["dialog"]["offense_obj"] = "gbl_start";

  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }
}

_id_5300() {
  maps\mp\_utility::_id_8653(1);
  _setdynamicdvar("scr_dm_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("dm", 1);
  _setdynamicdvar("scr_dm_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("dm", 1);
  _setdynamicdvar("scr_dm_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("dm", 0);
}

_id_6BAF() {
  _setclientnamemode("auto_change");
  maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_DM");
  maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_DM");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_DM");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_DM");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_DM_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_DM_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_DM_HINT");
  maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_DM_HINT");
  _id_050D::_id_10E4();
  level._id_A239 = 1;
  var_0[0] = "dm";
  var_0[1] = "blocker_dm";
  _id_04D1::main(var_0);
  level._id_7895 = 1;
}

_id_6B5C(var_0, var_1, var_2) {
  var_3 = 0;

  foreach(var_5 in level.players) {
    if(isDefined(var_5.score) && var_5.score > var_3) {
      var_3 = var_5.score;
    }
  }

  if(game["state"] == "postgame" && var_1.score >= var_3) {
    var_1._id_3B4B = 1;
  }
}

_id_6B7F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = maps\mp\gametypes\_rank::getscoreinfovalue(var_0);
  var_1 maps\mp\_utility::_id_867B(var_1._id_008F + var_5);
  var_1 _id_04D2::_id_A161(var_1, var_5);

  if(_id_57BF(var_0)) {
    return 1;
  } else if(_id_57BD(var_0)) {
    return 0;
  }

  return 0;
}

_id_57BF(var_0) {
  switch (var_0) {
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

_id_57BD(var_0) {
  switch (var_0) {
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