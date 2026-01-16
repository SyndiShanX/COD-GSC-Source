/**************************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_vil_makarov_oneshotonekill.gsc
**************************************************************/

main() {
  self setmodel("body_russian_military_assault_a_woodland");
  self attach("head_makarov_b_young", "", 1);
  self.headmodel = "head_makarov_b_young";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_russian_military_assault_a_woodland");
  precachemodel("head_makarov_b_young");
}