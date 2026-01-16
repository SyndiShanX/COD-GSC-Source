/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mul_jinan_guard.gsc
*******************************************/

#include codescripts\character;
#include xmodelalias\c_mul_jinan_guard_head_als;

main() {
  self setmodel("c_mul_jinan_guard_body");
  self.headmodel = codescripts\character::randomelement(xmodelalias\c_mul_jinan_guard_head_als::main());
  self attach(self.headmodel, "", 1);
  self.voice = "terrorist";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_mul_jinan_guard_body");
  codescripts\character::precachemodelarray(xmodelalias\c_mul_jinan_guard_head_als::main());
}