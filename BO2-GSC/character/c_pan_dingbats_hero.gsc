/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_pan_dingbats_hero.gsc
*********************************************/

main() {
  self setmodel("c_pan_dingbats_body_2");
  self.headmodel = "c_pan_dingbats_head_3_cin";
  self attach(self.headmodel, "", 1);
  self.gearmodel = "c_pan_dingbats_gear_2";
  self attach(self.gearmodel, "", 1);
  self.voice = "digbat";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_pan_dingbats_body_2");
  precachemodel("c_pan_dingbats_head_3_cin");
  precachemodel("c_pan_dingbats_gear_2");
}