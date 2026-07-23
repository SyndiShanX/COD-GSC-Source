/*********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_seal_soccom_assault_c.gsc
*********************************************************/

main() {
  self setModel("body_seal_soccom_assault_c");
  codescripts\character::attachHead("alias_seal_soccom_heads", xmodelalias\alias_seal_soccom_heads::main());
  self.voice = "taskforce";
}

precache() {
  precacheModel("body_seal_soccom_assault_c");
  codescripts\character::precacheModelArray(xmodelalias\alias_seal_soccom_heads::main());
}