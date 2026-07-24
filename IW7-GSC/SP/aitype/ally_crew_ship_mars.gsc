/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_crew_ship_mars.gsc
******************************************/

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
  var_0 = [0.015, 0.023, 0.031, 0.046, 0.062, 0.077, 0.092, 0.108, 0.123, 0.131, 0.138, 0.154, 0.169, 0.185, 0.2, 0.215, 0.231, 0.246, 0.262, 0.277, 0.292, 0.308, 0.323, 0.338, 0.354, 0.369, 0.385, 0.4, 0.408, 0.415, 0.431, 0.446, 0.462, 0.477, 0.492, 0.508, 0.523, 0.538, 0.554, 0.569, 0.585, 0.6, 0.615, 0.631, 0.646, 0.662, 0.677, 0.692, 0.708, 0.723, 0.738, 0.754, 0.769, 0.788, 0.808, 0.827, 0.846, 0.865, 0.885, 0.904, 0.923, 0.942, 0.962, 0.981, 1.0];
  var_1 = ["character_un_crew_ship_mars_male_bc_01_male_bc_03", "character_un_crew_ship_mars_male_bc_01_male_bc_04", "character_un_crew_ship_mars_male_bc_01_male_bc_04_beard", "character_un_crew_ship_male_bc_01_male_bc_05", "character_un_crew_ship_mars_male_bc_01_engineering_mate", "character_un_crew_ship_mars_male_bc_01_male_15", "character_un_crew_ship_mars_male_bc_01_male_20", "character_un_crew_ship_mars_male_bc_02_male_bc_01", "character_un_crew_ship_mars_male_bc_02_male_bc_03", "character_un_crew_ship_mars_male_bc_02_male_bc_04", "character_un_crew_ship_mars_male_bc_02_male_bc_04_beard", "character_un_crew_ship_mars_male_bc_02_male_bc_05", "character_un_crew_ship_mars_male_bc_02_engineering_mate", "character_un_crew_ship_mars_male_bc_02_male_20", "character_un_crew_ship_mars_male_bc_03_male_bc_01", "character_un_crew_ship_mars_male_bc_03_male_bc_04_beard", "character_un_crew_ship_mars_male_bc_03_male_bc_05", "character_un_crew_ship_mars_male_bc_03_engineering_mate", "character_un_crew_ship_mars_male_bc_04_male_bc_01", "character_un_crew_ship_mars_male_bc_04_male_bc_05", "character_un_crew_ship_mars_male_bc_04_engineering_mate", "character_un_crew_ship_mars_male_bc_05_male_bc_01", "character_un_crew_ship_mars_male_bc_05_male_bc_03", "character_un_crew_ship_mars_male_bc_05_engineering_mate", "character_un_crew_ship_mars_male_bc_05_male_12", "character_un_crew_ship_mars_male_bc_05_male_15", "character_un_crew_ship_mars_male_bc_05_male_20", "character_un_crew_ship_mars_engineering_mate_male_bc_01", "character_un_crew_ship_mars_engineering_mate_male_bc_04", "character_un_crew_ship_mars_engineering_mate_male_bc_04_beard", "character_un_crew_ship_mars_engineering_mate_male_bc_05", "character_un_crew_ship_mars_engineering_mate", "character_un_crew_ship_mars_engineering_mate_male_12", "character_un_crew_ship_mars_engineering_mate_male_15", "character_un_crew_ship_mars_engineering_mate_male_20", "character_un_crew_ship_mars_male_12_male_bc_01", "character_un_crew_ship_mars_male_12_male_bc_05", "character_un_crew_ship_mars_male_12_engineering_mate", "character_un_crew_ship_mars_male_12", "character_un_crew_ship_mars_male_12_male_15", "character_un_crew_ship_mars_male_12_male_20", "character_un_crew_ship_mars_male_18_male_bc_03", "character_un_crew_ship_mars_male_18_male_bc_05", "character_un_crew_ship_mars_male_18_engineering_mate", "character_un_crew_ship_mars_male_18_male_15", "character_un_crew_ship_mars_male_18_male_20", "character_un_crew_ship_mars_male_15_male_bc_01", "character_un_crew_ship_mars_male_15_male_bc_03", "character_un_crew_ship_mars_male_15_male_bc_04_beard", "character_un_crew_ship_mars_male_15_male_bc_05", "character_un_crew_ship_mars_male_20_male_bc_01", "character_un_crew_ship_mars_male_20_male_15", "character_un_crew_ship_mars_male_20", "character_un_crew_ship_mars_comms_officer_female_bc_02", "character_un_crew_ship_mars_comms_officer_female_04", "character_un_crew_ship_mars_comms_officer_female_05", "character_un_crew_ship_mars_female_14", "character_un_crew_ship_mars_female_14_female_04", "character_un_crew_ship_mars_female_14_female_05", "character_un_crew_ship_mars_female_04_comms_officer", "character_un_crew_ship_mars_female_04", "character_un_crew_ship_mars_female_04_female_05", "character_un_crew_ship_mars_female_05_female_bc_02", "character_un_crew_ship_mars_female_05_comms_officer", "character_un_crew_ship_mars_female_05"];

  switch (scripts\code\character::get_random_character(65, var_0, var_1)) {
    case 0:
      _id_07ED::main();
      break;
    case 1:
      _id_07EE::main();
      break;
    case 2:
      _id_07EF::main();
      break;
    case 3:
      _id_079E::main();
      break;
    case 4:
      _id_07EA::main();
      break;
    case 5:
      _id_07EB::main();
      break;
    case 6:
      _id_07EC::main();
      break;
    case 7:
      _id_07F2::main();
      break;
    case 8:
      _id_07F3::main();
      break;
    case 9:
      _id_07F4::main();
      break;
    case 10:
      _id_07F5::main();
      break;
    case 11:
      _id_07F6::main();
      break;
    case 12:
      _id_07F0::main();
      break;
    case 13:
      _id_07F1::main();
      break;
    case 14:
      _id_07F8::main();
      break;
    case 15:
      _id_07F9::main();
      break;
    case 16:
      _id_07FA::main();
      break;
    case 17:
      _id_07F7::main();
      break;
    case 18:
      _id_07FC::main();
      break;
    case 19:
      _id_07FD::main();
      break;
    case 20:
      _id_07FB::main();
      break;
    case 21:
      _id_0802::main();
      break;
    case 22:
      _id_0803::main();
      break;
    case 23:
      _id_07FE::main();
      break;
    case 24:
      _id_07FF::main();
      break;
    case 25:
      _id_0800::main();
      break;
    case 26:
      _id_0801::main();
      break;
    case 27:
      _id_07CB::main();
      break;
    case 28:
      _id_07CC::main();
      break;
    case 29:
      _id_07CD::main();
      break;
    case 30:
      _id_07CE::main();
      break;
    case 31:
      _id_07C7::main();
      break;
    case 32:
      _id_07C8::main();
      break;
    case 33:
      _id_07C9::main();
      break;
    case 34:
      _id_07CA::main();
      break;
    case 35:
      _id_07DC::main();
      break;
    case 36:
      _id_07DD::main();
      break;
    case 37:
      _id_07D9::main();
      break;
    case 38:
      _id_07D8::main();
      break;
    case 39:
      _id_07DA::main();
      break;
    case 40:
      _id_07DB::main();
      break;
    case 41:
      _id_07E5::main();
      break;
    case 42:
      _id_07E6::main();
      break;
    case 43:
      _id_07E2::main();
      break;
    case 44:
      _id_07E3::main();
      break;
    case 45:
      _id_07E4::main();
      break;
    case 46:
      _id_07DE::main();
      break;
    case 47:
      _id_07DF::main();
      break;
    case 48:
      _id_07E0::main();
      break;
    case 49:
      _id_07E1::main();
      break;
    case 50:
      _id_07E9::main();
      break;
    case 51:
      _id_07E8::main();
      break;
    case 52:
      _id_07E7::main();
      break;
    case 53:
      _id_07C6::main();
      break;
    case 54:
      _id_07C4::main();
      break;
    case 55:
      _id_07C5::main();
      break;
    case 56:
      _id_07D5::main();
      break;
    case 57:
      _id_07D6::main();
      break;
    case 58:
      _id_07D7::main();
      break;
    case 59:
      _id_07D0::main();
      break;
    case 60:
      _id_07CF::main();
      break;
    case 61:
      _id_07D1::main();
      break;
    case 62:
      _id_07D4::main();
      break;
    case 63:
      _id_07D3::main();
      break;
    case 64:
      _id_07D2::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_07ED::precache();
  _id_07EE::precache();
  _id_07EF::precache();
  _id_079E::precache();
  _id_07EA::precache();
  _id_07EB::precache();
  _id_07EC::precache();
  _id_07F2::precache();
  _id_07F3::precache();
  _id_07F4::precache();
  _id_07F5::precache();
  _id_07F6::precache();
  _id_07F0::precache();
  _id_07F1::precache();
  _id_07F8::precache();
  _id_07F9::precache();
  _id_07FA::precache();
  _id_07F7::precache();
  _id_07FC::precache();
  _id_07FD::precache();
  _id_07FB::precache();
  _id_0802::precache();
  _id_0803::precache();
  _id_07FE::precache();
  _id_07FF::precache();
  _id_0800::precache();
  _id_0801::precache();
  _id_07CB::precache();
  _id_07CC::precache();
  _id_07CD::precache();
  _id_07CE::precache();
  _id_07C7::precache();
  _id_07C8::precache();
  _id_07C9::precache();
  _id_07CA::precache();
  _id_07DC::precache();
  _id_07DD::precache();
  _id_07D9::precache();
  _id_07D8::precache();
  _id_07DA::precache();
  _id_07DB::precache();
  _id_07E5::precache();
  _id_07E6::precache();
  _id_07E2::precache();
  _id_07E3::precache();
  _id_07E4::precache();
  _id_07DE::precache();
  _id_07DF::precache();
  _id_07E0::precache();
  _id_07E1::precache();
  _id_07E9::precache();
  _id_07E8::precache();
  _id_07E7::precache();
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