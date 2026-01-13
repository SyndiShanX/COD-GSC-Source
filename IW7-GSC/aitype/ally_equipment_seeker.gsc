/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: aitype\ally_equipment_seeker.gsc
*********************************************/

main() {
  self.var_17DB = "ai\\seeker_assets.csv";
  self.team = "allies";
  self.type = "human";
  self.unittype = "seeker";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 200;
  self.objective_team = "";
  self.objective_state = 0;
  self.secondaryweapon = "";
  self.var_101B4 = "";
  self.behaviortreeasset = "seeker";
  self.var_1FA9 = "seeker";
  if(isai(self)) {
    self func_82DC(50, 0);
    self func_82DB(50, 1024);
  }

  self.var_394 = "none";
  lib_0920::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  lib_0920::precache();
  scripts\aitypes\bt_util::init();
  lib_09FD::func_F10A();
  lib_03B0::func_DEE8();
  lib_0C54::func_2371();
}