/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_transit_player_engineer.gsc
***************************************************/

main() {
  self setmodel("c_zom_player_engineer_fb");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_zom_player_engineer_fb");
}