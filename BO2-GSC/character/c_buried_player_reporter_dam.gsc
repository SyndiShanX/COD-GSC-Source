/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_buried_player_reporter_dam.gsc
*******************************************************/

main() {
  self setmodel("c_zom_player_reporter_dam_fb");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_zom_player_reporter_dam_fb");
}