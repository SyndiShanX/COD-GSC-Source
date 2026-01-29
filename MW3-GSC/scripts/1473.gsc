/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1473.gsc
**************************************/

main() {
  self setModel("body_russian_military_smg_a_airborne");
  codescripts\character::attachhead("alias_so_regular_smg_heads", _id_05C0::main());
  self.voice = "russian";
}

precache() {
  precachemodel("body_russian_military_smg_a_airborne");
  codescripts\character::precachemodelarray(_id_05C0::main());
}