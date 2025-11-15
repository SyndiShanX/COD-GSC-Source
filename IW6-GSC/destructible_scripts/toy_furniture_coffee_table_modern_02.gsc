/*************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: destructible_scripts\toy_furniture_coffee_table_modern_02.gsc
*************************************************************************/

main() {
  common_scripts\_destructible::destructible_create("toy_furniture_coffee_table_modern_02", "tag_origin", 50, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_fx("tag_fx", "fx/props/furniture_coffee_table_modern_02", 1, undefined);
  common_scripts\_destructible::destructible_explode(600, 1651, 60, 60, 10, 20, undefined, 10);
  common_scripts\_destructible::destructible_state(undefined, "furniture_coffee_table_modern_02_dest", undefined, undefined, undefined, undefined, undefined, 0);
}