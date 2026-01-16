/***************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_usmc_force_a.gsc
***************************************************/

main() {
  self setmodel("body_force_assault_woodland");
  self attach("head_force_assault", "", 1);
  self.headmodel = "head_force_assault";
  self.voice = "british";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_force_assault_woodland");
  precachemodel("head_force_assault");
}