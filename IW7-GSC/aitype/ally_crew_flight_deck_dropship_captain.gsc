/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_crew_flight_deck_dropship_captain.gsc
*************************************************************/

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
  var_0 = [0.25, 0.75, 1.0];
  var_1 = ["character_un_crew_flight_deck_dropship_captain", "character_un_crew_flight_deck_dropship_captain_female", "character_un_crew_flight_deck_dropship_captain_pt2"];

  switch (scripts\code\character::get_random_character(3, var_0, var_1)) {
    case 0:
      _id_053F::main();
      break;
    case 1:
      _id_0540::main();
      break;
    case 2:
      _id_0542::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_053F::precache();
  _id_0540::precache();
  _id_0542::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}