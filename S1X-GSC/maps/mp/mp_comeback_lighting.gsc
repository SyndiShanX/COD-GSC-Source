/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_comeback_lighting.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  setdvar("r_reflectionprobefog", "1");
  setdvar("r_lightGridEnableTweaks", "1");
  setdvar("r_lightGridIntensity", "1.33");

  setdvar("r_gunSightColorEntityScale", "7");
  setdvar("r_gunSightColorNoneScale", "0.8");

  if(level.currentgen) {
    SetDvar("r_intensity", 1.15);
    setdvar("r_brightness", GetDvar("r_brightness") + 0.07);
  }

}