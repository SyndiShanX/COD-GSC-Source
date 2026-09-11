/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_ally_so15_3.gsc
***********************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_ctsfo_3");
  self attach("head_sc_m_beck", "", 1);
  self.headmodel = "head_sc_m_beck";
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
  precachemodel("body_ctsfo_3");
  precachemodel("head_sc_m_beck");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "sas";
  self setModel("body_ctsfo_3");
  self attach("head_sc_m_beck", "", 1);
  self.headmodel = "head_sc_m_beck";
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier";
}