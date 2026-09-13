/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\vip.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  _id_9BBACB179DEA3237[1] = "sd";
  _id_9BBACB179DEA3237[2] = "bombzone";
  _id_9BBACB179DEA3237[3] = "dom";
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 3);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  level.teambased = 1;
  level.objectivebased = 1;
  updategametypedvars();
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onnormaldeath = ::onnormaldeath;
  level.onplayerkilled = ::onplayerkilled;
  level.ondeadevent = ::ondeadevent;
  game["dialog"]["gametype"] = "gametype_defender";
  game["dialog"]["offense_obj"] = "hint_killall";
  game["dialog"]["defense_obj"] = "hint_killall";
  level._effect["vfx_smk_signal"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal");
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("dvar_DD7FDF98A94C3F97", 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  setdynamicdvar("dvar_274247F977C3CF99", 0);
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
}

onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    _id_2B21F2FBE8DD5C6E = game["attackers"];
    _id_8D904E28CF14C8AE = game["defenders"];
    game["attackers"] = _id_8D904E28CF14C8AE;
    game["defenders"] = _id_2B21F2FBE8DD5C6E;
  }

  scripts\mp\utility\game::setobjectivetext("allies", &"OBJECTIVES/VIP");
  scripts\mp\utility\game::setobjectivetext("axis", &"OBJECTIVES/VIP");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext("allies", &"OBJECTIVES/VIP");
    scripts\mp\utility\game::setobjectivescoretext("axis", &"OBJECTIVES/VIP");
  } else {
    scripts\mp\utility\game::setobjectivescoretext("allies", &"OBJECTIVES/VIP_SCORE");
    scripts\mp\utility\game::setobjectivescoretext("axis", &"OBJECTIVES/VIP_SCORE");
  }

  scripts\mp\utility\game::setobjectivehinttext("allies", &"OBJECTIVES/VIP_HINT");
  scripts\mp\utility\game::setobjectivehinttext("axis", &"OBJECTIVES/VIP_HINT");
  initspawns();
  level.hostagestates = [];
  level.hostagecarrystates = [];
  seticonnames();
  thread waittoprocess();
  level thread votimeendingsoon();
}

waittoprocess() {
  level endon("game_end");
  level endon("waitSkipped");
  level thread extractionzone();
  level thread spawnvip();
  level thread createthreatbiasgroups();
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("graceperiod_done");
  self notify("graceComplete");
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_sd_spawn_attacker");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_sd_spawn_defender");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  _id_700A871A46435669 = "mp_sd_spawn_defender";

  if(self.pers["team"] == game["attackers"])
    _id_700A871A46435669 = "mp_sd_spawn_attacker";

  spawnpoints = scripts\mp\spawnlogic::getspawnpointarray(_id_700A871A46435669);
  spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints);
  return spawnpoint;
}

seticonnames() {
  level.iconrecover = "waypoint_recover_vip";
  level.iconescort = "waypoint_escort_vip";
  level.iconextract = "waypoint_extract_vip";
  level.icontakingextract = "waypoint_taking_extract";
  level.iconlosingextract = "waypoint_losing_extract";
  level.iconcontestingextract = "waypoint_contesting_extract";
  level.icondefendextract = "waypoint_defend_extract";
  level.iconcaptureextract = "waypoint_capture_extract";
  level.iconstoppingextract = "waypoint_stopping_extract";
}

onspawnplayer(_id_9156B53BCF7CE573) {
  self.isvip = 0;
  self.usingobj = undefined;
  level notify("spawned_player");
  scripts\mp\hud_message::_id_F004EF4606B9EFDC("hide_match_hint");
  self setthreatbiasgroup(self.team);
  thread updatematchstatushintonspawn();

  if(isDefined(level.vip))
    level.vip.trigger enableplayeruse(self);
}

onnormaldeath(victim, attacker, lifeid, smeansofdeath, objweapon, iskillstreakweapon) {
  score = scripts\mp\rank::getscoreinfovalue("stat_EF9582D72160F199");
  team = victim.team;

  if(isDefined(victim.isvip) && victim.isvip) {
    level thread vip_endgame(game["attackers"], &"MP_ELIMINATED_VIP");
    attacker.finalkill = 1;
  }
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  thread checkallowspectating();
}

ontimelimit() {
  if(game["status"] == "overtime")
    winner = "forfeit";
  else if(game["teamScores"]["allies"] == game["teamScores"]["axis"])
    winner = "overtime";
  else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
    winner = "axis";
  else
    winner = "allies";

  thread scripts\mp\gamelogic::endgame(winner, game["end_reason"]["time_limit_reached"]);
}

checkallowspectating() {
  waitframe();
  update = 0;

  if(!scripts\mp\utility\teams::getteamdata(game["attackers"], "aliveCount")) {
    level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
    update = 1;
  }

  if(!scripts\mp\utility\teams::getteamdata(game["defenders"], "aliveCount")) {
    level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
    update = 1;
  }

  if(update)
    scripts\mp\spectating::updatespectatesettings();
}

ondeadevent(team) {
  if(team == game["attackers"])
    level thread vip_endgame(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
  else if(team == game["defenders"])
    level thread vip_endgame(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
}

vip_endgame(_id_EC15CE3E7A9D1D86, _id_F0500919D8C387B9) {
  thread scripts\mp\gamelogic::endgame(_id_EC15CE3E7A9D1D86, _id_F0500919D8C387B9);
}

extractionzone() {
  triggers = getEntArray("bombzone", "targetname");
  triggers = _id_7188DBFE03E45511::removebombzonec(triggers);
  level.objectives = [];
  _id_C8A41AE10DD3B1D2 = game["attackers"];

  foreach(trigger in triggers) {
    visuals[0] = spawn("script_model", trigger.origin);
    visuals[0].angles = (0, 270, 0);
    visuals[0].team = _id_C8A41AE10DD3B1D2;
    visuals[0].visibleteam = "any";
    visuals[0].ownerteam = _id_C8A41AE10DD3B1D2;
    visuals[0].type = "";
    exfilgoaltrigger = spawn("trigger_radius", trigger.origin, 0, 120, 80);
    exfilgoaltrigger.team = _id_C8A41AE10DD3B1D2;
    droppoint = exfilgoaltrigger.origin;
    contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 0, 0, 1, 1);
    ignoreents = [];
    trace = scripts\engine\trace::ray_trace(visuals[0].origin + (0, 0, 20), visuals[0].origin - (0, 0, 4000), ignoreents, contentoverride, 0);

    if(isPlayer(trace["entity"]))
      trace["entity"] = undefined;

    if(isDefined(trace)) {
      _id_9CA1B8FD292FEFFA = randomfloat(360);
      droporigin = trace["position"];

      if(isDefined(self.visualgroundoffset))
        droporigin = droporigin + self.visualgroundoffset;

      forward = (cos(_id_9CA1B8FD292FEFFA), sin(_id_9CA1B8FD292FEFFA), 0);
      forward = vectorNormalize(forward - trace["normal"] * vectordot(forward, trace["normal"]));
      dropangles = vectortoangles(forward);
      visuals[0].origin = droporigin;
      visuals[0] setModel("cop_marker_scriptable");
      visuals[0] setscriptablepartstate("marker", "red");
      visuals[0] playLoopSound("mp_flare_burn_lp");
    }

    level.flagcapturetime = 0.05;

    if(isDefined(exfilgoaltrigger.objectivekey))
      objectivekey = exfilgoaltrigger.objectivekey;
    else
      objectivekey = exfilgoaltrigger.script_label;

    if(isDefined(exfilgoaltrigger.iconname))
      iconname = exfilgoaltrigger.iconname;
    else
      iconname = exfilgoaltrigger.script_label;

    exfilgoaltrigger = scripts\mp\gameobjects::createuseobject(_id_C8A41AE10DD3B1D2, exfilgoaltrigger, visuals, (0, 0, 100));
    exfilgoaltrigger.team = _id_C8A41AE10DD3B1D2;
    exfilgoaltrigger.ownerteam = game["defenders"];
    exfilgoaltrigger.ownerteamcaps = 1;
    exfilgoaltrigger.origin = exfilgoaltrigger.curorigin;
    exfilgoaltrigger scripts\mp\gameobjects::allowuse("enemy");
    exfilgoaltrigger scripts\mp\gameobjects::cancontestclaim(1);
    exfilgoaltrigger scripts\mp\gameobjects::setusetime(level.flagcapturetime);
    exfilgoaltrigger.onuse = ::extractzone_onuse;
    exfilgoaltrigger.onbeginuse = ::extractzone_onusebegin;
    exfilgoaltrigger.onenduse = ::extractzone_onuseend;
    exfilgoaltrigger.oncontested = ::extractzone_oncontested;
    exfilgoaltrigger.onuncontested = ::extractzone_onuncontested;
    exfilgoaltrigger scripts\mp\gameobjects::pinobjiconontriggertouch();
    exfilgoaltrigger.id = "domFlag";
    exfilgoaltrigger.extractionactive = 0;
    exfilgoaltrigger scripts\mp\gameobjects::setcapturebehavior("normal");
    exfilgoaltrigger.objectivekey = objectivekey;
    exfilgoaltrigger.iconname = iconname;
    exfilgoaltrigger scripts\mp\gameobjects::setvisibleteam("any");
    exfilgoaltrigger.stompprogressreward = ::extractzone_stompprogressreward;
    exfilgoaltrigger.nousebar = 1;
    exfilgoaltrigger.id = "domFlag";
    exfilgoaltrigger.claimgracetime = level.flagcapturetime * 1000;
    exfilgoaltrigger scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendextract, level.iconcaptureextract);
    waitframe();
  }

  entities = getEntArray();

  foreach(entity in entities) {
    _id_49C0BB15CB302F86 = entity.script_gameobjectname;

    if(isDefined(_id_49C0BB15CB302F86)) {
      if(_id_49C0BB15CB302F86 == "bombzone")
        entity delete();
    }
  }
}

extractzone_onusebegin(player) {
  player.iscapturing = 1;
  level.canprocessot = 0;
  ownerteam = scripts\mp\gameobjects::getownerteam();
  self.neutralizing = istrue(level.flagneutralization) && ownerteam != "neutral";

  if(!istrue(self.neutralized))
    self.didstatusnotify = 0;

  if(istrue(level.capturedecay))
    thread scripts\mp\gameobjects::useobjectdecay(player.team);

  self.prevownerteam = scripts\mp\utility\game::getotherteam(player.team)[0];
  _id_6663215F917210AE::updateflagcapturestate(player.team);

  if(ownerteam == game["attackers"])
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconstoppingextract, level.iconlosingextract);
  else
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosingextract, level.icontakingextract);
}

extractzone_onuseend(team, player, success) {
  level.canprocessot = 1;

  if(success)
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);

  if(isPlayer(player)) {
    player.iscapturing = 0;
    player setclientomnvar("ui_objective_pinned_text_param", 0);
  }

  if(!success) {
    self.neutralized = 0;
    ownerteam = scripts\mp\gameobjects::getownerteam();

    if(ownerteam == game["attackers"]) {
      if(self.extractionactive)
        scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_active_exfil", "icon_waypoint_prevent_exfil");
      else
        scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_waitfor_exfil", "icon_waypoint_prevent_exfil");
    } else
      scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendextract, level.iconcaptureextract);
  }
}

extractzone_onuse(_id_22282E7D48CA3400) {
  level.canprocessot = 1;
  team = _id_22282E7D48CA3400.team;
  _id_8A04AA0E0755E7E3 = scripts\mp\gameobjects::getownerteam();
  self.capturetime = gettime();
  self.neutralized = 0;
  extractzone_setcaptured(team, _id_22282E7D48CA3400);

  if(!self.neutralized) {
    if(isDefined(level.onobjectivecomplete))
      [[level.onobjectivecomplete]]("dompoint", self.objectivekey, _id_22282E7D48CA3400, team, _id_8A04AA0E0755E7E3, self);
  }

  if(team == game["attackers"]) {
    playFXOnTag(level._effect["vfx_smk_signal"], self.visuals[0], "tag_origin");
    playannouncerbattlechatter(team, "extract_littlebird_start_a_friendly", 20);
    _id_22282E7D48CA3400 vipextract(self);
  } else {
    stopFXOnTag(level._effect["vfx_smk_signal"], self.visuals[0], "tag_origin");
    self.extractionactive = 0;
  }
}

extractzone_oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontestingextract);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
}

extractzone_onuncontested(lastclaimteam) {
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(self.ownerteam == game["attackers"]) {
    if(self.extractionactive)
      scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_active_exfil", "icon_waypoint_prevent_exfil");
    else
      scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_waitfor_exfil", "icon_waypoint_prevent_exfil");
  } else
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendextract, level.iconcaptureextract);
}

extractzone_setcaptured(team, _id_22282E7D48CA3400) {
  scripts\mp\gameobjects::setownerteam(team);

  if(self.ownerteam == game["attackers"]) {
    scripts\mp\gameobjects::setusetime(5);
    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_waitfor_exfil", "icon_waypoint_prevent_exfil");
  } else {
    scripts\mp\gameobjects::setusetime(0.05);
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendextract, level.iconcaptureextract);

    foreach(heli in self.choppers) {
      heli notify("bugOut");
      heli notify("esc_littlebird_arrive");
      heli scripts\engine\utility::array_remove(self.choppers, heli);
      self.choppers = [];
      heli thread _id_556596FE1CBE7D24::littlebirdleave();
    }

    playannouncerbattlechatter(game["attackers"], "extract_littlebird_leaving_a_friendly", 10);
  }

  self notify("capture", _id_22282E7D48CA3400);
  self notify("assault", _id_22282E7D48CA3400);
  self.neutralized = 0;

  if(self.touchlist[team].size == 0)
    self.touchlist = self.oldtouchlist;

  thread giveflagcapturexp(self.touchlist[team], _id_22282E7D48CA3400);
  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "captured_" + team);
}

extractzone_stompprogressreward(player) {
  player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2D96CED878338CD2");
}

getcapturetype() {
  capturetype = "normal";

  if(level.capturetype == 2)
    capturetype = "neutralize";
  else if(level.capturetype == 3)
    capturetype = "persistent";

  return capturetype;
}

giveflagcapturexp(touchlist, _id_22282E7D48CA3400) {
  level endon("game_ended");
  _id_0666D6B1872868D7 = _id_22282E7D48CA3400;

  if(isDefined(_id_0666D6B1872868D7.owner))
    _id_0666D6B1872868D7 = _id_0666D6B1872868D7.owner;

  level.lastcaptime = gettime();

  if(isPlayer(_id_0666D6B1872868D7)) {
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_securedposition", _id_0666D6B1872868D7);
    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.player = _id_0666D6B1872868D7;
    _id_7E2C53B0BCF117D9.eventname = "capture";
    _id_7E2C53B0BCF117D9.position = _id_0666D6B1872868D7.origin;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
  }

  _id_59DB5D0F4E3000A7 = getarraykeys(touchlist);

  for(index = 0; index < _id_59DB5D0F4E3000A7.size; index++) {
    player = touchlist[_id_59DB5D0F4E3000A7[index]].player;

    if(isDefined(player.owner))
      player = player.owner;

    if(!isPlayer(player)) {
      continue;
    }
    player scripts\mp\utility\stats::incpersstat("captures", 1);
    player scripts\mp\persistence::statsetchild("round", "captures", player.pers["captures"]);
    player scripts\mp\utility\stats::setextrascore0(player.pers["captures"]);
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5A7B15A24E10A93B");
    wait 0.05;
  }
}

vipextract(_id_53472FD04EF31634) {
  if(!isDefined(_id_53472FD04EF31634.choppers))
    _id_53472FD04EF31634.choppers = [];

  _id_E227374D9D756C2D = anglesToForward(self getplayerangles(1));
  groundpos = getgroundposition(self getEye() + (0, 0, 60) + _id_E227374D9D756C2D * 80, 60) + (0, 0, 8);
  heli = _id_556596FE1CBE7D24::spawnextractchopper(_id_53472FD04EF31634, _id_53472FD04EF31634.origin);
  _id_53472FD04EF31634.choppers[_id_53472FD04EF31634.choppers.size] = heli;
  self iprintlnbold("Extraction copter en route!");
  heli.extractzone = _id_53472FD04EF31634;
  heli.extractteam = self.team;
  _id_53472FD04EF31634.curorigin = _id_53472FD04EF31634.origin;
  _id_53472FD04EF31634.offset3d = (0, 0, 30);
  _id_53472FD04EF31634 thread extracttriggerwatcher(heli);
}

extracttriggerwatcher(heli) {
  level endon("game_ended");
  heli endon("bugOut");
  heli waittill("esc_littlebird_arrive");
  self.extractionactive = 1;
  playannouncerbattlechatter(heli.extractteam, "extract_littlebird_close_a_friendly", 10);

  if(self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontestingextract);
  else
    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_active_exfil", "icon_waypoint_prevent_exfil");

  for(;;) {
    self.trigger waittill("trigger", player);

    if(!istrue(self.stalemate)) {
      if(istrue(player.isagentvip) && self.numtouching[game["defenders"]] == 0) {
        level thread vip_endgame(player.team, game["end_reason"]["objective_completed"]);
        break;
      } else if(player.team == self.team && isDefined(player.carryobject)) {
        level thread vip_endgame(player.team, game["end_reason"]["objective_completed"]);
        break;
      }
    }
  }
}

createthreatbiasgroups() {
  waitframe();
  createthreatbiasgroup("vip");

  foreach(team in level.teamnamelist) {
    createthreatbiasgroup(team);
    setignoremegroup(team, "vip");
  }
}

spawnvip() {
  level endon("game_ended");
  wait 2;
  _id_048F7B37896E887B = getEnt("sd_bomb_pickup_trig", "targetname");
  agent = undefined;
  _id_FB1DEF007972B25A = undefined;
  level.allowhvtspawn = 1;

  while(!isDefined(agent)) {
    agent = scripts\mp\agents\agent_common::connectnewagent("player", game["attackers"]);

    if(isDefined(agent)) {
      _id_FB1DEF007972B25A = _id_048F7B37896E887B.origin;
      _id_048F7B37896E887B delete();
      agent thread[[agent scripts\mp\agents\agent_utility::agentfunc("spawn")]](_id_FB1DEF007972B25A, (0, 0, 0));
      _id_E6874E9B453D7005 = agent getnearestnode();
      agent setOrigin(_id_E6874E9B453D7005.origin);
      agent.team = game["attackers"];
      agent scripts\mp\bots\bots_util::bot_set_difficulty("recruit");
      agent.outlineid = scripts\mp\utility\outline::outlineenableforteam(agent, agent.team, "outline_nodepth_green", "lowest");
      agent.nocorpse = 1;
      agent.isdowned = 0;
      agent.isagentvip = 1;
      trigger = spawn("script_model", agent.origin + (0, 0, 30));
      trigger.team = game["attackers"];
      trigger.destination = agent.origin;
      trigger linkTo(agent);
      trigger scripts\mp\utility\usability::maketeamusable(trigger.team);
      trigger setHintString(&"MP/HOLD_TO_ESCORT_VIP");
      trigger setusepriority(-4);
      agent.trigger = trigger;
      agent.ownerteam = trigger.team;
      agent.interactteam = "friendly";
      agent.requireslos = 1;
      agent.exclusiveuse = 0;
      agent.curprogress = 0;
      agent.usetime = 0;
      agent.userate = 1;
      agent.id = "care_package";
      agent.skiptouching = 1;
      agent.onuse = ::agent_onuse;
      agent thread scripts\mp\gameobjects::useobjectusethink();
      agent.trackedobject = agent scripts\mp\gameobjects::createtrackedobject(agent, (0, 0, 70));
      agent.trackedobject.objidpingfriendly = 0;
      agent.trackedobject.objidpingenemy = 0;
      agent.trackedobject.objpingdelay = 0.05;
      agent.trackedobject.visibleteam = "friendly";
      agent.invulnerable = 1;
      agent.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconescort);
      continue;
    }

    waitframe();
  }

  agent setthreatbiasgroup("vip");
  agent thread hvtclearmove(_id_FB1DEF007972B25A);
  agent thread hvtdeathwatcher();
  agent takeallweapons();
  waitframe();
  agent scripts\cp_mp\utility\inventory_utility::_giveweapon("iw9_me_fists_mp", undefined, undefined, 1);
  level.vip = agent;
}

hvtclearmove(_id_FB1DEF007972B25A) {
  self botsetscriptgoal(_id_FB1DEF007972B25A, 20, "critical");
  result = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  while(!isDefined(self.tetherplayer)) {
    self botsetflag("disable_movement", 1);
    wait 0.1;
  }
}

agent_onuse(player) {
  scripts\mp\utility\print::printboldonteam("HVT is following " + player.name, player.team);
  self.following = 1;
  self.usetime = 1000;
  thread followplayer(player);
  player thread watchownerdeath(self);
  self.trigger scripts\mp\utility\usability::maketeamusable(self.team);
  self.trigger disableplayeruse(player);
}

followplayer(player) {
  self endon("game_ended");
  self.tetherplayer = player;
  level.tetherplayer = player;
  self botsetflag("disable_movement", 0);
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(player.team, "vip_extract", "vip_stop_extract", level.tetherplayer, "vip_escort");

  while(isDefined(self.tetherplayer)) {
    _id_FDDEEC50A509ECE5 = self.tetherplayer getstance();
    self botsetstance(_id_FDDEEC50A509ECE5);

    if(self.tetherplayer issprinting()) {
      self botsetflag("cautious", 0);
      self botsetflag("force_sprint", 1);
    } else {
      self botsetflag("force_sprint", 0);
      self botsetflag("cautious", 1);
    }

    if(distance2dsquared(self.tetherplayer.origin, self.origin) < 10000)
      level.vipdist = distance2dsquared(self.tetherplayer.origin, self.origin);
    else if(distance2dsquared(self.tetherplayer.origin, self.origin) > 10000) {
      level.vipdist = distance2dsquared(self.tetherplayer.origin, self.origin);
      goalnode = botgetclosestnavigablepoint(self.tetherplayer.origin, 40, self);

      if(isDefined(goalnode)) {
        self botsetpathingstyle("sneak");
        self botsetscriptgoal(goalnode, 32, "tactical");
        _id_2504DA19C43FB0D3 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(3);

        if(_id_2504DA19C43FB0D3 == "goal") {}
      }
    }

    wait 0.15;
  }

  level.tetherplayer = undefined;
}

watchownerdeath(vip) {
  self endon("game_ended");
  vip endon("tether_swap");
  self waittill("death");
  vip.following = 0;
  vip.usetime = 0;
  vip.tetherplayer = undefined;
  level.tetherplayer = undefined;
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(vip.team, "vip_secure", "vip_stop_extract");
}

hvtdeathwatcher() {
  self endon("game_ended");
  self endon("hvt_timeout");
  self waittill("death");
  self.trackedobject scripts\mp\gameobjects::releaseid();
  self.trigger scripts\mp\utility\usability::setallunusable();
  level.hostages[0] = spawnhostage(self.origin, self.team, 1);
  level.hostages[0].outlineid = scripts\mp\utility\outline::outlineenableforteam(level.hostages[0].body, level.hostages[0].team, "outline_nodepth_cyan", "killstreak_personal");
}

updatematchstatushintonspawn() {
  level endon("game_ended");
  level scripts\mp\flags::gameflagwait("prematch_done");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(level.vip)) {
    if(isDefined(level.tetherplayer)) {
      if(isDefined(level.tetherplayer.team) && level.tetherplayer.team == self.team) {
        if(level.tetherplayer == self)
          scripts\mp\hud_message::_id_F004EF4606B9EFDC("vip_escort");
        else
          scripts\mp\hud_message::_id_F004EF4606B9EFDC("vip_extract");
      } else
        scripts\mp\hud_message::_id_F004EF4606B9EFDC("vip_stop_extract");
    } else if(isDefined(self.team) && level.vip.team == self.team)
      scripts\mp\hud_message::_id_F004EF4606B9EFDC("vip_secure");
    else
      scripts\mp\hud_message::_id_F004EF4606B9EFDC("vip_stop_extract");
  } else if(isDefined(level.hostagecarrier)) {
    if(level.hostagecarrier.team == self.team) {
      if(level.hostagecarrier == self)
        scripts\mp\hud_message::_id_F004EF4606B9EFDC("vip_carry");
      else
        scripts\mp\hud_message::_id_F004EF4606B9EFDC("vip_extract");
    } else
      scripts\mp\hud_message::_id_F004EF4606B9EFDC("vip_stop_extract");
  } else if(level.hostages[0].team == self.team)
    scripts\mp\hud_message::_id_F004EF4606B9EFDC("vip_secure");
  else
    scripts\mp\hud_message::_id_F004EF4606B9EFDC("vip_stop_extract");
}

playannouncerbattlechatter(team, _id_CB3339ECE72DBDEB, _id_0E4731409BD255E0) {
  level endon("game_ended");
  faction = "ustl";
  soundalias = "dx_mpa_" + faction + "_" + _id_CB3339ECE72DBDEB + "_" + _id_0E4731409BD255E0;

  if(soundexists(soundalias)) {
    foreach(player in level.players) {
      if(player.team == team)
        player queuedialogforplayer(soundalias, _id_CB3339ECE72DBDEB, 2);
    }
  }
}

votimeendingsoon() {
  level endon("game_ended");
  level waittill("match_ending_very_soon");
  playannouncerbattlechatter(game["attackers"], "extract_littlebird_leaving_soon_a_friendly", 10);
}

spawnhostage(_id_8F5D6F42D8464DE0, _id_2883E54A0393D54D, showicon) {
  if(!isDefined(showicon))
    showicon = 1;

  if(scripts\mp\utility\game::getgametype() == "vip") {
    _id_2883E54A0393D54D = game["attackers"];
    _id_0A5979337C62D2A9 = "body_opforce_london_terrorist_1_2";
    _id_9163C4F755283F46 = "head_male_bc_03";
  } else {
    _id_2883E54A0393D54D = "neutral";
    _id_0A5979337C62D2A9 = "body_mp_western_fireteam_west_ar_1_1_lod1";
    _id_9163C4F755283F46 = "head_mp_western_fireteam_west_ar_1_1";
  }

  hostage = spawn("script_model", _id_8F5D6F42D8464DE0);
  _id_15115ECDAB98AF77 = spawn("script_model", _id_8F5D6F42D8464DE0);
  _id_541B553BD71295F4 = spawn("script_model", _id_8F5D6F42D8464DE0);
  _id_15115ECDAB98AF77 setModel(_id_0A5979337C62D2A9);
  _id_541B553BD71295F4 setModel(_id_9163C4F755283F46);
  _id_541B553BD71295F4 linkTo(_id_15115ECDAB98AF77, "j_neck", (-9, 1, 0), (0, 0, 0));
  _id_15115ECDAB98AF77 linkTo(hostage, "", (0, 0, -48), (0, 0, 0));
  trigger = spawn("script_model", _id_8F5D6F42D8464DE0);
  trigger.team = _id_2883E54A0393D54D;
  trigger.destination = _id_8F5D6F42D8464DE0;
  hostage.trigger = trigger;
  trigger linkTo(hostage);
  hostage.trigger makeusable();
  hostage.body = _id_15115ECDAB98AF77;
  hostage.head = _id_541B553BD71295F4;
  hostage = drophostage(undefined, hostage, _id_8F5D6F42D8464DE0, 1);
  hostage.teamscored["allies"] = 0;
  hostage.teamscored["axis"] = 0;
  hostage.wasindent = 0;
  hostage.requireslos = 1;
  hostage.setdropped = ::drophostage;
  hostage.team = _id_2883E54A0393D54D;
  hostage.usehostagedrop = 1;
  hostage.ownerteam = _id_2883E54A0393D54D;
  hostage.interactteam = scripts\engine\utility::ter_op(_id_2883E54A0393D54D == "neutral", "any", "friendly");
  hostage.exclusiveuse = 0;
  hostage.curprogress = 0;
  hostage.usetime = scripts\engine\utility::ter_op(scripts\mp\utility\game::getgametype() == "cmd", 500, 0);
  hostage.userate = 1;
  hostage.id = "care_package";
  hostage.skiptouching = 1;
  hostage thread scripts\mp\gameobjects::useobjectusethink();
  _id_30F120A1EFC1DCBE = "icon_minimap_tac_ops_hostage_unknown";
  attachobj = spawn("script_model", _id_8F5D6F42D8464DE0);
  attachobj linkTo(hostage);
  hostage.attachobj = attachobj;

  if(_id_2883E54A0393D54D == "neutral") {
    _id_E7345E605D1947FC = "any";
    visibleteam = "any";
  } else {
    _id_E7345E605D1947FC = "friendly";
    visibleteam = "friendly";
  }

  if(scripts\mp\utility\game::getgametype() != "cmd" && showicon) {
    hostage.trackedobject = hostage scripts\mp\gameobjects::createtrackedobject(attachobj, (0, 0, 0));
    hostage.trackedobject.objidpingfriendly = 0;
    hostage.trackedobject.objidpingenemy = 1;
    hostage.trackedobject.objpingdelay = 2.0;
    hostage.trackedobject scripts\mp\gameobjects::allowcarry(_id_E7345E605D1947FC);
    hostage.trackedobject scripts\mp\gameobjects::setownerteam(hostage.ownerteam);
    hostage.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconrecover, level.iconrecover);
    hostage.trackedobject.cancontestclaim = 1;
    hostage.trackedobject.stalemate = 0;
    hostage.trackedobject.wasstalemate = 1;
    hostage.trackedobject scripts\mp\gameobjects::setvisibleteam(visibleteam);
  }

  if(isDefined(hostage.trackedobject)) {
    hostage.trackedobject scripts\mp\gameobjects::allowcarry(_id_2883E54A0393D54D);
    hostage.trackedobject scripts\mp\gameobjects::setownerteam(_id_2883E54A0393D54D);
    hostage.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconrecover, level.iconrecover);

    if(scripts\mp\utility\game::getgametype() == "btm" || scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict") {
      hostage.trackedobject.cancontestclaim = 1;
      hostage.trackedobject.stalemate = 0;
      hostage.trackedobject.wasstalemate = 1;
    }

    hostage.trackedobject scripts\mp\gameobjects::setvisibleteam(visibleteam);
  }

  return hostage;
}

drophostage(player, hostage, position, _id_7006C5C506086629, waittime) {
  self notify("gameobject_deleted");

  if(!isDefined(player))
    player = self.carrier;

  if(!isDefined(position))
    position = self.curorigin;

  if(!isDefined(hostage))
    hostage = self;

  hostage notify("dropped");

  if(isDefined(hostage.trackedobject)) {
    hostage.trackedobject.carrier = hostage.attachobj;
    hostage.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconrecover, level.iconrecover);

    if(scripts\mp\utility\game::getgametype() != "cmd" && scripts\mp\utility\game::getgametype() != "btm" || scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict") {}
  }

  if(isDefined(level.hostagegoalent)) {
    level.hostagegoalent scripts\mp\gameobjects::setvisibleteam("none");
    level.hostagegoalent scripts\mp\gameobjects::releaseid();
  }

  if(scripts\mp\utility\game::getgametype() == "btm" && isDefined(level.vipextractzones))
    level.vipextractzones[player.team].goalent scripts\mp\gameobjects::setvisibleteam("none");

  hostage.carried = 0;
  _id_02E8AA5D4AF61544 = position;
  hostage unlink();
  _id_02E8AA5D4AF61544 = getclosestpointonnavmesh(position);
  hostage.origin = getphysicspointaboutnavmesh(_id_02E8AA5D4AF61544) + (0, 0, 2);
  hostage.angles = (0, hostage.angles[1], 0);

  if(!isDefined(_id_7006C5C506086629) && isDefined(hostage.useobj))
    hostage.useobj.origin = hostage.origin;

  if(isDefined(player)) {
    player.carryobject = undefined;
    team = player.team;

    foreach(_id_A188B7CA32400499 in level.hostages) {
      if(_id_A188B7CA32400499 != hostage)
        _id_A188B7CA32400499 enableplayeruse(player);
    }
  }

  if(isDefined(hostage.wmhostage)) {
    hostage.wmhostage unlink();
    hostage.wmhostage.head delete();
    hostage.wmhostage delete();
    hostage.wmhostage = undefined;
  }

  if(isDefined(waittime))
    wait(waittime);

  if(isDefined(player) && isDefined(player.hostagecarried)) {
    player.hostagecarried.body show();
    player.hostagecarried.head show();
    player.hostagecarried = undefined;
  } else {
    hostage.body show();
    hostage.head show();
  }

  hostage.trigger makeusable();

  if(isDefined(waittime)) {}

  level.hostagecarrier = undefined;

  if(scripts\mp\utility\game::getgametype() == "vip") {
    foreach(player in level.players) {
      if(player.team != hostage.trigger.team) {
        hostage.trigger disableplayeruse(player);
        hostage.trigger hidefromplayer(player);
      }
    }

    hostage.trigger setHintString(&"MP/HOLD_TO_PICKUP_VIP");
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(hostage.team, "vip_secure", "vip_stop_extract");
  } else if(scripts\mp\utility\game::getgametype() == "btm") {
    hostage.trigger setHintString(&"MP/HOLD_TO_PICKUP_VIP");
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(hostage.team, "vip_secure", "vip_stop_extract");
  } else
    hostage.trigger setHintString(&"MP/HOLD_TO_PICKUP_HOSTAGE");

  hostage setusepriority(-4);

  if(isDefined(hostage.curobjid))
    objective_setownerteam(hostage.curobjid, "neutral");

  if(isDefined(hostage.body)) {
    hostage.body linkTo(hostage, "", (0, 0, 0), (0, 0, 0));
    hostage.body scriptmodelplayanimdeltamotion("hm_grnd_civ_react02_idle07");
  }

  return hostage;
}

getphysicspointaboutnavmesh(_id_CDCD3178F5176585) {
  contents = scripts\engine\trace::create_contents(undefined, 1, 1, undefined, undefined, undefined, undefined);
  _id_BC1FB594D8A6E68A = physics_raycast(_id_CDCD3178F5176585 + (0, 0, 48), _id_CDCD3178F5176585 - (0, 0, 48), contents, undefined, 0, "physicsquery_closest");
  hit = isDefined(_id_BC1FB594D8A6E68A) && _id_BC1FB594D8A6E68A.size > 0;

  if(hit) {
    _id_2E3BC21C15E7AB6C = _id_BC1FB594D8A6E68A[0]["position"];
    return _id_2E3BC21C15E7AB6C;
  }

  return _id_CDCD3178F5176585;
}