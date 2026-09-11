/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\civ_london_female_skintone_light.gsc
**********************************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\civilian_london_female_body_skintone_01::main());
  scripts\code\character::attachhead("civilian_london_female_head_skintone_light", xmodelalias\civilian_london_female_head_skintone_light::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\civilian_london_female_body_skintone_01::main());
  scripts\code\character::precachemodelarray(xmodelalias\civilian_london_female_head_skintone_light::main());
}

function main_mp() {
  self.animationarchetype = "civilian_female";
  self.voice = "unitednationsfemale";
  scripts\code\character::setmodelfromarray(xmodelalias\civilian_london_female_body_skintone_01::main());
  scripts\code\character::attachhead("civilian_london_female_head_skintone_light", xmodelalias\civilian_london_female_head_skintone_light::main());
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "civilian_female";
}