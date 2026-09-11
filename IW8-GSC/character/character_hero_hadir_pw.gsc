/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_hero_hadir_pw.gsc
*************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_hero_hadir_al_qatala");
  self attach("head_hero_hadir_al_qatala", "", 1);
  self.headmodel = "head_hero_hadir_al_qatala";
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
  precachemodel("body_hero_hadir_al_qatala");
  precachemodel("head_hero_hadir_al_qatala");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "sas";
  self setModel("body_hero_hadir_al_qatala");
  self attach("head_hero_hadir_al_qatala", "", 1);
  self.headmodel = "head_hero_hadir_al_qatala";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier";
}