/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_instinct_lighting.gsc
***************************************************/

#include maps\mp\_mp_lights;

main() {
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);

  setDvar("r_volumeLightScatterUseTweaks", "1");
  setDvar("r_lightGridEnableTweaks", "1");
  setDvar("r_lightGridIntensity", "1.33");
  setDvar("r_volumeLightScatter", "1");
  setDvar("r_volumeLightScatterUseTweaks", "1");
  setDvar("r_volumeLightScatterAngularAtten", ".05");
  setDvar("r_volumeLightScatterColor", ".960.96 0.94");
  setDvar("r_volumeLightScatterLinearAtten", "1");
  setDvar("r_volumeLightScatterEV", "14");

  setDvar("r_mpRimColor", ".8 .8 .6 0");
  setDvar("r_mpRimStrength", "0");
  setDvar("r_mpRimDiffuseTint", "1.2 1.5 1.5");

  setDvar("r_gunSightColorEntityScale", "7");
  setDvar("r_gunSightColorNoneScale", "0.8");

  if(level.currentgen) {
    setDvar("r_dof_tweak", 2);
  }
}