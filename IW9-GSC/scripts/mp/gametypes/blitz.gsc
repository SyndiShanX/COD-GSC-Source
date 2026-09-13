/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\blitz.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  flag_default_origins();
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
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 1);
  }

  updategametypedvars();

  if(level.winrule)
    level.wingamebytype = "teamScores";
  else
    level.wingamebytype = "roundsWon";

  level.teambased = 1;
  level.objectivebased = 1;
  level.overtimescorewinoverride = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.modeonspawnplayer = ::onspawnplayer;
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

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("dvar_2242911BB32FDA25", getmatchrulesdata("blitzData", "winRule"));
  setdynamicdvar("dvar_6900636C8A5E6124", getmatchrulesdata("blitzData", "captureCondition"));
  setdynamicdvar("dvar_C99307E8C870A9A0", getmatchrulesdata("blitzData", "returnTime"));
  setdynamicdvar("dvar_95D04EEAFA839D02", getmatchrulesdata("carryData", "showEnemyCarrier"));
  setdynamicdvar("dvar_597D04FAB84C445D", getmatchrulesdata("carryData", "idleResetTime"));
  setdynamicdvar("dvar_D8F0B1E4678A7A1A", getmatchrulesdata("carryData", "pickupTime"));
  setdynamicdvar("dvar_4EE2C8D42A5BDCA7", 0);
  scripts\mp\utility\game::registerhalftimedvar("blitz", 0);
  setdynamicdvar("scr_blitz_promode", 0);
}

onspawnplayer(_id_9156B53BCF7CE573) {}

onstartgametype() {
  inot = scripts\mp\utility\game::inovertime();
  _id_31E2A8F506168626 = game["overtimeRoundsPlayed"] == 0;
  _id_C640A385CFD8BB75 = scripts\mp\utility\game::istimetobeatvalid();

  if(inot) {
    if(_id_31E2A8F506168626) {
      setomnvar("ui_round_hint_override_attackers", 1);
      setomnvar("ui_round_hint_override_defenders", 1);
    } else if(_id_C640A385CFD8BB75) {
      setomnvar("ui_round_hint_override_attackers", scripts\engine\utility::ter_op(game["timeToBeatTeam"] == game["attackers"], 2, 3));
      setomnvar("ui_round_hint_override_defenders", scripts\engine\utility::ter_op(game["timeToBeatTeam"] == game["defenders"], 2, 3));
    } else {
      setomnvar("ui_round_hint_override_attackers", 4);
      setomnvar("ui_round_hint_override_defenders", 4);
    }
  }

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(scripts\mp\utility\game::inovertime())
    setDvar("ui_override_halftime", 0);
  else if(game["switchedsides"])
    setDvar("ui_override_halftime", 2);
  else
    setDvar("ui_override_halftime", 1);

  if(!isDefined(game["original_defenders"]))
    game["original_defenders"] = game["defenders"];

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

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.winrule = scripts\mp\utility\dvars::dvarintvalue("winRule", 0, 0, 1);
  level.showenemycarrier = scripts\mp\utility\dvars::dvarintvalue("showEnemyCarrier", 5, 0, 6);
  level.idleresettime = scripts\mp\utility\dvars::dvarfloatvalue("idleResetTime", 30, 0, 60);
  level.capturecondition = scripts\mp\utility\dvars::dvarintvalue("captureCondition", 0, 0, 1);
  level.pickuptime = scripts\mp\utility\dvars::dvarfloatvalue("pickupTime", 0, 0, 10);
  level.returntime = scripts\mp\utility\dvars::dvarfloatvalue("returnTime", 0, -1, 25);
}

createflagsandhud() {
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

flag_setupvfx() {}

initspawns() {
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

assignteamspawns() {
  spawnpoints = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype);
  ispathdataavailable = scripts\mp\spawnlogic::ispathdataavailable();
  level.teamspawnpoints["axis"] = [];
  level.teamspawnpoints["allies"] = [];
  level.teamspawnpoints["neutral"] = [];

  if(level.teamflags.size == 2) {
    _id_52283A0A1CF75C1E = level.teamflags["allies"];
    _id_5228390A1CF759EB = level.teamflags["axis"];
    _id_22D30D2DB06D47EA = (_id_52283A0A1CF75C1E.curorigin[0], _id_52283A0A1CF75C1E.curorigin[1], 0);
    _id_4F73762DD18A9B93 = (_id_5228390A1CF759EB.curorigin[0], _id_5228390A1CF759EB.curorigin[1], 0);
    _id_556BD2AB7D99178B = _id_4F73762DD18A9B93 - _id_22D30D2DB06D47EA;
    _id_7562A3D0685EA6EB = length2d(_id_556BD2AB7D99178B);

    foreach(spawnpoint in spawnpoints) {
      _id_C982049EA3238D92 = (spawnpoint.origin[0], spawnpoint.origin[1], 0);
      _id_9AF7B82DE70E01D8 = _id_C982049EA3238D92 - _id_22D30D2DB06D47EA;
      _id_4D2D882316198C95 = vectordot(_id_9AF7B82DE70E01D8, _id_556BD2AB7D99178B);
      _id_A40D2CEA46F228CA = _id_4D2D882316198C95 / (_id_7562A3D0685EA6EB * _id_7562A3D0685EA6EB);

      if(_id_A40D2CEA46F228CA < 0.33) {
        spawnpoint.teambase = _id_52283A0A1CF75C1E.ownerteam;
        level.teamspawnpoints[spawnpoint.teambase][level.teamspawnpoints[spawnpoint.teambase].size] = spawnpoint;
        continue;
      }

      if(_id_A40D2CEA46F228CA > 0.67) {
        spawnpoint.teambase = _id_5228390A1CF759EB.ownerteam;
        level.teamspawnpoints[spawnpoint.teambase][level.teamspawnpoints[spawnpoint.teambase].size] = spawnpoint;
        continue;
      }

      _id_5838748BF91BE3C2 = undefined;
      _id_D11E294724D3ABCB = undefined;

      if(ispathdataavailable)
        _id_5838748BF91BE3C2 = getpathdist(spawnpoint.origin, _id_52283A0A1CF75C1E.curorigin, 999999);

      if(isDefined(_id_5838748BF91BE3C2) && _id_5838748BF91BE3C2 != -1)
        _id_D11E294724D3ABCB = getpathdist(spawnpoint.origin, _id_5228390A1CF759EB.curorigin, 999999);

      if(!isDefined(_id_D11E294724D3ABCB) || _id_D11E294724D3ABCB == -1) {
        _id_5838748BF91BE3C2 = distance2d(_id_52283A0A1CF75C1E.curorigin, spawnpoint.origin);
        _id_D11E294724D3ABCB = distance2d(_id_5228390A1CF759EB.curorigin, spawnpoint.origin);
      }

      _id_7C7809CDC3F571E5 = max(_id_5838748BF91BE3C2, _id_D11E294724D3ABCB);
      _id_126715ED2B04D65F = min(_id_5838748BF91BE3C2, _id_D11E294724D3ABCB);
      _id_882F07CD483EE4DA = _id_126715ED2B04D65F / _id_7C7809CDC3F571E5;

      if(_id_882F07CD483EE4DA > 0.5)
        level.teamspawnpoints["neutral"][level.teamspawnpoints["neutral"].size] = spawnpoint;
    }
  } else {
    foreach(spawnpoint in spawnpoints) {
      spawnpoint.teambase = getnearestflagteam(spawnpoint);

      if(spawnpoint.teambase == "axis") {
        level.teamspawnpoints["axis"][level.teamspawnpoints["axis"].size] = spawnpoint;
        continue;
      }

      level.teamspawnpoints["allies"][level.teamspawnpoints["allies"].size] = spawnpoint;
    }
  }
}

getnearestflagteam(spawnpoint) {
  ispathdataavailable = scripts\mp\spawnlogic::ispathdataavailable();
  _id_7EFD24545F778D1F = undefined;
  _id_36213E24B6EA2351 = undefined;

  foreach(flag in level.teamflags) {
    dist = undefined;

    if(ispathdataavailable)
      dist = getpathdist(spawnpoint.origin, flag.curorigin, 999999);

    if(!isDefined(dist) || dist == -1)
      dist = distancesquared(flag.curorigin, spawnpoint.origin);

    if(!isDefined(_id_7EFD24545F778D1F) || dist < _id_36213E24B6EA2351) {
      _id_7EFD24545F778D1F = flag;
      _id_36213E24B6EA2351 = dist;
    }
  }

  return _id_7EFD24545F778D1F.ownerteam;
}

getspawnpoint() {
  spawnteam = self.pers["team"];
  enemyteam = scripts\mp\utility\game::getotherteam(spawnteam)[0];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(level.mapname == "mp_runner") {
      spawnteam = scripts\mp\utility\game::getotherteam(spawnteam)[0];
      enemyteam = scripts\mp\utility\game::getotherteam(enemyteam)[0];
    }

    if(game["switchedsides"]) {
      spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_ctf_spawn_" + enemyteam + "_start");
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints);
    } else {
      spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_ctf_spawn_" + spawnteam + "_start");
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints);
    }
  } else
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, level.ctfteamspawnsetids[spawnteam], "neutral");

  return spawnpoint;
}

flag_default_origins() {
  level.default_goal_origins = [];
  level.flags = getEntArray("flag_primary", "targetname");

  if(!isDefined(game["attackers"]))
    game["attackers"] = "allies";

  if(!isDefined(game["defenders"]))
    game["defenders"] = "axis";

  if(istrue(game["switchedsides"])) {
    _id_2B21F2FBE8DD5C6E = game["attackers"];
    _id_8D904E28CF14C8AE = game["defenders"];
    game["attackers"] = _id_8D904E28CF14C8AE;
    game["defenders"] = _id_2B21F2FBE8DD5C6E;
  }

  foreach(flag in level.flags) {
    switch (flag.script_label) {
      case "_a":
        if(istrue(game["switchedsides"]))
          level.default_flag_origins[game["defenders"]] = flag.origin;
        else
          level.default_flag_origins[game["attackers"]] = flag.origin;

        break;
      case "_c":
        if(istrue(game["switchedsides"]))
          level.default_flag_origins[game["attackers"]] = flag.origin;
        else
          level.default_flag_origins[game["defenders"]] = flag.origin;

        break;
    }
  }

  trigger = getEnt("ctf_zone_" + game["defenders"], "targetname");

  if(isDefined(trigger)) {
    if(istrue(game["switchedsides"]))
      level.default_flag_origins[game["attackers"]] = trigger.origin;
    else
      level.default_flag_origins[game["defenders"]] = trigger.origin;
  }

  trigger = getEnt("ctf_zone_" + game["attackers"], "targetname");

  if(isDefined(trigger)) {
    if(istrue(game["switchedsides"]))
      level.default_flag_origins[game["defenders"]] = trigger.origin;
    else
      level.default_flag_origins[game["attackers"]] = trigger.origin;
  }
}

flag_create_team_goal(team) {
  goal = spawnStruct();

  switch (level.script) {
    default:
      break;
  }

  if(!isDefined(goal.origin))
    goal.origin = level.default_flag_origins[team];

  goal flag_find_ground();
  goal.origin = goal.ground_origin;
  goal.radius = 30;
  goal.team = team;
  goal.ball_in_goal = 0;
  goal.highestspawndistratio = 0;
  return goal;
}

flag_find_ground(_id_29B6333B64DE3FFD) {
  tracestart = self.origin + (0, 0, 32);
  _id_8B39E5984DA1FFAF = self.origin + (0, 0, -1000);
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  ignoreents = [];
  trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, contentoverride);
  self.ground_origin = trace["position"];
  return trace["fraction"] != 0 && trace["fraction"] != 1;
}

showflagradiuseffecttoplayers(team, player, position) {
  if(isDefined(player._flagradiuseffect[team]))
    player._flagradiuseffect[team] delete();

  effect = undefined;
  _id_8E879FAF3052E0D2 = player.team;
  _id_8420670EAFC8D391 = player _meth_8420670EAFC8D391();

  if(_id_8420670EAFC8D391)
    _id_8E879FAF3052E0D2 = player _meth_638EEBEFF841E16A();
  else if(_id_8E879FAF3052E0D2 == "spectator")
    _id_8E879FAF3052E0D2 = "allies";

  if(_id_8E879FAF3052E0D2 == team) {
    _id_64DF8525AE68EBE4 = spawnfxforclient(level.flagradiusfxid["friendly"], position, player, (0, 0, 1));
    _id_64DF8525AE68EBE4 setfxkilldefondelete();
  } else {
    _id_64DF8525AE68EBE4 = spawnfxforclient(level.flagradiusfxid["enemy"], position, player, (0, 0, 1));
    _id_64DF8525AE68EBE4 setfxkilldefondelete();
  }

  player._flagradiuseffect[team] = _id_64DF8525AE68EBE4;
  triggerfx(_id_64DF8525AE68EBE4);
}

showbaseeffecttoplayer(team, player) {
  if(isDefined(player._flageffect[team]))
    player._flageffect[team] delete();

  effect = undefined;
  _id_8E879FAF3052E0D2 = player.team;
  _id_8420670EAFC8D391 = player _meth_8420670EAFC8D391();

  if(_id_8420670EAFC8D391)
    _id_8E879FAF3052E0D2 = player _meth_638EEBEFF841E16A();
  else if(_id_8E879FAF3052E0D2 == "spectator")
    _id_8E879FAF3052E0D2 = "allies";

  if(_id_8E879FAF3052E0D2 == team) {
    _id_64DF8525AE68EBE4 = spawnfxforclient(level.flagbaseglowfxid["friendly"], self.origin, player, self.baseeffectforward);
    _id_64DF8525AE68EBE4 setfxkilldefondelete();
  } else {
    _id_64DF8525AE68EBE4 = spawnfxforclient(level.flagbaseglowfxid["enemy"], self.origin, player, self.baseeffectforward);
    _id_64DF8525AE68EBE4 setfxkilldefondelete();
  }

  player._flageffect[team] = _id_64DF8525AE68EBE4;
  triggerfx(_id_64DF8525AE68EBE4);
}

setteaminhuddatafromteamname(_id_FABF84450735DD93) {
  if(_id_FABF84450735DD93 == "axis")
    self setteaminhuddata(1);
  else if(_id_FABF84450735DD93 == "allies")
    self setteaminhuddata(2);
  else
    self setteaminhuddata(0);
}

createteamflag(team, _id_B7BC03D62FDB8D7F) {
  _id_0DA71D292931C16B = 0;
  _id_B7BA378AE30BEDB4 = flag_create_team_goal(team);
  trigger = spawn("trigger_radius", _id_B7BA378AE30BEDB4.origin - (0, 0, _id_B7BA378AE30BEDB4.radius / 2), 0, _id_B7BA378AE30BEDB4.radius, 80);
  trigger.no_moving_platfrom_unlink = 1;
  trigger.linktoenabledflag = 1;
  trigger.baseorigin = trigger.origin;
  _id_0DA71D292931C16B = 1;
  visuals[0] = spawn("script_model", _id_B7BA378AE30BEDB4.origin);
  visuals[0] setasgametypeobjective();
  visuals[0] setteaminhuddatafromteamname(_id_B7BC03D62FDB8D7F);

  if(!isDefined(visuals[0])) {}

  if(!_id_0DA71D292931C16B) {
    radius = 15;

    if(level.pickuptime > 0 || level.returntime > 0)
      radius = radius * 2;

    _id_25D213B4714288CE = spawn("trigger_radius", trigger.origin, 0, radius, trigger.height);
    trigger = _id_25D213B4714288CE;
  }

  visuals[0] setModel(level.flagmodel[team]);
  visuals[0] setasgametypeobjective();
  visuals[0] setteaminhuddatafromteamname(_id_B7BC03D62FDB8D7F);
  _id_3BC2B88A59B6D062 = scripts\mp\gameobjects::createcarryobject(team, trigger, visuals, (0, 0, 72));
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::allowcarry("friendly");
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setteamusetime("friendly", level.pickuptime);
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setteamusetime("enemy", level.returntime);
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setvisibleteam("friendly");
  scripts\mp\objidpoolmanager::objective_set_play_intro(_id_3BC2B88A59B6D062.objidnum, 0);
  _id_3BC2B88A59B6D062.atbase = 1;
  _id_3BC2B88A59B6D062.allowweapons = 1;
  _id_3BC2B88A59B6D062.onpickup = ::onpickup;
  _id_3BC2B88A59B6D062.onpickupfailed = ::onpickup;
  _id_3BC2B88A59B6D062.ondrop = ::ondrop;
  _id_3BC2B88A59B6D062.onreset = ::onreset;
  _id_3BC2B88A59B6D062.onbeginuse = ::onresetstart;
  _id_3BC2B88A59B6D062.onenduse = ::onresetend;

  if(level.pickuptime > 0 || level.returntime > 0) {
    _id_3BC2B88A59B6D062.nousebar = 1;
    _id_3BC2B88A59B6D062.claimgracetime = max(level.pickuptime * 1000, level.returntime * 1000);
    _id_3BC2B88A59B6D062 scripts\mp\gameobjects::pinobjiconontriggertouch();
  }

  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        _id_3BC2B88A59B6D062.objidpingfriendly = 0;
        _id_3BC2B88A59B6D062.objidpingenemy = 1;
        _id_3BC2B88A59B6D062.objpingdelay = 60.0;
        break;
      case 1:
        _id_3BC2B88A59B6D062.objidpingfriendly = 0;
        _id_3BC2B88A59B6D062.objidpingenemy = 1;
        _id_3BC2B88A59B6D062.objpingdelay = 0.05;
        break;
      case 2:
        _id_3BC2B88A59B6D062.objidpingfriendly = 0;
        _id_3BC2B88A59B6D062.objidpingenemy = 1;
        _id_3BC2B88A59B6D062.objpingdelay = 1.0;
        break;
      case 3:
        _id_3BC2B88A59B6D062.objidpingfriendly = 0;
        _id_3BC2B88A59B6D062.objidpingenemy = 1;
        _id_3BC2B88A59B6D062.objpingdelay = 1.5;
        break;
      case 4:
        _id_3BC2B88A59B6D062.objidpingfriendly = 0;
        _id_3BC2B88A59B6D062.objidpingenemy = 1;
        _id_3BC2B88A59B6D062.objpingdelay = 2.0;
        break;
      case 5:
        _id_3BC2B88A59B6D062.objidpingfriendly = 0;
        _id_3BC2B88A59B6D062.objidpingenemy = 1;
        _id_3BC2B88A59B6D062.objpingdelay = 3.0;
        break;
      case 6:
        _id_3BC2B88A59B6D062.objidpingfriendly = 0;
        _id_3BC2B88A59B6D062.objidpingenemy = 1;
        _id_3BC2B88A59B6D062.objpingdelay = 4.0;
        break;
    }
  } else {
    _id_3BC2B88A59B6D062.objidpingfriendly = 0;
    _id_3BC2B88A59B6D062.objidpingenemy = 1;
    _id_3BC2B88A59B6D062.objpingdelay = 3.0;
  }

  _id_3BC2B88A59B6D062.oldradius = trigger.radius;
  tracestart = trigger.origin + (0, 0, 32);
  _id_8B39E5984DA1FFAF = trigger.origin + (0, 0, -32);
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  ignoreents = [];
  trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, contentoverride);
  _id_3BC2B88A59B6D062.baseeffectpos = _id_3BC2B88A59B6D062.visuals[0].origin;
  upangles = anglestoup(_id_3BC2B88A59B6D062.visuals[0].angles);
  _id_3BC2B88A59B6D062.baseeffectforward = anglesToForward(upangles);
  level.teamflagbases[team] = createteamflagbase(team, _id_3BC2B88A59B6D062);
  return _id_3BC2B88A59B6D062;
}

createteamflagbase(team, _id_3BC2B88A59B6D062) {
  _id_D9CA1813B9DE5E20 = _id_3BC2B88A59B6D062.visuals[0].origin;
  _id_0FD8B4C619F5E9FF = spawn("script_model", _id_D9CA1813B9DE5E20);
  _id_0FD8B4C619F5E9FF setModel(level.flagbase[team]);
  _id_0FD8B4C619F5E9FF.ownerteam = team;
  _id_0FD8B4C619F5E9FF setasgametypeobjective();
  _id_0FD8B4C619F5E9FF setteaminhuddatafromteamname(team);
  _id_0FD8B4C619F5E9FF.baseeffectpos = _id_D9CA1813B9DE5E20;
  upangles = anglestoup(_id_3BC2B88A59B6D062.visuals[0].angles);
  _id_0FD8B4C619F5E9FF.baseeffectforward = anglesToForward(upangles);
  return _id_0FD8B4C619F5E9FF;
}

createcapzone(team, _id_B7BC03D62FDB8D7F) {
  _id_B7BA378AE30BEDB4 = flag_create_team_goal(team);
  trigger = getEnt("ctf_zone_" + _id_B7BC03D62FDB8D7F, "targetname");

  if(!isDefined(trigger)) {
    trigger = spawn("trigger_radius", _id_B7BA378AE30BEDB4.origin - (0, 0, _id_B7BA378AE30BEDB4.radius / 2), 0, _id_B7BA378AE30BEDB4.radius, 80);
    trigger.no_moving_platfrom_unlink = 1;
    trigger.linktoenabledflag = 1;
    trigger.baseorigin = trigger.origin;
    trigger.height = 80;
  }

  _id_25D213B4714288CE = spawn("trigger_radius", trigger.origin, 0, 15, trigger.height);
  trigger = _id_25D213B4714288CE;
  visuals = [];
  _id_E1C2BB288FC23E0D = scripts\mp\gameobjects::createuseobject(team, trigger, visuals, (0, 0, 85));
  _id_E1C2BB288FC23E0D scripts\mp\gameobjects::allowuse("enemy");
  _id_E1C2BB288FC23E0D scripts\mp\gameobjects::setvisibleteam("any");
  _id_E1C2BB288FC23E0D scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupdefendflag, level.icongoalflag);
  _id_E1C2BB288FC23E0D scripts\mp\gameobjects::setusetime(0);
  _id_E1C2BB288FC23E0D scripts\mp\gameobjects::setkeyobject(level.teamflags[scripts\mp\utility\game::getotherteam(team)[0]]);
  _id_E1C2BB288FC23E0D.onuse = ::onuse;
  tracestart = trigger.origin + (0, 0, 32);
  _id_8B39E5984DA1FFAF = trigger.origin + (0, 0, -32);
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  ignoreents = [];
  trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, contentoverride);
  upangles = vectortoangles(trace["normal"]);
  forward = anglesToForward(upangles);
  right = anglestoright(upangles);
  return _id_E1C2BB288FC23E0D;
}

onbeginuse(player) {
  team = player.pers["team"];

  if(team == scripts\mp\gameobjects::getownerteam())
    self.trigger.radius = 1024;
  else
    self.trigger.radius = self.oldradius;
}

onenduse(player, team, success) {
  self.trigger.radius = self.oldradius;
}

onpickup(player, _id_5760E0F038D1BAA3, defused) {
  self notify("picked_up");
  player notify("obj_picked_up");
  team = player.pers["team"];

  if(team == "allies")
    otherteam = "axis";
  else
    otherteam = "allies";

  if(team != scripts\mp\gameobjects::getownerteam()) {
    if(isDefined(level.closecapturekiller[player.team]) && level.closecapturekiller[player.team] == player)
      player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_FE8BA8AD4E2E427B");

    level.closecapturekiller[player.team] = undefined;
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_FF156B04645795AE");
    thread returnflag(team);
    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.player = player;
    _id_7E2C53B0BCF117D9.eventname = "obj_return";
    _id_7E2C53B0BCF117D9.position = player.origin;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
    scripts\mp\utility\sound::playsoundonplayers("mp_obj_returned", team);
    scripts\mp\utility\sound::playsoundonplayers("mp_obj_returned", scripts\mp\utility\game::getotherteam(team)[0]);
    scripts\mp\utility\dialog::leaderdialog("ourblitzflag_return", otherteam, "status");
    scripts\mp\utility\dialog::leaderdialog("enemyblitzflag_return", team, "status");
    player scripts\mp\utility\stats::incpersstat("returns", 1);
    player scripts\mp\persistence::statsetchild("round", "returns", player.pers["returns"]);

    if(isPlayer(player))
      player scripts\mp\utility\stats::setextrascore1(player.pers["returns"]);
  } else {
    if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[team]))
      player thread applyflagcarrierclass();
    else
      player attachflag();

    self.atbase = 0;
    level.closecapturekiller[otherteam] = undefined;

    if(player.team == "allies")
      setomnvar("ui_ctf_flag_allies", player getentitynumber());
    else
      setomnvar("ui_ctf_flag_axis", player getentitynumber());

    player setclientomnvar("ui_flag_player_hud_icon", 1);

    if(isDefined(level.showenemycarrier)) {
      if(level.showenemycarrier == 0)
        scripts\mp\gameobjects::setvisibleteam("any");
      else
        scripts\mp\gameobjects::setvisibleteam("any");
    }

    scripts\mp\gameobjects::setobjectivestatusicons(level.iconescort, level.iconkill);

    if(level.teamflags[otherteam].atbase)
      level.capzones[otherteam] scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupdefendflag, level.icongoalflag);
    else {
      level.capzones[otherteam] scripts\mp\gameobjects::setvisibleteam("any");
      level.capzones[otherteam] scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendflag, level.icongoalflag);
    }

    level.capzones[team] scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendflag, level.icongoalflag);

    if(level.capturecondition == 0) {}

    scripts\mp\utility\sound::playsoundonplayers("mp_obj_taken", team);
    scripts\mp\utility\dialog::leaderdialog("ourblitzflag_taken", team);
    thread scripts\mp\hud_util::teamplayercardsplash("callout_flagpickup", player);

    if(!isDefined(self.previouscarrier) || self.previouscarrier != player)
      player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_91372813B1BCAF92");

    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.player = player;
    _id_7E2C53B0BCF117D9.eventname = "pickup";
    _id_7E2C53B0BCF117D9.position = player.origin;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
    self.previouscarrier = player;

    if(level.codcasterenabled)
      player setgametypevip(1);
  }
}

returnflag(team) {
  self.atbase = 1;

  if(team == "allies")
    setomnvar("ui_ctf_flag_allies", -2);
  else
    setomnvar("ui_ctf_flag_axis", -2);

  scripts\mp\gameobjects::returnhome();
}

ondrop(player) {
  team = scripts\mp\gameobjects::getownerteam();
  otherteam = scripts\mp\utility\game::getotherteam(team)[0];
  scripts\mp\gameobjects::allowcarry("any");
  scripts\mp\gameobjects::setvisibleteam("any");
  objective_setpings(self.objidnum, 0);

  if(level.returntime >= 0)
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupflag, level.iconreturnflag);
  else
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupflag, level.icongoalflag);

  if(team == "allies")
    setomnvar("ui_ctf_flag_allies", -1);
  else
    setomnvar("ui_ctf_flag_axis", -1);

  if(isDefined(player))
    player setclientomnvar("ui_flag_player_hud_icon", 0);

  _id_86929BFC3B565860 = self.visuals[0] gettagorigin("tag_origin");

  if(isDefined(player)) {
    if(!scripts\mp\utility\player::isreallyalive(player))
      player.carryobject.previouscarrier = undefined;

    if(isDefined(player.carryflag))
      player detachflag();

    scripts\mp\utility\sound::playsoundonplayers("iw9_mp_ui_objective_lost", otherteam);

    if(level.codcasterenabled)
      player setgametypevip(0);
  } else
    scripts\mp\utility\sound::playsoundonplayers("iw9_mp_ui_objective_lost", otherteam);

  scripts\mp\utility\dialog::leaderdialog("enemyblitzflag_drop", otherteam, "status");
  scripts\mp\utility\dialog::leaderdialog("ourblitzflag_drop", team, "status");

  if(level.idleresettime > 0)
    thread returnaftertime();
}

returnaftertime() {
  self endon("picked_up");
  _id_8E53D4CA3DE8531A = 0.0;

  while(_id_8E53D4CA3DE8531A < level.idleresettime) {
    waitframe();

    if(self.claimteam == "none")
      _id_8E53D4CA3DE8531A = _id_8E53D4CA3DE8531A + level.framedurationseconds;
  }

  team = scripts\mp\gameobjects::getownerteam();
  otherteam = scripts\mp\utility\game::getotherteam(team)[0];
  scripts\mp\utility\sound::playsoundonplayers("iw9_mp_ui_objective_taken", team);
  scripts\mp\utility\sound::playsoundonplayers("iw9_mp_ui_objective_lost", otherteam);
  scripts\mp\gameobjects::returnhome();
}

onreset() {
  team = scripts\mp\gameobjects::getownerteam();
  otherteam = scripts\mp\utility\game::getotherteam(team)[0];
  scripts\mp\gameobjects::allowcarry("friendly");
  scripts\mp\gameobjects::setvisibleteam("none");
  objective_setpings(self.objidnum, 0);

  if(team == "allies")
    setomnvar("ui_ctf_flag_allies", -2);
  else
    setomnvar("ui_ctf_flag_axis", -2);

  if(level.teamflags[team].atbase)
    level.capzones[team] scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupdefendflag, level.icongoalflag);

  if(level.teamflags[otherteam].atbase)
    level.capzones[team] scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupdefendflag, level.icongoalflag);
  else
    level.capzones[team] scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendflag, level.icongoalflag);

  level.capzones[team] scripts\mp\gameobjects::allowuse("enemy");
  self.previouscarrier = undefined;
}

onresetstart(player) {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosingflag, level.iconresettingflag);
}

onresetend(player, team, success) {
  if(!success)
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconpickupflag, level.iconreturnflag);
}

onuse(player) {
  if(!level.gameended) {
    team = player.pers["team"];

    if(team == "allies")
      otherteam = "axis";
    else
      otherteam = "allies";

    player setclientomnvar("ui_flag_player_hud_icon", 0);
    scripts\mp\utility\dialog::leaderdialog("ourblitzflag_capt", team, "status");
    scripts\mp\utility\dialog::leaderdialog("enemyblitzflag_capt", otherteam, "status");
    thread scripts\mp\hud_util::teamplayercardsplash("callout_flagcapture", player);
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_7B8C8A78AC292C0D");
    player notify("objective", "captured");
    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.player = player;
    _id_7E2C53B0BCF117D9.eventname = "capture";
    _id_7E2C53B0BCF117D9.position = player.origin;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);

    if(level.codcasterenabled)
      player setgametypevip(0);

    player scripts\mp\utility\stats::incpersstat("captures", 1);
    player scripts\mp\persistence::statsetchild("round", "captures", player.pers["captures"]);

    if(isPlayer(player))
      player scripts\mp\utility\stats::setextrascore0(player.pers["captures"]);

    scripts\mp\utility\sound::playsoundonplayers("mp_obj_captured", team);
    scripts\mp\utility\sound::playsoundonplayers("mp_enemy_obj_captured", scripts\mp\utility\game::getotherteam(team)[0]);

    if(isDefined(player.carryflag))
      player detachflag();

    if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[team]))
      player thread removeflagcarrierclass();

    level.closecapturekiller[team] = undefined;
    level.closecapturekiller[otherteam] = undefined;

    if(level.teamflags[scripts\mp\utility\game::getotherteam(team)[0]].atbase)
      level scripts\mp\gamescore::giveteamscoreforobjective(team, 2, 0);
    else
      level scripts\mp\gamescore::giveteamscoreforobjective(team, 1, 0);

    level.teamflags[team] returnflag(team);
  }
}

onplayerconnect(player) {
  player._flageffect = [];
  player._flagradiuseffect = [];
  player thread onplayerspawned();
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned");
    self setclientomnvar("ui_flag_player_hud_icon", 0);
    scripts\mp\utility\stats::setextrascore0(0);

    if(isDefined(self.pers["captures"]))
      scripts\mp\utility\stats::setextrascore0(self.pers["captures"]);

    scripts\mp\utility\stats::setextrascore1(0);

    if(isDefined(self.pers["returns"]))
      scripts\mp\utility\stats::setextrascore1(self.pers["returns"]);
  }
}

applyflagcarrierclass() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self ismantling())
    waitframe();

  while(!self isonground())
    waitframe();

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

waitattachflag() {
  level endon("game_ende");
  self endon("death_or_disconnect");
  self waittill("spawned_player");
  attachflag();
}

removeflagcarrierclass() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self ismantling())
    waitframe();

  while(!self isonground())
    waitframe();

  self.pers["gamemodeLoadout"] = undefined;
  scripts\mp\equipment\tac_insert::spawnpoint_setspawnpoint(self.origin, self.angles);
  self notify("faux_spawn");
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  _id_AEC2E5E01F424119 = 0;
  _id_86C1C8628B1D55F8 = attacker.origin;
  attackerisinflictor = 0;

  if(isDefined(einflictor)) {
    _id_86C1C8628B1D55F8 = einflictor.origin;
    attackerisinflictor = einflictor == attacker;
  }

  if(isDefined(attacker) && isPlayer(attacker) && attacker.pers["team"] != self.pers["team"]) {
    if(isDefined(attacker.carryflag) && attackerisinflictor) {
      attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_F735B92839C5A687");
      _id_AEC2E5E01F424119 = 1;
    }

    if(isDefined(self.carryflag)) {
      _id_33F8CE08C3E0650B = distancesquared(self.origin, level.capzones[self.team].trigger.origin);

      if(_id_33F8CE08C3E0650B < 90000)
        level.closecapturekiller[attacker.team] = attacker;
      else
        level.closecapturekiller[attacker.team] = undefined;

      attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5311F153A7FEE40C");
      attacker scripts\mp\utility\stats::incpersstat("defends", 1);
      attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
      thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, _id_61B5D0250B328F00, "carrying");
      _id_AEC2E5E01F424119 = 1;
    }

    if(!_id_AEC2E5E01F424119) {
      _id_3CD1AF2851F12AB5 = 0;
      _id_C3F9FED5999C974E = 0;

      foreach(flag in level.teamflags) {
        _id_D4D1706F5BCA5ABD = distsquaredcheck(_id_86C1C8628B1D55F8, self.origin, flag.curorigin);

        if(_id_D4D1706F5BCA5ABD) {
          if(flag.ownerteam == self.team) {
            _id_3CD1AF2851F12AB5 = 1;
            continue;
          }

          _id_C3F9FED5999C974E = 1;
        }
      }

      if(_id_3CD1AF2851F12AB5) {
        attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5A3B180273BE47B1");
        thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, _id_61B5D0250B328F00, "defending");
      } else if(_id_C3F9FED5999C974E) {
        attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2D96CED878338CD2");
        attacker scripts\mp\utility\stats::incpersstat("defends", 1);
        attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
        thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, _id_61B5D0250B328F00, "assaulting");
      }
    }
  }

  if(isDefined(self.carryflag))
    detachflag();
}

distsquaredcheck(_id_86C1C8628B1D55F8, _id_F7DED1FDB02A123D, _id_76227CD0036993E3) {
  _id_AAE76E7732B9A9DA = distancesquared(_id_76227CD0036993E3, _id_86C1C8628B1D55F8);
  _id_3D29A24F32F790B1 = distancesquared(_id_76227CD0036993E3, _id_F7DED1FDB02A123D);

  if(_id_AAE76E7732B9A9DA < 90000 || _id_3D29A24F32F790B1 < 90000)
    return 1;
  else
    return 0;
}

attachflag() {
  otherteam = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];
  self attach(level.carryflag[otherteam], "tag_stowed_back3", 1);
  self.carryflag = level.carryflag[otherteam];
}

detachflag() {
  self detach(self.carryflag, "tag_stowed_back3");
  self.carryflag = undefined;
}

setspecialloadouts() {
  if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses", "axis", 5, "class", "inUse"))
    level.ctf_loadouts["axis"] = scripts\mp\utility\game::getmatchrulesspecialclass("axis", 5);

  if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses", "allies", 5, "class", "inUse"))
    level.ctf_loadouts["allies"] = scripts\mp\utility\game::getmatchrulesspecialclass("allies", 5);
}

setupwaypointicons() {
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