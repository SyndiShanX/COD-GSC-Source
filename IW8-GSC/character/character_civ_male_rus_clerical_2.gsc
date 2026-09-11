/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_civ_male_rus_clerical_2.gsc
***********************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_civ_russian_dead_clerical_male_1");
  self attach("head_sc_m_androsov_civ", "", 1);
  self.headmodel = "head_sc_m_androsov_civ";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "civilian";
  self.voice = "russian";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_civ_russian_dead_clerical_male_1");
  precachemodel("head_sc_m_androsov_civ");
}

function main_mp() {
  self.animationarchetype = "civilian";
  self.voice = "russian";
  self setModel("body_civ_russian_dead_clerical_male_1");
  self attach("head_sc_m_androsov_civ", "", 1);
  self.headmodel = "head_sc_m_androsov_civ";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "civilian";
}