/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\civ_syrkistan_female_nurse_mask.gsc
*********************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_civ_nurse_female_no_scarf");
  self attach("head_sc_f_eghbali_civ", "", 1);
  self.headmodel = "head_sc_f_eghbali_civ";
  self.hatmodel = "hat_civ_nurse_female";
  self attach(self.hatmodel);
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "civilian_female";
  self.voice = "alqatalafemale";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_civ_nurse_female_no_scarf");
  precachemodel("head_sc_f_eghbali_civ");
  precachemodel("hat_civ_nurse_female");
}

function main_mp() {
  self.animationarchetype = "civilian_female";
  self.voice = "alqatalafemale";
  self setModel("body_civ_nurse_female_no_scarf");
  self attach("head_sc_f_eghbali_civ", "", 1);
  self.headmodel = "head_sc_f_eghbali_civ";
  self.hatmodel = "hat_civ_nurse_female";
  self attach(self.hatmodel);
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "civilian_female";
}