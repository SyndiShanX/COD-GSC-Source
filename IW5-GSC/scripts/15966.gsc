/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\15966.gsc
**************************************/

main() {
  self setModel("body_russian_president");
  self attach("head_russian_president", "", 1);
  self.headmodel = "head_russian_president";
  self.voice = "russian";
}

precache() {
  precachemodel("body_russian_president");
  precachemodel("head_russian_president");
}