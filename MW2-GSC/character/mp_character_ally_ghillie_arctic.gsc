/**********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_ally_ghillie_arctic.gsc
**********************************************************/

main() {
  self setModel("mp_body_ally_sniper_ghillie_arctic");
  self attach("head_allies_sniper_ghillie_arctic", "", true);
  self.headModel = "head_allies_sniper_ghillie_arctic";
  self setViewmodel("viewhands_ghillie_arctic");
  self.voice = "taskforce";
}

precache() {
  precacheModel("mp_body_ally_sniper_ghillie_arctic");
  precacheModel("head_allies_sniper_ghillie_arctic");
  precacheModel("viewhands_ghillie_arctic");
}