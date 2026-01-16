/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_secserv_driver.gsc
**********************************************/

main() {
  self setmodel("c_usa_secserv_body");
  self.headmodel = "c_usa_secserv_head_driver";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_secserv_body");
  precachemodel("c_usa_secserv_head_driver");
}