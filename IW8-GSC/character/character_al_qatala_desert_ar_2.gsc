/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_al_qatala_desert_ar_2.gsc
*********************************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\bodies_al_qatala_desert_02::main());
  scripts\code\character::attachhead("heads_al_qatala_desert", xmodelalias\heads_al_qatala_desert::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\bodies_al_qatala_desert_02::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_al_qatala_desert::main());
}

function main_mp() {
  self.animationarchetype = "rebel";
  self.voice = "alqatala";
  scripts\code\character::setmodelfromarray(xmodelalias\bodies_al_qatala_desert_02::main());
  scripts\code\character::attachhead("heads_al_qatala_desert", xmodelalias\heads_al_qatala_desert::main());
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "rebel";
}