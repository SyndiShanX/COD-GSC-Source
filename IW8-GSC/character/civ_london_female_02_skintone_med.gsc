/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\civ_london_female_02_skintone_med.gsc
***********************************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\civilian_london_female_body_02_skintone_med::main());
  scripts\code\character::attachhead("civilian_london_female_heads_skintone_med", xmodelalias\civilian_london_female_heads_skintone_med::main());
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "civilian_female";
  self.voice = "unitednationsfemale";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  scripts\code\character::precachemodelarray(xmodelalias\civilian_london_female_body_02_skintone_med::main());
  scripts\code\character::precachemodelarray(xmodelalias\civilian_london_female_heads_skintone_med::main());
}

function main_mp() {
  self.animationarchetype = "civilian_female";
  self.voice = "unitednationsfemale";
  scripts\code\character::setmodelfromarray(xmodelalias\civilian_london_female_body_02_skintone_med::main());
  scripts\code\character::attachhead("civilian_london_female_heads_skintone_med", xmodelalias\civilian_london_female_heads_skintone_med::main());
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "civilian_female";
}