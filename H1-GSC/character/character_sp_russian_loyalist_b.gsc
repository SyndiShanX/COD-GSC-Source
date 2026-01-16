/*********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_russian_loyalist_b.gsc
*********************************************************/

main() {
  self setmodel("body_russian_loyalist_b");
  self attach("head_russian_loyalist_b", "", 1);
  self.headmodel = "head_russian_loyalist_b";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_russian_loyalist_b");
  precachemodel("head_russian_loyalist_b");
}