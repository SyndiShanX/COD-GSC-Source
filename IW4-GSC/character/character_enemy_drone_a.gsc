/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_enemy_drone_a.gsc
********************************************************/

main() {
  self setModel("body_complete_enemy_drone_a");
  self.voice = "american";
}

precache() {
  precacheModel("body_complete_enemy_drone_a");
}