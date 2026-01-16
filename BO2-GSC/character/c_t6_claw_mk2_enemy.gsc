/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_t6_claw_mk2_enemy.gsc
*********************************************/

main() {
  self setmodel("veh_t6_drone_claw_mk2_alt");
  self.headmodel = "veh_t6_drone_claw_mk2_turret";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("veh_t6_drone_claw_mk2_alt");
  precachemodel("veh_t6_drone_claw_mk2_turret");
}