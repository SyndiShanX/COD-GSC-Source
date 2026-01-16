/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mul_jinan_baghandler.gsc
************************************************/

#include codescripts\character;
#include xmodelalias\c_mul_jinan_baghandler_head_als;

main() {
  self setmodel("c_mul_jinan_baghandler_body");
  self.headmodel = codescripts\character::randomelement(xmodelalias\c_mul_jinan_baghandler_head_als::main());
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_mul_jinan_baghandler_body");
  codescripts\character::precachemodelarray(xmodelalias\c_mul_jinan_baghandler_head_als::main());
}