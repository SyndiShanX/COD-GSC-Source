/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_c12.gsc
**************************************/

main() {
  self._id_17DB = "ai\\c12_assets.csv";
  self.team = "allies";
  self.type = "human";
  self.unittype = "C12";
  self.subclass = "C12";
  self.accuracy = 0.2;
  self.health = 5000;
  self.grenadeweapon = "";
  self.grenadeammo = 0;
  self.secondaryweapon = "iw7_c12gatling";
  self._id_101B4 = "";
  self.behaviortreeasset = "c12";
  self._id_1FA9 = "C12";

  if(isai(self)) {
    self _meth_82DC(256.0, 0.0);
    self _meth_82DB(768.0, 1024.0);
  }

  self.weapon = "iw7_c12rocket";
  _id_03B6::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_03B6::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::_id_3508();
  _id_03AC::_id_DEE8();
  _id_0C48::_id_2371();
  precacheitem("iw7_c12rocket");
  precacheitem("iw7_c12gatling");
}