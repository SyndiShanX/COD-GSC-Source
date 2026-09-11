/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_civ_russian_police_officer.gsc
**************************************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\bodies_civ_russian_police_officer::main());
  scripts\code\character::attachhead("heads_civ_russian_police_officer", xmodelalias\heads_civ_russian_police_officer::main());
  scripts\code\character::attachhat("hats_civ_russian_police_officer", xmodelalias\hats_civ_russian_police_officer::main());
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "rebel";
  self.voice = "russian";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  scripts\code\character::precachemodelarray(xmodelalias\bodies_civ_russian_police_officer::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_civ_russian_police_officer::main());
  scripts\code\character::precachemodelarray(xmodelalias\hats_civ_russian_police_officer::main());
}

function main_mp() {
  self.animationarchetype = "rebel";
  self.voice = "russian";
  scripts\code\character::setmodelfromarray(xmodelalias\bodies_civ_russian_police_officer::main());
  scripts\code\character::attachhead("heads_civ_russian_police_officer", xmodelalias\heads_civ_russian_police_officer::main());
  scripts\code\character::attachhat("hats_civ_russian_police_officer", xmodelalias\hats_civ_russian_police_officer::main());
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "rebel";
}