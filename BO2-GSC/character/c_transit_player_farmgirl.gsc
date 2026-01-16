/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_transit_player_farmgirl.gsc
***************************************************/

main() {
  self setmodel("c_zom_player_farmgirl_fb");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_zom_player_farmgirl_fb");
}