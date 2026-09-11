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
    var0 = 1000;
    var1 = getdvarint("proxchat_radius_override", 0);

    if(var1 != 0) {
      var0 = var1;
    }

    setDvar("NNMLSMNTOQ", var0);
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

  var0 = [];
  GscBinSkip0(0x2e, 0, (-22592, 27367, 1000));
}

function ref_12c14() {
  wait 5;
  var0 = [];
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

  foreach(var2, var1 in game["killstreakTable"].tabledatabyref) {
    level.waypointcolors[var2 + "_incoming"] = "neutral";
    level.waypointbgtype[var2 + "_incoming"] = 1;
    level.waypointstring[var2 + "_incoming"] = "";
    level.waypointshader[var2 + "_incoming"] = var1["hudIcon"];
    level.waypointpulses[var2 + "_incoming"] = 0;
    level.waypointcolors[var2] = "neutral";
    level.waypointbgtype[var2] = 1;
    level.waypointstring[var2] = "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS";
    level.waypointshader[var2] = var1["hudIcon"];
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
  var0 = ["_a", "_b", "_c", "_d", "_e"];
  var1 = 0;

  foreach(var3 in level.startingfobnames_allies) {
    var4 = spawnStruct();
    var4.name = var3;
    var4.trigger = scripts\cp_mp\utility\game_utility::getlocaleent(var3);
    var4.trigger.objkey = var0[var1];
    var1++;
    level.gw_objstruct.startingfobs_allies[level.gw_objstruct.startingfobs_allies.size] = var4;
  }

  foreach(var3 in level.startingfobnames_axis) {
    var4 = spawnStruct();
    var4.name = var3;
    var4.trigger = scripts\cp_mp\utility\game_utility::getlocaleent(var3);
    var4.trigger.objkey = var0[var1];
    var1++;
    level.gw_objstruct.startingfobs_axis[level.gw_objstruct.startingfobs_axis.size] = var4;
  }

  foreach(var3 in level.startingfobnames_neutral) {
    var4 = spawnStruct();
    var4.name = var3;
    var4.trigger = scripts\cp_mp\utility\game_utility::getlocaleent(var3);
    var4.trigger.objkey = var0[var1];
    var1++;
    level.gw_objstruct.startingfobs_neutral[level.gw_objstruct.startingfobs_neutral.size] = var4;
  }
}

function updatedomscores() {
  level endon("game_ended");
  var0 = undefined;
  var1 = undefined;
  level waittill("prematch_done");
  level thread scripts\mp\spawnselection::ref_13fd9();

  while(!level.gameended) {
    wait 10;
    scripts\mp\hostmigration::waittillhostmigrationdone();
    var2 = getowneddomflags();

    if(!isDefined(level.scoretick)) {
      level.scoretick = [];
    }

    foreach(var4 in level.teamnamelist) {
      level.scoretick[var4] = 0;
    }

    if(var2.size) {
      for(var6 = 1; var6 < var2.size; var6++) {
        var7 = var2[var6];
        var8 = gettime() - var7.capturetime;

        for(var9 = var6 - 1; var9 >= 0 && var8 > gettime() - var2[var9].capturetime; var9--) {
          var2 = var2[var9];
        }

        var2 = var7;
      }

      foreach(var7 in var2) {
        var11 = var7 scripts\mp\gameobjects::getownerteam();
        var0 = getteamscore(var11);
        var12 = scripts\mp\gametypes\obj_dom::getteamflagcount(var11);

        if(var12 >= level.flagsrequiredtoscore) {
          level.scoretick[var11] += level.pointsperflag;
        }
      }
    }

    updatescores();
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

function runobjectives(var0) {
  level.axisspawnareas = [level.axishqname];
  level.alliesspawnareas = [level.allieshqname];
  level.allfobs = [];

  if(istrue(level.useobjectives)) {
    foreach(var2 in level.gw_objstruct.startingfobs_axis) {
      var3 = runobjflag(var2.trigger, "axis");
      level.allfobs[level.allfobs.size] = var2;
      level.axisspawnareas[level.axisspawnareas.size] = var2.name;

      if(isDefined(level.spawnselectionlocations[var2.name]["axis"].anchorentity)) {
        level.spawnselectionlocations[var2.name]["axis"].anchorentity.origin = var2.trigger.origin + (0, 0, 100);
      }
    }

    foreach(var2 in level.gw_objstruct.startingfobs_allies) {
      var3 = runobjflag(var2.trigger, "allies");
      level.allfobs[level.allfobs.size] = var2;
      level.alliesspawnareas[level.alliesspawnareas.size] = var2.name;

      if(isDefined(level.spawnselectionlocations[var2.name]["allies"].anchorentity)) {
        level.spawnselectionlocations[var2.name]["allies"].anchorentity.origin = var2.trigger.origin + (0, 0, 100);
      }
    }

    foreach(var2 in level.gw_objstruct.startingfobs_neutral) {
      var3 = runobjflag(var2.trigger, "neutral");
      level.allfobs[level.allfobs.size] = var2;
    }

    foreach(var2 in level.allfobs) {
      var2.trigger.gameobject.oncontested = &objective_oncontested;
      var2.trigger.gameobject.onuncontested = &objective_onuncontested;
      var2.trigger.gameobject.onuse = &objective_onuse;
      var2.trigger.gameobject.onbeginuse = &objective_onusebegin;
      var2.trigger.gameobject.onenduse = &objective_onuseend;
      var2.trigger.gameobject.onpinnedstate = &objective_onpinnedstate;
      var2.trigger.gameobject.onunpinnedstate = &objective_onunpinnedstate;

      if(istrue(level.playinggulagbink)) {
        var2.ref_136cd = &scripts\mp\gametypes\obj_dom::ref_136ce;
      }

      level.objectives[var2.trigger.gameobject.objectivekey] = var2.trigger.gameobject;
      level.spawnselectionlocations[var2.name]["allies"].objectivekey = var2.trigger.gameobject.objectivekey;
      level.spawnselectionlocations[var2.name]["axis"].objectivekey = var2.trigger.gameobject.objectivekey;
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

  foreach(var1 in level.allfobs) {
    var1.trigger.gameobject scripts\mp\gameobjects::allowuse("enemy");
  }
}

function objective_manageobjectivesintrovisibility() {
  wait 1;
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.axishqloc.marker.objidnum);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.allieshqloc.marker.objidnum);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.axishqloc.nuclear_core_on_chopper.objidnum);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.allieshqloc.nuclear_core_on_chopper.objidnum);

  foreach(var1 in level.allfobs) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var1.trigger.gameobject.objidnum);
  }

  if(isDefined(level.rallypointvehicles)) {
    foreach(var4 in level.rallypointvehicles) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var4.marker.objidnum);
    }
  }

  while(!scripts\mp\flags::gameflag("prematch_done")) {
    waitframe();
  }

  scripts\mp\objidpoolmanager::objective_teammask_addtomask(level.gw_objstruct.axishqloc.marker.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(level.gw_objstruct.allieshqloc.marker.objidnum, "allies");

  foreach(var1 in level.allfobs) {
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(var1.trigger.gameobject.objidnum);
  }

  if(isDefined(level.rallypointvehicles)) {
    foreach(var4 in level.rallypointvehicles) {
      if(isDefined(var4)) {
        scripts\mp\objidpoolmanager::objective_teammask_addtomask(var4.marker.objidnum, var4.team);
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

  var0 = "allies";
  var1 = level.spawnselectionteamforward[var0];
  var2 = ["gw_fob_alliesHQ", "gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05"];

  foreach(var4 in var2) {
    var5 = level.spawnselectionlocations[var4][var0].anchorentity.origin;
    var6 = var5 + var1 * -8500 + (0, 0, 7000);
    var7 = vectorNormalize(var5 - var6);
    var8 = scripts\mp\utility\script::vectortoanglessafe(var7, (0, 0, 1));

    if(istrue(level.useunifiedspawnselectioncameraheight)) {
      var9 = scripts\mp\spawnselection::getunifedspawnselectioncameraheight();
      var6 = (var6[0], var6[1], var9);
    }

    var6 += calculatecameraoffset(var0, var5);
    level.spawncameras[var4][var0].origin = var6;
    level.spawncameras[var4][var0].angles = var8;
  }

  while(!isDefined(level.spawncameras["gw_fob_axisHQ"])) {
    waitframe();
  }

  var0 = "axis";
  var1 = level.spawnselectionteamforward[var0];
  var2 = ["gw_fob_axisHQ", "gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05"];

  foreach(var4 in var2) {
    var5 = level.spawnselectionlocations[var4][var0].anchorentity.origin;
    var6 = var5 + var1 * -8500 + (0, 0, 7000);
    var7 = vectorNormalize(var5 - var6);
    var8 = scripts\mp\utility\script::vectortoanglessafe(var7, (0, 0, 1));

    if(istrue(level.useunifiedspawnselectioncameraheight)) {
      var9 = scripts\mp\spawnselection::getunifedspawnselectioncameraheight();
      var6 = (var6[0], var6[1], var9);
    }

    var6 += calculatecameraoffset(var0, var5);
    level.spawncameras[var4][var0].origin = var6;
    level.spawncameras[var4][var0].angles = var8;
  }
}

function updatefobspawnselection() {
  level.axisspawnareas = [level.axishqname];
  level.alliesspawnareas = [level.allieshqname];

  foreach(var1 in level.allfobs) {
    var2 = var1.trigger.gameobject;

    if(var2.ownerteam == "axis") {
      level.axisspawnareas[level.axisspawnareas.size] = var1.name;

      if(isDefined(level.spawnselectionlocations[var1.name]["axis"].anchorentity)) {
        level.spawnselectionlocations[var1.name]["axis"].anchorentity.origin = var1.trigger.origin + (0, 0, 100);
      }

      continue;
    }

    if(var2.ownerteam == "allies") {
      level.alliesspawnareas[level.alliesspawnareas.size] = var1.name;

      if(isDefined(level.spawnselectionlocations[var1.name]["allies"].anchorentity)) {
        level.spawnselectionlocations[var1.name]["allies"].anchorentity.origin = var1.trigger.origin + (0, 0, 100);
      }
    }
  }

  scripts\mp\spawnselection::setspawnlocations(level.axisspawnareas, "axis");
  scripts\mp\spawnselection::setspawnlocations(level.alliesspawnareas, "allies");
}

function sethqmarkerobjective() {
  var0 = "any";
  var1 = level.gw_objstruct.axishqloc.trigger.origin;
  var2 = scripts\mp\gameobjects::createobjidobject(var1, "neutral", (0, 0, 0), undefined, var0, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var2.objidnum, 0);
  var2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var2.objidnum, "icon_waypoint_hq_friendly");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var2.objidnum, 6);
  var2.lockupdatingicons = 1;
  level.gw_objstruct.axishqloc.marker = var2;
  level.uncapturableobjectives[level.uncapturableobjectives.size] = var2;
  var2 = scripts\mp\gameobjects::createobjidobject(var1, "neutral", (0, 0, 0), undefined, var0, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var2.objidnum, 0);
  var2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var2.objidnum, "icon_waypoint_hq_enemy");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var2.objidnum, 7);
  var2.lockupdatingicons = 1;
  level.gw_objstruct.axishqloc.nuclear_core_on_chopper = var2;
  level.uncapturableobjectives[level.uncapturableobjectives.size] = var2;
  var1 = level.gw_objstruct.allieshqloc.trigger.origin;
  var2 = scripts\mp\gameobjects::createobjidobject(var1, "neutral", (0, 0, 0), undefined, var0, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var2.objidnum, 0);
  var2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var2.objidnum, "icon_waypoint_hq_friendly");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var2.objidnum, 6);
  var2.lockupdatingicons = 1;
  level.gw_objstruct.allieshqloc.marker = var2;
  level.uncapturableobjectives[level.uncapturableobjectives.size] = var2;
  var2 = scripts\mp\gameobjects::createobjidobject(var1, "neutral", (0, 0, 0), undefined, var0, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var2.objidnum, 0);
  var2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var2.objidnum, "icon_waypoint_hq_enemy");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var2.objidnum, 7);
  var2.lockupdatingicons = 1;
  level.gw_objstruct.allieshqloc.nuclear_core_on_chopper = var2;
  level.uncapturableobjectives[level.uncapturableobjectives.size] = var2;
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

function objective_onuncontested(var0) {
  scripts\mp\gametypes\obj_dom::dompoint_onuncontested(var0);

  if(istrue(self.updatedoncontestedspawnselection)) {
    updatefobspawnselection();
    self.updatedoncontestedspawnselection = 0;
    return;
  }
}

function objective_onusebegin(var0) {
  scripts\mp\gametypes\obj_dom::dompoint_onusebegin(var0);
  updatefobspawnselection();
}

function objective_onuseend(var0, var1, var2) {
  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var0, var1, var2);
  updatefobspawnselection();
}

function objective_onuse(var0) {
  scripts\mp\gametypes\obj_dom::dompoint_onuse(var0);
  updatefobspawnselection();
}

function objective_onuseupdate(var0, var1, var2, var3) {}

function objective_onpinnedstate(var0) {
  updatefobspawnselection();
  scripts\mp\gametypes\obj_dom::dompoint_onunpinnedstate(var0);
}

function objective_onunpinnedstate(var0) {
  updatefobspawnselection();
  scripts\mp\gametypes\obj_dom::dompoint_onunpinnedstate(var0);
}

function dommainloop() {}

function runobjflag(var0, var1) {
  level endon("game_ended");

  while(!isDefined(level.spawnselectionlocations)) {
    waitframe();
  }

  var0.script_label = var0.objkey;
  var2 = scripts\mp\gametypes\obj_dom::setupobjective(var0, undefined, undefined, undefined, 0);
  var2.origin = var0.origin;
  var2 scripts\mp\gameobjects::allowuse("none");
  var2.didstatusnotify = 0;
  var2 scripts\mp\gameobjects::setownerteam(var1);
  var3 = "any";

  if(var1 != "neutral") {
    if(level.hideenemyfobs) {
      var3 = "friendly";
    }

    var2.capturetime = gettime();
  }

  var2 scripts\mp\gameobjects::setvisibleteam(var3);
  return var2;
}

function dropcrate(var0, var1, var2) {
  var3 = scripts\cp_mp\killstreaks\airdrop::droparmcratefromscriptedheli(var2, var0, var1.origin, (0, randomint(360), 0), undefined);
  return var3;
}

function docratedropsmoke(var0, var1, var2) {
  var3 = var1.origin + (0, 0, 2000);
  var4 = scripts\common\utility::groundpos(var3, (0, 0, 1));
  var1.vfxent = spawn("script_model", var4);
  var1.vfxent setModel("tag_origin");
  var1.vfxent.angles = (0, 0, 0);
  var1.vfxent playLoopSound("smoke_carepackage_smoke_lp");
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_gr"), var1.vfxent, "tag_origin");

  if(isDefined(var0)) {
    var0 scripts\engine\utility::ref_143b9(var2, "crate_dropped");
  } else {
    wait var2;
  }

  stopFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_gr"), var1.vfxent, "tag_origin");
  var1.vfxent delete();
}

function addkillstreakstoqueue(var0) {
  level.killstreaklist[var0] = scripts\engine\utility::array_randomize(level.killstreaklist[var0]);

  foreach(var2 in level.killstreaklist[var0]) {
    level.killstreakqueue[level.killstreakqueue.size] = var2;
  }
}

function dropdefconkillstreaks(var0) {
  level.activezone.airdroplocations[var0] = scripts\engine\utility::array_randomize(level.activezone.airdroplocations[var0]);

  for(var1 = 0; var1 < 3; var1++) {
    var2 = level.activezone.airdroplocations[var0][var1];

    if(isDefined(var2)) {
      var2.isinside = 0;
      thread runkillstreakreward(level, var2.origin);
      wait randomfloatrange(1.5, 2.5);
    }
  }
}

function registervaliddroplocations() {
  scripts\cp_mp\killstreaks\airdrop::initplundercratedata();
  level.validdroplocationstruct = spawnStruct();
  level.validdroplocationstruct.clusters = scripts\engine\utility::getStructArray("dropBagCluterNode", "script_noteworthy");
  var0 = scripts\engine\utility::getStructArray("dropBagLocation", "script_noteworthy");

  foreach(var2 in var0) {
    var2.inuse = 0;

    foreach(var4 in level.validdroplocationstruct.clusters) {
      if(var2.target == var4.targetname) {
        if(!isDefined(var4.droplocations)) {
          var4.droplocations = [];
        }

        var4.droplocations[var4.droplocations.size] = var2;
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

function checkkillstreakcratedrop(var0) {
  if(game["teamScores"][var0] >= level.nextkillstreakgoal) {
    level.nextkillstreakgoal += 100;
    dropkillstreakcrates(2);
    return;
  }
}

function dropkillstreakcrates(var0) {
  var1 = undefined;

  foreach(var3 in level.players) {
    if(isDefined(var3)) {
      var1 = var3;
      break;
    }
  }

  for(var5 = 0; var5 < var0; var5++) {
    var6 = choosecratelocation();
    thread runkillstreakreward(var6, var1, getkillstreak(1));
    wait 5;
  }
}

function choosecratelocation() {
  var0 = randomfloatrange(0, 1);
  var1 = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, var0);
  var2 = vectorlerp(level.c130pathstruct_b.endpt, level.c130pathstruct_b.startpt, var0);
  var3 = vectorlerp(var1, var2, 0.5);
  var4 = scripts\engine\trace::ray_trace(var3, var3 - (0, 0, 100000));
  var3 = var4["position"];
  var5 = findclosestdroplocation(var3);

  if(false) {
    debugsphereonlocation(var1, (0, 0, 1), 100);
    debugsphereonlocation(var2, (0, 0, 1), 100);
    debugsphereonlocation(var3, (1, 0, 0), 100);
    debugsphereonlocation(var5.origin, (0, 1, 0), 100);
    thread scripts\mp\utility\debug::drawline(var3, var5.origin, 3, (0, 1, 0));
  }

  return var5;
}

function findclosestdroplocation(var0) {
  var1 = spawnStruct();
  var1.origin = var0;
  var2 = var1 scripts\engine\utility::array_sort_with_func(level.validdroplocationstruct.clusters, &sortlocationsbydistance);

  foreach(var4 in var2) {
    var5 = scripts\engine\utility::array_randomize(var4.droplocations);

    if(false) {
      return var5[0];
    }

    foreach(var7 in var5) {
      if(!var7.inuse) {
        var7.inuse = 1;
        return var7;
      }
    }
  }

  return undefined;
}

function choosenukecratelocation() {
  var0 = randomfloatrange(level.mapsafecorners[1][0], level.mapsafecorners[0][0]);
  var1 = randomfloatrange(level.mapsafecorners[1][1], level.mapsafecorners[0][1]);
  var2 = (var0, var1, 100000);
  var3 = scripts\engine\trace::ray_trace(var2, var2 - (0, 0, 100000));
  var2 = var3["position"];
  var4 = findclosestdroplocation(var2);

  if(false) {
    debugsphereonlocation(var2, (1, 0, 0), 100);
    debugsphereonlocation(var4.origin, (0, 1, 0), 100);
    thread scripts\mp\utility\debug::drawline(var2, var4.origin, 3, (0, 1, 0));
  }

  return var4;
}

function runkillstreakreward(var0, var1, var2) {
  level endon("game_ended");
  var3 = undefined;
  var4 = scripts\mp\gameobjects::createobjidobject(var0.origin, "neutral", (0, 0, 72), undefined, "any");
  var4.origin = var0.origin;
  var4.angles = var0.angles;
  thread docratedropsmoke(undefined, var0, 16);
  var4.iconname = "_incoming";
  var4.lockupdatingicons = 0;
  var4 scripts\mp\gameobjects::setobjectivestatusicons(var2);
  var4.lockupdatingicons = 1;
  wait 4;
  var3 = scripts\cp_mp\killstreaks\airdrop::droparmcratefromscriptedheli(var1.team, var2, var0.origin, (0, randomint(360), 0), undefined);
  var3.skipminimapicon = 1;
  var3.nevertimeout = 0;
  var3.waitforobjectiveactivate = 1;
  var3.killminimapicon = 0;
  var3.disallowheadiconid = 1;
  var3.isarmcrate = 1;
  var3 waittill("crate_dropped");
  var4.useobj = var3;
  var4.origin = var3.origin;
  var5 = 0;
  var6 = 0.1;
  wait 1;
  var3 notify("objective_activate");
  scripts\mp\objidpoolmanager::update_objective_onentity(var4.objidnum, var3);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var4.objidnum, 72);
  var4.iconname = "";
  var4.lockupdatingicons = 0;
  var4 scripts\mp\gameobjects::setobjectivestatusicons(var2);
  var4.lockupdatingicons = 1;
  objective_setlabel(var4.objidnum, "");
  var3 waittill("death");
  var4 scripts\mp\gameobjects::setvisibleteam("none");
  var4 scripts\mp\gameobjects::releaseid();
  var4.visibleteam = "none";
}

function getkillstreak(var0) {
  if(!isDefined(level.killstreaktierlist)) {
    processkillstreaksintotiers();
  }

  level.killstreaktierlist[var0] = scripts\engine\utility::array_randomize(level.killstreaktierlist[var0]);
  return level.killstreaktierlist[var0][0];
}

function processkillstreaksintotiers() {
  level.killstreaktierlist = [];
  level.killstreaktierlist[3] = ["cruise_predator", "scrambler_drone_guard", "uav"];
  level.killstreaktierlist[2] = ["precision_airstrike", "multi_airstrike", "bradley"];
  level.killstreaktierlist[1] = ["toma_strike", "uav", "pac_sentry", "white_phosphorus"];
  level.killstreaktierlist[0] = ["uav"];
}

function br_getrewardicon(var0) {
  return level.killstreakglobals.streaktable.tabledatabyref[var0]["hudIcon"];
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

function ref_11ef6(var0) {
  level notify("mercy_ending_timer_started");
  level endon("mercy_ending_triggered");
  setomnvar("ui_arm_dominatingTeam", scripts\engine\utility::ter_op(var0 == "axis", 1, 2));
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 9, 2, 1);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 0, 9, level.ref_11bd3);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 1);
  var1 = 0;
  var2 = gettime();
  var3 = level.ref_11bd3 * 1000 + var2;
  setomnvar("ui_nuke_end_milliseconds", level.ref_11bd3 * 1000 + var2);

  while(freeze_bomb_case_timer(var0) == level.objectives.size) {
    waitframe();

    if(gettime() > var3) {
      ref_11ef9(var0);
      level notify("mercy_ending_triggered");
    }
  }

  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 0);
  thread ref_11eef();
}

function ref_11ef9(var0) {
  level endon("game_ended");
  level.ref_11bd4 = 1;
  level.blocknukekills = 1;

  foreach(var2 in level.objectives) {
    var2 scripts\mp\gameobjects::allowuse("none");
  }

  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 0);

  foreach(var5 in level.players) {
    if(isDefined(var5) && !isbot(var5) && istrue(var5.inspawnselection)) {
      if(isDefined(var5.ref_12135)) {
        var5 clearsoundsubmix("iw8_mp_spawn_camera");
        var5.ref_12135 stoploopsound(var5.ref_12136);
        var5.ref_12135 delete();
        var5.ref_12135 = undefined;
        var5.ref_12136 = undefined;
      }
    }
  }

  if(isDefined(level.teamdata[var0]["alivePlayers"][0])) {
    var7 = level.teamdata[var0]["alivePlayers"][0];
    var7 _calloutmarkerping_handleluinotify_acknowledged::tryusenuke();
    return;
  }

  level thread scripts\mp\gamelogic::endgame(var0, game["end_reason"]["mercy_win"], game["end_reason"]["mercy_loss"], 0, 1);
}

function nukeselectgimmewatcher(var0) {
  if(!istrue(var0.hasnukeselectks)) {
    var1 = var0.killcountthislife % level.killstoearnnukeselect;

    if(var1 >= 0 && var0.killcountthislife >= level.killstoearnnukeselect) {
      var0.hasnukeselectks = 1;
      var0 thread scripts\mp\killstreaks\killstreaks::givekillstreak("nuke_select_location", 0, 0, var0);
      var0 scripts\mp\hud_message::showkillstreaksplash("nuke_select_location", undefined, 1);
      return;
    }

    return;
  }
}

function initspawns(var0) {
  level.gamemodestartspawnpointnames = [];

  if(istrue(var0)) {
    var1 = "mp_gw_spawn_allies_start";
    var2 = "mp_gw_spawn_axis_start";
    var3 = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_allies_start_mod");

    if(var3.size > 0) {
      var1 = "mp_gw_spawn_allies_start_mod";
    }

    var4 = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_axis_start_mod");

    if(var4.size > 0) {
      var2 = "mp_gw_spawn_axis_start_mod";
    }
  } else {
    var1 = "mp_gw_spawn_allies_start";
    var2 = "mp_gw_spawn_axis_start";
  }

  level.gamemodestartspawnpointnames["allies"] = var1;
  level.gamemodestartspawnpointnames["axis"] = var2;
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

  scripts\mp\spawnlogic::addstartspawnpoints(var1);
  scripts\mp\spawnlogic::addstartspawnpoints(var2);
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], var1);
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], var2);
  var5 = scripts\mp\spawnlogic::getspawnpointarray(var1);
  var6 = scripts\mp\spawnlogic::getspawnpointarray(var2);
  scripts\mp\spawnlogic::registerspawnset("start_attackers", var5);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", var6);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  var7 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  var8 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", var7);
  scripts\mp\spawnlogic::registerspawnset("fallback", var8);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.spawnpoints = var7;
}

function calculatespawndisttozones(var0) {
  var0.scriptdata.distsqtokothzones = [];

  foreach(var2 in level.objectives) {
    var3 = getpathdist(var0.origin, var2.origin, 5000);

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

function getspawnpoint() {
  var0 = self.pers["team"];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(var0 == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      var1 = scripts\mp\spawnlogic::getspawnpoint(self, var0, undefined, "start_attackers");
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      var1 = scripts\mp\spawnlogic::getspawnpoint(self, var1, undefined, "start_defenders");
    }
  } else {
    scripts\mp\spawnlogic::activatespawnset("normal", 1);
    var1 = scripts\mp\spawnlogic::getspawnpoint(self, var1, undefined, "fallback");
  }

  if(istrue(level.usesquadspawn) && istrue(self.squadspawnconfirmed)) {
    var2 = self getspectatingplayer();

    if(isDefined(var2) && isDefined(self.squadindex) && self.team == var2.team && self.squadindex == var2.squadindex) {
      var1 = scripts\mp\spawnscoring::findteammatebuddyspawn(var2);
    }
  }

  return var1;
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

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  scripts\mp\menus::updatesquadomnvars(self.team, self.squadindex);
  scripts\mp\gametypes\obj_dom::awardgenericmedals(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

  if(level.nukeselectactive && isPlayer(var1) && var3 != "MOD_SUICIDE") {
    if(!isDefined(var1.killcountthislife)) {
      var1.killcountthislife = 0;
    }

    if(!istrue(var1.hasnukeselectks)) {
      var1.killcountthislife++;
    }

    nukeselectgimmewatcher(var1);
  }

  if(!isDefined(level.c130pathkilltracker) || level.c130movementmethod != 1) {
    return;
  }

  level.c130pathkilltracker[self.team] += 1;
}

function managedroppedents(var0) {
  if(!isDefined(level.br_droppedloot)) {
    level.br_droppedloot = [];
  }

  if(level.br_droppedloot.size > 64) {
    for(var1 = 0; var1 < 16; var1++) {
      if(isDefined(level.br_droppedloot[var1])) {
        level.br_droppedloot[var1] delete();
        level.br_droppedloot[var1] = undefined;
      }
    }

    var2 = [];
    var1 = 16;

    if(var1 < level.br_droppedloot.size) {
      GscBinSkip0(0x2e, var1 - 16, level.br_droppedloot[var1]);
    }

    level.br_droppedloot = var2;
  }

  foreach(var4 in var0) {
    level.br_droppedloot[level.br_droppedloot.size] = var4;
  }

  if(!isDefined(level.br_pickups.droppeditems)) {
    level.br_pickups.droppeditems = [];
  }

  if(level.br_pickups.droppeditems.size > 64) {
    for(var1 = 0; var1 < 16; var1++) {
      if(isDefined(level.br_pickups.droppeditems[var1])) {
        level.br_pickups.droppeditems[var1] delete();
        level.br_pickups.droppeditems[var1] = undefined;
      }
    }

    var2 = [];
    var1 = 16;

    if(var1 < level.br_pickups.droppeditems.size) {
      GscBinSkip0(0x2e, var1 - 16, level.br_pickups.droppeditems[var1]);
    }

    level.br_pickups.droppeditems = var2;
    return;
  }
}

function onplayerconnect(var0) {
  if(isDefined(level.rallypointvehicles)) {
    thread scripts\mp\rally_point::rallypoint_showtoplayer(var0);
  }

  if(istrue(level.ref_1408c)) {
    var0 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_initplayer();
  }

  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
}

function onplayerdisconnect(var0) {
  thread scripts\mp\spawnselection::ref_12acb(var0.team, var0.squadindex);
}

function updategamemodespawncamera() {
  var0 = "lane02_4";

  if(isDefined(level.activezone)) {
    var0 = level.activezone.zonetrigger.script_label;
  }

  scripts\mp\spawncamera::setgamemodecamera("allies", level.spawncameras[var0]["allies"]);
  scripts\mp\spawncamera::setgamemodecamera("axis", level.spawncameras[var0]["axis"]);
}

function debugdrawtocameras() {
  for(;;) {
    wait 0.25;

    if(!isDefined(level.players[0])) {
      continue;
    }

    foreach(var1 in level.spawncameras) {
      foreach(var3 in var1) {
        thread scripts\mp\utility\debug::drawangles(var3.origin, var3.angles, 0.25, 50);
        thread scripts\mp\utility\debug::drawsphere(var3.origin, 50, 0.25, scripts\engine\utility::ter_op(var4 == "allies", (0, 0, 1), (1, 0, 0)));
      }
    }
  }
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
  self.spawncameraskipthermal = 0;
  return undefined;
}

function onnormaldeath(var0, var1, var2, var3, var4, var5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4, var5);
}

function spawnspectate(var0, var1) {
  self setspectatedefaults(var0, var1);
  self spawn(var0, var1);
  scripts\mp\utility\player::ref_12898("arm::spawnSpectate() !!!CODE SPAWN!!! @" + var0);
}

function ref_12065() {
  if(!isDefined(self.sessionteam) || self.sessionteam == "spectator" || self.sessionteam == "none" || self calloutmarkerping_getEnt()) {
    return true;
  }

  if(isDefined(self.thrust_fx_model)) {
    return false;
  }

  var0 = scripts\mp\spawnlogic::getspawnpointarray(level.gamemodestartspawnpointnames[self.sessionteam]);
  var1 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var0);
  self.thrust_fx_model = var1;
  spawnspectate(var1.origin, var1.angles);
  return false;
}

function ref_125f1() {
  return self.sessionstate == "spectator" && isDefined(self.thrust_fx_model);
}

function initspecatatorcameras() {
  level.spectatorcameras = [];
  level.currentspectatorcamref = "cop_2";
  var0 = scripts\engine\utility::getStructArray("tac_ops_map_config", "targetname");

  foreach(var2 in var0) {
    var3 = var2.script_noteworthy;
    var4 = scripts\engine\utility::getStructArray(var2.target, "targetname");

    foreach(var6 in var4) {
      switch (var6.script_label) {
        case "to_allies_camera":
          setteammapposition(var3, "allies", var6);
          break;
        case "to_axis_camera":
          setteammapposition(var3, "axis", var6);
          break;
      }
    }
  }
}

function setteammapposition(var0, var1, var2) {
  if(!isDefined(level.spectatorcameras[var0])) {
    level.spectatorcameras[var0] = [];
  }

  level.spectatorcameras[var0][var1] = var2;
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
  var0 = 0;
  var1 = undefined;
  var2 = (0, 0, 0);
  var3 = 1000;
  var4 = self.origin + (0, 0, var3);
  var5 = self.angles;
  self.deathspectatepos = var4;
  self.deathspectateangles = var5;
  var6 = spawn("script_model", self getvieworigin());
  var6 setModel("tag_origin");
  var6.angles = var5;
  self.spectatorcament = var6;
  self.isusingtacopsmapcamera = 1;
  self cameralinkTo(var6, "tag_origin", 1);
  thread dohalfwayflash();
  movecameratomappos(var6, self, var4, var5);
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

function movecameratomappos(var0, var1, var2) {
  var0 endon("spawned_player");
  var3 = 1;
  var4 = 1;
  self moveTo(var1, 2, 1, 1);
  var0 playlocalsound("mp_cmd_camera_zoom_out");
  var0 setclienttriggeraudiozonepartialwithfade("spawn_cam", 0.5, "mix");
  self rotateTo(var2, 2, 1, 1);
  wait 1.1;
  var5 = anglesToForward(var2) * 300;
  var5 *= (1, 1, 0);

  if(isDefined(var0) && isDefined(var0.spectatorcament)) {
    self moveTo(var1 + var5, 15, 1, 1);
    var0 earthquakeforplayer(0.03, 15, var1 + var5, 1000);
    return;
  }
}

function runslamzoomonspawn() {
  self waittill("spawned_player");
  var0 = self getEye();
  var1 = self.angles;
  scripts\mp\utility\player::updatesessionstate("spectator");
  self cameralinkTo(self.spectatorcament, "tag_origin", 1);
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.2);
  self.spectatorcament moveTo(var0, 0.5);
  self playlocalsound("mp_cmd_camera_zoom_in");
  self clearclienttriggeraudiozone(0.5);
  self.spectatorcament rotateTo(var1, 0.5, 0.5);
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
  var0 = newclienthudelem(self);
  var0.x = 0;
  var0.y = 0;
  var0.alignx = "left";
  var0.aligny = "top";
  var0.sort = 1;
  var0.horzalign = "fullscreen";
  var0.vertalign = "fullscreen";
  var0.alpha = 1;
  var0.foreground = 1;
  var0 setshader("white", 640, 480);
  var0 fadeovertime(0.4);
  var0.alpha = 0;
  wait 0.4;
  var0 destroy();
}

function arm_playstatusdialog(var0, var1) {
  var2 = "dx_mpa_ustl_" + var0;
  var2 = tolower(var2);
  var3 = undefined;

  if(var1 == "bothTeams") {
    var4 = scripts\mp\utility\teams::getteamdata("axis", "players");
    var5 = scripts\mp\utility\teams::getteamdata("allies", "players");
    var3 = scripts\engine\utility::array_combine(var4, var5);
  } else if(var1 == "axis" || var1 == "allies") {
    var3 = scripts\mp\utility\teams::getteamdata(var1, "players");
  }

  foreach(var7 in var3) {
    if(!isbot(var7)) {
      arm_leaderdialogonplayer_internal(var7, var2, var0);
    }
  }
}

function arm_playstatusdialogonplayer(var0) {
  var1 = "dx_mpa_ustl_announcer_" + var0;
  var1 = tolower(var1);
  arm_leaderdialogonplayer_internal(var1, var0);
}

function arm_leaderdialogonplayer_internal(var0, var1) {
  if(isDefined(self.playerlastdialogstatus)) {
    var2 = 5000;

    if(gettime() < self.playerlastdialogstatus["time"] + var2 && self.playerlastdialogstatus["dialog"] == var1) {
      return;
    }

    self.playerlastdialogstatus["time"] = gettime();
    self.playerlastdialogstatus["dialog"] = var1;
  }

  if(soundexists(var0)) {
    self queuedialogforplayer(var0, var1, 2);
    return;
  }
}

function managec130spawns() {
  level endon("game_ended");
  var0 = 6000;
  var1 = 12000;
  var2 = 20000;
  var3 = 1;
  var4 = (0, 0, 6000);
  level.timebetweenc130passes = 0;
  level.flighttime = 20;
  level.spawnc130 = [];

  foreach(var6 in level.teamnamelist) {
    level.spawnc130[var6] = undefined;
  }

  c130_pickrandomflightpath();
  level.spawnc130["axis"] = createc130("axis", level.c130pathstruct_a.startpt + var4);
  level.spawnc130["allies"] = createc130("allies", level.c130pathstruct_b.startpt + var4);

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

    var8 = gettime() + (level.flighttime + level.timebetweenc130passes) * 1000;
    level.timeuntilnextc130["axis"] = var8;
    level.timeuntilnextc130["allies"] = var8;

    if(false) {
      thread scripts\mp\utility\debug::drawline(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 1000, (1, 0, 0));
      thread scripts\mp\utility\debug::drawline(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 1000, (0, 0, 1));
    }

    if(var3) {
      thread handlec130motion(level.spawnc130["axis"], level.c130pathstruct_a.startpt + var4, level.c130pathstruct_a.endpt + var4, level.flighttime);
      thread handlec130motion(level.spawnc130["allies"], level.c130pathstruct_b.startpt + var4, level.c130pathstruct_b.endpt + var4, level.flighttime);
    } else {
      thread handlec130motion(level.spawnc130["axis"], level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, level.flighttime);
      thread handlec130motion(level.spawnc130["allies"], level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, level.flighttime);
    }

    level.c130firstpassstarted = 1;
    level scripts\engine\utility::waittill_all_in_array(["C130_path_complete_axis", "C130_path_complete_allies"]);
    c130_fightpathmove();
    var9 = level.c130pathstruct_a.startpt;
    level.c130pathstruct_a.startpt = level.c130pathstruct_a.endpt;
    level.c130pathstruct_a.endpt = var9;
    var9 = level.c130pathstruct_b.startpt;
    level.c130pathstruct_b.startpt = level.c130pathstruct_b.endpt;
    level.c130pathstruct_b.endpt = var9;
    var3 = 0;

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

function createc130(var0, var1) {
  var2 = spawn("script_model", var1);
  var2 setModel("veh8_mil_air_acharlie130");
  var2 setCanDamage(0);
  var2.maxhealth = 100000;
  var2.health = var2.maxhealth;
  var2.playeroffsets = [(32, 30, 0), (-32, 30, 0), (0, 30, 0), (16, 30, 0), (-16, 30, 0)];
  var2.currentplayeroffset = 0;
  var2.respawnqueue = [];
  var2.players = [];
  var2.team = var0;
  var2 playLoopSound("iw8_ks_ac130_lp");
  var2 thread scripts\mp\gametypes\br_public::gunship_spawnvfx();
  return var2;
}

function handlec130motion(var0, var1, var2, var3) {
  var4 = vectorNormalize(var1 - var0);
  var5 = distance(var1, var0);
  var6 = var0 + var4 * var5 * 0.425;
  var7 = var0 + var4 * var5 * 0.55;
  var8 = var2 * 0.3;
  var9 = var2 * 0.6;
  var10 = var2 * 0.1;
  self.canjoin = 1;
  self.canparachute = 0;
  var11 = vectorNormalize(var1 - var0);
  self.angles = vectortoangles(var11);
  self.origin = var0;
  gatherc130playerstospawn();
  self moveTo(var1, var8 + var9 + var10, var8 * 0.25);
  wait var8;
  self.canparachute = 1;

  foreach(var13 in self.players) {
    var13 notify("canParachute");
  }

  wait var9;
  self.canjoin = 0;
  self.canparachute = 0;

  foreach(var13 in self.players) {
    var13 notify("halo_kick_c130");
  }

  wait var10;
  level notify("C130_path_complete_" + var3);
}

function gatherc130playerstospawn() {
  self.players = scripts\engine\utility::array_combine(self.players, self.respawnqueue);
  self.respawnqueue = [];
  var0 = 1400;
  var1 = (30, 0, 0);
  var2 = anglesToForward(var1) * var0 * -1;
  var3 = self gettagorigin("tag_origin") + var2;
  var4 = self.angles;

  foreach(var6 in self.players) {
    if(!isDefined(var6)) {
      continue;
    }

    var6.forcespawncameraorg = var3;
    var6.forcespawncameraang = var4;
    var6 notify("c130_ready");
  }
}

function removefromspawnselectionaftertime(var0) {
  wait var0;
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
  var0 = level.spawnc130[self.team];
  var0.respawnqueue[var0.respawnqueue.size] = self;

  if(istrue(var0.canjoin)) {
    gatherc130playerstospawn(var0);
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
  thread jumplistener(var0, 0);
  self.br_infil_type = "c130";

  if(!isbot(self)) {
    thread scripts\mp\gametypes\br_public::orbitcam(var0);
    return;
  }
}

function jumplistener(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("jumpListener()");
  self endon("jumpListener()");

  if(isDefined(self.parachute)) {
    self.parachute delete();
  }

  scripts\mp\utility\game::ref_131a3(self, 1);
  thread listenjump(var0, var1);
  thread listenkick(var0, var1);
}

function listenkick(var0, var1) {
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

  var2 = var0 scripts\mp\gametypes\br_public::calctrailpoint();
  thread parachute(var0, var1);
  self notify("br_jump");
  self notify("stop_cam_shake");
}

function listenjump(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("br_jump");
  self notify("listenJump()");
  self endon("listenJump()");
  self notifyonplayercommand("halo_jump_c130", "+gostand");

  for(;;) {
    var2 = scripts\engine\utility::waittill_either("halo_jump_c130", "canParachute");

    if(isDefined(var2) && var2 == "canParachute") {
      self iprintlnbold("Press Jump to Parachute!");
    } else if(!istrue(var0.canparachute)) {
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
  thread parachute(var0, var1);
  self notify("br_jump");
  self notify("stop_cam_shake");
}

function parachute(var0, var1) {
  self endon("jumpListener()");
  self notify("parachute()");
  self endon("parachute()");

  if(self.team == "axis") {
    var2 = level.c130pathstruct_b.midpt;
  } else {
    var2 = level.c130pathstruct_a.midpt;
  }

  var3 = vectorNormalize(var2 - var1.origin);
  var1.players = scripts\engine\utility::array_remove(var1.players, self);

  if(isDefined(var1.playeroffsets) && isDefined(var1.currentplayeroffset)) {
    var4 = var1.playeroffsets[var1.currentplayeroffset];
    self setOrigin(var1.origin + var4, 1, 1);
    var1.currentplayeroffset++;

    if(var1.currentplayeroffset == var1.playeroffsets.size) {
      var1.currentplayeroffset = 0;
    }
  } else {
    var5 = anglesToForward(var1.angles) * var1.br_vieworigin;
    self setOrigin(var1.origin + var5, 1, 1);
  }

  waitframe();
  self playershow();
  self.plotarmor = 0;
  scripts\mp\utility\game::ref_131a3(self, 0);
  self setplayerangles(vectortoangles(var3));
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
    var0 = (level.gw_objstruct.axishqloc.trigger.origin + level.gw_objstruct.allieshqloc.trigger.origin) * 0.5;
    var1 = vectortoangles(level.gw_objstruct.axishqloc.trigger.origin - level.gw_objstruct.allieshqloc.trigger.origin);
    var2 = var1[1];

    if(false) {
      debugsphereonlocation(var0, (0, 1, 0), 100000);
    }
  } else {
    var0 = (level.mapsafecorners[0] + level.mapsafecorners[1]) * 0.5;
    var2 = randomfloatrange(0, 359);
  }

  var3 = makec130pathparamsstruct(var0, var2 - 90);
  level.c130pathstruct_a = scripts\mp\gametypes\br_public::makepathstruct(var3);
  var3.randomangle += 180;
  level.c130pathstruct_b = scripts\mp\gametypes\br_public::makepathstruct(var3);
  var4 = 0.2;
  var5 = 0;
  var6 = 0;

  if(istrue(level.c130spacing_usebigmapsettings)) {
    var4 = 0.1;
    var5 = randomfloatrange(-5000, 5000);
    var6 = randomfloatrange(-5000, 5000);
  }

  var7 = anglestoright(level.c130pathstruct_a.angle);
  level.c130pathstruct_a.startpt = var7 * level.c130distapart + level.c130pathstruct_a.startpt;
  level.c130pathstruct_a.endpt = var7 * level.c130distapart + level.c130pathstruct_a.endpt;
  var7 = anglestoright(level.c130pathstruct_b.angle);
  level.c130pathstruct_b.startpt = var7 * level.c130distapart + level.c130pathstruct_b.startpt;
  level.c130pathstruct_b.endpt = var7 * level.c130distapart + level.c130pathstruct_b.endpt;
  var8 = (var5, var6, 0);
  level.c130pathstruct_a.startpt += var8;
  level.c130pathstruct_a.endpt += var8;
  level.c130pathstruct_a.midpt = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 0.5);
  level.c130pathstruct_b.startpt += var8;
  level.c130pathstruct_b.endpt += var8;
  level.c130pathstruct_b.midpt = vectorlerp(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 0.5);
  level.battlecenter = vectorlerp(level.c130pathstruct_a.midpt, level.c130pathstruct_b.midpt, 0.5);
  level.c130minpathmovementinterval = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_b.endpt, var4);
  level.c130minpathmovementinterval -= level.c130pathstruct_a.startpt;
  level.c130minpathmovementinterval = vectorNormalize(level.c130minpathmovementinterval) * level.c130distapart / 10;
  level.c130minpathmovementinterval = (level.c130minpathmovementinterval[0], level.c130minpathmovementinterval[1], 0);
}

function makec130pathparamsstruct(var0, var1) {
  var2 = 6.28318;
  var3 = var1;
  var4 = 180;
  var5 = level.c130flightdist;
  var6 = spawnStruct();
  var6.r = var5;
  var6.randomangle = var3;
  var6.endangleoffset = var4;
  var6.centerpt = var0;
  return var6;
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
    var0 = (0, 0, 0);
    var1 = (0, 0, 0);
    var2 = 0;
    var3 = 0;

    foreach(var5 in level.players) {
      if(isalive(var5)) {
        if(var5.team == "axis") {
          var0 += var5.origin;
          var2++;
          continue;
        }

        if(var5.team == "allies") {
          var1 += var5.origin;
          var3++;
        }
      }
    }

    if(var2 == 0 || var3 == 0) {
      return;
    }

    var7 = var0 / var2;
    var8 = var1 / var3;
    var9 = vectorlerp(var7, var8, 0.5);
    level.c130minpathmovementinterval = vectorlerp(level.battlecenter, var9, 0.5);
    level.c130minpathmovementinterval -= level.battlecenter;
    var10 = distance2d(level.battlecenter, var9);
    level.c130minpathmovementinterval = vectorNormalize(level.c130minpathmovementinterval) * var10 / 4;
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
        debugsphereonlocation(var9, (0, 1, 0), 700);
      }

      level.battlecenter += level.c130minpathmovementinterval;
      return;
    }

    return;
  }
}

function arenextpathsinsafebounds(var0) {
  return ispointinsafebounds(level.c130pathstruct_a.startpt + var0) && ispointinsafebounds(level.c130pathstruct_a.endpt + var0) && ispointinsafebounds(level.c130pathstruct_b.startpt + var0) && ispointinsafebounds(level.c130pathstruct_b.endpt + var0);
}

function ispointinsafebounds(var0) {
  return var0[0] < level.mapsafecorners[0][0] && var0[0] > level.mapsafecorners[1][0] && var0[1] < level.mapsafecorners[0][1] && var0[1] > level.mapsafecorners[1][1];
}

function registervehicletype(var0, var1, var2) {
  var3 = spawnStruct();
  var3.refname = var0;
  var3.spawncallback = var2;
  var3.vehiclespawns = [[var1]]();

  if(!isDefined(level.vehicleinfo)) {
    level.vehicleinfo = [];
  }

  level.vehicleinfo[var0] = var3;
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

  foreach(var1 in level.vehicleinfo) {
    if(var1.refname == "light_tank" && level.mapname == "mp_downtown_gw" && level.localeid == "locale_6") {
      var2 = [];
      var3 = [];
      var2 = (17465, -21971, -150);
      GscBinSkip0(0x2e, 0, (10, 90, 0));
    }

    if(var9.refname == "atv") {
      if(level.mapname == "mp_farms2_gw" && level.localeid == "locale_9") {
        var11 = [];
        var12 = [];
        var11 = (46022, 1039, 56);
        GscBinSkip0(0x2e, 0, (7, 289, 0));
      }

      if(level.mapname == "mp_downtown_gw" && level.localeid == "locale_6") {
        var11 = [];
        var12 = [];
        var11 = (17806, -20823, -110);
        GscBinSkip0(0x2e, 0, (11, 358, 0));
      }
    }

    if(var3.refname == "tac_rover") {
      if(level.mapname == "mp_farms2_gw" && level.localeid == "locale_9") {
        var11 = [];
        var12 = [];
        var11 = (48384, -1703, 70);
        GscBinSkip0(0x2e, 0, (7, 260, 0));
      }

      if(level.mapname == "mp_downtown_gw" && level.localeid == "locale_6") {
        var11 = [];
        var12 = [];
        var11 = (21969, -11928, -156);
        GscBinSkip0(0x2e, 0, (7, 269, 0));
      }
    }

    if(var12.refname == "cargo_truck" && level.mapname == "mp_downtown_gw" && level.localeid == "locale_6") {
      foreach(var12 in var12.vehiclespawns) {
        if(distancesquared(var12.origin, (20559, -24015, -105)) < 16384) {
          var12.origin = (18119, -21282, -118);
          var12.angles = (6, 55, 0);
        }
      }
    }

    foreach(var11, var12 in var12.vehiclespawns) {
      if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var12.script_noteworthy) && var12.script_noteworthy == level.localeid) {
        if(var12.refname == "light_tank") {
          if(isDefined(var12.script_team) && var12.script_team == "axis") {
            var22 = level.tankspawnlocs_axis.size;
            level.tankspawnlocs_axis[var22] = var12;
            level.tankspawnlocs_axis[var22].refname = var12.refname;
          } else if(isDefined(var12.script_team) && var12.script_team == "allies") {
            var22 = level.tankspawnlocs_allies.size;
            level.tankspawnlocs_allies[var22] = var12;
            level.tankspawnlocs_allies[var22].refname = var12.refname;
          }

          continue;
        }

        if(istrue(level.matchdata_logvictimkillevent) && var12.refname == "jeep" || istrue(level.matchdata_logscoreevent) && var12.refname == "cargo_truck") {
          continue;
        } else {
          var22 = level.vehiclespawnlocs.size;
          level.vehiclespawnlocs[var22] = var12;
          level.vehiclespawnlocs[var22].refname = var12.refname;
        }
      }
    }
  }

  var11 = undefined;
  var12 = undefined;

  if(false) {
    foreach(var26 in level.vehiclespawnlocs) {
      thread scripts\mp\utility\debug::drawline(var26.origin, var26.origin + (0, 0, 1500), 1000, (1, 0, 0));
    }
  }

  level.vehiclespawnlocs = scripts\engine\utility::array_randomize(level.vehiclespawnlocs);
  var28 = level.ref_11f41;

  if(!isDefined(level.ref_11f41)) {
    var28 = 25;
  }

  if(false) {
    for(var13 = 0; var13 < var28; var13++) {
      var26 = level.vehiclespawnlocs[var13];
      thread scripts\mp\utility\debug::drawline(var26.origin + (0, 0, 1500), var26.origin + (0, 0, 2500), 1000, (0, 1, 0));
    }
  }

  for(var13 = 0; var13 < var28; var13++) {
    var26 = level.vehiclespawnlocs[var13];

    if(isDefined(var26)) {
      var12 = level.vehicleinfo[var26.refname];
      [[var12.spawncallback]](var26);
    }
  }

  scripts\mp\flags::gameflagwait("prematch_countdown");
  level.numhqtanks_axis = 0;
  level.numhqtanks_allies = 0;
  thread vehiclespawn_hqtanks(level.tankspawnlocs_axis);
  thread vehiclespawn_hqtanks(level.tankspawnlocs_allies);
}

function vehiclespawn_hqtanks(var0) {
  foreach(var2 in var0) {
    var3 = level.vehicleinfo[var2.refname];
    [[var3.spawncallback]](var2);
    wait randomfloatrange(2, 3);
  }
}

function vehiclespawn_truck(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("technical", var2, var1);
}

function vehiclespawn_littlebird(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird", var2, var1);
}

function ref_14266(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird_mg", var2, var1);
}

function vehiclespawn_copcar(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("cop_car", var2, var1);
}

function vehiclespawn_atv(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("atv", var2, var1);
}

function vehiclespawn_cargotruck(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("cargo_truck", var2, var1);
}

function vehiclespawn_hoopty(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("hoopty", var2, var1);
}

function vehiclespawn_hooptytruck(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("hoopty_truck", var2, var1);
}

function vehiclespawn_jeep(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("jeep", var2, var1);
}

function vehiclespawn_largetransport(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("large_transport", var2, var1);
}

function vehiclespawn_medtransport(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("medium_transport", var2, var1);
}

function vehiclespawn_pickuptruck(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("pickup_truck", var2, var1);
}

function vehiclespawn_tacrover(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("tac_rover", var2, var1);
}

function vehiclespawn_van(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("van", var2, var1);
}

function vehiclespawn_tank(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  var2.spawnmethod = "airdrop_at_position_unsafe";

  if(isDefined(var0.script_team) && var0.script_team == "axis") {
    if(level.numhqtanks_axis >= level.maxhqtanks) {
      return;
    }

    var2.usealtmodel = 1;
    var2.team = "axis";
    level.numhqtanks_axis++;
  } else {
    if(level.numhqtanks_allies >= level.maxhqtanks) {
      return;
    }

    var2.team = "allies";
    level.numhqtanks_allies++;
  }

  var3 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("light_tank", var2, var1);

  if(istrue(level.ref_13377)) {
    ref_1413b(var3, var3.team);
  }

  return var3;
}

function ref_1413b(var0, var1) {
  wait 1;
  var2 = scripts\mp\gameobjects::createobjidobject(var0.origin, var1, (0, 0, 0), undefined, 0, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var2.objidnum, var1);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var2.objidnum);
  scripts\mp\objidpoolmanager::objective_set_play_intro(var2.objidnum, 0);
  var2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var2.objidnum, "icon_minimap_bradley_spawn_selection");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var2.objidnum, 1);
  scripts\mp\objidpoolmanager::update_objective_onentity(var2.objidnum, var0);
  var2.lockupdatingicons = 1;

  foreach(var4 in level.players) {
    if(isDefined(var4) && isDefined(var4.team) && var4.team == var1 && istrue(var4.inspawnselection)) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var2.objidnum, var4);
    }
  }

  var0.ref_1369d = var2;
  thread ref_14228(var0);
  level.ref_13c4a[var1][level.ref_13c4a[var1].size] = var0;
}

function ref_14228(var0) {
  var1 = var0.ref_1369d.objidnum;
  var2 = var0.team;
  var0 waittill("death");
  scripts\mp\objidpoolmanager::returnobjectiveid(var1);
  level.ref_13c4a[var2] = scripts\engine\utility::array_remove(level.ref_13c4a[var2], var0);
}

function ref_1420e() {
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(var1 in level.ref_13c4a[self.team]) {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var1.ref_1369d.objidnum, self);
  }

  while(self.inspawnselection) {
    waitframe();
  }

  foreach(var1 in level.ref_13c4a["axis"]) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var1.ref_1369d.objidnum, self);
  }

  foreach(var1 in level.ref_13c4a["allies"]) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var1.ref_1369d.objidnum, self);
  }
}

function vehiclespawn_getspawndata(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin;
  var1.angles = var0.angles;
  var1.spawntype = "GAME_MODE";
  var1.showheadicon = 1;
  return var1;
}

function droptank_playincomingdialog(var0) {
  var1 = var0.team;
  var2 = "bradley";

  if(level.teambased) {
    if(isDefined(level.killstreakactivatedtime[var2])) {
      if(isDefined(level.killstreakactivatedtime[var2][var1])) {
        if(gettime() < level.killstreakactivatedtime[var2][var1]) {
          return;
        }
      }
    }

    level.killstreakactivatedtime[var2][var1] = gettime() + scripts\mp\utility\dialog::getkillstreakdialogcooldown() * 1000;
  }

  scripts\mp\utility\dialog::leaderdialog(var1 + "_friendly_" + var2 + "_inbound", var1, "killstreak_used");
}

function ref_1413a(var0, var1) {
  wait 1;
  var2 = scripts\mp\gameobjects::createobjidobject(var0.origin, var1, (0, 0, 0), undefined, 0, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var2.objidnum, var1);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var2.objidnum);
  scripts\mp\objidpoolmanager::objective_set_play_intro(var2.objidnum, 0);
  var2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var2.objidnum, "icon_minimap_littlebird_static");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var2.objidnum, 1);
  scripts\mp\objidpoolmanager::update_objective_onentity(var2.objidnum, var0);
  var2.lockupdatingicons = 1;

  foreach(var4 in level.players) {
    if(isDefined(var4) && istrue(var4.inspawnselection)) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var2.objidnum, var4);
    }
  }

  var0.ref_1369d = var2;
  thread ref_14227(var0);
  level.ref_13c49["untouched"][level.ref_13c49["untouched"].size] = var0;
}

function ref_14227(var0) {
  var1 = var0.ref_1369d.objidnum;
  var0 waittill("death");
  scripts\mp\objidpoolmanager::returnobjectiveid(var1);
  var2 = var0.watch_for_player_entered_trap_room;

  if(!isDefined(var0.watch_for_player_entered_trap_room)) {
    var2 = "untouched";
  }

  level.ref_13c49[var2] = scripts\engine\utility::array_remove(level.ref_13c49[var2], var0);
}

function ref_1420f() {
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(var1 in level.ref_13c49[self.team]) {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var1.ref_1369d.objidnum, self);
  }

  foreach(var1 in level.ref_13c49["untouched"]) {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var1.ref_1369d.objidnum, self);
  }

  while(self.inspawnselection) {
    waitframe();
  }

  foreach(var1 in level.ref_13c49["axis"]) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var1.ref_1369d.objidnum, self);
  }

  foreach(var1 in level.ref_13c49["allies"]) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var1.ref_1369d.objidnum, self);
  }

  foreach(var1 in level.ref_13c49["untouched"]) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var1.ref_1369d.objidnum, self);
  }
}

function ref_141ff(var0) {
  if(isDefined(self.watch_for_player_entered_trap_room)) {
    level.ref_13c49[self.watch_for_player_entered_trap_room] = scripts\engine\utility::array_remove(level.ref_13c49[self.watch_for_player_entered_trap_room], self);
  } else {
    level.ref_13c49["untouched"] = scripts\engine\utility::array_remove(level.ref_13c49["untouched"], self);
  }

  self.watch_for_player_entered_trap_room = var0;
  level.ref_13c49[var0][level.ref_13c49[var0].size] = self;
  scripts\mp\objidpoolmanager::update_objective_icon(self.ref_1369d.objidnum, "icon_minimap_littlebird_spawn_selection");

  foreach(var2 in level.players) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.ref_1369d.objidnum, var2);

    if(isDefined(var2) && isDefined(var2.team) && var2.team == var0 && istrue(var2.inspawnselection)) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.ref_1369d.objidnum, var2);
      continue;
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.ref_1369d.objidnum, var2);
  }
}

function init_rallyvehicles() {
  while(!isDefined(level.spawnselectionlocations)) {
    waitframe();
  }

  waitframe();
  level.rallypointvehicles = [];
  var0 = scripts\engine\utility::getStructArray("rallyPointTechnical", "targetname");

  foreach(var7, var2 in var0) {
    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var2.script_noteworthy) && var2.script_noteworthy != level.localeid) {
      continue;
    }

    var3 = scripts\engine\utility::ter_op(var2.script_team == "axis", "axis", "allies");
    var4 = getrallyvehiclespawndata(var2, var3);
    var5 = spawnStruct();
    var6 = scripts\mp\vehicles\technical_mp::technical_mp_spawncallback(var4, var5);

    if(isDefined(var6)) {
      level.rallypointvehicles[level.rallypointvehicles.size] = var6;
    }
  }

  var0 = scripts\engine\utility::getStructArray("rallyPointLittleBird", "targetname");

  if(!istrue(level.disablelittlebirdrally)) {
    foreach(var2 in var0) {
      if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var2.script_noteworthy) && var2.script_noteworthy != level.localeid) {
        continue;
      }

      var3 = scripts\engine\utility::ter_op(var2.script_team == "axis", "axis", "allies");
      var4 = getrallyvehiclespawndata(var2, var3);
      var5 = spawnStruct();

      if(level.move_spawnpoints_to_valid_positions) {
        var6 = _x1opsnpcwaittilluse::xyvelscale_low(var4, var5);
      } else {
        var6 = scripts\mp\vehicles\little_bird_mp::little_bird_mp_spawncallback(var4, var5);
      }

      if(isDefined(var6)) {
        level.rallypointvehicles[level.rallypointvehicles.size] = var6;
      }
    }
  } else if(!istrue(level.completelyremovelittlebird)) {
    if(level.localeid == "locale_6" && level.mapname == "mp_downtown_gw" && istrue(level.ref_11ac5)) {
      var10 = [];
      GscBinSkip0(0x2e, 0, (23718, -4470, -350));
    }

    foreach(var3 in var1) {
      if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var3.script_noteworthy) && var3.script_noteworthy != level.localeid) {
        continue;
      }

      if(!isDefined(var3.angles)) {
        var3.angles = (0, randomfloat(360), 0);
      }

      var5 = vehiclespawn_getspawndata(var3);

      if(level.move_spawnpoints_to_valid_positions) {
        var7 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird_mg", var5, undefined);
      } else {
        var7 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird", var5, undefined);
      }

      thread ref_1413a(level, var7);
    }
  }

  var1 = scripts\engine\utility::getStructArray("rallyPointAPC", "targetname");

  foreach(var3 in var1) {
    var4 = scripts\engine\utility::ter_op(var3.script_team == "axis", "axis", "allies");
    var5 = getrallyvehiclespawndata(var3, var4);

    if(var4 == "allies") {
      var5.usealtmodel = 1;
    }

    var6 = spawnStruct();
    var7 = scripts\mp\vehicles\apc_rus_mp::apc_rus_mp_spawncallback(var5, var6);

    if(isDefined(var7)) {
      level.rallypointvehicles[level.rallypointvehicles.size] = var7;
      LOC_000003db:
    }
    LOC_000003db:
  }

  foreach(var19 in level.teamnamelist) {
    while(!isDefined(level.availablespawnlocations[var19][0])) {
      waitframe();
    }
  }

  var21 = 0;
  var22 = 0;
  var23 = 0;
  var24 = 0;
  var25 = 0;
  var26 = 0;
  var27 = "gw_vehicle_technical_";
  var28 = "gw_vehicle_littlebird_";
  var29 = "gw_vehicle_apc_";

  foreach(var7 in level.rallypointvehicles) {
    var5 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(var7);

    if(!isDefined(var5.rallypointhealth)) {
      var5.rallypointhealth = var7.health;
    } else {
      var7.health = var5.rallypointhealth;
    }

    var13 = 0;
    var31 = undefined;

    if(var7.team == "axis") {
      if(var7.vehiclename == "technical") {
        var21++;

        if(var21 <= 8) {
          var5.ref = var27 + var21;
        }
      } else if(var7.vehiclename == "little_bird" || var7.vehiclename == "little_bird_mg") {
        var22++;

        if(var22 <= 2) {
          var5.ref = var28 + var22;
        }
      } else if(var7.vehiclename == "apc_russian") {
        var23++;

        if(var23 <= 2) {
          var5.ref = var29 + var23;
        }
      }
    } else if(var7.vehiclename == "technical") {
      var24++;

      if(var24 <= 8) {
        var5.ref = var27 + var24;
      }
    } else if(var7.vehiclename == "little_bird" || var7.vehiclename == "little_bird_mg") {
      var25++;

      if(var25 <= 2) {
        var5.ref = var28 + var25;
      }
    } else if(var7.vehiclename == "apc_russian") {
      var26++;

      if(var26 <= 2) {
        var5.ref = var29 + var26;
      }
    }

    if(istrue(level.userallypointvehicles) && level.userallypointvehicles != 2) {
      watchvehicleforrallypointactivation(var7);
    }
  }
}

function watchvehicleforrallypointactivation(var0) {
  scripts\mp\rally_point::rallypointvehicle_activate(var0);
}

function getrallyvehiclespawndata(var0, var1) {
  var2 = spawnStruct();
  var2.origin = var0.origin;
  var2.angles = var0.angles;
  var2.spawntype = "GAME_MODE";
  var2.cannotbesuspended = 1;
  var2.team = var1;
  return var2;
}

function arm_initoutofbounds() {
  level.outofboundstriggers = [];
  var0 = getEntArray("OutOfBounds", "targetname");

  foreach(var2 in var0) {
    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var2.script_noteworthy) && var2.script_noteworthy == level.localeid && scripts\mp\utility\game_utility_mp::ref_11c8a(var2)) {
      level.outofboundstriggers[level.outofboundstriggers.size] = var2;
      continue;
    }

    var2 delete();
  }
}

function debugprint(var0) {
  if(false) {
    return;
  }
}

function isobjectivecontested(var0) {
  if(var0.ownerteam == "axis") {
    return (var0.numtouching["allies"] > 0);
  }

  if(var0.ownerteam == "allies") {
    return (var0.numtouching["axis"] > 0);
  }
}

function freeze_bomb_case_timer(var0) {
  var1 = 0;

  foreach(var3 in level.objectives) {
    if(var3.ownerteam == var0) {
      var1++;
    }
  }

  return var1;
}

function createhintobject(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  var12 = undefined;

  if(isDefined(var11)) {
    var12 = var11;
  } else {
    var12 = spawn("script_model", var0);
  }

  var12 makeusable();

  if(isDefined(var11) && isDefined(var0)) {
    var12 sethinttag(var0);
  }

  if(isDefined(var1)) {
    var12 setCursorHint(var1);
  } else {
    var12 setCursorHint("HINT_NOICON");
  }

  if(isDefined(var2)) {
    var12 sethinticon(var2);
  }

  if(isDefined(var3)) {
    var12 setHintString(var3);
  }

  if(isDefined(var4)) {
    var12 setusepriority(var4);
  } else {
    var12 setusepriority(0);
  }

  if(isDefined(var5)) {
    var12 setuseholdduration(var5);
  } else {
    var12 setuseholdduration("duration_short");
  }

  if(isDefined(var6)) {
    var12 sethintonobstruction(var6);
  } else {
    var12 sethintonobstruction("hide");
  }

  if(isDefined(var7)) {
    var12 sethintdisplayrange(var7);
  } else {
    var12 sethintdisplayrange(200);
  }

  if(isDefined(var8)) {
    var12 sethintdisplayfov(var8);
  } else {
    var12 sethintdisplayfov(160);
  }

  if(isDefined(var9)) {
    var12 setuserange(var9);
  } else {
    var12 setuserange(50);
  }

  if(isDefined(var10)) {
    var12 setusefov(var10);
  } else {
    var12 setusefov(120);
  }

  if(!isDefined(var11)) {
    return var12;
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
  var0 = scripts\engine\utility::getStructArray("airdropLocation_allies", "targetname");
  var1 = scripts\engine\utility::getStructArray("airdropLocation_axis", "targetname");
  var2 = scripts\engine\utility::array_combine(var0, var1);
  var3 = scripts\engine\utility::getclosest(level.lane_1_obj_struct.currentobjective.gameobject.origin, var2);
  var4 = scripts\engine\utility::getclosest(level.lane_2_obj_struct.currentobjective.gameobject.origin, var2);
  var5 = scripts\engine\utility::getclosest(level.lane_3_obj_struct.currentobjective.gameobject.origin, var2);
  level.armexfilcount = 3;
  return [var3, var4, var5];
}

function onexfilfinish(var0) {}

function onexfilkilled(var0) {
  level.armexfilcount--;

  if(level.armexfilcount == 0) {
    thread scripts\mp\gamelogic::endgame(var0, game["end_reason"]["target_destroyed"]);
    return;
  }
}

function sortlocationsbydistance(var0, var1) {
  return distancesquared(var0.origin, self.origin) < distancesquared(var1.origin, self.origin);
}

function calculatedroplocationnearlocation(var0, var1, var2) {
  var3 = var0.origin;
  var4 = undefined;
  var5 = undefined;
  var6 = randomint(2);
  var7 = scripts\engine\utility::ter_op(var6, -1, 1);

  if(var7 > 0) {
    var4 = randomfloatrange(var3[0] + var1 * var7, var3[0] + var2 * var7);

    if(var4 >= level.br_level.br_corners[0][0]) {
      var4 = level.br_level.br_corners[0][0] - 250;
    }
  } else {
    var4 = randomfloatrange(var3[0] + var2 * var7, var3[0] + var1 * var7);

    if(var4 <= level.br_level.br_corners[1][0]) {
      var4 = level.br_level.br_corners[1][0] + 250;
    }
  }

  var6 = randomint(2);
  var7 = scripts\engine\utility::ter_op(var6, -1, 1);

  if(var7 > 0) {
    var5 = randomfloatrange(var3[1] + var1 * var7, var3[1] + var2 * var7);

    if(var5 >= level.br_level.br_corners[0][1]) {
      var5 = level.br_level.br_corners[0][1] - 250;
    }
  } else {
    var5 = randomfloatrange(var3[1] + var2 * var7, var3[1] + var1 * var7);

    if(var5 >= level.br_level.br_corners[1][1]) {
      var5 = level.br_level.br_corners[1][1] + 250;
    }
  }

  var8 = spawnStruct();
  var8.origin = (var4, var5, var3[2]);
  return var8;
}

function debugsphereonlocation(var0, var1, var2) {}

function getmissedinfilcamerapositions(var0) {
  var1 = spawnStruct();
  var1.startorigin = undefined;
  var1.endpos = undefined;

  if(level.mapname == "mp_locale_test") {
    switch (level.localeid) {
      case "locale_8":
      case "locale_6":
        if(var0 == "axis") {
          var1.startorigin = (2094, -1804, 2763);
          var1.startangles = (54, 40, 0);
          var1.endorigin = (2094, -1804, 2763);
          var1.endangles = (54, 40, 0);
        } else {
          var1.startorigin = (2315, 1956, 2763);
          var1.startangles = (54, 296, 0);
          var1.endorigin = (2094, -1804, 2763);
          var1.endangles = (54, 40, 0);
        }

        break;
      default:
        var1.startorigin = (0, 0, 0);
        var1.startangles = (0, 0, 0);
        var1.endorigin = (0, 0, 0);
        var1.endangles = (0, 0, 0);
        break;
    }
  } else {
    switch (level.localeid) {
      case "locale_3":
        if(var0 == "axis") {
          var1.startorigin = (38864, -14018, -396);
          var1.startangles = (3, 250, 0);
          var1.endorigin = (38473, -14077, 401);
          var1.endangles = (15, 252, 0);
        } else {
          var1.startorigin = (30526, -38262, -483);
          var1.startangles = (0, 72, 0);
          var1.endorigin = (30024, -38403, 560);
          var1.endangles = (19, 67, 0);
        }

        break;
      case "locale_6":
        if(var0 == "axis") {
          var1.startorigin = (16977, -23256, 169);
          var1.startangles = (9, 69, 0);
          var1.endorigin = (16899, -23467, 683);
          var1.endangles = (15, 68, 0);
        } else {
          var1.startorigin = (18607, 1423, -355);
          var1.startangles = (8, 289, 0);
          var1.endorigin = (18100, 1083, 503);
          var1.endangles = (22, 302, 0);
        }

        break;
      case "locale_8":
        if(var0 == "axis") {
          var1.startorigin = (18672, -26836, -129);
          var1.startangles = (359, 76, 0);
          var1.endorigin = (18518, -26909, 314);
          var1.endangles = (14, 69, 0);
        } else {
          var1.startorigin = (18607, 1423, -355);
          var1.startangles = (8, 289, 0);
          var1.endorigin = (18100, 1083, 503);
          var1.endangles = (22, 302, 0);
        }

        break;
      case "locale_16":
      case "locale_5":
        if(var0 == "axis") {
          var1.startorigin = (24893, 28349, 1408);
          var1.startangles = (15, 54, 0);
          var1.endorigin = (25613, 29274, 1255);
          var1.endangles = (19, 53, 0);
        } else {
          var1.startorigin = (39490, 48919, 2302);
          var1.startangles = (17, 235, 0);
          var1.endorigin = (39254, 48584, 1542);
          var1.endangles = (18, 245, 0);
        }

        break;
      case "locale_9":
        if(var0 == "axis") {
          var1.startorigin = (48331, -24822, 514);
          var1.startangles = (12, 77, 0);
          var1.endorigin = (48424, -24421, -240);
          var1.endangles = (2, 77, 0);
        } else {
          var1.startorigin = (46188, 2520, 49);
          var1.startangles = (7, 295, 0);
          var1.endorigin = (46571, 2664, 526);
          var1.endangles = (16, 276, 0);
        }

        break;
      case "locale_10":
        if(var0 == "axis") {
          var1.startorigin = (-11083, 22197, 381);
          var1.startangles = (10, 181, 0);
          var1.endorigin = (-12112, 23761, 381);
          var1.endangles = (11, 201, 0);
        } else {
          var1.startorigin = (-31134, 11924, -116);
          var1.startangles = (0, 36, 0);
          var1.endorigin = (-31134, 11924, 434);
          var1.endangles = (11, 36, 0);
        }

        break;
      case "locale_17":
        if(var0 == "axis") {
          var1.startorigin = (9215, 984, 325);
          var1.startangles = (357, 186, 0);
          var1.endorigin = (9107, 628, 1144);
          var1.endangles = (19, 182, 0);
        } else {
          var1.startorigin = (-5351, 641, 408);
          var1.startangles = (2, 352, 0);
          var1.endorigin = (-5282, 996, 1103);
          var1.endangles = (11, 347, 0);
        }

        break;
      case "locale_18":
        if(var0 == "axis") {
          var1.startorigin = (-22847, -28632, 34);
          var1.startangles = (12, 42, 0);
          var1.endorigin = (-22694, -28429, 356);
          var1.endangles = (12, 40, 0);
        } else {
          var1.startorigin = (-8084, -20649, 72);
          var1.startangles = (10, 185, 0);
          var1.endorigin = (-9092, -20635, 224);
          var1.endangles = (12, 184, 0);
        }

        break;
      default:
        var1.startorigin = (0, 0, 0);
        var1.startangles = (0, 0, 0);
        var1.endorigin = (0, 0, 0);
        var1.endangles = (0, 0, 0);
        break;
    }
  }

  return var1;
}

function calculatehqmidpoint() {
  level.hqmidpoint = (level.gw_objstruct.axishqloc.trigger.origin + level.gw_objstruct.allieshqloc.trigger.origin) * 0.5;
  level.hqvecttomid_allies = level.gw_objstruct.axishqloc.trigger.origin - level.hqmidpoint;
  level.hqvecttomid_axis = level.gw_objstruct.allieshqloc.trigger.origin - level.hqmidpoint;
  level.hqdisttomid = length(level.hqvecttomid_axis);
}

function calculatecameraoffset(var0, var1) {
  switch (level.mapname) {
    case "mp_quarry2":
      var2 = 0.25;
      var3 = 0.35;
      break;
    case "mp_farms2":
      var2 = 0.25;
      var3 = 0.8;
      break;
    case "mp_aniyah":
      var2 = 0.5;
      var3 = 0.3;
      break;
    default:
      var2 = 0;
      var3 = 0;
      break;
  }

  var4 = distance(var3, level.hqmidpoint);

  if(var4 < 2048) {
    return (0, 0, 0);
  }

  if(var2 == "axis") {
    var5 = distance(level.gw_objstruct.axishqloc.trigger.origin, var3);
    var6 = level.hqvecttomid_axis;
  } else {
    var5 = distance(level.gw_objstruct.allieshqloc.trigger.origin, var3);
    var6 = level.hqvecttomid_allies;
  }

  if(var5 < 2048) {
    return (var6 * var4);
  }

  if(var5 > level.hqdisttomid) {
    if(var2 == "axis") {
      var5 = distance(level.gw_objstruct.allieshqloc.trigger.origin, var3);
    } else {
      var5 = distance(level.gw_objstruct.axishqloc.trigger.origin, var3);
    }

    var7 = 100 - var5 * 100 / level.hqdisttomid;
    var8 = var6 * var5 * -1 * var7 / 100;
    return var8;
  }

  var7 = 100 - var7 * 100 / level.hqdisttomid;
  var8 = var8 * var6 * var7 / 100;
  return var8;
}

function ref_1368d() {
  if(isDefined(self.selectedspawnarea) && issubstr(self.selectedspawnarea, "HQ")) {
    return true;
  }

  return false;
}