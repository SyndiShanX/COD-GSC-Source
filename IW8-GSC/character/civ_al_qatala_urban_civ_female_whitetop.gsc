/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\civ_al_qatala_urban_civ_female_whitetop.gsc
*****************************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_civ_al_qatala_urban_female_5_1_no_scarf");
  self attach("head_sc_f_daly", "", 1);
  self.headmodel = "head_sc_f_daly";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier";
  self.voice = "alqatalafemale";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_civ_al_qatala_urban_female_5_1_no_scarf");
  precachemodel("head_sc_f_daly");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "alqatalafemale";
  self setModel("body_civ_al_qatala_urban_female_5_1_no_scarf");
  self attach("head_sc_f_daly", "", 1);
  self.headmodel = "head_sc_f_daly";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier";
}