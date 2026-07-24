/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_pilot_sipes.gsc
***************************************/

main() {
  self._id_17DB = "";
  self.team = "allies";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = _id_0A2F::_id_7BEB();
  self.grenadeammo = 1;
  self.secondaryweapon = "iw7_fhr+reflexsmg+silencersmg";
  self._id_101B4 = "";
  self.behaviortreeasset = "enemy_combatant";
  self._id_1FA9 = "soldier";

  if(isai(self)) {
    self _meth_82DC(256.0, 0.0);
    self _meth_82DB(768.0, 1024.0);
  }

  self.weapon = "iw7_fhr+reflexsmg+silencersmg";
  _id_082E::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_082E::precache();
  scripts\aitypes\bt_util::init();
  _id_09FD::soldier();
  _id_03AE::_id_DEE8();
  _id_0C69::_id_2371();
  precacheitem("iw7_fhr+reflexsmg+silencersmg");
  precacheitem("iw7_fhr+reflexsmg+silencersmg");
}