/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_seal80s_medium.gsc
**********************************************/

main() {
  self setmodel("c_usa_seal80s_body");
  self.headmodel = "c_usa_seal80s_head1";
  self attach(self.headmodel, "", 1);
  self.gearmodel = "c_usa_seal80s_gear_medium";
  self attach(self.gearmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_seal80s_body");
  precachemodel("c_usa_seal80s_head1");
  precachemodel("c_usa_seal80s_gear_medium");
}