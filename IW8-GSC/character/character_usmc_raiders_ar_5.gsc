/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_usmc_raiders_ar_5.gsc
*****************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_usmc_raiders_ar_5");
  self attach("head_sc_m_valladares", "", 1);
  self.headmodel = "head_sc_m_valladares";
  self.hatmodel = "hat_usmc_raiders_ar_5";
  self attach(self.hatmodel);
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier";
  self.voice = "unitedstates";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_usmc_raiders_ar_5");
  precachemodel("head_sc_m_valladares");
  precachemodel("hat_usmc_raiders_ar_5");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "unitedstates";
  self setModel("body_usmc_raiders_ar_5");
  self attach("head_sc_m_valladares", "", 1);
  self.headmodel = "head_sc_m_valladares";
  self.hatmodel = "hat_usmc_raiders_ar_5";
  self attach(self.hatmodel);
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier";
}