/*********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: destructible_scripts\toy_usa_gas_station_trash_bin_02.gsc
*********************************************************************/

main() {
  common_scripts\_destructible::destructible_create("toy_usa_gas_station_trash_bin_02", "tag_origin", 120, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_fx("tag_fx_high", "fx/props/garbage_spew_des", 1, "splash");
  common_scripts\_destructible::destructible_fx("tag_fx_high", "fx/props/garbage_spew", 1, common_scripts\_destructible::damage_not("splash"));
  common_scripts\_destructible::destructible_explode(600, 651, 1, 1, 10, 20);
  common_scripts\_destructible::destructible_state(undefined, "usa_gas_station_trash_bin_02_base", undefined, undefined, undefined, undefined, undefined, 0);
  common_scripts\_destructible::destructible_part("tag_fx_high", "usa_gas_station_trash_bin_02_lid", undefined, undefined, undefined, undefined, 1.0, 1.0);
}