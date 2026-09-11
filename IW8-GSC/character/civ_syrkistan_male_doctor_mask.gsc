/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\civ_syrkistan_male_doctor_mask.gsc
********************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("civ_doctor_male_body");
  self attach("head_sc_m_bansal_civ", "", 1);
  self.headmodel = "head_sc_m_bansal_civ";
  self.hatmodel = "civ_doctor_male_hat_mask";
  self attach(self.hatmodel);
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "civilian";
  self.voice = "alqatala";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("civ_doctor_male_body");
  precachemodel("head_sc_m_bansal_civ");
  precachemodel("civ_doctor_male_hat_mask");
}

function main_mp() {
  self.animationarchetype = "civilian";
  self.voice = "alqatala";
  self setModel("civ_doctor_male_body");
  self attach("head_sc_m_bansal_civ", "", 1);
  self.headmodel = "head_sc_m_bansal_civ";
  self.hatmodel = "civ_doctor_male_hat_mask";
  self attach(self.hatmodel);
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "civilian";
}