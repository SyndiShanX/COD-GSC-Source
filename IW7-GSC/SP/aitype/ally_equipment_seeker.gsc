/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_equipment_seeker.gsc
********************************************/

main() {
  self._id_17DB = "ai\\seeker_assets.csv";
  self.team = "allies";
  self.type = "human";
  self.unittype = "seeker";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 200;
  self.grenadeweapon = "";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self._id_101B4 = "";
  self.behaviortreeasset = "seeker";
  self._id_1FA9 = "seeker";

  if(isai(self)) {
    self _meth_82DC(50.0, 0.0);
    self _meth_82DB(50.0, 1024.0);
  }

  self.weapon = "none";
  _id_0920::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_0920::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::_id_F10A();
  _id_03B0::_id_DEE8();
  _id_0C54::_id_2371();
}