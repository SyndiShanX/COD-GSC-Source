/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_iw8_russian_army_1_trial.gsc
************************************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\bodies_al_qatala_desert_01::main());
  scripts\code\character::attachhead("heads_al_qatala_tmtyl", scripts\cp\execution::main());
  self.bhasthighholster = 0;
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
  scripts\code\character::precachemodelarray(xmodelalias\bodies_al_qatala_desert_01::main());
  scripts\code\character::precachemodelarray(scripts\cp\execution::main());
}

function main_mp() {
  self.animationarchetype = "soldier_cp";
  self.voice = "alqatala";
  scripts\code\character::setmodelfromarray(xmodelalias\bodies_al_qatala_desert_01::main());
  scripts\code\character::attachhead("heads_al_qatala_tmtyl", scripts\cp\execution::main());
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier_cp";
}