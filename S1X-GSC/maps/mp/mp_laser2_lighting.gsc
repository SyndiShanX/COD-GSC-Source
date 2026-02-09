/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_laser2_lighting.gsc
***************************************************/

#include maps\mp\_mp_lights;

main() {
  setDvar("r_reflectionprobefog", "1");
  setDvar("r_lightGridEnableTweaks", "1");
  setDvar("r_lightGridIntensity", "1.33");

  setDvar("r_volumeLightScatter", "1");
  setDvar("r_volumeLightScatterUseTweaks", "1");
  setDvar("r_volumeLightScatterAngularAtten", ".34");
  setDvar("r_volumeLightScatterColor", "0.970.98 0.96");
  setDvar("r_volumeLightScatterLinearAtten", "1");
  setDvar("r_volumeLightScatterEV", "12.7");
  setDvar("r_volumeLightScatterBackgroundDistance", "200000");

  setDvar("r_gunSightColorEntityScale", "7");
  setDvar("r_gunSightColorNoneScale", "0.8");

  setDvar("r_mpRimColor", "1 0.8 0.5");
  setDvar("r_mpRimStrength", "0");
  setDvar("r_mpRimDiffuseTint", "1 1 1");

  if(level.currentgen) {
    setDvar("r_intensity", 1.15);
    setDvar("r_brightness", getDvar("r_brightness") + 0.07);
  }
}