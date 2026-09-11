/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_al_qatala_urban_cqb_variant.gsc
***************************************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\bodies_al_qatala_urban_cqb_variant::main());
  scripts\code\character::attachhead("heads_al_qatala_urban_ar_variant", xmodelalias\heads_al_qatala_urban_ar_variant::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\bodies_al_qatala_urban_cqb_variant::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_al_qatala_urban_ar_variant::main());
}

function main_mp() {
  self.animationarchetype = "rebel";
  self.voice = "alqatala";
  scripts\code\character::setmodelfromarray(xmodelalias\bodies_al_qatala_urban_cqb_variant::main());
  scripts\code\character::attachhead("heads_al_qatala_urban_ar_variant", xmodelalias\heads_al_qatala_urban_ar_variant::main());
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "rebel";
}