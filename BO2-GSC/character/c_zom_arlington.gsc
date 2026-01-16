/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_zom_arlington.gsc
*****************************************/

main() {
  self setmodel("c_zom_player_arlington_fb");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_zom_player_arlington_fb");
}