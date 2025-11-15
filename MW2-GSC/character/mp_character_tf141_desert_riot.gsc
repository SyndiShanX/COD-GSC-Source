/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_tf141_desert_riot.gsc
********************************************************/

main() {
  self setModel("mp_body_riot_tf141_desert");
  self attach("head_riot_tf141_desert", "", true);
  self.headModel = "head_riot_tf141_desert";
  self setViewmodel("viewhands_tf141");
  self.voice = "taskforce";
}

precache() {
  precacheModel("mp_body_riot_tf141_desert");
  precacheModel("head_riot_tf141_desert");
  precacheModel("viewhands_tf141");
}