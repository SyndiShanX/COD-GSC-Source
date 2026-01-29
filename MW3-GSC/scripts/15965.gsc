/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\15965.gsc
**************************************/

main() {
  self setModel("body_russian_president_dirty");
  self attach("head_russian_president_dirty", "", 1);
  self.headmodel = "head_russian_president_dirty";
  self.voice = "russian";
}

precache() {
  precachemodel("body_russian_president_dirty");
  precachemodel("head_russian_president_dirty");
}