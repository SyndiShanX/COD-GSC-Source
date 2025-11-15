/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_submarine_enemy_b.gsc
********************************************************/

main() {
  self setModel("body_work_civ_male_b");
  codescripts\character::attachHead("alias_civilian_worker_heads", xmodelalias\alias_civilian_worker_heads::main());
  self.voice = "russian";
}

precache() {
  precacheModel("body_work_civ_male_b");
  codescripts\character::precacheModelArray(xmodelalias\alias_civilian_worker_heads::main());
}