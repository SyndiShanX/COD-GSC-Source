/***************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_usmc_force_c.gsc
***************************************************/

main() {
  self setmodel("body_force_c_woodland");
  self attach("head_force_c", "", 1);
  self.headmodel = "head_force_c";
  self.voice = "british";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_force_c_woodland");
  precachemodel("head_force_c");
}