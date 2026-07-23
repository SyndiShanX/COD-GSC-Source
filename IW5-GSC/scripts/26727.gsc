/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\26727.gsc
**************************************/

main() {
  self setModel("body_hero_sandman_seal_udt");
  codescripts\character::attachhead("alias_seal_udt_heads_dive", _id_6866::main());
  self.voice = "delta";
}

precache() {
  precachemodel("body_hero_sandman_seal_udt");
  codescripts\character::precachemodelarray(_id_6866::main());
}