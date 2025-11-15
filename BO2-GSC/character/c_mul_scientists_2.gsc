/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mul_scientists_2.gsc
********************************************/

#include codescripts\character;
#include xmodelalias\c_mul_scientists_shirt_als;

main() {
  codescripts\character::setmodelfromarray(xmodelalias\c_mul_scientists_shirt_als::main());
  self.headmodel = "c_mul_scientists_head2";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  codescripts\character::precachemodelarray(xmodelalias\c_mul_scientists_shirt_als::main());
  precachemodel("c_mul_scientists_head2");
}