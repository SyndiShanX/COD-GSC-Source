/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\22676.gsc
**************************************/

main() {
  self setModel("body_fso_vest_b");
  codescripts\character::attachhead("alias_fso_heads", _id_5890::main());
  self.voice = "russian";
}

precache() {
  precachemodel("body_fso_vest_b");
  codescripts\character::precachemodelarray(_id_5890::main());
}