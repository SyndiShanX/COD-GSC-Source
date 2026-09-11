/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_al_qatala_desert_ar.gsc
*******************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_al_qatala_desert_01");
  self attach("head_al_qatala_desert_01", "", 1);
  self.headmodel = "head_al_qatala_desert_01";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "rebel";
  self.voice = "alqatala";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_al_qatala_desert_01");
  precachemodel("head_al_qatala_desert_01");
}

function main_mp() {
  self.animationarchetype = "rebel";
  self.voice = "alqatala";
  self setModel("body_al_qatala_desert_01");
  self attach("head_al_qatala_desert_01", "", 1);
  self.headmodel = "head_al_qatala_desert_01";
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "rebel";
}