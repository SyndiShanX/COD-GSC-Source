/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_secserv_swat_tactical.gsc
*****************************************************/

main() {
  self setmodel("c_usa_secserv_body");
  self.headmodel = "c_usa_secserv_head_tactical";
  self attach(self.headmodel, "", 1);
  self.gearmodel = "c_usa_secserv_gear_medium";
  self attach(self.gearmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_secserv_body");
  precachemodel("c_usa_secserv_head_tactical");
  precachemodel("c_usa_secserv_gear_medium");
}