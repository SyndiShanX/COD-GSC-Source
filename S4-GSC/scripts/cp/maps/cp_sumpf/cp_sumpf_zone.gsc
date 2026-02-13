/******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sumpf\cp_sumpf_zone.gsc
******************************************************/

init() {
  scripts\cp\zone_manager::init_zone_manager();
  scripts\cp\zone_manager::zone_init("center_building_upstairs_zone");
  scripts\cp\zone_manager::zone_init("teleport_room");
  scripts\cp\zone_manager::add_adjacent_zone("center_building_upstairs_zone", "center_building_upstairs_buy_zone", "door_center_building_upstairs_bought");
  scripts\cp\zone_manager::add_adjacent_zone("center_building_upstairs_buy_zone", "center_building_combined_zone_southeast", "door_center_building_upstairs_bought");
  scripts\cp\zone_manager::add_adjacent_zone("center_building_upstairs_zone", "center_building_combined_zone_northeast", "door_center_building_stairs_bought");
  scripts\cp\zone_manager::add_adjacent_zone("center_building_upstairs_zone", "center_building_combined_zone_northwest", "door_center_building_stairs_bought");
  scripts\cp\zone_manager::add_adjacent_zone("center_building_upstairs_buy_zone", "center_building_combined_zone_southeast", "door_center_building_stairs_bought");
  scripts\cp\zone_manager::add_adjacent_zone("center_building_combined_zone_northeast", "center_building_combined_zone_northwest", "enable_center_building_combined_zone");
  scripts\cp\zone_manager::add_adjacent_zone("center_building_combined_zone_northeast", "center_building_combined_zone_southeast", "enable_center_building_combined_zone");
  scripts\cp\zone_manager::add_adjacent_zone("center_building_combined_zone_northeast", "center_building_combined_zone_southwest", "enable_center_building_combined_zone");
  scripts\cp\zone_manager::add_adjacent_zone("center_building_combined_zone_northwest", "center_building_combined_zone_southeast", "enable_center_building_combined_zone");
  scripts\cp\zone_manager::add_adjacent_zone("center_building_combined_zone_northwest", "center_building_combined_zone_southwest", "enable_center_building_combined_zone");
  scripts\cp\zone_manager::add_adjacent_zone("center_building_combined_zone_southeast", "center_building_combined_zone_southwest", "enable_center_building_combined_zone");
  scripts\cp\zone_manager::add_adjacent_zone("center_building_combined_zone_southwest", "doctors_quarters_outside_to_center_building_zone", "door_center_building_to_doctors_quarters_bought");
  scripts\cp\zone_manager::add_adjacent_zone("doctors_quarters_outside_zone", "doctors_quarters_outside_to_center_building_zone", "door_center_building_to_doctors_quarters_bought");
  scripts\cp\zone_manager::add_adjacent_zone("doctors_quarters_outside_zone", "doctors_quarters_outside_to_center_building_zone", "door_doctors_quarters_bought");
  scripts\cp\zone_manager::add_adjacent_zone("doctors_quarters_outside_zone", "doctors_quarters_building_zone", "door_doctors_quarters_bought");
  scripts\cp\zone_manager::add_adjacent_zone("center_building_combined_zone_northwest", "storage_outside_to_center_building_zone", "enable_storage_outside");
  scripts\cp\zone_manager::add_adjacent_zone("storage_outside_to_center_building_zone", "storage_outside_zone", "enable_storage_outside");
  scripts\cp\zone_manager::add_adjacent_zone("storage_outside_to_dig_site_zone", "storage_outside_to_center_building_zone", "enable_storage_outside");
  scripts\cp\zone_manager::add_adjacent_zone("storage_outside_to_dig_site_zone", "storage_outside_zone", "enable_storage_outside");
  scripts\cp\zone_manager::add_adjacent_zone("storage_outside_zone", "storage_building_zone", "door_storage_bought");
  scripts\cp\zone_manager::add_adjacent_zone("center_building_combined_zone_southeast", "fishing_hut_outside_to_center_building_zone", "door_center_building_to_fishing_hut_bought");
  scripts\cp\zone_manager::add_adjacent_zone("fishing_hut_outside_to_center_building_zone", "fishing_hut_outside_zone", "door_center_building_to_fishing_hut_bought");
  scripts\cp\zone_manager::add_adjacent_zone("fishing_hut_outside_to_fishing_hut_zone", "fishing_hut_outside_zone", "door_center_building_to_fishing_hut_bought");
  scripts\cp\zone_manager::add_adjacent_zone("fishing_hut_outside_to_fishing_hut_zone", "fishing_hut_building_zone", "door_fishing_hut_bought");
  scripts\cp\zone_manager::add_adjacent_zone("fishing_hut_outside_zone", "fishing_hut_outside_to_center_building_zone", "door_fishing_hut_bought");
  scripts\cp\zone_manager::add_adjacent_zone("fishing_hut_outside_zone", "fishing_hut_outside_to_fishing_hut_zone", "door_fishing_hut_bought");
  scripts\cp\zone_manager::add_adjacent_zone("center_building_combined_zone_northeast", "comm_room_outside_to_center_building_zone", "enable_comm_room_outside");
  scripts\cp\zone_manager::add_adjacent_zone("comm_room_outside_to_center_building_zone", "comm_room_outside_zone", "enable_comm_room_outside");
  scripts\cp\zone_manager::add_adjacent_zone("comm_room_outside_to_dig_site_zone", "comm_room_outside_zone", "enable_comm_room_outside");
  scripts\cp\zone_manager::add_adjacent_zone("comm_room_outside_to_dig_site_zone", "comm_room_outside_to_center_building_zone", "enable_comm_room_outside");
  scripts\cp\zone_manager::add_adjacent_zone("comm_room_outside_zone", "comm_room_building_zone", "door_comm_room_bought");
  scripts\cp\zone_manager::add_adjacent_zone("dig_site_to_comm_room_outside_zone", "comm_room_outside_to_dig_site_zone", "door_comm_to_digsite_bought");
  scripts\cp\zone_manager::add_adjacent_zone("dig_site_to_storage_outside_zone", "storage_outside_to_dig_site_zone", "door_storage_to_digsite_bought");
  scripts\cp\zone_manager::add_adjacent_zone("dig_site_west_zone", "dig_site_to_comm_room_outside_zone", "door_comm_to_digsite_bought");
  scripts\cp\zone_manager::add_adjacent_zone("dig_site_east_zone", "dig_site_to_storage_outside_zone", "door_comm_to_digsite_bought");
  scripts\cp\zone_manager::add_adjacent_zone("dig_site_east_zone", "dig_site_west_zone", "door_comm_to_digsite_bought");
  scripts\cp\zone_manager::add_adjacent_zone("dig_site_west_zone", "dig_site_to_comm_room_outside_zone", "door_storage_to_digsite_bought");
  scripts\cp\zone_manager::add_adjacent_zone("dig_site_east_zone", "dig_site_to_storage_outside_zone", "door_storage_to_digsite_bought");
  scripts\cp\zone_manager::add_adjacent_zone("dig_site_east_zone", "dig_site_west_zone", "door_storage_to_digsite_bought");
  scripts\cp\zone_manager::set_zone_enabled("center_building_upstairs_zone", 1);
  scripts\cp\zone_manager::set_zone_enabled("teleport_room", 1);
  level thread scripts\cp\zone_manager::manage_zones();
  level thread enable_zone_listener(["door_center_building_stairs_bought", "door_center_building_upstairs_bought"], "enable_center_building_combined_zone");
  level thread enable_zone_listener(["door_center_building_to_comm_room_bought", "door_comm_to_digsite_bought"], "enable_comm_room_outside");
  level thread enable_zone_listener(["door_center_building_to_storage_bought", "door_storage_to_digsite_bought"], "enable_storage_outside");
  level.default_respawn_zone = "center_building_upstairs_zone";
  level.flogger_zone_flag = "door_center_building_to_fishing_hut_bought";
  level.zipline_zone_flag = "door_center_building_to_doctors_quarters_bought";
}

enable_zone_listener(var_0, var_1) {
  level endon("end_game");
  level scripts\engine\utility::_id_5C28(var_0);
  level scripts\engine\utility::_id_5C11(var_1);
  level scripts\engine\utility::_id_5C1B(var_1);
}