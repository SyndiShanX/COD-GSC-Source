/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_al_qatala_urban_civ_4.gsc
*********************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_al_qatala_urban_civ_4_1");
  self attach("head_sc_m_arakelyan_civ", "", 1);
  self.headmodel = "head_sc_m_arakelyan_civ";
  self.hatmodel = "hat_sc_m_arakelyan_civ_baseball_cap";
  self attach(self.hatmodel);
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier";
  self.voice = "alqatala";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_al_qatala_urban_civ_4_1");
  precachemodel("head_sc_m_arakelyan_civ");
  precachemodel("hat_sc_m_arakelyan_civ_baseball_cap");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "alqatala";
  self setModel("body_al_qatala_urban_civ_4_1");
  self attach("head_sc_m_arakelyan_civ", "", 1);
  self.headmodel = "head_sc_m_arakelyan_civ";
  self.hatmodel = "hat_sc_m_arakelyan_civ_baseball_cap";
  self attach(self.hatmodel);
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier";
}