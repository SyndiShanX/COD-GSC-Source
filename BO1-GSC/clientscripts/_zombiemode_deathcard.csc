/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_zombiemode_deathcard.csc
***************************************************/

#include clientscripts\_utility;
#include clientscripts\_fx;
#include clientscripts\_music;

init() {
  level thread death_card_think();
}

death_card_think() {
  if(!isDefined(level.dcsound)) {
    level.dcsound = spawn(0, (0, 0, 0), "script_origin");
  }
  while(1) {
    level waittill("dc0");
    level.dcsound playsound(0, "evt_death_card");
  }
}