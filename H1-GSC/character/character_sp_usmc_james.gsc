/*************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_usmc_james.gsc
*************************************************/

main() {
  self setmodel("body_usmc_desert_assault_james");
  self attach("head_usmc_desert_support_james", "", 1);
  self.headmodel = "head_usmc_desert_support_james";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_usmc_desert_assault_james");
  precachemodel("head_usmc_desert_support_james");
}