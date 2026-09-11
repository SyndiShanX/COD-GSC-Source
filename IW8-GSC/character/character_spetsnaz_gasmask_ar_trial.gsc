/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_spetsnaz_gasmask_ar_trial.gsc
*************************************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\russian_army_bodies_1::main());
  scripts\code\character::attachhead("russian_army_heads", xmodelalias\russian_army_heads::main());
  scripts\code\character::attachhat("russian_army_hats", xmodelalias\russian_army_hats::main());
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier_lw";
  self.voice = "russian";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  scripts\code\character::precachemodelarray(xmodelalias\russian_army_bodies_1::main());
  scripts\code\character::precachemodelarray(xmodelalias\russian_army_heads::main());
  scripts\code\character::precachemodelarray(xmodelalias\russian_army_hats::main());
}

function main_mp() {
  self.animationarchetype = "soldier_lw";
  self.voice = "russian";
  scripts\code\character::setmodelfromarray(xmodelalias\russian_army_bodies_1::main());
  scripts\code\character::attachhead("russian_army_heads", xmodelalias\russian_army_heads::main());
  scripts\code\character::attachhat("russian_army_hats", xmodelalias\russian_army_hats::main());
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier_lw";
}