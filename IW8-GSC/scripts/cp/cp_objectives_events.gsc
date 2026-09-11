/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_objectives_events.gsc
***********************************************/

function init() {
  level.event_director = spawnStruct();
  level.event_director.registered_events = [];

  if(!isDefined(level.globalobjectives)) {
    level.globalobjectives = [];
    return;
  }
}

function register_event(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.start_func = var_1;
  var_4.stop_func = var_2;
  var_4.init_func = var_3;
  var_4.available = 1;
  var_4.active = 0;
  scripts\engine\utility::flag_init("event_" + var_0 + "_completed");
  level.event_director.registered_events[var_0] = var_4;
}

function run(var_0) {
  if(getdvarint("scr_events_disable", 0) != 0) {
    return;
  }

  thread start_event_director(level);
}

function start_event_director(var_0) {
  level endon("game_ended");
  var_1 = 1;
  level.event_table_ref = var_0;
  var_2 = int(tablelookup(var_0, 0, "maxid", 1));

  while(var_1 <= var_2) {
    var_3 = tablelookup(var_0, 0, var_1 + "", 5);
    var_4 = tablelookup(var_0, 0, var_1 + "", 2);
    var_5 = spawnStruct();
    var_5.index = int(0);
    var_5.row_index = var_1;
    var_5.ref = tablelookup(var_0, 0, var_1 + "", 2);
    var_5.activatestring = tablelookup(var_0, 0, var_1 + "", 7);
    var_5.objicon = tablelookup(var_0, 0, var_1 + "", 8);
    var_5.label = tablelookup(var_0, 0, var_1 + "", 9);

    if(isDefined(level.objectivestabledata[var_5.ref]) && isDefined(level.objectivestabledata[var_5.ref].questtype)) {
      var_5.questtype = level.objectivestabledata[var_5.ref].questtype;
    } else {
      var_5.questtype = "global";
    }

    var_5.timer1 = int(tablelookup(var_0, 0, var_1 + "", 11));
    var_5.timer2 = int(tablelookup(var_0, 0, var_1 + "", 12));
    var_5.timer3 = int(tablelookup(var_0, 0, var_1 + "", 13));
    var_5.showobjprogress = int(tablelookup(var_0, 0, var_1 + "", 14));
    var_5.points = int(tablelookup(var_0, 0, var_1 + "", 15));
    var_5.time_stamp = tablelookup(var_0, 0, var_1 + "", 1);
    var_5.associated_table = var_0;
    var_5.event_to_stop = var_3;
    var_6 = tablelookup(var_0, 0, var_1 + "", 3);
    var_5.repeat = var_6;
    assign_event_location(var_5);
    var_5.showobjprogressbackup = var_5.showobjprogress;

    if(var_5.activatestring == "") {
      var_5.activatestring = undefined;
    }

    if(!isDefined(var_5.activatestring) && !isDefined(var_5.objicon) && !isDefined(var_5.iconpos)) {
      var_5.noobjective = 1;
    }

    level.globalobjectives[level.globalobjectives.size] = var_5;
    level.objectivestabledata[var_4] = var_5;
    level.event_director.events[var_4] = var_5;
    register_objective(var_4);
    var_1++;
  }

  thread debug_show_all_live_events();
  thread debug_start_event_force();
  thread debug_stop_event_force();
}

function assign_event_location(var_0) {
  var_1 = tablelookup(var_0.associated_table, 0, var_0.row_index + "", 10);

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = strtok(var_1, ",");
  var_3 = undefined;

  if(var_2.size == 3) {
    var_3 = (int(var_2[0]), int(var_2[1]), int(var_2[2]));
  } else if(var_2.size == 2) {
    var_3 = scripts\engine\utility::getStructArray(var_2[0], var_2[1]);

    if(!isDefined(var_3)) {
      var_3 = getEntArray(var_1, var_2[1]);
    }

    if(!isDefined(var_3) || var_3.size == 0) {
      var_3 = getEntArray(var_2[0], var_2[1]);
    }
  }

  if(isDefined(var_3)) {
    if(isvector(var_3)) {
      var_0.iconpos = var_3;
      return;
    }

    if(isarray(var_3)) {
      var_0.iconpos = [];

      foreach(var_5 in var_3) {
        var_0.iconpos[var_0.iconpos.size] = var_5.origin;
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

function delete_old_objective_location(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(isDefined(var_1)) {
    if(scripts\engine\utility::array_contains(level.struct_class_names["targetname"][var_0], var_1)) {
      level.struct_class_names["targetname"][var_0] = scripts\engine\utility::array_remove(level.struct_class_names["targetname"][var_0], var_1);
    }

    var_1 = undefined;
    return;
  }
}

function register_objective(var_0) {
  if(!isDefined(level.event_director.registered_events)) {
    return;
  }

  if(!isDefined(level.event_director.registered_events[var_0])) {
    return;
  }

  var_1 = level.event_director.registered_events[var_0].start_func;
  var_2 = level.event_director.registered_events[var_0].end_func;
  scripts\cp\cp_objectives::registerobjective(var_0, undefined, var_1, var_2);
}

function run_through_timestamps() {
  if(getdvarint("scr_events_disable_timestamps", 0) != 0) {
    return;
  }

  var_0 = 0;

  foreach(var_2 in level.event_director.events) {
    if(isDefined(var_2.time_stamp) && var_2.time_stamp != "") {
      thread thread_timestamped_events(level, var_0);
    }
  }
}

function thread_timestamped_events(var_0, var_1) {
  if(waittill_reaching_time_stamp(var_0, var_1.time_stamp)) {
    try_start_event(var_1.ref, var_1.associated_table, var_1.row_index);
    return;
  }
}

function try_start_event(var_0, var_1, var_2) {
  if(var_0 == "") {
    return;
  }

  if(getDvar("scr_events_isolate", "") != "") {
    if(getDvar("scr_events_isolate", "") != level.objectivestabledata[var_0].ref) {
      return;
    }
  }

  if(getdvarint("scr_events_disable", 0) != 0) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = level.event_table_ref;
  }

  var_3 = level.objectivestabledata[var_0];
  var_4 = var_3.repeat;

  if(!isDefined(var_2)) {
    var_2 = var_3.row_index;
  }

  try_update_wait_for_repeating_event(var_0, var_4);

  if(is_event_active(var_0)) {
    return;
  }

  mark_event_active(var_0, 1);
  try_run_init_of_event(var_0);
  var_5 = tablelookup(var_1, 0, var_2 + "", 4);

  if(var_5 != "") {
    thread check_prerequisites_then_start_event(level, var_0, var_5);
    return;
  }

  thread start_event(level, var_0);
}

function try_run_init_of_event(var_0) {
  level endon("stop_repeating_event_" + var_0);
  var_1 = level.objectivestabledata[var_0];
  var_2 = get_init_func(var_0);

  if(isDefined(var_2)) {
    level[[var_2]](var_1);
    return;
  }
}

function try_update_wait_for_repeating_event(var_0, var_1) {
  if(!isDefined(var_1) || var_1 == "") {
    return;
  }

  var_2 = strtok(var_1, ",");
  var_3 = int(var_2[0]);
  var_4 = int(var_2[1]);
  update_wait_for_repeating_event(var_0, var_3, var_4);
}

function update_wait_for_repeating_event(var_0, var_1, var_2) {
  if(!isDefined(level.wait_for_repeating_event)) {
    level.wait_for_repeating_event = [];
  }

  var_3 = spawnStruct();
  var_3.min_wait_between_repeat = var_1;
  var_3.max_wait_between_repeat = var_2;
  level.wait_for_repeating_event[var_0] = var_3;
}

function stop_event(var_0) {
  if(var_0 == "") {
    return;
  }

  if(!is_event_active(var_0)) {
    return;
  }

  debug_message_players("^6 STOP EVENT " + var_0);
  mark_event_active(var_0, 0);
  var_1 = get_stop_func(var_0);
  var_2 = level.objectivestabledata[var_0];

  if(is_event_completed(var_0)) {
    if(isDefined(var_2.points) && var_2.points > 0) {
      foreach(var_4 in level.players) {
        var_4 scripts\cp\cp_persistence::give_player_currency(var_2.points, "large");
      }
    }
  }

  var_6 = var_2.repeat;
  var_2 = level.objectivestabledata[var_0];
  level thread scripts\cp\cp_objectives::defaultcompleteobjective(var_2);
  level notify("debug_beat_" + var_2.ref + "_objective");

  if(isDefined(var_1)) {
    level thread[[var_1]]();
    return;
  }
}

function disable_repeating_event(var_0) {
  level notify("stop_repeating_event_" + var_0);
}

function check_prerequisites_then_start_event(var_0, var_1, var_2) {
  level endon("game_ended");
  wait_for_prerequisites_complete(var_1);
  start_event(var_0, var_2);
}

function start_event(var_0, var_1) {
  if(var_0 == "") {
    return;
  }

  if(getdvarint("scr_events_disable_repeating", 0) != 0) {
    var_1 = "";
  }

  if(!isDefined(var_1)) {
    var_1 = "";
  }

  var_2 = level.objectivestabledata[var_0];

  if(is_event_active(var_2.event_to_stop)) {
    stop_event(var_2.event_to_stop);
  }

  var_3 = get_start_func(var_0);

  if(isDefined(var_3)) {}

  assign_event_location(var_2);

  if(is_event_repeating(var_1)) {
    thread run_repeating_event(level, var_0);
    return;
  }

  debug_message_players("^6 EVENT" + var_0 + "^6RUN");
  level thread scripts\cp\cp_objectives::run_objective(var_0, "global");
}

function is_event_repeating(var_0) {
  return !(var_0 == "");
}

function run_repeating_event(var_0, var_1) {
  level endon("stop_repeating_event_" + var_0);
  var_2 = level.objectivestabledata[var_0];

  for(;;) {
    assign_event_location(var_2);
    level thread scripts\cp\cp_objectives::run_objective(var_0, "global");
    debug_message_players("^6 REPEATING EVENT" + var_0 + "^6RUN");
    var_3 = get_wait_for_repeating_event(var_0);
    var_4 = randomintrange(var_3.min_wait_between_repeat, var_3.max_wait_between_repeat);
    var_5 = 0;

    while(var_5 < var_4) {
      var_5 += 1;

      if(getdvarint("scr_events_1s_repeat", 0) != 0) {
        var_5 = var_4;
      }

      wait 1;
    }

    level thread scripts\cp\cp_objectives::defaultcompleteobjective(var_2);
    level notify("debug_beat_" + var_2.ref + "_objective");
    wait 5;
  }
}

function get_wait_for_repeating_event(var_0) {
  return level.wait_for_repeating_event[var_0];
}

function mark_event_active(var_0, var_1) {
  level.event_director.registered_events[var_0].active = var_1;
}

function is_event_active(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = level.event_director.registered_events[var_0];

  if(isDefined(var_1)) {
    return istrue(var_1.active);
  }

  return 0;
}

function mark_event_completed(var_0) {
  scripts\engine\utility::flag_set("event_" + var_0 + "_completed");
}

function is_event_completed(var_0) {
  return scripts\engine\utility::flag("event_" + var_0 + "_completed");
}

function wait_for_event_complete(var_0) {
  scripts\engine\utility::flag_wait("event_" + var_0 + "_completed");
}

function get_init_func(var_0) {
  return level.event_director.registered_events[var_0].init_func;
}

function get_start_func(var_0) {
  return level.event_director.registered_events[var_0].start_func;
}

function get_stop_func(var_0) {
  return level.event_director.registered_events[var_0].stop_func;
}

function get_event_location(var_0) {
  return level.event_director.registered_events[var_0].location;
}

function waittill_reaching_time_stamp(var_0, var_1) {
  var_2 = convert_time_stamp_to_sec(var_1);
  var_3 = var_2 - var_0;
  wait var_3;
  return var_0 + var_3;
}

function convert_time_stamp_to_sec(var_0) {
  var_1 = strtok(var_0, ":");
  var_2 = int(var_1[0]);
  var_3 = int(var_1[1]);
  return 60 * var_2 + var_3;
}

function wait_for_prerequisites_complete(var_0) {
  var_1 = strtok(var_0, ",");
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(var_1[0])) {
    var_2 = "event_" + var_1[0] + "_completed";
  }

  if(isDefined(var_1[1])) {
    var_3 = "event_" + var_1[1] + "_completed";
  }

  if(isDefined(var_1[2])) {
    var_4 = "event_" + var_1[2] + "_completed";
  }

  if(isDefined(var_1[3])) {
    var_5 = "event_" + var_1[3] + "_completed";
  }

  scripts\engine\utility::flag_wait_all(var_2, var_3, var_4, var_5);
}

function debug_message_players(var_0) {
  if(getdvarint("scr_events_disable_messages", 0) != 0) {
    return;
  }
}

function debug_show_all_live_events() {
  wait 5;

  for(;;) {
    if(getdvarint("scr_events_show_active", 0) == 0) {
      wait 3;
      continue;
    }

    var_0 = "";

    foreach(var_2 in level.event_director.events) {
      if(istrue(level.event_director.registered_events[var_2.ref].active)) {
        var_0 += ", " + var_2.row_index;
      }
    }

    if(isDefined(var_0) && var_0 != "") {
      debug_message_players(var_0);
    }

    wait 0.5;
  }
}

function debug_start_event_force() {
  wait 3;

  for(;;) {
    if(getDvar("scr_events_force", "") == "") {
      wait 3;
      continue;
    }

    var_0 = getDvar("scr_events_force", "");
    var_1 = level.objectivestabledata[var_0];

    if(!isDefined(var_1)) {
      debug_message_players("Invalid Event Name: " + var_0);
      setDvar("scr_events_force", "");
      continue;
    }

    if(is_event_active(var_0)) {
      debug_message_players(var_0 + " is active already");
      setDvar("scr_events_force", "");
      continue;
    }

    force_start_event_non_repeating(var_0);
    setDvar("scr_events_force", "");
  }
}

function force_start_event_non_repeating(var_0) {
  if(is_event_active(var_0)) {
    return;
  }

  var_1 = level.objectivestabledata[var_0];

  if(!isDefined(var_1)) {
    return;
  }

  mark_event_active(var_0, 1);
  var_2 = get_init_func(var_0);

  if(isDefined(var_2)) {
    level[[var_2]](var_1);
  }

  start_event(var_0, "");
}

function debug_stop_event_force() {
  wait 3;

  for(;;) {
    if(getDvar("scr_events_stop", "") == "") {
      wait 3;
      continue;
    }

    var_0 = getDvar("scr_events_stop", "");
    var_1 = level.objectivestabledata[var_0];

    if(!isDefined(var_1)) {
      debug_message_players("Invalid Event Name: " + var_0);
      setDvar("scr_events_stop", "");
      continue;
    }

    if(!is_event_active(var_0)) {
      debug_message_players(var_0 + " is not running");
      setDvar("scr_events_stop", "");
      continue;
    }

    stop_event(var_0);
    setDvar("scr_events_stop", "");
  }
}