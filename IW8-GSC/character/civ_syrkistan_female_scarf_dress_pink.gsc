/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\civ_syrkistan_female_scarf_dress_pink.gsc
***************************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_civ_syrkistan_female_4_1");
  self attach("head_sc_f_mostafavi_civ", "", 1);
  self.headmodel = "head_sc_f_mostafavi_civ";
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
  precachemodel("body_civ_syrkistan_female_4_1");
  precachemodel("head_sc_f_mostafavi_civ");
}

function main_mp() {
  self.animationarchetype = "civilian_female";
  self.voice = "alqatalafemale";
  self setModel("body_civ_syrkistan_female_4_1");
  self attach("head_sc_f_mostafavi_civ", "", 1);
  self.headmodel = "head_sc_f_mostafavi_civ";
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "civilian_female";
}