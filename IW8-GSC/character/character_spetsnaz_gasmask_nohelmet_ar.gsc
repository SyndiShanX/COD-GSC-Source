/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_spetsnaz_gasmask_nohelmet_ar.gsc
****************************************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\bodies_spetsnaz_ar::main());
  scripts\code\character::attachhead("russian_army_heads_gasmask", xmodelalias\russian_army_heads_gasmask::main());
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier";
  self.voice = "russian";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  scripts\code\character::precachemodelarray(xmodelalias\bodies_spetsnaz_ar::main());
  scripts\code\character::precachemodelarray(xmodelalias\russian_army_heads_gasmask::main());
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "russian";
  scripts\code\character::setmodelfromarray(xmodelalias\bodies_spetsnaz_ar::main());
  scripts\code\character::attachhead("russian_army_heads_gasmask", xmodelalias\russian_army_heads_gasmask::main());
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier";
}