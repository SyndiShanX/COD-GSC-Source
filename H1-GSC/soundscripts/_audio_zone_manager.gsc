/************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: soundscripts\_audio_zone_manager.gsc
************************************************/

azm_init() {
  if(!isdefined(level._audio.zone_mgr)) {
    level._audio.zone_mgr = spawnstruct();
    level._audio.zone_mgr.current_zone = "";
    level._audio.zone_mgr.zones = [];
    level._audio.zone_mgr.overrides = spawnstruct();
    level._audio.zone_mgr.overrides.samb = [];
    level._audio.zone_mgr.overrides.damb = [];
    level._audio.zone_mgr.overrides.mix = [];
    level._audio.zone_mgr.overrides.rev = [];
    level._audio.zone_mgr.overrides.occ = [];
    azm_set_quad_enable(1);
    azm_set_damb_enable(1);
    azm_set_mix_enable(1);
    azm_set_reverb_enable(1);
    azm_set_filter_enable(1);
    azm_set_occlusion_enable(1);
    azm_set_mix_bypass(0);
    azm_set_reverb_bypass(0);
    azm_set_filter_bypass(0);
    azm_set_occlusion_bypass(0);
    level._audio.zone_mgr.use_string_table_presets = 0;
  }

  if(!isdefined(level._audio.use_level_audio_zones))
    level._audio.level_audio_zones_function = undefined;
}

azm_use_string_table() {
  level._audio.zone_mgr.use_string_table_presets = 1;
}

azm_start_zone(var_0, var_1, var_2) {
  if(level._audio.zone_mgr.current_zone == var_0)
    return;
  else if(level._audio.zone_mgr.current_zone != "")
    azm_stop_zone(level._audio.zone_mgr.current_zone, var_1);

  level._audio.zone_mgr.current_zone = var_0;

  if(isdefined(level._audio.zone_mgr.zones[var_0]) && isdefined(level._audio.zone_mgr.zones[var_0]["state"]) && level._audio.zone_mgr.zones[var_0]["state"] != "stopping") {
    soundscripts\_audio::aud_print_warning("ZONEM_start_zone(\"" + var_0 + "\") being called even though audio zone, \"" + var_0 + "\", is already started.");
    return;
  }

  var_3 = 2.0;

  if(isdefined(var_1))
    var_3 = var_1;

  if(!isdefined(level._audio.zone_mgr.zones[var_0])) {
    var_4 = azmx_load_zone(var_0);

    if(!isdefined(var_4)) {
      return;
    }
    level._audio.zone_mgr.zones[var_0] = var_4;
  }

  var_4 = level._audio.zone_mgr.zones[var_0];
  soundscripts\_audio::aud_print_zone("ZONE START: " + var_0);
  level._audio.zone_mgr.zones[var_0]["state"] = "playing";
  var_5 = var_4["priority"];
  var_6 = var_4["interrupt_fade"];

  if(isdefined(var_4["streamed_ambience"])) {
    if(var_4["streamed_ambience"] != "none")
      soundscripts\_audio_stream_manager::sm_start_preset(var_4["streamed_ambience"], var_3, var_5, var_6);
    else
      soundscripts\_audio_stream_manager::sm_stop_ambience(var_3);
  }

  if(isdefined(var_4["dynamic_ambience"])) {
    if(var_4["dynamic_ambience"] != "none")
      soundscripts\_audio_dynamic_ambi::damb_zone_start_preset(var_4["dynamic_ambience"], 1.0);
    else
      soundscripts\_audio_dynamic_ambi::damb_stop_zone(1.0);
  }

  if(isdefined(var_4["occlusion"]) && !azm_get_occlusion_bypass()) {
    if(var_4["occlusion"] != "none")
      soundscripts\_snd_filters::snd_set_occlusion(var_4["occlusion"]);
    else
      soundscripts\_snd_filters::snd_set_occlusion(undefined);
  }

  if(isdefined(var_4["filter"]) && !azm_get_filter_bypass()) {
    soundscripts\_snd_filters::snd_set_filter(var_4["filter"], 0);
    soundscripts\_snd_filters::snd_set_filter_lerp(1);
  }

  if(isdefined(var_4["reverb"]) && !azm_get_reverb_bypass()) {
    if(var_4["reverb"] != "none")
      soundscripts\_audio_reverb::rvb_start_preset(var_4["reverb"]);
    else
      soundscripts\_audio_reverb::rvb_deactive_reverb();
  }

  if(isdefined(var_4["mix"]) && !azm_get_mix_bypass()) {
    if(var_4["mix"] != "none")
      soundscripts\_audio_mix_manager::mm_start_zone_preset(var_4["mix"]);
    else
      soundscripts\_audio_mix_manager::mm_clear_zone_mix(undefined, 1.0);
  }

  if(isdefined(var_4["context"]))
    soundscripts\_snd_common::snd_enable_soundcontextoverride(var_4["context"]);
}

azm_set_zone_streamed_ambience(var_0, var_1, var_2) {
  var_3 = azmx_set_param_internal(var_0, "streamed_ambience", var_1, ::azmx_restart_stream, var_2);

  if(!var_3) {
    if(!isdefined(var_1))
      var_1 = "none";

    level._audio.zone_mgr.overrides.samb[var_0] = var_1;
  }
}

azm_set_zone_dynamic_ambience(var_0, var_1, var_2) {
  if(!isdefined(var_1))
    var_1 = "none";

  azmx_set_param_internal(var_0, "dynamic_ambience", var_1, ::azmx_restart_damb, var_2);
  level._audio.zone_mgr.overrides.damb[var_0] = var_1;
}

azm_set_zone_reverb(var_0, var_1, var_2) {
  if(!isdefined(var_1))
    var_1 = "none";

  azmx_set_param_internal(var_0, "reverb", var_1, ::azmx_restart_reverb, var_2);
  level._audio.zone_mgr.overrides.rev[var_0] = var_1;
}

azm_set_zone_occlusion(var_0, var_1, var_2) {
  if(!isdefined(var_1))
    var_1 = "none";

  azmx_set_param_internal(var_0, "occlusion", var_1, ::azmx_restart_occlusion, var_2);
  level._audio.zone_mgr.overrides.mix[var_1] = var_1;
}

azm_set_zone_mix(var_0, var_1, var_2) {
  if(!isdefined(var_1))
    var_1 = "none";

  azmx_set_param_internal(var_0, "mix", var_1, ::azmx_restart_mix, var_2);
  level._audio.zone_mgr.overrides.mix[var_1] = var_1;
}

azm_stop_zones(var_0) {
  var_1 = 1.0;

  if(isdefined(var_0))
    var_1 = var_0;

  soundscripts\_audio::aud_print_zone("ZONE STOP ALL");

  foreach(var_3 in level._audio.zone_mgr.zones)
  azm_stop_zone(var_3["name"], var_1, 0);
}

azm_stop_zone(var_0, var_1, var_2) {
  if(isdefined(level._audio.zone_mgr.zones[var_0]) && isdefined(level._audio.zone_mgr.zones[var_0]["state"]) && level._audio.zone_mgr.zones[var_0]["state"] != "stopping") {
    var_3 = 1.0;

    if(isdefined(var_1))
      var_3 = var_1;

    var_4 = level._audio.zone_mgr.zones[var_0];
    var_5 = 0;

    if(isdefined(var_2))
      var_5 = var_2;

    if(var_5)
      soundscripts\_audio::aud_print_zone("ZONE STOP ZONE: " + var_0);

    if(isdefined(var_4["streamed_ambience"]))
      soundscripts\_audio_stream_manager::sm_stop_ambient_alias(var_4["streamed_ambience"], var_3);

    if(isdefined(var_4["dynamic_ambience"]))
      soundscripts\_audio_dynamic_ambi::damb_zone_stop_preset(var_4["dynamic_ambience"], var_3);

    if(isdefined(var_4["mix"]) && !azm_get_mix_bypass())
      soundscripts\_audio_mix_manager::mm_clear_zone_mix(var_4["mix"], var_3);

    if(isdefined(var_4["context"]))
      soundscripts\_snd_common::snd_disable_soundcontextoverride(var_4["context"]);

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

azm_set_quad_enable(var_0) {
  level._audio.zone_mgr.overrides.quad_enable = var_0;
}

azm_get_quad_enable() {
  return level._audio.zone_mgr.overrides.quad_enable;
}

azm_set_damb_enable(var_0) {
  level._audio.zone_mgr.overrides.damb_enable = var_0;
}

azm_get_damb_enable() {
  return level._audio.zone_mgr.overrides.damb_enable;
}

azm_set_mix_enable(var_0) {
  level._audio.zone_mgr.overrides.mix_enable = var_0;
}

azm_get_mix_enable() {
  return level._audio.zone_mgr.overrides.mix_enable;
}

azm_set_reverb_enable(var_0) {
  level._audio.zone_mgr.overrides.reverb_enable = var_0;
}

azm_get_reverb_enable() {
  return level._audio.zone_mgr.overrides.reverb_enable;
}

azm_set_filter_enable(var_0) {
  level._audio.zone_mgr.overrides.filter_enable = var_0;
}

azm_get_filter_enable() {
  return level._audio.zone_mgr.overrides.filter_enable;
}

azm_set_occlusion_enable(var_0) {
  level._audio.zone_mgr.overrides.occlusion_enable = var_0;
}

azm_get_occlusion_enable() {
  return level._audio.zone_mgr.overrides.occlusion_enable;
}

azm_set_mix_bypass(var_0) {
  level._audio.zone_mgr.overrides.mix_bypass = var_0;
}

azm_get_mix_bypass() {
  return level._audio.zone_mgr.overrides.mix_bypass;
}

azm_set_reverb_bypass(var_0) {
  level._audio.zone_mgr.overrides.reverb_bypass = var_0;
}

azm_get_reverb_bypass() {
  return level._audio.zone_mgr.overrides.reverb_bypass;
}

azm_set_filter_bypass(var_0) {
  level._audio.zone_mgr.overrides.filter_bypass = var_0;
}

azm_get_filter_bypass() {
  return isdefined(level.mute_device_active) && level.mute_device_active || level._audio.zone_mgr.overrides.filter_bypass;
}

azm_set_occlusion_bypass(var_0) {
  level._audio.zone_mgr.overrides.occlusion_bypass = var_0;
}

azm_get_occlusion_bypass() {
  return level._audio.zone_mgr.overrides.occlusion_bypass;
}

azmx_load_zone(var_0) {
  if(isdefined(level._audio.zone_mgr.zones[var_0])) {
    return;
  }
  if(!isdefined(level._audio.zone_mgr.preset_cache))
    level._audio.zone_mgr.preset_cache = [];

  var_1 = [];

  if(isdefined(level._audio.zone_mgr.preset_cache[var_0]))
    var_1 = level._audio.zone_mgr.preset_cache[var_0];
  else
    var_1 = azmx_get_preset_from_string_table(var_0, 1);

  if(!isdefined(var_1) || var_1.size == 0) {
    return;
  }
  level._audio.zone_mgr.preset_cache[var_0] = var_1;
  var_2 = 0;

  if(azm_get_quad_enable() && isdefined(level._audio.zone_mgr.overrides.samb[var_0])) {
    if(level._audio.zone_mgr.overrides.samb[var_0] == "none")
      var_1["streamed_ambience"] = undefined;
    else
      var_1["streamed_ambience"] = level._audio.zone_mgr.overrides.samb[var_0];

    var_2 = 1;
    level._audio.zone_mgr.overrides.samb[var_0] = undefined;
  }

  if(azm_get_damb_enable() && isdefined(level._audio.zone_mgr.overrides.damb[var_0])) {
    if(level._audio.zone_mgr.overrides.damb[var_0] == "none")
      var_1["dynamic_ambience"] = undefined;
    else
      var_1["dynamic_ambience"] = level._audio.zone_mgr.overrides.damb[var_0];

    var_2 = 1;
    level._audio.zone_mgr.overrides.damb[var_0] = undefined;
  }

  if(azm_get_reverb_enable() && isdefined(level._audio.zone_mgr.overrides.rev[var_0])) {
    if(level._audio.zone_mgr.overrides.rev[var_0] == "none")
      var_1["reverb"] = undefined;
    else
      var_1["reverb"] = level._audio.zone_mgr.overrides.rev[var_0];

    var_2 = 1;
    level._audio.zone_mgr.overrides.rev[var_0] = undefined;
  }

  if(azm_get_occlusion_enable() && isdefined(level._audio.zone_mgr.overrides.occ[var_0])) {
    if(level._audio.zone_mgr.overrides.occ[var_0] == "none")
      var_1["occlusion"] = undefined;
    else
      var_1["occlusion"] = level._audio.zone_mgr.overrides.occ[var_0];

    var_2 = 1;
    level._audio.zone_mgr.overrides.occ[var_0] = undefined;
  }

  if(azm_get_filter_enable() && isdefined(level._audio.zone_mgr.overrides.mix[var_0])) {
    if(level._audio.zone_mgr.overrides.mix[var_0] == "none")
      var_1["mix"] = undefined;
    else
      var_1["mix"] = level._audio.zone_mgr.overrides.mix[var_0];

    var_2 = 1;
    level._audio.zone_mgr.overrides.mix[var_0] = undefined;
  }

  if(var_2)
    level._audio.zone_mgr.preset_cache[var_0] = var_1;

  var_1["name"] = var_0;

  if(!isdefined(var_1["priority"]))
    var_1["priority"] = 1;

  if(!isdefined(var_1["interrupt_fade"]))
    var_1["interrupt_fade"] = 0.1;

  return var_1;
}

azmx_get_preset_from_string_table(var_0, var_1) {
  var_2 = "soundtables\sp_defaults.csv";
  var_3 = soundscripts\_audio::get_zone_stringtable();
  var_4 = [];

  if(var_1)
    var_4 = azmx_get_zone_preset_from_stringtable_internal(var_3, var_0);

  if(!isdefined(var_4) || var_4.size == 0)
    var_4 = azmx_get_zone_preset_from_stringtable_internal(var_2, var_0);

  if(!isdefined(var_4) || var_4.size == 0) {
    return;
  }
  return var_4;
}

azmx_get_zone_preset_from_stringtable_internal(var_0, var_1) {
  var_2 = [];
  var_3 = "";
  var_4 = "";
  var_5 = packedtablesectionlookup(var_0, "zone_names", "zone_names;reverb_names;filter_names;occlusion_names;timescale_names;dynamic_ambience_names;components;loop_defs;whizby_preset_names;mix_names;healthfx_params");

  if(isdefined(var_5)) {
    var_6 = 9;

    for (var_7 = 1; var_7 < var_6; var_7++) {
      if(var_3 != "comments" && var_4 != "")
        var_2[var_3] = var_4;

      var_3 = packedtablelookupwithrange(var_0, 0, "zone_names", var_7, var_5[0], var_5[1]);
      var_4 = packedtablelookupwithrange(var_0, 0, var_1, var_7, var_5[0], var_5[1]);

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
          case "context":
            var_2["context"] = var_4;
            break;
          default:
            break;
        }
      }
    }

    return var_2;
  }
}

azmx_restart_stream(var_0, var_1) {
  var_2 = level._audio.zone_mgr.zones[var_0]["streamed_ambience"];

  if(isdefined(var_2))
    soundscripts\_audio_stream_manager::sm_start_preset(var_2, var_1);
  else
    soundscripts\_audio_stream_manager::sm_stop_ambience(var_1);
}

azmx_restart_damb(var_0, var_1) {
  var_2 = 1.0;

  if(isdefined(var_1))
    var_2 = var_1;

  var_3 = level._audio.zone_mgr.zones[var_0]["dynamic_ambience"];

  if(isdefined(var_3))
    soundscripts\_audio_dynamic_ambi::damb_zone_start_preset(var_3, var_2);
  else
    soundscripts\_audio_dynamic_ambi::damb_zone_stop_preset(undefined, var_2);
}

azmx_restart_reverb(var_0, var_1) {
  var_2 = level._audio.zone_mgr.zones[var_0]["reverb"];

  if(isdefined(var_2) && !azm_get_reverb_bypass())
    soundscripts\_audio_reverb::rvb_start_preset(var_2);
}

azmx_restart_occlusion(var_0, var_1) {
  var_2 = level._audio.zone_mgr.zones[var_0]["occlusion"];

  if(isdefined(var_2) && !azm_get_occlusion_bypass())
    soundscripts\_snd_filters::snd_set_occlusion(var_2);
}

azmx_restart_mix(var_0, var_1) {
  var_2 = level._audio.zone_mgr.zones[var_0]["mix"];

  if(!azm_get_mix_bypass()) {
    if(isdefined(var_2))
      soundscripts\_audio_mix_manager::mm_start_zone_preset(var_2);
    else
      soundscripts\_audio_mix_manager::mm_clear_zone_mix(undefined, var_1);
  }
}

azmx_set_param_internal(var_0, var_1, var_2, var_3, var_4) {
  if(isdefined(level._audio.zone_mgr.zones[var_0])) {
    if(isdefined(level._audio.zone_mgr.zones[var_0][var_1]) && level._audio.zone_mgr.zones[var_0][var_1] != var_2 || !isdefined(level._audio.zone_mgr.zones[var_0][var_1]) && (isdefined(var_2) && var_2 != "none")) {
      if(var_2 == "none")
        level._audio.zone_mgr.zones[var_0][var_1] = undefined;
      else
        level._audio.zone_mgr.zones[var_0][var_1] = var_2;

      if(var_0 == azm_get_current_zone())
        [[var_3]](var_0, var_4);
    }

    return 1;
  } else
    return 0;
}

azmx_wait_till_fade_done_and_remove_zone(var_0, var_1) {
  wait(var_1);
  wait 0.05;

  if(level._audio.zone_mgr.zones[var_0]["state"] == "stopping")
    return;
}

azmx_get_blend_args(var_0, var_1) {
  var_2 = spawnstruct();
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
  var_2.context1 = undefined;
  var_2.context2 = undefined;

  if(!isdefined(level._audio.zone_mgr.zones[var_0])) {
    var_3 = azmx_load_zone(var_0);

    if(!isdefined(var_3)) {
      soundscripts\_audio::aud_print_warning("Couldn't find zone: " + var_0);
      return;
    }

    level._audio.zone_mgr.zones[var_0] = var_3;
  }

  var_4 = level._audio.zone_mgr.zones[var_0];

  if(!isdefined(level._audio.zone_mgr.zones[var_1])) {
    var_3 = azmx_load_zone(var_1);

    if(!isdefined(var_3)) {
      soundscripts\_audio::aud_print_warning("Couldn't find zone: " + var_1);
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
  var_2.context1 = var_4["context"];
  var_2.context2 = var_5["context"];
  var_2.samb1_name = var_4["streamed_ambience"];
  var_2.samb2_name = var_5["streamed_ambience"];
  var_6 = level._audio.damb.playing["zone"].size;

  if(var_6 > 1)
    soundscripts\_audio_dynamic_ambi::damb_stop(1.0, "zone");

  var_2.damb1_name = var_4["dynamic_ambience"];
  var_2.damb2_name = var_5["dynamic_ambience"];
  return var_2;
}

azmx_is_valid_mix_blend_request(var_0, var_1) {
  var_2 = 0;

  if(isdefined(var_0) && isdefined(var_1) && var_0 != var_1)
    var_2 = 1;
  else if(isdefined(var_1) && !isdefined(var_0))
    var_2 = 1;
  else if(isdefined(var_0) && !isdefined(var_1))
    var_2 = 1;

  return var_2;
}

azmx_is_valid_damb_blend_request(var_0, var_1) {
  var_2 = 0;

  if(isdefined(var_0) && isdefined(var_1) && var_0 != var_1)
    var_2 = 1;
  else if(isdefined(var_1) && !isdefined(var_0))
    var_2 = 1;
  else if(isdefined(var_0) && !isdefined(var_1))
    var_2 = 1;

  return var_2;
}

azmx_is_valid_samb_blend_request(var_0, var_1) {
  var_2 = 0;

  if(isdefined(var_0) && isdefined(var_1) && var_0 != var_1)
    var_2 = 1;
  else if(isdefined(var_1) && !isdefined(var_0))
    var_2 = 1;
  else if(isdefined(var_0) && !isdefined(var_1))
    var_2 = 1;

  return var_2;
}

azmx_blend_zones(var_0, var_1, var_2) {
  if(azmx_is_valid_samb_blend_request(var_2.samb1_name, var_2.samb2_name)) {
    var_3 = [];
    var_4 = 0;

    if(isdefined(var_2.samb1_name) && var_2.samb1_name != "") {
      var_5 = level._audio.zone_mgr.zones[var_2.zone_from_name];
      var_3[var_4] = spawnstruct();
      var_3[var_4].alias = var_2.samb1_name;
      var_3[var_4].vol = var_0;
      var_3[var_4].fade = var_5["interrupt_fade"];
      var_3[var_4].priority = var_5["priority"];
      var_4++;
    }

    if(isdefined(var_2.samb2_name) && var_2.samb2_name != "") {
      var_6 = level._audio.zone_mgr.zones[var_2.zone_to_name];
      var_3[var_4] = spawnstruct();
      var_3[var_4].alias = var_2.samb2_name;
      var_3[var_4].vol = var_1;
      var_3[var_4].fade = var_6["interrupt_fade"];
      var_3[var_4].priority = var_6["priority"];
    }

    if(var_3.size > 0)
      soundscripts\_audio_stream_manager::sm_mix_ambience(var_3);
  }

  if(azmx_is_valid_damb_blend_request(var_2.damb1_name, var_2.damb2_name))
    soundscripts\_audio_dynamic_ambi::damb_prob_mix_damb_presets(var_2.damb1_name, var_0, var_2.damb2_name, var_1);

  if(azmx_is_valid_mix_blend_request(var_2.mix1, var_2.mix2) && !azm_get_mix_bypass())
    soundscripts\_audio_mix_manager::mm_blend_zone_mix(var_2.mix1, var_0, var_2.mix2, var_1);

  if(isdefined(var_2.filter1)) {
    if(!azm_get_filter_bypass())
      soundscripts\_snd_filters::snd_set_filter(var_2.filter1, 0, 0);
  } else if(!azm_get_filter_bypass())
    soundscripts\_snd_filters::snd_set_filter(undefined, 0, 0);

  if(isdefined(var_2.filter2)) {
    if(!azm_get_filter_bypass())
      soundscripts\_snd_filters::snd_set_filter(var_2.filter2, 1, 0);
  } else if(!azm_get_filter_bypass())
    soundscripts\_snd_filters::snd_set_filter(undefined, 1, 0);

  if(isdefined(var_2.filter1) || isdefined(var_2.filter2)) {
    if(!azm_get_filter_bypass())
      soundscripts\_snd_filters::snd_set_filter_lerp(var_0);
  }

  if(var_0 >= 0.75) {
    if(isdefined(var_2.reverb1) && !azm_get_reverb_bypass()) {
      if(var_2.reverb1 == "none")
        soundscripts\_audio_reverb::rvb_start_preset(undefined);
      else
        soundscripts\_audio_reverb::rvb_start_preset(var_2.reverb1);
    }

    if(isdefined(var_2.occlusion1) && !azm_get_occlusion_bypass()) {
      if(var_2.occlusion1 == "none")
        soundscripts\_snd_filters::snd_set_occlusion(undefined);
      else
        soundscripts\_snd_filters::snd_set_occlusion(var_2.occlusion1);
    }

    if(isdefined(var_2.context2))
      soundscripts\_snd_common::snd_disable_soundcontextoverride(var_2.context2);

    if(isdefined(var_2.context1))
      soundscripts\_snd_common::snd_enable_soundcontextoverride(var_2.context1);
  } else if(var_1 >= 0.75) {
    if(isdefined(var_2.reverb2) && !azm_get_reverb_bypass()) {
      if(var_2.reverb2 == "none")
        soundscripts\_audio_reverb::rvb_start_preset(undefined);
      else
        soundscripts\_audio_reverb::rvb_start_preset(var_2.reverb2);
    }

    if(isdefined(var_2.occlusion2) && !azm_get_occlusion_bypass()) {
      if(var_2.occlusion2 == "none")
        soundscripts\_snd_filters::snd_set_occlusion(undefined);
      else
        soundscripts\_snd_filters::snd_set_occlusion(var_2.occlusion2);
    }

    if(isdefined(var_2.context1))
      soundscripts\_snd_common::snd_disable_soundcontextoverride(var_2.context1);

    if(isdefined(var_2.context2))
      soundscripts\_snd_common::snd_enable_soundcontextoverride(var_2.context2);
  }
}