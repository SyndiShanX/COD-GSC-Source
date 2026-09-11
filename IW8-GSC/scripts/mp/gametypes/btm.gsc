/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\btm.gsc
***********************************************/

function main() {
  var_0 = spawnStruct();
  level.btm = var_0;

  if(getDvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_btm_zoneLifetime", getmatchrulesdata("kothData", "zoneLifetime"));
  setdynamicdvar("scr_btm_zoneCaptureTime", getmatchrulesdata("kothData", "zoneCaptureTime"));
  setdynamicdvar("scr_btm_zoneActivationDelay", getmatchrulesdata("kothData", "zoneActivationDelay"));
  setdynamicdvar("scr_btm_randomLocationOrder", getmatchrulesdata("kothData", "randomLocationOrder"));
  setdynamicdvar("scr_btm_additiveScoring", getmatchrulesdata("kothData", "additiveScoring"));
  setdynamicdvar("scr_btm_pauseTime", getmatchrulesdata("kothData", "pauseTime"));
  setdynamicdvar("scr_btm_delayPlayer", getmatchrulesdata("kothData", "delayPlayer"));
  setdynamicdvar("scr_btm_useHQRules", getmatchrulesdata("kothData", "useHQRules"));
  setdynamicdvar("scr_btm_spawndelay", getmatchrulesdata("tdefData", "spawnDelay"));
  setdynamicdvar("scr_btm_juggHealth", getmatchrulesdata("btmData", "juggHealth"));
  setdynamicdvar("scr_btm_juggswitchtime", getmatchrulesdata("btmData", "juggSwitchTime"));
  setdynamicdvar("scr_btm_ppkasjugg", getmatchrulesdata("btmData", "ppkAsJugg"));
  setdynamicdvar("scr_btm_ppkonjugg", getmatchrulesdata("btmData", "ppkOnJugg"));
  setdynamicdvar("scr_btm_ppkjuggonjugg", getmatchrulesdata("btmData", "ppkJuggOnJugg"));
  setdynamicdvar("scr_koth_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("koth", 0);
}

function onstartgametype() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  level._effect["bomb_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");

  foreach(var_3 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_3, &"OBJECTIVES/KOTH");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"OBJECTIVES/KOTH");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"OBJECTIVES/KOTH_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var_3, &"OBJECTIVES/KOTH_HINT");
  }

  setclientnamemode("auto_change");
  level.objectives = [];
  thread objectiveselectorsetup();
  setupradios();
  setupbtmflags();
  thread dommainloop();
  thread hqmainloop();
  thread waittospawnvip();
  thread waittospawnjuggcrate();
  thread waittospawnbtmbombs();
  setmapsizespawnconsts();
  initspawns();
  seticonnames();
  setupwaypointicons();
  level.usedomflag = 0;
  setomnvar("ui_btm_timer", 0);
  setomnvar("ui_btm_status", -1);
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.zoneduration = scripts\mp\utility\dvars::dvarfloatvalue("zoneLifetime", 60, 0, 300);
  level.zonecapturetime = scripts\mp\utility\dvars::dvarfloatvalue("zoneCaptureTime", 0, 0, 30);
  level.zoneactivationdelay = 30;
  level.zonerandomlocationorder = scripts\mp\utility\dvars::dvarintvalue("randomLocationOrder", 0, 0, 1);
  level.zoneadditivescoring = scripts\mp\utility\dvars::dvarintvalue("additiveScoring", 0, 0, 1);
  level.pausescoring = scripts\mp\utility\dvars::dvarintvalue("pauseTime", 1, 0, 1);
  level.delayplayer = scripts\mp\utility\dvars::dvarintvalue("delayPlayer", 1, 0, 1);
  level.spawndelay = scripts\mp\utility\dvars::dvarfloatvalue("spawnDelay", 5, 0, 30);
  level.usehqrules = 1;
  level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("flagCaptureTime", 10, 0, 30);
  level.flagsrequiredtoscore = scripts\mp\utility\dvars::dvarintvalue("flagsRequiredToScore", 1, 1, 3);
  level.pointsperflag = scripts\mp\utility\dvars::dvarintvalue("pointsPerFlag", 10, 1, 300);
  level.flagneutralization = scripts\mp\utility\dvars::dvarintvalue("flagNeutralization", 0, 0, 1);
  level.precappoints = scripts\mp\utility\dvars::dvarintvalue("preCapPoints", 0, 0, 1);
  level.capturedecay = scripts\mp\utility\dvars::dvarintvalue("captureDecay", 1, 0, 1);
  level.capturetype = scripts\mp\utility\dvars::dvarintvalue("captureType", 1, 0, 3);
  level.numflagsscoreonkill = scripts\mp\utility\dvars::dvarintvalue("numFlagsScoreOnKill", 0, 0, 3);
  level.objectivescaler = scripts\mp\utility\dvars::dvarfloatvalue("objScalar", 4, 1, 10);
  level.jugghealth = scripts\mp\utility\dvars::dvarintvalue("juggHealth", 1000, 1000, 10000);
  level.juggswitchtime = scripts\mp\utility\dvars::dvarfloatvalue("juggSwitchTime", 60, 10, 180);
  level.ppkasjugg = scripts\mp\utility\dvars::dvarintvalue("ppkAsJugg", 20, 1, 100);
  level.ppkonjugg = scripts\mp\utility\dvars::dvarintvalue("ppkOnJugg", 50, 1, 100);
  level.ppkjuggonjugg = scripts\mp\utility\dvars::dvarintvalue("ppkJuggOnJugg", 50, 1, 100);
}

function setmapsizespawnconsts() {
  var_0 = getsubstr(level.mapname, 0, 7);

  switch (var_0) {
    case "mp_vill":
    case "mp_offs":
    case "mp_dome":
    case "mp_cras":
    case "mp_hack":
    case "mp_cave":
      level.spawn_deadzone_dist = 1000;
      level.close_spawn_min_dist_sq = 10000;
      level.max_spawn_dist_sq = 25000000;
      level.max_relevant_spawn_dist = 6000;
      level.enemy_spawn_influence_dist_sq = 12250000;
      break;
    default:
      level.spawn_deadzone_dist = 1000;
      level.close_spawn_min_dist_sq = 10000;
      level.max_spawn_dist_sq = 225000000;
      level.max_relevant_spawn_dist = 5000;
      level.enemy_spawn_influence_dist_sq = 12250000;
      break;
  }
}

function initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::registerspawnset("normal", "mp_tdm_spawn");
  scripts\mp\spawnlogic::registerspawnset("fallback", "mp_tdm_spawn_secondary");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  enablespawnpointbyindex("mp_tdm_spawn");
  level.spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");

  if(!level.spawnpoints.size) {
    return;
  }

  foreach(var_1 in level.objectives) {
    var_1.furthestspawndistsq = 0;
    var_1.spawnpoints = [];
    var_1.fallbackspawnpoints = [];
  }

  foreach(var_4 in level.spawnpoints) {
    calculatespawndisttozones(var_4);
    var_5 = scripts\mp\spawnlogic::getoriginidentifierstring(var_4);

    if(isDefined(level.btmextraprimaryspawnpoints) && isDefined(level.btmextraprimaryspawnpoints[var_5])) {
      foreach(var_7 in level.btmextraprimaryspawnpoints[var_5]) {
        var_1 = level.objectives[var_7];
        var_1.spawnpoints[var_1.spawnpoints.size] = var_4;
      }
    }

    var_9 = 0;
    var_10 = var_4.classname == "mp_tdm_spawn";
    var_11 = var_4.classname == "mp_tdm_spawn_secondary";

    if(var_10 || var_11) {
      if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy != "") {
        var_9 = 1;
        var_12 = strtok(var_4.script_noteworthy, " ");

        foreach(var_7 in var_12) {
          var_1 = level.objectives[var_7];

          if(var_10) {
            var_1.spawnpoints[var_1.spawnpoints.size] = var_4;
            continue;
          }

          var_1.fallbackspawnpoints[var_1.fallbackspawnpoints.size] = var_4;
        }
      }
    }

    if(!var_9) {
      foreach(var_1 in level.objectives) {
        if(var_4.scriptdata.distsqtokothzones[var_1 getentitynumber()] < level.close_spawn_min_dist_sq || var_4.scriptdata.distsqtokothzones[var_1 getentitynumber()] > level.max_spawn_dist_sq) {
          var_1.removespawn = 1;
        }

        if(var_10) {
          if(!isDefined(var_1.removespawn)) {
            var_1.spawnpoints[var_1.spawnpoints.size] = var_4;
          }

          continue;
        }

        var_1.fallbackspawnpoints[var_1.fallbackspawnpoints.size] = var_4;
      }
    }
  }

  foreach(var_1 in level.objectives) {
    var_1.spawnset = "btm_" + var_19;
    scripts\mp\spawnlogic::registerspawnset(var_1.spawnset, var_1.spawnpoints);
    var_1.fallbackspawnset = "btm_fallback_" + var_19;
    scripts\mp\spawnlogic::registerspawnset(var_1.fallbackspawnset, var_1.fallbackspawnpoints);
  }
}

function calculatespawndisttozones(var_0) {
  var_0.scriptdata.distsqtokothzones = [];

  foreach(var_2 in level.objectives) {
    var_3 = getpathdist(var_0.origin, var_2.origin, level.max_relevant_spawn_dist);

    if(var_3 < 0) {
      var_3 = scripts\engine\utility::distance_2d_squared(var_0.origin, var_2.origin);
    } else {
      var_3 *= var_3;
    }

    var_0.scriptdata.distsqtokothzones[var_2 getentitynumber()] = var_3;

    if(var_3 > var_2.furthestspawndistsq) {
      var_2.furthestspawndistsq = var_3;
    }
  }
}

function setupradios() {
  var_0 = [];
  var_1 = getEntArray("hq_hardpoint", "targetname");

  if(var_1.size < 2) {
    var_0 = "There are not at least 2 entities with targetname \"radio\"";
  }

  var_2 = getEntArray("radiotrigger", "targetname");

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = 0;
    var_5 = var_1[var_3];
    var_5.trig = undefined;

    for(var_6 = 0; var_6 < var_2.size; var_6++) {
      if(var_5 istouching(var_2[var_6])) {
        if(isDefined(var_5.trig)) {
          var_0 = "Radio at " + var_5.origin + " is touching more than one \"radiotrigger\" trigger";
          var_4 = 1;
          break;
        }

        var_5.trig = var_2[var_6];
        break;
      }
    }

    if(!isDefined(var_5.trig)) {
      if(!var_4) {
        var_0 = "Radio at " + var_5.origin + " is not inside any \"radiotrigger\" trigger";
      }

      var_5.trig = spawn("trigger_radius", var_5.origin, 0, 128, 128);
      var_4 = 0;
    }

    var_5.trigorigin = var_5.trig.origin;
    var_7 = [];
    var_7 = var_5;
    var_8 = getEntArray(var_5.target, "targetname");

    for(var_6 = 0; var_6 < var_8.size; var_6++) {
      var_7 = var_8[var_6];
    }

    var_5.visuals = var_7;
    var_5 scripts\mp\gameobjects::setmodelvisibility(0);
    var_5.gameobject = scripts\mp\gameobjects::createuseobject("neutral", var_5.trig, var_5.visuals, var_5.origin - var_5.trigorigin + (0, 0, 60));
    var_5.gameobject scripts\mp\gameobjects::disableobject();
    var_5.gameobject scripts\mp\gameobjects::setmodelvisibility(0);
    var_5.trig.useobj = var_5.gameobject;
  }

  if(var_0.size > 0) {
    for(var_3 = 0; var_3 < var_0.size; var_3++) {}
  }

  foreach(var_10 in var_1) {
    level.objectives[level.objectives.size] = var_10;
  }

  level.radios = var_1;
  level.radios2 = var_1;
  level.prevradio = undefined;
  level.prevradio2 = undefined;
  return true;
}

function setupbtmflags() {
  var_0 = getEntArray("btm_flag_primary", "targetname");

  if(var_0.size == 0) {
    var_1 = getEntArray("flag_primary", "targetname");
    var_2 = getEntArray("flag_secondary", "targetname");

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      level.primaryflags[level.primaryflags.size] = var_1[var_3];
    }

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      level.primaryflags[level.primaryflags.size] = var_2[var_3];
    }

    thread runnormaldomflags(level, var_1);
  } else {
    level.primaryflags = var_0;
    level.primaryflags2 = var_0;
    level.prevflag = undefined;
    level.prevflag2 = undefined;
    thread runbtmflags();
  }

  foreach(var_5 in level.primaryflags) {
    level.objectives[level.objectives.size] = var_5;
  }
}

function dommainloop() {
  level endon("game_ended");
  thread updatedomscores();
}

function runbtmflags() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    level waittill("spawn_btm_dom");
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 0, 0);
    scripts\mp\spawnlogic::setactivespawnlogic("Hardpoint", "Crit_Default");
    var_0 = pickflagtospawn();
    var_0.script_label = "_a";
    var_1 = "_a";
    var_2 = scripts\mp\gametypes\obj_dom::setupobjective(var_0);
    var_2.origin = var_0.origin;
    var_2 scripts\mp\gameobjects::allowuse("none");
    var_2 scripts\mp\gameobjects::setvisibleteam("any");
    var_2 scripts\mp\gameobjects::setobjectivestatusicons(level.iconlocked);
    var_2.ignorestomp = 1;
    level.btmflagobject = var_2;
    setomnvar("ui_btm_timer", int(30000 + gettime()));
    setomnvar("ui_btm_status", 2);
    scripts\mp\utility\sound::playsoundonplayers("ui_aar_sidebar");
    wait 30;
    scripts\mp\utility\sound::playsoundonplayers("iw8_new_objective_sfx");

    foreach(var_4 in level.teamnamelist) {
      scripts\mp\utility\dialog::leaderdialog("obj_capture", var_4);

      if(scripts\mp\utility\teams::getteamdata(var_4, "teamCount") > 0) {
        scripts\mp\utility\print::teamhudtutorialmessage("OBJECTIVES/CAPTURE_FLAG", var_4, 4);
      }
    }

    level.btmflagobject scripts\mp\gameobjects::allowuse("enemy");
    level.btmflagobject scripts\mp\gametypes\obj_dom::domflag_setneutral();
    setomnvar("ui_btm_timer", int(60000 + gettime()));
    setomnvar("ui_btm_status", 3);
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 14, 14);
    wait 60;
    scripts\mp\utility\sound::playsoundonplayers("mp_sar_enemy_eliminated");

    foreach(var_4 in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamdata(var_4, "teamCount") > 0) {
        scripts\mp\utility\print::teamhudtutorialmessage("OBJECTIVES/OBJ_OFFLINE", var_4, 4);
      }
    }

    level.btmflagobject scripts\mp\gametypes\obj_dom::domflag_setneutral();
    removedompoint(level, var_1);
    level.btmflagobject = undefined;
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
    getnextobjective(level, "dom");
  }
}

function runnormaldomflags(var_0, var_1) {
  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    level waittill("spawn_btm_dom");
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 0, 0);

    switch (level.usedomflag) {
      case 0:
        var_2 = "_b";
        break;
      case 1:
        var_2 = "_a";
        break;
      case 2:
        var_2 = "_c";
        break;
      default:
        var_2 = "_b";
        break;
    }

    scripts\mp\spawnlogic::setactivespawnlogic("Hardpoint", "Crit_Default");
    var_3 = [];

    for(var_4 = 0; var_4 < var_0.size; var_4++) {
      var_3 = var_0[var_4];
    }

    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      var_3 = var_1[var_4];
    }

    foreach(var_6 in var_3) {
      if(var_6.script_label == var_2) {
        var_7 = scripts\mp\gametypes\obj_dom::setupobjective(var_6);
        var_7 scripts\mp\gameobjects::allowuse("none");
        var_7 scripts\mp\gameobjects::setvisibleteam("any");
        var_7 scripts\mp\gameobjects::setobjectivestatusicons(level.iconlocked);
        var_7.ignorestomp = 1;
        level.btmflagobject = var_7;
        break;
      }
    }

    setomnvar("ui_btm_timer", int(30000 + gettime()));
    setomnvar("ui_btm_status", 2);
    scripts\mp\utility\sound::playsoundonplayers("ui_aar_sidebar");
    wait 30;
    scripts\mp\utility\sound::playsoundonplayers("iw8_new_objective_sfx");

    foreach(var_10 in level.teamnamelist) {
      scripts\mp\utility\dialog::leaderdialog("obj_capture", var_10);

      if(scripts\mp\utility\teams::getteamdata(var_10, "teamCount") > 0) {
        scripts\mp\utility\print::teamhudtutorialmessage("OBJECTIVES/CAPTURE_FLAG", var_10, 4);
      }
    }

    level.btmflagobject scripts\mp\gameobjects::allowuse("enemy");
    level.btmflagobject scripts\mp\gametypes\obj_dom::domflag_setneutral();
    setomnvar("ui_btm_timer", int(60000 + gettime()));
    setomnvar("ui_btm_status", 3);
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 14, 14);
    wait 60;
    scripts\mp\utility\sound::playsoundonplayers("mp_sar_enemy_eliminated");

    foreach(var_10 in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamdata(var_10, "teamCount") > 0) {
        scripts\mp\utility\print::teamhudtutorialmessage("OBJECTIVES/OBJ_OFFLINE", var_10, 4);
      }
    }

    level.btmflagobject scripts\mp\gametypes\obj_dom::domflag_setneutral();
    removedompoint(level, var_2);
    level.btmflagobject = undefined;
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
    getnextobjective(level, "dom");
  }
}

function updatedomscores() {
  level endon("game_ended");
  level waittill("spawn_btm_dom");
  var_0 = undefined;
  var_1 = undefined;

  while(!level.gameended) {
    wait 5;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!isDefined(level.scoretick)) {
      level.scoretick = [];
    }

    foreach(var_3 in level.teamnamelist) {
      level.scoretick[var_3] = 0;
    }

    if(isDefined(level.btmflagobject)) {
      var_5 = level.btmflagobject scripts\mp\gameobjects::getownerteam();

      if(var_5 == "neutral") {
        continue;
      }

      level.scoretick[var_5] += level.pointsperflag;
      updatescores();
    }
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

  foreach(var_2 in level.teamnamelist) {
    if(level.scoretick[var_2] > 0) {
      scripts\mp\gamescore::giveteamscoreforobjective(var_2, level.scoretick[var_2], 1);
    }
  }
}

function removedompoint(var_0) {
  self endon("game_ended");
  level.btmflagobject scripts\mp\gameobjects::allowuse("none");
  level.btmflagobject scripts\mp\gameobjects::setvisibleteam("none");
  level.btmflagobject scripts\mp\gameobjects::releaseid();
  level.btmflagobject.trigger = undefined;
  level.btmflagobject notify("deleted");
  level.btmflagobject.visibleteam = "none";
  level.btmflagobject.scriptable delete();
  level.btmflagobject.flagmodel delete();
}

function pickflagtospawn() {
  var_0 = [];
  var_1 = [];

  foreach(var_4, var_3 in level.players) {
    if(var_3.team == "spectator") {
      continue;
    }

    if(!isalive(var_3)) {
      continue;
    }

    var_3.dist = 0;

    if(var_3.team == "allies") {
      var_0 = var_3;
      continue;
    }

    var_1 = var_3;
  }

  if(!var_0.size || !var_1.size) {
    if(level.primaryflags.size == 0) {
      level.primaryflags = level.primaryflags2;
    }

    for(var_5 = level.primaryflags[randomint(level.primaryflags.size)]; isDefined(level.prevflag) && var_5 == level.prevflag; var_5 = level.primaryflags[randomint(level.primaryflags.size)]) {}

    level.prevflag2 = level.prevflag;
    level.prevflag = var_5;
    return var_5;
  }

  for(var_6 = 0; var_6 < var_1.size; var_6++) {
    for(var_7 = var_6 + 1; var_7 < var_1.size; var_7++) {
      var_8 = distancesquared(var_1[var_6].origin, var_1[var_7].origin);
      var_1[var_6].dist += var_8;
      var_1[var_7].dist += var_8;
    }
  }

  for(var_6 = 0; var_6 < var_2.size; var_6++) {
    for(var_7 = var_6 + 1; var_7 < var_2.size; var_7++) {
      var_8 = distancesquared(var_2[var_6].origin, var_2[var_7].origin);
      var_2[var_6].dist += var_8;
      var_2[var_7].dist += var_8;
    }
  }

  var_9 = var_1[0];

  foreach(var_4 in var_1) {
    if(var_4.dist < var_9.dist) {
      var_9 = var_4;
    }
  }

  GscBinSkip1(0x45, "allies", var_9.origin);
}

function hqmainloop() {
  level endon("game_ended");
  level.hqrevealtime = -100000;
  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    level waittill("spawn_btm_hq");
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 0, 0);
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
    setomnvar("ui_btm_timer", 0);
    setomnvar("ui_btm_status", -1);
    scripts\mp\spawnlogic::setactivespawnlogic("Hardpoint", "Crit_Default");
    var_0 = pickradiotospawn();
    makeradioactive(var_0);
    scripts\mp\utility\sound::playsoundonplayers("ui_aar_sidebar");
    var_1 = var_0.gameobject;
    var_1 scripts\mp\gameobjects::pinobjiconontriggertouch();
    var_1 scripts\mp\gameobjects::setmodelvisibility(1);
    var_1 scripts\mp\gameobjects::setvisibleteam("any");
    var_1 scripts\mp\gameobjects::setobjectivestatusicons(level.iconlocked, level.iconlocked);
    level.radioobject = var_1;
    level.hqrevealtime = gettime();

    if(level.zoneactivationdelay) {
      setomnvar("ui_btm_timer", int(30000 + gettime()));
      setomnvar("ui_btm_status", 2);
      wait level.zoneactivationdelay;
    }

    waittillframeend();
    scripts\mp\utility\sound::playsoundonplayers("iw8_new_objective_sfx");

    foreach(var_3 in level.teamnamelist) {
      scripts\mp\utility\dialog::leaderdialog("obj_capture", var_3);

      if(scripts\mp\utility\teams::getteamdata(var_3, "teamCount") > 0) {
        scripts\mp\utility\print::teamhudtutorialmessage("OBJECTIVES/CAPTURE_HQ", var_3, 4);
      }
    }

    var_1 scripts\mp\gameobjects::allowuse("any");
    var_1 scripts\mp\gameobjects::setusetime(level.zonecapturetime);
    var_1 scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqneutral, level.iconhqneutral);
    var_1 scripts\mp\gameobjects::setvisibleteam("any");
    var_1.onuse = &onradiocapture;
    var_1.onbeginuse = &onbeginuse;
    var_1.onenduse = &onenduse;
    var_1.onuncontested = &onuncontested;
    var_1.oncontested = &oncontested;
    var_1.id = "hardpoint";
    var_1 scripts\mp\gameobjects::pinobjiconontriggertouch();
    var_1 scripts\mp\gameobjects::setcapturebehavior("normal");
    level.radioobject = var_1;
    setomnvar("ui_btm_timer", int(60000 + gettime()));
    setomnvar("ui_btm_status", 3);
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 16, 16);
    thread destroyhqaftertime(60);
    var_5 = level scripts\engine\utility::ref_143ad("hq_captured", "hq_destroyed");

    if(var_5 == "hq_captured") {
      var_6 = var_1 scripts\mp\gameobjects::getownerteam();
      var_7 = scripts\mp\utility\game::getotherteam(var_6);

      if(level.hqautodestroytime) {
        thread destroyhqaftertime(level.hqautodestroytime, var_6);
      } else {
        level.hqdestroyedbytimer = 0;
      }

      for(;;) {
        var_6 = var_1 scripts\mp\gameobjects::getownerteam();
        var_7 = scripts\mp\utility\game::getotherteam(var_6);

        if(var_6 == "allies") {}

        var_1 scripts\mp\gameobjects::allowuse("enemy");
        var_1 scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqdefend, level.iconhqcapture);

        if(!level.kothmode) {
          var_1 scripts\mp\gameobjects::setusetext(&"MP_DESTROYING_HQ");
        }

        var_1.onuse = &onradiodestroy;
        level waittill("hq_destroyed");

        if(!level.kothmode || level.hqdestroyedbytimer) {
          break;
        }

        thread forcespawnteam(var_6);
        var_1 scripts\mp\gameobjects::setownerteam(scripts\mp\utility\game::getotherteam(var_6)[0]);
      }
    }

    scripts\mp\utility\sound::playsoundonplayers("mp_sar_enemy_eliminated");

    foreach(var_3 in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamdata(var_3, "teamCount") > 0) {
        scripts\mp\utility\print::teamhudtutorialmessage("OBJECTIVES/HQ_OFFLINE", var_3, 4);
      }
    }

    var_6 = var_1 scripts\mp\gameobjects::getownerteam();
    var_1 scripts\mp\gameobjects::allowuse("none");
    var_1 scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqneutral, level.iconhqneutral);
    var_1 scripts\mp\gameobjects::setownerteam("neutral");
    var_1 scripts\mp\gameobjects::setmodelvisibility(0);
    makeradioinactive(var_0);
    level.radioobject = undefined;

    if(var_6 != "neutral") {
      thread forcespawnteam(var_6, level.extradelay);
    }

    level.usedomflag++;

    if(level.usedomflag == 3) {
      level.usedomflag = 0;
    }

    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
    wait 1;
    getnextobjective(level, "koth");
  }
}

function forcespawnteam(var_0, var_1) {
  if(isDefined(var_1)) {
    foreach(var_3 in level.players) {
      if(isalive(var_3)) {
        continue;
      }

      if(var_3.pers["team"] == var_0) {
        var_3 scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_1 * 1000));
      }
    }

    wait var_1;
  }

  foreach(var_3 in level.players) {
    if(var_3.pers["team"] == var_0) {
      var_3 scripts\mp\utility\lower_message::setlowermessageomnvar(0);

      if(!isalive(var_3)) {
        var_3.forcespawnnearteammates = 1;
      }

      var_3 notify("force_spawn");
    }
  }
}

function onbeginuse(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();

  if(var_1 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqtaking, level.iconhqlosing);
    return;
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqtaking, level.iconhqlosing);
}

function onenduse(var_0, var_1, var_2) {
  var_3 = scripts\mp\gameobjects::getownerteam();

  if(var_2) {
    return;
  }

  if(var_3 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqneutral, level.iconhqneutral);
    return;
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqdefend, level.iconhqcapture);
}

function oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqcontested);
}

function onuncontested(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();

  if(var_0 == "none" || var_1 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqneutral);
    return;
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqcapture, level.iconhqdefend);
}

function onradiocapture(var_0) {
  var_1 = var_0.pers["team"];
  scripts\mp\gamescore::giveplayerscore("capture", var_0);

  foreach(var_3 in self.touchlist[var_1]) {
    var_4 = var_3.player;
    var_4 scripts\mp\utility\stats::incpersstat("captures", 1);
    var_4 scripts\mp\persistence::statsetchild("round", "captures", var_0.pers["captures"]);
  }

  var_0 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "capture", var_0.origin);
  var_6 = scripts\mp\gameobjects::getownerteam();
  scripts\mp\gameobjects::setownerteam(var_1);

  if(!level.kothmode) {
    scripts\mp\gameobjects::setusetime(level.zonecapturetime);
  }

  var_7 = "axis";

  if(var_1 == "axis") {
    var_7 = "allies";
  }

  thread scripts\mp\utility\sound::playsoundonplayers("mp_dom_flag_captured", var_1);
  thread scripts\mp\utility\sound::playsoundonplayers("mp_dom_flag_lost", var_7);
  thread awardhqpoints(level);
  var_0 notify("objective", "captured");
  level notify("hq_captured");
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_1, 17, 16);
}

function onradiodestroy(var_0) {
  var_1 = var_0.pers["team"];
  var_2 = "axis";

  if(var_1 == "axis") {
    var_2 = "allies";
  }

  scripts\mp\gamescore::giveplayerscore("capture", var_0);

  foreach(var_4 in self.touchlist[var_1]) {
    var_5 = var_4.player;
    var_5 scripts\mp\utility\stats::incpersstat("destructions", 1);
    var_5 scripts\mp\persistence::statsetchild("round", "destructions", var_0.pers["destructions"]);
  }

  var_0 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "destroy", var_0.origin);

  if(level.kothmode) {}

  thread scripts\mp\utility\sound::playsoundonplayers("mp_dom_flag_captured", var_1);
  thread scripts\mp\utility\sound::playsoundonplayers("mp_dom_flag_lost", var_2);
  level notify("hq_destroyed");

  if(level.kothmode) {
    thread awardhqpoints(level);
    return;
  }

  scripts\mp\gamescore::giveteamscoreforobjective(var_1, 20);
}

function destroyhqaftertime(var_0, var_1) {
  level endon("game_ended");
  level endon("hq_reset");
  level notify("hq_reset_timeout");
  level endon("hq_reset_timeout");
  level.hqdestroytime = gettime() + var_0 * 1000;
  level.hqdestroyedbytimer = 0;
  wait var_0;
  level.hqdestroyedbytimer = 1;

  if(isDefined(var_1)) {
    scripts\mp\gamescore::giveteamscoreforobjective(var_1, 5);
  }

  level notify("hq_destroyed");
}

function awardhqpoints(var_0) {
  level endon("game_ended");
  level endon("hq_destroyed");
  level notify("awardHQPointsRunning");
  level endon("awardHQPointsRunning");
  var_1 = 12;
  var_2 = 5;
  var_3 = 5;
  var_4 = 5;

  if(level.promode) {
    var_5 = int(level.hqautodestroytime / var_1);
  } else {
    var_5 = 5;
  }

  var_6 = 0;

  while(!level.gameended) {
    scripts\mp\gamescore::giveteamscoreforobjective(var_1, 15);
    var_6++;
    wait var_5;
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

function makeradioactive() {
  self.gameobject scripts\mp\gameobjects::setmodelvisibility(0);
  self.gameobject scripts\mp\gameobjects::cancontestclaim(1);
  self.gameobject scripts\mp\gameobjects::enableobject();
  self.gameobject.ignorestomp = 1;
  self.trig.useobj = self.gameobject;
}

function makeradioinactive() {
  self.gameobject scripts\mp\gameobjects::releaseid();
  self.gameobject scripts\mp\gameobjects::setvisibleteam("none");
  self.gameobject scripts\mp\gameobjects::allowuse("none");
  level.radios = scripts\engine\utility::array_remove(level.radios, self);
}

function pickradiotospawn() {
  var_0 = [];
  var_1 = [];

  foreach(var_4, var_3 in level.players) {
    if(var_3.team == "spectator") {
      continue;
    }

    if(!isalive(var_3)) {
      continue;
    }

    var_3.dist = 0;

    if(var_3.team == "allies") {
      var_0 = var_3;
      continue;
    }

    var_1 = var_3;
  }

  if(!var_0.size || !var_1.size) {
    if(level.radios.size == 0) {
      level.radios = level.radios2;
    }

    for(var_5 = level.radios[randomint(level.radios.size)]; isDefined(level.prevradio) && var_5 == level.prevradio; var_5 = level.radios[randomint(level.radios.size)]) {}

    level.prevradio2 = level.prevradio;
    level.prevradio = var_5;
    return var_5;
  }

  for(var_6 = 0; var_6 < var_1.size; var_6++) {
    for(var_7 = var_6 + 1; var_7 < var_1.size; var_7++) {
      var_8 = distancesquared(var_1[var_6].origin, var_1[var_7].origin);
      var_1[var_6].dist += var_8;
      var_1[var_7].dist += var_8;
    }
  }

  for(var_6 = 0; var_6 < var_2.size; var_6++) {
    for(var_7 = var_6 + 1; var_7 < var_2.size; var_7++) {
      var_8 = distancesquared(var_2[var_6].origin, var_2[var_7].origin);
      var_2[var_6].dist += var_8;
      var_2[var_7].dist += var_8;
    }
  }

  var_9 = var_1[0];

  foreach(var_4 in var_1) {
    if(var_4.dist < var_9.dist) {
      var_9 = var_4;
    }
  }

  GscBinSkip1(0x45, "allies", var_9.origin);
}

function updaterespawntimer() {
  level endon("game_ended");
  level endon("zone_moved");
  level endon("zone_destroyed");
  var_0 = gettime();

  if(level.zoneduration > 0) {
    var_1 = var_0 + level.zoneduration * 1000;
  } else {
    var_1 = var_1 + scripts\mp\utility\game::gettimelimit() * 1000 - scripts\mp\utility\game::gettimepassed();
  }

  var_2 = var_1;

  while(var_2 < var_1) {
    var_2 = gettime();
    level.spawndelay = (var_1 - var_2) / 1000;
    waitframe();
  }
}

function onteamscore(var_0, var_1, var_2) {}

function waittospawnvip() {
  level endon("game_ended");
  level waittill("spawn_btm_vip");
  setomnvar("ui_btm_timer", 0);
  setomnvar("ui_btm_status", -1);
  level.spawnedvip = 1;
  level.hostagespawnpos = pickviptospawn();
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  level.onteamscore = undefined;
  level.hostagecarrystates = [];
  level.hostages[0] = scripts\mp\tac_ops\hostage_utility::spawnhostage(level.hostagespawnpos, "neutral");
  thread spawnextractzones();
  scripts\mp\utility\sound::playsoundonplayers("iw8_new_objective_sfx");

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\dialog::leaderdialog("obj_capture", var_1);

    if(scripts\mp\utility\teams::getteamdata(var_1, "teamCount") > 0) {
      scripts\mp\utility\print::teamhudtutorialmessage("OBJECTIVES/CAPTURE_VIP", var_1, 4);
    }
  }

  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 10, 10);
}

function spawnextractzones() {
  level endon("game_ended");
  level.vipextractzones = [];
  var_0 = getextractionbtmflag();
  var_1 = getextractionbtmflag(var_0);
  setupextractgoal(var_0, "allies");
  setupextractgoal(var_1, "axis");
}

function getextractionbtmflag(var_0) {
  var_1 = 0;
  var_2 = undefined;
  var_3 = 1000000;

  foreach(var_5 in level.primaryflags2) {
    var_6 = scripts\engine\utility::distance_2d_squared(level.hostagespawnpos, var_5.origin);

    if(isDefined(var_0)) {
      if(var_6 > var_3 && var_0 != var_5.origin) {
        var_2 = var_5;
      }

      continue;
    }

    if(var_6 > 1000000) {
      var_2 = var_5;
    }
  }

  return var_2.origin;
}

function setupextractgoal(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2.angles = (0, 270, 0);
  var_2.team = var_1;
  var_2.ownerteam = var_1;
  var_2.curorigin = var_0;
  var_2.offset3d = (0, 0, 32);
  var_2.compassicons = [];
  var_2.type = "useObject";
  var_2 setModel("cop_marker_scriptable");
  var_2 setscriptablepartstate("marker", "red");
  var_2 playLoopSound("mp_flare_burn_lp");
  var_3 = spawn("trigger_radius", var_0, 0, 120, 128);
  var_2 scripts\mp\gameobjects::requestid(1, 1);
  var_2 scripts\mp\gameobjects::setvisibleteam("none");
  var_2 scripts\mp\gameobjects::setobjectivestatusicons(level.iconextract, level.iconpreventextract);
  var_3.goalent = var_2;
  thread goaltriggerwatcher();
  level.vipextractzones[var_1] = var_3;
  waitframe();
  playFXOnTag(level._effect["vfx_smk_signal"], var_2, "tag_origin");
}

function goaltriggerwatcher() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(isDefined(level.hostagecarrier) && var_0 == level.hostagecarrier && var_0.team == self.goalent.team) {
      scripts\mp\tac_ops\hostage_utility::drophostage(var_0, level.hostages[0], var_0.origin);
      level.hostages[0].trigger makeunusable();
      level.hostages[0] makeunusable();
      level.hostages[0].useobj unlink();
      level.hostages[0].useobj makeunusable();
      level.hostages[0].trackedobject scripts\mp\gameobjects::allowuse("none");
      level.hostages[0].trackedobject scripts\mp\gameobjects::setvisibleteam("none");
      level.hostages[0].trackedobject scripts\mp\gameobjects::releaseid();
      level.hostages[0] notify("gameobject_deleted");
      level.hostages[0] delete();
      self.goalent scripts\mp\gameobjects::setvisibleteam("none");
      self.goalent scripts\mp\gameobjects::releaseid();
      scripts\mp\gamescore::giveteamscoreforobjective(var_0.team, 200, 0);
      level notify("vip_scored");
      level.spawnedvip = 0;
      self.chopper thread scripts\mp\gametypes\br_extract_chopper::littlebirdleave();
      playannouncerbattlechatter(self.chopper.team, "extract_littlebird_leaving_a_friendly", 10);

      foreach(var_2 in level.vipextractzones) {
        stopFXOnTag(level._effect["vfx_smk_signal"], var_2.goalent, "tag_origin");
        var_2.goalent stoploopsound();
        var_2.goalent delete();
        var_2.goalent = undefined;
        var_2 delete();
      }

      thread scripts\mp\utility\sound::playsoundonplayers("mp_dom_flag_captured", var_0.team);
      thread scripts\mp\utility\sound::playsoundonplayers("mp_dom_flag_lost", scripts\mp\utility\game::getotherteam(var_0.team)[0]);

      foreach(var_5 in level.teamnamelist) {
        if(scripts\mp\utility\teams::getteamdata(var_5, "teamCount") > 0) {
          scripts\mp\utility\print::teamhudtutorialmessage("OBJECTIVES/VIP_CAPTURED", var_5, 4);
        }
      }

      level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 0, 0);
      break;
    }

    waitframe();
  }

  level.objectiveselector.objectivetypes[2] = "skip";
  getnextobjective(level, "vip");
}

function summonextractchopper(var_0) {
  if(!isDefined(var_0.chopper)) {
    var_1 = scripts\mp\gametypes\br_extract_chopper::spawnextractchopper(var_0, var_0.origin);
    var_1.invulnerable = 1;
    var_0.chopper = var_1;
    self iprintlnbold("Extraction copter en route!");
    var_1.extractzone = var_0;
    var_1.extractteam = self.team;
    var_0.curorigin = var_0.origin;
    var_0.offset3d = (0, 0, 30);
    thread extracttriggerwatcher(var_0);
    return;
  }
}

function extracttriggerwatcher(var_0) {
  level endon("game_ended");
  var_0 endon("bugOut");
  var_0 waittill("esc_littlebird_arrive");
  self.extractionactive = 1;
  playannouncerbattlechatter(var_0.extractteam, "extract_littlebird_close_a_friendly", 10);
}

function playannouncerbattlechatter(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = "ustl";
  var_4 = "dx_mpa_" + var_3 + "_" + var_1 + "_" + var_2;

  if(soundexists(var_4)) {
    foreach(var_6 in level.players) {
      if(var_6.team == var_0) {
        var_6 queuedialogforplayer(var_4, var_1, 2);
      }
    }

    return;
  }
}

function pickviptospawn() {
  var_0 = [];
  var_1 = [];

  foreach(var_4, var_3 in level.players) {
    if(var_3.team == "spectator") {
      continue;
    }

    if(!isalive(var_3)) {
      continue;
    }

    var_3.dist = 0;

    if(var_3.team == "allies") {
      var_0 = var_3;
      continue;
    }

    var_1 = var_3;
  }

  var_5 = level.primaryflags2;

  if(!var_0.size || !var_1.size) {
    for(var_6 = var_5[randomint(var_5.size)]; isDefined(level.prevspawnpos) && var_6 == level.prevspawnpos; var_6 = var_5[randomint(var_5.size)]) {}

    level.prevspawnpos2 = level.prevspawnpos;
    level.prevspawnpos = var_6;
    return var_6.origin;
  }

  for(var_7 = 0; var_7 < var_1.size; var_7++) {
    for(var_8 = var_7 + 1; var_8 < var_1.size; var_8++) {
      var_9 = distancesquared(var_1[var_7].origin, var_1[var_8].origin);
      var_1[var_7].dist += var_9;
      var_1[var_8].dist += var_9;
    }
  }

  for(var_7 = 0; var_7 < var_2.size; var_7++) {
    for(var_8 = var_7 + 1; var_8 < var_2.size; var_8++) {
      var_9 = distancesquared(var_2[var_7].origin, var_2[var_8].origin);
      var_2[var_7].dist += var_9;
      var_2[var_8].dist += var_9;
    }
  }

  var_10 = var_1[0];

  foreach(var_4 in var_1) {
    if(var_4.dist < var_10.dist) {
      var_10 = var_4;
    }
  }

  GscBinSkip1(0x45, "allies", var_10.origin);
}

function waittospawnjuggcrate() {
  level endon("game_ended");
  level waittill("spawn_btm_jugg");
  level.spawnedjugg = 1;
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  scripts\mp\utility\sound::playsoundonplayers("iw8_new_objective_sfx");

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\dialog::leaderdialog("obj_capture", var_1);

    if(scripts\mp\utility\teams::getteamdata(var_1, "teamCount") > 0) {
      scripts\mp\utility\print::teamhudtutorialmessage("OBJECTIVES/CAPTURE_JUGG", var_1, 4);
    }
  }

  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 19, 19);
  level.spawnedjugg = 1;
  level.juggcratespawnpos = pickviptospawn();
  initjugg();
  level.btmjuggcrate = createjuggcrate(level.juggcratespawnpos, (0, 0, 0));
  setomnvar("ui_btm_timer", int(30000 + gettime()));
  setomnvar("ui_btm_status", 2);
  wait 30;
  thread juggcratemanageuse();
  setomnvar("ui_btm_timer", 0);
  setomnvar("ui_btm_status", -1);
  objective_icon(level.juggcrateobjid, "icon_minimap_juggernaut");
}

function createjuggcrate(var_0, var_1) {
  var_2 = getgroundposition(var_0, 32);
  var_3 = spawn("script_model", var_2 + (0, 0, 40));
  var_4 = spawn("script_model", var_2);
  var_3.cratemodel = var_4;
  var_3.cratemodel.angles = var_1;
  var_3.cratemodel setModel("military_crate_large_stackable_01_jugg");
  var_3.crateid = var_3 getentitynumber();
  createjuggcrateobjective(var_3);
  return var_3;
}

function juggcratemanageuse() {
  level endon("game_ended");
  self endon("death");
  self setuserange(120);
  self setCursorHint("HINT_NOICON");
  self setHintString(&"MP_MODE_RUGBY/CRATE_USE");
  self setuseholdduration("duration_long");
  self makeusable();
  self.inuse = 0;
  thread juggcratewatchuseprogress();
  thread juggcratewatchusecompleted();
  thread juggcratewatchstopuseprogress();
}

function juggcrateused(var_0) {
  activatenewjuggernaut(var_0);
  juggcratecleanup();
  level notify("jugg_scored");
  level.objectiveselector.objectivetypes[3] = "skip";
  getnextobjective(level, "jugg");
  self.cratemodel delete();
  self delete();
}

function juggcratecleanup() {
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objid);
}

function juggcratewatchusecompleted() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }

    juggcrateused(var_0);
    return;
  }
}

function juggcratewatchuseprogress() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger_progress", var_0);
    self.usingplayer = var_0;
    self.inuse = 1;
    self.lastusetime = gettime();
  }
}

function juggcratewatchstopuseprogress() {
  level endon("game_ended");
  self endon("death");
  var_0 = self.inuse;

  for(var_1 = self.usingplayer;; var_1 = self.usingplayer) {
    wait 0.2;

    if(self.inuse) {
      if(self.lastusetime < gettime() - 200) {
        self.inuse = 0;
        self.usingplayer = undefined;
        self.lastusetime = undefined;
        continue;
      }

      var_2 = isDefined(var_1) && isDefined(self.usingplayer) && var_1 != self.usingplayer;

      if(!var_0 || var_2) {
        updatejuggcrateobjectivestate(self);
      }
    } else if(var_0) {
      updatejuggcrateobjectivestate(self);
    }

    var_0 = self.inuse;
  }
}

function createjuggcrateobjective(var_0) {
  var_1 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  var_0.objid = var_1;
  level.juggcrateobjid = var_1;
  var_2 = var_0.origin + (0, 0, 32);
  scripts\mp\objidpoolmanager::objective_add_objective(var_1, "current", var_2, level.iconlocked);
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_1, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(var_1, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_1);
  objective_setneutrallabel(var_1, "MP_MODE_RUGBY/CRATE_CAPTURE");
  objective_setfriendlylabel(var_1, "MP_MODE_RUGBY/CRATE_CAPTURING");
  objective_setenemylabel(var_1, "MP_MODE_RUGBY/CRATE_LOSING");
  updatejuggcrateobjectivestate(var_0);
}

function updatejuggcrateobjectivestate(var_0) {
  var_1 = var_0.objid;
  var_2 = istrue(var_0.inuse);

  if(var_2) {
    objective_setownerteam(var_1, var_0.usingplayer.team);
    objective_sethot(var_1, 1);
    return;
  }

  objective_setownerteam(var_1, undefined);
  objective_sethot(var_1, 0);
}

function activatenewjuggernaut(var_0) {
  var_1 = level.btm;
  var_2 = spawnStruct();
  var_2.player = var_0;
  var_3 = var_0 getentitynumber();
  var_2.id = var_3;
  var_1.activejuggernauts[var_3] = var_0;
  var_0.btmjugginfo = var_2;
  setupplayerasjugg(var_0);
  createjuggobjective(var_0, var_2);
}

function setupplayerasjugg(var_0) {
  var_1 = level.btm.juggconfig;
  var_0 scripts\mp\juggernaut::jugg_makejuggernaut(var_1);
  var_0 givemaxammo(var_0.classstruct.loadoutprimaryobject);
  var_0 givemaxammo(var_0.classstruct.loadoutsecondaryobject);
  var_0 scripts\mp\weapons::updatemovespeedscale();
  var_2 = scripts\mp\utility\teams::getenemyteams(var_0.team);
  var_3 = var_2[0];
  var_0.isjuggernaut = 1;
}

function createjuggobjective(var_0, var_1) {
  var_2 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  var_1.juggobjid = var_2;
  scripts\mp\objidpoolmanager::objective_add_objective(var_2, "current", var_0.origin, "icon_minimap_juggernaut");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(var_2, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_2);
  scripts\mp\objidpoolmanager::update_objective_onentity(var_2, var_0);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var_2, 90);
  objective_setownerteam(var_2, var_0.team);
  objective_setfriendlylabel(var_2, "MP_INGAME_ONLY/OBJ_DEFEND_CAPS");
  objective_setenemylabel(var_2, "MP_INGAME_ONLY/OBJ_KILL_CAPS");
}

function initjugg() {
  var_0 = scripts\mp\juggernaut::jugg_createconfig();
  level.btm.juggconfig = var_0;
  var_1 = getjuggmaxhealth();
  var_0.maxhealth = var_1;
  var_0.startinghealth = var_1;
  var_0.suit = "iw8_juggernaut_mp_rugby";
  var_0.allows["crouch"] = 0;
  var_0.allows["sprint"] = 0;
  var_0.allows["usability"] = 0;
  var_0.allows["weapon_switch"] = undefined;
  var_0.classstruct.loadoutprimary = "iw8_lm_dblmg";
  var_0.classstruct.loadoutprimaryattachments = ["holo"];
  var_0.classstruct.loadoutsecondary = "iw8_pi_decho";
}

function cleanupobjectiveiconsforjugg(var_0) {
  scripts\mp\objidpoolmanager::returnobjectiveid(var_0.btmjugginfo.juggobjid);
}

function getjuggmaxhealth() {
  return getdvarint("scr_btm_juggHealth");
}

function waittospawnbtmbombs() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  level waittill("spawn_btm_dd");
  level.bombexploded = 0;
  level.multibomb = 1;
  level.bombsplanted = 0;
  level.bombtimer = 45;
  level.defusetime = 5;
  level.planttime = 5;
  level.bombzones = [];
  level.aplanted = 0;
  level.bplanted = 0;
  thread applybombstoplayers();
  var_0 = getfirstbtmbombloc();
  var_1 = getsecondbtmbombloc(var_0);
  var_0 = getgroundposition(var_0.origin, 64);
  var_1 = getgroundposition(var_1.origin, 64);
  level.resetprogress = 1;
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  var_2 = getEntArray("bombzone", "targetname");
  var_2 = scripts\mp\gametypes\sd::removebombzonec(var_2);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = getEntArray(var_2[var_3].target, "targetname");

    if(var_3 == 0) {
      var_2 = modifybombzonecollision(var_4, var_2[var_3], var_0);
      var_2[var_3].origin = var_0;
      var_4[0].origin = var_0;
    } else {
      var_2 = modifybombzonecollision(var_4, var_2[var_3], var_1);
      var_2[var_3].origin = var_1;
      var_4[0].origin = var_1;
    }

    var_5 = scripts\mp\gameobjects::createuseobject("neutral", var_2[var_3], var_4, (0, 0, 64));
    var_5 scripts\mp\gameobjects::allowuse("none");
    var_6 = var_2[var_3].script_label;

    if(isDefined(var_2[var_3].objectivekey)) {
      var_5.objectivekey = var_2[var_3].objectivekey;
    } else {
      var_5.objectivekey = var_5 scripts\mp\gameobjects::getlabel();
    }

    if(isDefined(var_2[var_3].iconname)) {
      var_5.iconname = var_2[var_3].iconname;
    } else {
      var_5.iconname = var_5 scripts\mp\gameobjects::getlabel();
    }

    var_5.id = "bomb_zone";
    var_5.trigger setusepriority(-3);
    var_5 scripts\mp\gameobjects::setusetime(level.planttime);
    var_5 scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
    var_5 scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_PLANT_EXPLOSIVES");

    if(var_5.objectivekey == "_c") {
      var_5.objectivekey = "_a";
      var_5.iconname = "_a";
    }

    var_5 scripts\mp\gameobjects::setobjectivestatusicons(level.iconlocked);
    var_5 scripts\mp\gameobjects::setvisibleteam("any");
    var_5.onbeginuse = &scripts\mp\gametypes\obj_bombzone::bombzone_onbeginuse;
    var_5.onenduse = &scripts\mp\gametypes\obj_bombzone::bombzone_onenduse;
    var_5.onuse = &scripts\mp\gametypes\obj_bombzone::bombzone_onuseplantobject;
    var_5.oncantuse = &scripts\mp\gametypes\obj_bombzone::bombzone_oncantuse;
    var_5.useweapon = getcompleteweaponname("briefcase_bomb_mp");
    var_5.bombplanted = 0;
    var_5.bombexploded = undefined;
    var_5.resetprogress = level.resetprogress;

    for(var_7 = 0; var_7 < var_4.size; var_7++) {
      if(isDefined(var_4[var_7].script_exploder)) {
        var_5.exploderindex = var_4[var_7].script_exploder;
        var_4[var_7] thread scripts\mp\gametypes\obj_bombzone::setupkillcament(var_5);
        break;
      }
    }

    var_5.bombdefusetrig = getEnt(var_4[0].target, "targetname");
    var_5.bombdefusetrig.origin += (0, 0, -10000);
    var_5.bombdefusetrig.label = var_6;
    var_5.noweapondropallowedtrigger = spawn("trigger_radius", var_5.trigger.origin, 0, 140, 100);
    level.objectives[var_5.objectivekey] = var_5;
    level.bombzones[level.bombzones.size] = var_5;
  }

  setomnvar("ui_btm_timer", int(30000 + gettime()));
  setomnvar("ui_btm_status", 2);
  wait 30;

  foreach(var_5 in level.bombzones) {
    var_5 scripts\mp\gameobjects::allowuse("any");
    var_5 scripts\mp\gameobjects::setobjectivestatusicons(level.iconplant);
  }

  setomnvar("ui_btm_timer", 0);
  setomnvar("ui_btm_status", -1);
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 20, 20);
}

function applybombstoplayers() {
  foreach(var_1 in level.players) {
    if(!isai(var_1)) {
      var_1 setclientomnvar("ui_carrying_bomb", 1);
      var_1.isplanting = 0;
      var_1.isdefusing = 0;
      var_1.isbombcarrier = 1;
    }
  }
}

function resetbombzone() {
  scripts\mp\gameobjects::setownerteam("neutral");
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconplant);
  self.id = "bomb_zone";
  scripts\mp\gameobjects::setusetime(level.planttime);
  scripts\mp\gameobjects::setvisibleteam("any");
  scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_PLANT_EXPLOSIVES");
  self.useweapon = getcompleteweaponname("briefcase_bomb_mp");
  self.bombexploded = undefined;
  self.bombplanted = 0;
}

function bombhandler(var_0, var_1, var_2) {
  level.bombsplanted -= 1;

  if(self.objectivekey == "_a") {
    level.aplanted = 0;
  } else {
    level.bplanted = 0;
  }

  scripts\mp\gametypes\obj_bombzone::setbombtimeromnvars();

  if(level.gameended) {
    return;
  }

  if(var_1 == "explode") {
    self.bombexploded = 1;
    self.bombplanted = 0;
    scripts\mp\gameobjects::releaseid();
    scripts\mp\gamescore::giveteamscoreforobjective(var_0.team, 100);

    if(level.bombexploded > 1) {
      level.objectiveselector.objectivetypes[4] = "skip";
      getnextobjective(level, "dd");
      return;
    }

    return;
  }

  var_0 notify("bomb_defused" + self.objectivekey);
  self notify("defused");
  resetbombzone();
}

function getsecondbtmbombloc(var_0) {
  var_1 = 1000000;
  var_2 = [];
  var_3 = [];

  foreach(var_6, var_5 in level.players) {
    if(var_5.team == "spectator") {
      continue;
    }

    if(!isalive(var_5)) {
      continue;
    }

    var_5.dist = 0;

    if(var_5.team == "allies") {
      var_2 = var_5;
      continue;
    }

    var_3 = var_5;
  }

  var_7 = level.primaryflags2;

  if(!var_2.size || !var_3.size) {
    for(var_8 = var_7[randomint(var_7.size)]; isDefined(level.prevbomb) && var_8 == level.prevbomb; var_8 = var_7[randomint(var_7.size)]) {}

    level.prevbomb2 = level.prevbomb;
    level.prevbomb = var_8;
    return var_8;
  }

  for(var_9 = 0; var_9 < var_3.size; var_9++) {
    for(var_10 = var_9 + 1; var_10 < var_3.size; var_10++) {
      var_11 = distancesquared(var_3[var_9].origin, var_3[var_10].origin);
      var_3[var_9].dist += var_11;
      var_3[var_10].dist += var_11;
    }
  }

  for(var_9 = 0; var_9 < var_4.size; var_9++) {
    for(var_10 = var_9 + 1; var_10 < var_4.size; var_10++) {
      var_11 = distancesquared(var_4[var_9].origin, var_4[var_10].origin);
      var_4[var_9].dist += var_11;
      var_4[var_10].dist += var_11;
    }
  }

  var_12 = var_3[0];

  foreach(var_6 in var_3) {
    if(var_6.dist < var_12.dist) {
      var_12 = var_6;
    }
  }

  GscBinSkip1(0x45, "allies", var_12.origin);
}

function getfirstbtmbombloc() {
  var_0 = [];
  var_1 = [];

  foreach(var_4, var_3 in level.players) {
    if(var_3.team == "spectator") {
      continue;
    }

    if(!isalive(var_3)) {
      continue;
    }

    var_3.dist = 0;

    if(var_3.team == "allies") {
      var_0 = var_3;
      continue;
    }

    var_1 = var_3;
  }

  var_5 = level.primaryflags2;

  if(!var_0.size || !var_1.size) {
    for(var_6 = var_5[randomint(var_5.size)]; isDefined(level.prevbomb) && var_6 == level.prevbomb; var_6 = var_5[randomint(var_5.size)]) {}

    level.prevbomb2 = level.prevbomb;
    level.prevbomb = var_6;
    return var_6;
  }

  for(var_7 = 0; var_7 < var_1.size; var_7++) {
    for(var_8 = var_7 + 1; var_8 < var_1.size; var_8++) {
      var_9 = distancesquared(var_1[var_7].origin, var_1[var_8].origin);
      var_1[var_7].dist += var_9;
      var_1[var_8].dist += var_9;
    }
  }

  for(var_7 = 0; var_7 < var_2.size; var_7++) {
    for(var_8 = var_7 + 1; var_8 < var_2.size; var_8++) {
      var_9 = distancesquared(var_2[var_7].origin, var_2[var_8].origin);
      var_2[var_7].dist += var_9;
      var_2[var_8].dist += var_9;
    }
  }

  var_10 = var_1[0];

  foreach(var_4 in var_1) {
    if(var_4.dist < var_10.dist) {
      var_10 = var_4;
    }
  }

  GscBinSkip1(0x45, "allies", var_10.origin);
}

function modifybombzonecollision(var_0, var_1, var_2) {
  var_3 = var_1.origin;
  var_4 = modifiedbombzones(var_1, var_3, var_0, var_2);
  return var_4;
}

function modifiedbombzones(var_0, var_1, var_2, var_3) {
  var_2[0].origin = var_3;
  var_2[0].angles = (0, 0, 0);
  var_0.origin = var_3;
  var_0.angles = (0, 0, 0);
  setmodifiedbombzonescollision((0, 0, 35), (0, 0, 0), var_1, var_2);
  setexplodermodel(var_1, var_2);
  return var_0;
}

function setmodifiedbombzonescollision(var_0, var_1, var_2, var_3) {
  var_4 = getEntArray("script_brushmodel", "classname");

  foreach(var_6 in var_4) {
    if(isDefined(var_6.script_gameobjectname) && var_6.script_gameobjectname == "bombzone") {
      if(distance(var_6.origin, var_2) < 100) {
        var_7 = spawn("script_model", var_3[0].origin + var_0);
        var_7.angles = var_1;
        var_7 clonebrushmodeltoscriptmodel(var_6);
        var_7 disconnectPaths();
        var_6 delete();
        break;
      }
    }
  }
}

function setexplodermodel(var_0, var_1) {
  var_2 = getEntArray("script_model", "classname");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(isDefined(var_2[var_3].script_exploder)) {
      if(isDefined(var_2[var_3].targetname) && var_2[var_3].targetname == "exploder" && distance(var_2[var_3].origin, var_0) < 100) {
        var_2[var_3].origin = var_1[0].origin;
        var_2[var_3].angles = var_1[0].angles;
      }
    }
  }
}

function getspawnpoint() {
  var_0 = self.pers["team"];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var_0 + "_start");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  } else {
    if(isDefined(level.radioobject)) {
      var_1 = removespawnsinactivehq(level.radioobject.spawnpoints);
      var_3 = removespawnsinactivehq(level.radioobject.fallbackspawnpoints);
      var_4 = getobjzonedeadzonedist();
      var_5 = [];
      GscBinSkip0(0x2e, "activeKOTHZoneNumber", level.radioobject.visuals[0] getentitynumber());
    }

    if(isDefined(level.btmflagobject)) {
      var_1 = removespawnsinactiveflag(level.btmflagobject.trigger.spawnpoints);
      var_3 = removespawnsinactiveflag(level.btmflagobject.trigger.fallbackspawnpoints);
      var_4 = getobjzonedeadzonedist();
      var_5 = [];
      GscBinSkip0(0x2e, "activeKOTHZoneNumber", level.btmflagobject.trigger getentitynumber());
    }

    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, var_5, "normal", "fallback");
  }

  return var_2;
}

function getobjzonedeadzonedist() {
  return level.spawn_deadzone_dist;
}

function removespawnsinactivehq(var_0) {
  var_1 = [];

  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      if(!ispointinvolume(var_3.origin, level.radioobject.trigger)) {
        var_1 = var_3;
      }
    }
  }

  return var_1;
}

function removespawnsinactiveflag(var_0) {
  var_1 = [];

  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      if(!ispointinvolume(var_3.origin, level.btmflagobject.trigger)) {
        var_1 = var_3;
      }
    }
  }

  return var_1;
}

function forcespawnplayers() {
  var_0 = level.players;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isDefined(var_2) || isalive(var_2)) {
      continue;
    }

    var_2 notify("force_spawn");
    wait 0.1;
  }
}

function onspawnplayer() {
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  self.forcespawnnearteammates = undefined;
  self setclientomnvar("ui_match_status_hint_text", -1);
  thread updatematchstatushintonspawn();

  if(istrue(level.multibomb)) {
    self setclientomnvar("ui_carrying_bomb", 1);
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 1;
    return;
  }
}

function movezoneaftertime(var_0) {
  level endon("game_ended");
  level endon("zone_reset");
  level endon("dev_force_zone");
  level.zonemovetime = var_0;
  level.zonedestroyedbytimer = 0;
  scripts\mp\gametypes\obj_zonecapture::zonetimerwait();
  level.zonedestroyedbytimer = 1;
  level notify("zone_moved");
  level notify("zone_destroyed");
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }

  if(var_1 == self) {
    return;
  }

  if(isDefined(level.radioobject)) {
    var_10 = level.radioobject.ownerteam;

    if(!isDefined(var_10)) {
      return;
    }

    if(isDefined(var_4) && scripts\mp\utility\weapon::iskillstreakweapon(var_4.basename)) {
      return;
    }

    var_11 = self;
    var_12 = 0;
    var_13 = var_1.team;

    if(level.zonecapturetime > 0 && var_1 istouching(level.radioobject.trigger)) {
      if(var_10 != var_13) {
        var_12 = 1;
      }
    }

    if(var_13 != var_10) {
      if(var_11 istouching(level.radioobject.trigger)) {
        if(var_12) {
          var_1 thread scripts\mp\utility\points::giveunifiedpoints("capture_kill");
        }

        var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
        thread scripts\common\utility::ref_13e0a(level.ref_11b24.ref_11b30, var_9, "defending");
      }
    } else if(var_1 istouching(level.radioobject.trigger)) {
      if(var_12) {
        var_1 thread scripts\mp\utility\points::giveunifiedpoints("capture_kill");
      }

      var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
      var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
      var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
      var_1 scripts\mp\utility\stats::setextrascore1(var_1.pers["defends"]);
    }
  }

  if(istrue(level.spawnedjugg)) {
    if(var_3 == "MOD_SUICIDE" && var_4.basename == "none" && isDefined(self.wasswitchingteamsforonplayerkilled)) {
      return;
    }

    var_11 = self;

    if(isDefined(var_11.isjuggernaut)) {
      level.spawnedjugg = 0;

      if(isDefined(var_11.juggoverlay)) {
        var_11.juggoverlay destroy();
      }

      var_11.playerstreakspeedscale = undefined;
      var_11.nostuckdamagekill = 0;
      var_11 scripts\mp\utility\player::_setsuit("iw8_defaultsuit_mp");
      cleanupobjectiveiconsforjugg(var_11);
    }

    if(isDefined(var_1) && isPlayer(var_1)) {
      var_14 = 0;
      var_15 = 0;
      var_16 = 0;
      var_17 = 0;
      var_18 = 0;
      var_19 = 0;

      if(var_1.team != var_11.team) {
        if(isDefined(var_11.isjuggernaut)) {
          if(isDefined(var_1.isjuggernaut)) {
            var_15 = 1;
          } else {
            var_16 = 1;
          }
        } else if(isDefined(var_1.isjuggernaut)) {
          var_17 = 1;
        }
      }

      if(var_16) {
        var_1 thread scripts\mp\utility\points::giveunifiedpoints("kill_juggernaut");
        var_19 = level.ppkonjugg;
      } else if(var_15) {
        var_19 = level.ppkjuggonjugg;
      } else if(var_17) {
        var_19 = level.ppkasjugg;
      }

      if(var_19) {
        var_1 scripts\mp\gamescore::giveteamscoreforobjective(var_1.pers["team"], var_19);
      }

      if(var_1.team != var_11.team && game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level.otherteam[var_1.team]]) {
        var_1.finalkill = 1;
        return;
      }

      return;
    }

    return;
  }
}

function objectiveselectorsetup() {
  level endon("game_ended");
  level.objectiveselector = spawnStruct();
  level.objectiveselector.objectivetypes = [];
  level.objectiveselector.objectivetypes[0] = "dom";
  level.objectiveselector.objectivetypes[1] = "koth";
  level.objectiveselector.objectivetypes[2] = "vip";
  level.objectiveselector.objectivetypes[3] = "jugg";
  level.objectiveselector.objectivetypes[4] = "dd";
  level.objectiveselector.prevobj = undefined;
  level.objectiveselector.currentobj = undefined;
  getnextobjective(level);
}

function getnextobjective(var_0) {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  if(isDefined(var_0)) {
    level.objectiveselector.prevobj = var_0;

    for(;;) {
      var_1 = randomint(level.objectiveselector.objectivetypes.size);

      if(var_0 != level.objectiveselector.objectivetypes[var_1] && level.objectiveselector.objectivetypes[var_1] != "skip") {
        break;
      }

      waitframe();
    }

    setomnvar("ui_btm_timer", int(45000 + gettime()));
    setomnvar("ui_btm_status", 1);
    wait 45;
  } else {
    var_1 = randomint(level.objectiveselector.objectivetypes.size);
    setomnvar("ui_btm_timer", int(60000 + gettime()));
    setomnvar("ui_btm_status", 1);
    wait 60;
  }

  switch (var_1) {
    case 0:
      startbtmflag();
      break;
    case 1:
      starthq();
      break;
    case 2:
      startvip();
      break;
    case 3:
      startjugg();
      break;
    case 4:
      startddbombs();
      break;
    default:
      startbtmflag();
      break;
  }
}

function startbtmflag() {
  level notify("spawn_btm_dom");
}

function starthq() {
  level notify("spawn_btm_hq");
}

function startvip() {
  level notify("spawn_btm_vip");
}

function startjugg() {
  level notify("spawn_btm_jugg");
}

function startddbombs() {
  level notify("spawn_btm_dd");
}

function give_capture_credit(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  level.lastcaptime = gettime();
  var_5 = var_4;

  if(isDefined(var_5.owner)) {
    var_5 = var_5.owner;
  }

  if(isPlayer(var_5)) {
    if(!isscoreboosting(var_5)) {
      var_5 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "capture", var_5.origin);
      var_5 thread scripts\mp\awards::givemidmatchaward("mode_hp_secure");

      if(isDefined(level.radioobject.lastactivatetime) && gettime() - level.radioobject.lastactivatetime <= 2100) {
        var_5 thread scripts\mp\awards::givemidmatchaward("mode_hp_quick_cap");
      }

      if(var_5.lastkilltime + 500 > gettime()) {} else {
        var_5 scripts\mp\gametypes\obj_zonecapture::setcrankedtimerzonecap(var_5);
      }
    }
  }

  var_6 = getarraykeys(var_0);

  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    var_8 = var_0[var_6[var_7]].player;
    updatecapsperminute(var_8, var_3);

    if(!isscoreboosting(var_8)) {
      var_8 scripts\mp\utility\stats::incpersstat("captures", 1);
      var_8 scripts\mp\persistence::statsetchild("round", "captures", var_8.pers["captures"]);
    }

    wait 0.05;
  }
}

function updatecapsperminute(var_0) {
  if(!isDefined(self.capsperminute)) {
    self.numcaps = 0;
    self.capsperminute = 0;
  }

  if(!isDefined(var_0) || var_0 == "neutral") {
    return;
  }

  self.numcaps++;
  var_1 = scripts\mp\utility\game::gettimepassed() / 60000;

  if(isPlayer(self) && isDefined(self.timeplayed["total"])) {
    var_1 = self.timeplayed["total"] / 60;
  }

  self.capsperminute = self.numcaps / var_1;

  if(self.capsperminute > self.numcaps) {
    self.capsperminute = self.numcaps;
    return;
  }
}

function isscoreboosting(var_0) {
  if(var_0.capsperminute > 3) {
    return true;
  }

  return false;
}

function onplayerconnect(var_0) {
  var_0._hardpointeffect = [];
  var_0.numcaps = 0;
  var_0.capsperminute = 0;
  var_0.timebyrotation = [];
  var_0 scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var_0.pers["captures"])) {
    var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["captures"]);
  }

  var_0 scripts\mp\utility\stats::setextrascore1(0);

  if(isDefined(var_0.pers["defends"])) {
    var_0 scripts\mp\utility\stats::setextrascore1(var_0.pers["defends"]);
  }

  thread onplayerspawned(var_0);
}

function onplayerspawned(var_0) {
  for(;;) {
    var_0 waittill("spawned");
  }
}

function getownerteamplayer(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(var_3.team == var_0) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

function getrespawndelay() {
  if(!level.delayplayer) {
    return undefined;
  }

  if(!isDefined(level.radioobject)) {
    return undefined;
  }

  var_0 = level.radioobject.ownerteam;

  if(isDefined(var_0)) {
    if(self.pers["team"] == var_0) {
      if(!level.spawndelay) {
        return undefined;
      }

      return level.spawndelay;
    }

    return;
  }
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
}

function updatematchstatushintonspawn() {
  level endon("game_ended");

  if(isDefined(level.btmflagobject)) {
    if(isDefined(level.btmflagobject.ownerteam)) {
      if(level.btmflagobject.ownerteam == self.team) {
        self setclientomnvar("ui_match_status_hint_text", 15);
        return;
      }

      self setclientomnvar("ui_match_status_hint_text", 14);
      return;
    }

    return;
  }

  if(isDefined(level.radioobject)) {
    if(isDefined(level.radioobject.ownerteam)) {
      if(level.radioobject.ownerteam == self.team) {
        self setclientomnvar("ui_match_status_hint_text", 17);
        return;
      }

      self setclientomnvar("ui_match_status_hint_text", 16);
      return;
    }

    return;
  }

  if(istrue(level.spawnedvip)) {
    if(isDefined(level.hostagecarrier)) {
      if(level.hostagecarrier.team == self.team) {
        if(level.hostagecarrier == self) {
          self setclientomnvar("ui_match_status_hint_text", 13);
          return;
        }

        self setclientomnvar("ui_match_status_hint_text", 11);
        return;
      }

      self setclientomnvar("ui_match_status_hint_text", 12);
      return;
    }

    if(level.hostages[0].team == self.team) {
      self setclientomnvar("ui_match_status_hint_text", 10);
      return;
    }

    self setclientomnvar("ui_match_status_hint_text", 12);
    return;
  }

  if(istrue(level.spawnedjugg)) {
    self setclientomnvar("ui_match_status_hint_text", 19);
    return;
  }

  self setclientomnvar("ui_match_status_hint_text", 0);
}

function seticonnames() {
  level.iconneutral = "waypoint_captureneutral";
  level.iconcapture = "waypoint_capture";
  level.icondefend = "waypoint_defend";
  level.iconcontested = "waypoint_contested";
  level.icontaking = "waypoint_taking";
  level.iconlosing = "waypoint_losing";
  level.icontarget = "waypoint_dom_target";
  level.iconlocked = "icon_waypoint_locked";
  level.iconhqtarget = "hq_target";
  level.iconhqneutral = "hq_neutral";
  level.iconhqcapture = "hq_destroy";
  level.iconhqdefend = "hq_defend";
  level.iconhqcontested = "hq_contested";
  level.iconhqtaking = "hq_taking";
  level.iconhqlosing = "hq_losing";
  level.iconrecover = "waypoint_recover_vip";
  level.iconescort = "waypoint_escort_vip_carrier";
  level.iconkill = "waypoint_kill_vip_carrier";
  level.iconextract = "waypoint_extract_vip";
  level.iconpreventextract = "icon_waypoint_prevent_exfil";
  level.iconplant = "waypoint_target_btm";
}

function setupwaypointicons() {}