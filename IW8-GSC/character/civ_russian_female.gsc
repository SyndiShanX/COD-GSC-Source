/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\civ_russian_female.gsc
***********************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\civilian_russian_female_body::main());
  scripts\code\character::attachhead("civilian_russian_female_head", xmodelalias\civilian_russian_female_head::main());
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "civilian_female";
  self.voice = "alqatalafemale";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  scripts\code\character::precachemodelarray(xmodelalias\civilian_russian_female_body::main());
  scripts\code\character::precachemodelarray(xmodelalias\civilian_russian_female_head::main());
}

function main_mp() {
  self.animationarchetype = "civilian_female";
  self.voice = "alqatalafemale";
  scripts\code\character::setmodelfromarray(xmodelalias\civilian_russian_female_body::main());
  scripts\code\character::attachhead("civilian_russian_female_head", xmodelalias\civilian_russian_female_head::main());
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "civilian_female";
}