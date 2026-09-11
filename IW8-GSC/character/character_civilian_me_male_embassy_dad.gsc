/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_civilian_me_male_embassy_dad.gsc
****************************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_civ_syrkistan_male_4_1");
  self attach("head_sc_m_rozmiarek_civ", "", 1);
  self.headmodel = "head_sc_m_rozmiarek_civ";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "civilian";
  self.voice = "fsa";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_civ_syrkistan_male_4_1");
  precachemodel("head_sc_m_rozmiarek_civ");
}

function main_mp() {
  self.animationarchetype = "civilian";
  self.voice = "fsa";
  self setModel("body_civ_syrkistan_male_4_1");
  self attach("head_sc_m_rozmiarek_civ", "", 1);
  self.headmodel = "head_sc_m_rozmiarek_civ";
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "civilian";
}