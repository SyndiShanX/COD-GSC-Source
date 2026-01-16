/**************************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_spetsnaz_boris_jeepride.gsc
**************************************************************/

main() {
  self setmodel("body_spetsnaz_assault_boris_jeepride");
  self attach("head_spetsnaz_assault_boris_jeepride", "", 1);
  self.headmodel = "head_spetsnaz_assault_boris_jeepride";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_spetsnaz_assault_boris_jeepride");
  precachemodel("head_spetsnaz_assault_boris_jeepride");
}