/****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gametypes\ctf.gsc
****************************************/

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
    level.modifyplayerdamage = ::scripts\mp\damage::gamemodemodifyplayerdamage;
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
  var_00 = scripts\mp\utility::inovertime();
  var_01 = game["overtimeRoundsPlayed"] == 0;
  var_02 = scripts\mp\utility::istimetobeatvalid();
  if(var_00) {
    if(var_01) {
      setomnvar("ui_round_hint_override_attackers", 1);
      setomnvar("ui_round_hint_override_defenders", 1);
    } else if(var_02) {
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
    setdvar("ui_override_halftime", 0);
  } else if(game["switchedsides"]) {
    setdvar("ui_override_halftime", 2);
  } else {
    setdvar("ui_override_halftime", 1);
  }

  if(!isDefined(game["original_defenders"])) {
    game["original_defenders"] = game["defenders"];
  }

  if(game["switchedsides"]) {
    var_03 = game["attackers"];
    var_04 = game["defenders"];
    game["attackers"] = var_04;
    game["defenders"] = var_03;
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
  var_05[0] = "ctf";
  scripts\mp\gameobjects::main(var_05);
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
  var_00 = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype);
  var_01 = scripts\mp\spawnlogic::ispathdataavailable();
  level.teamspawnpoints["axis"] = [];
  level.teamspawnpoints["allies"] = [];
  level.teamspawnpoints["neutral"] = [];
  if(level.teamflags.size == 2) {
    var_02 = level.teamflags["allies"];
    var_03 = level.teamflags["axis"];
    var_04 = (var_02.curorigin[0], var_02.curorigin[1], 0);
    var_05 = (var_03.curorigin[0], var_03.curorigin[1], 0);
    var_06 = var_05 - var_04;
    var_07 = length2d(var_06);
    foreach(var_09 in var_00) {
      var_0A = (var_09.origin[0], var_09.origin[1], 0);
      var_0B = var_0A - var_04;
      var_0C = vectordot(var_0B, var_06);
      var_0D = var_0C / var_07 * var_07;
      if(var_0D < 0.33) {
        var_09.teambase = var_02.ownerteam;
        level.teamspawnpoints[var_09.teambase][level.teamspawnpoints[var_09.teambase].size] = var_09;
        continue;
      }

      if(var_0D > 0.67) {
        var_09.teambase = var_03.ownerteam;
        level.teamspawnpoints[var_09.teambase][level.teamspawnpoints[var_09.teambase].size] = var_09;
        continue;
      }

      var_0E = undefined;
      var_0F = undefined;
      if(var_01) {
        var_0E = getpathdist(var_09.origin, var_02.curorigin, 999999);
      }

      if(isDefined(var_0E) && var_0E != -1) {
        var_0F = getpathdist(var_09.origin, var_03.curorigin, 999999);
      }

      if(!isDefined(var_0F) || var_0F == -1) {
        var_0E = distance2d(var_02.curorigin, var_09.origin);
        var_0F = distance2d(var_03.curorigin, var_09.origin);
      }

      var_10 = max(var_0E, var_0F);
      var_11 = min(var_0E, var_0F);
      var_12 = var_11 / var_10;
      if(var_12 > 0.5) {
        level.teamspawnpoints["neutral"][level.teamspawnpoints["neutral"].size] = var_09;
      }
    }

    return;
  }

  foreach(var_09 in var_01) {
    var_09.teambase = getnearestflagteam(var_09);
    if(var_09.teambase == "axis") {
      level.teamspawnpoints["axis"][level.teamspawnpoints["axis"].size] = var_09;
      continue;
    }

    level.teamspawnpoints["allies"][level.teamspawnpoints["allies"].size] = var_09;
  }
}

getnearestflagteam(param_00) {
  var_01 = scripts\mp\spawnlogic::ispathdataavailable();
  var_02 = undefined;
  var_03 = undefined;
  foreach(var_05 in level.teamflags) {
    var_06 = undefined;
    if(var_01) {
      var_06 = getpathdist(param_00.origin, var_05.curorigin, 999999);
    }

    if(!isDefined(var_06) || var_06 == -1) {
      var_06 = distancesquared(var_05.curorigin, param_00.origin);
    }

    if(!isDefined(var_02) || var_06 < var_03) {
      var_02 = var_05;
      var_03 = var_06;
    }
  }

  return var_02.ownerteam;
}

getspawnpoint() {
  var_00 = self.pers["team"];
  var_01 = scripts\mp\utility::getotherteam(var_00);
  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(game["switchedsides"]) {
      var_02 = scripts\mp\spawnlogic::getspawnpointarray("mp_ctf_spawn_" + var_01 + "_start");
      var_03 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_02);
    } else {
      var_02 = scripts\mp\spawnlogic::getspawnpointarray("mp_ctf_spawn_" + var_02 + "_start");
      var_03 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_03);
    }
  } else {
    var_04 = level.teamspawnpoints["neutral"].size > 0;
    var_02 = scripts\mp\spawnlogic::getteamspawnpoints(var_00);
    var_03 = scripts\mp\spawnscoring::getspawnpoint(var_02, undefined, undefined, var_04);
    if(!isDefined(var_03) && var_04) {
      var_02 = scripts\mp\spawnlogic::getteamspawnpoints("neutral");
      var_03 = scripts\mp\spawnscoring::getspawnpoint(var_02);
    }
  }

  return var_03;
}

flag_default_origins() {
  level.default_goal_origins = [];
  level.magicbullet = getEntArray("flag_primary", "targetname");
  foreach(var_01 in level.magicbullet) {
    switch (var_01.script_label) {
      case "_a":
        level.default_flag_origins[game["attackers"]] = var_01.origin;
        break;

      case "_b":
        level.default_ball_origin = var_01.origin;
        break;

      case "_c":
        level.default_flag_origins[game["defenders"]] = var_01.origin;
        break;
    }
  }
}

flag_create_team_goal(param_00) {
  var_01 = 0;
  var_02 = undefined;
  if(isDefined(var_02)) {
    var_02 flag_find_ground();
    var_02.origin = var_02.ground_origin;
  } else {
    var_02 = spawnStruct();
    switch (level.script) {
      default:
        break;
    }

    if(!isDefined(var_02.origin)) {
      var_02.origin = level.default_flag_origins[param_00];
    }

    var_02 flag_find_ground();
    var_02.origin = var_02.ground_origin;
  }

  var_02.fgetarg = 30;
  var_02.team = param_00;
  var_02.ball_in_goal = 0;
  var_02.highestspawndistratio = 0;
  return var_02;
}

flag_find_ground(param_00) {
  var_01 = self.origin + (0, 0, 32);
  var_02 = self.origin + (0, 0, -1000);
  var_03 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_04 = [];
  var_05 = scripts\common\trace::ray_trace(var_01, var_02, var_04, var_03);
  self.ground_origin = var_05["position"];
  return var_05["fraction"] != 0 && var_05["fraction"] != 1;
}

showflagradiuseffecttoplayers(param_00, param_01, param_02) {
  if(isDefined(param_01._flagradiuseffect[param_00])) {
    param_01._flagradiuseffect[param_00] delete();
  }

  var_03 = undefined;
  var_04 = param_01.team;
  var_05 = param_01 ismlgspectator();
  if(var_05) {
    var_04 = param_01 getmlgspectatorteam();
  } else if(var_04 == "spectator") {
    var_04 = "allies";
  }

  if(var_04 == param_00) {
    var_06 = spawnfxforclient(level.flagradiusfxid["friendly"], param_02, param_01, (0, 0, 1));
    var_06 setfxkilldefondelete();
  } else {
    var_06 = spawnfxforclient(level.flagradiusfxid["enemy"], var_03, param_02, (0, 0, 1));
    var_06 setfxkilldefondelete();
  }

  param_01._flagradiuseffect[param_00] = var_06;
  triggerfx(var_06);
}

showbaseeffecttoplayer(param_00, param_01) {
  if(isDefined(param_01._flageffect[param_00])) {
    param_01._flageffect[param_00] delete();
  }

  var_02 = undefined;
  var_03 = param_01.team;
  var_04 = param_01 ismlgspectator();
  if(var_04) {
    var_03 = param_01 getmlgspectatorteam();
  } else if(var_03 == "spectator") {
    var_03 = "allies";
  }

  if(var_03 == param_00) {
    var_05 = spawnfxforclient(level.flagbaseglowfxid["friendly"], self.origin, param_01, self.baseeffectforward);
    var_05 setfxkilldefondelete();
  } else {
    var_05 = spawnfxforclient(level.flagbaseglowfxid["enemy"], self.origin, var_02, self.baseeffectforward);
    var_05 setfxkilldefondelete();
  }

  param_01._flageffect[param_00] = var_05;
  triggerfx(var_05);
}

removeflagpickupradiuseffect(param_00) {
  if(param_00 == self.team) {
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

setteaminhuddatafromteamname(param_00) {
  if(param_00 == "axis") {
    self setteaminhuddata(1);
    return;
  }

  if(param_00 == "allies") {
    self setteaminhuddata(2);
    return;
  }

  self setteaminhuddata(0);
}

player_delete_flag_goal_fx(param_00) {
  if(param_00 == self.team) {
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

getflagpos(param_00) {
  var_01 = getent("ctf_flag_" + param_00, "targetname");
  return var_01.origin;
}

createteamflag(param_00, param_01) {
  var_02 = 0;
  var_03 = getent("ctf_zone_" + param_01, "targetname");
  if(!isDefined(var_03)) {
    var_04 = flag_create_team_goal(param_00);
    var_03 = spawn("trigger_radius", var_04.origin - (0, 0, var_04.fgetarg / 2), 0, var_04.fgetarg, 80);
    var_03.no_moving_platfrom_unlink = 1;
    var_03.linktoenabledflag = 1;
    var_03.baseorigin = var_03.origin;
    var_02 = 1;
    var_05[0] = spawn("script_model", var_04.origin);
    var_05[0] setasgametypeobjective();
    var_05[0] setteaminhuddatafromteamname(param_01);
  } else {
    var_05[0] = getent("ctf_flag_" + var_02, "targetname");
  }

  if(!isDefined(var_05[0])) {}

  if(!var_02) {
    var_06 = 15;
    if(level.pickuptime > 0 || level.returntime > 0) {
      var_06 = var_06 * 2;
    }

    var_07 = spawn("trigger_radius", var_03.origin, 0, var_06, var_03.height);
    var_03 = var_07;
  }

  var_05[0] setModel(level.flagmodel[param_00]);
  var_05[0] setasgametypeobjective();
  var_05[0] setteaminhuddatafromteamname(param_01);
  var_08 = scripts\mp\gameobjects::createcarryobject(param_00, var_03, var_05, (0, 0, 85));
  var_08 scripts\mp\gameobjects::setteamusetext("enemy", &"MP_GRABBING_FLAG");
  var_08 scripts\mp\gameobjects::setteamusetext("friendly", &"MP_RETURNING_FLAG");
  var_08 scripts\mp\gameobjects::allowcarry("enemy");
  var_08 scripts\mp\gameobjects::setteamusetime("enemy", level.pickuptime);
  var_08 scripts\mp\gameobjects::setteamusetime("friendly", level.returntime);
  var_08 scripts\mp\gameobjects::setvisibleteam("none");
  var_08 scripts\mp\gameobjects::set2dicon("friendly", level.iconkill2d);
  var_08 scripts\mp\gameobjects::set3dicon("friendly", level.iconkill3d);
  var_08 scripts\mp\gameobjects::set2dicon("enemy", level.iconescort2d);
  var_08 scripts\mp\gameobjects::set3dicon("enemy", level.iconescort3d);
  var_08.allowweapons = 1;
  var_08.onpickup = ::onpickup;
  var_08.onpickupfailed = ::onpickup;
  var_08.ondrop = ::ondrop;
  var_08.onreset = ::onreset;
  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        var_08.objidpingenemy = 1;
        var_08.objidpingfriendly = 0;
        var_08.objpingdelay = 60;
        break;

      case 1:
        var_08.objidpingenemy = 0;
        var_08.objidpingfriendly = 0;
        var_08.objpingdelay = 0.05;
        break;

      case 2:
        var_08.objidpingenemy = 1;
        var_08.objidpingfriendly = 0;
        var_08.objpingdelay = 1;
        break;

      case 3:
        var_08.objidpingenemy = 1;
        var_08.objidpingfriendly = 0;
        var_08.objpingdelay = 1.5;
        break;

      case 4:
        var_08.objidpingenemy = 1;
        var_08.objidpingfriendly = 0;
        var_08.objpingdelay = 2;
        break;

      case 5:
        var_08.objidpingenemy = 1;
        var_08.objidpingfriendly = 0;
        var_08.objpingdelay = 3;
        break;

      case 6:
        var_08.objidpingenemy = 1;
        var_08.objidpingfriendly = 0;
        var_08.objpingdelay = 4;
        break;
    }
  } else {
    var_08.objidpingenemy = 1;
    var_08.objidpingfriendly = 0;
    var_08.objpingdelay = 3;
  }

  var_08.oldradius = var_03.fgetarg;
  var_09 = var_03.origin + (0, 0, 32);
  var_0A = var_03.origin + (0, 0, -32);
  var_0B = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_0C = [];
  var_0D = scripts\common\trace::ray_trace(var_09, var_0A, var_0C, var_0B);
  var_08.baseeffectpos = var_08.visuals[0].origin;
  var_0E = anglestoup(var_08.visuals[0].angles);
  var_08.baseeffectforward = anglesToForward(var_0E);
  level.teamflagbases[param_00] = createteamflagbase(param_00, var_08);
  return var_08;
}

createteamflagbase(param_00, param_01) {
  var_02 = param_01.visuals[0].origin;
  var_03 = spawn("script_model", var_02);
  var_03 setModel(level.flagbase[param_00]);
  var_03.ownerteam = param_00;
  var_03 setasgametypeobjective();
  var_03 setteaminhuddatafromteamname(param_00);
  var_03.baseeffectpos = var_02;
  var_04 = anglestoup(param_01.visuals[0].angles);
  var_03.baseeffectforward = anglesToForward(var_04);
  foreach(var_06 in level.players) {
    var_03 showbaseeffecttoplayer(param_00, var_06);
  }

  return var_03;
}

createcapzone(param_00, param_01) {
  var_02 = flag_create_team_goal(param_00);
  var_03 = getent("ctf_zone_" + param_01, "targetname");
  if(!isDefined(var_03)) {
    var_03 = spawn("trigger_radius", var_02.origin - (0, 0, var_02.fgetarg / 2), 0, var_02.fgetarg, 80);
    var_03.no_moving_platfrom_unlink = 1;
    var_03.linktoenabledflag = 1;
    var_03.baseorigin = var_03.origin;
    var_03.height = 80;
  }

  var_04 = spawn("trigger_radius", var_03.origin, 0, 15, var_03.height);
  var_03 = var_04;
  var_05 = [];
  var_06 = scripts\mp\gameobjects::createuseobject(param_00, var_03, var_05, (0, 0, 85));
  var_06 scripts\mp\gameobjects::allowuse("friendly");
  var_06 scripts\mp\gameobjects::setvisibleteam("any");
  var_06 scripts\mp\gameobjects::set2dicon("friendly", level.icondefendflag2d);
  var_06 scripts\mp\gameobjects::set3dicon("friendly", level.icondefendflag3d);
  var_06 scripts\mp\gameobjects::set2dicon("enemy", level.iconcaptureflag2d);
  var_06 scripts\mp\gameobjects::set3dicon("enemy", level.iconcaptureflag3d);
  var_06 scripts\mp\gameobjects::setusetime(0);
  var_06 scripts\mp\gameobjects::setkeyobject(level.teamflags[scripts\mp\utility::getotherteam(param_00)]);
  var_06.onuse = ::onuse;
  var_06.oncantuse = ::oncantuse;
  var_07 = var_03.origin + (0, 0, 32);
  var_08 = var_03.origin + (0, 0, -32);
  var_09 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_0A = [];
  var_0B = scripts\common\trace::ray_trace(var_07, var_08, var_0A, var_09);
  var_0C = vectortoangles(var_0B["normal"]);
  var_0D = anglesToForward(var_0C);
  var_0E = anglestoright(var_0C);
  return var_06;
}

onbeginuse(param_00) {
  var_01 = param_00.pers["team"];
  if(var_01 == scripts\mp\gameobjects::getownerteam()) {
    self.trigger.fgetarg = 1024;
    return;
  }

  self.trigger.fgetarg = self.oldradius;
}

onenduse(param_00, param_01, param_02) {
  self.trigger.fgetarg = self.oldradius;
}

onpickup(param_00) {
  self notify("picked_up");
  param_00 notify("obj_picked_up");
  var_01 = param_00.pers["team"];
  if(var_01 == "allies") {
    var_02 = "axis";
  } else {
    var_02 = "allies";
  }

  if(var_01 == scripts\mp\gameobjects::getownerteam()) {
    if(isDefined(level.closecapturekiller[param_00.team]) && level.closecapturekiller[param_00.team] == param_00) {
      param_00 thread scripts\mp\awards::givemidmatchaward("mode_ctf_nope");
    }

    scripts\mp\utility::setmlgannouncement(11, param_00.team, param_00 getentitynumber());
    level.closecapturekiller[param_00.team] = undefined;
    param_00 thread scripts\mp\utility::giveunifiedpoints("flag_return");
    thread returnflag();
    param_00 thread scripts\mp\matchdata::loggameevent("obj_return", param_00.origin);
    scripts\mp\utility::printandsoundoneveryone(var_01, scripts\mp\utility::getotherteam(var_01), &"MP_FLAG_RETURNED", &"MP_ENEMY_FLAG_RETURNED", "mp_obj_returned", "mp_obj_returned", param_00);
    scripts\mp\utility::leaderdialog("enemy_flag_returned", var_02, "status");
    scripts\mp\utility::leaderdialog("flag_returned", var_01, "status");
    param_00 scripts\mp\utility::incperstat("returns", 1);
    param_00 scripts\mp\persistence::statsetchild("round", "returns", param_00.pers["returns"]);
    if(isplayer(param_00)) {
      param_00 scripts\mp\utility::setextrascore1(param_00.pers["returns"]);
    }

    if(var_01 == "allies") {
      setomnvar("ui_ctf_flag_allies", -2);
      return;
    }

    setomnvar("ui_ctf_flag_axis", -2);
    return;
  }

  if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[var_01])) {
    param_00 thread applyflagcarrierclass();
  } else {
    param_00 attachflag();
  }

  scripts\mp\utility::setmlgannouncement(8, param_00.team, param_00 getentitynumber());
  level.closecapturekiller[var_02] = undefined;
  if(param_00.team == "allies") {
    setomnvar("ui_ctf_flag_axis", param_00 getentitynumber());
  } else {
    setomnvar("ui_ctf_flag_allies", param_00 getentitynumber());
  }

  param_00 setclientomnvar("ui_ctf_flag_carrier", 1);
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
    level.capzones[var_02] scripts\mp\gameobjects::allowuse("none");
  }

  level.capzones[var_02] scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\utility::printandsoundoneveryone(var_01, var_02, &"MP_ENEMY_FLAG_TAKEN_BY", &"MP_FLAG_TAKEN_BY", "mp_obj_taken", "mp_enemy_obj_taken", param_00);
  scripts\mp\utility::leaderdialog("enemy_flag_taken", var_01);
  scripts\mp\utility::leaderdialog("flag_getback", var_02);
  thread scripts\mp\utility::teamplayercardsplash("callout_flagpickup", param_00);
  if(!isDefined(self.previouscarrier) || self.previouscarrier != param_00) {
    param_00 thread scripts\mp\utility::giveunifiedpoints("flag_grab");
  }

  param_00 thread scripts\mp\matchdata::loggameevent("pickup", param_00.origin);
  self.previouscarrier = param_00;
  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    param_00 setgametypevip(1);
  }

  param_00 thread superabilitywatcher();
}

returnflag() {
  scripts\mp\utility::setmlgannouncement(11, scripts\mp\gameobjects::getownerteam());
  scripts\mp\gameobjects::returnobjectiveid();
}

ondrop(param_00) {
  var_01 = scripts\mp\gameobjects::getownerteam();
  var_02 = level.otherteam[var_01];
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
  if(var_01 == "allies") {
    setomnvar("ui_ctf_flag_allies", -1);
  } else {
    setomnvar("ui_ctf_flag_axis", -1);
  }

  if(isDefined(param_00)) {
    param_00 setclientomnvar("ui_ctf_flag_carrier", 0);
  }

  var_03 = self.visuals[0] gettagorigin("tag_origin");
  level.capzones[var_02].trigger scripts\mp\entityheadicons::setheadicon("none", "", (0, 0, 0));
  if(isDefined(param_00)) {
    if(!scripts\mp\utility::isreallyalive(param_00)) {
      param_00.carryobject.previouscarrier = undefined;
    }

    if(isDefined(param_00.carryflag)) {
      param_00 detachflag();
    }

    scripts\mp\utility::printandsoundoneveryone(var_02, "none", &"MP_ENEMY_FLAG_DROPPED_BY", "", "mp_war_objective_lost", "", param_00);
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      param_00 setgametypevip(0);
    }
  } else {
    scripts\mp\utility::playsoundonplayers("mp_war_objective_lost", var_02);
  }

  scripts\mp\utility::leaderdialog("enemy_flag_dropped", var_02, "status");
  scripts\mp\utility::leaderdialog("flag_dropped", var_01, "status");
  if(level.idleresettime > 0) {
    thread returnaftertime();
  }
}

returnaftertime() {
  self endon("picked_up");
  var_00 = 0;
  while(var_00 < level.idleresettime) {
    wait(0.05);
    if(self.claimteam == "none") {
      var_00 = var_00 + 0.05;
    }
  }

  var_01 = scripts\mp\gameobjects::getownerteam();
  var_02 = level.otherteam[var_01];
  scripts\mp\utility::playsoundonplayers("mp_war_objective_taken", var_01);
  scripts\mp\utility::playsoundonplayers("mp_war_objective_lost", var_02);
  scripts\mp\utility::setmlgannouncement(11, scripts\mp\gameobjects::getownerteam());
  scripts\mp\gameobjects::returnobjectiveid();
}

onreset() {
  var_00 = scripts\mp\gameobjects::getownerteam();
  var_01 = level.otherteam[var_00];
  scripts\mp\gameobjects::allowcarry("enemy");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::set2dicon("friendly", level.iconkill2d);
  scripts\mp\gameobjects::set3dicon("friendly", level.iconkill3d);
  scripts\mp\gameobjects::set2dicon("enemy", level.iconescort2d);
  scripts\mp\gameobjects::set3dicon("enemy", level.iconescort3d);
  if(var_00 == "allies") {
    setomnvar("ui_ctf_flag_allies", -2);
  } else {
    setomnvar("ui_ctf_flag_axis", -2);
  }

  level.capzones[var_00] scripts\mp\gameobjects::allowuse("friendly");
  level.capzones[var_00] scripts\mp\gameobjects::setvisibleteam("any");
  level.capzones[var_00] scripts\mp\gameobjects::set2dicon("friendly", level.icondefendflag2d);
  level.capzones[var_00] scripts\mp\gameobjects::set3dicon("friendly", level.icondefendflag3d);
  level.capzones[var_00] scripts\mp\gameobjects::set2dicon("enemy", level.iconcaptureflag2d);
  level.capzones[var_00] scripts\mp\gameobjects::set3dicon("enemy", level.iconcaptureflag3d);
  level.capzones[var_00].trigger scripts\mp\entityheadicons::setheadicon("none", "", (0, 0, 0));
  self.previouscarrier = undefined;
}

onuse(param_00) {
  if(!level.gameended) {
    var_01 = param_00.pers["team"];
    if(var_01 == "allies") {
      var_02 = "axis";
    } else {
      var_02 = "allies";
    }

    param_00 setclientomnvar("ui_ctf_flag_carrier", 0);
    scripts\mp\utility::leaderdialog("enemy_flag_captured", var_01, "status");
    scripts\mp\utility::leaderdialog("flag_captured", var_02, "status");
    thread scripts\mp\utility::teamplayercardsplash("callout_flagcapture", param_00);
    param_00 thread scripts\mp\awards::givemidmatchaward("mode_ctf_cap");
    param_00 notify("objective", "captured");
    param_00 thread scripts\mp\matchdata::loggameevent("capture", param_00.origin);
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      param_00 setgametypevip(0);
    }

    param_00 scripts\mp\utility::incperstat("captures", 1);
    param_00 scripts\mp\persistence::statsetchild("round", "captures", param_00.pers["captures"]);
    if(isplayer(param_00)) {
      param_00 scripts\mp\utility::setextrascore0(param_00.pers["captures"]);
    }

    scripts\mp\utility::printandsoundoneveryone(var_01, var_02, &"MP_ENEMY_FLAG_CAPTURED_BY", &"MP_FRIENDLY_FLAG_CAPTURED_BY", "mp_obj_captured", "mp_enemy_obj_captured", param_00);
    if(isDefined(param_00.carryflag)) {
      param_00 detachflag();
    }

    if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[var_01])) {
      param_00 thread removeflagcarrierclass();
    }

    level.closecapturekiller[var_01] = undefined;
    level.closecapturekiller[var_02] = undefined;
    level.teamflags[var_02] returnflag();
    scripts\mp\utility::setmlgannouncement(9, var_01, param_00 getentitynumber());
    level scripts\mp\gamescore::giveteamscoreforobjective(var_01, 1, 0);
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00._flageffect = [];
    var_00._flagradiuseffect = [];
    var_00 thread onplayerspawned();
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
      foreach(var_01 in level.teamflagbases) {
        if(isDefined(var_01)) {
          var_01 showbaseeffecttoplayer(var_01.ownerteam, self);
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
    scripts\mp\perks\_perkfunctions::deleteti(self.setspawnpoint);
  }

  var_00 = spawn("script_model", self.origin);
  var_00.angles = self.angles;
  var_00.playerspawnpos = self.origin;
  var_00.notti = 1;
  self.setspawnpoint = var_00;
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
  var_00 = self.pers["team"];
  if(var_00 == "allies") {
    var_01 = "axis";
  } else {
    var_01 = "allies";
  }

  level.teamflags[var_01] endon("reset");
  for(;;) {
    self waittill("super_started");
    var_02 = level.teamflags[var_01];
    if(!isDefined(var_02)) {
      continue;
    }

    var_03 = self.super;
    switch (var_03.staticdata.ref) {
      case "super_phaseshift":
        var_02 thread scripts\mp\gameobjects::setdropped();
        break;

      case "super_teleport":
      case "super_rewind":
        scripts\engine\utility::waittill_any_3("teleport_success", "rewind_success");
        var_02.ftldrop = 1;
        var_02 thread scripts\mp\gameobjects::setdropped();
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
    scripts\mp\perks\_perkfunctions::deleteti(self.setspawnpoint);
  }

  var_00 = spawn("script_model", self.origin);
  var_00.angles = self.angles;
  var_00.playerspawnpos = self.origin;
  var_00.notti = 1;
  self.setspawnpoint = var_00;
  self notify("faux_spawn");
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

oncantuse(param_00) {}

onplayerkilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  var_0A = 0;
  var_0B = param_01.origin;
  var_0C = 0;
  if(isDefined(param_00)) {
    var_0B = param_00.origin;
    var_0C = param_00 == param_01;
  }

  if(isDefined(param_01) && isplayer(param_01) && param_01.pers["team"] != self.pers["team"]) {
    if(isDefined(param_01.carryflag) && var_0C) {
      param_01 thread scripts\mp\awards::givemidmatchaward("mode_ctf_kill_with_flag");
      var_0A = 1;
    }

    if(isDefined(self.carryflag)) {
      var_0D = distancesquared(self.origin, level.capzones[self.team].trigger.origin);
      if(var_0D < 90000) {
        level.closecapturekiller[param_01.team] = param_01;
      } else {
        level.closecapturekiller[param_01.team] = undefined;
      }

      param_01 thread scripts\mp\awards::givemidmatchaward("mode_ctf_kill_carrier");
      scripts\mp\utility::setmlgannouncement(10, param_01.team, param_01 getentitynumber());
      param_01 scripts\mp\utility::incperstat("defends", 1);
      param_01 scripts\mp\persistence::statsetchild("round", "defends", param_01.pers["defends"]);
      thread scripts\mp\matchdata::loginitialstats(param_09, "carrying");
      var_0A = 1;
    }

    if(!var_0A) {
      var_0E = 0;
      var_0F = 0;
      foreach(var_11 in level.teamflags) {
        var_12 = distsquaredcheck(var_0B, self.origin, var_11.curorigin);
        if(var_12) {
          if(var_11.ownerteam == self.team) {
            var_0E = 1;
            continue;
          }

          var_0F = 1;
        }
      }

      if(var_0E) {
        param_01 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
        thread scripts\mp\matchdata::loginitialstats(param_09, "defending");
      } else if(var_0F) {
        param_01 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
        param_01 scripts\mp\utility::incperstat("defends", 1);
        param_01 scripts\mp\persistence::statsetchild("round", "defends", param_01.pers["defends"]);
        thread scripts\mp\matchdata::loginitialstats(param_09, "assaulting");
      }
    }
  }

  if(isDefined(self.carryflag)) {
    detachflag();
  }
}

distsquaredcheck(param_00, param_01, param_02) {
  var_03 = distancesquared(param_02, param_00);
  var_04 = distancesquared(param_02, param_01);
  if(var_03 < 90000 || var_04 < 90000) {
    return 1;
  }

  return 0;
}

attachflag() {
  var_00 = level.otherteam[self.pers["team"]];
  self attach(level.carryflag[var_00], "J_spine4", 1);
  self.carryflag = level.carryflag[var_00];
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
    if(getdvar("scr_devRemoveDomFlag", "") != "") {
      var_00 = getdvar("scr_devRemoveDomFlag", "");
      if(var_00 == "_a") {
        var_01 = "allies";
      } else {
        var_01 = "axis";
      }

      if(var_01 == "allies") {
        if(game["switchedsides"]) {
          var_01 = game["defenders"];
        } else {
          var_01 = game["attackers"];
        }
      } else if(game["switchedsides"]) {
        var_01 = game["attackers"];
      } else {
        var_01 = game["defenders"];
      }

      level.teamflags[var_01].trigger notify("move_gameobject");
      level.teamflags[var_01] scripts\mp\gameobjects::allowuse("none");
      level.teamflags[var_01].trigger = undefined;
      level.teamflags[var_01] notify("deleted");
      level.teamflags[var_01].visuals[0] delete();
      level.teamflagbases[var_01] delete();
      level.capzones[var_01] scripts\mp\gameobjects::allowuse("none");
      level.capzones[var_01].trigger = undefined;
      level.capzones[var_01] notify("deleted");
      foreach(var_03 in level.players) {
        var_03 player_delete_flag_goal_fx(var_01);
      }

      level.teamflags[var_01].visibleteam = "none";
      level.teamflags[var_01] scripts\mp\gameobjects::set2dicon("friendly", undefined);
      level.teamflags[var_01] scripts\mp\gameobjects::set3dicon("friendly", undefined);
      level.teamflags[var_01] scripts\mp\gameobjects::set2dicon("enemy", undefined);
      level.teamflags[var_01] scripts\mp\gameobjects::set3dicon("enemy", undefined);
      level.capzones[var_01].visibleteam = "none";
      level.capzones[var_01] scripts\mp\gameobjects::set2dicon("friendly", undefined);
      level.capzones[var_01] scripts\mp\gameobjects::set3dicon("friendly", undefined);
      level.capzones[var_01] scripts\mp\gameobjects::set2dicon("enemy", undefined);
      level.capzones[var_01] scripts\mp\gameobjects::set3dicon("enemy", undefined);
      level.teamflags[var_01] = undefined;
      setdynamicdvar("scr_devRemoveDomFlag", "");
    }

    wait(1);
  }
}

placeflag() {
  level endon("game_ended");
  for(;;) {
    if(getdvar("scr_devPlaceDomFlag", "") != "") {
      var_00 = getdvar("scr_devPlaceDomFlag", "");
      if(var_00 == "_a") {
        var_01 = "allies";
      } else {
        var_01 = "axis";
      }

      if(var_01 == "allies") {
        if(game["switchedsides"]) {
          var_01 = game["defenders"];
        } else {
          var_01 = game["attackers"];
        }
      } else if(game["switchedsides"]) {
        var_01 = game["attackers"];
      } else {
        var_01 = game["defenders"];
      }

      var_02 = undefined;
      var_02 = spawnStruct();
      var_02 dev_flag_find_ground();
      var_02.origin = var_02.ground_origin;
      var_02.fgetarg = 30;
      var_02.team = var_01;
      var_03 = spawn("trigger_radius", var_02.origin, 0, 30, 80);
      var_04[0] = spawn("script_model", var_02.origin);
      var_04[0] setModel(level.flagmodel[var_01]);
      var_05 = scripts\mp\gameobjects::createcarryobject(var_01, var_03, var_04, (0, 0, 85));
      var_05 scripts\mp\gameobjects::setteamusetext("enemy", &"MP_GRABBING_FLAG");
      var_05 scripts\mp\gameobjects::setteamusetext("friendly", &"MP_RETURNING_FLAG");
      var_05 scripts\mp\gameobjects::allowcarry("enemy");
      var_05 scripts\mp\gameobjects::setvisibleteam("none");
      var_05 scripts\mp\gameobjects::set2dicon("friendly", level.iconkill2d);
      var_05 scripts\mp\gameobjects::set3dicon("friendly", level.iconkill3d);
      var_05 scripts\mp\gameobjects::set2dicon("enemy", level.iconescort2d);
      var_05 scripts\mp\gameobjects::set3dicon("enemy", level.iconescort3d);
      var_05.objidpingenemy = 1;
      var_05.allowweapons = 1;
      var_05.onpickup = ::onpickup;
      var_05.onpickupfailed = ::onpickup;
      var_05.ondrop = ::ondrop;
      var_05.onreset = ::onreset;
      var_05.oldradius = var_03.fgetarg;
      var_05.origin = var_02.origin;
      var_05.label = var_01;
      var_05.previouscarrier = undefined;
      var_06 = var_03.origin + (0, 0, 32);
      var_07 = var_03.origin + (0, 0, -32);
      var_08 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
      var_09 = [];
      var_0A = scripts\common\trace::ray_trace(var_06, var_07, var_09, var_08);
      var_05.baseeffectpos = var_0A["position"];
      var_0B = vectortoangles(var_0A["normal"]);
      var_05.baseeffectforward = anglesToForward(var_0B);
      level.teamflagbases[var_01] = createteamflagbase(var_01, var_05);
      if(var_01 == "allies") {
        if(game["switchedsides"]) {
          level.teamflags[game["defenders"]] = var_05;
        } else {
          level.teamflags[game["attackers"]] = var_05;
        }
      } else if(game["switchedsides"]) {
        level.teamflags[game["attackers"]] = var_05;
      } else {
        level.teamflags[game["defenders"]] = var_05;
      }

      var_04 = [];
      var_03 = spawn("trigger_radius", var_02.origin - (0, 0, var_02.fgetarg / 2), 0, var_02.fgetarg, 80);
      var_03.no_moving_platfrom_unlink = 1;
      var_03.linktoenabledflag = 1;
      var_03.baseorigin = var_03.origin;
      var_0C = scripts\mp\gameobjects::createuseobject(var_01, var_03, var_04, (0, 0, 115));
      var_0C scripts\mp\gameobjects::allowuse("friendly");
      var_0C scripts\mp\gameobjects::setvisibleteam("any");
      var_0C scripts\mp\gameobjects::set2dicon("friendly", level.icondefendflag2d);
      var_0C scripts\mp\gameobjects::set3dicon("friendly", level.icondefendflag3d);
      var_0C scripts\mp\gameobjects::set2dicon("enemy", level.iconcaptureflag2d);
      var_0C scripts\mp\gameobjects::set3dicon("enemy", level.iconcaptureflag3d);
      var_0C scripts\mp\gameobjects::setusetime(0);
      var_0C scripts\mp\gameobjects::setkeyobject(level.teamflags[scripts\mp\utility::getotherteam(var_01)]);
      level.capzones[level.otherteam[var_01]] scripts\mp\gameobjects::setkeyobject(var_05);
      var_0C.onuse = ::onuse;
      var_0C.oncantuse = ::oncantuse;
      var_06 = var_03.origin + (0, 0, 32);
      var_07 = var_03.origin + (0, 0, -32);
      var_08 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
      var_09 = [];
      var_0A = scripts\common\trace::ray_trace(var_06, var_07, var_09, var_08);
      var_0B = vectortoangles(var_0A["normal"]);
      var_0D = anglesToForward(var_0B);
      var_0E = anglestoright(var_0B);
      if(var_01 == "allies") {
        if(game["switchedsides"]) {
          level.capzones[game["defenders"]] = var_0C;
        } else {
          level.capzones[game["attackers"]] = var_0C;
        }
      } else if(game["switchedsides"]) {
        level.capzones[game["attackers"]] = var_0C;
      } else {
        level.capzones[game["defenders"]] = var_0C;
      }

      setdynamicdvar("scr_devPlaceDomFlag", "");
    }

    wait(1);
  }
}

dev_flag_find_ground() {
  var_00 = level.players[0].origin + (0, 0, 32);
  var_01 = level.players[0].origin + (0, 0, -1000);
  var_02 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_03 = [];
  var_04 = scripts\common\trace::ray_trace(var_00, var_01, var_03, var_02);
  self.ground_origin = var_04["position"];
  return var_04["fraction"] != 0 && var_04["fraction"] != 1;
}