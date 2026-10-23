/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\hp.gsc
********************************************/

main() {
  if(getDvar("1673") == "mp_background") {
    return;
  }
  setdvarifuninitialized("spv_enableHPBroadcasterMesh", 1);
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
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  maps\mp\_utility::_id_873B(1);
  level.randomzonespawn = maps\mp\_utility::getintproperty("scr_hp_radom_selection", 0);
  level.hpstarttime = 0;
  level.zoneduration = 60;
  level.initialzonedelay = maps\mp\_utility::getintproperty("scr_hp_zone_delay", 0);
  level.playercapturelpm = 6;
  level.scoreperplayer = 0;
  level.onstartgametype = ::onstartgametype;
  level._id_6B7B = ::_id_6B7B;
  level._id_6B86 = ::_id_6B86;
  level._effect["hp_neutral"] = loadfx("vfx/unique/hardpoint_chevron_neutral");
  level._effect["hp_neutral_vertical"] = loadfx("vfx/unique/hardpoint_chevron_neutral_vertical");
  level._effect["hp_friendly"] = loadfx("vfx/unique/hardpoint_chevron_friendly");
  level._effect["hp_friendly_vertical"] = loadfx("vfx/unique/hardpoint_chevron_friendly_vertical");
  level._effect["hp_enemy"] = loadfx("vfx/unique/hardpoint_chevron_enemy");
  level._effect["hp_enemy_vertical"] = loadfx("vfx/unique/hardpoint_chevron_enemy_vertical");
  level._effect["hp_contested"] = loadfx("vfx/unique/hardpoint_chevron_contested");
  level._effect["hp_contested_vertical"] = loadfx("vfx/unique/hardpoint_chevron_contested_vertical");
  game["dialog"]["gametype"] = "hpt_intro";

  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["objective_active"] = "mp_hp_new_hardpoint_active";
  game["objective_gained_sound"] = "mp_obj_notify_pos_sml";
  game["objective_lost_sound"] = "mp_obj_notify_neg_sml";
  game["objective_contested_sound"] = "mp_obj_notify_neg_sml";
  level.lastdialogtime = 0;
  level.zonespawnqueue = [];
}

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata();
  maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
  maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
  maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
  _setdynamicdvar("scr_hp_radom_selection", _getmatchrulesdata("hpData", "randomZones"));
  _setdynamicdvar("scr_hp_zone_delay", _getmatchrulesdata("hpData", "initDelay"));
}

_id_6B86() {
  level.objectivehintpreparezone = &"MP_CONTROL_KOTH";
  level.objectivehintcapturezone = &"MP_CAPTURE_KOTH";
  level.objectivehintdefendhq = &"MP_DEFEND_KOTH";
  level.iconneutral = "waypoint_captureneutral";
  level.iconcapture = "waypoint_capture";
  level.icondefend = "waypoint_defend";
  level.iconcontested = "waypoint_contested";
  level._id_5023 = "waypoint_caster_hardpoint";
  level._id_5009 = "waypoint_caster_contested";
  level.zonespawninginstr = &"MP_KOTH_AVAILABLE_IN";
  level.zonedestroyedinenemystr = &"MP_KOTH_MOVING_IN";
}

updateobjectivehintmessages(var_0, var_1) {
  game["strings"]["objective_hint_allies"] = var_0;
  game["strings"]["objective_hint_axis"] = var_1;
}

updateobjectivehintmessage(var_0) {
  updateobjectivehintmessages(var_0, var_0);
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

  maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_KOTH");
  maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_KOTH");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_KOTH");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_KOTH");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_KOTH_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_KOTH_SCORE");
  }

  if(level.initialzonedelay) {
    updateobjectivehintmessage(level.objectivehintpreparezone);
  } else {
    updateobjectivehintmessage(level.objectivehintcapturezone);
  }

  _setclientnamemode("auto_change");
  _id_050D::_id_10E4();
  var_2[0] = "hp";
  var_2[1] = "blocker_hp";
  _id_04D1::main(var_2);
  _setomnvar("ui_broadcaster_game_mode_status_1", 0);
  _setomnvar("ui_broadcaster_game_mode_status_2", 0);
  level thread onplayerconnect();
  level thread setupzones();
  level thread hardpointmainloop();
  level thread _id_5E9C();
  var_3 = getEntArray("hp_broadcaster_placeholder", "targetname");

  foreach(var_5 in var_3) {
    var_5 hide();
  }

  if(soundscripts/_snd_timescale() && maps\mp\_utility::inovertime() && !isDefined(level._id_501A)) {
    _id_6B86();
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.gameobjecthudindex = 0;
    var_0._id_0112 = 0;
    var_0.touchtriggers = [];
    var_0 thread _id_A91F();
    var_0._id_4B1D = [];
    var_0.touchinghardpoint = 0;
  }
}

_id_A91F() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("joined_team");
    _id_8A6F();
  }
}

hpupdateuserate() {
  level.zone.gameobject _id_04D1::updateuserate_internal();
  _setomnvar("ui_broadcaster_game_mode_status_1", level.zone.gameobject.numtouching["allies"]);
  _setomnvar("ui_broadcaster_game_mode_status_2", level.zone.gameobject.numtouching["axis"]);
}

spawn_next_zone() {
  _id_5A87();

  if(isDefined(level.zone.broadcastermesh)) {
    level.zone.broadcastermesh hide();
  }

  if(level.randomzonespawn) {
    level.zone = getnextzonefromqueue();
  } else {
    level.zone = getnextzone();
  }

  _id_8A70();
  setneutralicons();
  maps\mp\gametypes\_gamelogic::_id_7DFC();
  _setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::gettimeremaining()), 1);
  _id_0485::_id_5E91(game["roundsPlayed"], _getteamscore("axis"), _getteamscore("allies"));
  game["roundsPlayed"]++;
  level notify("round_switch", "next_zone");

  if(isDefined(level.zone._id_5E5D)) {
    _setomnvar("ui_hardpoint_minimap_location_callout", level.zone._id_5E5D);
  }

  maps\mp\_utility::_id_863E(5, "free");
}

_id_4484() {
  return level.zone;
}

hpcaptureloop() {
  level endon("game_ended");
  level endon("zone_moved");
  level.hpstarttime = gettime();
  var_0 = "none";

  for(;;) {
    level.zone.gameobject _id_04D1::_id_0C30("any");
    level.zone.gameobject _id_04D1::setusetime(0);
    level.zone.gameobject _id_04D1::setusetext(&"MP_CAPTURING_OBJECTIVE");
    level.zone.gameobject _id_04D1::setvisibleteam("any");
    level.zone.gameobject _id_04D1::setmodelvisibility(1);
    level.zone.gameobject _id_04D1::mustmaintainclaim(0);
    level.zone.gameobject _id_04D1::cancontestclaim(1);
    level.zone.gameobject.onuse = ::onzonecapture;
    var_1 = gettime();
    var_2 = level.zone.gameobject _id_04D1::getownerteam();
    _reconevent("script_mp_hp: gameTime %d, hp_origin %v, owner %s", var_1, level.zone.origin, var_2);
    var_3 = level common_scripts\utility::waittill_any_return("zone_captured", "zone_destroyed");

    if(var_3 == "zone_destroyed") {
      continue;
    }
    var_4 = level.zone.gameobject _id_04D1::getownerteam();
    var_1 = gettime();

    if(isDefined(var_4)) {
      var_2 = var_4;
    }

    _reconevent("script_mp_hp: gameTime %d, hp_origin %v, owner %s", var_1, level.zone.origin, var_2);

    if(var_0 != "none" && var_0 != var_4) {
      if(isDefined(game["objectiveFlipCount"])) {
        game["objectiveFlipCount"]++;
      } else {
        game["objectiveFlipCount"] = 1;
      }
    }

    var_0 = var_4;

    if(var_4 == "allies") {
      updateobjectivehintmessages(level.objectivehintdefendhq, level.objectivehintcapturezone);
    } else if(var_4 == "axis") {
      updateobjectivehintmessages(level.objectivehintcapturezone, level.objectivehintdefendhq);
    } else {
      updateobjectivehintmessages(level.objectivehintcapturezone, level.objectivehintcapturezone);
    }

    level.zone.gameobject _id_04D1::_id_0C30("none");
    level.zone.gameobject.onuse = undefined;
    level.zone.gameobject.onunoccupied = ::onzoneunoccupied;
    level.zone.gameobject.oncontested = ::onzonecontested;
    level.zone.gameobject.onuncontested = ::onzoneuncontested;
    level waittill("zone_destroyed", var_5);
    thread forcespawnteam(var_4);

    if(isDefined(var_5)) {
      level.zone.gameobject _id_04D1::setownerteam(var_5);
      continue;
    }

    level.zone.gameobject _id_04D1::setownerteam("none");
  }
}

updategameobjecthudindex() {
  for(;;) {
    foreach(var_1 in level.players) {
      var_2 = var_1;

      if(!isDefined(var_1.team) || !isDefined(var_1.sessionstate)) {
        continue;
      }
      if(var_1.team == "spectator" || var_1.sessionstate == "spectator") {
        var_2 = var_1 getspectatingplayer();
      }

      if(var_1 ismlgspectator()) {
        if(var_1.camera._id_A4A8 == "third_person") {
          var_1 setgameobjecthudindex(var_1, 0);
          continue;
        }
      }

      if(!maps\mp\_utility::isreallyalive(var_2)) {
        var_1 setgameobjecthudindex(var_1, 0);
        continue;
      }

      if(var_2.touchtriggers.size == 0) {
        var_1 setgameobjecthudindex(var_1, 0);
        continue;
      }

      foreach(var_4 in var_2.touchtriggers) {
        if(var_4 == level.zone.gameobject.trigger) {
          var_1 setgameobjecthudindex(var_1, 1);
          break;
        }

        var_1 setgameobjecthudindex(var_1, 0);
      }
    }

    waitframe();
  }
}

setgameobjecthudindex(var_0, var_1) {
  var_2 = 0;

  if(var_1) {
    var_2 = 1;

    if(isDefined(level.zone.gameobject.iscontested) && level.zone.gameobject.iscontested) {
      var_2 = 2;
    }

    if(!var_0.touchinghardpoint) {
      thread _id_0485::loggameevent("hp_enter", var_0.origin, level.zone.setmovespeedscale);
      var_0.touchinghardpoint = 1;
    }
  } else if(var_0.touchinghardpoint) {
    thread _id_0485::loggameevent("hp_exit", var_0.origin, level.zone.setmovespeedscale);
    var_0.touchinghardpoint = 0;
  }

  if(var_2 != var_0.gameobjecthudindex) {
    var_0 setclientomnvar("ui_hardpoint", var_2);
    var_0.gameobjecthudindex = var_2;
    var_0._id_0112 = var_2;
  }
}

hardpointmainloop() {
  level endon("game_ended");
  level.zonerevealtime = -100000;
  level.zone = getfirstzone();
  _id_8A70();
  _setomnvar("ui_hardpoint_minimap_location_callout", level.zone._id_5E5D);
  var_0 = 1;
  maps\mp\_utility::gameflagwait("prematch_done");
  level childthread updategameobjecthudindex();

  for(;;) {
    maps\mp\_utility::playsoundonplayers("mp_suitcase_pickup");
    maps\mp\_utility::flushgroupdialog("gamemode_objective");
    level.zone.gameobject _id_04D1::setmodelvisibility(1);
    level.zone.gameobject.onupdateuserate = ::hpupdateuserate;
    level.zonerevealtime = gettime();

    if(level.initialzonedelay) {
      setwaitingicons(level.zone);
      level.zone.gameobject _id_04D1::setvisibleteam("any");
      updateobjectivehintmessage(level.objectivehintpreparezone);
      _setomnvar("ui_hardpoint_timer", gettime() + 1000 * level.initialzonedelay);
      wait(level.initialzonedelay);
    }

    if(var_0) {
      var_0 = 0;
      wait 5.0;
      maps\mp\_utility::_id_863E(5, "free");

      foreach(var_2 in level.players) {
        if(var_2 ismlgspectator() && getdvarint("spv_enableHPBroadcasterMesh") != 0 && (isDefined(var_2.camera._id_A4A8) && var_2.camera._id_A4A8 == "third_person")) {
          if(isDefined(level.zone.broadcastermesh)) {
            level.zone.broadcastermesh showtoplayer(var_2);
          }
        }
      }
    }

    waittillframeend;
    setneutralicons(level.zone);
    maps\mp\_utility::leaderdialog("hp_online", undefined, "gamemode_objective");
    updateobjectivehintmessage(level.objectivehintcapturezone);
    level thread maps\mp\_utility::playsoundonplayers(game["objective_active"]);
    level.zone.gameobject _id_04D1::enableobject();
    level.zone.gameobject.capturecount = 0;
    level.zone.gameobject thread _id_04D1::_id_9BA8();

    if(level.zoneduration) {
      thread movezoneaftertime(level.zoneduration);
      _setomnvar("ui_hardpoint_timer", gettime() + 1000 * level.zoneduration);
    } else
      level.zonedestroyedbytimer = 0;

    hpcaptureloop();
    var_4 = level.zone.gameobject _id_04D1::getownerteam();
    level.zone.gameobject.lastcaptureteam = undefined;
    level.zone.gameobject _id_04D1::disableobject();
    level.zone.gameobject _id_04D1::_id_0C30("none");
    level.zone.gameobject _id_04D1::setownerteam("neutral");
    level.zone.gameobject _id_04D1::setmodelvisibility(0);
    level.zone.gameobject _id_04D1::mustmaintainclaim(0);
    level.zone.gameobject _id_04D1::set2dicon("broadcaster", undefined);
    level.zone.gameobject _id_04D1::playsoundtoteam("broadcaster", undefined);
    level notify("zone_reset");

    if(isDefined(level.hp_pause_for_dynamic_event) && level.hp_pause_for_dynamic_event == 1) {
      level waittill("ready_for_next_hp_zone");
    }

    spawn_next_zone();
    wait 0.5;
    thread forcespawnteam(var_4);
    wait 0.5;
  }
}

forcespawnteam(var_0) {
  var_1 = level.players;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3.pers["team"] == var_0) {
      var_3 notify("force_spawn");
      wait 0.1;
    }
  }
}

onzonecapture(var_0) {
  var_1 = var_0.pers["team"];
  var_2 = maps\mp\_utility::getotherteam(var_1);
  var_3 = gettime();
  var_0 logstring("zone captured");
  level.zone.gameobject.iscontested = 0;
  level.usestartspawns = 0;
  setteamicons(var_1);
  maps\mp\gametypes\_gamelogic::pausetimer();
  _setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::gettimeremaining()), 1);

  if(!isDefined(self.lastcaptureteam) || self.lastcaptureteam != var_1) {
    var_4 = [];
    var_5 = getarraykeys(self.touchlist[var_1]);

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      var_4[var_5[var_6]] = self.touchlist[var_1][var_5[var_6]];
    }

    level thread give_capture_credit(var_4, var_3, var_1, self.lastcaptureteam);
    level thread maps\mp\_utility::leaderdialog("hp_secured", var_1, "gamemode_objective");
    level thread maps\mp\_utility::leaderdialog("hp_lost", var_2, "gamemode_objective");
  }

  level thread maps\mp\_utility::playsoundonplayers(game["objective_gained_sound"], var_1);
  level thread maps\mp\_utility::playsoundonplayers(game["objective_lost_sound"], var_2);
  level.hpcapteam = var_1;

  if(!isDefined(level.lastcaptureteam) || var_1 != level.lastcaptureteam) {
    maps\mp\_utility::_id_863E(6, var_1, var_0 getentitynumber());
  }

  _id_04D1::setownerteam(var_1);

  if(isDefined(self.lastcaptureteam) && self.lastcaptureteam != var_1) {
    for(var_7 = 0; var_7 < level.players.size; var_7++) {
      var_0 = level.players[var_7];

      if(var_0.pers["team"] == var_1) {
        if(isDefined(var_0.lastkilldefendertime) && var_0.lastkilldefendertime + 500 > gettime()) {
          var_0 maps\mp\gametypes\_missions::processchallenge("ch_hp_killedLastContester");
        }
      }
    }
  }

  level thread awardcapturepoints(var_1, self.lastcaptureteam);
  self.capturecount++;
  self.lastcaptureteam = var_1;
  _id_04D1::mustmaintainclaim(1);
  level notify("zone_captured");
  level notify("zone_captured" + var_1);
}

give_capture_credit(var_0, var_1, var_2, var_3) {
  var_4 = getarraykeys(var_0);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = var_0[var_4[var_5]].player;
    var_6 updatecapsperminute(var_3);

    if(!isscoreboosting(var_6)) {
      var_6 maps\mp\gametypes\_missions::processchallenge("ch_hp_capturedObjective");

      if(level.hpstarttime + 500 > var_1) {
        var_6 maps\mp\gametypes\_missions::processchallenge("ch_hp_immediateCapture");
      }

      var_6 thread _id_047A::botgetdifficulty(level.zone.setmovespeedscale);
      var_6 notify("ch_capture", level.zone);
    } else {}

    waitframe();
  }
}

onzoneunoccupied() {
  level notify("zone_destroyed");
  level.hpcapteam = "neutral";
  level.zone.gameobject.iscontested = 0;

  if(self.numtouching["axis"] == 0 && self.numtouching["allies"] == 0) {
    level.zone.gameobject.wasleftunoccupied = 1;
    setneutralicons();

    if(isDefined(level.timerstoppedforgamemode) && level.timerstoppedforgamemode) {
      maps\mp\gametypes\_gamelogic::_id_7DFC();
      _setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::gettimeremaining()), 1);
    }
  }
}

onzonecontested() {
  maps\mp\_utility::_id_863E(7, "free");
  var_0 = level.zone.gameobject _id_04D1::getownerteam();
  level.zone.gameobject.wascontested = 1;
  level.zone.gameobject.iscontested = 1;
  setcontestedicons();

  if(isDefined(level.timerstoppedforgamemode) && level.timerstoppedforgamemode) {
    maps\mp\gametypes\_gamelogic::_id_7DFC();
    _setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::gettimeremaining()), 1);
  }

  level thread maps\mp\_utility::playsoundonplayers(game["objective_contested_sound"]);
  maps\mp\_utility::leaderdialog("hp_contested", undefined, "gamemode_objective");
  var_1 = gettime();
  var_2 = "contested";
  _reconevent("script_mp_hp: gameTime %d, hp_origin %v, owner %s", var_1, level.zone.origin, var_2);
}

onzoneuncontested(var_0) {
  level.zone.gameobject.iscontested = 0;
  setteamicons(var_0);
  maps\mp\gametypes\_gamelogic::pausetimer();
  _setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::gettimeremaining()), 1);
  level.zone.gameobject _id_04D1::setclaimteam(var_0);
  var_1 = gettime();
  var_2 = var_0;
  _reconevent("script_mp_hp: gameTime %d, hp_origin %v, owner %s", var_1, level.zone.origin, var_2);
}

setneutralicons(var_0) {
  if(!isDefined(var_0)) {
    var_0 = level.zone;
  }

  if(!isDefined(level.zone) || var_0 == level.zone) {
    thread _id_74EF(0);
    _setomnvar("ui_hardpoint_status", 0);
    thread setbroadcastermesh("neutral");
  }

  var_0.gameobject _id_04D1::set2dicon("friendly", level.iconneutral);
  var_0.gameobject _id_04D1::playsoundtoteam("friendly", level.iconneutral);
  var_0.gameobject _id_04D1::set2dicon("enemy", level.iconneutral);
  var_0.gameobject _id_04D1::playsoundtoteam("enemy", level.iconneutral);
  maps\mp\_utility::_id_863F(var_0.gameobject, level.iconneutral, 0, 1);
}

setwaitingicons(var_0) {
  if(!isDefined(var_0)) {
    var_0 = level.zone;
  }

  var_1 = "waypoint_waitfor_flag_neutral";
  var_0.gameobject _id_04D1::set2dicon("friendly", var_1);
  var_0.gameobject _id_04D1::playsoundtoteam("friendly", var_1);
  var_0.gameobject _id_04D1::set2dicon("enemy", var_1);
  var_0.gameobject _id_04D1::playsoundtoteam("enemy", var_1);
  maps\mp\_utility::_id_863F(var_0.gameobject, var_1, 0, 1);
}

setcontestedicons() {
  thread _id_74EF(-1);
  thread setbroadcastermesh("contested");
  _setomnvar("ui_hardpoint_status", -1);
  level.zone.gameobject _id_04D1::set2dicon("friendly", level.iconcontested);
  level.zone.gameobject _id_04D1::playsoundtoteam("friendly", level.iconcontested);
  level.zone.gameobject _id_04D1::set2dicon("enemy", level.iconcontested);
  level.zone.gameobject _id_04D1::playsoundtoteam("enemy", level.iconcontested);
  maps\mp\_utility::_id_863F(level.zone.gameobject, level.iconcontested, 3, 1);
}

setteamicons(var_0) {
  level.zone.gameobject _id_04D1::set2dicon("friendly", level.icondefend);
  level.zone.gameobject _id_04D1::playsoundtoteam("friendly", level.icondefend);
  level.zone.gameobject _id_04D1::set2dicon("enemy", level.iconcapture);
  level.zone.gameobject _id_04D1::playsoundtoteam("enemy", level.iconcapture);

  if(var_0 == "allies") {
    thread _id_74EF(2);
    thread setbroadcastermesh("allies");
    _setomnvar("ui_hardpoint_status", 2);
    maps\mp\_utility::_id_863F(level.zone.gameobject, level.iconcapture, 2, 1);
  } else {
    thread _id_74EF(1);
    thread setbroadcastermesh("axis");
    _setomnvar("ui_hardpoint_status", 1);
    maps\mp\_utility::_id_863F(level.zone.gameobject, level.iconcapture, 1, 1);
  }
}

_id_8A70() {
  if(!isDefined(level.zone) || !isDefined(level.zone._id_356F)) {
    return;
  }
  foreach(var_1 in level.players) {
    var_1 _id_8A6F();
  }
}

_id_8A6F() {
  if(!isDefined(level.zone) || !isDefined(level.zone._id_356F)) {
    return;
  }
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.team)) {
    return;
  }
  foreach(var_1 in getarraykeys(level.zone._id_356F)) {
    foreach(var_3 in level.zone._id_356F[var_1]) {
      if(var_1 == self.team) {
        var_3 showtoplayer(self);
        continue;
      }

      var_3 _meth_8006(self);
    }
  }

  if(self ismlgspectator() && (isDefined(self.camera._id_A4A8) && self.camera._id_A4A8 == "third_person")) {
    if(isDefined(level.zone.broadcastermesh) && getdvarint("spv_enableHPBroadcasterMesh") != 0) {
      level.zone.broadcastermesh showtoplayer(self);
    }
  }
}

_id_5A87() {
  if(!isDefined(level.zone) || !isDefined(level.zone._id_356F)) {
    return;
  }
  foreach(var_1 in level.zone._id_356F) {
    foreach(var_3 in var_1) {
      var_3 hide();
    }
  }
}

_id_74EF(var_0) {
  level notify("zoneFxChanged");
  level endon("zoneFxChanged");

  if(!isDefined(level.zone) || !isDefined(level.zone._id_356F)) {
    return;
  }
  foreach(var_2 in getarraykeys(level.zone._id_356F)) {
    foreach(var_4 in level.zone._id_356F[var_2]) {
      var_5 = isDefined(var_4._id_A419) && var_4._id_A419;

      if(var_0 == 0) {
        if(var_5) {
          var_4 setfootstepeffectsmall(common_scripts\utility::getfx("hp_neutral_vertical"));
        } else {
          var_4 setfootstepeffectsmall(common_scripts\utility::getfx("hp_neutral"));
        }

        continue;
      }

      if(var_0 == -1) {
        if(var_5) {
          var_4 setfootstepeffectsmall(common_scripts\utility::getfx("hp_contested_vertical"));
        } else {
          var_4 setfootstepeffectsmall(common_scripts\utility::getfx("hp_contested"));
        }

        continue;
      }

      if(var_0 == 1 && var_2 == "allies" || var_0 == 2 && var_2 == "axis" || var_2 == "spectator" && var_0 == 1) {
        if(var_5) {
          var_4 setfootstepeffectsmall(common_scripts\utility::getfx("hp_enemy_vertical"));
        } else {
          var_4 setfootstepeffectsmall(common_scripts\utility::getfx("hp_enemy"));
        }

        continue;
      }

      if(var_0 == 1 && var_2 == "axis" || var_0 == 2 && var_2 == "allies" || var_2 == "spectator" && var_0 == 2) {
        if(var_5) {
          var_4 setfootstepeffectsmall(common_scripts\utility::getfx("hp_friendly_vertical"));
          continue;
        }

        var_4 setfootstepeffectsmall(common_scripts\utility::getfx("hp_friendly"));
      }
    }
  }
}

movezoneaftertime(var_0) {
  level endon("game_ended");
  level endon("zone_reset");
  level.zonemovetime = gettime() + var_0 * 1000;
  level.zonedestroyedbytimer = 0;
  wait(var_0);

  if(!isDefined(level.zone.gameobject.wascontested) || level.zone.gameobject.wascontested == 0) {
    if(!isDefined(level.zone.gameobject.wasleftunoccupied) || level.zone.gameobject.wasleftunoccupied == 0) {
      var_1 = level.zone.gameobject _id_04D1::getownerteam();

      foreach(var_3 in level.players) {
        if(var_3.pers["team"] == var_1) {
          var_3 maps\mp\gametypes\_missions::processchallenge("ch_hp_controlZoneEntirely");
        }
      }
    }
  }

  level.zonedestroyedbytimer = 1;
  level notify("zone_moved");
}

awardcapturepoints(var_0, var_1) {
  level endon("game_ended");
  level endon("zone_destroyed");
  level endon("zone_reset");
  level endon("zone_moved");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");
  var_2 = 1;
  var_3 = 5;
  var_4 = 1;
  var_5 = [];

  while(!level.gameended) {
    wait(var_2);
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

    if(!level.zone.gameobject.iscontested) {
      if(level.scoreperplayer) {
        var_4 = level.zone.gameobject.numtouching[var_0];
      }

      _id_04D2::giveteamscoreforobjective(var_0, var_4, 1);
      var_6 = [];

      foreach(var_8 in level.players) {
        if(var_8.pers["team"] != var_0) {
          continue;
        }
        if(var_8 istouching(level.zone.trig)) {
          if(!isDefined(var_8._id_99DE)) {
            var_8._id_99DE = 0;
          }

          if(!isDefined(var_8._id_4B1D[level.zone.setmovespeedscale])) {
            var_8._id_4B1D[level.zone.setmovespeedscale] = 0;
          }

          var_8._id_4B1D[level.zone.setmovespeedscale] = var_8._id_4B1D[level.zone.setmovespeedscale] + 1;
          var_8._id_99DE = var_8._id_99DE + 1;
          var_8.pers["time"] = var_8._id_99DE;
          var_8 maps\mp\_utility::setextrascore0(var_8.pers["time"]);

          if(isDefined(var_5) && var_5.size > 0 && common_scripts\utility::_id_0F79(var_5, var_8)) {
            if(isDefined(var_8._id_4C67) && var_8._id_4C67 + var_3 * 1000 <= gettime()) {
              if(var_8 maps\mp\_utility::_hasperk("specialty_improvedobjectives")) {
                var_8 thread _id_047A::_id_4C68();
              }

              var_8._id_4C67 = gettime();
            }
          } else
            var_8._id_4C67 = gettime() - 1000;

          var_6[var_6.size] = var_8;
        }
      }

      var_5 = var_6;
      continue;
    }

    var_5 = [];
  }
}

comparezoneindexes(var_0, var_1) {
  var_2 = var_0.setmovespeedscale;
  var_3 = var_1.setmovespeedscale;

  if(!isDefined(var_2) && !isDefined(var_3)) {
    return 0;
  }

  if(!isDefined(var_2) && isDefined(var_3)) {
    return 1;
  }

  if(isDefined(var_2) && !isDefined(var_3)) {
    return 0;
  }

  if(var_2 > var_3) {
    return 1;
  }

  return 0;
}

getzonearray(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(!isDefined(var_1)) {
    return undefined;
  }

  var_2 = 1;

  for(var_3 = var_1.size; var_2; var_3--) {
    var_2 = 0;

    for(var_4 = 0; var_4 < var_3 - 1; var_4++) {
      if(comparezoneindexes(var_1[var_4], var_1[var_4 + 1])) {
        var_5 = var_1[var_4];
        var_1[var_4] = var_1[var_4 + 1];
        var_1[var_4 + 1] = var_5;
        var_2 = 1;
      }
    }
  }

  return var_1;
}

setupzones() {
  var_0 = getzonearray("hp_zone_center");
  var_1 = getEntArray("hp_zone_trigger", "targetname");
  level.zones = matchzonestotriggers(var_0, var_1);
  level._id_0BCF = level.zones;
  return 1;
}

matchzonestotriggers(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = 0;
    var_4 = var_0[var_2];
    var_4.trig = undefined;

    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      if(var_1[var_5] _meth_858B(var_4.origin)) {
        if(isDefined(var_4.trig)) {
          var_3 = 1;
          break;
        }

        var_4.trig = var_1[var_5];
        break;
      }
    }

    if(!isDefined(var_4.trig)) {
      if(!var_3) {
        continue;
      }
    }

    var_4.trigorigin = var_4.trig.origin;
    var_6 = [];
    var_6[0] = var_4;

    if(isDefined(var_4.target)) {
      var_7 = getEntArray(var_4.target, "targetname");

      for(var_5 = 0; var_5 < var_7.size; var_5++) {
        if(isDefined(var_7[var_5]._id_0165) && var_7[var_5]._id_0165 == "broadcaster_visual") {
          var_4.broadcastermesh = var_7[var_5];
          var_7[var_5] hide();
          var_7[var_5] _meth_80B1();
          continue;
        }

        var_6[var_6.size] = var_7[var_5];
      }
    }

    var_8 = [];
    var_8["allies"] = [];
    var_8["axis"] = [];
    var_8["spectator"] = [];
    var_9 = common_scripts\utility::getstructarray(var_4.target, "targetname");

    foreach(var_11 in var_9) {
      var_12 = undefined;
      var_13 = 0;

      if(isDefined(var_11._id_0165) && var_11._id_0165 == "vertical") {
        var_13 = 1;
      }

      if(var_13) {
        var_12 = common_scripts\utility::getfx("hp_neutral_vertical");
      } else {
        var_12 = common_scripts\utility::getfx("hp_neutral");
      }

      var_14 = anglesToForward(var_11.angles);
      var_15 = anglestoup(var_11.angles);
      var_16 = _spawnfx(var_12, var_11.origin, var_14, var_15);
      var_17 = _spawnfx(var_12, var_11.origin, var_14, var_15);
      var_18 = _spawnfx(var_12, var_11.origin, var_14, var_15);

      if(var_13) {
        var_16._id_A419 = 1;
        var_17._id_A419 = 1;
        var_18._id_A419 = 1;
      }

      var_16 hide();
      var_17 hide();
      var_8["allies"][var_8["allies"].size] = var_16;
      var_8["axis"][var_8["axis"].size] = var_17;
      var_8["spectator"][var_8["spectator"].size] = var_18;
    }

    var_4._id_356F = var_8;
    var_4.gameobject = _id_04D1::createuseobject("neutral", var_4.trig, var_6, (0, 0, 0));
    var_4.gameobject _id_04D1::disableobject();
    setneutralicons(var_4);
    maps\mp\_utility::_id_863F(var_4.gameobject, undefined);
    var_4.gameobject _id_04D1::setmodelvisibility(0);
    var_4.trig.useobj = var_4.gameobject;
    var_4.gameobject.objpoints["allies"] sethidetrigger(var_4.trig);
    var_4.gameobject.objpoints["axis"] sethidetrigger(var_4.trig);
    var_4 setupnearbyspawns();

    if(isDefined(var_4.trig._id_0165)) {
      var_4._id_5E5D = int(var_4.trig._id_0165);
      continue;
    }

    var_4._id_5E5D = -1;
  }

  return var_0;
}

setupnearbyspawns() {
  var_0 = _id_050D::_id_448A();

  if(var_0.size == 0) {
    return;
  }
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1].distsq = distancesquared(var_0[var_1].origin, self.origin);
  }

  for(var_1 = 1; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    for(var_3 = var_1 - 1; var_3 >= 0 && var_2.distsq < var_0[var_3].distsq; var_3--) {
      var_0[var_3 + 1] = var_0[var_3];
    }

    var_0[var_3 + 1] = var_2;
  }

  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = var_0.size / 3;

  for(var_1 = 0; var_1 <= var_8; var_1++) {
    var_4[var_4.size] = var_0[var_1];
  }

  while(var_1 < var_0.size) {
    var_7[var_7.size] = var_0[var_1];

    if(var_1 <= var_8 * 2) {
      var_5[var_5.size] = var_0[var_1];
    } else {
      var_6[var_6.size] = var_0[var_1];
    }

    var_1++;
  }

  self.gameobject.nearspawns = var_4;
  self.gameobject.midspawns = var_5;
  self.gameobject.farspawns = var_6;
  self.gameobject.outerspawns = var_7;
}

getfirstzone() {
  var_0 = level.zones[0];
  level.prevzoneindex = 0;
  level.currentzoneindex = 0;
  return var_0;
}

getnextzone() {
  var_0 = (level.prevzoneindex + 1) % level.zones.size;
  var_1 = level.zones[var_0];
  level.prevzoneindex = var_0;
  level.currentzoneindex = var_0;
  return var_1;
}

shufflezones() {
  level.zonespawnqueue = common_scripts\utility::array_randomize(level.zones);

  if(level.zone == level.zonespawnqueue[0]) {
    level.zonespawnqueue = common_scripts\utility::swap(level.zonespawnqueue, 0, _randomintrange(1, level.zonespawnqueue.size));
  }
}

getnextzonefromqueue() {
  if(level.zonespawnqueue.size == 0) {
    shufflezones();
  }

  var_0 = level.zonespawnqueue[0];

  for(var_1 = 0; var_1 < level.zones.size; var_1++) {
    if(var_0 == level.zones[var_1]) {
      level.currentzoneindex = var_1;
    }
  }

  var_2 = [];

  for(var_1 = 1; var_1 < level.zonespawnqueue.size; var_1++) {
    var_2[var_1 - 1] = level.zonespawnqueue[var_1];
  }

  level.zonespawnqueue = var_2;
  return var_0;
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
  if(!isDefined(level.zone)) {
    return;
  }
  var_10 = level.zone.gameobject _id_04D1::getownerteam();

  if(!isDefined(var_10) || var_10 == "neutral") {
    return;
  }
  self.touchinghardpoint = 0;
  var_11 = 0;
  var_12 = self;

  if(!level.zone.gameobject.iscontested && var_1 istouching(level.zone.trig)) {
    var_11 = 1;
    var_1 thread _id_047A::killwhilecapture(self, var_9, var_4, level.zone.setmovespeedscale);
    var_1.modifiers["assaultObjective"] = level.zone;
  }

  if(var_12 istouching(level.zone.trig)) {
    var_12._id_2EF1 = 1;
    var_1.lastkilldefendertime = gettime();
    var_1 thread maps\mp\gametypes\_missions::_id_80BB(var_4, var_3);
    var_12 thread _id_0485::logkillevent(var_12._id_5CC6, "in_hardpoint");

    if(var_11) {
      return;
    }
    if(var_12.team == var_10) {
      var_1 thread _id_047A::assaultobjectiveevent(var_12, var_9, var_4);
      var_1.modifiers["assaultObjective"] = level.zone;
    } else {
      var_1 maps\mp\gametypes\_missions::processchallenge("ch_hp_zoneDefense");
      var_1 thread _id_047A::defendobjectiveevent(self, var_9, var_4, level.zone.setmovespeedscale);
      var_1 maps\mp\_utility::setextrascore1(var_1.pers["defends"]);
      var_1.modifiers["defendObjective"] = level.zone;
    }
  } else
    var_12._id_2EF1 = 0;
}

onendgame(var_0) {
  for(var_1 = 0; var_1 < level.zones.size; var_1++) {
    level.zones[var_1].gameobject _id_04D1::_id_0C30("none");
  }
}

_id_5E9C() {
  level waittill("game_ended");

  foreach(var_1 in level.players) {
    foreach(var_5, var_3 in var_1._id_4B1D) {
      if(var_5 > 0 && var_5 < 6) {
        var_4 = getmatchdata("players", var_1.clientid, "hardpointScore", var_5);
        var_4 = var_4 + var_3;
        setmatchdata("players", var_1.clientid, "hardpointScore", var_5, var_4);
      }
    }
  }
}

updatecapsperminute(var_0) {
  if(!isDefined(self.capsperminute)) {
    self.numcaps = 0;
    self.capsperminute = 0;
  }

  if(!isDefined(var_0) || var_0 == "neutral") {
    return;
  }
  self.numcaps++;
  var_1 = maps\mp\_utility::gettimepassed() / 60000;

  if(isPlayer(self) && isDefined(self.timeplayed["total"])) {
    var_1 = max(self.timeplayed["total"], 1) / 60;
  }

  self.capsperminute = self.numcaps / var_1;

  if(self.capsperminute > self.numcaps) {
    self.capsperminute = self.numcaps;
  }
}

isscoreboosting(var_0) {
  if(!level.rankedmatch) {
    return 0;
  }

  if(var_0.capsperminute > level.playercapturelpm) {
    return 1;
  }

  return 0;
}

setbroadcastermesh(var_0) {
  if(getdvarint("spv_enableHPBroadcasterMesh") == 0) {
    return;
  }
  if(!isDefined(level.zone) || !isDefined(level.zone.broadcastermesh)) {
    return;
  }
  if(!isDefined(level.broadcastercolorindexallies) || !isDefined(level.broadcastercolorindexaxis)) {
    return;
  }
  waittillframeend;
  var_1 = maps\mp\_utility::getmapname();

  if(issubstr(var_1, "carentan_s2_winter")) {
    var_1 = "mp_carentan_s2";
  }

  if(var_0 == "allies") {
    level.zone.broadcastermesh setModel(var_1 + "_hp_zone_" + (level.currentzoneindex + 1) + "_" + level.broadcastercolorindexallies);
  } else if(var_0 == "axis") {
    level.zone.broadcastermesh setModel(var_1 + "_hp_zone_" + (level.currentzoneindex + 1) + "_" + level.broadcastercolorindexaxis);
  } else if(var_0 == "contested") {
    level.zone.broadcastermesh setModel(var_1 + "_hp_zone_" + (level.currentzoneindex + 1) + "_contested");
  } else {
    level.zone.broadcastermesh setModel(var_1 + "_hp_zone_" + (level.currentzoneindex + 1));
  }
}