/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\civ_syrkistan_male_doctor_nomask.gsc
**********************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("civ_doctor_male_body");
  scripts\code\character::attachhead("civilian_syrkistan_male_head", xmodelalias\civilian_syrkistan_male_head::main());
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "civilian";
  self.voice = "alqatala";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("civ_doctor_male_body");
  scripts\code\character::precachemodelarray(xmodelalias\civilian_syrkistan_male_head::main());
}

function main_mp() {
  self.animationarchetype = "civilian";
  self.voice = "alqatala";
  self setModel("civ_doctor_male_body");
  scripts\code\character::attachhead("civilian_syrkistan_male_head", xmodelalias\civilian_syrkistan_male_head::main());
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "civilian";
}