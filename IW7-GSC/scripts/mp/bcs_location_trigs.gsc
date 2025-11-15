/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\bcs_location_trigs.gsc
*********************************************/

bcs_location_trigs_init() {
  if(!isDefined(level.bcs_location_mappings)) {
    level.bcs_location_mappings = [];
  }

  bcs_location_trigger_mapping();
  bcs_trigs_assign_aliases();
  level.bcs_location_mappings = undefined;
  anim.locationlastcallouttimes = [];
}

bcs_trigs_assign_aliases() {
  if(!isDefined(level.bcs_locations)) {
    anim.bcs_locations = [];
  }

  var_00 = getEntArray();
  var_01 = [];
  foreach(var_03 in var_00) {
    if(isDefined(var_03.classname) && issubstr(var_03.classname, "trigger_multiple_bcs")) {
      var_01[var_01.size] = var_03;
    }
  }

  foreach(var_03 in var_01) {
    if(!isDefined(level.bcs_location_mappings[var_03.classname])) {
      continue;
    }

    var_06 = parselocationaliases(level.bcs_location_mappings[var_03.classname]);
    if(var_06.size > 1) {
      var_06 = scripts\engine\utility::array_randomize(var_06);
    }

    var_03.locationaliases = var_06;
  }

  anim.bcs_locations = scripts\engine\utility::array_combine(level.bcs_locations, var_01);
}

parselocationaliases(param_00) {
  var_01 = strtok(param_00, " ");
  return var_01;
}

add_bcs_location_mapping(param_00, param_01) {
  if(isDefined(level.bcs_location_mappings[param_00])) {
    var_02 = level.bcs_location_mappings[param_00];
    var_03 = parselocationaliases(var_02);
    var_04 = parselocationaliases(param_01);
    foreach(var_06 in var_04) {
      foreach(var_08 in var_03) {
        if(var_06 == var_08) {
          return;
        }
      }
    }

    var_02 = var_02 + " " + param_01;
    level.bcs_location_mappings[param_00] = var_02;
    return;
  }

  level.bcs_location_mappings[var_09] = var_0A;
}

bcs_location_trigger_mapping() {
  geneva();
  neon();
  prime();
  afghan();
  func_B2FD();
  flip();
  junk();
  marsoasis();
  nova();
  paris();
  pixel();
  overflow();
  hawkwar();
  rally();
  func_5238();
  codphish();
}

metropolis() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_metropolis_room_bathroom", "room_bathroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_metropolis_generator_generic", "generator_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_metropolis_tunnel_generic", "tunnel_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_metropolis_train_generic", "train_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_metropolis_station_charging", "station_charging");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_metropolis_alley_generic", "alley_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_metropolis_van_news", "van_news");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_metropolis_station_central", "station_central");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_metropolis_park_generic", "park_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_metropolis_slums_generic", "slums_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_metropolis_building_bbq", "building_bbq");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_metropolis_lobby_generic", "lobby_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_metropolis_car_fire", "car_fire");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_metropolis_rack_bikes", "rack_bikes");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_metropolis_screen_big", "screen_big");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_metropolis_building_steakhouse", "building_steakhouse");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_metropolis_droppod_generic", "droppod_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_metropolis_tree_glow", "tree_glow");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_metropolis_car_generic", "car_generic");
}

quarry() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_crates_red", "crates_red");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_crates_generic", "crates_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_quarters_crew", "quarters_crew");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_barrels_yellow", "barrels_yellow");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_room_rechall", "room_rechall");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_room_cafeteria", "room_cafeteria");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_room_canteen", "room_canteen");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_tunnel_underground", "tunnel_underground");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_tunnel_maintenance", "tunnel_maintenance");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_underpass_generic", "underpass_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_tunnel_access", "tunnel_access");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_crawlspace_generic", "crawlspace_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_overpass_generic", "overpass_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_tires_generic", "tires_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_fence_generic", "fence_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_vehicle_dumptruck", "vehicle_dumptruck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_vehicle_bigtruck", "vehicle_bigtruck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_room_repairbay", "room_repairbay");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_room_motorpool", "room_motorpool");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_robots_generic", "robots_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_rocks_generic", "rocks_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_rockcrusher_generic", "rockcrusher_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_deck_lower", "deck_lower");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_room_readyroom", "room_readyroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_room_fillingstation", "room_fillingstation");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_quarry_room_cleanroom", "room_cleanroom");
}

breakneck() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_hallway_officersquarter", "hallway_officersquarter");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_hallway_bridge", "hallway_bridge");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_room_server", "room_server");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_portmissionbay_one", "portmissionbay_one");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_loadingdock_one", "loadingdock_one");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_hangar_one", "hangar_one");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_readyroom_officers", "readyroom_officers");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_readyroom_one", "readyroom_one");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_readyroom_blue", "readyroom_blue");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_navigation_holo", "navigation_holo");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_room_briefing", "room_briefing");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_kitchen_generic", "kitchen_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_elevators_port", "elevators_port");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_gundeck_port", "gundeck_port");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_hall_dining", "hall_dining");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_area_common", "area_common");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_berths_crew", "berths_crew");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_quarters_enlisted", "quarters_enlisted");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_readyroom_crew", "readyroom_crew");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_readyroom_two", "readyroom_two");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_readyroom_red", "readyroom_red");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_portmissionbay_two", "portmissionbay_two");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_loadingdock_two", "loadingdock_two");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_hangar_two", "hangar_two");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_command_control", "command_control");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_command_shipdefense", "command_shipdefense");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_armory_generic", "armory_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_armorylift_generic", "armorylift_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_room_armament", "room_armament");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_breakneck_room_weaponstorage", "room_weaponstorage");
}

desert() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_desert_pod_2", "pod_2");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_desert_pod_yellow", "pod_yellow");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_desert_bridge_generic", "bridge_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_desert_pod_1", "pod_1");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_desert_pod_blue", "pod_blue");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_desert_window_pod", "window_pod");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_desert_cave_sniper", "cave_sniper");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_desert_turret_destroyed", "turret_destroyed");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_desert_panels_solar", "panels_solar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_desert_jackal_crashed", "jackal_crashed");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_desert_window_generic", "window_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_desert_wall_run", "wall_run");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_desert_engine_giant", "engine_giant");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_desert_hallway_ship", "hallway_ship");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_desert_cargobay_generic", "cargobay_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_desert_screen_generic", "screen_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_desert_stairs_generic", "stairs_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_desert_area_yard", "area_yard");
}

divide() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_divide_building_cargohangar", "building_cargohangar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_divide_controls_hangar", "controls_hangar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_divide_room_drillcontrol", "room_drillcontrol");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_divide_deck_observation", "deck_observation");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_divide_room_lockerroom", "room_lockerroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_divide_turbine_generic", "turbine_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_divide_lava_pipe", "lava_pipe");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_divide_building_processing", "building_processing");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_divide_skybridge_generic", "skybridge_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_divide_drill_generic", "drill_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_divide_wallrun_digsite", "wallrun_digsite");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_divide_building_shiphang", "building_shiphang");
}

fallen() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_fallen_shop_icecream", "shop_icecream");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_fallen_movietheater_generic", "movietheater_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_fallen_store_hardware", "store_hardware");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_fallen_church_generic", "church_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_fallen_mainstreet_generic", "mainstreet_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_fallen_mainstreet_underpass", "mainstreet_underpass");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_fallen_bowlingalley_generic", "bowlingalley_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_fallen_policestation_generic", "policestation_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_fallen_field_baseball", "field_baseball");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_fallen_fieldhouse_generic", "fieldhouse_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_fallen_station", "station");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_fallen_station_ticketcounter", "station_ticketcounter");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_fallen_station_departures", "station_departures");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_fallen_station_foodcourt", "station_foodcourt");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_fallen_station_arrivals", "station_arrivals");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_fallen_silo_generic", "silo_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_fallen_greenhouse_generic", "greenhouse_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_fallen_farmersmarket_generic", "farmersmarket_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_fallen_farmhouse_generic", "farmhouse_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_fallen_barn_generic", "barn_generic");
}

frontier() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_frontier_room_briefing", "room_briefing");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_frontier_room_bunk", "room_bunk");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_frontier_room_command", "room_command");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_frontier_pods_escape", "pods_escape");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_frontier_lounge_generic", "lounge_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_frontier_hallway_lower", "hallway_lower");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_frontier_room_medbay", "room_medbay");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_frontier_hall_mess", "hall_mess");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_frontier_lab_hydro", "lab_hydro");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_frontier_hallway_main", "hallway_main");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_frontier_lift_yellow", "lift_yellow");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_frontier_lift_blue", "lift_blue");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_frontier_tunnel_service", "tunnel_service");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_frontier_stairwell_generic", "stairwell_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_frontier_ramp_generic", "ramp_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_frontier_room_control", "room_control");
}

parkour() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_parkour_watertank_generic", "helipad_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_parkour_watertank_generic", "watertank_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_parkour_whirlpool", "whirlpool");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_parkour_window_washroom", "window_washroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_parkour_vehicle_dropship", "vehicle_dropship");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_parkour_bodies_dead", "bodies_dead");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_parkour_room_barracks", "room_barracks");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_parkour_window_generic", "window_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_parkour_crates_generic", "crates_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_parkour_cave_generic", "cave_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_parkour_cryo_prisoners", "cryo_prisoners");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_parkour_vehicle_truck", "vehicle_truck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_parkour_room_shipping", "room_shipping");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_parkour_barrels_generic", "barrels_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_parkour_roof_mid", "roof_mid");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_parkour_building_round", "building_round");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_parkour_room_wet", "room_wet");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_parkour_balcony_generic", "balcony_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_parkour_wall_run", "wall_run");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_parkour_cellblock_generic", "cellblock_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_parkour_building_medpod", "building_medpod");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_parkour_window_medbay", "window_medbay");
}

proto() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_proto_dock_loading", "dock_loading");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_proto_room_security", "room_security");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_proto_entrance_generic", "entrance_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_proto_bay_robot", "bay_robot");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_proto_sub_launch", "sub_launch");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_proto_pump_water", "pump_water");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_proto_building_comms", "building_comms");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_proto_blocks_ice", "catwalk_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_proto_blocks_ice", "blocks_ice");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_proto_area_construction", "area_construction");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_proto_jackal_control", "jackal_control");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_proto_crate_stack", "crate_stack");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_proto_grinder_ice", "grinder_ice");
}

riot() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_riot_building_church", "building_church");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_riot_wall_destroyed", "wall_destroyed");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_riot_courtyard_generic", "courtyard_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_riot_garden_beer", "garden_beer");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_riot_statue_generic", "statue_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_riot_stairs_archway", "stairs_archway");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_riot_bikeshop_interior", "bikeshop_interior");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_riot_scaffolding_generic", "scaffolding_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_riot_vehicle_apc", "vehicle_apc");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_riot_vehicle_sailboat", "vehicle_sailboat");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_riot_building_castle", "building_castle");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_riot_vehicle_bus", "vehicle_bus");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_riot_room_bar", "room_bar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_riot_hallway_generic", "hallway_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_riot_lobby_hotel", "lobby_hotel");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_riot_room_hotel", "room_hotel");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_riot_rooftop_generic", "rooftop_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_riot_vehicle_policecar", "vehicle_policecar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_riot_tunnel_generic", "tunnel_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_riot_docks_upper", "docks_upper");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_riot_waterfront_generic", "waterfront_generic");
}

rivet() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rivet_dock_yellow", "dock_yellow");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rivet_ship_bow", "ship_bow");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rivet_dock_blue", "dock_blue");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rivet_room_chemstorage", "room_chemstorage");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rivet_area_hosing", "area_hosing");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rivet_area_cleaning", "area_cleaning");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rivet_path_center", "path_center");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rivet_rocket_generic", "rocket_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rivet_loadingzone_generic", "loadingzone_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rivet_area_warehouseload", "area_warehouseload");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rivet_rocket_engine", "rocket_engine");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rivet_catwalk_yellow", "catwalk_yellow");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rivet_airlock_generic", "airlock_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rivet_catwalk_blue", "catwalk_blue");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rivet_hallway_west", "hallway_west");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rivet_building_yellow", "building_yellow");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rivet_building_fabrication", "building_fabrication");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rivet_overlook_fabrication", "overlook_fabrication");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rivet_building_blue", "building_blue");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rivet_building_warehouse", "building_warehouse");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rivet_door_garage", "door_garage");
}

skyway() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skyway_area_checkpoint", "area_checkpoint");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skyway_area_security", "area_security");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skyway_area_luggagecheck", "area_luggagecheck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skyway_desk_desk", "desk_desk");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skyway_tree_generic", "tree_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skyway_store_gift", "store_gift");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skyway_store_book", "store_book");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skyway_jetway_generic", "jetway_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skyway_corridor_generic", "corridor_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skyway_store_sushi", "store_sushi");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skyway_area_dining", "area_dining");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skyway_room_restroom", "room_restroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skyway_fountain_generic", "fountain_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skyway_fountain_stairs", "fountain_stairs");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skyway_vehicle_crane", "vehicle_crane");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skyway_statue_astronaut", "statue_astronaut");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skyway_stair_car", "stair_car");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skyway_room_control", "room_control");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skyway_turret_generic", "turret_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skyway_shuttle_ramp", "shuttle_ramp");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skyway_shuttle_cockpit", "shuttle_cockpit");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skyway_tarmac_generic", "tarmac_generic");
}

geneva() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_masq_shop", "masq_shop");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_statue_plaza", "statue_plaza");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_well", "well");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_well_inside", "well_inside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_restaurant_outside", "restaurant_outside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_gelato_parlor", "gelato_parlor");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_fountain", "fountain");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_fruit_stand", "fruit_stand");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_monument", "monument");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_gandolas", "gandolas");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_bank_outside", "bank_outside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_atms", "atms");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_church_inside", "church_inside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_travelagency_wndw", "travelagency_wndw");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_travelagency_inside", "travelagency_inside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_doubledoors", "doubledoors");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_boat", "informatioboatn_desk");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_canal_shop", "canal_shop");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_canal", "canal");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_garden", "garden");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_stairs", "stairs");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_newsstand", "newsstand");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_kiosk", "kiosk");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_lamppost", "lamppost");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_altar", "altar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_candles", "candles");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_window", "window");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_tables", "tables");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_geneva_arches", "arches");
}

prime() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_prime_barbershop", "barbershop");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_prime_market", "market");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_prime_pharmacy_2ndflr", "pharmacy_2ndflr");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_prime_statue_plaza", "statue_plaza");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_prime_policestation_outside", "policestation_outside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_prime_subway_inside", "subway_inside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_prime_subway_outside", "subway_outside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_prime_bridge_under", "bridge_under");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_prime_crane", "crane");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_prime_plaza", "plaza");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_prime_docks", "docks");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_prime_store_2ndflr", "store_2ndflr");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_prime_store_1stflr", "store_1stflr");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_prime_firehouse_inside", "firehouse_inside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_prime_firehouse_outside", "firehouse_outside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_prime_diner_above", "diner_above");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_prime_scaffolding", "scaffolding");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_prime_fuelcans", "fuelcans");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_prime_subway_tunnel", "subway_tunnel");
}

neon() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_neon_theater", "theater");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_neon_nightclub", "nightclub");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_neon_parking_lot", "parking_lot");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_neon_pharmacy", "pharmacy");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_neon_hospital", "hospital");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_neon_stairway", "stairway");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_neon_canopy", "canopy");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_neon_policestation_inside", "policestation_inside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_neon_policestation_balcony", "policestation_balcony");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_neon_policestation_outside", "policestation_outside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_neon_cityhall_inside", "cityhall_inside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_neon_cityhall_outside", "cityhall_outside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_neon_bank_outside", "bank_outside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_neon_apts_2ndflr", "apts_2ndflr");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_neon_apts_outside", "apts_outside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_neon_hotel_outside", "hotel_outside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_neon_market", "market");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_neon_firetruck", "firetruck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_neon_ambulance", "ambulance");
}

afghan() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_afghan_large_pipes", "large_pipes");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_afghan_hydroponics", "hydroponics");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_afghan_garden", "garden");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_afghan_control_room", "control_room");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_afghan_bunker", "bunker");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_afghan_servers", "servers");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_afghan_crash_site", "crash_site");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_afghan_cockpit", "cockpit");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_afghan_tail_section", "tail_section");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_afghan_generator", "generator");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_afghan_aaguns", "aaguns");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_afghan_overlook", "overlook");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_afghan_broken_stairs", "broken_stairs");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_afghan_satellite_dish", "satellite_dish");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_afghan_cavern", "cavern");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_afghan_atmogen", "atmogen");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_afghan_vehicle_ent", "vehicle_ent");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_afghan_vehicles", "vehicles");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_afghan_pump_station", "pump_station");
}

func_B2FD() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_mansion_shark", "shark");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_mansion_room_security", "room_security");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_mansion_vases_antique", "vases_antique");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_mansion_garden", "garden");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_mansion_station_foodcourt", "station_foodcourt");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_mansion_room_bathroom", "room_bathroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_mansion_station_ticketcounter", "station_ticketcounter");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_mansion_room_storage", "room_storage");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_mansion_store_gift", "store_gift");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_mansion_room_fist", "store_gift");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_mansion_room_library", "room_library");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_mansion_courtyard_generic", "courtyard_generic");
}

flip() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flip_docks", "docks");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flip_statue_head", "statue_head");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flip_penthouse", "penthouse");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flip_lobby_tower", "lobby_tower");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flip_car_gold", "car_gold");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flip_garden_rooftop", "garden_rooftop");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flip_tubes_generic", "tubes_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flip_sign_building", "sign_building");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flip_elevator", "elevator");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flip_fan_ventilation", "fan_ventilation");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flip_control_docking", "control_docking");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flip_fountain_runner", "fountain_runner");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flip_fountain_2nd", "fountain_2nd");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flip_fountain_generic", "fountain_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flip_statue_lion", "statue_lion");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flip_screen_generic", "screen_generic");
}

junk() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_junk_crane_blue", "crane_blue");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_junk_room_control", "room_control");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_junk_fuselage_interior", "fuselage_interior");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_junk_tunnel_generic", "tunnel_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_junk_crane_orange", "crane_orange");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_junk_compactor_interior", "compactor_interior");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_junk_compactor_wallrun", "compactor_wallrun");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_junk_gate_front", "gate_front");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_junk_room_security", "room_security");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_junk_room_grindercontrol", "room_grindercontrol");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_junk_quarters_crew", "quarters_crew");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_junk_area_maintenance", "area_maintenance");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_junk_comm_center", "comm_center");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_junk_grinder_ice", "grinder_ice");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_junk_magnet_scrap", "magnet_scrap");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_junk_vehicle_mooncrawler", "vehicle_mooncrawler");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_junk_vehicle_bulldozer", "vehicle_bulldozer");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_junk_building_rotunda", "building_rotunda");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_junk_pod_communication", "pod_communication");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_junk_vehicle_dropship", "vehicle_dropship");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_junk_tires_generic", "tires_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_junk_crane", "crane");
}

marsoasis() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_marsoasis_waterfall_generic", "waterfall_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_marsoasis_truck_generic", "truck_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_marsoasis_table_gaming", "table_gaming");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_marsoasis_building_casino", "building_casino");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_marsoasis_room_bar", "room_bar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_marsoasis_slot_machine", "slot_machine");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_marsoasis_lounge_generic", "lounge_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_marsoasis_overlook", "overlook");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_marsoasis_window_generic", "window_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_marsoasis_shop_dive", "shop_dive");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_marsoasis_directory_generic", "directory_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_marsoasis_desk_front", "desk_front");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_marsoasis_elevators_port", "elevators_port");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_marsoasis_aquarium_generic", "aquarium_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_marsoasis_cliff_side", "cliff_side");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_marsoasis_spa_interior", "spa_interior");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_marsoasis_hot_springs", "hot_springs");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_marsoasis_pods_generic", "pods_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_marsoasis_river_generic", "river_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_marsoasis_hotel_entrance", "hotel_entrance");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_marsoasis_luggage_generic", "luggage_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_marsoasis_elevator", "elevator");
}

nova() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_lighthouse_generic", "lighthouse_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_lighthouse_bridge", "lighthouse_bridge");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_beach_generic", "beach_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_lumberyard_generic", "lumberyard_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_market", "market");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_market_food", "market_food");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_market_square", "market_square");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_trading_post", "trading_post");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_downedship_generic", "downedship_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_downedship_interior", "downedship_interior");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_residential_interior", "residential_interior");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_apartments_container", "apartments_container");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_outhouse_generic", "outhouse_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_outhouse_generic", "room_engine");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_greenhouse_generic", "greenhouse_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_hydroponics", "hydroponics");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_farm_generic", "farm_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_restaurant_outside", "restaurant_outside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_oil_spill", "oil_spill");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_oil_tanks", "oil_tanks");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_broiler_generic", "broiler_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_pier_generic", "pier_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_large_pipes", "large_pipes");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_sewer_wall", "sewer_wall");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_sewer_generic", "sewer_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_nova_pump_station", "pump_station");
}

paris() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_paris_gallows_generic", "gallows_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_paris_waterwell_generic", "waterwell_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_paris_church_generic", "church_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_paris_building_church", "building_church");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_paris_church_inside", "church_inside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_paris_tower_radio", "tower_radio");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_paris_gazebo_generic", "gazebo_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_paris_tanks_water", "tanks_water");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_paris_room_cellar", "room_cellar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_paris_gate_green", "gate_green");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_paris_archway_generic", "archway_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_paris_sandbags_generic", "sandbags_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_paris_balcony_generic", "balcony_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_paris_wall_destroyed", "wall_destroyed");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_paris_pile_log", "pile_log");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_paris_wire_barbed", "wire_barbed");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_paris_building_wrecked", "building_wrecked");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_paris_building_jail", "building_jail");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_paris_building_inn", "building_inn");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_paris_building_lodge", "building_lodge");
}

pixel() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_dragon_giant", "dragon_giant");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_skull_dino", "skull_dino");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_catapult_generic", "catapult_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_range_archery", "range_archery");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_tents_generic", "tents_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_forest_dark", "forest_dark");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_haystacks_generic", "haystacks_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_building_windmill", "building_windmill");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_archway_castle", "archway_castle");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_stairs_castle", "stairs_castle");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_doorway_castle", "doorway_castle");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_obelisk_generic", "obelisk_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_tomb_generic", "tomb_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_fountain_generic", "fountain_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_tiki_hut", "tiki_hut");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_statues_tiki", "statues_tiki");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_stairs_temple", "stairs_temple");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_arch_donut", "arch_donut");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_statue_icecreamcone", "statue_icecreamcone");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_station_foodcourt", "station_foodcourt");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_barrels_generic", "barrels_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_window_office", "window_office");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_arcade_generic", "arcade_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pixel_breakroom_generic", "breakroom_generic");
}

overflow() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_breakroom_generic", "breakroom_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_droppod_generic", "droppod_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_building_droppod", "building_droppod");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_parkinglot", "parkinglot");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_backlot_generic", "backlot_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_door_garage", "door_garage");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_cliff_side", "cliff_side");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_cliff_generic", "cliff_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_alleyway_generic", "alleyway_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_tunnel_generic", "tunnel_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_street_collapsed", "street_collapsed");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_firetruck", "firetruck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_vehicle_bus", "vehicle_bus");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_theater", "theater");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_theater_lobby", "theater_lobby");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_theater_entrance", "theater_entrance");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_murderscene_generic", "murderscene_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_vehicle_dropship", "vehicle_dropship");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_shipwreck_generic", "shipwreck_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_terrace_generic", "terrace_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_hotdogstand_generic", "hotdogstand_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_underpass_generic", "underpass_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_window_generic", "window_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_wall_run", "wall_run");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_room_bathroom", "room_bathroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_overflow_elevators_port", "elevators_port");
}

hawkwar() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_antiques", "antiques");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_bar", "bar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_icecream", "icecream");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_mill_outside", "mill_outside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_postoffice_inside", "postoffice_inside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_apartment_inside", "apartment_inside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_headquarters", "headquarters");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_assembly_line", "assembly_line");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_firetruck", "firetruck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_intersection", "intersection");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_alley", "alley");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_shops", "shops");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_roadwork", "roadwork");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_hardware", "hardware");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_watertower", "watertower");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_bakery", "bakery");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_maintenance_area", "maintenance_area");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_restoration", "restoration");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_encoding", "encoding");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_behavioral", "behavioral");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_parts", "parts");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_storage", "storage");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hawkwar_barbershop", "barbershop");
}

func_5238() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_depot_ship", "ship");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_depot_warehouse", "warehouse");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_depot_repairshop", "repairshop");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_depot_restaurant_outside", "restaurant_outside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_depot_construction", "construction");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_depot_market", "market");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_depot_alley", "alley");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_depot_garage_outside", "garage_outside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_depot_office", "office");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_depot_pulley", "pulley");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_depot_silos", "silos");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_depot_trains", "trains");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_depot_market_entrance", "market_entrance");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_depot_monorail", "monorail");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_depot_rooftop", "rooftop");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_depot_mainstreet", "mainstreet");
}

rally() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_diner_outside", "diner_outside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_gasstation", "gasstation");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_bleachers", "bleachers");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_stage", "stage");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_soundbooth", "soundbooth");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_snackshop", "snackshop");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_burninator", "burninator");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_bigtruck", "big_truck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_bar", "bar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_bridge", "bridge");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_junkyard", "junkyard");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_spillway", "spillway");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_pumproom", "pumproom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_control_window", "control_window");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_riverbed", "riverbed");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_dam", "dam");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_office", "office");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_parkinglot", "parkinglot");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_cliffside", "cliffside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_drain", "drain");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_trucks", "trucks");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_bus", "bus");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_van", "van");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_balcony", "balcony");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_fire", "fire");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rally_fence", "fence");
}

codphish() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_cliffside", "cliffside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_awning", "awning");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_terrace", "terrace");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_terrace", "terrace");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_valet", "valet");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_lobby", "lobby");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_lobby_entrance", "lobby_entrance");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_oaktree", "oaktree");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_cafe", "cafe");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_cafe_kiosk", "cafe_kiosk");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_waterfall_kiosk", "waterfall_kiosk");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_bridge", "bridge");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_lowerbridge", "lowerbridge");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_underpass", "underpass");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_waterfall", "waterfall");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_elevators", "elevators");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_monument", "monument");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_cinema", "cinema");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_observatory", "observatory");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_mannequins", "mannequins");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_turnstiles", "turnstiles");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_sushi_restaurant", "sushi_restaurant");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_nightclub_inside", "nightclub_inside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_restrooms", "restrooms");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_apartments_inside", "apartments_inside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_apartments_outside", "apartments_outside");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_gym", "gym");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_hallway", "hallway");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_vending_machines", "vending_machines");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_commonroom", "commonroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_stairs", "stairs");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_fountain", "fountain");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_balcony", "balcony");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_codphish_restaurant_outside", "restaurant_outside");
}