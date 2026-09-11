/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rush.gsc
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
  setdynamicdvar("scr_rush_activationDelay", getmatchrulesdata("rushData", "activationDelay"));
  setdynamicdvar("scr_rush_captureDuration", getmatchrulesdata("rushData", "captureDuration"));
  setdynamicdvar("scr_rush_extraTimeBonus", getmatchrulesdata("rushData", "extraTimeBonus"));
}

function seticonnames() {
  level.iconcapture = "hq_destroy";
  level.iconcontested = "hq_contested";
  level.icondefend = "hq_defend";
  level.iconlosing = "hq_losing";
  level.iconneutral = "hq_neutral";
  level.icontaking = "hq_taking";
  level.icontarget = "hq_target";
}

function onstartgametype() {
  seticonnames();

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"OBJECTIVES/RUSH");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"OBJECTIVES/RUSH");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"OBJECTIVES/RUSH_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var_1, &"OBJECTIVES/RUSH_HINT");
  }

  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(scripts\mp\utility\game::inovertime()) {
    game["overtimeProgress"] = 0;
    game["overtimeProgressFrac"] = 0;
    game["attackers"] = scripts\engine\utility::ter_op(game["overtimeRoundsPlayed"] == 0, "axis", "allies");
    game["defenders"] = scripts\engine\utility::ter_op(game["overtimeRoundsPlayed"] == 0, "allies", "axis");

    if(!isDefined(game["overtimeLimit"]) || !isDefined(game["overtimeLimit"][game["attackers"]])) {
      game["overtimeLimit"][game["attackers"]] = 1;
    }

    scripts\mp\utility\game::setovertimelimitdvar(game["overtimeLimit"][game["attackers"]]);
  } else {
    game["attackers"] = scripts\engine\utility::ter_op(!istrue(game["switchedsides"]), "axis", "allies");
    game["defenders"] = scripts\engine\utility::ter_op(!istrue(game["switchedsides"]), "allies", "axis");
  }

  level scripts\mp\gamelogic::enableovertimegameplay();
  initspecatatorcameras();
  thread loopspectatorlocations();
  setupobjectives();
  initspawns();
  thread startgame();
  thread manageovertimestate();
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.activationdelay = scripts\mp\utility\dvars::dvarfloatvalue("activationDelay", 30, 0, 60);
  level.captureduration = scripts\mp\utility\dvars::dvarfloatvalue("captureDuration", 40, 0, 60);
  level.extratimebonus = scripts\mp\utility\dvars::dvarfloatvalue("extraTimeBonus", 60, 0, 300);
}

function setupobjectives() {
  var_0 = getEntArray("rush_flag", "targetname");
  var_1 = getEntArray("rush_flag_override", "targetname");

  if(var_0.size == 0) {
    return;
  }

  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_2 = var_0[var_3];
  }

  var_4 = [];

  if(var_1.size > 0) {
    foreach(var_6 in var_1) {
      var_7 = var_6.script_noteworthy;
      var_4 = var_6;
    }
  }

  foreach(var_6 in var_2) {
    var_7 = var_6.script_noteworthy;

    if(var_7 == "0" || var_7 == "4") {
      continue;
    }

    if(isDefined(var_4[var_7])) {
      var_6 = var_4[var_7];
    }

    var_6.objectivekey = var_7;
    mapobjectiveicon(var_6, var_7);
    var_10 = scripts\mp\gametypes\obj_dom::setupobjective(var_6);
    dompoint_ondisableobjective(var_10);
    level.objectives[var_10.objectivekey] = var_10;
    var_10.onbeginuse = &dompoint_onbeginuse;
    var_10.onuseupdate = &dompoint_onuseupdate;
    var_10.onuse = &dompoint_onuse;
    var_10.onenduse = &dompoint_onenduse;
    var_10.oncontested = &dompoint_oncontested;
    var_10.onuncontested = &dompoint_onuncontested;
    var_10.ondisableobjective = &dompoint_ondisableobjective;
    var_10.onenableobjective = &dompoint_onenableobjective;
    var_10.onactivateobjective = &dompoint_onactivateobjective;
    var_10 thread scripts\mp\gametypes\obj_dom::updateflagstate("off", 0);
    var_10.defaultownerteam = game["defenders"];
    var_10.overrideprogressteam = game["attackers"];
    var_10.ignorestomp = 1;
    var_10.decaygraceperiod = 5;
    var_10.permcapturethresholds = [0.33, 0.66];
  }
}

function startgame() {
  level endon("game_ended");
  setomnvar("ui_objective_timer_stopped", 1);
  setomnvar("ui_hardpoint_timer", 0);
  scripts\mp\flags::gameflagwait("prematch_done");
  setomnvar("ui_objective_timer_stopped", 0);
  level.currentobjectiveindex = 1;
  updatecurrentobjective(level.currentobjectiveindex);
}

function manageovertimestate() {
  for(;;) {
    waitframe();

    if(istrue(level.timerstoppedforgamemode)) {
      level.canprocessot = 0;
      continue;
    }

    if(isDefined(level.currentobjective)) {
      level.canprocessot = level.currentobjective.touchlist[game["attackers"]].size == 0;
    }
  }
}

function updatecurrentobjective(var_0) {
  if(!isDefined(level.objectives[scripts\engine\utility::string(var_0)])) {
    return;
  }

  if(isDefined(level.currentobjective) && isDefined(level.currentobjective.ondisableobjective)) {
    level.currentobjective[[level.currentobjective.ondisableobjective]]();
  }

  level.currentobjectiveindex = var_0;
  level.currentobjective = level.objectives[scripts\engine\utility::string(var_0)];
  updatespectatorcamera("rush_" + level.currentobjectiveindex);

  if(isDefined(level.currentobjective.onenableobjective)) {
    level.currentobjective[[level.currentobjective.onenableobjective]]();
  }

  if(level.activationdelay > 0) {
    level scripts\mp\gamelogic::pausetimer();
    var_1 = int(gettime() + level.activationdelay * 1000);
    setomnvar("ui_hardpoint_timer", var_1);
    wait level.activationdelay;
    level scripts\mp\gamelogic::resumetimer();
  }

  if(isDefined(level.currentobjective.onactivateobjective)) {
    level.currentobjective[[level.currentobjective.onactivateobjective]]();
  }

  var_2 = 0;

  switch (var_0) {
    case 1:
      var_2 = 10;
      break;
    case 2:
      var_2 = 10;
      break;
    case 3:
      var_2 = 10;
      break;
  }

  scripts\mp\gamelogic::updatewavespawndelay(var_2);
}

function initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_rush_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_rush_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_rush_spawn_allies", 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_rush_spawn_axis", 1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);

  foreach(var_1 in level.objectives) {
    var_1.spawnpoints = [];
    var_1.spawnpoints["allies"] = [];
    var_1.spawnpoints["axis"] = [];
  }

  foreach(var_4 in level.spawnpoints) {
    if(isDefined(var_4.script_noteworthy)) {
      var_5 = var_4.script_noteworthy;

      if(var_5 == "0" || var_5 == "4") {
        continue;
      }

      if(var_4.classname == "mp_rush_spawn_allies") {
        level.objectives[var_5].spawnpoints["allies"][level.objectives[var_5].spawnpoints["allies"].size] = var_4;
        continue;
      }

      if(var_4.classname == "mp_rush_spawn_axis") {
        level.objectives[var_5].spawnpoints["axis"][level.objectives[var_5].spawnpoints["axis"].size] = var_4;
      }
    }
  }

  foreach(var_1 in level.objectives) {
    var_1.spawnpointsets = [];
    var_1.spawnpointsets["allies"] = "rush_allies_" + var_8;
    var_1.spawnpointsets["axis"] = "rush_axis_" + var_8;
    scripts\mp\spawnlogic::registerspawnset(var_1.spawnpointsets["allies"], var_1.spawnpoints["allies"]);
    scripts\mp\spawnlogic::registerspawnset(var_1.spawnpointsets["axis"], var_1.spawnpoints["axis"]);
  }
}

function getspawnpoint() {
  var_0 = self.pers["team"];

  if(game["switchedsides"]) {
    var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_rush_spawn_" + var_0 + "_start");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
    self.startspawnpoint = var_2;
  } else {
    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, var_2, level.currentobjective.spawnpointsets[var_2]);
  }

  return var_2;
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

function mapobjectiveicon(var_0) {
  self.iconname = "";
}

function disabledomflagscriptable() {
  thread scripts\mp\gametypes\obj_dom::updateflagstate("off", 0);
}

function awardcapturepoints() {
  level endon("game_ended");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");
  var_0 = 1;
  var_1 = 1;

  while(!level.gameended) {
    for(var_2 = 0; var_2 < var_0; var_2 = 0) {
      waitframe();
      scripts\mp\hostmigration::waittillhostmigrationdone();
      var_2 += level.framedurationseconds;

      if(self.stalemate) {}
    }

    var_3 = self.claimteam;

    if(var_3 == "none") {
      continue;
    }

    if(!self.stalemate) {
      foreach(var_5 in self.touchlist[var_3]) {
        var_5.player thread scripts\mp\utility\points::giveunifiedpoints("cop_in_obj");
      }
    }
  }
}

function dompoint_onbeginuse(var_0) {
  scripts\mp\gametypes\obj_dom::dompoint_onusebegin(var_0);
  self.didstatusnotify = 1;
}

function dompoint_onuseupdate(var_0, var_1, var_2, var_3) {
  scripts\mp\gametypes\obj_dom::dompoint_onuseupdate(var_0, var_1, var_2, var_3);

  if(scripts\mp\utility\game::inovertime()) {
    var_4 = self.teamprogress[game["attackers"]] / self.usetime;

    if(var_4 > game["overtimeProgressFrac"]) {
      game["overtimeProgressFrac"] = var_4;
    }

    var_5 = game["overtimeProgress"] + game["overtimeProgressFrac"];

    if(game["overtimeRoundsPlayed"] == 1 && scripts\mp\utility\game::setscoretobeat(var_0, var_5 * 60) == var_0) {
      thread scripts\mp\gamelogic::endgame(var_0, game["end_reason"]["objective_completed"]);
      return;
    }

    return;
  }
}

function dompoint_onuse(var_0) {
  scripts\mp\gametypes\obj_dom::dompoint_onuse(var_0);
  var_1 = scripts\mp\gameobjects::getownerteam();
  level.usestartspawns = 0;
  var_2 = scripts\mp\utility\game::getotherteam(var_1)[0];
  thread scripts\mp\utility\print::printandsoundoneveryone(var_1, var_2, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", var_0);
  scripts\mp\gamescore::giveteamscoreforobjective(var_1, 1, 0);
  var_3 = level.currentobjectiveindex;
  var_3++;

  if(var_3 == 4) {
    var_4 = scripts\mp\gamelogic::gettimeremaining();
    var_4 /= 60000;
    game["overtimeLimit"][var_1] = max(1, var_4);

    if(scripts\mp\utility\game::inovertime()) {
      var_5 = scripts\mp\utility\game::setscoretobeat(var_1, 180);
      thread scripts\mp\gamelogic::endgame(var_5, game["end_reason"]["objective_completed"]);
      return;
    }

    thread scripts\mp\gamelogic::endgame(var_1, game["end_reason"]["objective_completed"]);
    return;
  }

  if(level.extratimebonus > 0) {
    level.extratime = level.currentobjectiveindex * level.extratimebonus;
    var_4 = scripts\mp\gamelogic::gettimeremaining();
    setgameendtime(gettime() + int(var_4));
  }

  if(scripts\mp\utility\game::inovertime()) {
    game["overtimeProgress"]++;
    game["overtimeProgressFrac"] = 0;
  }

  updatecurrentobjective(var_3);
}

function dompoint_onenduse(var_0, var_1, var_2) {
  if(self != level.currentobjective) {
    return;
  }

  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var_0, var_1, var_2);
}

function dompoint_oncontested() {
  if(self != level.currentobjective) {
    return;
  }

  scripts\mp\gametypes\obj_dom::dompoint_oncontested();
}

function dompoint_onuncontested(var_0) {
  if(self != level.currentobjective) {
    return;
  }

  scripts\mp\gametypes\obj_dom::dompoint_onuncontested(var_0);
  self.didstatusnotify = 1;
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = scripts\engine\utility::ter_op(var_1 == "neutral", "idle", var_1);
  var_1 = scripts\mp\gameobjects::getownerteam();
}

function dompoint_ondisableobjective() {
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::disableobject();
  scripts\mp\gameobjects::resetcaptureprogress();
  scripts\mp\gameobjects::releaseid();
  self notify("useObjectDecay");
  scripts\engine\utility::delaythread(0.1, &disabledomflagscriptable);
}

function dompoint_onenableobjective() {
  scripts\mp\gameobjects::requestid(1, 1);
  scripts\mp\gameobjects::enableobject();
  scripts\mp\gameobjects::setvisibleteam("any");
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);

  if(isDefined(self.defaultownerteam)) {
    scripts\mp\gameobjects::setownerteam(self.defaultownerteam);
    thread scripts\mp\gametypes\obj_dom::updateflagstate(self.defaultownerteam, 0);
    return;
  }

  scripts\mp\gameobjects::setownerteam("neutral");
  thread scripts\mp\gametypes\obj_dom::updateflagstate("idle", 0);
}

function dompoint_onactivateobjective() {
  scripts\mp\utility\sound::playsoundonplayers("mp_combat_outpost_activateobj");
  scripts\mp\gameobjects::allowuse("enemy");
  thread awardcapturepoints();
  level.flagcapturetime = level.captureduration;
  scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

function initspecatatorcameras() {
  level.spectatorcameras = [];
  level.currentspectatorcamref = "rush_1";
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

function startspectatorview() {
  waitframe();
  scripts\mp\utility\player::updatesessionstate("spectator");
  scripts\mp\spectating::setdisabled();

  if(isDefined(self.lastdeathangles)) {
    self setplayerangles(self.lastdeathangles);
  }

  wait 0.1;
  scripts\mp\utility\player::setdof_default();
  var_0 = level.spectatorcameras[level.currentspectatorcamref][self.team];
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  self.deathspectatepos = var_1;
  self.deathspectateangles = var_2;
  var_3 = spawn("script_model", self getvieworigin());
  var_3 setModel("tag_origin");
  var_3.angles = var_2;
  self.spectatorcament = var_3;
  self.isusingtacopsmapcamera = 1;
  self cameralinkTo(var_3, "tag_origin", 1);
  thread dohalfwayflash();
  movecameratomappos(var_3, self, var_1, var_2);
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

function updatespectatorcamera(var_0) {
  level.currentspectatorcamref = var_0;

  foreach(var_2 in level.players) {
    if(isDefined(var_2.spectatorcament)) {
      var_3 = var_2.team;
      var_4 = getdvarint("scr_cmd_camera_team", -1);

      if(var_4 != -1) {
        var_3 = scripts\engine\utility::ter_op(var_4 == 0, "allies", "axis");
      }

      var_5 = level.spectatorcameras[level.currentspectatorcamref][var_3];
      movecameratomappos(var_2.spectatorcament, var_2, var_5.origin, var_5.angles);
    }
  }
}

function movecameratomappos(var_0, var_1, var_2) {
  var_0 endon("spawned_player");
  var_3 = 1;
  var_4 = 1;
  self moveTo(var_1, 1, 0.5, 0.5);
  var_0 playlocalsound("mp_cmd_camera_zoom_out");
  var_0 setclienttriggeraudiozonepartialwithfade("spawn_cam", 0.5, "mix");
  self rotateTo(var_2, 1, 0.5, 0.5);
  thread startoperatorsound();
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

function startoperatorsound() {
  self endon("game_ended");
  self waittill("spawned_player");
  wait 0.5;
}

function applythermal() {
  self visionsetthermalforplayer("proto_apache_flir_mp");
  self thermalvisionon();
}

function removethermal() {
  self thermalvisionoff();
}

function loopspectatorlocations() {
  var_0 = 1;

  for(;;) {
    if(getdvarint("scr_cmd_camera_debug", 0) == 1) {
      if(isalive(level.players[0])) {
        level.players[0] suicide();
      }

      var_1 = getdvarint("scr_cmd_camera_index", -1);

      if(var_1 != -1) {
        var_0 = var_1;
      }

      updatespectatorcamera("rush_" + var_0);
      var_2 = getdvarfloat("scr_cmd_camera_delay", 1);
      wait var_2;
      var_0++;

      if(var_0 > 3) {
        var_0 = 1;
      }

      if(getdvarint("scr_cmd_camera_debug", 0) == 0) {
        level.players[0] notify("force_spawn");
      }

      continue;
    }

    waitframe();
  }
}