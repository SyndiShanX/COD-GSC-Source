/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_hero_price_undercover.gsc
*********************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_hero_price_undercover");
  self attach("head_hero_price_newrig_bald", "", 1);
  self.headmodel = "head_hero_price_newrig_bald";
  self.hatmodel = "hat_hero_price_undercover_beanie";
  self attach(self.hatmodel);
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
  precachemodel("body_hero_price_undercover");
  precachemodel("head_hero_price_newrig_bald");
  precachemodel("hat_hero_price_undercover_beanie");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "sas";
  self setModel("body_hero_price_undercover");
  self attach("head_hero_price_newrig_bald", "", 1);
  self.headmodel = "head_hero_price_newrig_bald";
  self.hatmodel = "hat_hero_price_undercover_beanie";
  self attach(self.hatmodel);
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier";
}