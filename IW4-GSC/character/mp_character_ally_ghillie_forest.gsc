/**********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_ally_ghillie_forest.gsc
**********************************************************/

main() {
  self setModel("mp_body_ally_sniper_ghillie_forest");
  self attach("head_allies_sniper_ghillie_forest", "", true);
  self.headModel = "head_allies_sniper_ghillie_forest";
  self setViewmodel("viewhands_ghillie_forest");
  self.voice = "taskforce";
}

precache() {
  precacheModel("mp_body_ally_sniper_ghillie_forest");
  precacheModel("head_allies_sniper_ghillie_forest");
  precacheModel("viewhands_ghillie_forest");
}