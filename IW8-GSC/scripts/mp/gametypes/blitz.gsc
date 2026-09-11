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
  var0 = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype);
  var1 = scripts\mp\spawnlogic::ispathdataavailable();
  level.teamspawnpoints["axis"] = [];
  level.teamspawnpoints["allies"] = [];
  level.teamspawnpoints["neutral"] = [];
  jumpiffalse(level.teamflags.size == 2) LOC_00000220;
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
      var9.teambase = var2.ownerteam;
      level.teamspawnpoints[var9.teambase][level.teamspawnpoints[var9.teambase].size] = var9;
      continue;
    }

    if(var13 > 0.67) {
      var9.teambase = var3.ownerteam;
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

  return var2.ownerteam;
}

function getspawnpoint() {
  var0 = self.pers["team"];
  var1 = scripts\mp\utility\game::getotherteam(var0)[0];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(level.mapname == "mp_runner") {
      var0 = scripts\mp\utility\game::getotherteam(var0)[0];
      var1 = scripts\mp\utility\game::getotherteam(var1)[0];
    }

    jumpiffalse(game["switchedsides"]) LOC_0000006d;
    var2 = scripts\mp\spawnlogic::getspawnpointarray("mp_ctf_spawn_" + var1 + "_start");
    var3 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var2);
    goto LOC_0000008b;
  } else {
    var3 = scripts\mp\spawnlogic::getspawnpoint(self, var2, level.ctfteamspawnsetids[var2], "neutral");
  }

  return var3;
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
    var0 = game["attackers"];
    var1 = game["defenders"];
    game["attackers"] = var1;
    game["defenders"] = var0;
  }

  foreach(var3 in level.flags) {
    switch (var3.script_label) {
      case "_a":
        if(istrue(game["switchedsides"])) {
          level.default_flag_origins[game["defenders"]] = var3.origin;
        } else {
          level.default_flag_origins[game["attackers"]] = var3.origin;
        }

        break;
      case "_c":
        if(istrue(game["switchedsides"])) {
          level.default_flag_origins[game["attackers"]] = var3.origin;
        } else {
          level.default_flag_origins[game["defenders"]] = var3.origin;
        }

        break;
    }
  }

  var5 = getEnt("ctf_zone_" + game["defenders"], "targetname");

  if(isDefined(var5)) {
    if(istrue(game["switchedsides"])) {
      level.default_flag_origins[game["attackers"]] = var5.origin;
    } else {
      level.default_flag_origins[game["defenders"]] = var5.origin;
    }
  }

  var5 = getEnt("ctf_zone_" + game["attackers"], "targetname");

  if(isDefined(var5)) {
    if(istrue(game["switchedsides"])) {
      level.default_flag_origins[game["defenders"]] = var5.origin;
      return;
    }

    level.default_flag_origins[game["attackers"]] = var5.origin;
    return;
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

function createteamflag(var0, var1) {
  var2 = 0;
  var3 = flag_create_team_goal(var0);
  var4 = spawn("trigger_radius", var3.origin - (0, 0, var3.radius / 2), 0, var3.radius, 80);
  var4.no_moving_platfrom_unlink = 1;
  var4.linktoenabledflag = 1;
  var4.baseorigin = var4.origin;
  var2 = 1;
  GscBinSkip1(0x45, 0, spawn("script_model", var3.origin));
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
  var6 scripts\mp\gameobjects::allowuse("enemy");
  var6 scripts\mp\gameobjects::setvisibleteam("any");
  var6 scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupdefendflag, level.icongoalflag);
  var6 scripts\mp\gameobjects::setusetime(0);
  var6 scripts\mp\gameobjects::setkeyobject(level.teamflags[scripts\mp\utility\game::getotherteam(var0)[0]]);
  var6.onuse = &onuse;
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
  var3 = var0.pers["team"];

  if(var3 == "allies") {
    var4 = "axis";
  } else {
    var4 = "allies";
  }

  if(var4 != scripts\mp\gameobjects::getownerteam()) {
    if(isDefined(level.closecapturekiller[var1.team]) && level.closecapturekiller[var1.team] == var1) {
      var1 thread scripts\mp\awards::givemidmatchaward("mode_ctf_nope");
    }

    level.closecapturekiller[var1.team] = undefined;
    var1 thread scripts\mp\utility\points::giveunifiedpoints("flag_return");
    thread returnflag(var4);
    var1 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "obj_return", var1.origin);
    scripts\mp\utility\sound::playsoundonplayers("mp_obj_returned", var4);
    scripts\mp\utility\sound::playsoundonplayers("mp_obj_returned", scripts\mp\utility\game::getotherteam(var4)[0]);
    scripts\mp\utility\dialog::leaderdialog("ourblitzflag_return", var4, "status");
    scripts\mp\utility\dialog::leaderdialog("enemyblitzflag_return", var4, "status");
    var1 scripts\mp\utility\stats::incpersstat("returns", 1);
    var1 scripts\mp\persistence::statsetchild("round", "returns", var1.pers["returns"]);

    if(isPlayer(var1)) {
      var1 scripts\mp\utility\stats::setextrascore1(var1.pers["returns"]);
      return;
    }

    return;
  }

  if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[var4])) {
    thread applyflagcarrierclass();
  } else {
    attachflag(var1);
  }

  self.atbase = 0;
  level.closecapturekiller[var4] = undefined;

  if(var1.team == "allies") {
    setomnvar("ui_ctf_flag_allies", var1 getentitynumber());
  } else {
    setomnvar("ui_ctf_flag_axis", var1 getentitynumber());
  }

  var1 setclientomnvar("ui_ctf_flag_carrier", 1);

  if(isDefined(level.showenemycarrier)) {
    if(level.showenemycarrier == 0) {
      scripts\mp\gameobjects::setvisibleteam("any");
    } else {
      scripts\mp\gameobjects::setvisibleteam("any");
    }
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.iconescort, level.iconkill);

  if(level.teamflags[var4].atbase) {
    level.capzones[var4] scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupdefendflag, level.icongoalflag);
  } else {
    level.capzones[var4] scripts\mp\gameobjects::setvisibleteam("any");
    level.capzones[var4] scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendflag, level.icongoalflag);
  }

  level.capzones[var4] scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendflag, level.icongoalflag);

  if(level.capturecondition == 0) {}

  scripts\mp\utility\sound::playsoundonplayers("mp_obj_taken", var4);
  scripts\mp\utility\dialog::leaderdialog("ourblitzflag_taken", var4);
  thread scripts\mp\hud_util::teamplayercardsplash("callout_flagpickup", var1);

  if(!isDefined(self.previouscarrier) || self.previouscarrier != var1) {
    var1 thread scripts\mp\utility\points::giveunifiedpoints("flag_grab");
  }

  var1 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "pickup", var1.origin);
  self.previouscarrier = var1;

  if(level.codcasterenabled) {
    var1 setgametypevip(1);
    return;
  }
}

function returnflag(var0) {
  self.atbase = 1;

  if(var0 == "allies") {
    setomnvar("ui_ctf_flag_allies", -2);
  } else {
    setomnvar("ui_ctf_flag_axis", -2);
  }

  scripts\mp\gameobjects::returnhome();
}

function ondrop(var0) {
  var1 = scripts\mp\gameobjects::getownerteam();
  var2 = scripts\mp\utility\game::getotherteam(var1)[0];
  scripts\mp\gameobjects::allowcarry("any");
  scripts\mp\gameobjects::setvisibleteam("any");
  objective_setpings(self.objidnum, 0);

  if(level.returntime >= 0) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupflag, level.iconreturnflag);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupflag, level.icongoalflag);
  }

  if(var1 == "allies") {
    setomnvar("ui_ctf_flag_allies", -1);
  } else {
    setomnvar("ui_ctf_flag_axis", -1);
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

    scripts\mp\utility\sound::playsoundonplayers("mp_war_objective_lost", var2);

    if(level.codcasterenabled) {
      var0 setgametypevip(0);
    }
  } else {
    scripts\mp\utility\sound::playsoundonplayers("mp_war_objective_lost", var2);
  }

  scripts\mp\utility\dialog::leaderdialog("enemyblitzflag_drop", var2, "status");
  scripts\mp\utility\dialog::leaderdialog("ourblitzflag_drop", var1, "status");

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
  var0 = scripts\mp\gameobjects::getownerteam();
  var1 = scripts\mp\utility\game::getotherteam(var0)[0];
  scripts\mp\gameobjects::allowcarry("friendly");
  scripts\mp\gameobjects::setvisibleteam("none");
  objective_setpings(self.objidnum, 0);

  if(var0 == "allies") {
    setomnvar("ui_ctf_flag_allies", -2);
  } else {
    setomnvar("ui_ctf_flag_axis", -2);
  }

  if(level.teamflags[var0].atbase) {
    level.capzones[var0] scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupdefendflag, level.icongoalflag);
  }

  if(level.teamflags[var1].atbase) {
    level.capzones[var0] scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupdefendflag, level.icongoalflag);
  } else {
    level.capzones[var0] scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendflag, level.icongoalflag);
  }

  level.capzones[var0] scripts\mp\gameobjects::allowuse("enemy");
  self.previouscarrier = undefined;
}

function onresetstart(var0) {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosingflag, level.iconresettingflag);
}

function onresetend(var0, var1, var2) {
  if(!var2) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupflag, level.iconreturnflag);
    return;
  }
}

function onuse(var0) {
  if(!level.gameended) {
    var1 = var0.pers["team"];

    if(var1 == "allies") {
      var2 = "axis";
    } else {
      var2 = "allies";
    }

    var1 setclientomnvar("ui_ctf_flag_carrier", 0);
    scripts\mp\utility\dialog::leaderdialog("ourblitzflag_capt", var2, "status");
    scripts\mp\utility\dialog::leaderdialog("enemyblitzflag_capt", var2, "status");
    thread scripts\mp\hud_util::teamplayercardsplash("callout_flagcapture", var1);
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

    scripts\mp\utility\sound::playsoundonplayers("mp_obj_captured", var2);
    scripts\mp\utility\sound::playsoundonplayers("mp_enemy_obj_captured", scripts\mp\utility\game::getotherteam(var2)[0]);

    if(isDefined(var1.carryflag)) {
      detachflag(var1);
    }

    if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[var2])) {
      thread removeflagcarrierclass();
    }

    level.closecapturekiller[var2] = undefined;
    level.closecapturekiller[var2] = undefined;

    if(level.teamflags[scripts\mp\utility\game::getotherteam(var2)[0]].atbase) {
      level scripts\mp\gamescore::giveteamscoreforobjective(var2, 2, 0);
    } else {
      level scripts\mp\gamescore::giveteamscoreforobjective(var2, 1, 0);
    }

    returnflag(level.teamflags[var2], var2);
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
      var1 scripts\mp\utility\stats::incpersstat("defends", 1);
      var1 scripts\mp\persistence::statsetchild("round", "defends", var1.pers["defends"]);
      thread scripts\common\utility::ref_13e0a(level.ref_11b30, var9, "carrying");
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
        var1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
        thread scripts\common\utility::ref_13e0a(level.ref_11b30, var9, "defending");
      } else if(var15) {
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