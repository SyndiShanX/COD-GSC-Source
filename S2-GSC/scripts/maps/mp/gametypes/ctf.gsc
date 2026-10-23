/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\ctf.gsc
*********************************************/

main() {
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();

  if(_isusingmatchrulesdata()) {
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
  level.thermalvisionon = 1;
  maps\mp\_utility::_id_873B(1);
  level.objectivebased = 1;
  level.overtimescorewinoverride = 1;
  level.onlyroundoverride = 1;
  level.pingstate = maps\mp\_utility::getintproperty("scr_ping_carrier", 1);
  level.winbycaptures = maps\mp\_utility::getintproperty("scr_ctf_win_by_captures", 0);
  level.onstartgametype = ::onstartgametype;
  level._id_6B7B = ::_id_6B7B;
  level.ontimelimit = ::ontimelimit;
  level.onhalftime = ::onhalftime;

  if(!isDefined(game["shut_out"])) {
    game["shut_out"]["axis"] = 1;
    game["shut_out"]["allies"] = 1;
  }

  if(level.winbycaptures) {
    _setdynamicdvar("scr_ctf_scorelimit", 0);
  }

  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
  }

  level.flagreturntime = maps\mp\_utility::getintproperty("scr_ctf_returntime", 30);
  game["dialog"]["gametype"] = "ctf_intro";

  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "dom_start";
  game["dialog"]["defense_obj"] = "dom_start";
  thread onplayerconnect();

  if(!isDefined(game["allies_side_caps"])) {
    game["allies_side_caps"] = 0;
  }

  if(!isDefined(game["axis_side_caps"])) {
    game["axis_side_caps"] = 0;
  }

  if(!isDefined(game["allies_side_pickups"])) {
    game["allies_side_pickups"] = 0;
  }

  if(!isDefined(game["axis_side_pickups"])) {
    game["axis_side_pickups"] = 0;
  }
}

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata();
  _setdynamicdvar("scr_ctf_roundlimit", 2);
  maps\mp\_utility::registerroundlimitdvar("ctf", 1);
  _setdynamicdvar("scr_ctf_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("ctf", 1);
  _setdynamicdvar("scr_ctf_halftime", 1);
  maps\mp\_utility::registerhalftimedvar("ctf", 1);
  _setdynamicdvar("scr_ctf_returntime", _getmatchrulesdata("ctfData", "returnTime"));
  _setdynamicdvar("scr_ping_carrier", _getmatchrulesdata("ctfData", "enemyCarrierIcon"));
  _setdynamicdvar("scr_ctf_win_by_captures", _getmatchrulesdata("ctfData", "winByCaptures"));
  _setdynamicdvar("scr_ctf_flag_pick_up_time_friendly", _getmatchrulesdata("ctfData", "pickupTime"));
  _setdynamicdvar("scr_ctf_flag_pick_up_time_enemy", _getmatchrulesdata("ctfData", "pickupTime"));
  _setdynamicdvar("scr_ctf_extratime", _getmatchrulesdata("ctfData", "extraTime"));
}

onstartgametype() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(maps\mp\_utility::isovertimetext(game["status"])) {
    game["switchedsides"] = !game["switchedsides"];
  }

  if(game["status"] == "halftime") {
    _setomnvar("ui_current_round", 2);
  } else if(game["status"] == "overtime") {
    _setomnvar("ui_current_round", 3);
  } else if(game["status"] == "overtime_halftime") {
    _setomnvar("ui_current_round", 4);
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
    _setteamscore(game["attackers"], 0);
    game["teamScores"][game["defenders"]] = 0;
    _setteamscore(game["defenders"], 0);
  }

  _setclientnamemode("auto_change");
  var_2 = _getmapcustom("allieschar");

  if(!isDefined(var_2) || var_2 == "") {
    var_2 = "allies";
  }

  var_3 = _getmapcustom("axischar");

  if(!isDefined(var_3) || var_3 == "") {
    var_3 = "axis";
  }

  level._id_3CB5[var_2][0] = loadfx("vfx/unique/vfx_marker_ctf_allies_red");
  level._id_3CB5[var_2][1] = loadfx("vfx/unique/vfx_marker_ctf_allies_red");
  level._id_3CB5[var_2][2] = loadfx("vfx/unique/vfx_marker_ctf_allies_blue");
  level._id_3CB5[var_2][3] = loadfx("vfx/unique/vfx_marker_ctf_allies_blue");
  level._id_3CB5[var_2][4] = loadfx("vfx/unique/vfx_marker_ctf_allies_red");
  level._id_3CB5[var_3][0] = loadfx("vfx/unique/vfx_marker_ctf_axis_red");
  level._id_3CB5[var_3][1] = loadfx("vfx/unique/vfx_marker_ctf_axis_red");
  level._id_3CB5[var_3][2] = loadfx("vfx/unique/vfx_marker_ctf_axis_blue");
  level._id_3CB5[var_3][3] = loadfx("vfx/unique/vfx_marker_ctf_axis_blue");
  level._id_3CB5[var_3][4] = loadfx("vfx/unique/vfx_marker_ctf_axis_red");

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
  var_4[0] = "ctf";
  var_4[1] = "blocker_ctf";
  _id_04D1::main(var_4);
  level._id_3992 = maps\mp\_utility::dvarintvalue("extraTime", maps\mp\_utility::getintproperty("scr_ctf_extratime", 1), 0, 3);
  level._id_289F = 0;
  level thread ctf();
  level thread updatescoreboardctf();
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
  self._id_0021 = self.pers["returns"];
}

updatedefends() {
  waittillframeend;
  maps\mp\_utility::setextrascore1(self.pers["defends"]);
}

ctf() {
  level.flagmodel["allies"]["allies"] = "usa_ctf_flag_physics_placed";
  level.flagmodel["allies"]["axis"] = "usa_ctf_flag_physics_placed_red";
  level.carryflag["allies"]["allies"] = spawn("script_model", (0, 0, 0));
  level.carryflag["allies"]["allies"] setModel("usa_ctf_flag_physics_attach");
  level.carryflag["allies"]["axis"] = spawn("script_model", (0, 0, 0));
  level.carryflag["allies"]["axis"] setModel("usa_ctf_flag_physics_attach_red");
  level.carryflag["allies"]["allies"] hide();
  level.carryflag["allies"]["axis"] hide();
  level.flagmodel["axis"]["axis"] = "ger_ctf_flag_physics_placed_blue";
  level.flagmodel["axis"]["allies"] = "ger_ctf_flag_physics_placed";
  level.carryflag["axis"]["axis"] = spawn("script_model", (0, 0, 0));
  level.carryflag["axis"]["axis"] setModel("ger_ctf_flag_physics_attach_blue");
  level.carryflag["axis"]["allies"] = spawn("script_model", (0, 0, 0));
  level.carryflag["axis"]["allies"] setModel("ger_ctf_flag_physics_attach");
  level.carryflag["axis"]["axis"] hide();
  level.carryflag["axis"]["allies"] hide();
  level.iconescort3d = "waypoint_escort_flag";
  level.iconescort2d = "waypoint_escort_flag";
  level.iconkill3d = "waypoint_kill";
  level.iconkill2d = "waypoint_kill";
  level._id_4FFC = "waypoint_allies_flag_friendly";
  level._id_4FFB = "waypoint_allies_flag_friendly";
  level._id_4FFA = "waypoint_allies_flag_enemy";
  level._id_4FF9 = "waypoint_allies_flag_enemy";
  level._id_5002 = "waypoint_axis_flag_friendly";
  level._id_5001 = "waypoint_axis_flag_friendly";
  level._id_5000 = "waypoint_axis_flag_enemy";
  level._id_4FFF = "waypoint_axis_flag_enemy";
  level.iconreturnflag3d = "waypoint_return_flag";
  level.iconreturnflag2d = "waypoint_return_flag";
  level.iconwaitforflag3d = "waypoint_waitfor_flag";
  level.iconwaitforflag2d = "waypoint_waitfor_flag";
  level._id_4FFE = "waypoint_caster_flag_taken";
  level._id_500E = "waypoint_caster_flag_dropped";
  level._id_4FFD = "waypoint_caster_flag";
  level._id_5018 = "waypoint_caster_flag_missing";
  level.teamflags[game["defenders"]] = createteamflag(game["defenders"], level.otherteam["allies"]);
  level.teamflags[game["attackers"]] = createteamflag(game["attackers"], "allies");
  level.capzones[game["defenders"]] = createcapzone(game["defenders"], level.otherteam["allies"]);
  level.capzones[game["attackers"]] = createcapzone(game["attackers"], "allies");
  level.capzones["allies"].ground_origin = level.capzones["allies"].curorigin;
  level.capzones["axis"].ground_origin = level.capzones["axis"].curorigin;
  _id_050D::_id_10E4();
  _id_050D::_id_908D(level.capzones["allies"], level.capzones["axis"]);
  level thread _id_289C();
  onresetflaghudstatus("allies");
  onresetflaghudstatus("axis");
}

_id_289C() {
  level endon("game_ended");
  var_0 = level.teamflags["allies"];
  var_1 = level.teamflags["axis"];

  for(;;) {
    var_2 = gettime();
    var_3 = var_0.carrier;
    var_4 = var_1.carrier;
    var_5 = undefined;
    var_6 = undefined;

    if(!isDefined(var_3)) {
      var_7 = "none";
      var_5 = var_0.origin;
    } else {
      var_7 = var_3.name;
      var_5 = var_3.origin;
    }

    if(!isDefined(var_4)) {
      var_8 = "none";
      var_6 = var_1.origin;
    } else {
      var_8 = var_4.name;
      var_6 = var_4.origin;
    }

    _reconevent("script_mp_ctf: gameTime %d, allies_flag_loc %v, axis_flag_loc %v, allies_carrier %s, axis_carrier %s", var_2, var_5, var_6, var_7, var_8);
    wait 0.2;
  }
}

onresetflaghudstatus(var_0) {
  if(var_0 == "allies") {
    level._id_0BF7 = 0;
    level._id_0BF6 = -1;
  } else {
    level.axisflagstatus = 0;
    level.axisflagcarrierclientnum = -1;
  }

  level notify("update_flag_status");
}

onpickupflaghudstatus(var_0) {
  var_1 = var_0.pers["team"];

  if(var_1 == "allies") {
    var_0._id_0112 = 1;
    level.axisflagstatus = 2;
    level.axisflagcarrierclientnum = var_0 getentitynumber();
  } else {
    var_0._id_0112 = 2;
    level._id_0BF7 = 2;
    level._id_0BF6 = var_0 getentitynumber();
  }

  level notify("update_flag_status");
}

ondropflaghudstatus(var_0) {
  if(var_0 == "allies") {
    level._id_0BF7 = 1;
    level._id_0BF6 = -1;
  } else {
    level.axisflagstatus = 1;
    level.axisflagcarrierclientnum = -1;
  }

  level notify("update_flag_status");
}

playerupdateflagstatus() {
  if(!isDefined(self.team) || !isDefined(level._id_0BF7)) {
    return;
  }
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  _setomnvar("ui_broadcaster_ctf_allies_status", level._id_0BF7);
  _setomnvar("ui_broadcaster_ctf_allies_carrier_clientnum", level._id_0BF6);
  _setomnvar("ui_broadcaster_ctf_axis_status", level.axisflagstatus);
  _setomnvar("ui_broadcaster_ctf_axis_carrier_clientnum", level.axisflagcarrierclientnum);

  if(self.team == "allies" || self.team == "spectator") {
    var_0 = level._id_0BF7;
    var_1 = level._id_0BF6;
    var_2 = level.axisflagstatus;
    var_3 = level.axisflagcarrierclientnum;
  } else if(self.team == "axis") {
    var_0 = level.axisflagstatus;
    var_1 = level.axisflagcarrierclientnum;
    var_2 = level._id_0BF7;
    var_3 = level._id_0BF6;
  } else
    return;

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
    common_scripts\utility::waittill_any_ents(level, "update_flag_status", self, "spawned_player");
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
  var_2 = _getEnt("ctf_zone_" + var_1, "targetname");

  if(!isDefined(var_2)) {
    common_scripts\utility::error("No ctf_zone_" + var_1 + " trigger found in map.");
  } else {
    var_3[0] = _getEnt("ctf_flag_" + var_1, "targetname");

    if(!isDefined(var_3[0])) {
      common_scripts\utility::error("No ctf_flag_" + var_1 + " script_model found in map.");
      return;
    }

    var_4 = (0, 0, 0);

    if(var_1 == "allies") {
      if(isDefined(level.allies_ctf_flag_offset)) {
        var_4 = level.allies_ctf_flag_offset;
      }
    } else if(var_1 == "axis") {
      if(isDefined(level.axis_ctf_flag_offset)) {
        var_4 = level.axis_ctf_flag_offset;
      }
    }

    var_5 = spawn("trigger_radius", var_2.origin + var_4, 0, 32, var_2._id_00BD);
    var_2 = var_5;
    var_3[0] setModel(level.flagmodel[var_0][var_0]);
    var_3[0].oldcontents = var_3[0] _meth_80B1();
    var_3[1] = spawn("script_model", var_3[0].origin);
    var_3[1] setModel(level.flagmodel[var_0][maps\mp\_utility::getotherteam(var_0)]);
    var_3[1].oldcontents = var_3[1] _meth_80B1();
    var_6 = var_3[0].origin + (0, 0, 32) + var_4;
    var_7 = var_3[0].origin + (0, 0, -32) + var_4;
    var_8 = bulletTrace(var_6, var_7, 0, undefined);
    var_3[0].origin = var_8["position"];
    var_3[1].origin = var_8["position"];
    var_3[1].angles = var_3[0].angles;
    var_9 = _id_04D1::createcarryobject(var_0, var_2, var_3, (0, 0, 85), 1, 0, 1);
    var_9 thread _id_8BF8(var_0);
    var_10 = getdvarfloat("scr_ctf_flag_pick_up_time_friendly", 0.0);

    if(var_10 > 0) {
      var_9 _id_04D1::setteamusetime("friendly", var_10);
    }

    var_11 = getdvarfloat("scr_ctf_flag_pick_up_time_enemy", 0.0);

    if(var_11 > 0) {
      var_9 _id_04D1::setteamusetime("enemy", var_11);
    }

    var_9 _id_04D1::setteamusetext("enemy", &"MP_GRABBING_FLAG");
    var_9 _id_04D1::setteamusetext("friendly", &"MP_RETURNING_FLAG");
    var_9 _id_04D1::_id_0C1D("enemy");
    var_9 _id_04D1::setvisibleteam("none");
    var_9 _id_04D1::set2dicon("enemy", level.iconescort2d);
    var_9 _id_04D1::playsoundtoteam("enemy", level.iconescort3d, undefined, 1);

    if(level.pingstate != 2) {
      var_9 _id_04D1::set2dicon("friendly", level.iconkill2d);
      var_9 _id_04D1::playsoundtoteam("friendly", level.iconkill3d, undefined, 1);
    } else {
      var_9 _id_04D1::set2dicon("friendly", undefined);
      var_9 _id_04D1::playsoundtoteam("friendly", undefined);
    }

    var_9.objidpingfriendly = 1;
    var_9._id_0C33 = 1;
    var_9.requireslos = 1;
    var_9.onpickup = ::onpickup;
    var_9.onpickupfailed = ::onpickup;
    var_9._id_6AEF = ::_id_6AEF;
    var_9.onreset = ::onreset;
    var_9.oldradius = var_2.radius;
    var_9.origin = var_2.origin;

    if(level.pingstate == 0) {
      var_9.objidpingfriendly = 0;
    }

    if(var_0 == "axis") {
      maps\mp\_utility::_id_863F(var_9, level._id_4FFD, 1, 1);
      _setomnvar("ui_broadcaster_game_mode_status_1", 0);
    } else {
      maps\mp\_utility::_id_863F(var_9, level._id_4FFD, 2, 1);
      _setomnvar("ui_broadcaster_game_mode_status_2", 0);
    }
  }
}

createcapzone(var_0, var_1) {
  var_2 = _getEnt("ctf_zone_" + var_1, "targetname");
  var_3 = (0, 0, 0);

  if(var_1 == "allies") {
    if(isDefined(level.allies_ctf_flag_offset)) {
      var_3 = level.allies_ctf_flag_offset;
    }
  } else if(var_1 == "axis") {
    if(isDefined(level.axis_ctf_flag_offset)) {
      var_3 = level.axis_ctf_flag_offset;
    }
  }

  var_4 = spawn("trigger_radius", var_2.origin + var_3, 0, 32, var_2._id_00BD);
  var_2 = var_4;
  var_5 = [];
  var_6 = _id_04D1::createuseobject(var_0, var_2, var_5, (0, 0, 85));
  var_6 _id_04D1::_id_0C30("friendly");
  var_6 _id_04D1::setvisibleteam("any");
  var_6 _id_04D1::set2dicon("friendly", level.icondefendflag2d);
  var_6 _id_04D1::playsoundtoteam("friendly", level.icondefendflag3d, undefined, 1);
  var_6 _id_04D1::set2dicon("enemy", level.iconcaptureflag2d);
  var_6 _id_04D1::playsoundtoteam("enemy", level._id_5006, undefined, 1);

  if(var_0 == "allies") {
    var_6 _id_04D1::set2dicon("friendly", level._id_4FFB);
    var_6 _id_04D1::playsoundtoteam("friendly", level._id_4FFC, undefined, 1);
    var_6 _id_04D1::set2dicon("enemy", level._id_4FF9);
    var_6 _id_04D1::playsoundtoteam("enemy", level._id_4FFA, undefined, 1);
  } else {
    var_6 _id_04D1::set2dicon("friendly", level._id_5001);
    var_6 _id_04D1::playsoundtoteam("friendly", level._id_5002, undefined, 1);
    var_6 _id_04D1::set2dicon("enemy", level._id_4FFF);
    var_6 _id_04D1::playsoundtoteam("enemy", level._id_5000, undefined, 1);
  }

  var_6 _id_04D1::setusetime(0);
  var_6 _id_04D1::setkeyobject(level.teamflags[maps\mp\_utility::getotherteam(var_0)]);
  var_6.onuse = ::onuse;
  var_6.oncantuse = ::oncantuse;
  var_7 = var_2.origin + (0, 0, 32);
  var_8 = var_2.origin + (0, 0, -32);
  var_9 = bulletTrace(var_7, var_8, 0, undefined);
  var_6.baseeffectpos = var_9["position"];
  var_6.baseeffectforward = var_9["normal"];
  var_6 thread capturezoneeffects();
  var_6._id_4D3F = 0.0;
  var_6._id_645F = -1;
  return var_6;
}

onbeginuse(var_0) {
  var_1 = var_0.pers["team"];

  if(var_1 == _id_04D1::getownerteam()) {
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

  if(var_1 == _id_04D1::getownerteam()) {
    maps\mp\_utility::_id_863E(11, var_0.team, var_0 getentitynumber());
    thread returnflag(0);
    maps\mp\_utility::leaderdialog("flag_returned", var_1, "status");
    maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_med", var_1);
    maps\mp\_utility::leaderdialog("enemy_flag_returned", var_2, "status");
    maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_med", var_2);
    var_0 thread _id_047A::flagreturnevent();
    onresetflaghudstatus(var_1);
  } else {
    if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[var_1])) {
      var_0 thread _id_0F32(self);
    } else {
      var_0 attachflag(self);
    }

    var_3 = 0;

    if(var_0 maps\mp\_utility::_hasperk("specialty_improvedobjectives")) {
      var_3 = 20;
      self.objpingdelay = 7.5;
    } else
      self.objpingdelay = 5.0;

    if(var_3 > 0) {
      var_0 thread _id_052C::setlightarmor(var_3);
    } else {
      var_0 thread _id_052C::unsetlightarmor();
    }

    maps\mp\_utility::_id_863E(8, var_0.team, var_0 getentitynumber());
    thread bringhomeflagvo(var_0, var_1);
    thread getflagbackvo(var_2);
    onpickupflaghudstatus(var_0);
    _id_04D1::setvisibleteam("any");
    _id_04D1::set2dicon("enemy", level.iconescort2d);
    _id_04D1::playsoundtoteam("enemy", level.iconescort3d, undefined, 1);

    if(level.pingstate != 2) {
      _id_04D1::set2dicon("friendly", level.iconkill2d);
      _id_04D1::playsoundtoteam("friendly", level.iconkill3d, undefined, 1);
    } else {
      _id_04D1::set2dicon("friendly", undefined);
      _id_04D1::playsoundtoteam("friendly", undefined);
    }

    level.capzones[var_2] _id_04D1::_id_0C30("none");
    level.capzones[var_2] _id_04D1::setvisibleteam("friendly");
    level.capzones[var_2] _id_04D1::set2dicon("friendly", level.iconwaitforflag2d);
    level.capzones[var_2] _id_04D1::playsoundtoteam("friendly", level.iconwaitforflag3d, undefined, 1);
    var_4 = [var_0];
    maps\mp\_utility::leaderdialog("enemy_flag_taken", var_1, "status");
    maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_sml", var_1, var_4);
    var_0 playlocalsound("mp_ctf_flag_pickup");
    maps\mp\_utility::leaderdialog("flag_taken", var_2, "status");
    maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_sml", var_2);

    if(_id_04D1::getownerteam() == "axis") {
      maps\mp\_utility::_id_863F(level.capzones[var_2], level._id_5018, 1, 1);
      maps\mp\_utility::_id_863F(self, level._id_4FFE, 1, 1);
      _setomnvar("ui_broadcaster_game_mode_status_1", var_0 getentitynumber());
    } else {
      maps\mp\_utility::_id_863F(level.capzones[var_2], level._id_5018, 2, 1);
      maps\mp\_utility::_id_863F(self, level._id_4FFE, 2, 1);
      _setomnvar("ui_broadcaster_game_mode_status_2", var_0 getentitynumber());
    }

    var_0 _meth_8608(1);
    var_0 thread _id_047A::flagpickupevent();

    if(var_1 == game["attackers"]) {
      game["allies_side_pickups"]++;
    } else if(var_1 == game["defenders"]) {
      game["axis_side_pickups"]++;
    }
  }
}

bringhomeflagvo(var_0, var_1) {
  level endon("game_ended");
  self endon("reset");
  var_0 endon("death");
  var_0 endon("disconnect");

  for(;;) {
    wait 15;

    if(level.teamflags[var_1] _id_04D1::ishome()) {
      var_0 maps\mp\_utility::leaderdialogonplayer("enemy_flag_bringhome", "status");
    }
  }
}

getflagbackvo(var_0) {
  level endon("game_ended");
  self endon("reset");
  var_1 = getflagstatus(var_0);

  if(var_1 == 1) {
    return;
  }
  for(;;) {
    wait 15;
    maps\mp\_utility::leaderdialog("flag_getback", var_0, "status");
  }
}

getflagstatus(var_0) {
  if(var_0 == "allies") {
    return level._id_0BF7;
  }

  if(var_0 == "axis") {
    return level.axisflagstatus;
  }
}

returnflag(var_0) {
  if(!var_0) {
    maps\mp\_utility::_id_863E(11, _id_04D1::getownerteam());
  }

  _id_04D1::returnhome();

  if(level._id_289F) {
    var_1 = getflagstatus("allies");
    var_2 = getflagstatus("axis");

    if(var_1 == 0 && var_2 == 0) {
      ontimelimit();
    }
  }
}

_id_6AEF(var_0) {
  var_1 = _id_04D1::getownerteam();
  var_2 = level.otherteam[var_1];
  _id_04D1::_id_0C1D("any");
  _id_04D1::setvisibleteam("any");
  _id_04D1::set2dicon("friendly", level.iconreturnflag2d);
  _id_04D1::playsoundtoteam("friendly", level.iconreturnflag3d, undefined, 1);

  if(var_1 == "allies") {
    _id_04D1::set2dicon("enemy", level._id_4FF9);
    _id_04D1::playsoundtoteam("enemy", level._id_4FFA, undefined, 1);
  } else {
    _id_04D1::set2dicon("enemy", level._id_4FFF);
    _id_04D1::playsoundtoteam("enemy", level._id_5000, undefined, 1);
  }

  self.visuals[0] _id_8BF9(var_1);
  self.visuals[1] _id_8BF9(maps\mp\_utility::getotherteam(var_1));
  ondropflaghudstatus(var_1);

  if(var_1 == "axis") {
    maps\mp\_utility::_id_863F(self, level._id_500E, 1, 1);
    _setomnvar("ui_broadcaster_game_mode_status_1", 0 - level.flagreturntime);
  } else {
    maps\mp\_utility::_id_863F(self, level._id_500E, 2, 1);
    _setomnvar("ui_broadcaster_game_mode_status_2", 0 - level.flagreturntime);
  }

  if(isDefined(var_0)) {
    var_0._id_0112 = 0;

    if(isDefined(var_0.carryflag)) {
      var_0 detachflag();
    }

    var_0 _meth_8608(0);
    var_0 thread _id_052C::unsetlightarmor();
  }

  maps\mp\_utility::leaderdialog("flag_dropped", var_1, "status");
  maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_sml", var_1);
  maps\mp\_utility::leaderdialog("enemy_flag_dropped", var_2, "status");
  maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_sml", var_2);
  thread _id_7E2C();
}

_id_7E2C() {
  self endon("picked_up");
  self endon("reset");
  wait(level.flagreturntime);
  var_0 = _id_04D1::getownerteam();
  var_1 = level.otherteam[var_0];
  maps\mp\_utility::leaderdialog("flag_returned", var_0, "status");
  maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_med", var_0);
  maps\mp\_utility::leaderdialog("enemy_flag_returned", var_1, "status");
  maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_med", var_1);
  maps\mp\_utility::_id_863E(11, _id_04D1::getownerteam());
  thread returnflag(0);
}

onreset() {
  var_0 = _id_04D1::getownerteam();
  var_1 = level.otherteam[var_0];
  _id_04D1::_id_0C1D("enemy");
  _id_04D1::setvisibleteam("none");
  _id_04D1::set2dicon("enemy", level.iconescort2d);
  _id_04D1::playsoundtoteam("enemy", level.iconescort3d, undefined, 1);

  if(level.pingstate != 2) {
    _id_04D1::set2dicon("friendly", level.iconkill2d);
    _id_04D1::playsoundtoteam("friendly", level.iconkill3d, undefined, 1);
  } else {
    _id_04D1::set2dicon("friendly", undefined);
    _id_04D1::playsoundtoteam("friendly", undefined);
  }

  onresetflaghudstatus(var_0);
  level.capzones[var_0] _id_04D1::_id_0C30("friendly");
  level.capzones[var_0] _id_04D1::setvisibleteam("any");

  if(var_0 == "allies") {
    level.capzones[var_0] _id_04D1::set2dicon("friendly", level._id_4FFB);
    level.capzones[var_0] _id_04D1::playsoundtoteam("friendly", level._id_4FFC, undefined, 1);
    level.capzones[var_0] _id_04D1::set2dicon("enemy", level._id_4FF9);
    level.capzones[var_0] _id_04D1::playsoundtoteam("enemy", level._id_4FFA, undefined, 1);
    maps\mp\_utility::_id_863F(level.capzones[var_0], undefined);
    maps\mp\_utility::_id_863F(self, level._id_4FFD, 2, 1);
    _setomnvar("ui_broadcaster_game_mode_status_1", 0);
  } else {
    level.capzones[var_0] _id_04D1::set2dicon("friendly", level._id_5001);
    level.capzones[var_0] _id_04D1::playsoundtoteam("friendly", level._id_5002, undefined, 1);
    level.capzones[var_0] _id_04D1::set2dicon("enemy", level._id_4FFF);
    level.capzones[var_0] _id_04D1::playsoundtoteam("enemy", level._id_5000, undefined, 1);
    maps\mp\_utility::_id_863F(level.capzones[var_0], undefined);
    maps\mp\_utility::_id_863F(self, level._id_4FFD, 1, 1);
    _setomnvar("ui_broadcaster_game_mode_status_2", 0);
  }

  self.visuals[0] _id_8BF9(var_0);
  self.visuals[1] _id_8BF9(maps\mp\_utility::getotherteam(var_0));
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
  var_0 thread _id_052C::unsetlightarmor();
  var_0 thread _id_047A::flagcaptureevent();
  var_0 notify("ch_capture", self);
  _id_04D2::giveteamscoreforobjective(var_1, 1, 1);

  if(var_1 == game["attackers"]) {
    game["allies_side_caps"]++;
  } else if(var_1 == game["defenders"]) {
    game["axis_side_caps"]++;
  }

  game["shut_out"][var_2] = 0;
  maps\mp\_utility::_id_863E(9, var_1, var_0 getentitynumber());

  if(_id_04D1::getownerteam() == "allies") {
    _setomnvar("ui_broadcaster_game_mode_status_1", 0);
  } else {
    _setomnvar("ui_broadcaster_game_mode_status_2", 0);
  }

  level thread checkroundwin(var_1);

  if(isDefined(var_0)) {
    var_0._id_0112 = 0;

    if(isDefined(var_0.carryflag)) {
      var_0 detachflag();
    }

    var_0 _meth_8608(0);
  }

  if(isDefined(level.ctf_loadouts) && isDefined(level.ctf_loadouts[var_1])) {
    var_0 thread removeflagcarrierclass();
  }

  level.teamflags[var_2] returnflag(1);
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

      if(var_0 == "allies" || var_0 == "axis" || var_0 == "tie") {
        _reconevent("script_mp_ctf_scoring: winner %s, allies_side_pickups %d, allies_side_caps %d, axis_side_pickups %d, axis_side_caps %d, win_type %s", var_0, game["allies_side_pickups"], game["allies_side_caps"], game["axis_side_pickups"], game["axis_side_caps"], game["status"]);
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

      if(var_2 == "allies" || var_2 == "axis") {
        _reconevent("script_mp_ctf_scoring: winner %s, allies_side_pickups %d, allies_side_caps %d, axis_side_pickups %d, axis_side_caps %d, win_type %s", var_2, game["allies_side_pickups"], game["allies_side_caps"], game["axis_side_pickups"], game["axis_side_caps"], game["status"]);
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

      _reconevent("script_mp_ctf_scoring: winner %s, allies_side_pickups %d, allies_side_caps %d, axis_side_pickups %d, axis_side_caps %d, win_type %s", var_1, game["allies_side_pickups"], game["allies_side_caps"], game["axis_side_pickups"], game["axis_side_caps"], game["status"]);
      level thread maps\mp\gametypes\_gamelogic::endgame(var_1, game["end_reason"]["time_limit_reached"]);
    }
  } else if(game["status"] == "halftime") {
    if(level._id_3992 > 0 && level._id_289F == 0) {
      var_2 = 0;
      var_3 = getflagstatus("allies");
      var_4 = getflagstatus("axis");
      var_5 = game[var_0]["allies"];
      var_6 = game[var_0]["axis"];
      var_7 = game["teamScores"]["allies"];
      var_8 = game["teamScores"]["axis"];
      var_9 = var_8 - var_7 <= 1 && var_8 - var_7 >= 0;
      var_10 = var_7 - var_8 <= 1 && var_7 - var_8 >= 0;
      var_11 = var_6 - var_5 <= 1 && var_6 - var_5 >= 0;
      var_12 = var_5 - var_6 <= 1 && var_5 - var_6 >= 0;

      if(var_12 && var_3 != 0 || var_11 && var_4 != 0) {
        if(level.winbycaptures) {
          var_2 = 1;
        } else if(var_10 && var_3 != 0 || var_9 && var_4 != 0) {
          var_2 = 1;
        }
      }

      if(var_2) {
        level._id_289F = 1;

        foreach(var_14 in level.players) {
          var_14 thread maps\mp\gametypes\_hud_message::splashnotify("ctf_extratime");
        }

        return;
      }
    }

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

    if(var_1 == "allies" || var_1 == "axis" || var_1 == "tie") {
      _reconevent("script_mp_ctf_scoring: winner %s, allies_side_pickups %d, allies_side_caps %d, axis_side_pickups %d, axis_side_caps %d, win_type %s", var_1, game["allies_side_pickups"], game["allies_side_caps"], game["axis_side_pickups"], game["axis_side_caps"], game["status"]);
    }

    level thread maps\mp\gametypes\_gamelogic::endgame(var_1, game["end_reason"]["time_limit_reached"]);
  } else {
    if(level._id_3992 > 0 && level._id_289F == 0) {
      var_2 = 0;
      var_3 = getflagstatus("allies");
      var_4 = getflagstatus("axis");
      var_7 = game["teamScores"]["allies"];
      var_8 = game["teamScores"]["axis"];
      var_16 = var_8 - var_7 <= 1 && var_8 - var_7 >= 0;
      var_17 = var_7 - var_8 <= 1 && var_7 - var_8 >= 0;

      if(var_3 != 0 || var_4 != 0) {
        if(level.winbycaptures) {
          var_2 = 1;
        } else if(var_17 && var_3 != 0 || var_16 && var_4 != 0) {
          var_2 = 1;
        }
      }

      if(var_2) {
        level._id_289F = 1;

        foreach(var_14 in level.players) {
          var_14 thread maps\mp\gametypes\_hud_message::splashnotify("ctf_extratime");
        }

        return;
      }
    }

    if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      updateroundswon("axis");
    }

    if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
      updateroundswon("allies");
    }

    level thread maps\mp\gametypes\_gamelogic::endgame("halftime", game["end_reason"]["time_limit_reached"]);
  }
}

_id_0F32(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
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
    _id_051E::updatekillstreaks(1);
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
    waitframe();
  }

  self.pers["gamemodeLoadout"] = undefined;
  self notify("faux_spawn");
  maps\mp\gametypes\_class::giveandapplyloadout(self.team, self.class);

  if(self.loadoutkeepcurrentkillstreaks) {
    _id_051E::updatekillstreaks(1);
  }

  refillbattery();
}

oncantuse(var_0) {}

_id_6B7B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isPlayer(var_1) && var_1.pers["team"] != self.pers["team"]) {
    if(isDefined(var_1.carryflag)) {
      var_1 thread _id_047A::killwithflagevent(var_4);
    }

    if(isDefined(self.carryflag)) {
      var_1 thread _id_047A::killflagcarrierevent(var_9);
      maps\mp\_utility::_id_863E(10, var_1.team, var_1 getentitynumber());
      detachflag();
      self._id_2EF1 = 1;
      return;
    } else
      self._id_2EF1 = 0;

    var_10 = 65536;

    foreach(var_12 in level.capzones) {
      var_13 = _distance2dsquared(var_1.origin, var_12.curorigin);
      var_14 = _distance2dsquared(self.origin, var_12.curorigin);

      if(var_14 < var_10) {
        var_1 thread maps\mp\gametypes\_missions::_id_80BB(var_4, var_3);
      }

      if(var_12.ownerteam == var_1.team) {
        if(var_13 < var_10 || var_14 < var_10) {
          var_1 thread _id_047A::defendobjectiveevent(self, var_9, var_4);
          var_1 maps\mp\_utility::setextrascore1(var_1.pers["defends"]);
          var_1.modifiers["defendObjective"] = var_12;
        }
      }

      if(var_12.ownerteam == self.team) {
        if(var_13 < var_10 || var_14 < var_10) {
          var_1 thread _id_047A::assaultobjectiveevent(self, var_9, var_4);
          var_1.modifiers["assaultObjective"] = var_12;
        }
      }
    }
  } else if(isDefined(self.carryflag))
    detachflag();
}

attachflag(var_0) {
  var_1 = level.otherteam[self.pers["team"]];
  level.carryflag[var_1][self.pers["team"]] linktosynchronizedparent(self, "J_spine4", (0, 0, 0), (0, 0, 0));
  self.carryflag = level.carryflag[var_1][self.pers["team"]];
  level.carryflag[var_1][self.pers["team"]] _id_8BF9(self.pers["team"]);
  level.carryflag[var_1][var_1] linktosynchronizedparent(self, "J_spine4", (0, 0, 0), (0, 0, 0));
  self._id_2014 = level.carryflag[var_1][var_1];
  level.carryflag[var_1][var_1] _id_8BF9(var_1);
  thread _id_2E41(self.carryflag, self._id_2014);
}

detachflag() {
  self notify("lost_ctf_flag");
  self.carryflag unlink();
  self.carryflag hide();
  self.carryflag = undefined;
  self._id_2014 unlink();
  self._id_2014 hide();
  self._id_2014 = undefined;
}

setspecialloadouts() {
  if(_isusingmatchrulesdata() && _getmatchrulesdata("defaultClasses", "axis", "defaultClass", 5, "class", "inUse")) {
    level.ctf_loadouts["axis"] = maps\mp\_utility::getmatchrulesspecialclass("axis", 5);
  }

  if(_isusingmatchrulesdata() && _getmatchrulesdata("defaultClasses", "allies", "defaultClass", 5, "class", "inUse")) {
    level.ctf_loadouts["allies"] = maps\mp\_utility::getmatchrulesspecialclass("allies", 5);
  }
}

capturezoneeffects() {
  waittillframeend;
  friendlyenemyeffects(level._id_3CB5, self.baseeffectpos, self.baseeffectforward);
}

friendlyenemyeffectsstop() {
  if(isDefined(self.friendlyfx)) {
    self.friendlyfx delete();
  }

  if(isDefined(self.enemyfx)) {
    self.enemyfx delete();
  }

  if(isDefined(self._id_1C98)) {
    self._id_1C98 delete();
  }
}

friendlyenemyeffects(var_0, var_1, var_2) {
  var_3 = self.ownerteam;
  var_4 = var_0[game[var_3]][2];
  var_5 = var_0[game[var_3]][0];

  if(game[var_3] == "allies") {
    var_6 = var_0[game[var_3]][3];
  } else {
    var_6 = var_0[game[var_3]][4];
  }

  friendlyenemyeffectsstop();
  self.friendlyfx = maps\mp\_utility::spawnfxshowtoteam(var_4, var_3, var_1, var_2);
  self.enemyfx = maps\mp\_utility::spawnfxshowtoteam(var_5, maps\mp\_utility::getotherteam(var_3), var_1, var_2);
  self._id_1C98 = maps\mp\_utility::spawnfxshowtoteam(var_6, "broadcaster", var_1, var_2);
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

_id_8BF8(var_0) {
  var_1 = maps\mp\_utility::getotherteam(var_0);
  self.visuals[0] hide();
  self.visuals[1] hide();

  foreach(var_3 in level.players) {
    if(var_3.team == var_0) {
      self.visuals[0] showtoplayer(var_3);
    }

    if(var_3.team == "spectator" && var_0 == "allies") {
      self.visuals[0] showtoplayer(var_3);
    }

    if(var_3.team == var_1) {
      self.visuals[1] showtoplayer(var_3);
    }

    if(var_3.team == "spectator" && var_1 == "allies") {
      self.visuals[1] showtoplayer(var_3);
    }
  }

  for(;;) {
    level waittill("joined_team");

    if(!isDefined(self.carrier)) {
      self.visuals[0] hide();
      self.visuals[1] hide();

      foreach(var_3 in level.players) {
        if(var_3.team == var_0) {
          self.visuals[0] showtoplayer(var_3);
        }

        if(var_3.team == "spectator" && var_0 == "allies") {
          self.visuals[0] showtoplayer(var_3);
        }

        if(var_3.team == var_1) {
          self.visuals[1] showtoplayer(var_3);
        }

        if(var_3.team == "spectator" && var_1 == "allies") {
          self.visuals[1] showtoplayer(var_3);
        }
      }

      continue;
    }

    var_7 = _id_04D1::getownerteam();
    var_1 = maps\mp\_utility::getotherteam(var_7);
    level.carryflag[var_7][var_7] hide();
    level.carryflag[var_7][var_1] hide();

    foreach(var_3 in level.players) {
      if(var_3.team == "allies" || var_3.team == "axis") {
        level.carryflag[var_7][var_3.team] showtoplayer(var_3);
        continue;
      }

      if(var_3.team == "spectator") {
        level.carryflag[var_7]["allies"] showtoplayer(var_3);
      }
    }
  }
}

_id_8BF9(var_0) {
  self hide();

  foreach(var_2 in level.players) {
    if(var_2.team == var_0) {
      self showtoplayer(var_2);
    }

    if(var_2.team == "spectator" && var_0 == "allies") {
      self showtoplayer(var_2);
    }
  }
}

_id_2E41(var_0, var_1) {
  level endon("game_ended");
  self endon("lost_ctf_flag");
  self waittill("disconnect");
  var_0 hide();
  var_1 hide();
}