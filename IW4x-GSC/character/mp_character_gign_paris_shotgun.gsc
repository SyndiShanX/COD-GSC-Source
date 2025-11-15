/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\mp_character_gign_paris_shotgun.gsc
*********************************************************/

main() {
  self setModel("mp_body_gign_paris_shotgun");
  self attach("head_gign_b", "", 1);
  self.headmodel = "head_gign_b";
  self setviewmodel("viewhands_sas");
  self.voice = "french";
}

precache() {
  precachemodel("mp_body_gign_paris_shotgun");
  precachemodel("head_gign_b");
  precachemodel("viewhands_sas");
}