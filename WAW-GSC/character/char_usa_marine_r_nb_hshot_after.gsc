/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\char_usa_marine_r_nb_hshot_after.gsc
**********************************************************/

main() {
  self setModel("char_usa_marine_body1_1");
  self.headModel = "char_usa_marine_head_shot";
  self attach(self.headModel, "", true);
  self.gearModel = "char_usa_raider_gear2";
  self attach(self.gearModel);
  self.voice = "american";
}

precache() {
  precacheModel("char_usa_marine_body1_1");
  precacheModel("char_usa_marine_head_shot");
  precacheModel("char_usa_raider_gear2");
}