/*************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_iw8_russian_weapon_smugglers_burned_1.gsc
*************************************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("white_phosphorous_burntbody_male");
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
  precachemodel("white_phosphorous_burntbody_male");
}

function main_mp() {
  self.animationarchetype = "soldier";
  self.voice = "russian";
  self setModel("white_phosphorous_burntbody_male");
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier";
}