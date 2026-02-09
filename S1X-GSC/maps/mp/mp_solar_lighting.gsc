/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_solar_lighting.gsc
***************************************************/

#include maps\mp\_mp_lights;
#include maps\mp\_utility;

main() {
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);

  setDvar("r_gunSightColorEntityScale", "7");
  setDvar("r_gunSightColorNoneScale", "0.8");

  thread set_lighting_values();
}

set_lighting_values() {
  if(IsUsingHDR()) {
    while(true) {
      level waittill("connected", player);
    }
  }
}