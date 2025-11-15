/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_seaside_alt_sound.csc
***********************************************/

#namespace mp_seaside_alt_sound;

main() {
  thread church_bells();
}

church_bells() {
  while(true) {
    wait 300;
    playSound(0, #"hash_5727281a9dcec94e", (-587, 2988, 1901));
  }
}