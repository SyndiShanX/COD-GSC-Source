/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_rus_pilot_helicopter.gsc
********************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_russian_helicopter_pilot");
  self attach("head_russian_helicopter_pilot", "", 1);
  self.headmodel = "head_russian_helicopter_pilot";
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
  precachemodel("body_russian_helicopter_pilot");
  precachemodel("head_russian_helicopter_pilot");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "russian";
  self setModel("body_russian_helicopter_pilot");
  self attach("head_russian_helicopter_pilot", "", 1);
  self.headmodel = "head_russian_helicopter_pilot";
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier";
}