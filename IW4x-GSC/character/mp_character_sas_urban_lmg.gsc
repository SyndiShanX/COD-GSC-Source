/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\mp_character_sas_urban_lmg.gsc
****************************************************/

main() {
  self setModel("mp_body_sas_urban_lmg");
  codescripts\character::attachhead("alias_sas_heads", xmodelalias\alias_sas_heads::main());
  self setviewmodel("viewhands_sas");
  self.voice = "british";
}

precache() {
  precachemodel("mp_body_sas_urban_lmg");
  codescripts\character::precachemodelarray(xmodelalias\alias_sas_heads::main());
  precachemodel("viewhands_sas");
}