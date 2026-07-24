/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\civilian.gsc
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
  var_0 = [0.024, 0.048, 0.071, 0.095, 0.107, 0.119, 0.143, 0.155, 0.179, 0.202, 0.214, 0.226, 0.238, 0.262, 0.286, 0.31, 0.321, 0.333, 0.345, 0.369, 0.381, 0.405, 0.429, 0.452, 0.476, 0.5, 0.524, 0.548, 0.571, 0.595, 0.619, 0.643, 0.667, 0.69, 0.714, 0.738, 0.762, 0.786, 0.81, 0.833, 0.857, 0.881, 0.905, 0.929, 0.952, 0.976, 1.0];
  var_1 = ["character_civ_head_bg_engineering_mate_head_hero_gator", "character_civ_head_bg_engineering_mate_head_male_bc_01", "character_civ_head_bg_engineering_mate_head_male_bc_02", "character_civ_head_bg_engineering_mate_head_male_bc_03", "character_civ_head_bg_engineering_mate_head_male_bc_04", "character_civ_head_bg_engineering_mate_head_male_bc_04_beard", "character_civ_head_bg_engineering_mate_head_male_bc_05", "character_civ_head_bg_engineering_mate_head_male_bc_06", "character_civ_head_bg_engineering_mate_head_male_bc_07", "character_civ_head_bg_engineering_mate_head_sc_lee", "character_civ_head_bg_male_06", "character_civ_head_bg_male_06_head_male_bc_04", "character_civ_head_bg_male_06_head_male_bc_04_beard", "character_civ_head_bg_male_06_head_male_bc_05", "character_civ_head_bg_male_06_head_sc_lee", "character_civ_head_bg_male_07", "character_civ_head_bg_male_07_head_male_bc_03", "character_civ_head_bg_male_07_head_male_bc_04", "character_civ_head_bg_male_07_head_male_bc_04_beard", "character_civ_head_bg_male_07_head_male_bc_05", "character_civ_head_bg_male_07_head_male_bc_06", "character_civ_head_bg_male_07_head_sc_engineering_mate", "character_civ_head_bg_male_07_head_sc_lee", "character_civ_head_bg_female_03", "character_civ_head_bg_female_03_head_female_bc_01", "character_civ_head_bg_female_03_head_female_bc_02", "character_civ_head_bg_female_03_head_hero_air_boss", "character_civ_head_bg_female_03_head_hero_dropship_officer", "character_civ_head_bg_female_03_head_sc_comms_officer", "character_civ_head_bg_female_03_head_sc_female_04", "character_civ_head_bg_female_03_head_sc_owens", "character_civ_head_bg_female_04", "character_civ_head_bg_female_04_head_female_bc_02", "character_civ_head_bg_female_04_head_female_bc_03", "character_civ_head_bg_female_04_head_hero_air_boss", "character_civ_head_bg_female_04_head_hero_tigris_captain", "character_civ_head_bg_female_04_head_sc_owens", "character_civ_head_bg_female_comms_officer_head_female_bc_02", "character_civ_head_bg_female_comms_officer_head_female_bc_03", "character_civ_head_bg_female_comms_officer_head_sc_female_04", "character_civ_head_bg_female_comms_officer_head_sc_owens", "character_civ_head_bg_male_19", "character_civ_head_male_bc_02", "character_civ_head_bg_male_11", "character_civ_head_female_bc_01", "character_civ_head_female_bc_02", "character_civ_head_sc_female_13"];

  switch (scripts\code\character::get_random_character(47, var_0, var_1)) {
    case 0:
      _id_03DD::main();
      break;
    case 1:
      _id_03E1::main();
      break;
    case 2:
      _id_03E5::main();
      break;
    case 3:
      _id_03E9::main();
      break;
    case 4:
      _id_03ED::main();
      break;
    case 5:
      _id_03EE::main();
      break;
    case 6:
      _id_03F5::main();
      break;
    case 7:
      _id_03F9::main();
      break;
    case 8:
      _id_03FD::main();
      break;
    case 9:
      _id_0401::main();
      break;
    case 10:
      _id_0447::main();
      break;
    case 11:
      _id_044B::main();
      break;
    case 12:
      _id_044C::main();
      break;
    case 13:
      _id_0453::main();
      break;
    case 14:
      _id_0457::main();
      break;
    case 15:
      _id_045B::main();
      break;
    case 16:
      _id_045F::main();
      break;
    case 17:
      _id_0463::main();
      break;
    case 18:
      _id_0464::main();
      break;
    case 19:
      _id_046B::main();
      break;
    case 20:
      _id_046F::main();
      break;
    case 21:
      _id_0473::main();
      break;
    case 22:
      _id_0477::main();
      break;
    case 23:
      _id_0405::main();
      break;
    case 24:
      _id_0409::main();
      break;
    case 25:
      _id_040D::main();
      break;
    case 26:
      _id_0411::main();
      break;
    case 27:
      _id_0413::main();
      break;
    case 28:
      _id_0417::main();
      break;
    case 29:
      _id_0419::main();
      break;
    case 30:
      _id_041D::main();
      break;
    case 31:
      _id_0421::main();
      break;
    case 32:
      _id_0425::main();
      break;
    case 33:
      _id_0429::main();
      break;
    case 34:
      _id_042D::main();
      break;
    case 35:
      _id_042F::main();
      break;
    case 36:
      _id_0433::main();
      break;
    case 37:
      _id_0437::main();
      break;
    case 38:
      _id_043B::main();
      break;
    case 39:
      _id_043F::main();
      break;
    case 40:
      _id_0443::main();
      break;
    case 41:
      _id_047F::main();
      break;
    case 42:
      _id_048B::main();
      break;
    case 43:
      _id_047B::main();
      break;
    case 44:
      _id_0483::main();
      break;
    case 45:
      _id_0487::main();
      break;
    case 46:
      _id_048F::main();
      break;
  }
}

spawner() {
  self setspawnerteam("neutral");
}

precache() {
  _id_03DD::precache();
  _id_03E1::precache();
  _id_03E5::precache();
  _id_03E9::precache();
  _id_03ED::precache();
  _id_03EE::precache();
  _id_03F5::precache();
  _id_03F9::precache();
  _id_03FD::precache();
  _id_0401::precache();
  _id_0447::precache();
  _id_044B::precache();
  _id_044C::precache();
  _id_0453::precache();
  _id_0457::precache();
  _id_045B::precache();
  _id_045F::precache();
  _id_0463::precache();
  _id_0464::precache();
  _id_046B::precache();
  _id_046F::precache();
  _id_0473::precache();
  _id_0477::precache();
  _id_0405::precache();
  _id_0409::precache();
  _id_040D::precache();
  _id_0411::precache();
  _id_0413::precache();
  _id_0417::precache();
  _id_0419::precache();
  _id_041D::precache();
  _id_0421::precache();
  _id_0425::precache();
  _id_0429::precache();
  _id_042D::precache();
  _id_042F::precache();
  _id_0433::precache();
  _id_0437::precache();
  _id_043B::precache();
  _id_043F::precache();
  _id_0443::precache();
  _id_047F::precache();
  _id_048B::precache();
  _id_047B::precache();
  _id_0483::precache();
  _id_0487::precache();
  _id_048F::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::_id_009B();
  aiasm\civilian_sp_MAYBE::_id_DEE8();
  _id_0C4A::_id_2371();
}