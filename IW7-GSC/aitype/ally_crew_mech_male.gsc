/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_crew_mech_male.gsc
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
  var_0 = [0.02, 0.025, 0.03, 0.035, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.1, 0.11, 0.12, 0.13, 0.14, 0.16, 0.165, 0.17, 0.175, 0.18, 0.19, 0.2, 0.21, 0.22, 0.23, 0.24, 0.25, 0.26, 0.27, 0.28, 0.29, 0.3, 0.31, 0.32, 0.33, 0.34, 0.35, 0.36, 0.37, 0.38, 0.39, 0.4, 0.42, 0.43, 0.44, 0.46, 0.48, 0.5, 0.51, 0.52, 0.525, 0.53, 0.535, 0.54, 0.55, 0.56, 0.57, 0.58, 0.6, 0.61, 0.62, 0.63, 0.64, 0.65, 0.66, 0.67, 0.68, 0.69, 0.7, 0.72, 0.73, 0.74, 0.75, 0.76, 0.78, 0.79, 0.8, 0.81, 0.82, 0.83, 0.84, 0.85, 0.86, 0.87, 0.88, 0.9, 0.91, 0.92, 0.93, 0.94, 0.95, 0.96, 0.97, 0.98, 0.99, 1.0];
  var_1 = ["character_un_crew_mech_male_bc_01_male_bc_03", "character_un_crew_mech_male_bc_01_male_bc_04", "character_un_crew_mech_male_bc_01_male_bc_04_cap", "character_un_crew_mech_male_bc_01_male_bc_04_beard", "character_un_crew_mech_male_bc_01_male_bc_04_beard_cap", "character_un_crew_mech_male_bc_01_male_bc_05", "character_un_crew_mech_male_bc_01_male_bc_05_cap", "character_un_crew_mech_male_bc_01_engineering_mate", "character_un_crew_mech_male_bc_01_engineering_mate_cap", "character_un_crew_mech_male_bc_01_male_15", "character_un_crew_mech_male_bc_01_male_15_cap", "character_un_crew_mech_male_bc_01_male_20", "character_un_crew_mech_male_bc_01_male_20_cap", "character_un_crew_mech_male_bc_02_male_bc_01", "character_un_crew_mech_male_bc_02_male_bc_01_cap", "character_un_crew_mech_male_bc_02_male_bc_03", "character_un_crew_mech_male_bc_02_male_bc_04", "character_un_crew_mech_male_bc_02_male_bc_04_cap", "character_un_crew_mech_male_bc_02_male_bc_04_beard", "character_un_crew_mech_male_bc_02_male_bc_04_beard_cap", "character_un_crew_mech_male_bc_02_male_bc_05", "character_un_crew_mech_male_bc_02_male_bc_05_cap", "character_un_crew_mech_male_bc_02_engineering_mate", "character_un_crew_mech_male_bc_02_engineering_mate_cap", "character_un_crew_mech_male_bc_02_male_20", "character_un_crew_mech_male_bc_02_male_20_cap", "character_un_crew_mech_male_bc_03_male_bc_01", "character_un_crew_mech_male_bc_03_male_bc_01_cap", "character_un_crew_mech_male_bc_03_male_bc_04_beard", "character_un_crew_mech_male_bc_03_male_bc_04_beard_cap", "character_un_crew_mech_male_bc_03_male_bc_05", "character_un_crew_mech_male_bc_03_male_bc_05_cap", "character_un_crew_mech_male_bc_03_engineering_mate", "character_un_crew_mech_male_bc_03_engineering_mate_cap", "character_un_crew_mech_male_bc_04_male_bc_01", "character_un_crew_mech_male_bc_04_male_bc_01_cap", "character_un_crew_mech_male_bc_04_male_bc_05", "character_un_crew_mech_male_bc_04_male_bc_05_cap", "character_un_crew_mech_male_bc_04_engineering_mate", "character_un_crew_mech_male_bc_04_engineering_mate_cap", "character_un_crew_mech_male_bc_05_male_bc_01", "character_un_crew_mech_male_bc_05_male_bc_01_cap", "character_un_crew_mech_male_bc_05_male_bc_03", "character_un_crew_mech_male_bc_05_engineering_mate", "character_un_crew_mech_male_bc_05_engineering_mate_cap", "character_un_crew_mech_male_bc_05_male_12", "character_un_crew_mech_male_bc_05_male_15", "character_un_crew_mech_male_bc_05_male_20", "character_un_crew_mech_engineering_mate_male_bc_01", "character_un_crew_mech_engineering_mate_male_bc_01_cap", "character_un_crew_mech_engineering_mate_male_bc_04", "character_un_crew_mech_engineering_mate_male_bc_04_cap", "character_un_crew_mech_engineering_mate_male_bc_04_beard", "character_un_crew_mech_engineering_mate_male_bc_04_beard_cap", "character_un_crew_mech_engineering_mate_male_bc_05", "character_un_crew_mech_engineering_mate_male_bc_05_cap", "character_un_crew_mech_engineering_mate", "character_un_crew_mech_engineering_mate_cap", "character_un_crew_mech_engineering_mate_male_12", "character_un_crew_mech_engineering_mate_male_15", "character_un_crew_mech_engineering_mate_male_15_cap", "character_un_crew_mech_engineering_mate_male_20", "character_un_crew_mech_engineering_mate_male_20_cap", "character_un_crew_mech_male_12_male_bc_01", "character_un_crew_mech_male_12_male_bc_01_cap", "character_un_crew_mech_male_12_male_bc_05", "character_un_crew_mech_male_12_male_bc_05_cap", "character_un_crew_mech_male_12_engineering_mate", "character_un_crew_mech_male_12_engineering_mate_cap", "character_un_crew_mech_male_12", "character_un_crew_mech_male_12_male_15", "character_un_crew_mech_male_12_male_15_cap", "character_un_crew_mech_male_12_male_20", "character_un_crew_mech_male_12_male_20_cap", "character_un_crew_mech_male_18_male_bc_03", "character_un_crew_mech_male_18_male_bc_05", "character_un_crew_mech_male_18_male_bc_05_cap", "character_un_crew_mech_male_18_engineering_mate", "character_un_crew_mech_male_18_engineering_mate_cap", "character_un_crew_mech_male_18_male_15", "character_un_crew_mech_male_18_male_15_cap", "character_un_crew_mech_male_18_male_20", "character_un_crew_mech_male_18_male_20_cap", "character_un_crew_mech_male_15_male_bc_01", "character_un_crew_mech_male_15_male_bc_01_cap", "character_un_crew_mech_male_15_male_bc_03", "character_un_crew_mech_male_15_male_bc_04_beard", "character_un_crew_mech_male_15_male_bc_04_beard_cap", "character_un_crew_mech_male_15_male_bc_05", "character_un_crew_mech_male_15_male_bc_05_cap", "character_un_crew_mech_male_20_male_bc_01", "character_un_crew_mech_male_20_male_bc_01_cap", "character_un_crew_mech_male_20_male_15", "character_un_crew_mech_male_20_male_15_cap", "character_un_crew_mech_male_20", "character_un_crew_mech_male_20_cap"];

  switch (scripts\code\character::get_random_character(96, var_0, var_1)) {
    case 0:
      _id_05D8::main();
      break;
    case 1:
      _id_05D9::main();
      break;
    case 2:
      _id_05DC::main();
      break;
    case 3:
      _id_05DA::main();
      break;
    case 4:
      _id_05DB::main();
      break;
    case 5:
      _id_05DD::main();
      break;
    case 6:
      _id_05DE::main();
      break;
    case 7:
      _id_05D2::main();
      break;
    case 8:
      _id_05D3::main();
      break;
    case 9:
      _id_05D4::main();
      break;
    case 10:
      _id_05D5::main();
      break;
    case 11:
      _id_05D6::main();
      break;
    case 12:
      _id_05D7::main();
      break;
    case 13:
      _id_05E3::main();
      break;
    case 14:
      _id_05E4::main();
      break;
    case 15:
      _id_05E5::main();
      break;
    case 16:
      _id_05E6::main();
      break;
    case 17:
      _id_05E9::main();
      break;
    case 18:
      _id_05E7::main();
      break;
    case 19:
      _id_05E8::main();
      break;
    case 20:
      _id_05EA::main();
      break;
    case 21:
      _id_05EB::main();
      break;
    case 22:
      _id_05DF::main();
      break;
    case 23:
      _id_05E0::main();
      break;
    case 24:
      _id_05E1::main();
      break;
    case 25:
      _id_05E2::main();
      break;
    case 26:
      _id_05EE::main();
      break;
    case 27:
      _id_05EF::main();
      break;
    case 28:
      _id_05F0::main();
      break;
    case 29:
      _id_05F1::main();
      break;
    case 30:
      _id_05F2::main();
      break;
    case 31:
      _id_05F3::main();
      break;
    case 32:
      _id_05EC::main();
      break;
    case 33:
      _id_05ED::main();
      break;
    case 34:
      _id_05F6::main();
      break;
    case 35:
      _id_05F7::main();
      break;
    case 36:
      _id_05F8::main();
      break;
    case 37:
      _id_05F9::main();
      break;
    case 38:
      _id_05F4::main();
      break;
    case 39:
      _id_05F5::main();
      break;
    case 40:
      _id_05FF::main();
      break;
    case 41:
      _id_0600::main();
      break;
    case 42:
      _id_0601::main();
      break;
    case 43:
      _id_05FA::main();
      break;
    case 44:
      _id_05FB::main();
      break;
    case 45:
      _id_05FC::main();
      break;
    case 46:
      _id_05FD::main();
      break;
    case 47:
      _id_05FE::main();
      break;
    case 48:
      _id_057B::main();
      break;
    case 49:
      _id_057C::main();
      break;
    case 50:
      _id_057D::main();
      break;
    case 51:
      _id_0580::main();
      break;
    case 52:
      _id_057E::main();
      break;
    case 53:
      _id_057F::main();
      break;
    case 54:
      _id_0581::main();
      break;
    case 55:
      _id_0582::main();
      break;
    case 56:
      _id_0574::main();
      break;
    case 57:
      _id_0575::main();
      break;
    case 58:
      _id_0576::main();
      break;
    case 59:
      _id_0577::main();
      break;
    case 60:
      _id_0578::main();
      break;
    case 61:
      _id_0579::main();
      break;
    case 62:
      _id_057A::main();
      break;
    case 63:
      _id_05B8::main();
      break;
    case 64:
      _id_05B9::main();
      break;
    case 65:
      _id_05BA::main();
      break;
    case 66:
      _id_05BB::main();
      break;
    case 67:
      _id_05B2::main();
      break;
    case 68:
      _id_05B3::main();
      break;
    case 69:
      _id_05B1::main();
      break;
    case 70:
      _id_05B4::main();
      break;
    case 71:
      _id_05B5::main();
      break;
    case 72:
      _id_05B6::main();
      break;
    case 73:
      _id_05B7::main();
      break;
    case 74:
      _id_05C9::main();
      break;
    case 75:
      _id_05CA::main();
      break;
    case 76:
      _id_05CB::main();
      break;
    case 77:
      _id_05C3::main();
      break;
    case 78:
      _id_05C4::main();
      break;
    case 79:
      _id_05C5::main();
      break;
    case 80:
      _id_05C6::main();
      break;
    case 81:
      _id_05C7::main();
      break;
    case 82:
      _id_05C8::main();
      break;
    case 83:
      _id_05BC::main();
      break;
    case 84:
      _id_05BD::main();
      break;
    case 85:
      _id_05BE::main();
      break;
    case 86:
      _id_05BF::main();
      break;
    case 87:
      _id_05C0::main();
      break;
    case 88:
      _id_05C1::main();
      break;
    case 89:
      _id_05C2::main();
      break;
    case 90:
      _id_05D0::main();
      break;
    case 91:
      _id_05D1::main();
      break;
    case 92:
      _id_05CE::main();
      break;
    case 93:
      _id_05CF::main();
      break;
    case 94:
      _id_05CC::main();
      break;
    case 95:
      _id_05CD::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_05D8::precache();
  _id_05D9::precache();
  _id_05DC::precache();
  _id_05DA::precache();
  _id_05DB::precache();
  _id_05DD::precache();
  _id_05DE::precache();
  _id_05D2::precache();
  _id_05D3::precache();
  _id_05D4::precache();
  _id_05D5::precache();
  _id_05D6::precache();
  _id_05D7::precache();
  _id_05E3::precache();
  _id_05E4::precache();
  _id_05E5::precache();
  _id_05E6::precache();
  _id_05E9::precache();
  _id_05E7::precache();
  _id_05E8::precache();
  _id_05EA::precache();
  _id_05EB::precache();
  _id_05DF::precache();
  _id_05E0::precache();
  _id_05E1::precache();
  _id_05E2::precache();
  _id_05EE::precache();
  _id_05EF::precache();
  _id_05F0::precache();
  _id_05F1::precache();
  _id_05F2::precache();
  _id_05F3::precache();
  _id_05EC::precache();
  _id_05ED::precache();
  _id_05F6::precache();
  _id_05F7::precache();
  _id_05F8::precache();
  _id_05F9::precache();
  _id_05F4::precache();
  _id_05F5::precache();
  _id_05FF::precache();
  _id_0600::precache();
  _id_0601::precache();
  _id_05FA::precache();
  _id_05FB::precache();
  _id_05FC::precache();
  _id_05FD::precache();
  _id_05FE::precache();
  _id_057B::precache();
  _id_057C::precache();
  _id_057D::precache();
  _id_0580::precache();
  _id_057E::precache();
  _id_057F::precache();
  _id_0581::precache();
  _id_0582::precache();
  _id_0574::precache();
  _id_0575::precache();
  _id_0576::precache();
  _id_0577::precache();
  _id_0578::precache();
  _id_0579::precache();
  _id_057A::precache();
  _id_05B8::precache();
  _id_05B9::precache();
  _id_05BA::precache();
  _id_05BB::precache();
  _id_05B2::precache();
  _id_05B3::precache();
  _id_05B1::precache();
  _id_05B4::precache();
  _id_05B5::precache();
  _id_05B6::precache();
  _id_05B7::precache();
  _id_05C9::precache();
  _id_05CA::precache();
  _id_05CB::precache();
  _id_05C3::precache();
  _id_05C4::precache();
  _id_05C5::precache();
  _id_05C6::precache();
  _id_05C7::precache();
  _id_05C8::precache();
  _id_05BC::precache();
  _id_05BD::precache();
  _id_05BE::precache();
  _id_05BF::precache();
  _id_05C0::precache();
  _id_05C1::precache();
  _id_05C2::precache();
  _id_05D0::precache();
  _id_05D1::precache();
  _id_05CE::precache();
  _id_05CF::precache();
  _id_05CC::precache();
  _id_05CD::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}