/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_frenetic_sound.gsc
***********************************************/

#namespace mp_frenetic_sound;

main() {
  level thread snd_alarms();
  level thread function_2878f9d1();
}

snd_alarms() {
  while(true) {
    wait 300;
    playSoundAtPosition(#"amb_reactor_alarm", (905, 50, 1091));
    playSoundAtPosition(#"amb_reactor_alarm_comp_1", (1053, 975, 304));
    playSoundAtPosition(#"amb_reactor_alarm_comp_2", (1218, -1599, 270));
  }
}

function_2878f9d1() {
  while(true) {
    level waittill(#"snd_solar_alarm");
    playSoundAtPosition(#"amb_start_alarm", (905, 50, 1091));
  }
}