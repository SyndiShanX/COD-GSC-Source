/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_pilot_c_purple.gsc
**************************************************/

main() {
  self setModel("body_pilot_c_purple");
  codescripts\character::attachhead("alias_pilot_heads_purple", xmodelalias\alias_pilot_heads_purple::main());
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_pilot_c_purple");
  codescripts\character::precachemodelarray(xmodelalias\alias_pilot_heads_purple::main());
}