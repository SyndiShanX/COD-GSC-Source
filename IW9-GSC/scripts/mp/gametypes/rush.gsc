/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rush.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 3);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.lastcaptime = gettime();
  level.capturedecay = 1;
  game["dialog"]["gametype"] = "gametype_domination";

  if(getdvarint("scr_diehard"))
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  else if(getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_promode")))
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";

  game["dialog"]["offense_obj"] = "capture_objs";
  game["dialog"]["defense_obj"] = "capture_objs";
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("dvar_B053776A66D3006D", getmatchrulesdata("rushData", "activationDelay"));
  setdynamicdvar("dvar_4985DDA611D2A008", getmatchrulesdata("rushData", "captureDuration"));
  setdynamicdvar("dvar_8B83E0F6E757F0C0", getmatchrulesdata("rushData", "extraTimeBonus"));
}

seticonnames() {
  level.iconcapture = "hq_destroy";
  level.iconcontested = "hq_contested";
  level.icondefend = "hq_defend";
  level.iconlosing = "hq_losing";
  level.iconneutral = "hq_neutral";
  level.icontaking = "hq_taking";
  level.icontarget = "hq_target";
}

onstartgametype() {
  seticonnames();

  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/RUSH");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/RUSH");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/RUSH_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/RUSH_HINT");
  }

  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(scripts\mp\utility\game::inovertime()) {
    game["overtimeProgress"] = 0;
    game["overtimeProgressFrac"] = 0;
    game["attackers"] = scripts\engine\utility::ter_op(game["overtimeRoundsPlayed"] == 0, "axis", "allies");
    game["defenders"] = scripts\engine\utility::ter_op(game["overtimeRoundsPlayed"] == 0, "allies", "axis");

    if(!isDefined(game["overtimeLimit"]) || !isDefined(game["overtimeLimit"][game["attackers"]]))
      game["overtimeLimit"][game["attackers"]] = 1.0;

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

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.activationdelay = scripts\mp\utility\dvars::dvarfloatvalue("activationDelay", 30, 0, 60);
  level.captureduration = scripts\mp\utility\dvars::dvarfloatvalue("captureDuration", 40, 0, 60);
  level.extratimebonus = scripts\mp\utility\dvars::dvarfloatvalue("extraTimeBonus", 60, 0, 300);
}

setupobjectives() {
  primaryflags = getEntArray("rush_flag", "targetname");
  _id_A9232BFE0BB02C00 = getEntArray("rush_flag_override", "targetname");

  if(primaryflags.size == 0) {
    return;
  }
  triggers = [];

  for(index = 0; index < primaryflags.size; index++)
    triggers[triggers.size] = primaryflags[index];

  _id_1DC2B3DBB108241C = [];

  if(_id_A9232BFE0BB02C00.size > 0) {
    foreach(trigger in _id_A9232BFE0BB02C00) {
      objectiveindex = trigger.script_noteworthy;
      _id_1DC2B3DBB108241C[objectiveindex] = trigger;
    }
  }

  foreach(trigger in triggers) {
    objectiveindex = trigger.script_noteworthy;

    if(objectiveindex == "0" || objectiveindex == "4") {
      continue;
    }
    if(isDefined(_id_1DC2B3DBB108241C[objectiveindex]))
      trigger = _id_1DC2B3DBB108241C[objectiveindex];

    trigger.objectivekey = objectiveindex;
    trigger mapobjectiveicon(objectiveindex);
    domflag = _id_6663215F917210AE::setupobjective(trigger);
    domflag dompoint_ondisableobjective();
    level.objectives[domflag.objectivekey] = domflag;
    domflag.onbeginuse = ::dompoint_onbeginuse;
    domflag.onuseupdate = ::dompoint_onuseupdate;
    domflag.onuse = ::dompoint_onuse;
    domflag.onenduse = ::dompoint_onenduse;
    domflag.oncontested = ::dompoint_oncontested;
    domflag.onuncontested = ::dompoint_onuncontested;
    domflag.ondisableobjective = ::dompoint_ondisableobjective;
    domflag.onenableobjective = ::dompoint_onenableobjective;
    domflag.onactivateobjective = ::dompoint_onactivateobjective;
    domflag thread _id_6663215F917210AE::updateflagstate("off", 0);
    domflag.defaultownerteam = game["defenders"];
    domflag.overrideprogressteam = game["attackers"];
    domflag.ignorestomp = 1;
    domflag.decaygraceperiod = 5.0;
    domflag.permcapturethresholds = [0.33, 0.66];
  }
}

startgame() {
  level endon("game_ended");
  setomnvar("ui_objective_timer_stopped", 1);
  setomnvar("ui_hardpoint_timer", 0);
  scripts\mp\flags::gameflagwait("prematch_done");
  setomnvar("ui_objective_timer_stopped", 0);
  level.currentobjectiveindex = 1;
  updatecurrentobjective(level.currentobjectiveindex);
}

manageovertimestate() {
  for(;;) {
    waitframe();

    if(istrue(level.timerstoppedforgamemode)) {
      level.canprocessot = 0;
      continue;
    }

    if(isDefined(level.currentobjective))
      level.canprocessot = level.currentobjective.touchlist[game["attackers"]].size == 0;
  }
}

updatecurrentobjective(_id_DC6CBFDA5CAFD043) {
  if(!isDefined(level.objectives[scripts\engine\utility::string(_id_DC6CBFDA5CAFD043)])) {
    return;
  }
  if(isDefined(level.currentobjective) && isDefined(level.currentobjective.ondisableobjective))
    level.currentobjective[[level.currentobjective.ondisableobjective]]();

  level.currentobjectiveindex = _id_DC6CBFDA5CAFD043;
  level.currentobjective = level.objectives[scripts\engine\utility::string(_id_DC6CBFDA5CAFD043)];
  updatespectatorcamera("rush_" + level.currentobjectiveindex);

  if(isDefined(level.currentobjective.onenableobjective))
    level.currentobjective[[level.currentobjective.onenableobjective]]();

  if(level.activationdelay > 0) {
    level scripts\mp\gamelogic::pausetimer();
    _id_AC61FD4C042A7FDB = int(gettime() + level.activationdelay * 1000);
    setomnvar("ui_hardpoint_timer", _id_AC61FD4C042A7FDB);
    wait(level.activationdelay);
    level scripts\mp\gamelogic::resumetimer();
  }

  if(isDefined(level.currentobjective.onactivateobjective))
    level.currentobjective[[level.currentobjective.onactivateobjective]]();

  spawndelay = 0;

  switch (_id_DC6CBFDA5CAFD043) {
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

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
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

      if(spawnpoint.classname == "mp_rush_spawn_axis")
        level.objectives[index].spawnpoints["axis"][level.objectives[index].spawnpoints["axis"].size] = spawnpoint;
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

getspawnpoint() {
  spawnteam = self.pers["team"];

  if(game["switchedsides"])
    spawnteam = scripts\mp\utility\game::getotherteam(spawnteam)[0];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_rush_spawn_" + spawnteam + "_start");
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints);
    self.startspawnpoint = spawnpoint;
  } else
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, level.currentobjective.spawnpointsets[spawnteam]);

  return spawnpoint;
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  if(!isPlayer(attacker) || attacker.team == self.team) {
    return;
  }
  if(isDefined(objweapon) && _id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename)) {
    return;
  }
  _id_6663215F917210AE::awardgenericmedals(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00);
}

onplayerconnect(player) {
  player thread onplayerspawned();
}

onplayerspawned(player) {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned");
    scripts\mp\utility\stats::setextrascore0(0);

    if(isDefined(self.pers["captures"]))
      scripts\mp\utility\stats::setextrascore0(self.pers["captures"]);

    scripts\mp\utility\stats::setextrascore1(0);

    if(isDefined(self.pers["defends"]))
      scripts\mp\utility\stats::setextrascore1(self.pers["defends"]);
  }
}

mapobjectiveicon(index) {
  self.iconname = "";
}

disabledomflagscriptable() {
  thread _id_6663215F917210AE::updateflagstate("off", 0);
}

awardcapturepoints() {
  level endon("game_ended");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");
  _id_CC748B6D457627FE = 1;
  score = 1;

  while(!level.gameended) {
    waittime = 0.0;

    while(waittime < _id_CC748B6D457627FE) {
      waitframe();
      scripts\mp\hostmigration::waittillhostmigrationdone();
      waittime = waittime + level.framedurationseconds;

      if(self.stalemate)
        waittime = 0.0;
    }

    team = self.claimteam;

    if(team == "none") {
      continue;
    }
    if(!self.stalemate) {
      foreach(object in self.touchlist[team])
      object.player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_B70D7C404342B807");
    }
  }
}

dompoint_onbeginuse(player) {
  _id_6663215F917210AE::dompoint_onusebegin(player);
  self.didstatusnotify = 1;
}

dompoint_onuseupdate(team, progress, _id_301D62DA1A0738F1, _id_4B22E50E504339FE) {
  _id_6663215F917210AE::dompoint_onuseupdate(team, progress, _id_301D62DA1A0738F1, _id_4B22E50E504339FE);

  if(scripts\mp\utility\game::inovertime()) {
    current = self.teamprogress[game["attackers"]] / self.usetime;

    if(current > game["overtimeProgressFrac"])
      game["overtimeProgressFrac"] = current;

    score = game["overtimeProgress"] + game["overtimeProgressFrac"];

    if(game["overtimeRoundsPlayed"] == 1 && scripts\mp\utility\game::setscoretobeat(team, score * 60.0) == team)
      thread scripts\mp\gamelogic::endgame(team, game["end_reason"]["objective_completed"]);
  }
}

dompoint_onuse(_id_22282E7D48CA3400) {
  _id_6663215F917210AE::dompoint_onuse(_id_22282E7D48CA3400);
  team = scripts\mp\gameobjects::getownerteam();
  level.usestartspawns = 0;
  otherteam = scripts\mp\utility\game::getotherteam(team)[0];
  thread scripts\mp\utility\print::printandsoundoneveryone(team, otherteam, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", _id_22282E7D48CA3400);
  scripts\mp\gamescore::giveteamscoreforobjective(team, 1, 0);
  _id_DC6CBFDA5CAFD043 = level.currentobjectiveindex;
  _id_DC6CBFDA5CAFD043++;

  if(_id_DC6CBFDA5CAFD043 == 4) {
    _id_8DD9F2EB8215A139 = scripts\mp\gamelogic::gettimeremaining();
    _id_8DD9F2EB8215A139 = _id_8DD9F2EB8215A139 / 60000.0;
    game["overtimeLimit"][team] = max(1.0, _id_8DD9F2EB8215A139);

    if(scripts\mp\utility\game::inovertime()) {
      winner = scripts\mp\utility\game::setscoretobeat(team, 180.0);
      thread scripts\mp\gamelogic::endgame(winner, game["end_reason"]["objective_completed"]);
      return;
    }

    thread scripts\mp\gamelogic::endgame(team, game["end_reason"]["objective_completed"]);
    return;
  } else {
    if(level.extratimebonus > 0) {
      level.extratime = level.currentobjectiveindex * level.extratimebonus;
      _id_8DD9F2EB8215A139 = scripts\mp\gamelogic::gettimeremaining();
      setgameendtime(gettime() + int(_id_8DD9F2EB8215A139));
    }

    if(scripts\mp\utility\game::inovertime()) {
      game["overtimeProgress"]++;
      game["overtimeProgressFrac"] = 0;
    }

    updatecurrentobjective(_id_DC6CBFDA5CAFD043);
  }
}

dompoint_onenduse(team, player, success) {
  if(self != level.currentobjective) {
    return;
  }
  _id_6663215F917210AE::dompoint_onuseend(team, player, success);
}

dompoint_oncontested() {
  if(self != level.currentobjective) {
    return;
  }
  _id_6663215F917210AE::dompoint_oncontested();
}

dompoint_onuncontested(lastclaimteam) {
  if(self != level.currentobjective) {
    return;
  }
  _id_6663215F917210AE::dompoint_onuncontested(lastclaimteam);
  self.didstatusnotify = 1;
  ownerteam = scripts\mp\gameobjects::getownerteam();
  state = scripts\engine\utility::ter_op(ownerteam == "neutral", "idle", ownerteam);
  ownerteam = scripts\mp\gameobjects::getownerteam();
}

dompoint_ondisableobjective() {
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::disableobject();
  scripts\mp\gameobjects::resetcaptureprogress();
  scripts\mp\gameobjects::releaseid();
  self notify("useObjectDecay");
  scripts\engine\utility::delaythread(0.1, ::disabledomflagscriptable);
}

dompoint_onenableobjective() {
  scripts\mp\gameobjects::requestid(1, 1);
  scripts\mp\gameobjects::enableobject();
  scripts\mp\gameobjects::setvisibleteam("any");
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);

  if(isDefined(self.defaultownerteam)) {
    scripts\mp\gameobjects::setownerteam(self.defaultownerteam);
    thread _id_6663215F917210AE::updateflagstate(self.defaultownerteam, 0);
  } else {
    scripts\mp\gameobjects::setownerteam("neutral");
    thread _id_6663215F917210AE::updateflagstate("idle", 0);
  }
}

dompoint_onactivateobjective() {
  scripts\mp\utility\sound::playsoundonplayers("mp_combat_outpost_activateobj");
  scripts\mp\gameobjects::allowuse("enemy");
  thread awardcapturepoints();
  level.flagcapturetime = level.captureduration;
  scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

initspecatatorcameras() {
  level.spectatorcameras = [];
  level.currentspectatorcamref = "rush_1";
  _id_84286554864313CB = scripts\engine\utility::getStructArray("tac_ops_map_config", "targetname");

  foreach(_id_48380029FBB1007A in _id_84286554864313CB) {
    _id_CA2C833762E5466C = _id_48380029FBB1007A.script_noteworthy;
    _id_84BD84DEB891A915 = scripts\engine\utility::getStructArray(_id_48380029FBB1007A.target, "targetname");

    foreach(_id_6A17713098332FE4 in _id_84BD84DEB891A915) {
      switch (_id_6A17713098332FE4.script_label) {
        case "to_allies_camera":
          setteammapposition(_id_CA2C833762E5466C, "allies", _id_6A17713098332FE4);
          break;
        case "to_axis_camera":
          setteammapposition(_id_CA2C833762E5466C, "axis", _id_6A17713098332FE4);
          break;
      }
    }
  }
}

setteammapposition(_id_CA2C833762E5466C, team, _id_20C18491AEB9A905) {
  if(!isDefined(level.spectatorcameras[_id_CA2C833762E5466C]))
    level.spectatorcameras[_id_CA2C833762E5466C] = [];

  level.spectatorcameras[_id_CA2C833762E5466C][team] = _id_20C18491AEB9A905;
}

startspectatorview() {
  waitframe();
  scripts\mp\utility\player::updatesessionstate("spectator");
  scripts\mp\spectating::setdisabled();

  if(isDefined(self.lastdeathangles))
    self setplayerangles(self.lastdeathangles);

  wait 0.1;
  scripts\mp\utility\player::setdof_default();
  _id_025AC223966C5537 = level.spectatorcameras[level.currentspectatorcamref][self.team];
  _id_0DEAD2082432CECC = _id_025AC223966C5537.origin;
  _id_06788DC28320974A = _id_025AC223966C5537.angles;
  self.deathspectatepos = _id_0DEAD2082432CECC;
  self.deathspectateangles = _id_06788DC28320974A;
  cameraent = spawn("script_model", self getvieworigin());
  cameraent setModel("tag_origin");
  cameraent.angles = _id_06788DC28320974A;
  self.spectatorcament = cameraent;
  self.isusingtacopsmapcamera = 1;
  self cameralinkTo(cameraent, "tag_origin", 1);
  thread dohalfwayflash();
  cameraent movecameratomappos(self, _id_0DEAD2082432CECC, _id_06788DC28320974A);
}

dohalfwayflash() {
  wait 0.4;
  thread playslamzoomflash();
  applythermal();
}

endspectatorview() {
  if(!isDefined(self.spectatorcament)) {
    return;
  }
  removethermal();
  thread runslamzoomonspawn();
}

updatespectatorcamera(_id_CA2C833762E5466C) {
  level.currentspectatorcamref = _id_CA2C833762E5466C;

  foreach(player in level.players) {
    if(isDefined(player.spectatorcament)) {
      team = player.team;
      _id_B5ECD32577A250AD = getdvarint("dvar_8BFD75900211E88B", -1);

      if(_id_B5ECD32577A250AD != -1)
        team = scripts\engine\utility::ter_op(_id_B5ECD32577A250AD == 0, "allies", "axis");

      _id_5940F376A254619D = level.spectatorcameras[level.currentspectatorcamref][team];
      player.spectatorcament movecameratomappos(player, _id_5940F376A254619D.origin, _id_5940F376A254619D.angles);
    }
  }
}

movecameratomappos(player, _id_9813182985677B23, finalangles) {
  player endon("spawned_player");
  movetime = 1.0;
  _id_CC5BC42930ABBC4F = 1.0;
  self moveTo(_id_9813182985677B23, 1.0, 0.5, 0.5);
  player playlocalsound("mp_cmd_camera_zoom_out");
  player setclienttriggeraudiozonepartialwithfade("spawn_cam", 0.5, "mix");
  self rotateTo(finalangles, 1.0, 0.5, 0.5);
  player thread startoperatorsound();
  wait 1.1;
  _id_AE753108F3DFF053 = anglesToForward(finalangles) * 300;
  _id_AE753108F3DFF053 = _id_AE753108F3DFF053 * (1, 1, 0);

  if(isDefined(player) && isDefined(player.spectatorcament)) {
    self moveTo(_id_9813182985677B23 + _id_AE753108F3DFF053, 15.0, 1.0, 1.0);
    player earthquakeforplayer(0.03, 15.0, _id_9813182985677B23 + _id_AE753108F3DFF053, 1000);
  }
}

runslamzoomonspawn() {
  self waittill("spawned_player");
  targetpos = self getEye();
  targetangles = self.angles;
  scripts\mp\utility\player::updatesessionstate("spectator");
  self cameralinkTo(self.spectatorcament, "tag_origin", 1);
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.2);
  self.spectatorcament moveTo(targetpos, 0.5);
  self playlocalsound("mp_cmd_camera_zoom_in");
  self clearclienttriggeraudiozone(0.5);
  self.spectatorcament rotateTo(targetangles, 0.5, 0.5);
  wait 0.5;
  self visionsetnakedforplayer("", 0);
  thread playslamzoomflash();
  scripts\mp\utility\player::updatesessionstate("playing");
  self cameraunlink();
  self.spectatorcament delete();
}

playslamzoomflash() {
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
  overlay.alpha = 0.0;
  wait 0.4;
  overlay destroy();
}

startoperatorsound() {
  self endon("game_ended");
  self waittill("spawned_player");
  wait 0.5;
}

applythermal() {
  self visionsetthermalforplayer("proto_apache_flir_mp");
  self thermalvisionon();
}

removethermal() {
  self thermalvisionoff();
}

loopspectatorlocations() {
  index = 1;

  for(;;) {
    if(getdvarint("dvar_4AC8D16CE8DD74FD", 0) == 1) {
      if(isalive(level.players[0]))
        level.players[0] suicide();

      _id_7940DCDE72827AF7 = getdvarint("dvar_885DEA990259DAFE", -1);

      if(_id_7940DCDE72827AF7 != -1)
        index = _id_7940DCDE72827AF7;

      updatespectatorcamera("rush_" + index);
      duration = getdvarfloat("dvar_7D3EA16C514F408D", 1.0);
      wait(duration);
      index++;

      if(index > 3)
        index = 1;

      if(getdvarint("dvar_4AC8D16CE8DD74FD", 0) == 0)
        level.players[0] notify("force_spawn");

      continue;
    }

    waitframe();
  }
}