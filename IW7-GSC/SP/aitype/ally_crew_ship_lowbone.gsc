/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_crew_ship_lowbone.gsc
*********************************************/

main() {
  self._id_17DB = "";
  self.team = "allies";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "crew";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = "";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self._id_101B4 = "";
  self.behaviortreeasset = "enemy_combatant";
  self._id_1FA9 = "soldier";

  if(isai(self)) {
    self _meth_82DC(256.0, 0.0);
    self _meth_82DB(768.0, 1024.0);
  }

  self.weapon = "none";
  var_0 = undefined;
  var_1 = ["character_un_crew_ship_lowbone", "character_un_crew_ship_med_lowbone", "character_un_crew_ship_drk_lowbone", "character_un_crew_ship_female_lowbone", "character_un_crew_ship_female_med_lowbone"];

  switch (scripts\code\character::get_random_character(5, var_0, var_1)) {
    case 0:
      _id_0771::main();
      break;
    case 1:
      _id_0805::main();
      break;
    case 2:
      _id_070F::main();
      break;
    case 3:
      _id_074A::main();
      break;
    case 4:
      _id_074D::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_0771::precache();
  _id_0805::precache();
  _id_070F::precache();
  _id_074A::precache();
  _id_074D::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}