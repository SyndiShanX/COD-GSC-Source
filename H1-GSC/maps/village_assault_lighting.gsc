/*********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\village_assault_lighting.gsc
*********************************************/

main() {
  init_level_lighting_flags();
  level.cheat_highcontrast_override = "_night";
  thread setup_dof_presets();
  thread set_level_lighting_values();
  thread setup_flickerlight_motion_presets();
  thread maps\_lighting::play_flickerlight_motion_preset("firelight_motion_06", "heli_fire_01");
  thread maps\_lighting::play_flickerlight_motion_preset("firelight_motion_05", "gas_station_flicker_01");
  level.default_clut = "clut_village_assault";
  level.default_lightset = "village_assault";
  level.default_visionset = "village_assault";
  level.nightvisionlightset = "village_assault_nightvision";
  visionsetnight("village_assault_nightvision");
}

init_level_lighting_flags() {}

setup_dof_presets() {}

set_level_lighting_values() {
  setsaveddvar("sm_minSpotLightScore", "0.0001");
  setsaveddvar("r_specularColorScale", "4.5");
  maps\_utility::vision_set_fog_changes("village_assault", 0);
  level.player maps\_utility::set_light_set_player("village_assault");
  level.player setclutforplayer("clut_village_assault", 0.0);
}

setup_flickerlight_motion_presets() {
  maps\_lighting::create_flickerlight_motion_preset("firelight_motion_05", (0.8, 0.6, 0.4), 1200, 20, 0.2, 0.8);
  maps\_lighting::create_flickerlight_motion_preset("firelight_motion_06", (0.9, 0.6, 0.3), 1200, 20, 0.1, 0.8);
}

goblack(var_0, var_1, var_2) {
  var_3 = newhudelem();
  var_3.x = 0;
  var_3.y = 0;
  var_3.alignx = "left";
  var_3.aligny = "top";
  var_3.horzalign = "fullscreen";
  var_3.vertalign = "fullscreen";
  var_3 setshader("black", 640, 480);
  var_3.sort = 1;
  var_3.alpha = 0;

  if(var_1 > 0)
    var_3 fadeovertime(var_1);

  var_3.alpha = 1.0;
  wait(var_1);

  if(!isdefined(var_0)) {
    return;
  }
  wait(var_0);
  level notify("fade_from_black");
  wait 0.1;

  if(var_2 > 0)
    var_3 fadeovertime(var_2);

  var_3.alpha = 0.0;
  wait(var_2);
  var_3 destroy();
}