/************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: soundscripts\_audio_dynamic_ambi.gsc
************************************************/

damb_init() {
  if(!isdefined(level._audio))
    level._audio = spawnstruct();

  if(!isdefined(level._audio.damb)) {
    level._audio.damb = spawnstruct();
    level._audio.damb.loop_handle_index = 0;
    level._audio.damb.single_loop_handle_index = 0;
    level._audio.damb.oneshot_handle_index = 0;
    level._audio.damb.serial_playback_lock = 1;
    level._audio.damb.playing = [];
    level._audio.damb.playing["zone"] = [];
    level._audio.damb.playing["free"] = [];
    level._audio.damb.component_weights = [];
    level._audio.damb.callbacks = [];
    level._audio.damb.preset_cache = [];
    level._audio.damb.component_cache = [];
    level._audio.damb.loop_cache = [];
    level._audio.damb.use_string_table_presets = 0;
    level._audio.damb.entity_ref_count = 0;
    level._audio.damb.loop_entity_ref_count = 0;
    level._audio.damb.max_entities = 15;
  }
}

damb_set_max_entities(var_0) {
  level._audio.damb.max_entities = var_0;
}

damb_use_string_table() {
  level._audio.damb.use_string_table_presets = 1;
}

damb_zone_start_preset(var_0, var_1) {
  dambx_start_preset("zone", var_0, undefined, var_1);
}

damb_start_preset(var_0, var_1, var_2, var_3) {
  dambx_start_preset("free", var_0, var_1, var_2, undefined, undefined, undefined, var_3);
}

damb_start_preset_at_point(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isdefined(var_3))
    thread dambx_monitor_damb_point_distance(var_0, var_1, var_2, var_3, var_4, var_5);
  else
    dambx_start_preset("free", var_0, var_2, undefined, var_1, undefined, undefined, var_5);
}

damb_stop_preset_at_point(var_0, var_1, var_2) {
  if(isstring(var_1))
    var_3 = var_1;
  else
    var_3 = var_0;

  level notify(var_3 + "dist_monitor_stop");
  damb_stop_preset(var_3, var_2);
}

damb_make_linked_damb(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnstruct();
  var_5.name = var_0;
  var_5.point = var_1;
  var_5.label = var_2;
  var_5.min_delay = var_3;
  var_5.max_delay = var_4;
  return var_5;
}

dambx_monitor_damb_point_distance(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isstring(var_2))
    level endon(var_2 + "dist_monitor_stop");
  else
    level endon(var_0 + "dist_monitor_stop");

  var_6 = 1.0;

  if(isdefined(var_4))
    var_6 = var_4;

  var_7 = 1;

  for (;;) {
    var_8 = distance(level.player.origin, var_1);

    if(var_8 < var_3) {
      if(var_7) {
        var_7 = 0;
        dambx_start_preset("free", var_0, var_2, undefined, var_1, undefined, undefined, var_5);
      }
    } else if(!var_7) {
      var_7 = 1;

      if(isdefined(var_2))
        dambx_stop_preset("free", var_2, var_6);
      else
        dambx_stop_preset("free", var_0, var_6);
    }

    wait 1;
  }
}

damb_start_preset_on_entity(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "attach";

  if(isdefined(var_3))
    var_5 = var_3;

  dambx_start_preset("free", var_0, var_2, var_4, undefined, var_1, var_5);
}

damb_stop(var_0, var_1) {
  var_2 = 2.0;

  if(isdefined(var_0))
    var_2 = var_0;

  var_3 = "all";

  if(isdefined(var_1))
    var_3 = var_1;

  if(var_3 == "free" || var_3 == "all") {
    foreach(var_6, var_5 in level._audio.damb.playing["free"])
    damb_stop_preset(var_6, var_2);
  }

  if(var_3 == "zone" || var_3 == "all") {
    foreach(var_6, var_5 in level._audio.damb.playing["zone"])
    damb_zone_stop_preset(var_6, var_2);
  }
}

damb_stop_zone(var_0) {
  dambx_stop_preset("zone", undefined, var_0);
}

damb_zone_stop_preset(var_0, var_1) {
  dambx_stop_preset("zone", var_0, var_1);
}

damb_stop_preset(var_0, var_1) {
  dambx_stop_preset("free", var_0, var_1);
}

damb_prob_mix_damb_presets(var_0, var_1, var_2, var_3) {
  if(isdefined(var_0) && var_0 != "none") {
    if(var_1 == 0)
      damb_zone_stop_preset(var_0, 2.0);
    else
      damb_zone_start_preset(var_0, var_1);
  }

  if(isdefined(var_2) && var_2 != "none") {
    if(var_3 == 0)
      damb_zone_stop_preset(var_2, 2.0);
    else
      damb_zone_start_preset(var_2, var_3);
  }
}

damb_set_oneshot_callback_for_component(var_0, var_1) {
  if(!isdefined(level._audio.damb.callback))
    level._audio.damb.callback = [];

  level._audio.damb.callback[var_0] = var_1;
}

damb_set_oneshot_callback_for_dynamic_ambience(var_0, var_1) {
  var_2 = [];

  if(isdefined(level._audio.damb.preset_cache[var_0]))
    var_2 = level._audio.damb.preset_cache[var_0];
  else if(level._audio.damb.use_string_table_presets) {
    var_2 = dambx_get_preset_from_string_table(var_0, 1);
    level._audio.damb.preset_cache[var_0] = var_2;
  } else {
    var_2 = dambx_get_preset_from_string_table(var_0, 0);
    level._audio.damb.preset_cache[var_0] = var_2;
  }

  foreach(var_4 in var_2["components"])
  damb_set_oneshot_callback_for_component(var_4, var_1);
}

damb_pause_damb(var_0, var_1) {
  var_2 = "free";

  if(isdefined(var_1))
    var_2 = var_1;

  if(isdefined(level._audio.damb.playing[var_2][var_0]))
    level._audio.damb.playing[var_2][var_0]["paused"] = 1;
}

damb_unpause_damb(var_0, var_1) {
  var_2 = "free";

  if(isdefined(var_1))
    var_2 = var_1;

  if(isdefined(level._audio.damb.playing[var_2][var_0])) {
    level._audio.damb.playing[var_2][var_0]["paused"] = 0;
    level notify(var_2 + "_" + var_0 + "_event");
  }
}

damb_manual_trigger(var_0, var_1) {
  var_2 = "free";

  if(isdefined(var_1))
    var_2 = var_1;

  if(isdefined(level._audio.damb.playing[var_2][var_0]))
    level notify(var_2 + "_" + var_0 + "_event");
}

damb_link_to_damb(var_0, var_1, var_2, var_3) {
  var_4 = "free";

  if(isdefined(level._audio.damb.playing[var_4][var_0]) && isdefined(level._audio.damb.playing[var_4][var_1])) {
    var_2 = min(var_2, var_3);
    var_3 = max(var_2, var_3);

    if(!isdefined(level._audio.damb.playing[var_4][var_0]["linked_dambs"]))
      level._audio.damb.playing[var_4][var_0]["linked_dambs"] = [];

    var_5 = level._audio.damb.playing[var_4][var_0]["linked_dambs"].size;
    level._audio.damb.playing[var_4][var_0]["linked_dambs"][var_5] = spawnstruct();
    level._audio.damb.playing[var_4][var_0]["linked_dambs"][var_5].name = var_1;
    level._audio.damb.playing[var_4][var_0]["linked_dambs"][var_5].min_delay = max(var_2, 0);
    level._audio.damb.playing[var_4][var_0]["linked_dambs"][var_5].max_delay = max(var_3, 0);
  }
}

dambx_start_preset(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 1.0;

  if(isdefined(var_3))
    var_8 = var_3;

  var_9 = var_1;

  if(isstring(var_2))
    var_9 = var_2;

  if(!isdefined(level._audio.damb.playing[var_0][var_9])) {
    var_10 = dambx_get_damb_preset(var_1);

    if(!isdefined(var_10)) {
      return;
    }
    level._audio.damb.playing[var_0][var_9] = var_10;
    level._audio.damb.playing[var_0][var_9]["prob_scale"] = var_8;
    level._audio.damb.playing[var_0][var_9]["paused"] = 0;

    if(isdefined(var_7))
      dambx_start_linked_dambs(var_9, var_7);

    if(isdefined(var_5)) {
      level._audio.damb.playing[var_0][var_9]["entity"] = var_5;
      level._audio.damb.playing[var_0][var_9]["mode"] = var_6;
    }

    thread dambx_play(var_0, var_9, var_4);
  } else if(level._audio.damb.playing[var_0][var_9]["prob_scale"] != var_8)
    level._audio.damb.playing[var_0][var_9]["prob_scale"] = var_8;
}

dambx_start_linked_dambs(var_0, var_1) {
  if(isarray(var_1)) {
    foreach(var_3 in var_1) {
      dambx_start_preset("free", var_3.name, var_3.label, undefined, var_3.point);
      damb_pause_damb(var_3.label);
      damb_link_to_damb(var_0, var_3.label, var_3.min_delay, var_3.max_delay);
    }
  } else {
    dambx_start_preset("free", var_1.name, var_1.label, undefined, var_1.point);
    damb_pause_damb(var_1.label);
    damb_link_to_damb(var_0, var_1.label, var_1.min_delay, var_1.max_delay);
  }
}

dambx_stop_preset(var_0, var_1, var_2) {
  var_3 = 2.0;

  if(isdefined(var_2))
    var_3 = var_2;

  if(var_0 == "zone" && !isdefined(var_1)) {
    if(isdefined(level._audio.damb.playing[var_0])) {
      foreach(var_1, var_5 in level._audio.damb.playing[var_0]) {
        level._audio.damb.playing[var_0][var_1]["fade"] = var_3;
        level notify(var_0 + "_" + var_1 + "_stop");
      }
    }
  } else if(isdefined(level._audio.damb.playing[var_0][var_1])) {
    level._audio.damb.playing[var_0][var_1]["fade"] = var_3;
    level notify(var_0 + "_" + var_1 + "_stop");
  }
}

dambx_update_serially(var_0, var_1, var_2) {
  level endon(var_0 + "_" + var_1 + "_stop");
  var_3 = level._audio.damb.playing[var_0][var_1]["event_time"];
  var_4 = min(var_3[0], var_3[1]);
  var_5 = max(var_3[0], var_3[1]);
  var_6 = undefined;
  var_7 = undefined;

  if(isdefined(level._audio.damb.playing[var_0][var_1]["first_event"])) {
    var_3 = level._audio.damb.playing[var_0][var_1]["first_event"];
    var_6 = min(var_3[0], var_3[1]);
    var_7 = max(var_3[0], var_3[1]);
  }

  var_8 = undefined;

  if(isdefined(var_6))
    var_8 = randomfloatrange(var_6, var_7);
  else
    var_8 = randomfloatrange(var_4, var_5);

  for (;;) {
    if(!level._audio.damb.playing[var_0][var_1]["paused"])
      wait(var_8);

    if(level._audio.damb.playing[var_0][var_1]["paused"])
      level waittill(var_0 + "_" + var_1 + "_event");

    var_9 = dambx_pick_random_component(var_0, var_1);

    if(!isdefined(var_9)) {
      continue;
    }
    var_10 = dambx_get_component_data(var_0, var_1, var_9, var_1);

    if(var_10.using_oneshots_or_loops) {
      if(var_10.using_entity && !isdefined(var_10.ent)) {
        level notify(var_0 + "_" + var_1 + "_stop");
        break;
      }

      var_11 = dambx_create_damb_event(var_10, var_1, var_9);

      if(var_11.success) {
        if(level._audio.damb.serial_playback_lock)
          dambx_perform_play_event(var_0, var_1, var_11);
        else
          thread dambx_perform_play_event(var_0, var_1, var_11);
      }
    } else
      soundscripts\_audio::aud_print_warning("Dynamic ambience is playing back serially and using components which do not define oneshots or loops");

    var_8 = randomfloatrange(var_4, var_5);
  }
}

dambx_play_component_loops(var_0, var_1, var_2, var_3, var_4) {
  if(isdefined(var_2["single_loops"])) {
    foreach(var_6 in var_2["single_loops"]) {
      var_7 = undefined;

      if(isdefined(var_4))
        var_7 = spawn("script_origin", var_4.origin);
      else if(isdefined(var_3))
        var_7 = spawn("script_origin", var_3);
      else
        var_7 = spawn("script_origin", level.player.origin);

      level._audio.damb.loop_entity_ref_count++;
      var_7 playloopsound(var_6);

      if(isdefined(var_4))
        var_7 linkto(var_4);

      var_8 = level._audio.damb.single_loop_handle_index;
      level._audio.damb.playing[var_0][var_1]["single_loops"][var_8] = var_7;
      level._audio.damb.single_loop_handle_index++;
    }
  }
}

dambx_get_component_data(var_0, var_1, var_2, var_1) {
  var_3 = spawnstruct();
  var_3.using_oneshots_or_loops = 0;

  if(!isdefined(var_2["single_loops"]))
    var_3.single_loops = 0;
  else
    var_3.single_loops = 1;

  if(isdefined(var_2["oneshots"]) || isdefined(var_2["loops"])) {
    var_3.using_oneshots_or_loops = 1;

    if(!isdefined(var_2["radius"]))
      var_2["radius"] = [0.0, 0.01];

    var_3.min_radius = min(var_2["radius"][0], var_2["radius"][1]);
    var_3.max_radius = max(var_2["radius"][0], var_2["radius"][1]);

    if(isarray(var_2["event_time"])) {
      var_3.min_time = min(var_2["event_time"][0], var_2["event_time"][1]);
      var_3.max_time = max(var_2["event_time"][0], var_2["event_time"][1]);
    }

    if(isarray(var_2["first_event"])) {
      var_3.first_event = 1;
      var_3.first_event_min = min(var_2["first_event"][0], var_2["first_event"][1]);
      var_3.first_event_max = max(var_2["first_event"][0], var_2["first_event"][1]);
    }

    if(isarray(var_2["pitch"])) {
      var_3.min_pitch = min(var_2["pitch"][0], var_2["pitch"][1]);
      var_3.max_pitch = max(var_2["pitch"][0], var_2["pitch"][1]);
    }

    if(isarray(var_2["travel_time"])) {
      var_3.min_trav_time = min(var_2["travel_time"][0], var_2["travel_time"][1]);
      var_3.max_trav_time = max(var_2["travel_time"][0], var_2["travel_time"][1]);

      if(isarray(var_2["delta"])) {
        var_3.min_delta = min(var_2["delta"][0], var_2["delta"][1]);
        var_3.max_delta = max(var_2["delta"][0], var_2["delta"][1]);
      } else {
        var_3.min_delta_angle = min(var_2["delta_angle"][0], var_2["delta_angle"][1]);
        var_3.max_delta_angle = max(var_2["delta_angle"][0], var_2["delta_angle"][1]);
      }
    }

    if(isarray(var_2["pitch_time"])) {
      var_3.min_pitch_time = min(var_2["pitch_time"][0], var_2["pitch_time"][1]);
      var_3.max_pitch_time = max(var_2["pitch_time"][0], var_2["pitch_time"][1]);
    }

    if(isdefined(var_2["cone"])) {
      var_3.min_start_angle = min(var_2["cone"][0], var_2["cone"][1]);
      var_3.max_start_angle = max(var_2["cone"][0], var_2["cone"][1]);
    }
  } else
    var_3.using_oneshots_or_loops = 0;

  var_3.using_entity = 0;

  if(isdefined(level._audio.damb.playing[var_0][var_1]["entity"])) {
    var_3.using_entity = 1;
    var_3.ent = level._audio.damb.playing[var_0][var_1]["entity"];
    var_3.mode = level._audio.damb.playing[var_0][var_1]["mode"];
  }

  var_3.prob_scale = level._audio.damb.playing[var_0][var_1]["prob_scale"];
  return var_3;
}

dambx_monitor_single_loops_on_ent(var_0, var_1, var_2) {
  for (;;) {
    if(!isdefined(var_2))
      level notify(var_0 + "_" + var_1 + "_stop");

    wait 1.0;
  }
}

dambx_create_damb_event(var_0, var_1, var_2, var_3) {
  var_4 = spawnstruct();

  if(randomfloat(1.0) < var_0.prob_scale) {
    var_4.success = 1;

    if(isdefined(level._audio.damb.callbacks[var_1]))
      thread[[level._audio.damb.callback[var_1]]]();
    else {
      var_4.alias = dambx_pick_random_alias(var_2);
      var_4.point = var_3;
      var_4.ent = var_0.ent;
      var_4.mode = var_0.mode;
      var_5 = randomfloatrange(var_0.min_radius, var_0.max_radius);
      var_6 = undefined;

      if(isdefined(var_0.min_start_angle))
        var_6 = randomfloatrange(var_0.min_start_angle, var_0.max_start_angle);
      else
        var_6 = randomfloatrange(0, 360);

      var_7 = var_5 * cos(var_6);
      var_8 = var_5 * sin(var_6);
      var_4.start_position = (var_7, var_8, 0);

      if(isdefined(var_0.min_trav_time)) {
        var_4.travel_time = randomfloatrange(var_0.min_trav_time, var_0.max_trav_time);

        if(isdefined(var_0.min_delta)) {
          var_5 = randomfloatrange(var_0.min_delta, var_0.max_delta);
          var_6 = randomfloatrange(0, 360);
          var_7 = var_5 * cos(var_6);
          var_8 = var_5 * sin(var_6);
          var_4.end_position = var_4.start_position + (var_7, var_8, 0);
        } else {
          var_9 = randomfloatrange(var_0.min_delta_angle, var_0.max_delta_angle);
          var_9 = var_9 * 0.5;
          var_10 = level.player.origin;

          if(isdefined(var_3))
            var_10 = var_3;

          var_11 = var_4.start_position - var_10;
          var_7 = var_11[0] * cos(var_9) - var_11[1] * sin(var_9);
          var_8 = var_11[0] * sin(var_9) + var_11[1] * cos(var_9);
          var_4.end_position = var_4.start_position + (var_7, var_8, 0);
        }
      }

      if(isdefined(var_0.min_pitch))
        var_4.start_pitch = randomfloatrange(var_0.min_pitch, var_0.max_pitch);

      if(isdefined(var_0.min_pitch_time)) {
        var_4.end_pitch = randomfloatrange(var_0.min_pitch, var_0.max_pitch);
        var_4.pitch_time = randomfloatrange(var_0.min_pitch_time, var_0.max_pitch_time);
      }
    }
  } else
    var_4.success = 0;

  return var_4;
}

dambx_trigger_linked_damb(var_0, var_1) {
  wait(var_1);
  damb_manual_trigger(var_0);
}

dambx_make_first_wait(var_0) {
  var_1 = undefined;

  if(isdefined(var_0.first_event))
    var_1 = randomfloatrange(var_0.first_event_min, var_0.first_event_max);
  else
    var_1 = randomfloatrange(var_0.min_time, var_0.max_time);

  return var_1;
}

dambx_update(var_0, var_1, var_2, var_3) {
  level endon(var_0 + "_" + var_1 + "_stop");
  var_4 = dambx_get_component_data(var_0, var_1, var_2, var_1);

  if(var_4.single_loops) {
    dambx_play_component_loops(var_0, var_1, var_2, var_3, var_4.ent);

    if(var_4.using_entity && !var_4.using_oneshots_or_loops)
      thread dambx_monitor_single_loops_on_ent(var_0, var_1, var_4.ent);
  }

  if(var_4.using_oneshots_or_loops) {
    var_5 = dambx_make_first_wait(var_4);

    for (;;) {
      if(!level._audio.damb.playing[var_0][var_1]["paused"])
        wait(var_5);

      if(level._audio.damb.playing[var_0][var_1]["paused"])
        level waittill(var_0 + "_" + var_1 + "_event");

      if(var_4.using_entity && !isdefined(var_4.ent)) {
        level notify(var_0 + "_" + var_1 + "_stop");
        break;
      }

      if(isdefined(level._audio.damb.playing[var_0][var_1]["linked_dambs"])) {
        foreach(var_7 in level._audio.damb.playing[var_0][var_1]["linked_dambs"]) {
          var_8 = randomfloatrange(var_7.min_delay, var_7.max_delay);
          thread dambx_trigger_linked_damb(var_7.name, var_8);
        }
      }

      var_4.prob_scale = level._audio.damb.playing[var_0][var_1]["prob_scale"];
      var_10 = dambx_create_damb_event(var_4, var_1, var_2, var_3);

      if(var_10.success)
        thread dambx_perform_play_event(var_0, var_1, var_10);

      var_5 = randomfloatrange(var_4.min_time, var_4.max_time);
    }
  }
}

dambx_wait_till_sound_done_and_remove_handle(var_0, var_1, var_2, var_3) {
  level endon(var_0 + "_" + var_1 + "_stop");
  var_3 waittill("sounddone");

  if(isdefined(level._audio.damb.playing[var_0][var_1]["oneshots"][var_2])) {
    var_3 delete();
    decrement_ref_count();
    level._audio.damb.playing[var_0][var_1]["oneshots"][var_2] = undefined;
  }
}

dambx_perform_play_event(var_0, var_1, var_2) {
  level endon(var_0 + "_" + var_1 + "_stop");

  if(var_2.alias["type"] == "loop")
    dambx_perform_loop_event(var_0, var_1, var_2);
  else
    dambx_perform_oneshot_event(var_0, var_1, var_2);
}

dambx_perform_oneshot_event(var_0, var_1, var_2) {
  level endon(var_0 + "_" + var_1 + "_stop");
  var_3 = level.player.origin;

  if(isdefined(var_2.ent))
    var_3 = var_2.ent.origin;
  else if(isdefined(var_2.point))
    var_3 = var_2.point;

  if(level._audio.damb.entity_ref_count < level._audio.damb.max_entities) {
    var_4 = spawn("script_origin", var_3 + var_2.start_position);

    if(isdefined(var_2.ent) && var_2.mode == "attach")
      var_4 linkto(var_2.ent);

    var_4 playsound(var_2.alias["name"], "sounddone");
    var_4 thread soundscripts\_audio::aud_check_sound_done();

    if(!var_4.sounddone) {
      var_5 = level._audio.damb.oneshot_handle_index;
      level._audio.damb.playing[var_0][var_1]["oneshots"][var_5] = var_4;
      level._audio.damb.oneshot_handle_index++;
      increment_ref_count();

      if(isdefined(var_2.end_position) && !isdefined(var_2.entity)) {
        var_6 = 0.1 * var_2.travel_time;
        var_4 moveto(var_3 + var_2.end_position, var_2.travel_time, var_6, var_6);
      }

      if(isdefined(var_2.start_pitch))
        var_4 scalepitch(var_2.start_pitch);

      if(isdefined(var_2.pitch_time)) {
        wait 0.05;

        if(isdefined(var_4) && !var_4.sounddone)
          var_4 scalepitch(var_2.end_pitch, var_2.pitch_time);
      }

      thread dambx_wait_till_sound_done_and_remove_handle(var_0, var_1, var_5, var_4);
      var_4 waittill("sounddone");
      return;
    }

    var_4 delete();
    return;
  } else
    soundscripts\_audio::aud_print_warning("TRYING TO PLAY ONESHOT WITH DAMB REF COUNT AT MAXIMUM!");
}

dambx_perform_loop_event(var_0, var_1, var_2) {
  level endon(var_0 + "_" + var_1 + "_stop");

  if(level._audio.damb.entity_ref_count < level._audio.damb.max_entities) {
    var_3 = level.player.origin;

    if(isdefined(var_2.ent))
      var_3 = var_2.ent.origin;
    else if(isdefined(var_2.point))
      var_3 = var_2.point;

    var_4 = var_2.alias["name"];
    var_5 = dambx_get_loop_preset(var_4);

    if(!isdefined(var_5)) {
      return;
    }
    var_6 = min(var_5["duration"][0], var_5["duration"][1]);
    var_7 = max(var_5["duration"][0], var_5["duration"][1]);
    var_8 = randomfloatrange(var_6, var_7);
    var_9 = var_5["loop_alias"];
    var_10 = var_5["fade_in"];
    var_11 = var_5["fade_out"];
    var_12 = undefined;

    if(isdefined(var_5["end_alias"]))
      var_12 = var_5["end_alias"];

    var_13 = spawn("script_origin", var_3 + var_2.start_position);

    if(isdefined(var_2.ent) && var_2.mode == "attach")
      var_13 linkto(var_2.ent);

    var_13 playloopsound(var_9);

    if(isdefined(var_10)) {
      var_13 scalevolume(0.0);
      wait 0.05;
      var_13 scalevolume(1.0, var_10);
    }

    var_13 thread soundscripts\_audio::aud_check_sound_done();

    if(!var_13.sounddone) {
      var_14 = level._audio.damb.loop_handle_index;
      level._audio.damb.playing[var_0][var_1]["loops"][var_14] = var_13;
      increment_ref_count();
      level._audio.damb.loop_handle_index++;
      var_15 = 0;

      if(isdefined(var_2.mode) && var_2.mode == "free" && isdefined(var_2.end_position))
        var_15 = 1;
      else if(!isdefined(var_2.mode) && isdefined(var_2.end_position))
        var_15 = 1;

      if(var_15) {
        var_16 = 0.1 * var_2.travel_time;
        var_13 moveto(var_3 + var_2.end_position, var_2.travel_time, var_16, var_16);
      }

      if(isdefined(var_2.start_pitch))
        var_13 setpitch(var_2.start_pitch);

      if(isdefined(var_2.pitch_time)) {
        wait 0.05;

        if(isdefined(var_13) && !var_13.sounddone)
          var_13 setpitch(var_2.end_pitch, var_2.pitch_time);
      }

      wait(var_8);

      if(!var_13.sounddone) {
        if(isdefined(level._audio.damb.playing[var_0][var_1]["loops"][var_14])) {
          if(isdefined(var_12)) {
            var_17 = spawn("script_origin", var_13.origin);
            var_17 playsound(var_12, "sounddone");
            var_18 = level._audio.damb.oneshot_handle_index;
            level._audio.damb.oneshot_handle_index++;
            level._audio.damb.playing[var_0][var_1]["oneshots"][var_18] = var_17;
            increment_ref_count();
            thread dambx_wait_till_sound_done_and_remove_handle(var_0, var_1, var_18, var_17);
          }

          if(isdefined(var_11))
            thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_13, var_11);
          else {
            var_13 stoploopsound();
            wait 0.05;
            var_13 delete();
          }

          decrement_ref_count();
          level._audio.damb.playing[var_0][var_1]["loops"][var_14] = undefined;
          return;
        }

        return;
      }

      var_13 stoploopsound();
      var_13 delete();
      decrement_ref_count();
      level._audio.damb.playing[var_0][var_1]["loops"][var_14] = undefined;
      return;
      return;
    }

    var_13 delete();
    return;
  } else
    soundscripts\_audio::aud_print_warning("TRYING TO PLAY LOOP WITH DAMB REF COUNT AT MAXIMUM!");
}

dambx_pick_random_component(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in level._audio.damb.playing[var_0][var_1]["components"]) {
    var_5 = var_4[1];
    var_2 = var_2 + var_5;
  }

  var_7 = randomfloat(var_2);
  var_8 = 0.0;
  var_9 = undefined;

  foreach(var_4 in level._audio.damb.playing[var_0][var_1]["components"]) {
    var_11 = var_8 + var_4[1];

    if(var_7 >= var_8 && var_7 < var_11) {
      var_9 = var_4[0];
      break;
    }

    var_8 = var_11;
  }

  var_13 = dambx_get_component_preset(var_9);

  if(!isdefined(var_13)) {
    return;
  }
  var_13["name"] = var_9;
  return var_13;
}

dambx_pick_random_alias(var_0) {
  var_1 = var_0["loops"];
  var_2 = var_0["oneshots"];
  var_3 = undefined;

  if(!isdefined(level._audio.damb.component_weights[var_0["name"]])) {
    var_3 = 0;

    if(isdefined(var_1)) {
      if(isstring(var_1[0]))
        var_3 = var_3 + var_1[1];
      else {
        foreach(var_5 in var_1)
        var_3 = var_3 + var_5[1];
      }
    }

    if(isdefined(var_2)) {
      if(isstring(var_2[0]))
        var_3 = var_3 + var_2[1];
      else {
        foreach(var_5 in var_2)
        var_3 = var_3 + var_5[1];
      }
    }

    level._audio.damb.component_weights[var_0["name"]] = var_3;
  } else
    var_3 = level._audio.damb.component_weights[var_0["name"]];

  var_9 = randomfloatrange(0.0, var_3);
  var_10 = undefined;
  var_11 = undefined;
  var_12 = 0.0;

  if(isdefined(var_1)) {
    if(isstring(var_1[0])) {
      var_13 = var_12 + var_1[1];

      if(var_9 >= var_12 && var_9 < var_13) {
        var_10 = var_1[0];
        var_11 = "loop";
      } else
        var_12 = var_13;
    } else {
      foreach(var_5 in var_1) {
        var_13 = var_12 + var_5[1];

        if(var_9 >= var_12 && var_9 < var_13) {
          var_10 = var_5[0];
          var_11 = "loop";
          break;
        } else
          var_12 = var_13;
      }
    }
  }

  if(!isdefined(var_10) && isdefined(var_2)) {
    if(isarray(var_2)) {
      foreach(var_5 in var_2) {
        var_13 = var_12 + var_5[1];

        if(var_9 >= var_12 && var_9 < var_13) {
          var_10 = var_5[0];
          var_11 = "oneshot";
          break;
        } else
          var_12 = var_13;
      }
    } else {
      var_13 = var_12 + var_2[1];

      if(var_9 >= var_12 && var_9 < var_13) {
        var_10 = var_2[0];
        var_11 = "oneshot";
      } else
        var_12 = var_13;
    }
  }

  var_18 = [];
  var_18["name"] = var_10;
  var_18["type"] = var_11;
  return var_18;
}

dambx_get_loop_preset(var_0) {
  var_1 = [];

  if(isdefined(level._audio.damb.loop_cache[var_0]))
    var_1 = level._audio.damb.loop_cache[var_0];
  else
    var_1 = dambx_get_loop_def_from_string_table(var_0, 1);

  if(!isdefined(var_1) || var_1.size == 0) {
    return;
  }
  level._audio.damb.loop_cache[var_0] = var_1;
  return var_1;
}

dambx_get_component_preset(var_0) {
  if(!isdefined(level._audio.damb.component_cache))
    level._audio.damb.component_cache = [];

  var_1 = [];

  if(isdefined(level._audio.damb.component_cache[var_0]))
    var_1 = level._audio.damb.component_cache[var_0];

  var_1 = dambx_get_component_from_string_table(var_0, 1);

  if(!isdefined(var_1) || var_1.size == 0) {
    return;
  }
  level._audio.damb.component_cache[var_0] = var_1;
  return var_1;
}

dambx_play(var_0, var_1, var_2) {
  level._audio.damb.playing[var_0][var_1]["loops"] = [];
  level._audio.damb.playing[var_0][var_1]["single_loops"] = [];
  level._audio.damb.playing[var_0][var_1]["oneshots"] = [];

  if(!isdefined(level._audio.damb.playing[var_0][var_1]["event_time"])) {
    foreach(var_4 in level._audio.damb.playing[var_0][var_1]["components"]) {
      var_5 = dambx_get_component_preset(var_4);

      if(!isdefined(var_5)) {
        return;
      }
      var_5["name"] = var_4;
      thread dambx_update(var_0, var_1, var_5, var_2);
    }
  } else
    thread dambx_update_serially(var_0, var_1, var_2);

  level waittill(var_0 + "_" + var_1 + "_stop");
  wait 0.1;

  foreach(var_8 in level._audio.damb.playing[var_0][var_1]["loops"])
  thread dambx_fade_out_playing_loop(var_8, level._audio.damb.playing[var_0][var_1]["fade"], 0);

  foreach(var_8 in level._audio.damb.playing[var_0][var_1]["single_loops"])
  thread dambx_fade_out_playing_loop(var_8, level._audio.damb.playing[var_0][var_1]["fade"], 1);

  foreach(var_8 in level._audio.damb.playing[var_0][var_1]["oneshots"])
  thread dambx_fade_out_playing_sound(var_8, level._audio.damb.playing[var_0][var_1]["fade"]);

  level._audio.damb.playing[var_0][var_1] = undefined;
}

dambx_fade_out_playing_sound(var_0, var_1) {
  if(isdefined(var_0)) {
    var_0 scalevolume(0.0, var_1);
    wait(var_1);
    var_0 stopsounds();
    wait 0.05;
    var_0 delete();
    decrement_ref_count();
  }
}

dambx_fade_out_playing_loop(var_0, var_1, var_2) {
  var_0 scalevolume(0.0, var_1);
  wait(var_1);

  if(isdefined(var_0)) {
    var_0 stoploopsound();
    wait 0.05;
    var_0 delete();
  }

  if(var_2)
    level._audio.damb.loop_entity_ref_count--;
  else
    decrement_ref_count();
}

dambx_get_list_value_from_string_table(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if(isdefined(var_3))
    var_4 = var_3;

  var_5 = [];
  var_6 = 0;
  var_7 = strtok(var_0, "+");
  var_8 = 0;

  for (var_9 = 0; var_9 < var_7.size; var_9++) {
    var_10 = strtok(var_7[var_9], " ");

    if(var_10.size == 1 && var_10[0] != "") {
      var_5[var_5.size] = var_10[0];
      continue;
    }

    var_11 = var_5.size;
    var_5[var_11] = [];
    var_5[var_11][0] = var_10[0];
    var_5[var_11][1] = float(var_10[1]);
  }

  if(!var_6 && var_4) {
    var_12 = [];

    for (var_9 = 0; var_9 < var_5.size; var_9++) {
      var_13 = var_12.size;
      var_12[var_13] = [];
      var_12[var_13][0] = var_5[var_9];
      var_12[var_13][1] = 1.0;
    }

    var_5 = var_12;
  }

  return var_5;
}

dambx_get_loop_def_from_string_table(var_0, var_1) {
  var_2 = "soundtables\sp_defaults.csv";
  var_3 = soundscripts\_audio::get_damb_loops_stringtable();
  var_4 = [];

  if(var_1)
    var_4 = dambx_get_loop_def_from_string_table_internal(var_3, var_0);

  if(!isdefined(var_4) || var_4.size == 0)
    var_4 = dambx_get_loop_def_from_string_table_internal(var_2, var_0);

  if(!isdefined(var_4) || var_4.size == 0) {
    return;
  }
  return var_4;
}

dambx_get_loop_def_from_string_table_internal(var_0, var_1) {
  var_2 = [];
  var_3 = 8;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = [];
  var_9 = packedtablesectionlookup(var_0, "loop_defs", "zone_names;reverb_names;filter_names;occlusion_names;timescale_names;dynamic_ambience_names;components;loop_defs;whizby_preset_names;mix_names;healthfx_params");

  if(isdefined(var_9)) {
    for (var_10 = 0; var_10 < var_3; var_10++) {
      var_11 = packedtablelookupwithrange(var_0, 0, "loop_defs", var_10, var_9[0], var_9[1]);

      if(!isdefined(var_11) || var_11 == "") {
        return;
      }
      var_12 = packedtablelookupwithrange(var_0, 0, var_1, var_10, var_9[0], var_9[1]);

      if(var_12 != "" && var_11 != "comments") {
        switch (var_11) {
          case "loop_alias":
            var_4 = var_12;
            break;
          case "fade_in":
            if(isdefined(var_12) && var_12 != "")
              var_6 = max(float(var_12), 0.0);

            break;
          case "fade_out":
            if(isdefined(var_12) && var_12 != "")
              var_7 = max(float(var_12), 0.0);

            break;
          case "end_alias":
            if(isdefined(var_12) && var_12 != "")
              var_5 = var_12;

            break;
          case "duration_min":
            if(isdefined(var_12) && var_12 != "")
              var_8[0] = float(var_12);

            break;
          case "duration_max":
            if(isdefined(var_12) && var_12 != "")
              var_8[1] = float(var_12);

            break;
          default:
            break;
        }
      }
    }

    var_2["loop_alias"] = var_4;

    if(isdefined(var_6))
      var_2["fade_in"] = var_6;

    if(isdefined(var_7))
      var_2["fade_out"] = var_7;

    if(isdefined(var_5))
      var_2["end_alias"] = var_5;

    if(isdefined(var_8[0]))
      var_2["duration"] = dambx_get_two_value_float_array(var_8);

    return var_2;
  }
}

dambx_get_two_value_float_array(var_0) {
  var_1 = [];
  var_1[0] = float(var_0[0]);
  var_1[1] = float(var_0[1]);
  return var_1;
}

dambx_get_component_from_string_table_internal(var_0, var_1) {
  var_2 = [];
  var_3 = 21;
  var_4 = 8;
  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = [];
  var_9 = [];
  var_10 = [];
  var_11 = [];
  var_12 = [];
  var_13 = [];
  var_14 = [];
  var_15 = [];
  var_16 = 0;
  var_17 = packedtablesectionlookup(var_0, "components", "zone_names;reverb_names;filter_names;occlusion_names;timescale_names;dynamic_ambience_names;components;loop_defs;whizby_preset_names;mix_names;healthfx_params");

  if(isdefined(var_17)) {
    for (var_18 = 1; var_18 < var_3; var_18++) {
      var_19 = packedtablelookupwithrange(var_0, 0, "components", var_18, var_17[0], var_17[1]);

      if(!isdefined(var_19)) {
        return;
      }
      var_20 = packedtablelookupwithrange(var_0, 0, var_1, var_18, var_17[0], var_17[1]);

      if(var_20 != "" && var_19 != "comments") {
        var_16++;

        switch (var_19) {
          case "oneshots":
            var_5 = dambx_get_list_value_from_string_table(var_20, "component definition", "oneshots", 1);
            break;
          case "loops":
            var_6 = dambx_get_list_value_from_string_table(var_20, "component definition", "loops", 1);
            break;
          case "single_loops":
            var_7 = dambx_get_list_value_from_string_table(var_20, "component definition", "single_loops", 0);
            break;
          case "first_event_min":
            var_8[0] = float(var_20);
            break;
          case "first_event_max":
            var_8[1] = float(var_20);
            break;
          case "event_time_min":
            var_9[0] = float(var_20);
            break;
          case "event_time_max":
            var_9[1] = float(var_20);
            break;
          case "dist_min":
            var_10[0] = float(var_20);
            break;
          case "dist_max":
            var_10[1] = float(var_20);
            break;
          case "cone_min":
            var_11[0] = float(var_20);
            break;
          case "cone_max":
            var_11[1] = float(var_20);
            break;
          case "travel_min":
            var_12[0] = float(var_20);
            break;
          case "travel_max":
            var_12[1] = float(var_20);
            break;
          case "travel_time_min":
            var_13[0] = float(var_20);
            break;
          case "travel_time_max":
            var_13[1] = float(var_20);
            break;
          case "pitch_min":
            var_14[0] = float(var_20);
            break;
          case "pitch_max":
            var_14[1] = float(var_20);
            break;
          case "pitch_time_min":
            var_15[0] = float(var_20);
            break;
          case "pitch_time_max":
            var_15[1] = float(var_20);
            break;
          default:
            break;
        }
      }
    }

    if(var_16 > 0) {
      if(isdefined(var_5[0])) {
        if(isstring(var_5[0]))
          var_5[1] = 1.0;

        var_2["oneshots"] = var_5;
      }

      if(isdefined(var_6[0]))
        var_2["loops"] = var_6;

      if(isdefined(var_7[0]))
        var_2["single_loops"] = var_7;

      if(isdefined(var_8[0]))
        var_2["first_event"] = dambx_get_two_value_float_array(var_8);

      if(isdefined(var_9[0]))
        var_2["event_time"] = dambx_get_two_value_float_array(var_9);

      if(isdefined(var_10[0]))
        var_2["radius"] = dambx_get_two_value_float_array(var_10);

      if(isdefined(var_11[0]))
        var_2["cone"] = dambx_get_two_value_float_array(var_11);

      if(isdefined(var_12[0]))
        var_2["delta"] = dambx_get_two_value_float_array(var_12);

      if(isdefined(var_13[0]))
        var_2["travel_time"] = dambx_get_two_value_float_array(var_13);

      if(isdefined(var_14[0]))
        var_2["pitch"] = dambx_get_two_value_float_array(var_14);

      if(isdefined(var_15[0]))
        var_2["pitch_time"] = dambx_get_two_value_float_array(var_15);

      if(!isdefined(var_2["radius"]))
        var_2["radius"] = [0.0, 0.01];
    }

    return var_2;
  }
}

dambx_get_component_from_string_table(var_0, var_1) {
  var_2 = soundscripts\_audio::get_damb_component_stringtable();
  var_3 = "soundtables\sp_defaults.csv";
  var_4 = [];

  if(var_1)
    var_4 = dambx_get_component_from_string_table_internal(var_2, var_0);

  if(!isdefined(var_4) || var_4.size == 0)
    var_4 = dambx_get_component_from_string_table_internal(var_3, var_0);

  if(!isdefined(var_4) || var_4.size == 0) {
    return;
  }
  return var_4;
}

dambx_get_preset_from_stringtable_internal(var_0, var_1) {
  var_2 = 7;
  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = packedtablesectionlookup(var_0, "dynamic_ambience_names", "zone_names;reverb_names;filter_names;occlusion_names;timescale_names;dynamic_ambience_names;components;loop_defs;whizby_preset_names;mix_names;healthfx_params");

  if(isdefined(var_7)) {
    for (var_8 = 1; var_8 < var_2; var_8++) {
      var_9 = packedtablelookupwithrange(var_0, 0, "dynamic_ambience_names", var_8, var_7[0], var_7[1]);
      var_10 = packedtablelookupwithrange(var_0, 0, var_1, var_8, var_7[0], var_7[1]);
      var_11 = 0;

      if(var_10 != "" && var_9 != "comments") {
        switch (var_9) {
          case "components":
            var_4 = dambx_get_list_value_from_string_table(var_10, "preset definition", "components");
            break;
          case "first_event_min":
            if(isdefined(var_10) && var_10 != "")
              var_5[0] = float(var_10);

            break;
          case "first_event_max":
            if(isdefined(var_10) && var_10 != "")
              var_5[1] = float(var_10);

            break;
          case "event_time_min":
            if(isdefined(var_10) && var_10 != "")
              var_6[0] = float(var_10);

            break;
          case "event_time_max":
            if(isdefined(var_10) && var_10 != "")
              var_6[1] = float(var_10);
          case "comment":
            break;
          default:
            break;
        }
      }
    }

    var_11 = 0;

    if(isdefined(var_5[0])) {
      var_11 = 1;
      var_3["first_event"] = var_5;
    }

    if(isdefined(var_6[0])) {
      var_11 = 1;
      var_3["event_time"] = var_6;
    }

    if(var_11) {
      if(isdefined(var_4[0][1]))
        var_3["components"] = var_4;
      else {
        var_3["components"] = [];

        for (var_8 = 0; var_8 < var_4.size; var_8++)
          var_3["components"][var_3["components"].size] = [var_4[0], 1.0];

        if(var_3["components"].size == 0)
          var_3["components"] = undefined;
      }
    } else if(var_4.size != 0)
      var_3["components"] = var_4;

    return var_3;
  }
}

dambx_get_preset_from_string_table(var_0, var_1) {
  var_2 = soundscripts\_audio::get_damb_stringtable();
  var_3 = "soundtables\sp_defaults.csv";
  var_4 = [];

  if(var_1)
    var_4 = dambx_get_preset_from_stringtable_internal(var_2, var_0);

  if(!isdefined(var_4) || var_4.size == 0)
    var_4 = dambx_get_preset_from_stringtable_internal(var_3, var_0);

  if(!isdefined(var_4) || var_4.size == 0) {
    return;
  }
  return var_4;
}

dambx_get_damb_preset(var_0) {
  var_1 = [];

  if(isdefined(level._audio.damb.preset_cache[var_0]))
    var_1 = level._audio.damb.preset_cache[var_0];
  else
    var_1 = dambx_get_preset_from_string_table(var_0, 1);

  if(!isdefined(var_1) || var_1.size == 0) {
    return;
  }
  level._audio.damb.preset_cache[var_0] = var_1;
  var_1["name"] = var_0;
  return var_1;
}

increment_ref_count() {
  level._audio.damb.entity_ref_count++;
}

decrement_ref_count() {
  level._audio.damb.entity_ref_count--;
}