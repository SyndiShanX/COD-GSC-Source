/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_comeback_lighting.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  setDvar("r_reflectionprobefog", "1");
  setDvar("r_lightGridEnableTweaks", "1");
  setDvar("r_lightGridIntensity", "1.33");

  setDvar("r_gunSightColorEntityScale", "7");
  setDvar("r_gunSightColorNoneScale", "0.8");

  if(level.currentgen) {
    setDvar("r_intensity", 1.15);
    setDvar("r_brightness", getDvar("r_brightness") + 0.07);
  }
}