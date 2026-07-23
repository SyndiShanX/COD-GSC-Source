/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_hero_us_army_dunn.gsc
********************************************************/

main() {
  self setModel("body_us_army_lmg");
  self attach("head_hero_dunn", "", true);
  self.headModel = "head_hero_dunn";
  self.voice = "american";
}

precache() {
  precacheModel("body_us_army_lmg");
  precacheModel("head_hero_dunn");
}