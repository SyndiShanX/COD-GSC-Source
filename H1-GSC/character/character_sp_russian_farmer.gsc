/*****************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_russian_farmer.gsc
*****************************************************/

main() {
  self setmodel("body_sp_russian_farmer");
  self attach("head_sp_russian_farmer", "", 1);
  self.headmodel = "head_sp_russian_farmer";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_sp_russian_farmer");
  precachemodel("head_sp_russian_farmer");
}