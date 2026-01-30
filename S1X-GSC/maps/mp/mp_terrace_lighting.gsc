/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_terrace_lighting.gsc
***************************************************/

main() {
  thread set_level_lighting_values();
}

set_level_lighting_values() {
  if(IsUsingHDR()) {
    thread setup_lighting();
  }
}

setup_lighting() {
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);

  setdvar("r_gunSightColorEntityScale", "7");
  setdvar("r_gunSightColorNoneScale", "0.8");
}