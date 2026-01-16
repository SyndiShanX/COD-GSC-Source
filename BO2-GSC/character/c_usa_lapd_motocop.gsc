/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_lapd_motocop.gsc
********************************************/

main() {
  self setmodel("c_usa_lapd_motocop_fb");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_lapd_motocop_fb");
}