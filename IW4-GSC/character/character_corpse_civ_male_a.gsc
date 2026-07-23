/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_corpse_civ_male_a.gsc
********************************************************/

main() {
  self setModel("body_corpse_civ_male_a");
  self attach("head_corpse_civ_male_a", "", true);
  self.headModel = "head_corpse_civ_male_a";
  self.voice = "american";
}

precache() {
  precacheModel("body_corpse_civ_male_a");
  precacheModel("head_corpse_civ_male_a");
}