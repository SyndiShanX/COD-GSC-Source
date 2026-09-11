/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\civ_london_female_03_skintone_dark.gsc
************************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("civ_london_female_3_3");
  scripts\code\character::attachhead("civilian_london_female_heads_skintone_dark_nohair", xmodelalias\civilian_london_female_heads_skintone_dark_nohair::main());
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
  precachemodel("civ_london_female_3_3");
  scripts\code\character::precachemodelarray(xmodelalias\civilian_london_female_heads_skintone_dark_nohair::main());
}

function main_mp() {
  self.animationarchetype = "civilian_female";
  self.voice = "unitednationsfemale";
  self setModel("civ_london_female_3_3");
  scripts\code\character::attachhead("civilian_london_female_heads_skintone_dark_nohair", xmodelalias\civilian_london_female_heads_skintone_dark_nohair::main());
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "civilian_female";
}