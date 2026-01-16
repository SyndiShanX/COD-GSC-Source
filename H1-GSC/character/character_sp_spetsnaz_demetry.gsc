/*******************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_spetsnaz_demetry.gsc
*******************************************************/

main() {
  self setmodel("body_spetsnaz_assault_demetry");
  self attach("head_spetsnaz_assault_demetry", "", 1);
  self.headmodel = "head_spetsnaz_assault_demetry";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_spetsnaz_assault_demetry");
  precachemodel("head_spetsnaz_assault_demetry");
}