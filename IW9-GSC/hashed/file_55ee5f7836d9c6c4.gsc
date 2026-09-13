/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_55ee5f7836d9c6c4.gsc
***********************************************/

main() {
  if(getdvarint("dvar_176FA03E6DA10955", 0) == 0) {
    return;
  }
  setomnvar("ui_raid_lua_render_stage", 5);
  register_fuel_stability_event();
  initializerocketfuelreadings(1);
  registerpuzzleinteractions();
  thread watch_for_players_activating_juggmaze_map();
  thread validatefuelstability();
}

register_fuel_stability_event() {
  scripts\cp\cp_objectives::registerobjective("fuel_stability", ::fuel_stability_event_init, ::fuel_stability_event_start, undefined, scripts\cp\cp_objectives::debugbeatobjective, undefined);
  scripts\cp\cp_objectives::registerobjective("pressure_stability", ::pressure_stability_event_init, ::pressure_stability_event_start, undefined, scripts\cp\cp_objectives::debugbeatobjective, undefined);
}

fuel_stability_event_init(objectivestruct) {
  wait 0.05;
}

fuel_stability_event_start(objectivestruct) {
  level waittill("reset_gauges");
  thread clear_up_objective_after_delay();
}

pressure_stability_event_init(objectivestruct) {
  wait 0.05;
}

pressure_stability_event_start(objectivestruct) {
  level.pressure_unstable = 1;
  level thread watch_for_objective_failed(objectivestruct);
  setomnvar("ui_chemical_4_stability", 1);
  level waittill("normalized_pressure");
  setomnvar("ui_chemical_4_stability", 0);
  reset_current_step_count();
  level.pressure_unstable = undefined;
  thread clear_up_objective_after_delay();
}

watch_for_objective_failed(objectivestruct) {
  result = level scripts\engine\utility::waittill_any_timeout_2(15, objectivestruct.ref + "_timer_complete", "normalized_pressure");

  if(isDefined(result) && result == "normalized_pressure") {
    return;
  }
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
  return;
}

clear_up_objective_after_delay() {
  waitframe();
}

reset_current_step_count() {
  level.rocket_fuel.current_steps = 0;
}

initializerocketfuelreadings(_id_8174307463B4E86F, _id_DF071553D0996FF9) {
  level.rocket_fuel = spawnStruct();
  _id_8750F34870A547DF = 5;
  setomnvar("ui_rocket_thruster_stage", _id_8174307463B4E86F);

  switch (_id_8174307463B4E86F) {
    case 1:
      level.tank_x1_capacity = 30;
      level.tank_x2_capacity = 50;
      level.rocket_fuel.required_tank_capacity = 40;
      level.rocket_fuel.pressure_timeout = 3;
      _id_8750F34870A547DF = 5;
      break;
    case 2:
      level.tank_x1_capacity = 60;
      level.tank_x2_capacity = 110;
      level.rocket_fuel.required_tank_capacity = 80;
      level.rocket_fuel.pressure_timeout = 2;
      _id_8750F34870A547DF = 2;
      break;
    case 3:
      level.tank_x1_capacity = 170;
      level.tank_x2_capacity = 200;
      level.rocket_fuel.required_tank_capacity = 90;
      level.rocket_fuel.pressure_timeout = 1;
      _id_8750F34870A547DF = 0;
      break;
    default:
      foreach(struct in scripts\engine\utility::getStructArray("seq_button", "script_noteworthy")) {
        if(isDefined(struct.headicon))
          deleteheadicon(struct.headicon);
      }

      level notify("progress_level");

      if(isDefined(_id_DF071553D0996FF9))
        scripts\cp\cp_interaction::remove_from_current_interaction_list(_id_DF071553D0996FF9);

      return;
  }

  iprintln(" ^1 ROCKET FUEL STAGE CHANGED. ^3CURRENT STAGE = ^5 " + _id_8174307463B4E86F);
  level.rocket_fuel.stage = int(_id_8174307463B4E86F);
  level.rocket_fuel.max_steps_before_stability_loss = minsteps(level.tank_x1_capacity, level.tank_x2_capacity, level.rocket_fuel.required_tank_capacity);
  level.rocket_fuel.pressure_overload_threshold = level.rocket_fuel.max_steps_before_stability_loss + _id_8750F34870A547DF;
  level.rocket_fuel.current_steps = 0;
  level.rocket_fuel_x1 = spawnStruct();
  level.rocket_fuel_x1.value = 0;
  level.rocket_fuel_x1.polarity = 1;

  if(getdvarint("dvar_FDDAA9A78A7586B7", 0) != 0)
    level.rocket_fuel_x1.increment_factor = level.rocket_fuel.required_tank_capacity;
  else
    level.rocket_fuel_x1.increment_factor = level.tank_x1_capacity;

  level.rocket_fuel_x1.reading = level.rocket_fuel_x1.value * level.rocket_fuel_x1.polarity;
  level.rocket_fuel_x2 = spawnStruct();
  level.rocket_fuel_x2.value = 0;
  level.rocket_fuel_x2.polarity = 1;

  if(getdvarint("dvar_FDDAA9A78A7586B7", 0) != 0)
    level.rocket_fuel_x2.increment_factor = level.rocket_fuel.required_tank_capacity;
  else
    level.rocket_fuel_x2.increment_factor = level.tank_x2_capacity;

  level.rocket_fuel_x2.reading = level.rocket_fuel_x2.value * level.rocket_fuel_x2.polarity;
}

registerpuzzleinteractions() {
  scripts\cp\cp_interaction::registerinteraction("seq_button", ::hint_seq_button, ::activate_seq_button, ::init_seq_button, 0, "duration_long");
}

validatefuelstability() {
  for(;;) {
    level waittill("fuel_levels_changed");
    _id_15267D7819E09FA2 = 1;

    if(level.rocket_fuel_x1.value > level.tank_x1_capacity || level.rocket_fuel_x2.value > level.tank_x2_capacity)
      _id_15267D7819E09FA2 = 0;

    if(!_id_15267D7819E09FA2) {
      if(level.rocket_fuel_x1.value > level.tank_x1_capacity) {
        setomnvar("ui_chemical_1_stability", 1);
        setomnvar("ui_chemical_2_stability", 1);
      }

      if(level.rocket_fuel_x2.value > level.tank_x2_capacity)
        setomnvar("ui_chemical_3_stability", 1);

      thread start_unstable_rocket_fuel_timer(level.jugg_objective_struct, 30);
      continue;
    }

    setomnvar("ui_chemical_1_stability", 0);
    setomnvar("ui_chemical_2_stability", 0);
    setomnvar("ui_chemical_3_stability", 0);
    level notify("reset_gauges");
  }
}

set_pressure_stability_reading() {}

start_unstable_rocket_fuel_timer(objectivestruct, delay) {
  level endon("escaped_maze");

  if(istrue(level.unstable_gauge_timer_active)) {
    iprintln(" UNSTABLE GAUGES STILL PRESENT! PLEASE RESET!! ");
    return;
  }

  level.unstable_gauge_timer_active = 1;
  thread scripts\cp\cp_objectives::run_objective("fuel_stability");
  result = level scripts\engine\utility::waittill_any_timeout_2(30, objectivestruct.ref + "_timer_complete", "reset_gauges");

  if(isDefined(result) && result == "reset_gauges") {} else
    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);

  level.unstable_gauge_timer_active = undefined;
}

watch_for_players_activating_juggmaze_map() {
  for(;;) {
    level waittill("manifest_computer_used", player);
    _id_4D346DA49A80368C::start_periodic_jugg_pulses();
    level.overwatch_player = player;
    player.bisoverwatch = 1;
    player thread update_readings();
    show_rocket_fuel_readings();
    player waittill("exit_computer");
    player notify("update_readings");
    player.bisoverwatch = undefined;
    level.overwatch_player = undefined;
    level notify("end_jugg_recon_thread");
  }
}

show_rocket_fuel_readings() {
  setomnvar("ui_chemical_1_amount", int(level.rocket_fuel_x1.reading));

  if(level.rocket_fuel_x1.value > level.tank_x1_capacity)
    setomnvar("ui_chemical_2_amount", int(abs(level.rocket_fuel_x1.reading - level.tank_x1.capacity)));

  if(level.rocket_fuel_x2.value > level.tank_x2_capacity)
    setomnvar("ui_chemical_2_amount", int(abs(level.rocket_fuel_x2.reading - level.tank_x2.capacity)));

  setomnvar("ui_chemical_3_amount", int(level.rocket_fuel_x2.reading));
  setomnvar("ui_chemical_4_amount", int(level.rocket_fuel.current_steps));
  setomnvar("ui_rocket_fuel_total", int(level.rocket_fuel.required_tank_capacity));
}

update_readings() {
  self notify("update_readings");
  self endon("update_readings");

  for(;;) {
    level waittill("fuel_levels_changed");
    show_rocket_fuel_readings();
  }
}

hide_rocket_fuel_readings_to_player(player) {
  setomnvar("ui_chemical_1_amount", -1);
  setomnvar("ui_chemical_2_amount", -1);
  setomnvar("ui_chemical_3_amount", -1);
  setomnvar("ui_chemical_4_amount", -1);
  setomnvar("ui_rocket_fuel_total", -1);
}

init_seq_button(_id_70DAB3207FB65169) {
  if(_id_70DAB3207FB65169.size > 0) {
    foreach(struct in _id_70DAB3207FB65169) {
      headicon = "icon_electronic_interact";

      switch (struct.script_label) {
        case "A":
          headicon = "icon_electronic_interact";
          break;
        case "B":
          headicon = "icon_electronic_interact";
          break;
        case "C":
          headicon = "hud_icon_perk_medic_pro";
          break;
        case "D":
          headicon = "hud_icon_perk_medic_pro";
          break;
        case "E":
          headicon = "hud_icon_sng_intel";
          break;
        case "F":
          headicon = "hud_icon_hardpoint_diamond";
          break;
        case "G":
          headicon = "hud_icon_hardpoint_diamond";
          break;
        case "H":
          headicon = "hud_icon_perk_momentum_pro";
          break;
        case "I":
          headicon = "hud_icon_sng_intel";
          break;
        case "J":
          headicon = "cp_crate_icon_armor";
          break;
      }

      struct.blocked = 0;
      struct.model = spawn("script_model", struct.origin);
      struct.headicon = createheadicon(struct.model);
      setheadiconimage(struct.headicon, headicon);
      setheadiconzoffset(struct.headicon, 5);
      setheadiconsnaptoedges(struct.headicon, 0);
      setheadicondrawthroughgeo(struct.headicon, 1);
      setheadiconmaxdistance(struct.headicon, 5000);
      setheadiconnaturaldistance(struct.headicon, 500);
    }
  }
}

hint_seq_button(_id_DF071553D0996FF9, player) {
  if(istrue(_id_DF071553D0996FF9.blocked))
    return "";

  if(istrue(level.pressure_unstable)) {
    if(isDefined(_id_DF071553D0996FF9.script_label) && (_id_DF071553D0996FF9.script_label != "A" || _id_DF071553D0996FF9.script_label != "B"))
      return;
  }

  if(istrue(level.unstable_gauge_timer_active)) {
    if(isDefined(_id_DF071553D0996FF9.script_label) && (_id_DF071553D0996FF9.script_label == "E" || _id_DF071553D0996FF9.script_label == "I"))
      return "";
  }

  return &"CP_RAID_COMPLEX_JUGG_MAZE/ADJUST_GAUGE";
}

activate_seq_button(_id_DF071553D0996FF9, player) {
  player endon("disconnect");

  if(istrue(_id_DF071553D0996FF9.blocked)) {
    return;
  }
  if(istrue(level.pressure_unstable)) {
    if(isDefined(_id_DF071553D0996FF9.script_label) && (_id_DF071553D0996FF9.script_label != "A" || _id_DF071553D0996FF9.script_label != "B"))
      return;
  }

  if(istrue(level.unstable_gauge_timer_active)) {
    if(isDefined(_id_DF071553D0996FF9.script_label) && (_id_DF071553D0996FF9.script_label == "E" || _id_DF071553D0996FF9.script_label == "I"))
      return;
  }

  switch (_id_DF071553D0996FF9.script_label) {
    case "B":
    case "A":
      level notify("normalized_pressure");
      break;
    case "C":
      level.rocket_fuel_x1.reading = level.rocket_fuel_x1.reading + level.rocket_fuel_x1.increment_factor * level.rocket_fuel_x1.polarity;
      level.rocket_fuel_x1.value = abs(level.rocket_fuel_x1.reading);
      player iprintln(" Element X1 Reading = ^1 " + level.rocket_fuel_x1.reading);
      break;
    case "D":
      level.rocket_fuel_x2.reading = level.rocket_fuel_x2.reading + level.rocket_fuel_x2.increment_factor * level.rocket_fuel_x2.polarity;
      level.rocket_fuel_x2.value = abs(level.rocket_fuel_x2.reading);
      player iprintln(" Element X2 Reading = ^1 " + level.rocket_fuel_x2.reading);
      break;
    case "E":
      struct = mix_with_caps(level.tank_x2_capacity, level.tank_x1_capacity, level.rocket_fuel_x2.value, level.rocket_fuel_x1.value);
      level.rocket_fuel_x2.value = struct.from;
      level.rocket_fuel_x1.value = struct.to;
      level.rocket_fuel_x2.reading = level.rocket_fuel_x2.value * level.rocket_fuel_x2.polarity;
      level.rocket_fuel_x1.reading = level.rocket_fuel_x1.value * level.rocket_fuel_x1.polarity;
      player iprintln(" ^3 Values = ^3Element X1 = ^1" + level.rocket_fuel_x1.reading + " ^3 Element X2 = ^1" + level.rocket_fuel_x2.reading);
      break;
    case "F":
      level.rocket_fuel_x1 = spawnStruct();
      level.rocket_fuel_x1.value = 0;
      level.rocket_fuel_x1.polarity = 1;
      level.rocket_fuel_x1.increment_factor = level.tank_x1_capacity;
      level.rocket_fuel_x1.reading = level.rocket_fuel_x1.value * level.rocket_fuel_x1.polarity;
      break;
    case "G":
      level.rocket_fuel_x2 = spawnStruct();
      level.rocket_fuel_x2.value = 0;
      level.rocket_fuel_x2.polarity = 1;
      level.rocket_fuel_x2.increment_factor = level.tank_x2_capacity;
      level.rocket_fuel_x2.reading = level.rocket_fuel_x2.value * level.rocket_fuel_x2.polarity;
      break;
    case "H":
      if(isfuelreadingoptimal()) {
        initializerocketfuelreadings(level.rocket_fuel.stage + 1, _id_DF071553D0996FF9);
        level notify("fuel_levels_changed");
        return;
      }

      break;
    case "I":
      struct = mix_with_caps(level.tank_x1_capacity, level.tank_x2_capacity, level.rocket_fuel_x1.value, level.rocket_fuel_x2.value);
      level.rocket_fuel_x1.value = struct.from;
      level.rocket_fuel_x2.value = struct.to;
      level.rocket_fuel_x1.reading = level.rocket_fuel_x1.value * level.rocket_fuel_x1.polarity;
      level.rocket_fuel_x2.reading = level.rocket_fuel_x2.value * level.rocket_fuel_x2.polarity;
      player iprintln(" ^3 Values = ^3Element X1 = ^1" + level.rocket_fuel_x1.reading + " ^3 Element X2 = ^1" + level.rocket_fuel_x2.reading);
      break;
    case "J":
      level notify("fuel_levels_changed");
      player iprintln(" ^3 Current Reading - ^2 Element X1 = ^1" + level.rocket_fuel_x1.reading + " ^2 Element X2 = ^1" + level.rocket_fuel_x2.reading);
      return;
  }

  level notify("fuel_levels_changed");
  level.rocket_fuel.current_steps++;

  if(getdvarint("dvar_BB0A6FFD2CA3D199", 0) == 0) {
    if(level.rocket_fuel.current_steps >= level.rocket_fuel.pressure_overload_threshold) {
      level notify("pressure_change");
      thread scripts\cp\cp_objectives::run_objective("pressure_stability");
    }
  }
}

watch_for_second_input() {
  level notify("watch_for_second_input");
  level endon("watch_for_second_input");
  level endon("normalized_pressure");
  value = level scripts\engine\utility::waittill_any_timeout_1(level.rocket_fuel.pressure_timeout, "second_gauge_triggered");

  if(isDefined(value) && value == "second_gauge_triggered") {
    level.first_pressure_switch_triggered = undefined;
    level notify("normalized_pressure");
  }
}

reset_progress() {
  initializerocketfuelreadings();
}

isfuelreadingoptimal() {
  if(level.rocket_fuel_x1.reading == level.rocket_fuel.required_tank_capacity || level.rocket_fuel_x2.reading == level.rocket_fuel.required_tank_capacity)
    return 1;
  else
    return 0;
}

gcd(a, b) {
  if(b == 0)
    return a;

  return gcd(b, a % b);
}

mix_with_caps(_id_B8F98FB3BE1EB267, _id_71B0972CE6E85BB8, from, to) {
  if(from == 0) {
    struct = spawnStruct();
    struct.from = from;
    struct.to = to;
    return struct;
  }

  if(to == 0 && from == _id_B8F98FB3BE1EB267)
    return mix(_id_B8F98FB3BE1EB267, _id_71B0972CE6E85BB8);

  temp = min(from, _id_71B0972CE6E85BB8 - to);
  to = to + temp;
  from = from - temp;
  struct = spawnStruct();
  struct.from = from;
  struct.to = to;
  return struct;
}

mix(_id_B8F98FB3BE1EB267, _id_71B0972CE6E85BB8) {
  from = _id_B8F98FB3BE1EB267;
  to = 0;
  temp = min(from, _id_71B0972CE6E85BB8 - to);
  to = to + temp;
  from = from - temp;
  struct = spawnStruct();
  struct.from = from;
  struct.to = to;
  return struct;
}

pour(_id_B8F98FB3BE1EB267, _id_71B0972CE6E85BB8, _id_AC0E564AC96A9D0F) {
  from = _id_B8F98FB3BE1EB267;
  to = 0;
  _id_D0DE0DB1760B9C5B = 1;

  while(from != _id_AC0E564AC96A9D0F && to != _id_AC0E564AC96A9D0F) {
    temp = min(from, _id_71B0972CE6E85BB8 - to);
    to = to + temp;
    from = from - temp;
    _id_D0DE0DB1760B9C5B++;

    if(from == _id_AC0E564AC96A9D0F || to == _id_AC0E564AC96A9D0F) {
      break;
    }

    if(from == 0) {
      from = _id_B8F98FB3BE1EB267;
      _id_D0DE0DB1760B9C5B++;
    }

    if(to == _id_71B0972CE6E85BB8) {
      to = 0;
      _id_D0DE0DB1760B9C5B++;
    }
  }

  return _id_D0DE0DB1760B9C5B;
}

minsteps(_id_AC0E5D4AC96AAC74, n, _id_AC0E564AC96A9D0F) {
  if(_id_AC0E5D4AC96AAC74 > n) {
    temp = _id_AC0E5D4AC96AAC74;
    _id_AC0E5D4AC96AAC74 = n;
    n = temp;
  }

  if(_id_AC0E564AC96A9D0F > n)
    return -1;

  if(_id_AC0E564AC96A9D0F % gcd(n, _id_AC0E5D4AC96AAC74) != 0)
    return -1;

  return min(pour(n, _id_AC0E5D4AC96AAC74, _id_AC0E564AC96A9D0F), pour(_id_AC0E5D4AC96AAC74, n, _id_AC0E564AC96A9D0F));
}