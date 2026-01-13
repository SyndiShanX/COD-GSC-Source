/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: aitype\ally_pilot_reaper.gsc
*********************************************/

main() {
  self.var_17DB = "";
  self.team = "allies";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.objective_team = lib_0A2F::func_7BEB();
  self.objective_state = 1;
  self.secondaryweapon = "iw7_fhr+silencersmg+reflexsmg";
  self.var_101B4 = "";
  self.behaviortreeasset = "enemy_combatant";
  self.var_1FA9 = "soldier";
  if(isai(self)) {
    self _meth_82DC(256, 0);
    self _meth_82DB(768, 1024);
  }

  self.var_394 = "iw7_m4+silencer+thermalm4";
  lib_082D::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  lib_082D::precache();
  scripts\aitypes\bt_util::init();
  lib_09FD::soldier();
  lib_03AE::func_DEE8();
  lib_0C69::func_2371();
  precacheitem("iw7_m4+silencer+thermalm4");
  precacheitem("iw7_fhr+silencersmg+reflexsmg");
}