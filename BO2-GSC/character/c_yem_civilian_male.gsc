/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_yem_civilian_male.gsc
*********************************************/

#include codescripts\character;
#include xmodelalias\c_yem_civilian_male_body_als;
#include xmodelalias\c_yem_civilian_male_head_als;

main() {
  codescripts\character::setmodelfromarray(xmodelalias\c_yem_civilian_male_body_als::main());
  self.headmodel = codescripts\character::randomelement(xmodelalias\c_yem_civilian_male_head_als::main());
  self attach(self.headmodel, "", 1);
  self.voice = "terrorist";
  self.skeleton = "base";
}

precache() {
  codescripts\character::precachemodelarray(xmodelalias\c_yem_civilian_male_body_als::main());
  codescripts\character::precachemodelarray(xmodelalias\c_yem_civilian_male_head_als::main());
}