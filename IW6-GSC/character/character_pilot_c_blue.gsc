/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_pilot_c_blue.gsc
************************************************/

main() {
  self setModel("body_pilot_c_blue");
  codescripts\character::attachhead("alias_pilot_heads_blue", xmodelalias\alias_pilot_heads_blue::main());
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_pilot_c_blue");
  codescripts\character::precachemodelarray(xmodelalias\alias_pilot_heads_blue::main());
}