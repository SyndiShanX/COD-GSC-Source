/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\airlift_lighting.gsc
********************************/

main() {
  init_level_lighting_flags();
  level.cheat_invert_override = "_bright";
  thread play_flickering_light();
  thread setup_dof_presets();
  thread set_level_lighting_values();
  shadow_triggers_setup();
}

init_level_lighting_flags() {}

setup_dof_presets() {}

set_level_lighting_values() {
  maps\_utility::vision_set_fog_changes("airlift_intro", 0);
  level.player maps\_utility::set_light_set_player("airlift_Start");
  level.player setclutforplayer("clut_airlift", 0.0);
  setsaveddvar("fx_cast_shadow", 0);
}

apply_lighting_pass_airlift(var_0) {
  if(!isdefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "airlift":
      var_1 = 3;
      var_2 = "airlift";
      var_3 = "airlift";
      var_0 = "airlift";
      var_4 = "clut_airlift";
      break;
    case "airlift_cobra":
      var_1 = 3;
      var_2 = "airlift_cobra";
      var_3 = "airlift_cobra";
      var_0 = "airlift";
      var_4 = "clut_airlift";
      break;
    case "airlift_streets":
      var_1 = 3;
      var_2 = "airlift_streets";
      var_3 = "airlift_streets";
      var_0 = "airlift_streets";
      var_4 = "clut_airlift";
      break;
    case "airlift_escape":
      var_1 = 3;
      var_2 = "airlift_cobra";
      var_3 = "airlift_cobra";
      var_0 = "airlift";
      var_4 = "clut_airlift";
      break;
    case "airlift_streets_rescue":
      var_1 = 3;
      var_2 = "airlift_streets_rescue";
      var_3 = "airlift_streets_rescue";
      var_0 = "airlift_streets";
      var_4 = "clut_airlift";
      break;
    case "airlift_nuke":
      var_1 = 6.25;
      var_2 = "airlift_nuke";
      var_3 = "airlift_nuke";
      var_0 = "airlift_nuke";
      var_4 = "clut_airlift";
      break;
    case "airlift_nuke_flash":
      var_1 = 0.25;
      var_2 = "airlift_nuke_flash";
      var_3 = "airlift_nuke_flash";
      var_0 = "airlift_nuke_flash";
      var_4 = "clut_airlift";
      break;
    case "airlift_nuke_wavehit":
      var_1 = 10;
      var_2 = "airlift_nuke_wavehit";
      var_3 = "airlift_nuke_wavehit";
      var_0 = "airlift_nuke_wavehit";
      var_4 = "clut_airlift";
      break;
    default:
      var_1 = 3;
      var_2 = "airlift";
      var_3 = "airlift";
      var_0 = "airlift";
      var_4 = "clut_airlift";
      break;
  }

  maps\_utility::set_vision_set(var_2, var_1);
  maps\_utility::fog_set_changes(var_3, var_1);
  level.player maps\_utility::set_light_set_player(var_0);
  level.player setclutforplayer(var_4, var_1);
  level.current_light_set = var_0;
}

play_flickering_light() {
  thread maps\_lighting::model_flicker_preset("flicker_1", 0, 1500, 4000, undefined, undefined, 0.01, 0.4, 0.01, 0.04, undefined, undefined, 1500);
  thread maps\_lighting::model_flicker_preset("flicker_2", 0, 400, 2500, undefined, undefined, 0.03, 0.6, 0.01, 0.08, undefined, undefined, 1500);
  thread maps\_lighting::model_flicker_preset("flicker_3", 0, 1500, 1850, undefined, undefined, 0.03, 0.6, 0.01, 0.08, undefined, undefined, 1500);
  thread maps\_lighting::model_flicker_preset("flicker_4", 0, 1500, 2000, undefined, undefined, 0.03, 0.6, 0.01, 0.08, undefined, undefined, 1500);
}

shadow_triggers_setup() {
  var_0 = getentarray("turn_off_shadows", "targetname");
  var_1 = getentarray("shadow_trigger", "targetname");
  level.current_shadow = "on";
  common_scripts\utility::array_thread(var_1, ::shadow_trigger_think, var_0);
}

shadow_trigger_think(var_0) {
  for (;;) {
    self waittill("trigger");

    if(self.script_noteworthy != level.current_shadow) {
      var_1 = common_scripts\utility::ter_op(self.script_noteworthy == "on", "normal", "force_off");

      foreach(var_3 in var_0)
      var_3 setlightshadowstate(var_1);

      level.current_shadow = var_1;
    }
  }
}