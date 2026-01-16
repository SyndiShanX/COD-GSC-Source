/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_cc_briggs.gsc
*****************************************/

main() {
  self setmodel("c_usa_cc_briggs_fb");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_cc_briggs_fb");
}