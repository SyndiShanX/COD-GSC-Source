/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_solar_lighting.gsc
***************************************************/

#include maps\mp\_mp_lights;
#include maps\mp\_utility;

main() {
  SetDvar("r_lightGridEnableTweaks", 1);
  SetDvar("r_lightGridIntensity", 1.33);

  setdvar("r_gunSightColorEntityScale", "7");
  setdvar("r_gunSightColorNoneScale", "0.8");

  thread set_lighting_values();
}

set_lighting_values() {
  if(IsUsingHDR()) {
    while(true) {
      level waittill("connected", player);
    }
  }
}