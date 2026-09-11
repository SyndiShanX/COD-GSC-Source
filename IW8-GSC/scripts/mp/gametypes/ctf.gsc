/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\ctf.gsc
***********************************************/

function main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  flag_default_origins();
  GscBinSkip1(0x45, 0, "ctf");
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_ctf_winRule", getmatchrulesdata("ctfData", "winRule"));
  setdynamicdvar("scr_ctf_captureCondition", getmatchrulesdata("ctfData", "captureCondition"));
  setdynamicdvar("scr_ctf_returnTime", getmatchrulesdata("ctfData", "returnTime"));
  setdynamicdvar("scr_ctf_showEnemyCarrier", getmatchrulesdata("carryData", "showEnemyCarrier"));
  setdynamicdvar("scr_ctf_idleResetTime", getmatchrulesdata("carryData", "idleResetTime"));
  setdynamicdvar("scr_ctf_pickupTime", getmatchrulesdata("carryData", "pickupTime"));
  setdynamicdvar("scr_ctf_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("ctf", 0);
}

function onspawnplayer() {
  ref_13ffa();
}

function onstartgametype() {
  var_0 = scripts\mp\utility\game::inovertime();
  var_1 = game["overtimeRoundsPlayed"] == 0;
  var_2 = scripts\mp\utility\game::istimetobeatvalid();

  if(var_0) {
    if(var_1) {
      setomnvar("ui_round_hint_override_attackers", 1);
      setomnvar("ui_round_hint_override_defenders", 1);
    } else if(var_2) {
      setomnvar("ui_round_hint_override_attackers", scripts\engine\utility::ter_op(game["timeToBeatTeam"] == game["attackers"], 2, 3));
      setomnvar("ui_round_hint_override_defenders", scripts\engine\utility::ter_op(game["timeToBeatTeam"] == game["defenders"], 2, 3));
    } else {
      setomnvar("ui_round_hint_override_attackers", 4);
      setomnvar("ui_round_hint_override_defenders", 4);
    }
  }

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(scripts\mp\utility\game::inovertime()) {
    setDvar("ui_override_halftime", 0);
  } else if(game["switchedsides"]) {
    setDvar("ui_override_halftime", 2);
  } else {
    setDvar("ui_override_halftime", 1);
  }

  if(!isDefined(game["original_defenders"])) {
    game["original_defenders"] = game["defenders"];
  }

  if(game["switchedsides"]) {
    var_3 = game["attackers"];
    var_4 = game["defenders"];
    game["attackers"] = var_4;
    game["defenders"] = var_3;
  }

  setclientnamemode("auto_change");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER");
    scripts\mp\utility\game::setobjectivescoretext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER");
  } else {
    scripts\mp\utility\game::setobjectivescoretext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER_SCORE");
    scripts\mp\utility\game::setobjectivescoretext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER_SCORE");
  }

  scripts\mp\utility\game::setobjectivetext(game["attackers"], &"OBJECTIVES/CTF");
  scripts\mp\utility\game::setobjectivetext(game["defenders"], &"OBJECTIVES/CTF");
  scripts\mp\utility\game::setobjectivehinttext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER_HINT");
  scripts\mp\utility\game::setobjectivehinttext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER_HINT");
  flag_setupvfx();
  createflagsandhud();
  initspawns();
  thread removeflag();
  thread placeflag();
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.winrule = scripts\mp\utility\dvars::dvarintvalue("winRule", 0, 0, 1);
  level.showenemycarrier = scripts\mp\utility\dvars::dvarintvalue("showEnemyCarrier", 5, 0, 6);
  level.idleresettime = scripts\mp\utility\dvars::dvarfloatvalue("idleResetTime", 30, 0, 60);
  level.capturecondition = scripts\mp\utility\dvars::dvarintvalue("captureCondition", 0, 0, 1);
  level.pickuptime = scripts\mp\utility\dvars::dvarfloatvalue("pickupTime", 0, 0, 10);
  level.returntime = scripts\mp\utility\dvars::dvarfloatvalue("returnTime", 0, -1, 25);
}

function createflagsandhud() {
  level.flagmodel["allies"] = "ctf_game_flag_west";
  level.flagbase["allies"] = "ctf_game_flag_base";
  level.carryflag["allies"] = "prop_ctf_game_flag_west";
  level.flagmodel["axis"] = "ctf_game_flag_east";
  level.flagbase["axis"] = "ctf_game_flag_base";
  level.carryflag["axis"] = "prop_ctf_game_flag_east";
  level.closecapturekiller = [];
  level.closecapturekiller["allies"] = undefined;
  level.closecapturekiller["axis"] = undefined;
  setupwaypointicons();
  level.iconescort = "waypoint_escort_flag";
  level.iconkill = "waypoint_ctf_kill";
  level.iconcaptureflag = "waypoint_take_flag";
  level.icondefendflag = "waypoint_defend_flag";
  level.iconreturnflag = "waypoint_recover_flag";
  level.ref_11c5f = "waypoint_mlg_empty_flag";
  level.ref_11c60 = "waypoint_mlg_full_flag";
  level.teamflags[game["defenders"]] = createteamflag(game["defenders"], "axis");
  level.teamflags[game["attackers"]] = createteamflag(game["attackers"], "allies");
  level.capzones[game["defenders"]] = createcapzone(game["defenders"], "axis");
  level.capzones[game["attackers"]] = createcapzone(game["attackers"], "allies");
  scripts\mp\objidpoolmanager::ref_11f84(level.capzones[game["defenders"]].objidnum, 1);
  scripts\mp\objidpoolmanager::ref_11f84(level.capzones[game["attackers"]].objidnum, 1);
}

function flag_setupvfx() {}

function initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("AwayFromEnemies", "Crit_Default");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_ctf_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_ctf_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_ctf_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_ctf_spawn_axis_start");
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_ctf_spawn_allies_start");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_ctf_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", var_0);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", var_1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_ctf_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_ctf_spawn");
  assignteamspawns();
  level.ctfteamspawnsetids["allies"] = "allies";
  level.ctfteamspawnsetids["axis"] = "axis";
  scripts\mp\spawnlogic::registerspawnset("allies", level.teamspawnpoints["allies"]);
  scripts\mp\spawnlogic::registerspawnset("axis", level.teamspawnpoints["axis"]);
  scripts\mp\spawnlogic::registerspawnset("neutral", level.teamspawnpoints["neutral"]);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function assignteamspawns() {
  var_0 = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype);
  var_1 = scripts\mp\spawnlogic::ispathdataavailable();
  level.teamspawnpoints["axis"] = [];
  level.teamspawnpoints["allies"] = [];
  level.teamspawnpoints["neutral"] = [];
  jumpiffalse(level.teamflags.size == 2) LOC_0000022e;
  var_2 = level.teamflags["allies"];
  var_3 = level.teamflags["axis"];
  var_4 = (var_2.curorigin[0], var_2.curorigin[1], 0);
  var_5 = (var_3.curorigin[0], var_3.curorigin[1], 0);
  var_6 = var_5 - var_4;
  var_7 = length2d(var_6);

  foreach(var_9 in var_0) {
    var_10 = (var_9.origin[0], var_9.origin[1], 0);
    var_11 = var_10 - var_4;
    var_12 = vectordot(var_11, var_6);
    var_13 = var_12 / var_7 * var_7;

    if(var_13 < 0.33) {
      var_9.teambase = scripts\mp\utility\game::getotherteam(var_2.ownerteam)[0];
      level.teamspawnpoints[var_9.teambase][level.teamspawnpoints[var_9.teambase].size] = var_9;
      continue;
    }

    if(var_13 > 0.67) {
      var_9.teambase = scripts\mp\utility\game::getotherteam(var_3.ownerteam)[0];
      level.teamspawnpoints[var_9.teambase][level.teamspawnpoints[var_9.teambase].size] = var_9;
      continue;
    }

    var_14 = undefined;
    var_15 = undefined;

    if(var_1) {
      var_14 = getpathdist(var_9.origin, var_2.curorigin, 999999);
    }

    if(isDefined(var_14) && var_14 != -1) {
      var_15 = getpathdist(var_9.origin, var_3.curorigin, 999999);
    }

    if(!isDefined(var_15) || var_15 == -1) {
      var_14 = distance2d(var_2.curorigin, var_9.origin);
      var_15 = distance2d(var_3.curorigin, var_9.origin);
    }

    var_16 = max(var_14, var_15);
    var_17 = min(var_14, var_15);
    var_18 = var_17 / var_16;

    if(var_18 > 0.5) {
      level.teamspawnpoints["neutral"][level.teamspawnpoints["neutral"].size] = var_9;
    }
  }

  return;
}

function getnearestflagteam(var_0) {
  var_1 = scripts\mp\spawnlogic::ispathdataavailable();
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in level.teamflags) {
    var_6 = undefined;

    if(var_1) {
      var_6 = getpathdist(var_0.origin, var_5.curorigin, 999999);
    }

    if(!isDefined(var_6) || var_6 == -1) {
      var_6 = distancesquared(var_5.curorigin, var_0.origin);
    }

    if(!isDefined(var_2) || var_6 < var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  return scripts\mp\utility\game::getotherteam(var_2.ownerteam)[0];
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
    var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_1, level.ctfteamspawnsetids[var_1], "neutral");
  }

  return var_1;
}

function flag_default_origins() {
  level.default_goal_origins = [];
  level.flags = getEntArray("flag_primary", "targetname");

  if(!isDefined(game["attackers"])) {
    game["attackers"] = "allies";
  }

  if(!isDefined(game["defenders"])) {
    game["defenders"] = "axis";
  }

  foreach(var_1 in level.flags) {
    switch (var_1.script_label) {
      case "_a":
        level.default_flag_origins[game["attackers"]] = var_1.origin;
        break;
      case "_c":
        level.default_flag_origins[game["defenders"]] = var_1.origin;
        break;
    }
  }
}

function flag_create_team_goal(var_0) {
  var_1 = spawnStruct();

  switch (level.script) {
    default:
      break;
  }

  if(!isDefined(var_1.origin)) {
    var_1.origin = level.default_flag_origins[var_0];
  }

  flag_find_ground(var_1);
  var_1.origin = var_1.ground_origin;
  var_1.radius = 30;
  var_1.team = var_0;
  var_1.ball_in_goal = 0;
  var_1.highestspawndistratio = 0;
  return var_1;
}

function flag_find_ground(var_0) {
  var_1 = self.origin + (0, 0, 32);
  var_2 = self.origin + (0, 0, -1000);
  var_3 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_4 = [];
  var_5 = scripts\engine\trace::ray_trace(var_1, var_2, var_4, var_3);
  self.ground_origin = var_5["position"];
  return var_5["fraction"] != 0 && var_5["fraction"] != 1;
}

function showflagradiuseffecttoplayers(var_0, var_1, var_2) {
  if(isDefined(var_1._flagradiuseffect[var_0])) {
    var_1._flagradiuseffect[var_0] delete();
  }

  var_3 = undefined;
  var_4 = var_1.team;
  var_5 = var_1 ismlgspectator();

  if(var_5) {
    var_4 = var_1 getmlgspectatorteam();
  } else if(var_4 == "spectator") {
    var_4 = "allies";
  }

  if(var_4 == var_0) {
    var_6 = spawnfxforclient(level.flagradiusfxid["friendly"], var_2, var_1, (0, 0, 1));
    var_6 setfxkilldefondelete();
  } else {
    var_6 = spawnfxforclient(level.flagradiusfxid["enemy"], var_3, var_2, (0, 0, 1));
    var_6 setfxkilldefondelete();
  }

  var_2._flagradiuseffect[var_1] = var_6;
  triggerfx(var_6);
}

function showbaseeffecttoplayer(var_0, var_1) {
  if(isDefined(var_1._flageffect[var_0])) {
    var_1._flageffect[var_0] delete();
  }

  var_2 = undefined;
  var_3 = var_1.team;
  var_4 = var_1 ismlgspectator();

  if(var_4) {
    var_3 = var_1 getmlgspectatorteam();
  } else if(var_3 == "spectator") {
    var_3 = "allies";
  }

  if(var_3 == var_0) {
    var_5 = spawnfxforclient(level.flagbaseglowfxid["friendly"], self.origin, var_1, self.baseeffectforward);
    var_5 setfxkilldefondelete();
  } else {
    var_5 = spawnfxforclient(level.flagbaseglowfxid["enemy"], self.origin, var_2, self.baseeffectforward);
    var_5 setfxkilldefondelete();
  }

  var_2._flageffect[var_1] = var_5;
  triggerfx(var_5);
}

function removeflagpickupradiuseffect(var_0) {
  if(var_0 == self.team) {
    if(isDefined(self._flagradiuseffect[self.team])) {
      self._flagradiuseffect[self.team] delete();
      return;
    }

    return;
  }

  if(isDefined(self._flagradiuseffect[scripts\mp\utility\game::getotherteam(self.team)[0]])) {
    self._flagradiuseffect[scripts\mp\utility\game::getotherteam(self.team)[0]] delete();
    return;
  }
}

function setteaminhuddatafromteamname(var_0) {
  if(var_0 == "axis") {
    self setteaminhuddata(1);
    return;
  }

  if(var_0 == "allies") {
    self setteaminhuddata(2);
    return;
  }

  self setteaminhuddata(0);
}

function player_delete_flag_goal_fx(var_0) {
  if(var_0 == self.team) {
    if(isDefined(self._flageffect[self.team])) {
      self._flageffect[self.team] delete();
      return;
    }

    return;
  }

  if(isDefined(self._flageffect[scripts\mp\utility\game::getotherteam(self.team)[0]])) {
    self._flageffect[scripts\mp\utility\game::getotherteam(self.team)[0]] delete();
    return;
  }
}

function getflagpos(var_0) {
  var_1 = getEnt("ctf_flag_" + var_0, "targetname");
  return var_1.origin;
}

function createteamflag(var_0, var_1) {
  var_2 = 0;
  var_3 = getEnt("ctf_zone_" + var_1, "targetname");

  if(!isDefined(var_3)) {
    var_4 = flag_create_team_goal(var_0);
    var_3 = spawn("trigger_radius", var_4.origin - (0, 0, var_4.radius / 2), 0, var_4.radius, 80);
    var_3.no_moving_platfrom_unlink = 1;
    var_3.linktoenabledflag = 1;
    var_3.baseorigin = var_3.origin;
    var_2 = 1;
    var_5 = spawn("script_model", var_4.origin);
    var_5[0] setasgametypeobjective();
    setteaminhuddatafromteamname(var_5[0], var_1);
  } else {
    GscBinSkip1(0x45, 0, getEnt("ctf_flag_" + var_2, "targetname"));
  }

  if(isDefined(var_5[0])) {}

  if(!var_2) {
    var_6 = 15;

    if(level.pickuptime > 0 || level.returntime > 0) {
      var_6 *= 2;
    }

    var_7 = spawn("trigger_radius", var_3.origin, 0, var_6, var_3.height);
    var_3 = var_7;
  }

  if(level.mapname == "mp_m_speedball") {
    flag_find_ground(var_3);
    var_3.origin = var_3.ground_origin;
    var_5[0].origin = var_3.ground_origin - (0, 0, 0.5);
  }

  var_5[0] setModel(level.flagmodel[var_0]);
  var_5[0] setasgametypeobjective();
  setteaminhuddatafromteamname(var_5[0], var_1);
  var_8 = scripts\mp\utility\game::getotherteam(var_0)[0];
  var_9 = scripts\mp\gameobjects::createcarryobject(var_8, var_3, var_5, (0, 0, 85));
  var_9 scripts\mp\gameobjects::allowcarry("friendly");
  var_9 scripts\mp\gameobjects::setteamusetime("friendly", level.pickuptime);
  var_9 scripts\mp\gameobjects::setteamusetime("enemy", level.returntime);
  var_9 scripts\mp\gameobjects::setvisibleteam("none");
  var_9 scripts\mp\gameobjects::ref_1317f(level.iconescort, level.iconkill, level.ref_11c60);
  var_9 scripts\mp\objidpoolmanager::objective_set_play_intro(var_9.objidnum, 0);
  var_9 scripts\mp\objidpoolmanager::objective_set_play_outro(var_9.objidnum, 0);
  var_9 scripts\mp\gameobjects::ref_12b13(&player_infil_already_played);
  var_9.allowweapons = 1;
  var_9.ref_1214b = var_8;
  var_9.onpickup = &onpickup;
  var_9.onpickupfailed = &onpickup;
  var_9.ondrop = &ondrop;
  var_9.onreset = &onreset;
  var_9.tv_station_gas_rise = 1;

  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        var_9.objidpingfriendly = 1;
        var_9.objidpingenemy = 0;
        var_9.objpingdelay = 60;
        break;
      case 1:
        var_9.objidpingfriendly = 0;
        var_9.objidpingenemy = 0;
        var_9.objpingdelay = 0.05;
        break;
      case 2:
        var_9.objidpingfriendly = 1;
        var_9.objidpingenemy = 0;
        var_9.objpingdelay = 1;
        break;
      case 3:
        var_9.objidpingfriendly = 1;
        var_9.objidpingenemy = 0;
        var_9.objpingdelay = 1.5;
        break;
      case 4:
        var_9.objidpingfriendly = 1;
        var_9.objidpingenemy = 0;
        var_9.objpingdelay = 2;
        break;
      case 5:
        var_9.objidpingfriendly = 1;
        var_9.objidpingenemy = 0;
        var_9.objpingdelay = 3;
        break;
      case 6:
        var_9.objidpingfriendly = 1;
        var_9.objidpingenemy = 0;
        var_9.objpingdelay = 4;
        break;
    }

    var_10 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
    var_9.pingobjidnum = var_10;
    scripts\mp\objidpoolmanager::objective_add_objective(var_10, "done", var_9.origin);
    scripts\mp\objidpoolmanager::objective_set_play_intro(var_10, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(var_10, 0);
    var_9 scripts\mp\gameobjects::setvisibleteam("none", var_10);
    objective_setownerteam(var_10, var_0);
    var_9 scripts\mp\gameobjects::ref_1317f(level.iconescort, level.iconkill, level.ref_11c60, var_10);
  } else {
    var_9.objidpingfriendly = 1;
    var_9.objidpingenemy = 0;
    var_9.objpingdelay = 3;
  }

  var_9.oldradius = var_3.radius;
  var_11 = var_3.origin + (0, 0, 32);
  var_12 = var_3.origin + (0, 0, -32);
  var_13 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_14 = [];
  var_15 = scripts\engine\trace::ray_trace(var_11, var_12, var_14, var_13);
  var_9.baseeffectpos = var_9.visuals[0].origin;
  var_16 = anglestoup(var_9.visuals[0].angles);
  var_9.baseeffectforward = anglesToForward(var_16);
  level.teamflagbases[var_0] = createteamflagbase(var_0, var_9);
  return var_9;
}

function player_infil_already_played(var_0) {
  return !var_0 scripts\cp_mp\utility\player_utility::isinvehicle();
}

function createteamflagbase(var_0, var_1) {
  var_2 = var_1.visuals[0].origin;
  var_3 = spawn("script_model", var_2);
  var_3 setModel(level.flagbase[var_0]);
  var_3.ownerteam = var_0;
  var_3 setasgametypeobjective();
  setteaminhuddatafromteamname(var_3, var_0);
  var_3.baseeffectpos = var_2;
  var_4 = anglestoup(var_1.visuals[0].angles);
  var_3.baseeffectforward = anglesToForward(var_4);
  return var_3;
}

function createcapzone(var_0, var_1) {
  var_2 = flag_create_team_goal(var_0);
  var_3 = getEnt("ctf_zone_" + var_1, "targetname");

  if(!isDefined(var_3)) {
    var_3 = spawn("trigger_radius", var_2.origin - (0, 0, var_2.radius / 2), 0, var_2.radius, 80);
    var_3.no_moving_platfrom_unlink = 1;
    var_3.linktoenabledflag = 1;
    var_3.baseorigin = var_3.origin;
    var_3.height = 80;
  }

  var_4 = spawn("trigger_radius", var_3.origin, 0, 15, var_3.height);
  var_3 = var_4;
  var_5 = [];
  var_6 = scripts\mp\gameobjects::createuseobject(var_0, var_3, var_5, (0, 0, 85));
  var_6 scripts\mp\gameobjects::allowuse("friendly");
  var_6 scripts\mp\gameobjects::setvisibleteam("any");
  var_6 scripts\mp\gameobjects::ref_1317f(level.icondefendflag, level.iconcaptureflag, level.ref_11c60);
  var_6 scripts\mp\gameobjects::setusetime(0);
  var_6 scripts\mp\gameobjects::setkeyobject(level.teamflags[scripts\mp\utility\game::getotherteam(var_0)[0]]);
  var_6.onuse = &onuse;
  var_6.oncantuse = &oncantuse;
  var_7 = var_3.origin + (0, 0, 32);
  var_8 = var_3.origin + (0, 0, -32);
  var_9 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_10 = [];
  var_11 = scripts\engine\trace::ray_trace(var_7, var_8, var_10, var_9);
  var_12 = vectortoangles(var_11["normal"]);
  var_13 = anglesToForward(var_12);
  var_14 = anglestoright(var_12);
  return var_6;
}

function onbeginuse(var_0) {
  var_1 = var_0.pers["team"];

  if(var_1 == scripts\mp\gameobjects::getownerteam()) {
    self.trigger.radius = 1024;
    return;
  }

  self.trigger.radius = self.oldradius;
}

function onenduse(var_0, var_1, var_2) {
  self.trigger.radius = self.oldradius;
}

function onpickup(var_0, var_1, var_2) {
  self notify("picked_up");
  var_0 notify("obj_picked_up");
  var_3 = scripts\mp\gameobjects::getownerteam();

  if(isDefined(self.droppedteam)) {
    if(self.droppedteam == var_0.team) {
      scripts\mp\gameobjects::setownerteam(self.droppedteam);
      var_3 = self.droppedteam;
    } else {
      scripts\mp\gameobjects::setownerteam(scripts\mp\utility\game::getotherteam(var_0.team)[0]);
      var_3 = self.droppedteam;
    }

    self.droppedteam = undefined;
  }

  var_4 = var_0.pers["team"];

  if(var_4 == "allies") {
    var_5 = "axis";
  } else {
    var_5 = "allies";
  }

  if(var_5 != var_4) {
    if(isDefined(level.closecapturekiller[var_1.team]) && level.closecapturekiller[var_1.team] == var_1) {
      var_1 thread scripts\mp\awards::givemidmatchaward("mode_ctf_nope");
    }

    level.closecapturekiller[var_1.team] = undefined;
    var_1 thread scripts\mp\utility\points::giveunifiedpoints("flag_return");

    if(level.codcasterenabled) {
      level.capzones[var_1.team] scripts\mp\gameobjects::ref_12c75();
    }

    thread returnflag();
    var_1 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "obj_return", var_1.origin);
    scripts\mp\utility\print::printandsoundoneveryone(var_5, scripts\mp\utility\game::getotherteam(var_5)[0], undefined, undefined, "mp_obj_returned", "mp_obj_returned", var_1);
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_returned", var_5, "status");
    scripts\mp\utility\dialog::leaderdialog("flag_returned", var_5, "status");
    scripts\mp\utility\game::setmlgannouncement(18, var_1.team, var_1 getentitynumber());
    var_1 scripts\mp\utility\stats::incpersstat("returns", 1);
    var_1 scripts\mp\persistence::statsetchild("round", "returns", var_1.pers["returns"]);

    if(isPlayer(var_1)) {
      var_1 scripts\mp\utility\stats::setextrascore1(var_1.pers["returns"]);
    }

    if(self.ref_1214b == "allies") {
      setomnvar("ui_ctf_flag_axis", -2);
      return;
    }

    setomnvar("ui_ctf_flag_allies", -2);
    return;
  }

  if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[var_5])) {
    thread applyflagcarrierclass();
  } else {
    attachflag(var_1);
  }

  var_1 scripts\mp\utility\stats::incpersstat("pickups", 1);
  level.closecapturekiller[var_5] = undefined;

  if(self.ref_1214b == "allies") {
    setomnvar("ui_ctf_flag_axis", var_1 getentitynumber());
  } else {
    setomnvar("ui_ctf_flag_allies", var_1 getentitynumber());
  }

  var_1 setclientomnvar("ui_ctf_flag_carrier", 1);

  if(isDefined(level.showenemycarrier)) {
    if(level.showenemycarrier == 0) {
      scripts\mp\gameobjects::setvisibleteam("none");
    } else {
      scripts\mp\gameobjects::setvisibleteam("friendly");
      objective_state(self.pingobjidnum, "current");
      scripts\mp\gameobjects::updatecompassicon("enemy", self.pingobjidnum);
      objective_icon(self.pingobjidnum, "icon_waypoint_kill");
      scripts\mp\objidpoolmanager::ref_11f7d(self.pingobjidnum, 1);
    }
  }

  scripts\mp\gameobjects::ref_1317f(level.iconescort, level.iconkill, level.ref_11c60);

  if(level.capturecondition == 0) {
    level.capzones[var_5] scripts\mp\gameobjects::allowuse("none");
  }

  level.capzones[var_5] scripts\mp\gameobjects::setvisibleteam("none");
  level.capzones[var_5] scripts\mp\gameobjects::ref_13172(level.ref_11c5f);
  scripts\mp\utility\print::printandsoundoneveryone(var_5, var_5, undefined, undefined, "mp_obj_taken", "mp_enemy_obj_taken", var_1);
  scripts\mp\utility\dialog::leaderdialog("enemy_flag_taken", var_5);
  scripts\mp\utility\dialog::leaderdialog("flag_getback", var_5);
  thread scripts\mp\hud_util::teamplayercardsplash("callout_flagpickup", var_1);

  if(!isDefined(self.previouscarrier) || self.previouscarrier != var_1) {
    var_1 thread scripts\mp\utility\points::giveunifiedpoints("flag_grab");
  }

  var_1 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "pickup", var_1.origin);
  self.previouscarrier = var_1;

  if(level.codcasterenabled) {
    var_1 setgametypevip(1);
  }

  thread superabilitywatcher();
}

function onpickupfailed(var_0) {}

function returnflag() {
  scripts\mp\gameobjects::returnhome();
}

function ondrop(var_0) {
  if(isDefined(var_0.leaving_team)) {
    self.droppedteam = var_0.leaving_team;
    var_0.leaving_team = undefined;
  } else if(!isDefined(var_0)) {
    self.droppedteam = self.ref_1214b;
  } else {
    self.droppedteam = var_0.team;
  }

  if(isDefined(var_0)) {
    ref_13ffa(var_0);
  }

  scripts\mp\gameobjects::setownerteam(scripts\mp\utility\game::getotherteam(self.droppedteam)[0]);
  var_1 = self.droppedteam;
  var_2 = scripts\mp\utility\game::getotherteam(self.droppedteam)[0];
  scripts\mp\gameobjects::allowcarry("any");
  scripts\mp\gameobjects::setvisibleteam("any");
  objective_state(self.pingobjidnum, "done");

  if(level.returntime >= 0) {
    scripts\mp\gameobjects::ref_1317f(level.iconreturnflag, level.iconcaptureflag, level.ref_11c60);
  } else {
    scripts\mp\gameobjects::ref_1317f(level.icondefendflag, level.iconcaptureflag, level.ref_11c60);
    scripts\mp\objidpoolmanager::ref_11f7d(self.objidnum, 1);
  }

  if(self.ref_1214b == "allies") {
    setomnvar("ui_ctf_flag_axis", -1);
  } else {
    setomnvar("ui_ctf_flag_allies", -1);
  }

  if(isDefined(var_0)) {
    var_0 setclientomnvar("ui_ctf_flag_carrier", 0);
  }

  var_3 = self.visuals[0] gettagorigin("tag_origin");

  if(isDefined(var_0)) {
    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      var_0.carryobject.previouscarrier = undefined;
    }

    if(isDefined(var_0.carryflag)) {
      detachflag(var_0);
    }

    scripts\mp\utility\print::printandsoundoneveryone(var_2, "none", undefined, undefined, "mp_war_objective_lost", "", var_0);

    if(level.codcasterenabled) {
      var_0 setgametypevip(0);
    }
  } else {
    scripts\mp\utility\sound::playsoundonplayers("mp_war_objective_lost", var_2);
  }

  scripts\mp\utility\dialog::leaderdialog("enemy_flag_dropped", self.ref_1214b, "status");
  scripts\mp\utility\dialog::leaderdialog("flag_dropped", scripts\mp\utility\game::getotherteam(self.ref_1214b)[0], "status");

  if(level.idleresettime > 0) {
    thread returnaftertime();
    return;
  }
}

function returnaftertime() {
  self endon("picked_up");
  var_0 = 0;

  while(var_0 < level.idleresettime) {
    waitframe();

    if(self.claimteam == "none") {
      var_0 += level.framedurationseconds;
    }
  }

  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = scripts\mp\utility\game::getotherteam(var_1)[0];
  scripts\mp\utility\sound::playsoundonplayers("mp_war_objective_taken", var_1);
  scripts\mp\utility\sound::playsoundonplayers("mp_war_objective_lost", var_2);
  scripts\mp\gameobjects::returnhome();
}

function onreset() {
  if(isDefined(self.droppedteam)) {
    scripts\mp\gameobjects::setownerteam(self.droppedteam);
  }

  var_0 = scripts\mp\gameobjects::getownerteam();
  var_1 = scripts\mp\utility\game::getotherteam(var_0)[0];
  self.droppedteam = undefined;
  scripts\mp\gameobjects::allowcarry("friendly");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconescort, level.iconkill);

  if(self.ref_1214b == "allies") {
    setomnvar("ui_ctf_flag_axis", -2);
  } else {
    setomnvar("ui_ctf_flag_allies", -2);
  }

  level.capzones[var_1] scripts\mp\gameobjects::allowuse("friendly");
  level.capzones[var_1] scripts\mp\gameobjects::setvisibleteam("any");
  level.capzones[var_1] scripts\mp\gameobjects::ref_1317f(level.icondefendflag, level.iconcaptureflag, level.ref_11c60);
  self.previouscarrier = undefined;
}

function onuse(var_0) {
  if(!level.gameended) {
    if(var_0 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      return;
    }

    var_1 = var_0.pers["team"];

    if(var_1 == "allies") {
      var_2 = "axis";
    } else {
      var_2 = "allies";
    }

    var_1 setclientomnvar("ui_ctf_flag_carrier", 0);
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_captured", var_2, "status");
    scripts\mp\utility\dialog::leaderdialog("flag_captured", var_2, "status");
    scripts\mp\utility\game::setmlgannouncement(17, var_1.team, var_1 getentitynumber());
    objective_state(level.teamflags[var_2].pingobjidnum, "done");
    ref_13ffa(var_1);
    thread scripts\mp\hud_util::teamplayercardsplash("callout_flagcapture", var_1);
    var_1 thread scripts\mp\rank::scoreeventpopup("flag_capture");
    var_1 thread scripts\mp\awards::givemidmatchaward("mode_ctf_cap");
    var_1 notify("objective", "captured");
    var_1 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "capture", var_1.origin);

    if(level.codcasterenabled) {
      var_1 setgametypevip(0);
    }

    var_1 scripts\mp\utility\stats::incpersstat("captures", 1);
    var_1 scripts\mp\persistence::statsetchild("round", "captures", var_1.pers["captures"]);

    if(isPlayer(var_1)) {
      var_1 scripts\mp\utility\stats::setextrascore0(var_1.pers["captures"]);
    }

    scripts\mp\utility\print::printandsoundoneveryone(var_2, var_2, undefined, undefined, "mp_obj_captured", "mp_enemy_obj_captured", var_1);

    if(isDefined(var_1.carryflag)) {
      detachflag(var_1);
    }

    if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[var_2])) {
      thread removeflagcarrierclass();
    }

    level.closecapturekiller[var_2] = undefined;
    level.closecapturekiller[var_2] = undefined;

    if(level.codcasterenabled) {
      level.capzones[var_2] scripts\mp\gameobjects::ref_12c75();
    }

    returnflag(level.teamflags[var_2]);
    level scripts\mp\gamescore::giveteamscoreforobjective(var_2, 1, 0);
    var_1 scripts\cp\vehicles\vehicle_compass_cp::ref_12003();
    return;
  }
}

function onplayerconnect(var_0) {
  var_0._flageffect = [];
  var_0._flagradiuseffect = [];
  thread onplayerspawned();
}

function onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned");
    self setclientomnvar("ui_ctf_flag_carrier", 0);
    scripts\mp\utility\stats::setextrascore0(0);

    if(isDefined(self.pers["captures"])) {
      scripts\mp\utility\stats::setextrascore0(self.pers["captures"]);
    }

    scripts\mp\utility\stats::setextrascore1(0);

    if(isDefined(self.pers["returns"])) {
      scripts\mp\utility\stats::setextrascore1(self.pers["returns"]);
    }
  }
}

function applyflagcarrierclass() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self ismantling()) {
    waitframe();
  }

  while(!self isonground()) {
    waitframe();
  }

  self.pers["gamemodeLoadout"] = level.ctf_loadouts[self.team];
  scripts\mp\equipment\tac_insert::ref_13684(self.origin, self.angles);
  self.gamemode_chosenclass = self.class;
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "gamemode";
  self.class = "gamemode";
  self.lastclass = "gamemode";
  self notify("faux_spawn");
  self.gameobject_fauxspawn = 1;
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
  thread waitattachflag();
}

function superabilitywatcher() {
  self notify("superWatcher");
  self endon("superWatcher");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("drop_object");
  var_0 = self.pers["team"];

  if(var_0 == "allies") {
    var_1 = "axis";
  } else {
    var_1 = "allies";
  }

  level.teamflags[var_1] endon("reset");

  for(;;) {
    self waittill("super_started");
    var_2 = level.teamflags[var_1];

    if(!isDefined(var_2)) {
      continue;
    }

    var_3 = self.super;

    switch (var_3.staticdata.ref) {
      case "super_rewind":
        scripts\engine\utility::ref_143a5("teleport_success", "rewind_success");
        var_2 thread scripts\mp\gameobjects::setdropped();
        return;
    }
  }
}

function waitattachflag() {
  level endon("game_ende");
  self endon("death_or_disconnect");
  self waittill("spawned_player");
  attachflag();
}

function removeflagcarrierclass() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self ismantling()) {
    waitframe();
  }

  while(!self isonground()) {
    waitframe();
  }

  self.pers["gamemodeLoadout"] = undefined;
  scripts\mp\equipment\tac_insert::ref_13684(self.origin, self.angles);
  self notify("faux_spawn");
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

function oncantuse(var_0) {}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = 0;
  var_11 = var_1.origin;
  var_12 = 0;

  if(isDefined(var_0)) {
    var_11 = var_0.origin;
    var_12 = var_0 == var_1;
  }

  if(isDefined(var_1) && isPlayer(var_1) && var_1.pers["team"] != self.pers["team"]) {
    if(isDefined(var_1.carryflag) && var_12) {
      var_1 thread scripts\mp\rank::scoreeventpopup("carrier_kill");
      var_1 thread scripts\mp\awards::givemidmatchaward("mode_ctf_kill_with_flag");
      var_10 = 1;
    }

    if(isDefined(self.carryflag)) {
      var_13 = distancesquared(self.origin, level.capzones[self.team].trigger.origin);

      if(var_13 < 90000) {
        level.closecapturekiller[var_1.team] = var_1;
      } else {
        level.closecapturekiller[var_1.team] = undefined;
      }

      var_1 thread scripts\mp\awards::givemidmatchaward("mode_ctf_kill_carrier");
      var_1 scripts\mp\utility\stats::incpersstat("carrierKills", 1);
      var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
      var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
      thread scripts\common\utility::ref_13e0a(level.ref_11b30, var_9, "carrying");
      scripts\mp\utility\game::setmlgannouncement(20, var_1.team, var_1 getentitynumber());
      var_10 = 1;
    }

    if(!var_10) {
      var_14 = 0;
      var_15 = 0;

      foreach(var_17 in level.teamflags) {
        var_18 = distsquaredcheck(var_11, self.origin, var_17.curorigin);

        if(var_18) {
          if(var_17.ownerteam == self.team) {
            var_14 = 1;
            continue;
          }

          var_15 = 1;
        }
      }

      if(var_14) {
        var_1 thread scripts\mp\rank::scoreeventpopup("assault");
        var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
        thread scripts\common\utility::ref_13e0a(level.ref_11b30, var_9, "defending");
        var_1 scripts\mp\utility\stats::incpersstat("assaults", 1);
      } else if(var_15) {
        var_1 thread scripts\mp\rank::scoreeventpopup("defend");
        var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
        var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
        var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
        thread scripts\common\utility::ref_13e0a(level.ref_11b30, var_9, "assaulting");
      }
    }
  }

  if(isDefined(self.carryflag)) {
    detachflag();
    return;
  }
}

function distsquaredcheck(var_0, var_1, var_2) {
  var_3 = distancesquared(var_2, var_0);
  var_4 = distancesquared(var_2, var_1);

  if(var_3 < 90000 || var_4 < 90000) {
    return 1;
  }

  return 0;
}

function attachflag() {
  ref_13ff9();
  var_0 = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];
  self attach(level.carryflag[var_0], "tag_stowed_back3", 1);
  self.carryflag = level.carryflag[var_0];
}

function detachflag() {
  self detach(self.carryflag, "tag_stowed_back3");
  self.carryflag = undefined;
}

function setspecialloadouts() {
  if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses", "axis", 5, "class", "inUse")) {
    level.ctf_loadouts["axis"] = scripts\mp\utility\game::getmatchrulesspecialclass("axis", 5);
  }

  if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses", "allies", 5, "class", "inUse")) {
    level.ctf_loadouts["allies"] = scripts\mp\utility\game::getmatchrulesspecialclass("allies", 5);
    return;
  }
}

function removeflag() {
  level endon("game_ended");

  for(;;) {
    if(getDvar("scr_devRemoveDomFlag", "") != "") {
      var_0 = getDvar("scr_devRemoveDomFlag", "");

      if(var_0 == "_a") {
        var_1 = "allies";
      } else {
        var_1 = "axis";
      }

      if(var_1 == "allies") {
        if(game["switchedsides"]) {
          var_1 = game["defenders"];
        } else {
          var_1 = game["attackers"];
        }
      } else if(game["switchedsides"]) {
        var_1 = game["attackers"];
      } else {
        var_1 = game["defenders"];
      }

      level.teamflags[var_1].trigger notify("move_gameobject");
      level.teamflags[var_1] scripts\mp\gameobjects::allowuse("none");
      level.teamflags[var_1].trigger = undefined;
      level.teamflags[var_1] notify("deleted");
      level.teamflags[var_1].visuals[0] delete();
      level.teamflagbases[var_1] delete();
      level.capzones[var_1] scripts\mp\gameobjects::allowuse("none");
      level.capzones[var_1].trigger = undefined;
      level.capzones[var_1] notify("deleted");

      foreach(var_3 in level.players) {
        player_delete_flag_goal_fx(var_3, var_1);
      }

      level.teamflags[var_1].visibleteam = "none";
      level.teamflags[var_1] scripts\mp\gameobjects::setobjectivestatusicons(undefined, undefined);
      level.capzones[var_1].visibleteam = "none";
      level.capzones[var_1] scripts\mp\gameobjects::setobjectivestatusicons(undefined, undefined);
      level.teamflags[var_1] = undefined;
      setdynamicdvar("scr_devRemoveDomFlag", "");
    }

    wait 1;
  }
}

function placeflag() {
  level endon("game_ended");

  for(;;) {
    if(getDvar("scr_devPlaceDomFlag", "") != "") {
      var_0 = getDvar("scr_devPlaceDomFlag", "");

      if(var_0 == "_a") {
        var_1 = "allies";
      } else {
        var_1 = "axis";
      }

      if(var_1 == "allies") {
        if(game["switchedsides"]) {
          var_1 = game["defenders"];
        } else {
          var_1 = game["attackers"];
        }
      } else if(game["switchedsides"]) {
        var_1 = game["attackers"];
      } else {
        var_1 = game["defenders"];
      }

      var_2 = undefined;
      var_2 = spawnStruct();
      dev_flag_find_ground(var_2);
      var_2.origin = var_2.ground_origin;
      var_2.radius = 30;
      var_2.team = var_1;
      var_3 = spawn("trigger_radius", var_2.origin, 0, 30, 80);
      GscBinSkip1(0x45, 0, spawn("script_model", var_2.origin));
    }

    wait 1;
  }
}

function dev_flag_find_ground() {
  var_0 = level.players[0].origin + (0, 0, 32);
  var_1 = level.players[0].origin + (0, 0, -1000);
  var_2 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_3 = [];
  var_4 = scripts\engine\trace::ray_trace(var_0, var_1, var_3, var_2);
  self.ground_origin = var_4["position"];
  return var_4["fraction"] != 0 && var_4["fraction"] != 1;
}

function setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_ctf_kill", 2, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_recover_flag", 2, "friendly", "MP_INGAME_ONLY/OBJ_RECOVER_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_flag", 2, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_take_flag", 2, "enemy", "MP_INGAME_ONLY/OBJ_TAKE_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_flag", 2, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_mlg_empty_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_empty", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_mlg_full_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_full", 0);
}

function ref_13ffa() {
  self setclientomnvar("ui_match_status_hint_text", 37);
}

function ref_13ff9() {
  self setclientomnvar("ui_match_status_hint_text", 38);
}