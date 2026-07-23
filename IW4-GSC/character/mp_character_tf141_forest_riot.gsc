/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_tf141_forest_riot.gsc
********************************************************/

main() {
  self setModel("mp_body_riot_tf141_forest");
  self attach("head_riot_tf141_forest", "", true);
  self.headModel = "head_riot_tf141_forest";
  self setViewmodel("viewhands_tf141");
  self.voice = "taskforce";
}

precache() {
  precacheModel("mp_body_riot_tf141_forest");
  precacheModel("head_riot_tf141_forest");
  precacheModel("viewhands_tf141");
}