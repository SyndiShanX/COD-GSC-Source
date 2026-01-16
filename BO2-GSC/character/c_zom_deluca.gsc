/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_zom_deluca.gsc
**************************************/

main() {
  self setmodel("c_zom_player_deluca_fb");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_zom_player_deluca_fb");
}