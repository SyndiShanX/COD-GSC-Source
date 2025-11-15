/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_us_army_welder.gsc
********************************************************/

main() {
  self setModel("body_us_army_casual_a_wht");
  self attach("head_army_welder", "", true);
  self.headModel = "head_army_welder";
  self.voice = "american";
}

precache() {
  precacheModel("body_us_army_casual_a_wht");
  precacheModel("head_army_welder");
}