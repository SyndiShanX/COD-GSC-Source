/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_civilian_me_male_cinderblock_d.gsc
******************************************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\civilian_me_male_veil_bodies::main());
  scripts\code\character::attachhead("civilian_me_male_veil_heads", xmodelalias\civilian_me_male_veil_heads::main());
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "civilian_cinderblockd";
  self.voice = "fsa";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  scripts\code\character::precachemodelarray(xmodelalias\civilian_me_male_veil_bodies::main());
  scripts\code\character::precachemodelarray(xmodelalias\civilian_me_male_veil_heads::main());
}

function main_mp() {
  self.animationarchetype = "civilian_cinderblockd";
  self.voice = "fsa";
  scripts\code\character::setmodelfromarray(xmodelalias\civilian_me_male_veil_bodies::main());
  scripts\code\character::attachhead("civilian_me_male_veil_heads", xmodelalias\civilian_me_male_veil_heads::main());
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "civilian_cinderblockd";
}