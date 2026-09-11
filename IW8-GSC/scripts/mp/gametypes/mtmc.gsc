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

  foreach(var1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var1, &"OBJECTIVES/DOM");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var1, &"OBJECTIVES/DOM");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var1, &"OBJECTIVES/DOM_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var1, &"OBJECTIVES/DOM_HINT");
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

  foreach(var1 in level.objectives) {
    var1 scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    var1 scripts\mp\gameobjects::enableobject();
    var1 scripts\mp\gameobjects::setvisibleteam("any");
    var1 scripts\mp\gameobjects::allowuse("any");
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
  var0 = scripts\mp\spawnlogic::getspawnpointarray("mp_mtmc_spawn_start");

  foreach(var2 in game["remainingTeams"]) {
    scripts\mp\spawnlogic::registerspawnpoints(var2, var0);
  }

  level.startlocations = [];

  foreach(var5 in var0) {
    if(!isDefined(var5.target) || var5.target == "") {
      continue;
    }

    if(!isDefined(var5.script_noteworthy) || var5.script_noteworthy == "") {}

    if(int(var5.script_noteworthy) != game["remainingTeams"].size) {
      continue;
    }

    var6 = level.startlocations[var5.target];

    if(isDefined(var6)) {
      var6.spawnpoints[var6.spawnpoints.size] = var5;
      continue;
    }

    var7 = scripts\engine\utility::getStruct(var5.target, "targetname");
    var8 = spawnStruct();
    var8.origin = var7.origin;
    var8.angles = var7.angles;
    var8.spawnpoints = [];
    var8.spawnpoints[0] = var5;
    var8.inuse = 0;
    level.startlocations[var5.target] = var8;
  }

  foreach(var6 in level.startlocations) {
    scripts\mp\spawnlogic::registerspawnset(var11, var6.spawnpoints);
    scripts\mp\spawnlogic::activatespawnset(var11);
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
  scripts\mp\spawnlogic::deactivateallspawnsets();

  if(!isDefined(level.teamspawnlocations)) {
    level.teamspawnlocations = [];
  }

  var0 = level.teamspawnlocations[self.team];

  if(isDefined(var0)) {
    scripts\mp\spawnlogic::activatespawnset(var0);
    var1 = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "bad");
    return var1;
  }

  foreach(var1, var3 in level.startlocations) {
    if(var3.inuse) {
      continue;
    }

    scripts\mp\spawnlogic::activatespawnset(var1);
  }

  var1 = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "bad");
  level.startlocations[var1.target].inuse = 1;
  level.teamspawnlocations[self.team] = var1.target;
  return var1;
}

function setupflags() {
  var0 = getEntArray("mtmc_dom", "targetname");

  if(!var0.size) {
    return;
  }

  foreach(var2 in var0) {
    if(!isDefined(var2.script_noteworthy) || var2.script_noteworthy == "") {}

    if(int(var2.script_noteworthy) != game["remainingTeams"].size) {
      continue;
    }

    var3 = scripts\mp\gametypes\obj_dom::setupobjective(var2, 1);
    var3 scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
    var3 scripts\mp\gameobjects::disableobject();
    var3 scripts\mp\gameobjects::setvisibleteam("any");
    var3 scripts\mp\gameobjects::allowuse("none");
    level.objectives[var3.objectivekey] = var3;
  }
}

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isPlayer(var1) || var1.team == self.team) {
    return;
  }

  if(isDefined(var4) && scripts\mp\utility\weapon::iskillstreakweapon(var4.basename)) {
    return;
  }

  scripts\mp\gametypes\obj_dom::awardgenericmedals(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
}

function onspawnplayer() {}

function onplayerconnect(var0) {
  var0.ui_dom_securing = undefined;
  var0.ui_dom_stalemate = undefined;
  thread onplayerspawned();
}

function onplayerspawned(var0) {
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

function onflagcapture(var0, var1, var2, var3, var4, var5) {
  scripts\mp\utility\dialog::statusdialog("secured" + self.objectivekey, var3, 1);
  var6 = scripts\mp\utility\game::getotherteam(var3);

  foreach(var8 in var6) {
    scripts\mp\utility\dialog::statusdialog("lost_" + self.objectivekey, var8, 1);
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
  var0 = self getEye();
  var1 = self getplayerangles();
  var2 = anglesToForward(var1);
  var3 = cos(10);
  var4 = 250000;
  var5 = undefined;
  var6 = undefined;
  var7 = undefined;
  var8 = undefined;
  var9 = undefined;

  foreach(var11 in level.objectives) {
    var12 = vectorNormalize(var11.trigger.origin - var0);
    var13 = vectordot(var2, var12);
    var14 = distancesquared(var11.trigger.origin, var0);

    if(!isDefined(var5) || var5 < var13) {
      var5 = var13;
      var7 = var14;
      var6 = var11;
    }

    if(!isDefined(var8) || var8 > var14) {
      var8 = var14;
      var9 = var11;
    }
  }

  var11 = undefined;
  var16 = undefined;
  var17 = undefined;

  if(isDefined(var5) && var5 > var3) {
    var11 = var6;
    var18 = getsubstr(var11.objectivekey, 1, 2);

    if(var11.ownerteam == "neutral") {
      var16 = self.name + ": Capture " + var18 + "!";
      var17 = "capture";
    } else if(var11.ownerteam == self.team) {
      var16 = self.name + ": Defend" + var18 + "!";
      var17 = "defend";
    } else {
      var16 = self.name + ": Assault " + var18 + "!";
      var17 = "assault";
    }
  } else if(isDefined(var8) && var8 < var4) {
    var11 = var9;
    var18 = getsubstr(var11.objectivekey, 1, 2);

    if(var11.ownerteam == "neutral") {
      var16 = self.name + ": Capture " + var18 + "!";
      var17 = "capture";
    } else if(var11.ownerteam == self.team) {
      var16 = self.name + ": Defend" + var18 + "!";
      var17 = "defend";
    } else {
      var16 = self.name + ": Assault " + var18 + "!";
      var17 = "assault";
    }
  }

  if(isDefined(var11)) {
    thread scripts\cp_mp\gestures::applygamemodecallout(var11, var16, var17);
  }

  return isDefined(var11);
}

function verifygamemodecallout(var0, var1) {
  var2 = 0;

  switch (var0) {
    case "capture":
      if(var1.team == self.team) {
        var2 = 1;
      }

      break;
    case "defend":
      if(var1.team == self.team) {
        var2 = 1;
      }

      break;
    case "assault":
      if(var1.team == self.team) {
        var2 = 1;
      }

      break;
  }

  return var2;
}

function ondeadevent(var0) {
  if(var0 == "all") {
    setremainingteams();
    return;
  }

  var1 = scripts\mp\utility\teams::getenemyteams(var0);
  var2 = [];

  foreach(var4 in var1) {
    var2 = 0;
  }

  if(!istrue(level.disablespawning)) {
    foreach(var4 in var1) {
      foreach(var8 in scripts\mp\utility\teams::getteamdata(var4, "players")) {
        if(!istrue(var8.hasspawned)) {
          continue;
        }

        var2 = var2[var4] + var8.pers["lives"];
      }
    }
  }

  var11 = [];

  foreach(var4 in var1) {
    if(scripts\mp\utility\teams::getteamdata(var4, "aliveCount") || var2[var4]) {
      var11 = var4;
    }
  }

  if(var11.size == 1) {
    setremainingteams(var11[0]);
    return;
  }
}

function setremainingteams(var0) {
  if(istrue(level.remainingteamsset)) {
    return;
  }

  level.remainingteamsset = 1;
  game["remainingTeams"] = [];

  foreach(var2 in level.objectives) {
    if(var2.ownerteam == "neutral") {
      continue;
    }

    if(!scripts\engine\utility::array_contains(game["remainingTeams"], var2.ownerteam)) {
      game["remainingTeams"][game["remainingTeams"].size] = var2.ownerteam;
    }
  }

  if(isDefined(var0) && !scripts\engine\utility::array_contains(game["remainingTeams"], var0) && game["remainingTeams"].size < level.objectives.size) {
    game["remainingTeams"][game["remainingTeams"].size] = var0;
  }

  foreach(var5 in level.players) {
    if(scripts\engine\utility::array_contains(level.teamnamelist, var5.team)) {
      if(!scripts\engine\utility::array_contains(game["remainingTeams"], var5.team)) {
        var5 scripts\mp\menus::addtoteam("spectator");
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