/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\dom.gsc
*********************************************/

main() {
  if(getDvar("1673") == "mp_background") {
    return;
  }
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();

  if(_isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread maps\mp\_utility::reinitializematchrulesonmigration();
  } else {
    maps\mp\_utility::registertimelimitdvar(level.gametype, 30);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 300);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 1);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  maps\mp\_utility::_id_873B(1);
  level._id_0C27 = 0;
  level.onstartgametype = ::onstartgametype;
  level._id_6B7B = ::_id_6B7B;
  level.onspawnplayer = ::onspawnplayer;
  level.domroundstarttime = gettime();
  level._id_320D = maps\mp\_utility::getfloatproperty("scr_dom_capture_time", 10);
  level._id_7672 = -1;
  level._id_0BDB["axis"]["time"] = 0;
  level._id_0BDB["axis"]["awarded"] = 0;
  level._id_0BDB["allies"]["time"] = 0;
  level._id_0BDB["allies"]["awarded"] = 0;
  level._id_0BF4 = [];
  level.axiscapturing = [];
  level.dom = spawnStruct();

  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["gametype"] = "dom_intro";

  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "dom_start";
  game["dialog"]["defense_obj"] = "dom_start";
}

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata();
  _setdynamicdvar("scr_dom_roundlimit", 2);
  maps\mp\_utility::registerroundlimitdvar("dom", 1);
  _setdynamicdvar("scr_dom_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("dom", 1);
  _setdynamicdvar("scr_dom_halftime", 1);
  maps\mp\_utility::registerhalftimedvar("dom", 1);
  _setdynamicdvar("scr_dom_capture_time", _getmatchrulesdata("domData", "captureTime"));
  _setdynamicdvar("scr_dom_allowNeutral", _getmatchrulesdata("domData", "allowNeutral"));
  _setdynamicdvar("scr_dom_halftimeswitchsides", _getmatchrulesdata("domData", "halfTimeSwitchSides"));
}

onstartgametype() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  if(game["status"] == "halftime") {
    _setomnvar("ui_current_round", 2);
  } else if(game["status"] == "overtime") {
    _setomnvar("ui_current_round", 3);
  } else if(game["status"] == "overtime_halftime") {
    _setomnvar("ui_current_round", 4);
  }

  maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_DOM");
  maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_DOM");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_DOM");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_DOM");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_DOM_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_DOM_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_DOM_HINT");
  maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_DOM_HINT");
  _setclientnamemode("auto_change");
  level.iconalliestaking = "waypoint_caster_friendly_taking";
  level.iconaxistaking = "waypoint_caster_enemy_taking";
  level.iconallies = "waypoint_defend";
  level.iconaxis = "waypoint_capture";
  _id_050D::_id_10E4();
  precacheflags();
  var_2[0] = "dom";
  var_2[1] = "blocker_dom";
  _id_04D1::main(var_2);
  _setomnvar("ui_broadcaster_game_mode_status_1", 0);
  _setomnvar("ui_broadcaster_game_mode_status_2", 0);
  _setomnvar("ui_broadcaster_game_mode_status_3", 0);
  level thread _id_3211();
  level thread _id_A109();
  level thread updatescoreboarddom();
  level.halftime_switch_sides = maps\mp\_utility::dvarintvalue("halftimeswitchsides", 1, 0, 1);
  level._id_0C27 = maps\mp\_utility::dvarintvalue("allowNeutral", 0, 0, 1);
}

updatescoreboarddom() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread updatecaptues();
    var_0 thread updatedefends();
  }
}

updatecaptues() {
  waittillframeend;
  maps\mp\_utility::setextrascore0(self.pers["captures"]);
}

updatedefends() {
  waittillframeend;
  maps\mp\_utility::setextrascore1(self.pers["defends"]);
}

_id_A0EA() {
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in level.players) {
      var_1._id_0112 = 0;

      foreach(var_3 in level._id_3211) {
        if(var_1 istouching(var_3.levelflag)) {
          if(var_3.numtouching["axis"] * var_3.numtouching["allies"] > 0) {
            var_1._id_0112 = 1;
          } else if(var_3.ownerteam == "neutral") {
            if(var_1.team == "allies") {
              var_1._id_0112 = 2;
            } else {
              var_1._id_0112 = 3;
            }
          } else if(var_3.ownerteam == "allies") {
            if(var_1.team == "allies") {
              var_1._id_0112 = 4;
            } else {
              var_1._id_0112 = 5;
            }
          } else if(var_3.ownerteam == "axis") {
            if(var_1.team == "axis") {
              var_1._id_0112 = 6;
            } else {
              var_1._id_0112 = 7;
            }
          }

          if(var_1._id_0112 > 0) {
            if(var_3.label == "_b") {
              var_1._id_0112 = var_1._id_0112 + 7;
              continue;
            }

            if(var_3.label == "_c") {
              var_1._id_0112 = var_1._id_0112 + 14;
            }
          }
        }
      }
    }

    waitframe();
  }
}

precacheflags() {
  game["neutral"] = "neutral";
  var_0 = _getmapcustom("allieschar");

  if(!isDefined(var_0) || var_0 == "") {
    var_0 = "allies";
  }

  var_1 = _getmapcustom("axischar");

  if(!isDefined(var_1) || var_1 == "") {
    var_1 = "axis";
  }

  level.boarderfxid[var_0]["friendly"] = loadfx("vfx/unique/vfx_marker_dom");
  level.boarderfxid[var_0]["enemy"] = loadfx("vfx/unique/vfx_marker_dom_red");
  level.boarderfxid[var_1]["friendly"] = loadfx("vfx/unique/vfx_marker_dom");
  level.boarderfxid[var_1]["enemy"] = loadfx("vfx/unique/vfx_marker_dom_red");
  level.boarderfxid["neutral"]["friendly"] = loadfx("vfx/unique/vfx_marker_dom_white");
  level.boarderfxid["neutral"]["enemy"] = loadfx("vfx/unique/vfx_marker_dom_white");
}

getteamdompoints(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_3211) {
    if(var_3.ownerteam == var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_4638(var_0) {
  if(level._id_7672 == gettime() && level._id_7671 == var_0) {
    return level._id_7670;
  }

  var_1 = getteamdompoints(var_0);
  var_2 = maps\mp\_utility::getotherteam(var_0);
  var_3 = getteamdompoints(var_2);
  level._id_7672 = gettime();
  level._id_7671 = var_0;
  level._id_7670 = [];

  for(var_4 = 0; var_4 < level._id_3211.size; var_4++) {
    level._id_7670[level._id_3211[var_4].label] = 0;
  }

  if(var_1.size == level._id_3211.size || var_3.size == level._id_3211.size || var_1.size == 0 || var_3.size == 0) {
    return level._id_7670;
  }

  if(var_1.size > 0) {
    foreach(var_6 in var_1) {
      level._id_7670[var_6.label] = 1;
    }

    return level._id_7670;
  }

  return level._id_7670;
}

gettimesincedompointcapture(var_0) {
  return gettime() - var_0.capturetime;
}

_id_44E1(var_0) {
  foreach(var_2 in level._id_3211) {
    if(var_2.label == var_0) {
      return var_2.levelflag.origin;
    }
  }

  return undefined;
}

_id_454E() {
  if(level._id_3211.size == 3) {
    return "_c";
  } else if(level._id_3211.size == 5) {
    return "_e";
  } else {}
}

_id_45DB() {
  if(level._id_3211.size == 3) {
    return "_b";
  } else if(level._id_3211.size == 5) {
    return "_c";
  } else {}
}

_id_8BF4() {
  level endon("game_ended");

  for(;;) {
    level waittill("joined_team");

    foreach(var_1 in level._id_3211) {
      var_1.visuals[1] hide();
      var_1.visuals[2] hide();

      foreach(var_3 in level.players) {
        if(var_3.team == "allies") {
          var_1.visuals[1] showtoplayer(var_3);
          continue;
        }

        if(var_3.team == "axis") {
          var_1.visuals[2] showtoplayer(var_3);
          continue;
        }

        if(var_3.team == "spectator") {
          var_1.visuals[1] showtoplayer(var_3);
        }
      }
    }
  }
}

_id_3211() {
  level.laststatus["allies"] = 0;
  level.laststatus["axis"] = 0;
  var_0 = maps\mp\_utility::dvarintvalue("domFlagCount", 5, 3, 5);
  level.flags = [];
  var_1 = getEntArray("mp_dom_flag_" + var_0, "script_noteworthy");

  if(var_1.size == 0) {
    var_1 = getEntArray("flag_primary", "targetname");

    if(var_1.size < 2) {
      return;
    }
    level.flags = var_1;
  } else if(var_1.size != var_0)
    return;
  else {
    level.flags = var_1;

    for(var_2 = 0; var_2 < level.flags.size; var_2++) {
      var_3 = level.flags[var_2];
      var_4 = spawn("trigger_radius", var_3.origin + (0, 0, -1), 0, 160, 128);
      var_4.angles = var_3.angles;
      var_4.shootblank = var_3.shootblank;
      var_4._id_0165 = var_3._id_0165;
      var_4.target = var_3.target;
      var_4.targetname = var_3.targetname;
      level.flags[var_2] delete();
      level.flags[var_2] = var_4;
    }
  }

  level._id_3211 = [];

  for(var_2 = 0; var_2 < level.flags.size; var_2++) {
    var_3 = level.flags[var_2];
    var_5 = common_scripts\utility::getstruct(var_3.target, "targetname");

    if(!isDefined(var_5)) {}

    var_6 = common_scripts\utility::getstruct(var_5.target, "targetname");

    if(!isDefined(var_6)) {}

    var_7[0] = spawn("script_model", var_5.origin);
    var_7[0].angles = var_5.angles;

    if(isDefined(var_5._id_0165) && var_5._id_0165 == "no_supports") {
      var_7[0] setModel("ctf_flag_pole");
    } else {
      var_7[0] setModel("ctf_flag_pole_with_supports");
    }

    var_7[1] = spawn("script_model", var_6.origin);
    var_7[1].angles = var_6.angles;
    var_7[1] setModel("neutral_ctf_flag_anim");
    var_7[1] scriptmodelplayanim("ctf_flag_flap");
    var_7[2] = spawn("script_model", var_6.origin);
    var_7[2].angles = var_6.angles;
    var_7[2] setModel("neutral_ctf_flag_anim");
    var_7[2] scriptmodelplayanim("ctf_flag_flap");
    var_8 = _id_04D1::createuseobject("neutral", var_3, var_7, (0, 0, 100));
    var_8 _id_04D1::_id_0C30("enemy");
    var_8 _id_04D1::setusetime(level._id_320D);
    var_8 _id_04D1::setusetext(&"MP_SECURING_POSITION");
    var_9 = var_8 _id_04D1::getlabel();
    var_8.label = var_9;
    var_8 _id_04D1::set2dicon("friendly", "waypoint_defend" + var_9);
    var_8 _id_04D1::playsoundtoteam("friendly", "waypoint_defend" + var_9, undefined, 1);
    var_8 _id_04D1::set2dicon("enemy", "waypoint_captureneutral" + var_9);
    var_8 _id_04D1::playsoundtoteam("enemy", "waypoint_captureneutral" + var_9, undefined, 1);
    maps\mp\_utility::_id_863F(var_8, level.iconallies + var_9, 0, 1);
    var_8 _id_04D1::setvisibleteam("any");
    var_8.onuse = ::onuse;
    var_8.onbeginuse = ::onbeginuse;
    var_8.onuseupdate = ::onuseupdate;
    var_8.onenduse = ::onenduse;
    var_8.nousebar = 1;
    var_8.id = "domFlag";
    var_8._id_4B25 = 0;
    var_8.firstcapture = 1;
    var_10 = var_7[0].origin + (0, 0, 32);
    var_11 = var_7[0].origin + (0, 0, -32);
    var_12 = bulletTrace(var_10, var_11, 0, var_7[0]);
    var_13 = vectortoangles(var_12["normal"]);
    var_8.baseeffectforward = anglesToForward(var_13);
    var_8.baseeffectright = anglestoright(var_13);
    var_8.baseeffectpos = var_12["position"];
    var_8 thread updatevisuals(1);
    var_8.visuals[1] _meth_8013(0, "allies");
    var_8.visuals[2] _meth_8013(0, "axis");
    level.flags[var_2].useobj = var_8;
    var_8.levelflag = level.flags[var_2];
    level._id_3211[level._id_3211.size] = var_8;
  }

  level thread _id_8BF4();
  var_14 = _id_050D::getspawnpointarray("axis");
  var_15 = _id_050D::getspawnpointarray("allies");
  level.startpos["allies"] = var_15[0].origin;
  level.startpos["axis"] = var_14[0].origin;
  level.bestspawnflag = [];
  level.bestspawnflag["allies"] = _id_44E0("allies", undefined, 0);
  level.bestspawnflag["axis"] = _id_44E0("axis", level.bestspawnflag["allies"], 0);
  flagsetuplegacy();
  wait 1;
  var_16 = gettime();

  for(var_2 = 0; var_2 < level._id_3211.size; var_2++) {
    _reconspatialevent(level._id_3211[var_2].visuals[0].origin, "script_mp_captures: team %s, gameTime %d", "neutral", var_16);
    _reconspatialevent(level._id_3211[var_2].visuals[0].origin, "script_mp_dom: gameTime %d, label %s, owner %s", var_16, level._id_3211[var_2].label, level._id_3211[var_2].ownerteam);
  }
}

_id_44E0(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;

  for(var_5 = 0; var_5 < level.flags.size; var_5++) {
    var_6 = level.flags[var_5];

    if(!var_2 && var_6 getflagteam() != "neutral") {
      continue;
    }
    var_7 = distancesquared(var_6.origin, level.startpos[var_0]);

    if((!isDefined(var_1) || var_6 != var_1) && (!isDefined(var_3) || var_7 < var_4)) {
      var_4 = var_7;
      var_3 = var_6;
    }
  }

  return var_3;
}

onbeginuse(var_0) {
  var_1 = _id_04D1::getownerteam();
  self.didstatusnotify = 0;
  self._id_2950 = 0;
  _id_04D1::setusetime(level._id_320D);

  if(var_1 == "neutral") {
    statusdialog("securing" + self.label, var_0.team);

    if(self.firstcapture || self.curprogress == 0) {
      _id_04D1::setusetime(level._id_320D);
    }
  } else {
    if(var_0.team == "allies") {
      level._id_0BF4[level._id_0BF4.size] = self.label;
      var_2 = "axis";
      return;
    }

    level.axiscapturing[level.axiscapturing.size] = self.label;
    var_2 = "allies";
  }
}

_id_1FB9() {
  if(isDefined(self.stalemate) && self.stalemate) {
    _id_04D1::set2dicon("enemy", "waypoint_contested" + self.label);
    _id_04D1::playsoundtoteam("enemy", "waypoint_contested" + self.label, undefined, 1);
    _id_04D1::set2dicon("friendly", "waypoint_contested" + self.label);
    _id_04D1::playsoundtoteam("friendly", "waypoint_contested" + self.label, undefined, 1);
  } else {
    _id_04D1::set2dicon("enemy", "waypoint_taking_neutral" + self.label);
    _id_04D1::playsoundtoteam("enemy", "waypoint_taking_neutral" + self.label, undefined, 1);
    _id_04D1::set2dicon("friendly", "waypoint_losing_neutral" + self.label);
    _id_04D1::playsoundtoteam("friendly", "waypoint_losing_neutral" + self.label, undefined, 1);
  }
}

_id_1FC0() {
  if(isDefined(self.stalemate) && self.stalemate) {
    _id_04D1::set2dicon("enemy", "waypoint_contested" + self.label);
    _id_04D1::playsoundtoteam("enemy", "waypoint_contested" + self.label, undefined, 1);
    _id_04D1::set2dicon("friendly", "waypoint_contested" + self.label);
    _id_04D1::playsoundtoteam("friendly", "waypoint_contested" + self.label, undefined, 1);
  } else {
    _id_04D1::set2dicon("enemy", "waypoint_taking" + self.label);
    _id_04D1::playsoundtoteam("enemy", "waypoint_taking" + self.label, undefined, 1);
    _id_04D1::set2dicon("friendly", "waypoint_losing" + self.label);
    _id_04D1::playsoundtoteam("friendly", "waypoint_losing" + self.label, undefined, 1);
  }
}

onuseupdate(var_0, var_1, var_2) {
  var_3 = _id_04D1::getownerteam();

  if(isDefined(self.stalemate)) {
    if(self._id_2950 != self.stalemate) {
      self._id_2950 = self.stalemate;

      if(var_3 == "neutral") {
        _id_1FB9();
      } else {
        _id_1FC0();
      }
    }
  }

  if(var_1 > 0.05 && var_2 && !self.didstatusnotify) {
    if(var_3 == "neutral") {
      statusdialog("securing" + self.label, var_0);

      if(var_0 == "allies") {
        maps\mp\_utility::_id_863F(self, level.iconalliestaking + self.label, 0, 1);
      } else {
        maps\mp\_utility::_id_863F(self, level.iconaxistaking + self.label, 0, 1);
      }

      _id_1FB9();
    } else {
      statusdialog("losing" + self.label, var_3, 1);
      statusdialog("securing" + self.label, var_0);

      if(var_3 == "allies") {
        maps\mp\_utility::_id_863F(self, level.iconaxistaking + self.label, 2, 1);
      } else {
        maps\mp\_utility::_id_863F(self, level.iconalliestaking + self.label, 1, 1);
      }

      _id_1FC0();
    }

    self.didstatusnotify = 1;
  } else if(level._id_0C27 && var_1 > 0.49 && var_2 && self.didstatusnotify && var_3 != "neutral") {
    var_4 = _id_04D1::getearliestclaimplayer();
    var_5 = gettime();
    _reconspatialevent(self.visuals[0].origin, "script_mp_captures: player_name %s, life_id %d, team %s, gameTime %d", var_4.name, var_4._id_5CC6, "neutral", var_5);
    _id_04D1::setownerteam("neutral");
    updatevisuals();
    statusdialog("lost" + self.label, var_3, 1);
    level thread maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_lrg", var_0);
    level thread maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_lrg", var_3);
    updateuiflagomnvars(self.label, "neutral");
    thread giveflagneutralizexp(self.touchlist[var_0]);
  }
}

statusdialog(var_0, var_1, var_2) {
  var_3 = gettime();

  if(gettime() < level.laststatus[var_1] + 5000 && (!isDefined(var_2) || !var_2)) {
    return;
  }
  thread delayedleaderdialog(var_0, var_1);
  level.laststatus[var_1] = gettime();
}

onenduse(var_0, var_1, var_2) {
  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_capture_icon", 0);
    var_1 setclientomnvar("ui_capture_status_index", 0);
  }

  var_3 = _id_04D1::getownerteam();

  if(var_3 != "neutral") {
    _id_04D1::set2dicon("enemy", "waypoint_capture" + self.label);
    _id_04D1::playsoundtoteam("enemy", "waypoint_capture" + self.label, undefined, 1);
    _id_04D1::set2dicon("friendly", "waypoint_defend" + self.label);
    _id_04D1::playsoundtoteam("friendly", "waypoint_defend" + self.label, undefined, 1);

    if(var_3 == "allies") {
      maps\mp\_utility::_id_863F(self, level.iconallies + self.label, 2, 1);
    } else {
      maps\mp\_utility::_id_863F(self, level.iconaxis + self.label, 1, 1);
    }
  } else {
    _id_04D1::set2dicon("enemy", "waypoint_captureneutral" + self.label);
    _id_04D1::playsoundtoteam("enemy", "waypoint_captureneutral" + self.label, undefined, 1);
    _id_04D1::set2dicon("friendly", "waypoint_captureneutral" + self.label);
    _id_04D1::playsoundtoteam("friendly", "waypoint_captureneutral" + self.label, undefined, 1);
    maps\mp\_utility::_id_863F(self, level.iconallies + self.label, 0, 1);
  }

  if(isDefined(var_1) && isDefined(var_1.team)) {
    if(var_1.team == "allies") {
      level._id_0BF4 = common_scripts\utility::_id_0F93(level._id_0BF4, self.label);
    } else {
      level.axiscapturing = common_scripts\utility::_id_0F93(level.axiscapturing, self.label);
    }
  }
}

updatevisuals(var_0) {
  if(isDefined(var_0) && var_0) {
    waittillframeend;
  }

  if(!_isremovedentity(self.visuals[0])) {
    var_1 = self.visuals[0];
    friendlyenemyeffects(var_1.origin, anglestoup(var_1.angles));
  }
}

friendlyenemyeffects(var_0, var_1) {
  var_2 = self.ownerteam;

  if(var_2 == "allies") {
    self.visuals[1] setModel("usa_ctf_flag_anim");
    self.visuals[2] setModel("usa_ctf_flag_red_anim");
  } else if(var_2 == "axis") {
    self.visuals[1] setModel("ger_ctf_flag_anim");
    self.visuals[2] setModel("ger_ctf_flag_blue_anim");
  } else if(var_2 == "neutral") {
    self.visuals[1] setModel("neutral_ctf_flag_anim");
    self.visuals[2] setModel("neutral_ctf_flag_anim");
  }

  var_3 = gettime();
  _reconspatialevent(self.visuals[0].origin, "script_mp_dom: gameTime %d, label %s, owner %s", var_3, self.label, self.ownerteam);
}

friendlyenemyeffectsstop() {
  if(isDefined(self.friendlyflagfxid)) {
    self.friendlyflagfxid delete();
  }

  if(isDefined(self.friendlyboarderfxid)) {
    self.friendlyboarderfxid delete();
  }

  if(isDefined(self._id_1C94)) {
    self._id_1C94 delete();
  }

  if(isDefined(self._id_1C90)) {
    self._id_1C90 delete();
  }

  if(isDefined(self._id_3768)) {
    self._id_3768 delete();
  }

  if(isDefined(self.enemyflagfxid)) {
    self.enemyflagfxid delete();
  }
}

updateuiflagomnvars(var_0, var_1) {
  var_2 = "ui_broadcaster_game_mode_status_1";

  if(var_0 == "_b") {
    var_2 = "ui_broadcaster_game_mode_status_2";
  }

  if(var_0 == "_c") {
    var_2 = "ui_broadcaster_game_mode_status_3";
  }

  if(var_1 == "allies") {
    _setomnvar(var_2, -1);
  } else if(var_1 == "axis") {
    _setomnvar(var_2, 1);
  } else {
    _setomnvar(var_2, 0);
  }
}

onuse(var_0) {
  var_1 = gettime();
  var_2 = var_0.team;
  var_3 = _id_04D1::getownerteam();
  var_4 = 0;
  var_5 = 0;
  var_6 = _id_44E0(maps\mp\_utility::getotherteam(var_2), undefined, 1);
  var_7 = _id_44E0(var_2, var_6, 1);

  if(self.firstcapture && self.label == _id_45DB()) {
    var_4 = 1;
  } else if(self.firstcapture && self.label != _id_45DB() && self.label == var_7.useobj.label) {
    var_5 = 1;
  }

  self.capturetime = gettime();
  var_8 = 3;

  if(self.label == "_a") {
    var_8 = 1;
  } else if(self.label == "_b") {
    var_8 = 2;
  }

  maps\mp\_utility::_id_863E(19, var_2, var_0 getentitynumber(), var_8);
  self.firstcapture = 0;
  self._id_4B25 = 1;

  if(isDefined(self.ownedtheentireround)) {
    self.ownedtheentireround = 0;
  } else {
    self.ownedtheentireround = 1;
  }

  if(!var_5 && var_3 != "neutral" && self.label != _id_45DB()) {
    if(isDefined(game["objectiveFlipCount"])) {
      game["objectiveFlipCount"]++;
    } else {
      game["objectiveFlipCount"] = 1;
    }
  }

  if(self.label != "_b" && isDefined(level._id_321C) && isDefined(level._id_321C[var_2]) && isDefined(level._id_321C[var_2]["flag"]) && level._id_321C[var_2]["flag"] == "_b") {
    level._id_321C[var_2] = undefined;
  }

  _reconspatialevent(self.visuals[0].origin, "script_mp_captures: player_name %s, life_id %d, team %s, gameTime %d", var_0.name, var_0._id_5CC6, var_2, var_1);
  _id_04D1::setownerteam(var_2);
  _id_04D1::set2dicon("enemy", "waypoint_capture" + self.label);
  _id_04D1::playsoundtoteam("enemy", "waypoint_capture" + self.label, undefined, 1);
  _id_04D1::set2dicon("friendly", "waypoint_defend" + self.label);
  _id_04D1::playsoundtoteam("friendly", "waypoint_defend" + self.label, undefined, 1);

  if(var_2 == "allies") {
    maps\mp\_utility::_id_863F(self, level.iconallies + self.label, 2, 1);
  } else {
    maps\mp\_utility::_id_863F(self, level.iconaxis + self.label, 1, 1);
  }

  updatevisuals();
  level.usestartspawns = 0;

  if(var_3 == "neutral") {
    var_9 = maps\mp\_utility::getotherteam(var_2);
    statusdialog("secured" + self.label, var_2, 1);
    statusdialog("enemy_has" + self.label, var_9, 1);
    level thread maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_lrg", var_2);
  } else {
    if(getteamflagcount(var_2) == level.flags.size) {
      statusdialog("secure_all", var_2);
      statusdialog("lost_all", var_3);
    } else {
      statusdialog("secured" + self.label, var_2, 1);
      statusdialog("lost" + self.label, var_3, 1);
    }

    level thread maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_lrg", var_2);
    level thread maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_lrg", var_3);
    level.bestspawnflag[var_3] = self.levelflag;
  }

  updateuiflagomnvars(self.label, var_2);
  var_0 thread _id_046C::snd_play_team_splash("mp_obj_notify_pos_lrg", "mp_obj_notify_neg_lrg");
  thread giveflagcapturexp(self.touchlist[var_2], var_4, var_5);
}

giveflagcapturexp(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = _id_04D1::getearliestclaimplayer();

  if(isDefined(var_3._id_0117)) {
    var_3 = var_3._id_0117;
  }

  if(isPlayer(var_3)) {
    level thread maps\mp\_utility::teamplayercardsplash("callout_securedposition" + self.label, var_3);
  }

  var_4 = getarraykeys(var_0);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_3 = var_0[var_4[var_5]].player;

    if(isDefined(var_3._id_0117)) {
      var_3 = var_3._id_0117;
    }

    if(!isPlayer(var_3)) {
      continue;
    }
    var_3 thread _id_047A::domcaptureevent(var_1, var_2);
    var_3 notify("ch_capture", self.trigger);
    var_3 thread updatecpm();
    waitframe();
  }
}

giveflagneutralizexp(var_0) {
  level endon("game_ended");
  var_1 = _id_04D1::getearliestclaimplayer();

  if(isDefined(var_1._id_0117)) {
    var_1 = var_1._id_0117;
  }

  if(isPlayer(var_1)) {
    level thread maps\mp\_utility::teamplayercardsplash("callout_neutralized_position" + self.label, var_1);
  }

  var_2 = getarraykeys(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_1 = var_0[var_2[var_3]].player;

    if(isDefined(var_1._id_0117)) {
      var_1 = var_1._id_0117;
    }

    if(!isPlayer(var_1)) {
      continue;
    }
    var_1 thread _id_047A::domneutralizeevent();
    waitframe();
  }
}

delayedleaderdialog(var_0, var_1) {
  level endon("game_ended");
  wait 0.1;
  maps\mp\_utility::waittillslowprocessallowed();
  maps\mp\_utility::leaderdialog(var_0, var_1);
}

delayedleaderdialogbothteams(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  wait 0.1;
  maps\mp\_utility::waittillslowprocessallowed();
  maps\mp\_utility::leaderdialogbothteams(var_0, var_1, var_2, var_3);
}

_id_A109() {
  level endon("game_ended");

  while(!level.gameended) {
    var_0 = getowneddomflags();

    if(var_0.size) {
      var_1 = undefined;
      var_2 = undefined;

      foreach(var_4 in var_0) {
        var_5 = var_4 _id_04D1::getownerteam();
        _id_04D2::giveteamscoreforobjective(var_5, 1, 0);

        if(!isDefined(var_1) || var_1 < var_4.capturetime) {
          var_1 = var_4.capturetime;
        }

        if(!isDefined(var_2)) {
          var_2 = var_5;
        }

        if(var_2 != var_5) {
          var_2 = "none";
        }
      }

      if(level._id_3211.size == var_0.size && var_2 != "none" && level._id_0BDB[var_2]["awarded"] == 0 && level.players.size > 5) {
        if(level._id_0BDB[var_2]["time"] == 0) {
          level._id_0BDB[maps\mp\_utility::getotherteam(var_2)]["time"] = 0;
          level notify("cancel_all_cap");

          foreach(var_8 in level.players) {
            if(var_8.team != var_2) {
              continue;
            }
            if(!isDefined(var_8._id_5BE2)) {
              continue;
            }
            var_8 thread _id_9B9F();
          }
        }

        level._id_0BDB[var_2]["time"] = gettime() - var_1;

        if(level._id_0BDB[var_2]["time"] > 60000) {
          level._id_0BDB[var_2]["awarded"] = 1;
          level notify("award_all_cap");
        }
      } else {
        level._id_0BDB["axis"]["time"] = 0;
        level._id_0BDB["allies"]["time"] = 0;
        level notify("cancel_all_cap");
      }
    }

    var_10 = 1;
    var_11 = _id_454E();

    foreach(var_13 in level._id_3211) {
      if((var_13.label == "_a" || var_13.label == var_11) && var_13._id_4B25 == 0) {
        var_10 = 0;
        break;
      }
    }

    if(maps\mp\_utility::matchmakinggame() && !level._id_0C27 && !var_10 && getdomroundtimepassed() > 120000 && !getdvarint("850")) {
      level.finalkillcam_winner = "none";
      level.forcedend = 1;
      thread maps\mp\gametypes\_gamelogic::endgame("none", game["end_reason"]["time_limit_reached"]);
      return;
    }

    thread maps\mp\gametypes\_gamelogic::checkscorelimit();
    wait 5.0;
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
  }
}

_id_9B9F() {
  level endon("cancel_all_cap");
  level waittill("award_all_cap");
  maps\mp\gametypes\_missions::processchallenge("ch_dom_tripcap");
}

getdomroundtimepassed() {
  return gettime() - level.domroundstarttime;
}

_id_6B7B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isPlayer(var_1)) {
    return;
  }
  if(maps\mp\gametypes\_damage::isfriendlyfire(self, var_1)) {
    return;
  }
  if(var_1 == self) {
    return;
  }
  var_10 = 0;
  var_11 = self;

  foreach(var_13 in var_1.touchtriggers) {
    var_14 = 0;

    foreach(var_16 in level.flags) {
      if(var_13 == var_16) {
        var_14 = 1;
        break;
      }
    }

    if(!var_14) {
      continue;
    }
    var_18 = var_13.useobj.ownerteam;

    if(var_1.team != var_18) {
      var_1 thread _id_047A::killwhilecapture(var_11, var_9, var_4);
      var_1.modifiers["assaultObjective"] = var_13;
      var_10 = 1;
    }
  }

  var_20 = 90000;
  var_21 = 0;

  foreach(var_13 in level.flags) {
    var_18 = var_13.useobj.ownerteam;
    var_23 = distancesquared(var_13.origin, var_11.origin);
    var_24 = distancesquared(var_13.origin, var_1.origin);

    if(var_23 < var_20) {
      var_21 = 1;
      var_1 thread maps\mp\gametypes\_missions::_id_80BB(var_4, var_3);
    }

    if(var_18 == var_1.team) {
      if(var_23 < var_20 || var_24 < var_20) {
        var_1 thread _id_047A::defendobjectiveevent(var_11, var_9, var_4);
        var_1 maps\mp\_utility::setextrascore1(var_1.pers["defends"]);
        var_1.modifiers["defendObjective"] = var_13;
      }
    }

    if(var_10) {
      break;
    }

    if(var_18 == var_11.team) {
      if(var_24 < var_20 || var_23 < var_20) {
        var_1 notify("dominated_battlecry");
        var_1 thread _id_047A::assaultobjectiveevent(self, var_9, var_4);
        var_1.modifiers["assaultObjective"] = var_13;
      }
    }
  }

  var_11._id_2EF1 = var_21;
}

getowneddomflags() {
  var_0 = [];

  foreach(var_2 in level._id_3211) {
    if(var_2 _id_04D1::getownerteam() != "neutral" && isDefined(var_2.capturetime)) {
      var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

getteamflagcount(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < level._id_3211.size; var_2++) {
    if(level._id_3211[var_2] _id_04D1::getownerteam() == var_0) {
      var_1++;
    }
  }

  return var_1;
}

getflagteam() {
  return self.useobj _id_04D1::getownerteam();
}

flagsetuplegacy() {
  var_0 = _id_050D::_id_448A();

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_0165) && issubstr(var_2._id_0165, "_override")) {
      var_2._id_766F = "_" + getsubstr(var_2._id_0165, 0, 1);
      continue;
    }

    var_2._id_663E = getnearestflagpoint(var_2);
    var_2._id_766F = var_2._id_663E.useobj.label;
  }
}

getnearestflagpoint(var_0) {
  var_1 = _id_050D::ispathdataavailable();
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in level._id_3211) {
    var_6 = undefined;

    if(var_1) {
      var_6 = _getpathdist(var_0.origin, var_5.levelflag.origin, 999999);
    }

    if(!isDefined(var_6) || var_6 == -1) {
      var_6 = distancesquared(var_5.levelflag.origin, var_0.origin);
    }

    if(!isDefined(var_2) || var_6 < var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  return var_2.levelflag;
}

onspawnplayer() {
  if(isDefined(self.spawninfo) && isDefined(self.spawninfo._id_9087) && isDefined(self.spawninfo._id_9087._id_766F)) {
    level._id_321C[self.team]["flag"] = self.spawninfo._id_9087._id_766F;
    level._id_321C[self.team]["time"] = gettime();

    if(isDefined(level._id_321C[maps\mp\_utility::getotherteam(self.team)]) && level._id_321C[self.team]["flag"] == level._id_321C[maps\mp\_utility::getotherteam(self.team)]["flag"]) {
      level._id_321C[maps\mp\_utility::getotherteam(self.team)] = undefined;
    }
  }
}

updatecpm() {
  if(!isDefined(self.cpm)) {
    self.numcaps = 0;
    self.cpm = 0;
  }

  self.numcaps++;

  if(maps\mp\_utility::getminutespassed() < 1) {
    return;
  }
  self.cpm = self.numcaps / maps\mp\_utility::getminutespassed();
}

getcapxpscale() {
  if(self.cpm < 4) {
    return 1;
  } else {
    return 0.25;
  }
}