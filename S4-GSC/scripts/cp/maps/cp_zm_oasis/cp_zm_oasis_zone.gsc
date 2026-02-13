/************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_zone.gsc
************************************************************/

init() {
  scripts\cp\zone_manager::init_zone_manager();
  level thread scripts\cp\zone_manager::manage_zones();
  scripts\cp\zone_manager::zone_init("zone_temple");
  scripts\cp\zone_manager::set_zone_enabled("zone_temple", 1);
  scripts\cp\zone_manager::zone_init("zone_dark_aehter");
  scripts\cp\zone_manager::set_zone_enabled("zone_dark_aehter", 1);
  scripts\cp\zone_manager::zone_init("teleport_room");
  scripts\cp\zone_manager::set_zone_enabled("teleport_room", 1);
  scripts\cp\zone_manager::add_adjacent_zone("zone_temple", "zone_temple_east", "always_on");
  scripts\cp\zone_manager::add_adjacent_zone("zone_temple", "zone_temple_west", "always_on");
  scripts\cp\zone_manager::add_adjacent_zone("zone_temple_west", "zone_temple_east", "always_on");
  scripts\cp\zone_manager::add_adjacent_zone("zone_temple_east", "zone_east_spring_west", "door_oasis_temple_to_east_spring_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_temple_east", "zone_east_spring", "door_oasis_temple_to_east_spring_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_temple_west", "zone_west_spring_east", "door_oasis_temple_to_west_spring_east_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_temple", "zone_west_spring", "door_oasis_temple_to_west_spring_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_pap", "zone_temple_east", "always_on");
  scripts\cp\zone_manager::add_adjacent_zone("zone_pap", "zone_temple_west", "always_on");
  scripts\cp\zone_manager::add_adjacent_zone("zone_pap", "zone_east_spring_west", "door_oasis_pap_to_east_spring_west_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_pap", "zone_west_spring_east", "door_oasis_pap_to_west_spring_east_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_east_spring_west", "zone_east_spring", "connect_zone_east_spring");
  scripts\cp\zone_manager::add_adjacent_zone("zone_east_spring_east", "zone_east_spring", "connect_zone_east_spring");
  scripts\cp\zone_manager::add_adjacent_zone("zone_tent_west", "zone_east_spring", "door_oasis_east_spring_to_tent_west_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_tent_east", "zone_east_spring_east", "door_oasis_east_spring_east_to_tent_east_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_east_spring_west", "zone_east_ruins_west_south", "door_oasis_east_spring_to_east_ruins_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_east_spring_west", "zone_east_ruins_west_north", "door_oasis_east_spring_to_east_ruins_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_east_spring", "zone_east_ruins_north", "door_oasis_east_spring_to_east_ruins_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_east_spring_east", "zone_east_ruins_east_north", "door_oasis_east_spring_to_east_ruins_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_east_spring_west", "zone_merchant_road", "power_on");
  scripts\cp\zone_manager::add_adjacent_zone("zone_tent_west", "zone_tent_east", "enable_zone_tent");
  scripts\cp\zone_manager::add_adjacent_zone("zone_east_ruins_west_south", "zone_east_ruins_west_north", "connect_zone_east_ruins");
  scripts\cp\zone_manager::add_adjacent_zone("zone_east_ruins_west_south", "zone_east_ruins_south", "connect_zone_east_ruins");
  scripts\cp\zone_manager::add_adjacent_zone("zone_east_ruins_west_north", "zone_east_ruins_north", "connect_zone_east_ruins");
  scripts\cp\zone_manager::add_adjacent_zone("zone_east_ruins_south", "zone_east_ruins_north", "connect_zone_east_ruins");
  scripts\cp\zone_manager::add_adjacent_zone("zone_east_ruins_south", "zone_east_ruins_east_south", "connect_zone_east_ruins");
  scripts\cp\zone_manager::add_adjacent_zone("zone_east_ruins_north", "zone_east_ruins_east_north", "connect_zone_east_ruins");
  scripts\cp\zone_manager::add_adjacent_zone("zone_east_ruins_east_south", "zone_east_ruins_east_north", "connect_zone_east_ruins");
  scripts\cp\zone_manager::add_adjacent_zone("zone_east_ruins_south", "zone_merchant_road_east", "door_east_ruins_to_merchant_road_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_east_ruins_west_south", "zone_merchant_road_east", "door_east_ruins_to_merchant_road_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_merchant_road_east", "zone_merchant_road", "connect_merchant_road");
  scripts\cp\zone_manager::add_adjacent_zone("zone_merchant_road_west", "zone_merchant_road_south", "connect_merchant_road");
  scripts\cp\zone_manager::add_adjacent_zone("zone_merchant_road", "zone_merchant_road_west", "connect_merchant_road");
  scripts\cp\zone_manager::add_adjacent_zone("zone_merchant_road_east", "zone_crash_site_east_north", "door_merchant_road_east_to_crash_site_east_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_merchant_road_south", "zone_crash_site_west", "door_crash_site_west_to_merchant_road_south_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_merchant_road_west", "zone_west_ruins_south", "door_merchant_road_west_to_west_ruins_south_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_merchant_road_west", "zone_west_spring_east", "power_on");
  scripts\cp\zone_manager::add_adjacent_zone("zone_crash_site_east_south", "zone_crash_site_east_north", "door_merchant_road_east_to_crash_site_east_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_crash_site_east_south", "zone_crash_site_east_north", "door_crash_site_to_crash_site_east_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_crash_site_east_south", "zone_crash_site", "door_crash_site_to_crash_site_east_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_crash_site_west", "zone_crash_site", "door_crash_site_to_crash_site_east_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_crash_site_west", "zone_crash_site", "door_crash_site_west_to_merchant_road_south_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_west_spring_east", "zone_west_spring", "connect_zone_west_spring");
  scripts\cp\zone_manager::add_adjacent_zone("zone_west_spring_west", "zone_west_spring", "connect_zone_west_spring");
  scripts\cp\zone_manager::add_adjacent_zone("zone_west_spring_east", "zone_west_ruins_east", "door_oasis_west_spring_east_to_west_ruins_east_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_west_spring_west", "zone_west_ruins", "door_west_ruins_to_west_spring_west_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_west_ruins_east", "zone_west_ruins", "door_west_ruins_east_to_west_ruins_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_west_ruins_south", "zone_west_ruins", "connect_zone_west_ruins");
  scripts\cp\zone_manager::add_adjacent_zone("zone_west_ruins_to_train", "zone_west_ruins", "door_zone_west_ruins_to_train_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_west_ruins_to_train", "zone_train_east", "door_zone_west_ruins_to_train_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_train_south", "zone_train_east", "door_zone_west_ruins_to_train_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_train_north", "zone_train_east", "door_zone_west_ruins_to_train_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_train_north", "zone_train_south", "door_zone_west_ruins_to_train_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_train_south", "zone_train_west", "door_zone_west_ruins_to_train_bought");
  scripts\cp\zone_manager::add_adjacent_zone("zone_train_north", "zone_train_west", "door_zone_west_ruins_to_train_bought");
  level thread enable_zone_listener(["power_on", "door_oasis_temple_to_east_spring_bought", "door_oasis_east_spring_to_east_ruins_bought", "door_oasis_east_spring_to_tent_west_bought", "door_oasis_east_spring_east_to_tent_east_bought"], "connect_zone_east_spring");
  level thread enable_zone_listener(["door_oasis_east_spring_to_tent_west_bought", "door_oasis_east_spring_east_to_tent_east_bought"], "enable_zone_tent");
  level thread enable_zone_listener(["door_oasis_east_spring_to_east_ruins_bought", "door_east_ruins_to_merchant_road_bought"], "connect_zone_east_ruins");
  level thread enable_zone_listener(["power_on", "door_east_ruins_to_merchant_road_bought", "door_merchant_road_east_to_crash_site_east_bought", "door_crash_site_west_to_merchant_road_south_bought", "door_merchant_road_west_to_west_ruins_south_bought"], "connect_merchant_road");
  level thread enable_zone_listener(["power_on", "door_oasis_temple_to_west_spring_east_bought", "door_oasis_temple_to_west_spring_bought", "door_oasis_west_spring_east_to_west_ruins_east_bought", "door_west_ruins_to_west_spring_west_bought"], "connect_zone_west_spring");
  level thread enable_zone_listener(["door_west_ruins_east_to_west_ruins_bought", "door_oasis_west_spring_east_to_west_ruins_east_bought", "door_merchant_road_west_to_west_ruins_south_bought", "door_zone_west_ruins_to_train_bought", "door_west_ruins_to_west_spring_west_bought"], "connect_zone_west_ruins");
  level.default_respawn_zone = "zone_temple";
  level scripts\engine\utility::_id_5C11("always_on");
  level scripts\engine\utility::_id_5C1B("always_on");
}

enable_zone_listener(var_0, var_1) {
  level endon("end_game");
  level scripts\engine\utility::_id_5C28(var_0);
  level scripts\engine\utility::_id_5C11(var_1);
  level scripts\engine\utility::_id_5C1B(var_1);
}