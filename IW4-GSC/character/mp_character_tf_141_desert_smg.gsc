/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_tf_141_desert_smg.gsc
********************************************************/

main() {
  self setModel("mp_body_desert_tf141_smg");
  codescripts\character::attachHead("alias_tf141_heads_desert", xmodelalias\alias_tf141_heads_desert::main());
  self setViewmodel("viewhands_tf141");
  self.voice = "taskforce";
}

precache() {
  precacheModel("mp_body_desert_tf141_smg");
  codescripts\character::precacheModelArray(xmodelalias\alias_tf141_heads_desert::main());
  precacheModel("viewhands_tf141");
}