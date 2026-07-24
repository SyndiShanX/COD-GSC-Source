/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_crew_ship_om_shotgun.gsc
*************************************************/

main() {
  self._id_17DB = "";
  self.team = "axis";
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

  self.weapon = _id_0A2F::_id_7BEC("spread");
  var_0 = [0.56, 0.6, 0.64, 0.68, 0.72, 0.76, 0.8, 0.84, 0.88, 0.92, 0.96, 1.0];
  var_1 = ["character_sdf_crew_ship", "character_sdf_crew_ship_kloos", "character_sdf_crew_ship_kloos_male_24", "character_sdf_crew_ship_male_17_kloos", "character_sdf_crew_ship_male_17_male_21", "character_sdf_crew_ship_male_17_male_24", "character_sdf_crew_ship_male_17_male_25", "character_sdf_crew_ship_male_21", "character_sdf_crew_ship_male_25_male_24", "character_sdf_crew_ship_male_25", "character_sdf_crew_ship_male_28_male_24", "character_sdf_crew_ship_male_28"];

  switch (scripts\code\character::get_random_character(12, var_0, var_1)) {
    case 0:
      _id_0515::main();
      break;
    case 1:
      _id_051F::main();
      break;
    case 2:
      _id_0520::main();
      break;
    case 3:
      _id_0521::main();
      break;
    case 4:
      _id_0522::main();
      break;
    case 5:
      _id_0523::main();
      break;
    case 6:
      _id_0524::main();
      break;
    case 7:
      _id_0525::main();
      break;
    case 8:
      _id_0527::main();
      break;
    case 9:
      _id_0526::main();
      break;
    case 10:
      _id_0529::main();
      break;
    case 11:
      _id_0528::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  _id_0515::precache();
  _id_051F::precache();
  _id_0520::precache();
  _id_0521::precache();
  _id_0522::precache();
  _id_0523::precache();
  _id_0524::precache();
  _id_0525::precache();
  _id_0527::precache();
  _id_0526::precache();
  _id_0529::precache();
  _id_0528::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}