/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\btm.gsc
***********************************************/

function main() {
  var0 = spawnStruct();
  level.btm = var0;

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
    var0 = game["attackers"];
    var1 = game["defenders"];
    game["attackers"] = var1;
    game["defenders"] = var0;
  }

  level._effect["bomb_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");

  foreach(var3 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var3, &"OBJECTIVES/KOTH");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var3, &"OBJECTIVES/KOTH");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var3, &"OBJECTIVES/KOTH_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var3, &"OBJECTIVES/KOTH_HINT");
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
  var0 = getsubstr(level.mapname, 0, 7);

  switch (var0) {
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

  foreach(var1 in level.objectives) {
    var1.furthestspawndistsq = 0;
    var1.spawnpoints = [];
    var1.fallbackspawnpoints = [];
  }

  foreach(var4 in level.spawnpoints) {
    calculatespawndisttozones(var4);
    var5 = scripts\mp\spawnlogic::getoriginidentifierstring(var4);

    if(isDefined(level.btmextraprimaryspawnpoints) && isDefined(level.btmextraprimaryspawnpoints[var5])) {
      foreach(var7 in level.btmextraprimaryspawnpoints[var5]) {
        var1 = level.objectives[var7];
        var1.spawnpoints[var1.spawnpoints.size] = var4;
      }
    }

    var9 = 0;
    var10 = var4.classname == "mp_tdm_spawn";
    var11 = var4.classname == "mp_tdm_spawn_secondary";

    if(var10 || var11) {
      if(isDefined(var4.script_noteworthy) && var4.script_noteworthy != "") {
        var9 = 1;
        var12 = strtok(var4.script_noteworthy, " ");

        foreach(var7 in var12) {
          var1 = level.objectives[var7];

          if(var10) {
            var1.spawnpoints[var1.spawnpoints.size] = var4;
            continue;
          }

          var1.fallbackspawnpoints[var1.fallbackspawnpoints.size] = var4;
        }
      }
    }

    if(!var9) {
      foreach(var1 in level.objectives) {
        if(var4.scriptdata.distsqtokothzones[var1 getentitynumber()] < level.close_spawn_min_dist_sq || var4.scriptdata.distsqtokothzones[var1 getentitynumber()] > level.max_spawn_dist_sq) {
          var1.removespawn = 1;
        }

        if(var10) {
          if(!isDefined(var1.removespawn)) {
            var1.spawnpoints[var1.spawnpoints.size] = var4;
          }

          continue;
        }

        var1.fallbackspawnpoints[var1.fallbackspawnpoints.size] = var4;
      }
    }
  }

  foreach(var1 in level.objectives) {
    var1.spawnset = "btm_" + var19;
    scripts\mp\spawnlogic::registerspawnset(var1.spawnset, var1.spawnpoints);
    var1.fallbackspawnset = "btm_fallback_" + var19;
    scripts\mp\spawnlogic::registerspawnset(var1.fallbackspawnset, var1.fallbackspawnpoints);
  }
}

function calculatespawndisttozones(var0) {
  var0.scriptdata.distsqtokothzones = [];

  foreach(var2 in level.objectives) {
    var3 = getpathdist(var0.origin, var2.origin, level.max_relevant_spawn_dist);

    if(var3 < 0) {
      var3 = scripts\engine\utility::distance_2d_squared(var0.origin, var2.origin);
    } else {
      var3 *= var3;
    }

    var0.scriptdata.distsqtokothzones[var2 getentitynumber()] = var3;

    if(var3 > var2.furthestspawndistsq) {
      var2.furthestspawndistsq = var3;
    }
  }
}

function setupradios() {
  var0 = [];
  var1 = getEntArray("hq_hardpoint", "targetname");

  if(var1.size < 2) {
    var0 = "There are not at least 2 entities with targetname \"radio\"";
  }

  var2 = getEntArray("radiotrigger", "targetname");

  for(var3 = 0; var3 < var1.size; var3++) {
    var4 = 0;
    var5 = var1[var3];
    var5.trig = undefined;

    for(var6 = 0; var6 < var2.size; var6++) {
      if(var5 istouching(var2[var6])) {
        if(isDefined(var5.trig)) {
          var0 = "Radio at " + var5.origin + " is touching more than one \"radiotrigger\" trigger";
          var4 = 1;
          break;
        }

        var5.trig = var2[var6];
        break;
      }
    }

    if(!isDefined(var5.trig)) {
      if(!var4) {
        var0 = "Radio at " + var5.origin + " is not inside any \"radiotrigger\" trigger";
      }

      var5.trig = spawn("trigger_radius", var5.origin, 0, 128, 128);
      var4 = 0;
    }

    var5.trigorigin = var5.trig.origin;
    var7 = [];
    var7 = var5;
    var8 = getEntArray(var5.target, "targetname");

    for(var6 = 0; var6 < var8.size; var6++) {
      var7 = var8[var6];
    }

    var5.visuals = var7;
    var5 scripts\mp\gameobjects::setmodelvisibility(0);
    var5.gameobject = scripts\mp\gameobjects::createuseobject("neutral", var5.trig, var5.visuals, var5.origin - var5.trigorigin + (0, 0, 60));
    var5.gameobject scripts\mp\gameobjects::disableobject();
    var5.gameobject scripts\mp\gameobjects::setmodelvisibility(0);
    var5.trig.useobj = var5.gameobject;
  }

  if(var0.size > 0) {
    for(var3 = 0; var3 < var0.size; var3++) {}
  }

  foreach(var10 in var1) {
    level.objectives[level.objectives.size] = var10;
  }

  level.radios = var1;
  level.radios2 = var1;
  level.prevradio = undefined;
  level.prevradio2 = undefined;
  return true;
}

function setupbtmflags() {
  var0 = getEntArray("btm_flag_primary", "targetname");

  if(var0.size == 0) {
    var1 = getEntArray("flag_primary", "targetname");
    var2 = getEntArray("flag_secondary", "targetname");

    for(var3 = 0; var3 < var1.size; var3++) {
      level.primaryflags[level.primaryflags.size] = var1[var3];
    }

    for(var3 = 0; var3 < var2.size; var3++) {
      level.primaryflags[level.primaryflags.size] = var2[var3];
    }

    thread runnormaldomflags(level, var1);
  } else {
    level.primaryflags = var0;
    level.primaryflags2 = var0;
    level.prevflag = undefined;
    level.prevflag2 = undefined;
    thread runbtmflags();
  }

  foreach(var5 in level.primaryflags) {
    level.objectives[level.objectives.size] = var5;
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
    var0 = pickflagtospawn();
    var0.script_label = "_a";
    var1 = "_a";
    var2 = scripts\mp\gametypes\obj_dom::setupobjective(var0);
    var2.origin = var0.origin;
    var2 scripts\mp\gameobjects::allowuse("none");
    var2 scripts\mp\gameobjects::setvisibleteam("any");
    var2 scripts\mp\gameobjects::setobjectivestatusicons(level.iconlocked);
    var2.ignorestomp = 1;
    level.btmflagobject = var2;
    setomnvar("ui_btm_timer", int(30000 + gettime()));
    setomnvar("ui_btm_status", 2);
    scripts\mp\utility\sound::playsoundonplayers("ui_aar_sidebar");
    wait 30;
    scripts\mp\utility\sound::playsoundonplayers("iw8_new_objective_sfx");

    foreach(var4 in level.teamnamelist) {
      scripts\mp\utility\dialog::leaderdialog("obj_capture", var4);

      if(scripts\mp\utility\teams::getteamdata(var4, "teamCount") > 0) {
        scripts\mp\utility\print::teamhudtutorialmessage("OBJECTIVES/CAPTURE_FLAG", var4, 4);
      }
    }

    level.btmflagobject scripts\mp\gameobjects::allowuse("enemy");
    level.btmflagobject scripts\mp\gametypes\obj_dom::domflag_setneutral();
    setomnvar("ui_btm_timer", int(60000 + gettime()));
    setomnvar("ui_btm_status", 3);
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 14, 14);
    wait 60;
    scripts\mp\utility\sound::playsoundonplayers("mp_sar_enemy_eliminated");

    foreach(var4 in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamdata(var4, "teamCount") > 0) {
        scripts\mp\utility\print::teamhudtutorialmessage("OBJECTIVES/OBJ_OFFLINE", var4, 4);
      }
    }

    level.btmflagobject scripts\mp\gametypes\obj_dom::domflag_setneutral();
    removedompoint(level, var1);
    level.btmflagobject = undefined;
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
    getnextobjective(level, "dom");
  }
}

function runnormaldomflags(var0, var1) {
  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    level waittill("spawn_btm_dom");
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 0, 0);

    switch (level.usedomflag) {
      case 0:
        var2 = "_b";
        break;
      case 1:
        var2 = "_a";
        break;
      case 2:
        var2 = "_c";
        break;
      default:
        var2 = "_b";
        break;
    }

    scripts\mp\spawnlogic::setactivespawnlogic("Hardpoint", "Crit_Default");
    var3 = [];

    for(var4 = 0; var4 < var0.size; var4++) {
      var3 = var0[var4];
    }

    for(var4 = 0; var4 < var1.size; var4++) {
      var3 = var1[var4];
    }

    foreach(var6 in var3) {
      if(var6.script_label == var2) {
        var7 = scripts\mp\gametypes\obj_dom::setupobjective(var6);
        var7 scripts\mp\gameobjects::allowuse("none");
        var7 scripts\mp\gameobjects::setvisibleteam("any");
        var7 scripts\mp\gameobjects::setobjectivestatusicons(level.iconlocked);
        var7.ignorestomp = 1;
        level.btmflagobject = var7;
        break;
      }
    }

    setomnvar("ui_btm_timer", int(30000 + gettime()));
    setomnvar("ui_btm_status", 2);
    scripts\mp\utility\sound::playsoundonplayers("ui_aar_sidebar");
    wait 30;
    scripts\mp\utility\sound::playsoundonplayers("iw8_new_objective_sfx");

    foreach(var10 in level.teamnamelist) {
      scripts\mp\utility\dialog::leaderdialog("obj_capture", var10);

      if(scripts\mp\utility\teams::getteamdata(var10, "teamCount") > 0) {
        scripts\mp\utility\print::teamhudtutorialmessage("OBJECTIVES/CAPTURE_FLAG", var10, 4);
      }
    }

    level.btmflagobject scripts\mp\gameobjects::allowuse("enemy");
    level.btmflagobject scripts\mp\gametypes\obj_dom::domflag_setneutral();
    setomnvar("ui_btm_timer", int(60000 + gettime()));
    setomnvar("ui_btm_status", 3);
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 14, 14);
    wait 60;
    scripts\mp\utility\sound::playsoundonplayers("mp_sar_enemy_eliminated");

    foreach(var10 in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamdata(var10, "teamCount") > 0) {
        scripts\mp\utility\print::teamhudtutorialmessage("OBJECTIVES/OBJ_OFFLINE", var10, 4);
      }
    }

    level.btmflagobject scripts\mp\gametypes\obj_dom::domflag_setneutral();
    removedompoint(level, var2);
    level.btmflagobject = undefined;
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
    getnextobjective(level, "dom");
  }
}

function updatedomscores() {
  level endon("game_ended");
  level waittill("spawn_btm_dom");
  var0 = undefined;
  var1 = undefined;

  while(!level.gameended) {
    wait 5;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!isDefined(level.scoretick)) {
      level.scoretick = [];
    }

    foreach(var3 in level.teamnamelist) {
      level.scoretick[var3] = 0;
    }

    if(isDefined(level.btmflagobject)) {
      var5 = level.btmflagobject scripts\mp\gameobjects::getownerteam();

      if(var5 == "neutral") {
        continue;
      }

      level.scoretick[var5] += level.pointsperflag;
      updatescores();
    }
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

  foreach(var2 in level.teamnamelist) {
    if(level.scoretick[var2] > 0) {
      scripts\mp\gamescore::giveteamscoreforobjective(var2, level.scoretick[var2], 1);
    }
  }
}

function removedompoint(var0) {
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
  var0 = [];
  var1 = [];

  foreach(var4, var3 in level.players) {
    if(var3.team == "spectator") {
      continue;
    }

    if(!isalive(var3)) {
      continue;
    }

    var3.dist = 0;

    if(var3.team == "allies") {
      var0 = var3;
      continue;
    }

    var1 = var3;
  }

  if(!var0.size || !var1.size) {
    if(level.primaryflags.size == 0) {
      level.primaryflags = level.primaryflags2;
    }

    for(var5 = level.primaryflags[randomint(level.primaryflags.size)]; isDefined(level.prevflag) && var5 == level.prevflag; var5 = level.primaryflags[randomint(level.primaryflags.size)]) {}

    level.prevflag2 = level.prevflag;
    level.prevflag = var5;
    return var5;
  }

  for(var6 = 0; var6 < var1.size; var6++) {
    for(var7 = var6 + 1; var7 < var1.size; var7++) {
      var8 = distancesquared(var1[var6].origin, var1[var7].origin);
      var1[var6].dist += var8;
      var1[var7].dist += var8;
    }
  }

  for(var6 = 0; var6 < var2.size; var6++) {
    for(var7 = var6 + 1; var7 < var2.size; var7++) {
      var8 = distancesquared(var2[var6].origin, var2[var7].origin);
      var2[var6].dist += var8;
      var2[var7].dist += var8;
    }
  }

  var9 = var1[0];

  foreach(var4 in var1) {
    if(var4.dist < var9.dist) {
      var9 = var4;
    }
  }

  GscBinSkip1(0x45, "allies", var9.origin);
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
    var0 = pickradiotospawn();
    makeradioactive(var0);
    scripts\mp\utility\sound::playsoundonplayers("ui_aar_sidebar");
    var1 = var0.gameobject;
    var1 scripts\mp\gameobjects::pinobjiconontriggertouch();
    var1 scripts\mp\gameobjects::setmodelvisibility(1);
    var1 scripts\mp\gameobjects::setvisibleteam("any");
    var1 scripts\mp\gameobjects::setobjectivestatusicons(level.iconlocked, level.iconlocked);
    level.radioobject = var1;
    level.hqrevealtime = gettime();

    if(level.zoneactivationdelay) {
      setomnvar("ui_btm_timer", int(30000 + gettime()));
      setomnvar("ui_btm_status", 2);
      wait level.zoneactivationdelay;
    }

    waittillframeend();
    scripts\mp\utility\sound::playsoundonplayers("iw8_new_objective_sfx");

    foreach(var3 in level.teamnamelist) {
      scripts\mp\utility\dialog::leaderdialog("obj_capture", var3);

      if(scripts\mp\utility\teams::getteamdata(var3, "teamCount") > 0) {
        scripts\mp\utility\print::teamhudtutorialmessage("OBJECTIVES/CAPTURE_HQ", var3, 4);
      }
    }

    var1 scripts\mp\gameobjects::allowuse("any");
    var1 scripts\mp\gameobjects::setusetime(level.zonecapturetime);
    var1 scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqneutral, level.iconhqneutral);
    var1 scripts\mp\gameobjects::setvisibleteam("any");
    var1.onuse = &onradiocapture;
    var1.onbeginuse = &onbeginuse;
    var1.onenduse = &onenduse;
    var1.onuncontested = &onuncontested;
    var1.oncontested = &oncontested;
    var1.id = "hardpoint";
    var1 scripts\mp\gameobjects::pinobjiconontriggertouch();
    var1 scripts\mp\gameobjects::setcapturebehavior("normal");
    level.radioobject = var1;
    setomnvar("ui_btm_timer", int(60000 + gettime()));
    setomnvar("ui_btm_status", 3);
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 16, 16);
    thread destroyhqaftertime(60);
    var5 = level scripts\engine\utility::ref_143ad("hq_captured", "hq_destroyed");

    if(var5 == "hq_captured") {
      var6 = var1 scripts\mp\gameobjects::getownerteam();
      var7 = scripts\mp\utility\game::getotherteam(var6);

      if(level.hqautodestroytime) {
        thread destroyhqaftertime(level.hqautodestroytime, var6);
      } else {
        level.hqdestroyedbytimer = 0;
      }

      for(;;) {
        var6 = var1 scripts\mp\gameobjects::getownerteam();
        var7 = scripts\mp\utility\game::getotherteam(var6);

        if(var6 == "allies") {}

        var1 scripts\mp\gameobjects::allowuse("enemy");
        var1 scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqdefend, level.iconhqcapture);

        if(!level.kothmode) {
          var1 scripts\mp\gameobjects::setusetext(&"MP_DESTROYING_HQ");
        }

        var1.onuse = &onradiodestroy;
        level waittill("hq_destroyed");

        if(!level.kothmode || level.hqdestroyedbytimer) {
          break;
        }

        thread forcespawnteam(var6);
        var1 scripts\mp\gameobjects::setownerteam(scripts\mp\utility\game::getotherteam(var6)[0]);
      }
    }

    scripts\mp\utility\sound::playsoundonplayers("mp_sar_enemy_eliminated");

    foreach(var3 in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamdata(var3, "teamCount") > 0) {
        scripts\mp\utility\print::teamhudtutorialmessage("OBJECTIVES/HQ_OFFLINE", var3, 4);
      }
    }

    var6 = var1 scripts\mp\gameobjects::getownerteam();
    var1 scripts\mp\gameobjects::allowuse("none");
    var1 scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqneutral, level.iconhqneutral);
    var1 scripts\mp\gameobjects::setownerteam("neutral");
    var1 scripts\mp\gameobjects::setmodelvisibility(0);
    makeradioinactive(var0);
    level.radioobject = undefined;

    if(var6 != "neutral") {
      thread forcespawnteam(var6, level.extradelay);
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

function forcespawnteam(var0, var1) {
  if(isDefined(var1)) {
    foreach(var3 in level.players) {
      if(isalive(var3)) {
        continue;
      }

      if(var3.pers["team"] == var0) {
        var3 scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var1 * 1000));
      }
    }

    wait var1;
  }

  foreach(var3 in level.players) {
    if(var3.pers["team"] == var0) {
      var3 scripts\mp\utility\lower_message::setlowermessageomnvar(0);

      if(!isalive(var3)) {
        var3.forcespawnnearteammates = 1;
      }

      var3 notify("force_spawn");
    }
  }
}

function onbeginuse(var0) {
  var1 = scripts\mp\gameobjects::getownerteam();

  if(var1 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqtaking, level.iconhqlosing);
    return;
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqtaking, level.iconhqlosing);
}

function onenduse(var0, var1, var2) {
  var3 = scripts\mp\gameobjects::getownerteam();

  if(var2) {
    return;
  }

  if(var3 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqneutral, level.iconhqneutral);
    return;
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqdefend, level.iconhqcapture);
}

function oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqcontested);
}

function onuncontested(var0) {
  var1 = scripts\mp\gameobjects::getownerteam();

  if(var0 == "none" || var1 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqneutral);
    return;
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.iconhqcapture, level.iconhqdefend);
}

function onradiocapture(var0) {
  var1 = var0.pers["team"];
  scripts\mp\gamescore::giveplayerscore("capture", var0);

  foreach(var3 in self.touchlist[var1]) {
    var4 = var3.player;
    var4 scripts\mp\utility\stats::incpersstat("captures", 1);
    var4 scripts\mp\persistence::statsetchild("round", "captures", var0.pers["captures"]);
  }

  var0 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "capture", var0.origin);
  var6 = scripts\mp\gameobjects::getownerteam();
  scripts\mp\gameobjects::setownerteam(var1);

  if(!level.kothmode) {
    scripts\mp\gameobjects::setusetime(level.zonecapturetime);
  }

  var7 = "axis";

  if(var1 == "axis") {
    var7 = "allies";
  }

  thread scripts\mp\utility\sound::playsoundonplayers("mp_dom_flag_captured", var1);
  thread scripts\mp\utility\sound::playsoundonplayers("mp_dom_flag_lost", var7);
  thread awardhqpoints(level);
  var0 notify("objective", "captured");
  level notify("hq_captured");
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var1, 17, 16);
}

function onradiodestroy(var0) {
  var1 = var0.pers["team"];
  var2 = "axis";

  if(var1 == "axis") {
    var2 = "allies";
  }

  scripts\mp\gamescore::giveplayerscore("capture", var0);

  foreach(var4 in self.touchlist[var1]) {
    var5 = var4.player;
    var5 scripts\mp\utility\stats::incpersstat("destructions", 1);
    var5 scripts\mp\persistence::statsetchild("round", "destructions", var0.pers["destructions"]);
  }

  var0 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "destroy", var0.origin);

  if(level.kothmode) {}

  thread scripts\mp\utility\sound::playsoundonplayers("mp_dom_flag_captured", var1);
  thread scripts\mp\utility\sound::playsoundonplayers("mp_dom_flag_lost", var2);
  level notify("hq_destroyed");

  if(level.kothmode) {
    thread awardhqpoints(level);
    return;
  }

  scripts\mp\gamescore::giveteamscoreforobjective(var1, 20);
}

function destroyhqaftertime(var0, var1) {
  level endon("game_ended");
  level endon("hq_reset");
  level notify("hq_reset_timeout");
  level endon("hq_reset_timeout");
  level.hqdestroytime = gettime() + var0 * 1000;
  level.hqdestroyedbytimer = 0;
  wait var0;
  level.hqdestroyedbytimer = 1;

  if(isDefined(var1)) {
    scripts\mp\gamescore::giveteamscoreforobjective(var1, 5);
  }

  level notify("hq_destroyed");
}

function awardhqpoints(var0) {
  level endon("game_ended");
  level endon("hq_destroyed");
  level notify("awardHQPointsRunning");
  level endon("awardHQPointsRunning");
  var1 = 12;
  var2 = 5;
  var3 = 5;
  var4 = 5;

  if(level.promode) {
    var5 = int(level.hqautodestroytime / var1);
  } else {
    var5 = 5;
  }

  var6 = 0;

  while(!level.gameended) {
    scripts\mp\gamescore::giveteamscoreforobjective(var1, 15);
    var6++;
    wait var5;
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
  var0 = [];
  var1 = [];

  foreach(var4, var3 in level.players) {
    if(var3.team == "spectator") {
      continue;
    }

    if(!isalive(var3)) {
      continue;
    }

    var3.dist = 0;

    if(var3.team == "allies") {
      var0 = var3;
      continue;
    }

    var1 = var3;
  }

  if(!var0.size || !var1.size) {
    if(level.radios.size == 0) {
      level.radios = level.radios2;
    }

    for(var5 = level.radios[randomint(level.radios.size)]; isDefined(level.prevradio) && var5 == level.prevradio; var5 = level.radios[randomint(level.radios.size)]) {}

    level.prevradio2 = level.prevradio;
    level.prevradio = var5;
    return var5;
  }

  for(var6 = 0; var6 < var1.size; var6++) {
    for(var7 = var6 + 1; var7 < var1.size; var7++) {
      var8 = distancesquared(var1[var6].origin, var1[var7].origin);
      var1[var6].dist += var8;
      var1[var7].dist += var8;
    }
  }

  for(var6 = 0; var6 < var2.size; var6++) {
    for(var7 = var6 + 1; var7 < var2.size; var7++) {
      var8 = distancesquared(var2[var6].origin, var2[var7].origin);
      var2[var6].dist += var8;
      var2[var7].dist += var8;
    }
  }

  var9 = var1[0];

  foreach(var4 in var1) {
    if(var4.dist < var9.dist) {
      var9 = var4;
    }
  }

  GscBinSkip1(0x45, "allies", var9.origin);
}

function updaterespawntimer() {
  level endon("game_ended");
  level endon("zone_moved");
  level endon("zone_destroyed");
  var0 = gettime();

  if(level.zoneduration > 0) {
    var1 = var0 + level.zoneduration * 1000;
  } else {
    var1 = var1 + scripts\mp\utility\game::gettimelimit() * 1000 - scripts\mp\utility\game::gettimepassed();
  }

  var2 = var1;

  while(var2 < var1) {
    var2 = gettime();
    level.spawndelay = (var1 - var2) / 1000;
    waitframe();
  }
}

function onteamscore(var0, var1, var2) {}

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

  foreach(var1 in level.teamnamelist) {
    scripts\mp\utility\dialog::leaderdialog("obj_capture", var1);

    if(scripts\mp\utility\teams::getteamdata(var1, "teamCount") > 0) {
      scripts\mp\utility\print::teamhudtutorialmessage("OBJECTIVES/CAPTURE_VIP", var1, 4);
    }
  }

  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 10, 10);
}

function spawnextractzones() {
  level endon("game_ended");
  level.vipextractzones = [];
  var0 = getextractionbtmflag();
  var1 = getextractionbtmflag(var0);
  setupextractgoal(var0, "allies");
  setupextractgoal(var1, "axis");
}

function getextractionbtmflag(var0) {
  var1 = 0;
  var2 = undefined;
  var3 = 1000000;

  foreach(var5 in level.primaryflags2) {
    var6 = scripts\engine\utility::distance_2d_squared(level.hostagespawnpos, var5.origin);

    if(isDefined(var0)) {
      if(var6 > var3 && var0 != var5.origin) {
        var2 = var5;
      }

      continue;
    }

    if(var6 > 1000000) {
      var2 = var5;
    }
  }

  return var2.origin;
}

function setupextractgoal(var0, var1) {
  var2 = spawn("script_model", var0);
  var2.angles = (0, 270, 0);
  var2.team = var1;
  var2.ownerteam = var1;
  var2.curorigin = var0;
  var2.offset3d = (0, 0, 32);
  var2.compassicons = [];
  var2.type = "useObject";
  var2 setModel("cop_marker_scriptable");
  var2 setscriptablepartstate("marker", "red");
  var2 playLoopSound("mp_flare_burn_lp");
  var3 = spawn("trigger_radius", var0, 0, 120, 128);
  var2 scripts\mp\gameobjects::requestid(1, 1);
  var2 scripts\mp\gameobjects::setvisibleteam("none");
  var2 scripts\mp\gameobjects::setobjectivestatusicons(level.iconextract, level.iconpreventextract);
  var3.goalent = var2;
  thread goaltriggerwatcher();
  level.vipextractzones[var1] = var3;
  waitframe();
  playFXOnTag(level._effect["vfx_smk_signal"], var2, "tag_origin");
}

function goaltriggerwatcher() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var0);

    if(isDefined(level.hostagecarrier) && var0 == level.hostagecarrier && var0.team == self.goalent.team) {
      scripts\mp\tac_ops\hostage_utility::drophostage(var0, level.hostages[0], var0.origin);
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
      scripts\mp\gamescore::giveteamscoreforobjective(var0.team, 200, 0);
      level notify("vip_scored");
      level.spawnedvip = 0;
      self.chopper thread scripts\mp\gametypes\br_extract_chopper::littlebirdleave();
      playannouncerbattlechatter(self.chopper.team, "extract_littlebird_leaving_a_friendly", 10);

      foreach(var2 in level.vipextractzones) {
        stopFXOnTag(level._effect["vfx_smk_signal"], var2.goalent, "tag_origin");
        var2.goalent stoploopsound();
        var2.goalent delete();
        var2.goalent = undefined;
        var2 delete();
      }

      thread scripts\mp\utility\sound::playsoundonplayers("mp_dom_flag_captured", var0.team);
      thread scripts\mp\utility\sound::playsoundonplayers("mp_dom_flag_lost", scripts\mp\utility\game::getotherteam(var0.team)[0]);

      foreach(var5 in level.teamnamelist) {
        if(scripts\mp\utility\teams::getteamdata(var5, "teamCount") > 0) {
          scripts\mp\utility\print::teamhudtutorialmessage("OBJECTIVES/VIP_CAPTURED", var5, 4);
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

function summonextractchopper(var0) {
  if(!isDefined(var0.chopper)) {
    var1 = scripts\mp\gametypes\br_extract_chopper::spawnextractchopper(var0, var0.origin);
    var1.invulnerable = 1;
    var0.chopper = var1;
    self iprintlnbold("Extraction copter en route!");
    var1.extractzone = var0;
    var1.extractteam = self.team;
    var0.curorigin = var0.origin;
    var0.offset3d = (0, 0, 30);
    thread extracttriggerwatcher(var0);
    return;
  }
}

function extracttriggerwatcher(var0) {
  level endon("game_ended");
  var0 endon("bugOut");
  var0 waittill("esc_littlebird_arrive");
  self.extractionactive = 1;
  playannouncerbattlechatter(var0.extractteam, "extract_littlebird_close_a_friendly", 10);
}

function playannouncerbattlechatter(var0, var1, var2) {
  level endon("game_ended");
  var3 = "ustl";
  var4 = "dx_mpa_" + var3 + "_" + var1 + "_" + var2;

  if(soundexists(var4)) {
    foreach(var6 in level.players) {
      if(var6.team == var0) {
        var6 queuedialogforplayer(var4, var1, 2);
      }
    }

    return;
  }
}

function pickviptospawn() {
  var0 = [];
  var1 = [];

  foreach(var4, var3 in level.players) {
    if(var3.team == "spectator") {
      continue;
    }

    if(!isalive(var3)) {
      continue;
    }

    var3.dist = 0;

    if(var3.team == "allies") {
      var0 = var3;
      continue;
    }

    var1 = var3;
  }

  var5 = level.primaryflags2;

  if(!var0.size || !var1.size) {
    for(var6 = var5[randomint(var5.size)]; isDefined(level.prevspawnpos) && var6 == level.prevspawnpos; var6 = var5[randomint(var5.size)]) {}

    level.prevspawnpos2 = level.prevspawnpos;
    level.prevspawnpos = var6;
    return var6.origin;
  }

  for(var7 = 0; var7 < var1.size; var7++) {
    for(var8 = var7 + 1; var8 < var1.size; var8++) {
      var9 = distancesquared(var1[var7].origin, var1[var8].origin);
      var1[var7].dist += var9;
      var1[var8].dist += var9;
    }
  }

  for(var7 = 0; var7 < var2.size; var7++) {
    for(var8 = var7 + 1; var8 < var2.size; var8++) {
      var9 = distancesquared(var2[var7].origin, var2[var8].origin);
      var2[var7].dist += var9;
      var2[var8].dist += var9;
    }
  }

  var10 = var1[0];

  foreach(var4 in var1) {
    if(var4.dist < var10.dist) {
      var10 = var4;
    }
  }

  GscBinSkip1(0x45, "allies", var10.origin);
}

function waittospawnjuggcrate() {
  level endon("game_ended");
  level waittill("spawn_btm_jugg");
  level.spawnedjugg = 1;
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  scripts\mp\utility\sound::playsoundonplayers("iw8_new_objective_sfx");

  foreach(var1 in level.teamnamelist) {
    scripts\mp\utility\dialog::leaderdialog("obj_capture", var1);

    if(scripts\mp\utility\teams::getteamdata(var1, "teamCount") > 0) {
      scripts\mp\utility\print::teamhudtutorialmessage("OBJECTIVES/CAPTURE_JUGG", var1, 4);
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

function createjuggcrate(var0, var1) {
  var2 = getgroundposition(var0, 32);
  var3 = spawn("script_model", var2 + (0, 0, 40));
  var4 = spawn("script_model", var2);
  var3.cratemodel = var4;
  var3.cratemodel.angles = var1;
  var3.cratemodel setModel("military_crate_large_stackable_01_jugg");
  var3.crateid = var3 getentitynumber();
  createjuggcrateobjective(var3);
  return var3;
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

function juggcrateused(var0) {
  activatenewjuggernaut(var0);
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
    self waittill("trigger", var0);

    if(!scripts\mp\utility\player::isreallyalive(var0)) {
      continue;
    }

    juggcrateused(var0);
    return;
  }
}

function juggcratewatchuseprogress() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger_progress", var0);
    self.usingplayer = var0;
    self.inuse = 1;
    self.lastusetime = gettime();
  }
}

function juggcratewatchstopuseprogress() {
  level endon("game_ended");
  self endon("death");
  var0 = self.inuse;

  for(var1 = self.usingplayer;; var1 = self.usingplayer) {
    wait 0.2;

    if(self.inuse) {
      if(self.lastusetime < gettime() - 200) {
        self.inuse = 0;
        self.usingplayer = undefined;
        self.lastusetime = undefined;
        continue;
      }

      var2 = isDefined(var1) && isDefined(self.usingplayer) && var1 != self.usingplayer;

      if(!var0 || var2) {
        updatejuggcrateobjectivestate(self);
      }
    } else if(var0) {
      updatejuggcrateobjectivestate(self);
    }

    var0 = self.inuse;
  }
}

function createjuggcrateobjective(var0) {
  var1 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  var0.objid = var1;
  level.juggcrateobjid = var1;
  var2 = var0.origin + (0, 0, 32);
  scripts\mp\objidpoolmanager::objective_add_objective(var1, "current", var2, level.iconlocked);
  scripts\mp\objidpoolmanager::objective_set_play_intro(var1, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(var1, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var1);
  objective_setneutrallabel(var1, "MP_MODE_RUGBY/CRATE_CAPTURE");
  objective_setfriendlylabel(var1, "MP_MODE_RUGBY/CRATE_CAPTURING");
  objective_setenemylabel(var1, "MP_MODE_RUGBY/CRATE_LOSING");
  updatejuggcrateobjectivestate(var0);
}

function updatejuggcrateobjectivestate(var0) {
  var1 = var0.objid;
  var2 = istrue(var0.inuse);

  if(var2) {
    objective_setownerteam(var1, var0.usingplayer.team);
    objective_sethot(var1, 1);
    return;
  }

  objective_setownerteam(var1, undefined);
  objective_sethot(var1, 0);
}

function activatenewjuggernaut(var0) {
  var1 = level.btm;
  var2 = spawnStruct();
  var2.player = var0;
  var3 = var0 getentitynumber();
  var2.id = var3;
  var1.activejuggernauts[var3] = var0;
  var0.btmjugginfo = var2;
  setupplayerasjugg(var0);
  createjuggobjective(var0, var2);
}

function setupplayerasjugg(var0) {
  var1 = level.btm.juggconfig;
  var0 scripts\mp\juggernaut::jugg_makejuggernaut(var1);
  var0 givemaxammo(var0.classstruct.loadoutprimaryobject);
  var0 givemaxammo(var0.classstruct.loadoutsecondaryobject);
  var0 scripts\mp\weapons::updatemovespeedscale();
  var2 = scripts\mp\utility\teams::getenemyteams(var0.team);
  var3 = var2[0];
  var0.isjuggernaut = 1;
}

function createjuggobjective(var0, var1) {
  var2 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  var1.juggobjid = var2;
  scripts\mp\objidpoolmanager::objective_add_objective(var2, "current", var0.origin, "icon_minimap_juggernaut");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var2, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(var2, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var2);
  scripts\mp\objidpoolmanager::update_objective_onentity(var2, var0);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var2, 90);
  objective_setownerteam(var2, var0.team);
  objective_setfriendlylabel(var2, "MP_INGAME_ONLY/OBJ_DEFEND_CAPS");
  objective_setenemylabel(var2, "MP_INGAME_ONLY/OBJ_KILL_CAPS");
}

function initjugg() {
  var0 = scripts\mp\juggernaut::jugg_createconfig();
  level.btm.juggconfig = var0;
  var1 = getjuggmaxhealth();
  var0.maxhealth = var1;
  var0.startinghealth = var1;
  var0.suit = "iw8_juggernaut_mp_rugby";
  var0.allows["crouch"] = 0;
  var0.allows["sprint"] = 0;
  var0.allows["usability"] = 0;
  var0.allows["weapon_switch"] = undefined;
  var0.classstruct.loadoutprimary = "iw8_lm_dblmg";
  var0.classstruct.loadoutprimaryattachments = ["holo"];
  var0.classstruct.loadoutsecondary = "iw8_pi_decho";
}

function cleanupobjectiveiconsforjugg(var0) {
  scripts\mp\objidpoolmanager::returnobjectiveid(var0.btmjugginfo.juggobjid);
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
  var0 = getfirstbtmbombloc();
  var1 = getsecondbtmbombloc(var0);
  var0 = getgroundposition(var0.origin, 64);
  var1 = getgroundposition(var1.origin, 64);
  level.resetprogress = 1;
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  var2 = getEntArray("bombzone", "targetname");
  var2 = scripts\mp\gametypes\sd::removebombzonec(var2);

  for(var3 = 0; var3 < var2.size; var3++) {
    var4 = getEntArray(var2[var3].target, "targetname");

    if(var3 == 0) {
      var2 = modifybombzonecollision(var4, var2[var3], var0);
      var2[var3].origin = var0;
      var4[0].origin = var0;
    } else {
      var2 = modifybombzonecollision(var4, var2[var3], var1);
      var2[var3].origin = var1;
      var4[0].origin = var1;
    }

    var5 = scripts\mp\gameobjects::createuseobject("neutral", var2[var3], var4, (0, 0, 64));
    var5 scripts\mp\gameobjects::allowuse("none");
    var6 = var2[var3].script_label;

    if(isDefined(var2[var3].objectivekey)) {
      var5.objectivekey = var2[var3].objectivekey;
    } else {
      var5.objectivekey = var5 scripts\mp\gameobjects::getlabel();
    }

    if(isDefined(var2[var3].iconname)) {
      var5.iconname = var2[var3].iconname;
    } else {
      var5.iconname = var5 scripts\mp\gameobjects::getlabel();
    }

    var5.id = "bomb_zone";
    var5.trigger setusepriority(-3);
    var5 scripts\mp\gameobjects::setusetime(level.planttime);
    var5 scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
    var5 scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_PLANT_EXPLOSIVES");

    if(var5.objectivekey == "_c") {
      var5.objectivekey = "_a";
      var5.iconname = "_a";
    }

    var5 scripts\mp\gameobjects::setobjectivestatusicons(level.iconlocked);
    var5 scripts\mp\gameobjects::setvisibleteam("any");
    var5.onbeginuse = &scripts\mp\gametypes\obj_bombzone::bombzone_onbeginuse;
    var5.onenduse = &scripts\mp\gametypes\obj_bombzone::bombzone_onenduse;
    var5.onuse = &scripts\mp\gametypes\obj_bombzone::bombzone_onuseplantobject;
    var5.oncantuse = &scripts\mp\gametypes\obj_bombzone::bombzone_oncantuse;
    var5.useweapon = getcompleteweaponname("briefcase_bomb_mp");
    var5.bombplanted = 0;
    var5.bombexploded = undefined;
    var5.resetprogress = level.resetprogress;

    for(var7 = 0; var7 < var4.size; var7++) {
      if(isDefined(var4[var7].script_exploder)) {
        var5.exploderindex = var4[var7].script_exploder;
        var4[var7] thread scripts\mp\gametypes\obj_bombzone::setupkillcament(var5);
        break;
      }
    }

    var5.bombdefusetrig = getEnt(var4[0].target, "targetname");
    var5.bombdefusetrig.origin += (0, 0, -10000);
    var5.bombdefusetrig.label = var6;
    var5.noweapondropallowedtrigger = spawn("trigger_radius", var5.trigger.origin, 0, 140, 100);
    level.objectives[var5.objectivekey] = var5;
    level.bombzones[level.bombzones.size] = var5;
  }

  setomnvar("ui_btm_timer", int(30000 + gettime()));
  setomnvar("ui_btm_status", 2);
  wait 30;

  foreach(var5 in level.bombzones) {
    var5 scripts\mp\gameobjects::allowuse("any");
    var5 scripts\mp\gameobjects::setobjectivestatusicons(level.iconplant);
  }

  setomnvar("ui_btm_timer", 0);
  setomnvar("ui_btm_status", -1);
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 20, 20);
}

function applybombstoplayers() {
  foreach(var1 in level.players) {
    if(!isai(var1)) {
      var1 setclientomnvar("ui_carrying_bomb", 1);
      var1.isplanting = 0;
      var1.isdefusing = 0;
      var1.isbombcarrier = 1;
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

function bombhandler(var0, var1, var2) {
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

  if(var1 == "explode") {
    self.bombexploded = 1;
    self.bombplanted = 0;
    scripts\mp\gameobjects::releaseid();
    scripts\mp\gamescore::giveteamscoreforobjective(var0.team, 100);

    if(level.bombexploded > 1) {
      level.objectiveselector.objectivetypes[4] = "skip";
      getnextobjective(level, "dd");
      return;
    }

    return;
  }

  var0 notify("bomb_defused" + self.objectivekey);
  self notify("defused");
  resetbombzone();
}

function getsecondbtmbombloc(var0) {
  var1 = 1000000;
  var2 = [];
  var3 = [];

  foreach(var6, var5 in level.players) {
    if(var5.team == "spectator") {
      continue;
    }

    if(!isalive(var5)) {
      continue;
    }

    var5.dist = 0;

    if(var5.team == "allies") {
      var2 = var5;
      continue;
    }

    var3 = var5;
  }

  var7 = level.primaryflags2;

  if(!var2.size || !var3.size) {
    for(var8 = var7[randomint(var7.size)]; isDefined(level.prevbomb) && var8 == level.prevbomb; var8 = var7[randomint(var7.size)]) {}

    level.prevbomb2 = level.prevbomb;
    level.prevbomb = var8;
    return var8;
  }

  for(var9 = 0; var9 < var3.size; var9++) {
    for(var10 = var9 + 1; var10 < var3.size; var10++) {
      var11 = distancesquared(var3[var9].origin, var3[var10].origin);
      var3[var9].dist += var11;
      var3[var10].dist += var11;
    }
  }

  for(var9 = 0; var9 < var4.size; var9++) {
    for(var10 = var9 + 1; var10 < var4.size; var10++) {
      var11 = distancesquared(var4[var9].origin, var4[var10].origin);
      var4[var9].dist += var11;
      var4[var10].dist += var11;
    }
  }

  var12 = var3[0];

  foreach(var6 in var3) {
    if(var6.dist < var12.dist) {
      var12 = var6;
    }
  }

  GscBinSkip1(0x45, "allies", var12.origin);
}

function getfirstbtmbombloc() {
  var0 = [];
  var1 = [];

  foreach(var4, var3 in level.players) {
    if(var3.team == "spectator") {
      continue;
    }

    if(!isalive(var3)) {
      continue;
    }

    var3.dist = 0;

    if(var3.team == "allies") {
      var0 = var3;
      continue;
    }

    var1 = var3;
  }

  var5 = level.primaryflags2;

  if(!var0.size || !var1.size) {
    for(var6 = var5[randomint(var5.size)]; isDefined(level.prevbomb) && var6 == level.prevbomb; var6 = var5[randomint(var5.size)]) {}

    level.prevbomb2 = level.prevbomb;
    level.prevbomb = var6;
    return var6;
  }

  for(var7 = 0; var7 < var1.size; var7++) {
    for(var8 = var7 + 1; var8 < var1.size; var8++) {
      var9 = distancesquared(var1[var7].origin, var1[var8].origin);
      var1[var7].dist += var9;
      var1[var8].dist += var9;
    }
  }

  for(var7 = 0; var7 < var2.size; var7++) {
    for(var8 = var7 + 1; var8 < var2.size; var8++) {
      var9 = distancesquared(var2[var7].origin, var2[var8].origin);
      var2[var7].dist += var9;
      var2[var8].dist += var9;
    }
  }

  var10 = var1[0];

  foreach(var4 in var1) {
    if(var4.dist < var10.dist) {
      var10 = var4;
    }
  }

  GscBinSkip1(0x45, "allies", var10.origin);
}

function modifybombzonecollision(var0, var1, var2) {
  var3 = var1.origin;
  var4 = modifiedbombzones(var1, var3, var0, var2);
  return var4;
}

function modifiedbombzones(var0, var1, var2, var3) {
  var2[0].origin = var3;
  var2[0].angles = (0, 0, 0);
  var0.origin = var3;
  var0.angles = (0, 0, 0);
  setmodifiedbombzonescollision((0, 0, 35), (0, 0, 0), var1, var2);
  setexplodermodel(var1, var2);
  return var0;
}

function setmodifiedbombzonescollision(var0, var1, var2, var3) {
  var4 = getEntArray("script_brushmodel", "classname");

  foreach(var6 in var4) {
    if(isDefined(var6.script_gameobjectname) && var6.script_gameobjectname == "bombzone") {
      if(distance(var6.origin, var2) < 100) {
        var7 = spawn("script_model", var3[0].origin + var0);
        var7.angles = var1;
        var7 clonebrushmodeltoscriptmodel(var6);
        var7 disconnectPaths();
        var6 delete();
        break;
      }
    }
  }
}

function setexplodermodel(var0, var1) {
  var2 = getEntArray("script_model", "classname");

  for(var3 = 0; var3 < var2.size; var3++) {
    if(isDefined(var2[var3].script_exploder)) {
      if(isDefined(var2[var3].targetname) && var2[var3].targetname == "exploder" && distance(var2[var3].origin, var0) < 100) {
        var2[var3].origin = var1[0].origin;
        var2[var3].angles = var1[0].angles;
      }
    }
  }
}

function getspawnpoint() {
  var0 = self.pers["team"];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var0 + "_start");
    var2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var1);
  } else {
    if(isDefined(level.radioobject)) {
      var1 = removespawnsinactivehq(level.radioobject.spawnpoints);
      var3 = removespawnsinactivehq(level.radioobject.fallbackspawnpoints);
      var4 = getobjzonedeadzonedist();
      var5 = [];
      GscBinSkip0(0x2e, "activeKOTHZoneNumber", level.radioobject.visuals[0] getentitynumber());
    }

    if(isDefined(level.btmflagobject)) {
      var1 = removespawnsinactiveflag(level.btmflagobject.trigger.spawnpoints);
      var3 = removespawnsinactiveflag(level.btmflagobject.trigger.fallbackspawnpoints);
      var4 = getobjzonedeadzonedist();
      var5 = [];
      GscBinSkip0(0x2e, "activeKOTHZoneNumber", level.btmflagobject.trigger getentitynumber());
    }

    var2 = scripts\mp\spawnlogic::getspawnpoint(self, var5, "normal", "fallback");
  }

  return var2;
}

function getobjzonedeadzonedist() {
  return level.spawn_deadzone_dist;
}

function removespawnsinactivehq(var0) {
  var1 = [];

  if(isDefined(var0)) {
    foreach(var3 in var0) {
      if(!ispointinvolume(var3.origin, level.radioobject.trigger)) {
        var1 = var3;
      }
    }
  }

  return var1;
}

function removespawnsinactiveflag(var0) {
  var1 = [];

  if(isDefined(var0)) {
    foreach(var3 in var0) {
      if(!ispointinvolume(var3.origin, level.btmflagobject.trigger)) {
        var1 = var3;
      }
    }
  }

  return var1;
}

function forcespawnplayers() {
  var0 = level.players;

  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = var0[var1];

    if(!isDefined(var2) || isalive(var2)) {
      continue;
    }

    var2 notify("force_spawn");
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

function movezoneaftertime(var0) {
  level endon("game_ended");
  level endon("zone_reset");
  level endon("dev_force_zone");
  level.zonemovetime = var0;
  level.zonedestroyedbytimer = 0;
  scripts\mp\gametypes\obj_zonecapture::zonetimerwait();
  level.zonedestroyedbytimer = 1;
  level notify("zone_moved");
  level notify("zone_destroyed");
}

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isPlayer(var1) || var1.team == self.team) {
    return;
  }

  if(var1 == self) {
    return;
  }

  if(isDefined(level.radioobject)) {
    var10 = level.radioobject.ownerteam;

    if(!isDefined(var10)) {
      return;
    }

    if(isDefined(var4) && scripts\mp\utility\weapon::iskillstreakweapon(var4.basename)) {
      return;
    }

    var11 = self;
    var12 = 0;
    var13 = var1.team;

    if(level.zonecapturetime > 0 && var1 istouching(level.radioobject.trigger)) {
      if(var10 != var13) {
        var12 = 1;
      }
    }

    if(var13 != var10) {
      if(var11 istouching(level.radioobject.trigger)) {
        if(var12) {
          var1 thread scripts\mp\utility\points::giveunifiedpoints("capture_kill");
        }

        var1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
        thread scripts\common\utility::ref_13e0a(level.ref_11b24.ref_11b30, var9, "defending");
      }
    } else if(var1 istouching(level.radioobject.trigger)) {
      if(var12) {
        var1 thread scripts\mp\utility\points::giveunifiedpoints("capture_kill");
      }

      var1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
      var1 scripts\mp\utility\stats::incpersstat("defends", 1);
      var1 scripts\mp\persistence::statsetchild("round", "defends", var1.pers["defends"]);
      var1 scripts\mp\utility\stats::setextrascore1(var1.pers["defends"]);
    }
  }

  if(istrue(level.spawnedjugg)) {
    if(var3 == "MOD_SUICIDE" && var4.basename == "none" && isDefined(self.wasswitchingteamsforonplayerkilled)) {
      return;
    }

    var11 = self;

    if(isDefined(var11.isjuggernaut)) {
      level.spawnedjugg = 0;

      if(isDefined(var11.juggoverlay)) {
        var11.juggoverlay destroy();
      }

      var11.playerstreakspeedscale = undefined;
      var11.nostuckdamagekill = 0;
      var11 scripts\mp\utility\player::_setsuit("iw8_defaultsuit_mp");
      cleanupobjectiveiconsforjugg(var11);
    }

    if(isDefined(var1) && isPlayer(var1)) {
      var14 = 0;
      var15 = 0;
      var16 = 0;
      var17 = 0;
      var18 = 0;
      var19 = 0;

      if(var1.team != var11.team) {
        if(isDefined(var11.isjuggernaut)) {
          if(isDefined(var1.isjuggernaut)) {
            var15 = 1;
          } else {
            var16 = 1;
          }
        } else if(isDefined(var1.isjuggernaut)) {
          var17 = 1;
        }
      }

      if(var16) {
        var1 thread scripts\mp\utility\points::giveunifiedpoints("kill_juggernaut");
        var19 = level.ppkonjugg;
      } else if(var15) {
        var19 = level.ppkjuggonjugg;
      } else if(var17) {
        var19 = level.ppkasjugg;
      }

      if(var19) {
        var1 scripts\mp\gamescore::giveteamscoreforobjective(var1.pers["team"], var19);
      }

      if(var1.team != var11.team && game["state"] == "postgame" && game["teamScores"][var1.team] > game["teamScores"][level.otherteam[var1.team]]) {
        var1.finalkill = 1;
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

function getnextobjective(var0) {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  if(isDefined(var0)) {
    level.objectiveselector.prevobj = var0;

    for(;;) {
      var1 = randomint(level.objectiveselector.objectivetypes.size);

      if(var0 != level.objectiveselector.objectivetypes[var1] && level.objectiveselector.objectivetypes[var1] != "skip") {
        break;
      }

      waitframe();
    }

    setomnvar("ui_btm_timer", int(45000 + gettime()));
    setomnvar("ui_btm_status", 1);
    wait 45;
  } else {
    var1 = randomint(level.objectiveselector.objectivetypes.size);
    setomnvar("ui_btm_timer", int(60000 + gettime()));
    setomnvar("ui_btm_status", 1);
    wait 60;
  }

  switch (var1) {
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

function give_capture_credit(var0, var1, var2, var3, var4) {
  level endon("game_ended");
  level.lastcaptime = gettime();
  var5 = var4;

  if(isDefined(var5.owner)) {
    var5 = var5.owner;
  }

  if(isPlayer(var5)) {
    if(!isscoreboosting(var5)) {
      var5 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "capture", var5.origin);
      var5 thread scripts\mp\awards::givemidmatchaward("mode_hp_secure");

      if(isDefined(level.radioobject.lastactivatetime) && gettime() - level.radioobject.lastactivatetime <= 2100) {
        var5 thread scripts\mp\awards::givemidmatchaward("mode_hp_quick_cap");
      }

      if(var5.lastkilltime + 500 > gettime()) {} else {
        var5 scripts\mp\gametypes\obj_zonecapture::setcrankedtimerzonecap(var5);
      }
    }
  }

  var6 = getarraykeys(var0);

  for(var7 = 0; var7 < var6.size; var7++) {
    var8 = var0[var6[var7]].player;
    updatecapsperminute(var8, var3);

    if(!isscoreboosting(var8)) {
      var8 scripts\mp\utility\stats::incpersstat("captures", 1);
      var8 scripts\mp\persistence::statsetchild("round", "captures", var8.pers["captures"]);
    }

    wait 0.05;
  }
}

function updatecapsperminute(var0) {
  if(!isDefined(self.capsperminute)) {
    self.numcaps = 0;
    self.capsperminute = 0;
  }

  if(!isDefined(var0) || var0 == "neutral") {
    return;
  }

  self.numcaps++;
  var1 = scripts\mp\utility\game::gettimepassed() / 60000;

  if(isPlayer(self) && isDefined(self.timeplayed["total"])) {
    var1 = self.timeplayed["total"] / 60;
  }

  self.capsperminute = self.numcaps / var1;

  if(self.capsperminute > self.numcaps) {
    self.capsperminute = self.numcaps;
    return;
  }
}

function isscoreboosting(var0) {
  if(var0.capsperminute > 3) {
    return true;
  }

  return false;
}

function onplayerconnect(var0) {
  var0._hardpointeffect = [];
  var0.numcaps = 0;
  var0.capsperminute = 0;
  var0.timebyrotation = [];
  var0 scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var0.pers["captures"])) {
    var0 scripts\mp\utility\stats::setextrascore0(var0.pers["captures"]);
  }

  var0 scripts\mp\utility\stats::setextrascore1(0);

  if(isDefined(var0.pers["defends"])) {
    var0 scripts\mp\utility\stats::setextrascore1(var0.pers["defends"]);
  }

  thread onplayerspawned(var0);
}

function onplayerspawned(var0) {
  for(;;) {
    var0 waittill("spawned");
  }
}

function getownerteamplayer(var0) {
  var1 = undefined;

  foreach(var3 in level.players) {
    if(var3.team == var0) {
      var1 = var3;
      break;
    }
  }

  return var1;
}

function getrespawndelay() {
  if(!level.delayplayer) {
    return undefined;
  }

  if(!isDefined(level.radioobject)) {
    return undefined;
  }

  var0 = level.radioobject.ownerteam;

  if(isDefined(var0)) {
    if(self.pers["team"] == var0) {
      if(!level.spawndelay) {
        return undefined;
      }

      return level.spawndelay;
    }

    return;
  }
}

function onnormaldeath(var0, var1, var2, var3, var4, var5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4, var5);
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