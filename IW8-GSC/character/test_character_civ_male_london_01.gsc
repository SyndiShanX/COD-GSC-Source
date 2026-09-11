/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\test_character_civ_male_london_01.gsc
***********************************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\test_alias_civ_london_male_1_body::main());
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "civilian";
  self.voice = "sas";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  scripts\code\character::precachemodelarray(xmodelalias\test_alias_civ_london_male_1_body::main());
}

function main_mp() {
  self.animationarchetype = "civilian";
  self.voice = "sas";
  scripts\code\character::setmodelfromarray(xmodelalias\test_alias_civ_london_male_1_body::main());
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "civilian";
}