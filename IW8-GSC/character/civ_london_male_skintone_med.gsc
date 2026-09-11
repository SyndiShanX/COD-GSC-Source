/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\civ_london_male_skintone_med.gsc
******************************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\civilian_london_male_body_skintone_med::main());
  scripts\code\character::attachhead("civilian_uk_male_heads_skintone_med", xmodelalias\civilian_uk_male_heads_skintone_med::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\civilian_london_male_body_skintone_med::main());
  scripts\code\character::precachemodelarray(xmodelalias\civilian_uk_male_heads_skintone_med::main());
}

function main_mp() {
  self.animationarchetype = "civilian";
  self.voice = "unitednations";
  scripts\code\character::setmodelfromarray(xmodelalias\civilian_london_male_body_skintone_med::main());
  scripts\code\character::attachhead("civilian_uk_male_heads_skintone_med", xmodelalias\civilian_uk_male_heads_skintone_med::main());
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "civilian";
}