/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_iw8_al_qatala_urban_female_01.gsc
*****************************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_opforce_al_qatala_urban_female_1");
  self attach("head_opforce_al_qatala_urban_female_1", "", 1);
  self.headmodel = "head_opforce_al_qatala_urban_female_1";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "rebel";
  self.voice = "alqatalafemale";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_opforce_al_qatala_urban_female_1");
  precachemodel("head_opforce_al_qatala_urban_female_1");
}

function main_mp() {
  self.animationarchetype = "rebel";
  self.voice = "alqatalafemale";
  self setModel("body_opforce_al_qatala_urban_female_1");
  self attach("head_opforce_al_qatala_urban_female_1", "", 1);
  self.headmodel = "head_opforce_al_qatala_urban_female_1";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "rebel";
}