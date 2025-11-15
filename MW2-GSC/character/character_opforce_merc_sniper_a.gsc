/*********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_opforce_merc_sniper_a.gsc
*********************************************************/

main() {
  self setModel("body_opforce_sniper_ghillie");
  self attach("head_opforce_sniper_ghillie", "", true);
  self.headModel = "head_opforce_sniper_ghillie";
  self.voice = "russian";
}

precache() {
  precacheModel("body_opforce_sniper_ghillie");
  precacheModel("head_opforce_sniper_ghillie");
}