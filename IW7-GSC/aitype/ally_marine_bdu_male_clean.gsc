/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_marine_bdu_male_clean.gsc
*************************************************/

main() {
  self._id_17DB = "";
  self.team = "allies";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "regular";
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
  var_0 = [0.02, 0.025, 0.029, 0.034, 0.039, 0.049, 0.059, 0.069, 0.078, 0.088, 0.098, 0.108, 0.118, 0.127, 0.137, 0.147, 0.157, 0.176, 0.181, 0.186, 0.191, 0.196, 0.206, 0.216, 0.225, 0.235, 0.245, 0.255, 0.265, 0.275, 0.284, 0.294, 0.304, 0.314, 0.324, 0.333, 0.343, 0.353, 0.363, 0.373, 0.382, 0.392, 0.402, 0.412, 0.431, 0.441, 0.451, 0.471, 0.49, 0.51, 0.52, 0.529, 0.534, 0.539, 0.544, 0.549, 0.559, 0.569, 0.578, 0.588, 0.608, 0.618, 0.627, 0.637, 0.647, 0.657, 0.667, 0.676, 0.686, 0.696, 0.706, 0.725, 0.735, 0.745, 0.755, 0.765, 0.784, 0.794, 0.804, 0.814, 0.824, 0.833, 0.843, 0.853, 0.863, 0.873, 0.882, 0.902, 0.912, 0.922, 0.931, 0.941, 0.951, 0.961, 0.971, 0.98, 0.99, 1.0];
  var_1 = ["character_un_marine_bdu_male_bc_01_male_bc_03", "character_un_marine_bdu_male_bc_01_male_bc_04", "character_un_marine_bdu_male_bc_01_male_bc_04_cap", "character_un_marine_bdu_male_bc_01_male_bc_04_beard", "character_un_marine_bdu_male_bc_01_male_bc_04_beard_cap", "character_un_marine_bdu_male_bc_01_male_bc_05", "character_un_marine_bdu_male_bc_01_male_bc_05_cap", "character_un_marine_bdu_male_bc_01_engineering_mate", "character_un_marine_bdu_male_bc_01_engineering_mate_cap", "character_un_marine_bdu_male_bc_01_engineering_mate", "character_un_marine_bdu_male_bc_01_engineering_mate_cap", "character_un_marine_bdu_male_bc_01_male_15", "character_un_marine_bdu_male_bc_01_male_15_cap", "character_un_marine_bdu_male_bc_01_male_20", "character_un_marine_bdu_male_bc_01_male_20_cap", "character_un_marine_bdu_male_bc_02_male_bc_01", "character_un_marine_bdu_male_bc_02_male_bc_01_cap", "character_un_marine_bdu_male_bc_02_male_bc_03", "character_un_marine_bdu_male_bc_02_male_bc_04", "character_un_marine_bdu_male_bc_02_male_bc_04_cap", "character_un_marine_bdu_male_bc_02_male_bc_04_beard", "character_un_marine_bdu_male_bc_02_male_bc_04_beard_cap", "character_un_marine_bdu_male_bc_02_male_bc_05", "character_un_marine_bdu_male_bc_02_male_bc_05_cap", "character_un_marine_bdu_male_bc_02_engineering_mate", "character_un_marine_bdu_male_bc_02_engineering_mate", "character_un_marine_bdu_male_bc_02_male_20", "character_un_marine_bdu_male_bc_02_male_20", "character_un_marine_bdu_male_bc_03_male_bc_01", "character_un_marine_bdu_male_bc_03_male_bc_01_cap", "character_un_marine_bdu_male_bc_03_male_bc_04_beard", "character_un_marine_bdu_male_bc_03_male_bc_04_beard_cap", "character_un_marine_bdu_male_bc_03_male_bc_05", "character_un_marine_bdu_male_bc_03_male_bc_05_cap", "character_un_marine_bdu_male_bc_03_engineering_mate", "character_un_marine_bdu_male_bc_03_engineering_mate_cap", "character_un_marine_bdu_male_bc_04_male_bc_01", "character_un_marine_bdu_male_bc_04_male_bc_01_cap", "character_un_marine_bdu_male_bc_04_male_bc_05", "character_un_marine_bdu_male_bc_04_male_bc_05_cap", "character_un_marine_bdu_male_bc_04_engineering_mate", "character_un_marine_bdu_male_bc_04_engineering_mate_cap", "character_un_marine_bdu_male_bc_05_male_bc_01", "character_un_marine_bdu_male_bc_05_male_bc_01_cap", "character_un_marine_bdu_male_bc_05_male_bc_03", "character_un_marine_bdu_male_bc_05_engineering_mate", "character_un_marine_bdu_male_bc_05_engineering_mate_cap", "character_un_marine_bdu_male_bc_05_male_12", "character_un_marine_bdu_male_bc_05_male_15", "character_un_marine_bdu_male_bc_05_male_20", "character_un_marine_bdu_engineering_mate_male_bc_01", "character_un_marine_bdu_engineering_mate_male_bc_01_cap", "character_un_marine_bdu_engineering_mate_male_bc_04", "character_un_marine_bdu_engineering_mate_male_bc_04_cap", "character_un_marine_bdu_engineering_mate_male_bc_04_beard", "character_un_marine_bdu_engineering_mate_male_bc_04_beard_cap", "character_un_marine_bdu_engineering_mate_male_bc_05", "character_un_marine_bdu_engineering_mate_male_bc_05_cap", "character_un_marine_bdu_engineering_mate", "character_un_marine_bdu_engineering_mate_cap", "character_un_marine_bdu_engineering_mate_male_12", "character_un_marine_bdu_engineering_mate_male_15", "character_un_marine_bdu_engineering_mate_male_15_cap", "character_un_marine_bdu_engineering_mate_male_20", "character_un_marine_bdu_engineering_mate_male_20_cap", "character_un_marine_bdu_male_12_male_bc_01", "character_un_marine_bdu_male_12_male_bc_01_cap", "character_un_marine_bdu_male_12_male_bc_05", "character_un_marine_bdu_male_12_male_bc_05_cap", "character_un_marine_bdu_male_12_engineering_mate", "character_un_marine_bdu_male_12_engineering_mate_cap", "character_un_marine_bdu_male_12", "character_un_marine_bdu_male_12_male_15", "character_un_marine_bdu_male_12_male_15_cap", "character_un_marine_bdu_male_12_male_20", "character_un_marine_bdu_male_12_male_20_cap", "character_un_marine_bdu_male_18_male_bc_03", "character_un_marine_bdu_male_18_male_bc_05", "character_un_marine_bdu_male_18_male_bc_05", "character_un_marine_bdu_male_18_engineering_mate", "character_un_marine_bdu_male_18_engineering_mate_cap", "character_un_marine_bdu_male_18_male_15", "character_un_marine_bdu_male_18_male_15_cap", "character_un_marine_bdu_male_18_male_20", "character_un_marine_bdu_male_18_male_20", "character_un_marine_bdu_male_15_male_bc_01", "character_un_marine_bdu_male_15_male_bc_01_cap", "character_un_marine_bdu_male_15_male_bc_03", "character_un_marine_bdu_male_15_male_bc_04_beard", "character_un_marine_bdu_male_15_male_bc_04_beard_cap", "character_un_marine_bdu_male_15_male_bc_05", "character_un_marine_bdu_male_15_male_bc_05_cap", "character_un_marine_bdu_male_20_male_bc_01", "character_un_marine_bdu_male_20_male_bc_01_cap", "character_un_marine_bdu_male_20_male_15", "character_un_marine_bdu_male_20_male_15_cap", "character_un_marine_bdu_male_20", "character_un_marine_bdu_male_20_cap"];

  switch (scripts\code\character::get_random_character(98, var_0, var_1)) {
    case 0:
      _id_087B::main();
      break;
    case 1:
      _id_087C::main();
      break;
    case 2:
      _id_087F::main();
      break;
    case 3:
      _id_087D::main();
      break;
    case 4:
      _id_087E::main();
      break;
    case 5:
      _id_0880::main();
      break;
    case 6:
      _id_0881::main();
      break;
    case 7:
      _id_0875::main();
      break;
    case 8:
      _id_0876::main();
      break;
    case 9:
      _id_0875::main();
      break;
    case 10:
      _id_0876::main();
      break;
    case 11:
      _id_0877::main();
      break;
    case 12:
      _id_0878::main();
      break;
    case 13:
      _id_0879::main();
      break;
    case 14:
      _id_087A::main();
      break;
    case 15:
      _id_0884::main();
      break;
    case 16:
      _id_0885::main();
      break;
    case 17:
      _id_0886::main();
      break;
    case 18:
      _id_0887::main();
      break;
    case 19:
      _id_088A::main();
      break;
    case 20:
      _id_0888::main();
      break;
    case 21:
      _id_0889::main();
      break;
    case 22:
      _id_088B::main();
      break;
    case 23:
      _id_088C::main();
      break;
    case 24:
      _id_0882::main();
      break;
    case 25:
      _id_0882::main();
      break;
    case 26:
      _id_0883::main();
      break;
    case 27:
      _id_0883::main();
      break;
    case 28:
      _id_088F::main();
      break;
    case 29:
      _id_0890::main();
      break;
    case 30:
      _id_0891::main();
      break;
    case 31:
      _id_0892::main();
      break;
    case 32:
      _id_0893::main();
      break;
    case 33:
      _id_0894::main();
      break;
    case 34:
      _id_088D::main();
      break;
    case 35:
      _id_088E::main();
      break;
    case 36:
      _id_0897::main();
      break;
    case 37:
      _id_0898::main();
      break;
    case 38:
      _id_0899::main();
      break;
    case 39:
      _id_089A::main();
      break;
    case 40:
      _id_0895::main();
      break;
    case 41:
      _id_0896::main();
      break;
    case 42:
      _id_08A0::main();
      break;
    case 43:
      _id_08A1::main();
      break;
    case 44:
      _id_08A2::main();
      break;
    case 45:
      _id_089B::main();
      break;
    case 46:
      _id_089C::main();
      break;
    case 47:
      _id_089D::main();
      break;
    case 48:
      _id_089E::main();
      break;
    case 49:
      _id_089F::main();
      break;
    case 50:
      _id_083B::main();
      break;
    case 51:
      _id_083C::main();
      break;
    case 52:
      _id_083D::main();
      break;
    case 53:
      _id_0840::main();
      break;
    case 54:
      _id_083E::main();
      break;
    case 55:
      _id_083F::main();
      break;
    case 56:
      _id_0841::main();
      break;
    case 57:
      _id_0842::main();
      break;
    case 58:
      _id_0834::main();
      break;
    case 59:
      _id_0835::main();
      break;
    case 60:
      _id_0836::main();
      break;
    case 61:
      _id_0837::main();
      break;
    case 62:
      _id_0838::main();
      break;
    case 63:
      _id_0839::main();
      break;
    case 64:
      _id_083A::main();
      break;
    case 65:
      _id_085D::main();
      break;
    case 66:
      _id_085E::main();
      break;
    case 67:
      _id_085F::main();
      break;
    case 68:
      _id_0860::main();
      break;
    case 69:
      _id_0857::main();
      break;
    case 70:
      _id_0858::main();
      break;
    case 71:
      _id_0856::main();
      break;
    case 72:
      _id_0859::main();
      break;
    case 73:
      _id_085A::main();
      break;
    case 74:
      _id_085B::main();
      break;
    case 75:
      _id_085C::main();
      break;
    case 76:
      _id_086D::main();
      break;
    case 77:
      _id_086E::main();
      break;
    case 78:
      _id_086E::main();
      break;
    case 79:
      _id_0868::main();
      break;
    case 80:
      _id_0869::main();
      break;
    case 81:
      _id_086A::main();
      break;
    case 82:
      _id_086B::main();
      break;
    case 83:
      _id_086C::main();
      break;
    case 84:
      _id_086C::main();
      break;
    case 85:
      _id_0861::main();
      break;
    case 86:
      _id_0862::main();
      break;
    case 87:
      _id_0863::main();
      break;
    case 88:
      _id_0864::main();
      break;
    case 89:
      _id_0865::main();
      break;
    case 90:
      _id_0866::main();
      break;
    case 91:
      _id_0867::main();
      break;
    case 92:
      _id_0873::main();
      break;
    case 93:
      _id_0874::main();
      break;
    case 94:
      _id_0871::main();
      break;
    case 95:
      _id_0872::main();
      break;
    case 96:
      _id_086F::main();
      break;
    case 97:
      _id_0870::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_087B::precache();
  _id_087C::precache();
  _id_087F::precache();
  _id_087D::precache();
  _id_087E::precache();
  _id_0880::precache();
  _id_0881::precache();
  _id_0875::precache();
  _id_0876::precache();
  _id_0875::precache();
  _id_0876::precache();
  _id_0877::precache();
  _id_0878::precache();
  _id_0879::precache();
  _id_087A::precache();
  _id_0884::precache();
  _id_0885::precache();
  _id_0886::precache();
  _id_0887::precache();
  _id_088A::precache();
  _id_0888::precache();
  _id_0889::precache();
  _id_088B::precache();
  _id_088C::precache();
  _id_0882::precache();
  _id_0882::precache();
  _id_0883::precache();
  _id_0883::precache();
  _id_088F::precache();
  _id_0890::precache();
  _id_0891::precache();
  _id_0892::precache();
  _id_0893::precache();
  _id_0894::precache();
  _id_088D::precache();
  _id_088E::precache();
  _id_0897::precache();
  _id_0898::precache();
  _id_0899::precache();
  _id_089A::precache();
  _id_0895::precache();
  _id_0896::precache();
  _id_08A0::precache();
  _id_08A1::precache();
  _id_08A2::precache();
  _id_089B::precache();
  _id_089C::precache();
  _id_089D::precache();
  _id_089E::precache();
  _id_089F::precache();
  _id_083B::precache();
  _id_083C::precache();
  _id_083D::precache();
  _id_0840::precache();
  _id_083E::precache();
  _id_083F::precache();
  _id_0841::precache();
  _id_0842::precache();
  _id_0834::precache();
  _id_0835::precache();
  _id_0836::precache();
  _id_0837::precache();
  _id_0838::precache();
  _id_0839::precache();
  _id_083A::precache();
  _id_085D::precache();
  _id_085E::precache();
  _id_085F::precache();
  _id_0860::precache();
  _id_0857::precache();
  _id_0858::precache();
  _id_0856::precache();
  _id_0859::precache();
  _id_085A::precache();
  _id_085B::precache();
  _id_085C::precache();
  _id_086D::precache();
  _id_086E::precache();
  _id_086E::precache();
  _id_0868::precache();
  _id_0869::precache();
  _id_086A::precache();
  _id_086B::precache();
  _id_086C::precache();
  _id_086C::precache();
  _id_0861::precache();
  _id_0862::precache();
  _id_0863::precache();
  _id_0864::precache();
  _id_0865::precache();
  _id_0866::precache();
  _id_0867::precache();
  _id_0873::precache();
  _id_0874::precache();
  _id_0871::precache();
  _id_0872::precache();
  _id_086F::precache();
  _id_0870::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}