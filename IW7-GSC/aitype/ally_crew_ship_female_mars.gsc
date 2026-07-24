/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_crew_ship_female_mars.gsc
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
  var_0 = [0.083, 0.167, 0.25, 0.333, 0.417, 0.5, 0.583, 0.667, 0.75, 0.833, 0.917, 1.0];
  var_1 = ["character_un_crew_ship_mars_comms_officer_female_bc_02", "character_un_crew_ship_mars_comms_officer_female_04", "character_un_crew_ship_mars_comms_officer_female_05", "character_un_crew_ship_mars_female_14", "character_un_crew_ship_mars_female_14_female_04", "character_un_crew_ship_mars_female_14_female_05", "character_un_crew_ship_mars_female_04_comms_officer", "character_un_crew_ship_mars_female_04", "character_un_crew_ship_mars_female_04_female_05", "character_un_crew_ship_mars_female_05_female_bc_02", "character_un_crew_ship_mars_female_05_comms_officer", "character_un_crew_ship_mars_female_05"];

  switch (scripts\code\character::get_random_character(12, var_0, var_1)) {
    case 0:
      _id_07C6::main();
      break;
    case 1:
      _id_07C4::main();
      break;
    case 2:
      _id_07C5::main();
      break;
    case 3:
      _id_07D5::main();
      break;
    case 4:
      _id_07D6::main();
      break;
    case 5:
      _id_07D7::main();
      break;
    case 6:
      _id_07D0::main();
      break;
    case 7:
      _id_07CF::main();
      break;
    case 8:
      _id_07D1::main();
      break;
    case 9:
      _id_07D4::main();
      break;
    case 10:
      _id_07D3::main();
      break;
    case 11:
      _id_07D2::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_07C6::precache();
  _id_07C4::precache();
  _id_07C5::precache();
  _id_07D5::precache();
  _id_07D6::precache();
  _id_07D7::precache();
  _id_07D0::precache();
  _id_07CF::precache();
  _id_07D1::precache();
  _id_07D4::precache();
  _id_07D3::precache();
  _id_07D2::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}