/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_sdf_ar_nohelmet.gsc
********************************************/

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

  self.weapon = _id_0A2F::_id_7BEC("rifle");
  var_0 = [0.28, 0.3, 0.32, 0.34, 0.36, 0.38, 0.4, 0.42, 0.44, 0.46, 0.48, 0.5, 0.78, 0.8, 0.82, 0.84, 0.86, 0.88, 0.9, 0.92, 0.94, 0.96, 0.98, 1.0];
  var_1 = ["character_sdf_army_light_1_nohelmet", "character_sdf_army_light_1_nohelmet_kloos", "character_sdf_army_light_1_nohelmet_kloos_male_24", "character_sdf_army_light_1_nohelmet_male_17_kloos", "character_sdf_army_light_1_nohelmet_male_17_male_21", "character_sdf_army_light_1_nohelmet_male_17_male_24", "character_sdf_army_light_1_nohelmet_male_17_male_25", "character_sdf_army_light_1_nohelmet_male_21", "character_sdf_army_light_1_nohelmet_male_25", "character_sdf_army_light_1_nohelmet_male_25_male_24", "character_sdf_army_light_1_nohelmet_male_28", "character_sdf_army_light_1_nohelmet_male_28_male_24", "character_sdf_army_heavy_4_nohelmet", "character_sdf_army_heavy_4_nohelmet_kloos", "character_sdf_army_heavy_4_nohelmet_kloos_male_24", "character_sdf_army_heavy_4_nohelmet_male_17_kloos", "character_sdf_army_heavy_4_nohelmet_male_17_male_21", "character_sdf_army_heavy_4_nohelmet_male_17_male_24", "character_sdf_army_heavy_4_nohelmet_male_17_male_25", "character_sdf_army_heavy_4_nohelmet_male_21", "character_sdf_army_heavy_4_nohelmet_male_25", "character_sdf_army_heavy_4_nohelmet_male_25_male_24", "character_sdf_army_heavy_4_nohelmet_male_28", "character_sdf_army_heavy_4_nohelmet_male_28_male_24"];

  switch (scripts\code\character::get_random_character(24, var_0, var_1)) {
    case 0:
      _id_0502::main();
      break;
    case 1:
      _id_0503::main();
      break;
    case 2:
      _id_0504::main();
      break;
    case 3:
      _id_0505::main();
      break;
    case 4:
      _id_0506::main();
      break;
    case 5:
      _id_0507::main();
      break;
    case 6:
      _id_0508::main();
      break;
    case 7:
      _id_0509::main();
      break;
    case 8:
      _id_050A::main();
      break;
    case 9:
      _id_050B::main();
      break;
    case 10:
      _id_050C::main();
      break;
    case 11:
      _id_050D::main();
      break;
    case 12:
      _id_04EF::main();
      break;
    case 13:
      _id_04F0::main();
      break;
    case 14:
      _id_04F1::main();
      break;
    case 15:
      _id_04F2::main();
      break;
    case 16:
      _id_04F3::main();
      break;
    case 17:
      _id_04F4::main();
      break;
    case 18:
      _id_04F5::main();
      break;
    case 19:
      _id_04F6::main();
      break;
    case 20:
      _id_04F7::main();
      break;
    case 21:
      _id_04F8::main();
      break;
    case 22:
      _id_04F9::main();
      break;
    case 23:
      _id_04FA::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  _id_0502::precache();
  _id_0503::precache();
  _id_0504::precache();
  _id_0505::precache();
  _id_0506::precache();
  _id_0507::precache();
  _id_0508::precache();
  _id_0509::precache();
  _id_050A::precache();
  _id_050B::precache();
  _id_050C::precache();
  _id_050D::precache();
  _id_04EF::precache();
  _id_04F0::precache();
  _id_04F1::precache();
  _id_04F2::precache();
  _id_04F3::precache();
  _id_04F4::precache();
  _id_04F5::precache();
  _id_04F6::precache();
  _id_04F7::precache();
  _id_04F8::precache();
  _id_04F9::precache();
  _id_04FA::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}