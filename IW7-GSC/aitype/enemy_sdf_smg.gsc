/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: aitype\enemy_sdf_smg.gsc
*********************************************/

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

  self.weapon = lib_0A2F::func_7BEC("smg");
  var_0 = undefined;
  var_1 = ["character_sdf_army_ftl_1", "character_sdf_army_light_1", "character_sdf_army_heavy_4"];
  switch (scripts\code\character::get_random_character(3, var_0, var_1)) {
    case 0:
      lib_04D6::main();
      break;

    case 1:
      lib_04FF::main();
      break;

    case 2:
      lib_04EE::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  lib_04D6::precache();
  lib_04FF::precache();
  lib_04EE::precache();
  scripts\aitypes\bt_util::init();
  lib_09FD::soldier();
  lib_03AE::func_DEE8();
  lib_0C69::func_2371();
}