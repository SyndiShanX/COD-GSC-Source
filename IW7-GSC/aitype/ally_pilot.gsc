/*********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: aitype\ally_pilot.gsc
*********************************/

main() {
  self.var_17DB = "";
  self.team = "allies";
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
    self _meth_82DC(256, 0);
    self _meth_82DB(768, 1024);
  }

  self.var_394 = lib_0A2F::func_7BEC("rifle");
  var_00 = undefined;
  var_01 = ["character_un_jackal_pilots", "character_un_jackal_pilots", "character_un_jackal_pilots_pt2"];
  switch (scripts\code\character::get_random_character(3, var_00, var_01)) {
    case 0:
      lib_0829::main();
      break;

    case 1:
      lib_0829::main();
      break;

    case 2:
      lib_082C::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  lib_0829::precache();
  lib_0829::precache();
  lib_082C::precache();
  scripts\aitypes\bt_util::init();
  lib_09FD::soldier();
  lib_03AE::func_DEE8();
  lib_0C69::func_2371();
}