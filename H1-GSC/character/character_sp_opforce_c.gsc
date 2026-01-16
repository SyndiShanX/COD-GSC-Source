/************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_opforce_c.gsc
************************************************/

main() {
  self setmodel("body_ultra_nationalist_assault_c");
  self attach("head_spetsnaz_assault_boris", "", 1);
  self.headmodel = "head_spetsnaz_assault_boris";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_ultra_nationalist_assault_c");
  precachemodel("head_spetsnaz_assault_boris");
}