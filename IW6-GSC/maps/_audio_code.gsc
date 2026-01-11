/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_audio_code.gsc
*****************************************************/

get_channel_array() {
  var_0 = [];
  var_0["physics"] = "physics";
  var_0["ambdist1"] = "ambdist1";
  var_0["ambdist2"] = "ambdist2";
  var_0["alarm"] = "alarm";
  var_0["auto"] = "auto";
  var_0["auto2"] = "auto2";
  var_0["auto2d"] = "auto2d";
  var_0["autodog"] = "autodog";
  var_0["explosiondist1"] = "explosiondist1";
  var_0["explosiondist2"] = "explosiondist2";
  var_0["explosiveimpact"] = "explosiveimpact";
  var_0["element"] = "element";
  var_0["foley_plr_mvmt"] = "foley_plr_mvmt";
  var_0["foley_plr_weap"] = "foley_plr_weap";
  var_0["foley_npc_mvmt"] = "foley_npc_mvmt";
  var_0["foley_npc_weap"] = "foley_npc_weap";
  var_0["element_int"] = "element_int";
  var_0["element_ext"] = "element_ext";
  var_0["foley_dog_mvmt"] = "foley_dog_mvmt";
  var_0["voice_dog"] = "voice_dog";
  var_0["element_lim"] = "element_lim";
  var_0["element2d"] = "element2d";
  var_0["voice_dog_dist"] = "voice_dog_dist";
  var_0["bulletflesh1npc_npc"] = "bulletflesh1npc_npc";
  var_0["bulletflesh2npc_npc"] = "bulletflesh2npc_npc";
  var_0["bulletimpact"] = "bulletimpact";
  var_0["bulletflesh1"] = "bulletflesh1";
  var_0["bulletflesh2"] = "bulletflesh2";
  var_0["vehicle"] = "vehicle";
  var_0["vehiclelimited"] = "vehiclelimited";
  var_0["menu"] = "menu";
  var_0["menulim1"] = "menulim1";
  var_0["menulim2"] = "menulim2";
  var_0["bulletflesh1npc"] = "bulletflesh1npc";
  var_0["bulletflesh2npc"] = "bulletflesh2npc";
  var_0["bulletwhizbyin"] = "bulletwhizbyin";
  var_0["bulletwhizbyout"] = "bulletwhizbyout";
  var_0["body"] = "body";
  var_0["body2d"] = "body2d";
  var_0["reload"] = "reload";
  var_0["reload2d"] = "reload2d";
  var_0["foley_plr_step"] = "foley_plr_step";
  var_0["foley_plr_step_unres"] = "foley_plr_step";
  var_0["foley_npc_step"] = "foley_npc_step";
  var_0["foley_dog_step"] = "foley_dog_step";
  var_0["item"] = "item";
  var_0["weapon_drone"] = "weapon_drone";
  var_0["explosion1"] = "explosion1";
  var_0["explosion2"] = "explosion2";
  var_0["explosion3"] = "explosion3";
  var_0["explosion4"] = "explosion4";
  var_0["explosion5"] = "explosion5";
  var_0["effects1"] = "effects1";
  var_0["effects2"] = "effects2";
  var_0["effects3"] = "effects3";
  var_0["effects2d1"] = "effects2d1";
  var_0["effects2d2"] = "effects2d2";
  var_0["norestrict"] = "norestrict";
  var_0["norestrict2d"] = "norestrict2d";
  var_0["aircraft"] = "aircraft";
  var_0["vehicle2d"] = "vehicle2d";
  var_0["weapon_dist"] = "weapon_dist";
  var_0["weapon_mid"] = "weapon_mid";
  var_0["weapon"] = "weapon";
  var_0["weapon2d"] = "weapon2d";
  var_0["nonshock"] = "nonshock";
  var_0["nonshock2"] = "nonshock2";
  var_0["voice"] = "voice";
  var_0["music_emitter"] = "music_emitter";
  var_0["voice_dog_attack"] = "voice_dog_attack";
  var_0["local"] = "local";
  var_0["local2"] = "local2";
  var_0["local3"] = "local3";
  var_0["ambient"] = "ambient";
  var_0["plr_weap_fire_2d"] = "plr_weap_fire_2d";
  var_0["plr_weap_mech_2d"] = "plr_weap_mech_2d";
  var_0["hurt"] = "hurt";
  var_0["player1"] = "player1";
  var_0["player2"] = "player2";
  var_0["music"] = "music";
  var_0["musicnopause"] = "musicnopause";
  var_0["mission"] = "mission";
  var_0["missionfx"] = "missionfx";
  var_0["announcer"] = "announcer";
  var_0["shellshock"] = "shellshock";
  return var_0;
}

cache_ambient(var_0) {
  if(isDefined(level._audio.ambient.cached_ambients[var_0])) {
    return;
  }
  var_1 = ["ambient_name", "time_min", "time_max"];
  var_2 = get_table_data(get_map_soundtable(), var_0, var_1);

  if(var_2.size == 0) {
    return;
  }
  var_2["time_min"] = string_to_float(var_2["time_min"]);
  var_2["time_max"] = string_to_float(var_2["time_max"]);
  var_2["time"] = [var_2["time_min"], var_2["time_max"]];
  var_2["time_min"] = undefined;
  var_2["time_max"] = undefined;
  var_3 = spawnStruct();
  var_3.data = var_2;

  if(var_2["time"][0] > 0 && var_2["time"][1] > 0) {
    var_3.serialized = 1;
  }

  level._audio.ambient.cached_ambients[var_0] = var_3;
  cache_ambient_event(var_0);
}

cache_ambient_event(var_0) {
  var_1 = ["ambient_event", "element", "weight"];
  var_2 = get_table_data_array(get_map_soundtable(), var_0, var_1);

  if(var_2.size == 0) {
    return;
  }
  foreach(var_5, var_4 in var_2) {
  var_2[var_5]["weight"] = string_to_float(var_4["weight"]);
  }

  var_6 = [];

  foreach(var_4 in var_2) {
    var_8 = spawnStruct();
    var_8.elem = var_4["element"];
    var_8.weight = var_4["weight"];
    var_6[var_6.size] = var_8;
    cache_ambient_element(var_8);
  }

  level._audio.ambient.cached_ambients[var_0].events = var_6;
}

cache_ambient_element(var_0) {
  var_1 = var_0.elem;

  if(isDefined(level._audio.ambient.cached_elems[var_1])) {
    return;
  }
  var_2 = ["ambient_element", "alias", "range_min", "range_max", "cone_min", "cone_max", "time_min", "time_max", "travel_min", "travel_max", "travel_time_min", "travel_time_max"];
  var_3 = get_table_data(get_map_soundtable(), var_1, var_2);

  if(var_3.size == 0) {
    return;
  }
  foreach(var_6, var_5 in var_3) {
    if(var_5 == "") {
      var_3[var_6] = undefined;
      continue;
    }

    if(var_6 == "alias") {
      continue;
    }
    var_3[var_6] = string_to_float(var_3[var_6]);
  }

  var_7 = ["range", "cone", "time", "travel", "travel_time"];

  foreach(var_9 in var_7) {
    if(isDefined(var_3[var_9 + "_min"]) && isDefined(var_3[var_9 + "_max"])) {
      var_3[var_9] = [var_3[var_9 + "_min"], var_3[var_9 + "_max"]];
      var_3[var_9 + "_min"] = undefined;
      var_3[var_9 + "_max"] = undefined;
    }
  }

  level._audio.ambient.cached_elems[var_1] = var_3;
}

cache_zone(var_0) {
  if(isDefined(level._audio.zone.cached[var_0])) {
    return;
  }
  var_1 = ["zone_name", "ambience", "ambient_name", "mix", "reverb", "filter", "occlusion"];
  var_2 = get_table_data(get_map_soundtable(), var_0, var_1);

  if(var_2.size == 0) {
    return;
  }
  level._audio.zone.cached[var_0] = var_2;
}

get_zone_blend_args(var_0, var_1) {
  if(!isDefined(level._audio.zone.cached[var_0])) {
    cache_zone(var_0);

    if(!isDefined(level._audio.zone.cached[var_0])) {
      debug_warning("Couldn't find zone: " + var_0);
      return undefined;
    }
  }

  var_2 = level._audio.zone.cached[var_0];

  if(!isDefined(level._audio.zone.cached[var_1])) {
    cache_zone(var_1);

    if(!isDefined(level._audio.zone.cached[var_1])) {
      debug_warning("Couldn't find zone: " + var_1);
      return undefined;
    }
  }

  var_3 = level._audio.zone.cached[var_1];
  var_4 = ["ambience", "occlusion", "filter", "reverb", "mix"];
  var_5 = [];
  var_5["zone1"] = var_0;
  var_5["zone2"] = var_1;

  foreach(var_7 in var_4) {
    var_5[var_7 + "1"] = var_2[var_7];
    var_5[var_7 + "2"] = var_3[var_7];
  }

  var_5["ambient_name1"] = level._audio.ambient.current_zone;
  maps\_audio_ambient::stop_current_ambient();
  var_5["ambient_name2"] = var_3["ambient_name"];
  return var_5;
}

is_dyn_ambience_valid(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 0;
  }

  if(isDefined(var_0) || isDefined(var_1)) {
    return 1;
  }

  if(var_0 == var_1) {
    return 0;
  }

  return 1;
}

is_ambience_blend_valid(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 0;
  }

  if(var_0 == var_1) {
    return 0;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  return 1;
}

blend_zones(var_0, var_1, var_2, var_3) {
  var_4 = [var_0, var_1];
  var_5 = var_4;

  if(var_3) {
    var_5 = common_scripts\utility::array_reverse(var_5);
  }

  if(is_ambience_blend_valid(var_2["ambience1"], var_2["ambience2"])) {
    var_6 = [];

    for(var_7 = 0; var_7 < 2; var_7++) {
      var_8 = var_7 + 1;
      var_9 = "ambience" + var_8;

      if(isDefined(var_2[var_9]) && var_2[var_9] != "") {
        var_10 = level._audio.zone.cached[var_2["zone" + var_8]];
        var_6[var_7] = spawnStruct();
        var_6[var_7].alias = var_2[var_9];
        var_6[var_7].volume = var_4[var_7];
        var_6[var_7].fade = 0.5;
      }
    }

    if(var_6.size > 0) {
      maps\_audio::mix_ambient_tracks(var_6);
    }
  }

  if(is_dyn_ambience_valid(var_2["ambient_name1"], var_2["ambient_name2"])) {
    maps\_audio_ambient::swap_ambient_event_zones(var_2["ambient_name1"], var_0, var_2["ambient_name2"], var_1);
  }

  var_11 = 0;

  for(var_7 = 0; var_7 < 2; var_7++) {
    var_8 = var_7 + 1;
    var_12 = undefined;

    if(isDefined(var_2["filter" + var_8])) {
      var_11++;
      var_12 = var_2["filter" + var_8];
    }

    if(!isDefined(var_12) || var_12 == "") {
      maps\_audio::clear_filter(var_7);
      continue;
    }

    maps\_audio::set_filter(var_12, var_7);
  }

  if(var_11 == 2) {
    level.player seteqlerp(var_5[0], 0);
  }

  if(var_0 >= 0.75) {
    if(isDefined(var_2["reverb1"])) {
      if(var_2["reverb1"] == "") {} else
        maps\_audio::set_reverb(var_2["reverb1"]);
    }

    if(isDefined(var_2["mix1"])) {
      if(var_2["mix1"] == "") {
        maps\_audio::clear_mix(2);
      }
      else {
        maps\_audio::set_mix(var_2["mix1"]);
      }
    }

    if(isDefined(var_2["occlusion1"])) {
      if(var_2["occlusion1"] == "") {
        maps\_audio::deactivate_occlusion();
      }
      else {
        maps\_audio::set_occlusion(var_2["occlusion1"]);
      }
    }
  } else if(var_1 >= 0.75) {
    if(isDefined(var_2["reverb2"])) {
      if(var_2["reverb2"] == "") {} else
        maps\_audio::set_reverb(var_2["reverb2"]);
    }

    if(isDefined(var_2["mix2"])) {
      if(var_2["mix2"] == "") {
        maps\_audio::clear_mix(2);
      }
      else {
        maps\_audio::set_mix(var_2["mix2"]);
      }
    }

    if(isDefined(var_2["occlusion2"])) {
      if(var_2["occlusion2"] == "") {
        maps\_audio::deactivate_occlusion();
      }
      else {
        maps\_audio::set_occlusion(var_2["occlusion2"]);
      }
    }
  }
}

get_current_audio_zone() {
  return level._audio.zone.current_zone;
}

set_current_audio_zone(var_0) {
  level._audio.zone.current_zone = var_0;
}

validate_zone(var_0, var_1) {}

cache_filter(var_0) {
  if(isDefined(level._audio.filter.cached[var_0])) {
    return;
  }
  var_1 = ["filter_name", "channel", "band", "type", "freq", "gain", "q"];
  var_2 = get_table_data_array(get_map_soundtable(), var_0, var_1);

  if(var_2.size == 0) {
    return;
  }
  foreach(var_5, var_4 in var_2) {
    var_2[var_5]["band"] = string_to_int(var_4["band"]);
    var_2[var_5]["freq"] = string_to_float(var_4["freq"]);
    var_2[var_5]["gain"] = string_to_float(var_4["gain"]);
    var_2[var_5]["q"] = string_to_float(var_4["q"]);
  }

  level._audio.filter.cached[var_0] = var_2;
}

cache_occlusion(var_0) {
  if(isDefined(level._audio.occlusion.cached[var_0])) {
    return;
  }
  var_1 = ["occlusion_name", "channel", "freq", "type", "gain", "q"];
  var_2 = get_table_data_array(get_map_soundtable(), var_0, var_1);

  if(var_2.size == 0) {
    return;
  }
  foreach(var_5, var_4 in var_2) {
    var_2[var_5]["freq"] = string_to_float(var_4["freq"]);
    var_2[var_5]["gain"] = string_to_float(var_4["gain"]);
    var_2[var_5]["q"] = string_to_float(var_4["q"]);
  }

  level._audio.occlusion.cached[var_0] = var_2;
}

cache_mix(var_0) {
  if(isDefined(level._audio.mix.cached[var_0])) {
    return;
  }
  var_1 = ["mix_name", "mix_bus", "volume", "fade"];
  var_2 = get_table_data_array(get_map_soundtable(), var_0, var_1);

  if(var_2.size == 0) {
    return;
  }
  foreach(var_5, var_4 in var_2) {
    var_2[var_5]["volume"] = string_to_float(var_4["volume"]);
    var_2[var_5]["fade"] = string_to_float(var_4["fade"]);
    var_2[var_5]["mix_bus"] = undefined;
  }

  level._audio.mix.cached[var_0] = var_2;
}

cache_mix_default() {
  var_0 = ["mix_bus", "volume"];
  var_1 = read_in_table("soundaliases/volumemodgroups.svmod", var_0);

  foreach(var_4, var_3 in var_1) {
    var_1[var_4]["volume"] = string_to_float(var_3["volume"]);
    var_1[var_4]["fade"] = 1;
    var_1[var_4]["mix_bus"] = undefined;
  }

  level._audio.mix.cached["default"] = var_1;
}

cache_reverb(var_0) {
  if(isDefined(level._audio.reverb.cached[var_0])) {
    return;
  }
  var_1 = ["reverb_name", "roomtype", "drylevel", "wetlevel", "fade"];
  var_2 = get_table_data(get_map_soundtable(), var_0, var_1);

  if(var_2.size == 0) {
    return;
  }
  var_2["drylevel"] = string_to_float(var_2["drylevel"]);
  var_2["wetlevel"] = string_to_float(var_2["wetlevel"]);
  var_2["fade"] = string_to_float(var_2["fade"]);
  level._audio.reverb.cached[var_0] = var_2;
}

cache_whizby(var_0) {
  if(isDefined(level._audio.whizby.cached[var_0])) {
    return;
  }
  var_1 = ["whizby_name", "near_radius", "medium_radius", "far_radius", "radius_offset", "near_spread", "medium_spread", "far_spread", "near_prob", "medium_prob", "far_prob"];
  var_2 = get_table_data(get_map_soundtable(), var_0, var_1);

  if(var_2.size == 0) {
    return;
  }
  foreach(var_5, var_4 in var_2) {
  var_2[var_5] = string_to_float(var_2[var_5]);
  }

  level._audio.whizby.cached[var_0] = var_2;
}

cache_timescale(var_0) {
  if(isDefined(level._audio.timescale.cached[var_0])) {
    return;
  }
  var_1 = ["timescale_name", "channel", "scale"];
  var_2 = get_table_data_array(get_map_soundtable(), var_0, var_1);

  if(var_2.size == 0) {
    return;
  }
  foreach(var_5, var_4 in var_2) {
  var_2[var_5]["scale"] = string_to_float(var_4["scale"]);
  }

  level._audio.timescale.cached[var_0] = var_2;
}

get_table_data(var_0, var_1, var_2) {
  var_3 = [];

  if(tableexists(get_map_soundtable())) {
    var_3 = get_table_data_array_internal(get_map_soundtable(), var_1, var_2, 1);
  }

  if(var_3.size == 0) {
    debug_println("^2Looking in common soundtable for " + var_1);
    var_3 = get_table_data_array_internal(get_common_soundtable(), var_1, var_2, 1);
  }

  return var_3;
}

get_table_data_array(var_0, var_1, var_2) {
  var_3 = [];

  if(tableexists(get_map_soundtable())) {
    var_3 = get_table_data_array_internal(get_map_soundtable(), var_1, var_2);
  }

  if(var_3.size == 0) {
    debug_println("^2Looking in common soundtable for " + var_1);
    var_3 = get_table_data_array_internal(get_common_soundtable(), var_1, var_2);
  }

  return var_3;
}

get_table_data_array_internal(var_0, var_1, var_2, var_3) {
  var_4 = var_2[0];
  var_5 = tablelookuprownum(var_0, 0, var_4);
  var_6 = 0;
  var_7 = [];

  if(var_5 < 0) {
    return var_7;
  }

  var_8 = undefined;

  for(;;) {
    var_5++;
    var_9 = tablelookupbyrow(var_0, var_5, 0);

    if(var_9 == "") {
      var_6++;

      if(var_6 > 10) {
        break;
      }
    } else {
      var_6 = 0;

      if(isDefined(var_8) && var_8 != var_9) {
        break;
      }

      if(var_9 != var_1) {
        continue;
      }
      if(var_9 == "END_OF_FILE" || in_new_section(var_4, var_9)) {
        break;
      }

      var_8 = var_1;
      var_10 = [];
      var_11 = undefined;

      for(var_12 = 1; var_12 < var_2.size; var_12++) {
        var_13 = tablelookupbyrow(var_0, var_5, var_12);
        var_10[var_2[var_12]] = var_13;

        if(var_12 == 1) {
          var_11 = var_13;
        }
      }

      if(isDefined(var_3)) {
        return var_10;
      }

      var_7[var_11] = var_10;
    }
  }

  return var_7;
}

in_new_section(var_0, var_1) {
  var_2 = ["zone_name", "whizby_name", "reverb_name", "mix_name", "filter_name", "occlusion_name", "timescale_name", "ambient_name", "ambient_event", "ambient_element", "adsr_name", "adsr_zone_player", "adsr_zone_npc"];
  var_2 = common_scripts\utility::array_remove(var_2, var_0);

  foreach(var_4 in var_2) {
    if(var_4 == var_1) {
      return 1;
    }
  }

  return 0;
}

read_in_table(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = [];

  for(;;) {
    var_2++;
    var_5 = tablelookupbyrow(var_0, var_2, 0);

    if(var_5 == "") {
      var_3++;

      if(var_3 > 10) {
        break;
      }
    } else {
      var_3 = 0;
      var_6 = [];
      var_6[var_1[0]] = var_5;

      for(var_7 = 1; var_7 < var_1.size; var_7++) {
        var_8 = tablelookupbyrow(var_0, var_2, var_7);
        var_6[var_1[var_7]] = var_8;
      }

      var_4[var_5] = var_6;
    }
  }

  return var_4;
}

get_map_soundtable() {
  return "soundtables/" + common_scripts\utility::get_template_level() + ".csv";
}

get_common_soundtable() {
  return "soundtables/common.csv";
}

string_to_float(var_0) {
  if(var_0 == "") {
    return 0;
  }

  return float(var_0);
}

string_to_int(var_0) {
  if(var_0 == "") {
    return 0;
  }

  return int(var_0);
}

round_to(var_0, var_1) {
  return int(var_0 * var_1) / var_1;
}

debug_println(var_0, var_1) {}

debug_iprintln(var_0) {}

debug_enabled() {
  return 0;
}

debug_warning(var_0) {
  debug_println("^2" + var_0);
}

debug_error(var_0) {
  debug_println("^3" + var_0);
}

get_headroom_dvar() {
  return getdvarfloat("debug_headroom");
}

create_submix_hud() {}

destroy_submix_hud() {}

new_volmod_hud(var_0, var_1, var_2, var_3, var_4, var_5) {}

new_submix_hud(var_0, var_1, var_2, var_3, var_4, var_5) {}

delete_volmod_hud(var_0) {}

create_zone_hud() {}

destroy_zone_hud() {}

remove_hud_text(var_0) {
  if(!isDefined(level._audio.huds[var_0])) {
    return;
  }
  level._audio.huds[var_0] destroy();
  level._audio.huds = common_scripts\utility::array_removeundefined(level._audio.huds);
}

debug_hud_disabled() {}

debug_audio_hud() {}

check_zone_hud_dvar() {}

check_submix_hud_dvar() {}

create_hud(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {}

init_hud(var_0, var_1, var_2, var_3, var_4, var_5) {}

init_hud_internal(var_0, var_1, var_2, var_3, var_4, var_5) {}

init_hud_percent(var_0, var_1, var_2, var_3, var_4, var_5) {}

set_hud_value(var_0, var_1) {}

set_hud_percent_value(var_0, var_1) {}

set_hud_value_internal(var_0) {}

set_hud_name_percent_value(var_0, var_1, var_2) {}