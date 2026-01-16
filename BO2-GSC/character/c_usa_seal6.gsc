/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_seal6.gsc
**************************************/

#include codescripts\character;
#include xmodelalias\c_usa_seal6_head_als;
#include xmodelalias\c_usa_seal6_gear_als;

main() {
  self setmodel("c_usa_seal6_body");
  self.headmodel = codescripts\character::randomelement(xmodelalias\c_usa_seal6_head_als::main());
  self attach(self.headmodel, "", 1);
  self.gearmodel = codescripts\character::randomelement(xmodelalias\c_usa_seal6_gear_als::main());
  self attach(self.gearmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_seal6_body");
  codescripts\character::precachemodelarray(xmodelalias\c_usa_seal6_head_als::main());
  codescripts\character::precachemodelarray(xmodelalias\c_usa_seal6_gear_als::main());
}