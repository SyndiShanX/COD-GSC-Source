/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\ctf.gsc
***********************************************/

#using script_4a6760982b403bad;
#using script_548072087c9fd504;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\equipment\tac_insert;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\stats;
#namespace ctf;

function main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  flag_default_origins();
  allowed[0] = "ctf";
  scripts\mp\gameobjects::main(allowed);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread reinitializematchrulesonmigration();
  } else {
    registertimelimitdvar(getgametype(), 300);
    registerscorelimitdvar(getgametype(), 3);
    registerroundlimitdvar(getgametype(), 2);
    registerwinlimitdvar(getgametype(), 1);
    registernumlivesdvar(getgametype(), 0);
    registerhalftimedvar(getgametype(), 0);
    registerroundswitchdvar(getgametype(), 1, 0, 1);
  }

  updategametypedvars();

  if(level.winrule) {
    level.wingamebytype = "teamScores";
  } else {
    level.wingamebytype = "roundsWon";
  }

  level.teambased = 1;
  level.objectivebased = 1;
  level.overtimescorewinoverride = 1;
  level.onstartgametype = &onstartgametype;
  level.onplayerconnect = &onplayerconnect;
  level.getspawnpoint = &getspawnpoint;
  level.onplayerkilled = &onplayerkilled;
  level.modeonspawnplayer = &onspawnplayer;
  level.onmaprestart = &function_9136c8e96ae14d11;
  level.resetscoreonroundstart = &function_3f98ea23e8fa1954;
  level.spawnnodetype = "mp_ctf_spawn";

  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    game["dialog"]["gametype"] = "iw9_mpcf_mode_uktl_cft1";
  } else {
    game["dialog"]["gametype"] = "gametype_ctf";
  }

  game["dialog"]["boost"] = "boost_ctf";
  game["dialog"]["offense_obj"] = "boost_ctf";
  game["dialog"]["defense_obj"] = "boost_ctf";
  game["dialog"]["flag_taken"] = "ourflag_taken";
  game["dialog"]["flag_dropped"] = "ourflag_drop";
  game["dialog"]["flag_returned"] = "ourflag_return";
  game["dialog"]["flag_captured"] = "ourflag_capt";
  game["dialog"]["flag_getback"] = "ourflag_getback";
  game["dialog"]["enemy_flag_bringhome"] = "enemyflag_tobase";
  game["dialog"]["enemy_flag_taken"] = "enemyflag_taken";
  game["dialog"]["enemy_flag_dropped"] = "enemyflag_drop";
  game["dialog"]["enemy_flag_returned"] = "enemyflag_return";
  game["dialog"]["enemy_flag_captured"] = "enemyflag_capt";
  setomnvar("ui_ctf_flag_axis", -2);
  setomnvar("ui_ctf_flag_allies", -2);
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  setdynamicdvar(@ "hash_d1d5e42ea50e97bd", getmatchrulesdata("ctfData", "winRule"));
  setdynamicdvar(@ "hash_a2d431c4aaa9315c", getmatchrulesdata("ctfData", "captureCondition"));
  setdynamicdvar(@ "hash_5cec825b941e1a68", getmatchrulesdata("ctfData", "returnTime"));
  setdynamicdvar(@ "hash_f4a43cc54d1c9b3a", getmatchrulesdata("carryData", "showEnemyCarrier"));
  setdynamicdvar(@ "hash_58c0e8ca6390c725", getmatchrulesdata("carryData", "idleResetTime"));
  setdynamicdvar(@ "hash_97ede3296a3d49d2", getmatchrulesdata("carryData", "pickupTime"));
  setdynamicdvar(@ "hash_82f42dfd88cbacad", getmatchrulesdata("carryData", "manualDropEnabled"));
  setdynamicdvar(@ "hash_95c5d19271613c1f", 0);
  registerhalftimedvar("ctf", 0);
}

function onspawnplayer(revivespawn) {
  updatematchstatushintonnoflag();
}

function onstartgametype() {
  inot = inovertime();
  var_31e2a8f506168626 = game["overtimeRoundsPlayed"] == 0;
  var_c640a385cfd8bb75 = istimetobeatvalid();

  if(inot) {
    if(var_31e2a8f506168626) {
      setomnvar("ui_round_hint_override_attackers", 1);
      setomnvar("ui_round_hint_override_defenders", 1);
    } else if(var_c640a385cfd8bb75) {
      setomnvar("ui_round_hint_override_attackers", ter_op(game["timeToBeatTeam"] == game["attackers"], 2, 3));
      setomnvar("ui_round_hint_override_defenders", ter_op(game["timeToBeatTeam"] == game["defenders"], 2, 3));
    } else {
      setomnvar("ui_round_hint_override_attackers", 4);
      setomnvar("ui_round_hint_override_defenders", 4);
    }
  }

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(inovertime()) {
    setDvar(@ "hash_8ecb43b0c41972de", 0);
  } else if(game["switchedsides"]) {
    setDvar(@ "hash_8ecb43b0c41972de", 2);
  } else {
    setDvar(@ "hash_8ecb43b0c41972de", 1);
  }

  if(!isDefined(game["original_defenders"])) {
    game["original_defenders"] = game["defenders"];
  }

  if(game["switchedsides"]) {
    oldattackers = game["attackers"];
    olddefenders = game["defenders"];
    game["attackers"] = olddefenders;
    game["defenders"] = oldattackers;
  }

  setclientnamemode("auto_change");

  if(level.splitscreen) {
    setobjectivescoretext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER");
    setobjectivescoretext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER");
  } else {
    setobjectivescoretext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER_SCORE");
    setobjectivescoretext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER_SCORE");
  }

  setobjectivetext(game["attackers"], &"OBJECTIVES/CTF");
  setobjectivetext(game["defenders"], &"OBJECTIVES/CTF");
  setobjectivehinttext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER_HINT");
  setobjectivehinttext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER_HINT");
  flag_setupvfx();
  createflagsandhud();
  initspawns();

  thread function_2f8e8b92f965d936();

  thread removeflag();
  thread placeflag();
}

function updategametypedvars() {
  updatecommongametypedvars();
  level.winrule = dvarintvalue("winRule", 0, 0, 1);
  level.showenemycarrier = dvarintvalue("showEnemyCarrier", 5, 0, 6);
  level.idleresettime = dvarfloatvalue("idleResetTime", 30, 0, 60);
  level.capturecondition = dvarintvalue("captureCondition", 0, 0, 1);
  level.pickuptime = dvarfloatvalue("pickupTime", 0, 0, 10);
  level.returntime = dvarfloatvalue("returnTime", 0, -1, 25);
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
  level.teamflags[game["defenders"]] = createteamflag(game["defenders"], "axis");
  level.teamflags[game["attackers"]] = createteamflag(game["attackers"], "allies");
  level.capzones[game["defenders"]] = createcapzone(game["defenders"], "axis");
  level.capzones[game["attackers"]] = createcapzone(game["attackers"], "allies");
  scripts\mp\objidpoolmanager::objective_show_for_mlg_spectator(level.capzones[game["defenders"]].objidnum, 1);
  scripts\mp\objidpoolmanager::objective_show_for_mlg_spectator(level.capzones[game["attackers"]].objidnum, 1);
}

function flag_setupvfx() {}

function initspawns() {
  if(spawnlogic::function_bff229a11ecd1e34()) {
    spawnlogic::setactivespawnlogic(#"default");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("AwayFromEnemies", "Crit_Default");
  }

  level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
  level.spawnmaxs = (-2147483647, -2147483647, -2147483647);
  spawnkey = "ctf";
  var_ba6687ab13d4dce0 = scripts\mp\spawnlogic::function_b17bf43316b9fb08(spawnkey);

  if(var_ba6687ab13d4dce0) {
    scripts\mp\spawnlogic::initspawnlist(spawnkey, 1, "start_attacker", "start_defender");
    scripts\mp\spawnlogic::initspawnlist(spawnkey, 0, "spawn", "spawn");
  } else {
    scripts\mp\spawnlogic::addstartspawnpoints("mp_ctf_spawn_allies_start");
    scripts\mp\spawnlogic::addstartspawnpoints("mp_ctf_spawn_axis_start");
    scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_ctf_spawn_allies_start");
    scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_ctf_spawn_axis_start");
    attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_ctf_spawn_allies_start");
    defenders = scripts\mp\spawnlogic::getspawnpointarray("mp_ctf_spawn_axis_start");
    scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
    scripts\mp\spawnlogic::registerspawnset("start_defenders", defenders);
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_ctf_spawn");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_ctf_spawn");
  }

  assignteamspawns(var_ba6687ab13d4dce0, spawnkey, "spawn");
  level.ctfteamspawnsetids["allies"] = "primary_allies";
  level.ctfteamspawnsetids["axis"] = "primary_axis";
  scripts\mp\spawnlogic::registerspawnset("primary_allies", level.teamspawnpoints["allies"]);
  scripts\mp\spawnlogic::registerspawnset("primary_axis", level.teamspawnpoints["axis"]);
  scripts\mp\spawnlogic::registerspawnset("primary_neutral", level.teamspawnpoints["neutral"]);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function assignteamspawns(var_8719ff6e31a3d80b, spawnkey, spawnvalue) {
  if(var_8719ff6e31a3d80b) {
    spawnpoints = scripts\mp\spawnlogic::function_5cb7f8468d3b9fe0(spawnkey, spawnvalue);
  } else {
    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype);
  }

  ispathdataavailable = scripts\mp\spawnlogic::ispathdataavailable();
  level.teamspawnpoints["axis"] = [];
  level.teamspawnpoints["allies"] = [];
  level.teamspawnpoints["neutral"] = [];

  if(level.teamflags.size == 2) {
    flaga = level.teamflags["allies"];
    flagb = level.teamflags["axis"];
    var_22d30d2db06d47ea = (flaga.curorigin[0], flaga.curorigin[1], 0);
    var_4f73762dd18a9b93 = (flagb.curorigin[0], flagb.curorigin[1], 0);
    flagdelta = var_4f73762dd18a9b93 - var_22d30d2db06d47ea;
    flagdist = length2d(flagdelta);

    foreach(spawnpoint in spawnpoints) {
      var_c982049ea3238d92 = (spawnpoint.origin[0], spawnpoint.origin[1], 0);
      var_9af7b82de70e01d8 = var_c982049ea3238d92 - var_22d30d2db06d47ea;
      dotvalue = vectordot(var_9af7b82de70e01d8, flagdelta);
      var_a40d2cea46f228ca = dotvalue / flagdist * flagdist;

      if(var_a40d2cea46f228ca < 0.33) {
        spawnpoint.teambase = getotherteam(flaga.ownerteam)[0];
        level.teamspawnpoints[spawnpoint.teambase][level.teamspawnpoints[spawnpoint.teambase].size] = spawnpoint;
        continue;
      }

      if(var_a40d2cea46f228ca > 0.67) {
        spawnpoint.teambase = getotherteam(flagb.ownerteam)[0];
        level.teamspawnpoints[spawnpoint.teambase][level.teamspawnpoints[spawnpoint.teambase].size] = spawnpoint;
        continue;
      }

      var_5838748bf91be3c2 = undefined;
      var_d11e294724d3abcb = undefined;

      if(ispathdataavailable) {
        var_5838748bf91be3c2 = getpathdist(spawnpoint.origin, flaga.curorigin, 999999);
      }

      if(isDefined(var_5838748bf91be3c2) && var_5838748bf91be3c2 != -1) {
        var_d11e294724d3abcb = getpathdist(spawnpoint.origin, flagb.curorigin, 999999);
      }

      if(!isDefined(var_d11e294724d3abcb) || var_d11e294724d3abcb == -1) {
        var_5838748bf91be3c2 = distance2d(flaga.curorigin, spawnpoint.origin);
        var_d11e294724d3abcb = distance2d(flagb.curorigin, spawnpoint.origin);
      }

      var_7c7809cdc3f571e5 = max(var_5838748bf91be3c2, var_d11e294724d3abcb);
      var_126715ed2b04d65f = min(var_5838748bf91be3c2, var_d11e294724d3abcb);
      distpercent = var_126715ed2b04d65f / var_7c7809cdc3f571e5;

      if(distpercent > 0.5) {
        level.teamspawnpoints["neutral"][level.teamspawnpoints["neutral"].size] = spawnpoint;
      }
    }

    return;
  }

  foreach(spawnpoint in spawnpoints) {
    spawnpoint.teambase = getnearestflagteam(spawnpoint);

    if(spawnpoint.teambase == "axis") {
      level.teamspawnpoints["axis"][level.teamspawnpoints["axis"].size] = spawnpoint;
      continue;
    }

    level.teamspawnpoints["allies"][level.teamspawnpoints["allies"].size] = spawnpoint;
  }
}

function getnearestflagteam(spawnpoint) {
  ispathdataavailable = scripts\mp\spawnlogic::ispathdataavailable();
  nearestflag = undefined;
  nearestdist = undefined;

  foreach(flag in level.teamflags) {
    dist = undefined;

    if(ispathdataavailable) {
      dist = getpathdist(spawnpoint.origin, flag.curorigin, 999999);
    }

    if(!isDefined(dist) || dist == -1) {
      dist = distancesquared(flag.curorigin, spawnpoint.origin);
    }

    if(!isDefined(nearestflag) || dist < nearestdist) {
      nearestflag = flag;
      nearestdist = dist;
    }
  }

  return getotherteam(nearestflag.ownerteam)[0];
}

function getspawnpoint() {
  spawnteam = self.pers["team"];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    spawnpoint = scripts\mp\spawnlogic::function_542d0780ea7c537d(self, spawnteam);
  } else {
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, level.ctfteamspawnsetids[spawnteam], "primary_neutral");
  }

  return spawnpoint;
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

  foreach(flag in level.flags) {
    switch (flag.script_label) {
      case #"hash_fac2c5f6bddd49bd":
        level.default_flag_origins[game["attackers"]] = flag.origin;
        break;
      case #"hash_fac2c3f6bddd4697":
        level.default_flag_origins[game["defenders"]] = flag.origin;
        break;
    }
  }
}

function flag_create_team_goal(team) {
  goal = spawnStruct();

  if(!isDefined(goal.origin)) {
    goal.origin = level.default_flag_origins[team];
  }

  goal flag_find_ground();
  goal.origin = goal.ground_origin;
  goal.radius = 30;
  goal.team = team;
  goal.ball_in_goal = 0;
  goal.highestspawndistratio = 0;
  return goal;
}

function flag_find_ground(z_offset) {
  tracestart = self.origin + (0, 0, 32);
  traceend = self.origin + (0, 0, -1000);
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  ignoreents = [];
  trace = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, contentoverride);
  self.ground_origin = trace["position"];
  return trace["fraction"] != 0 && trace["fraction"] != 1;
}

function showflagradiuseffecttoplayers(team, player, position) {
  if(isDefined(player._flagradiuseffect[team])) {
    player._flagradiuseffect[team] delete();
  }

  effect = undefined;
  var_8e879faf3052e0d2 = player.team;
  iscodcaster = player iscodcaster();

  if(iscodcaster) {
    var_8e879faf3052e0d2 = player function_638eebeff841e16a();
  } else if(var_8e879faf3052e0d2 == "spectator") {
    var_8e879faf3052e0d2 = "allies";
  }

  if(var_8e879faf3052e0d2 == team) {
    var_64df8525ae68ebe4 = spawnfxforclient(level.flagradiusfxid["friendly"], position, player, (0, 0, 1));
    var_64df8525ae68ebe4 setfxkilldefondelete();
  } else {
    var_64df8525ae68ebe4 = spawnfxforclient(level.flagradiusfxid["enemy"], position, player, (0, 0, 1));
    var_64df8525ae68ebe4 setfxkilldefondelete();
  }

  player._flagradiuseffect[team] = var_64df8525ae68ebe4;
  triggerfx(var_64df8525ae68ebe4);
}

function showbaseeffecttoplayer(team, player) {
  if(isDefined(player._flageffect[team])) {
    player._flageffect[team] delete();
  }

  effect = undefined;
  var_8e879faf3052e0d2 = player.team;
  iscodcaster = player iscodcaster();

  if(iscodcaster) {
    var_8e879faf3052e0d2 = player function_638eebeff841e16a();
  } else if(var_8e879faf3052e0d2 == "spectator") {
    var_8e879faf3052e0d2 = "allies";
  }

  if(var_8e879faf3052e0d2 == team) {
    var_64df8525ae68ebe4 = spawnfxforclient(level.flagbaseglowfxid["friendly"], self.origin, player, self.baseeffectforward);
    var_64df8525ae68ebe4 setfxkilldefondelete();
  } else {
    var_64df8525ae68ebe4 = spawnfxforclient(level.flagbaseglowfxid["enemy"], self.origin, player, self.baseeffectforward);
    var_64df8525ae68ebe4 setfxkilldefondelete();
  }

  player._flageffect[team] = var_64df8525ae68ebe4;
  triggerfx(var_64df8525ae68ebe4);
}

function removeflagpickupradiuseffect(flagteam) {
  if(flagteam == self.team) {
    if(isDefined(self._flagradiuseffect[self.team])) {
      self._flagradiuseffect[self.team] delete();
    }

    return;
  }

  if(isDefined(self._flagradiuseffect[getotherteam(self.team)[0]])) {
    self._flagradiuseffect[getotherteam(self.team)[0]] delete();
  }
}

function setteaminhuddatafromteamname(teamname) {
  if(teamname == "axis") {
    self setteaminhuddata(1);
    return;
  }

  if(teamname == "allies") {
    self setteaminhuddata(2);
    return;
  }

  self setteaminhuddata(0);
}

function player_delete_flag_goal_fx(flagteam) {
  if(flagteam == self.team) {
    if(isDefined(self._flageffect[self.team])) {
      self._flageffect[self.team] delete();
    }

    return;
  }

  if(isDefined(self._flageffect[getotherteam(self.team)[0]])) {
    self._flageffect[getotherteam(self.team)[0]] delete();
  }
}

function getflagpos(team) {
  ent = getEnt("ctf_flag_" + team, "targetname");
  assertex(isDefined(ent) && isDefined(ent.origin));
  return ent.origin;
}

function createteamflag(team, entityteam) {
  var_da71d292931c16b = 0;
  trigger = getEnt("ctf_zone_" + entityteam, "targetname");

  if(!isDefined(trigger)) {
    flaggoal = flag_create_team_goal(team);
    trigger = spawn("trigger_radius", flaggoal.origin - (0, 0, flaggoal.radius / 2), 0, flaggoal.radius, 80);
    trigger.no_moving_platfrom_unlink = 1;
    trigger.linktoenabledflag = 1;
    trigger.baseorigin = trigger.origin;
    var_da71d292931c16b = 1;
    visuals[0] = spawn("script_model", flaggoal.origin);
    visuals[0] setasgametypeobjective();
    visuals[0] setteaminhuddatafromteamname(entityteam);
  } else {
    visuals[0] = getEnt("ctf_flag_" + entityteam, "targetname");
  }

  if(isDefined(visuals[0])) {}

  if(!var_da71d292931c16b) {
    radius = 15;

    if(level.pickuptime > 0 || level.returntime > 0) {
      radius *= 2;
    }

    clonetrigger = spawn("trigger_radius", trigger.origin, 0, radius, trigger.height);
    trigger = clonetrigger;
  }

  if(level.mapname == "mp_m_speedball") {
    trigger flag_find_ground();
    trigger.origin = trigger.ground_origin;
    visuals[0].origin = trigger.ground_origin - (0, 0, 0.5);
  }

  visuals[0] setModel(level.flagmodel[team]);
  visuals[0] setasgametypeobjective();
  visuals[0] setteaminhuddatafromteamname(entityteam);
  carryteam = getotherteam(team)[0];
  teamflag = scripts\mp\gameobjects::createcarryobject(carryteam, trigger, visuals, (0, 0, 85));
  teamflag scripts\mp\gameobjects::allowcarry("friendly");
  teamflag scripts\mp\gameobjects::setteamusetime("friendly", level.pickuptime);
  teamflag scripts\mp\gameobjects::setteamusetime("enemy", level.returntime);
  teamflag scripts\mp\gameobjects::setvisibleteam("none");
  teamflag scripts\mp\gameobjects::setobjectivestatusallicons(level.iconescort, level.iconkill, undefined);
  teamflag scripts\mp\objidpoolmanager::objective_set_play_intro(teamflag.objidnum, 0);
  teamflag scripts\mp\objidpoolmanager::objective_set_play_outro(teamflag.objidnum, 0);
  teamflag scripts\mp\gameobjects::registercarryobjectpickupcheck(&flagpickupchecks);
  teamflag.allowweapons = 1;
  teamflag.originalownerteam = carryteam;
  teamflag.onpickup = &onpickup;
  teamflag.onpickupfailed = &onpickupfailed;
  teamflag.ondrop = &ondrop;
  teamflag.onreset = &onreset;

  if(getdvarint(@ "hash_82f42dfd88cbacad") != 0) {
    teamflag scripts\mp\gameobjects::create_manual_drop_data_struct([visuals[0]], trigger, 1, 80, 0);
  }

  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        teamflag.objidpingfriendly = 1;
        teamflag.objidpingenemy = 0;
        teamflag.objpingdelay = 60;
        break;
      case 1:
        teamflag.objidpingfriendly = 0;
        teamflag.objidpingenemy = 0;
        teamflag.objpingdelay = 0.05;
        break;
      case 2:
        teamflag.objidpingfriendly = 1;
        teamflag.objidpingenemy = 0;
        teamflag.objpingdelay = 1;
        break;
      case 3:
        teamflag.objidpingfriendly = 1;
        teamflag.objidpingenemy = 0;
        teamflag.objpingdelay = 1.5;
        break;
      case 4:
        teamflag.objidpingfriendly = 1;
        teamflag.objidpingenemy = 0;
        teamflag.objpingdelay = 2;
        break;
      case 5:
        teamflag.objidpingfriendly = 1;
        teamflag.objidpingenemy = 0;
        teamflag.objpingdelay = 3;
        break;
      case 6:
        teamflag.objidpingfriendly = 1;
        teamflag.objidpingenemy = 0;
        teamflag.objpingdelay = 4;
        break;
    }

    pingobjid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
    teamflag.pingobjidnum = pingobjid;
    scripts\mp\objidpoolmanager::objective_add_objective(pingobjid, "done", teamflag.origin);
    scripts\mp\objidpoolmanager::objective_set_play_intro(pingobjid, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(pingobjid, 0);
    teamflag scripts\mp\gameobjects::setvisibleteam("none", pingobjid);
    objective_setownerteam(pingobjid, team);
    teamflag scripts\mp\gameobjects::setobjectivestatusallicons(level.iconescort, level.iconkill, level.mlgiconfullflag, pingobjid);
  } else {
    teamflag.objidpingfriendly = 1;
    teamflag.objidpingenemy = 0;
    teamflag.objpingdelay = 3;
  }

  teamflag.oldradius = trigger.radius;
  tracestart = trigger.origin + (0, 0, 32);
  traceend = trigger.origin + (0, 0, -32);
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  ignoreents = [];
  trace = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, contentoverride);
  teamflag.baseeffectpos = teamflag.visuals[0].origin;
  upangles = anglestoup(teamflag.visuals[0].angles);
  teamflag.baseeffectforward = anglesToForward(upangles);
  level.teamflagbases[team] = createteamflagbase(team, teamflag);
  return teamflag;
}

function flagpickupchecks(player) {
  return !player scripts\cp_mp\utility\player_utility::isinvehicle();
}

function createteamflagbase(team, teamflag) {
  flagbaseorigin = teamflag.visuals[0].origin;
  teamflagbase = spawn("script_model", flagbaseorigin);
  teamflagbase setModel(level.flagbase[team]);
  teamflagbase.ownerteam = team;
  teamflagbase setasgametypeobjective();
  teamflagbase setteaminhuddatafromteamname(team);
  teamflagbase.baseeffectpos = flagbaseorigin;
  upangles = anglestoup(teamflag.visuals[0].angles);
  teamflagbase.baseeffectforward = anglesToForward(upangles);
  return teamflagbase;
}

function createcapzone(team, entityteam) {
  flaggoal = flag_create_team_goal(team);
  trigger = getEnt("ctf_zone_" + entityteam, "targetname");

  if(!isDefined(trigger)) {
    trigger = spawn("trigger_radius", flaggoal.origin - (0, 0, flaggoal.radius / 2), 0, flaggoal.radius, 80);
    trigger.no_moving_platfrom_unlink = 1;
    trigger.linktoenabledflag = 1;
    trigger.baseorigin = trigger.origin;
    trigger.height = 80;
  }

  clonetrigger = spawn("trigger_radius", trigger.origin, 0, 15, trigger.height);
  trigger = clonetrigger;
  visuals = [];
  capzone = scripts\mp\gameobjects::createuseobject(team, trigger, visuals, (0, 0, 85));
  capzone scripts\mp\gameobjects::allowuse("friendly");
  capzone scripts\mp\gameobjects::setvisibleteam("any");
  capzone scripts\mp\gameobjects::setobjectivestatusallicons(level.icondefendflag, level.iconcaptureflag, level.mlgiconfullflag);
  capzone scripts\mp\gameobjects::setusetime(0);
  capzone scripts\mp\gameobjects::setkeyobject(level.teamflags[getotherteam(team)[0]]);
  capzone.onuse = &onuse;
  capzone.oncantuse = &oncantuse;
  tracestart = trigger.origin + (0, 0, 32);
  traceend = trigger.origin + (0, 0, -32);
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  ignoreents = [];
  trace = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, contentoverride);
  upangles = vectortoangles(trace["normal"]);
  forward = anglesToForward(upangles);
  right = anglestoright(upangles);
  return capzone;
}

function onbeginuse(player) {
  team = player.pers["team"];

  if(team == scripts\mp\gameobjects::getownerteam()) {
    self.trigger.radius = 1024;
    return;
  }

  self.trigger.radius = self.oldradius;
}

function onenduse(player, team, success) {
  self.trigger.radius = self.oldradius;
}

function onpickup(player, playervo, defused) {
  self notify("picked_up");
  player notify("obj_picked_up");
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(isDefined(self.droppedteam)) {
    if(self.droppedteam == player.team) {
      scripts\mp\gameobjects::setownerteam(self.droppedteam);
      ownerteam = self.droppedteam;
    } else {
      scripts\mp\gameobjects::setownerteam(getotherteam(player.team)[0]);
      ownerteam = self.droppedteam;
    }

    self.droppedteam = undefined;
  }

  team = player.pers["team"];
  otherteam = getotherteam(team)[0];

  if(team != ownerteam) {
    if(isDefined(level.closecapturekiller[player.team]) && level.closecapturekiller[player.team] == player) {
      player thread scripts\mp\utility\points::doscoreevent(#"hash_fe8ba8ad4e2e427b");
    }

    level.closecapturekiller[player.team] = undefined;
    player thread doscoreevent(#"flag_return");

    if(level.codcasterenabled) {
      level.capzones[player.team] scripts\mp\gameobjects::resetmlgobjectivestatusicon();
    }

    thread returnflag();
    var_7e2c53b0bcf117d9 = spawnStruct();
    var_7e2c53b0bcf117d9.player = player;
    var_7e2c53b0bcf117d9.eventname = "obj_return";
    var_7e2c53b0bcf117d9.position = player.origin;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_game_event", var_7e2c53b0bcf117d9);
    player playlocalsound("jup_ctf_obj_returned_player");
    player playsoundtoteam("jup_ctf_obj_returned_allies", team, player, player);
    player playsoundtoteam("jup_ctf_obj_returned_enemy", otherteam, player, player);
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_returned", otherteam, "status");
    scripts\mp\utility\dialog::leaderdialog("flag_returned", team, "status");
    namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c(18, player.team, player getentitynumber());
    player incpersstat("returns", 1);
    player scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648(15, 1);
    player scripts\mp\persistence::statsetchild("round", "returns", player.pers["returns"]);

    if(isPlayer(player)) {
      player setextrascore1(player.pers["returns"]);
    }

    if(self.originalownerteam == "allies") {
      setomnvar("ui_ctf_flag_axis", -2);
    } else {
      setomnvar("ui_ctf_flag_allies", -2);
    }

    return;
  }

  if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[team])) {
    player thread applyflagcarrierclass();
  } else {
    player attachflag();
  }

  player incpersstat("pickups", 1);
  level.closecapturekiller[otherteam] = undefined;

  if(self.originalownerteam == "allies") {
    setomnvar("ui_ctf_flag_axis", player getentitynumber());
  } else {
    setomnvar("ui_ctf_flag_allies", player getentitynumber());
  }

  player setclientomnvar("ui_flag_player_hud_icon", 1);

  if(isDefined(level.showenemycarrier)) {
    if(level.showenemycarrier == 0) {
      scripts\mp\gameobjects::setvisibleteam("none");
    } else {
      scripts\mp\gameobjects::setvisibleteam("friendly");
      objective_state(self.pingobjidnum, "current");
      scripts\mp\gameobjects::updatecompassicon("enemy", self.pingobjidnum);
      objective_icon(self.pingobjidnum, "icon_waypoint_kill");
      scripts\mp\objidpoolmanager::objective_hide_for_mlg_spectator(self.pingobjidnum, 1);
    }
  }

  scripts\mp\gameobjects::setobjectivestatusallicons(level.iconescort, level.iconkill, level.mlgiconfullflag);

  if(level.capturecondition == 0) {
    level.capzones[otherteam] scripts\mp\gameobjects::allowuse("none");
  }

  level.capzones[otherteam] scripts\mp\gameobjects::setvisibleteam("none");
  player playlocalsound("jup_ctf_obj_pickup_player");
  player playsoundtoteam("jup_ctf_obj_pickup_allies", team, player, player);
  player playsoundtoteam("jup_ctf_obj_pickup_enemy", otherteam, player, player);
  scripts\mp\utility\dialog::leaderdialog("enemy_flag_taken", team);
  scripts\mp\utility\dialog::leaderdialog("flag_getback", otherteam);
  thread teamplayercardsplash("callout_flagpickup", player);

  if(!isDefined(self.previouscarrier) || self.previouscarrier != player) {
    player thread doscoreevent(#"flag_grab");
  }

  var_7e2c53b0bcf117d9 = spawnStruct();
  var_7e2c53b0bcf117d9.player = player;
  var_7e2c53b0bcf117d9.eventname = "pickup";
  var_7e2c53b0bcf117d9.position = player.origin;
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_game_event", var_7e2c53b0bcf117d9);
  self.previouscarrier = player;

  if(level.codcasterenabled) {
    player setgametypevip(1);
  }

  player thread superabilitywatcher();
}

function onpickupfailed(player) {}

function returnflag() {
  scripts\mp\gameobjects::returnhome();
}

function ondrop(player) {
  if(isDefined(player.leaving_team)) {
    self.droppedteam = player.leaving_team;
    player.leaving_team = undefined;
  } else if(!isDefined(player)) {
    self.droppedteam = self.originalownerteam;
  } else {
    self.droppedteam = player.team;
  }

  if(isDefined(player)) {
    player updatematchstatushintonnoflag();
  }

  scripts\mp\gameobjects::setownerteam(getotherteam(self.droppedteam)[0]);
  team = self.droppedteam;
  otherteam = getotherteam(self.droppedteam)[0];
  scripts\mp\gameobjects::allowcarry("any");
  scripts\mp\gameobjects::setvisibleteam("any");
  objective_state(self.pingobjidnum, "done");

  if(level.returntime >= 0) {
    scripts\mp\gameobjects::setobjectivestatusallicons(level.iconreturnflag, level.iconcaptureflag, level.mlgiconfullflag);
  } else {
    scripts\mp\gameobjects::setobjectivestatusallicons(level.icondefendflag, level.iconcaptureflag, level.mlgiconfullflag);
    scripts\mp\objidpoolmanager::objective_hide_for_mlg_spectator(self.objidnum, 1);
  }

  if(self.originalownerteam == "allies") {
    setomnvar("ui_ctf_flag_axis", -1);
  } else {
    setomnvar("ui_ctf_flag_allies", -1);
  }

  if(isDefined(player)) {
    player setclientomnvar("ui_flag_player_hud_icon", 0);
  }

  var_86929bfc3b565860 = self.visuals[0] gettagorigin("tag_origin");

  if(isDefined(player)) {
    if(!isreallyalive(player)) {
      player.carryobject.previouscarrier = undefined;
    }

    if(isDefined(player.carryflag)) {
      player detachflag();
    }

    player playlocalsound("jup_ctf_obj_drop_player");
    player playsoundtoteam("jup_ctf_obj_drop_allies", team, player, player);
    player playsoundtoteam("jup_ctf_obj_drop_enemy", otherteam, player, player);

    if(level.codcasterenabled) {
      player setgametypevip(0);
    }
  } else {
    scripts\mp\utility\sound::playsoundonplayers("iw9_mp_ui_objective_lost", otherteam);
  }

  scripts\mp\utility\dialog::leaderdialog("enemy_flag_dropped", self.originalownerteam, "status");
  scripts\mp\utility\dialog::leaderdialog("flag_dropped", getotherteam(self.originalownerteam)[0], "status");

  if(level.idleresettime > 0) {
    thread returnaftertime();
  }
}

function returnaftertime() {
  self endon("picked_up");
  currentwaittime = 0;

  while(currentwaittime < level.idleresettime) {
    waitframe();

    if(self.claimteam == "none") {
      currentwaittime += level.framedurationseconds;
    }
  }

  team = scripts\mp\gameobjects::getownerteam();
  otherteam = getotherteam(team)[0];
  self.visuals[0] playsoundtoteam("jup_ctf_obj_returned_time_allies", team);
  self.visuals[0] playsoundtoteam("jup_ctf_obj_returned_time_enemy", otherteam);
  scripts\mp\gameobjects::returnhome();
}

function onreset() {
  if(isDefined(self.droppedteam)) {
    scripts\mp\gameobjects::setownerteam(self.droppedteam);
  }

  team = scripts\mp\gameobjects::getownerteam();
  otherteam = getotherteam(team)[0];
  self.droppedteam = undefined;
  scripts\mp\gameobjects::allowcarry("friendly");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconescort, level.iconkill);

  if(self.originalownerteam == "allies") {
    setomnvar("ui_ctf_flag_axis", -2);
  } else {
    setomnvar("ui_ctf_flag_allies", -2);
  }

  level.capzones[otherteam] scripts\mp\gameobjects::allowuse("friendly");
  level.capzones[otherteam] scripts\mp\gameobjects::setvisibleteam("any");
  level.capzones[otherteam] scripts\mp\gameobjects::setobjectivestatusallicons(level.icondefendflag, level.iconcaptureflag, level.mlgiconfullflag);
  self.previouscarrier = undefined;
}

function onuse(player) {
  if(!level.gameended) {
    if(player scripts\cp_mp\utility\player_utility::isinvehicle()) {
      return;
    }

    team = player.pers["team"];
    otherteam = getotherteam(team)[0];
    player setclientomnvar("ui_flag_player_hud_icon", 0);
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_captured", team, "status");
    scripts\mp\utility\dialog::leaderdialog("flag_captured", otherteam, "status");
    namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c(17, player.team, player getentitynumber());
    objective_state(level.teamflags[otherteam].pingobjidnum, "done");
    player updatematchstatushintonnoflag();
    thread teamplayercardsplash("callout_flagcapture", player);
    player thread scripts\mp\rank::scoreeventpopup(#"flag_capture");
    player thread scripts\mp\utility\points::doscoreevent(#"hash_7b8c8a78ac292c0d");
    player notify("objective", "captured");
    player notify("ctfFlag_captured");
    var_7e2c53b0bcf117d9 = spawnStruct();
    var_7e2c53b0bcf117d9.player = player;
    var_7e2c53b0bcf117d9.eventname = "capture";
    var_7e2c53b0bcf117d9.position = player.origin;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_game_event", var_7e2c53b0bcf117d9);

    if(level.codcasterenabled) {
      player setgametypevip(0);
    }

    player incpersstat("captures", 1);
    player scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648(15, 1);
    player scripts\mp\persistence::statsetchild("round", "captures", player.pers["captures"]);

    if(isPlayer(player)) {
      player setextrascore0(player.pers["captures"]);
    }

    player playlocalsound("jup_ctf_obj_captured_player");
    player playsoundtoteam("jup_ctf_obj_captured_allies", team, player, player);
    player playsoundtoteam("jup_ctf_obj_captured_enemy", otherteam, player, player);

    if(isDefined(player.carryflag)) {
      player detachflag();
    }

    if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[team])) {
      player thread removeflagcarrierclass();
    }

    level.closecapturekiller[team] = undefined;
    level.closecapturekiller[otherteam] = undefined;

    if(level.codcasterenabled) {
      level.capzones[otherteam] scripts\mp\gameobjects::resetmlgobjectivestatusicon();
    }

    level.teamflags[otherteam] returnflag();
    level scripts\mp\gamescore::giveteamscoreforobjective(team, 1, 0);
  }
}

function onplayerconnect(player) {
  player._flageffect = [];
  player._flagradiuseffect = [];
  player thread onplayerspawned();
}

function onplayerspawned() {
  self endon("disconnect");

  while(true) {
    self waittill("spawned");
    self setclientomnvar("ui_flag_player_hud_icon", 0);
    setextrascore0(0);

    if(isDefined(self.pers["captures"])) {
      setextrascore0(self.pers["captures"]);
    }

    setextrascore1(0);

    if(isDefined(self.pers["returns"])) {
      setextrascore1(self.pers["returns"]);
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
  scripts\mp\equipment\tac_insert::spawnpoint_setspawnpoint(self.origin, self.angles);
  self.gamemode_chosenclass = self.class;
  scripts\mp\class::function_a16868d4dcd81a4b();
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
  team = self.pers["team"];
  otherteam = getotherteam(team)[0];
  level.teamflags[otherteam] endon("reset");

  while(true) {
    self waittill("super_started");
    theflag = level.teamflags[otherteam];

    if(!isDefined(theflag)) {
      continue;
    }

    super = self.super;

    switch (super.staticdata.ref) {
      case #"hash_8cf10370c167105a":
        waittill_any_2("teleport_success", "rewind_success");
        theflag thread scripts\mp\gameobjects::setdropped();
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
  scripts\mp\equipment\tac_insert::spawnpoint_setspawnpoint(self.origin, self.angles);
  self notify("faux_spawn");
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

function oncantuse(player) {}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  var_aec2e5e01f424119 = 0;
  attackerpos = attacker.origin;
  attackerisinflictor = 0;

  if(isDefined(einflictor)) {
    attackerpos = einflictor.origin;
    attackerisinflictor = einflictor == attacker;
  }

  if(isDefined(attacker) && isPlayer(attacker) && attacker.pers["team"] != self.pers["team"]) {
    if(isDefined(attacker.carryflag) && attackerisinflictor) {
      attacker thread scripts\mp\rank::scoreeventpopup(#"carrier_kill");
      attacker thread scripts\mp\utility\points::doscoreevent(#"hash_f735b92839c5a687");
      var_aec2e5e01f424119 = 1;
    }

    if(isDefined(self.carryflag)) {
      var_33f8ce08c3e0650b = distancesquared(self.origin, level.capzones[self.team].trigger.origin);

      if(var_33f8ce08c3e0650b < 90000) {
        level.closecapturekiller[attacker.team] = attacker;
      } else {
        level.closecapturekiller[attacker.team] = undefined;
      }

      attacker thread scripts\mp\utility\points::doscoreevent(#"hash_5311f153a7fee40c");
      attacker incpersstat("carrierKills", 1);
      attacker incpersstat("defends", 1);
      attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
      thread utility::trycall(level.matchdata_logvictimkillevent, killid, "carrying");
      namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c(20, attacker.team, attacker getentitynumber());
      var_aec2e5e01f424119 = 1;
    }

    if(!var_aec2e5e01f424119) {
      var_3cd1af2851f12ab5 = 0;
      awarddefense = 0;

      foreach(flag in level.teamflags) {
        flagcheck = distsquaredcheck(attackerpos, self.origin, flag.curorigin);

        if(flagcheck) {
          if(flag.ownerteam == self.team) {
            var_3cd1af2851f12ab5 = 1;
            continue;
          }

          awarddefense = 1;
        }
      }

      if(var_3cd1af2851f12ab5) {
        attacker thread scripts\mp\rank::scoreeventpopup(#"assault");
        attacker thread scripts\mp\utility\points::doscoreevent(#"mode_x_assault");
        thread utility::trycall(level.matchdata_logvictimkillevent, killid, "defending");
        attacker incpersstat("assaults", 1);
      } else if(awarddefense) {
        attacker thread scripts\mp\rank::scoreeventpopup(#"defend");
        attacker thread scripts\mp\utility\points::doscoreevent(#"hash_2d96ced878338cd2");
        attacker incpersstat("defends", 1);
        attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
        thread utility::trycall(level.matchdata_logvictimkillevent, killid, "assaulting");
      }
    }
  }

  if(isDefined(self.carryflag)) {
    detachflag();
  }
}

function distsquaredcheck(attackerpos, victimpos, checkpos) {
  attackerdistsq = distancesquared(checkpos, attackerpos);
  victimdistsq = distancesquared(checkpos, victimpos);

  if(attackerdistsq < 90000 || victimdistsq < 90000) {
    return 1;
  }

  return 0;
}

function attachflag() {
  updatematchstatushintonhasflag();
  otherteam = getotherteam(self.pers["team"])[0];
  self attach(level.carryflag[otherteam], "tag_stowed_back3", 1);
  self.carryflag = level.carryflag[otherteam];
}

function detachflag() {
  self detach(self.carryflag, "tag_stowed_back3");
  self.carryflag = undefined;
}

function setspecialloadouts() {
  if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses", "axis", 5, "class", "inUse")) {
    level.ctf_loadouts["axis"] = getmatchrulesspecialclass("axis", 5);
  }

  if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses", "allies", 5, "class", "inUse")) {
    level.ctf_loadouts["allies"] = getmatchrulesspecialclass("allies", 5);
  }
}

function removeflag() {
  level endon("game_ended");

  while(true) {
    if(getDvar(@ "hash_6ce167f2cdc8ef7c", "") != "") {
      goallabel = getDvar(@ "hash_6ce167f2cdc8ef7c", "");

      if(goallabel == "_a") {
        team = "allies";
      } else {
        team = "axis";
      }

      if(team == "allies") {
        if(game["switchedsides"]) {
          team = game["defenders"];
        } else {
          team = game["attackers"];
        }
      } else if(game["switchedsides"]) {
        team = game["attackers"];
      } else {
        team = game["defenders"];
      }

      level.teamflags[team].trigger notify("move_gameobject");
      level.teamflags[team] scripts\mp\gameobjects::allowuse("none");
      level.teamflags[team].trigger = undefined;
      level.teamflags[team] notify("deleted");
      level.teamflags[team].visuals[0] delete();
      level.teamflagbases[team] delete();
      level.capzones[team] scripts\mp\gameobjects::allowuse("none");
      level.capzones[team].trigger = undefined;
      level.capzones[team] notify("deleted");

      foreach(player in level.players) {
        player player_delete_flag_goal_fx(team);
      }

      level.teamflags[team].visibleteam = "none";
      level.teamflags[team] scripts\mp\gameobjects::setobjectivestatusicons(undefined, undefined);
      level.capzones[team].visibleteam = "none";
      level.capzones[team] scripts\mp\gameobjects::setobjectivestatusicons(undefined, undefined);
      level.teamflags[team] = undefined;
      setdynamicdvar(@ "hash_6ce167f2cdc8ef7c", "");
    }

    wait 1;
  }
}

function placeflag() {
  level endon("game_ended");

  while(true) {
    if(getDvar(@ "hash_29d45d6822a1cf6d", "") != "") {
      goallabel = getDvar(@ "hash_29d45d6822a1cf6d", "");

      if(goallabel == "_a") {
        team = "allies";
      } else {
        team = "axis";
      }

      if(team == "allies") {
        if(game["switchedsides"]) {
          team = game["defenders"];
        } else {
          team = game["attackers"];
        }
      } else if(game["switchedsides"]) {
        team = game["attackers"];
      } else {
        team = game["defenders"];
      }

      goal = undefined;
      goal = spawnStruct();
      goal dev_flag_find_ground();
      goal.origin = goal.ground_origin;
      goal.radius = 30;
      goal.team = team;
      trigger = spawn("trigger_radius", goal.origin, 0, 30, 80);
      visuals[0] = spawn("script_model", goal.origin);
      visuals[0] setModel(level.flagmodel[team]);
      newteamflag = scripts\mp\gameobjects::createcarryobject(team, trigger, visuals, (0, 0, 85));
      newteamflag scripts\mp\gameobjects::setteamusetext("enemy", &"MP/GRABBING_FLAG");
      newteamflag scripts\mp\gameobjects::setteamusetext("friendly", &"MP/RETURNING_FLAG");
      newteamflag scripts\mp\gameobjects::allowcarry("enemy");
      newteamflag scripts\mp\gameobjects::setvisibleteam("none");
      newteamflag scripts\mp\gameobjects::setobjectivestatusallicons(level.iconescort, level.iconkill, level.mlgiconfullflag);
      newteamflag.objidpingfriendly = 1;
      newteamflag.allowweapons = 1;
      newteamflag.onpickup = &onpickup;
      newteamflag.onpickupfailed = &onpickupfailed;
      newteamflag.ondrop = &ondrop;
      newteamflag.onreset = &onreset;
      newteamflag.oldradius = trigger.radius;
      newteamflag.origin = goal.origin;
      newteamflag.label = team;
      newteamflag.previouscarrier = undefined;
      tracestart = trigger.origin + (0, 0, 32);
      traceend = trigger.origin + (0, 0, -32);
      contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
      ignoreents = [];
      trace = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, contentoverride);
      newteamflag.baseeffectpos = trace["position"];
      upangles = vectortoangles(trace["normal"]);
      newteamflag.baseeffectforward = anglesToForward(upangles);
      level.teamflagbases[team] = createteamflagbase(team, newteamflag);

      if(team == "allies") {
        if(game["switchedsides"]) {
          level.teamflags[game["defenders"]] = newteamflag;
        } else {
          level.teamflags[game["attackers"]] = newteamflag;
        }
      } else if(game["switchedsides"]) {
        level.teamflags[game["attackers"]] = newteamflag;
      } else {
        level.teamflags[game["defenders"]] = newteamflag;
      }

      visuals = [];
      trigger = spawn("trigger_radius", goal.origin - (0, 0, goal.radius / 2), 0, goal.radius, 80);
      trigger.no_moving_platfrom_unlink = 1;
      trigger.linktoenabledflag = 1;
      trigger.baseorigin = trigger.origin;
      capzone = scripts\mp\gameobjects::createuseobject(team, trigger, visuals, (0, 0, 115));
      capzone scripts\mp\gameobjects::allowuse("friendly");
      capzone scripts\mp\gameobjects::setvisibleteam("any");
      capzone scripts\mp\gameobjects::setobjectivestatusallicons(level.icondefendflag, level.iconcaptureflag, level.mlgiconfullflag);
      capzone scripts\mp\gameobjects::setusetime(0);
      capzone scripts\mp\gameobjects::setkeyobject(level.teamflags[getotherteam(team)[0]]);
      level.capzones[getotherteam(team)[0]] scripts\mp\gameobjects::setkeyobject(newteamflag);
      capzone.onuse = &onuse;
      capzone.oncantuse = &oncantuse;
      tracestart = trigger.origin + (0, 0, 32);
      traceend = trigger.origin + (0, 0, -32);
      contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
      ignoreents = [];
      trace = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, contentoverride);
      upangles = vectortoangles(trace["normal"]);
      forward = anglesToForward(upangles);
      right = anglestoright(upangles);

      if(team == "allies") {
        if(game["switchedsides"]) {
          level.capzones[game["defenders"]] = capzone;
        } else {
          level.capzones[game["attackers"]] = capzone;
        }
      } else if(game["switchedsides"]) {
        level.capzones[game["attackers"]] = capzone;
      } else {
        level.capzones[game["defenders"]] = capzone;
      }

      setdynamicdvar(@ "hash_29d45d6822a1cf6d", "");
    }

    wait 1;
  }
}

function dev_flag_find_ground() {
  tracestart = level.players[0].origin + (0, 0, 32);
  traceend = level.players[0].origin + (0, 0, -1000);
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  ignoreents = [];
  trace = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, contentoverride);
  self.ground_origin = trace["position"];
  return trace["fraction"] != 0 && trace["fraction"] != 1;
}

function setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_ctf_kill", 2, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_recover_flag", 2, "friendly", "MP_INGAME_ONLY/OBJ_RECOVER_CAPS", "icon_waypoint_flag", 0, 12);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_flag", 2, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_flag_escort", 0, 12);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_take_flag", 2, "enemy", "MP_INGAME_ONLY/OBJ_TAKE_CAPS", "icon_waypoint_flag", 0, 13);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_flag", 2, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0, 13);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_mlg_empty_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_empty", 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_mlg_full_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_full", 0, undefined);
}

function updatematchstatushintonnoflag() {
  scripts\mp\hud_message::function_f004ef4606b9efdc("flag_capture");
}

function updatematchstatushintonhasflag() {
  scripts\mp\hud_message::function_f004ef4606b9efdc("flag_return");
}

function function_2f8e8b92f965d936() {
  self endon("<dev string:x1c>");

  while(true) {
    if(getdvarint(@ "hash_46a6b424af6acbc2") != 0) {
      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x2a>", getdvarint(@ "hash_46a6b424af6acbc2"), 0);
      break;
    } else if(getdvarint(@ "hash_86e14326e43c0115") != 0) {
      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x34>", getdvarint(@ "hash_86e14326e43c0115"), 0);
      break;
    }

    wait 1;
  }

  setdevdvar(@ "hash_46a6b424af6acbc2", 0);
  setdevdvar(@ "hash_86e14326e43c0115", 0);
  thread function_2f8e8b92f965d936();
}

function function_9136c8e96ae14d11() {
  scripts\mp\codcasterclientmatchdata::function_edba1ee7c2375a5();
}

function function_3f98ea23e8fa1954(isinovertime) {
  return !isinovertime && getwingamebytype() == "roundsWon";
}