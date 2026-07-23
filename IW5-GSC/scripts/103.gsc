/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\103.gsc
**************************************/

aud_init() {
  if(!isDefined(level.aud)) {
    if(!isDefined(level.script)) {
      level.script = tolower(getDvar("mapname"));
    }
    level.aud = spawnStruct();

    if(!isDefined(level._audio)) {
      level._audio = spawnStruct();
    }
    level._audio.using_string_tables = 0;
    level._audio.stringtables = [];
    var_0 = spawnStruct();
    level._audio.index = spawnStruct();
    level._audio.index.local = get_index_struct();
    level._audio.index.common = get_index_struct();
    index_common_presets();
    level._audio.message_handlers = [];
    level._audio.progress_trigger_callbacks = [];
    level._audio.progress_maps = [];
    level._audio.filter_disabled = 0;
    level._audio.current_filter = "";
    level._audio.current_filter_indices = ["", ""];
    level._audio.zone_occlusion_and_filtering_disabled = 0;
    level._audio.vo_duck_active = 0;
    level._audio.sticky_threat = undefined;
    level._audio.player_state = spawnStruct();
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
    maps\_audio_stream_manager::sm_init();
    maps\_audio_dynamic_ambi::damb_init();
    maps\_audio_zone_manager::azm_init();
    thread maps\_audio_mix_manager::mm_init();
    maps\_audio_reverb::rvb_init();
    maps\_audio_music::mus_init();
    maps\_audio_whizby::whiz_init();
    maps\_audio_vehicles::vm_init();
    thread aud_level_fadein();
    thread aud_wait_for_mission_fail_music();
    aud_register_msg_handler(::_audio_msg_handler);
  }
}

audio_presets_dynamic_ambience(var_0, var_1) {
  aud_print_error("CALLING DYNAMIC_AMBIENCE PRESET USING OLD METHOD!");
}

audio_presets_dynamic_ambience_components(var_0, var_1) {
  aud_print_error("CALLING DYNAMIC_AMBIENCE_COMPONENTS PRESET USING OLD METHOD!");
}

audio_presets_dynamic_ambience_loop_definitions(var_0, var_1) {
  aud_print_error("CALLING DYNAMIC_AMBIENCE_LOOP_DEFINITIONS PRESET USING OLD METHOD!");
}

audio_presets_mix(var_0, var_1) {
  aud_print_error("CALLING MIX PRESET USING OLD METHOD!");
}

audio_presets_occlusion(var_0, var_1) {
  aud_print_error("CALLING OCCLUSION PRESET USING OLD METHOD!");
}

audio_presets_reverb(var_0, var_1) {
  aud_print_error("CALLING REVERB PRESET USING OLD METHOD!");
}

audio_presets_whizby(var_0, var_1) {
  aud_print_error("CALLING WHIZBY PRESET USING OLD METHOD!");
}

audio_presets_zones(var_0, var_1) {
  aud_print_error("CALLING ZONE PRESET USING OLD METHOD!");
}

aud_prime_stream(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }
  self endon("release" + var_0);

  for(;;) {
    self prefetchsound(var_0, "primed" + var_0);
    self waittill("primed" + var_0);

    if(!isDefined(self.primed_streams)) {
      self.primed_streams = [];
    }
    self.primed_streams[var_0] = 1;

    if(!var_3) {
      return;
    } else if(isDefined(var_2)) {
      wait(var_2);
    }
  }
}

aud_is_stream_primed(var_0) {
  if(isDefined(self.primed_streams) && isDefined(self.primed_streams[var_0]) && self.primed_streams[var_0]) {
    return 1;
  } else {
    return 0;
  }
}

aud_error_if_not_primed(var_0) {}

aud_release_stream(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }
  self notify("release" + var_0);

  if(var_2 && isDefined(self)) {
    self stopsounds();
  }
}

aud_wait_till_primed(var_0) {
  if(isDefined(self.primed_streams) && isDefined(self.primed_streams[var_0]) && self.primed_streams[var_0]) {
    return;
  }
  self waittill("primed" + var_0);
  self notify("release" + var_0);
}

aud_prime_and_play_internal(var_0, var_1, var_2) {
  aud_prime_stream(var_0);

  if(isDefined(var_2) && var_2) {
    aud_slomo_wait(var_1);
  } else {
    wait(var_1);
  }
  self playSound(var_0, "sounddone");
  self waittill("sounddone");
  wait 0.05;
  self delete();
}

aud_prime_and_play(var_0, var_1, var_2, var_3) {
  var_4 = level.player.origin;

  if(isDefined(var_2)) {
    var_4 = var_2;
  }
  var_5 = spawn("script_origin", var_4);
  var_5 thread aud_prime_and_play_internal(var_0, var_1, var_3);
  return var_5;
}

aud_add_progress_map(var_0, var_1) {
  level._audio.progress_maps[var_0] = var_1;
}

aud_get_progress_map(var_0) {
  if(isDefined(level._audio.progress_maps[var_0])) {
    return level._audio.progress_maps[var_0];
  }
}

is_deathsdoor_audio_enabled() {
  if(!isDefined(level._audio.deathsdoor_enabled)) {
    return 1;
  } else {
    return level._audio.deathsdoor_enabled;
  }
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
  if(is_deathsdoor_audio_enabled() || isDefined(level._audio.in_deathsdoor)) {
    level._audio.in_deathsdoor = undefined;
    thread aud_set_occlusion(level._audio.deathsdoor.occlusion);
    thread aud_set_filter(level._audio.deathsdoor.filter);
    thread maps\_audio_reverb::rvb_start_preset(level._audio.deathsdoor.reverb);
  }
}

set_deathsdoor() {
  level._audio.in_deathsdoor = 1;

  if(!isDefined(level._audio.deathsdoor)) {
    level._audio.deathsdoor = spawnStruct();
  }
  level._audio.deathsdoor.filter = undefined;
  level._audio.deathsdoor.occlusion = undefined;
  level._audio.deathsdoor.reverb = undefined;
  level._audio.deathsdoor.filter = level._audio.current_filter;
  level._audio.deathsdoor.occlusion = level._audio.current_occlusion;
  level._audio.deathsdoor.reverb = level._audio.current_reverb;

  if(is_deathsdoor_audio_enabled()) {
    thread aud_set_filter("deathsdoor");
    thread maps\_audio_reverb::rvb_start_preset("deathsdoor");
  }
}

aud_set_mission_failed_music(var_0) {
  level._audio.failed_music_alias = var_0;
}

aud_wait_for_mission_fail_music() {
  wait 0.05;

  while(!common_scripts\utility::flag_exist("missionfailed")) {
    wait 0.05;
  }
  var_0 = "shg_mission_failed_stinger";
  common_scripts\utility::flag_wait("missionfailed");

  if(isDefined(level._audio.failed_music_alias)) {
    var_0 = level._audio.failed_music_alias;
  }
  if(soundexists(var_0)) {
    maps\_audio_music::mus_play(var_0, 2, 4);
  }
}

aud_set_filter_internal(var_0, var_1, var_2, var_3) {
  var_4 = 7;
  var_5 = "";
  var_6 = 0;
  var_7 = [];
  var_8 = [];
  var_9 = 0;
  var_10 = 0;
  var_2 = get_indexed_preset("filter", var_0, var_3);

  if(var_2 != -1) {
    var_6 = var_2;
  } else if(var_3 && aud_is_common_indexed() || !var_3 && aud_is_local_indexed()) {
    return 0;
  }
  while(var_5 != "EOF" && var_10 < 10) {
    var_5 = tablelookupbyrow(var_1, var_6, 0);

    if(var_5 != "") {
      var_10 = 0;
    }
    while(var_5 == var_0) {
      var_9 = 1;
      var_7 = undefined;

      for(var_11 = 1; var_11 < var_4; var_11++) {
        if(!isDefined(var_8[var_11])) {
          var_8[var_11] = tablelookupbyrow(var_1, 0, var_11);
        }
        var_12 = var_8[var_11];
        var_13 = tablelookupbyrow(var_1, var_6, var_11);

        if(var_13 != "") {
          switch (var_12) {
            case "channel_name":
              var_7 = spawnStruct();
              var_7.channel = var_13;
              break;
            case "band":
              var_7.band = int(var_13);
              break;
            case "type":
              var_7.type = var_13;
              break;
            case "freq":
              var_7.freq = float(var_13);
              break;
            case "gain":
              var_7.gain = float(var_13);
              break;
            case "q":
              var_7.q = float(var_13);
              break;
            default:
              break;
          }
        }
      }

      if(!isDefined(level._audio.filter_presets[var_0])) {
        level._audio.filter_presets[var_0] = [];
      }
      level._audio.filter_presets[var_0][level._audio.filter_presets[var_0].size] = var_7;
      var_6++;
      var_5 = tablelookupbyrow(var_1, var_6, 0);
    }

    var_10++;

    if(var_9) {
      return 1;
    }
    var_6++;
  }

  return 0;
}

aud_set_filter_threaded(var_0, var_1, var_2) {
  if(!isDefined(level._audio.filter_presets)) {
    level._audio.filter_presets = [];
  }
  var_3 = 0;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }
  if(!isDefined(level._audio.filter_presets[var_0])) {
    level._audio.filter_presets[var_0] = [];
    var_4 = "soundtables/common_filter.csv";
    var_5 = get_filter_stringtable();
    var_6 = 1;
    var_6 = aud_set_filter_internal(var_0, var_5, var_3, 0);

    if(!var_6) {
      var_6 = aud_set_filter_internal(var_0, var_4, var_3, 1);
    }
    if(!var_6) {
      return;
    }
  }

  level._audio.current_filter = var_0;

  if(level._audio.current_filter_indices[var_3] != var_0) {
    level._audio.current_filter_indices[var_3] = var_0;
    var_7 = 10;

    if(isDefined(var_2)) {
      var_7 = var_2;
    }
    var_8 = 0;

    foreach(var_10 in level._audio.filter_presets[var_0]) {
      level.player seteq(var_10.channel, var_3, var_10.band, var_10.type, var_10.gain, var_10.freq, var_10.q);

      if(var_8 < var_7) {
        var_8++;
        continue;
      }

      var_8 = 0;
      wait 0.05;
    }
  }
}

aud_clear_filter(var_0) {
  var_1 = 0;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }
  level._audio.current_filter_indices[var_1] = "";
  aud_set_filter(undefined, var_1);
}

aud_disable_zone_filter() {
  level._audio.filter_zone_disabled = 1;
}

aud_enable_zone_filter() {
  level._audio.filter_zone_disabled = undefined;
}

aud_is_zone_filter_enabled() {
  return !isDefined(level._audio.filter_zone_disabled);
}

aud_set_filter(var_0, var_1, var_2, var_3) {
  if(level._audio.filter_disabled) {
    return;
  }
  if(isDefined(level.player.ent_flag) && isDefined(level.player.ent_flag["player_has_red_flashing_overlay"]) && level.player maps\_utility::ent_flag("player_has_red_flashing_overlay")) {
    return;
  }
  var_4 = 0;

  if(isDefined(var_1)) {
    var_4 = var_1;
  }
  if(!isDefined(var_0) || isDefined(var_0) && var_0 == "") {
    level._audio.current_filter = undefined;
    level.player deactivateeq(var_4);
    return;
  }

  thread aud_set_filter_threaded(var_0, var_1, var_2);
}

aud_disable_filter_setting(var_0) {
  level._audio.filter_disabled = 1;
}

aud_enable_filter_setting(var_0) {
  level._audio.filter_disabled = 0;
}

aud_set_timescale_internal(var_0) {
  var_1 = "soundtables/common_timescale.csv";
  var_2 = 2;
  var_3 = "";
  var_4 = 0;
  var_5 = [];
  var_6 = [];
  var_7 = 0;
  var_8 = 0;
  var_9 = get_indexed_preset("timescale", var_0, 1);

  if(var_9 != -1) {
    var_4 = var_9;
  } else if(aud_is_common_indexed()) {
    return 0;
  }
  while(var_3 != "EOF" && var_8 < 10) {
    var_3 = tablelookupbyrow(var_1, var_4, 0);

    if(var_3 != "") {
      var_8 = 0;
    }
    while(var_3 == var_0) {
      var_7 = 1;
      var_5 = undefined;

      for(var_10 = 1; var_10 < var_2 + 1; var_10++) {
        if(!isDefined(var_6[var_10])) {
          var_6[var_10] = tablelookupbyrow(var_1, 0, var_10);
        }
        var_11 = var_6[var_10];
        var_12 = tablelookupbyrow(var_1, var_4, var_10);

        if(var_12 != "") {
          switch (var_11) {
            case "channel_name":
              var_5 = spawnStruct();
              var_5.channel = var_12;
              break;
            case "scalefactor":
              var_5.scalefactor = float(var_12);
              break;
            default:
              aud_print_error("In timescale preset table, common_timescale.csv, there is an improperly labeled parameter column, \"" + var_11 + "\".");
              break;
          }
        }
      }

      if(isDefined(var_5)) {
        level._audio.timescale_presets[var_0][level._audio.timescale_presets[var_0].size] = var_5;
      }
      var_4++;
      var_3 = tablelookupbyrow(var_1, var_4, 0);
    }

    var_8++;

    if(var_7) {
      return 1;
    }
    var_4++;
  }

  return 0;
}

aud_set_timescale_threaded(var_0, var_1) {
  var_2 = "default";

  if(isDefined(var_0)) {
    var_2 = var_0;
  }
  if(!isDefined(level._audio.timescale_presets)) {
    level._audio.timescale_presets = [];
  }
  var_3 = 1;

  if(!isDefined(level._audio.timescale_presets[var_2])) {
    level._audio.timescale_presets[var_2] = [];
    var_3 = aud_set_timescale_internal(var_2);
  }

  if(!var_3) {
    return;
  }
  var_4 = 10;

  if(isDefined(var_1)) {
    var_4 = var_1;
  }
  var_5 = 0;

  foreach(var_7 in level._audio.timescale_presets[var_2]) {
    soundsettimescalefactor(var_7.channel, var_7.scalefactor);

    if(var_5 < var_4) {
      var_5++;
      continue;
    }

    var_5 = 0;
    wait 0.05;
  }
}

aud_set_timescale(var_0, var_1) {
  thread aud_set_timescale_threaded(var_0, var_1);
}

aud_set_occlusion_internal(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = "soundtables/common_occlusion.csv";
  var_2 = 5;
  var_3 = "";
  var_4 = 0;
  var_5 = [];
  var_6 = [];
  var_7 = 0;
  var_8 = 0;
  var_9 = get_indexed_preset("occlusion", var_0, 1);

  if(var_9 != -1) {
    var_4 = var_9;
  } else if(aud_is_common_indexed()) {
    return 0;
  }
  while(var_3 != "EOF" && var_8 < 10) {
    var_3 = tablelookupbyrow(var_1, var_4, 0);

    if(var_3 != "") {
      var_8 = 0;
    }
    while(var_3 == var_0) {
      var_7 = 1;
      var_5 = undefined;

      for(var_10 = 1; var_10 < var_2 + 1; var_10++) {
        if(!isDefined(var_6[var_10])) {
          var_6[var_10] = tablelookupbyrow(var_1, 0, var_10);
        }
        var_11 = var_6[var_10];
        var_12 = tablelookupbyrow(var_1, var_4, var_10);

        if(var_12 != "") {
          switch (var_11) {
            case "channel_name":
              var_5 = spawnStruct();
              var_5.channel = var_12;
              break;
            case "frequency":
              var_5.freq = float(var_12);
              break;
            case "type":
              var_5.type = var_12;
              break;
            case "gain":
              var_5.gain = float(var_12);
              break;
            case "q":
              var_5.q = float(var_12);
              break;
            default:
              aud_print_error("In occlusion preset table, common_occlusion.csv, there is an improperly labeled parameter column, \"" + var_11 + "\".");
              break;
          }
        }
      }

      if(!isDefined(var_5.freq)) {
        var_5.freq = 600;
      }
      if(!isDefined(var_5.type)) {
        var_5.type = "highshelf";
      }
      if(!isDefined(var_5.gain)) {
        var_5.gain = -12;
      }
      if(!isDefined(var_5.q)) {
        var_5.q = 1;
      }
      level._audio.occlusion_presets[var_0][level._audio.occlusion_presets[var_0].size] = var_5;
      var_4++;
      var_3 = tablelookupbyrow(var_1, var_4, 0);
    }

    var_8++;

    if(var_7) {
      return 1;
    }
    var_4++;
  }

  return 0;
}

aud_set_occlusion_threaded(var_0, var_1) {
  var_2 = "default";

  if(isDefined(var_0)) {
    var_2 = var_0;
  }
  if(!isDefined(level._audio.occlusion_presets)) {
    level._audio.occlusion_presets = [];
  }
  var_3 = 1;

  if(!isDefined(level._audio.occlusion_presets[var_2])) {
    level._audio.occlusion_presets[var_2] = [];
    var_3 = aud_set_occlusion_internal(var_2);
  }

  if(!var_3) {
    return;
  }
  level._audio.current_occlusion = var_2;

  if(!(isDefined(level._audio.zone_occlusion_and_filtering_disabled) && level._audio.zone_occlusion_and_filtering_disabled)) {
    var_4 = 10;

    if(isDefined(var_1)) {
      var_4 = var_4;
    }
    var_5 = 0;

    foreach(var_7 in level._audio.occlusion_presets[var_2]) {
      level.player setocclusion(var_7.channel, var_7.freq, var_7.type, var_7.gain, var_7.q);

      if(var_5 < var_4) {
        var_5++;
        continue;
      }

      var_5 = 0;
      wait 0.05;
    }
  }
}

aud_set_occlusion(var_0, var_1) {
  if(isDefined(level.player.ent_flag) && isDefined(level.player.ent_flag["player_has_red_flashing_overlay"]) && level.player maps\_utility::ent_flag("player_has_red_flashing_overlay")) {
    return;
  }
  if(!isDefined(var_0)) {
    level._audio.current_filter = undefined;
    return;
  }

  thread aud_set_occlusion_threaded(var_0, var_1);
}

aud_deactivate_occlusion(var_0) {
  var_1 = 10;

  if(isDefined(var_0)) {
    var_1 = var_1;
  }
  var_2 = 0;

  foreach(var_5, var_4 in level._audio.mix.channel_names) {
    level.player deactivateocclusion(var_5);

    if(var_2 < var_1) {
      var_2++;
      continue;
    }

    var_2 = 0;
    wait 0.05;
  }
}

aud_disable_zone_occlusion_and_filtering(var_0) {
  var_1 = 10;

  if(isDefined(var_0)) {
    var_1 = var_1;
  }
  aud_set_filter(undefined, 0, var_1);
  aud_set_filter(undefined, 1, var_1);
  aud_deactivate_occlusion(var_1);
  level._audio.zone_occlusion_and_filtering_disabled = 1;
}

aud_enable_zone_occlusion_and_filtering(var_0) {
  var_1 = undefined;
  var_2 = "default";
  var_3 = 10;

  if(isDefined(var_0)) {
    var_3 = var_3;
  }
  if(isDefined(level._audio.zone_mgr.current_zone) && isDefined(level._audio.zone_mgr.zones[level._audio.zone_mgr.current_zone])) {
    var_4 = maps\_audio_zone_manager::azm_get_current_zone();
    var_5 = level._audio.zone_mgr.zones[var_4];

    if(isDefined(var_5["occlusion"]) && var_5["occlusion"] != "none") {
      var_2 = var_5["occlusion"];
    }
    if(isDefined(var_5["filter"]) && var_5["filter"] != "none") {
      var_1 = var_5["filter"];
    }
  }

  if(level._audio.current_occlusion != var_2) {
    var_2 = level._audio.current_occlusion;
  }
  level._audio.zone_occlusion_and_filtering_disabled = 0;
  aud_set_filter(var_1, 0, var_3);
  aud_set_filter(undefined, 1, var_3);
  aud_set_occlusion(var_2, var_3);
}

aud_use_level_zones(var_0) {
  level._audio.level_audio_zones_function = var_0;
}

aud_use_level_reverb(var_0) {
  level._audio.level_audio_reverb_function = var_0;
}

aud_use_level_filters(var_0) {
  level._audio.level_audio_filter_function = var_0;
}

aud_use_string_tables(var_0) {
  var_1 = 1;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }
  level._audio.using_string_tables = 1;
  maps\_audio_zone_manager::azm_use_string_table();
  maps\_audio_reverb::rvb_use_string_table();
  maps\_audio_dynamic_ambi::damb_use_string_table();
  maps\_audio_mix_manager::mm_use_string_table();
  maps\_audio_whizby::whiz_use_string_table();

  if(var_1) {
    aud_index_presets();
  }
  maps\_audio_whizby::whiz_set_preset("default");
}

set_stringtable_mapname(var_0) {
  aud_use_string_tables(0);
  level._audio.stringtables["map"] = var_0;
  aud_index_presets();
}

get_stringtable_mapname() {
  if(isDefined(level._audio.stringtables["map"])) {
    return level._audio.stringtables["map"];
  } else {
    return common_scripts\utility::get_template_level();
  }
}

set_mix_stringtable(var_0) {
  level._audio.stringtables["mix"] = var_0;
}

get_mix_stringtable() {
  if(!isDefined(level._audio.stringtables["mix"])) {
    return "soundtables/" + get_stringtable_mapname() + "_mix.csv";
  } else {
    return "soundtables/" + level._audio.stringtables["mix"];
  }
}

set_damb_stringtable(var_0) {
  level._audio.stringtables["damb"] = var_0;
}

get_damb_stringtable() {
  if(!isDefined(level._audio.stringtables["damb"])) {
    return "soundtables/" + get_stringtable_mapname() + "_damb.csv";
  } else {
    return "soundtables/" + level._audio.stringtables["damb"];
  }
}

set_damb_component_stringtable(var_0) {
  level._audio.stringtables["damb_comp"] = var_0;
}

get_damb_component_stringtable(var_0) {
  if(!isDefined(level._audio.stringtables["damb_comp"])) {
    return "soundtables/" + get_stringtable_mapname() + "_damb_components.csv";
  } else {
    return "soundtables/" + level._audio.stringtables["damb_comp"];
  }
}

set_damb_loops_stringtable(var_0) {
  level._audio.stringtables["damb_loops"] = var_0;
}

get_damb_loops_stringtable(var_0) {
  if(!isDefined(level._audio.stringtables["damb_loops"])) {
    return "soundtables/" + get_stringtable_mapname() + "_damb_loops.csv";
  } else {
    return "soundtables/" + level._audio.stringtables["damb_loops"];
  }
}

set_reverb_stringtable(var_0) {
  level._audio.stringtables["reverb"] = var_0;
}

get_reverb_stringtable() {
  if(!isDefined(level._audio.stringtables["reverb"])) {
    return "soundtables/" + get_stringtable_mapname() + "_reverb.csv";
  } else {
    return "soundtables/" + level._audio.stringtables["reverb"];
  }
}

set_filter_stringtable(var_0) {
  level._audio.stringtables["filter"] = var_0;
}

get_filter_stringtable() {
  if(!isDefined(level._audio.stringtables["filter"])) {
    return "soundtables/" + get_stringtable_mapname() + "_filter.csv";
  } else {
    return "soundtables/" + level._audio.stringtables["filter"];
  }
}

set_zone_stringtable(var_0) {
  level._audio.stringtables["zone"] = var_0;
}

get_zone_stringtable() {
  if(!isDefined(level._audio.stringtables["zone"])) {
    return "soundtables/" + get_stringtable_mapname() + "_zone.csv";
  } else {
    return "soundtables/" + level._audio.stringtables["zone"];
  }
}

set_occlusion_stringtable(var_0) {
  level._audio.stringtables["occlusion"] = var_0;
}

get_occlusion_stringtable() {
  if(!isDefined(level._audio.stringtables["occlusion"])) {
    return "soundtables/" + get_stringtable_mapname() + "_occlusion.csv";
  } else {
    return "soundtables/" + level._audio.stringtables["occlusion"];
  }
}

aud_register_msg_handler(var_0) {
  level._audio.message_handlers[level._audio.message_handlers.size] = var_0;
}

aud_send_msg(var_0, var_1, var_2) {
  thread aud_dispatch_msg(var_0, var_1, var_2);
}

aud_dispatch_msg(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 0;

  foreach(var_6 in level._audio.message_handlers) {
    var_4 = self[[var_6]](var_0, var_1);

    if(!var_3 && isDefined(var_4) && var_4 == 1) {
      var_3 = var_4;
      continue;
    }

    if(!var_3 && !isDefined(var_4)) {
      var_3 = 1;
    }
  }

  if(isDefined(var_2)) {
    self notify(var_2);
  }
  if(!var_3) {
    aud_print_warning("\tAUDIO MESSAGE NOT HANDLED: " + var_0);
  }
}

aud_get_player_locamote_state() {
  return level._audio.player_state.locamote;
}

aud_get_threat_level(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = aud_get_sticky_threat();

  if(isDefined(var_4)) {
    var_3 = var_4;
  } else {
    var_5 = 3;
    var_6 = 10;
    var_7 = 100;

    if(isDefined(var_0)) {
      var_5 = var_0;
    }
    if(isDefined(var_2)) {
      var_7 = var_2;
    }
    if(isDefined(var_2)) {
      var_6 = var_1;
    }
    var_8 = 36 * var_7;
    var_9 = 36 * var_6;
    var_10 = getaiarray("bad_guys");
    var_11 = 0;
    var_12 = 0;

    foreach(var_14 in var_10) {
      if(isDefined(var_14.alertlevelint) && var_14.alertlevelint >= var_5) {
        var_15 = distance(level.player.origin, var_14.origin);

        if(var_15 < var_8) {
          var_11++;

          if(var_15 < var_9) {
            var_16 = 1.0;
          } else {
            var_16 = 1.0 - (var_15 - var_9) / (var_8 - var_9);
          }
          var_12 = var_12 + var_16;
        }
      }
    }

    if(var_11 > 0) {
      var_3 = var_12 / var_11;
    } else {
      var_3 = 0;
    }
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

  if(isDefined(var_0)) {
    var_2 = 36 * var_0;
  }
  var_3 = getaiarray("bad_guys");

  foreach(var_5 in var_3) {
    if(isalive(var_5)) {
      var_6 = distance(level.player.origin, var_5.origin);

      if(var_6 < var_2) {
        var_1++;
      }
    }
  }

  return var_1;
}

_audio_msg_handler(var_0, var_1) {
  var_2 = 1;

  switch (var_0) {
    case "level_fade_to_black":
      var_3 = var_1[0];
      var_4 = var_1[1];
      wait(var_3);
      maps\_audio_mix_manager::mm_start_preset("mute_all", var_4);
      break;
    case "generic_building_bomb_shake":
      level.player playSound("sewer_bombs");
      break;
    case "start_player_slide_trigger":
      break;
    case "end_player_slide_trigger":
      break;
    case "missile_fired":
      break;
    case "msg_audio_fx_ambientExp":
      break;
    case "aud_play_sound_at":
      aud_play_sound_at(var_1.alias, var_1.pos);
      break;
    case "aud_play_dynamic_explosion":
      if(isDefined(var_1.spread_width)) {
        var_5 = var_1.spread_width;
      } else {
        var_5 = undefined;
      }
      if(isDefined(var_1.rear_dist)) {
        var_6 = var_1.rear_dist;
      } else {
        var_6 = undefined;
      }
      if(isDefined(var_1.velocity)) {
        var_7 = var_1.velocity;
      } else {
        var_7 = undefined;
      }
      aud_play_dynamic_explosion(var_1.explosion_pos, var_1.left_alias, var_1.right_alias, var_5, var_6, var_7);
      break;
    case "aud_play_conversation":
      aud_play_conversation(var_0, var_1);
      break;
    case "xm25_contact_explode":
      if(soundexists("xm25_proj_explo")) {
        var_8 = var_1;
        thread common_scripts\utility::play_sound_in_space("xm25_proj_explo", var_8);
      }

      break;
    case "light_flicker_on":
      var_9 = var_1;
      aud_handle_flickering_light(var_9);
      break;
    default:
      var_2 = 0;
  }

  return var_2;
}

aud_handle_flickering_light(var_0) {
  var_1 = 0;

  switch (var_0.model) {
    case "furniture_lamp_table1":
    case "com_cafe_light_part1_off":
    case "furniture_lamp_floor1_off":
      var_1 = 1;

      if(soundexists("paris_lamplight_flicker")) {
        thread common_scripts\utility::play_sound_in_space("paris_lamplight_flicker", var_0.origin);
      }
      break;
    default:
      var_1 = 0;
  }

  return var_1;
}

aud_play_conversation(var_0, var_1) {
  var_2 = var_1;
  var_3 = [];

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_3[var_4] = var_2[var_4].ent.battlechatter;
    var_2[var_4].ent.battlechatter = 0;
  }

  foreach(var_6 in var_2) {
    if(isDefined(var_6.delay)) {
      wait(var_6.delay);
    }
    var_7 = spawn("script_origin", (0, 0, 0));
    var_7 linkTo(var_6.ent, "", (0, 0, 0), (0, 0, 0));
    var_7 playSound(var_6.sound, "sounddone");
    var_7 waittill("sounddone");
    wait 0.05;
    var_7 delete();
  }

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_2[var_4].ent.battlechatter = var_3[var_4];
  }
}

trigger_multiple_audio_register_callback(var_0) {
  if(!isDefined(level._audio.trigger_functions)) {
    level._audio.trigger_functions = [];
  }
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];
    var_3 = var_2[0];
    var_4 = var_2[1];
    level._audio.trigger_functions[var_3] = var_4;
  }

  if(isDefined(level._audio.trigger_function_keys)) {
    foreach(var_3 in level._audio.trigger_function_keys) {}

    level._audio.trigger_function_keys = undefined;
  }
}

get_target_ent_target() {
  var_0 = common_scripts\utility::get_target_ent();
  return var_0.target;
}

get_target_ent_origin() {
  var_0 = common_scripts\utility::get_target_ent();
  return var_0.origin;
}

get_target_ent_target_ent() {
  var_0 = common_scripts\utility::get_target_ent();
  return var_0 common_scripts\utility::get_target_ent();
}

get_target_ent_target_ent_origin() {
  var_0 = get_target_ent_target_ent();
  return var_0.origin;
}

get_zone_from(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return undefined;
  }
  if(var_1) {
    return var_0[1];
  } else {
    return var_0[0];
  }
}

get_zone_to(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return undefined;
  }
  if(var_1) {
    return var_0[0];
  } else {
    return var_0[1];
  }
}

trigger_multiple_audio_trigger(var_0) {
  if(!isDefined(level._audio)) {
    level._audio = spawnStruct();
  }
  if(!isDefined(level._audio.trigger_functions)) {
    level._audio.trigger_functions = [];
  }
  var_1 = undefined;

  if(isDefined(var_0) && var_0) {
    if(isDefined(self.ambient)) {
      var_1 = strtok(self.ambient, " ");
    }
  } else if(isDefined(self.script_audio_zones)) {
    var_1 = strtok(self.script_audio_zones, " ");
  } else if(isDefined(self.audio_zones)) {
    var_1 = strtok(self.audio_zones, " ");
  }
  if(isDefined(var_1) && var_1.size == 2) {} else if(isDefined(var_1) && var_1.size == 1) {
    for(;;) {
      self waittill("trigger", var_2);
      maps\_audio_zone_manager::azm_start_zone(var_1[0], self.script_duration);
    }
  }

  if(isDefined(self.script_audio_progress_map)) {
    if(!isDefined(level._audio.progress_maps[self.script_audio_progress_map])) {
      aud_print_error("Trying to set a progress_map_function without defining the envelope in the level.aud.envs array.");
      self.script_audio_progress_map = undefined;
    }
  }

  if(!isDefined(level._audio.trigger_function_keys)) {
    level._audio.trigger_function_keys = [];
  }
  if(isDefined(self.script_audio_enter_func)) {
    level._audio.trigger_function_keys[level._audio.trigger_function_keys.size] = self.script_audio_enter_func;
  }
  if(isDefined(self.script_audio_exit_func)) {
    level._audio.trigger_function_keys[level._audio.trigger_function_keys.size] = self.script_audio_exit_func;
  }
  if(isDefined(self.script_audio_progress_func)) {
    level._audio.trigger_function_keys[level._audio.trigger_function_keys.size] = self.script_audio_progress_func;
  }
  if(isDefined(self.script_audio_point_func)) {
    level._audio.trigger_function_keys[level._audio.trigger_function_keys.size] = self.script_audio_point_func;
  }
  if(!isDefined(self.script_audio_blend_mode)) {
    self.script_audio_blend_mode = "blend";
  }
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(self.target)) {
    if(!isDefined(common_scripts\utility::get_target_ent())) {
      aud_print_error("Audo Zone Trigger at " + self.origin + " has defined a target, " + self.target + ", but that target doesn't exist.");
      return;
    }

    if(isDefined(get_target_ent_target())) {
      var_3 = get_target_ent_origin();

      if(!isDefined(get_target_ent_target_ent())) {
        aud_print_error("Audo Zone Trigger at " + self.origin + " has defined a target, " + get_target_ent_target() + ", but that target doesn't exist.");
        return;
      }

      var_4 = get_target_ent_target_ent_origin();
    } else {
      var_6 = common_scripts\utility::get_target_ent();
      var_7 = 2 * (self.origin - var_6.origin);
      var_8 = vectortoangles(var_7);
      var_3 = get_target_ent_origin();
      var_4 = var_3 + var_7;

      if(angleclamp180(var_8[0]) < 45) {
        var_3 = (var_3[0], var_3[1], 0);
        var_4 = (var_4[0], var_4[1], 0);
      }
    }

    var_5 = distance(var_3, var_4);
  }

  var_9 = 0;

  for(;;) {
    self waittill("trigger", var_2);

    if(aud_is_specops() && var_2 != level.player) {
      continue;
    }
    if(isDefined(var_3) && isDefined(var_4)) {
      var_10 = trigger_multiple_audio_progress(var_3, var_4, var_5, var_2.origin);

      if(var_10 < 0.5) {
        var_9 = 0;

        if(isDefined(self.script_audio_enter_msg)) {
          if(isDefined(var_1) && isDefined(var_1[0])) {
            aud_send_msg(self.script_audio_enter_msg, var_1[0]);
          } else {
            aud_send_msg(self.script_audio_enter_msg, "front");
          }
        }

        if(isDefined(self.script_audio_enter_func)) {
          if(isDefined(var_1) && isDefined(var_1[0])) {
            if(isDefined(level._audio.trigger_functions[self.script_audio_enter_func])) {
              [[level._audio.trigger_functions[self.script_audio_enter_func]]](var_1[0]);
            }
          } else if(isDefined(level._audio.trigger_functions[self.script_audio_enter_func])) {
            [[level._audio.trigger_functions[self.script_audio_enter_func]]]("front");
          }
        }
      } else {
        var_9 = 1;

        if(isDefined(self.script_audio_enter_msg)) {
          if(isDefined(var_1) && isDefined(var_1[1])) {
            aud_send_msg(self.script_audio_enter_msg, var_1[1]);
          } else {
            aud_send_msg(self.script_audio_enter_msg, "back");
          }
        }

        if(isDefined(self.script_audio_enter_func)) {
          if(isDefined(var_1) && isDefined(var_1[1])) {
            if(isDefined(level._audio.trigger_functions[self.script_audio_enter_func])) {
              [[level._audio.trigger_functions[self.script_audio_enter_func]]](var_1[1]);
            }
          } else if(isDefined(level._audio.trigger_functions[self.script_audio_enter_func])) {
            [[level._audio.trigger_functions[self.script_audio_enter_func]]]("back");
          }
        }
      }
    } else {
      if(isDefined(self.script_audio_enter_msg)) {
        aud_send_msg(self.script_audio_enter_msg);
      }
      if(isDefined(self.script_audio_enter_func)) {
        if(isDefined(level._audio.trigger_functions[self.script_audio_enter_func])) {
          [[level._audio.trigger_functions[self.script_audio_enter_func]]]();
        }
      }
    }

    var_11 = undefined;

    if(isDefined(get_zone_from(var_1, var_9)) && isDefined(get_zone_to(var_1, var_9))) {
      var_11 = maps\_audio_zone_manager::azmx_get_blend_args(get_zone_from(var_1, var_9), get_zone_to(var_1, var_9));

      if(!isDefined(var_11)) {
        return;
      }
      var_11.mode = self.script_audio_blend_mode;
    }

    if(isDefined(var_11) && aud_is_zone_filter_enabled()) {
      if(isDefined(var_11.filter1) || isDefined(var_11.filter2)) {
        level.player deactivateeq(1);
      }
    }

    var_12 = -1;
    var_10 = -1;

    while(var_2 istouching(self)) {
      if(isDefined(self.script_audio_point_func)) {
        var_13 = trigger_multiple_audio_progress_point(var_3, var_4, var_2.origin);

        if(isDefined(level._audio.trigger_functions[self.script_audio_point_func])) {
          [[level._audio.trigger_functions[self.script_audio_point_func]]](var_13);
        }
      }

      if(isDefined(var_3) && isDefined(var_4)) {
        var_10 = trigger_multiple_audio_progress(var_3, var_4, var_5, var_2.origin);

        if(isDefined(self.script_audio_progress_map)) {
          var_10 = aud_map(var_10, level._audio.progress_maps[self.script_audio_progress_map]);
        }
        if(var_10 != var_12) {
          if(isDefined(get_zone_from(var_1, var_9)) && isDefined(get_zone_to(var_1, var_9))) {
            maps\_audio_zone_manager::azm_print_enter_blend(get_zone_from(var_1, var_9), get_zone_to(var_1, var_9), var_10);
          }
          if(isDefined(self.script_audio_progress_msg)) {
            aud_send_msg(self.script_audio_progress_msg, var_10);
          }
          if(isDefined(self.script_audio_progress_func)) {
            if(isDefined(level._audio.trigger_functions[self.script_audio_progress_func])) {
              [[level._audio.trigger_functions[self.script_audio_progress_func]]](var_10);
            }
          }

          if(isDefined(var_11)) {
            trigger_multiple_audio_blend(var_10, var_11, var_9);
          }
          var_12 = var_10;
          maps\_audio_zone_manager::azm_print_progress(var_10);
        }
      }

      if(isDefined(self.script_audio_update_rate)) {
        wait(self.script_audio_update_rate);
        continue;
      }

      wait 0.1;
    }

    if(isDefined(var_3) && isDefined(var_4)) {
      if(var_10 > 0.5) {
        if(isDefined(var_1) && isDefined(var_1[1])) {
          maps\_audio_zone_manager::azm_set_current_zone(var_1[1]);
        }
        if(isDefined(self.script_audio_exit_msg)) {
          if(isDefined(var_1) && isDefined(var_1[1])) {
            aud_send_msg(self.script_audio_exit_msg, var_1[1]);
          } else {
            aud_send_msg(self.script_audio_exit_msg, "back");
          }
        }

        if(isDefined(self.script_audio_exit_func)) {
          if(isDefined(var_1) && isDefined(var_1[1])) {
            if(isDefined(level._audio.trigger_functions[self.script_audio_exit_func])) {
              [[level._audio.trigger_functions[self.script_audio_exit_func]]](var_1[1]);
            }
          } else if(isDefined(level._audio.trigger_functions[self.script_audio_exit_func])) {
            [[level._audio.trigger_functions[self.script_audio_exit_func]]]("back");
          }
        }

        var_10 = 1;
      } else {
        if(isDefined(var_1) && isDefined(var_1[0])) {
          maps\_audio_zone_manager::azm_set_current_zone(var_1[0]);
        }
        if(isDefined(self.script_audio_exit_msg)) {
          if(isDefined(var_1) && isDefined(var_1[0])) {
            aud_send_msg(self.script_audio_exit_msg, var_1[0]);
          } else {
            aud_send_msg(self.script_audio_exit_msg, "front");
          }
        }

        if(isDefined(self.script_audio_exit_func)) {
          if(isDefined(var_1) && isDefined(var_1[0])) {
            if(isDefined(level._audio.trigger_functions[self.script_audio_exit_func])) {
              [[level._audio.trigger_functions[self.script_audio_exit_func]]](var_1[0]);
            }
          } else if(isDefined(level._audio.trigger_functions[self.script_audio_exit_func])) {
            [[level._audio.trigger_functions[self.script_audio_exit_func]]]("front");
          }
        }

        var_10 = 0;
      }

      if(isDefined(var_11)) {
        trigger_multiple_audio_blend(var_10, var_11, var_9);
      }
      continue;
    }

    if(isDefined(self.script_audio_exit_msg)) {
      aud_send_msg(self.script_audio_exit_msg);
    }
    if(isDefined(self.script_audio_exit_func)) {
      if(isDefined(level._audio.trigger_functions[self.script_audio_exit_func])) {
        [[level._audio.trigger_functions[self.script_audio_exit_func]]]();
      }
    }
  }
}

trigger_multiple_audio_progress(var_0, var_1, var_2, var_3) {
  var_4 = vectorNormalize(var_1 - var_0);
  var_5 = var_3 - var_0;
  var_6 = vectordot(var_5, var_4);
  var_6 = var_6 / var_2;
  return clamp(var_6, 0, 1.0);
}

trigger_multiple_audio_progress_point(var_0, var_1, var_2) {
  var_3 = vectorNormalize(var_1 - var_0);
  var_4 = var_2 - var_0;
  var_5 = vectordot(var_4, var_3);
  return var_3 * var_5 + var_0;
}

trigger_multiple_audio_blend(var_0, var_1, var_2) {
  var_0 = clamp(var_0, 0, 1.0);

  if(var_2) {
    var_0 = 1.0 - var_0;
  }
  var_3 = var_1.mode;

  if(var_3 == "blend") {
    var_4 = 1.0 - var_0;
    var_5 = var_0;
    maps\_audio_zone_manager::azmx_blend_zones(var_4, var_5, var_1);
  } else if(var_0 < 0.33) {
    maps\_audio_zone_manager::azm_start_zone(var_1.zone_from_name);
  } else if(var_0 > 0.66) {
    maps\_audio_zone_manager::azm_start_zone(var_1.zone_to_name);
  }
}

aud_play_dynamic_explosion(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawn("script_origin", level.player.origin);
  var_7 = spawn("script_origin", var_0);

  if(!isDefined(var_3)) {
    var_3 = distance(var_7.origin, var_6.origin);
  }
  if(!isDefined(var_4)) {
    var_8 = 30;
    var_4 = 36 * var_8;
  }

  var_9 = aud_do_dynamic_explosion_math(var_7.origin, var_6.origin, var_3, var_4);
  var_9[0] = (var_9[0][0], var_9[0][1], var_6.origin[2]);
  var_9[1] = (var_9[1][0], var_9[1][1], var_6.origin[2]);
  var_10 = distance(var_7.origin, var_9[0]);

  if(!isDefined(var_5)) {
    var_5 = 1800;
  }
  var_11 = var_10 / var_5;

  if(isDefined(var_9) && var_9.size == 2) {
    var_12 = spawn("script_origin", var_7.origin);
    var_13 = spawn("script_origin", var_7.origin);
    var_12 playSound(var_1);
    var_13 playSound(var_2);
    var_12 moveTo(var_9[0], var_11, 0, 0);
    var_13 moveTo(var_9[1], var_11, 0, 0);
  }
}

aud_do_dynamic_explosion_math(var_0, var_1, var_2, var_3) {
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
  var_2 = var_1;

  if(isDefined(var_0)) {
    var_2 = var_0;
  }
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
  if(isDefined(var_0) && isDefined(var_1)) {
    return var_0 == var_1;
  } else {
    return !isDefined(var_0) && !isDefined(var_1);
  }
}

isundefined(var_0) {
  return !isDefined(var_0);
}

delete_on_sounddone(var_0) {
  var_0 waittill("sounddone");
  var_0 delete_sound_entity();
}

delete_sound_entity() {
  common_scripts\utility::delaycall(0.05, ::delete);
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
  if(var_0 <= var_1) {
    return var_0;
  } else {
    return var_1;
  }
}

aud_max(var_0, var_1) {
  if(var_0 >= var_1) {
    return var_0;
  } else {
    return var_1;
  }
}

aud_clamp(var_0, var_1, var_2) {
  if(var_0 < var_1) {
    var_0 = var_1;
  } else if(var_0 > var_2) {
    var_0 = var_2;
  }
  return var_0;
}

aud_fade_sound_in(var_0, var_1, var_2, var_3, var_4) {
  var_2 = aud_clamp(var_2, 0.0, 1.0);
  var_3 = aud_max(0.05, var_3);
  var_5 = 0;

  if(isDefined(var_4)) {
    var_5 = var_4;
  }
  if(var_5) {
    var_0 playLoopSound(var_1);
  } else {
    var_0 playSound(var_1);
  }
  var_0 scalevolume(0.0);
  var_0 common_scripts\utility::delaycall(0.05, ::scalevolume, var_2, var_3);
}

aud_map2(var_0, var_1) {
  var_4 = var_1[0][0];
  var_5 = var_1[var_1.size - 1][0];
  var_6 = var_1[0][1];
  var_7 = var_1[var_1.size - 1][1];
  var_8 = undefined;

  if(var_0 <= var_4) {
    var_8 = var_6;
  } else if(var_0 >= var_5) {
    var_8 = var_7;
  } else {
    var_9 = undefined;
    var_2 = var_4;
    var_10 = var_6;

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      var_9 = var_1[var_3][0];
      var_11 = var_1[var_3][1];

      if(var_0 >= var_2 && var_0 < var_9) {
        var_12 = (var_0 - var_2) / (var_9 - var_2);
        var_8 = var_10 + var_12 * (var_11 - var_10);
        break;
      }

      var_2 = var_9;
      var_10 = var_11;
    }
  }

  return var_8;
}

aud_map(var_0, var_1) {
  var_2 = 0.0;
  var_3 = var_1.size;
  var_4 = var_1[0];

  for(var_5 = 1; var_5 < var_1.size; var_5++) {
    var_6 = var_1[var_5];

    if(var_0 >= var_4[0] && var_0 <= var_6[0]) {
      var_7 = var_4[0];
      var_8 = var_6[0];
      var_9 = var_4[1];
      var_10 = var_6[1];
      var_11 = (var_0 - var_7) / (var_8 - var_7);
      var_2 = var_9 + var_11 * (var_10 - var_9);
      break;
    } else {
      var_4 = var_6;
    }
  }

  return var_2;
}

aud_map_range(var_0, var_1, var_2, var_3) {
  var_4 = (var_0 - var_1) / (var_2 - var_1);
  var_4 = clamp(var_4, 0.0, 1.0);
  return aud_map(var_4, var_3);
}

aud_smooth(var_0, var_1, var_2) {
  return var_0 + var_2 * (var_1 - var_0);
}

aud_is_even(var_0) {
  return var_0 == int(var_0 / 2) * 2;
}

all_mix_channels_except(var_0) {
  var_1 = maps\_audio_mix_manager::mm_get_channel_names();
  var_2 = [];

  foreach(var_4 in var_0) {}
  var_1[var_4] = undefined;

  foreach(var_4, var_7 in var_1) {}
  var_2[var_2.size] = var_4;

  return var_2;
}

all_mix_channels() {
  var_0 = maps\_audio_mix_manager::mm_get_channel_names();
  var_1 = [];

  foreach(var_4, var_3 in var_0) {}
  var_1[var_1.size] = var_4;

  return var_1;
}

aud_setalltimescalefactors(var_0) {
  var_0 = clamp(var_0, 0, 1.0);
  var_1 = all_mix_channels();
  aud_settimescalefactors(var_1, var_0);
}

aud_settimescalefactors(var_0, var_1) {
  thread audx_settimescalefactors(var_0, var_1);
}

audx_settimescalefactors(var_0, var_1) {
  var_2 = 8;
  var_3 = 0;
  var_4 = 0;

  for(var_5 = 0; var_4 < var_0.size; var_4 = var_4 + var_2) {
    var_5 = var_4;

    for(var_3 = 0; var_3 < var_2 && var_5 < var_0.size; var_3++) {
      soundsettimescalefactor(var_0[var_5], var_1);
      var_5++;
    }

    wait 0.05;
  }
}

aud_set_breach_time_scale_factors() {
  var_0 = all_mix_channels();
  aud_settimescalefactors(var_0, 1.0);
  wait 0.5;
  soundsettimescalefactor("Music", 0);
  soundsettimescalefactor("Menu", 0);
  soundsettimescalefactor("local3", 0.0);
  soundsettimescalefactor("Mission", 0.0);
  soundsettimescalefactor("Announcer", 0.0);
  soundsettimescalefactor("Bulletimpact", 0.6);
  soundsettimescalefactor("Voice", 0.4);
  soundsettimescalefactor("effects1", 0.2);
  soundsettimescalefactor("effects2", 0.2);
  soundsettimescalefactor("local", 0.2);
  soundsettimescalefactor("local2", 0.2);
  soundsettimescalefactor("physics", 0.2);
  soundsettimescalefactor("ambient", 0.5);
  soundsettimescalefactor("auto", 0.5);
}

play_2d_sound_internal(var_0) {
  self playSound(var_0, "sounddone");
  self waittill("sounddone");
  wait 0.05;
  self delete();
}

aud_delay_play_2d_sound_internal(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2) {
    aud_slomo_wait(var_1);
  } else {
    wait(var_1);
  }
  var_3 = spawn("script_origin", level.player.origin);
  var_3 thread play_2d_sound_internal(var_0);
  return var_3;
}

aud_play_2d_sound(var_0) {
  var_1 = spawn("script_origin", level.player.origin);
  var_1 thread play_2d_sound_internal(var_0);
  return var_1;
}

aud_delay_play_2d_sound(var_0, var_1, var_2) {
  var_3 = thread aud_delay_play_2d_sound_internal(var_0, var_1, var_2);
  return var_3;
}

audx_play_linked_sound_internal(var_0, var_1, var_2) {
  if(var_0 == "loop") {
    level endon(var_2 + "internal");
    self playLoopSound(var_1);
    level waittill(var_2);

    if(isDefined(self)) {
      self stoploopsound(var_1);
      wait 0.05;
      self delete();
    }
  } else if(var_0 == "oneshot") {
    self playSound(var_1, "sounddone");
    self waittill("sounddone");

    if(isDefined(self)) {
      self delete();
    }
  }
}

audx_monitor_linked_entity_health(var_0, var_1) {
  level endon(var_1);

  while(isDefined(self)) {
    wait 0.1;
  }
  level notify(var_1 + "internal");

  if(isDefined(var_0)) {
    var_0 stoploopsound();
    wait 0.05;
    var_0 delete();
  }
}

aud_play_linked_sound(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "oneshot";

  if(isDefined(var_2)) {
    var_5 = var_2;
  }
  var_6 = spawn("script_origin", var_1.origin);

  if(isDefined(var_4)) {
    var_6 linkTo(var_1, "tag_origin", var_4, (0, 0, 0));
  } else {
    var_6 linkTo(var_1);
  }
  if(var_5 == "loop") {
    var_1 thread audx_monitor_linked_entity_health(var_6, var_3);
  }
  var_6 thread audx_play_linked_sound_internal(var_5, var_0, var_3);
  return var_6;
}

aud_playsound_attach(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", var_1.origin);
  var_3 linkTo(var_1);
  var_4 = "oneshot";

  if(isDefined(var_2)) {
    var_4 = var_2;
  }
  if(var_4 == "loop") {
    var_3 playLoopSound(var_0);
  } else {
    var_3 playSound(var_0);
  }
  return var_3;
}

aud_play_sound_at_internal(var_0, var_1, var_2) {
  self playSound(var_0, "sounddone");

  if(isDefined(var_2)) {
    wait(var_2);
    self stopsounds();
  } else {
    self waittill("sounddone");
  }
  wait 0.05;
  self delete();
}

aud_play_sound_at(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", var_1);
  var_3 thread aud_play_sound_at_internal(var_0, var_1, var_2);
  return var_3;
}

aud_prime_point_source_loop(var_0, var_1) {
  var_2 = spawn("script_origin", var_1);
  var_2 thread aud_prime_stream(var_0, 1, 0.1);
  return var_2;
}

aud_play_primed_point_source_loop(var_0, var_1, var_2) {
  var_3 = aud_get_optional_param(var_1, 1.0);
  var_4 = aud_get_optional_param(var_2, 1.0);
  aud_fade_sound_in(self, var_0, var_3, var_4, 1);
  aud_release_stream(var_0);
}

aud_play_point_source_loop(var_0, var_1, var_2, var_3) {
  var_4 = aud_get_optional_param(var_2, 1.0);
  var_5 = aud_get_optional_param(var_3, 1.0);
  var_6 = spawn("script_origin", var_1);
  aud_fade_sound_in(var_6, var_0, var_4, var_5, 1);
  return var_6;
}

aud_stop_point_source_loop(var_0, var_1) {
  var_2 = aud_get_optional_param(var_1, 1.0);
  aud_fade_out_and_delete(var_0, var_2);
}

aud_set_point_source_loop_volume(var_0, var_1, var_2) {
  var_1 = clamp(var_1, 0, 1.0);
  var_3 = aud_get_optional_param(var_2, 1.0);
  var_0 scalevolume(var_1, var_3);
}

aud_play_loops_on_destructables_array(var_0, var_1, var_2, var_3) {
  var_4 = 0.1;

  if(isDefined(var_3)) {
    var_4 = var_3;
  }
  var_5 = getEntArray(var_0, "script_noteworthy");
  var_6 = var_5.size;

  foreach(var_8 in var_5) {
    var_8 playLoopSound(var_1);
    var_8.loop_sound_stopped = 0;
  }

  while(var_6 > 0) {
    wait(var_4);

    foreach(var_8 in var_5) {
      if(var_8.health < 0 && !var_8.loop_sound_stopped) {
        var_6--;
        var_8 stoploopsound();
        var_8.loop_sound_stopped = 1;

        if(isDefined(var_2)) {
          common_scripts\utility::play_sound_in_space(var_2, var_8.origin);
        }
      }
    }
  }
}

aud_set_music_submix(var_0, var_1) {
  var_2 = "music_submix";

  if(!maps\_audio_mix_manager::mm_does_volmod_submix_exist(var_2)) {
    maps\_audio_mix_manager::mm_add_dynamic_volmod_submix(var_2, ["music", 1.0], var_1);
    maps\_audio_mix_manager::mm_make_submix_sticky(var_2);
  }

  maps\_audio_mix_manager::mm_scale_submix(var_2, var_0, var_1);
}

aud_set_ambi_submix(var_0, var_1) {
  var_2 = "ambi_submix";

  if(!maps\_audio_mix_manager::mm_does_volmod_submix_exist(var_2)) {
    maps\_audio_mix_manager::mm_add_dynamic_volmod_submix(var_2, ["ambience", 1.0], var_1);
    maps\_audio_mix_manager::mm_make_submix_sticky(var_2);
  }

  maps\_audio_mix_manager::mm_scale_submix(var_2, var_0, var_1);
}

aud_fade_in_music(var_0) {
  var_1 = 10.0;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }
  maps\_audio_mix_manager::mm_add_submix("mute_music", 0.1);
  wait 0.05;
  maps\_audio_mix_manager::mm_clear_submix("mute_music", var_1);
}

aud_check_sound_done() {
  self endon("cleanup");

  if(!isDefined(self.sounddone)) {
    self.sounddone = 0;
  }
  self waittill("sounddone");

  if(isDefined(self)) {
    self.sounddone = 1;
    self notify("cleanup");
  }
}

aud_in_zone(var_0) {
  return equal_strings(maps\_audio_zone_manager::azm_get_current_zone(), var_0);
}

aud_find_exploder(var_0) {
  if(isDefined(level.createfxexploders)) {
    var_1 = level.createfxexploders["" + var_0];

    if(isDefined(var_1)) {
      return var_1[0];
    }
  } else {
    for(var_2 = 0; var_2 < level.createfxent.size; var_2++) {
      var_3 = level.createfxent[var_2];

      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isDefined(var_3.v["exploder"])) {
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

  if(isDefined(var_2)) {
    var_4 = var_2;
  }
  var_5 = var_4;

  if(isDefined(var_3)) {
    var_5 = var_3;
  }
  maps\_audio_mix_manager::mm_add_submix(var_0, var_4);
  wait(var_1);
  maps\_audio_mix_manager::mm_clear_submix(var_0, var_5);
}

get_index_struct() {
  var_0 = spawnStruct();
  var_0.filter = [];
  var_0.mix = [];
  var_0.occlusion = [];
  var_0.timescale = [];
  var_0.indexed = 0;
  return var_0;
}

aud_index_presets() {
  level._audio.index.local.mix = index_stringtable_internal(get_mix_stringtable());
  level._audio.index.local.filter = index_stringtable_internal(get_filter_stringtable());
  level._audio.index.local.indexed = 1;
}

aud_is_local_indexed() {
  return level._audio.index.local.indexed;
}

index_common_presets() {
  level._audio.index.common.mix = index_stringtable_internal("soundtables/common_mix.csv");
  level._audio.index.common.occlusion = index_stringtable_internal("soundtables/common_occlusion.csv");
  level._audio.index.common.timescale = index_stringtable_internal("soundtables/common_timescale.csv");
  level._audio.index.common.filter = index_stringtable_internal("soundtables/common_filter.csv");
  level._audio.index.common.indexed = 1;
}

aud_is_common_indexed() {
  return level._audio.index.common.indexed;
}

get_indexed_preset(var_0, var_1, var_2) {
  var_3 = 1;

  if(isDefined(var_2)) {
    var_3 = var_2;
  }
  var_4 = undefined;

  if(var_3) {
    var_4 = level._audio.index.common;
  } else {
    var_4 = level._audio.index.local;
  }
  var_5 = undefined;

  switch (var_0) {
    case "mix":
      var_5 = var_4.mix[var_1];
      break;
    case "filter":
      var_5 = var_4.filter[var_1];
      break;
    case "occlusion":
      var_5 = level._audio.index.common.occlusion[var_1];
      break;
    case "timescale":
      var_5 = level._audio.index.common.timescale[var_1];
      break;
    default:
      break;
  }

  if(!isDefined(var_5)) {
    var_5 = -1;
  }
  return var_5;
}

get_mix_index(var_0, var_1) {
  if(var_1) {
    return level._audio.index.common.mix[var_0];
  } else {
    return level._audio.index.local.mix[var_0];
  }
}

index_stringtable_internal(var_0) {
  var_1 = "";
  var_2 = 0;
  var_3 = 1;
  var_4 = [];

  for(var_5 = ""; var_2 < 10 && var_5 != "EOF"; var_3++) {
    var_5 = tablelookupbyrow(var_0, var_3, 0);

    if(isDefined(var_5) && var_5 != var_1 && var_5 != "" && var_5 != "EOF") {
      var_2 = 0;
      var_1 = var_5;
      var_4[var_1] = var_3;
      continue;
    }

    if(var_5 == "") {
      var_2++;
    }
  }

  return var_4;
}

aud_percent_chance(var_0) {
  return randomintrange(1, 100) <= var_0;
}

aud_start_slow_mo_gunshot_callback(var_0, var_1) {
  level endon("aud_stop_slow_mo_gunshot");
  var_2 = getaiarray("axis");

  foreach(var_4 in var_2) {}
  var_4 thread aud_impact_monitor(var_1);

  var_6 = 0;
  var_7 = level.player getcurrentweapon();

  for(;;) {
    if(level.player attackButtonPressed()) {
      if(!var_6) {
        var_6 = 1;
        [[var_0]](var_7);
      }
    } else {
      var_6 = 0;
    }
    wait 0.05;
  }
}

aud_impact_monitor(var_0) {
  level endon("aud_stop_slow_mo_gunshot");
  var_1 = level.player getcurrentweapon();

  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6);

    if(isDefined(var_5)) {
      [[var_0]](var_1, var_2, var_3, var_5, var_6);
    }
  }
}

aud_stop_slow_mo_gunshot_callback() {
  level notify("aud_stop_slow_mo_gunshot");
}

aud_play_distributed_sound(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return;
  self.isdistributedsound = 1;
  self.alias = var_0;
  self.points = var_1;
  self.edge_spread = var_2;
  self.update_rate = var_5;
  self.min_dist = var_3;
  self.max_dist = var_4;
  self.vol_scale = var_6;
  self playLoopSound(var_0);
  wait 0.1;
  thread audx_distributed_sound_update_loop(var_1, var_2, var_5, var_3, var_4, var_6);
}

aud_stop_distributed_sound() {
  self notify("stop");
}

aud_start_distributed_sound() {
  return;

  if(isDefined(self.isdistributedsound)) {
    self playLoopSound(self.alias);
    wait 0.1;
    thread audx_distributed_sound_update_loop(self.points, self.edge_spread, self.update_rate, self.min_dist, self.max_dist, self.vol_scale);
  }
}

audx_distributed_sound_update_loop(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("stop");
  var_6 = 0.1;

  if(isDefined(var_2)) {
    var_6 = var_2;
  }
  var_7 = 1.0;

  if(isDefined(var_5)) {
    var_7 = var_5;
  }
  if(isDefined(var_3)) {
    if(!isDefined(var_4)) {
      return;
    }
    while(isDefined(self)) {
      self setdistributed2dsound(var_0, var_1, var_6, var_7, var_3, var_4);
      wait(var_6);
    }
  } else {
    while(isDefined(self)) {
      self setdistributed2dsound(var_0, var_1, var_6, var_7);
      wait(var_6);
    }
  }
}

aud_slomo_wait(var_0) {
  var_1 = spawn("script_origin", (0, 0, 0));
  var_1 thread aud_slomo_wait_internal(var_0);
  var_1 waittill("slo_mo_wait_done");
  var_1 delete();
}

aud_slomo_wait_internal(var_0) {
  var_1 = 0;

  while(var_1 < var_0) {
    var_2 = getdvarfloat("com_timescale");
    var_1 = var_1 + 0.05 / var_2;
    wait 0.05;
  }

  self notify("slo_mo_wait_done");
}

aud_set_level_fade_time(var_0) {
  if(!isDefined(level._audio)) {
    level._audio = spawnStruct();
  }
  level._audio.level_fade_time = var_0;
}

aud_level_fadein() {
  if(!isDefined(level._audio.level_fade_time)) {
    level._audio.level_fade_time = 1.0;
  }
  wait 0.05;
  levelsoundfade(1, level._audio.level_fade_time);
}

aud_is_specops() {
  return isDefined(level._audio.specops);
}

audx_set_spec_ops_internal() {
  if(!isDefined(level._audio)) {
    level._audio = spawnStruct();
  }
  level._audio.specops = 1;
}

aud_set_spec_ops() {
  thread audx_set_spec_ops_internal();
}

audx_play_line_emitter_internal() {
  level endon(self.label + "_line_emitter_stop");
  var_0 = self.point2 - self.point1;
  var_1 = vectorNormalize(var_0);
  var_2 = distance(self.point1, self.point2);
  var_3 = 0.1;

  for(;;) {
    var_4 = level.player.origin - self.point1;
    var_5 = vectordot(var_4, var_1);
    var_5 = clamp(var_5, 0, var_2);
    var_6 = self.point1 + var_1 * var_5;

    if(!self.is_playing) {
      self.origin = var_6;
      self playLoopSound(self.alias);
      self scalevolume(0);
      wait 0.05;
      self scalevolume(1.0, self.fade_in);
      self.is_playing = 1;
    } else {
      self moveTo(var_6, var_3);
    }
    wait(var_3);
  }
}

aud_stop_line_emitter(var_0) {
  level notify(var_0 + "_line_emitter_stop");
}

aud_play_line_emitter(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0.1;
  var_7 = 0.1;

  if(isDefined(var_4)) {
    var_6 = max(var_4, 0);
    var_7 = max(var_4, 0);
  }

  if(isDefined(var_5)) {
    var_7 = max(var_5, 0);
  }
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
  var_8 stoploopsound();
  wait 0.05;
  var_8 delete();
}

aud_print_3d_on_ent(var_0, var_1, var_2) {
  if(isDefined(self)) {
    var_3 = (1, 1, 1);
    var_4 = (1, 0, 0);
    var_5 = (0, 1, 0);
    var_6 = (0, 1, 1);
    var_7 = 5;
    var_8 = var_3;

    if(isDefined(var_1)) {
      var_7 = var_1;
    }
    if(isDefined(var_2)) {
      var_8 = var_2;

      switch (var_8) {
        case "red":
          var_8 = var_4;
          break;
        case "white":
          var_8 = var_3;
          break;
        case "blue":
          var_8 = var_6;
          break;
        case "green":
          var_8 = var_5;
          break;
        default:
          var_8 = var_3;
      }
    }

    self endon("death");

    while(isDefined(self)) {
      wait 0.05;
    }
  }
}