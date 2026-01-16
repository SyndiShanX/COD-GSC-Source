/************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_opforce_a.gsc
************************************************/

main() {
  self setmodel("body_ultra_nationalist_assault_a");
  self attach("head_spetsnaz_assault_demetry", "", 1);
  self.headmodel = "head_spetsnaz_assault_demetry";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_ultra_nationalist_assault_a");
  precachemodel("head_spetsnaz_assault_demetry");
}