/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\test_character_farah_father.gsc
*****************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_hero_farahs_father");
  self attach("head_hero_farahs_father", "", 1);
  self.headmodel = "head_hero_farahs_father";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "father";
  self.voice = "fsa";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_hero_farahs_father");
  precachemodel("head_hero_farahs_father");
}

function main_mp() {
  self.animationarchetype = "father";
  self.voice = "fsa";
  self setModel("body_hero_farahs_father");
  self attach("head_hero_farahs_father", "", 1);
  self.headmodel = "head_hero_farahs_father";
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "father";
}