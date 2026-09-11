/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_iw8_russian_weapon_smugglers_1.gsc
******************************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_russian_weapon_smugglers_1");
  self attach("head_russian_army_balaclava_1", "", 1);
  self.headmodel = "head_russian_army_balaclava_1";
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
  precachemodel("body_russian_weapon_smugglers_1");
  precachemodel("head_russian_army_balaclava_1");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "russian";
  self setModel("body_russian_weapon_smugglers_1");
  self attach("head_russian_army_balaclava_1", "", 1);
  self.headmodel = "head_russian_army_balaclava_1";
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "soldier";
}