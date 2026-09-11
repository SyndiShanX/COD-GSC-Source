/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_matchdata.gsc
***********************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_civ_syrkistan_male_8_1");
  self attach("head_sc_m_kargorgis_civ", "", 1);
  self.headmodel = "head_sc_m_kargorgis_civ";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "civilian_cp";
  self.voice = "fsa";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_civ_syrkistan_male_8_1");
  precachemodel("head_sc_m_kargorgis_civ");
}

function main_mp() {
  self.animationarchetype = "civilian_cp";
  self.voice = "fsa";
  self setModel("body_civ_syrkistan_male_8_1");
  self attach("head_sc_m_kargorgis_civ", "", 1);
  self.headmodel = "head_sc_m_kargorgis_civ";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "civilian_cp";
}