/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_us_rangers_lmg_a_urban.gsc
**********************************************************/

main() {
  self setModel("body_us_rangers_lmg_a_urban");
  codescripts\character::attachhead("alias_us_rangers_heads_a_urban", xmodelalias\alias_us_rangers_heads_a_urban::main());
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_us_rangers_lmg_a_urban");
  codescripts\character::precachemodelarray(xmodelalias\alias_us_rangers_heads_a_urban::main());
}