/***********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_usmc_at4.gsc
***********************************************/

main() {
  self setmodel("body_usmc_desert_assault_james_at4");
  self attach("head_usmc_desert_support_james", "", 1);
  self.headmodel = "head_usmc_desert_support_james";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_usmc_desert_assault_james_at4");
  precachemodel("head_usmc_desert_support_james");
}