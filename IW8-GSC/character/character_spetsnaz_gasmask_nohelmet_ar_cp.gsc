/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_spetsnaz_gasmask_nohelmet_ar_cp.gsc
*******************************************************************/

#using_animtree("soldier_lw_br");

function main() {
  scripts\code\character::setmodelfromarray(scripts\cp\cp_rank::main());
  self attach("head_russian_army_balaclava_2_civ_br", "", 1);
  self.headmodel = "head_russian_army_balaclava_2_civ_br";
  self.bhasthighholster = 1;
  self.animtree = "soldier_lw_br";
  self.animationarchetype = "soldier_lw_br";
  self.voice = "russian";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  scripts\code\character::precachemodelarray(scripts\cp\cp_rank::main());
  precachemodel("head_russian_army_balaclava_2_civ_br");
}

function main_mp() {
  self.animationarchetype = "soldier_lw_br";
  self.voice = "russian";
  scripts\code\character::setmodelfromarray(scripts\cp\cp_rank::main());
  self attach("head_russian_army_balaclava_2_civ_br", "", 1);
  self.headmodel = "head_russian_army_balaclava_2_civ_br";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier_lw_br";
}