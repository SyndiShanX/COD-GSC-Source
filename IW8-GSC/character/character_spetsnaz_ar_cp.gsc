/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_spetsnaz_ar_cp.gsc
**************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_spetsnaz_ar");
  self attach("head_spetsnaz_ar", "", 1);
  self.headmodel = "head_spetsnaz_ar";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier_cp";
  self.voice = "russian";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_spetsnaz_ar");
  precachemodel("head_spetsnaz_ar");
}

function main_mp() {
  self.animationarchetype = "soldier_cp";
  self.voice = "russian";
  self setModel("body_spetsnaz_ar");
  self attach("head_spetsnaz_ar", "", 1);
  self.headmodel = "head_spetsnaz_ar";
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier_cp";
}