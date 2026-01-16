/****************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_spetsnaz_yuri.gsc
****************************************************/

main() {
  self setmodel("body_spetsnaz_assault_yuri");
  self attach("head_spetsnaz_assault_boris", "", 1);
  self.headmodel = "head_spetsnaz_assault_boris";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_spetsnaz_assault_yuri");
  precachemodel("head_spetsnaz_assault_boris");
}