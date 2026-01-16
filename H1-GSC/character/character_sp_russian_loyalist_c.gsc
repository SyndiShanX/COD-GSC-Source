/*********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_russian_loyalist_c.gsc
*********************************************************/

main() {
  self setmodel("body_russian_loyalist_c");
  self attach("head_russian_loyalist_c", "", 1);
  self.headmodel = "head_russian_loyalist_c";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_russian_loyalist_c");
  precachemodel("head_russian_loyalist_c");
}