/******************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_usmc_force_mark.gsc
******************************************************/

main() {
  self setmodel("body_force_mark_woodland");
  self attach("head_force_assault_mark", "", 1);
  self.headmodel = "head_force_assault_mark";
  self.voice = "british";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_force_mark_woodland");
  precachemodel("head_force_assault_mark");
}