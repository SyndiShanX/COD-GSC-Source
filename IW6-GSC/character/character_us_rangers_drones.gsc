/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_us_rangers_drones.gsc
*****************************************************/

main() {
  codescripts\character::setmodelfromarray(xmodelalias\alias_us_rangers_drone_bodies::main());
  codescripts\character::attachhead("alias_us_rangers_drone_heads", xmodelalias\alias_us_rangers_drone_heads::main());
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  codescripts\character::precachemodelarray(xmodelalias\alias_us_rangers_drone_bodies::main());
  codescripts\character::precachemodelarray(xmodelalias\alias_us_rangers_drone_heads::main());
}