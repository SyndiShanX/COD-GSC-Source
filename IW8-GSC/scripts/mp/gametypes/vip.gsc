/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\vip.gsc
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
  setdynamicdvar("scr_vip_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  setdynamicdvar("scr_vip_promode", 0);
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
}

function onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
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
  thread votimeendingsoon();
}

function waittoprocess() {
  level endon("game_end");
  level endon("waitSkipped");
  thread extractionzone();
  thread spawnvip();
  thread createthreatbiasgroups();
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("graceperiod_done");
  self notify("graceComplete");
}

function initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_sd_spawn_attacker");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_sd_spawn_defender");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
  var_0 = "mp_sd_spawn_defender";

  if(self.pers["team"] == game["attackers"]) {
    var_0 = "mp_sd_spawn_attacker";
  }

  var_1 = scripts\mp\spawnlogic::getspawnpointarray(var_0);
  var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  return var_2;
}

function seticonnames() {
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

function onspawnplayer() {
  self.isvip = 0;
  self.usingobj = undefined;
  level notify("spawned_player");
  self setclientomnvar("ui_match_status_hint_text", -1);
  self setthreatbiasgroup(self.team);
  thread updatematchstatushintonspawn();

  if(isDefined(level.vip)) {
    level.vip.trigger enableplayeruse(self);
    return;
  }
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\mp\rank::getscoreinfovalue("kill");
  var_7 = var_0.team;

  if(isDefined(var_0.isvip) && var_0.isvip) {
    thread vip_endgame(level, game["attackers"]);
    var_1.finalkill = 1;
    return;
  }
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  thread checkallowspectating();
}

function ontimelimit() {
  if(game["status"] == "overtime") {
    var_0 = "forfeit";
  } else if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
    var_0 = "overtime";
  } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
    var_0 = "axis";
  } else {
    var_0 = "allies";
  }

  thread scripts\mp\gamelogic::endgame(var_0, game["end_reason"]["time_limit_reached"]);
}

function checkallowspectating() {
  waitframe();
  var_0 = 0;

  if(!scripts\mp\utility\teams::getteamdata(game["attackers"], "aliveCount")) {
    level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
    var_0 = 1;
  }

  if(!scripts\mp\utility\teams::getteamdata(game["defenders"], "aliveCount")) {
    level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
    var_0 = 1;
  }

  if(var_0) {
    scripts\mp\spectating::updatespectatesettings();
    return;
  }
}

function ondeadevent(var_0) {
  if(var_0 == game["attackers"]) {
    thread vip_endgame(level, game["defenders"]);
    return;
  }

  if(var_0 == game["defenders"]) {
    thread vip_endgame(level, game["attackers"]);
    return;
  }
}

function vip_endgame(var_0, var_1) {
  thread scripts\mp\gamelogic::endgame(var_0, var_1);
}

function extractionzone() {
  var_0 = getEntArray("bombzone", "targetname");
  var_0 = scripts\mp\gametypes\sd::removebombzonec(var_0);
  level.objectives = [];
  var_1 = game["attackers"];

  foreach(var_3 in var_0) {
    var_4 = spawn("script_model", var_3.origin);
    var_4[0].angles = (0, 270, 0);
    var_4[0].team = var_1;
    var_4[0].visibleteam = "any";
    var_4[0].ownerteam = var_1;
    var_4[0].type = "";
    var_5 = spawn("trigger_radius", var_3.origin, 0, 120, 80);
    var_5.team = var_1;
    var_6 = var_5.origin;
    var_7 = scripts\engine\trace::create_contents(0, 1, 1, 0, 0, 1, 1);
    var_8 = [];
    var_9 = scripts\engine\trace::ray_trace(var_4[0].origin + (0, 0, 20), var_4[0].origin - (0, 0, 4000), var_8, var_7, 0);

    if(isPlayer(var_9["entity"])) {
      var_9["entity"] = undefined;
    }

    if(isDefined(var_9)) {
      var_10 = randomfloat(360);
      var_11 = var_9["position"];

      if(isDefined(self.visualgroundoffset)) {
        var_11 += self.visualgroundoffset;
      }

      var_12 = (cos(var_10), sin(var_10), 0);
      var_12 = vectorNormalize(var_12 - var_9["normal"] * vectordot(var_12, var_9["normal"]));
      var_13 = vectortoangles(var_12);
      var_4[0].origin = var_11;
      var_4[0] setModel("cop_marker_scriptable");
      var_4[0] setscriptablepartstate("marker", "red");
      var_4[0] playLoopSound("mp_flare_burn_lp");
    }

    level.flagcapturetime = 0.05;

    if(isDefined(var_5.objectivekey)) {
      var_14 = var_5.objectivekey;
    } else {
      var_14 = var_5.script_label;
    }

    if(isDefined(var_5.iconname)) {
      var_15 = var_5.iconname;
    } else {
      var_15 = var_5.script_label;
    }

    var_5 = scripts\mp\gameobjects::createuseobject(var_1, var_5, var_4, (0, 0, 100));
    var_5.team = var_1;
    var_5.ownerteam = game["defenders"];
    var_5.ownerteamcaps = 1;
    var_5.origin = var_5.curorigin;
    var_5 scripts\mp\gameobjects::allowuse("enemy");
    var_5 scripts\mp\gameobjects::cancontestclaim(1);
    var_5 scripts\mp\gameobjects::setusetime(level.flagcapturetime);
    var_5.onuse = &extractzone_onuse;
    var_5.onbeginuse = &extractzone_onusebegin;
    var_5.onenduse = &extractzone_onuseend;
    var_5.oncontested = &extractzone_oncontested;
    var_5.onuncontested = &extractzone_onuncontested;
    var_5 scripts\mp\gameobjects::pinobjiconontriggertouch();
    var_5.id = "domFlag";
    var_5.extractionactive = 0;
    var_5 scripts\mp\gameobjects::setcapturebehavior("normal");
    var_5.objectivekey = var_14;
    var_5.iconname = var_15;
    var_5 scripts\mp\gameobjects::setvisibleteam("any");
    var_5.stompprogressreward = &extractzone_stompprogressreward;
    var_5.nousebar = 1;
    var_5.id = "domFlag";
    var_5.claimgracetime = level.flagcapturetime * 1000;
    var_5 scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendextract, level.iconcaptureextract);
    waitframe();
  }

  var_17 = getEntArray();

  foreach(var_19 in var_17) {
    var_20 = var_19.script_gameobjectname;

    if(isDefined(var_20)) {
      if(var_20 == "bombzone") {
        var_19 delete();
      }
    }
  }
}

function extractzone_onusebegin(var_0) {
  var_0.iscapturing = 1;
  level.canprocessot = 0;
  var_1 = scripts\mp\gameobjects::getownerteam();
  self.neutralizing = istrue(level.flagneutralization) && var_1 != "neutral";

  if(!istrue(self.neutralized)) {
    self.didstatusnotify = 0;
  }

  if(istrue(level.capturedecay)) {
    thread scripts\mp\gameobjects::useobjectdecay(var_0.team);
  }

  self.prevownerteam = scripts\mp\utility\game::getotherteam(var_0.team)[0];
  scripts\mp\gametypes\obj_dom::updateflagcapturestate(var_0.team);

  if(var_1 == game["attackers"]) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconstoppingextract, level.iconlosingextract);
    return;
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosingextract, level.icontakingextract);
}

function extractzone_onuseend(var_0, var_1, var_2) {
  level.canprocessot = 1;

  if(var_2) {
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  }

  if(isPlayer(var_1)) {
    var_1.iscapturing = 0;
    var_1 setclientomnvar("ui_objective_state", 0);
    var_1.ui_dom_securing = undefined;
  }

  if(!var_2) {
    self.neutralized = 0;
    var_3 = scripts\mp\gameobjects::getownerteam();

    if(var_3 == game["attackers"]) {
      if(self.extractionactive) {
        scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_active_exfil", "icon_waypoint_prevent_exfil");
        return;
      }

      scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_waitfor_exfil", "icon_waypoint_prevent_exfil");
      return;
    }

    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendextract, level.iconcaptureextract);
    return;
  }
}

function extractzone_onuse(var_0) {
  level.canprocessot = 1;
  var_1 = var_0.team;
  var_2 = scripts\mp\gameobjects::getownerteam();
  self.capturetime = gettime();
  self.neutralized = 0;
  extractzone_setcaptured(var_1, var_0);

  if(!self.neutralized) {
    if(isDefined(level.onobjectivecomplete)) {
      [[level.onobjectivecomplete]]("dompoint", self.objectivekey, var_0, var_1, var_2, self);
    }
  }

  if(var_1 == game["attackers"]) {
    playFXOnTag(level._effect["vfx_smk_signal"], self.visuals[0], "tag_origin");
    playannouncerbattlechatter(var_1, "extract_littlebird_start_a_friendly", 20);
    vipextract(var_0, self);
    return;
  }

  stopFXOnTag(level._effect["vfx_smk_signal"], self.visuals[0], "tag_origin");
  self.extractionactive = 0;
}

function extractzone_oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontestingextract);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
}

function extractzone_onuncontested(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();

  if(self.ownerteam == game["attackers"]) {
    if(self.extractionactive) {
      scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_active_exfil", "icon_waypoint_prevent_exfil");
      return;
    }

    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_waitfor_exfil", "icon_waypoint_prevent_exfil");
    return;
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendextract, level.iconcaptureextract);
}

function extractzone_setcaptured(var_0, var_1) {
  scripts\mp\gameobjects::setownerteam(var_0);

  if(self.ownerteam == game["attackers"]) {
    scripts\mp\gameobjects::setusetime(5);
    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_waitfor_exfil", "icon_waypoint_prevent_exfil");
  } else {
    scripts\mp\gameobjects::setusetime(0.05);
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendextract, level.iconcaptureextract);

    foreach(var_3 in self.choppers) {
      var_3 notify("bugOut");
      var_3 notify("esc_littlebird_arrive");
      var_3 scripts\engine\utility::array_remove(self.choppers, var_3);
      self.choppers = [];
      var_3 thread scripts\mp\gametypes\br_extract_chopper::littlebirdleave();
    }

    playannouncerbattlechatter(game["attackers"], "extract_littlebird_leaving_a_friendly", 10);
  }

  self notify("capture", var_1);
  self notify("assault", var_1);
  self.neutralized = 0;

  if(self.touchlist[var_0].size == 0) {
    self.touchlist = self.oldtouchlist;
  }

  thread giveflagcapturexp(self.touchlist[var_0], var_1);
  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "captured_" + var_0);
}

function extractzone_stompprogressreward(var_0) {
  var_0 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
}

function getcapturetype() {
  var_0 = "normal";

  if(level.capturetype == 2) {
    var_0 = "neutralize";
  } else if(level.capturetype == 3) {
    var_0 = "persistent";
  }

  return var_0;
}

function giveflagcapturexp(var_0, var_1) {
  level endon("game_ended");
  var_2 = var_1;

  if(isDefined(var_2.owner)) {
    var_2 = var_2.owner;
  }

  level.lastcaptime = gettime();

  if(isPlayer(var_2)) {
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_securedposition", var_2);
    var_2 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "capture", var_2.origin);
  }

  var_3 = getarraykeys(var_0);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_0[var_3[var_4]].player;

    if(isDefined(var_5.owner)) {
      var_5 = var_5.owner;
    }

    if(!isPlayer(var_5)) {
      continue;
    }

    var_5 scripts\mp\utility\stats::incpersstat("captures", 1);
    var_5 scripts\mp\persistence::statsetchild("round", "captures", var_5.pers["captures"]);
    var_5 scripts\mp\utility\stats::setextrascore0(var_5.pers["captures"]);
    var_5 thread scripts\mp\awards::givemidmatchaward("mode_dom_secure");
    wait 0.05;
  }
}

function vipextract(var_0) {
  if(!isDefined(var_0.choppers)) {
    var_0.choppers = [];
  }

  var_1 = anglesToForward(self getplayerangles(1));
  var_2 = getgroundposition(self getEye() + (0, 0, 60) + var_1 * 80, 60) + (0, 0, 8);
  var_3 = scripts\mp\gametypes\br_extract_chopper::spawnextractchopper(var_0, var_0.origin);
  var_0.choppers[var_0.choppers.size] = var_3;
  self iprintlnbold("Extraction copter en route!");
  var_3.extractzone = var_0;
  var_3.extractteam = self.team;
  var_0.curorigin = var_0.origin;
  var_0.offset3d = (0, 0, 30);
  thread extracttriggerwatcher(var_0);
}

function extracttriggerwatcher(var_0) {
  level endon("game_ended");
  var_0 endon("bugOut");
  var_0 waittill("esc_littlebird_arrive");
  self.extractionactive = 1;
  playannouncerbattlechatter(var_0.extractteam, "extract_littlebird_close_a_friendly", 10);

  if(self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontestingextract);
    goto LOC_0000005c;
  }

  scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_active_exfil", "icon_waypoint_prevent_exfil");

  for(;;) {
    self.trigger waittill("trigger", var_1);

    if(!istrue(self.stalemate)) {
      if(istrue(var_1.isagentvip) && self.numtouching[game["defenders"]] == 0) {
        thread vip_endgame(level, var_1.team);
        break;
      }

      if(var_1.team == self.team && isDefined(var_1.carryobject)) {
        thread vip_endgame(level, var_1.team);
        break;
      }
    }
  }
}

function createthreatbiasgroups() {
  waitframe();
  createthreatbiasgroup("vip");

  foreach(var_1 in level.teamnamelist) {
    createthreatbiasgroup(var_1);
    setignoremegroup(var_1, "vip");
  }
}

function spawnvip() {
  level endon("game_ended");
  wait 2;
  var_0 = getEnt("sd_bomb_pickup_trig", "targetname");
  var_1 = undefined;
  var_2 = undefined;
  level.allowhvtspawn = 1;

  while(!isDefined(var_1)) {
    var_1 = scripts\mp\agents\agent_common::connectnewagent("player", game["attackers"]);

    if(isDefined(var_1)) {
      var_2 = var_0.origin;
      var_0 delete();
      var_1 thread[[var_1 scripts\mp\agents\agent_utility::agentfunc("spawn")]](var_2, (0, 0, 0));
      var_3 = var_1 getnearestnode();
      var_1 setOrigin(var_3.origin);
      var_1.team = game["attackers"];
      var_1 scripts\mp\bots\bots_util::bot_set_difficulty("recruit");
      var_1.outlineid = scripts\mp\utility\outline::outlineenableforteam(var_1, var_1.team, "outline_nodepth_green", "lowest");
      var_1.nocorpse = 1;
      var_1.isdowned = 0;
      var_1.isagentvip = 1;
      var_4 = spawn("script_model", var_1.origin + (0, 0, 30));
      var_4.team = game["attackers"];
      var_4.destination = var_1.origin;
      var_4 linkTo(var_1);
      var_4 scripts\mp\utility\usability::maketeamusable(var_4.team);
      var_4 setHintString(&"MP/HOLD_TO_ESCORT_VIP");
      var_4 setusepriority(-3);
      var_1.trigger = var_4;
      var_1.ownerteam = var_4.team;
      var_1.interactteam = "friendly";
      var_1.requireslos = 1;
      var_1.exclusiveuse = 0;
      var_1.curprogress = 0;
      var_1.usetime = 0;
      var_1.userate = 1;
      var_1.id = "care_package";
      var_1.skiptouching = 1;
      var_1.onuse = &agent_onuse;
      var_1 thread scripts\mp\gameobjects::useobjectusethink();
      var_1.trackedobject = var_1 scripts\mp\gameobjects::createtrackedobject(var_1, (0, 0, 70));
      var_1.trackedobject.objidpingfriendly = 0;
      var_1.trackedobject.objidpingenemy = 0;
      var_1.trackedobject.objpingdelay = 0.05;
      var_1.trackedobject.visibleteam = "friendly";
      var_1.invulnerable = 1;
      var_1.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconescort);
      continue;
    }

    waitframe();
  }

  var_1 setthreatbiasgroup("vip");
  thread hvtclearmove(var_1);
  thread hvtdeathwatcher();
  var_1 takeallweapons();
  waitframe();
  var_1 scripts\cp_mp\utility\inventory_utility::_giveweapon("iw8_fists_mp", undefined, undefined, 1);
  level.vip = var_1;
}

function hvtclearmove(var_0) {
  self botsetscriptgoal(var_0, 20, "critical");
  var_1 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  while(!isDefined(self.tetherplayer)) {
    self botsetflag("disable_movement", 1);
    wait 0.1;
  }
}

function agent_onuse(var_0) {
  scripts\mp\utility\print::printboldonteam("HVT is following " + var_0.name, var_0.team);
  self.following = 1;
  self.usetime = 1000;
  thread followplayer(var_0);
  thread watchownerdeath(var_0);
  self.trigger scripts\mp\utility\usability::maketeamusable(self.team);
  self.trigger disableplayeruse(var_0);
}

function followplayer(var_0) {
  self endon("game_ended");
  self.tetherplayer = var_0;
  level.tetherplayer = var_0;
  self botsetflag("disable_movement", 0);
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_0.team, 11, 12, level.tetherplayer, 9);

  while(isDefined(self.tetherplayer)) {
    var_1 = self.tetherplayer getstance();
    self botsetstance(var_1);

    if(self.tetherplayer issprinting()) {
      self botsetflag("cautious", 0);
      self botsetflag("force_sprint", 1);
    } else {
      self botsetflag("force_sprint", 0);
      self botsetflag("cautious", 1);
    }

    if(distance2dsquared(self.tetherplayer.origin, self.origin) < 10000) {
      level.vipdist = distance2dsquared(self.tetherplayer.origin, self.origin);
    } else if(distance2dsquared(self.tetherplayer.origin, self.origin) > 10000) {
      level.vipdist = distance2dsquared(self.tetherplayer.origin, self.origin);
      var_2 = botgetclosestnavigablepoint(self.tetherplayer.origin, 40, self);

      if(isDefined(var_2)) {
        self botsetpathingstyle("sneak");
        self botsetscriptgoal(var_2, 32, "tactical");
        var_3 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(3);

        if(var_3 == "goal") {}
      }
    }

    wait 0.15;
  }

  level.tetherplayer = undefined;
}

function watchownerdeath(var_0) {
  self endon("game_ended");
  var_0 endon("tether_swap");
  self waittill("death");
  var_0.following = 0;
  var_0.usetime = 0;
  var_0.tetherplayer = undefined;
  level.tetherplayer = undefined;
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_0.team, 10, 12);
}

function hvtdeathwatcher() {
  self endon("game_ended");
  self endon("hvt_timeout");
  self waittill("death");
  self.trackedobject scripts\mp\gameobjects::releaseid();
  self.trigger scripts\mp\utility\usability::setallunusable();
  level.hostages[0] = scripts\mp\tac_ops\hostage_utility::spawnhostage(self.origin, self.team, 1);
  level.hostages[0].outlineid = scripts\mp\utility\outline::outlineenableforteam(level.hostages[0].body, level.hostages[0].team, "outline_nodepth_cyan", "killstreak_personal");
}

function updatematchstatushintonspawn() {
  level endon("game_ended");
  level scripts\mp\flags::gameflagwait("prematch_done");

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(level.vip)) {
    if(isDefined(level.tetherplayer)) {
      if(isDefined(level.tetherplayer.team) && level.tetherplayer.team == self.team) {
        if(level.tetherplayer == self) {
          self setclientomnvar("ui_match_status_hint_text", 9);
          return;
        }

        self setclientomnvar("ui_match_status_hint_text", 11);
        return;
      }

      self setclientomnvar("ui_match_status_hint_text", 12);
      return;
    }

    if(isDefined(self.team) && level.vip.team == self.team) {
      self setclientomnvar("ui_match_status_hint_text", 10);
      return;
    }

    self setclientomnvar("ui_match_status_hint_text", 12);
    return;
  }

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

function votimeendingsoon() {
  level endon("game_ended");
  level waittill("match_ending_very_soon");
  playannouncerbattlechatter(game["attackers"], "extract_littlebird_leaving_soon_a_friendly", 10);
}