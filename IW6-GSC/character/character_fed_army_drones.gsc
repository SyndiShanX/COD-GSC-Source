/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_fed_army_drones.gsc
***************************************************/

main() {
  self setModel("body_fed_army_assault_a_drone");
  self attach("head_fed_army_a_drone", "", 1);
  self.headmodel = "head_fed_army_a_drone";
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_fed_army_assault_a_drone");
  precachemodel("head_fed_army_a_drone");
}