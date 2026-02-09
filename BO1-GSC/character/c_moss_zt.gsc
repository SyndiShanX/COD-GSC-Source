/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_moss_zt.gsc
**************************************/

main() {
  self setModel("c_moss_body");
  self.voice = "american";
  self.skeleton = "base";
}
precache() {
  precacheModel("c_moss_body");
}