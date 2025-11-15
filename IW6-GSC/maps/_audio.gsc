/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_audio.gsc
*****************************************************/

init_audio() {
  if(isDefined(level._audio)) {
    return;
  }
  setdvarifuninitialized("debug_audio", "0");
  setdvarifuninitialized("debug_headroom", "-1");
  setdvarifuninitialized("music_enable", "1");
  level._audio = spawnStruct();
  level._audio.using_string_tables = 0;
  level._audio.progress_trigger_callbacks = [];
  level._audio.progress_maps = [];
  init_tracks();
  init_filter();
  init_occlusion();
  maps\_audio_ambient::init_ambient();
  init_mix();
  init_reverb();
  init_timescale();
  init_whizby();
  init_zones();
  thread level_fadein();
}

aud_set_spec_ops() {}

aud_add_progress_map(var_0, var_1) {
  level._audio.progress_maps[var_0] = var_1;
}

is_deathsdoor_audio_enabled() {
  if(!isDefined(level._audio.deathsdoor_enabled))
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
  if(is_deathsdoor_audio_enabled() || isDefined(level._audio.in_deathsdoor)) {
    level._audio.in_deathsdoor = undefined;
    level.player clearclienttriggeraudiozone();
  }
}

set_deathsdoor() {
  level._audio.in_deathsdoor = 1;

  if(is_deathsdoor_audio_enabled()) {
    if(isDefined(level.deathsdooroverride))
      level.player setclienttriggeraudiozonepartial(level.deathsdooroverride, "reverb", "mix", "filter");
    else
      level.player setclienttriggeraudiozonepartial("deathsdoor", "reverb", "mix", "filter");
  }
}

trigger_multiple_audio_trigger(var_0) {
  if(isDefined(var_0._audio_trigger)) {
    return;
  }
  var_0._audio_trigger = 1;
  var_1 = undefined;

  if(isDefined(var_0.ambient))
    var_1 = strtok(var_0.ambient, " ");
  else if(isDefined(var_0.script_audio_zones))
    var_1 = strtok(var_0.script_audio_zones, " ");
  else if(isDefined(var_0.audio_zones))
    var_1 = strtok(var_0.audio_zones, " ");

  if(isDefined(var_1) && var_1.size == 2) {} else if(isDefined(var_1) && var_1.size == 1) {
    for(;;) {
      var_0 waittill("trigger", var_2);
      set_zone(var_1[0], var_0.script_duration);
    }
  }

  if(isDefined(var_0.script_audio_progress_map)) {
    if(!isDefined(level._audio.progress_maps[var_0.script_audio_progress_map])) {
      maps\_audio_code::debug_error("Trying to set a progress_map_function without defining the envelope in the level.aud.envs array.");
      var_0.script_audio_progress_map = undefined;
    }
  }

  if(!isDefined(var_0.script_audio_blend_mode))
    var_0.script_audio_blend_mode = "blend";

  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(var_0.target)) {
    if(!isDefined(var_0 common_scripts\utility::get_target_ent())) {
      maps\_audio_code::debug_error("Audo Zone Trigger at " + var_0.origin + " has defined a target, " + var_0.target + ", but that target doesn't exist.");
      return;
    }

    if(isDefined(var_0 get_target_ent_target())) {
      var_3 = var_0 get_target_ent_origin();

      if(!isDefined(var_0 get_target_ent_target_ent())) {
        maps\_audio_code::debug_error("Audo Zone Trigger at " + var_0.origin + " has defined a target, " + get_target_ent_target() + ", but that target doesn't exist.");
        return;
      }

      var_4 = var_0 get_target_ent_target_ent_origin();
    } else {
      var_6 = var_0 common_scripts\utility::get_target_ent();
      var_7 = 2 * (var_0.origin - var_6.origin);
      var_8 = vectortoangles(var_7);
      var_3 = var_0 get_target_ent_origin();
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
    var_0 waittill("trigger", var_2);

    if(maps\_utility::is_specialop() && var_2 != level.player) {
      continue;
    }
    if(isDefined(var_3) && isDefined(var_4)) {
      var_10 = trigger_multiple_audio_progress(var_3, var_4, var_5, var_2.origin);

      if(var_10 < 0.5)
        var_9 = 0;
      else
        var_9 = 1;
    }

    var_11 = undefined;
    var_12 = get_zone_from(var_1, var_9);
    var_13 = get_zone_to(var_1, var_9);

    if(isDefined(var_12) && isDefined(var_13)) {
      var_11 = maps\_audio_code::get_zone_blend_args(var_12, var_13);

      if(!isDefined(var_11)) {
        return;
      }
      var_11["mode"] = var_0.script_audio_blend_mode;

      if(var_9) {
        var_14 = var_11["filter1"];
        var_15 = var_11["filter2"];
        var_11["filter1"] = var_15;
        var_11["filter2"] = var_14;
        var_14 = undefined;
        var_15 = undefined;
      }
    }

    var_16 = -1;
    var_10 = -1;

    while(var_2 istouching(var_0)) {
      if(isDefined(var_0.script_audio_point_func)) {
        var_17 = trigger_multiple_audio_progress_point(var_3, var_4, var_2.origin);

        if(isDefined(level._audio.trigger_functions[var_0.script_audio_point_func]))
          [[level._audio.trigger_functions[var_0.script_audio_point_func]]](var_17);
      }

      if(isDefined(var_3) && isDefined(var_4)) {
        var_10 = trigger_multiple_audio_progress(var_3, var_4, var_5, var_2.origin);

        if(isDefined(var_0.script_audio_progress_map))
          var_10 = aud_map(var_10, level._audio.progress_maps[var_0.script_audio_progress_map]);

        if(var_10 != var_16) {
          if(isDefined(var_11))
            trigger_multiple_audio_blend(var_10, var_11, var_9);

          var_16 = var_10;
        }
      }

      if(isDefined(var_0.script_audio_update_rate)) {
        wait(var_0.script_audio_update_rate);
        continue;
      }

      wait 0.05;
    }

    if(isDefined(var_3) && isDefined(var_4)) {
      if(var_10 > 0.5) {
        if(isDefined(var_1) && isDefined(var_1[1]))
          maps\_audio_code::set_current_audio_zone(var_1[1]);

        var_10 = 1;
      } else {
        if(isDefined(var_1) && isDefined(var_1[0]))
          maps\_audio_code::set_current_audio_zone(var_1[0]);

        var_10 = 0;
      }

      if(isDefined(var_11))
        trigger_multiple_audio_blend(var_10, var_11, var_9);
    }
  }
}

trigger_multiple_audio_progress(var_0, var_1, var_2, var_3) {
  var_4 = vectornormalize(var_1 - var_0);
  var_5 = var_3 - var_0;
  var_6 = vectordot(var_5, var_4);
  var_6 = var_6 / var_2;
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
    var_0 = 1 - var_0;

  var_3 = var_1["mode"];

  if(var_3 == "blend") {
    var_4 = 1 - var_0;
    var_5 = var_0;
    maps\_audio_code::blend_zones(var_4, var_5, var_1, var_2);
  } else if(var_0 < 0.33)
    set_zone(var_1["zone_from"]);
  else if(var_0 > 0.66)
    set_zone(var_1["zone_to"]);
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
  if(!isDefined(var_0) || !isDefined(var_1))
    return undefined;

  if(var_1)
    return var_0[1];
  else
    return var_0[0];
}

get_zone_to(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1))
    return undefined;

  if(var_1)
    return var_0[0];
  else
    return var_0[1];
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
    } else
      var_4 = var_6;
  }

  return var_2;
}

aud_map_range(var_0, var_1, var_2, var_3) {
  var_4 = (var_0 - var_1) / (var_2 - var_1);
  var_4 = clamp(var_4, 0.0, 1.0);
  return aud_map(var_4, var_3);
}

audx_validate_env_array(var_0) {}

play_linked_sound(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    var_2 = "oneshot";

  var_5 = spawn("script_origin", var_1.origin);

  if(isDefined(var_4))
    var_5 linkto(var_1, "tag_origin", var_4, (0, 0, 0));
  else
    var_5 linkto(var_1);

  if(var_2 == "loop")
    var_1 thread play_linked_sound_think(var_5, var_3);

  var_5 thread play_linked_sound_internal(var_2, var_0, var_3);
  return var_5;
}

play_linked_sound_internal(var_0, var_1, var_2) {
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

    if(isDefined(self))
      self delete();
  }
}

play_linked_sound_think(var_0, var_1) {
  level endon(var_1);

  while(isDefined(self))
    wait 0.1;

  level notify(var_1 + "internal");

  if(isDefined(var_0)) {
    var_0 stoploopsound();
    wait 0.05;
    var_0 delete();
  }
}

level_fadein() {
  if(!isDefined(level._audio.level_fade_time))
    level._audio.level_fade_time = 1.0;

  wait 0.05;
  levelsoundfade(1, level._audio.level_fade_time);
}

init_tracks() {
  level._audio.ambient_track = spawnStruct();
  level._audio.ambient_track.current = create_track_struct();
  level._audio.ambient_track.previous = create_track_struct();
}

create_track_struct() {
  var_0 = spawnStruct();
  var_0.name = "";
  var_0.volume = 0.0;
  var_0.fade = 0.0;
  return var_0;
}

clear_track_struct(var_0) {
  var_0.name = "";
  var_0.volume = 0.0;
  var_0.fade = 0.0;
}

set_current_track_struct(var_0, var_1, var_2, var_3) {
  var_0.previous set_track_values(var_0.current.name, var_0.current.volume, var_0.current.fade);
  var_0.current set_track_values(var_1, var_2, var_3);
}

set_track_values(var_0, var_1, var_2) {
  self.name = var_0;
  self.volume = var_1;
  self.fade = var_2;
}

set_ambient_track(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_2))
    var_2 = 1;

  set_current_track_struct(level._audio.ambient_track, var_0, var_2, var_1);
  maps\_audio_code::set_hud_value("ambient", var_0);
  maps\_audio_code::set_hud_name_percent_value("ambient_from", "");
  maps\_audio_code::set_hud_name_percent_value("ambient_to", "");
  ambientplay(var_0, var_1, var_2);
}

stop_ambient_track(var_0, var_1) {
  if(var_0 == "") {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 1;

  if(level._audio.ambient_track.current.name == var_0) {
    level._audio.ambient_track.current = level._audio.ambient_track.previous;
    maps\_audio_code::set_hud_value("ambient", "");
    maps\_audio_code::set_hud_name_percent_value("ambient_from", "");
    maps\_audio_code::set_hud_name_percent_value("ambient_to", "");
    clear_track_struct(level._audio.ambient_track.previous);
  } else if(level._audio.ambient_track.previous.name == var_0)
    clear_track_struct(level._audio.ambient_track.previous);

  ambientstop(var_1, var_0);
}

stop_ambient_tracks(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  clear_track_struct(level._audio.ambient_track.current);
  clear_track_struct(level._audio.ambient_track.previous);
  ambientstop(var_0);
}

mix_ambient_tracks(var_0) {
  var_1 = 0.009;
  var_2 = level._audio.ambient_track.current;
  var_3 = level._audio.ambient_track.previous;

  if(var_0.size == 1)
    var_2 set_track_values(var_0[0].alias, var_0[0].volume, var_0[0].fade);
  else if(var_0.size == 2) {
    var_3 set_track_values(var_0[0].alias, var_0[0].volume, var_0[0].fade);
    var_2 set_track_values(var_0[1].alias, var_0[1].volume, var_0[1].fade);
  }

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5].alias;
    var_7 = max(var_0[var_5].volume, 0);
    var_8 = clamp(var_0[var_5].fade, 0, 1);

    if(var_6 != "") {
      if(var_7 < var_1) {
        ambientstop(var_8, var_6);
        continue;
      }

      ambientplay(var_6, var_8, var_7, 0);
    }
  }
}

empty_string_if_none(var_0) {
  if(var_0 == "none")
    return "";

  return var_0;
}

init_zones() {
  level._audio.zone = spawnStruct();
  level._audio.zone.current_zone = "";
  level._audio.zone.cached = [];
}

set_zone(var_0, var_1, var_2) {
  if(isDefined(var_2)) {}

  if(level._audio.zone.current_zone == var_0) {
    return;
  }
  if(level._audio.zone.current_zone != "")
    stop_zone(level._audio.zone.current_zone, var_1);

  level._audio.zone.current_zone = var_0;

  if(isDefined(level._audio.zone.cached[var_0]) && isDefined(level._audio.zone.cached[var_0]["state"]) && level._audio.zone.cached[var_0]["state"] != "stopping") {
    maps\_audio_code::debug_error("set_zone( \"" + var_0 + "\" ) being called even though audio zone, \"" + var_0 + "\", is already started.");
    return;
  }

  if(!isDefined(var_1))
    var_1 = 2;

  maps\_audio_code::cache_zone(var_0);
  maps\_audio_code::debug_println("ZONE START: " + var_0);
  level._audio.zone.cached[var_0]["state"] = "playing";
  maps\_audio_code::set_hud_value("zone", var_0);
  var_3 = level._audio.zone.cached[var_0];

  if(isDefined(var_3["ambience"])) {
    if(var_3["ambience"] != "")
      set_ambient_track(var_3["ambience"], var_1);
    else
      stop_ambient_tracks(var_1);
  }

  if(isDefined(var_3["ambient_name"])) {
    if(var_3["ambient_name"] != "") {
      maps\_audio_code::set_hud_value("ambient_elem", var_3["ambient_name"]);
      maps\_audio_code::set_hud_name_percent_value("ambient_elem_from", "", "");
      maps\_audio_code::set_hud_name_percent_value("ambient_elem_to", "", "");
      maps\_audio_ambient::start_ambient_event_zone(var_3["ambient_name"]);
    } else {
      maps\_audio_code::set_hud_value("ambient_elem", "");
      maps\_audio_code::set_hud_name_percent_value("ambient_elem_from", "", "");
      maps\_audio_code::set_hud_name_percent_value("ambient_elem_to", "", "");
      maps\_audio_ambient::stop_current_ambient();
    }
  }

  if(isDefined(var_3["occlusion"])) {
    if(var_3["occlusion"] != "")
      set_occlusion(var_3["occlusion"]);
    else
      deactivate_occlusion();
  }

  if(isDefined(var_3["filter"])) {
    if(var_3["filter"] != "") {
      set_filter(var_3["filter"], 0);
      level.player seteqlerp(1, level._audio.filter.eq_index);
    }
  }

  if(isDefined(var_3["reverb"])) {
    if(var_3["reverb"] != "")
      set_reverb(var_3["reverb"]);
    else
      clear_reverb();
  }

  if(isDefined(var_3["mix"])) {
    if(var_3["mix"] != "")
      set_mix(var_3["mix"], var_1);
    else
      clear_mix();
  }
}

stop_zones(var_0) {
  if(!isDefined(var_0))
    var_0 = 1.0;

  maps\_audio_code::debug_println("ZONE STOP ALL");

  foreach(var_2 in level._audio.zone.cached)
  stop_zone(var_2["name"], var_0);
}

stop_zone(var_0, var_1) {
  if(isDefined(level._audio.zone.cached[var_0]) && isDefined(level._audio.zone.cached[var_0]["state"]) && level._audio.zone.cached[var_0]["state"] != "stopping") {
    if(!isDefined(var_1))
      var_1 = 1.0;

    var_2 = level._audio.zone.cached[var_0];
    maps\_audio_code::debug_println("ZONE STOP " + var_0);

    if(isDefined(var_2["ambience"]))
      stop_ambient_track(var_2["ambience"], var_1);

    if(isDefined(var_2["ambient_name"]))
      maps\_audio_ambient::stop_ambient_event_zone(var_2["ambient_name"]);

    level._audio.zone.cached[var_0]["state"] = "stopping";
  }
}

init_filter() {
  level._audio.filter = spawnStruct();
  level._audio.filter.eq_index = 0;
  level._audio.filter.current = [];
  level._audio.filter.current[0] = "";
  level._audio.filter.current[1] = "";
  level._audio.filter.previous = [];
  level._audio.filter.previous[0] = "";
  level._audio.filter.previous[1] = "";
}

set_filter(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  if(level._audio.filter.current[var_1] == var_0) {
    return;
  }
  if(isDefined(level._audio.in_deathsdoor)) {
    level._audio.deathsdoor.filter[var_1] = var_0;
    return;
  }

  if(level._audio.filter.current[var_1] != var_0) {
    maps\_audio_code::debug_println("filter DeactivateEq() index=" + var_1, 2);
    level.player deactivateeq(var_1);
  }

  set_current_filter(var_1, var_0);
  level.player seteqfromtable(maps\_audio_code::get_map_soundtable(), var_0, var_1);
}

set_current_filter(var_0, var_1) {
  if(var_1 == "deathsdoor") {
    return;
  }
  level._audio.filter.previous[var_0] = level._audio.filter.current[var_0];
  level._audio.filter.current[var_0] = var_1;
  maps\_audio_code::set_hud_name_percent_value("filter_" + var_0, var_1, "last");
}

clear_filter(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  set_current_filter(var_0, "");
  maps\_audio_code::debug_println("filter DeactivateEq() index=" + var_0, 2);
  level.player deactivateeq(var_0);
  maps\_audio_code::set_hud_name_percent_value("filter_" + var_0, "", "last");
}

init_occlusion() {
  level._audio.occlusion = spawnStruct();
  level._audio.occlusion.current = "";
  set_occlusion("default");
}

set_occlusion(var_0) {
  if(level._audio.occlusion.current == var_0) {
    return;
  }
  thread set_occlusion_thread(var_0);
}

set_occlusion_thread(var_0) {
  if(level._audio.occlusion.current == var_0) {
    return;
  }
  level._audio.occlusion.current = var_0;
  maps\_audio_code::debug_println("occlusion SetOcclusionFromTable() name=" + var_0, 2);
  maps\_audio_code::set_hud_value("occlusion", var_0);
  level.player setocclusionfromtable(maps\_audio_code::get_map_soundtable(), var_0);
}

deactivate_occlusion() {
  maps\_audio_code::debug_println("occlusion DeactivateAllOcclusion() ");
  level.player deactivateallocclusion();
}

init_reverb(var_0) {
  level._audio.reverb = spawnStruct();
  level._audio.reverb.current = "";
}

set_reverb(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(level._audio.reverb.current == var_0) {
    return;
  }
  if(isDefined(level._audio.in_deathsdoor) && var_0 != "deathsdoor") {
    level._audio.deathsdoor.reverb = var_0;
    return;
  }

  level._audio.reverb.current = var_0;
  maps\_audio_code::debug_println("reverb SetReverbFromTable(): name=" + var_0, 2);
  level.player setreverbfromtable(maps\_audio_code::get_map_soundtable(), var_0, "snd_enveffectsprio_level");
}

clear_reverb() {
  maps\_audio_code::debug_println("deactivatereverb");
  level.player deactivatereverb("snd_enveffectsprio_level", 2);
  level._audio.reverb.current = "";
  maps\_audio_code::set_hud_value("reverb", "");
}

init_mix() {
  level._audio.mix = spawnStruct();
  level._audio.mix.current = "";
  level._audio.mix.previous = "";
  set_mix("default");
}

set_mix(var_0, var_1) {
  if(level._audio.mix.current == var_0) {
    return;
  }
  change_mix(var_0, "default", var_1);
}

change_mix(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = "default";

  if(var_0 == var_1) {
    return;
  }
  if(isDefined(var_2))
    level.player setvolmodfromtable(maps\_audio_code::get_map_soundtable(), var_0, var_2);
  else
    level.player setvolmodfromtable(maps\_audio_code::get_map_soundtable(), var_0);

  maps\_audio_code::set_hud_value("mix", var_0);
  level._audio.mix.previous = level._audio.mix.current;
  level._audio.mix.current = var_0;
}

clear_mix(var_0) {
  if(level._audio.mix.current == "") {
    return;
  }
  if(!isDefined(var_0))
    var_0 = 1;

  change_mix("default", level._audio.mix.current);
}

init_whizby() {
  level._audio.whizby = spawnStruct();
  level._audio.whizby.current = "";
  thread set_whizby("default");
}

set_whizby(var_0) {
  if(level._audio.whizby.current == var_0) {
    return;
  }
  level._audio.whizby.current = var_0;
  level.player setwhizbyfromtable(maps\_audio_code::get_map_soundtable(), var_0);
}

init_timescale() {
  level._audio.timescale = spawnStruct();
  level._audio.timescale.current = "";
  set_timescale("default");
}

set_timescale(var_0) {
  if(level._audio.timescale.current == var_0) {
    return;
  }
  level._audio.timescale.current = var_0;
  level.player settimescalefactorfromtable(maps\_audio_code::get_map_soundtable(), var_0);
}