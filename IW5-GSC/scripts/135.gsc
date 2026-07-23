/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\135.gsc
**************************************/

mm_init() {
  if(!isDefined(level._audio)) {
    level._audio = spawnStruct();
  }
  if(!isDefined(level._audio.mix)) {
    level._audio.mix = spawnStruct();
  }
  mmx_init_volmods();
  level._audio.mix.use_string_table_presets = 0;
  level._audio.mix.use_iw_presets = 0;
  level._audio.mix.blending = 0;
  level._audio.mix.debug_mix_mode = 0;
  var_0 = 10;
  thread mmx_mix_server_throttler(var_0);
  thread mmx_volmod_server_throttler(var_0);
  level._audio.mix.curr_preset = "";
  level._audio.mix.prev_preset = "";
  level._audio.mix.sticky_submixes = [];

  if(!isDefined(level._audio.volmod_submixes)) {
    level._audio.volmod_submixes = [];
  }
  level._audio.mix.volmod_submixblends = [];
  level._audio.mix.preset_cache = [];
  level._audio.mix.changed_presets = [];
  level._audio.mix.headroom = 0.85;
  level._audio.mix.blend_value = 0;
  level._audio.mix.blend_name = "";
  thread mmx_update_mix_thread();
  waittillframeend;
  thread mmx_apply_initial_mix();
}

mm_precache_preset(var_0) {
  mmx_get_mix_preset(var_0);
}

mm_set_headroom_mix(var_0, var_1, var_2) {
  if(!level._audio.mix.debug_mix_mode) {
    var_3 = 1.0;

    if(isDefined(var_2)) {
      var_3 = var_2;
    }
    level._audio.mix.headroom = var_1;
    var_4 = mmx_get_mix_preset(var_0);

    if(isDefined(var_4)) {
      level._audio.mix.headroom_preset = var_4;
      mmx_update_mix(var_3, var_0);
    }
  }
}

mm_enabled_debug_mode() {
  level._audio.mix.debug_mix_mode = 1;
}

mm_disable_debug_mode() {
  level._audio.mix.debug_mix_mode = 0;
}

mm_use_string_table() {
  level._audio.mix.use_string_table_presets = 1;
  level._audio.mix.use_iw_presets = 0;
}

mm_start_preset(var_0, var_1) {
  if(!level._audio.mix.debug_mix_mode && !level._audio.mix.blending) {
    if(var_0 != level._audio.mix.curr_preset) {
      mmx_clear_submixes(0);
      mmx_set_mix(var_0, var_1);
    }
  }
}

mm_start_zone_preset(var_0) {
  if(!level._audio.mix.debug_mix_mode && !level._audio.mix.blending) {
    var_1 = mmx_get_mix_preset(var_0);

    if(!isDefined(var_1)) {
      return;
    }
    if(isDefined(level._audio.mix.volmod_submixes["zone_mix"])) {
      foreach(var_4, var_3 in level._audio.mix.volmod_submixes["zone_mix"]) {
        if(var_4 != "fade_time" && var_4 != "preset_name") {
          level._audio.mix.volmod_submixes["zone_mix"][var_4].current_volume = 1.0;
        }
      }
    } else {
      level._audio.mix.volmod_submixes["zone_mix"] = [];
    }
    level._audio.mix.volmod_submixes["zone_mix"]["preset_name"] = var_0;

    foreach(var_4, var_3 in var_1) {
      if(var_4 != "fade_time" && var_4 != "name") {
        level._audio.mix.volmod_submixes["zone_mix"][var_4] = spawnStruct();
        level._audio.mix.volmod_submixes["zone_mix"][var_4].current_volume = var_3;
        level._audio.mix.volmod_submixes["zone_mix"][var_4].original_volume = var_3;
      }
    }

    var_6 = 1.0;

    if(isDefined(var_1["fade_time"])) {
      var_6 = var_1["fade_time"];
    }
    mmx_update_mix(var_6, "zone_mix");
  }
}

mm_clear_zone_mix(var_0) {
  var_1 = 1.0;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }
  if(isDefined(level._audio.mix.volmod_submixes["zone_mix"])) {
    level._audio.mix.volmod_submixes["zone_mix"]["CLEAR"] = 1;
    mmx_update_mix(var_1, "zone_mix");
  }
}

mm_clear_submixes(var_0) {
  mmx_clear_submixes(1, var_0);
}

mm_make_submix_sticky(var_0) {
  level._audio.mix.sticky_submixes[var_0] = 1;
}

mm_make_submix_unsticky(var_0) {
  level._audio.mix.sticky_submixes[var_0] = undefined;
}

mm_add_submix(var_0, var_1, var_2) {
  if(!level._audio.mix.debug_mix_mode && !level._audio.mix.blending) {
    mmx_set_mix(var_0, var_1, var_2);
  }
}

mm_add_submix_blend_to(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._audio.mix.volmod_submixblends[var_1])) {
    var_4 = mmx_create_submix_blend(undefined, var_0, var_2);

    if(!isDefined(var_4)) {
      return;
    }
    level._audio.mix.volmod_submixblends[var_1] = var_4;
    mmx_update_mix(var_3, var_0);
  }
}

mm_add_submix_blend(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._audio.mix.volmod_submixblends[var_2])) {
    var_5 = mmx_create_submix_blend(var_0, var_1, var_3);

    if(!isDefined(var_5)) {
      return;
    }
    level._audio.mix.volmod_submixblends[var_2] = var_5;
    mmx_update_mix(var_4, var_2);
  }
}

mm_set_submix_blend_value(var_0, var_1, var_2) {
  if(isDefined(level._audio.mix.volmod_submixblends[var_0])) {
    level._audio.mix.volmod_submixblends[var_0].blendvalue = clamp(var_1, 0, 1);
    mmx_update_mix(var_2, var_0);
  }
}

mm_clear_submix_blend(var_0, var_1) {
  if(isDefined(level._audio.mix.volmod_submixblends[var_0])) {
    level._audio.mix.volmod_submixblends[var_0].clear = 1;
    mmx_update_mix(var_1, var_0);
  }
}

mm_scale_submix(var_0, var_1, var_2) {
  if(!level._audio.mix.debug_mix_mode && !level._audio.mix.blending) {
    if(isDefined(level._audio.mix.volmod_submixes[var_0])) {
      mmx_scale_submix(var_0, var_1);
    } else {
      mmx_make_new_submix(var_0, var_1);
    }
    mmx_update_mix(var_2, var_0);
  }
}

mm_restore_submix(var_0, var_1) {
  if(!level._audio.mix.debug_mix_mode && !level._audio.mix.blending) {
    if(isDefined(level._audio.mix.volmod_submixes[var_0])) {
      level._audio.mix.volmod_submixes[var_0].current_volume = level._audio.mix.volmod_submixes[var_0].original_volume;
      mmx_update_mix(var_1, var_0);
    }
  }
}

mm_clear_submix(var_0, var_1) {
  if(!level._audio.mix.debug_mix_mode && !level._audio.mix.blending) {
    if(var_0 == "default") {
      return;
    }
    if(!isDefined(level._audio.mix.sticky_submixes[var_0]) && isDefined(level._audio.mix.volmod_submixes[var_0])) {
      level._audio.mix.volmod_submixes[var_0]["CLEAR"] = 1;
      mmx_update_mix(var_1, var_0);
    }
  }
}

mm_get_applied_preset_name() {
  return level._audio.mix.curr_preset;
}

mm_add_dynamic_volmod_submix(var_0, var_1, var_2) {
  if(!level._audio.mix.debug_mix_mode) {
    if(isDefined(level._audio.mix.volmod_submixes[var_0])) {
      return;
    }
    level._audio.mix.volmod_submixes[var_0] = [];
    var_3 = 0;
    var_4 = undefined;

    foreach(var_6 in var_1) {
      if(maps\_audio::aud_is_even(var_3)) {
        var_4 = var_6;
      } else {
        if(!mmx_is_volmod_channel(var_4)) {
          level._audio.mix.volmod_submixes[var_0] = undefined;
          return;
        }

        level._audio.mix.volmod_submixes[var_0][var_4] = spawnStruct();
        level._audio.mix.volmod_submixes[var_0][var_4].current_volume = var_6;
        level._audio.mix.volmod_submixes[var_0][var_4].original_volume = var_6;
        var_4 = undefined;
      }

      var_3++;
    }

    mmx_update_mix(var_2, var_0);
  }
}

mm_add_dynamic_submix(var_0, var_1, var_2) {
  if(!level._audio.mix.debug_mix_mode) {
    level._audio.mix.volmod_submixes[var_0] = [];
    var_3 = 0;
    var_4 = undefined;

    foreach(var_6 in var_1) {
      if(maps\_audio::aud_is_even(var_3)) {
        var_4 = var_6;
      } else {
        level._audio.mix.volmod_submixes[var_0][var_4] = spawnStruct();
        level._audio.mix.volmod_submixes[var_0][var_4].current_volume = var_6;
        level._audio.mix.volmod_submixes[var_0][var_4].original_volume = var_6;
        var_4 = undefined;
      }

      var_3++;
    }

    mmx_update_mix(var_2, var_0);
  }
}

mm_does_volmod_submix_exist(var_0) {
  return isDefined(level._audio.mix.volmod_submixes[var_0]);
}

mm_mute_volmods(var_0, var_1) {
  if(!level._audio.mix.debug_mix_mode) {
    level._audio.mix.volmod_submixes["mm_mute"] = [];

    if(isstring(var_0)) {
      if(!isDefined(level._audio.mix.volmod_submixes["mm_mute"][var_0])) {
        level._audio.mix.volmod_submixes["mm_mute"][var_0] = spawnStruct();
      }
      level._audio.mix.volmod_submixes["mm_mute"][var_0].current_volume = 0.0;
      level._audio.mix.volmod_submixes["mm_mute"][var_0].original_volume = 1.0;
    } else {
      foreach(var_3 in var_0) {
        if(!isDefined(level._audio.mix.volmod_submixes["mm_mute"][var_3])) {
          level._audio.mix.volmod_submixes["mm_mute"][var_3] = spawnStruct();
        }
        level._audio.mix.volmod_submixes["mm_mute"][var_3].current_volume = 0.0;
        level._audio.mix.volmod_submixes["mm_mute"][var_3].original_volume = 1.0;
      }
    }

    mmx_update_mix(var_1, "mm_mute");
  }
}

mm_clear_volmod_mute_mix(var_0) {
  if(isDefined(level._audio.volmod_submixes["mm_mute"])) {
    level._audio.volmod_submixes["mm_mute"] = undefined;
    mmx_update_mix(var_0, "mm_mute");
  }
}

mm_solo_volmods(var_0, var_1) {
  if(!level._audio.mix.debug_mix_mode) {
    level._audio.mix.volmod_submixes["mm_solo"] = [];

    foreach(var_4, var_3 in level._audio.mix.volmod_vals) {
      level._audio.mix.volmod_submixes["mm_solo"][var_4] = spawnStruct();
      level._audio.mix.volmod_submixes["mm_solo"][var_4].current_volume = 0.0;
      level._audio.mix.volmod_submixes["mm_solo"][var_4].original_volume = 1.0;
    }

    if(isstring(var_0)) {
      level._audio.mix.volmod_submixes["mm_solo"][var_0].current_volume = 1.0;
    } else {
      foreach(var_6 in var_0) {}
      level._audio.mix.volmod_submixes["mm_solo"][var_6].current_volume = 1.0;
    }

    mmx_update_mix(var_1, "mm_solo");
  }
}

mm_clear_solo_volmods(var_0) {
  if(isDefined(level._audio.mix.volmod_submixes["mm_solo"])) {
    level._audio.mix.volmod_submixes["mm_solo"] = undefined;
    mmx_update_mix(var_0, "mm_solo");
  }
}

mm_get_channel_names() {
  return level._audio.mix.channel_names;
}

mm_get_num_volmod_submixes() {
  return level._audio.mix.volmod_submixes.size;
}

mm_get_num_submixes() {
  return 0;
}

mm_get_volmod_submix_name_by_index(var_0) {
  var_1 = undefined;

  if(isDefined(level._audio.mix.volmod_submixes) && var_0 < level._audio.mix.volmod_submixes.size) {
    var_2 = 0;

    foreach(var_6, var_4 in level._audio.mix.volmod_submixes) {
      if(var_4.size > 0) {
        if(var_2 == var_0) {
          if(var_6 == "zone_mix") {
            var_5 = level._audio.mix.volmod_submixes["zone_mix"]["preset_name"];
            var_6 = "zone_mix : " + var_5;
          }

          var_1 = var_6;
          break;
        }

        var_2++;
      }
    }
  }

  return var_1;
}

mm_get_volmod_submix_by_name(var_0) {
  var_1 = undefined;

  if(getsubstr(var_0, 0, 8) == "zone_mix") {
    var_0 = "zone_mix";
  }
  if(isDefined(level._audio.mix.volmod_submixes) && isDefined(level._audio.mix.volmod_submixes[var_0])) {
    if(level._audio.mix.volmod_submixes[var_0].size > 0) {
      var_1 = level._audio.mix.volmod_submixes[var_0];
    }
  }

  return var_1;
}

mm_set_default_volmod(var_0, var_1, var_2) {
  var_1 = clamp(var_1, 0, 1);

  if(isDefined(level._audio.mix.volmod_submixes["default"])) {
    if(isDefined(level._audio.mix.volmod_submixes["default"][var_0])) {
      level._audio.mix.volmod_submixes["default"][var_0].current_volume = var_1;
      mmx_update_mix(var_2, "default");
    } else {
      maps\_audio::aud_print_error("Trying to set a volmod value on the default submix but the volmod doesn't exist: " + var_0);
    }
  } else {
    maps\_audio::aud_print_error("Trying to set a volmod value on the default submix but \"default\" doesn't exist.");
  }
}

mm_get_original_default_volmod(var_0) {
  var_1 = undefined;

  if(isDefined(level._audio.mix.volmod_submixes["default"])) {
    if(isDefined(level._audio.mix.volmod_submixes["default"][var_0])) {
      var_1 = level._audio.mix.volmod_submixes["default"][var_0].original_volume;
    } else {
      maps\_audio::aud_print_error("Trying to set a volmod value on the default submix but the volmod doesn't exist: " + var_0);
    }
  } else {
    maps\_audio::aud_print_error("Trying to set a volmod value on the default submix but \"default\" doesn't exist.");
  }
  return var_1;
}

mm_restore_original_default_volmod(var_0, var_1) {
  var_2 = mm_get_original_default_volmod(var_0);

  if(isDefined(var_2)) {
    mm_set_default_volmod(var_0, var_2, var_1);
  }
}

mmx_set_mix(var_0, var_1, var_2) {
  mmx_make_new_submix(var_0, var_2);
  level._audio.mix.prev_preset = level._audio.mix.curr_preset;
  level._audio.mix.curr_preset = var_0;
  mmx_update_mix(var_1, var_0);
}

mmx_scale_submix(var_0, var_1) {
  if(isDefined(level._audio.mix.volmod_submixes[var_0])) {
    foreach(var_4, var_3 in level._audio.mix.volmod_submixes[var_0]) {}
    level._audio.mix.volmod_submixes[var_0][var_4].current_volume = var_3.original_volume * var_1;
  }
}

mmx_make_new_submix(var_0, var_1) {
  if(var_0 == "default") {
    return;
  }
  if(!isDefined(level._audio.mix.volmod_submixes[var_0])) {
    var_2 = mmx_get_mix_preset(var_0);

    if(!isDefined(var_2)) {
      return;
    }
    var_3 = 1.0;

    if(isDefined(var_1)) {
      var_3 = var_1;
      var_3 = max(var_3, 0.0);
    }

    level._audio.mix.volmod_submixes[var_0] = [];

    foreach(var_6, var_5 in var_2) {
      if(var_6 != "name" && var_6 != "fade_time") {
        level._audio.mix.volmod_submixes[var_0][var_6] = spawnStruct();
        level._audio.mix.volmod_submixes[var_0][var_6].current_volume = var_5 * var_3;
        level._audio.mix.volmod_submixes[var_0][var_6].original_volume = var_5;
      }
    }
  }
}

mmx_create_submix_blend(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_2)) {
    var_3 = clamp(var_2, 0, 1);
  }
  var_4 = spawnStruct();
  var_5 = mmx_get_mix_preset(var_1);

  if(!isDefined(var_5)) {
    return;
  }
  var_4.presetb = var_5;
  var_4.presetb["fade_time"] = undefined;
  var_4.presetb["name"] = undefined;

  if(isDefined(var_0)) {
    var_6 = mmx_get_mix_preset(var_0);

    if(!isDefined(var_6)) {
      return;
    }
    var_4.preseta = var_6;
    var_4.preseta["fade_time"] = undefined;
    var_4.preseta["name"] = undefined;
  } else {
    var_4.preseta = [];

    foreach(var_9, var_8 in var_4.presetb) {}
    var_4.preseta[var_9] = 1.0;
  }

  var_4.blendvalue = var_3;
  return var_4;
}

mmx_clear_submixes(var_0, var_1) {
  var_2 = 1;

  if(isDefined(var_0)) {
    var_2 = var_0;
  }
  foreach(var_5, var_4 in level._audio.mix.volmod_submixes) {
    if(var_5 != "default" && var_5 != "zone_mix" && !isDefined(level._audio.mix.sticky_submixes[var_5]) && var_5 != "mm_solo" && var_5 != "mm_mute") {
      level._audio.mix.volmod_submixes[var_5]["CLEAR"] = 1;
      level._audio.mix.changed_presets[var_5] = 1;
    }
  }

  if(var_2) {
    mmx_update_mix(var_1, undefined);
  }
}

mmx_update_mix(var_0, var_1) {
  level._audio.mix.last_fade_time = var_0;

  if(isDefined(var_1)) {
    level._audio.mix.changed_presets[var_1] = 1;
  }
  level notify("mix_update");
}

mmx_update_mix_thread() {
  level waittill("mix_update");

  for(;;) {
    waittillframeend;
    var_0 = 0;

    if(isDefined(level._audio.mix.last_fade_time)) {
      var_0 = level._audio.mix.last_fade_time;
    }
    mmx_update_volmod_groups(var_0);
    level waittill("mix_update");
  }
}

mmx_mix_in_non_changed_submixes() {
  var_0 = [];

  foreach(var_3, var_2 in level._audio.mix.volmod_submixes) {
    if(!isDefined(level._audio.mix.changed_presets[var_3])) {
      var_0[var_3] = 1;
    }
  }

  foreach(var_8, var_5 in level._audio.mix.volume_products) {
    foreach(var_3, var_7 in var_0) {
      if(isDefined(level._audio.mix.volmod_submixes[var_3][var_8])) {
        level._audio.mix.volume_products[var_8] = level._audio.mix.volume_products[var_8] * level._audio.mix.volmod_submixes[var_3][var_8].current_volume;
      }
    }
  }
}

mmx_update_volmod_groups(var_0) {
  var_1 = 1.0;

  if(isDefined(var_0)) {
    var_1 = var_0;
    var_1 = max(var_1, 0.0);
  }

  level._audio.mix.volume_products = undefined;
  mmx_set_volume_products_volmods(0);
  mmx_mix_in_non_changed_submixes();
  var_2 = 0;

  foreach(var_5, var_4 in level._audio.mix.volume_products) {
    if(var_5 != "voiceover_critical" && var_5 != "fullvolume") {
      var_4 = var_4 * level._audio.mix.headroom;
    }
    if(var_4 != level._audio.mix.volmod_vals[var_5].volume) {
      var_2 = 1;
      level._audio.mix.volmod_vals[var_5].volume = var_4;
      level._audio.mix.volmod_vals[var_5].fade_time = var_1;
      mmx_volmod_setting_enqueue(var_5, var_4, var_1);
    }
  }

  level._audio.mix.changed_presets = [];

  if(var_2) {
    level notify("aud_new_volmod_set");
  }
}

mmx_set_volume_products_volmods(var_0) {
  level._audio.mix.volume_products = [];
  var_1 = [];

  foreach(var_16, var_3 in level._audio.mix.changed_presets) {
    if(isDefined(level._audio.mix.volmod_submixes[var_16])) {
      var_4 = level._audio.mix.volmod_submixes[var_16];
      var_4["name"] = undefined;
      var_4["fade_time"] = undefined;
      var_4["preset_name"] = undefined;
      var_5 = 0;

      if(isDefined(var_4["CLEAR"])) {
        var_5 = 1;
      }
      var_4["CLEAR"] = undefined;

      foreach(var_8, var_7 in var_4) {
        if(isDefined(level._audio.mix.volume_products[var_8]) && !var_5) {
          level._audio.mix.volume_products[var_8] = level._audio.mix.volume_products[var_8] * var_7.current_volume;
          continue;
        }

        if(var_5 && !isDefined(level._audio.mix.volume_products[var_8])) {
          level._audio.mix.volume_products[var_8] = 1.0;
          continue;
        }

        if(!var_5) {
          level._audio.mix.volume_products[var_8] = var_7.current_volume;
        }
      }

      if(var_5) {
        level._audio.mix.volmod_submixes[var_16] = undefined;
      }
      continue;
    }

    if(isDefined(level._audio.mix.volmod_submixblends[var_16])) {
      var_9 = level._audio.mix.volmod_submixblends[var_16];
      var_5 = 0;

      if(isDefined(var_9.clear)) {
        var_5 = 1;
      }
      foreach(var_8, var_11 in var_9.preseta) {
        if(!isDefined(var_1[var_8])) {
          var_1[var_8] = 1.0;
        }
        if(!var_5) {
          var_12 = var_9.presetb[var_8];
          var_13 = var_9.preseta[var_8];
          var_14 = var_9.blendvalue;
          var_15 = var_14 * (var_12 - var_13) + var_13;
          var_1[var_8] = var_1[var_8] * var_15;
        }
      }

      if(var_5) {
        level._audio.mix.volmod_submixblends[var_16] = undefined;
      }
    }
  }

  foreach(var_18, var_11 in var_1) {
    if(isDefined(level._audio.mix.volume_products[var_18])) {
      level._audio.mix.volume_products[var_18] = level._audio.mix.volume_products[var_18] * var_11;
      continue;
    }

    level._audio.mix.volume_products[var_18] = var_11;
  }
}

mmx_apply_initial_mix() {
  var_0 = undefined;
  var_1 = undefined;
}

mmx_apply_debug_mix(var_0) {
  if(level._audio.mix.debug_mix_mode) {
    while(!isDefined(level.player)) {
      wait 0.05;
    }
    mmx_set_mix(var_0);
  }
}

mmx_volmod_setting_enqueue(var_0, var_1, var_2) {
  if(!isDefined(level._audio.mix.volmod_queue)) {
    level._audio.mix.volmod_queue = [];
    level._audio.mix.volmod_index = 0;
  }

  var_3 = 0;

  foreach(var_6, var_5 in level._audio.mix.volmod_queue) {
    if(var_5["volmod"] == var_0) {
      var_3 = 1;
      level._audio.mix.volmod_queue[var_6]["volume"] = var_1;
      level._audio.mix.volmod_queue[var_6]["fade_time"] = var_2;
      break;
    }
  }

  if(!var_3) {
    var_7 = [];
    var_7["volmod"] = var_0;
    var_7["volume"] = var_1;
    var_7["fade_time"] = var_2;
    level._audio.mix.volmod_queue[level._audio.mix.volmod_index] = var_7;
    level._audio.mix.volmod_index++;
  }
}

mmx_mix_setting_enqueue(var_0, var_1, var_2) {
  if(!isDefined(level._audio.mix.queue)) {
    level._audio.mix.queue = [];
    level._audio.mix.index = 0;
  }

  var_3 = 0;

  foreach(var_6, var_5 in level._audio.mix.queue) {
    if(var_5["channel"] == var_0) {
      var_3 = 1;
      level._audio.mix.queue[var_6]["volume"] = var_1;
      level._audio.mix.queue[var_6]["fade_time"] = var_2;
      break;
    }
  }

  if(!var_3) {
    var_7 = [];
    var_7["channel"] = var_0;
    var_7["volume"] = var_1;
    var_7["fade_time"] = var_2;
    level._audio.mix.queue[level._audio.mix.index] = var_7;
    level._audio.mix.index++;
  }
}

mmx_volmod_server_throttler(var_0) {
  if(!isDefined(level._audio.mix.volmod_queue)) {
    level._audio.mix.volmod_queue = [];
    level._audio.mix.volmod_index = 0;
  }

  var_1 = 5;

  if(isDefined(var_0)) {
    var_1 = var_0;
    var_1 = max(var_1, 1);
  }

  for(;;) {
    level waittill("aud_new_volmod_set");

    while(level._audio.mix.volmod_queue.size > 0) {
      var_2 = 0;
      var_3 = [];

      foreach(var_10, var_5 in level._audio.mix.volmod_queue) {
        if(var_2 < var_1) {
          var_2++;
          var_3[var_3.size] = var_10;
          var_6 = level._audio.mix.volmod_queue[var_10];
          var_7 = var_6["volmod"];
          var_8 = var_6["volume"];
          var_9 = var_6["fade_time"];
          var_8 = clamp(var_8, 0.0, 1.0);
          level.player setvolmod(var_7, var_8, var_9);
          continue;
        }

        break;
      }

      for(var_11 = 0; var_11 < var_3.size; var_11++) {
        var_12 = var_3[var_11];
        level._audio.mix.volmod_queue[var_12] = undefined;
      }

      wait 0.05;
    }
  }
}

mmx_mix_server_throttler(var_0) {
  if(!isDefined(level._audio.mix.queue)) {
    level._audio.mix.queue = [];
    level._audio.mix.index = 0;
  }

  var_1 = 5;

  if(isDefined(var_0)) {
    var_1 = var_0;
    var_1 = max(var_1, 1);
  }

  for(;;) {
    level waittill("aud_new_mix_set");

    while(level._audio.mix.queue.size > 0) {
      var_2 = 0;
      var_3 = [];

      foreach(var_10, var_5 in level._audio.mix.queue) {
        if(var_2 < var_1) {
          var_2++;
          var_3[var_3.size] = var_10;
          var_6 = level._audio.mix.queue[var_10];
          var_7 = var_6["channel"];
          var_8 = var_6["volume"];
          var_9 = var_6["fade_time"];
          var_8 = clamp(var_8, 0.0, 1.0);
          level.player setchannelvolume(var_7, var_8, var_9);
          continue;
        }

        break;
      }

      for(var_11 = 0; var_11 < var_3.size; var_11++) {
        var_12 = var_3[var_11];
        level._audio.mix.queue[var_12] = undefined;
      }

      wait 0.05;
    }
  }
}

mmx_get_preset_from_string_table(var_0, var_1) {
  var_2 = [];
  var_3 = maps\_audio::get_mix_stringtable();
  var_4 = "soundtables/common_mix.csv";

  if(!isDefined(level._audio.mix.preset_cache)) {
    level._audio.mix.preset_cache = [];
  }
  if(isDefined(level._audio.mix.preset_cache[var_0])) {
    var_2 = level._audio.mix.preset_cache[var_0];
  } else {
    if(var_1) {
      var_2 = mmx_get_mix_preset_from_stringtable_internal(var_3, var_0, 0);
    }
    if(!isDefined(var_2) || var_2.size == 0) {
      var_2 = mmx_get_mix_preset_from_stringtable_internal(var_4, var_0, 1);
    }
    if(!isDefined(var_2) || var_2.size == 0) {
      return;
    }
    level._audio.mix.preset_cache[var_0] = var_2;
  }

  return var_2;
}

mmx_get_mix_preset_from_stringtable_internal(var_0, var_1, var_2) {
  var_3 = 4;
  var_4 = "";
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = undefined;
  var_9 = [];

  if(!isDefined(level._audio.mix.param_names)) {
    level._audio.mix.param_names = [];
  }
  if(!isDefined(level._audio.mix.param_names[var_0])) {
    level._audio.mix.param_names[var_0] = [];

    for(var_10 = 1; var_10 < var_3; var_10++) {
      var_11 = tablelookupbyrow(var_0, 0, var_10);
      level._audio.mix.param_names[var_0][var_11] = var_10;
    }
  }

  var_12 = maps\_audio::get_indexed_preset("mix", var_1, var_2);

  if(var_12 != -1) {
    var_5 = var_12;
  } else if(var_2 && maps\_audio::aud_is_common_indexed() || !var_2 && maps\_audio::aud_is_local_indexed()) {
    return var_9;
  }
  for(var_13 = 0; var_4 != "EOF" && var_7 < 10; var_5++) {
    var_4 = tablelookupbyrow(var_0, var_5, 0);

    if(var_4 != "") {
      var_7 = 0;
    }
    while(var_4 == var_1) {
      var_6 = 1;

      if(!isDefined(var_8)) {
        var_14 = level._audio.mix.param_names[var_0]["fade_time"];
        var_8 = tablelookupbyrow(var_0, var_5, var_14);

        if(!isDefined(var_8) || isDefined(var_8) && var_8 == "") {
          var_8 = 1.0;
        }
      }

      var_15 = level._audio.mix.param_names[var_0]["channels"];
      var_16 = level._audio.mix.param_names[var_0]["value"];
      var_17 = tablelookupbyrow(var_0, var_5, var_15);
      var_18 = tablelookupbyrow(var_0, var_5, var_16);

      if(var_17 == "set_all" || var_17 == "setall") {
        if(float(var_18) < 1) {
          var_9 = volmod_mix_with_all_channels_at(float(var_18));
        }
      } else {
        if(!isDefined(level._audio.mix.volmodfile[var_17])) {
          maps\_audio::aud_print_error("In soundtable " + var_0 + ", " + var_1 + " uses a volmod group name that doesn't exist in the volmodgroups.csv file.");
          return;
        }

        var_9[var_17] = float(var_18);
      }

      var_5++;
      var_4 = tablelookupbyrow(var_0, var_5, 0);
      var_13++;
    }

    var_7++;

    if(var_6) {
      break;
    }
  }

  if(var_6 && isDefined(var_8)) {
    var_9["fade_time"] = float(var_8);
  }
  return var_9;
}

mmx_get_mix_preset(var_0) {
  if(!isDefined(level._audio.mix.preset_cache)) {
    level._audio.mix.preset_cache = [];
  }
  var_1 = [];

  if(isDefined(level._audio.mix.preset_cache[var_0])) {
    var_1 = level._audio.mix.preset_cache[var_0];
  } else {
    var_1 = undefined;

    if(level._audio.mix.use_string_table_presets) {
      var_1 = mmx_get_preset_from_string_table(var_0, 1);
    } else {
      var_1 = mmx_get_preset_from_string_table(var_0, 0);

      if(!isDefined(var_1) || var_1.size == 0) {
        var_1 = maps\_audio::audio_presets_mix(var_0, var_1);
      }
    }

    if(!isDefined(var_1) || var_1.size == 0) {
      return;
    }
    var_1["name"] = var_0;

    if(!isDefined(var_1["fade_time"])) {
      var_1["fade_time"] = 1.0;
    }
    level._audio.mix.preset_cache[var_0] = var_1;
  }

  return var_1;
}

mmx_init_volmods() {
  if(!isDefined(level._audio.mix.volmodfile)) {
    mmx_parse_volumemodgroups_csv();
  }
  level._audio.mix.volmod_vals = [];

  foreach(var_2, var_1 in level._audio.mix.volmodfile) {
    level._audio.mix.volmod_vals[var_2] = spawnStruct();
    level._audio.mix.volmod_vals[var_2].volume = var_1;
    level._audio.mix.volmod_vals[var_2].fade_time = 0.0;
  }

  mmx_init_channel_names();
}

mmx_init_channel_names() {
  if(!isDefined(level._audio.mix.channel_names)) {
    var_0 = [];
    var_0["physics"] = 1;
    var_0["ambdist1"] = 1;
    var_0["ambdist2"] = 1;
    var_0["auto"] = 1;
    var_0["auto2"] = 1;
    var_0["auto2d"] = 1;
    var_0["autodog"] = 1;
    var_0["explosiondist1"] = 1;
    var_0["explosiondist2"] = 1;
    var_0["explosiveimpact"] = 1;
    var_0["element"] = 1;
    var_0["element_int"] = 1;
    var_0["element_ext"] = 1;
    var_0["bulletimpact"] = 1;
    var_0["bulletflesh1"] = 1;
    var_0["bulletflesh2"] = 1;
    var_0["bulletwhizby"] = 1;
    var_0["vehicle"] = 1;
    var_0["vehiclelimited"] = 1;
    var_0["menu"] = 1;
    var_0["body"] = 1;
    var_0["body2d"] = 1;
    var_0["reload"] = 1;
    var_0["reload2d"] = 1;
    var_0["item"] = 1;
    var_0["explosion1"] = 1;
    var_0["explosion2"] = 1;
    var_0["explosion3"] = 1;
    var_0["explosion4"] = 1;
    var_0["explosion5"] = 1;
    var_0["effects1"] = 1;
    var_0["effects2"] = 1;
    var_0["effects3"] = 1;
    var_0["effects2d1"] = 1;
    var_0["effects2d2"] = 1;
    var_0["vehicle2d"] = 1;
    var_0["weapon_dist"] = 1;
    var_0["weapon_mid"] = 1;
    var_0["weapon"] = 1;
    var_0["weapon2d"] = 1;
    var_0["nonshock"] = 1;
    var_0["nonshock2"] = 1;
    var_0["voice"] = 1;
    var_0["local"] = 1;
    var_0["local2"] = 1;
    var_0["local3"] = 1;
    var_0["ambient"] = 1;
    var_0["hurt"] = 1;
    var_0["player1"] = 1;
    var_0["player2"] = 1;
    var_0["music"] = 1;
    var_0["musicnopause"] = 1;
    var_0["grondo3d"] = 1;
    var_0["grondo2d"] = 1;
    var_0["mission"] = 1;
    var_0["critical"] = 1;
    var_0["announcer"] = 1;
    var_0["shellshock"] = 1;
    level._audio.mix.channel_names = var_0;
  }
}

mmx_get_channel_volumes() {
  return level._audio.mix.channel_volumes;
}

volmod_mix_with_all_channels_at(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in level._audio.mix.volmodfile) {
    if(var_4 != "hud" && var_4 != "interface" && var_4 != "interface_music") {
      var_1[var_4] = var_0;
    }
  }

  return var_1;
}

mmx_parse_volumemodgroups_csv() {
  var_0 = "soundaliases/volumemodgroups.svmod";
  level._audio.mix.volmodfile = [];
  var_1 = 10;
  var_2 = 0;
  var_3 = 0;

  while(var_2 < var_1) {
    var_4 = tablelookupbyrow(var_0, var_3, 0);

    if(var_4 == "") {
      var_2++;
      continue;
    }

    var_5 = getsubstr(var_4, 0, 0);

    if(var_5 == "#") {
      continue;
    }
    var_6 = tablelookupbyrow(var_0, var_3, 1);
    level._audio.mix.volmodfile[var_4] = float(var_6);
    var_3++;
  }

  if(!isDefined(level._audio.volmod_submixes)) {
    level._audio.volmod_submixes = [];
  }
  level._audio.mix.volmod_submixes["default"] = [];

  foreach(var_4, var_8 in level._audio.mix.volmodfile) {
    level._audio.mix.volmod_submixes["default"][var_4] = spawnStruct();
    level._audio.mix.volmod_submixes["default"][var_4].current_volume = var_8;
    level._audio.mix.volmod_submixes["default"][var_4].original_volume = var_8;
  }
}

mmx_is_mix_channel(var_0) {
  return isDefined(level._audio.mix.channel_names[var_0]);
}

mmx_is_volmod_channel(var_0) {
  return isDefined(level._audio.mix.volmodfile[var_0]);
}