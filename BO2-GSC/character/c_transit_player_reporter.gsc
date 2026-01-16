/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_transit_player_reporter.gsc
***************************************************/

main() {
  self setmodel("c_zom_player_reporter_fb");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_zom_player_reporter_fb");
}