/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: aitype\enemy_sdf_snow_ar.gsc
*********************************************/

main() {
  self.var_17DB = "";
  self.team = "axis";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.objective_team = lib_0A2F::func_7BEB();
  self.objective_state = 1;
  self.secondaryweapon = "";
  self.var_101B4 = lib_0A2F::func_7BEC("pistol");
  self.behaviortreeasset = "enemy_combatant";
  self.var_1FA9 = "soldier";
  if(isai(self)) {
    self func_82DC(256, 0);
    self func_82DB(768, 1024);
  }

  self.var_394 = lib_0A2F::func_7BEC("rifle");
  lib_04E9::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  lib_04E9::precache();
  scripts\aitypes\bt_util::init();
  lib_09FD::soldier();
  lib_03AE::func_DEE8();
  lib_0C69::func_2371();
}