/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_hero_kyle_undercover.gsc
********************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_kyle_undercover_st_petersburg");
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
  precachemodel("body_kyle_undercover_st_petersburg");
  precachemodel("head_hero_kyle");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "sas";
  self setModel("body_kyle_undercover_st_petersburg");
  self attach("head_hero_kyle", "", 1);
  self.headmodel = "head_hero_kyle";
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier";
}