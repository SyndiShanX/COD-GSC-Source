/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_airborne_casual_a.gsc
********************************************************/

main() {
  self setModel("body_airborne_assault_a");
  self attach("head_airport_a", "", true);
  self.headModel = "head_airport_a";
  self.voice = "russian";
}

precache() {
  precacheModel("body_airborne_assault_a");
  precacheModel("head_airport_a");
}