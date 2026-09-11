/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\blitz.gsc
***********************************************/

function main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  flag_default_origins();
  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_blitz_winRule", getmatchrulesdata("blitzData", "winRule"));
  setdynamicdvar("scr_blitz_captureCondition", getmatchrulesdata("blitzData", "captureCondition"));
  setdynamicdvar("scr_blitz_returnTime", getmatchrulesdata("blitzData", "returnTime"));
  setdynamicdvar("scr_blitz_showEnemyCarrier", getmatchrulesdata("carryData", "showEnemyCarrier"));
  setdynamicdvar("scr_blitz_idleResetTime", getmatchrulesdata("carryData", "idleResetTime"));
  setdynamicdvar("scr_blitz_pickupTime", getmatchrulesdata("carryData", "pickupTime"));
  setdynamicdvar("scr_blitz_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("blitz", 0);
  setdynamicdvar("scr_blitz_promode", 0);
}

function onspawnplayer() {}

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

  setclientnamemode("auto_change");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER");
    scripts\mp\utility\game::setobjectivescoretext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER");
  } else {
    scripts\mp\utility\game::setobjectivescoretext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER_SCORE");
    scripts\mp\utility\game::setobjectivescoretext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER_SCORE");
  }

  scripts\mp\utility\game::setobjectivetext(game["attackers"], &"OBJECTIVES/BLITZ");
  scripts\mp\utility\game::setobjectivetext(game["defenders"], &"OBJECTIVES/BLITZ");
  scripts\mp\utility\game::setobjectivehinttext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER_HINT");
  scripts\mp\utility\game::setobjectivehinttext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER_HINT");
  flag_setupvfx();
  createflagsandhud();
  initspawns();
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
  level.iconescort = "waypoint_blitz_escort";
  level.iconkill = "waypoint_blitz_kill";
  level.iconpickupflag = "waypoint_blitz_pickup";
  level.icongoalflag = "waypoint_blitz_goal";
  level.iconreturnflag = "waypoint_blitz_reset";
  level.iconresettingflag = "waypoint_blitz_resetting";
  level.iconlosingflag = "waypoint_blitz_pickup_losing";
  level.icondefendflag = "waypoint_blitz_defend";
  level.iconpickupdefendflag = "waypoint_blitz_pickup_defend";
  level.teamflags[game["defenders"]] = createteamflag(game["defenders"], "axis");
  level.teamflags[game["attackers"]] = createteamflag(game["attackers"], "allies");
  level.capzones[game["defenders"]] = createcapzone(game["defenders"], "axis");
  level.capzones[game["attackers"]] = createcapzone(game["attackers"], "allies");
}

function flag_setupvfx() {}

function initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("AwayFromEnemies", "Crit_Default");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_ctf_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_ctf_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_ctf_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_ctf_spawn");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  assignteamspawns();
  level.ctfteamspawnsetids["allies"] = "allies";
  level.ctfteamspawnsetids["axis"] = "axis";
  scripts\mp\spawnlogic::registerspawnset("allies", level.teamspawnpoints["allies"]);
  scripts\mp\spawnlogic::registerspawnset("axis", level.teamspawnpoints["axis"]);
  scripts\mp\spawnlogic::registerspawnset("neutral", level.teamspawnpoints["neutral"]);
}

function assignteamspawns() {
  var_0 = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype);
  var_1 = scripts\mp\spawnlogic::ispathdataavailable();
  level.teamspawnpoints["axis"] = [];
  level.teamspawnpoints["allies"] = [];
  level.teamspawnpoints["neutral"] = [];
  jumpiffalse(level.teamflags.size == 2) LOC_00000220;
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
      var_9.teambase = var_2.ownerteam;
      level.teamspawnpoints[var_9.teambase][level.teamspawnpoints[var_9.teambase].size] = var_9;
      continue;
    }

    if(var_13 > 0.67) {
      var_9.teambase = var_3.ownerteam;
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

  return var_2.ownerteam;
}

function getspawnpoint() {
  var_0 = self.pers["team"];
  var_1 = scripts\mp\utility\game::getotherteam(var_0)[0];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(level.mapname == "mp_runner") {
      var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];
      var_1 = scripts\mp\utility\game::getotherteam(var_1)[0];
    }

    jumpiffalse(game["switchedsides"]) LOC_0000006d;
    var_2 = scripts\mp\spawnlogic::getspawnpointarray("mp_ctf_spawn_" + var_1 + "_start");
    var_3 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_2);
    goto LOC_0000008b;
  } else {
    var_3 = scripts\mp\spawnlogic::getspawnpoint(self, var_2, level.ctfteamspawnsetids[var_2], "neutral");
  }

  return var_3;
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

  if(istrue(game["switchedsides"])) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  foreach(var_3 in level.flags) {
    switch (var_3.script_label) {
      case "_a":
        if(istrue(game["switchedsides"])) {
          level.default_flag_origins[game["defenders"]] = var_3.origin;
        } else {
          level.default_flag_origins[game["attackers"]] = var_3.origin;
        }

        break;
      case "_c":
        if(istrue(game["switchedsides"])) {
          level.default_flag_origins[game["attackers"]] = var_3.origin;
        } else {
          level.default_flag_origins[game["defenders"]] = var_3.origin;
        }

        break;
    }
  }

  var_5 = getEnt("ctf_zone_" + game["defenders"], "targetname");

  if(isDefined(var_5)) {
    if(istrue(game["switchedsides"])) {
      level.default_flag_origins[game["attackers"]] = var_5.origin;
    } else {
      level.default_flag_origins[game["defenders"]] = var_5.origin;
    }
  }

  var_5 = getEnt("ctf_zone_" + game["attackers"], "targetname");

  if(isDefined(var_5)) {
    if(istrue(game["switchedsides"])) {
      level.default_flag_origins[game["defenders"]] = var_5.origin;
      return;
    }

    level.default_flag_origins[game["attackers"]] = var_5.origin;
    return;
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

function createteamflag(var_0, var_1) {
  var_2 = 0;
  var_3 = flag_create_team_goal(var_0);
  var_4 = spawn("trigger_radius", var_3.origin - (0, 0, var_3.radius / 2), 0, var_3.radius, 80);
  var_4.no_moving_platfrom_unlink = 1;
  var_4.linktoenabledflag = 1;
  var_4.baseorigin = var_4.origin;
  var_2 = 1;
  GscBinSkip1(0x45, 0, spawn("script_model", var_3.origin));
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
  var_6 scripts\mp\gameobjects::allowuse("enemy");
  var_6 scripts\mp\gameobjects::setvisibleteam("any");
  var_6 scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupdefendflag, level.icongoalflag);
  var_6 scripts\mp\gameobjects::setusetime(0);
  var_6 scripts\mp\gameobjects::setkeyobject(level.teamflags[scripts\mp\utility\game::getotherteam(var_0)[0]]);
  var_6.onuse = &onuse;
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
  var_3 = var_0.pers["team"];

  if(var_3 == "allies") {
    var_4 = "axis";
  } else {
    var_4 = "allies";
  }

  if(var_4 != scripts\mp\gameobjects::getownerteam()) {
    if(isDefined(level.closecapturekiller[var_1.team]) && level.closecapturekiller[var_1.team] == var_1) {
      var_1 thread scripts\mp\awards::givemidmatchaward("mode_ctf_nope");
    }

    level.closecapturekiller[var_1.team] = undefined;
    var_1 thread scripts\mp\utility\points::giveunifiedpoints("flag_return");
    thread returnflag(var_4);
    var_1 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "obj_return", var_1.origin);
    scripts\mp\utility\sound::playsoundonplayers("mp_obj_returned", var_4);
    scripts\mp\utility\sound::playsoundonplayers("mp_obj_returned", scripts\mp\utility\game::getotherteam(var_4)[0]);
    scripts\mp\utility\dialog::leaderdialog("ourblitzflag_return", var_4, "status");
    scripts\mp\utility\dialog::leaderdialog("enemyblitzflag_return", var_4, "status");
    var_1 scripts\mp\utility\stats::incpersstat("returns", 1);
    var_1 scripts\mp\persistence::statsetchild("round", "returns", var_1.pers["returns"]);

    if(isPlayer(var_1)) {
      var_1 scripts\mp\utility\stats::setextrascore1(var_1.pers["returns"]);
      return;
    }

    return;
  }

  if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[var_4])) {
    thread applyflagcarrierclass();
  } else {
    attachflag(var_1);
  }

  self.atbase = 0;
  level.closecapturekiller[var_4] = undefined;

  if(var_1.team == "allies") {
    setomnvar("ui_ctf_flag_allies", var_1 getentitynumber());
  } else {
    setomnvar("ui_ctf_flag_axis", var_1 getentitynumber());
  }

  var_1 setclientomnvar("ui_ctf_flag_carrier", 1);

  if(isDefined(level.showenemycarrier)) {
    if(level.showenemycarrier == 0) {
      scripts\mp\gameobjects::setvisibleteam("any");
    } else {
      scripts\mp\gameobjects::setvisibleteam("any");
    }
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.iconescort, level.iconkill);

  if(level.teamflags[var_4].atbase) {
    level.capzones[var_4] scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupdefendflag, level.icongoalflag);
  } else {
    level.capzones[var_4] scripts\mp\gameobjects::setvisibleteam("any");
    level.capzones[var_4] scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendflag, level.icongoalflag);
  }

  level.capzones[var_4] scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendflag, level.icongoalflag);

  if(level.capturecondition == 0) {}

  scripts\mp\utility\sound::playsoundonplayers("mp_obj_taken", var_4);
  scripts\mp\utility\dialog::leaderdialog("ourblitzflag_taken", var_4);
  thread scripts\mp\hud_util::teamplayercardsplash("callout_flagpickup", var_1);

  if(!isDefined(self.previouscarrier) || self.previouscarrier != var_1) {
    var_1 thread scripts\mp\utility\points::giveunifiedpoints("flag_grab");
  }

  var_1 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "pickup", var_1.origin);
  self.previouscarrier = var_1;

  if(level.codcasterenabled) {
    var_1 setgametypevip(1);
    return;
  }
}

function returnflag(var_0) {
  self.atbase = 1;

  if(var_0 == "allies") {
    setomnvar("ui_ctf_flag_allies", -2);
  } else {
    setomnvar("ui_ctf_flag_axis", -2);
  }

  scripts\mp\gameobjects::returnhome();
}

function ondrop(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = scripts\mp\utility\game::getotherteam(var_1)[0];
  scripts\mp\gameobjects::allowcarry("any");
  scripts\mp\gameobjects::setvisibleteam("any");
  objective_setpings(self.objidnum, 0);

  if(level.returntime >= 0) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupflag, level.iconreturnflag);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupflag, level.icongoalflag);
  }

  if(var_1 == "allies") {
    setomnvar("ui_ctf_flag_allies", -1);
  } else {
    setomnvar("ui_ctf_flag_axis", -1);
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

    scripts\mp\utility\sound::playsoundonplayers("mp_war_objective_lost", var_2);

    if(level.codcasterenabled) {
      var_0 setgametypevip(0);
    }
  } else {
    scripts\mp\utility\sound::playsoundonplayers("mp_war_objective_lost", var_2);
  }

  scripts\mp\utility\dialog::leaderdialog("enemyblitzflag_drop", var_2, "status");
  scripts\mp\utility\dialog::leaderdialog("ourblitzflag_drop", var_1, "status");

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
  var_0 = scripts\mp\gameobjects::getownerteam();
  var_1 = scripts\mp\utility\game::getotherteam(var_0)[0];
  scripts\mp\gameobjects::allowcarry("friendly");
  scripts\mp\gameobjects::setvisibleteam("none");
  objective_setpings(self.objidnum, 0);

  if(var_0 == "allies") {
    setomnvar("ui_ctf_flag_allies", -2);
  } else {
    setomnvar("ui_ctf_flag_axis", -2);
  }

  if(level.teamflags[var_0].atbase) {
    level.capzones[var_0] scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupdefendflag, level.icongoalflag);
  }

  if(level.teamflags[var_1].atbase) {
    level.capzones[var_0] scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupdefendflag, level.icongoalflag);
  } else {
    level.capzones[var_0] scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendflag, level.icongoalflag);
  }

  level.capzones[var_0] scripts\mp\gameobjects::allowuse("enemy");
  self.previouscarrier = undefined;
}

function onresetstart(var_0) {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosingflag, level.iconresettingflag);
}

function onresetend(var_0, var_1, var_2) {
  if(!var_2) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupflag, level.iconreturnflag);
    return;
  }
}

function onuse(var_0) {
  if(!level.gameended) {
    var_1 = var_0.pers["team"];

    if(var_1 == "allies") {
      var_2 = "axis";
    } else {
      var_2 = "allies";
    }

    var_1 setclientomnvar("ui_ctf_flag_carrier", 0);
    scripts\mp\utility\dialog::leaderdialog("ourblitzflag_capt", var_2, "status");
    scripts\mp\utility\dialog::leaderdialog("enemyblitzflag_capt", var_2, "status");
    thread scripts\mp\hud_util::teamplayercardsplash("callout_flagcapture", var_1);
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

    scripts\mp\utility\sound::playsoundonplayers("mp_obj_captured", var_2);
    scripts\mp\utility\sound::playsoundonplayers("mp_enemy_obj_captured", scripts\mp\utility\game::getotherteam(var_2)[0]);

    if(isDefined(var_1.carryflag)) {
      detachflag(var_1);
    }

    if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[var_2])) {
      thread removeflagcarrierclass();
    }

    level.closecapturekiller[var_2] = undefined;
    level.closecapturekiller[var_2] = undefined;

    if(level.teamflags[scripts\mp\utility\game::getotherteam(var_2)[0]].atbase) {
      level scripts\mp\gamescore::giveteamscoreforobjective(var_2, 2, 0);
    } else {
      level scripts\mp\gamescore::giveteamscoreforobjective(var_2, 1, 0);
    }

    returnflag(level.teamflags[var_2], var_2);
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
      var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
      var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
      thread scripts\common\utility::ref_13e0a(level.ref_11b30, var_9, "carrying");
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
        var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
        thread scripts\common\utility::ref_13e0a(level.ref_11b30, var_9, "defending");
      } else if(var_15) {
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

function setupwaypointicons() {
  level.waypointcolors["waypoint_blitz_kill"] = "enemy";
  level.waypointbgtype["waypoint_blitz_kill"] = 1;
  level.waypointstring["waypoint_blitz_kill"] = "MP_INGAME_ONLY/OBJ_KILL_CAPS";
  level.waypointshader["waypoint_blitz_kill"] = "icon_waypoint_kill";
  level.waypointpulses["waypoint_blitz_kill"] = 0;
  level.waypointcolors["waypoint_blitz_pickup"] = "friendly";
  level.waypointbgtype["waypoint_blitz_pickup"] = 0;
  level.waypointstring["waypoint_blitz_pickup"] = "MP_INGAME_ONLY/OBJ_PICKUP_CAPS";
  level.waypointshader["waypoint_blitz_pickup"] = "icon_waypoint_flag";
  level.waypointpulses["waypoint_blitz_pickup"] = 1;
  level.waypointcolors["waypoint_blitz_goal"] = "enemy";
  level.waypointbgtype["waypoint_blitz_goal"] = 0;
  level.waypointstring["waypoint_blitz_goal"] = "MP_INGAME_ONLY/OBJ_TARGET_CAPS";
  level.waypointshader["waypoint_blitz_goal"] = "icon_waypoint_cyber_bombsite";
  level.waypointpulses["waypoint_blitz_goal"] = 0;
  level.waypointcolors["waypoint_blitz_escort"] = "friendly";
  level.waypointbgtype["waypoint_blitz_escort"] = 2;
  level.waypointstring["waypoint_blitz_escort"] = "MP_INGAME_ONLY/OBJ_ESCORT_CAPS";
  level.waypointshader["waypoint_blitz_escort"] = "icon_waypoint_flag";
  level.waypointpulses["waypoint_blitz_escort"] = 0;
  level.waypointcolors["waypoint_blitz_defend"] = "friendly";
  level.waypointbgtype["waypoint_blitz_defend"] = 0;
  level.waypointstring["waypoint_blitz_defend"] = "MP_INGAME_ONLY/OBJ_DEFEND_CAPS";
  level.waypointshader["waypoint_blitz_defend"] = "icon_waypoint_cyber_bombsite";
  level.waypointpulses["waypoint_blitz_defend"] = 0;
  level.waypointcolors["waypoint_blitz_reset"] = "friendly";
  level.waypointbgtype["waypoint_blitz_reset"] = 0;
  level.waypointstring["waypoint_blitz_reset"] = "MP_INGAME_ONLY/OBJ_RESET_CAPS";
  level.waypointshader["waypoint_blitz_reset"] = "icon_waypoint_flag";
  level.waypointpulses["waypoint_blitz_reset"] = 0;
  level.waypointcolors["waypoint_blitz_resetting"] = "enemy";
  level.waypointbgtype["waypoint_blitz_resetting"] = 0;
  level.waypointstring["waypoint_blitz_resetting"] = "MP_INGAME_ONLY/OBJ_RESETTING_CAPS";
  level.waypointshader["waypoint_blitz_resetting"] = "icon_waypoint_flag";
  level.waypointpulses["waypoint_blitz_resetting"] = 0;
  level.waypointcolors["waypoint_blitz_pickup_losing"] = "friendly";
  level.waypointbgtype["waypoint_blitz_pickup_losing"] = 0;
  level.waypointstring["waypoint_blitz_pickup_losing"] = "MP_INGAME_ONLY/OBJ_PICKUP_CAPS";
  level.waypointshader["waypoint_blitz_pickup_losing"] = "icon_waypoint_flag";
  level.waypointpulses["waypoint_blitz_pickup_losing"] = 1;
  level.waypointcolors["waypoint_blitz_pickup_defend"] = "friendly";
  level.waypointbgtype["waypoint_blitz_pickup_defend"] = 0;
  level.waypointstring["waypoint_blitz_pickup_defend"] = "MP_INGAME_ONLY/OBJ_PICKUP_DEFEND_CAPS";
  level.waypointshader["waypoint_blitz_pickup_defend"] = "icon_waypoint_flag";
  level.waypointpulses["waypoint_blitz_pickup_defend"] = 0;
}