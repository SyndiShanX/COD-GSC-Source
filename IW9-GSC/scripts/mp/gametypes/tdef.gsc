/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\tdef.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  level.defenderflag_starts = [];
  _id_58553518A66CEBE9 = getEntArray("cyber_emp_pickup_trig", "targetname");

  foreach(trig in _id_58553518A66CEBE9)
  level.defenderflag_starts[level.defenderflag_starts.size] = trig.origin;

  level.defenderflag_bflagstart = (0, 0, 0);
  primaryflags = getEntArray("flag_primary", "targetname");

  foreach(flag in primaryflags) {
    if(flag.script_label == "_b") {
      level.defenderflag_bflagstart = flag.origin;
      break;
    }
  }

  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  _id_9BBACB179DEA3237[1] = "tdm";
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 10);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 7500);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    setdynamicdvar("scr_tdef_possessionresetcondition", 1);
    setdynamicdvar("scr_tdef_possessionresettime", 60);
    level.matchrules_enemyflagradar = 1;
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  level.carrierarmor = 100;
  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.onrespawndelay = ::getrespawndelay;
  level.defenderflagreset = 1;
  level.defenderflagbases = [];
  level.scorefrozenuntil = 0;
  level.defenderflagpickupscorefrozen = 0;

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    game["dialog"]["gametype"] = "iw9_tdef_mode_uktl_tdt1";
  else
    game["dialog"]["gametype"] = "gametype_defender";

  game["strings"]["overtime_hint"] = &"MP/FIRST_BLOOD";
  game["bomb_dropped_sound"] = "iw9_mp_ui_objective_lost";
  game["bomb_recovered_sound"] = "iw9_mp_ui_objective_taken";
  game["dialog"]["offense_obj"] = "boost_tdm";
  game["dialog"]["defense_obj"] = "boost_tdm";
  game["dialog"]["flag_dropped"] = "ourblitzflag_drop";
  game["dialog"]["flag_returned"] = "ourflag_return";
  game["dialog"]["flag_getback"] = "ourblitzflag_getback";
  game["dialog"]["enemy_flag_taken"] = "ourblitzflag_taken";
  game["dialog"]["enemy_flag_dropped"] = "enemyblitzflag_drop";
  game["dialog"]["enemy_flag_returned"] = "ourblitzflag_return";
  setomnvar("ui_single_flag_loc", -2);
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("dvar_1CC0D66C46DB96D6", getmatchrulesdata("tdefData", "ppkTeamNoFlag"));
  setdynamicdvar("dvar_1AA7E0F1A1007031", getmatchrulesdata("tdefData", "ppkTeamWithFlag"));
  setdynamicdvar("dvar_C896B59425076B7C", getmatchrulesdata("tdefData", "ppkFlagCarrier"));
  setdynamicdvar("scr_tdef_scoringtime", getmatchrulesdata("tdefData", "scoringTime"));
  setdynamicdvar("scr_tdef_scorepertick", getmatchrulesdata("tdefData", "scorePerTick"));
  setdynamicdvar("scr_tdef_carrierbonustime", getmatchrulesdata("tdefData", "carrierBonusTime"));
  setdynamicdvar("scr_tdef_carrierbonusscore", getmatchrulesdata("tdefData", "carrierBonusScore"));
  setdynamicdvar("scr_tdef_spawndelay", getmatchrulesdata("tdefData", "spawnDelay"));
  setdynamicdvar("dvar_53C09E0944FB50DA", getmatchrulesdata("tdefData", "flagActivationDelay"));
  setdynamicdvar("scr_tdef_possessionresetcondition", getmatchrulesdata("carryData", "possessionResetCondition"));
  setdynamicdvar("scr_tdef_possessionresettime", getmatchrulesdata("carryData", "possessionResetTime"));
  setdynamicdvar("scr_tdef_showenemycarrier", getmatchrulesdata("carryData", "showEnemyCarrier"));
  setdynamicdvar("scr_tdef_idleresettime", getmatchrulesdata("carryData", "idleResetTime"));
  setdynamicdvar("scr_tdef_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("tdef", 0);
  setdynamicdvar("scr_tdef_promode", 0);
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
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/TDEF");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/TDEF");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/TDEF_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/TDEF_ATTACKER_HINT");
  }

  initspawns();
  tdef();
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.ppkteamnoflag = scripts\mp\utility\dvars::dvarintvalue("ppkTeamNoFlag", 50, 0, 250);
  level.ppkteamwithflag = scripts\mp\utility\dvars::dvarintvalue("ppkTeamWithFlag", 100, 0, 250);
  level.ppkflagcarrier = scripts\mp\utility\dvars::dvarintvalue("ppkFlagCarrier", 250, 0, 250);
  level.scoringtime = scripts\mp\utility\dvars::dvarfloatvalue("scoringTime", 1, 1, 10);
  level.scorepertick = scripts\mp\utility\dvars::dvarintvalue("scorePerTick", 1, 1, 25);
  level.carrierbonustime = scripts\mp\utility\dvars::dvarfloatvalue("carrierBonusTime", 4, 0, 10);
  level.carrierbonusscore = scripts\mp\utility\dvars::dvarintvalue("carrierBonusScore", 25, 0, 250);
  level.spawndelay = scripts\mp\utility\dvars::dvarfloatvalue("spawnDelay", 60, 0, 60);
  level.flagactivationdelay = scripts\mp\utility\dvars::dvarfloatvalue("flagActivationDelay", 10, 0, 30);
  level.possessionresetcondition = scripts\mp\utility\dvars::dvarintvalue("possessionResetCondition", 0, 0, 2);
  level.possessionresettime = scripts\mp\utility\dvars::dvarfloatvalue("possessionResetTime", 0, 0, 150);
  level.idleresettime = scripts\mp\utility\dvars::dvarfloatvalue("idleResetTime", 15, 0, 60);
  level.showenemycarrier = scripts\mp\utility\dvars::dvarintvalue("showEnemyCarrier", 5, 0, 6);
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("TDef", "Crit_Frontline");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  _id_3A5288F40C8BE099 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", _id_29D9D2428185616D);
  scripts\mp\spawnlogic::registerspawnset("fallback", _id_3A5288F40C8BE099);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);

  foreach(spawnpoint in level.spawnpoints)
  calculatespawndisttodefenderflagstart(spawnpoint);
}

calculatespawndisttodefenderflagstart(spawnpoint) {
  spawnpoint.scriptdata.distsqtodefenderflagstart = undefined;
  dist = getpathdist(spawnpoint.origin, level.defenderflag_starts[0], 1000);

  if(dist < 0)
    dist = scripts\engine\utility::distance_2d_squared(spawnpoint.origin, level.defenderflag_starts[0]);
  else
    dist = dist * dist;

  spawnpoint.scriptdata.distsqtodefenderflagstart = dist;
}

getspawnpoint() {
  spawnteam = self.pers["team"];

  if(game["switchedsides"])
    spawnteam = scripts\mp\utility\game::getotherteam(spawnteam)[0];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + spawnteam + "_start");
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints);
  } else {
    _id_BA0A9FD614A3F6EE = [];
    _id_BA0A9FD614A3F6EE["defenderFlagPosition"] = level.defenderflag.visuals[0].origin;

    if(isDefined(level.defenderflag.carrier))
      _id_BA0A9FD614A3F6EE["activeCarrierPosition"] = level.defenderflag.carrier.origin;
    else
      _id_BA0A9FD614A3F6EE["activeCarrierPosition"] = _id_BA0A9FD614A3F6EE["defenderFlagPosition"];

    _id_BA0A9FD614A3F6EE["avoidDefenderFlagDeadZoneDistSq"] = 1000000;
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, "normal", "fallback", undefined, _id_BA0A9FD614A3F6EE);
  }

  return spawnpoint;
}

tdef() {
  level.flagmodel["allies"] = "ctf_game_flag_west";
  level.flagbase["allies"] = "ctf_game_flag_base";
  level.carryflag["allies"] = "prop_ctf_game_flag_west";
  level.flagmodel["axis"] = "ctf_game_flag_east";
  level.flagbase["axis"] = "ctf_game_flag_base";
  level.carryflag["axis"] = "prop_ctf_game_flag_east";
  setupwaypointicons();
  level.iconescort = "waypoint_escort_flag";
  level.iconkill = "waypoint_ctf_kill";
  level.iconcaptureflag = "waypoint_take_flag";
  level.icondefendflag = "waypoint_defend_flag";
  level.iconreturnflag = "waypoint_recover_flag";
  level.mlgiconemptyflag = "waypoint_mlg_empty_flag";
  level.mlgiconfullflag = "waypoint_mlg_full_flag";
  level.icontarget = "waypoint_target";
  createflagstart();
}

setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_ctf_kill", 2, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_recover_flag", 0, "neutral", "MP_INGAME_ONLY/OBJ_RECOVER_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_flag", 2, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_take_flag", 0, "neutral", "MP_INGAME_ONLY/OBJ_TAKE_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_mlg_empty_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_empty", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_mlg_full_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_full", 0);
}

createflagstart() {
  level.defenderflag_starts = scripts\engine\utility::array_randomize(level.defenderflag_starts);
  tracestart = level.defenderflag_starts[0] + (0, 0, 64);
  _id_8B39E5984DA1FFAF = level.defenderflag_starts[0] + (0, 0, -64);
  trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, undefined, scripts\engine\trace::create_default_contents(1));
  level.defenderflag_starts[0] = trace["position"];
  level.defenderflag = createteamdefenderflag("allies");
  level thread flaglockedtimer();
}

flaglockedtimer() {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level.defenderflagbase.objectiveicon scripts\mp\gameobjects::setvisibleteam("none");
    level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");
    level.defenderflagbase.objectiveicon scripts\mp\gameobjects::setvisibleteam("any");
  }

  if(level.flagactivationdelay) {
    scripts\mp\flags::gameflagwait("prematch_done");
    level.defenderflagbase.objectiveicon thread scripts\mp\gameobjects::_id_D36DCACAC1708708(level.flagactivationdelay);
    wait(level.flagactivationdelay);
    level.defenderflagbase.objectiveicon scripts\mp\gameobjects::setobjectivestatusallicons(level.iconcaptureflag, level.iconcaptureflag, level.mlgiconfullflag);
    level.defenderflag.trigger scripts\engine\utility::trigger_on();

    foreach(team in level.teamnamelist)
    scripts\mp\utility\dialog::leaderdialog("obj_generic_capture", team);
  }
}

createteamdefenderflag(team) {
  level.pickuptime = 0;
  level.returntime = 0;
  radius = 32;
  trigger = spawn("trigger_radius", level.defenderflag_starts[0], 0, radius, 128);
  visuals = [];
  visuals[0] = spawn("script_model", level.defenderflag_starts[0]);
  visuals[0] setModel(level.flagmodel[team]);
  visuals[0] setasgametypeobjective();
  visuals[0] setteaminhuddatafromteamname(team);
  _id_4E86579DC7E39505 = "neutral";
  _id_3BC2B88A59B6D062 = scripts\mp\gameobjects::createcarryobject(_id_4E86579DC7E39505, trigger, visuals, (0, 0, 85));
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::allowcarry("any");
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setteamusetime("friendly", level.pickuptime);
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setteamusetime("enemy", level.returntime);
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setvisibleteam("none");
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setobjectivestatusallicons(level.iconescort, level.iconkill, level.mlgiconfullflag);
  _id_3BC2B88A59B6D062 scripts\mp\objidpoolmanager::objective_set_play_intro(_id_3BC2B88A59B6D062.objidnum, 0);
  _id_3BC2B88A59B6D062 scripts\mp\objidpoolmanager::objective_set_play_outro(_id_3BC2B88A59B6D062.objidnum, 0);
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::registercarryobjectpickupcheck(::flagpickupchecks);
  _id_3BC2B88A59B6D062.allowweapons = 1;
  _id_3BC2B88A59B6D062.onpickup = ::onpickup;
  _id_3BC2B88A59B6D062.onpickupfailed = ::onpickup;
  _id_3BC2B88A59B6D062.ondrop = ::ondrop;
  _id_3BC2B88A59B6D062.onreset = ::onreset;

  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 60.0;
        break;
      case 1:
        _id_3BC2B88A59B6D062.objidpingfriendly = 0;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 0.05;
        break;
      case 2:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 1.0;
        break;
      case 3:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 1.5;
        break;
      case 4:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 2.0;
        break;
      case 5:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 3.0;
        break;
      case 6:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 4.0;
        break;
    }

    _id_220BE32C83520117 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
    _id_3BC2B88A59B6D062.pingobjidnum = _id_220BE32C83520117;
    scripts\mp\objidpoolmanager::objective_add_objective(_id_220BE32C83520117, "done", _id_3BC2B88A59B6D062.origin);
    scripts\mp\objidpoolmanager::objective_set_play_intro(_id_220BE32C83520117, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(_id_220BE32C83520117, 0);
    _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setvisibleteam("none", _id_220BE32C83520117);
    objective_setownerteam(_id_220BE32C83520117, team);
    _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setobjectivestatusallicons(level.iconescort, level.iconkill, level.mlgiconfullflag, _id_220BE32C83520117);
  } else {
    _id_3BC2B88A59B6D062.objidpingfriendly = 1;
    _id_3BC2B88A59B6D062.objidpingenemy = 0;
    _id_3BC2B88A59B6D062.objpingdelay = 3.0;
  }

  level.defenderflagbase = createteamdefenderflagbase(team, _id_3BC2B88A59B6D062);
  return _id_3BC2B88A59B6D062;
}

flagpickupchecks(player) {
  return !player scripts\cp_mp\utility\player_utility::isinvehicle();
}

createteamdefenderflagbase(team, _id_3BC2B88A59B6D062) {
  _id_D9CA1813B9DE5E20 = _id_3BC2B88A59B6D062.visuals[0].origin;
  _id_0FD8B4C619F5E9FF = spawn("script_model", _id_D9CA1813B9DE5E20);
  _id_0FD8B4C619F5E9FF setModel(level.flagbase[team]);
  _id_0FD8B4C619F5E9FF.ownerteam = "neutral";
  _id_0FD8B4C619F5E9FF setasgametypeobjective();
  _id_0FD8B4C619F5E9FF setteaminhuddatafromteamname(team);
  _id_0FD8B4C619F5E9FF.objectiveicon = scripts\mp\gameobjects::createobjidobject(_id_D9CA1813B9DE5E20, "neutral", (0, 0, 85), undefined, "any", 0);
  _id_0FD8B4C619F5E9FF.objectiveicon scripts\mp\gameobjects::setvisibleteam("any");

  if(level.flagactivationdelay) {
    _id_3BC2B88A59B6D062.trigger scripts\engine\utility::trigger_off();
    _id_0FD8B4C619F5E9FF.objectiveicon scripts\mp\gameobjects::setobjectivestatusallicons(level.icontarget, level.icontarget, level.mlgiconfullflag);
  } else
    _id_0FD8B4C619F5E9FF.objectiveicon scripts\mp\gameobjects::setobjectivestatusallicons(level.iconcaptureflag, level.iconcaptureflag, level.mlgiconfullflag);

  return _id_0FD8B4C619F5E9FF;
}

setteaminhuddatafromteamname(_id_FABF84450735DD93) {
  if(_id_FABF84450735DD93 == "axis")
    self setteaminhuddata(1);
  else if(_id_FABF84450735DD93 == "allies")
    self setteaminhuddata(2);
  else
    self setteaminhuddata(0);
}

onpickup(player, _id_5760E0F038D1BAA3, defused) {
  self notify("picked_up");
  player notify("obj_picked_up");
  level.defenderflagbase.objectiveicon scripts\mp\gameobjects::setvisibleteam("none");
  level.defenderflag.currentcarrier = player;
  player thread awardobjtimeforcarrier();

  if(level.scorepertick > 0)
    level.defenderflag thread awardcapturepoints(player.team);
  else
    player thread flagattachradar();

  ownerteam = scripts\mp\gameobjects::getownerteam();
  scripts\mp\gameobjects::setownerteam(player.team);
  team = player.pers["team"];

  if(team == "allies")
    otherteam = "axis";
  else
    otherteam = "allies";

  player attachflag();
  player scripts\mp\utility\stats::incpersstat("pickups", 1);

  if(self.ownerteam == "allies")
    setomnvar("ui_single_flag_loc", player getentitynumber());
  else
    setomnvar("ui_single_flag_loc", player getentitynumber());

  player setclientomnvar("ui_flag_player_hud_icon", 1);

  if(isDefined(level.showenemycarrier)) {
    if(level.showenemycarrier == 0)
      scripts\mp\gameobjects::setvisibleteam("none");
    else {
      scripts\mp\gameobjects::setvisibleteam("friendly");
      objective_state(self.pingobjidnum, "current");
      scripts\mp\gameobjects::updatecompassicon("enemy", self.pingobjidnum);
      objective_icon(self.pingobjidnum, "icon_waypoint_kill");
      objective_setbackground(self.pingobjidnum, 2);
      scripts\mp\objidpoolmanager::objective_hide_for_mlg_spectator(self.pingobjidnum, 1);
      scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(self.pingobjidnum, "MP_INGAME_ONLY/OBJ_DEFEND_CAPS");
      scripts\mp\objidpoolmanager::update_objective_setenemylabel(self.pingobjidnum, "MP_INGAME_ONLY/OBJ_KILL_CAPS");
      objective_setownerteam(self.pingobjidnum, team);
    }
  }

  scripts\mp\gameobjects::setobjectivestatusallicons(level.iconescort, level.iconkill, level.mlgiconfullflag);
  scripts\mp\utility\print::printandsoundoneveryone(team, otherteam, undefined, undefined, "mp_obj_taken", "mp_enemy_obj_taken", player);

  if(!level.gameended) {
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_taken", team);
    scripts\mp\utility\dialog::leaderdialog("flag_getback", otherteam);
  }

  thread scripts\mp\hud_util::teamplayercardsplash("callout_flagpickup", player);
  player thread scripts\mp\hud_message::showsplash("flagpickup");

  if(!isDefined(self.previouscarrier) || self.previouscarrier != player)
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_91372813B1BCAF92");

  _id_7E2C53B0BCF117D9 = spawnStruct();
  _id_7E2C53B0BCF117D9.player = player;
  _id_7E2C53B0BCF117D9.eventname = "pickup";
  _id_7E2C53B0BCF117D9.position = player.origin;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
  self.previouscarrier = player;

  if(level.codcasterenabled)
    player setgametypevip(1);
}

returnflag() {
  scripts\mp\gameobjects::returnhome();
}

ondrop(player) {
  if(isDefined(player.leaving_team)) {
    self.droppedteam = player.leaving_team;
    player.leaving_team = undefined;
  } else if(!isDefined(player))
    self.droppedteam = self.ownerteam;
  else
    self.droppedteam = player.team;

  level.defenderflag.currentcarrier = undefined;

  if(isDefined(player))
    player updatematchstatushintonnoflag();

  scripts\mp\gameobjects::setownerteam("neutral");
  team = self.droppedteam;
  otherteam = scripts\mp\utility\game::getotherteam(self.droppedteam)[0];
  scripts\mp\gameobjects::allowcarry("any");
  scripts\mp\gameobjects::setvisibleteam("any");
  objective_state(self.pingobjidnum, "done");

  if(level.returntime >= 0)
    scripts\mp\gameobjects::setobjectivestatusallicons(level.iconreturnflag, level.iconreturnflag, level.mlgiconfullflag);
  else {
    scripts\mp\gameobjects::setobjectivestatusallicons(level.iconreturnflag, level.iconreturnflag, level.mlgiconfullflag);
    scripts\mp\objidpoolmanager::objective_hide_for_mlg_spectator(self.objidnum, 1);
  }

  if(self.ownerteam == "allies")
    setomnvar("ui_single_flag_loc", -1);
  else
    setomnvar("ui_single_flag_loc", -1);

  if(isDefined(player))
    player setclientomnvar("ui_flag_player_hud_icon", 0);

  if(isDefined(player)) {
    if(!scripts\mp\utility\player::isreallyalive(player))
      player.carryobject.previouscarrier = undefined;

    if(isDefined(player.carryflag))
      player detachflag();

    scripts\mp\utility\print::printandsoundoneveryone(otherteam, "none", undefined, undefined, "iw9_mp_ui_objective_lost", "", player);

    if(level.codcasterenabled)
      player setgametypevip(0);
  } else
    scripts\mp\utility\sound::playsoundonplayers("iw9_mp_ui_objective_lost", otherteam);

  if(!level.gameended) {
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_dropped", scripts\mp\utility\game::getotherteam(self.droppedteam)[0], "status");
    scripts\mp\utility\dialog::leaderdialog("flag_dropped", self.droppedteam, "status");
  }

  if(level.spawndelay > 5)
    thread forcespawnplayers();

  if(level.idleresettime > 0)
    thread returnaftertime();
}

returnaftertime() {
  self endon("picked_up");
  _id_8E53D4CA3DE8531A = 0.0;

  while(_id_8E53D4CA3DE8531A < level.idleresettime) {
    waitframe();

    if(self.claimteam == "none")
      _id_8E53D4CA3DE8531A = _id_8E53D4CA3DE8531A + level.framedurationseconds;
  }

  foreach(team in level.teamnamelist)
  scripts\mp\utility\sound::playsoundonplayers("iw9_mp_ui_objective_lost", team);

  scripts\mp\gameobjects::returnhome();
}

onreset() {
  level.defenderflag.currentcarrier = undefined;

  if(isDefined(level.defenderflag.portable_radar)) {
    level.defenderflag.portable_radar clearportableradar();
    level.defenderflag.portable_radar delete();
  }

  if(isDefined(self.droppedteam))
    scripts\mp\gameobjects::setownerteam(self.droppedteam);

  team = scripts\mp\gameobjects::getownerteam();
  otherteam = scripts\mp\utility\game::getotherteam(team)[0];
  scripts\mp\gameobjects::allowcarry("any");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconescort, level.iconkill);
  level.defenderflagbase.objectiveicon scripts\mp\gameobjects::setvisibleteam("any");

  if(!level.gameended) {
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_returned", scripts\mp\utility\game::getotherteam(self.droppedteam)[0], "status");
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_returned", self.droppedteam, "status");
  }

  self.droppedteam = undefined;

  if(self.ownerteam == "allies")
    setomnvar("ui_single_flag_loc", -2);
  else
    setomnvar("ui_single_flag_loc", -2);

  self.previouscarrier = undefined;
}

attachflag() {
  updatematchstatushintonhasflag();
  otherteam = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];
  self attach(level.carryflag[otherteam], "tag_stowed_back3", 1);
  self.carryflag = level.carryflag[otherteam];
}

detachflag() {
  self detach(self.carryflag, "tag_stowed_back3");
  self.carryflag = undefined;
}

updatematchstatushintonnoflag() {
  scripts\mp\hud_message::_id_F004EF4606B9EFDC("single_flag_cap");
}

updatematchstatushintonhasflag() {
  scripts\mp\hud_message::_id_F004EF4606B9EFDC("single_flag_cap");
}

awardobjtimeforcarrier(team) {
  level endon("game_ended");
  level.defenderflag endon("dropped");
  level.defenderflag endon("reset");
  level notify("objTimePointsRunning");
  level endon("objTimePointsRunning");

  while(!level.gameended) {
    wait 1;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!level.gameended) {
      level.defenderflag.carrier scripts\mp\utility\stats::incpersstat("objTime", 1);
      level.defenderflag.carrier scripts\mp\persistence::statsetchild("round", "objTime", level.defenderflag.carrier.pers["objTime"]);
      level.defenderflag.carrier scripts\mp\utility\stats::setextrascore0(level.defenderflag.carrier.pers["objTime"]);
      level.defenderflag.carrier scripts\mp\gamescore::giveplayerscore("stat_98BFD8D29C56BC08", 10);
    }
  }
}

flagattachradar(_id_C3C023E794344066) {
  level endon("game_ended");
  level.defenderflag endon("dropped");
  level.defenderflag endon("reset");
  level notify("portableRadarRunning");
  level endon("portableRadarRunning");

  if(isDefined(level.defenderflag.portable_radar)) {
    level.defenderflag.portable_radar clearportableradar();
    level.defenderflag.portable_radar delete();
  }

  if(!isDefined(_id_C3C023E794344066))
    _id_C3C023E794344066 = self.team;

  _id_D9E51CC670E30892 = getflagradarowner(_id_C3C023E794344066);
  portable_radar = spawn("script_model", level.defenderflag.visuals[0].origin);
  portable_radar.team = scripts\mp\utility\game::getotherteam(_id_C3C023E794344066)[0];
  portable_radar.owner = _id_D9E51CC670E30892;
  portable_radar makeportableradar(_id_D9E51CC670E30892);
  level.defenderflag.portable_radar = portable_radar;
  level.defenderflag thread flagradarmover();
  level.defenderflag thread flagwatchradarownerlost();
}

getflagradarowner(team) {
  level endon("game_ended");
  self endon("dropped");
  level endon("portableRadarRunning");
  _id_347499D973E25860 = 0;

  for(;;) {
    if(level.teamswithplayers.size == 1 && game["state"] == "playing")
      _id_347499D973E25860 = 1;
    else {
      if(_id_347499D973E25860)
        wait 15;

      otherteam = scripts\mp\utility\game::getotherteam(team)[0];
      _id_347499D973E25860 = 0;

      foreach(player in level.players) {
        if(isalive(player) && player.pers["team"] == otherteam)
          return player;
      }
    }

    wait 0.05;
  }
}

flagradarmover() {
  level endon("game_ended");
  self endon("dropped");
  self.portable_radar endon("death");
  level endon("portableRadarRunning");

  for(;;) {
    self.portable_radar moveTo(self.currentcarrier.origin, 0.05);
    wait 0.05;
  }
}

flagwatchradarownerlost() {
  level endon("game_ended");
  self endon("dropped");
  _id_C3C023E794344066 = self.portable_radar.team;
  _id_C3C023E794344066 = scripts\mp\utility\game::getotherteam(_id_C3C023E794344066)[0];
  self.portable_radar.owner scripts\engine\utility::waittill_any_3("disconnect", "joined_team", "joined_spectators");
  self.portable_radar clearportableradar();
  self.portable_radar = undefined;
  flagattachradar(_id_C3C023E794344066);
}

getrespawndelay() {
  ownerteam = level.defenderflag scripts\mp\gameobjects::getownerteam();

  if(isDefined(ownerteam)) {
    if(self.pers["team"] == ownerteam) {
      if(!isDefined(level.spawndelay) || level.spawndelay <= 0)
        return undefined;

      if(istrue(self._id_F5EAA6F4ACF15628))
        return 0;

      return level.spawndelay;
    }
  }
}

forcespawnplayers() {
  players = level.players;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    player = players[_id_AC0E594AC96AA3A8];

    if(!isDefined(player) || istrue(player.fauxdead) && player scripts\mp\utility\player::isusingremote() || isalive(player) && !istrue(player.fauxdead)) {
      continue;
    }
    player notify("force_spawn");
    waitframe();
  }
}

onplayerconnect(player) {
  thread onplayerspawned(player);
}

onplayerspawned(player) {
  for(;;) {
    player waittill("spawned");
    player._id_F5EAA6F4ACF15628 = undefined;
    player setclientomnvar("ui_flag_player_hud_icon", 0);
    player scripts\mp\utility\stats::setextrascore0(0);

    if(isDefined(player.pers["objTime"]))
      player scripts\mp\utility\stats::setextrascore0(player.pers["objTime"]);

    player scripts\mp\utility\stats::setextrascore1(0);

    if(isDefined(player.pers["defends"]))
      player scripts\mp\utility\stats::setextrascore1(player.pers["defends"]);
  }
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  if(!isPlayer(attacker) || attacker == self) {
    if(isDefined(self.carryflag)) {
      detachflag();
      self._id_F5EAA6F4ACF15628 = 1;
    }

    return;
  }

  score = level.ppkteamnoflag;

  if(isDefined(level.defenderflag) && level.defenderflag scripts\mp\gameobjects::getownerteam() == attacker.pers["team"]) {
    if(isDefined(level.defenderflag.carrier) && attacker != level.defenderflag.carrier) {
      level.defenderflag.carrier thread scripts\mp\rank::scoreeventpopup("stat_AF3B99DA11B23E7F");
      points = scripts\mp\rank::getscoreinfovalue("stat_AF3B99DA11B23E7F");
      scripts\mp\gamescore::giveplayerscore("stat_AF3B99DA11B23E7F", points, self);
      level.defenderflag.carrier thread scripts\mp\rank::giverankxp("stat_AF3B99DA11B23E7F", points);
      attacker thread scripts\mp\rank::scoreeventpopup("stat_764E78BD2752D4B5");
      points = scripts\mp\rank::getscoreinfovalue("stat_764E78BD2752D4B5");
      scripts\mp\gamescore::giveplayerscore("stat_764E78BD2752D4B5", points, self);
      attacker thread scripts\mp\rank::giverankxp("stat_764E78BD2752D4B5", points);
    }

    score = level.ppkteamwithflag;
  } else if(isDefined(self.carryflag))
    score = level.ppkflagcarrier;

  attacker scripts\mp\gamescore::giveteamscoreforobjective(attacker.pers["team"], score);
  _id_AEC2E5E01F424119 = 0;
  _id_86C1C8628B1D55F8 = attacker.origin;
  attackerisinflictor = 0;

  if(isDefined(einflictor)) {
    _id_86C1C8628B1D55F8 = einflictor.origin;
    attackerisinflictor = einflictor == attacker;
  }

  if(isDefined(attacker) && isPlayer(attacker) && attacker.pers["team"] != self.pers["team"]) {
    if(isDefined(attacker.carryflag) && attackerisinflictor) {
      attacker thread scripts\mp\rank::scoreeventpopup("stat_EBCC9C019C3B6818");
      attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_F735B92839C5A687");
      _id_AEC2E5E01F424119 = 1;
    }

    if(isDefined(self.carryflag)) {
      attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5311F153A7FEE40C");
      attacker scripts\mp\utility\stats::incpersstat("carrierKills", 1);
      attacker thread scripts\mp\hud_message::showsplash("killed_carrier");
      attacker scripts\mp\utility\stats::incpersstat("defends", 1);
      attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
      thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, _id_61B5D0250B328F00, "carrying");
      _id_548072087C9FD504::_id_7D42D3F8DD68280C(20, attacker.team, attacker getentitynumber());
      _id_AEC2E5E01F424119 = 1;
    }

    if(!_id_AEC2E5E01F424119) {
      _id_3CD1AF2851F12AB5 = 0;
      _id_C3F9FED5999C974E = 0;
      _id_D4D1706F5BCA5ABD = distsquaredcheck(_id_86C1C8628B1D55F8, self.origin, level.defenderflag.curorigin);

      if(_id_D4D1706F5BCA5ABD) {
        if(level.defenderflag.ownerteam == self.team)
          _id_3CD1AF2851F12AB5 = 1;
        else
          _id_C3F9FED5999C974E = 1;
      }

      if(_id_3CD1AF2851F12AB5) {
        attacker thread scripts\mp\rank::scoreeventpopup("stat_E54C7B357A5A826C");
        attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5A3B180273BE47B1");
        thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, _id_61B5D0250B328F00, "defending");
        attacker scripts\mp\utility\stats::incpersstat("assaults", 1);
      } else if(_id_C3F9FED5999C974E) {
        attacker thread scripts\mp\rank::scoreeventpopup("stat_6FF0E80C570DACA1");
        attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2D96CED878338CD2");
        attacker scripts\mp\utility\stats::incpersstat("defends", 1);
        attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
        thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, _id_61B5D0250B328F00, "assaulting");
      }
    }
  }

  if(isDefined(self.carryflag)) {
    detachflag();
    self._id_F5EAA6F4ACF15628 = 1;
  }
}

distsquaredcheck(_id_86C1C8628B1D55F8, _id_F7DED1FDB02A123D, _id_76227CD0036993E3) {
  _id_AAE76E7732B9A9DA = distancesquared(_id_76227CD0036993E3, _id_86C1C8628B1D55F8);
  _id_3D29A24F32F790B1 = distancesquared(_id_76227CD0036993E3, _id_F7DED1FDB02A123D);

  if(_id_AAE76E7732B9A9DA < 90000 || _id_3D29A24F32F790B1 < 90000)
    return 1;
  else
    return 0;
}

carriergivescore() {
  level endon("game_ended");
  self endon("death");
  level.defenderflag endon("dropped");
  level.defenderflag endon("reset");

  for(;;)
    wait(level.carrierbonustime);
}

awardcapturepoints(team) {
  level endon("game_ended");
  level.defenderflag endon("dropped");
  level.defenderflag endon("reset");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");

  if(level.carrierbonusscore > 0)
    level.defenderflag.carrier thread carriergivescore();

  _id_CC748B6D457627FE = level.scoringtime;
  score = level.scorepertick;

  while(!level.gameended) {
    wait(_id_CC748B6D457627FE);
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!level.gameended) {
      scripts\mp\gamescore::giveteamscoreforobjective(team, score, 0);
      level.defenderflag.carrier scripts\mp\utility\stats::incpersstat("objTime", 1);
      level.defenderflag.carrier scripts\mp\persistence::statsetchild("round", "objTime", level.defenderflag.carrier.pers["objTime"]);
      level.defenderflag.carrier scripts\mp\utility\stats::setextrascore0(level.defenderflag.carrier.pers["objTime"]);
      level.defenderflag.carrier scripts\mp\gamescore::giveplayerscore("stat_98BFD8D29C56BC08", 10);
    }
  }
}

_id_3B12569EBD75DE5B() {
  level._id_F076141742A52169 = level.possessionresettime;
  level._id_BC53C4BEA6CD9A8F = 1;
  level._id_19D29CCA063754A2 = 0;

  if(isDefined(level.possessionresetcondition) && level.possessionresetcondition != 0) {
    return;
  }
  return;
}

createhudelems() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  updatetimers("neutral", 1, 1);
}

updatetimers(ownerteam, _id_365C174C8C9B9ACE, _id_229E69D7CA087FCB, _id_A1B8B95D5E8DE27A) {
  if(!istrue(level.possessionresetcondition)) {
    return;
  }
  _id_38A6B48A5F70C0B8 = undefined;
  _id_48F1DBF87DD99400 = 1000 * level.possessionresettime;

  if(istrue(_id_229E69D7CA087FCB)) {
    if(istrue(level.flagactivationdelay) && !istrue(level.defenderflagreset))
      _id_48F1DBF87DD99400 = 1000 * level.flagactivationdelay;
  }

  if(istrue(_id_229E69D7CA087FCB) || istrue(_id_A1B8B95D5E8DE27A)) {
    level._id_F076141742A52169 = level.possessionresettime;
    level._id_9D87EA6F4E249074 = int(gettime() + _id_48F1DBF87DD99400);
  } else
    level._id_9D87EA6F4E249074 = int(gettime() + 1000 * level._id_F076141742A52169);

  setomnvar("ui_hardpoint_timer", level._id_9D87EA6F4E249074);

  if(_id_48F1DBF87DD99400 > 0 && (istrue(_id_A1B8B95D5E8DE27A) || !_id_365C174C8C9B9ACE && level._id_BC53C4BEA6CD9A8F))
    level.defenderflag thread _id_D363CC9811CD5042(ownerteam, _id_38A6B48A5F70C0B8);

  if(_id_365C174C8C9B9ACE)
    level _id_AA07CCCBF564C5D1();
}

_id_D363CC9811CD5042(ownerteam, _id_38A6B48A5F70C0B8) {
  level endon("game_ended");
  level endon("reset");
  level endon("pause_defenderFlag_timer");
  level notify("defenderFlagRunTimer");
  level endon("defenderFlagRunTimer");
  level._id_BC53C4BEA6CD9A8F = 0;
  _id_1A73C412BBDD19AC(ownerteam, _id_38A6B48A5F70C0B8);
}

_id_1A73C412BBDD19AC(ownerteam, _id_38A6B48A5F70C0B8) {
  level endon("game_ended");
  level endon("pause_defenderFlag_timer");
  _id_FF049FF4093F7A4E = scripts\engine\utility::ter_op(isDefined(_id_38A6B48A5F70C0B8), _id_38A6B48A5F70C0B8, int(level._id_F076141742A52169 * 1000 + gettime()));
  level _id_D06F48B387FF75BC(_id_38A6B48A5F70C0B8);
  thread watchtimerpause();
  level thread handlehostmigration(_id_FF049FF4093F7A4E);
  _id_797AA8AED455DC96(level._id_F076141742A52169);
}

_id_797AA8AED455DC96(duration) {
  level endon("game_ended");
  level endon("pause_defenderFlag_timer");

  if(duration == 0) {
    return;
  }
  starttime = gettime();
  endtime = gettime() + duration * 1000;

  while(gettime() < endtime) {
    _id_4F70F01F97007F69((endtime - gettime()) / 1000);

    while(isDefined(level.hostmigrationtimer)) {
      endtime = endtime + 1000;
      setgameendtime(int(endtime));
      wait 1;
    }
  }

  while(isDefined(level.hostmigrationtimer)) {
    endtime = endtime + 1000;
    setgameendtime(int(endtime));
    wait 1;
  }

  return gettime() - starttime;
}

_id_4F70F01F97007F69(duration) {
  level endon("game_ended");
  level endon("pause_defenderFlag_timer");

  if(isDefined(level.hostmigrationtimer)) {
    return;
  }
  level endon("host_migration_begin");
  wait(duration);
}

handlehostmigration(_id_FF049FF4093F7A4E) {
  level endon("game_ended");
  level endon("disconnect");
  level waittill("host_migration_begin");
  setomnvar("ui_objective_timer_stopped", 1);
  _id_3B5803E733581858 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(!level._id_19D29CCA063754A2)
    setomnvar("ui_objective_timer_stopped", 0);

  if(_id_3B5803E733581858 > 0)
    setomnvar("ui_hardpoint_timer", level._id_9D87EA6F4E249074 + _id_3B5803E733581858);
  else
    setomnvar("ui_hardpoint_timer", level._id_9D87EA6F4E249074);
}

watchtimerpause() {
  level endon("game_ended");
  level notify("watchResetSoon");
  level endon("watchResetSoon");
  _id_2526E18A7C1CB9EE = 0;

  for(_id_7C2F34F22D3F69F7 = undefined; level._id_F076141742A52169 > 0 && !level._id_BC53C4BEA6CD9A8F; level._id_F076141742A52169 = level._id_F076141742A52169 - _id_CE254178F5785581) {
    currenttime = gettime();

    if(!_id_2526E18A7C1CB9EE && level._id_F076141742A52169 < 10) {
      foreach(_id_F90358454413407F in level.teamnamelist) {}

      _id_2526E18A7C1CB9EE = 1;
    }

    if(isDefined(level.defenderflag.carrier) && level._id_F076141742A52169 < 5) {
      if(!isDefined(_id_7C2F34F22D3F69F7) || currenttime > _id_7C2F34F22D3F69F7 + 1000)
        _id_7C2F34F22D3F69F7 = currenttime;
    }

    _id_CE254178F5785581 = 0.05;
    wait(_id_CE254178F5785581);
  }

  if(level._id_BC53C4BEA6CD9A8F)
    level notify("pause_defenderFlag_timer");
}

_id_EE738AB8EC64BDE3(_id_38A6B48A5F70C0B8) {
  _id_94A402AC046FD810 = level._id_BC53C4BEA6CD9A8F || isDefined(level.hostmigrationtimer);

  if(!scripts\mp\flags::gameflag("prematch_done"))
    _id_94A402AC046FD810 = 0;

  if(!level._id_19D29CCA063754A2 && _id_94A402AC046FD810) {
    level._id_19D29CCA063754A2 = 1;
    setomnvar("ui_objective_timer_stopped", 1);
  } else if(level._id_19D29CCA063754A2 && !_id_94A402AC046FD810) {
    level._id_19D29CCA063754A2 = 0;
    setomnvar("ui_objective_timer_stopped", 0);
  }
}

_id_AA07CCCBF564C5D1() {
  level._id_BC53C4BEA6CD9A8F = 1;
  _id_EE738AB8EC64BDE3();
}

_id_D06F48B387FF75BC(_id_38A6B48A5F70C0B8) {
  level._id_BC53C4BEA6CD9A8F = 0;
  _id_EE738AB8EC64BDE3(_id_38A6B48A5F70C0B8);
}