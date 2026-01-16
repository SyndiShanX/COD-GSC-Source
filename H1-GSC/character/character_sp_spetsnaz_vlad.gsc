/****************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_spetsnaz_vlad.gsc
****************************************************/

main() {
  self setmodel("body_spetsnaz_assault_vlad");
  self attach("head_spetsnaz_assault_vlad_facemask", "", 1);
  self.headmodel = "head_spetsnaz_assault_vlad_facemask";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_spetsnaz_assault_vlad");
  precachemodel("head_spetsnaz_assault_vlad_facemask");
}