/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_7thinf_1.gsc
****************************************/

#include codescripts\character;
#include xmodelalias\c_usa_7thinf_head_als;
#include xmodelalias\c_usa_7thinf_gear_als;

main() {
  self setmodel("c_usa_7thinf_body_1");
  self.headmodel = codescripts\character::randomelement(xmodelalias\c_usa_7thinf_head_als::main());
  self attach(self.headmodel, "", 1);
  self.hatmodel = "c_usa_7thinf_helmet_1";
  self attach(self.hatmodel);
  self.gearmodel = codescripts\character::randomelement(xmodelalias\c_usa_7thinf_gear_als::main());
  self attach(self.gearmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_7thinf_body_1");
  codescripts\character::precachemodelarray(xmodelalias\c_usa_7thinf_head_als::main());
  precachemodel("c_usa_7thinf_helmet_1");
  codescripts\character::precachemodelarray(xmodelalias\c_usa_7thinf_gear_als::main());
}