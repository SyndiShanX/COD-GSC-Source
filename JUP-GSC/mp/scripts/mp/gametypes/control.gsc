/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\control.gsc
***********************************************/

#using script_548072087c9fd504;
#using scripts\common\utility;
#using scripts\cp_mp\gestures;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\damage;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\hq;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\music_and_dialog;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\playerlogic;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\print;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#namespace control;

function main() {
  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  allowed[0] = getgametype();

  if(scripts\cp_mp\utility\game_utility::function_21322da268e71c19()) {
    allowed[0] = scripts\mp\utility\game::getbasegametype();
  }

  if(scripts\cp_mp\utility\game_utility::function_eb455c18ac9d8ac5() || level.leagueplaymatch) {
    allowed[0] = scripts\mp\utility\game::getbasegametype();
  }

  scripts\mp\gameobjects::main(allowed);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread reinitializematchrulesonmigration();
  } else {
    registertimelimitdvar(getgametype(), 90);
    registerscorelimitdvar(getgametype(), 200);
    registerroundlimitdvar(getgametype(), 0);
    registerroundswitchdvar(getgametype(), 1, 0, 1);
    registerwinlimitdvar(getgametype(), 3);
    registernumlivesdvar(getgametype(), 1);
    registerhalftimedvar(getgametype(), 0);
  }

  update_gametype_dvars();
  level.updatealiveomnvars = &function_99a2435bdaa61d08;
  level.onstartgametype = &control_onstartgametype;
  level.onplayerconnect = &control_onplayerconnect;
  level.onplayerdisconnect = &control_onplayerdisconnect;
  level.getspawnpoint = &control_getspawnpoint;
  level.onplayerkilled = &control_onplayerkilled;
  level.ononeleftevent = &control_ononeleftevent;
  level.modeonspawnplayer = &control_onspawnplayer;
  level.disablespawningforplayerfunc = &function_d9c3e51ec6bc88be;
  level.onobjectivecomplete = &function_6dc36e4dd3018346;
  level.ontimelimit = &control_ontimelimit;
  level.onmaprestart = &function_63a77191349871bf;
  level.gamemodegesturecalloutassign = &function_e5b3b788aa8a4401;
  level.gamemodegesturecalloutverify = &function_d234db657e8b7dc5;
  level.playholdtwovo = 0;
  level.objectivebased = 1;
  level.teambased = 1;
  level.disablebuddyspawn = 1;
  level.lastcaptime = gettime();
  level.nosuspensemusic = 1;
  level.var_46c429e667d32f63 = 1;

  if(isDefined(level.numflagsscoreonkill) && level.numflagsscoreonkill > 0) {
    level.teamscoresonkill = [];
    level.onnormaldeath = &onnormaldeath;
    setdynamicdvar(hashcat(@ "hash_845664fda53dd4bd"), 1);
  }

  initdialog();
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  setdynamicdvar(function_3514ae5d09f47ed2("flagCaptureTime"), getmatchrulesdata("domData", "flagCaptureTime"));
  setdynamicdvar(function_3514ae5d09f47ed2("flagsRequiredToScore"), getmatchrulesdata("domData", "flagsRequiredToScore"));
  setdynamicdvar(function_3514ae5d09f47ed2("pointsPerFlag"), getmatchrulesdata("domData", "pointsPerFlag"));
  setdynamicdvar(function_3514ae5d09f47ed2("flagNeutralization"), getmatchrulesdata("domData", "flagNeutralization"));
  setdynamicdvar(function_3514ae5d09f47ed2("numFlagsScoreOnKill"), getmatchrulesdata("domData", "numFlagsScoreOnKill"));
  setdynamicdvar(function_3514ae5d09f47ed2("objScalar"), getmatchrulesdata("domData", "objScalar"));
  setdynamicdvar(function_3514ae5d09f47ed2("preCapPoints"), getmatchrulesdata("siegeData", "preCapPoints"));
  setdynamicdvar(function_3514ae5d09f47ed2("captureType"), getmatchrulesdata("captureData", "captureType"));
  setdynamicdvar(function_3514ae5d09f47ed2("captureDecay"), getmatchrulesdata("captureData", "captureDecay"));
  setdynamicdvar(function_3514ae5d09f47ed2("disableMajorityCapProgress"), getmatchrulesdata("controlData", "disableMajorityCapProgress"));
  setdynamicdvar(function_3514ae5d09f47ed2("useSegments"), getmatchrulesdata("controlData", "useSegments"));
  setdynamicdvar(function_3514ae5d09f47ed2("suicideTeamKillLowersLives"), getmatchrulesdata("controlData", "suicideTeamKillLowersLives"));
  setdynamicdvar(function_3514ae5d09f47ed2("captureExtraTime"), getmatchrulesdata("controlData", "captureExtraTime"));
  setdynamicdvar(function_3514ae5d09f47ed2("pauseTime"), getmatchrulesdata("kothData", "pauseTime"));
  setdynamicdvar(function_3514ae5d09f47ed2("numTeamLives"), getmatchrulesdata("controlData", "numTeamLives"));
  setdynamicdvar(function_3514ae5d09f47ed2("overtimeDefenders"), getmatchrulesdata("controlData", "overtimeDefenders"));
  setdynamicdvar(function_3514ae5d09f47ed2("segmentCaptureExtraTime"), getmatchrulesdata("controlData", "segmentCaptureExtraTime"));
  setdynamicdvar(function_3514ae5d09f47ed2("numCaptureSegments"), getmatchrulesdata("controlData", "numCaptureSegments"));
  setdynamicdvar(@ "hash_b45b3f9cb0508339", 0);
  registerhalftimedvar(getgametype(), 0);
}

function initdialog() {
  if(scripts\cp_mp\utility\game_utility::function_21322da268e71c19()) {
    game["dialog"]["gametype"] = "dx_mp_ctrl_game_t141_cthc";
  } else {
    game["dialog"]["gametype"] = "dx_mp_ctrl_game_uktl_name";
  }

  game["dialog"]["offense_obj"] = "dx_mp_ctrl_game_uktl_cboa";
  game["dialog"]["defense_obj"] = "dx_mp_ctrl_game_uktl_cbod";
  game["dialog"]["securing_a"] = "dx_mp_ctrl_game_uktl_ctka";
  game["dialog"]["securing_b"] = "dx_mp_ctrl_game_uktl_ctkb";
  game["dialog"]["securing_c"] = "dx_mp_ctrl_game_uktl_ctkc";
  game["dialog"]["secured_a"] = "dx_mp_ctrl_game_uktl_ctat";
  game["dialog"]["secured_b"] = "dx_mp_ctrl_game_uktl_ctbt";
  game["dialog"]["secured_c"] = "dx_mp_ctrl_game_uktl_ctct";
  game["dialog"]["attack_last_flag"] = "dx_mp_ctrl_game_uktl_ctad";
  game["dialog"]["contest_attacker_a"] = "dx_mp_ctrl_game_uktl_ctaa";
  game["dialog"]["contest_defender_a"] = "dx_mp_ctrl_game_uktl_ctda";
  game["dialog"]["contest_attacker_b"] = "dx_mp_ctrl_game_uktl_ctab";
  game["dialog"]["contest_defender_b"] = "dx_mp_ctrl_game_uktl_ctdb";
  game["dialog"]["contest_attacker_c"] = "dx_mp_ctrl_game_uktl_ctac";
  game["dialog"]["contest_defender_c"] = "dx_mp_ctrl_game_uktl_ctdc";
  game["dialog"]["contest_attacker_all"] = "dx_mp_ctrl_game_uktl_cfca";
  game["dialog"]["contest_defender_all"] = "dx_mp_ctrl_game_uktl_ceca";
  game["dialog"]["losing_a"] = "dx_mp_ctrl_game_uktl_clsa";
  game["dialog"]["losing_b"] = "dx_mp_ctrl_game_uktl_clsb";
  game["dialog"]["losing_c"] = "dx_mp_ctrl_game_uktl_clsc";
  game["dialog"]["lost_a"] = "dx_mp_ctrl_game_uktl_ctal";
  game["dialog"]["lost_b"] = "dx_mp_ctrl_game_uktl_ctbl";
  game["dialog"]["lost_c"] = "dx_mp_ctrl_game_uktl_ctcl";
  game["dialog"]["defend_last_flag"] = "dx_mp_ctrl_game_uktl_cead";
  game["dialog"]["team_low_lives"] = "dx_mp_ctrl_game_uktl_cfll";
  game["dialog"]["enemy_low_lives"] = "dx_mp_ctrl_game_uktl_cell";
  game["dialog"]["team_no_lives"] = "dx_mp_ctrl_game_uktl_cfnl";
  game["dialog"]["enemy_no_lives"] = "dx_mp_ctrl_game_uktl_cenl";
  game["dialog"]["gamestate_domwinning"] = "dx_mp_ctrl_game_uktl_ctfd";
}

function function_69f9599fc4c0f82e() {
  level.iconneutral = "waypoint_captureneutral";
  level.iconcapture = "waypoint_capture";
  level.icondefend = "waypoint_defend";
  level.icondefending = "waypoint_defending";
  level.iconcontested = "waypoint_contested";
  level.icontaking = "waypoint_taking";
  level.iconlosing = "waypoint_losing";
}

function control_onstartgametype() {
  attacking_team = game["attackers"];
  defending_team = game["defenders"];
  level.teamdata[attacking_team]["livesCount"] = level.numteamlives;
  level.teamdata[defending_team]["livesCount"] = level.numteamlives;
  level.teamdata[attacking_team]["controlUILivesCount"] = level.teamdata[attacking_team]["livesCount"];
  level.teamdata[defending_team]["controlUILivesCount"] = level.teamdata[defending_team]["livesCount"];
  function_69f9599fc4c0f82e();

  foreach(entry in level.teamnamelist) {
    if(isDefined(level.teamscoresonkill)) {
      level.teamscoresonkill[entry] = level.precappoints >= level.numflagsscoreonkill && level.precappoints >= level.flagsrequiredtoscore;
    }

    if(entry == attacking_team) {
      setobjectivetext(entry, &"OBJECTIVES/CONTROL_ATTACKER");
    } else {
      setobjectivetext(entry, &"OBJECTIVES/CONTROL_DEFENDER");
    }

    if(level.splitscreen) {
      setobjectivescoretext(entry, &"OBJECTIVES/CONTROL");
    } else {
      setobjectivescoretext(entry, &"OBJECTIVES/CONTROL_SCORE");
    }

    if(entry == attacking_team) {
      setobjectivehinttext(entry, &"OBJECTIVES/CONTROL_ATTACKER_HINT");
      continue;
    }

    setobjectivehinttext(entry, &"OBJECTIVES/CONTROL_DEFENDER_HINT");
  }

  setclientnamemode("auto_change");

  if(!isDefined(game["match_kills"])) {
    game["match_kills"][defending_team] = 0;
    game["match_kills"][attacking_team] = 0;
  }

  if(!isDefined(game["segment_captures"])) {
    game["segment_captures"][defending_team] = 0;
    game["segment_captures"][attacking_team] = 0;
    function_216b35ca5806ec6(0, defending_team);
    function_216b35ca5806ec6(0, attacking_team);
  }

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(level.overtimedefenders != 0 && game["roundsWon"][defending_team] == level.winlimit - 1 && game["roundsWon"][attacking_team] == level.winlimit - 1) {
    bestteam = ter_op(game["axis_defending"], "axis", "allies");

    if(bestteam == game["attackers"]) {
      game["attackers"] = defending_team;
      game["defenders"] = attacking_team;
    }
  } else if(game["switchedsides"]) {
    game["attackers"] = defending_team;
    game["defenders"] = attacking_team;
  }

  level init_spawns();

  thread function_95b0959344794f91();
  thread removedompoint();
  thread placedompoint();

  scripts\mp\gametypes\bradley_spawner::inittankspawns();
  level.var_a18fa3de81feff0a = 0;
  level.var_a18fa0de81fef871 = 0;
  level.teamdata[attacking_team]["uncountedDeaths"] = 0;
  level.teamdata[defending_team]["uncountedDeaths"] = 0;

  if(level.scoremod["kill"] > 0) {
    game["dialog"]["offense_obj"] = "boost_groundwar";
    game["dialog"]["defense_obj"] = "boost_groundwar";
  }

  thread function_212d9bd663252af4();
  thread setup_control_zones();
}

function function_212d9bd663252af4() {
  if(!gameflag("prematch_done")) {
    level waittill("prematch_done");
  }

  level function_56c428ee980a8464();
}

function update_gametype_dvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.flagcapturetime = dvarfloatvalue("flagCaptureTime", 60, 0, 120);
  level.captureextratime = dvarfloatvalue("captureExtraTime", 60, 30, 300);
  level.disablemajoritycapprogress = dvarintvalue("disableMajorityCapProgress", 1, 0, 1);
  level.objectivescaler = dvarfloatvalue("objScalar", 4, 1, 10);
  level.suicideteamkilllowerslives = dvarintvalue("suicideTeamKillLowersLives", 0, 0, 1);
  level.numteamlives = dvarintvalue("numTeamLives", 30, 0, 100);
  level.overtimedefenders = dvarintvalue("overtimeDefenders", 2, 0, 2);
  level.pausetimer = dvarintvalue("pauseTime", 1, 0, 1);
  level.usesegments = dvarintvalue("useSegments", 1, 0, 1);
  level.flagsrequiredtoscore = dvarintvalue("flagsRequiredToScore", 2, 1, 3);
  level.pointsperflag = dvarintvalue("pointsPerFlag", 1, 1, 300);
  level.flagneutralization = dvarintvalue("flagNeutralization", 0, 0, 1);
  level.precappoints = dvarintvalue("preCapPoints", 1, 0, 1);
  level.capturedecay = dvarintvalue("captureDecay", 1, 0, 1);
  level.capturetype = dvarintvalue("captureType", 1, 0, 3);
  level.numflagsscoreonkill = dvarintvalue("numFlagsScoreOnKill", 2, 0, 3);
  level.capturesegments = dvarintvalue("numCaptureSegments", 3, 0, 5);
  level.segmentcaptureextratime = dvarfloatvalue("segmentCaptureExtraTime", 10, 0, 60);
  level.capturesegments = 3;
}

function init_spawns() {
  if(spawnlogic::function_bff229a11ecd1e34()) {
    spawnlogic::setactivespawnlogic(#"default");
  } else if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    spawnlogic::setactivespawnlogic("BigTDM", "Crit_Default");
  } else {
    spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  }

  level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
  level.spawnmaxs = (-2147483647, -2147483647, -2147483647);
  spawnkey = "control";

  if(spawnlogic::function_b17bf43316b9fb08(spawnkey, "attacker")) {
    initspawnlists(spawnkey, "attacker", "defender", "start_attacker", "start_defender", "fallback_attacker", "fallback_defender");
  } else {
    attackers_start = spawnlogic::getspawnpointarray("mp_control_spawn_attacker_start");

    if(attackers_start.size > 0) {
      spawnlogic::addstartspawnpoints("mp_control_spawn_attacker_start", 0, "allies");
      spawnlogic::addspawnpoints("allies", "mp_control_spawn_attacker_start");
    }

    spawnlogic::registerspawnset("start_attackers", attackers_start);
    defenders_start = spawnlogic::getspawnpointarray("mp_control_spawn_defender_start");

    if(defenders_start.size > 0) {
      spawnlogic::addstartspawnpoints("mp_control_spawn_defender_start", 0, "axis");
      spawnlogic::addspawnpoints("axis", "mp_control_spawn_defender_start");
    }

    spawnlogic::registerspawnset("start_defenders", defenders_start);
    attackers = spawnlogic::getspawnpointarray("mp_control_spawn_attacker");
    spawnlogic::addspawnpoints("allies", "mp_control_spawn_attacker", 1);
    spawnlogic::registerspawnset("primary_attackers", attackers);
    defenders = spawnlogic::getspawnpointarray("mp_control_spawn_defender");
    spawnlogic::addspawnpoints("axis", "mp_control_spawn_defender", 1);
    spawnlogic::registerspawnset("primary_defenders", defenders);
    attackers_secondary = spawnlogic::getspawnpointarray("mp_control_spawn_attacker_secondary");
    spawnlogic::addspawnpoints("allies", "mp_control_spawn_attacker_secondary", 1, 1);
    spawnlogic::registerspawnset("fallback_attackers", attackers_secondary);
    defenders_secondary = spawnlogic::getspawnpointarray("mp_control_spawn_defender_secondary");
    spawnlogic::addspawnpoints("axis", "mp_control_spawn_defender_secondary", 1, 1);
    spawnlogic::registerspawnset("fallback_defenders", defenders_secondary);
  }

  spawnlogic::function_437beaf209334ce2();
  level.mapcenter = spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function control_getspawnpoint() {
  return spawnlogic::getspawnpointforplayer(self);
}

function setup_control_zones() {
  primaryzones = [];

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    var_e4748ddc114e50b9 = getEntArray("control_zone", "targetname");

    foreach(zone in var_e4748ddc114e50b9) {
      if(isDefined(zone.script_noteworthy) && zone.script_noteworthy == level.localeid) {
        primaryzones[primaryzones.size] = zone;
        continue;
      }

      if(isDefined(zone.target)) {
        primaryzones[primaryzones.size] = zone;
        continue;
      }

      assertmsg("<dev string:x1c>");
      zone delete();
    }
  } else {
    var_e4748ddc114e50b9 = getEntArray("control_zone", "targetname");

    foreach(zone in var_e4748ddc114e50b9) {
      primaryzones[primaryzones.size] = zone;
    }
  }

  if(primaryzones.size != 2) {
    assertmsg("<dev string:x5e>");
    return;
  }

  setomnvar("ui_num_dom_flags", primaryzones.size);
  triggers = [];

  for(index = 0; index < primaryzones.size; index++) {
    triggers[triggers.size] = primaryzones[index];
  }

  foreach(trigger in triggers) {
    control_zone = function_d5ddc77707c5c50e(trigger, game["defenders"], 1, 0);
    control_zone thread function_275f384d96766b39(trigger.target, trigger.script_label);
    level.objectives[control_zone.objectivekey] = control_zone;
  }

  spawn_attackers_start = spawnlogic::getspawnpointarray("mp_control_spawn_attacker_start");
  spawn_defenders_start = spawnlogic::getspawnpointarray("mp_control_spawn_defender_start");

  if(isDefined(spawn_attackers_start) && isDefined(spawn_attackers_start[0])) {
    level.startpos["allies"] = spawn_attackers_start[0].origin;
  } else {
    level.startpos["allies"] = level.startspawnavg["allies"];
  }

  if(isDefined(spawn_defenders_start) && isDefined(spawn_defenders_start[0])) {
    level.startpos["axis"] = spawn_defenders_start[0].origin;
  } else {
    level.startpos["axis"] = level.startspawnavg["axis"];
  }

  level.bestspawnflag = [];
  level.bestspawnflag["allies"] = scripts\mp\gametypes\obj_dom::getunownedflagneareststart("allies", undefined);
  level.bestspawnflag["axis"] = scripts\mp\gametypes\obj_dom::getunownedflagneareststart("axis", level.bestspawnflag["allies"]);

  if(istrue(level.codcasterenabled)) {
    thread updatetriggerforcodcaster();
  }

  flagsetup();

  foreach(control_zone in level.objectives) {
    control_zone scripts\mp\gametypes\obj_dom::setflagcaptured(game["defenders"], "neutral", undefined, 1);
  }
}

function function_d5ddc77707c5c50e(trigger, team, var_5ddbc1faed2c56e6, skipobjid, showoncompass) {
  var_88e6e0bc0479fa98 = trigger.origin;
  var_2efb87a1b8512118 = 1;
  var_c4c04a7d9915671a = getEntArray("control_flagui", "script_noteworthy");

  foreach(point in var_c4c04a7d9915671a) {
    if(is_equal(point.script_linkname, trigger.script_linkname)) {
      var_88e6e0bc0479fa98 = point.origin;
      var_2efb87a1b8512118 = 0;
      point delete();
    }
  }

  tracestart = var_88e6e0bc0479fa98 + (0, 0, 64);
  traceend = var_88e6e0bc0479fa98 + (0, 0, -64);
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  ignoreents = [];
  trace = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, contentoverride);

  if(var_2efb87a1b8512118) {
    var_88e6e0bc0479fa98 = trace["position"] + (0, 0, 72);
  }

  visuals = [];
  visuals[0] = spawn("script_model", var_88e6e0bc0479fa98);
  visuals[0].angles = (0, 0, 0);

  if(!isDefined(level.flagcapturetime)) {
    level.flagcapturetime = dvarfloatvalue(@ "flagcapturetime", 60, 0, 60);
  }

  if(!isDefined(level.var_e42a415ae1c75964)) {
    level.flagcapturetimemin = dvarfloatvalue("flagCaptureTimeMin", 0, 0, 30);
  }

  if(!isDefined(level.var_fb607d7bf823f6f9)) {
    level.var_fb607d7bf823f6f9 = level.flagcapturetime * 0.5;
  }

  if(isDefined(trigger.objectivekey)) {
    objectivekey = trigger.objectivekey;
  } else {
    objectivekey = trigger.script_label;
  }

  if(isDefined(trigger.iconname)) {
    iconname = trigger.iconname;
  } else {
    iconname = trigger.script_label;
  }

  if(istrue(var_5ddbc1faed2c56e6)) {
    reservedobjid = scripts\mp\gametypes\obj_dom::getreservedobjid(objectivekey);
  } else {
    reservedobjid = undefined;
  }

  if(!isDefined(team)) {
    team = "neutral";
  }

  control_zone = scripts\mp\gameobjects::createuseobject(team, trigger, visuals, var_88e6e0bc0479fa98 - trigger.origin, reservedobjid, skipobjid, showoncompass);
  control_zone scripts\mp\gameobjects::cancontestclaim(1);
  control_zone scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  control_zone scripts\mp\gameobjects::allowuse("any");

  if(isDefined(level.capturetype)) {
    control_zone scripts\mp\gameobjects::setcapturebehavior(scripts\mp\gametypes\obj_dom::getcapturetype());
  }

  control_zone.objectivekey = objectivekey;
  control_zone.iconname = iconname;
  control_zone.var_fb60f3aec3a62f06 = 1;

  if(!istrue(skipobjid)) {
    control_zone scripts\mp\gameobjects::setvisibleteam("any");
    control_zone.onuse = &control_onuse;
    control_zone.onbeginuse = &control_onbeginuse;
    control_zone.onuseupdate = &scripts\mp\gametypes\obj_dom::dompoint_onuseupdate;
    control_zone.onenduse = &control_onenduse;
    control_zone.oncontested = &control_oncontested;
    control_zone.onuncontested = &control_onuncontested;
    control_zone.onunoccupied = &control_onunoccupied;
    control_zone.onpinnedstate = &function_131f0413c52bbf59;
    control_zone.onunpinnedstate = &function_d0dc8fa9d7252f74;
    control_zone.stompprogressreward = &scripts\mp\gametypes\obj_dom::dompoint_stompprogressreward;
    control_zone.var_916e4c007c6b8ba1 = &function_90ee8e359d6d3323;
    objective_setminimapiconsize(control_zone.objidnum, "icon_medium");
  }

  control_zone.nousebar = 1;
  control_zone.id = "domFlag";
  control_zone.claimgracetime = level.flagcapturetime * 1000;
  control_zone.firstcapture = 0;
  control_zone scripts\mp\gameobjects::pinobjiconontriggertouch();
  offset = scripts\mp\gametypes\obj_dom::checkmapoffsets(control_zone);
  control_zone.baseeffectpos = trace["position"] + offset;
  upangles = vectortoangles(trace["normal"]);
  modifiedupangles = scripts\mp\gametypes\obj_dom::checkmapfxangles(control_zone, upangles);
  control_zone.baseeffectforward = anglesToForward(modifiedupangles);
  control_zone.vfxnamemod = "";
  control_zone.noscriptable = 1;
  control_zone scripts\mp\gametypes\obj_dom::initializematchrecording();
  return control_zone;
}

function control_onuse(credit_player, team) {
  scripts\mp\gametypes\obj_dom::dompoint_onuse(credit_player, team);

  if(isDefined(level.teamscoresonkill)) {
    foreach(team in level.teamnamelist) {
      var_fee716687dd29378 = scripts\mp\gametypes\obj_dom::getteamflagcount(team);
      level.teamscoresonkill[team] = var_fee716687dd29378 >= level.numflagsscoreonkill && var_fee716687dd29378 >= level.flagsrequiredtoscore;
    }
  }
}

function control_onbeginuse(player) {
  if(level.pausetimer && self.ownerteam != player.team && !istrue(self.var_25317b559796e5d1)) {
    self.var_25317b559796e5d1 = 1;
    scripts\mp\gamelogic::pausetimer();
  }

  scripts\mp\gametypes\obj_dom::dompoint_onusebegin(player);
  function_223fb185e0afb231();

  if(self.numtouching[player.team] < 2 && self.mostnumtouchingteam == player.team) {
    if(self.allowcapture == 1) {
      self.trigger playsoundtoteam("mp_jup_control_capturing_positive", player.team);
      self.trigger playsoundtoteam("mp_jup_control_capturing_negative", self.prevownerteam);
    }
  }
}

function control_onenduse(team, player, success) {
  scripts\mp\gametypes\obj_dom::dompoint_onuseend(team, player, success);

  if(success) {
    thread function_726259d42f88361("off");
    return;
  }

  function_223fb185e0afb231();
}

function control_oncontested() {
  if(level.pausetimer) {
    self.var_25317b559796e5d1 = 1;
    scripts\mp\gamelogic::pausetimer();
  }

  scripts\mp\gametypes\obj_dom::dompoint_oncontested();
  function_223fb185e0afb231();
  defender = scripts\mp\gameobjects::getownerteam();
  attackers = getotherteam(defender);

  if(isDefined(self.objectivekey)) {
    level.objectives[self.objectivekey].contested = 1;
  }

  var_512dca16e9559524 = 0;

  foreach(zone in level.objectives) {
    if(istrue(zone.contested)) {
      var_512dca16e9559524++;
    }
  }

  if(var_512dca16e9559524 == 0) {
    return;
  }

  if(level.objectives.size > 1 && var_512dca16e9559524 == level.objectives.size) {
    scripts\mp\utility\dialog::statusdialog("contest_defender_all", defender);

    foreach(enemyteam in attackers) {
      scripts\mp\utility\dialog::statusdialog("contest_attacker_all", enemyteam);
    }

    return;
  }

  scripts\mp\utility\dialog::statusdialog("contest_defender" + self.objectivekey, defender);

  foreach(enemyteam in attackers) {
    scripts\mp\utility\dialog::statusdialog("contest_attacker" + self.objectivekey, enemyteam);
  }
}

function control_onuncontested(lastclaimteam) {
  if(self.ownerteam == lastclaimteam) {
    self.var_25317b559796e5d1 = 0;

    if(!function_fcb83cd8b5b5098(self)) {
      scripts\mp\gamelogic::resumetimer();
    }
  }

  scripts\mp\gametypes\obj_dom::dompoint_onuncontested(lastclaimteam);
  delaythread(0.05, &function_223fb185e0afb231);

  if(isDefined(self.objectivekey)) {
    level.objectives[self.objectivekey].contested = 0;
  }

  scripts\mp\objidpoolmanager::update_objective_sethot(self.objidnum, 0);
}

function control_onunoccupied() {
  self.var_25317b559796e5d1 = 0;

  if(!function_fcb83cd8b5b5098(self) && (!isDefined(level.var_d659494e95bd9496) || !level.var_d659494e95bd9496)) {
    scripts\mp\gamelogic::resumetimer();
  }

  scripts\mp\gametypes\obj_dom::dompoint_onunoccupied();
  function_223fb185e0afb231();

  if(scripts\mp\flags::gameflag("prematch_done")) {
    playsoundatpos(self.trigger.origin, "jup_shared_zone_neutral_ping");
  }
}

function function_131f0413c52bbf59(player) {
  scripts\mp\gametypes\obj_dom::dompoint_onpinnedstate(player);

  if(self.numtouching[self.ownerteam] && !self.stalemate) {
    if(self.ownerteam == player.team) {
      if(self.numtouching[player.team] < 2 && self.mostnumtouchingteam == player.team) {
        if(self.allowcapture == 1) {
          self.trigger playsoundtoteam("mp_jup_control_defending_positive", self.ownerteam);
          self.trigger playsoundtoteam("mp_jup_control_defending_negative", getotherteam(self.ownerteam)[0]);
        }
      }
    }
  }

  function_223fb185e0afb231();
}

function function_d0dc8fa9d7252f74(player) {
  function_223fb185e0afb231();
}

function function_275f384d96766b39(target, label) {
  wait 1;
  othervisuals = getentitylessscriptablearray(target, "targetname");
  othervisuals = removechevronsfromarray(othervisuals, label);
  othervisuals = postshipmodifychevrons(othervisuals, label);
  chevrons = [];

  foreach(visual in othervisuals) {
    index = chevrons.size;
    chevrons[index] = visual;
    chevrons[index].numchevrons = 1;

    if(isDefined(visual.script_noteworthy)) {
      if(visual.script_noteworthy == "2") {
        chevrons[index].numchevrons = 2;
      } else if(visual.script_noteworthy == "3") {
        chevrons[index].numchevrons = 3;
      } else if(visual.script_noteworthy == "4") {
        chevrons[index].numchevrons = 4;
      }
    }

    if(isDefined(visual.numchevrons)) {
      chevrons[index].numchevrons = visual.numchevrons;
    }
  }

  self.chevrons = chevrons;
  function_726259d42f88361("idle");
}

function removechevronsfromarray(othervisuals, label) {
  var_d23f6234846f86a6 = [];

  switch (level.mapname) {
    case #"hash_dfa04d97b4cc9b44":
      var_d23f6234846f86a6["_a"] = [(-8705.1, 41410.1, 262.553), (-8789.1, 41434.1, 267.825), (-8843.1, 41446.1, 266.31), (-8915.9, 41987.1, 267.008), (-8867.9, 42003.1, 266.841), (-8703.9, 41957.1, 257.841), (-8582.9, 41925.1, 257.841), (-8458.9, 41892.1, 257.841), (-8340.1, 41574.9, 257.841), (-8985.69, 41784.7, 266.233)];
      var_d23f6234846f86a6["_b"] = [(-7198, 43939, 261), (-7440, 43669, 256), (-6924.37, 43159.2, 262.694), (-7237.4, 43784.4, 269.851), (-7209.91, 43870, 267.73), (-7188.96, 43931.1, 265.13), (-7291.54, 43763.5, 257.326), (-6795.05, 43444.3, 247.059), (-6820.03, 43382.4, 238.789), (-6845.69, 43287.7, 253.317), (-6871.27, 43206.3, 271.569)];
      break;
    case #"hash_85e9d22b30423202":
      var_d23f6234846f86a6["_a"] = [(-13759, -9636, 51)];
      break;
    default:
      break;
  }

  if(isDefined(var_d23f6234846f86a6[label])) {
    foreach(removalpoint in var_d23f6234846f86a6[label]) {
      var_25ff688c15d791d2 = spawnStruct();
      var_25ff688c15d791d2.visual = undefined;
      var_25ff688c15d791d2.distancesquared = undefined;

      foreach(visual in othervisuals) {
        distancesquared = distancesquared(removalpoint, visual.origin);

        if(distancesquared > 400) {
          continue;
        }

        if(!isDefined(var_25ff688c15d791d2.distancesquared) || distancesquared < var_25ff688c15d791d2.distancesquared) {
          var_25ff688c15d791d2.visual = visual;
          var_25ff688c15d791d2.distancesquared = distancesquared;
        }
      }

      if(isDefined(var_25ff688c15d791d2.visual)) {
        othervisuals = scripts\engine\utility::array_remove(othervisuals, var_25ff688c15d791d2.visual);
      }
    }
  }

  return othervisuals;
}

function postshipmodifychevrons(othervisuals, label) {
  var_34dce00df63cff91 = [];

  switch (level.mapname) {
    case #"hash_dfa04d97b4cc9b44":
      var_34dce00df63cff91["_a"] = [];
      var_34dce00df63cff91["_a"][0] = [(-8705.1, 41410.1, 268), (0, 74, 0)];
      var_34dce00df63cff91["_a"][1] = [(-8789.1, 41434.1, 270), (0, 74, 0)];
      var_34dce00df63cff91["_a"][2] = [(-8843.1, 41446.1, 270), (0, 74, 0)];
      var_34dce00df63cff91["_a"][3] = [(-8936.38, 41990.3, 282), (0, 344, 0)];
      var_34dce00df63cff91["_a"][4] = [(-8875.08, 42015.3, 288.024), (0, 255, 0)];
      var_34dce00df63cff91["_a"][5] = [(-8702.42, 41972.5, 277.812), (0, 255, 0)];
      var_34dce00df63cff91["_a"][6] = [(-8582.16, 41936.6, 277.812), (0, 255, 0)];
      var_34dce00df63cff91["_a"][7] = [(-8456, 41902, 280), (0, 255, 0)];
      var_34dce00df63cff91["_a"][8] = [(-8328.93, 41577.2, 258.001), (0, 164, 0)];
      var_34dce00df63cff91["_a"][9] = [(-8984.06, 41783.8, 266.233), (0, 344, 0)];
      var_34dce00df63cff91["_b"] = [];
      var_34dce00df63cff91["_b"][0] = [(-7268.6, 43247.6, 302.314), (0, 75, 0)];
      var_34dce00df63cff91["_b"][1] = [(-7417.31, 43277.5, 310.182), (0, 75, 0)];
      var_34dce00df63cff91["_b"][2] = [(-7489.92, 43298.4, 320.182), (0, 75, 0)];
      var_34dce00df63cff91["_b"][3] = [(-6936.37, 43155.1, 261.456), (0, 75, 0)];
      var_34dce00df63cff91["_b"][4] = [(-7237.4, 43784.4, 269.851), (0, 340, 0)];
      var_34dce00df63cff91["_b"][5] = [(-7209.91, 43870, 267.73), (0, 340, 0)];
      var_34dce00df63cff91["_b"][6] = [(-7188.96, 43931.1, 265.13), (0, 340, 0)];
      var_34dce00df63cff91["_b"][7] = [(-7291.54, 43763.5, 257.326), (0, 253, 0)];
      var_34dce00df63cff91["_b"][8] = [(-6795.05, 43444.3, 247.059), (0, 160, 0)];
      var_34dce00df63cff91["_b"][9] = [(-6820.03, 43382.4, 238.789), (0, 160, 0)];
      var_34dce00df63cff91["_b"][10] = [(-6843.79, 43311.7, 245.027), (0, 160, 0)];
      var_34dce00df63cff91["_b"][11] = [(-6863.11, 43221.2, 271.244), (0, 160, 0)];
      var_34dce00df63cff91["_b"][12] = [(-6882.7, 43159.3, 268.085), (0, 160, 0)];
      break;
  }

  if(isDefined(var_34dce00df63cff91[label])) {
    modifiedvisuals = [];

    foreach(entry in var_34dce00df63cff91[label]) {
      origin = entry[0];
      angles = entry[1];
      scriptable = spawnscriptable("hardpoint_chevron", origin, angles);
      modifiedvisuals[modifiedvisuals.size] = scriptable;
    }

    othervisuals = array_combine(othervisuals, modifiedvisuals);
  }

  return othervisuals;
}

function function_726259d42f88361(state) {
  self notify("updateChevrons");
  self endon("updateChevrons");

  while(!isDefined(self.chevrons)) {
    waitframe();
  }

  var_a27485475186b39d = "chevron_";

  foreach(chevron in self.chevrons) {
    for(i = 0; i < chevron.numchevrons; i++) {
      chevron setscriptablepartstate(var_a27485475186b39d + i, state);
    }
  }
}

function function_223fb185e0afb231() {
  if(isDefined(self.segmentupdate) && self.segmentupdate >= level.capturesegments || self.ownerteam == game["attackers"]) {
    thread function_726259d42f88361("off");
    return;
  }

  if(self.stalemate) {
    thread function_726259d42f88361("contested");
    return;
  }

  if(self.isunoccupied) {
    thread function_726259d42f88361("idle");
    return;
  }

  thread function_726259d42f88361(self.mostnumtouchingteam);
}

function control_onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  if(isDefined(attacker) && isPlayer(attacker) && attacker != self && attacker.team != self.team) {
    isattacker = attacker.team == game["attackers"];
    victim = self;
    attackerteam = attacker.team;
    livescount = getteamdata(victim.team, "controlUILivesCount");
    teamcount = getteamdata(victim.team, "teamCount");

    if(livescount - 1 == teamcount) {
      namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c(24, victim.team);
    }

    foreach(zone in level.objectives) {
      if(!isDefined(zone.trigger)) {
        continue;
      }

      var_229449cfd54fdc5b = attacker istouching(zone.trigger);
      var_9d0123af024e86ac = victim istouching(zone.trigger);

      if(isattacker) {
        if(var_229449cfd54fdc5b) {
          attacker scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648(11, 1);
        }

        continue;
      }

      if(var_9d0123af024e86ac) {
        attacker scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648(11, 1);
      }
    }

    if(isattacker) {
      attacker scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648(10, 1);
    } else {
      attacker scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648(9, 1);
    }

    scripts\mp\gametypes\obj_dom::awardgenericmedals(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid);
  }

  currentteam = self.team;
  issuicide = scripts\mp\damage::issuicide(einflictor, attacker, smeansofdeath, objweapon);
  isteamkill = scripts\mp\damage::isteamkill(einflictor, attacker);

  if(isDefined(self.joining_team) && self.joining_team != "spectator") {
    currentteam = getotherteam(self.joining_team)[0];
  }

  if((issuicide || isteamkill) && !level.suicideteamkilllowerslives && !istrue(self.switching_teams)) {
    if(getteamdata(currentteam, "noRespawns")) {
      thread scripts\mp\playerlogic::spawnclient();
    }

    level thread function_d620fd9b072da70d(self, currentteam);
    return;
  }

  game["match_kills"][getotherteam(currentteam)[0]]++;
  function_c6ae85c2ab29d931(self, currentteam);
}

function function_c6ae85c2ab29d931(player, affectedteam) {
  if(!getteamdata(affectedteam, "noRespawns") && getteamdata(affectedteam, "livesCount") == 0) {
    function_539f2c0c7c8e8403(affectedteam);
  }

  level.teamdata[affectedteam]["controlUILivesCount"]--;
  level function_56c428ee980a8464();
  var_6bcdfd625daabeef = get_lives(affectedteam, 1);
  teamcount = getteamdata(affectedteam, "teamCount");

  if(var_6bcdfd625daabeef == 0 && level.numteamlives != 0 || teamcount == 0) {
    otherteam = getotherteam(affectedteam)[0];
    level thread scripts\mp\gamelogic::endgame(otherteam, game["end_reason"]["enemies_eliminated"], game["end_reason"]["friendlies_eliminated"]);
    scripts\mp\codcasterclientmatchdata::function_94c8f3722d550646();
  }
}

function control_ononeleftevent(team) {
  lastplayer = getlastlivingplayer(team);
  lastplayer thread control_givelastonteamwarning();
}

function control_givelastonteamwarning() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  waittillrecoveredhealth(3);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, #"bc_status_inform_last_one");
  otherteam = getotherteam(self.pers["team"])[0];
  level thread teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread teamplayercardsplash("callout_lastenemyalive", self, otherteam);
  level notify("last_alive", self);
}

function function_df4c58d276eea572(team) {
  if(gettimepassed() < 5000) {
    return;
  }

  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players) {
    player thread scripts\mp\gametypes\hq::showrespawnwarningmessage();
  }

  scripts\mp\utility\dialog::statusdialog("team_no_lives", team, "lives");

  foreach(enemyteam in getotherteam(team)) {
    scripts\mp\utility\dialog::statusdialog("enemy_no_lives", enemyteam, "lives");
  }
}

function onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  if(istrue(level.teamscoresonkill[attacker.team])) {
    oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
  }

  level function_56c428ee980a8464();
}

function getflagteam() {
  return scripts\mp\gameobjects::getownerteam();
}

function flagsetup() {
  setdevdvarifuninitialized(@ "scr_domdebug", "<dev string:xa5>");

  foreach(controlzone in level.objectives) {
    controlzone.spawnflagid = getflagspawnidforobjectivekey(controlzone.objectivekey);
  }

  spawnpoints = level.spawnpoints;

  foreach(spawnpoint in spawnpoints) {
    spawnpoint.scriptdata.domflagassignments = getspawnpointflagassignment(spawnpoint);
  }
}

function getflagspawnidforobjectivekey(objectivekey) {
  switch (objectivekey) {
    case #"hash_fac2c5f6bddd49bd":
      return 1;
    case #"hash_fac2c2f6bddd4504":
      return 2;
    case #"hash_fac2c3f6bddd4697":
      return 4;
    case #"hash_fac2c0f6bddd41de":
      return 8;
    case #"hash_fac2c1f6bddd4371":
      return 16;
  }

  return undefined;
}

function getspawnpointflagassignment(spawnpoint) {
  if(scripts\cp_mp\utility\game_utility::isarenamap()) {
    if(spawnpoint.script_noteworthy == "1" || spawnpoint.script_noteworthy == "2" || spawnpoint.script_noteworthy == "3") {
      spawnpoint.script_noteworthy = "";
    }
  }

  if(isDefined(spawnpoint.script_noteworthy) && spawnpoint.script_noteworthy != "" && spawnpoint.script_noteworthy != "6v6" && spawnpoint.script_noteworthy != "10v10") {
    flagassignment = parseflagassignmentstring(spawnpoint.script_noteworthy);

    if(isDefined(flagassignment)) {
      return flagassignment;
    }
  }

  nearestdompoint = findnearestdompoint(spawnpoint.origin);
  return nearestdompoint.spawnflagid;
}

function parseflagassignmentstring(stringvalue) {
  stringvalue = tolower(stringvalue);

  switch (stringvalue) {
    case #"hash_31103fbc01bd840c":
      return 1;
    case #"hash_311042bc01bd88c5":
      return 2;
    case #"hash_311041bc01bd8732":
      return 4;
    case #"hash_31103cbc01bd7f53":
      return 8;
    case #"hash_31103bbc01bd7dc0":
      return 16;
    case #"hash_fa18c2f6bd57792a":
    case #"hash_fa21b1f6bd5e1a2c":
      return 32;
    case #"hash_fa1ecaf6bd5c02f0":
    case #"hash_fa21b3f6bd5e1d52":
      return 64;
    case #"hash_fa18c3f6bd577abd":
    case #"hash_fa1ecdf6bd5c07a9":
      return 128;
    default:
      assertmsg("<dev string:xaa>" + stringvalue + "<dev string:xe3>");
      break;
  }
}

function findnearestdompoint(pos) {
  navmeshpoints = [];

  foreach(dompoint in level.objectives) {
    dompoint.navmeshpos = getclosestpointonnavmesh(dompoint.trigger.origin);
    navmeshpoints[navmeshpoints.size] = dompoint.navmeshpos;
  }

  var_2a1e7872f714f838 = findclosestpointbyapproxpathdist(navmeshpoints, getclosestpointonnavmesh(pos));
  nearestdompoint = undefined;

  if(!isDefined(var_2a1e7872f714f838)) {
    nearestdist = undefined;

    foreach(dompoint in level.objectives) {
      dist = distancesquared(dompoint.trigger.origin, pos);

      if(!isDefined(nearestdompoint) || dist < nearestdist) {
        nearestdompoint = dompoint;
        nearestdist = dist;
      }
    }
  } else {
    foreach(dompoint in level.objectives) {
      if(distance2dsquared(dompoint.navmeshpos, var_2a1e7872f714f838) < 1) {
        nearestdompoint = dompoint;
        break;
      }
    }

    assert(isDefined(nearestdompoint));
  }

  return nearestdompoint;
}

function function_8861fae4db7f9c2() {
  spawnpoints = spawnlogic::getteamspawnpoints("<dev string:x128>");
  fallbacks = spawnlogic::getteamfallbackspawnpoints("<dev string:x128>");
  spawnpoints = array_combine(spawnpoints, fallbacks);
  ispathdataavailable = spawnlogic::ispathdataavailable();
  heightoffsetlines = (0, 0, 12);
  heightoffsetnames = (0, 0, 64);
  colors = [];
  colors[1] = (1, 0, 0);
  colors[2] = (0, 1, 0);
  colors[4] = (0, 0, 1);
  colors[8] = (1, 1, 1);
  colors[16] = (0, 0, 0);
  colors[32] = (1, 1, 0);
  colors[64] = (0, 1, 1);
  colors[128] = (1, 0, 1);

  while(true) {
    if(getDvar(@ "scr_domdebug") != "<dev string:x130>") {
      wait 1;
      continue;
    }

    setdevdvar(@ "scr_showspawns", "<dev string:x130>");

    while(true) {
      if(getDvar(@ "scr_domdebug") != "<dev string:x130>") {
        setdevdvar(@ "scr_showspawns", "<dev string:xa5>");
        break;
      }

      if(!isDefined(level.players[0])) {
        waitframe();
        continue;
      }

      endpoints = [];
      endpoints[1] = [level.objectives["<dev string:x135>"]];
      endpoints[2] = [level.objectives["<dev string:x13b>"]];
      endpoints[4] = [level.objectives["<dev string:x141>"]];
      endpoints[8] = [level.objectives["<dev string:x147>"]];
      endpoints[16] = [level.objectives["<dev string:x14d>"]];
      endpoints[32] = [level.objectives["<dev string:x135>"], level.objectives["<dev string:x13b>"]];
      endpoints[64] = [level.objectives["<dev string:x141>"], level.objectives["<dev string:x13b>"]];
      endpoints[128] = [level.objectives["<dev string:x135>"], level.objectives["<dev string:x141>"]];

      foreach(spawnpoint in spawnpoints) {
        spawnpointdata = spawnpoint.scriptdata;

        if(!isDefined(spawnpointdata.domflagassignments)) {
          continue;
        }

        if(!isDefined(spawnpointdata.var_601117ef603f46a3)) {
          spawnpointdata.var_601117ef603f46a3 = [];
        }

        if(ispathdataavailable) {
          foreach(endpoint in endpoints[spawnpoint.scriptdata.domflagassignments]) {
            if(!isDefined(spawnpointdata.var_601117ef603f46a3[endpoint.spawnflagid])) {
              spawnpointdata.var_601117ef603f46a3[endpoint.spawnflagid] = level.players[0] findpath(spawnpoint.origin, endpoint.curorigin);
            }

            if(!isDefined(spawnpointdata.var_601117ef603f46a3[endpoint.spawnflagid]) || spawnpointdata.var_601117ef603f46a3[endpoint.spawnflagid].size == 0) {
              continue;
            }

            color = colors[spawnpoint.scriptdata.domflagassignments];
            line(spawnpoint.origin + heightoffsetlines, spawnpointdata.var_601117ef603f46a3[endpoint.spawnflagid][0] + heightoffsetlines, color);

            for(i = 0; i < spawnpointdata.var_601117ef603f46a3[endpoint.spawnflagid].size - 1; i++) {
              line(spawnpointdata.var_601117ef603f46a3[endpoint.spawnflagid][i] + heightoffsetlines, spawnpointdata.var_601117ef603f46a3[endpoint.spawnflagid][i + 1] + heightoffsetlines, color);
            }
          }

          continue;
        }

        foreach(endpoint in endpoints[spawnpoint.scriptdata.domflagassignments]) {
          line(endpoint.curorigin + heightoffsetlines, spawnpoint.origin + heightoffsetlines, (0.2, 0.2, 0.6));
        }
      }

      foreach(flaglocation in level.objectives) {
        if(flaglocation == level.bestspawnflag["<dev string:x153>"]) {
          print3d(flaglocation.trigger.origin + heightoffsetnames, "<dev string:x15d>");
        }

        if(flaglocation == level.bestspawnflag["<dev string:x128>"]) {
          print3d(flaglocation.trigger.origin + heightoffsetnames, "<dev string:x17a>");
        }
      }

      waitframe();
    }
  }
}

function control_onspawnplayer(revivespawn) {
  thread updatematchstatushintonspawn();

  if(getteamdata(self.team, "livesCount") == 0 && getteamdata(self.team, "noRespawns") == 0 && level.numteamlives != 0) {
    function_539f2c0c7c8e8403(self.team);
  }
}

function function_d9c3e51ec6bc88be(player) {
  if(getteamdata(player.team, "noRespawns") && player.team != "none" && player.team != "spectator") {
    return true;
  }

  return false;
}

function control_onplayerconnect(player) {
  player thread onplayerspawned();
}

function control_onplayerdisconnect(player) {
  if(isreallyalive(player)) {
    function_c6ae85c2ab29d931(player, player.team);
  }
}

function function_d620fd9b072da70d(player, currentteam) {
  level.teamdata[currentteam]["uncountedDeaths"]++;
  player.uncounteddeath = 1;
  player waittill_any_2("spawned", "disconnect");
  level.teamdata[currentteam]["uncountedDeaths"]--;
  player.uncounteddeath = undefined;
}

function function_56c428ee980a8464() {
  var_853bab92f5cddacb = getteamdata("allies", "aliveCount");
  var_648c7106b0a281e7 = getteamdata("axis", "aliveCount");

  if(level.numteamlives == 0) {
    setomnvar("ui_allies_alive", getteamdata("allies", "teamCount"));
    setomnvar("ui_axis_alive", getteamdata("axis", "teamCount"));
    setomnvar("ui_allies_lives_remaining", getteamdata("allies", "teamCount"));
    setomnvar("ui_axis_lives_remaining", getteamdata("axis", "teamCount"));
    return;
  } else if(var_853bab92f5cddacb > level.numteamlives || var_648c7106b0a281e7 > level.numteamlives) {
    var_4edf38fbab5966e5 = ter_op(var_853bab92f5cddacb > var_648c7106b0a281e7, var_853bab92f5cddacb, var_648c7106b0a281e7);
    function_1f5ab97903453ce1("allies", var_4edf38fbab5966e5);
    function_1f5ab97903453ce1("axis", var_4edf38fbab5966e5);
    level.numteamlives = var_4edf38fbab5966e5;
  }

  setomnvar("ui_allies_alive", get_lives("allies", 1));
  setomnvar("ui_axis_alive", get_lives("axis", 1));
  setomnvar("ui_allies_lives_remaining", get_lives("allies", 1));
  setomnvar("ui_axis_lives_remaining", get_lives("axis", 1));
  var_3c88e2c95a9c563d = level.teamdata["allies"]["teamCount"];

  if(getteamdata("allies", "livesCount") <= 10 && !level.var_a18fa3de81feff0a && level.numteamlives - var_3c88e2c95a9c563d > 10) {
    scripts\mp\utility\dialog::statusdialog("team_low_lives", "allies", "lives");
    scripts\mp\utility\dialog::statusdialog("enemy_low_lives", "axis", "lives");
    level.var_a18fa3de81feff0a = 1;
  }

  var_76686016ad63e461 = level.teamdata["axis"]["teamCount"];

  if(getteamdata("axis", "livesCount") <= 10 && !level.var_a18fa0de81fef871 && level.numteamlives - var_76686016ad63e461 > 10) {
    scripts\mp\utility\dialog::statusdialog("team_low_lives", "axis", "lives");
    scripts\mp\utility\dialog::statusdialog("enemy_low_lives", "allies", "lives");
    level.var_a18fa0de81fef871 = 1;
  }
}

function function_1f5ab97903453ce1(team_name, var_41e4d73fabed18df) {
  alivecount = getteamdata(team_name, "aliveCount");
  livescount = getteamdata(team_name, "livesCount");
  uicount = getteamdata(team_name, "controlUILivesCount");

  if(var_41e4d73fabed18df < uicount || var_41e4d73fabed18df < alivecount + livescount) {
    assertmsg("<dev string:x197>" + team_name);
    return;
  }

  if(alivecount + livescount < var_41e4d73fabed18df) {
    var_e4c33c2942b6c9cd = var_41e4d73fabed18df - alivecount + livescount;
    level.teamdata[team_name]["livesCount"] = level.teamdata[team_name]["livesCount"] + var_e4c33c2942b6c9cd;
    level.teamdata[team_name]["noRespawns"] = 0;
  }

  if(uicount != var_41e4d73fabed18df) {
    level.teamdata[team_name]["controlUILivesCount"] = var_41e4d73fabed18df;
  }
}

function function_99a2435bdaa61d08() {
  level function_56c428ee980a8464();
}

function get_lives(team, internal_count) {
  total_lives = undefined;

  if(istrue(internal_count)) {
    total_lives = level.teamdata[team]["controlUILivesCount"];
  } else {
    livescount = getteamdata(team, "livesCount");
    alivecount = getteamdata(team, "aliveCount");
    total_lives = livescount + alivecount;
  }

  if(!isDefined(total_lives) || total_lives < 0) {
    total_lives = 0;
  }

  return total_lives;
}

function onplayerspawned(player) {
  self endon("disconnect");

  while(true) {
    self waittill("spawned");
    setextrascore0(0);

    if(isDefined(self.pers["damage"])) {
      setextrascore0(self.pers["damage"]);
    }

    setextrascore1(0);

    if(isDefined(self.pers["segmentCaptures"])) {
      setextrascore1(self.pers["segmentCaptures"]);
    }

    level function_56c428ee980a8464();
  }
}

function function_6dc36e4dd3018346(objectivetype, label, credit_player, team, oldteam, flagobj) {
  level.usestartspawns = 0;
  soundalias = undefined;
  soundalias_otherteam = undefined;
  assert(team != "<dev string:x1cb>");
  game["segment_captures"][team]++;
  function_216b35ca5806ec6(game["segment_captures"][team], team);
  credit_player = scripts\mp\gameobjects::function_15a05ddc354746a2(credit_player);
  function_37fa3a520e86530d(credit_player);
  otherteam = getotherteam(team)[0];

  if(scripts\mp\gametypes\obj_dom::getteamflagcount(team) == level.objectives.size) {
    soundalias = "mp_jup_control_flag_captured_all";
    soundalias_otherteam = "mp_jup_control_flag_lost_all";
  } else {
    soundalias = "mp_jup_control_flag_captured";
    soundalias_otherteam = "mp_jup_control_flag_lost";
  }

  thread printandsoundoneveryone(team, otherteam, undefined, undefined, soundalias, soundalias_otherteam, credit_player);

  if(scripts\mp\gametypes\obj_dom::getteamflagcount(team) < level.objectives.size) {
    scripts\mp\utility\dialog::statusdialog("secured" + self.objectivekey, team);

    if(isDefined(oldteam) && oldteam == "neutral") {
      if(isDefined(level.objectives) && level.objectives.size == 5 && (self.objectivekey == "_c" || self.objectivekey == "_d") || self.objectivekey == "_b") {
        scripts\mp\utility\dialog::statusdialog("lost" + self.objectivekey, otherteam);
      }
    } else {
      scripts\mp\utility\dialog::statusdialog("lost" + self.objectivekey, otherteam);
    }
  } else {
    thread scripts\mp\music_and_dialog::dominating_music(team);
    scripts\mp\utility\dialog::statusdialog("gamestate_domwinning", team);
    scripts\mp\utility\dialog::statusdialog("gamestate_domlosing", otherteam);
  }

  if(!isDefined(level.var_b6d6b525aeaa0557)) {
    level.var_b6d6b525aeaa0557 = 0;
  }

  level.var_b6d6b525aeaa0557++;

  if(level.var_b6d6b525aeaa0557 == level.objectives.size - 1) {
    scripts\mp\utility\dialog::statusdialog("attack_last_flag", team, "finale");
    scripts\mp\utility\dialog::statusdialog("defend_last_flag", otherteam, "finale");
    setmusicstate("mp_timesup_general");
  }

  if(level.var_b6d6b525aeaa0557 == level.objectives.size) {
    level thread scripts\mp\gamelogic::endgame(game["attackers"], game["end_reason"]["control_allzones_win"], game["end_reason"]["control_allzones_loss"]);
    scripts\mp\codcasterclientmatchdata::function_94c8f3722d550646();
  } else {
    flagobj.var_25317b559796e5d1 = 0;
    otherflag = array_remove(level.objectives, flagobj)[0];

    if(!istrue(otherflag.var_25317b559796e5d1)) {
      scripts\mp\gamelogic::resumetimer();
    }

    if(level.segmentcaptureextratime > 0) {
      thread function_fc3c787b555257ac(level.segmentcaptureextratime, istrue(otherflag.var_25317b559796e5d1));
    } else {
      thread function_fc3c787b555257ac(level.captureextratime, istrue(otherflag.var_25317b559796e5d1));
    }
  }

  capturedwaypoint = scripts\mp\gameobjects::function_fd1b4a7d915fc9a6(flagobj.curorigin, flagobj.offset3d, 1, 0);
  capturedwaypoint scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_dom_captured");
  level.var_bdd2491524b1ddd5[label] = capturedwaypoint;
  scripts\mp\gametypes\obj_dom::removeobjective(flagobj);
}

function function_90ee8e359d6d3323(team, capplayer, segment) {
  otherteam = getotherteam(team)[0];
  capplayer = scripts\mp\gameobjects::function_15a05ddc354746a2(capplayer);

  if(self.segmentupdate != level.capturesegments) {
    game["segment_captures"][team]++;
    function_37fa3a520e86530d(capplayer);
    function_216b35ca5806ec6(game["segment_captures"][team], team);
  }

  if(segment == level.capturesegments) {
    soundalias = "mp_jup_control_flag_captured_all";
    soundalias_otherteam = "mp_jup_control_flag_lost_all";
  } else {
    soundalias = "mp_jup_control_win_section";
    soundalias_otherteam = "mp_jup_control_lose_section";
  }

  if(segment < 3) {
    thread printandsoundoneveryone(team, otherteam, undefined, undefined, soundalias, soundalias_otherteam, capplayer);
  }

  pause_timer = segment != level.capturesegments;

  if(level.segmentcaptureextratime > 0) {
    thread function_fc3c787b555257ac(level.segmentcaptureextratime, pause_timer);
  }
}

function function_fc3c787b555257ac(time, pause_game) {
  if(getwatcheddvar("timelimit") == 0) {
    return;
  }

  if(!isDefined(level.extratime)) {
    level.extratime = 0;
  }

  level.extratime += time;
  timeremaining = scripts\mp\gamelogic::gettimeremaining();
  scripts\mp\gamelogic::resumetimer(level.extratime + timeremaining);
  waitframe();

  if(level.pausetimer && istrue(pause_game)) {
    scripts\mp\gamelogic::pausetimer();
  }
}

function function_95b0959344794f91() {
  self endon("<dev string:x1d6>");

  while(true) {
    if(getdvarint(@ "hash_46a6b424af6acbc2") != 0) {
      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x153>", getdvarint(@ "hash_46a6b424af6acbc2"), 1);
      break;
    } else if(getdvarint(@ "hash_86e14326e43c0115") != 0) {
      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x128>", getdvarint(@ "hash_86e14326e43c0115"), 1);
      break;
    }

    wait 1;
  }

  setdevdvar(@ "hash_46a6b424af6acbc2", 0);
  setdevdvar(@ "hash_86e14326e43c0115", 0);
  thread function_95b0959344794f91();
}

function removedompoint() {
  self endon("<dev string:x1d6>");

  while(true) {
    if(getDvar(@ "hash_6ce167f2cdc8ef7c", "<dev string:x1e4>") != "<dev string:x1e4>") {
      flaglabel = getDvar(@ "hash_6ce167f2cdc8ef7c", "<dev string:x1e4>");

      foreach(domflag in level.objectives) {
        if(isDefined(domflag.objectivekey) && domflag.objectivekey == flaglabel) {
          domflag scripts\mp\gameobjects::allowuse("<dev string:x1e8>");
          domflag.trigger = undefined;
          domflag notify("<dev string:x1f0>");
          domflag.visibleteam = "<dev string:x1e8>";
          domflag scripts\mp\gameobjects::setobjectivestatusicons(undefined);
          tempflags = [];

          foreach(objective in level.objectives) {
            if(objective.objectivekey != flaglabel) {
              tempflags[objective.objectivekey] = objective;
            }
          }

          level.objectives = tempflags;
          break;
        }
      }

      setdynamicdvar(@ "hash_6ce167f2cdc8ef7c", "<dev string:x1e4>");
    }

    wait 1;
  }
}

function placedompoint() {
  self endon("<dev string:x1d6>");

  while(true) {
    if(getDvar(@ "hash_29d45d6822a1cf6d", "<dev string:x1e4>") != "<dev string:x1e4>") {
      flaglabel = getDvar(@ "hash_29d45d6822a1cf6d", "<dev string:x1e4>");
      zone = spawnStruct();
      zone.origin = level.players[0].origin;
      zone.angles = level.players[0].angles;
      trigger = spawn("<dev string:x1fb>", zone.origin, 0, 120, 128);
      zone.trigger = trigger;
      zone.trigger.script_label = flaglabel;
      zone.ownerteam = "<dev string:x1cb>";
      tracestart = zone.origin + (0, 0, 32);
      traceend = zone.origin + (0, 0, -32);
      trace = scripts\engine\trace::ray_trace(tracestart, traceend, undefined, scripts\engine\trace::create_default_contents(1));
      zone.origin = trace["<dev string:x20d>"];
      zone.upangles = vectortoangles(trace["<dev string:x219>"]);
      zone.forward = anglesToForward(zone.upangles);
      zone.right = anglestoright(zone.upangles);
      zone.visuals[0] = spawn("<dev string:x223>", zone.origin);
      zone.visuals[0].angles = zone.angles;
      domflag = scripts\mp\gameobjects::createuseobject("<dev string:x1cb>", zone.trigger, zone.visuals, (0, 0, 100));
      domflag scripts\mp\gameobjects::allowuse("<dev string:x233>");
      domflag scripts\mp\gameobjects::setusetime(60);

      if(isDefined(trigger.objectivekey)) {
        domflag.objectivekey = trigger.objectivekey;
      } else {
        domflag.objectivekey = domflag scripts\mp\gameobjects::getlabel();
      }

      if(isDefined(trigger.iconname)) {
        domflag.iconname = trigger.iconname;
      } else {
        domflag.iconname = domflag scripts\mp\gameobjects::getlabel();
      }

      domflag scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconneutral);
      domflag scripts\mp\gameobjects::setvisibleteam("<dev string:x23c>");
      domflag.onuse = &control_onuse;
      domflag.onbeginuse = &control_onbeginuse;
      domflag.onuseupdate = &scripts\mp\gametypes\obj_dom::dompoint_onuseupdate;
      domflag.onenduse = &control_onenduse;
      domflag.nousebar = 1;
      domflag.id = "<dev string:x243>";
      domflag.firstcapture = 0;
      domflag.claimgracetime = 10000;
      domflag.decayrate = 50;
      tracestart = zone.visuals[0].origin + (0, 0, 32);
      traceend = zone.visuals[0].origin + (0, 0, -32);
      contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
      ignoreents = [];
      trace = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, contentoverride);
      domflag.baseeffectpos = trace["<dev string:x20d>"];
      upangles = vectortoangles(trace["<dev string:x219>"]);
      domflag.baseeffectforward = anglesToForward(upangles);
      domflag scripts\mp\gametypes\obj_dom::initializematchrecording();
      domflag thread scripts\mp\gametypes\obj_dom::domflag_setneutral();
      level.objectives[domflag.objectivekey] = domflag;
      setdynamicdvar(@ "hash_29d45d6822a1cf6d", "<dev string:x1e4>");
    }

    wait 1;
  }
}

function function_e5b3b788aa8a4401() {
  startpos = self getEye();
  viewangles = self getplayerangles();
  fwd = anglesToForward(viewangles);
  mindot = cos(10);
  maxdistsq = 250000;
  bestdot = undefined;
  bestent = undefined;
  bestdistsq = undefined;
  closestdistsq = undefined;
  closestent = undefined;

  foreach(ent in level.objectives) {
    totarget = vectorNormalize(ent.trigger.origin - startpos);
    dot = vectordot(fwd, totarget);
    distsq = distancesquared(ent.trigger.origin, startpos);

    if(!isDefined(bestdot) || bestdot < dot) {
      bestdot = dot;
      bestdistsq = distsq;
      bestent = ent;
    }

    if(!isDefined(closestdistsq) || closestdistsq > distsq) {
      closestdistsq = distsq;
      closestent = ent;
    }
  }

  ent = undefined;
  msg = undefined;
  event = undefined;

  if(isDefined(bestdot) && bestdot > mindot) {
    ent = bestent;
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
  } else if(isDefined(closestdistsq) && closestdistsq < maxdistsq) {
    ent = closestent;
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

  if(isDefined(ent)) {
    thread scripts\cp_mp\gestures::applygamemodecallout(ent, msg, event);
  }

  return isDefined(ent);
}

function function_d234db657e8b7dc5(event, player) {
  giveconfirm = 0;

  switch (event) {
    case #"hash_7f5ae40133d322a1":
      if(player.team == self.team) {
        giveconfirm = 1;
      }

      break;
    case #"hash_8b567e450ad3ae21":
      if(player.team == self.team) {
        giveconfirm = 1;
      }

      break;
    case #"hash_d4f05e450448c3ec":
      if(player.team == self.team) {
        giveconfirm = 1;
      }

      break;
  }

  return giveconfirm;
}

function function_fcb83cd8b5b5098(excludedflag) {
  if(!isDefined(level.objectives)) {
    return false;
  }

  var_84cdf2cb02579ee3 = level.objectives;

  if(isDefined(excludedflag)) {
    var_84cdf2cb02579ee3 = array_remove(var_84cdf2cb02579ee3, excludedflag);
  }

  foreach(objective in level.objectives) {
    if(istrue(objective.var_25317b559796e5d1)) {
      return true;
    }
  }

  return false;
}

function updatematchstatushintonspawn() {
  level endon("game_ended");

  if(self.team == game["attackers"]) {
    scripts\mp\hud_message::function_f004ef4606b9efdc("control_attack_zones");
  } else {
    scripts\mp\hud_message::function_f004ef4606b9efdc("control_defend_zones");
  }

  level function_56c428ee980a8464();
}

function updatetriggerforcodcaster() {
  level endon("game_ended");
  level waittill("prematch_done");

  while(!level.gameended) {
    foreach(player in level.players) {
      mlgpoint = 0;

      foreach(dompoint in level.objectives) {
        if(!isDefined(dompoint.trigger)) {
          continue;
        }

        if(player istouching(dompoint.trigger) && isalive(player)) {
          mlgpoint = scripts\mp\gametypes\obj_dom::getreservedobjid(dompoint.objectivekey) + 1;
          break;
        }
      }

      if(!isDefined(player.mlgpoint) || player.mlgpoint != mlgpoint) {
        player setmlgdominationpoint(mlgpoint);
        player.mlgpoint = mlgpoint;
        player setgametypevip(1);
      }

      if(mlgpoint == 0) {
        player setgametypevip(0);
      }
    }

    waitframe();
  }
}

function control_ontimelimit() {
  if(!isDefined(level.var_3d06de480d9ef9c4)) {
    level thread scripts\mp\gamelogic::endgame(game["defenders"], game["end_reason"]["time_limit_reached"]);
    scripts\mp\codcasterclientmatchdata::function_94c8f3722d550646();
    level.var_3d06de480d9ef9c4 = 1;
  }
}

function function_63a77191349871bf() {
  scripts\mp\codcasterclientmatchdata::function_edba1ee7c2375a5();
}

function function_539f2c0c7c8e8403(team) {
  setteamdata(team, "noRespawns", 1);

  if(!isDefined(level.var_defc2acd2b0203ad)) {
    level.var_defc2acd2b0203ad = [];
  }

  level.var_defc2acd2b0203ad[team] = gettime();
  function_df4c58d276eea572(team);
}

function function_287623bbb15154be() {
  attacking_team = game["attackers"];
  defending_team = game["defenders"];

  if(level.overtimedefenders == 2) {
    if(game["segment_captures"][attacking_team] > game["segment_captures"][defending_team]) {
      return [attacking_team, game["end_reason"]["team_defending_most_segments"]];
    } else if(game["segment_captures"][defending_team] > game["segment_captures"][attacking_team]) {
      return [defending_team, game["end_reason"]["team_defending_most_segments"]];
    }
  }

  totalkills[attacking_team] = game["match_kills"][attacking_team];
  totalkills[defending_team] = game["match_kills"][defending_team];

  if(totalkills[attacking_team] > totalkills[defending_team]) {
    return [attacking_team, game["end_reason"]["team_defending_most_kills"]];
  }

  if(totalkills[defending_team] > totalkills[attacking_team]) {
    return [defending_team, game["end_reason"]["team_defending_most_kills"]];
  }

  if(randomint(2) == 0) {
    return [attacking_team, game["end_reason"]["team_defending"]];
  }

  return [defending_team, game["end_reason"]["team_defending"]];
}

function function_37fa3a520e86530d(player) {
  player incpersstat("segmentCaptures", 1);
  player scripts\mp\persistence::statsetchild("round", "segmentCaptures", player.pers["segmentCaptures"]);
  player setextrascore1(player.pers["segmentCaptures"]);
}