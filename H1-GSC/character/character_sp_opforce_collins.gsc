/******************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_opforce_collins.gsc
******************************************************/

main() {
  self setmodel("body_ultra_nationalist_assault_d");
  self attach("head_spetsnaz_assault_vlad", "", 1);
  self.headmodel = "head_spetsnaz_assault_vlad";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_ultra_nationalist_assault_d");
  precachemodel("head_spetsnaz_assault_vlad");
}