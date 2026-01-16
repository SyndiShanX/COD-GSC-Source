/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: aitype\enemy_c6_ar.gsc
*********************************************/

main() {
  self.var_17DB = "ai\\c6_assets.csv";
  self.team = "axis";
  self.type = "human";
  self.unittype = "C6";
  self.subclass = "C6";
  self.accuracy = 0.2;
  self.health = 400;
  self.grenadeweapon = lib_0A2F::func_7BEB();
  self.objective_state = 1;
  self.secondaryweapon = "";
  self.var_101B4 = lib_0A2F::func_7BEC("pistol");
  self.behaviortreeasset = "c6";
  self.var_1FA9 = "c6";
  if(isai(self)) {
    self func_82DC(250, 0);
    self func_82DB(600, 600);
  }

  self.weapon = lib_0A2F::func_7BEC("rifle");
  lib_03B9::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  lib_03B9::precache();
  scripts\aitypes\bt_util::init();
  lib_09FD::func_3353();
  lib_03A8::func_DEE8();
  lib_0C32::func_2371();
}