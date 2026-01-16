/******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: soundscripts\_audio_reverb.gsc
******************************************/

rvb_init(var_0) {
  if(!isdefined(level._audio))
    level._audio = spawnstruct();

  level._audio.reverb = spawnstruct();
  level._audio.reverb.use_string_table_presets = 0;
  level._audio.reverb.current_reverb = "";
}

rvb_use_string_table() {
  level._audio.reverb.use_string_table_presets = 1;
}

rvb_set_dry_level(var_0, var_1) {
  var_1 = clamp(var_1, 0, 1.0);
  var_0.drylevel = var_1;
}

rvb_set_wet_level(var_0, var_1) {
  var_1 = clamp(var_1, 0, 1.0);
  var_0.wetlevel = var_1;
}

rvb_apply_reverb(var_0, var_1) {
  if(!isdefined(level._audio.reverb.applied_reverb) || level._audio.reverb.applied_reverb != var_0) {
    level._audio.reverb.applied_reverb = var_0;
    var_2 = undefined;

    if(isdefined(var_1))
      var_2 = var_1;
    else
      var_2 = var_0.fadetime;

    level.player setreverb(var_0.priority, var_0.roomtype, var_0.drylevel, var_0.wetlevel, var_2);
  }
}

rvb_start_preset(var_0, var_1) {
  if(isdefined(level.player.ent_flag) && isdefined(level.player.ent_flag["player_has_red_flashing_overlay"]) && level.player maps\_utility::ent_flag("player_has_red_flashing_overlay")) {
    if(isdefined(var_0) && var_0 != "none") {
      var_2 = rvbx_get_reverb_preset(var_0);

      if(!isdefined(var_2)) {
        soundscripts\_audio::aud_print_warning("Failed to load reverb preset: " + var_0);
        return;
      }

      if(var_0 != "deathsdoor") {
        rvbx_store_current_reverb_track(var_0, var_2);
        level._audio.deathsdoor.reverb = var_0;
      }
    } else {
      rvbx_store_current_reverb_track("none", undefined);
      level._audio.deathsdoor.reverb = "none";
    }

    return;
  }

  if((isdefined(var_0) && var_0 == "none" || !isdefined(var_0)) && isdefined(level._audio.current_reverb)) {
    level.player deactivatereverb("snd_enveffectsprio_level", 1);
    level._audio.current_reverb = undefined;
    level._audio.reverb.current_reverb = "";
    return;
  } else if(!isdefined(var_0) || isdefined(var_0) && var_0 == "none") {
    return;
  }
  var_2 = rvbx_get_reverb_preset(var_0);

  if(!isdefined(var_2)) {
    soundscripts\_audio::aud_print_warning("Failed to load reverb preset: " + var_0);
    return;
  }

  level._audio.current_reverb = var_0;

  if(var_0 != "deathsdoor")
    rvbx_store_current_reverb_track(var_0, var_2);

  if(level._audio.reverb.current_reverb != var_0) {
    level._audio.reverb.current_reverb = var_0;
    rvb_apply_reverb(var_2, var_1);
  }
}

rvbx_store_current_reverb_track(var_0, var_1) {
  if(var_0 != "deathsdoor") {
    level.reverb_track = var_0;

    if(var_0 == "none" && !isdefined(level.ambient_reverb["none"]))
      level.ambient_reverb["none"] = 1;
    else if(!isdefined(level.ambient_reverb[var_0])) {
      level.ambient_reverb[var_0] = [];
      level.ambient_reverb[var_0]["priority"] = "snd_enveffectsprio_level";
      level.ambient_reverb[var_0]["roomtype"] = var_1.roomtype;
      level.ambient_reverb[var_0]["drylevel"] = var_1.drylevel;
      level.ambient_reverb[var_0]["wetlevel"] = var_1.wetlevel;
      level.ambient_reverb[var_0]["fadetime"] = var_1.fadetime;
    }
  }
}

rvb_deactive_reverb() {
  level.reverb_track = "";
  level.player deactivatereverb("snd_enveffectsprio_level", 2);
  level._audio.current_reverb = undefined;
  level._audio.reverb.current_reverb = "";
}

rvb_get_applied_reverb() {
  var_0 = undefined;

  if(isdefined(level._audio.reverb.applied_reverb))
    var_0 = level._audio.reverb.applied_reverb;

  return var_0;
}

rvbx_get_preset_from_string_table(var_0, var_1) {
  var_2 = soundscripts\_audio::get_reverb_stringtable();
  var_3 = "soundtables\sp_defaults.csv";
  var_4 = [];

  if(var_1)
    var_4 = rvbx_get_reverb_preset_from_stringtable_internal(var_2, var_0);

  if(!isdefined(var_4) || var_4.size == 0)
    var_4 = rvbx_get_reverb_preset_from_stringtable_internal(var_3, var_0);

  if(!isdefined(var_4) || var_4.size == 0) {
    return;
  }
  return var_4;
}

rvbx_get_reverb_preset_from_stringtable_internal(var_0, var_1) {
  var_2 = [];
  var_3 = "";
  var_4 = "";
  var_5 = packedtablesectionlookup(var_0, "reverb_names", "zone_names;reverb_names;filter_names;occlusion_names;timescale_names;dynamic_ambience_names;components;loop_defs;whizby_preset_names;mix_names;healthfx_params");

  if(isdefined(var_5)) {
    var_6 = 6;

    for (var_7 = 1; var_7 < var_6; var_7++) {
      var_3 = packedtablelookupwithrange(var_0, 0, "reverb_names", var_7, var_5[0], var_5[1]);
      var_4 = packedtablelookupwithrange(var_0, 0, var_1, var_7, var_5[0], var_5[1]);

      if(var_3 != "comments" && var_4 != "") {
        if(var_3 != "roomtype") {
          var_2[var_3] = float(var_4);
          continue;
        }

        var_2[var_3] = var_4;
      }
    }

    return var_2;
  }
}

rvbx_apply_inital_reverb() {
  while (!isdefined(level.player))
    wait 0.5;

  rvb_apply_reverb(level._audio.reverb.default_reverb);
}

rvbx_get_reverb_preset(var_0) {
  if(!isdefined(level._audio.reverb.preset_cache))
    level._audio.reverb.preset_cache = [];

  var_1 = rvbx_create();
  var_2 = [];

  if(isdefined(level._audio.level_audio_reverb_function))
    var_2 = [
      [level._audio.level_audio_reverb_function]
    ](var_0, var_2);
  else if(isdefined(level._audio.reverb.preset_cache[var_0]))
    var_2 = level._audio.reverb.preset_cache[var_0];
  else if(level._audio.reverb.use_string_table_presets) {
    var_2 = rvbx_get_preset_from_string_table(var_0, 1);

    if(!isdefined(var_2)) {
      return;
    }
    level._audio.reverb.preset_cache[var_0] = var_2;
  } else {
    var_2 = rvbx_get_preset_from_string_table(var_0, 0);

    if(!isdefined(var_2)) {
      return;
    }
    level._audio.reverb.preset_cache[var_0] = var_2;
  }

  var_1.name = var_0;
  var_1.roomtype = var_2["roomtype"];
  var_1.drylevel = var_2["drylevel"];
  var_1.wetlevel = var_2["wetlevel"];
  var_1.fadetime = var_2["fadetime"];
  return var_1;
}

rvbx_create() {
  var_0 = spawnstruct();
  var_0.roomtype = "generic";
  var_0.drylevel = 1.0;
  var_0.wetlevel = 0.5;
  var_0.fadetime = 0;
  var_0.priority = "snd_enveffectsprio_level";
  return var_0;
}