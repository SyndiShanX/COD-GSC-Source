/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_events.gsc
***********************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_spetsnaz_lmg_old");
  self attach("head_spetsnaz_lmg_old", "", 1);
  self.headmodel = "head_spetsnaz_lmg_old";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier_lw";
  self.voice = "russian";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_spetsnaz_lmg_old");
  precachemodel("head_spetsnaz_lmg_old");
}

function main_mp() {
  self.animationarchetype = "soldier_lw";
  self.voice = "russian";
  self setModel("body_spetsnaz_lmg_old");
  self attach("head_spetsnaz_lmg_old", "", 1);
  self.headmodel = "head_spetsnaz_lmg_old";
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier_lw";
}