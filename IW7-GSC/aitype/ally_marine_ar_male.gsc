/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_marine_ar_male.gsc
******************************************/

main() {
  self.var_17DB = "";
  self.team = "allies";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = func_0A2F::func_7BEB();
  self.grenadeammo = 1;
  self.secondaryweapon = "";
  self.var_101B4 = func_0A2F::func_7BEC("pistol");
  self.behaviortreeasset = "enemy_combatant";
  self.var_1FA9 = "soldier";

  if(isai(self)) {
    self func_82DC(256.0, 0.0);
    self func_82DB(768.0, 1024.0);
  }

  self.weapon = func_0A2F::func_7BEC("rifle");
  func_08A3::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  func_08A3::precache();
  scripts\aitypes\bt_util::init();
  func_09FD::soldier();
  func_03AE::func_DEE8();
  func_0C69::func_2371();
}