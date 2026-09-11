/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\civ_embassy_ambassador_assistant.gsc
**********************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_civ_embassy_ambassador_assistant");
  self attach("head_sc_f_miller", "", 1);
  self.headmodel = "head_sc_f_miller";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "civilian";
  self.voice = "unitednationsfemale";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_civ_embassy_ambassador_assistant");
  precachemodel("head_sc_f_miller");
}

function main_mp() {
  self.animationarchetype = "civilian";
  self.voice = "unitednationsfemale";
  self setModel("body_civ_embassy_ambassador_assistant");
  self attach("head_sc_f_miller", "", 1);
  self.headmodel = "head_sc_f_miller";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "civilian";
}