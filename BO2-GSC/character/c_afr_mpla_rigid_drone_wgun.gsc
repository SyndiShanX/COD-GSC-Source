/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_afr_mpla_rigid_drone_wgun.gsc
*****************************************************/

#include codescripts\character;
#include xmodelalias\c_afr_mpla_drone_rigid_wgun_als;

main() {
  codescripts\character::setmodelfromarray(xmodelalias\c_afr_mpla_drone_rigid_wgun_als::main());
  self.voice = "unita";
  self.skeleton = "base";
}

precache() {
  codescripts\character::precachemodelarray(xmodelalias\c_afr_mpla_drone_rigid_wgun_als::main());
}