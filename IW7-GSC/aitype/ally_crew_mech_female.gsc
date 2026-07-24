/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_crew_mech_female.gsc
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
  var_1 = ["character_un_crew_mech_female_bc_02_hero_xo_cap", "character_un_crew_mech_female_bc_02_comms_officer_cap", "character_un_crew_mech_female_bc_02_female_14_cap", "character_un_crew_mech_female_bc_02_female_05_cap", "character_un_crew_mech_comms_officer_female_bc_02", "character_un_crew_mech_comms_officer_female_04", "character_un_crew_mech_comms_officer_female_05", "character_un_crew_mech_comms_officer_female_11", "character_un_crew_mech_female_14_hero_xo", "character_un_crew_mech_female_14", "character_un_crew_mech_female_14_female_04", "character_un_crew_mech_female_14_female_05", "character_un_crew_mech_female_14_female_11", "character_un_crew_mech_female_04_comms_officer", "character_un_crew_mech_female_04_female_14", "character_un_crew_mech_female_04", "character_un_crew_mech_female_04_female_05", "character_un_crew_mech_female_05_female_bc_02", "character_un_crew_mech_female_05_comms_officer", "character_un_crew_mech_female_05_female_marine", "character_un_crew_mech_female_05", "character_un_crew_mech_female_05_female_11", "character_un_crew_mech_female_11"];

  switch (scripts\code\character::get_random_character(23, var_0, var_1)) {
    case 0:
      _id_0595::main();
      break;
    case 1:
      _id_0592::main();
      break;
    case 2:
      _id_0594::main();
      break;
    case 3:
      _id_0593::main();
      break;
    case 4:
      _id_0573::main();
      break;
    case 5:
      _id_0570::main();
      break;
    case 6:
      _id_0571::main();
      break;
    case 7:
      _id_0572::main();
      break;
    case 8:
      _id_0591::main();
      break;
    case 9:
      _id_058D::main();
      break;
    case 10:
      _id_058E::main();
      break;
    case 11:
      _id_058F::main();
      break;
    case 12:
      _id_0590::main();
      break;
    case 13:
      _id_0584::main();
      break;
    case 14:
      _id_0586::main();
      break;
    case 15:
      _id_0583::main();
      break;
    case 16:
      _id_0585::main();
      break;
    case 17:
      _id_058A::main();
      break;
    case 18:
      _id_0588::main();
      break;
    case 19:
      _id_058B::main();
      break;
    case 20:
      _id_0587::main();
      break;
    case 21:
      _id_0589::main();
      break;
    case 22:
      _id_058C::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_0595::precache();
  _id_0592::precache();
  _id_0594::precache();
  _id_0593::precache();
  _id_0573::precache();
  _id_0570::precache();
  _id_0571::precache();
  _id_0572::precache();
  _id_0591::precache();
  _id_058D::precache();
  _id_058E::precache();
  _id_058F::precache();
  _id_0590::precache();
  _id_0584::precache();
  _id_0586::precache();
  _id_0583::precache();
  _id_0585::precache();
  _id_058A::precache();
  _id_0588::precache();
  _id_058B::precache();
  _id_0587::precache();
  _id_0589::precache();
  _id_058C::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}