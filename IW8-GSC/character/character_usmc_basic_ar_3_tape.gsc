/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_usmc_basic_ar_3_tape.gsc
********************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_usmc_basic_ar_3");
  self attach("head_sc_m_colvin", "", 1);
  self.headmodel = "head_sc_m_colvin";
  self.hatmodel = "hat_sc_m_colvin_mouth_tape";
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
  precachemodel("body_usmc_basic_ar_3");
  precachemodel("head_sc_m_colvin");
  precachemodel("hat_sc_m_colvin_mouth_tape");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "unitedstates";
  self setModel("body_usmc_basic_ar_3");
  self attach("head_sc_m_colvin", "", 1);
  self.headmodel = "head_sc_m_colvin";
  self.hatmodel = "hat_sc_m_colvin_mouth_tape";
  self attach(self.hatmodel);
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier";
}