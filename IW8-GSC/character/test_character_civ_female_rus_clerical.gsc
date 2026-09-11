/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\test_character_civ_female_rus_clerical.gsc
****************************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_civ_london_female_10_1");
  self attach("head_sc_f_eghbali", "", 1);
  self.headmodel = "head_sc_f_eghbali";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "civilian";
  self.voice = "russianfemale";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_civ_london_female_10_1");
  precachemodel("head_sc_f_eghbali");
}

function main_mp() {
  self.animationarchetype = "civilian";
  self.voice = "russianfemale";
  self setModel("body_civ_london_female_10_1");
  self attach("head_sc_f_eghbali", "", 1);
  self.headmodel = "head_sc_f_eghbali";
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "civilian";
}