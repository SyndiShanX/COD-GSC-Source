/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_sas_urban_ar_4.gsc
**************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_sas_urban_ar_4_1");
  scripts\code\character::attachhead("heads_sas_urban_nvg", xmodelalias\heads_sas_urban_nvg::main());
  self.bhasthighholster = 1;
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
  precachemodel("body_sas_urban_ar_4_1");
  scripts\code\character::precachemodelarray(xmodelalias\heads_sas_urban_nvg::main());
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "sas";
  self setModel("body_sas_urban_ar_4_1");
  scripts\code\character::attachhead("heads_sas_urban_nvg", xmodelalias\heads_sas_urban_nvg::main());
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier";
}