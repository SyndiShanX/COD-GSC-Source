/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_afr_childsoldier_1.gsc
**********************************************/

main() {
  self setmodel("c_afr_childsoldier_1_fb");
  self.voice = "unita";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_afr_childsoldier_1_fb");
}