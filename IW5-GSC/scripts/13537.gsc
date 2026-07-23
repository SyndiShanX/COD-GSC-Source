/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\13537.gsc
**************************************/

main() {
  self setModel("body_fso_vest_b_dirty");
  codescripts\character::attachhead("alias_fso_heads_dirty", _id_34DF::main());
  self.voice = "russian";
}

precache() {
  precachemodel("body_fso_vest_b_dirty");
  codescripts\character::precachemodelarray(_id_34DF::main());
}