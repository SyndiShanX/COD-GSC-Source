/**********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_tf141_arctic_sniper.gsc
**********************************************************/

main() {
  self setModel("mp_body_tf141_arctic_sniper");
  self attach("head_allies_tf141_arctic_sniper", "", true);
  self.headModel = "head_allies_tf141_arctic_sniper";
  self setViewmodel("viewhands_sniper_tf141_arctic");
  self.voice = "taskforce";
}

precache() {
  precacheModel("mp_body_tf141_arctic_sniper");
  precacheModel("head_allies_tf141_arctic_sniper");
  precacheModel("viewhands_sniper_tf141_arctic");
}