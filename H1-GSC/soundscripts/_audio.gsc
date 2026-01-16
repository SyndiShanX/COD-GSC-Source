/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: soundscripts\_audio.gsc
********************************/

aud_init(var_0) {
  if(isdefined(var_0))
    aud_set_level_fade_time(var_0);

  soundscripts\_snd::snd_init();

  if(!isdefined(level.aud))
    level.aud = spawnstruct();

  if(!isdefined(level.script))
    level.script = tolower(getdvar("mapname"));

  if(!isdefined(level._audio))
    level._audio = spawnstruct();

  level._audio.using_string_tables = 0;
  level._audio.stringtables = [];
  level._audio.message_handlers = [];
  level._audio.progress_trigger_callbacks = [];
  level._audio.progress_maps = [];
  level._audio.vo_duck_active = 0;
  level._audio.sticky_threat = undefined;
  level._audio.player_state = spawnstruct();
  level._audio.player_state.locamote = "idle";
  level._audio.player_state.locamote_prev = "idle";
  level.ambient_reverb = [];
  level.ambient_track = [];
  level.fxfireloopmod = 1;
  level.reverb_track = "";
  level.eq_main_track = 0;
  level.eq_mix_track = 1;
  level.eq_track[level.eq_main_track] = "";
  level.eq_track[level.eq_mix_track] = "";
  soundscripts\_audio_stream_manager::sm_init();
  soundscripts\_audio_dynamic_ambi::damb_init();
  soundscripts\_audio_zone_manager::azm_init();
  thread soundscripts\_audio_mix_manager::mm_init();
  soundscripts\_audio_reverb::rvb_init();
  soundscripts\_audio_whizby::whiz_init();
  soundscripts\_audio_vehicle_manager::avm_init();
  soundscripts\_audio_music::mus_init();
  thread aud_level_fadein();
  init_deathsdoor();
  deprecated_aud_register_msg_handler(::deprecated__audio_msg_handler);
}

aud_set_level_fade_time(var_0) {
  if(!isdefined(level._audio))
    level._audio = spawnstruct();

  level._audio.level_fade_time = var_0;
}

aud_level_fadein() {
  if(!isdefined(level._audio.level_fade_time))
    level._audio.level_fade_time = 1.0;

  wait 0.05;

  if(common_scripts\utility::flag_exist("chyron_video_done"))
    common_scripts\utility::flag_wait("chyron_video_done");

  levelsoundfade(1, level._audio.level_fade_time);
}

aud_is_specops() {
  return isdefined(level._audio.specops);
}

audx_set_spec_ops() {
  if(!isdefined(level._audio))
    level._audio = spawnstruct();

  level._audio.specops = 1;
}

aud_set_spec_ops() {
  thread audx_set_spec_ops();
}

aud_stop_line_emitter(var_0) {
  level notify(var_0 + "_line_emitter_stop");
}

aud_play_line_emitter(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0.1;
  var_7 = 0.1;

  if(isdefined(var_4)) {
    var_6 = max(var_4, 0);
    var_7 = max(var_4, 0);
  }

  if(isdefined(var_5))
    var_7 = max(var_5, 0);

  var_8 = spawn("script_origin", (0, 0, 0));
  var_8.alias = var_1;
  var_8.is_playing = 0;
  var_8.point1 = var_2;
  var_8.point2 = var_3;
  var_8.fade_in = var_6;
  var_8.label = var_0;
  var_8 thread audx_play_line_emitter_internal();
  level waittill(var_0 + "_line_emitter_stop");
  var_8 scalevolume(0, var_7);
  wait(var_7);
  var_8 soundscripts\_snd_playsound::snd_stop_sound();
  wait 0.05;
  var_8 delete();
}

audx_play_line_emitter_internal() {
  level endon(self.label + "_line_emitter_stop");
  var_0 = self.point2 - self.point1;
  var_1 = vectornormalize(var_0);
  var_2 = distance(self.point1, self.point2);
  var_3 = 0.1;

  for (;;) {
    var_4 = level.player.origin - self.point1;
    var_5 = vectordot(var_4, var_1);
    var_5 = clamp(var_5, 0, var_2);
    var_6 = self.point1 + var_1 * var_5;

    if(!self.is_playing) {
      self.origin = var_6;
      soundscripts\_snd_playsound::snd_play_loop(self.alias);
      self scalevolume(0);
      wait 0.05;
      self scalevolume(1.0, self.fade_in);
      self.is_playing = 1;
    } else
      self moveto(var_6, var_3);

    wait(var_3);
  }
}

aud_play_point_source_loop(var_0, var_1, var_2, var_3) {
  var_4 = aud_get_optional_param(1.0, var_2);
  var_5 = aud_get_optional_param(1.0, var_3);
  var_6 = spawn("script_origin", var_1);
  deprecated_aud_fade_sound_in(var_6, var_0, var_4, var_5, 1);
  return var_6;
}

aud_stop_point_source_loop(var_0, var_1) {
  var_2 = aud_get_optional_param(1.0, var_1);
  aud_fade_out_and_delete(var_0, var_2);
}

aud_set_point_source_loop_volume(var_0, var_1, var_2) {
  var_1 = clamp(var_1, 0, 1.0);
  var_3 = aud_get_optional_param(1.0, var_2);
  var_0 scalevolume(var_1, var_3);
}

aud_set_music_submix(var_0, var_1) {
  if(var_0 == 1.0) {
    soundscripts\_audio_mix_manager::mm_make_submix_unsticky("music");
    soundscripts\_audio_mix_manager::mm_clear_submix("music", var_1);
  } else {
    soundscripts\_audio_mix_manager::mm_scale_submix("music", var_0, var_1);
    soundscripts\_audio_mix_manager::mm_make_submix_sticky("music");
  }

  level._audio.curr_music_submix = var_0;
}

aud_set_ambi_submix(var_0, var_1) {
  if(var_0 == 1.0) {
    soundscripts\_audio_mix_manager::mm_make_submix_unsticky("ambi");
    soundscripts\_audio_mix_manager::mm_clear_submix("ambi", var_1);
  } else {
    soundscripts\_audio_mix_manager::mm_scale_submix("ambi", var_0, var_1);
    soundscripts\_audio_mix_manager::mm_make_submix_sticky("ambi");
  }

  level._audio.curr_ambi_submix = var_0;
}

aud_get_music_submix() {
  var_0 = 1.0;

  if(isdefined(level._audio.curr_music_submix))
    var_0 = level._audio.curr_music_submix;

  return var_0;
}

aud_get_ambi_submix() {
  var_0 = 1.0;

  if(isdefined(level._audio.curr_ambi_submix))
    var_0 = level._audio.curr_ambi_submix;

  return var_0;
}

trigger_multiple_audio_trigger(var_0) {
  if(!isdefined(level._audio))
    level._audio = spawnstruct();

  if(!isdefined(level._audio.trigger_functions))
    level._audio.trigger_functions = [];

  var_1 = undefined;

  if(isdefined(var_0) && var_0) {
    if(isdefined(self.ambient))
      var_1 = strtok(self.ambient, " ");
  } else if(isdefined(self.script_audio_zones))
    var_1 = strtok(self.script_audio_zones, " ");
  else if(isdefined(self.audio_zones))
    var_1 = strtok(self.audio_zones, " ");

  if(isdefined(var_1) && var_1.size == 2) {} else if(isdefined(var_1) && var_1.size == 1) {
    for (;;) {
      self waittill("trigger", var_2);
      soundscripts\_audio_zone_manager::azm_start_zone(var_1[0], self.script_duration);
    }
  }

  if(isdefined(self.script_audio_progress_map)) {
    if(!isdefined(level._audio.progress_maps[self.script_audio_progress_map])) {
      aud_print_error("Trying to set a progress_map_function without defining the envelope in the level.aud.envs array.");
      self.script_audio_progress_map = undefined;
    }
  }

  if(!isdefined(level._audio.trigger_function_keys))
    level._audio.trigger_function_keys = [];

  if(isdefined(self.script_audio_enter_func))
    level._audio.trigger_function_keys[level._audio.trigger_function_keys.size] = self.script_audio_enter_func;

  if(isdefined(self.script_audio_exit_func))
    level._audio.trigger_function_keys[level._audio.trigger_function_keys.size] = self.script_audio_exit_func;

  if(isdefined(self.script_audio_progress_func))
    level._audio.trigger_function_keys[level._audio.trigger_function_keys.size] = self.script_audio_progress_func;

  if(isdefined(self.script_audio_point_func))
    level._audio.trigger_function_keys[level._audio.trigger_function_keys.size] = self.script_audio_point_func;

  if(!isdefined(self.script_audio_blend_mode))
    self.script_audio_blend_mode = "blend";

  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(isdefined(self.target)) {
    if(!isdefined(common_scripts\utility::get_target_ent())) {
      aud_print_error("Audo Zone Trigger at " + self.origin + " has defined a target, " + self.target + ", but that target doesn't exist.");
      return;
    }

    if(isdefined(trigger_multiple_audio_get_target_ent_target())) {
      var_3 = trigger_multiple_audio_get_target_ent_origin();

      if(!isdefined(trigger_multiple_audio_get_target_ent_target_ent())) {
        aud_print_error("Audo Zone Trigger at " + self.origin + " has defined a target, " + trigger_multiple_audio_get_target_ent_target() + ", but that target doesn't exist.");
        return;
      }

      var_4 = trigger_multiple_audio_get_target_ent_target_ent_origin();
    } else {
      var_6 = common_scripts\utility::get_target_ent();
      var_7 = 2 * (self.origin - var_6.origin);
      var_8 = vectortoangles(var_7);
      var_3 = trigger_multiple_audio_get_target_ent_origin();
      var_4 = var_3 + var_7;

      if(angleclamp180(var_8[0]) < 45) {
        var_3 = (var_3[0], var_3[1], 0);
        var_4 = (var_4[0], var_4[1], 0);
      }
    }

    var_5 = distance(var_3, var_4);
  }

  var_9 = 0;

  for (;;) {
    self waittill("trigger", var_2);

    if(aud_is_specops() && var_2 != level.player) {
      continue;
    }
    if(isdefined(var_3) && isdefined(var_4)) {
      if(isdefined(var_1) && isdefined(var_1[0]) && isdefined(var_1[1])) {
        var_10 = soundscripts\_audio_zone_manager::azm_get_current_zone();

        if(var_10 == var_1[0])
          var_9 = 0;
        else if(var_10 == var_1[1])
          var_9 = 1;
        else if(var_10 != "") {
          var_11 = trigger_multiple_audio_progress(var_3, var_4, var_5, var_2.origin);

          if(var_11 < 0.5) {
            soundscripts\_audio_zone_manager::azm_start_zone(var_1[0]);
            var_9 = 0;
          } else {
            soundscripts\_audio_zone_manager::azm_start_zone(var_1[1]);
            var_9 = 1;
          }
        } else {

        }
      } else {
        var_11 = trigger_multiple_audio_progress(var_3, var_4, var_5, var_2.origin);

        if(var_11 < 0.5)
          var_9 = 0;
        else
          var_9 = 1;
      }

      if(!var_9) {
        if(isdefined(var_1) && isdefined(var_1[0])) {
          if(isdefined(level._snd) && isdefined(var_1[1])) {
            var_12 = "enter_" + var_1[1];
            soundscripts\_snd::snd_message("snd_zone_handler", var_12, var_1[0]);
          } else if(isdefined(self.script_audio_enter_msg))
            deprecated_aud_send_msg(self.script_audio_enter_msg, var_1[0]);
        } else if(isdefined(self.script_audio_enter_msg))
          deprecated_aud_send_msg(self.script_audio_enter_msg, "front");

        if(isdefined(self.script_audio_enter_func)) {
          if(isdefined(var_1) && isdefined(var_1[0])) {
            if(isdefined(level._audio.trigger_functions[self.script_audio_enter_func]))
              [[level._audio.trigger_functions[self.script_audio_enter_func]]](var_1[0]);
          } else if(isdefined(level._audio.trigger_functions[self.script_audio_enter_func]))
            [[level._audio.trigger_functions[self.script_audio_enter_func]]]("front");
        }
      } else {
        if(isdefined(var_1) && isdefined(var_1[1])) {
          if(isdefined(level._snd)) {
            var_12 = "enter_" + var_1[1];
            soundscripts\_snd::snd_message("snd_zone_handler", var_12, var_1[1]);
          } else if(isdefined(self.script_audio_enter_msg))
            deprecated_aud_send_msg(self.script_audio_enter_msg, var_1[1]);
        } else if(isdefined(self.script_audio_enter_msg))
          deprecated_aud_send_msg(self.script_audio_enter_msg, "back");

        if(isdefined(self.script_audio_enter_func)) {
          if(isdefined(var_1) && isdefined(var_1[1])) {
            if(isdefined(level._audio.trigger_functions[self.script_audio_enter_func]))
              [[level._audio.trigger_functions[self.script_audio_enter_func]]](var_1[1]);
          } else if(isdefined(level._audio.trigger_functions[self.script_audio_enter_func]))
            [[level._audio.trigger_functions[self.script_audio_enter_func]]]("back");
        }
      }
    } else {
      if(isdefined(self.script_audio_enter_msg))
        deprecated_aud_send_msg(self.script_audio_enter_msg);

      if(isdefined(self.script_audio_enter_func)) {
        if(isdefined(level._audio.trigger_functions[self.script_audio_enter_func]))
          [[level._audio.trigger_functions[self.script_audio_enter_func]]]();
      }
    }

    var_13 = undefined;

    if(isdefined(trigger_multiple_audio_get_zone_from(var_1, var_9)) && isdefined(trigger_multiple_audio_get_zone_to(var_1, var_9))) {
      var_13 = soundscripts\_audio_zone_manager::azmx_get_blend_args(trigger_multiple_audio_get_zone_from(var_1, var_9), trigger_multiple_audio_get_zone_to(var_1, var_9));

      if(isdefined(var_13))
        var_13.mode = self.script_audio_blend_mode;
    }

    if(isdefined(var_13)) {
      if(isdefined(var_13.filter1) || isdefined(var_13.filter2)) {
        if(!level._audio.zone_mgr.overrides.filter_bypass) {
          soundscripts\_snd_filters::snd_clear_filter(0);
          soundscripts\_snd_filters::snd_clear_filter(1);
        }
      }
    }

    var_14 = -1;
    var_11 = -1;

    while (var_2 istouching(self)) {
      if(isdefined(self.script_audio_point_func)) {
        var_15 = trigger_multiple_audio_progress_point(var_3, var_4, var_2.origin);

        if(isdefined(level._audio.trigger_functions[self.script_audio_point_func]))
          [[level._audio.trigger_functions[self.script_audio_point_func]]](var_15);
      }

      if(isdefined(var_3) && isdefined(var_4)) {
        var_11 = trigger_multiple_audio_progress(var_3, var_4, var_5, var_2.origin);

        if(isdefined(self.script_audio_progress_map))
          var_11 = deprecated_aud_map(var_11, level._audio.progress_maps[self.script_audio_progress_map]);

        if(var_11 != var_14) {
          if(isdefined(trigger_multiple_audio_get_zone_from(var_1, var_9)) && isdefined(trigger_multiple_audio_get_zone_to(var_1, var_9)))
            soundscripts\_audio_zone_manager::azm_print_enter_blend(trigger_multiple_audio_get_zone_from(var_1, var_9), trigger_multiple_audio_get_zone_to(var_1, var_9), var_11);

          if(isdefined(self.script_audio_progress_msg))
            deprecated_aud_send_msg(self.script_audio_progress_msg, var_11);

          if(isdefined(self.script_audio_progress_func)) {
            if(isdefined(level._audio.trigger_functions[self.script_audio_progress_func]))
              [[level._audio.trigger_functions[self.script_audio_progress_func]]](var_11);
          }

          if(isdefined(var_13))
            trigger_multiple_audio_blend(var_11, var_13, var_9);

          var_14 = var_11;
          soundscripts\_audio_zone_manager::azm_print_progress(var_11);
        }
      }

      if(isdefined(self.script_audio_update_rate)) {
        wait(self.script_audio_update_rate);
        continue;
      }

      wait 0.1;
    }

    if(isdefined(var_3) && isdefined(var_4)) {
      if(var_11 > 0.5) {
        if(isdefined(var_1) && isdefined(var_1[1]))
          soundscripts\_audio_zone_manager::azm_set_current_zone(var_1[1]);

        if(isdefined(var_1) && isdefined(var_1[1])) {
          if(isdefined(level._snd)) {
            var_16 = "exit_" + var_1[1];
            soundscripts\_snd::snd_message("snd_zone_handler", var_16, var_1[1]);
          } else if(isdefined(self.script_audio_exit_msg))
            deprecated_aud_send_msg(self.script_audio_exit_msg, var_1[1]);
        } else if(isdefined(self.script_audio_exit_msg))
          deprecated_aud_send_msg(self.script_audio_exit_msg, "back");

        if(isdefined(self.script_audio_exit_func)) {
          if(isdefined(var_1) && isdefined(var_1[1])) {
            if(isdefined(level._audio.trigger_functions[self.script_audio_exit_func]))
              [[level._audio.trigger_functions[self.script_audio_exit_func]]](var_1[1]);
          } else if(isdefined(level._audio.trigger_functions[self.script_audio_exit_func]))
            [[level._audio.trigger_functions[self.script_audio_exit_func]]]("back");
        }

        var_11 = 1;
      } else {
        if(isdefined(var_1) && isdefined(var_1[0]))
          soundscripts\_audio_zone_manager::azm_set_current_zone(var_1[0]);

        if(isdefined(var_1) && isdefined(var_1[0])) {
          if(isdefined(level._snd)) {
            var_16 = "exit_" + var_1[1];
            soundscripts\_snd::snd_message("snd_zone_handler", var_16, var_1[0]);
          } else if(isdefined(self.script_audio_exit_msg))
            deprecated_aud_send_msg(self.script_audio_exit_msg, var_1[0]);
        } else if(isdefined(self.script_audio_exit_msg))
          deprecated_aud_send_msg(self.script_audio_exit_msg, "front");

        if(isdefined(self.script_audio_exit_func)) {
          if(isdefined(var_1) && isdefined(var_1[0])) {
            if(isdefined(level._audio.trigger_functions[self.script_audio_exit_func]))
              [[level._audio.trigger_functions[self.script_audio_exit_func]]](var_1[0]);
          } else if(isdefined(level._audio.trigger_functions[self.script_audio_exit_func]))
            [[level._audio.trigger_functions[self.script_audio_exit_func]]]("front");
        }

        var_11 = 0;
      }

      if(isdefined(var_13))
        trigger_multiple_audio_blend(var_11, var_13, var_9);

      continue;
    }

    if(isdefined(self.script_audio_exit_msg))
      deprecated_aud_send_msg(self.script_audio_exit_msg);

    if(isdefined(self.script_audio_exit_func)) {
      if(isdefined(level._audio.trigger_functions[self.script_audio_exit_func]))
        [[level._audio.trigger_functions[self.script_audio_exit_func]]]();
    }
  }
}

trigger_multiple_audio_progress(var_0, var_1, var_2, var_3) {
  if(var_2 == 0)
    return 0;

  if(!isdefined(self.script_audio_use_distance_only)) {
    var_4 = vectornormalize(var_1 - var_0);
    var_5 = var_3 - var_0;
    var_6 = vectordot(var_5, var_4);
    var_6 = var_6 / var_2;
  } else {
    var_7 = distance(var_3, var_0);
    var_6 = var_7 / var_2;
  }

  return clamp(var_6, 0, 1.0);
}

trigger_multiple_audio_progress_point(var_0, var_1, var_2) {
  var_3 = vectornormalize(var_1 - var_0);
  var_4 = var_2 - var_0;
  var_5 = vectordot(var_4, var_3);
  return var_3 * var_5 + var_0;
}

trigger_multiple_audio_blend(var_0, var_1, var_2) {
  var_0 = clamp(var_0, 0, 1.0);

  if(var_2)
    var_0 = 1.0 - var_0;

  var_3 = var_1.mode;

  if(var_3 == "blend") {
    var_4 = 1.0 - var_0;
    var_5 = var_0;
    soundscripts\_audio_zone_manager::azmx_blend_zones(var_4, var_5, var_1);
  } else if(var_0 < 0.33)
    soundscripts\_audio_zone_manager::azm_start_zone(var_1.zone_from_name);
  else if(var_0 > 0.66)
    soundscripts\_audio_zone_manager::azm_start_zone(var_1.zone_to_name);
}

trigger_multiple_audio_register_callback(var_0) {
  if(!isdefined(level._audio.trigger_functions))
    level._audio.trigger_functions = [];

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];
    var_3 = var_2[0];
    var_4 = var_2[1];
    level._audio.trigger_functions[var_3] = var_4;
  }

  if(isdefined(level._audio.trigger_function_keys)) {
    foreach(var_3 in level._audio.trigger_function_keys) {

    }

    level._audio.trigger_function_keys = undefined;
  }
}

trigger_multiple_audio_get_target_ent_target() {
  var_0 = common_scripts\utility::get_target_ent();
  return var_0.target;
}

trigger_multiple_audio_get_target_ent_origin() {
  var_0 = common_scripts\utility::get_target_ent();
  return var_0.origin;
}

trigger_multiple_audio_get_target_ent_target_ent() {
  var_0 = common_scripts\utility::get_target_ent();
  return var_0 common_scripts\utility::get_target_ent();
}

trigger_multiple_audio_get_target_ent_target_ent_origin() {
  var_0 = trigger_multiple_audio_get_target_ent_target_ent();
  return var_0.origin;
}

trigger_multiple_audio_get_zone_from(var_0, var_1) {
  if(!isdefined(var_0) || !isdefined(var_1))
    return undefined;

  if(var_1)
    return var_0[1];
  else
    return var_0[0];
}

trigger_multiple_audio_get_zone_to(var_0, var_1) {
  if(!isdefined(var_0) || !isdefined(var_1))
    return undefined;

  if(var_1)
    return var_0[0];
  else
    return var_0[1];
}

aud_play_dynamic_explosion(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawn("script_origin", level.player.origin);
  var_7 = spawn("script_origin", var_0);

  if(!isdefined(var_3))
    var_3 = distance(var_7.origin, var_6.origin);

  if(!isdefined(var_4)) {
    var_8 = 30;
    var_4 = 36 * var_8;
  }

  var_9 = audx_do_dynamic_explosion_math(var_7.origin, var_6.origin, var_3, var_4);
  var_9[0] = (var_9[0][0], var_9[0][1], var_6.origin[2]);
  var_9[1] = (var_9[1][0], var_9[1][1], var_6.origin[2]);
  var_10 = distance(var_7.origin, var_9[0]);

  if(!isdefined(var_5))
    var_5 = 1800;

  var_11 = var_10 / var_5;

  if(isdefined(var_9) && var_9.size == 2) {
    var_12 = spawn("script_origin", var_7.origin);
    var_13 = spawn("script_origin", var_7.origin);
    var_12 soundscripts\_snd_playsound::snd_play(var_1);
    var_13 soundscripts\_snd_playsound::snd_play(var_2);
    var_12 moveto(var_9[0], var_11, 0, 0);
    var_13 moveto(var_9[1], var_11, 0, 0);
  }
}

audx_do_dynamic_explosion_math(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_0;
  var_5 = aud_copy_vector(var_4);
  var_6 = aud_copy_vector(var_4);
  var_7 = aud_vector_magnitude_2d(var_5);
  var_8 = 0.5 * var_2 / var_7;
  var_5 = aud_scale_vector_2d(var_5, var_8);
  var_6 = aud_scale_vector_2d(var_6, var_8);
  var_5 = aud_rotate_vector_yaw(var_5, 90);
  var_6 = aud_rotate_vector_yaw(var_6, -90);
  var_9 = aud_vector_magnitude_2d(var_4);
  var_10 = var_3 / var_9;
  var_11 = aud_scale_vector_2d(var_4, var_10);
  var_11 = var_11 + var_4;
  var_11 = var_11 + var_4;
  var_5 = var_5 + var_11;
  var_6 = var_6 + var_11;
  var_12 = [];
  var_12[0] = var_5;
  var_12[1] = var_6;
  return var_12;
}

aud_get_optional_param(var_0, var_1) {
  var_2 = var_0;

  if(isdefined(var_1))
    var_2 = var_1;

  return var_2;
}

aud_scale_vector_2d(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2]);
}

aud_scale_vector(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}

aud_rotate_vector_yaw(var_0, var_1) {
  var_2 = var_0[0] * cos(var_1) - var_0[1] * sin(var_1);
  var_3 = var_0[0] * sin(var_1) + var_0[1] * cos(var_1);
  return (var_2, var_3, var_0[2]);
}

aud_copy_vector(var_0) {
  var_1 = (0, 0, 0);
  var_1 = var_1 + var_0;
  return var_1;
}

aud_vector_magnitude_2d(var_0) {
  return sqrt(var_0[0] * var_0[0] + var_0[1] * var_0[1]);
}

aud_print_synch(var_0) {
  aud_print(var_0, "synch_frame");
}

aud_print(var_0, var_1) {}

aud_print_warning(var_0) {
  aud_print(var_0, "warning");
}

aud_print_error(var_0) {
  aud_print(var_0, "error");
}

aud_print_debug(var_0) {
  aud_print(var_0);
}

aud_print_zone(var_0) {
  aud_print(var_0, "zone");
}

aud_print_zone_small(var_0) {
  aud_print(var_0, "zone_small");
}

equal_strings(var_0, var_1) {
  if(isdefined(var_0) && isdefined(var_1))
    return var_0 == var_1;
  else
    return !isdefined(var_0) && !isdefined(var_1);
}

isundefined(var_0) {
  return !isdefined(var_0);
}

aud_fade_out_and_delete(var_0, var_1) {
  var_0 scalevolume(0.0, var_1);
  var_0 common_scripts\utility::delaycall(var_1 + 0.05, ::stopsounds);
  var_0 common_scripts\utility::delaycall(var_1 + 0.1, ::delete);
}

aud_fade_loop_out_and_delete(var_0, var_1) {
  var_0 scalevolume(0.0, var_1);
  wait(var_1 + 0.05);
  var_0 stoploopsound();
  wait 0.05;
  var_0 delete();
}

aud_min(var_0, var_1) {
  if(var_0 <= var_1)
    return var_0;
  else
    return var_1;
}

aud_max(var_0, var_1) {
  if(var_0 >= var_1)
    return var_0;
  else
    return var_1;
}

aud_clamp(var_0, var_1, var_2) {
  if(var_0 < var_1)
    var_0 = var_1;
  else if(var_0 > var_2)
    var_0 = var_2;

  return var_0;
}

aud_get_envelope_domain(var_0) {
  if(isarray(var_0))
    return [var_0[0][0], var_0[var_0.size - 1][0]];
  else
    return [var_0.env_array[0][0], var_0.env_array[var_0.env_array.size - 1][0]];
}

aud_scale_envelope(var_0, var_1, var_2) {
  var_1 = aud_get_optional_param(1, var_1);
  var_2 = aud_get_optional_param(1, var_2);

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    var_0[var_3][0] = var_0[var_3][0] * var_1;
    var_0[var_3][1] = var_0[var_3][1] * var_2;
  }

  return var_0;
}

aud_smooth(var_0, var_1, var_2) {
  return var_0 + var_2 * (var_1 - var_0);
}

aud_is_even(var_0) {
  return var_0 == int(var_0 / 2) * 2;
}

aud_fade_in_music(var_0) {
  var_1 = 10.0;

  if(isdefined(var_0))
    var_1 = var_0;

  soundscripts\_audio_mix_manager::mm_add_submix("mute_music", 0.1);
  wait 0.05;
  soundscripts\_audio_mix_manager::mm_clear_submix("mute_music", var_1);
}

aud_check_sound_done() {
  self endon("cleanup");

  if(!isdefined(self.sounddone))
    self.sounddone = 0;

  self waittill("sounddone");

  if(isdefined(self)) {
    self.sounddone = 1;
    self notify("cleanup");
  }
}

aud_in_zone(var_0) {
  return equal_strings(soundscripts\_audio_zone_manager::azm_get_current_zone(), var_0);
}

aud_find_exploder(var_0) {
  if(isdefined(level.createfxexploders)) {
    var_1 = level.createfxexploders["" + var_0];

    if(isdefined(var_1))
      return var_1[0];
  } else {
    for (var_2 = 0; var_2 < level.createfxent.size; var_2++) {
      var_3 = level.createfxent[var_2];

      if(!isdefined(var_3)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isdefined(var_3.v["exploder"])) {
        continue;
      }
      if(int(var_3.v["exploder"]) != var_0) {
        continue;
      }
      return var_3;
    }
  }

  return undefined;
}

aud_duck(var_0, var_1, var_2, var_3) {
  thread audx_duck(var_0, var_1, var_2, var_3);
}

audx_duck(var_0, var_1, var_2, var_3) {
  var_1 = clamp(var_1, 0, 10);
  var_4 = 1.0;

  if(isdefined(var_2))
    var_4 = var_2;

  var_5 = var_4;

  if(isdefined(var_3))
    var_5 = var_3;

  soundscripts\_audio_mix_manager::mm_add_submix(var_0, var_4);
  wait(var_1);
  soundscripts\_audio_mix_manager::mm_clear_submix(var_0, var_5);
}

aud_percent_chance(var_0) {
  return randomintrange(1, 100) <= var_0;
}

aud_start_slow_mo_gunshot_callback(var_0, var_1) {
  level endon("aud_stop_slow_mo_gunshot");
  var_2 = getaiarray("axis");

  foreach(var_4 in var_2)
  var_4 thread aud_impact_monitor(var_1);

  var_6 = 0;
  var_7 = level.player getcurrentweapon();

  for (;;) {
    if(level.player attackbuttonpressed()) {
      if(!var_6) {
        var_6 = 1;
        [
          [var_0]
        ](var_7);
      }
    } else
      var_6 = 0;

    wait 0.05;
  }
}

aud_impact_monitor(var_0) {
  level endon("aud_stop_slow_mo_gunshot");
  var_1 = level.player getcurrentweapon();

  for (;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6);

    if(isdefined(var_5))
      [[var_0]](var_1, var_2, var_3, var_5, var_6);
  }
}

aud_stop_slow_mo_gunshot_callback() {
  level notify("aud_stop_slow_mo_gunshot");
}

aud_wait_delay(var_0, var_1, var_2, var_3) {
  if(isdefined(var_2)) {
    var_4 = 60;

    if(isdefined(var_3))
      var_4 = var_3;

    var_5 = floor(var_0);
    var_6 = (var_0 - var_5) * 100;
    var_0 = var_5 + var_6 * 1 / var_4;
  }

  var_7 = var_0;

  if(isdefined(var_1) && var_1)
    aud_slomo_wait(var_7);
  else
    wait(var_7);
}

aud_slomo_wait(var_0) {
  var_1 = spawn("script_origin", (0, 0, 0));
  var_1 thread audx_slomo_wait(var_0);
  var_1 waittill("slo_mo_wait_done");
  var_1 delete();
}

audx_slomo_wait(var_0) {
  var_1 = 0;

  while (var_1 < var_0) {
    var_2 = getdvarfloat("com_timescale");
    var_1 = var_1 + 0.05 / var_2;
    wait 0.05;
  }

  self notify("slo_mo_wait_done");
}

aud_print_3d_on_ent(var_0, var_1, var_2, var_3, var_4) {
  if(isdefined(self)) {
    var_5 = (1, 1, 1);
    var_6 = (1, 0, 0);
    var_7 = (0, 1, 0);
    var_8 = (0, 1, 1);
    var_9 = 5;
    var_10 = var_5;

    if(isdefined(var_1))
      var_9 = var_1;

    if(isdefined(var_2)) {
      var_10 = var_2;

      switch (var_10) {
        case "red":
          var_10 = var_6;
          break;
        case "white":
          var_10 = var_5;
          break;
        case "blue":
          var_10 = var_8;
          break;
        case "green":
          var_10 = var_7;
          break;
        default:
          var_10 = var_5;
      }
    }

    if(isdefined(var_4))
      thread audx_print_3d_timer(var_4);

    self endon("death");
    self endon("aud_stop_3D_print");

    while (isdefined(self)) {
      var_11 = var_0;

      if(isdefined(var_3))
        var_11 = var_11 + self[[var_3]]();

      wait 0.05;
    }
  }
}

audx_print_3d_timer(var_0) {
  self endon("death");
  wait(var_0);

  if(isdefined(self))
    self notify("aud_stop_3D_print");
}

aud_add_progress_map(var_0, var_1) {
  level._audio.progress_maps[var_0] = var_1;
}

aud_get_progress_map(var_0) {
  if(isdefined(level._audio.progress_maps[var_0]))
    return level._audio.progress_maps[var_0];
}

is_deathsdoor_audio_enabled() {
  if(!isdefined(level._audio.deathsdoor_enabled))
    return 1;
  else
    return level._audio.deathsdoor_enabled;
}

aud_enable_deathsdoor_audio() {
  level.player.disable_breathing_sound = 0;
  level._audio.deathsdoor_enabled = 1;
}

aud_disable_deathsdoor_audio() {
  level.player.disable_breathing_sound = 1;
  level._audio.deathsdoor_enabled = 0;
}

restore_after_deathsdoor() {
  if(is_deathsdoor_audio_enabled() && isdefined(level._audio.in_deathsdoor)) {
    level._audio.in_deathsdoor = undefined;
    soundscripts\_audio_mix_manager::mm_clear_submix("deaths_door", 2);
    soundscripts\_snd_common::snd_disable_soundcontextoverride("deathsdoor");
    level notify("kill_deaths_door_audio");
    level.player setpainvisioneq(0);
    soundscripts\_audio_zone_manager::azm_set_filter_bypass(0);
    thread soundscripts\_audio_reverb::rvb_start_preset(level._audio.deathsdoor.reverb);
    soundscripts\_snd_playsound::snd_play_2d("deaths_door_exit");
  }
}

init_deathsdoor() {
  level._audio.deathsdoor = spawnstruct();
  level._audio.deathsdoor.reverb = undefined;
}

set_deathsdoor() {
  level._audio.in_deathsdoor = 1;

  if(!isdefined(level._audio.deathsdoor))
    level._audio.deathsdoor = spawnstruct();

  level._audio.deathsdoor.reverb = undefined;
  level._audio.deathsdoor.reverb = level._audio.current_reverb;

  if(is_deathsdoor_audio_enabled()) {
    soundscripts\_audio_zone_manager::azm_set_filter_bypass(1);
    thread soundscripts\_audio_reverb::rvb_start_preset("deathsdoor");
    soundscripts\_audio_mix_manager::mm_add_submix("deaths_door");
    soundscripts\_snd_common::snd_enable_soundcontextoverride("deathsdoor");
    soundscripts\_snd_playsound::snd_play_2d("deaths_door_intro");
    soundscripts\_snd_playsound::snd_play_2d("deaths_door_breaths", "kill_deaths_door_audio", 0, 0.5);
    soundscripts\_snd_playsound::snd_play_loop_2d("deaths_door_loop", "kill_deaths_door_audio", 0, 0.5);
    level.player setpainvisioneq(1);
  }
}

aud_restore_after_flashbang() {
  soundscripts\_snd_filters::snd_fade_out_filter(2);
  soundscripts\_audio_zone_manager::azm_set_filter_bypass(0);
}

aud_set_flashbang() {
  soundscripts\_audio_zone_manager::azm_set_filter_bypass(1);
  soundscripts\_snd_filters::snd_fade_in_filter("flashbang", 0.5);
}

aud_set_mission_failed_music(var_0) {
  level._audio.failed_music_alias = var_0;
}

aud_wait_for_mission_fail_music() {
  wait 0.05;

  while (!common_scripts\utility::flag_exist("missionfailed"))
    wait 0.05;

  var_0 = "shg_mission_failed_stinger";
  common_scripts\utility::flag_wait("missionfailed");

  if(isdefined(level._audio.failed_music_alias))
    var_0 = level._audio.failed_music_alias;

  if(soundexists(var_0))
    soundscripts\_audio_music::mus_play(var_0, 2, 4);
}

aud_use_string_tables() {
  level._audio.using_string_tables = 1;
  soundscripts\_audio_zone_manager::azm_use_string_table();
  soundscripts\_audio_reverb::rvb_use_string_table();
  soundscripts\_audio_dynamic_ambi::damb_use_string_table();
  soundscripts\_audio_whizby::whiz_use_string_table();
  soundscripts\_audio_whizby::whiz_set_preset("default");
}

set_stringtable_mapname(var_0) {
  soundscripts\_snd::snd_set_soundtable_name(var_0);
  aud_use_string_tables();
  level._audio.stringtables["map"] = var_0;
}

get_stringtable_mapname() {
  return soundscripts\_snd::snd_get_soundtable_name();
}

set_damb_stringtable(var_0) {
  level._audio.stringtables["damb"] = var_0;
}

get_damb_stringtable() {
  if(!isdefined(level._audio.stringtables["damb"]))
    return "soundtables\" + level.script + ".csv ";
  else
    return "soundtables\" + level._audio.stringtables["
  damb "];
}

set_damb_component_stringtable(var_0) {
  level._audio.stringtables["damb_comp"] = var_0;
}

get_damb_component_stringtable(var_0) {
  if(!isdefined(level._audio.stringtables["damb_comp"]))
    return "soundtables\" + level.script + ".csv ";
  else
    return "soundtables\" + level._audio.stringtables["
  damb_comp "];
}

set_damb_loops_stringtable(var_0) {
  level._audio.stringtables["damb_loops"] = var_0;
}

get_damb_loops_stringtable(var_0) {
  if(!isdefined(level._audio.stringtables["damb_loops"]))
    return "soundtables\" + level.script + ".csv ";
  else
    return "soundtables\" + level._audio.stringtables["
  damb_loops "];
}

set_reverb_stringtable(var_0) {
  level._audio.stringtables["reverb"] = var_0;
}

get_reverb_stringtable() {
  if(!isdefined(level._audio.stringtables["reverb"]))
    return "soundtables\" + level.script + ".csv ";
  else
    return "soundtables\" + level._audio.stringtables["
  reverb "];
}

set_zone_stringtable(var_0) {
  level._audio.stringtables["zone"] = var_0;
}

get_zone_stringtable() {
  if(!isdefined(level._audio.stringtables["zone"]))
    return "soundtables\" + level.script + ".csv ";
  else
    return "soundtables\" + level._audio.stringtables["
  zone "];
}

aud_get_player_locamote_state() {
  return level._audio.player_state.locamote;
}

aud_get_threat_level(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = aud_get_sticky_threat();

  if(isdefined(var_4))
    var_3 = var_4;
  else {
    var_5 = 3;
    var_6 = 10;
    var_7 = 100;

    if(isdefined(var_0))
      var_5 = var_0;

    if(isdefined(var_2))
      var_7 = var_2;

    if(isdefined(var_2))
      var_6 = var_1;

    var_8 = 36 * var_7;
    var_9 = 36 * var_6;
    var_10 = getaiarray("bad_guys");
    var_11 = 0;
    var_12 = 0;

    foreach(var_14 in var_10) {
      if(isdefined(var_14.alertlevelint) && var_14.alertlevelint >= var_5) {
        var_15 = distance(level.player.origin, var_14.origin);

        if(var_15 < var_8) {
          var_11++;

          if(var_15 < var_9)
            var_16 = 1.0;
          else
            var_16 = 1.0 - (var_15 - var_9) / (var_8 - var_9);

          var_12 = var_12 + var_16;
        }
      }
    }

    if(var_11 > 0)
      var_3 = var_12 / var_11;
    else
      var_3 = 0;
  }

  return var_3;
}

aud_get_sticky_threat() {
  return level._audio.sticky_threat;
}

aud_set_sticky_threat(var_0) {
  level._audio.sticky_threat = var_0;
}

aud_clear_sticky_threat() {
  level._audio.sticky_threat = undefined;
}

aud_num_alive_enemies(var_0) {
  var_1 = 0;
  var_2 = 3600;

  if(isdefined(var_0))
    var_2 = 36 * var_0;

  var_3 = getaiarray("bad_guys");

  foreach(var_5 in var_3) {
    if(isalive(var_5)) {
      var_6 = distance(level.player.origin, var_5.origin);

      if(var_6 < var_2)
        var_1++;
    }
  }

  return var_1;
}

deprecated_aud_fade_sound_in(var_0, var_1, var_2, var_3, var_4) {
  var_2 = aud_clamp(var_2, 0.0, 1.0);
  var_3 = aud_max(0.05, var_3);
  var_5 = 0;

  if(isdefined(var_4))
    var_5 = var_4;

  if(var_5)
    var_0 soundscripts\_snd_playsound::snd_play_loop(var_1);
  else
    var_0 soundscripts\_snd_playsound::snd_play(var_1);

  var_0 scalevolume(0.0);
  var_0 common_scripts\utility::delaycall(0.05, ::scalevolume, var_2, var_3);
}

deprecated_aud_map2(var_0, var_1) {
  return piecewiselinearlookup(var_0, var_1);
}

deprecated_aud_map(var_0, var_1) {
  return piecewiselinearlookup(var_0, var_1);
}

deprecated_aud_map_range(var_0, var_1, var_2, var_3) {
  var_4 = (var_0 - var_1) / (var_2 - var_1);
  var_4 = clamp(var_4, 0.0, 1.0);
  return piecewiselinearlookup(var_4, var_3);
}

deprecated_aud_register_msg_handler(var_0) {
  level._audio.message_handlers[level._audio.message_handlers.size] = var_0;
}

deprecated_audio_message(var_0, var_1, var_2) {
  thread deprecated_audx_dispatch_msg(var_0, var_1, var_2);
}

deprecated_aud_send_msg(var_0, var_1, var_2) {
  deprecated_audio_message(var_0, var_1, var_2);
}

deprecated_audx_dispatch_msg(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 0;

  foreach(var_6 in level._audio.message_handlers) {
    var_4 = self[[var_6]](var_0, var_1);

    if(!var_3 && isdefined(var_4) && var_4 == 1) {
      var_3 = var_4;
      continue;
    }

    if(!var_3 && !isdefined(var_4))
      var_3 = 1;
  }

  if(isdefined(var_2))
    self notify(var_2);

  if(!var_3)
    aud_print_warning("\tAUDIO MESSAGE NOT HANDLED: " + var_0);
}

aud_play_pcap_vo(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 1;
  var_5 = self;

  if(isdefined(var_2))
    deprecated_aud_delay_play_2d_sound(var_0, var_1, var_3, var_4);
  else
    deprecated_aud_delay_play_linked_sound(var_0, var_5, var_1, var_3, var_4);
}

deprecated_play_2d_sound_internal(var_0) {
  soundscripts\_snd_playsound::snd_play(var_0, "sounddone");
  self waittill("sounddone");
  wait 0.05;
  self delete();
}

deprecated_aud_delay_play_2d_sound_internal(var_0, var_1, var_2, var_3) {
  aud_wait_delay(var_1, var_2, var_3);
  var_4 = spawn("script_origin", level.player.origin);
  var_4 thread deprecated_play_2d_sound_internal(var_0);
  return var_4;
}

deprecated_aud_play_2d_sound(var_0) {
  var_1 = spawn("script_origin", level.player.origin);
  var_1 thread deprecated_play_2d_sound_internal(var_0);
  return var_1;
}

deprecated_aud_delay_play_2d_sound(var_0, var_1, var_2, var_3, var_4) {
  var_5 = thread deprecated_aud_delay_play_2d_sound_internal(var_0, var_1, var_2, var_3);
  return var_5;
}

deprecated_aud_delay_play_linked_sound(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  thread deprecated_aud_delay_play_linked_sound_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

deprecated_aud_delay_play_linked_sound_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  aud_wait_delay(var_2, var_3, var_4, var_5);
  thread deprecated_aud_play_linked_sound(var_0, var_1, var_6, var_7, var_8, var_9);
}

deprecated_audx_play_linked_sound_internal(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 == "loop") {
    level endon(var_2 + "internal");
    soundscripts\_snd_playsound::snd_play_loop(var_1);
    level waittill(var_2);

    if(isdefined(self)) {
      if(isdefined(var_4)) {
        self scalevolume(0, var_4);
        wait(var_4);
      }

      soundscripts\_snd_playsound::snd_stop_sound();
      wait 0.05;
      self delete();
    }
  } else if(var_0 == "oneshot") {
    soundscripts\_snd_playsound::snd_play(var_1, "sounddone");

    if(isdefined(var_3))
      self scalevolume(var_3, 0);

    self waittill("sounddone");

    if(isdefined(self))
      self delete();
  }
}

deprecated_audx_monitor_linked_entity_health(var_0, var_1, var_2) {
  level endon(var_1);

  while (isdefined(self))
    wait 0.1;

  level notify(var_1 + "internal");

  if(isdefined(var_0)) {
    if(isdefined(var_2)) {
      var_0 scalevolume(0, var_2);
      wait(var_2);
    }

    var_0 soundscripts\_snd_playsound::snd_stop_sound();
    wait 0.05;
    var_0 delete();
  }
}

deprecated_aud_play_linked_sound(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = "oneshot";

  if(isdefined(var_2))
    var_8 = var_2;

  var_9 = var_1.origin;

  if(isdefined(var_6))
    var_9 = var_6;

  var_10 = spawn("script_origin", var_9);

  if(isdefined(var_4))
    var_10 linkto(var_1, "tag_origin", var_4, (0, 0, 0));
  else
    var_10 linkto(var_1);

  if(var_8 == "loop")
    var_1 thread deprecated_audx_monitor_linked_entity_health(var_10, var_3, var_7);

  var_10 thread deprecated_audx_play_linked_sound_internal(var_8, var_0, var_3, var_5, var_7);
  return var_10;
}

deprecated_aud_play_sound_at_internal(var_0, var_1, var_2) {
  soundscripts\_snd_playsound::snd_play(var_0, "sounddone");

  if(isdefined(var_2)) {
    wait(var_2);
    self stopsounds();
  } else
    self waittill("sounddone");

  wait 0.05;
  self delete();
}

deprecated_aud_play_sound_at(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", var_1);
  var_3 thread deprecated_aud_play_sound_at_internal(var_0, var_1, var_2);
  return var_3;
}

deprecated_aud_set_occlusion(var_0) {
  soundscripts\_snd_filters::snd_set_occlusion(var_0);
}

deprecated_aud_set_filter(var_0, var_1, var_2, var_3) {
  soundscripts\_snd_filters::snd_set_filter(var_0, var_1, var_3);
}

deprecated_aud_delete_on_sounddone() {
  self waittill("sounddone");
  deprecated_delete_sound_entity();
}

deprecated_delete_sound_entity() {
  common_scripts\utility::delaycall(0.05, ::delete);
}

deprecated__audio_msg_handler(var_0, var_1) {
  var_2 = 1;

  switch (var_0) {
    case "level_fade_to_black":
      var_3 = var_1[0];
      var_4 = var_1[1];
      wait(var_3);
      soundscripts\_audio_mix_manager::mm_start_preset("mute_all", var_4);
      break;
    case "generic_building_bomb_shake":
      level.player soundscripts\_snd_playsound::snd_play("sewer_bombs");
      break;
    case "start_player_slide_trigger":
      break;
    case "end_player_slide_trigger":
      break;
    case "missile_fired":
      break;
    case "msg_audio_fx_ambientExp":
      break;
    case "DEPRECATED_aud_play_sound_at":
      deprecated_aud_play_sound_at(var_1.alias, var_1.pos);
      break;
    case "aud_play_dynamic_explosion":
      if(isdefined(var_1.spread_width))
        var_5 = var_1.spread_width;
      else
        var_5 = undefined;

      if(isdefined(var_1.rear_dist))
        var_6 = var_1.rear_dist;
      else
        var_6 = undefined;

      if(isdefined(var_1.velocity))
        var_7 = var_1.velocity;
      else
        var_7 = undefined;

      aud_play_dynamic_explosion(var_1.explosion_pos, var_1.left_alias, var_1.right_alias, var_5, var_6, var_7);
      break;
    case "DEPRECATED_aud_play_conversation":
      deprecated_aud_play_conversation(var_0, var_1);
      break;
    case "xm25_contact_explode":
      if(soundexists("xm25_proj_explo")) {
        var_8 = var_1;
        thread common_scripts\utility::play_sound_in_space("xm25_proj_explo", var_8);
      }

      break;
    case "light_flicker_on":
      var_9 = var_1;
      deprecated_aud_handle_flickering_light(var_9);
      break;
    default:
      var_2 = 0;
  }

  return var_2;
}

deprecated_aud_handle_flickering_light(var_0) {
  var_1 = 0;

  switch (var_0.model) {
    case "furniture_lamp_table1":
    case "com_cafe_light_part1_off":
    case "furniture_lamp_floor1_off":
      var_1 = 1;

      if(soundexists("paris_lamplight_flicker"))
        thread common_scripts\utility::play_sound_in_space("paris_lamplight_flicker", var_0.origin);

      break;
    default:
      var_1 = 0;
  }

  return var_1;
}

deprecated_aud_play_conversation(var_0, var_1) {
  var_2 = var_1;
  var_3 = [];

  for (var_4 = 0; var_4 < var_2.size; var_4++) {
    var_3[var_4] = var_2[var_4].ent.battlechatter;
    var_2[var_4].ent.battlechatter = 0;
  }

  foreach(var_6 in var_2) {
    if(isdefined(var_6.delay))
      wait(var_6.delay);

    var_7 = spawn("script_origin", (0, 0, 0));
    var_7 linkto(var_6.ent, "", (0, 0, 0), (0, 0, 0));
    var_7 soundscripts\_snd_playsound::snd_play(var_6.sound, "sounddone");
    var_7 waittill("sounddone");
    wait 0.05;
    var_7 delete();
  }

  for (var_4 = 0; var_4 < var_2.size; var_4++)
    var_2[var_4].ent.battlechatter = var_3[var_4];
}