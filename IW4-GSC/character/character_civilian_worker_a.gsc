/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_civilian_worker_a.gsc
********************************************************/

main() {
  self setModel("body_work_civ_male_a");
  codescripts\character::attachHead("alias_civilian_worker_heads", xmodelalias\alias_civilian_worker_heads::main());
  self.voice = "american";
}

precache() {
  precacheModel("body_work_civ_male_a");
  codescripts\character::precacheModelArray(xmodelalias\alias_civilian_worker_heads::main());
}