/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_oil_worker.gsc
**********************************************/

main() {
  codescripts\character::setmodelfromarray(xmodelalias\alias_oil_worker_bodies::main());
  codescripts\character::attachhead("alias_oil_worker_heads", xmodelalias\alias_oil_worker_heads::main());
  self.voice = "russian";
  self setclothtype("nylon");
}

precache() {
  codescripts\character::precachemodelarray(xmodelalias\alias_oil_worker_bodies::main());
  codescripts\character::precachemodelarray(xmodelalias\alias_oil_worker_heads::main());
}