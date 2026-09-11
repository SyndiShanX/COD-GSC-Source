/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\test_character_crew_male_vest_picc_01.gsc
***************************************************************/

#using_animtree("generic_human");

function main() {
  self setModel("body_opforce_london_terrorist_1_bomb_vest");
  scripts\code\character::attachhead("test_enemy_picc_heads", xmodelalias\test_enemy_picc_heads::main());
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self.animationarchetype = "suicidebomber";
  self.voice = "alqatala";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("body_opforce_london_terrorist_1_bomb_vest");
  scripts\code\character::precachemodelarray(xmodelalias\test_enemy_picc_heads::main());
}

function main_mp() {
  self.animationarchetype = "suicidebomber";
  self.voice = "alqatala";
  self setModel("body_opforce_london_terrorist_1_bomb_vest");
  scripts\code\character::attachhead("test_enemy_picc_heads", xmodelalias\test_enemy_picc_heads::main());
}

function precache_mp(var_0) {
  level.agent_definition[var_0]["animclass"] = "suicidebomber";
}