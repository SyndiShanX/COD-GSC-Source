/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_airport_b.gsc
********************************************************/

main() {
  self setModel("body_airport_com_b");
  self attach("head_airport_d", "", true);
  self.headModel = "head_airport_d";
  self.voice = "seal";
}

precache() {
  precacheModel("body_airport_com_b");
  precacheModel("head_airport_d");
}