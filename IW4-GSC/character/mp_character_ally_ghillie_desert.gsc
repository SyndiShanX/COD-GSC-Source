/**********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_ally_ghillie_desert.gsc
**********************************************************/

main() {
  self setModel("mp_body_ally_sniper_ghillie_desert");
  self attach("head_allies_sniper_ghillie_desert", "", true);
  self.headModel = "head_allies_sniper_ghillie_desert";
  self setViewmodel("viewhands_ghillie_desert");
  self.voice = "taskforce";
}

precache() {
  precacheModel("mp_body_ally_sniper_ghillie_desert");
  precacheModel("head_allies_sniper_ghillie_desert");
  precacheModel("viewhands_ghillie_desert");
}