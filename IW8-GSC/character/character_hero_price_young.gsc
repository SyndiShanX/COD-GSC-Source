/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_hero_price_young.gsc
****************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_hero_price_young");
  self attach("head_hero_price_young", "", 1);
  self.headmodel = "head_hero_price_young";
  self.bhasthighholster = 0;
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
  precachemodel("body_hero_price_young");
  precachemodel("head_hero_price_young");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "sas";
  self setModel("body_hero_price_young");
  self attach("head_hero_price_young", "", 1);
  self.headmodel = "head_hero_price_young";
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier";
}