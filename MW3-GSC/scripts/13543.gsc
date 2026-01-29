/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\13543.gsc
**************************************/

main() {
  self setModel("body_london_female_c");
  codescripts\character::attachhead("alias_civilian_heads_female", _id_7943::main());
  self.voice = "british";
}

precache() {
  precachemodel("body_london_female_c");
  codescripts\character::precachemodelarray(_id_7943::main());
}