/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_hero_hadir_prisoner.gsc
*******************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_hero_hadir_prisoner");
  self attach("head_hero_hadir_teen_blendshape", "", 1);
  self.headmodel = "head_hero_hadir_teen_blendshape";
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
  precachemodel("body_hero_hadir_prisoner");
  precachemodel("head_hero_hadir_teen_blendshape");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "sas";
  self setModel("body_hero_hadir_prisoner");
  self attach("head_hero_hadir_teen_blendshape", "", 1);
  self.headmodel = "head_hero_hadir_teen_blendshape";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier";
}