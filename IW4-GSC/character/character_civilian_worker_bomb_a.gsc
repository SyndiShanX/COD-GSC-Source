/**********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_civilian_worker_bomb_a.gsc
**********************************************************/

main() {
  self setModel("body_work_civ_male_a_bomb");
  codescripts\character::attachHead("alias_civilian_worker_heads_hostage", xmodelalias\alias_civilian_worker_heads_hostage::main());
  self.voice = "american";
}

precache() {
  precacheModel("body_work_civ_male_a_bomb");
  codescripts\character::precacheModelArray(xmodelalias\alias_civilian_worker_heads_hostage::main());
}