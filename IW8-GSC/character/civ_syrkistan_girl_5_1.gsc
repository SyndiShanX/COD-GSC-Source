/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\civ_syrkistan_girl_5_1.gsc
************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_civ_syrkistan_girl_5_1");
  self attach("head_sc_f_mendoza_child", "", 1);
  self.headmodel = "head_sc_f_mendoza_child";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "civilian";
  self.voice = "fsafemale";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_civ_syrkistan_girl_5_1");
  precachemodel("head_sc_f_mendoza_child");
}

function main_mp() {
  self.animationarchetype = "civilian";
  self.voice = "fsafemale";
  self setModel("body_civ_syrkistan_girl_5_1");
  self attach("head_sc_f_mendoza_child", "", 1);
  self.headmodel = "head_sc_f_mendoza_child";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "civilian";
}