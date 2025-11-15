/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\see1_amb.csc
*****************************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;

main() {
  /
  if(isDefined(level._explosionEntPos)) {
    playSound(0, "explosion_house", level._explosionEntPos.origin);
  }
}

house_explosion2() {
  level waittill("house_explosion");
  house_explo = getstruct("house_explo", "targetname");
  playSound(0, "explosion_house", house_explo.origin);
}

camp_audio() {
  level waittill("camp_audio_on");
  klaxxon = getstruct("klaxxon", "targetname");
  pa_speaker = getstruct("pa_speaker", "targetname");
  e1 = clientscripts\_audio::playloopat(0, "klaxxon", klaxxon.origin);
  e2 = clientscripts\_audio::playloopat(0, "pa_speaker", pa_speaker.origin);
  level waittill("stop_pa");
  deletefakeent(0, e2);
  level waittill("stop_klaxxon");
  deletefakeent(0, e1);
}

plane_machine_gun() {
  for(;;) {
    level waittill("start_firing_sound");
    thread my_coolness();
  }
}

my_coolness() {
  level endon("stop_firing_sound");
  while(1) {
    plane_guns = getEntArray(0, "plane", "targetname");
    for(i = 0; i < plane_guns.size; i++) {
      playSound(0, "plane_shot", plane_guns[i].origin);
    }
    wait(.048);
  }
}