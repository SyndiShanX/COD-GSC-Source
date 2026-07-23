/*********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_tf_141_arctic_shotgun.gsc
*********************************************************/

main() {
  self setModel("body_tf141_shotgun");
  codescripts\character::attachHead("alias_tf141_heads_arctic", xmodelalias\alias_tf141_heads_arctic::main());
  self.voice = "taskforce";
}

precache() {
  precacheModel("body_tf141_shotgun");
  codescripts\character::precacheModelArray(xmodelalias\alias_tf141_heads_arctic::main());
}