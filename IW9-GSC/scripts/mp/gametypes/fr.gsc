/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\fr.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 75);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onplayerkilled = ::onplayerkilled;
  game["dialog"]["gametype"] = "gametype_tdm";
  game["dialog"]["boost"] = "boost_tdm";
  game["dialog"]["offense_obj"] = "boost_tdm";
  game["dialog"]["defense_obj"] = "boost_tdm";

  if(scripts\mp\utility\game::matchmakinggame())
    level.shouldgamelobbyremainintact = ::shouldgamelobbyremainintact;

  _id_392E29D6A9A83091::_id_B2AB8303E71FFCF4();
  _id_60B33963BE93AE9D::_id_6154A7FA500FFDC6();
  _id_D6A9E7094F78672E();
  _id_6617E2F2BB62B52B::_id_70B0F5C75F974EFF();

  if(getdvarint("dvar_3A0783F0E1830D67", 0)) {
    _id_18C2FB8B3F85C7CD::_id_6F8C89F8F7DD3CC1();
    _id_60B33963BE93AE9D::_id_6A2FD0869DA15E06("test_0");
  }
}

_id_D6A9E7094F78672E() {
  _id_41387EECC35B88BF::_id_89929DF8C53338F7();
  _id_41387EECC35B88BF::_id_8E0A16F0CA8E45E9("MG_HALO_DROP", _id_4DD6F6922D39D18B::_id_1CD4D60BE487039F, undefined, undefined);
  _id_41387EECC35B88BF::_id_8E0A16F0CA8E45E9("MG_FISH", _id_70964912D5FF0187::_id_4E027FF231BE8B77, undefined, undefined);
  _id_41387EECC35B88BF::_id_8E0A16F0CA8E45E9("MG_RADIOACTIVE", _id_20B10468A7CC2D44::_id_5C90BC15A1D74A38, undefined, undefined);
  _id_41387EECC35B88BF::_id_8E0A16F0CA8E45E9("REV_HOSTAGE", _id_45FFE5649EDE77C2::_id_D4CB9A04A954FBA0, undefined, undefined);
  _id_41387EECC35B88BF::_id_8E0A16F0CA8E45E9("REV_ARMORED_CONVOY", undefined, undefined, _id_524B4C9FC437C147::_id_4ECB1B2838C104EF);
  _id_41387EECC35B88BF::_id_8E0A16F0CA8E45E9("STR_HEIST", _id_6B7185811FC757E6::_id_69D3956A1823A672, undefined, undefined);
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_war_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  setdynamicdvar("scr_war_promode", 0);
}

onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    _id_2B21F2FBE8DD5C6E = game["attackers"];
    _id_8D904E28CF14C8AE = game["defenders"];
    game["attackers"] = _id_8D904E28CF14C8AE;
    game["defenders"] = _id_2B21F2FBE8DD5C6E;
  }

  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/WAR");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/WAR");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/WAR_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/WAR_HINT");
  }

  if(isDefined(level.initspawnsoverridefunc))
    [[level.initspawnsoverridefunc]]();
  else
    initspawns();

  _id_641E4E9B12A99632::inittankspawns();

  if(getdvarint("dvar_3A0783F0E1830D67", 0))
    _id_60B33963BE93AE9D::_id_D1A0788290216F08("test_0");
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()))
    scripts\mp\spawnlogic::setactivespawnlogic("BigTDM", "Crit_Frontline");
  else
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");

  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_tdm_spawn_axis_start");
  attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", _id_2FD93EA689E77097);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  _id_3A5288F40C8BE099 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", _id_29D9D2428185616D);
  scripts\mp\spawnlogic::registerspawnset("fallback", _id_3A5288F40C8BE099);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  spawnteam = self.pers["team"];
  spawnpoint = undefined;

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(spawnteam == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
    }
  } else {
    scripts\mp\spawnlogic::activatespawnset("normal", 1);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "fallback");
  }

  return spawnpoint;
}

onspawnplayer(_id_9156B53BCF7CE573) {
  if(istrue(level._id_3CD921E8F55A730B))
    _id_392E29D6A9A83091::_id_CC6A3B6B4C6E5ED8();

  _id_41387EECC35B88BF::_id_EDF73B691C19DFB3();
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);

  if(isPlayer(self))
    _id_41387EECC35B88BF::_id_DDCB9338C5CD1D29(self);
}

ontimelimit() {
  winner = scripts\mp\gamescore::gethighestscoringteam();

  if(game["status"] == "overtime")
    winner = "forfeit";
  else if("tie")
    winner = "overtime";

  thread scripts\mp\gamelogic::endgame(winner, game["end_reason"]["time_limit_reached"]);
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  if(isPlayer(self))
    _id_41387EECC35B88BF::_id_DDCB9338C5CD1D29(self);
}

shouldgamelobbyremainintact() {
  _id_18A3FAB290E780C2 = int(game["teamScores"]["axis"]);
  _id_43A41488C3C487DF = int(game["teamScores"]["allies"]);
  _id_F9C7AAE8C6ACD600 = _id_18A3FAB290E780C2 - _id_43A41488C3C487DF;
  return _id_F9C7AAE8C6ACD600 < 10;
}