/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\139.gsc
**************************************/

azm_init() {
  if(!isDefined(level._audio.zone_mgr)) {
    level._audio.zone_mgr = spawnStruct();
    level._audio.zone_mgr.current_zone = "";
    level._audio.zone_mgr.zones = [];
    level._audio.zone_mgr.overrides = spawnStruct();
    level._audio.zone_mgr.overrides.samb = [];
    level._audio.zone_mgr.overrides.damb = [];
    level._audio.zone_mgr.overrides.mix = [];
    level._audio.zone_mgr.overrides.rev = [];
    level._audio.zone_mgr.overrides.occ = [];
    level._audio.zone_mgr.use_string_table_presets = 0;
    level._audio.zone_mgr.use_iw_presets = 0;
  }

  if(!isDefined(level._audio.use_level_audio_zones)) {
    level._audio.level_audio_zones_function = undefined;
  }
}

azm_use_string_table() {
  level._audio.zone_mgr.use_string_table_presets = 1;
  level._audio.zone_mgr.use_iw_presets = 0;
}

azm_use_iw_presets() {
  level._audio.zone_mgr.use_iw_presets = 1;
  level._audio.zone_mgr.use_string_table_presets = 0;
}

azm_start_zone(var_0, var_1, var_2) {
  if(level._audio.zone_mgr.current_zone == var_0) {
    return;
  } else if(level._audio.zone_mgr.current_zone != "") {
    azm_stop_zone(level._audio.zone_mgr.current_zone, var_1);
  }
  level._audio.zone_mgr.current_zone = var_0;

  if(isDefined(level._audio.zone_mgr.zones[var_0]) && isDefined(level._audio.zone_mgr.zones[var_0]["state"]) && level._audio.zone_mgr.zones[var_0]["state"] != "stopping") {
    maps\_audio::aud_print_warning("ZONEM_start_zone(\"" + var_0 + "\") being called even though audio zone, \"" + var_0 + "\", is already started.");
    return;
  }

  var_3 = 2.0;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }
  if(!isDefined(level._audio.zone_mgr.zones[var_0])) {
    var_4 = azmx_load_zone(var_0);

    if(!isDefined(var_4)) {
      return;
    }
    level._audio.zone_mgr.zones[var_0] = var_4;
  }

  var_4 = level._audio.zone_mgr.zones[var_0];
  maps\_audio::aud_print_zone("ZONE START: " + var_0);
  level._audio.zone_mgr.zones[var_0]["state"] = "playing";
  var_5 = var_4["priority"];
  var_6 = var_4["interrupt_fade"];

  if(isDefined(var_4["streamed_ambience"])) {
    if(var_4["streamed_ambience"] != "none") {
      maps\_audio_stream_manager::sm_start_preset(var_4["streamed_ambience"], var_3, var_5, var_6);
    } else {
      maps\_audio_stream_manager::sm_stop_ambience(var_3);
    }
  }

  if(isDefined(var_4["dynamic_ambience"])) {
    if(var_4["dynamic_ambience"] != "none") {
      maps\_audio_dynamic_ambi::damb_zone_start_preset(var_4["dynamic_ambience"], 1.0);
    } else {
      maps\_audio_dynamic_ambi::damb_stop_zone(1.0);
    }
  }

  if(isDefined(var_4["occlusion"])) {
    if(var_4["occlusion"] != "none") {
      maps\_audio::aud_set_occlusion(var_4["occlusion"]);
    } else {
      maps\_audio::aud_deactivate_occlusion();
    }
  }

  if(isDefined(var_4["filter"])) {
    if(var_4["filter"] != "none") {
      maps\_audio::aud_set_filter(var_4["filter"], 0);
      level.player seteqlerp(1, 0);
    }
  }

  if(isDefined(var_4["reverb"])) {
    if(var_4["reverb"] != "none") {
      maps\_audio_reverb::rvb_start_preset(var_4["reverb"]);
    } else {
      maps\_audio_reverb::rvb_deactive_reverb();
    }
  }

  if(isDefined(var_4["mix"])) {
    if(var_4["mix"] != "none") {
      maps\_audio_mix_manager::mm_start_zone_preset(var_4["mix"]);
    } else {
      maps\_audio_mix_manager::mm_clear_zone_mix(1.0);
    }
  }
}

azm_set_zone_streamed_ambience(var_0, var_1, var_2) {
  var_3 = azmx_set_param_internal(var_0, "streamed_ambience", var_1, ::azmx_restart_stream, var_2);

  if(!var_3) {
    if(!isDefined(var_1)) {
      var_1 = "none";
    }
    level._audio.zone_mgr.overrides.samb[var_0] = var_1;
  }
}

azm_set_zone_dynamic_ambience(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "none";
  }
  azmx_set_param_internal(var_0, "dynamic_ambience", var_1, ::azmx_restart_damb, var_2);
  level._audio.zone_mgr.overrides.damb[var_0] = var_1;
}

azm_set_zone_reverb(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "none";
  }
  azmx_set_param_internal(var_0, "reverb", var_1, ::azmx_restart_reverb, var_2);
  level._audio.zone_mgr.overrides.rev[var_0] = var_1;
}

azm_set_zone_occlusion(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "none";
  }
  azmx_set_param_internal(var_0, "occlusion", var_1, ::azmx_restart_occlusion, var_2);
  level._audio.zone_mgr.overrides.mix[var_1] = var_1;
}

azm_set_zone_mix(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "none";
  }
  azmx_set_param_internal(var_0, "mix", var_1, ::azmx_restart_mix, var_2);
  level._audio.zone_mgr.overrides.mix[var_1] = var_1;
}

azm_stop_zones(var_0) {
  var_1 = 1.0;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }
  maps\_audio::aud_print_zone("ZONE STOP ALL");

  foreach(var_3 in level._audio.zone_mgr.zones) {}
  azm_stop_zone(var_3["name"], var_1, 0);
}

azm_stop_zone(var_0, var_1, var_2) {
  if(isDefined(level._audio.zone_mgr.zones[var_0]) && isDefined(level._audio.zone_mgr.zones[var_0]["state"]) && level._audio.zone_mgr.zones[var_0]["state"] != "stopping") {
    var_3 = 1.0;

    if(isDefined(var_1)) {
      var_3 = var_1;
    }
    var_4 = level._audio.zone_mgr.zones[var_0];
    var_5 = 0;

    if(isDefined(var_2)) {
      var_5 = var_2;
    }
    if(var_5) {
      maps\_audio::aud_print_zone("ZONE STOP ZONE: " + var_0);
    }
    if(isDefined(var_4["streamed_ambience"])) {
      maps\_audio_stream_manager::sm_stop_ambient_alias(var_4["streamed_ambience"], var_3);
    }
    if(isDefined(var_4["dynamic_ambience"])) {
      maps\_audio_dynamic_ambi::damb_zone_stop_preset(var_4["dynamic_ambience"], var_3);
    }
    level._audio.zone_mgr.zones[var_0]["state"] = "stopping";
    thread azmx_wait_till_fade_done_and_remove_zone(var_0, var_3);
  }
}

azm_get_current_zone() {
  return level._audio.zone_mgr.current_zone;
}

azm_set_current_zone(var_0) {
  level._audio.zone_mgr.current_zone = var_0;
}

azm_print_enter_blend(var_0, var_1, var_2) {}

azm_print_exit_blend(var_0) {}

azm_print_progress(var_0) {}

azmx_load_zone(var_0) {
  if(isDefined(level._audio.zone_mgr.zones[var_0])) {
    return;
  }
  if(!isDefined(level._audio.zone_mgr.preset_cache)) {
    level._audio.zone_mgr.preset_cache = [];
  }
  var_1 = [];

  if(isDefined(level._audio.zone_mgr.preset_cache[var_0])) {
    var_1 = level._audio.zone_mgr.preset_cache[var_0];
  } else {
    var_1 = azmx_get_preset_from_string_table(var_0, 1);
  }
  if(!isDefined(var_1) || var_1.size == 0) {
    return;
  }
  level._audio.zone_mgr.preset_cache[var_0] = var_1;
  var_2 = 0;

  if(isDefined(level._audio.zone_mgr.overrides.samb[var_0])) {
    if(level._audio.zone_mgr.overrides.samb[var_0] == "none") {
      var_1["streamed_ambience"] = undefined;
    } else {
      var_1["streamed_ambience"] = level._audio.zone_mgr.overrides.samb[var_0];
    }
    var_2 = 1;
    level._audio.zone_mgr.overrides.samb[var_0] = undefined;
  }

  if(isDefined(level._audio.zone_mgr.overrides.damb[var_0])) {
    if(level._audio.zone_mgr.overrides.damb[var_0] == "none") {
      var_1["dynamic_ambience"] = undefined;
    } else {
      var_1["dynamic_ambience"] = level._audio.zone_mgr.overrides.damb[var_0];
    }
    var_2 = 1;
    level._audio.zone_mgr.overrides.damb[var_0] = undefined;
  }

  if(isDefined(level._audio.zone_mgr.overrides.rev[var_0])) {
    if(level._audio.zone_mgr.overrides.rev[var_0] == "none") {
      var_1["reverb"] = undefined;
    } else {
      var_1["reverb"] = level._audio.zone_mgr.overrides.rev[var_0];
    }
    var_2 = 1;
    level._audio.zone_mgr.overrides.rev[var_0] = undefined;
  }

  if(isDefined(level._audio.zone_mgr.overrides.occ[var_0])) {
    if(level._audio.zone_mgr.overrides.occ[var_0] == "none") {
      var_1["occlusion"] = undefined;
    } else {
      var_1["occlusion"] = level._audio.zone_mgr.overrides.occ[var_0];
    }
    var_2 = 1;
    level._audio.zone_mgr.overrides.occ[var_0] = undefined;
  }

  if(isDefined(level._audio.zone_mgr.overrides.mix[var_0])) {
    if(level._audio.zone_mgr.overrides.mix[var_0] == "none") {
      var_1["mix"] = undefined;
    } else {
      var_1["mix"] = level._audio.zone_mgr.overrides.mix[var_0];
    }
    var_2 = 1;
    level._audio.zone_mgr.overrides.mix[var_0] = undefined;
  }

  if(var_2) {
    level._audio.zone_mgr.preset_cache[var_0] = var_1;
  }
  var_1["name"] = var_0;

  if(!isDefined(var_1["priority"])) {
    var_1["priority"] = 1;
  }
  if(!isDefined(var_1["interrupt_fade"])) {
    var_1["interrupt_fade"] = 0.1;
  }
  return var_1;
}

azmx_get_preset_from_string_table(var_0, var_1) {
  var_2 = "soundtables/common_zone.csv";
  var_3 = maps\_audio::get_zone_stringtable();
  var_4 = [];

  if(var_1) {
    var_4 = azmx_get_zone_preset_from_stringtable_internal(var_3, var_0);
  }
  if(!isDefined(var_4) || var_4.size == 0) {
    var_4 = azmx_get_zone_preset_from_stringtable_internal(var_2, var_0);
  }
  if(!isDefined(var_4) || var_4.size == 0) {
    return;
  }
  return var_4;
}

azmx_get_zone_preset_from_stringtable_internal(var_0, var_1) {
  var_2 = [];
  var_3 = "";
  var_4 = "";
  var_5 = 8;

  for(var_6 = 1; var_6 < var_5; var_6++) {
    if(var_3 != "comments" && var_4 != "") {
      var_2[var_3] = var_4;
    }
    var_3 = tablelookup(var_0, 0, "zone_names", var_6);
    var_4 = tablelookup(var_0, 0, var_1, var_6);

    if(var_3 != "comment" && var_3 != "comments" && var_4 != "") {
      switch (var_3) {
        case "streamed_ambience":
          var_2["streamed_ambience"] = var_4;
          break;
        case "dynamic_ambience":
          var_2["dynamic_ambience"] = var_4;
          break;
        case "mix":
          var_2["mix"] = var_4;
          break;
        case "reverb":
          var_2["reverb"] = var_4;
          break;
        case "filter":
          var_2["filter"] = var_4;
          break;
        case "occlusion":
          var_2["occlusion"] = var_4;
          break;
        default:
          break;
      }
    }
  }

  return var_2;
}

azmx_restart_stream(var_0, var_1) {
  var_2 = level._audio.zone_mgr.zones[var_0]["streamed_ambience"];

  if(isDefined(var_2)) {
    maps\_audio_stream_manager::sm_start_preset(var_2, var_1);
  } else {
    maps\_audio_stream_manager::sm_stop_ambience(var_1);
  }
}

azmx_restart_damb(var_0, var_1) {
  var_2 = 1.0;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }
  var_3 = level._audio.zone_mgr.zones[var_0]["dynamic_ambience"];

  if(isDefined(var_3)) {
    maps\_audio_dynamic_ambi::damb_zone_start_preset(var_3, var_2);
  } else {
    maps\_audio_dynamic_ambi::damb_zone_stop_preset(undefined, var_2);
  }
}

azmx_restart_reverb(var_0, var_1) {
  var_2 = level._audio.zone_mgr.zones[var_0]["reverb"];

  if(isDefined(var_2)) {
    maps\_audio_reverb::rvb_start_preset(var_2);
  }
}

azmx_restart_occlusion(var_0, var_1) {
  var_2 = level._audio.zone_mgr.zones[var_0]["occlusion"];

  if(isDefined(var_2)) {
    maps\_audio::aud_set_occlusion(var_2);
  }
}

azmx_restart_mix(var_0, var_1) {
  var_2 = level._audio.zone_mgr.zones[var_0]["mix"];

  if(isDefined(var_2)) {
    maps\_audio_mix_manager::mm_start_preset(var_2);
  }
}

azmx_set_param_internal(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level._audio.zone_mgr.zones[var_0])) {
    if(isDefined(level._audio.zone_mgr.zones[var_0][var_1]) && level._audio.zone_mgr.zones[var_0][var_1] != var_2 || !isDefined(level._audio.zone_mgr.zones[var_0][var_1]) && var_2 != "none") {
      if(var_2 == "none") {
        level._audio.zone_mgr.zones[var_0][var_1] = undefined;
      } else {
        level._audio.zone_mgr.zones[var_0][var_1] = var_2;
      }
      if(var_0 == azm_get_current_zone()) {
        [[var_3]](var_0, var_4);
      }
    }

    return 1;
  } else {
    return 0;
  }
}

azmx_wait_till_fade_done_and_remove_zone(var_0, var_1) {
  wait(var_1);
  wait 0.05;

  if(level._audio.zone_mgr.zones[var_0]["state"] == "stopping") {
    return;
  }
}

azmx_get_blend_args(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.zone_from_name = var_0;
  var_2.zone_to_name = var_1;
  var_2.samb1_name = undefined;
  var_2.samb2_name = undefined;
  var_2.damb1_name = undefined;
  var_2.damb2_name = undefined;
  var_2.occlusion1 = undefined;
  var_2.occlusion2 = undefined;
  var_2.filter1 = undefined;
  var_2.filter2 = undefined;
  var_2.reverb1 = undefined;
  var_2.reverb2 = undefined;
  var_2.mix1_name = undefined;
  var_2.mix2_name = undefined;

  if(!isDefined(level._audio.zone_mgr.zones[var_0])) {
    var_3 = azmx_load_zone(var_0);

    if(!isDefined(var_3)) {
      maps\_audio::aud_print_warning("Couldn't find zone: " + var_0);
      return;
    }

    level._audio.zone_mgr.zones[var_0] = var_3;
  }

  var_4 = level._audio.zone_mgr.zones[var_0];

  if(!isDefined(level._audio.zone_mgr.zones[var_1])) {
    var_3 = azmx_load_zone(var_1);

    if(!isDefined(var_3)) {
      maps\_audio::aud_print_warning("Couldn't find zone: " + var_1);
      return;
    }

    level._audio.zone_mgr.zones[var_1] = var_3;
  }

  var_5 = level._audio.zone_mgr.zones[var_1];
  var_2.occlusion1 = var_4["occlusion"];
  var_2.occlusion2 = var_5["occlusion"];
  var_2.filter1 = var_4["filter"];
  var_2.filter2 = var_5["filter"];
  var_2.reverb1 = var_4["reverb"];
  var_2.reverb2 = var_5["reverb"];
  var_2.mix1 = var_4["mix"];
  var_2.mix2 = var_5["mix"];
  var_2.samb1_name = var_4["streamed_ambience"];
  var_2.samb2_name = var_5["streamed_ambience"];
  var_6 = level._audio.damb.playing["zone"].size;

  if(var_6 != 1) {
    maps\_audio_dynamic_ambi::damb_stop(1.0, "zone");
  }
  if(var_6 == 1) {
    foreach(var_9, var_8 in level._audio.damb.playing["zone"]) {
      var_2.damb1_name = var_9;
      break;
    }
  }

  var_2.damb2_name = var_5["dynamic_ambience"];
  return var_2;
}

azmx_is_valid_damb_blend_request(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0) && isDefined(var_1) && var_0 != var_1) {
    var_2 = 1;
  } else if(isDefined(var_1) && !isDefined(var_0)) {
    var_2 = 1;
  } else if(isDefined(var_0) && !isDefined(var_1)) {
    var_2 = 1;
  }
  return var_2;
}

azmx_is_valid_samb_blend_request(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0) && isDefined(var_1) && var_0 != var_1) {
    var_2 = 1;
  } else if(isDefined(var_1) && !isDefined(var_0)) {
    var_2 = 1;
  }
  return var_2;
}

azmx_blend_zones(var_0, var_1, var_2) {
  if(azmx_is_valid_samb_blend_request(var_2.samb1_name, var_2.samb2_name)) {
    var_3 = [];
    var_4 = 0;

    if(isDefined(var_2.samb1_name) && var_2.samb1_name != "") {
      var_5 = level._audio.zone_mgr.zones[var_2.zone_from_name];
      var_3[var_4] = spawnStruct();
      var_3[var_4].alias = var_2.samb1_name;
      var_3[var_4].vol = var_0;
      var_3[var_4].fade = var_5["interrupt_fade"];
      var_3[var_4].priority = var_5["priority"];
      var_4++;
    }

    if(isDefined(var_2.samb2_name) && var_2.samb2_name != "") {
      var_6 = level._audio.zone_mgr.zones[var_2.zone_to_name];
      var_3[var_4] = spawnStruct();
      var_3[var_4].alias = var_2.samb2_name;
      var_3[var_4].vol = var_1;
      var_3[var_4].fade = var_6["interrupt_fade"];
      var_3[var_4].priority = var_6["priority"];
    }

    if(var_3.size > 0) {
      maps\_audio_stream_manager::sm_mix_ambience(var_3);
    }
  }

  if(azmx_is_valid_damb_blend_request(var_2.damb1_name, var_2.damb2_name)) {
    maps\_audio_dynamic_ambi::damb_prob_mix_damb_presets(var_2.damb1_name, var_0, var_2.damb2_name, var_1);
  }
  var_7 = 0;

  if(maps\_audio::aud_is_zone_filter_enabled()) {
    if(isDefined(var_2.filter1)) {
      var_7 = 1;
      maps\_audio::aud_set_filter(var_2.filter1, 0, 0);
    } else {
      maps\_audio::aud_set_filter(undefined, 0, 0);
    }
    if(isDefined(var_2.filter2)) {
      var_7 = 1;
      maps\_audio::aud_set_filter(var_2.filter2, 1, 0);
    } else {
      maps\_audio::aud_set_filter(undefined, 1, 0);
    }
    if(!(isDefined(level._audio.zone_occlusion_and_filtering_disabled) && level._audio.zone_occlusion_and_filtering_disabled)) {
      if(isDefined(var_2.filter1) || isDefined(var_2.filter2)) {
        level.player seteqlerp(var_0, 0);
      }
    }
  }

  if(var_0 >= 0.75) {
    if(isDefined(var_2.reverb1)) {
      if(var_2.reverb1 == "none") {
        maps\_audio_reverb::rvb_start_preset(undefined);
      } else {
        maps\_audio_reverb::rvb_start_preset(var_2.reverb1);
      }
    }

    if(isDefined(var_2.mix1)) {
      if(var_2.mix1 == "none") {
        maps\_audio_mix_manager::mm_clear_zone_mix(2.0);
      } else {
        maps\_audio_mix_manager::mm_start_zone_preset(var_2.mix1);
      }
    }

    if(maps\_audio::aud_is_zone_filter_enabled()) {
      if(isDefined(var_2.occlusion1)) {
        if(var_2.occlusion1 == "none") {
          maps\_audio::aud_deactivate_occlusion();
        } else {
          maps\_audio::aud_set_occlusion(var_2.occlusion1);
        }
      }
    }
  } else if(var_1 >= 0.75) {
    if(isDefined(var_2.reverb2)) {
      if(var_2.reverb2 == "none") {
        maps\_audio_reverb::rvb_start_preset(undefined);
      } else {
        maps\_audio_reverb::rvb_start_preset(var_2.reverb2);
      }
    }

    if(isDefined(var_2.mix2)) {
      if(var_2.mix2 == "none") {
        maps\_audio_mix_manager::mm_clear_zone_mix(2.0);
      } else {
        maps\_audio_mix_manager::mm_start_zone_preset(var_2.mix2);
      }
    }

    if(maps\_audio::aud_is_zone_filter_enabled()) {
      if(isDefined(var_2.occlusion2)) {
        if(var_2.occlusion2 == "none") {
          maps\_audio::aud_deactivate_occlusion();
        } else {
          maps\_audio::aud_set_occlusion(var_2.occlusion2);
        }
      }
    }
  }
}