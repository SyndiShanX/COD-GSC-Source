/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: aitype\enemy_sdf_snow_ar_bc_05.gsc
**********************************************/

main() {
  self.var_17DB = "";
  self.team = "axis";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = lib_0A2F::func_7BEB();
  self.objective_state = 1;
  self.secondaryweapon = "";
  self.var_101B4 = lib_0A2F::func_7BEC("pistol");
  self.behaviortreeasset = "enemy_combatant";
  self.var_1FA9 = "soldier";
  if(isai(self)) {
    self func_82DC(256, 0);
    self func_82DB(768, 1024);
  }

  self.weapon = lib_0A2F::func_7BEC("rifle");
  lib_04EA::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  lib_04EA::precache();
  scripts\aitypes\bt_util::init();
  lib_09FD::soldier();
  lib_03AE::func_DEE8();
  lib_0C69::func_2371();
}