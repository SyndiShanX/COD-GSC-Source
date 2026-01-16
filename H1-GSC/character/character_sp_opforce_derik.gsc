/****************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_opforce_derik.gsc
****************************************************/

main() {
  self setmodel("body_ultra_nationalist_assault_f");
  self attach("head_spetsnaz_assault_derik", "", 1);
  self.headmodel = "head_spetsnaz_assault_derik";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_ultra_nationalist_assault_f");
  precachemodel("head_spetsnaz_assault_derik");
}