/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\civilian_miner_female_ar.gsc
***********************************************/

main() {
  self._id_17DB = "";
  self.team = "allies";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "noboost";
  self.accuracy = 0.5;
  self.health = 100;
  self.grenadeweapon = "";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self._id_101B4 = _id_0A2F::_id_7BEC("pistol");
  self.behaviortreeasset = "enemy_combatant";
  self._id_1FA9 = "soldier";

  if(isai(self)) {
    self _meth_82DC(256.0, 0.0);
    self _meth_82DB(768.0, 1024.0);
  }

  self.weapon = _id_0A2F::_id_7BEC("rifle");
  _id_049A::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_049A::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
}