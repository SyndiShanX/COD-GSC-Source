/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\civ_western_cold_girl.gsc
***********************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\bodies_civ_western_cold_girl::main());
  scripts\code\character::attachhead("heads_civ_western_cold_girl", xmodelalias\heads_civ_western_cold_girl::main());
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "civilian";
  self.voice = "fsafemale";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  scripts\code\character::precachemodelarray(xmodelalias\bodies_civ_western_cold_girl::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_civ_western_cold_girl::main());
}

function main_mp() {
  self.animationarchetype = "civilian";
  self.voice = "fsafemale";
  scripts\code\character::setmodelfromarray(xmodelalias\bodies_civ_western_cold_girl::main());
  scripts\code\character::attachhead("heads_civ_western_cold_girl", xmodelalias\heads_civ_western_cold_girl::main());
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "civilian";
}