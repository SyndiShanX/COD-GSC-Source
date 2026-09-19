/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\638.gsc
**************************************/

main() {
  self setModel("mp_body_cloak_test");
  self attach("mp_head_cloak_test", "", 1);
  self.headmodel = "mp_head_cloak_test";
  self _meth_8348("mp_viewhands_cloak_test");
  self._id_A600 = "american";
  self _meth_83E1("vestlight");
}

precache() {
  precachemodel("mp_body_cloak_test");
  precachemodel("mp_head_cloak_test");
  precachemodel("mp_viewhands_cloak_test");
}