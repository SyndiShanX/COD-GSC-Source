/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_objectives_events.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\cp\cp_objectives;
#using scripts\cp\persistence;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace cp_objectives_events;

function init() {
  level.event_director = spawnStruct();
  level.event_director.registered_events = [];

  if(!isDefined(level.globalobjectives)) {
    level.globalobjectives = [];
  }
}

function register_event(name, start_func, stop_func, init_func) {
  event_info = spawnStruct();
  event_info.start_func = start_func;
  event_info.stop_func = stop_func;
  event_info.init_func = init_func;
  event_info.available = 1;
  event_info.active = 0;
  scripts\engine\utility::flag_init("event_" + name + "_completed");
  level.event_director.registered_events[name] = event_info;
}

function run(event_table) {
  if(getdvarint(@ "hash_3d8a77f6192d51dd", 0) != 0) {
    return;
  }

  level thread start_event_director(event_table);
}

function start_event_director(event_table) {
  level endon("game_ended");
  row_index = 1;
  level.event_table_ref = event_table;
  max_row = int(tablelookup(event_table, 0, "maxid", 1));

  while(row_index <= max_row) {
    event_to_stop = tablelookup(event_table, 0, row_index + "", 5);
    var_334956874d1fa70e = tablelookup(event_table, 0, row_index + "", 2);
    objstruct = spawnStruct();
    objstruct.index = int(0);
    objstruct.row_index = row_index;
    objstruct.ref = tablelookup(event_table, 0, row_index + "", 2);
    objstruct.activatestring = tablelookup(event_table, 0, row_index + "", 7);
    objstruct.objicon = tablelookup(event_table, 0, row_index + "", 8);
    objstruct.label = tablelookup(event_table, 0, row_index + "", 9);

    if(isDefined(level.objectivestabledata[objstruct.ref]) && isDefined(level.objectivestabledata[objstruct.ref].questtype)) {
      objstruct.questtype = level.objectivestabledata[objstruct.ref].questtype;
    } else {
      objstruct.questtype = "global";
    }

    objstruct.timer1 = int(tablelookup(event_table, 0, row_index + "", 11));
    objstruct.timer2 = int(tablelookup(event_table, 0, row_index + "", 12));
    objstruct.timer3 = int(tablelookup(event_table, 0, row_index + "", 13));
    objstruct.showobjprogress = int(tablelookup(event_table, 0, row_index + "", 14));
    objstruct.points = int(tablelookup(event_table, 0, row_index + "", 15));
    objstruct.time_stamp = tablelookup(event_table, 0, row_index + "", 1);
    objstruct.associated_table = event_table;
    objstruct.event_to_stop = event_to_stop;
    repeat = tablelookup(event_table, 0, row_index + "", 3);
    objstruct.repeat = repeat;
    assign_event_location(objstruct);
    objstruct.showobjprogressbackup = objstruct.showobjprogress;

    if(objstruct.activatestring == "") {
      objstruct.activatestring = undefined;
    }

    if(!isDefined(objstruct.activatestring) && !isDefined(objstruct.objicon) && !isDefined(objstruct.iconpos)) {
      objstruct.noobjective = 1;
    }

    level.globalobjectives[level.globalobjectives.size] = objstruct;
    level.objectivestabledata[var_334956874d1fa70e] = objstruct;
    level.event_director.events[var_334956874d1fa70e] = objstruct;
    register_objective(var_334956874d1fa70e);
    row_index++;
  }

  level thread debug_show_all_live_events();
  level thread debug_start_event_force();
  level thread debug_stop_event_force();
}

function assign_event_location(objstruct) {
  iconposref = tablelookup(objstruct.associated_table, 0, objstruct.row_index + "", 10);

  if(!isDefined(iconposref)) {
    return;
  }

  var_846ca06c527078a = strtok(iconposref, ",");
  iconpos = undefined;

  if(var_846ca06c527078a.size == 3) {
    iconpos = (int(var_846ca06c527078a[0]), int(var_846ca06c527078a[1]), int(var_846ca06c527078a[2]));
  } else if(var_846ca06c527078a.size == 2) {
    iconpos = getStructArray(var_846ca06c527078a[0], var_846ca06c527078a[1]);

    if(!isDefined(iconpos)) {
      iconpos = getEntArray(iconposref, var_846ca06c527078a[1]);
    }

    if(!isDefined(iconpos) || iconpos.size == 0) {
      iconpos = getEntArray(var_846ca06c527078a[0], var_846ca06c527078a[1]);
    }
  }

  if(isDefined(iconpos)) {
    if(isvector(iconpos)) {
      objstruct.iconpos = iconpos;
    } else if(isarray(iconpos)) {
      objstruct.iconpos = [];

      foreach(item in iconpos) {
        objstruct.iconpos[objstruct.iconpos.size] = item.origin;
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

function register_objective(name) {
  if(!isDefined(level.event_director.registered_events)) {
    return;
  }

  if(!isDefined(level.event_director.registered_events[name])) {
    return;
  }

  start_func = level.event_director.registered_events[name].start_func;
  end_func = level.event_director.registered_events[name].end_func;
  scripts\cp\cp_objectives::registerobjective(name, undefined, start_func, end_func);
}

function run_through_timestamps() {
  if(getdvarint(@ "hash_cfd80682d8b66b27", 0) != 0) {
    return;
  }

  time_passed = 0;

  foreach(eventstruct in level.event_director.events) {
    if(isDefined(eventstruct.time_stamp) && eventstruct.time_stamp != "") {
      level thread thread_timestamped_events(time_passed, eventstruct);
    }
  }
}

function thread_timestamped_events(time_passed, eventstruct) {
  if(waittill_reaching_time_stamp(time_passed, eventstruct.time_stamp)) {
    try_start_event(eventstruct.ref, eventstruct.associated_table, eventstruct.row_index);
  }
}

function try_start_event(event, event_table, row_index) {
  if(event == "") {
    return;
  }

  if(getDvar(@ "hash_1b8e295dd908dd7c", "") != "") {
    if(getDvar(@ "hash_1b8e295dd908dd7c", "") != level.objectivestabledata[event].ref) {
      return;
    }
  }

  if(getdvarint(@ "hash_3d8a77f6192d51dd", 0) != 0) {
    return;
  }

  if(!isDefined(event_table)) {
    event_table = level.event_table_ref;
  }

  var_b3da61e297c69198 = level.objectivestabledata[event];
  repeat = var_b3da61e297c69198.repeat;

  if(!isDefined(row_index)) {
    row_index = var_b3da61e297c69198.row_index;
  }

  try_update_wait_for_repeating_event(event, repeat);

  if(is_event_active(event)) {
    return;
  }

  mark_event_active(event, 1);
  try_run_init_of_event(event);
  prerequisites = tablelookup(event_table, 0, row_index + "", 4);

  if(prerequisites != "") {
    level thread check_prerequisites_then_start_event(event, prerequisites, repeat);
    return;
  }

  level thread start_event(event, repeat);
}

function try_run_init_of_event(event) {
  level endon("stop_repeating_event_" + event);
  var_b3da61e297c69198 = level.objectivestabledata[event];
  init_func = get_init_func(event);

  if(isDefined(init_func)) {
    level[[init_func]](var_b3da61e297c69198);
  }
}

function try_update_wait_for_repeating_event(event, repeat) {
  if(!isDefined(repeat) || repeat == "") {
    return;
  }

  var_699ef6a27cbeac32 = strtok(repeat, ",");
  min_wait_between_repeat = int(var_699ef6a27cbeac32[0]);
  max_wait_between_repeat = int(var_699ef6a27cbeac32[1]);
  update_wait_for_repeating_event(event, min_wait_between_repeat, max_wait_between_repeat);
}

function update_wait_for_repeating_event(event, min_wait_between_repeat, max_wait_between_repeat) {
  if(!isDefined(level.wait_for_repeating_event)) {
    level.wait_for_repeating_event = [];
  }

  wait_for_repeating_event = spawnStruct();
  wait_for_repeating_event.min_wait_between_repeat = min_wait_between_repeat;
  wait_for_repeating_event.max_wait_between_repeat = max_wait_between_repeat;
  level.wait_for_repeating_event[event] = wait_for_repeating_event;
}

function stop_event(event) {
  if(event == "") {
    return;
  }

  if(!is_event_active(event)) {
    return;
  }

  debug_message_players("^6 STOP EVENT " + event);
  mark_event_active(event, 0);
  stop_func = get_stop_func(event);
  var_b3da61e297c69198 = level.objectivestabledata[event];

  if(is_event_completed(event)) {
    if(isDefined(var_b3da61e297c69198.points) && var_b3da61e297c69198.points > 0) {
      foreach(player in level.players) {
        player scripts\cp\persistence::give_player_currency(var_b3da61e297c69198.points, "large");
      }
    }
  }

  repeat = var_b3da61e297c69198.repeat;
  var_b3da61e297c69198 = level.objectivestabledata[event];
  level thread scripts\cp\cp_objectives::defaultcompleteobjective(var_b3da61e297c69198);
  level notify("debug_beat_" + var_b3da61e297c69198.ref + "_objective");

  if(isDefined(stop_func)) {
    level thread[[stop_func]]();
  }
}

function disable_repeating_event(event) {
  level notify("stop_repeating_event_" + event);
}

function check_prerequisites_then_start_event(event, prerequisites, repeat) {
  level endon("game_ended");
  wait_for_prerequisites_complete(prerequisites);
  start_event(event, repeat);
}

function start_event(event, repeat) {
  if(event == "") {
    return;
  }

  if(getdvarint(@ "hash_9534e61f8fb26d17", 0) != 0) {
    repeat = "";
  }

  if(!isDefined(repeat)) {
    repeat = "";
  }

  var_b3da61e297c69198 = level.objectivestabledata[event];

  if(is_event_active(var_b3da61e297c69198.event_to_stop)) {
    stop_event(var_b3da61e297c69198.event_to_stop);
  }

  start_func = get_start_func(event);

  if(!isDefined(start_func)) {
    assertmsg("no start func, event or objective will complete instantly");
  }

  assign_event_location(var_b3da61e297c69198);

  if(is_event_repeating(repeat)) {
    level thread run_repeating_event(event, start_func);
    return;
  }

  debug_message_players("^6 EVENT" + event + "^6RUN");
  level thread scripts\cp\cp_objectives::run_objective(event, "global");
}

function is_event_repeating(repeat) {
  return !(repeat == "");
}

function run_repeating_event(event, start_func) {
  level endon("stop_repeating_event_" + event);
  var_b3da61e297c69198 = level.objectivestabledata[event];

  while(true) {
    assign_event_location(var_b3da61e297c69198);
    level thread scripts\cp\cp_objectives::run_objective(event, "global");
    debug_message_players("^6 REPEATING EVENT" + event + "^6RUN");
    wait_time = get_wait_for_repeating_event(event);
    time_to_wait = randomintrange(wait_time.min_wait_between_repeat, wait_time.max_wait_between_repeat);
    start_time = 0;

    while(start_time < time_to_wait) {
      start_time += 1;

      if(getdvarint(@ "hash_e8efc5ef84d24077", 0) != 0) {
        start_time = time_to_wait;
      }

      wait 1;
    }

    level thread scripts\cp\cp_objectives::defaultcompleteobjective(var_b3da61e297c69198);
    level notify("debug_beat_" + var_b3da61e297c69198.ref + "_objective");
    wait 5;
  }
}

function get_wait_for_repeating_event(event) {
  return level.wait_for_repeating_event[event];
}

function mark_event_active(event, value) {
  level.event_director.registered_events[event].active = value;
}

function is_event_active(event) {
  if(!isDefined(event)) {
    return 0;
  }

  potential_event = level.event_director.registered_events[event];

  if(isDefined(potential_event)) {
    return istrue(potential_event.active);
  }

  return 0;
}

function mark_event_completed(event) {
  scripts\engine\utility::flag_set("event_" + event + "_completed");
}

function is_event_completed(event) {
  return scripts\engine\utility::flag("event_" + event + "_completed");
}

function wait_for_event_complete(event) {
  scripts\engine\utility::flag_wait("event_" + event + "_completed");
}

function get_init_func(event) {
  return level.event_director.registered_events[event].init_func;
}

function get_start_func(event) {
  return level.event_director.registered_events[event].start_func;
}

function get_stop_func(event) {
  return level.event_director.registered_events[event].stop_func;
}

function get_event_location(event) {
  return level.event_director.registered_events[event].location;
}

function waittill_reaching_time_stamp(time_passed, time_stamp) {
  var_3a4f16db447a1938 = convert_time_stamp_to_sec(time_stamp);
  sec_to_wait = var_3a4f16db447a1938 - time_passed;
  wait sec_to_wait;
  return time_passed + sec_to_wait;
}

function convert_time_stamp_to_sec(time_stamp) {
  var_f4de06a41a449c8c = strtok(time_stamp, ":");
  minute = int(var_f4de06a41a449c8c[0]);
  second = int(var_f4de06a41a449c8c[1]);
  return 60 * minute + second;
}

function wait_for_prerequisites_complete(prerequisites) {
  var_e836c4f0dd6c3b14 = strtok(prerequisites, ",");
  var_3f758aa7af64a72f = undefined;
  var_3f758ba7af64a962 = undefined;
  var_3f758ca7af64ab95 = undefined;
  var_3f7585a7af649c30 = undefined;

  if(isDefined(var_e836c4f0dd6c3b14[0])) {
    var_3f758aa7af64a72f = "event_" + var_e836c4f0dd6c3b14[0] + "_completed";
  }

  if(isDefined(var_e836c4f0dd6c3b14[1])) {
    var_3f758ba7af64a962 = "event_" + var_e836c4f0dd6c3b14[1] + "_completed";
  }

  if(isDefined(var_e836c4f0dd6c3b14[2])) {
    var_3f758ca7af64ab95 = "event_" + var_e836c4f0dd6c3b14[2] + "_completed";
  }

  if(isDefined(var_e836c4f0dd6c3b14[3])) {
    var_3f7585a7af649c30 = "event_" + var_e836c4f0dd6c3b14[3] + "_completed";
  }

  scripts\engine\utility::flag_wait_all(var_3f758aa7af64a72f, var_3f758ba7af64a962, var_3f758ca7af64ab95, var_3f7585a7af649c30);
}

function debug_message_players(message) {
  if(getdvarint(@ "hash_bc947870db205bc2", 0) != 0) {
    return;
  }

  foreach(player in level.players) {
    iprintlnbold(message);
  }
}

function debug_show_all_live_events() {
  wait 5;

  while(true) {
    if(getdvarint(@ "hash_79cd1956718d291d", 0) == 0) {
      wait 3;
      continue;
    }

    text = "";

    foreach(event in level.event_director.events) {
      if(istrue(level.event_director.registered_events[event.ref].active)) {
        text += ", " + event.row_index;
      }
    }

    if(isDefined(text) && text != "") {
      debug_message_players(text);
    }

    wait 0.5;
  }
}

function debug_start_event_force() {
  wait 3;

  while(true) {
    if(getDvar(@ "hash_c0cf4761bd0512d6", "") == "") {
      wait 3;
      continue;
    }

    event = getDvar(@ "hash_c0cf4761bd0512d6", "");
    var_b3da61e297c69198 = level.objectivestabledata[event];

    if(!isDefined(var_b3da61e297c69198)) {
      debug_message_players("Invalid Event Name: " + event);
      setDvar(@ "hash_c0cf4761bd0512d6", "");
      continue;
    }

    if(is_event_active(event)) {
      debug_message_players(event + " is active already");
      setDvar(@ "hash_c0cf4761bd0512d6", "");
      continue;
    }

    force_start_event_non_repeating(event);
    setDvar(@ "hash_c0cf4761bd0512d6", "");
  }
}

function force_start_event_non_repeating(event) {
  if(is_event_active(event)) {
    assertmsg("event: " + event + " already running!");
    return;
  }

  var_b3da61e297c69198 = level.objectivestabledata[event];

  if(!isDefined(var_b3da61e297c69198)) {
    assertmsg("event: " + event + " not in objectives Table!");
    return;
  }

  mark_event_active(event, 1);
  init_func = get_init_func(event);

  if(isDefined(init_func)) {
    level[[init_func]](var_b3da61e297c69198);
  }

  start_event(event, "");
}

function debug_stop_event_force() {
  wait 3;

  while(true) {
    if(getDvar(@ "hash_412d320df65398c3", "") == "") {
      wait 3;
      continue;
    }

    event = getDvar(@ "hash_412d320df65398c3", "");
    var_b3da61e297c69198 = level.objectivestabledata[event];

    if(!isDefined(var_b3da61e297c69198)) {
      debug_message_players("Invalid Event Name: " + event);
      setDvar(@ "hash_412d320df65398c3", "");
      continue;
    }

    if(!is_event_active(event)) {
      debug_message_players(event + " is not running");
      setDvar(@ "hash_412d320df65398c3", "");
      continue;
    }

    stop_event(event);
    setDvar(@ "hash_412d320df65398c3", "");
  }
}