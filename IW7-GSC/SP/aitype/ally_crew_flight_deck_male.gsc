/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_crew_flight_deck_male.gsc
*************************************************/

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
  var_1 = ["character_un_crew_flight_deck_handler", "character_un_crew_flight_deck_maintenance", "character_un_crew_flight_deck_ordnance", "character_un_crew_flight_deck_plane_captain", "character_un_crew_flight_deck_shooter", "character_un_crew_flight_deck_fuel", "character_un_crew_flight_deck_dropship_captain", "character_un_crew_flight_deck_director", "character_un_crew_flight_deck", "character_un_crew_flight_deck_handler_pt2", "character_un_crew_flight_deck_maintenance_pt2", "character_un_crew_flight_deck_ordnance_pt2", "character_un_crew_flight_deck_plane_captain_pt2", "character_un_crew_flight_deck_shooter_pt2", "character_un_crew_flight_deck_fuel_pt2", "character_un_crew_flight_deck_dropship_captain_pt2", "character_un_crew_flight_deck_director_pt2", "character_un_crew_flight_deck_pt2"];

  switch (scripts\code\character::get_random_character(18, var_0, var_1)) {
    case 0:
      _id_054D::main();
      break;
    case 1:
      _id_0555::main();
      break;
    case 2:
      _id_055B::main();
      break;
    case 3:
      _id_0561::main();
      break;
    case 4:
      _id_056A::main();
      break;
    case 5:
      _id_0547::main();
      break;
    case 6:
      _id_053F::main();
      break;
    case 7:
      _id_0539::main();
      break;
    case 8:
      _id_0538::main();
      break;
    case 9:
      _id_0550::main();
      break;
    case 10:
      _id_0558::main();
      break;
    case 11:
      _id_055E::main();
      break;
    case 12:
      _id_0564::main();
      break;
    case 13:
      _id_056D::main();
      break;
    case 14:
      _id_054A::main();
      break;
    case 15:
      _id_0542::main();
      break;
    case 16:
      _id_053C::main();
      break;
    case 17:
      _id_0567::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_054D::precache();
  _id_0555::precache();
  _id_055B::precache();
  _id_0561::precache();
  _id_056A::precache();
  _id_0547::precache();
  _id_053F::precache();
  _id_0539::precache();
  _id_0538::precache();
  _id_0550::precache();
  _id_0558::precache();
  _id_055E::precache();
  _id_0564::precache();
  _id_056D::precache();
  _id_054A::precache();
  _id_0542::precache();
  _id_053C::precache();
  _id_0567::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}