/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_spetsnaz_ar_nvg_fixed.gsc
*********************************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\bodies_spetsnaz_ar::main());
  self attach("head_spetsnaz_cqc", "", 1);
  self.headmodel = "head_spetsnaz_cqc";
  self.hatmodel = "hat_spetsnaz_helmet_cloth_a_nvg";
  self attach(self.hatmodel);
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
  precachemodel("head_spetsnaz_cqc");
  precachemodel("hat_spetsnaz_helmet_cloth_a_nvg");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "russian";
  scripts\code\character::setmodelfromarray(xmodelalias\bodies_spetsnaz_ar::main());
  self attach("head_spetsnaz_cqc", "", 1);
  self.headmodel = "head_spetsnaz_cqc";
  self.hatmodel = "hat_spetsnaz_helmet_cloth_a_nvg";
  self attach(self.hatmodel);
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier";
}