/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_highrise_player_oldman.gsc
**************************************************/

main() {
  self setmodel("c_zom_player_oldman_dlc1_fb");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_zom_player_oldman_dlc1_fb");
}