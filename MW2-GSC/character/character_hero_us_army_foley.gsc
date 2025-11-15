/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_hero_us_army_foley.gsc
********************************************************/

main() {
  self setModel("body_us_army_assault_a");
  self attach("head_hero_foley", "", true);
  self.headModel = "head_hero_foley";
  self.voice = "american";
}

precache() {
  precacheModel("body_us_army_assault_a");
  precacheModel("head_hero_foley");
}