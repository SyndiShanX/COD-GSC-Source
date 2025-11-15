/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_marine_ar.gsc
***************************************/

main() {
  self.func_17DB = "";
  self.team = "allies";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = func_0A2F::func_7BEB();
  self.grenadeammo = 1;
  self.secondaryweapon = "";
  self.func_101B4 = func_0A2F::func_7BEC("pistol");
  self.behaviortreeasset = "enemy_combatant";
  self.func_1FA9 = "soldier";

  if(isai(self)) {
    self _meth_82DC(256.0, 0.0);
    self _meth_82DB(768.0, 1024.0);
  }

  self.weapon = func_0A2F::func_7BEC("rifle");
  var_00 = undefined;
  var_01 = ["character_un_marines", "character_un_marines_female"];

  switch (scripts\code\character::get_random_character(2, var_00, var_01)) {
    case 0:
      func_08A3::main();
      break;
    case 1:
      func_08B0::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  func_08A3::precache();
  func_08B0::precache();
  scripts\aitypes\bt_util::init();
  func_09FD::soldier();
  func_03AE::func_DEE8();
  func_0C69::func_2371();
}