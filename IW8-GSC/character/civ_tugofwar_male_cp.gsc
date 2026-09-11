/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\civ_tugofwar_male_cp.gsc
***********************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\bodies_spetsnaz_ar::main());
  self attach("head_spetsnaz_cqc", "", 1);
  self.headmodel = "head_spetsnaz_cqc";
  self.hatmodel = "hat_spetsnaz_helmet_cloth_a_nvg";
  self attach(self.hatmodel);
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier_cp";
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
  self.animationarchetype = "soldier_cp";
  self.voice = "russian";
  scripts\code\character::setmodelfromarray(xmodelalias\bodies_spetsnaz_ar::main());
  self attach("head_spetsnaz_cqc", "", 1);
  self.headmodel = "head_spetsnaz_cqc";
  self.hatmodel = "hat_spetsnaz_helmet_cloth_a_nvg";
  self attach(self.hatmodel);
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier_cp";
}