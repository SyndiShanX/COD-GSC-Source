/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_c8.gsc
**************************************/

main() {
  self._id_17DB = "ai\\c8_assets.csv";
  self.team = "axis";
  self.type = "human";
  self.unittype = "C8";
  self.subclass = "C8";
  self.accuracy = 0.2;
  self.health = 3200;
  self.grenadeweapon = "c8_grenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "iw7_steeldragon_ai";
  self._id_101B4 = "";
  self.behaviortreeasset = "c8";
  self._id_1FA9 = "c8";

  if(isai(self)) {
    self _meth_82DC(256.0, 0.0);
    self _meth_82DB(768.0, 1024.0);
  }

  self.weapon = "iw7_mauler_c8";
  _id_04B1::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  _id_04B1::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::_id_341D();
  _id_03AB::_id_DEE8();
  _id_0C40::_id_2371();
  precacheitem("iw7_mauler_c8");
  precacheitem("iw7_steeldragon_ai");
  precacheitem("c8_grenade");
}