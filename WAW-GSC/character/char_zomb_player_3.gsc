/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\char_zomb_player_3.gsc
*****************************************************/

main() {
  self setModel("char_ger_ansel_body_zomb");
  self.headModel = "char_ger_ansel_head_zomb";
  self attach(self.headModel, "", true);
  self.hatModel = "char_ger_waffen_officercap1_zomb";
  self attach(self.hatModel);
  self.voice = "german";
}

precache() {
  precacheModel("char_ger_ansel_body_zomb");
  precacheModel("char_ger_ansel_head_zomb");
  precacheModel("char_ger_waffen_officercap1_zomb");
}