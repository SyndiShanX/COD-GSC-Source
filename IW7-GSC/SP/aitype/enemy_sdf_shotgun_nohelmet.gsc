/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_sdf_shotgun_nohelmet.gsc
*************************************************/

main() {
  self._id_17DB = "";
  self.team = "axis";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = _id_0A2F::_id_7BEB();
  self.grenadeammo = 1;
  self.secondaryweapon = "";
  self._id_101B4 = _id_0A2F::_id_7BEC("pistol");
  self.behaviortreeasset = "enemy_combatant";
  self._id_1FA9 = "soldier";

  if(isai(self)) {
    self _meth_82DC(256.0, 0.0);
    self _meth_82DB(768.0, 1024.0);
  }

  self.weapon = _id_0A2F::_id_7BEC("spread");
  var_0 = [0.56, 0.6, 0.64, 0.68, 0.72, 0.76, 0.8, 0.84, 0.88, 0.92, 0.96, 1.0];
  var_1 = ["character_sdf_army_armored_1_nohelmet", "character_sdf_army_armored_1_nohelmet_kloos", "character_sdf_army_armored_1_nohelmet_kloos_male_24", "character_sdf_army_armored_1_nohelmet_male_17_kloos", "character_sdf_army_armored_1_nohelmet_male_17_male_21", "character_sdf_army_armored_1_nohelmet_male_17_male_24", "character_sdf_army_armored_1_nohelmet_male_17_male_25", "character_sdf_army_armored_1_nohelmet_male_21", "character_sdf_army_armored_1_nohelmet_male_25", "character_sdf_army_armored_1_nohelmet_male_25_male_24", "character_sdf_army_armored_1_nohelmet_male_28", "character_sdf_army_armored_1_nohelmet_male_28_male_24"];

  switch (scripts\code\character::get_random_character(12, var_0, var_1)) {
    case 0:
      _id_04CA::main();
      break;
    case 1:
      _id_04CB::main();
      break;
    case 2:
      _id_04CC::main();
      break;
    case 3:
      _id_04CD::main();
      break;
    case 4:
      _id_04CE::main();
      break;
    case 5:
      _id_04CF::main();
      break;
    case 6:
      _id_04D0::main();
      break;
    case 7:
      _id_04D1::main();
      break;
    case 8:
      _id_04D2::main();
      break;
    case 9:
      _id_04D3::main();
      break;
    case 10:
      _id_04D4::main();
      break;
    case 11:
      _id_04D5::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  _id_04CA::precache();
  _id_04CB::precache();
  _id_04CC::precache();
  _id_04CD::precache();
  _id_04CE::precache();
  _id_04CF::precache();
  _id_04D0::precache();
  _id_04D1::precache();
  _id_04D2::precache();
  _id_04D3::precache();
  _id_04D4::precache();
  _id_04D5::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}