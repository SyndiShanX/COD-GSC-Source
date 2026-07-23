/************************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_secret_service_assault_a.gsc
************************************************************/

main() {
  self setModel("body_secret_service_assault_a");
  codescripts\character::attachHead("alias_secret_service_heads_blazer", xmodelalias\alias_secret_service_heads_blazer::main());
  self.voice = "russian";
}

precache() {
  precacheModel("body_secret_service_assault_a");
  codescripts\character::precacheModelArray(xmodelalias\alias_secret_service_heads_blazer::main());
}