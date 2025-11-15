/*********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_hero_forest_ghost_dmg.gsc
*********************************************************/

main() {
  self setModel("body_forest_tf141_ghost_dmg");
  self attach("head_hero_ghost_forest_dmg", "", true);
  self.headModel = "head_hero_ghost_forest_dmg";
  self.voice = "taskforce";
}

precache() {
  precacheModel("body_forest_tf141_ghost_dmg");
  precacheModel("head_hero_ghost_forest_dmg");
}