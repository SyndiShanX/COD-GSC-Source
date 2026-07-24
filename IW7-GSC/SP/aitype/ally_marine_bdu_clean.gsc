/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_marine_bdu_clean.gsc
********************************************/

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
  var_0 = [0.014, 0.018, 0.021, 0.025, 0.029, 0.036, 0.043, 0.05, 0.057, 0.064, 0.071, 0.079, 0.086, 0.093, 0.1, 0.107, 0.114, 0.129, 0.132, 0.136, 0.139, 0.143, 0.15, 0.157, 0.164, 0.171, 0.179, 0.186, 0.193, 0.2, 0.207, 0.214, 0.221, 0.229, 0.236, 0.243, 0.25, 0.257, 0.264, 0.271, 0.279, 0.286, 0.293, 0.3, 0.314, 0.321, 0.329, 0.343, 0.357, 0.371, 0.379, 0.386, 0.389, 0.393, 0.396, 0.4, 0.407, 0.414, 0.421, 0.429, 0.443, 0.45, 0.457, 0.464, 0.471, 0.479, 0.486, 0.493, 0.5, 0.507, 0.514, 0.529, 0.536, 0.543, 0.55, 0.557, 0.571, 0.579, 0.586, 0.593, 0.6, 0.607, 0.614, 0.621, 0.629, 0.636, 0.643, 0.657, 0.664, 0.671, 0.679, 0.686, 0.693, 0.7, 0.707, 0.714, 0.721, 0.729, 0.743, 0.757, 0.771, 0.786, 0.8, 0.814, 0.829, 0.843, 0.857, 0.871, 0.886, 0.9, 0.914, 0.929, 0.943, 0.957, 0.971, 0.986, 1.0];
  var_1 = ["character_un_marine_bdu_male_bc_01_male_bc_03", "character_un_marine_bdu_male_bc_01_male_bc_04", "character_un_marine_bdu_male_bc_01_male_bc_04_cap", "character_un_marine_bdu_male_bc_01_male_bc_04_beard", "character_un_marine_bdu_male_bc_01_male_bc_04_beard_cap", "character_un_marine_bdu_male_bc_01_male_bc_05", "character_un_marine_bdu_male_bc_01_male_bc_05_cap", "character_un_marine_bdu_male_bc_01_engineering_mate", "character_un_marine_bdu_male_bc_01_engineering_mate_cap", "character_un_marine_bdu_male_bc_01_engineering_mate", "character_un_marine_bdu_male_bc_01_engineering_mate_cap", "character_un_marine_bdu_male_bc_01_male_15", "character_un_marine_bdu_male_bc_01_male_15_cap", "character_un_marine_bdu_male_bc_01_male_20", "character_un_marine_bdu_male_bc_01_male_20_cap", "character_un_marine_bdu_male_bc_02_male_bc_01", "character_un_marine_bdu_male_bc_02_male_bc_01_cap", "character_un_marine_bdu_male_bc_02_male_bc_03", "character_un_marine_bdu_male_bc_02_male_bc_04", "character_un_marine_bdu_male_bc_02_male_bc_04_cap", "character_un_marine_bdu_male_bc_02_male_bc_04_beard", "character_un_marine_bdu_male_bc_02_male_bc_04_beard_cap", "character_un_marine_bdu_male_bc_02_male_bc_05", "character_un_marine_bdu_male_bc_02_male_bc_05_cap", "character_un_marine_bdu_male_bc_02_engineering_mate", "character_un_marine_bdu_male_bc_02_engineering_mate", "character_un_marine_bdu_male_bc_02_male_20", "character_un_marine_bdu_male_bc_02_male_20", "character_un_marine_bdu_male_bc_03_male_bc_01", "character_un_marine_bdu_male_bc_03_male_bc_01_cap", "character_un_marine_bdu_male_bc_03_male_bc_04_beard", "character_un_marine_bdu_male_bc_03_male_bc_04_beard_cap", "character_un_marine_bdu_male_bc_03_male_bc_05", "character_un_marine_bdu_male_bc_03_male_bc_05_cap", "character_un_marine_bdu_male_bc_03_engineering_mate", "character_un_marine_bdu_male_bc_03_engineering_mate_cap", "character_un_marine_bdu_male_bc_04_male_bc_01", "character_un_marine_bdu_male_bc_04_male_bc_01_cap", "character_un_marine_bdu_male_bc_04_male_bc_05", "character_un_marine_bdu_male_bc_04_male_bc_05_cap", "character_un_marine_bdu_male_bc_04_engineering_mate", "character_un_marine_bdu_male_bc_04_engineering_mate_cap", "character_un_marine_bdu_male_bc_05_male_bc_01", "character_un_marine_bdu_male_bc_05_male_bc_01_cap", "character_un_marine_bdu_male_bc_05_male_bc_03", "character_un_marine_bdu_male_bc_05_engineering_mate", "character_un_marine_bdu_male_bc_05_engineering_mate_cap", "character_un_marine_bdu_male_bc_05_male_12", "character_un_marine_bdu_male_bc_05_male_15", "character_un_marine_bdu_male_bc_05_male_20", "character_un_marine_bdu_engineering_mate_male_bc_01", "character_un_marine_bdu_engineering_mate_male_bc_01_cap", "character_un_marine_bdu_engineering_mate_male_bc_04", "character_un_marine_bdu_engineering_mate_male_bc_04_cap", "character_un_marine_bdu_engineering_mate_male_bc_04_beard", "character_un_marine_bdu_engineering_mate_male_bc_04_beard_cap", "character_un_marine_bdu_engineering_mate_male_bc_05", "character_un_marine_bdu_engineering_mate_male_bc_05_cap", "character_un_marine_bdu_engineering_mate", "character_un_marine_bdu_engineering_mate_cap", "character_un_marine_bdu_engineering_mate_male_12", "character_un_marine_bdu_engineering_mate_male_15", "character_un_marine_bdu_engineering_mate_male_15_cap", "character_un_marine_bdu_engineering_mate_male_20", "character_un_marine_bdu_engineering_mate_male_20_cap", "character_un_marine_bdu_male_12_male_bc_01", "character_un_marine_bdu_male_12_male_bc_01_cap", "character_un_marine_bdu_male_12_male_bc_05", "character_un_marine_bdu_male_12_male_bc_05_cap", "character_un_marine_bdu_male_12_engineering_mate", "character_un_marine_bdu_male_12_engineering_mate_cap", "character_un_marine_bdu_male_12", "character_un_marine_bdu_male_12_male_15", "character_un_marine_bdu_male_12_male_15_cap", "character_un_marine_bdu_male_12_male_20", "character_un_marine_bdu_male_12_male_20_cap", "character_un_marine_bdu_male_18_male_bc_03", "character_un_marine_bdu_male_18_male_bc_05", "character_un_marine_bdu_male_18_male_bc_05", "character_un_marine_bdu_male_18_engineering_mate", "character_un_marine_bdu_male_18_engineering_mate_cap", "character_un_marine_bdu_male_18_male_15", "character_un_marine_bdu_male_18_male_15_cap", "character_un_marine_bdu_male_18_male_20", "character_un_marine_bdu_male_18_male_20", "character_un_marine_bdu_male_15_male_bc_01", "character_un_marine_bdu_male_15_male_bc_01_cap", "character_un_marine_bdu_male_15_male_bc_03", "character_un_marine_bdu_male_15_male_bc_04_beard", "character_un_marine_bdu_male_15_male_bc_04_beard_cap", "character_un_marine_bdu_male_15_male_bc_05", "character_un_marine_bdu_male_15_male_bc_05_cap", "character_un_marine_bdu_male_20_male_bc_01", "character_un_marine_bdu_male_20_male_bc_01_cap", "character_un_marine_bdu_male_20_male_15", "character_un_marine_bdu_male_20_male_15_cap", "character_un_marine_bdu_male_20", "character_un_marine_bdu_male_20_cap", "character_un_marine_bdu_comms_officer_female_bc_02", "character_un_marine_bdu_comms_officer_female_04", "character_un_marine_bdu_comms_officer_female_05", "character_un_marine_bdu_comms_officer_female_11", "character_un_marine_bdu_female_14_hero_xo", "character_un_marine_bdu_female_14", "character_un_marine_bdu_female_14_female_04", "character_un_marine_bdu_female_14_female_05", "character_un_marine_bdu_female_14_female_11", "character_un_marine_bdu_female_04_comms_officer", "character_un_marine_bdu_female_04_female_14", "character_un_marine_bdu_female_04", "character_un_marine_bdu_female_04_female_05", "character_un_marine_bdu_female_05_female_bc_02", "character_un_marine_bdu_female_05_comms_officer", "character_un_marine_bdu_female_05_female_marine", "character_un_marine_bdu_female_05", "character_un_marine_bdu_female_05_female_11", "character_un_marine_bdu_female_11"];

  switch (scripts\code\character::get_random_character(117, var_0, var_1)) {
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
    case 98:
      _id_0833::main();
      break;
    case 99:
      _id_0830::main();
      break;
    case 100:
      _id_0831::main();
      break;
    case 101:
      _id_0832::main();
      break;
    case 102:
      _id_0851::main();
      break;
    case 103:
      _id_084D::main();
      break;
    case 104:
      _id_084E::main();
      break;
    case 105:
      _id_084F::main();
      break;
    case 106:
      _id_0850::main();
      break;
    case 107:
      _id_0844::main();
      break;
    case 108:
      _id_0846::main();
      break;
    case 109:
      _id_0843::main();
      break;
    case 110:
      _id_0845::main();
      break;
    case 111:
      _id_084A::main();
      break;
    case 112:
      _id_0848::main();
      break;
    case 113:
      _id_084B::main();
      break;
    case 114:
      _id_0847::main();
      break;
    case 115:
      _id_0849::main();
      break;
    case 116:
      _id_084C::main();
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
  _id_0833::precache();
  _id_0830::precache();
  _id_0831::precache();
  _id_0832::precache();
  _id_0851::precache();
  _id_084D::precache();
  _id_084E::precache();
  _id_084F::precache();
  _id_0850::precache();
  _id_0844::precache();
  _id_0846::precache();
  _id_0843::precache();
  _id_0845::precache();
  _id_084A::precache();
  _id_0848::precache();
  _id_084B::precache();
  _id_0847::precache();
  _id_0849::precache();
  _id_084C::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}