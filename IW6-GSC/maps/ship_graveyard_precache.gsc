/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ship_graveyard_precache.gsc
********************************************/

main() {
  maps\interactive_models\fish_bannerfish::main();
  maps\interactive_models\fish_school_sardines::main();
  maps\interactive_models\fish_school_snapper::main();
  vehicle_scripts\_lcs::main("vehicle_lcs", undefined, "script_vehicle_lcs");
  vehicle_scripts\_hind::main("vehicle_mi24p_hind_woodland", undefined, "script_vehicle_mi24p_hind_woodland");
  vehicle_scripts\_missile_boat::main("vehicle_boat_underneath_2", undefined, "script_vehicle_missile_boat_under");
  vehicle_scripts\_submarine_sdv::main("vehicle_mini_sub_iw6", undefined, "script_vehicle_submarine_minisub");
  vehicle_scripts\_zodiac::main("vehicle_boat_underneath_1", undefined, "script_vehicle_zodiac_underneath");
}