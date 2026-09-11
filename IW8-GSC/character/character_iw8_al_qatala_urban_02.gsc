/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_iw8_al_qatala_urban_02.gsc
**********************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_al_qatala_urban_ar_2_1");
  self attach("head_sc_m_bansal_civ", "", 1);
  self.headmodel = "head_sc_m_bansal_civ";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "rebel";
  self.voice = "alqatala";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_al_qatala_urban_ar_2_1");
  precachemodel("head_sc_m_bansal_civ");
}

function main_mp() {
  self.animationarchetype = "rebel";
  self.voice = "alqatala";
  self setModel("body_al_qatala_urban_ar_2_1");
  self attach("head_sc_m_bansal_civ", "", 1);
  self.headmodel = "head_sc_m_bansal_civ";
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "rebel";
}