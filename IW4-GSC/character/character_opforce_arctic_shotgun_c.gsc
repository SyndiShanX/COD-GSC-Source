/************************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_opforce_arctic_shotgun_c.gsc
************************************************************/

main() {
  self setModel("body_opforce_arctic_shotgun_c");
  codescripts\character::attachHead("alias_opforce_arctic_heads", xmodelalias\alias_opforce_arctic_heads::main());
  self.voice = "russian";
}

precache() {
  precacheModel("body_opforce_arctic_shotgun_c");
  codescripts\character::precacheModelArray(xmodelalias\alias_opforce_arctic_heads::main());
}