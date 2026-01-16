/***************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: character\character_sp_usmc_vasquez.gsc
***************************************************/

main() {
  self setmodel("body_usmc_desert_assault_vasquez");
  self attach("head_usmc_marine_vazquez", "", 1);
  self.headmodel = "head_usmc_marine_vazquez";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_usmc_desert_assault_vasquez");
  precachemodel("head_usmc_marine_vazquez");
}