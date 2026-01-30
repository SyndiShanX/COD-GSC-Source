/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_instinct_lighting.gsc
***************************************************/

#include maps\mp\_mp_lights;

main() {
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);

  setdvar("r_volumeLightScatterUseTweaks", "1");
  setdvar("r_lightGridEnableTweaks", "1");
  setdvar("r_lightGridIntensity", "1.33");
  setdvar("r_volumeLightScatter", "1");
  setdvar("r_volumeLightScatterUseTweaks", "1");
  setdvar("r_volumeLightScatterAngularAtten", ".05");
  setdvar("r_volumeLightScatterColor", ".960.96 0.94");
  setdvar("r_volumeLightScatterLinearAtten", "1");
  setdvar("r_volumeLightScatterEV", "14");

  setdvar("r_mpRimColor", ".8 .8 .6 0");
  setdvar("r_mpRimStrength", "0");
  setdvar("r_mpRimDiffuseTint", "1.2 1.5 1.5");

  setdvar("r_gunSightColorEntityScale", "7");
  setdvar("r_gunSightColorNoneScale", "0.8");

  if(level.currentgen) {
    setdvar("r_dof_tweak", 2);
  }

}