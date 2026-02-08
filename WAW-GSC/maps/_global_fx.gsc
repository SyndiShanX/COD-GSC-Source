/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_global_fx.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;

main() {
  level._global_fx_ents = [];
  randomStartDelay = randomfloatrange(-20, -15);

  global_FX("rustic_hanging_fx_point", "rustic_hanging_global", "env/light/fx_lights_rustic", randomStartDelay, "fx_lights_rustic_flame");

  global_FX("candle_flame_fx_point", "candle_flame_global", "env/light/fx_lights_candle_flame", randomStartDelay);

  global_FX("lantern_light_fx_point", "lantern_on_global", "env/light/fx_lights_lantern_on", randomStartDelay);

  global_FX("barrel_fireFX_origin", "global_barrel_fire", "fire/firelp_barrel_pm", randomStartDelay, "fire_barrel_small");

  global_FX("ch_streetlight_02_FX_origin", "ch_streetlight_02_FX", "misc/lighthaze", randomStartDelay);

  global_FX("me_streetlight_01_FX_origin", "me_streetlight_01_FX", "misc/lighthaze_bog_a", randomStartDelay);

  global_FX("ch_street_light_01_on", "lamp_glow_FX", "misc/light_glow_white", randomStartDelay);

  global_FX("highway_lamp_post", "ch_streetlight_02_FX", "misc/lighthaze_villassault", randomStartDelay);

  global_FX("cs_cargoship_spotlight_on_FX_origin", "cs_cargoship_spotlight_on_FX", "misc/lighthaze", randomStartDelay);

  global_FX("me_dumpster_fire_FX_origin", "me_dumpster_fire_FX", "fire/firelp_med_pm", randomStartDelay, "fire_dumpster_medium");

  global_FX("com_tires_burning01_FX_origin", "com_tires_burning01_FX", "fire/tire_fire_med", randomStartDelay);

  global_FX("icbm_powerlinetower_FX_origin", "icbm_powerlinetower_FX", "misc/power_tower_light_red_blink", randomStartDelay);

  global_FX("icbm_mainframe_FX_origin", "icbm_mainframe_FX", "props/icbm_mainframe_lightblink", randomStartDelay);

  global_FX("light_pulse_red_FX_origin", "light_pulse_red_FX", "misc/light_glow_red_generic_pulse", -2);

  global_FX("light_pulse_red_FX_origin", "light_pulse_red_FX", "misc/light_glow_red_generic_pulse", -2);

  global_FX("light_pulse_orange_FX_origin", "light_pulse_orange_FX", "misc/light_glow_orange_generic_pulse", -2);
}

global_FX(targetname, fxName, fxFile, delay, soundalias) {
  ents = getstructarray(targetname, "targetname");
  if(!isDefined(ents))
    return;
  if(ents.size <= 0) {
    return;
  }
  for(i = 0; i < ents.size; i++) {
    ent = ents[i] global_FX_create(fxName, fxFile, delay, soundalias);
    if(!isDefined(ents[i].script_noteworthy)) {
      continue;
    }
    note = ents[i].script_noteworthy;
    if(!isDefined(level._global_fx_ents[note])) {
      level._global_fx_ents[note] = [];
    }

    level._global_fx_ents[note][level._global_fx_ents[note].size] = ent;
  }
}

global_FX_create(fxName, fxFile, delay, soundalias) {
  if(!isDefined(level._effect))
    level._effect = [];
  if(!isDefined(level._effect[fxName]))
    level._effect[fxName] = loadfx(fxFile);

  if(!isDefined(self.angles))
    self.angles = (0, 0, 0);

  if(!level.clientscripts) {
    ent = createOneshotEffect(fxName);
    ent.v["origin"] = (self.origin);
    ent.v["angles"] = (self.angles);
    ent.v["fxid"] = fxName;
    ent.v["delay"] = delay;
    if(isDefined(soundalias)) {
      ent.v["soundalias"] = soundalias;
    }
    return ent;
  }
}