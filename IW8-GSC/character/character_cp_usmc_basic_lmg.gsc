/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_cp_usmc_basic_lmg.gsc
*****************************************************/

#using_animtree("soldier_lw_br");

function main() {
  self setModel("c_s4_wz_ger_afr_ar_02");
  self attach("head_sc_m_reshetniak", "", 1);
  self.headmodel = "head_sc_m_reshetniak";
  self.hatmodel = "c_s4_wz_ger_afr_rpg_helmet_01";
  self attach(self.hatmodel);
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
  precachemodel("c_s4_wz_ger_afr_ar_02");
  precachemodel("head_sc_m_reshetniak");
  precachemodel("c_s4_wz_ger_afr_rpg_helmet_01");
}

function main_mp() {
  self.animationarchetype = "soldier_lw_br";
  self.voice = "russian";
  self setModel("c_s4_wz_ger_afr_ar_02");
  self attach("head_sc_m_reshetniak", "", 1);
  self.headmodel = "head_sc_m_reshetniak";
  self.hatmodel = "c_s4_wz_ger_afr_rpg_helmet_01";
  self attach(self.hatmodel);
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier_lw_br";
}