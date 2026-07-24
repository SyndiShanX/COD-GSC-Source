/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\civilian_male_bloody.gsc
*******************************************/

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
  var_0 = [0.047, 0.093, 0.14, 0.186, 0.209, 0.233, 0.279, 0.302, 0.349, 0.395, 0.419, 0.442, 0.465, 0.512, 0.558, 0.605, 0.651, 0.674, 0.698, 0.744, 0.767, 0.814, 0.86, 0.907, 0.953, 1.0];
  var_1 = ["character_civ_head_bg_engineering_mate_head_hero_gator_bloody", "character_civ_head_bg_engineering_mate_head_male_bc_01_bloody", "character_civ_head_bg_engineering_mate_head_male_bc_02_bloody", "character_civ_head_bg_engineering_mate_head_male_bc_03_bloody", "character_civ_head_bg_engineering_mate_head_male_bc_04_bloody", "character_civ_head_bg_engineering_mate_head_male_bc_04_beard_bloody", "character_civ_head_bg_engineering_mate_head_male_bc_05_bloody", "character_civ_head_bg_engineering_mate_head_male_bc_06_bloody", "character_civ_head_bg_engineering_mate_head_male_bc_07_bloody", "character_civ_head_bg_engineering_mate_head_sc_lee_bloody", "character_civ_head_bg_male_06_bloody", "character_civ_head_bg_male_06_head_male_bc_04_bloody", "character_civ_head_bg_male_06_head_male_bc_04_beard_bloody", "character_civ_head_bg_male_06_head_male_bc_05_bloody", "character_civ_head_bg_male_06_head_sc_lee_bloody", "character_civ_head_bg_male_07_bloody", "character_civ_head_bg_male_07_head_male_bc_03_bloody", "character_civ_head_bg_male_07_head_male_bc_04_bloody", "character_civ_head_bg_male_07_head_male_bc_04_beard_bloody", "character_civ_head_bg_male_07_head_male_bc_05_bloody", "character_civ_head_bg_male_07_head_male_bc_06_bloody", "character_civ_head_bg_male_07_head_sc_engineering_mate_bloody", "character_civ_head_bg_male_07_head_sc_lee_bloody", "character_civ_head_bg_male_19_bloody", "character_civ_head_male_bc_02_bloody", "character_civ_head_bg_male_11_bloody"];

  switch (scripts\code\character::get_random_character(26, var_0, var_1)) {
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
      _id_0480::main();
      break;
    case 24:
      _id_048C::main();
      break;
    case 25:
      _id_047C::main();
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
  _id_0480::precache();
  _id_048C::precache();
  _id_047C::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::_id_009B();
  aiasm\civilian_sp_MAYBE::_id_DEE8();
  _id_0C4A::_id_2371();
}