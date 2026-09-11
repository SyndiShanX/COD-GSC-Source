/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_london_police_hivis.gsc
*******************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("civilian_london_police_male_1_body");
  scripts\code\character::attachhead("heads_london_police", xmodelalias\heads_london_police::main());
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "soldier_pistol";
  self.voice = "unitednations";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("civilian_london_police_male_1_body");
  scripts\code\character::precachemodelarray(xmodelalias\heads_london_police::main());
}

function main_mp() {
  self.animationarchetype = "soldier_pistol";
  self.voice = "unitednations";
  self setModel("civilian_london_police_male_1_body");
  scripts\code\character::attachhead("heads_london_police", xmodelalias\heads_london_police::main());
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "soldier_pistol";
}