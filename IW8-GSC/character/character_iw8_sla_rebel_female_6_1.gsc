/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_iw8_sla_rebel_female_6_1.gsc
************************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_sla_rebels_female_6_1");
  self attach("head_sc_f_mendoza", "", 1);
  self.headmodel = "head_sc_f_mendoza";
  self.hatmodel = "hat_sc_f_mendoza_scarf_6_1";
  self attach(self.hatmodel);
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "rebel_female";
  self.voice = "fsafemale";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_sla_rebels_female_6_1");
  precachemodel("head_sc_f_mendoza");
  precachemodel("hat_sc_f_mendoza_scarf_6_1");
}

function main_mp() {
  self.animationarchetype = "rebel_female";
  self.voice = "fsafemale";
  self setModel("body_sla_rebels_female_6_1");
  self attach("head_sc_f_mendoza", "", 1);
  self.headmodel = "head_sc_f_mendoza";
  self.hatmodel = "hat_sc_f_mendoza_scarf_6_1";
  self attach(self.hatmodel);
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "rebel_female";
}