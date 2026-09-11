/*********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_iw8_russian_army_2_hood_safehouse.gsc
*********************************************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\russian_army_bodies_2::main());
  scripts\code\character::attachhead("russian_army_heads_safehouse", xmodelalias\russian_army_heads_safehouse::main());
  self.bhasthighholster = 0;
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
  scripts\code\character::precachemodelarray(xmodelalias\russian_army_bodies_2::main());
  scripts\code\character::precachemodelarray(xmodelalias\russian_army_heads_safehouse::main());
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "russian";
  scripts\code\character::setmodelfromarray(xmodelalias\russian_army_bodies_2::main());
  scripts\code\character::attachhead("russian_army_heads_safehouse", xmodelalias\russian_army_heads_safehouse::main());
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier";
}