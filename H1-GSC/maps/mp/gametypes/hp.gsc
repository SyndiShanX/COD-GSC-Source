/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\hp.gsc
********************************/

main() {
  if(getdvar("mapname") == "mp_background") {
    return;
  }
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  maps\mp\gametypes\_globallogic::setupcallbacks();

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [
      [level.initializematchrules]
    ]();
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

  level.teambased = 1;
  level.randomzonespawn = maps\mp\_utility::getintproperty("scr_hp_radom_selection", 0);
  level.hpstarttime = 0;
  level.zoneduration = 60;
  level.initialzonedelay = maps\mp\_utility::getintproperty("scr_hp_zone_delay", 0);
  level.playercapturelpm = 6;
  level.scoreperplayer = 0;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.onprecachegametype = ::onprecachegametype;
  game["dialog"]["gametype"] = "hpt_intro";

  if(getdvarint("g_hardcore"))
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];

  if(!level.initialzonedelay) {
    game["dialog"]["offense_obj"] = "null";
    game["dialog"]["defense_obj"] = "null";
  }

  game["objective_active"] = "mp_killstreak_radar";
  game["objective_gained_sound"] = "h1_mp_war_objective_taken";
  game["objective_lost_sound"] = "h1_mp_war_objective_lost";
  game["objective_contested_sound"] = "mp_obj_notify_neg_sml";
  level.lastdialogtime = 0;
  level.zonespawnqueue = [];
}

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata();
  maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
  maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
  maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
  setdynamicdvar("scr_hp_radom_selection", getmatchrulesdata("hpData", "randomZones"));
  setdynamicdvar("scr_hp_zone_delay", getmatchrulesdata("hpData", "initDelay"));
}

onprecachegametype() {
  level.objectivehintpreparezone = & "MP_CONTROL_KOTH";
  level.objectivehintcapturezone = & "MP_CAPTURE_KOTH";
  level.objectivehintdefendhq = & "MP_DEFEND_KOTH";
  level.iconneutral3d = "waypoint_captureneutral";
  level.iconneutral2d = "waypoint_captureneutral";
  level.iconcapture3d = "waypoint_capture";
  level.iconcapture2d = "waypoint_capture";
  level.icondefend3d = "waypoint_defend";
  level.icondefend2d = "waypoint_defend";
  level.iconcontested3d = "waypoint_contested";
  level.iconcontested2d = "waypoint_contested";
  level.iconneutralspectator = "waypoint_esports_hardpoint_white";
  level.iconbluespectator = "waypoint_esports_hardpoint_blue";
  level.iconredspectator = "waypoint_esports_hardpoint_red";
  level.iconcontestedspectator = "waypoint_contested";
  level.zonespawninginstr = & "MP_KOTH_AVAILABLE_IN";
  level.zonedestroyedinenemystr = & "MP_KOTH_MOVING_IN";
}

updateobjectivehintmessages(var_0, var_1) {
  game["strings"]["objective_hint_allies"] = var_0;
  game["strings"]["objective_hint_axis"] = var_1;
}

updateobjectivehintmessage(var_0) {
  updateobjectivehintmessages(var_0, var_0);
}

onstartgametype() {
  if(!isdefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  maps\mp\_utility::setobjectivetext("allies", & "OBJECTIVES_KOTH");
  maps\mp\_utility::setobjectivetext("axis", & "OBJECTIVES_KOTH");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", & "OBJECTIVES_KOTH");
    maps\mp\_utility::setobjectivescoretext("axis", & "OBJECTIVES_KOTH");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", & "OBJECTIVES_KOTH_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", & "OBJECTIVES_KOTH_SCORE");
  }

  if(level.initialzonedelay)
    updateobjectivehintmessage(level.objectivehintpreparezone);
  else
    updateobjectivehintmessage(level.objectivehintcapturezone);

  setclientnamemode("auto_change");
  initspawns();
  var_2[0] = "hp";
  maps\mp\gametypes\_gameobjects::main(var_2);
  setomnvar("ui_mlg_game_mode_status_1", 0);
  setomnvar("ui_mlg_game_mode_status_2", 0);
  level thread onplayerconnect();
  level thread setupzones();
  level thread hardpointmainloop();
}

onplayerconnect() {
  for (;;) {
    level waittill("connected", var_0);
    var_0.gameobjecthudindex = 0;
    var_0.objective = 0;
    var_0.touchtriggers = [];
  }
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_hp_spawn_allies_start");
  maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_hp_spawn_axis_start");
  maps\mp\gametypes\_spawnlogic::addspawnpoints("allies", "mp_hp_spawn");
  maps\mp\gametypes\_spawnlogic::addspawnpoints("axis", "mp_hp_spawn");
  level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  var_0 = self.pers["team"];

  if(game["switchedsides"])
    var_0 = maps\mp\_utility::getotherteam(var_0);

  if(level.usestartspawns && level.ingraceperiod)
    var_1 = maps\mp\gametypes\_spawnlogic::getrandomstartspawn("mp_hp_spawn_" + var_0 + "_start");
  else {
    var_2 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_0);
    var_1 = maps\mp\gametypes\_spawnscoring::getspawnpoint_hardpoint(var_2);
  }

  maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_1);
  return var_1;
}

hpupdateuserate() {
  level.zone.gameobject maps\mp\gametypes\_gameobjects::updateuserate_internal();
  setomnvar("ui_mlg_game_mode_status_1", level.zone.gameobject.numtouching["allies"]);
  setomnvar("ui_mlg_game_mode_status_2", level.zone.gameobject.numtouching["axis"]);
}

spawn_next_zone() {
  if(level.randomzonespawn)
    level.zone = getnextzonefromqueue();
  else
    level.zone = getnextzone();

  setneutralicons();
  level.zone namedborderhidden();
}

hpcaptureloop() {
  level endon("game_ended");
  level endon("zone_moved");
  level.hpstarttime = gettime();

  for (;;) {
    level.zone.gameobject maps\mp\gametypes\_gameobjects::allowuse("any");
    level.zone.gameobject maps\mp\gametypes\_gameobjects::setusetime(0);
    level.zone.gameobject maps\mp\gametypes\_gameobjects::setusetext(&"MP_CAPTURING_OBJECTIVE");
    level.zone.gameobject maps\mp\gametypes\_gameobjects::setvisibleteam("any");
    level.zone.gameobject maps\mp\gametypes\_gameobjects::setmodelvisibility(1);
    level.zone.gameobject maps\mp\gametypes\_gameobjects::mustmaintainclaim(0);
    level.zone.gameobject maps\mp\gametypes\_gameobjects::cancontestclaim(1);
    level.zone.gameobject.onuse = ::onzonecapture;
    var_0 = level common_scripts\utility::waittill_any_return("zone_captured", "zone_destroyed");

    if(var_0 == "zone_destroyed") {
      continue;
    }
    var_1 = level.zone.gameobject maps\mp\gametypes\_gameobjects::getownerteam();

    if(var_1 == "allies")
      updateobjectivehintmessages(level.objectivehintdefendhq, level.objectivehintcapturezone);
    else if(var_1 == "axis")
      updateobjectivehintmessages(level.objectivehintcapturezone, level.objectivehintdefendhq);
    else
      updateobjectivehintmessages(level.objectivehintcapturezone, level.objectivehintcapturezone);

    level.zone.gameobject maps\mp\gametypes\_gameobjects::allowuse("none");
    level.zone.gameobject.onuse = undefined;
    level.zone.gameobject.onunoccupied = ::onzoneunoccupied;
    level.zone.gameobject.oncontested = ::onzonecontested;
    level.zone.gameobject.onuncontested = ::onzoneuncontested;
    level waittill("zone_destroyed", var_2);
    thread forcespawnteam(var_1);

    if(isdefined(var_2)) {
      level.zone.gameobject maps\mp\gametypes\_gameobjects::setownerteam(var_2);
      continue;
    }

    level.zone.gameobject maps\mp\gametypes\_gameobjects::setownerteam("none");
  }
}

updategameobjecthudindex() {
  for (;;) {
    foreach(var_1 in level.players) {
      var_2 = var_1;

      if(var_1.team == "spectator" || var_1.sessionstate == "spectator")
        var_2 = var_1 getspectatingplayer();

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

    wait 0.05;
  }
}

setgameobjecthudindex(var_0, var_1) {
  var_2 = 0;

  if(var_1) {
    var_2 = 1;

    if(isdefined(level.zone.gameobject.iscontested) && level.zone.gameobject.iscontested)
      var_2 = 2;
  }

  if(var_2 != var_0.gameobjecthudindex) {
    var_0 setclientomnvar("ui_hardpoint", var_2);
    var_0.gameobjecthudindex = var_2;
    var_0.objective = var_2;
  }
}

hardpointmainloop() {
  level endon("game_ended");
  level.zonerevealtime = -100000;
  level.zone = getfirstzone();
  maps\mp\_utility::gameflagwait("prematch_done");
  level childthread updategameobjecthudindex();

  for (;;) {
    maps\mp\_utility::playsoundonplayers("mp_suitcase_pickup");
    maps\mp\_utility::flushgroupdialog("gamemode_objective");
    level.zone.gameobject maps\mp\gametypes\_gameobjects::setmodelvisibility(1);
    level.zone.gameobject.onupdateuserate = ::hpupdateuserate;
    level.zonerevealtime = gettime();

    if(level.initialzonedelay) {
      setwaitingicons(level.zone);
      level.zone.gameobject maps\mp\gametypes\_gameobjects::setvisibleteam("any");
      level.zone namedborderneutral();
      updateobjectivehintmessage(level.objectivehintpreparezone);
      setomnvar("ui_hardpoint_timer", gettime() + 1000 * level.initialzonedelay);
      wait(level.initialzonedelay);
    }

    waittillframeend;
    setneutralicons(level.zone);
    maps\mp\_utility::leaderdialog("hp_online", undefined, "gamemode_objective");
    updateobjectivehintmessage(level.objectivehintcapturezone);
    level thread maps\mp\_utility::playsoundonplayers(game["objective_active"]);
    level.zone.gameobject maps\mp\gametypes\_gameobjects::enableobject();
    level.zone.gameobject.capturecount = 0;
    level.zone namedborderneutral();

    if(level.zoneduration) {
      thread movezoneaftertime(level.zoneduration);
      setomnvar("ui_hardpoint_timer", gettime() + 1000 * level.zoneduration);
    } else
      level.zonedestroyedbytimer = 0;

    hpcaptureloop();
    var_0 = level.zone.gameobject maps\mp\gametypes\_gameobjects::getownerteam();
    level.zone.gameobject.lastcaptureteam = undefined;
    level.zone.gameobject maps\mp\gametypes\_gameobjects::disableobject();
    level.zone.gameobject maps\mp\gametypes\_gameobjects::allowuse("none");
    level.zone.gameobject maps\mp\gametypes\_gameobjects::setownerteam("neutral");
    level.zone.gameobject maps\mp\gametypes\_gameobjects::setmodelvisibility(0);
    level.zone.gameobject maps\mp\gametypes\_gameobjects::mustmaintainclaim(0);
    level.zone.gameobject maps\mp\gametypes\_gameobjects::set2dicon("mlg", undefined);
    level.zone.gameobject maps\mp\gametypes\_gameobjects::set3dicon("mlg", undefined);
    level.zone namedborderhidden();
    level notify("zone_reset");

    if(isdefined(level.hp_pause_for_dynamic_event) && level.hp_pause_for_dynamic_event == 1)
      level waittill("ready_for_next_hp_zone");

    spawn_next_zone();
    wait 0.5;
    thread forcespawnteam(var_0);
    wait 0.5;
  }
}

forcespawnteam(var_0) {
  var_1 = level.players;

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(!isdefined(var_3)) {
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
  level.zone namedborderowned(var_1);

  if(!isdefined(self.lastcaptureteam) || self.lastcaptureteam != var_1) {
    var_4 = [];
    var_5 = getarraykeys(self.touchlist[var_1]);

    for (var_6 = 0; var_6 < var_5.size; var_6++)
      var_4[var_5[var_6]] = self.touchlist[var_1][var_5[var_6]];

    level thread give_capture_credit(var_4, var_3, var_1, self.lastcaptureteam);
    level thread maps\mp\_utility::leaderdialog("hp_secured", var_1, "gamemode_objective");
    level thread maps\mp\_utility::leaderdialog("hp_lost", var_2, "gamemode_objective");
  }

  level thread maps\mp\_utility::playsoundonplayers(game["objective_gained_sound"], var_1);
  level thread maps\mp\_utility::playsoundonplayers(game["objective_lost_sound"], var_2);
  level.hpcapteam = var_1;
  maps\mp\gametypes\_gameobjects::setownerteam(var_1);

  if(isdefined(self.lastcaptureteam) && self.lastcaptureteam != var_1) {
    for (var_7 = 0; var_7 < level.players.size; var_7++) {
      var_0 = level.players[var_7];

      if(var_0.pers["team"] == var_1) {
        if(isdefined(var_0.lastkilldefendertime) && var_0.lastkilldefendertime + 500 > gettime())
          var_0 maps\mp\gametypes\_missions::processchallenge("ch_hp_killedLastContester");
      }
    }
  }

  level thread awardcapturepoints(var_1, self.lastcaptureteam);
  self.capturecount++;
  self.lastcaptureteam = var_1;
  maps\mp\gametypes\_gameobjects::mustmaintainclaim(1);
  level notify("zone_captured");
  level notify("zone_captured" + var_1);
}

give_capture_credit(var_0, var_1, var_2, var_3) {
  var_4 = getarraykeys(var_0);

  for (var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = var_0[var_4[var_5]].player;
    var_6 updatecapsperminute(var_3);

    if(!isscoreboosting(var_6)) {
      var_6 maps\mp\gametypes\_missions::processchallenge("ch_hpcaptures");

      if(level.hpstarttime + 500 > var_1)
        var_6 maps\mp\gametypes\_missions::processchallenge("ch_hp_immediateCapture");

      var_6 thread maps\mp\_events::securehardpointevent();
    } else {

    }

    wait 0.05;
  }
}

namedbordervisible(var_0, var_1) {
  if(!isdefined(self.namedborders[var_0])) {
    return;
  }
  foreach(var_3 in self.namedborders[var_0]) {
    var_3 notify("stopShowFXToTeam");

    if(var_1) {
      var_3.state = "show";
      var_3 show();
      continue;
    }

    var_3.state = "hide";
    var_3 hide();
  }
}

namedbordershowtoteam(var_0, var_1) {
  if(!isdefined(self.namedborders[var_0])) {
    return;
  }
  foreach(var_3 in self.namedborders[var_0]) {
    var_3.state = "showToTeam";
    var_3 notify("stopShowFXToTeam");
    var_3 thread maps\mp\_utility::showfxtoteam(var_1);
  }
}

namedborderhidden() {
  namedbordervisible("neutral", 0);
  namedbordervisible("contested", 0);
  namedbordervisible("friendly", 0);
  namedbordervisible("enemy", 0);
}

namedborderneutral() {
  namedbordervisible("neutral", 1);
  namedbordervisible("contested", 0);
  namedbordervisible("friendly", 0);
  namedbordervisible("enemy", 0);
}

namedbordercontested() {
  namedbordervisible("neutral", 0);
  namedbordervisible("contested", 1);
  namedbordervisible("friendly", 0);
  namedbordervisible("enemy", 0);
}

namedborderowned(var_0) {
  namedbordervisible("neutral", 0);
  namedbordervisible("contested", 0);
  namedbordershowtoteam("friendly", var_0);
  namedbordershowtoteam("enemy", maps\mp\_utility::getotherteam(var_0));
}

onzoneunoccupied() {
  level notify("zone_destroyed");
  level.hpcapteam = "neutral";
  level.zone.gameobject.iscontested = 0;

  if(self.numtouching["axis"] == 0 && self.numtouching["allies"] == 0) {
    level.zone.gameobject.wasleftunoccupied = 1;
    setneutralicons();
    level.zone namedborderneutral();
  }
}

onzonecontested() {
  var_0 = level.zone.gameobject maps\mp\gametypes\_gameobjects::getownerteam();
  level.zone.gameobject.wascontested = 1;
  level.zone.gameobject.iscontested = 1;
  setcontestedicons();
  level.zone namedbordercontested();
  level thread maps\mp\_utility::playsoundonplayers(game["objective_contested_sound"]);
  maps\mp\_utility::leaderdialog("hp_contested", undefined, "gamemode_objective");
}

onzoneuncontested(var_0) {
  level.zone.gameobject.iscontested = 0;
  setteamicons(var_0);
  level.zone namedborderowned(var_0);
  level.zone.gameobject maps\mp\gametypes\_gameobjects::setclaimteam(var_0);
}

setneutralicons(var_0) {
  if(!isdefined(var_0))
    var_0 = level.zone;

  var_0.gameobject maps\mp\gametypes\_gameobjects::set2dicon("friendly", level.iconneutral2d);
  var_0.gameobject maps\mp\gametypes\_gameobjects::set3dicon("friendly", level.iconneutral3d);
  var_0.gameobject maps\mp\gametypes\_gameobjects::set2dicon("enemy", level.iconneutral2d);
  var_0.gameobject maps\mp\gametypes\_gameobjects::set3dicon("enemy", level.iconneutral3d);
  var_0.gameobject maps\mp\gametypes\_gameobjects::set2dicon("mlg", level.iconneutralspectator);
  var_0.gameobject maps\mp\gametypes\_gameobjects::set3dicon("mlg", level.iconneutralspectator);
}

setwaitingicons(var_0) {
  if(!isdefined(var_0))
    var_0 = level.zone;

  var_1 = "waypoint_waitfor_flag_neutral";
  var_0.gameobject maps\mp\gametypes\_gameobjects::set2dicon("friendly", var_1);
  var_0.gameobject maps\mp\gametypes\_gameobjects::set3dicon("friendly", var_1);
  var_0.gameobject maps\mp\gametypes\_gameobjects::set2dicon("enemy", var_1);
  var_0.gameobject maps\mp\gametypes\_gameobjects::set3dicon("enemy", var_1);
  var_0.gameobject maps\mp\gametypes\_gameobjects::set2dicon("mlg", var_1);
  var_0.gameobject maps\mp\gametypes\_gameobjects::set3dicon("mlg", var_1);
}

setcontestedicons() {
  level.zone.gameobject maps\mp\gametypes\_gameobjects::set2dicon("friendly", level.iconcontested2d);
  level.zone.gameobject maps\mp\gametypes\_gameobjects::set3dicon("friendly", level.iconcontested3d);
  level.zone.gameobject maps\mp\gametypes\_gameobjects::set2dicon("enemy", level.iconcontested2d);
  level.zone.gameobject maps\mp\gametypes\_gameobjects::set3dicon("enemy", level.iconcontested3d);
  level.zone.gameobject maps\mp\gametypes\_gameobjects::set2dicon("mlg", level.iconcontestedspectator);
  level.zone.gameobject maps\mp\gametypes\_gameobjects::set3dicon("mlg", level.iconcontestedspectator);
}

setteamicons(var_0) {
  level.zone.gameobject maps\mp\gametypes\_gameobjects::set2dicon("friendly", level.icondefend2d);
  level.zone.gameobject maps\mp\gametypes\_gameobjects::set3dicon("friendly", level.icondefend3d);
  level.zone.gameobject maps\mp\gametypes\_gameobjects::set2dicon("enemy", level.iconcapture2d);
  level.zone.gameobject maps\mp\gametypes\_gameobjects::set3dicon("enemy", level.iconcapture3d);

  if(var_0 == "allies") {
    level.zone.gameobject maps\mp\gametypes\_gameobjects::set2dicon("mlg", level.iconbluespectator);
    level.zone.gameobject maps\mp\gametypes\_gameobjects::set3dicon("mlg", level.iconbluespectator);
  } else {
    level.zone.gameobject maps\mp\gametypes\_gameobjects::set2dicon("mlg", level.iconredspectator);
    level.zone.gameobject maps\mp\gametypes\_gameobjects::set3dicon("mlg", level.iconredspectator);
  }
}

movezoneaftertime(var_0) {
  level endon("game_ended");
  level endon("zone_reset");
  level.zonemovetime = gettime() + var_0 * 1000;
  level.zonedestroyedbytimer = 0;
  wait(var_0);

  if(!isdefined(level.zone.gameobject.wascontested) || level.zone.gameobject.wascontested == 0) {
    if(!isdefined(level.zone.gameobject.wasleftunoccupied) || level.zone.gameobject.wasleftunoccupied == 0) {
      var_1 = level.zone.gameobject maps\mp\gametypes\_gameobjects::getownerteam();

      foreach(var_3 in level.players) {
        if(var_3.pers["team"] == var_1)
          var_3 maps\mp\gametypes\_missions::processchallenge("ch_hp_controlZoneEntirely");
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
  var_3 = 1;

  while (!level.gameended) {
    wait(var_2);
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

    if(!level.zone.gameobject.iscontested) {
      if(level.scoreperplayer)
        var_3 = level.zone.gameobject.numtouching[var_0];

      var_4 = level.zone.gameobject.touchlist[var_0];
      var_5 = getarraykeys(var_4);

      for (var_6 = 0; var_6 < var_5.size; var_6++) {
        var_7 = var_4[var_5[var_6]].player;

        if(!isplayer(var_7)) {
          continue;
        }
        var_7 thread maps\mp\_events::holdhardpointevent();
      }

      maps\mp\gametypes\_gamescore::giveteamscoreforobjective(var_0, var_3);
    }
  }
}

comparezoneindexes(var_0, var_1) {
  var_2 = var_0.script_index;
  var_3 = var_1.script_index;

  if(!isdefined(var_2) && !isdefined(var_3))
    return 0;

  if(!isdefined(var_2) && isdefined(var_3))
    return 1;

  if(isdefined(var_2) && !isdefined(var_3))
    return 0;

  if(var_2 > var_3)
    return 1;

  return 0;
}

getzonearray(var_0) {
  var_1 = getentarray(var_0, "targetname");

  if(!isdefined(var_1))
    return undefined;

  var_2 = 1;

  for (var_3 = var_1.size; var_2; var_3--) {
    var_2 = 0;

    for (var_4 = 0; var_4 < var_3 - 1; var_4++) {
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
  var_1 = getentarray("hp_zone_trigger", "targetname");
  level.zones = matchzonestotriggers(var_0, var_1);
  var_2 = getzonearray("hp_zone_center_augmented");
  var_3 = getentarray("hp_zone_trigger_augmented", "targetname");

  if(isdefined(var_2) && isdefined(var_3)) {
    var_2 = matchzonestotriggers(var_2, var_3);

    if(maps\mp\_utility::isaugmentedgamemode()) {
      foreach(var_5 in var_2) {
        for (var_6 = 0; var_6 < level.zones.size; var_6++) {
          if(level.zones[var_6].script_index == var_5.script_index)
            level.zones[var_6] = var_5;
        }
      }
    }
  }

  level.all_hp_zones = level.zones;
  return 1;
}

matchzonestotriggers(var_0, var_1) {
  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = 0;
    var_4 = var_0[var_2];
    var_4.trig = undefined;

    for (var_5 = 0; var_5 < var_1.size; var_5++) {
      if(var_4 istouching(var_1[var_5])) {
        if(isdefined(var_4.trig)) {
          var_3 = 1;
          break;
        }

        var_4.trig = var_1[var_5];
        break;
      }
    }

    if(!isdefined(var_4.trig)) {
      if(!var_3)
        continue;
    }

    var_4.trigorigin = var_4.trig.origin;
    var_6 = [];
    var_6[0] = var_4;
    var_4.namedborders = [];

    if(isdefined(var_4.target)) {
      var_7 = getentarray(var_4.target, "targetname");

      foreach(var_9 in var_7) {
        var_10 = var_9.script_noteworthy;

        if(isdefined(var_10)) {
          if(!isdefined(var_4.namedborders[var_10]))
            var_4.namedborders[var_10] = [];

          var_11 = var_4.namedborders[var_10].size;
          var_4.namedborders[var_10][var_11] = var_9;
          continue;
        }

        var_6[var_6.size] = var_9;
      }
    }

    var_4.gameobject = maps\mp\gametypes\_gameobjects::createuseobject("neutral", var_4.trig, var_6, (0, 0, 0));
    var_4.gameobject maps\mp\gametypes\_gameobjects::disableobject();
    setneutralicons(var_4);
    var_4.gameobject maps\mp\gametypes\_gameobjects::set2dicon("mlg", undefined);
    var_4.gameobject maps\mp\gametypes\_gameobjects::set3dicon("mlg", undefined);
    var_4.gameobject maps\mp\gametypes\_gameobjects::setmodelvisibility(0);
    var_4.trig.useobj = var_4.gameobject;
    var_4.gameobject.objpoints["allies"] sethidetrigger(var_4.trig);
    var_4.gameobject.objpoints["axis"] sethidetrigger(var_4.trig);
    var_4.gameobject.objpoints["mlg"] sethidetrigger(var_4.trig);
    var_4 setupnearbyspawns();
    var_4 namedborderhidden();
  }

  return var_0;
}

setupnearbyspawns() {
  var_0 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_hp_spawn");

  for (var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1].distsq = distancesquared(var_0[var_1].origin, self.origin);

  for (var_1 = 1; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    for (var_3 = var_1 - 1; var_3 >= 0 && var_2.distsq < var_0[var_3].distsq; var_3--)
      var_0[var_3 + 1] = var_0[var_3];

    var_0[var_3 + 1] = var_2;
  }

  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = var_0.size / 3;

  for (var_1 = 0; var_1 <= var_8; var_1++)
    var_4[var_4.size] = var_0[var_1];

  while (var_1 < var_0.size) {
    var_7[var_7.size] = var_0[var_1];

    if(var_1 <= var_8 * 2)
      var_5[var_5.size] = var_0[var_1];
    else
      var_6[var_6.size] = var_0[var_1];

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
  return var_0;
}

getnextzone() {
  var_0 = (level.prevzoneindex + 1) % level.zones.size;
  var_1 = level.zones[var_0];
  level.prevzoneindex = var_0;
  return var_1;
}

shufflezones() {
  level.zonespawnqueue = common_scripts\utility::array_randomize(level.zones);

  if(level.zone == level.zonespawnqueue[0])
    level.zonespawnqueue = maps\mp\_utility::swap(level.zonespawnqueue, 0, randomintrange(1, level.zonespawnqueue.size));
}

getnextzonefromqueue() {
  if(level.zonespawnqueue.size == 0)
    shufflezones();

  var_0 = level.zonespawnqueue[0];
  var_1 = [];

  for (var_2 = 1; var_2 < level.zonespawnqueue.size; var_2++)
    var_1[var_2 - 1] = level.zonespawnqueue[var_2];

  level.zonespawnqueue = var_1;
  return var_0;
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isplayer(var_1)) {
    return;
  }
  if(maps\mp\gametypes\_damage::isfriendlyfire(self, var_1)) {
    return;
  }
  if(var_1 == self) {
    return;
  }
  if(!isdefined(level.zone)) {
    return;
  }
  var_10 = level.zone.gameobject maps\mp\gametypes\_gameobjects::getownerteam();

  if(!isdefined(var_10) || var_10 == "neutral") {
    return;
  }
  if(isdefined(var_4) && maps\mp\_utility::iskillstreakweapon(var_4)) {
    return;
  }
  var_11 = 0;

  if(!level.zone.gameobject.iscontested && var_1 istouching(level.zone.trig)) {
    var_11 = 1;
    var_1 thread maps\mp\_events::killwhilecapture(self, var_9);
  }

  if(self istouching(level.zone.trig)) {
    var_1.lastkilldefendertime = gettime();

    if(var_11) {
      return;
    }
    if(self.team == var_10)
      var_1 thread maps\mp\_events::assaultobjectiveevent(self, var_9);
    else {
      var_1 maps\mp\gametypes\_missions::processchallenge("ch_hp_zoneDefense");
      var_1 thread maps\mp\_events::defendobjectiveevent(self, var_9);
      var_1 maps\mp\_utility::setextrascore1(var_1.pers["defends"]);
    }
  }
}

onendgame(var_0) {
  for (var_1 = 0; var_1 < level.zones.size; var_1++)
    level.zones[var_1].gameobject maps\mp\gametypes\_gameobjects::allowuse("none");
}

updatecapsperminute(var_0) {
  if(!isdefined(self.capsperminute)) {
    self.numcaps = 0;
    self.capsperminute = 0;
  }

  if(!isdefined(var_0) || var_0 == "neutral") {
    return;
  }
  self.numcaps++;
  var_1 = maps\mp\_utility::gettimepassed() / 60000;

  if(isplayer(self) && isdefined(self.timeplayed["total"]))
    var_1 = max(self.timeplayed["total"], 1) / 60;

  self.capsperminute = self.numcaps / var_1;

  if(self.capsperminute > self.numcaps)
    self.capsperminute = self.numcaps;
}

isscoreboosting(var_0) {
  if(!level.rankedmatch)
    return 0;

  if(var_0.capsperminute > level.playercapturelpm)
    return 1;

  return 0;
}