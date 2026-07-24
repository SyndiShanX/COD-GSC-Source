/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_hero_eth3n_zerog_space.gsc
**************************************************/

main() {
  self._id_17DB = "ai\\human_assets.csv";
  self.team = "allies";
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
  self._id_1FA9 = "zero_gravity_space";

  if(isai(self)) {
    self _meth_82DC(256.0, 0.0);
    self _meth_82DB(768.0, 1024.0);
  }

  self.weapon = _id_0A2F::_id_7BEC("rifle");
  _id_08EC::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_08EC::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C70::_id_2371();
}