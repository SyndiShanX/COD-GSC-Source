/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_chn_pla_assault.gsc
*******************************************/

main() {
  self setmodel("c_chn_pla_body");
  self.headmodel = "c_chn_pla_head1";
  self attach(self.headmodel, "", 1);
  self.gearmodel = "c_chn_pla_gear1";
  self attach(self.gearmodel, "", 1);
  self.voice = "chinese";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_chn_pla_body");
  precachemodel("c_chn_pla_head1");
  precachemodel("c_chn_pla_gear1");
}