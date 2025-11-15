/********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: aitype\enemy_c12.gsc
********************************/

main() {
  self.var_17DB = "ai\\c12_assets.csv";
  self.team = "axis";
  self.type = "human";
  self.unittype = "C12";
  self.subclass = "C12";
  self.accuracy = 0.2;
  self.health = 10000;
  self.objective_team = "";
  self.objective_state = 0;
  self.secondaryweapon = "iw7_c12gatling";
  self.var_101B4 = "";
  self.behaviortreeasset = "c12";
  self.var_1FA9 = "C12";
  if(isai(self)) {
    self _meth_82DC(256, 0);
    self _meth_82DB(768, 1024);
  }

  self.var_394 = "iw7_c12rocket";
  lib_04B2::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  lib_04B2::precache();
  scripts\aitypes\bt_util::init();
  lib_09FD::func_3508();
  lib_03AC::func_DEE8();
  lib_0C48::func_2371();
  precacheitem("iw7_c12rocket");
  precacheitem("iw7_c12gatling");
}