/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\civilian_male_dustable.gsc
*********************************************/

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
  var_0 = [0.012, 0.047, 0.058, 0.093, 0.105, 0.14, 0.151, 0.186, 0.192, 0.209, 0.215, 0.233, 0.244, 0.279, 0.285, 0.302, 0.314, 0.349, 0.36, 0.395, 0.401, 0.419, 0.424, 0.442, 0.448, 0.465, 0.477, 0.512, 0.523, 0.558, 0.57, 0.605, 0.616, 0.651, 0.657, 0.674, 0.68, 0.698, 0.709, 0.744, 0.75, 0.767, 0.779, 0.814, 0.826, 0.86, 0.872, 0.907, 0.919, 0.953, 0.965, 1.0];
  var_1 = ["character_civ_head_bg_engineering_mate_head_hero_gator_dustable", "character_civ_head_bg_engineering_mate_head_hero_gator_bloody_dustable", "character_civ_head_bg_engineering_mate_head_male_bc_01_dustable", "character_civ_head_bg_engineering_mate_head_male_bc_01_bloody_dustable", "character_civ_head_bg_engineering_mate_head_male_bc_02_dustable", "character_civ_head_bg_engineering_mate_head_male_bc_02_bloody_dustable", "character_civ_head_bg_engineering_mate_head_male_bc_03_dustable", "character_civ_head_bg_engineering_mate_head_male_bc_03_bloody_dustable", "character_civ_head_bg_engineering_mate_head_male_bc_04_dustable", "character_civ_head_bg_engineering_mate_head_male_bc_04_bloody_dustable", "character_civ_head_bg_engineering_mate_head_male_bc_04_beard_dustable", "character_civ_head_bg_engineering_mate_head_male_bc_04_beard_bloody_dustable", "character_civ_head_bg_engineering_mate_head_male_bc_05_dustable", "character_civ_head_bg_engineering_mate_head_male_bc_05_bloody_dustable", "character_civ_head_bg_engineering_mate_head_male_bc_06_dustable", "character_civ_head_bg_engineering_mate_head_male_bc_06_bloody_dustable", "character_civ_head_bg_engineering_mate_head_male_bc_07_dustable", "character_civ_head_bg_engineering_mate_head_male_bc_07_bloody_dustable", "character_civ_head_bg_engineering_mate_head_sc_lee_dustable", "character_civ_head_bg_engineering_mate_head_sc_lee_bloody_dustable", "character_civ_head_bg_male_06_dustable", "character_civ_head_bg_male_06_bloody_dustable", "character_civ_head_bg_male_06_head_male_bc_04_dustable", "character_civ_head_bg_male_06_head_male_bc_04_bloody_dustable", "character_civ_head_bg_male_06_head_male_bc_04_beard_dustable", "character_civ_head_bg_male_06_head_male_bc_04_beard_bloody_dustable", "character_civ_head_bg_male_06_head_male_bc_05_dustable", "character_civ_head_bg_male_06_head_male_bc_05_bloody_dustable", "character_civ_head_bg_male_06_head_sc_lee_dustable", "character_civ_head_bg_male_06_head_sc_lee_bloody_dustable", "character_civ_head_bg_male_07_dustable", "character_civ_head_bg_male_07_bloody_dustable", "character_civ_head_bg_male_07_head_male_bc_03_dustable", "character_civ_head_bg_male_07_head_male_bc_03_bloody_dustable", "character_civ_head_bg_male_07_head_male_bc_04_dustable", "character_civ_head_bg_male_07_head_male_bc_04_bloody_dustable", "character_civ_head_bg_male_07_head_male_bc_04_beard_dustable", "character_civ_head_bg_male_07_head_male_bc_04_beard_bloody_dustable", "character_civ_head_bg_male_07_head_male_bc_05_dustable", "character_civ_head_bg_male_07_head_male_bc_05_bloody_dustable", "character_civ_head_bg_male_07_head_male_bc_06_dustable", "character_civ_head_bg_male_07_head_male_bc_06_bloody_dustable", "character_civ_head_bg_male_07_head_sc_engineering_mate_dustable", "character_civ_head_bg_male_07_head_sc_engineering_mate_bloody_dustable", "character_civ_head_bg_male_07_head_sc_lee_dustable", "character_civ_head_bg_male_07_head_sc_lee_bloody_dustable", "character_civ_head_bg_male_19_dustable", "character_civ_head_bg_male_19_bloody_dustable", "character_civ_head_male_bc_02_dustable", "character_civ_head_male_bc_02_bloody_dustable", "character_civ_head_bg_male_11_dustable", "character_civ_head_bg_male_11_bloody_dustable"];

  switch (scripts\code\character::get_random_character(52, var_0, var_1)) {
    case 0:
      _id_03E0::main();
      break;
    case 1:
      _id_03DF::main();
      break;
    case 2:
      _id_03E4::main();
      break;
    case 3:
      _id_03E3::main();
      break;
    case 4:
      _id_03E8::main();
      break;
    case 5:
      _id_03E7::main();
      break;
    case 6:
      _id_03EC::main();
      break;
    case 7:
      _id_03EB::main();
      break;
    case 8:
      _id_03F4::main();
      break;
    case 9:
      _id_03F3::main();
      break;
    case 10:
      _id_03F1::main();
      break;
    case 11:
      _id_03F0::main();
      break;
    case 12:
      _id_03F8::main();
      break;
    case 13:
      _id_03F7::main();
      break;
    case 14:
      _id_03FC::main();
      break;
    case 15:
      _id_03FB::main();
      break;
    case 16:
      _id_0400::main();
      break;
    case 17:
      _id_03FF::main();
      break;
    case 18:
      _id_0404::main();
      break;
    case 19:
      _id_0403::main();
      break;
    case 20:
      _id_044A::main();
      break;
    case 21:
      _id_0449::main();
      break;
    case 22:
      _id_0452::main();
      break;
    case 23:
      _id_0451::main();
      break;
    case 24:
      _id_044F::main();
      break;
    case 25:
      _id_044E::main();
      break;
    case 26:
      _id_0456::main();
      break;
    case 27:
      _id_0455::main();
      break;
    case 28:
      _id_045A::main();
      break;
    case 29:
      _id_0459::main();
      break;
    case 30:
      _id_045E::main();
      break;
    case 31:
      _id_045D::main();
      break;
    case 32:
      _id_0462::main();
      break;
    case 33:
      _id_0461::main();
      break;
    case 34:
      _id_046A::main();
      break;
    case 35:
      _id_0469::main();
      break;
    case 36:
      _id_0467::main();
      break;
    case 37:
      _id_0466::main();
      break;
    case 38:
      _id_046E::main();
      break;
    case 39:
      _id_046D::main();
      break;
    case 40:
      _id_0472::main();
      break;
    case 41:
      _id_0471::main();
      break;
    case 42:
      _id_0476::main();
      break;
    case 43:
      _id_0475::main();
      break;
    case 44:
      _id_047A::main();
      break;
    case 45:
      _id_0479::main();
      break;
    case 46:
      _id_0482::main();
      break;
    case 47:
      _id_0481::main();
      break;
    case 48:
      _id_048E::main();
      break;
    case 49:
      _id_048D::main();
      break;
    case 50:
      _id_047E::main();
      break;
    case 51:
      _id_047D::main();
      break;
  }
}

spawner() {
  self setspawnerteam("neutral");
}

precache() {
  _id_03E0::precache();
  _id_03DF::precache();
  _id_03E4::precache();
  _id_03E3::precache();
  _id_03E8::precache();
  _id_03E7::precache();
  _id_03EC::precache();
  _id_03EB::precache();
  _id_03F4::precache();
  _id_03F3::precache();
  _id_03F1::precache();
  _id_03F0::precache();
  _id_03F8::precache();
  _id_03F7::precache();
  _id_03FC::precache();
  _id_03FB::precache();
  _id_0400::precache();
  _id_03FF::precache();
  _id_0404::precache();
  _id_0403::precache();
  _id_044A::precache();
  _id_0449::precache();
  _id_0452::precache();
  _id_0451::precache();
  _id_044F::precache();
  _id_044E::precache();
  _id_0456::precache();
  _id_0455::precache();
  _id_045A::precache();
  _id_0459::precache();
  _id_045E::precache();
  _id_045D::precache();
  _id_0462::precache();
  _id_0461::precache();
  _id_046A::precache();
  _id_0469::precache();
  _id_0467::precache();
  _id_0466::precache();
  _id_046E::precache();
  _id_046D::precache();
  _id_0472::precache();
  _id_0471::precache();
  _id_0476::precache();
  _id_0475::precache();
  _id_047A::precache();
  _id_0479::precache();
  _id_0482::precache();
  _id_0481::precache();
  _id_048E::precache();
  _id_048D::precache();
  _id_047E::precache();
  _id_047D::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::_id_009B();
  aiasm\civilian_sp_MAYBE::_id_DEE8();
  _id_0C4A::_id_2371();
}