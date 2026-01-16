/*********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_russian_loyalist_a.gsc
*********************************************************/

main() {
  self setmodel("body_russian_loyalist_a");
  self attach("head_russian_loyalist_a", "", 1);
  self.headmodel = "head_russian_loyalist_a";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_russian_loyalist_a");
  precachemodel("head_russian_loyalist_a");
}