/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_vil_makarov.gsc
********************************************************/

main() {
  self setModel("body_airport_com_a");
  self attach("head_vil_makarov", "", true);
  self.headModel = "head_vil_makarov";
  self.voice = "seal";
}

precache() {
  precacheModel("body_airport_com_a");
  precacheModel("head_vil_makarov");
}