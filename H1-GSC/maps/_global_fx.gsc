/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_global_fx.gsc
********************************/

main() {
  maps\_global_fx_code::global_fx("ch_streetlight_02_FX_origin", "fx\misc\lighthaze");
  maps\_global_fx_code::global_fx("me_streetlight_01_FX_origin", "fx\misc\lighthaze_bog_a");
  maps\_global_fx_code::global_fx("ch_street_light_01_on", "fx\misc\lighthaze");
  maps\_global_fx_code::global_fx("com_wall_streetlamp_on", "fx\misc\light_glow_white_dim");
  maps\_global_fx_code::global_fx("lamp_post_globe_on", "fx\misc\light_glow_white");
  maps\_global_fx_code::global_fx("highway_lamp_post", "fx\misc\lighthaze_villassault");
  maps\_global_fx_code::global_fx("cs_cargoship_spotlight_on_FX_origin", "fx\misc\lighthaze");
  maps\_global_fx_code::global_fx("com_tires_burning01_FX_origin", "fx\fire\tire_fire_med");
  maps\_global_fx_code::global_fx("icbm_powerlinetower_FX_origin", "fx\misc\power_tower_light_red_blink");
  maps\_global_fx_code::global_fx("icbm_mainframe_FX_origin", "fx\props\icbm_mainframe_lightblink");
  maps\_global_fx_code::global_fx("lighthaze_oilrig_FX_origin", "fx\misc\lighthaze_oilrig");
  maps\_global_fx_code::global_fx("lighthaze_white_FX_origin", "fx\misc\lighthaze_white");
  maps\_global_fx_code::global_fx("light_glow_walllight_white_FX_origin", "fx\misc\light_glow_walllight_white");
  maps\_global_fx_code::global_fx("fluorescent_glow_FX_origin", "fx\misc\fluorescent_glow");
  maps\_global_fx_code::global_fx("light_glow_industrial_FX_origin", "fx\misc\light_glow_industrial");
  maps\_global_fx_code::global_fx("light_glow_white_bulb_FX_origin", "fx\misc\light_glow_white_bulb");
  maps\_global_fx_code::global_fx("light_glow_white_lamp_FX_origin", "fx\misc\light_glow_white_lamp");
  maps\_global_fx_code::global_fx("highrise_blinky_tower", "fx\misc\power_tower_light_red_blink_large");
  maps\_global_fx_code::global_fx("light_red_steady_FX_origin", "fx\misc\tower_light_red_steady", -2);
  maps\_global_fx_code::global_fx("light_blue_steady_FX_origin", "fx\misc\tower_light_blue_steady", -2);
  maps\_global_fx_code::global_fx("light_orange_steady_FX_origin", "fx\misc\tower_light_orange_steady", -2);
  maps\_global_fx_code::global_fx("glow_stick_pile_FX_origin", "fx\misc\glow_stick_glow_pile", -2);
  maps\_global_fx_code::global_fx("light_pulse_red_FX_origin", "fx\misc\light_glow_red_generic_pulse", -2);
  maps\_global_fx_code::global_fx("light_pulse_red_FX_origin", "fx\misc\light_glow_red_generic_pulse", -2);
  maps\_global_fx_code::global_fx("light_pulse_orange_FX_origin", "fx\misc\light_glow_orange_generic_pulse", -2);
  maps\_global_fx_code::global_fx("light_red_blink_FX_origin", "fx\misc\power_tower_light_red_blink", -2);
  maps\_global_fx_code::global_fx("flare_ambient_FX_origin", "fx\misc\flare_ambient", undefined, undefined, "emt_road_flare_burn");
  maps\_global_fx_code::global_fx("me_dumpster_fire_FX_origin", "fx\fire\firelp_med_pm", undefined, undefined, "fire_dumpster_medium");
  maps\_global_fx_code::global_fx("barrel_fireFX_origin", "fx\fire\firelp_barrel_pm", undefined, undefined, "fire_barrel_small");
  maps\_global_fx_code::global_fx("cnd_laptop_001_open_on_FX_origin", "vfx\ambient\props\laptop_dust");
  maps\_global_fx_code::global_fx("cnd_glowstick_FX_origin", "fx\misc\glow_stick_glow_orange");
}

override_global_fx(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5["targetname"] = var_0;
  var_5["fxFile"] = var_1;
  var_5["delay"] = var_2;
  var_5["fxName"] = var_3;
  var_5["soundalias"] = var_4;
  level.global_fx_override[var_0] = var_5;
}

set_custom_global_fx(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5["targetname"] = var_0;
  var_5["fxFile"] = var_1;
  var_5["delay"] = var_2;
  var_5["fxName"] = var_3;
  var_5["soundalias"] = var_4;
  level.global_fx_custom[var_0] = var_5;
}

create_custom_global_fx() {
  if(!isdefined(level.global_fx_custom)) {
    return;
  }
  foreach(var_1 in level.global_fx_custom) {
    var_2 = var_1["targetname"];
    var_3 = var_1["fxFile"];
    var_4 = var_1["delay"];
    var_5 = var_1["fxName"];
    var_6 = var_1["soundalias"];
    maps\_global_fx_code::global_fx(var_2, var_3, var_4, var_5, var_6);
  }
}