/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\war.gsc
*********************************************/

main() {
  if(getDvar("1673") == "mp_background") {
    return;
  }
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();

  if(_isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread maps\mp\_utility::reinitializematchrulesonmigration();
  } else {
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 10);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 75);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  maps\mp\_utility::_id_873B(1);
  level.onstartgametype = ::onstartgametype;
  level.onnormaldeath = ::onnormaldeath;

  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["gametype"] = "tdm_intro";

  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["defense_obj"] = "gbl_start";
  game["dialog"]["offense_obj"] = "gbl_start";
  game["strings"]["overtime_hint"] = &"MP_FIRST_BLOOD";

  if(level.practiceround) {
    game["dialog"]["gametype"] = "ptr_welcome";
    game["dialog"]["ptr_new_best"] = "ptr_new_best";
    game["dialog"]["ptr_assist"] = "ptr_assist";
    game["dialog"]["ptr_headshot"] = "ptr_headshot";
    game["dialog"]["ptr_greatshot"] = "ptr_greatshot";
  }
}

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata();
  _setdynamicdvar("scr_war_roundswitch", 0);
  maps\mp\_utility::registerroundswitchdvar("war", 0, 0, 9);
  _setdynamicdvar("scr_war_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("war", 1);
  _setdynamicdvar("scr_war_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("war", 1);
  _setdynamicdvar("scr_war_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("war", 0);
}

onstartgametype() {
  _setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_WAR");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_WAR");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_WAR");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_WAR_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_WAR_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_WAR_HINT");
  maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_WAR_HINT");
  _id_050D::_id_10E4();
  var_2[0] = level.gametype;
  var_2[1] = "blocker_war";
  _id_04D1::main(var_2);
}

onnormaldeath(var_0, var_1, var_2) {
  level _id_04D2::giveteamscoreforobjective(var_1.pers["team"], 1, 1);

  if(game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level.otherteam[var_1.team]]) {
    var_1.finalkill = 1;
  }
}

ontimelimit() {
  level.finalkillcam_winner = "none";

  if(game["status"] == "overtime") {
    var_0 = "forfeit";
  } else if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
    var_0 = "overtime";
  } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
    level.finalkillcam_winner = "axis";
    var_0 = "axis";
  } else {
    level.finalkillcam_winner = "allies";
    var_0 = "allies";
  }

  if(maps\mp\_utility::practiceroundgame()) {
    var_0 = "none";
  }

  thread maps\mp\gametypes\_gamelogic::endgame(var_0, game["end_reason"]["time_limit_reached"]);
}