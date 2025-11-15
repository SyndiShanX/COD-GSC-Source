/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_dog_mp.csc
*************************************************/

#include character\clientscripts\character_mp_german_shepherd;

main() {
  character\clientscripts\character_mp_german_shepherd::main();
  self._aitype = "enemy_dog_mp";
}

precache(ai_index) {
  character\clientscripts\character_mp_german_shepherd::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}