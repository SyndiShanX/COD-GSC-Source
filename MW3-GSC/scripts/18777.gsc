/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\18777.gsc
**************************************/

main() {
  self setModel("body_seal_udt_smg");
  codescripts\character::attachhead("alias_seal_udt_heads", _id_041D::main());
  self.voice = "seal";
}

precache() {
  precachemodel("body_seal_udt_smg");
  codescripts\character::precachemodelarray(_id_041D::main());
}