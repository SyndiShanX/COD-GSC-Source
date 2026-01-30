/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\ctf.gsc
**************************************/

main() {
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  maps\mp\gametypes\_globallogic::setupcallbacks();

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread maps\mp\_utility::reinitializematchrulesonmigration();
  } else {
    maps\mp\_utility::registertimelimitdvar(level.gametype, 5);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 3);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  maps\mp\_utility::setovertimelimitdvar(5);

  if(isDefined(game["round_time_to_beat"])) {
    maps\mp\_utility::setovertimelimitdvar(game["round_time_to_beat"]);
    game["round_time_to_beat"] = undefined;
  }

  setspecialloadouts();
  level.assists_disabled = 1;
  level.teambased = 1;
  level.objectivebased = 1;
  level.overtimescorewinoverride = 1;
  level.onlyroundoverride = 1;
  level.pingstate = maps\mp\_utility::getintproperty("scr_ping_carrier", 1);
  level.winbycaptures = maps\mp\_utility::getintproperty("scr_win_by_captures", 0);
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.ontimelimit = ::ontimelimit;
  level.onhalftime = ::onhalftime;

  if(!isDefined(game["shut_out"])) {
    game["shut_out"]["axis"] = 1;
    game["shut_out"]["allies"] = 1;
  }

  if(level.winbycaptures) {
    setdynamicdvar("scr_ctf_scorelimit", 0);
  }

  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
  }

  level.flagreturntime = maps\mp\_utility::getintproperty("scr_ctf_returntime", 30);
  game["dialog"]["gametype"] = "ctf_intro";

  if(getdvarint("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "dom_start";
  game["dialog"]["defense_obj"] = "dom_start";

  if(maps\mp\_utility::isgrapplinghookgamemode()) {
    game["dialog"]["gametype"] = "grap_" + game["dialog"]["gametype"];
  }

  thread onplayerconnect();
}

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_ctf_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("ctf", 1);
  setdynamicdvar("scr_ctf_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("ctf", 1);
  setdynamicdvar("scr_ctf_halftime", 1);
  maps\mp\_utility::registerhalftimedvar("ctf", 1);
  setdynamicdvar("scr_ctf_returntime", getmatchrulesdata("ctfData", "returnTime"));
  setdynamicdvar("scr_ping_carrier", getmatchrulesdata("ctfData", "enemyCarrierIcon"));
  setdynamicdvar("scr_win_by_captures", getmatchrulesdata("ctfData", "winByCaptures"));
  setdynamicdvar("scr_ctf_flag_pick_up_time_friendly", getmatchrulesdata("ctfData", "pickupTime"));
  setdynamicdvar("scr_ctf_flag_pick_up_time_enemy", getmatchrulesdata("ctfData", "pickupTime"));
}

onstartgametype() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(maps\mp\_utility::isovertimetext(game["status"])) {
    game["switchedsides"] = !game["switchedsides"];
  }

  if(game["status"] == "halftime") {
    setomnvar("ui_current_round", 2);
  } else if(game["status"] == "overtime") {
    setomnvar("ui_current_round", 3);
  } else if(game["status"] == "overtime_halftime") {
    setomnvar("ui_current_round", 4);
  }

  if(!isDefined(game["original_defenders"])) {
    game["original_defenders"] = game["defenders"];
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  if(!level.winbycaptures) {
    game["teamScores"][game["attackers"]] = 0;
    setteamscore(game["attackers"], 0);
    game["teamScores"][game["defenders"]] = 0;
    setteamscore(game["defenders"], 0);
  }

  setclientnamemode("auto_change");
  level.flagstowedfxid["sentinel"]["friendly"] = loadfx("vfx/unique/vfx_flag_project_stowed_sentinel_friendly");
  level.flagstowedfxid["sentinel"]["enemy"] = loadfx("vfx/unique/vfx_flag_project_stowed_sentinel_enemy");
  level.flagstowedfxid["atlas"]["friendly"] = loadfx("vfx/unique/vfx_flag_project_stowed_atlas_friendly");
  level.flagstowedfxid["atlas"]["enemy"] = loadfx("vfx/unique/vfx_flag_project_stowed_atlas_enemy");
  level.flaggroundfxid["sentinel"]["friendly"] = loadfx("vfx/unique/vfx_flag_project_sentinel_friendly");
  level.flaggroundfxid["sentinel"]["enemy"] = loadfx("vfx/unique/vfx_flag_project_sentinel_enemy");
  level.flaggroundfxid["atlas"]["friendly"] = loadfx("vfx/unique/vfx_flag_project_atlas_friendly");
  level.flaggroundfxid["atlas"]["enemy"] = loadfx("vfx/unique/vfx_flag_project_atlas_enemy");
  level.flagbasefxid["sentinel"]["friendly"] = loadfx("vfx/unique/vfx_marker_ctf");
  level.flagbasefxid["sentinel"]["enemy"] = loadfx("vfx/unique/vfx_marker_ctf_red");
  level.flagbasefxid["atlas"]["friendly"] = loadfx("vfx/unique/vfx_marker_ctf");
  level.flagbasefxid["atlas"]["enemy"] = loadfx("vfx/unique/vfx_marker_ctf_red");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER");
    maps\mp\_utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER");
  } else {
    maps\mp\_utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER_SCORE");
    maps\mp\_utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER_SCORE");
  }

  maps\mp\_utility::setobjectivetext(game["attackers"], &"OBJECTIVES_CTF");
  maps\mp\_utility::setobjectivetext(game["defenders"], &"OBJECTIVES_CTF");
  maps\mp\_utility::setobjectivehinttext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER_HINT");
  maps\mp\_utility::setobjectivehinttext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER_HINT");
  initspawn();
  var_2[0] = "ctf";
  maps\mp\gametypes\_gameobjects::main(var_2);
  level thread ctf();
  level thread updatescoreboardctf();
}

initspawn() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_ctf_spawn_allies_start");
  maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_ctf_spawn_axis_start");
  level.spawn_name = "mp_ctf_spawn";
  maps\mp\gametypes\_spawnlogic::addspawnpoints("allies", level.spawn_name);
  maps\mp\gametypes\_spawnlogic::addspawnpoints("axis", level.spawn_name);
  level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  var_0 = self.team;

  if(level.usestartspawns && level.ingraceperiod) {
    if(!game["switchedsides"]) {
      var_0 = maps\mp\_utility::getotherteam(var_0);
    }

    var_1 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_ctf_spawn_" + var_0 + "_start");
    var_2 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_1);
  } else {
    var_1 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_0);
    var_2 = maps\mp\gametypes\_spawnscoring::getspawnpoint_ctf(var_1, var_0);
  }

  maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_2);
  return var_2;
}

updatescoreboardctf() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread updatecaptues();
    var_0 thread updatereturns();
    var_0 thread updatedefends();
  }
}

updatecaptues() {
  waittillframeend;
  maps\mp\_utility::setextrascore0(self.pers["captures"]);
}

updatereturns() {
  waittillframeend;
  self.assists = self.pers["returns"];
}

updatedefends() {
  waittillframeend;
  maps\mp\_utility::setextrascore1(self.pers["defends"]);
}

ctf() {
  level.flagmodel["allies"] = maps\mp\gametypes\_teams::getteamflagmodel("allies");
  level.carryflag["allies"] = maps\mp\gametypes\_teams::getteamflagcarrymodel("allies");
  level.flagmodel["axis"] = maps\mp\gametypes\_teams::getteamflagmodel("axis");
  level.carryflag["axis"] = maps\mp\gametypes\_teams::getteamflagcarrymodel("axis");
  level.iconescort3d = "waypoint_escort";
  level.iconescort2d = "waypoint_escort";
  level.iconkill3d = "waypoint_kill";
  level.iconkill2d = "waypoint_kill";
  level.iconcaptureflag3d = "waypoint_capture_flag";
  level.iconcaptureflag2d = "waypoint_capture_flag";
  level.icondefendflag3d = "waypoint_defend_flag";
  level.icondefendflag2d = "waypoint_defend_flag";
  level.iconreturnflag3d = "waypoint_return_flag";
  level.iconreturnflag2d = "waypoint_return_flag";
  level.iconwaitforflag3d = "waypoint_waitfor_flag";
  level.iconwaitforflag2d = "waypoint_waitfor_flag";
  level.iconawayblue = "waypoint_esports_ctf_taken_blue";
  level.iconawayred = "waypoint_esports_ctf_taken_red";
  level.icondroppedblue = "waypoint_esports_ctf_dropped_blue";
  level.icondroppedred = "waypoint_esports_ctf_dropped_red";
  level.iconatbaseblue = "waypoint_esports_ctf_flag_blue";
  level.iconatbasered = "waypoint_esports_ctf_flag_red";
  level.iconmissingblue = "waypoint_esports_ctf_flag_missing_blue";
  level.iconmissingred = "waypoint_esports_ctf_flag_missing_red";
  level.teamflags[game["defenders"]] = createteamflag(game["defenders"], "allies");
  level.teamflags[game["attackers"]] = createteamflag(game["attackers"], level.otherteam["allies"]);
  level.capzones[game["defenders"]] = createcapzone(game["defenders"], "allies");
  level.capzones[game["attackers"]] = createcapzone(game["attackers"], level.otherteam["allies"]);
  assignteamspawns();
  onresetflaghudstatus("allies");
  onresetflaghudstatus("axis");
}

onresetflaghudstatus(var_0) {
  if(var_0 == "allies") {
    level.alliesflagstatus = 0;
    level.alliesflagcarrierclientnum = -1;
  } else {
    level.axisflagstatus = 0;
    level.axisflagcarrierclientnum = -1;
  }

  level notify("update_flag_status");
}

onpickupflaghudstatus(var_0) {
  var_1 = var_0.pers["team"];

  if(var_1 == "allies") {
    var_0.objective = 1;
    level.axisflagstatus = 2;
    level.axisflagcarrierclientnum = var_0 getentitynumber();
  } else {
    var_0.objective = 2;
    level.alliesflagstatus = 2;
    level.alliesflagcarrierclientnum = var_0 getentitynumber();
  }

  level notify("update_flag_status");
}

ondropflaghudstatus(var_0) {
  if(var_0 == "allies") {
    level.alliesflagstatus = 1;
    level.alliesflagcarrierclientnum = -1;
  } else {
    level.axisflagstatus = 1;
    level.axisflagcarrierclientnum = -1;
  }

  level notify("update_flag_status");
}

playerupdateflagstatus() {
  if(!isDefined(self.team) || !isDefined(level.alliesflagstatus)) {
    return;
  }
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  if(self.team == "allies" || self.team == "spectator") {
    var_0 = level.alliesflagstatus;
    var_1 = level.alliesflagcarrierclientnum;
    var_2 = level.axisflagstatus;
    var_3 = level.axisflagcarrierclientnum;
  } else if(self.team == "axis") {
    var_0 = level.axisflagstatus;
    var_1 = level.axisflagcarrierclientnum;
    var_2 = level.alliesflagstatus;
    var_3 = level.alliesflagcarrierclientnum;
  } else {
    return;
  }

  self setclientomnvar("ui_ctf_friendly_status", var_0);
  self setclientomnvar("ui_ctf_friendly_carrier_clientnum", var_1);
  self setclientomnvar("ui_ctf_enemy_status", var_2);
  self setclientomnvar("ui_ctf_enemy_carrier_clientnum", var_3);
  self setclientomnvar("ui_ctf_status_changed", 1);
}

playerupdateflagstatusonjointeam() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("joined_team");
    playerupdateflagstatus();
  }
}

playerwatchflagstatus() {
  level endon("game_ended");
  self endon("disconnect");
  playerupdateflagstatus();
  thread playerupdateflagstatusonjointeam();

  for(;;) {
    level waittill("update_flag_status");
    playerupdateflagstatus();
  }
}

hidehudelementongameend(var_0) {
  level waittill("game_ended");

  if(isDefined(var_0)) {
    var_0.alpha = 0;
  }
}

createteamflag(var_0, var_1) {
  var_2 = getent("ctf_zone_" + var_1, "targetname");

  if(!isDefined(var_2)) {
    common_scripts\utility::error("No ctf_zone_" + var_1 + " trigger found in map.");
  } else {
    var_3 = getent("ctf_zone_augmented_" + var_1, "targetname");

    if(isDefined(var_3)) {
      if(maps\mp\_utility::isaugmentedgamemode()) {
        var_2 delete();
        var_2 = var_3;
      } else {
        var_3 delete();
      }
    }

    var_4[0] = getent("ctf_flag_" + var_1, "targetname");

    if(!isDefined(var_4[0])) {
      common_scripts\utility::error("No ctf_flag_" + var_1 + " script_model found in map.");
      return;
    }

    var_5[0] = getent("ctf_flag_augmented_" + var_1, "targetname");

    if(isDefined(var_5[0])) {
      if(maps\mp\_utility::isaugmentedgamemode()) {
        var_4[0] delete();
        var_4[0] = var_5[0];
      } else {
        var_5[0] delete();
      }
    }

    var_6 = spawn("trigger_radius", var_2.origin, 0, 96, var_2.height);
    var_2 = var_6;
    var_4[0] setModel(level.flagmodel[var_0]);
    var_4[0].oldcontents = var_4[0] setcontents(0);
    var_7 = var_4[0].origin + (0, 0, 32);
    var_8 = var_4[0].origin + (0, 0, -32);
    var_9 = bulletTrace(var_7, var_8, 0, undefined);
    var_4[0].origin = var_9["position"];
    var_10 = maps\mp\gametypes\_gameobjects::createcarryobject(var_0, var_2, var_4, (0, 0, 85));
    var_11 = getdvarfloat("scr_ctf_flag_pick_up_time_friendly", 0.0);

    if(var_11 > 0) {
      var_10 maps\mp\gametypes\_gameobjects::setteamusetime("friendly", var_11);
    }

    var_12 = getdvarfloat("scr_ctf_flag_pick_up_time_enemy", 0.0);

    if(var_12 > 0) {
      var_10 maps\mp\gametypes\_gameobjects::setteamusetime("enemy", var_12);
    }

    var_10 maps\mp\gametypes\_gameobjects::setteamusetext("enemy", &"MP_GRABBING_FLAG");
    var_10 maps\mp\gametypes\_gameobjects::setteamusetext("friendly", &"MP_RETURNING_FLAG");
    var_10 maps\mp\gametypes\_gameobjects::allowcarry("enemy");
    var_10 maps\mp\gametypes\_gameobjects::setvisibleteam("none");
    var_10 maps\mp\gametypes\_gameobjects::set2dicon("enemy", level.iconescort2d);
    var_10 maps\mp\gametypes\_gameobjects::set3dicon("enemy", level.iconescort3d);

    if(level.pingstate != 2) {
      var_10 maps\mp\gametypes\_gameobjects::set2dicon("friendly", level.iconkill2d);
      var_10 maps\mp\gametypes\_gameobjects::set3dicon("friendly", level.iconkill3d);
    }

    if(maps\mp\_utility::isaugmentedgamemode()) {
      var_10.objpingdelay = 2.5;
    }

    var_10.objidpingfriendly = 1;
    var_10.allowweapons = 1;
    var_10.requireslos = 1;
    var_10.onpickup = ::onpickup;
    var_10.onpickupfailed = ::onpickup;
    var_10.ondrop = ::ondrop;
    var_10.onreset = ::onreset;
    var_10.goliaththink = ::goliathattachflag;
    var_10.canuseobject = ::canuse;
    var_10.goliaththink = ::goliathdropflag;
    var_10.oldradius = var_2.radius;
    var_10.origin = var_2.origin;
    var_10.highestspawndistratio = 0.0;

    if(level.pingstate == 0) {
      var_10.objidpingfriendly = 0;
    }

    if(var_0 == "allies") {
      var_10 maps\mp\gametypes\_gameobjects::set2dicon("mlg", level.iconatbaseblue);
      var_10 maps\mp\gametypes\_gameobjects::set3dicon("mlg", level.iconatbaseblue);
      setomnvar("ui_mlg_game_mode_status_1", 0);
    } else {
      var_10 maps\mp\gametypes\_gameobjects::set2dicon("mlg", level.iconatbasered);
      var_10 maps\mp\gametypes\_gameobjects::set3dicon("mlg", level.iconatbasered);
      setomnvar("ui_mlg_game_mode_status_2", 0);
    }

    var_10 thread flageffects();
  }
}

createcapzone(var_0, var_1) {
  var_2 = getent("ctf_zone_" + var_1, "targetname");
  var_3 = getent("ctf_zone_augmented_" + var_1, "targetname");

  if(isDefined(var_3) && maps\mp\_utility::isaugmentedgamemode()) {
    var_2 = var_3;
  }

  var_4 = [];
  var_5 = maps\mp\gametypes\_gameobjects::createuseobject(var_0, var_2, var_4, (0, 0, 85));
  var_5 maps\mp\gametypes\_gameobjects::allowuse("friendly");
  var_5 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
  var_5 maps\mp\gametypes\_gameobjects::set2dicon("friendly", level.icondefendflag2d);
  var_5 maps\mp\gametypes\_gameobjects::set3dicon("friendly", level.icondefendflag3d);
  var_5 maps\mp\gametypes\_gameobjects::set2dicon("enemy", level.iconcaptureflag2d);
  var_5 maps\mp\gametypes\_gameobjects::set3dicon("enemy", level.iconcaptureflag3d);
  var_5 maps\mp\gametypes\_gameobjects::setusetime(0);
  var_5 maps\mp\gametypes\_gameobjects::setkeyobject(level.teamflags[maps\mp\_utility::getotherteam(var_0)]);
  var_5.onuse = ::onuse;
  var_5.oncantuse = ::oncantuse;
  var_6 = var_2.origin + (0, 0, 32);
  var_7 = var_2.origin + (0, 0, -32);
  var_8 = bulletTrace(var_6, var_7, 0, undefined);
  var_5.baseeffectpos = var_8["position"];
  var_5.baseeffectforward = var_8["normal"];
  var_5 thread capturezoneeffects();
  return var_5;
}

onbeginuse(var_0) {
  var_1 = var_0.pers["team"];

  if(var_1 == maps\mp\gametypes\_gameobjects::getownerteam()) {
    self.trigger.radius = 1024;
  } else {
    self.trigger.radius = self.oldradius;
  }
}

onenduse(var_0, var_1, var_2) {
  self.trigger.radius = self.oldradius;
}

onpickup(var_0) {
  self notify("picked_up");
  var_1 = var_0.pers["team"];

  if(var_1 == "allies") {
    var_2 = "axis";
  } else {
    var_2 = "allies";
  }

  flageffectsstop();

  if(var_1 == maps\mp\gametypes\_gameobjects::getownerteam()) {
    thread returnflag();
    maps\mp\_utility::leaderdialog("flag_returned", var_1, "status");
    maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_med", var_1);
    maps\mp\_utility::leaderdialog("enemy_flag_returned", var_2, "status");
    maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_med", var_2);
    var_0 thread maps\mp\_events::flagreturnevent();
    onresetflaghudstatus(var_1);
  } else {
    if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[var_1])) {
      var_0 thread applyflagcarrierclass(self);
    } else {
      var_0 attachflag(self);
    }

    onpickupflaghudstatus(var_0);
    maps\mp\gametypes\_gameobjects::setvisibleteam("any");
    maps\mp\gametypes\_gameobjects::set2dicon("enemy", level.iconescort2d);
    maps\mp\gametypes\_gameobjects::set3dicon("enemy", level.iconescort3d);

    if(level.pingstate != 2) {
      maps\mp\gametypes\_gameobjects::set2dicon("friendly", level.iconkill2d);
      maps\mp\gametypes\_gameobjects::set3dicon("friendly", level.iconkill3d);
    } else {
      maps\mp\gametypes\_gameobjects::set2dicon("friendly", undefined);
      maps\mp\gametypes\_gameobjects::set3dicon("friendly", undefined);
    }

    level.capzones[var_2] maps\mp\gametypes\_gameobjects::allowuse("none");
    level.capzones[var_2] maps\mp\gametypes\_gameobjects::setvisibleteam("friendly");
    level.capzones[var_2] maps\mp\gametypes\_gameobjects::set2dicon("friendly", level.iconwaitforflag2d);
    level.capzones[var_2] maps\mp\gametypes\_gameobjects::set3dicon("friendly", level.iconwaitforflag3d);
    var_3 = [var_0];
    maps\mp\_utility::leaderdialog("enemy_flag_taken", var_1, "status");
    maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_sml", var_1, var_3);
    var_0 playlocalsound("mp_ctf_flag_pickup");
    maps\mp\_utility::leaderdialog("flag_taken", var_2, "status");
    maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_sml", var_2);

    if(maps\mp\gametypes\_gameobjects::getownerteam() == "allies") {
      level.capzones[var_2] maps\mp\gametypes\_gameobjects::set2dicon("mlg", level.iconmissingblue);
      level.capzones[var_2] maps\mp\gametypes\_gameobjects::set3dicon("mlg", level.iconmissingblue);
      maps\mp\gametypes\_gameobjects::set2dicon("mlg", level.iconawayblue);
      maps\mp\gametypes\_gameobjects::set3dicon("mlg", level.iconawayblue);
      setomnvar("ui_mlg_game_mode_status_1", var_0 getentitynumber());
    } else {
      level.capzones[var_2] maps\mp\gametypes\_gameobjects::set2dicon("mlg", level.iconmissingred);
      level.capzones[var_2] maps\mp\gametypes\_gameobjects::set3dicon("mlg", level.iconmissingred);
      maps\mp\gametypes\_gameobjects::set2dicon("mlg", level.iconawayred);
      maps\mp\gametypes\_gameobjects::set3dicon("mlg", level.iconawayred);
      setomnvar("ui_mlg_game_mode_status_2", var_0 getentitynumber());
    }

    var_0 thread maps\mp\_events::flagpickupevent();
    thread flagawayvo(var_0, var_1, var_2);
  }
}

flagawayvo(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("reset");

  for(;;) {
    wait 15;

    if(level.teamflags[var_1] maps\mp\gametypes\_gameobjects::ishome()) {
      var_0 maps\mp\_utility::leaderdialogonplayer("enemy_flag_bringhome", "status");
    }

    maps\mp\_utility::leaderdialog("flag_getback", var_2, "status");
  }
}

returnflag() {
  maps\mp\gametypes\_gameobjects::returnhome();
}

ondrop(var_0) {
  var_1 = maps\mp\gametypes\_gameobjects::getownerteam();
  var_2 = level.otherteam[var_1];
  maps\mp\gametypes\_gameobjects::allowcarry("any");
  maps\mp\gametypes\_gameobjects::setvisibleteam("any");
  maps\mp\gametypes\_gameobjects::set2dicon("friendly", level.iconreturnflag2d);
  maps\mp\gametypes\_gameobjects::set3dicon("friendly", level.iconreturnflag3d);
  maps\mp\gametypes\_gameobjects::set2dicon("enemy", level.iconcaptureflag2d);
  maps\mp\gametypes\_gameobjects::set3dicon("enemy", level.iconcaptureflag3d);
  ondropflaghudstatus(var_1);

  if(var_1 == "allies") {
    maps\mp\gametypes\_gameobjects::set2dicon("mlg", level.icondroppedblue);
    maps\mp\gametypes\_gameobjects::set3dicon("mlg", level.icondroppedblue);
    setomnvar("ui_mlg_game_mode_status_1", 0 - level.flagreturntime);
  } else {
    maps\mp\gametypes\_gameobjects::set2dicon("mlg", level.icondroppedred);
    maps\mp\gametypes\_gameobjects::set3dicon("mlg", level.icondroppedred);
    setomnvar("ui_mlg_game_mode_status_2", 0 - level.flagreturntime);
  }

  if(isDefined(var_0)) {
    var_0.objective = 0;

    if(isDefined(var_0.carryflag)) {
      var_0 detachflag();
    }
  }

  maps\mp\_utility::leaderdialog("flag_dropped", var_1, "status");
  maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_sml", var_1);
  maps\mp\_utility::leaderdialog("enemy_flag_dropped", var_2, "status");
  maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_sml", var_2);
  thread flageffects();
  thread returnaftertime();
}

returnaftertime() {
  self endon("picked_up");
  self endon("reset");
  wait(level.flagreturntime);
  var_0 = maps\mp\gametypes\_gameobjects::getownerteam();
  var_1 = level.otherteam[var_0];
  maps\mp\_utility::leaderdialog("flag_returned", var_0, "status");
  maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_med", var_0);
  maps\mp\_utility::leaderdialog("enemy_flag_returned", var_1, "status");
  maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_med", var_1);
  thread returnflag();
}

onreset() {
  var_0 = maps\mp\gametypes\_gameobjects::getownerteam();
  var_1 = level.otherteam[var_0];
  maps\mp\gametypes\_gameobjects::allowcarry("enemy");
  maps\mp\gametypes\_gameobjects::setvisibleteam("none");
  maps\mp\gametypes\_gameobjects::set2dicon("enemy", level.iconescort2d);
  maps\mp\gametypes\_gameobjects::set3dicon("enemy", level.iconescort3d);

  if(level.pingstate != 2) {
    maps\mp\gametypes\_gameobjects::set2dicon("friendly", level.iconkill2d);
    maps\mp\gametypes\_gameobjects::set3dicon("friendly", level.iconkill3d);
  } else {
    maps\mp\gametypes\_gameobjects::set2dicon("friendly", undefined);
    maps\mp\gametypes\_gameobjects::set3dicon("friendly", undefined);
  }

  thread flageffects();
  onresetflaghudstatus(var_0);
  level.capzones[var_0] maps\mp\gametypes\_gameobjects::allowuse("friendly");
  level.capzones[var_0] maps\mp\gametypes\_gameobjects::setvisibleteam("any");
  level.capzones[var_0] maps\mp\gametypes\_gameobjects::set2dicon("friendly", level.icondefendflag2d);
  level.capzones[var_0] maps\mp\gametypes\_gameobjects::set3dicon("friendly", level.icondefendflag3d);
  level.capzones[var_0] maps\mp\gametypes\_gameobjects::set2dicon("enemy", level.iconcaptureflag2d);
  level.capzones[var_0] maps\mp\gametypes\_gameobjects::set3dicon("enemy", level.iconcaptureflag3d);

  if(var_0 == "allies") {
    level.capzones[var_0] maps\mp\gametypes\_gameobjects::set2dicon("mlg", undefined);
    level.capzones[var_0] maps\mp\gametypes\_gameobjects::set3dicon("mlg", undefined);
    maps\mp\gametypes\_gameobjects::set2dicon("mlg", level.iconatbaseblue);
    maps\mp\gametypes\_gameobjects::set3dicon("mlg", level.iconatbaseblue);
    setomnvar("ui_mlg_game_mode_status_1", 0);
  } else {
    level.capzones[var_0] maps\mp\gametypes\_gameobjects::set2dicon("mlg", undefined);
    level.capzones[var_0] maps\mp\gametypes\_gameobjects::set3dicon("mlg", undefined);
    maps\mp\gametypes\_gameobjects::set2dicon("mlg", level.iconatbasered);
    maps\mp\gametypes\_gameobjects::set3dicon("mlg", level.iconatbasered);
    setomnvar("ui_mlg_game_mode_status_2", 0);
  }
}

onuse(var_0) {
  var_1 = var_0.pers["team"];

  if(var_1 == "allies") {
    var_2 = "axis";
  } else {
    var_2 = "allies";
  }

  maps\mp\_utility::leaderdialog("enemy_flag_captured", var_1, "status");
  maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_lrg", var_1);
  maps\mp\_utility::leaderdialog("flag_captured", var_2, "status");
  maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_lrg", var_2);
  var_0 thread maps\mp\_events::flagcaptureevent();
  maps\mp\gametypes\_gamescore::giveteamscoreforobjective(var_1, 1);
  game["shut_out"][var_2] = 0;

  if(isDefined(var_0)) {
    var_0.objective = 0;

    if(isDefined(var_0.carryflag)) {
      var_0 detachflag();
    }
  }

  if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[var_1])) {
    var_0 thread removeflagcarrierclass();
  }

  level.teamflags[var_2] returnflag();

  if(maps\mp\gametypes\_gameobjects::getownerteam() == "allies") {
    setomnvar("ui_mlg_game_mode_status_1", 0);
  } else {
    setomnvar("ui_mlg_game_mode_status_2", 0);
  }

  level thread checkroundwin(var_1);
}

checkroundwin(var_0) {
  var_1 = "roundsWon";

  if(level.winbycaptures) {
    var_1 = "teamScores";
  }

  if(maps\mp\_utility::inovertime()) {
    updateroundswon(var_0);

    if(game["status"] == "overtime") {
      game["round_time_to_beat"] = maps\mp\_utility::getminutespassed();
      level thread maps\mp\gametypes\_gamelogic::endgame("overtime_halftime", game["end_reason"]["score_limit_reached"]);
    } else if(game["status"] == "overtime_halftime") {
      if(game["roundsWon"]["axis"] == game["roundsWon"]["allies"]) {
        updateroundswon(var_0);
      }

      if(game["teamScores"]["axis"] == game["teamScores"]["allies"]) {
        game["teamScores"][var_0]++;
      }

      level thread maps\mp\gametypes\_gamelogic::endgame(var_0, game["end_reason"]["score_limit_reached"]);
    }
  } else if(game["teamScores"][var_0] == maps\mp\_utility::getwatcheddvar("scorelimit")) {
    updateroundswon(var_0);

    if(game["status"] == "normal") {
      game["roundMillisecondsAlreadyPassed"] = maps\mp\_utility::gettimepassed();
      level thread maps\mp\gametypes\_gamelogic::endgame("halftime", game["end_reason"]["score_limit_reached"]);
    } else if(game["status"] == "halftime") {
      var_2 = var_0;

      if(game[var_1]["axis"] == game[var_1]["allies"]) {
        var_2 = "overtime";
        level.finalkillcam_winner = "none";
      }

      level thread maps\mp\gametypes\_gamelogic::endgame(var_2, game["end_reason"]["switching_sides"]);
    }
  }
}

updateroundswon(var_0) {
  level.finalkillcam_winner = var_0;
  game["roundsWon"][var_0]++;
}

onhalftime(var_0) {
  ontimelimit();
}

ontimelimit() {
  level.finalkillcam_winner = "none";
  var_0 = "roundsWon";

  if(level.winbycaptures) {
    var_0 = "teamScores";
  }

  if(maps\mp\_utility::inovertime()) {
    if(game["status"] == "overtime") {
      level thread maps\mp\gametypes\_gamelogic::endgame("overtime_halftime", game["end_reason"]["time_limit_reached"]);
    } else if(game["status"] == "overtime_halftime") {
      var_1 = "tie";

      if(game[var_0]["axis"] > game[var_0]["allies"]) {
        var_1 = "axis";
      }

      if(game[var_0]["allies"] > game[var_0]["axis"]) {
        var_1 = "allies";
      }

      level thread maps\mp\gametypes\_gamelogic::endgame(var_1, game["end_reason"]["time_limit_reached"]);
    }
  } else if(game["status"] == "halftime") {
    var_1 = "tie";

    if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      var_1 = "axis";
    }

    if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
      var_1 = "allies";
    }

    if(var_1 == "axis" || var_1 == "allies") {
      updateroundswon(var_1);
    }

    if(game[var_0]["axis"] == game[var_0]["allies"]) {
      var_1 = "overtime";
    }

    level thread maps\mp\gametypes\_gamelogic::endgame(var_1, game["end_reason"]["time_limit_reached"]);
  } else {
    if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      updateroundswon("axis");
    }

    if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
      updateroundswon("allies");
    }

    level thread maps\mp\gametypes\_gamelogic::endgame("halftime", game["end_reason"]["time_limit_reached"]);
  }
}

applyflagcarrierclass(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    wait 0.05;
  }

  if(maps\mp\_utility::isjuggernaut()) {
    self notify("lost_juggernaut");
    wait 0.05;
  }

  self.pers["gamemodeLoadout"] = level.ctf_loadouts[self.team];
  self.gamemode_chosenclass = self.class;
  self.gamemode_carrierclass = 1;
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "gamemode";
  self.class = "gamemode";
  self.lastclass = "gamemode";
  self notify("faux_spawn");
  maps\mp\gametypes\_class::giveandapplyloadout(self.team, "gamemode");

  if(self.loadoutkeepcurrentkillstreaks) {
    maps\mp\killstreaks\_killstreaks::updatekillstreaks(1);
  }

  refillbattery();
  thread waitattachflag(var_0);
}

refillbattery() {
  var_0 = self getweaponslistoffhands();

  foreach(var_2 in var_0) {
    self batteryfullrecharge(var_2);
  }
}

waitattachflag(var_0) {
  level endon("game_ende");
  self endon("disconnect");
  self endon("death");
  self waittill("spawned_player");
  attachflag(var_0);
}

removeflagcarrierclass() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    wait 0.05;
  }

  if(maps\mp\_utility::isjuggernaut()) {
    self notify("lost_juggernaut");
    wait 0.05;
  }

  self.pers["gamemodeLoadout"] = undefined;
  self notify("faux_spawn");
  maps\mp\gametypes\_class::giveandapplyloadout(self.team, self.class);

  if(self.loadoutkeepcurrentkillstreaks) {
    maps\mp\killstreaks\_killstreaks::updatekillstreaks(1);
  }

  refillbattery();
}

oncantuse(var_0) {}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isplayer(var_1) && var_1.pers["team"] != self.pers["team"]) {
    if(isDefined(var_1.carryflag)) {
      var_1 thread maps\mp\_events::killwithflagevent();
    }

    if(isDefined(self.carryflag)) {
      var_1 thread maps\mp\_events::killflagcarrierevent(var_9);
      detachflag();
      return;
    }

    if(isDefined(var_4) && maps\mp\_utility::iskillstreakweapon(var_4)) {
      return;
    }
    var_10 = 9216;

    foreach(var_12 in level.capzones) {
      var_13 = distance2dsquared(var_1.origin, var_12.curorigin);
      var_14 = distance2dsquared(self.origin, var_12.curorigin);

      if(var_12.ownerteam == var_1.team) {
        if(var_13 < var_10 || var_14 < var_10) {
          var_1 thread maps\mp\_events::defendobjectiveevent(self, var_9);
          var_1 maps\mp\_utility::setextrascore1(var_1.pers["defends"]);
        }
      }

      if(var_12.ownerteam == self.team) {
        if(var_13 < var_10 || var_14 < var_10) {
          var_1 thread maps\mp\_events::assaultobjectiveevent(self, var_9);
        }
      }
    }
  } else if(isDefined(self.carryflag)) {
    detachflag();
  }
}

attachflag(var_0) {
  var_1 = level.otherteam[self.pers["team"]];
  self attach(level.carryflag[var_1], "J_SpineUpper", 1);
  self.carryflag = level.carryflag[var_1];
  var_0 thread flageffects();
}

goliathattachflag() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("lost_ctf_flag");
  self waittill("goliath_equipped");
  wait 1.0;

  if(isDefined(self.carryflag)) {
    self attach(self.carryflag, "J_SpineUpper", 1);
  }

  if(isDefined(self.carryobject)) {
    self.carryobject thread flageffects();
  }
}

canuse(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 maps\mp\_utility::isjuggernaut()) {
    return 0;
  }

  if(isDefined(var_0.enteringgoliath) && var_0.enteringgoliath == 1) {
    return 0;
  }

  return 1;
}

goliathdropflag() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self waittill("goliath_equipped");

  if(isDefined(self.carryobject)) {
    self.carryflag = undefined;
    self.carryobject thread maps\mp\gametypes\_gameobjects::setdropped();
  }
}

detachflag() {
  self notify("lost_ctf_flag");
  var_0 = "J_SpineUpper";
  self detach(self.carryflag, var_0);
  self.carryflag = undefined;
}

setspecialloadouts() {
  if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses", "axis", 5, "class", "inUse")) {
    level.ctf_loadouts["axis"] = maps\mp\_utility::getmatchrulesspecialclass("axis", 5);
  }

  if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses", "allies", 5, "class", "inUse")) {
    level.ctf_loadouts["allies"] = maps\mp\_utility::getmatchrulesspecialclass("allies", 5);
  }
}

assignteamspawns() {
  var_0 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_ctf_spawn");
  level.teamspawnpoints["axis"] = [];
  level.teamspawnpoints["allies"] = [];

  foreach(var_2 in var_0) {
    var_2.teambase = getnearestflagteam(var_2);

    if(var_2.teambase == "axis") {
      level.teamspawnpoints["axis"][level.teamspawnpoints["axis"].size] = var_2;
      continue;
    }

    level.teamspawnpoints["allies"][level.teamspawnpoints["allies"].size] = var_2;
  }
}

reassign_ctf_team_spawns() {
  var_0 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_ctf_spawn");
  level.teamspawnpoints["axis"] = [];
  level.teamspawnpoints["allies"] = [];

  foreach(var_2 in var_0) {
    var_2.teambase = get_nearest_capzone_team(var_2);

    if(var_2.teambase == "axis") {
      level.teamspawnpoints["axis"][level.teamspawnpoints["axis"].size] = var_2;
      continue;
    }

    level.teamspawnpoints["allies"][level.teamspawnpoints["allies"].size] = var_2;
  }
}

get_nearest_capzone_team(var_0) {
  var_1 = maps\mp\gametypes\_spawnlogic::ispathdataavailable();
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in level.capzones) {
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

getnearestflagteam(var_0) {
  var_1 = maps\mp\gametypes\_spawnlogic::ispathdataavailable();
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  if(var_1) {
    var_3 = getpathdist(var_0.origin, level.teamflags["allies"].origin, 999999);
    var_4 = getpathdist(var_0.origin, level.teamflags["axis"].origin, 999999);
  }

  if(!isDefined(var_3) || var_3 == -1) {
    var_3 = distancesquared(level.teamflags["allies"].origin, var_0.origin);
  }

  if(!isDefined(var_4) || var_4 == -1) {
    var_4 = distancesquared(level.teamflags["axis"].origin, var_0.origin);
  }

  if(isDefined(var_0.script_noteworthy)) {
    if(game["switchedsides"] && var_0.script_noteworthy == "axis_override" || !game["switchedsides"] && var_0.script_noteworthy == "allies_override") {
      var_2 = "allies";
      var_0.friendlyflag = level.teamflags["allies"];
      var_0.friendlyflagdist = var_3;
      var_0.enemyflagdist = var_4;
    } else if(game["switchedsides"] && var_0.script_noteworthy == "allies_override" || !game["switchedsides"] && var_0.script_noteworthy == "axis_override") {
      var_2 = "axis";
      var_0.friendlyflag = level.teamflags["axis"];
      var_0.friendlyflagdist = var_4;
      var_0.enemyflagdist = var_3;
    }
  }

  if(!isDefined(var_2)) {
    var_2 = common_scripts\utility::ter_op(var_3 < var_4, "allies", "axis");
    var_0.friendlyflag = common_scripts\utility::ter_op(var_3 < var_4, level.teamflags["allies"], level.teamflags["axis"]);
    var_0.friendlyflagdist = common_scripts\utility::ter_op(var_3 < var_4, var_3, var_4);
    var_0.enemyflagdist = common_scripts\utility::ter_op(var_3 > var_4, var_3, var_4);
  }

  var_5 = var_0.friendlyflagdist / var_0.enemyflagdist;

  if(var_0.friendlyflag.highestspawndistratio < var_5) {
    var_0.friendlyflag.highestspawndistratio = var_5;
  }

  return var_2;
}

flageffectsstop() {
  friendlyenemyeffectsstop();
}

flageffects() {
  waittillframeend;

  if(isDefined(self.carrier)) {
    friendlyenemylinkedeffects(level.flagstowedfxid, self.carrier, "tag_fx_flag");
  } else {
    var_0 = self.visuals[0];
    friendlyenemyeffects(level.flaggroundfxid, var_0.origin, anglestoup(var_0.angles));
  }
}

capturezoneeffects() {
  waittillframeend;
  friendlyenemyeffects(level.flagbasefxid, self.baseeffectpos, self.baseeffectforward);
}

friendlyenemyeffectsstop() {
  if(isDefined(self.friendlyfx)) {
    self.friendlyfx delete();
  }

  if(isDefined(self.enemyfx)) {
    self.enemyfx delete();
  }
}

friendlyenemylinkedeffects(var_0, var_1, var_2) {
  var_3 = self.ownerteam;
  var_4 = var_0[game[var_3]]["friendly"];
  var_5 = var_0[game[var_3]]["enemy"];
  friendlyenemyeffectsstop();
  self.friendlyfx = spawnlinkedfxshowtoteam(var_4, var_3, var_1, var_2);
  self.enemyfx = spawnlinkedfxshowtoteam(var_5, maps\mp\_utility::getotherteam(var_3), var_1, var_2);
}

friendlyenemyeffects(var_0, var_1, var_2) {
  var_3 = self.ownerteam;
  var_4 = var_0[game[var_3]]["friendly"];
  var_5 = var_0[game[var_3]]["enemy"];
  friendlyenemyeffectsstop();
  self.friendlyfx = maps\mp\_utility::spawnfxshowtoteam(var_4, var_3, var_1, var_2);
  self.enemyfx = maps\mp\_utility::spawnfxshowtoteam(var_5, maps\mp\_utility::getotherteam(var_3), var_1, var_2);
}

spawnlinkedfxshowtoteam(var_0, var_1, var_2, var_3) {
  var_4 = spawnlinkedfx(var_0, var_2, var_3);
  var_4 maps\mp\_utility::fxshowtoteam(var_1);
  return var_4;
}

capturezone_reset_base_effects() {
  foreach(var_1 in level.teamflags) {
    if(var_1.visuals.size) {
      var_2 = var_1.visuals[0].origin + (0, 0, 32);
      var_3 = var_1.visuals[0].origin + (0, 0, -32);
      var_4 = bulletTrace(var_2, var_3, 0, undefined);
      var_5 = vectortoangles(var_4["normal"]);
      var_1.baseeffectforward = anglesToForward(var_5);
      var_1.baseeffectpos = var_4["position"];
      var_1 thread flageffects();
      var_6 = level.capzones[var_1.ownerteam];
      var_6.baseeffectforward = var_1.baseeffectforward;
      var_6.baseeffectpos = var_1.baseeffectpos;
      var_6 thread capturezoneeffects();
    }
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread playerwatchflagstatus();
  }
}