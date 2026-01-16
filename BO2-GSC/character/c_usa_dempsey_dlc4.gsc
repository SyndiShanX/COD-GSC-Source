/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_dempsey_dlc4.gsc
********************************************/

main() {
  self setmodel("c_zom_tomb_dempsey_fb");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_zom_tomb_dempsey_fb");
}