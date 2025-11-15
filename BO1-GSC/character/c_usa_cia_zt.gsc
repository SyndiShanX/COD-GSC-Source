/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_cia_zt.gsc
**************************************/

main() {
  self setModel("c_rus_scientist_body1_zt");
  self.headModel = "c_rus_scientist_head1";
  self attach(self.headModel, "", true);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precacheModel("c_rus_scientist_body1_zt");
  precacheModel("c_rus_scientist_head1");
}