/*********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_usmc_ghillie_price.gsc
*********************************************************/

main() {
  self setmodel("body_complete_sp_usmc_ghillie_price");
  self attach("head_usmc_ghillie_price", "", 1);
  self.headmodel = "head_usmc_ghillie_price";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_complete_sp_usmc_ghillie_price");
  precachemodel("head_usmc_ghillie_price");
}