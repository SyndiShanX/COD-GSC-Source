/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\loki_precache.gsc
*****************************************************/

main() {
  common_scripts\utility::add_destructible_type_function("electrical_transformer_large", destructible_scripts\electrical_transformer_large::main);
  common_scripts\utility::add_destructible_type_function("toy_sp_panel_box", destructible_scripts\toy_sp_panel_box::main);
  common_scripts\utility::add_destructible_type_function("toy_transformer_small01", destructible_scripts\toy_transformer_small01::main);
  vehicle_scripts\hind::main("vehicle_battle_hind_low", "hind_battle", "script_vehicle_hind_battle_low");
  vehicle_scripts\_mig29::main("vehicle_mig29_low", undefined, "script_vehicle_mig29_low_cheap");
}