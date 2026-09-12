/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_multisquad_pve.gsc
***************************************************************/

function init() {
  scripts\mp\agents\agent_encounter_manager::init();
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("circle");
  init_vfx();
  thread table_getaddblueprintattachments();
}

function init_vfx() {}

function table_getaddblueprintattachments() {
  waitframe();
  tarmac_techo_start();
  thread raid_watch_for_start();
}

function tarmac_techo_start() {
  level.raid_struct = spawnStruct();
  level.raid_struct.i_current_phase = 0;
  level.raid_struct.i_objective_index = 0;
  level.raid_struct.a_phases = [];
  level.raid_struct.a_objective_locations_unused = [];
  level.raid_struct.a_objective_locations_typed = [];
  level.raid_struct.a_objectives_active = [];
  level.raid_struct.a_objectives_completed = [];
  init_map_variables();
  init_raid_variables();
}

function init_map_variables() {
  switch (getDvar("mapname")) {
    case "mp_sm_island_1":
      register_objective_location("winery2", (3313, -398, 1385), (0, -2, 0));
      register_objective_location("radio", (3399, -3958, 1108), (0, 21, 0));
      register_objective_location("lighthouse", (7513, -5579, 565), (0, 331, 0));
      register_objective_location("winery", (7777, 512, 1070), (0, 195, 0));
      register_objective_location("grotto", (-1300, -1331, 249), (0, 31, 0));
      register_objective_location("camp", (-3496, -4755, 977), (0, 105, 0));
      register_objective_location("library", (-6638, -244, 1249), (0, -2, 0));
      register_objective_location("graveyard", (-4214, 2145, 1406), (0, 21, 0));
      register_objective_location("terraces", (-1468, 6260, 1485), (0, 331, 0));
      register_objective_location("church", (-1279, 3698, 1408), (0, 195, 0));
      register_objective_location("fort", (3142, 6800, 1180), (0, 31, 0));
      register_objective_location("airstrip", (11730, -3835, 555), (0, 105, 0));
      register_objective_location("clocktower_nest", (-7243, 765, 1511), (0, -2, 0));
      register_objective_location("keep_west_nest", (-2837, 4387, 2102), (0, 21, 0));
      register_objective_location("keep_east_nest", (3033, 1795, 1782), (0, 331, 0));
      register_objective_location("winery_nest", (6845, 79, 1703), (0, 195, 0));
      register_objective_location("lighthouse_nest", (6560, -5507, 1119), (0, 31, 0));
      register_objective_location("radio_nest", (3252, -4398, 1215), (0, 105, 0));
      var_0 = ["winery2", "radio", "lighthouse", "winery", "grotto", "camp", "library", "graveyard", "terraces", "church", "fort", "airstrip"];
      assign_objective_type_locations("domination", var_0);
      assign_objective_type_locations("sweep_and_clear", var_0);
      var_0 = ["clocktower_nest", "keep_west_nest", "keep_east_nest", "winery_nest", "lighthouse_nest", "radio_nest"];
      assign_objective_type_locations("overwatch", var_0);
      var_0 = ["airstrip", "clocktower_nest", "keep_west_nest", "keep_east_nest", "winery_nest", "lighthouse_nest", "radio_nest"];
      assign_objective_type_locations("assassination", var_0);
      break;
  }
}

function init_raid_variables() {
  var_0 = getDvar("multisquad_pve_instance", "test");

  switch (var_0) {
    case "test":
      init_test_raid();
      break;
  }
}

function raid_watch_for_start() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  thread raid_start();
}

function raid_start() {
  thread raid_watch_for_next_phase();
  thread raid_watch_for_raid_complete();
  thread raid_watch_for_raid_failed();
  level waittill("infils_ready");
  [[level.raid_struct.a_phases[0]]]();
}

function raid_watch_for_next_phase() {
  level endon("game_ended");

  for(;;) {
    level waittill("raid_phase_complete");

    if(level.raid_struct.i_current_phase + 1 >= level.raid_struct.a_phases.size) {
      level notify("raid_complete");
      break;
    }

    thread raid_start_next_phase();
  }
}

function raid_start_next_phase(var_0) {
  if(isDefined(var_0)) {
    level.raid_struct.i_current_phase = var_0;
  } else {
    level.raid_struct.i_current_phase++;
  }

  [[level.raid_struct.a_phases[level.raid_struct.i_current_phase]]]();
}

function raid_watch_for_raid_complete() {
  level endon("raid_failed");
  level waittill("raid_complete");
  level thread scripts\mp\gametypes\br::brendgame("allies", game["end_reason"]["objective_complete"]);
}

function raid_watch_for_raid_failed() {
  level endon("raid_complete");
  GscBinSkip4(0x6e, level);
}

function raid_watch_for_wipe() {
  for(;;) {
    var_0 = 1;

    foreach(var_2 in level.players) {
      if(isalive(var_2)) {
        var_0 = 0;
      }
    }

    if(var_0) {
      level notify("raid_failed");
      break;
    }

    wait 1;
  }
}

function ___test() {}

function init_test_raid() {
  scripts\mp\agents\agent_encounter_manager::register_agent_class("rifle_guy", "actor_enemy_lw_br", 0, undefined, 1);
  scripts\mp\agents\agent_encounter_manager::register_agent_class("heavy_rifle_guy", "actor_enemy_lw_br", 1, undefined, 1);
  level.raid_struct.a_phases[0] = &test_raid_phase_0;
  level.raid_struct.a_phases[1] = &test_raid_phase_1;
  level.raid_struct.a_phases[2] = &test_raid_phase_2;
}

function test_raid_phase_0() {
  var_0 = scripts\mp\agents\agent_encounter_manager::make_spawn_params_radius(0, 1100);
  var_1 = scripts\mp\agents\agent_encounter_manager::init_encounter_params_swarm(12, undefined, "rifle_guy", var_0);
  start_objectives("domination", 1, var_1);
  var_0 = scripts\mp\agents\agent_encounter_manager::make_spawn_params_radius(0, 1100);
  var_2 = [];
  GscBinSkip0(0x2e, 0, scripts\mp\agents\agent_encounter_manager::make_wave(12, 6, "rifle_guy", var_0));
}

function test_raid_phase_1() {
  var_0 = scripts\mp\agents\agent_encounter_manager::make_spawn_params_radius(0, 1400);
  var_1 = scripts\mp\agents\agent_encounter_manager::init_encounter_params_swarm(18, undefined, "heavy_rifle_guy", var_0);
  start_objectives("domination", 1, var_1);

  while(get_objectives_active().size > 1) {
    wait 1;
  }

  wait 3;
  start_objectives("domination", 1, var_1);
  var_2 = get_objectives_active()[scripts\engine\utility::cointoss()];

  if(!isDefined(var_2)) {
    var_2 = get_objectives_active()[0];
  }

  wait 3;
  var_2.ai_encounter scripts\mp\agents\agent_encounter_manager::inrease_ai_budget_by(12);
  var_3 = undefined;

  switch (var_2.ai_encounter.id) {
    case 0:
      var_3 = "A";
      break;
    case 1:
      var_3 = "B";
      break;
    case 2:
      var_3 = "C";
      break;
    case 3:
      var_3 = "D";
      break;
    case 4:
      var_3 = "E";
      break;
  }

  while(get_objectives_active().size > 0) {
    wait 1;
  }

  wait 3;
  level notify("raid_phase_complete");
}

function test_raid_phase_2() {
  reset_objective_index();
  var_0 = scripts\mp\agents\agent_encounter_manager::make_spawn_params_radius(0, 2900);
  var_1 = scripts\mp\agents\agent_encounter_manager::init_encounter_params_swarm(48, undefined, "rifle_guy", var_0);
  start_objectives("domination", 1, var_1);
  set_as_final_objective(get_objectives_active()[0]);

  while(get_objectives_active().size > 0) {
    wait 1;
  }

  level notify("raid_phase_complete");
}

function ___objectives() {}

function register_objective_location(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.id = var_0;
  var_3.origin = var_1;
  var_3.angles = var_2;
  level.raid_struct.a_objective_locations_unused = scripts\engine\utility::array_add(level.raid_struct.a_objective_locations_unused, var_3);
}

function assign_objective_type_locations(var_0, var_1) {
  level.raid_struct.a_objective_locations_typed[var_0] = var_1;
  level.raid_struct.a_objectives_active[var_0] = [];
  level.raid_struct.a_objectives_completed[var_0] = [];
}

function start_objectives(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_1; var_3++) {
    start_objective(var_0, var_2);
    wait 3;
  }
}

function start_objective(var_0, var_1) {
  var_2 = randomint(level.raid_struct.a_objective_locations_typed[var_0].size);
  var_3 = level.raid_struct.a_objective_locations_typed[var_0][var_2];
  var_4 = undefined;

  foreach(var_6 in level.raid_struct.a_objective_locations_unused) {
    if(var_6.id == var_3) {
      var_4 = var_6;
      break;
    }
  }

  var_8 = objective_init(var_0, var_4);
  mark_objective_active(var_8);

  switch (var_0) {
    case "domination":
      objective_icon_init("DOM_CAPTURE");
      start_objective_domination(var_8, var_1);
      break;
    case "overwatch":
      objective_icon_init("OVERWATCH");
      start_objective_overwatch(var_8, var_1);
      break;
    case "sweep_and_clear":
      objective_icon_init("SWEEP_AND_CLEAR");
      start_objective_sweep_and_clear(var_8, var_1);
      break;
    case "assassination":
      objective_icon_init("ASSASSINATE");
      start_objective_assassination(var_8, var_1);
      break;
  }
}

function objective_init(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.type = var_0;
  var_2.origin = scripts\engine\utility::ter_op(isDefined(var_1.origin), var_1.origin, (0, 0, 0));
  var_2.angles = scripts\engine\utility::ter_op(isDefined(var_1.angles), var_1.angles, (0, 0, 0));
  var_2.radius = 350;
  var_2.height = 100;
  var_2.capture_time = 4.5;
  var_2.location_id = var_1.id;
  var_2.b_final_objective = 0;
  objective_icon_init(var_0);
  return var_2;
}

function objective_icon_init(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  switch (level.raid_struct.i_objective_index) {
    case 0:
      var_1 = "waypoint_captureneutral_br_a";
      var_2 = "icon_waypoint_dom_a";
      break;
    case 1:
      var_1 = "waypoint_captureneutral_br_b";
      var_2 = "icon_waypoint_dom_b";
      break;
    case 2:
      var_1 = "waypoint_captureneutral_br_c";
      var_2 = "icon_waypoint_dom_c";
      break;
    case 3:
      var_1 = "waypoint_captureneutral_br_d";
      var_2 = "icon_waypoint_dom_d";
      break;
    case 4:
      var_1 = "waypoint_captureneutral_br_e";
      var_2 = "icon_waypoint_dom_e";
      break;
  }

  setdomflagiconinfo(var_1, "neutral", "MP_BR_INGAME/" + var_0, var_2, 0);
  scripts\mp\gametypes\br_dom_quest::ref_13239();
  thread ref_13bb1();
}

function mark_objective_active(var_0) {
  foreach(var_2 in level.raid_struct.a_objective_locations_typed) {
    foreach(var_4 in var_2) {
      if(var_4 == var_0.location_id) {
        level.raid_struct.a_objective_locations_typed[var_0.type] = scripts\engine\utility::array_remove(level.raid_struct.a_objective_locations_typed[var_0.type], var_4);
        break;
      }
    }
  }

  foreach(var_8 in level.raid_struct.a_objective_locations_unused) {
    if(var_8.id == var_0.location_id) {
      level.raid_struct.a_objective_locations_unused = scripts\engine\utility::array_remove(level.raid_struct.a_objective_locations_unused, var_8);
      break;
    }
  }

  level.raid_struct.a_objectives_active[var_0.type] = scripts\engine\utility::array_add(level.raid_struct.a_objectives_active[var_0.type], var_0);
}

function mark_objective_complete(var_0) {
  if(isDefined(var_0.ai_encounter)) {
    var_0.ai_encounter scripts\mp\agents\agent_encounter_manager::end_encounter();
  }

  level.raid_struct.a_objectives_active[var_0.type] = scripts\engine\utility::array_remove(level.raid_struct.a_objectives_active[var_0.type], var_0);
  level.raid_struct.a_objectives_completed[var_0.type] = scripts\engine\utility::array_add(level.raid_struct.a_objectives_completed[var_0.type], var_0);
}

function ref_12424(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_4 = undefined;

    if(isalive(var_3)) {
      if(isDefined(var_1)) {
        var_4 = spawnStruct();
        var_4.intvar = var_1;
      }

      scripts\mp\gametypes\br_quest_util::displayplayersplash(var_3, var_0, var_4);
      continue;
    }

    if(!isDefined(var_4)) {
      var_4 = spawnStruct();
    }

    var_4.intvar = var_1;
    var_4.ref_136f3 = var_0;
    thread ref_12981(var_3);
  }
}

function ref_12981(var_0) {
  self notify("dead_splash_queue_triggered");
  self endon("dead_splash_queue_triggered");
  level endon("game_ended");
  level endon("disconnect");

  if(!isDefined(self.isflagcarrymode)) {
    self.isflagcarrymode = [];
  }

  self.isflagcarrymode = scripts\engine\utility::array_add(self.isflagcarrymode, var_0);

  while(isDefined(self) && isDefined(self.isflagcarrymode) && self.isflagcarrymode.size > 0) {
    if(isalive(self)) {
      wait 0.5;

      foreach(var_2 in self.isflagcarrymode) {
        scripts\mp\gametypes\br_quest_util::displayplayersplash(self, var_2.ref_136f3, var_2);
      }

      self.isflagcarrymode = [];
      break;
    }

    wait 1;
  }
}

function reset_objective_index() {
  level.raid_struct.i_objective_index = 0;
}

function get_objective_locations_unused(var_0) {
  if(isDefined(var_0)) {
    return level.raid_struct.a_objective_locations_typed[var_0];
  }

  return level.raid_struct.a_objective_locations_unused;
}

function get_objectives_active(var_0) {
  if(isDefined(var_0)) {
    return level.raid_struct.a_objectives_active[var_0];
  }

  return get_objectives_all(level.raid_struct.a_objectives_active);
}

function get_objectives_completed(var_0) {
  if(isDefined(var_0)) {
    return level.raid_struct.a_objectives_completed[var_0];
  }

  return get_objectives_all(level.raid_struct.a_objectives_completed);
}

function get_objectives_all(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_1 = scripts\engine\utility::array_combine(var_1, var_3);
  }

  return var_1;
}

function set_as_final_objective() {
  self.b_final_objective = 1;
}

function ___domination() {}

function start_objective_domination(var_0, var_1) {
  var_2 = ["_a", "_b", "_c", "_d", "_e"];
  var_3 = var_0.origin - (0, 0, var_0.height / 3);
  var_4 = spawn("trigger_radius", var_3, 0, var_0.radius, var_0.height);
  var_4.i_objective_index = level.raid_struct.i_objective_index;
  var_4.script_label = var_2[level.raid_struct.i_objective_index];
  var_4.iconname = var_2[level.raid_struct.i_objective_index];
  level.raid_struct.i_objective_index++;
  var_5 = scripts\mp\gametypes\obj_dom::setupobjective(var_4, "neutral");
  var_5.onuse = &ref_122b2;
  var_5.onbeginuse = &ref_122a8;
  var_5.onuseupdate = &ref_122b3;
  var_5.onenduse = &ref_122aa;
  var_5.oncontested = &ref_122a9;
  var_5.onuncontested = &ref_122af;
  var_5.onunoccupied = &ref_122b0;
  var_5.onpinnedstate = &ref_122ad;
  var_5.onunpinnedstate = &ref_122b1;
  var_5.ref_138b2 = &ref_122ae;
  var_5.stompprogressreward = &ref_122b8;
  var_5.id = "domFlag";
  var_5.pinobj = 1;
  var_5.lockupdatingicons = 1;
  var_5.trigger = var_4;
  var_5.get_current_bush_zone = 0;
  var_5.get_current_building_obj_struct = var_0.radius;
  var_5.pos = var_0.origin;
  var_5 scripts\mp\gameobjects::setcapturebehavior("persistent");
  var_5 scripts\mp\gameobjects::setusetime(var_0.capture_time);
  playencryptedcinematicforall(var_5.objidnum, 1);
  var_5.map_circle = spawnStruct();
  var_5.map_circle scripts\mp\gametypes\br_quest_util::init_tactical_boxes(8, 0, 0, var_0.origin);
  var_5.map_circle scripts\mp\gametypes\br_quest_util::ref_1316f(var_0.radius);
  var_5.map_circle scripts\mp\gametypes\br_quest_util::ref_13369();
  var_5 scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_5.objidnum, level.players[0].team);
  thread ref_122b9();
  thread ref_122ba();
  var_5.objective = var_0;
  var_0.ai_encounter = scripts\mp\agents\agent_encounter_manager::start_encounter(var_0.origin, var_1);
}

function ref_122b9() {
  level endon("game_ended");
  self.ref_1265b = [];

  while(!self.get_current_bush_zone) {
    self.trigger waittill("trigger", var_0);

    if((isPlayer(var_0) || isbot(var_0)) && !scripts\engine\utility::array_contains(self.ref_1265b, var_0)) {
      ref_122ab(var_0);
    }

    waitframe();
  }
}

function ref_122ab(var_0) {
  self.ref_1265b = scripts\engine\utility::array_add(self.ref_1265b, var_0);
  var_0.truck_03_node = 1;
}

function ref_122ba() {
  level endon("game_ended");

  while(!self.get_current_bush_zone) {
    foreach(var_1 in self.ref_1265b) {
      if(!var_1 istouching(self.trigger) || !isalive(var_1)) {
        ref_122ac(var_1);
      }
    }

    wait 0.1;
  }

  foreach(var_1 in self.ref_1265b) {
    ref_122ac(var_1);
  }
}

function ref_122ac(var_0) {
  self.ref_1265b = scripts\engine\utility::array_remove(self.ref_1265b, var_0);
  var_0.truck_03_node = 0;
}

function ref_122bb(var_0) {
  if(var_0 != self.waittill_pickup_or_timeout) {
    self.waittill_pickup_or_timeout = var_0;

    foreach(var_2 in self.ref_11ad0) {
      var_2 scripts\mp\gametypes\br_quest_util::spawn_double_cargo();
    }

    var_4 = self.waittill_pickup_or_timeout != "axis" && self.waittill_pickup_or_timeout != "allies";
    var_5 = undefined;

    foreach(var_7 in level.players) {
      var_8 = var_7.team == self.waittill_pickup_or_timeout;

      if(var_4) {
        var_5 = self.ref_11ad0["neutral"];
      } else {
        var_5 = scripts\engine\utility::ter_op(var_8, self.ref_11ad0["ally"], self.ref_11ad0["enemy"]);
      }

      if(isDefined(var_5)) {
        var_5 scripts\mp\gametypes\br_quest_util::ref_1336a(var_7);
      }
    }

    if(isDefined(var_5)) {
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.objidnum, var_0);
      return;
    }

    return;
  }
}

function ref_122b2(var_0) {
  var_1 = var_0.team;
  self.get_current_station_signage_structs = var_1;
  self.capturetime = gettime();
  self.get_current_bush_zone = 1;

  if(self.touchlist[var_1].size == 0 && isDefined(self.oldtouchlist)) {
    self.touchlist = self.oldtouchlist;
  }

  self notify("pe_dom_flag_end");
  thread ref_122a2(var_1);
}

function ref_122a8(var_0) {
  self.userate = 1;

  if(!isDefined(self.ref_11f63) || !self.ref_11f63) {
    self.ref_11f63 = 1;
    var_1 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 0);

    foreach(var_3 in var_1) {
      var_3 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    return;
  }
}

function ref_122b3(var_0, var_1, var_2, var_3) {
  self.userate = 1;

  if(var_1 < 1 && !level.gameended && !istrue(self.get_current_bush_zone)) {
    ref_12427(var_1, var_0);
  }

  if(var_1 > 0.05 && var_2 && !istrue(self.didstatusnotify)) {
    self.didstatusnotify = 1;
    return;
  }
}

function ref_122aa(var_0, var_1, var_2) {
  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var_0, var_1, var_2);
}

function ref_122a9() {
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_contested");
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  level thread scripts\mp\gametypes\br_public::brleaderdialog("exfil_contested");
  var_0 = scripts\mp\gameobjects::getownerteam();
}

function ref_122af(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = undefined;
  var_3 = ref_122a6();

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

    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");

    if(var_0 == "none" || var_1 == "neutral") {
      self.didstatusnotify = 0;
      return;
    }

    return;
  }
}

function ref_122a6() {
  var_0 = 0;

  foreach(var_2 in self.numtouching) {
    if(var_2 > 0 && (!isstring(var_3) || var_3 != "none")) {
      var_0++;
    }
  }

  return var_0;
}

function ref_122b0() {
  var_0 = scripts\mp\gameobjects::getownerteam();

  if(var_0 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_captureneutral");
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");
  }

  self.didstatusnotify = 0;
}

function ref_122ad(var_0) {
  if(self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending", "waypoint_capture");
    return;
  }
}

function ref_122b1(var_0) {
  if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");
    return;
  }
}

function ref_122ae(var_0) {
  self.userate = level.endgametutorial_func.manualturret_watchturretusetimeout;
  var_1 = scripts\mp\utility\teams::getenemyteams(var_0);
  var_2 = undefined;

  foreach(var_4 in var_1) {
    var_5 = self.teamprogress[var_4];

    if(var_5 > 0) {
      var_2 = var_5 / self.usetime;
    }
  }
}

function ref_122b8(var_0) {
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("obj_prog_defend");
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending", "waypoint_capture");

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

function ref_122a2(var_0) {
  mark_objective_complete(self.objective);

  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      if(!self.objective.b_final_objective) {
        var_2 thread scripts\mp\hud_message::showsplash("br_rumble_pe_dom_flag_captured_ally");
      }
    }
  }

  foreach(var_5 in self.touchlist[var_0]) {
    var_2 = var_5.player;
    var_2 thread scripts\mp\rank::giverankxp("rumble_dom_flag_capture", 250, var_2 getcurrentprimaryweapon());
    var_2 thread scripts\mp\rank::scoreeventpopup("rumble_dom_flag_capture");
  }

  thread ref_122a3(self);
}

function ref_122b4() {
  switch (level.raid_struct.a_objectives_completed["domination"].size) {
    case 1:
      level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dom_point_friendly_capture_1", self);
      break;
    case 2:
      level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dom_point_friendly_capture_2", self);
      break;
    case 3:
      level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("dom_point_friendly_capture_all", self);
      break;
  }
}

function ref_122a3(var_0) {
  var_0.map_circle scripts\mp\gametypes\br_quest_util::lastdirtyscore();
  scripts\mp\gametypes\obj_dom::removeobjective(var_0);
}

function subwave_progression(var_0) {
  setdomflagiconinfo("waypoint_captureneutral_br_a", "neutral", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_a", 0);
  setdomflagiconinfo("waypoint_captureneutral_br_b", "neutral", "MP_BR_INGAME/SWEEP_AND_CLEAR", "icon_waypoint_dom_b", 0);
  setdomflagiconinfo("waypoint_captureneutral_br_c", "neutral", "MP_BR_INGAME/ASSASSINATE", "icon_waypoint_dom_c", 0);
  setdomflagiconinfo("waypoint_captureneutral_br_d", "neutral", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_d", 0);
  setdomflagiconinfo("waypoint_captureneutral_br_e", "neutral", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_e", 0);
  scripts\mp\gametypes\br_dom_quest::ref_13239();
  thread ref_13bb1();
}

function setdomflagiconinfo(var_0, var_1, var_2, var_3, var_4) {
  level.waypointcolors[var_0] = var_1;
  level.waypointbgtype[var_0] = 0;
  level.waypointstring[var_0] = var_2;
  level.waypointshader[var_0] = var_3;
  level.waypointpulses[var_0] = var_4;
}

function ref_13bb1() {
  level waittill("br_dialog_initialized");
  level.disableinitplayergameobjects = 0;
}

function ___overwatch() {}

function start_objective_overwatch(var_0, var_1) {
  var_2 = ["_a", "_b", "_c", "_d", "_e"];
  var_3 = var_0.origin - (0, 0, var_0.height / 3);
  var_4 = spawn("trigger_radius", var_3, 0, var_0.radius, var_0.height);
  var_4.i_objective_index = level.raid_struct.i_objective_index;
  var_4.script_label = var_2[level.raid_struct.i_objective_index];
  var_4.iconname = var_2[level.raid_struct.i_objective_index];
  level.raid_struct.i_objective_index++;
  var_5 = scripts\mp\gametypes\obj_dom::setupobjective(var_4, "neutral");
  var_5.onuse = &ref_122b2;
  var_5.onbeginuse = &ref_122a8;
  var_5.onuseupdate = &ref_122b3;
  var_5.onenduse = &ref_122aa;
  var_5.oncontested = &ref_122a9;
  var_5.onuncontested = &ref_122af;
  var_5.onunoccupied = &ref_122b0;
  var_5.onpinnedstate = &ref_122ad;
  var_5.onunpinnedstate = &ref_122b1;
  var_5.ref_138b2 = &ref_122ae;
  var_5.stompprogressreward = &ref_122b8;
  var_5.id = "domFlag";
  var_5.pinobj = 0;
  var_5.lockupdatingicons = 1;
  var_5.trigger = var_4;
  var_5.get_current_bush_zone = 0;
  var_5.get_current_building_obj_struct = var_0.radius;
  var_5.pos = var_0.origin;
  var_5 scripts\mp\gameobjects::setcapturebehavior("persistent");
  var_5 scripts\mp\gameobjects::setusetime(var_0.capture_time);
  playencryptedcinematicforall(var_5.objidnum, 1);
  var_5.map_circle = spawnStruct();
  var_5.map_circle scripts\mp\gametypes\br_quest_util::init_tactical_boxes(8, 0, 0, var_0.origin);
  var_5.map_circle scripts\mp\gametypes\br_quest_util::ref_1316f(var_0.radius);
  var_5.map_circle scripts\mp\gametypes\br_quest_util::ref_13369();
  var_5 scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_5.objidnum, level.players[0].team);
  thread ref_122b9();
  thread ref_122ba();
  var_5.objective = var_0;
  var_0.ai_encounter = scripts\mp\agents\agent_encounter_manager::start_encounter(var_0.origin, var_1);
}

function ___sweep_and_clear() {}

function start_objective_sweep_and_clear(var_0, var_1) {
  var_2 = ["_a", "_b", "_c", "_d", "_e"];
  var_3 = var_0.origin - (0, 0, var_0.height / 3);
  var_4 = spawn("trigger_radius", var_3, 0, 1, 1);
  var_4.i_objective_index = level.raid_struct.i_objective_index;
  var_4.script_label = var_2[level.raid_struct.i_objective_index];
  var_4.iconname = var_2[level.raid_struct.i_objective_index];
  level.raid_struct.i_objective_index++;
  var_0.radius = int(1.1 * var_1.waves[0].spawn_params.max_radius);
  var_5 = scripts\mp\gametypes\obj_dom::setupobjective(var_4, "neutral");
  var_5.id = "domFlag";
  var_5.pinobj = 0;
  var_5.lockupdatingicons = 1;
  var_5.get_current_bush_zone = 1;
  var_5.get_current_building_obj_struct = var_0.radius;
  var_5.pos = var_0.origin;
  playencryptedcinematicforall(var_5.objidnum, 1);
  var_5.map_circle = spawnStruct();
  var_5.map_circle scripts\mp\gametypes\br_quest_util::init_tactical_boxes(8, 0, 0, var_0.origin);
  var_5.map_circle scripts\mp\gametypes\br_quest_util::ref_1316f(var_0.radius);
  var_5.map_circle scripts\mp\gametypes\br_quest_util::ref_13369();
  var_5.objective = var_0;
  thread sweep_and_clear_think();
  var_0.ai_encounter = scripts\mp\agents\agent_encounter_manager::start_encounter(var_0.origin, var_1);
}

function sweep_and_clear_think() {
  while(!isDefined(self.objective.ai_encounter)) {
    wait 0.05;
  }

  for(;;) {
    self.objective.ai_encounter waittill("agent_death");

    if(self.objective.ai_encounter.agents.size == 0) {
      break;
    }
  }

  thread ref_122a2("allies");
}

function ___assassination() {}

function start_objective_assassination(var_0, var_1) {
  level.raid_struct.i_objective_index++;
  thread assassination_think();
  var_0.ai_encounter = scripts\mp\agents\agent_encounter_manager::start_encounter(var_0.origin, var_1);
}

function assassination_think() {
  while(!isDefined(self.ai_encounter) || self.ai_encounter.agents.size <= 0) {
    wait 0.05;
  }

  var_0 = self.ai_encounter.agents[0];
  assassination_quest_circle_setup(var_0, 6000, 1000, 3);
  thread assassination_target_distance_watcher();
  var_0 waittill("death");
  self notify("target_found");
  scripts\mp\objidpoolmanager::returnreservedobjectiveid(self.ref_11f64);
  self notify("stop_circle_anim");

  if(isDefined(self.mapcircle)) {
    scripts\mp\gametypes\br_quest_util::lastdirtyscore();
  }

  if(isDefined(self.obj_icon_mover)) {
    self.obj_icon_mover delete();
  }

  mark_objective_complete(self);
}

function assassination_quest_circle_setup(var_0, var_1, var_2, var_3) {
  self.target = var_0;
  var_4 = var_0.origin;
  self.quest_circle_offset = scripts\engine\math::random_vector_2d() * randomfloatrange(0, var_1 * 0.9);
  var_5 = var_4 + self.quest_circle_offset;
  var_6 = (var_5[0], var_5[1], var_1);
  scripts\mp\gametypes\br_quest_util::init_tactical_boxes(8, 0, 0, var_6);
  scripts\mp\gametypes\br_quest_util::ref_13369();
  self.a_circles = [];
  var_7 = var_6 - var_4;
  var_8 = var_2 / var_1;
  var_9 = var_4 + var_7 * var_8;
  var_9 = (var_9[0], var_9[1], var_2);
  var_10 = 1 / var_3;

  for(var_11 = 0; var_11 <= var_3; var_11++) {
    self.a_circles[var_11] = vectorlerp(var_6, var_9, var_10 * var_11);
  }

  self.i_circle_step = 0;
  self.v_next_circle = self.a_circles[1];
  self.i_next_circle_distance = squared(self.v_next_circle[2]);
  var_12 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_12 > -1) {
    self.obj_icon_mover = spawn("script_model", var_5);
    objective_onentity(var_12, self.obj_icon_mover);
    objective_state(var_12, "current");
    thread assasination_icon_hide_after_intro(var_12);
    objective_setplayintro(var_12, 1);
    objective_setshowoncompass(var_12, 1);
    objective_setshowdistance(var_12, 0);
    playencryptedcinematicforall(var_12, 1);
    getscriptcachecontents(var_12, 0.5, 0.7);
    var_13 = level.raid_struct.i_objective_index - 1;
    self.str_objective_index = undefined;

    switch (var_13) {
      case 0:
        self.str_objective_index = "icon_waypoint_dom_a";
        break;
      case 1:
        self.str_objective_index = "icon_waypoint_dom_b";
        break;
      case 2:
        self.str_objective_index = "icon_waypoint_dom_c";
        break;
      case 3:
        self.str_objective_index = "icon_waypoint_dom_d";
        break;
      case 4:
        self.str_objective_index = "icon_waypoint_dom_e";
        break;
    }

    objective_icon(var_12, self.str_objective_index);
    objective_setbackground(var_12, 0);
    objective_setlabel(var_12, "MB_BR_INGAME/ASSASSINATE");
    objective_setneutrallabel(var_12, "MB_BR_INGAME/ASSASSINATE");
    objective_setfriendlylabel(var_12, "MB_BR_INGAME/ASSASSINATE");
    objective_setenemylabel(var_12, "MB_BR_INGAME/ASSASSINATE");
    objective_setzoffset(var_12, 100);
    function_0442(var_12, 1);
    self.ref_11f64 = var_12;
    return;
  }
}

function assasination_icon_hide_after_intro(var_0) {
  level endon("game_ended");
  wait 2;
  objective_state(var_0, "active");
}

function assassination_quest_circle_tick() {
  self.i_circle_step++;

  if(self.i_circle_step + 1 < self.a_circles.size) {
    thread assassination_quest_circle_animate(self.i_circle_step - 1], self.i_circle_step], 2);
self.v_next_circle = self.i_circle_step + 1];
self.i_next_circle_distance = squared(self.v_next_circle[2]);
return;
}

assassination_show_target();
}

function assassination_quest_circle_animate(var_0, var_1, var_2, var_3) {
  self notify("stop_circle_anim");
  level endon("game_ended");
  self endon("stop_circle_anim");
  var_4 = var_2 * 1000;
  var_5 = gettime() + var_4;
  var_6 = 0;
  self.obj_icon_mover moveTo((var_1[0], var_1[1], self.target.origin[2]), var_2);

  while(var_6 < 1) {
    var_6 = 1 - (var_5 - gettime()) / var_4;
    var_7 = vectorlerp(var_0, var_1, var_6);
    var_8 = var_7;

    if(istrue(var_3)) {
      var_8 = (var_7[0], var_7[1], scripts\engine\math::lerp(var_0[2], 0, var_6));
    }

    scripts\mp\gametypes\br_quest_util::ref_11dae(var_8);
    waitframe();
  }
}

function assassination_show_target() {
  thread assassination_quest_circle_animate(self.i_circle_step - 1], self.target.origin, 2, 1);
objective_state(self.ref_11f64, "current");
objective_setshowoncompass(self.ref_11f64, 0);
playencryptedcinematicforall(self.ref_11f64, 0);
function_0442(self.ref_11f64, 0);
objective_setshowdistance(self.ref_11f64, 1);
objective_icon(self.ref_11f64, self.str_objective_index);
objective_setbackground(self.ref_11f64, 0);
objective_setlabel(self.ref_11f64, "MB_BR_INGAME/ASSASSINATE");
objective_setneutrallabel(self.ref_11f64, "MB_BR_INGAME/ASSASSINATE");
objective_setfriendlylabel(self.ref_11f64, "MB_BR_INGAME/ASSASSINATE");
objective_setenemylabel(self.ref_11f64, "MB_BR_INGAME/ASSASSINATE");
objective_onentity(self.ref_11f64, self.target);
}

function assassination_target_distance_watcher() {
  level endon("game_ended");
  self endon("target_found");
  var_0 = level.players;
  var_1 = squared(1000);
  var_2 = squared(10000);

  for(;;) {
    foreach(var_4 in var_0) {
      if(!isDefined(var_4) || !isalive(var_4)) {
        continue;
      }

      var_5 = distancesquared(var_4.origin, self.target.origin);

      if(var_5 < var_1) {
        assassination_show_target();
        self notify("target_found");
      }
    }

    var_7 = var_2;

    foreach(var_4 in var_0) {
      var_7 = min(distance2dsquared(var_4.origin, self.v_next_circle), var_7);
    }

    if(var_7 < self.i_next_circle_distance) {
      assassination_quest_circle_tick();
    }

    wait 1;
  }
}