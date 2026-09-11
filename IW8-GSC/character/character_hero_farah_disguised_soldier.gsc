/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_hero_farah_disguised_soldier.gsc
****************************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_hero_farah_disguised");
  self attach("head_hero_farah_disguised", "", 1);
  self.headmodel = "head_hero_farah_disguised";
  self.hatmodel = "hat_shemagh_hero_farah_disguised";
  self attach(self.hatmodel);
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
  precachemodel("body_hero_farah_disguised");
  precachemodel("head_hero_farah_disguised");
  precachemodel("hat_shemagh_hero_farah_disguised");
}

function main_mp() {
  self.animationarchetype = "farah";
  self.voice = "fsafemale";
  self setModel("body_hero_farah_disguised");
  self attach("head_hero_farah_disguised", "", 1);
  self.headmodel = "head_hero_farah_disguised";
  self.hatmodel = "hat_shemagh_hero_farah_disguised";
  self attach(self.hatmodel);
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "farah";
}