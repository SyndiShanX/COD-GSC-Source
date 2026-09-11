/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_sas_pilot_helicopter_cp.gsc
***********************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_pilot_helicopter_british");
  self attach("head_pilot_helicopter_british", "", 1);
  self.headmodel = "head_pilot_helicopter_british";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier_cp";
  self.voice = "sas";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_pilot_helicopter_british");
  precachemodel("head_pilot_helicopter_british");
}

function main_mp() {
  self.animationarchetype = "soldier_cp";
  self.voice = "sas";
  self setModel("body_pilot_helicopter_british");
  self attach("head_pilot_helicopter_british", "", 1);
  self.headmodel = "head_pilot_helicopter_british";
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier_cp";
}