/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 638.gsc
*********************************************/

lib_027E::func_00F9() {
  self setModel("mp_body_cloak_test");
  self attach("mp_head_cloak_test", "", 1);
  self.var_4BF2 = "mp_head_cloak_test";
  self setviewmodel("mp_viewhands_cloak_test");
  self.var_A600 = "american";
  self method_83E1("vestlight");
}

lib_027E::func_0136() {
  precachemodel("mp_body_cloak_test");
  precachemodel("mp_head_cloak_test");
  precachemodel("mp_viewhands_cloak_test");
}