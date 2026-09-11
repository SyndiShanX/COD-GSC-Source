/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rumble_invasion\br_ri_dom.gsc
**************************************************************/

function maphint_computerscriptableused() {
  scripts\mp\gametypes\br_rumble_invasion_dom_mp_wz_island::initstructs();
  level.defend_wave_3 = getdvarint("scr_br_domHeight", 250);
  var0 = ["_a", "_b", "_c", "_d", "_e", "_f", "_g"];

  if(!isDefined(level.start_reach_exhaust_waste.maphint_phonescriptableused)) {
    level.start_reach_exhaust_waste.maphint_phonescriptableused = scripts\engine\utility::getStructArray("brRumbleInv_dom_points", "targetname");
  }

  if(!isDefined(level.start_reach_exhaust_waste.maphint_cheese2scriptableused)) {
    level.start_reach_exhaust_waste.maphint_cheese2scriptableused = [];
  }

  foreach(var2 in level.start_reach_exhaust_waste.maphint_phonescriptableused) {
    var3 = level.start_reach_exhaust_waste.maphints;
    var4 = spawn("trigger_radius", var2.origin, 0, int(var3), int(level.defend_wave_3));
    var4.script_label = var0[var6];
    var4.iconname = var0[var6];
    var5 = scripts\mp\gametypes\obj_dom::setupobjective(var4, "neutral");
    var5.onuse = &manualturret_endturretuseonexecution;
    var5.onbeginuse = &manual_turret_allowpickupofturret;
    var5.onuseupdate = &manualturret_endturretuseonpush;
    var5.onenduse = &manual_turret_handlemovingplatform;
    var5.oncontested = &manual_turret_canpickup;
    var5.onuncontested = &manualturret_clearplacementinstructions;
    var5.onunoccupied = &manualturret_disablecrouchpronemantle;
    var5.onpinnedstate = &manual_turret_operate_by_nearby_enemies;
    var5.onunpinnedstate = &manualturret_domonitoredweaponswitch;
    var5.ref_138b2 = &manualadjustlittlebirdlocs;
    var5.stompprogressreward = &manualturret_watchdeathongameend;
    var5.id = "domFlag";
    var5.pinobj = 1;
    var5.lockupdatingicons = 0;
    var5.trigger = var4;
    var5.get_current_bush_zone = 0;
    var5.ref_133a5 = 1;
    var5.get_current_building_obj_struct = var3;
    var5.pos = var2.origin;
    var5.vfxent = spawn("script_model", var5.pos);
    var5.vfxent setModel("vfx_ri_dom");
    var5.vfxent setscriptablepartstate("base", "neutral");
    var5 scripts\mp\gameobjects::setcapturebehavior("persistent");
    var5 scripts\mp\gameobjects::setusetime(level.start_reach_exhaust_waste.ref_122a1);
    thread map_dev_name_to_actual_station_name();
    thread mapcalloutsready();
    playencryptedcinematicforall(var5.objidnum, 1);
    function_0442(var5.objidnum, 1);
    level.start_reach_exhaust_waste.maphint_cheese2scriptableused = scripts\engine\utility::array_add(level.start_reach_exhaust_waste.maphint_cheese2scriptableused, var5);
  }

  thread mapedgeextractionlocs();
}

function manualturret_endturretuseonexecution(var0) {
  var1 = var0.team;
  self.get_current_station_signage_structs = var1;
  self.capturetime = gettime();
  self.get_current_bush_zone = 1;

  if(self.touchlist[var1].size == 0 && isDefined(self.oldtouchlist)) {
    self.touchlist = self.oldtouchlist;
  }

  self notify("dom_flag_end");
  thread manned_turret_spawn_func(var1);
  self.firstcapture = 0;
}

function manual_turret_allowpickupofturret(var0) {
  self.userate = 1;

  if(!isDefined(self.ref_11f63) || !self.ref_11f63) {
    self.ref_11f63 = 1;
    scripts\mp\gametypes\br_quest_util::ref_140b1(self.curorigin, "dom");
    var1 = scripts\mp\utility\teams::getfriendlyplayers(var0.team, 0);

    foreach(var3 in var1) {
      var3 notify("calloutmarkerping_warzoneKillQuestIcon");
    }
  }

  var5 = scripts\mp\gameobjects::getownerteam();

  if(var5 != self.claimteam) {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_losing_br", "waypoint_taking_br");
    return;
  }
}

function manualturret_endturretuseonpush(var0, var1, var2, var3) {
  self.userate = 1;

  if(var1 < 1 && !level.gameended && !istrue(self.get_current_bush_zone)) {
    ref_12427(var1, var0);
  }

  if(var1 > 0.05 && var2 && !istrue(self.didstatusnotify)) {
    self.didstatusnotify = 1;
    return;
  }
}

function manual_turret_handlemovingplatform(var0, var1, var2) {
  if(isPlayer(var1)) {
    var1 setclientomnvar("ui_objective_state", 0);
    var1.ui_dom_securing = undefined;
  }

  var3 = scripts\mp\gameobjects::getownerteam();

  if(var3 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_captureneutral_br");
    thread scripts\mp\gametypes\obj_dom::updateflagstate("idle", 0);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend_br", "waypoint_capture_br");
    thread scripts\mp\gametypes\obj_dom::updateflagstate(var3, 0);
  }

  if(!var2) {
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
    foreach(var1 in self.ref_1265b) {
      if(isDefined(var1.waittill_track_is_operational) && gettime() - var1.waittill_track_is_operational < 5000) {
        continue;
      }

      var1 thread scripts\mp\rank::giverankxp("ri_dom_flag_contest", 20, var1.weapon, 0, 1);
      var1 thread scripts\mp\rank::scoreeventpopup("ri_dom_flag_contest");
      var1.waittill_track_is_operational = gettime();
    }

    wait 0.1;
  }
}

function manualturret_clearplacementinstructions(var0) {
  var1 = scripts\mp\gameobjects::getownerteam();
  var2 = undefined;
  var3 = mantlebrush();

  if(var3 <= 1) {
    foreach(var5 in level.teamnamelist) {
      var6 = self.teamprogress[var5];

      if(var6 > 0) {
        var2 = var5;
        break;
      }
    }

    if(isDefined(var2)) {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var2);
    } else if(var1 != "neutral") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var1);
    } else if(var0 != "none") {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var0);
    }

    if(isDefined(self.get_current_station_signage_structs)) {
      if(self.get_current_station_signage_structs != var0) {
        scripts\mp\gameobjects::setobjectivestatusicons("waypoint_losing_br", "waypoint_taking_br");
      } else {
        scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend_br", "waypoint_capture_br");
      }
    } else {
      scripts\mp\gameobjects::setobjectivestatusicons("waypoint_captureneutral_br");
    }

    if(var0 == "none" || var1 == "neutral") {
      self.didstatusnotify = 0;
    }

    self notify("flag_uncontest");
    return;
  }
}

function manualturret_disablecrouchpronemantle() {
  var0 = scripts\mp\gameobjects::getownerteam();

  if(var0 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_captureneutral_br");
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend_br", "waypoint_capture_br");
  }

  self.didstatusnotify = 0;
}

function manual_turret_operate_by_nearby_enemies(var0) {
  if(self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending_br", "waypoint_capture_br");
    return;
  }
}

function manualturret_domonitoredweaponswitch(var0) {
  if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend_br", "waypoint_capture_br");
    return;
  }
}

function manualadjustlittlebirdlocs(var0) {
  self.userate = level.start_reach_exhaust_waste.manualturret_watchturretusetimeout;
  var1 = scripts\mp\utility\teams::getenemyteams(var0);
  var2 = undefined;

  foreach(var4 in var1) {
    var5 = self.teamprogress[var4];

    if(var5 > 0) {
      var2 = var5 / self.usetime;
    }
  }
}

function manualturret_watchdeathongameend(var0) {
  var0 thread scripts\mp\utility\points::giveunifiedpoints("obj_prog_defend");
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending_br", "waypoint_capture_br");

  if(isDefined(self.lastprogressteam)) {
    self.lastprogressteam = undefined;
    return;
  }
}

function ref_12427(var0, var1) {
  if(!isDefined(self.lastsfxplayedtime)) {
    self.lastsfxplayedtime = gettime();
  }

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var2 = "";
    var0 = int(floor(var0 * 10));
    var2 = "mp_dom_capturing_tick_0" + var0;
    self.visuals[0] playsoundtoteam(var2, var1);
    return;
  }
}

function manualturret_moving_platform_death(var0, var1, var2) {
  var3 = scripts\engine\utility::ter_op(var0, "secured", "lost");
  var4 = "uk";
  var5 = "dx_mpa_" + var4 + "tl_" + var3 + var2;

  if(soundexists(var5)) {
    var6 = var3 + var2;
    var7 = lookupsoundlength(var5, 1) / 1000;
    self queuedialogforplayer(var5, var6, var7);
    return;
  }
}

function manned_turret_spawn_func(var0) {
  if(isDefined(var0) && var0 != "tie") {
    var1 = "";

    if(istrue(self.firstcapture)) {
      var1 += "_first";
    } else if(istrue(level.start_reach_exhaust_waste.inovertime)) {
      var1 += "_ot";
    }

    var1 += self.trigger.iconname;

    foreach(var3 in level.players) {
      if(isDefined(var3) && isDefined(var3.team) && var3.team == var0) {
        var3 thread scripts\mp\hud_message::showsplash("br_ri_dom_flag_captured_ally" + var1);
        thread manualturret_moving_platform_death(var3, 1, var0);
        continue;
      }

      if(isDefined(var3) && isDefined(var3.team) && var3.team != var0) {
        var3 thread scripts\mp\hud_message::showsplash("br_ri_dom_flag_captured_enemy" + var1);
        thread manualturret_moving_platform_death(var3, 0, var0);
      }
    }

    var5 = undefined;

    foreach(var7 in self.touchlist[var0]) {
      var3 = var7.player;
      var3 thread scripts\mp\rank::giverankxp("rumble_dom_flag_capture", 250, var3 getcurrentprimaryweapon());
      var3 thread scripts\mp\rank::scoreeventpopup("rumble_dom_flag_capture");

      if(!isDefined(var5)) {
        var5 = var3;
      }
    }

    thread manualturret_toggleallowplacementactions();
    scripts\mp\gametypes\obj_dom::dompoint_setcaptured(var0, var5);
    self.vfxent setscriptablepartstate("base", var0);

    if(istrue(self.firstcapture)) {
      var9 = getdvarint("scr_ri_points_capture_first", 5);
    } else {
      var9 = getdvarint("scr_ri_points_capture", 10);
    }

    if(istrue(level.start_reach_exhaust_waste.inovertime)) {
      var9 *= getdvarint("scr_ri_overtime_mod", 2);
    }

    level scripts\mp\gamescore::giveteamscoreforobjective(var1, var9, 0);
    return;
  }
}

function mapedgeextractionlocs() {
  level endon("game_ended");
  var0 = getdvarint("scr_ri_points_per_tick", 1);
  var1 = getdvarint("scr_ri_time_per_tick", 5);

  while(game["state"] == "playing") {
    foreach(var3 in level.start_reach_exhaust_waste.maphint_cheese2scriptableused) {
      if(isDefined(var3.ownerteam) && var3.ownerteam != "neutral") {
        level scripts\mp\gamescore::giveteamscoreforobjective(var3.ownerteam, var0, 0);
      }
    }

    wait var1;
  }
}

function manualturret_toggleallowplacementactions() {
  level thread scripts\mp\gametypes\br_gametype_rumble_invasion::ref_119f7(self.pos, "loot_table_dom_flag_capture_cash", 25);
  level thread scripts\mp\gametypes\br_gametype_rumble_invasion::ref_119f7(self.pos, "loot_table_dom_flag_capture_weapons", 5);
}

function mantlebrush() {
  var0 = 0;

  foreach(var2 in self.numtouching) {
    if(var2 > 0 && (!isstring(var3) || var3 != "none")) {
      var0++;
    }
  }

  return var0;
}

function map_dev_name_to_actual_station_name() {
  level endon("game_ended");
  self.ref_1265b = [];

  for(;;) {
    self.trigger waittill("trigger", var0);

    if((isPlayer(var0) || isbot(var0)) && !scripts\engine\utility::array_contains(self.ref_1265b, var0)) {
      manual_turret_laststandwatcher(var0);
    }

    waitframe();
  }
}

function mapcalloutsready() {
  level endon("game_ended");

  for(;;) {
    foreach(var1 in self.ref_1265b) {
      if(!var1 istouching(self.trigger) || !isalive(var1)) {
        manual_turret_munitionused(var1);
      }
    }

    wait 0.1;
  }
}

function manual_turret_laststandwatcher(var0) {
  self.ref_1265b = scripts\engine\utility::array_add(self.ref_1265b, var0);
  var0.truck_03_node = 1;
}

function manual_turret_munitionused(var0) {
  self.ref_1265b = scripts\engine\utility::array_remove(self.ref_1265b, var0);
  var0.truck_03_node = 0;
}

function mantlekill(var0, var1) {
  if(istrue(var1.truck_03_node)) {
    var0 thread scripts\mp\rank::giverankxp("ri_dom_flag_enemy_kill", 20, var0.weapon, 0, 1);
    var0 thread scripts\mp\rank::scoreeventpopup("ri_dom_flag_enemy_kill");
  }

  if(istrue(var0.truck_03_node)) {
    var0 thread scripts\mp\rank::giverankxp("ri_dom_flag_defend_kill", 20, var0.weapon, 0, 1);
    var0 thread scripts\mp\rank::scoreeventpopup("ri_dom_flag_defend_kill");
    return;
  }
}