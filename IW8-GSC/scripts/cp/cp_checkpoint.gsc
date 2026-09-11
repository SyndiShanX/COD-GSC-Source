/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_checkpoint.gsc
***********************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_spetsnaz_lmg_old");
  scripts\code\character::attachhead("russian_army_heads_gasmask", xmodelalias\russian_army_heads_gasmask::main());
  scripts\code\character::attachhat("russian_army_ar_1_hats_gasmask", xmodelalias\russian_army_ar_1_hats_gasmask::main());
  self.bhasthighholster = 1;
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
  precachemodel("body_spetsnaz_lmg_old");
  scripts\code\character::precachemodelarray(xmodelalias\russian_army_heads_gasmask::main());
  scripts\code\character::precachemodelarray(xmodelalias\russian_army_ar_1_hats_gasmask::main());
}

function main_mp() {
  self.animationarchetype = "soldier_lw";
  self.voice = "russian";
  self setModel("body_spetsnaz_lmg_old");
  scripts\code\character::attachhead("russian_army_heads_gasmask", xmodelalias\russian_army_heads_gasmask::main());
  scripts\code\character::attachhat("russian_army_ar_1_hats_gasmask", xmodelalias\russian_army_ar_1_hats_gasmask::main());
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier_lw";
}