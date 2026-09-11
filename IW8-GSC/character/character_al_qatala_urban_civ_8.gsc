/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_al_qatala_urban_civ_8.gsc
*********************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_al_qatala_urban_civ_4_2");
  self attach("head_sc_m_tabassomi_civ", "", 1);
  self.headmodel = "head_sc_m_tabassomi_civ";
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
  precachemodel("body_al_qatala_urban_civ_4_2");
  precachemodel("head_sc_m_tabassomi_civ");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "alqatala";
  self setModel("body_al_qatala_urban_civ_4_2");
  self attach("head_sc_m_tabassomi_civ", "", 1);
  self.headmodel = "head_sc_m_tabassomi_civ";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier";
}