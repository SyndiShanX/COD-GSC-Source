/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_c6_shotgun.gsc
***************************************/

main() {
  self._id_17DB = "ai\\c6_assets.csv";
  self.team = "axis";
  self.type = "human";
  self.unittype = "C6";
  self.subclass = "C6";
  self.accuracy = 0.2;
  self.health = 400;
  self.grenadeweapon = _id_0A2F::_id_7BEB();
  self.grenadeammo = 1;
  self.secondaryweapon = "";
  self._id_101B4 = _id_0A2F::_id_7BEC("pistol");
  self.behaviortreeasset = "c6";
  self._id_1FA9 = "c6";

  if(isai(self)) {
    self _meth_82DC(250.0, 0.0);
    self _meth_82DB(600.0, 600.0);
  }

  self.weapon = _id_0A2F::_id_7BEC("spread");
  _id_03B7::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  _id_03B7::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::_id_3353();
  _id_03A8::_id_DEE8();
  _id_0C32::_id_2371();
}