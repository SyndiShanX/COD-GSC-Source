/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_dog_sp.csc
*************************************************/

#include character\clientscripts\character_sp_german_sheperd_dog;

main() {
  character\clientscripts\character_sp_german_sheperd_dog::main();
  self._aitype = "enemy_dog_sp";
}

precache(ai_index) {
  character\clientscripts\character_sp_german_sheperd_dog::precache();
  usefootsteptable(ai_index, "fly_step_dog");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}