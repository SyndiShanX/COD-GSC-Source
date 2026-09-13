/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dom.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  level._id_2CF7B819EE66EE8E = scripts\mp\utility\dvars::dvarintvalue("useStrongholdHills", 0, 0, 1);

  if(level._id_2CF7B819EE66EE8E)
    _id_9BBACB179DEA3237[0] = "hardpoint";
  else if(scripts\cp_mp\utility\game_utility::_id_2D79A7A3B91C4C3E())
    _id_9BBACB179DEA3237 = _id_26508F2DE04C7A52::_id_4248416FFFB4C5B3();
  else
    _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();

  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 200);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level._id_0952BD6E10104D8A = ::_id_0952BD6E10104D8A;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.modeonspawnplayer = ::onspawnplayer;
  level.lastcaptime = gettime();
  level.onobjectivecomplete = ::onflagcapture;
  level.onmaprestart = ::_id_6D0C070C982EDDB4;

  if(isDefined(level.numflagsscoreonkill) && level.numflagsscoreonkill > 0) {
    level.teamscoresonkill = [];
    level.onnormaldeath = ::onnormaldeath;
    setdynamicdvar(_func_2EF675C13CA1C4AF("dvar_39365BFDE3C7D1C4"), 1);
  }

  level.domflag_setneutral = _id_6663215F917210AE::domflag_setneutral;
  level.dompoint_setcaptured = _id_6663215F917210AE::dompoint_setcaptured;
  level.onflagcapture = ::onflagcapture;
  level.playholdtwovo = 0;

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    game["dialog"]["gametype"] = "iw9_mdom_mode_uktl_dnt1";
  else
    game["dialog"]["gametype"] = "iw9_mdom_mode_uktl_name";

  game["dialog"]["offense_obj"] = "iw9_mdom_mode_uktl_bost";
  game["dialog"]["defense_obj"] = "iw9_mdom_mode_uktl_bost";
  game["dialog"]["securing_a"] = "iw9_mdom_mode_uktl_dsca";
  game["dialog"]["securing_b"] = "iw9_mdom_mode_uktl_dscb";
  game["dialog"]["securing_c"] = "iw9_mdom_mode_uktl_dscc";
  game["dialog"]["securing_d"] = "iw9_mdom_mode_uktl_dscd";
  game["dialog"]["securing_e"] = "iw9_mdom_mode_uktl_dsce";
  game["dialog"]["secured_a"] = "iw9_mdom_mode_uktl_dcpa";
  game["dialog"]["secured_b"] = "iw9_mdom_mode_uktl_dcpb";
  game["dialog"]["secured_c"] = "iw9_mdom_mode_uktl_dcpc";
  game["dialog"]["secured_d"] = "iw9_mdom_mode_uktl_dcpd";
  game["dialog"]["secured_e"] = "iw9_mdom_mode_uktl_dcpe";
  game["dialog"]["losing_a"] = "iw9_mdom_mode_uktl_dlsa";
  game["dialog"]["losing_b"] = "iw9_mdom_mode_uktl_dlsb";
  game["dialog"]["losing_c"] = "iw9_mdom_mode_uktl_dlsc";
  game["dialog"]["losing_d"] = "iw9_mdom_mode_uktl_dlsd";
  game["dialog"]["losing_e"] = "iw9_mdom_mode_uktl_dlse";
  game["dialog"]["lost_a"] = "iw9_mdom_mode_uktl_dloa";
  game["dialog"]["lost_b"] = "iw9_mdom_mode_uktl_dlob";
  game["dialog"]["lost_c"] = "iw9_mdom_mode_uktl_dloc";
  game["dialog"]["lost_d"] = "iw9_mdom_mode_uktl_dlod";
  game["dialog"]["lost_e"] = "iw9_mdom_mode_uktl_dloe";
  game["dialog"]["enemy_captured_2"] = "iw9_mdom_mode_uktl_dec2";
  game["dialog"]["friendly_captured_2"] = "iw9_mdom_mode_uktl_dfc2";
  game["dialog"]["gamestate_domlosing"] = "iw9_mdom_mode_uktl_doml";
  game["dialog"]["gamestate_domwinning"] = "iw9_mdom_mode_uktl_domw";
  game["dialog"]["friendly_scoring"] = "iw9_mpgm_anno_uktl_hofs";
  game["dialog"]["enemy_scoring"] = "iw9_mpgm_anno_uktl_hoes";

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    _id_26508F2DE04C7A52::_id_8C9C24A50231B1F9();
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_dom_flagcapturetime", getmatchrulesdata("domData", "flagCaptureTime"));
  setdynamicdvar("dvar_D764A88A211808AB", getmatchrulesdata("domData", "flagDecayTime"));
  setdynamicdvar("dvar_0D5B44A6D740AA7D", getmatchrulesdata("domData", "flagModelHidden"));
  setdynamicdvar("scr_dom_flagneutralization", getmatchrulesdata("domData", "flagNeutralization"));
  setdynamicdvar("dvar_A8B54822CF2AE875", getmatchrulesdata("domData", "flagReinforcement"));
  setdynamicdvar("scr_dom_flagsrequiredtoscore", getmatchrulesdata("domData", "flagsRequiredToScore"));
  setdynamicdvar("scr_dom_numflagsscoreonkill", getmatchrulesdata("domData", "numFlagsScoreOnKill"));
  setdynamicdvar("scr_dom_objscalar", getmatchrulesdata("domData", "objScalar"));
  setdynamicdvar("scr_dom_pointsperflag", getmatchrulesdata("domData", "pointsPerFlag"));
  setdynamicdvar("dvar_4741178D39231B2D", getmatchrulesdata("domData", "pointsPerReinforcedFlag"));
  setdynamicdvar("dvar_79DC889414104040", getmatchrulesdata("domData", "reinforcementStompScalar"));
  setdynamicdvar("dvar_C2487DD62D832C6F", getmatchrulesdata("domData", "shuffleHillRoundCount"));
  setdynamicdvar("dvar_815362D3D31C11E4", getmatchrulesdata("domData", "strongholdScoreAllCapIncrement"));
  setdynamicdvar("dvar_DD2EE550FF868233", getmatchrulesdata("domData", "strongholdScoreIncrement"));
  setdynamicdvar("dvar_748324579ED364DF", getmatchrulesdata("domData", "strongholdScoreInterval"));
  setdynamicdvar("dvar_AE69F23606846528", getmatchrulesdata("domData", "useStrongholdScoring"));
  setdynamicdvar("scr_dom_precappoints", getmatchrulesdata("siegeData", "preCapPoints"));
  setdynamicdvar("scr_dom_capturetype", getmatchrulesdata("captureData", "captureType"));
  setdynamicdvar("scr_dom_capturedecay", getmatchrulesdata("captureData", "captureDecay"));
  setdynamicdvar("scr_dom_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("dom", 0);
}

seticonnames() {
  level.iconneutral = "waypoint_captureneutral";
  level.iconcapture = "waypoint_capture";
  level.icondefend = "waypoint_defend";
  level.icondefending = "waypoint_defending";
  level.iconcontested = "waypoint_contested";
  level.icontaking = "waypoint_taking";
  level.iconlosing = "waypoint_losing";
  level._id_88E61386EF037AAF = "waypoint_clearing";
  level._id_0A58E0495B821276 = "waypoint_reinforcing";
}

onstartgametype() {
  seticonnames();

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(isDefined(level.teamscoresonkill))
      level.teamscoresonkill[_id_F90358454413407F] = level.precappoints >= level.numflagsscoreonkill && level.precappoints >= level.flagsrequiredtoscore;

    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/DOM");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/DOM");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/DOM_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/DOM_HINT");
  }

  setclientnamemode("auto_change");

  if(level.scoremod["kill"] > 0) {
    game["dialog"]["offense_obj"] = "boost_groundwar";
    game["dialog"]["defense_obj"] = "boost_groundwar";
  }

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    _id_2B21F2FBE8DD5C6E = game["attackers"];
    _id_8D904E28CF14C8AE = game["defenders"];
    game["attackers"] = _id_8D904E28CF14C8AE;
    game["defenders"] = _id_2B21F2FBE8DD5C6E;
  }

  initspawns();
  thread domflags();
  thread updatedomscores();
  _id_641E4E9B12A99632::inittankspawns();
}

_id_0952BD6E10104D8A() {
  if(level.scoremod["kill"] > 0)
    setDvar("dvar_CF1C084C7A6622F9", 1);
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("flagCaptureTime", 10, 0, 30);
  level._id_CF4070FA327A81A2 = scripts\mp\utility\dvars::dvarfloatvalue("flagDecayTime", 0, 0, 30);
  level._id_0393D50BC6A378DC = scripts\mp\utility\dvars::dvarintvalue("flagModelHidden", 0, 0, 1);
  level.flagneutralization = scripts\mp\utility\dvars::dvarintvalue("flagNeutralization", 0, 0, 1);
  level._id_3D37CDC4C1238328 = scripts\mp\utility\dvars::dvarintvalue("flagReinforcement", 0, 0, 1);
  level.flagsrequiredtoscore = scripts\mp\utility\dvars::dvarintvalue("flagsRequiredToScore", 1, 1, 3);
  level.numflagsscoreonkill = scripts\mp\utility\dvars::dvarintvalue("numFlagsScoreOnKill", 0, 0, 3);
  level.objectivescaler = scripts\mp\utility\dvars::dvarfloatvalue("objScalar", 4, 1, 10);
  level.pointsperflag = scripts\mp\utility\dvars::dvarintvalue("pointsPerFlag", 1, 1, 300);
  level._id_55C7198FF5BDA690 = scripts\mp\utility\dvars::dvarintvalue("pointsPerReinforcedFlag", 0, 0, 300);
  level._id_D701BF01C81A10B3 = scripts\mp\utility\dvars::dvarfloatvalue("reinforcementStompScalar", 1, 1, 10);
  level._id_80FD35AF3BB73B72 = scripts\mp\utility\dvars::dvarintvalue("shuffleHillRoundCount", 2, 0, 10);
  level._id_6000406FB4BD08B7 = scripts\mp\utility\dvars::dvarintvalue("strongholdScoreAllCapIncrement", 2, 2, 10);
  level._id_5AF4925BA79C5958 = scripts\mp\utility\dvars::dvarintvalue("strongholdScoreIncrement", 1, 1, 5);
  level._id_CC84EF7F24B8BE32 = scripts\mp\utility\dvars::dvarfloatvalue("strongholdScoreInterval", 1, 1, 10);
  level._id_701CE1283B8E2DB7 = scripts\mp\utility\dvars::dvarintvalue("useStrongholdScoring", 0, 0, 1);
  level.precappoints = scripts\mp\utility\dvars::dvarintvalue("preCapPoints", 0, 0, 1);
  level.capturetype = scripts\mp\utility\dvars::dvarintvalue("captureType", 1, 0, 3);
  level.capturedecay = scripts\mp\utility\dvars::dvarintvalue("captureDecay", 1, 0, 1);
}

initspawns() {
  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()))
    scripts\mp\spawnlogic::setactivespawnlogic("BigTDM", "Crit_Default");
  else if(istrue(level.adjustshipmentspawns))
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  else
    scripts\mp\spawnlogic::setactivespawnlogic("Domination", "Crit_Default");

  if(scripts\mp\spawnselection::_id_167619FE3D0CFF00()) {
    level.gamemodestartspawnpointnames = [];
    level.gamemodestartspawnpointnames["allies"] = "mp_dom_spawn_allies_start";
    level.gamemodestartspawnpointnames["axis"] = "mp_dom_spawn_axis_start";
    level.gamemodespawnpointnames = [];
    level.gamemodespawnpointnames["allies"] = "mp_dom_spawn";
    level.gamemodespawnpointnames["axis"] = "mp_dom_spawn";
  }

  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dom_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dom_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_dom_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_dom_spawn_axis_start");
  attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_allies_start");
  _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", _id_2FD93EA689E77097);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dom_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dom_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dom_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dom_spawn_secondary", 1, 1);
  _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn");
  _id_3A5288F40C8BE099 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("dom", _id_29D9D2428185616D);
  scripts\mp\spawnlogic::registerspawnset("dom_fallback", _id_3A5288F40C8BE099);

  if(istrue(level.adjustshipmentspawns)) {
    scripts\mp\spawnlogic::registerspawnset("normal", _id_29D9D2428185616D);
    scripts\mp\spawnlogic::registerspawnset("fallback", _id_3A5288F40C8BE099);
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  spawnteam = self.pers["team"];
  _id_E02688745E0052C3 = getteamdompoints(spawnteam);
  enemyteam = scripts\mp\utility\game::getotherteam(spawnteam)[0];
  _id_DB44AC0D1491F876 = getteamdompoints(enemyteam);
  _id_A57270E5BA6E59A3 = getpreferreddompoints(_id_E02688745E0052C3, _id_DB44AC0D1491F876, spawnteam, enemyteam);
  _id_BA0A9FD614A3F6EE = [];
  _id_BA0A9FD614A3F6EE["preferredDomPoints"] = _id_A57270E5BA6E59A3["preferred"];
  _id_BA0A9FD614A3F6EE["secondaryDomPoints"] = _id_A57270E5BA6E59A3["secondary"];

  if(istrue(level.adjustshipmentspawns)) {
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
  } else if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(spawnteam == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers", undefined, _id_BA0A9FD614A3F6EE);
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders", undefined, _id_BA0A9FD614A3F6EE);
    }
  } else {
    scripts\mp\spawnlogic::activatespawnset("dom");
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, "dom", "dom_fallback", undefined, _id_BA0A9FD614A3F6EE);
  }

  return spawnpoint;
}

getteamdompoints(team) {
  _id_E02688745E0052C3 = [];

  foreach(_id_1183B8D0EE70C22F in level.objectives) {
    if(_id_1183B8D0EE70C22F.ownerteam == team)
      _id_E02688745E0052C3[_id_E02688745E0052C3.size] = _id_1183B8D0EE70C22F;
  }

  return _id_E02688745E0052C3;
}

getpreferreddompoints(_id_E02688745E0052C3, _id_DB44AC0D1491F876, team, enemyteam) {
  _id_ECA8BA29DF25A989 = [];

  if(_id_E02688745E0052C3.size == level.objectives.size) {
    _id_3A37F3AE11A88ED4 = level.bestspawnflag[enemyteam];

    foreach(flag in _id_E02688745E0052C3) {
      if(flag != _id_3A37F3AE11A88ED4)
        _id_ECA8BA29DF25A989[_id_ECA8BA29DF25A989.size] = flag;
    }
  } else if(_id_E02688745E0052C3.size > 0) {
    foreach(flag in _id_E02688745E0052C3)
    _id_ECA8BA29DF25A989[_id_ECA8BA29DF25A989.size] = flag;
  } else if(_id_E02688745E0052C3.size == 0) {
    _id_E4B0A18C08E01FC9 = level.bestspawnflag[team];

    if(_id_DB44AC0D1491F876.size > 0 && _id_DB44AC0D1491F876.size < level.objectives.size)
      _id_E4B0A18C08E01FC9 = _id_6663215F917210AE::getunownedflagneareststart(team);

    _id_ECA8BA29DF25A989[_id_ECA8BA29DF25A989.size] = _id_E4B0A18C08E01FC9;
  }

  _id_255BA911692A2561 = 0;
  _id_D4AFFDBF750D5880 = 0;

  foreach(flag in _id_ECA8BA29DF25A989) {
    if(flag scripts\mp\gameobjects::getclaimteam() == "none") {
      _id_255BA911692A2561 = _id_255BA911692A2561 | flag.spawnflagid;
      continue;
    }

    _id_D4AFFDBF750D5880 = _id_D4AFFDBF750D5880 | flag.spawnflagid;
  }

  if(_id_255BA911692A2561 & 1 && _id_255BA911692A2561 & 2)
    _id_255BA911692A2561 = _id_255BA911692A2561 | 32;

  if(_id_255BA911692A2561 & 4 && _id_255BA911692A2561 & 2)
    _id_255BA911692A2561 = _id_255BA911692A2561 | 64;

  if(_id_255BA911692A2561 & 1 && _id_255BA911692A2561 & 4)
    _id_255BA911692A2561 = _id_255BA911692A2561 | 128;

  _id_A57270E5BA6E59A3 = [];
  _id_A57270E5BA6E59A3["preferred"] = _id_255BA911692A2561;
  _id_A57270E5BA6E59A3["secondary"] = _id_D4AFFDBF750D5880;
  return _id_A57270E5BA6E59A3;
}

domflags() {
  primaryflags = [];
  _id_528742B1628EB47C = [];
  level.changenumdomflags = 0;

  if(level._id_2CF7B819EE66EE8E) {
    _id_C49B98F4ADB52D7B = _id_734EA6311B19A424::getzonearray("hardpoint_zone");

    if(!isDefined(game["strongholdFlagKeys"]) || level._id_80FD35AF3BB73B72 > 0 && game["roundsPlayed"] % level._id_80FD35AF3BB73B72 == 0) {
      _id_3DABCE211C987A42 = _id_C49B98F4ADB52D7B;

      if(isDefined(game["strongholdFlagKeys"])) {
        _id_E1E302C0235F5998 = randomintrange(0, _id_3DABCE211C987A42.size - game["strongholdFlagKeys"].size);

        while(_id_E1E302C0235F5998 > 0) {
          _id_496C6AD9BA0C9C80 = game["strongholdFlagKeys"][randomint(game["strongholdFlagKeys"].size)];
          game["strongholdFlagKeys"] = scripts\engine\utility::array_remove(game["strongholdFlagKeys"], _id_496C6AD9BA0C9C80);

          foreach(_id_32E85ACA9CEC4226 in _id_3DABCE211C987A42) {
            if(_id_32E85ACA9CEC4226.script_label == _id_496C6AD9BA0C9C80) {
              _id_3DABCE211C987A42 = scripts\engine\utility::array_remove(_id_3DABCE211C987A42, _id_32E85ACA9CEC4226);
              _id_E1E302C0235F5998--;
              break;
            }
          }
        }
      }

      _id_2A267AC444BE003E = [];
      _id_15E6D8F207A41389 = scripts\engine\utility::get_array_of_closest(scripts\mp\spawncamera::getstartspawnavg("allies", "mp_dom_spawn_allies_start"), _id_3DABCE211C987A42, undefined, 2);
      _id_496C6AD9BA0C9C80 = _id_15E6D8F207A41389[randomint(_id_15E6D8F207A41389.size)];
      _id_3DABCE211C987A42 = scripts\engine\utility::array_remove(_id_3DABCE211C987A42, _id_496C6AD9BA0C9C80);
      _id_2A267AC444BE003E[0] = _id_496C6AD9BA0C9C80.script_label;
      _id_96CD90A3393629A0 = scripts\engine\utility::get_array_of_closest(scripts\mp\spawncamera::getstartspawnavg("axis", "mp_dom_spawn_axis_start"), _id_3DABCE211C987A42, undefined, 2);
      _id_496C6AD9BA0C9C80 = _id_96CD90A3393629A0[randomint(_id_96CD90A3393629A0.size)];
      _id_3DABCE211C987A42 = scripts\engine\utility::array_remove(_id_3DABCE211C987A42, _id_496C6AD9BA0C9C80);
      _id_2A267AC444BE003E[2] = _id_496C6AD9BA0C9C80.script_label;
      _id_496C6AD9BA0C9C80 = _id_3DABCE211C987A42[randomint(_id_3DABCE211C987A42.size)];
      _id_3DABCE211C987A42 = scripts\engine\utility::array_remove(_id_3DABCE211C987A42, _id_496C6AD9BA0C9C80);
      _id_2A267AC444BE003E[1] = _id_496C6AD9BA0C9C80.script_label;
      game["strongholdFlagKeys"] = _id_2A267AC444BE003E;
    }

    _id_79B9159E31664699 = ["_a", "_b", "_c", "_d", "_e"];
    _id_48D64E8C548BDA41 = 0;
    _id_173231B2F39BCF53 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < game["strongholdFlagKeys"].size; _id_AC0E594AC96AA3A8++) {
      _id_09111499E2F9187D = game["strongholdFlagKeys"][_id_AC0E594AC96AA3A8];

      foreach(zone in _id_C49B98F4ADB52D7B) {
        if(_id_09111499E2F9187D != zone.script_label) {
          continue;
        }
        key = _id_79B9159E31664699[_id_48D64E8C548BDA41];
        zone.script_label = key;
        zone.objectivekey = key;
        _id_173231B2F39BCF53[_id_173231B2F39BCF53.size] = zone;
        _id_48D64E8C548BDA41++;
        break;
      }
    }

    primaryflags = _id_173231B2F39BCF53;
    level.changenumdomflags = getdvarint("scr_dom_flagcount", 3);
  } else {
    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      _id_85E038319FBAFCF9 = getEntArray("flag_primary", "targetname");

      foreach(flag in _id_85E038319FBAFCF9) {
        if(isDefined(flag.script_noteworthy) && flag.script_noteworthy == level.localeid) {
          primaryflags[primaryflags.size] = flag;
          continue;
        }

        flag delete();
      }
    } else {
      level.changenumdomflags = getdvarint("scr_dom_flagcount", 0);
      primaryflags = getEntArray("flag_primary", "targetname");
    }

    _id_528742B1628EB47C = getEntArray("flag_secondary", "targetname");
  }

  if(primaryflags.size + _id_528742B1628EB47C.size < 2) {
    return;
  }
  if(level.changenumdomflags == 3)
    setomnvar("ui_num_dom_flags", level.changenumdomflags);
  else
    setomnvar("ui_num_dom_flags", primaryflags.size);

  triggers = scripts\engine\utility::array_combine(primaryflags, _id_528742B1628EB47C);

  if(level.changenumdomflags == 3 || level.mapname == "mp_rust") {
    foreach(trigger in triggers)
    trigger remapdomtriggerscriptlabel();
  }

  foreach(trigger in triggers) {
    if(!level._id_2CF7B819EE66EE8E && level.changenumdomflags == 3) {
      if(trigger.script_label == "_d" || trigger.script_label == "_e")
        continue;
    }

    modifytriggerlocation(trigger);
    domflag = _id_6663215F917210AE::setupobjective(trigger, undefined, 1, 1);
    level.objectives[domflag.objectivekey] = domflag;
  }

  _id_7FC4B3DB1868930F = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_axis_start");
  _id_99A20728731AC0B0 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_allies_start");
  level.startpos["allies"] = _id_99A20728731AC0B0[0].origin;
  level.startpos["axis"] = _id_7FC4B3DB1868930F[0].origin;
  level.bestspawnflag = [];
  level.bestspawnflag["allies"] = _id_6663215F917210AE::getunownedflagneareststart("allies", undefined);
  level.bestspawnflag["axis"] = _id_6663215F917210AE::getunownedflagneareststart("axis", level.bestspawnflag["allies"]);
  flagsetup();
  thread modifieddefendradiussetup();

  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    iconsize = "icon_medium";
  else
    iconsize = undefined;

  foreach(flag in level.objectives) {
    _id_3C2389BA69E5822B = _id_6663215F917210AE::getreservedobjid(flag.objectivekey);
    flag scripts\mp\gameobjects::requestid(1, 1, _id_3C2389BA69E5822B, undefined, undefined, iconsize);
    flag.onuse = ::dompoint_onuse;
    flag.onbeginuse = _id_6663215F917210AE::dompoint_onusebegin;
    flag.onuseupdate = _id_6663215F917210AE::dompoint_onuseupdate;
    flag.onenduse = _id_6663215F917210AE::dompoint_onuseend;
    flag.oncontested = _id_6663215F917210AE::dompoint_oncontested;
    flag.onuncontested = _id_6663215F917210AE::dompoint_onuncontested;
    flag.onunoccupied = _id_6663215F917210AE::dompoint_onunoccupied;
    flag._id_DBEE3CF9CC42CF08 = _id_6663215F917210AE::_id_3DC46DF97466E4D3;
    flag._id_FF5925101700484B = _id_6663215F917210AE::_id_3DC46DF97466E4D3;
    flag.onpinnedstate = _id_6663215F917210AE::dompoint_onpinnedstate;
    flag.onunpinnedstate = _id_6663215F917210AE::dompoint_onunpinnedstate;
    flag.stompprogressreward = _id_6663215F917210AE::dompoint_stompprogressreward;
    flag scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");
    flag scripts\mp\gameobjects::setvisibleteam("any");
    flag _id_6663215F917210AE::domflag_setneutral();
  }

  if(level.precappoints)
    thread _id_6663215F917210AE::precap();

  if(level.codcasterenabled)
    thread updatetriggerforcodcaster();
}

modifytriggerlocation(trigger) {
  switch (level.mapname) {
    case "mp_piccadilly":
      switch (trigger.script_label) {
        case "_a":
          trigger.origin = (983, 303, 110);
          break;
        case "_b":
          trigger.origin = (-1064, -525, 110);
          break;
        case "_c":
          trigger.origin = (-1605, -2298, 60);
          break;
      }

      break;
  }
}

remapdomtriggerscriptlabel() {
  if(level.mapname == "mp_aniyah" || level.mapname == "mp_aniyah_pm") {
    if(self.script_label == "_e" && !isDefined(self.remappedscriptlabel)) {
      self.script_label = "_c";
      self.remappedscriptlabel = 1;
    } else if(self.script_label == "_c" && !isDefined(self.remappedscriptlabel)) {
      self.script_label = "_e";
      self.remappedscriptlabel = 1;
    }
  } else if(level.mapname == "mp_rust") {
    if(self.script_label == "_a")
      self.script_label = "_b";
    else if(self.script_label == "_b")
      self.script_label = "_a";
  }
}

updatedomscores() {
  level endon("game_ended");
  _id_929A6DF466DC4F22 = undefined;
  _id_AC865A705B3E1162 = undefined;
  level waittill("prematch_done");

  if(!isDefined(level.scoretick))
    level.scoretick = [];

  while(!level.gameended) {
    waittime = 5.0;

    if(level._id_701CE1283B8E2DB7)
      waittime = level._id_CC84EF7F24B8BE32;

    _id_8DD9F2EB8215A139 = scripts\mp\gamelogic::gettimeremaining();

    if(_id_8DD9F2EB8215A139 < 5000 && _id_8DD9F2EB8215A139 > 0)
      waittime = _id_8DD9F2EB8215A139 / 1000;

    wait(waittime);
    scripts\mp\hostmigration::waittillhostmigrationdone();
    domflags = getowneddomflags();

    foreach(_id_F90358454413407F in level.teamnamelist)
    level.scoretick[_id_F90358454413407F] = 0;

    if(domflags.size) {
      for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < domflags.size; _id_AC0E594AC96AA3A8++) {
        domflag = domflags[_id_AC0E594AC96AA3A8];
        _id_C2B268E253C97D27 = gettime() - domflag.capturetime;

        for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 - 1; _id_AC0E5C4AC96AAA41 >= 0 && _id_C2B268E253C97D27 > gettime() - domflags[_id_AC0E5C4AC96AAA41].capturetime; _id_AC0E5C4AC96AAA41--)
          domflags[_id_AC0E5C4AC96AAA41 + 1] = domflags[_id_AC0E5C4AC96AAA41];

        domflags[_id_AC0E5C4AC96AAA41 + 1] = domflag;
      }

      if(level._id_701CE1283B8E2DB7) {
        foreach(team in level.teamnamelist) {
          _id_FEE716687DD29378 = _id_6663215F917210AE::getteamflagcount(team, level._id_701CE1283B8E2DB7);

          if(_id_FEE716687DD29378 == level.objectives.size) {
            level.scoretick[team] = level._id_6000406FB4BD08B7;
            continue;
          }

          if(_id_FEE716687DD29378 >= level.flagsrequiredtoscore)
            level.scoretick[team] = level._id_5AF4925BA79C5958;
        }
      } else {
        foreach(domflag in domflags) {
          team = domflag scripts\mp\gameobjects::getownerteam();
          _id_929A6DF466DC4F22 = getteamscore(team);
          _id_FEE716687DD29378 = _id_6663215F917210AE::getteamflagcount(team);

          if(_id_FEE716687DD29378 >= level.flagsrequiredtoscore) {
            level.scoretick[team] = level.scoretick[team] + level.pointsperflag;

            if(istrue(domflag._id_11D80259A066AB76) && isDefined(level._id_55C7198FF5BDA690))
              level.scoretick[team] = level.scoretick[team] + level._id_55C7198FF5BDA690;
          }
        }
      }
    }

    updatescores();
    checkendgame(domflags.size);
  }
}

updatescores() {
  _id_BC96F305D3D139CF = [];

  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_882B7AD682FF97CE = game["teamScores"][_id_F90358454413407F] + level.scoretick[_id_F90358454413407F];

    if(_id_882B7AD682FF97CE >= level.roundscorelimit)
      _id_BC96F305D3D139CF[_id_BC96F305D3D139CF.size] = _id_F90358454413407F;
  }

  if(_id_BC96F305D3D139CF.size == 1)
    level.scoretick[_id_BC96F305D3D139CF[0]] = level.roundscorelimit - game["teamScores"][_id_BC96F305D3D139CF[0]];

  _id_E80DC2F88D61C61C = scripts\mp\gamescore::calculatewinningteam();

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(level.scoretick[_id_F90358454413407F] > 0)
      scripts\mp\gamescore::giveteamscoreforobjective(_id_F90358454413407F, level.scoretick[_id_F90358454413407F], 1, undefined, 1);
  }

  _id_3397ACF8985DBD01 = scripts\mp\gamescore::calculatewinningteam();

  if(_id_E80DC2F88D61C61C != _id_3397ACF8985DBD01)
    scripts\mp\gamescore::playscorestatusdialog(_id_3397ACF8985DBD01, 1, _id_E80DC2F88D61C61C);
}

checkendgame(_id_BEDC18E1C7DA5FBF) {
  _id_59666E71A5A0A42E = gettime() - level.lastcaptime;

  if(scripts\mp\utility\game::matchmakinggame() && _id_BEDC18E1C7DA5FBF < 2 && _id_59666E71A5A0A42E > 120000) {
    level.forcedend = 1;
    thread scripts\mp\gamelogic::endgame("none", game["end_reason"]["dom_force_end"]);
    return;
  }

  if(level.objectives.size == 3 && level.playholdtwovo && _id_59666E71A5A0A42E > 30000) {
    foreach(_id_F90358454413407F in level.teamnamelist) {
      if(_id_6663215F917210AE::getteamflagcount(_id_F90358454413407F) == 2) {
        otherteam = scripts\mp\utility\game::getotherteam(_id_F90358454413407F)[0];
        scripts\mp\utility\dialog::statusdialog("enemy_captured_2", otherteam);
        scripts\mp\utility\dialog::statusdialog("friendly_captured_2", _id_F90358454413407F);
        level.playholdtwovo = 0;
        break;
      }
    }
  }
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  if(!isPlayer(attacker) || attacker.team == self.team) {
    return;
  }
  if(isDefined(objweapon) && _id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename)) {
    return;
  }
  _id_6663215F917210AE::awardgenericmedals(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00);
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  if(istrue(level.teamscoresonkill[attacker.team]))
    _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
}

getowneddomflags() {
  domflags = [];

  foreach(domflag in level.objectives) {
    if(domflag scripts\mp\gameobjects::getownerteam() != "neutral" && isDefined(domflag.capturetime))
      domflags[domflags.size] = domflag;
  }

  return domflags;
}

getflagteam() {
  return scripts\mp\gameobjects::getownerteam();
}

flagsetup() {
  foreach(domflag in level.objectives)
  domflag.spawnflagid = getflagspawnidforobjectivekey(domflag.objectivekey);

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
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      _id_73EF432F38CED282 = parseflagassignmentstring(spawnpoint.script_noteworthy);

      if(isDefined(_id_73EF432F38CED282))
        return _id_73EF432F38CED282;
    }
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

modifieddefendradiussetup() {
  if(level.mapname == "mp_frontier") {
    foreach(objective in level.objectives) {
      if(objective.objectivekey == "_b")
        objective.trigger.modifieddefendcheck = 1;
    }
  }
}

onspawnplayer(_id_9156B53BCF7CE573) {
  thread updatematchstatushintonspawn();

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    thread _id_26508F2DE04C7A52::_id_F9AE07213A0AF3DE();
}

updatecpm() {
  if(!isDefined(self.cpm)) {
    self.numcaps = 0;
    self.cpm = 0;
  }

  self.numcaps++;

  if(scripts\mp\utility\game::getminutespassed() < 1) {
    return;
  }
  self.cpm = self.numcaps / scripts\mp\utility\game::getminutespassed();
}

getcapxpscale() {
  if(self.cpm < 4)
    return 1;
  else
    return 0.25;
}

onplayerconnect(player) {
  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    player thread _id_26508F2DE04C7A52::_id_8BB13AA2A5D32576(player, "mp_gametype_domination_match_introduction");

  player thread onplayerspawned();
}

onplayerspawned(player) {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned");
    scripts\mp\utility\stats::setextrascore0(0);

    if(isDefined(self.pers["captures"]))
      scripts\mp\utility\stats::setextrascore0(self.pers["captures"]);

    scripts\mp\utility\stats::setextrascore1(0);

    if(isDefined(self.pers["defends"]))
      scripts\mp\utility\stats::setextrascore1(self.pers["defends"]);
  }
}

onflagcapture(_id_3985F515E9F06D2C, label, _id_22282E7D48CA3400, team, _id_8A04AA0E0755E7E3, _id_579DA7B2997DEC60) {
  level.usestartspawns = 0;
  soundalias = undefined;
  otherteam = scripts\mp\utility\game::getotherteam(team)[0];

  if(_id_6663215F917210AE::getteamflagcount(team) == level.objectives.size)
    soundalias = "mp_dom_flag_captured_all";
  else
    soundalias = "mp_dom_flag_captured";

  if(_id_2C3C990BA58FA6F5::_id_D3915632A8C61EB2()) {
    self.visuals[0] playsoundtoteam("iw9_dom_scarecrow_roar", team);
    self.visuals[0] playsoundtoteam("iw9_dom_scarecrow_roar", otherteam);
  }

  thread scripts\mp\utility\print::printandsoundoneveryone(team, otherteam, undefined, undefined, soundalias, "mp_dom_flag_lost", _id_22282E7D48CA3400);
  _id_22282E7D48CA3400 scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(15, 1);

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

  if(istrue(level._id_D0D511BA6517842A))
    _id_D0D511BA6517842A(team);
}

dompoint_onuse(_id_22282E7D48CA3400) {
  _id_6663215F917210AE::dompoint_onuse(_id_22282E7D48CA3400, _id_22282E7D48CA3400.team);

  if(isDefined(level.teamscoresonkill)) {
    foreach(team in level.teamnamelist) {
      _id_FEE716687DD29378 = _id_6663215F917210AE::getteamflagcount(team);
      level.teamscoresonkill[team] = _id_FEE716687DD29378 >= level.numflagsscoreonkill && _id_FEE716687DD29378 >= level.flagsrequiredtoscore;
    }
  }
}

_id_6D0C070C982EDDB4() {
  scripts\mp\codcasterclientmatchdata::_id_0EDBA1EE7C2375A5();
}

updatematchstatushintonspawn() {
  level endon("game_ended");
  scripts\mp\hud_message::_id_F004EF4606B9EFDC("dom_cap_defend");
}

updatetriggerforcodcaster() {
  level endon("game_ended");
  level waittill("prematch_done");

  while(!level.gameended) {
    foreach(player in level.players) {
      mlgpoint = 0;

      foreach(_id_1183B8D0EE70C22F in level.objectives) {
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

_id_D0D511BA6517842A(team) {
  _id_B5B1784D5A1327C7 = team + "_agents";
  _id_3D2E4B298E935C8D = _id_48814951E916AF89::_id_9368FB9261E4CD0A(_id_B5B1784D5A1327C7);
  _id_0644D90DE7685F75 = level._id_72E8A99508B7BE1B - _id_3D2E4B298E935C8D;

  if(_id_0644D90DE7685F75 <= 0) {
    return;
  }
  numagents = getdvarint("dvar_3AC57A7FBBFE5CF8", 1);

  if(numagents > 0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < numagents; _id_AC0E594AC96AA3A8++) {
      type = _id_48814951E916AF89::_id_06D1E55C48E2C12F();
      aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB();
      agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, self.trigger.origin + _id_8271F5B7AC2C25DA(_id_AC0E594AC96AA3A8), (0, 0, 0), "medium", _id_B5B1784D5A1327C7, "domAgents", _id_B5B1784D5A1327C7, team);

      if(isDefined(agent)) {
        agent thread _id_0FD32F08E72B657F::_id_35C195DF2BA46725(agent, team);
        agent thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, self.trigger.origin);

        if(team == "allies") {
          agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF("body_mp_eastern_geist_1_1_lod1", "head_mp_eastern_bale_1_1");
          continue;
        }

        agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF("body_spetsnaz_cqc", "head_spetsnaz_cqc");
      }
    }
  }

  if(getdvarint("dvar_B50A927A2E0E0A5D", 1) == 1) {
    if(self.objectivekey == "_b") {
      _id_40E875A042B82875 = getdvarint("dvar_2C76D4F86FD341DE", 1);

      if(_id_40E875A042B82875 > 0) {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_40E875A042B82875; _id_AC0E594AC96AA3A8++) {
          agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF("enemy_mp_jugg_base", self.trigger.origin, (0, 0, 0), "absolute", _id_B5B1784D5A1327C7, "jugg", _id_B5B1784D5A1327C7, team);

          if(isDefined(agent)) {
            agent thread _id_0FD32F08E72B657F::_id_35C195DF2BA46725(agent, team);
            _id_371B4C2AB5861E62::_id_1828F1E20E52B418(agent);
            agent thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, self.trigger.origin);
          }
        }
      }
    }
  } else {
    _id_40E875A042B82875 = getdvarint("dvar_2C76D4F86FD341DE", 0);

    if(_id_40E875A042B82875 > 0) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_40E875A042B82875; _id_AC0E594AC96AA3A8++) {
        agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF("enemy_mp_jugg_base", self.trigger.origin, (0, 0, 0), "absolute", _id_B5B1784D5A1327C7, "jugg", _id_B5B1784D5A1327C7, team);

        if(isDefined(agent)) {
          agent thread _id_0FD32F08E72B657F::_id_35C195DF2BA46725(agent, team);
          _id_371B4C2AB5861E62::_id_1828F1E20E52B418(agent);
          agent thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, self.trigger.origin);
        }
      }
    }
  }
}

_id_8271F5B7AC2C25DA(_id_62E50AD3144802A8) {
  offset = (0, 0, 0);

  if(_id_62E50AD3144802A8 == 0)
    offset = (32, 0, 0);
  else if(_id_62E50AD3144802A8 == 1)
    offset = (0, 32, 0);
  else if(_id_62E50AD3144802A8 == 2)
    offset = (32, 32, 0);
  else if(_id_62E50AD3144802A8 == 3)
    offset = (-32, 0, 0);

  return offset;
}