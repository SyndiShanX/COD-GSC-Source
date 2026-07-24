/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_crew_medic.gsc
**************************************/

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
  var_1 = ["character_un_crew_medic_male_bc_01_male_bc_03", "character_un_crew_medic_male_bc_01_male_bc_04", "character_un_crew_medic_male_bc_01_male_bc_04_cap", "character_un_crew_medic_male_bc_01_male_bc_04_beard", "character_un_crew_medic_male_bc_01_male_bc_04_beard_cap", "character_un_crew_medic_male_bc_01_male_bc_05", "character_un_crew_medic_male_bc_01_male_bc_05_cap", "character_un_crew_medic_male_bc_01_engineering_mate", "character_un_crew_medic_male_bc_01_engineering_mate_cap", "character_un_crew_medic_male_bc_01_male_15", "character_un_crew_medic_male_bc_01_male_15_cap", "character_un_crew_medic_male_bc_01_male_20", "character_un_crew_medic_male_bc_01_male_20_cap", "character_un_crew_medic_male_bc_02_male_bc_01", "character_un_crew_medic_male_bc_02_male_bc_01_cap", "character_un_crew_medic_male_bc_02_male_bc_03", "character_un_crew_medic_male_bc_02_male_bc_04", "character_un_crew_medic_male_bc_02_male_bc_04_cap", "character_un_crew_medic_male_bc_02_male_bc_04_beard", "character_un_crew_medic_male_bc_02_male_bc_04_beard_cap", "character_un_crew_medic_male_bc_02_male_bc_05", "character_un_crew_medic_male_bc_02_male_bc_05_cap", "character_un_crew_medic_male_bc_02_engineering_mate", "character_un_crew_medic_male_bc_02_engineering_mate_cap", "character_un_crew_medic_male_bc_02_male_20", "character_un_crew_medic_male_bc_02_male_20_cap", "character_un_crew_medic_male_bc_03_male_bc_01", "character_un_crew_medic_male_bc_03_male_bc_01_cap", "character_un_crew_medic_male_bc_03_male_bc_04_beard", "character_un_crew_medic_male_bc_03_male_bc_04_beard_cap", "character_un_crew_medic_male_bc_03_male_bc_05", "character_un_crew_medic_male_bc_03_male_bc_05_cap", "character_un_crew_medic_male_bc_03_engineering_mate", "character_un_crew_medic_male_bc_03_engineering_mate_cap", "character_un_crew_medic_male_bc_04_male_bc_01", "character_un_crew_medic_male_bc_04_male_bc_01_cap", "character_un_crew_medic_male_bc_04_male_bc_05", "character_un_crew_medic_male_bc_04_male_bc_05_cap", "character_un_crew_medic_male_bc_04_engineering_mate", "character_un_crew_medic_male_bc_04_engineering_mate_cap", "character_un_crew_medic_male_bc_05_male_bc_01", "character_un_crew_medic_male_bc_05_male_bc_01_cap", "character_un_crew_medic_male_bc_05_male_bc_03", "character_un_crew_medic_male_bc_05_engineering_mate", "character_un_crew_medic_male_bc_05_engineering_mate_cap", "character_un_crew_medic_male_bc_05_male_12", "character_un_crew_medic_male_bc_05_male_15", "character_un_crew_medic_male_bc_05_male_20", "character_un_crew_medic_engineering_mate_male_bc_01", "character_un_crew_medic_engineering_mate_male_bc_01_cap", "character_un_crew_medic_engineering_mate_male_bc_04", "character_un_crew_medic_engineering_mate_male_bc_04_cap", "character_un_crew_medic_engineering_mate_male_bc_04_beard", "character_un_crew_medic_engineering_mate_male_bc_04_beard_cap", "character_un_crew_medic_engineering_mate_male_bc_05", "character_un_crew_medic_engineering_mate_male_bc_05_cap", "character_un_crew_medic_engineering_mate", "character_un_crew_medic_engineering_mate_cap", "character_un_crew_medic_engineering_mate_male_12", "character_un_crew_medic_engineering_mate_male_15", "character_un_crew_medic_engineering_mate_male_15_cap", "character_un_crew_medic_engineering_mate_male_20", "character_un_crew_medic_engineering_mate_male_20_cap", "character_un_crew_medic_male_12_male_bc_01", "character_un_crew_medic_male_12_male_bc_01_cap", "character_un_crew_medic_male_12_male_bc_05", "character_un_crew_medic_male_12_male_bc_05_cap", "character_un_crew_medic_male_12_engineering_mate", "character_un_crew_medic_male_12_engineering_mate_cap", "character_un_crew_medic_male_12", "character_un_crew_medic_male_12_male_15", "character_un_crew_medic_male_12_male_15_cap", "character_un_crew_medic_male_12_male_20", "character_un_crew_medic_male_12_male_20_cap", "character_un_crew_medic_male_18_male_bc_03", "character_un_crew_medic_male_18_male_bc_05", "character_un_crew_medic_male_18_male_bc_05_cap", "character_un_crew_medic_male_18_engineering_mate", "character_un_crew_medic_male_18_engineering_mate_cap", "character_un_crew_medic_male_18_male_15", "character_un_crew_medic_male_18_male_15_cap", "character_un_crew_medic_male_18_male_20", "character_un_crew_medic_male_18_male_20_cap", "character_un_crew_medic_male_15_male_bc_01", "character_un_crew_medic_male_15_male_bc_01_cap", "character_un_crew_medic_male_15_male_bc_03", "character_un_crew_medic_male_15_male_bc_04_beard", "character_un_crew_medic_male_15_male_bc_04_beard_cap", "character_un_crew_medic_male_15_male_bc_05", "character_un_crew_medic_male_15_male_bc_05_cap", "character_un_crew_medic_male_20_male_bc_01", "character_un_crew_medic_male_20_male_bc_01_cap", "character_un_crew_medic_male_20_male_15", "character_un_crew_medic_male_20_male_15_cap", "character_un_crew_medic_male_20", "character_un_crew_medic_male_20_cap"];

  switch (scripts\code\character::get_random_character(96, var_0, var_1)) {
    case 0:
      _id_06A6::main();
      break;
    case 1:
      _id_06A7::main();
      break;
    case 2:
      _id_06AA::main();
      break;
    case 3:
      _id_06A8::main();
      break;
    case 4:
      _id_06A9::main();
      break;
    case 5:
      _id_06AB::main();
      break;
    case 6:
      _id_06AC::main();
      break;
    case 7:
      _id_06A0::main();
      break;
    case 8:
      _id_06A1::main();
      break;
    case 9:
      _id_06A2::main();
      break;
    case 10:
      _id_06A3::main();
      break;
    case 11:
      _id_06A4::main();
      break;
    case 12:
      _id_06A5::main();
      break;
    case 13:
      _id_06B1::main();
      break;
    case 14:
      _id_06B2::main();
      break;
    case 15:
      _id_06B3::main();
      break;
    case 16:
      _id_06B4::main();
      break;
    case 17:
      _id_06B7::main();
      break;
    case 18:
      _id_06B5::main();
      break;
    case 19:
      _id_06B6::main();
      break;
    case 20:
      _id_06B8::main();
      break;
    case 21:
      _id_06B9::main();
      break;
    case 22:
      _id_06AD::main();
      break;
    case 23:
      _id_06AE::main();
      break;
    case 24:
      _id_06AF::main();
      break;
    case 25:
      _id_06B0::main();
      break;
    case 26:
      _id_06BC::main();
      break;
    case 27:
      _id_06BD::main();
      break;
    case 28:
      _id_06BE::main();
      break;
    case 29:
      _id_06BF::main();
      break;
    case 30:
      _id_06C0::main();
      break;
    case 31:
      _id_06C1::main();
      break;
    case 32:
      _id_06BA::main();
      break;
    case 33:
      _id_06BB::main();
      break;
    case 34:
      _id_06C4::main();
      break;
    case 35:
      _id_06C5::main();
      break;
    case 36:
      _id_06C6::main();
      break;
    case 37:
      _id_06C7::main();
      break;
    case 38:
      _id_06C2::main();
      break;
    case 39:
      _id_06C3::main();
      break;
    case 40:
      _id_06CD::main();
      break;
    case 41:
      _id_06CE::main();
      break;
    case 42:
      _id_06CF::main();
      break;
    case 43:
      _id_06C8::main();
      break;
    case 44:
      _id_06C9::main();
      break;
    case 45:
      _id_06CA::main();
      break;
    case 46:
      _id_06CB::main();
      break;
    case 47:
      _id_06CC::main();
      break;
    case 48:
      _id_066A::main();
      break;
    case 49:
      _id_066B::main();
      break;
    case 50:
      _id_066C::main();
      break;
    case 51:
      _id_066F::main();
      break;
    case 52:
      _id_066D::main();
      break;
    case 53:
      _id_066E::main();
      break;
    case 54:
      _id_0670::main();
      break;
    case 55:
      _id_0671::main();
      break;
    case 56:
      _id_0663::main();
      break;
    case 57:
      _id_0664::main();
      break;
    case 58:
      _id_0665::main();
      break;
    case 59:
      _id_0666::main();
      break;
    case 60:
      _id_0667::main();
      break;
    case 61:
      _id_0668::main();
      break;
    case 62:
      _id_0669::main();
      break;
    case 63:
      _id_0686::main();
      break;
    case 64:
      _id_0687::main();
      break;
    case 65:
      _id_0688::main();
      break;
    case 66:
      _id_0689::main();
      break;
    case 67:
      _id_0680::main();
      break;
    case 68:
      _id_0681::main();
      break;
    case 69:
      _id_067F::main();
      break;
    case 70:
      _id_0682::main();
      break;
    case 71:
      _id_0683::main();
      break;
    case 72:
      _id_0684::main();
      break;
    case 73:
      _id_0685::main();
      break;
    case 74:
      _id_0697::main();
      break;
    case 75:
      _id_0698::main();
      break;
    case 76:
      _id_0699::main();
      break;
    case 77:
      _id_0691::main();
      break;
    case 78:
      _id_0692::main();
      break;
    case 79:
      _id_0693::main();
      break;
    case 80:
      _id_0694::main();
      break;
    case 81:
      _id_0695::main();
      break;
    case 82:
      _id_0696::main();
      break;
    case 83:
      _id_068A::main();
      break;
    case 84:
      _id_068B::main();
      break;
    case 85:
      _id_068C::main();
      break;
    case 86:
      _id_068D::main();
      break;
    case 87:
      _id_068E::main();
      break;
    case 88:
      _id_068F::main();
      break;
    case 89:
      _id_0690::main();
      break;
    case 90:
      _id_069E::main();
      break;
    case 91:
      _id_069F::main();
      break;
    case 92:
      _id_069C::main();
      break;
    case 93:
      _id_069D::main();
      break;
    case 94:
      _id_069A::main();
      break;
    case 95:
      _id_069B::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_06A6::precache();
  _id_06A7::precache();
  _id_06AA::precache();
  _id_06A8::precache();
  _id_06A9::precache();
  _id_06AB::precache();
  _id_06AC::precache();
  _id_06A0::precache();
  _id_06A1::precache();
  _id_06A2::precache();
  _id_06A3::precache();
  _id_06A4::precache();
  _id_06A5::precache();
  _id_06B1::precache();
  _id_06B2::precache();
  _id_06B3::precache();
  _id_06B4::precache();
  _id_06B7::precache();
  _id_06B5::precache();
  _id_06B6::precache();
  _id_06B8::precache();
  _id_06B9::precache();
  _id_06AD::precache();
  _id_06AE::precache();
  _id_06AF::precache();
  _id_06B0::precache();
  _id_06BC::precache();
  _id_06BD::precache();
  _id_06BE::precache();
  _id_06BF::precache();
  _id_06C0::precache();
  _id_06C1::precache();
  _id_06BA::precache();
  _id_06BB::precache();
  _id_06C4::precache();
  _id_06C5::precache();
  _id_06C6::precache();
  _id_06C7::precache();
  _id_06C2::precache();
  _id_06C3::precache();
  _id_06CD::precache();
  _id_06CE::precache();
  _id_06CF::precache();
  _id_06C8::precache();
  _id_06C9::precache();
  _id_06CA::precache();
  _id_06CB::precache();
  _id_06CC::precache();
  _id_066A::precache();
  _id_066B::precache();
  _id_066C::precache();
  _id_066F::precache();
  _id_066D::precache();
  _id_066E::precache();
  _id_0670::precache();
  _id_0671::precache();
  _id_0663::precache();
  _id_0664::precache();
  _id_0665::precache();
  _id_0666::precache();
  _id_0667::precache();
  _id_0668::precache();
  _id_0669::precache();
  _id_0686::precache();
  _id_0687::precache();
  _id_0688::precache();
  _id_0689::precache();
  _id_0680::precache();
  _id_0681::precache();
  _id_067F::precache();
  _id_0682::precache();
  _id_0683::precache();
  _id_0684::precache();
  _id_0685::precache();
  _id_0697::precache();
  _id_0698::precache();
  _id_0699::precache();
  _id_0691::precache();
  _id_0692::precache();
  _id_0693::precache();
  _id_0694::precache();
  _id_0695::precache();
  _id_0696::precache();
  _id_068A::precache();
  _id_068B::precache();
  _id_068C::precache();
  _id_068D::precache();
  _id_068E::precache();
  _id_068F::precache();
  _id_0690::precache();
  _id_069E::precache();
  _id_069F::precache();
  _id_069C::precache();
  _id_069D::precache();
  _id_069A::precache();
  _id_069B::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}