/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\civ_embassy_office_worker_female_2_1.gsc
**************************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_civ_embassy_office_worker_female_2_1");
  self attach("head_sc_f_page_civ", "", 1);
  self.headmodel = "head_sc_f_page_civ";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "civilian";
  self.voice = "unitednations";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_civ_embassy_office_worker_female_2_1");
  precachemodel("head_sc_f_page_civ");
}

function main_mp() {
  self.animationarchetype = "civilian";
  self.voice = "unitednations";
  self setModel("body_civ_embassy_office_worker_female_2_1");
  self attach("head_sc_f_page_civ", "", 1);
  self.headmodel = "head_sc_f_page_civ";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "civilian";
}