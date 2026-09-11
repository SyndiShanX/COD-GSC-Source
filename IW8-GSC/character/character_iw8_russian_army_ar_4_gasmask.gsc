/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_iw8_russian_army_ar_4_gasmask.gsc
*****************************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_russian_army_ar_4");
  scripts\code\character::attachhead("russian_army_heads_gasmask", xmodelalias\russian_army_heads_gasmask::main());
  scripts\code\character::attachhat("russian_army_ar_4_hats_gasmask", xmodelalias\russian_army_ar_4_hats_gasmask::main());
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
  precachemodel("body_russian_army_ar_4");
  scripts\code\character::precachemodelarray(xmodelalias\russian_army_heads_gasmask::main());
  scripts\code\character::precachemodelarray(xmodelalias\russian_army_ar_4_hats_gasmask::main());
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "russian";
  self setModel("body_russian_army_ar_4");
  scripts\code\character::attachhead("russian_army_heads_gasmask", xmodelalias\russian_army_heads_gasmask::main());
  scripts\code\character::attachhat("russian_army_ar_4_hats_gasmask", xmodelalias\russian_army_ar_4_hats_gasmask::main());
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier";
}