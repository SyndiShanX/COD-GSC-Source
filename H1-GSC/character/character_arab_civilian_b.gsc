/***************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_arab_civilian_b.gsc
***************************************************/

main() {
  self setmodel("character_arab_civilian_lowres_b");
  self attach("character_arab_civilian_lowres_b_head", "", 1);
  self.headmodel = "character_arab_civilian_lowres_b_head";
  self.voice = "arab";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("character_arab_civilian_lowres_b");
  precachemodel("character_arab_civilian_lowres_b_head");
}