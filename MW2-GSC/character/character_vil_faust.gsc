/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_vil_faust.gsc
********************************************************/

main() {
  self setModel("body_vil_faust");
  self attach("head_vil_faust", "", true);
  self.headModel = "head_vil_faust";
  self.voice = "portuguese";
}

precache() {
  precacheModel("body_vil_faust");
  precacheModel("head_vil_faust");
}