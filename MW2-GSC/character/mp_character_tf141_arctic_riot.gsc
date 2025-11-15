/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_tf141_arctic_riot.gsc
********************************************************/

main() {
  self setModel("mp_body_riot_tf141_arctic");
  self attach("head_riot_tf141_arctic", "", true);
  self.headModel = "head_riot_tf141_arctic";
  self setViewmodel("viewhands_arctic");
  self.voice = "taskforce";
}

precache() {
  precacheModel("mp_body_riot_tf141_arctic");
  precacheModel("head_riot_tf141_arctic");
  precacheModel("viewhands_arctic");
}