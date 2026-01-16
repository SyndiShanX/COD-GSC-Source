/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_lapd_rigid_drone1.gsc
*************************************************/

main() {
  self setmodel("c_usa_lapd_rigid_drone_fb");
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_lapd_rigid_drone_fb");
}