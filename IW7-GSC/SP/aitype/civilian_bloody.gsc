/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\civilian_bloody.gsc
**************************************/

main() {
  self._id_17DB = "";
  self.team = "neutral";
  self.type = "human";
  self.unittype = "civilian";
  self.subclass = "noboost";
  self.accuracy = 0.2;
  self.health = 30;
  self.grenadeweapon = "";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self._id_101B4 = "";
  self.behaviortreeasset = "civilian";
  self._id_1FA9 = "civilian";

  if(isai(self)) {
    self _meth_82DC(256.0, 0.0);
    self _meth_82DB(768.0, 1024.0);
  }

  self.weapon = "none";
  var_0 = [0.025, 0.049, 0.074, 0.099, 0.111, 0.123, 0.148, 0.16, 0.185, 0.21, 0.222, 0.235, 0.247, 0.272, 0.296, 0.321, 0.346, 0.358, 0.37, 0.395, 0.407, 0.432, 0.457, 0.481, 0.506, 0.531, 0.556, 0.58, 0.605, 0.63, 0.654, 0.679, 0.704, 0.728, 0.753, 0.778, 0.802, 0.827, 0.852, 0.877, 0.901, 0.926, 0.951, 0.975, 1.0];
  var_1 = ["character_civ_head_bg_engineering_mate_head_hero_gator_bloody", "character_civ_head_bg_engineering_mate_head_male_bc_01_bloody", "character_civ_head_bg_engineering_mate_head_male_bc_02_bloody", "character_civ_head_bg_engineering_mate_head_male_bc_03_bloody", "character_civ_head_bg_engineering_mate_head_male_bc_04_bloody", "character_civ_head_bg_engineering_mate_head_male_bc_04_beard_bloody", "character_civ_head_bg_engineering_mate_head_male_bc_05_bloody", "character_civ_head_bg_engineering_mate_head_male_bc_06_bloody", "character_civ_head_bg_engineering_mate_head_male_bc_07_bloody", "character_civ_head_bg_engineering_mate_head_sc_lee_bloody", "character_civ_head_bg_male_06_bloody", "character_civ_head_bg_male_06_head_male_bc_04_bloody", "character_civ_head_bg_male_06_head_male_bc_04_beard_bloody", "character_civ_head_bg_male_06_head_male_bc_05_bloody", "character_civ_head_bg_male_06_head_sc_lee_bloody", "character_civ_head_bg_male_07_bloody", "character_civ_head_bg_male_07_head_male_bc_03_bloody", "character_civ_head_bg_male_07_head_male_bc_04_bloody", "character_civ_head_bg_male_07_head_male_bc_04_beard_bloody", "character_civ_head_bg_male_07_head_male_bc_05_bloody", "character_civ_head_bg_male_07_head_male_bc_06_bloody", "character_civ_head_bg_male_07_head_sc_engineering_mate_bloody", "character_civ_head_bg_male_07_head_sc_lee_bloody", "character_civ_head_bg_female_03_bloody", "character_civ_head_bg_female_03_head_female_bc_01_bloody", "character_civ_head_bg_female_03_head_female_bc_02_bloody", "character_civ_head_bg_female_comms_officer_head_sc_female_04_bloody", "character_civ_head_bg_female_03_head_hero_dropship_officer_bloody", "character_civ_head_bg_female_04_head_female_bc_03_bloody", "character_civ_head_bg_female_03_head_sc_female_04_bloody", "character_civ_head_bg_female_03_head_sc_owens_bloody", "character_civ_head_bg_female_04_bloody", "character_civ_head_bg_female_04_head_female_bc_02_bloody", "character_civ_head_bg_female_04_head_female_bc_03_bloody", "character_civ_head_bg_female_comms_officer_head_sc_owens_bloody", "character_civ_head_bg_female_04_head_hero_tigris_captain_bloody", "character_civ_head_bg_female_04_head_sc_owens_bloody", "character_civ_head_bg_female_comms_officer_head_female_bc_02_bloody", "character_civ_head_bg_female_comms_officer_head_female_bc_03_bloody", "character_civ_head_bg_male_19_bloody", "character_civ_head_male_bc_02_bloody", "character_civ_head_bg_male_11_bloody", "character_civ_head_female_bc_01_bloody", "character_civ_head_female_bc_02_bloody", "character_civ_head_sc_female_13_bloody"];

  switch (scripts\code\character::get_random_character(45, var_0, var_1)) {
    case 0:
      _id_03DE::main();
      break;
    case 1:
      _id_03E2::main();
      break;
    case 2:
      _id_03E6::main();
      break;
    case 3:
      _id_03EA::main();
      break;
    case 4:
      _id_03F2::main();
      break;
    case 5:
      _id_03EF::main();
      break;
    case 6:
      _id_03F6::main();
      break;
    case 7:
      _id_03FA::main();
      break;
    case 8:
      _id_03FE::main();
      break;
    case 9:
      _id_0402::main();
      break;
    case 10:
      _id_0448::main();
      break;
    case 11:
      _id_0450::main();
      break;
    case 12:
      _id_044D::main();
      break;
    case 13:
      _id_0454::main();
      break;
    case 14:
      _id_0458::main();
      break;
    case 15:
      _id_045C::main();
      break;
    case 16:
      _id_0460::main();
      break;
    case 17:
      _id_0468::main();
      break;
    case 18:
      _id_0465::main();
      break;
    case 19:
      _id_046C::main();
      break;
    case 20:
      _id_0470::main();
      break;
    case 21:
      _id_0474::main();
      break;
    case 22:
      _id_0478::main();
      break;
    case 23:
      _id_0406::main();
      break;
    case 24:
      _id_040A::main();
      break;
    case 25:
      _id_040E::main();
      break;
    case 26:
      _id_0440::main();
      break;
    case 27:
      _id_0414::main();
      break;
    case 28:
      _id_042A::main();
      break;
    case 29:
      _id_041A::main();
      break;
    case 30:
      _id_041E::main();
      break;
    case 31:
      _id_0422::main();
      break;
    case 32:
      _id_0426::main();
      break;
    case 33:
      _id_042A::main();
      break;
    case 34:
      _id_0444::main();
      break;
    case 35:
      _id_0430::main();
      break;
    case 36:
      _id_0434::main();
      break;
    case 37:
      _id_0438::main();
      break;
    case 38:
      _id_043C::main();
      break;
    case 39:
      _id_0480::main();
      break;
    case 40:
      _id_048C::main();
      break;
    case 41:
      _id_047C::main();
      break;
    case 42:
      _id_0484::main();
      break;
    case 43:
      _id_0488::main();
      break;
    case 44:
      _id_0490::main();
      break;
  }
}

spawner() {
  self setspawnerteam("neutral");
}

precache() {
  _id_03DE::precache();
  _id_03E2::precache();
  _id_03E6::precache();
  _id_03EA::precache();
  _id_03F2::precache();
  _id_03EF::precache();
  _id_03F6::precache();
  _id_03FA::precache();
  _id_03FE::precache();
  _id_0402::precache();
  _id_0448::precache();
  _id_0450::precache();
  _id_044D::precache();
  _id_0454::precache();
  _id_0458::precache();
  _id_045C::precache();
  _id_0460::precache();
  _id_0468::precache();
  _id_0465::precache();
  _id_046C::precache();
  _id_0470::precache();
  _id_0474::precache();
  _id_0478::precache();
  _id_0406::precache();
  _id_040A::precache();
  _id_040E::precache();
  _id_0440::precache();
  _id_0414::precache();
  _id_042A::precache();
  _id_041A::precache();
  _id_041E::precache();
  _id_0422::precache();
  _id_0426::precache();
  _id_042A::precache();
  _id_0444::precache();
  _id_0430::precache();
  _id_0434::precache();
  _id_0438::precache();
  _id_043C::precache();
  _id_0480::precache();
  _id_048C::precache();
  _id_047C::precache();
  _id_0484::precache();
  _id_0488::precache();
  _id_0490::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::_id_009B();
  aiasm\civilian_sp_MAYBE::_id_DEE8();
  _id_0C4A::_id_2371();
}