/**********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_opforce_arab_assault_a.gsc
**********************************************************/

main() {
  self setModel("body_opforce_arab_assault_a");
  codescripts\character::attachHead("alias_opforce_arab_heads", xmodelalias\alias_opforce_arab_heads::main());
  if(issubstr(self.headModel, "hat")) {
    self.hatModel = "hat_opforce_arab_d";
    self attach(self.hatModel);
  }
  self.voice = "arab";
}

precache() {
  precacheModel("body_opforce_arab_assault_a");
  codescripts\character::precacheModelArray(xmodelalias\alias_opforce_arab_heads::main());
  precacheModel("hat_opforce_arab_d");
}