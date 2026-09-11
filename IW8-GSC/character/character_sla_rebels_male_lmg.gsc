/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_sla_rebels_male_lmg.gsc
*******************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_sla_rebels_lmg");
  self attach("head_sc_m_nazeri", "", 1);
  self.headmodel = "head_sc_m_nazeri";
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
  precachemodel("body_sla_rebels_lmg");
  precachemodel("head_sc_m_nazeri");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "fsa";
  self setModel("body_sla_rebels_lmg");
  self attach("head_sc_m_nazeri", "", 1);
  self.headmodel = "head_sc_m_nazeri";
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier";
}