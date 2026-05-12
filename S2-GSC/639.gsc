/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 639.gsc
*********************************************/

lib_027F::func_00F9() {
  self setModel("mp_sentinel_body_nojet_b");
  lib_0281::func_114A("alias_mp_sentinel_heads", lib_03D7::func_00F9());
  self setviewmodel("viewhands_s1_pmc");
  self.var_A600 = "american";
  self method_83E1("vestlight");
}

lib_027F::func_0136() {
  precachemodel("mp_sentinel_body_nojet_b");
  lib_0281::func_7653(lib_03D7::func_00F9());
  precachemodel("viewhands_s1_pmc");
}