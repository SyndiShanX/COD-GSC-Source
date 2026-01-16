/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_zom_giant_robot_1.gsc
*********************************************/

main() {
  self setmodel("veh_t6_dlc_zm_robot_1");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("veh_t6_dlc_zm_robot_1");
}