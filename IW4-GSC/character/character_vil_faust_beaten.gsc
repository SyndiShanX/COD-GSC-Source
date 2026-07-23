/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_vil_faust_beaten.gsc
********************************************************/

main() {
  self setModel("body_vil_faust_beaten");
  self attach("head_vil_faust_beaten", "", true);
  self.headModel = "head_vil_faust_beaten";
  self.voice = "portuguese";
}

precache() {
  precacheModel("body_vil_faust_beaten");
  precacheModel("head_vil_faust_beaten");
}