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
    var0 = game["attackers"];
    var1 = game["defenders"];
    game["attackers"] = var1;
    game["defenders"] = var0;
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
  var0 = "mp_sd_spawn_defender";

  if(self.pers["team"] == game["attackers"]) {
    var0 = "mp_sd_spawn_attacker";
  }

  var1 = scripts\mp\spawnlogic::getspawnpointarray(var0);
  var2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var1);
  return var2;
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

function onnormaldeath(var0, var1, var2, var3, var4, var5) {
  var6 = scripts\mp\rank::getscoreinfovalue("kill");
  var7 = var0.team;

  if(isDefined(var0.isvip) && var0.isvip) {
    thread vip_endgame(level, game["attackers"]);
    var1.finalkill = 1;
    return;
  }
}

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  thread checkallowspectating();
}

function ontimelimit() {
  if(game["status"] == "overtime") {
    var0 = "forfeit";
  } else if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
    var0 = "overtime";
  } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
    var0 = "axis";
  } else {
    var0 = "allies";
  }

  thread scripts\mp\gamelogic::endgame(var0, game["end_reason"]["time_limit_reached"]);
}

function checkallowspectating() {
  waitframe();
  var0 = 0;

  if(!scripts\mp\utility\teams::getteamdata(game["attackers"], "aliveCount")) {
    level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
    var0 = 1;
  }

  if(!scripts\mp\utility\teams::getteamdata(game["defenders"], "aliveCount")) {
    level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
    var0 = 1;
  }

  if(var0) {
    scripts\mp\spectating::updatespectatesettings();
    return;
  }
}

function ondeadevent(var0) {
  if(var0 == game["attackers"]) {
    thread vip_endgame(level, game["defenders"]);
    return;
  }

  if(var0 == game["defenders"]) {
    thread vip_endgame(level, game["attackers"]);
    return;
  }
}

function vip_endgame(var0, var1) {
  thread scripts\mp\gamelogic::endgame(var0, var1);
}

function extractionzone() {
  var0 = getEntArray("bombzone", "targetname");
  var0 = scripts\mp\gametypes\sd::removebombzonec(var0);
  level.objectives = [];
  var1 = game["attackers"];

  foreach(var3 in var0) {
    var4 = spawn("script_model", var3.origin);
    var4[0].angles = (0, 270, 0);
    var4[0].team = var1;
    var4[0].visibleteam = "any";
    var4[0].ownerteam = var1;
    var4[0].type = "";
    var5 = spawn("trigger_radius", var3.origin, 0, 120, 80);
    var5.team = var1;
    var6 = var5.origin;
    var7 = scripts\engine\trace::create_contents(0, 1, 1, 0, 0, 1, 1);
    var8 = [];
    var9 = scripts\engine\trace::ray_trace(var4[0].origin + (0, 0, 20), var4[0].origin - (0, 0, 4000), var8, var7, 0);

    if(isPlayer(var9["entity"])) {
      var9["entity"] = undefined;
    }

    if(isDefined(var9)) {
      var10 = randomfloat(360);
      var11 = var9["position"];

      if(isDefined(self.visualgroundoffset)) {
        var11 += self.visualgroundoffset;
      }

      var12 = (cos(var10), sin(var10), 0);
      var12 = vectorNormalize(var12 - var9["normal"] * vectordot(var12, var9["normal"]));
      var13 = vectortoangles(var12);
      var4[0].origin = var11;
      var4[0] setModel("cop_marker_scriptable");
      var4[0] setscriptablepartstate("marker", "red");
      var4[0] playLoopSound("mp_flare_burn_lp");
    }

    level.flagcapturetime = 0.05;

    if(isDefined(var5.objectivekey)) {
      var14 = var5.objectivekey;
    } else {
      var14 = var5.script_label;
    }

    if(isDefined(var5.iconname)) {
      var15 = var5.iconname;
    } else {
      var15 = var5.script_label;
    }

    var5 = scripts\mp\gameobjects::createuseobject(var1, var5, var4, (0, 0, 100));
    var5.team = var1;
    var5.ownerteam = game["defenders"];
    var5.ownerteamcaps = 1;
    var5.origin = var5.curorigin;
    var5 scripts\mp\gameobjects::allowuse("enemy");
    var5 scripts\mp\gameobjects::cancontestclaim(1);
    var5 scripts\mp\gameobjects::setusetime(level.flagcapturetime);
    var5.onuse = &extractzone_onuse;
    var5.onbeginuse = &extractzone_onusebegin;
    var5.onenduse = &extractzone_onuseend;
    var5.oncontested = &extractzone_oncontested;
    var5.onuncontested = &extractzone_onuncontested;
    var5 scripts\mp\gameobjects::pinobjiconontriggertouch();
    var5.id = "domFlag";
    var5.extractionactive = 0;
    var5 scripts\mp\gameobjects::setcapturebehavior("normal");
    var5.objectivekey = var14;
    var5.iconname = var15;
    var5 scripts\mp\gameobjects::setvisibleteam("any");
    var5.stompprogressreward = &extractzone_stompprogressreward;
    var5.nousebar = 1;
    var5.id = "domFlag";
    var5.claimgracetime = level.flagcapturetime * 1000;
    var5 scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendextract, level.iconcaptureextract);
    waitframe();
  }

  var17 = getEntArray();

  foreach(var19 in var17) {
    var20 = var19.script_gameobjectname;

    if(isDefined(var20)) {
      if(var20 == "bombzone") {
        var19 delete();
      }
    }
  }
}

function extractzone_onusebegin(var0) {
  var0.iscapturing = 1;
  level.canprocessot = 0;
  var1 = scripts\mp\gameobjects::getownerteam();
  self.neutralizing = istrue(level.flagneutralization) && var1 != "neutral";

  if(!istrue(self.neutralized)) {
    self.didstatusnotify = 0;
  }

  if(istrue(level.capturedecay)) {
    thread scripts\mp\gameobjects::useobjectdecay(var0.team);
  }

  self.prevownerteam = scripts\mp\utility\game::getotherteam(var0.team)[0];
  scripts\mp\gametypes\obj_dom::updateflagcapturestate(var0.team);

  if(var1 == game["attackers"]) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconstoppingextract, level.iconlosingextract);
    return;
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosingextract, level.icontakingextract);
}

function extractzone_onuseend(var0, var1, var2) {
  level.canprocessot = 1;

  if(var2) {
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  }

  if(isPlayer(var1)) {
    var1.iscapturing = 0;
    var1 setclientomnvar("ui_objective_state", 0);
    var1.ui_dom_securing = undefined;
  }

  if(!var2) {
    self.neutralized = 0;
    var3 = scripts\mp\gameobjects::getownerteam();

    if(var3 == game["attackers"]) {
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

function extractzone_onuse(var0) {
  level.canprocessot = 1;
  var1 = var0.team;
  var2 = scripts\mp\gameobjects::getownerteam();
  self.capturetime = gettime();
  self.neutralized = 0;
  extractzone_setcaptured(var1, var0);

  if(!self.neutralized) {
    if(isDefined(level.onobjectivecomplete)) {
      [[level.onobjectivecomplete]]("dompoint", self.objectivekey, var0, var1, var2, self);
    }
  }

  if(var1 == game["attackers"]) {
    playFXOnTag(level._effect["vfx_smk_signal"], self.visuals[0], "tag_origin");
    playannouncerbattlechatter(var1, "extract_littlebird_start_a_friendly", 20);
    vipextract(var0, self);
    return;
  }

  stopFXOnTag(level._effect["vfx_smk_signal"], self.visuals[0], "tag_origin");
  self.extractionactive = 0;
}

function extractzone_oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontestingextract);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
}

function extractzone_onuncontested(var0) {
  var1 = scripts\mp\gameobjects::getownerteam();

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

function extractzone_setcaptured(var0, var1) {
  scripts\mp\gameobjects::setownerteam(var0);

  if(self.ownerteam == game["attackers"]) {
    scripts\mp\gameobjects::setusetime(5);
    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_waitfor_exfil", "icon_waypoint_prevent_exfil");
  } else {
    scripts\mp\gameobjects::setusetime(0.05);
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendextract, level.iconcaptureextract);

    foreach(var3 in self.choppers) {
      var3 notify("bugOut");
      var3 notify("esc_littlebird_arrive");
      var3 scripts\engine\utility::array_remove(self.choppers, var3);
      self.choppers = [];
      var3 thread scripts\mp\gametypes\br_extract_chopper::littlebirdleave();
    }

    playannouncerbattlechatter(game["attackers"], "extract_littlebird_leaving_a_friendly", 10);
  }

  self notify("capture", var1);
  self notify("assault", var1);
  self.neutralized = 0;

  if(self.touchlist[var0].size == 0) {
    self.touchlist = self.oldtouchlist;
  }

  thread giveflagcapturexp(self.touchlist[var0], var1);
  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "captured_" + var0);
}

function extractzone_stompprogressreward(var0) {
  var0 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
}

function getcapturetype() {
  var0 = "normal";

  if(level.capturetype == 2) {
    var0 = "neutralize";
  } else if(level.capturetype == 3) {
    var0 = "persistent";
  }

  return var0;
}

function giveflagcapturexp(var0, var1) {
  level endon("game_ended");
  var2 = var1;

  if(isDefined(var2.owner)) {
    var2 = var2.owner;
  }

  level.lastcaptime = gettime();

  if(isPlayer(var2)) {
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_securedposition", var2);
    var2 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "capture", var2.origin);
  }

  var3 = getarraykeys(var0);

  for(var4 = 0; var4 < var3.size; var4++) {
    var5 = var0[var3[var4]].player;

    if(isDefined(var5.owner)) {
      var5 = var5.owner;
    }

    if(!isPlayer(var5)) {
      continue;
    }

    var5 scripts\mp\utility\stats::incpersstat("captures", 1);
    var5 scripts\mp\persistence::statsetchild("round", "captures", var5.pers["captures"]);
    var5 scripts\mp\utility\stats::setextrascore0(var5.pers["captures"]);
    var5 thread scripts\mp\awards::givemidmatchaward("mode_dom_secure");
    wait 0.05;
  }
}

function vipextract(var0) {
  if(!isDefined(var0.choppers)) {
    var0.choppers = [];
  }

  var1 = anglesToForward(self getplayerangles(1));
  var2 = getgroundposition(self getEye() + (0, 0, 60) + var1 * 80, 60) + (0, 0, 8);
  var3 = scripts\mp\gametypes\br_extract_chopper::spawnextractchopper(var0, var0.origin);
  var0.choppers[var0.choppers.size] = var3;
  self iprintlnbold("Extraction copter en route!");
  var3.extractzone = var0;
  var3.extractteam = self.team;
  var0.curorigin = var0.origin;
  var0.offset3d = (0, 0, 30);
  thread extracttriggerwatcher(var0);
}

function extracttriggerwatcher(var0) {
  level endon("game_ended");
  var0 endon("bugOut");
  var0 waittill("esc_littlebird_arrive");
  self.extractionactive = 1;
  playannouncerbattlechatter(var0.extractteam, "extract_littlebird_close_a_friendly", 10);

  if(self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontestingextract);
    goto LOC_0000005c;
  }

  scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_active_exfil", "icon_waypoint_prevent_exfil");

  for(;;) {
    self.trigger waittill("trigger", var1);

    if(!istrue(self.stalemate)) {
      if(istrue(var1.isagentvip) && self.numtouching[game["defenders"]] == 0) {
        thread vip_endgame(level, var1.team);
        break;
      }

      if(var1.team == self.team && isDefined(var1.carryobject)) {
        thread vip_endgame(level, var1.team);
        break;
      }
    }
  }
}

function createthreatbiasgroups() {
  waitframe();
  createthreatbiasgroup("vip");

  foreach(var1 in level.teamnamelist) {
    createthreatbiasgroup(var1);
    setignoremegroup(var1, "vip");
  }
}

function spawnvip() {
  level endon("game_ended");
  wait 2;
  var0 = getEnt("sd_bomb_pickup_trig", "targetname");
  var1 = undefined;
  var2 = undefined;
  level.allowhvtspawn = 1;

  while(!isDefined(var1)) {
    var1 = scripts\mp\agents\agent_common::connectnewagent("player", game["attackers"]);

    if(isDefined(var1)) {
      var2 = var0.origin;
      var0 delete();
      var1 thread[[var1 scripts\mp\agents\agent_utility::agentfunc("spawn")]](var2, (0, 0, 0));
      var3 = var1 getnearestnode();
      var1 setOrigin(var3.origin);
      var1.team = game["attackers"];
      var1 scripts\mp\bots\bots_util::bot_set_difficulty("recruit");
      var1.outlineid = scripts\mp\utility\outline::outlineenableforteam(var1, var1.team, "outline_nodepth_green", "lowest");
      var1.nocorpse = 1;
      var1.isdowned = 0;
      var1.isagentvip = 1;
      var4 = spawn("script_model", var1.origin + (0, 0, 30));
      var4.team = game["attackers"];
      var4.destination = var1.origin;
      var4 linkTo(var1);
      var4 scripts\mp\utility\usability::maketeamusable(var4.team);
      var4 setHintString(&"MP/HOLD_TO_ESCORT_VIP");
      var4 setusepriority(-3);
      var1.trigger = var4;
      var1.ownerteam = var4.team;
      var1.interactteam = "friendly";
      var1.requireslos = 1;
      var1.exclusiveuse = 0;
      var1.curprogress = 0;
      var1.usetime = 0;
      var1.userate = 1;
      var1.id = "care_package";
      var1.skiptouching = 1;
      var1.onuse = &agent_onuse;
      var1 thread scripts\mp\gameobjects::useobjectusethink();
      var1.trackedobject = var1 scripts\mp\gameobjects::createtrackedobject(var1, (0, 0, 70));
      var1.trackedobject.objidpingfriendly = 0;
      var1.trackedobject.objidpingenemy = 0;
      var1.trackedobject.objpingdelay = 0.05;
      var1.trackedobject.visibleteam = "friendly";
      var1.invulnerable = 1;
      var1.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconescort);
      continue;
    }

    waitframe();
  }

  var1 setthreatbiasgroup("vip");
  thread hvtclearmove(var1);
  thread hvtdeathwatcher();
  var1 takeallweapons();
  waitframe();
  var1 scripts\cp_mp\utility\inventory_utility::_giveweapon("iw8_fists_mp", undefined, undefined, 1);
  level.vip = var1;
}

function hvtclearmove(var0) {
  self botsetscriptgoal(var0, 20, "critical");
  var1 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  while(!isDefined(self.tetherplayer)) {
    self botsetflag("disable_movement", 1);
    wait 0.1;
  }
}

function agent_onuse(var0) {
  scripts\mp\utility\print::printboldonteam("HVT is following " + var0.name, var0.team);
  self.following = 1;
  self.usetime = 1000;
  thread followplayer(var0);
  thread watchownerdeath(var0);
  self.trigger scripts\mp\utility\usability::maketeamusable(self.team);
  self.trigger disableplayeruse(var0);
}

function followplayer(var0) {
  self endon("game_ended");
  self.tetherplayer = var0;
  level.tetherplayer = var0;
  self botsetflag("disable_movement", 0);
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var0.team, 11, 12, level.tetherplayer, 9);

  while(isDefined(self.tetherplayer)) {
    var1 = self.tetherplayer getstance();
    self botsetstance(var1);

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
      var2 = botgetclosestnavigablepoint(self.tetherplayer.origin, 40, self);

      if(isDefined(var2)) {
        self botsetpathingstyle("sneak");
        self botsetscriptgoal(var2, 32, "tactical");
        var3 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(3);

        if(var3 == "goal") {}
      }
    }

    wait 0.15;
  }

  level.tetherplayer = undefined;
}

function watchownerdeath(var0) {
  self endon("game_ended");
  var0 endon("tether_swap");
  self waittill("death");
  var0.following = 0;
  var0.usetime = 0;
  var0.tetherplayer = undefined;
  level.tetherplayer = undefined;
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var0.team, 10, 12);
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

function votimeendingsoon() {
  level endon("game_ended");
  level waittill("match_ending_very_soon");
  playannouncerbattlechatter(game["attackers"], "extract_littlebird_leaving_soon_a_friendly", 10);
}