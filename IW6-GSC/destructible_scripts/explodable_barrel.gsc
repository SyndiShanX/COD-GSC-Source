/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: destructible_scripts\explodable_barrel.gsc
******************************************************/

main() {
  common_scripts\_destructible::destructible_create("explodable_barrel", "tag_origin", 55);
  common_scripts\_destructible::destructible_state("tag_origin", undefined, 44, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_fx("TAG_TOP", "fx/props/barrel_ignite", 1);
  common_scripts\_destructible::destructible_loopfx("TAG_TOP", "fx/props/barrel_fire_top", 0.4);
  common_scripts\_destructible::destructible_healthdrain(15, 0.05, 128);
  common_scripts\_destructible::destructible_state("tag_origin", undefined, 100, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_fx("tag_origin", "fx/props/barrelExp", 0);
  common_scripts\_destructible::destructible_sound("barrel_mtl_explode");
  common_scripts\_destructible::destructible_explode(4000, 5000, 210, 250, 50, 300, undefined, undefined, 0.3, 500);
  common_scripts\_destructible::destructible_state(undefined, "com_barrel_piece2_1");
}