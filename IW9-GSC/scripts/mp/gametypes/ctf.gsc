/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\ctf.gsc
***********************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  flag_default_origins();
  _id_9BBACB179DEA3237[0] = "ctf";
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
  level.onmaprestart = ::_id_9136C8E96AE14D11;
  level.spawnnodetype = "mp_ctf_spawn";

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    game["dialog"]["gametype"] = "iw9_mpcf_mode_uktl_cft1";
  else
    game["dialog"]["gametype"] = "gametype_ctf";

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

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_ctf_winrule", getmatchrulesdata("ctfData", "winRule"));
  setdynamicdvar("scr_ctf_capturecondition", getmatchrulesdata("ctfData", "captureCondition"));
  setdynamicdvar("scr_ctf_returntime", getmatchrulesdata("ctfData", "returnTime"));
  setdynamicdvar("scr_ctf_showenemycarrier", getmatchrulesdata("carryData", "showEnemyCarrier"));
  setdynamicdvar("scr_ctf_idleresettime", getmatchrulesdata("carryData", "idleResetTime"));
  setdynamicdvar("scr_ctf_pickuptime", getmatchrulesdata("carryData", "pickupTime"));
  setdynamicdvar("dvar_82F42DFD88CBACAD", getmatchrulesdata("carryData", "manualDropEnabled"));
  setdynamicdvar("scr_ctf_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("ctf", 0);
}

onspawnplayer(_id_9156B53BCF7CE573) {
  updatematchstatushintonnoflag();
}

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

  if(game["switchedsides"]) {
    _id_2B21F2FBE8DD5C6E = game["attackers"];
    _id_8D904E28CF14C8AE = game["defenders"];
    game["attackers"] = _id_8D904E28CF14C8AE;
    game["defenders"] = _id_2B21F2FBE8DD5C6E;
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

flag_setupvfx() {}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("AwayFromEnemies", "Crit_Default");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_ctf_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_ctf_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_ctf_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_ctf_spawn_axis_start");
  attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_ctf_spawn_allies_start");
  _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_ctf_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", _id_2FD93EA689E77097);
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
        spawnpoint.teambase = scripts\mp\utility\game::getotherteam(_id_52283A0A1CF75C1E.ownerteam)[0];
        level.teamspawnpoints[spawnpoint.teambase][level.teamspawnpoints[spawnpoint.teambase].size] = spawnpoint;
        continue;
      }

      if(_id_A40D2CEA46F228CA > 0.67) {
        spawnpoint.teambase = scripts\mp\utility\game::getotherteam(_id_5228390A1CF759EB.ownerteam)[0];
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

  return scripts\mp\utility\game::getotherteam(_id_7EFD24545F778D1F.ownerteam)[0];
}

getspawnpoint() {
  spawnteam = self.pers["team"];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(spawnteam == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
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

  foreach(flag in level.flags) {
    switch (flag.script_label) {
      case "_a":
        level.default_flag_origins[game["attackers"]] = flag.origin;
        break;
      case "_c":
        level.default_flag_origins[game["defenders"]] = flag.origin;
        break;
    }
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

removeflagpickupradiuseffect(_id_2A2A344185173D62) {
  if(_id_2A2A344185173D62 == self.team) {
    if(isDefined(self._flagradiuseffect[self.team]))
      self._flagradiuseffect[self.team] delete();
  } else if(isDefined(self._flagradiuseffect[scripts\mp\utility\game::getotherteam(self.team)[0]]))
    self._flagradiuseffect[scripts\mp\utility\game::getotherteam(self.team)[0]] delete();
}

setteaminhuddatafromteamname(_id_FABF84450735DD93) {
  if(_id_FABF84450735DD93 == "axis")
    self setteaminhuddata(1);
  else if(_id_FABF84450735DD93 == "allies")
    self setteaminhuddata(2);
  else
    self setteaminhuddata(0);
}

player_delete_flag_goal_fx(_id_2A2A344185173D62) {
  if(_id_2A2A344185173D62 == self.team) {
    if(isDefined(self._flageffect[self.team]))
      self._flageffect[self.team] delete();
  } else if(isDefined(self._flageffect[scripts\mp\utility\game::getotherteam(self.team)[0]]))
    self._flageffect[scripts\mp\utility\game::getotherteam(self.team)[0]] delete();
}

getflagpos(team) {
  ent = getEnt("ctf_flag_" + team, "targetname");
  return ent.origin;
}

createteamflag(team, _id_B7BC03D62FDB8D7F) {
  _id_0DA71D292931C16B = 0;
  trigger = getEnt("ctf_zone_" + _id_B7BC03D62FDB8D7F, "targetname");

  if(!isDefined(trigger)) {
    _id_B7BA378AE30BEDB4 = flag_create_team_goal(team);
    trigger = spawn("trigger_radius", _id_B7BA378AE30BEDB4.origin - (0, 0, _id_B7BA378AE30BEDB4.radius / 2), 0, _id_B7BA378AE30BEDB4.radius, 80);
    trigger.no_moving_platfrom_unlink = 1;
    trigger.linktoenabledflag = 1;
    trigger.baseorigin = trigger.origin;
    _id_0DA71D292931C16B = 1;
    visuals[0] = spawn("script_model", _id_B7BA378AE30BEDB4.origin);
    visuals[0] setasgametypeobjective();
    visuals[0] setteaminhuddatafromteamname(_id_B7BC03D62FDB8D7F);
  } else
    visuals[0] = getEnt("ctf_flag_" + _id_B7BC03D62FDB8D7F, "targetname");

  if(!isDefined(visuals[0])) {}

  if(!_id_0DA71D292931C16B) {
    radius = 15;

    if(level.pickuptime > 0 || level.returntime > 0)
      radius = radius * 2;

    _id_25D213B4714288CE = spawn("trigger_radius", trigger.origin, 0, radius, trigger.height);
    trigger = _id_25D213B4714288CE;
  }

  if(level.mapname == "mp_m_speedball") {
    trigger flag_find_ground();
    trigger.origin = trigger.ground_origin;
    visuals[0].origin = trigger.ground_origin - (0, 0, 0.5);
  }

  visuals[0] setModel(level.flagmodel[team]);
  visuals[0] setasgametypeobjective();
  visuals[0] setteaminhuddatafromteamname(_id_B7BC03D62FDB8D7F);
  _id_4E86579DC7E39505 = scripts\mp\utility\game::getotherteam(team)[0];
  _id_3BC2B88A59B6D062 = scripts\mp\gameobjects::createcarryobject(_id_4E86579DC7E39505, trigger, visuals, (0, 0, 85));
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::allowcarry("friendly");
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setteamusetime("friendly", level.pickuptime);
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setteamusetime("enemy", level.returntime);
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setvisibleteam("none");
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setobjectivestatusallicons(level.iconescort, level.iconkill, undefined);
  _id_3BC2B88A59B6D062 scripts\mp\objidpoolmanager::objective_set_play_intro(_id_3BC2B88A59B6D062.objidnum, 0);
  _id_3BC2B88A59B6D062 scripts\mp\objidpoolmanager::objective_set_play_outro(_id_3BC2B88A59B6D062.objidnum, 0);
  _id_3BC2B88A59B6D062 scripts\mp\gameobjects::registercarryobjectpickupcheck(::flagpickupchecks);
  _id_3BC2B88A59B6D062.allowweapons = 1;
  _id_3BC2B88A59B6D062.originalownerteam = _id_4E86579DC7E39505;
  _id_3BC2B88A59B6D062.onpickup = ::onpickup;
  _id_3BC2B88A59B6D062.onpickupfailed = ::onpickupfailed;
  _id_3BC2B88A59B6D062.ondrop = ::ondrop;
  _id_3BC2B88A59B6D062.onreset = ::onreset;

  if(getdvarint("dvar_82F42DFD88CBACAD") != 0)
    _id_3BC2B88A59B6D062 scripts\mp\gameobjects::_id_316D9DA870E12A03([visuals[0]], trigger, 1.0, 80, 0);

  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 60.0;
        break;
      case 1:
        _id_3BC2B88A59B6D062.objidpingfriendly = 0;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 0.05;
        break;
      case 2:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 1.0;
        break;
      case 3:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 1.5;
        break;
      case 4:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 2.0;
        break;
      case 5:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 3.0;
        break;
      case 6:
        _id_3BC2B88A59B6D062.objidpingfriendly = 1;
        _id_3BC2B88A59B6D062.objidpingenemy = 0;
        _id_3BC2B88A59B6D062.objpingdelay = 4.0;
        break;
    }

    _id_220BE32C83520117 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
    _id_3BC2B88A59B6D062.pingobjidnum = _id_220BE32C83520117;
    scripts\mp\objidpoolmanager::objective_add_objective(_id_220BE32C83520117, "done", _id_3BC2B88A59B6D062.origin);
    scripts\mp\objidpoolmanager::objective_set_play_intro(_id_220BE32C83520117, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(_id_220BE32C83520117, 0);
    _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setvisibleteam("none", _id_220BE32C83520117);
    objective_setownerteam(_id_220BE32C83520117, team);
    _id_3BC2B88A59B6D062 scripts\mp\gameobjects::setobjectivestatusallicons(level.iconescort, level.iconkill, level.mlgiconfullflag, _id_220BE32C83520117);
  } else {
    _id_3BC2B88A59B6D062.objidpingfriendly = 1;
    _id_3BC2B88A59B6D062.objidpingenemy = 0;
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

flagpickupchecks(player) {
  return !player scripts\cp_mp\utility\player_utility::isinvehicle();
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
  _id_E1C2BB288FC23E0D scripts\mp\gameobjects::allowuse("friendly");
  _id_E1C2BB288FC23E0D scripts\mp\gameobjects::setvisibleteam("any");
  _id_E1C2BB288FC23E0D scripts\mp\gameobjects::setobjectivestatusallicons(level.icondefendflag, level.iconcaptureflag, level.mlgiconfullflag);
  _id_E1C2BB288FC23E0D scripts\mp\gameobjects::setusetime(0);
  _id_E1C2BB288FC23E0D scripts\mp\gameobjects::setkeyobject(level.teamflags[scripts\mp\utility\game::getotherteam(team)[0]]);
  _id_E1C2BB288FC23E0D.onuse = ::onuse;
  _id_E1C2BB288FC23E0D.oncantuse = ::oncantuse;
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
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(isDefined(self.droppedteam)) {
    if(self.droppedteam == player.team) {
      scripts\mp\gameobjects::setownerteam(self.droppedteam);
      ownerteam = self.droppedteam;
    } else {
      scripts\mp\gameobjects::setownerteam(scripts\mp\utility\game::getotherteam(player.team)[0]);
      ownerteam = self.droppedteam;
    }

    self.droppedteam = undefined;
  }

  team = player.pers["team"];

  if(team == "allies")
    otherteam = "axis";
  else
    otherteam = "allies";

  if(team != ownerteam) {
    if(isDefined(level.closecapturekiller[player.team]) && level.closecapturekiller[player.team] == player)
      player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_FE8BA8AD4E2E427B");

    level.closecapturekiller[player.team] = undefined;
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_FF156B04645795AE");

    if(level.codcasterenabled)
      level.capzones[player.team] scripts\mp\gameobjects::resetmlgobjectivestatusicon();

    thread returnflag();
    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.player = player;
    _id_7E2C53B0BCF117D9.eventname = "obj_return";
    _id_7E2C53B0BCF117D9.position = player.origin;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
    scripts\mp\utility\print::printandsoundoneveryone(team, scripts\mp\utility\game::getotherteam(team)[0], undefined, undefined, "mp_obj_returned", "mp_obj_returned", player);
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_returned", otherteam, "status");
    scripts\mp\utility\dialog::leaderdialog("flag_returned", team, "status");
    _id_548072087C9FD504::_id_7D42D3F8DD68280C(18, player.team, player getentitynumber());
    player scripts\mp\utility\stats::incpersstat("returns", 1);
    player scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(15, 1);
    player scripts\mp\persistence::statsetchild("round", "returns", player.pers["returns"]);

    if(isPlayer(player))
      player scripts\mp\utility\stats::setextrascore1(player.pers["returns"]);

    if(self.originalownerteam == "allies")
      setomnvar("ui_ctf_flag_axis", -2);
    else
      setomnvar("ui_ctf_flag_allies", -2);
  } else {
    if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[team]))
      player thread applyflagcarrierclass();
    else
      player attachflag();

    player scripts\mp\utility\stats::incpersstat("pickups", 1);
    level.closecapturekiller[otherteam] = undefined;

    if(self.originalownerteam == "allies")
      setomnvar("ui_ctf_flag_axis", player getentitynumber());
    else
      setomnvar("ui_ctf_flag_allies", player getentitynumber());

    player setclientomnvar("ui_flag_player_hud_icon", 1);

    if(isDefined(level.showenemycarrier)) {
      if(level.showenemycarrier == 0)
        scripts\mp\gameobjects::setvisibleteam("none");
      else {
        scripts\mp\gameobjects::setvisibleteam("friendly");
        objective_state(self.pingobjidnum, "current");
        scripts\mp\gameobjects::updatecompassicon("enemy", self.pingobjidnum);
        objective_icon(self.pingobjidnum, "icon_waypoint_kill");
        scripts\mp\objidpoolmanager::objective_hide_for_mlg_spectator(self.pingobjidnum, 1);
      }
    }

    scripts\mp\gameobjects::setobjectivestatusallicons(level.iconescort, level.iconkill, level.mlgiconfullflag);

    if(level.capturecondition == 0)
      level.capzones[otherteam] scripts\mp\gameobjects::allowuse("none");

    level.capzones[otherteam] scripts\mp\gameobjects::setvisibleteam("none");
    scripts\mp\utility\print::printandsoundoneveryone(team, otherteam, undefined, undefined, "mp_obj_taken", "mp_enemy_obj_taken", player);
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_taken", team);
    scripts\mp\utility\dialog::leaderdialog("flag_getback", otherteam);
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

    player thread superabilitywatcher();
  }
}

onpickupfailed(player) {
  return;
}

returnflag() {
  scripts\mp\gameobjects::returnhome();
}

ondrop(player) {
  if(isDefined(player.leaving_team)) {
    self.droppedteam = player.leaving_team;
    player.leaving_team = undefined;
  } else if(!isDefined(player))
    self.droppedteam = self.originalownerteam;
  else
    self.droppedteam = player.team;

  if(isDefined(player))
    player updatematchstatushintonnoflag();

  scripts\mp\gameobjects::setownerteam(scripts\mp\utility\game::getotherteam(self.droppedteam)[0]);
  team = self.droppedteam;
  otherteam = scripts\mp\utility\game::getotherteam(self.droppedteam)[0];
  scripts\mp\gameobjects::allowcarry("any");
  scripts\mp\gameobjects::setvisibleteam("any");
  objective_state(self.pingobjidnum, "done");

  if(level.returntime >= 0)
    scripts\mp\gameobjects::setobjectivestatusallicons(level.iconreturnflag, level.iconcaptureflag, level.mlgiconfullflag);
  else {
    scripts\mp\gameobjects::setobjectivestatusallicons(level.icondefendflag, level.iconcaptureflag, level.mlgiconfullflag);
    scripts\mp\objidpoolmanager::objective_hide_for_mlg_spectator(self.objidnum, 1);
  }

  if(self.originalownerteam == "allies")
    setomnvar("ui_ctf_flag_axis", -1);
  else
    setomnvar("ui_ctf_flag_allies", -1);

  if(isDefined(player))
    player setclientomnvar("ui_flag_player_hud_icon", 0);

  _id_86929BFC3B565860 = self.visuals[0] gettagorigin("tag_origin");

  if(isDefined(player)) {
    if(!scripts\mp\utility\player::isreallyalive(player))
      player.carryobject.previouscarrier = undefined;

    if(isDefined(player.carryflag))
      player detachflag();

    scripts\mp\utility\print::printandsoundoneveryone(otherteam, "none", undefined, undefined, "iw9_mp_ui_objective_lost", "", player);

    if(level.codcasterenabled)
      player setgametypevip(0);
  } else
    scripts\mp\utility\sound::playsoundonplayers("iw9_mp_ui_objective_lost", otherteam);

  scripts\mp\utility\dialog::leaderdialog("enemy_flag_dropped", self.originalownerteam, "status");
  scripts\mp\utility\dialog::leaderdialog("flag_dropped", scripts\mp\utility\game::getotherteam(self.originalownerteam)[0], "status");

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
  if(isDefined(self.droppedteam))
    scripts\mp\gameobjects::setownerteam(self.droppedteam);

  team = scripts\mp\gameobjects::getownerteam();
  otherteam = scripts\mp\utility\game::getotherteam(team)[0];
  self.droppedteam = undefined;
  scripts\mp\gameobjects::allowcarry("friendly");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconescort, level.iconkill);

  if(self.originalownerteam == "allies")
    setomnvar("ui_ctf_flag_axis", -2);
  else
    setomnvar("ui_ctf_flag_allies", -2);

  level.capzones[otherteam] scripts\mp\gameobjects::allowuse("friendly");
  level.capzones[otherteam] scripts\mp\gameobjects::setvisibleteam("any");
  level.capzones[otherteam] scripts\mp\gameobjects::setobjectivestatusallicons(level.icondefendflag, level.iconcaptureflag, level.mlgiconfullflag);
  self.previouscarrier = undefined;
}

onuse(player) {
  if(!level.gameended) {
    if(player scripts\cp_mp\utility\player_utility::isinvehicle()) {
      return;
    }
    team = player.pers["team"];

    if(team == "allies")
      otherteam = "axis";
    else
      otherteam = "allies";

    player setclientomnvar("ui_flag_player_hud_icon", 0);
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_captured", team, "status");
    scripts\mp\utility\dialog::leaderdialog("flag_captured", otherteam, "status");
    _id_548072087C9FD504::_id_7D42D3F8DD68280C(17, player.team, player getentitynumber());
    objective_state(level.teamflags[otherteam].pingobjidnum, "done");
    player updatematchstatushintonnoflag();
    thread scripts\mp\hud_util::teamplayercardsplash("callout_flagcapture", player);
    player thread scripts\mp\rank::scoreeventpopup("stat_2E4B4CEFA76857CA");
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
    player scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(15, 1);
    player scripts\mp\persistence::statsetchild("round", "captures", player.pers["captures"]);

    if(isPlayer(player))
      player scripts\mp\utility\stats::setextrascore0(player.pers["captures"]);

    scripts\mp\utility\print::printandsoundoneveryone(team, otherteam, undefined, undefined, "mp_obj_captured", "mp_enemy_obj_captured", player);

    if(isDefined(player.carryflag))
      player detachflag();

    if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[team]))
      player thread removeflagcarrierclass();

    level.closecapturekiller[team] = undefined;
    level.closecapturekiller[otherteam] = undefined;

    if(level.codcasterenabled)
      level.capzones[otherteam] scripts\mp\gameobjects::resetmlgobjectivestatusicon();

    level.teamflags[otherteam] returnflag();
    level scripts\mp\gamescore::giveteamscoreforobjective(team, 1, 0);
    player scripts\cp_mp\challenges::oncapture();
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
  scripts\mp\class::_id_A16868D4DCD81A4B();
  self notify("faux_spawn");
  self.gameobject_fauxspawn = 1;
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
  thread waitattachflag();
}

superabilitywatcher() {
  self notify("superWatcher");
  self endon("superWatcher");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("drop_object");
  team = self.pers["team"];

  if(team == "allies")
    otherteam = "axis";
  else
    otherteam = "allies";

  level.teamflags[otherteam] endon("reset");

  for(;;) {
    self waittill("super_started");
    _id_3F594777B26BB842 = level.teamflags[otherteam];

    if(!isDefined(_id_3F594777B26BB842)) {
      continue;
    }
    super = self.super;

    switch (super.staticdata.ref) {
      case "super_rewind":
        scripts\engine\utility::waittill_any_2("teleport_success", "rewind_success");
        _id_3F594777B26BB842 thread scripts\mp\gameobjects::setdropped();
        return;
    }
  }
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

oncantuse(player) {}

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
      attacker thread scripts\mp\rank::scoreeventpopup("stat_EBCC9C019C3B6818");
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
      attacker scripts\mp\utility\stats::incpersstat("carrierKills", 1);
      attacker scripts\mp\utility\stats::incpersstat("defends", 1);
      attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
      thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, _id_61B5D0250B328F00, "carrying");
      _id_548072087C9FD504::_id_7D42D3F8DD68280C(20, attacker.team, attacker getentitynumber());
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
        attacker thread scripts\mp\rank::scoreeventpopup("stat_E54C7B357A5A826C");
        attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5A3B180273BE47B1");
        thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, _id_61B5D0250B328F00, "defending");
        attacker scripts\mp\utility\stats::incpersstat("assaults", 1);
      } else if(_id_C3F9FED5999C974E) {
        attacker thread scripts\mp\rank::scoreeventpopup("stat_6FF0E80C570DACA1");
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
  updatematchstatushintonhasflag();
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

removeflag() {
  level endon("game_ended");

  for(;;) {
    if(getDvar("scr_devremovedomflag", "") != "") {
      _id_3A8F577077353C70 = getDvar("scr_devremovedomflag", "");

      if(_id_3A8F577077353C70 == "_a")
        team = "allies";
      else
        team = "axis";

      if(team == "allies") {
        if(game["switchedsides"])
          team = game["defenders"];
        else
          team = game["attackers"];
      } else if(game["switchedsides"])
        team = game["attackers"];
      else
        team = game["defenders"];

      level.teamflags[team].trigger notify("move_gameobject");
      level.teamflags[team] scripts\mp\gameobjects::allowuse("none");
      level.teamflags[team].trigger = undefined;
      level.teamflags[team] notify("deleted");
      level.teamflags[team].visuals[0] delete();
      level.teamflagbases[team] delete();
      level.capzones[team] scripts\mp\gameobjects::allowuse("none");
      level.capzones[team].trigger = undefined;
      level.capzones[team] notify("deleted");

      foreach(player in level.players)
      player player_delete_flag_goal_fx(team);

      level.teamflags[team].visibleteam = "none";
      level.teamflags[team] scripts\mp\gameobjects::setobjectivestatusicons(undefined, undefined);
      level.capzones[team].visibleteam = "none";
      level.capzones[team] scripts\mp\gameobjects::setobjectivestatusicons(undefined, undefined);
      level.teamflags[team] = undefined;
      setdynamicdvar("scr_devremovedomflag", "");
    }

    wait 1;
  }
}

placeflag() {
  level endon("game_ended");

  for(;;) {
    if(getDvar("scr_devplacedomflag", "") != "") {
      _id_3A8F577077353C70 = getDvar("scr_devplacedomflag", "");

      if(_id_3A8F577077353C70 == "_a")
        team = "allies";
      else
        team = "axis";

      if(team == "allies") {
        if(game["switchedsides"])
          team = game["defenders"];
        else
          team = game["attackers"];
      } else if(game["switchedsides"])
        team = game["attackers"];
      else
        team = game["defenders"];

      goal = undefined;
      goal = spawnStruct();
      goal dev_flag_find_ground();
      goal.origin = goal.ground_origin;
      goal.radius = 30;
      goal.team = team;
      trigger = spawn("trigger_radius", goal.origin, 0, 30, 80);
      visuals[0] = spawn("script_model", goal.origin);
      visuals[0] setModel(level.flagmodel[team]);
      _id_062E400453977EEE = scripts\mp\gameobjects::createcarryobject(team, trigger, visuals, (0, 0, 85));
      _id_062E400453977EEE scripts\mp\gameobjects::setteamusetext("enemy", &"MP/GRABBING_FLAG");
      _id_062E400453977EEE scripts\mp\gameobjects::setteamusetext("friendly", &"MP/RETURNING_FLAG");
      _id_062E400453977EEE scripts\mp\gameobjects::allowcarry("enemy");
      _id_062E400453977EEE scripts\mp\gameobjects::setvisibleteam("none");
      _id_062E400453977EEE scripts\mp\gameobjects::setobjectivestatusallicons(level.iconescort, level.iconkill, level.mlgiconfullflag);
      _id_062E400453977EEE.objidpingfriendly = 1;
      _id_062E400453977EEE.allowweapons = 1;
      _id_062E400453977EEE.onpickup = ::onpickup;
      _id_062E400453977EEE.onpickupfailed = ::onpickupfailed;
      _id_062E400453977EEE.ondrop = ::ondrop;
      _id_062E400453977EEE.onreset = ::onreset;
      _id_062E400453977EEE.oldradius = trigger.radius;
      _id_062E400453977EEE.origin = goal.origin;
      _id_062E400453977EEE.label = team;
      _id_062E400453977EEE.previouscarrier = undefined;
      tracestart = trigger.origin + (0, 0, 32);
      _id_8B39E5984DA1FFAF = trigger.origin + (0, 0, -32);
      contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
      ignoreents = [];
      trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, contentoverride);
      _id_062E400453977EEE.baseeffectpos = trace["position"];
      upangles = vectortoangles(trace["normal"]);
      _id_062E400453977EEE.baseeffectforward = anglesToForward(upangles);
      level.teamflagbases[team] = createteamflagbase(team, _id_062E400453977EEE);

      if(team == "allies") {
        if(game["switchedsides"])
          level.teamflags[game["defenders"]] = _id_062E400453977EEE;
        else
          level.teamflags[game["attackers"]] = _id_062E400453977EEE;
      } else if(game["switchedsides"])
        level.teamflags[game["attackers"]] = _id_062E400453977EEE;
      else
        level.teamflags[game["defenders"]] = _id_062E400453977EEE;

      visuals = [];
      trigger = spawn("trigger_radius", goal.origin - (0, 0, goal.radius / 2), 0, goal.radius, 80);
      trigger.no_moving_platfrom_unlink = 1;
      trigger.linktoenabledflag = 1;
      trigger.baseorigin = trigger.origin;
      _id_E1C2BB288FC23E0D = scripts\mp\gameobjects::createuseobject(team, trigger, visuals, (0, 0, 115));
      _id_E1C2BB288FC23E0D scripts\mp\gameobjects::allowuse("friendly");
      _id_E1C2BB288FC23E0D scripts\mp\gameobjects::setvisibleteam("any");
      _id_E1C2BB288FC23E0D scripts\mp\gameobjects::setobjectivestatusallicons(level.icondefendflag, level.iconcaptureflag, level.mlgiconfullflag);
      _id_E1C2BB288FC23E0D scripts\mp\gameobjects::setusetime(0);
      _id_E1C2BB288FC23E0D scripts\mp\gameobjects::setkeyobject(level.teamflags[scripts\mp\utility\game::getotherteam(team)[0]]);
      level.capzones[scripts\mp\utility\game::getotherteam(team)[0]] scripts\mp\gameobjects::setkeyobject(_id_062E400453977EEE);
      _id_E1C2BB288FC23E0D.onuse = ::onuse;
      _id_E1C2BB288FC23E0D.oncantuse = ::oncantuse;
      tracestart = trigger.origin + (0, 0, 32);
      _id_8B39E5984DA1FFAF = trigger.origin + (0, 0, -32);
      contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
      ignoreents = [];
      trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, contentoverride);
      upangles = vectortoangles(trace["normal"]);
      forward = anglesToForward(upangles);
      right = anglestoright(upangles);

      if(team == "allies") {
        if(game["switchedsides"])
          level.capzones[game["defenders"]] = _id_E1C2BB288FC23E0D;
        else
          level.capzones[game["attackers"]] = _id_E1C2BB288FC23E0D;
      } else if(game["switchedsides"])
        level.capzones[game["attackers"]] = _id_E1C2BB288FC23E0D;
      else
        level.capzones[game["defenders"]] = _id_E1C2BB288FC23E0D;

      setdynamicdvar("scr_devplacedomflag", "");
    }

    wait 1;
  }
}

dev_flag_find_ground() {
  tracestart = level.players[0].origin + (0, 0, 32);
  _id_8B39E5984DA1FFAF = level.players[0].origin + (0, 0, -1000);
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  ignoreents = [];
  trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, contentoverride);
  self.ground_origin = trace["position"];
  return trace["fraction"] != 0 && trace["fraction"] != 1;
}

setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_ctf_kill", 2, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_recover_flag", 2, "friendly", "MP_INGAME_ONLY/OBJ_RECOVER_CAPS", "icon_waypoint_flag", 0, 12);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_flag", 2, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_flag", 0, 12);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_take_flag", 2, "enemy", "MP_INGAME_ONLY/OBJ_TAKE_CAPS", "icon_waypoint_flag", 0, 13);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_flag", 2, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0, 13);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_mlg_empty_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_empty", 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_mlg_full_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_full", 0, undefined);
}

updatematchstatushintonnoflag() {
  scripts\mp\hud_message::_id_F004EF4606B9EFDC("flag_capture");
}

updatematchstatushintonhasflag() {
  scripts\mp\hud_message::_id_F004EF4606B9EFDC("flag_return");
}

_id_9136C8E96AE14D11() {
  scripts\mp\codcasterclientmatchdata::_id_0EDBA1EE7C2375A5();
}