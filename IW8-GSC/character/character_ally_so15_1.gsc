/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_ally_so15_1.gsc
***********************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_ctsfo_1");
  self attach("head_sc_m_montano", "", 1);
  self.headmodel = "head_sc_m_montano";
  self.hatmodel = "hat_sc_m_montano_police_cap";
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
  precachemodel("body_ctsfo_1");
  precachemodel("head_sc_m_montano");
  precachemodel("hat_sc_m_montano_police_cap");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "sas";
  self setModel("body_ctsfo_1");
  self attach("head_sc_m_montano", "", 1);
  self.headmodel = "head_sc_m_montano";
  self.hatmodel = "hat_sc_m_montano_police_cap";
  self attach(self.hatmodel);
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier";
}