/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_crew_flight_deck_s.gsc
**********************************************/

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
  var_0 = [0.028, 0.083, 0.111, 0.167, 0.194, 0.25, 0.278, 0.333, 0.361, 0.417, 0.444, 0.5, 0.528, 0.583, 0.611, 0.667, 0.694, 0.75, 0.778, 0.806, 0.833, 0.861, 0.889, 0.917, 0.944, 0.972, 1.0];
  var_1 = ["character_un_crew_flight_deck_handler_sealed", "character_un_crew_flight_deck_handler_female_sealed", "character_un_crew_flight_deck_maintenance_sealed", "character_un_crew_flight_deck_maintenance_female_sealed", "character_un_crew_flight_deck_ordnance_sealed", "character_un_crew_flight_deck_ordnance_female_sealed", "character_un_crew_flight_deck_plane_captain_sealed", "character_un_crew_flight_deck_plane_captain_female_sealed", "character_un_crew_flight_deck_shooter_sealed", "character_un_crew_flight_deck_shooter_female_sealed", "character_un_crew_flight_deck_sealed", "character_un_crew_flight_deck_female_sealed", "character_un_crew_flight_deck_director_sealed", "character_un_crew_flight_deck_director_female_sealed", "character_un_crew_flight_deck_dropship_captain_sealed", "character_un_crew_flight_deck_dropship_captain_female_sealed", "character_un_crew_flight_deck_fuel_sealed", "character_un_crew_flight_deck_fuel_female_sealed", "character_un_crew_flight_deck_handler_sealed_pt2", "character_un_crew_flight_deck_maintenance_sealed_pt2", "character_un_crew_flight_deck_ordnance_sealed_pt2", "character_un_crew_flight_deck_plane_captain_sealed_pt2", "character_un_crew_flight_deck_shooter_sealed_pt2", "character_un_crew_flight_deck_sealed_pt2", "character_un_crew_flight_deck_director_sealed_pt2", "character_un_crew_flight_deck_dropship_captain_sealed_pt2", "character_un_crew_flight_deck_fuel_sealed_pt2"];

  switch (scripts\code\character::get_random_character(27, var_0, var_1)) {
    case 0:
      _id_0551::main();
      break;
    case 1:
      _id_054F::main();
      break;
    case 2:
      _id_0559::main();
      break;
    case 3:
      _id_0557::main();
      break;
    case 4:
      _id_055F::main();
      break;
    case 5:
      _id_055D::main();
      break;
    case 6:
      _id_0565::main();
      break;
    case 7:
      _id_0563::main();
      break;
    case 8:
      _id_056E::main();
      break;
    case 9:
      _id_056C::main();
      break;
    case 10:
      _id_0568::main();
      break;
    case 11:
      _id_0546::main();
      break;
    case 12:
      _id_053D::main();
      break;
    case 13:
      _id_053B::main();
      break;
    case 14:
      _id_0543::main();
      break;
    case 15:
      _id_0541::main();
      break;
    case 16:
      _id_054B::main();
      break;
    case 17:
      _id_0549::main();
      break;
    case 18:
      _id_0552::main();
      break;
    case 19:
      _id_055A::main();
      break;
    case 20:
      _id_0560::main();
      break;
    case 21:
      _id_0566::main();
      break;
    case 22:
      _id_056F::main();
      break;
    case 23:
      _id_0569::main();
      break;
    case 24:
      _id_053E::main();
      break;
    case 25:
      _id_0544::main();
      break;
    case 26:
      _id_054C::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_0551::precache();
  _id_054F::precache();
  _id_0559::precache();
  _id_0557::precache();
  _id_055F::precache();
  _id_055D::precache();
  _id_0565::precache();
  _id_0563::precache();
  _id_056E::precache();
  _id_056C::precache();
  _id_0568::precache();
  _id_0546::precache();
  _id_053D::precache();
  _id_053B::precache();
  _id_0543::precache();
  _id_0541::precache();
  _id_054B::precache();
  _id_0549::precache();
  _id_0552::precache();
  _id_055A::precache();
  _id_0560::precache();
  _id_0566::precache();
  _id_056F::precache();
  _id_0569::precache();
  _id_053E::precache();
  _id_0544::precache();
  _id_054C::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}