/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_chn_pla_nogib.gsc
*****************************************/

#include codescripts\character;
#include xmodelalias\c_chn_pla_head_als;
#include xmodelalias\c_chn_pla_gear_als;

main() {
  self setmodel("c_chn_pla_body");
  self.headmodel = codescripts\character::randomelement(xmodelalias\c_chn_pla_head_als::main());
  self attach(self.headmodel, "", 1);
  self.gearmodel = codescripts\character::randomelement(xmodelalias\c_chn_pla_gear_als::main());
  self attach(self.gearmodel, "", 1);
  self.voice = "chinese";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_chn_pla_body");
  codescripts\character::precachemodelarray(xmodelalias\c_chn_pla_head_als::main());
  codescripts\character::precachemodelarray(xmodelalias\c_chn_pla_gear_als::main());
}