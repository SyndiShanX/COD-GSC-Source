/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_c6_worker.gsc
**************************************/

main() {
  self._id_17DB = "ai\\c6_assets.csv";
  self.team = "axis";
  self.type = "human";
  self.unittype = "C6";
  self.subclass = "C6";
  self.accuracy = 0.2;
  self.health = 400;
  self.grenadeweapon = "frag";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self._id_101B4 = "";
  self.behaviortreeasset = "c6_worker";
  self._id_1FA9 = "c6_worker";

  if(isai(self)) {
    self _meth_82DC(250.0, 0.0);
    self _meth_82DB(600.0, 600.0);
  }

  self.weapon = "none";
  _id_03BC::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  _id_03BC::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::_id_3353();
  _id_03AA::_id_DEE8();
  _id_0C3C::_id_2371();
  precacheitem("frag");
}