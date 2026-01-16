/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_zom_zombie_buried_saloongirl_mp.gsc
*****************************************************************/

main() {
  self setmodel("c_zom_zombie_buried_sgirl_player_fb");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_zom_zombie_buried_sgirl_player_fb");
}