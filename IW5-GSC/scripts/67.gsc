/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\67.gsc
**************************************/

bcs_location_trigs_init() {
  level.bcs_location_mappings = [];
  bcs_location_trigger_mapping();
  bcs_trigs_assign_aliases();
  level.bcs_location_mappings = undefined;
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
    var_6 = parselocationaliases(level.bcs_location_mappings[var_3.classname]);

    if(var_6.size > 1) {
      var_6 = maps\_utility::array_randomize(var_6);
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

    var_2 = var_2 + (" " + var_1);
    level.bcs_location_mappings[var_0] = var_2;
    return;
  }

  level.bcs_location_mappings[var_0] = var_1;
}

bcs_location_trigger_mapping() {
  generic_locations();
  vehicles();
  landmarks();
  tibet();
  ny_manhattan();
  ny_harbor();
  hijack();
  warlord();
  london();
  payback();
  hamburg();
  paris_a();
  paris_b();
  paris_ac130();
  prague();
  berlin();
  dubai();
}

generic_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_uk_building_1stfloor", "loc_1st_report");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_building_2ndfloor", "loc_2nd_report");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_building_1stfloor_door_left", "loc_door_1st_left_report");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_building_1stfloor_door", "loc_door_1st_report");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_building_1stfloor_door_right", "loc_door_1st_right_report");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_building_2ndfloor_door", "loc_door_2nd_report");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_building_door", "loc_door_report");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_building_1stfloor_window_left", "loc_wndw_1st_left_report");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_building_1stfloor_window", "loc_wndw_1st_report");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_building_1stfloor_window_right", "loc_wndw_1st_right_report");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_building_2ndfloor_window_left", "loc_wndw_2nd_left_report");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_building_2ndfloor_window", "loc_wndw_2nd_report");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_building_2ndfloor_window_right", "loc_wndw_2nd_right_report");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_callout_loc_door", "callout_loc_door_report");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_callout_loc_door_1st", "callout_loc_door_1st_report");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_callout_loc_door_1st_right", "callout_loc_door_1st_right_report");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_callout_loc_door_1st_left", "callout_loc_door_1st_left_report");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_callout_loc_door_2nd", "callout_loc_door_2nd_report");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_callout_loc_wndw_1st", "callout_loc_wndw_1st_report");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_callout_loc_wndw_1st_left", "callout_loc_wndw_1st_left_report");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_callout_loc_wndw_1st_right", "callout_loc_wndw_1st_right_report");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_callout_loc_1st", "callout_loc_1st_report");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_callout_loc_2nd", "callout_loc_2nd_report");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_callout_loc_wndw_2nd", "callout_loc_wndw_2nd_report");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_callout_loc_wndw_2nd_left", "callout_loc_wndw_2nd_left_report");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_callout_loc_wndw_2nd_right", "callout_loc_wndw_2nd_right_report");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_callout_loc_wndw_3rd", "callout_loc_wndw_3rd_report");
}

landmarks() {
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_ac_generic", "loc_ac_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_airdrop_generic", "loc_airdrop_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_alley_generic", "loc_alley_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_balcony_2nd", "loc_balcony_2nd");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_balcony_3rd", "loc_balcony_3rd");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_bank_generic", "loc_bank_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_bar_generic", "loc_bar_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_barrels_generic", "loc_barrels_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_barricade_generic", "loc_barricade_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_barrier_hesco", "loc_barrier_hesco");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_barrier_orange", "loc_barrier_orange");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_bin_recycle", "loc_bin_recycle");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_bookcase_generic", "loc_bookcase_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_building_red", "loc_building_red");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_bulkhead_generic", "loc_bulkhead_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_bunk_generic", "loc_bunk_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_bus_generic", "loc_bus_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_bus_inside", "loc_bus_inside");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_car_blue", "loc_car_blue");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_car_burning", "loc_car_burning");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_car_destroyed", "loc_car_destroyed");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_car_generic", "loc_car_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_car_green", "loc_car_green");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_car_overturned", "loc_car_overturned");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_car_parked", "loc_car_parked");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_car_police", "loc_car_police");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_car_yellow", "loc_car_yellow");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_catwalk_generic", "loc_catwalk_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_chair_blue", "loc_chair_blue");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_column_generic", "loc_column_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_console_generic", "loc_console_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_container_generic", "loc_container_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_container_red", "loc_container_red");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_couch_blue", "loc_couch_blue");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_couch_generic", "loc_couch_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_crates_ammo", "loc_crates_ammo");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_crates_generic", "loc_crates_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_cubicles_left", "loc_cubicles_left");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_cubicles_right", "loc_cubicles_right");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_deck_generic", "loc_deck_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_door_back", "loc_door_back");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_door_front", "loc_door_front");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_dumpster_generic", "loc_dumpster_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_embassy_1st", "loc_embassy_1st");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_embassy_3rd", "loc_embassy_3rd");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_engine_generic", "loc_engine_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_fan_exhaust", "loc_fan_exhaust");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_gate_generic", "loc_gate_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_hill_generic", "loc_hill_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_machine_copy", "loc_machine_copy");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_mg_generic", "loc_mg_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_patio_generic", "loc_patio_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_pipe_generic", "loc_pipe_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_planter_generic", "loc_planter_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_rack_bike", "loc_rack_bike");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_railing_generic", "loc_railing_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_ramp_down", "loc_ramp_down");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_rooftop_generic", "loc_rooftop_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_room_conf", "loc_room_conf");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_room_middle", "loc_room_middle");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_rubble_generic", "loc_rubble_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_sandbags_generic", "loc_sandbags_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_scaffolding_generic", "loc_scaffolding_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_car_black", "loc_car_black");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_shop_book", "loc_shop_book");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_shop_cafe", "loc_shop_cafe");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_shop_coffee", "loc_shop_coffee");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_shop_restaurant", "loc_shop_restaurant");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_shop_souvenir", "loc_shop_souvenir");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_staircase_generic", "loc_staircase_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_stairs_bottom", "loc_stairs_bottom");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_stairs_generic", "loc_stairs_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_stairs_top", "loc_stairs_top");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_stand_hotdog", "loc_stand_hotdog");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_stand_news", "loc_stand_news");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_stand_trading", "loc_stand_trading");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_statue_generic", "loc_statue_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_stryker_destroyed", "loc_stryker_destroyed");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_subway_entrance", "loc_subway_entrance");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_table_computer", "loc_table_computer");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_table_generic", "loc_table_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_tanks_generic", "loc_tanks_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_taxi_destroyed", "loc_taxi_destroyed");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_taxi_generic", "loc_taxi_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_tires_large", "loc_tires_large");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_tower_jamming", "loc_tower_jamming");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_truck_white", "loc_truck_white");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_van_blue", "loc_van_blue");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_vehicle_btr", "loc_vehicle_btr");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_vehicle_dumptruck", "loc_vehicle_dumptruck");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_vehicle_gaz", "loc_vehicle_gaz");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_vehicle_hind", "loc_vehicle_hind");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_vehicle_snowcat", "loc_vehicle_snowcat");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_vehicle_snowmobile", "loc_vehicle_snowmobile");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_wall_low", "loc_wall_low");
  add_bcs_location_mapping("trigger_multiple_bcs_df_generic_loc_water_cooler", "loc_water_cooler");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_wndw_3rd", "callout_loc_wndw_3rd");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_alley_generic", "loc_alley_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_arch_generic", "loc_arch_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_balcony_2nd", "loc_balcony_2nd");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_balcony_3rd", "loc_balcony_3rd");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_balcony_generic", "loc_balcony_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_barrels_generic", "loc_barrels_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_boat_wooden", "loc_boat_wooden");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_car_burning", "loc_car_burning");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_car_generic", "loc_car_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_car_green", "loc_car_green");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_car_overturned", "loc_car_overturned");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_car_yellow", "loc_car_yellow");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_carport_generic", "loc_carport_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_cart_generic", "loc_cart_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_catwalk_generic", "loc_catwalk_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_container_cargo", "loc_container_cargo");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_couch_generic", "loc_couch_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_counter_generic", "loc_counter_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_crates_ammo", "loc_crates_ammo");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_crates_generic", "loc_crates_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_door_back", "loc_door_back");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_door_front", "loc_door_front");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_hull_3rd", "loc_hull_3rd");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_market_stalls", "loc_market_stalls");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_pier_far", "loc_pier_far");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_pier_generic", "loc_pier_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_rock_big", "loc_rock_big");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_rooftop_generic", "loc_rooftop_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_stairs_bottom", "loc_stairs_bottom");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_stairs_generic", "loc_stairs_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_stairs_top", "loc_stairs_top");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_tank_welding", "loc_tank_welding");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_truck_white", "loc_truck_white");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_wall_broken", "loc_wall_broken");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_generic_wall_generic", "loc_wall_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_1st", "callout_loc_1st");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_2nd", "callout_loc_2nd");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_door_1st_left", "callout_loc_door_1st_left");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_door_1st_right", "callout_loc_door_1st_right");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_door_1st", "callout_loc_door_1st");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_door_2nd", "callout_loc_door_2nd");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_door", "callout_loc_door");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_wndw_1st_left", "callout_loc_wndw_1st_left");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_wndw_1st_right", "callout_loc_wndw_1st_right");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_wndw_1st", "callout_loc_wndw_1st");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_wndw_2nd_left", "callout_loc_wndw_2nd_left");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_wndw_2nd_right", "callout_loc_wndw_2nd_right");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_wndw_2nd", "callout_loc_wndw_2nd");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_container_cargo", "loc_container_cargo");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_balcony_generic", "loc_balcony_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_boat_wooden", "loc_boat_wooden");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_tanks_welding", "loc_tanks_welding");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_carport_generic", "loc_carport_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_rock_big", "loc_rock_big");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_wall_broken", "loc_wall_broken");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_bin_trash", "loc_bin_trash");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_fridge_generic", "loc_fridge_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_washing_machine", "loc_washing_machine");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_tire_stack", "loc_tire_stack");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_mattress_generic", "loc_mattress_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_generic_umbrella_generic", "loc_umbrella_generic");
}

vehicles() {}

tibet() {}

ny_manhattan() {
  add_bcs_location_mapping("trigger_multiple_bcs_df_ny_manhattan_lm_memorial_building", "lm_memorial_building");
  add_bcs_location_mapping("trigger_multiple_bcs_df_ny_manhattan_loc_cases_generic", "loc_cases_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_ny_manhattan_loc_cases_left", "loc_cases_left");
  add_bcs_location_mapping("trigger_multiple_bcs_df_ny_manhattan_loc_cases_right", "loc_cases_right");
}

ny_harbor() {
  add_bcs_location_mapping("trigger_multiple_bcs_df_ny_harbor_loc_reactor_generic", "loc_reactor_generic");
}

hijack() {}

warlord() {
  add_bcs_location_mapping("trigger_multiple_bcs_tf_warlord_church_generic", "loc_church_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_warlord_shop_butcher", "loc_shop_butcher");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_warlord_shop_pharmacy", "loc_shop_pharmacy");
}

london() {
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_barrels", "loc_barrels_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_barrier", "loc_barrier_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_bulldozer", "loc_bulldozer_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_vehicle_car_black", "loc_car_black");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_catwalk", "loc_catwalk_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_cinder_blocks", "loc_cinder_blocks");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_container", "loc_container_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_container_open", "loc_container_open");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_container_small", "loc_container_small");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_crate_blue", "loc_crate_blue");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_crate", "loc_crate_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_dumpster_red", "loc_dumpster_red");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_flatbed", "loc_flatbed_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_loading_bay", "loc_loading_bay");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_pipe_cement", "loc_pipe_cement");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_platform_left", "loc_platform_left");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_porta_john", "loc_porta_john");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_scaffolding", "loc_scaffolding_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_stairs_down", "loc_stairs_down");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_stairs", "loc_stairs_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_stairs_top", "loc_stairs_top");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_vehicle_truck_charity", "loc_truck_charity");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_vehicle_truck", "loc_truck_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_vehicle_target", "loc_vehicle_target");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_wall_low", "loc_wall_low");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_warehouse", "loc_warehouse_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_warehouse_south", "loc_warehouse_south");
  add_bcs_location_mapping("trigger_multiple_bcs_uk_landmark_warehouse_west", "loc_warehouse_west");
}

payback() {
  add_bcs_location_mapping("trigger_multiple_bcs_pc_payback_lm_building_tall", "lm_building_tall");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_payback_lm_building_white", "lm_building_white");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_payback_ship_cargo", "loc_ship_cargo");
  add_bcs_location_mapping("trigger_multiple_bcs_pc_payback_shipwreck_generic", "loc_shipwreck_generic");
}

hamburg() {}

paris_a() {}

paris_b() {}

paris_ac130() {
  add_bcs_location_mapping("trigger_multiple_bcs_df_parisAC130_lm_embassy", "lm_embassy");
  add_bcs_location_mapping("trigger_multiple_bcs_df_parisAC130_lm_monument_courtyard", "lm_monument_courtyard");
  add_bcs_location_mapping("trigger_multiple_bcs_df_parisAC130_loc_monument_top", "loc_monument_top");
}

prague() {
  add_bcs_location_mapping("trigger_multiple_bcs_tf_prague_sign_large", "loc_sign_large");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_prague_car_white", "loc_car_white");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_prague_shops_east", "loc_shops_east");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_prague_btr_crashed", "loc_btr_crashed");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_prague_bldg_west", "loc_bldg_west");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_prague_cafe_tables", "loc_cafe_tables");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_prague_bldg_north", "loc_bldg_north");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_prague_antique_shop", "loc_antique_shop");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_prague_pillars", "loc_pillars");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_prague_barricades", "loc_barricades");
}

berlin() {
  add_bcs_location_mapping("trigger_multiple_bcs_df_berlin_lm_kitchen_back", "lm_kitchen_back");
}

rescue() {}

rescue_2() {
  add_bcs_location_mapping("trigger_multiple_bcs_tf_rescue_snowcat_generic", "loc_snowcat_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_rescue_dumptruck_generic", "loc_dumptruck_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_rescue_building_red", "loc_building_red");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_rescue_snowmobile_generic", "loc_snowmobile_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_rescue_scaffolding_generic", "loc_scaffolding_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_rescue_container_red", "loc_container_red");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_rescue_tires_large", "loc_tires_large");
}

dubai() {
  add_bcs_location_mapping("trigger_multiple_bcs_tf_dubai_arch_generic", "loc_arch_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_dubai_bar", "loc_bar");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_dubai_barricades", "loc_barricades");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_dubai_car_generic", "loc_car_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_dubai_chair_generic", "loc_chair_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_dubai_couch_generic", "loc_couch_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_dubai_counter_generic", "loc_counter_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_dubai_doorway", "loc_doorway");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_dubai_escalator_coming_down", "loc_escalator_coming_down");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_dubai_escalator_near_right", "loc_escalator_near_right");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_dubai_escalator_near_left", "loc_escalator_near_left");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_dubai_escalator_top", "loc_escalator_top");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_dubai_fountain_generic", "loc_fountain_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_dubai_lamppost_generic", "loc_lamppost_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_dubai_pillar_generic", "loc_pillar_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_dubai_pillar_left", "loc_pillar_left");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_dubai_pillar_right", "loc_pillar_right");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_dubai_planter_generic", "loc_planter_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_dubai_sedan_generic", "loc_sedan_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_tf_dubai_suv_generic", "loc_suv_generic");
}