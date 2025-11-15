/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_zom_electrician.gsc
*******************************************/

main() {
  self setModel("c_zom_electrician_body");
  self.voice = "german";
  self.skeleton = "base";
}

precache() {
  precacheModel("c_zom_electrician_body");
}