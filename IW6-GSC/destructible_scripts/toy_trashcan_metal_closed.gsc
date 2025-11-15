/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: destructible_scripts\toy_trashcan_metal_closed.gsc
**************************************************************/

#include common_scripts\_destructible;
#using_animtree("destructibles");

main() {
  destructible_create("toy_trashcan_metal_closed", "tag_origin", 120, undefined, 32, "no_melee");
  destructible_fx("tag_fx", "fx/props/garbage_spew_des", true, "splash");
  destructible_fx("tag_fx", "fx/props/garbage_spew", true, damage_not("splash"));
  destructible_sound("exp_trashcan_sweet");
  destructible_explode(600, 651, 1, 1, 10, 20);
  destructible_state(undefined, "com_trashcan_metal_with_trash", undefined, undefined, undefined, undefined, undefined, false);

  destructible_part("tag_fx", "com_trashcan_metalLID", undefined, undefined, undefined, undefined, 1.0, 1.0);
}