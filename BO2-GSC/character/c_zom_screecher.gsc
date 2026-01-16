/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_zom_screecher.gsc
*****************************************/

main() {
  self setmodel("c_zom_screecher_fb");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_zom_screecher_fb");
}