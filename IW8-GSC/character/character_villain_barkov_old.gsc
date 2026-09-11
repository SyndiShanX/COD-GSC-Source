/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_villain_barkov_old.gsc
******************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_villain_barkov");
  self attach("head_villain_barkov_old", "", 1);
  self.headmodel = "head_villain_barkov_old";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier";
  self.voice = "russian";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_villain_barkov");
  precachemodel("head_villain_barkov_old");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "russian";
  self setModel("body_villain_barkov");
  self attach("head_villain_barkov_old", "", 1);
  self.headmodel = "head_villain_barkov_old";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier";
}