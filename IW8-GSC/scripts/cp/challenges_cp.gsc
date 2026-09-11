/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\challenges_cp.gsc
***********************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_spetsnaz_dmr_old");
  self attach("head_spetsnaz_dmr_old", "", 1);
  self.headmodel = "head_spetsnaz_dmr_old";
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
  precachemodel("body_spetsnaz_dmr_old");
  precachemodel("head_spetsnaz_dmr_old");
}

function main_mp() {
  self.animationarchetype = "soldier_lw";
  self.voice = "russian";
  self setModel("body_spetsnaz_dmr_old");
  self attach("head_spetsnaz_dmr_old", "", 1);
  self.headmodel = "head_spetsnaz_dmr_old";
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier_lw";
}