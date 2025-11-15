/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_sp_zombie_dog.gsc
*************************************************/

main() {
  self setModel("zombie_wolf");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precacheModel("zombie_wolf");
}