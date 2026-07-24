/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_crew_ship_female.gsc
********************************************/

main() {
  self._id_17DB = "";
  self.team = "allies";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "crew";
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
  var_0 = [0.043, 0.087, 0.13, 0.174, 0.217, 0.261, 0.304, 0.348, 0.391, 0.435, 0.478, 0.522, 0.565, 0.609, 0.652, 0.696, 0.739, 0.783, 0.826, 0.87, 0.913, 0.957, 1.0];
  var_1 = ["character_un_crew_ship_female_bc_02_hero_xo_cap", "character_un_crew_ship_female_bc_02_comms_officer_cap", "character_un_crew_ship_female_bc_02_female_14_cap", "character_un_crew_ship_female_bc_02_female_05_cap", "character_un_crew_ship_comms_officer_female_bc_02", "character_un_crew_ship_comms_officer_female_04", "character_un_crew_ship_comms_officer_female_05", "character_un_crew_ship_comms_officer_female_11", "character_un_crew_ship_female_14_hero_xo", "character_un_crew_ship_female_14", "character_un_crew_ship_female_14_female_04", "character_un_crew_ship_female_14_female_05", "character_un_crew_ship_female_14_female_11", "character_un_crew_ship_female_04_comms_officer", "character_un_crew_ship_female_04_female_14", "character_un_crew_ship_female_04", "character_un_crew_ship_female_04_female_05", "character_un_crew_ship_female_05_female_bc_02", "character_un_crew_ship_female_05_comms_officer", "character_un_crew_ship_female_05_female_marine", "character_un_crew_ship_female_05", "character_un_crew_ship_female_05_female_11", "character_un_crew_ship_female_11"];

  switch (scripts\code\character::get_random_character(23, var_0, var_1)) {
    case 0:
      _id_0732::main();
      break;
    case 1:
      _id_072F::main();
      break;
    case 2:
      _id_0731::main();
      break;
    case 3:
      _id_0730::main();
      break;
    case 4:
      _id_070D::main();
      break;
    case 5:
      _id_070A::main();
      break;
    case 6:
      _id_070B::main();
      break;
    case 7:
      _id_070C::main();
      break;
    case 8:
      _id_072E::main();
      break;
    case 9:
      _id_072A::main();
      break;
    case 10:
      _id_072B::main();
      break;
    case 11:
      _id_072C::main();
      break;
    case 12:
      _id_072D::main();
      break;
    case 13:
      _id_0721::main();
      break;
    case 14:
      _id_0723::main();
      break;
    case 15:
      _id_0720::main();
      break;
    case 16:
      _id_0722::main();
      break;
    case 17:
      _id_0727::main();
      break;
    case 18:
      _id_0725::main();
      break;
    case 19:
      _id_0728::main();
      break;
    case 20:
      _id_0724::main();
      break;
    case 21:
      _id_0726::main();
      break;
    case 22:
      _id_0729::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_0732::precache();
  _id_072F::precache();
  _id_0731::precache();
  _id_0730::precache();
  _id_070D::precache();
  _id_070A::precache();
  _id_070B::precache();
  _id_070C::precache();
  _id_072E::precache();
  _id_072A::precache();
  _id_072B::precache();
  _id_072C::precache();
  _id_072D::precache();
  _id_0721::precache();
  _id_0723::precache();
  _id_0720::precache();
  _id_0722::precache();
  _id_0727::precache();
  _id_0725::precache();
  _id_0728::precache();
  _id_0724::precache();
  _id_0726::precache();
  _id_0729::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}