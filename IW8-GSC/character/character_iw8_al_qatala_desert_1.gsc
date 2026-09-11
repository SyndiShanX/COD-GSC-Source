/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_iw8_al_qatala_desert_1.gsc
**********************************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\bodies_al_qatala_desert_01::main());
  self attach("head_al_qatala_desert_01", "", 1);
  self.headmodel = "head_al_qatala_desert_01";
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
  scripts\code\character::precachemodelarray(xmodelalias\bodies_al_qatala_desert_01::main());
  precachemodel("head_al_qatala_desert_01");
}

function main_mp() {
  self.animationarchetype = "rebel";
  self.voice = "alqatala";
  scripts\code\character::setmodelfromarray(xmodelalias\bodies_al_qatala_desert_01::main());
  self attach("head_al_qatala_desert_01", "", 1);
  self.headmodel = "head_al_qatala_desert_01";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "rebel";
}