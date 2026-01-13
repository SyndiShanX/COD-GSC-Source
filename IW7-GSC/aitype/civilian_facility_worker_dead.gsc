/****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: aitype\civilian_facility_worker_dead.gsc
****************************************************/

main() {
  self.var_17DB = "";
  self.team = "allies";
  self.type = "human";
  self.unittype = "civilian";
  self.subclass = "noboost";
  self.accuracy = 0.2;
  self.health = 30;
  self.objective_team = "";
  self.objective_state = 0;
  self.secondaryweapon = "";
  self.var_101B4 = "";
  self.behaviortreeasset = "civilian";
  self.var_1FA9 = "civilian";
  if(isai(self)) {
    self _meth_82DC(256, 0);
    self _meth_82DB(768, 1024);
  }

  self.var_394 = "none";
  var_0 = [0.047, 0.093, 0.14, 0.186, 0.233, 0.256, 0.279, 0.326, 0.349, 0.395, 0.442, 0.465, 0.488, 0.512, 0.558, 0.605, 0.651, 0.698, 0.721, 0.744, 0.791, 0.814, 0.86, 0.907, 0.953, 1];
  var_1 = ["character_civ_facility_worker_dead_head_bg_male_07_head_sc_lee", "character_civ_facility_worker_dead_head_bg_engineering_mate_head_hero_gator", "character_civ_facility_worker_dead_head_bg_engineering_mate_head_male_bc_01", "character_civ_facility_worker_dead_head_bg_engineering_mate_head_male_bc_02", "character_civ_facility_worker_dead_head_bg_engineering_mate_head_male_bc_03", "character_civ_facility_worker_dead_head_bg_engineering_mate_head_male_bc_04", "character_civ_facility_worker_dead_head_bg_engineering_mate_head_male_bc_04_beard", "character_civ_facility_worker_dead_head_bg_engineering_mate_head_male_bc_05", "character_civ_facility_worker_dead_head_bg_engineering_mate_head_male_bc_06", "character_civ_facility_worker_dead_head_bg_engineering_mate_head_male_bc_07", "character_civ_facility_worker_dead_head_bg_engineering_mate_head_sc_lee", "character_civ_facility_worker_dead_head_bg_male_06", "character_civ_facility_worker_dead_head_bg_male_06_head_male_bc_04", "character_civ_facility_worker_dead_head_bg_male_06_head_male_bc_04_beard", "character_civ_facility_worker_dead_head_bg_male_06_head_male_bc_05", "character_civ_facility_worker_dead_head_bg_male_06_head_sc_lee", "character_civ_facility_worker_dead_head_bg_male_07", "character_civ_facility_worker_dead_head_bg_male_07_head_male_bc_03", "character_civ_facility_worker_dead_head_bg_male_07_head_male_bc_04", "character_civ_facility_worker_dead_head_bg_male_07_head_male_bc_04_beard", "character_civ_facility_worker_dead_head_bg_male_07_head_male_bc_05", "character_civ_facility_worker_dead_head_bg_male_07_head_male_bc_06", "character_civ_facility_worker_dead_head_bg_male_07_head_sc_engineering_mate", "character_civ_facility_worker_dead_head_sc_male_19", "character_civ_facility_worker_dead_head_male_bc_02", "character_civ_facility_worker_dead_head_sc_male_11"];
  switch (scripts\code\character::get_random_character(26, var_0, var_1)) {
    case 0:
      lib_03D4::main();
      break;

    case 1:
      lib_03BE::main();
      break;

    case 2:
      lib_03BF::main();
      break;

    case 3:
      lib_03C0::main();
      break;

    case 4:
      lib_03C1::main();
      break;

    case 5:
      lib_03C2::main();
      break;

    case 6:
      lib_03C3::main();
      break;

    case 7:
      lib_03C4::main();
      break;

    case 8:
      lib_03C5::main();
      break;

    case 9:
      lib_03C6::main();
      break;

    case 10:
      lib_03C7::main();
      break;

    case 11:
      lib_03C8::main();
      break;

    case 12:
      lib_03C9::main();
      break;

    case 13:
      lib_03CA::main();
      break;

    case 14:
      lib_03CB::main();
      break;

    case 15:
      lib_03CC::main();
      break;

    case 16:
      lib_03CD::main();
      break;

    case 17:
      lib_03CE::main();
      break;

    case 18:
      lib_03CF::main();
      break;

    case 19:
      lib_03D0::main();
      break;

    case 20:
      lib_03D1::main();
      break;

    case 21:
      lib_03D2::main();
      break;

    case 22:
      lib_03D3::main();
      break;

    case 23:
      lib_03D7::main();
      break;

    case 24:
      lib_03D5::main();
      break;

    case 25:
      lib_03D6::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  lib_03D4::precache();
  lib_03BE::precache();
  lib_03BF::precache();
  lib_03C0::precache();
  lib_03C1::precache();
  lib_03C2::precache();
  lib_03C3::precache();
  lib_03C4::precache();
  lib_03C5::precache();
  lib_03C6::precache();
  lib_03C7::precache();
  lib_03C8::precache();
  lib_03C9::precache();
  lib_03CA::precache();
  lib_03CB::precache();
  lib_03CC::precache();
  lib_03CD::precache();
  lib_03CE::precache();
  lib_03CF::precache();
  lib_03D0::precache();
  lib_03D1::precache();
  lib_03D2::precache();
  lib_03D3::precache();
  lib_03D7::precache();
  lib_03D5::precache();
  lib_03D6::precache();
  scripts\aitypes\bt_util::init();
  lib_09FD::opcode::OP_EvalArray();
  aiasm\civilian_sp_MAYBE::func_DEE8();
  lib_0C4A::func_2371();
}