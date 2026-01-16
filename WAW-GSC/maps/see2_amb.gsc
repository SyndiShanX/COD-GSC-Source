/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\see2_amb.gsc
*****************************************************/

#include maps\_utility;
#include maps\_ambientpackage;

main() {
  level thread walla_audio_notify();
}

walla_audio_notify() {
  level waittill("walla");
  walla1 = getent("walla1", "targetname");
  walla2 = getent("walla2", "targetname");
  chug = getent("chug", "targetname");
  whistle = getent("whistle", "targetname");
  walla1 playloopsound("See1_IGD_703A_RURS", 1);
  chug playloopsound("train_chug", 1);
  wait(5);
  walla2 playloopsound("See1_IGD_703A_RURS", 1);
  level waittill("audio_fade");
  playsoundatposition("train_whistle", whistle.origin);
  walla1 stoploopsound(4);
  walla2 stoploopsound(4);
}