/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\13545.gsc
**************************************/

main() {
  self setModel("russian_presidents_daughter_body_dirty");
  self attach("russian_presidents_daughter_head_dirty", "", 1);
  self.headmodel = "russian_presidents_daughter_head_dirty";
  self.voice = "russian";
}

precache() {
  precachemodel("russian_presidents_daughter_body_dirty");
  precachemodel("russian_presidents_daughter_head_dirty");
}