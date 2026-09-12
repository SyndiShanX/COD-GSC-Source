/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_objectives.gsc
***********************************************/

function objectives_init() {
  scripts\engine\utility::flag_init("objective_table_parsed");
  scripts\engine\utility::flag_init("objectives_registered");
  level.objectivestabledata = [];
  level.activequests = [];
  level.primaryobjectives = [];
  level.secondaryobjectives = [];
  level.infiniteobjectives = [];
  level.floorobjectives = [];
  level.globalobjectives = [];
  level.completedobjectives = [];
  level.active_objectives_string = "";
  initobjectivehud();

  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  if(isDefined(level.objectivesfunc)) {
    [[level.objectivesfunc]]();
  } else {
    parseobjectivestable();
  }

  scripts\engine\utility::flag_wait("interactions_initialized");

  if(isDefined(level.objectiveregistration)) {
    [[level.objectiveregistration]]();
  }

  initobjectiveicons();
  scripts\engine\utility::flag_set("objectives_registered");
  thread objectivedebug();
}

function setupobjectiveloops() {
  if(!should_run_objectives()) {
    return;
  }

  thread runmainobjective();
  thread runsecondaryobjectives();
  thread runobjectiveloop();
}

function runmainobjective() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("objectives_registered");
  wait 2;
  var_0 = scripts\engine\utility::random(level.primaryobjectives);
  thread run_objective(level, var_0);
}

function runsecondaryobjectives() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("objectives_registered");
  wait 2;

  if(!isDefined(level.secondaryobjectives) || !isDefined(level.num_secondary_objectives_active) || !level.secondaryobjectives.size) {
    return;
  }

  var_0 = scripts\engine\utility::array_randomize_objects(level.secondaryobjectives);
  var_1 = int(clamp(var_0.size, 0, level.num_secondary_objectives_active));

  for(var_2 = 0;; var_2--) {
    while(var_2 < var_1) {
      thread run_objective(var_0[var_2], "secondary");
      var_2++;
    }

    level waittill("secondary_objective_completed");
  }
}

function runobjectiveloop() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("objectives_registered");
  wait 2;

  if(!level.infiniteobjectives.size) {
    return;
  }

  var_0 = scripts\engine\utility::array_randomize_objects(level.infiniteobjectives);
  var_1 = int(clamp(var_0.size, 0, level.num_side_objectives_active));

  for(var_2 = 0;; var_2--) {
    while(var_2 < var_1) {
      thread run_objective(var_0[var_2], "infinite");
      var_2++;
    }

    level waittill("infinite_objective_completed");
  }
}

function should_run_objectives() {
  if(level.gametype == "cp_pvpve") {
    return false;
  }

  return true;
}

function objectivedebug() {}

function parseobjectivestable(var_0) {
  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  if(!isDefined(var_0)) {
    var_0 = "cp/cp_default_objectives.csv";
  }

  if(isDefined(level.objectivesmatrixtable)) {
    var_1 = level.objectivesmatrixtable;
  } else {
    var_1 = undefined;
  }

  for(var_2 = 0;; var_2++) {
    var_3 = tablelookupbyrow(var_1, var_2, 0);

    if(var_3 == "") {
      break;
    }

    var_4 = spawnStruct();
    var_4.index = int(var_3);
    var_4.ref = tablelookup(var_1, 0, var_3, 1);
    var_4.activatestring = tablelookup(var_1, 0, var_3, 2);
    var_4.label = tablelookup(var_1, 0, var_3, 3);
    var_4.questtype = tablelookup(var_1, 0, var_3, 5);
    var_4.objicon = tablelookup(var_1, 0, var_3, 6);
    var_4.showobjprogress = int(tablelookup(var_1, 0, var_3, 8));
    var_4.timer1 = int(tablelookup(var_1, 0, var_3, 9));
    var_4.timer2 = int(tablelookup(var_1, 0, var_3, 10));
    var_4.timer3 = int(tablelookup(var_1, 0, var_3, 11));
    var_4.client_hint = int(tablelookup(var_1, 0, var_3, 25));
    var_4.pathexit = tablelookup(var_1, 0, var_3, 24);
    var_4.variable1 = int(tablelookup(var_1, 0, var_3, 12));
    var_4.variable2 = int(tablelookup(var_1, 0, var_3, 13));
    var_4.variable3 = int(tablelookup(var_1, 0, var_3, 14));
    var_4.skipdescription = int(tablelookup(var_1, 0, var_3, 15));
    var_4.points = int(tablelookup(var_1, 0, var_3, 16));
    var_4.excludedfromrandompool = int(tablelookup(var_1, 0, var_3, 17));
    var_4.nofailontimeout = int(tablelookup(var_1, 0, var_3, 18));
    var_4.csdependency = tablelookup(var_1, 0, var_3, 26);

    if(isDefined(var_4.csdependency) && var_4.csdependency == "") {
      var_4.csdependency = undefined;
    }

    var_4.iconposref = tablelookup(var_1, 0, var_3, 7);
    var_4.disablefade = int(tablelookup(var_1, 0, var_3, 27)) >= 1;
    var_4.eventflag = tablelookup(var_1, 0, var_3, 31);
    var_4.ref_11f8d = [];

    if(isDefined(var_4.excludedfromrandompool) && var_4.excludedfromrandompool >= 1) {
      var_4.excludedfromrandompool = 1;
    } else {
      var_4.excludedfromrandompool = 0;
    }

    switch (var_4.questtype) {
      case "primary":
        level.primaryobjectives[level.primaryobjectives.size] = var_4.ref;
        break;
      case "secondary":
        level.secondaryobjectives[level.secondaryobjectives.size] = var_4.ref;
        break;
      case "infinite":
        level.infiniteobjectives[level.infiniteobjectives.size] = var_4.ref;
        break;
      case "floor":
        level.floorobjectives[level.floorobjectives.size] = var_4;
        break;
    }

    if(isDefined(var_1)) {
      var_4.nextsteps = [];
      var_5 = 0;

      for(var_6 = 1;; var_6++) {
        var_7 = tablelookup(var_1, var_5, var_4.ref, var_6);

        if(var_7 == "") {
          break;
        }

        var_4.nextsteps[var_4.nextsteps.size] = var_7;
      }
    }

    level.objectivestabledata[var_4.ref] = var_4;
  }

  scripts\engine\utility::flag_set("objective_table_parsed");
}

function processiconposref(var_0) {
  var_1 = var_0.iconposref;

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = strtok(var_1, ",");
  var_3 = undefined;

  if(var_2.size == 3) {
    var_3 = (int(var_2[0]), int(var_2[1]), int(var_2[2]));
  } else if(var_2.size == 2) {
    if(isDefined(level.struct_class_names[var_2[1]]) && isDefined(level.struct_class_names[var_2[1]][var_2[0]])) {
      var_3 = scripts\engine\utility::getStructArray(var_2[0], var_2[1]);
    } else {
      var_3 = getEnt(var_2[0], var_2[1]);
    }
  }

  if(isDefined(var_3)) {
    if(isvector(var_3)) {
      var_0.iconpos = var_3;
      var_0.ref_11f8d[var_0.ref_11f8d.size] = var_3;
      return;
    }

    if(isarray(var_3)) {
      if(!isDefined(var_0.iconpos)) {
        var_0.iconpos = [];
      }

      foreach(var_5 in var_3) {
        var_0.iconpos[var_0.iconpos.size] = var_5.origin;
        var_0.ref_11f8d[var_0.ref_11f8d.size] = var_5.origin;
        var_0.interactionstruct = var_5;
        var_5.objectivestruct = var_0;
      }

      return;
    }

    var_0.iconpos = var_3.origin;
    return;
  }

  var_0.iconpos = var_3;
}

function ref_1317e(var_0, var_1) {
  if(isarray(var_1)) {
    var_0.ref_11f8d = var_1;
    return;
  }

  var_0.ref_11f8d = [];
  var_0.ref_11f8d[0] = var_1;
}

function getobjectivestructfromref(var_0) {
  if(isDefined(level.objectivestabledata[var_0])) {
    return level.objectivestabledata[var_0];
  }

  return undefined;
}

function overridenextstep(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(var_1)) {
    var_0.nextsteps = undefined;
    return;
  }

  var_0.nextsteps = [];

  if(isarray(var_1)) {
    var_0.nextsteps = var_1;
    return;
  }

  var_0.nextsteps[0] = var_1;
}

function addheadicon(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "icon_waypoint_objective_general";
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_0.headiconid = thread scripts\cp\utility::ent_createheadicon(var_0, var_2, self.currentteam, var_1);
  setheadiconzoffset(var_0.headiconid, 1);
  setheadiconsnaptoedges(var_0.headiconid, 0);

  if(!isDefined(self.headiconents)) {
    self.headiconents = [];
  }

  self.headiconents[self.headiconents.size] = var_0;
  return var_0.headiconid;
}

function removeheadicon(var_0) {
  thread scripts\cp\utility::ent_deleteheadicon(var_0, var_0.headiconid);
  self.headiconents = scripts\engine\utility::array_remove(self.headiconents, var_0);
}

function registerobjective(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(level.objectivestabledata[var_0])) {
    return;
  }

  var_9 = level.objectivestabledata[var_0];
  var_9.init = var_1;
  var_9.startfunc = var_2;
  var_9.endfunc = var_3;
  var_9.ondebugbeatfunc = var_4;
  var_9.ondebugstartfunc = var_5;
  var_9.eventtype = var_7;
  var_9.ref = var_0;
  var_9.string = var_6;
  var_9.iscompletednaturally = 0;
  var_9.isregistered = 1;
  var_9.objname = var_0;
  createdevguientryforobjective(var_9);
}

function objective_update_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level notify(var_0 + "_update_instance");
  level endon(var_0 + "_update_instance");
  level endon(var_0 + "_completed");
  level endon(var_0 + "_failed");
  level endon(var_0 + "objective_paused");
  var_8 = undefined;
  var_6 = undefined;
  var_9 = undefined;

  if(isDefined(level.objectives_table)) {
    var_10 = check_event_flag(var_0);

    if(istrue(var_10)) {
      thread event_update_internal(var_0, var_1, var_2, var_3, var_4, var_5);
      return;
    }

    var_8 = int(tablelookup(level.objectives_table, 1, var_0, 0));
    var_9 = check_objective_reset_value(var_0);

    if(istrue(var_9)) {
      reset_objective_slots();
    }

    if(!isDefined(var_6)) {
      var_6 = get_objective_slot(var_0);
    }

    lua_objective_incomplete(var_0);
  }

  if(!isDefined(level.objectives_table)) {
    var_8 = int(tablelookup("cp/cp_default_objectives.csv", 1, var_0, 0));
  }

  if(!isDefined(var_8)) {
    return;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  var_11 = 1;
  var_12 = get_objective_type(var_0);

  if(isDefined(var_12)) {
    if(var_12 == "global") {
      var_11 = 0;
    }
  }

  if(istrue(var_11)) {
    show_objective_widget();

    switch (var_6) {
      case 1:
        setomnvar("cp_objective_sub_1_index", var_8);
        break;
      case 2:
        setomnvar("cp_objective_sub_2_index", var_8);
        break;
      case 3:
        setomnvar("cp_objective_sub_3_index", var_8);
        break;
      case 4:
        setomnvar("cp_objective_sub_4_index", var_8);
        break;
    }

    if(isDefined(var_5)) {
      switch (var_6) {
        case 1:
          setomnvar("cp_objective_sub_count_1", var_5);
          break;
        case 2:
          setomnvar("cp_objective_sub_count_2", var_5);
          break;
        case 3:
          setomnvar("cp_objective_sub_count_3", var_5);
          break;
        case 4:
          setomnvar("cp_objective_sub_count_4", var_5);
          break;
      }
    }
  }

  if(soundexists("ui_new_objective_popup")) {
    foreach(var_14 in level.players) {
      var_14 playsoundtoplayer("ui_new_objective_popup", var_14);
    }
  }

  if(isDefined(var_1) && var_1 > 0) {
    setomnvar("cp_countdown_color", 0);
    var_16 = var_6;

    if(istrue(var_7)) {
      var_16 = 5;
    }

    setomnvar("cp_countdown_timer_alpha", var_16);
    setomnvar("cp_countdown_timer", gettime() + var_1 * 1000);

    if(isDefined(var_2) && var_2 > 0 && var_2 < var_1 && !isDefined(var_3)) {
      wait var_1 - var_2;
      setomnvar("cp_countdown_color", 1);
      wait var_2;
    } else if(isDefined(var_2) && var_2 > 0 && var_2 < var_1 && isDefined(var_3) && var_3 < var_2) {
      wait var_1 - var_2;
      setomnvar("cp_countdown_color", 1);
      wait var_2 - var_3;
      setomnvar("cp_countdown_color", 2);
      wait var_3;
    } else {
      wait var_1;
    }

    if(!istrue(var_4)) {
      fail_objective(var_0);
    } else {
      level notify(var_0 + "_timer_complete");
    }

    reset_objective_timers();
    return;
  }
}

function event_update_internal(var_0, var_1, var_2, var_3, var_4, var_5) {
  level notify(var_0 + "_update_instance");
  level endon(var_0 + "_update_instance");
  level endon(var_0 + "_completed");
  level endon(var_0 + "_failed");
  level endon(var_0 + "objective_paused");
  var_6 = undefined;
  var_7 = undefined;

  if(isDefined(level.objectives_table)) {
    var_6 = int(tablelookup(level.objectives_table, 1, var_0, 0));
    var_7 = check_objective_reset_value(var_0);

    if(istrue(var_7)) {
      reset_objective_slots();
    }

    lua_objective_incomplete(var_0);
  }

  if(!isDefined(level.objectives_table)) {
    var_6 = int(tablelookup("cp/cp_default_objectives.csv", 1, var_0, 0));
  }

  if(!isDefined(var_6)) {
    return;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  var_8 = 1;
  var_9 = get_objective_type(var_0);

  if(isDefined(var_9)) {
    if(var_9 == "global") {
      var_8 = 0;
    }
  }

  if(istrue(var_8)) {
    setomnvar("cp_objective_event_index", var_6);

    if(isDefined(var_5)) {
      setomnvar("cp_objective_event_count", var_5);
    }
  }

  if(soundexists("iw8_new_objective_sfx")) {
    playsoundatpos((0, 0, 0), "iw8_new_objective_sfx");
  }

  if(isDefined(var_1) && var_1 > 0) {
    setomnvar("cp_countdown_event_color", 0);
    setomnvar("cp_countdown_event_timer_alpha", 1);
    setomnvar("cp_countdown_event_timer", gettime() + var_1 * 1000);

    if(isDefined(var_2) && var_2 > 0 && var_2 < var_1 && !isDefined(var_3)) {
      wait var_1 - var_2;
      setomnvar("cp_countdown_event_color", 1);
      wait var_2;
    } else if(isDefined(var_2) && var_2 > 0 && var_2 < var_1 && isDefined(var_3) && var_3 < var_2) {
      wait var_1 - var_2;
      setomnvar("cp_countdown_event_color", 1);
      wait var_2 - var_3;
      setomnvar("cp_countdown_event_color", 2);
      wait var_3;
    } else {
      wait var_1;
    }

    if(!istrue(var_4)) {
      fail_objective(var_0);
      reset_event_timers();
      return;
    }

    level notify(var_0 + "_timer_complete");
    return;
  }

  setomnvar("cp_countdown_event_timer_alpha", 0);
}

function show_objective_widget() {
  setomnvar("cp_objective_index", 1);
}

function hide_objective_widget() {
  setomnvar("cp_objective_index", 0);
}

function get_objective_slot(var_0) {
  var_1 = undefined;

  if(isDefined(level.objectives_table)) {
    var_1 = tablelookup(level.objectives_table, 1, var_0, 29);
  }

  if(isDefined(var_1) && var_1 != "") {
    return int(var_1);
  }

  return 1;
}

function check_objective_reset_value(var_0) {
  var_1 = undefined;

  if(isDefined(level.objectives_table)) {
    var_1 = tablelookup(level.objectives_table, 1, var_0, 30);
  }

  if(isDefined(var_1) && var_1 != "") {
    return 1;
  }

  return 0;
}

function fail_objective(var_0) {
  level notify(var_0 + "_failed");
  reset_objective_omnvars(var_0);
}

function run_objective(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("debug_beat_" + var_0 + "_objective");
  level endon(var_0 + "_failed");

  if(getdvarint("scr_disable_objectives", 0)) {
    return;
  }

  if(!isDefined(level.objectivestabledata[var_0])) {
    return;
  }

  var_3 = level.objectivestabledata[var_0];
  var_3.objname = var_0;
  var_3.iscompletednaturally = 0;

  if(isDefined(var_3.csdependency) && var_3.csdependency != "") {
    if(!scripts\engine\utility::flag_exist(var_3.csdependency)) {
      scripts\engine\utility::flag_init(var_3.csdependency);
    }

    if(!scripts\engine\utility::flag(var_3.csdependency)) {
      scripts\engine\utility::flag_set(var_3.csdependency);
    }

    scripts\engine\utility::flag_wait(var_3.csdependency + "_completed");
  }

  processiconposref(var_3);

  if(!isDefined(var_2)) {
    var_3.currentteam = "allies";
  } else {
    var_3.currentteam = var_2;
  }

  if(isDefined(var_1) && var_1 == "primary") {
    var_3.alwaysshowicon = 1;
  } else if(isDefined(var_1) && var_1 == "global") {
    var_3.alwaysshowicon = 1;
  }

  thread watchfordebugcompletion(level, var_3, var_0);
  thread watchforobjectivefailure(level, var_3, var_0);
  initializeobjective(var_3, var_0, var_1);
  startobjective(var_3, var_0, var_1);
  completeobjective(var_3, var_0, var_1);

  if(isDefined(var_1)) {
    level notify(var_1 + "_objective_completed");
    return;
  }
}

function watchforobjectivefailure(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("debug_beat_" + var_1 + "_objective");
  var_0 endon(var_1 + "_completed");
  level waittill(var_1 + "_failed");
  var_3 = var_0.ref;

  if(isDefined(var_0.hudicon)) {
    destroy_objective_waypoint(var_0.hudicon);
  }

  if(isDefined(var_0.currentteam)) {
    var_0.currentteam = undefined;
  }

  if(isDefined(var_0.headiconents)) {
    foreach(var_5 in var_0.headiconents) {
      removeheadicon(var_0, var_5);
    }

    var_0.headiconents = undefined;
  }

  remove_from_active_quests(var_0);
  mark_objective_failed(var_3);
  reset_objective_omnvars(var_3);
  tryrunnextobjective(var_0, 0);
}

function mark_objective_failed(var_0) {
  var_1 = getobjectivestructfromref(var_0);

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = var_1.objectiveindex;

  if(!isDefined(var_2)) {
    return;
  }

  objective_state(var_2, "failed");
}

function lua_objective_complete(var_0) {
  var_1 = check_event_flag(var_0);

  if(!istrue(var_1)) {
    var_2 = get_objective_slot(var_0);
    var_3 = check_for_objective_timer(var_0);

    if(var_3) {
      reset_objective_timers();
    }

    switch (var_2) {
      case 1:
        setomnvar("cp_objective_sub_1_complete", 1);
        break;
      case 2:
        setomnvar("cp_objective_sub_2_complete", 1);
        break;
      case 3:
        setomnvar("cp_objective_sub_3_complete", 1);
        break;
      case 4:
        setomnvar("cp_objective_sub_4_complete", 1);
        break;
    }

    return;
  }

  setomnvar("cp_objective_event_complete", 1);
  reset_event_timers();
}

function lua_objective_incomplete(var_0, var_1) {
  var_1 = check_event_flag(var_0);

  if(!istrue(var_1)) {
    var_2 = get_objective_slot(var_0);
    var_3 = check_for_objective_timer(var_0);

    if(var_3) {
      reset_objective_timers();
    }

    switch (var_2) {
      case 1:
        setomnvar("cp_objective_sub_1_complete", 0);
        break;
      case 2:
        setomnvar("cp_objective_sub_2_complete", 0);
        break;
      case 3:
        setomnvar("cp_objective_sub_3_complete", 0);
        break;
      case 4:
        setomnvar("cp_objective_sub_4_complete", 0);
        break;
    }

    return;
  }

  setomnvar("cp_objective_event_complete", 0);
  reset_event_timers();
}

function check_for_objective_timer(var_0) {
  var_1 = int(tablelookup(level.objectives_table, 1, var_0, 9));

  if(isDefined(var_1) && var_1 > 0) {
    return 1;
  }

  return 0;
}

function reset_objective_slots() {
  setomnvar("cp_objective_sub_1_index", 0);
  setomnvar("cp_objective_sub_count_1", -1);
  setomnvar("cp_objective_sub_2_index", 0);
  setomnvar("cp_objective_sub_count_2", -1);
  setomnvar("cp_objective_sub_3_index", 0);
  setomnvar("cp_objective_sub_count_3", -1);
  setomnvar("cp_objective_sub_4_index", 0);
  setomnvar("cp_objective_sub_count_4", -1);
}

function reset_objective_timers() {
  setomnvar("cp_countdown_timer", 0);
  setomnvar("cp_countdown_timer_alpha", 0);
  setomnvar("cp_countdown_color", 0);
}

function reset_event_timers() {
  setomnvar("cp_countdown_event_timer", 0);
  setomnvar("cp_countdown_event_timer_alpha", 0);
  setomnvar("cp_countdown_event_color", 0);
}

function reset_subobjective_slot(var_0) {
  var_1 = get_objective_slot(var_0);
  setomnvar("cp_objective_sub_" + var_1 + "_index", 0);
  setomnvar("cp_objective_sub_count_" + var_1, -1);
}

function check_event_flag(var_0) {
  var_1 = int(tablelookup(level.objectives_table, 1, var_0, 31));

  if(isDefined(var_1) && var_1 == 1) {
    return 1;
  }

  return 0;
}

function reset_objective_omnvars(var_0) {
  var_1 = check_event_flag(var_0);

  if(!istrue(var_1)) {
    var_2 = get_objective_slot(var_0);

    switch (var_2) {
      case 1:
        setomnvar("cp_objective_sub_1_index", 0);
        setomnvar("cp_objective_sub_count_1", -1);
        break;
      case 2:
        setomnvar("cp_objective_sub_2_index", 0);
        setomnvar("cp_objective_sub_count_2", -1);
        break;
      case 3:
        setomnvar("cp_objective_sub_3_index", 0);
        setomnvar("cp_objective_sub_count_3", -1);
        break;
      case 4:
        setomnvar("cp_objective_sub_4_index", 0);
        setomnvar("cp_objective_sub_count_4", -1);
        break;
    }

    return;
  }

  setomnvar("cp_objective_event_index", 0);
  setomnvar("cp_objective_event_count", -1);
}

function watchfordebugcompletion(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon(var_1 + "_failed");
  var_0 endon(var_1 + "_completed");
  level waittill("debug_beat_" + var_0.objname + "_objective");
  wait 1;

  if(isDefined(var_0.ondebugbeatfunc)) {
    [[var_0.ondebugbeatfunc]](var_0);
  }

  if(!var_0.iscompletednaturally) {
    completeobjective(var_0, var_1, var_2);
  }

  if(isDefined(var_2)) {
    level notify(var_2 + "_objective_completed");
    return;
  }
}

function debugbeatobjective(var_0) {
  level notify("debug_beat_" + var_0 + "_objective");
}

function createdevguientryforobjective(var_0) {
  if(!isDefined(level.completedobjectives)) {
    var_1 = 0;
  } else {
    var_1 = level.completedobjectives.size + 1;
  }

  var_2 = "devgui_cmd \"CP Debug:2 / Objectives / Complete / Beat " + var_1.objname + " Objective:" + var_1 + "\" \"set start_objective_debug notify-debug_beat_" + var_1.objname + "_objective\" \n";
  scripts\cp\utility::addentrytodevgui(var_2);

  if(!istrue(var_1.excludedfromrandompool)) {
    var_2 = "devgui_cmd \"CP Debug:2 / Objectives / Start / Start " + var_1.objname + " Objective:" + var_1 + "\" \"set start_objective_debug notify-debug-start_-" + var_1.objname + "-objective\" \n";
    scripts\cp\utility::addentrytodevgui(var_2);
    return;
  }
}

function addprintlinetext(var_0) {}

function initializeobjective(var_0, var_1, var_2) {
  level endon("debug_beat_" + var_0.objname + "_objective");
  default_init_objective(var_0, var_2);

  if(isDefined(var_0.init)) {
    [[var_0.init]](var_0);
  }

  var_0 notify("objective_initialized");
}

function startobjective(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("debug_beat_" + var_0.objname + "_objective");
  getentitylessscriptablearray("dlog_event_cpdata_level_progression", ["levelname", level.script, "active_objective", var_1, "time_stamp", gettime(), "description", "Started"]);
  level.activequests[level.activequests.size] = var_0;

  if(level.active_objectives_string.size <= 0) {
    level.active_objectives_string = var_1;
  } else {
    level.active_objectives_string = level.active_objectives_string + "," + var_1;
  }

  if(isDefined(var_0.startfunc)) {
    [[var_0.startfunc]](var_0);
    return;
  }
}

function completeobjective(var_0, var_1, var_2) {
  if(!scripts\engine\utility::array_contains(level.ref_12880, var_0.objname)) {
    level.ref_12880 = scripts\engine\utility::array_add(level.ref_12880, var_0.objname);
  }

  remove_from_active_quests(var_0);

  if(isDefined(var_2) && var_2 == "global" && !istrue(scripts\cp\cp_objectives_events::is_event_completed(var_0.ref))) {
    if(isDefined(var_0.hudicon)) {
      destroy_objective_waypoint(var_0.hudicon);
    }

    delete_objective(var_0.objname);
    return;
  }

  var_0 notify("objective_completed");
  var_0.iscompletednaturally = 1;
  defaultcompleteobjective(var_0);
  start_mode_after_playerspawn();
  getentitylessscriptablearray("dlog_event_cpdata_level_progression", ["levelname", level.script, "active_objective", var_1, "time_stamp", gettime(), "description", "Completed"]);

  if(isDefined(var_0.points) && var_0.points > 0) {
    var_3 = var_0.points;

    if(level.gametype == "cp_survival") {
      var_3 = 100;
    }

    foreach(var_5 in level.players) {
      var_5 scripts\cp\cp_persistence::give_player_currency(var_3, "large");
    }
  }

  if(isDefined(var_0.endfunc)) {
    [[var_0.endfunc]](var_0);
  }

  tryrunnextobjective(var_0, 1);
  level notify(var_1 + "_completed");
  var_0 notify(var_1 + "_completed");
}

function delete_objective(var_0) {
  var_1 = getobjectivestructfromref(var_0);

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = var_1.objectiveindex;

  if(!isDefined(var_2)) {
    return;
  }

  objective_delete(var_2);
}

function tryrunnextobjective(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(getDvar("ui_gametype") == "cp_survival" && var_0.questtype == "primary") {
    if(var_1 && isDefined(var_0.nextsteps) && var_0.nextsteps.size > 0) {
      thread run_objective(var_0.nextsteps[0], var_0.questtype);
      return;
    }

    return;
  }

  if(var_1) {
    if(isDefined(var_0.nextsteps) && var_0.nextsteps.size > 0) {
      thread run_objective(scripts\engine\utility::random(var_0.nextsteps), var_0.questtype);
      return;
    }

    return;
  }
}

function remove_from_active_quests(var_0) {
  level.activequests = scripts\engine\utility::array_remove(level.activequests, var_0);
  var_1 = strtok(level.active_objectives_string, ",");

  if(var_1.size > 0) {
    var_2 = "";
    var_3 = 0;

    foreach(var_5 in var_1) {
      if(var_5 == var_0.ref) {
        continue;
      }

      if(var_3 == 0) {
        var_2 = var_5;
      } else {
        var_2 = var_2 + "," + var_5;
      }

      var_3++;
    }

    level.active_objectives_string = var_2;
    return;
  }
}

function findandrunrandomprimaryobjective() {
  level endon("game_ended");
  var_0 = undefined;
  var_1 = [];

  foreach(var_3 in level.objectivestabledata) {
    if(var_3.questtype == "primary" && !scripts\engine\utility::array_contains(level.completedobjectives, var_3) && istrue(var_3.isregistered) && !istrue(var_3.excludedfromrandompool)) {
      var_1 = var_3;
    }
  }

  if(var_1.size <= 0) {
    return;
  }

  wait 5;
  thread run_objective(scripts\engine\utility::random(var_1).ref);
}

function initobjectivehud() {}

function setlevelobjectivetext(var_0) {}

function clearobjectivetext() {}

function setobjectivetextforplayer(var_0, var_1) {}

function clearobjectivetextforplayer(var_0) {}

function blankobjectivefunc() {
  level endon("new_objective_chosen");
}

function setomnvarbasedonindex(var_0) {
  foreach(var_2 in level.objectivestabledata) {
    if(int(var_0) == int(var_2.index)) {
      setomnvar("cp_objective_index", var_0);
      return;
    }
  }

  setomnvar("cp_objective_index", 0);
}

function setobjectivetocompleteanddroploot(var_0, var_1) {
  var_0.completedobjective = 1;
}

function create_objective_waypoint(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  var_5 = undefined;

  if(var_1 != "all") {
    var_5 = newteamhudelem(var_1);
  } else {
    var_5 = newhudelem();
  }

  var_5.id = level.waypoint_index;
  var_5.x = var_0[0];
  var_5.y = var_0[1];
  var_5.z = var_0[2];
  var_5.team = var_1;
  var_5.isflashing = 0;
  var_5.isshown = 1;
  level.waypoint_index++;

  if(isDefined(var_2)) {
    var_5 setshader(var_2, level.waypoint_size, level.waypoint_size);
    var_5 setwaypoint(1, 1);
  }

  if(isDefined(var_3)) {
    var_5.alpha = var_3;
  } else {
    var_5.alpha = level.waypoint_alpha;
  }

  var_5.basealpha = var_5.alpha;
  return var_5;
}

function destroy_objective_waypoint(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    level thread[[var_1]](var_0);
  }

  if(isDefined(var_1) && isDefined(var_2)) {
    var_0 scripts\engine\utility::ref_143b9(var_2, "destroy_objective_icon");
  } else if(isDefined(var_1)) {
    var_0 waittill("destroy_objective_icon");
  } else if(isDefined(var_2)) {
    wait var_2;
  }

  var_0 destroy();
}

function give_objective_skillpoints() {
  foreach(var_1 in level.players) {
    var_1 scripts\cp\classes\cp_class_progression::give_skill_points(1);
  }
}

function default_init_objective(var_0, var_1) {
  if(isDefined(var_0.nofailontimeout) && var_0.nofailontimeout > 0) {
    var_2 = 1;
  } else {
    var_2 = 0;
  }

  if(!istrue(var_1.client_hint)) {
    var_1.client_hint = 0;
  }

  if(!istrue(var_1.skipdescription)) {
    setomnvar("cp_objective_desc_index", 1);

    if(isDefined(var_1.timer1) && isDefined(var_1.timer2) && isDefined(var_1.timer3)) {
      level thread scripts\cp\utility::objective_update(var_1.objname, var_1.timer1, var_1.timer2, var_1.timer3, var_2);
    } else if(isDefined(var_1.timer1) && isDefined(var_1.timer2)) {
      level thread scripts\cp\utility::objective_update(var_1.objname, var_1.timer1, var_1.timer2, undefined, var_2);
    } else if(isDefined(var_1.timer1)) {
      level thread scripts\cp\utility::objective_update(var_1.objname, var_1.timer1, undefined, undefined, var_2);
    } else {
      level thread scripts\cp\utility::objective_update(var_1.objname);
    }
  }

  var_3 = scripts\engine\utility::ter_op(isDefined(var_1.objname), var_1.objname, undefined);
  var_4 = scripts\engine\utility::ter_op(isDefined(var_1.iconpos), var_1.iconpos, undefined);
  var_5 = scripts\engine\utility::ter_op(isDefined(var_1.activatestring), var_1.activatestring, undefined);
  var_6 = scripts\engine\utility::ter_op(isDefined(var_1.label), var_1.label, undefined);
  var_7 = scripts\engine\utility::ter_op(isDefined(var_1.objicon), var_1.objicon, undefined);
  var_8 = scripts\engine\utility::ter_op(isDefined(var_1.questtype), var_1.questtype, undefined);
  var_9 = "icon_regular";

  if(isDefined(var_5) && var_5 == "" || istrue(var_1.skipdescription)) {
    var_5 = undefined;
  }

  if(isDefined(var_1.iconpos) && isDefined(var_1.objicon)) {
    var_10 = "current";
  } else {
    var_10 = "active";
  }

  var_10 = "current";
  level.initlethalmaxoffsetmap = var_2.objname;

  if(isarray(var_5)) {
    var_2.objectiveindexes = [];
    add_objective(var_4, var_10, undefined, var_6, var_7, var_8, var_10, var_9, var_2, var_2);

    foreach(var_12 in var_5) {
      objective_setlocation(var_2.objectiveindex, var_13, var_12);
      var_2.objectiveindexes[var_2.objectiveindexes.size] = var_13;
    }

    return;
  }

  add_objective(var_4, var_10, var_5, var_6, var_7, var_8, var_10, var_9, var_2, var_2);
}

function defaultcompleteobjective(var_0, var_1) {
  thread scripts\cp\coop_personal_ents::update_special_mode_for_all_players();

  if(isDefined(var_0.hudicon)) {
    destroy_objective_waypoint(var_0.hudicon);
  }

  if(isDefined(var_0.headiconents)) {
    foreach(var_3 in var_0.headiconents) {
      removeheadicon(var_0, var_3);
    }

    var_0.headiconents = undefined;
  }

  if(isDefined(var_0.objname)) {
    freeworldid(var_0.objname);
    var_5 = var_0.objectiveindex;

    if(isDefined(var_0.complete_state)) {
      if(isDefined(var_5)) {
        objective_state(var_5, var_0.complete_state);
      }
    } else {
      if(isDefined(var_5)) {
        objective_state(var_5, "done");
      }

      if(isDefined(var_0.objectiveindexes)) {
        foreach(var_7 in var_0.objectiveindexes) {
          objective_unsetlocation(var_0.objectiveindex, var_7);
        }
      }
    }

    if(get_objective_type(var_0.objname) == "global") {
      delay_delete_objective(var_0.objectiveindex, 0.15);
      var_0 notify(var_0.objname + "_completed");
      level notify("debug_beat_" + var_0.objname + "_objective");
    }

    if(isDefined(var_0.currentteam)) {
      var_9 = var_0.currentteam;

      if(does_team_have_active_chain(var_9)) {
        if(!isDefined(var_0.nextsteps) || var_0.nextsteps.size <= 0) {
          add_to_list_of_current_chain_idx(var_0, var_9);
          delete_all_team_chain_objectives(var_9);
        } else {
          add_to_list_of_current_chain_idx(var_0, var_9);
        }
      } else if(isDefined(var_0.nextsteps) && var_0.nextsteps.size > 0) {
        add_to_list_of_current_chain_idx(var_0, var_9);
      } else {
        objective_delete(var_5);
      }

      var_0.currentteam = undefined;
    }

    lua_objective_complete(var_0.ref);
  }

  if(istrue(var_1) || istrue(var_0.checkpointrevive)) {
    checkpoint_revive();
  }

  if(istrue(var_1) || istrue(var_0.checkpointrevive)) {
    give_objective_skillpoints();
  }

  foreach(var_11 in level.completedobjectives) {}

  level.completedobjectives[level.completedobjectives.size] = var_0;
}

function does_team_have_active_chain(var_0) {
  return isDefined(level.currentteamobjectivechain) && isDefined(level.currentteamobjectivechain[var_0]) && level.currentteamobjectivechain[var_0].size > 0;
}

function add_to_list_of_current_chain_idx(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }

  if(!isDefined(level.currentteamobjectivechain)) {
    level.currentteamobjectivechain = [];
  }

  if(!isDefined(level.currentteamobjectivechain[var_1])) {
    level.currentteamobjectivechain[var_1] = [];
  }

  level.currentteamobjectivechain[var_1][level.currentteamobjectivechain[var_1].size] = var_0;
}

function delete_all_team_chain_objectives(var_0) {
  if(!isDefined(level.currentteamobjectivechain) || !isDefined(level.currentteamobjectivechain[var_0])) {
    return;
  }

  foreach(var_2 in level.currentteamobjectivechain[var_0]) {
    objective_delete(var_2.objectiveindex);
  }
}

function delay_delete_objective(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(var_1)) {
    wait var_1;
  }

  objective_delete(var_0);
}

function checkpoint_revive() {
  foreach(var_1 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_1)) {
      var_1 scripts\cp\cp_laststand::instant_revive(var_1);

      if(isDefined(var_1.dogtag)) {
        var_1.dogtag delete();
      }
    }
  }
}

function add_objective(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = 20;

  if(var_7 == "global") {
    var_10 = 15;
  }

  var_11 = requestworldid(var_0, var_10);
  _add_objective(var_11, var_1, var_2, var_5, var_6);

  if(isDefined(var_7) && var_7 != "primary" && isDefined(var_2)) {
    if(var_7 != "global") {
      thread watchfornearbyplayers(level, var_11, var_2);
    }
  }

  objective_set_play_intro(var_11, 1);

  if(isDefined(var_3)) {
    if(isDefined(level.display_objective_text_func)) {
      level thread[[level.display_objective_text_func]](var_0, var_3, var_8.currentteam, 5);
    }

    objective_setdescription(var_11, var_3);
  }

  if(isDefined(var_4)) {
    objective_setlabel(var_11, var_4);
  }

  objective_unpinforteam(var_11, "allies");
  objective_setshowdistance(var_11, 1);
  objective_setbackground(var_11, 0);
  objective_setshowoncompass(var_11, 1);
  objective_setpulsate(var_11, 1);

  if(isDefined(var_8.disablefade)) {
    objective_setfadedisabled(var_11, var_8.disablefade);
  }

  if(!isDefined(var_2)) {
    objective_state(var_11, "invisible");
  }

  var_8.objiconid = var_11;
  var_8.iconname = var_8.objname;
  var_8.objectiveindex = var_11;

  if(istrue(var_8.showobjprogress)) {
    objective_show_progress(var_8.objectiveindex, 1);

    if(get_objective_type(var_8.objname) == "global") {
      var_8.showobjprogress = var_8.showobjprogressbackup;
    }

    if(var_8.showobjprogress > 1) {
      objective_set_progress(var_8.objectiveindex, 0);
      thread startprogresstimer(var_8, var_8);
      return;
    }

    if(var_8.showobjprogress < -1) {
      objective_set_progress(var_8.objectiveindex, 1);
      thread startprogresstimer(var_8, var_8, var_8.showobjprogress * -1);
      return;
    }

    return;
  }
}

function startprogresstimer(var_0, var_1, var_2) {
  level endon("debug_beat_" + var_0.objname + "_objective");
  var_0 endon(var_0.objname + "_completed");
  var_0 endon("stop_timer");

  if(var_1 > 3) {
    var_1 -= 3;
    wait 3;
  }

  var_3 = 0;
  var_4 = 1;

  if(istrue(var_2)) {
    var_3 = 1;
    var_4 = 0;
  }

  var_5 = 0;
  var_6 = 0.1;
  var_7 = gettime() + var_1 * 1000;
  objective_set_progress(var_0.objectiveindex, var_3);

  while(gettime() < var_7) {
    if(!istrue(var_2)) {
      objective_set_progress(var_0.objectiveindex, var_5 / var_1);
    } else {
      objective_set_progress(var_0.objectiveindex, 1 - var_5 / var_1);
    }

    if(!isDefined(var_0.pause_timer)) {
      var_5 += var_6;
    } else {
      var_7 += 1000 * var_6;
    }

    if(var_5 <= 0) {
      break;
    }

    wait var_6;
  }

  objective_set_progress(var_0.objectiveindex, var_4);
}

function set_nearby_console(var_0) {
  var_0.nearby_players[var_0.nearby_players.size] = self;
}

function show_to_players_that_are_near(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_2 endon("objective_completed");
  var_2 endon("stop_watching");
  var_4 = 0;
  minimap_objective_playermask_hidefromall(var_0);
  minimap_objective_pin_global(var_0, 0);

  if(isDefined(var_3)) {
    var_5 = var_3 * var_3;
  } else {
    var_5 = 1048576;
  }

  var_3.showtoall = 0;

  for(;;) {
    if(istrue(var_3.showtoall)) {
      if(!var_5) {
        var_5 = 1;
        minimap_objective_playermask_showtoall(var_1);
      }
    } else if(istrue(var_3.hidefromall)) {
      if(var_5) {
        var_5 = 0;
        minimap_objective_playermask_hidefromall(var_1);
      }
    } else {
      minimap_objective_pin_global(var_1, 0);
      var_3.nearby_players = [];
      var_6 = scripts\engine\utility::get_array_of_closest(var_2, level.players, undefined, undefined, var_5);
      scripts\engine\utility::array_call(var_6, &set_nearby_console, var_3);
      var_5 = 0;

      foreach(var_8 in level.players) {
        if(istrue(var_8.disable_objective_update)) {
          objective_set_play_outro(var_1, 0);
          minimap_objective_playermask_hidefrom(var_1, var_8);
          continue;
        }

        if(var_8 scripts\cp\utility::is_valid_player() && distancesquared(var_8.origin, var_2) <= var_5) {
          objective_set_play_intro(var_1, 0);
          minimap_objective_playermask_showto(var_1, var_8);
          continue;
        }

        objective_set_play_outro(var_1, 0);
        minimap_objective_playermask_hidefrom(var_1, var_8);
      }
    }

    var_3 scripts\engine\utility::ref_143b9(0.5, "update_nearby_thread");
  }
}

function watchfornearbyplayers(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_2 endon("objective_completed");
  var_2 endon("stop_watching");
  var_4 = 0;
  minimap_objective_playermask_hidefromall(var_0);

  if(isDefined(var_3)) {
    var_5 = var_3 * var_3;
  } else {
    var_5 = 1056784;
  }

  for(;;) {
    while(!istrue(var_3.showtoall) && !scripts\cp\utility::any_player_nearby(var_2, var_5)) {
      if(var_5) {
        minimap_objective_playermask_hidefromall(var_1);
        var_5 = 0;
      }

      var_3 scripts\engine\utility::ref_143b9(0.5, "update_nearby_thread");
    }

    if(!var_5) {
      var_5 = 1;
      minimap_objective_playermask_showtoall(var_1);
    }

    var_3 scripts\engine\utility::ref_143b9(0.5, "update_nearby_thread");
  }
}

function unset_all_locations(var_0) {
  for(var_1 = 0; var_1 <= 7; var_1++) {
    objective_unsetlocation(var_0, var_1);
  }
}

function initobjectiveicons() {
  var_0 = spawnStruct();
  var_0.active = [];
  var_0.reclaimed = [];
  var_0.index = 0;
  level.minimapobjidpool = var_0;
  var_1 = spawnStruct();
  var_1.active = [];
  var_1.reclaimed = [];
  var_1.index = 0;
  level.worldobjidpool = var_1;
}

function requestminimapid(var_0) {
  var_1 = getnextminimapid(var_0);

  if(var_1 == -1) {
    return -1;
  }

  var_2 = spawnStruct();
  var_2.priority = var_0;
  var_2.requesttime = gettime();
  var_2.objid = var_1;
  level.minimapobjidpool.active[var_1] = var_2;
  return var_1;
}

function removebestminimapid(var_0) {
  var_1 = [];

  foreach(var_3 in level.minimapobjidpool.active) {
    if(var_3.priority <= var_0) {
      var_1 = var_3;
    }
  }

  scripts\engine\utility::array_sort_with_func(var_1, &comparepriorityandtime);
  return returnminimapid(var_1[0].objid);
}

function comparepriorityandtime(var_0, var_1) {
  if(var_0.priority == var_1.priority) {
    return (var_0.requesttime < var_1.requesttime);
  }

  return var_0.priority < var_1.priority;
}

function getnextminimapid(var_0) {
  if(level.minimapobjidpool.index == 32) {
    if(!removebestminimapid(var_0)) {
      return -1;
    }
  }

  if(!level.minimapobjidpool.reclaimed.size) {
    if(level.minimapobjidpool.index == 32) {
      return -1;
    } else {
      var_1 = level.minimapobjidpool.index;
      level.minimapobjidpool.index++;
    }
  } else {
    var_1 = level.minimapobjidpool.reclaimed[level.minimapobjidpool.reclaimed.size - 1];
    level.minimapobjidpool.reclaimed[level.minimapobjidpool.reclaimed.size - 1] = undefined;
  }

  return var_1;
}

function returnminimapid(var_0) {
  if(!isDefined(var_0) || var_0 == -1) {
    return false;
  }

  for(var_1 = 0; var_1 < level.minimapobjidpool.reclaimed.size; var_1++) {
    if(var_0 == level.minimapobjidpool.reclaimed[var_1]) {
      return false;
    }
  }

  level.minimapobjidpool.active[var_0] = undefined;
  objective_delete(var_0);
  level.minimapobjidpool.reclaimed[level.minimapobjidpool.reclaimed.size] = var_0;
  return true;
}

function requestworldid(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 10;
  }

  var_2 = getnextworldid(var_1);

  if(var_2 == -1) {
    return undefined;
  }

  var_3 = spawnStruct();
  var_3.requesttime = gettime();
  var_3.objid = var_2;
  var_3.identifier = var_0;
  level.worldobjidpool.active[var_2] = var_3;
  level notify("worldObjIDPool_requested", var_0, var_2);
  return var_2;
}

function freeworldid(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  foreach(var_2 in level.worldobjidpool.active) {
    if(var_2.identifier == var_0) {
      unset_all_locations(var_2.objid);
      internal_reclaimworldid(var_2.objid);
    }
  }
}

function freeworldidbyobjid(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  foreach(var_2 in level.worldobjidpool.active) {
    if(var_2.objid == var_0) {
      unset_all_locations(var_2.objid);
      internal_reclaimworldid(var_2.objid);
    }
  }
}

function removebestworldid(var_0) {
  var_1 = [];

  foreach(var_3 in level.worldobjidpool.active) {
    if(var_3.priority < var_0) {
      var_1 = var_3;
    }
  }

  scripts\engine\utility::array_sort_with_func(var_1, &comparepriorityandtime);
  return internal_reclaimworldid(var_1[0].objid);
}

function getnextworldid(var_0) {
  if(level.worldobjidpool.index == 32) {
    if(!removebestworldid(var_0)) {
      return -1;
    }
  }

  if(level.worldobjidpool.reclaimed.size <= 0) {
    if(level.worldobjidpool.index == 32) {
      return -1;
    } else {
      var_1 = level.worldobjidpool.index;
      level.worldobjidpool.index++;
    }
  } else {
    var_1 = level.worldobjidpool.reclaimed[level.worldobjidpool.reclaimed.size - 1];
    level.worldobjidpool.reclaimed[level.worldobjidpool.reclaimed.size - 1] = undefined;
  }

  return var_1;
}

function internal_reclaimworldid(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  var_1 = var_0;

  for(var_2 = 0; var_2 < level.worldobjidpool.reclaimed.size; var_2++) {
    if(var_1 == level.worldobjidpool.reclaimed[var_2]) {
      return false;
    }
  }

  objective_delete(var_1);
  level notify("objective_id_reclaimed_" + var_1);
  level.worldobjidpool.active[var_1] = undefined;
  level.worldobjidpool.reclaimed[level.worldobjidpool.reclaimed.size] = var_1;
  return true;
}

function is_objective_active(var_0) {
  foreach(var_2 in level.activequests) {
    if(var_2.ref == var_0) {
      return true;
    }
  }

  return false;
}

function _add_objective(var_0, var_1, var_2, var_3, var_4) {
  objective_delete(var_0);

  if(isDefined(var_1)) {
    objective_state(var_0, var_1);
  }

  if(isDefined(var_2)) {
    objective_position(var_0, var_2);
  }

  if(isDefined(var_3) && var_3 != "") {
    objective_icon(var_0, var_3);
  }

  if(isDefined(var_4)) {
    objective_setminimapiconsize(var_0, var_4);
    return;
  }
}

function minimap_objective_add(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 == -1) {
    return;
  }

  _add_objective(var_0, var_1, var_2, var_3, var_4);
}

function minimap_objective_state(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_state(var_0, var_1);
}

function minimap_objective_position(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_position(var_0, var_1);
}

function minimap_objective_icon(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_icon(var_0, var_1);
}

function minimap_objective_setbackground(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setbackground(var_0, var_1);
}

function minimap_objective_onentity(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_onentity(var_0, var_1);
}

function minimap_objective_onentitywithrotation(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_onentity(var_0, var_1);
  objective_setrotateonminimap(var_0, 1);
}

function minimap_objective_setzoffset(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setzoffset(var_0, var_1);
}

function minimap_objective_player(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_removeallfrommask(var_0);
  objective_addclienttomask(var_0, var_1);
  objective_showtoplayersinmask(var_0);
}

function minimap_objective_team(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_removeallfrommask(var_0);
  objective_addteamtomask(var_0, var_1);
  objective_showtoplayersinmask(var_0);
}

function minimap_objective_playermask_hidefromall(var_0) {
  if(var_0 == -1) {
    return;
  }

  objective_addalltomask(var_0);
  objective_hidefromplayersinmask(var_0);
}

function minimap_objective_playermask_hidefrom(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_showtoplayersinmask(var_0);
  objective_removeclientfrommask(var_0, var_1);
}

function minimap_objective_playermask_showto(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_showtoplayersinmask(var_0);
  objective_addclienttomask(var_0, var_1);
}

function minimap_objective_playermask_showtoall(var_0) {
  if(var_0 == -1) {
    return;
  }

  objective_addalltomask(var_0);
  objective_showtoplayersinmask(var_0);
}

function minimap_objective_playerteam(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_removeallfrommask(var_0);

  if(level.teambased) {
    objective_addteamtomask(var_0, var_1.team);
  } else {
    objective_addclienttomask(var_0, var_1);
  }

  objective_showtoplayersinmask(var_0);
}

function minimap_objective_playerenemyteam(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_removeallfrommask(var_0);

  if(level.teambased) {
    objective_addteamtomask(var_0, var_1.team);
  } else {
    objective_addclienttomask(var_0, var_1);
  }

  objective_hidefromplayersinmask(var_0);
}

function minimap_objective_team_addtomask(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_addteamtomask(var_0, var_1);
  objective_showtoplayersinmask(var_0);
}

function minimap_objective_team_removefrommask(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_removeteamfrommask(var_0, var_1);
  objective_showtoplayersinmask(var_0);
}

function minimap_objective_pin_global(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setpinned(var_0, var_1);
}

function minimap_objective_pin_team(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_pinforteam(var_0, var_1);
}

function minimap_objective_unpin_team(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_unpinforteam(var_0, var_1);
}

function minimap_objective_pin_player(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_pinforclient(var_0, var_1);
}

function minimap_objective_unpin_player(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_unpinforclient(var_0, var_1);
}

function ref_11f83(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_sethot(var_0, var_1);
}

function objective_show_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setshowprogress(var_0, var_1);
}

function objective_show_team_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_showprogressforteam(var_0, var_1);
}

function objective_hide_team_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_hideprogressforteam(var_0, var_1);
}

function objective_show_player_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_showprogressforclient(var_0, var_1);
}

function objective_hide_player_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_hideprogressforclient(var_0, var_1);
}

function objective_set_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setprogress(var_0, var_1);
}

function objective_set_progress_team(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setprogressteam(var_0, var_1);
}

function objective_set_progress_client(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setprogressclient(var_0, var_1);
}

function objective_set_play_intro(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setplayintro(var_0, var_1);
}

function objective_set_play_outro(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setplayoutro(var_0, var_1);
}

function objective_set_pulsate(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setpulsate(var_0, var_1);
}

function update_objective(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(level.objectivestabledata[var_0])) {
    return;
  }

  var_10 = level.objectivestabledata[var_0];
  var_11 = level.objectivestabledata[var_0].objectiveindex;

  if(isDefined(var_8) && var_8) {
    objective_delete(var_11);
  }

  if(isDefined(var_9)) {
    objective_setplayoutro(var_11, var_9);
  }

  if(isDefined(var_8)) {
    objective_setplayintro(var_11, var_8);
  }

  if(isDefined(var_1)) {
    objective_state(var_11, var_1);
  }

  if(isDefined(var_2)) {
    objective_position(var_11, var_2);
  }

  if(isDefined(var_3)) {
    objective_setdescription(var_11, var_3);
  }

  if(isDefined(var_5)) {
    if(var_5 > 8) {
      var_5 = 8;
    }

    if(var_5 < 1) {
      var_5 = 1;
    }

    setomnvar("cp_objective_desc_index", var_5);
  }

  if(isDefined(var_4)) {
    objective_setlabel(var_11, var_4);
  }

  if(isDefined(var_6)) {
    objective_icon(var_11, var_6);
  }

  if(isDefined(var_7)) {
    objective_setbackground(var_11, var_7);
  }

  setomnvarbasedonindex(0);
  wait 0.5;
  setomnvarbasedonindex(var_10.index);
}

function getobjectiveforfloor(var_0) {
  var_1 = undefined;

  if(isDefined(level.mapbasedobjectiverules)) {
    var_1 = [[level.mapbasedobjectiverules]](level.floorobjectives, var_0);
  } else {
    var_1 = scripts\engine\utility::random(level.floorobjectives);
  }

  thread run_objective(var_1.ref, var_1.questtype);
}

function get_active_objectives() {
  return level.activequests;
}

function get_objective_type(var_0) {
  if(!isDefined(level.objectivestabledata)) {
    return;
  }

  foreach(var_2 in level.objectivestabledata) {
    if(var_2.ref == var_0) {
      if(isDefined(var_2.questtype)) {
        return var_2.questtype;
      }
    }
  }

  return undefined;
}

function create_breadcrumb_for_team(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp\utility::getplayersinteam(var_0);
  var_5 = [];

  foreach(var_7 in var_4) {
    var_5 = create_breadcrumb_for_player(var_7, var_1, var_2, var_3);
    wait 0.5;
  }

  return var_5;
}

function create_breadcrumb_for_player(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.activebreadcrumbs)) {
    level.activebreadcrumbs = [];
  }

  var_4 = spawnStruct();
  var_4.stepstructs = [];
  var_4.ref_138a6 = [];
  var_5 = scripts\engine\utility::getStructArray(var_1, "script_noteworthy");

  if(var_5.size <= 0) {
    return undefined;
  }

  var_5 = scripts\engine\utility::array_sort_with_func(var_5, &compare_breadcrumb_order);

  foreach(var_7 in var_5) {
    var_8 = var_4.stepstructs.size;
    var_4.stepstructs[var_8] = var_7.origin;

    if(isDefined(var_7.script_radius)) {
      var_4.ref_138a6[var_8] = squared(var_7.script_radius);
    }
  }

  var_4.id = requestworldid("breadcrumb_for_" + var_0.name, 2);

  if(isDefined(var_3) && var_3 != "") {
    var_4.iconname = var_3;
  } else {
    var_4.iconname = "icon_waypoint_objective_general";
  }

  if(isDefined(var_2)) {
    var_4.label = var_2;
  }

  var_4.player = var_0;
  var_8 = 0;

  if(isDefined(level.disable_hvt_pickup)) {
    var_8 = [[level.disable_hvt_pickup]](var_4);
  }

  update_breadcrumb_for_player(var_4, var_8);
  thread watchforplayernearbcrumb(var_4);
  level.activebreadcrumbs[level.activebreadcrumbs.size] = var_4;
  return var_4;
}

function compare_breadcrumb_order(var_0, var_1) {
  return int(var_0.targetname) < int(var_1.targetname);
}

function watchforplayernearbcrumb(var_0) {
  level endon("game_ended");
  self endon("breadcrumb_finished");
  var_1 = self.player;
  var_2 = 0;

  if(isDefined(var_0)) {
    var_2 = var_0;
  }

  var_3 = self.stepstructs.size;
  var_4 = 90000;

  while(var_2 < var_3 && isPlayer(self.player)) {
    if(distancesquared(var_1.origin, self.stepstructs[var_2]) <= printcodechosen(self, var_2)) {
      var_2++;

      if(var_2 >= var_3) {
        level notify("finished_last_breadcrumb", var_1);
        delete_breadcrumb(level, self);
      } else {
        update_breadcrumb_for_player(self, var_2);
      }

      waitframe();
      continue;
    } else if(distancesquared(var_1.origin, self.stepstructs[var_3 - 1]) <= printcodechosen(self, var_3 - 1)) {
      level notify("finished_last_breadcrumb", var_1);
      delete_breadcrumb(level, self);
    }

    wait 0.1;
  }
}

function printcodechosen(var_0, var_1) {
  if(isDefined(var_0.ref_138a6[var_1])) {
    return var_0.ref_138a6[var_1];
  }

  return 90000;
}

function update_breadcrumb_for_player(var_0, var_1) {
  if(!isPlayer(var_0.player) || !isDefined(var_0) || !isDefined(var_0.stepstructs[var_1])) {
    return 0;
  }

  objective_delete(var_0.id);
  waitframe();

  if(isDefined(var_0.label)) {
    objective_setlabel(var_0.id, var_0.label);
  }

  objective_position(var_0.id, var_0.stepstructs[var_1]);
  objective_icon(var_0.id, var_0.iconname);
  objective_setbackground(var_0.id, 1);

  foreach(var_3 in level.players) {
    if(var_3 != var_0.player) {
      objective_removeclientfrommask(var_0.id, var_3);
      continue;
    }

    objective_addclienttomask(var_0.id, var_3);
  }

  objective_state(var_0.id, "current");
}

function delete_breadcrumb(var_0) {
  objective_delete(var_0.id);
  internal_reclaimworldid(var_0.id);
  var_0 notify("breadcrumb_finished");

  if(scripts\engine\utility::array_contains(level.activebreadcrumbs, var_0)) {
    level.activebreadcrumbs = scripts\engine\utility::array_remove(level.activebreadcrumbs, var_0);
    return;
  }
}

function delete_breadcrumb_array(var_0) {
  foreach(var_2 in var_0) {
    delete_breadcrumb(var_2);
  }
}

function ref_11f80(var_0) {
  objective_state(var_0, "current");
  objective_setshowoncompass(var_0, 1);
  objective_setminimapiconsize(var_0, "icon_regular");
  level notify("objective_minimapUpdate");
}

function screenent_c(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "minor_objective";
  }

  foreach(var_2 in level.players) {
    var_2 thread scripts\cp\drone\emp_drone::giverankxp(var_0, scripts\cp\drone\emp_drone::getscoreinfovalue(var_0));
  }

  level notify("give_objective_xp_to_all_players", var_0);
}

function start_mode_after_playerspawn() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.pers["periodic_xp_participation"])) {
      var_1.pers["periodic_xp_participation"]++;
      continue;
    }

    var_1.pers["periodic_xp_participation"] = 1;
  }
}

function ref_12868(var_0) {
  var_1 = getobjectivestructfromref(var_0);

  if(!isDefined(var_1)) {
    return;
  }

  jumpiffalse(isDefined(level.objectivestabledata) && isDefined(level.objectivestabledata[var_1.objname])) LOC_000000ca;
  var_2 = level.objectivestabledata[var_1.objname].index;
  var_3 = level.objectivestabledata[var_1.objname].pathexit;

  if(isDefined(var_3) && var_3 != "") {
    foreach(var_5 in level.players) {
      var_5 setclientomnvar("ui_cp_mission_fail_index", var_2);
    }

    return;
  }

  foreach(var_5 in level.players) {
    var_5 setclientomnvar("ui_cp_mission_fail_index", 0);
  }

  return;
}

function ref_12ddb() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  scripts\engine\utility::flag_wait("objective_table_parsed");
  scripts\engine\utility::flag_wait("objectives_registered");
  var_0 = getDvar(level.script + "_start_obj", "");

  if(isDefined(var_0) && var_0 != "") {
    if(isDefined(level.objectivestabledata[var_0])) {
      var_1 = level.objectivestabledata[var_0];

      if(isDefined(var_1.ondebugstartfunc)) {
        [[var_1.ondebugstartfunc]](var_1);
      }

      thread run_objective(level, var_1.objname);
      return;
    }

    return;
  }
}