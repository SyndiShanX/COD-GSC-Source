/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_us_rangers_smg_a_desert.gsc
***********************************************************/

main() {
  self setModel("body_us_rangers_smg_a_desert");
  codescripts\character::attachhead("alias_us_rangers_heads_a_desert", xmodelalias\alias_us_rangers_heads_a_desert::main());
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_us_rangers_smg_a_desert");
  codescripts\character::precachemodelarray(xmodelalias\alias_us_rangers_heads_a_desert::main());
}