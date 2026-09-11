/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_opforce_juggernaut_cp.gsc
*********************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_opforce_juggernaut_basebody");
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "juggernaut_cp";
  self.voice = "russian";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("c8_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_opforce_juggernaut_basebody");
}

function main_mp() {
  self.animationarchetype = "juggernaut_cp";
  self.voice = "russian";
  self setModel("body_opforce_juggernaut_basebody");
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "juggernaut_cp";
}