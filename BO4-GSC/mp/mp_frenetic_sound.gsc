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
    playsoundatposition(#"hash_4eb7a29f1b1a264", (905, 50, 1091));
    playsoundatposition(#"hash_44f8b894cb0ec41e", (1053, 975, 304));
    playsoundatposition(#"hash_44f8b794cb0ec26b", (1218, -1599, 270));
  }
}

function_2878f9d1() {
  while(true) {
    level waittill(#"snd_solar_alarm");
    playsoundatposition(#"hash_119425eb77c9699a", (905, 50, 1091));
  }
}