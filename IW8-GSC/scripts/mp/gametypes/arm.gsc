/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\arm.gsc
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
  setdynamicdvar("scr_btm_zoneLifetime", getmatchrulesdata("kothData", "zoneLifetime"));
  setdynamicdvar("scr_btm_zoneCaptureTime", getmatchrulesdata("kothData", "zoneCaptureTime"));
  setdynamicdvar("scr_btm_zoneActivationDelay", getmatchrulesdata("kothData", "zoneActivationDelay"));
  setdynamicdvar("scr_btm_randomLocationOrder", getmatchrulesdata("kothData", "randomLocationOrder"));
  setdynamicdvar("scr_btm_additiveScoring", getmatchrulesdata("kothData", "additiveScoring"));
  setdynamicdvar("scr_btm_pauseTime", getmatchrulesdata("kothData", "pauseTime"));
  setdynamicdvar("scr_btm_delayPlayer", getmatchrulesdata("kothData", "delayPlayer"));
  setdynamicdvar("scr_btm_useHQRules", getmatchrulesdata("kothData", "useHQRules"));
  setdynamicdvar("scr_btm_spawndelay", getmatchrulesdata("tdefData", "spawnDelay"));
  scripts\mp\utility\game::registerhalftimedvar("arm", 0);
}

function onstartgametype() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  setclientnamemode("auto_change");
  level.objectives = [];
  level.uncapturableobjectives = [];
  initspawns();
  seticonnames();
  level.usedomflag = 0;
  level.killstreakqueue = [];
  level.teamkillstreakqueue = [];
  level.teamkillstreakqueue["allies"] = [];
  level.teamkillstreakqueue["axis"] = [];
  level.killstreaklist = [];
  level.killstreaklist[4] = ["cruise_predator", "scrambler_drone_guard"];
  level.killstreaklist[3] = ["precision_airstrike", "multi_airstrike", "bradley"];
  level.killstreaklist[2] = ["toma_strike", "chopper_gunner", "pac_sentry", "gunship"];
  level.teamkillstreakqueue["allies"] = ["cruise_predator", "precision_airstrike", "cruise_predator"];
  level.teamkillstreakqueue["axis"] = ["cruise_predator", "precision_airstrike", "cruise_predator"];
  thread setupwaypointicons();
  debug_setupmatchdata();
  ref_1324d();
  calculatehqmidpoint();

  if(istrue(level.useobjectives)) {
    setupobjectives();
  }

  thread runobjectives();

  if(level.usec130spawn) {
    thread managec130spawns();
  }

  if(istrue(level.userallypointvehicles)) {
    scripts\mp\rally_point::init();
    thread init_rallyvehicles();
  }

  thread init_groundwarvehicles();
  thread updatedomscores();
  scripts\mp\utility\dialog::initstatusdialog();

  if(istrue(level.ref_11bd2)) {
    thread ref_11eee();
  }

  monitordriverexitbutton();

  if(istrue(level.ref_1408c)) {
    scripts\cp_mp\vehicles\vehicle_compass::calloutmarkerping_init();
  }

  scripts\cp_mp\parachute::initparachutedvars();
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.pausescoring = scripts\mp\utility\dvars::dvarintvalue("pauseTime", 1, 0, 1);
  level.delayplayer = scripts\mp\utility\dvars::dvarintvalue("delayPlayer", 1, 0, 1);
  level.spawndelay = scripts\mp\utility\dvars::dvarfloatvalue("spawnDelay", 5, 0, 30);
  level.usehqrules = 1;
  level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("flagCaptureTime", 30, 0, 30);
  level.flagsrequiredtoscore = scripts\mp\utility\dvars::dvarintvalue("flagsRequiredToScore", 1, 1, 3);
  level.pointsperflag = scripts\mp\utility\dvars::dvarintvalue("pointsPerFlag", 1, 1, 300);
  level.flagneutralization = scripts\mp\utility\dvars::dvarintvalue("flagNeutralization", 0, 0, 1);
  level.precappoints = scripts\mp\utility\dvars::dvarintvalue("preCapPoints", 0, 0, 1);
  level.capturedecay = scripts\mp\utility\dvars::dvarintvalue("captureDecay", 1, 0, 1);
  level.capturetype = scripts\mp\utility\dvars::dvarintvalue("captureType", 1, 0, 3);
  level.numflagsscoreonkill = scripts\mp\utility\dvars::dvarintvalue("numFlagsScoreOnKill", 0, 0, 3);
  level.objectivescaler = scripts\mp\utility\dvars::dvarfloatvalue("objScalar", 4, 1, 10);

  if(getdvarint("allow_team_proxchat", 0) == 1) {
    setDvar("LKTPRPKPMR", 1);
    var_0 = 1000;
    var_1 = getdvarint("proxchat_radius_override", 0);

    if(var_1 != 0) {
      var_0 = var_1;
    }

    setDvar("NNMLSMNTOQ", var_0);
    return;
  }
}

function seticonnames() {
  level.iconcapture = "waypoint_capture";
  level.iconneutral = "waypoint_captureneutral";
  level.icondefend = "waypoint_defend";
  level.iconcontested = "waypoint_contested";
  level.icondefending = "waypoint_defending";
  level.icontaking = "waypoint_taking";
  level.iconlosing = "waypoint_losing";
}

function monitordriverexitbutton() {
  scripts\cp_mp\utility\game_utility::ref_12c10("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::ref_12c10("vehicle_volume", "script_noteworthy");
  scripts\cp_mp\utility\game_utility::ref_12c10("vehicle_volume_simplified", "script_noteworthy");
  scripts\cp_mp\utility\game_utility::ref_12c10("super", "script_noteworthy");
  scripts\cp_mp\utility\game_utility::ref_12c10("militarybase", "script_noteworthy");
  scripts\cp_mp\utility\game_utility::ref_12c10("location_volume", "targetname");
  scripts\cp_mp\utility\game_utility::ref_12c10("locale_area_trigger", "targetname");
  scripts\cp_mp\utility\game_utility::ref_12c10("shadow_blocker", "targetname");
  scripts\cp_mp\utility\game_utility::ref_12c11("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::ref_12c11("veh8_mil_air_acharlie130", 1);
  scripts\cp_mp\utility\game_utility::ref_12c11("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::ref_12c11("me_electrical_box_street_01", 1);
  scripts\cp_mp\utility\game_utility::ref_12c0f("light");
  scripts\cp_mp\utility\game_utility::ref_12c0f("trigger_use_touch");

  if(isDefined(level.localeid) && level.localeid == "locale_6") {
    scripts\cp_mp\utility\game_utility::ref_12c10("locale_8", "script_noteworthy");
  }

  var_0 = [];
  GscBinSkip0(0x2e, 0, (-22592, 27367, 1000));
}

function ref_12c14() {
  wait 5;
  var_0 = [];
  GscBinSkip0(0x2e, 0, "tactical_cover_col");
}

function debug_setupmatchdata() {
  level.axishqname = "gw_fob_axisHQ";
  level.allieshqname = "gw_fob_alliesHQ";
  level.startingfobnames_allies = [];
  level.startingfobnames_axis = [];
  level.startingfobnames_neutral = ["gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05"];
  level.defaultaxisspawn = "gw_fob_axishq";
  level.defaultaxisspawncamera = "gw_fob_axishq";
  level.defaultalliesspawn = "gw_fob_allieshq";
  level.defaultalliesspawncamera = "gw_fob_allieshq";
}

function setupwaypointicons() {
  while(!isDefined(game["killstreakTable"])) {
    waitframe();
  }

  foreach(var_2, var_1 in game["killstreakTable"].tabledatabyref) {
    level.waypointcolors[var_2 + "_incoming"] = "neutral";
    level.waypointbgtype[var_2 + "_incoming"] = 1;
    level.waypointstring[var_2 + "_incoming"] = "";
    level.waypointshader[var_2 + "_incoming"] = var_1["hudIcon"];
    level.waypointpulses[var_2 + "_incoming"] = 0;
    level.waypointcolors[var_2] = "neutral";
    level.waypointbgtype[var_2] = 1;
    level.waypointstring[var_2] = "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS";
    level.waypointshader[var_2] = var_1["hudIcon"];
  }
}

function ref_1324d() {
  level.gw_objstruct = spawnStruct();
  level.gw_objstruct.axishqloc = spawnStruct();
  level.gw_objstruct.axishqloc.trigger = scripts\cp_mp\utility\game_utility::getlocaleent(level.axishqname);

  if(isDefined(level.gw_objstruct.axishqloc)) {}

  level.gw_objstruct.allieshqloc = spawnStruct();
  level.gw_objstruct.allieshqloc.trigger = scripts\cp_mp\utility\game_utility::getlocaleent(level.allieshqname);

  if(!isDefined(level.gw_objstruct.allieshqloc)) {
    return;
  }
}

function setupobjectives() {
  level.gw_objstruct.startingfobs_allies = [];
  level.gw_objstruct.startingfobs_axis = [];
  level.gw_objstruct.startingfobs_neutral = [];
  var_0 = ["_a", "_b", "_c", "_d", "_e"];
  var_1 = 0;

  foreach(var_3 in level.startingfobnames_allies) {
    var_4 = spawnStruct();
    var_4.name = var_3;
    var_4.trigger = scripts\cp_mp\utility\game_utility::getlocaleent(var_3);
    var_4.trigger.objkey = var_0[var_1];
    var_1++;
    level.gw_objstruct.startingfobs_allies[level.gw_objstruct.startingfobs_allies.size] = var_4;
  }

  foreach(var_3 in level.startingfobnames_axis) {
    var_4 = spawnStruct();
    var_4.name = var_3;
    var_4.trigger = scripts\cp_mp\utility\game_utility::getlocaleent(var_3);
    var_4.trigger.objkey = var_0[var_1];
    var_1++;
    level.gw_objstruct.startingfobs_axis[level.gw_objstruct.startingfobs_axis.size] = var_4;
  }

  foreach(var_3 in level.startingfobnames_neutral) {
    var_4 = spawnStruct();
    var_4.name = var_3;
    var_4.trigger = scripts\cp_mp\utility\game_utility::getlocaleent(var_3);
    var_4.trigger.objkey = var_0[var_1];
    var_1++;
    level.gw_objstruct.startingfobs_neutral[level.gw_objstruct.startingfobs_neutral.size] = var_4;
  }
}

function updatedomscores() {
  level endon("game_ended");
  var_0 = undefined;
  var_1 = undefined;
  level waittill("prematch_done");
  level thread scripts\mp\spawnselection::ref_13fd9();

  while(!level.gameended) {
    wait 10;
    scripts\mp\hostmigration::waittillhostmigrationdone();
    var_2 = getowneddomflags();

    if(!isDefined(level.scoretick)) {
      level.scoretick = [];
    }

    foreach(var_4 in level.teamnamelist) {
      level.scoretick[var_4] = 0;
    }

    if(var_2.size) {
      for(var_6 = 1; var_6 < var_2.size; var_6++) {
        var_7 = var_2[var_6];
        var_8 = gettime() - var_7.capturetime;

        for(var_9 = var_6 - 1; var_9 >= 0 && var_8 > gettime() - var_2[var_9].capturetime; var_9--) {
          var_2 = var_2[var_9];
        }

        var_2 = var_7;
      }

      foreach(var_7 in var_2) {
        var_11 = var_7 scripts\mp\gameobjects::getownerteam();
        var_0 = getteamscore(var_11);
        var_12 = scripts\mp\gametypes\obj_dom::getteamflagcount(var_11);

        if(var_12 >= level.flagsrequiredtoscore) {
          level.scoretick[var_11] += level.pointsperflag;
        }
      }
    }

    updatescores();
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

function runobjectives(var_0) {
  level.axisspawnareas = [level.axishqname];
  level.alliesspawnareas = [level.allieshqname];
  level.allfobs = [];

  if(istrue(level.useobjectives)) {
    foreach(var_2 in level.gw_objstruct.startingfobs_axis) {
      var_3 = runobjflag(var_2.trigger, "axis");
      level.allfobs[level.allfobs.size] = var_2;
      level.axisspawnareas[level.axisspawnareas.size] = var_2.name;

      if(isDefined(level.spawnselectionlocations[var_2.name]["axis"].anchorentity)) {
        level.spawnselectionlocations[var_2.name]["axis"].anchorentity.origin = var_2.trigger.origin + (0, 0, 100);
      }
    }

    foreach(var_2 in level.gw_objstruct.startingfobs_allies) {
      var_3 = runobjflag(var_2.trigger, "allies");
      level.allfobs[level.allfobs.size] = var_2;
      level.alliesspawnareas[level.alliesspawnareas.size] = var_2.name;

      if(isDefined(level.spawnselectionlocations[var_2.name]["allies"].anchorentity)) {
        level.spawnselectionlocations[var_2.name]["allies"].anchorentity.origin = var_2.trigger.origin + (0, 0, 100);
      }
    }

    foreach(var_2 in level.gw_objstruct.startingfobs_neutral) {
      var_3 = runobjflag(var_2.trigger, "neutral");
      level.allfobs[level.allfobs.size] = var_2;
    }

    foreach(var_2 in level.allfobs) {
      var_2.trigger.gameobject.oncontested = &objective_oncontested;
      var_2.trigger.gameobject.onuncontested = &objective_onuncontested;
      var_2.trigger.gameobject.onuse = &objective_onuse;
      var_2.trigger.gameobject.onbeginuse = &objective_onusebegin;
      var_2.trigger.gameobject.onenduse = &objective_onuseend;
      var_2.trigger.gameobject.onpinnedstate = &objective_onpinnedstate;
      var_2.trigger.gameobject.onunpinnedstate = &objective_onunpinnedstate;

      if(istrue(level.playinggulagbink)) {
        var_2.ref_136cd = &scripts\mp\gametypes\obj_dom::ref_136ce;
      }

      level.objectives[var_2.trigger.gameobject.objectivekey] = var_2.trigger.gameobject;
      level.spawnselectionlocations[var_2.name]["allies"].objectivekey = var_2.trigger.gameobject.objectivekey;
      level.spawnselectionlocations[var_2.name]["axis"].objectivekey = var_2.trigger.gameobject.objectivekey;
    }
  }

  if(level.usesquadspawnselection) {
    scripts\mp\spawnselection::setspawnlocations(level.axisspawnareas, "axis");
    scripts\mp\spawnselection::setspawnlocations(level.alliesspawnareas, "allies");
    sethqmarkerobjective();

    while(!isDefined(level.spawnselectionlocations)) {
      waitframe();
    }

    waitframe();

    if(isDefined(level.spawnselectionlocations[level.axishqname]["axis"].anchorentity)) {
      level.spawnselectionlocations[level.axishqname]["axis"].anchorentity.origin = level.gw_objstruct.axishqloc.trigger.origin;
    }

    if(isDefined(level.spawnselectionlocations[level.allieshqname]["allies"].anchorentity)) {
      level.spawnselectionlocations[level.allieshqname]["allies"].anchorentity.origin = level.gw_objstruct.allieshqloc.trigger.origin;
    }
  }

  thread objective_manageobjectivesintrovisibility();
  hackfixcameras();
  thread brking_getspawnpoint();
}

function brking_getspawnpoint() {
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(var_1 in level.allfobs) {
    var_1.trigger.gameobject scripts\mp\gameobjects::allowuse("enemy");
  }
}

function objective_manageobjectivesintrovisibility() {
  wait 1;
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.axishqloc.marker.objidnum);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.allieshqloc.marker.objidnum);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.axishqloc.nuclear_core_on_chopper.objidnum);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.allieshqloc.nuclear_core_on_chopper.objidnum);

  foreach(var_1 in level.allfobs) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_1.trigger.gameobject.objidnum);
  }

  if(isDefined(level.rallypointvehicles)) {
    foreach(var_4 in level.rallypointvehicles) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_4.marker.objidnum);
    }
  }

  while(!scripts\mp\flags::gameflag("prematch_done")) {
    waitframe();
  }

  scripts\mp\objidpoolmanager::objective_teammask_addtomask(level.gw_objstruct.axishqloc.marker.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(level.gw_objstruct.allieshqloc.marker.objidnum, "allies");

  foreach(var_1 in level.allfobs) {
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_1.trigger.gameobject.objidnum);
  }

  if(isDefined(level.rallypointvehicles)) {
    foreach(var_4 in level.rallypointvehicles) {
      if(isDefined(var_4)) {
        scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_4.marker.objidnum, var_4.team);
      }
    }

    return;
  }
}

function hackfixcameras() {
  if(istrue(level.usestaticspawnselectioncamera)) {
    return;
  }

  while(!isDefined(level.spawncameras["gw_fob_alliesHQ"])) {
    waitframe();
  }

  var_0 = "allies";
  var_1 = level.spawnselectionteamforward[var_0];
  var_2 = ["gw_fob_alliesHQ", "gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05"];

  foreach(var_4 in var_2) {
    var_5 = level.spawnselectionlocations[var_4][var_0].anchorentity.origin;
    var_6 = var_5 + var_1 * -8500 + (0, 0, 7000);
    var_7 = vectorNormalize(var_5 - var_6);
    var_8 = scripts\mp\utility\script::vectortoanglessafe(var_7, (0, 0, 1));

    if(istrue(level.useunifiedspawnselectioncameraheight)) {
      var_9 = scripts\mp\spawnselection::getunifedspawnselectioncameraheight();
      var_6 = (var_6[0], var_6[1], var_9);
    }

    var_6 += calculatecameraoffset(var_0, var_5);
    level.spawncameras[var_4][var_0].origin = var_6;
    level.spawncameras[var_4][var_0].angles = var_8;
  }

  while(!isDefined(level.spawncameras["gw_fob_axisHQ"])) {
    waitframe();
  }

  var_0 = "axis";
  var_1 = level.spawnselectionteamforward[var_0];
  var_2 = ["gw_fob_axisHQ", "gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05"];

  foreach(var_4 in var_2) {
    var_5 = level.spawnselectionlocations[var_4][var_0].anchorentity.origin;
    var_6 = var_5 + var_1 * -8500 + (0, 0, 7000);
    var_7 = vectorNormalize(var_5 - var_6);
    var_8 = scripts\mp\utility\script::vectortoanglessafe(var_7, (0, 0, 1));

    if(istrue(level.useunifiedspawnselectioncameraheight)) {
      var_9 = scripts\mp\spawnselection::getunifedspawnselectioncameraheight();
      var_6 = (var_6[0], var_6[1], var_9);
    }

    var_6 += calculatecameraoffset(var_0, var_5);
    level.spawncameras[var_4][var_0].origin = var_6;
    level.spawncameras[var_4][var_0].angles = var_8;
  }
}

function updatefobspawnselection() {
  level.axisspawnareas = [level.axishqname];
  level.alliesspawnareas = [level.allieshqname];

  foreach(var_1 in level.allfobs) {
    var_2 = var_1.trigger.gameobject;

    if(var_2.ownerteam == "axis") {
      level.axisspawnareas[level.axisspawnareas.size] = var_1.name;

      if(isDefined(level.spawnselectionlocations[var_1.name]["axis"].anchorentity)) {
        level.spawnselectionlocations[var_1.name]["axis"].anchorentity.origin = var_1.trigger.origin + (0, 0, 100);
      }

      continue;
    }

    if(var_2.ownerteam == "allies") {
      level.alliesspawnareas[level.alliesspawnareas.size] = var_1.name;

      if(isDefined(level.spawnselectionlocations[var_1.name]["allies"].anchorentity)) {
        level.spawnselectionlocations[var_1.name]["allies"].anchorentity.origin = var_1.trigger.origin + (0, 0, 100);
      }
    }
  }

  scripts\mp\spawnselection::setspawnlocations(level.axisspawnareas, "axis");
  scripts\mp\spawnselection::setspawnlocations(level.alliesspawnareas, "allies");
}

function sethqmarkerobjective() {
  var_0 = "any";
  var_1 = level.gw_objstruct.axishqloc.trigger.origin;
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "neutral", (0, 0, 0), undefined, var_0, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "icon_waypoint_hq_friendly");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 6);
  var_2.lockupdatingicons = 1;
  level.gw_objstruct.axishqloc.marker = var_2;
  level.uncapturableobjectives[level.uncapturableobjectives.size] = var_2;
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "neutral", (0, 0, 0), undefined, var_0, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "icon_waypoint_hq_enemy");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 7);
  var_2.lockupdatingicons = 1;
  level.gw_objstruct.axishqloc.nuclear_core_on_chopper = var_2;
  level.uncapturableobjectives[level.uncapturableobjectives.size] = var_2;
  var_1 = level.gw_objstruct.allieshqloc.trigger.origin;
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "neutral", (0, 0, 0), undefined, var_0, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "icon_waypoint_hq_friendly");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 6);
  var_2.lockupdatingicons = 1;
  level.gw_objstruct.allieshqloc.marker = var_2;
  level.uncapturableobjectives[level.uncapturableobjectives.size] = var_2;
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "neutral", (0, 0, 0), undefined, var_0, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "icon_waypoint_hq_enemy");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 7);
  var_2.lockupdatingicons = 1;
  level.gw_objstruct.allieshqloc.nuclear_core_on_chopper = var_2;
  level.uncapturableobjectives[level.uncapturableobjectives.size] = var_2;
  level.spawnselectionteamforward = [];
  level.spawnselectionteamforward["allies"] = vectorNormalize(level.gw_objstruct.axishqloc.trigger.origin - level.gw_objstruct.allieshqloc.trigger.origin);
  level.spawnselectionteamforward["axis"] = vectorNormalize(level.gw_objstruct.allieshqloc.trigger.origin - level.gw_objstruct.axishqloc.trigger.origin);
}

function spawnselection_showenemyhq() {
  self endon("disconnect");

  if(self.team == "allies") {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.allieshqloc.marker.objidnum, self);
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.axishqloc.nuclear_core_on_chopper.objidnum, self);
  } else {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.allieshqloc.nuclear_core_on_chopper.objidnum, self);
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.axishqloc.marker.objidnum, self);
  }

  while(self.inspawnselection) {
    waitframe();
  }

  if(self.team == "axis") {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct.allieshqloc.nuclear_core_on_chopper.objidnum, self);
    return;
  }

  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct.axishqloc.nuclear_core_on_chopper.objidnum, self);
}

function objective_oncontested() {
  scripts\mp\gametypes\obj_dom::dompoint_oncontested();

  if(!istrue(self.updatedoncontestedspawnselection)) {
    updatefobspawnselection();
    self.updatedoncontestedspawnselection = 1;
    return;
  }
}

function objective_onuncontested(var_0) {
  scripts\mp\gametypes\obj_dom::dompoint_onuncontested(var_0);

  if(istrue(self.updatedoncontestedspawnselection)) {
    updatefobspawnselection();
    self.updatedoncontestedspawnselection = 0;
    return;
  }
}

function objective_onusebegin(var_0) {
  scripts\mp\gametypes\obj_dom::dompoint_onusebegin(var_0);
  updatefobspawnselection();
}

function objective_onuseend(var_0, var_1, var_2) {
  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var_0, var_1, var_2);
  updatefobspawnselection();
}

function objective_onuse(var_0) {
  scripts\mp\gametypes\obj_dom::dompoint_onuse(var_0);
  updatefobspawnselection();
}

function objective_onuseupdate(var_0, var_1, var_2, var_3) {}

function objective_onpinnedstate(var_0) {
  updatefobspawnselection();
  scripts\mp\gametypes\obj_dom::dompoint_onunpinnedstate(var_0);
}

function objective_onunpinnedstate(var_0) {
  updatefobspawnselection();
  scripts\mp\gametypes\obj_dom::dompoint_onunpinnedstate(var_0);
}

function dommainloop() {}

function runobjflag(var_0, var_1) {
  level endon("game_ended");

  while(!isDefined(level.spawnselectionlocations)) {
    waitframe();
  }

  var_0.script_label = var_0.objkey;
  var_2 = scripts\mp\gametypes\obj_dom::setupobjective(var_0, undefined, undefined, undefined, 0);
  var_2.origin = var_0.origin;
  var_2 scripts\mp\gameobjects::allowuse("none");
  var_2.didstatusnotify = 0;
  var_2 scripts\mp\gameobjects::setownerteam(var_1);
  var_3 = "any";

  if(var_1 != "neutral") {
    if(level.hideenemyfobs) {
      var_3 = "friendly";
    }

    var_2.capturetime = gettime();
  }

  var_2 scripts\mp\gameobjects::setvisibleteam(var_3);
  return var_2;
}

function dropcrate(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\killstreaks\airdrop::droparmcratefromscriptedheli(var_2, var_0, var_1.origin, (0, randomint(360), 0), undefined);
  return var_3;
}

function docratedropsmoke(var_0, var_1, var_2) {
  var_3 = var_1.origin + (0, 0, 2000);
  var_4 = scripts\common\utility::groundpos(var_3, (0, 0, 1));
  var_1.vfxent = spawn("script_model", var_4);
  var_1.vfxent setModel("tag_origin");
  var_1.vfxent.angles = (0, 0, 0);
  var_1.vfxent playLoopSound("smoke_carepackage_smoke_lp");
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_gr"), var_1.vfxent, "tag_origin");

  if(isDefined(var_0)) {
    var_0 scripts\engine\utility::ref_143b9(var_2, "crate_dropped");
  } else {
    wait var_2;
  }

  stopFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_gr"), var_1.vfxent, "tag_origin");
  var_1.vfxent delete();
}

function addkillstreakstoqueue(var_0) {
  level.killstreaklist[var_0] = scripts\engine\utility::array_randomize(level.killstreaklist[var_0]);

  foreach(var_2 in level.killstreaklist[var_0]) {
    level.killstreakqueue[level.killstreakqueue.size] = var_2;
  }
}

function dropdefconkillstreaks(var_0) {
  level.activezone.airdroplocations[var_0] = scripts\engine\utility::array_randomize(level.activezone.airdroplocations[var_0]);

  for(var_1 = 0; var_1 < 3; var_1++) {
    var_2 = level.activezone.airdroplocations[var_0][var_1];

    if(isDefined(var_2)) {
      var_2.isinside = 0;
      thread runkillstreakreward(level, var_2.origin);
      wait randomfloatrange(1.5, 2.5);
    }
  }
}

function registervaliddroplocations() {
  scripts\cp_mp\killstreaks\airdrop::initplundercratedata();
  level.validdroplocationstruct = spawnStruct();
  level.validdroplocationstruct.clusters = scripts\engine\utility::getStructArray("dropBagCluterNode", "script_noteworthy");
  var_0 = scripts\engine\utility::getStructArray("dropBagLocation", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2.inuse = 0;

    foreach(var_4 in level.validdroplocationstruct.clusters) {
      if(var_2.target == var_4.targetname) {
        if(!isDefined(var_4.droplocations)) {
          var_4.droplocations = [];
        }

        var_4.droplocations[var_4.droplocations.size] = var_2;
      }
    }
  }

  level.nextkillstreakgoal = 100;

  if(false) {
    thread debug_testcratedroplocationpicker();
    return;
  }
}

function debug_testcratedroplocationpicker() {
  for(;;) {
    choosecratelocation();
    wait 1;
  }
}

function checkkillstreakcratedrop(var_0) {
  if(game["teamScores"][var_0] >= level.nextkillstreakgoal) {
    level.nextkillstreakgoal += 100;
    dropkillstreakcrates(2);
    return;
  }
}

function dropkillstreakcrates(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(isDefined(var_3)) {
      var_1 = var_3;
      break;
    }
  }

  for(var_5 = 0; var_5 < var_0; var_5++) {
    var_6 = choosecratelocation();
    thread runkillstreakreward(var_6, var_1, getkillstreak(1));
    wait 5;
  }
}

function choosecratelocation() {
  var_0 = randomfloatrange(0, 1);
  var_1 = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, var_0);
  var_2 = vectorlerp(level.c130pathstruct_b.endpt, level.c130pathstruct_b.startpt, var_0);
  var_3 = vectorlerp(var_1, var_2, 0.5);
  var_4 = scripts\engine\trace::ray_trace(var_3, var_3 - (0, 0, 100000));
  var_3 = var_4["position"];
  var_5 = findclosestdroplocation(var_3);

  if(false) {
    debugsphereonlocation(var_1, (0, 0, 1), 100);
    debugsphereonlocation(var_2, (0, 0, 1), 100);
    debugsphereonlocation(var_3, (1, 0, 0), 100);
    debugsphereonlocation(var_5.origin, (0, 1, 0), 100);
    thread scripts\mp\utility\debug::drawline(var_3, var_5.origin, 3, (0, 1, 0));
  }

  return var_5;
}

function findclosestdroplocation(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0;
  var_2 = var_1 scripts\engine\utility::array_sort_with_func(level.validdroplocationstruct.clusters, &sortlocationsbydistance);

  foreach(var_4 in var_2) {
    var_5 = scripts\engine\utility::array_randomize(var_4.droplocations);

    if(false) {
      return var_5[0];
    }

    foreach(var_7 in var_5) {
      if(!var_7.inuse) {
        var_7.inuse = 1;
        return var_7;
      }
    }
  }

  return undefined;
}

function choosenukecratelocation() {
  var_0 = randomfloatrange(level.mapsafecorners[1][0], level.mapsafecorners[0][0]);
  var_1 = randomfloatrange(level.mapsafecorners[1][1], level.mapsafecorners[0][1]);
  var_2 = (var_0, var_1, 100000);
  var_3 = scripts\engine\trace::ray_trace(var_2, var_2 - (0, 0, 100000));
  var_2 = var_3["position"];
  var_4 = findclosestdroplocation(var_2);

  if(false) {
    debugsphereonlocation(var_2, (1, 0, 0), 100);
    debugsphereonlocation(var_4.origin, (0, 1, 0), 100);
    thread scripts\mp\utility\debug::drawline(var_2, var_4.origin, 3, (0, 1, 0));
  }

  return var_4;
}

function runkillstreakreward(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = undefined;
  var_4 = scripts\mp\gameobjects::createobjidobject(var_0.origin, "neutral", (0, 0, 72), undefined, "any");
  var_4.origin = var_0.origin;
  var_4.angles = var_0.angles;
  thread docratedropsmoke(undefined, var_0, 16);
  var_4.iconname = "_incoming";
  var_4.lockupdatingicons = 0;
  var_4 scripts\mp\gameobjects::setobjectivestatusicons(var_2);
  var_4.lockupdatingicons = 1;
  wait 4;
  var_3 = scripts\cp_mp\killstreaks\airdrop::droparmcratefromscriptedheli(var_1.team, var_2, var_0.origin, (0, randomint(360), 0), undefined);
  var_3.skipminimapicon = 1;
  var_3.nevertimeout = 0;
  var_3.waitforobjectiveactivate = 1;
  var_3.killminimapicon = 0;
  var_3.disallowheadiconid = 1;
  var_3.isarmcrate = 1;
  var_3 waittill("crate_dropped");
  var_4.useobj = var_3;
  var_4.origin = var_3.origin;
  var_5 = 0;
  var_6 = 0.1;
  wait 1;
  var_3 notify("objective_activate");
  scripts\mp\objidpoolmanager::update_objective_onentity(var_4.objidnum, var_3);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var_4.objidnum, 72);
  var_4.iconname = "";
  var_4.lockupdatingicons = 0;
  var_4 scripts\mp\gameobjects::setobjectivestatusicons(var_2);
  var_4.lockupdatingicons = 1;
  objective_setlabel(var_4.objidnum, "");
  var_3 waittill("death");
  var_4 scripts\mp\gameobjects::setvisibleteam("none");
  var_4 scripts\mp\gameobjects::releaseid();
  var_4.visibleteam = "none";
}

function getkillstreak(var_0) {
  if(!isDefined(level.killstreaktierlist)) {
    processkillstreaksintotiers();
  }

  level.killstreaktierlist[var_0] = scripts\engine\utility::array_randomize(level.killstreaktierlist[var_0]);
  return level.killstreaktierlist[var_0][0];
}

function processkillstreaksintotiers() {
  level.killstreaktierlist = [];
  level.killstreaktierlist[3] = ["cruise_predator", "scrambler_drone_guard", "uav"];
  level.killstreaktierlist[2] = ["precision_airstrike", "multi_airstrike", "bradley"];
  level.killstreaktierlist[1] = ["toma_strike", "uav", "pac_sentry", "white_phosphorus"];
  level.killstreaktierlist[0] = ["uav"];
}

function br_getrewardicon(var_0) {
  return level.killstreakglobals.streaktable.tabledatabyref[var_0]["hudIcon"];
}

function ref_11eee() {
  scripts\mp\flags::gameflagwait("prematch_done");

  if(istrue(level.useobjectives)) {
    thread ref_11eef();
    return;
  }
}

function ref_11eef() {
  level endon("game_ended");
  level endon("mercy_ending_timer_started");

  for(;;) {
    if(freeze_bomb_case_timer("axis") == level.objectives.size) {
      thread ref_11ef6(level);
    } else if(freeze_bomb_case_timer("allies") == level.objectives.size) {
      thread ref_11ef6(level);
    }

    waitframe();
  }
}

function ref_11ef6(var_0) {
  level notify("mercy_ending_timer_started");
  level endon("mercy_ending_triggered");
  setomnvar("ui_arm_dominatingTeam", scripts\engine\utility::ter_op(var_0 == "axis", 1, 2));
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 9, 2, 1);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 0, 9, level.ref_11bd3);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 1);
  var_1 = 0;
  var_2 = gettime();
  var_3 = level.ref_11bd3 * 1000 + var_2;
  setomnvar("ui_nuke_end_milliseconds", level.ref_11bd3 * 1000 + var_2);

  while(freeze_bomb_case_timer(var_0) == level.objectives.size) {
    waitframe();

    if(gettime() > var_3) {
      ref_11ef9(var_0);
      level notify("mercy_ending_triggered");
    }
  }

  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 0);
  thread ref_11eef();
}

function ref_11ef9(var_0) {
  level endon("game_ended");
  level.ref_11bd4 = 1;
  level.blocknukekills = 1;

  foreach(var_2 in level.objectives) {
    var_2 scripts\mp\gameobjects::allowuse("none");
  }

  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 0);

  foreach(var_5 in level.players) {
    if(isDefined(var_5) && !isbot(var_5) && istrue(var_5.inspawnselection)) {
      if(isDefined(var_5.ref_12135)) {
        var_5 clearsoundsubmix("iw8_mp_spawn_camera");
        var_5.ref_12135 stoploopsound(var_5.ref_12136);
        var_5.ref_12135 delete();
        var_5.ref_12135 = undefined;
        var_5.ref_12136 = undefined;
      }
    }
  }

  if(isDefined(level.teamdata[var_0]["alivePlayers"][0])) {
    var_7 = level.teamdata[var_0]["alivePlayers"][0];
    var_7 _calloutmarkerping_handleluinotify_acknowledged::tryusenuke();
    return;
  }

  level thread scripts\mp\gamelogic::endgame(var_0, game["end_reason"]["mercy_win"], game["end_reason"]["mercy_loss"], 0, 1);
}

function nukeselectgimmewatcher(var_0) {
  if(!istrue(var_0.hasnukeselectks)) {
    var_1 = var_0.killcountthislife % level.killstoearnnukeselect;

    if(var_1 >= 0 && var_0.killcountthislife >= level.killstoearnnukeselect) {
      var_0.hasnukeselectks = 1;
      var_0 thread scripts\mp\killstreaks\killstreaks::givekillstreak("nuke_select_location", 0, 0, var_0);
      var_0 scripts\mp\hud_message::showkillstreaksplash("nuke_select_location", undefined, 1);
      return;
    }

    return;
  }
}

function initspawns(var_0) {
  level.gamemodestartspawnpointnames = [];

  if(istrue(var_0)) {
    var_1 = "mp_gw_spawn_allies_start";
    var_2 = "mp_gw_spawn_axis_start";
    var_3 = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_allies_start_mod");

    if(var_3.size > 0) {
      var_1 = "mp_gw_spawn_allies_start_mod";
    }

    var_4 = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_axis_start_mod");

    if(var_4.size > 0) {
      var_2 = "mp_gw_spawn_axis_start_mod";
    }
  } else {
    var_1 = "mp_gw_spawn_allies_start";
    var_2 = "mp_gw_spawn_axis_start";
  }

  level.gamemodestartspawnpointnames["allies"] = var_1;
  level.gamemodestartspawnpointnames["axis"] = var_2;
  level.gamemodespawnpointnames = [];
  level.gamemodespawnpointnames["allies"] = "mp_tdm_spawn";
  level.gamemodespawnpointnames["axis"] = "mp_tdm_spawn";
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);

  if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_aniyah") {
    scripts\mp\spawnlogic::setactivespawnlogic("GroundWarTTLOS", "Crit_Default");
  } else if(scripts\cp_mp\utility\game_utility::islargemap()) {
    scripts\mp\spawnlogic::setactivespawnlogic("GroundWar", "Crit_Default");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  }

  scripts\mp\spawnlogic::addstartspawnpoints(var_1);
  scripts\mp\spawnlogic::addstartspawnpoints(var_2);
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], var_1);
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], var_2);
  var_5 = scripts\mp\spawnlogic::getspawnpointarray(var_1);
  var_6 = scripts\mp\spawnlogic::getspawnpointarray(var_2);
  scripts\mp\spawnlogic::registerspawnset("start_attackers", var_5);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", var_6);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  var_7 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  var_8 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", var_7);
  scripts\mp\spawnlogic::registerspawnset("fallback", var_8);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.spawnpoints = var_7;
}

function calculatespawndisttozones(var_0) {
  var_0.scriptdata.distsqtokothzones = [];

  foreach(var_2 in level.objectives) {
    var_3 = getpathdist(var_0.origin, var_2.origin, 5000);

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

function getspawnpoint() {
  var_0 = self.pers["team"];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(var_0 == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "start_attackers");
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_1, undefined, "start_defenders");
    }
  } else {
    scripts\mp\spawnlogic::activatespawnset("normal", 1);
    var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_1, undefined, "fallback");
  }

  if(istrue(level.usesquadspawn) && istrue(self.squadspawnconfirmed)) {
    var_2 = self getspectatingplayer();

    if(isDefined(var_2) && isDefined(self.squadindex) && self.team == var_2.team && self.squadindex == var_2.squadindex) {
      var_1 = scripts\mp\spawnscoring::findteammatebuddyspawn(var_2);
    }
  }

  return var_1;
}

function onspawnplayer() {
  self.forcespawnnearteammates = undefined;
  thread updatematchstatushintonspawn();
  scripts\mp\menus::updatesquadomnvars(self.team, self.squadindex);
}

function updatematchstatushintonspawn() {
  level endon("game_ended");

  if(isDefined(level.nukeprogress)) {
    self setclientomnvar("ui_match_status_hint_text", 28);
    return;
  }

  self setclientomnvar("ui_match_status_hint_text", 27);
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  scripts\mp\menus::updatesquadomnvars(self.team, self.squadindex);
  scripts\mp\gametypes\obj_dom::awardgenericmedals(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(level.nukeselectactive && isPlayer(var_1) && var_3 != "MOD_SUICIDE") {
    if(!isDefined(var_1.killcountthislife)) {
      var_1.killcountthislife = 0;
    }

    if(!istrue(var_1.hasnukeselectks)) {
      var_1.killcountthislife++;
    }

    nukeselectgimmewatcher(var_1);
  }

  if(!isDefined(level.c130pathkilltracker) || level.c130movementmethod != 1) {
    return;
  }

  level.c130pathkilltracker[self.team] += 1;
}

function managedroppedents(var_0) {
  if(!isDefined(level.br_droppedloot)) {
    level.br_droppedloot = [];
  }

  if(level.br_droppedloot.size > 64) {
    for(var_1 = 0; var_1 < 16; var_1++) {
      if(isDefined(level.br_droppedloot[var_1])) {
        level.br_droppedloot[var_1] delete();
        level.br_droppedloot[var_1] = undefined;
      }
    }

    var_2 = [];
    var_1 = 16;

    if(var_1 < level.br_droppedloot.size) {
      GscBinSkip0(0x2e, var_1 - 16, level.br_droppedloot[var_1]);
    }

    level.br_droppedloot = var_2;
  }

  foreach(var_4 in var_0) {
    level.br_droppedloot[level.br_droppedloot.size] = var_4;
  }

  if(!isDefined(level.br_pickups.droppeditems)) {
    level.br_pickups.droppeditems = [];
  }

  if(level.br_pickups.droppeditems.size > 64) {
    for(var_1 = 0; var_1 < 16; var_1++) {
      if(isDefined(level.br_pickups.droppeditems[var_1])) {
        level.br_pickups.droppeditems[var_1] delete();
        level.br_pickups.droppeditems[var_1] = undefined;
      }
    }

    var_2 = [];
    var_1 = 16;

    if(var_1 < level.br_pickups.droppeditems.size) {
      GscBinSkip0(0x2e, var_1 - 16, level.br_pickups.droppeditems[var_1]);
    }

    level.br_pickups.droppeditems = var_2;
    return;
  }
}

function onplayerconnect(var_0) {
  if(isDefined(level.rallypointvehicles)) {
    thread scripts\mp\rally_point::rallypoint_showtoplayer(var_0);
  }

  if(istrue(level.ref_1408c)) {
    var_0 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_initplayer();
  }

  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
}

function onplayerdisconnect(var_0) {
  thread scripts\mp\spawnselection::ref_12acb(var_0.team, var_0.squadindex);
}

function updategamemodespawncamera() {
  var_0 = "lane02_4";

  if(isDefined(level.activezone)) {
    var_0 = level.activezone.zonetrigger.script_label;
  }

  scripts\mp\spawncamera::setgamemodecamera("allies", level.spawncameras[var_0]["allies"]);
  scripts\mp\spawncamera::setgamemodecamera("axis", level.spawncameras[var_0]["axis"]);
}

function debugdrawtocameras() {
  for(;;) {
    wait 0.25;

    if(!isDefined(level.players[0])) {
      continue;
    }

    foreach(var_1 in level.spawncameras) {
      foreach(var_3 in var_1) {
        thread scripts\mp\utility\debug::drawangles(var_3.origin, var_3.angles, 0.25, 50);
        thread scripts\mp\utility\debug::drawsphere(var_3.origin, 50, 0.25, scripts\engine\utility::ter_op(var_4 == "allies", (0, 0, 1), (1, 0, 0)));
      }
    }
  }
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
  self.spawncameraskipthermal = 0;
  return undefined;
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
}

function spawnspectate(var_0, var_1) {
  self setspectatedefaults(var_0, var_1);
  self spawn(var_0, var_1);
  scripts\mp\utility\player::ref_12898("arm::spawnSpectate() !!!CODE SPAWN!!! @" + var_0);
}

function ref_12065() {
  if(!isDefined(self.sessionteam) || self.sessionteam == "spectator" || self.sessionteam == "none" || self calloutmarkerping_getEnt()) {
    return true;
  }

  if(isDefined(self.thrust_fx_model)) {
    return false;
  }

  var_0 = scripts\mp\spawnlogic::getspawnpointarray(level.gamemodestartspawnpointnames[self.sessionteam]);
  var_1 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_0);
  self.thrust_fx_model = var_1;
  spawnspectate(var_1.origin, var_1.angles);
  return false;
}

function ref_125f1() {
  return self.sessionstate == "spectator" && isDefined(self.thrust_fx_model);
}

function initspecatatorcameras() {
  level.spectatorcameras = [];
  level.currentspectatorcamref = "cop_2";
  var_0 = scripts\engine\utility::getStructArray("tac_ops_map_config", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2.script_noteworthy;
    var_4 = scripts\engine\utility::getStructArray(var_2.target, "targetname");

    foreach(var_6 in var_4) {
      switch (var_6.script_label) {
        case "to_allies_camera":
          setteammapposition(var_3, "allies", var_6);
          break;
        case "to_axis_camera":
          setteammapposition(var_3, "axis", var_6);
          break;
      }
    }
  }
}

function setteammapposition(var_0, var_1, var_2) {
  if(!isDefined(level.spectatorcameras[var_0])) {
    level.spectatorcameras[var_0] = [];
  }

  level.spectatorcameras[var_0][var_1] = var_2;
}

function applythermal() {
  self visionsetthermalforplayer("proto_apache_flir_mp");
  self thermalvisionon();
}

function removethermal() {
  self thermalvisionoff();
}

function startspectatorview() {
  if(scripts\mp\utility\game::isteamreviveenabled()) {
    return;
  }

  waitframe();
  scripts\mp\utility\player::updatesessionstate("spectator");
  scripts\mp\spectating::setdisabled();

  if(isDefined(self.lastdeathangles)) {
    self setplayerangles(self.lastdeathangles);
  }

  wait 0.1;
  scripts\mp\utility\player::setdof_default();
  var_0 = 0;
  var_1 = undefined;
  var_2 = (0, 0, 0);
  var_3 = 1000;
  var_4 = self.origin + (0, 0, var_3);
  var_5 = self.angles;
  self.deathspectatepos = var_4;
  self.deathspectateangles = var_5;
  var_6 = spawn("script_model", self getvieworigin());
  var_6 setModel("tag_origin");
  var_6.angles = var_5;
  self.spectatorcament = var_6;
  self.isusingtacopsmapcamera = 1;
  self cameralinkTo(var_6, "tag_origin", 1);
  thread dohalfwayflash();
  movecameratomappos(var_6, self, var_4, var_5);
}

function dohalfwayflash() {
  wait 0.4;
  thread playslamzoomflash();
  applythermal();
}

function endspectatorview() {
  if(!isDefined(self.spectatorcament)) {
    return;
  }

  removethermal();
  thread runslamzoomonspawn();
}

function movecameratomappos(var_0, var_1, var_2) {
  var_0 endon("spawned_player");
  var_3 = 1;
  var_4 = 1;
  self moveTo(var_1, 2, 1, 1);
  var_0 playlocalsound("mp_cmd_camera_zoom_out");
  var_0 setclienttriggeraudiozonepartialwithfade("spawn_cam", 0.5, "mix");
  self rotateTo(var_2, 2, 1, 1);
  wait 1.1;
  var_5 = anglesToForward(var_2) * 300;
  var_5 *= (1, 1, 0);

  if(isDefined(var_0) && isDefined(var_0.spectatorcament)) {
    self moveTo(var_1 + var_5, 15, 1, 1);
    var_0 earthquakeforplayer(0.03, 15, var_1 + var_5, 1000);
    return;
  }
}

function runslamzoomonspawn() {
  self waittill("spawned_player");
  var_0 = self getEye();
  var_1 = self.angles;
  scripts\mp\utility\player::updatesessionstate("spectator");
  self cameralinkTo(self.spectatorcament, "tag_origin", 1);
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.2);
  self.spectatorcament moveTo(var_0, 0.5);
  self playlocalsound("mp_cmd_camera_zoom_in");
  self clearclienttriggeraudiozone(0.5);
  self.spectatorcament rotateTo(var_1, 0.5, 0.5);
  wait 0.5;

  if(!isDefined(self)) {
    return;
  }

  self visionsetnakedforplayer("", 0);
  thread playslamzoomflash();
  scripts\mp\utility\player::updatesessionstate("playing");
  self cameraunlink();
  self.spectatorcament delete();
}

function playslamzoomflash() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 1;
  var_0.foreground = 1;
  var_0 setshader("white", 640, 480);
  var_0 fadeovertime(0.4);
  var_0.alpha = 0;
  wait 0.4;
  var_0 destroy();
}

function arm_playstatusdialog(var_0, var_1) {
  var_2 = "dx_mpa_ustl_" + var_0;
  var_2 = tolower(var_2);
  var_3 = undefined;

  if(var_1 == "bothTeams") {
    var_4 = scripts\mp\utility\teams::getteamdata("axis", "players");
    var_5 = scripts\mp\utility\teams::getteamdata("allies", "players");
    var_3 = scripts\engine\utility::array_combine(var_4, var_5);
  } else if(var_1 == "axis" || var_1 == "allies") {
    var_3 = scripts\mp\utility\teams::getteamdata(var_1, "players");
  }

  foreach(var_7 in var_3) {
    if(!isbot(var_7)) {
      arm_leaderdialogonplayer_internal(var_7, var_2, var_0);
    }
  }
}

function arm_playstatusdialogonplayer(var_0) {
  var_1 = "dx_mpa_ustl_announcer_" + var_0;
  var_1 = tolower(var_1);
  arm_leaderdialogonplayer_internal(var_1, var_0);
}

function arm_leaderdialogonplayer_internal(var_0, var_1) {
  if(isDefined(self.playerlastdialogstatus)) {
    var_2 = 5000;

    if(gettime() < self.playerlastdialogstatus["time"] + var_2 && self.playerlastdialogstatus["dialog"] == var_1) {
      return;
    }

    self.playerlastdialogstatus["time"] = gettime();
    self.playerlastdialogstatus["dialog"] = var_1;
  }

  if(soundexists(var_0)) {
    self queuedialogforplayer(var_0, var_1, 2);
    return;
  }
}

function managec130spawns() {
  level endon("game_ended");
  var_0 = 6000;
  var_1 = 12000;
  var_2 = 20000;
  var_3 = 1;
  var_4 = (0, 0, 6000);
  level.timebetweenc130passes = 0;
  level.flighttime = 20;
  level.spawnc130 = [];

  foreach(var_6 in level.teamnamelist) {
    level.spawnc130[var_6] = undefined;
  }

  c130_pickrandomflightpath();
  level.spawnc130["axis"] = createc130("axis", level.c130pathstruct_a.startpt + var_4);
  level.spawnc130["allies"] = createc130("allies", level.c130pathstruct_b.startpt + var_4);

  while(!isDefined(level.spawnselectionlocations)) {
    waitframe();
  }

  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    if(!isDefined(level.timeuntilnextc130)) {
      level.timeuntilnextc130 = [];
    }

    if(!isDefined(level.timeuntilnextc130["axis"])) {
      level.timeuntilnextc130["axis"] = 0;
    }

    if(!isDefined(level.timeuntilnextc130["allies"])) {
      level.timeuntilnextc130["allies"] = 0;
    }

    var_8 = gettime() + (level.flighttime + level.timebetweenc130passes) * 1000;
    level.timeuntilnextc130["axis"] = var_8;
    level.timeuntilnextc130["allies"] = var_8;

    if(false) {
      thread scripts\mp\utility\debug::drawline(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 1000, (1, 0, 0));
      thread scripts\mp\utility\debug::drawline(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 1000, (0, 0, 1));
    }

    if(var_3) {
      thread handlec130motion(level.spawnc130["axis"], level.c130pathstruct_a.startpt + var_4, level.c130pathstruct_a.endpt + var_4, level.flighttime);
      thread handlec130motion(level.spawnc130["allies"], level.c130pathstruct_b.startpt + var_4, level.c130pathstruct_b.endpt + var_4, level.flighttime);
    } else {
      thread handlec130motion(level.spawnc130["axis"], level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, level.flighttime);
      thread handlec130motion(level.spawnc130["allies"], level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, level.flighttime);
    }

    level.c130firstpassstarted = 1;
    level scripts\engine\utility::waittill_all_in_array(["C130_path_complete_axis", "C130_path_complete_allies"]);
    c130_fightpathmove();
    var_9 = level.c130pathstruct_a.startpt;
    level.c130pathstruct_a.startpt = level.c130pathstruct_a.endpt;
    level.c130pathstruct_a.endpt = var_9;
    var_9 = level.c130pathstruct_b.startpt;
    level.c130pathstruct_b.startpt = level.c130pathstruct_b.endpt;
    level.c130pathstruct_b.endpt = var_9;
    var_3 = 0;

    if(istrue(level.usec130spawnfirstonly)) {
      level.usec130spawn = 0;
      break;
    }
  }

  scripts\mp\spawnselection::removedynamicspawnarea("axis", "dynamic_c130");
  scripts\mp\spawnselection::removedynamicspawnarea("allies", "dynamic_c130");
  scripts\mp\spawnselection::removespawnlocation("dynamic_c130", "axis");
  scripts\mp\spawnselection::removespawnlocation("dynamic_c130", "allies");
  level.spawnc130["axis"] delete();
  level.spawnc130["allies"] delete();
}

function createc130(var_0, var_1) {
  var_2 = spawn("script_model", var_1);
  var_2 setModel("veh8_mil_air_acharlie130");
  var_2 setCanDamage(0);
  var_2.maxhealth = 100000;
  var_2.health = var_2.maxhealth;
  var_2.playeroffsets = [(32, 30, 0), (-32, 30, 0), (0, 30, 0), (16, 30, 0), (-16, 30, 0)];
  var_2.currentplayeroffset = 0;
  var_2.respawnqueue = [];
  var_2.players = [];
  var_2.team = var_0;
  var_2 playLoopSound("iw8_ks_ac130_lp");
  var_2 thread scripts\mp\gametypes\br_public::gunship_spawnvfx();
  return var_2;
}

function handlec130motion(var_0, var_1, var_2, var_3) {
  var_4 = vectorNormalize(var_1 - var_0);
  var_5 = distance(var_1, var_0);
  var_6 = var_0 + var_4 * var_5 * 0.425;
  var_7 = var_0 + var_4 * var_5 * 0.55;
  var_8 = var_2 * 0.3;
  var_9 = var_2 * 0.6;
  var_10 = var_2 * 0.1;
  self.canjoin = 1;
  self.canparachute = 0;
  var_11 = vectorNormalize(var_1 - var_0);
  self.angles = vectortoangles(var_11);
  self.origin = var_0;
  gatherc130playerstospawn();
  self moveTo(var_1, var_8 + var_9 + var_10, var_8 * 0.25);
  wait var_8;
  self.canparachute = 1;

  foreach(var_13 in self.players) {
    var_13 notify("canParachute");
  }

  wait var_9;
  self.canjoin = 0;
  self.canparachute = 0;

  foreach(var_13 in self.players) {
    var_13 notify("halo_kick_c130");
  }

  wait var_10;
  level notify("C130_path_complete_" + var_3);
}

function gatherc130playerstospawn() {
  self.players = scripts\engine\utility::array_combine(self.players, self.respawnqueue);
  self.respawnqueue = [];
  var_0 = 1400;
  var_1 = (30, 0, 0);
  var_2 = anglesToForward(var_1) * var_0 * -1;
  var_3 = self gettagorigin("tag_origin") + var_2;
  var_4 = self.angles;

  foreach(var_6 in self.players) {
    if(!isDefined(var_6)) {
      continue;
    }

    var_6.forcespawncameraorg = var_3;
    var_6.forcespawncameraang = var_4;
    var_6 notify("c130_ready");
  }
}

function removefromspawnselectionaftertime(var_0) {
  wait var_0;
  removefromspawnselection();
}

function removefromspawnselection() {
  scripts\mp\spawnselection::removedynamicspawnarea(self.team, "dynamic_c130");
  scripts\mp\spawnselection::removespawnlocation("dynamic_c130", self.team);
}

function spawnplayertoc130() {
  self endon("disconnect");

  if(!isDefined(level.spawnc130[self.team])) {
    return;
  }

  self waittill("spawn_camera_idle");
  var_0 = level.spawnc130[self.team];
  var_0.respawnqueue[var_0.respawnqueue.size] = self;

  if(istrue(var_0.canjoin)) {
    gatherc130playerstospawn(var_0);
  }

  if(istrue(self.inspawncamera)) {
    self waittill("spawn_camera_complete");
  } else {
    self waittill("spawned_player");
  }

  scripts\common\utility::allow_killstreaks(0);
  self disableusability();
  self disableoffhandweapons();
  self allowmelee(0);
  self allowads(0);
  self allowfire(0);
  self setCanDamage(0);
  thread jumplistener(var_0, 0);
  self.br_infil_type = "c130";

  if(!isbot(self)) {
    thread scripts\mp\gametypes\br_public::orbitcam(var_0);
    return;
  }
}

function jumplistener(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("jumpListener()");
  self endon("jumpListener()");

  if(isDefined(self.parachute)) {
    self.parachute delete();
  }

  scripts\mp\utility\game::ref_131a3(self, 1);
  thread listenjump(var_0, var_1);
  thread listenkick(var_0, var_1);
}

function listenkick(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("br_jump");
  self notify("listenKick()");
  self endon("listenKick()");
  self waittill("halo_kick_c130");
  self cameradefault();
  self unlink();
  wait 0.1;

  if(self.sessionstate == "spectator") {
    return;
  }

  var_2 = var_0 scripts\mp\gametypes\br_public::calctrailpoint();
  thread parachute(var_0, var_1);
  self notify("br_jump");
  self notify("stop_cam_shake");
}

function listenjump(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("br_jump");
  self notify("listenJump()");
  self endon("listenJump()");
  self notifyonplayercommand("halo_jump_c130", "+gostand");

  for(;;) {
    var_2 = scripts\engine\utility::waittill_either("halo_jump_c130", "canParachute");

    if(isDefined(var_2) && var_2 == "canParachute") {
      self iprintlnbold("Press Jump to Parachute!");
    } else if(!istrue(var_0.canparachute)) {
      self iprintlnbold("Not over the AO");
    } else {
      break;
    }

    if(self.sessionstate == "spectator") {
      return;
    }
  }

  self cameradefault();
  self unlink();
  wait 0.1;
  thread parachute(var_0, var_1);
  self notify("br_jump");
  self notify("stop_cam_shake");
}

function parachute(var_0, var_1) {
  self endon("jumpListener()");
  self notify("parachute()");
  self endon("parachute()");

  if(self.team == "axis") {
    var_2 = level.c130pathstruct_b.midpt;
  } else {
    var_2 = level.c130pathstruct_a.midpt;
  }

  var_3 = vectorNormalize(var_2 - var_1.origin);
  var_1.players = scripts\engine\utility::array_remove(var_1.players, self);

  if(isDefined(var_1.playeroffsets) && isDefined(var_1.currentplayeroffset)) {
    var_4 = var_1.playeroffsets[var_1.currentplayeroffset];
    self setOrigin(var_1.origin + var_4, 1, 1);
    var_1.currentplayeroffset++;

    if(var_1.currentplayeroffset == var_1.playeroffsets.size) {
      var_1.currentplayeroffset = 0;
    }
  } else {
    var_5 = anglesToForward(var_1.angles) * var_1.br_vieworigin;
    self setOrigin(var_1.origin + var_5, 1, 1);
  }

  waitframe();
  self playershow();
  self.plotarmor = 0;
  scripts\mp\utility\game::ref_131a3(self, 0);
  self setplayerangles(vectortoangles(var_3));
  thread scripts\cp_mp\parachute::startfreefall(5, 0);
}

function debug_randomflightpathstest() {
  wait 10;

  for(;;) {
    c130_pickrandomflightpath();
    level.c130pathstruct_a.startpt -= (0, 0, 10000);
    level.c130pathstruct_a.endpt -= (0, 0, 10000);
    level.c130pathstruct_b.startpt -= (0, 0, 10000);
    level.c130pathstruct_b.endpt -= (0, 0, 10000);
    thread scripts\mp\utility\debug::drawline(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 1, (1, 0, 1));
    thread scripts\mp\utility\debug::drawline(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 1, (1, 0, 1));
    wait 1;
  }
}

function c130_pickrandomflightpath() {
  if(istrue(level.c130alignedtolocale) && istrue(level.useobjectives)) {
    var_0 = (level.gw_objstruct.axishqloc.trigger.origin + level.gw_objstruct.allieshqloc.trigger.origin) * 0.5;
    var_1 = vectortoangles(level.gw_objstruct.axishqloc.trigger.origin - level.gw_objstruct.allieshqloc.trigger.origin);
    var_2 = var_1[1];

    if(false) {
      debugsphereonlocation(var_0, (0, 1, 0), 100000);
    }
  } else {
    var_0 = (level.mapsafecorners[0] + level.mapsafecorners[1]) * 0.5;
    var_2 = randomfloatrange(0, 359);
  }

  var_3 = makec130pathparamsstruct(var_0, var_2 - 90);
  level.c130pathstruct_a = scripts\mp\gametypes\br_public::makepathstruct(var_3);
  var_3.randomangle += 180;
  level.c130pathstruct_b = scripts\mp\gametypes\br_public::makepathstruct(var_3);
  var_4 = 0.2;
  var_5 = 0;
  var_6 = 0;

  if(istrue(level.c130spacing_usebigmapsettings)) {
    var_4 = 0.1;
    var_5 = randomfloatrange(-5000, 5000);
    var_6 = randomfloatrange(-5000, 5000);
  }

  var_7 = anglestoright(level.c130pathstruct_a.angle);
  level.c130pathstruct_a.startpt = var_7 * level.c130distapart + level.c130pathstruct_a.startpt;
  level.c130pathstruct_a.endpt = var_7 * level.c130distapart + level.c130pathstruct_a.endpt;
  var_7 = anglestoright(level.c130pathstruct_b.angle);
  level.c130pathstruct_b.startpt = var_7 * level.c130distapart + level.c130pathstruct_b.startpt;
  level.c130pathstruct_b.endpt = var_7 * level.c130distapart + level.c130pathstruct_b.endpt;
  var_8 = (var_5, var_6, 0);
  level.c130pathstruct_a.startpt += var_8;
  level.c130pathstruct_a.endpt += var_8;
  level.c130pathstruct_a.midpt = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 0.5);
  level.c130pathstruct_b.startpt += var_8;
  level.c130pathstruct_b.endpt += var_8;
  level.c130pathstruct_b.midpt = vectorlerp(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 0.5);
  level.battlecenter = vectorlerp(level.c130pathstruct_a.midpt, level.c130pathstruct_b.midpt, 0.5);
  level.c130minpathmovementinterval = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_b.endpt, var_4);
  level.c130minpathmovementinterval -= level.c130pathstruct_a.startpt;
  level.c130minpathmovementinterval = vectorNormalize(level.c130minpathmovementinterval) * level.c130distapart / 10;
  level.c130minpathmovementinterval = (level.c130minpathmovementinterval[0], level.c130minpathmovementinterval[1], 0);
}

function makec130pathparamsstruct(var_0, var_1) {
  var_2 = 6.28318;
  var_3 = var_1;
  var_4 = 180;
  var_5 = level.c130flightdist;
  var_6 = spawnStruct();
  var_6.r = var_5;
  var_6.randomangle = var_3;
  var_6.endangleoffset = var_4;
  var_6.centerpt = var_0;
  return var_6;
}

function c130_fightpathmove() {
  if(false) {
    level.c130movementmethod = 2;
  }

  if(level.c130movementmethod == 0) {
    return;
  }

  if(level.c130movementmethod == 1) {
    if(false) {
      level.c130pathkilltracker["axis"] = 1;
      level.c130pathkilltracker["allies"] = 0;
    }

    if(level.c130pathkilltracker["axis"] > level.c130pathkilltracker["allies"]) {
      if(arenextpathsinsafebounds(level.c130minpathmovementinterval)) {
        level.c130pathstruct_a.startpt += level.c130minpathmovementinterval;
        level.c130pathstruct_a.endpt += level.c130minpathmovementinterval;
        level.c130pathstruct_b.startpt += level.c130minpathmovementinterval;
        level.c130pathstruct_b.endpt += level.c130minpathmovementinterval;
      }
    } else if(arenextpathsinsafebounds(level.c130minpathmovementinterval * -1)) {
      level.c130pathstruct_a.startpt -= level.c130minpathmovementinterval;
      level.c130pathstruct_a.endpt -= level.c130minpathmovementinterval;
      level.c130pathstruct_b.startpt -= level.c130minpathmovementinterval;
      level.c130pathstruct_b.endpt -= level.c130minpathmovementinterval;
    }

    level.c130pathstruct_a.midpt = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 0.5);
    level.c130pathstruct_b.midpt = vectorlerp(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 0.5);
    level.c130pathkilltracker["axis"] = 0;
    level.c130pathkilltracker["allies"] = 0;
    return;
  }

  if(level.c130movementmethod == 2) {
    var_0 = (0, 0, 0);
    var_1 = (0, 0, 0);
    var_2 = 0;
    var_3 = 0;

    foreach(var_5 in level.players) {
      if(isalive(var_5)) {
        if(var_5.team == "axis") {
          var_0 += var_5.origin;
          var_2++;
          continue;
        }

        if(var_5.team == "allies") {
          var_1 += var_5.origin;
          var_3++;
        }
      }
    }

    if(var_2 == 0 || var_3 == 0) {
      return;
    }

    var_7 = var_0 / var_2;
    var_8 = var_1 / var_3;
    var_9 = vectorlerp(var_7, var_8, 0.5);
    level.c130minpathmovementinterval = vectorlerp(level.battlecenter, var_9, 0.5);
    level.c130minpathmovementinterval -= level.battlecenter;
    var_10 = distance2d(level.battlecenter, var_9);
    level.c130minpathmovementinterval = vectorNormalize(level.c130minpathmovementinterval) * var_10 / 4;
    level.c130minpathmovementinterval = (level.c130minpathmovementinterval[0], level.c130minpathmovementinterval[1], 0);

    if(arenextpathsinsafebounds(level.c130minpathmovementinterval)) {
      level.c130pathstruct_a.startpt += level.c130minpathmovementinterval;
      level.c130pathstruct_a.endpt += level.c130minpathmovementinterval;
      level.c130pathstruct_a.midpt = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 0.5);
      level.c130pathstruct_b.startpt += level.c130minpathmovementinterval;
      level.c130pathstruct_b.endpt += level.c130minpathmovementinterval;
      level.c130pathstruct_b.midpt = vectorlerp(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 0.5);

      if(false) {
        debugsphereonlocation(level.battlecenter, (1, 0, 0), 700);
        debugsphereonlocation(var_9, (0, 1, 0), 700);
      }

      level.battlecenter += level.c130minpathmovementinterval;
      return;
    }

    return;
  }
}

function arenextpathsinsafebounds(var_0) {
  return ispointinsafebounds(level.c130pathstruct_a.startpt + var_0) && ispointinsafebounds(level.c130pathstruct_a.endpt + var_0) && ispointinsafebounds(level.c130pathstruct_b.startpt + var_0) && ispointinsafebounds(level.c130pathstruct_b.endpt + var_0);
}

function ispointinsafebounds(var_0) {
  return var_0[0] < level.mapsafecorners[0][0] && var_0[0] > level.mapsafecorners[1][0] && var_0[1] < level.mapsafecorners[0][1] && var_0[1] > level.mapsafecorners[1][1];
}

function registervehicletype(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.refname = var_0;
  var_3.spawncallback = var_2;
  var_3.vehiclespawns = [[var_1]]();

  if(!isDefined(level.vehicleinfo)) {
    level.vehicleinfo = [];
  }

  level.vehicleinfo[var_0] = var_3;
}

function init_groundwarvehicles() {
  level.ignorevehicletypeinstancelimit = 1;
  registervehicletype("technical", &scripts\cp_mp\vehicles\technical::technical_getspawnstructscallback, &vehiclespawn_truck);
  registervehicletype("little_bird", &scripts\cp_mp\vehicles\little_bird::little_bird_getspawnstructscallback, &vehiclespawn_littlebird);
  registervehicletype("little_bird_mg", &_calloutmarkerping_poolidisdanger::x1stash_detectplayers, &ref_14266);
  registervehicletype("cop_car", &scripts\cp_mp\vehicles\cop_car::cop_car_getspawnstructscallback, &vehiclespawn_copcar);
  registervehicletype("atv", &scripts\cp_mp\vehicles\atv::atv_getspawnstructscallback, &vehiclespawn_atv);
  registervehicletype("cargo_truck", &scripts\cp_mp\vehicles\cargo_truck::cargo_truck_getspawnstructscallback, &vehiclespawn_cargotruck);
  registervehicletype("hoopty", &scripts\cp_mp\vehicles\hoopty::hoopty_getspawnstructscallback, &vehiclespawn_hoopty);
  registervehicletype("hoopty_truck", &scripts\cp_mp\vehicles\hoopty_truck::hoopty_truck_getspawnstructscallback, &vehiclespawn_hooptytruck);
  registervehicletype("jeep", &scripts\cp_mp\vehicles\jeep::jeep_getspawnstructscallback, &vehiclespawn_jeep);
  registervehicletype("large_transport", &scripts\cp_mp\vehicles\large_transport::large_transport_getspawnstructscallback, &vehiclespawn_largetransport);
  registervehicletype("medium_transport", &scripts\cp_mp\vehicles\med_transport::med_transport_getspawnstructscallback, &vehiclespawn_medtransport);
  registervehicletype("pickup_truck", &scripts\cp_mp\vehicles\pickup_truck::pickup_truck_getspawnstructscallback, &vehiclespawn_pickuptruck);
  registervehicletype("tac_rover", &scripts\cp_mp\vehicles\tac_rover::tac_rover_getspawnstructscallback, &vehiclespawn_tacrover);
  registervehicletype("van", &scripts\cp_mp\vehicles\van::van_getspawnstructscallback, &vehiclespawn_van);
  registervehicletype("light_tank", &scripts\cp_mp\vehicles\light_tank::light_tank_getspawnstructscallback, &vehiclespawn_tank);
  level.vehiclespawnlocs = [];
  level.tankspawnlocs_axis = [];
  level.tankspawnlocs_allies = [];

  foreach(var_1 in level.vehicleinfo) {
    if(var_1.refname == "light_tank" && level.mapname == "mp_downtown_gw" && level.localeid == "locale_6") {
      var_2 = [];
      var_3 = [];
      var_2 = (17465, -21971, -150);
      GscBinSkip0(0x2e, 0, (10, 90, 0));
    }

    if(var_9.refname == "atv") {
      if(level.mapname == "mp_farms2_gw" && level.localeid == "locale_9") {
        var_11 = [];
        var_12 = [];
        var_11 = (46022, 1039, 56);
        GscBinSkip0(0x2e, 0, (7, 289, 0));
      }

      if(level.mapname == "mp_downtown_gw" && level.localeid == "locale_6") {
        var_11 = [];
        var_12 = [];
        var_11 = (17806, -20823, -110);
        GscBinSkip0(0x2e, 0, (11, 358, 0));
      }
    }

    if(var_3.refname == "tac_rover") {
      if(level.mapname == "mp_farms2_gw" && level.localeid == "locale_9") {
        var_11 = [];
        var_12 = [];
        var_11 = (48384, -1703, 70);
        GscBinSkip0(0x2e, 0, (7, 260, 0));
      }

      if(level.mapname == "mp_downtown_gw" && level.localeid == "locale_6") {
        var_11 = [];
        var_12 = [];
        var_11 = (21969, -11928, -156);
        GscBinSkip0(0x2e, 0, (7, 269, 0));
      }
    }

    if(var_12.refname == "cargo_truck" && level.mapname == "mp_downtown_gw" && level.localeid == "locale_6") {
      foreach(var_12 in var_12.vehiclespawns) {
        if(distancesquared(var_12.origin, (20559, -24015, -105)) < 16384) {
          var_12.origin = (18119, -21282, -118);
          var_12.angles = (6, 55, 0);
        }
      }
    }

    foreach(var_11, var_12 in var_12.vehiclespawns) {
      if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var_12.script_noteworthy) && var_12.script_noteworthy == level.localeid) {
        if(var_12.refname == "light_tank") {
          if(isDefined(var_12.script_team) && var_12.script_team == "axis") {
            var_22 = level.tankspawnlocs_axis.size;
            level.tankspawnlocs_axis[var_22] = var_12;
            level.tankspawnlocs_axis[var_22].refname = var_12.refname;
          } else if(isDefined(var_12.script_team) && var_12.script_team == "allies") {
            var_22 = level.tankspawnlocs_allies.size;
            level.tankspawnlocs_allies[var_22] = var_12;
            level.tankspawnlocs_allies[var_22].refname = var_12.refname;
          }

          continue;
        }

        if(istrue(level.matchdata_logvictimkillevent) && var_12.refname == "jeep" || istrue(level.matchdata_logscoreevent) && var_12.refname == "cargo_truck") {
          continue;
        } else {
          var_22 = level.vehiclespawnlocs.size;
          level.vehiclespawnlocs[var_22] = var_12;
          level.vehiclespawnlocs[var_22].refname = var_12.refname;
        }
      }
    }
  }

  var_11 = undefined;
  var_12 = undefined;

  if(false) {
    foreach(var_26 in level.vehiclespawnlocs) {
      thread scripts\mp\utility\debug::drawline(var_26.origin, var_26.origin + (0, 0, 1500), 1000, (1, 0, 0));
    }
  }

  level.vehiclespawnlocs = scripts\engine\utility::array_randomize(level.vehiclespawnlocs);
  var_28 = level.ref_11f41;

  if(!isDefined(level.ref_11f41)) {
    var_28 = 25;
  }

  if(false) {
    for(var_13 = 0; var_13 < var_28; var_13++) {
      var_26 = level.vehiclespawnlocs[var_13];
      thread scripts\mp\utility\debug::drawline(var_26.origin + (0, 0, 1500), var_26.origin + (0, 0, 2500), 1000, (0, 1, 0));
    }
  }

  for(var_13 = 0; var_13 < var_28; var_13++) {
    var_26 = level.vehiclespawnlocs[var_13];

    if(isDefined(var_26)) {
      var_12 = level.vehicleinfo[var_26.refname];
      [[var_12.spawncallback]](var_26);
    }
  }

  scripts\mp\flags::gameflagwait("prematch_countdown");
  level.numhqtanks_axis = 0;
  level.numhqtanks_allies = 0;
  thread vehiclespawn_hqtanks(level.tankspawnlocs_axis);
  thread vehiclespawn_hqtanks(level.tankspawnlocs_allies);
}

function vehiclespawn_hqtanks(var_0) {
  foreach(var_2 in var_0) {
    var_3 = level.vehicleinfo[var_2.refname];
    [[var_3.spawncallback]](var_2);
    wait randomfloatrange(2, 3);
  }
}

function vehiclespawn_truck(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("technical", var_2, var_1);
}

function vehiclespawn_littlebird(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird", var_2, var_1);
}

function ref_14266(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird_mg", var_2, var_1);
}

function vehiclespawn_copcar(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("cop_car", var_2, var_1);
}

function vehiclespawn_atv(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("atv", var_2, var_1);
}

function vehiclespawn_cargotruck(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("cargo_truck", var_2, var_1);
}

function vehiclespawn_hoopty(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("hoopty", var_2, var_1);
}

function vehiclespawn_hooptytruck(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("hoopty_truck", var_2, var_1);
}

function vehiclespawn_jeep(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("jeep", var_2, var_1);
}

function vehiclespawn_largetransport(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("large_transport", var_2, var_1);
}

function vehiclespawn_medtransport(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("medium_transport", var_2, var_1);
}

function vehiclespawn_pickuptruck(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("pickup_truck", var_2, var_1);
}

function vehiclespawn_tacrover(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("tac_rover", var_2, var_1);
}

function vehiclespawn_van(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("van", var_2, var_1);
}

function vehiclespawn_tank(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  var_2.spawnmethod = "airdrop_at_position_unsafe";

  if(isDefined(var_0.script_team) && var_0.script_team == "axis") {
    if(level.numhqtanks_axis >= level.maxhqtanks) {
      return;
    }

    var_2.usealtmodel = 1;
    var_2.team = "axis";
    level.numhqtanks_axis++;
  } else {
    if(level.numhqtanks_allies >= level.maxhqtanks) {
      return;
    }

    var_2.team = "allies";
    level.numhqtanks_allies++;
  }

  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("light_tank", var_2, var_1);

  if(istrue(level.ref_13377)) {
    ref_1413b(var_3, var_3.team);
  }

  return var_3;
}

function ref_1413b(var_0, var_1) {
  wait 1;
  var_2 = scripts\mp\gameobjects::createobjidobject(var_0.origin, var_1, (0, 0, 0), undefined, 0, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, var_1);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_2.objidnum);
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "icon_minimap_bradley_spawn_selection");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 1);
  scripts\mp\objidpoolmanager::update_objective_onentity(var_2.objidnum, var_0);
  var_2.lockupdatingicons = 1;

  foreach(var_4 in level.players) {
    if(isDefined(var_4) && isDefined(var_4.team) && var_4.team == var_1 && istrue(var_4.inspawnselection)) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_2.objidnum, var_4);
    }
  }

  var_0.ref_1369d = var_2;
  thread ref_14228(var_0);
  level.ref_13c4a[var_1][level.ref_13c4a[var_1].size] = var_0;
}

function ref_14228(var_0) {
  var_1 = var_0.ref_1369d.objidnum;
  var_2 = var_0.team;
  var_0 waittill("death");
  scripts\mp\objidpoolmanager::returnobjectiveid(var_1);
  level.ref_13c4a[var_2] = scripts\engine\utility::array_remove(level.ref_13c4a[var_2], var_0);
}

function ref_1420e() {
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(var_1 in level.ref_13c4a[self.team]) {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_1.ref_1369d.objidnum, self);
  }

  while(self.inspawnselection) {
    waitframe();
  }

  foreach(var_1 in level.ref_13c4a["axis"]) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_1.ref_1369d.objidnum, self);
  }

  foreach(var_1 in level.ref_13c4a["allies"]) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_1.ref_1369d.objidnum, self);
  }
}

function vehiclespawn_getspawndata(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.spawntype = "GAME_MODE";
  var_1.showheadicon = 1;
  return var_1;
}

function droptank_playincomingdialog(var_0) {
  var_1 = var_0.team;
  var_2 = "bradley";

  if(level.teambased) {
    if(isDefined(level.killstreakactivatedtime[var_2])) {
      if(isDefined(level.killstreakactivatedtime[var_2][var_1])) {
        if(gettime() < level.killstreakactivatedtime[var_2][var_1]) {
          return;
        }
      }
    }

    level.killstreakactivatedtime[var_2][var_1] = gettime() + scripts\mp\utility\dialog::getkillstreakdialogcooldown() * 1000;
  }

  scripts\mp\utility\dialog::leaderdialog(var_1 + "_friendly_" + var_2 + "_inbound", var_1, "killstreak_used");
}

function ref_1413a(var_0, var_1) {
  wait 1;
  var_2 = scripts\mp\gameobjects::createobjidobject(var_0.origin, var_1, (0, 0, 0), undefined, 0, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, var_1);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_2.objidnum);
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "icon_minimap_littlebird_static");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 1);
  scripts\mp\objidpoolmanager::update_objective_onentity(var_2.objidnum, var_0);
  var_2.lockupdatingicons = 1;

  foreach(var_4 in level.players) {
    if(isDefined(var_4) && istrue(var_4.inspawnselection)) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_2.objidnum, var_4);
    }
  }

  var_0.ref_1369d = var_2;
  thread ref_14227(var_0);
  level.ref_13c49["untouched"][level.ref_13c49["untouched"].size] = var_0;
}

function ref_14227(var_0) {
  var_1 = var_0.ref_1369d.objidnum;
  var_0 waittill("death");
  scripts\mp\objidpoolmanager::returnobjectiveid(var_1);
  var_2 = var_0.watch_for_player_entered_trap_room;

  if(!isDefined(var_0.watch_for_player_entered_trap_room)) {
    var_2 = "untouched";
  }

  level.ref_13c49[var_2] = scripts\engine\utility::array_remove(level.ref_13c49[var_2], var_0);
}

function ref_1420f() {
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(var_1 in level.ref_13c49[self.team]) {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_1.ref_1369d.objidnum, self);
  }

  foreach(var_1 in level.ref_13c49["untouched"]) {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_1.ref_1369d.objidnum, self);
  }

  while(self.inspawnselection) {
    waitframe();
  }

  foreach(var_1 in level.ref_13c49["axis"]) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_1.ref_1369d.objidnum, self);
  }

  foreach(var_1 in level.ref_13c49["allies"]) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_1.ref_1369d.objidnum, self);
  }

  foreach(var_1 in level.ref_13c49["untouched"]) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_1.ref_1369d.objidnum, self);
  }
}

function ref_141ff(var_0) {
  if(isDefined(self.watch_for_player_entered_trap_room)) {
    level.ref_13c49[self.watch_for_player_entered_trap_room] = scripts\engine\utility::array_remove(level.ref_13c49[self.watch_for_player_entered_trap_room], self);
  } else {
    level.ref_13c49["untouched"] = scripts\engine\utility::array_remove(level.ref_13c49["untouched"], self);
  }

  self.watch_for_player_entered_trap_room = var_0;
  level.ref_13c49[var_0][level.ref_13c49[var_0].size] = self;
  scripts\mp\objidpoolmanager::update_objective_icon(self.ref_1369d.objidnum, "icon_minimap_littlebird_spawn_selection");

  foreach(var_2 in level.players) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.ref_1369d.objidnum, var_2);

    if(isDefined(var_2) && isDefined(var_2.team) && var_2.team == var_0 && istrue(var_2.inspawnselection)) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.ref_1369d.objidnum, var_2);
      continue;
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.ref_1369d.objidnum, var_2);
  }
}

function init_rallyvehicles() {
  while(!isDefined(level.spawnselectionlocations)) {
    waitframe();
  }

  waitframe();
  level.rallypointvehicles = [];
  var_0 = scripts\engine\utility::getStructArray("rallyPointTechnical", "targetname");

  foreach(var_7, var_2 in var_0) {
    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var_2.script_noteworthy) && var_2.script_noteworthy != level.localeid) {
      continue;
    }

    var_3 = scripts\engine\utility::ter_op(var_2.script_team == "axis", "axis", "allies");
    var_4 = getrallyvehiclespawndata(var_2, var_3);
    var_5 = spawnStruct();
    var_6 = scripts\mp\vehicles\technical_mp::technical_mp_spawncallback(var_4, var_5);

    if(isDefined(var_6)) {
      level.rallypointvehicles[level.rallypointvehicles.size] = var_6;
    }
  }

  var_0 = scripts\engine\utility::getStructArray("rallyPointLittleBird", "targetname");

  if(!istrue(level.disablelittlebirdrally)) {
    foreach(var_2 in var_0) {
      if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var_2.script_noteworthy) && var_2.script_noteworthy != level.localeid) {
        continue;
      }

      var_3 = scripts\engine\utility::ter_op(var_2.script_team == "axis", "axis", "allies");
      var_4 = getrallyvehiclespawndata(var_2, var_3);
      var_5 = spawnStruct();

      if(level.move_spawnpoints_to_valid_positions) {
        var_6 = _x1opsnpcwaittilluse::xyvelscale_low(var_4, var_5);
      } else {
        var_6 = scripts\mp\vehicles\little_bird_mp::little_bird_mp_spawncallback(var_4, var_5);
      }

      if(isDefined(var_6)) {
        level.rallypointvehicles[level.rallypointvehicles.size] = var_6;
      }
    }
  } else if(!istrue(level.completelyremovelittlebird)) {
    if(level.localeid == "locale_6" && level.mapname == "mp_downtown_gw" && istrue(level.ref_11ac5)) {
      var_10 = [];
      GscBinSkip0(0x2e, 0, (23718, -4470, -350));
    }

    foreach(var_3 in var_1) {
      if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var_3.script_noteworthy) && var_3.script_noteworthy != level.localeid) {
        continue;
      }

      if(!isDefined(var_3.angles)) {
        var_3.angles = (0, randomfloat(360), 0);
      }

      var_5 = vehiclespawn_getspawndata(var_3);

      if(level.move_spawnpoints_to_valid_positions) {
        var_7 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird_mg", var_5, undefined);
      } else {
        var_7 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird", var_5, undefined);
      }

      thread ref_1413a(level, var_7);
    }
  }

  var_1 = scripts\engine\utility::getStructArray("rallyPointAPC", "targetname");

  foreach(var_3 in var_1) {
    var_4 = scripts\engine\utility::ter_op(var_3.script_team == "axis", "axis", "allies");
    var_5 = getrallyvehiclespawndata(var_3, var_4);

    if(var_4 == "allies") {
      var_5.usealtmodel = 1;
    }

    var_6 = spawnStruct();
    var_7 = scripts\mp\vehicles\apc_rus_mp::apc_rus_mp_spawncallback(var_5, var_6);

    if(isDefined(var_7)) {
      level.rallypointvehicles[level.rallypointvehicles.size] = var_7;
      LOC_000003db:
    }
    LOC_000003db:
  }

  foreach(var_19 in level.teamnamelist) {
    while(!isDefined(level.availablespawnlocations[var_19][0])) {
      waitframe();
    }
  }

  var_21 = 0;
  var_22 = 0;
  var_23 = 0;
  var_24 = 0;
  var_25 = 0;
  var_26 = 0;
  var_27 = "gw_vehicle_technical_";
  var_28 = "gw_vehicle_littlebird_";
  var_29 = "gw_vehicle_apc_";

  foreach(var_7 in level.rallypointvehicles) {
    var_5 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(var_7);

    if(!isDefined(var_5.rallypointhealth)) {
      var_5.rallypointhealth = var_7.health;
    } else {
      var_7.health = var_5.rallypointhealth;
    }

    var_13 = 0;
    var_31 = undefined;

    if(var_7.team == "axis") {
      if(var_7.vehiclename == "technical") {
        var_21++;

        if(var_21 <= 8) {
          var_5.ref = var_27 + var_21;
        }
      } else if(var_7.vehiclename == "little_bird" || var_7.vehiclename == "little_bird_mg") {
        var_22++;

        if(var_22 <= 2) {
          var_5.ref = var_28 + var_22;
        }
      } else if(var_7.vehiclename == "apc_russian") {
        var_23++;

        if(var_23 <= 2) {
          var_5.ref = var_29 + var_23;
        }
      }
    } else if(var_7.vehiclename == "technical") {
      var_24++;

      if(var_24 <= 8) {
        var_5.ref = var_27 + var_24;
      }
    } else if(var_7.vehiclename == "little_bird" || var_7.vehiclename == "little_bird_mg") {
      var_25++;

      if(var_25 <= 2) {
        var_5.ref = var_28 + var_25;
      }
    } else if(var_7.vehiclename == "apc_russian") {
      var_26++;

      if(var_26 <= 2) {
        var_5.ref = var_29 + var_26;
      }
    }

    if(istrue(level.userallypointvehicles) && level.userallypointvehicles != 2) {
      watchvehicleforrallypointactivation(var_7);
    }
  }
}

function watchvehicleforrallypointactivation(var_0) {
  scripts\mp\rally_point::rallypointvehicle_activate(var_0);
}

function getrallyvehiclespawndata(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0.origin;
  var_2.angles = var_0.angles;
  var_2.spawntype = "GAME_MODE";
  var_2.cannotbesuspended = 1;
  var_2.team = var_1;
  return var_2;
}

function arm_initoutofbounds() {
  level.outofboundstriggers = [];
  var_0 = getEntArray("OutOfBounds", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == level.localeid && scripts\mp\utility\game_utility_mp::ref_11c8a(var_2)) {
      level.outofboundstriggers[level.outofboundstriggers.size] = var_2;
      continue;
    }

    var_2 delete();
  }
}

function debugprint(var_0) {
  if(false) {
    return;
  }
}

function isobjectivecontested(var_0) {
  if(var_0.ownerteam == "axis") {
    return (var_0.numtouching["allies"] > 0);
  }

  if(var_0.ownerteam == "allies") {
    return (var_0.numtouching["axis"] > 0);
  }
}

function freeze_bomb_case_timer(var_0) {
  var_1 = 0;

  foreach(var_3 in level.objectives) {
    if(var_3.ownerteam == var_0) {
      var_1++;
    }
  }

  return var_1;
}

function createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = undefined;

  if(isDefined(var_11)) {
    var_12 = var_11;
  } else {
    var_12 = spawn("script_model", var_0);
  }

  var_12 makeusable();

  if(isDefined(var_11) && isDefined(var_0)) {
    var_12 sethinttag(var_0);
  }

  if(isDefined(var_1)) {
    var_12 setCursorHint(var_1);
  } else {
    var_12 setCursorHint("HINT_NOICON");
  }

  if(isDefined(var_2)) {
    var_12 sethinticon(var_2);
  }

  if(isDefined(var_3)) {
    var_12 setHintString(var_3);
  }

  if(isDefined(var_4)) {
    var_12 setusepriority(var_4);
  } else {
    var_12 setusepriority(0);
  }

  if(isDefined(var_5)) {
    var_12 setuseholdduration(var_5);
  } else {
    var_12 setuseholdduration("duration_short");
  }

  if(isDefined(var_6)) {
    var_12 sethintonobstruction(var_6);
  } else {
    var_12 sethintonobstruction("hide");
  }

  if(isDefined(var_7)) {
    var_12 sethintdisplayrange(var_7);
  } else {
    var_12 sethintdisplayrange(200);
  }

  if(isDefined(var_8)) {
    var_12 sethintdisplayfov(var_8);
  } else {
    var_12 sethintdisplayfov(160);
  }

  if(isDefined(var_9)) {
    var_12 setuserange(var_9);
  } else {
    var_12 setuserange(50);
  }

  if(isDefined(var_10)) {
    var_12 setusefov(var_10);
  } else {
    var_12 setusefov(120);
  }

  if(!isDefined(var_11)) {
    return var_12;
  }
}

function calculatefrontline() {
  if(level.mapname == "mp_arm_test") {
    level.c130frontlinepos = (0, 375, 0);
    level.c130frontlinevec = (0, 1, 0);
    level.axisfrontlinevec = (-1, 0, 0);
    level.alliesfrontlinevec = (1, 0, 0);
    return;
  }

  level.c130frontlinepos = (5100, -1615, 0);
  level.c130frontlinevec = (1, 0, 0);
  level.axisfrontlinevec = (0, -1, 0);
  level.alliesfrontlinevec = (0, 1, 0);
}

function getexfilstructs() {
  var_0 = scripts\engine\utility::getStructArray("airdropLocation_allies", "targetname");
  var_1 = scripts\engine\utility::getStructArray("airdropLocation_axis", "targetname");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  var_3 = scripts\engine\utility::getclosest(level.lane_1_obj_struct.currentobjective.gameobject.origin, var_2);
  var_4 = scripts\engine\utility::getclosest(level.lane_2_obj_struct.currentobjective.gameobject.origin, var_2);
  var_5 = scripts\engine\utility::getclosest(level.lane_3_obj_struct.currentobjective.gameobject.origin, var_2);
  level.armexfilcount = 3;
  return [var_3, var_4, var_5];
}

function onexfilfinish(var_0) {}

function onexfilkilled(var_0) {
  level.armexfilcount--;

  if(level.armexfilcount == 0) {
    thread scripts\mp\gamelogic::endgame(var_0, game["end_reason"]["target_destroyed"]);
    return;
  }
}

function sortlocationsbydistance(var_0, var_1) {
  return distancesquared(var_0.origin, self.origin) < distancesquared(var_1.origin, self.origin);
}

function calculatedroplocationnearlocation(var_0, var_1, var_2) {
  var_3 = var_0.origin;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = randomint(2);
  var_7 = scripts\engine\utility::ter_op(var_6, -1, 1);

  if(var_7 > 0) {
    var_4 = randomfloatrange(var_3[0] + var_1 * var_7, var_3[0] + var_2 * var_7);

    if(var_4 >= level.br_level.br_corners[0][0]) {
      var_4 = level.br_level.br_corners[0][0] - 250;
    }
  } else {
    var_4 = randomfloatrange(var_3[0] + var_2 * var_7, var_3[0] + var_1 * var_7);

    if(var_4 <= level.br_level.br_corners[1][0]) {
      var_4 = level.br_level.br_corners[1][0] + 250;
    }
  }

  var_6 = randomint(2);
  var_7 = scripts\engine\utility::ter_op(var_6, -1, 1);

  if(var_7 > 0) {
    var_5 = randomfloatrange(var_3[1] + var_1 * var_7, var_3[1] + var_2 * var_7);

    if(var_5 >= level.br_level.br_corners[0][1]) {
      var_5 = level.br_level.br_corners[0][1] - 250;
    }
  } else {
    var_5 = randomfloatrange(var_3[1] + var_2 * var_7, var_3[1] + var_1 * var_7);

    if(var_5 >= level.br_level.br_corners[1][1]) {
      var_5 = level.br_level.br_corners[1][1] + 250;
    }
  }

  var_8 = spawnStruct();
  var_8.origin = (var_4, var_5, var_3[2]);
  return var_8;
}

function debugsphereonlocation(var_0, var_1, var_2) {}

function getmissedinfilcamerapositions(var_0) {
  var_1 = spawnStruct();
  var_1.startorigin = undefined;
  var_1.endpos = undefined;

  if(level.mapname == "mp_locale_test") {
    switch (level.localeid) {
      case "locale_8":
      case "locale_6":
        if(var_0 == "axis") {
          var_1.startorigin = (2094, -1804, 2763);
          var_1.startangles = (54, 40, 0);
          var_1.endorigin = (2094, -1804, 2763);
          var_1.endangles = (54, 40, 0);
        } else {
          var_1.startorigin = (2315, 1956, 2763);
          var_1.startangles = (54, 296, 0);
          var_1.endorigin = (2094, -1804, 2763);
          var_1.endangles = (54, 40, 0);
        }

        break;
      default:
        var_1.startorigin = (0, 0, 0);
        var_1.startangles = (0, 0, 0);
        var_1.endorigin = (0, 0, 0);
        var_1.endangles = (0, 0, 0);
        break;
    }
  } else {
    switch (level.localeid) {
      case "locale_3":
        if(var_0 == "axis") {
          var_1.startorigin = (38864, -14018, -396);
          var_1.startangles = (3, 250, 0);
          var_1.endorigin = (38473, -14077, 401);
          var_1.endangles = (15, 252, 0);
        } else {
          var_1.startorigin = (30526, -38262, -483);
          var_1.startangles = (0, 72, 0);
          var_1.endorigin = (30024, -38403, 560);
          var_1.endangles = (19, 67, 0);
        }

        break;
      case "locale_6":
        if(var_0 == "axis") {
          var_1.startorigin = (16977, -23256, 169);
          var_1.startangles = (9, 69, 0);
          var_1.endorigin = (16899, -23467, 683);
          var_1.endangles = (15, 68, 0);
        } else {
          var_1.startorigin = (18607, 1423, -355);
          var_1.startangles = (8, 289, 0);
          var_1.endorigin = (18100, 1083, 503);
          var_1.endangles = (22, 302, 0);
        }

        break;
      case "locale_8":
        if(var_0 == "axis") {
          var_1.startorigin = (18672, -26836, -129);
          var_1.startangles = (359, 76, 0);
          var_1.endorigin = (18518, -26909, 314);
          var_1.endangles = (14, 69, 0);
        } else {
          var_1.startorigin = (18607, 1423, -355);
          var_1.startangles = (8, 289, 0);
          var_1.endorigin = (18100, 1083, 503);
          var_1.endangles = (22, 302, 0);
        }

        break;
      case "locale_16":
      case "locale_5":
        if(var_0 == "axis") {
          var_1.startorigin = (24893, 28349, 1408);
          var_1.startangles = (15, 54, 0);
          var_1.endorigin = (25613, 29274, 1255);
          var_1.endangles = (19, 53, 0);
        } else {
          var_1.startorigin = (39490, 48919, 2302);
          var_1.startangles = (17, 235, 0);
          var_1.endorigin = (39254, 48584, 1542);
          var_1.endangles = (18, 245, 0);
        }

        break;
      case "locale_9":
        if(var_0 == "axis") {
          var_1.startorigin = (48331, -24822, 514);
          var_1.startangles = (12, 77, 0);
          var_1.endorigin = (48424, -24421, -240);
          var_1.endangles = (2, 77, 0);
        } else {
          var_1.startorigin = (46188, 2520, 49);
          var_1.startangles = (7, 295, 0);
          var_1.endorigin = (46571, 2664, 526);
          var_1.endangles = (16, 276, 0);
        }

        break;
      case "locale_10":
        if(var_0 == "axis") {
          var_1.startorigin = (-11083, 22197, 381);
          var_1.startangles = (10, 181, 0);
          var_1.endorigin = (-12112, 23761, 381);
          var_1.endangles = (11, 201, 0);
        } else {
          var_1.startorigin = (-31134, 11924, -116);
          var_1.startangles = (0, 36, 0);
          var_1.endorigin = (-31134, 11924, 434);
          var_1.endangles = (11, 36, 0);
        }

        break;
      case "locale_17":
        if(var_0 == "axis") {
          var_1.startorigin = (9215, 984, 325);
          var_1.startangles = (357, 186, 0);
          var_1.endorigin = (9107, 628, 1144);
          var_1.endangles = (19, 182, 0);
        } else {
          var_1.startorigin = (-5351, 641, 408);
          var_1.startangles = (2, 352, 0);
          var_1.endorigin = (-5282, 996, 1103);
          var_1.endangles = (11, 347, 0);
        }

        break;
      case "locale_18":
        if(var_0 == "axis") {
          var_1.startorigin = (-22847, -28632, 34);
          var_1.startangles = (12, 42, 0);
          var_1.endorigin = (-22694, -28429, 356);
          var_1.endangles = (12, 40, 0);
        } else {
          var_1.startorigin = (-8084, -20649, 72);
          var_1.startangles = (10, 185, 0);
          var_1.endorigin = (-9092, -20635, 224);
          var_1.endangles = (12, 184, 0);
        }

        break;
      default:
        var_1.startorigin = (0, 0, 0);
        var_1.startangles = (0, 0, 0);
        var_1.endorigin = (0, 0, 0);
        var_1.endangles = (0, 0, 0);
        break;
    }
  }

  return var_1;
}

function calculatehqmidpoint() {
  level.hqmidpoint = (level.gw_objstruct.axishqloc.trigger.origin + level.gw_objstruct.allieshqloc.trigger.origin) * 0.5;
  level.hqvecttomid_allies = level.gw_objstruct.axishqloc.trigger.origin - level.hqmidpoint;
  level.hqvecttomid_axis = level.gw_objstruct.allieshqloc.trigger.origin - level.hqmidpoint;
  level.hqdisttomid = length(level.hqvecttomid_axis);
}

function calculatecameraoffset(var_0, var_1) {
  switch (level.mapname) {
    case "mp_quarry2":
      var_2 = 0.25;
      var_3 = 0.35;
      break;
    case "mp_farms2":
      var_2 = 0.25;
      var_3 = 0.8;
      break;
    case "mp_aniyah":
      var_2 = 0.5;
      var_3 = 0.3;
      break;
    default:
      var_2 = 0;
      var_3 = 0;
      break;
  }

  var_4 = distance(var_3, level.hqmidpoint);

  if(var_4 < 2048) {
    return (0, 0, 0);
  }

  if(var_2 == "axis") {
    var_5 = distance(level.gw_objstruct.axishqloc.trigger.origin, var_3);
    var_6 = level.hqvecttomid_axis;
  } else {
    var_5 = distance(level.gw_objstruct.allieshqloc.trigger.origin, var_3);
    var_6 = level.hqvecttomid_allies;
  }

  if(var_5 < 2048) {
    return (var_6 * var_4);
  }

  if(var_5 > level.hqdisttomid) {
    if(var_2 == "axis") {
      var_5 = distance(level.gw_objstruct.allieshqloc.trigger.origin, var_3);
    } else {
      var_5 = distance(level.gw_objstruct.axishqloc.trigger.origin, var_3);
    }

    var_7 = 100 - var_5 * 100 / level.hqdisttomid;
    var_8 = var_6 * var_5 * -1 * var_7 / 100;
    return var_8;
  }

  var_7 = 100 - var_7 * 100 / level.hqdisttomid;
  var_8 = var_8 * var_6 * var_7 / 100;
  return var_8;
}

function ref_1368d() {
  if(isDefined(self.selectedspawnarea) && issubstr(self.selectedspawnarea, "HQ")) {
    return true;
  }

  return false;
}