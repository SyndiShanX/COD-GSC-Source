/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\25726.gsc
**************************************/

main() {
  self setModel("body_pmc_africa_assault_a");
  codescripts\character::attachhead("alias_pmc_africa_heads", xmodelalias\alias_pmc_africa_heads::main());
  self.voice = "pmc";
}

precache() {
  precachemodel("body_pmc_africa_assault_a");
  codescripts\character::precachemodelarray(xmodelalias\alias_pmc_africa_heads::main());
}