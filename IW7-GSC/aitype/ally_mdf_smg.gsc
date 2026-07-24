/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_mdf_smg.gsc
**************************************/

main() {
  self._id_17DB = "";
  self.team = "allies";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "MDF";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = _id_0A2F::_id_7BEB();
  self.grenadeammo = 1;
  self.secondaryweapon = "";
  self._id_101B4 = "";
  self.behaviortreeasset = "enemy_combatant";
  self._id_1FA9 = "soldier";

  if(isai(self)) {
    self _meth_82DC(256.0, 0.0);
    self _meth_82DB(768.0, 1024.0);
  }

  self.weapon = _id_0A2F::_id_7BEC("smg");
  var_0 = undefined;
  var_1 = ["character_un_moon_guard", "character_un_moon_guard_female"];

  switch (scripts\code\character::get_random_character(2, var_0, var_1)) {
    case 0:
      _id_08C2::main();
      break;
    case 1:
      _id_08C3::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_08C2::precache();
  _id_08C3::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}