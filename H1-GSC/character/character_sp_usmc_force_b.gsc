/***************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_usmc_force_b.gsc
***************************************************/

main() {
  self setmodel("body_force_b_woodland");
  self attach("head_force_chad", "", 1);
  self.headmodel = "head_force_chad";
  self.voice = "british";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_force_b_woodland");
  precachemodel("head_force_chad");
}