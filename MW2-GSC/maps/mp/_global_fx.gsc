/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\mp\_global_fx.gsc
********************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

randomStartDelay = randomfloatrange(-20, -15);
global_FX("barrel_fireFX_origin", "global_barrel_fire", "fire/firelp_barrel_pm", randomStartDelay, "fire_barrel_small");
global_FX("ch_streetlight_02_FX_origin", "ch_streetlight_02_FX", "misc/lighthaze", randomStartDelay);
global_FX("me_streetlight_01_FX_origin", "me_streetlight_01_FX", "misc/lighthaze_bog_a", randomStartDelay);
global_FX("ch_street_light_01_on", "lamp_glow_FX", "misc/light_glow_white", randomStartDelay);
global_FX("lamp_post_globe_on", "lamp_glow_FX", "misc/light_glow_white", randomStartDelay);
global_FX("highway_lamp_post", "ch_streetlight_02_FX", "misc/lighthaze_villassault", randomStartDelay);
global_FX("cs_cargoship_spotlight_on_FX_origin", "cs_cargoship_spotlight_on_FX", "misc/lighthaze", randomStartDelay);
global_FX("me_dumpster_fire_FX_origin", "me_dumpster_fire_FX", "fire/firelp_med_pm", randomStartDelay, "fire_dumpster_medium");
global_FX("com_tires_burning01_FX_origin", "com_tires_burning01_FX", "fire/tire_fire_med", randomStartDelay);
global_FX("icbm_powerlinetower_FX_origin", "icbm_powerlinetower_FX", "misc/power_tower_light_red_blink", randomStartDelay);
global_FX("icbm_mainframe_FX_origin", "icbm_mainframe_FX", "props/icbm_mainframe_lightblink", randomStartDelay);
global_FX("light_pulse_red_FX_origin", "light_pulse_red_FX", "misc/light_glow_red_generic_pulse", -2);
global_FX("light_pulse_red_FX_origin", "light_pulse_red_FX", "misc/light_glow_red_generic_pulse", -2);
global_FX("light_pulse_orange_FX_origin", "light_pulse_orange_FX", "misc/light_glow_orange_generic_pulse", -2);
global_FX("light_red_blink_FX_origin", "light_red_blink", "misc/power_tower_light_red_blink", -2);
global_FX("lighthaze_oilrig_FX_origin", "lighthaze_oilrig", "misc/lighthaze_oilrig", randomStartDelay);
global_FX("lighthaze_white_FX_origin", "lighthaze_white", "misc/lighthaze_white", randomStartDelay);
global_FX("light_glow_walllight_white_FX_origin", "light_glow_walllight_white", "misc/light_glow_walllight_white", randomStartDelay);
global_FX("fluorescent_glow_FX_origin", "fluorescent_glow", "misc/fluorescent_glow", randomStartDelay);
global_FX("light_glow_industrial_FX_origin", "light_glow_industrial", "misc/light_glow_industrial", randomStartDelay);
global_FX("light_red_steady_FX_origin", "light_red_steady", "misc/tower_light_red_steady", -2);
global_FX("light_blue_steady_FX_origin", "light_blue_steady", "misc/tower_light_blue_steady", -2);
global_FX("light_orange_steady_FX_origin", "light_orange_steady", "misc/tower_light_orange_steady", -2);
global_FX("glow_stick_pile_FX_origin", "glow_stick_pile", "misc/glow_stick_glow_pile", -2);
global_FX("glow_stick_orange_pile_FX_origin", "glow_stick_pile_orange", "misc/glow_stick_glow_pile_orange", -2);
global_FX("highrise_blinky_tower", "highrise_blinky_tower_FX", "misc/power_tower_light_red_blink_large", randomStartDelay);
global_FX("flare_ambient_FX_origin", "flare_ambient_FX", "misc/flare_ambient", randomStartDelay, "emt_road_flare_burn");
global_FX("light_glow_white_bulb_FX_origin", "light_glow_white_bulb_FX", "misc/light_glow_white_bulb", randomStartDelay);
global_FX("light_glow_white_lamp_FX_origin", "light_glow_white_lamp_FX", "misc/light_glow_white_lamp", randomStartDelay);
}

global_FX(targetname, fxName, fxFile, delay, soundalias) {
  ents = getStructArray(targetname, "targetname");
  if(!isDefined(ents))
    return;
  if(ents.size <= 0) {
    return;
  }
  for(i = 0; i < ents.size; i++)
    ents[i] global_FX_create(fxName, fxFile, delay, soundalias);
}

global_FX_create(fxName, fxFile, delay, soundalias) {
  if(!isDefined(level._effect))
    level._effect = [];
  if(!isDefined(level._effect[fxName]))
    level._effect[fxName] = loadfx(fxFile);

  if(!isDefined(self.angles))
    self.angles = (0, 0, 0);

  ent = createOneshotEffect(fxName);
  ent.v["origin"] = (self.origin);
  ent.v["angles"] = (self.angles);
  ent.v["fxid"] = fxName;
  ent.v["delay"] = delay;
  if(isDefined(soundalias)) {
    ent.v["soundalias"] = soundalias;
  }
}