/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_vil_shepherd.gsc
********************************************************/

main() {
  self setModel("body_vil_shepherd");
  self attach("head_vil_shepherd", "", true);
  self.headModel = "head_vil_shepherd";
  self.voice = "american";
}

precache() {
  precacheModel("body_vil_shepherd");
  precacheModel("head_vil_shepherd");
}