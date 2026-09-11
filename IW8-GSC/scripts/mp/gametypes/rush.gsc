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

  foreach(var1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var1, &"OBJECTIVES/RUSH");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var1, &"OBJECTIVES/RUSH");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var1, &"OBJECTIVES/RUSH_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var1, &"OBJECTIVES/RUSH_HINT");
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
  var0 = getEntArray("rush_flag", "targetname");
  var1 = getEntArray("rush_flag_override", "targetname");

  if(var0.size == 0) {
    return;
  }

  var2 = [];

  for(var3 = 0; var3 < var0.size; var3++) {
    var2 = var0[var3];
  }

  var4 = [];

  if(var1.size > 0) {
    foreach(var6 in var1) {
      var7 = var6.script_noteworthy;
      var4 = var6;
    }
  }

  foreach(var6 in var2) {
    var7 = var6.script_noteworthy;

    if(var7 == "0" || var7 == "4") {
      continue;
    }

    if(isDefined(var4[var7])) {
      var6 = var4[var7];
    }

    var6.objectivekey = var7;
    mapobjectiveicon(var6, var7);
    var10 = scripts\mp\gametypes\obj_dom::setupobjective(var6);
    dompoint_ondisableobjective(var10);
    level.objectives[var10.objectivekey] = var10;
    var10.onbeginuse = &dompoint_onbeginuse;
    var10.onuseupdate = &dompoint_onuseupdate;
    var10.onuse = &dompoint_onuse;
    var10.onenduse = &dompoint_onenduse;
    var10.oncontested = &dompoint_oncontested;
    var10.onuncontested = &dompoint_onuncontested;
    var10.ondisableobjective = &dompoint_ondisableobjective;
    var10.onenableobjective = &dompoint_onenableobjective;
    var10.onactivateobjective = &dompoint_onactivateobjective;
    var10 thread scripts\mp\gametypes\obj_dom::updateflagstate("off", 0);
    var10.defaultownerteam = game["defenders"];
    var10.overrideprogressteam = game["attackers"];
    var10.ignorestomp = 1;
    var10.decaygraceperiod = 5;
    var10.permcapturethresholds = [0.33, 0.66];
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

function updatecurrentobjective(var0) {
  if(!isDefined(level.objectives[scripts\engine\utility::string(var0)])) {
    return;
  }

  if(isDefined(level.currentobjective) && isDefined(level.currentobjective.ondisableobjective)) {
    level.currentobjective[[level.currentobjective.ondisableobjective]]();
  }

  level.currentobjectiveindex = var0;
  level.currentobjective = level.objectives[scripts\engine\utility::string(var0)];
  updatespectatorcamera("rush_" + level.currentobjectiveindex);

  if(isDefined(level.currentobjective.onenableobjective)) {
    level.currentobjective[[level.currentobjective.onenableobjective]]();
  }

  if(level.activationdelay > 0) {
    level scripts\mp\gamelogic::pausetimer();
    var1 = int(gettime() + level.activationdelay * 1000);
    setomnvar("ui_hardpoint_timer", var1);
    wait level.activationdelay;
    level scripts\mp\gamelogic::resumetimer();
  }

  if(isDefined(level.currentobjective.onactivateobjective)) {
    level.currentobjective[[level.currentobjective.onactivateobjective]]();
  }

  var2 = 0;

  switch (var0) {
    case 1:
      var2 = 10;
      break;
    case 2:
      var2 = 10;
      break;
    case 3:
      var2 = 10;
      break;
  }

  scripts\mp\gamelogic::updatewavespawndelay(var2);
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

  foreach(var1 in level.objectives) {
    var1.spawnpoints = [];
    var1.spawnpoints["allies"] = [];
    var1.spawnpoints["axis"] = [];
  }

  foreach(var4 in level.spawnpoints) {
    if(isDefined(var4.script_noteworthy)) {
      var5 = var4.script_noteworthy;

      if(var5 == "0" || var5 == "4") {
        continue;
      }

      if(var4.classname == "mp_rush_spawn_allies") {
        level.objectives[var5].spawnpoints["allies"][level.objectives[var5].spawnpoints["allies"].size] = var4;
        continue;
      }

      if(var4.classname == "mp_rush_spawn_axis") {
        level.objectives[var5].spawnpoints["axis"][level.objectives[var5].spawnpoints["axis"].size] = var4;
      }
    }
  }

  foreach(var1 in level.objectives) {
    var1.spawnpointsets = [];
    var1.spawnpointsets["allies"] = "rush_allies_" + var8;
    var1.spawnpointsets["axis"] = "rush_axis_" + var8;
    scripts\mp\spawnlogic::registerspawnset(var1.spawnpointsets["allies"], var1.spawnpoints["allies"]);
    scripts\mp\spawnlogic::registerspawnset(var1.spawnpointsets["axis"], var1.spawnpoints["axis"]);
  }
}

function getspawnpoint() {
  var0 = self.pers["team"];

  if(game["switchedsides"]) {
    var0 = scripts\mp\utility\game::getotherteam(var0)[0];
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_rush_spawn_" + var0 + "_start");
    var2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var1);
    self.startspawnpoint = var2;
  } else {
    var2 = scripts\mp\spawnlogic::getspawnpoint(self, var2, level.currentobjective.spawnpointsets[var2]);
  }

  return var2;
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

function mapobjectiveicon(var0) {
  self.iconname = "";
}

function disabledomflagscriptable() {
  thread scripts\mp\gametypes\obj_dom::updateflagstate("off", 0);
}

function awardcapturepoints() {
  level endon("game_ended");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");
  var0 = 1;
  var1 = 1;

  while(!level.gameended) {
    for(var2 = 0; var2 < var0; var2 = 0) {
      waitframe();
      scripts\mp\hostmigration::waittillhostmigrationdone();
      var2 += level.framedurationseconds;

      if(self.stalemate) {}
    }

    var3 = self.claimteam;

    if(var3 == "none") {
      continue;
    }

    if(!self.stalemate) {
      foreach(var5 in self.touchlist[var3]) {
        var5.player thread scripts\mp\utility\points::giveunifiedpoints("cop_in_obj");
      }
    }
  }
}

function dompoint_onbeginuse(var0) {
  scripts\mp\gametypes\obj_dom::dompoint_onusebegin(var0);
  self.didstatusnotify = 1;
}

function dompoint_onuseupdate(var0, var1, var2, var3) {
  scripts\mp\gametypes\obj_dom::dompoint_onuseupdate(var0, var1, var2, var3);

  if(scripts\mp\utility\game::inovertime()) {
    var4 = self.teamprogress[game["attackers"]] / self.usetime;

    if(var4 > game["overtimeProgressFrac"]) {
      game["overtimeProgressFrac"] = var4;
    }

    var5 = game["overtimeProgress"] + game["overtimeProgressFrac"];

    if(game["overtimeRoundsPlayed"] == 1 && scripts\mp\utility\game::setscoretobeat(var0, var5 * 60) == var0) {
      thread scripts\mp\gamelogic::endgame(var0, game["end_reason"]["objective_completed"]);
      return;
    }

    return;
  }
}

function dompoint_onuse(var0) {
  scripts\mp\gametypes\obj_dom::dompoint_onuse(var0);
  var1 = scripts\mp\gameobjects::getownerteam();
  level.usestartspawns = 0;
  var2 = scripts\mp\utility\game::getotherteam(var1)[0];
  thread scripts\mp\utility\print::printandsoundoneveryone(var1, var2, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", var0);
  scripts\mp\gamescore::giveteamscoreforobjective(var1, 1, 0);
  var3 = level.currentobjectiveindex;
  var3++;

  if(var3 == 4) {
    var4 = scripts\mp\gamelogic::gettimeremaining();
    var4 /= 60000;
    game["overtimeLimit"][var1] = max(1, var4);

    if(scripts\mp\utility\game::inovertime()) {
      var5 = scripts\mp\utility\game::setscoretobeat(var1, 180);
      thread scripts\mp\gamelogic::endgame(var5, game["end_reason"]["objective_completed"]);
      return;
    }

    thread scripts\mp\gamelogic::endgame(var1, game["end_reason"]["objective_completed"]);
    return;
  }

  if(level.extratimebonus > 0) {
    level.extratime = level.currentobjectiveindex * level.extratimebonus;
    var4 = scripts\mp\gamelogic::gettimeremaining();
    setgameendtime(gettime() + int(var4));
  }

  if(scripts\mp\utility\game::inovertime()) {
    game["overtimeProgress"]++;
    game["overtimeProgressFrac"] = 0;
  }

  updatecurrentobjective(var3);
}

function dompoint_onenduse(var0, var1, var2) {
  if(self != level.currentobjective) {
    return;
  }

  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var0, var1, var2);
}

function dompoint_oncontested() {
  if(self != level.currentobjective) {
    return;
  }

  scripts\mp\gametypes\obj_dom::dompoint_oncontested();
}

function dompoint_onuncontested(var0) {
  if(self != level.currentobjective) {
    return;
  }

  scripts\mp\gametypes\obj_dom::dompoint_onuncontested(var0);
  self.didstatusnotify = 1;
  var1 = scripts\mp\gameobjects::getownerteam();
  var2 = scripts\engine\utility::ter_op(var1 == "neutral", "idle", var1);
  var1 = scripts\mp\gameobjects::getownerteam();
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

function startspectatorview() {
  waitframe();
  scripts\mp\utility\player::updatesessionstate("spectator");
  scripts\mp\spectating::setdisabled();

  if(isDefined(self.lastdeathangles)) {
    self setplayerangles(self.lastdeathangles);
  }

  wait 0.1;
  scripts\mp\utility\player::setdof_default();
  var0 = level.spectatorcameras[level.currentspectatorcamref][self.team];
  var1 = var0.origin;
  var2 = var0.angles;
  self.deathspectatepos = var1;
  self.deathspectateangles = var2;
  var3 = spawn("script_model", self getvieworigin());
  var3 setModel("tag_origin");
  var3.angles = var2;
  self.spectatorcament = var3;
  self.isusingtacopsmapcamera = 1;
  self cameralinkTo(var3, "tag_origin", 1);
  thread dohalfwayflash();
  movecameratomappos(var3, self, var1, var2);
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

function updatespectatorcamera(var0) {
  level.currentspectatorcamref = var0;

  foreach(var2 in level.players) {
    if(isDefined(var2.spectatorcament)) {
      var3 = var2.team;
      var4 = getdvarint("scr_cmd_camera_team", -1);

      if(var4 != -1) {
        var3 = scripts\engine\utility::ter_op(var4 == 0, "allies", "axis");
      }

      var5 = level.spectatorcameras[level.currentspectatorcamref][var3];
      movecameratomappos(var2.spectatorcament, var2, var5.origin, var5.angles);
    }
  }
}

function movecameratomappos(var0, var1, var2) {
  var0 endon("spawned_player");
  var3 = 1;
  var4 = 1;
  self moveTo(var1, 1, 0.5, 0.5);
  var0 playlocalsound("mp_cmd_camera_zoom_out");
  var0 setclienttriggeraudiozonepartialwithfade("spawn_cam", 0.5, "mix");
  self rotateTo(var2, 1, 0.5, 0.5);
  thread startoperatorsound();
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
  var0 = 1;

  for(;;) {
    if(getdvarint("scr_cmd_camera_debug", 0) == 1) {
      if(isalive(level.players[0])) {
        level.players[0] suicide();
      }

      var1 = getdvarint("scr_cmd_camera_index", -1);

      if(var1 != -1) {
        var0 = var1;
      }

      updatespectatorcamera("rush_" + var0);
      var2 = getdvarfloat("scr_cmd_camera_delay", 1);
      wait var2;
      var0++;

      if(var0 > 3) {
        var0 = 1;
      }

      if(getdvarint("scr_cmd_camera_debug", 0) == 0) {
        level.players[0] notify("force_spawn");
      }

      continue;
    }

    waitframe();
  }
}