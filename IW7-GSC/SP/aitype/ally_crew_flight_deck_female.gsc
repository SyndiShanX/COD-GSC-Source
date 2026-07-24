/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_crew_flight_deck_female.gsc
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
  var_0 = [0.111, 0.222, 0.333, 0.444, 0.556, 0.667, 0.778, 0.889, 1.0];
  var_1 = ["character_un_crew_flight_deck_handler_female", "character_un_crew_flight_deck_maintenance_female", "character_un_crew_flight_deck_ordnance_female", "character_un_crew_flight_deck_plane_captain_female", "character_un_crew_flight_deck_shooter_female", "character_un_crew_flight_deck_fuel_female", "character_un_crew_flight_deck_dropship_captain_female", "character_un_crew_flight_deck_director_female", "character_un_crew_flight_deck_female"];

  switch (scripts\code\character::get_random_character(9, var_0, var_1)) {
    case 0:
      _id_054E::main();
      break;
    case 1:
      _id_0556::main();
      break;
    case 2:
      _id_055C::main();
      break;
    case 3:
      _id_0562::main();
      break;
    case 4:
      _id_056B::main();
      break;
    case 5:
      _id_0548::main();
      break;
    case 6:
      _id_0540::main();
      break;
    case 7:
      _id_053A::main();
      break;
    case 8:
      _id_0545::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_054E::precache();
  _id_0556::precache();
  _id_055C::precache();
  _id_0562::precache();
  _id_056B::precache();
  _id_0548::precache();
  _id_0540::precache();
  _id_053A::precache();
  _id_0545::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}