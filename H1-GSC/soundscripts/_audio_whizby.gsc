/******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: soundscripts\_audio_whizby.gsc
******************************************/

whiz_init() {
  level._audio.whiz = spawnstruct();
  level._audio.whiz.use_string_table_presets = 0;
}

whiz_use_string_table() {
  level._audio.whiz.use_string_table_presets = 1;
}

whiz_set_preset(var_0) {
  var_1 = [];
  var_1 = whizx_get_stringtable_preset(var_0);
  var_1["name"] = var_0;
  var_2 = var_1["probability"];
  var_3 = var_1["spread"];
  var_4 = var_1["radius"];
  var_5 = var_1["offset"];
  level.player setwhizbyprobabilities(var_2[0], var_2[1], var_2[2]);
  level.player setwhizbyspreads(var_3[0], var_3[1], var_3[2]);
  level.player setwhizbyradii(var_4[0], var_4[1], var_4[2]);
  level.player setwhizbyoffset(var_5);
}

whiz_set_probabilities(var_0, var_1, var_2) {
  level.player setwhizbyprobabilities(var_0, var_1, var_2);
}

whiz_set_spreads(var_0, var_1, var_2) {
  level.player setwhizbyspreads(var_0, var_1, var_2);
}

whiz_set_radii(var_0, var_1, var_2) {
  level.player setwhizbyradii(var_0, var_1, var_2);
}

whiz_set_offset(var_0) {
  level.player setwhizbyoffset(var_0);
}

whizx_get_stringtable_preset(var_0) {
  var_1 = "soundtables\sp_defaults.csv";
  var_2 = [];
  var_2 = whizx_get_mix_preset_from_stringtable_internal(var_1, var_0);
  return var_2;
}

whizx_get_mix_preset_from_stringtable_internal(var_0, var_1) {
  var_2 = [];
  var_3 = "";
  var_4 = "";
  var_5 = 12;
  var_6 = [];
  var_7 = [];
  var_8 = [];
  var_9 = 0;
  var_10 = 0;
  var_11 = packedtablesectionlookup(var_0, "whizby_preset_names", "zone_names;reverb_names;filter_names;occlusion_names;timescale_names;dynamic_ambience_names;components;loop_defs;whizby_preset_names;mix_names;healthfx_params");

  if(isdefined(var_11)) {
    for (var_12 = 1; var_12 < var_5; var_12++) {
      var_3 = packedtablelookupwithrange(var_0, 0, "whizby_preset_names", var_12, var_11[0], var_11[1]);
      var_4 = packedtablelookupwithrange(var_0, 0, var_1, var_12, var_11[0], var_11[1]);

      if(!isdefined(var_4)) {
        break;
      }

      if(var_4 != "" && var_4 != "comments") {
        var_10++;

        switch (var_3) {
          case "radius_offset":
            var_9 = float(var_4);
            break;
          case "near_radius":
            var_6[0] = float(var_4);
            break;
          case "medium_radius":
            var_6[1] = float(var_4);
            break;
          case "far_radius":
            var_6[2] = float(var_4);
            break;
          case "near_spread":
            var_7[0] = float(var_4);
            break;
          case "medium_spread":
            var_7[1] = float(var_4);
            break;
          case "far_spread":
            var_7[2] = float(var_4);
            break;
          case "near_prob":
            var_8[0] = float(var_4);
            break;
          case "medium_prob":
            var_8[1] = float(var_4);
            break;
          case "far_prob":
            var_8[2] = float(var_4);
            break;
        }
      }
    }

    if(var_10 > 0) {
      var_2["radius"] = var_6;
      var_2["spread"] = var_7;
      var_2["probability"] = var_8;

      if(isdefined(var_9))
        var_2["offset"] = var_9;
    }

    return var_2;
  }
}