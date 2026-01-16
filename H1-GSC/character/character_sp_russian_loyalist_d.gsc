/*********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_russian_loyalist_d.gsc
*********************************************************/

main() {
  self setmodel("body_russian_loyalist_d");
  self attach("head_russian_loyalist_kamarov", "", 1);
  self.headmodel = "head_russian_loyalist_kamarov";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_russian_loyalist_d");
  precachemodel("head_russian_loyalist_kamarov");
}