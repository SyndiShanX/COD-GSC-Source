/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_hero_nikolai_st_petersburg.gsc
**************************************************************/

#using_animtree("generic_human");

function main() {
  scripts\code\character::setmodelfromarray(xmodelalias\alias_hero_stpetersburg_nikilai_body::main());
  self attach("head_hero_nikolai", "", 1);
  self.headmodel = "head_hero_nikolai";
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
  scripts\code\character::precachemodelarray(xmodelalias\alias_hero_stpetersburg_nikilai_body::main());
  precachemodel("head_hero_nikolai");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "sas";
  scripts\code\character::setmodelfromarray(xmodelalias\alias_hero_stpetersburg_nikilai_body::main());
  self attach("head_hero_nikolai", "", 1);
  self.headmodel = "head_hero_nikolai";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier";
}