/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_2_amb.gsc
**************************************/

#include maps\_music;
#include maps\_utility;

main() {
  level.sndf35_death_sound = 0;
}

radio_chatter() {
  level endon("player_ejected");

  while(true) {
    wait(randomintrange(1, 6));
    level.player playsound("blk_f35_radio_chatter", "sound_done");
    level.player waittill("sound_done");
  }
}