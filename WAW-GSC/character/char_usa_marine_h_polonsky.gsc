/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\char_usa_marine_h_polonsky.gsc
****************************************************/

main() {
  self setModel("char_usa_marine_polonsky");
  self.hatModel = "char_usa_raider_helm2";
  self attach(self.hatModel);
  self.voice = "american";
}

precache() {
  precacheModel("char_usa_marine_polonsky");
  precacheModel("char_usa_raider_helm2");
}