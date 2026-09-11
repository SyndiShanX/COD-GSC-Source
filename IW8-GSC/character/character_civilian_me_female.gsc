/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_civilian_me_female.gsc
******************************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\civilian_me_female_bodies::main());
  scripts\code\character::attachhead("civilian_me_female_heads", xmodelalias\civilian_me_female_heads::main());
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "civilian_female";
  self.voice = "fsafemale";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  scripts\code\character::precachemodelarray(xmodelalias\civilian_me_female_bodies::main());
  scripts\code\character::precachemodelarray(xmodelalias\civilian_me_female_heads::main());
}

function main_mp() {
  self.animationarchetype = "civilian_female";
  self.voice = "fsafemale";
  scripts\code\character::setmodelfromarray(xmodelalias\civilian_me_female_bodies::main());
  scripts\code\character::attachhead("civilian_me_female_heads", xmodelalias\civilian_me_female_heads::main());
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "civilian_female";
}