/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\see2_amb.gsc
**************************************/

#include maps\_utility;
#include maps\_ambientpackage;

main() {
  level thread walla_audio_notify();
}

walla_audio_notify() {
  level waittill("walla");
  walla1 = getEnt("walla1", "targetname");
  walla2 = getEnt("walla2", "targetname");
  chug = getEnt("chug", "targetname");
  whistle = getEnt("whistle", "targetname");

  walla1 playLoopSound("See1_IGD_703A_RURS", 1);
  chug playLoopSound("train_chug", 1);
  wait(5);
  walla2 playLoopSound("See1_IGD_703A_RURS", 1);

  level waittill("audio_fade");
  playSoundAtPosition("train_whistle", whistle.origin);

  walla1 stoploopsound(4);
  walla2 stoploopsound(4);
}