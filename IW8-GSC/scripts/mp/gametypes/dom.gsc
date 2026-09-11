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

  if(level.scoremod["kill"] > 0) {
    game["dialog"]["offense_obj"] = "boost_groundwar";
    game["dialog"]["defense_obj"] = "boost_groundwar";
  }

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var3 = game["attackers"];
    var4 = game["defenders"];
    game["attackers"] = var4;
    game["defenders"] = var3;
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
  var0 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_allies_start");
  var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", var0);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", var1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dom_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dom_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dom_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dom_spawn_secondary", 1, 1);
  var2 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn");
  var3 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("dom", var2);
  scripts\mp\spawnlogic::registerspawnset("dom_fallback", var3);

  if(istrue(level.binoculars_clearuidata)) {
    scripts\mp\spawnlogic::registerspawnset("normal", var2);
    scripts\mp\spawnlogic::registerspawnset("fallback", var3);
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
  var0 = self.pers["team"];
  var1 = getteamdompoints(var0);
  var2 = scripts\mp\utility\game::getotherteam(var0)[0];
  var3 = getteamdompoints(var2);
  var4 = getpreferreddompoints(var1, var3, var0, var2);
  var5 = [];
  GscBinSkip0(0x2e, "preferredDomPoints", var4["preferred"]);
}

function getteamdompoints(var0) {
  var1 = [];

  foreach(var3 in level.objectives) {
    if(var3.ownerteam == var0) {
      var1 = var3;
    }
  }

  return var1;
}

function getpreferreddompoints(var0, var1, var2, var3) {
  var4 = [];

  if(var0.size == level.objectives.size) {
    var5 = level.bestspawnflag[var3];

    foreach(var7 in var0) {
      if(var7 != var5) {
        var4 = var7;
      }
    }
  } else if(var0.size > 0) {
    foreach(var7 in var0) {
      var4 = var7;
    }
  } else if(var0.size == 0) {
    var11 = level.bestspawnflag[var2];

    if(var1.size > 0 && var1.size < level.objectives.size) {
      var11 = scripts\mp\gametypes\obj_dom::getunownedflagneareststart(var2);
    }

    var4 = var11;
  }

  var12 = 0;
  var13 = 0;

  foreach(var7 in var4) {
    if(var7 scripts\mp\gameobjects::getclaimteam() == "none") {
      var12 |= var7.spawnflagid;
      continue;
    }

    var13 |= var7.spawnflagid;
  }

  if(var12 & 1 && var12 & 2) {
    var12 |= 32;
  }

  if(var12 & 4 && var12 & 2) {
    var12 |= 64;
  }

  if(var12 & 1 && var12 & 4) {
    var12 |= 128;
  }

  var16 = [];
  GscBinSkip0(0x2e, "preferred", var12);
}

function domflags() {
  var0 = [];
  level.changenumdomflags = 0;

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    var1 = getEntArray("flag_primary", "targetname");

    foreach(var3 in var1) {
      if(isDefined(var3.script_noteworthy) && var3.script_noteworthy == level.localeid) {
        var0 = var3;
        continue;
      }

      var3 delete();
    }
  } else {
    level.changenumdomflags = getdvarint("scr_dom_flagcount", 0);
    var0 = getEntArray("flag_primary", "targetname");
  }

  var5 = getEntArray("flag_secondary", "targetname");

  if(var0.size + var5.size < 2) {
    return;
  }

  if(level.changenumdomflags == 3) {
    setomnvar("ui_num_dom_flags", level.changenumdomflags);
  } else {
    setomnvar("ui_num_dom_flags", var0.size);
  }

  var6 = [];

  for(var7 = 0; var7 < var0.size; var7++) {
    var6 = var0[var7];
  }

  for(var7 = 0; var7 < var5.size; var7++) {
    var6 = var5[var7];
  }

  if(level.changenumdomflags == 3 || level.mapname == "mp_rust") {
    foreach(var9 in var6) {
      remapdomtriggerscriptlabel(var9);
    }
  }

  foreach(var9 in var6) {
    if(level.changenumdomflags == 3) {
      if(var9.script_label == "_d" || var9.script_label == "_e") {
        continue;
      }
    }

    ref_11ca0(var9);
    var12 = scripts\mp\gametypes\obj_dom::setupobjective(var9, undefined, 1, 1);
    level.objectives[var12.objectivekey] = var12;
  }

  var14 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_axis_start");
  var15 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_allies_start");
  level.startpos["allies"] = var15[0].origin;
  level.startpos["axis"] = var14[0].origin;
  level.bestspawnflag = [];
  level.bestspawnflag["allies"] = scripts\mp\gametypes\obj_dom::getunownedflagneareststart("allies", undefined);
  level.bestspawnflag["axis"] = scripts\mp\gametypes\obj_dom::getunownedflagneareststart("axis", level.bestspawnflag["allies"]);
  flagsetup();
  thread modifieddefendradiussetup();

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level scripts\engine\utility::ref_143a5("prematch_done", "start_mode_setup");
  }

  foreach(var3 in level.objectives) {
    var17 = scripts\mp\gametypes\obj_dom::getreservedobjid(var3.objectivekey);
    var3 scripts\mp\gameobjects::requestid(1, 1, var17);
    var3.onuse = &scripts\mp\gametypes\obj_dom::dompoint_onuse;
    var3.onbeginuse = &scripts\mp\gametypes\obj_dom::dompoint_onusebegin;
    var3.onuseupdate = &scripts\mp\gametypes\obj_dom::dompoint_onuseupdate;
    var3.onenduse = &scripts\mp\gametypes\obj_dom::dompoint_onuseend;
    var3.oncontested = &scripts\mp\gametypes\obj_dom::dompoint_oncontested;
    var3.onuncontested = &scripts\mp\gametypes\obj_dom::dompoint_onuncontested;
    var3.onunoccupied = &scripts\mp\gametypes\obj_dom::dompoint_onunoccupied;
    var3.onpinnedstate = &scripts\mp\gametypes\obj_dom::dompoint_onpinnedstate;
    var3.onunpinnedstate = &scripts\mp\gametypes\obj_dom::dompoint_onunpinnedstate;
    var3.stompprogressreward = &scripts\mp\gametypes\obj_dom::dompoint_stompprogressreward;
    var3 scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");
    var3 scripts\mp\gameobjects::setvisibleteam("any");
    var3 scripts\mp\gametypes\obj_dom::domflag_setneutral(undefined, 1);
  }

  if(level.precappoints) {
    thread scripts\mp\gametypes\obj_dom::precap();
  }

  if(level.codcasterenabled) {
    thread ref_1402b();
    return;
  }
}

function ref_11ca0(var0) {
  switch (level.mapname) {
    case "mp_piccadilly":
      switch (var0.script_label) {
        case "_a":
          var0.origin = (983, 303, 110);
          break;
        case "_b":
          var0.origin = (-1064, -525, 110);
          break;
        case "_c":
          var0.origin = (-1605, -2298, 60);
          break;
      }

      break;
    case "mp_malyshev":
      if(level.ref_11ad3) {
        switch (var0.script_label) {
          case "_a":
            var0.origin = (-520, 632.25, 16);
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
  var0 = undefined;
  var1 = undefined;
  level waittill("prematch_done");

  while(!level.gameended) {
    var2 = 5;
    var3 = scripts\mp\gamelogic::gettimeremaining();

    if(var3 < 5000 && var3 > 0) {
      var2 = var3 / 1000;
    }

    wait var2;
    scripts\mp\hostmigration::waittillhostmigrationdone();
    var4 = getowneddomflags();

    if(!isDefined(level.scoretick)) {
      level.scoretick = [];
    }

    foreach(var6 in level.teamnamelist) {
      level.scoretick[var6] = 0;
    }

    if(var4.size) {
      for(var8 = 1; var8 < var4.size; var8++) {
        var9 = var4[var8];
        var10 = gettime() - var9.capturetime;

        for(var11 = var8 - 1; var11 >= 0 && var10 > gettime() - var4[var11].capturetime; var11--) {
          var4 = var4[var11];
        }

        var4 = var9;
      }

      foreach(var9 in var4) {
        var13 = var9 scripts\mp\gameobjects::getownerteam();
        var0 = getteamscore(var13);
        var14 = scripts\mp\gametypes\obj_dom::getteamflagcount(var13);

        if(var14 >= level.flagsrequiredtoscore) {
          level.scoretick[var13] += level.pointsperflag;
        }
      }
    }

    updatescores();
    checkendgame(var4.size);
  }
}

function updatescores() {
  var0 = [];

  foreach(var2 in level.teamnamelist) {
    var3 = game["teamScores"][var2] + level.scoretick[var2];

    if(var3 >= level.roundscorelimit) {
      var0 = var2;
    }
  }

  if(var0.size == 1) {
    level.scoretick[var0[0]] = level.roundscorelimit - game["teamScores"][var0[0]];
  }

  var5 = scripts\mp\gamescore::freight_lift_door_switch();

  foreach(var2 in level.teamnamelist) {
    if(level.scoretick[var2] > 0) {
      scripts\mp\gamescore::giveteamscoreforobjective(var2, level.scoretick[var2], 1, undefined, 1);
    }
  }

  var8 = scripts\mp\gamescore::freight_lift_door_switch();

  if(var5 != var8) {
    scripts\mp\gamescore::ref_12762(var8, 1, var5);
    return;
  }
}

function checkendgame(var0) {
  var1 = gettime() - level.lastcaptime;

  if(scripts\mp\utility\game::matchmakinggame() && var0 < 2 && var1 > 120000) {
    level.forcedend = 1;
    thread scripts\mp\gamelogic::endgame("none", game["end_reason"]["dom_force_end"]);
    return;
  }

  if(level.objectives.size == 3 && level.playholdtwovo && var1 > 30000) {
    foreach(var3 in level.teamnamelist) {
      if(scripts\mp\gametypes\obj_dom::getteamflagcount(var3) == 2) {
        var4 = scripts\mp\utility\game::getotherteam(var3)[0];
        scripts\mp\utility\dialog::statusdialog("enemy_captured_2", var4);
        scripts\mp\utility\dialog::statusdialog("friendly_captured_2", var3);
        level.playholdtwovo = 0;
        break;
      }
    }

    return;
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

function onnormaldeath(var0, var1, var2, var3, var4, var5) {
  if(level.teamscoresonkill[var1.team]) {
    scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4, var5);
    return;
  }
}

function getowneddomflags() {
  var0 = [];

  foreach(var2 in level.objectives) {
    if(var2 scripts\mp\gameobjects::getownerteam() != "neutral" && isDefined(var2.capturetime)) {
      var0 = var2;
    }
  }

  return var0;
}

function getflagteam() {
  return scripts\mp\gameobjects::getownerteam();
}

function flagsetup() {
  foreach(var1 in level.objectives) {
    var1.spawnflagid = getflagspawnidforobjectivekey(var1.objectivekey);
  }

  var3 = level.spawnpoints;

  foreach(var5 in var3) {
    var5.scriptdata.domflagassignments = getspawnpointflagassignment(var5);
  }
}

function getflagspawnidforobjectivekey(var0) {
  switch (var0) {
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

function getspawnpointflagassignment(var0) {
  if(scripts\cp_mp\utility\game_utility::isarenamap()) {
    if(var0.script_noteworthy == "1" || var0.script_noteworthy == "2" || var0.script_noteworthy == "3") {
      var0.script_noteworthy = "";
    }
  }

  if(isDefined(var0.script_noteworthy) && var0.script_noteworthy != "" && var0.script_noteworthy != "6v6" && var0.script_noteworthy != "10v10") {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      var1 = parseflagassignmentstring(var0.script_noteworthy);

      if(isDefined(var1)) {
        return var1;
      }
    }
  }

  var2 = findnearestdompoint(var0.origin);
  return var2.spawnflagid;
}

function parseflagassignmentstring(var0) {
  var0 = tolower(var0);

  switch (var0) {
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

function findnearestdompoint(var0) {
  var1 = [];

  foreach(var3 in level.objectives) {
    var3.navmeshpos = getclosestpointonnavmesh(var3.trigger.origin);
    var1 = var3.navmeshpos;
  }

  var5 = findclosestnonlospointwithinvolume(var1, getclosestpointonnavmesh(var0));
  var6 = undefined;

  if(!isDefined(var5)) {
    var7 = undefined;

    foreach(var3 in level.objectives) {
      var9 = distancesquared(var3.trigger.origin, var0);

      if(!isDefined(var6) || var9 < var7) {
        var6 = var3;
        var7 = var9;
      }
    }
  } else {
    foreach(var3 in level.objectives) {
      if(distance2dsquared(var3.navmeshpos, var5) < 1) {
        var6 = var3;
        break;
      }
    }
  }

  return var6;
}

function modifieddefendradiussetup() {
  if(level.mapname == "mp_frontier") {
    foreach(var1 in level.objectives) {
      if(var1.objectivekey == "_b") {
        var1.trigger.modifieddefendcheck = 1;
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
  level.usestartspawns = 0;
  var6 = undefined;
  var7 = scripts\mp\utility\game::getotherteam(var3)[0];

  if(scripts\mp\gametypes\obj_dom::getteamflagcount(var3) == level.objectives.size) {
    var6 = "mp_dom_flag_captured_all";
  } else {
    var6 = "mp_dom_flag_captured";
  }

  thread scripts\mp\utility\print::printandsoundoneveryone(var3, var7, undefined, undefined, var6, "mp_dom_flag_lost", var2);

  if(scripts\mp\gametypes\obj_dom::getteamflagcount(var3) < level.objectives.size) {
    scripts\mp\utility\dialog::statusdialog("secured" + self.objectivekey, var3);

    if(isDefined(var4) && var4 == "neutral") {
      if(isDefined(level.objectives) && level.objectives.size == 5 && (self.objectivekey == "_c" || self.objectivekey == "_d") || self.objectivekey == "_b") {
        scripts\mp\utility\dialog::statusdialog("lost" + self.objectivekey, var7);
        return;
      }

      return;
    }

    scripts\mp\utility\dialog::statusdialog("lost" + self.objectivekey, var7);
    return;
  }

  thread scripts\mp\music_and_dialog::dominating_music(var3);
  scripts\mp\utility\dialog::statusdialog("gamestate_domwinning", var3);
  scripts\mp\utility\dialog::statusdialog("gamestate_domlosing", var7);
}

function updatescoremod() {
  wait 1;
  level.onnormaldeath = &onnormaldeath;
  level.teamscoresonkill = [];

  foreach(var1 in level.teamnamelist) {
    level.teamscoresonkill[var1] = 0;
  }

  level.scoremod["kill"] = 1;
}

function removedompoint() {
  self endon("game_ended");

  for(;;) {
    if(getDvar("scr_devRemoveDomFlag", "") != "") {
      var0 = getDvar("scr_devRemoveDomFlag", "");

      foreach(var2 in level.objectives) {
        if(isDefined(var2.objectivekey) && var2.objectivekey == var0) {
          var2 scripts\mp\gameobjects::allowuse("none");
          var2.trigger = undefined;
          var2 notify("deleted");
          var2.visibleteam = "none";
          var2 scripts\mp\gameobjects::setobjectivestatusicons(undefined);
          var3 = [];

          foreach(var5 in level.objectives) {
            if(var5.objectivekey != var0) {
              var3 = var5;
            }
          }

          level.objectives = var3;
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
      var0 = getDvar("scr_devPlaceDomFlag", "");
      var1 = spawnStruct();
      var1.origin = level.players[0].origin;
      var1.angles = level.players[0].angles;
      var2 = spawn("trigger_radius", var1.origin, 0, 120, 128);
      var1.trigger = var2;
      var1.trigger.script_label = var0;
      var1.ownerteam = "neutral";
      var3 = var1.origin + (0, 0, 32);
      var4 = var1.origin + (0, 0, -32);
      var5 = scripts\engine\trace::ray_trace(var3, var4, undefined, scripts\engine\trace::create_default_contents(1));
      var1.origin = var5["position"];
      var1.upangles = vectortoangles(var5["normal"]);
      var1.forward = anglesToForward(var1.upangles);
      var1.right = anglestoright(var1.upangles);
      var1.visuals[0] = spawn("script_model", var1.origin);
      var1.visuals[0].angles = var1.angles;
      var6 = scripts\mp\gameobjects::createuseobject("neutral", var1.trigger, var1.visuals, (0, 0, 100));
      var6 scripts\mp\gameobjects::allowuse("enemy");
      var6 scripts\mp\gameobjects::setusetime(10);

      if(isDefined(var2.objectivekey)) {
        var6.objectivekey = var2.objectivekey;
      } else {
        var6.objectivekey = var6 scripts\mp\gameobjects::getlabel();
      }

      if(isDefined(var2.iconname)) {
        var6.iconname = var2.iconname;
      } else {
        var6.iconname = var6 scripts\mp\gameobjects::getlabel();
      }

      var6 scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconneutral);
      var6 scripts\mp\gameobjects::setvisibleteam("any");
      var6.onuse = &scripts\mp\gametypes\obj_dom::dompoint_onuse;
      var6.onbeginuse = &scripts\mp\gametypes\obj_dom::dompoint_onusebegin;
      var6.onuseupdate = &scripts\mp\gametypes\obj_dom::dompoint_onuseupdate;
      var6.onenduse = &scripts\mp\gametypes\obj_dom::dompoint_onuseend;
      var6.nousebar = 1;
      var6.id = "domFlag";
      var6.firstcapture = 1;
      var6.claimgracetime = 10000;
      var6.decayrate = 50;
      var3 = var1.visuals[0].origin + (0, 0, 32);
      var4 = var1.visuals[0].origin + (0, 0, -32);
      var7 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
      var8 = [];
      var5 = scripts\engine\trace::ray_trace(var3, var4, var8, var7);
      var6.baseeffectpos = var5["position"];
      var9 = vectortoangles(var5["normal"]);
      var6.baseeffectforward = anglesToForward(var9);
      var6 scripts\mp\gametypes\obj_dom::initializematchrecording();
      var6 thread scripts\mp\gametypes\obj_dom::domflag_setneutral();
      level.objectives[var6.objectivekey] = var6;
      setdynamicdvar("scr_devPlaceDomFlag", "");
    }

    wait 1;
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

function updatematchstatushintonspawn() {
  level endon("game_ended");
  self setclientomnvar("ui_match_status_hint_text", 27);
}

function ref_1402b() {
  level endon("game_ended");
  level waittill("prematch_done");

  while(!level.gameended) {
    foreach(var1 in level.players) {
      var2 = 0;

      foreach(var4 in level.objectives) {
        if(var1 istouching(var4.trigger) && isalive(var1)) {
          var2 = scripts\mp\gametypes\obj_dom::getreservedobjid(var4.objectivekey) + 1;
          break;
        }
      }

      if(!isDefined(var1.ref_11c62) || var1.ref_11c62 != var2) {
        var1 setmlgthirdpersonenabled(var2);
        var1.ref_11c62 = var2;
        var1 setgametypevip(1);
      }

      if(var2 == 0) {
        var1 setgametypevip(0);
      }
    }

    waitframe();
  }
}