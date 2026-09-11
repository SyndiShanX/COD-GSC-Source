/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\civ_russian_male.gsc
***********************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\civ_russian_male_body_1::main());
  scripts\code\character::attachhead("civ_russian_male_head_1", xmodelalias\civ_russian_male_head_1::main());
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "civilian";
  self.voice = "unitednations";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  scripts\code\character::precachemodelarray(xmodelalias\civ_russian_male_body_1::main());
  scripts\code\character::precachemodelarray(xmodelalias\civ_russian_male_head_1::main());
}

function main_mp() {
  self.animationarchetype = "civilian";
  self.voice = "unitednations";
  scripts\code\character::setmodelfromarray(xmodelalias\civ_russian_male_body_1::main());
  scripts\code\character::attachhead("civ_russian_male_head_1", xmodelalias\civ_russian_male_head_1::main());
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "civilian";
}