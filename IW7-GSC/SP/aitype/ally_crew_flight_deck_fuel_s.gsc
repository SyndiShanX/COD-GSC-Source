/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_crew_flight_deck_fuel_s.gsc
***************************************************/

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
  var_0 = [0.25, 0.75, 1.0];
  var_1 = ["character_un_crew_flight_deck_fuel_sealed", "character_un_crew_flight_deck_fuel_female_sealed", "character_un_crew_flight_deck_fuel_sealed_pt2"];

  switch (scripts\code\character::get_random_character(3, var_0, var_1)) {
    case 0:
      _id_054B::main();
      break;
    case 1:
      _id_0549::main();
      break;
    case 2:
      _id_054C::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_054B::precache();
  _id_0549::precache();
  _id_054C::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}