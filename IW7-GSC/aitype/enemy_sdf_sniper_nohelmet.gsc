/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_sdf_sniper_nohelmet.gsc
************************************************/

main() {
  self._id_17DB = "";
  self.team = "axis";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "regular";
  self.accuracy = 0.5;
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

  self.weapon = _id_0A2F::_id_7BEC("sniper");
  var_0 = [0.56, 0.6, 0.64, 0.68, 0.72, 0.76, 0.8, 0.84, 0.88, 0.92, 0.96, 1.0];
  var_1 = ["character_sdf_army_ghost_1_nohelmet", "character_sdf_army_ghost_1_nohelmet_kloos", "character_sdf_army_ghost_1_nohelmet_kloos_male_24", "character_sdf_army_ghost_1_nohelmet_male_17_kloos", "character_sdf_army_ghost_1_nohelmet_male_17_male_21", "character_sdf_army_ghost_1_nohelmet_male_17_male_24", "character_sdf_army_ghost_1_nohelmet_male_17_male_25", "character_sdf_army_ghost_1_nohelmet_male_21", "character_sdf_army_ghost_1_nohelmet_male_25", "character_sdf_army_ghost_1_nohelmet_male_25_male_24", "character_sdf_army_ghost_1_nohelmet_male_28", "character_sdf_army_ghost_1_nohelmet_male_28_male_24"];

  switch (scripts\code\character::get_random_character(12, var_0, var_1)) {
    case 0:
      _id_04D8::main();
      break;
    case 1:
      _id_04D9::main();
      break;
    case 2:
      _id_04DA::main();
      break;
    case 3:
      _id_04DB::main();
      break;
    case 4:
      _id_04DC::main();
      break;
    case 5:
      _id_04DD::main();
      break;
    case 6:
      _id_04DE::main();
      break;
    case 7:
      _id_04DF::main();
      break;
    case 8:
      _id_04E0::main();
      break;
    case 9:
      _id_04E1::main();
      break;
    case 10:
      _id_04E2::main();
      break;
    case 11:
      _id_04E3::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  _id_04D8::precache();
  _id_04D9::precache();
  _id_04DA::precache();
  _id_04DB::precache();
  _id_04DC::precache();
  _id_04DD::precache();
  _id_04DE::precache();
  _id_04DF::precache();
  _id_04E0::precache();
  _id_04E1::precache();
  _id_04E2::precache();
  _id_04E3::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}