/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\civilian_facility_worker_dead.gsc
****************************************************/

main() {
  self._id_17DB = "";
  self.team = "allies";
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
  var_0 = [0.047, 0.093, 0.14, 0.186, 0.233, 0.256, 0.279, 0.326, 0.349, 0.395, 0.442, 0.465, 0.488, 0.512, 0.558, 0.605, 0.651, 0.698, 0.721, 0.744, 0.791, 0.814, 0.86, 0.907, 0.953, 1.0];
  var_1 = ["character_civ_facility_worker_dead_head_bg_male_07_head_sc_lee", "character_civ_facility_worker_dead_head_bg_engineering_mate_head_hero_gator", "character_civ_facility_worker_dead_head_bg_engineering_mate_head_male_bc_01", "character_civ_facility_worker_dead_head_bg_engineering_mate_head_male_bc_02", "character_civ_facility_worker_dead_head_bg_engineering_mate_head_male_bc_03", "character_civ_facility_worker_dead_head_bg_engineering_mate_head_male_bc_04", "character_civ_facility_worker_dead_head_bg_engineering_mate_head_male_bc_04_beard", "character_civ_facility_worker_dead_head_bg_engineering_mate_head_male_bc_05", "character_civ_facility_worker_dead_head_bg_engineering_mate_head_male_bc_06", "character_civ_facility_worker_dead_head_bg_engineering_mate_head_male_bc_07", "character_civ_facility_worker_dead_head_bg_engineering_mate_head_sc_lee", "character_civ_facility_worker_dead_head_bg_male_06", "character_civ_facility_worker_dead_head_bg_male_06_head_male_bc_04", "character_civ_facility_worker_dead_head_bg_male_06_head_male_bc_04_beard", "character_civ_facility_worker_dead_head_bg_male_06_head_male_bc_05", "character_civ_facility_worker_dead_head_bg_male_06_head_sc_lee", "character_civ_facility_worker_dead_head_bg_male_07", "character_civ_facility_worker_dead_head_bg_male_07_head_male_bc_03", "character_civ_facility_worker_dead_head_bg_male_07_head_male_bc_04", "character_civ_facility_worker_dead_head_bg_male_07_head_male_bc_04_beard", "character_civ_facility_worker_dead_head_bg_male_07_head_male_bc_05", "character_civ_facility_worker_dead_head_bg_male_07_head_male_bc_06", "character_civ_facility_worker_dead_head_bg_male_07_head_sc_engineering_mate", "character_civ_facility_worker_dead_head_sc_male_19", "character_civ_facility_worker_dead_head_male_bc_02", "character_civ_facility_worker_dead_head_sc_male_11"];

  switch (scripts\code\character::get_random_character(26, var_0, var_1)) {
    case 0:
      _id_03D4::main();
      break;
    case 1:
      _id_03BE::main();
      break;
    case 2:
      _id_03BF::main();
      break;
    case 3:
      _id_03C0::main();
      break;
    case 4:
      _id_03C1::main();
      break;
    case 5:
      _id_03C2::main();
      break;
    case 6:
      _id_03C3::main();
      break;
    case 7:
      _id_03C4::main();
      break;
    case 8:
      _id_03C5::main();
      break;
    case 9:
      _id_03C6::main();
      break;
    case 10:
      _id_03C7::main();
      break;
    case 11:
      _id_03C8::main();
      break;
    case 12:
      _id_03C9::main();
      break;
    case 13:
      _id_03CA::main();
      break;
    case 14:
      _id_03CB::main();
      break;
    case 15:
      _id_03CC::main();
      break;
    case 16:
      _id_03CD::main();
      break;
    case 17:
      _id_03CE::main();
      break;
    case 18:
      _id_03CF::main();
      break;
    case 19:
      _id_03D0::main();
      break;
    case 20:
      _id_03D1::main();
      break;
    case 21:
      _id_03D2::main();
      break;
    case 22:
      _id_03D3::main();
      break;
    case 23:
      _id_03D7::main();
      break;
    case 24:
      _id_03D5::main();
      break;
    case 25:
      _id_03D6::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_03D4::precache();
  _id_03BE::precache();
  _id_03BF::precache();
  _id_03C0::precache();
  _id_03C1::precache();
  _id_03C2::precache();
  _id_03C3::precache();
  _id_03C4::precache();
  _id_03C5::precache();
  _id_03C6::precache();
  _id_03C7::precache();
  _id_03C8::precache();
  _id_03C9::precache();
  _id_03CA::precache();
  _id_03CB::precache();
  _id_03CC::precache();
  _id_03CD::precache();
  _id_03CE::precache();
  _id_03CF::precache();
  _id_03D0::precache();
  _id_03D1::precache();
  _id_03D2::precache();
  _id_03D3::precache();
  _id_03D7::precache();
  _id_03D5::precache();
  _id_03D6::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::_id_009B();
  aiasm\civilian_sp_MAYBE::_id_DEE8();
  _id_0C4A::_id_2371();
}