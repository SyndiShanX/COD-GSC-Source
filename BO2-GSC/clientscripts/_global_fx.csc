/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_global_fx.csc
****************************************/

#include clientscripts\_utility;
#include clientscripts\_fx;

main() {
  level._global_fx_ents = [];
  randomstartdelay = randomfloatrange(-20, -15);
  global_fx("rustic_hanging_fx_point", "rustic_hanging_global", "env/light/fx_lights_rustic", randomstartdelay, "fx_lights_rustic_flame");
  global_fx("candle_flame_fx_point", "candle_flame_global", "env/light/fx_lights_candle_flame", randomstartdelay);
  global_fx("lantern_light_fx_point", "lantern_on_global", "env/light/fx_lights_lantern_on", randomstartdelay);
  global_fx("barrel_fireFX_origin", "global_barrel_fire", "fire/firelp_barrel_pm", randomstartdelay, "fire_barrel_small");
  global_fx("ch_streetlight_02_FX_origin", "ch_streetlight_02_FX", "misc/lighthaze", randomstartdelay);
  global_fx("me_streetlight_01_FX_origin", "me_streetlight_01_FX", "misc/lighthaze_bog_a", randomstartdelay);
  global_fx("ch_street_light_01_on", "lamp_glow_FX", "misc/light_glow_white", randomstartdelay);
  global_fx("highway_lamp_post", "ch_streetlight_02_FX", "misc/lighthaze_villassault", randomstartdelay);
  global_fx("cs_cargoship_spotlight_on_FX_origin", "cs_cargoship_spotlight_on_FX", "misc/lighthaze", randomstartdelay);
  global_fx("me_dumpster_fire_FX_origin", "me_dumpster_fire_FX", "fire/firelp_med_pm", randomstartdelay, "fire_dumpster_medium");
  global_fx("com_tires_burning01_FX_origin", "com_tires_burning01_FX", "fire/tire_fire_med", randomstartdelay);
  global_fx("icbm_powerlinetower_FX_origin", "icbm_powerlinetower_FX", "misc/power_tower_light_red_blink", randomstartdelay);
  global_fx("icbm_mainframe_FX_origin", "icbm_mainframe_FX", "props/icbm_mainframe_lightblink", randomstartdelay);
  global_fx("light_pulse_red_FX_origin", "light_pulse_red_FX", "misc/light_glow_red_generic_pulse", -2);
  global_fx("light_pulse_red_FX_origin", "light_pulse_red_FX", "misc/light_glow_red_generic_pulse", -2);
  global_fx("light_pulse_orange_FX_origin", "light_pulse_orange_FX", "misc/light_glow_orange_generic_pulse", -2);
}

global_fx(targetname, fxname, fxfile, delay, soundalias) {
  ents = getstructarray(targetname, "targetname");

  if(!isDefined(ents)) {
    return;
  }
  if(ents.size <= 0) {
    return;
  }
  println("*** Client : _global_FX - creating " + ents.size + " globalFX " + fxname);

  for(i = 0; i < ents.size; i++) {
    ent = ents[i] global_fx_create(fxname, fxfile, delay, soundalias);

    if(!isDefined(ents[i].script_noteworthy)) {
      continue;
    }
    note = ents[i].script_noteworthy;

    if(!isDefined(level._global_fx_ents[note]))
      level._global_fx_ents[note] = [];

    level._global_fx_ents[note][level._global_fx_ents[note].size] = ent;
  }
}

global_fx_create(fxname, fxfile, delay, soundalias) {
  if(!isDefined(level._effect))
    level._effect = [];

  if(!isDefined(level._effect[fxname]))
    level._effect[fxname] = loadfx(fxfile);

  if(!isDefined(self.angles))
    self.angles = (0, 0, 0);

  ent = clientscripts\_fx::createoneshoteffect(fxname);
  ent.v["origin"] = self.origin;
  ent.v["angles"] = self.angles;
  ent.v["fxid"] = fxname;
  ent.v["delay"] = delay;

  if(isDefined(soundalias))
    ent.v["soundalias"] = soundalias;

  return ent;
}