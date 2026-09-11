/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_hero_kyle_desert.gsc
****************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_hero_kyle_desert");
  self attach("head_hero_kyle_no_hair", "", 1);
  self.headmodel = "head_hero_kyle_no_hair";
  self.hatmodel = "hat_hero_kyle_headset";
  self attach(self.hatmodel);
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier";
  self.voice = "sas";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_hero_kyle_desert");
  precachemodel("head_hero_kyle_no_hair");
  precachemodel("hat_hero_kyle_headset");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "sas";
  self setModel("body_hero_kyle_desert");
  self attach("head_hero_kyle_no_hair", "", 1);
  self.headmodel = "head_hero_kyle_no_hair";
  self.hatmodel = "hat_hero_kyle_headset";
  self attach(self.hatmodel);
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier";
}