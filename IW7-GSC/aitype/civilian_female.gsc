/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\civilian_female.gsc
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
  var_0 = undefined;
  var_1 = ["character_civ_head_bg_female_03", "character_civ_head_bg_female_03_head_female_bc_01", "character_civ_head_bg_female_03_head_female_bc_02", "character_civ_head_bg_female_03_head_hero_air_boss", "character_civ_head_bg_female_03_head_hero_dropship_officer", "character_civ_head_bg_female_03_head_sc_comms_officer", "character_civ_head_bg_female_03_head_sc_female_04", "character_civ_head_bg_female_03_head_sc_owens", "character_civ_head_bg_female_04", "character_civ_head_bg_female_04_head_female_bc_02", "character_civ_head_bg_female_04_head_female_bc_03", "character_civ_head_bg_female_04_head_hero_air_boss", "character_civ_head_bg_female_04_head_hero_tigris_captain", "character_civ_head_bg_female_04_head_sc_owens", "character_civ_head_bg_female_comms_officer_head_female_bc_02", "character_civ_head_bg_female_comms_officer_head_female_bc_03", "character_civ_head_bg_female_comms_officer_head_sc_female_04", "character_civ_head_bg_female_comms_officer_head_sc_owens", "character_civ_head_female_bc_01", "character_civ_head_female_bc_02", "character_civ_head_sc_female_13"];

  switch (scripts\code\character::get_random_character(21, var_0, var_1)) {
    case 0:
      _id_0405::main();
      break;
    case 1:
      _id_0409::main();
      break;
    case 2:
      _id_040D::main();
      break;
    case 3:
      _id_0411::main();
      break;
    case 4:
      _id_0413::main();
      break;
    case 5:
      _id_0417::main();
      break;
    case 6:
      _id_0419::main();
      break;
    case 7:
      _id_041D::main();
      break;
    case 8:
      _id_0421::main();
      break;
    case 9:
      _id_0425::main();
      break;
    case 10:
      _id_0429::main();
      break;
    case 11:
      _id_042D::main();
      break;
    case 12:
      _id_042F::main();
      break;
    case 13:
      _id_0433::main();
      break;
    case 14:
      _id_0437::main();
      break;
    case 15:
      _id_043B::main();
      break;
    case 16:
      _id_043F::main();
      break;
    case 17:
      _id_0443::main();
      break;
    case 18:
      _id_0483::main();
      break;
    case 19:
      _id_0487::main();
      break;
    case 20:
      _id_048F::main();
      break;
  }
}

spawner() {
  self setspawnerteam("neutral");
}

precache() {
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
  _id_0483::precache();
  _id_0487::precache();
  _id_048F::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::_id_009B();
  aiasm\civilian_sp_MAYBE::_id_DEE8();
  _id_0C4A::_id_2371();
}