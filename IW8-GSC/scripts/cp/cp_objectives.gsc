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
  var0 = scripts\engine\utility::random(level.primaryobjectives);
  thread run_objective(level, var0);
}

function runsecondaryobjectives() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("objectives_registered");
  wait 2;

  if(!isDefined(level.secondaryobjectives) || !isDefined(level.num_secondary_objectives_active) || !level.secondaryobjectives.size) {
    return;
  }

  var0 = scripts\engine\utility::array_randomize_objects(level.secondaryobjectives);
  var1 = int(clamp(var0.size, 0, level.num_secondary_objectives_active));

  for(var2 = 0;; var2--) {
    while(var2 < var1) {
      thread run_objective(var0[var2], "secondary");
      var2++;
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

  var0 = scripts\engine\utility::array_randomize_objects(level.infiniteobjectives);
  var1 = int(clamp(var0.size, 0, level.num_side_objectives_active));

  for(var2 = 0;; var2--) {
    while(var2 < var1) {
      thread run_objective(var0[var2], "infinite");
      var2++;
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

function parseobjectivestable(var0) {
  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  if(!isDefined(var0)) {
    var0 = "cp/cp_default_objectives.csv";
  }

  if(isDefined(level.objectivesmatrixtable)) {
    var1 = level.objectivesmatrixtable;
  } else {
    var1 = undefined;
  }

  for(var2 = 0;; var2++) {
    var3 = tablelookupbyrow(var1, var2, 0);

    if(var3 == "") {
      break;
    }

    var4 = spawnStruct();
    var4.index = int(var3);
    var4.ref = tablelookup(var1, 0, var3, 1);
    var4.activatestring = tablelookup(var1, 0, var3, 2);
    var4.label = tablelookup(var1, 0, var3, 3);
    var4.questtype = tablelookup(var1, 0, var3, 5);
    var4.objicon = tablelookup(var1, 0, var3, 6);
    var4.showobjprogress = int(tablelookup(var1, 0, var3, 8));
    var4.timer1 = int(tablelookup(var1, 0, var3, 9));
    var4.timer2 = int(tablelookup(var1, 0, var3, 10));
    var4.timer3 = int(tablelookup(var1, 0, var3, 11));
    var4.client_hint = int(tablelookup(var1, 0, var3, 25));
    var4.pathexit = tablelookup(var1, 0, var3, 24);
    var4.variable1 = int(tablelookup(var1, 0, var3, 12));
    var4.variable2 = int(tablelookup(var1, 0, var3, 13));
    var4.variable3 = int(tablelookup(var1, 0, var3, 14));
    var4.skipdescription = int(tablelookup(var1, 0, var3, 15));
    var4.points = int(tablelookup(var1, 0, var3, 16));
    var4.excludedfromrandompool = int(tablelookup(var1, 0, var3, 17));
    var4.nofailontimeout = int(tablelookup(var1, 0, var3, 18));
    var4.csdependency = tablelookup(var1, 0, var3, 26);

    if(isDefined(var4.csdependency) && var4.csdependency == "") {
      var4.csdependency = undefined;
    }

    var4.iconposref = tablelookup(var1, 0, var3, 7);
    var4.disablefade = int(tablelookup(var1, 0, var3, 27)) >= 1;
    var4.eventflag = tablelookup(var1, 0, var3, 31);
    var4.ref_11f8d = [];

    if(isDefined(var4.excludedfromrandompool) && var4.excludedfromrandompool >= 1) {
      var4.excludedfromrandompool = 1;
    } else {
      var4.excludedfromrandompool = 0;
    }

    switch (var4.questtype) {
      case "primary":
        level.primaryobjectives[level.primaryobjectives.size] = var4.ref;
        break;
      case "secondary":
        level.secondaryobjectives[level.secondaryobjectives.size] = var4.ref;
        break;
      case "infinite":
        level.infiniteobjectives[level.infiniteobjectives.size] = var4.ref;
        break;
      case "floor":
        level.floorobjectives[level.floorobjectives.size] = var4;
        break;
    }

    if(isDefined(var1)) {
      var4.nextsteps = [];
      var5 = 0;

      for(var6 = 1;; var6++) {
        var7 = tablelookup(var1, var5, var4.ref, var6);

        if(var7 == "") {
          break;
        }

        var4.nextsteps[var4.nextsteps.size] = var7;
      }
    }

    level.objectivestabledata[var4.ref] = var4;
  }

  scripts\engine\utility::flag_set("objective_table_parsed");
}

function processiconposref(var0) {
  var1 = var0.iconposref;

  if(!isDefined(var1)) {
    return;
  }

  var2 = strtok(var1, ",");
  var3 = undefined;

  if(var2.size == 3) {
    var3 = (int(var2[0]), int(var2[1]), int(var2[2]));
  } else if(var2.size == 2) {
    if(isDefined(level.struct_class_names[var2[1]]) && isDefined(level.struct_class_names[var2[1]][var2[0]])) {
      var3 = scripts\engine\utility::getStructArray(var2[0], var2[1]);
    } else {
      var3 = getEnt(var2[0], var2[1]);
    }
  }

  if(isDefined(var3)) {
    if(isvector(var3)) {
      var0.iconpos = var3;
      var0.ref_11f8d[var0.ref_11f8d.size] = var3;
      return;
    }

    if(isarray(var3)) {
      if(!isDefined(var0.iconpos)) {
        var0.iconpos = [];
      }

      foreach(var5 in var3) {
        var0.iconpos[var0.iconpos.size] = var5.origin;
        var0.ref_11f8d[var0.ref_11f8d.size] = var5.origin;
        var0.interactionstruct = var5;
        var5.objectivestruct = var0;
      }

      return;
    }

    var0.iconpos = var3.origin;
    return;
  }

  var0.iconpos = var3;
}

function ref_1317e(var0, var1) {
  if(isarray(var1)) {
    var0.ref_11f8d = var1;
    return;
  }

  var0.ref_11f8d = [];
  var0.ref_11f8d[0] = var1;
}

function getobjectivestructfromref(var0) {
  if(isDefined(level.objectivestabledata[var0])) {
    return level.objectivestabledata[var0];
  }

  return undefined;
}

function overridenextstep(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var1)) {
    var0.nextsteps = undefined;
    return;
  }

  var0.nextsteps = [];

  if(isarray(var1)) {
    var0.nextsteps = var1;
    return;
  }

  var0.nextsteps[0] = var1;
}

function addheadicon(var0, var1, var2) {
  if(!isDefined(var1)) {
    var1 = "icon_waypoint_objective_general";
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  var0.headiconid = thread scripts\cp\utility::ent_createheadicon(var0, var2, self.currentteam, var1);
  setheadiconzoffset(var0.headiconid, 1);
  setheadiconsnaptoedges(var0.headiconid, 0);

  if(!isDefined(self.headiconents)) {
    self.headiconents = [];
  }

  self.headiconents[self.headiconents.size] = var0;
  return var0.headiconid;
}

function removeheadicon(var0) {
  thread scripts\cp\utility::ent_deleteheadicon(var0, var0.headiconid);
  self.headiconents = scripts\engine\utility::array_remove(self.headiconents, var0);
}

function registerobjective(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(!isDefined(level.objectivestabledata[var0])) {
    return;
  }

  var9 = level.objectivestabledata[var0];
  var9.init = var1;
  var9.startfunc = var2;
  var9.endfunc = var3;
  var9.ondebugbeatfunc = var4;
  var9.ondebugstartfunc = var5;
  var9.eventtype = var7;
  var9.ref = var0;
  var9.string = var6;
  var9.iscompletednaturally = 0;
  var9.isregistered = 1;
  var9.objname = var0;
  createdevguientryforobjective(var9);
}

function objective_update_internal(var0, var1, var2, var3, var4, var5, var6, var7) {
  level notify(var0 + "_update_instance");
  level endon(var0 + "_update_instance");
  level endon(var0 + "_completed");
  level endon(var0 + "_failed");
  level endon(var0 + "objective_paused");
  var8 = undefined;
  var6 = undefined;
  var9 = undefined;

  if(isDefined(level.objectives_table)) {
    var10 = check_event_flag(var0);

    if(istrue(var10)) {
      thread event_update_internal(var0, var1, var2, var3, var4, var5);
      return;
    }

    var8 = int(tablelookup(level.objectives_table, 1, var0, 0));
    var9 = check_objective_reset_value(var0);

    if(istrue(var9)) {
      reset_objective_slots();
    }

    if(!isDefined(var6)) {
      var6 = get_objective_slot(var0);
    }

    lua_objective_incomplete(var0);
  }

  if(!isDefined(level.objectives_table)) {
    var8 = int(tablelookup("cp/cp_default_objectives.csv", 1, var0, 0));
  }

  if(!isDefined(var8)) {
    return;
  }

  if(!isDefined(var4)) {
    var4 = 0;
  }

  var11 = 1;
  var12 = get_objective_type(var0);

  if(isDefined(var12)) {
    if(var12 == "global") {
      var11 = 0;
    }
  }

  if(istrue(var11)) {
    show_objective_widget();

    switch (var6) {
      case 1:
        setomnvar("cp_objective_sub_1_index", var8);
        break;
      case 2:
        setomnvar("cp_objective_sub_2_index", var8);
        break;
      case 3:
        setomnvar("cp_objective_sub_3_index", var8);
        break;
      case 4:
        setomnvar("cp_objective_sub_4_index", var8);
        break;
    }

    if(isDefined(var5)) {
      switch (var6) {
        case 1:
          setomnvar("cp_objective_sub_count_1", var5);
          break;
        case 2:
          setomnvar("cp_objective_sub_count_2", var5);
          break;
        case 3:
          setomnvar("cp_objective_sub_count_3", var5);
          break;
        case 4:
          setomnvar("cp_objective_sub_count_4", var5);
          break;
      }
    }
  }

  if(soundexists("ui_new_objective_popup")) {
    foreach(var14 in level.players) {
      var14 playsoundtoplayer("ui_new_objective_popup", var14);
    }
  }

  if(isDefined(var1) && var1 > 0) {
    setomnvar("cp_countdown_color", 0);
    var16 = var6;

    if(istrue(var7)) {
      var16 = 5;
    }

    setomnvar("cp_countdown_timer_alpha", var16);
    setomnvar("cp_countdown_timer", gettime() + var1 * 1000);

    if(isDefined(var2) && var2 > 0 && var2 < var1 && !isDefined(var3)) {
      wait var1 - var2;
      setomnvar("cp_countdown_color", 1);
      wait var2;
    } else if(isDefined(var2) && var2 > 0 && var2 < var1 && isDefined(var3) && var3 < var2) {
      wait var1 - var2;
      setomnvar("cp_countdown_color", 1);
      wait var2 - var3;
      setomnvar("cp_countdown_color", 2);
      wait var3;
    } else {
      wait var1;
    }

    if(!istrue(var4)) {
      fail_objective(var0);
    } else {
      level notify(var0 + "_timer_complete");
    }

    reset_objective_timers();
    return;
  }
}

function event_update_internal(var0, var1, var2, var3, var4, var5) {
  level notify(var0 + "_update_instance");
  level endon(var0 + "_update_instance");
  level endon(var0 + "_completed");
  level endon(var0 + "_failed");
  level endon(var0 + "objective_paused");
  var6 = undefined;
  var7 = undefined;

  if(isDefined(level.objectives_table)) {
    var6 = int(tablelookup(level.objectives_table, 1, var0, 0));
    var7 = check_objective_reset_value(var0);

    if(istrue(var7)) {
      reset_objective_slots();
    }

    lua_objective_incomplete(var0);
  }

  if(!isDefined(level.objectives_table)) {
    var6 = int(tablelookup("cp/cp_default_objectives.csv", 1, var0, 0));
  }

  if(!isDefined(var6)) {
    return;
  }

  if(!isDefined(var4)) {
    var4 = 0;
  }

  var8 = 1;
  var9 = get_objective_type(var0);

  if(isDefined(var9)) {
    if(var9 == "global") {
      var8 = 0;
    }
  }

  if(istrue(var8)) {
    setomnvar("cp_objective_event_index", var6);

    if(isDefined(var5)) {
      setomnvar("cp_objective_event_count", var5);
    }
  }

  if(soundexists("iw8_new_objective_sfx")) {
    playsoundatpos((0, 0, 0), "iw8_new_objective_sfx");
  }

  if(isDefined(var1) && var1 > 0) {
    setomnvar("cp_countdown_event_color", 0);
    setomnvar("cp_countdown_event_timer_alpha", 1);
    setomnvar("cp_countdown_event_timer", gettime() + var1 * 1000);

    if(isDefined(var2) && var2 > 0 && var2 < var1 && !isDefined(var3)) {
      wait var1 - var2;
      setomnvar("cp_countdown_event_color", 1);
      wait var2;
    } else if(isDefined(var2) && var2 > 0 && var2 < var1 && isDefined(var3) && var3 < var2) {
      wait var1 - var2;
      setomnvar("cp_countdown_event_color", 1);
      wait var2 - var3;
      setomnvar("cp_countdown_event_color", 2);
      wait var3;
    } else {
      wait var1;
    }

    if(!istrue(var4)) {
      fail_objective(var0);
      reset_event_timers();
      return;
    }

    level notify(var0 + "_timer_complete");
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

function get_objective_slot(var0) {
  var1 = undefined;

  if(isDefined(level.objectives_table)) {
    var1 = tablelookup(level.objectives_table, 1, var0, 29);
  }

  if(isDefined(var1) && var1 != "") {
    return int(var1);
  }

  return 1;
}

function check_objective_reset_value(var0) {
  var1 = undefined;

  if(isDefined(level.objectives_table)) {
    var1 = tablelookup(level.objectives_table, 1, var0, 30);
  }

  if(isDefined(var1) && var1 != "") {
    return 1;
  }

  return 0;
}

function fail_objective(var0) {
  level notify(var0 + "_failed");
  reset_objective_omnvars(var0);
}

function run_objective(var0, var1, var2) {
  level endon("game_ended");
  level endon("debug_beat_" + var0 + "_objective");
  level endon(var0 + "_failed");

  if(getdvarint("scr_disable_objectives", 0)) {
    return;
  }

  if(!isDefined(level.objectivestabledata[var0])) {
    return;
  }

  var3 = level.objectivestabledata[var0];
  var3.objname = var0;
  var3.iscompletednaturally = 0;

  if(isDefined(var3.csdependency) && var3.csdependency != "") {
    if(!scripts\engine\utility::flag_exist(var3.csdependency)) {
      scripts\engine\utility::flag_init(var3.csdependency);
    }

    if(!scripts\engine\utility::flag(var3.csdependency)) {
      scripts\engine\utility::flag_set(var3.csdependency);
    }

    scripts\engine\utility::flag_wait(var3.csdependency + "_completed");
  }

  processiconposref(var3);

  if(!isDefined(var2)) {
    var3.currentteam = "allies";
  } else {
    var3.currentteam = var2;
  }

  if(isDefined(var1) && var1 == "primary") {
    var3.alwaysshowicon = 1;
  } else if(isDefined(var1) && var1 == "global") {
    var3.alwaysshowicon = 1;
  }

  thread watchfordebugcompletion(level, var3, var0);
  thread watchforobjectivefailure(level, var3, var0);
  initializeobjective(var3, var0, var1);
  startobjective(var3, var0, var1);
  completeobjective(var3, var0, var1);

  if(isDefined(var1)) {
    level notify(var1 + "_objective_completed");
    return;
  }
}

function watchforobjectivefailure(var0, var1, var2) {
  level endon("game_ended");
  level endon("debug_beat_" + var1 + "_objective");
  var0 endon(var1 + "_completed");
  level waittill(var1 + "_failed");
  var3 = var0.ref;

  if(isDefined(var0.hudicon)) {
    destroy_objective_waypoint(var0.hudicon);
  }

  if(isDefined(var0.currentteam)) {
    var0.currentteam = undefined;
  }

  if(isDefined(var0.headiconents)) {
    foreach(var5 in var0.headiconents) {
      removeheadicon(var0, var5);
    }

    var0.headiconents = undefined;
  }

  remove_from_active_quests(var0);
  mark_objective_failed(var3);
  reset_objective_omnvars(var3);
  tryrunnextobjective(var0, 0);
}

function mark_objective_failed(var0) {
  var1 = getobjectivestructfromref(var0);

  if(!isDefined(var1)) {
    return;
  }

  var2 = var1.objectiveindex;

  if(!isDefined(var2)) {
    return;
  }

  objective_state(var2, "failed");
}

function lua_objective_complete(var0) {
  var1 = check_event_flag(var0);

  if(!istrue(var1)) {
    var2 = get_objective_slot(var0);
    var3 = check_for_objective_timer(var0);

    if(var3) {
      reset_objective_timers();
    }

    switch (var2) {
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

function lua_objective_incomplete(var0, var1) {
  var1 = check_event_flag(var0);

  if(!istrue(var1)) {
    var2 = get_objective_slot(var0);
    var3 = check_for_objective_timer(var0);

    if(var3) {
      reset_objective_timers();
    }

    switch (var2) {
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

function check_for_objective_timer(var0) {
  var1 = int(tablelookup(level.objectives_table, 1, var0, 9));

  if(isDefined(var1) && var1 > 0) {
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

function reset_subobjective_slot(var0) {
  var1 = get_objective_slot(var0);
  setomnvar("cp_objective_sub_" + var1 + "_index", 0);
  setomnvar("cp_objective_sub_count_" + var1, -1);
}

function check_event_flag(var0) {
  var1 = int(tablelookup(level.objectives_table, 1, var0, 31));

  if(isDefined(var1) && var1 == 1) {
    return 1;
  }

  return 0;
}

function reset_objective_omnvars(var0) {
  var1 = check_event_flag(var0);

  if(!istrue(var1)) {
    var2 = get_objective_slot(var0);

    switch (var2) {
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

function watchfordebugcompletion(var0, var1, var2) {
  level endon("game_ended");
  level endon(var1 + "_failed");
  var0 endon(var1 + "_completed");
  level waittill("debug_beat_" + var0.objname + "_objective");
  wait 1;

  if(isDefined(var0.ondebugbeatfunc)) {
    [[var0.ondebugbeatfunc]](var0);
  }

  if(!var0.iscompletednaturally) {
    completeobjective(var0, var1, var2);
  }

  if(isDefined(var2)) {
    level notify(var2 + "_objective_completed");
    return;
  }
}

function debugbeatobjective(var0) {
  level notify("debug_beat_" + var0 + "_objective");
}

function createdevguientryforobjective(var0) {
  if(!isDefined(level.completedobjectives)) {
    var1 = 0;
  } else {
    var1 = level.completedobjectives.size + 1;
  }

  var2 = "devgui_cmd \"CP Debug:2 / Objectives / Complete / Beat " + var1.objname + " Objective:" + var1 + "\" \"set start_objective_debug notify-debug_beat_" + var1.objname + "_objective\" \n";
  scripts\cp\utility::addentrytodevgui(var2);

  if(!istrue(var1.excludedfromrandompool)) {
    var2 = "devgui_cmd \"CP Debug:2 / Objectives / Start / Start " + var1.objname + " Objective:" + var1 + "\" \"set start_objective_debug notify-debug-start_-" + var1.objname + "-objective\" \n";
    scripts\cp\utility::addentrytodevgui(var2);
    return;
  }
}

function addprintlinetext(var0) {}

function initializeobjective(var0, var1, var2) {
  level endon("debug_beat_" + var0.objname + "_objective");
  default_init_objective(var0, var2);

  if(isDefined(var0.init)) {
    [[var0.init]](var0);
  }

  var0 notify("objective_initialized");
}

function startobjective(var0, var1, var2) {
  level endon("game_ended");
  level endon("debug_beat_" + var0.objname + "_objective");
  getentitylessscriptablearray("dlog_event_cpdata_level_progression", ["levelname", level.script, "active_objective", var1, "time_stamp", gettime(), "description", "Started"]);
  level.activequests[level.activequests.size] = var0;

  if(level.active_objectives_string.size <= 0) {
    level.active_objectives_string = var1;
  } else {
    level.active_objectives_string = level.active_objectives_string + "," + var1;
  }

  if(isDefined(var0.startfunc)) {
    [[var0.startfunc]](var0);
    return;
  }
}

function completeobjective(var0, var1, var2) {
  if(!scripts\engine\utility::array_contains(level.ref_12880, var0.objname)) {
    level.ref_12880 = scripts\engine\utility::array_add(level.ref_12880, var0.objname);
  }

  remove_from_active_quests(var0);

  if(isDefined(var2) && var2 == "global" && !istrue(scripts\cp\cp_objectives_events::is_event_completed(var0.ref))) {
    if(isDefined(var0.hudicon)) {
      destroy_objective_waypoint(var0.hudicon);
    }

    delete_objective(var0.objname);
    return;
  }

  var0 notify("objective_completed");
  var0.iscompletednaturally = 1;
  defaultcompleteobjective(var0);
  start_mode_after_playerspawn();
  getentitylessscriptablearray("dlog_event_cpdata_level_progression", ["levelname", level.script, "active_objective", var1, "time_stamp", gettime(), "description", "Completed"]);

  if(isDefined(var0.points) && var0.points > 0) {
    var3 = var0.points;

    if(level.gametype == "cp_survival") {
      var3 = 100;
    }

    foreach(var5 in level.players) {
      var5 scripts\cp\cp_persistence::give_player_currency(var3, "large");
    }
  }

  if(isDefined(var0.endfunc)) {
    [[var0.endfunc]](var0);
  }

  tryrunnextobjective(var0, 1);
  level notify(var1 + "_completed");
  var0 notify(var1 + "_completed");
}

function delete_objective(var0) {
  var1 = getobjectivestructfromref(var0);

  if(!isDefined(var1)) {
    return;
  }

  var2 = var1.objectiveindex;

  if(!isDefined(var2)) {
    return;
  }

  objective_delete(var2);
}

function tryrunnextobjective(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(getDvar("MOLPOSLOMO") == "cp_survival" && var0.questtype == "primary") {
    if(var1 && isDefined(var0.nextsteps) && var0.nextsteps.size > 0) {
      thread run_objective(var0.nextsteps[0], var0.questtype);
      return;
    }

    return;
  }

  if(var1) {
    if(isDefined(var0.nextsteps) && var0.nextsteps.size > 0) {
      thread run_objective(scripts\engine\utility::random(var0.nextsteps), var0.questtype);
      return;
    }

    return;
  }
}

function remove_from_active_quests(var0) {
  level.activequests = scripts\engine\utility::array_remove(level.activequests, var0);
  var1 = strtok(level.active_objectives_string, ",");

  if(var1.size > 0) {
    var2 = "";
    var3 = 0;

    foreach(var5 in var1) {
      if(var5 == var0.ref) {
        continue;
      }

      if(var3 == 0) {
        var2 = var5;
      } else {
        var2 = var2 + "," + var5;
      }

      var3++;
    }

    level.active_objectives_string = var2;
    return;
  }
}

function findandrunrandomprimaryobjective() {
  level endon("game_ended");
  var0 = undefined;
  var1 = [];

  foreach(var3 in level.objectivestabledata) {
    if(var3.questtype == "primary" && !scripts\engine\utility::array_contains(level.completedobjectives, var3) && istrue(var3.isregistered) && !istrue(var3.excludedfromrandompool)) {
      var1 = var3;
    }
  }

  if(var1.size <= 0) {
    return;
  }

  wait 5;
  thread run_objective(scripts\engine\utility::random(var1).ref);
}

function initobjectivehud() {}

function setlevelobjectivetext(var0) {}

function clearobjectivetext() {}

function setobjectivetextforplayer(var0, var1) {}

function clearobjectivetextforplayer(var0) {}

function blankobjectivefunc() {
  level endon("new_objective_chosen");
}

function setomnvarbasedonindex(var0) {
  foreach(var2 in level.objectivestabledata) {
    if(int(var0) == int(var2.index)) {
      setomnvar("cp_objective_index", var0);
      return;
    }
  }

  setomnvar("cp_objective_index", 0);
}

function setobjectivetocompleteanddroploot(var0, var1) {
  var0.completedobjective = 1;
}

function create_objective_waypoint(var0, var1, var2, var3, var4) {
  if(!isDefined(var4)) {
    var4 = 1;
  }

  var5 = undefined;

  if(var1 != "all") {
    var5 = newteamhudelem(var1);
  } else {
    var5 = newhudelem();
  }

  var5.id = level.waypoint_index;
  var5.x = var0[0];
  var5.y = var0[1];
  var5.z = var0[2];
  var5.team = var1;
  var5.isflashing = 0;
  var5.isshown = 1;
  level.waypoint_index++;

  if(isDefined(var2)) {
    var5 setshader(var2, level.waypoint_size, level.waypoint_size);
    var5 setwaypoint(1, 1);
  }

  if(isDefined(var3)) {
    var5.alpha = var3;
  } else {
    var5.alpha = level.waypoint_alpha;
  }

  var5.basealpha = var5.alpha;
  return var5;
}

function destroy_objective_waypoint(var0, var1, var2) {
  if(isDefined(var1)) {
    level thread[[var1]](var0);
  }

  if(isDefined(var1) && isDefined(var2)) {
    var0 scripts\engine\utility::ref_143b9(var2, "destroy_objective_icon");
  } else if(isDefined(var1)) {
    var0 waittill("destroy_objective_icon");
  } else if(isDefined(var2)) {
    wait var2;
  }

  var0 destroy();
}

function give_objective_skillpoints() {
  foreach(var1 in level.players) {
    var1 scripts\cp\classes\cp_class_progression::give_skill_points(1);
  }
}

function default_init_objective(var0, var1) {
  if(isDefined(var0.nofailontimeout) && var0.nofailontimeout > 0) {
    var2 = 1;
  } else {
    var2 = 0;
  }

  if(!istrue(var1.client_hint)) {
    var1.client_hint = 0;
  }

  if(!istrue(var1.skipdescription)) {
    setomnvar("cp_objective_desc_index", 1);

    if(isDefined(var1.timer1) && isDefined(var1.timer2) && isDefined(var1.timer3)) {
      level thread scripts\cp\utility::objective_update(var1.objname, var1.timer1, var1.timer2, var1.timer3, var2);
    } else if(isDefined(var1.timer1) && isDefined(var1.timer2)) {
      level thread scripts\cp\utility::objective_update(var1.objname, var1.timer1, var1.timer2, undefined, var2);
    } else if(isDefined(var1.timer1)) {
      level thread scripts\cp\utility::objective_update(var1.objname, var1.timer1, undefined, undefined, var2);
    } else {
      level thread scripts\cp\utility::objective_update(var1.objname);
    }
  }

  var3 = scripts\engine\utility::ter_op(isDefined(var1.objname), var1.objname, undefined);
  var4 = scripts\engine\utility::ter_op(isDefined(var1.iconpos), var1.iconpos, undefined);
  var5 = scripts\engine\utility::ter_op(isDefined(var1.activatestring), var1.activatestring, undefined);
  var6 = scripts\engine\utility::ter_op(isDefined(var1.label), var1.label, undefined);
  var7 = scripts\engine\utility::ter_op(isDefined(var1.objicon), var1.objicon, undefined);
  var8 = scripts\engine\utility::ter_op(isDefined(var1.questtype), var1.questtype, undefined);
  var9 = "icon_regular";

  if(isDefined(var5) && var5 == "" || istrue(var1.skipdescription)) {
    var5 = undefined;
  }

  if(isDefined(var1.iconpos) && isDefined(var1.objicon)) {
    var10 = "current";
  } else {
    var10 = "active";
  }

  var10 = "current";
  level.initlethalmaxoffsetmap = var2.objname;

  if(isarray(var5)) {
    var2.objectiveindexes = [];
    add_objective(var4, var10, undefined, var6, var7, var8, var10, var9, var2, var2);

    foreach(var12 in var5) {
      objective_setlocation(var2.objectiveindex, var13, var12);
      var2.objectiveindexes[var2.objectiveindexes.size] = var13;
    }

    return;
  }

  add_objective(var4, var10, var5, var6, var7, var8, var10, var9, var2, var2);
}

function defaultcompleteobjective(var0, var1) {
  thread scripts\cp\coop_personal_ents::update_special_mode_for_all_players();

  if(isDefined(var0.hudicon)) {
    destroy_objective_waypoint(var0.hudicon);
  }

  if(isDefined(var0.headiconents)) {
    foreach(var3 in var0.headiconents) {
      removeheadicon(var0, var3);
    }

    var0.headiconents = undefined;
  }

  if(isDefined(var0.objname)) {
    freeworldid(var0.objname);
    var5 = var0.objectiveindex;

    if(isDefined(var0.complete_state)) {
      if(isDefined(var5)) {
        objective_state(var5, var0.complete_state);
      }
    } else {
      if(isDefined(var5)) {
        objective_state(var5, "done");
      }

      if(isDefined(var0.objectiveindexes)) {
        foreach(var7 in var0.objectiveindexes) {
          objective_unsetlocation(var0.objectiveindex, var7);
        }
      }
    }

    if(get_objective_type(var0.objname) == "global") {
      delay_delete_objective(var0.objectiveindex, 0.15);
      var0 notify(var0.objname + "_completed");
      level notify("debug_beat_" + var0.objname + "_objective");
    }

    if(isDefined(var0.currentteam)) {
      var9 = var0.currentteam;

      if(does_team_have_active_chain(var9)) {
        if(!isDefined(var0.nextsteps) || var0.nextsteps.size <= 0) {
          add_to_list_of_current_chain_idx(var0, var9);
          delete_all_team_chain_objectives(var9);
        } else {
          add_to_list_of_current_chain_idx(var0, var9);
        }
      } else if(isDefined(var0.nextsteps) && var0.nextsteps.size > 0) {
        add_to_list_of_current_chain_idx(var0, var9);
      } else {
        objective_delete(var5);
      }

      var0.currentteam = undefined;
    }

    lua_objective_complete(var0.ref);
  }

  if(istrue(var1) || istrue(var0.checkpointrevive)) {
    checkpoint_revive();
  }

  if(istrue(var1) || istrue(var0.checkpointrevive)) {
    give_objective_skillpoints();
  }

  foreach(var11 in level.completedobjectives) {}

  level.completedobjectives[level.completedobjectives.size] = var0;
}

function does_team_have_active_chain(var0) {
  return isDefined(level.currentteamobjectivechain) && isDefined(level.currentteamobjectivechain[var0]) && level.currentteamobjectivechain[var0].size > 0;
}

function add_to_list_of_current_chain_idx(var0, var1) {
  if(!isDefined(var1)) {
    return;
  }

  if(!isDefined(level.currentteamobjectivechain)) {
    level.currentteamobjectivechain = [];
  }

  if(!isDefined(level.currentteamobjectivechain[var1])) {
    level.currentteamobjectivechain[var1] = [];
  }

  level.currentteamobjectivechain[var1][level.currentteamobjectivechain[var1].size] = var0;
}

function delete_all_team_chain_objectives(var0) {
  if(!isDefined(level.currentteamobjectivechain) || !isDefined(level.currentteamobjectivechain[var0])) {
    return;
  }

  foreach(var2 in level.currentteamobjectivechain[var0]) {
    objective_delete(var2.objectiveindex);
  }
}

function delay_delete_objective(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var1)) {
    wait var1;
  }

  objective_delete(var0);
}

function checkpoint_revive() {
  foreach(var1 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var1)) {
      var1 scripts\cp\cp_laststand::instant_revive(var1);

      if(isDefined(var1.dogtag)) {
        var1.dogtag delete();
      }
    }
  }
}

function add_objective(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  var10 = 20;

  if(var7 == "global") {
    var10 = 15;
  }

  var11 = requestworldid(var0, var10);
  _add_objective(var11, var1, var2, var5, var6);

  if(isDefined(var7) && var7 != "primary" && isDefined(var2)) {
    if(var7 != "global") {
      thread watchfornearbyplayers(level, var11, var2);
    }
  }

  objective_set_play_intro(var11, 1);

  if(isDefined(var3)) {
    if(isDefined(level.display_objective_text_func)) {
      level thread[[level.display_objective_text_func]](var0, var3, var8.currentteam, 5);
    }

    objective_setdescription(var11, var3);
  }

  if(isDefined(var4)) {
    objective_setlabel(var11, var4);
  }

  objective_unpinforteam(var11, "allies");
  objective_setshowdistance(var11, 1);
  objective_setbackground(var11, 0);
  objective_setshowoncompass(var11, 1);
  objective_setpulsate(var11, 1);

  if(isDefined(var8.disablefade)) {
    objective_setfadedisabled(var11, var8.disablefade);
  }

  if(!isDefined(var2)) {
    objective_state(var11, "invisible");
  }

  var8.objiconid = var11;
  var8.iconname = var8.objname;
  var8.objectiveindex = var11;

  if(istrue(var8.showobjprogress)) {
    objective_show_progress(var8.objectiveindex, 1);

    if(get_objective_type(var8.objname) == "global") {
      var8.showobjprogress = var8.showobjprogressbackup;
    }

    if(var8.showobjprogress > 1) {
      objective_set_progress(var8.objectiveindex, 0);
      thread startprogresstimer(var8, var8);
      return;
    }

    if(var8.showobjprogress < -1) {
      objective_set_progress(var8.objectiveindex, 1);
      thread startprogresstimer(var8, var8, var8.showobjprogress * -1);
      return;
    }

    return;
  }
}

function startprogresstimer(var0, var1, var2) {
  level endon("debug_beat_" + var0.objname + "_objective");
  var0 endon(var0.objname + "_completed");
  var0 endon("stop_timer");

  if(var1 > 3) {
    var1 -= 3;
    wait 3;
  }

  var3 = 0;
  var4 = 1;

  if(istrue(var2)) {
    var3 = 1;
    var4 = 0;
  }

  var5 = 0;
  var6 = 0.1;
  var7 = gettime() + var1 * 1000;
  objective_set_progress(var0.objectiveindex, var3);

  while(gettime() < var7) {
    if(!istrue(var2)) {
      objective_set_progress(var0.objectiveindex, var5 / var1);
    } else {
      objective_set_progress(var0.objectiveindex, 1 - var5 / var1);
    }

    if(!isDefined(var0.pause_timer)) {
      var5 += var6;
    } else {
      var7 += 1000 * var6;
    }

    if(var5 <= 0) {
      break;
    }

    wait var6;
  }

  objective_set_progress(var0.objectiveindex, var4);
}

function set_nearby_console(var0) {
  var0.nearby_players[var0.nearby_players.size] = self;
}

function show_to_players_that_are_near(var0, var1, var2, var3) {
  level endon("game_ended");
  var2 endon("objective_completed");
  var2 endon("stop_watching");
  var4 = 0;
  minimap_objective_playermask_hidefromall(var0);
  minimap_objective_pin_global(var0, 0);

  if(isDefined(var3)) {
    var5 = var3 * var3;
  } else {
    var5 = 1048576;
  }

  var3.showtoall = 0;

  for(;;) {
    if(istrue(var3.showtoall)) {
      if(!var5) {
        var5 = 1;
        minimap_objective_playermask_showtoall(var1);
      }
    } else if(istrue(var3.hidefromall)) {
      if(var5) {
        var5 = 0;
        minimap_objective_playermask_hidefromall(var1);
      }
    } else {
      minimap_objective_pin_global(var1, 0);
      var3.nearby_players = [];
      var6 = scripts\engine\utility::get_array_of_closest(var2, level.players, undefined, undefined, var5);
      scripts\engine\utility::array_call(var6, &set_nearby_console, var3);
      var5 = 0;

      foreach(var8 in level.players) {
        if(istrue(var8.disable_objective_update)) {
          objective_set_play_outro(var1, 0);
          minimap_objective_playermask_hidefrom(var1, var8);
          continue;
        }

        if(var8 scripts\cp\utility::is_valid_player() && distancesquared(var8.origin, var2) <= var5) {
          objective_set_play_intro(var1, 0);
          minimap_objective_playermask_showto(var1, var8);
          continue;
        }

        objective_set_play_outro(var1, 0);
        minimap_objective_playermask_hidefrom(var1, var8);
      }
    }

    var3 scripts\engine\utility::ref_143b9(0.5, "update_nearby_thread");
  }
}

function watchfornearbyplayers(var0, var1, var2, var3) {
  level endon("game_ended");
  var2 endon("objective_completed");
  var2 endon("stop_watching");
  var4 = 0;
  minimap_objective_playermask_hidefromall(var0);

  if(isDefined(var3)) {
    var5 = var3 * var3;
  } else {
    var5 = 1056784;
  }

  for(;;) {
    while(!istrue(var3.showtoall) && !scripts\cp\utility::any_player_nearby(var2, var5)) {
      if(var5) {
        minimap_objective_playermask_hidefromall(var1);
        var5 = 0;
      }

      var3 scripts\engine\utility::ref_143b9(0.5, "update_nearby_thread");
    }

    if(!var5) {
      var5 = 1;
      minimap_objective_playermask_showtoall(var1);
    }

    var3 scripts\engine\utility::ref_143b9(0.5, "update_nearby_thread");
  }
}

function unset_all_locations(var0) {
  for(var1 = 0; var1 <= 7; var1++) {
    objective_unsetlocation(var0, var1);
  }
}

function initobjectiveicons() {
  var0 = spawnStruct();
  var0.active = [];
  var0.reclaimed = [];
  var0.index = 0;
  level.minimapobjidpool = var0;
  var1 = spawnStruct();
  var1.active = [];
  var1.reclaimed = [];
  var1.index = 0;
  level.worldobjidpool = var1;
}

function requestminimapid(var0) {
  var1 = getnextminimapid(var0);

  if(var1 == -1) {
    return -1;
  }

  var2 = spawnStruct();
  var2.priority = var0;
  var2.requesttime = gettime();
  var2.objid = var1;
  level.minimapobjidpool.active[var1] = var2;
  return var1;
}

function removebestminimapid(var0) {
  var1 = [];

  foreach(var3 in level.minimapobjidpool.active) {
    if(var3.priority <= var0) {
      var1 = var3;
    }
  }

  scripts\engine\utility::array_sort_with_func(var1, &comparepriorityandtime);
  return returnminimapid(var1[0].objid);
}

function comparepriorityandtime(var0, var1) {
  if(var0.priority == var1.priority) {
    return (var0.requesttime < var1.requesttime);
  }

  return var0.priority < var1.priority;
}

function getnextminimapid(var0) {
  if(level.minimapobjidpool.index == 32) {
    if(!removebestminimapid(var0)) {
      return -1;
    }
  }

  if(!level.minimapobjidpool.reclaimed.size) {
    if(level.minimapobjidpool.index == 32) {
      return -1;
    } else {
      var1 = level.minimapobjidpool.index;
      level.minimapobjidpool.index++;
    }
  } else {
    var1 = level.minimapobjidpool.reclaimed[level.minimapobjidpool.reclaimed.size - 1];
    level.minimapobjidpool.reclaimed[level.minimapobjidpool.reclaimed.size - 1] = undefined;
  }

  return var1;
}

function returnminimapid(var0) {
  if(!isDefined(var0) || var0 == -1) {
    return false;
  }

  for(var1 = 0; var1 < level.minimapobjidpool.reclaimed.size; var1++) {
    if(var0 == level.minimapobjidpool.reclaimed[var1]) {
      return false;
    }
  }

  level.minimapobjidpool.active[var0] = undefined;
  objective_delete(var0);
  level.minimapobjidpool.reclaimed[level.minimapobjidpool.reclaimed.size] = var0;
  return true;
}

function requestworldid(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 10;
  }

  var2 = getnextworldid(var1);

  if(var2 == -1) {
    return undefined;
  }

  var3 = spawnStruct();
  var3.requesttime = gettime();
  var3.objid = var2;
  var3.identifier = var0;
  level.worldobjidpool.active[var2] = var3;
  level notify("worldObjIDPool_requested", var0, var2);
  return var2;
}

function freeworldid(var0) {
  if(!isDefined(var0)) {
    return;
  }

  foreach(var2 in level.worldobjidpool.active) {
    if(var2.identifier == var0) {
      unset_all_locations(var2.objid);
      internal_reclaimworldid(var2.objid);
    }
  }
}

function freeworldidbyobjid(var0) {
  if(!isDefined(var0)) {
    return;
  }

  foreach(var2 in level.worldobjidpool.active) {
    if(var2.objid == var0) {
      unset_all_locations(var2.objid);
      internal_reclaimworldid(var2.objid);
    }
  }
}

function removebestworldid(var0) {
  var1 = [];

  foreach(var3 in level.worldobjidpool.active) {
    if(var3.priority < var0) {
      var1 = var3;
    }
  }

  scripts\engine\utility::array_sort_with_func(var1, &comparepriorityandtime);
  return internal_reclaimworldid(var1[0].objid);
}

function getnextworldid(var0) {
  if(level.worldobjidpool.index == 32) {
    if(!removebestworldid(var0)) {
      return -1;
    }
  }

  if(level.worldobjidpool.reclaimed.size <= 0) {
    if(level.worldobjidpool.index == 32) {
      return -1;
    } else {
      var1 = level.worldobjidpool.index;
      level.worldobjidpool.index++;
    }
  } else {
    var1 = level.worldobjidpool.reclaimed[level.worldobjidpool.reclaimed.size - 1];
    level.worldobjidpool.reclaimed[level.worldobjidpool.reclaimed.size - 1] = undefined;
  }

  return var1;
}

function internal_reclaimworldid(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  var1 = var0;

  for(var2 = 0; var2 < level.worldobjidpool.reclaimed.size; var2++) {
    if(var1 == level.worldobjidpool.reclaimed[var2]) {
      return false;
    }
  }

  objective_delete(var1);
  level notify("objective_id_reclaimed_" + var1);
  level.worldobjidpool.active[var1] = undefined;
  level.worldobjidpool.reclaimed[level.worldobjidpool.reclaimed.size] = var1;
  return true;
}

function is_objective_active(var0) {
  foreach(var2 in level.activequests) {
    if(var2.ref == var0) {
      return true;
    }
  }

  return false;
}

function _add_objective(var0, var1, var2, var3, var4) {
  objective_delete(var0);

  if(isDefined(var1)) {
    objective_state(var0, var1);
  }

  if(isDefined(var2)) {
    objective_position(var0, var2);
  }

  if(isDefined(var3) && var3 != "") {
    objective_icon(var0, var3);
  }

  if(isDefined(var4)) {
    objective_setminimapiconsize(var0, var4);
    return;
  }
}

function minimap_objective_add(var0, var1, var2, var3, var4) {
  if(var0 == -1) {
    return;
  }

  _add_objective(var0, var1, var2, var3, var4);
}

function minimap_objective_state(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_state(var0, var1);
}

function minimap_objective_position(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_position(var0, var1);
}

function minimap_objective_icon(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_icon(var0, var1);
}

function minimap_objective_setbackground(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setbackground(var0, var1);
}

function minimap_objective_onentity(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_onentity(var0, var1);
}

function minimap_objective_onentitywithrotation(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_onentity(var0, var1);
  objective_setrotateonminimap(var0, 1);
}

function minimap_objective_setzoffset(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setzoffset(var0, var1);
}

function minimap_objective_player(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_removeallfrommask(var0);
  objective_addclienttomask(var0, var1);
  objective_showtoplayersinmask(var0);
}

function minimap_objective_team(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_removeallfrommask(var0);
  objective_addteamtomask(var0, var1);
  objective_showtoplayersinmask(var0);
}

function minimap_objective_playermask_hidefromall(var0) {
  if(var0 == -1) {
    return;
  }

  objective_addalltomask(var0);
  objective_hidefromplayersinmask(var0);
}

function minimap_objective_playermask_hidefrom(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_showtoplayersinmask(var0);
  objective_removeclientfrommask(var0, var1);
}

function minimap_objective_playermask_showto(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_showtoplayersinmask(var0);
  objective_addclienttomask(var0, var1);
}

function minimap_objective_playermask_showtoall(var0) {
  if(var0 == -1) {
    return;
  }

  objective_addalltomask(var0);
  objective_showtoplayersinmask(var0);
}

function minimap_objective_playerteam(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_removeallfrommask(var0);

  if(level.teambased) {
    objective_addteamtomask(var0, var1.team);
  } else {
    objective_addclienttomask(var0, var1);
  }

  objective_showtoplayersinmask(var0);
}

function minimap_objective_playerenemyteam(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_removeallfrommask(var0);

  if(level.teambased) {
    objective_addteamtomask(var0, var1.team);
  } else {
    objective_addclienttomask(var0, var1);
  }

  objective_hidefromplayersinmask(var0);
}

function minimap_objective_team_addtomask(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_addteamtomask(var0, var1);
  objective_showtoplayersinmask(var0);
}

function minimap_objective_team_removefrommask(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_removeteamfrommask(var0, var1);
  objective_showtoplayersinmask(var0);
}

function minimap_objective_pin_global(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setpinned(var0, var1);
}

function minimap_objective_pin_team(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_pinforteam(var0, var1);
}

function minimap_objective_unpin_team(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_unpinforteam(var0, var1);
}

function minimap_objective_pin_player(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_pinforclient(var0, var1);
}

function minimap_objective_unpin_player(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_unpinforclient(var0, var1);
}

function ref_11f83(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_sethot(var0, var1);
}

function objective_show_progress(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setshowprogress(var0, var1);
}

function objective_show_team_progress(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_showprogressforteam(var0, var1);
}

function objective_hide_team_progress(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_hideprogressforteam(var0, var1);
}

function objective_show_player_progress(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_showprogressforclient(var0, var1);
}

function objective_hide_player_progress(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_hideprogressforclient(var0, var1);
}

function objective_set_progress(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setprogress(var0, var1);
}

function objective_set_progress_team(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setprogressteam(var0, var1);
}

function objective_set_progress_client(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setprogressclient(var0, var1);
}

function objective_set_play_intro(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setplayintro(var0, var1);
}

function objective_set_play_outro(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setplayoutro(var0, var1);
}

function objective_set_pulsate(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setpulsate(var0, var1);
}

function update_objective(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isDefined(level.objectivestabledata[var0])) {
    return;
  }

  var10 = level.objectivestabledata[var0];
  var11 = level.objectivestabledata[var0].objectiveindex;

  if(isDefined(var8) && var8) {
    objective_delete(var11);
  }

  if(isDefined(var9)) {
    objective_setplayoutro(var11, var9);
  }

  if(isDefined(var8)) {
    objective_setplayintro(var11, var8);
  }

  if(isDefined(var1)) {
    objective_state(var11, var1);
  }

  if(isDefined(var2)) {
    objective_position(var11, var2);
  }

  if(isDefined(var3)) {
    objective_setdescription(var11, var3);
  }

  if(isDefined(var5)) {
    if(var5 > 8) {
      var5 = 8;
    }

    if(var5 < 1) {
      var5 = 1;
    }

    setomnvar("cp_objective_desc_index", var5);
  }

  if(isDefined(var4)) {
    objective_setlabel(var11, var4);
  }

  if(isDefined(var6)) {
    objective_icon(var11, var6);
  }

  if(isDefined(var7)) {
    objective_setbackground(var11, var7);
  }

  setomnvarbasedonindex(0);
  wait 0.5;
  setomnvarbasedonindex(var10.index);
}

function getobjectiveforfloor(var0) {
  var1 = undefined;

  if(isDefined(level.mapbasedobjectiverules)) {
    var1 = [[level.mapbasedobjectiverules]](level.floorobjectives, var0);
  } else {
    var1 = scripts\engine\utility::random(level.floorobjectives);
  }

  thread run_objective(var1.ref, var1.questtype);
}

function get_active_objectives() {
  return level.activequests;
}

function get_objective_type(var0) {
  if(!isDefined(level.objectivestabledata)) {
    return;
  }

  foreach(var2 in level.objectivestabledata) {
    if(var2.ref == var0) {
      if(isDefined(var2.questtype)) {
        return var2.questtype;
      }
    }
  }

  return undefined;
}

function create_breadcrumb_for_team(var0, var1, var2, var3) {
  var4 = scripts\cp\utility::getplayersinteam(var0);
  var5 = [];

  foreach(var7 in var4) {
    var5 = create_breadcrumb_for_player(var7, var1, var2, var3);
    wait 0.5;
  }

  return var5;
}

function create_breadcrumb_for_player(var0, var1, var2, var3) {
  if(!isDefined(level.activebreadcrumbs)) {
    level.activebreadcrumbs = [];
  }

  var4 = spawnStruct();
  var4.stepstructs = [];
  var4.ref_138a6 = [];
  var5 = scripts\engine\utility::getStructArray(var1, "script_noteworthy");

  if(var5.size <= 0) {
    return undefined;
  }

  var5 = scripts\engine\utility::array_sort_with_func(var5, &compare_breadcrumb_order);

  foreach(var7 in var5) {
    var8 = var4.stepstructs.size;
    var4.stepstructs[var8] = var7.origin;

    if(isDefined(var7.script_radius)) {
      var4.ref_138a6[var8] = squared(var7.script_radius);
    }
  }

  var4.id = requestworldid("breadcrumb_for_" + var0.name, 2);

  if(isDefined(var3) && var3 != "") {
    var4.iconname = var3;
  } else {
    var4.iconname = "icon_waypoint_objective_general";
  }

  if(isDefined(var2)) {
    var4.label = var2;
  }

  var4.player = var0;
  var8 = 0;

  if(isDefined(level.disable_hvt_pickup)) {
    var8 = [[level.disable_hvt_pickup]](var4);
  }

  update_breadcrumb_for_player(var4, var8);
  thread watchforplayernearbcrumb(var4);
  level.activebreadcrumbs[level.activebreadcrumbs.size] = var4;
  return var4;
}

function compare_breadcrumb_order(var0, var1) {
  return int(var0.targetname) < int(var1.targetname);
}

function watchforplayernearbcrumb(var0) {
  level endon("game_ended");
  self endon("breadcrumb_finished");
  var1 = self.player;
  var2 = 0;

  if(isDefined(var0)) {
    var2 = var0;
  }

  var3 = self.stepstructs.size;
  var4 = 90000;

  while(var2 < var3 && isPlayer(self.player)) {
    if(distancesquared(var1.origin, self.stepstructs[var2]) <= printcodechosen(self, var2)) {
      var2++;

      if(var2 >= var3) {
        level notify("finished_last_breadcrumb", var1);
        delete_breadcrumb(level, self);
      } else {
        update_breadcrumb_for_player(self, var2);
      }

      waitframe();
      continue;
    } else if(distancesquared(var1.origin, self.stepstructs[var3 - 1]) <= printcodechosen(self, var3 - 1)) {
      level notify("finished_last_breadcrumb", var1);
      delete_breadcrumb(level, self);
    }

    wait 0.1;
  }
}

function printcodechosen(var0, var1) {
  if(isDefined(var0.ref_138a6[var1])) {
    return var0.ref_138a6[var1];
  }

  return 90000;
}

function update_breadcrumb_for_player(var0, var1) {
  if(!isPlayer(var0.player) || !isDefined(var0) || !isDefined(var0.stepstructs[var1])) {
    return 0;
  }

  objective_delete(var0.id);
  waitframe();

  if(isDefined(var0.label)) {
    objective_setlabel(var0.id, var0.label);
  }

  objective_position(var0.id, var0.stepstructs[var1]);
  objective_icon(var0.id, var0.iconname);
  objective_setbackground(var0.id, 1);

  foreach(var3 in level.players) {
    if(var3 != var0.player) {
      objective_removeclientfrommask(var0.id, var3);
      continue;
    }

    objective_addclienttomask(var0.id, var3);
  }

  objective_state(var0.id, "current");
}

function delete_breadcrumb(var0) {
  objective_delete(var0.id);
  internal_reclaimworldid(var0.id);
  var0 notify("breadcrumb_finished");

  if(scripts\engine\utility::array_contains(level.activebreadcrumbs, var0)) {
    level.activebreadcrumbs = scripts\engine\utility::array_remove(level.activebreadcrumbs, var0);
    return;
  }
}

function delete_breadcrumb_array(var0) {
  foreach(var2 in var0) {
    delete_breadcrumb(var2);
  }
}

function ref_11f80(var0) {
  objective_state(var0, "current");
  objective_setshowoncompass(var0, 1);
  objective_setminimapiconsize(var0, "icon_regular");
  level notify("objective_minimapUpdate");
}

function screenent_c(var0) {
  if(!isDefined(var0)) {
    var0 = "minor_objective";
  }

  foreach(var2 in level.players) {
    var2 thread scripts\cp\drone\emp_drone::giverankxp(var0, scripts\cp\drone\emp_drone::getscoreinfovalue(var0));
  }

  level notify("give_objective_xp_to_all_players", var0);
}

function start_mode_after_playerspawn() {
  foreach(var1 in level.players) {
    if(isDefined(var1.pers["periodic_xp_participation"])) {
      var1.pers["periodic_xp_participation"]++;
      continue;
    }

    var1.pers["periodic_xp_participation"] = 1;
  }
}

function ref_12868(var0) {
  var1 = getobjectivestructfromref(var0);

  if(!isDefined(var1)) {
    return;
  }

  jumpiffalse(isDefined(level.objectivestabledata) && isDefined(level.objectivestabledata[var1.objname])) LOC_000000ca;
  var2 = level.objectivestabledata[var1.objname].index;
  var3 = level.objectivestabledata[var1.objname].pathexit;

  if(isDefined(var3) && var3 != "") {
    foreach(var5 in level.players) {
      var5 setclientomnvar("ui_cp_mission_fail_index", var2);
    }

    return;
  }

  foreach(var5 in level.players) {
    var5 setclientomnvar("ui_cp_mission_fail_index", 0);
  }

  return;
}

function ref_12ddb() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  scripts\engine\utility::flag_wait("objective_table_parsed");
  scripts\engine\utility::flag_wait("objectives_registered");
  var0 = getDvar(level.script + "_start_obj", "");

  if(isDefined(var0) && var0 != "") {
    if(isDefined(level.objectivestabledata[var0])) {
      var1 = level.objectivestabledata[var0];

      if(isDefined(var1.ondebugstartfunc)) {
        [[var1.ondebugstartfunc]](var1);
      }

      thread run_objective(level, var1.objname);
      return;
    }

    return;
  }
}