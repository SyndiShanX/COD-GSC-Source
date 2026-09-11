/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_civilian_me_male.gsc
****************************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\civilian_syrkistan_male_body::main());
  scripts\code\character::attachhead("civilian_syrkistan_male_head", xmodelalias\civilian_syrkistan_male_head::main());
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "civilian";
  self.voice = "fsa";
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
  self.animationarchetype = "civilian";
  self.voice = "fsa";
  scripts\code\character::setmodelfromarray(xmodelalias\civilian_syrkistan_male_body::main());
  scripts\code\character::attachhead("civilian_syrkistan_male_head", xmodelalias\civilian_syrkistan_male_head::main());
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "civilian";
}