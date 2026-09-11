/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\hero_xo_farah_variant.gsc
***********************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_hero_farah");
  self attach("head_hero_farah", "", 1);
  self.headmodel = "head_hero_farah";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "farah";
  self.voice = "fsafemale";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_hero_farah");
  precachemodel("head_hero_farah");
}

function main_mp() {
  self.animationarchetype = "farah";
  self.voice = "fsafemale";
  self setModel("body_hero_farah");
  self attach("head_hero_farah", "", 1);
  self.headmodel = "head_hero_farah";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "farah";
}