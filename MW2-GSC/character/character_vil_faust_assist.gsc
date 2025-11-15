/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_vil_faust_assist.gsc
********************************************************/

main() {
  self setModel("body_vil_faust_assist");
  self attach("head_vil_faust_assist", "", true);
  self.headModel = "head_vil_faust_assist";
  self.voice = "portuguese";
}

precache() {
  precacheModel("body_vil_faust_assist");
  precacheModel("head_vil_faust_assist");
}