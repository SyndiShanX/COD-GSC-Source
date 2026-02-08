/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\char_usa_marine_h_pow_cut.gsc
***************************************************/

main() {
  self setModel("char_usa_marine_pow_body");
  self.headModel = "char_usa_marine_pow_head_cut";
  self attach(self.headModel, "", true);
  self.gearModel = "char_usa_marine_pow_cuffs";
  self attach(self.gearModel);
  self.voice = "american";
}

precache() {
  precacheModel("char_usa_marine_pow_body");
  precacheModel("char_usa_marine_pow_head_cut");
  precacheModel("char_usa_marine_pow_cuffs");
}