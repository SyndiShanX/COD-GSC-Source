/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_hero_alex_desert.gsc
****************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_hero_alex_desert");
  self attach("head_hero_alex", "", 1);
  self.headmodel = "head_hero_alex";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier";
  self.voice = "unitedstates";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_hero_alex_desert");
  precachemodel("head_hero_alex");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "unitedstates";
  self setModel("body_hero_alex_desert");
  self attach("head_hero_alex", "", 1);
  self.headmodel = "head_hero_alex";
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier";
}