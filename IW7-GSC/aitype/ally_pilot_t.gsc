/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: aitype\ally_pilot_t.gsc
*********************************************/

main() {
  self.var_17DB = "";
  self.team = "allies";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = lib_0A2F::func_7BEB();
  self.objective_state = 1;
  self.secondaryweapon = "iw7_fhr+reflexsmg+silencersmg";
  self.var_101B4 = "";
  self.behaviortreeasset = "enemy_combatant";
  self.var_1FA9 = "soldier";
  if(isai(self)) {
    self func_82DC(256, 0);
    self func_82DB(768, 1024);
  }

  self.weapon = "iw7_fhr+reflexsmg+silencersmg";
  lib_082F::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  lib_082F::precache();
  scripts\aitypes\bt_util::init();
  lib_09FD::soldier();
  lib_03AE::func_DEE8();
  lib_0C69::func_2371();
  precacheitem("iw7_fhr+reflexsmg+silencersmg");
  precacheitem("iw7_fhr+reflexsmg+silencersmg");
}