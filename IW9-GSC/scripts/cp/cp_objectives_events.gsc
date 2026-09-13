/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_objectives_events.gsc
***********************************************/

init() {
  level.event_director = spawnStruct();
  level.event_director.registered_events = [];

  if(!isDefined(level.globalobjectives))
    level.globalobjectives = [];
}

register_event(name, start_func, stop_func, init_func) {
  _id_BD00EBB44A0208E0 = spawnStruct();
  _id_BD00EBB44A0208E0.start_func = start_func;
  _id_BD00EBB44A0208E0.stop_func = stop_func;
  _id_BD00EBB44A0208E0.init_func = init_func;
  _id_BD00EBB44A0208E0.available = 1;
  _id_BD00EBB44A0208E0.active = 0;
  scripts\engine\utility::flag_init("event_" + name + "_completed");
  level.event_director.registered_events[name] = _id_BD00EBB44A0208E0;
}

run(_id_6BBBFBEB60E7E110) {
  if(getdvarint("dvar_3D8A77F6192D51DD", 0) != 0) {
    return;
  }
  level thread start_event_director(_id_6BBBFBEB60E7E110);
}

start_event_director(_id_6BBBFBEB60E7E110) {
  level endon("game_ended");
  row_index = 1;
  level.event_table_ref = _id_6BBBFBEB60E7E110;

  for(_id_655FB8B3FB126D72 = int(tablelookup(_id_6BBBFBEB60E7E110, 0, "maxid", 1)); row_index <= _id_655FB8B3FB126D72; row_index++) {
    event_to_stop = tablelookup(_id_6BBBFBEB60E7E110, 0, row_index + "", 5);
    _id_334956874D1FA70E = tablelookup(_id_6BBBFBEB60E7E110, 0, row_index + "", 2);
    objstruct = spawnStruct();
    objstruct.index = int(0);
    objstruct.row_index = row_index;
    objstruct.ref = tablelookup(_id_6BBBFBEB60E7E110, 0, row_index + "", 2);
    objstruct.activatestring = tablelookup(_id_6BBBFBEB60E7E110, 0, row_index + "", 7);
    objstruct.objicon = tablelookup(_id_6BBBFBEB60E7E110, 0, row_index + "", 8);
    objstruct.label = tablelookup(_id_6BBBFBEB60E7E110, 0, row_index + "", 9);

    if(isDefined(level.objectivestabledata[objstruct.ref]) && isDefined(level.objectivestabledata[objstruct.ref].questtype))
      objstruct.questtype = level.objectivestabledata[objstruct.ref].questtype;
    else
      objstruct.questtype = "global";

    objstruct.timer1 = int(tablelookup(_id_6BBBFBEB60E7E110, 0, row_index + "", 11));
    objstruct.timer2 = int(tablelookup(_id_6BBBFBEB60E7E110, 0, row_index + "", 12));
    objstruct.timer3 = int(tablelookup(_id_6BBBFBEB60E7E110, 0, row_index + "", 13));
    objstruct.showobjprogress = int(tablelookup(_id_6BBBFBEB60E7E110, 0, row_index + "", 14));
    objstruct.points = int(tablelookup(_id_6BBBFBEB60E7E110, 0, row_index + "", 15));
    objstruct.time_stamp = tablelookup(_id_6BBBFBEB60E7E110, 0, row_index + "", 1);
    objstruct.associated_table = _id_6BBBFBEB60E7E110;
    objstruct.event_to_stop = event_to_stop;
    repeat = tablelookup(_id_6BBBFBEB60E7E110, 0, row_index + "", 3);
    objstruct.repeat = repeat;
    assign_event_location(objstruct);
    objstruct.showobjprogressbackup = objstruct.showobjprogress;

    if(objstruct.activatestring == "")
      objstruct.activatestring = undefined;

    if(!isDefined(objstruct.activatestring) && !isDefined(objstruct.objicon) && !isDefined(objstruct.iconpos))
      objstruct.noobjective = 1;

    level.globalobjectives[level.globalobjectives.size] = objstruct;
    level.objectivestabledata[_id_334956874D1FA70E] = objstruct;
    level.event_director.events[_id_334956874D1FA70E] = objstruct;
    register_objective(_id_334956874D1FA70E);
  }

  level thread debug_show_all_live_events();
  level thread debug_start_event_force();
  level thread debug_stop_event_force();
}

assign_event_location(objstruct) {
  iconposref = tablelookup(objstruct.associated_table, 0, objstruct.row_index + "", 10);

  if(!isDefined(iconposref)) {
    return;
  }
  _id_0846CA06C527078A = strtok(iconposref, ",");
  iconpos = undefined;

  if(_id_0846CA06C527078A.size == 3)
    iconpos = (int(_id_0846CA06C527078A[0]), int(_id_0846CA06C527078A[1]), int(_id_0846CA06C527078A[2]));
  else if(_id_0846CA06C527078A.size == 2) {
    iconpos = scripts\engine\utility::getStructArray(_id_0846CA06C527078A[0], _id_0846CA06C527078A[1]);

    if(!isDefined(iconpos))
      iconpos = getEntArray(iconposref, _id_0846CA06C527078A[1]);

    if(!isDefined(iconpos) || iconpos.size == 0)
      iconpos = getEntArray(_id_0846CA06C527078A[0], _id_0846CA06C527078A[1]);
  }

  if(isDefined(iconpos)) {
    if(isvector(iconpos))
      objstruct.iconpos = iconpos;
    else if(isarray(iconpos)) {
      objstruct.iconpos = [];

      foreach(item in iconpos) {
        objstruct.iconpos[objstruct.iconpos.size] = item.origin;
        objstruct.interactionstruct = item;
        item.objectivestruct = objstruct;
      }
    } else
      objstruct.iconpos = iconpos.origin;
  } else
    objstruct.iconpos = iconpos;
}

register_objective(name) {
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

run_through_timestamps() {
  if(getdvarint("dvar_CFD80682D8B66B27", 0) != 0) {
    return;
  }
  _id_B497E19421070AE9 = 0;

  foreach(_id_5125C340EACE0872 in level.event_director.events) {
    if(isDefined(_id_5125C340EACE0872.time_stamp) && _id_5125C340EACE0872.time_stamp != "")
      level thread thread_timestamped_events(_id_B497E19421070AE9, _id_5125C340EACE0872);
  }
}

thread_timestamped_events(_id_B497E19421070AE9, _id_5125C340EACE0872) {
  if(waittill_reaching_time_stamp(_id_B497E19421070AE9, _id_5125C340EACE0872.time_stamp))
    try_start_event(_id_5125C340EACE0872.ref, _id_5125C340EACE0872.associated_table, _id_5125C340EACE0872.row_index);
}

try_start_event(event, _id_6BBBFBEB60E7E110, row_index) {
  if(event == "") {
    return;
  }
  if(getDvar("dvar_1B8E295DD908DD7C", "") != "") {
    if(getDvar("dvar_1B8E295DD908DD7C", "") != level.objectivestabledata[event].ref)
      return;
  }

  if(getdvarint("dvar_3D8A77F6192D51DD", 0) != 0) {
    return;
  }
  if(!isDefined(_id_6BBBFBEB60E7E110))
    _id_6BBBFBEB60E7E110 = level.event_table_ref;

  _id_B3DA61E297C69198 = level.objectivestabledata[event];
  repeat = _id_B3DA61E297C69198.repeat;

  if(!isDefined(row_index))
    row_index = _id_B3DA61E297C69198.row_index;

  try_update_wait_for_repeating_event(event, repeat);

  if(is_event_active(event)) {
    return;
  }
  mark_event_active(event, 1);
  try_run_init_of_event(event);
  _id_AD0353179FEFBE5C = tablelookup(_id_6BBBFBEB60E7E110, 0, row_index + "", 4);

  if(_id_AD0353179FEFBE5C != "")
    level thread check_prerequisites_then_start_event(event, _id_AD0353179FEFBE5C, repeat);
  else
    level thread start_event(event, repeat);
}

try_run_init_of_event(event) {
  level endon("stop_repeating_event_" + event);
  _id_B3DA61E297C69198 = level.objectivestabledata[event];
  init_func = get_init_func(event);

  if(isDefined(init_func))
    level[[init_func]](_id_B3DA61E297C69198);
}

try_update_wait_for_repeating_event(event, repeat) {
  if(!isDefined(repeat) || repeat == "") {
    return;
  }
  _id_699EF6A27CBEAC32 = strtok(repeat, ",");
  min_wait_between_repeat = int(_id_699EF6A27CBEAC32[0]);
  max_wait_between_repeat = int(_id_699EF6A27CBEAC32[1]);
  update_wait_for_repeating_event(event, min_wait_between_repeat, max_wait_between_repeat);
}

update_wait_for_repeating_event(event, min_wait_between_repeat, max_wait_between_repeat) {
  if(!isDefined(level.wait_for_repeating_event))
    level.wait_for_repeating_event = [];

  wait_for_repeating_event = spawnStruct();
  wait_for_repeating_event.min_wait_between_repeat = min_wait_between_repeat;
  wait_for_repeating_event.max_wait_between_repeat = max_wait_between_repeat;
  level.wait_for_repeating_event[event] = wait_for_repeating_event;
}

stop_event(event) {
  if(event == "") {
    return;
  }
  if(!is_event_active(event)) {
    return;
  }
  debug_message_players("^6 STOP EVENT " + event);
  mark_event_active(event, 0);
  stop_func = get_stop_func(event);
  _id_B3DA61E297C69198 = level.objectivestabledata[event];

  if(is_event_completed(event)) {
    if(isDefined(_id_B3DA61E297C69198.points) && _id_B3DA61E297C69198.points > 0) {
      foreach(player in level.players)
      player _id_3BCAA2CBAF54ABDD::give_player_currency(_id_B3DA61E297C69198.points, "large");
    }
  }

  repeat = _id_B3DA61E297C69198.repeat;
  _id_B3DA61E297C69198 = level.objectivestabledata[event];
  level thread scripts\cp\cp_objectives::defaultcompleteobjective(_id_B3DA61E297C69198);
  level notify("debug_beat_" + _id_B3DA61E297C69198.ref + "_objective");

  if(isDefined(stop_func))
    level thread[[stop_func]]();
}

disable_repeating_event(event) {
  level notify("stop_repeating_event_" + event);
}

check_prerequisites_then_start_event(event, _id_AD0353179FEFBE5C, repeat) {
  level endon("game_ended");
  wait_for_prerequisites_complete(_id_AD0353179FEFBE5C);
  start_event(event, repeat);
}

start_event(event, repeat) {
  if(event == "") {
    return;
  }
  if(getdvarint("dvar_9534E61F8FB26D17", 0) != 0)
    repeat = "";

  if(!isDefined(repeat))
    repeat = "";

  _id_B3DA61E297C69198 = level.objectivestabledata[event];

  if(is_event_active(_id_B3DA61E297C69198.event_to_stop))
    stop_event(_id_B3DA61E297C69198.event_to_stop);

  start_func = get_start_func(event);

  if(!isDefined(start_func)) {}

  assign_event_location(_id_B3DA61E297C69198);

  if(is_event_repeating(repeat))
    level thread run_repeating_event(event, start_func);
  else {
    debug_message_players("^6 EVENT" + event + "^6RUN");
    level thread scripts\cp\cp_objectives::run_objective(event, "global");
  }
}

is_event_repeating(repeat) {
  return !(repeat == "");
}

run_repeating_event(event, start_func) {
  level endon("stop_repeating_event_" + event);
  _id_B3DA61E297C69198 = level.objectivestabledata[event];

  for(;;) {
    assign_event_location(_id_B3DA61E297C69198);
    level thread scripts\cp\cp_objectives::run_objective(event, "global");
    debug_message_players("^6 REPEATING EVENT" + event + "^6RUN");
    wait_time = get_wait_for_repeating_event(event);
    _id_7A4D89B99942D23C = randomintrange(wait_time.min_wait_between_repeat, wait_time.max_wait_between_repeat);
    start_time = 0;

    while(start_time < _id_7A4D89B99942D23C) {
      start_time = start_time + 1;

      if(getdvarint("dvar_E8EFC5EF84D24077", 0) != 0)
        start_time = _id_7A4D89B99942D23C;

      wait 1;
    }

    level thread scripts\cp\cp_objectives::defaultcompleteobjective(_id_B3DA61E297C69198);
    level notify("debug_beat_" + _id_B3DA61E297C69198.ref + "_objective");
    wait 5;
  }
}

get_wait_for_repeating_event(event) {
  return level.wait_for_repeating_event[event];
}

mark_event_active(event, value) {
  level.event_director.registered_events[event].active = value;
}

is_event_active(event) {
  if(!isDefined(event))
    return 0;

  _id_0351783D44AE6D6E = level.event_director.registered_events[event];

  if(isDefined(_id_0351783D44AE6D6E))
    return istrue(_id_0351783D44AE6D6E.active);
  else
    return 0;
}

mark_event_completed(event) {
  scripts\engine\utility::flag_set("event_" + event + "_completed");
}

is_event_completed(event) {
  return scripts\engine\utility::flag("event_" + event + "_completed");
}

wait_for_event_complete(event) {
  scripts\engine\utility::flag_wait("event_" + event + "_completed");
}

get_init_func(event) {
  return level.event_director.registered_events[event].init_func;
}

get_start_func(event) {
  return level.event_director.registered_events[event].start_func;
}

get_stop_func(event) {
  return level.event_director.registered_events[event].stop_func;
}

get_event_location(event) {
  return level.event_director.registered_events[event].location;
}

waittill_reaching_time_stamp(_id_B497E19421070AE9, time_stamp) {
  _id_3A4F16DB447A1938 = convert_time_stamp_to_sec(time_stamp);
  _id_2842477F729E001A = _id_3A4F16DB447A1938 - _id_B497E19421070AE9;
  wait(_id_2842477F729E001A);
  return _id_B497E19421070AE9 + _id_2842477F729E001A;
}

convert_time_stamp_to_sec(time_stamp) {
  _id_F4DE06A41A449C8C = strtok(time_stamp, ":");
  _id_C73C4CECD342CA9D = int(_id_F4DE06A41A449C8C[0]);
  _id_8AAC3EFABCD3A679 = int(_id_F4DE06A41A449C8C[1]);
  return 60 * _id_C73C4CECD342CA9D + _id_8AAC3EFABCD3A679;
}

wait_for_prerequisites_complete(_id_AD0353179FEFBE5C) {
  _id_E836C4F0DD6C3B14 = strtok(_id_AD0353179FEFBE5C, ",");
  _id_3F758AA7AF64A72F = undefined;
  _id_3F758BA7AF64A962 = undefined;
  _id_3F758CA7AF64AB95 = undefined;
  _id_3F7585A7AF649C30 = undefined;

  if(isDefined(_id_E836C4F0DD6C3B14[0]))
    _id_3F758AA7AF64A72F = "event_" + _id_E836C4F0DD6C3B14[0] + "_completed";

  if(isDefined(_id_E836C4F0DD6C3B14[1]))
    _id_3F758BA7AF64A962 = "event_" + _id_E836C4F0DD6C3B14[1] + "_completed";

  if(isDefined(_id_E836C4F0DD6C3B14[2]))
    _id_3F758CA7AF64AB95 = "event_" + _id_E836C4F0DD6C3B14[2] + "_completed";

  if(isDefined(_id_E836C4F0DD6C3B14[3]))
    _id_3F7585A7AF649C30 = "event_" + _id_E836C4F0DD6C3B14[3] + "_completed";

  scripts\engine\utility::flag_wait_all(_id_3F758AA7AF64A72F, _id_3F758BA7AF64A962, _id_3F758CA7AF64AB95, _id_3F7585A7AF649C30);
}

debug_message_players(message) {
  if(getdvarint("dvar_BC947870DB205BC2", 0) != 0)
    return;
}

debug_show_all_live_events() {
  wait 5;

  for(;;) {
    if(getdvarint("dvar_79CD1956718D291D", 0) == 0) {
      wait 3;
      continue;
    }

    text = "";

    foreach(event in level.event_director.events) {
      if(istrue(level.event_director.registered_events[event.ref].active))
        text = text + (", " + event.row_index);
    }

    if(isDefined(text) && text != "")
      debug_message_players(text);

    wait 0.5;
  }
}

debug_start_event_force() {
  wait 3;

  for(;;) {
    if(getDvar("dvar_C0CF4761BD0512D6", "") == "") {
      wait 3;
      continue;
    } else {
      event = getDvar("dvar_C0CF4761BD0512D6", "");
      _id_B3DA61E297C69198 = level.objectivestabledata[event];

      if(!isDefined(_id_B3DA61E297C69198)) {
        debug_message_players("Invalid Event Name: " + event);
        setDvar("dvar_C0CF4761BD0512D6", "");
        continue;
      }

      if(is_event_active(event)) {
        debug_message_players(event + " is active already");
        setDvar("dvar_C0CF4761BD0512D6", "");
        continue;
      }

      force_start_event_non_repeating(event);
      setDvar("dvar_C0CF4761BD0512D6", "");
    }
  }
}

force_start_event_non_repeating(event) {
  if(is_event_active(event)) {
    return;
  }
  _id_B3DA61E297C69198 = level.objectivestabledata[event];

  if(!isDefined(_id_B3DA61E297C69198)) {
    return;
  }
  mark_event_active(event, 1);
  init_func = get_init_func(event);

  if(isDefined(init_func))
    level[[init_func]](_id_B3DA61E297C69198);

  start_event(event, "");
}

debug_stop_event_force() {
  wait 3;

  for(;;) {
    if(getDvar("dvar_412D320DF65398C3", "") == "") {
      wait 3;
      continue;
    } else {
      event = getDvar("dvar_412D320DF65398C3", "");
      _id_B3DA61E297C69198 = level.objectivestabledata[event];

      if(!isDefined(_id_B3DA61E297C69198)) {
        debug_message_players("Invalid Event Name: " + event);
        setDvar("dvar_412D320DF65398C3", "");
        continue;
      }

      if(!is_event_active(event)) {
        debug_message_players(event + " is not running");
        setDvar("dvar_412D320DF65398C3", "");
        continue;
      }

      stop_event(event);
      setDvar("dvar_412D320DF65398C3", "");
    }
  }
}