/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\26725.gsc
**************************************/

main() {
  self setModel("body_russian_naval_captain_a");
  self attach("head_russian_naval_captain_a", "", 1);
  self.headmodel = "head_russian_naval_captain_a";
  self.voice = "russian";
}

precache() {
  precachemodel("body_russian_naval_captain_a");
  precachemodel("head_russian_naval_captain_a");
}