/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_airport_a.gsc
********************************************************/

main() {
  self setModel("body_airport_com_c");
  self attach("head_airport_a", "", true);
  self.headModel = "head_airport_a";
  self.voice = "seal";
}

precache() {
  precacheModel("body_airport_com_c");
  precacheModel("head_airport_a");
}