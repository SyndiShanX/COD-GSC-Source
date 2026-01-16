/***************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_arab_civilian_a.gsc
***************************************************/

main() {
  self setmodel("character_arab_civilian_lowres_a");
  self attach("character_arab_civilian_lowres_a_head", "", 1);
  self.headmodel = "character_arab_civilian_lowres_a_head";
  self.voice = "arab";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("character_arab_civilian_lowres_a");
  precachemodel("character_arab_civilian_lowres_a_head");
}