/************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_usmc_sami.gsc
************************************************/

main() {
  self setmodel("body_usmc_desert_assault_james");
  self attach("head_usmc_desert_support_zack", "", 1);
  self.headmodel = "head_usmc_desert_support_zack";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_usmc_desert_assault_james");
  precachemodel("head_usmc_desert_support_zack");
}