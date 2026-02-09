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
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);

  setDvar("r_gunSightColorEntityScale", "7");
  setDvar("r_gunSightColorNoneScale", "0.8");
}