/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_iw8_cp_al_qatala_urban_bombvest.gsc
*******************************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_al_qatala_desert_09_rpg");
  scripts\code\character::attachhead("heads_al_qatala_desert", xmodelalias\heads_al_qatala_desert::main());
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier_cp";
  self.voice = "alqatala";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_al_qatala_desert_09_rpg");
  scripts\code\character::precachemodelarray(xmodelalias\heads_al_qatala_desert::main());
}

function main_mp() {
  self.animationarchetype = "soldier_cp";
  self.voice = "alqatala";
  self setModel("body_al_qatala_desert_09_rpg");
  scripts\code\character::attachhead("heads_al_qatala_desert", xmodelalias\heads_al_qatala_desert::main());
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier_cp";
}