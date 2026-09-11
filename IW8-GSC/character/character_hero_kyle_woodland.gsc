/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_hero_kyle_woodland.gsc
******************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_hero_kyle_woodland_nopatches");
  self attach("head_hero_kyle", "", 1);
  self.headmodel = "head_hero_kyle";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier";
  self.voice = "sas";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_hero_kyle_woodland_nopatches");
  precachemodel("head_hero_kyle");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "sas";
  self setModel("body_hero_kyle_woodland_nopatches");
  self attach("head_hero_kyle", "", 1);
  self.headmodel = "head_hero_kyle";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier";
}