/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\267.gsc
**************************************/

main() {
  if(!isDefined(level.global_fx)) {
    level.global_fx = [];

  }
  level._id_1BF8 = [];
  var_0 = randomfloatrange(-20, -15);
  global_fx("barrel_fireFX_origin", "global_barrel_fire", "fire/firelp_barrel_pm", var_0, "fire_barrel_small");
  global_fx("ch_streetlight_02_FX_origin", "ch_streetlight_02_FX", "misc/lighthaze", var_0);
  global_fx("me_streetlight_01_FX_origin", "me_streetlight_01_FX", "misc/lighthaze_bog_a", var_0);
  global_fx("ch_street_light_01_on", "lamp_glow_FX", "misc/lighthaze", var_0);
  global_fx("com_wall_streetlamp_on", "com_wall_streetlamp_on_FX", "misc/light_glow_white_dim", var_0);
  global_fx("lamp_post_globe_on", "lamp_glow_FX", "misc/light_glow_white", var_0);
  global_fx("highway_lamp_post", "ch_streetlight_02_FX", "misc/lighthaze_villassault", var_0);
  global_fx("cs_cargoship_spotlight_on_FX_origin", "cs_cargoship_spotlight_on_FX", "misc/lighthaze", var_0);
  global_fx("me_dumpster_fire_FX_origin", "me_dumpster_fire_FX", "fire/firelp_med_pm", var_0, "fire_dumpster_medium");
  global_fx("com_tires_burning01_FX_origin", "com_tires_burning01_FX", "fire/tire_fire_med", var_0);
  global_fx("icbm_powerlinetower_FX_origin", "icbm_powerlinetower_FX", "misc/power_tower_light_red_blink", var_0);
  global_fx("icbm_mainframe_FX_origin", "icbm_mainframe_FX", "props/icbm_mainframe_lightblink", var_0);
  global_fx("light_pulse_red_FX_origin", "light_pulse_red_FX", "misc/light_glow_red_generic_pulse", -2);
  global_fx("light_pulse_red_FX_origin", "light_pulse_red_FX", "misc/light_glow_red_generic_pulse", -2);
  global_fx("light_pulse_orange_FX_origin", "light_pulse_orange_FX", "misc/light_glow_orange_generic_pulse", -2);
  global_fx("light_red_blink_FX_origin", "light_red_blink", "misc/power_tower_light_red_blink", -2);
  global_fx("lighthaze_oilrig_FX_origin", "lighthaze_oilrig", "misc/lighthaze_oilrig", var_0);
  global_fx("lighthaze_white_FX_origin", "lighthaze_white", "misc/lighthaze_white", var_0);
  global_fx("light_glow_walllight_white_FX_origin", "light_glow_walllight_white", "misc/light_glow_walllight_white", var_0);
  global_fx("fluorescent_glow_FX_origin", "fluorescent_glow", "misc/fluorescent_glow", var_0);
  global_fx("light_glow_industrial_FX_origin", "light_glow_industrial", "misc/light_glow_industrial", var_0);
  global_fx("light_red_steady_FX_origin", "light_red_steady", "misc/tower_light_red_steady", -2);
  global_fx("light_blue_steady_FX_origin", "light_blue_steady", "misc/tower_light_blue_steady", -2);
  global_fx("light_orange_steady_FX_origin", "light_orange_steady", "misc/tower_light_orange_steady", -2);
  global_fx("glow_stick_pile_FX_origin", "glow_stick_pile", "misc/glow_stick_glow_pile", -2);
  global_fx("highrise_blinky_tower", "highrise_blinky_tower_FX", "misc/power_tower_light_red_blink_large", var_0, undefined, 1.5);
  global_fx("flare_ambient_FX_origin", "flare_ambient_FX", "misc/flare_ambient", var_0, "emt_road_flare_burn", 1.5);
  global_fx("light_glow_white_bulb_FX_origin", "light_glow_white_bulb_FX", "misc/light_glow_white_bulb", var_0);
  global_fx("light_glow_white_lamp_FX_origin", "light_glow_white_lamp_FX", "misc/light_glow_white_lamp", var_0);
}

global_fx(var_0, var_1, var_2, var_3, var_4, var_5) {
  level.global_fx[var_0] = var_1;
  var_6 = maps\_utility::_id_1BF9(var_0, "targetname");

  if(!isDefined(var_6)) {
    return;
  }
  if(var_6.size <= 0) {
    return;
  }
  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    var_8 = var_6[var_7] global_fx_create(var_1, var_2, var_3, var_4, var_5);

    if(!isDefined(var_6[var_7].script_noteworthy)) {
      continue;
    }
    var_9 = var_6[var_7].script_noteworthy;

    if(!isDefined(level._id_1BF8[var_9])) {
      level._id_1BF8[var_9] = [];

    }
    level._id_1BF8[var_9][level._id_1BF8[var_9].size] = var_8;
  }
}

global_fx_create(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._effect)) {
    level._effect = [];

  }
  if(!isDefined(level._effect[var_0])) {
    level._effect[var_0] = loadfx(var_1);

  }
  if(isDefined(var_4)) {
    var_2 = var_2 + randomfloat(var_4);

  }
  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);

  }
  var_5 = common_scripts\utility::createoneshoteffect(var_0);
  var_5.v["origin"] = self.origin;
  var_5.v["angles"] = self.angles;
  var_5.v["fxid"] = var_0;
  var_5.v["delay"] = var_2;

  if(isDefined(var_3)) {
    var_5.v["soundalias"] = var_3;

  }
  return var_5;
}