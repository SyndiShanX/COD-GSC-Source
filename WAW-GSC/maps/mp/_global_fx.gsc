/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_global_fx.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

main() {
  randomStartDelay = randomfloatrange(-20, -15);
  global_FX("barrel_fireFX_origin", "global_barrel_fire", "fire/firelp_barrel_pm", randomStartDelay, "fire_barrel_small");
  global_FX("ch_streetlight_02_FX_origin", "ch_streetlight_02_FX", "misc/lighthaze", randomStartDelay);
  global_FX("me_streetlight_01_FX_origin", "me_streetlight_01_FX", "misc/lighthaze_bog_a", randomStartDelay);
  global_FX("ch_street_light_01_on", "lamp_glow_FX", "misc/light_glow_white", randomStartDelay);
  global_FX("highway_lamp_post", "ch_streetlight_02_FX", "misc/lighthaze_villassault", randomStartDelay);
  global_FX("cs_cargoship_spotlight_on_FX_origin", "cs_cargoship_spotlight_on_FX", "misc/lighthaze", randomStartDelay);
  global_FX("me_dumpster_fire_FX_origin", "me_dumpster_fire_FX", "fire/firelp_med_pm_nodistort", randomStartDelay, "fire_dumpster_medium");
  global_FX("com_tires_burning01_FX_origin", "com_tires_burning01_FX", "fire/tire_fire_med", randomStartDelay);
  global_FX("icbm_powerlinetower_FX_origin", "icbm_powerlinetower_FX", "misc/power_tower_light_red_blink", randomStartDelay);
}

global_FX(targetname, fxName, fxFile, delay, soundalias) {
  ents = getstructarray(targetname, "targetname");
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