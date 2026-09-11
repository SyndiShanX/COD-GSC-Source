/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rumble_invasion\br_ri_dom.gsc
**************************************************************/

function maphint_computerscriptableused() {
  scripts\mp\gametypes\br_rumble_invasion_dom_mp_wz_island::initstructs();
  level.defend_wave_3 = getdvarint("scr_br_domHeight", 250);
  var_0 = ["_a", "_b", "_c", "_d", "_e", "_f", "_g"];

  if(!isDefined(level.start_reach_exhaust_waste.maphint_phonescriptableused)) {
    level.start_reach_exhaust_waste.maphint_phonescriptableused = scripts\engine\utility::getStructArray("brRumbleInv_dom_points", "targetname");
  }

  if(!isDefined(level.start_reach_exhaust_waste.maphint_cheese2scriptableused)) {
    level.start_reach_exhaust_waste.maphint_cheese2scriptableused = [];
  }

  foreach(var_2 in level.start_reach_exhaust_waste.maphint_phonescriptableused) {
    var_3 = level.start_reach_exhaust_waste.maphints;
    var_4 = spawn("trigger_radius", var_2.origin, 0, int(var_3), int(level.defend_wave_3));
    var_4.script_label = var_0[var_6];
    var_4.iconname = var_0[var_6];
    var_5 = scripts\mp\gametypes\obj_dom::setupobjective(var_4, "neutral");
    var_5.onuse = &manualturret_endturretuseonexecution;
    var_5.onbeginuse = &manual_turret_allowpickupofturret;
    var_5.onuseupdate = &manualturret_endturretuseonpush;
    var_5.onenduse = &manual_turret_handlemovingplatform;
    var_5.oncontested = &manual_turret_canpickup;
    var_5.onuncontested = &manualturret_clearplacementinstructions;
    var_5.onunoccupied = &manualturret_disablecrouchpronemantle;
    var_5.onpinnedstate = &manual_turret_operate_by_nearby_enemies;
    var_5.onunpinnedstate = &manualturret_domonitoredweaponswitch;
    var_5.ref_138b2 = &manualadjustlittlebirdlocs;
    var_5.stompprogressreward = &manualturret_watchdeathongameend;
    var_5.id = "domFlag";
    var_5.pinobj = 1;
    var_5.lockupdatingicons = 0;
    var_5.trigger = var_4;
    var_5.get_current_bush_zone = 0;
    var_5.ref_133a5 = 1;
    var_5.get_current_building_obj_struct = var_3;
    var_5.pos = var_2.origin;
    var_5.vfxent = spawn("script_model", var_5.pos);
    var_5.vfxent setModel("vfx_ri_dom");
    var_5.vfxent setscriptablepartstate("base", "neutral");
    var_5 scripts\mp\gameobjects::setcapturebehavior("persistent");
    var_5 scripts\mp\gameobjects::setusetime(level.start_reach_exhaust_waste.ref_122a1);
    thread map_dev_name_to_actual_station_name();
    thread mapcalloutsready();
    playencryptedcinematicforall(var_5.objidnum, 1);
    function_0442(var_5.objidnum, 1);
    level.start_reach_exhaust_waste.maphint_cheese2scriptableused = scripts\engine\utility::array_add(level.start_reach_exhaust_waste.maphint_cheese2scriptableused, var_5);
  }

  thread mapedgeextractionlocs();
}

function manualturret_endturretuseonexecution(var_0) {
  var_1 = var_0.team;
  self.get_current_station_signage_structs = var_1;
  self.capturetime = gettime();
  self.get_current_bush_zone = 1;

  if(self.touchlist[var_1].size == 0 && isDefined(self.oldtouchlist)) {
    self.touchlist = self.oldtouchlist;
  }

  self notify("dom_flag_end");
  thread manned_turret_spawn_func(var_1);
  self.firstcapture = 0;
}

function manual_turret_allowpickupofturret(var_0) {
  self.userate = 1;

  if(!isDefined(self.ref_11f63) || !self.ref_11f63) {
    self.ref_11f63 = 1;
    scripts\mp\gametypes\br_quest_util::ref_140b1(self.curorigin, "dom");
    var_1 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 0);

    foreach(var_3 in var_1) {
      var_3 notify("calloutmarkerping_warzoneKillQuestIcon");
    }
  }

  var_5 = scripts\mp\gameobjects::getownerteam();

  if(var_5 != self.claimteam) {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_losing_br", "waypoint_taking_br");
    return;
  }
}

function manualturret_endturretuseonpush(var_0, var_1, var_2, var_3) {
  self.userate = 1;

  if(var_1 < 1 && !level.gameended && !istrue(self.get_current_bush_zone)) {
    ref_12427(var_1, var_0);
  }

  if(var_1 > 0.05 && var_2 && !istrue(self.didstatusnotify)) {
    self.didstatusnotify = 1;
    return;
  }
}

function manual_turret_handlemovingplatform(var_0, var_1, var_2) {
  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_objective_state", 0);
    var_1.ui_dom_securing = undefined;
  }

  var_3 = scripts\mp\gameobjects::getownerteam();

  if(var_3 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_captureneutral_br");
    thread scripts\mp\gametypes\obj_dom::updateflagstate("idle", 0);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend_br", "waypoint_capture_br");
    thread scripts\mp\gametypes\obj_dom::updateflagstate(var_3, 0);
  }

  if(!var_2) {
    self.neutralized = 0;
    return;
  }
}

function manual_turret_canpickup() {
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_contested_br");
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  level thread scripts\mp\gametypes\br_public::brleaderdialog("exfil_contested");
  thread manned_turret_spawned_nodes();
}

function manned_turret_spawned_nodes() {
  level endon("game_ended");
  self notify("flag_contest");
  self endon("flag_contest");
  self endon("flag_uncontest");

  while(self.stalemate) {
    foreach(var_1 in self.ref_1265b) {
      if(isDefined(var_1.waittill_track_is_operational) && gettime() - var_1.waittill_track_is_operational < 5000) {
        continue;
      }

      var_1 thread scripts\mp\rank::giverankxp("ri_dom_flag_contest", 20, var_1.weapon, 0, 1);
      var_1 thread scripts\mp\rank::scoreeventpopup("ri_dom_flag_contest");
      var_1.waittill_track_is_operational = gettime();
    }

    wait 0.1;
  }
}

function manualturret_clearplacementinstructions(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = undefined;
  var_3 = mantlebrush();

  if(var_3 <= 1) {
    foreach(var_5 in level.teamnamelist) {
      var_6 = self.teamprogress[var_5];

      if(var_6 > 0) {
        var_2 = var_5;
        break;
      }
    }

    if(isDefined(var_2)) {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_2);
    } else if(var_1 != "neutral") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_1);
    } else if(var_0 != "none") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_0);
    }

    if(isDefined(self.get_current_station_signage_structs)) {
      if(self.get_current_station_signage_structs != var_0) {
        scripts\mp\gameobjects::setobjectivestatusicons("waypoint_losing_br", "waypoint_taking_br");
      } else {
        scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend_br", "waypoint_capture_br");
      }
    } else {
      scripts\mp\gameobjects::setobjectivestatusicons("waypoint_captureneutral_br");
    }

    if(var_0 == "none" || var_1 == "neutral") {
      self.didstatusnotify = 0;
    }

    self notify("flag_uncontest");
    return;
  }
}

function manualturret_disablecrouchpronemantle() {
  var_0 = scripts\mp\gameobjects::getownerteam();

  if(var_0 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_captureneutral_br");
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend_br", "waypoint_capture_br");
  }

  self.didstatusnotify = 0;
}

function manual_turret_operate_by_nearby_enemies(var_0) {
  if(self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending_br", "waypoint_capture_br");
    return;
  }
}

function manualturret_domonitoredweaponswitch(var_0) {
  if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend_br", "waypoint_capture_br");
    return;
  }
}

function manualadjustlittlebirdlocs(var_0) {
  self.userate = level.start_reach_exhaust_waste.manualturret_watchturretusetimeout;
  var_1 = scripts\mp\utility\teams::getenemyteams(var_0);
  var_2 = undefined;

  foreach(var_4 in var_1) {
    var_5 = self.teamprogress[var_4];

    if(var_5 > 0) {
      var_2 = var_5 / self.usetime;
    }
  }
}

function manualturret_watchdeathongameend(var_0) {
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("obj_prog_defend");
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending_br", "waypoint_capture_br");

  if(isDefined(self.lastprogressteam)) {
    self.lastprogressteam = undefined;
    return;
  }
}

function ref_12427(var_0, var_1) {
  if(!isDefined(self.lastsfxplayedtime)) {
    self.lastsfxplayedtime = gettime();
  }

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var_2 = "";
    var_0 = int(floor(var_0 * 10));
    var_2 = "mp_dom_capturing_tick_0" + var_0;
    self.visuals[0] playsoundtoteam(var_2, var_1);
    return;
  }
}

function manualturret_moving_platform_death(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::ter_op(var_0, "secured", "lost");
  var_4 = "uk";
  var_5 = "dx_mpa_" + var_4 + "tl_" + var_3 + var_2;

  if(soundexists(var_5)) {
    var_6 = var_3 + var_2;
    var_7 = lookupsoundlength(var_5, 1) / 1000;
    self queuedialogforplayer(var_5, var_6, var_7);
    return;
  }
}

function manned_turret_spawn_func(var_0) {
  if(isDefined(var_0) && var_0 != "tie") {
    var_1 = "";

    if(istrue(self.firstcapture)) {
      var_1 += "_first";
    } else if(istrue(level.start_reach_exhaust_waste.inovertime)) {
      var_1 += "_ot";
    }

    var_1 += self.trigger.iconname;

    foreach(var_3 in level.players) {
      if(isDefined(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
        var_3 thread scripts\mp\hud_message::showsplash("br_ri_dom_flag_captured_ally" + var_1);
        thread manualturret_moving_platform_death(var_3, 1, var_0);
        continue;
      }

      if(isDefined(var_3) && isDefined(var_3.team) && var_3.team != var_0) {
        var_3 thread scripts\mp\hud_message::showsplash("br_ri_dom_flag_captured_enemy" + var_1);
        thread manualturret_moving_platform_death(var_3, 0, var_0);
      }
    }

    var_5 = undefined;

    foreach(var_7 in self.touchlist[var_0]) {
      var_3 = var_7.player;
      var_3 thread scripts\mp\rank::giverankxp("rumble_dom_flag_capture", 250, var_3 getcurrentprimaryweapon());
      var_3 thread scripts\mp\rank::scoreeventpopup("rumble_dom_flag_capture");

      if(!isDefined(var_5)) {
        var_5 = var_3;
      }
    }

    thread manualturret_toggleallowplacementactions();
    scripts\mp\gametypes\obj_dom::dompoint_setcaptured(var_0, var_5);
    self.vfxent setscriptablepartstate("base", var_0);

    if(istrue(self.firstcapture)) {
      var_9 = getdvarint("scr_ri_points_capture_first", 5);
    } else {
      var_9 = getdvarint("scr_ri_points_capture", 10);
    }

    if(istrue(level.start_reach_exhaust_waste.inovertime)) {
      var_9 *= getdvarint("scr_ri_overtime_mod", 2);
    }

    level scripts\mp\gamescore::giveteamscoreforobjective(var_1, var_9, 0);
    return;
  }
}

function mapedgeextractionlocs() {
  level endon("game_ended");
  var_0 = getdvarint("scr_ri_points_per_tick", 1);
  var_1 = getdvarint("scr_ri_time_per_tick", 5);

  while(game["state"] == "playing") {
    foreach(var_3 in level.start_reach_exhaust_waste.maphint_cheese2scriptableused) {
      if(isDefined(var_3.ownerteam) && var_3.ownerteam != "neutral") {
        level scripts\mp\gamescore::giveteamscoreforobjective(var_3.ownerteam, var_0, 0);
      }
    }

    wait var_1;
  }
}

function manualturret_toggleallowplacementactions() {
  level thread scripts\mp\gametypes\br_gametype_rumble_invasion::ref_119f7(self.pos, "loot_table_dom_flag_capture_cash", 25);
  level thread scripts\mp\gametypes\br_gametype_rumble_invasion::ref_119f7(self.pos, "loot_table_dom_flag_capture_weapons", 5);
}

function mantlebrush() {
  var_0 = 0;

  foreach(var_2 in self.numtouching) {
    if(var_2 > 0 && (!isstring(var_3) || var_3 != "none")) {
      var_0++;
    }
  }

  return var_0;
}

function map_dev_name_to_actual_station_name() {
  level endon("game_ended");
  self.ref_1265b = [];

  for(;;) {
    self.trigger waittill("trigger", var_0);

    if((isPlayer(var_0) || isbot(var_0)) && !scripts\engine\utility::array_contains(self.ref_1265b, var_0)) {
      manual_turret_laststandwatcher(var_0);
    }

    waitframe();
  }
}

function mapcalloutsready() {
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in self.ref_1265b) {
      if(!var_1 istouching(self.trigger) || !isalive(var_1)) {
        manual_turret_munitionused(var_1);
      }
    }

    wait 0.1;
  }
}

function manual_turret_laststandwatcher(var_0) {
  self.ref_1265b = scripts\engine\utility::array_add(self.ref_1265b, var_0);
  var_0.truck_03_node = 1;
}

function manual_turret_munitionused(var_0) {
  self.ref_1265b = scripts\engine\utility::array_remove(self.ref_1265b, var_0);
  var_0.truck_03_node = 0;
}

function mantlekill(var_0, var_1) {
  if(istrue(var_1.truck_03_node)) {
    var_0 thread scripts\mp\rank::giverankxp("ri_dom_flag_enemy_kill", 20, var_0.weapon, 0, 1);
    var_0 thread scripts\mp\rank::scoreeventpopup("ri_dom_flag_enemy_kill");
  }

  if(istrue(var_0.truck_03_node)) {
    var_0 thread scripts\mp\rank::giverankxp("ri_dom_flag_defend_kill", 20, var_0.weapon, 0, 1);
    var_0 thread scripts\mp\rank::scoreeventpopup("ri_dom_flag_defend_kill");
    return;
  }
}