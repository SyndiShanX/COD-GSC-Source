/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dom.gsc
***********************************************/

function main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_dom_flagCaptureTime", getmatchrulesdata("domData", "flagCaptureTime"));
  setdynamicdvar("scr_dom_flagsRequiredToScore", getmatchrulesdata("domData", "flagsRequiredToScore"));
  setdynamicdvar("scr_dom_pointsPerFlag", getmatchrulesdata("domData", "pointsPerFlag"));
  setdynamicdvar("scr_dom_flagNeutralization", getmatchrulesdata("domData", "flagNeutralization"));
  setdynamicdvar("scr_dom_numFlagsScoreOnKill", getmatchrulesdata("domData", "numFlagsScoreOnKill"));
  setdynamicdvar("scr_dom_objScalar", getmatchrulesdata("domData", "objScalar"));
  setdynamicdvar("scr_dom_preCapPoints", getmatchrulesdata("siegeData", "preCapPoints"));
  setdynamicdvar("scr_dom_captureType", getmatchrulesdata("captureData", "captureType"));
  setdynamicdvar("scr_dom_captureDecay", getmatchrulesdata("captureData", "captureDecay"));
  setdynamicdvar("scr_dom_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("dom", 0);
}

function seticonnames() {
  level.iconneutral = "waypoint_captureneutral";
  level.iconcapture = "waypoint_capture";
  level.icondefend = "waypoint_defend";
  level.icondefending = "waypoint_defending";
  level.iconcontested = "waypoint_contested";
  level.icontaking = "waypoint_taking";
  level.iconlosing = "waypoint_losing";
}

function onstartgametype() {
  seticonnames();

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"OBJECTIVES/DOM");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"OBJECTIVES/DOM");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"OBJECTIVES/DOM_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var_1, &"OBJECTIVES/DOM_HINT");
  }

  setclientnamemode("auto_change");

  if(level.scoremod["kill"] > 0) {
    game["dialog"]["offense_obj"] = "boost_groundwar";
    game["dialog"]["defense_obj"] = "boost_groundwar";
  }

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_3 = game["attackers"];
    var_4 = game["defenders"];
    game["attackers"] = var_4;
    game["defenders"] = var_3;
  }

  initspawns();
  thread domflags();
  thread updatedomscores();
  thread removedompoint();
  thread placedompoint();
  scripts\mp\gametypes\bradley_spawner::inittankspawns();
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("flagCaptureTime", 10, 0, 30);
  level.flagsrequiredtoscore = scripts\mp\utility\dvars::dvarintvalue("flagsRequiredToScore", 1, 1, 3);
  level.pointsperflag = scripts\mp\utility\dvars::dvarintvalue("pointsPerFlag", 1, 1, 300);
  level.flagneutralization = scripts\mp\utility\dvars::dvarintvalue("flagNeutralization", 0, 0, 1);
  level.precappoints = scripts\mp\utility\dvars::dvarintvalue("preCapPoints", 0, 0, 1);
  level.capturedecay = scripts\mp\utility\dvars::dvarintvalue("captureDecay", 1, 0, 1);
  level.capturetype = scripts\mp\utility\dvars::dvarintvalue("captureType", 1, 0, 3);
  level.numflagsscoreonkill = scripts\mp\utility\dvars::dvarintvalue("numFlagsScoreOnKill", 0, 0, 3);
  level.objectivescaler = scripts\mp\utility\dvars::dvarfloatvalue("objScalar", 4, 1, 10);
}

function initspawns() {
  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    scripts\mp\spawnlogic::setactivespawnlogic("BigTDM", "Crit_Default");
  } else if(istrue(level.binoculars_clearuidata)) {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("Domination", "Crit_Default");
  }

  if(getdvarint("scr_game_usespawnselection", 0) == 1) {
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
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_allies_start");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", var_0);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", var_1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dom_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dom_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dom_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dom_spawn_secondary", 1, 1);
  var_2 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn");
  var_3 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("dom", var_2);
  scripts\mp\spawnlogic::registerspawnset("dom_fallback", var_3);

  if(istrue(level.binoculars_clearuidata)) {
    scripts\mp\spawnlogic::registerspawnset("normal", var_2);
    scripts\mp\spawnlogic::registerspawnset("fallback", var_3);
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
  var_0 = self.pers["team"];
  var_1 = getteamdompoints(var_0);
  var_2 = scripts\mp\utility\game::getotherteam(var_0)[0];
  var_3 = getteamdompoints(var_2);
  var_4 = getpreferreddompoints(var_1, var_3, var_0, var_2);
  var_5 = [];
  GscBinSkip0(0x2e, "preferredDomPoints", var_4["preferred"]);
}

function getteamdompoints(var_0) {
  var_1 = [];

  foreach(var_3 in level.objectives) {
    if(var_3.ownerteam == var_0) {
      var_1 = var_3;
    }
  }

  return var_1;
}

function getpreferreddompoints(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(var_0.size == level.objectives.size) {
    var_5 = level.bestspawnflag[var_3];

    foreach(var_7 in var_0) {
      if(var_7 != var_5) {
        var_4 = var_7;
      }
    }
  } else if(var_0.size > 0) {
    foreach(var_7 in var_0) {
      var_4 = var_7;
    }
  } else if(var_0.size == 0) {
    var_11 = level.bestspawnflag[var_2];

    if(var_1.size > 0 && var_1.size < level.objectives.size) {
      var_11 = scripts\mp\gametypes\obj_dom::getunownedflagneareststart(var_2);
    }

    var_4 = var_11;
  }

  var_12 = 0;
  var_13 = 0;

  foreach(var_7 in var_4) {
    if(var_7 scripts\mp\gameobjects::getclaimteam() == "none") {
      var_12 |= var_7.spawnflagid;
      continue;
    }

    var_13 |= var_7.spawnflagid;
  }

  if(var_12 & 1 && var_12 & 2) {
    var_12 |= 32;
  }

  if(var_12 & 4 && var_12 & 2) {
    var_12 |= 64;
  }

  if(var_12 & 1 && var_12 & 4) {
    var_12 |= 128;
  }

  var_16 = [];
  GscBinSkip0(0x2e, "preferred", var_12);
}

function domflags() {
  var_0 = [];
  level.changenumdomflags = 0;

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    var_1 = getEntArray("flag_primary", "targetname");

    foreach(var_3 in var_1) {
      if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == level.localeid) {
        var_0 = var_3;
        continue;
      }

      var_3 delete();
    }
  } else {
    level.changenumdomflags = getdvarint("scr_dom_flagcount", 0);
    var_0 = getEntArray("flag_primary", "targetname");
  }

  var_5 = getEntArray("flag_secondary", "targetname");

  if(var_0.size + var_5.size < 2) {
    return;
  }

  if(level.changenumdomflags == 3) {
    setomnvar("ui_num_dom_flags", level.changenumdomflags);
  } else {
    setomnvar("ui_num_dom_flags", var_0.size);
  }

  var_6 = [];

  for(var_7 = 0; var_7 < var_0.size; var_7++) {
    var_6 = var_0[var_7];
  }

  for(var_7 = 0; var_7 < var_5.size; var_7++) {
    var_6 = var_5[var_7];
  }

  if(level.changenumdomflags == 3 || level.mapname == "mp_rust") {
    foreach(var_9 in var_6) {
      remapdomtriggerscriptlabel(var_9);
    }
  }

  foreach(var_9 in var_6) {
    if(level.changenumdomflags == 3) {
      if(var_9.script_label == "_d" || var_9.script_label == "_e") {
        continue;
      }
    }

    ref_11CA0(var_9);
    var_12 = scripts\mp\gametypes\obj_dom::setupobjective(var_9, undefined, 1, 1);
    level.objectives[var_12.objectivekey] = var_12;
  }

  var_14 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_axis_start");
  var_15 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_allies_start");
  level.startpos["allies"] = var_15[0].origin;
  level.startpos["axis"] = var_14[0].origin;
  level.bestspawnflag = [];
  level.bestspawnflag["allies"] = scripts\mp\gametypes\obj_dom::getunownedflagneareststart("allies", undefined);
  level.bestspawnflag["axis"] = scripts\mp\gametypes\obj_dom::getunownedflagneareststart("axis", level.bestspawnflag["allies"]);
  flagsetup();
  thread modifieddefendradiussetup();

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level scripts\engine\utility::ref_143A5("prematch_done", "start_mode_setup");
  }

  foreach(var_3 in level.objectives) {
    var_17 = scripts\mp\gametypes\obj_dom::getreservedobjid(var_3.objectivekey);
    var_3 scripts\mp\gameobjects::requestid(1, 1, var_17);
    var_3.onuse = &scripts\mp\gametypes\obj_dom::dompoint_onuse;
    var_3.onbeginuse = &scripts\mp\gametypes\obj_dom::dompoint_onusebegin;
    var_3.onuseupdate = &scripts\mp\gametypes\obj_dom::dompoint_onuseupdate;
    var_3.onenduse = &scripts\mp\gametypes\obj_dom::dompoint_onuseend;
    var_3.oncontested = &scripts\mp\gametypes\obj_dom::dompoint_oncontested;
    var_3.onuncontested = &scripts\mp\gametypes\obj_dom::dompoint_onuncontested;
    var_3.onunoccupied = &scripts\mp\gametypes\obj_dom::dompoint_onunoccupied;
    var_3.onpinnedstate = &scripts\mp\gametypes\obj_dom::dompoint_onpinnedstate;
    var_3.onunpinnedstate = &scripts\mp\gametypes\obj_dom::dompoint_onunpinnedstate;
    var_3.stompprogressreward = &scripts\mp\gametypes\obj_dom::dompoint_stompprogressreward;
    var_3 scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");
    var_3 scripts\mp\gameobjects::setvisibleteam("any");
    var_3 scripts\mp\gametypes\obj_dom::domflag_setneutral(undefined, 1);
  }

  if(level.precappoints) {
    thread scripts\mp\gametypes\obj_dom::precap();
  }

  if(level.codcasterenabled) {
    thread ref_1402B();
    return;
  }
}

function ref_11CA0(var_0) {
  switch (level.mapname) {
    case "mp_piccadilly":
      switch (var_0.script_label) {
        case "_a":
          var_0.origin = (983, 303, 110);
          break;
        case "_b":
          var_0.origin = (-1064, -525, 110);
          break;
        case "_c":
          var_0.origin = (-1605, -2298, 60);
          break;
      }

      break;
    case "mp_malyshev":
      if(level.ref_11AD3) {
        switch (var_0.script_label) {
          case "_a":
            var_0.origin = (-520, 632.25, 16);
            break;
        }
      }

      break;
  }
}

function remapdomtriggerscriptlabel() {
  if(level.mapname == "mp_aniyah" || level.mapname == "mp_aniyah_pm") {
    if(self.script_label == "_e" && !isDefined(self.remappedscriptlabel)) {
      self.script_label = "_c";
      self.remappedscriptlabel = 1;
      return;
    }

    if(self.script_label == "_c" && !isDefined(self.remappedscriptlabel)) {
      self.script_label = "_e";
      self.remappedscriptlabel = 1;
      return;
    }

    return;
  }

  if(level.mapname == "mp_rust") {
    if(self.script_label == "_a") {
      self.script_label = "_b";
      return;
    }

    if(self.script_label == "_b") {
      self.script_label = "_a";
      return;
    }

    return;
  }
}

function updatedomscores() {
  level endon("game_ended");
  var_0 = undefined;
  var_1 = undefined;
  level waittill("prematch_done");

  while(!level.gameended) {
    var_2 = 5;
    var_3 = scripts\mp\gamelogic::gettimeremaining();

    if(var_3 < 5000 && var_3 > 0) {
      var_2 = var_3 / 1000;
    }

    wait var_2;
    scripts\mp\hostmigration::waittillhostmigrationdone();
    var_4 = getowneddomflags();

    if(!isDefined(level.scoretick)) {
      level.scoretick = [];
    }

    foreach(var_6 in level.teamnamelist) {
      level.scoretick[var_6] = 0;
    }

    if(var_4.size) {
      for(var_8 = 1; var_8 < var_4.size; var_8++) {
        var_9 = var_4[var_8];
        var_10 = gettime() - var_9.capturetime;

        for(var_11 = var_8 - 1; var_11 >= 0 && var_10 > gettime() - var_4[var_11].capturetime; var_11--) {
          var_4 = var_4[var_11];
        }

        var_4 = var_9;
      }

      foreach(var_9 in var_4) {
        var_13 = var_9 scripts\mp\gameobjects::getownerteam();
        var_0 = getteamscore(var_13);
        var_14 = scripts\mp\gametypes\obj_dom::getteamflagcount(var_13);

        if(var_14 >= level.flagsrequiredtoscore) {
          level.scoretick[var_13] += level.pointsperflag;
        }
      }
    }

    updatescores();
    checkendgame(var_4.size);
  }
}

function updatescores() {
  var_0 = [];

  foreach(var_2 in level.teamnamelist) {
    var_3 = game["teamScores"][var_2] + level.scoretick[var_2];

    if(var_3 >= level.roundscorelimit) {
      var_0 = var_2;
    }
  }

  if(var_0.size == 1) {
    level.scoretick[var_0[0]] = level.roundscorelimit - game["teamScores"][var_0[0]];
  }

  var_5 = scripts\mp\gamescore::freight_lift_door_switch();

  foreach(var_2 in level.teamnamelist) {
    if(level.scoretick[var_2] > 0) {
      scripts\mp\gamescore::giveteamscoreforobjective(var_2, level.scoretick[var_2], 1, undefined, 1);
    }
  }

  var_8 = scripts\mp\gamescore::freight_lift_door_switch();

  if(var_5 != var_8) {
    scripts\mp\gamescore::ref_12762(var_8, 1, var_5);
    return;
  }
}

function checkendgame(var_0) {
  var_1 = gettime() - level.lastcaptime;

  if(scripts\mp\utility\game::matchmakinggame() && var_0 < 2 && var_1 > 120000) {
    level.forcedend = 1;
    thread scripts\mp\gamelogic::endgame("none", game["end_reason"]["dom_force_end"]);
    return;
  }

  if(level.objectives.size == 3 && level.playholdtwovo && var_1 > 30000) {
    foreach(var_3 in level.teamnamelist) {
      if(scripts\mp\gametypes\obj_dom::getteamflagcount(var_3) == 2) {
        var_4 = scripts\mp\utility\game::getotherteam(var_3)[0];
        scripts\mp\utility\dialog::statusdialog("enemy_captured_2", var_4);
        scripts\mp\utility\dialog::statusdialog("friendly_captured_2", var_3);
        level.playholdtwovo = 0;
        break;
      }
    }

    return;
  }
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }

  if(isDefined(var_4) && scripts\mp\utility\weapon::iskillstreakweapon(var_4.basename)) {
    return;
  }

  scripts\mp\gametypes\obj_dom::awardgenericmedals(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(level.teamscoresonkill[var_1.team]) {
    scripts\mp\gametypes\common::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
    return;
  }
}

function getowneddomflags() {
  var_0 = [];

  foreach(var_2 in level.objectives) {
    if(var_2 scripts\mp\gameobjects::getownerteam() != "neutral" && isDefined(var_2.capturetime)) {
      var_0 = var_2;
    }
  }

  return var_0;
}

function getflagteam() {
  return scripts\mp\gameobjects::getownerteam();
}

function flagsetup() {
  foreach(var_1 in level.objectives) {
    var_1.spawnflagid = getflagspawnidforobjectivekey(var_1.objectivekey);
  }

  var_3 = level.spawnpoints;

  foreach(var_5 in var_3) {
    var_5.scriptdata.domflagassignments = getspawnpointflagassignment(var_5);
  }
}

function getflagspawnidforobjectivekey(var_0) {
  switch (var_0) {
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

function getspawnpointflagassignment(var_0) {
  if(scripts\cp_mp\utility\game_utility::isarenamap()) {
    if(var_0.script_noteworthy == "1" || var_0.script_noteworthy == "2" || var_0.script_noteworthy == "3") {
      var_0.script_noteworthy = "";
    }
  }

  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy != "" && var_0.script_noteworthy != "6v6" && var_0.script_noteworthy != "10v10") {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      var_1 = parseflagassignmentstring(var_0.script_noteworthy);

      if(isDefined(var_1)) {
        return var_1;
      }
    }
  }

  var_2 = findnearestdompoint(var_0.origin);
  return var_2.spawnflagid;
}

function parseflagassignmentstring(var_0) {
  var_0 = tolower(var_0);

  switch (var_0) {
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

function findnearestdompoint(var_0) {
  var_1 = [];

  foreach(var_3 in level.objectives) {
    var_3.navmeshpos = getclosestpointonnavmesh(var_3.trigger.origin);
    var_1 = var_3.navmeshpos;
  }

  var_5 = findclosestnonlospointwithinvolume(var_1, getclosestpointonnavmesh(var_0));
  var_6 = undefined;

  if(!isDefined(var_5)) {
    var_7 = undefined;

    foreach(var_3 in level.objectives) {
      var_9 = distancesquared(var_3.trigger.origin, var_0);

      if(!isDefined(var_6) || var_9 < var_7) {
        var_6 = var_3;
        var_7 = var_9;
      }
    }
  } else {
    foreach(var_3 in level.objectives) {
      if(distance2dsquared(var_3.navmeshpos, var_5) < 1) {
        var_6 = var_3;
        break;
      }
    }
  }

  return var_6;
}

function modifieddefendradiussetup() {
  if(level.mapname == "mp_frontier") {
    foreach(var_1 in level.objectives) {
      if(var_1.objectivekey == "_b") {
        var_1.trigger.modifieddefendcheck = 1;
      }
    }

    return;
  }
}

function onspawnplayer() {
  thread updatematchstatushintonspawn();
}

function updatecpm() {
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

function getcapxpscale() {
  if(self.cpm < 4) {
    return 1;
  }

  return 0.25;
}

function onplayerconnect(var_0) {
  var_0.ui_dom_securing = undefined;
  var_0.ui_dom_stalemate = undefined;
  thread onplayerspawned();
}

function onplayerspawned(var_0) {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned");
    scripts\mp\utility\stats::setextrascore0(0);

    if(isDefined(self.pers["captures"])) {
      scripts\mp\utility\stats::setextrascore0(self.pers["captures"]);
    }

    scripts\mp\utility\stats::setextrascore1(0);

    if(isDefined(self.pers["defends"])) {
      scripts\mp\utility\stats::setextrascore1(self.pers["defends"]);
    }
  }
}

function onflagcapture(var_0, var_1, var_2, var_3, var_4, var_5) {
  level.usestartspawns = 0;
  var_6 = undefined;
  var_7 = scripts\mp\utility\game::getotherteam(var_3)[0];

  if(scripts\mp\gametypes\obj_dom::getteamflagcount(var_3) == level.objectives.size) {
    var_6 = "mp_dom_flag_captured_all";
  } else {
    var_6 = "mp_dom_flag_captured";
  }

  thread scripts\mp\utility\print::printandsoundoneveryone(var_3, var_7, undefined, undefined, var_6, "mp_dom_flag_lost", var_2);

  if(scripts\mp\gametypes\obj_dom::getteamflagcount(var_3) < level.objectives.size) {
    scripts\mp\utility\dialog::statusdialog("secured" + self.objectivekey, var_3);

    if(isDefined(var_4) && var_4 == "neutral") {
      if(isDefined(level.objectives) && level.objectives.size == 5 && (self.objectivekey == "_c" || self.objectivekey == "_d") || self.objectivekey == "_b") {
        scripts\mp\utility\dialog::statusdialog("lost" + self.objectivekey, var_7);
        return;
      }

      return;
    }

    scripts\mp\utility\dialog::statusdialog("lost" + self.objectivekey, var_7);
    return;
  }

  thread scripts\mp\music_and_dialog::dominating_music(var_3);
  scripts\mp\utility\dialog::statusdialog("gamestate_domwinning", var_3);
  scripts\mp\utility\dialog::statusdialog("gamestate_domlosing", var_7);
}

function updatescoremod() {
  wait 1;
  level.onnormaldeath = &onnormaldeath;
  level.teamscoresonkill = [];

  foreach(var_1 in level.teamnamelist) {
    level.teamscoresonkill[var_1] = 0;
  }

  level.scoremod["kill"] = 1;
}

function removedompoint() {
  self endon("game_ended");

  for(;;) {
    if(getDvar("scr_devRemoveDomFlag", "") != "") {
      var_0 = getDvar("scr_devRemoveDomFlag", "");

      foreach(var_2 in level.objectives) {
        if(isDefined(var_2.objectivekey) && var_2.objectivekey == var_0) {
          var_2 scripts\mp\gameobjects::allowuse("none");
          var_2.trigger = undefined;
          var_2 notify("deleted");
          var_2.visibleteam = "none";
          var_2 scripts\mp\gameobjects::setobjectivestatusicons(undefined);
          var_3 = [];

          foreach(var_5 in level.objectives) {
            if(var_5.objectivekey != var_0) {
              var_3 = var_5;
            }
          }

          level.objectives = var_3;
          break;
        }
      }

      setdynamicdvar("scr_devRemoveDomFlag", "");
    }

    wait 1;
  }
}

function placedompoint() {
  self endon("game_ended");

  for(;;) {
    if(getDvar("scr_devPlaceDomFlag", "") != "") {
      var_0 = getDvar("scr_devPlaceDomFlag", "");
      var_1 = spawnStruct();
      var_1.origin = level.players[0].origin;
      var_1.angles = level.players[0].angles;
      var_2 = spawn("trigger_radius", var_1.origin, 0, 120, 128);
      var_1.trigger = var_2;
      var_1.trigger.script_label = var_0;
      var_1.ownerteam = "neutral";
      var_3 = var_1.origin + (0, 0, 32);
      var_4 = var_1.origin + (0, 0, -32);
      var_5 = scripts\engine\trace::ray_trace(var_3, var_4, undefined, scripts\engine\trace::create_default_contents(1));
      var_1.origin = var_5["position"];
      var_1.upangles = vectortoangles(var_5["normal"]);
      var_1.forward = anglesToForward(var_1.upangles);
      var_1.right = anglestoright(var_1.upangles);
      var_1.visuals[0] = spawn("script_model", var_1.origin);
      var_1.visuals[0].angles = var_1.angles;
      var_6 = scripts\mp\gameobjects::createuseobject("neutral", var_1.trigger, var_1.visuals, (0, 0, 100));
      var_6 scripts\mp\gameobjects::allowuse("enemy");
      var_6 scripts\mp\gameobjects::setusetime(10);

      if(isDefined(var_2.objectivekey)) {
        var_6.objectivekey = var_2.objectivekey;
      } else {
        var_6.objectivekey = var_6 scripts\mp\gameobjects::getlabel();
      }

      if(isDefined(var_2.iconname)) {
        var_6.iconname = var_2.iconname;
      } else {
        var_6.iconname = var_6 scripts\mp\gameobjects::getlabel();
      }

      var_6 scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconneutral);
      var_6 scripts\mp\gameobjects::setvisibleteam("any");
      var_6.onuse = &scripts\mp\gametypes\obj_dom::dompoint_onuse;
      var_6.onbeginuse = &scripts\mp\gametypes\obj_dom::dompoint_onusebegin;
      var_6.onuseupdate = &scripts\mp\gametypes\obj_dom::dompoint_onuseupdate;
      var_6.onenduse = &scripts\mp\gametypes\obj_dom::dompoint_onuseend;
      var_6.nousebar = 1;
      var_6.id = "domFlag";
      var_6.firstcapture = 1;
      var_6.claimgracetime = 10000;
      var_6.decayrate = 50;
      var_3 = var_1.visuals[0].origin + (0, 0, 32);
      var_4 = var_1.visuals[0].origin + (0, 0, -32);
      var_7 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
      var_8 = [];
      var_5 = scripts\engine\trace::ray_trace(var_3, var_4, var_8, var_7);
      var_6.baseeffectpos = var_5["position"];
      var_9 = vectortoangles(var_5["normal"]);
      var_6.baseeffectforward = anglesToForward(var_9);
      var_6 scripts\mp\gametypes\obj_dom::initializematchrecording();
      var_6 thread scripts\mp\gametypes\obj_dom::domflag_setneutral();
      level.objectives[var_6.objectivekey] = var_6;
      setdynamicdvar("scr_devPlaceDomFlag", "");
    }

    wait 1;
  }
}

function assigngamemodecallout() {
  var_0 = self getEye();
  var_1 = self getplayerangles();
  var_2 = anglesToForward(var_1);
  var_3 = cos(10);
  var_4 = 250000;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;

  foreach(var_11 in level.objectives) {
    var_12 = vectorNormalize(var_11.trigger.origin - var_0);
    var_13 = vectordot(var_2, var_12);
    var_14 = distancesquared(var_11.trigger.origin, var_0);

    if(!isDefined(var_5) || var_5 < var_13) {
      var_5 = var_13;
      var_7 = var_14;
      var_6 = var_11;
    }

    if(!isDefined(var_8) || var_8 > var_14) {
      var_8 = var_14;
      var_9 = var_11;
    }
  }

  var_11 = undefined;
  var_16 = undefined;
  var_17 = undefined;

  if(isDefined(var_5) && var_5 > var_3) {
    var_11 = var_6;
    var_18 = getsubstr(var_11.objectivekey, 1, 2);

    if(var_11.ownerteam == "neutral") {
      var_16 = self.name + ": Capture " + var_18 + "!";
      var_17 = "capture";
    } else if(var_11.ownerteam == self.team) {
      var_16 = self.name + ": Defend" + var_18 + "!";
      var_17 = "defend";
    } else {
      var_16 = self.name + ": Assault " + var_18 + "!";
      var_17 = "assault";
    }
  } else if(isDefined(var_8) && var_8 < var_4) {
    var_11 = var_9;
    var_18 = getsubstr(var_11.objectivekey, 1, 2);

    if(var_11.ownerteam == "neutral") {
      var_16 = self.name + ": Capture " + var_18 + "!";
      var_17 = "capture";
    } else if(var_11.ownerteam == self.team) {
      var_16 = self.name + ": Defend" + var_18 + "!";
      var_17 = "defend";
    } else {
      var_16 = self.name + ": Assault " + var_18 + "!";
      var_17 = "assault";
    }
  }

  if(isDefined(var_11)) {
    thread scripts\cp_mp\gestures::applygamemodecallout(var_11, var_16, var_17);
  }

  return isDefined(var_11);
}

function verifygamemodecallout(var_0, var_1) {
  var_2 = 0;

  switch (var_0) {
    case "capture":
      if(var_1.team == self.team) {
        var_2 = 1;
      }

      break;
    case "defend":
      if(var_1.team == self.team) {
        var_2 = 1;
      }

      break;
    case "assault":
      if(var_1.team == self.team) {
        var_2 = 1;
      }

      break;
  }

  return var_2;
}

function updatematchstatushintonspawn() {
  level endon("game_ended");
  self setclientomnvar("ui_match_status_hint_text", 27);
}

function ref_1402B() {
  level endon("game_ended");
  level waittill("prematch_done");

  while(!level.gameended) {
    foreach(var_1 in level.players) {
      var_2 = 0;

      foreach(var_4 in level.objectives) {
        if(var_1 istouching(var_4.trigger) && isalive(var_1)) {
          var_2 = scripts\mp\gametypes\obj_dom::getreservedobjid(var_4.objectivekey) + 1;
          break;
        }
      }

      if(!isDefined(var_1.ref_11C62) || var_1.ref_11C62 != var_2) {
        var_1 setmlgthirdpersonenabled(var_2);
        var_1.ref_11C62 = var_2;
        var_1 setgametypevip(1);
      }

      if(var_2 == 0) {
        var_1 setgametypevip(0);
      }
    }

    waitframe();
  }
}