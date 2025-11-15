/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\char_usa_marinewet_h_roebuck.gsc
******************************************************/

main() {
  self setModel("char_usa_marine_wet_roebuck");
  self.hatModel = "char_usa_raider_wet_helm2";
  self attach(self.hatModel);
  self.voice = "american";
}

precache() {
  precacheModel("char_usa_marine_wet_roebuck");
  precacheModel("char_usa_raider_wet_helm2");
}