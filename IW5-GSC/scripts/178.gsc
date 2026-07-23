/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\178.gsc
**************************************/

vm_init() {
  if(!isDefined(level._audio)) {
    level._audio = spawnStruct();
  }
  if(!isDefined(level._audio.veh)) {
    level._audio.veh = spawnStruct();
    level._audio.veh.minrate = 0.1;
    level._audio.veh.defrate = 0.5;
    level._audio.veh.defsmooth = 0.1;
    level._audio.veh.minpitch = 0.5;
    level._audio.veh.maxpitch = 1.5;
    level._audio.veh.fadein_time = 2.0;
    level._audio.veh.callbacks = [];
    level._audio.veh.print_speed = 0;
    level._audio.veh.print_tilt = 0;
    level._audio.veh.print_yaw = 0;
    level._audio.veh.print_roll = 0;
    level._audio.veh.print_altitude = 0;
    level._audio.veh.print_throttle = 0;
    level._audio.veh.presets = [];
    level._audio.veh.maps = [];
    level._audio.veh.instances = [];
    level._audio.veh.ducked_instances = [];
    level._audio.veh.duck_starts = [];
    level._audio.veh.duck_stops = [];
  }
}

vm_register_custom_callback(var_0, var_1) {
  level._audio.veh.callbacks[var_0] = var_1;
}

vm_start_preset(var_0, var_1, var_2, var_3, var_4, var_5) {
  wait 0.25;

  if(isDefined(level._audio.veh.instances[var_0])) {
    vm_stop_preset_instance(var_0);
  }
  if(isDefined(var_4)) {
    thread maps\_audio::aud_play_linked_sound(var_4, var_2, undefined, undefined, var_5);
  }
  level._audio.veh.instances[var_0] = [];
  level._audio.veh.instances[var_0]["entity"] = var_2;

  if(!isDefined(level._audio.veh.presets[var_1])) {
    var_6 = [];
    var_6 = maps\_audio_presets_vehicles::audio_presets_vehicles(var_1, var_6);
    level._audio.veh.presets[var_1] = var_6;
  }

  level._audio.veh.instances[var_0]["entity"] = var_2;

  foreach(var_19, var_8 in level._audio.veh.presets[var_1]) {
    var_9 = spawnStruct();
    var_9.instance_name = var_0;
    var_9.vehicle = var_2;

    switch (var_19) {
      case "tilt":
        var_9.type = "tilt";
        var_9.callback = ::vmx_get_tilt;
        var_9.min = -45.0;
        var_9.max = 45.0;
        break;
      case "yaw":
        var_9.type = "yaw";
        var_9.callback = ::vmx_get_yaw;
        var_9.min = 0.0;
        var_9.max = 360.0;
        break;
      case "roll":
        var_9.type = "roll";
        var_9.callback = ::vmx_get_roll;
        var_9.min = -45.0;
        var_9.max = 45.0;
        break;
      case "speed":
        var_9.type = "speed";
        var_9.callback = ::vmx_get_speed;
        var_9.min = 0.0;
        var_9.max = 100.0;
        break;
      case "altitude":
        var_9.type = "altitude";
        var_9.callback = ::vmx_get_altitude;
        var_9.min = 0.0;
        var_9.max = 100.0;
        break;
      case "start_stop":
        var_9.type = "start_stop";
        var_9.callback = ::vmx_get_throttle;
        var_9.min = 0.0;
        var_9.max = 1.0;
        break;
      default:
        break;
    }

    var_9.smoothness = level._audio.veh.defsmooth;
    var_9.smooth_up = undefined;
    var_9.smooth_down = undefined;
    var_9.updaterate = level._audio.veh.defrate;
    var_9.alias_data = [];
    var_9.fadein = 0.5;

    if(isDefined(var_3)) {
      var_9.fadein = var_3;
    }
    foreach(var_18, var_11 in var_8) {
      switch (var_11[0]) {
        case "updaterate":
          var_9.updaterate = var_11[1];
          break;
        case "smoothness":
          var_9.smoothness = var_11[1];
          break;
        case "smooth_up":
          var_9.smooth_up = var_11[1];
          break;
        case "smooth_down":
          var_9.smooth_down = var_11[1];
          break;
        case "heightmax":
          var_9.heightmax = var_11[1];
          break;
        case "callback":
          var_12 = var_11[1];
          var_9.custom_callback = level._audio.veh.callbacks[var_12];
          break;
        case "range":
          var_9.min = min(var_11[1], var_11[2]);
          var_9.max = max(var_11[1], var_11[2]);
          break;
        case "multiply_by_throttle":
          var_9.multiply_by_throttle = 1;
          break;
        case "multiply_by_leftstick":
          var_9.multiply_by_leftstick = 1;
          break;
        case "start":
          var_9.start_alias_data = spawnStruct();
          var_9.start_alias_data.name = var_11[1];

          for(var_13 = 2; var_13 < var_11.size; var_13++) {
            if(isarray(var_11[var_13])) {
              var_14 = var_11[var_13][0];
              var_15 = var_11[var_13][1];

              if(var_14 == "pitch") {
                var_9.start_alias_data.pitch_map_name = var_15;
              } else if(var_14 == "volume") {
                var_9.start_alias_data.volume_map_name = var_15;

              }
              if(!isDefined(level._audio.veh.maps[var_15])) {
                var_16 = [];
                var_16 = maps\_audio_presets_vehicles::audio_presets_vehicle_maps(var_15, var_16);
                level._audio.veh.maps[var_15] = var_16;
              }

              continue;
            }

            level._audio.veh.duck_starts[var_0] = var_11[var_13];
          }

          break;
        case "stop":
          var_9.stop_alias_data = spawnStruct();
          var_9.stop_alias_data.name = var_11[1];

          for(var_13 = 2; var_13 < var_11.size; var_13++) {
            if(isarray(var_11[var_13])) {
              var_14 = var_11[var_13][0];
              var_15 = var_11[var_13][1];

              if(var_14 == "pitch") {
                var_9.stop_alias_data.pitch_map_name = var_15;
              } else if(var_14 == "volume") {
                var_9.stop_alias_data.volume_map_name = var_15;

              }
              if(!isDefined(level._audio.veh.maps[var_15])) {
                var_16 = [];
                var_16 = maps\_audio_presets_vehicles::audio_presets_vehicle_maps(var_15, var_16);
                level._audio.veh.maps[var_15] = var_16;
              }

              continue;
            }

            level._audio.veh.duck_stops[var_0] = var_11[var_13];
          }

          break;
        case "throttle_input":
          var_9.throttle_input = var_11[1];
          break;
        case "on_threshold":
          var_9.on_threshold = var_11[1];
          break;
        case "off_threshold":
          var_9.off_threshold = var_11[1];
          break;
        case "oneshot_duck":
          var_9.duck_amount = var_11[1];
          break;
        case "oneshot_duck_time":
          var_9.duck_time = var_11[1];
          break;
        case "offset":
          var_9.offset = var_11[1];
          break;
        default:
          var_17 = spawnStruct();
          var_17.alias_name = var_11[0];

          for(var_13 = 1; var_13 < var_11.size; var_13++) {
            var_15 = var_11[var_13][1];

            if(var_11[var_13][0] == "pitch") {
              var_17.pitch_map_name = var_15;
            } else {
              var_17.vol_map_name = var_15;
            }
            if(!isDefined(level._audio.veh.maps[var_15])) {
              var_16 = [];
              var_16 = maps\_audio_presets_vehicles::audio_presets_vehicle_maps(var_15, var_16);
              level._audio.veh.maps[var_15] = var_16;
            }
          }

          var_9.alias_data[var_9.alias_data.size] = var_17;
          break;
      }
    }

    if(var_9.type == "start_stop") {
      thread vmx_do_start_stop_callback(var_9);
      continue;
    }

    thread vmx_callback(var_9);
  }
}

vm_stop(var_0) {
  level notify("aud_veh_stop");
  var_1 = 1.0;

  if(isDefined(var_0)) {
    var_1 = max(0.1, var_0);
  }
  foreach(var_3 in level._audio.veh.playing_presets) {
    if(var_3.size > 0) {
      foreach(var_5 in var_3) {}
      thread maps\_audio::aud_fade_out_and_delete(var_5, var_1);
    }
  }

  level._audio.veh.playing_presets = [];
}

vm_stop_preset_instance(var_0, var_1) {
  var_2 = 1.0;

  if(isDefined(var_1)) {
    var_2 = max(0.01, var_1);
  }
  if(isDefined(level._audio.veh.instances[var_0])) {
    level notify("aud_veh_stop_" + var_0);

    if(level._audio.veh.instances[var_0].size > 0) {
      foreach(var_5, var_4 in level._audio.veh.instances[var_0]) {
        if(var_5 != "entity" && var_5 != "speed" && var_5 != "throttle") {
          var_4 scalevolume(0.0, var_2);
        }
      }
    }

    wait(var_2 + 0.05);

    if(level._audio.veh.instances[var_0].size > 0) {
      foreach(var_5, var_4 in level._audio.veh.instances[var_0]) {
        if(var_5 != "entity" && var_5 != "speed" && var_5 != "throttle") {
          var_4 delete();
        }
      }
    }

    level._audio.veh.instances[var_0] = undefined;
  }
}

vm_set_range(var_0, var_1, var_2) {
  if(!isDefined(self.aud_overrides)) {
    self.aud_overrides = [];
  }
  self.aud_overrides[var_0] = spawnStruct();
  self.aud_overrides[var_0].min_range = var_1;
  self.aud_overrides[var_0].max_range = var_2;
}

vmx_monitor_oneshot_ent() {
  self.sound_playing = 1;
  self waittill("sounddone");
  self.sound_playing = 0;
}

vmx_waittill_endon_delete(var_0) {
  level common_scripts\utility::waittill_any("aud_veh_stop", "aud_veh_stop_" + var_0);

  if(self.sound_playing) {
    self scalevolume(0.0, 0.1);
    wait 0.1;
    self stopsounds();
    wait 0.05;
  }

  self delete();
}

vmx_stop_sound(var_0) {
  self scalevolume(0.0, 0.05);
  wait 0.05;
  self stopsounds();
  wait 0.05;
  self.sound_playing = 0;
}

vmx_play_oneshot_sound(var_0) {
  if(self.sound_playing) {
    vmx_stop_sound(0.0);
  }
  self playSound(var_0, "sounddone");
  thread vmx_monitor_oneshot_ent();
}

vmx_init_oneshot_ents(var_0) {
  if(!isDefined(level._audio.veh.start_ents)) {
    level._audio.veh.start_ents = [];
  }
  if(!isDefined(level._audio.veh.stop_ents)) {
    level._audio.veh.stop_ents = [];
  }
  if(!isDefined(level._audio.veh.start_ent_count)) {
    level._audio.veh.start_ent_count = [];
  }
  if(!isDefined(level._audio.veh.stop_ent_count)) {
    level._audio.veh.stop_ent_count = [];
  }
  level._audio.veh.start_ents[var_0] = [];
  level._audio.veh.start_ent_count[var_0] = 0;
  level._audio.veh.stop_ents[var_0] = [];
  level._audio.veh.stop_ent_count[var_0] = 0;
}

vmx_get_need_to_duck(var_0) {
  var_1 = 0;

  if(isDefined(level._audio.veh.duck_starts[var_0]) && level._audio.veh.duck_starts[var_0] && vmx_get_start_sound_playing(var_0)) {
    var_1 = 1;
  }
  if(isDefined(level._audio.veh.duck_stops[var_0]) && level._audio.veh.duck_stops[var_0] && vmx_get_stop_sound_playing(var_0)) {
    var_1 = 1;
  }
  return var_1;
}

vmx_get_start_sound_playing(var_0) {
  if(level._audio.veh.start_ents[var_0].size > 0) {
    return 1;
  }
  return 0;
}

vmx_get_stop_sound_playing(var_0) {
  if(level._audio.veh.stop_ents[var_0].size > 0) {
    return 1;
  }
  return 0;
}

vmx_scale_start_sound_pitch(var_0, var_1, var_2) {
  foreach(var_4 in level._audio.veh.start_ents[var_2]) {
    if(isDefined(var_4)) {
      var_4 setpitch(var_0, var_1);
    }
  }
}

vmx_scale_stop_sound_pitch(var_0, var_1, var_2) {
  foreach(var_4 in level._audio.veh.stop_ents[var_2]) {
    if(isDefined(var_4)) {
      var_4 setpitch(var_0, var_1);
    }
  }
}

vmx_scale_start_sound_volume(var_0, var_1, var_2) {
  foreach(var_4 in level._audio.veh.start_ents[var_2]) {
    if(isDefined(var_4)) {
      var_4 scalevolume(var_0, var_1);
    }
  }
}

vmx_scale_stop_sound_volume(var_0, var_1, var_2) {
  foreach(var_4 in level._audio.veh.stop_ents[var_2]) {
    if(isDefined(var_4)) {
      var_4 scalevolume(var_0, var_1);
    }
  }
}

vmx_play_start_sound(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if(isDefined(var_3)) {
    var_4 = var_3;
  }
  var_5 = spawn("script_origin", var_1.origin);
  var_5 linkTo(var_1, "tag_origin", (var_4, 0, 0), (0, 0, 0));
  var_5.ref = level._audio.veh.start_ent_count[var_2];
  var_5 playSound(var_0, "sounddone");
  var_5 thread vmx_monitor_start_ent(var_2);
  level._audio.veh.start_ents[var_2][var_5.ref] = var_5;
  level._audio.veh.start_ent_count[var_2]++;
}

vmx_play_stop_sound(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if(isDefined(var_3)) {
    var_4 = var_3;
  }
  var_5 = spawn("script_origin", var_1.origin);
  var_5 linkTo(var_1, "tag_origin", (var_4, 0, 0), (0, 0, 0));
  var_5.ref = level._audio.veh.stop_ent_count[var_2];
  var_5 playSound(var_0, "sounddone");
  level._audio.veh.stop_ents[var_2][var_5.ref] = var_5;
  level._audio.veh.stop_ent_count[var_2]++;
  wait 0.05;
  var_5 thread vmx_monitor_stop_ent(var_2);
}

vmx_monitor_start_ent(var_0) {
  self endon("kill");
  self waittill("sounddone");
  level._audio.veh.start_ents[var_0][self.ref] = undefined;

  if(isDefined(level._audio.veh.ducked_instances[var_0])) {
    level._audio.veh.ducked_instances[var_0] = undefined;
  }
  self delete();
}

vmx_monitor_stop_ent(var_0) {
  self endon("kill");
  self waittill("sounddone");
  level._audio.veh.stop_ents[var_0][self.ref] = undefined;

  if(isDefined(level._audio.veh.ducked_instances[var_0])) {
    level._audio.veh.ducked_instances[var_0] = undefined;
  }
  self delete();
}

vmx_stop_stop_ent(var_0, var_1, var_2) {
  if(isDefined(level._audio.veh.ducked_instances[var_2])) {
    level._audio.veh.ducked_instances[var_2] = undefined;
  }
  var_3 = 0.1;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }
  level._audio.veh.stop_ents[var_2][var_0.ref] = undefined;
  var_0 scalevolume(0.0, var_3 + 0.05);
  var_0 notify("kill");
  wait(var_3 + 0.05);
  var_0 stopsounds();
  wait 0.05;
  var_0 delete();
}

vmx_stop_start_ent(var_0, var_1, var_2) {
  if(isDefined(level._audio.veh.ducked_instances[var_2])) {
    level._audio.veh.ducked_instances[var_2] = undefined;
  }
  var_3 = 0.1;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }
  level._audio.veh.start_ents[var_2][var_0.ref] = undefined;
  var_0 scalevolume(0.0, var_3 + 0.05);
  var_0 notify("kill");
  wait(var_3 + 0.05);
  var_0 stopsounds();
  wait 0.05;
  var_0 delete();
}

vmx_do_start_stop_callback(var_0) {
  var_1 = var_0.instance_name;
  level endon("aud_veh_stop");
  level endon("aud_veh_stop_" + var_1);
  level._audio.veh.instances[var_1]["entity"] endon("death");
  var_2 = 0;
  var_3 = 0;
  var_4 = -1;
  var_5 = "off";
  var_6 = var_0.smoothness;
  var_7 = var_0.smooth_up;
  var_8 = var_0.smooth_down;
  var_9 = var_0.min;
  var_10 = var_0.max;
  var_11 = 0;
  vmx_init_oneshot_ents(var_1);
  var_12 = gettime();

  for(;;) {
    var_13 = [[var_0.callback]](var_0);
    var_13 = (var_13 - var_0.min) / (var_0.max - var_0.min);
    var_13 = clamp(var_13, 0.0, 1.0);
    var_11 = var_13;

    if(isDefined(var_7) && var_13 > var_2) {
      var_2 = var_2 + var_7 * (var_13 - var_2);
    } else if(isDefined(var_8) && var_13 <= var_2) {
      var_2 = var_2 + var_8 * (var_13 - var_2);
    } else {
      var_2 = var_2 + var_6 * (var_13 - var_2);
    }
    var_14 = var_2 - var_3;
    var_3 = var_2;
    var_15 = gettime();
    var_16 = var_15 - var_12;
    var_17 = 0;
    var_18 = 0;

    if((var_14 >= var_0.on_threshold || var_11 >= 0.99) && var_5 == "off" && var_16 > 200) {
      var_12 = var_15;
      var_5 = "on";
      var_17 = 1;
      wait 0.05;
      var_19 = level._audio.veh.instances[var_1]["entity"];
      thread vmx_play_start_sound(var_0.start_alias_data.name, var_19, var_0.instance_name, var_0.offset);

      if(isDefined(level._audio.veh.stop_ents[var_0.instance_name])) {
        var_20 = level._audio.veh.stop_ents[var_0.instance_name];

        foreach(var_19 in var_20) {}
        thread vmx_stop_stop_ent(var_19, undefined, var_0.instance_name);
      }
    } else if((var_14 <= var_0.off_threshold || var_11 <= 0.01) && var_5 == "on" && var_16 > 200) {
      var_12 = var_15;
      var_5 = "off";
      var_18 = 1;
      wait 0.05;
      var_19 = level._audio.veh.instances[var_1]["entity"];
      thread vmx_play_stop_sound(var_0.stop_alias_data.name, var_19, var_0.instance_name, var_0.offset);

      if(isDefined(level._audio.veh.start_ents[var_0.instance_name])) {
        var_23 = level._audio.veh.start_ents[var_0.instance_name];

        foreach(var_19 in var_23) {}
        thread vmx_stop_start_ent(var_19, undefined, var_0.instance_name);
      }
    }

    var_26 = undefined;
    var_27 = undefined;

    if(vmx_get_start_sound_playing(var_0.instance_name)) {
      if(var_17) {
        var_17 = 0;

        if(isDefined(var_0.start_alias_data.pitch_map_name)) {
          var_26 = maps\_audio::aud_map(var_2, level._audio.veh.maps[var_0.start_alias_data.pitch_map_name]);
          var_26 = level._audio.veh.minpitch + var_26 * (level._audio.veh.maxpitch - level._audio.veh.minpitch);
          vmx_scale_start_sound_pitch(var_26, var_0.updaterate, var_0.instance_name);
        }
      }

      if(isDefined(var_0.start_alias_data.vol_map_name)) {
        var_27 = maps\_audio::aud_map(var_2, level._audio.veh.maps[var_0.start_alias_data.vol_map_name]);
        vmx_scale_start_sound_volume(var_27, var_0.updaterate, var_0.instance_name);
      }
    }

    if(vmx_get_stop_sound_playing(var_0.instance_name)) {
      if(var_18) {
        var_18 = 0;

        if(isDefined(var_0.stop_alias_data.pitch_map_name)) {
          var_26 = maps\_audio::aud_map(var_2, level._audio.veh.maps[var_0.stop_alias_data.pitch_map_name]);
          var_26 = level._audio.veh.minpitch + var_26 * (level._audio.veh.maxpitch - level._audio.veh.minpitch);
          vmx_scale_stop_sound_pitch(var_26, var_0.updaterate, var_0.instance_name);
        }
      }

      if(isDefined(var_0.stop_alias_data.vol_map_name)) {
        var_27 = maps\_audio::aud_map(var_2, level._audio.veh.maps[var_0.stop_alias_data.vol_map_name]);
        vmx_scale_stop_sound_volume(var_27, var_0.updaterate, var_0.instance_name);
      }
    }

    var_4 = var_2;
    wait(var_0.updaterate);
  }
}

vm_disablethrottleupdate(var_0) {
  self.aud_engine_disable = 1;

  if(isDefined(var_0)) {
    self.aud_engine_throttle_amount = var_0;
  }
}

vm_enablethrottleupdate() {
  self.aud_engine_disable = undefined;
}

vmx_callback(var_0) {
  var_1 = var_0.instance_name;
  level endon("aud_veh_stop");
  level endon("aud_veh_stop_" + var_1);
  var_2 = undefined;
  var_3 = var_0.smoothness;
  var_4 = var_0.smooth_up;
  var_5 = var_0.smooth_down;
  var_6 = var_0.min;
  var_7 = var_0.max;

  if(isDefined(var_0.heightmax)) {
    var_8 = level._audio.veh.instances[var_1]["entity"];
    var_0.init_height = var_8.origin[2];
  }

  var_9 = 1;

  for(;;) {
    var_0.smoothness = var_3;
    var_0.smooth_up = var_4;
    var_0.smooth_down = var_5;
    var_8 = level._audio.veh.instances[var_1]["entity"];

    if(isDefined(var_8.aud_overrides) && isDefined(var_8.aud_overrides[var_0.type]) && isDefined(var_8.aud_overrides[var_0.type].min_range)) {
      var_0.min = var_8.aud_overrides[var_0.type].min_range;
      var_0.max = var_8.aud_overrides[var_0.type].max_range;
    } else {
      var_0.min = var_6;
      var_0.max = var_7;
    }

    if(!isDefined(var_8)) {
      vm_stop(var_0.instance_name);
      return;
    }

    var_10 = 0;
    var_11 = 0;

    if(isDefined(var_8.aud_engine_disable)) {
      var_10 = var_8.aud_engine_disable;

      if(isDefined(var_8.aud_engine_throttle_amount)) {
        var_11 = var_8.aud_engine_throttle_amount;
      }
    }

    var_12 = [[var_0.callback]](var_0);

    if(isDefined(var_0.multiply_by_throttle)) {
      if(var_10) {
        var_13 = var_11;
      } else {
        var_13 = vmx_get_throttle(var_0);
      }
      if(level._audio.veh.print_throttle) {
        iprintln("throttle: " + var_13);
      }
      var_12 = var_12 * var_13;
    }

    var_12 = (var_12 - var_0.min) / (var_0.max - var_0.min);
    var_12 = clamp(var_12, 0.0, 1.0);

    if(isDefined(var_2)) {
      if(isDefined(var_0.smooth_up) && var_12 > var_2) {
        var_2 = var_2 + var_0.smooth_up * (var_12 - var_2);
      } else if(isDefined(var_0.smooth_down) && var_12 <= var_2) {
        var_2 = var_2 + var_0.smooth_down * (var_12 - var_2);
      } else {
        var_2 = var_2 + var_0.smoothness * (var_12 - var_2);
      }
    } else {
      var_2 = var_12;
    }
    if(isDefined(var_0.custom_callback)) {
      [[var_0.custom_callback]](var_8, var_2);
    }
    foreach(var_15 in var_0.alias_data) {}
    thread vmx_update_sound(var_15, var_0, var_2, var_1, var_9);

    if(var_9) {
      var_9 = 0;
      wait(var_0.fadein);
      continue;
    }

    wait(var_0.updaterate);
  }
}

vmx_update_sound(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_0.pitch_map_name)) {
    var_5 = maps\_audio::aud_map(var_2, level._audio.veh.maps[var_0.pitch_map_name]);
    var_5 = level._audio.veh.minpitch + var_5 * (level._audio.veh.maxpitch - level._audio.veh.minpitch);
  }

  if(isDefined(var_0.vol_map_name)) {
    var_6 = maps\_audio::aud_map(var_2, level._audio.veh.maps[var_0.vol_map_name]);
  }
  var_7 = 0;
  var_8 = 0;

  if(isDefined(level._audio.veh.ducked_instances[var_3])) {
    var_9 = level._audio.veh.ducked_instances[var_3];
    var_10 = gettime();
    var_11 = 2.5;

    if(isDefined(var_1.duck_time)) {
      var_11 = var_1.duck_time;
    }
    if(var_10 - var_9 < var_11 * 1000) {
      var_7 = 1;
    }
  }

  if(!var_7) {
    if(!isDefined(level._audio.veh.ducked_instances[var_3]) && vmx_get_need_to_duck(var_3)) {
      var_7 = 1;
      level._audio.veh.ducked_instances[var_3] = gettime();
    }
  }

  if(var_7) {
    var_12 = 0.7;

    if(isDefined(var_1.duck_amount)) {
      var_12 = var_1.duck_amount;
    }
    var_6 = var_6 * var_12;
  }

  if(isDefined(var_1.heightmax)) {
    var_13 = var_1.vehicle.origin[2];
    var_14 = var_13 - var_1.init_height;

    if(var_14 > var_1.heightmax) {
      var_6 = 0;
    }
  }

  if(!isDefined(level._audio.veh.instances[var_3][var_0.alias_name])) {
    level._audio.veh.instances[var_3][var_0.alias_name] = spawn("script_origin", var_1.vehicle.origin);
    var_15 = 0;

    if(isDefined(var_1.offset)) {
      var_15 = var_1.offset;
    }
    level._audio.veh.instances[var_3][var_0.alias_name] linkTo(var_1.vehicle, "tag_origin", (var_15, 0, 0), (0, 0, 0));
    level._audio.veh.instances[var_3][var_0.alias_name] playLoopSound(var_0.alias_name);
    level._audio.veh.instances[var_3][var_0.alias_name] scalevolume(0.0);
    wait 0.05;
    level._audio.veh.instances[var_3][var_0.alias_name] scalevolume(var_6, var_1.fadein);
  } else {
    if(isDefined(var_5)) {
      level._audio.veh.instances[var_3][var_0.alias_name] setpitch(var_5, var_1.updaterate);
    }
    if(isDefined(var_6)) {
      level._audio.veh.instances[var_3][var_0.alias_name] scalevolume(var_6, var_1.updaterate);
    }
  }
}

vm_linkto_new_entity(var_0, var_1, var_2, var_3) {
  var_4 = "tag_origin";

  if(isDefined(var_2)) {
    var_4 = "tag_origin";
  }
  var_5 = 0;

  if(isDefined(var_3)) {
    var_5 = var_3;
  }
  if(isDefined(level._audio.veh.instances[var_0])) {
    foreach(var_8, var_7 in level._audio.veh.instances[var_0]) {
      if(var_8 != "entity" && var_8 != "speed" && var_8 != "throttle") {
        var_7 unlink();
        var_7 linkTo(var_1, var_4, (var_5, 0, 0), (0, 0, 0));
      }
    }

    level._audio.veh.instances[var_0]["entity"] = var_1;
  }
}

vm_set_speed_callback(var_0, var_1) {
  if(isDefined(level._audio.veh.instances[var_0])) {
    level._audio.veh.instances[var_0]["speed"] = var_1;
  }
}

vm_set_throttle_callback(var_0, var_1) {
  if(isDefined(level._audio.veh.instances[var_0])) {
    level._audio.veh.instances[var_0]["throttle"] = var_1;
  }
}

vm_set_start_stop_callback(var_0, var_1) {
  if(isDefined(level._audio.veh.instances[var_0])) {
    return;
  }
}

vmx_get_tilt(var_0) {
  var_1 = level._audio.veh.instances[var_0.instance_name]["entity"];
  var_2 = var_1.angles[0];

  if(level._audio.veh.print_tilt) {
    iprintln("tilt: " + var_2);
  }
  return var_2;
}

vmx_get_speed(var_0) {
  var_1 = level._audio.veh.instances[var_0.instance_name]["entity"];
  var_2 = 0;

  if(isDefined(level._audio.veh.instances[var_0.instance_name]["speed"])) {
    var_3 = level._audio.veh.instances[var_0.instance_name]["speed"];
    var_2 = var_1[[var_3]]();
  } else {
    var_2 = var_0.vehicle vehicle_getspeed();
  }
  if(level._audio.veh.print_speed) {
    iprintln("speed: " + var_2);
  }
  return var_2;
}

vmx_get_yaw(var_0) {
  var_1 = level._audio.veh.instances[var_0.instance_name]["entity"];
  var_2 = var_1.angles[1];

  if(level._audio.veh.print_speed) {
    iprintln("yaw: " + var_2);
  }
  return var_2;
}

vmx_get_roll(var_0) {
  var_1 = level._audio.veh.instances[var_0.instance_name]["entity"];
  var_2 = var_1.angles[2];

  if(level._audio.veh.print_roll) {
    iprintln("roll: " + var_2);
  }
  return var_2;
}

vmx_get_altitude(var_0) {
  var_1 = level._audio.veh.instances[var_0.instance_name]["entity"];
  return 1.0;
}

vmx_get_throttle(var_0) {
  var_1 = level._audio.veh.instances[var_0.instance_name]["entity"];
  var_2 = 0;

  if(isDefined(level._audio.veh.instances[var_0.instance_name]["throttle"])) {
    var_3 = level._audio.veh.instances[var_0.instance_name]["speed"];
    var_2 = var_1[[var_3]]();
  } else if(isDefined(var_0.throttle_input) && var_0.throttle_input == "leftstick") {
    var_4 = level.player getnormalizedmovement();
    var_5 = var_4[0];
    var_2 = 0;

    if(var_5 >= 0) {
      var_2 = var_5;
    }
  } else if(isDefined(var_0.throttle_input) && var_0.throttle_input == "leftstick_abs") {
    var_4 = level.player getnormalizedmovement();
    var_5 = abs(var_4[0]);
    var_6 = abs(var_4[1]);
    var_2 = 2 * sqrt(var_5 * var_5 + var_6 * var_6);
    var_2 = clamp(var_2, 0, 1);
  } else if(isDefined(var_0.throttle_input) && var_0.throttle_input == "attack") {
    if(level.player attackButtonPressed()) {
      var_2 = 1.0;
    } else {
      var_2 = 0.0;
    }
  } else {
    var_2 = var_1 vehicle_getthrottle();
  }
  return var_2;
}

vm_ground_vehicle_start(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  self.veh_aliases = spawnStruct();
  self.veh_aliases.move_lo_lp = var_0;
  self.veh_aliases.rolling_lp = var_1;
  self.veh_aliases.idle_lp = var_2;
  self.veh_aliases.engine_rev_lo_os = var_3;
  self.veh_aliases.breaks_os = var_4;
  thread vmx_monitor_explosion(var_5);
  thread vmx_ground_vehicle_monitor_death();
  thread vmx_cleanup_ents();
  vmx_vehicle_engine();
}

vmx_vehicle_engine() {
  self endon("death");
  self.do_rev = 1;
  self.ents_mixed_in = 0;
  self.has_idle_played = 0;
  self.has_move_played = 0;
  self.has_roll_played = 0;
  self.veh_mix_ents = spawnStruct();
  self.veh_mix_ents.idle_ent = spawn("script_origin", self.origin);
  self.veh_mix_ents.idle_ent linkTo(self);
  self.veh_mix_ents.move_ent = spawn("script_origin", self.origin);
  self.veh_mix_ents.move_ent linkTo(self);
  self.veh_mix_ents.roll_ent = spawn("script_origin", self.origin);
  self.veh_mix_ents.roll_ent linkTo(self);
  self.veh_mix_ents.one_shot = spawn("script_origin", self.origin);
  self.veh_mix_ents.one_shot linkTo(self);

  for(;;) {
    var_0 = self vehicle_getspeed();

    if(var_0 > 0.05) {
      self.do_rev = 1;
      vmx_ground_speed_watch(var_0);
    }

    wait 0.25;
  }
}

vmx_ground_speed_watch(var_0) {
  self endon("death");
  var_1 = 0.5;
  var_2 = 1.5;
  var_3 = 0;

  for(;;) {
    var_4 = var_0;
    wait 0.1;
    var_5 = 0.5 + self vehicle_getspeed();

    if(var_5 >= var_4) {
      if(isDefined(self.veh_aliases.idle_lp) && self.has_idle_played) {
        self.veh_mix_ents.idle_ent thread vmx_aud_ent_fade_out(0.5);
      }
      if(self.do_rev) {
        self.do_rev = 0;

        if(isDefined(self.veh_aliases.engine_rev_lo_os)) {
          self.veh_mix_ents.one_shot playSound(self.veh_aliases.engine_rev_lo_os);
        }
      } else {
        if(isDefined(self.veh_aliases.rolling_lp) && !self.has_roll_played) {
          self.has_roll_played = 1;
          self.veh_mix_ents.roll_ent playLoopSound(self.veh_aliases.rolling_lp);
        }

        if(isDefined(self.veh_aliases.move_lo_lp) && !self.has_move_played) {
          self.has_move_played = 1;
          self.veh_mix_ents.move_ent playLoopSound(self.veh_aliases.move_lo_lp);
        }

        if(!var_3) {
          if(isDefined(self.veh_aliases.move_lo_lp)) {
            self.veh_mix_ents.move_ent thread vmx_aud_ent_fade_in(var_1);
          }
          if(isDefined(self.veh_aliases.rolling_lp)) {
            self.veh_mix_ents.roll_ent thread vmx_aud_ent_fade_in(var_1);
          }
          var_3 = 1;
        }
      }
    } else if(var_5 < var_4) {
      if(isDefined(self.veh_aliases.idle_lp)) {
        if(!self.has_idle_played) {
          self.has_idle_played = 1;
          self.veh_mix_ents.idle_ent playLoopSound(self.veh_aliases.idle_lp);
        }

        self.veh_mix_ents.idle_ent thread vmx_aud_ent_fade_in(0.5);
      }

      if(isDefined(self.veh_aliases.breaks_os)) {
        self.veh_mix_ents.one_shot playSound(self.veh_aliases.breaks_os);
      }
      if(isDefined(self.veh_aliases.move_lo_lp)) {
        self.veh_mix_ents.move_ent thread vmx_aud_ent_fade_out(0.5);
      }
      if(isDefined(self.veh_aliases.move_lo_lp)) {
        self.veh_mix_ents.roll_ent thread vmx_aud_ent_fade_out(0.1);
      }
      return;
    }

    wait 0.2;
  }
}

vmx_aud_ent_fade_out(var_0) {
  self scalevolume(0.0, var_0);
}

vmx_aud_ent_fade_in(var_0, var_1) {
  var_2 = 1.0;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }
  self scalevolume(0.0);
  wait 0.05;
  self scalevolume(var_2, var_0);
}

vmx_cleanup_ents() {
  self waittill("cleanup_sound_ents");
  self.veh_mix_ents.idle_ent stoploopsound();
  self.veh_mix_ents.move_ent stoploopsound();
  self.veh_mix_ents.roll_ent stoploopsound();
  self.veh_mix_ents.one_shot stopsounds();
  wait 0.05;
  self.veh_mix_ents.idle_ent delete();
  self.veh_mix_ents.move_ent delete();
  self.veh_mix_ents.roll_ent delete();
  self.veh_mix_ents.one_shot delete();
}

vmx_ground_vehicle_monitor_death() {
  self endon("cleanup_sound_ents");
  self waittill("death");
  self notify("cleanup_sound_ents");
}

vmx_monitor_explosion(var_0) {
  self endon("cleanup_sound_ents");

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(self.health < self.healthbuffer) {
      break;
    }

    wait 0.05;
  }

  self notify("died");

  if(isDefined(var_0)) {
    common_scripts\utility::play_sound_in_space(var_0, self.origin);
  }
  self notify("ceanup_sound_ents");
}

vm_aud_air_vehicle_flyby(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0;

  if(isDefined(var_3)) {
    var_6 = var_3;
  }
  var_7 = 0;

  if(isDefined(var_4)) {
    var_7 = var_4;
  }
  while(isDefined(var_0)) {
    if(var_7) {
      var_8 = distance(var_0.origin, level.player.origin);
    } else {
      var_8 = distance2d(var_0.origin, level.player.origin);
    }
    if(var_6) {
      iprintln("Distance: " + var_8);
    }
    if(var_8 < var_2) {
      var_9 = spawn("script_origin", var_0.origin);
      var_9 linkTo(var_0);
      var_9 playSound(var_1, "sounddone");
      var_0 notify("flyby_sound_played");
      var_9 thread vmx_waittill_deathspin(var_0);
      var_9 thread vmx_waittill_sounddone();
      var_9 waittill("flyby_ent", var_10);

      if(var_10 == "deathspin") {
        if(isDefined(var_5)) {
          thread common_scripts\utility::play_sound_in_space(var_5, var_9.origin);
        }
        var_9 scalevolume(0.0, 0.3);
        wait 0.4;
        var_9 stopsounds();
        wait 0.05;
        var_9 delete();
        return;
      } else if(var_10 == "sounddone") {
        wait 0.1;
        var_9 delete();
        return;
      }

      continue;
    }

    wait 0.05;
  }
}

vmx_waittill_deathspin(var_0) {
  self endon("flyby_ent");
  var_0 waittill("deathspin");
  self notify("flyby_ent", "deathspin");
}

vmx_waittill_sounddone() {
  self endon("flyby_ent");
  self waittill("sounddone");
  self notify("flyby_ent", "sounddone");
}