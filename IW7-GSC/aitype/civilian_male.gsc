/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\civilian_male.gsc
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
  var_0 = [0.047, 0.093, 0.14, 0.186, 0.209, 0.233, 0.279, 0.302, 0.349, 0.395, 0.419, 0.442, 0.465, 0.512, 0.558, 0.605, 0.651, 0.674, 0.698, 0.744, 0.767, 0.814, 0.86, 0.907, 0.953, 1.0];
  var_1 = ["character_civ_head_bg_engineering_mate_head_hero_gator", "character_civ_head_bg_engineering_mate_head_male_bc_01", "character_civ_head_bg_engineering_mate_head_male_bc_02", "character_civ_head_bg_engineering_mate_head_male_bc_03", "character_civ_head_bg_engineering_mate_head_male_bc_04", "character_civ_head_bg_engineering_mate_head_male_bc_04_beard", "character_civ_head_bg_engineering_mate_head_male_bc_05", "character_civ_head_bg_engineering_mate_head_male_bc_06", "character_civ_head_bg_engineering_mate_head_male_bc_07", "character_civ_head_bg_engineering_mate_head_sc_lee", "character_civ_head_bg_male_06", "character_civ_head_bg_male_06_head_male_bc_04", "character_civ_head_bg_male_06_head_male_bc_04_beard", "character_civ_head_bg_male_06_head_male_bc_05", "character_civ_head_bg_male_06_head_sc_lee", "character_civ_head_bg_male_07", "character_civ_head_bg_male_07_head_male_bc_03", "character_civ_head_bg_male_07_head_male_bc_04", "character_civ_head_bg_male_07_head_male_bc_04_beard", "character_civ_head_bg_male_07_head_male_bc_05", "character_civ_head_bg_male_07_head_male_bc_06", "character_civ_head_bg_male_07_head_sc_engineering_mate", "character_civ_head_bg_male_07_head_sc_lee", "character_civ_head_bg_male_19", "character_civ_head_male_bc_02", "character_civ_head_bg_male_11"];

  switch (scripts\code\character::get_random_character(26, var_0, var_1)) {
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
      _id_047F::main();
      break;
    case 24:
      _id_048B::main();
      break;
    case 25:
      _id_047B::main();
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
  _id_047F::precache();
  _id_048B::precache();
  _id_047B::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::_id_009B();
  aiasm\civilian_sp_MAYBE::_id_DEE8();
  _id_0C4A::_id_2371();
}