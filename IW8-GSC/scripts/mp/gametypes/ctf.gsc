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
  var0 = scripts\mp\utility\game::inovertime();
  var1 = game["overtimeRoundsPlayed"] == 0;
  var2 = scripts\mp\utility\game::istimetobeatvalid();

  if(var0) {
    if(var1) {
      setomnvar("ui_round_hint_override_attackers", 1);
      setomnvar("ui_round_hint_override_defenders", 1);
    } else if(var2) {
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
    var3 = game["attackers"];
    var4 = game["defenders"];
    game["attackers"] = var4;
    game["defenders"] = var3;
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
  var0 = scripts\mp\spawnlogic::getspawnpointarray("mp_ctf_spawn_allies_start");
  var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_ctf_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", var0);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", var1);
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
  var0 = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype);
  var1 = scripts\mp\spawnlogic::ispathdataavailable();
  level.teamspawnpoints["axis"] = [];
  level.teamspawnpoints["allies"] = [];
  level.teamspawnpoints["neutral"] = [];
  jumpiffalse(level.teamflags.size == 2) LOC_0000022e;
  var2 = level.teamflags["allies"];
  var3 = level.teamflags["axis"];
  var4 = (var2.curorigin[0], var2.curorigin[1], 0);
  var5 = (var3.curorigin[0], var3.curorigin[1], 0);
  var6 = var5 - var4;
  var7 = length2d(var6);

  foreach(var9 in var0) {
    var10 = (var9.origin[0], var9.origin[1], 0);
    var11 = var10 - var4;
    var12 = vectordot(var11, var6);
    var13 = var12 / var7 * var7;

    if(var13 < 0.33) {
      var9.teambase = scripts\mp\utility\game::getotherteam(var2.ownerteam)[0];
      level.teamspawnpoints[var9.teambase][level.teamspawnpoints[var9.teambase].size] = var9;
      continue;
    }

    if(var13 > 0.67) {
      var9.teambase = scripts\mp\utility\game::getotherteam(var3.ownerteam)[0];
      level.teamspawnpoints[var9.teambase][level.teamspawnpoints[var9.teambase].size] = var9;
      continue;
    }

    var14 = undefined;
    var15 = undefined;

    if(var1) {
      var14 = getpathdist(var9.origin, var2.curorigin, 999999);
    }

    if(isDefined(var14) && var14 != -1) {
      var15 = getpathdist(var9.origin, var3.curorigin, 999999);
    }

    if(!isDefined(var15) || var15 == -1) {
      var14 = distance2d(var2.curorigin, var9.origin);
      var15 = distance2d(var3.curorigin, var9.origin);
    }

    var16 = max(var14, var15);
    var17 = min(var14, var15);
    var18 = var17 / var16;

    if(var18 > 0.5) {
      level.teamspawnpoints["neutral"][level.teamspawnpoints["neutral"].size] = var9;
    }
  }

  return;
}

function getnearestflagteam(var0) {
  var1 = scripts\mp\spawnlogic::ispathdataavailable();
  var2 = undefined;
  var3 = undefined;

  foreach(var5 in level.teamflags) {
    var6 = undefined;

    if(var1) {
      var6 = getpathdist(var0.origin, var5.curorigin, 999999);
    }

    if(!isDefined(var6) || var6 == -1) {
      var6 = distancesquared(var5.curorigin, var0.origin);
    }

    if(!isDefined(var2) || var6 < var3) {
      var2 = var5;
      var3 = var6;
    }
  }

  return scripts\mp\utility\game::getotherteam(var2.ownerteam)[0];
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
    var1 = scripts\mp\spawnlogic::getspawnpoint(self, var1, level.ctfteamspawnsetids[var1], "neutral");
  }

  return var1;
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

  foreach(var1 in level.flags) {
    switch (var1.script_label) {
      case "_a":
        level.default_flag_origins[game["attackers"]] = var1.origin;
        break;
      case "_c":
        level.default_flag_origins[game["defenders"]] = var1.origin;
        break;
    }
  }
}

function flag_create_team_goal(var0) {
  var1 = spawnStruct();

  switch (level.script) {
    default:
      break;
  }

  if(!isDefined(var1.origin)) {
    var1.origin = level.default_flag_origins[var0];
  }

  flag_find_ground(var1);
  var1.origin = var1.ground_origin;
  var1.radius = 30;
  var1.team = var0;
  var1.ball_in_goal = 0;
  var1.highestspawndistratio = 0;
  return var1;
}

function flag_find_ground(var0) {
  var1 = self.origin + (0, 0, 32);
  var2 = self.origin + (0, 0, -1000);
  var3 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var4 = [];
  var5 = scripts\engine\trace::ray_trace(var1, var2, var4, var3);
  self.ground_origin = var5["position"];
  return var5["fraction"] != 0 && var5["fraction"] != 1;
}

function showflagradiuseffecttoplayers(var0, var1, var2) {
  if(isDefined(var1._flagradiuseffect[var0])) {
    var1._flagradiuseffect[var0] delete();
  }

  var3 = undefined;
  var4 = var1.team;
  var5 = var1 ismlgspectator();

  if(var5) {
    var4 = var1 getmlgspectatorteam();
  } else if(var4 == "spectator") {
    var4 = "allies";
  }

  if(var4 == var0) {
    var6 = spawnfxforclient(level.flagradiusfxid["friendly"], var2, var1, (0, 0, 1));
    var6 setfxkilldefondelete();
  } else {
    var6 = spawnfxforclient(level.flagradiusfxid["enemy"], var3, var2, (0, 0, 1));
    var6 setfxkilldefondelete();
  }

  var2._flagradiuseffect[var1] = var6;
  triggerfx(var6);
}

function showbaseeffecttoplayer(var0, var1) {
  if(isDefined(var1._flageffect[var0])) {
    var1._flageffect[var0] delete();
  }

  var2 = undefined;
  var3 = var1.team;
  var4 = var1 ismlgspectator();

  if(var4) {
    var3 = var1 getmlgspectatorteam();
  } else if(var3 == "spectator") {
    var3 = "allies";
  }

  if(var3 == var0) {
    var5 = spawnfxforclient(level.flagbaseglowfxid["friendly"], self.origin, var1, self.baseeffectforward);
    var5 setfxkilldefondelete();
  } else {
    var5 = spawnfxforclient(level.flagbaseglowfxid["enemy"], self.origin, var2, self.baseeffectforward);
    var5 setfxkilldefondelete();
  }

  var2._flageffect[var1] = var5;
  triggerfx(var5);
}

function removeflagpickupradiuseffect(var0) {
  if(var0 == self.team) {
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

function setteaminhuddatafromteamname(var0) {
  if(var0 == "axis") {
    self setteaminhuddata(1);
    return;
  }

  if(var0 == "allies") {
    self setteaminhuddata(2);
    return;
  }

  self setteaminhuddata(0);
}

function player_delete_flag_goal_fx(var0) {
  if(var0 == self.team) {
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

function getflagpos(var0) {
  var1 = getEnt("ctf_flag_" + var0, "targetname");
  return var1.origin;
}

function createteamflag(var0, var1) {
  var2 = 0;
  var3 = getEnt("ctf_zone_" + var1, "targetname");

  if(!isDefined(var3)) {
    var4 = flag_create_team_goal(var0);
    var3 = spawn("trigger_radius", var4.origin - (0, 0, var4.radius / 2), 0, var4.radius, 80);
    var3.no_moving_platfrom_unlink = 1;
    var3.linktoenabledflag = 1;
    var3.baseorigin = var3.origin;
    var2 = 1;
    var5 = spawn("script_model", var4.origin);
    var5[0] setasgametypeobjective();
    setteaminhuddatafromteamname(var5[0], var1);
  } else {
    GscBinSkip1(0x45, 0, getEnt("ctf_flag_" + var2, "targetname"));
  }

  if(isDefined(var5[0])) {}

  if(!var2) {
    var6 = 15;

    if(level.pickuptime > 0 || level.returntime > 0) {
      var6 *= 2;
    }

    var7 = spawn("trigger_radius", var3.origin, 0, var6, var3.height);
    var3 = var7;
  }

  if(level.mapname == "mp_m_speedball") {
    flag_find_ground(var3);
    var3.origin = var3.ground_origin;
    var5[0].origin = var3.ground_origin - (0, 0, 0.5);
  }

  var5[0] setModel(level.flagmodel[var0]);
  var5[0] setasgametypeobjective();
  setteaminhuddatafromteamname(var5[0], var1);
  var8 = scripts\mp\utility\game::getotherteam(var0)[0];
  var9 = scripts\mp\gameobjects::createcarryobject(var8, var3, var5, (0, 0, 85));
  var9 scripts\mp\gameobjects::allowcarry("friendly");
  var9 scripts\mp\gameobjects::setteamusetime("friendly", level.pickuptime);
  var9 scripts\mp\gameobjects::setteamusetime("enemy", level.returntime);
  var9 scripts\mp\gameobjects::setvisibleteam("none");
  var9 scripts\mp\gameobjects::ref_1317f(level.iconescort, level.iconkill, level.ref_11c60);
  var9 scripts\mp\objidpoolmanager::objective_set_play_intro(var9.objidnum, 0);
  var9 scripts\mp\objidpoolmanager::objective_set_play_outro(var9.objidnum, 0);
  var9 scripts\mp\gameobjects::ref_12b13(&player_infil_already_played);
  var9.allowweapons = 1;
  var9.ref_1214b = var8;
  var9.onpickup = &onpickup;
  var9.onpickupfailed = &onpickup;
  var9.ondrop = &ondrop;
  var9.onreset = &onreset;
  var9.tv_station_gas_rise = 1;

  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        var9.objidpingfriendly = 1;
        var9.objidpingenemy = 0;
        var9.objpingdelay = 60;
        break;
      case 1:
        var9.objidpingfriendly = 0;
        var9.objidpingenemy = 0;
        var9.objpingdelay = 0.05;
        break;
      case 2:
        var9.objidpingfriendly = 1;
        var9.objidpingenemy = 0;
        var9.objpingdelay = 1;
        break;
      case 3:
        var9.objidpingfriendly = 1;
        var9.objidpingenemy = 0;
        var9.objpingdelay = 1.5;
        break;
      case 4:
        var9.objidpingfriendly = 1;
        var9.objidpingenemy = 0;
        var9.objpingdelay = 2;
        break;
      case 5:
        var9.objidpingfriendly = 1;
        var9.objidpingenemy = 0;
        var9.objpingdelay = 3;
        break;
      case 6:
        var9.objidpingfriendly = 1;
        var9.objidpingenemy = 0;
        var9.objpingdelay = 4;
        break;
    }

    var10 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
    var9.pingobjidnum = var10;
    scripts\mp\objidpoolmanager::objective_add_objective(var10, "done", var9.origin);
    scripts\mp\objidpoolmanager::objective_set_play_intro(var10, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(var10, 0);
    var9 scripts\mp\gameobjects::setvisibleteam("none", var10);
    objective_setownerteam(var10, var0);
    var9 scripts\mp\gameobjects::ref_1317f(level.iconescort, level.iconkill, level.ref_11c60, var10);
  } else {
    var9.objidpingfriendly = 1;
    var9.objidpingenemy = 0;
    var9.objpingdelay = 3;
  }

  var9.oldradius = var3.radius;
  var11 = var3.origin + (0, 0, 32);
  var12 = var3.origin + (0, 0, -32);
  var13 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var14 = [];
  var15 = scripts\engine\trace::ray_trace(var11, var12, var14, var13);
  var9.baseeffectpos = var9.visuals[0].origin;
  var16 = anglestoup(var9.visuals[0].angles);
  var9.baseeffectforward = anglesToForward(var16);
  level.teamflagbases[var0] = createteamflagbase(var0, var9);
  return var9;
}

function player_infil_already_played(var0) {
  return !var0 scripts\cp_mp\utility\player_utility::isinvehicle();
}

function createteamflagbase(var0, var1) {
  var2 = var1.visuals[0].origin;
  var3 = spawn("script_model", var2);
  var3 setModel(level.flagbase[var0]);
  var3.ownerteam = var0;
  var3 setasgametypeobjective();
  setteaminhuddatafromteamname(var3, var0);
  var3.baseeffectpos = var2;
  var4 = anglestoup(var1.visuals[0].angles);
  var3.baseeffectforward = anglesToForward(var4);
  return var3;
}

function createcapzone(var0, var1) {
  var2 = flag_create_team_goal(var0);
  var3 = getEnt("ctf_zone_" + var1, "targetname");

  if(!isDefined(var3)) {
    var3 = spawn("trigger_radius", var2.origin - (0, 0, var2.radius / 2), 0, var2.radius, 80);
    var3.no_moving_platfrom_unlink = 1;
    var3.linktoenabledflag = 1;
    var3.baseorigin = var3.origin;
    var3.height = 80;
  }

  var4 = spawn("trigger_radius", var3.origin, 0, 15, var3.height);
  var3 = var4;
  var5 = [];
  var6 = scripts\mp\gameobjects::createuseobject(var0, var3, var5, (0, 0, 85));
  var6 scripts\mp\gameobjects::allowuse("friendly");
  var6 scripts\mp\gameobjects::setvisibleteam("any");
  var6 scripts\mp\gameobjects::ref_1317f(level.icondefendflag, level.iconcaptureflag, level.ref_11c60);
  var6 scripts\mp\gameobjects::setusetime(0);
  var6 scripts\mp\gameobjects::setkeyobject(level.teamflags[scripts\mp\utility\game::getotherteam(var0)[0]]);
  var6.onuse = &onuse;
  var6.oncantuse = &oncantuse;
  var7 = var3.origin + (0, 0, 32);
  var8 = var3.origin + (0, 0, -32);
  var9 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var10 = [];
  var11 = scripts\engine\trace::ray_trace(var7, var8, var10, var9);
  var12 = vectortoangles(var11["normal"]);
  var13 = anglesToForward(var12);
  var14 = anglestoright(var12);
  return var6;
}

function onbeginuse(var0) {
  var1 = var0.pers["team"];

  if(var1 == scripts\mp\gameobjects::getownerteam()) {
    self.trigger.radius = 1024;
    return;
  }

  self.trigger.radius = self.oldradius;
}

function onenduse(var0, var1, var2) {
  self.trigger.radius = self.oldradius;
}

function onpickup(var0, var1, var2) {
  self notify("picked_up");
  var0 notify("obj_picked_up");
  var3 = scripts\mp\gameobjects::getownerteam();

  if(isDefined(self.droppedteam)) {
    if(self.droppedteam == var0.team) {
      scripts\mp\gameobjects::setownerteam(self.droppedteam);
      var3 = self.droppedteam;
    } else {
      scripts\mp\gameobjects::setownerteam(scripts\mp\utility\game::getotherteam(var0.team)[0]);
      var3 = self.droppedteam;
    }

    self.droppedteam = undefined;
  }

  var4 = var0.pers["team"];

  if(var4 == "allies") {
    var5 = "axis";
  } else {
    var5 = "allies";
  }

  if(var5 != var4) {
    if(isDefined(level.closecapturekiller[var1.team]) && level.closecapturekiller[var1.team] == var1) {
      var1 thread scripts\mp\awards::givemidmatchaward("mode_ctf_nope");
    }

    level.closecapturekiller[var1.team] = undefined;
    var1 thread scripts\mp\utility\points::giveunifiedpoints("flag_return");

    if(level.codcasterenabled) {
      level.capzones[var1.team] scripts\mp\gameobjects::ref_12c75();
    }

    thread returnflag();
    var1 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "obj_return", var1.origin);
    scripts\mp\utility\print::printandsoundoneveryone(var5, scripts\mp\utility\game::getotherteam(var5)[0], undefined, undefined, "mp_obj_returned", "mp_obj_returned", var1);
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_returned", var5, "status");
    scripts\mp\utility\dialog::leaderdialog("flag_returned", var5, "status");
    scripts\mp\utility\game::setmlgannouncement(18, var1.team, var1 getentitynumber());
    var1 scripts\mp\utility\stats::incpersstat("returns", 1);
    var1 scripts\mp\persistence::statsetchild("round", "returns", var1.pers["returns"]);

    if(isPlayer(var1)) {
      var1 scripts\mp\utility\stats::setextrascore1(var1.pers["returns"]);
    }

    if(self.ref_1214b == "allies") {
      setomnvar("ui_ctf_flag_axis", -2);
      return;
    }

    setomnvar("ui_ctf_flag_allies", -2);
    return;
  }

  if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[var5])) {
    thread applyflagcarrierclass();
  } else {
    attachflag(var1);
  }

  var1 scripts\mp\utility\stats::incpersstat("pickups", 1);
  level.closecapturekiller[var5] = undefined;

  if(self.ref_1214b == "allies") {
    setomnvar("ui_ctf_flag_axis", var1 getentitynumber());
  } else {
    setomnvar("ui_ctf_flag_allies", var1 getentitynumber());
  }

  var1 setclientomnvar("ui_ctf_flag_carrier", 1);

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
    level.capzones[var5] scripts\mp\gameobjects::allowuse("none");
  }

  level.capzones[var5] scripts\mp\gameobjects::setvisibleteam("none");
  level.capzones[var5] scripts\mp\gameobjects::ref_13172(level.ref_11c5f);
  scripts\mp\utility\print::printandsoundoneveryone(var5, var5, undefined, undefined, "mp_obj_taken", "mp_enemy_obj_taken", var1);
  scripts\mp\utility\dialog::leaderdialog("enemy_flag_taken", var5);
  scripts\mp\utility\dialog::leaderdialog("flag_getback", var5);
  thread scripts\mp\hud_util::teamplayercardsplash("callout_flagpickup", var1);

  if(!isDefined(self.previouscarrier) || self.previouscarrier != var1) {
    var1 thread scripts\mp\utility\points::giveunifiedpoints("flag_grab");
  }

  var1 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "pickup", var1.origin);
  self.previouscarrier = var1;

  if(level.codcasterenabled) {
    var1 setgametypevip(1);
  }

  thread superabilitywatcher();
}

function onpickupfailed(var0) {}

function returnflag() {
  scripts\mp\gameobjects::returnhome();
}

function ondrop(var0) {
  if(isDefined(var0.leaving_team)) {
    self.droppedteam = var0.leaving_team;
    var0.leaving_team = undefined;
  } else if(!isDefined(var0)) {
    self.droppedteam = self.ref_1214b;
  } else {
    self.droppedteam = var0.team;
  }

  if(isDefined(var0)) {
    ref_13ffa(var0);
  }

  scripts\mp\gameobjects::setownerteam(scripts\mp\utility\game::getotherteam(self.droppedteam)[0]);
  var1 = self.droppedteam;
  var2 = scripts\mp\utility\game::getotherteam(self.droppedteam)[0];
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

  if(isDefined(var0)) {
    var0 setclientomnvar("ui_ctf_flag_carrier", 0);
  }

  var3 = self.visuals[0] gettagorigin("tag_origin");

  if(isDefined(var0)) {
    if(!scripts\mp\utility\player::isreallyalive(var0)) {
      var0.carryobject.previouscarrier = undefined;
    }

    if(isDefined(var0.carryflag)) {
      detachflag(var0);
    }

    scripts\mp\utility\print::printandsoundoneveryone(var2, "none", undefined, undefined, "mp_war_objective_lost", "", var0);

    if(level.codcasterenabled) {
      var0 setgametypevip(0);
    }
  } else {
    scripts\mp\utility\sound::playsoundonplayers("mp_war_objective_lost", var2);
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
  var0 = 0;

  while(var0 < level.idleresettime) {
    waitframe();

    if(self.claimteam == "none") {
      var0 += level.framedurationseconds;
    }
  }

  var1 = scripts\mp\gameobjects::getownerteam();
  var2 = scripts\mp\utility\game::getotherteam(var1)[0];
  scripts\mp\utility\sound::playsoundonplayers("mp_war_objective_taken", var1);
  scripts\mp\utility\sound::playsoundonplayers("mp_war_objective_lost", var2);
  scripts\mp\gameobjects::returnhome();
}

function onreset() {
  if(isDefined(self.droppedteam)) {
    scripts\mp\gameobjects::setownerteam(self.droppedteam);
  }

  var0 = scripts\mp\gameobjects::getownerteam();
  var1 = scripts\mp\utility\game::getotherteam(var0)[0];
  self.droppedteam = undefined;
  scripts\mp\gameobjects::allowcarry("friendly");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconescort, level.iconkill);

  if(self.ref_1214b == "allies") {
    setomnvar("ui_ctf_flag_axis", -2);
  } else {
    setomnvar("ui_ctf_flag_allies", -2);
  }

  level.capzones[var1] scripts\mp\gameobjects::allowuse("friendly");
  level.capzones[var1] scripts\mp\gameobjects::setvisibleteam("any");
  level.capzones[var1] scripts\mp\gameobjects::ref_1317f(level.icondefendflag, level.iconcaptureflag, level.ref_11c60);
  self.previouscarrier = undefined;
}

function onuse(var0) {
  if(!level.gameended) {
    if(var0 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      return;
    }

    var1 = var0.pers["team"];

    if(var1 == "allies") {
      var2 = "axis";
    } else {
      var2 = "allies";
    }

    var1 setclientomnvar("ui_ctf_flag_carrier", 0);
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_captured", var2, "status");
    scripts\mp\utility\dialog::leaderdialog("flag_captured", var2, "status");
    scripts\mp\utility\game::setmlgannouncement(17, var1.team, var1 getentitynumber());
    objective_state(level.teamflags[var2].pingobjidnum, "done");
    ref_13ffa(var1);
    thread scripts\mp\hud_util::teamplayercardsplash("callout_flagcapture", var1);
    var1 thread scripts\mp\rank::scoreeventpopup("flag_capture");
    var1 thread scripts\mp\awards::givemidmatchaward("mode_ctf_cap");
    var1 notify("objective", "captured");
    var1 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "capture", var1.origin);

    if(level.codcasterenabled) {
      var1 setgametypevip(0);
    }

    var1 scripts\mp\utility\stats::incpersstat("captures", 1);
    var1 scripts\mp\persistence::statsetchild("round", "captures", var1.pers["captures"]);

    if(isPlayer(var1)) {
      var1 scripts\mp\utility\stats::setextrascore0(var1.pers["captures"]);
    }

    scripts\mp\utility\print::printandsoundoneveryone(var2, var2, undefined, undefined, "mp_obj_captured", "mp_enemy_obj_captured", var1);

    if(isDefined(var1.carryflag)) {
      detachflag(var1);
    }

    if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[var2])) {
      thread removeflagcarrierclass();
    }

    level.closecapturekiller[var2] = undefined;
    level.closecapturekiller[var2] = undefined;

    if(level.codcasterenabled) {
      level.capzones[var2] scripts\mp\gameobjects::ref_12c75();
    }

    returnflag(level.teamflags[var2]);
    level scripts\mp\gamescore::giveteamscoreforobjective(var2, 1, 0);
    var1 scripts\cp\vehicles\vehicle_compass_cp::ref_12003();
    return;
  }
}

function onplayerconnect(var0) {
  var0._flageffect = [];
  var0._flagradiuseffect = [];
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
  var0 = self.pers["team"];

  if(var0 == "allies") {
    var1 = "axis";
  } else {
    var1 = "allies";
  }

  level.teamflags[var1] endon("reset");

  for(;;) {
    self waittill("super_started");
    var2 = level.teamflags[var1];

    if(!isDefined(var2)) {
      continue;
    }

    var3 = self.super;

    switch (var3.staticdata.ref) {
      case "super_rewind":
        scripts\engine\utility::ref_143a5("teleport_success", "rewind_success");
        var2 thread scripts\mp\gameobjects::setdropped();
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

function oncantuse(var0) {}

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  var10 = 0;
  var11 = var1.origin;
  var12 = 0;

  if(isDefined(var0)) {
    var11 = var0.origin;
    var12 = var0 == var1;
  }

  if(isDefined(var1) && isPlayer(var1) && var1.pers["team"] != self.pers["team"]) {
    if(isDefined(var1.carryflag) && var12) {
      var1 thread scripts\mp\rank::scoreeventpopup("carrier_kill");
      var1 thread scripts\mp\awards::givemidmatchaward("mode_ctf_kill_with_flag");
      var10 = 1;
    }

    if(isDefined(self.carryflag)) {
      var13 = distancesquared(self.origin, level.capzones[self.team].trigger.origin);

      if(var13 < 90000) {
        level.closecapturekiller[var1.team] = var1;
      } else {
        level.closecapturekiller[var1.team] = undefined;
      }

      var1 thread scripts\mp\awards::givemidmatchaward("mode_ctf_kill_carrier");
      var1 scripts\mp\utility\stats::incpersstat("carrierKills", 1);
      var1 scripts\mp\utility\stats::incpersstat("defends", 1);
      var1 scripts\mp\persistence::statsetchild("round", "defends", var1.pers["defends"]);
      thread scripts\common\utility::ref_13e0a(level.ref_11b30, var9, "carrying");
      scripts\mp\utility\game::setmlgannouncement(20, var1.team, var1 getentitynumber());
      var10 = 1;
    }

    if(!var10) {
      var14 = 0;
      var15 = 0;

      foreach(var17 in level.teamflags) {
        var18 = distsquaredcheck(var11, self.origin, var17.curorigin);

        if(var18) {
          if(var17.ownerteam == self.team) {
            var14 = 1;
            continue;
          }

          var15 = 1;
        }
      }

      if(var14) {
        var1 thread scripts\mp\rank::scoreeventpopup("assault");
        var1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
        thread scripts\common\utility::ref_13e0a(level.ref_11b30, var9, "defending");
        var1 scripts\mp\utility\stats::incpersstat("assaults", 1);
      } else if(var15) {
        var1 thread scripts\mp\rank::scoreeventpopup("defend");
        var1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
        var1 scripts\mp\utility\stats::incpersstat("defends", 1);
        var1 scripts\mp\persistence::statsetchild("round", "defends", var1.pers["defends"]);
        thread scripts\common\utility::ref_13e0a(level.ref_11b30, var9, "assaulting");
      }
    }
  }

  if(isDefined(self.carryflag)) {
    detachflag();
    return;
  }
}

function distsquaredcheck(var0, var1, var2) {
  var3 = distancesquared(var2, var0);
  var4 = distancesquared(var2, var1);

  if(var3 < 90000 || var4 < 90000) {
    return 1;
  }

  return 0;
}

function attachflag() {
  ref_13ff9();
  var0 = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];
  self attach(level.carryflag[var0], "tag_stowed_back3", 1);
  self.carryflag = level.carryflag[var0];
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
      var0 = getDvar("scr_devRemoveDomFlag", "");

      if(var0 == "_a") {
        var1 = "allies";
      } else {
        var1 = "axis";
      }

      if(var1 == "allies") {
        if(game["switchedsides"]) {
          var1 = game["defenders"];
        } else {
          var1 = game["attackers"];
        }
      } else if(game["switchedsides"]) {
        var1 = game["attackers"];
      } else {
        var1 = game["defenders"];
      }

      level.teamflags[var1].trigger notify("move_gameobject");
      level.teamflags[var1] scripts\mp\gameobjects::allowuse("none");
      level.teamflags[var1].trigger = undefined;
      level.teamflags[var1] notify("deleted");
      level.teamflags[var1].visuals[0] delete();
      level.teamflagbases[var1] delete();
      level.capzones[var1] scripts\mp\gameobjects::allowuse("none");
      level.capzones[var1].trigger = undefined;
      level.capzones[var1] notify("deleted");

      foreach(var3 in level.players) {
        player_delete_flag_goal_fx(var3, var1);
      }

      level.teamflags[var1].visibleteam = "none";
      level.teamflags[var1] scripts\mp\gameobjects::setobjectivestatusicons(undefined, undefined);
      level.capzones[var1].visibleteam = "none";
      level.capzones[var1] scripts\mp\gameobjects::setobjectivestatusicons(undefined, undefined);
      level.teamflags[var1] = undefined;
      setdynamicdvar("scr_devRemoveDomFlag", "");
    }

    wait 1;
  }
}

function placeflag() {
  level endon("game_ended");

  for(;;) {
    if(getDvar("scr_devPlaceDomFlag", "") != "") {
      var0 = getDvar("scr_devPlaceDomFlag", "");

      if(var0 == "_a") {
        var1 = "allies";
      } else {
        var1 = "axis";
      }

      if(var1 == "allies") {
        if(game["switchedsides"]) {
          var1 = game["defenders"];
        } else {
          var1 = game["attackers"];
        }
      } else if(game["switchedsides"]) {
        var1 = game["attackers"];
      } else {
        var1 = game["defenders"];
      }

      var2 = undefined;
      var2 = spawnStruct();
      dev_flag_find_ground(var2);
      var2.origin = var2.ground_origin;
      var2.radius = 30;
      var2.team = var1;
      var3 = spawn("trigger_radius", var2.origin, 0, 30, 80);
      GscBinSkip1(0x45, 0, spawn("script_model", var2.origin));
    }

    wait 1;
  }
}

function dev_flag_find_ground() {
  var0 = level.players[0].origin + (0, 0, 32);
  var1 = level.players[0].origin + (0, 0, -1000);
  var2 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var3 = [];
  var4 = scripts\engine\trace::ray_trace(var0, var1, var3, var2);
  self.ground_origin = var4["position"];
  return var4["fraction"] != 0 && var4["fraction"] != 1;
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