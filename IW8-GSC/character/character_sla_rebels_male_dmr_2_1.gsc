/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_sla_rebels_male_dmr_2_1.gsc
***********************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_sla_rebels_dmr_2_1");
  self attach("head_sc_m_swaynos_no_hair", "", 1);
  self.headmodel = "head_sc_m_swaynos_no_hair";
  self.hatmodel = "hat_sla_rebels_dmr_2_1";
  self attach(self.hatmodel);
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier";
  self.voice = "fsa";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_sla_rebels_dmr_2_1");
  precachemodel("head_sc_m_swaynos_no_hair");
  precachemodel("hat_sla_rebels_dmr_2_1");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "fsa";
  self setModel("body_sla_rebels_dmr_2_1");
  self attach("head_sc_m_swaynos_no_hair", "", 1);
  self.headmodel = "head_sc_m_swaynos_no_hair";
  self.hatmodel = "hat_sla_rebels_dmr_2_1";
  self attach(self.hatmodel);
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier";
}