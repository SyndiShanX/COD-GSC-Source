/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\civ_syrkistan_female_nurse_nomask.gsc
***********************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("civ_nurse_female");
  scripts\code\character::attachhead("civilian_syrkistan_female_head_no_hair", xmodelalias\civilian_syrkistan_female_head_no_hair::main());
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
  precachemodel("civ_nurse_female");
  scripts\code\character::precachemodelarray(xmodelalias\civilian_syrkistan_female_head_no_hair::main());
}

function main_mp() {
  self.animationarchetype = "civilian_female";
  self.voice = "alqatalafemale";
  self setModel("civ_nurse_female");
  scripts\code\character::attachhead("civilian_syrkistan_female_head_no_hair", xmodelalias\civilian_syrkistan_female_head_no_hair::main());
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "civilian_female";
}