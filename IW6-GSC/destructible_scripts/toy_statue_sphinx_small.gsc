/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: destructible_scripts\toy_statue_sphinx_small.gsc
************************************************************/

main() {
  common_scripts\_destructible::destructible_create("toy_statue_sphinx_small", "tag_origin", 1000, undefined, undefined, "splash");
  sphinx_part_setup("beard");
  sphinx_part_setup("forehead");
  sphinx_part_setup("head_l");
  sphinx_part_setup("leg_fl");
  sphinx_part_setup("leg_fr");
  sphinx_part_setup("leg_rl");
  sphinx_part_setup("leg_rr");
}

sphinx_part_setup(var_0) {
  common_scripts\_destructible::destructible_part("tag_" + var_0, "statue_sphinx_small_dest_" + var_0 + "_dust", 30);
  common_scripts\_destructible::destructible_physics("tag_" + var_0, (20, 0, 0));
  common_scripts\_destructible::destructible_fx("tag_" + var_0, "fx/props/statue_sphinx_small_impact");
  common_scripts\_destructible::destructible_sound("dst_sphinx_statue");
  common_scripts\_destructible::destructible_state();
}