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

function register_event(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var4.start_func = var1;
  var4.stop_func = var2;
  var4.init_func = var3;
  var4.available = 1;
  var4.active = 0;
  scripts\engine\utility::flag_init("event_" + var0 + "_completed");
  level.event_director.registered_events[var0] = var4;
}

function run(var0) {
  if(getdvarint("scr_events_disable", 0) != 0) {
    return;
  }

  thread start_event_director(level);
}

function start_event_director(var0) {
  level endon("game_ended");
  var1 = 1;
  level.event_table_ref = var0;
  var2 = int(tablelookup(var0, 0, "maxid", 1));

  while(var1 <= var2) {
    var3 = tablelookup(var0, 0, var1 + "", 5);
    var4 = tablelookup(var0, 0, var1 + "", 2);
    var5 = spawnStruct();
    var5.index = int(0);
    var5.row_index = var1;
    var5.ref = tablelookup(var0, 0, var1 + "", 2);
    var5.activatestring = tablelookup(var0, 0, var1 + "", 7);
    var5.objicon = tablelookup(var0, 0, var1 + "", 8);
    var5.label = tablelookup(var0, 0, var1 + "", 9);

    if(isDefined(level.objectivestabledata[var5.ref]) && isDefined(level.objectivestabledata[var5.ref].questtype)) {
      var5.questtype = level.objectivestabledata[var5.ref].questtype;
    } else {
      var5.questtype = "global";
    }

    var5.timer1 = int(tablelookup(var0, 0, var1 + "", 11));
    var5.timer2 = int(tablelookup(var0, 0, var1 + "", 12));
    var5.timer3 = int(tablelookup(var0, 0, var1 + "", 13));
    var5.showobjprogress = int(tablelookup(var0, 0, var1 + "", 14));
    var5.points = int(tablelookup(var0, 0, var1 + "", 15));
    var5.time_stamp = tablelookup(var0, 0, var1 + "", 1);
    var5.associated_table = var0;
    var5.event_to_stop = var3;
    var6 = tablelookup(var0, 0, var1 + "", 3);
    var5.repeat = var6;
    assign_event_location(var5);
    var5.showobjprogressbackup = var5.showobjprogress;

    if(var5.activatestring == "") {
      var5.activatestring = undefined;
    }

    if(!isDefined(var5.activatestring) && !isDefined(var5.objicon) && !isDefined(var5.iconpos)) {
      var5.noobjective = 1;
    }

    level.globalobjectives[level.globalobjectives.size] = var5;
    level.objectivestabledata[var4] = var5;
    level.event_director.events[var4] = var5;
    register_objective(var4);
    var1++;
  }

  thread debug_show_all_live_events();
  thread debug_start_event_force();
  thread debug_stop_event_force();
}

function assign_event_location(var0) {
  var1 = tablelookup(var0.associated_table, 0, var0.row_index + "", 10);

  if(!isDefined(var1)) {
    return;
  }

  var2 = strtok(var1, ",");
  var3 = undefined;

  if(var2.size == 3) {
    var3 = (int(var2[0]), int(var2[1]), int(var2[2]));
  } else if(var2.size == 2) {
    var3 = scripts\engine\utility::getStructArray(var2[0], var2[1]);

    if(!isDefined(var3)) {
      var3 = getEntArray(var1, var2[1]);
    }

    if(!isDefined(var3) || var3.size == 0) {
      var3 = getEntArray(var2[0], var2[1]);
    }
  }

  if(isDefined(var3)) {
    if(isvector(var3)) {
      var0.iconpos = var3;
      return;
    }

    if(isarray(var3)) {
      var0.iconpos = [];

      foreach(var5 in var3) {
        var0.iconpos[var0.iconpos.size] = var5.origin;
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

function delete_old_objective_location(var0) {
  var1 = scripts\engine\utility::getStruct(var0, "targetname");

  if(isDefined(var1)) {
    if(scripts\engine\utility::array_contains(level.struct_class_names["targetname"][var0], var1)) {
      level.struct_class_names["targetname"][var0] = scripts\engine\utility::array_remove(level.struct_class_names["targetname"][var0], var1);
    }

    var1 = undefined;
    return;
  }
}

function register_objective(var0) {
  if(!isDefined(level.event_director.registered_events)) {
    return;
  }

  if(!isDefined(level.event_director.registered_events[var0])) {
    return;
  }

  var1 = level.event_director.registered_events[var0].start_func;
  var2 = level.event_director.registered_events[var0].end_func;
  scripts\cp\cp_objectives::registerobjective(var0, undefined, var1, var2);
}

function run_through_timestamps() {
  if(getdvarint("scr_events_disable_timestamps", 0) != 0) {
    return;
  }

  var0 = 0;

  foreach(var2 in level.event_director.events) {
    if(isDefined(var2.time_stamp) && var2.time_stamp != "") {
      thread thread_timestamped_events(level, var0);
    }
  }
}

function thread_timestamped_events(var0, var1) {
  if(waittill_reaching_time_stamp(var0, var1.time_stamp)) {
    try_start_event(var1.ref, var1.associated_table, var1.row_index);
    return;
  }
}

function try_start_event(var0, var1, var2) {
  if(var0 == "") {
    return;
  }

  if(getDvar("scr_events_isolate", "") != "") {
    if(getDvar("scr_events_isolate", "") != level.objectivestabledata[var0].ref) {
      return;
    }
  }

  if(getdvarint("scr_events_disable", 0) != 0) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = level.event_table_ref;
  }

  var3 = level.objectivestabledata[var0];
  var4 = var3.repeat;

  if(!isDefined(var2)) {
    var2 = var3.row_index;
  }

  try_update_wait_for_repeating_event(var0, var4);

  if(is_event_active(var0)) {
    return;
  }

  mark_event_active(var0, 1);
  try_run_init_of_event(var0);
  var5 = tablelookup(var1, 0, var2 + "", 4);

  if(var5 != "") {
    thread check_prerequisites_then_start_event(level, var0, var5);
    return;
  }

  thread start_event(level, var0);
}

function try_run_init_of_event(var0) {
  level endon("stop_repeating_event_" + var0);
  var1 = level.objectivestabledata[var0];
  var2 = get_init_func(var0);

  if(isDefined(var2)) {
    level[[var2]](var1);
    return;
  }
}

function try_update_wait_for_repeating_event(var0, var1) {
  if(!isDefined(var1) || var1 == "") {
    return;
  }

  var2 = strtok(var1, ",");
  var3 = int(var2[0]);
  var4 = int(var2[1]);
  update_wait_for_repeating_event(var0, var3, var4);
}

function update_wait_for_repeating_event(var0, var1, var2) {
  if(!isDefined(level.wait_for_repeating_event)) {
    level.wait_for_repeating_event = [];
  }

  var3 = spawnStruct();
  var3.min_wait_between_repeat = var1;
  var3.max_wait_between_repeat = var2;
  level.wait_for_repeating_event[var0] = var3;
}

function stop_event(var0) {
  if(var0 == "") {
    return;
  }

  if(!is_event_active(var0)) {
    return;
  }

  debug_message_players("^6 STOP EVENT " + var0);
  mark_event_active(var0, 0);
  var1 = get_stop_func(var0);
  var2 = level.objectivestabledata[var0];

  if(is_event_completed(var0)) {
    if(isDefined(var2.points) && var2.points > 0) {
      foreach(var4 in level.players) {
        var4 scripts\cp\cp_persistence::give_player_currency(var2.points, "large");
      }
    }
  }

  var6 = var2.repeat;
  var2 = level.objectivestabledata[var0];
  level thread scripts\cp\cp_objectives::defaultcompleteobjective(var2);
  level notify("debug_beat_" + var2.ref + "_objective");

  if(isDefined(var1)) {
    level thread[[var1]]();
    return;
  }
}

function disable_repeating_event(var0) {
  level notify("stop_repeating_event_" + var0);
}

function check_prerequisites_then_start_event(var0, var1, var2) {
  level endon("game_ended");
  wait_for_prerequisites_complete(var1);
  start_event(var0, var2);
}

function start_event(var0, var1) {
  if(var0 == "") {
    return;
  }

  if(getdvarint("scr_events_disable_repeating", 0) != 0) {
    var1 = "";
  }

  if(!isDefined(var1)) {
    var1 = "";
  }

  var2 = level.objectivestabledata[var0];

  if(is_event_active(var2.event_to_stop)) {
    stop_event(var2.event_to_stop);
  }

  var3 = get_start_func(var0);

  if(isDefined(var3)) {}

  assign_event_location(var2);

  if(is_event_repeating(var1)) {
    thread run_repeating_event(level, var0);
    return;
  }

  debug_message_players("^6 EVENT" + var0 + "^6RUN");
  level thread scripts\cp\cp_objectives::run_objective(var0, "global");
}

function is_event_repeating(var0) {
  return !(var0 == "");
}

function run_repeating_event(var0, var1) {
  level endon("stop_repeating_event_" + var0);
  var2 = level.objectivestabledata[var0];

  for(;;) {
    assign_event_location(var2);
    level thread scripts\cp\cp_objectives::run_objective(var0, "global");
    debug_message_players("^6 REPEATING EVENT" + var0 + "^6RUN");
    var3 = get_wait_for_repeating_event(var0);
    var4 = randomintrange(var3.min_wait_between_repeat, var3.max_wait_between_repeat);
    var5 = 0;

    while(var5 < var4) {
      var5 += 1;

      if(getdvarint("scr_events_1s_repeat", 0) != 0) {
        var5 = var4;
      }

      wait 1;
    }

    level thread scripts\cp\cp_objectives::defaultcompleteobjective(var2);
    level notify("debug_beat_" + var2.ref + "_objective");
    wait 5;
  }
}

function get_wait_for_repeating_event(var0) {
  return level.wait_for_repeating_event[var0];
}

function mark_event_active(var0, var1) {
  level.event_director.registered_events[var0].active = var1;
}

function is_event_active(var0) {
  if(!isDefined(var0)) {
    return 0;
  }

  var1 = level.event_director.registered_events[var0];

  if(isDefined(var1)) {
    return istrue(var1.active);
  }

  return 0;
}

function mark_event_completed(var0) {
  scripts\engine\utility::flag_set("event_" + var0 + "_completed");
}

function is_event_completed(var0) {
  return scripts\engine\utility::flag("event_" + var0 + "_completed");
}

function wait_for_event_complete(var0) {
  scripts\engine\utility::flag_wait("event_" + var0 + "_completed");
}

function get_init_func(var0) {
  return level.event_director.registered_events[var0].init_func;
}

function get_start_func(var0) {
  return level.event_director.registered_events[var0].start_func;
}

function get_stop_func(var0) {
  return level.event_director.registered_events[var0].stop_func;
}

function get_event_location(var0) {
  return level.event_director.registered_events[var0].location;
}

function waittill_reaching_time_stamp(var0, var1) {
  var2 = convert_time_stamp_to_sec(var1);
  var3 = var2 - var0;
  wait var3;
  return var0 + var3;
}

function convert_time_stamp_to_sec(var0) {
  var1 = strtok(var0, ":");
  var2 = int(var1[0]);
  var3 = int(var1[1]);
  return 60 * var2 + var3;
}

function wait_for_prerequisites_complete(var0) {
  var1 = strtok(var0, ",");
  var2 = undefined;
  var3 = undefined;
  var4 = undefined;
  var5 = undefined;

  if(isDefined(var1[0])) {
    var2 = "event_" + var1[0] + "_completed";
  }

  if(isDefined(var1[1])) {
    var3 = "event_" + var1[1] + "_completed";
  }

  if(isDefined(var1[2])) {
    var4 = "event_" + var1[2] + "_completed";
  }

  if(isDefined(var1[3])) {
    var5 = "event_" + var1[3] + "_completed";
  }

  scripts\engine\utility::flag_wait_all(var2, var3, var4, var5);
}

function debug_message_players(var0) {
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

    var0 = "";

    foreach(var2 in level.event_director.events) {
      if(istrue(level.event_director.registered_events[var2.ref].active)) {
        var0 += ", " + var2.row_index;
      }
    }

    if(isDefined(var0) && var0 != "") {
      debug_message_players(var0);
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

    var0 = getDvar("scr_events_force", "");
    var1 = level.objectivestabledata[var0];

    if(!isDefined(var1)) {
      debug_message_players("Invalid Event Name: " + var0);
      setDvar("scr_events_force", "");
      continue;
    }

    if(is_event_active(var0)) {
      debug_message_players(var0 + " is active already");
      setDvar("scr_events_force", "");
      continue;
    }

    force_start_event_non_repeating(var0);
    setDvar("scr_events_force", "");
  }
}

function force_start_event_non_repeating(var0) {
  if(is_event_active(var0)) {
    return;
  }

  var1 = level.objectivestabledata[var0];

  if(!isDefined(var1)) {
    return;
  }

  mark_event_active(var0, 1);
  var2 = get_init_func(var0);

  if(isDefined(var2)) {
    level[[var2]](var1);
  }

  start_event(var0, "");
}

function debug_stop_event_force() {
  wait 3;

  for(;;) {
    if(getDvar("scr_events_stop", "") == "") {
      wait 3;
      continue;
    }

    var0 = getDvar("scr_events_stop", "");
    var1 = level.objectivestabledata[var0];

    if(!isDefined(var1)) {
      debug_message_players("Invalid Event Name: " + var0);
      setDvar("scr_events_stop", "");
      continue;
    }

    if(!is_event_active(var0)) {
      debug_message_players(var0 + " is not running");
      setDvar("scr_events_stop", "");
      continue;
    }

    stop_event(var0);
    setDvar("scr_events_stop", "");
  }
}