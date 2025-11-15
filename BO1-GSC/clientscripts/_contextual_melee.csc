/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_contextual_melee.csc
***********************************************/

#include clientscripts\_utility;

main() {
  level thread rumble_garrote();
}

rumble_garrote() {
  while(true) {
    level waittill("garrote_stand");
    player = getLocalPlayers()[0];
    player playRumbleOnEntity(0, "melee_garrote");
  }
}