/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rumble_invasion\br_ri_pe_dom.gsc
*****************************************************************/

function init() {
  superonunset();
  level.start_reach_exhaust_waste.setupteamplunderhud = spawnStruct();
  level.start_reach_exhaust_waste.setupteamplunderhud.active = 0;
  level.start_reach_exhaust_waste.setupteamplunderhud.duration = getdvarint("scr_ri_pe_hardpoint_duration", 120);
  var0 = spawnStruct();
  var0.weight = getdvarfloat("scr_ri_pe_hardpoint_weight", 1);
  var0.attackerswaittime = &attackerswaittime;
  var0.ref_140cf = &ref_140cf;
  var0.ref_14382 = &ref_14382;
  var0.ref_11b78 = getdvarint("scr_ri_pe_hardpoint_max_times", 1);
  var0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("hardpoint", "10 5 0 0 0 0 0 0");
  scripts\mp\gametypes\br_publicevents::ref_12b35(101, var0);
}

function ref_140cf() {
  return false;
}

function ref_14382() {
  level endon("game_ended");
  level endon("cancel_public_event");
  var0 = forest_combat();
  wait var0;
}

function forest_combat() {
  var0 = getdvarfloat("scr_ri_pe_hardpoint_starttime_min", 795);
  var1 = getdvarfloat("scr_ri_pe_hardpoint_starttime_max", 1110);

  if(var1 > var0) {
    return randomfloatrange(var0, var1);
  }

  return var0;
}

function attackerswaittime() {
  var0 = randomint(level.start_reach_exhaust_waste.ref_12e2c.manualturret_toggleallowuseactions.size);
  ref_122c0(var0);
}

function superonunset() {
  level.start_reach_exhaust_waste.setupteamplunderleaderboard = [];

  for(var0 = 0; var0 < 7; var0++) {
    var1 = scripts\engine\utility::getStructArray("brRumbleInv_hardpoint_zones" + var0, "targetname");

    if(var1.size < 0) {
      continue;
    }

    var2 = [];

    foreach(var4 in var1) {
      var2 = var4.origin;
    }

    level.start_reach_exhaust_waste.setupteamplunderleaderboard = scripts\engine\utility::array_add(level.start_reach_exhaust_waste.setupteamplunderleaderboard, var2);
  }

  if(level.start_reach_exhaust_waste.setupteamplunderleaderboard.size < 0) {
    var6 = [[(1517, 643, 3154)], [(-16156, -12766, 946)], [(35718, 35730, 2010)], [(3109, 38466, 714)], [(-26003, 14132, 2286)], [(5385, -26020, 2630)], [(35361, -1082, 1226)]];
    level.start_reach_exhaust_waste.setupteamplunderleaderboard = var6;
  }

  for(var7 = 0; var7 < 4; var7++) {
    for(var8 = 0; var8 < level.start_reach_exhaust_waste.setupteamplunderleaderboard.size; var8++) {
      if(level.start_reach_exhaust_waste.setupteamplunderleaderboard[var8].size > 0) {
        ref_12af0(level.start_reach_exhaust_waste.ref_12e2c, var7, race_ui_checkpoint(var8));
      }
    }
  }
}

function ref_12af0(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = level.start_reach_exhaust_waste.maphints;
  }

  if(!isDefined(self.manualturret_toggleallowuseactions)) {
    self.manualturret_toggleallowuseactions = [];
  }

  if(!isDefined(self.manualturret_toggleallowuseactions[var0])) {
    self.manualturret_toggleallowuseactions[var0] = [];
  }

  var3 = spawnStruct();
  var3.ref_135ce = var0;
  var3.location = getgroundposition(var1, 5);
  var3.get_current_building_obj_struct = var2;
  self.manualturret_toggleallowuseactions[var0] = scripts\engine\utility::array_add(self.manualturret_toggleallowuseactions[var0], var3);
}

function ref_122c0(var0) {
  level endon("game_ended");

  if(!isDefined(level.start_reach_exhaust_waste.ref_12e2c.manualturret_toggleallowuseactions)) {
    ref_12af0(level.start_reach_exhaust_waste.ref_12e2c, var0, level.start_reach_exhaust_waste.ref_12e2c.ground_detection_think);
  }

  var1 = level.start_reach_exhaust_waste.ref_12e2c.manualturret_toggleallowuseactions[var0];
  level.start_reach_exhaust_waste.ref_12e2c.ref_122b5 = var0;

  if(!isDefined(var1) || var1.size <= 0) {
    return;
  }

  level.maphint_cheesescriptableused = var1.size;
  ref_122bf();

  if(getdvarint("scr_ri_skip_event_wait_times", 0) == 0) {
    level thread scripts\mp\gametypes\br_public::brleaderdialog("dom_point_incoming", 0);
    scripts\mp\gametypes\rumble_invasion\br_ri_ui::ref_12424("br_ri_pe_dom_flags_incoming");
    wait 20;
  }

  level thread scripts\mp\gametypes\br_public::brleaderdialog("dom_point_started", 0);
  scripts\mp\gametypes\rumble_invasion\br_ri_ui::ref_12424("br_ri_pe_dom_flags_online");
  wait 3;
  thread ref_122be();
}

function ref_122bc() {
  var0 = level.start_reach_exhaust_waste.ref_12e2c.manualturret_toggleallowuseactions[level.start_reach_exhaust_waste.ref_12e2c.ref_122b5];

  foreach(var2 in var0) {
    var3 = var2.manned_turret_operator_validation_func;
    var3 notify("pe_dom_flag_end");
    thread ref_122a3(var3);
  }
}

function ref_122bf() {
  var0 = level.start_reach_exhaust_waste.ref_12e2c.ref_122b5;
  var1 = level.start_reach_exhaust_waste.ref_12e2c.manualturret_toggleallowuseactions[var0];

  foreach(var3 in var1) {
    thread ref_122b7();
  }
}

function ref_122be() {
  var0 = ["_a", "_b", "_c", "_d", "_e", "_f", "_g"];

  if(!isDefined(level.start_reach_exhaust_waste.are_all_players_in_region)) {
    level.start_reach_exhaust_waste.are_all_players_in_region = [];
    level.start_reach_exhaust_waste.are_all_players_in_region["allies"] = 0;
    level.start_reach_exhaust_waste.are_all_players_in_region["axis"] = 0;
  }

  if(!isDefined(level.start_reach_exhaust_waste.spawnsecretstashlootcache)) {
    level.start_reach_exhaust_waste.spawnsecretstashlootcache = 0;
  }

  var1 = level.start_reach_exhaust_waste.ref_12e2c.ref_122b5;
  var2 = level.start_reach_exhaust_waste.ref_12e2c.manualturret_toggleallowuseactions[var1];

  foreach(var8, var4 in var2) {
    var5 = scripts\engine\utility::ter_op(isDefined(var4.get_current_building_obj_struct), var4.get_current_building_obj_struct, level.start_reach_exhaust_waste.maphints);
    var6 = spawn("trigger_radius", var4.location, 0, int(var5), int(level.defend_wave_3));
    var6.script_label = var0[level.start_reach_exhaust_waste.spawnsecretstashlootcache];
    var6.iconname = var0[level.start_reach_exhaust_waste.spawnsecretstashlootcache];
    level.start_reach_exhaust_waste.spawnsecretstashlootcache++;
    var2[var8].trigger = var6;
    var7 = scripts\mp\gametypes\obj_dom::setupobjective(var2[var8].trigger, "neutral");
    var7.onuse = &ref_122b2;
    var7.onbeginuse = &ref_122a8;
    var7.onuseupdate = &ref_122b3;
    var7.onenduse = &ref_122aa;
    var7.oncontested = &ref_122a9;
    var7.onuncontested = &ref_122af;
    var7.onunoccupied = &ref_122b0;
    var7.onpinnedstate = &ref_122ad;
    var7.onunpinnedstate = &ref_122b1;
    var7.ref_138b2 = &ref_122ae;
    var7.stompprogressreward = &ref_122b8;
    var7.id = "domFlag";
    var7.pinobj = 1;
    var7.lockupdatingicons = 1;
    var7.trigger = var6;
    var7.get_current_bush_zone = 0;
    var7.get_current_building_obj_struct = var5;
    var7.pos = var4.location;
    var7.vfxent = var4.vfxent;
    var7 scripts\mp\gameobjects::setcapturebehavior("persistent");
    var7 scripts\mp\gameobjects::setusetime(level.start_reach_exhaust_waste.ref_122a1);
    playencryptedcinematicforall(var7.objidnum, 1);
    var7.ref_11ad0 = [];
    var7.ref_11ad0["ally"] = spawnStruct();
    var7.ref_11ad0["enemy"] = spawnStruct();
    var7.ref_11ad0["neutral"] = spawnStruct();
    var7.waittill_pickup_or_timeout = "undefined";
    ref_122a4(var7.ref_11ad0["neutral"], 9, var7.curorigin, var5);
    ref_122a4(var7.ref_11ad0["ally"], 8, var7.curorigin, var5);
    ref_122a4(var7.ref_11ad0["enemy"], 0, var7.curorigin, var5);
    ref_122bb(var7, "neutral");
    thread ref_122b9();
    thread ref_122ba();
    var2[var8].manned_turret_operator_validation_func = var7;
    wait 0.5;
  }
}

function ref_122ab(var0) {
  self.ref_1265b = scripts\engine\utility::array_add(self.ref_1265b, var0);
  var0.truck_04_node = 1;
}

function ref_122ac(var0) {
  self.ref_1265b = scripts\engine\utility::array_remove(self.ref_1265b, var0);
  var0.truck_04_node = 0;
}

function ref_122b9() {
  self endon("game_ended");
  self.ref_1265b = [];

  while(!self.get_current_bush_zone) {
    self.trigger waittill("trigger", var0);

    if((isPlayer(var0) || isbot(var0)) && !scripts\engine\utility::array_contains(self.ref_1265b, var0)) {
      ref_122ab(var0);
    }

    waitframe();
  }
}

function ref_122ba() {
  self endon("game_ended");

  while(!self.get_current_bush_zone) {
    foreach(var1 in self.ref_1265b) {
      if(!var1 istouching(self.trigger) || !isalive(var1)) {
        ref_122ac(var1);
      }
    }

    wait 0.1;
  }

  foreach(var1 in self.ref_1265b) {
    ref_122ac(var1);
  }
}

function ref_122a7(var0, var1) {
  if(istrue(var1.truck_04_node)) {
    var0 thread scripts\mp\rank::giverankxp("rumble_dom_flag_enemy_kill", 20, var0.weapon, 0, 1);
    var0 thread scripts\mp\rank::scoreeventpopup("rumble_dom_flag_enemy_kill");
  }

  if(istrue(var0.truck_04_node)) {
    var0 thread scripts\mp\rank::giverankxp("rumble_dom_flag_defend_kill", 20, var0.weapon, 0, 1);
    var0 thread scripts\mp\rank::scoreeventpopup("rumble_dom_flag_defend_kill");
    return;
  }
}

function ref_122a4(var0, var1, var2) {
  scripts\mp\gametypes\br_quest_util::init_tactical_boxes(var0, 0, 0, var1);
  scripts\mp\gametypes\br_quest_util::ref_1316f(int(var2));
}

function ref_122bb(var0) {
  if(var0 != self.waittill_pickup_or_timeout) {
    self.waittill_pickup_or_timeout = var0;

    foreach(var2 in self.ref_11ad0) {
      var2 scripts\mp\gametypes\br_quest_util::spawn_double_cargo();
    }

    var4 = self.waittill_pickup_or_timeout != "axis" && self.waittill_pickup_or_timeout != "allies";
    var5 = undefined;

    foreach(var7 in level.players) {
      var8 = var7.team == self.waittill_pickup_or_timeout;

      if(var4) {
        var5 = self.ref_11ad0["neutral"];
      } else {
        var5 = scripts\engine\utility::ter_op(var8, self.ref_11ad0["ally"], self.ref_11ad0["enemy"]);
      }

      if(isDefined(var5)) {
        var5 scripts\mp\gametypes\br_quest_util::ref_1336a(var7);
      }
    }

    if(isDefined(var5)) {
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.objidnum, var0);
      return;
    }

    return;
  }
}

function ref_122a5() {
  foreach(var1 in self.ref_11ad0) {
    if(isDefined(var1)) {
      var1 scripts\mp\gametypes\br_quest_util::lastdirtyscore();
    }
  }
}

function ref_122b2(var0) {
  var1 = var0.team;
  self.get_current_station_signage_structs = var1;
  self.capturetime = gettime();
  self.get_current_bush_zone = 1;

  if(self.touchlist[var1].size == 0 && isDefined(self.oldtouchlist)) {
    self.touchlist = self.oldtouchlist;
  }

  self notify("pe_dom_flag_end");
  thread ref_122a2(var1);
}

function ref_122a8(var0) {
  self.userate = 1;

  if(!isDefined(self.ref_11f63) || !self.ref_11f63) {
    self.ref_11f63 = 1;
    scripts\mp\gametypes\br_quest_util::ref_140b1(self.curorigin, "dom");
    var1 = scripts\mp\utility\teams::getfriendlyplayers(var0.team, 0);

    foreach(var3 in var1) {
      var3 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    return;
  }
}

function ref_122b3(var0, var1, var2, var3) {
  self.userate = 1;

  if(var1 < 1 && !level.gameended && !istrue(self.get_current_bush_zone)) {
    ref_12427(var1, var0);
  }

  if(var1 > 0.05 && var2 && !istrue(self.didstatusnotify)) {
    self.didstatusnotify = 1;
  }

  ref_122bb(var0);
}

function ref_122aa(var0, var1, var2) {
  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var0, var1, var2);
}

function ref_122a9() {
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_contested_br");
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  level thread scripts\mp\gametypes\br_public::brleaderdialog("exfil_contested");
  var0 = scripts\mp\gameobjects::getownerteam();
}

function ref_122af(var0) {
  var1 = scripts\mp\gameobjects::getownerteam();
  var2 = undefined;
  var3 = ref_122a6();

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

    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend_br", "waypoint_capture_br");

    if(var0 == "none" || var1 == "neutral") {
      self.didstatusnotify = 0;
      return;
    }

    return;
  }
}

function ref_122b0() {
  var0 = scripts\mp\gameobjects::getownerteam();

  if(var0 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_captureneutral_br");
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend_br", "waypoint_capture_br");
  }

  self.didstatusnotify = 0;
}

function ref_122ad(var0) {
  if(self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending_br", "waypoint_capture_br");
    return;
  }
}

function ref_122b1(var0) {
  if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend_br", "waypoint_capture_br");
    return;
  }
}

function ref_122ae(var0) {
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

function ref_122b8(var0) {
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

function ref_122a2(var0) {
  if(isDefined(var0) && var0 != "tie") {
    level.start_reach_exhaust_waste.are_all_players_in_region[var0] += 1;

    foreach(var2 in level.players) {
      if(isDefined(var2) && isDefined(var2.team) && var2.team == var0) {
        thread ref_122b4(var2, 1);
        var2 thread scripts\mp\hud_message::showsplash("br_ri_pe_dom_flag_captured_ally");
        continue;
      }

      if(isDefined(var2) && isDefined(var2.team) && var2.team != var0) {
        thread ref_122b4(var2, 0);
        var2 thread scripts\mp\hud_message::showsplash("br_ri_pe_dom_flag_captured_enemy");
      }
    }

    var4 = undefined;

    foreach(var6 in self.touchlist[var0]) {
      var2 = var6.player;
      var2 thread scripts\mp\rank::giverankxp("rumble_dom_flag_capture", 250, var2 getcurrentprimaryweapon());
      var2 thread scripts\mp\rank::scoreeventpopup("rumble_dom_flag_capture");

      if(!isDefined(var4)) {
        var4 = var2;
      }
    }

    thread ref_122b6();
    thread ref_122a3(self);
    return;
  }
}

function ref_122b4(var0, var1) {
  var2 = level.start_reach_exhaust_waste.are_all_players_in_region[var1];

  switch (var2) {
    case 1:
      if(var0) {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dom_point_friendly_capture_1", self);
      } else {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dom_point_enemy_capture_1", self);
      }

      break;
    case 2:
      if(var0) {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dom_point_friendly_capture_2", self);
      } else {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dom_point_enemy_capture_2", self);
      }

      break;
    case 3:
      if(var0) {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dom_point_friendly_capture_all", self);
      } else {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dom_point_enemy_capture_all", self);
      }

      break;
  }
}

function ref_122a3(var0) {
  if(isDefined(var0.vfxent)) {
    stopFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_green"), var0.vfxent, "tag_origin");
  }

  level.maphint_cheesescriptableused--;

  if(level.maphint_cheesescriptableused == 0) {
    var1 = scripts\mp\gamelogic::gettimeremaining() / 1000;
    level.manifest_music_started = -1;
    level.manned_turret_createhintobject = ceil(var1) - 60 + 20;
  }

  ref_122a5(var0);
  scripts\mp\gametypes\obj_dom::removeobjective(var0);
}

function ref_122b7() {
  var0 = spawn("script_model", self.location - (0, 0, 3));
  var0 setModel("tag_origin");
  self.vfxent = var0;
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_green"), var0, "tag_origin");
}

function ref_122b6() {
  level thread scripts\mp\gametypes\br_gametype_rumble_invasion::ref_119f7(self.pos, "loot_table_dom_flag_capture_cash", 25);
  level thread scripts\mp\gametypes\br_gametype_rumble_invasion::ref_119f7(self.pos, "loot_table_dom_flag_capture_weapons", 5);
}

function ref_122a6() {
  var0 = 0;

  foreach(var2 in self.numtouching) {
    if(var2 > 0 && (!isstring(var3) || var3 != "none")) {
      var0++;
    }
  }

  return var0;
}

function race_ui_checkpoint(var0) {
  var1 = randomint(level.start_reach_exhaust_waste.setupteamplunderleaderboard[var0].size);
  return level.start_reach_exhaust_waste.setupteamplunderleaderboard[var0][var1];
}