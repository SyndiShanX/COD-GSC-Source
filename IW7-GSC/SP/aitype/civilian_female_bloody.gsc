/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\civilian_female_bloody.gsc
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
  var_0 = undefined;
  var_1 = ["character_civ_head_bg_female_03_bloody", "character_civ_head_bg_female_03_head_female_bc_01_bloody", "character_civ_head_bg_female_03_head_female_bc_02_bloody", "character_civ_head_bg_female_comms_officer_head_sc_female_04_bloody", "character_civ_head_bg_female_03_head_hero_dropship_officer_bloody", "character_civ_head_bg_female_comms_officer_head_female_bc_03_bloody", "character_civ_head_bg_female_03_head_sc_female_04_bloody", "character_civ_head_bg_female_03_head_sc_owens_bloody", "character_civ_head_bg_female_04_bloody", "character_civ_head_bg_female_04_head_female_bc_02_bloody", "character_civ_head_bg_female_04_head_female_bc_03_bloody", "character_civ_head_bg_female_comms_officer_head_sc_owens_bloody", "character_civ_head_bg_female_04_head_hero_tigris_captain_bloody", "character_civ_head_bg_female_04_head_sc_owens_bloody", "character_civ_head_bg_female_comms_officer_head_female_bc_02_bloody", "character_civ_head_female_bc_01_bloody", "character_civ_head_female_bc_02_bloody", "character_civ_head_sc_female_13_bloody"];

  switch (scripts\code\character::get_random_character(18, var_0, var_1)) {
    case 0:
      _id_0406::main();
      break;
    case 1:
      _id_040A::main();
      break;
    case 2:
      _id_040E::main();
      break;
    case 3:
      _id_0440::main();
      break;
    case 4:
      _id_0414::main();
      break;
    case 5:
      _id_043C::main();
      break;
    case 6:
      _id_041A::main();
      break;
    case 7:
      _id_041E::main();
      break;
    case 8:
      _id_0422::main();
      break;
    case 9:
      _id_0426::main();
      break;
    case 10:
      _id_042A::main();
      break;
    case 11:
      _id_0444::main();
      break;
    case 12:
      _id_0430::main();
      break;
    case 13:
      _id_0434::main();
      break;
    case 14:
      _id_0438::main();
      break;
    case 15:
      _id_0484::main();
      break;
    case 16:
      _id_0488::main();
      break;
    case 17:
      _id_0490::main();
      break;
  }
}

spawner() {
  self setspawnerteam("neutral");
}

precache() {
  _id_0406::precache();
  _id_040A::precache();
  _id_040E::precache();
  _id_0440::precache();
  _id_0414::precache();
  _id_043C::precache();
  _id_041A::precache();
  _id_041E::precache();
  _id_0422::precache();
  _id_0426::precache();
  _id_042A::precache();
  _id_0444::precache();
  _id_0430::precache();
  _id_0434::precache();
  _id_0438::precache();
  _id_0484::precache();
  _id_0488::precache();
  _id_0490::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::_id_009B();
  aiasm\civilian_sp_MAYBE::_id_DEE8();
  _id_0C4A::_id_2371();
}