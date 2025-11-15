/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\char_usa_pbycrew_gunner.gsc
*****************************************************/

main() {
  self setModel("char_usa_pbycrew_body1_1");
  self.headModel = "char_usa_pbycrew_fullmask";
  self attach(self.headModel, "", true);
  self.voice = "american";
}

precache() {
  precacheModel("char_usa_pbycrew_body1_1");
  precacheModel("char_usa_pbycrew_fullmask");
}