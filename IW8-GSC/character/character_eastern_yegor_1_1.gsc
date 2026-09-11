/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_eastern_yegor_1_1.gsc
*****************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_mp_eastern_yegor_1_1");
  self attach("head_mp_eastern_yegor_1_1", "", 1);
  self.headmodel = "head_mp_eastern_yegor_1_1";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier";
  self.voice = "unitednations";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_mp_eastern_yegor_1_1");
  precachemodel("head_mp_eastern_yegor_1_1");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "unitednations";
  self setModel("body_mp_eastern_yegor_1_1");
  self attach("head_mp_eastern_yegor_1_1", "", 1);
  self.headmodel = "head_mp_eastern_yegor_1_1";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier";
}