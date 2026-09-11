/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_spetsnaz_gasmask_lmg_trial.gsc
**************************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_opforce_juggernaut");
  self attach("head_opforce_juggernaut", "", 1);
  self.headmodel = "head_opforce_juggernaut";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "juggernaut_lw";
  self.voice = "russian";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("c8_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_opforce_juggernaut");
  precachemodel("head_opforce_juggernaut");
}

function main_mp() {
  self.animationarchetype = "juggernaut_lw";
  self.voice = "russian";
  self setModel("body_opforce_juggernaut");
  self attach("head_opforce_juggernaut", "", 1);
  self.headmodel = "head_opforce_juggernaut";
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "juggernaut_lw";
}