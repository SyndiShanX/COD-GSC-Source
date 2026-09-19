/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\639.gsc
**************************************/

main() {
  self setModel("mp_sentinel_body_nojet_b");
  codescripts\character::attachhead("alias_mp_sentinel_heads", _id_03D7::main());
  self _meth_8348("viewhands_s1_pmc");
  self._id_A600 = "american";
  self _meth_83E1("vestlight");
}

precache() {
  precachemodel("mp_sentinel_body_nojet_b");
  codescripts\character::precachemodelarray(_id_03D7::main());
  precachemodel("viewhands_s1_pmc");
}