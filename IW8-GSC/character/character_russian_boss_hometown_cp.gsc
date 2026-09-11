/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_russian_boss_hometown_cp.gsc
************************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_russian_soldier_boss");
  self attach("head_russian_soldier_boss", "", 1);
  self.headmodel = "head_russian_soldier_boss";
  self.hatmodel = "hat_russian_soldier_boss";
  self attach(self.hatmodel);
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier_cp";
  self.voice = "russian";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_russian_soldier_boss");
  precachemodel("head_russian_soldier_boss");
  precachemodel("hat_russian_soldier_boss");
}

function main_mp() {
  self.animationarchetype = "soldier_cp";
  self.voice = "russian";
  self setModel("body_russian_soldier_boss");
  self attach("head_russian_soldier_boss", "", 1);
  self.headmodel = "head_russian_soldier_boss";
  self.hatmodel = "hat_russian_soldier_boss";
  self attach(self.hatmodel);
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier_cp";
}