/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\civilian_miner_male_noh.gsc
**********************************************/

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
  var_0 = [0.625, 0.667, 0.708, 0.75, 0.792, 0.833, 0.875, 0.917, 0.958, 1.0];
  var_1 = ["character_civ_miner_male_noh", "character_civ_miner_male_noh_sc_male_11", "character_civ_miner_male_noh_sc_ling_hero_marine_1", "character_civ_miner_male_noh_sc_male_11_bg_male_09", "character_civ_miner_male_noh_sc_male_11_hero_marine_1", "character_civ_miner_male_noh_sc_male_11_sc_ling", "character_civ_miner_male_noh_sc_male_14_hero_marine_1", "character_civ_miner_male_noh_sc_male_19_hero_marine_1", "character_civ_miner_male_noh_sc_male_19_sc_ling", "character_civ_miner_male_noh_sc_male_19_sc_male_11"];

  switch (scripts\code\character::get_random_character(10, var_0, var_1)) {
    case 0:
      _id_049D::main();
      break;
    case 1:
      _id_049F::main();
      break;
    case 2:
      _id_049E::main();
      break;
    case 3:
      _id_04A0::main();
      break;
    case 4:
      _id_04A1::main();
      break;
    case 5:
      _id_04A2::main();
      break;
    case 6:
      _id_04A3::main();
      break;
    case 7:
      _id_04A4::main();
      break;
    case 8:
      _id_04A5::main();
      break;
    case 9:
      _id_04A6::main();
      break;
  }
}

spawner() {
  self setspawnerteam("neutral");
}

precache() {
  _id_049D::precache();
  _id_049F::precache();
  _id_049E::precache();
  _id_04A0::precache();
  _id_04A1::precache();
  _id_04A2::precache();
  _id_04A3::precache();
  _id_04A4::precache();
  _id_04A5::precache();
  _id_04A6::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::_id_009B();
  aiasm\civilian_sp_MAYBE::_id_DEE8();
  _id_0C4A::_id_2371();
}