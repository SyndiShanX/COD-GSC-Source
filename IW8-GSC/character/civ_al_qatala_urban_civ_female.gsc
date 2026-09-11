/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\civ_al_qatala_urban_civ_female.gsc
********************************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\bodies_civ_al_qatala_urban_female::main());
  scripts\code\character::attachhead("heads_civ_al_qatala_urban_female", xmodelalias\heads_civ_al_qatala_urban_female::main());
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier";
  self.voice = "alqatalafemale";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  scripts\code\character::precachemodelarray(xmodelalias\bodies_civ_al_qatala_urban_female::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_civ_al_qatala_urban_female::main());
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "alqatalafemale";
  scripts\code\character::setmodelfromarray(xmodelalias\bodies_civ_al_qatala_urban_female::main());
  scripts\code\character::attachhead("heads_civ_al_qatala_urban_female", xmodelalias\heads_civ_al_qatala_urban_female::main());
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier";
}