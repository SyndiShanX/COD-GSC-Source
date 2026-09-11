/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_iw8_al_qatala_urban_06.gsc
**********************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_al_qatala_urban_lmg");
  scripts\code\character::attachhead("heads_al_qatala_urban_06", xmodelalias\heads_al_qatala_urban_06::main());
  self.bhasthighholster = 1;
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
  precachemodel("body_al_qatala_urban_lmg");
  scripts\code\character::precachemodelarray(xmodelalias\heads_al_qatala_urban_06::main());
}

function main_mp() {
  self.animationarchetype = "rebel";
  self.voice = "alqatala";
  self setModel("body_al_qatala_urban_lmg");
  scripts\code\character::attachhead("heads_al_qatala_urban_06", xmodelalias\heads_al_qatala_urban_06::main());
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "rebel";
}