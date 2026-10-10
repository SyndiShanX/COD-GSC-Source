/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\rush.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\spawnlogic;
#using scripts\mp\spectating;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#namespace rush;

function main() {
  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  allowed[0] = getgametype();
  scripts\mp\gameobjects::main(allowed);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread reinitializematchrulesonmigration();
  } else {
    registertimelimitdvar(getgametype(), 300);
    registerscorelimitdvar(getgametype(), 3);
    registerroundlimitdvar(getgametype(), 2);
    registerroundswitchdvar(getgametype(), 1, 0, 1);
    registerwinlimitdvar(getgametype(), 0);
    registernumlivesdvar(getgametype(), 0);
    registerhalftimedvar(getgametype(), 0);
  }

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = &onstartgametype;
  level.getspawnpoint = &getspawnpoint;
  level.onplayerkilled = &onplayerkilled;
  level.lastcaptime = gettime();
  level.capturedecay = 1;
  game["dialog"]["gametype"] = "gametype_domination";

  if(getdvarint(@ "hash_4a2b3d01a81655a6")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint(hashcat(@ "scr_", getgametype(), "_promode"))) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["dialog"]["offense_obj"] = "capture_objs";
  game["dialog"]["defense_obj"] = "capture_objs";
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  setdynamicdvar(@ "hash_b053776a66d3006d", getmatchrulesdata("rushData", "activationDelay"));
  setdynamicdvar(@ "hash_4985dda611d2a008", getmatchrulesdata("rushData", "captureDuration"));
  setdynamicdvar(@ "hash_8b83e0f6e757f0c0", getmatchrulesdata("rushData", "extraTimeBonus"));
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

  foreach(entry in level.teamnamelist) {
    setobjectivetext(entry, &"OBJECTIVES/RUSH");

    if(level.splitscreen) {
      setobjectivescoretext(entry, &"OBJECTIVES/RUSH");
    } else {
      setobjectivescoretext(entry, &"OBJECTIVES/RUSH_SCORE");
    }

    setobjectivehinttext(entry, &"OBJECTIVES/RUSH_HINT");
  }

  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(inovertime()) {
    game["overtimeProgress"] = 0;
    game["overtimeProgressFrac"] = 0;
    game["attackers"] = ter_op(game["overtimeRoundsPlayed"] == 0, "axis", "allies");
    game["defenders"] = ter_op(game["overtimeRoundsPlayed"] == 0, "allies", "axis");

    if(!isDefined(game["overtimeLimit"]) || !isDefined(game["overtimeLimit"][game["attackers"]])) {
      game["overtimeLimit"][game["attackers"]] = 1;
    }

    setovertimelimitdvar(game["overtimeLimit"][game["attackers"]]);
  } else {
    game["attackers"] = ter_op(!istrue(game["switchedsides"]), "axis", "allies");
    game["defenders"] = ter_op(!istrue(game["switchedsides"]), "allies", "axis");
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
  level.activationdelay = dvarfloatvalue("activationDelay", 30, 0, 60);
  level.captureduration = dvarfloatvalue("captureDuration", 40, 0, 60);
  level.extratimebonus = dvarfloatvalue("extraTimeBonus", 60, 0, 300);
}

function setupobjectives() {
  primaryflags = getEntArray("rush_flag", "targetname");
  flagoverrides = getEntArray("rush_flag_override", "targetname");

  if(primaryflags.size == 0) {
    return;
  }

  triggers = [];

  for(index = 0; index < primaryflags.size; index++) {
    triggers[triggers.size] = primaryflags[index];
  }

  triggeroverrides = [];

  if(flagoverrides.size > 0) {
    foreach(trigger in flagoverrides) {
      assert(isDefined(trigger.script_noteworthy));
      objectiveindex = trigger.script_noteworthy;
      triggeroverrides[objectiveindex] = trigger;
    }
  }

  foreach(trigger in triggers) {
    assert(isDefined(trigger.script_noteworthy));
    objectiveindex = trigger.script_noteworthy;

    if(objectiveindex == "0" || objectiveindex == "4") {
      continue;
    }

    if(isDefined(triggeroverrides[objectiveindex])) {
      trigger = triggeroverrides[objectiveindex];
    }

    trigger.objectivekey = objectiveindex;
    trigger mapobjectiveicon(objectiveindex);
    domflag = scripts\mp\gametypes\obj_dom::setupobjective(trigger);
    domflag dompoint_ondisableobjective();
    level.objectives[domflag.objectivekey] = domflag;
    domflag.onbeginuse = &dompoint_onbeginuse;
    domflag.onuseupdate = &dompoint_onuseupdate;
    domflag.onuse = &dompoint_onuse;
    domflag.onenduse = &dompoint_onenduse;
    domflag.oncontested = &dompoint_oncontested;
    domflag.onuncontested = &dompoint_onuncontested;
    domflag.ondisableobjective = &dompoint_ondisableobjective;
    domflag.onenableobjective = &dompoint_onenableobjective;
    domflag.onactivateobjective = &dompoint_onactivateobjective;
    domflag thread scripts\mp\gametypes\obj_dom::updateflagstate("off", 0);
    domflag.defaultownerteam = game["defenders"];
    domflag.overrideprogressteam = game["attackers"];
    domflag.ignorestomp = 1;
    domflag.decaygraceperiod = 5;
    domflag.permcapturethresholds = [0.33, 0.66];
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
  while(true) {
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

function updatecurrentobjective(newindex) {
  if(!isDefined(level.objectives[string(newindex)])) {
    return;
  }

  if(isDefined(level.currentobjective) && isDefined(level.currentobjective.ondisableobjective)) {
    level.currentobjective[[level.currentobjective.ondisableobjective]]();
  }

  level.currentobjectiveindex = newindex;
  level.currentobjective = level.objectives[string(newindex)];
  updatespectatorcamera("rush_" + level.currentobjectiveindex);

  if(isDefined(level.currentobjective.onenableobjective)) {
    level.currentobjective[[level.currentobjective.onenableobjective]]();
  }

  if(level.activationdelay > 0) {
    level scripts\mp\gamelogic::pausetimer();
    zonedelaytime = int(gettime() + level.activationdelay * 1000);
    setomnvar("ui_hardpoint_timer", zonedelaytime);
    wait level.activationdelay;
    level scripts\mp\gamelogic::resumetimer();
  }

  if(isDefined(level.currentobjective.onactivateobjective)) {
    level.currentobjective[[level.currentobjective.onactivateobjective]]();
  }

  spawndelay = 0;

  switch (newindex) {
    case 1:
      spawndelay = 10;
      break;
    case 2:
      spawndelay = 10;
      break;
    case 3:
      spawndelay = 10;
      break;
  }

  scripts\mp\gamelogic::updatewavespawndelay(spawndelay);
}

function initspawns() {
  level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
  level.spawnmaxs = (-2147483647, -2147483647, -2147483647);

  if(function_bff229a11ecd1e34()) {
    scripts\mp\spawnlogic::setactivespawnlogic(#"default");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  }

  scripts\mp\spawnlogic::addstartspawnpoints("mp_rush_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_rush_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_rush_spawn_allies", 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_rush_spawn_axis", 1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);

  foreach(objective in level.objectives) {
    objective.spawnpoints = [];
    objective.spawnpoints["allies"] = [];
    objective.spawnpoints["axis"] = [];
  }

  foreach(spawnpoint in level.spawnpoints) {
    if(isDefined(spawnpoint.script_noteworthy)) {
      index = spawnpoint.script_noteworthy;

      if(index == "0" || index == "4") {
        continue;
      }

      if(spawnpoint.classname == "mp_rush_spawn_allies") {
        level.objectives[index].spawnpoints["allies"][level.objectives[index].spawnpoints["allies"].size] = spawnpoint;
        continue;
      }

      if(spawnpoint.classname == "mp_rush_spawn_axis") {
        level.objectives[index].spawnpoints["axis"][level.objectives[index].spawnpoints["axis"].size] = spawnpoint;
      }
    }
  }

  foreach(objid, objective in level.objectives) {
    objective.spawnpointsets = [];
    objective.spawnpointsets["allies"] = "rush_allies_" + objid;
    objective.spawnpointsets["axis"] = "rush_axis_" + objid;
    scripts\mp\spawnlogic::registerspawnset(objective.spawnpointsets["allies"], objective.spawnpoints["allies"]);
    scripts\mp\spawnlogic::registerspawnset(objective.spawnpointsets["axis"], objective.spawnpoints["axis"]);
  }
}

function getspawnpoint() {
  spawnteam = self.pers["team"];

  if(game["switchedsides"]) {
    spawnteam = getotherteam(spawnteam)[0];
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_rush_spawn_" + spawnteam + "_start");
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints);
    self.startspawnpoint = spawnpoint;
  } else {
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, level.currentobjective.spawnpointsets[spawnteam]);
  }

  return spawnpoint;
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  if(!isPlayer(attacker) || attacker.team == self.team) {
    return;
  }

  if(isDefined(objweapon) && scripts\cp_mp\weapon::iskillstreakweapon(objweapon.basename)) {
    return;
  }

  scripts\mp\gametypes\obj_dom::awardgenericmedals(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid);
}

function onplayerconnect(player) {
  player thread onplayerspawned();
}

function onplayerspawned(player) {
  self endon("disconnect");

  while(true) {
    self waittill("spawned");
    setextrascore0(0);

    if(isDefined(self.pers["captures"])) {
      setextrascore0(self.pers["captures"]);
    }

    setextrascore1(0);

    if(isDefined(self.pers["defends"])) {
      setextrascore1(self.pers["defends"]);
    }
  }
}

function mapobjectiveicon(index) {
  self.iconname = "";
}

function disabledomflagscriptable() {
  thread scripts\mp\gametypes\obj_dom::updateflagstate("off", 0);
}

function awardcapturepoints() {
  level endon("game_ended");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");
  seconds = 1;
  score = 1;

  while(!level.gameended) {
    for(waittime = 0; waittime < seconds; waittime = 0) {
      waitframe();
      scripts\mp\hostmigration::waittillhostmigrationdone();
      waittime += level.framedurationseconds;

      if(self.stalemate) {}
    }

    team = self.claimteam;

    if(team == "none") {
      continue;
    }

    if(!self.stalemate) {
      foreach(object in self.touchlist[team]) {
        object.player thread doscoreevent(#"hash_b70d7c404342b807");
      }
    }
  }
}

function dompoint_onbeginuse(player) {
  scripts\mp\gametypes\obj_dom::dompoint_onusebegin(player);
  self.didstatusnotify = 1;
}

function dompoint_onuseupdate(team, progress, change, capplayer) {
  scripts\mp\gametypes\obj_dom::dompoint_onuseupdate(team, progress, change, capplayer);

  if(inovertime()) {
    current = self.teamprogress[game["attackers"]] / self.usetime;

    if(current > game["overtimeProgressFrac"]) {
      game["overtimeProgressFrac"] = current;
    }

    score = game["overtimeProgress"] + game["overtimeProgressFrac"];

    if(game["overtimeRoundsPlayed"] == 1 && setscoretobeat(team, score * 60) == team) {
      thread scripts\mp\gamelogic::endgame(team, game["end_reason"]["objective_completed"]);
    }
  }
}

function dompoint_onuse(credit_player) {
  scripts\mp\gametypes\obj_dom::dompoint_onuse(credit_player);
  team = scripts\mp\gameobjects::getownerteam();
  level.usestartspawns = 0;
  assert(team != "<dev string:x1c>");
  otherteam = getotherteam(team)[0];
  thread printandsoundoneveryone(team, otherteam, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", credit_player);
  scripts\mp\gamescore::giveteamscoreforobjective(team, 1, 0);
  newindex = level.currentobjectiveindex;
  newindex++;

  if(newindex == 4) {
    timeleft = scripts\mp\gamelogic::gettimeremaining();
    timeleft /= 60000;
    game["overtimeLimit"][team] = max(1, timeleft);

    if(inovertime()) {
      winner = setscoretobeat(team, 180);
      thread scripts\mp\gamelogic::endgame(winner, game["end_reason"]["objective_completed"]);
    } else {
      thread scripts\mp\gamelogic::endgame(team, game["end_reason"]["objective_completed"]);
    }

    return;
  }

  if(level.extratimebonus > 0) {
    level.extratime = level.currentobjectiveindex * level.extratimebonus;
    timeleft = scripts\mp\gamelogic::gettimeremaining();
    setgameendtime(gettime() + int(timeleft));
  }

  if(inovertime()) {
    game["overtimeProgress"]++;
    game["overtimeProgressFrac"] = 0;
  }

  updatecurrentobjective(newindex);
}

function dompoint_onenduse(team, player, success) {
  if(self != level.currentobjective) {
    return;
  }

  scripts\mp\gametypes\obj_dom::dompoint_onuseend(team, player, success);
}

function dompoint_oncontested() {
  if(self != level.currentobjective) {
    return;
  }

  scripts\mp\gametypes\obj_dom::dompoint_oncontested();
}

function dompoint_onuncontested(lastclaimteam) {
  if(self != level.currentobjective) {
    return;
  }

  scripts\mp\gametypes\obj_dom::dompoint_onuncontested(lastclaimteam);
  self.didstatusnotify = 1;
  ownerteam = scripts\mp\gameobjects::getownerteam();
  state = ter_op(ownerteam == "neutral", "idle", ownerteam);
  ownerteam = scripts\mp\gameobjects::getownerteam();
}

function dompoint_ondisableobjective() {
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::disableobject();
  scripts\mp\gameobjects::resetcaptureprogress();
  scripts\mp\gameobjects::releaseid();
  self notify("useObjectDecay");
  delaythread(0.1, &disabledomflagscriptable);
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
  playsoundonplayers("mp_combat_outpost_activateobj");
  scripts\mp\gameobjects::allowuse("enemy");
  thread awardcapturepoints();
  level.flagcapturetime = level.captureduration;
  scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

function initspecatatorcameras() {
  level.spectatorcameras = [];
  level.currentspectatorcamref = "rush_1";
  var_84286554864313cb = getStructArray("tac_ops_map_config", "targetname");

  foreach(var_48380029fbb1007a in var_84286554864313cb) {
    var_ca2c833762e5466c = var_48380029fbb1007a.script_noteworthy;
    childstructs = getStructArray(var_48380029fbb1007a.target, "targetname");

    foreach(childstruct in childstructs) {
      switch (childstruct.script_label) {
        case #"hash_11e1630c6c429f23":
          setteammapposition(var_ca2c833762e5466c, "allies", childstruct);
          break;
        case #"hash_e66f1db565904926":
          setteammapposition(var_ca2c833762e5466c, "axis", childstruct);
          break;
      }
    }
  }
}

function setteammapposition(var_ca2c833762e5466c, team, posinfo) {
  if(!isDefined(level.spectatorcameras[var_ca2c833762e5466c])) {
    level.spectatorcameras[var_ca2c833762e5466c] = [];
  }

  level.spectatorcameras[var_ca2c833762e5466c][team] = posinfo;
}

function startspectatorview() {
  waitframe();
  updatesessionstate("spectator");
  scripts\mp\spectating::setdisabled();

  if(isDefined(self.lastdeathangles)) {
    self setplayerangles(self.lastdeathangles);
  }

  wait 0.1;
  setdof_default();
  var_25ac223966c5537 = level.spectatorcameras[level.currentspectatorcamref][self.team];
  var_dead2082432cecc = var_25ac223966c5537.origin;
  var_6788dc28320974a = var_25ac223966c5537.angles;
  self.deathspectatepos = var_dead2082432cecc;
  self.deathspectateangles = var_6788dc28320974a;
  cameraent = spawn("script_model", self getvieworigin());
  cameraent setModel("tag_origin");
  cameraent.angles = var_6788dc28320974a;
  self.spectatorcament = cameraent;
  self.isusingtacopsmapcamera = 1;
  self cameralinkTo(cameraent, "tag_origin", 1);
  thread dohalfwayflash();
  cameraent movecameratomappos(self, var_dead2082432cecc, var_6788dc28320974a);
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

function updatespectatorcamera(var_ca2c833762e5466c) {
  level.currentspectatorcamref = var_ca2c833762e5466c;

  foreach(player in level.players) {
    if(isDefined(player.spectatorcament)) {
      team = player.team;
      forcedteam = getdvarint(@ "hash_8bfd75900211e88b", -1);

      if(forcedteam != -1) {
        team = ter_op(forcedteam == 0, "allies", "axis");
      }

      cament = level.spectatorcameras[level.currentspectatorcamref][team];
      player.spectatorcament movecameratomappos(player, cament.origin, cament.angles);
    }
  }
}

function movecameratomappos(player, var_9813182985677b23, finalangles) {
  player endon("spawned_player");
  movetime = 1;
  rotatetime = 1;
  self moveTo(var_9813182985677b23, 1, 0.5, 0.5);
  player playlocalsound("mp_cmd_camera_zoom_out");
  player setclienttriggeraudiozonepartialwithfade("spawn_cam", 0.5, "mix");
  self rotateTo(finalangles, 1, 0.5, 0.5);
  player thread startoperatorsound();
  wait 1.1;
  var_ae753108f3dff053 = anglesToForward(finalangles) * 300;
  var_ae753108f3dff053 *= (1, 1, 0);

  if(isDefined(player) && isDefined(player.spectatorcament)) {
    self moveTo(var_9813182985677b23 + var_ae753108f3dff053, 15, 1, 1);
    player earthquakeforplayer(0.03, 15, var_9813182985677b23 + var_ae753108f3dff053, 1000);
  }
}

function runslamzoomonspawn() {
  self waittill("spawned_player");
  targetpos = self getEye();
  targetangles = self.angles;
  updatesessionstate("spectator");
  self cameralinkTo(self.spectatorcament, "tag_origin", 1);
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.2);
  self.spectatorcament moveTo(targetpos, 0.5);
  self playlocalsound("mp_cmd_camera_zoom_in");
  self clearclienttriggeraudiozone(0.5);
  self.spectatorcament rotateTo(targetangles, 0.5, 0.5);
  wait 0.5;
  self visionsetnakedforplayer("", 0);
  thread playslamzoomflash();
  updatesessionstate("playing");
  self cameraunlink();
  self.spectatorcament delete();
}

function playslamzoomflash() {
  overlay = newclienthudelem(self);
  overlay.x = 0;
  overlay.y = 0;
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.sort = 1;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.alpha = 1;
  overlay.foreground = 1;
  overlay setshader("white", 640, 480);
  overlay fadeovertime(0.4);
  overlay.alpha = 0;
  wait 0.4;
  overlay destroy();
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
  index = 1;

  while(true) {
    if(getdvarint(@ "hash_4ac8d16ce8dd74fd", 0) == 1) {
      if(isalive(level.players[0])) {
        level.players[0] suicide();
      }

      overrideindex = getdvarint(@ "hash_885dea990259dafe", -1);

      if(overrideindex != -1) {
        index = overrideindex;
      }

      updatespectatorcamera("rush_" + index);
      duration = getdvarfloat(@ "hash_7d3ea16c514f408d", 1);
      wait duration;
      index++;

      if(index > 3) {
        index = 1;
      }

      if(getdvarint(@ "hash_4ac8d16ce8dd74fd", 0) == 0) {
        level.players[0] notify("force_spawn");
      }

      continue;
    }

    waitframe();
  }
}