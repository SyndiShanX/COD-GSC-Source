/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\test_character_alq_embassy.gsc
****************************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\civilian_syrkistan_male_body::main());
  scripts\code\character::attachhead("civilian_syrkistan_male_head", xmodelalias\civilian_syrkistan_male_head::main());
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "rebel";
  self.voice = "alqatala";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  scripts\code\character::precachemodelarray(xmodelalias\civilian_syrkistan_male_body::main());
  scripts\code\character::precachemodelarray(xmodelalias\civilian_syrkistan_male_head::main());
}

function main_mp() {
  self.animationarchetype = "rebel";
  self.voice = "alqatala";
  scripts\code\character::setmodelfromarray(xmodelalias\civilian_syrkistan_male_body::main());
  scripts\code\character::attachhead("civilian_syrkistan_male_head", xmodelalias\civilian_syrkistan_male_head::main());
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "rebel";
}