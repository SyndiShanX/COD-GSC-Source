/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_spetsnaz_cqc_nvg_cp.gsc
*******************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_usmc_basic_ar_4");
  scripts\code\character::attachhead("heads_usmc_male", xmodelalias\heads_usmc_male::main());
  self.hatmodel = "helmet_usmc_basic_ar_4";
  self attach(self.hatmodel);
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier_cp";
  self.voice = "unitedstates";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_usmc_basic_ar_4");
  scripts\code\character::precachemodelarray(xmodelalias\heads_usmc_male::main());
  precachemodel("helmet_usmc_basic_ar_4");
}

function main_mp() {
  self.animationarchetype = "soldier_cp";
  self.voice = "unitedstates";
  self setModel("body_usmc_basic_ar_4");
  scripts\code\character::attachhead("heads_usmc_male", xmodelalias\heads_usmc_male::main());
  self.hatmodel = "helmet_usmc_basic_ar_4";
  self attach(self.hatmodel);
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier_cp";
}