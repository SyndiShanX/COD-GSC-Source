/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\bog_a_lighting.gsc
********************************/

main() {
  init_level_lighting_flags();
  thread setup_dof_presets();
  thread set_level_lighting_values();
  level.cheat_highcontrast_override = "_night";
  enableouterspacemodellighting((10000, 10000, 10000), (0.001, 0.001, 0.001));
  thread setup_flickerlight_motion_presets();
  thread maps\_lighting::play_flickerlight_motion_preset("firelight_motion_dim_01", "firelight_dim_01");
  thread maps\_lighting::play_flickerlight_motion_preset("firelight_motion_dim_02", "firelight_dim_02");
  thread maps\_lighting::play_flickerlight_motion_preset("firelight_motion_medium_01", "firelight_medium_01");
  thread maps\_lighting::play_flickerlight_motion_preset("firelight_motion_medium_02", "firelight_medium_02");
  thread maps\_lighting::play_flickerlight_motion_preset("firelight_motion_bright_01", "firelight_bright_01");
  thread maps\_lighting::play_flickerlight_motion_preset("firelight_motion_bright_02", "firelight_bright_02");
  thread maps\_lighting::play_flickerlight_motion_preset("firelight_motion_verybright_01", "firelight_verybright_01");
  thread maps\_lighting::play_flickerlight_motion_preset("firelight_motion_ridonculous_01", "firelight_ridonculous_01");
  level.nightvisionlightset = "nightvision_bog_a";
  visionsetnight("bog_a_nightvision");
  setsaveddvar("sm_cacheSunShadowEnabled", 0);
  setsaveddvar("r_useSunShadowPortals", 1);
}

init_level_lighting_flags() {}

setup_dof_presets() {}

set_level_lighting_values() {
  setsaveddvar("sm_minSpotLightScore", "0.0001");
  maps\_utility::vision_set_fog_changes("bog_a", 0);
  level.player maps\_utility::set_light_set_player("bog_a");
  level.player setclutforplayer("clut_bog_a", 0.0);
}

setup_flickerlight_motion_presets() {
  maps\_lighting::create_flickerlight_motion_preset("firelight_motion_dim_01", (0.86, 0.5, 0.15), 10, 12, 0.15, 0.75);
  maps\_lighting::create_flickerlight_motion_preset("firelight_motion_dim_02", (0.86, 0.5, 0.15), 13, 12, 0.15, 0.75);
  maps\_lighting::create_flickerlight_motion_preset("firelight_motion_medium_01", (0.86, 0.5, 0.15), 35, 12, 0.15, 0.75);
  maps\_lighting::create_flickerlight_motion_preset("firelight_motion_medium_02", (0.86, 0.5, 0.15), 35, 12, 0.15, 0.75);
  maps\_lighting::create_flickerlight_motion_preset("firelight_motion_bright_01", (0.86, 0.5, 0.15), 80, 20, 0.2, 1.0);
  maps\_lighting::create_flickerlight_motion_preset("firelight_motion_bright_02", (0.86, 0.5, 0.15), 80, 20, 0.2, 1.0);
  maps\_lighting::create_flickerlight_motion_preset("firelight_motion_verybright_01", (0.86, 0.5, 0.15), 200, 30, 0.6, 1.5);
  maps\_lighting::create_flickerlight_motion_preset("firelight_motion_ridonculous_01", (0.86, 0.5, 0.15), 4000, 40, 1, 2.5);
}