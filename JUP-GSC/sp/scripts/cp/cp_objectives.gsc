/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_objectives.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp\coop_personal_ents;
#using scripts\cp\cp_analytics;
#using scripts\cp\cp_checkpoint;
#using scripts\cp\cp_objectives_events;
#using scripts\cp\laststand;
#using scripts\cp\persistence;
#using scripts\cp\rank;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace cp_objectives;

function objectives_init() {
  flag_init("objective_table_parsed");

  level thread debug_activation(@ "hash_e6d8ad34aadb296", &function_2e0726d51b65646);

  flag_init("objectives_registered");
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

  if(flag_exist("strike_init_done")) {
    flag_wait("strike_init_done");
  }

  if(isDefined(level.objectivesfunc)) {
    [[level.objectivesfunc]]();
  } else {
    parseobjectivestable();
  }

  if(isDefined(level.objectiveregistration)) {
    [[level.objectiveregistration]]();
  }

  initobjectiveicons();
  flag_set("objectives_registered");
  level thread objectivedebug();
}

function setupobjectiveloops() {
  if(!should_run_objectives()) {
    return;
  }

  level thread runmainobjective();
  level thread runsecondaryobjectives();
  level thread runobjectiveloop();
}

function runmainobjective() {
  level endon("game_ended");
  flag_wait("objectives_registered");
  wait 2;
  var_eaf8894a5f8595e8 = random(level.primaryobjectives);
  level thread run_objective(var_eaf8894a5f8595e8, "primary");
}

function runsecondaryobjectives() {
  level endon("game_ended");
  flag_wait("objectives_registered");
  wait 2;

  if(!isDefined(level.secondaryobjectives) || !isDefined(level.num_secondary_objectives_active) || !level.secondaryobjectives.size) {
    return;
  }

  objectives = array_randomize_objects(level.secondaryobjectives);
  goal = int(clamp(objectives.size, 0, level.num_secondary_objectives_active));

  for(active = 0; true; active--) {
    while(active < goal) {
      thread run_objective(objectives[active], "secondary");
      active++;
    }

    level waittill("secondary_objective_completed");
  }
}

function runobjectiveloop() {
  level endon("game_ended");
  flag_wait("objectives_registered");
  wait 2;

  if(!level.infiniteobjectives.size) {
    return;
  }

  objectives = array_randomize_objects(level.infiniteobjectives);
  goal = int(clamp(objectives.size, 0, level.num_side_objectives_active));

  for(active = 0; true; active--) {
    while(active < goal) {
      thread run_objective(objectives[active], "infinite");
      active++;
    }

    level waittill("infinite_objective_completed");
  }
}

function should_run_objectives() {
  return true;
}

function objectivedebug() {}

function parseobjectivestable(table) {
  if(flag_exist("strike_init_done")) {
    flag_wait("strike_init_done");
  }

  if(!isDefined(table)) {
    table = "cp/cp_default_objectives.csv";
  }

  if(isDefined(level.objectivesmatrixtable)) {
    matrixtable = level.objectivesmatrixtable;
  } else {
    matrixtable = undefined;
  }

  for(row = 0; true; row++) {
    index = tablelookupbyrow(table, row, 0);

    if(index == "") {
      break;
    }

    objstruct = spawnStruct();
    objstruct.index = int(index);
    objstruct.ref = tablelookup(table, 0, index, 1);
    objstruct.activatestring = tablelookup(table, 0, index, 2);
    objstruct.label = tablelookup(table, 0, index, 3);
    objstruct.questtype = tablelookup(table, 0, index, 5);
    objstruct.objicon = tablelookup(table, 0, index, 6);
    objstruct.showobjprogress = int(tablelookup(table, 0, index, 8));
    objstruct.timer1 = int(tablelookup(table, 0, index, 9));
    objstruct.timer2 = int(tablelookup(table, 0, index, 10));
    objstruct.timer3 = int(tablelookup(table, 0, index, 11));
    objstruct.bigtimer = int(tablelookup(table, 0, index, 25));
    objstruct.failedtext = tablelookup(table, 0, index, 24);
    objstruct.variable1 = int(tablelookup(table, 0, index, 12));
    objstruct.variable2 = int(tablelookup(table, 0, index, 13));
    objstruct.variable3 = int(tablelookup(table, 0, index, 14));
    objstruct.skipdescription = int(tablelookup(table, 0, index, 15));
    objstruct.points = int(tablelookup(table, 0, index, 16));
    objstruct.excludedfromrandompool = int(tablelookup(table, 0, index, 17));
    objstruct.nofailontimeout = int(tablelookup(table, 0, index, 18));
    objstruct.csdependency = tablelookup(table, 0, index, 26);
    objstruct.var_24852c22989ccfc5 = tablelookup(table, 0, index, 28);

    if(isDefined(objstruct.csdependency) && objstruct.csdependency == "") {
      objstruct.csdependency = undefined;
    }

    objstruct.iconposref = tablelookup(table, 0, index, 7);
    objstruct.disablefade = int(tablelookup(table, 0, index, 27)) >= 1;
    objstruct.eventflag = int(tablelookup(table, 0, index, 31));
    objstruct.objectivelocations = [];

    if(isDefined(objstruct.excludedfromrandompool) && objstruct.excludedfromrandompool >= 1) {
      objstruct.excludedfromrandompool = 1;
    } else {
      objstruct.excludedfromrandompool = 0;
    }

    switch (objstruct.questtype) {
      case #"hash_325cb2e66f67d5b9":
        level.primaryobjectives[level.primaryobjectives.size] = objstruct.ref;
        break;
      case #"hash_511d3c24fcedcdb1":
        level.secondaryobjectives[level.secondaryobjectives.size] = objstruct.ref;
        break;
      case #"hash_36a0a6f7dc65d4ed":
        level.infiniteobjectives[level.infiniteobjectives.size] = objstruct.ref;
        break;
      case #"hash_3e7681464ca7b9fd":
        level.floorobjectives[level.floorobjectives.size] = objstruct;
        break;
    }

    if(isDefined(matrixtable)) {
      objstruct.nextsteps = [];
      var_1ec1ca65b5506dcc = 0;

      for(var_29c240d3347ba1ae = 1; true; var_29c240d3347ba1ae++) {
        var_4af635111d18aa35 = tablelookup(matrixtable, var_1ec1ca65b5506dcc, objstruct.ref, var_29c240d3347ba1ae);

        if(var_4af635111d18aa35 == "") {
          break;
        }

        objstruct.nextsteps[objstruct.nextsteps.size] = var_4af635111d18aa35;
      }
    }

    level.objectivestabledata[objstruct.ref] = objstruct;
  }

  flag_set("objective_table_parsed");
}

function function_b46922280aa2802c(objectivename, objectivedesc, questtype, var_f8d1e1a3eeb7be32, objectiveicon, points, var_937a34cbb9782a22, var_46ff8e3cf753908e, var_53b4259e1f971282) {
  if(isDefined(level.objectivestabledata[objectivename])) {
    println("<dev string:x1c>" + objectivename + "<dev string:x31>");
    return level.objectivestabledata[objectivename];
  }

  index = level.objectivestabledata.size + 1;
  objstruct = spawnStruct();
  objstruct.index = index;
  objstruct.ref = objectivename;
  objstruct.activatestring = objectivedesc;
  objstruct.questtype = questtype;
  objstruct.var_24852c22989ccfc5 = ter_op(isDefined(var_f8d1e1a3eeb7be32), var_f8d1e1a3eeb7be32, "<dev string:xc6>");
  objstruct.objicon = ter_op(isDefined(objectiveicon), objectiveicon, "<dev string:xc6>");
  objstruct.points = ter_op(isDefined(points), points, 0);
  objstruct.excludedfromrandompool = ter_op(isDefined(var_937a34cbb9782a22), var_937a34cbb9782a22, 0);
  objstruct.nextsteps = ter_op(isDefined(var_46ff8e3cf753908e), var_46ff8e3cf753908e, []);
  objstruct.objicon = "<dev string:xc6>";
  objstruct.showobjprogress = 0;
  objstruct.bigtimer = 0;
  objstruct.failedtext = "<dev string:xc6>";
  objstruct.variable1 = 0;
  objstruct.variable2 = 0;
  objstruct.variable3 = 0;
  objstruct.skipdescription = 0;
  objstruct.nofailontimeout = 0;
  objstruct.iconposref = "<dev string:xc6>";
  objstruct.disablefade = 0;
  objstruct.objectivelocations = [];
  objstruct.csdependency = undefined;
  objstruct.eventflag = undefined;
  objstruct.timer1 = undefined;
  objstruct.timer2 = undefined;
  objstruct.timer3 = undefined;

  if(isDefined(var_53b4259e1f971282)) {
    objstruct.var_53b4259e1f971282 = string(var_53b4259e1f971282);
  } else {
    objstruct.var_53b4259e1f971282 = undefined;
  }

  objstruct.var_d1f50ecf0047c109 = undefined;

  switch (objstruct.questtype) {
    case #"hash_325cb2e66f67d5b9":
      level.primaryobjectives[level.primaryobjectives.size] = objstruct.ref;
      break;
    case #"hash_511d3c24fcedcdb1":
      level.secondaryobjectives[level.secondaryobjectives.size] = objstruct.ref;
      break;
    case #"hash_36a0a6f7dc65d4ed":
      level.infiniteobjectives[level.infiniteobjectives.size] = objstruct.ref;
      break;
    case #"hash_3e7681464ca7b9fd":
      level.floorobjectives[level.floorobjectives.size] = objstruct;
      break;
  }

  level.objectivestabledata[objstruct.ref] = objstruct;
  return objstruct;
}

function processiconposref(objstruct) {
  iconposref = objstruct.iconposref;

  if(!isDefined(iconposref)) {
    return;
  }

  var_846ca06c527078a = strtok(iconposref, ",");
  iconpos = undefined;

  if(var_846ca06c527078a.size == 3) {
    iconpos = (int(var_846ca06c527078a[0]), int(var_846ca06c527078a[1]), int(var_846ca06c527078a[2]));
  } else if(var_846ca06c527078a.size == 2) {
    if(getStructArray(var_846ca06c527078a[0], var_846ca06c527078a[1]).size > 0) {
      iconpos = getStructArray(var_846ca06c527078a[0], var_846ca06c527078a[1]);
    } else {
      iconpos = getEntArray(var_846ca06c527078a[0], var_846ca06c527078a[1]);
    }
  }

  if(isDefined(iconpos)) {
    if(isvector(iconpos)) {
      objstruct.iconpos = iconpos;
      objstruct.objectivelocations[objstruct.objectivelocations.size] = iconpos;
    } else if(isarray(iconpos)) {
      if(!isDefined(objstruct.iconpos)) {
        objstruct.iconpos = [];
      }

      foreach(item in iconpos) {
        objstruct.iconpos[objstruct.iconpos.size] = item.origin;
        objstruct.objectivelocations[objstruct.objectivelocations.size] = item.origin;
        objstruct.interactionstruct = item;
        item.objectivestruct = objstruct;
      }
    } else {
      objstruct.iconpos = iconpos.origin;
    }

    return;
  }

  objstruct.iconpos = iconpos;
}

function setobjectivelocations(objectivestruct, locarray) {
  if(isarray(locarray)) {
    objectivestruct.objectivelocations = locarray;
    return;
  }

  objectivestruct.objectivelocations = [];
  objectivestruct.objectivelocations[0] = locarray;
}

function getobjectivestructfromref(ref) {
  if(isDefined(level.objectivestabledata[ref])) {
    return level.objectivestabledata[ref];
  }

  return undefined;
}

function overridenextstep(objectivestruct, var_99d1679d9e88f1b2) {
  if(!isDefined(objectivestruct)) {
    return;
  }

  if(!isDefined(var_99d1679d9e88f1b2)) {
    objectivestruct.nextsteps = undefined;
    return;
  }

  objectivestruct.nextsteps = [];

  if(isarray(var_99d1679d9e88f1b2)) {
    objectivestruct.nextsteps = var_99d1679d9e88f1b2;
    return;
  }

  objectivestruct.nextsteps[0] = var_99d1679d9e88f1b2;
}

function addheadicon(ent, icon, offset) {
  assertex(isent(ent), "AddHeadIcon needs to have a unique ent provided");

  if(!isDefined(icon)) {
    icon = "icon_waypoint_objective_general";
  }

  if(!isDefined(offset)) {
    offset = 0;
  }

  ent.headiconid = thread scripts\cp\utility::ent_createheadicon(ent, offset, self.currentteam, icon);
  setheadicondrawthroughgeo(ent.headiconid, 1);
  setheadiconmaxdistance(ent.headiconid, 0);

  if(!isDefined(self.headiconents)) {
    self.headiconents = [];
  }

  self.headiconents[self.headiconents.size] = ent;
  return ent.headiconid;
}

function removeheadicon(ent) {
  thread scripts\cp\utility::ent_deleteheadicon(ent, ent.headiconid);
  self.headiconents = array_remove(self.headiconents, ent);
}

function registerobjective(objectivename, var_b87ab6d2c49ef466, var_b99e0b41050699ee, var_1fb210698b4e2543, ondebugbeatfunc, ondebugstartfunc, sstring, eventtype, var_70091b6fb2a35c96) {
  if(!isDefined(level.objectivestabledata[objectivename])) {
    assertmsg("<dev string:xe8>" + objectivename + "<dev string:x112>");
    return;
  }

  objectivestruct = level.objectivestabledata[objectivename];
  objectivestruct.init = var_b87ab6d2c49ef466;
  objectivestruct.startfunc = var_b99e0b41050699ee;
  objectivestruct.endfunc = var_1fb210698b4e2543;
  objectivestruct.ondebugbeatfunc = ondebugbeatfunc;
  objectivestruct.ondebugstartfunc = ondebugstartfunc;
  objectivestruct.eventtype = eventtype;
  objectivestruct.ref = objectivename;
  objectivestruct.string = sstring;
  objectivestruct.iscompletednaturally = 0;
  objectivestruct.isregistered = 1;
  objectivestruct.objname = objectivename;
  createdevguientryforobjective(objectivestruct);
}

function objective_update_internal(message_ref, time, yellow_time, red_time, nofailontimeout, object_count, objective_slot, big_timer) {
  level notify(message_ref + "_update_instance");
  level endon(message_ref + "_update_instance");
  level endon(message_ref + "_completed");
  level endon(message_ref + "_failed");
  level endon(message_ref + "objective_paused");
  var_6427da22a2830c8e = undefined;
  objective_slot = undefined;
  reset_bool = undefined;

  if(isDefined(level.objectives_table)) {
    event_flag = check_event_flag(message_ref);

    if(isDefined(level.objectivestabledata[message_ref])) {
      var_6427da22a2830c8e = level.objectivestabledata[message_ref].index;
    } else {
      var_6427da22a2830c8e = int(tablelookup(level.objectives_table, 1, message_ref, 0));
    }

    reset_bool = check_objective_reset_value(message_ref);

    if(istrue(reset_bool)) {
      reset_objective_slots();
    }

    if(!isDefined(objective_slot)) {
      objective_slot = get_objective_slot(message_ref);
    }

    lua_objective_incomplete(message_ref);
  }

  if(!isDefined(level.objectives_table)) {
    var_6427da22a2830c8e = int(tablelookup("cp/cp_default_objectives.csv", 1, message_ref, 0));
  }

  if(!isDefined(var_6427da22a2830c8e)) {
    return;
  }

  if(!isDefined(nofailontimeout)) {
    nofailontimeout = 0;
  }

  setindex = 1;
  type = get_objective_type(message_ref);

  if(isDefined(type)) {
    if(type == "global") {
      setindex = 0;
    }
  }

  if(istrue(setindex)) {
    show_objective_widget();

    switch (objective_slot) {
      case 1:
        function_3e3f7e6442d2ee69(objective_slot, level.objectivestabledata[message_ref]);
        setomnvar("cp_objective_sub_1_index", var_6427da22a2830c8e);
        break;
      case 2:
        function_3e3f7e6442d2ee69(objective_slot, level.objectivestabledata[message_ref]);
        setomnvar("cp_objective_sub_2_index", var_6427da22a2830c8e);
        break;
      case 3:
        function_3e3f7e6442d2ee69(objective_slot, level.objectivestabledata[message_ref]);
        setomnvar("cp_objective_sub_3_index", var_6427da22a2830c8e);
        break;
      case 4:
        function_3e3f7e6442d2ee69(objective_slot, level.objectivestabledata[message_ref]);
        setomnvar("cp_objective_sub_4_index", var_6427da22a2830c8e);
        break;
    }

    if(isDefined(object_count)) {
      switch (objective_slot) {
        case 1:
          setomnvar("cp_objective_sub_count_1", object_count);
          break;
        case 2:
          setomnvar("cp_objective_sub_count_2", object_count);
          break;
        case 3:
          setomnvar("cp_objective_sub_count_3", object_count);
          break;
        case 4:
          setomnvar("cp_objective_sub_count_4", object_count);
          break;
      }
    }
  }

  if(soundexists("ui_new_objective_popup")) {
    foreach(player in level.players) {
      player playsoundtoplayer("ui_new_objective_popup", player);
    }
  }

  if(isDefined(time) && time > 0) {
    setomnvar("cp_countdown_color", 0);
    timer_slot = objective_slot;

    if(istrue(big_timer)) {
      timer_slot = 5;
    }

    setomnvar("cp_countdown_timer_alpha", timer_slot);
    setomnvar("cp_countdown_timer", gettime() + time * 1000);

    if(isDefined(yellow_time) && yellow_time > 0 && yellow_time < time && !isDefined(red_time)) {
      wait time - yellow_time;
      setomnvar("cp_countdown_color", 1);
      wait yellow_time;
    } else if(isDefined(yellow_time) && isDefined(red_time) && yellow_time > 0 && yellow_time < time && red_time < yellow_time) {
      wait time - yellow_time;
      setomnvar("cp_countdown_color", 1);
      wait yellow_time - red_time;
      setomnvar("cp_countdown_color", 2);
      wait red_time;
    } else {
      wait time;
    }

    if(!istrue(nofailontimeout)) {
      fail_objective(message_ref);
    } else {
      level notify(message_ref + "_timer_complete");
    }

    reset_objective_timers();
  }
}

function function_74e8374f8dd7beb3(original_time, yellow_time, red_time) {
  level endon("game_ended");
  setomnvar("cp_countdown_timer", gettime() + original_time * 1000);
  setomnvar("cp_countdown_timer_alpha", 5);
  setomnvar("cp_countdown_color", 0);
  time_remaining = original_time;

  if(isDefined(yellow_time) && yellow_time < original_time) {
    time = original_time - yellow_time;
    thread function_1261c5424863a560(time, 2);
    time_remaining = time;
  }

  if(isDefined(red_time) && red_time < time_remaining) {
    time = original_time - red_time;
    thread function_1261c5424863a560(time, 1);
  }

  wait original_time;
  reset_objective_timers();
}

function function_f7e398d203c2a25e(objective) {
  var_eb92e89246b291b6 = scripts\cp\cp_checkpoint::function_87ce7c6cba6c393();
  var_2147f031250509f6 = 0;

  foreach(checkpoint in var_eb92e89246b291b6) {
    if(!function_81066d5ad04fa613(checkpoint, objective)) {
      function_b6090c4fefd0c9a5(checkpoint, objective);
      var_2147f031250509f6 = 1;
    }
  }

  return var_2147f031250509f6;
}

function function_1261c5424863a560(time_to_wait, new_color) {
  level endon("game_ended");
  wait time_to_wait;
  function_2d1e769c3e096073(new_color);
}

function function_2d1e769c3e096073(color) {
  switch (color) {
    case 0:
    case #"hash_1393412d7401c646":
      setomnvar("cp_countdown_color", 0);
      break;
    case 1:
    case #"hash_2ac407c1cd5943a9":
      setomnvar("cp_countdown_color", 1);
      break;
    case 2:
    case #"hash_97430f6c58e61cbc":
      setomnvar("cp_countdown_color", 2);
      break;
  }
}

function event_update_internal(message_ref, time, yellow_time, red_time, nofailontimeout, object_count) {
  level notify(message_ref + "_update_instance");
  level endon(message_ref + "_update_instance");
  level endon(message_ref + "_completed");
  level endon(message_ref + "_failed");
  level endon(message_ref + "objective_paused");
  var_6427da22a2830c8e = undefined;
  reset_bool = undefined;

  if(isDefined(level.objectives_table)) {
    if(isDefined(level.objectivestabledata[message_ref])) {
      var_6427da22a2830c8e = level.objectivestabledata[message_ref].index;
    } else {
      var_6427da22a2830c8e = int(tablelookup(level.objectives_table, 1, message_ref, 0));
    }

    reset_bool = check_objective_reset_value(message_ref);

    if(istrue(reset_bool)) {
      reset_objective_slots();
    }

    lua_objective_incomplete(message_ref);
  }

  if(!isDefined(level.objectives_table)) {
    var_6427da22a2830c8e = int(tablelookup("cp/cp_default_objectives.csv", 1, message_ref, 0));
  }

  if(!isDefined(var_6427da22a2830c8e)) {
    return;
  }

  if(!isDefined(nofailontimeout)) {
    nofailontimeout = 0;
  }

  setindex = 1;
  type = get_objective_type(message_ref);

  if(isDefined(type)) {
    if(type == "global") {
      setindex = 0;
    }
  }

  if(istrue(setindex)) {
    function_531e694c49fc6238(level.objectivestabledata[message_ref]);
    setomnvar("cp_objective_event_index", var_6427da22a2830c8e);

    if(isDefined(object_count)) {
      setomnvar("cp_objective_event_count", object_count);
    }
  }

  if(soundexists("iw8_new_objective_sfx")) {
    playsoundatpos((0, 0, 0), "iw8_new_objective_sfx");
  }

  if(isDefined(time) && time > 0) {
    setomnvar("cp_countdown_event_color", 0);
    setomnvar("cp_countdown_event_timer_alpha", 1);
    setomnvar("cp_countdown_event_timer", gettime() + time * 1000);

    if(isDefined(yellow_time) && yellow_time > 0 && yellow_time < time && !isDefined(red_time)) {
      wait time - yellow_time;
      setomnvar("cp_countdown_event_color", 1);
      wait yellow_time;
    } else if(isDefined(yellow_time) && yellow_time > 0 && yellow_time < time && isDefined(red_time) && red_time < yellow_time) {
      wait time - yellow_time;
      setomnvar("cp_countdown_event_color", 1);
      wait yellow_time - red_time;
      setomnvar("cp_countdown_event_color", 2);
      wait red_time;
    } else {
      wait time;
    }

    if(!istrue(nofailontimeout)) {
      fail_objective(message_ref);
      reset_event_timers();
    } else {
      level notify(message_ref + "_timer_complete");
    }

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

function get_objective_slot(message_ref) {
  objective_slot = undefined;

  if(isDefined(level.objectivestabledata) && isDefined(level.objectivestabledata[message_ref])) {
    objective_slot = level.objectivestabledata[message_ref].var_53b4259e1f971282;
  }

  if(isDefined(level.objectives_table) && !isDefined(objective_slot)) {
    objective_slot = tablelookup(level.objectives_table, 1, message_ref, 29);
  }

  if(isDefined(objective_slot) && objective_slot != "") {
    return int(objective_slot);
  }

  return 1;
}

function check_objective_reset_value(message_ref) {
  objective_reset = undefined;

  if(isDefined(level.objectivestabledata) && isDefined(level.objectivestabledata[message_ref])) {
    objective_reset = level.objectivestabledata[message_ref].var_d1f50ecf0047c109;
  }

  if(isDefined(level.objectives_table) && !isDefined(objective_reset)) {
    objective_reset = tablelookup(level.objectives_table, 1, message_ref, 30);
  }

  if(isDefined(objective_reset) && objective_reset != "") {
    return 1;
  }

  return 0;
}

function fail_objective(message_ref) {
  level notify(message_ref + "_failed");
  reset_objective_omnvars(message_ref);
}

function run_objective(var_dcd66f3ea861d2a2, var_5dcdfd3a4eff9961, team, var_a1bbc6ba0618b4f4) {
  level endon("game_ended");
  level endon("debug_beat_" + var_dcd66f3ea861d2a2 + "_objective");
  level endon(var_dcd66f3ea861d2a2 + "_failed");

  if(getdvarint(@ "hash_d69a0cd99ac530d6", 0)) {
    return;
  }

  if(!isDefined(level.objectivestabledata[var_dcd66f3ea861d2a2])) {
    return;
  }

  objectivestruct = level.objectivestabledata[var_dcd66f3ea861d2a2];
  objectivestruct.objname = var_dcd66f3ea861d2a2;
  objectivestruct.iscompletednaturally = 0;

  if(isDefined(objectivestruct.csdependency) && objectivestruct.csdependency != "") {
    if(!flag_exist(objectivestruct.csdependency)) {
      flag_init(objectivestruct.csdependency);
    }

    if(!flag(objectivestruct.csdependency)) {
      flag_set(objectivestruct.csdependency);
    }

    flag_wait(objectivestruct.csdependency + "_completed");
  }

  processiconposref(objectivestruct);

  if(!isDefined(team)) {
    objectivestruct.currentteam = "allies";
  } else {
    objectivestruct.currentteam = team;
  }

  if(isDefined(var_5dcdfd3a4eff9961) && var_5dcdfd3a4eff9961 == "primary") {
    objectivestruct.alwaysshowicon = 1;
  } else if(isDefined(var_5dcdfd3a4eff9961) && var_5dcdfd3a4eff9961 == "global") {
    objectivestruct.alwaysshowicon = 1;
  }

  level thread watchfordebugcompletion(objectivestruct, var_dcd66f3ea861d2a2, var_5dcdfd3a4eff9961);
  level thread watchforobjectivefailure(objectivestruct, var_dcd66f3ea861d2a2, var_5dcdfd3a4eff9961);
  function_15e35b3d28646e05(objectivestruct, var_dcd66f3ea861d2a2, var_5dcdfd3a4eff9961, var_a1bbc6ba0618b4f4);

  if(isDefined(var_5dcdfd3a4eff9961)) {
    level notify(var_5dcdfd3a4eff9961 + "_objective_completed");
  }
}

function function_15e35b3d28646e05(objectivestruct, var_dcd66f3ea861d2a2, var_5dcdfd3a4eff9961, var_a1bbc6ba0618b4f4) {
  level endon(var_dcd66f3ea861d2a2 + "_stop_early");
  initializeobjective(objectivestruct, var_dcd66f3ea861d2a2, var_5dcdfd3a4eff9961);
  startobjective(objectivestruct, var_dcd66f3ea861d2a2, var_5dcdfd3a4eff9961, var_a1bbc6ba0618b4f4);
  completeobjective(objectivestruct, var_dcd66f3ea861d2a2, var_5dcdfd3a4eff9961);
}

function function_7850abf9f827db14(var_f2d97351ff0781ba, newstate, wait_time, play_intro) {
  if(getdvarint(@ "hash_aeb5afa02dc9651d", 0) > 0) {
    return;
  }

  level thread update_objective_state(var_f2d97351ff0781ba, "current", play_intro);

  if(getdvarint(@ "hash_80b4d12585669f54", 0) > 0) {
    level thread function_41851a22b94a7feb(var_f2d97351ff0781ba, newstate, wait_time, play_intro);
  }
}

function function_41851a22b94a7feb(var_f2d97351ff0781ba, new_state, wait_time, play_intro) {
  if(!isDefined(wait_time)) {
    wait_time = 90;
  } else if(isDefined(level.var_35de5b3d21a7b809)) {
    wait_time = level.var_35de5b3d21a7b809;
  }

  if(!isDefined(play_intro)) {
    play_intro = 0;
  }

  wait wait_time;
  update_objective_state(var_f2d97351ff0781ba, new_state, play_intro);
}

function update_objective_state(var_f2d97351ff0781ba, new_state, play_intro) {
  objective_setplayintro(var_f2d97351ff0781ba, play_intro);
  objective_state(var_f2d97351ff0781ba, new_state);
}

function function_74fbd2df5669698e(first_state, end_state, wait_time) {
  activequests = get_active_objectives();

  if(!isDefined(activequests)) {
    return;
  }

  for(i = 0; i < activequests.size; i++) {
    if(isDefined(activequests[i]) && isDefined(activequests[i].objectiveindex)) {
      objectiveindex = activequests[i].objectiveindex;
      level thread update_objective_state(objectiveindex, first_state, 0);

      if(getdvarint(@ "hash_80b4d12585669f54", 0) > 0) {
        level thread function_41851a22b94a7feb(objectiveindex, end_state, wait_time, 0);
      }
    }
  }
}

function function_4060f86cf056cf74(notification, val) {
  if(isDefined(level.worldobjidpool) && getdvarint(@ "hash_aeb5afa02dc9651d", 0) <= 0) {
    function_74fbd2df5669698e("current", "active");
  }
}

function watchforobjectivefailure(objectivestruct, var_dcd66f3ea861d2a2, var_5dcdfd3a4eff9961) {
  level endon("game_ended");
  level endon("debug_beat_" + var_dcd66f3ea861d2a2 + "_objective");
  objectivestruct endon(var_dcd66f3ea861d2a2 + "_completed");
  level waittill(var_dcd66f3ea861d2a2 + "_failed");
  ref = objectivestruct.ref;

  if(isDefined(objectivestruct.hudicon)) {
    destroy_objective_waypoint(objectivestruct.hudicon);
  }

  if(isDefined(objectivestruct.currentteam)) {
    objectivestruct.currentteam = undefined;
  }

  if(isDefined(objectivestruct.headiconents)) {
    foreach(ent in objectivestruct.headiconents) {
      objectivestruct removeheadicon(ent);
    }

    objectivestruct.headiconents = undefined;
  }

  remove_from_active_quests(objectivestruct);
  mark_objective_failed(ref);
  reset_objective_omnvars(ref);
  tryrunnextobjective(objectivestruct, 0);
}

function mark_objective_failed(name) {
  objectivestruct = getobjectivestructfromref(name);

  if(!isDefined(objectivestruct)) {
    return;
  }

  index = objectivestruct.objectiveindex;

  if(!isDefined(index)) {
    return;
  }

  objective_state(index, "failed");
}

function lua_objective_complete(message_ref) {
  event_flag = check_event_flag(message_ref);

  if(!istrue(event_flag)) {
    objective_slot = get_objective_slot(message_ref);
    var_d44a3d0c31d349c3 = check_for_objective_timer(message_ref);

    if(var_d44a3d0c31d349c3) {
      reset_objective_timers();
    }

    switch (objective_slot) {
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

function lua_objective_incomplete(message_ref, event_flag) {
  event_flag = check_event_flag(message_ref);

  if(!istrue(event_flag)) {
    objective_slot = get_objective_slot(message_ref);
    var_d44a3d0c31d349c3 = check_for_objective_timer(message_ref);

    if(var_d44a3d0c31d349c3) {
      reset_objective_timers();
    }

    switch (objective_slot) {
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

function check_for_objective_timer(message_ref) {
  timer1 = undefined;

  if(isDefined(level.objectivestabledata) && isDefined(level.objectivestabledata[message_ref])) {
    timer1 = level.objectivestabledata[message_ref].timer1;
  }

  if(isDefined(level.objectives_table) && !isDefined(timer1)) {
    timer1 = int(tablelookup(level.objectives_table, 1, message_ref, 9));
  }

  if(isDefined(timer1) && timer1 > 0) {
    return 1;
  }

  return 0;
}

function reset_objective_slots() {
  function_a245aa068aad0c25(1);
  setomnvar("cp_objective_sub_1_index", 0);
  setomnvar("cp_objective_sub_count_1", -1);
  function_a245aa068aad0c25(2);
  setomnvar("cp_objective_sub_2_index", 0);
  setomnvar("cp_objective_sub_count_2", -1);
  function_a245aa068aad0c25(3);
  setomnvar("cp_objective_sub_3_index", 0);
  setomnvar("cp_objective_sub_count_3", -1);
  function_a245aa068aad0c25(4);
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

function reset_subobjective_slot(message_ref) {
  slot = get_objective_slot(message_ref);
  setomnvar("cp_objective_sub_" + slot + "_index", 0);
  setomnvar("cp_objective_sub_count_" + slot, -1);
}

function check_event_flag(message_ref) {
  event_flag = undefined;

  if(isDefined(level.objectivestabledata) && isDefined(level.objectivestabledata[message_ref])) {
    event_flag = level.objectivestabledata[message_ref].eventflag;
  }

  if(isDefined(level.objectives_table) && !isDefined(event_flag)) {
    event_flag = int(tablelookup(level.objectives_table, 1, message_ref, 31));
  }

  if(isDefined(event_flag) && event_flag == 1) {
    return 1;
  }

  return 0;
}

function reset_objective_omnvars(message_ref) {
  event_flag = check_event_flag(message_ref);

  if(!istrue(event_flag)) {
    objective_slot = get_objective_slot(message_ref);
    function_a245aa068aad0c25(objective_slot);

    switch (objective_slot) {
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

  function_44eb8f15c8b0f94c();
  setomnvar("cp_objective_event_index", 0);
  setomnvar("cp_objective_event_count", -1);
}

function watchfordebugcompletion(objectivestruct, var_dcd66f3ea861d2a2, var_5dcdfd3a4eff9961) {
  level endon("game_ended");
  level endon(var_dcd66f3ea861d2a2 + "_failed");
  objectivestruct endon(var_dcd66f3ea861d2a2 + "_completed");
  level waittill("debug_beat_" + objectivestruct.objname + "_objective");
  wait 1;

  if(isDefined(objectivestruct.ondebugbeatfunc)) {
    [[objectivestruct.ondebugbeatfunc]](objectivestruct);
  }

  if(!objectivestruct.iscompletednaturally) {
    completeobjective(objectivestruct, var_dcd66f3ea861d2a2, var_5dcdfd3a4eff9961);
  }

  if(isDefined(var_5dcdfd3a4eff9961)) {
    level notify(var_5dcdfd3a4eff9961 + "_objective_completed");
  }
}

function debugbeatobjective(objectivename) {
  level notify("debug_beat_" + objectivename + "_objective");
}

function createdevguientryforobjective(objectivestruct) {
  if(!isDefined(level.completedobjectives)) {
    index = 0;
  } else {
    index = level.completedobjectives.size + 1;
  }

  cmd = "devgui_cmd \"CP Debug:2 / Objectives / Complete / Beat " + objectivestruct.objname + " Objective:" + index + "\" \"set start_objective_debug notify - debug_beat_" + objectivestruct.objname + "_objective\" \n";
  addentrytodevgui(cmd);

  if(!istrue(objectivestruct.excludedfromrandompool)) {
    cmd = "devgui_cmd \"CP Debug:2 / Objectives / Start / Start " + objectivestruct.objname + " Objective:" + index + "\" \"set start_objective_debug notify - debug - start_" + objectivestruct.objname + " -objective\" \n";
    addentrytodevgui(cmd);
  }
}

function addprintlinetext(var_dcd66f3ea861d2a2) {}

function initializeobjective(objectivestruct, var_dcd66f3ea861d2a2, var_5dcdfd3a4eff9961) {
  level endon("debug_beat_" + objectivestruct.objname + "_objective");

  if(function_f7e398d203c2a25e(var_dcd66f3ea861d2a2)) {
    level notify(var_dcd66f3ea861d2a2 + "_stop_early");
    return;
  }

  default_init_objective(objectivestruct, var_5dcdfd3a4eff9961);

  if(isDefined(objectivestruct.init)) {
    [[objectivestruct.init]](objectivestruct);
  }

  objectivestruct notify("objective_initialized");
}

function function_a51fcb4045af8a4c(var_dcd66f3ea861d2a2, var_5dcdfd3a4eff9961) {
  objectivestruct = level.objectivestabledata[var_dcd66f3ea861d2a2];
  default_init_objective(objectivestruct, var_5dcdfd3a4eff9961);
  level.activequests[level.activequests.size] = objectivestruct;
  function_d0218c674cea5dc3(var_dcd66f3ea861d2a2);
  wait 1;

  if(isDefined(level.previous_spawn_points) && array_contains(level.previous_spawn_points, objectivestruct.objname)) {
    level.previous_spawn_points = array_add(level.previous_spawn_points, objectivestruct.objname);
  }

  remove_from_active_quests(objectivestruct);

  if(isDefined(var_5dcdfd3a4eff9961) && var_5dcdfd3a4eff9961 == "global" && !istrue(scripts\cp\cp_objectives_events::is_event_completed(objectivestruct.ref))) {
    if(isDefined(objectivestruct.hudicon)) {
      destroy_objective_waypoint(objectivestruct.hudicon);
    }

    delete_objective(objectivestruct.objname);
    return;
  }

  objectivestruct notify("objective_completed");
  defaultcompleteobjective(objectivestruct);
  tryrunnextobjective(objectivestruct, 1);
}

function startobjective(objectivestruct, var_dcd66f3ea861d2a2, var_5dcdfd3a4eff9961, var_a1bbc6ba0618b4f4) {
  level endon("game_ended");
  level endon("debug_beat_" + objectivestruct.objname + "_objective");
  objectivestruct.var_a1bbc6ba0618b4f4 = var_a1bbc6ba0618b4f4;

  if(!istrue(var_a1bbc6ba0618b4f4)) {
    scripts\cp\cp_analytics::function_ae955ccdef747b0(var_dcd66f3ea861d2a2);
  }

  level.activequests[level.activequests.size] = objectivestruct;
  function_d0218c674cea5dc3(var_dcd66f3ea861d2a2);

  if(isDefined(objectivestruct.startfunc)) {
    [[objectivestruct.startfunc]](objectivestruct);
  }
}

function function_d0218c674cea5dc3(var_dcd66f3ea861d2a2) {
  if(level.active_objectives_string.size <= 0) {
    level.active_objectives_string = var_dcd66f3ea861d2a2;
    return;
  }

  level.active_objectives_string = level.active_objectives_string + "," + var_dcd66f3ea861d2a2;
}

function completeobjective(objectivestruct, var_dcd66f3ea861d2a2, var_5dcdfd3a4eff9961) {
  if(isDefined(level.previous_spawn_points) && array_contains(level.previous_spawn_points, objectivestruct.objname)) {
    level.previous_spawn_points = array_add(level.previous_spawn_points, objectivestruct.objname);
  }

  remove_from_active_quests(objectivestruct);

  if(isDefined(var_5dcdfd3a4eff9961) && var_5dcdfd3a4eff9961 == "global" && !istrue(scripts\cp\cp_objectives_events::is_event_completed(objectivestruct.ref))) {
    if(isDefined(objectivestruct.hudicon)) {
      destroy_objective_waypoint(objectivestruct.hudicon);
    }

    delete_objective(objectivestruct.objname);
    return;
  }

  objectivestruct notify("objective_completed");
  objectivestruct.iscompletednaturally = 1;
  defaultcompleteobjective(objectivestruct);

  if(!istrue(objectivestruct.var_a1bbc6ba0618b4f4)) {
    scripts\cp\cp_analytics::function_b6283ac45a607764(var_dcd66f3ea861d2a2);
  }

  if(isDefined(objectivestruct.points) && objectivestruct.points > 0) {
    amount = objectivestruct.points;

    if(level.gametype == "cp_survival") {
      amount = 100;
    }

    foreach(player in level.players) {
      player scripts\cp\persistence::give_player_currency(amount, "large");
    }
  }

  if(isDefined(objectivestruct.endfunc)) {
    [[objectivestruct.endfunc]](objectivestruct);
  }

  tryrunnextobjective(objectivestruct, 1);
  level notify(var_dcd66f3ea861d2a2 + "_completed");
  objectivestruct notify(var_dcd66f3ea861d2a2 + "_completed");
}

function function_4312a455bfdaa469(objectivestruct, var_dcd66f3ea861d2a2, var_5dcdfd3a4eff9961) {
  if(!array_contains(level.previous_spawn_points, objectivestruct.objname)) {
    level.previous_spawn_points = array_add(level.previous_spawn_points, objectivestruct.objname);
  }

  remove_from_active_quests(objectivestruct);
  objectivestruct notify("objective_completed");
  defaultcompleteobjective(objectivestruct);

  if(isDefined(objectivestruct.endfunc)) {
    [[objectivestruct.endfunc]](objectivestruct);
  }

  level notify(var_dcd66f3ea861d2a2 + "_completed");
  objectivestruct notify(var_dcd66f3ea861d2a2 + "_completed");
}

function delete_objective(name) {
  objectivestruct = getobjectivestructfromref(name);

  if(!isDefined(objectivestruct)) {
    return;
  }

  index = objectivestruct.objectiveindex;

  if(!isDefined(index)) {
    return;
  }

  objective_delete(index);

  if(isDefined(objectivestruct.var_aa2e0492a2d8b18d)) {
    objective_delete(objectivestruct.var_aa2e0492a2d8b18d);
    objectivestruct.var_aa2e0492a2d8b18d = undefined;
  }
}

function tryrunnextobjective(objectivestruct, var_a5c6e6f71769ad99) {
  if(!isDefined(var_a5c6e6f71769ad99)) {
    var_a5c6e6f71769ad99 = 1;
  }

  if(getDvar(@ "ui_gametype") == "cp_survival" && objectivestruct.questtype == "primary") {
    if(var_a5c6e6f71769ad99 && isDefined(objectivestruct.nextsteps) && objectivestruct.nextsteps.size > 0) {
      thread run_objective(objectivestruct.nextsteps[0], objectivestruct.questtype);
    }

    return;
  }

  if(var_a5c6e6f71769ad99) {
    if(isDefined(objectivestruct.nextsteps) && objectivestruct.nextsteps.size > 0) {
      thread run_objective(random(objectivestruct.nextsteps), objectivestruct.questtype);
    }
  }
}

function remove_from_active_quests(objectivestruct) {
  level.activequests = array_remove(level.activequests, objectivestruct);
  toks = strtok(level.active_objectives_string, ",");

  if(toks.size > 0) {
    new_string = "";
    count = 0;

    foreach(tok in toks) {
      if(tok == objectivestruct.ref) {
        continue;
      }

      if(count == 0) {
        new_string = tok;
      } else {
        new_string = new_string + "," + tok;
      }

      count++;
    }

    level.active_objectives_string = new_string;
  }
}

function findandrunrandomprimaryobjective() {
  level endon("game_ended");
  newobjective = undefined;
  primaryobjectives = [];

  foreach(obj in level.objectivestabledata) {
    if(obj.questtype == "primary" && !array_contains(level.completedobjectives, obj) && istrue(obj.isregistered) && !istrue(obj.excludedfromrandompool)) {
      primaryobjectives[primaryobjectives.size] = obj;
    }
  }

  if(primaryobjectives.size <= 0) {
    return;
  }

  wait 5;
  thread run_objective(random(primaryobjectives).ref);
}

function initobjectivehud() {}

function setlevelobjectivetext(text) {}

function clearobjectivetext() {}

function setobjectivetextforplayer(player, text) {}

function clearobjectivetextforplayer(player) {}

function blankobjectivefunc() {
  level endon("new_objective_chosen");
}

function setomnvarbasedonindex(index) {
  foreach(struct in level.objectivestabledata) {
    if(int(index) == int(struct.index)) {
      setomnvar("cp_objective_index", index);
      return;
    }
  }

  setomnvar("cp_objective_index", 0);
}

function setobjectivetocompleteanddroploot(interaction_struct, player) {
  interaction_struct.completedobjective = 1;
}

function create_objective_waypoint(origin, team, shader, alpha, scale) {
  if(!isDefined(scale)) {
    scale = 1;
  }

  waypoint = undefined;

  if(team != "all") {
    waypoint = newteamhudelem(team);
  } else {
    waypoint = newhudelem();
  }

  waypoint.id = level.waypoint_index;
  waypoint.x = origin[0];
  waypoint.y = origin[1];
  waypoint.z = origin[2];
  waypoint.team = team;
  waypoint.isflashing = 0;
  waypoint.isshown = 1;
  level.waypoint_index++;

  if(isDefined(shader)) {
    waypoint setshader(shader, level.waypoint_size, level.waypoint_size);
    waypoint setwaypoint(1, 1);
  }

  if(isDefined(alpha)) {
    waypoint.alpha = alpha;
  } else {
    waypoint.alpha = level.waypoint_alpha;
  }

  waypoint.basealpha = waypoint.alpha;
  return waypoint;
}

function destroy_objective_waypoint(var_bdc9be1e8d868b84, var_5d6af369e433bf0d, var_4f881fbc80a8e973) {
  if(isDefined(var_5d6af369e433bf0d)) {
    level thread[[var_5d6af369e433bf0d]](var_bdc9be1e8d868b84);
  }

  if(isDefined(var_5d6af369e433bf0d) && isDefined(var_4f881fbc80a8e973)) {
    var_bdc9be1e8d868b84 waittill_any_timeout_1(var_4f881fbc80a8e973, "destroy_objective_icon");
  } else if(isDefined(var_5d6af369e433bf0d)) {
    var_bdc9be1e8d868b84 waittill("destroy_objective_icon");
  } else if(isDefined(var_4f881fbc80a8e973)) {
    wait var_4f881fbc80a8e973;
  }

  var_bdc9be1e8d868b84 destroy();
}

function give_objective_skillpoints() {}

function default_init_objective(objectivestruct, var_c8e8379712763a61) {
  if(isDefined(objectivestruct.nofailontimeout) && objectivestruct.nofailontimeout > 0) {
    nofailontimeout = 1;
  } else {
    nofailontimeout = 0;
  }

  if(!istrue(objectivestruct.bigtimer)) {
    objectivestruct.bigtimer = 0;
  }

  if(!istrue(objectivestruct.skipdescription)) {
    setomnvar("cp_objective_desc_index", 1);

    if(isDefined(objectivestruct.timer1) && isDefined(objectivestruct.timer2) && isDefined(objectivestruct.timer3)) {
      level thread objective_update(objectivestruct.objname, objectivestruct.timer1, objectivestruct.timer2, objectivestruct.timer3, nofailontimeout);
    } else if(isDefined(objectivestruct.timer1) && isDefined(objectivestruct.timer2)) {
      level thread objective_update(objectivestruct.objname, objectivestruct.timer1, objectivestruct.timer2, undefined, nofailontimeout);
    } else if(isDefined(objectivestruct.timer1)) {
      level thread objective_update(objectivestruct.objname, objectivestruct.timer1, undefined, undefined, nofailontimeout);
    } else {
      level thread objective_update(objectivestruct.objname);
    }
  }

  sname = ter_op(isDefined(objectivestruct.objname), objectivestruct.objname, undefined);
  vpos = ter_op(isDefined(objectivestruct.iconpos), objectivestruct.iconpos, undefined);
  var_76519454e15d81d8 = ter_op(isDefined(objectivestruct.activatestring), objectivestruct.activatestring, undefined);
  slabel = ter_op(isDefined(objectivestruct.label), objectivestruct.label, undefined);
  icon = ter_op(isDefined(objectivestruct.objicon), objectivestruct.objicon, undefined);
  stype = ter_op(isDefined(objectivestruct.questtype), objectivestruct.questtype, undefined);
  var_c2ca522a99b04a12 = "icon_regular";

  if(isDefined(var_76519454e15d81d8) && var_76519454e15d81d8 == "" || istrue(objectivestruct.skipdescription)) {
    var_76519454e15d81d8 = undefined;
  }

  if(isDefined(objectivestruct.iconpos) && isDefined(objectivestruct.objicon)) {
    sstate = "current";
  } else {
    sstate = "active";
  }

  if(getdvarint(@ "hash_aeb5afa02dc9651d", 0) > 0) {
    sstate = "active";
  }

  level.current_respawn_point = objectivestruct.objname;

  if(isarray(vpos)) {
    objectivestruct.objectiveindexes = [];
    add_objective(sname, sstate, undefined, var_76519454e15d81d8, slabel, icon, var_c2ca522a99b04a12, stype, objectivestruct, var_c8e8379712763a61);

    foreach(index, var_b578ad77fc83ce0e in vpos) {
      objective_setlocation(objectivestruct.objectiveindex, index, var_b578ad77fc83ce0e);
      objectivestruct.objectiveindexes[objectivestruct.objectiveindexes.size] = index;
    }

    return;
  }

  add_objective(sname, sstate, vpos, var_76519454e15d81d8, slabel, icon, var_c2ca522a99b04a12, stype, objectivestruct, var_c8e8379712763a61);
}

function defaultcompleteobjective(objectivestruct, var_673ee5e7ddb8a56a) {
  thread scripts\cp\coop_personal_ents::update_special_mode_for_all_players();

  if(isDefined(objectivestruct.hudicon)) {
    destroy_objective_waypoint(objectivestruct.hudicon);
  }

  if(isDefined(objectivestruct.headiconents)) {
    foreach(ent in objectivestruct.headiconents) {
      objectivestruct removeheadicon(ent);
    }

    objectivestruct.headiconents = undefined;
  }

  if(isDefined(objectivestruct.objname)) {
    var_d9e0fff6d338fda3 = objectivestruct.objectiveindex;

    if(isDefined(objectivestruct.complete_state)) {
      if(isDefined(var_d9e0fff6d338fda3)) {
        objective_state(var_d9e0fff6d338fda3, objectivestruct.complete_state);
      }

      if(isDefined(objectivestruct.var_aa2e0492a2d8b18d)) {
        objective_state(objectivestruct.var_aa2e0492a2d8b18d, objectivestruct.complete_state);
      }
    } else {
      if(isDefined(var_d9e0fff6d338fda3)) {
        objective_state(var_d9e0fff6d338fda3, "done");
      }

      if(isDefined(objectivestruct.var_aa2e0492a2d8b18d)) {
        objective_state(objectivestruct.var_aa2e0492a2d8b18d, "done");
      }

      if(isDefined(objectivestruct.objectiveindexes)) {
        foreach(i in objectivestruct.objectiveindexes) {
          objective_unsetlocation(objectivestruct.objectiveindex, i);
        }
      }
    }

    if(get_objective_type(objectivestruct.objname) == "global") {
      delay_delete_objective(objectivestruct.objectiveindex, 0.15);

      if(isDefined(objectivestruct.var_aa2e0492a2d8b18d)) {
        delay_delete_objective(objectivestruct.var_aa2e0492a2d8b18d, 0.15);
        objectivestruct.var_aa2e0492a2d8b18d = undefined;
      }

      objectivestruct notify(objectivestruct.objname + "_completed");
      level notify("debug_beat_" + objectivestruct.objname + "_objective");
    }

    if(isDefined(objectivestruct.currentteam)) {
      curteam = objectivestruct.currentteam;

      if(does_team_have_active_chain(curteam)) {
        if(!isDefined(objectivestruct.nextsteps) || objectivestruct.nextsteps.size <= 0) {
          add_to_list_of_current_chain_idx(objectivestruct, curteam);
          delete_all_team_chain_objectives(curteam);
        } else {
          add_to_list_of_current_chain_idx(objectivestruct, curteam);
        }
      } else if(isDefined(objectivestruct.nextsteps) && objectivestruct.nextsteps.size > 0) {
        add_to_list_of_current_chain_idx(objectivestruct, curteam);
      } else {
        freeworldid(objectivestruct.objname);

        if(isDefined(objectivestruct.var_aa2e0492a2d8b18d)) {
          objective_delete(objectivestruct.var_aa2e0492a2d8b18d);
          objectivestruct.var_aa2e0492a2d8b18d = undefined;
        }
      }

      objectivestruct.currentteam = undefined;
    } else {
      freeworldid(objectivestruct.objname);
    }

    if(!istrue(objectivestruct.skipdescription)) {
      lua_objective_complete(objectivestruct.ref);
    }
  }

  if(istrue(var_673ee5e7ddb8a56a) || istrue(objectivestruct.checkpointrevive)) {
    checkpoint_revive();
  }

  if(istrue(var_673ee5e7ddb8a56a) || istrue(objectivestruct.checkpointrevive)) {
    give_objective_skillpoints();
  }

  foreach(objective in level.completedobjectives) {
    cmd = "<dev string:x15d>" + objective.objname + "<dev string:x194>";
    addentrytodevgui(cmd);
  }

  level.completedobjectives[level.completedobjectives.size] = objectivestruct;
}

function does_team_have_active_chain(team) {
  return isDefined(level.currentteamobjectivechain) && isDefined(level.currentteamobjectivechain[team]) && level.currentteamobjectivechain[team].size > 0;
}

function add_to_list_of_current_chain_idx(objectivestruct, team) {
  if(!isDefined(team)) {
    return;
  }

  if(!isDefined(level.currentteamobjectivechain)) {
    level.currentteamobjectivechain = [];
  }

  if(!isDefined(level.currentteamobjectivechain[team])) {
    level.currentteamobjectivechain[team] = [];
  }

  level.currentteamobjectivechain[team][level.currentteamobjectivechain[team].size] = objectivestruct;
}

function delete_all_team_chain_objectives(team) {
  if(!isDefined(level.currentteamobjectivechain) || !isDefined(level.currentteamobjectivechain[team])) {
    return;
  }

  foreach(objstruct in level.currentteamobjectivechain[team]) {
    objective_delete(objstruct.objectiveindex);
  }
}

function delay_delete_objective(objectiveindex, delay_time) {
  if(!isDefined(objectiveindex)) {
    return;
  }

  if(isDefined(delay_time)) {
    wait delay_time;
  }

  objective_delete(objectiveindex);
}

function checkpoint_revive() {
  foreach(player in level.players) {
    if(scripts\cp\laststand::player_in_laststand(player)) {
      player scripts\cp\laststand::instant_revive(player);

      if(isDefined(player.dogtag)) {
        player.dogtag delete();
      }
    }
  }
}

function add_objective(name, state, position, text, var_44acebb5ec08d85d, iconname, iconsize, var_5dcdfd3a4eff9961, objectivestruct, var_c8e8379712763a61) {
  priority = 20;

  if(var_5dcdfd3a4eff9961 == "global") {
    priority = 15;
  }

  index = requestworldid(name, priority);
  _add_objective(index, state, position, iconname, iconsize);

  if(isDefined(var_5dcdfd3a4eff9961) && var_5dcdfd3a4eff9961 != "primary" && isDefined(position)) {
    if(var_5dcdfd3a4eff9961 != "global") {
      level thread watchfornearbyplayers(index, position, objectivestruct);
    }
  }

  objective_set_play_intro(index, 1);

  if(isDefined(text)) {
    if(isDefined(level.display_objective_text_func)) {
      level thread[[level.display_objective_text_func]](name, text, objectivestruct.currentteam, 5);
    }

    objective_setdescription(index, text);
  }

  if(isDefined(var_44acebb5ec08d85d)) {
    objective_setlabel(index, var_44acebb5ec08d85d);
  }

  objective_unpinforteam(index, "allies");
  objective_setshowdistance(index, 1);
  objective_setbackground(index, 0);
  objective_setshowoncompass(index, 1);

  if(isDefined(objectivestruct.disablefade)) {
    objective_setfadedisabled(index, objectivestruct.disablefade);
  }

  if(!isDefined(position) && getdvarint(@ "hash_aeb5afa02dc9651d", 0) <= 0) {
    objective_state(index, "invisible");
  }

  objectivestruct.objiconid = index;
  objectivestruct.iconname = objectivestruct.objname;
  objectivestruct.objectiveindex = index;

  if(istrue(objectivestruct.showobjprogress)) {
    objective_show_progress(objectivestruct.objectiveindex, 1);

    if(get_objective_type(objectivestruct.objname) == "global") {
      objectivestruct.showobjprogress = objectivestruct.showobjprogressbackup;
    }

    if(objectivestruct.showobjprogress > 1) {
      objective_set_progress(objectivestruct.objectiveindex, 0);
      objectivestruct thread startprogresstimer(objectivestruct, objectivestruct.showobjprogress);
      return;
    }

    if(objectivestruct.showobjprogress < -1) {
      objective_set_progress(objectivestruct.objectiveindex, 1);
      objectivestruct thread startprogresstimer(objectivestruct, objectivestruct.showobjprogress * -1, 1);
    }
  }
}

function startprogresstimer(objectivestruct, var_7add62896f072eb8, reversed) {
  level endon("debug_beat_" + objectivestruct.objname + "_objective");
  objectivestruct endon(objectivestruct.objname + "_completed");
  objectivestruct endon("stop_timer");

  if(var_7add62896f072eb8 > 3) {
    var_7add62896f072eb8 -= 3;
    wait 3;
  }

  var_25ccce114196d19c = 0;
  var_6939f739bef3dab9 = 1;

  if(istrue(reversed)) {
    var_25ccce114196d19c = 1;
    var_6939f739bef3dab9 = 0;
  }

  timepassed = 0;
  tick = 0.1;
  endtime = gettime() + var_7add62896f072eb8 * 1000;
  objective_set_progress(objectivestruct.objectiveindex, var_25ccce114196d19c);

  while(gettime() < endtime) {
    if(!istrue(reversed)) {
      objective_set_progress(objectivestruct.objectiveindex, timepassed / var_7add62896f072eb8);
    } else {
      objective_set_progress(objectivestruct.objectiveindex, 1 - timepassed / var_7add62896f072eb8);
    }

    if(!isDefined(objectivestruct.pause_timer)) {
      timepassed += tick;
    } else {
      endtime += 1000 * tick;
    }

    if(timepassed <= 0) {
      break;
    }

    wait tick;
  }

  objective_set_progress(objectivestruct.objectiveindex, var_6939f739bef3dab9);
}

function set_nearby_console(objectivestruct) {
  objectivestruct.nearby_players[objectivestruct.nearby_players.size] = self;
}

function show_to_players_that_are_near(index, position, objectivestruct, dist_override) {
  level endon("game_ended");
  objectivestruct endon("objective_completed");
  objectivestruct endon("stop_watching");
  showing = 0;
  minimap_objective_playermask_hidefromall(index);
  minimap_objective_pin_global(index, 0);

  if(isDefined(dist_override)) {
    dist = dist_override * dist_override;
  } else {
    dist = 1048576;
  }

  objectivestruct.showtoall = 0;

  while(true) {
    if(istrue(objectivestruct.showtoall)) {
      if(!showing) {
        showing = 1;
        minimap_objective_playermask_showtoall(index);
      }
    } else if(istrue(objectivestruct.hidefromall)) {
      if(showing) {
        showing = 0;
        minimap_objective_playermask_hidefromall(index);
      }
    } else {
      minimap_objective_pin_global(index, 0);
      objectivestruct.nearby_players = [];
      closest_players = get_array_of_closest(position, level.players, undefined, undefined, dist);
      array_call(closest_players, &set_nearby_console, objectivestruct);
      showing = 0;

      foreach(player in level.players) {
        if(istrue(player.disable_objective_update)) {
          objective_set_play_outro(index, 0);
          minimap_objective_playermask_hidefrom(index, player);
          continue;
        }

        if(player is_valid_player() && distancesquared(player.origin, position) <= dist) {
          objective_set_play_intro(index, 0);
          minimap_objective_playermask_showto(index, player);
          continue;
        }

        objective_set_play_outro(index, 0);
        minimap_objective_playermask_hidefrom(index, player);
      }
    }

    objectivestruct waittill_any_timeout_1(0.5, "update_nearby_thread");
  }
}

function watchfornearbyplayers(index, position, objectivestruct, dist_override) {
  level endon("game_ended");
  objectivestruct endon("objective_completed");
  objectivestruct endon("stop_watching");
  showing = 0;
  minimap_objective_playermask_hidefromall(index);

  if(isDefined(dist_override)) {
    dist = dist_override * dist_override;
  } else {
    dist = 1056784;
  }

  while(true) {
    while(!istrue(objectivestruct.showtoall) && !any_player_nearby(position, dist)) {
      if(showing) {
        minimap_objective_playermask_hidefromall(index);
        showing = 0;
      }

      objectivestruct waittill_any_timeout_1(0.5, "update_nearby_thread");
    }

    if(!showing) {
      showing = 1;
      minimap_objective_playermask_showtoall(index);
    }

    objectivestruct waittill_any_timeout_1(0.5, "update_nearby_thread");
  }
}

function unset_all_locations(id) {
  for(i = 0; i <= 7; i++) {
    objective_unsetlocation(id, i);
  }
}

function initobjectiveicons() {
  minimapobjidpool = spawnStruct();
  minimapobjidpool.active = [];
  minimapobjidpool.reclaimed = [];
  minimapobjidpool.index = 0;
  level.minimapobjidpool = minimapobjidpool;
  worldobjidpool = spawnStruct();
  worldobjidpool.active = [];
  worldobjidpool.reclaimed = [];
  worldobjidpool.reserved = [];
  worldobjidpool.index = 0;
  level.worldobjidpool = worldobjidpool;
}

function requestminimapid(priority) {
  objid = getnextminimapid(priority);

  if(objid == -1) {
    return -1;
  }

  entry = spawnStruct();
  entry.priority = priority;
  entry.requesttime = gettime();
  entry.objid = objid;
  level.minimapobjidpool.active[objid] = entry;
  return objid;
}

function removebestminimapid(prioritymax) {
  query = [];

  foreach(objid in level.minimapobjidpool.active) {
    if(objid.priority <= prioritymax) {
      query[query.size] = objid;
    }
  }

  array_sort_with_func(query, &comparepriorityandtime);
  return returnminimapid(query[0].objid);
}

function comparepriorityandtime(a, b) {
  if(a.priority == b.priority) {
    return (a.requesttime < b.requesttime);
  }

  return a.priority < b.priority;
}

function getnextminimapid(priority) {
  if(level.minimapobjidpool.index == 32) {
    if(!removebestminimapid(priority)) {
      assertmsg("Unable to locate an objective to remove!");
      return -1;
    }
  }

  if(!level.minimapobjidpool.reclaimed.size) {
    if(level.minimapobjidpool.index == 32) {
      assertmsg("No minimap IDs available!");
      return -1;
    } else {
      nextid = level.minimapobjidpool.index;
      level.minimapobjidpool.index++;
    }
  } else {
    nextid = level.minimapobjidpool.reclaimed[level.minimapobjidpool.reclaimed.size - 1];
    level.minimapobjidpool.reclaimed[level.minimapobjidpool.reclaimed.size - 1] = undefined;
  }

  return nextid;
}

function returnminimapid(objid) {
  if(!isDefined(objid) || objid == -1) {
    return false;
  }

  for(i = 0; i < level.minimapobjidpool.reclaimed.size; i++) {
    if(objid == level.minimapobjidpool.reclaimed[i]) {
      assertmsg("ObjID has already been returned!");
      return false;
    }
  }

  level.minimapobjidpool.active[objid] = undefined;
  objective_delete(objid);
  level.minimapobjidpool.reclaimed[level.minimapobjidpool.reclaimed.size] = objid;
  return true;
}

function function_cabeebf04bbbf02d(identifier) {
  assertex(isDefined(identifier), "a WorldID check has to be called with an identifier parameter");

  foreach(id in level.worldobjidpool.active) {
    if(identifier == id.identifier) {
      return id.objid;
    }
  }

  return undefined;
}

function requestworldid(identifier, priority) {
  assertex(isDefined(identifier), "a WorldIDRequest has to be called with an identifier parameter");

  if(!isDefined(priority)) {
    priority = 10;
  }

  worldid = getnextworldid(priority);

  if(worldid == -1) {
    return undefined;
  }

  entry = spawnStruct();
  entry.priority = priority;
  entry.requesttime = gettime();
  entry.objid = worldid;
  entry.identifier = identifier;
  level.worldobjidpool.active[worldid] = entry;
  level notify("worldObjIDPool_requested", identifier, worldid);
  return worldid;
}

function function_c0663d9578eb8bbb(objid) {
  level endon("game_ended");
  flag_wait("objectives_registered");

  if(!isDefined(objid) || objid == -1) {
    objid = getnextworldid(100);

    if(objid == -1) {
      return -1;
    }
  } else if(array_contains(level.worldobjidpool.reserved, objid)) {
    return;
  }

  entry = spawnStruct();
  entry.priority = 100;
  entry.requesttime = gettime();
  entry.objid = objid;
  level.worldobjidpool.active[objid] = entry;
  level.worldobjidpool.reserved[level.worldobjidpool.reserved.size] = objid;
  return objid;
}

function freeworldid(identifier) {
  if(!isDefined(identifier)) {
    return;
  }

  foreach(entry in level.worldobjidpool.active) {
    if(isDefined(entry.identifier) && entry.identifier == identifier) {
      unset_all_locations(entry.objid);
      internal_reclaimworldid(entry.objid);
    }
  }
}

function freeworldidbyobjid(objid) {
  if(!isDefined(objid)) {
    return;
  }

  foreach(entry in level.worldobjidpool.active) {
    if(entry.objid == objid) {
      unset_all_locations(entry.objid);
      internal_reclaimworldid(entry.objid);
    }
  }
}

function removebestworldid(prioritymax) {
  query = [];

  foreach(var_f5e161df984c344f in level.worldobjidpool.active) {
    if(array_contains(level.worldobjidpool.reserved, var_f5e161df984c344f)) {
      continue;
    }

    if(var_f5e161df984c344f.priority < prioritymax) {
      query[query.size] = var_f5e161df984c344f;
    }
  }

  array_sort_with_func(query, &comparepriorityandtime);
  return internal_reclaimworldid(query[0].objid);
}

function getnextworldid(priority) {
  if(objective_isunlimited()) {
    return objective_create();
  }

  if(level.worldobjidpool.index == 32) {
    if(!removebestworldid(priority)) {
      assertmsg("Unable to locate an objective to remove!");
      return -1;
    }
  }

  if(level.worldobjidpool.reclaimed.size <= 0) {
    if(level.worldobjidpool.index == 32) {
      assertmsg("All CP World IDs are taken and have more or equal priority than " + priority);
      return -1;
    } else {
      while(array_contains(level.worldobjidpool.reserved, level.worldobjidpool.index)) {
        level.worldobjidpool.index++;
      }

      if(level.worldobjidpool.index == 32) {
        assertmsg("<dev string:x1a3>" + priority);
        return -1;
      }

      nextid = level.worldobjidpool.index;
      level.worldobjidpool.index++;
    }
  } else {
    nextid = level.worldobjidpool.reclaimed[level.worldobjidpool.reclaimed.size - 1];
    level.worldobjidpool.reclaimed[level.worldobjidpool.reclaimed.size - 1] = undefined;
  }

  return nextid;
}

function internal_reclaimworldid(objid) {
  if(!isDefined(objid)) {
    return false;
  }

  if(objective_isunlimited()) {
    objective_delete(objid);
    level.worldobjidpool.active[objid] = undefined;
    return true;
  }

  index = objid;

  for(i = 0; i < level.worldobjidpool.reclaimed.size; i++) {
    if(index == level.worldobjidpool.reclaimed[i]) {
      println("<dev string:x1e4>");
      return false;
    }
  }

  if(isDefined(level.worldobjidpool.reserved)) {
    var_73fb94c9aedcc497 = array_find(level.worldobjidpool.reserved, objid);

    if(isDefined(var_73fb94c9aedcc497)) {
      level.worldobjidpool.reserved[var_73fb94c9aedcc497] = undefined;
    }
  }

  objective_delete(index);
  level notify("objective_id_reclaimed_" + index);
  level.worldobjidpool.active[index] = undefined;
  level.worldobjidpool.reclaimed[level.worldobjidpool.reclaimed.size] = index;
  return true;
}

function is_objective_active(var_82b6ee472031a48b) {
  foreach(quest in level.activequests) {
    if(quest.ref == var_82b6ee472031a48b) {
      return true;
    }
  }

  return false;
}

function _add_objective(objectivenumber, state, position, iconname, iconsize) {
  if(!objective_isunlimited()) {
    objective_delete(objectivenumber);
  }

  if(isDefined(state)) {
    objective_state(objectivenumber, state);
  }

  if(isDefined(position)) {
    objective_position(objectivenumber, position);
  }

  if(isDefined(iconname) && iconname != "") {
    objective_icon(objectivenumber, iconname);
  }

  if(isDefined(iconsize)) {
    objective_setminimapiconsize(objectivenumber, iconsize);
  }
}

function minimap_objective_add(objid, state, position, iconshader, iconsize) {
  if(objid == -1) {
    return;
  }

  _add_objective(objid, state, position, iconshader, iconsize);
}

function minimap_objective_state(objid, state) {
  if(objid == -1) {
    return;
  }

  objective_state(objid, state);
}

function minimap_objective_position(objid, position) {
  if(objid == -1) {
    return;
  }

  objective_position(objid, position);
}

function minimap_objective_icon(objid, iconshader) {
  if(objid == -1) {
    return;
  }

  objective_icon(objid, iconshader);
}

function minimap_objective_setbackground(objid, type) {
  if(objid == -1) {
    return;
  }

  objective_setbackground(objid, type);
}

function minimap_objective_onentity(objid, ent) {
  if(objid == -1) {
    return;
  }

  objective_onentity(objid, ent);
}

function minimap_objective_onentitywithrotation(objid, ent) {
  if(objid == -1) {
    return;
  }

  objective_onentity(objid, ent);
  objective_setrotateonminimap(objid, 1);
}

function minimap_objective_setzoffset(objid, offset) {
  if(objid == -1) {
    return;
  }

  objective_setzoffset(objid, offset);
}

function minimap_objective_player(objid, ent) {
  if(objid == -1) {
    return;
  }

  objective_removeallfrommask(objid);
  objective_addclienttomask(objid, ent);
  objective_showtoplayersinmask(objid);
}

function minimap_objective_team(objid, team) {
  if(objid == -1) {
    return;
  }

  objective_removeallfrommask(objid);
  objective_addteamtomask(objid, team);
  objective_showtoplayersinmask(objid);
}

function minimap_objective_playermask_hidefromall(objid) {
  if(objid == -1) {
    return;
  }

  objective_addalltomask(objid);
  objective_hidefromplayersinmask(objid);
}

function minimap_objective_playermask_hidefrom(objid, ent) {
  if(objid == -1) {
    return;
  }

  objective_showtoplayersinmask(objid);
  objective_removeclientfrommask(objid, ent);
}

function minimap_objective_playermask_showto(objid, ent) {
  if(objid == -1) {
    return;
  }

  objective_showtoplayersinmask(objid);
  objective_addclienttomask(objid, ent);
}

function minimap_objective_playermask_showtoall(objid) {
  if(objid == -1) {
    return;
  }

  objective_addalltomask(objid);
  objective_showtoplayersinmask(objid);
}

function minimap_objective_playerteam(objid, ent) {
  if(objid == -1) {
    return;
  }

  objective_removeallfrommask(objid);

  if(level.teambased) {
    objective_addteamtomask(objid, ent.team);
  } else {
    objective_addclienttomask(objid, ent);
  }

  objective_showtoplayersinmask(objid);
}

function minimap_objective_playerenemyteam(objid, ent) {
  if(objid == -1) {
    return;
  }

  objective_removeallfrommask(objid);

  if(level.teambased) {
    objective_addteamtomask(objid, ent.team);
  } else {
    objective_addclienttomask(objid, ent);
  }

  objective_hidefromplayersinmask(objid);
}

function minimap_objective_team_addtomask(objid, team) {
  if(objid == -1) {
    return;
  }

  objective_addteamtomask(objid, team);
  objective_showtoplayersinmask(objid);
}

function minimap_objective_team_removefrommask(objid, team) {
  if(objid == -1) {
    return;
  }

  objective_removeteamfrommask(objid, team);
  objective_showtoplayersinmask(objid);
}

function minimap_objective_pin_global(objid, pin) {
  if(objid == -1) {
    return;
  }

  objective_setpinned(objid, pin);
}

function minimap_objective_pin_team(objid, team) {
  if(objid == -1) {
    return;
  }

  objective_pinforteam(objid, team);
}

function minimap_objective_unpin_team(objid, team) {
  if(objid == -1) {
    return;
  }

  objective_unpinforteam(objid, team);
}

function minimap_objective_pin_player(objid, player) {
  if(objid == -1) {
    return;
  }

  objective_pinforclient(objid, player);
}

function minimap_objective_unpin_player(objid, player) {
  if(objid == -1) {
    return;
  }

  objective_unpinforclient(objid, player);
}

function objective_set_hot(objid, bool) {
  if(objid == -1) {
    return;
  }

  objective_sethot(objid, bool);
}

function objective_show_progress(objid, show) {
  if(objid == -1) {
    return;
  }

  objective_setshowprogress(objid, show);
}

function objective_show_team_progress(objid, team) {
  if(objid == -1) {
    return;
  }

  objective_showprogressforteam(objid, team);
}

function objective_hide_team_progress(objid, team) {
  if(objid == -1) {
    return;
  }

  objective_hideprogressforteam(objid, team);
}

function objective_show_player_progress(objid, player) {
  if(objid == -1) {
    return;
  }

  objective_showprogressforclient(objid, player);
}

function objective_hide_player_progress(objid, player) {
  if(objid == -1) {
    return;
  }

  objective_hideprogressforclient(objid, player);
}

function objective_set_progress(objid, progress) {
  if(objid == -1) {
    return;
  }

  objective_setprogress(objid, progress);
}

function objective_set_progress_team(objid, team) {
  if(objid == -1) {
    return;
  }

  objective_setprogressteam(objid, team);
}

function objective_set_progress_client(objid, player) {
  if(objid == -1) {
    return;
  }

  objective_setprogressclient(objid, player);
}

function objective_set_play_intro(objid, show) {
  if(objid == -1) {
    return;
  }

  objective_setplayintro(objid, show);
}

function objective_set_play_outro(objid, show) {
  if(objid == -1) {
    return;
  }

  objective_setplayoutro(objid, show);
}

function objective_set_pulsate(objid, pulse) {
  if(objid == -1) {
    return;
  }

  objective_setpulsate(objid, pulse);
}

function update_objective(name, state, position, var_9e3ea33dc78e3908, label, var_6d3f81546283a608, icon, background_preset, should_play_intro, var_2d17a4ab32a30541) {
  if(!isDefined(level.objectivestabledata[name])) {
    return;
  }

  objectivestruct = level.objectivestabledata[name];
  index = level.objectivestabledata[name].objectiveindex;

  if(isDefined(should_play_intro) && should_play_intro) {
    objective_delete(index);
  }

  if(isDefined(var_2d17a4ab32a30541)) {
    objective_setplayoutro(index, var_2d17a4ab32a30541);
  }

  if(isDefined(should_play_intro)) {
    objective_setplayintro(index, should_play_intro);
  }

  if(isDefined(state)) {
    objective_state(index, state);
  }

  if(isDefined(position)) {
    objective_position(index, position);
  }

  if(isDefined(var_9e3ea33dc78e3908)) {
    objective_setdescription(index, var_9e3ea33dc78e3908);
  }

  if(isDefined(var_6d3f81546283a608)) {
    if(var_6d3f81546283a608 > 8) {
      var_6d3f81546283a608 = 8;
    }

    if(var_6d3f81546283a608 < 1) {
      var_6d3f81546283a608 = 1;
    }

    setomnvar("cp_objective_desc_index", var_6d3f81546283a608);
  }

  if(isDefined(label)) {
    objective_setlabel(index, label);
  }

  if(isDefined(icon)) {
    objective_icon(index, icon);
  }

  if(isDefined(background_preset)) {
    objective_setbackground(index, background_preset);
  }

  function_215a200907638b6e();
  setomnvarbasedonindex(0);
  wait 0.5;
  function_393d1a6fdf1b49a8(objectivestruct);
  setomnvarbasedonindex(objectivestruct.index);
  newstate = ter_op(isDefined(state), state, "active");
  function_7850abf9f827db14(index, newstate, undefined, istrue(should_play_intro));
}

function getobjectiveforfloor(var_7fa79ccde6800a5e) {
  var_9f552ac3a1c58174 = undefined;

  if(isDefined(level.mapbasedobjectiverules)) {
    var_9f552ac3a1c58174 = [[level.mapbasedobjectiverules]](level.floorobjectives, var_7fa79ccde6800a5e);
  } else {
    var_9f552ac3a1c58174 = random(level.floorobjectives);
  }

  thread run_objective(var_9f552ac3a1c58174.ref, var_9f552ac3a1c58174.questtype);
}

function get_active_objectives() {
  return level.activequests;
}

function get_objective_type(message_ref) {
  if(!isDefined(level.objectivestabledata)) {
    return;
  }

  foreach(objectivestruct in level.objectivestabledata) {
    if(objectivestruct.ref == message_ref) {
      if(isDefined(objectivestruct.questtype)) {
        return objectivestruct.questtype;
      }
    }
  }

  return undefined;
}

function create_breadcrumb_for_team(team, var_da9f87445b20f758, breadcrumb_label, iconname) {
  players = getplayersinteam(team);
  var_f02b9c5f28f98df5 = [];

  foreach(player in players) {
    var_f02b9c5f28f98df5[var_f02b9c5f28f98df5.size] = create_breadcrumb_for_player(player, var_da9f87445b20f758, breadcrumb_label, iconname);
    wait 0.5;
  }

  return var_f02b9c5f28f98df5;
}

function create_breadcrumb_for_player(player, var_da9f87445b20f758, breadcrumb_label, iconname) {
  if(!isDefined(level.activebreadcrumbs)) {
    level.activebreadcrumbs = [];
  }

  var_4f5586ff3cac9451 = spawnStruct();
  var_4f5586ff3cac9451.stepstructs = [];
  var_4f5586ff3cac9451.stepstructsproximity = [];
  stepstructs = getStructArray(var_da9f87445b20f758, "script_noteworthy");

  if(stepstructs.size <= 0) {
    return undefined;
  }

  stepstructs = array_sort_with_func(stepstructs, &compare_breadcrumb_order);

  foreach(var_1f0fbe7770e2e902 in stepstructs) {
    index = var_4f5586ff3cac9451.stepstructs.size;
    var_4f5586ff3cac9451.stepstructs[index] = var_1f0fbe7770e2e902.origin;

    if(isDefined(var_1f0fbe7770e2e902.script_radius)) {
      var_4f5586ff3cac9451.stepstructsproximity[index] = squared(var_1f0fbe7770e2e902.script_radius);
    }
  }

  var_4f5586ff3cac9451.id = requestworldid("breadcrumb_for_" + player.name, 2);

  if(isDefined(iconname) && iconname != "") {
    var_4f5586ff3cac9451.iconname = iconname;
  } else {
    var_4f5586ff3cac9451.iconname = "icon_waypoint_objective_general";
  }

  if(isDefined(breadcrumb_label)) {
    var_4f5586ff3cac9451.label = breadcrumb_label;
  }

  var_4f5586ff3cac9451.player = player;
  index = 0;

  if(isDefined(level.breadcrumb_update_func)) {
    index = [[level.breadcrumb_update_func]](var_4f5586ff3cac9451);
  }

  update_breadcrumb_for_player(var_4f5586ff3cac9451, index);
  var_4f5586ff3cac9451 thread watchforplayernearbcrumb(index);
  level.activebreadcrumbs[level.activebreadcrumbs.size] = var_4f5586ff3cac9451;
  return var_4f5586ff3cac9451;
}

function compare_breadcrumb_order(a, b) {
  return int(a.targetname) < int(b.targetname);
}

function watchforplayernearbcrumb(index_override) {
  level endon("game_ended");
  self endon("breadcrumb_finished");
  player = self.player;
  curindex = 0;

  if(isDefined(index_override)) {
    curindex = index_override;
  }

  lastindex = self.stepstructs.size;
  distsq = 90000;

  while(curindex < lastindex && isPlayer(self.player)) {
    if(distancesquared(player.origin, self.stepstructs[curindex]) <= get_bcrumbstruct_proximity(self, curindex)) {
      curindex++;

      if(curindex >= lastindex) {
        level notify("finished_last_breadcrumb", player);
        level delete_breadcrumb(self);
      } else {
        update_breadcrumb_for_player(self, curindex);
      }

      waitframe();
      continue;
    } else if(distancesquared(player.origin, self.stepstructs[lastindex - 1]) <= get_bcrumbstruct_proximity(self, lastindex - 1)) {
      level notify("finished_last_breadcrumb", player);
      level delete_breadcrumb(self);
    }

    wait 0.1;
  }
}

function get_bcrumbstruct_proximity(var_4f5586ff3cac9451, index) {
  if(isDefined(var_4f5586ff3cac9451.stepstructsproximity[index])) {
    return var_4f5586ff3cac9451.stepstructsproximity[index];
  }

  return 90000;
}

function update_breadcrumb_for_player(var_4f5586ff3cac9451, index) {
  if(!isPlayer(var_4f5586ff3cac9451.player) || !isDefined(var_4f5586ff3cac9451) || !isDefined(var_4f5586ff3cac9451.stepstructs[index])) {
    return 0;
  }

  objective_delete(var_4f5586ff3cac9451.id);
  waitframe();

  if(isDefined(var_4f5586ff3cac9451.label)) {
    objective_setlabel(var_4f5586ff3cac9451.id, var_4f5586ff3cac9451.label);
  }

  objective_position(var_4f5586ff3cac9451.id, var_4f5586ff3cac9451.stepstructs[index]);
  objective_icon(var_4f5586ff3cac9451.id, var_4f5586ff3cac9451.iconname);
  objective_setbackground(var_4f5586ff3cac9451.id, 1);

  foreach(player in level.players) {
    if(player != var_4f5586ff3cac9451.player) {
      objective_removeclientfrommask(var_4f5586ff3cac9451.id, player);
      continue;
    }

    objective_addclienttomask(var_4f5586ff3cac9451.id, player);
  }

  objective_state(var_4f5586ff3cac9451.id, "current");
}

function delete_breadcrumb(objstruct) {
  objective_delete(objstruct.id);
  internal_reclaimworldid(objstruct.id);
  objstruct notify("breadcrumb_finished");

  if(array_contains(level.activebreadcrumbs, objstruct)) {
    level.activebreadcrumbs = array_remove(level.activebreadcrumbs, objstruct);
  }
}

function delete_breadcrumb_array(var_b03c3da266132086) {
  foreach(crumb in var_b03c3da266132086) {
    delete_breadcrumb(crumb);
  }
}

function objective_minimapupdate(objectiveindex) {
  objective_state(objectiveindex, "current");
  objective_setshowoncompass(objectiveindex, 1);
  objective_setminimapiconsize(objectiveindex, "icon_regular");
  level notify("objective_minimapUpdate");
}

function give_objective_xp_to_all_players(type) {
  if(!isDefined(type)) {
    type = #"minor_objective";
  }

  foreach(player in level.players) {
    player thread scripts\cp\rank::giverankxp(type, scripts\cp\rank::getscoreinfovalue(type));
  }

  level notify("give_objective_xp_to_all_players", type);
}

function increment_player_participation() {
  foreach(player in level.players) {
    if(isDefined(player.pers["periodic_xp_participation"])) {
      player.pers["periodic_xp_participation"]++;
      continue;
    }

    player.pers["periodic_xp_participation"] = 1;
  }
}

function prepare_mission_failed_text(objectivename) {
  objectivestruct = getobjectivestructfromref(objectivename);

  if(!isDefined(objectivestruct)) {
    return;
  }

  if(isDefined(level.objectivestabledata) && isDefined(level.objectivestabledata[objectivestruct.objname])) {
    var_58aa18381e030864 = level.objectivestabledata[objectivestruct.objname].index;
    failed_text = level.objectivestabledata[objectivestruct.objname].failedtext;

    if(isDefined(failed_text) && failed_text != "") {
      foreach(player in level.players) {
        player setclientomnvar("ui_cp_mission_fail_index", var_58aa18381e030864);
      }
    } else {
      foreach(player in level.players) {
        player setclientomnvar("ui_cp_mission_fail_index", 0);
      }
    }

    return;
  }

  foreach(player in level.players) {
    player setclientomnvar("ui_cp_mission_fail_index", 0);
  }
}

function run_debug_start_objective(var_2c54f5164c98d2d) {
  level endon("game_ended");
  flag_wait("level_ready_for_script");
  flag_wait("objective_table_parsed");
  flag_wait("objectives_registered");
  objname = "";

  if(isDefined(var_2c54f5164c98d2d) && isstring(var_2c54f5164c98d2d)) {
    objname = getDvar(@ "start", var_2c54f5164c98d2d);
  } else {
    objname = getDvar(@ "start", "");
  }

  if(!isDefined(objname) || objname == "") {
    if(isDefined(var_2c54f5164c98d2d) && isstring(var_2c54f5164c98d2d)) {
      objname = getDvar(hashcat(@ "hash_287b3b75f2c14fe9", level.script), var_2c54f5164c98d2d);
    } else {
      objname = getDvar(hashcat(@ "hash_287b3b75f2c14fe9", level.script), "");
    }
  }

  if(isDefined(objname) && objname != "") {
    if(isDefined(level.objectivestabledata[objname])) {
      objstruct = level.objectivestabledata[objname];

      if(isDefined(objstruct.ondebugstartfunc)) {
        [[objstruct.ondebugstartfunc]](objstruct);
      }

      level thread run_objective(objstruct.objname, objstruct.questtype);
    }
  }
}

function objective_playermask_hidefrom(objid, ent) {
  if(objid == -1) {
    return;
  }

  objective_removeclientfrommask(objid, ent);
  objective_showtoplayersinmask(objid);
}

function objective_playermask_addshowplayer(objid, ent) {
  if(objid == -1) {
    return;
  }

  objective_showtoplayersinmask(objid);
  objective_addclienttomask(objid, ent);
}

function function_2e0726d51b65646(itemref) {
  flag_wait("<dev string:x207>");
  items = strtok(itemref, "<dev string:x21e>");
  playertoks = strtok(itemref, "<dev string:x220>");
  player = undefined;

  if(playertoks.size > 1) {
    playerint = int(playertoks[1]);
    player = level.players[playerint];
  }

  switch (items[0]) {
    case #"hash_a230d018e76ed84a":
      level notify(playertoks[1]);
      break;
    case #"hash_e2d99549915d1ebf":
      if(isDefined(level.objectivestabledata[playertoks[3]])) {
        objstruct = level.objectivestabledata[playertoks[3]];

        if(isDefined(objstruct.ondebugstartfunc)) {
          [[objstruct.ondebugstartfunc]](objstruct);
        }

        run_objective(objstruct.objname, objstruct.questtype);
      }

      break;
    default:
      break;
  }
}

function showquestobjicontoplayer(player) {
  objective_addclienttomask(self.objectiveiconid, player);
}

function hidequestobjiconfromplayer(player) {
  objective_removeclientfrommask(self.objectiveiconid, player);
}

function function_3e3f7e6442d2ee69(slotindex, objstruct) {
  if(slotindex < 1 || slotindex > 4) {
    return;
  }

  var_a646becc88132126 = isDefined(objstruct);
  var_da64e46ac49388c5 = ter_op(var_a646becc88132126 && isDefined(objstruct.activatestring), objstruct.activatestring, "<dev string:xc6>");
  var_e9146de10b7d0e9d = ter_op(var_a646becc88132126 && isDefined(objstruct.var_24852c22989ccfc5), objstruct.var_24852c22989ccfc5, "<dev string:xc6>");
  var_3a71d2c8acdf91cc = ter_op(var_a646becc88132126 && isDefined(objstruct.objicon), objstruct.objicon, "<dev string:xc6>");

  foreach(player in level.players) {
    player setclientdvar(hashcat(@ "cp_objective_sub_", slotindex, "<dev string:x242>"), var_da64e46ac49388c5);
    player setclientdvar(hashcat(@ "cp_objective_sub_", slotindex, "<dev string:x248>"), var_e9146de10b7d0e9d);
    player setclientdvar(hashcat(@ "cp_objective_sub_", slotindex, "<dev string:x253>"), var_3a71d2c8acdf91cc);
  }
}

function function_a245aa068aad0c25(slotindex) {
  if(slotindex < 1 || slotindex > 4) {
    return;
  }

  foreach(player in level.players) {
    player setclientdvar(hashcat(@ "cp_objective_sub_", slotindex, "<dev string:x242>"), "<dev string:xc6>");
    player setclientdvar(hashcat(@ "cp_objective_sub_", slotindex, "<dev string:x248>"), "<dev string:xc6>");
    player setclientdvar(hashcat(@ "cp_objective_sub_", slotindex, "<dev string:x253>"), "<dev string:xc6>");
  }
}

function function_531e694c49fc6238(objstruct) {
  var_a646becc88132126 = isDefined(objstruct);
  var_760a4bb0f0886b6b = ter_op(var_a646becc88132126 && isDefined(objstruct.var_24852c22989ccfc5), objstruct.var_24852c22989ccfc5, "<dev string:xc6>");
  var_53fceb19fef319fa = ter_op(var_a646becc88132126 && isDefined(objstruct.objicon), objstruct.objicon, "<dev string:xc6>");

  foreach(player in level.players) {
    player setclientdvar(@ "hash_bbe849b7a1de4c33", var_760a4bb0f0886b6b);
    player setclientdvar(@ "hash_3d54612c6d4203df", var_53fceb19fef319fa);
  }
}

function function_44eb8f15c8b0f94c() {
  foreach(player in level.players) {
    player setclientdvar(@ "hash_bbe849b7a1de4c33", "<dev string:xc6>");
    player setclientdvar(@ "hash_3d54612c6d4203df", "<dev string:xc6>");
  }
}

function function_393d1a6fdf1b49a8(objstruct) {
  var_a646becc88132126 = isDefined(objstruct);
  var_9fe2f3d2a21a5755 = ter_op(var_a646becc88132126 && isDefined(objstruct.var_24852c22989ccfc5), objstruct.var_24852c22989ccfc5, "<dev string:xc6>");
  icon = ter_op(var_a646becc88132126 && isDefined(objstruct.objicon), objstruct.objicon, "<dev string:xc6>");

  foreach(player in level.players) {
    player setclientdvar(@ "hash_d835c8736e856d41", var_9fe2f3d2a21a5755);
    player setclientdvar(@ "hash_b067e9b6cb8c1793", icon);
  }
}

function function_215a200907638b6e() {
  foreach(player in level.players) {
    player setclientdvar(@ "hash_d835c8736e856d41", "<dev string:xc6>");
    player setclientdvar(@ "hash_b067e9b6cb8c1793", "<dev string:xc6>");
  }
}

function function_9a19ccf8dc6c3caf() {
  return istrue(self.pinobj);
}

function function_dc06030ceb03363b() {
  if((getDvar(@ "hash_7611a2790a0bf7fe", "") == "dmz" || getDvar(@ "hash_7611a2790a0bf7fe", "") == "exgm") && isDefined(self.trigger) && isDefined(self.trigger.objidnum)) {
    return istrue(self.trigger.pinobj);
  }

  return false;
}

function createquestobjicon(iconref, state, var_38116998df9814d4) {
  assert(isDefined(self.missionid));
  assert(self.missionid != "");
  self.objectiveiconid = requestworldid(self.missionid);

  if(self.objectiveiconid != -1) {
    objective_state(self.objectiveiconid, state);
    objective_position(self.objectiveiconid, (0, 0, 0));
    objective_icon(self.objectiveiconid, iconref);
    objective_setbackground(self.objectiveiconid, 1);
    objective_showtoplayersinmask(self.objectiveiconid);
    objective_setplayintro(self.objectiveiconid, 1);

    if(isDefined(var_38116998df9814d4)) {
      movequestobjicon(var_38116998df9814d4);
    }

    return;
  }

  println(self.category + "<dev string:x259>");
}

function showquestobjicontoall(objid) {
  objective_addalltomask(objid);
}

function deletequestobjicon() {
  if(self.objectiveiconid == -1) {
    return;
  }

  freeworldidbyobjid(self.objectiveiconid);
}

function movequestobjicon(neworigin) {
  objective_position(self.objectiveiconid, neworigin);
}

function checkforactiveobjicon() {
  return isDefined(self.objectiveiconid);
}

function function_e18920c0717c1b4e(boolean) {
  level.player setclientomnvar("ui_objective_reveal_fanfare_enabled", boolean);
}

function function_84126bde5bb3888b(boolean) {
  level.player setclientomnvar("ui_objective_dismiss_fanfare_enabled", boolean);
}

function function_4e1c4a6c6eec1568() {
  return level.player getclientomnvar("ui_objective_reveal_fanfare_enabled");
}

function function_b338aa1e9ec37fbd(displaytime) {
  self endon("disconnect");
  self endon("death");
  displaytime = default_to(displaytime, 3);

  if(flag("objective_splash_onscreen")) {
    return;
  }

  waitframe();
  level notify("interrupt_tutorial_print");
  flag_waitopen("other_splash_onscreen");
  flag_set("objective_splash_onscreen");
  level.player setclientomnvar("ui_disable_objective_reveal_fanfare", 1);
  level.player setclientomnvar("ui_show_objectives", 1);
  wait displaytime;
  level.player setclientomnvar("ui_show_objectives", 0);
  flag_clear("objective_splash_onscreen");
}

function function_3ea9346c75f0a9bc(displaytime) {
  self endon("disconnect");
  self endon("death");
  displaytime = default_to(displaytime, 3);
  level.player setclientomnvar("ui_disable_objective_reveal_fanfare", 0);
  level.player setclientomnvar("ui_show_objectives_force", 1);
  wait displaytime;
  level.player setclientomnvar("ui_show_objectives_force", 0);
}

function function_b26ad6615e6cf8ce(start_flag, end_flag) {
  level endon("game_ended");

  if(isDefined(start_flag)) {
    flag_wait(start_flag);
  }

  level.player setclientomnvar("ui_show_objectives", 1);

  if(isDefined(end_flag)) {
    flag_wait(end_flag);
  } else {
    while(true) {
      result = level function_28551e899093b138("objectives_updated_state", "objectives_updated");

      if(result["message"] == "objectives_updated") {
        break;
      }

      if(result[0] != "current" && result[0] != "invisible") {
        break;
      }
    }
  }

  level.player setclientomnvar("ui_show_objectives", 0);
}