/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pel1a_amb.gsc
*****************************************************/

#include maps\_utility;
#include maps\_ambientpackage;

main() {
  /
}

play_fake_japanese_battlechatter() {
  wait(4);
  while(1) {
    level endon("player_win");
    ai = getaiarray("axis");
    ent = ai[randomint(ai.size)];
    if(!isalive(ent) || !isDefined(ent) || (isDefined(ent.isplaying_fake_bc) && ent.isplaying_fake_bc == true)) {
      wait 0.5;
      continue;
    }
    num_battle_chatters = 24;
    randomizer = randomintrange(1, num_battle_chatters);
    ent playSound("fake_jbc_" + randomizer, "sound_done");
    ent.isplaying_fake_bc = true;
    ent waittill("sound_done");
    if(isalive(ent) && isDefined(ent)) {
      ent.isplaying_fake_bc = false;
    }
    wait(1);
    wait(randomintrange(1, 3));
  }
}