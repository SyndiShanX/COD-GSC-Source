/*************************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_civilian_worker_hostage_b.gsc
*************************************************************/

main() {
  self setModel("body_work_civ_male_b");
  codescripts\character::attachHead("alias_civilian_worker_heads_hostage", xmodelalias\alias_civilian_worker_heads_hostage::main());
  self.voice = "american";
}

precache() {
  precacheModel("body_work_civ_male_b");
  codescripts\character::precacheModelArray(xmodelalias\alias_civilian_worker_heads_hostage::main());
}