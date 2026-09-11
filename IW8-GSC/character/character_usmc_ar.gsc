/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_usmc_ar.gsc
***********************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_usmc_ar");
  self attach("head_usmc_lmg", "", 1);
  self.headmodel = "head_usmc_lmg";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier";
  self.voice = "unitedstates";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_usmc_ar");
  precachemodel("head_usmc_lmg");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "unitedstates";
  self setModel("body_usmc_ar");
  self attach("head_usmc_lmg", "", 1);
  self.headmodel = "head_usmc_lmg";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier";
}