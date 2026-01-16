/*******************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_spetsnaz_collins.gsc
*******************************************************/

main() {
  self setmodel("body_spetsnaz_assault_vlad");
  self attach("head_spetsnaz_assault_vlad", "", 1);
  self.headmodel = "head_spetsnaz_assault_vlad";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_spetsnaz_assault_vlad");
  precachemodel("head_spetsnaz_assault_vlad");
}