/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\mtmc.gsc
***********************************************/

function main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, "mtmc");
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_mtmc_flagCaptureTime", getmatchrulesdata("domData", "flagCaptureTime"));
  setdynamicdvar("scr_mtmc_flagNeutralization", getmatchrulesdata("domData", "flagNeutralization"));
  setdynamicdvar("scr_mtmc_objScalar", getmatchrulesdata("domData", "objScalar"));
  setdynamicdvar("scr_mtmc_preCapPoints", getmatchrulesdata("siegeData", "preCapPoints"));
  setdynamicdvar("scr_mtmc_captureType", getmatchrulesdata("captureData", "captureType"));
  setdynamicdvar("scr_mtmc_captureDecay", getmatchrulesdata("captureData", "captureDecay"));
  setdynamicdvar("scr_mtmc_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("mtmc", 0);
}

function seticonnames() {
  level.iconneutral = "waypoint_captureneutral";
  level.iconcapture = "waypoint_capture";
  level.icondefend = "waypoint_defend";
  level.iconcontested = "waypoint_contested";
  level.icontaking = "waypoint_taking";
  level.iconlosing = "waypoint_losing";
  level.icontarget = "icon_waypoint_target";
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

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(!isDefined(game["remainingTeams"])) {
    game["remainingTeams"] = level.teamnamelist;
  }

  initspawns();
  thread setupflags();
  thread startgame();
}

function startgame() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  wait 15;

  foreach(var_1 in level.objectives) {
    var_1 scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    var_1 scripts\mp\gameobjects::enableobject();
    var_1 scripts\mp\gameobjects::setvisibleteam("any");
    var_1 scripts\mp\gameobjects::allowuse("any");
  }
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("flagCaptureTime", 30, 0, 30);
  level.flagneutralization = scripts\mp\utility\dvars::dvarintvalue("flagNeutralization", 0, 0, 1);
  level.precappoints = scripts\mp\utility\dvars::dvarintvalue("preCapPoints", 0, 0, 1);
  level.capturedecay = scripts\mp\utility\dvars::dvarintvalue("captureDecay", 1, 0, 1);
  level.capturetype = scripts\mp\utility\dvars::dvarintvalue("captureType", 1, 0, 3);
  level.objectivescaler = scripts\mp\utility\dvars::dvarfloatvalue("objScalar", 4, 1, 10);
}

function initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("MTMC", "Crit_Default");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_mtmc_spawn_start");

  foreach(var_2 in game["remainingTeams"]) {
    scripts\mp\spawnlogic::registerspawnpoints(var_2, var_0);
  }

  level.startlocations = [];

  foreach(var_5 in var_0) {
    if(!isDefined(var_5.target) || var_5.target == "") {
      continue;
    }

    if(!isDefined(var_5.script_noteworthy) || var_5.script_noteworthy == "") {}

    if(int(var_5.script_noteworthy) != game["remainingTeams"].size) {
      continue;
    }

    var_6 = level.startlocations[var_5.target];

    if(isDefined(var_6)) {
      var_6.spawnpoints[var_6.spawnpoints.size] = var_5;
      continue;
    }

    var_7 = scripts\engine\utility::getStruct(var_5.target, "targetname");
    var_8 = spawnStruct();
    var_8.origin = var_7.origin;
    var_8.angles = var_7.angles;
    var_8.spawnpoints = [];
    var_8.spawnpoints[0] = var_5;
    var_8.inuse = 0;
    level.startlocations[var_5.target] = var_8;
  }

  foreach(var_6 in level.startlocations) {
    scripts\mp\spawnlogic::registerspawnset(var_11, var_6.spawnpoints);
    scripts\mp\spawnlogic::activatespawnset(var_11);
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
  scripts\mp\spawnlogic::deactivateallspawnsets();

  if(!isDefined(level.teamspawnlocations)) {
    level.teamspawnlocations = [];
  }

  var_0 = level.teamspawnlocations[self.team];

  if(isDefined(var_0)) {
    scripts\mp\spawnlogic::activatespawnset(var_0);
    var_1 = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "bad");
    return var_1;
  }

  foreach(var_1, var_3 in level.startlocations) {
    if(var_3.inuse) {
      continue;
    }

    scripts\mp\spawnlogic::activatespawnset(var_1);
  }

  var_1 = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "bad");
  level.startlocations[var_1.target].inuse = 1;
  level.teamspawnlocations[self.team] = var_1.target;
  return var_1;
}

function setupflags() {
  var_0 = getEntArray("mtmc_dom", "targetname");

  if(!var_0.size) {
    return;
  }

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.script_noteworthy) || var_2.script_noteworthy == "") {}

    if(int(var_2.script_noteworthy) != game["remainingTeams"].size) {
      continue;
    }

    var_3 = scripts\mp\gametypes\obj_dom::setupobjective(var_2, 1);
    var_3 scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
    var_3 scripts\mp\gameobjects::disableobject();
    var_3 scripts\mp\gameobjects::setvisibleteam("any");
    var_3 scripts\mp\gameobjects::allowuse("none");
    level.objectives[var_3.objectivekey] = var_3;
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

function onspawnplayer() {}

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
  scripts\mp\utility\dialog::statusdialog("secured" + self.objectivekey, var_3, 1);
  var_6 = scripts\mp\utility\game::getotherteam(var_3);

  foreach(var_8 in var_6) {
    scripts\mp\utility\dialog::statusdialog("lost_" + self.objectivekey, var_8, 1);
  }

  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::allowuse("none");

  if(isDefined(self.flagmodel)) {
    self.flagmodel hide();
  }

  if(!isDefined(level.remainingflags)) {
    level.remainingflags = level.objectives.size;
  }

  level.remainingflags--;

  if(level.remainingflags == 0) {
    setremainingteams();
    return;
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

function ondeadevent(var_0) {
  if(var_0 == "all") {
    setremainingteams();
    return;
  }

  var_1 = scripts\mp\utility\teams::getenemyteams(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    var_2 = 0;
  }

  if(!istrue(level.disablespawning)) {
    foreach(var_4 in var_1) {
      foreach(var_8 in scripts\mp\utility\teams::getteamdata(var_4, "players")) {
        if(!istrue(var_8.hasspawned)) {
          continue;
        }

        var_2 = var_2[var_4] + var_8.pers["lives"];
      }
    }
  }

  var_11 = [];

  foreach(var_4 in var_1) {
    if(scripts\mp\utility\teams::getteamdata(var_4, "aliveCount") || var_2[var_4]) {
      var_11 = var_4;
    }
  }

  if(var_11.size == 1) {
    setremainingteams(var_11[0]);
    return;
  }
}

function setremainingteams(var_0) {
  if(istrue(level.remainingteamsset)) {
    return;
  }

  level.remainingteamsset = 1;
  game["remainingTeams"] = [];

  foreach(var_2 in level.objectives) {
    if(var_2.ownerteam == "neutral") {
      continue;
    }

    if(!scripts\engine\utility::array_contains(game["remainingTeams"], var_2.ownerteam)) {
      game["remainingTeams"][game["remainingTeams"].size] = var_2.ownerteam;
    }
  }

  if(isDefined(var_0) && !scripts\engine\utility::array_contains(game["remainingTeams"], var_0) && game["remainingTeams"].size < level.objectives.size) {
    game["remainingTeams"][game["remainingTeams"].size] = var_0;
  }

  foreach(var_5 in level.players) {
    if(scripts\engine\utility::array_contains(level.teamnamelist, var_5.team)) {
      if(!scripts\engine\utility::array_contains(game["remainingTeams"], var_5.team)) {
        var_5 scripts\mp\menus::addtoteam("spectator");
      }
    }
  }

  if(game["remainingTeams"].size == 1) {
    scripts\mp\gamescore::giveteamscoreforobjective(game["remainingTeams"][0], 1, 0);
    thread scripts\mp\gamelogic::endgame(game["remainingTeams"][0], game["end_reason"]["enemies_eliminated"]);
    return;
  }

  thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["objective_completed"]);
}