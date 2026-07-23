/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_airport_c.gsc
********************************************************/

main() {
  self setModel("body_airport_com_d");
  self attach("head_airport_b", "", true);
  self.headModel = "head_airport_b";
  self.voice = "seal";
}

precache() {
  precacheModel("body_airport_com_d");
  precacheModel("head_airport_b");
}