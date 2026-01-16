/***********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_dead_russian_loyalist_c.gsc
***********************************************************/

main() {
  self setmodel("body_russian_loyalist_c_dead");
  self attach("head_russian_loyalist_a_dead", "", 1);
  self.headmodel = "head_russian_loyalist_a_dead";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_russian_loyalist_c_dead");
  precachemodel("head_russian_loyalist_a_dead");
}