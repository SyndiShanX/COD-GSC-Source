/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_crew_mech_tools.gsc
*******************************************/

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
  var_1 = ["character_un_crew_mech_tool_male_bc_01_male_bc_03", "character_un_crew_mech_tool_male_bc_01_male_bc_04", "character_un_crew_mech_tool_male_bc_01_male_bc_04_cap", "character_un_crew_mech_tool_male_bc_01_male_bc_04_beard", "character_un_crew_mech_tool_male_bc_01_male_bc_04_beard_cap", "character_un_crew_mech_tool_male_bc_01_male_bc_05", "character_un_crew_mech_tool_male_bc_01_male_bc_05_cap", "character_un_crew_mech_tool_male_bc_01_engineering_mate", "character_un_crew_mech_tool_male_bc_01_engineering_mate_cap", "character_un_crew_mech_tool_male_bc_01_male_15", "character_un_crew_mech_tool_male_bc_01_male_15_cap", "character_un_crew_mech_tool_male_bc_01_male_20", "character_un_crew_mech_tool_male_bc_01_male_20_cap", "character_un_crew_mech_tool_male_bc_02_male_bc_01", "character_un_crew_mech_tool_male_bc_02_male_bc_01_cap", "character_un_crew_mech_tool_male_bc_02_male_bc_03", "character_un_crew_mech_tool_male_bc_02_male_bc_04", "character_un_crew_mech_tool_male_bc_02_male_bc_04_cap", "character_un_crew_mech_tool_male_bc_02_male_bc_04_beard", "character_un_crew_mech_tool_male_bc_02_male_bc_04_beard_cap", "character_un_crew_mech_tool_male_bc_02_male_bc_05", "character_un_crew_mech_tool_male_bc_02_male_bc_05_cap", "character_un_crew_mech_tool_male_bc_02_engineering_mate", "character_un_crew_mech_tool_male_bc_02_engineering_mate_cap", "character_un_crew_mech_tool_male_bc_02_male_20", "character_un_crew_mech_tool_male_bc_02_male_20_cap", "character_un_crew_mech_tool_male_bc_03_male_bc_01", "character_un_crew_mech_tool_male_bc_03_male_bc_01_cap", "character_un_crew_mech_tool_male_bc_03_male_bc_04_beard", "character_un_crew_mech_tool_male_bc_03_male_bc_04_beard_cap", "character_un_crew_mech_tool_male_bc_03_male_bc_05", "character_un_crew_mech_tool_male_bc_03_male_bc_05_cap", "character_un_crew_mech_tool_male_bc_03_engineering_mate", "character_un_crew_mech_tool_male_bc_03_engineering_mate_cap", "character_un_crew_mech_tool_male_bc_04_male_bc_01", "character_un_crew_mech_tool_male_bc_04_male_bc_01_cap", "character_un_crew_mech_tool_male_bc_04_male_bc_05", "character_un_crew_mech_tool_male_bc_04_male_bc_05_cap", "character_un_crew_mech_tool_male_bc_04_engineering_mate", "character_un_crew_mech_tool_male_bc_04_engineering_mate_cap", "character_un_crew_mech_tool_male_bc_05_male_bc_01", "character_un_crew_mech_tool_male_bc_05_male_bc_01_cap", "character_un_crew_mech_tool_male_bc_05_male_bc_03", "character_un_crew_mech_tool_male_bc_05_engineering_mate", "character_un_crew_mech_tool_male_bc_05_engineering_mate_cap", "character_un_crew_mech_tool_male_bc_05_male_12", "character_un_crew_mech_tool_male_bc_05_male_15", "character_un_crew_mech_tool_male_bc_05_male_20", "character_un_crew_mech_tool_engineering_mate_male_bc_01", "character_un_crew_mech_tool_engineering_mate_male_bc_01_cap", "character_un_crew_mech_tool_engineering_mate_male_bc_04", "character_un_crew_mech_tool_engineering_mate_male_bc_04_cap", "character_un_crew_mech_tool_engineering_mate_male_bc_04_beard", "character_un_crew_mech_tool_engineering_mate_male_bc_04_beard_cap", "character_un_crew_mech_tool_engineering_mate_male_bc_05", "character_un_crew_mech_tool_engineering_mate_male_bc_05_cap", "character_un_crew_mech_tool_engineering_mate", "character_un_crew_mech_tool_engineering_mate_cap", "character_un_crew_mech_tool_engineering_mate_male_12", "character_un_crew_mech_tool_engineering_mate_male_15", "character_un_crew_mech_tool_engineering_mate_male_15_cap", "character_un_crew_mech_tool_engineering_mate_male_20", "character_un_crew_mech_tool_engineering_mate_male_20_cap", "character_un_crew_mech_tool_male_12_male_bc_01", "character_un_crew_mech_tool_male_12_male_bc_01_cap", "character_un_crew_mech_tool_male_12_male_bc_05", "character_un_crew_mech_tool_male_12_male_bc_05_cap", "character_un_crew_mech_tool_male_12_engineering_mate", "character_un_crew_mech_tool_male_12_engineering_mate_cap", "character_un_crew_mech_tool_male_12", "character_un_crew_mech_tool_male_12_male_15", "character_un_crew_mech_tool_male_12_male_15_cap", "character_un_crew_mech_tool_male_12_male_20", "character_un_crew_mech_tool_male_12_male_20_cap", "character_un_crew_mech_tool_male_18_male_bc_03", "character_un_crew_mech_tool_male_18_male_bc_05", "character_un_crew_mech_tool_male_18_male_bc_05_cap", "character_un_crew_mech_tool_male_18_engineering_mate", "character_un_crew_mech_tool_male_18_engineering_mate_cap", "character_un_crew_mech_tool_male_18_male_15", "character_un_crew_mech_tool_male_18_male_15_cap", "character_un_crew_mech_tool_male_18_male_20", "character_un_crew_mech_tool_male_18_male_20_cap", "character_un_crew_mech_tool_male_15_male_bc_01", "character_un_crew_mech_tool_male_15_male_bc_01_cap", "character_un_crew_mech_tool_male_15_male_bc_03", "character_un_crew_mech_tool_male_15_male_bc_04_beard", "character_un_crew_mech_tool_male_15_male_bc_04_beard_cap", "character_un_crew_mech_tool_male_15_male_bc_05", "character_un_crew_mech_tool_male_15_male_bc_05_cap", "character_un_crew_mech_tool_male_20_male_bc_01", "character_un_crew_mech_tool_male_20_male_bc_01_cap", "character_un_crew_mech_tool_male_20_male_15", "character_un_crew_mech_tool_male_20_male_15_cap", "character_un_crew_mech_tool_male_20", "character_un_crew_mech_tool_male_20_cap"];

  switch (scripts\code\character::get_random_character(96, var_0, var_1)) {
    case 0:
      _id_0638::main();
      break;
    case 1:
      _id_0639::main();
      break;
    case 2:
      _id_063C::main();
      break;
    case 3:
      _id_063A::main();
      break;
    case 4:
      _id_063B::main();
      break;
    case 5:
      _id_063D::main();
      break;
    case 6:
      _id_063E::main();
      break;
    case 7:
      _id_0632::main();
      break;
    case 8:
      _id_0633::main();
      break;
    case 9:
      _id_0634::main();
      break;
    case 10:
      _id_0635::main();
      break;
    case 11:
      _id_0636::main();
      break;
    case 12:
      _id_0637::main();
      break;
    case 13:
      _id_0643::main();
      break;
    case 14:
      _id_0644::main();
      break;
    case 15:
      _id_0645::main();
      break;
    case 16:
      _id_0646::main();
      break;
    case 17:
      _id_0649::main();
      break;
    case 18:
      _id_0647::main();
      break;
    case 19:
      _id_0648::main();
      break;
    case 20:
      _id_064A::main();
      break;
    case 21:
      _id_064B::main();
      break;
    case 22:
      _id_063F::main();
      break;
    case 23:
      _id_0640::main();
      break;
    case 24:
      _id_0641::main();
      break;
    case 25:
      _id_0642::main();
      break;
    case 26:
      _id_064E::main();
      break;
    case 27:
      _id_064F::main();
      break;
    case 28:
      _id_0650::main();
      break;
    case 29:
      _id_0651::main();
      break;
    case 30:
      _id_0652::main();
      break;
    case 31:
      _id_0653::main();
      break;
    case 32:
      _id_064C::main();
      break;
    case 33:
      _id_064D::main();
      break;
    case 34:
      _id_0656::main();
      break;
    case 35:
      _id_0657::main();
      break;
    case 36:
      _id_0658::main();
      break;
    case 37:
      _id_0659::main();
      break;
    case 38:
      _id_0654::main();
      break;
    case 39:
      _id_0655::main();
      break;
    case 40:
      _id_065F::main();
      break;
    case 41:
      _id_0660::main();
      break;
    case 42:
      _id_0661::main();
      break;
    case 43:
      _id_065A::main();
      break;
    case 44:
      _id_065B::main();
      break;
    case 45:
      _id_065C::main();
      break;
    case 46:
      _id_065D::main();
      break;
    case 47:
      _id_065E::main();
      break;
    case 48:
      _id_0609::main();
      break;
    case 49:
      _id_060A::main();
      break;
    case 50:
      _id_060B::main();
      break;
    case 51:
      _id_060E::main();
      break;
    case 52:
      _id_060C::main();
      break;
    case 53:
      _id_060D::main();
      break;
    case 54:
      _id_060F::main();
      break;
    case 55:
      _id_0610::main();
      break;
    case 56:
      _id_0602::main();
      break;
    case 57:
      _id_0603::main();
      break;
    case 58:
      _id_0604::main();
      break;
    case 59:
      _id_0605::main();
      break;
    case 60:
      _id_0606::main();
      break;
    case 61:
      _id_0607::main();
      break;
    case 62:
      _id_0608::main();
      break;
    case 63:
      _id_0618::main();
      break;
    case 64:
      _id_0619::main();
      break;
    case 65:
      _id_061A::main();
      break;
    case 66:
      _id_061B::main();
      break;
    case 67:
      _id_0612::main();
      break;
    case 68:
      _id_0613::main();
      break;
    case 69:
      _id_0611::main();
      break;
    case 70:
      _id_0614::main();
      break;
    case 71:
      _id_0615::main();
      break;
    case 72:
      _id_0616::main();
      break;
    case 73:
      _id_0617::main();
      break;
    case 74:
      _id_0629::main();
      break;
    case 75:
      _id_062A::main();
      break;
    case 76:
      _id_062B::main();
      break;
    case 77:
      _id_0623::main();
      break;
    case 78:
      _id_0624::main();
      break;
    case 79:
      _id_0625::main();
      break;
    case 80:
      _id_0626::main();
      break;
    case 81:
      _id_0627::main();
      break;
    case 82:
      _id_0628::main();
      break;
    case 83:
      _id_061C::main();
      break;
    case 84:
      _id_061D::main();
      break;
    case 85:
      _id_061E::main();
      break;
    case 86:
      _id_061F::main();
      break;
    case 87:
      _id_0620::main();
      break;
    case 88:
      _id_0621::main();
      break;
    case 89:
      _id_0622::main();
      break;
    case 90:
      _id_0630::main();
      break;
    case 91:
      _id_0631::main();
      break;
    case 92:
      _id_062E::main();
      break;
    case 93:
      _id_062F::main();
      break;
    case 94:
      _id_062C::main();
      break;
    case 95:
      _id_062D::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_0638::precache();
  _id_0639::precache();
  _id_063C::precache();
  _id_063A::precache();
  _id_063B::precache();
  _id_063D::precache();
  _id_063E::precache();
  _id_0632::precache();
  _id_0633::precache();
  _id_0634::precache();
  _id_0635::precache();
  _id_0636::precache();
  _id_0637::precache();
  _id_0643::precache();
  _id_0644::precache();
  _id_0645::precache();
  _id_0646::precache();
  _id_0649::precache();
  _id_0647::precache();
  _id_0648::precache();
  _id_064A::precache();
  _id_064B::precache();
  _id_063F::precache();
  _id_0640::precache();
  _id_0641::precache();
  _id_0642::precache();
  _id_064E::precache();
  _id_064F::precache();
  _id_0650::precache();
  _id_0651::precache();
  _id_0652::precache();
  _id_0653::precache();
  _id_064C::precache();
  _id_064D::precache();
  _id_0656::precache();
  _id_0657::precache();
  _id_0658::precache();
  _id_0659::precache();
  _id_0654::precache();
  _id_0655::precache();
  _id_065F::precache();
  _id_0660::precache();
  _id_0661::precache();
  _id_065A::precache();
  _id_065B::precache();
  _id_065C::precache();
  _id_065D::precache();
  _id_065E::precache();
  _id_0609::precache();
  _id_060A::precache();
  _id_060B::precache();
  _id_060E::precache();
  _id_060C::precache();
  _id_060D::precache();
  _id_060F::precache();
  _id_0610::precache();
  _id_0602::precache();
  _id_0603::precache();
  _id_0604::precache();
  _id_0605::precache();
  _id_0606::precache();
  _id_0607::precache();
  _id_0608::precache();
  _id_0618::precache();
  _id_0619::precache();
  _id_061A::precache();
  _id_061B::precache();
  _id_0612::precache();
  _id_0613::precache();
  _id_0611::precache();
  _id_0614::precache();
  _id_0615::precache();
  _id_0616::precache();
  _id_0617::precache();
  _id_0629::precache();
  _id_062A::precache();
  _id_062B::precache();
  _id_0623::precache();
  _id_0624::precache();
  _id_0625::precache();
  _id_0626::precache();
  _id_0627::precache();
  _id_0628::precache();
  _id_061C::precache();
  _id_061D::precache();
  _id_061E::precache();
  _id_061F::precache();
  _id_0620::precache();
  _id_0621::precache();
  _id_0622::precache();
  _id_0630::precache();
  _id_0631::precache();
  _id_062E::precache();
  _id_062F::precache();
  _id_062C::precache();
  _id_062D::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}