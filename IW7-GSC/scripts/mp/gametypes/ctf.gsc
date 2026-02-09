/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\ctf.gsc
*********************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility::registertimelimitdvar(level.gametype, 5);
    scripts\mp\utility::registerscorelimitdvar(level.gametype, 3);
    scripts\mp\utility::registerroundlimitdvar(level.gametype, 2);
    scripts\mp\utility::registerwinlimitdvar(level.gametype, 1);
    scripts\mp\utility::registernumlivesdvar(level.gametype, 0);
    scripts\mp\utility::registerhalftimedvar(level.gametype, 0);
    scripts\mp\utility::registerroundswitchdvar(level.gametype, 1, 0, 1);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
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
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.onspawnplayer = ::onspawnplayer;
  level.spawnnodetype = "mp_ctf_spawn";
  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["gametype"] = "captureflag";
  if(getdvarint("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("camera_thirdPerson")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_diehard")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_" + level.gametype + "_promode")) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["dialog"]["offense_obj"] = "capture_obj";
  game["dialog"]["defense_obj"] = "capture_obj";
  setomnvar("ui_ctf_flag_axis", -2);
  setomnvar("ui_ctf_flag_allies", -2);
  thread onplayerconnect();
}

initializematchrules() {
  scripts\mp\utility::setcommonrulesfrommatchdata();
  setdynamicdvar("scr_ctf_winRule", getmatchrulesdata("ctfData", "winRule"));
  setdynamicdvar("scr_ctf_showEnemyCarrier", getmatchrulesdata("ctfData", "showEnemyCarrier"));
  setdynamicdvar("scr_ctf_idleResetTime", getmatchrulesdata("ctfData", "idleResetTime"));
  setdynamicdvar("scr_ctf_captureCondition", getmatchrulesdata("ctfData", "captureCondition"));
  setdynamicdvar("scr_ctf_pickupTime", getmatchrulesdata("ctfData", "pickupTime"));
  setdynamicdvar("scr_ctf_returnTime", getmatchrulesdata("ctfData", "returnTime"));
  setdynamicdvar("scr_ctf_halftime", 0);
  scripts\mp\utility::registerhalftimedvar("ctf", 0);
  setdynamicdvar("scr_ctf_promode", 0);
}

onspawnplayer() {}

onstartgametype() {
  var_0 = scripts\mp\utility::inovertime();
  var_1 = game["overtimeRoundsPlayed"] == 0;
  var_2 = scripts\mp\utility::istimetobeatvalid();
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

  if(scripts\mp\utility::inovertime()) {
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
    scripts\mp\utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER");
    scripts\mp\utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER");
  } else {
    scripts\mp\utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER_SCORE");
    scripts\mp\utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER_SCORE");
  }

  scripts\mp\utility::setobjectivetext(game["attackers"], &"OBJECTIVES_CTF");
  scripts\mp\utility::setobjectivetext(game["defenders"], &"OBJECTIVES_CTF");
  scripts\mp\utility::setobjectivehinttext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER_HINT");
  scripts\mp\utility::setobjectivehinttext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER_HINT");
  flag_default_origins();
  var_5[0] = "ctf";
  scripts\mp\gameobjects::main(var_5);
  flag_setupvfx();
  createflagsandhud();
  initspawns();
  thread removeflag();
  thread placeflag();
}

updategametypedvars() {
  scripts\mp\gametypes\common::updategametypedvars();
  level.winrule = scripts\mp\utility::dvarintvalue("winRule", 0, 0, 1);
  level.showenemycarrier = scripts\mp\utility::dvarintvalue("showEnemyCarrier", 5, 0, 6);
  level.idleresettime = scripts\mp\utility::dvarfloatvalue("idleResetTime", 30, 0, 60);
  level.capturecondition = scripts\mp\utility::dvarintvalue("captureCondition", 0, 0, 1);
  level.pickuptime = scripts\mp\utility::dvarfloatvalue("pickupTime", 0, 0, 10);
  level.returntime = scripts\mp\utility::dvarfloatvalue("returnTime", 0, -1, 25);
}

createflagsandhud() {
  level.flagmodel["allies"] = "ctf_game_flag_unsa_open_wm";
  level.flagbase["allies"] = "ctf_game_flag_unsa_base_wm";
  level.carryflag["allies"] = "ctf_game_flag_unsa_close_wm";
  level.flagmodel["axis"] = "ctf_game_flag_sdf_open_wm";
  level.flagbase["axis"] = "ctf_game_flag_sdf_base_wm";
  level.carryflag["axis"] = "ctf_game_flag_sdf_close_wm";
  level.closecapturekiller = [];
  level.closecapturekiller["allies"] = undefined;
  level.closecapturekiller["axis"] = undefined;
  level.iconescort3d = "waypoint_escort";
  level.iconescort2d = "waypoint_escort";
  level.iconkill3d = "waypoint_capture_kill";
  level.iconkill2d = "waypoint_capture_kill";
  level.iconcaptureflag3d = "waypoint_capture_take";
  level.iconcaptureflag2d = "waypoint_capture_take";
  level.icondefendflag3d = "waypoint_blitz_defend";
  level.icondefendflag2d = "waypoint_blitz_defend";
  level.iconreturnflag3d = "waypoint_capture_recover";
  level.iconreturnflag2d = "waypoint_capture_recover";
  level.teamflags[game["defenders"]] = createteamflag(game["defenders"], "axis");
  level.teamflags[game["attackers"]] = createteamflag(game["attackers"], "allies");
  level.capzones[game["defenders"]] = createcapzone(game["defenders"], "axis");
  level.capzones[game["attackers"]] = createcapzone(game["attackers"], "allies");
}

flag_setupvfx() {
  level.flagbaseglowfxid["friendly"] = loadfx("vfx\iw7\core\mp\vfx_ctf_base_glow_fr.vfx");
  level.flagbaseglowfxid["enemy"] = loadfx("vfx\iw7\core\mp\vfx_ctf_base_glow_en.vfx");
  level.flagradiusfxid["friendly"] = loadfx("vfx\core\mp\core\vfx_marker_flag_cyan.vfx");
  level.flagradiusfxid["enemy"] = loadfx("vfx\core\mp\core\vfx_marker_flag_orng.vfx");
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("AwayFromEnemies");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_ctf_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_ctf_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_ctf_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_ctf_spawn");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  assignteamspawns();
}

assignteamspawns() {
  var_0 = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype);
  var_1 = scripts\mp\spawnlogic::ispathdataavailable();
  level.teamspawnpoints["axis"] = [];
  level.teamspawnpoints["allies"] = [];
  level.teamspawnpoints["neutral"] = [];
  if(level.teamflags.size == 2) {
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

      var_10 = max(var_14, var_15);
      var_11 = min(var_14, var_15);
      var_12 = var_11 / var_10;
      if(var_12 > 0.5) {
        level.teamspawnpoints["neutral"][level.teamspawnpoints["neutral"].size] = var_9;
      }
    }

    return;
  }

  foreach(var_9 in var_1) {
    var_9.teambase = getnearestflagteam(var_9);
    if(var_9.teambase == "axis") {
      level.teamspawnpoints["axis"][level.teamspawnpoints["axis"].size] = var_9;
      continue;
    }

    level.teamspawnpoints["allies"][level.teamspawnpoints["allies"].size] = var_9;
  }
}

getnearestflagteam(var_0) {
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

getspawnpoint() {
  var_0 = self.pers["team"];
  var_1 = scripts\mp\utility::getotherteam(var_0);
  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(game["switchedsides"]) {
      var_2 = scripts\mp\spawnlogic::getspawnpointarray("mp_ctf_spawn_" + var_1 + "_start");
      var_3 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_2);
    } else {
      var_2 = scripts\mp\spawnlogic::getspawnpointarray("mp_ctf_spawn_" + var_2 + "_start");
      var_3 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_3);
    }
  } else {
    var_4 = level.teamspawnpoints["neutral"].size > 0;
    var_2 = scripts\mp\spawnlogic::getteamspawnpoints(var_0);
    var_3 = scripts\mp\spawnscoring::getspawnpoint(var_2, undefined, undefined, var_4);
    if(!isDefined(var_3) && var_4) {
      var_2 = scripts\mp\spawnlogic::getteamspawnpoints("neutral");
      var_3 = scripts\mp\spawnscoring::getspawnpoint(var_2);
    }
  }

  return var_3;
}

flag_default_origins() {
  level.default_goal_origins = [];
  level.magicbullet = getEntArray("flag_primary", "targetname");
  foreach(var_1 in level.magicbullet) {
    switch (var_1.script_label) {
      case "_a":
        level.default_flag_origins[game["attackers"]] = var_1.origin;
        break;

      case "_b":
        level.default_ball_origin = var_1.origin;
        break;

      case "_c":
        level.default_flag_origins[game["defenders"]] = var_1.origin;
        break;
    }
  }
}

flag_create_team_goal(var_0) {
  var_1 = 0;
  var_2 = undefined;
  if(isDefined(var_2)) {
    var_2 flag_find_ground();
    var_2.origin = var_2.ground_origin;
  } else {
    var_2 = spawnStruct();
    switch (level.script) {
      default:
        break;
    }

    if(!isDefined(var_2.origin)) {
      var_2.origin = level.default_flag_origins[var_0];
    }

    var_2 flag_find_ground();
    var_2.origin = var_2.ground_origin;
  }

  var_2.fgetarg = 30;
  var_2.team = var_0;
  var_2.ball_in_goal = 0;
  var_2.highestspawndistratio = 0;
  return var_2;
}

flag_find_ground(var_0) {
  var_1 = self.origin + (0, 0, 32);
  var_2 = self.origin + (0, 0, -1000);
  var_3 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_4 = [];
  var_5 = scripts\common\trace::ray_trace(var_1, var_2, var_4, var_3);
  self.ground_origin = var_5["position"];
  return var_5["fraction"] != 0 && var_5["fraction"] != 1;
}

showflagradiuseffecttoplayers(var_0, var_1, var_2) {
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

  var_1._flagradiuseffect[var_0] = var_6;
  triggerfx(var_6);
}

showbaseeffecttoplayer(var_0, var_1) {
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

  var_1._flageffect[var_0] = var_5;
  triggerfx(var_5);
}

removeflagpickupradiuseffect(var_0) {
  if(var_0 == self.team) {
    if(isDefined(self._flagradiuseffect[self.team])) {
      self._flagradiuseffect[self.team] delete();
      return;
    }

    return;
  }

  if(isDefined(self._flagradiuseffect[level.otherteam[self.team]])) {
    self._flagradiuseffect[level.otherteam[self.team]] delete();
  }
}

setteaminhuddatafromteamname(var_0) {
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

player_delete_flag_goal_fx(var_0) {
  if(var_0 == self.team) {
    if(isDefined(self._flageffect[self.team])) {
      self._flageffect[self.team] delete();
      return;
    }

    return;
  }

  if(isDefined(self._flageffect[level.otherteam[self.team]])) {
    self._flageffect[level.otherteam[self.team]] delete();
  }
}

getflagpos(var_0) {
  var_1 = getent("ctf_flag_" + var_0, "targetname");
  return var_1.origin;
}

createteamflag(var_0, var_1) {
  var_2 = 0;
  var_3 = getent("ctf_zone_" + var_1, "targetname");
  if(!isDefined(var_3)) {
    var_4 = flag_create_team_goal(var_0);
    var_3 = spawn("trigger_radius", var_4.origin - (0, 0, var_4.fgetarg / 2), 0, var_4.fgetarg, 80);
    var_3.no_moving_platfrom_unlink = 1;
    var_3.linktoenabledflag = 1;
    var_3.baseorigin = var_3.origin;
    var_2 = 1;
    var_5[0] = spawn("script_model", var_4.origin);
    var_5[0] setasgametypeobjective();
    var_5[0] setteaminhuddatafromteamname(var_1);
  } else {
    var_5[0] = getent("ctf_flag_" + var_2, "targetname");
  }

  if(!isDefined(var_5[0])) {}

  if(!var_2) {
    var_6 = 15;
    if(level.pickuptime > 0 || level.returntime > 0) {
      var_6 = var_6 * 2;
    }

    var_7 = spawn("trigger_radius", var_3.origin, 0, var_6, var_3.height);
    var_3 = var_7;
  }

  var_5[0] setModel(level.flagmodel[var_0]);
  var_5[0] setasgametypeobjective();
  var_5[0] setteaminhuddatafromteamname(var_1);
  var_8 = scripts\mp\gameobjects::createcarryobject(var_0, var_3, var_5, (0, 0, 85));
  var_8 scripts\mp\gameobjects::setteamusetext("enemy", &"MP_GRABBING_FLAG");
  var_8 scripts\mp\gameobjects::setteamusetext("friendly", &"MP_RETURNING_FLAG");
  var_8 scripts\mp\gameobjects::allowcarry("enemy");
  var_8 scripts\mp\gameobjects::setteamusetime("enemy", level.pickuptime);
  var_8 scripts\mp\gameobjects::setteamusetime("friendly", level.returntime);
  var_8 scripts\mp\gameobjects::setvisibleteam("none");
  var_8 scripts\mp\gameobjects::set2dicon("friendly", level.iconkill2d);
  var_8 scripts\mp\gameobjects::set3dicon("friendly", level.iconkill3d);
  var_8 scripts\mp\gameobjects::set2dicon("enemy", level.iconescort2d);
  var_8 scripts\mp\gameobjects::set3dicon("enemy", level.iconescort3d);
  var_8.allowweapons = 1;
  var_8.onpickup = ::onpickup;
  var_8.onpickupfailed = ::onpickup;
  var_8.ondrop = ::ondrop;
  var_8.onreset = ::onreset;
  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        var_8.objidpingenemy = 1;
        var_8.objidpingfriendly = 0;
        var_8.objpingdelay = 60;
        break;

      case 1:
        var_8.objidpingenemy = 0;
        var_8.objidpingfriendly = 0;
        var_8.objpingdelay = 0.05;
        break;

      case 2:
        var_8.objidpingenemy = 1;
        var_8.objidpingfriendly = 0;
        var_8.objpingdelay = 1;
        break;

      case 3:
        var_8.objidpingenemy = 1;
        var_8.objidpingfriendly = 0;
        var_8.objpingdelay = 1.5;
        break;

      case 4:
        var_8.objidpingenemy = 1;
        var_8.objidpingfriendly = 0;
        var_8.objpingdelay = 2;
        break;

      case 5:
        var_8.objidpingenemy = 1;
        var_8.objidpingfriendly = 0;
        var_8.objpingdelay = 3;
        break;

      case 6:
        var_8.objidpingenemy = 1;
        var_8.objidpingfriendly = 0;
        var_8.objpingdelay = 4;
        break;
    }
  } else {
    var_8.objidpingenemy = 1;
    var_8.objidpingfriendly = 0;
    var_8.objpingdelay = 3;
  }

  var_8.oldradius = var_3.fgetarg;
  var_9 = var_3.origin + (0, 0, 32);
  var_10 = var_3.origin + (0, 0, -32);
  var_11 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_12 = [];
  var_13 = scripts\common\trace::ray_trace(var_9, var_10, var_12, var_11);
  var_8.baseeffectpos = var_8.visuals[0].origin;
  var_14 = anglestoup(var_8.visuals[0].angles);
  var_8.baseeffectforward = anglesToForward(var_14);
  level.teamflagbases[var_0] = createteamflagbase(var_0, var_8);
  return var_8;
}

createteamflagbase(var_0, var_1) {
  var_2 = var_1.visuals[0].origin;
  var_3 = spawn("script_model", var_2);
  var_3 setModel(level.flagbase[var_0]);
  var_3.ownerteam = var_0;
  var_3 setasgametypeobjective();
  var_3 setteaminhuddatafromteamname(var_0);
  var_3.baseeffectpos = var_2;
  var_4 = anglestoup(var_1.visuals[0].angles);
  var_3.baseeffectforward = anglesToForward(var_4);
  foreach(var_6 in level.players) {
    var_3 showbaseeffecttoplayer(var_0, var_6);
  }

  return var_3;
}

createcapzone(var_0, var_1) {
  var_2 = flag_create_team_goal(var_0);
  var_3 = getent("ctf_zone_" + var_1, "targetname");
  if(!isDefined(var_3)) {
    var_3 = spawn("trigger_radius", var_2.origin - (0, 0, var_2.fgetarg / 2), 0, var_2.fgetarg, 80);
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
  var_6 scripts\mp\gameobjects::set2dicon("friendly", level.icondefendflag2d);
  var_6 scripts\mp\gameobjects::set3dicon("friendly", level.icondefendflag3d);
  var_6 scripts\mp\gameobjects::set2dicon("enemy", level.iconcaptureflag2d);
  var_6 scripts\mp\gameobjects::set3dicon("enemy", level.iconcaptureflag3d);
  var_6 scripts\mp\gameobjects::setusetime(0);
  var_6 scripts\mp\gameobjects::setkeyobject(level.teamflags[scripts\mp\utility::getotherteam(var_0)]);
  var_6.onuse = ::onuse;
  var_6.oncantuse = ::oncantuse;
  var_7 = var_3.origin + (0, 0, 32);
  var_8 = var_3.origin + (0, 0, -32);
  var_9 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_10 = [];
  var_11 = scripts\common\trace::ray_trace(var_7, var_8, var_10, var_9);
  var_12 = vectortoangles(var_11["normal"]);
  var_13 = anglesToForward(var_12);
  var_14 = anglestoright(var_12);
  return var_6;
}

onbeginuse(var_0) {
  var_1 = var_0.pers["team"];
  if(var_1 == scripts\mp\gameobjects::getownerteam()) {
    self.trigger.fgetarg = 1024;
    return;
  }

  self.trigger.fgetarg = self.oldradius;
}

onenduse(var_0, var_1, var_2) {
  self.trigger.fgetarg = self.oldradius;
}

onpickup(var_0) {
  self notify("picked_up");
  var_0 notify("obj_picked_up");
  var_1 = var_0.pers["team"];
  if(var_1 == "allies") {
    var_2 = "axis";
  } else {
    var_2 = "allies";
  }

  if(var_1 == scripts\mp\gameobjects::getownerteam()) {
    if(isDefined(level.closecapturekiller[var_0.team]) && level.closecapturekiller[var_0.team] == var_0) {
      var_0 thread scripts\mp\awards::givemidmatchaward("mode_ctf_nope");
    }

    scripts\mp\utility::setmlgannouncement(11, var_0.team, var_0 getentitynumber());
    level.closecapturekiller[var_0.team] = undefined;
    var_0 thread scripts\mp\utility::giveunifiedpoints("flag_return");
    thread returnflag();
    var_0 thread scripts\mp\matchdata::loggameevent("obj_return", var_0.origin);
    scripts\mp\utility::printandsoundoneveryone(var_1, scripts\mp\utility::getotherteam(var_1), &"MP_FLAG_RETURNED", &"MP_ENEMY_FLAG_RETURNED", "mp_obj_returned", "mp_obj_returned", var_0);
    scripts\mp\utility::leaderdialog("enemy_flag_returned", var_2, "status");
    scripts\mp\utility::leaderdialog("flag_returned", var_1, "status");
    var_0 scripts\mp\utility::incperstat("returns", 1);
    var_0 scripts\mp\persistence::statsetchild("round", "returns", var_0.pers["returns"]);
    if(isPlayer(var_0)) {
      var_0 scripts\mp\utility::setextrascore1(var_0.pers["returns"]);
    }

    if(var_1 == "allies") {
      setomnvar("ui_ctf_flag_allies", -2);
      return;
    }

    setomnvar("ui_ctf_flag_axis", -2);
    return;
  }

  if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[var_1])) {
    var_0 thread applyflagcarrierclass();
  } else {
    var_0 attachflag();
  }

  scripts\mp\utility::setmlgannouncement(8, var_0.team, var_0 getentitynumber());
  level.closecapturekiller[var_2] = undefined;
  if(var_0.team == "allies") {
    setomnvar("ui_ctf_flag_axis", var_0 getentitynumber());
  } else {
    setomnvar("ui_ctf_flag_allies", var_0 getentitynumber());
  }

  var_0 setclientomnvar("ui_ctf_flag_carrier", 1);
  if(isDefined(level.showenemycarrier)) {
    if(level.showenemycarrier == 0) {
      scripts\mp\gameobjects::setvisibleteam("enemy");
    } else {
      scripts\mp\gameobjects::setvisibleteam("any");
    }
  }

  scripts\mp\gameobjects::set2dicon("friendly", level.iconkill2d);
  scripts\mp\gameobjects::set3dicon("friendly", level.iconkill3d);
  scripts\mp\gameobjects::set2dicon("enemy", level.iconescort2d);
  scripts\mp\gameobjects::set3dicon("enemy", level.iconescort3d);
  if(level.capturecondition == 0) {
    level.capzones[var_2] scripts\mp\gameobjects::allowuse("none");
  }

  level.capzones[var_2] scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\utility::printandsoundoneveryone(var_1, var_2, &"MP_ENEMY_FLAG_TAKEN_BY", &"MP_FLAG_TAKEN_BY", "mp_obj_taken", "mp_enemy_obj_taken", var_0);
  scripts\mp\utility::leaderdialog("enemy_flag_taken", var_1);
  scripts\mp\utility::leaderdialog("flag_getback", var_2);
  thread scripts\mp\utility::teamplayercardsplash("callout_flagpickup", var_0);
  if(!isDefined(self.previouscarrier) || self.previouscarrier != var_0) {
    var_0 thread scripts\mp\utility::giveunifiedpoints("flag_grab");
  }

  var_0 thread scripts\mp\matchdata::loggameevent("pickup", var_0.origin);
  self.previouscarrier = var_0;
  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    var_0 setgametypevip(1);
  }

  var_0 thread superabilitywatcher();
}

returnflag() {
  scripts\mp\utility::setmlgannouncement(11, scripts\mp\gameobjects::getownerteam());
  scripts\mp\gameobjects::returnobjectiveid();
}

ondrop(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = level.otherteam[var_1];
  scripts\mp\gameobjects::allowcarry("any");
  scripts\mp\gameobjects::setvisibleteam("any");
  if(level.returntime >= 0) {
    scripts\mp\gameobjects::set2dicon("friendly", level.iconreturnflag2d);
    scripts\mp\gameobjects::set3dicon("friendly", level.iconreturnflag3d);
  } else {
    scripts\mp\gameobjects::set2dicon("friendly", level.icondefendflag2d);
    scripts\mp\gameobjects::set3dicon("friendly", level.icondefendflag3d);
  }

  scripts\mp\gameobjects::set2dicon("enemy", level.iconcaptureflag2d);
  scripts\mp\gameobjects::set3dicon("enemy", level.iconcaptureflag3d);
  if(var_1 == "allies") {
    setomnvar("ui_ctf_flag_allies", -1);
  } else {
    setomnvar("ui_ctf_flag_axis", -1);
  }

  if(isDefined(var_0)) {
    var_0 setclientomnvar("ui_ctf_flag_carrier", 0);
  }

  var_3 = self.visuals[0] gettagorigin("tag_origin");
  level.capzones[var_2].trigger scripts\mp\entityheadicons::setheadicon("none", "", (0, 0, 0));
  if(isDefined(var_0)) {
    if(!scripts\mp\utility::isreallyalive(var_0)) {
      var_0.carryobject.previouscarrier = undefined;
    }

    if(isDefined(var_0.carryflag)) {
      var_0 detachflag();
    }

    scripts\mp\utility::printandsoundoneveryone(var_2, "none", &"MP_ENEMY_FLAG_DROPPED_BY", "", "mp_war_objective_lost", "", var_0);
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      var_0 setgametypevip(0);
    }
  } else {
    scripts\mp\utility::playsoundonplayers("mp_war_objective_lost", var_2);
  }

  scripts\mp\utility::leaderdialog("enemy_flag_dropped", var_2, "status");
  scripts\mp\utility::leaderdialog("flag_dropped", var_1, "status");
  if(level.idleresettime > 0) {
    thread returnaftertime();
  }
}

returnaftertime() {
  self endon("picked_up");
  var_0 = 0;
  while(var_0 < level.idleresettime) {
    wait(0.05);
    if(self.claimteam == "none") {
      var_0 = var_0 + 0.05;
    }
  }

  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = level.otherteam[var_1];
  scripts\mp\utility::playsoundonplayers("mp_war_objective_taken", var_1);
  scripts\mp\utility::playsoundonplayers("mp_war_objective_lost", var_2);
  scripts\mp\utility::setmlgannouncement(11, scripts\mp\gameobjects::getownerteam());
  scripts\mp\gameobjects::returnobjectiveid();
}

onreset() {
  var_0 = scripts\mp\gameobjects::getownerteam();
  var_1 = level.otherteam[var_0];
  scripts\mp\gameobjects::allowcarry("enemy");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::set2dicon("friendly", level.iconkill2d);
  scripts\mp\gameobjects::set3dicon("friendly", level.iconkill3d);
  scripts\mp\gameobjects::set2dicon("enemy", level.iconescort2d);
  scripts\mp\gameobjects::set3dicon("enemy", level.iconescort3d);
  if(var_0 == "allies") {
    setomnvar("ui_ctf_flag_allies", -2);
  } else {
    setomnvar("ui_ctf_flag_axis", -2);
  }

  level.capzones[var_0] scripts\mp\gameobjects::allowuse("friendly");
  level.capzones[var_0] scripts\mp\gameobjects::setvisibleteam("any");
  level.capzones[var_0] scripts\mp\gameobjects::set2dicon("friendly", level.icondefendflag2d);
  level.capzones[var_0] scripts\mp\gameobjects::set3dicon("friendly", level.icondefendflag3d);
  level.capzones[var_0] scripts\mp\gameobjects::set2dicon("enemy", level.iconcaptureflag2d);
  level.capzones[var_0] scripts\mp\gameobjects::set3dicon("enemy", level.iconcaptureflag3d);
  level.capzones[var_0].trigger scripts\mp\entityheadicons::setheadicon("none", "", (0, 0, 0));
  self.previouscarrier = undefined;
}

onuse(var_0) {
  if(!level.gameended) {
    var_1 = var_0.pers["team"];
    if(var_1 == "allies") {
      var_2 = "axis";
    } else {
      var_2 = "allies";
    }

    var_0 setclientomnvar("ui_ctf_flag_carrier", 0);
    scripts\mp\utility::leaderdialog("enemy_flag_captured", var_1, "status");
    scripts\mp\utility::leaderdialog("flag_captured", var_2, "status");
    thread scripts\mp\utility::teamplayercardsplash("callout_flagcapture", var_0);
    var_0 thread scripts\mp\awards::givemidmatchaward("mode_ctf_cap");
    var_0 notify("objective", "captured");
    var_0 thread scripts\mp\matchdata::loggameevent("capture", var_0.origin);
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      var_0 setgametypevip(0);
    }

    var_0 scripts\mp\utility::incperstat("captures", 1);
    var_0 scripts\mp\persistence::statsetchild("round", "captures", var_0.pers["captures"]);
    if(isPlayer(var_0)) {
      var_0 scripts\mp\utility::setextrascore0(var_0.pers["captures"]);
    }

    scripts\mp\utility::printandsoundoneveryone(var_1, var_2, &"MP_ENEMY_FLAG_CAPTURED_BY", &"MP_FRIENDLY_FLAG_CAPTURED_BY", "mp_obj_captured", "mp_enemy_obj_captured", var_0);
    if(isDefined(var_0.carryflag)) {
      var_0 detachflag();
    }

    if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[var_1])) {
      var_0 thread removeflagcarrierclass();
    }

    level.closecapturekiller[var_1] = undefined;
    level.closecapturekiller[var_2] = undefined;
    level.teamflags[var_2] returnflag();
    scripts\mp\utility::setmlgannouncement(9, var_1, var_0 getentitynumber());
    level scripts\mp\gamescore::giveteamscoreforobjective(var_1, 1, 0);
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0._flageffect = [];
    var_0._flagradiuseffect = [];
    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned");
    self setclientomnvar("ui_ctf_flag_carrier", 0);
    scripts\mp\utility::setextrascore0(0);
    if(isDefined(self.pers["captures"])) {
      scripts\mp\utility::setextrascore0(self.pers["captures"]);
    }

    scripts\mp\utility::setextrascore1(0);
    if(isDefined(self.pers["returns"])) {
      scripts\mp\utility::setextrascore1(self.pers["returns"]);
    }

    if(isDefined(self.team)) {
      foreach(var_1 in level.teamflagbases) {
        if(isDefined(var_1)) {
          var_1 showbaseeffecttoplayer(var_1.ownerteam, self);
        }
      }
    }
  }
}

applyflagcarrierclass() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    wait(0.05);
  }

  while(self ismantling()) {
    wait(0.05);
  }

  while(!self isonground()) {
    wait(0.05);
  }

  if(scripts\mp\utility::isjuggernaut()) {
    self notify("lost_juggernaut");
    wait(0.05);
  }

  self.pers["gamemodeLoadout"] = level.ctf_loadouts[self.team];
  if(isDefined(self.setspawnpoint)) {
    scripts\mp\perks\perkfunctions::deleteti(self.setspawnpoint);
  }

  var_0 = spawn("script_model", self.origin);
  var_0.angles = self.angles;
  var_0.playerspawnpos = self.origin;
  var_0.notti = 1;
  self.setspawnpoint = var_0;
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

superabilitywatcher() {
  self notify("superWatcher");
  self endon("superWatcher");
  self endon("death");
  self endon("disconnect");
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
      case "super_phaseshift":
        var_2 thread scripts\mp\gameobjects::setdropped();
        break;

      case "super_teleport":
      case "super_rewind":
        scripts\engine\utility::waittill_any("teleport_success", "rewind_success");
        var_2.ftldrop = 1;
        var_2 thread scripts\mp\gameobjects::setdropped();
        break;
    }
  }
}

waitattachflag() {
  level endon("game_ende");
  self endon("disconnect");
  self endon("death");
  self waittill("spawned_player");
  attachflag();
}

removeflagcarrierclass() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    wait(0.05);
  }

  while(self ismantling()) {
    wait(0.05);
  }

  while(!self isonground()) {
    wait(0.05);
  }

  if(scripts\mp\utility::isjuggernaut()) {
    self notify("lost_juggernaut");
    wait(0.05);
  }

  self.pers["gamemodeLoadout"] = undefined;
  if(isDefined(self.setspawnpoint)) {
    scripts\mp\perks\perkfunctions::deleteti(self.setspawnpoint);
  }

  var_0 = spawn("script_model", self.origin);
  var_0.angles = self.angles;
  var_0.playerspawnpos = self.origin;
  var_0.notti = 1;
  self.setspawnpoint = var_0;
  self notify("faux_spawn");
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

oncantuse(var_0) {}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
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
      scripts\mp\utility::setmlgannouncement(10, var_1.team, var_1 getentitynumber());
      var_1 scripts\mp\utility::incperstat("defends", 1);
      var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
      thread scripts\mp\matchdata::loginitialstats(var_9, "carrying");
      var_10 = 1;
    }

    if(!var_10) {
      var_14 = 0;
      var_15 = 0;
      foreach(var_11 in level.teamflags) {
        var_12 = distsquaredcheck(var_11, self.origin, var_11.curorigin);
        if(var_12) {
          if(var_11.ownerteam == self.team) {
            var_14 = 1;
            continue;
          }

          var_15 = 1;
        }
      }

      if(var_14) {
        var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
        thread scripts\mp\matchdata::loginitialstats(var_9, "defending");
      } else if(var_15) {
        var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
        var_1 scripts\mp\utility::incperstat("defends", 1);
        var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
        thread scripts\mp\matchdata::loginitialstats(var_9, "assaulting");
      }
    }
  }

  if(isDefined(self.carryflag)) {
    detachflag();
  }
}

distsquaredcheck(var_0, var_1, var_2) {
  var_3 = distancesquared(var_2, var_0);
  var_4 = distancesquared(var_2, var_1);
  if(var_3 < 90000 || var_4 < 90000) {
    return 1;
  }

  return 0;
}

attachflag() {
  var_0 = level.otherteam[self.pers["team"]];
  self attach(level.carryflag[var_0], "J_spine4", 1);
  self.carryflag = level.carryflag[var_0];
}

detachflag() {
  self detach(self.carryflag, "J_spine4");
  self.carryflag = undefined;
}

setspecialloadouts() {
  if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses", "axis", 5, "class", "inUse")) {
    level.ctf_loadouts["axis"] = ::scripts\mp\utility::getmatchrulesspecialclass("axis", 5);
  }

  if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses", "allies", 5, "class", "inUse")) {
    level.ctf_loadouts["allies"] = ::scripts\mp\utility::getmatchrulesspecialclass("allies", 5);
  }
}

removeflag() {
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
        var_3 player_delete_flag_goal_fx(var_1);
      }

      level.teamflags[var_1].visibleteam = "none";
      level.teamflags[var_1] scripts\mp\gameobjects::set2dicon("friendly", undefined);
      level.teamflags[var_1] scripts\mp\gameobjects::set3dicon("friendly", undefined);
      level.teamflags[var_1] scripts\mp\gameobjects::set2dicon("enemy", undefined);
      level.teamflags[var_1] scripts\mp\gameobjects::set3dicon("enemy", undefined);
      level.capzones[var_1].visibleteam = "none";
      level.capzones[var_1] scripts\mp\gameobjects::set2dicon("friendly", undefined);
      level.capzones[var_1] scripts\mp\gameobjects::set3dicon("friendly", undefined);
      level.capzones[var_1] scripts\mp\gameobjects::set2dicon("enemy", undefined);
      level.capzones[var_1] scripts\mp\gameobjects::set3dicon("enemy", undefined);
      level.teamflags[var_1] = undefined;
      setdynamicdvar("scr_devRemoveDomFlag", "");
    }

    wait(1);
  }
}

placeflag() {
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
      var_2 dev_flag_find_ground();
      var_2.origin = var_2.ground_origin;
      var_2.fgetarg = 30;
      var_2.team = var_1;
      var_3 = spawn("trigger_radius", var_2.origin, 0, 30, 80);
      var_4[0] = spawn("script_model", var_2.origin);
      var_4[0] setModel(level.flagmodel[var_1]);
      var_5 = scripts\mp\gameobjects::createcarryobject(var_1, var_3, var_4, (0, 0, 85));
      var_5 scripts\mp\gameobjects::setteamusetext("enemy", &"MP_GRABBING_FLAG");
      var_5 scripts\mp\gameobjects::setteamusetext("friendly", &"MP_RETURNING_FLAG");
      var_5 scripts\mp\gameobjects::allowcarry("enemy");
      var_5 scripts\mp\gameobjects::setvisibleteam("none");
      var_5 scripts\mp\gameobjects::set2dicon("friendly", level.iconkill2d);
      var_5 scripts\mp\gameobjects::set3dicon("friendly", level.iconkill3d);
      var_5 scripts\mp\gameobjects::set2dicon("enemy", level.iconescort2d);
      var_5 scripts\mp\gameobjects::set3dicon("enemy", level.iconescort3d);
      var_5.objidpingenemy = 1;
      var_5.allowweapons = 1;
      var_5.onpickup = ::onpickup;
      var_5.onpickupfailed = ::onpickup;
      var_5.ondrop = ::ondrop;
      var_5.onreset = ::onreset;
      var_5.oldradius = var_3.fgetarg;
      var_5.origin = var_2.origin;
      var_5.label = var_1;
      var_5.previouscarrier = undefined;
      var_6 = var_3.origin + (0, 0, 32);
      var_7 = var_3.origin + (0, 0, -32);
      var_8 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
      var_9 = [];
      var_10 = scripts\common\trace::ray_trace(var_6, var_7, var_9, var_8);
      var_5.baseeffectpos = var_10["position"];
      var_11 = vectortoangles(var_10["normal"]);
      var_5.baseeffectforward = anglesToForward(var_11);
      level.teamflagbases[var_1] = createteamflagbase(var_1, var_5);
      if(var_1 == "allies") {
        if(game["switchedsides"]) {
          level.teamflags[game["defenders"]] = var_5;
        } else {
          level.teamflags[game["attackers"]] = var_5;
        }
      } else if(game["switchedsides"]) {
        level.teamflags[game["attackers"]] = var_5;
      } else {
        level.teamflags[game["defenders"]] = var_5;
      }

      var_4 = [];
      var_3 = spawn("trigger_radius", var_2.origin - (0, 0, var_2.fgetarg / 2), 0, var_2.fgetarg, 80);
      var_3.no_moving_platfrom_unlink = 1;
      var_3.linktoenabledflag = 1;
      var_3.baseorigin = var_3.origin;
      var_12 = scripts\mp\gameobjects::createuseobject(var_1, var_3, var_4, (0, 0, 115));
      var_12 scripts\mp\gameobjects::allowuse("friendly");
      var_12 scripts\mp\gameobjects::setvisibleteam("any");
      var_12 scripts\mp\gameobjects::set2dicon("friendly", level.icondefendflag2d);
      var_12 scripts\mp\gameobjects::set3dicon("friendly", level.icondefendflag3d);
      var_12 scripts\mp\gameobjects::set2dicon("enemy", level.iconcaptureflag2d);
      var_12 scripts\mp\gameobjects::set3dicon("enemy", level.iconcaptureflag3d);
      var_12 scripts\mp\gameobjects::setusetime(0);
      var_12 scripts\mp\gameobjects::setkeyobject(level.teamflags[scripts\mp\utility::getotherteam(var_1)]);
      level.capzones[level.otherteam[var_1]] scripts\mp\gameobjects::setkeyobject(var_5);
      var_12.onuse = ::onuse;
      var_12.oncantuse = ::oncantuse;
      var_6 = var_3.origin + (0, 0, 32);
      var_7 = var_3.origin + (0, 0, -32);
      var_8 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
      var_9 = [];
      var_10 = scripts\common\trace::ray_trace(var_6, var_7, var_9, var_8);
      var_11 = vectortoangles(var_10["normal"]);
      var_13 = anglesToForward(var_11);
      var_14 = anglestoright(var_11);
      if(var_1 == "allies") {
        if(game["switchedsides"]) {
          level.capzones[game["defenders"]] = var_12;
        } else {
          level.capzones[game["attackers"]] = var_12;
        }
      } else if(game["switchedsides"]) {
        level.capzones[game["attackers"]] = var_12;
      } else {
        level.capzones[game["defenders"]] = var_12;
      }

      setdynamicdvar("scr_devPlaceDomFlag", "");
    }

    wait(1);
  }
}

dev_flag_find_ground() {
  var_0 = level.players[0].origin + (0, 0, 32);
  var_1 = level.players[0].origin + (0, 0, -1000);
  var_2 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_3 = [];
  var_4 = scripts\common\trace::ray_trace(var_0, var_1, var_3, var_2);
  self.ground_origin = var_4["position"];
  return var_4["fraction"] != 0 && var_4["fraction"] != 1;
}