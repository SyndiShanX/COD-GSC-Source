/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_zom_moon_pressure_suit_zombie.gsc
*********************************************************/

main() {
  self setModel("c_zom_moon_pressure_suit_body_zombie");
  self.headModel = "c_zom_moon_pressure_suit_helm";
  self attach(self.headModel, "", true);
  self.voice = "german";
  self.skeleton = "base";
}

precache() {
  precacheModel("c_zom_moon_pressure_suit_body_zombie");
  precacheModel("c_zom_moon_pressure_suit_helm");
}