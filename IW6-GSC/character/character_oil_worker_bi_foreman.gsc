/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_oil_worker_bi_foreman.gsc
*********************************************************/

main() {
  codescripts\character::setmodelfromarray(xmodelalias\alias_oil_worker_bodies::main());
  self attach("head_fed_basic_a", "", 1);
  self.headmodel = "head_fed_basic_a";
  self.voice = "russian";
  self setclothtype("nylon");
}

precache() {
  codescripts\character::precachemodelarray(xmodelalias\alias_oil_worker_bodies::main());
  precachemodel("head_fed_basic_a");
}