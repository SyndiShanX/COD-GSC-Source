/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_dempsey_zt.gsc
******************************************/

main() {
  self setModel("c_usa_dempsey_body");
  self.voice = "american";
  self.skeleton = "base";
}
precache() {
  precacheModel("c_usa_dempsey_body");
}