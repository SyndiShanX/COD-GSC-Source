/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_prison_z_lighting.gsc
***************************************************/

#include maps\mp\_mp_lights;

main() {
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);

  setDvar("r_mpRimColor", "0.8 0.6 0.3");
  setDvar("r_mpRimStrength", "10");
  setDvar("r_mpRimDiffuseTint", "1.5 1.5 1.5");

  setDvar("r_gunSightColorEntityScale", "7");
  setDvar("r_gunSightColorNoneScale", "0.8");

  if(level.currentgen) {
    setDvar("r_specularcolorscale", 1.0);
  }

  init();
}

fire_flicker() {
  play_flickerLight_preset("fire", "fire_flicker", 3000);
}