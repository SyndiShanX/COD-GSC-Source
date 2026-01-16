/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_zom_ally_farmgirl.gsc
*********************************************/

main() {
  self setmodel("c_zom_player_farmgirl_dlc1_fb");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_zom_player_farmgirl_dlc1_fb");
}