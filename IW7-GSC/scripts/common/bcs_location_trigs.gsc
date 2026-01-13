/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\common\bcs_location_trigs.gsc
*************************************************/

bcs_location_trigs_init() {
  level.bcs_location_mappings = [];
  bcs_location_trigger_mapping();
  bcs_trigs_assign_aliases();
  level.bcs_location_mappings = undefined;
  anim.locationlastcallouttimes = [];
}

bcs_trigs_assign_aliases() {
  anim.bcs_locations = [];
  var_0 = getEntArray();
  var_1 = [];
  foreach(var_3 in var_0) {
    if(isDefined(var_3.classname) && issubstr(var_3.classname, "trigger_multiple_bcs")) {
      var_1[var_1.size] = var_3;
    }
  }

  foreach(var_3 in var_1) {
    if(!isDefined(level.bcs_location_mappings[var_3.classname])) {
      continue;
    }

    var_6 = parselocationaliases(level.bcs_location_mappings[var_3.classname]);
    if(var_6.size > 1) {
      var_6 = scripts\engine\utility::array_randomize(var_6);
    }

    var_3.locationaliases = var_6;
  }

  anim.bcs_locations = var_1;
}

parselocationaliases(var_0) {
  var_1 = strtok(var_0, " ");
  return var_1;
}

add_bcs_location_mapping(var_0, var_1) {
  if(isDefined(level.bcs_location_mappings[var_0])) {
    var_2 = level.bcs_location_mappings[var_0];
    var_3 = parselocationaliases(var_2);
    var_4 = parselocationaliases(var_1);
    foreach(var_6 in var_4) {
      foreach(var_8 in var_3) {
        if(var_6 == var_8) {
          return;
        }
      }
    }

    var_2 = var_2 + " " + var_1;
    level.bcs_location_mappings[var_0] = var_2;
    return;
  }

  level.bcs_location_mappings[var_9] = var_0A;
}

bcs_location_trigger_mapping() {
  if(scripts\engine\utility::issp()) {
    sp();
    return;
  }

  metropolis();
  quarry();
  breakneck();
  desert();
  divide();
  fallen();
  frontier();
  parkour();
  riot();
  rivet();
  proto();
  skyway();
}

sp() {
  add_bcs_location_mapping("trigger_multiple_bcs_sp_doorway", "doorway_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_window_generic", "window_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_1stfloor", "1stfloor_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_2ndfloor", "2ndfloor_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_rooftop", "rooftop_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_balcony_generic", "balcony_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_bridge", "bridge_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_catwalk", "catwalk_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_crates_generic", "crates_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_hallway", "hallway_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_pillar", "pillar_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_pipes_generic", "pipes_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_railings", "railings_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_bar", "bar_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_cafe", "cafe_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_counter", "counter_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_elevator", "elevator_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_fountain", "fountain_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_generator", "generator_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_loadingbay", "loadingbay_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_ramp_generic", "ramp_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_stairs", "stairs_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_statue", "statue_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_turbines", "turbines_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_wall_generic", "wall_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_courtyard", "courtyard_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_street_generic", "street_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_planter", "planter_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_bench", "bench_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_boats", "boats_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_ladder", "ladder_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_tables", "tables_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_sign_generic", "sign_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_barricade_multiple", "barricades_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_garage", "garage_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_trench", "trench_generic");
  add_bcs_location_mapping("trigger_multiple_sp_rock", "rock_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_crater", "crater_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_trees", "trees_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_rubble", "rubble_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_dropship", "dropship_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_bookstore", "bookstore_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_bus", "bus_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_shop_kiosk", "kiosk_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_solarpanels", "solarpanels_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_aagun", "aagun_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_stairway", "stairway_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_foodcourt", "foodcourt_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_railcar", "railcar_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_droppod", "droppod_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_shop_generic", "shop_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_vendingmachine", "vendingmachine_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_lounge", "lounge_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_checkpoint", "checkpoint_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_hangar", "hangar_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_deck_upper", "deck_upper");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_ramp_main", "ramp_main");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_drill_heads", "drill_heads");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_street_end", "street_end");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_sign_parking", "parking_sign");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_sign_yield", "yield_sign");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_3rd_floor", "3rdfloor");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_vehicle_van", "vehicle_van");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_banner_blue", "banner_blue");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_building_destroyed", "building_destroyed");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_conveyor_belt", "conveyor_belt");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_door_security", "security_door");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_trash_cans", "trash_cans");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_door_report", "door_report");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_door_1stfloor_report", "door_1st_report");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_door_2ndfloor_report", "door_2nd_report");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_window_3rdfloor", "window_3rdfloor");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_window_1stfloor_report", "wndw_1st_report");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_window_2ndfloor_report", "wndw_2nd_report");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_floor_1st_report", "1st_report");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_floor_2nd_report", "2nd_report");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_fuel_tanks", "fuel_tanks");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_barrier_concrete", "concrete_barrier");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_barrels_yellow", "barrels_yellow");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_barrels_generic", "barrels_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_barrels_blue", "barrels_blue");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_oildrum", "oildrum_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_balcony_2ndfloor", "balcony_2ndfloor");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_vent", "vent_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_controlpanel", "controlpanel_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_lockers", "lockers_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_container_stacked", "container_stacked");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_container_shipping", "container_shipping");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_crates_plastic", "crates_plastic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_crates_pile", "crates_pile");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_crates_white", "crates_white");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_crates_ammo", "crate_ammo");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_commandcenter", "commandcenter_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_rack_missile", "rack_missile");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_pipes_gas", "pipes_gas");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_vehicle_atv", "vehicle_atv");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_wall_low", "wall_low");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_boulder_generic", "boulder_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_boulder_gap", "boulder_gap");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_vehicle_tram", "vehicle_tram");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_shop_dutyfree", "shop_dutyfree");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_shop_jewelry", "shop_jewelry");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_cart_luggage", "cart_luggage");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_vehicle_forklift", "vehicle_forklift");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_servers", "servers_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_vehicle_transport", "vehicle_transport");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_wall_stone", "wall_stone");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_wall_brick", "wall_brick");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_barricade_single", "barricades_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_bushes", "bushes_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_tower_control", "tower_control");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_missile_launcher", "missile_launcher");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_tower_radar", "tower_radar");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_satdish", "satdish_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_door_cargo", "door_cargo");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_gun_big", "gun_big");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_deck_lower", "deck_lower");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_side_port", "side_port");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_tower_generic", "tower_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_dropshipbay", "dropshipbay_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_roomcontrol", "room_control");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_terminal", "terminal_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_radar", "radar_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_wheelhouse", "wheelhouse_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_deck_2nd", "deck_2nd");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_missile_rack", "missile_rack");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_below", "below_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_hatch", "hatch_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_bulkheads", "bulkheads_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_topside", "topside_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_debris", "debris_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_above", "above_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_missile_silos", "missile_silos");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_deck_gun", "deck_gun");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_torpedo_mag", "torpedo_mag");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_airlock", "airlock_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_cargobay", "cargobay_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_controlcenter", "controlcenter_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_armory", "armory_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_rack_ordnance", "rack_ordnance");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_vault", "vault_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_pipes_orange", "pipes_orange");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_console", "console_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_gurney", "gurney_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_scanner_body", "scanner_body");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_bed", "bed_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_refinery", "refinery_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_tank_fuel", "tank_fuel");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_roof_vents", "roof_vents");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_truck_cargo", "truck_cargo");
  add_bcs_location_mapping("trigger_multiple_bcs_sp_drill_generic", "drill_generic");
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