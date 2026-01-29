/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1476.gsc
**************************************/

main() {
  self setModel("body_russian_military_assault_a_black");
  codescripts\character::attachhead("alias_so_veteran_ar_heads", _id_05C3::main());
  self.voice = "russian";
}

precache() {
  precachemodel("body_russian_military_assault_a_black");
  codescripts\character::precachemodelarray(_id_05C3::main());
}