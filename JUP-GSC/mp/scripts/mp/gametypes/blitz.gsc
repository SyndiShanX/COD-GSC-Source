/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\blitz.gsc
***********************************************/

#using script_4a6760982b403bad;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment\tac_insert;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\playerlogic;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\stats;
#namespace blitz;

function main() {
  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  flag_default_origins();
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
  level.resetscoreonroundstart = &function_180943832c190cc0;
  level.spawnnodetype = "mp_ctf_spawn";
  game["dialog"]["gametype"] = "gametype_blitz";
  game["dialog"]["offense_obj"] = "boost_blitz";
  game["dialog"]["defense_obj"] = "boost_blitz";
  game["dialog"]["enemyblitzflag_capt"] = "enemyblitzflag_capt";
  game["dialog"]["enemyblitzflag_drop"] = "enemyblitzflag_drop";
  game["dialog"]["enemyblitzflag_return"] = "enemyblitzflag_return";
  game["dialog"]["enemyblitzflag_taken"] = "enemyblitzflag_taken";
  game["dialog"]["ourblitzflag_capt"] = "ourblitzflag_capt";
  game["dialog"]["ourblitzflag_drop"] = "ourblitzflag_drop";
  game["dialog"]["ourblitzflag_getback"] = "ourblitzflag_getback";
  game["dialog"]["ourblitzflag_return"] = "ourblitzflag_return";
  game["dialog"]["ourblitzflag_taken"] = "ourblitzflag_taken";
  setomnvar("ui_ctf_flag_axis", -2);
  setomnvar("ui_ctf_flag_allies", -2);
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  setdynamicdvar(@ "hash_2242911bb32fda25", getmatchrulesdata("blitzData", "winRule"));
  setdynamicdvar(@ "hash_6900636c8a5e6124", getmatchrulesdata("blitzData", "captureCondition"));
  setdynamicdvar(@ "hash_c99307e8c870a9a0", getmatchrulesdata("blitzData", "returnTime"));
  setdynamicdvar(@ "hash_95d04eeafa839d02", getmatchrulesdata("carryData", "showEnemyCarrier"));
  setdynamicdvar(@ "hash_597d04fab84c445d", getmatchrulesdata("carryData", "idleResetTime"));
  setdynamicdvar(@ "hash_d8f0b1e4678a7a1a", getmatchrulesdata("carryData", "pickupTime"));
  setdynamicdvar(@ "hash_4ee2c8d42a5bdca7", 0);
  registerhalftimedvar("blitz", 0);
  setdynamicdvar(@ "hash_9981b8204c05d5a9", 0);
}

function onspawnplayer(revivespawn) {}

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

  setclientnamemode("auto_change");

  if(level.splitscreen) {
    setobjectivescoretext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER");
    setobjectivescoretext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER");
  } else {
    setobjectivescoretext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER_SCORE");
    setobjectivescoretext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER_SCORE");
  }

  setobjectivetext(game["attackers"], &"OBJECTIVES/BLITZ");
  setobjectivetext(game["defenders"], &"OBJECTIVES/BLITZ");
  setobjectivehinttext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER_HINT");
  setobjectivehinttext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER_HINT");
  flag_setupvfx();
  createflagsandhud();
  initspawns();
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
  if(function_bff229a11ecd1e34()) {
    scripts\mp\spawnlogic::setactivespawnlogic(#"default");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("AwayFromEnemies", "Crit_Default");
  }

  level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
  level.spawnmaxs = (-2147483647, -2147483647, -2147483647);
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
  spawnpoints = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype);
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
        spawnpoint.teambase = flaga.ownerteam;
        level.teamspawnpoints[spawnpoint.teambase][level.teamspawnpoints[spawnpoint.teambase].size] = spawnpoint;
        continue;
      }

      if(var_a40d2cea46f228ca > 0.67) {
        spawnpoint.teambase = flagb.ownerteam;
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

  return nearestflag.ownerteam;
}

function getspawnpoint() {
  spawnteam = self.pers["team"];
  enemyteam = getotherteam(spawnteam)[0];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(level.mapname == "mp_runner") {
      spawnteam = getotherteam(spawnteam)[0];
      enemyteam = getotherteam(enemyteam)[0];
    }

    if(game["switchedsides"]) {
      spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_ctf_spawn_" + enemyteam + "_start");
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints);
    } else {
      spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_ctf_spawn_" + spawnteam + "_start");
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints);
    }
  } else {
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, level.ctfteamspawnsetids[spawnteam], "neutral");
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

  if(istrue(game["switchedsides"])) {
    oldattackers = game["attackers"];
    olddefenders = game["defenders"];
    game["attackers"] = olddefenders;
    game["defenders"] = oldattackers;
  }

  foreach(flag in level.flags) {
    switch (flag.script_label) {
      case #"hash_fac2c5f6bddd49bd":
        if(istrue(game["switchedsides"])) {
          level.default_flag_origins[game["defenders"]] = flag.origin;
        } else {
          level.default_flag_origins[game["attackers"]] = flag.origin;
        }

        break;
      case #"hash_fac2c3f6bddd4697":
        if(istrue(game["switchedsides"])) {
          level.default_flag_origins[game["attackers"]] = flag.origin;
        } else {
          level.default_flag_origins[game["defenders"]] = flag.origin;
        }

        break;
    }
  }

  trigger = getEnt("ctf_zone_" + game["defenders"], "targetname");

  if(isDefined(trigger)) {
    if(istrue(game["switchedsides"])) {
      level.default_flag_origins[game["attackers"]] = trigger.origin;
    } else {
      level.default_flag_origins[game["defenders"]] = trigger.origin;
    }
  }

  trigger = getEnt("ctf_zone_" + game["attackers"], "targetname");

  if(isDefined(trigger)) {
    if(istrue(game["switchedsides"])) {
      level.default_flag_origins[game["defenders"]] = trigger.origin;
      return;
    }

    level.default_flag_origins[game["attackers"]] = trigger.origin;
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

function createteamflag(team, entityteam) {
  var_da71d292931c16b = 0;
  flaggoal = flag_create_team_goal(team);
  trigger = spawn("trigger_radius", flaggoal.origin - (0, 0, flaggoal.radius / 2), 0, flaggoal.radius, 80);
  trigger.no_moving_platfrom_unlink = 1;
  trigger.linktoenabledflag = 1;
  trigger.baseorigin = trigger.origin;
  var_da71d292931c16b = 1;
  visuals[0] = spawn("script_model", flaggoal.origin);
  visuals[0] setasgametypeobjective();
  visuals[0] setteaminhuddatafromteamname(entityteam);

  if(isDefined(visuals[0])) {}

  if(!var_da71d292931c16b) {
    radius = 15;

    if(level.pickuptime > 0 || level.returntime > 0) {
      radius *= 2;
    }

    clonetrigger = spawn("trigger_radius", trigger.origin, 0, radius, trigger.height);
    trigger = clonetrigger;
  }

  visuals[0] setModel(level.flagmodel[team]);
  visuals[0] setasgametypeobjective();
  visuals[0] setteaminhuddatafromteamname(entityteam);
  teamflag = scripts\mp\gameobjects::createcarryobject(team, trigger, visuals, (0, 0, 72));
  teamflag scripts\mp\gameobjects::allowcarry("friendly");
  teamflag scripts\mp\gameobjects::setteamusetime("friendly", level.pickuptime);
  teamflag scripts\mp\gameobjects::setteamusetime("enemy", level.returntime);
  teamflag scripts\mp\gameobjects::setvisibleteam("friendly");
  scripts\mp\objidpoolmanager::objective_set_play_intro(teamflag.objidnum, 0);
  teamflag.atbase = 1;
  teamflag.allowweapons = 1;
  teamflag.onpickup = &onpickup;
  teamflag.onpickupfailed = &onpickup;
  teamflag.ondrop = &ondrop;
  teamflag.onreset = &onreset;
  teamflag.onbeginuse = &onresetstart;
  teamflag.onenduse = &onresetend;

  if(level.pickuptime > 0 || level.returntime > 0) {
    teamflag.nousebar = 1;
    teamflag.claimgracetime = max(level.pickuptime * 1000, level.returntime * 1000);
    teamflag scripts\mp\gameobjects::pinobjiconontriggertouch();
  }

  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        teamflag.objidpingfriendly = 0;
        teamflag.objidpingenemy = 1;
        teamflag.objpingdelay = 60;
        break;
      case 1:
        teamflag.objidpingfriendly = 0;
        teamflag.objidpingenemy = 1;
        teamflag.objpingdelay = 0.05;
        break;
      case 2:
        teamflag.objidpingfriendly = 0;
        teamflag.objidpingenemy = 1;
        teamflag.objpingdelay = 1;
        break;
      case 3:
        teamflag.objidpingfriendly = 0;
        teamflag.objidpingenemy = 1;
        teamflag.objpingdelay = 1.5;
        break;
      case 4:
        teamflag.objidpingfriendly = 0;
        teamflag.objidpingenemy = 1;
        teamflag.objpingdelay = 2;
        break;
      case 5:
        teamflag.objidpingfriendly = 0;
        teamflag.objidpingenemy = 1;
        teamflag.objpingdelay = 3;
        break;
      case 6:
        teamflag.objidpingfriendly = 0;
        teamflag.objidpingenemy = 1;
        teamflag.objpingdelay = 4;
        break;
    }
  } else {
    teamflag.objidpingfriendly = 0;
    teamflag.objidpingenemy = 1;
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
  capzone scripts\mp\gameobjects::allowuse("enemy");
  capzone scripts\mp\gameobjects::setvisibleteam("any");
  capzone scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupdefendflag, level.icongoalflag);
  capzone scripts\mp\gameobjects::setusetime(0);
  capzone scripts\mp\gameobjects::setkeyobject(level.teamflags[getotherteam(team)[0]]);
  capzone.onuse = &onuse;
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
  team = player.pers["team"];

  if(team == "allies") {
    otherteam = "axis";
  } else {
    otherteam = "allies";
  }

  if(team != scripts\mp\gameobjects::getownerteam()) {
    if(isDefined(level.closecapturekiller[player.team]) && level.closecapturekiller[player.team] == player) {
      player thread scripts\mp\utility\points::doscoreevent(#"hash_fe8ba8ad4e2e427b");
    }

    level.closecapturekiller[player.team] = undefined;
    player thread doscoreevent(#"flag_return");
    thread returnflag(team);
    var_7e2c53b0bcf117d9 = spawnStruct();
    var_7e2c53b0bcf117d9.player = player;
    var_7e2c53b0bcf117d9.eventname = "obj_return";
    var_7e2c53b0bcf117d9.position = player.origin;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_game_event", var_7e2c53b0bcf117d9);
    scripts\mp\utility\sound::playsoundonplayers("mp_obj_returned", team);
    scripts\mp\utility\sound::playsoundonplayers("mp_obj_returned", getotherteam(team)[0]);
    scripts\mp\utility\dialog::leaderdialog("ourblitzflag_return", otherteam, "status");
    scripts\mp\utility\dialog::leaderdialog("enemyblitzflag_return", team, "status");
    player incpersstat("returns", 1);
    player scripts\mp\persistence::statsetchild("round", "returns", player.pers["returns"]);

    if(isPlayer(player)) {
      player setextrascore1(player.pers["returns"]);
    }

    return;
  }

  if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[team])) {
    player thread applyflagcarrierclass();
  } else {
    player attachflag();
  }

  self.atbase = 0;
  level.closecapturekiller[otherteam] = undefined;

  if(player.team == "allies") {
    setomnvar("ui_ctf_flag_allies", player getentitynumber());
  } else {
    setomnvar("ui_ctf_flag_axis", player getentitynumber());
  }

  player setclientomnvar("ui_flag_player_hud_icon", 1);

  if(isDefined(level.showenemycarrier)) {
    if(level.showenemycarrier == 0) {
      scripts\mp\gameobjects::setvisibleteam("any");
    } else {
      scripts\mp\gameobjects::setvisibleteam("any");
    }
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.iconescort, level.iconkill);

  if(level.teamflags[otherteam].atbase) {
    level.capzones[otherteam] scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupdefendflag, level.icongoalflag);
  } else {
    level.capzones[otherteam] scripts\mp\gameobjects::setvisibleteam("any");
    level.capzones[otherteam] scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendflag, level.icongoalflag);
  }

  level.capzones[team] scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendflag, level.icongoalflag);

  if(level.capturecondition == 0) {}

  scripts\mp\utility\sound::playsoundonplayers("mp_obj_taken", team);
  scripts\mp\utility\dialog::leaderdialog("ourblitzflag_taken", team);
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
}

function returnflag(team) {
  self.atbase = 1;

  if(team == "allies") {
    setomnvar("ui_ctf_flag_allies", -2);
  } else {
    setomnvar("ui_ctf_flag_axis", -2);
  }

  scripts\mp\gameobjects::returnhome();
}

function ondrop(player) {
  team = scripts\mp\gameobjects::getownerteam();
  otherteam = getotherteam(team)[0];
  scripts\mp\gameobjects::allowcarry("any");
  scripts\mp\gameobjects::setvisibleteam("any");
  objective_setpings(self.objidnum, 0);

  if(level.returntime >= 0) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupflag, level.iconreturnflag);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupflag, level.icongoalflag);
  }

  if(team == "allies") {
    setomnvar("ui_ctf_flag_allies", -1);
  } else {
    setomnvar("ui_ctf_flag_axis", -1);
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

    scripts\mp\utility\sound::playsoundonplayers("iw9_mp_ui_objective_lost", otherteam);

    if(level.codcasterenabled) {
      player setgametypevip(0);
    }
  } else {
    scripts\mp\utility\sound::playsoundonplayers("iw9_mp_ui_objective_lost", otherteam);
  }

  scripts\mp\utility\dialog::leaderdialog("enemyblitzflag_drop", otherteam, "status");
  scripts\mp\utility\dialog::leaderdialog("ourblitzflag_drop", team, "status");

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
  scripts\mp\utility\sound::playsoundonplayers("iw9_mp_ui_objective_taken", team);
  scripts\mp\utility\sound::playsoundonplayers("iw9_mp_ui_objective_lost", otherteam);
  scripts\mp\gameobjects::returnhome();
}

function onreset() {
  team = scripts\mp\gameobjects::getownerteam();
  otherteam = getotherteam(team)[0];
  scripts\mp\gameobjects::allowcarry("friendly");
  scripts\mp\gameobjects::setvisibleteam("none");
  objective_setpings(self.objidnum, 0);

  if(team == "allies") {
    setomnvar("ui_ctf_flag_allies", -2);
  } else {
    setomnvar("ui_ctf_flag_axis", -2);
  }

  if(level.teamflags[team].atbase) {
    level.capzones[team] scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupdefendflag, level.icongoalflag);
  }

  if(level.teamflags[otherteam].atbase) {
    level.capzones[team] scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupdefendflag, level.icongoalflag);
  } else {
    level.capzones[team] scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendflag, level.icongoalflag);
  }

  level.capzones[team] scripts\mp\gameobjects::allowuse("enemy");
  self.previouscarrier = undefined;
}

function onresetstart(player) {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosingflag, level.iconresettingflag);
}

function onresetend(player, team, success) {
  if(!success) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupflag, level.iconreturnflag);
  }
}

function onuse(player) {
  if(!level.gameended) {
    team = player.pers["team"];

    if(team == "allies") {
      otherteam = "axis";
    } else {
      otherteam = "allies";
    }

    player setclientomnvar("ui_flag_player_hud_icon", 0);
    scripts\mp\utility\dialog::leaderdialog("ourblitzflag_capt", team, "status");
    scripts\mp\utility\dialog::leaderdialog("enemyblitzflag_capt", otherteam, "status");
    thread teamplayercardsplash("callout_flagcapture", player);
    player thread scripts\mp\utility\points::doscoreevent(#"hash_7b8c8a78ac292c0d");
    player notify("objective", "captured");
    var_7e2c53b0bcf117d9 = spawnStruct();
    var_7e2c53b0bcf117d9.player = player;
    var_7e2c53b0bcf117d9.eventname = "capture";
    var_7e2c53b0bcf117d9.position = player.origin;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_game_event", var_7e2c53b0bcf117d9);

    if(level.codcasterenabled) {
      player setgametypevip(0);
    }

    player incpersstat("captures", 1);
    player scripts\mp\persistence::statsetchild("round", "captures", player.pers["captures"]);

    if(isPlayer(player)) {
      player setextrascore0(player.pers["captures"]);
    }

    scripts\mp\utility\sound::playsoundonplayers("mp_obj_captured", team);
    scripts\mp\utility\sound::playsoundonplayers("mp_enemy_obj_captured", getotherteam(team)[0]);

    if(isDefined(player.carryflag)) {
      player detachflag();
    }

    if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[team])) {
      player thread removeflagcarrierclass();
    }

    level.closecapturekiller[team] = undefined;
    level.closecapturekiller[otherteam] = undefined;

    if(level.teamflags[getotherteam(team)[0]].atbase) {
      level scripts\mp\gamescore::giveteamscoreforobjective(team, 2, 0);
    } else {
      level scripts\mp\gamescore::giveteamscoreforobjective(team, 1, 0);
    }

    level.teamflags[team] returnflag(team);
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
  scripts\mp\equipment\tac_insert::spawnpoint_setspawnpoint(self.origin, self.angles);
  self notify("faux_spawn");
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

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
      attacker incpersstat("defends", 1);
      attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
      thread utility::trycall(level.matchdata_logvictimkillevent, killid, "carrying");
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
        attacker thread scripts\mp\utility\points::doscoreevent(#"mode_x_assault");
        thread utility::trycall(level.matchdata_logvictimkillevent, killid, "defending");
      } else if(awarddefense) {
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

function function_180943832c190cc0(isinovertime) {
  return !isinovertime && getwingamebytype() == "roundsWon";
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