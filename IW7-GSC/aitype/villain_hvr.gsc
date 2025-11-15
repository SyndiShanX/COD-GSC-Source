/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\villain_hvr.gsc
***************************************/

main() {
  self.func_17DB = "";
  self.team = "axis";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "noboost";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = "";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self.func_101B4 = "";
  self.behaviortreeasset = "enemy_combatant";
  self.func_1FA9 = "soldier";

  if(isai(self)) {
    self _meth_82DC(256.0, 0.0);
    self _meth_82DB(768.0, 1024.0);
  }

  self.weapon = "none";
  func_0921::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  func_0921::precache();
  scripts\aitypes\bt_util::init();
  func_09FD::soldier();
  func_03AE::func_DEE8();
  func_0C69::func_2371();
}