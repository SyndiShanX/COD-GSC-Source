/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dd.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  _id_9BBACB179DEA3237[1] = "dd_bombzone";
  _id_9BBACB179DEA3237[2] = "blocker";
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 180);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 3);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::setovertimelimitdvar(180);
  }

  updategametypedvars();
  level.objectivebased = 1;
  level.teambased = 1;
  level.onprecachegametype = ::onprecachegametype;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.ondeadevent = ::ondeadevent;
  level.ontimelimit = ::ontimelimit;
  level.onnormaldeath = ::onnormaldeath;
  level.gamemodemaydropweapon = scripts\mp\utility\game::isplayeroutsideofanybombsite;
  level.resetuiomnvargamemode = _id_0780CA0FF5944FCE::resetuiomnvargamemode;
  level.dd = 1;
  level.bombsplanted = 0;
  level.ddbombmodel = [];
  level.aplanted = 0;
  level.bplanted = 0;
  _id_0780CA0FF5944FCE::setbombtimeromnvars();

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    game["dialog"]["gametype"] = "iw9_mpdd_mode_uktl_ddt1";
  else
    game["dialog"]["gametype"] = "gametype_demo";

  game["dialog"]["gametype"] = "gametype_demo";

  if(getdvarint("scr_diehard"))
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  else if(getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_promode")))
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";

  game["dialog"]["bomb_achieve"] = "bomb_achieve";
  game["dialog"]["bomb_taken"] = "bomb_taken";
  game["dialog"]["bomb_lost"] = "bomb_enemyowns";
  game["dialog"]["bomb_defused"] = "bomb_defused";
  game["dialog"]["bomb_planted"] = "bomb_planted";
  game["dialog"]["enemy_bomb_a"] = "bomb_enemy_a";
  game["dialog"]["enemy_bomb_b"] = "bomb_enemy_b";
  game["dialog"]["enemy_bomb_defused"] = "bomb_enemydefused";
  game["dialog"]["enemy_bomb_planted"] = "bomb_enemyplanted";
  game["dialog"]["bomb_planting"] = "bomb_planting";
  game["dialog"]["bomb_planting_a"] = "bomb_planting_a";
  game["dialog"]["bomb_planting_b"] = "bomb_planting_b";
  game["dialog"]["bomb_destroyed_en"] = "objective_destroyed";

  if(!isDefined(game["roundsPlayed"])) {
    _id_4EDD1486C09DBEDB = "boost_demoattack";
    _id_00576426D0D8B57B = "boost_demodefend";
  } else if(game["roundsPlayed"] == 2) {
    _id_4EDD1486C09DBEDB = "boost_demo_ot";
    _id_00576426D0D8B57B = "boost_demo_ot";
  } else {
    _id_4EDD1486C09DBEDB = "boost_demoattack_short";
    _id_00576426D0D8B57B = "boost_demodefend_short";
  }

  game["dialog"]["offense_obj"] = _id_4EDD1486C09DBEDB;
  game["dialog"]["defense_obj"] = _id_00576426D0D8B57B;
  return isDefined(game["status"]) && game["status"] == "overtime";
  setomnvar("ui_bomb_timer_endtime_a", 0);
  setomnvar("ui_bomb_timer_endtime_b", 0);
  setomnvar("ui_bomb_planted_a", 0);
  setomnvar("ui_bomb_planted_b", 0);
  setomnvar("ui_bomb_interacting", 0);
  level.nosuspensemusic = 1;
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_dd_bombtimer", getmatchrulesdata("bombData", "bombTimer"));
  setdynamicdvar("scr_dd_planttime", getmatchrulesdata("bombData", "plantTime"));
  setdynamicdvar("scr_dd_defusetime", getmatchrulesdata("bombData", "defuseTime"));
  setdynamicdvar("scr_dd_silentplant", getmatchrulesdata("bombData", "silentPlant"));
  setdynamicdvar("scr_dd_extratime", getmatchrulesdata("demData", "extraTime"));
  setdynamicdvar("scr_dd_overtimelimit", getmatchrulesdata("demData", "overtimeLimit"));
  setdynamicdvar("scr_dd_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("dd", 0);
  setdynamicdvar("scr_dd_promode", 0);
}

onprecachegametype() {
  game["bomb_dropped_sound"] = "iw9_mp_ui_objective_lost";
  game["bomb_recovered_sound"] = "iw9_mp_ui_objective_taken";
}

onstartgametype() {
  setomnvar("ui_victory_condition_completed", 0);

  if(game["roundsPlayed"] == 2) {
    game["status"] = "overtime";
    setDvar("ui_overtime", 1);
  }

  if(scripts\mp\utility\game::inovertime()) {
    setomnvar("ui_round_hint_override_attackers", 1);
    setomnvar("ui_round_hint_override_defenders", 1);
  }

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    _id_2B21F2FBE8DD5C6E = game["attackers"];
    _id_8D904E28CF14C8AE = game["defenders"];
    game["attackers"] = _id_8D904E28CF14C8AE;
    game["defenders"] = _id_2B21F2FBE8DD5C6E;
  }

  level.usestartspawns = 1;
  setclientnamemode("manual_change");

  if(scripts\mp\utility\game::inovertime())
    game["dialog"]["defense_obj"] = "obj_destroy";

  level._effect["bomb_explosion"] = loadfx("vfx/iw9/dmz/bombsite/vfx_dmz_bombsite_expl.vfx");
  level._effect["vehicle_explosion"] = loadfx("vfx/core/expl/small_vehicle_explosion_new.vfx");
  level._effect["building_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  scripts\mp\utility\game::setobjectivetext(game["attackers"], &"OBJECTIVES/DD_ATTACKER");
  scripts\mp\utility\game::setobjectivetext(game["defenders"], &"OBJECTIVES/DD_DEFENDER");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext(game["attackers"], &"OBJECTIVES/DD_ATTACKER");
    scripts\mp\utility\game::setobjectivescoretext(game["defenders"], &"OBJECTIVES/DD_DEFENDER");
  } else {
    scripts\mp\utility\game::setobjectivescoretext(game["attackers"], &"OBJECTIVES/DD_ATTACKER_SCORE");
    scripts\mp\utility\game::setobjectivescoretext(game["defenders"], &"OBJECTIVES/DD_DEFENDER_SCORE");
  }

  if(scripts\mp\utility\game::inovertime()) {
    scripts\mp\utility\game::setobjectivehinttext(game["attackers"], &"OBJECTIVES/DD_OVERTIME_HINT");
    scripts\mp\utility\game::setobjectivehinttext(game["defenders"], &"OBJECTIVES/DD_OVERTIME_HINT");
  } else {
    scripts\mp\utility\game::setobjectivehinttext(game["attackers"], &"OBJECTIVES/DD_ATTACKER_HINT");
    scripts\mp\utility\game::setobjectivehinttext(game["defenders"], &"OBJECTIVES/DD_DEFENDER_HINT");
  }

  thread waittoprocess();
  setupobjectiveicons();
  thread bombs();
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dd_spawn_attacker_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dd_spawn_defender_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_dd_spawn_attacker_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_dd_spawn_defender_start");
  attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_dd_spawn_attacker_start");
  _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_dd_spawn_defender_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", _id_2FD93EA689E77097);
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_dd_spawn_defender");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_dd_spawn_defender_a", 1);
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_dd_spawn_defender_b", 1);
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_dd_spawn_attacker");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_dd_spawn_attacker_a", 1);
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_dd_spawn_attacker_b", 1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);

  if(istrue(level.adjustshipmentspawns)) {
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
    _id_3C9C79460E7AEE38 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
    _id_3D83BC62B320D11A = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
    scripts\mp\spawnlogic::registerspawnset("normal", _id_3C9C79460E7AEE38);
    scripts\mp\spawnlogic::registerspawnset("fallback", _id_3D83BC62B320D11A);
    return;
  }

  level.spawn_defenders = scripts\mp\spawnlogic::getspawnpointarray("mp_dd_spawn_defender");
  scripts\mp\spawnlogic::registerspawnset("dd_defenders", level.spawn_defenders);
  level.spawn_defenders_a = scripts\mp\spawnlogic::getspawnpointarray("mp_dd_spawn_defender_a");
  level.spawn_defenders_a = scripts\engine\utility::array_combine(level.spawn_defenders, level.spawn_defenders_a);
  scripts\mp\spawnlogic::registerspawnset("dd_defenders_a", level.spawn_defenders_a);
  level.spawn_defenders_b = scripts\mp\spawnlogic::getspawnpointarray("mp_dd_spawn_defender_b");
  level.spawn_defenders_b = scripts\engine\utility::array_combine(level.spawn_defenders, level.spawn_defenders_b);
  scripts\mp\spawnlogic::registerspawnset("dd_defenders_b", level.spawn_defenders_b);
  level.spawn_defenders_fallback = scripts\engine\utility::array_combine(level.spawn_defenders, level.spawn_defenders_a, level.spawn_defenders_b);
  scripts\mp\spawnlogic::registerspawnset("dd_defenders_fallback", level.spawn_defenders_fallback);
  level.spawn_attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_dd_spawn_attacker");
  scripts\mp\spawnlogic::registerspawnset("dd_attackers", level.spawn_attackers);
  level.spawn_attackers_a = scripts\mp\spawnlogic::getspawnpointarray("mp_dd_spawn_attacker_a");
  level.spawn_attackers_a = scripts\engine\utility::array_combine(level.spawn_attackers, level.spawn_attackers_a);
  scripts\mp\spawnlogic::registerspawnset("dd_attackers_a", level.spawn_attackers_a);
  level.spawn_attackers_b = scripts\mp\spawnlogic::getspawnpointarray("mp_dd_spawn_attacker_b");
  level.spawn_attackers_b = scripts\engine\utility::array_combine(level.spawn_attackers, level.spawn_attackers_b);
  scripts\mp\spawnlogic::registerspawnset("dd_attackers_b", level.spawn_attackers_b);
  level.spawn_attackers_fallback = scripts\engine\utility::array_combine(level.spawn_attackers, level.spawn_attackers_a, level.spawn_attackers_b);
  scripts\mp\spawnlogic::registerspawnset("dd_attackers_fallback", level.spawn_attackers_fallback);
  level.spawn_defenders_start = scripts\mp\spawnlogic::getspawnpointarray("mp_dd_spawn_defender_start");
  level.spawn_attackers_start = scripts\mp\spawnlogic::getspawnpointarray("mp_dd_spawn_attacker_start");
}

getspawnpointdist(spawnpoint, goalpos) {
  dist = getpathdist(spawnpoint.origin, goalpos, 16000);

  if(dist < 0)
    dist = distance(spawnpoint.origin, goalpos);

  return dist;
}

waittoprocess() {
  level endon("game_end");

  for(;;) {
    if(level.ingraceperiod == 0) {
      break;
    }

    waitframe();
  }

  level.usestartspawns = 0;
}

getspawnpoint() {
  spawnteam = self.pers["team"];

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
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
    }
  } else {
    spawnset = undefined;
    fallbackspawnset = undefined;

    if(spawnteam == game["attackers"]) {
      if(scripts\mp\utility\game::inovertime())
        spawnset = "dd_attackers";
      else if(!level.aplanted && !level.bplanted)
        spawnset = "dd_attackers";
      else if(level.aplanted && !level.bplanted)
        spawnset = "dd_attackers_a";
      else if(level.bplanted && !level.aplanted)
        spawnset = "dd_attackers_b";
      else
        spawnset = "dd_attackers";

      fallbackspawnset = "dd_attackers_fallback";
    } else {
      if(scripts\mp\utility\game::inovertime())
        spawnset = "dd_defenders";
      else if(!level.aplanted && !level.bplanted)
        spawnset = "dd_defenders";
      else if(level.aplanted && !level.bplanted)
        spawnset = "dd_defenders_a";
      else if(level.bplanted && !level.aplanted)
        spawnset = "dd_defenders_b";
      else
        spawnset = "dd_defenders";

      fallbackspawnset = "dd_defenders_fallback";
    }

    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, spawnset, fallbackspawnset);
  }

  return spawnpoint;
}

onspawnplayer(_id_9156B53BCF7CE573) {
  _id_887D0C63AD49A9D4 = getbombteam();

  if(scripts\mp\utility\game::inovertime() || self.pers["team"] == _id_887D0C63AD49A9D4) {
    self setclientomnvar("ui_carrying_bomb", 1);
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 1;
  } else {
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 0;
  }

  if(isDefined(self.pers["plants"]))
    scripts\mp\utility\stats::setextrascore0(self.pers["plants"]);
  else
    scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(self.pers["defuses"]))
    scripts\mp\utility\stats::setextrascore1(self.pers["defuses"]);
  else
    scripts\mp\utility\stats::setextrascore1(0);

  level notify("spawned_player");
}

getbombteam() {
  _id_887D0C63AD49A9D4 = game["attackers"];

  if(level.mapname == "mp_euphrates") {
    if(game["switchedsides"])
      _id_887D0C63AD49A9D4 = game["attackers"];
    else
      _id_887D0C63AD49A9D4 = game["defenders"];
  }

  return _id_887D0C63AD49A9D4;
}

hidecarryiconongameend() {
  self endon("disconnect");
  level waittill("game_ended");

  if(isDefined(self.carryicon))
    self.carryicon.alpha = 0;
}

dd_endgame(_id_EC15CE3E7A9D1D86, _id_F0500919D8C387B9) {
  setomnvar("ui_bomb_interacting", 0);
  thread scripts\mp\gamelogic::endgame(_id_EC15CE3E7A9D1D86, _id_F0500919D8C387B9);
}

ondeadevent(team) {
  if(level.bombexploded > 0 || level.bombdefused) {
    return;
  }
  if(team == "all") {
    if(level.bombplanted)
      dd_endgame(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
    else
      dd_endgame(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
  } else if(team == game["attackers"]) {
    if(level.bombplanted) {
      return;
    }
    level thread dd_endgame(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
  } else if(team == game["defenders"])
    level thread dd_endgame(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
  team = victim.team;

  if(victim.isplanting) {
    thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, lifeid, "planting");
    attacker scripts\mp\utility\stats::incpersstat("defends", 1);
    attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
  } else if(victim.isdefusing) {
    thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, lifeid, "defusing");
    attacker scripts\mp\utility\stats::incpersstat("defends", 1);
    attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
  }

  _id_0780CA0FF5944FCE::bombzone_awardgenericbombzonemedals(attacker, victim);
}

ontimelimit() {
  if(scripts\mp\utility\game::inovertime())
    dd_endgame("tie", game["end_reason"]["time_limit_reached"]);
  else
    dd_endgame(game["defenders"], game["end_reason"]["time_limit_reached"]);
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.planttime = scripts\mp\utility\dvars::dvarfloatvalue("planttime", 5, 0, 20);
  level.defusetime = scripts\mp\utility\dvars::dvarfloatvalue("defusetime", 5, 0, 20);
  level.bombtimer = scripts\mp\utility\dvars::dvarintvalue("bombtimer", 45, 1, 300);
  level.ddtimetoadd = scripts\mp\utility\dvars::dvarfloatvalue("extraTime", 120, 0, 500);
  level.overtime = scripts\mp\utility\dvars::dvarfloatvalue("overtimeLimit", 1, 0, 180);
  level.resetprogress = scripts\mp\utility\dvars::dvarintvalue("resetProgress", 1, 0, 1);
  scripts\mp\utility\game::setovertimelimitdvar(level.overtime);
  level.silentplant = scripts\mp\utility\dvars::dvarintvalue("silentPlant", 0, 0, 1);
}

verifybombzones(bombzones) {
  _id_AA19EFF12D6BB163 = "";

  if(bombzones.size != 3) {
    _id_8AB8CDAA16D825EE = 0;
    _id_8AB8CCAA16D823BB = 0;
    _id_8AB8CBAA16D82188 = 0;

    foreach(_id_EEF26A325310D3AF in bombzones) {
      if(issubstr(tolower(_id_EEF26A325310D3AF.script_label), "a")) {
        _id_8AB8CDAA16D825EE = 1;
        continue;
      }

      if(issubstr(tolower(_id_EEF26A325310D3AF.script_label), "b")) {
        _id_8AB8CCAA16D823BB = 1;
        continue;
      }

      if(issubstr(tolower(_id_EEF26A325310D3AF.script_label), "c"))
        _id_8AB8CBAA16D82188 = 1;
    }

    if(!_id_8AB8CDAA16D825EE)
      _id_AA19EFF12D6BB163 = _id_AA19EFF12D6BB163 + " A ";

    if(!_id_8AB8CCAA16D823BB)
      _id_AA19EFF12D6BB163 = _id_AA19EFF12D6BB163 + " B ";

    if(!_id_8AB8CBAA16D82188)
      _id_AA19EFF12D6BB163 = _id_AA19EFF12D6BB163 + " C ";
  }

  if(_id_AA19EFF12D6BB163 != "")
    return;
}

bombs() {
  waittillframeend;
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombexploded = 0;
  level.multibomb = 1;
  triggers = getEntArray("dd_bombzone", "targetname");
  verifybombzones(triggers);
  level.objectives = [];

  foreach(trigger in triggers) {
    _id_EEF26A325310D3AF = _id_0780CA0FF5944FCE::setupobjective(trigger, 1);

    if(isDefined(_id_EEF26A325310D3AF)) {
      _id_EEF26A325310D3AF.onbeginuse = ::onbeginuse;
      _id_EEF26A325310D3AF.onenduse = ::onenduse;
      _id_EEF26A325310D3AF.onuse = ::onuseplantobject;
      level.objectives[_id_EEF26A325310D3AF.objectivekey] = _id_EEF26A325310D3AF;
    }
  }

  initspawns();

  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");

  foreach(_id_EEF26A325310D3AF in level.objectives) {
    _id_EEF26A325310D3AF scripts\mp\gameobjects::requestid(1, 1);

    if(scripts\mp\utility\game::inovertime())
      _id_EEF26A325310D3AF scripts\mp\gameobjects::setobjectivestatusicons("waypoint_target_neutral");
    else
      _id_EEF26A325310D3AF scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");

    _id_EEF26A325310D3AF scripts\mp\gameobjects::setvisibleteam("any");
  }
}

onbeginuse(player) {
  _id_0780CA0FF5944FCE::bombzone_onbeginuse(player);
}

onenduse(team, player, result) {
  _id_0780CA0FF5944FCE::bombzone_onenduse(team, player, result);
}

onuseplantobject(player) {
  _id_4725E52B7C3AA25C = [];
  _id_4725E52B7C3AA25C[_id_4725E52B7C3AA25C.size] = player;
  level thread scripts\mp\hud_message::notifyteam("emp_planted", "emp_planted_enemy", player.team, _id_4725E52B7C3AA25C);
  player thread scripts\mp\hud_message::showsplash("emp_planted", scripts\mp\rank::getscoreinfovalue("stat_FD5E014E1660FC72"));
  _id_0780CA0FF5944FCE::bombzone_onuseplantobject(player);

  if(level.bombexploded == 1)
    thread scripts\mp\music_and_dialog::bombplanted_music();
}

setupkillcament() {
  _id_027BA39CB4DA36C7 = spawn("script_origin", self.origin);
  _id_027BA39CB4DA36C7.angles = self.angles;
  _id_027BA39CB4DA36C7 rotateYaw(-45, 0.05);
  waitframe();
  _id_B44CEFCF38B5DA97 = self.origin + (0, 0, 5);
  _id_DFDBE7C0C9DCA192 = self.origin + anglesToForward(_id_027BA39CB4DA36C7.angles) * 100 + (0, 0, 128);
  result = scripts\engine\trace::ray_trace(_id_B44CEFCF38B5DA97, _id_DFDBE7C0C9DCA192, self, scripts\engine\trace::create_default_contents(1));
  self.killcament = spawn("script_model", result["position"]);
  self.killcament setscriptmoverkillcam("explosive");
  _id_027BA39CB4DA36C7 delete();
}

resetbombzone(player) {
  if(scripts\mp\utility\game::inovertime()) {
    scripts\mp\gameobjects::setownerteam("neutral");
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_target");
  } else {
    scripts\mp\gameobjects::setownerteam(game["defenders"]);
    scripts\mp\gameobjects::allowuse("enemy");
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");
  }

  scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_PLANT_EXPLOSIVES");
  self.id = "bomb_zone";
  scripts\mp\gameobjects::setusetime(level.planttime);
  scripts\mp\gameobjects::setvisibleteam("any");
  self.useweapon = makeweapon("briefcase_bomb_mp");
  self.bombexploded = undefined;
}

setupfordefusing() {
  scripts\mp\gameobjects::allowuse("friendly");
  scripts\mp\gameobjects::setusetime(level.defusetime);
  scripts\mp\gameobjects::setkeyobject(undefined);
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defuse", "waypoint_defend");
  scripts\mp\gameobjects::setvisibleteam("any");
}

oncantuse(player) {
  player iprintlnbold(&"MP/BOMBSITE_IN_USE");
}

onreset() {}

bombplanted(_id_2810BD61A09D19F5, player) {
  _id_2810BD61A09D19F5 endon("defused");
  playerteam = player.team;
  level.bombsplanted = level.bombsplanted + 1;
  scripts\mp\gamelogic::pausetimer();
  level.timepausestart = gettime();
  level.timelimitoverride = 1;
  level.bombplanted = 1;
  level.destroyedobject = _id_2810BD61A09D19F5;

  if(level.destroyedobject.objectivekey == "_a")
    level.aplanted = 1;
  else
    level.bplanted = 1;

  level.destroyedobject.bombplanted = 1;
  level.tickingobject = _id_2810BD61A09D19F5.visuals[0];
  dropbombmodel(player, _id_2810BD61A09D19F5.objectivekey);
  _id_2810BD61A09D19F5.bombdefused = 0;
  _id_2810BD61A09D19F5 scripts\mp\gameobjects::allowuse("none");
  _id_2810BD61A09D19F5 scripts\mp\gameobjects::setvisibleteam("none");

  if(scripts\mp\utility\game::inovertime())
    _id_2810BD61A09D19F5 scripts\mp\gameobjects::setownerteam(scripts\mp\utility\game::getotherteam(player.team)[0]);

  _id_2810BD61A09D19F5 setupfordefusing();
  _id_2810BD61A09D19F5 bombtimerwait(_id_2810BD61A09D19F5);
  _id_2810BD61A09D19F5 thread bombhandler(player, "explode", playerteam);
}

bombhandler(player, _id_68B7E26F25CA1151, playerteam) {
  level.bombsplanted = level.bombsplanted - 1;

  if(self.objectivekey == "_a")
    level.aplanted = 0;
  else
    level.bplanted = 0;

  restarttimer();
  _id_0780CA0FF5944FCE::setbombtimeromnvars();

  if(level.gameended) {
    return;
  }
  if(_id_68B7E26F25CA1151 == "explode") {
    self.bombexploded = 1;
    timelimit = scripts\mp\utility\dvars::getwatcheddvar("timelimit");

    if(timelimit != 0 && !scripts\mp\utility\game::inovertime() && level.bombexploded < 2 && level.ddtimetoadd > 0) {
      level.extratime = level.bombexploded * level.ddtimetoadd;
      _id_8DD9F2EB8215A139 = scripts\mp\gamelogic::gettimeremaining();

      if(istrue(level.timerstoppedforgamemode))
        _id_8DD9F2EB8215A139 = _id_8DD9F2EB8215A139 - level.bombtimer * 1000;

      setgameendtime(gettime() + int(_id_8DD9F2EB8215A139));
    }

    wait 2;

    if(scripts\mp\utility\game::inovertime() || level.bombexploded > 1) {
      if(istrue(level.nukeinfo._id_9DCCABA98B643CAD)) {
        return;
      }
      dd_endgame(playerteam, game["end_reason"]["target_destroyed"]);
      return;
    }

    if(level.ddtimetoadd > 0) {
      scripts\mp\utility\dialog::statusdialog("bomb_destroyed_en", game["defenders"]);
      level thread scripts\mp\hud_message::notifyteam("callout_time_added", "callout_time_added", player.team);
      return;
    }

    return;
  } else {
    player notify("bomb_defused" + self.objectivekey);
    self notify("defused");
    resetbombzone(player);
  }
}

dropbombmodel(player, site) {
  trace = scripts\engine\trace::ray_trace(player.origin + (0, 0, 20), player.origin - (0, 0, 2000), player, scripts\engine\trace::create_default_contents(1));
  _id_9CA1B8FD292FEFFA = randomfloat(360);
  forward = (cos(_id_9CA1B8FD292FEFFA), sin(_id_9CA1B8FD292FEFFA), 0);
  forward = vectorNormalize(forward - trace["normal"] * vectordot(forward, trace["normal"]));
  dropangles = vectortoangles(forward);
  level.ddbombmodel[site] = spawn("script_model", trace["position"]);
  level.ddbombmodel[site].angles = dropangles;
  level.ddbombmodel[site] setModel("prop_suitcase_bomb");
}

restarttimer() {
  if(scripts\mp\utility\game::inovertime()) {
    if(level.bombexploded == 1)
      return;
  } else if(level.bombexploded > 1) {
    return;
  }
  if(level.bombsplanted <= 0) {
    scripts\mp\gamelogic::resumetimer();
    level.timepaused = gettime() - level.timepausestart;
    level.timelimitoverride = 0;
  }
}

bombtimerwait(_id_5AC945A5ED78E00C) {
  level endon("game_ended");
  level endon("bomb_defused" + _id_5AC945A5ED78E00C.objectivekey);

  if(scripts\mp\utility\game::inovertime())
    _id_5AC945A5ED78E00C.waittime = level.bombtimer;
  else
    _id_5AC945A5ED78E00C.waittime = level.bombtimer;

  level thread update_ui_timers(_id_5AC945A5ED78E00C);

  while(_id_5AC945A5ED78E00C.waittime >= 0) {
    _id_5AC945A5ED78E00C.waittime--;

    if(_id_5AC945A5ED78E00C.waittime >= 0)
      wait 1;

    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

update_ui_timers(_id_5AC945A5ED78E00C) {
  level endon("game_ended");
  level endon("disconnect");
  level endon("bomb_defused" + _id_5AC945A5ED78E00C.objectivekey);
  level endon("bomb_exploded" + _id_5AC945A5ED78E00C.objectivekey);
  _id_4DFAA92E2BCE1194 = _id_5AC945A5ED78E00C.waittime * 1000 + gettime();
  setDvar(_func_2EF675C13CA1C4AF("dvar_0B6224AB79B658C2", _id_5AC945A5ED78E00C.objectivekey), _id_4DFAA92E2BCE1194);
  level waittill("host_migration_begin");
  _id_3B5803E733581858 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(_id_3B5803E733581858 > 0)
    setDvar(_func_2EF675C13CA1C4AF("dvar_0B6224AB79B658C2", _id_5AC945A5ED78E00C.objectivekey), _id_4DFAA92E2BCE1194 + _id_3B5803E733581858);
}

bombdefused(_id_530B0CC4B4365BC4) {
  level.tickingobject scripts\mp\gamelogic::stoptickingsound();
  _id_530B0CC4B4365BC4.bombdefused = 1;
  level notify("bomb_defused" + _id_530B0CC4B4365BC4.objectivekey);
}

setupobjectiveicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_target_neutral_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defuse_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defuse_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_b", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_defend_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defuse_nt_a", 0, "enemy", "", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defuse_nt_b", 0, "enemy", "", "icon_waypoint_dom_b", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_defend_nt_a", 0, "friendly", "", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_defend_nt_b", 0, "friendly", "", "icon_waypoint_dom_b", 0);
}