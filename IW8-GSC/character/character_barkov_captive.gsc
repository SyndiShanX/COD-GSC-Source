/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_barkov_captive.gsc
**************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_villain_barkov");
  self attach("head_villain_barkov", "", 1);
  self.headmodel = "head_villain_barkov";
  self.bhasthighholster = 0;
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
  precachemodel("head_villain_barkov");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "russian";
  self setModel("body_villain_barkov");
  self attach("head_villain_barkov", "", 1);
  self.headmodel = "head_villain_barkov";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier";
}