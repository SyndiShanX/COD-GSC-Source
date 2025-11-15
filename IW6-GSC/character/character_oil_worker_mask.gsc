/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_oil_worker_mask.gsc
***************************************************/

main() {
  codescripts\character::setmodelfromarray(xmodelalias\alias_oil_worker_bodies::main());
  self attach("head_oil_worker_d", "", 1);
  self.headmodel = "head_oil_worker_d";
  self.voice = "russian";
  self setclothtype("nylon");
}

precache() {
  codescripts\character::precachemodelarray(xmodelalias\alias_oil_worker_bodies::main());
  precachemodel("head_oil_worker_d");
}