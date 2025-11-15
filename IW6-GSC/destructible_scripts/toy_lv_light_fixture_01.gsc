/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: destructible_scripts\toy_lv_light_fixture_01.gsc
************************************************************/

main() {
  if(common_scripts\utility::issp()) {
    common_scripts\_destructible::destructible_create("toy_lv_light_fixture_01", "tag_origin", 0);
    common_scripts\_destructible::destructible_function(maps\interactive_models\hanging_light_off::hanging_light_off);
    common_scripts\_destructible::destructible_state("tag_origin", undefined, 10);
    common_scripts\_destructible::destructible_fx("tag_fx", "props/lv_light_fixture_01_smash");
    common_scripts\_destructible::destructible_sound("dst_small_glass_wall_lights");
    common_scripts\_destructible::destructible_explode(0, 0, 1, 1, 0, 0);
    common_scripts\_destructible::destructible_state("tag_origin", "lv_light_fixture_01_d");
  } else {
    common_scripts\_destructible::destructible_create("toy_lv_light_fixture_01", "tag_origin", 10);
    common_scripts\_destructible::destructible_fx("tag_fx", "props/lv_light_fixture_01_smash");
    common_scripts\_destructible::destructible_sound("dst_small_glass_wall_lights");
    common_scripts\_destructible::destructible_explode(0, 0, 1, 1, 0, 0);
    common_scripts\_destructible::destructible_state("tag_origin", "lv_light_fixture_01_d");
  }
}