/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_hero_griggs_desert.gsc
******************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_usmc_basic_griggs");
  self attach("head_sc_m_grigsby", "", 1);
  self.headmodel = "head_sc_m_grigsby";
  self.hatmodel = "hat_sc_m_grigsby_helmet";
  self attach(self.hatmodel);
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier";
  self.voice = "sas";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_usmc_basic_griggs");
  precachemodel("head_sc_m_grigsby");
  precachemodel("hat_sc_m_grigsby_helmet");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "sas";
  self setModel("body_usmc_basic_griggs");
  self attach("head_sc_m_grigsby", "", 1);
  self.headmodel = "head_sc_m_grigsby";
  self.hatmodel = "hat_sc_m_grigsby_helmet";
  self attach(self.hatmodel);
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier";
}