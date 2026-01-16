/*******************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_arab_civilian_f_fem.gsc
*******************************************************/

main() {
  self setmodel("character_arab_civilian_lowres_f");
  self attach("character_arab_civilian_lowres_f_head", "", 1);
  self.headmodel = "character_arab_civilian_lowres_f_head";
  self.voice = "arab";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("character_arab_civilian_lowres_f");
  precachemodel("character_arab_civilian_lowres_f_head");
}