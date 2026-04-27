/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_seaside_sound.csc
***********************************************/

#namespace mp_seaside_sound;

main() {
  thread church_bells();
}

church_bells() {
  while(true) {
    wait 300;
    playSound(0, #"amb_church_bells", (-587, 2988, 1901));
  }
}