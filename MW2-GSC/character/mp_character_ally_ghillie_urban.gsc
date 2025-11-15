/*********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_ally_ghillie_urban.gsc
*********************************************************/

main() {
  self setModel("mp_body_ally_sniper_ghillie_urban");
  self attach("head_allies_sniper_ghillie_urban", "", true);
  self.headModel = "head_allies_sniper_ghillie_urban";
  self setViewmodel("viewhands_ghillie_urban");
  self.voice = "seal";
}

precache() {
  precacheModel("mp_body_ally_sniper_ghillie_urban");
  precacheModel("head_allies_sniper_ghillie_urban");
  precacheModel("viewhands_ghillie_urban");
}