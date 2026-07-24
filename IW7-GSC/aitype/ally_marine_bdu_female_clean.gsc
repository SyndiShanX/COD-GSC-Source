/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_marine_bdu_female_clean.gsc
***************************************************/

main() {
  self._id_17DB = "";
  self.team = "allies";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = "";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self._id_101B4 = "";
  self.behaviortreeasset = "enemy_combatant";
  self._id_1FA9 = "soldier";

  if(isai(self)) {
    self _meth_82DC(256.0, 0.0);
    self _meth_82DB(768.0, 1024.0);
  }

  self.weapon = "none";
  var_0 = [0.053, 0.105, 0.158, 0.211, 0.263, 0.316, 0.368, 0.421, 0.474, 0.526, 0.579, 0.632, 0.684, 0.737, 0.789, 0.842, 0.895, 0.947, 1.0];
  var_1 = ["character_un_marine_bdu_comms_officer_female_bc_02", "character_un_marine_bdu_comms_officer_female_04", "character_un_marine_bdu_comms_officer_female_05", "character_un_marine_bdu_comms_officer_female_11", "character_un_marine_bdu_female_14_hero_xo", "character_un_marine_bdu_female_14", "character_un_marine_bdu_female_14_female_04", "character_un_marine_bdu_female_14_female_05", "character_un_marine_bdu_female_14_female_11", "character_un_marine_bdu_female_04_comms_officer", "character_un_marine_bdu_female_04_female_14", "character_un_marine_bdu_female_04", "character_un_marine_bdu_female_04_female_05", "character_un_marine_bdu_female_05_female_bc_02", "character_un_marine_bdu_female_05_comms_officer", "character_un_marine_bdu_female_05_female_marine", "character_un_marine_bdu_female_05", "character_un_marine_bdu_female_05_female_11", "character_un_marine_bdu_female_11"];

  switch (scripts\code\character::get_random_character(19, var_0, var_1)) {
    case 0:
      _id_0833::main();
      break;
    case 1:
      _id_0830::main();
      break;
    case 2:
      _id_0831::main();
      break;
    case 3:
      _id_0832::main();
      break;
    case 4:
      _id_0851::main();
      break;
    case 5:
      _id_084D::main();
      break;
    case 6:
      _id_084E::main();
      break;
    case 7:
      _id_084F::main();
      break;
    case 8:
      _id_0850::main();
      break;
    case 9:
      _id_0844::main();
      break;
    case 10:
      _id_0846::main();
      break;
    case 11:
      _id_0843::main();
      break;
    case 12:
      _id_0845::main();
      break;
    case 13:
      _id_084A::main();
      break;
    case 14:
      _id_0848::main();
      break;
    case 15:
      _id_084B::main();
      break;
    case 16:
      _id_0847::main();
      break;
    case 17:
      _id_0849::main();
      break;
    case 18:
      _id_084C::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_0833::precache();
  _id_0830::precache();
  _id_0831::precache();
  _id_0832::precache();
  _id_0851::precache();
  _id_084D::precache();
  _id_084E::precache();
  _id_084F::precache();
  _id_0850::precache();
  _id_0844::precache();
  _id_0846::precache();
  _id_0843::precache();
  _id_0845::precache();
  _id_084A::precache();
  _id_0848::precache();
  _id_084B::precache();
  _id_0847::precache();
  _id_0849::precache();
  _id_084C::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}