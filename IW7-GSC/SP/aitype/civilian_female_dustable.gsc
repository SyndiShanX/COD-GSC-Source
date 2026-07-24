/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\civilian_female_dustable.gsc
***********************************************/

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
  var_0 = [0.014, 0.056, 0.069, 0.111, 0.125, 0.167, 0.181, 0.222, 0.236, 0.278, 0.292, 0.333, 0.347, 0.389, 0.403, 0.444, 0.458, 0.5, 0.514, 0.556, 0.569, 0.611, 0.625, 0.667, 0.681, 0.722, 0.736, 0.778, 0.792, 0.833, 0.847, 0.889, 0.903, 0.944, 0.958, 1.0];
  var_1 = ["character_civ_head_bg_female_03_dustable", "character_civ_head_bg_female_03_bloody_dustable", "character_civ_head_bg_female_03_head_female_bc_01_dustable", "character_civ_head_bg_female_03_head_female_bc_01_bloody_dustable", "character_civ_head_bg_female_03_head_female_bc_02_dustable", "character_civ_head_bg_female_03_head_female_bc_02_bloody_dustable", "character_civ_head_bg_female_03_head_hero_dropship_officer_dustable", "character_civ_head_bg_female_03_head_hero_dropship_officer_bloody_dustable", "character_civ_head_bg_female_03_head_sc_female_04_dustable", "character_civ_head_bg_female_03_head_sc_female_04_bloody_dustable", "character_civ_head_bg_female_03_head_sc_owens_dustable", "character_civ_head_bg_female_03_head_sc_owens_bloody_dustable", "character_civ_head_bg_female_04_dustable", "character_civ_head_bg_female_04_bloody_dustable", "character_civ_head_bg_female_04_head_female_bc_02_dustable", "character_civ_head_bg_female_04_head_female_bc_02_bloody_dustable", "character_civ_head_bg_female_04_head_female_bc_03_dustable", "character_civ_head_bg_female_04_head_female_bc_03_bloody_dustable", "character_civ_head_bg_female_04_head_hero_tigris_captain_dustable", "character_civ_head_bg_female_04_head_hero_tigris_captain_bloody_dustable", "character_civ_head_bg_female_04_head_sc_owens_dustable", "character_civ_head_bg_female_04_head_sc_owens_bloody_dustable", "character_civ_head_bg_female_comms_officer_head_female_bc_02_dustable", "character_civ_head_bg_female_comms_officer_head_female_bc_02_bloody_dustable", "character_civ_head_bg_female_comms_officer_head_female_bc_03_dustable", "character_civ_head_bg_female_comms_officer_head_female_bc_03_bloody_dustable", "character_civ_head_bg_female_comms_officer_head_sc_female_04_dustable", "character_civ_head_bg_female_comms_officer_head_sc_female_04_bloody_dustable", "character_civ_head_bg_female_comms_officer_head_sc_owens_dustable", "character_civ_head_bg_female_comms_officer_head_sc_owens_bloody_dustable", "character_civ_head_female_bc_01_dustable", "character_civ_head_female_bc_01_bloody_dustable", "character_civ_head_female_bc_02_dustable", "character_civ_head_female_bc_02_bloody_dustable", "character_civ_head_sc_female_13_dustable", "character_civ_head_sc_female_13_bloody_dustable"];

  switch (scripts\code\character::get_random_character(36, var_0, var_1)) {
    case 0:
      _id_0408::main();
      break;
    case 1:
      _id_0407::main();
      break;
    case 2:
      _id_040C::main();
      break;
    case 3:
      _id_040B::main();
      break;
    case 4:
      _id_0410::main();
      break;
    case 5:
      _id_040F::main();
      break;
    case 6:
      _id_0416::main();
      break;
    case 7:
      _id_0415::main();
      break;
    case 8:
      _id_041C::main();
      break;
    case 9:
      _id_041B::main();
      break;
    case 10:
      _id_0420::main();
      break;
    case 11:
      _id_041F::main();
      break;
    case 12:
      _id_0424::main();
      break;
    case 13:
      _id_0423::main();
      break;
    case 14:
      _id_0428::main();
      break;
    case 15:
      _id_0427::main();
      break;
    case 16:
      _id_042C::main();
      break;
    case 17:
      _id_042B::main();
      break;
    case 18:
      _id_0432::main();
      break;
    case 19:
      _id_0431::main();
      break;
    case 20:
      _id_0436::main();
      break;
    case 21:
      _id_0435::main();
      break;
    case 22:
      _id_043A::main();
      break;
    case 23:
      _id_0439::main();
      break;
    case 24:
      _id_043E::main();
      break;
    case 25:
      _id_043D::main();
      break;
    case 26:
      _id_0442::main();
      break;
    case 27:
      _id_0441::main();
      break;
    case 28:
      _id_0446::main();
      break;
    case 29:
      _id_0445::main();
      break;
    case 30:
      _id_0486::main();
      break;
    case 31:
      _id_0485::main();
      break;
    case 32:
      _id_048A::main();
      break;
    case 33:
      _id_0489::main();
      break;
    case 34:
      _id_0492::main();
      break;
    case 35:
      _id_0491::main();
      break;
  }
}

spawner() {
  self setspawnerteam("neutral");
}

precache() {
  _id_0408::precache();
  _id_0407::precache();
  _id_040C::precache();
  _id_040B::precache();
  _id_0410::precache();
  _id_040F::precache();
  _id_0416::precache();
  _id_0415::precache();
  _id_041C::precache();
  _id_041B::precache();
  _id_0420::precache();
  _id_041F::precache();
  _id_0424::precache();
  _id_0423::precache();
  _id_0428::precache();
  _id_0427::precache();
  _id_042C::precache();
  _id_042B::precache();
  _id_0432::precache();
  _id_0431::precache();
  _id_0436::precache();
  _id_0435::precache();
  _id_043A::precache();
  _id_0439::precache();
  _id_043E::precache();
  _id_043D::precache();
  _id_0442::precache();
  _id_0441::precache();
  _id_0446::precache();
  _id_0445::precache();
  _id_0486::precache();
  _id_0485::precache();
  _id_048A::precache();
  _id_0489::precache();
  _id_0492::precache();
  _id_0491::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::_id_009B();
  aiasm\civilian_sp_MAYBE::_id_DEE8();
  _id_0C4A::_id_2371();
}