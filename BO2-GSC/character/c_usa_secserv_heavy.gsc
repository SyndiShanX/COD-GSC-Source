/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_secserv_heavy.gsc
*********************************************/

main() {
  self setmodel("c_usa_secserv_body");
  self.headmodel = "c_usa_secserv_head_heavy";
  self attach(self.headmodel, "", 1);
  self.gearmodel = "c_usa_secserv_gear_heavy";
  self attach(self.gearmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_secserv_body");
  precachemodel("c_usa_secserv_head_heavy");
  precachemodel("c_usa_secserv_gear_heavy");
}