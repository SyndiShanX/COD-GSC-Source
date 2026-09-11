/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\civ_female_interrogation.gsc
**************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("civ_female_interrogation");
  self attach("head_sc_f_mahdawi", "", 1);
  self.headmodel = "head_sc_f_mahdawi";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "civilian_female";
  self.voice = "unitednationsfemale";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("civ_female_interrogation");
  precachemodel("head_sc_f_mahdawi");
}

function main_mp() {
  self.animationarchetype = "civilian_female";
  self.voice = "unitednationsfemale";
  self setModel("civ_female_interrogation");
  self attach("head_sc_f_mahdawi", "", 1);
  self.headmodel = "head_sc_f_mahdawi";
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "civilian_female";
}