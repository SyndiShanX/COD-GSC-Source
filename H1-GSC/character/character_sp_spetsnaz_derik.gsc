/*****************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_spetsnaz_derik.gsc
*****************************************************/

main() {
  self setmodel("body_spetsnaz_assault_boris");
  self attach("head_spetsnaz_assault_vlad_facemask", "", 1);
  self.headmodel = "head_spetsnaz_assault_vlad_facemask";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_spetsnaz_assault_boris");
  precachemodel("head_spetsnaz_assault_vlad_facemask");
}