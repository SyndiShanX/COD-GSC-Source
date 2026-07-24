/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\civilian_female_cheap.gsc
********************************************/

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
  var_1 = ["character_civ_female_ph_drone", "character_civ_female_ph_drone", "character_civ_female_ph_drone", "character_civ_female_ph_drone", "character_civ_female_ph_drone_medium", "character_civ_female_ph_drone_medium", "character_civ_female_ph_drone_dark"];

  switch (scripts\code\character::get_random_character(7, var_0, var_1)) {
    case 0:
      _id_03D9::main();
      break;
    case 1:
      _id_03D9::main();
      break;
    case 2:
      _id_03D9::main();
      break;
    case 3:
      _id_03D9::main();
      break;
    case 4:
      _id_03DB::main();
      break;
    case 5:
      _id_03DB::main();
      break;
    case 6:
      _id_03DA::main();
      break;
  }
}

spawner() {
  self setspawnerteam("neutral");
}

precache() {
  _id_03D9::precache();
  _id_03D9::precache();
  _id_03D9::precache();
  _id_03D9::precache();
  _id_03DB::precache();
  _id_03DB::precache();
  _id_03DA::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::_id_009B();
  aiasm\civilian_sp_MAYBE::_id_DEE8();
  _id_0C4A::_id_2371();
}