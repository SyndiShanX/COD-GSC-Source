/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_objectives_events.gsc
***********************************************/

init() {
  level.event_director = spawnStruct();
  level.event_director.registered_events = [];

  if(!isDefined(level.globalobjectives))
    level.globalobjectives = [];
}

register_event(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.start_func = var_1;
  var_4.stop_func = var_2;
  var_4.init_func = var_3;
  var_4.available = 1;
  var_4.active = 0;
  scripts\engine\utility::flag_init("_encstr_BACE07D36E4F603577" + var_0 + "_encstr_93D80BF536F6B638D8AC1D95C8");
  level.event_director.registered_events[var_0] = var_4;
}

run(var_0) {
  if(getdvarint("_encstr_AACC13E68DE4FA59B359CD1D6E7D234B6E1626B195", 0) != 0) {
    return;
  }
  level thread start_event_director(var_0);
}

start_event_director(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 1;
  level.event_table_ref = var_0;

  for(var_2 = int(tablelookup(var_0, 0, "_encstr_96A40632C9DB4FF7", 1)); var_1 <= var_2; var_1++) {
    var_3 = tablelookup(var_0, 0, var_1 + "_encstr_B40101", 5);
    var_4 = tablelookup(var_0, 0, var_1 + "_encstr_B40101", 2);
    var_5 = spawnStruct();
    var_5.index = int(0);
    var_5.row_index = var_1;
    var_5.ref = tablelookup(var_0, 0, var_1 + "_encstr_B40101", 2);
    var_5.activatestring = tablelookup(var_0, 0, var_1 + "_encstr_B40101", 7);
    var_5.objicon = tablelookup(var_0, 0, var_1 + "_encstr_B40101", 8);
    var_5.label = tablelookup(var_0, 0, var_1 + "_encstr_B40101", 9);

    if(isDefined(level.objectivestabledata[var_5.ref]) && isDefined(level.objectivestabledata[var_5.ref].questtype))
      var_5.questtype = level.objectivestabledata[var_5.ref].questtype;
    else
      var_5.questtype = "_encstr_8A5707E9C2BFCEF0ED";

    var_5.timer1 = int(tablelookup(var_0, 0, var_1 + "_encstr_B40101", 11));
    var_5.timer2 = int(tablelookup(var_0, 0, var_1 + "_encstr_B40101", 12));
    var_5.timer3 = int(tablelookup(var_0, 0, var_1 + "_encstr_B40101", 13));
    var_5.showobjprogress = int(tablelookup(var_0, 0, var_1 + "_encstr_B40101", 14));
    var_5.points = int(tablelookup(var_0, 0, var_1 + "_encstr_B40101", 15));
    var_5.time_stamp = tablelookup(var_0, 0, var_1 + "_encstr_B40101", 1);
    var_5.associated_table = var_0;
    var_5.event_to_stop = var_3;
    var_6 = tablelookup(var_0, 0, var_1 + "_encstr_B40101", 3);
    var_5.repeat = var_6;
    assign_event_location(var_5);
    var_5.showobjprogressbackup = var_5.showobjprogress;

    if(var_5.activatestring == "_encstr_B40101")
      var_5.activatestring = undefined;

    if(!isDefined(var_5.activatestring) && !isDefined(var_5.objicon) && !isDefined(var_5.iconpos))
      var_5.noobjective = 1;

    level.globalobjectives[level.globalobjectives.size] = var_5;
    level.objectivestabledata[var_4] = var_5;
    level.event_director.events[var_4] = var_5;
    register_objective(var_4);
  }

  level thread debug_show_all_live_events();
  level thread debug_start_event_force();
  level thread debug_stop_event_force();
}

assign_event_location(var_0) {
  var_1 = tablelookup(var_0.associated_table, 0, var_0.row_index + "_encstr_B40101", 10);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = strtok(var_1, "_encstr_964C0249");
  var_3 = undefined;

  if(var_2.size == 3)
    var_3 = (int(var_2[0]), int(var_2[1]), int(var_2[2]));
  else if(var_2.size == 2) {
    var_3 = scripts\engine\utility::getStructArray(var_2[0], var_2[1]);

    if(!isDefined(var_3))
      var_3 = getEntArray(var_1, var_2[1]);

    if(!isDefined(var_3) || var_3.size == 0)
      var_3 = getEntArray(var_2[0], var_2[1]);
  }

  if(isDefined(var_3)) {
    if(isvector(var_3))
      var_0.iconpos = var_3;
    else if(isarray(var_3)) {
      var_0.iconpos = [];

      foreach(var_5 in var_3) {
        var_0.iconpos[var_0.iconpos.size] = var_5.origin;
        var_0.interactionstruct = var_5;
        var_5.objectivestruct = var_0;
      }
    } else
      var_0.iconpos = var_3.origin;
  } else
    var_0.iconpos = var_3;
}

delete_old_objective_location(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_1)) {
    if(scripts\engine\utility::array_contains(level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_0], var_1))
      level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_0] = scripts\engine\utility::array_remove(level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_0], var_1);

    var_1 = undefined;
  }
}

register_objective(var_0) {
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

run_through_timestamps() {
  if(getdvarint("_encstr_8F5B1E63278BEF9A6D8FB8FC1E7737219BB10383A5CF93C0319F674363AD333B", 0) != 0) {
    return;
  }
  var_0 = 0;

  foreach(var_2 in level.event_director.events) {
    if(isDefined(var_2.time_stamp) && var_2.time_stamp != "_encstr_B40101")
      level thread thread_timestamped_events(var_0, var_2);
  }
}

thread_timestamped_events(var_0, var_1) {
  if(waittill_reaching_time_stamp(var_0, var_1.time_stamp))
    try_start_event(var_1.ref, var_1.associated_table, var_1.row_index);
}

try_start_event(var_0, var_1, var_2) {
  if(var_0 == "_encstr_B40101") {
    return;
  }
  if(getDvar("_encstr_976913E603AB8EA3F3220820BB4173C307A467DD9D", "_encstr_B40101") != "_encstr_B40101") {
    if(getDvar("_encstr_976913E603AB8EA3F3220820BB4173C307A467DD9D", "_encstr_B40101") != level.objectivestabledata[var_0].ref)
      return;
  }

  if(getdvarint("_encstr_AACC13E68DE4FA59B359CD1D6E7D234B6E1626B195", 0) != 0) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = level.event_table_ref;

  var_3 = level.objectivestabledata[var_0];
  var_4 = var_3.repeat;

  if(!isDefined(var_2))
    var_2 = var_3.row_index;

  try_update_wait_for_repeating_event(var_0, var_4);

  if(is_event_active(var_0)) {
    return;
  }
  mark_event_active(var_0, 1);
  try_run_init_of_event(var_0);
  var_5 = tablelookup(var_1, 0, var_2 + "_encstr_B40101", 4);

  if(var_5 != "_encstr_B40101")
    level thread check_prerequisites_then_start_event(var_0, var_5, var_4);
  else
    level thread start_event(var_0, var_4);
}

try_run_init_of_event(var_0) {
  level endon("_encstr_8EC5165F79388BD710D16A3749F839A284978FD333D0939F" + var_0);
  var_1 = level.objectivestabledata[var_0];
  var_2 = get_init_func(var_0);

  if(isDefined(var_2))
    level[[var_2]](var_1);
}

try_update_wait_for_repeating_event(var_0, var_1) {
  if(!isDefined(var_1) || var_1 == "_encstr_B40101") {
    return;
  }
  var_2 = strtok(var_1, "_encstr_964C0249");
  var_3 = int(var_2[0]);
  var_4 = int(var_2[1]);
  update_wait_for_repeating_event(var_0, var_3, var_4);
}

update_wait_for_repeating_event(var_0, var_1, var_2) {
  if(!isDefined(level.wait_for_repeating_event))
    level.wait_for_repeating_event = [];

  var_3 = spawnStruct();
  var_3.min_wait_between_repeat = var_1;
  var_3.max_wait_between_repeat = var_2;
  level.wait_for_repeating_event[var_0] = var_3;
}

stop_event(var_0) {
  if(var_0 == "_encstr_B40101") {
    return;
  }
  if(!is_event_active(var_0)) {
    return;
  }
  debug_message_players("_encstr_B6050F9033BE1F3FFFEBA2B1CBCDB4D966" + var_0);
  mark_event_active(var_0, 0);
  var_1 = get_stop_func(var_0);
  var_2 = level.objectivestabledata[var_0];

  if(is_event_completed(var_0)) {
    if(isDefined(var_2.points) && var_2.points > 0) {
      foreach(var_4 in level.players)
      var_4 scripts\cp\cp_persistence::give_player_currency(var_2.points, "_encstr_8DEC06B1E943615B");
    }
  }

  var_6 = var_2.repeat;
  var_2 = level.objectivestabledata[var_0];
  level thread scripts\cp\cp_objectives::defaultcompleteobjective(var_2);
  level notify("_encstr_A1A70CA0D21E6361EFFA2D17C4C7" + var_2.ref + "_encstr_A7A70B7DDE989AAC6CA3D2B359");

  if(isDefined(var_1))
    level thread[[var_1]]();
}

disable_repeating_event(var_0) {
  level notify("_encstr_8EC5165F79388BD710D16A3749F839A284978FD333D0939F" + var_0);
}

check_prerequisites_then_start_event(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait_for_prerequisites_complete(var_1);
  start_event(var_0, var_2);
}

start_event(var_0, var_1) {
  if(var_0 == "_encstr_B40101") {
    return;
  }
  if(getdvarint("_encstr_B83C1D4A025BA8D8A61FDDFC3F4613C93EF2ADF9F181C07B39753B0C28D087", 0) != 0)
    var_1 = "_encstr_B40101";

  if(!isDefined(var_1))
    var_1 = "_encstr_B40101";

  var_2 = level.objectivestabledata[var_0];

  if(is_event_active(var_2.event_to_stop))
    stop_event(var_2.event_to_stop);

  var_3 = get_start_func(var_0);

  if(!isDefined(var_3)) {}

  assign_event_location(var_2);

  if(is_event_repeating(var_1))
    level thread run_repeating_event(var_0, var_3);
  else {
    debug_message_players("_encstr_9B3D0B79D808A2B2A8728A0280" + var_0 + "_encstr_9AF008F21B081049AA72");
    level thread scripts\cp\cp_objectives::run_objective(var_0, "_encstr_8A5707E9C2BFCEF0ED");
  }
}

is_event_repeating(var_0) {
  return !(var_0 == "_encstr_B40101");
}

run_repeating_event(var_0, var_1) {
  level endon("_encstr_8EC5165F79388BD710D16A3749F839A284978FD333D0939F" + var_0);
  var_2 = level.objectivestabledata[var_0];

  for(;;) {
    assign_event_location(var_2);
    level thread scripts\cp\cp_objectives::run_objective(var_0, "_encstr_8A5707E9C2BFCEF0ED");
    debug_message_players("_encstr_A73615CB8D0129A8821528A294728E108A2B1593A80180" + var_0 + "_encstr_9AF008F21B081049AA72");
    var_3 = get_wait_for_repeating_event(var_0);
    var_4 = randomintrange(var_3.min_wait_between_repeat, var_3.max_wait_between_repeat);
    var_5 = 0;

    while(var_5 < var_4) {
      var_5 = var_5 + 1;

      if(getdvarint("_encstr_965715E66C39D72BECB2B98EDCEB4C6EEB93CA38CA2C47", 0) != 0)
        var_5 = var_4;

      wait 1;
    }

    level thread scripts\cp\cp_objectives::defaultcompleteobjective(var_2);
    level notify("_encstr_A1A70CA0D21E6361EFFA2D17C4C7" + var_2.ref + "_encstr_A7A70B7DDE989AAC6CA3D2B359");
    wait 5;
  }
}

get_wait_for_repeating_event(var_0) {
  return level.wait_for_repeating_event[var_0];
}

mark_event_active(var_0, var_1) {
  level.event_director.registered_events[var_0].active = var_1;
}

is_event_active(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = level.event_director.registered_events[var_0];

  if(isDefined(var_1))
    return istrue(var_1.active);
  else
    return 0;
}

mark_event_completed(var_0) {
  scripts\engine\utility::flag_set("_encstr_BACE07D36E4F603577" + var_0 + "_encstr_93D80BF536F6B638D8AC1D95C8");
}

is_event_completed(var_0) {
  return scripts\engine\utility::flag("_encstr_BACE07D36E4F603577" + var_0 + "_encstr_93D80BF536F6B638D8AC1D95C8");
}

wait_for_event_complete(var_0) {
  scripts\engine\utility::flag_wait("_encstr_BACE07D36E4F603577" + var_0 + "_encstr_93D80BF536F6B638D8AC1D95C8");
}

get_init_func(var_0) {
  return level.event_director.registered_events[var_0].init_func;
}

get_start_func(var_0) {
  return level.event_director.registered_events[var_0].start_func;
}

get_stop_func(var_0) {
  return level.event_director.registered_events[var_0].stop_func;
}

get_event_location(var_0) {
  return level.event_director.registered_events[var_0].location;
}

waittill_reaching_time_stamp(var_0, var_1) {
  var_2 = convert_time_stamp_to_sec(var_1);
  var_3 = var_2 - var_0;
  wait(var_3);
  return var_0 + var_3;
}

convert_time_stamp_to_sec(var_0) {
  var_1 = strtok(var_0, "_encstr_8D4C02E8");
  var_2 = int(var_1[0]);
  var_3 = int(var_1[1]);
  return 60 * var_2 + var_3;
}

wait_for_prerequisites_complete(var_0) {
  var_1 = strtok(var_0, "_encstr_964C0249");
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(var_1[0]))
    var_2 = "_encstr_BACE07D36E4F603577" + var_1[0] + "_encstr_93D80BF536F6B638D8AC1D95C8";

  if(isDefined(var_1[1]))
    var_3 = "_encstr_BACE07D36E4F603577" + var_1[1] + "_encstr_93D80BF536F6B638D8AC1D95C8";

  if(isDefined(var_1[2]))
    var_4 = "_encstr_BACE07D36E4F603577" + var_1[2] + "_encstr_93D80BF536F6B638D8AC1D95C8";

  if(isDefined(var_1[3]))
    var_5 = "_encstr_BACE07D36E4F603577" + var_1[3] + "_encstr_93D80BF536F6B638D8AC1D95C8";

  scripts\engine\utility::flag_wait_all(var_2, var_3, var_4, var_5);
}

debug_message_players(var_0) {
  if(getdvarint("_encstr_A60B1C5B01560F2FC84BE6E47F59B71F7EF9C232A9B89F67C88FE1FF7B50", 0) != 0)
    return;
}

debug_show_all_live_events() {
  wait 5;

  for(;;) {
    if(getdvarint("_encstr_8AE2179B10959F0390A31EE0172FF3225057D78F9963E89CB7", 0) == 0) {
      wait 3;
      continue;
    }

    var_0 = "_encstr_B40101";

    foreach(var_2 in level.event_director.events) {
      if(istrue(level.event_director.registered_events[var_2.ref].active))
        var_0 = var_0 + ("_encstr_BE0703F5EF" + var_2.row_index);
    }

    if(isDefined(var_0) && var_0 != "_encstr_B40101")
      debug_message_players(var_0);

    wait 0.5;
  }
}

debug_start_event_force() {
  wait 3;

  for(;;) {
    if(getDvar("_encstr_B43B119BC639EB59D995738EDCBE99DB9C1B56", "_encstr_B40101") == "_encstr_B40101") {
      wait 3;
      continue;
    } else {
      var_0 = getDvar("_encstr_B43B119BC639EB59D995738EDCBE99DB9C1B56", "_encstr_B40101");
      var_1 = level.objectivestabledata[var_0];

      if(!isDefined(var_1)) {
        debug_message_players("_encstr_A5F315C91DBB92FB80594A354CA1DD612E9B17DB5FA0A7" + var_0);
        setDvar("_encstr_B43B119BC639EB59D995738EDCBE99DB9C1B56", "_encstr_B40101");
        continue;
      }

      if(is_event_active(var_0)) {
        debug_message_players(var_0 + "_encstr_8D6913402DE6400B6CD1A5CEB2808563E4562C8CBC");
        setDvar("_encstr_B43B119BC639EB59D995738EDCBE99DB9C1B56", "_encstr_B40101");
        continue;
      }

      force_start_event_non_repeating(var_0);
      setDvar("_encstr_B43B119BC639EB59D995738EDCBE99DB9C1B56", "_encstr_B40101");
    }
  }
}

force_start_event_non_repeating(var_0) {
  if(is_event_active(var_0)) {
    return;
  }
  var_1 = level.objectivestabledata[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  mark_event_active(var_0, 1);
  var_2 = get_init_func(var_0);

  if(isDefined(var_2))
    level[[var_2]](var_1);

  start_event(var_0, "_encstr_B40101");
}

debug_stop_event_force() {
  wait 3;

  for(;;) {
    if(getDvar("_encstr_BD7710BB0F581947EC7102AB9B50C70B58D1", "_encstr_B40101") == "_encstr_B40101") {
      wait 3;
      continue;
    } else {
      var_0 = getDvar("_encstr_BD7710BB0F581947EC7102AB9B50C70B58D1", "_encstr_B40101");
      var_1 = level.objectivestabledata[var_0];

      if(!isDefined(var_1)) {
        debug_message_players("_encstr_A5F315C91DBB92FB80594A354CA1DD612E9B17DB5FA0A7" + var_0);
        setDvar("_encstr_BD7710BB0F581947EC7102AB9B50C70B58D1", "_encstr_B40101");
        continue;
      }

      if(!is_event_active(var_0)) {
        debug_message_players(var_0 + "_encstr_8F6310BA2A62810877A4C7E69D4B30DB8D52");
        setDvar("_encstr_BD7710BB0F581947EC7102AB9B50C70B58D1", "_encstr_B40101");
        continue;
      }

      stop_event(var_0);
      setDvar("_encstr_BD7710BB0F581947EC7102AB9B50C70B58D1", "_encstr_B40101");
    }
  }
}