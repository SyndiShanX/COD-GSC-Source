/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\18776.gsc
**************************************/

main() {
  self setModel("body_seal_udt_assault_a");
  codescripts\character::attachhead("alias_seal_udt_heads", _id_041D::main());
  self.voice = "seal";
}

precache() {
  precachemodel("body_seal_udt_assault_a");
  codescripts\character::precachemodelarray(_id_041D::main());
}