/****************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_iw8_russian_army_2_hood_safehouse_finale.gsc
****************************************************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\russian_army_bodies_2_light::main());
  scripts\code\character::attachhead("russian_army_heads", xmodelalias\russian_army_heads::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\russian_army_bodies_2_light::main());
  scripts\code\character::precachemodelarray(xmodelalias\russian_army_heads::main());
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "russian";
  scripts\code\character::setmodelfromarray(xmodelalias\russian_army_bodies_2_light::main());
  scripts\code\character::attachhead("russian_army_heads", xmodelalias\russian_army_heads::main());
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier";
}