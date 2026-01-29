/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\13534.gsc
**************************************/

main() {
  self setModel("russian_presidents_daughter_body");
  self attach("russian_presidents_daughter_head", "", 1);
  self.headmodel = "russian_presidents_daughter_head";
  self.voice = "russian";
}

precache() {
  precachemodel("russian_presidents_daughter_body");
  precachemodel("russian_presidents_daughter_head");
}