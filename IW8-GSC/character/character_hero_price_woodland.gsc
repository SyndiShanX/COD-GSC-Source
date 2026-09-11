/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_hero_price_woodland.gsc
*******************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_hero_price_woodland");
  self attach("head_hero_price_newrig_bald", "", 1);
  self.headmodel = "head_hero_price_newrig_bald";
  self.hatmodel = "m_hat_hero_price_boonie";
  self attach(self.hatmodel);
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
  precachemodel("body_hero_price_woodland");
  precachemodel("head_hero_price_newrig_bald");
  precachemodel("m_hat_hero_price_boonie");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "sas";
  self setModel("body_hero_price_woodland");
  self attach("head_hero_price_newrig_bald", "", 1);
  self.headmodel = "head_hero_price_newrig_bald";
  self.hatmodel = "m_hat_hero_price_boonie";
  self attach(self.hatmodel);
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier";
}