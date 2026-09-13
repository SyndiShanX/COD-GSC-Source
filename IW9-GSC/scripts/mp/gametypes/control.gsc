/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\control.gsc
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
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 90);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 200);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 3);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  _id_099B6CF14579E2F2();
  level.updatealiveomnvars = ::_id_99A2435BDAA61D08;
  level.onstartgametype = ::_id_675AFF24F4E37138;
  level.onplayerconnect = ::_id_8C35121EC0B41C27;
  level.onplayerdisconnect = ::_id_51CF571AD0EB34B9;
  level.getspawnpoint = ::_id_B16BF8E8672B4CAA;
  level.onplayerkilled = ::_id_93B1902DC83D81D2;
  level.ononeleftevent = ::_id_BAEB9F54B3A7566D;
  level.modeonspawnplayer = ::_id_EEBC5ADA1461570C;
  level.disablespawningforplayerfunc = ::_id_D9C3E51EC6BC88BE;
  level.onobjectivecomplete = ::_id_6DC36E4DD3018346;
  level.ontimelimit = ::_id_FA93175C92F8F506;
  level.onmaprestart = ::_id_63A77191349871BF;
  level.gamemodegesturecalloutassign = ::_id_E5B3B788AA8A4401;
  level.gamemodegesturecalloutverify = ::_id_D234DB657E8B7DC5;
  level.playholdtwovo = 0;
  level.objectivebased = 1;
  level.teambased = 1;
  level.disablebuddyspawn = 1;
  level.lastcaptime = gettime();
  level.nosuspensemusic = 1;

  if(isDefined(level.numflagsscoreonkill) && level.numflagsscoreonkill > 0) {
    level.teamscoresonkill = [];
    level.onnormaldeath = ::onnormaldeath;
    setdynamicdvar(_func_2EF675C13CA1C4AF("dvar_845664FDA53DD4BD"), 1);
  }

  initdialog();
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("dvar_8BFD270DF707F68A", getmatchrulesdata("domData", "flagCaptureTime"));
  setdynamicdvar("dvar_450E884C20147BD2", getmatchrulesdata("domData", "flagsRequiredToScore"));
  setdynamicdvar("dvar_6F0B5C2CDFCBA4F3", getmatchrulesdata("domData", "pointsPerFlag"));
  setdynamicdvar("dvar_2D9A75F300856972", getmatchrulesdata("domData", "flagNeutralization"));
  setdynamicdvar("dvar_68DE7B78236B12A1", getmatchrulesdata("domData", "numFlagsScoreOnKill"));
  setdynamicdvar("dvar_D151B6BD28741A1E", getmatchrulesdata("domData", "objScalar"));
  setdynamicdvar("dvar_07886ED2E897CF35", getmatchrulesdata("siegeData", "preCapPoints"));
  setdynamicdvar("dvar_D6D8ED8DF8667405", getmatchrulesdata("captureData", "captureType"));
  setdynamicdvar("dvar_D86C2818B06AA425", getmatchrulesdata("captureData", "captureDecay"));
  setdynamicdvar("dvar_3A8D3C9492C066D3", getmatchrulesdata("controlData", "disableMajorityCapProgress"));
  setdynamicdvar("dvar_FB21C17984E58B2E", getmatchrulesdata("controlData", "useSegments"));
  setdynamicdvar("dvar_928A1EE5502ED81B", getmatchrulesdata("controlData", "suicideTeamKillLowersLives"));
  setdynamicdvar("dvar_38BCAAF0DD037DC8", getmatchrulesdata("controlData", "captureExtraTime"));
  setdynamicdvar("dvar_7AAFAD8C3E32B158", getmatchrulesdata("kothData", "pauseTime"));
  setdynamicdvar("dvar_6F23CBA3B7DA972D", getmatchrulesdata("controlData", "numTeamLives"));
  setdynamicdvar("dvar_28D6DE659E3698C6", getmatchrulesdata("controlData", "overtimeDefenders"));
  setdynamicdvar("dvar_5627514F089475E7", getmatchrulesdata("controlData", "segmentCaptureExtraTime"));
  setdynamicdvar("dvar_B99649BB10EE3FC1", getmatchrulesdata("controlData", "numCaptureSegments"));
  setdynamicdvar("dvar_B45B3F9CB0508339", 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
}

initdialog() {
  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    game["dialog"]["gametype"] = "iw9_ctrl_mode_uktl_cnt1";
  else
    game["dialog"]["gametype"] = "iw9_ctrl_mode_uktl_name";

  game["dialog"]["offense_obj"] = "iw9_ctrl_mode_uktl_cboa";
  game["dialog"]["defense_obj"] = "iw9_ctrl_mode_uktl_cbod";
  game["dialog"]["securing_a"] = "iw9_ctrl_mode_uktl_ctka";
  game["dialog"]["securing_b"] = "iw9_ctrl_mode_uktl_ctkb";
  game["dialog"]["securing_c"] = "iw9_ctrl_mode_uktl_ctkc";
  game["dialog"]["secured_a"] = "iw9_ctrl_mode_uktl_ctat";
  game["dialog"]["secured_b"] = "iw9_ctrl_mode_uktl_ctbt";
  game["dialog"]["secured_c"] = "iw9_ctrl_mode_uktl_ctct";
  game["dialog"]["attack_last_flag"] = "iw9_ctrl_mode_uktl_ctad";
  game["dialog"]["contest_attacker_a"] = "iw9_ctrl_mode_uktl_ctaa";
  game["dialog"]["contest_defender_a"] = "iw9_ctrl_mode_uktl_ctda";
  game["dialog"]["contest_attacker_b"] = "iw9_ctrl_mode_uktl_ctab";
  game["dialog"]["contest_defender_b"] = "iw9_ctrl_mode_uktl_ctdb";
  game["dialog"]["contest_attacker_c"] = "iw9_ctrl_mode_uktl_ctac";
  game["dialog"]["contest_defender_c"] = "iw9_ctrl_mode_uktl_ctdc";
  game["dialog"]["contest_attacker_all"] = "iw9_ctrl_mode_uktl_cfca";
  game["dialog"]["contest_defender_all"] = "iw9_ctrl_mode_uktl_ceca";
  game["dialog"]["losing_a"] = "iw9_ctrl_mode_uktl_clsa";
  game["dialog"]["losing_b"] = "iw9_ctrl_mode_uktl_clsb";
  game["dialog"]["losing_c"] = "iw9_ctrl_mode_uktl_clsc";
  game["dialog"]["lost_a"] = "iw9_ctrl_mode_uktl_ctal";
  game["dialog"]["lost_b"] = "iw9_ctrl_mode_uktl_ctbl";
  game["dialog"]["lost_c"] = "iw9_ctrl_mode_uktl_ctcl";
  game["dialog"]["defend_last_flag"] = "iw9_ctrl_mode_uktl_cead";
  game["dialog"]["team_low_lives"] = "iw9_ctrl_mode_uktl_cfll";
  game["dialog"]["enemy_low_lives"] = "iw9_ctrl_mode_uktl_cell";
  game["dialog"]["team_no_lives"] = "iw9_ctrl_mode_uktl_cfnl";
  game["dialog"]["enemy_no_lives"] = "iw9_ctrl_mode_uktl_cenl";
  game["dialog"]["gamestate_domwinning"] = "iw9_ctrl_mode_uktl_ctfd";
}

_id_69F9599FC4C0F82E() {
  level.iconneutral = "waypoint_captureneutral";
  level.iconcapture = "waypoint_capture";
  level.icondefend = "waypoint_defend";
  level.icondefending = "waypoint_defending";
  level.iconcontested = "waypoint_contested";
  level.icontaking = "waypoint_taking";
  level.iconlosing = "waypoint_losing";
}

_id_675AFF24F4E37138() {
  _id_D6FD8BE398B20F61 = game["attackers"];
  _id_8613C2B22B0116A5 = game["defenders"];
  level.teamdata[_id_D6FD8BE398B20F61]["livesCount"] = level._id_23D874371501C40D;
  level.teamdata[_id_8613C2B22B0116A5]["livesCount"] = level._id_23D874371501C40D;
  level.teamdata[_id_D6FD8BE398B20F61]["controlUILivesCount"] = level.teamdata[_id_D6FD8BE398B20F61]["livesCount"];
  level.teamdata[_id_8613C2B22B0116A5]["controlUILivesCount"] = level.teamdata[_id_8613C2B22B0116A5]["livesCount"];
  _id_69F9599FC4C0F82E();

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(isDefined(level.teamscoresonkill))
      level.teamscoresonkill[_id_F90358454413407F] = level.precappoints >= level.numflagsscoreonkill && level.precappoints >= level.flagsrequiredtoscore;

    if(_id_F90358454413407F == _id_D6FD8BE398B20F61)
      scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/CONTROL_ATTACKER");
    else
      scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/CONTROL_DEFENDER");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/CONTROL");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/CONTROL_SCORE");

    if(_id_F90358454413407F == _id_D6FD8BE398B20F61) {
      scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/CONTROL_ATTACKER_HINT");
      continue;
    }

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/CONTROL_DEFENDER_HINT");
  }

  setclientnamemode("auto_change");

  if(!isDefined(game["match_kills"])) {
    game["match_kills"][_id_8613C2B22B0116A5] = 0;
    game["match_kills"][_id_D6FD8BE398B20F61] = 0;
  }

  if(!isDefined(game["segment_captures"])) {
    game["segment_captures"][_id_8613C2B22B0116A5] = 0;
    game["segment_captures"][_id_D6FD8BE398B20F61] = 0;
    _id_548072087C9FD504::_id_0216B35CA5806EC6(0, _id_8613C2B22B0116A5);
    _id_548072087C9FD504::_id_0216B35CA5806EC6(0, _id_D6FD8BE398B20F61);
  }

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(level._id_64C1510A260A9426 != 0 && game["roundsWon"][_id_8613C2B22B0116A5] == level.winlimit - 1 && game["roundsWon"][_id_D6FD8BE398B20F61] == level.winlimit - 1) {
    [_id_3B8219D206004DFA, _id_401C3A2E68AAB0FD] = _id_287623BBB15154BE();

    if(_id_3B8219D206004DFA == game["attackers"]) {
      game["attackers"] = _id_8613C2B22B0116A5;
      game["defenders"] = _id_D6FD8BE398B20F61;
    }
  } else if(game["switchedsides"]) {
    game["attackers"] = _id_8613C2B22B0116A5;
    game["defenders"] = _id_D6FD8BE398B20F61;
  }

  level _id_B4BC8E806C1993A4();
  _id_641E4E9B12A99632::inittankspawns();
  level._id_A18FA3DE81FEFF0A = 0;
  level._id_A18FA0DE81FEF871 = 0;
  level.teamdata[_id_D6FD8BE398B20F61]["uncountedDeaths"] = 0;
  level.teamdata[_id_8613C2B22B0116A5]["uncountedDeaths"] = 0;

  if(level.scoremod["kill"] > 0) {
    game["dialog"]["offense_obj"] = "boost_groundwar";
    game["dialog"]["defense_obj"] = "boost_groundwar";
  }

  thread _id_212D9BD663252AF4();
  thread _id_24D4600219715EAC();
}

_id_212D9BD663252AF4() {
  if(!scripts\mp\flags::gameflag("prematch_done"))
    level waittill("prematch_done");

  level _id_56C428EE980A8464();
}

_id_099B6CF14579E2F2() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("flagCaptureTime", 60, 0, 120);
  level._id_5D2813FEE57C50A8 = scripts\mp\utility\dvars::dvarfloatvalue("captureExtraTime", 60, 30, 300);
  level._id_5D1135235E7DB3B3 = scripts\mp\utility\dvars::dvarintvalue("disableMajorityCapProgress", 1, 0, 1);
  level.objectivescaler = scripts\mp\utility\dvars::dvarfloatvalue("objScalar", 4, 1, 10);
  level._id_7CFD99E45A36D4FB = scripts\mp\utility\dvars::dvarintvalue("suicideTeamKillLowersLives", 0, 0, 1);
  level._id_23D874371501C40D = scripts\mp\utility\dvars::dvarintvalue("numTeamLives", 30, 0, 100);
  level._id_64C1510A260A9426 = scripts\mp\utility\dvars::dvarintvalue("overtimeDefenders", 2, 0, 2);
  level.pausetimer = scripts\mp\utility\dvars::dvarintvalue("pauseTime", 1, 0, 1);
  level._id_2DD5FDE7E4D5DE8E = scripts\mp\utility\dvars::dvarintvalue("useSegments", 1, 0, 1);
  level.flagsrequiredtoscore = scripts\mp\utility\dvars::dvarintvalue("flagsRequiredToScore", 2, 1, 3);
  level.pointsperflag = scripts\mp\utility\dvars::dvarintvalue("pointsPerFlag", 1, 1, 300);
  level.flagneutralization = scripts\mp\utility\dvars::dvarintvalue("flagNeutralization", 0, 0, 1);
  level.precappoints = scripts\mp\utility\dvars::dvarintvalue("preCapPoints", 1, 0, 1);
  level.capturedecay = scripts\mp\utility\dvars::dvarintvalue("captureDecay", 1, 0, 1);
  level.capturetype = scripts\mp\utility\dvars::dvarintvalue("captureType", 1, 0, 3);
  level.numflagsscoreonkill = scripts\mp\utility\dvars::dvarintvalue("numFlagsScoreOnKill", 2, 0, 3);
  level._id_DA41C55843E26237 = scripts\mp\utility\dvars::dvarintvalue("numCaptureSegments", 3, 0, 5);
  level._id_FB709E12ADDF5E47 = scripts\mp\utility\dvars::dvarfloatvalue("segmentCaptureExtraTime", 10, 0, 60);
  level._id_DA41C55843E26237 = 3;
}

_id_B4BC8E806C1993A4() {
  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()))
    scripts\mp\spawnlogic::setactivespawnlogic("BigTDM", "Crit_Default");
  else
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");

  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  _id_69181D544E5C1158 = scripts\mp\spawnlogic::getspawnpointarray("mp_control_spawn_attacker_start");

  if(_id_69181D544E5C1158.size > 0) {
    scripts\mp\spawnlogic::addstartspawnpoints("mp_control_spawn_attacker_start", 0, "allies");
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_control_spawn_attacker_start");
  }

  scripts\mp\spawnlogic::registerspawnset("start_attackers", _id_69181D544E5C1158);
  _id_132CC0C8C54D00A4 = scripts\mp\spawnlogic::getspawnpointarray("mp_control_spawn_defender_start");

  if(_id_132CC0C8C54D00A4.size > 0) {
    scripts\mp\spawnlogic::addstartspawnpoints("mp_control_spawn_defender_start", 0, "axis");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_control_spawn_defender_start");
  }

  scripts\mp\spawnlogic::registerspawnset("start_defenders", _id_132CC0C8C54D00A4);
  attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_control_spawn_attacker");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_control_spawn_attacker", 1);
  scripts\mp\spawnlogic::registerspawnset("normal_attackers", attackers);
  _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_control_spawn_defender");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_control_spawn_defender", 1);
  scripts\mp\spawnlogic::registerspawnset("normal_defenders", _id_2FD93EA689E77097);
  _id_7471BF3A9733361E = scripts\mp\spawnlogic::getspawnpointarray("mp_control_spawn_attacker_secondary");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_control_spawn_attacker_secondary", 1, 1);
  scripts\mp\spawnlogic::registerspawnset("secondary_attackers", _id_7471BF3A9733361E);
  _id_35DE02C8A810DE3A = scripts\mp\spawnlogic::getspawnpointarray("mp_control_spawn_defender_secondary");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_control_spawn_defender_secondary", 1, 1);
  scripts\mp\spawnlogic::registerspawnset("secondary_defenders", _id_35DE02C8A810DE3A);
  _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  scripts\mp\spawnlogic::registerspawnset("mp_tdm_spawn", _id_29D9D2428185616D);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

_id_B16BF8E8672B4CAA() {
  spawnteam = self.pers["team"];
  spawnpoint = undefined;

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(spawnteam == game["attackers"])
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, "start_attackers", "normal_attackers");
    else
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, "start_defenders", "normal_defenders");
  } else if(spawnteam == game["attackers"])
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, "normal_attackers", "secondary_attackers");
  else
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, "normal_defenders", "secondary_defenders");

  return spawnpoint;
}

_id_24D4600219715EAC() {
  _id_B38C97B95E246DEC = [];

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    _id_E4748DDC114E50B9 = getEntArray("control_zone", "targetname");

    foreach(zone in _id_E4748DDC114E50B9) {
      if(isDefined(zone.script_noteworthy) && zone.script_noteworthy == level.localeid) {
        _id_B38C97B95E246DEC[_id_B38C97B95E246DEC.size] = zone;
        continue;
      }

      if(isDefined(zone.target)) {
        _id_B38C97B95E246DEC[_id_B38C97B95E246DEC.size] = zone;
        continue;
      }

      zone delete();
    }
  } else {
    _id_E4748DDC114E50B9 = getEntArray("control_zone", "targetname");

    foreach(zone in _id_E4748DDC114E50B9)
    _id_B38C97B95E246DEC[_id_B38C97B95E246DEC.size] = zone;
  }

  if(_id_B38C97B95E246DEC.size != 2) {
    return;
  }
  setomnvar("ui_num_dom_flags", _id_B38C97B95E246DEC.size);
  triggers = [];

  for(index = 0; index < _id_B38C97B95E246DEC.size; index++)
    triggers[triggers.size] = _id_B38C97B95E246DEC[index];

  foreach(trigger in triggers) {
    _id_1E02025E7C954B6D = _id_D5DDC77707C5C50E(trigger, game["defenders"], 1, 0);
    _id_1E02025E7C954B6D _id_275F384D96766B39(trigger.target, trigger.script_label);
    level.objectives[_id_1E02025E7C954B6D.objectivekey] = _id_1E02025E7C954B6D;
  }

  spawn_attackers_start = scripts\mp\spawnlogic::getspawnpointarray("mp_control_spawn_attacker_start");
  spawn_defenders_start = scripts\mp\spawnlogic::getspawnpointarray("mp_control_spawn_defender_start");

  if(isDefined(spawn_attackers_start) && isDefined(spawn_attackers_start[0]))
    level.startpos["allies"] = spawn_attackers_start[0].origin;
  else
    level.startpos["allies"] = level.startspawnavg["allies"];

  if(isDefined(spawn_defenders_start) && isDefined(spawn_defenders_start[0]))
    level.startpos["axis"] = spawn_defenders_start[0].origin;
  else
    level.startpos["axis"] = level.startspawnavg["axis"];

  level.bestspawnflag = [];
  level.bestspawnflag["allies"] = _id_6663215F917210AE::getunownedflagneareststart("allies", undefined);
  level.bestspawnflag["axis"] = _id_6663215F917210AE::getunownedflagneareststart("axis", level.bestspawnflag["allies"]);

  if(level.codcasterenabled)
    thread updatetriggerforcodcaster();

  flagsetup();

  foreach(_id_1E02025E7C954B6D in level.objectives)
  _id_1E02025E7C954B6D _id_6663215F917210AE::setflagcaptured(game["defenders"], "neutral", undefined, 1);
}

_id_D5DDC77707C5C50E(trigger, team, _id_5DDBC1FAED2C56E6, _id_08B9949739F4E0F6, showoncompass) {
  _id_88E6E0BC0479FA98 = trigger.origin;
  _id_2EFB87A1B8512118 = 1;
  _id_C4C04A7D9915671A = getEntArray("control_flagui", "script_noteworthy");

  foreach(point in _id_C4C04A7D9915671A) {
    if(scripts\engine\utility::is_equal(point.script_linkname, trigger.script_linkname)) {
      _id_88E6E0BC0479FA98 = point.origin;
      _id_2EFB87A1B8512118 = 0;
      point delete();
    }
  }

  tracestart = _id_88E6E0BC0479FA98 + (0, 0, 64);
  _id_8B39E5984DA1FFAF = _id_88E6E0BC0479FA98 + (0, 0, -64);
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  ignoreents = [];
  trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, contentoverride);

  if(_id_2EFB87A1B8512118)
    _id_88E6E0BC0479FA98 = trace["position"] + (0, 0, 72);

  visuals = [];
  visuals[0] = spawn("script_model", _id_88E6E0BC0479FA98);
  visuals[0].angles = (0, 0, 0);

  if(!isDefined(level.flagcapturetime))
    level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("flagcapturetime", 60, 0, 60);

  if(!isDefined(level._id_E42A415AE1C75964))
    level._id_A09B8D25C0133F7E = scripts\mp\utility\dvars::dvarfloatvalue("flagCaptureTimeMin", 0, 0, 30);

  if(!isDefined(level._id_FB607D7BF823F6F9))
    level._id_FB607D7BF823F6F9 = level.flagcapturetime * 0.5;

  if(isDefined(trigger.objectivekey))
    objectivekey = trigger.objectivekey;
  else
    objectivekey = trigger.script_label;

  if(isDefined(trigger.iconname))
    iconname = trigger.iconname;
  else
    iconname = trigger.script_label;

  if(istrue(_id_5DDBC1FAED2C56E6))
    _id_3C2389BA69E5822B = _id_6663215F917210AE::getreservedobjid(objectivekey);
  else
    _id_3C2389BA69E5822B = undefined;

  if(!isDefined(team))
    team = "neutral";

  _id_1E02025E7C954B6D = scripts\mp\gameobjects::createuseobject(team, trigger, visuals, _id_88E6E0BC0479FA98 - trigger.origin, _id_3C2389BA69E5822B, _id_08B9949739F4E0F6, showoncompass);
  _id_1E02025E7C954B6D scripts\mp\gameobjects::cancontestclaim(1);
  _id_1E02025E7C954B6D scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  _id_1E02025E7C954B6D scripts\mp\gameobjects::allowuse("any");

  if(isDefined(level.capturetype))
    _id_1E02025E7C954B6D scripts\mp\gameobjects::setcapturebehavior(_id_6663215F917210AE::getcapturetype());

  _id_1E02025E7C954B6D.objectivekey = objectivekey;
  _id_1E02025E7C954B6D.iconname = iconname;
  _id_1E02025E7C954B6D._id_FB60F3AEC3A62F06 = 1;

  if(!istrue(_id_08B9949739F4E0F6)) {
    _id_1E02025E7C954B6D scripts\mp\gameobjects::setvisibleteam("any");
    _id_1E02025E7C954B6D.onuse = ::_id_2AB9F408525DEC1D;
    _id_1E02025E7C954B6D.onbeginuse = ::_id_82812A3910E3F1C6;
    _id_1E02025E7C954B6D.onuseupdate = _id_6663215F917210AE::dompoint_onuseupdate;
    _id_1E02025E7C954B6D.onenduse = ::_id_B1E882C74139F14E;
    _id_1E02025E7C954B6D.oncontested = ::_id_3558107088D8FEFF;
    _id_1E02025E7C954B6D.onuncontested = ::_id_37EB483C520715A2;
    _id_1E02025E7C954B6D.onunoccupied = ::_id_A99378EC0F83C03D;
    _id_1E02025E7C954B6D.onpinnedstate = ::_id_131F0413C52BBF59;
    _id_1E02025E7C954B6D.onunpinnedstate = ::_id_D0DC8FA9D7252F74;
    _id_1E02025E7C954B6D.stompprogressreward = _id_6663215F917210AE::dompoint_stompprogressreward;
    _id_1E02025E7C954B6D._id_916E4C007C6B8BA1 = ::_id_90EE8E359D6D3323;
    objective_setminimapiconsize(_id_1E02025E7C954B6D.objidnum, "icon_medium");
  }

  _id_1E02025E7C954B6D.nousebar = 1;
  _id_1E02025E7C954B6D.id = "domFlag";
  _id_1E02025E7C954B6D.claimgracetime = level.flagcapturetime * 1000;
  _id_1E02025E7C954B6D.firstcapture = 0;
  _id_1E02025E7C954B6D scripts\mp\gameobjects::pinobjiconontriggertouch();
  offset = _id_6663215F917210AE::checkmapoffsets(_id_1E02025E7C954B6D);
  _id_1E02025E7C954B6D.baseeffectpos = trace["position"] + offset;
  upangles = vectortoangles(trace["normal"]);
  _id_232BC202587CA413 = _id_6663215F917210AE::checkmapfxangles(_id_1E02025E7C954B6D, upangles);
  _id_1E02025E7C954B6D.baseeffectforward = anglesToForward(_id_232BC202587CA413);
  _id_1E02025E7C954B6D.vfxnamemod = "";
  _id_1E02025E7C954B6D.noscriptable = 1;
  _id_1E02025E7C954B6D _id_6663215F917210AE::initializematchrecording();
  return _id_1E02025E7C954B6D;
}

_id_2AB9F408525DEC1D(_id_22282E7D48CA3400, team) {
  _id_6663215F917210AE::dompoint_onuse(_id_22282E7D48CA3400, team);

  if(isDefined(level.teamscoresonkill)) {
    foreach(team in level.teamnamelist) {
      _id_FEE716687DD29378 = _id_6663215F917210AE::getteamflagcount(team);
      level.teamscoresonkill[team] = _id_FEE716687DD29378 >= level.numflagsscoreonkill && _id_FEE716687DD29378 >= level.flagsrequiredtoscore;
    }
  }
}

_id_82812A3910E3F1C6(player) {
  if(level.pausetimer && self.ownerteam != player.team && !istrue(self._id_25317B559796E5D1)) {
    self._id_25317B559796E5D1 = 1;
    scripts\mp\gamelogic::pausetimer();
  }

  _id_6663215F917210AE::dompoint_onusebegin(player);
  _id_223FB185E0AFB231();
}

_id_B1E882C74139F14E(team, player, success) {
  _id_6663215F917210AE::dompoint_onuseend(team, player, success);

  if(success)
    thread _id_0726259D42F88361("off");
  else
    _id_223FB185E0AFB231();
}

_id_3558107088D8FEFF() {
  if(level.pausetimer) {
    self._id_25317B559796E5D1 = 1;
    scripts\mp\gamelogic::pausetimer();
  }

  _id_6663215F917210AE::dompoint_oncontested();
  _id_223FB185E0AFB231();
  _id_EE2753C1176F5C7E = scripts\mp\gameobjects::getownerteam();
  attackers = scripts\mp\utility\game::getotherteam(_id_EE2753C1176F5C7E);

  if(isDefined(self.objectivekey))
    level.objectives[self.objectivekey].contested = 1;

  _id_512DCA16E9559524 = 0;

  foreach(zone in level.objectives) {
    if(istrue(zone.contested))
      _id_512DCA16E9559524++;
  }

  if(_id_512DCA16E9559524 == 0)
    return;
  else if(level.objectives.size > 1 && _id_512DCA16E9559524 == level.objectives.size) {
    scripts\mp\utility\dialog::statusdialog("contest_defender_all", _id_EE2753C1176F5C7E);

    foreach(enemyteam in attackers)
    scripts\mp\utility\dialog::statusdialog("contest_attacker_all", enemyteam);
  } else {
    scripts\mp\utility\dialog::statusdialog("contest_defender" + self.objectivekey, _id_EE2753C1176F5C7E);

    foreach(enemyteam in attackers)
    scripts\mp\utility\dialog::statusdialog("contest_attacker" + self.objectivekey, enemyteam);
  }
}

_id_37EB483C520715A2(lastclaimteam) {
  if(self.ownerteam == lastclaimteam) {
    self._id_25317B559796E5D1 = 0;

    if(!_id_0FCB83CD8B5B5098(self))
      scripts\mp\gamelogic::resumetimer();
  }

  _id_6663215F917210AE::dompoint_onuncontested(lastclaimteam);
  scripts\engine\utility::delaythread(0.05, ::_id_223FB185E0AFB231);

  if(isDefined(self.objectivekey))
    level.objectives[self.objectivekey].contested = 0;
}

_id_A99378EC0F83C03D() {
  self._id_25317B559796E5D1 = 0;

  if(!_id_0FCB83CD8B5B5098(self) && (!isDefined(level._id_D659494E95BD9496) || !level._id_D659494E95BD9496))
    scripts\mp\gamelogic::resumetimer();

  _id_6663215F917210AE::dompoint_onunoccupied();
  _id_223FB185E0AFB231();
}

_id_131F0413C52BBF59(player) {
  _id_6663215F917210AE::dompoint_onpinnedstate(player);
  _id_223FB185E0AFB231();
}

_id_D0DC8FA9D7252F74(player) {
  _id_223FB185E0AFB231();
}

_id_275F384D96766B39(target, label) {
  wait 1.0;
  _id_C236336A4B27E7DA = getentitylessscriptablearray(target, "targetname");
  _id_C236336A4B27E7DA = removechevronsfromarray(_id_C236336A4B27E7DA, label);
  _id_C236336A4B27E7DA = postshipmodifychevrons(_id_C236336A4B27E7DA, label);
  chevrons = [];

  foreach(visual in _id_C236336A4B27E7DA) {
    index = chevrons.size;
    chevrons[index] = visual;
    chevrons[index].numchevrons = 1;

    if(isDefined(visual.script_noteworthy)) {
      if(visual.script_noteworthy == "2")
        chevrons[index].numchevrons = 2;
      else if(visual.script_noteworthy == "3")
        chevrons[index].numchevrons = 3;
      else if(visual.script_noteworthy == "4")
        chevrons[index].numchevrons = 4;
    }

    if(isDefined(visual.numchevrons))
      chevrons[index].numchevrons = visual.numchevrons;
  }

  self.chevrons = chevrons;
  _id_0726259D42F88361("idle");
}

removechevronsfromarray(_id_C236336A4B27E7DA, label) {
  _id_D23F6234846F86A6 = [];

  switch (level.mapname) {
    case "mp_wartorn":
      _id_D23F6234846F86A6["_a"] = [(-8705.1, 41410.1, 262.553), (-8789.1, 41434.1, 267.825), (-8843.1, 41446.1, 266.31), (-8915.9, 41987.1, 267.008), (-8867.9, 42003.1, 266.841), (-8703.9, 41957.1, 257.841), (-8582.9, 41925.1, 257.841), (-8458.9, 41892.1, 257.841), (-8340.1, 41574.9, 257.841), (-8985.69, 41784.7, 266.233)];
      _id_D23F6234846F86A6["_b"] = [(-7198, 43939, 261), (-7440, 43669, 256), (-6924.37, 43159.2, 262.694), (-7237.4, 43784.4, 269.851), (-7209.91, 43870, 267.73), (-7188.96, 43931.1, 265.13), (-7291.54, 43763.5, 257.326), (-6795.05, 43444.3, 247.059), (-6820.03, 43382.4, 238.789), (-6845.69, 43287.7, 253.317), (-6871.27, 43206.3, 271.569)];
      break;
    case "mp_floatinghouses":
      _id_D23F6234846F86A6["_a"] = [(-13759, -9636, 51)];
      break;
    default:
      break;
  }

  if(isDefined(_id_D23F6234846F86A6[label])) {
    foreach(_id_4FE83B0D2DF701BB in _id_D23F6234846F86A6[label]) {
      _id_25FF688C15D791D2 = spawnStruct();
      _id_25FF688C15D791D2.visual = undefined;
      _id_25FF688C15D791D2.distancesquared = undefined;

      foreach(visual in _id_C236336A4B27E7DA) {
        distancesquared = distancesquared(_id_4FE83B0D2DF701BB, visual.origin);

        if(distancesquared > 400) {
          continue;
        }
        if(!isDefined(_id_25FF688C15D791D2.distancesquared) || distancesquared < _id_25FF688C15D791D2.distancesquared) {
          _id_25FF688C15D791D2.visual = visual;
          _id_25FF688C15D791D2.distancesquared = distancesquared;
        }
      }

      if(isDefined(_id_25FF688C15D791D2.visual))
        _id_C236336A4B27E7DA = scripts\engine\utility::array_remove(_id_C236336A4B27E7DA, _id_25FF688C15D791D2.visual);
    }
  }

  return _id_C236336A4B27E7DA;
}

postshipmodifychevrons(_id_C236336A4B27E7DA, label) {
  _id_34DCE00DF63CFF91 = [];

  switch (level.mapname) {
    case "mp_wartorn":
      _id_34DCE00DF63CFF91["_a"] = [];
      _id_34DCE00DF63CFF91["_a"][0] = [(-8705.1, 41410.1, 268), (0, 74, 0)];
      _id_34DCE00DF63CFF91["_a"][1] = [(-8789.1, 41434.1, 270), (0, 74, 0)];
      _id_34DCE00DF63CFF91["_a"][2] = [(-8843.1, 41446.1, 270), (0, 74, 0)];
      _id_34DCE00DF63CFF91["_a"][3] = [(-8936.38, 41990.3, 282), (0, 344, 0)];
      _id_34DCE00DF63CFF91["_a"][4] = [(-8875.08, 42015.3, 288.024), (0, 255, 0)];
      _id_34DCE00DF63CFF91["_a"][5] = [(-8702.42, 41972.5, 277.812), (0, 255, 0)];
      _id_34DCE00DF63CFF91["_a"][6] = [(-8582.16, 41936.6, 277.812), (0, 255, 0)];
      _id_34DCE00DF63CFF91["_a"][7] = [(-8456, 41902, 280), (0, 255, 0)];
      _id_34DCE00DF63CFF91["_a"][8] = [(-8328.93, 41577.2, 258.001), (0, 164, 0)];
      _id_34DCE00DF63CFF91["_a"][9] = [(-8984.06, 41783.8, 266.233), (0, 344, 0)];
      _id_34DCE00DF63CFF91["_b"] = [];
      _id_34DCE00DF63CFF91["_b"][0] = [(-7268.6, 43247.6, 302.314), (0, 75, 0)];
      _id_34DCE00DF63CFF91["_b"][1] = [(-7417.31, 43277.5, 310.182), (0, 75, 0)];
      _id_34DCE00DF63CFF91["_b"][2] = [(-7489.92, 43298.4, 320.182), (0, 75, 0)];
      _id_34DCE00DF63CFF91["_b"][3] = [(-6936.37, 43155.1, 261.456), (0, 75, 0)];
      _id_34DCE00DF63CFF91["_b"][4] = [(-7237.4, 43784.4, 269.851), (0, 340, 0)];
      _id_34DCE00DF63CFF91["_b"][5] = [(-7209.91, 43870, 267.73), (0, 340, 0)];
      _id_34DCE00DF63CFF91["_b"][6] = [(-7188.96, 43931.1, 265.13), (0, 340, 0)];
      _id_34DCE00DF63CFF91["_b"][7] = [(-7291.54, 43763.5, 257.326), (0, 253, 0)];
      _id_34DCE00DF63CFF91["_b"][8] = [(-6795.05, 43444.3, 247.059), (0, 160, 0)];
      _id_34DCE00DF63CFF91["_b"][9] = [(-6820.03, 43382.4, 238.789), (0, 160, 0)];
      _id_34DCE00DF63CFF91["_b"][10] = [(-6843.79, 43311.7, 245.027), (0, 160, 0)];
      _id_34DCE00DF63CFF91["_b"][11] = [(-6863.11, 43221.2, 271.244), (0, 160, 0)];
      _id_34DCE00DF63CFF91["_b"][12] = [(-6882.7, 43159.3, 268.085), (0, 160, 0)];
      break;
  }

  if(isDefined(_id_34DCE00DF63CFF91[label])) {
    _id_C081A38873B1D5E3 = [];

    foreach(index, _id_F90358454413407F in _id_34DCE00DF63CFF91[label]) {
      origin = _id_F90358454413407F[0];
      angles = _id_F90358454413407F[1];
      scriptable = spawnscriptable("hardpoint_chevron", origin, angles);
      _id_C081A38873B1D5E3[_id_C081A38873B1D5E3.size] = scriptable;
    }

    _id_C236336A4B27E7DA = scripts\engine\utility::array_combine(_id_C236336A4B27E7DA, _id_C081A38873B1D5E3);
  }

  return _id_C236336A4B27E7DA;
}

_id_0726259D42F88361(state) {
  self notify("updateChevrons");
  self endon("updateChevrons");

  while(!isDefined(self.chevrons))
    waitframe();

  _id_A27485475186B39D = "chevron_";

  foreach(_id_0EAE85273686F4F4 in self.chevrons) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0EAE85273686F4F4.numchevrons; _id_AC0E594AC96AA3A8++)
      _id_0EAE85273686F4F4 setscriptablepartstate(_id_A27485475186B39D + _id_AC0E594AC96AA3A8, state);
  }
}

_id_223FB185E0AFB231() {
  if(isDefined(self._id_AE9B09D28693B763) && self._id_AE9B09D28693B763 >= level._id_DA41C55843E26237 || self.ownerteam == game["attackers"])
    thread _id_0726259D42F88361("off");
  else if(self.stalemate)
    thread _id_0726259D42F88361("contested");
  else if(self.isunoccupied)
    thread _id_0726259D42F88361("idle");
  else
    thread _id_0726259D42F88361(self.mostnumtouchingteam);
}

_id_93B1902DC83D81D2(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  if(isDefined(attacker) && isPlayer(attacker) && attacker != self && attacker.team != self.team) {
    isattacker = attacker.team == game["attackers"];
    victim = self;
    attackerteam = attacker.team;
    livescount = scripts\mp\utility\teams::getteamdata(victim.team, "controlUILivesCount");
    _id_652F47620AC4713F = scripts\mp\utility\teams::getteamdata(victim.team, "teamCount");

    if(livescount - 1 == _id_652F47620AC4713F)
      _id_548072087C9FD504::_id_7D42D3F8DD68280C(24, victim.team);

    foreach(zone in level.objectives) {
      if(!isDefined(zone.trigger)) {
        continue;
      }
      _id_229449CFD54FDC5B = attacker istouching(zone.trigger);
      _id_9D0123AF024E86AC = victim istouching(zone.trigger);

      if(isattacker) {
        if(_id_229449CFD54FDC5B)
          attacker scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(11, 1);

        continue;
      }

      if(_id_9D0123AF024E86AC)
        attacker scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(11, 1);
    }

    if(isattacker)
      attacker scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(10, 1);
    else
      attacker scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(9, 1);

    _id_6663215F917210AE::awardgenericmedals(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00);
  }

  currentteam = self.team;
  _id_FE5EE0F83D4109EB = scripts\mp\damage::_id_FE5EE0F83D4109EB(einflictor, attacker, smeansofdeath, objweapon);
  _id_E07D55B45FC82AE0 = scripts\mp\damage::_id_E07D55B45FC82AE0(einflictor, attacker);

  if(isDefined(self.joining_team) && self.joining_team != "spectator")
    currentteam = scripts\mp\utility\game::getotherteam(self.joining_team)[0];

  if((_id_FE5EE0F83D4109EB || _id_E07D55B45FC82AE0) && !level._id_7CFD99E45A36D4FB && !istrue(self.switching_teams)) {
    if(scripts\mp\utility\teams::getteamdata(currentteam, "noRespawns"))
      thread scripts\mp\playerlogic::spawnclient();

    level thread _id_D620FD9B072DA70D(self, currentteam);
    return;
  }

  game["match_kills"][scripts\mp\utility\game::getotherteam(currentteam)[0]]++;
  _id_C6AE85C2AB29D931(self, currentteam);
}

_id_C6AE85C2AB29D931(player, _id_4154C74CBB62F73C) {
  if(!scripts\mp\utility\teams::getteamdata(_id_4154C74CBB62F73C, "noRespawns") && scripts\mp\utility\teams::getteamdata(_id_4154C74CBB62F73C, "livesCount") == 0)
    _id_539F2C0C7C8E8403(_id_4154C74CBB62F73C);

  level.teamdata[_id_4154C74CBB62F73C]["controlUILivesCount"]--;
  level _id_56C428EE980A8464();
  _id_6BCDFD625DAABEEF = _id_6F5C46FF82B34CC7(_id_4154C74CBB62F73C, 1);
  _id_652F47620AC4713F = scripts\mp\utility\teams::getteamdata(_id_4154C74CBB62F73C, "teamCount");

  if(_id_6BCDFD625DAABEEF == 0 && level._id_23D874371501C40D != 0 || _id_652F47620AC4713F == 0) {
    otherteam = scripts\mp\utility\game::getotherteam(_id_4154C74CBB62F73C)[0];
    level thread scripts\mp\gamelogic::endgame(otherteam, game["end_reason"]["enemies_eliminated"], game["end_reason"]["friendlies_eliminated"]);
    scripts\mp\codcasterclientmatchdata::_id_94C8F3722D550646();
  }
}

_id_BAEB9F54B3A7566D(team) {
  _id_B0DFD912BE32D040 = scripts\mp\utility\game::getlastlivingplayer(team);
  _id_B0DFD912BE32D040 thread _id_D217EC508307279E();
}

_id_D217EC508307279E() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\utility\player::waittillrecoveredhealth(3);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_915F01BAA2419C9F");
  otherteam = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastenemyalive", self, otherteam);
  level notify("last_alive", self);
}

_id_DF4C58D276EEA572(team) {
  if(scripts\mp\utility\game::gettimepassed() < 5000) {
    return;
  }
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players)
  player thread _id_154439FDBDB10B95::showrespawnwarningmessage();

  scripts\mp\utility\dialog::statusdialog("team_no_lives", team, "lives");

  foreach(enemyteam in scripts\mp\utility\game::getotherteam(team))
  scripts\mp\utility\dialog::statusdialog("enemy_no_lives", enemyteam, "lives");
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  if(istrue(level.teamscoresonkill[attacker.team]))
    _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);

  level _id_56C428EE980A8464();
}

getflagteam() {
  return scripts\mp\gameobjects::getownerteam();
}

flagsetup() {
  foreach(_id_3D4E0AF1F6597DC4 in level.objectives)
  _id_3D4E0AF1F6597DC4.spawnflagid = getflagspawnidforobjectivekey(_id_3D4E0AF1F6597DC4.objectivekey);

  spawnpoints = level.spawnpoints;

  foreach(spawnpoint in spawnpoints)
  spawnpoint.scriptdata.domflagassignments = getspawnpointflagassignment(spawnpoint);
}

getflagspawnidforobjectivekey(objectivekey) {
  switch (objectivekey) {
    case "_a":
      return 1;
    case "_b":
      return 2;
    case "_c":
      return 4;
    case "_d":
      return 8;
    case "_e":
      return 16;
  }

  return undefined;
}

getspawnpointflagassignment(spawnpoint) {
  if(scripts\cp_mp\utility\game_utility::isarenamap()) {
    if(spawnpoint.script_noteworthy == "1" || spawnpoint.script_noteworthy == "2" || spawnpoint.script_noteworthy == "3")
      spawnpoint.script_noteworthy = "";
  }

  if(isDefined(spawnpoint.script_noteworthy) && spawnpoint.script_noteworthy != "" && spawnpoint.script_noteworthy != "6v6" && spawnpoint.script_noteworthy != "10v10") {
    _id_73EF432F38CED282 = parseflagassignmentstring(spawnpoint.script_noteworthy);

    if(isDefined(_id_73EF432F38CED282))
      return _id_73EF432F38CED282;
  }

  _id_EF41E2C126D3EE6B = findnearestdompoint(spawnpoint.origin);
  return _id_EF41E2C126D3EE6B.spawnflagid;
}

parseflagassignmentstring(_id_0DD683497230EAE5) {
  _id_0DD683497230EAE5 = tolower(_id_0DD683497230EAE5);

  switch (_id_0DD683497230EAE5) {
    case "a":
      return 1;
    case "b":
      return 2;
    case "c":
      return 4;
    case "d":
      return 8;
    case "e":
      return 16;
    case "ba":
    case "ab":
      return 32;
    case "bc":
    case "cb":
      return 64;
    case "ca":
    case "ac":
      return 128;
    default:
      break;
  }
}

findnearestdompoint(pos) {
  _id_73D756724E06734C = [];

  foreach(_id_1183B8D0EE70C22F in level.objectives) {
    _id_1183B8D0EE70C22F.navmeshpos = getclosestpointonnavmesh(_id_1183B8D0EE70C22F.trigger.origin);
    _id_73D756724E06734C[_id_73D756724E06734C.size] = _id_1183B8D0EE70C22F.navmeshpos;
  }

  _id_2A1E7872F714F838 = findclosestpointbyapproxpathdist(_id_73D756724E06734C, getclosestpointonnavmesh(pos));
  _id_EF41E2C126D3EE6B = undefined;

  if(!isDefined(_id_2A1E7872F714F838)) {
    _id_36213E24B6EA2351 = undefined;

    foreach(_id_1183B8D0EE70C22F in level.objectives) {
      dist = distancesquared(_id_1183B8D0EE70C22F.trigger.origin, pos);

      if(!isDefined(_id_EF41E2C126D3EE6B) || dist < _id_36213E24B6EA2351) {
        _id_EF41E2C126D3EE6B = _id_1183B8D0EE70C22F;
        _id_36213E24B6EA2351 = dist;
      }
    }
  } else {
    foreach(_id_1183B8D0EE70C22F in level.objectives) {
      if(distance2dsquared(_id_1183B8D0EE70C22F.navmeshpos, _id_2A1E7872F714F838) < 1.0) {
        _id_EF41E2C126D3EE6B = _id_1183B8D0EE70C22F;
        break;
      }
    }
  }

  return _id_EF41E2C126D3EE6B;
}

_id_EEBC5ADA1461570C(_id_9156B53BCF7CE573) {
  thread updatematchstatushintonspawn();

  if(scripts\mp\utility\teams::getteamdata(self.team, "livesCount") == 0 && scripts\mp\utility\teams::getteamdata(self.team, "noRespawns") == 0 && level._id_23D874371501C40D != 0)
    _id_539F2C0C7C8E8403(self.team);
}

_id_D9C3E51EC6BC88BE(player) {
  if(scripts\mp\utility\teams::getteamdata(player.team, "noRespawns") && player.team != "none" && player.team != "spectator")
    return 1;

  return 0;
}

_id_8C35121EC0B41C27(player) {
  player thread onplayerspawned();
}

_id_51CF571AD0EB34B9(player) {
  if(scripts\mp\utility\player::isreallyalive(player))
    _id_C6AE85C2AB29D931(player, player.team);
}

_id_D620FD9B072DA70D(player, currentteam) {
  level.teamdata[currentteam]["uncountedDeaths"]++;
  player._id_5F07316A0CB9F1DE = 1;
  player scripts\engine\utility::waittill_any_2("spawned", "disconnect");
  level.teamdata[currentteam]["uncountedDeaths"]--;
  player._id_5F07316A0CB9F1DE = undefined;
}

_id_56C428EE980A8464() {
  _id_853BAB92F5CDDACB = scripts\mp\utility\teams::getteamdata("allies", "aliveCount");
  _id_648C7106B0A281E7 = scripts\mp\utility\teams::getteamdata("axis", "aliveCount");

  if(level._id_23D874371501C40D == 0) {
    setomnvar("ui_allies_alive", scripts\mp\utility\teams::getteamdata("allies", "teamCount"));
    setomnvar("ui_axis_alive", scripts\mp\utility\teams::getteamdata("axis", "teamCount"));
    setomnvar("ui_allies_lives_remaining", scripts\mp\utility\teams::getteamdata("allies", "teamCount"));
    setomnvar("ui_axis_lives_remaining", scripts\mp\utility\teams::getteamdata("axis", "teamCount"));
    return;
  } else if(_id_853BAB92F5CDDACB > level._id_23D874371501C40D || _id_648C7106B0A281E7 > level._id_23D874371501C40D) {
    _id_4EDF38FBAB5966E5 = scripts\engine\utility::ter_op(_id_853BAB92F5CDDACB > _id_648C7106B0A281E7, _id_853BAB92F5CDDACB, _id_648C7106B0A281E7);
    _id_1F5AB97903453CE1("allies", _id_4EDF38FBAB5966E5);
    _id_1F5AB97903453CE1("axis", _id_4EDF38FBAB5966E5);
    level._id_23D874371501C40D = _id_4EDF38FBAB5966E5;
  }

  setomnvar("ui_allies_alive", _id_6F5C46FF82B34CC7("allies", 1));
  setomnvar("ui_axis_alive", _id_6F5C46FF82B34CC7("axis", 1));
  setomnvar("ui_allies_lives_remaining", _id_6F5C46FF82B34CC7("allies", 1));
  setomnvar("ui_axis_lives_remaining", _id_6F5C46FF82B34CC7("axis", 1));
  _id_3C88E2C95A9C563D = level.teamdata["allies"]["teamCount"];

  if(scripts\mp\utility\teams::getteamdata("allies", "livesCount") <= 10 && !level._id_A18FA3DE81FEFF0A && level._id_23D874371501C40D - _id_3C88E2C95A9C563D > 10) {
    scripts\mp\utility\dialog::statusdialog("team_low_lives", "allies", "lives");
    scripts\mp\utility\dialog::statusdialog("enemy_low_lives", "axis", "lives");
    level._id_A18FA3DE81FEFF0A = 1;
  }

  _id_76686016AD63E461 = level.teamdata["axis"]["teamCount"];

  if(scripts\mp\utility\teams::getteamdata("axis", "livesCount") <= 10 && !level._id_A18FA0DE81FEF871 && level._id_23D874371501C40D - _id_76686016AD63E461 > 10) {
    scripts\mp\utility\dialog::statusdialog("team_low_lives", "axis", "lives");
    scripts\mp\utility\dialog::statusdialog("enemy_low_lives", "allies", "lives");
    level._id_A18FA0DE81FEF871 = 1;
  }
}

_id_1F5AB97903453CE1(_id_A3BF560B25C4A33E, _id_41E4D73FABED18DF) {
  _id_BCE4EFC75EB01319 = scripts\mp\utility\teams::getteamdata(_id_A3BF560B25C4A33E, "aliveCount");
  livescount = scripts\mp\utility\teams::getteamdata(_id_A3BF560B25C4A33E, "livesCount");
  _id_C25C5E1C4026B366 = scripts\mp\utility\teams::getteamdata(_id_A3BF560B25C4A33E, "controlUILivesCount");

  if(_id_41E4D73FABED18DF < _id_C25C5E1C4026B366 || _id_41E4D73FABED18DF < _id_BCE4EFC75EB01319 + livescount) {
    return;
  }
  if(_id_BCE4EFC75EB01319 + livescount < _id_41E4D73FABED18DF) {
    _id_E4C33C2942B6C9CD = _id_41E4D73FABED18DF - (_id_BCE4EFC75EB01319 + livescount);
    level.teamdata[_id_A3BF560B25C4A33E]["livesCount"] = level.teamdata[_id_A3BF560B25C4A33E]["livesCount"] + _id_E4C33C2942B6C9CD;
    level.teamdata[_id_A3BF560B25C4A33E]["noRespawns"] = 0;
  }

  if(_id_C25C5E1C4026B366 != _id_41E4D73FABED18DF)
    level.teamdata[_id_A3BF560B25C4A33E]["controlUILivesCount"] = _id_41E4D73FABED18DF;
}

_id_99A2435BDAA61D08() {
  level _id_56C428EE980A8464();
}

_id_6F5C46FF82B34CC7(team, _id_59A886B576F75DC8) {
  _id_AE75A4D0DCB50F69 = undefined;

  if(istrue(_id_59A886B576F75DC8))
    _id_AE75A4D0DCB50F69 = level.teamdata[team]["controlUILivesCount"];
  else {
    livescount = scripts\mp\utility\teams::getteamdata(team, "livesCount");
    _id_BCE4EFC75EB01319 = scripts\mp\utility\teams::getteamdata(team, "aliveCount");
    _id_AE75A4D0DCB50F69 = livescount + _id_BCE4EFC75EB01319;
  }

  if(!isDefined(_id_AE75A4D0DCB50F69) || _id_AE75A4D0DCB50F69 < 0)
    _id_AE75A4D0DCB50F69 = 0;

  return _id_AE75A4D0DCB50F69;
}

onplayerspawned(player) {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned");
    scripts\mp\utility\stats::setextrascore0(0);

    if(isDefined(self.pers["damage"]))
      scripts\mp\utility\stats::setextrascore0(self.pers["damage"]);

    scripts\mp\utility\stats::setextrascore1(0);

    if(isDefined(self.pers["segmentCaptures"]))
      scripts\mp\utility\stats::setextrascore1(self.pers["segmentCaptures"]);

    level _id_56C428EE980A8464();
  }
}

_id_6DC36E4DD3018346(_id_3985F515E9F06D2C, label, _id_22282E7D48CA3400, team, _id_8A04AA0E0755E7E3, _id_579DA7B2997DEC60) {
  level.usestartspawns = 0;
  soundalias = undefined;
  _id_69DD2B8B93EF2940 = undefined;
  game["segment_captures"][team]++;
  _id_548072087C9FD504::_id_0216B35CA5806EC6(game["segment_captures"][team], team);
  _id_37FA3A520E86530D(_id_22282E7D48CA3400);
  otherteam = scripts\mp\utility\game::getotherteam(team)[0];

  if(_id_6663215F917210AE::getteamflagcount(team) == level.objectives.size) {
    soundalias = "mp_dom_flag_captured_all";
    _id_69DD2B8B93EF2940 = "mp_dom_flag_lost";
  } else {
    soundalias = "mp_dom_flag_captured";
    _id_69DD2B8B93EF2940 = "mp_dom_flag_lost";
  }

  thread scripts\mp\utility\print::printandsoundoneveryone(team, otherteam, undefined, undefined, soundalias, _id_69DD2B8B93EF2940, _id_22282E7D48CA3400);

  if(_id_6663215F917210AE::getteamflagcount(team) < level.objectives.size) {
    scripts\mp\utility\dialog::statusdialog("secured" + self.objectivekey, team);

    if(isDefined(_id_8A04AA0E0755E7E3) && _id_8A04AA0E0755E7E3 == "neutral") {
      if(isDefined(level.objectives) && level.objectives.size == 5 && (self.objectivekey == "_c" || self.objectivekey == "_d") || self.objectivekey == "_b")
        scripts\mp\utility\dialog::statusdialog("lost" + self.objectivekey, otherteam);
    } else
      scripts\mp\utility\dialog::statusdialog("lost" + self.objectivekey, otherteam);
  } else {
    thread scripts\mp\music_and_dialog::dominating_music(team);
    scripts\mp\utility\dialog::statusdialog("gamestate_domwinning", team);
    scripts\mp\utility\dialog::statusdialog("gamestate_domlosing", otherteam);
  }

  if(!isDefined(level._id_B6D6B525AEAA0557))
    level._id_B6D6B525AEAA0557 = 0;

  level._id_B6D6B525AEAA0557++;

  if(level._id_B6D6B525AEAA0557 == level.objectives.size - 1) {
    scripts\mp\utility\dialog::statusdialog("attack_last_flag", team, "finale");
    scripts\mp\utility\dialog::statusdialog("defend_last_flag", otherteam, "finale");
    setmusicstate("mp_timesup_general");
  }

  if(level._id_B6D6B525AEAA0557 == level.objectives.size) {
    level thread scripts\mp\gamelogic::endgame(game["attackers"], game["end_reason"]["control_allzones_win"], game["end_reason"]["control_allzones_loss"]);
    scripts\mp\codcasterclientmatchdata::_id_94C8F3722D550646();
  } else {
    _id_579DA7B2997DEC60._id_25317B559796E5D1 = 0;
    _id_365B87F0954E784B = scripts\engine\utility::array_remove(level.objectives, _id_579DA7B2997DEC60)[0];

    if(!istrue(_id_365B87F0954E784B._id_25317B559796E5D1))
      scripts\mp\gamelogic::resumetimer();

    if(level._id_FB709E12ADDF5E47 > 0)
      thread _id_FC3C787B555257AC(level._id_FB709E12ADDF5E47, istrue(_id_365B87F0954E784B._id_25317B559796E5D1));
    else
      thread _id_FC3C787B555257AC(level._id_5D2813FEE57C50A8, istrue(_id_365B87F0954E784B._id_25317B559796E5D1));
  }

  _id_1D4121D1C73E4374 = scripts\mp\gameobjects::_id_FD1B4A7D915FC9A6(_id_579DA7B2997DEC60.curorigin, _id_579DA7B2997DEC60.offset3d, 1, 0);
  _id_1D4121D1C73E4374 scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_dom_captured");
  level._id_BDD2491524B1DDD5[label] = _id_1D4121D1C73E4374;
  _id_6663215F917210AE::removeobjective(_id_579DA7B2997DEC60);
}

_id_90EE8E359D6D3323(team, _id_4B22E50E504339FE, _id_1F7FD473E2E3E8AA) {
  otherteam = scripts\mp\utility\game::getotherteam(team)[0];

  if(self._id_AE9B09D28693B763 != level._id_DA41C55843E26237) {
    game["segment_captures"][team]++;
    _id_37FA3A520E86530D(_id_4B22E50E504339FE);
    _id_548072087C9FD504::_id_0216B35CA5806EC6(game["segment_captures"][team], team);
  }

  if(_id_6663215F917210AE::getteamflagcount(team) == level.objectives.size) {
    soundalias = "mp_dom_flag_captured_all";
    _id_69DD2B8B93EF2940 = "mp_dom_flag_lost";
  } else {
    soundalias = "mp_control_win_sfx";
    _id_69DD2B8B93EF2940 = "mp_control_lose_sfx";
  }

  thread scripts\mp\utility\print::printandsoundoneveryone(team, otherteam, undefined, undefined, soundalias, _id_69DD2B8B93EF2940, _id_4B22E50E504339FE);
  pause_timer = _id_1F7FD473E2E3E8AA != level._id_DA41C55843E26237;

  if(level._id_FB709E12ADDF5E47 > 0)
    thread _id_FC3C787B555257AC(level._id_FB709E12ADDF5E47, pause_timer);
}

_id_FC3C787B555257AC(time, _id_62A68B92C1D8CF78) {
  if(scripts\mp\utility\dvars::getwatcheddvar("timelimit") == 0) {
    return;
  }
  if(!isDefined(level.extratime))
    level.extratime = 0;

  level.extratime = level.extratime + time;
  timeremaining = scripts\mp\gamelogic::gettimeremaining();
  scripts\mp\gamelogic::resumetimer(level.extratime + timeremaining);
  waitframe();

  if(level.pausetimer && istrue(_id_62A68B92C1D8CF78))
    scripts\mp\gamelogic::pausetimer();
}

_id_E5B3B788AA8A4401() {
  startpos = self getEye();
  _id_8C57EF0D95A6EE0C = self getplayerangles();
  fwd = anglesToForward(_id_8C57EF0D95A6EE0C);
  _id_ED9AE4EC33B989C6 = cos(10);
  _id_CDC5DD6C28C9709D = 250000;
  _id_445ACA8C2C95592E = undefined;
  _id_37088D8C2341BC50 = undefined;
  _id_A52892DFFB2F5A53 = undefined;
  _id_84D4866087B00608 = undefined;
  _id_0DA9D76F5A9B4145 = undefined;

  foreach(ent in level.objectives) {
    _id_7F96D62F3ABBF9B9 = vectorNormalize(ent.trigger.origin - startpos);
    dot = vectordot(fwd, _id_7F96D62F3ABBF9B9);
    distsq = distancesquared(ent.trigger.origin, startpos);

    if(!isDefined(_id_445ACA8C2C95592E) || _id_445ACA8C2C95592E < dot) {
      _id_445ACA8C2C95592E = dot;
      _id_A52892DFFB2F5A53 = distsq;
      _id_37088D8C2341BC50 = ent;
    }

    if(!isDefined(_id_84D4866087B00608) || _id_84D4866087B00608 > distsq) {
      _id_84D4866087B00608 = distsq;
      _id_0DA9D76F5A9B4145 = ent;
    }
  }

  ent = undefined;
  msg = undefined;
  event = undefined;

  if(isDefined(_id_445ACA8C2C95592E) && _id_445ACA8C2C95592E > _id_ED9AE4EC33B989C6) {
    ent = _id_37088D8C2341BC50;
    objectivename = getsubstr(ent.objectivekey, 1, 2);

    if(ent.ownerteam == "neutral") {
      msg = self.name + ": Capture " + objectivename + "!";
      event = "capture";
    } else if(ent.ownerteam == self.team) {
      msg = self.name + ": Defend" + objectivename + "!";
      event = "defend";
    } else {
      msg = self.name + ": Assault " + objectivename + "!";
      event = "assault";
    }
  } else if(isDefined(_id_84D4866087B00608) && _id_84D4866087B00608 < _id_CDC5DD6C28C9709D) {
    ent = _id_0DA9D76F5A9B4145;
    objectivename = getsubstr(ent.objectivekey, 1, 2);

    if(ent.ownerteam == "neutral") {
      msg = self.name + ": Capture " + objectivename + "!";
      event = "capture";
    } else if(ent.ownerteam == self.team) {
      msg = self.name + ": Defend" + objectivename + "!";
      event = "defend";
    } else {
      msg = self.name + ": Assault " + objectivename + "!";
      event = "assault";
    }
  }

  if(isDefined(ent))
    thread scripts\cp_mp\gestures::applygamemodecallout(ent, msg, event);

  return isDefined(ent);
}

_id_D234DB657E8B7DC5(event, player) {
  _id_98DA853291A33610 = 0;

  switch (event) {
    case "capture":
      if(player.team == self.team)
        _id_98DA853291A33610 = 1;

      break;
    case "defend":
      if(player.team == self.team)
        _id_98DA853291A33610 = 1;

      break;
    case "assault":
      if(player.team == self.team)
        _id_98DA853291A33610 = 1;

      break;
  }

  return _id_98DA853291A33610;
}

_id_0FCB83CD8B5B5098(_id_B436B4763AE72FCD) {
  if(!isDefined(level.objectives))
    return 0;

  _id_84CDF2CB02579EE3 = level.objectives;

  if(isDefined(_id_B436B4763AE72FCD))
    _id_84CDF2CB02579EE3 = scripts\engine\utility::array_remove(_id_84CDF2CB02579EE3, _id_B436B4763AE72FCD);

  foreach(objective in level.objectives) {
    if(istrue(objective._id_25317B559796E5D1))
      return 1;
  }

  return 0;
}

updatematchstatushintonspawn() {
  level endon("game_ended");

  if(self.team == game["attackers"])
    scripts\mp\hud_message::_id_F004EF4606B9EFDC("control_attack_zones");
  else
    scripts\mp\hud_message::_id_F004EF4606B9EFDC("control_defend_zones");

  level _id_56C428EE980A8464();
}

updatetriggerforcodcaster() {
  level endon("game_ended");
  level waittill("prematch_done");

  while(!level.gameended) {
    foreach(player in level.players) {
      mlgpoint = 0;

      foreach(_id_1183B8D0EE70C22F in level.objectives) {
        if(!isDefined(_id_1183B8D0EE70C22F.trigger)) {
          continue;
        }
        if(player istouching(_id_1183B8D0EE70C22F.trigger) && isalive(player)) {
          mlgpoint = _id_6663215F917210AE::getreservedobjid(_id_1183B8D0EE70C22F.objectivekey) + 1;
          break;
        }
      }

      if(!isDefined(player.mlgpoint) || player.mlgpoint != mlgpoint) {
        player setmlgdominationpoint(mlgpoint);
        player.mlgpoint = mlgpoint;
        player setgametypevip(1);
      }

      if(mlgpoint == 0)
        player setgametypevip(0);
    }

    waitframe();
  }
}

_id_FA93175C92F8F506() {
  if(!isDefined(level._id_3D06DE480D9EF9C4)) {
    level thread scripts\mp\gamelogic::endgame(game["defenders"], game["end_reason"]["time_limit_reached"]);
    scripts\mp\codcasterclientmatchdata::_id_94C8F3722D550646();
    level._id_3D06DE480D9EF9C4 = 1;
  }
}

_id_63A77191349871BF() {
  scripts\mp\codcasterclientmatchdata::_id_0EDBA1EE7C2375A5();
}

_id_539F2C0C7C8E8403(team) {
  scripts\mp\utility\teams::setteamdata(team, "noRespawns", 1);

  if(!isDefined(level._id_DEFC2ACD2B0203AD))
    level._id_DEFC2ACD2B0203AD = [];

  level._id_DEFC2ACD2B0203AD[team] = gettime();
  _id_DF4C58D276EEA572(team);
}

_id_287623BBB15154BE() {
  _id_D6FD8BE398B20F61 = game["attackers"];
  _id_8613C2B22B0116A5 = game["defenders"];

  if(level._id_64C1510A260A9426 == 2) {
    if(game["segment_captures"][_id_D6FD8BE398B20F61] > game["segment_captures"][_id_8613C2B22B0116A5])
      return [_id_D6FD8BE398B20F61, game["end_reason"]["team_defending_most_segments"]];
    else if(game["segment_captures"][_id_8613C2B22B0116A5] > game["segment_captures"][_id_D6FD8BE398B20F61])
      return [_id_8613C2B22B0116A5, game["end_reason"]["team_defending_most_segments"]];
  }

  _id_77F3CA6D2F0AAE12[_id_D6FD8BE398B20F61] = game["match_kills"][_id_D6FD8BE398B20F61];
  _id_77F3CA6D2F0AAE12[_id_8613C2B22B0116A5] = game["match_kills"][_id_8613C2B22B0116A5];

  if(_id_77F3CA6D2F0AAE12[_id_D6FD8BE398B20F61] > _id_77F3CA6D2F0AAE12[_id_8613C2B22B0116A5])
    return [_id_D6FD8BE398B20F61, game["end_reason"]["team_defending_most_kills"]];
  else if(_id_77F3CA6D2F0AAE12[_id_8613C2B22B0116A5] > _id_77F3CA6D2F0AAE12[_id_D6FD8BE398B20F61])
    return [_id_8613C2B22B0116A5, game["end_reason"]["team_defending_most_kills"]];
  else if(randomint(2) == 0)
    return [_id_D6FD8BE398B20F61, game["end_reason"]["team_defending"]];
  else
    return [_id_8613C2B22B0116A5, game["end_reason"]["team_defending"]];
}

_id_37FA3A520E86530D(player) {
  player scripts\mp\utility\stats::incpersstat("segmentCaptures", 1);
  player scripts\mp\persistence::statsetchild("round", "segmentCaptures", player.pers["segmentCaptures"]);
  player scripts\mp\utility\stats::setextrascore1(player.pers["segmentCaptures"]);
}