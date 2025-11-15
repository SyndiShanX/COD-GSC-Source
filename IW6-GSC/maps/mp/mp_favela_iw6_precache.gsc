/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_favela_iw6_precache.gsc
**********************************************/

main() {
  common_scripts\utility::add_destructible_type_function("toy_chicken", destructible_scripts\toy_chicken::main);
  common_scripts\utility::add_destructible_type_function("toy_chicken_black_white", destructible_scripts\toy_chicken_black_white::main);
  common_scripts\utility::add_destructible_type_function("vehicle_small_hatch_blue", destructible_scripts\vehicle_small_hatch_blue::main);
  common_scripts\utility::add_destructible_type_function("vehicle_small_hatch_white", destructible_scripts\vehicle_small_hatch_white::main);
  maps\animated_models\hanging_apron_wind_medium::main();
  maps\animated_models\hanging_longsleeve_wind_medium::main();
  maps\animated_models\hanging_sheet_wind_medium::main();
  maps\animated_models\hanging_shortsleeve_wind_medium::main();
}