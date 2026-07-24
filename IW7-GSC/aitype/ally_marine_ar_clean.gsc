/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_marine_ar_clean.gsc
*******************************************/

main() {
  self._id_17DB = "";
  self.team = "allies";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = _id_0A2F::_id_7BEB();
  self.grenadeammo = 1;
  self.secondaryweapon = "";
  self._id_101B4 = _id_0A2F::_id_7BEC("pistol");
  self.behaviortreeasset = "enemy_combatant";
  self._id_1FA9 = "soldier";

  if(isai(self)) {
    self _meth_82DC(256.0, 0.0);
    self _meth_82DB(768.0, 1024.0);
  }

  self.weapon = _id_0A2F::_id_7BEC("rifle");
  var_0 = undefined;
  var_1 = ["character_un_marines_clean", "character_un_marines_female_clean"];

  switch (scripts\code\character::get_random_character(2, var_0, var_1)) {
    case 0:
      _id_08AC::main();
      break;
    case 1:
      _id_08B7::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_08AC::precache();
  _id_08B7::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}