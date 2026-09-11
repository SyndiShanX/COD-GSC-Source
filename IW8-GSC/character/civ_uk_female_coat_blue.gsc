/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\civ_uk_female_coat_blue.gsc
*************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("civ_london_townhouse_female_a_med");
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "civilian_female";
  self.voice = "unitednationsfemale";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("civ_london_townhouse_female_a_med");
}

function main_mp() {
  self.animationarchetype = "civilian_female";
  self.voice = "unitednationsfemale";
  self setModel("civ_london_townhouse_female_a_med");
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "civilian_female";
}